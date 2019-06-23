unit uWeather_Mouse;

interface

uses
  System.Classes,
  System.Types,
  System.Rtti,
  System.SysUtils,
  System.UiTypes,
  FMX.Graphics,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Dialogs,
  FMX.Grid,
  FMX.Layouts,
  System.Threading,
  Bass;

type
  TWEATHER_ADDON_LAYOUT = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TWEATHER_ADDON_PANEL = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TWEATHER_ADDON_TEXT = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TWEATHER_ADDON_TLABEL = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TWEATHER_ADDON_IMAGE = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TWEATHER_ADDON_BUTTON = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TWEATHER_ADDON_STRIGGRID = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TWEATHER_ADDON_CHECKBOX = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TWEATHER_ADDON_TIMER = class(TObject)
    procedure OnTimer(Sender: TObject);
  end;

type
  TWEATHER_MOUSE = record
    Layout: TWEATHER_ADDON_LAYOUT;
    Image: TWEATHER_ADDON_IMAGE;
    Button: TWEATHER_ADDON_BUTTON;
    Panel: TWEATHER_ADDON_PANEL;
    Text: TWEATHER_ADDON_TEXT;
    VLabel: TWEATHER_ADDON_TLABEL;
    Stringgrid: TWEATHER_ADDON_STRIGGRID;
    Checkbox: TWEATHER_ADDON_CHECKBOX;
    Timer: TWEATHER_ADDON_TIMER;
  end;

implementation

uses
  uLoad,
  uLoad_AllTypes,
  main,
  uMain_Actions,
  uWeather_Actions,
  uWeather_AllTypes,
  uWeather_SetAll,
  uWeather_Config,
  uWeather_Config_Provider,
  uWeather_Config_Towns,
  uWeather_Config_Towns_Add,
  uWeather_Config_Towns_Refresh,
  uWeather_Config_Towns_Delete,
  uWeather_Config_Options,
  uWeather_MenuActions,
  uWeather_Config_Iconsets,
  uWeather_Providers_Yahoo;

{ TWEATHER_ADDON_IMAGE }

procedure TWEATHER_ADDON_IMAGE.OnMouseClick(Sender: TObject);
begin
  if extrafe.prog.state = 'addon_weather' then
  begin
    if TImage(Sender).Name = 'A_W_ArrowLeft_Image' then
      uWeather_MenuActions_SlideLeft
    else if TImage(Sender).Name = 'A_W_ArrowRight_Image' then
      uWeather_MenuActions_SlideRight
    else if TImage(Sender).Name = 'A_W_Settings_Image' then
      if not Assigned(vWeather.Scene.First.Panel) then
        uWeather_Config_ShowHide(True)
  end
  else if extrafe.prog.state = 'addon_weather_config' then
  begin
    if TImage(Sender).Name = 'A_W_Settings_Image' then
      uWeather_Config_ShowHide(False)
      // Towns
      // IconSets
      // else if TImage(Sender).TagFloat = 100 then
      // uWeather_Config_Iconsets_UseIconSet(addons.weather.Config.Iconset.Names.Strings[TImage(Sender).Tag])
      // else if TImage(Sender).TagFloat = 101 then
      // uWeather_Config_Iconsets_ShowSet(addons.weather.Config.Iconset.Names.Strings[TSpeedButton(Sender).Tag])
    else if TImage(Sender).Name = 'A_W_Config_Iconsets_Back' then
      uWeather_Config_Iconsets_ReturnToPreview
  end;
end;

procedure TWEATHER_ADDON_IMAGE.OnMouseEnter(Sender: TObject);
begin
  if extrafe.prog.state = 'addon_weather' then
  begin
    if TImage(Sender).Name = 'A_W_ArrowLeft_Image' then
      vWeather.Scene.Arrow_Left_Glow.Enabled := True
    else if TImage(Sender).Name = 'A_W_ArrowRight_Image' then
      vWeather.Scene.Arrow_Right_Glow.Enabled := True
    else if TImage(Sender).Name = 'A_W_Settings_Image' then
      vWeather.Scene.Settings_Glow.Enabled := True;
    TImage(Sender).Cursor := crHandPoint;
  end
  else if extrafe.prog.state = 'addon_weather_config' then
  begin
    if TImage(Sender).Name = 'A_W_Settings_Image' then
      vWeather.Scene.Settings_Glow.Enabled := True
  end;
end;

