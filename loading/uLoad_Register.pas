unit uLoad_Register;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  System.JSON,
  System.DateUtils,
  FMX.Types,
  FMX.Objects,
  FMX.Dialogs,
  FMX.Forms,
  FMX.StdCtrls;

type
  TUSER_ACOUNT_DATABASE = record
    Database_Num: String;
    Username: String;
    Password: String;
    Email: String;
    IP: String;
    Name: String;
    Surname: String;
    Avatar: String;
    Registered: string;
    Last_Visit: String;
    Genre: String;
  end;

type
  TUSER_ACCOUNT_REGISTER = record
    User_Empty: Boolean;
    User_Total: Integer;
    User_Num: Boolean;
    User_Symbol: Boolean;
    User_Cap: Boolean;
    Pass_Empty: Boolean;
    Pass_Total: Integer;
    RePass_Empty: Boolean;
    RePass_Match: Boolean;
    Email_Empty: Boolean;
    Email_Correct: Boolean;
    ReEmail_Empty: Boolean;
    ReEmail_Match: Boolean;
    Terms: Boolean;
    Accept_Terms: Boolean;
    Captcha_Empty: Boolean;
    Captcha_Match: Boolean;
    Captcha: WideString;
  end;

procedure Create_Help;
procedure Enable_Help(vHeader: Integer);
procedure Create_Captcha;
procedure Refresh_Captcha;

procedure OK(vTNum: TLabel; vCNum: Integer);
procedure Wrong(vTNum: TLabel; vCNum: Integer);

procedure Update_Username(vValue: String);
procedure Update_Password(vValue: String);
procedure Update_RePassword(vValue: String);
procedure Update_Email(vValue: String);
procedure Update_ReEmail(vValue: String);
procedure Update_ReadTerms;
procedure Update_AcceptTerms(vAccept: Boolean);
procedure Update_Captcha(vValue: String);

procedure Show_Password;
procedure Show_RePassword;

procedure Apply;
procedure Cancel;

function Check_Data: Boolean;
function Register_User: Boolean;

var
  User: TUSER_ACCOUNT_REGISTER;
  User_Reg: TUSER_ACOUNT_DATABASE;
  vCaptcha: String;
  Is_user_registered: Boolean;

implementation

uses
  uLoad_AllTypes,
  ULoad_SetAll,
  uInternet_Files,
  uDatabase_SQLCommands,
  uSnippet_Convert;

procedure Create_Captcha;
var
  vi: Integer;
  Distance: Integer;
  Height: Integer;
  Num: Integer;
  Color: Integer;
begin
  vCaptcha := '';
  for vi := 0 to 5 do
  begin
    Distance := 0;
    ex_load.Reg.Main.Capt_Img_Word[vi] := TText.Create(ex_load.Reg.Main.Capt_Img);
    ex_load.Reg.Main.Capt_Img_Word[vi].Name := 'Loading_Register_Capt_Word_' + vi.ToString;
    ex_load.Reg.Main.Capt_Img_Word[vi].Parent := ex_load.Reg.Main.Capt_Img;
    if vi <> 0 then
      Distance := Random(10);
    Height := -15 + Random(30);
    ex_load.Reg.Main.Capt_Img_Word[vi].SetBounds(10 + ((vi * 30) + Distance), ((ex_load.Reg.Main.Capt_Img.Height / 2) - 12) + Height,
      ex_load.Reg.Main.Capt_Img.Width - 20, 50);
    Color := Random(4);
    case Color of
      0:
        ex_load.Reg.Main.Capt_Img_Word[vi].Color := TAlphaColorRec.White;
      1:
        ex_load.Reg.Main.Capt_Img_Word[vi].Color := TAlphaColorRec.Fuchsia;
      2:
        ex_load.Reg.Main.Capt_Img_Word[vi].Color := TAlphaColorRec.Deepskyblue;
      3:
        ex_load.Reg.Main.Capt_Img_Word[vi].Color := TAlphaColorRec.Springgreen;
    end;
    ex_load.Reg.Main.Capt_Img_Word[vi].Font.Size := 11 + Random(30);
    Num := Random(2);
    if Num = 0 then
      ex_load.Reg.Main.Capt_Img_Word[vi].Text := Chr(ord('A') + Random(26))
    else
      ex_load.Reg.Main.Capt_Img_Word[vi].Text := Chr(ord('a') + Random(26));
    ex_load.Reg.Main.Capt_Img_Word[vi].TextSettings.HorzAlign := TTextAlign.Leading;
    ex_load.Reg.Main.Capt_Img_Word[vi].Visible := True;
    vCaptcha := vCaptcha + UpperCase(ex_load.Reg.Main.Capt_Img_Word[vi].Text);
  end;
end;

procedure Refresh_Captcha;
var
  vi: Integer;
begin
  for vi := 0 to 5 do
    FreeAndNil(ex_load.Reg.Main.Capt_Img_Word[vi]);
  Create_Captcha;
  ex_load.Reg.Main.Capt_Refresh.RotationAngle:= ex_load.Reg.Main.Capt_Refresh.RotationAngle+ 25;
end;

function Check_Data: Boolean;
begin
  if (User.User_Empty = False) and (User.User_Total > 7) and (User.User_Num) and (User.User_Symbol) and (User.User_Cap) and (User.Pass_Empty = False) and
    (User.Pass_Total > 5) and (User.RePass_Empty = False) and (User.RePass_Match) and (User.Email_Empty = False) and (User.Email_Correct) and
    (User.ReEmail_Empty = False) and (User.ReEmail_Match) and (User.Terms) and (User.Accept_Terms) and (User.Captcha_Empty = False) and (User.Captcha_Match)
  then
    Result := True
  else
    Result := False;
