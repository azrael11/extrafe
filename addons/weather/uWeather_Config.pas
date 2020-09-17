unit uWeather_Config;

interface

uses
  System.classes;

procedure uWeather_Config_ShowHide(mShow: Boolean);
procedure uWeather_COnfig_ClearConfig;
procedure uWeather_Config_ShowPanel(mPanel: Integer);

implementation

uses
  uDB_AUser,
  uLoad_AllTypes,
  uWeather_AllTypes,
  uWeather_Config_Provider,
  uWeather_Config_Towns,
  uWeather_Config_Options,
  uWeather_Config_Iconsets,
  uWeather_Providers_Yahoo;

procedure uWeather_Config_ShowHide(mShow: Boolean);
begin
  if mShow then
    extrafe.prog.State := 'addon_weather_config'
  else
  begin
    extrafe.prog.State := 'addon_weather';
    uWeather_COnfig_ClearConfig;
  end;
  vWeather.Scene.Blur.Enabled := mShow;
  vWeather.Config.Panel.Visible := mShow;
  weather.Config.Active_Panel := -1;
end;

procedure uWeather_COnfig_ClearConfig;
begin
  if Assigned(vWeather.Config.main.Right.Panels[0]) then
    uWeather_Config_Provider.Free
  else if Assigned(vWeather.Config.main.Right.Panels[1]) then
    uWeather_Config_Towns.Free
  else if Assigned(vWeather.Config.main.Right.Panels[2]) then
    uWeather_Config_Options.Free
  else if Assigned(vWeather.Config.main.Right.Panels[3]) then
    uWeather_Config_Iconsets.Free;
end;

procedure uWeather_Config_ShowPanel(mPanel: Integer);
begin
  if weather.Config.Active_Panel <> mPanel then
  begin
    uWeather_COnfig_ClearConfig;
    case mPanel of
      0:
        uWeather_Config_Provider.Load;
      1:
        uWeather_Config_Towns.Load;
      2:
        uWeather_Config_Options.Load;
      3:
        uWeather_Config_Iconsets.Load;
    end;
    weather.Config.Active_Panel := mPanel;
  end;
end;

end.
