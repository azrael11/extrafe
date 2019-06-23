unit uWeather_Config_Options;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  FMX.StdCtrls,
  FMX.Types,
  FMX.Edit;

procedure uWeather_Config_Options_Show;
procedure uWeather_Config_Options_Free;

function uWeather_Config_Options_CalcDegree(vIsCelcius: Boolean; vCurrent: String): String;
procedure uWeather_Config_Options_UseDegree(vDegreeType: String);

procedure uWeather_Config_Options_Refresh(vOnce: Boolean);

implementation

uses
  uLoad,
  uLoad_AllTypes,
  uSnippet_Text,
  uWeather_Actions,
  uWeather_AllTypes,
  uWeather_SetAll,
  uWeather_Providers_Yahoo_Config;

procedure uWeather_Config_Options_Show;
begin
  if addons.weather.Action.Provider <> '' then
  begin
    if addons.weather.Action.Provider = 'yahoo' then
      uWeather_Providers_Yahoo_Config.Create_Options
    else if addons.weather.Action.Provider = 'openweathermap' then
    begin
      vWeather.Config.Main.Right.Panels[2] := TPanel.Create(vWeather.Config.Main.Right.Panel);
      vWeather.Config.Main.Right.Panels[2].Name := 'Weather_Config_Panels_2';
      vWeather.Config.Main.Right.Panels[2].Parent := vWeather.Config.Main.Right.Panel;
      vWeather.Config.Main.Right.Panels[2].Align := TAlignLayout.Client;
      vWeather.Config.Main.Right.Panels[2].Visible := True;

      vWeather.Config.Main.Right.Options_OWM.Degree := TGroupBox.Create(vWeather.Config.Main.Right.Panels[2]);
      vWeather.Config.Main.Right.Options_OWM.Degree.Name := 'Weather_Config_Options_Degree_Groupbox';
      vWeather.Config.Main.Right.Options_OWM.Degree.Parent := vWeather.Config.Main.Right.Panels[2];
      vWeather.Config.Main.Right.Options_OWM.Degree.SetBounds(10, 10, vWeather.Config.Main.Right.Panels[2].Width - 20, 100);
      vWeather.Config.Main.Right.Options_OWM.Degree.Text := 'Temperature unit';
      vWeather.Config.Main.Right.Options_OWM.Degree.Visible := True;

      vWeather.Config.Main.Right.Options_OWM.Degree_C := TCheckBox.Create(vWeather.Config.Main.Right.Options_OWM.Degree);
      vWeather.Config.Main.Right.Options_OWM.Degree_C.Name := 'Weather_Config_Options_Degree_Celcius_Checkbox';
      vWeather.Config.Main.Right.Options_OWM.Degree_C.Parent := vWeather.Config.Main.Right.Options_OWM.Degree;
      if addons.weather.Action.Provider = 'yahoo' then
        vWeather.Config.Main.Right.Options_OWM.Degree_C.SetBounds(10, 40, 200, 20)
      else if addons.weather.Action.Provider = 'openweathermap' then
        vWeather.Config.Main.Right.Options_OWM.Degree_C.SetBounds(10, 40, 100, 20);
      vWeather.Config.Main.Right.Options_OWM.Degree_C.Text := 'Celcius';
      vWeather.Config.Main.Right.Options_OWM.Degree_C.Font.Style := vWeather.Config.Main.Right.Options_OWM.Degree_C.Font.Style + [TFontStyle.fsBold];
      vWeather.Config.Main.Right.Options_OWM.Degree_C.OnClick := addons.weather.Input.mouse.Checkbox.OnMouseClick;
      vWeather.Config.Main.Right.Options_OWM.Degree_C.OnMouseEnter := addons.weather.Input.mouse.Checkbox.OnMouseEnter;
      vWeather.Config.Main.Right.Options_OWM.Degree_C.OnMouseLeave := addons.weather.Input.mouse.Checkbox.OnMouseLeave;
      vWeather.Config.Main.Right.Options_OWM.Degree_C.Visible := True;

      vWeather.Config.Main.Right.Options_OWM.Degree_F := TCheckBox.Create(vWeather.Config.Main.Right.Options_OWM.Degree);
      vWeather.Config.Main.Right.Options_OWM.Degree_F.Name := 'Weather_Config_Options_Degree_Fahrenheit_Checkbox';
      vWeather.Config.Main.Right.Options_OWM.Degree_F.Parent := vWeather.Config.Main.Right.Options_OWM.Degree;
      if addons.weather.Action.Provider = 'yahoo' then
        vWeather.Config.Main.Right.Options_OWM.Degree_F.SetBounds(vWeather.Config.Main.Right.Options_OWM.Degree.Width - 210, 40, 200, 20)
      else if addons.weather.Action.Provider = 'openweathermap' then
        vWeather.Config.Main.Right.Options_OWM.Degree_F.SetBounds((vWeather.Config.Main.Right.Options_OWM.Degree.Width / 2) - 50, 40, 100, 20);
      vWeather.Config.Main.Right.Options_OWM.Degree_F.Text := 'Fahrenheit';
      vWeather.Config.Main.Right.Options_OWM.Degree_F.Font.Style := vWeather.Config.Main.Right.Options_OWM.Degree_F.Font.Style + [TFontStyle.fsBold];
      vWeather.Config.Main.Right.Options_OWM.Degree_F.OnClick := addons.weather.Input.mouse.Checkbox.OnMouseClick;
      vWeather.Config.Main.Right.Options_OWM.Degree_F.OnMouseEnter := addons.weather.Input.mouse.Checkbox.OnMouseEnter;
      vWeather.Config.Main.Right.Options_OWM.Degree_F.OnMouseLeave := addons.weather.Input.mouse.Checkbox.OnMouseLeave;
      vWeather.Config.Main.Right.Options_OWM.Degree_F.Visible := True;

      if addons.weather.Action.Provider = 'openweathermap' then
      begin
        vWeather.Config.Main.Right.Options_OWM.Degree_K := TCheckBox.Create(vWeather.Config.Main.Right.Options_OWM.Degree);
        vWeather.Config.Main.Right.Options_OWM.Degree_K.Name := 'Weather_Config_Options_Degree_Kelvin_Checkbox';
        vWeather.Config.Main.Right.Options_OWM.Degree_K.Parent := vWeather.Config.Main.Right.Options_OWM.Degree;
        vWeather.Config.Main.Right.Options_OWM.Degree_K.SetBounds(vWeather.Config.Main.Right.Options_OWM.Degree.Width - 160, 40, 100, 20);
        vWeather.Config.Main.Right.Options_OWM.Degree_K.Text := 'Kelvin';
        vWeather.Config.Main.Right.Options_OWM.Degree_K.Align := TAlignLayout.Right;
        vWeather.Config.Main.Right.Options_OWM.Degree_K.Font.Style := vWeather.Config.Main.Right.Options_OWM.Degree_F.Font.Style + [TFontStyle.fsBold];
        vWeather.Config.Main.Right.Options_OWM.Degree_K.OnClick := addons.weather.Input.mouse.Checkbox.OnMouseClick;
        vWeather.Config.Main.Right.Options_OWM.Degree_K.OnMouseEnter := addons.weather.Input.mouse.Checkbox.OnMouseEnter;
        vWeather.Config.Main.Right.Options_OWM.Degree_K.OnMouseLeave := addons.weather.Input.mouse.Checkbox.OnMouseLeave;
        vWeather.Config.Main.Right.Options_OWM.Degree_K.Visible := True;
      end;

      vWeather.Config.Main.Right.Options_OWM.Refresh := TGroupBox.Create(vWeather.Config.Main.Right.Panels[2]);
      vWeather.Config.Main.Right.Options_OWM.Refresh.Name := 'Weather_Config_Options_Refresh_Groupbox';
      vWeather.Config.Main.Right.Options_OWM.Refresh.Parent := vWeather.Config.Main.Right.Panels[2];
      vWeather.Config.Main.Right.Options_OWM.Refresh.SetBounds(10, 130, vWeather.Config.Main.Right.Panels[2].Width - 20, 100);
      vWeather.Config.Main.Right.Options_OWM.Refresh.Text := 'Refresh Options';
      vWeather.Config.Main.Right.Options_OWM.Refresh.Visible := True;

      vWeather.Config.Main.Right.Options_OWM.Refresh_Every := TCheckBox.Create(vWeather.Config.Main.Right.Options_OWM.Refresh);
      vWeather.Config.Main.Right.Options_OWM.Refresh_Every.Name := 'Weather_Config_Options_Refresh_Every_Checkbox';
      vWeather.Config.Main.Right.Options_OWM.Refresh_Every.Parent := vWeather.Config.Main.Right.Options_OWM.Refresh;
      vWeather.Config.Main.Right.Options_OWM.Refresh_Every.SetBounds(10, 40, 250, 20);
      vWeather.Config.Main.Right.Options_OWM.Refresh_Every.Text := 'Every time open the weather addon';
      vWeather.Config.Main.Right.Options_OWM.Refresh_Every.Font.Style := vWeather.Config.Main.Right.Options_OWM.Refresh_Every.Font.Style + [TFontStyle.fsBold];
      vWeather.Config.Main.Right.Options_OWM.Refresh_Every.OnClick := addons.weather.Input.mouse.Checkbox.OnMouseClick;
      vWeather.Config.Main.Right.Options_OWM.Refresh_Every.OnMouseEnter := addons.weather.Input.mouse.Checkbox.OnMouseEnter;
      vWeather.Config.Main.Right.Options_OWM.Refresh_Every.OnMouseLeave := addons.weather.Input.mouse.Checkbox.OnMouseLeave;
      vWeather.Config.Main.Right.Options_OWM.Refresh_Every.Visible := True;

      vWeather.Config.Main.Right.Options_OWM.Refresh_Once := TCheckBox.Create(vWeather.Config.Main.Right.Options_OWM.Refresh);
      vWeather.Config.Main.Right.Options_OWM.Refresh_Once.Name := 'Weather_Config_Options_Refresh_Once_Checkbox';
      vWeather.Config.Main.Right.Options_OWM.Refresh_Once.Parent := vWeather.Config.Main.Right.Options_OWM.Refresh;
      vWeather.Config.Main.Right.Options_OWM.Refresh_Once.SetBounds(vWeather.Config.Main.Right.Options_OWM.Refresh.Width - 210, 40, 200, 20);
      vWeather.Config.Main.Right.Options_OWM.Refresh_Once.Text := 'Once when run ExtraFE';
      vWeather.Config.Main.Right.Options_OWM.Refresh_Once.Font.Style := vWeather.Config.Main.Right.Options_OWM.Refresh_Once.Font.Style + [TFontStyle.fsBold];
      vWeather.Config.Main.Right.Options_OWM.Refresh_Once.OnClick := addons.weather.Input.mouse.Checkbox.OnMouseClick;
      vWeather.Config.Main.Right.Options_OWM.Refresh_Once.OnMouseEnter := addons.weather.Input.mouse.Checkbox.OnMouseEnter;
      vWeather.Config.Main.Right.Options_OWM.Refresh_Once.OnMouseLeave := addons.weather.Input.mouse.Checkbox.OnMouseLeave;
      vWeather.Config.Main.Right.Options_OWM.Refresh_Once.Visible := True;

      vWeather.Config.Main.Right.Options_OWM.User_ID := TGroupBox.Create(vWeather.Config.Main.Right.Panels[2]);
      vWeather.Config.Main.Right.Options_OWM.User_ID.Name := 'Weather_Config_Options_UserID_Groupbox';
      vWeather.Config.Main.Right.Options_OWM.User_ID.Parent := vWeather.Config.Main.Right.Panels[2];
      vWeather.Config.Main.Right.Options_OWM.User_ID.SetBounds(10, 240, vWeather.Config.Main.Right.Panels[2].Width - 20, 100);
      vWeather.Config.Main.Right.Options_OWM.User_ID.Text := 'App_ID';
      vWeather.Config.Main.Right.Options_OWM.User_ID.Visible := True;

      vWeather.Config.Main.Right.Options_OWM.Text := TLabel.Create(vWeather.Config.Main.Right.Options_OWM.User_ID);
      vWeather.Config.Main.Right.Options_OWM.Text.Name := 'Weather_Config_Options_UserID_Text';
      vWeather.Config.Main.Right.Options_OWM.Text.Parent := vWeather.Config.Main.Right.Options_OWM.User_ID;
      vWeather.Config.Main.Right.Options_OWM.Text.SetBounds(10, 30, 200, 20);
      vWeather.Config.Main.Right.Options_OWM.Text.Text := 'User_ID : ';
      vWeather.Config.Main.Right.Options_OWM.Text.Visible := True;

      vWeather.Config.Main.Right.Options_OWM.ID := TEdit.Create(vWeather.Config.Main.Right.Options_OWM.User_ID);
      vWeather.Config.Main.Right.Options_OWM.ID.Name := 'Weather_Config_Options_UserID_ID';
      vWeather.Config.Main.Right.Options_OWM.ID.Parent := vWeather.Config.Main.Right.Options_OWM.User_ID;
      vWeather.Config.Main.Right.Options_OWM.ID.SetBounds(70, 35, vWeather.Config.Main.Right.Options_OWM.User_ID.Width - 80, 22);
      vWeather.Config.Main.Right.Options_OWM.ID.Enabled := False;
      vWeather.Config.Main.Right.Options_OWM.ID.Visible := True;

      if addons.weather.Action.Degree = 'Celcius' then
        vWeather.Config.Main.Right.Options_OWM.Degree_C.IsChecked := True
      else if addons.weather.Action.Degree = 'Fahrenheit' then
        vWeather.Config.Main.Right.Options_OWM.Degree_F.IsChecked := True
      else if addons.weather.Action.Degree = 'Kelvin' then
        vWeather.Config.Main.Right.Options_OWM.Degree_K.IsChecked := True;

      if addons.weather.Config.Refresh_Once = False then
        vWeather.Config.Main.Right.Options_OWM.Refresh_Every.IsChecked := True
      else
        vWeather.Config.Main.Right.Options_OWM.Refresh_Once.IsChecked := True;
    end;
  end;
