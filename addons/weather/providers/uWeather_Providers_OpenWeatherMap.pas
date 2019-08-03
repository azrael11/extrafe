unit uWeather_Providers_OpenWeatherMap;

interface

uses
  System.Classes,
  System.SysUtils,
  System.DateUtils,
  System.UiTypes,
  System.JSON,
  FMX.Graphics,
  FMX.Types,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Ani,
  FMX.Controls,
  FMX.Dialogs,
  FMX.Effects,
  IPPeerClient,
  REST.Client,
  REST.Types,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  ALFMXTabControl,
  uWeather_AllTypes;

type
  TWEATHER_PROVIDER_OPENWEATHERMAP_FIND_LIST = record
    woeid: string;
    country: string;
    country_code: string;
    city: string;
    text: string;
  end;

type
  TWEATHER_PROVIDER_OPENWEATHERMAP_TIME = record
    Full: String;
    Time: String;
    Date: String;
  end;

type
  TWEATHER_PROVIDER_OPENWEATHERMAP_ICON_TYPE = record
    text: String;
    bitmap: TBitmap;
  end;

const
  cAuthor_OWM_APPID = '5f1cc9b837706de78648b1de3443ccce';

procedure Main_Create_Towns;

procedure Main_Create_Town(vTown: TADDON_WEATHER_PROVIDER_OPENWEATHERMAP_DATATOWN; vTab: Integer);
procedure Main_Create_Hourly(vTown: TADDON_WEATHER_PROVIDER_OPENWEATHERMAP_DATATOWN; vTab: Integer);

procedure Load;

function Get_Forecast(vNum: Integer; vWoeid: String): TADDON_WEATHER_PROVIDER_OPENWEATHERMAP_DATATOWN;

function Get_Icon_From_Text(vConditionID: String): String;
function Get_Language_Num(vLanguage: String): Integer;
function Get_Language_From_Short_Desc(vShort_Desk: String): String;
function ConvertTime(vUnixTime, Quotes: String): TWEATHER_PROVIDER_OPENWEATHERMAP_TIME;
function Get_Icon_Text(vCode_ID, vIcon: String): String;
function Get_Flag(vCountry: String): TBitmap;
function Get_Icon_Time(vTime: String): String;
function Convert_Wind(vWind: Integer): Single;
Procedure Set_Lengauge_Text(vLanguage_Index: Integer);

procedure uWeather_Providers_OpenWeatherMap_Load_Config;

procedure Woeid_List;

procedure Find_Woeid_Locations(vText: String);
procedure Show_Locations;

function Is_Town_Exists(vWoeid: String): Boolean;

// procedure uWeather_Providers_OpenWeatherMap_AddTown_Main(vTabNum: Integer; vTown_Day: TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP;
// vTown_Hour: TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP_DAYS);

procedure Add_NewTown(vNum: Integer);
procedure uWeather_Providers_OpenWeatherMap_CreateConfigPanel(vNum: Integer);

function uWeather_Providers_OpenWeatherMap_Unit: String;
function uWeatehr_Providers_OpenWeatherMap_Unit_Word: String;

var
  vRESTClient: TRESTClient;
  vRESTRequest: TRESTRequest;
  vRESTResponse: TRESTResponse;
  vJSONValue: TJSONValue;

  vOpenWeatherMap_Find_List: array [0 .. 100] of TWEATHER_PROVIDER_OPENWEATHERMAP_FIND_LIST;
  vFound_Locations: Integer;

implementation

uses
  uLoad_AllTypes,
  uSnippet_Text,
  uInternet_Files,
  uWeather_Config_Towns,
  uWeather_Convert,
  uWeather_MenuActions,
  uWeather_Actions,
  uWeather_Config_Towns_Add,
  uSnippet_Convert,
  uWeather_Providers_OpenWeatherMap_Config;

procedure Find_Woeid_Locations(vText: String);
var
  vOutValue: String;
  vCount: String;
  vi: Integer;
begin
  vJSONValue := TJSONValue.Create;
  vJSONValue := uInternet_Files.Get_JSONValue('OpenWeatherMap', 'http://api.geonames.org/searchJSON?name_equals=' + vText + '&username=azrael11');

  vCount := vJSONValue.GetValue<String>('totalResultsCount');
  vFound_Locations := vCount.ToInteger;

  for vi := 0 to vFound_Locations - 1 do
  begin
    vOpenWeatherMap_Find_List[vi].woeid := vJSONValue.GetValue<String>('geonames[' + vi.ToString + '].geonameId');
    vOpenWeatherMap_Find_List[vi].city := vJSONValue.GetValue<String>('geonames[' + vi.ToString + '].name');
    vOpenWeatherMap_Find_List[vi].country := vJSONValue.GetValue<String>('geonames[' + vi.ToString + '].countryName');
    vOpenWeatherMap_Find_List[vi].country_code := vJSONValue.GetValue<String>('geonames[' + vi.ToString + '].countryCode');
    vOpenWeatherMap_Find_List[vi].text := vJSONValue.GetValue<String>('geonames[' + vi.ToString + '].adminName1');
  end;
end;

procedure Show_Locations;
var
  vi: Integer;
  vCodeFlag: Integer;
begin
  if vFound_Locations - 1 > -1 then
  begin
    for vi := 0 to vFound_Locations - 1 do
    begin
      vWeather.Config.main.Right.Towns.Add.main.Grid.Cells[0, vi] := (vi + 1).ToString;
      vCodeFlag := vCodes.IndexOf(LowerCase(vOpenWeatherMap_Find_List[vi].country_code) + '.png');
      vWeather.Config.main.Right.Towns.Add.main.Grid.Cells[1, vi] := vCodeFlag.ToString;
      vWeather.Config.main.Right.Towns.Add.main.Grid.Cells[2, vi] := vOpenWeatherMap_Find_List[vi].city;
      vWeather.Config.main.Right.Towns.Add.main.Grid.Cells[3, vi] := vOpenWeatherMap_Find_List[vi].text;
      vWeather.Config.main.Right.Towns.Add.main.Grid.Cells[4, vi] := vOpenWeatherMap_Find_List[vi].country;
    end;
    vWeather.Config.main.Right.Towns.Add.main.Grid.Selected := 0;
    DeleteFile(extrafe.prog.Path + cTemp_Towns);
    vWeather.Config.main.Right.Towns.Add.main.Add.Enabled := True;
    vWeather.Config.main.Right.Towns.Add.main.Add_Stay.Enabled := True;
  end
  else
  begin
    vWeather.Config.main.Right.Towns.Add.main.Add.Enabled := false;
    vWeather.Config.main.Right.Towns.Add.main.Add_Stay.Enabled := false;
  end;
  FreeAndNil(vJSONValue);
end;

procedure Main_Create_Towns;
var
  vi: Integer;
  vBackground: TImage;
  vProgress: TProgressBar;
  vProgress_Text: TText;
  vIcon: TText;
  vText: TText;
  vProgress_Num: Single;
begin
  if addons.weather.Action.OWM.Total_WoeID <> -1 then
  begin
    vBackground := TImage.Create(vWeather.Scene.Back);
    vBackground.Name := 'A_W_Providers_OpenWeatherMap_Loading_Background';
    vBackground.Parent := vWeather.Scene.Back;
    vBackground.SetBounds(0, 10, vWeather.Scene.Back.Width, vWeather.Scene.Back.Height);
    vBackground.bitmap.LoadFromFile(addons.weather.Path.Images + 'w_openweather_loading.png');
    vBackground.WrapMode := TImageWrapMode.Original;
    vBackground.Visible := True;

    vText := TText.Create(vWeather.Scene.Back);
    vText.Name := 'A_W_Providers_OpenWeatherMap_Loading_Please_Wait';
    vText.Parent := vWeather.Scene.Back;
    vText.SetBounds(50, 80, 400, 50);
    vText.Font.Family := 'Tahoma';
    vText.Font.Size := 38;
    vText.text := 'Please Wait...';
    vText.TextSettings.FontColor := TAlphaColorRec.White;
    vText.HorzTextAlign := TTextAlign.Center;
    vText.Visible := True;

    vIcon := TText.Create(vWeather.Scene.Back);
    vIcon.Name := 'A_W_Providers_OpenWeatherMap_Loading_Icon';
    vIcon.Parent := vWeather.Scene.Back;
    vIcon.SetBounds(extrafe.res.Half_Width - 40, vWeather.Scene.Back.Height - 400, 100, 100);
    vIcon.Font.Family := 'Weather Icons';
    vIcon.Font.Size := 72;
    vIcon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vIcon.text := Get_Icon_From_Text(Random(47).ToString);
    vIcon.Visible := True;

    vProgress_Text := TText.Create(vWeather.Scene.Back);
    vProgress_Text.Name := 'A_W_Providers_OpenWeatherMap_Loading_Progress_Text';
    vProgress_Text.Parent := vWeather.Scene.Back;
    vProgress_Text.SetBounds(300, vWeather.Scene.Back.Height - 300, 1320, 50);
    vProgress_Text.Font.Family := 'Tahoma';
    vProgress_Text.Font.Size := 24;
    vProgress_Text.text := '';
    vProgress_Text.TextSettings.FontColor := TAlphaColorRec.White;
    vProgress_Text.HorzTextAlign := TTextAlign.Leading;
    vProgress_Text.Visible := True;

    vProgress := TProgressBar.Create(vWeather.Scene.Back);
    vProgress.Name := 'A_W_Providers_OpenWeatherMap_Loading_Progress';
    vProgress.Parent := vWeather.Scene.Back;
    vProgress.SetBounds(300, vWeather.Scene.Back.Height - 250, 1320, 30);
    vProgress.Max := 100;
    vProgress.Min := 0;
    vProgress.Value := 0;
    vProgress.Visible := True;

    vProgress_Num := 100 / addons.weather.Action.OWM.Total_WoeID;
    for vi := 0 to addons.weather.Action.OWM.Total_WoeID do
    begin

    end;
  end
  else
  begin
    vWeather.Scene.Back.bitmap.LoadFromFile(addons.weather.Path.Images + 'w_addtowns.png');
  end;
end;

procedure Main_Create_Hourly(vTown: TADDON_WEATHER_PROVIDER_OPENWEATHERMAP_DATATOWN; vTab: Integer);
begin

end;

procedure Main_Create_Town(vTown: TADDON_WEATHER_PROVIDER_OPENWEATHERMAP_DATATOWN; vTab: Integer);
begin
  vWeather.Scene.Tab_OMP[vTab].Tab := TALTabItem.Create(vWeather.Scene.Control);
  vWeather.Scene.Tab_OMP[vTab].Tab.Name := 'A_W_WeatherTab_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Tab.Parent := vWeather.Scene.Control;
  vWeather.Scene.Tab_OMP[vTab].Tab.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F.Name := 'A_W_Provider_OpenWeatherMap_Unit_F';
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F.SetBounds(16, 90, 42, 42);
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F.Font.Size := 36;
  if addons.weather.Action.Yahoo.Selected_Unit = 'imperial' then
    vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F.Color := TAlphaColorRec.Deepskyblue
  else
    vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F.text := #$f045;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F.OnClick := addons.weather.Input.mouse.text.OnMouseClick;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F.OnMouseEnter := addons.weather.Input.mouse.text.OnMouseEnter;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F.OnMouseLeave := addons.weather.Input.mouse.text.OnMouseLeave;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F_Glow := TGlowEffect.Create(vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F);
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F_Glow.Name := 'A_W_Provider_OpenWeatherMap_Unit_F_Glow';
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F_Glow.Parent := vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F_Glow.Opacity := 0.9;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F_Glow.Softness := 0.4;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_F_Glow.Enabled := false;

  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C.Name := 'A_W_Provider_OpenWeatherMap_Unit_C';
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C.SetBounds(16, 140, 42, 42);
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C.Font.Size := 36;
  if addons.weather.Action.Yahoo.Selected_Unit = 'metric' then
    vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C.Color := TAlphaColorRec.Deepskyblue
  else
    vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C.text := #$f03c;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C.OnClick := addons.weather.Input.mouse.text.OnMouseClick;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C.OnMouseEnter := addons.weather.Input.mouse.text.OnMouseEnter;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C.OnMouseLeave := addons.weather.Input.mouse.text.OnMouseLeave;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C_Glow := TGlowEffect.Create(vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C);
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C_Glow.Name := 'A_W_Provider_OpenWeatherMap_C_Glow';
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C_Glow.Parent := vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C_Glow.Opacity := 0.9;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C_Glow.Softness := 0.4;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature_Unit_C_Glow.Enabled := false;

  vWeather.Scene.Tab_OMP[vTab].General.Date := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].General.Date.Name := 'A_W_Provider_OpenWeatherMap_Date_' + vTab.ToString;
  vWeather.Scene.Tab_OMP[vTab].General.Date.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].General.Date.SetBounds(16, 10, 300, 30);
  vWeather.Scene.Tab_OMP[vTab].General.Date.text := ConvertTime(vTown.Current.date_time, '/').Date;
  vWeather.Scene.Tab_OMP[vTab].General.Date.Font.Size := 18;
  vWeather.Scene.Tab_OMP[vTab].General.Date.TextSettings.FontColor := TAlphaColorRec.White;
  vWeather.Scene.Tab_OMP[vTab].General.Date.HorzTextAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_OMP[vTab].General.Date.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].General.Time := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].General.Time.Name := 'A_W_Provider_OpenWeatherMap_Time_' + vTab.ToString;
  vWeather.Scene.Tab_OMP[vTab].General.Time.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].General.Time.SetBounds(440, 10, 100, 30);
  vWeather.Scene.Tab_OMP[vTab].General.Time.text := FormatDateTime('hh:mm', Now);
  vWeather.Scene.Tab_OMP[vTab].General.Time.Font.Size := 18;
  vWeather.Scene.Tab_OMP[vTab].General.Time.TextSettings.FontColor := TAlphaColorRec.White;
  vWeather.Scene.Tab_OMP[vTab].General.Time.HorzTextAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_OMP[vTab].General.Time.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].General.Time_Icon := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].General.Time_Icon.Name := 'A_W_Provider_OpenWeatherMap_Time_Icon_' + vTab.ToString;
  vWeather.Scene.Tab_OMP[vTab].General.Time_Icon.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].General.Time_Icon.SetBounds(416, 10, 32, 32);
  vWeather.Scene.Tab_OMP[vTab].General.Time_Icon.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_OMP[vTab].General.Time_Icon.text := Get_Icon_Time(FormatDateTime('hh', Now) + ':00');
  vWeather.Scene.Tab_OMP[vTab].General.Time_Icon.Font.Size := 24;
  vWeather.Scene.Tab_OMP[vTab].General.Time_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_OMP[vTab].General.Time_Icon.HorzTextAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_OMP[vTab].General.Time_Icon.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].General.Text_Image := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].General.Text_Image.Name := 'A_W_Provider_OpenWeatherMap_Yahoo_Text_Image_' + vTab.ToString;
  vWeather.Scene.Tab_OMP[vTab].General.Text_Image.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].General.Text_Image.SetBounds(50, 60, 150, 150);
  vWeather.Scene.Tab_OMP[vTab].General.Text_Image.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_OMP[vTab].General.Text_Image.Font.Size := 72;
  vWeather.Scene.Tab_OMP[vTab].General.Text_Image.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_OMP[vTab].General.Text_Image.text := Get_Icon_Text(vTown.Current.weather.ID, vTown.Current.weather.Icon);
  vWeather.Scene.Tab_OMP[vTab].General.Text_Image.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].General.Temprature := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].General.Temprature.Name := 'A_W_Provider_OpenWeatherMap_Temprature_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].General.Temprature.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature.SetBounds(220, 100, 120, 50);
  vWeather.Scene.Tab_OMP[vTab].General.Temprature.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_OMP[vTab].General.Temprature.Font.Size := 48;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature.Color := TAlphaColorRec.White;
