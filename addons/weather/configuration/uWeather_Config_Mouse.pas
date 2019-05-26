unit uWeather_Config_Mouse;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  FMX.Objects,
  FMX.StdCtrls;

type
  TWEATHER_ADDON_CONFIG_TEXT = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TWEATHER_ADDON_CONFIG_BUTTON = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TWEATHER_ADDON_CONFIG_CHECKBOX = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TWEATHER_CONFIG_MOUSE = record
    Text: TWEATHER_ADDON_CONFIG_TEXT;
    Button: TWEATHER_ADDON_CONFIG_BUTTON;
    Checkbox: TWEATHER_ADDON_CONFIG_CHECKBOX;
  end;

implementation

uses
  uLoad_AllTypes,
  uWeather_AllTypes,
  uWeather_Config,
  uWeather_Config_Provider,
  uWeather_Config_Towns,
  uWeather_Config_Towns_Delete,
  uWeather_Config_Towns_Refresh,
  uWeather_Config_Towns_Add;

{ TWEATHER_ADDON_TEXT }

procedure TWEATHER_ADDON_CONFIG_TEXT.OnMouseClick(Sender: TObject);
begin
  if TText(Sender).TextSettings.FontColor = TAlphaColorRec.Deepskyblue then
  begin
    if extrafe.prog.state = 'addon_weather_config' then
    begin
      if TText(Sender).Name = 'A_W_Config_Towns_Add' then
      begin
        TText(Sender).Cursor:= crHourGlass;
        uWeather_Config_Towns_Add.Load;
        TText(Sender).Cursor:= crDefault;
      end
      else if TText(Sender).Name = 'A_W_Config_Towns_Lock' then
        uWeather_Config_Towns_Edit(not addons.weather.Config.Edit_Lock)
      else if TImage(Sender).Name = 'A_W_Config_Towns_PosUp' then
        uWeather_Config_Towns_TownGoUp
      else if TImage(Sender).Name = 'A_W_Config_Towns_PosDown' then
        uWeather_Config_Towns_TownGoDown
      else if TImage(Sender).Name = 'A_W_Config_Towns_Refresh' then
        uWeather_Config_Towns_Edit_Refresh_Show
      else if TImage(Sender).Name = 'A_W_Config_Towns_Delete' then
//        uWeather_Config_Towns_Edit_Delete_Show
    end
    else if extrafe.prog.state = 'addon_weather_config_towns_add' then
    begin
      TText(Sender).Cursor:= crHourGlass;
      if TText(Sender).Name = 'A_W_Config_Towns_Add_Search' then
        uWeather_Config_Towns_Add.FindTown(vWeather.Config.main.Right.Towns.Add.main.FindTown_V.Text);
      TText(Sender).Cursor:= crDefault;
    end;
  end;
end;

procedure TWEATHER_ADDON_CONFIG_TEXT.OnMouseEnter(Sender: TObject);
begin
  if TText(Sender).TextSettings.FontColor = TAlphaColorRec.Deepskyblue then
  begin
    if extrafe.prog.state = 'addon_weather_config' then
    begin
      if TText(Sender).Name = 'A_W_Config_Towns_Add' then
        vWeather.Config.main.Right.Towns.Add_Town_Glow.Enabled := True
      else if TText(Sender).Name = 'A_W_Config_Towns_Lock' then
        vWeather.Config.main.Right.Towns.EditLock_Glow.Enabled := True
      else if TText(Sender).Name = 'A_W_Config_Towns_PosUp' then
        vWeather.Config.main.Right.Towns.GoUp_Glow.Enabled := True
      else if TText(Sender).Name = 'A_W_Config_Towns_PosDown' then
        vWeather.Config.main.Right.Towns.GoDown_Glow.Enabled := True
      else if TImage(Sender).Name = 'A_W_Config_Towns_Refresh' then
        vWeather.Config.main.Right.Towns.Refresh_Glow.Enabled := True
      else if TImage(Sender).Name = 'A_W_Config_Towns_Delete' then
        vWeather.Config.main.Right.Towns.Delete_Glow.Enabled := True
    end
    else if extrafe.prog.state = 'addon_weather_config_towns_add' then
    begin
      if TText(Sender).Name = 'A_W_Config_Towns_Add_Search' then
        vWeather.Config.main.Right.Towns.Add.main.Search_Glow.Enabled := True;
    end;
    TText(Sender).Cursor := crHandPoint;
  end;
