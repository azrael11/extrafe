program MP4TagLibraryTutorial;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  MP4TagLibrary in 'MP4TagLibrary.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