//  if addons.weather.Action.Yahoo.Selected_Unit = 'imperial' then
//    vWeather.Scene.Tab[vTab].General.Temprature.Text := vTown.Observation.Tempreture.Now + '' + #$f042
//  else if addons.weather.Action.Yahoo.Selected_Unit = 'metric' then
  vWeather.Scene.Tab_OMP[vTab].General.Temprature.Text := vTown.Current.main.Temp + '' + #$f042;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_OMP[vTab].General.Temprature.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].General.Thermometer := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].General.Thermometer.Name := 'A_W_Provider_OpenWeatherMap_Thermometer';
  vWeather.Scene.Tab_OMP[vTab].General.Thermometer.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].General.Thermometer.SetBounds(320, 110, 60, 60);
  vWeather.Scene.Tab_OMP[vTab].General.Thermometer.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_OMP[vTab].General.Thermometer.Font.Size := 48;
  vWeather.Scene.Tab_OMP[vTab].General.Thermometer.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_OMP[vTab].General.Thermometer.Text := #$f055;
  vWeather.Scene.Tab_OMP[vTab].General.Thermometer.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].General.Low_Icon := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].General.Low_Icon.Name := 'A_W_Provider_OpenWeatherMap_Low_Icon';
  vWeather.Scene.Tab_OMP[vTab].General.Low_Icon.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].General.Low_Icon.SetBounds(350, 128, 60, 60);
  vWeather.Scene.Tab_OMP[vTab].General.Low_Icon.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_OMP[vTab].General.Low_Icon.Font.Size := 24;
  vWeather.Scene.Tab_OMP[vTab].General.Low_Icon.Color := TAlphaColorRec.Whitesmoke;
  vWeather.Scene.Tab_OMP[vTab].General.Low_Icon.Text := #$f044;
  vWeather.Scene.Tab_OMP[vTab].General.Low_Icon.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].General.Low := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].General.Low.Name := 'A_W_Provider_OpenWeatherMap_Low';
  vWeather.Scene.Tab_OMP[vTab].General.Low.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].General.Low.SetBounds(370, 142, 70, 30);
  vWeather.Scene.Tab_OMP[vTab].General.Low.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_OMP[vTab].General.Low.Font.Size := 16;
  vWeather.Scene.Tab_OMP[vTab].General.Low.Color := TAlphaColorRec.Whitesmoke;
//  if addons.weather.Action.Yahoo.Selected_Unit = 'imperial' then
//    vWeather.Scene.Tab[vTab].General.Low.Text := vTown.Observation.Tempreture.Low + #$f042
//  else if addons.weather.Action.Yahoo.Selected_Unit = 'metric' then
  vWeather.Scene.Tab_OMP[vTab].General.Low.Text := vTown.Five.list[0].main.Temp_Min + #$f042;
  vWeather.Scene.Tab_OMP[vTab].General.Low.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].General.High_Icon := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].General.High_Icon.Name := 'A_W_Provider_OpenWeatherMap_High_Icon';
  vWeather.Scene.Tab_OMP[vTab].General.High_Icon.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].General.High_Icon.SetBounds(350, 90, 60, 60);
  vWeather.Scene.Tab_OMP[vTab].General.High_Icon.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_OMP[vTab].General.High_Icon.Font.Size := 24;
  vWeather.Scene.Tab_OMP[vTab].General.High_Icon.Color := TAlphaColorRec.Red;
  vWeather.Scene.Tab_OMP[vTab].General.High_Icon.Text := #$f058;
  vWeather.Scene.Tab_OMP[vTab].General.High_Icon.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].General.High := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].General.High.Name := 'A_W_Provider_OpenWeatherMap_High';
  vWeather.Scene.Tab_OMP[vTab].General.High.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].General.High.SetBounds(370, 104, 70, 30);
  vWeather.Scene.Tab_OMP[vTab].General.High.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_OMP[vTab].General.High.Font.Size := 16;
  vWeather.Scene.Tab_OMP[vTab].General.High.Color := TAlphaColorRec.Red;
//  if addons.weather.Action.Yahoo.Selected_Unit = 'imperial' then
//    vWeather.Scene.Tab[vTab].General.High.Text := vTown.Observation.Tempreture.High + #$f042
//  else if addons.weather.Action.Yahoo.Selected_Unit = 'metric' then
  vWeather.Scene.Tab_OMP[vTab].General.High.Text := vTown.Five.list[0].main.Temp_Max + #$f042;
  vWeather.Scene.Tab_OMP[vTab].General.High.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].General.Condtition := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].General.Condtition.Name := 'A_W_Provider_OpenWeatherMap_Condtition_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].General.Condtition.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].General.Condtition.SetBounds(60, 200, 600, 30);
  vWeather.Scene.Tab_OMP[vTab].General.Condtition.Font.Size := 16;
  vWeather.Scene.Tab_OMP[vTab].General.Condtition.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_OMP[vTab].General.Condtition.Text := vTown.Current.weather.description;
  vWeather.Scene.Tab_OMP[vTab].General.Condtition.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_OMP[vTab].General.Condtition.Tag := vTab;
  vWeather.Scene.Tab_OMP[vTab].General.Condtition.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Wind.Text := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Wind.Text.Name := 'A_W_Provider_OpenWeatherMap_Wind_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Wind.Text.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Wind.Text.SetBounds(160, 350, 32, 32);
  vWeather.Scene.Tab_OMP[vTab].Wind.Text.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_OMP[vTab].Wind.Text.Font.Size := 26;
  vWeather.Scene.Tab_OMP[vTab].Wind.Text.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_OMP[vTab].Wind.Text.Text := #$f050;
  vWeather.Scene.Tab_OMP[vTab].Wind.Text.Visible := True;
  vWeather.Scene.Tab_OMP[vTab].Wind.Text.Width := 80;

  vWeather.Scene.Tab_OMP[vTab].Wind.Speed := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Wind.Speed.Name := 'A_W_Provider_OpenWeatherMap_WindSpeed' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Wind.Speed.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Wind.Speed.SetBounds(130, 404, 200, 30);
  vWeather.Scene.Tab_OMP[vTab].Wind.Speed.Font.Size := 16;
  vWeather.Scene.Tab_OMP[vTab].Wind.Speed.Color := TAlphaColorRec.White;
