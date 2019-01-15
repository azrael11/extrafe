program ExtraFE_Theme_Creator;

uses
  System.StartUpCopy,
  FMX.Forms,
  main in 'main.pas' {Main_Form},
  uThemes_Resolutions in 'main\uThemes_Resolutions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMain_Form, Main_Form);
  Application.Run;
end.
