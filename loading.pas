unit loading;

interface

uses
  System.UITypes,
  System.Classes,
  System.SysUtils,
  FMX.Forms,
  FMX.Types, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.FMXUI.Wait, Data.DB;

{type
  TTIMER_LOADING_VIDEO = class(TTimer)
    procedure OnTimer(Sender: TObject);
  end;}

type
  TLoading_Form = class(TForm)
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
begin
  Default_Load := False;
  uLoad_StartLoading;
end;

end.