//  if addons.weather.Action.Yahoo.Selected_Unit = 'imperial' then
//    vWeather.Scene.Tab[vTab].Wind.Speed.Text := 'Speed : ' + vTown.Observation.WindSpeed + ' mph'
//  else if addons.weather.Action.Yahoo.Selected_Unit = 'metric' then
  vWeather.Scene.Tab_OMP[vTab].Wind.Speed.Text := 'Speed : ' + vTown.Current.Wind.Speed + ' kmph';
  vWeather.Scene.Tab_OMP[vTab].Wind.Speed.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_OMP[vTab].Wind.Speed.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Wind.Direction := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Wind.Direction.Name := 'A_W_Provider_OpenWeatherMap_WindDiretion' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Wind.Direction.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Wind.Direction.SetBounds(160, 380, 200, 30);
  vWeather.Scene.Tab_OMP[vTab].Wind.Direction.Font.Size := 16;
  vWeather.Scene.Tab_OMP[vTab].Wind.Direction.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_OMP[vTab].Wind.Direction.Text := vTown.Current.Wind.degree;
  vWeather.Scene.Tab_OMP[vTab].Wind.Direction.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_OMP[vTab].Wind.Direction.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Wind.Direction_Arrow := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Wind.Direction_Arrow.Name := 'A_W_Provider_OpenWeatherMap_WindDirection_Arrow' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Wind.Direction_Arrow.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Wind.Direction_Arrow.SetBounds(240, 360, 32, 32);
  vWeather.Scene.Tab_OMP[vTab].Wind.Direction_Arrow.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_OMP[vTab].Wind.Direction_Arrow.Font.Size := 26;
  vWeather.Scene.Tab_OMP[vTab].Wind.Direction_Arrow.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_OMP[vTab].Wind.Direction_Arrow.Text := #$f0b1;
  vWeather.Scene.Tab_OMP[vTab].Wind.Direction_Arrow.RotationAngle := StrToFloat(vTown.Current.Wind.degree);
  vWeather.Scene.Tab_OMP[vTab].Wind.Direction_Arrow.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small_Stand := TImage.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small_Stand.Name := 'A_W_Provider_OpenWeatherMap_Wind_Small_Turbine_Stand_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small_Stand.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small_Stand.SetBounds(100, 360, 43, 52);
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small_Stand.WrapMode := TImageWrapMode.Fit;
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small_Stand.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_stand.png');
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small_Stand.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small := TImage.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small.Name := 'A_W_Provider_OpenWeatherMap_Wind_Small_Turbine_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small.SetBounds(94, 335, 54, 54);
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small.WrapMode := TImageWrapMode.Stretch;
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_turbine.png');
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small_Animation := TFloatAnimation.Create(vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small);
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small_Animation.Name := 'A_W_Provider_OpenWeatherMap_Wind_Small_Turbine_Animation_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small_Animation.Parent := vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small;
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small_Animation.PropertyName := 'RotationAngle';
  if addons.weather.Action.Yahoo.Selected_Unit = 'imperial' then
    vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small_Animation.Duration := Convert_Wind((Round(StrToFloat(vTown.Current.Wind.Speed) * 1.8)))
  else if addons.weather.Action.Yahoo.Selected_Unit = 'metric' then
    vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small_Animation.Duration := Convert_Wind(Round(vTown.Current.Wind.Speed.ToSingle));
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small_Animation.StartValue := 0;
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small_Animation.StopValue := 360;
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small_Animation.Loop := True;
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Small_Animation.Enabled := True;

  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Stand := TImage.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Stand.Name := 'A_W_Provider_OpenWeatherMap_Wind_Turbine_Stand_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Stand.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Stand.SetBounds(60, 370, 53, 64);
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Stand.WrapMode := TImageWrapMode.Fit;
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Stand.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_stand.png');
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Stand.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine := TImage.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine.Name := 'A_W_Provider_OpenWeatherMap_Wind_Turbine_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine.SetBounds(54, 335, 64, 64);
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine.WrapMode := TImageWrapMode.Stretch;
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_turbine.png');
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Animation := TFloatAnimation.Create(vWeather.Scene.Tab_OMP[vTab].Wind.Turbine);
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Animation.Name := 'A_W_Provider_OpenWeatherMap_Wind_Turbine_Animation_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Animation.Parent := vWeather.Scene.Tab_OMP[vTab].Wind.Turbine;
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Animation.PropertyName := 'RotationAngle';
  if addons.weather.Action.Yahoo.Selected_Unit = 'imperial' then
    vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Animation.Duration := Convert_Wind((Round(StrToFloat(vTown.Current.Wind.Speed) * 1.8) - 1))
  else if addons.weather.Action.Yahoo.Selected_Unit = 'metric' then
    vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Animation.Duration := Convert_Wind(Round(vTown.Current.Wind.Speed.ToSingle));
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Animation.StartValue := 0;
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Animation.StopValue := 360;
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Animation.Loop := True;
  vWeather.Scene.Tab_OMP[vTab].Wind.Turbine_Animation.Enabled := True;

  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure_Icon := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure_Icon.Name := 'A_W_Provider_OpenWeatherMap_Atmosphere_Pressure_Icon' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure_Icon.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure_Icon.SetBounds(60, 470, 32, 32);
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure_Icon.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure_Icon.Font.Size := 26;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure_Icon.Text := #$f079;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure_Icon.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure.Name := 'A_W_Provider_OpenWeatherMap_Atmosphere_Pressure' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure.SetBounds(100, 470, 200, 30);
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure.Font.Size := 16;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure.Color := TAlphaColorRec.White;
  if addons.weather.Action.Yahoo.Selected_Unit = 'imperial' then
    vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure.Text := vTown.Current.main.Pressure + ' inHg'
  else if addons.weather.Action.Yahoo.Selected_Unit = 'metric' then
    vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure.Text := vTown.Current.main.Pressure + ' mb';
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure.Tag := vTab;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Pressure.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Humidity_Icon := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Humidity_Icon.Name := 'A_W_Provider_OpenWeatherMap_Atmosphere_Humidity_Icon_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Humidity_Icon.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Humidity_Icon.SetBounds(60, 550, 32, 32);
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Humidity_Icon.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Humidity_Icon.Font.Size := 26;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Humidity_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Humidity_Icon.Text := #$f07a;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Humidity_Icon.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Humidity := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Humidity.Name := 'A_W_Provider_OpenWeatherMap_Atmosphere_Humidity' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Humidity.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Humidity.SetBounds(100, 550, 200, 30);
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Humidity.Font.Size := 16;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Humidity.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Humidity.Text := vTown.Current.main.Humidity + '%';
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Humidity.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.Humidity.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Atmosphere.UV := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.UV.Name := 'A_W_Provider_OpenWeatherMap_Atmosphere_Ultraviolet_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.UV.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.UV.SetBounds(300, 470, 300, 30);
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.UV.Font.Size := 16;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.UV.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.UV.Text := 'Ultraviolet (UV)';
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.UV.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.UV.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Atmosphere.UV_Index := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.UV_Index.Name := 'A_W_Provider_OpenWeatherMap_Atmosphere_Ultraviolet_Index' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.UV_Index.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.UV_Index.SetBounds(300, 490, 300, 30);
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.UV_Index.Font.Size := 16;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.UV_Index.Color := TAlphaColorRec.White;;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.UV_Index.Text := 'Index : ' + vTown.UV.current.value;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.UV_Index.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_OMP[vTab].Atmosphere.UV_Index.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise_Image := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise_Image.Name := 'A_W_Provider_OpenWeatherMap_Astronomy_Sunrise_Image_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise_Image.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise_Image.SetBounds(60, 710, 42, 42);
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise_Image.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise_Image.Font.Size := 36;
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise_Image.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise_Image.Text := #$f051;
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise_Image.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise.Name := 'A_W_Provider_OpenWeatherMap_Astronomy_Sunrise_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise.SetBounds(60, 740, 100, 30);
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise.Font.Size := 16;
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise.Color := TAlphaColorRec.White;
//  vWeather.Scene.Tab[vTab].Astronomy.Sunrise.Text := Convert_Astronomy(vTown.SunAndMoon.Sunrise);
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise.Text := vTown.Current.sys.sunrize;
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise.Tag := vTab;
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunrise.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset_Image := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset_Image.Name := 'A_W_Provider_OpenWeatherMap_Astronomy_Sunset_Image_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset_Image.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset_Image.SetBounds(430, 710, 42, 42);
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset_Image.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset_Image.Font.Size := 36;
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset_Image.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset_Image.Text := #$f052;
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset_Image.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset.Name := 'A_W_Provider_OpenWeatherMap_Astronomy_Sunset_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset.SetBounds(430, 740, 100, 30);
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset.Font.Size := 16;
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset.Color := TAlphaColorRec.White;
//  vWeather.Scene.Tab[vTab].Astronomy.Sunset.Text := Convert_Astronomy(vTown.SunAndMoon.Sunset);
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset.Text := vTown.Current.sys.sunset;
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset.Tag := vTab;
  vWeather.Scene.Tab_OMP[vTab].Astronomy.Sunset.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Server.Powered_By := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Server.Powered_By.Name := 'A_W_Provider_OpenWeatherMap_Powered_By_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Server.Powered_By.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Server.Powered_By.Font.Size := 16;
  vWeather.Scene.Tab_OMP[vTab].Server.Powered_By.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_OMP[vTab].Server.Powered_By.Position.Y := 710;
  vWeather.Scene.Tab_OMP[vTab].Server.Powered_By.Text := 'Powered by : ';
  vWeather.Scene.Tab_OMP[vTab].Server.Powered_By.Tag := vTab;
  vWeather.Scene.Tab_OMP[vTab].Server.Powered_By.Visible := True;
  vWeather.Scene.Tab_OMP[vTab].Server.Powered_By.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab_OMP[vTab].Server.Powered_By);
  vWeather.Scene.Tab_OMP[vTab].Server.Powered_By.Position.X := vWeather.Scene.Tab_OMP[vTab].Tab.Width - (vWeather.Scene.Tab_OMP[vTab].Server.Powered_By.Width + 70);

  vWeather.Scene.Tab_OMP[vTab].Server.Icon := TImage.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Server.Icon.Name := 'A_W_Provider_OpenWeatherMap_Powered_By_Yahoo_Icon_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Server.Icon.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Server.Icon.Width := 64;
  vWeather.Scene.Tab_OMP[vTab].Server.Icon.Height := 64;
  vWeather.Scene.Tab_OMP[vTab].Server.Icon.Position.X := vWeather.Scene.Tab_OMP[vTab].Tab.Width - 70;
  vWeather.Scene.Tab_OMP[vTab].Server.Icon.Position.Y := 700;
  vWeather.Scene.Tab_OMP[vTab].Server.Icon.WrapMode := TImageWrapMode.Fit;
  vWeather.Scene.Tab_OMP[vTab].Server.Icon.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_openweathermap.png');
  vWeather.Scene.Tab_OMP[vTab].Server.Icon.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Country.LastUpDate := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Country.LastUpDate.Name := 'A_W_Provider_OpenWeatherMap_Last_UpDate';
  vWeather.Scene.Tab_OMP[vTab].Country.LastUpDate.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Country.LastUpDate.SetBounds(extrafe.res.Half_Width - 200, vWeather.Scene.Tab_OMP[vTab].Tab.Height - 146, 400, 30);
  vWeather.Scene.Tab_OMP[vTab].Country.LastUpDate.Font.Size := 16;
  vWeather.Scene.Tab_OMP[vTab].Country.LastUpDate.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_OMP[vTab].Country.LastUpDate.Text := 'Last Update: ' + ConvertTime(vTown.Current.date_time, '').Full;
  vWeather.Scene.Tab_OMP[vTab].Country.LastUpDate.HorzTextAlign := TTextAlign.Center;
  vWeather.Scene.Tab_OMP[vTab].Country.LastUpDate.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Country.Town_and_Country := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Country.Town_and_Country.Name := 'A_W_Provider_OpenWeatherMap_TownAndCountry_' + IntToStr(vTab);
  vWeather.Scene.Tab_OMP[vTab].Country.Town_and_Country.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Country.Town_and_Country.SetBounds(0, vWeather.Scene.Tab_OMP[vTab].Tab.Height - 120, extrafe.res.Width, 50);
  vWeather.Scene.Tab_OMP[vTab].Country.Town_and_Country.Font.Size := 42;
  vWeather.Scene.Tab_OMP[vTab].Country.Town_and_Country.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_OMP[vTab].Country.Town_and_Country.Text := vTown.Current.Name + ' - ' + vTown.Current.sys.country;
  vWeather.Scene.Tab_OMP[vTab].Country.Town_and_Country.TextSettings.HorzAlign := TTextAlign.Center;
  vWeather.Scene.Tab_OMP[vTab].Country.Town_and_Country.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Country.Latidute := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Country.Latidute.Name := 'A_W_Provider_OpenWeatherMap_CountryLatitude';
  vWeather.Scene.Tab_OMP[vTab].Country.Latidute.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Country.Latidute.SetBounds(extrafe.res.Half_Width - 200, vWeather.Scene.Tab_OMP[vTab].Tab.Height - 60, 150, 30);
  vWeather.Scene.Tab_OMP[vTab].Country.Latidute.Font.Size := 16;
  vWeather.Scene.Tab_OMP[vTab].Country.Latidute.TextSettings.FontColor := TAlphaColorRec.White;
  vWeather.Scene.Tab_OMP[vTab].Country.Latidute.Text := 'Lat : ' + vTown.Current.coord.lat;
  vWeather.Scene.Tab_OMP[vTab].Country.Latidute.HorzTextAlign := TTextAlign.Center;
  vWeather.Scene.Tab_OMP[vTab].Country.Latidute.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Country.Earth := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Country.Earth.Name := 'A_W_Provider_OpenWeatherMap_Earth_' + vTab.ToString;
  vWeather.Scene.Tab_OMP[vTab].Country.Earth.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Country.Earth.SetBounds(extrafe.res.Half_Width - 16, vWeather.Scene.Tab_OMP[vTab].Tab.Height - 60, 32, 32);
  vWeather.Scene.Tab_OMP[vTab].Country.Earth.Font.Family := 'IcoMoon-Free';
  vWeather.Scene.Tab_OMP[vTab].Country.Earth.Font.Size := 26;
  vWeather.Scene.Tab_OMP[vTab].Country.Earth.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_OMP[vTab].Country.Earth.Text := #$e9ca;
  vWeather.Scene.Tab_OMP[vTab].Country.Earth.OnClick := addons.weather.Input.mouse.Text.OnMouseClick;
  vWeather.Scene.Tab_OMP[vTab].Country.Earth.OnMouseEnter := addons.weather.Input.mouse.Text.OnMouseEnter;
  vWeather.Scene.Tab_OMP[vTab].Country.Earth.OnMouseLeave := addons.weather.Input.mouse.Text.OnMouseLeave;
  vWeather.Scene.Tab_OMP[vTab].Country.Earth.HorzTextAlign := TTextAlign.Center;
  vWeather.Scene.Tab_OMP[vTab].Country.Earth.TagString := vTab.ToString;
  vWeather.Scene.Tab_OMP[vTab].Country.Earth.Visible := True;

  vWeather.Scene.Tab_OMP[vTab].Country.Earth_Glow := TGlowEffect.Create(vWeather.Scene.Tab_OMP[vTab].Country.Earth);
  vWeather.Scene.Tab_OMP[vTab].Country.Earth_Glow.Name := 'A_W_Provider_OpenWeatherMap_Earth_Glow';
  vWeather.Scene.Tab_OMP[vTab].Country.Earth_Glow.Parent := vWeather.Scene.Tab_OMP[vTab].Country.Earth;
  vWeather.Scene.Tab_OMP[vTab].Country.Earth_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_OMP[vTab].Country.Earth_Glow.Opacity := 0.9;
  vWeather.Scene.Tab_OMP[vTab].Country.Earth_Glow.Softness := 0.4;
  vWeather.Scene.Tab_OMP[vTab].Country.Earth_Glow.Enabled := False;

  vWeather.Scene.Tab_OMP[vTab].Country.Longidute := TText.Create(vWeather.Scene.Tab_OMP[vTab].Tab);
  vWeather.Scene.Tab_OMP[vTab].Country.Longidute.Name := 'A_W_Provider_OpenWeatherMap_Country_Longidute';
  vWeather.Scene.Tab_OMP[vTab].Country.Longidute.Parent := vWeather.Scene.Tab_OMP[vTab].Tab;
  vWeather.Scene.Tab_OMP[vTab].Country.Longidute.SetBounds(extrafe.res.Half_Width + 50, vWeather.Scene.Tab_OMP[vTab].Tab.Height - 60, 150, 30);
  vWeather.Scene.Tab_OMP[vTab].Country.Longidute.Font.Size := 16;
  vWeather.Scene.Tab_OMP[vTab].Country.Longidute.TextSettings.FontColor := TAlphaColorRec.White;
  vWeather.Scene.Tab_OMP[vTab].Country.Longidute.Text := 'Long : ' + vTown.Current.coord.lon;
  vWeather.Scene.Tab_OMP[vTab].Country.Longidute.HorzTextAlign := TTextAlign.Center;
  vWeather.Scene.Tab_OMP[vTab].Country.Longidute.Visible := True;
