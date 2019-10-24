{$I ../../source/compiler.inc}

program DemoPasLibVlcPlayer;

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  MainFormUnit,
  FullScreenFormUnit,
  SetEqualizerPresetFormUnit;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSetEqualizerPresetForm, SetEqualizerPresetForm);
  Application.Run;
end.
