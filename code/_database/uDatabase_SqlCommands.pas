unit uDatabase_SqlCommands;

interface

uses
  System.Classes,
  System.SysUtils;

function Get_Query(vRecNum: Integer; vCommand: String): String;
function Get_Run_Query(vQuery, vField: String): String;

function Update_Query(vCommand, vValue: string): String;
function Update_Run_Query(vQuery: String): Boolean;

function Add_New_User: Boolean;

function Is_User_Exists(vUser: string): Boolean;
function Is_Password_Correct_For_User(vUser, vPassword: string): Boolean;

implementation

uses
  loading,
  uload,
  uLoad_AllTypes,
  main,
  uDatabase,
  uDatabase_ActiveUser,
  uLoad_Register;

{ Query GET Command }
function Get_Query(vRecNum: Integer; vCommand: String): String;
var
  vQuery, vField: String;
begin
  if vCommand = 'count_records' then
    vQuery := 'SELECT COUNT(*) as value FROM users'
  else if vCommand = 'username' then
    vQuery := 'SELECT USERNAME as value FROM users WHERE NUM=' + vRecNum.ToString
  else if vCommand = 'password' then
    vQuery := 'SELECT PASSWORD as value FROM users WHERE NUM=' + vRecNum.ToString
  else if vCommand = 'avatar' then
    vQuery := 'SELECT AVATAR as value FROM users WHERE NUM=' + vRecNum.ToString
  else if vCommand = 'name' then
    vQuery := 'SELECT NAME as value FROM users WHERE NUM=' + vRecNum.ToString
  else if vCommand = 'surname' then
    vQuery := 'SELECT SURNAME as value FROM users WHERE NUM=' + vRecNum.ToString
  else if vCommand = 'email' then
    vQuery := 'SELECT EMAIL as value FROM users WHERE NUM=' + vRecNum.ToString
  else if vCommand = 'ip' then
    vQuery := 'SELECT IP as value FROM users WHERE NUM=' + vRecNum.ToString
  else if vCommand = 'registered' then
    vQuery := 'SELECT REGISTERED as value FROM users WHERE NUM=' + vRecNum.ToString
  else if vCommand = 'lastvisit' then
    vQuery := 'SELECT LASTVISIT as value FROM users WHERE NUM=' + vRecNum.ToString
  else if vCommand = 'gender' then
    vQuery := 'SELECT GENDER as value FROM users WHERE NUM=' + vRecNum.ToString;

  vField := 'value';

  Result := Get_Run_Query(vQuery, vField);
end;

function Get_Run_Query(vQuery, vField: String): String;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add(vQuery);
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query.FieldByName(vField).AsString;
  ExtraFE_Query.Close;
end;

{ Query UPDATE Command }
function Update_Query(vCommand, vValue: string): String;
var
  vQuery: String;
begin
  if vCommand = 'name' then
    vQuery := 'UPDATE users SET NAME=''' + vValue + ''' WHERE NUM=' + user_Active_Online.Database_Num.ToString
  else if vCommand = 'surname' then
    vQuery := 'UPDATE users SET SURNAME=''' + vValue + ''' WHERE NUM=' + user_Active_Online.Database_Num.ToString
  else if vCommand = 'gender' then
    vQuery := 'UPDATE users SET GENDER=''' + vValue + ''' WHERE NUM=' + user_Active_Online.Database_Num.ToString
  else if vCommand = 'avatar' then
    vQuery := 'UPDATE users SET AVATAR=' + vValue + ' WHERE NUM=' + user_Active_Online.Database_Num.ToString
  else if vCommand = 'password' then
    vQuery := 'UPDATE users SET PASSWORD=''' + vValue + ''' WHERE NUM=' + user_Active_Online.Database_Num.ToString;

  if Update_Run_Query(vQuery) then
    Result:= vValue;
end;

function Update_Run_Query(vQuery: String): Boolean;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add(vQuery);
  ExtraFE_Query.ExecSQL;
  Result:= True;
end;

///
function Add_New_User: Boolean;
begin
  Result := False;
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.ParamCheck := False;
  ExtraFE_Query.SQL.Add('INSERT INTO users (NUM, ID, USERNAME, PASSWORD, EMAIL, AVATAR, NAME, SURNAME, GENDER, IP, REGISTERED, LASTVISIT) VALUES (''' +
    User_Reg.Database_Num + ''', ''' + User_Reg.Database_Num + ''', ''' + User_Reg.Username + ''', ''' + User_Reg.Password + ''', ''' + User_Reg.Email +
    ''', ''' + User_Reg.Avatar + ''', ''' + User_Reg.Name + ''', ''' + User_Reg.Surname + ''', ''' + User_Reg.Genre + ''', ''' + User_Reg.IP + ''', ''' +
    User_Reg.Registered + ''', ''' + User_Reg.Last_Visit + ''')');
  ExtraFE_Query.ExecSQL;
  Result := True;
end;

function Is_User_Exists(vUser: string): Boolean;
var
  vRows: Integer;
  vCUser: String;
  vCUser_Avatar: String;
  vi: Integer;
begin
  Result := False;
  vRows := -1;
  vRows := Get_Query(-1, 'count_records').ToInteger;
  if vRows <> -1 then
    for vi := 0 to vRows - 1 do
    begin
      vCUser := Get_Query(vi, 'username');
      if vUser = vCUser then
      begin
        Result := True;
        user_Active_Online.Database_Num := vi;
        user_Active_Online.Username := vCUser;
        vCUser_Avatar := Get_Query(vi, 'avatar');
        user_Active_Online.Avatar := vCUser_Avatar;
        ex_load.Login.Avatar.Bitmap.LoadFromFile(ex_main.Paths.Avatar_Images + vCUser_Avatar + '.png');
        Break
      end;
    end;
end;

function Is_Password_Correct_For_User(vUser, vPassword: string): Boolean;
var
  vCPassword: String;
begin
  Result := False;
  vCPassword := Get_Query(user_Active_Online.Database_Num, 'password');
  if vCPassword = vPassword then
  begin
    user_Active_Online.Password := vCPassword;
    Result := True;
  end
end;

end.
