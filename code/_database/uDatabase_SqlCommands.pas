unit uDatabase_SqlCommands;

interface

uses
  System.Classes,
  System.SysUtils;

function uDatabase_SQLCommands_Count_Records: Integer;
function uDatabase_SQLCommands_Get_UserName(vRecNum: Integer): String;
function uDatabase_SQLCommands_Get_Password(vRecNum: Integer): String;
function uDatabase_SQLCommands_Get_Avatar(vRecNum: Integer): String;
function uDatabase_SQLCommands_Get_RealName(vRecNum: Integer): String;
function uDatabase_SQLCommands_Get_SurName(vRecNum: Integer): String;
function uDatabase_SQLCommands_Get_Email(vRecNum: Integer): String;
function uDatabase_SQLCommands_Get_LastDateVisit(vRecNum: Integer): String;
function uDatabase_SQLCommands_Get_LastTimeVisit(vRecNum: Integer): String;
function uDatabase_SQLCommands_Get_Country(vRecNum: Integer): String;
function uDatabase_SQLCommands_Get_Country_Code(vRecNum: Integer): String;
function uDatabase_SQLCommands_Get_Genre(vRecNum: Integer): String;
function uDatabase_SQLCommands_Get_LastGame(vRecNum: Integer): String;
function uDatabase_SQLCommands_Get_LastEmulator(vRecNum: Integer): String;
function uDatabase_SQLCommands_Get_TimePlay(vRecNum: Integer): String;

function uDatabase_Is_User_Exists(vUser: string): Boolean;
function uDatabase_Is_Password_Correct_For_User(vUser, vPassword: string): Boolean;
procedure uDatabase_Change_Avatar(mNum: Integer);
procedure uDatabase_Change_Password(vPassword: WideString);

function New_User: Boolean;

implementation

uses
  loading,
  uload,
  uLoad_AllTypes,
  main,
  uDatabase,
  uDatabase_ActiveUser,
  uLoad_Register;

function uDatabase_Is_User_Exists(vUser: string): Boolean;
var
  vRows: Integer;
  vCUser: String;
  vCUser_Avatar: String;
  vi: Integer;
begin
  Result := False;
  vRows := -1;
  vRows := uDatabase_SQLCommands_Count_Records;
  if vRows <> -1 then
    for vi := 0 to vRows - 1 do
    begin
      vCUser := uDatabase_SQLCommands_Get_UserName(vi);
      if vUser = vCUser then
      begin
        Result := True;
        user_Active.Database_Num := vi;
        user_Active.Username := vCUser;
        vCUser_Avatar := uDatabase_SQLCommands_Get_Avatar(vi);
        user_Active.Avatar := vCUser_Avatar;
        ex_load.Login.Avatar.Bitmap.LoadFromFile(ex_main.Paths.Avatar_Images + vCUser_Avatar + '.png');
        Break
      end;
    end;
end;

function uDatabase_Is_Password_Correct_For_User(vUser, vPassword: string): Boolean;
var
  vCPassword: String;
begin
  Result := False;
  vCPassword := uDatabase_SQLCommands_Get_Password(user_Active.Database_Num);
  if vCPassword = vPassword then
  begin
    user_Active.Password := vCPassword;
    Result := True;
  end
end;

procedure uDatabase_Change_Avatar(mNum: Integer);
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('UPDATE USER SET AVATAR=' + mNum.ToString + ' WHERE NUM=' +
    user_Active.Database_Num.ToString);
  ExtraFE_Query.ExecSQL;
  user_Active.Avatar := mNum.ToString;
end;

