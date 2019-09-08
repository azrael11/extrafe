unit uDatabase_SqlCommands;

interface

uses
  System.Classes,
  System.SysUtils;

{ Commands for Local Database }
function Get_Local_Query_USERS(vRecNum: Integer; vCommand: String): String;
function Get_Local_Query_EMULATORS(vRecNum: Integer; vCommand: String): String;
function Get_Local_Run_Query(vQuery, vField: String): String;

procedure Update_Local_Query(vTable_Name, vCol, vValue, vUser_Num: string);
function Update_Local_Run_Query(vQuery: String): Boolean;

{ Commands for Online Database }
function Get_Query(vRecNum: Integer; vCommand: String): String;
function Get_Run_Query(vQuery, vField: String): String;

function Update_Query(vCommand, vValue: string): String;
function Update_Run_Query(vQuery: String): Boolean;

{ Register }
{ OnLine Database }
function Add_New_User: Boolean;
{ Local Database }
function Add_User_Local: Boolean;

{ Functions for OnLine Database }
function Is_User_Exists(vUser: string): Boolean;
function Is_Password_Correct_For_User(vUser, vPassword: string): Boolean;

var
  vQuery, vField: String;

implementation

uses
  loading,
  uload,
  uLoad_AllTypes,
  main,
  uDatabase,
  uDatabase_ActiveUser,
  uLoad_Register;

{ Commands for Local Database }
{ Query GET Command }
function Get_Local_Query_USERS(vRecNum: Integer; vCommand: String): String;
begin
  if vCommand = 'id' then
    vQuery := 'SELECT ID_UNIQUE FROM users WHERE ID=' + vRecNum.ToString
  else if vCommand = 'username' then
    vQuery := 'SELECT USERNAME FROM users WHERE ID=' + vRecNum.ToString
  else if vCommand = 'password_local' then
    vQuery := 'SELECT PASSWORD_LOCAL FROM users WHERE ID=' + vRecNum.ToString
  else if vCommand = 'email' then
    vQuery := 'SELECT EMAIL FROM users WHERE ID=' + vRecNum.ToString
  else if vCommand = 'avatar' then
    vQuery := 'SELECT AVATAR FROM users WHERE ID=' + vRecNum.ToString
  else if vCommand = 'name' then
    vQuery := 'SELECT NAME FROM users WHERE ID=' + vRecNum.ToString
  else if vCommand = 'surname' then
    vQuery := 'SELECT SURNAME FROM users WHERE ID=' + vRecNum.ToString
  else if vCommand = 'gender' then
    vQuery := 'SELECT GENDER FROM users WHERE ID=' + vRecNum.ToString
  else if vCommand = 'ip' then
    vQuery := 'SELECT IP FROM users WHERE ID=' + vRecNum.ToString
  else if vCommand = 'country' then
    vQuery := 'SELECT COUNTRY FROM users WHERE ID=' + vRecNum.ToString
  else if vCommand = 'registered' then
    vQuery := 'SELECT REGISTERED FROM users WHERE ID=' + vRecNum.ToString
  else if vCommand = 'last_visit_online' then
    vQuery := 'SELECT LAST_VISIT_ONLINE FROM users WHERE ID=' + vRecNum.ToString
  else if vCommand = 'last_visit' then
    vQuery := 'SELECT LAST_VISIT FROM users WHERE ID=' + vRecNum.ToString
  else if vCommand = 'active_online' then
    vQuery := 'SELECT ACTIVE_ONLINE FROM users WHERE ID=' + vRecNum.ToString;

  vField := vCommand;
  Result := Get_Local_Run_Query(vQuery, vField);
end;

function Get_Local_Query_EMULATORS(vRecNum: Integer; vCommand: String): String;
begin
  if vCommand = 'count' then
    vQuery := 'SELECT COUNT FROM emulators WHERE ID=' + vRecNum.ToString;
  // else if vCommand = ' then

  Result := Get_Local_Run_Query(vQuery, vField);
end;

function Get_Local_Run_Query(vQuery, vField: String): String;
begin
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Add(vQuery);
  ExtraFE_Query_Local.Open;
  ExtraFE_Query_Local.First;
  Result := ExtraFE_Query_Local.FieldByName(vField).AsString;
  ExtraFE_Query_Local.Close;