//
//  //Here create 5 days per 3 hours panel
//
//  vWeather.Scene.Tab[vTab].General.Moon := TText.Create(vWeather.Scene.Tab[vTab].Tab);
//  vWeather.Scene.Tab[vTab].General.Moon.Name := 'A_W_Provider_OpenWeatherMap_Moon';
//  vWeather.Scene.Tab[vTab].General.Moon.Parent := vWeather.Scene.Tab[vTab].Tab;
//  vWeather.Scene.Tab[vTab].General.Moon.SetBounds(1690, 60, 200, 30);
//  vWeather.Scene.Tab[vTab].General.Moon.Font.Size := 16;
//  vWeather.Scene.Tab[vTab].General.Moon.TextSettings.FontColor := TAlphaColorRec.White;
//  vWeather.Scene.Tab[vTab].General.Moon.Text := 'Moon Phase ';
//  vWeather.Scene.Tab[vTab].General.Moon.HorzTextAlign := TTextAlign.Center;
//  vWeather.Scene.Tab[vTab].General.Moon.Visible := True;
//
//  vWeather.Scene.Tab[vTab].General.Moon_Phase := TText.Create(vWeather.Scene.Tab[vTab].Tab);
//  vWeather.Scene.Tab[vTab].General.Moon_Phase.Name := 'A_W_Provider_OpenWeatherMap_Moon_Phase';
//  vWeather.Scene.Tab[vTab].General.Moon_Phase.Parent := vWeather.Scene.Tab[vTab].Tab;
//  vWeather.Scene.Tab[vTab].General.Moon_Phase.SetBounds(1770, 90, 48, 48);
//  vWeather.Scene.Tab[vTab].General.Moon_Phase.Font.Family := 'Weather Icons';
//  vWeather.Scene.Tab[vTab].General.Moon_Phase.Font.Size := 32;
//  vWeather.Scene.Tab[vTab].General.Moon_Phase.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
////  vWeather.Scene.Tab[vTab].General.Moon_Phase.Text := Get_Moon_Phase(vTown.SunAndMoon.MoonPhase);
//  vWeather.Scene.Tab[vTab].General.Moon_Phase.Visible := True;
//
//  vWeather.Scene.Tab[vTab].General.Refresh_Text := TText.Create(vWeather.Scene.Tab[vTab].Tab);
//  vWeather.Scene.Tab[vTab].General.Refresh_Text.Name := 'A_W_Provider_OpenWeatherMap_Refresh_Text';
//  vWeather.Scene.Tab[vTab].General.Refresh_Text.Parent := vWeather.Scene.Tab[vTab].Tab;
//  vWeather.Scene.Tab[vTab].General.Refresh_Text.SetBounds(1690, 200, 200, 30);
//  vWeather.Scene.Tab[vTab].General.Refresh_Text.Font.Size := 16;
//  vWeather.Scene.Tab[vTab].General.Refresh_Text.TextSettings.FontColor := TAlphaColorRec.White;
//  vWeather.Scene.Tab[vTab].General.Refresh_Text.Text := 'Refresh Current Town';
//  vWeather.Scene.Tab[vTab].General.Refresh_Text.HorzTextAlign := TTextAlign.Center;
//  vWeather.Scene.Tab[vTab].General.Refresh_Text.Visible := True;
//
//  vWeather.Scene.Tab[vTab].General.Refresh := TText.Create(vWeather.Scene.Tab[vTab].Tab);
//  vWeather.Scene.Tab[vTab].General.Refresh.Name := 'A_W_Provider_OpenWeatherMap_Refresh';
//  vWeather.Scene.Tab[vTab].General.Refresh.Parent := vWeather.Scene.Tab[vTab].Tab;
//  vWeather.Scene.Tab[vTab].General.Refresh.SetBounds(1770, 230, 48, 48);
//  vWeather.Scene.Tab[vTab].General.Refresh.Font.Family := 'Weather Icons';
//  vWeather.Scene.Tab[vTab].General.Refresh.Font.Size := 32;
//  vWeather.Scene.Tab[vTab].General.Refresh.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
//  vWeather.Scene.Tab[vTab].General.Refresh.Text := #$f04c;
//  vWeather.Scene.Tab[vTab].General.Refresh.OnClick := addons.weather.Input.mouse.Text.OnMouseClick;
//  vWeather.Scene.Tab[vTab].General.Refresh.OnMouseEnter := addons.weather.Input.mouse.Text.OnMouseEnter;
//  vWeather.Scene.Tab[vTab].General.Refresh.OnMouseLeave := addons.weather.Input.mouse.Text.OnMouseLeave;
//  vWeather.Scene.Tab[vTab].General.Refresh.Visible := True;
//
//  vWeather.Scene.Tab[vTab].General.Refresh_Glow := TGlowEffect.Create(vWeather.Scene.Tab[vTab].General.Refresh);
//  vWeather.Scene.Tab[vTab].General.Refresh_Glow.Name := 'A_W_Provider_OpenWeatherMap_Refresh_Glow';
//  vWeather.Scene.Tab[vTab].General.Refresh_Glow.Parent := vWeather.Scene.Tab[vTab].General.Refresh;
//  vWeather.Scene.Tab[vTab].General.Refresh_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
//  vWeather.Scene.Tab[vTab].General.Refresh_Glow.Opacity := 0.9;
//  vWeather.Scene.Tab[vTab].General.Refresh_Glow.Softness := 0.4;
//  vWeather.Scene.Tab[vTab].General.Refresh_Glow.Enabled := False;

end;

procedure Load;
var
  vi: Integer;
  vID: String;
begin

  // for vi := 0 to addons.weather.Action.Active_Total do
  // begin
  // vID := addons.weather.Ini.Ini.ReadString(addons.weather.Action.Provider, IntToStr(vi) + '_WoeID', vID);
  // vDay := uWeather_Providers_OpenWeatherMap_GetForcast(vID);
  // vHours := uWeather_Providers_OpenWeatherMap_GetForecast_5Days(vID);
  // uWeather_Providers_OpenWeatherMap_AddTown_Main(vi, vDay, vHours);
  // end;
end;

procedure uWeather_Providers_OpenWeatherMap_Load_Config;
var
  vi: Integer;
  vID: String;
begin
  for vi := 0 to addons.weather.Action.Active_Total do
  begin
    vID := addons.weather.Ini.Ini.ReadString(addons.weather.Action.Provider, IntToStr(vi) + '_WoeID', vID);
    // vDay := uWeather_Providers_OpenWeatherMap_GetForcast(vID);
    // vHours := uWeather_Providers_OpenWeatherMap_GetForecast_5Days(vID);
    uWeather_Providers_OpenWeatherMap_CreateConfigPanel(vi);
  end;
end;

function Is_Town_Exists(vWoeid: String): Boolean;
var
  vi: Integer;
begin
  Result := false;
  for vi := 0 to addons.weather.Action.OWM.Towns_List.Count - 1 do
  begin
    if addons.weather.Action.OWM.Woeid_List.Strings[vi] = vWoeid then
      Result := True;
  end;
end;

procedure Woeid_List;
var
  vi: Integer;
  vString: String;
  vIPos: Integer;
  vWoeid: String;
  vTown: String;
begin
  addons.weather.Action.OWM.Woeid_List := TStringList.Create;
  addons.weather.Action.OWM.Towns_List := TStringList.Create;

  if addons.weather.Action.OWM.Total_WoeID <> -1 then
  begin
    for vi := 0 to addons.weather.Action.OWM.Total_WoeID do
    begin
      vString := addons.weather.Ini.Ini.ReadString('openweathermap', 'woeid_' + vi.ToString, vString);
      vIPos := Pos('_', vString);
      vWoeid := Trim(Copy(vString, 0, vIPos - 1));
      vTown := Trim(Copy(vString, vIPos + 1, length(vString) - vIPos));
      addons.weather.Action.OWM.Woeid_List.Add(vWoeid);
      addons.weather.Action.OWM.Towns_List.Add(vTown);
    end;
  end;
end;

procedure Add_NewTown(vNum: Integer);
var
  vTemp_NewTown: TADDON_WEATHER_CONFIG_TOWNS_NEWTOWNPANEL;
begin
  if Is_Town_Exists(vOpenWeatherMap_Find_List[vNum].woeid) then
    ShowMessage('This town already exists in your list')
  else
  begin
    Inc(addons.weather.Action.OWM.Total_WoeID, 1);
    SetLength(addons.weather.Action.OWM.Data_Town, addons.weather.Action.OWM.Total_WoeID + 1);
    addons.weather.Action.OWM.Data_Town[addons.weather.Action.OWM.Total_WoeID] := Get_Forecast(addons.weather.Action.OWM.Total_WoeID,
      vOpenWeatherMap_Find_List[vNum].woeid);
    vTemp_NewTown.Time_Results := ConvertTime(addons.weather.Action.OWM.Data_Town[vNum].Current.date_time, '').Full;
    vTemp_NewTown.Forecast_Image := Get_Icon_Text(addons.weather.Action.OWM.Data_Town[vNum].Current.weather.ID,
      addons.weather.Action.OWM.Data_Town[vNum].Current.weather.Icon);
    vTemp_NewTown.Temperature := addons.weather.Action.OWM.Data_Town[addons.weather.Action.OWM.Total_WoeID].Current.main.Temp;
    vTemp_NewTown.Temrerature_Unit := 'F';
    vTemp_NewTown.Temperature_Description := addons.weather.Action.OWM.Data_Town[vNum].Current.weather.description;
    vTemp_NewTown.City_Name := addons.weather.Action.OWM.Data_Town[vNum].Current.Name;
    vTemp_NewTown.Country_Name := addons.weather.Action.OWM.Data_Town[vNum].Current.sys.country;
    vTemp_NewTown.Country_Flag := Get_Flag(addons.weather.Action.OWM.Data_Town[vNum].Five.city.country);
    uWeather_Providers_OpenWeatherMap_Config.Towns_Add_New_Town(vNum, vTemp_NewTown);
    if addons.weather.Action.OWM.Total_WoeID = 0 then
      vWeather.Scene.Back.bitmap := nil;
    Main_Create_Town(addons.weather.Action.OWM.Data_Town[vNum], vNum);

  end;

  // inc(addons.weather.Action.Active_Total, 1);
  // addons.weather.Ini.Ini.WriteInteger('Active', 'Active_Total', addons.weather.Action.Active_Total);
  // if addons.weather.Action.Active_WOEID = -1 then
  // begin
  // addons.weather.Action.Active_WOEID := 0;
  // addons.weather.Ini.Ini.WriteInteger('Active', 'Active_Woeid', addons.weather.Action.Active_WOEID);
  // end;
  // inc(addons.weather.Action.Provider_Total, 1);
  // addons.weather.Ini.Ini.WriteInteger('openweathermap', 'Total', addons.weather.Action.Provider_Total);
  // addons.weather.Ini.Ini.WriteString('openweathermap', addons.weather.Action.Provider_Total.ToString + '_WOEID', vID);
  // vDay := uWeather_Providers_OpenWeatherMap_GetForcast(vID);
  // vHours := uWeather_Providers_OpenWeatherMap_GetForecast_5Days(vID);
  //
  // uWeather_Providers_OpenWeatherMap_CreateConfigPanel(addons.weather.Action.Active_Total);
  // uWeather_Providers_OpenWeatherMap_AddTown_Main(addons.weather.Action.Active_Total, vDay, vHours);
end;

function Get_Icon_Text(vCode_ID, vIcon: String): String;
var
  vState: String;
