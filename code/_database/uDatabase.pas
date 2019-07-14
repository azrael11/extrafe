unit uDatabase;

interface

uses
  System.Classes,
  System.SysUtils,
  FMX.Dialogs,
  ZAbstractRODataset,
  ZAbstractDataset,
  ZDataset,
  ZAbstractConnection,
  ZConnection;

procedure uDatabase_Create;
function uDatabase_Connect: Boolean;
function uDatabase_Disconnect: Boolean;

var
  ExtraFE_DB: TZConnection;
  ExtraFE_Query: TZQuery;

implementation

uses
  uLoad_AllTypes,
  main;

procedure uDatabase_Create;
begin
  ExtraFE_DB := TZConnection.Create(Main_Form);
  ExtraFE_DB.Name := 'ExtraFE_Database';
  ExtraFE_DB.Protocol:= 'mysql';
  ExtraFE_DB.LibraryLocation:= extrafe.prog.Paths.Lib+ 'libmysql.dll';
{ epizy.com
//  ExtraFE_DB.HostName := 'sql210.epizy.com'; epizy.com needs premium plan cheap but premium
//  ExtraFE_DB.User := 'epiz_23299538';
//  ExtraFE_DB.Password := 'u4fbISfU';
//  ExtraFE_DB.Database := 'epiz_23299538_extrafe';
//  ExtraFE_DB.Port := 3306;}

{//My raspberrypi server
  ExtraFE_DB.HostName := '192.168.2.4'; // http://az-creations.ddns.net/
  ExtraFE_DB.Port := 3306;
  ExtraFE_DB.User := 'Nikos_Azrael11';
  ExtraFE_DB.Password := '11azrael!';
  ExtraFE_DB.Database := 'extrafe_db_main';}


{ //Free RemoteSQL Server
  ExtraFE_DB.HostName := 'remotemysql.com';
  ExtraFE_DB.Port := 3306;
  ExtraFE_DB.User := 'UOow2q7XU9';
  ExtraFE_DB.Password := 'YyZItsVz8v';
  ExtraFE_DB.Database := 'UOow2q7XU9';}

//  ExtraFE_DB.HostName := '95.154.242.75';
//  ExtraFE_DB.Port := 3306;
//  ExtraFE_DB.User := 'gynaikei_nikos';
//  ExtraFE_DB.Password := 'lOsXMyD+PY$6';
//  ExtraFE_DB.Database := 'gynaikei_nikos';


  ExtraFE_Query:= TZQuery.Create(Main_Form);
  ExtraFE_Query.Name:= 'ExtraFE_Database_Query';
  ExtraFE_Query.Connection:= ExtraFE_DB;
end;

function uDatabase_Connect: Boolean;
begin
  try
    ExtraFE_DB.Connect;
  except
    on E : Exception do
    begin
//      ShowMessage('Something Wrong with the server click to continue');
    end;
  end;
  Result := ExtraFE_DB.Connected;
end;

function uDatabase_Disconnect: Boolean;
begin
  ExtraFE_DB.Disconnect;
  Result := ExtraFE_DB.Connected;
end;

///////////////////


end.