end;

{ Query UPDATE Command }
procedure Update_Local_Query(vTable_Name, vCol, vValue, vUser_Num: string);
begin
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Add('UPDATE ' + vTable_Name + ' SET ' + vCol + '=''' + vValue + ''' WHERE USER_ID=' + vUser_Num);
  ExtraFE_Query_Local.ExecSQL;
end;

function Update_Local_Run_Query(vQuery: String): Boolean;
begin

end;

/// ////////////////////////////////////////////////////////////////////////////////////

{ Commands for Online Database }
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
  else if vCommand = 'country' then
    vQuery := 'SELECT COUNTRY as value FROM users WHERE NUM=' + vRecNum.ToString
  else if vCommand = 'registered' then
    vQuery := 'SELECT REGISTERED as value FROM users WHERE NUM=' + vRecNum.ToString
  else if vCommand = 'lastvisit' then
    vQuery := 'SELECT LASTVISIT as value FROM users WHERE NUM=' + vRecNum.ToString
  else if vCommand = 'gender' then
    vQuery := 'SELECT GENDER as value FROM users WHERE NUM=' + vRecNum.ToString
  else if vCommand = 'active' then
    vQuery := 'SELECT ACTIVE as value FROM users WHERE NUM=' + vRecNum.ToString;

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
    vQuery := 'UPDATE users SET NAME=''' + vValue + ''' WHERE NUM=' + user_Active_Online.Num.ToString
  else if vCommand = 'surname' then
    vQuery := 'UPDATE users SET SURNAME=''' + vValue + ''' WHERE NUM=' + user_Active_Online.Num.ToString
  else if vCommand = 'gender' then
    vQuery := 'UPDATE users SET GENDER=''' + vValue + ''' WHERE NUM=' + user_Active_Online.Num.ToString
  else if vCommand = 'avatar' then
    vQuery := 'UPDATE users SET AVATAR=' + vValue + ' WHERE NUM=' + user_Active_Online.Num.ToString
  else if vCommand = 'password' then
    vQuery := 'UPDATE users SET PASSWORD=''' + vValue + ''' WHERE NUM=' + user_Active_Online.Num.ToString
  else if vCommand = 'active' then
    vQuery := 'UPDATE users SET ACTIVE=''' + vValue + ''' WHERE NUM=' + user_Active_Online.Num.ToString
  else if vCommand = 'lastvisit' then
    vQuery := 'UPDATE users SET LASTVISIT=''' + vValue + ''' WHERE NUM=' + user_Active_Online.Num.ToString
  else if vCommand = 'ip' then
    vQuery := 'UPDATE users SET IP=''' + vValue + ''' WHERE NUM=' + user_Active_Online.Num.ToString;

  if Update_Run_Query(vQuery) then
    Result := vValue;
end;

function Update_Run_Query(vQuery: String): Boolean;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add(vQuery);
  ExtraFE_Query.ExecSQL;
  Result := True;
end;

/// ///////////////////////////////////////////////////////////////////////////////////
function Add_New_User: Boolean;
begin
  Result := False;
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.ParamCheck := False;
  ExtraFE_Query.SQL.Add('INSERT INTO users (NUM, ID, USERNAME, PASSWORD, EMAIL, AVATAR, NAME, SURNAME, GENDER, IP, COUNTRY, REGISTERED, LASTVISIT) VALUES (''' +
    User_Reg.Database_Num + ''', ''' + User_Reg.Database_Num + ''', ''' + User_Reg.Username + ''', ''' + User_Reg.Password + ''', ''' + User_Reg.Email +
    ''', ''' + User_Reg.Avatar + ''', ''' + User_Reg.Name + ''', ''' + User_Reg.Surname + ''', ''' + User_Reg.Genre + ''', ''' + User_Reg.IP + ''', ''' +
    User_Reg.Country + ''',''' + User_Reg.Registered + ''', ''' + User_Reg.Last_Visit + ''')');
  ExtraFE_Query.ExecSQL;
  Result := True;
end;

function Add_User_Local: Boolean;
var
  vPath: array [0 .. 40] of string;
  procedure free_vpath;
  var
    vi: Integer;
  begin
    for vi := 0 to 40 do
      vPath[vi]:= '';
  end;
begin
  Result := False;

  { User data }
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Add
    (' INSERT INTO USERS (ID, ID_UNIQUE, USERNAME, PASSWORD_LOCAL, EMAIL, AVATAR, NAME, SURNAME, GENDER, IP, COUNTRY, REGISTERED, LAST_VISIT_ONLINE, LAST_VISIT, ACTIVE_ONLINE) VALUES ('''
    + User_Reg.Database_Num + ''', ''' + User_Reg.Database_Num + ''', ''' + User_Reg.Username + ''', ''' + User_Reg.Password + ''', ''' + User_Reg.Email +
    ''', ''' + User_Reg.Avatar + ''', ''' + User_Reg.Name + ''', ''' + User_Reg.Surname + ''', ''' + User_Reg.Genre + ''', ''' + User_Reg.IP + ''', ''' +
    User_Reg.Country + ''', ''' + User_Reg.Registered + ''', ''' + User_Reg.Last_Visit + ''', ''' + User_Reg.Last_Visit + ''', ''1'')');
  ExtraFE_Query_Local.ExecSQL;

  { User Statistics data }
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Add(' INSERT INTO USERS_STATISTICS ("USER_ID") VALUES (' + User_Reg.Database_Num + ')');
  ExtraFE_Query_Local.ExecSQL;

  { Emulation data }
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Add(' INSERT INTO EMULATORS ("USER_ID") VALUES (' + User_Reg.Database_Num + ')');
  ExtraFE_Query_Local.ExecSQL;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Add(' INSERT INTO ARCADE ("USER_ID") VALUES (' + User_Reg.Database_Num + ')');
  ExtraFE_Query_Local.ExecSQL;

  { Arcade Section Start }
  { Media }
  free_vpath;
  vPath[0] := extrafe.prog.Path + 'emu\arcade\media\artworks';
  vPath[1] := extrafe.prog.Path + 'emu\arcade\media\cabinets';
  vPath[2] := extrafe.prog.Path + 'emu\arcade\media\control_panels';
  vPath[3] := extrafe.prog.Path + 'emu\arcade\media\covers';
  vPath[4] := extrafe.prog.Path + 'emu\arcade\media\flyers';
  vPath[5] := extrafe.prog.Path + 'emu\arcade\media\fanart';
  vPath[6] := extrafe.prog.Path + 'emu\arcade\media\game_over';
  vPath[7] := extrafe.prog.Path + 'emu\arcade\media\icons';
  vPath[8] := extrafe.prog.Path + 'emu\arcade\media\manuals';
  vPath[9] := extrafe.prog.Path + 'emu\arcade\media\marquees';
  vPath[10] := extrafe.prog.Path + 'emu\arcade\media\pcbs';
  vPath[11] := extrafe.prog.Path + 'emu\arcade\media\snapshots';
  vPath[12] := extrafe.prog.Path + 'emu\arcade\media\titles';
  vPath[13] := extrafe.prog.Path + 'emu\arcade\media\artwork_preview';
  vPath[14] := extrafe.prog.Path + 'emu\arcade\media\bosses';
  vPath[15] := extrafe.prog.Path + 'emu\arcade\media\ends';
  vPath[16] := extrafe.prog.Path + 'emu\arcade\media\how_to';
  vPath[17] := extrafe.prog.Path + 'emu\arcade\media\logos';
  vPath[18] := extrafe.prog.Path + 'emu\arcade\media\scores';
  vPath[19] := extrafe.prog.Path + 'emu\arcade\media\selects';
  vPath[20] := extrafe.prog.Path + 'emu\arcade\media\stamps';
  vPath[21] := extrafe.prog.Path + 'emu\arcade\media\versus';
  vPath[22] := extrafe.prog.Path + 'emu\arcade\media\warnings';
  vPath[23] := extrafe.prog.Path + 'emu\arcade\media\soundtracks';
  vPath[24] := extrafe.prog.Path + 'emu\arcade\media\support_files';
  vPath[25] := extrafe.prog.Path + 'emu\arcade\media\videos';

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Add('INSERT INTO ARCADE_MEDIA ("USER_ID", "ARTWORKS", "CABINETS", "CONTROL_PANELS", "COVERS", "FLYERS", "FANART", "GAME_OVER", ' +
    '"ICONS", "MANUALS", "MARQUEES", "PCBS", "SNAPSHOTS", "TITLES", "ARTWORK_PREVIEW", "BOSSES", "ENDS", "HOW_TO", "LOGOS", "SCORES", "SELECTS", "STAMPS", ' +
    '"VERSUS", "WARNINGS", "SOUNDTRACKS", "SUPPORT_FILES", "VIDEOS") VALUES (''' + User_Reg.Database_Num + ''', ''' + vPath[0] + ''', ''' + vPath[1] + ''', '''
    + vPath[2] + ''', ''' + vPath[3] + ''', ''' + vPath[4] + ''', ''' + vPath[5] + ''', ''' + vPath[6] + ''', ''' + vPath[7] + ''', ''' + vPath[8] + ''', ''' +
    vPath[9] + ''', ''' + vPath[10] + ''' , ''' + vPath[11] + ''', ''' + vPath[12] + ''', ''' + vPath[13] + ''', ''' + vPath[14] + ''', ''' + vPath[15] +
    ''', ''' + vPath[16] + ''', ''' + vPath[17] + ''', ''' + vPath[18] + ''', ''' + vPath[19] + ''', ''' + vPath[20] + ''', ''' + vPath[21] + ''', ''' +
    vPath[22] + ''', ''' + vPath[23] + ''', ''' + vPath[24] + ''', ''' + vPath[25] + ''')');
  ExtraFE_Query_Local.ExecSQL;

  { Mame }
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Add(' INSERT INTO ARCADE_MAME ("USER_ID") VALUES (' + User_Reg.Database_Num + ')');
  ExtraFE_Query_Local.ExecSQL;
  { Arcade Section End }

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Add(' INSERT INTO COMPUTERS ("USER_ID") VALUES (' + User_Reg.Database_Num + ')');
  ExtraFE_Query_Local.ExecSQL;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Add(' INSERT INTO CONSOLES ("USER_ID") VALUES (' + User_Reg.Database_Num + ')');
  ExtraFE_Query_Local.ExecSQL;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Add(' INSERT INTO HANDHELDS ("USER_ID") VALUES (' + User_Reg.Database_Num + ')');
  ExtraFE_Query_Local.ExecSQL;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Add(' INSERT INTO PINBALLS ("USER_ID") VALUES (' + User_Reg.Database_Num + ')');
  ExtraFE_Query_Local.ExecSQL;

  { Addons data }
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Add(' INSERT INTO ADDONS ("USER_ID") VALUES (' + User_Reg.Database_Num + ')');
  ExtraFE_Query_Local.ExecSQL;

  { Addons Time }
  free_vpath;
  vPath[0] := extrafe.prog.Path + 'data\addons\time\images\';
  vPath[1] := extrafe.prog.Path + 'data\addons\time\sounds\';
  vPath[2] := extrafe.prog.Path + 'data\addons\time\clock\';

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Add('INSERT INTO ADDON_TIME ("USER_ID", "MENU_POSITION", "FIRST_POP", "PATH_IMAGES", "PATH_SOUNDS", "PATH_CLOCKS") VALUES (''' +
    User_Reg.Database_Num + ''', 0, TRUE, ''' + vPath[0] + ''', ''' + vPath[1] + ''', ''' + vPath[2] + ''')');
  ExtraFE_Query_Local.ExecSQL;

  { Addons Time Time Data }
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Add(' INSERT INTO ADDON_TIME_TIME ("USER_ID") VALUES (' + User_Reg.Database_Num + ')');
  ExtraFE_Query_Local.ExecSQL;

end;

/// ////////////////////////////////////////////////////////////////////////////////////
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
        user_Active_Online.Num := vi;
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
  vCPassword := Get_Query(user_Active_Online.Num, 'password');
  if vCPassword = vPassword then
  begin
    user_Active_Online.Password := vCPassword;
    Result := True;
  end
end;

end.