begin
  if vIcon = '' then
    vState := 'General'
  else if vIcon[length(vIcon)] = 'd' then
    vState := 'Day'
  else
    vState := 'Night';

  if vCode_ID = '200' then
  begin
    if vState = 'General' then
      Result := #$f01e
    else if vState = 'Day' then
      Result := #$f010
    else
      Result := #$f02d;
  end
  else if vCode_ID = '201' then
  begin
    if vState = 'General' then
      Result := #$f01e
    else if vState = 'Day' then
      Result := #$f010
    else
      Result := #$f02d;
  end
  else if vCode_ID = '202' then
  begin
    if vState = 'General' then
      Result := #$f01e
    else if vState = 'Day' then
      Result := #$f010
    else
      Result := #$f02d;
  end
  else if vCode_ID = '210' then
  begin
    if vState = 'General' then
      Result := #$f016
    else if vState = 'Day' then
      Result := #$f005
    else
      Result := #$f025;
  end
  else if vCode_ID = '211' then
  begin
    if vState = 'General' then
      Result := #$f016
    else if vState = 'Day' then
      Result := #$f005
    else
      Result := #$f025;
  end
  else if vCode_ID = '212' then
  begin
    if vState = 'General' then
      Result := #$f016
    else if vState = 'Day' then
      Result := #$f005
    else
      Result := #$f025;
  end
  else if vCode_ID = '221' then
  begin
    if vState = 'General' then
      Result := #$f016
    else if vState = 'Day' then
      Result := #$f005
    else
      Result := #$f025;
  end
  else if vCode_ID = '230' then
  begin
    if vState = 'General' then
      Result := #$f01e
    else if vState = 'Day' then
      Result := #$f010
    else
      Result := #$f02d;
  end
  else if vCode_ID = '231' then
  begin
    if vState = 'General' then
      Result := #$f01e
    else if vState = 'Day' then
      Result := #$f010
    else
      Result := #$f02d;
  end
  else if vCode_ID = '232' then
  begin
    if vState = 'General' then
      Result := #$f01e
    else if vState = 'Day' then
      Result := #$f010
    else
      Result := #$f02d;
  end
  else if vCode_ID = '300' then
  begin
    if vState = 'General' then
      Result := #$f01c
    else if vState = 'Day' then
      Result := #$f00b
    else
      Result := #$f02b;
  end
  else if vCode_ID = '301' then
  begin
    if vState = 'General' then
      Result := #$f01c
    else if vState = 'Day' then
      Result := #$f00b
    else
      Result := #$f02b;
  end
  else if vCode_ID = '302' then
  begin
    if vState = 'General' then
      Result := #$f019
    else if vState = 'Day' then
      Result := #$f008
    else
      Result := #$f028;
  end
  else if vCode_ID = '310' then
  begin
    if vState = 'General' then
      Result := #$f017
    else if vState = 'Day' then
      Result := #$f008
    else
      Result := #$f028;
  end
  else if vCode_ID = '311' then
  begin
    if vState = 'General' then
      Result := #$f019
    else if vState = 'Day' then
      Result := #$f008
    else
      Result := #$f028;
  end
  else if vCode_ID = '312' then
  begin
    if vState = 'General' then
      Result := #$f019
    else if vState = 'Day' then
      Result := #$f008
    else
      Result := #$f028;
  end
  else if vCode_ID = '313' then
  begin
    if vState = 'General' then
      Result := #$f01a
    else if vState = 'Day' then
      Result := #$f008
    else
      Result := #$f028;
  end
  else if vCode_ID = '314' then
  begin
    if vState = 'General' then
      Result := #$f019
    else if vState = 'Day' then
      Result := #$f008
    else
      Result := #$f028;
  end
  else if vCode_ID = '321' then
  begin
    if vState = 'General' then
      Result := #$f01c
    else if vState = 'Day' then
      Result := #$f00b
    else
      Result := #$f02b;
  end
  else if vCode_ID = '500' then
  begin
    if vState = 'General' then
      Result := #$f01c
    else if vState = 'Day' then
      Result := #$f00b
    else
      Result := #$f02b;
  end
  else if vCode_ID = '501' then
  begin
    if vState = 'General' then
      Result := #$f019
    else if vState = 'Day' then
      Result := #$f008
    else
      Result := #$f028;
  end
  else if vCode_ID = '502' then
  begin
    if vState = 'General' then
      Result := #$f019
    else if vState = 'Day' then
      Result := #$f008
    else
      Result := #$f028;
  end
  else if vCode_ID = '503' then
  begin
    if vState = 'General' then
      Result := #$f019
    else if vState = 'Day' then
      Result := #$f008
    else
      Result := #$f028;
  end
  else if vCode_ID = '504' then
  begin
    if vState = 'General' then
      Result := #$f019
    else if vState = 'Day' then
      Result := #$f008
    else
      Result := #$f028;
  end
  else if vCode_ID = '511' then
  begin
    if vState = 'General' then
      Result := #$f017
    else if vState = 'Day' then
      Result := #$f006
    else
      Result := #$f026;
  end
  else if vCode_ID = '520' then
  begin
    if vState = 'General' then
      Result := #$f01a
    else if vState = 'Day' then
      Result := #$f009
    else
      Result := #$f029;
  end
  else if vCode_ID = '521' then
  begin
    if vState = 'General' then
      Result := #$f01a
    else if vState = 'Day' then
      Result := #$f009
    else
      Result := #$f029;
  end
  else if vCode_ID = '522' then
  begin
    if vState = 'General' then
      Result := #$f01a
    else if vState = 'Day' then
      Result := #$f009
    else
      Result := #$f029;
  end
  else if vCode_ID = '531' then
  begin
    if vState = 'General' then
      Result := #$f01d
    else if vState = 'Day' then
      Result := #$f00e
    else
      Result := #$f02c;
  end
  else if vCode_ID = '600' then
  begin
    if vState = 'General' then
      Result := #$f01b
    else if vState = 'Day' then
      Result := #$f00a
    else
      Result := #$f02a;
  end
  else if vCode_ID = '601' then
  begin
    if vState = 'General' then
      Result := #$f01b
    else if vState = 'Day' then
      Result := #$f0b2
    else
      Result := #$f0b4;
  end
  else if vCode_ID = '602' then
  begin
    if vState = 'General' then
      Result := #$f0b5
    else if vState = 'Day' then
      Result := #$f01b
    else
      Result := #$f02a;
  end
  else if vCode_ID = '611' then
  begin
    if vState = 'General' then
      Result := #$f017
    else if vState = 'Day' then
      Result := #$f006
    else
      Result := #$f026;
  end
  else if vCode_ID = '612' then
  begin
    if vState = 'General' then
      Result := #$f017
    else if vState = 'Day' then
      Result := #$f006
    else
      Result := #$f026;
  end
  else if vCode_ID = '615' then
  begin
    if vState = 'General' then
      Result := #$f017
    else if vState = 'Day' then
      Result := #$f006
    else
      Result := #$f026;
  end
  else if vCode_ID = '616' then
  begin
    if vState = 'General' then
      Result := #$f017
    else if vState = 'Day' then
      Result := #$f006
    else
      Result := #$f026;
  end
  else if vCode_ID = '620' then
  begin
    if vState = 'General' then
      Result := #$f017
    else if vState = 'Day' then
      Result := #$f006
    else
      Result := #$f026;
  end
  else if vCode_ID = '621' then
  begin
    if vState = 'General' then
      Result := #$f01b
    else if vState = 'Day' then
      Result := #$f00a
    else
      Result := #$f02a;
  end
  else if vCode_ID = '622' then
  begin
    if vState = 'General' then
      Result := #$f01b
    else if vState = 'Day' then
      Result := #$f00a
    else
      Result := #$f02a;
  end
  else if vCode_ID = '701' then
  begin
    if vState = 'General' then
      Result := #$f01a
    else if vState = 'Day' then
      Result := #$f009
    else
      Result := #$f029;
  end
  else if vCode_ID = '711' then
  begin
    if vState = 'General' then
      Result := #$f062
    else if vState = 'Day' then
      Result := #$f062
    else
      Result := #$f062;
  end
  else if vCode_ID = '721' then
  begin
    if vState = 'General' then
      Result := #$f0b6
    else if vState = 'Day' then
      Result := #$f0b6
    else
      Result := #$f0b6;
  end
  else if vCode_ID = '731' then
  begin
    if vState = 'General' then
      Result := #$f063
    else if vState = 'Day' then
      Result := #$f063
    else
      Result := #$f063;
  end
  else if vCode_ID = '741' then
  begin
    if vState = 'General' then
      Result := #$f014
    else if vState = 'Day' then
      Result := #$f003
    else
      Result := #$f04a;
  end
  else if vCode_ID = '761' then
  begin
    if vState = 'General' then
      Result := #$f063
    else if vState = 'Day' then
      Result := #$f063
    else
      Result := #$f063;
  end
  else if vCode_ID = '762' then
  begin
    if vState = 'General' then
      Result := #$f063
    else if vState = 'Day' then
      Result := #$f063
    else
      Result := #$f063;
  end
  else if vCode_ID = '771' then
  begin
    if vState = 'General' then
      Result := #$f011
    else if vState = 'Day' then
      Result := ''
    else
      Result := '';
  end
  else if vCode_ID = '781' then
  begin
    if vState = 'General' then
      Result := #$f056
    else if vState = 'Day' then
      Result := #$f056
    else
      Result := #$f056;
  end
  else if vCode_ID = '800' then
  begin
    if vState = 'General' then
      Result := #$f00d
    else if vState = 'Day' then
      Result := #$f00d
    else
      Result := #$f02e;
  end
  else if vCode_ID = '801' then
  begin
    if vState = 'General' then
      Result := #$f011
    else if vState = 'Day' then
      Result := #$f000
    else
      Result := #$f022;
  end
  else if vCode_ID = '802' then
  begin
    if vState = 'General' then
      Result := #$f011
    else if vState = 'Day' then
      Result := #$f000
    else
      Result := #$f022;
  end
  else if vCode_ID = '803' then
  begin
    if vState = 'General' then
      Result := #$f011
    else if vState = 'Day' then
      Result := #$f000
    else
      Result := #$f022;
  end
  else if vCode_ID = '804' then
  begin
    if vState = 'General' then
      Result := #$f013
    else if vState = 'Day' then
      Result := #$f00c
    else
      Result := #$f086;
  end
  else if vCode_ID = '900' then
  begin
    if vState = 'General' then
      Result := #$f056
    else if vState = 'Day' then
      Result := #$f056
    else
      Result := #$f056;
  end
  else if vCode_ID = '901' then
  begin
    if vState = 'General' then
      Result := #$f01d
    else if vState = 'Day' then
      Result := ''
    else
      Result := '';
  end
  else if vCode_ID = '902' then
  begin
    if vState = 'General' then
      Result := #$f073
    else if vState = 'Day' then
      Result := #$f073
    else
      Result := #$f073;
  end
  else if vCode_ID = '903' then
  begin
    if vState = 'General' then
      Result := #$f076
    else if vState = 'Day' then
      Result := #$f076
    else
      Result := #$f07;
  end
  else if vCode_ID = '904' then
  begin
    if vState = 'General' then
      Result := #$f072
    else if vState = 'Day' then
      Result := #$f072
    else
      Result := #$f072;
  end
  else if vCode_ID = '905' then
  begin
    if vState = 'General' then
      Result := #$f021
    else if vState = 'Day' then
      Result := ''
    else
      Result := '';
  end
  else if vCode_ID = '906' then
  begin
    if vState = 'General' then
      Result := #$f015
    else if vState = 'Day' then
      Result := #$f004
    else
      Result := #$f024;
  end
  else if vCode_ID = '957' then
  begin
    if vState = 'General' then
      Result := #$f050
    else if vState = 'Day' then
      Result := #$f050
    else
      Result := #$f050;
  end
end;

function Get_Flag(vCountry: String): TBitmap;
begin
  Result := TBitmap.Create;
  Result.LoadFromFile(ex_main.Paths.Flags_Images + LowerCase(vCountry) + '.png');
end;

procedure uWeather_Providers_OpenWeatherMap_CreateConfigPanel(vNum: Integer);
var
  vCreatePanel: TADDON_WEATHER_CONFIG_CREATE_PANEL;
begin
  // vCreatePanel.Temp := vDay.Temp;
  // vCreatePanel.Temp_Unit := uWeatehr_Providers_OpenWeatherMap_Unit_Word;
  // vCreatePanel.Temp_Icon := vDay.Weather_Build_Icon;
  // vCreatePanel.Temp_Description := vDay.Weather_Desc;
  // vCreatePanel.City_Name := vDay.city;
  // vCreatePanel.Country_Name := vDay.country;
  // vCreatePanel.Country_Flag := vDay.Country_FlagCode;
  // vCreatePanel.Last_Checked := vDay.Last_Checked;
  // uWeather_Config_Towns_CreateTown_Panel(vNum, vCreatePanel);
end;

function uWeatehr_Providers_OpenWeatherMap_Unit_Word: String;
begin
  if addons.weather.Action.OWM.Selected_Unit = 'Celcius' then
    Result := 'C'
  else if addons.weather.Action.OWM.Selected_Unit = 'Fahrenheit' then
    Result := 'F'
  else if addons.weather.Action.OWM.Selected_Unit = 'Kelvin' then
    Result := 'K';
end;

function uWeather_Providers_OpenWeatherMap_Unit: String;
begin
  if addons.weather.Action.OWM.Selected_Unit = 'Celcius' then
    Result := 'metric'
  else if addons.weather.Action.OWM.Selected_Unit = 'Fahrenheit' then
    Result := 'imperial'
  else if addons.weather.Action.OWM.Selected_Unit = 'Kelvin' then
    Result := '';
end;

function Get_Forecast(vNum: Integer; vWoeid: String): TADDON_WEATHER_PROVIDER_OPENWEATHERMAP_DATATOWN;
var
  vOutValue: String;
  vi: Integer;
  vLat, vLon: String;
  vStart_Time, vEnd_Time: String;
