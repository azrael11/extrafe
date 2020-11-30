unit uMain_Config_General_Sound;

interface

uses
  System.Classes, FMX.Layouts;

procedure Load;

implementation

uses
  uLoad_AllTypes, uMain_AllTypes;

procedure Load;
begin
  extrafe.prog.State := 'main_config_general_sound';

  if mainScene.Config.Main.R.General.Sound.Layout = nil then
  begin

    mainScene.Config.Main.R.General.Sound.Layout := TLayout.Create(mainScene.Config.Main.R.General.Tab_Item[2]);
    mainScene.Config.Main.R.General.Sound.Layout.Name := 'Main_Config_General_Sound';
    mainScene.Config.Main.R.General.Sound.Layout.Parent := mainScene.Config.Main.R.General.Tab_Item[2];
    mainScene.Config.Main.R.General.Sound.Layout.SetBounds(0, 0, mainScene.Config.Main.R.General.Control.Width,
      mainScene.Config.Main.R.General.Control.Height);
    mainScene.Config.Main.R.General.Sound.Layout.Visible := True;
  end;

end;

end.