procedure TWEATHER_ADDON_IMAGE.OnMouseLeave(Sender: TObject);
begin
  if extrafe.prog.state = 'addon_weather' then
  begin
    if TImage(Sender).Name = 'A_W_ArrowLeft_Image' then
      vWeather.Scene.Arrow_Left_Glow.Enabled := False
    else if TImage(Sender).Name = 'A_W_ArrowRight_Image' then
      vWeather.Scene.Arrow_Right_Glow.Enabled := False
    else if TImage(Sender).Name = 'A_W_Settings_Image' then
      vWeather.Scene.Settings_Glow.Enabled := False;
  end
  else if extrafe.prog.state = 'addon_weather_config' then
  begin
    if TImage(Sender).Name = 'A_W_Settings_Image' then
      vWeather.Scene.Settings_Glow.Enabled := False
  end
end;

{ TWEATHER_ADDON_BUTTON }

procedure TWEATHER_ADDON_BUTTON.OnMouseClick(Sender: TObject);
begin
  if extrafe.prog.state = 'addon_weather' then
  begin
    if TButton(Sender).Name = 'A_W_First_Main_Done' then
      FreeAndNil(vWeather.Scene.First.Panel);
  end
  else if extrafe.prog.state = 'addon_weather_config_towns_delete' then
  begin
    if TButton(Sender).Name = 'A_W_Config_Delete_Delete' then
      uWeather_Config_Towns_Delete_Town(addons.weather.Config.Selected_Town)
    else if TButton(Sender).Name = 'A_W_Config_Delete_Cancel' then
      uWeather_Config_Towns_Delete_Free;
  end
  else if extrafe.prog.state = 'addon_weather_config_towns_refresh' then
  begin
    if TButton(Sender).Name = 'A_W_Config_Refresh_Refresh' then
      uWeather_Config_Towns_Edit_Refresh(addons.weather.Config.Selected_Town)
    else if TButton(Sender).Name = 'A_W_Config_Refresh_Cancel' then
      uWeather_Config_Towns_Edit_Refresh_Free;
  end;
end;

procedure TWEATHER_ADDON_BUTTON.OnMouseEnter(Sender: TObject);
begin

end;

procedure TWEATHER_ADDON_BUTTON.OnMouseLeave(Sender: TObject);
begin

end;

{ TWEATHER_ADDON_PANEL }

procedure TWEATHER_ADDON_PANEL.OnMouseClick(Sender: TObject);
begin
  if extrafe.prog.state = 'addon_weather_config' then
  begin
    if TPanel(Sender).TagFloat = 1000 then
    begin
      if addons.weather.Config.Edit_Lock then
        if TPanel(Sender).Tag <> addons.weather.Config.Selected_Town then
          uWeather_Config_Towns_Edit_SelectTown(TPanel(Sender).Tag);
    end
  end;
end;

procedure TWEATHER_ADDON_PANEL.OnMouseEnter(Sender: TObject);
begin
end;

procedure TWEATHER_ADDON_PANEL.OnMouseLeave(Sender: TObject);
begin
end;

{ TWEATHER_ADDON_TEXT }

procedure TWEATHER_ADDON_TEXT.OnMouseClick(Sender: TObject);
begin
  if addons.weather.Action.Provider = 'yahoo' then
  begin
    if TText(Sender).Name = 'A_W_Provider_Yahoo_Unit_F' then
    begin
      if TText(Sender).TextSettings.FontColor = TAlphaColorRec.White then
      begin
        uWeather_Providers_Yahoo.Use_Imperial;
        BASS_ChannelPlay(ex_main.Sounds.mouse[0], False);
      end;
    end
    else if TText(Sender).Name = 'A_W_Provider_Yahoo_Unit_C' then
    begin
      if TText(Sender).TextSettings.FontColor = TAlphaColorRec.White then
      begin
        uWeather_Providers_Yahoo.Use_Metric;
        BASS_ChannelPlay(ex_main.Sounds.mouse[0], False);
      end;
    end
    else if TText(Sender).Name = 'A_W_Provider_Yahoo_Refresh' then
      uWeather_Providers_Yahoo.Refresh_Town(vWeather.Scene.Control.TabIndex)
    else if TText(Sender).Name = 'A_W_Provider_Yahoo_ShowImage' then
      uWeather_Providers_Yahoo.Show_Image
    else if TText(Sender).Name = 'A_W_Provider_Yahoo_Town_Image_Left_Arrow' then
    begin
      if TText(Sender).TextSettings.FontColor <> TAlphaColorRec.Grey then
        uWeather_Providers_Yahoo.Show_Town_Image('previous');
    end
    else if TText(Sender).Name = 'A_W_Provider_Yahoo_Town_Image_Right_Arrow' then
    begin
      if TText(Sender).TextSettings.FontColor <> TAlphaColorRec.Grey then
        uWeather_Providers_Yahoo.Show_Town_Image('next');
    end;
  end
  else if addons.weather.Action.Provider = 'openweathermap' then
  begin

  end;