end;

procedure TWEATHER_ADDON_CONFIG_TEXT.OnMouseLeave(Sender: TObject);
begin
  if extrafe.prog.state = 'addon_weather_config' then
  begin
    if TText(Sender).Name = 'A_W_Config_Towns_Add' then
      vWeather.Config.main.Right.Towns.Add_Town_Glow.Enabled := False
    else if TText(Sender).Name = 'A_W_Config_Towns_Lock' then
      vWeather.Config.main.Right.Towns.EditLock_Glow.Enabled := False
    else if TText(Sender).Name = 'A_W_Config_Towns_PosUp' then
      vWeather.Config.main.Right.Towns.GoUp_Glow.Enabled := False
    else if TText(Sender).Name = 'A_W_Config_Towns_PosDown' then
      vWeather.Config.main.Right.Towns.GoDown_Glow.Enabled := False
    else if TImage(Sender).Name = 'A_W_Config_Towns_Refresh' then
      vWeather.Config.main.Right.Towns.Refresh_Glow.Enabled := False
    else if TImage(Sender).Name = 'A_W_Config_Towns_Delete' then
      vWeather.Config.main.Right.Towns.Delete_Glow.Enabled := False
  end
  else if extrafe.prog.state = 'addon_weather_config_towns_add' then
  begin
    if TText(Sender).Name = 'A_W_Config_Towns_Add_Search' then
      vWeather.Config.main.Right.Towns.Add.main.Search_Glow.Enabled := False;
  end;
end;

///

{ TWEATHER_ADDON_CONFIG_BUTTON }

procedure TWEATHER_ADDON_CONFIG_BUTTON.OnMouseClick(Sender: TObject);
begin
  if extrafe.prog.state = 'addon_weather_config' then
  begin
    if TButton(Sender).Name = 'A_W_Config_Left_Button_'+ TButton(Sender).Tag.ToString then
      uWeather_Config_ShowPanel(TButton(Sender).Tag);
  end
  else if extrafe.prog.state = 'addon_weather_config_towns_add' then
  begin
    if TButton(Sender).Name = 'A_W_Config_Towns_Add_Add' then
      uWeather_Config_Towns_Add.New_Town(vWeather.Config.main.Right.Towns.Add.main.Grid.Selected, False)
    else if TButton(Sender).Name = 'A_W_Config_Towns_Add_AddStay' then
      uWeather_Config_Towns_Add.New_Town(vWeather.Config.main.Right.Towns.Add.main.Grid.Selected, True)
    else if TButton(Sender).Name = 'A_W_Config_Towns_Add_Cancel' then
      uWeather_Config_Towns_Add.Free;
  end
end;

procedure TWEATHER_ADDON_CONFIG_BUTTON.OnMouseEnter(Sender: TObject);
begin
  TButton(Sender).Cursor:= crHandPoint;
end;

procedure TWEATHER_ADDON_CONFIG_BUTTON.OnMouseLeave(Sender: TObject);
begin

end;

{ TWEATHER_ADDON_CONFIG_CHECKBOX }

procedure TWEATHER_ADDON_CONFIG_CHECKBOX.OnMouseClick(Sender: TObject);
begin
  if TCheckBox(Sender).Name = 'Weather_Config_Provider_yahoo_CheckBox' then
    uWeather_Config_Provider.Check_Yahoo
  else if TCheckBox(Sender).Name = 'Weather_Config_Provider_openweathermap_CheckBox' then
    uWeather_Config_Provider.Check_OpenWeatherMap
end;

procedure TWEATHER_ADDON_CONFIG_CHECKBOX.OnMouseEnter(Sender: TObject);
begin
  TCheckBox(Sender).Cursor := crHandPoint;
end;

procedure TWEATHER_ADDON_CONFIG_CHECKBOX.OnMouseLeave(Sender: TObject);
begin

end;

initialization

addons.weather.Input.mouse_config.Text := TWEATHER_ADDON_CONFIG_TEXT.Create;
addons.weather.Input.mouse_config.Button := TWEATHER_ADDON_CONFIG_BUTTON.Create;
addons.weather.Input.mouse_config.Checkbox := TWEATHER_ADDON_CONFIG_CHECKBOX.Create;

finalization

addons.weather.Input.mouse_config.Text.Free;
addons.weather.Input.mouse_config.Button.Free;
addons.weather.Input.mouse_config.Checkbox.Free;

end.