begin
  // Get the current day forecast data
  vRESTClient := TRESTClient.Create('');
  vRESTClient.Name := 'OpenWeatherMap_RestClient';
  vRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
  vRESTClient.BaseURL := 'http://api.openweathermap.org/data/2.5/weather?id=' + vWoeid + '&APPID=' + cAuthor_OWM_APPID + '&units=' +
    uWeather_Providers_OpenWeatherMap_Unit;
  vRESTClient.FallbackCharsetEncoding := 'UTF-8';

  vRESTResponse := TRESTResponse.Create(vRESTClient);
  vRESTResponse.Name := 'OpenWeatherMap_Response';

  vRESTRequest := TRESTRequest.Create(vRESTClient);
  vRESTRequest.Name := 'OpenWeatherMap_Request';
  vRESTRequest.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTRequest.AcceptCharset := 'UTF-8, *;q=0.8';
  vRESTRequest.Client := vRESTClient;
  vRESTRequest.Method := TRESTRequestMethod.rmGET;
  vRESTRequest.Response := vRESTResponse;
  vRESTRequest.Timeout := 30000;

  vRESTRequest.Execute;
  vJSONValue := vRESTResponse.JSONValue;

  Result.Current.coord.lon := vJSONValue.GetValue<String>('coord.lon');
  Result.Current.coord.lat := vJSONValue.GetValue<String>('coord.lat');
  Result.Current.weather.ID := vJSONValue.GetValue<String>('weather[0].id');
  Result.Current.weather.main := vJSONValue.GetValue<String>('weather[0].main');
  Result.Current.weather.description := vJSONValue.GetValue<String>('weather[0].description');
  Result.Current.weather.Icon := vJSONValue.GetValue<String>('weather[0].icon');
  Result.Current.base := vJSONValue.GetValue<String>('base');
  Result.Current.main.Temp := vJSONValue.GetValue<String>('main.temp');
  Result.Current.main.Pressure := vJSONValue.GetValue<String>('main.pressure');
  Result.Current.main.Humidity := vJSONValue.GetValue<String>('main.humidity');
  Result.Current.main.Min := vJSONValue.GetValue<String>('main.temp_min');
  Result.Current.main.Max := vJSONValue.GetValue<String>('main.temp_max');
  if vJSONValue.TryGetValue('main.sea_level', vOutValue) then
    Result.Current.main.sea_level := vOutValue;
  if vJSONValue.TryGetValue('main.grnd_level', vOutValue) then
    Result.Current.main.ground_level := vOutValue;
  Result.Current.Wind.Speed := vJSONValue.GetValue<String>('wind.speed');
  if vJSONValue.TryGetValue('wind.deg', vOutValue) then
    Result.Current.Wind.degree := vOutValue;
  Result.Current.Clouds.all := vJSONValue.GetValue<String>('clouds.all');
  if vJSONValue.TryGetValue('rain.1h', vOutValue) then
    Result.Current.rain.one_hour := vOutValue;
  if vJSONValue.TryGetValue('rain.3h', vOutValue) then
    Result.Current.rain.three_hours := vOutValue;
  if vJSONValue.TryGetValue('snow.1h', vOutValue) then
    Result.Current.snow.one_hour := vOutValue;
  if vJSONValue.TryGetValue('snow.2h', vOutValue) then
    Result.Current.snow.three_hours := vOutValue;
  Result.Current.date_time := vJSONValue.GetValue<String>('dt');
  Result.Current.sys.vtype := vJSONValue.GetValue<String>('sys.type');
  Result.Current.sys.ID := vJSONValue.GetValue<String>('sys.id');
  Result.Current.sys.vmessage := vJSONValue.GetValue<String>('sys.message');
  Result.Current.sys.country := vJSONValue.GetValue<String>('sys.country');
  Result.Current.sys.sunrize := vJSONValue.GetValue<String>('sys.sunrise');
  Result.Current.sys.sunset := vJSONValue.GetValue<String>('sys.sunset');
  Result.Current.timezone := vJSONValue.GetValue<String>('timezone');
  Result.Current.ID := vJSONValue.GetValue<String>('id');
  Result.Current.Name := vJSONValue.GetValue<String>('name');
  Result.Current.cod := vJSONValue.GetValue<String>('cod');

  FreeAndNil(vJSONValue);
  FreeAndNil(vRESTRequest);

  // Get the 5 days forecast data
  vRESTClient := TRESTClient.Create('');
  vRESTClient.Name := 'OpenWeatherMap_RestClient';
  vRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
  vRESTClient.BaseURL := 'http://api.openweathermap.org/data/2.5/forecast?id=' + vWoeid + '&APPID=' + cAuthor_OWM_APPID + '&units=' +
    uWeather_Providers_OpenWeatherMap_Unit;
  vRESTClient.FallbackCharsetEncoding := 'UTF-8';

  vRESTResponse := TRESTResponse.Create(vRESTClient);
  vRESTResponse.Name := 'OpenWeatherMap_Response';

  vRESTRequest := TRESTRequest.Create(vRESTClient);
  vRESTRequest.Name := 'OpenWeatherMap_Request';
  vRESTRequest.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTRequest.AcceptCharset := 'UTF-8, *;q=0.8';
  vRESTRequest.Client := vRESTClient;
  vRESTRequest.Method := TRESTRequestMethod.rmGET;
  vRESTRequest.Response := vRESTResponse;
  vRESTRequest.Timeout := 30000;

  vRESTRequest.Execute;
  vJSONValue := vRESTResponse.JSONValue;

  Result.Five.cod := vJSONValue.GetValue<String>('cod');
  Result.Five.vmessage := vJSONValue.GetValue<String>('message');
  Result.Five.cnt := vJSONValue.GetValue<String>('cnt');

  for vi := 0 to Result.Five.cnt.ToInteger - 1 do
  begin
    Result.Five.list[vi].dt := vJSONValue.GetValue<String>('list[' + vi.ToString + '].dt');
    Result.Five.list[vi].main.Temp := vJSONValue.GetValue<String>('list[' + vi.ToString + '].main.temp');
    Result.Five.list[vi].main.Temp_Min := vJSONValue.GetValue<String>('list[' + vi.ToString + '].main.temp_min');
    Result.Five.list[vi].main.Temp_Max := vJSONValue.GetValue<String>('list[' + vi.ToString + '].main.temp_max');
    Result.Five.list[vi].main.Pressure := vJSONValue.GetValue<String>('list[' + vi.ToString + '].main.pressure');
    Result.Five.list[vi].main.sea_level := vJSONValue.GetValue<String>('list[' + vi.ToString + '].main.sea_level');
    Result.Five.list[vi].main.ground_level := vJSONValue.GetValue<String>('list[' + vi.ToString + '].main.grnd_level');
    Result.Five.list[vi].main.Humidity := vJSONValue.GetValue<String>('list[' + vi.ToString + '].main.humidity');
    Result.Five.list[vi].main.temp_kf := vJSONValue.GetValue<String>('list[' + vi.ToString + '].main.temp_kf');
    if vJSONValue.TryGetValue('list[' + vi.ToString + '].weather.id', vOutValue) then
      Result.Five.list[vi].weather.ID := vOutValue;
    if vJSONValue.TryGetValue('list[' + vi.ToString + '].weather.main', vOutValue) then
      Result.Five.list[vi].weather.main := vOutValue;
    if vJSONValue.TryGetValue('list[' + vi.ToString + '].weather.description', vOutValue) then
      Result.Five.list[vi].weather.description := vOutValue;
    if vJSONValue.TryGetValue('list[' + vi.ToString + '].weather.icon', vOutValue) then
      Result.Five.list[vi].weather.Icon := vOutValue;
    Result.Five.list[vi].Clouds.all := vJSONValue.GetValue<String>('list[' + vi.ToString + '].clouds.all');
    Result.Five.list[vi].Wind.Speed := vJSONValue.GetValue<String>('list[' + vi.ToString + '].wind.speed');
    if vJSONValue.TryGetValue('list[' + vi.ToString + '].wind.deg', vOutValue) then
      Result.Five.list[vi].Wind.degree := vOutValue;
    if vJSONValue.TryGetValue('list[' + vi.ToString + '].rain.3h', vOutValue) then
      Result.Five.list[vi].rain.three_hours := vOutValue;
    if vJSONValue.TryGetValue('list[' + vi.ToString + '].snow.3h', vOutValue) then
      Result.Five.list[vi].snow.three_hours := vOutValue;
    Result.Five.list[vi].date_time := vJSONValue.GetValue<String>('list[' + vi.ToString + '].dt_txt');
  end;

  Result.Five.city.ID := vJSONValue.GetValue<String>('city.id');
  Result.Five.city.Name := vJSONValue.GetValue<String>('city.name');
  Result.Five.city.coord.lon := vJSONValue.GetValue<String>('city.coord.lon');
  Result.Five.city.coord.lat := vJSONValue.GetValue<String>('city.coord.lat');
  Result.Five.city.country := vJSONValue.GetValue<String>('city.country');
  Result.Five.city.timezone := vJSONValue.GetValue<String>('city.timezone');

  FreeAndNil(vJSONValue);
  FreeAndNil(vRESTRequest);

  // Get UV forecast Data
  vLat := Result.Current.coord.lat;
  vLon := Result.Current.coord.lon;
  vStart_Time := '';
  vEnd_Time := '';

  // Get the Current UV Index forecast data
  vRESTClient := TRESTClient.Create('');
  vRESTClient.Name := 'OpenWeatherMap_RestClient';
  vRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
  vRESTClient.BaseURL := 'http://api.openweathermap.org/data/2.5/uvi?lat=' + vLat + '&lon=' + vLon + '&APPID=' + cAuthor_OWM_APPID;
  vRESTClient.FallbackCharsetEncoding := 'UTF-8';

  vRESTResponse := TRESTResponse.Create(vRESTClient);
  vRESTResponse.Name := 'OpenWeatherMap_Response';

  vRESTRequest := TRESTRequest.Create(vRESTClient);
  vRESTRequest.Name := 'OpenWeatherMap_Request';
  vRESTRequest.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTRequest.AcceptCharset := 'UTF-8, *;q=0.8';
  vRESTRequest.Client := vRESTClient;
  vRESTRequest.Method := TRESTRequestMethod.rmGET;
  vRESTRequest.Response := vRESTResponse;
  vRESTRequest.Timeout := 30000;

  vRESTRequest.Execute;
  vJSONValue := vRESTResponse.JSONValue;

  Result.UV.Current.lat := vJSONValue.GetValue<String>('lat');
  Result.UV.Current.lon := vJSONValue.GetValue<String>('lon');
  Result.UV.Current.date_iso := vJSONValue.GetValue<String>('date_iso');
  Result.UV.Current.Date := vJSONValue.GetValue<String>('date');
  Result.UV.Current.Value := vJSONValue.GetValue<String>('value');

  FreeAndNil(vJSONValue);
  FreeAndNil(vRESTRequest);

  // Get the 8 days ahead UV Index forecast data
  vRESTClient := TRESTClient.Create('');
  vRESTClient.Name := 'OpenWeatherMap_RestClient';
  vRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
  vRESTClient.BaseURL := 'http://api.openweathermap.org/data/2.5/uvi/forecast?lat=' + vLat + '&lon=' + vLon + '&APPID=' + cAuthor_OWM_APPID;
  vRESTClient.FallbackCharsetEncoding := 'UTF-8';

  vRESTResponse := TRESTResponse.Create(vRESTClient);
  vRESTResponse.Name := 'OpenWeatherMap_Response';

  vRESTRequest := TRESTRequest.Create(vRESTClient);
  vRESTRequest.Name := 'OpenWeatherMap_Request';
  vRESTRequest.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTRequest.AcceptCharset := 'UTF-8, *;q=0.8';
  vRESTRequest.Client := vRESTClient;
  vRESTRequest.Method := TRESTRequestMethod.rmGET;
  vRESTRequest.Response := vRESTResponse;
  vRESTRequest.Timeout := 30000;

  vRESTRequest.Execute;
  vJSONValue := vRESTResponse.JSONValue;

  for vi := 0 to 7 do
  begin
    Result.UV.ahead[vi].lat := vJSONValue.GetValue<String>('[' + vi.ToString + '].lat');
    Result.UV.ahead[vi].lon := vJSONValue.GetValue<String>('[' + vi.ToString + '].lon');
    Result.UV.ahead[vi].date_iso := vJSONValue.GetValue<String>('[' + vi.ToString + '].date_iso');
    Result.UV.ahead[vi].Date := vJSONValue.GetValue<String>('[' + vi.ToString + '].date');
    Result.UV.ahead[vi].Value := vJSONValue.GetValue<String>('[' + vi.ToString + '].value');
  end;

  FreeAndNil(vJSONValue);
  FreeAndNil(vRESTRequest);

  // Get the Historical UV Index forecast data (dates back = ?)
  // vRESTClient := TRESTClient.Create('');
  // vRESTClient.Name := 'OpenWeatherMap_RestClient';
  // vRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  // vRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
  // vRESTClient.BaseURL := 'http://api.openweathermap.org/data/2.5/uvi/history?lat=' + vLat + '&lon=' + vLon + '&start=' + vStart_Time + '&end=' + vEnd_Time +
  // '&APPID=' + cAuthor_OWM_APPID;
  // vRESTClient.FallbackCharsetEncoding := 'UTF-8';
  //
  // vRESTResponse := TRESTResponse.Create(vRESTClient);
  // vRESTResponse.Name := 'OpenWeatherMap_Response';
  //
  // vRESTRequest := TRESTRequest.Create(vRESTClient);
  // vRESTRequest.Name := 'OpenWeatherMap_Request';
  // vRESTRequest.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  // vRESTRequest.AcceptCharset := 'UTF-8, *;q=0.8';
  // vRESTRequest.Client := vRESTClient;
  // vRESTRequest.Method := TRESTRequestMethod.rmGET;
  // vRESTRequest.Response := vRESTResponse;
  // vRESTRequest.Timeout := 30000;
  //
  // vRESTRequest.Execute;
  // vJSONValue := vRESTResponse.JSONValue;
  //
  // for vi := 0 to 10 do
  // begin
  // Result.UV.historical[vi].lat := vJSONValue.GetValue<String>('lat');
  // Result.UV.historical[vi].lon := vJSONValue.GetValue<String>('lon');
  // Result.UV.historical[vi].date_iso := vJSONValue.GetValue<String>('date_iso');
  // Result.UV.historical[vi].date := vJSONValue.GetValue<String>('date');
  // Result.UV.historical[vi].Value := vJSONValue.GetValue<String>('value');
  // end;
  //
  // FreeAndNil(vJSONValue);
  // FreeAndNil(vRESTRequest);
end;

function ConvertTime(vUnixTime, Quotes: String): TWEATHER_PROVIDER_OPENWEATHERMAP_TIME;
var
  vDateTime: String;
  vIPos: Integer;
  vMonth: String;
  vDay: String;
  vYear: String;
  vTime: String;
begin
  vDateTime := FormatDateTime('dd+mm-yyyy/hh:mm', UnixToDateTime((vUnixTime.ToInt64)));
  vIPos := Pos('+', vDateTime);
  vMonth := Trim(Copy(vDateTime, vIPos + 1, 2));
  vMonth := uWeather_Convert_Month(vMonth);
  vDay := Trim(Copy(vDateTime, 1, 2));
  vIPos := Pos('-', vDateTime);
  vYear := Trim(Copy(vDateTime, vIPos + 1, 4));
  vIPos := Pos('/', vDateTime);
  vTime := Trim(Copy(vDateTime, vIPos + 1, 5));
  Result.Date := vDay + Quotes + vMonth + Quotes + vYear;
  Result.Time := vTime;
  Result.Full := vDay + ', ' + vMonth + ' ' + vYear + ' at ' + vTime;
end;