end;

function Register_User: Boolean;
var
  vIp: TJSONValue;

  function create_server_folder_name: String;
  var
    vi: Integer;
  begin
    Result := User_Reg.Username + '_';
    for vi := 0 to 7 do
      Result := Result + Random(9).ToString;
  end;

begin
  Result := False;
  Is_user_registered := False;
  if Check_Data then
  begin
    vIp:= uInternet_Files.Get_JSONValue('Register_IP_', 'http://ipinfo.io/json');
    User_Reg.Database_Num := uDatabase_SQLCommands.Get_Query(-1, 'count_records');
    User_Reg.Username := ex_load.Reg.Main.User_V.Text;
    User_Reg.Password := ex_load.Reg.Main.Pass_V.Text;
    User_Reg.Email := ex_load.Reg.Main.Email_V.Text;
    User_Reg.IP := vIP.GetValue<String>('ip');
    User_Reg.Name := '';
    User_Reg.Surname := '';
    User_Reg.Avatar := '0';
    User_Reg.Registered := DateTimeToUnix(Now).ToString;
    User_Reg.Last_Visit := User_Reg.Registered;
    User_Reg.Genre := '0';
    if uDatabase_SQLCommands.Add_New_User then
      uInternet_Files.Send_HTML_Email(User_Reg.Email, 'register_user'); // Ready with no bgcolor
    Is_user_registered := True;
    Result := True;
  end;
end;

procedure Create_Help;
const
  cHeaders: array [0 .. 7] of string = ('Username : ', 'Password :', 'Retype Password :', 'Email :', 'Retype Email :', 'Terms :', 'Accept Terms :',
    'Captcha :');
var
  vi: Integer;
  vCode, vIp, vPosition: String;
