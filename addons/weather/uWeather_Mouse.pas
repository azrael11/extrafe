unit uWeather_Mouse;

interface

uses
  System.Classes,
  System.Types,
  System.Rtti,
  System.SysUtils,
  FMX.Graphics,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Dialogs,
  FMX.Grid,
  System.UITypes,
  System.Threading;

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
  uWeather_Config_Iconsets;

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
    else if TImage(Sender).Name = 'A_W_Config_Towns_Add' then
    begin
      if vWeather.Config.main.Right.Towns.Add_Town_Grey.Enabled = False then
        uWeather_Config_Towns_Add_Load;
    end
    else if TImage(Sender).Name = 'A_W_Config_Towns_Lock' then
      uWeather_Config_Towns_Edit(not addons.weather.Config.Edit_Lock)
    else if TImage(Sender).Name = 'A_W_Config_Towns_Refresh' then
      uWeather_Config_Towns_Edit_Refresh_Show
    else if TImage(Sender).Name = 'A_W_Config_Towns_PosUp' then
    begin
      if vWeather.Config.main.Right.Towns.GoUp_Grey.Enabled = False then
        uWeather_Config_Towns_TownGoUp;
    end
    else if TImage(Sender).Name = 'A_W_Config_Towns_PosDown' then
    begin
      if vWeather.Config.main.Right.Towns.GoDown_Grey.Enabled = False then
        uWeather_Config_Towns_TownGoDown;
    end
    else if TImage(Sender).Name = 'A_W_Config_Towns_Delete' then
    begin
      if addons.weather.Config.Edit_Lock then
        uWeather_Config_Towns_Edit_Delete_Show
    end
    // IconSets
    else if TImage(Sender).TagFloat = 100 then
      uWeather_Config_Iconsets_UseIconSet(addons.weather.Config.Iconset.Names.Strings[TImage(Sender).Tag])
    else if TImage(Sender).TagFloat = 101 then
      uWeather_Config_Iconsets_ShowSet(addons.weather.Config.Iconset.Names.Strings[TSpeedButton(Sender).Tag])
    else if TImage(Sender).Name = 'A_W_Config_Iconsets_Back' then
      uWeather_Config_Iconsets_ReturnToPreview
  end
  else if extrafe.prog.state = 'addon_weather_config_towns_add' then
  begin
    if TImage(Sender).Name = 'A_W_Config_Towns_Add_Search' then
      uWeather_Config_Towns_Add_FindTown(vWeather.Config.main.Right.Towns.Add.main.FindTown_V.Text);
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
  end
  else if extrafe.prog.state = 'addon_weather_config' then
  begin
    if TImage(Sender).Name = 'A_W_Settings_Image' then
      vWeather.Scene.Settings_Glow.Enabled := True
      // Towns
    else if TImage(Sender).Name = 'A_W_Config_Towns_Add' then
    begin
      if vWeather.Config.main.Right.Towns.Add_Town_Grey.Enabled = False then
        vWeather.Config.main.Right.Towns.Add_Town_Glow.Enabled := True
    end
    else if TImage(Sender).Name = 'A_W_Config_Towns_Lock' then
      vWeather.Config.main.Right.Towns.EditLock_Glow.Enabled := True
    else if TImage(Sender).Name = 'A_W_Config_Towns_PosUp' then
    begin
      if vWeather.Config.main.Right.Towns.GoUp_Grey.Enabled = False then
        vWeather.Config.main.Right.Towns.GoUp_Glow.Enabled := True;
    end
    else if TImage(Sender).Name = 'A_W_Config_Towns_PosDown' then
    begin
      if vWeather.Config.main.Right.Towns.GoDown_Grey.Enabled = False then
        vWeather.Config.main.Right.Towns.GoDown_Glow.Enabled := True;
    end
    else if TImage(Sender).Name = 'A_W_Config_Towns_Refresh' then
    begin
      if vWeather.Config.main.Right.Towns.Refresh_Grey.Enabled = False then
        vWeather.Config.main.Right.Towns.Refresh_Glow.Enabled := True;
    end
    else if TImage(Sender).Name = 'A_W_Config_Towns_Delete' then
    begin
      if vWeather.Config.main.Right.Towns.Delete_Grey.Enabled = False then
        vWeather.Config.main.Right.Towns.Delete_Glow.Enabled := True;
    end
    // Iconsets
    else if TImage(Sender).TagFloat = 100 then
      vWeather.Config.main.Right.Iconsets.Mini[TImage(Sender).Tag].Panel_Glow.Enabled := True
    else if TImage(Sender).TagFloat = 101 then
      uWeather_Config_Iconsets_GlowPreview(TImage(Sender).Tag, True)
    else if TImage(Sender).Name = 'A_W_Config_Iconsets_Back' then
      vWeather.Config.main.Right.Iconsets.Full.Back_Glow.Enabled := True;
  end
  else if extrafe.prog.state = 'addon_weather_config_towns_add' then
  begin
    if TImage(Sender).Name = 'A_W_Config_Towns_Add_Search' then
      vWeather.Config.main.Right.Towns.Add.main.Search_Glow.Enabled := True;
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
      // Towns
    else if TImage(Sender).Name = 'A_W_Config_Towns_Add' then
    begin
      if vWeather.Config.main.Right.Towns.Add_Town_Grey.Enabled = False then
        vWeather.Config.main.Right.Towns.Add_Town_Glow.Enabled := False
    end
    else if TImage(Sender).Name = 'A_W_Config_Towns_Lock' then
      vWeather.Config.main.Right.Towns.EditLock_Glow.Enabled := False
    else if TImage(Sender).Name = 'A_W_Config_Towns_PosUp' then
    begin
      if vWeather.Config.main.Right.Towns.GoUp_Grey.Enabled = False then
        vWeather.Config.main.Right.Towns.GoUp_Glow.Enabled := False;
    end
    else if TImage(Sender).Name = 'A_W_Config_Towns_PosDown' then
    begin
      if vWeather.Config.main.Right.Towns.GoDown_Grey.Enabled = False then
        vWeather.Config.main.Right.Towns.GoDown_Glow.Enabled := False;
    end
    else if TImage(Sender).Name = 'A_W_Config_Towns_Refresh' then
    begin
      if vWeather.Config.main.Right.Towns.Refresh_Grey.Enabled = False then
        vWeather.Config.main.Right.Towns.Refresh_Glow.Enabled := False;
    end
    else if TImage(Sender).Name = 'A_W_Config_Towns_Delete' then
    begin
      if vWeather.Config.main.Right.Towns.Delete_Grey.Enabled = False then
        vWeather.Config.main.Right.Towns.Delete_Glow.Enabled := False;
    end
    // Iconsets
    else if TImage(Sender).TagFloat = 100 then
      vWeather.Config.main.Right.Iconsets.Mini[TImage(Sender).Tag].Panel_Glow.Enabled := False
    else if TImage(Sender).TagFloat = 101 then
      uWeather_Config_Iconsets_GlowPreview(TImage(Sender).Tag, False)
    else if TImage(Sender).Name = 'A_W_Config_Iconsets_Back' then
      vWeather.Config.main.Right.Iconsets.Full.Back_Glow.Enabled := False;
  end
  else if extrafe.prog.state = 'addon_weather_config_towns_add' then
  begin
    if TImage(Sender).Name = 'A_W_Config_Towns_Add_Search' then
      vWeather.Config.main.Right.Towns.Add.main.Search_Glow.Enabled := False;
  end;
