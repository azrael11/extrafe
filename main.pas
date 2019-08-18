unit main;

interface

uses
  System.Classes,
  FMX.Forms,
  FMX.Types,
  FMX.Effects,
  FMX.Ani,
  FMX.Filter.Effects,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP;

type
  TMain_Form = class(TForm)
    Main_IdHttp: TIdHTTP;
    FadeTransitionEffect1: TFadeTransitionEffect;
    FloatAnimation1: TFloatAnimation;
    procedure FormDestroy(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main_Form: TMain_Form;

implementation

{$R *.fmx}

uses
  uLoad_AllTypes,
  uMain_Actions,
  uKeyboard,
  uDatabase;

procedure TMain_Form.FormDestroy(Sender: TObject);
begin
  uDatabase.Online_Disconnect;
  ReportMemoryLeaksOnShutdown:= False;
end;

end.
