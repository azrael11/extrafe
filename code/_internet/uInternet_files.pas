unit uInternet_files;

interface

uses
  System.Classes,
  System.JSON,
  System.Sysutils,
  FMX.Graphics,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdSSLOpenSSL,
  IdExplicitTLSClientServerBase,
  IdFTP,
  IdSMTP,
  IdMessage,
  IdMessageBuilder,
  IdGlobal,
  REST.Client,
  REST.Types;

const
  HTTP_RESPONSE_OK = 200;

{$M+}
function ValidEmail(email: string): boolean;
function GeoIP(out vCountry_Code: string; out vIP: string; out vLat, vLon: String): boolean;

procedure Create_FTP_Folder(vFolder_Name: String);

function Send_HTML_Email(vEmail, vTheme: String): boolean;
procedure HTML_Registration(vHTMLBuild: TIdMessageBuilderHtml);
procedure HTML_Password_Forgat(vHTMLBuild: TIdMessageBuilderHtml);

function Get_Image(vPath: String): TBitmap;
function GetPage(aURL: string): string;

function Get_JSONValue(vRestName: String; vBaseUrl: String): TJSONValue;

type
  TIdHTTPProgress = class(TIdHTTP)
  private
    FProgress: Integer;
    FBytesToTransfer: Int64;
    FOnChange: TNotifyEvent;
    IOHndl: TIdSSLIOHandlerSocketOpenSSL;
    procedure HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure HTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure HTTPWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure SetProgress(const Value: Integer);
    procedure SetOnChance(const Value: TNotifyEvent);
  public
    Constructor Create(AOwner: TComponent);
    procedure DownloadFile(const aFileUrl: string; const aDestinationFile: String);
  published
    property Progress: Integer read FProgress write SetProgress;
    property BytesToTransfer: Int64 read FBytesToTransfer;
    property OnChange: TNotifyEvent read FOnChange write SetOnChance;
  end;

implementation

uses
  main,
  uLoad_AllTypes,
  uLoad_Register,
  uDatabase_ActiveUser,
  uDatabase_SqlCommands;
{ TIdHTTPProgress }

constructor TIdHTTPProgress.Create(AOwner: TComponent);
begin
  inherited;
  IOHndl := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  Request.BasicAuthentication := True;
  HandleRedirects := True;
  IOHandler := IOHndl;
  ReadTimeout := 30000;
  OnWork := HTTPWork;
  OnWorkBegin := HTTPWorkBegin;
  OnWorkEnd := HTTPWorkEnd;
end;

procedure TIdHTTPProgress.DownloadFile(const aFileUrl: string; const aDestinationFile: String);
var
  LDestStream: TFileStream;
  aPath: String;
begin
  Progress := 0;
  FBytesToTransfer := 0;
  aPath := ExtractFilePath(aDestinationFile);
  if aPath <> '' then
    ForceDirectories(aPath);

  LDestStream := TFileStream.Create(aDestinationFile, fmCreate);
  try
    Get(aFileUrl, LDestStream);
  finally
    FreeAndNil(LDestStream);
  end;
end;

procedure TIdHTTPProgress.HTTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  if BytesToTransfer = 0 then // No Update File
    Exit;

  Progress := Round((AWorkCount / BytesToTransfer) * 100);
end;

procedure TIdHTTPProgress.HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  FBytesToTransfer := AWorkCountMax;
end;

procedure TIdHTTPProgress.HTTPWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
  FBytesToTransfer := 0;
  Progress := 100;
end;

procedure TIdHTTPProgress.SetOnChance(const Value: TNotifyEvent);
begin
  FOnChange := Value;
end;

procedure TIdHTTPProgress.SetProgress(const Value: Integer);
begin
  FProgress := Value;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

