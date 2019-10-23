unit loading;

interface

uses
  System.UITypes,
  System.Classes,
  System.SysUtils,
  FMX.Forms,
  FMX.Types,
  JCLSysInfo,
  FireDAC.UI.Intf,
  FireDAC.FMXUI.Wait, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.SQLite;

{ type
  TTIMER_LOADING_VIDEO = class(TTimer)
  procedure OnTimer(Sender: TObject);
  end; }

type
  TLoading_Form = class(TForm)
    SQLite_DriverLink: TFDPhysSQLiteDriverLink;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Loading_Form: TLoading_Form;

implementation

uses
  uKeyboard,
  uLoad,
  uDatabase,
  uLoad_AllTypes;

{$R *.fmx}

procedure TLoading_Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ReportMemoryLeaksOnShutdown := False;
  Application.ProcessMessages;
end;

procedure TLoading_Form.FormCreate(Sender: TObject);
var
  iRetCode: Integer;
begin
  // if CPUID.CpuType <> CPU_TYPE_INTEL then
  // SetEnvironmentVar('KMP_AFFINITY', 'disabled');


  // if kmp then

  // iRetCode = _putenv( "KMP_AFFINITY=disabled" );
  // if( iRetCode == 0 )
  // printf( "KMP_AFFINITY=%sn", getenv( "KMP_AFFINITY" ) )
  // else
  // printf( "Error: Failed to Set Environment Variable KMP_AFFINITYn" );
//  SQLConnection1.Params.Add('Database=' + extrafe.prog.Path + 'data\database\extrafe.ib');
  Default_Load := False;
  uLoad.StartLoading;
end;

end.
