unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Menus;

type
  TMain_Form = class(TForm)
    MenuBar1: TMenuBar;
    Menu_File: TMenuItem;
    Menu_Exit: TMenuItem;
    Menu_Create_New: TMenuItem;
    MenuItem2: TMenuItem;
    Menu_New_HD_1920X1080: TMenuItem;
    procedure Menu_ExitClick(Sender: TObject);
    procedure Menu_New_HD_1920X1080Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main_Form: TMain_Form;

implementation

{$R *.fmx}

procedure TMain_Form.Menu_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMain_Form.Menu_New_HD_1920X1080Click(Sender: TObject);
begin
  Main_Form.Width:= 1920;
  Main_Form.Height:= 1080;
  Main_Form.WindowState:= TWindowState.wsMaximized;
end;

end.
