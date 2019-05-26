unit uSnippet_Convert;

interface
uses
  System.Classes,
  System.SysUtils,
  System.Inifiles;

function Code_To_Country(vCode: String): String;
function Country_To_Code(vCountry: String): String;

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

function Country_To_Code(vCountry: String): String;
var
  vTextFile: TextFile;
  vKey, vValue: String;
  vIPos: Integer;
  vString: String;
begin
  AssignFile(vTextFile, ex_main.Paths.Flags_Images+ 'en.ini');
  Reset(vTextFile);
  while not EOF(vTextFile) do
  begin
    Readln(vTextFile, vString);
    vIPos:= Pos('=', vString);
    if vIPos<> 0 then
    begin
      vKey:= Trim(Copy(vString, 0, vIPos - 1));
      vValue:= Trim(Copy(vString, vIPos+ 1, Length(vString)- vIPos));
      if vValue= vCountry then
      begin
        Result:= vKey;
        Break
      end;
    end;
  end;
  CloseFile(vTextFile);
end;

end.