end;

{ TWEATHER_ADDON_BUTTON }

procedure TWEATHER_ADDON_BUTTON.OnMouseClick(Sender: TObject);
begin
  if extrafe.prog.state = 'addon_weather' then
  begin
    if TButton(Sender).Name = 'A_W_First_Main_Done' then
      FreeAndNil(vWeather.Scene.First.Panel);
  end
  else if extrafe.prog.state = 'addon_weather_config' then
  begin
    if TButton(Sender).Name = 'A_W_Config_Left_Button_0' then
      uWeather_Config_ShowPanel(0)
    else if TButton(Sender).Name = 'A_W_Config_Left_Button_1' then
      uWeather_Config_ShowPanel(1)
    else if TButton(Sender).Name = 'A_W_Config_Left_Button_2' then
      uWeather_Config_ShowPanel(2)
    else if TButton(Sender).Name = 'A_W_Config_Left_Button_3' then
      uWeather_Config_ShowPanel(3)
  end
  else if extrafe.prog.state = 'addon_weather_config_towns_add' then
  begin
    if TButton(Sender).Name = 'A_W_Config_Towns_Add_Add' then
      uWeather_Config_Towns_Add_AddTown(False)
    else if TButton(Sender).Name = 'A_W_Config_Towns_Add_AddStay' then
      uWeather_Config_Towns_Add_AddTown(True)
    else if TButton(Sender).Name = 'A_W_Config_Towns_Add_Cancel' then
      uWeather_Config_Towns_Add_Free;
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
  if extrafe.prog.state = 'addon_weather_config' then
  begin
    if TPanel(Sender).TagFloat = 1000 then
    begin
      if addons.weather.Config.Edit_Lock then
      begin
        if TPanel(Sender).Tag <> addons.weather.Config.Selected_Town then
          vWeather.Config.main.Right.Towns.Town[TPanel(Sender).Tag].Glow_Panel.Enabled := True
      end
      else
        vWeather.Config.main.Right.Towns.Town[TPanel(Sender).Tag].Glow_Panel.Enabled := True
    end
    else if TPanel(Sender).TagFloat = 100 then
      vWeather.Config.main.Right.Iconsets.Mini[TPanel(Sender).Tag].Panel_Glow.Enabled := True;
  end;