begin
  // Create an empty user

  User.User_Empty := True;
  User.User_Total := 0;
  User.User_Num := False;
  User.User_Symbol := False;
  User.User_Cap := False;
  User.Pass_Empty := True;
  User.Pass_Total := 0;
  User.RePass_Empty := True;
  User.RePass_Match := False;
  User.Email_Empty := True;
  User.Email_Correct := False;
  User.ReEmail_Empty := True;
  User.ReEmail_Match := False;
  User.Terms := False;
  User.Accept_Terms := False;
  User.Captcha_Empty := True;
  User.Captcha_Match := False;

  ex_load.Reg.Main.Data.Panel := TCalloutPanel.Create(ex_load.Reg.Panel);
  ex_load.Reg.Main.Data.Panel.Name := 'Loading_Data_Panel';
  ex_load.Reg.Main.Data.Panel.Parent := ex_load.Reg.Panel;
  ex_load.Reg.Main.Data.Panel.SetBounds(-350, 30, 352, ex_load.Reg.Panel.Height - 30);
  ex_load.Reg.Main.Data.Panel.CalloutPosition := TCalloutPosition.Right;
  ex_load.Reg.Main.Data.Panel.CalloutOffset := 30;
  ex_load.Reg.Main.Data.Panel.Visible := True;

  // Username
  ex_load.Reg.Main.Data.Headers[0] := TLabel.Create(ex_load.Reg.Main.Data.Panel);
  ex_load.Reg.Main.Data.Headers[0].Name := 'Data_Header_Username';
  ex_load.Reg.Main.Data.Headers[0].Parent := ex_load.Reg.Main.Data.Panel;
  ex_load.Reg.Main.Data.Headers[0].SetBounds(10, 0, ex_load.Reg.Main.Data.Panel.Width - 20, 20);
  ex_load.Reg.Main.Data.Headers[0].Text := cHeaders[0];
  ex_load.Reg.Main.Data.Headers[0].Visible := True;

  for vi := 0 to 4 do
  begin
    ex_load.Reg.Main.Data.User[vi] := TLabel.Create(ex_load.Reg.Main.Data.Panel);
    ex_load.Reg.Main.Data.User[vi].Name := 'Data_User_' + vi.ToString;
    ex_load.Reg.Main.Data.User[vi].Parent := ex_load.Reg.Main.Data.Panel;
    ex_load.Reg.Main.Data.User[vi].SetBounds(40, 18 + (vi * 18), ex_load.Reg.Main.Data.Panel.Width - 50, 20);
    case vi of
      0:
        ex_load.Reg.Main.Data.User[vi].Text := 'Is Empty';
      1:
        ex_load.Reg.Main.Data.User[vi].Text := 'Is smaller that 8 characters';
      2:
        ex_load.Reg.Main.Data.User[vi].Text := 'Doesn''t contain number';
      3:
        ex_load.Reg.Main.Data.User[vi].Text := 'Doesn''t contain symbol';
      4:
        ex_load.Reg.Main.Data.User[vi].Text := 'Doesn''t contain captial letter';
    end;
    ex_load.Reg.Main.Data.User[vi].FontColor := TAlphaColorRec.Dimgrey;
    ex_load.Reg.Main.Data.User[vi].StyledSettings := ex_load.Reg.Main.Data.User[vi].StyledSettings - [TStyledSetting.FontColor, TStyledSetting.Style];
    ex_load.Reg.Main.Data.User[vi].Visible := True;

    ex_load.Reg.Main.Data.Check[vi] := TCheckBox.Create(ex_load.Reg.Main.Data.Panel);
    ex_load.Reg.Main.Data.Check[vi].Name := 'Data_Check_' + vi.ToString;
    ex_load.Reg.Main.Data.Check[vi].Parent := ex_load.Reg.Main.Data.Panel;
    ex_load.Reg.Main.Data.Check[vi].SetBounds(20, 18 + (vi * 18), 20, 20);
    ex_load.Reg.Main.Data.Check[vi].Enabled := False;
    ex_load.Reg.Main.Data.Check[vi].IsChecked := False;
    ex_load.Reg.Main.Data.Check[vi].Visible := True;
  end;

  // Password
  ex_load.Reg.Main.Data.Headers[1] := TLabel.Create(ex_load.Reg.Main.Data.Panel);
  ex_load.Reg.Main.Data.Headers[1].Name := 'Data_Header_Password';
  ex_load.Reg.Main.Data.Headers[1].Parent := ex_load.Reg.Main.Data.Panel;
  ex_load.Reg.Main.Data.Headers[1].SetBounds(10, 110, ex_load.Reg.Main.Data.Panel.Width - 20, 20);
  ex_load.Reg.Main.Data.Headers[1].Text := cHeaders[1];
  ex_load.Reg.Main.Data.Headers[1].Visible := True;

  for vi := 0 to 1 do
  begin
    ex_load.Reg.Main.Data.Pass[vi] := TLabel.Create(ex_load.Reg.Main.Data.Panel);
    ex_load.Reg.Main.Data.Pass[vi].Name := 'Data_Pass_' + vi.ToString;
    ex_load.Reg.Main.Data.Pass[vi].Parent := ex_load.Reg.Main.Data.Panel;
    ex_load.Reg.Main.Data.Pass[vi].SetBounds(40, 128 + (vi * 18), ex_load.Reg.Main.Data.Panel.Width - 50, 20);
    case vi of
      0:
        ex_load.Reg.Main.Data.Pass[vi].Text := 'Is Empty';
      1:
        ex_load.Reg.Main.Data.Pass[vi].Text := 'Is smaller that 6 characters';
    end;
    ex_load.Reg.Main.Data.Pass[vi].FontColor := TAlphaColorRec.Dimgrey;
    ex_load.Reg.Main.Data.Pass[vi].StyledSettings := ex_load.Reg.Main.Data.Pass[vi].StyledSettings - [TStyledSetting.FontColor, TStyledSetting.Style];
    ex_load.Reg.Main.Data.Pass[vi].Visible := True;

    ex_load.Reg.Main.Data.Check[vi + 5] := TCheckBox.Create(ex_load.Reg.Main.Data.Panel);
    ex_load.Reg.Main.Data.Check[vi + 5].Name := 'Data_Check_' + (vi + 5).ToString;
    ex_load.Reg.Main.Data.Check[vi + 5].Parent := ex_load.Reg.Main.Data.Panel;
    ex_load.Reg.Main.Data.Check[vi + 5].SetBounds(20, 128 + (vi * 18), 20, 20);
    ex_load.Reg.Main.Data.Check[vi + 5].Enabled := False;
    ex_load.Reg.Main.Data.Check[vi + 5].IsChecked := False;
    ex_load.Reg.Main.Data.Check[vi + 5].Visible := True;
  end;

  // Retype Password
  ex_load.Reg.Main.Data.Headers[2] := TLabel.Create(ex_load.Reg.Main.Data.Panel);
  ex_load.Reg.Main.Data.Headers[2].Name := 'Data_Header_Retype_Password';
  ex_load.Reg.Main.Data.Headers[2].Parent := ex_load.Reg.Main.Data.Panel;
  ex_load.Reg.Main.Data.Headers[2].SetBounds(10, 170, ex_load.Reg.Main.Data.Panel.Width - 20, 20);
  ex_load.Reg.Main.Data.Headers[2].Text := cHeaders[2];
  ex_load.Reg.Main.Data.Headers[2].Visible := True;

  for vi := 0 to 1 do
  begin
    ex_load.Reg.Main.Data.RePass[vi] := TLabel.Create(ex_load.Reg.Main.Data.Panel);
    ex_load.Reg.Main.Data.RePass[vi].Name := 'Data_Retype_Pass_' + vi.ToString;
    ex_load.Reg.Main.Data.RePass[vi].Parent := ex_load.Reg.Main.Data.Panel;
    ex_load.Reg.Main.Data.RePass[vi].SetBounds(40, 188 + (vi * 18), ex_load.Reg.Main.Data.Panel.Width - 50, 20);
    case vi of
      0:
        ex_load.Reg.Main.Data.RePass[vi].Text := 'Is Empty';
      1:
        ex_load.Reg.Main.Data.RePass[vi].Text := 'Don''t match';
    end;
    ex_load.Reg.Main.Data.RePass[vi].FontColor := TAlphaColorRec.Dimgrey;
    ex_load.Reg.Main.Data.RePass[vi].StyledSettings := ex_load.Reg.Main.Data.RePass[vi].StyledSettings - [TStyledSetting.FontColor, TStyledSetting.Style];
    ex_load.Reg.Main.Data.RePass[vi].Visible := True;

    ex_load.Reg.Main.Data.Check[vi + 7] := TCheckBox.Create(ex_load.Reg.Main.Data.Panel);
    ex_load.Reg.Main.Data.Check[vi + 7].Name := 'Data_Check_' + (vi + 7).ToString;
    ex_load.Reg.Main.Data.Check[vi + 7].Parent := ex_load.Reg.Main.Data.Panel;
    ex_load.Reg.Main.Data.Check[vi + 7].SetBounds(20, 188 + (vi * 18), 20, 20);
    ex_load.Reg.Main.Data.Check[vi + 7].Enabled := False;
    ex_load.Reg.Main.Data.Check[vi + 7].IsChecked := False;
    ex_load.Reg.Main.Data.Check[vi + 7].Visible := True;
  end;

  // Email
  ex_load.Reg.Main.Data.Headers[3] := TLabel.Create(ex_load.Reg.Main.Data.Panel);
  ex_load.Reg.Main.Data.Headers[3].Name := 'Data_Header_Email';
  ex_load.Reg.Main.Data.Headers[3].Parent := ex_load.Reg.Main.Data.Panel;
  ex_load.Reg.Main.Data.Headers[3].SetBounds(10, 230, ex_load.Reg.Main.Data.Panel.Width - 20, 20);
  ex_load.Reg.Main.Data.Headers[3].Text := cHeaders[3];
  ex_load.Reg.Main.Data.Headers[3].Visible := True;

  for vi := 0 to 1 do
  begin
    ex_load.Reg.Main.Data.Email[vi] := TLabel.Create(ex_load.Reg.Main.Data.Panel);
    ex_load.Reg.Main.Data.Email[vi].Name := 'Data_Eimail_' + vi.ToString;
    ex_load.Reg.Main.Data.Email[vi].Parent := ex_load.Reg.Main.Data.Panel;
    ex_load.Reg.Main.Data.Email[vi].SetBounds(40, 248 + (vi * 18), ex_load.Reg.Main.Data.Panel.Width - 50, 20);
    case vi of
      0:
        ex_load.Reg.Main.Data.Email[vi].Text := 'Is Empty';
      1:
        ex_load.Reg.Main.Data.Email[vi].Text := 'Is not correct';
    end;
    ex_load.Reg.Main.Data.Email[vi].FontColor := TAlphaColorRec.Dimgrey;
    ex_load.Reg.Main.Data.Email[vi].StyledSettings := ex_load.Reg.Main.Data.Email[vi].StyledSettings - [TStyledSetting.FontColor, TStyledSetting.Style];
    ex_load.Reg.Main.Data.Email[vi].Visible := True;

    ex_load.Reg.Main.Data.Check[vi + 9] := TCheckBox.Create(ex_load.Reg.Main.Data.Panel);
    ex_load.Reg.Main.Data.Check[vi + 9].Name := 'Data_Check_' + (vi + 9).ToString;
    ex_load.Reg.Main.Data.Check[vi + 9].Parent := ex_load.Reg.Main.Data.Panel;
    ex_load.Reg.Main.Data.Check[vi + 9].SetBounds(20, 248 + (vi * 18), 20, 20);
    ex_load.Reg.Main.Data.Check[vi + 9].Enabled := False;
    ex_load.Reg.Main.Data.Check[vi + 9].IsChecked := False;
    ex_load.Reg.Main.Data.Check[vi + 9].Visible := True;
  end;

  // Retype Eimail
  ex_load.Reg.Main.Data.Headers[4] := TLabel.Create(ex_load.Reg.Main.Data.Panel);
  ex_load.Reg.Main.Data.Headers[4].Name := 'Data_Header_Retype_Email';
  ex_load.Reg.Main.Data.Headers[4].Parent := ex_load.Reg.Main.Data.Panel;
  ex_load.Reg.Main.Data.Headers[4].SetBounds(10, 290, ex_load.Reg.Main.Data.Panel.Width - 20, 20);
  ex_load.Reg.Main.Data.Headers[4].Text := cHeaders[4];
  ex_load.Reg.Main.Data.Headers[4].Visible := True;

  for vi := 0 to 1 do
  begin
    ex_load.Reg.Main.Data.ReEmail[vi] := TLabel.Create(ex_load.Reg.Main.Data.Panel);
    ex_load.Reg.Main.Data.ReEmail[vi].Name := 'Data_Retype_Eimail_' + vi.ToString;
    ex_load.Reg.Main.Data.ReEmail[vi].Parent := ex_load.Reg.Main.Data.Panel;
    ex_load.Reg.Main.Data.ReEmail[vi].SetBounds(40, 308 + (vi * 18), ex_load.Reg.Main.Data.Panel.Width - 50, 20);
    case vi of
      0:
        ex_load.Reg.Main.Data.ReEmail[vi].Text := 'Is Empty';
      1:
        ex_load.Reg.Main.Data.ReEmail[vi].Text := 'Don''t match';
    end;
    ex_load.Reg.Main.Data.ReEmail[vi].FontColor := TAlphaColorRec.Dimgrey;
    ex_load.Reg.Main.Data.ReEmail[vi].StyledSettings := ex_load.Reg.Main.Data.ReEmail[vi].StyledSettings - [TStyledSetting.FontColor, TStyledSetting.Style];
    ex_load.Reg.Main.Data.ReEmail[vi].Visible := True;

    ex_load.Reg.Main.Data.Check[vi + 11] := TCheckBox.Create(ex_load.Reg.Main.Data.Panel);
    ex_load.Reg.Main.Data.Check[vi + 11].Name := 'Data_Check_' + (vi + 11).ToString;
    ex_load.Reg.Main.Data.Check[vi + 11].Parent := ex_load.Reg.Main.Data.Panel;
    ex_load.Reg.Main.Data.Check[vi + 11].SetBounds(20, 308 + (vi * 18), 20, 20);
    ex_load.Reg.Main.Data.Check[vi + 11].Enabled := False;
    ex_load.Reg.Main.Data.Check[vi + 11].IsChecked := False;
    ex_load.Reg.Main.Data.Check[vi + 11].Visible := True;
  end;

  // Terms
  ex_load.Reg.Main.Data.Headers[5] := TLabel.Create(ex_load.Reg.Main.Data.Panel);
  ex_load.Reg.Main.Data.Headers[5].Name := 'Data_Header_Terms';
  ex_load.Reg.Main.Data.Headers[5].Parent := ex_load.Reg.Main.Data.Panel;
  ex_load.Reg.Main.Data.Headers[5].SetBounds(10, 350, ex_load.Reg.Main.Data.Panel.Width - 20, 20);
  ex_load.Reg.Main.Data.Headers[5].Text := cHeaders[5];
  ex_load.Reg.Main.Data.Headers[5].Visible := True;

  ex_load.Reg.Main.Data.Terms := TLabel.Create(ex_load.Reg.Main.Data.Panel);
  ex_load.Reg.Main.Data.Terms.Name := 'Data_Terms';
  ex_load.Reg.Main.Data.Terms.Parent := ex_load.Reg.Main.Data.Panel;
  ex_load.Reg.Main.Data.Terms.SetBounds(40, 368, ex_load.Reg.Main.Data.Panel.Width - 50, 20);
  ex_load.Reg.Main.Data.Terms.Text := 'Must Read it';
  ex_load.Reg.Main.Data.Terms.FontColor := TAlphaColorRec.Dimgrey;
  ex_load.Reg.Main.Data.Terms.StyledSettings := ex_load.Reg.Main.Data.Terms.StyledSettings - [TStyledSetting.FontColor, TStyledSetting.Style];
  ex_load.Reg.Main.Data.Terms.Visible := True;

  ex_load.Reg.Main.Data.Check[13] := TCheckBox.Create(ex_load.Reg.Main.Data.Panel);
  ex_load.Reg.Main.Data.Check[13].Name := 'Data_Check_' + (13).ToString;
  ex_load.Reg.Main.Data.Check[13].Parent := ex_load.Reg.Main.Data.Panel;
  ex_load.Reg.Main.Data.Check[13].SetBounds(20, 368, 20, 20);
  ex_load.Reg.Main.Data.Check[13].Enabled := False;
  ex_load.Reg.Main.Data.Check[13].IsChecked := False;
  ex_load.Reg.Main.Data.Check[13].Visible := True;

  // Accept Terms
  ex_load.Reg.Main.Data.Headers[6] := TLabel.Create(ex_load.Reg.Main.Data.Panel);
  ex_load.Reg.Main.Data.Headers[6].Name := 'Data_Header_Accept_Terms';
  ex_load.Reg.Main.Data.Headers[6].Parent := ex_load.Reg.Main.Data.Panel;
  ex_load.Reg.Main.Data.Headers[6].SetBounds(10, 390, ex_load.Reg.Main.Data.Panel.Width - 20, 20);
  ex_load.Reg.Main.Data.Headers[6].Text := cHeaders[6];
  ex_load.Reg.Main.Data.Headers[6].Visible := True;

  ex_load.Reg.Main.Data.Accept_Terms := TLabel.Create(ex_load.Reg.Main.Data.Panel);
  ex_load.Reg.Main.Data.Accept_Terms.Name := 'Data_Accept_Terms';
  ex_load.Reg.Main.Data.Accept_Terms.Parent := ex_load.Reg.Main.Data.Panel;
  ex_load.Reg.Main.Data.Accept_Terms.SetBounds(40, 408, ex_load.Reg.Main.Data.Panel.Width - 50, 20);
  ex_load.Reg.Main.Data.Accept_Terms.Text := 'Must Accept it';
  ex_load.Reg.Main.Data.Accept_Terms.FontColor := TAlphaColorRec.Dimgrey;
  ex_load.Reg.Main.Data.Accept_Terms.StyledSettings := ex_load.Reg.Main.Data.Accept_Terms.StyledSettings - [TStyledSetting.FontColor, TStyledSetting.Style];
  ex_load.Reg.Main.Data.Accept_Terms.Visible := True;

  ex_load.Reg.Main.Data.Check[14] := TCheckBox.Create(ex_load.Reg.Main.Data.Panel);
  ex_load.Reg.Main.Data.Check[14].Name := 'Data_Check_' + (14).ToString;
  ex_load.Reg.Main.Data.Check[14].Parent := ex_load.Reg.Main.Data.Panel;
  ex_load.Reg.Main.Data.Check[14].SetBounds(20, 408, 20, 20);
  ex_load.Reg.Main.Data.Check[14].Enabled := False;
  ex_load.Reg.Main.Data.Check[14].IsChecked := False;
  ex_load.Reg.Main.Data.Check[14].Visible := True;

  // Captcha
  ex_load.Reg.Main.Data.Headers[7] := TLabel.Create(ex_load.Reg.Main.Data.Panel);
  ex_load.Reg.Main.Data.Headers[7].Name := 'Data_Header_Captcha';
  ex_load.Reg.Main.Data.Headers[7].Parent := ex_load.Reg.Main.Data.Panel;
  ex_load.Reg.Main.Data.Headers[7].SetBounds(10, 430, ex_load.Reg.Main.Data.Panel.Width - 20, 20);
  ex_load.Reg.Main.Data.Headers[7].Text := cHeaders[7];
  ex_load.Reg.Main.Data.Headers[7].Visible := True;

  for vi := 0 to 1 do
  begin
    ex_load.Reg.Main.Data.Captcha[vi] := TLabel.Create(ex_load.Reg.Main.Data.Panel);
    ex_load.Reg.Main.Data.Captcha[vi].Name := 'Data_Retype_Captcha_' + vi.ToString;
    ex_load.Reg.Main.Data.Captcha[vi].Parent := ex_load.Reg.Main.Data.Panel;
    ex_load.Reg.Main.Data.Captcha[vi].SetBounds(40, 448 + (vi * 18), ex_load.Reg.Main.Data.Panel.Width - 50, 20);
    case vi of
      0:
        ex_load.Reg.Main.Data.Captcha[vi].Text := 'Is Empty';
      1:
        ex_load.Reg.Main.Data.Captcha[vi].Text := 'Don''t match';
    end;
    ex_load.Reg.Main.Data.Captcha[vi].FontColor := TAlphaColorRec.Dimgrey;
    ex_load.Reg.Main.Data.Captcha[vi].StyledSettings := ex_load.Reg.Main.Data.Captcha[vi].StyledSettings - [TStyledSetting.FontColor, TStyledSetting.Style];
    ex_load.Reg.Main.Data.Captcha[vi].Visible := True;

    ex_load.Reg.Main.Data.Check[vi + 15] := TCheckBox.Create(ex_load.Reg.Main.Data.Panel);
    ex_load.Reg.Main.Data.Check[vi + 15].Name := 'Data_Check_' + (vi + 15).ToString;
    ex_load.Reg.Main.Data.Check[vi + 15].Parent := ex_load.Reg.Main.Data.Panel;
    ex_load.Reg.Main.Data.Check[vi + 15].SetBounds(20, 448 + (vi * 18), 20, 20);
    ex_load.Reg.Main.Data.Check[vi + 15].Enabled := False;
    ex_load.Reg.Main.Data.Check[vi + 15].IsChecked := False;
    ex_load.Reg.Main.Data.Check[vi + 15].Visible := True;
  end;