// procedure uWeather_Providers_OpenWeatherMap_AddTown_Main(vTabNum: Integer; vTown_Day: TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP;
// vTown_Hour: TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP_DAYS);
// begin
// vWeather.Scene.Tab[vTabNum].Tab := TALTabItem.Create(vWeather.Scene.Control);
// vWeather.Scene.Tab[vTabNum].Tab.Name := 'A_W_WeatherTab_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Tab.Parent := vWeather.Scene.Control;
// vWeather.Scene.Tab[vTabNum].Tab.Visible := True;
//
// vWeather.Scene.Tab[vTabNum].General.Image := TImage.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].General.Image.Name := 'A_W_WeatherImage_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].General.Image.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].General.Image.SetBounds(50, 60, 150, 150);
// // vWeather.Scene.Tab[vTabNum].General.Image.Bitmap.LoadFromFile(addons.weather.Path.Iconsets + addons.weather.Config.Iconset.name + '\w_w_' +
// // uWeather_Providers_OpenWeatherMap_IconShow(vDay.Weather_ID) + '.png');
// vWeather.Scene.Tab[vTabNum].General.Image.Tag := vTabNum;
// vWeather.Scene.Tab[vTabNum].General.Image.Visible := True;
//
// vWeather.Scene.Tab[vTabNum].General.Town_and_Country := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Name := 'A_W_Weather_TownAndCountry_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Font.Size := 42;
// vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Color := TAlphaColorRec.White;
// vWeather.Scene.Tab[vTabNum].General.Town_and_Country.text := vDay.city + ' - ' + vDay.country;
// vWeather.Scene.Tab[vTabNum].General.Town_and_Country.TextSettings.HorzAlign := TTextAlign.Leading;
// vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Tag := vTabNum;
// vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Visible := True;
// vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].General.Town_and_Country);
// vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Position.X := (vWeather.Scene.Tab[vTabNum].Tab.Width / 2) -
// (vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Width / 2);
// vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Position.Y := vWeather.Scene.Tab[vTabNum].Tab.Height - 120;
//
// vWeather.Scene.Tab[vTabNum].General.Temprature := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].General.Temprature.Name := 'A_W_WeatherTemprature_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].General.Temprature.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].General.Temprature.Font.Size := 56;
// vWeather.Scene.Tab[vTabNum].General.Temprature.Color := TAlphaColorRec.White;
// vWeather.Scene.Tab[vTabNum].General.Temprature.Position.X := 300;
// vWeather.Scene.Tab[vTabNum].General.Temprature.Position.Y := 60;
// vWeather.Scene.Tab[vTabNum].General.Temprature.text := vDay.Temp;
// vWeather.Scene.Tab[vTabNum].General.Temprature.TextSettings.HorzAlign := TTextAlign.Leading;
// vWeather.Scene.Tab[vTabNum].General.Temprature.Tag := vTabNum;
// vWeather.Scene.Tab[vTabNum].General.Temprature.Visible := True;
// vWeather.Scene.Tab[vTabNum].General.Temprature.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].General.Temprature);
//
// { vWeather.Scene.Tab[vTabNum].General.Temprature_Unit := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.name := 'A_W_WeatherTempratureUnit_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.Font.Size := 18;
// vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.Color := TAlphaColorRec.White;
// vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.Position.X := 310 + vWeather.Scene.Tab[vTabNum].General.Temprature.Width;
// vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.Position.Y := 40;
// vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.Text := vDay.Temp_Unit;
// vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.TextSettings.HorzAlign := TTextAlign.Leading;
// vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.Tag := vTabNum;
// vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.Visible := True; }
//
// vWeather.Scene.Tab[vTabNum].General.Condtition := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].General.Condtition.Name := 'A_W_WeatherTextCondtition_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].General.Condtition.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].General.Condtition.Font.Size := 42;
// vWeather.Scene.Tab[vTabNum].General.Condtition.Color := TAlphaColorRec.White;
// vWeather.Scene.Tab[vTabNum].General.Condtition.Position.X := 300;
// vWeather.Scene.Tab[vTabNum].General.Condtition.Position.Y := 120;
// vWeather.Scene.Tab[vTabNum].General.Condtition.text := vDay.Weather_Desc;
// vWeather.Scene.Tab[vTabNum].General.Condtition.TextSettings.HorzAlign := TTextAlign.Leading;
// vWeather.Scene.Tab[vTabNum].General.Condtition.Tag := vTabNum;
// vWeather.Scene.Tab[vTabNum].General.Condtition.Visible := True;
// vWeather.Scene.Tab[vTabNum].General.Condtition.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].General.Condtition);
//
// vWeather.Scene.Tab[vTabNum].Wind.text := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Wind.text.Name := 'A_W_WeatherWind_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Wind.text.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Wind.text.Font.Size := 22;
// vWeather.Scene.Tab[vTabNum].Wind.text.Color := TAlphaColorRec.Deepskyblue;
// vWeather.Scene.Tab[vTabNum].Wind.text.Position.X := 60;
// vWeather.Scene.Tab[vTabNum].Wind.text.Position.Y := 280;
// vWeather.Scene.Tab[vTabNum].Wind.text.text := 'Wind';
// vWeather.Scene.Tab[vTabNum].Wind.text.TextSettings.HorzAlign := TTextAlign.Leading;
// vWeather.Scene.Tab[vTabNum].Wind.text.Font.Style := vWeather.Scene.Tab[vTabNum].Wind.text.Font.Style + [TFontStyle.fsUnderline];
// vWeather.Scene.Tab[vTabNum].Wind.text.Tag := vTabNum;
// vWeather.Scene.Tab[vTabNum].Wind.text.Visible := True;
// vWeather.Scene.Tab[vTabNum].Wind.text.Width := 80;
//
// vWeather.Scene.Tab[vTabNum].Wind.Speed := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Wind.Speed.Name := 'A_W_WeatherWindSpeed' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Wind.Speed.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Wind.Speed.Font.Size := 22;
// vWeather.Scene.Tab[vTabNum].Wind.Speed.Color := TAlphaColorRec.White;
// vWeather.Scene.Tab[vTabNum].Wind.Speed.Position.X := 60;
// vWeather.Scene.Tab[vTabNum].Wind.Speed.Position.Y := 320;
// vWeather.Scene.Tab[vTabNum].Wind.Speed.text := 'Speed : ' + vDay.Wind_Speed + ' ';
// // + vTown.UnitV.Speed;
// vWeather.Scene.Tab[vTabNum].Wind.Speed.TextSettings.HorzAlign := TTextAlign.Leading;
// vWeather.Scene.Tab[vTabNum].Wind.Speed.Tag := vTabNum;
// vWeather.Scene.Tab[vTabNum].Wind.Speed.Visible := True;
// vWeather.Scene.Tab[vTabNum].Wind.Speed.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Wind.Speed);
//
// vWeather.Scene.Tab[vTabNum].Wind.Direction := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Wind.Direction.Name := 'A_W_WeatherWindDiretion' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Wind.Direction.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Wind.Direction.Font.Size := 22;
// vWeather.Scene.Tab[vTabNum].Wind.Direction.Color := TAlphaColorRec.White;
// vWeather.Scene.Tab[vTabNum].Wind.Direction.Position.X := 60;
// vWeather.Scene.Tab[vTabNum].Wind.Direction.Position.Y := 350;
// vWeather.Scene.Tab[vTabNum].Wind.Direction.text := 'Direction : ' + vDay.Wind_Direction;
// vWeather.Scene.Tab[vTabNum].Wind.Direction.TextSettings.HorzAlign := TTextAlign.Leading;
// vWeather.Scene.Tab[vTabNum].Wind.Direction.Tag := vTabNum;
// vWeather.Scene.Tab[vTabNum].Wind.Direction.Visible := True;
// vWeather.Scene.Tab[vTabNum].Wind.Direction.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Wind.Direction);
//
// vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.Name := 'A_W_WeatherWindDirectionArrow' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.Width := 64;
// vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.Height := 64;
// vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.Position.X := 280;
// vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.Position.Y := 340;
// // vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.WrapMode := TImageWrapMode.Fit;
// // vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_wind_arrow.png');
// vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.RotationAngle := StrToFloat(vDay.Wind_Direction);
// vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.Visible := True;
//
// vWeather.Scene.Tab[vTabNum].Wind.Chill := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Wind.Chill.Name := 'A_W_WeatherWindChill' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Wind.Chill.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Wind.Chill.Font.Size := 22;
// vWeather.Scene.Tab[vTabNum].Wind.Chill.Color := TAlphaColorRec.White;
// vWeather.Scene.Tab[vTabNum].Wind.Chill.Position.X := 60;
// vWeather.Scene.Tab[vTabNum].Wind.Chill.Position.Y := 380;
// vWeather.Scene.Tab[vTabNum].Wind.Chill.text := 'Chill : '; // + vTown.Wind.Chill;
// vWeather.Scene.Tab[vTabNum].Wind.Chill.TextSettings.HorzAlign := TTextAlign.Leading;
// vWeather.Scene.Tab[vTabNum].Wind.Chill.Tag := vTabNum;
// vWeather.Scene.Tab[vTabNum].Wind.Chill.Visible := True;
// vWeather.Scene.Tab[vTabNum].Wind.Chill.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Wind.Chill);
//
// vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon := TImage.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon.Name := 'A_W_WeatherWindChillIcon' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon.Width := 24;
// vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon.Height := 24;
// vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon.Position.X := vWeather.Scene.Tab[vTabNum].Wind.Chill.Width + 70;
// vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon.Position.Y := 392;
// vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon.WrapMode := TImageWrapMode.Fit;
// vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_wind_chill.png');
// vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon.Visible := True;
//
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand := TImage.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand.Name := 'A_W_WeatherWindTurbineSmallStand_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand.Width := 43;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand.Height := 52;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand.Position.X := 318;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand.Position.Y := 270;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand.WrapMode := TImageWrapMode.Fit;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_stand.png');
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand.Visible := True;
//
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small := TImage.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small.Name := 'A_W_WeatherWindSmallTurbine_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small.Width := 54;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small.Height := 54;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small.Position.X := 312;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small.Position.Y := 245;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small.WrapMode := TImageWrapMode.Stretch;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_turbine.png');
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small.Visible := True;
//
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Animation := TFloatAnimation.Create(vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small);
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Animation.Name := 'A_W_WeatherWindSmallTurbineAnimation_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Animation.Parent := vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Animation.PropertyName := 'RotationAngle';
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Animation.Duration := uWeather_Convert_WindSpeed(StrToFloat(vDay.Wind_Speed));
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Animation.StartValue := 0;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Animation.StopValue := 360;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Animation.Loop := True;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Animation.Enabled := True;
//
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand := TImage.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand.Name := 'A_W_WeatherWindTurbineStand_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand.Width := 53;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand.Height := 64;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand.Position.X := 278;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand.Position.Y := 280;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand.WrapMode := TImageWrapMode.Fit;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_stand.png');
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand.Visible := True;
//
// vWeather.Scene.Tab[vTabNum].Wind.Turbine := TImage.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Wind.Turbine.Name := 'A_W_WeatherWindTurbine_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Wind.Turbine.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine.Width := 64;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine.Height := 64;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine.Position.X := 272;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine.Position.Y := 243;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine.WrapMode := TImageWrapMode.Stretch;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_turbine.png');
// vWeather.Scene.Tab[vTabNum].Wind.Turbine.Visible := True;
//
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Animation := TFloatAnimation.Create(vWeather.Scene.Tab[vTabNum].Wind.Turbine);
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Animation.Name := 'A_W_WeatherWindTurbineAnimation_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Animation.Parent := vWeather.Scene.Tab[vTabNum].Wind.Turbine;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Animation.PropertyName := 'RotationAngle';
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Animation.Duration := uWeather_Convert_WindSpeed(StrToFloat(vDay.Wind_Speed));
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Animation.StartValue := 0;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Animation.StopValue := 360;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Animation.Loop := True;
// vWeather.Scene.Tab[vTabNum].Wind.Turbine_Animation.Enabled := True;
//
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Name := 'A_W_WeatherAtmospherePressure' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Font.Size := 22;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Color := TAlphaColorRec.White;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Position.X := 60;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Position.Y := 470;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.text := 'Pressure : ' + vDay.Pressure + ' '; // +
// // vTown.UnitV.Pressure;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.TextSettings.HorzAlign := TTextAlign.Leading;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Tag := vTabNum;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Visible := True;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure);
//
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon.Name := 'A_W_WeatherAtmospherePresureIcon' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon.Width := 24;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon.Height := 24;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon.Position.X := vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Width + 70;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon.Position.Y := 482;
// // vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon.WrapMode := TImageWrapMode.Fit;
// // vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_presure.png');
// vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon.Visible := True;
//
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Name := 'A_W_WeatherAtmosphereVisibility' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Font.Size := 22;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Color := TAlphaColorRec.White;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Position.X := 60;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Position.Y := 500;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.text := 'Visibility : ';
// // + vTown.Atmosphere.Visibility +
// // ' ' + vTown.UnitV.Distance;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.TextSettings.HorzAlign := TTextAlign.Leading;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Tag := vTabNum;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Visible := True;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility);
//
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility_Icon := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility_Icon.Name := 'A_W_WeatherAtmosphereVisibilityIcon' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility_Icon.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility_Icon.Width := 24;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility_Icon.Height := 24;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility_Icon.Position.X := vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Width + 70;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility_Icon.Position.Y := 512;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility_Icon.Visible := True;
//
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.Name := 'A_W_WeatherAtmosphereHumidity' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.Font.Size := 22;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.Color := TAlphaColorRec.White;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.Position.X := 60;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.Position.Y := 560;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.text := 'Humidity : ' + vDay.Humidity + '%';
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.TextSettings.HorzAlign := TTextAlign.Leading;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.Tag := vTabNum;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.Visible := True;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity);
//
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon.Name := 'A_W_WeatherAtmosphereHumidityIcon_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon.Width := 24;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon.Height := 24;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon.Position.X := 220;
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon.Position.Y := 572;
// // vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon.WrapMode := TImageWrapMode.Fit;
// // vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_humidity.png');
// vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon.Visible := True;
//
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Name := 'A_W_WeatherAstronomySunrise_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Font.Size := 22;
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Color := TAlphaColorRec.White;
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Position.X := 60;
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Position.Y := 650;
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.text := 'Sunrise : ' + vDay.Sunrise;
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.TextSettings.HorzAlign := TTextAlign.Leading;
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Tag := vTabNum;
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Visible := True;
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise);
//
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise_Image := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise_Image.Name := 'A_W_WeatherAstronomySunriseImage_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise_Image.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise_Image.SetBounds(60, 670, 42, 42);
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise_Image.Font.Family := 'Weather Icons';
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise_Image.Font.Size := 36;
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise_Image.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise_Image.text := #$f051;
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise_Image.Visible := True;
//
// vWeather.Scene.Tab[vTabNum].Astronomy.sunset := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Astronomy.sunset.Name := 'A_W_WeatherAstronomySunset_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Astronomy.sunset.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Astronomy.sunset.Font.Size := 22;
// vWeather.Scene.Tab[vTabNum].Astronomy.sunset.Color := TAlphaColorRec.White;
// vWeather.Scene.Tab[vTabNum].Astronomy.sunset.Position.X := 60;
// vWeather.Scene.Tab[vTabNum].Astronomy.sunset.Position.Y := 680;
// vWeather.Scene.Tab[vTabNum].Astronomy.sunset.text := 'Sunset : ' + vDay.sunset;
// vWeather.Scene.Tab[vTabNum].Astronomy.sunset.TextSettings.HorzAlign := TTextAlign.Leading;
// vWeather.Scene.Tab[vTabNum].Astronomy.sunset.Tag := vTabNum;
// vWeather.Scene.Tab[vTabNum].Astronomy.sunset.Visible := True;
// vWeather.Scene.Tab[vTabNum].Astronomy.sunset.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Astronomy.sunset);
//
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunset_Image := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunset_Image.Name := 'A_W_WeatherAstronomySunsetImage_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunset_Image.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunset_Image.SetBounds(460, 670, 42, 42);
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunset_Image.Font.Family := 'Weather Icons';
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunset_Image.Font.Size := 36;
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunset_Image.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunset_Image.text := #$f052;
// vWeather.Scene.Tab[vTabNum].Astronomy.Sunset_Image.Visible := True;
//
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot := TImage.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot.Name := 'A_W_WeatherAstronomySpot_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot.Width := 24;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot.Height := 24;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot.Position.X := vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Width + 120;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot.Position.Y := 670;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot.WrapMode := TImageWrapMode.Fit;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_sun.png');
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot.Visible := True;
//
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text := TText.Create(vWeather.Scene.Tab[vTabNum].Astronomy.Spot);
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.Name := 'A_W_Weather_Astronomy_Spot_Text_' + vTabNum.ToString;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.Parent := vWeather.Scene.Tab[vTabNum].Astronomy.Spot;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.Width := 100;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.Height := 18;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.Position.X := -38;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.Position.Y := -16;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.TextSettings.Font.Size := 10;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.TextSettings.FontColor := TAlphaColorRec.White;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.TextSettings.VertAlign := TTextAlign.Center;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.Visible := True;
//
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Ani := TPathAnimation.Create(vWeather.Scene.Tab[vTabNum].Astronomy.Spot);
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Ani.Name := 'A_W_Weather_Astronomy_Spot_Animation';
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Ani.Parent := vWeather.Scene.Tab[vTabNum].Astronomy.Spot;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Ani.Duration := 4;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Ani.Delay := 0.5;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Ani.OnFinish := vWeather_Animation.OnAniStop;
// vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Ani.Enabled := false;
//
// vWeather.Scene.Tab[vTabNum].Server.LastUpDate := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Server.LastUpDate.Name := 'A_W_WeatherLastUpDate_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Server.LastUpDate.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Server.LastUpDate.Font.Size := 16;
// vWeather.Scene.Tab[vTabNum].Server.LastUpDate.Color := TAlphaColorRec.Deepskyblue;
// vWeather.Scene.Tab[vTabNum].Server.LastUpDate.Position.X := 60;
// vWeather.Scene.Tab[vTabNum].Server.LastUpDate.Position.Y := 720;
// vWeather.Scene.Tab[vTabNum].Server.LastUpDate.text := 'Last Update: ' + vDay.Last_Checked;
// vWeather.Scene.Tab[vTabNum].Server.LastUpDate.Tag := vTabNum;
// vWeather.Scene.Tab[vTabNum].Server.LastUpDate.Visible := True;
// vWeather.Scene.Tab[vTabNum].Server.LastUpDate.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Server.LastUpDate);
//
// vWeather.Scene.Tab[vTabNum].Server.Powered_By := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Server.Powered_By.Name := 'A_W_WeatherPoweredBy_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Server.Powered_By.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Server.Powered_By.Font.Size := 16;
// vWeather.Scene.Tab[vTabNum].Server.Powered_By.Color := TAlphaColorRec.Deepskyblue;
// vWeather.Scene.Tab[vTabNum].Server.Powered_By.Position.Y := 710;
// vWeather.Scene.Tab[vTabNum].Server.Powered_By.text := 'Powered by : ';
// vWeather.Scene.Tab[vTabNum].Server.Powered_By.Tag := vTabNum;
// vWeather.Scene.Tab[vTabNum].Server.Powered_By.Visible := True;
// vWeather.Scene.Tab[vTabNum].Server.Powered_By.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Server.Powered_By);
// vWeather.Scene.Tab[vTabNum].Server.Powered_By.Position.X := vWeather.Scene.Tab[vTabNum].Tab.Width -
// (vWeather.Scene.Tab[vTabNum].Server.Powered_By.Width + 70);
//
// vWeather.Scene.Tab[vTabNum].Server.Icon := TImage.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Server.Icon.Name := 'A_W_WeatherPoweredByOpenWeatherMap_Icon_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Server.Icon.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Server.Icon.Width := 64;
// vWeather.Scene.Tab[vTabNum].Server.Icon.Height := 64;
// vWeather.Scene.Tab[vTabNum].Server.Icon.Position.X := vWeather.Scene.Tab[vTabNum].Tab.Width - 70;
// vWeather.Scene.Tab[vTabNum].Server.Icon.Position.Y := 700;
// vWeather.Scene.Tab[vTabNum].Server.Icon.WrapMode := TImageWrapMode.Fit;
// vWeather.Scene.Tab[vTabNum].Server.Icon.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_openweathermap.png');
// vWeather.Scene.Tab[vTabNum].Server.Icon.Visible := True;
//
// { vWeather.Scene.Tab[vTabNum].Forcast.Box := TVertScrollBox.Create(vWeather.Scene.Tab[vTabNum].Tab);
// vWeather.Scene.Tab[vTabNum].Forcast.Box.Name := 'A_W_WeatherForcastBox_' + IntToStr(vTabNum);
// vWeather.Scene.Tab[vTabNum].Forcast.Box.Parent := vWeather.Scene.Tab[vTabNum].Tab;
// vWeather.Scene.Tab[vTabNum].Forcast.Box.Position.Y := 70;
// vWeather.Scene.Tab[vTabNum].Forcast.Box.Position.X := 800;
// vWeather.Scene.Tab[vTabNum].Forcast.Box.Width := 1000;
// vWeather.Scene.Tab[vTabNum].Forcast.Box.Height := 600;
// vWeather.Scene.Tab[vTabNum].Forcast.Box.ShowScrollBars := True;
// vWeather.Scene.Tab[vTabNum].Forcast.Box.Tag := vTabNum;
// vWeather.Scene.Tab[vTabNum].Forcast.Box.Visible := True; }
// end;