end;

procedure TWEATHER_ADDON_PANEL.OnMouseLeave(Sender: TObject);
begin
  if extrafe.prog.state = 'addon_weather_config' then
  begin
    if TPanel(Sender).TagFloat = 1000 then
    begin
      if addons.weather.Config.Edit_Lock then
      begin
        if TPanel(Sender).Tag <> addons.weather.Config.Selected_Town then
          vWeather.Config.main.Right.Towns.Town[TPanel(Sender).Tag].Glow_Panel.Enabled := False
      end
      else
        vWeather.Config.main.Right.Towns.Town[TPanel(Sender).Tag].Glow_Panel.Enabled := False
    end
    else if TPanel(Sender).TagFloat = 100 then
      vWeather.Config.main.Right.Iconsets.Mini[TPanel(Sender).Tag].Panel_Glow.Enabled := False;
  end;
end;

{ TWEATHER_ADDON_TEXT }

procedure TWEATHER_ADDON_TEXT.OnMouseClick(Sender: TObject);
begin

end;

procedure TWEATHER_ADDON_TEXT.OnMouseEnter(Sender: TObject);
begin

end;

procedure TWEATHER_ADDON_TEXT.OnMouseLeave(Sender: TObject);
begin

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
  if TCheckBox(Sender).Name = 'Weather_Config_Provider_yahoo_CheckBox' then
    uWeather_Config_Provider_YahooCheck
  else if TCheckBox(Sender).Name= 'Weather_Config_Provider_openweathermap_CheckBox'  then
    uWeather_Config_Provider_OpenWeatherMapCheck
  else if TCheckBox(Sender).Name = 'Weather_Config_Options_Degree_Celcius_Checkbox' then
    uWeather_Config_Options_UseDegree(vWeather.Config.main.Right.Options.Degree_C.Text)
  else if TCheckBox(Sender).Name = 'Weather_Config_Options_Degree_Fahrenheit_Checkbox' then
    uWeather_Config_Options_UseDegree(vWeather.Config.main.Right.Options.Degree_F.Text)
  else if TCheckBox(Sender).Name = 'Weather_Config_Options_Refresh_Every_Checkbox' then
    uWeather_Config_Options_Refresh(False)
  else if TCheckBox(Sender).Name = 'Weather_Config_Options_Refresh_Once_Checkbox' then
    uWeather_Config_Options_Refresh(True)
  else if TCheckBox(Sender).Name = 'A_W_First_Main_Check' then
    uWeather_Actions_CheckFirst(not addons.weather.Action.First);
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
  if Assigned(vTask) then
  begin
    if not(vTask.Status = Ttaskstatus.Running) then
    begin
      vTaskTimer.Enabled := False;
      uWeather_Actions_ShowTheForcast;
    end;
  end;
end;

initialization

addons.weather.Input.mouse.Image := TWEATHER_ADDON_IMAGE.Create;
addons.weather.Input.mouse.Button := TWEATHER_ADDON_BUTTON.Create;
addons.weather.Input.mouse.Panel := TWEATHER_ADDON_PANEL.Create;
addons.weather.Input.mouse.Text := TWEATHER_ADDON_TEXT.Create;
addons.weather.Input.mouse.VLabel := TWEATHER_ADDON_TLABEL.Create;
addons.weather.Input.mouse.Stringgrid := TWEATHER_ADDON_STRIGGRID.Create;
addons.weather.Input.mouse.Checkbox := TWEATHER_ADDON_CHECKBOX.Create;
addons.weather.Input.mouse.Timer := TWEATHER_ADDON_TIMER.Create;

finalization

addons.weather.Input.mouse.Image.Free;
addons.weather.Input.mouse.Button.Free;
addons.weather.Input.mouse.Panel.Free;
addons.weather.Input.mouse.Text.Free;
addons.weather.Input.mouse.VLabel.Free;
addons.weather.Input.mouse.Stringgrid.Free;
addons.weather.Input.mouse.Checkbox.Free;
addons.weather.Input.mouse.Timer.Free;

end.
