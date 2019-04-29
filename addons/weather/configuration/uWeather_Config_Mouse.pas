unit uWeather_Config_Mouse;

interface

uses
  System.Classes,
  System.UiTypes,
  FMX.Objects;

type
  TWEATHER_ADDON_TEXT = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TWEATHER_CONFIG_MOUSE = record
    Text: TWEATHER_ADDON_TEXT;
  end;

implementation

uses
  uLoad_AllTypes,
  uWeather_AllTypes,
  uWeather_Config_Towns,
  uWeather_Config_Towns_Delete,
  uWeather_Config_Towns_Refresh,
  uWeather_Config_Towns_Add;

{ TWEATHER_ADDON_TEXT }

procedure TWEATHER_ADDON_TEXT.OnMouseClick(Sender: TObject);
begin
  if TText(Sender).TextSettings.FontColor = TAlphaColorRec.Deepskyblue then
  begin
    if extrafe.prog.state = 'addon_weather_config' then
    begin
      if TText(Sender).Name = 'A_W_Config_Towns_Add' then
        uWeather_Config_Towns_Add_Load
      else if TText(Sender).Name = 'A_W_Config_Towns_Lock' then
        uWeather_Config_Towns_Edit(not addons.weather.Config.Edit_Lock)
      else if TImage(Sender).Name = 'A_W_Config_Towns_PosUp' then
        uWeather_Config_Towns_TownGoUp
      else if TImage(Sender).Name = 'A_W_Config_Towns_PosDown' then
        uWeather_Config_Towns_TownGoDown
      else if TImage(Sender).Name = 'A_W_Config_Towns_Refresh' then
        uWeather_Config_Towns_Edit_Refresh_Show
      else if TImage(Sender).Name = 'A_W_Config_Towns_Delete' then
        uWeather_Config_Towns_Edit_Delete_Show
    end;
  end;
end;

procedure TWEATHER_ADDON_TEXT.OnMouseEnter(Sender: TObject);
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
    end;
    TText(Sender).Cursor := crHandPoint;
  end;
end;

procedure TWEATHER_ADDON_TEXT.OnMouseLeave(Sender: TObject);
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
  end;
end;

///

initialization

addons.weather.Input.mouse_config.Text := TWEATHER_ADDON_TEXT.Create;

finalization

addons.weather.Input.mouse_config.Text.Free;

end.
