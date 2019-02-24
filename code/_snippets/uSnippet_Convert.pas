unit uSnippet_Convert;

interface
uses
  System.Classes,
  System.SysUtils,
  System.Inifiles;

function Code_To_Country(vCode: String): String;

implementation
uses
  uLoad_AllTypes;

function Code_To_Country(vCode: String): String;
var
  vTempIni: TIniFile;
begin
  vTempIni:= TIniFile.Create(ex_main.Paths.Flags_Images+ 'en.ini');
  Result:= vTempIni.ReadString('COUNTRY', vCode, Result);
  FreeAndNil(vTempIni);
end;
end.
