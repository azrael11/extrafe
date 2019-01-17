unit uWeather_Config_Provider;

interface

uses
  System.Classes,
  System.UiTypes,
  System.SysUtils,
  FMX.StdCtrls,
  FMX.Types,
  FMX.Objects,
  FMX.Layouts,
  ALFmxObjects;

procedure uWeather_Config_Provider_Show;
procedure uWeather_Config_Provider_Create(vName: String; vNum: Integer);
procedure uWeather_Config_Provider_Free;

procedure uWeather_Config_Provider_YahooCheck;

implementation

uses
  uload,
  uLoad_AllTypes,
  main,
  uWeather_AllTypes,
  uWeather_SetAll;

procedure uWeather_Config_Provider_Create(vName: String; vNum: Integer);
begin
  vWeather.Config.main.Right.Provider.Prov[vNum].Panel :=
    TPanel.Create(vWeather.Config.main.Right.Provider.Box);
  vWeather.Config.main.Right.Provider.Prov[vNum].Panel.Name := 'Weather_Config_Provider_' + vName;
  vWeather.Config.main.Right.Provider.Prov[vNum].Panel.Parent := vWeather.Config.main.Right.Provider.Box;
  vWeather.Config.main.Right.Provider.Prov[vNum].Panel.SetBounds(10, 10 + (vNum * 100),
    vWeather.Config.main.Right.Provider.Box.Width - 20, 90);
  vWeather.Config.main.Right.Provider.Prov[vNum].Panel.Visible := True;

  vWeather.Config.main.Right.Provider.Prov[vNum].Check :=
    TCheckBox.Create(vWeather.Config.main.Right.Provider.Prov[vNum].Panel);
  vWeather.Config.main.Right.Provider.Prov[vNum].Check.Name := 'Weather_Config_Provider_' + vName +
    '_CheckBox';
  vWeather.Config.main.Right.Provider.Prov[vNum].Check.Parent := vWeather.Config.main.Right.Provider.Prov
    [vNum].Panel;
  vWeather.Config.main.Right.Provider.Prov[vNum].Check.SetBounds(5, 35, 20, 20);
  vWeather.Config.main.Right.Provider.Prov[vNum].Check.OnClick :=
    addons.weather.Input.mouse.Checkbox.OnMouseClick;
  vWeather.Config.main.Right.Provider.Prov[vNum].Check.OnMouseEnter :=
    addons.weather.Input.mouse.Checkbox.OnMouseEnter;
  vWeather.Config.main.Right.Provider.Prov[vNum].Check.OnMouseLeave :=
    addons.weather.Input.mouse.Checkbox.OnMouseLeave;
  vWeather.Config.main.Right.Provider.Prov[vNum].Check.Visible := True;

  vWeather.Config.main.Right.Provider.Prov[vNum].Icon :=
    TImage.Create(vWeather.Config.main.Right.Provider.Prov[vNum].Panel);
  vWeather.Config.main.Right.Provider.Prov[vNum].Icon.Name := 'Weather_Config_Provider_' + vName + '_Image';
  vWeather.Config.main.Right.Provider.Prov[vNum].Icon.Parent := vWeather.Config.main.Right.Provider.Prov
    [vNum].Panel;
  vWeather.Config.main.Right.Provider.Prov[vNum].Icon.SetBounds(25, 10, 140, 70);
  vWeather.Config.main.Right.Provider.Prov[vNum].Icon.Bitmap.LoadFromFile
    (addons.weather.Path.Images + 'w_provider_' + vName + '.png');
  vWeather.Config.main.Right.Provider.Prov[vNum].Icon.Visible := True;

  vWeather.Config.main.Right.Provider.Prov[vNum].Desc :=
    TALText.Create(vWeather.Config.main.Right.Provider.Prov[vNum].Panel);
  vWeather.Config.main.Right.Provider.Prov[vNum].Desc.Name := 'Weather_Config_Provider_' + vName + 'Desc';
  vWeather.Config.main.Right.Provider.Prov[vNum].Desc.Parent :=
    vWeather.Config.main.Right.Provider.Prov[vNum].Panel;
  vWeather.Config.main.Right.Provider.Prov[vNum].Desc.SetBounds(180, 5, vWeather.Config.main.Right.Provider.Prov[vNum].Panel.Width- 180, 80);
  vWeather.Config.main.Right.Provider.Prov[vNum].Desc.TextIsHtml:= True;
  vWeather.Config.main.Right.Provider.Prov[vNum].Desc.WordWrap:= True;
  vWeather.Config.main.Right.Provider.Prov[vNum].Desc.Color:= TAlphaColorRec.White;
  vWeather.Config.main.Right.Provider.Prov[vNum].Desc.TextSettings.HorzAlign:= TTextAlign.Leading;
  if vName= 'yahoo' then  
  vWeather.Config.main.Right.Provider.Prov[vNum].Desc.Text:= 'Yahoo Weather! provides up to 255 towns and a 10 days forecast. '+ #13#10 +
   'Provides Units, wind, atmoshpere, astronomy in to formats XML or Json. You choose witch in option menu.'
  else if vName= 'openweathermap' then
  vWeather.Config.main.Right.Provider.Prov[vNum].Desc.Text:= 'OpenWeatherMap provides up to 255 towns and a 5 days/3 Hours forecast. '+ #13#10 +
   'Provides Units + (kelvin), wind, atmoshpere, astronomy in to formats XML or Json. You choose witch in option menu.';
  vWeather.Config.main.Right.Provider.Prov[vNum].Desc.Visible := True;