function ValidEmail(email: string): boolean;
const
  atom_chars = [#33 .. #255] - ['(', ')', '<', '>', '@', ',', ';', ':', '\', '/', '"', '.', '[', ']', #127];
  quoted_string_chars = [#0 .. #255] - ['"', #13, '\'];
  letters = ['A' .. 'Z', 'a' .. 'z'];
  letters_digits = ['0' .. '9', 'A' .. 'Z', 'a' .. 'z'];
  subdomain_chars = ['-', '0' .. '9', 'A' .. 'Z', 'a' .. 'z'];

type
  States = (STATE_BEGIN, STATE_ATOM, STATE_QTEXT, STATE_QCHAR, STATE_QUOTE, STATE_LOCAL_PERIOD, STATE_EXPECTING_SUBDOMAIN, STATE_SUBDOMAIN, STATE_HYPHEN);

var
  State: States;
  i, n, subdomains: Integer;
  c: char;

begin
  State := STATE_BEGIN;
  n := Length(email);
  i := 1;
  subdomains := 1;

  while (i <= n) do
  begin
    c := email[i];
    case State of
      STATE_BEGIN:
        if c in atom_chars then
          State := STATE_ATOM
        else if c = '"' then
          State := STATE_QTEXT
        else
          break;
      STATE_ATOM:
        if c = '@' then
          State := STATE_EXPECTING_SUBDOMAIN
        else if c = '.' then
          State := STATE_LOCAL_PERIOD
        else if not(c in atom_chars) then
          break;
      STATE_QTEXT:
        if c = '\' then
          State := STATE_QCHAR
        else if c = '"' then
          State := STATE_QUOTE
        else if not(c in quoted_string_chars) then
          break;
      STATE_QCHAR:
        State := STATE_QTEXT;
      STATE_QUOTE:
        if c = '@' then
          State := STATE_EXPECTING_SUBDOMAIN
        else if c = '.' then
          State := STATE_LOCAL_PERIOD
        else
          break;
      STATE_LOCAL_PERIOD:
        if c in atom_chars then
          State := STATE_ATOM
        else if c = '"' then
          State := STATE_QTEXT
        else
          break;
      STATE_EXPECTING_SUBDOMAIN:
        if c in letters then
          State := STATE_SUBDOMAIN
        else
          break;
      STATE_SUBDOMAIN:
        if c = '.' then
        begin
          inc(subdomains);
          State := STATE_EXPECTING_SUBDOMAIN
        end
        else if c = '-' then
          State := STATE_HYPHEN
        else if not(c in letters_digits) then
          break;
      STATE_HYPHEN:
        if c in letters_digits then
          State := STATE_SUBDOMAIN
        else if c <> '-' then
          break;
    end;
    inc(i);
  end;
  if i <= n then
    Result := False
  else
    Result := (State = STATE_SUBDOMAIN) and (subdomains >= 2);
end;

function GeoIP(out vCountry_Code: string; out vIP: string; out vLat, vLon: String): boolean;
var
  vJSONValue: TJSONValue;
  vPosition: String;
  vOutValue: String;
  vIpos: Integer;
begin
  vJSONValue := TJSONValue.Create;
  vJSONValue := Get_JSONValue('IpInfo', 'http://ipinfo.io/json');

  if vJSONValue.TryGetValue('ip', vOutValue) then
  begin
    vIP := vOutValue;
    if vJSONValue.TryGetValue('country', vOutValue) then
      vCountry_Code := vOutValue;
    if vJSONValue.TryGetValue('loc', vOutValue) then
      vPosition := vOutValue;
    if vPosition <> '' then
    begin
      vIpos := Pos(',', vPosition);
      if vIpos <> 0 then
      begin
        vLat := Trim(Copy(vPosition, 0, vIpos - 1));
        vLon := Trim(Copy(vPosition, vIpos + 1, Length(vPosition) - vIpos));
      end;
    end;
  end
  else
    Result := False;
  FreeAndNil(vJSONValue);
end;

procedure Create_FTP_Folder(vFolder_Name: String);
const
  cPath = '/htdocs/users/int_pros/';
var
  vIdFTP: TIdFTP;
begin
  vIdFTP := TIdFTP.Create(ex_load.Scene.Back);
  vIdFTP.Host := 'ftpupload.net';
  vIdFTP.Username := 'epiz_23299538';
  vIdFTP.Password := 'u4fbISfU';
  vIdFTP.Port := 21;

  vIdFTP.Connect;

  vIdFTP.ChangeDir(cPath);
  vIdFTP.MakeDir(vFolder_Name);
  vIdFTP.Disconnect;
end;

procedure HTML_Registration(vHTMLBuild: TIdMessageBuilderHtml);
var
  vBackground: string;
  vLogo: String;
begin
  vBackground := ex_load.Path.Images + 'back.png';
  vLogo := ex_load.Path.Images + 'logo.png';

  vHTMLBuild.HtmlFiles.Add(vBackground, 'back');
  vHTMLBuild.HtmlFiles.Add(vLogo, 'logo');

  vHTMLBuild.Html.Add('<html>');
  vHTMLBuild.Html.Add('<head>');
  vHTMLBuild.Html.Add('<style>body {' + 'background-image: url("cid:back");' + 'background-repeat: repeat;' + 'background-color: #cccccc;' + '}</style>');
  vHTMLBuild.Html.Add('</head>');
  vHTMLBuild.Html.Add('<body>Congratulations on your enrollment in the ExtraFE world.<p>');
  vHTMLBuild.Html.Add('<p><img src="cid:logo" alt="Smiley face" height="260" width="500">');
  vHTMLBuild.Html.Add('<p><b>Username</b> : ' + User_Reg.Username + '<br>');
  vHTMLBuild.Html.Add('<b>Password</b> : ' + User_Reg.Password + '<p>');
  vHTMLBuild.Html.Add
    ('At the moment we sent you the e-mail the possibilities we provide are limited.<br> In the future we will add more and more services and benefits and of course it will be free forever.<p>');
  vHTMLBuild.Html.Add('<b>Homepage</b>      : <a href="http://extrafe.epizy.com">http://extrafe.epizy.com</a><br>');
  vHTMLBuild.Html.Add('<b>Documentation</b> : <a href="http://extrafe.epizy.com/doc/">http://extrafe.epizy.com/doc/</a><br>');
  vHTMLBuild.Html.Add('<b>Forum</b>         : <a href="http://extrafe.epizy.com/smf/">http://extrafe.epizy.com/smf/</a><p>');
  vHTMLBuild.Html.Add('Sincerely, the owner of ExraFE : <b>Nikos Kordas</b> AKA (azrael11).</body>');
  vHTMLBuild.Html.Add('</html>');
  vHTMLBuild.HtmlCharSet := 'utf-8';
  // if you want to add attachments images
  // vHTMLBuild.HtmlFiles.Add(imgfilename, 'load.png');
  // if you want to add unrelated HTML attachment like PDF file as mail attachment //
  // Htmlbuilder.Attachments.Add('c:\filename.pdf');
end;

procedure HTML_Password_Forgat(vHTMLBuild: TIdMessageBuilderHtml);
var
  vBackground: string;
  vLogo: String;
begin
  vBackground := ex_load.Path.Images + 'back.png';
  vLogo := ex_load.Path.Images + 'logo.png';

  vHTMLBuild.HtmlFiles.Add(vBackground, 'back');
  vHTMLBuild.HtmlFiles.Add(vLogo, 'logo');

  vHTMLBuild.Html.Add('<html>');
  vHTMLBuild.Html.Add('<head>');
  vHTMLBuild.Html.Add('<style>');
  vHTMLBuild.Html.Add('<style>body {' + 'background-image: url("cid:back");' + 'background-repeat: repeat;' + 'background-color: #cccccc;' + '}</style>');
  vHTMLBuild.Html.Add('</head>');
  vHTMLBuild.Html.Add('<body> You forgat your password.<p>');
  vHTMLBuild.Html.Add('<p><img src="cid:logo" alt="" height="260" width="500">');
  vHTMLBuild.Html.Add('<p>This email was sent to you because you asked us to enter the password you forgot.<p>');
  vHTMLBuild.Html.Add('<p><b>Username</b> : ' + user_Active.Username + '<br>');
  vHTMLBuild.Html.Add('<b>Password</b> : </b>' + uDatabase_SqlCommands.uDatabase_SQLCommands_Get_Password(user_Active.Database_Num) + '</b><p>');
  vHTMLBuild.Html.Add('If you continue to have trouble accessing the ExtraFE please with your username send e-mail at: spoooky11@hotmail.gr.<p>');
  vHTMLBuild.Html.Add('<b>Homepage</b>      : <a href="http://extrafe.epizy.com">http://extrafe.epizy.com</a><br>');
  vHTMLBuild.Html.Add('<b>Documentation</b> : <a href="http://extrafe.epizy.com/doc/">http://extrafe.epizy.com/doc/</a><br>');
  vHTMLBuild.Html.Add('<b>Forum</b>         : <a href="http://extrafe.epizy.com/smf/">http://extrafe.epizy.com/smf/</a><p>');
  vHTMLBuild.Html.Add('Sincerely, the owner of ExraFE : <b>Nikos Kordas</b> AKA (azrael11).</body>');
  vHTMLBuild.Html.Add('</html>');
  vHTMLBuild.HtmlCharSet := 'utf-8';
end;

function Send_HTML_Email(vEmail, vTheme: String): boolean;
var
  vIdSMTP: TIdSMTP;
  vIdMessage: TIdMessage;
  vIOHandlerSSL: TIdSSLIOHandlerSocketOpenSSL;
  Htmlbuilder: TIdMessageBuilderHtml;
begin
  Result := False;
  vIdSMTP := TIdSMTP.Create(ex_load.Scene.Back);
  vIdMessage := TIdMessage.Create(ex_load.Scene.Back);
  vIOHandlerSSL := TIdSSLIOHandlerSocketOpenSSL.Create(ex_load.Scene.Back);

  with vIOHandlerSSL do
  begin
    Destination := 'smtp-mail.outlook.com:587';
    Host := 'smtp-mail.outlook.com';
    MaxLineAction := maException;
    Port := 587;
    SSLOptions.Method := sslvTLSv1;
    SSLOptions.Mode := sslmUnassigned;
    SSLOptions.VerifyMode := [];
    SSLOptions.VerifyDepth := 0;
  end;

  with vIdSMTP do
  begin
    Host := 'smtp-mail.outlook.com';
    Port := 587;
    Username := 'spoooky11@hotmail.gr';
    Password := '11spoooky';
    IOHandler := vIOHandlerSSL;
    AuthType := satDefault;
    UseTLS := utUseExplicitTLS;
  end;

  try
    Htmlbuilder := TIdMessageBuilderHtml.Create;
    try
      if vTheme = 'register_user' then
        HTML_Registration(Htmlbuilder)
      else if vTheme = 'forgat_password' then
        HTML_Password_Forgat(Htmlbuilder);
      vIdMessage := Htmlbuilder.NewMessage(nil);
      vIdMessage.From.Address := 'spoooky11@hotmail.gr';
      if vTheme = 'register_user' then
        vIdMessage.Subject := 'Thank you for your registration to ExtraFE'
      else if vTheme = 'forgat_password' then
        vIdMessage.Subject := 'ExtraFE, revive forgaten password';
      vIdMessage.Priority := mpHigh;
      with vIdMessage.Recipients.Add do
      begin
        Name := User_Reg.Username;
        Address := vEmail;
      end;

      vIdSMTP.Connect();
      try
        vIdSMTP.Send(vIdMessage);
        Result := True;
      finally
        vIdSMTP.Disconnect();
      end;

    finally
      Htmlbuilder.Free();
    end;

  except
    on E: Exception do
      // ShowMessage('Failed: ' + E.Message);
  end;
end;

function Get_Image(vPath: String): TBitmap;
var
  MS: TMemoryStream;
  vIdHTTP: TIdHTTP;
begin
  MS := TMemoryStream.Create;
  Result := TBitmap.Create;
  vIdHTTP := TIdHTTP.Create(Main_Form);
  try
    vIdHTTP.Get(vPath, MS);
    MS.Seek(0, soFromBeginning);
    Result.LoadFromStream(MS);
  finally
    FreeAndNil(MS);
    FreeAndNil(vIdHTTP);
  end;
end;

function GetPage(aURL: string): string;
var
  Response: TStringStream;
  HTTP: TIdHTTP;
begin
  Result := '';
  Response := TStringStream.Create('');
  try
    HTTP := TIdHTTP.Create(nil);
    try
      HTTP.Get(aURL, Response);
      if HTTP.ResponseCode = HTTP_RESPONSE_OK then
      begin
        Result := Response.DataString;
      end
      else
      begin
        // TODO -cLogging: add some logging
      end;
    finally
      HTTP.Free;
    end;
  finally
    Response.Free;
  end;
end;

function Get_JSONValue(vRestName: String; vBaseUrl: String): TJSONValue;
var
  vRESTClient: TRESTClient;
  vRESTRequest: TRESTRequest;
  vRESTResponse: TRESTResponse;
begin
  Result:= TJSONValue.Create;
  vRESTClient := TRESTClient.Create('');
  vRESTClient.Name := vRestName + '_RestClient';
  vRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
  vRESTClient.BaseURL := vBaseUrl;
  vRESTClient.FallbackCharsetEncoding := 'UTF-8';

  vRESTResponse := TRESTResponse.Create(vRESTClient);
  vRESTResponse.Name := vRestName +'_Response';

  vRESTRequest := TRESTRequest.Create(vRESTClient);
  vRESTRequest.Name := vRestName +'_Request';
  vRESTRequest.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTRequest.AcceptCharset := 'UTF-8, *;q=0.8';
  vRESTRequest.Client := vRESTClient;
  vRESTRequest.Method := TRESTRequestMethod.rmGET;
  vRESTRequest.Response := vRESTResponse;
  vRESTRequest.Timeout := 30000;

  vRESTRequest.Execute;
  Result:= vRESTResponse.JSONValue;

  FreeAndNil(vRESTRequest)
end;

end.
