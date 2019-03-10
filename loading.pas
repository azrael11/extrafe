unit loading;

interface

uses
  System.UITypes,
  System.Classes,
  System.SysUtils,
  FMX.Forms,
  FMX.Types;

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
end;

procedure TLoading_Form.FormCreate(Sender: TObject);
begin
  Default_Load := False;
  uLoad_StartLoading;
end;

end.