procedure uDatabase_Change_Password(vPassword: WideString);
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('UPDATE USER SET PASSWORD=''' + vPassword + ''' WHERE NUM=' +
    IntToStr(user_Active.Database_Num));
  ExtraFE_Query.ExecSQL;
  user_Active.Password := vPassword;
end;

function uDatabase_SQLCommands_Count_Records: Integer;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('SELECT COUNT(*) as totalrecs FROM USER');
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query.FieldByName('totalrecs').AsInteger;
  ExtraFE_Query.Close;
end;

function uDatabase_SQLCommands_Get_UserName(vRecNum: Integer): String;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('SELECT NICKNAME as username FROM USER WHERE NUM=' + vRecNum.ToString);
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query.FieldByName('username').AsString;
  ExtraFE_Query.Close;
end;

function uDatabase_SQLCommands_Get_Password(vRecNum: Integer): String;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('SELECT PASSWORD as password FROM USER WHERE NUM=' + vRecNum.ToString);
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query.FieldByName('password').AsString;
  ExtraFE_Query.Close;
end;

function uDatabase_SQLCommands_Get_Avatar(vRecNum: Integer): String;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('SELECT AVATAR as avatar FROM USER WHERE NUM=' + vRecNum.ToString);
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query.FieldByName('avatar').AsString;
  ExtraFE_Query.Close;
end;

function uDatabase_SQLCommands_Get_RealName(vRecNum: Integer): String;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('SELECT NAME as realname FROM USER WHERE NUM=' + vRecNum.ToString);
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query.FieldByName('realname').AsString;
  ExtraFE_Query.Close;
end;

function uDatabase_SQLCommands_Get_SurName(vRecNum: Integer): String;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('SELECT SURNAME as surname FROM USER WHERE NUM=' + vRecNum.ToString);
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query.FieldByName('surname').AsString;
  ExtraFE_Query.Close;
end;

function uDatabase_SQLCommands_Get_Email(vRecNum: Integer): String;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('SELECT EMAIL as email FROM USER WHERE NUM=' + vRecNum.ToString);
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query.FieldByName('email').AsString;
  ExtraFE_Query.Close;
end;

function uDatabase_SQLCommands_Get_LastDateVisit(vRecNum: Integer): String;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('SELECT LAST_DATE_VISIT as datevisit FROM USER WHERE NUM=' + vRecNum.ToString);
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query.FieldByName('datevisit').AsString;
  ExtraFE_Query.Close;
end;

function uDatabase_SQLCommands_Get_LastTimeVisit(vRecNum: Integer): String;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('SELECT LAST_TIME_VISIT as timevisit FROM USER WHERE NUM=' + vRecNum.ToString);
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query.FieldByName('timevisit').AsString;
  ExtraFE_Query.Close;
end;

function uDatabase_SQLCommands_Get_Country(vRecNum: Integer): String;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('SELECT COUNTRY as country FROM USER WHERE NUM=' + vRecNum.ToString);
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query.FieldByName('country').AsString;
  ExtraFE_Query.Close;
end;

function uDatabase_SQLCommands_Get_Country_Code(vRecNum: Integer): String;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('SELECT COUNTRY_CODE as code FROM USER WHERE NUM=' + vRecNum.ToString);
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query.FieldByName('code').AsString;
  ExtraFE_Query.Close;
end;

function uDatabase_SQLCommands_Get_Genre(vRecNum: Integer): String;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('SELECT GENRE as genre FROM USER WHERE NUM=' + vRecNum.ToString);
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query.FieldByName('genre').AsString;
  ExtraFE_Query.Close;
end;

function uDatabase_SQLCommands_Get_LastGame(vRecNum: Integer): String;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('SELECT LAST_GAME_PLAY as lastgame FROM USER WHERE NUM=' + vRecNum.ToString);
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query.FieldByName('lastgame').AsString;
  ExtraFE_Query.Close;
end;

function uDatabase_SQLCommands_Get_LastEmulator(vRecNum: Integer): String;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('SELECT LAST_EMULATOR as lastemulator FROM USER WHERE NUM=' + vRecNum.ToString);
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query.FieldByName('lastemulator').AsString;
  ExtraFE_Query.Close;
end;

function uDatabase_SQLCommands_Get_TimePlay(vRecNum: Integer): String;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('SELECT TOTAL_PLAY_TIME as totalplay FROM USER WHERE NUM=' + vRecNum.ToString);
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query.FieldByName('totalplay').AsString;
  ExtraFE_Query.Close;
end;

//
function New_User: Boolean;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.ParamCheck := False;
  ExtraFE_Query.SQL.Add
    ('INSERT INTO USER (NUM, NICKNAME, PASSWORD, EMAIL, IP_ADDRESS, NAME, SURNAME, AVATAR, ' +
    'DATETIME_CREATED, LAST_DATETIME_VISIT, COUNTRY, COUNTRY_CODE, GENRE, LAST_GAME_PLAY, LAST_EMULATOR, ' +
    'TOTAL_PLAY_TIME, SERVER_FOLDER) VALUES (''' + User_Reg.Database_Num + ''', ''' + User_Reg.Username + ''', ''' +
    User_Reg.Password + ''', ''' + User_Reg.Email + ''', ''' + User_Reg.IP + ''', ''' + User_Reg.Name + ''', ''' +
    User_Reg.Surname + ''', ''' + User_Reg.Avatar + ''', ''' + User_Reg.DateTime_Created + ''', ''' +
    User_Reg.DateTime_Created + ''', ''' + User_Reg.Country + ''', ''' + User_Reg.Country_Code + ''', ''' + User_Reg.Genre
    + ''', ''' + User_Reg.Last_Game_Play + ''', ''' + User_Reg.Last_Emulator + ''', ''' + User_Reg.Total_Time_Play + ''', '''
    + User_Reg.Server_Folder + ''')');
  ExtraFE_Query.ExecSQL;
end;

end.
