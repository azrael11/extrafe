unit uMain_Config_Info_Emulators;

interface

uses
  System.Classes, FMX.Layouts;

procedure Load;

implementation

uses
  uLoad_AllTypes, uMain_AllTypes;

procedure Load;
begin
  extrafe.prog.State := 'main_config_info_emulators';

  if mainScene.Config.Main.R.info.Emulators.Layout = nil then
  begin

    mainScene.Config.Main.R.info.Emulators.Layout := TLayout.Create(mainScene.Config.Main.R.info.TabItem[1]);
    mainScene.Config.Main.R.info.Emulators.Layout.Name := 'Main_Config_Info_Emulators';
    mainScene.Config.Main.R.info.Emulators.Layout.Parent := mainScene.Config.Main.R.info.TabItem[1];
    mainScene.Config.Main.R.info.Emulators.Layout.SetBounds(0, 0, mainScene.Config.Main.R.info.TabControl.Width,
      mainScene.Config.Main.R.info.TabControl.Height);
    mainScene.Config.Main.R.info.Emulators.Layout.Visible := True;
  end;
end;

end.