end;

procedure Enable_Help(vHeader: Integer);
var
  vi: Integer;
begin
  for vi := 0 to 4 do
    ex_load.Reg.Main.Data.User[vi].FontColor := TAlphaColorRec.Dimgrey;
  for vi := 0 to 1 do
    ex_load.Reg.Main.Data.Pass[vi].FontColor := TAlphaColorRec.Dimgrey;
  for vi := 0 to 1 do
    ex_load.Reg.Main.Data.RePass[vi].FontColor := TAlphaColorRec.Dimgrey;
  for vi := 0 to 1 do
    ex_load.Reg.Main.Data.Email[vi].FontColor := TAlphaColorRec.Dimgrey;
  for vi := 0 to 1 do
    ex_load.Reg.Main.Data.ReEmail[vi].FontColor := TAlphaColorRec.Dimgrey;
  ex_load.Reg.Main.Data.Terms.FontColor := TAlphaColorRec.Dimgrey;
  ex_load.Reg.Main.Data.Accept_Terms.FontColor := TAlphaColorRec.Dimgrey;
  for vi := 0 to 1 do
    ex_load.Reg.Main.Data.Captcha[vi].FontColor := TAlphaColorRec.Dimgrey;

  case vHeader of
    0:
      begin
        ex_load.Reg.Edit_Select := 'username';
        for vi := 0 to 4 do
        begin
          ex_load.Reg.Main.Data.User[vi].FontColor := TAlphaColorRec.White;
          case vi of
            0:
              begin
                if User.User_Empty = False then
                  ex_load.Reg.Main.Data.User[vi].FontColor := TAlphaColorRec.Lime;
              end;
            1:
              begin
                if User.User_Total > 7 then
                  ex_load.Reg.Main.Data.User[vi].FontColor := TAlphaColorRec.Lime;
              end;
            2:
              begin
                if User.User_Num then
                  ex_load.Reg.Main.Data.User[vi].FontColor := TAlphaColorRec.Lime;
              end;
            3:
              begin
                if User.User_Symbol then
                  ex_load.Reg.Main.Data.User[vi].FontColor := TAlphaColorRec.Lime;
              end;
            4:
              begin
                if User.User_Cap then
                  ex_load.Reg.Main.Data.User[vi].FontColor := TAlphaColorRec.Lime;
              end;
          end;
        end;
        ex_load.Reg.Main.Data.Panel.CalloutOffset := 30;
      end;
    1:
      begin
        ex_load.Reg.Edit_Select := 'password';
        for vi := 0 to 1 do
        begin
          ex_load.Reg.Main.Data.Pass[vi].FontColor := TAlphaColorRec.White;
          case vi of
            0:
              begin
                if User.Pass_Empty = False then
                  ex_load.Reg.Main.Data.Pass[vi].FontColor := TAlphaColorRec.Lime;
              end;
            1:
              begin
                if User.Pass_Total > 5 then
                  ex_load.Reg.Main.Data.Pass[vi].FontColor := TAlphaColorRec.Lime;
              end;
          end;
        end;
        ex_load.Reg.Main.Data.Panel.CalloutOffset := 75;
      end;
    2:
      begin
        ex_load.Reg.Edit_Select := 'repassword';
        for vi := 0 to 1 do
        begin
          ex_load.Reg.Main.Data.RePass[vi].FontColor := TAlphaColorRec.White;
          case vi of
            0:
              begin
                if User.RePass_Empty = False then
                  ex_load.Reg.Main.Data.RePass[vi].FontColor := TAlphaColorRec.Lime;
              end;
            1:
              begin
                if User.RePass_Match then
                  ex_load.Reg.Main.Data.RePass[vi].FontColor := TAlphaColorRec.Lime;
              end;
          end;
        end;
        ex_load.Reg.Main.Data.Panel.CalloutOffset := 120;
      end;
    3:
      begin
        ex_load.Reg.Edit_Select := 'email';
        for vi := 0 to 1 do
        begin
          ex_load.Reg.Main.Data.Email[vi].FontColor := TAlphaColorRec.White;
          case vi of
            0:
              begin
                if User.Email_Empty = False then
                  ex_load.Reg.Main.Data.Email[vi].FontColor := TAlphaColorRec.Lime;
              end;
            1:
              begin
                if User.Email_Correct then
                  ex_load.Reg.Main.Data.Email[vi].FontColor := TAlphaColorRec.Lime;
              end;
          end;
        end;
        ex_load.Reg.Main.Data.Panel.CalloutOffset := 165;
      end;
    4:
      begin
        ex_load.Reg.Edit_Select := 'reemail';
        for vi := 0 to 1 do
        begin
          ex_load.Reg.Main.Data.ReEmail[vi].FontColor := TAlphaColorRec.White;
          case vi of
            0:
              begin
                if User.ReEmail_Empty = False then
                  ex_load.Reg.Main.Data.ReEmail[vi].FontColor := TAlphaColorRec.Lime;
              end;
            1:
              begin
                if User.ReEmail_Match then
                  ex_load.Reg.Main.Data.ReEmail[vi].FontColor := TAlphaColorRec.Lime;
              end;
          end;
        end;
        ex_load.Reg.Main.Data.Panel.CalloutOffset := 210;
      end;
    5:
      begin
        if User.Terms then
          ex_load.Reg.Main.Data.Terms.FontColor := TAlphaColorRec.Lime
        else
          ex_load.Reg.Main.Data.Terms.FontColor := TAlphaColorRec.White;
        ex_load.Reg.Main.Data.Panel.CalloutOffset := 290;
      end;
    6:
      begin
        if User.Accept_Terms then
          ex_load.Reg.Main.Data.Accept_Terms.FontColor := TAlphaColorRec.Lime
        else
          ex_load.Reg.Main.Data.Accept_Terms.FontColor := TAlphaColorRec.White;
        ex_load.Reg.Main.Data.Panel.CalloutOffset := 320;
      end;
    7:
      begin
        ex_load.Reg.Edit_Select := 'captcha';
        for vi := 0 to 1 do
        begin
          ex_load.Reg.Main.Data.Captcha[vi].FontColor := TAlphaColorRec.White;
          case vi of
            0:
              begin
                if User.Captcha_Empty = False then
                  ex_load.Reg.Main.Data.Captcha[0].FontColor := TAlphaColorRec.Lime;
              end;
            1:
              begin
                if User.Captcha_Match then
                  ex_load.Reg.Main.Data.Captcha[0].FontColor := TAlphaColorRec.Lime;
              end;
          end;
        end;
        ex_load.Reg.Main.Data.Panel.CalloutOffset := 410;
      end;
  end;
