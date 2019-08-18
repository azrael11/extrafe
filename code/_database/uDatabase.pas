unit uDatabase;

interface

uses
  System.Classes,
  System.SysUtils,
  FMX.Dialogs,
  Data.DB,
  Data.SqlExpr,
  Data.FMTBcd,
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

  ExtraFE_DB_Local: TSQLConnection; { Local Interbase }
  ExtraFE_Query_Local: TSQLQuery; { Local Interbase }

implementation

uses
  uLoad_AllTypes,
  main;

procedure Online_Create;
begin
  ExtraFE_DB := TZConnection.Create(Main_Form);
  ExtraFE_DB.Name := 'ExtraFE_Database';
  ExtraFE_DB.Protocol := 'mysql';
  ExtraFE_DB.LibraryLocation := extrafe.prog.Paths.Lib + 'libmysql.dll';
  { epizy.com
    //  ExtraFE_DB.HostName := 'sql210.epizy.com'; epizy.com needs premium plan cheap but premium
    //  ExtraFE_DB.User := 'epiz_23299538';
    //  ExtraFE_DB.Password := 'u4fbISfU';
    //  ExtraFE_DB.Database := 'epiz_23299538_extrafe';
    //  ExtraFE_DB.Port := 3306; }

  { //My raspberrypi server
    ExtraFE_DB.HostName := '192.168.2.4'; // http://az-creations.ddns.net/
    ExtraFE_DB.Port := 3306;
    ExtraFE_DB.User := 'Nikos_Azrael11';
    ExtraFE_DB.Password := '11azrael!';
    ExtraFE_DB.Database := 'extrafe_db_main'; }

  { //Free RemoteSQL Server
    ExtraFE_DB.HostName := 'remotemysql.com';
    ExtraFE_DB.Port := 3306;
    ExtraFE_DB.User := 'UOow2q7XU9';
    ExtraFE_DB.Password := 'YyZItsVz8v';
    ExtraFE_DB.Database := 'UOow2q7XU9'; }

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
      // ShowMessage('Something Wrong with the server click to continue');
    end;
  end;
  Result := ExtraFE_DB.Connected;
end;

function Online_Disconnect: Boolean;
begin
  ExtraFE_DB.Disconnect;
  Result := ExtraFE_DB.Connected;
end;

/// ////////////////
///

procedure Local_Create;
begin
  ExtraFE_DB_Local := TSQLConnection.Create(main.Main_Form);
  ExtraFE_DB_Local.Connected := False;
  ExtraFE_DB_Local.ConnectionName := 'IBToGoConnection';
  ExtraFE_DB_Local.DriverName := 'IBLite/ToGo';
  ExtraFE_DB_Local.KeepConnection := True;
  ExtraFE_DB_Local.LoginPrompt := True;
  ExtraFE_DB_Local.Name := 'ExtraFE_Local_Database';
  ExtraFE_DB_Local.Params.Clear;
  ExtraFE_DB_Local.Params.Add('DriverUnit=Data.DBXInterBase');
  ExtraFE_DB_Local.Params.Add('user_name=azrael11');
  ExtraFE_DB_Local.Params.Add('password=arcazrael11');
  ExtraFE_DB_Local.Params.Add('Database='+extrafe.prog.Path + 'data\database\extrafe.ib');
  ExtraFE_DB_Local.Params.Add('LibraryName=dbxint.dll');
  ExtraFE_DB_Local.Params.Add('GetDriverFunc=getSQLDriverINTERBASE');
  ExtraFE_DB_Local.Params.Add('VendorLib=gds32.dll');
  ExtraFE_DB_Local.Params.Add('VendorLibWin64=ibtogo64.dll');
  ExtraFE_DB_Local.Params.Add('VendorLibOsx=libibtogo.dylib');
  ExtraFE_DB_Local.Params.Add('DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver260.bpl');
  ExtraFE_DB_Local.Params.Add('DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=24.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');
  ExtraFE_DB_Local.Params.Add('MetaDataPackageLoader=TDBXInterbaseMetaDataCommandFactory,DbxInterBaseDriver260.bpl');
  ExtraFE_DB_Local.Params.Add('MetaDataAssemblyLoader=Borland.Data.TDBXInterbaseMetaDataCommandFactory,Borland.Data.DbxInterBaseDriver,Version=24.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');
  ExtraFE_DB_Local.ParamsLoaded:= True;
//  DriverUnit=Data.DBXInterBase
//DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver260.bpl
//DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=24.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b
//MetaDataPackageLoader=TDBXInterbaseMetaDataCommandFactory,DbxInterBaseDriver260.bpl
//MetaDataAssemblyLoader=Borland.Data.TDBXInterbaseMetaDataCommandFactory,Borland.Data.DbxInterBaseDriver,Version=24.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b
//GetDriverFunc=getSQLDriverINTERBASE
//LibraryName=dbxint.dll
//LibraryNameOsx=libsqlib.dylib
//VendorLib=gds32.dll
//VendorLibWin64=ibtogo64.dll
//VendorLibOsx=libibtogo.dylib
//Database=C:\Users\spooo\Documents\My_Projects\Program_Dev\ExtraFe\Release\ExtraFE\win64\data\database\extrafe.ib
//User_Name=azrael11
//Password=arcazrael11
//Role=RoleName
//MaxBlobSize=-1
//LocaleCode=0000
//IsolationLevel=ReadCommitted
//SQLDialect=3
//CommitRetain=False
//WaitOnLocks=True
//TrimChar=False
//DisplayDriverName=IBLite/ToGo
//AutoUnloadDriver=True
//BlobSize=-1
//ErrorResourceFile=
//RoleName=RoleName
//ServerCharSet=
//Trim Char=False
//SEP=
//  ExtraFE_DB_Local.Params.Values['Database'] := extrafe.prog.Path + 'data\database\extrafe.ib';
//  ExtraFE_DB_Local.Params.Values['User_Name'] := 'azrael11';
//  ExtraFE_DB_Local.Params.Values['Password'] := 'arcazrael11';
//  ExtraFE_DB_Local.Params.Values['Role'] := 'RoleName';
//  ExtraFE_DB_Local.Params.Values['MaxBlobSize'] := '-1';
//  ExtraFE_DB_Local.Params.Values['LocaleCode'] := '0000';
//  ExtraFE_DB_Local.Params.Values['IsolationLevel'] := 'ReadCommitted';
//  ExtraFE_DB_Local.Params.Values['SQLDialect'] := '3';
//  ExtraFE_DB_Local.Params.Values['CommitRetain'] := 'False';
//  ExtraFE_DB_Local.Params.Values['WaitOnLocks'] := 'True';
//  ExtraFE_DB_Local.Params.Values['TrimChar'] := 'False';
//  ExtraFE_DB_Local.Params.Values['DisplayDriverName'] := 'IBLite/ToGo';
//  ExtraFE_DB_Local.Params.Values['AutoUnloadDriver'] := 'True';
//  ExtraFE_DB_Local.Params.Values['BlobSize'] := '-1';
//  ExtraFE_DB_Local.Params.Values['ErrorResourceFile'] := '';
//  ExtraFE_DB_Local.Params.Values['RoleName'] := 'RoleName';
//  ExtraFE_DB_Local.Params.Values['ServerCharSet'] := '';
//  ExtraFE_DB_Local.Params.Values['Trim Char'] := 'False';
//  ExtraFE_DB_Local.Params.Values['SEP'] := '';
end;

function Local_Connect: Boolean;
begin
  Result := False;
  ExtraFE_DB_Local.Connected := True;

  if ExtraFE_DB_Local.Connected then
    Result := True;

  ExtraFE_Query_Local := TSQLQuery.Create(main.Main_Form);
  ExtraFE_Query_Local.Name := 'ExtraFE_Local_Query';
  ExtraFE_Query_Local.SQLConnection := ExtraFE_DB_Local;
  ExtraFE_Query_Local.Active := False;
end;

function Local_Disconnect: Boolean;
begin
  Result := False;
  ExtraFE_DB_Local.Connected := False;
  if ExtraFE_DB_Local.Connected= False then
    Result:= True;
end;

end.
