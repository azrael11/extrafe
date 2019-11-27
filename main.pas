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
  IdHTTP, FireDAC.UI.Intf, FireDAC.FMXUI.Wait, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Comp.UI;

type
  TMain_Form = class(TForm)
    Main_IdHttp: TIdHTTP;
    FadeTransitionEffect1: TFadeTransitionEffect;
    FloatAnimation1: TFloatAnimation;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDTransaction: TFDTransaction;
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
  uDB;

procedure TMain_Form.FormDestroy(Sender: TObject);
begin
//  uDB.Online_Disconnect;
  ReportMemoryLeaksOnShutdown:= False;
end;

end.