end;

procedure TWEATHER_ADDON_TEXT.OnMouseEnter(Sender: TObject);
begin
  if TText(Sender).TextSettings.FontColor <> TAlphaColorRec.Grey then
  begin
    if addons.weather.Action.Provider = 'yahoo' then
    begin
      if TText(Sender).Name = 'A_W_Provider_Yahoo_Hourly_Left' then
      begin
        vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].Forecast_Hourly.Left_Glow.Enabled := True;
        uWeather_Providers_Yahoo.Main_Slide('left');
      end
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_Hourly_Right' then
      begin
        vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].Forecast_Hourly.Right_Glow.Enabled := True;
        uWeather_Providers_Yahoo.Main_Slide('right');
      end
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_Daily_Up' then
      begin
        vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].Forecast_Daily.Up_Glow.Enabled := True;
        uWeather_Providers_Yahoo.Main_Slide('up');
      end
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_Daily_Down' then
      begin
        vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].Forecast_Daily.Down_Glow.Enabled := True;
        uWeather_Providers_Yahoo.Main_Slide('down');
      end
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_Unit_F' then
      begin
        if TText(Sender).TextSettings.FontColor <> TAlphaColorRec.Deepskyblue then
        begin
          TText(Sender).Cursor := crHandPoint;
          vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].General.Temprature_Unit_F_Glow.Enabled := True;
        end;
      end
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_Unit_C' then
      begin
        if TText(Sender).TextSettings.FontColor <> TAlphaColorRec.Deepskyblue then
        begin
          TText(Sender).Cursor := crHandPoint;
          vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].General.Temprature_Unit_C_Glow.Enabled := True;
        end;
      end
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_Refresh' then
      begin
        TText(Sender).Cursor := crHandPoint;
        vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].General.Refresh_Glow.Enabled := True;
      end
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_ShowImage' then
      begin
        TText(Sender).Cursor := crHandPoint;
        if vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].General.ShowImage_Blur.Enabled = False then
          vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].General.ShowImage_Glow.Enabled := True;
      end
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_Town_Image_Left_Arrow' then
      begin
        TText(Sender).Cursor := crHandPoint;
        vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].General.Town_Image_Left_Arrow_Glow.Enabled := True;
      end
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_Town_Image_Right_Arrow' then
      begin
        TText(Sender).Cursor := crHandPoint;
        vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].General.Town_Image_Right_Arrow_Glow.Enabled := True;
      end
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_Earth_' + TText(Sender).TagString then
      begin
        TText(Sender).Cursor := crHandPoint;
        vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].General.Earth_Glow.Enabled := True;
      end;
    end
    else if addons.weather.Action.Provider = 'openweathermap' then
    begin

    end;
  end;
end;

procedure TWEATHER_ADDON_TEXT.OnMouseLeave(Sender: TObject);
begin
  if TText(Sender).TextSettings.FontColor <> TAlphaColorRec.Grey then
  begin
    if addons.weather.Action.Provider = 'yahoo' then
    begin
      if TText(Sender).Name = 'A_W_Provider_Yahoo_Hourly_Left' then
      begin
        uWeather_Providers_Yahoo.Main_Slide_Free;
        vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].Forecast_Hourly.Left_Glow.Enabled := False;
      end
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_Hourly_Right' then
      begin
        uWeather_Providers_Yahoo.Main_Slide_Free;
        vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].Forecast_Hourly.Right_Glow.Enabled := False;
      end
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_Daily_Up' then
      begin
        uWeather_Providers_Yahoo.Main_Slide_Free;
        vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].Forecast_Daily.Up_Glow.Enabled := False;
      end
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_Daily_Down' then
      begin
        uWeather_Providers_Yahoo.Main_Slide_Free;
        vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].Forecast_Daily.Down_Glow.Enabled := False;
      end
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_Unit_F' then
      begin
        if TText(Sender).TextSettings.FontColor <> TAlphaColorRec.Deepskyblue then
          vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].General.Temprature_Unit_F_Glow.Enabled := False;
      end
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_Unit_C' then
      begin
        if TText(Sender).TextSettings.FontColor <> TAlphaColorRec.Deepskyblue then
          vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].General.Temprature_Unit_C_Glow.Enabled := False;
      end
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_Refresh' then
        vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].General.Refresh_Glow.Enabled := False
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_ShowImage' then
      begin
        if vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].General.ShowImage_Blur.Enabled = False then
          vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].General.ShowImage_Glow.Enabled := False;
      end
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_Town_Image_Left_Arrow' then
        vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].General.Town_Image_Left_Arrow_Glow.Enabled := False
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_Town_Image_Right_Arrow' then
        vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].General.Town_Image_Right_Arrow_Glow.Enabled := False
      else if TText(Sender).Name = 'A_W_Provider_Yahoo_Earth_' + TText(Sender).TagString then
        vWeather.Scene.Tab[vWeather.Scene.Control.TabIndex].General.Earth_Glow.Enabled := False;
    end;
  end
  else if addons.weather.Action.Provider = 'openweathermap' then
  begin

  end;
