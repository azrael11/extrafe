unit uDB;

interface

uses
  System.Classes,
  System.SysUtils,
  FMX.Dialogs,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.FMXUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Phys.IB,
  FireDAC.Phys.IBLiteDef,
  FireDAC.Stan.StorageJSON,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.UI,
  ZAbstractRODataset,
  ZAbstractDataset,
  ZDataset,
  ZAbstractConnection,
  ZConnection;

{ Databases actions }

procedure Online_Create;
function Online_Connect: Boolean;
function Online_Disconnect: Boolean;

procedure Local_Create;
function Local_Connect: Boolean;
function Local_Disconnect: Boolean;

procedure Emulators_Create;
function Emulators_Connect: Boolean;
function Emulators_Disconnect: Boolean;

{ New User }
{ OnLine Database }
function Add_New_User_Online: Boolean;
{ Local Database }
function Add_New_User_Local: Boolean;

{ Queries Actions Local }
procedure Query_Insert(vQuery: TFDQuery; vTable, vColumns, vValues: String);
procedure Query_Update(vQuery: TFDQuery; vTable_Name, vCol, vValue, vRec, vWhere: string);
function Query_Select(vQuery: TFDQuery; vColumn, vTable, vRec, vWhere: String): String;
// function Query_Select(vQuery: TFDQuery; vColumn, vTable, vRec, vWhere: String): Integer; overload;

{ Queries Actions Online }
procedure Query_Update_Online(vTable_Name, vCol, vValue, vUser_Num: string);
function Query_Select_Online(vColumn, vTable, vWhere: String): String;
// function Query_Select_Online(vTable, vWhere, vField: string): Integer; override;

var
  vColumns: String;
  vValues: String;

var
  { Databases }

  { Main ExtraFE Includes Addons }
  ExtraFE_DB: TZConnection; { Online MySQL }
  ExtraFE_Query: TZQuery; { Online MySQL }

  ExtraFE_DB_Local: TFDConnection; { Local SQLite }
  ExtraFE_Query_Local: TFDQuery; { Local SQLite }

  ExtraFE_FDGUIxWaitCursor: TFDGUIxWaitCursor;

  ExtraFE_MemTable: TFDMemTable; { Local_MemTable }
  ExtraFE_MemTable_JSON: TFDStanStorageJSONLink;

  { Emulators }
  Arcade: TFDConnection;
  Arcade_Query: TFDQuery;

  Computers: TFDConnection;
  Computers_Query: TFDQuery;

  Consoles: TFDConnection;
  Consoles_Query: TFDQuery;

  Handhelds: TFDConnection;
  Handhelds_Query: TFDQuery;

  Pinballs: TFDConnection;
  Pinballs_Query: TFDQuery;

implementation

uses
  uLoad_AllTypes,
  main,
  load,
  emu,
  uLoad_Register,
  uDB_AUser;

