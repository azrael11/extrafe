unit uDatabase;

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

procedure Online_Create;
function Online_Connect: Boolean;
function Online_Disconnect: Boolean;

procedure Local_Create;
function Local_Connect: Boolean;
function Local_Disconnect: Boolean;

var
  ExtraFE_DB: TZConnection; { Online MySQL }
  ExtraFE_Query: TZQuery; { Online MySQL }

  ExtraFE_DB_Local: TFDConnection; { Local SQLite }
  ExtraFE_Query_Local: TFDQuery; { Local SQLite }

  ExtraFE_FDGUIxWaitCursor: TFDGUIxWaitCursor;

  ExtraFE_MemTable: TFDMemTable; { Local_MemTable }
  ExtraFE_MemTable_JSON: TFDStanStorageJSONLink;

implementation

uses
  uLoad_AllTypes,
  main,
  load,
  uDatabase_ActiveUser,
  uDatabase_SqlCommands;

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
//      ShowMessage(E.ToString);
    end;
  end;
  Result := ExtraFE_DB.Connected;
end;

function Online_Disconnect: Boolean;
begin
//  uDatabase_SqlCommands.Update_Query('USERS', 'ACTIVE', 'FALSE', user_Active_Local.Num.ToString);
//  ExtraFE_DB.Disconnect;
//  Result := ExtraFE_DB.Connected;
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
      Add('Database='+ extrafe.prog.Path + 'data\database\EXTRAFE.DB');
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

  ExtraFE_FDGUIxWaitCursor:= TFDGUIxWaitCursor.Create(load.Loading);
  ExtraFE_FDGUIxWaitCursor.Name := 'ExtraFE_Local_GUIxWaitCursor';

  {Create a mem table for manipulation mem big lists not added in database}
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

end.