end;

{ TWEATHER_ADDON_TLABEL }

procedure TWEATHER_ADDON_TLABEL.OnMouseClick(Sender: TObject);
begin

end;

procedure TWEATHER_ADDON_TLABEL.OnMouseEnter(Sender: TObject);
begin
  if TLabel(Sender).TagFloat = 1000 then
  begin
    vWeather.Config.main.Right.Towns.Town[TLabel(Sender).Tag].Glow_Panel.Enabled := True;
  end;
end;

procedure TWEATHER_ADDON_TLABEL.OnMouseLeave(Sender: TObject);
begin
  if TLabel(Sender).TagFloat = 1000 then
  begin
    vWeather.Config.main.Right.Towns.Town[TLabel(Sender).Tag].Glow_Panel.Enabled := False;
  end;
end;

{ TWEATHER_ADDON_STRIGGRID }

procedure TWEATHER_ADDON_STRIGGRID.OnMouseClick(Sender: TObject);
begin
  if TStringGrid(Sender).Name = 'Weather_Config_AddTown_StringGrid' then
  begin
    vSelectedTown := TStringGrid(Sender).Selected;
    vWeather.Config.main.Right.Towns.Add.Panel.Enabled := True;
  end;
end;

procedure TWEATHER_ADDON_STRIGGRID.OnMouseEnter(Sender: TObject);
begin

end;

procedure TWEATHER_ADDON_STRIGGRID.OnMouseLeave(Sender: TObject);
begin

end;

{ TWEATHER_ADDON_CHECKBOX }

procedure TWEATHER_ADDON_CHECKBOX.OnMouseClick(Sender: TObject);
begin

end;

procedure TWEATHER_ADDON_CHECKBOX.OnMouseEnter(Sender: TObject);
begin

end;

procedure TWEATHER_ADDON_CHECKBOX.OnMouseLeave(Sender: TObject);
begin

end;

{ TWEATHER_ADDON_TIMER }

procedure TWEATHER_ADDON_TIMER.OnTimer(Sender: TObject);
begin

end;

{ TWEATHER_ADDON_LAYOUT }

procedure TWEATHER_ADDON_LAYOUT.OnMouseClick(Sender: TObject);
begin

end;

procedure TWEATHER_ADDON_LAYOUT.OnMouseEnter(Sender: TObject);
begin
end;

procedure TWEATHER_ADDON_LAYOUT.OnMouseLeave(Sender: TObject);
begin
end;

initialization

addons.weather.Input.mouse.Layout := TWEATHER_ADDON_LAYOUT.Create;
addons.weather.Input.mouse.Image := TWEATHER_ADDON_IMAGE.Create;
addons.weather.Input.mouse.Button := TWEATHER_ADDON_BUTTON.Create;
addons.weather.Input.mouse.Panel := TWEATHER_ADDON_PANEL.Create;
addons.weather.Input.mouse.Text := TWEATHER_ADDON_TEXT.Create;
addons.weather.Input.mouse.VLabel := TWEATHER_ADDON_TLABEL.Create;
addons.weather.Input.mouse.Stringgrid := TWEATHER_ADDON_STRIGGRID.Create;
addons.weather.Input.mouse.Checkbox := TWEATHER_ADDON_CHECKBOX.Create;
addons.weather.Input.mouse.Timer := TWEATHER_ADDON_TIMER.Create;

finalization

addons.weather.Input.mouse.Layout.Free;
addons.weather.Input.mouse.Image.Free;
addons.weather.Input.mouse.Button.Free;
addons.weather.Input.mouse.Panel.Free;
addons.weather.Input.mouse.Text.Free;
addons.weather.Input.mouse.VLabel.Free;
addons.weather.Input.mouse.Stringgrid.Free;
addons.weather.Input.mouse.Checkbox.Free;
addons.weather.Input.mouse.Timer.Free;

end.
