unit uMain_Config_General_Graphics;

interface
uses
  System.Classes;

procedure Load;

implementation

uses
  uLoad_AllTypes, uMain_AllTypes;

procedure Load;
begin
   extrafe.prog.State := 'main_config_profile_statistics';

  if mainScene.Config.Main.R.General..Layout = nil then
  begin

    mainScene.Config.Main.R.Profile.Statistics.Layout := TLayout.Create(mainScene.Config.Main.R.Profile.TabItem[1]);
    mainScene.Config.Main.R.Profile.Statistics.Layout.Name := 'Main_Config_Profile_Statistics';
    mainScene.Config.Main.R.Profile.Statistics.Layout.Parent := mainScene.Config.Main.R.Profile.TabItem[1];
    mainScene.Config.Main.R.Profile.Statistics.Layout.SetBounds(0, 0, mainScene.Config.Main.R.Profile.TabControl.Width,
      mainScene.Config.Main.R.Profile.TabControl.Height);
    mainScene.Config.Main.R.Profile.Statistics.Layout.Visible := True;
  end;

end;

end.