end;

procedure uWeather_Config_Options_Free;
begin
  FreeAndNil(vWeather.Config.Main.Right.Panels[2]);
end;

function uWeather_Config_Options_CalcDegree(vIsCelcius: Boolean; vCurrent: String): String;
var
  vi: Single;
begin
  vi := StrToFloat(vCurrent);
  if vIsCelcius then
    Result := FormatFloat('0', ((vi - 32) * 5) / 9)
  else
    Result := FormatFloat('0', ((vi * 9) / 5) + 32);
end;

procedure uWeather_Config_Options_UseDegree(vDegreeType: String);
var
  vi: integer;
  vCelcius: Boolean;
  vTempUnit: String;
begin
  if vDegreeType <> addons.weather.Action.Degree then
  begin
    if vDegreeType = 'Celcius' then
    begin
      vCelcius := True;
      vTempUnit := 'C';
      vWeather.Config.Main.Right.Options_OWM.Degree_F.IsChecked := False
    end
    else if vDegreeType = 'Fahrenheit' then
    begin
      vCelcius := False;
      vTempUnit := 'F';
      vWeather.Config.Main.Right.Options_OWM.Degree_C.IsChecked := False
    end;

    addons.weather.Action.Degree := vDegreeType;

    for vi := 0 to addons.weather.Action.Active_Total do
    begin
      vWeather.Scene.Tab[vi].General.Temprature.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].General.Temprature.Text);
      vWeather.Scene.Tab[vi].General.Temprature.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].General.Temprature);
      // vWeather.Scene.Tab[vi].General.Temprature_Unit.Text := vTempUnit;
      // vWeather.Scene.Tab[vi].General.Temprature_Unit.Position.X := vWeather.Scene.Tab[vi]
      // .General.Temprature.Position.X + vWeather.Scene.Tab[vi].General.Temprature.Width + 10;

      vWeather.Scene.Tab[vi].Forcast.Current.Low.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Current.Low.Text);
      vWeather.Scene.Tab[vi].Forcast.Current.Low.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Current.Low);
      vWeather.Scene.Tab[vi].Forcast.Current.Low_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Current.Low_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Current.Low.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Current.Low.Width + 4;
      vWeather.Scene.Tab[vi].Forcast.Current.High.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Current.High.Text);
      vWeather.Scene.Tab[vi].Forcast.Current.High.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Current.High);
      vWeather.Scene.Tab[vi].Forcast.Current.High_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Current.High_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Current.High.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Current.High.Width + 4;

      vWeather.Scene.Tab[vi].Forcast.Day_1.Low.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Day_1.Low.Text);
      vWeather.Scene.Tab[vi].Forcast.Day_1.Low.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Day_1.Low);
      vWeather.Scene.Tab[vi].Forcast.Day_1.Low_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Day_1.Low_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Day_1.Low.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Day_1.Low.Width + 4;
      vWeather.Scene.Tab[vi].Forcast.Day_1.High.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Day_1.High.Text);
      vWeather.Scene.Tab[vi].Forcast.Day_1.High.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Day_1.High);
      vWeather.Scene.Tab[vi].Forcast.Day_1.High_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Day_1.High_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Day_1.High.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Day_1.High.Width + 4;

      vWeather.Scene.Tab[vi].Forcast.Day_2.Low.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Day_2.Low.Text);
      vWeather.Scene.Tab[vi].Forcast.Day_2.Low.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Day_2.Low);
      vWeather.Scene.Tab[vi].Forcast.Day_2.Low_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Day_2.Low_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Day_2.Low.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Day_2.Low.Width + 4;
      vWeather.Scene.Tab[vi].Forcast.Day_2.High.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Day_2.High.Text);
      vWeather.Scene.Tab[vi].Forcast.Day_2.High.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Day_2.High);
      vWeather.Scene.Tab[vi].Forcast.Day_2.High_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Day_2.High_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Day_2.High.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Day_2.High.Width + 4;

      vWeather.Scene.Tab[vi].Forcast.Day_3.Low.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Day_3.Low.Text);
      vWeather.Scene.Tab[vi].Forcast.Day_3.Low.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Day_3.Low);
      vWeather.Scene.Tab[vi].Forcast.Day_3.Low_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Day_3.Low_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Day_3.Low.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Day_3.Low.Width + 4;
      vWeather.Scene.Tab[vi].Forcast.Day_3.High.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Day_3.High.Text);
      vWeather.Scene.Tab[vi].Forcast.Day_3.High.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Day_3.High);
      vWeather.Scene.Tab[vi].Forcast.Day_3.High_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Day_3.High_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Day_3.High.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Day_3.High.Width + 4;

      vWeather.Scene.Tab[vi].Forcast.Day_4.Low.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Day_4.Low.Text);
      vWeather.Scene.Tab[vi].Forcast.Day_4.Low.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Day_4.Low);
      vWeather.Scene.Tab[vi].Forcast.Day_4.Low_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Day_4.Low_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Day_4.Low.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Day_4.Low.Width + 4;
      vWeather.Scene.Tab[vi].Forcast.Day_4.High.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Day_4.High.Text);
      vWeather.Scene.Tab[vi].Forcast.Day_4.High.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Day_4.High);
      vWeather.Scene.Tab[vi].Forcast.Day_4.High_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Day_4.High_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Day_4.High.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Day_4.High.Width + 4;

      vWeather.Scene.Tab[vi].Forcast.Day_5.Low.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Day_5.Low.Text);
      vWeather.Scene.Tab[vi].Forcast.Day_5.Low.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Day_5.Low);
      vWeather.Scene.Tab[vi].Forcast.Day_5.Low_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Day_5.Low_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Day_5.Low.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Day_5.Low.Width + 4;
      vWeather.Scene.Tab[vi].Forcast.Day_5.High.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Day_5.High.Text);
      vWeather.Scene.Tab[vi].Forcast.Day_5.High.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Day_5.High);
      vWeather.Scene.Tab[vi].Forcast.Day_5.High_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Day_5.High_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Day_5.High.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Day_5.High.Width + 4;

      vWeather.Scene.Tab[vi].Forcast.Day_6.Low.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Day_6.Low.Text);
      vWeather.Scene.Tab[vi].Forcast.Day_6.Low.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Day_6.Low);
      vWeather.Scene.Tab[vi].Forcast.Day_6.Low_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Day_6.Low_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Day_6.Low.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Day_6.Low.Width + 4;
      vWeather.Scene.Tab[vi].Forcast.Day_6.High.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Day_6.High.Text);
      vWeather.Scene.Tab[vi].Forcast.Day_6.High.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Day_6.High);
      vWeather.Scene.Tab[vi].Forcast.Day_6.High_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Day_6.High_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Day_6.High.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Day_6.High.Width + 4;

      vWeather.Scene.Tab[vi].Forcast.Day_7.Low.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Day_7.Low.Text);
      vWeather.Scene.Tab[vi].Forcast.Day_7.Low.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Day_7.Low);
      vWeather.Scene.Tab[vi].Forcast.Day_7.Low_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Day_7.Low_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Day_7.Low.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Day_7.Low.Width + 4;
      vWeather.Scene.Tab[vi].Forcast.Day_7.High.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Day_7.High.Text);
      vWeather.Scene.Tab[vi].Forcast.Day_7.High.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Day_7.High);
      vWeather.Scene.Tab[vi].Forcast.Day_7.High_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Day_7.High_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Day_7.High.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Day_7.High.Width + 4;

      vWeather.Scene.Tab[vi].Forcast.Day_8.Low.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Day_8.Low.Text);
      vWeather.Scene.Tab[vi].Forcast.Day_8.Low.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Day_8.Low);
      vWeather.Scene.Tab[vi].Forcast.Day_8.Low_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Day_8.Low_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Day_8.Low.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Day_8.Low.Width + 4;
      vWeather.Scene.Tab[vi].Forcast.Day_8.High.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Day_8.High.Text);
      vWeather.Scene.Tab[vi].Forcast.Day_8.High.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Day_8.High);
      vWeather.Scene.Tab[vi].Forcast.Day_8.High_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Day_8.High_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Day_8.High.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Day_8.High.Width + 4;

      vWeather.Scene.Tab[vi].Forcast.Day_9.Low.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Day_9.Low.Text);
      vWeather.Scene.Tab[vi].Forcast.Day_9.Low.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Day_9.Low);
      vWeather.Scene.Tab[vi].Forcast.Day_9.Low_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Day_9.Low_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Day_9.Low.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Day_9.Low.Width + 4;
      vWeather.Scene.Tab[vi].Forcast.Day_9.High.Text := uWeather_Config_Options_CalcDegree(vCelcius, vWeather.Scene.Tab[vi].Forcast.Day_9.High.Text);
      vWeather.Scene.Tab[vi].Forcast.Day_9.High.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vi].Forcast.Day_9.High);
      vWeather.Scene.Tab[vi].Forcast.Day_9.High_TU.Text := vTempUnit;
      vWeather.Scene.Tab[vi].Forcast.Day_9.High_TU.Position.X := vWeather.Scene.Tab[vi].Forcast.Day_9.High.Position.X + vWeather.Scene.Tab[vi]
        .Forcast.Day_9.High.Width + 4;
    end;
    addons.weather.Ini.Ini.WriteString('Options', 'Degree', addons.weather.Action.Degree);
  end
  else
  begin
    if vDegreeType = 'Celcius' then
      vWeather.Config.Main.Right.Options_OWM.Degree_C.IsChecked := not vWeather.Config.Main.Right.Options_OWM.Degree_C.IsChecked
    else if vDegreeType = 'Fahrenheit' then
      vWeather.Config.Main.Right.Options_OWM.Degree_F.IsChecked := not vWeather.Config.Main.Right.Options_OWM.Degree_F.IsChecked;
  end;
end;

procedure uWeather_Config_Options_Refresh(vOnce: Boolean);
begin

end;

end.