end;

procedure OK(vTNum: TLabel; vCNum: Integer);
begin
  vTNum.FontColor := TAlphaColorRec.Lime;
  vTNum.Font.Style := vTNum.Font.Style + [TFontStyle.fsStrikeOut];
  ex_load.Reg.Main.Data.Check[vCNum].IsChecked := True;
end;

procedure Wrong(vTNum: TLabel; vCNum: Integer);
begin
  vTNum.FontColor := TAlphaColorRec.White;
  vTNum.Font.Style := vTNum.Font.Style - [TFontStyle.fsStrikeOut];
  ex_load.Reg.Main.Data.Check[vCNum].IsChecked := False;
end;

procedure Update_Username(vValue: String);
const
  cNumbers = ['0' .. '9'];
  cSymbols = ['!', '@', '#', '%', '^', '&', '*', '(', ')', '-', '_', '+', '=', '{', '}', '[', ']', ':', ';', '"', '|', '\', '/'];
  cCapitals = ['A' .. 'Z'];
var
  vi: Integer;
begin
  if vValue <> '' then
  begin
    OK(ex_load.Reg.Main.Data.User[0], 0);
    User.User_Empty := False;
  end
  else
  begin
    Wrong(ex_load.Reg.Main.Data.User[0], 0);
    User.User_Empty := True;
  end;

  if Length(vValue) > 7 then
  begin
    OK(ex_load.Reg.Main.Data.User[1], 1);
    User.User_Total := Length(vValue);
  end
  else
  begin
    Wrong(ex_load.Reg.Main.Data.User[1], 1);
    User.User_Total := Length(vValue);
  end;

  for vi := 1 to Length(vValue) do
  begin
    if vValue[vi] in cNumbers then
    begin
      OK(ex_load.Reg.Main.Data.User[2], 2);
      User.User_Num := True;
      Break
    end
    else
    begin
      Wrong(ex_load.Reg.Main.Data.User[2], 2);
      User.User_Num := False;
    end;
  end;

  for vi := 1 to Length(vValue) do
  begin
    if vValue[vi] in cSymbols then
    begin
      OK(ex_load.Reg.Main.Data.User[3], 3);
      User.User_Symbol := True;
      Break
    end
    else
    begin
      Wrong(ex_load.Reg.Main.Data.User[3], 3);
      User.User_Symbol := False;
    end;
  end;

  for vi := 1 to Length(vValue) do
  begin
    if vValue[vi] in cCapitals then
    begin
      OK(ex_load.Reg.Main.Data.User[4], 4);
      User.User_Cap := True;
      Break
    end
    else
    begin
      Wrong(ex_load.Reg.Main.Data.User[4], 4);
      User.User_Cap := False;
    end;
  end;
end;

procedure Update_Password(vValue: String);
begin
  if vValue <> '' then
  begin
    OK(ex_load.Reg.Main.Data.Pass[0], 5);
    User.Pass_Empty := False;
  end
  else
  begin
    Wrong(ex_load.Reg.Main.Data.Pass[0], 5);
    User.Pass_Empty := True;
  end;

  if Length(vValue) > 5 then
  begin
    OK(ex_load.Reg.Main.Data.Pass[1], 6);
    User.Pass_Total := Length(vValue);
  end
  else
  begin
    Wrong(ex_load.Reg.Main.Data.Pass[1], 6);
    User.Pass_Total := Length(vValue);
  end;
end;

procedure Update_RePassword(vValue: String);
begin
  if vValue <> '' then
  begin
    OK(ex_load.Reg.Main.Data.RePass[0], 7);
    User.RePass_Empty := False;
  end
  else
  begin
    Wrong(ex_load.Reg.Main.Data.RePass[0], 7);
    User.RePass_Empty := True;
  end;

  if (vValue = ex_load.Reg.Main.Pass_V.Text) and (Length(vValue) > 5) then
  begin
    OK(ex_load.Reg.Main.Data.RePass[1], 8);
    User.RePass_Match := True;
  end
  else
  begin
    Wrong(ex_load.Reg.Main.Data.RePass[1], 8);
    User.RePass_Match := False;
  end;
end;

procedure Update_Email(vValue: String);
begin
  if vValue <> '' then
  begin
    OK(ex_load.Reg.Main.Data.Email[0], 9);
    User.Email_Empty := False;
  end
  else
  begin
    Wrong(ex_load.Reg.Main.Data.Email[0], 9);
    User.Email_Empty := True;
  end;

  if uInternet_Files.ValidEmail(vValue) then
  begin
    OK(ex_load.Reg.Main.Data.Email[1], 10);
    User.Email_Correct := True;
  end
  else
  begin
    Wrong(ex_load.Reg.Main.Data.Email[1], 10);
    User.Email_Correct := False;
  end;
end;

procedure Update_ReEmail(vValue: String);
begin
  if vValue <> '' then
  begin
    OK(ex_load.Reg.Main.Data.ReEmail[0], 11);
    User.ReEmail_Empty := False;
  end
  else
  begin
    Wrong(ex_load.Reg.Main.Data.ReEmail[0], 11);
    User.ReEmail_Empty := True;
  end;

  if (vValue = ex_load.Reg.Main.Email_V.Text) and (vValue <> '') then
  begin
    OK(ex_load.Reg.Main.Data.ReEmail[1], 12);
    User.ReEmail_Match := True;
  end
  else
  begin
    Wrong(ex_load.Reg.Main.Data.ReEmail[1], 12);
    User.ReEmail_Match := True;
  end;

end;

procedure Update_ReadTerms;
begin
  OK(ex_load.Reg.Main.Data.Terms, 13);
  User.Terms := True;
end;

procedure Update_AcceptTerms(vAccept: Boolean);
begin
  if vAccept then
    OK(ex_load.Reg.Main.Data.Accept_Terms, 14)
  else
    Wrong(ex_load.Reg.Main.Data.Accept_Terms, 14);
  User.Accept_Terms := vAccept;
end;

procedure Update_Captcha(vValue: String);
begin
  if vValue <> '' then
  begin
    OK(ex_load.Reg.Main.Data.Captcha[0], 15);
    User.Captcha_Empty := False;
  end
  else
  begin
    Wrong(ex_load.Reg.Main.Data.Captcha[0], 15);
    User.Captcha_Empty := True;
  end;

  if UpperCase(vValue) = vCaptcha then
  begin
    OK(ex_load.Reg.Main.Data.Captcha[1], 16);
    User.Captcha_Match := True;
  end
  else
  begin
    Wrong(ex_load.Reg.Main.Data.Captcha[1], 16);
    User.Captcha_Match := False;
  end;
end;

procedure Show_Password;
begin
  if ex_load.Reg.Main.Pass_V.Password then
  begin
    ex_load.Reg.Main.Pass_Show.Text := #$e9ce;
    ex_load.Reg.Main.Pass_Show.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  end
  else
  begin
    ex_load.Reg.Main.Pass_Show.Text := #$e9d1;
    ex_load.Reg.Main.Pass_Show.TextSettings.FontColor := TAlphaColorRec.Blueviolet;
  end;
  ex_load.Reg.Main.Pass_V.Password := not ex_load.Reg.Main.Pass_V.Password;
end;

procedure Show_RePassword;
begin
  if ex_load.Reg.Main.RePass_V.Password then
  begin
    ex_load.Reg.Main.RePass_Show.Text := #$e9ce;
    ex_load.Reg.Main.RePass_Show.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  end
  else
  begin
    ex_load.Reg.Main.RePass_Show.Text := #$e9d1;
    ex_load.Reg.Main.RePass_Show.TextSettings.FontColor := TAlphaColorRec.Blueviolet;
  end;
  ex_load.Reg.Main.RePass_V.Password := not ex_load.Reg.Main.RePass_V.Password;
end;

{The two action buttons}
procedure Apply;
begin
  if Register_User then
    Cancel;
end;

procedure Cancel;
begin
  uLoad_SetAll_Login;
  if Is_user_registered then
  begin
    ex_load.Login.User_V.Text := User_Reg.Username;
    ex_load.Login.Pass_V.Text := '';
  end;
  FreeAndNil(ex_load.Reg.Panel);
end;

end.