end;

procedure uWeather_Config_Provider_Show;
var
  vi: Integer;
begin
  vWeather.Config.main.Right.Panels[0] := TPanel.Create(vWeather.Config.main.Right.Panel);
  vWeather.Config.main.Right.Panels[0].Name := 'Weather_Config_Panels_0';
  vWeather.Config.main.Right.Panels[0].Parent := vWeather.Config.main.Right.Panel;
  vWeather.Config.main.Right.Panels[0].Align := TAlignLayout.Client;
  vWeather.Config.main.Right.Panels[0].Visible := True;

  vWeather.Config.main.Right.Provider.Choose := TLabel.Create(vWeather.Config.main.Right.Panels[0]);
  vWeather.Config.main.Right.Provider.Choose.Name := 'Weather_Config_Provider_Choose_Label';
  vWeather.Config.main.Right.Provider.Choose.Parent := vWeather.Config.main.Right.Panels[0];
  vWeather.Config.main.Right.Provider.Choose.SetBounds(10, 10, 300, 20);
  vWeather.Config.main.Right.Provider.Choose.Text := 'Choose "Provider" from the list below.';
  vWeather.Config.main.Right.Provider.Choose.Font.Style :=
    vWeather.Config.main.Right.Provider.Choose.Font.Style + [TFontStyle.fsBold];
  vWeather.Config.main.Right.Provider.Choose.Visible := True;

  vWeather.Config.main.Right.Provider.Box := TVertScrollBox.Create(vWeather.Config.main.Right.Panels[0]);
  vWeather.Config.main.Right.Provider.Box.Name := 'Weather_Config_Provider_Box';
  vWeather.Config.main.Right.Provider.Box.Parent := vWeather.Config.main.Right.Panels[0];
  vWeather.Config.main.Right.Provider.Box.SetBounds(10, 25, vWeather.Config.main.Right.Panels[0].Width - 20,
    vWeather.Config.main.Right.Panels[0].Height - 35);
  vWeather.Config.main.Right.Provider.Box.Visible := True;

  for vi := 0 to 1 do
  begin
    if vi = 0 then
      uWeather_Config_Provider_Create('yahoo', vi)
    else
      uWeather_Config_Provider_Create('openweathermap', vi)
  end;

  vWeather.Config.main.Right.Provider.Text := TLabel.Create(vWeather.Config.main.Right.Panels[0]);
  vWeather.Config.main.Right.Provider.Text.Name := 'Weather_Config_Provider_Label';
  vWeather.Config.main.Right.Provider.Text.Parent := vWeather.Config.main.Right.Panels[0];
  vWeather.Config.main.Right.Provider.Text.SetBounds(10, vWeather.Config.main.Right.Panels[0].Height -
    30, 300, 20);
  vWeather.Config.main.Right.Provider.Text.Text := 'Selected "Provider" : ' + addons.weather.Action.Provider;
  vWeather.Config.main.Right.Provider.Text.Font.Style := vWeather.Config.main.Right.Provider.Text.Font.Style +
    [TFontStyle.fsBold];
  vWeather.Config.main.Right.Provider.Text.Visible := True;

  { if addons.Weather.Action.Provider = 'Yahoo' then
    vWeather.Config.Main.Right.Provider.Yahoo_Check.IsChecked := True; }
end;

procedure uWeather_Config_Provider_Free;
begin
  FreeAndNil(vWeather.Config.main.Right.Panels[0]);
end;

procedure uWeather_Config_Provider_YahooCheck;
begin
  { if vWeather.Config.main.Right.Provider.Yahoo_Check.IsChecked = False then
    begin
    addons.weather.Ini.Ini.WriteString('Provider', 'Name', 'Yahoo');
    addons.weather.Action.Provider := 'Yahoo';
    vWeather.Config.main.Right.Provider.Text.Text := 'Selected "Provider" : ' +
    addons.weather.Action.Provider;
    end
    else
    vWeather.Config.main.Right.Provider.Yahoo_Check.IsChecked :=
    not vWeather.Config.main.Right.Provider.Yahoo_Check.IsChecked; }
end;

end.
