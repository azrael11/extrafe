unit uInternet_files;

interface
uses
  System.Classes,
  System.IniFIles,
  IdHTTP,
  IdComponent;

  type INTERNET_FILES= class
  private
    vHTTP: TIdHTTP;
    vMS: TMemoryStream;
    vUrl: String;
  public
    constructor Create(vUrl: String);

    procedure uInternet_Files_Download(vIniFileName: TIniFile); Overload;
    procedure uInternet_Files_Download(vTxtFileName: String); Overload;

    destructor Destroy; Override;
  end;

  procedure uInternet_Files_Download_File(vFileName, vUrl: String);

implementation


procedure uInternet_Files_Download_File(vFileName, vUrl: String);
begin

end;

{ INTERNET_FILES }

constructor INTERNET_FILES.Create(vUrl: String);
begin

end;

destructor INTERNET_FILES.Destroy;
begin

  inherited;
end;

procedure INTERNET_FILES.uInternet_Files_Download(vTxtFileName: String);
begin

end;

procedure INTERNET_FILES.uInternet_Files_Download(vIniFileName: TIniFile);
begin

end;

end.