function Get_Icon_From_Text(vConditionID: String): String;
begin
  // case vConditionID.ToInteger of
  /// /    200 :
  /// /      Result :=
  // end;
end;

Procedure Set_Lengauge_Text(vLanguage_Index: Integer);
const
  cLanguages: array [0 .. 32] of string = ('Arabic', 'Bulgarian', 'Catalan', 'Czech', 'German', 'Ellinika', 'English', 'Persian (Farsi)', 'Finnish', 'French',
    'Galician', 'Croatian', 'Hungarian', 'Italian', 'Japanese', 'Korean', 'Latvian', 'Lithuaniana', 'Skopje', 'Dutch', 'Polish', 'Portuguese', 'Romanian',
    'Russian', 'Swedish', 'Slovak', 'Slovenian', 'Spanish', 'Turkish', 'Ukrainian', 'Vietnamese', 'Chinese Simplified', 'Chinese Traditional');
  cLanguages_Ext: array [0 .. 32] of string = ('ar', 'bg', 'ca', 'cz', 'de', 'gr', 'en', 'fa', 'fi', 'fr', 'gl', 'hr', 'hu', 'it', 'ja', 'kr', 'la', 'lt', 'mk',
    'nl', 'pl', 'pt', 'ro', 'ru', 'se', 'sk', 'sl', 'es', 'tr', 'ua', 'vi', 'zh_cn', 'zh_tw');
begin
  addons.weather.Action.OWM.Language := cLanguages_Ext[vLanguage_Index];
  addons.weather.Ini.Ini.WriteString('openweathermap', 'language', addons.weather.Action.OWM.Language);
end;

function Get_Language_Num(vLanguage: String): Integer;
const
  cLanguages: array [0 .. 32] of string = ('Arabic', 'Bulgarian', 'Catalan', 'Czech', 'German', 'Ellinika', 'English', 'Persian (Farsi)', 'Finnish', 'French',
    'Galician', 'Croatian', 'Hungarian', 'Italian', 'Japanese', 'Korean', 'Latvian', 'Lithuaniana', 'Skopje', 'Dutch', 'Polish', 'Portuguese', 'Romanian',
    'Russian', 'Swedish', 'Slovak', 'Slovenian', 'Spanish', 'Turkish', 'Ukrainian', 'Vietnamese', 'Chinese Simplified', 'Chinese Traditional');
  cLanguages_Ext: array [0 .. 32] of string = ('ar', 'bg', 'ca', 'cz', 'de', 'gr', 'en', 'fa', 'fi', 'fr', 'gl', 'hr', 'hu', 'it', 'ja', 'kr', 'la', 'lt', 'mk',
    'nl', 'pl', 'pt', 'ro', 'ru', 'se', 'sk', 'sl', 'es', 'tr', 'ua', 'vi', 'zh_cn', 'zh_tw');
var
  vi: Integer;
begin
  for vi := 0 to 32 do
    if cLanguages_Ext[vi] = vLanguage then
    begin
      Result := vi;
      Break
    end;
end;

function Get_Language_From_Short_Desc(vShort_Desk: String): String;
const
  cLanguages: array [0 .. 32] of string = ('Arabic', 'Bulgarian', 'Catalan', 'Czech', 'German', 'Ellinika', 'English', 'Persian (Farsi)', 'Finnish', 'French',
    'Galician', 'Croatian', 'Hungarian', 'Italian', 'Japanese', 'Korean', 'Latvian', 'Lithuaniana', 'Skopje', 'Dutch', 'Polish', 'Portuguese', 'Romanian',
    'Russian', 'Swedish', 'Slovak', 'Slovenian', 'Spanish', 'Turkish', 'Ukrainian', 'Vietnamese', 'Chinese Simplified', 'Chinese Traditional');
  cLanguages_Ext: array [0 .. 32] of string = ('ar', 'bg', 'ca', 'cz', 'de', 'gr', 'en', 'fa', 'fi', 'fr', 'gl', 'hr', 'hu', 'it', 'ja', 'kr', 'la', 'lt', 'mk',
    'nl', 'pl', 'pt', 'ro', 'ru', 'se', 'sk', 'sl', 'es', 'tr', 'ua', 'vi', 'zh_cn', 'zh_tw');
var
  vi: Integer;
begin
  for vi := 0 to 32 do
    if cLanguages_Ext[vi] = vShort_Desk then
      Break;
  Result := cLanguages[vi];
end;

function Get_Icon_Time(vTime: String): String;
begin
  if (vTime = '0:00') or (vTime = '0:00') or (vTime = '12:00') or (vTime = '24:00') then
    Result := #$f089
  else if (vTime = '01:00') or (vTime = '1:00') or (vTime = '13:00') then
    Result := #$f08a
  else if (vTime = '02:00') or (vTime = '2:00') or (vTime = '14:00') then
    Result := #$f08b
  else if (vTime = '03:00') or (vTime = '3:00') or (vTime = '15:00') then
    Result := #$f08c
  else if (vTime = '04:00') or (vTime = '4:00') or (vTime = '16:00') then
    Result := #$f08d
  else if (vTime = '05:00') or (vTime = '5:00') or (vTime = '17:00') then
    Result := #$f08e
  else if (vTime = '06:00') or (vTime = '6:00') or (vTime = '18:00') then
    Result := #$f08f
  else if (vTime = '07:00') or (vTime = '7:00') or (vTime = '19:00') then
    Result := #$f090
  else if (vTime = '08:00') or (vTime = '8:00') or (vTime = '20:00') then
    Result := #$f091
  else if (vTime = '09:00') or (vTime = '9:00') or (vTime = '21:00') then
    Result := #$f092
  else if (vTime = '10:00') or (vTime = '22:00') then
    Result := #$f093
  else if (vTime = '11:00') or (vTime = '23:00') then
    Result := #$f094
end;

function Convert_Wind(vWind: Integer): Single;
begin
  if vWind > 103 then
    Result := 0.1;
  case vWind of
    0 .. 1:
      Result := 0;
    2 .. 5:
      Result := 6;
    6 .. 11:
      Result := 5.2;
    12 .. 19:
      Result := 3.4;
    20 .. 28:
      Result := 2;
    29 .. 38:
      Result := 1.8;
    39 .. 49:
      Result := 1.4;
    50 .. 61:
      Result := 1;
    62 .. 74:
      Result := 0.7;
    75 .. 88:
      Result := 0.4;
    89 .. 102:
      Result := 0.2;
  end;
end;

end.
