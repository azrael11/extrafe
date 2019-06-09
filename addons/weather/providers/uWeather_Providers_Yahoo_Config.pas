unit uWeather_Providers_Yahoo_Config;

interface
uses
  System.Classes,
  System.SysUtils;

procedure Load;

implementation
uses
  uLoad_AllTypes,
  uWeather_AllTypes;

procedure Load;
var
  vi: Integer;
begin
  //Set the values in weather.ini
  addons.weather.Ini.Ini.WriteString('Provider', 'Name', 'yahoo');
  //Clear Main_Towns
  for vi := 0 to 255 do
  begin
    if vWeather.Config.Main.Right.Towns.Town[vi].Panel<> nil then
      FreeAndNil(vWeather.Config.Main.Right.Towns.Town[vi].Panel)
    else
      Break
  end;
  //Clear_Config_Towns
  for vi := 0 to 255 do
  begin
    if vWeather.Scene.Tab[0].Tab<> nil then
      FreeAndNil(vWeather.Scene.Tab[0].Tab)
    else
      Break
  end;
  //Clear_Options apo edo kai kato

  //Clear_Iconsets
  //if yahoo have towns load towns else load default
  //if yahoo have towns create main towns else load default
  //create options
  //create and use the selected iconset if have previus activities
end;

end.