procedure Online_Create;
begin
  ExtraFE_DB := TZConnection.Create(Main_Form);
  ExtraFE_DB.Name := 'ExtraFE_Database';
  ExtraFE_DB.Protocol := 'mysql';
  ExtraFE_DB.LibraryLocation := extrafe.prog.Lib_Path + 'libmysql.dll';
  { epizy.com
    //  ExtraFE_DB.HostName := 'sql210.epizy.com'; epizy.com needs premium plan cheap but premium
    //  ExtraFE_DB.User := 'epiz_23299538';
    //  ExtraFE_DB.Password := 'u4fbISfU';
    //  ExtraFE_DB.Database := 'epiz_23299538_extrafe';
    //  ExtraFE_DB.Port := 3306; }

  ExtraFE_DB.HostName := 'db4free.net';
  ExtraFE_DB.Port := 3306;
  ExtraFE_DB.User := 'azrael11';
  ExtraFE_DB.Password := '11azrael';
  ExtraFE_DB.Database := 'extrafe';

  { ExtraFE_DB.HostName := 'azrael11.heliohost.org';
    ExtraFE_DB.Port := 3306;
    //  ExtraFE_DB.User := 'azrael11@localhost';
    ExtraFE_DB.User := 'azrael11_azrael';
    ExtraFE_DB.Password := '11azrael';
    ExtraFE_DB.Database := 'azrael11_extrafe'; }

  ExtraFE_Query := TZQuery.Create(Main_Form);
  ExtraFE_Query.Name := 'ExtraFE_Database_Query';
  ExtraFE_Query.Connection := ExtraFE_DB;
end;

function Online_Connect: Boolean;
begin
  try
    ExtraFE_DB.Connect;
  except
    on E: Exception do
    begin
      ShowMessage(E.ToString);
    end;
  end;
  Result := ExtraFE_DB.Connected;

  Result := True;
end;

function Online_Disconnect: Boolean;
begin
  // Query_Update_Online('USERS', 'ACTIVE', 'FALSE', user_Active_Local.Num.ToString);
  // ExtraFE_DB.Disconnect;
  // Result := ExtraFE_DB.Connected;
end;

/// ////////////////
///

procedure Local_Create;
begin
  ExtraFE_DB_Local := TFDConnection.Create(main.Main_Form);
  ExtraFE_DB_Local.Name := 'ExtraFE_Local_Database';
  with ExtraFE_DB_Local do
  begin
    Close;
    with Params do
    begin
      Add('DriverID=SQLITE');
      Add('Database=' + extrafe.prog.Path + 'data\database\EXTRAFE.DB');
    end;
    Open;
  end;
  ExtraFE_DB_Local.LoginPrompt := False;
end;

function Local_Connect: Boolean;
begin
  Result := False;
  ExtraFE_DB_Local.Connected := True;

  if ExtraFE_DB_Local.Connected then
    Result := True;

  ExtraFE_Query_Local := TFDQuery.Create(main.Main_Form);
  ExtraFE_Query_Local.Name := 'ExtraFE_Local_Query';
  ExtraFE_Query_Local.Connection := ExtraFE_DB_Local;
  ExtraFE_Query_Local.Active := False;

  ExtraFE_FDGUIxWaitCursor := TFDGUIxWaitCursor.Create(load.Loading);
  ExtraFE_FDGUIxWaitCursor.Name := 'ExtraFE_Local_GUIxWaitCursor';

  { Create a mem table for manipulation mem big lists not added in database }
  ExtraFE_MemTable := TFDMemTable.Create(main.Main_Form);
  ExtraFE_MemTable.Name := 'ExtraFE_Local_MemTable';
  ExtraFE_MemTable.Active := False;
  ExtraFE_MemTable_JSON := TFDStanStorageJSONLink.Create(main.Main_Form);
  ExtraFE_MemTable_JSON.Name := 'ExtraFE_Local_JSON_Storage_Link';
end;

function Local_Disconnect: Boolean;
begin
  Result := False;
  ExtraFE_DB_Local.Connected := False;
  if ExtraFE_DB_Local.Connected = False then
    Result := True;
end;

procedure Emulators_Create;
begin
  { Arcade }
  Arcade := TFDConnection.Create(emu.Emu_Form);
  Arcade.Name := 'Arcade_Database';
  with Arcade do
  begin
    Close;
    with Params do
    begin
      Add('DriverID=SQLITE');
      Add('Database=' + extrafe.prog.Path + 'data\database\arcade\arcade.db');
    end;
    Open;
  end;
  Arcade.LoginPrompt := False;

  { Computers }
  Computers := TFDConnection.Create(emu.Emu_Form);
  Computers.Name := 'Computers_Database';
  with Computers do
  begin
    Close;
    with Params do
    begin
      Add('DriverID=SQLITE');
      Add('Database=' + extrafe.prog.Path + 'data\database\computers\computers.db');
    end;
    Open;
  end;
  Computers.LoginPrompt := False;

  { Consoles }
  Consoles := TFDConnection.Create(emu.Emu_Form);
  Consoles.Name := 'Consoles_Database';
  with Consoles do
  begin
    Close;
    with Params do
    begin
      Add('DriverID=SQLITE');
      Add('Database=' + extrafe.prog.Path + 'data\database\consoles\consoles.db');
    end;
    Open;
  end;
  Consoles.LoginPrompt := False;

  { Handhelds }
  Handhelds := TFDConnection.Create(emu.Emu_Form);
  Handhelds.Name := 'Handhelds_Database';
  with Handhelds do
  begin
    Close;
    with Params do
    begin
      Add('DriverID=SQLITE');
      Add('Database=' + extrafe.prog.Path + 'data\database\handhelds\handhelds.db');
    end;
    Open;
  end;
  Handhelds.LoginPrompt := False;

  { Pinballs }
  Pinballs := TFDConnection.Create(emu.Emu_Form);
  Pinballs.Name := 'Pinballs_Database';
  with Pinballs do
  begin
    Close;
    with Params do
    begin
      Add('DriverID=SQLITE');
      Add('Database=' + extrafe.prog.Path + 'data\database\pinballs\pinballs.db');
    end;
    Open;
  end;
  Pinballs.LoginPrompt := False;

end;

function Emulators_Connect: Boolean;
begin
  Arcade.Connected := True;

  Arcade_Query := TFDQuery.Create(emu.Emu_Form);
  Arcade_Query.Name := 'Mame_Local_Query';
  Arcade_Query.Connection := Arcade;
  Arcade_Query.Active := False;
end;

function Emulators_Disconnect: Boolean;
begin

end;

{ New User }
{ OnLine Database }
function Add_New_User_Online: Boolean;
begin
  Result := False;
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.ParamCheck := False;
  ExtraFE_Query.SQL.Add('INSERT INTO USERS (USER_ID, USERNAME, PASSWORD, EMAIL, AVATAR, NAME, SURNAME, GENDER, IP, COUNTRY, REGISTERED, LAST_VISIT) VALUES ("' + User_Reg.User_ID + '", "' +
    User_Reg.Username + '", "' + User_Reg.Password + '", "' + User_Reg.Email + '", "' + User_Reg.Avatar + '", "' + User_Reg.Name + '", "' + User_Reg.Surname + '", "' + User_Reg.Genre + '", "' +
    User_Reg.IP + '", "' + User_Reg.Country + '", "' + User_Reg.Registered + '", "' + User_Reg.Last_Visit + '")');
  ExtraFE_Query.ExecSQL;
  Result := True;
end;

{ Local Database }
function Add_New_User_Local: Boolean;
var
  vPath: array [0 .. 40] of string;
  vLocal_Num: String;
  procedure free_vpath;
  var
    vi: Integer;
  begin
    for vi := 0 to 40 do
      vPath[vi] := '';
  end;

begin
  Result := False;
  vLocal_Num := (uDB_AUser.Local.Num + 1).ToString;

  { User Settings }
  vPath[0] := extrafe.prog.Path;
  vPath[1] := 'ExtraFE.exe';
  vPath[2] := vPath[0] + '\lib\';
  vPath[3] := vPath[0] + '\data\database\history\';
  vPath[4] := vPath[0] + '\data\main\fonts\';
  vPath[5] := 'Air';
  vPath[6] := vPath[0] + '\data\themes\';
  vPath[7] := '1';
  vPath[8] := vPath[0] + '\data\';
  vPath[9] := vPath[0] + '\data\database\';

  vColumns := 'RESOLUTION_WIDTH, RESOLUTION_HEIGHT, FOULSCREEN, PATH, NAME, PATH_LIB, PATH_HISTORY, PATH_FONTS, THEME_NAME, THEME_PATH, THEME_NUM, LOCAL_DATA, DATABASE_PATH';
  vValues := '"1920", "1080", "TRUE", "' + vPath[0] + '",  "' + vPath[1] + '",  "' + vPath[2] + '",  "' + vPath[3] + '", "' + vPath[4] + '", "' + vPath[5] + '", "' + vPath[6] + '", "' + vPath[7] +
    '", "' + vPath[8] + '", "' + vPath[9] + '"';
  Query_Insert(ExtraFE_Query_Local, 'SETTINGS', vColumns, vValues);

  { User data }
  vColumns := 'UNIQUE_ID, USERNAME, PASSWORD, EMAIL, AVATAR, NAME, SURNAME, GENDER, IP, COUNTRY, REGISTERED, LAST_VISIT_ONLINE, LAST_VISIT, ACTIVE_ONLINE';
  vValues := '"' + User_Reg.User_ID + '", "' + User_Reg.Username + '", "' + User_Reg.Password + '", "' + User_Reg.Email + '", "' + User_Reg.Avatar + '", "' + User_Reg.Name + '", "' + User_Reg.Surname
    + '", "' + User_Reg.Genre + '", "' + User_Reg.IP + '", "' + User_Reg.Country + '", "' + User_Reg.Registered + '", "' + User_Reg.Last_Visit + '", "' + User_Reg.Last_Visit + '", "1"';
  Query_Insert(ExtraFE_Query_Local, 'USERS', vColumns, vValues);

  { Option Data }
  vColumns := 'VIRTUAL_KEYBOARD';
  vValues := '"0"';
  Query_Insert(ExtraFE_Query_Local, 'OPTIONS', vColumns, vValues);

  { User Statistics data }
  vColumns := 'USER_ID';
  vValues := '"' + vLocal_Num + '"';
  Query_Insert(ExtraFE_Query_Local, 'USERS_STATISTICS', vColumns, vValues);

  { Emulation data }
  free_vpath;
  vPath[0] := extrafe.prog.Path + 'emu\';

  vColumns := 'USER_ID, PATH';
  vValues := '"' + vLocal_Num + '", "' + vPath[0] + '"';
  Query_Insert(ExtraFE_Query_Local, 'EMULATORS', vColumns, vValues);

  { Arcade Section Start }
  vColumns := 'USER_ID';
  vValues := '"' + vLocal_Num + '"';
  Query_Insert(ExtraFE_Query_Local, 'ARCADE', vColumns, vValues);

  { Media }
  free_vpath;
  vPath[0] := extrafe.prog.Path + 'emu\arcade\media\artworks\';
  vPath[1] := extrafe.prog.Path + 'emu\arcade\media\cabinets\';
  vPath[2] := extrafe.prog.Path + 'emu\arcade\media\control_panels\';
  vPath[3] := extrafe.prog.Path + 'emu\arcade\media\covers\';
  vPath[4] := extrafe.prog.Path + 'emu\arcade\media\flyers\';
  vPath[5] := extrafe.prog.Path + 'emu\arcade\media\fanart\';
  vPath[6] := extrafe.prog.Path + 'emu\arcade\media\game_over\';
  vPath[7] := extrafe.prog.Path + 'emu\arcade\media\icons\';
  vPath[8] := extrafe.prog.Path + 'emu\arcade\media\manuals\';
  vPath[9] := extrafe.prog.Path + 'emu\arcade\media\marquees\';
  vPath[10] := extrafe.prog.Path + 'emu\arcade\media\pcbs\';
  vPath[11] := extrafe.prog.Path + 'emu\arcade\media\snapshots\';
  vPath[12] := extrafe.prog.Path + 'emu\arcade\media\titles\';
  vPath[13] := extrafe.prog.Path + 'emu\arcade\media\artwork_preview\';
  vPath[14] := extrafe.prog.Path + 'emu\arcade\media\bosses\';
  vPath[15] := extrafe.prog.Path + 'emu\arcade\media\ends\';
  vPath[16] := extrafe.prog.Path + 'emu\arcade\media\how_to\';
  vPath[17] := extrafe.prog.Path + 'emu\arcade\media\logos\';
  vPath[18] := extrafe.prog.Path + 'emu\arcade\media\scores\';
  vPath[19] := extrafe.prog.Path + 'emu\arcade\media\selects\';
  vPath[20] := extrafe.prog.Path + 'emu\arcade\media\stamps\';
  vPath[21] := extrafe.prog.Path + 'emu\arcade\media\versus\';
  vPath[22] := extrafe.prog.Path + 'emu\arcade\media\warnings\';
  vPath[23] := extrafe.prog.Path + 'emu\arcade\media\soundtracks\';
  vPath[24] := extrafe.prog.Path + 'emu\arcade\media\support_files\';
  vPath[25] := extrafe.prog.Path + 'emu\arcade\media\videos\';

  vColumns := 'USER_ID, ARTWORKS, CABINETS, CONTROL_PANELS, COVERS, FLYERS, FANART, GAME_OVER, ICONS, MANUALS, MARQUEES, PCBS, SNAPSHOTS, TITLES, ' +
    'ARTWORK_PREVIEW, BOSSES, ENDS, HOW_TO, LOGOS, SCORES, SELECTS, STAMPS, VERSUS, WARNINGS, SOUNDTRACKS, SUPPORT_FILES, VIDEOS';
  vValues := '"' + vLocal_Num + '", "' + vPath[0] + '", "' + vPath[1] + '", "' + vPath[2] + '", "' + vPath[3] + '", "' + vPath[4] + '", "' + vPath[5] + '", "' + vPath[6] + '", "' + vPath[7] + '", "' +
    vPath[8] + '", "' + vPath[9] + '", "' + vPath[10] + '" , "' + vPath[11] + '", "' + vPath[12] + '", "' + vPath[13] + '", "' + vPath[14] + '", "' + vPath[15] + '", "' + vPath[16] + '", "' +
    vPath[17] + '", "' + vPath[18] + '", "' + vPath[19] + '", "' + vPath[20] + '", "' + vPath[21] + '", "' + vPath[22] + '", "' + vPath[23] + '", "' + vPath[24] + '", "' + vPath[25] + '"';
  Query_Insert(ExtraFE_Query_Local, 'ARCADE_MEDIA', vColumns, vValues);

  { Mame }
  vColumns := 'USER_ID';
  vValues := '"' + vLocal_Num + '"';
  Query_Insert(ExtraFE_Query_Local, 'ARCADE_MAME', vColumns, vValues);
  { Arcade Section End }

  vColumns := 'USER_ID';
  vValues := '"' + vLocal_Num + '"';
  Query_Insert(ExtraFE_Query_Local, 'COMPUTERS', vColumns, vValues);

  vColumns := 'USER_ID';
  vValues := '"' + vLocal_Num + '"';
  Query_Insert(ExtraFE_Query_Local, 'CONSOLES', vColumns, vValues);

  vColumns := 'USER_ID';
  vValues := '"' + vLocal_Num + '"';
  Query_Insert(ExtraFE_Query_Local, 'HANDHELDS', vColumns, vValues);

  vColumns := 'USER_ID';
  vValues := '"' + vLocal_Num + '"';
  Query_Insert(ExtraFE_Query_Local, 'PINBALLS', vColumns, vValues);

  { Addons data }
  vColumns := 'USER_ID';
  vValues := '"' + vLocal_Num + '"';
  Query_Insert(ExtraFE_Query_Local, 'ADDONS', vColumns, vValues);

  { Addons Time }
  free_vpath;
  vPath[0] := extrafe.prog.Path + 'data\addons\time\images\';
  vPath[1] := extrafe.prog.Path + 'data\addons\time\sounds\';
  vPath[2] := extrafe.prog.Path + 'data\addons\time\clock\';

  vColumns := 'USER_ID, MENU_POSITION, FIRST_POP, PATH_IMAGES, PATH_SOUNDS, PATH_CLOCKS';
  vValues := '"' + vLocal_Num + '", "0", TRUE, "' + vPath[0] + '", "' + vPath[1] + '", "' + vPath[2] + '"';
  Query_Insert(ExtraFE_Query_Local, 'ADDON_TIME', vColumns, vValues);

  { Addons Time Time Data }
  vColumns := 'USER_ID';
  vValues := '"' + vLocal_Num + '"';
  Query_Insert(ExtraFE_Query_Local, 'ADDON_TIME_TIME', vColumns, vValues);

  { Addons Calendar }
  vColumns := 'USER_ID, MENU_POSITION';
  vValues := '"' + vLocal_Num + '" , "1"';
  Query_Insert(ExtraFE_Query_Local, 'ADDON_CALENDAR', vColumns, vValues);

  { Addons Weather }
  free_vpath;
  vPath[0] := extrafe.prog.Path + 'data\addons\weather\icons\';
  vPath[1] := extrafe.prog.Path + 'data\addons\weather\images\';
  vPath[2] := extrafe.prog.Path + 'data\addons\weather\sounds\';
  vPath[3] := extrafe.prog.Path + 'data\addons\weather\temp\';

  vColumns := 'USER_ID, PATH_ICONS, PATH_IMAGES, PATH_SOUNDS, PATH_TEMP';
  vValues := '"' + vLocal_Num + '", "' + vPath[0] + '", "' + vPath[1] + '", "' + vPath[2] + '", "' + vPath[3] + '"';
  Query_Insert(ExtraFE_Query_Local, 'ADDON_WEATHER', vColumns, vValues);

  { Addons SoundPlayer }
  free_vpath;
  vPath[0] := extrafe.prog.Path + 'data\addons\soundplayer\images\';
  vPath[1] := extrafe.prog.Path + 'data\addons\soundplayer\playlists\';
  vPath[2] := extrafe.prog.Path + 'data\addons\soundplayer\sounds\';

  vColumns := 'USER_ID, PATH_IMAGES, PATH_PLAYLISTS, PATH_SOUNDS';
  vValues := '"' + vLocal_Num + '", "' + vPath[0] + '", "' + vPath[1] + '", "' + vPath[2] + '"';
  Query_Insert(ExtraFE_Query_Local, 'ADDON_SOUNDPLAYER', vColumns, vValues);

  { Addons AzPlay }

  vColumns := 'USER_ID, COUNT, ACTIVE, AZHUNG';
  vValues := '"' + vLocal_Num + '", "4", "0", "1"';
  Query_Insert(ExtraFE_Query_Local, 'ADDON_AZPLAY', vColumns, vValues);

end;

{ Queries Actions Local }
procedure Query_Insert(vQuery: TFDQuery; vTable, vColumns, vValues: String);
begin
  vQuery.Close;
  vQuery.SQL.Clear;
  vQuery.SQL.Add('INSERT INTO ' + vTable + ' (' + vColumns + ') VALUES (' + vValues + ' )');
  vQuery.ExecSQL;
end;

procedure Query_Update(vQuery: TFDQuery; vTable_Name, vCol, vValue, vRec, vWhere: string);
begin
  vQuery.Close;
  vQuery.SQL.Clear;
  vQuery.SQL.Add('UPDATE ' + vTable_Name + ' SET ' + vCol + '="' + vValue + '" WHERE "' + vRec + '"="' + vWhere + '"');
  vQuery.ExecSQL;
end;

function Query_Select(vQuery: TFDQuery; vColumn, vTable, vRec, vWhere: String): String;
begin
  vQuery.Close;
  vQuery.SQL.Clear;
  vQuery.SQL.Add('SELECT ' + vColumn + ' FROM ' + vTable + ' WHERE ' + vRec + '="' + vWhere + '"');
  vQuery.Open;
  vQuery.First;
  Result := vQuery.FieldByName(vColumn).AsString;
end;

// function Query_Select(vQuery: TFDQuery; vColumn, vTable, vRec, vWhere: String): Integer;
// begin
//
// end;

{ Queries Actions Online }
procedure Query_Update_Online(vTable_Name, vCol, vValue, vUser_Num: string);
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('UPDATE ' + vTable_Name + ' SET ' + vCol + '=''' + vValue + ''' WHERE NUM=' + vUser_Num);
  ExtraFE_Query.ExecSQL;
end;

function Query_Select_Online(vColumn, vTable, vWhere: String): String;
var
  vQuery, vField: String;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('SELECT ' + vColumn + ' FROM ' + vTable + ' WHERE NUM=' + vWhere);
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query_Local.FieldByName(vColumn).AsString;
  ExtraFE_Query.Close;
end;

{ function Query_Select_Online(vTable, vWhere, vField: string): Integer; override;
  begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('SELECT * FROM '+ vTable +' WHERE USER_ID=' + vWhere);
  ExtraFE_Query.ExecSQL;
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query.FieldByName(vField).AsInteger;
  end; }

end.
