unit uWeather_Providers_OpenWeatherMap;

interface

uses
  System.Classes,
  System.SysUtils,
  System.DateUtils,
  System.UiTypes,
  System.JSON,
  FMX.Types,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Ani,
  FMX.Controls,
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
    lat: string;
    lon: string;
    country: string;
    country_code: string;
    city: string;
    text: string;
    id: string;
  end;

const
  cOWM_APPID = '5f1cc9b837706de78648b1de3443ccce';

procedure Main_Create_Towns;

procedure Load;

function Get_Icon_From_Text(vConditionID: String): String;
function Get_Language_Num(vLanguage: String): Integer;
function Get_Language_From_Short_Desc(vShort_Desk: String): String;
Procedure Set_Lengauge_Text(vLanguage_Index: Integer);

procedure uWeather_Providers_OpenWeatherMap_Load_Config;

procedure Woeid_List;

procedure Find_Woeid_Locations(vText: String);

procedure uWeather_Providers_OpenWeatherMap_AddTown_Main(vTabNum: Integer; vTown_Day: TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP;
  vTown_Hour: TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP_DAYS);

procedure uWeather_Providers_OpenWeatherMap_AddTown(vID: String);
procedure uWeather_Providers_OpenWeatherMap_CreateConfigPanel(vNum: Integer);

function uWeather_Providers_OpenWeatherMap_Unit: String;
function uWeatehr_Providers_OpenWeatherMap_Unit_Word: String;
function uWeather_Providers_OpenWeatherMap_GetForcast(vID: String): TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP;
function uWeather_Providers_OpenWeatherMap_GetForecast_5Days(vID: String): TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP_DAYS;

function uWeather_Providers_OpenWeatherMap_IconShow(vCode: String): String;
function uWeather_Providers_OpenWeatherMap_ConvertHeadline_ConfigPanel(vUnixTime: String): String;
function uWeather_Providers_OpenWeatherMap_ConvertTime(vUnixTime: String): String;

var
  vRESTClient: TRESTClient;
  vRESTRequest: TRESTRequest;
  vRESTResponse: TRESTResponse;
  vJSONValue: TJSONValue;
  vDay: TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP;
  vHours: TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP_DAYS;
  vOpenWeatherMap_Find_List: array [0 .. 20] of TWEATHER_PROVIDER_OPENWEATHERMAP_FIND_LIST;

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
  uSnippet_Convert;

procedure Find_Woeid_Locations(vText: String);
var
  vJSONValue: TJSONValue;
  vOutValue, vCount: String;
  vi: Integer;
  vCodeFlag: integer;
begin
  vJSONValue := TJSONValue.Create;
  vJSONValue := uInternet_Files.Get_JSONValue('OpenWeatherMap', 'http://api.geonames.org/searchJSON?name_equals=' + vText + '&username=azrael11');

  vCount := vJSONValue.GetValue<String>('totalResultsCount');

  for vi := 0 to vCount.ToInteger - 1 do
  begin
    vOpenWeatherMap_Find_List[vi].city := vJSONValue.GetValue<String>('geonames[' + vi.ToString + '].name');
    vOpenWeatherMap_Find_List[vi].country := vJSONValue.GetValue<String>('geonames[' + vi.ToString + '].countryName');
    vOpenWeatherMap_Find_List[vi].country_code := vJSONValue.GetValue<String>('geonames[' + vi.ToString + '].countryCode');
    vOpenWeatherMap_Find_List[vi].text := vJSONValue.GetValue<String>('geonames[' + vi.ToString + '].adminName1');
    vOpenWeatherMap_Find_List[vi].id := vJSONValue.GetValue<String>('geonames[' + vi.ToString + '].geonameId');
    vWeather.Config.main.Right.Towns.Add.main.Grid.Cells[0, vi] := IntToStr(vi + 1);

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
    vBackground.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_openweather_loading.png');
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
    vWeather.Scene.Back.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_addtowns.png');
  end;
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
    vDay := uWeather_Providers_OpenWeatherMap_GetForcast(vID);
    vHours := uWeather_Providers_OpenWeatherMap_GetForecast_5Days(vID);
    uWeather_Providers_OpenWeatherMap_CreateConfigPanel(vi);
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

procedure uWeather_Providers_OpenWeatherMap_AddTown(vID: String);
begin
  inc(addons.weather.Action.Active_Total, 1);
  addons.weather.Ini.Ini.WriteInteger('Active', 'Active_Total', addons.weather.Action.Active_Total);
  if addons.weather.Action.Active_WOEID = -1 then
  begin
    addons.weather.Action.Active_WOEID := 0;
    addons.weather.Ini.Ini.WriteInteger('Active', 'Active_Woeid', addons.weather.Action.Active_WOEID);
  end;
  inc(addons.weather.Action.Provider_Total, 1);
  addons.weather.Ini.Ini.WriteInteger('openweathermap', 'Total', addons.weather.Action.Provider_Total);
  addons.weather.Ini.Ini.WriteString('openweathermap', addons.weather.Action.Provider_Total.ToString + '_WOEID', vID);
  vDay := uWeather_Providers_OpenWeatherMap_GetForcast(vID);
  vHours := uWeather_Providers_OpenWeatherMap_GetForecast_5Days(vID);

  uWeather_Providers_OpenWeatherMap_CreateConfigPanel(addons.weather.Action.Active_Total);
  uWeather_Providers_OpenWeatherMap_AddTown_Main(addons.weather.Action.Active_Total, vDay, vHours);
end;

procedure uWeather_Providers_OpenWeatherMap_CreateConfigPanel(vNum: Integer);
var
  vCreatePanel: TADDON_WEATHER_CONFIG_CREATE_PANEL;
begin
  vCreatePanel.Temp := vDay.Temp;
  vCreatePanel.Temp_Unit := uWeatehr_Providers_OpenWeatherMap_Unit_Word;
  vCreatePanel.Temp_Icon := vDay.Weather_Build_Icon;
  vCreatePanel.Temp_Description := vDay.Weather_Desc;
  vCreatePanel.City_Name := vDay.city;
  vCreatePanel.Country_Name := vDay.country;
  vCreatePanel.Country_Flag := vDay.Country_FlagCode;
  vCreatePanel.Last_Checked := vDay.Last_Checked;
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

function uWeather_Providers_OpenWeatherMap_GetForcast(vID: String): TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP;
var
  vOutValue: String;
begin

  vRESTClient := TRESTClient.Create('');
  vRESTClient.Name := 'OpenWeatherMap_RestClient';
  vRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
  vRESTClient.BaseURL := 'http://api.openweathermap.org/data/2.5/weather?id=' + vID + '&APPID=' + cOWM_APPID + '&units=' +
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

  Result.Provider := addons.weather.Action.Provider;
  Result.woeid := vID;
  Result.Longitude := vJSONValue.GetValue<String>('coord.lon');
  Result.Latitude := vJSONValue.GetValue<String>('coord.lat');
  Result.Weather_ID := vJSONValue.GetValue<String>('weather[0].id');
  Result.Weather_Main := vJSONValue.GetValue<String>('weather[0].main');
  Result.Weather_Desc := vJSONValue.GetValue<String>('weather[0].description');
  Result.Weather_Icon := vJSONValue.GetValue<String>('weather[0].icon');
  Result.Weather_Build_Icon := uWeather_Providers_OpenWeatherMap_IconShow(Result.Weather_ID);
  Result.Temp := vJSONValue.GetValue<String>('main.temp');
  Result.Temp_Unit := uWeatehr_Providers_OpenWeatherMap_Unit_Word;
  Result.Pressure := vJSONValue.GetValue<String>('main.pressure');
  Result.Humidity := vJSONValue.GetValue<String>('main.humidity');
  Result.Now_Temp_Max := vJSONValue.GetValue<String>('main.temp_max');
  Result.Now_Temp_Min := vJSONValue.GetValue<String>('main.temp_min');
  if vJSONValue.TryGetValue('main.sea_level', vOutValue) then
    Result.Pressure_Sea := vOutValue;
  if vJSONValue.TryGetValue('main.grnd_level', vOutValue) then
    Result.Pressure_Ground := vOutValue;
  if vJSONValue.TryGetValue('visibility', vOutValue) then
    Result.Visibility := vOutValue;
  Result.Wind_Speed := vJSONValue.GetValue<String>('wind.speed');
  Result.Wind_Direction := vJSONValue.GetValue<String>('wind.deg');
  if vJSONValue.TryGetValue('clounds.all', vOutValue) then
    Result.Clounds := vOutValue;
  if vJSONValue.TryGetValue('rain.1h', vOutValue) then
    Result.Rain_1H := vOutValue;
  if vJSONValue.TryGetValue('rain.3h', vOutValue) then
    Result.Rain_3H := vOutValue;
  if vJSONValue.TryGetValue('snow.1h', vOutValue) then
    Result.Snow_1H := vOutValue;
  if vJSONValue.TryGetValue('snow.3h', vOutValue) then
    Result.Snow_3H := vOutValue;
  Result.Last_Checked := vJSONValue.GetValue<String>('dt');
  Result.Last_Checked := uWeather_Providers_OpenWeatherMap_ConvertHeadline_ConfigPanel(Result.Last_Checked);
  Result.Country_FlagCode := vJSONValue.GetValue<String>('sys.country');
  Result.country := uSnippet_Convert.Code_To_Country(LowerCase(Result.Country_FlagCode));
  Result.Sunrise := vJSONValue.GetValue<String>('sys.sunrise');
  Result.Sunrise := uWeather_Providers_OpenWeatherMap_ConvertTime(Result.Sunrise);
  Result.Sunset := vJSONValue.GetValue<String>('sys.sunset');
  Result.Sunset := uWeather_Providers_OpenWeatherMap_ConvertTime(Result.Sunset);
  Result.city := vJSONValue.GetValue<String>('name');

  FreeAndNil(vJSONValue);
  FreeAndNil(vRESTRequest);
end;

function uWeather_Providers_OpenWeatherMap_GetForecast_5Days(vID: String): TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP_DAYS;
var
  vOutValue: String;
  vi: Integer;
begin

  vJSONValue := TJSONValue.Create;

  vRESTClient := TRESTClient.Create('');
  vRESTClient.Name := 'OpenWeatherMap_RestClient';
  vRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
  vRESTClient.BaseURL := 'http://api.openweathermap.org/data/2.5/forecast?id=' + vID + '&APPID=' + cOWM_APPID + '&units=' +
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

  Result.City_ID := vJSONValue.GetValue<String>('city.id');
  Result.City_Name := vJSONValue.GetValue<String>('city.name');
  Result.Longitude := vJSONValue.GetValue<String>('city.coord.lon');
  Result.Latitude := vJSONValue.GetValue<String>('city.coord.lat');
  Result.country := vJSONValue.GetValue<String>('city.country');
  Result.Count := vJSONValue.GetValue<String>('cnt');

  SetLength(Result.Hour, (Result.Count).ToInteger);

  for vi := 0 to (Result.Count).ToInteger - 1 do
  begin
    Result.Hour[vi].Time := vJSONValue.GetValue<String>('list[' + vi.ToString + '].dt');
    Result.Hour[vi].Temp := vJSONValue.GetValue<String>('list[' + vi.ToString + '].main.temp');
    Result.Hour[vi].Temp_Min := vJSONValue.GetValue<String>('list[' + vi.ToString + '].main.temp_min');
    Result.Hour[vi].Temp_Max := vJSONValue.GetValue<String>('list[' + vi.ToString + '].main.temp_max');
    Result.Hour[vi].Pressure := vJSONValue.GetValue<String>('list[' + vi.ToString + '].main.pressure');
    if vJSONValue.TryGetValue('list[' + vi.ToString + '].main.sea_level', vOutValue) then
      Result.Hour[vi].Pressure_Sea := vOutValue;
    if vJSONValue.TryGetValue('list[' + vi.ToString + '].main.grnd_level', vOutValue) then
      Result.Hour[vi].Pressure_Ground := vOutValue;
    Result.Hour[vi].Humidity := vJSONValue.GetValue<String>('list[' + vi.ToString + '].main.humidity');
    Result.Hour[vi].Weather_ID := vJSONValue.GetValue<String>('list[' + vi.ToString + '].weather[0].id');
    Result.Hour[vi].Weather_Main := vJSONValue.GetValue<String>('list[' + vi.ToString + '].weather[0].main');
    Result.Hour[vi].Weather_Desc := vJSONValue.GetValue<String>('list[' + vi.ToString + '].weather[0].description');
    Result.Hour[vi].Wetaher_Icon := vJSONValue.GetValue<String>('list[' + vi.ToString + '].weather[0].icon');
    Result.Hour[vi].Clouds := vJSONValue.GetValue<String>('list[' + vi.ToString + '].clouds.all');
    Result.Hour[vi].Wind_Speed := vJSONValue.GetValue<String>('list[' + vi.ToString + '].wind.speed');
    Result.Hour[vi].Wind_Direction := vJSONValue.GetValue<String>('list[' + vi.ToString + '].wind.deg');
    if vJSONValue.TryGetValue('list[' + vi.ToString + '].rain.3h', vOutValue) then
      Result.Hour[vi].Rain_3H := vOutValue;
    if vJSONValue.TryGetValue('list[' + vi.ToString + '].snow.3h', vOutValue) then
      Result.Hour[vi].Snow_3H := vOutValue;
    Result.Hour[vi].Last_Checked := vJSONValue.GetValue<String>('list[' + vi.ToString + '].dt_txt');
  end;

  FreeAndNil(vJSONValue);
  FreeAndNil(vRESTRequest);
end;

function uWeather_Providers_OpenWeatherMap_IconShow(vCode: String): String;
begin
  case vCode.ToInteger of
    731:
      Result := '2';
    221:
      Result := '3';
    211:
      Result := '4';
    615:
      Result := '5';
    521:
      Result := '6';
    622:
      Result := '7';
    302:
      Result := '8';
    520:
      Result := '9';
    511:
      Result := '10';
    500:
      Result := '11';
    502:
      Result := '12';
    600:
      Result := '13';
    620:
      Result := '14';
    621:
      Result := '15';
    231:
      Result := '16';
    232:
      Result := '17';
    611:
      Result := '18';
    761:
      Result := '19';
    701:
      Result := '20';
    721:
      Result := '21';
    711:
      Result := '22';
    23:
      Result := '23'; // Not yet
    24:
      Result := '24'; // Not yet
    25:
      Result := '25'; // Not yet
    26:
      Result := '26'; // Not yet
    802:
      Result := '27';
    8082:
      Result := '28';
    803:
      Result := '29';
    8083:
      Result := '30';
    800:
      Result := '31';
    8080:
      Result := '32';
    801:
      Result := '33';
    8081:
      Result := '34';
    35:
      Result := '35'; // Not yet
    36:
      Result := '36'; // Not yet
    210:
      Result := '37';
    212:
      Result := '38';
    200:
      Result := '39';
    501:
      Result := '40';
    6222:
      Result := '41';
    601:
      Result := '42';
    602:
      Result := '43';
    45:
      Result := '45'; // Not yet
    804:
      Result := '46';
    2221:
      Result := '47';
  end;
end;

function uWeather_Providers_OpenWeatherMap_ConvertHeadline_ConfigPanel(vUnixTime: String): String;
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
  Result := vDay + ', ' + vMonth + ' ' + vYear + ' at ' + vTime;
end;

function uWeather_Providers_OpenWeatherMap_ConvertTime(vUnixTime: String): String;
var
  vDateTime: String;
  vIPos: Integer;
begin
  vDateTime := FormatDateTime('dd+mm-yyyy/hh:mm', UnixToDateTime((vUnixTime.ToInt64)));
  vIPos := Pos('/', vDateTime);
  Result := Trim(Copy(vDateTime, vIPos + 1, 5));
end;

procedure uWeather_Providers_OpenWeatherMap_AddTown_Main(vTabNum: Integer; vTown_Day: TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP;
  vTown_Hour: TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP_DAYS);
begin
  vWeather.Scene.Tab[vTabNum].Tab := TALTabItem.Create(vWeather.Scene.Control);
  vWeather.Scene.Tab[vTabNum].Tab.Name := 'A_W_WeatherTab_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Tab.Parent := vWeather.Scene.Control;
  vWeather.Scene.Tab[vTabNum].Tab.Visible := True;

  vWeather.Scene.Tab[vTabNum].General.Image := TImage.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].General.Image.Name := 'A_W_WeatherImage_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].General.Image.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].General.Image.SetBounds(50, 60, 150, 150);
  // vWeather.Scene.Tab[vTabNum].General.Image.Bitmap.LoadFromFile(addons.weather.Path.Iconsets + addons.weather.Config.Iconset.name + '\w_w_' +
  // uWeather_Providers_OpenWeatherMap_IconShow(vDay.Weather_ID) + '.png');
  vWeather.Scene.Tab[vTabNum].General.Image.Tag := vTabNum;
  vWeather.Scene.Tab[vTabNum].General.Image.Visible := True;

  vWeather.Scene.Tab[vTabNum].General.Town_and_Country := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Name := 'A_W_Weather_TownAndCountry_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Font.Size := 42;
  vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab[vTabNum].General.Town_and_Country.text := vDay.city + ' - ' + vDay.country;
  vWeather.Scene.Tab[vTabNum].General.Town_and_Country.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Tag := vTabNum;
  vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Visible := True;
  vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].General.Town_and_Country);
  vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Position.X := (vWeather.Scene.Tab[vTabNum].Tab.Width / 2) -
    (vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Width / 2);
  vWeather.Scene.Tab[vTabNum].General.Town_and_Country.Position.Y := vWeather.Scene.Tab[vTabNum].Tab.Height - 120;

  vWeather.Scene.Tab[vTabNum].General.Temprature := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].General.Temprature.Name := 'A_W_WeatherTemprature_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].General.Temprature.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].General.Temprature.Font.Size := 56;
  vWeather.Scene.Tab[vTabNum].General.Temprature.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab[vTabNum].General.Temprature.Position.X := 300;
  vWeather.Scene.Tab[vTabNum].General.Temprature.Position.Y := 60;
  vWeather.Scene.Tab[vTabNum].General.Temprature.text := vDay.Temp;
  vWeather.Scene.Tab[vTabNum].General.Temprature.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab[vTabNum].General.Temprature.Tag := vTabNum;
  vWeather.Scene.Tab[vTabNum].General.Temprature.Visible := True;
  vWeather.Scene.Tab[vTabNum].General.Temprature.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].General.Temprature);

  { vWeather.Scene.Tab[vTabNum].General.Temprature_Unit := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
    vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.name := 'A_W_WeatherTempratureUnit_' + IntToStr(vTabNum);
    vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.Parent := vWeather.Scene.Tab[vTabNum].Tab;
    vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.Font.Size := 18;
    vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.Color := TAlphaColorRec.White;
    vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.Position.X := 310 + vWeather.Scene.Tab[vTabNum].General.Temprature.Width;
    vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.Position.Y := 40;
    vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.Text := vDay.Temp_Unit;
    vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.TextSettings.HorzAlign := TTextAlign.Leading;
    vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.Tag := vTabNum;
    vWeather.Scene.Tab[vTabNum].General.Temprature_Unit.Visible := True; }

  vWeather.Scene.Tab[vTabNum].General.Condtition := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].General.Condtition.Name := 'A_W_WeatherTextCondtition_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].General.Condtition.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].General.Condtition.Font.Size := 42;
  vWeather.Scene.Tab[vTabNum].General.Condtition.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab[vTabNum].General.Condtition.Position.X := 300;
  vWeather.Scene.Tab[vTabNum].General.Condtition.Position.Y := 120;
  vWeather.Scene.Tab[vTabNum].General.Condtition.text := vDay.Weather_Desc;
  vWeather.Scene.Tab[vTabNum].General.Condtition.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab[vTabNum].General.Condtition.Tag := vTabNum;
  vWeather.Scene.Tab[vTabNum].General.Condtition.Visible := True;
  vWeather.Scene.Tab[vTabNum].General.Condtition.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].General.Condtition);

  vWeather.Scene.Tab[vTabNum].Wind.text := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Wind.text.Name := 'A_W_WeatherWind_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Wind.text.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Wind.text.Font.Size := 22;
  vWeather.Scene.Tab[vTabNum].Wind.text.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab[vTabNum].Wind.text.Position.X := 60;
  vWeather.Scene.Tab[vTabNum].Wind.text.Position.Y := 280;
  vWeather.Scene.Tab[vTabNum].Wind.text.text := 'Wind';
  vWeather.Scene.Tab[vTabNum].Wind.text.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab[vTabNum].Wind.text.Font.Style := vWeather.Scene.Tab[vTabNum].Wind.text.Font.Style + [TFontStyle.fsUnderline];
  vWeather.Scene.Tab[vTabNum].Wind.text.Tag := vTabNum;
  vWeather.Scene.Tab[vTabNum].Wind.text.Visible := True;
  vWeather.Scene.Tab[vTabNum].Wind.text.Width := 80;

  vWeather.Scene.Tab[vTabNum].Wind.Speed := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Wind.Speed.Name := 'A_W_WeatherWindSpeed' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Wind.Speed.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Wind.Speed.Font.Size := 22;
  vWeather.Scene.Tab[vTabNum].Wind.Speed.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab[vTabNum].Wind.Speed.Position.X := 60;
  vWeather.Scene.Tab[vTabNum].Wind.Speed.Position.Y := 320;
  vWeather.Scene.Tab[vTabNum].Wind.Speed.text := 'Speed : ' + vDay.Wind_Speed + ' '; // + vTown.UnitV.Speed;
  vWeather.Scene.Tab[vTabNum].Wind.Speed.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab[vTabNum].Wind.Speed.Tag := vTabNum;
  vWeather.Scene.Tab[vTabNum].Wind.Speed.Visible := True;
  vWeather.Scene.Tab[vTabNum].Wind.Speed.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Wind.Speed);

  vWeather.Scene.Tab[vTabNum].Wind.Direction := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Wind.Direction.Name := 'A_W_WeatherWindDiretion' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Wind.Direction.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Wind.Direction.Font.Size := 22;
  vWeather.Scene.Tab[vTabNum].Wind.Direction.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab[vTabNum].Wind.Direction.Position.X := 60;
  vWeather.Scene.Tab[vTabNum].Wind.Direction.Position.Y := 350;
  vWeather.Scene.Tab[vTabNum].Wind.Direction.text := 'Direction : ' + vDay.Wind_Direction;
  vWeather.Scene.Tab[vTabNum].Wind.Direction.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab[vTabNum].Wind.Direction.Tag := vTabNum;
  vWeather.Scene.Tab[vTabNum].Wind.Direction.Visible := True;
  vWeather.Scene.Tab[vTabNum].Wind.Direction.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Wind.Direction);

  vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.Name := 'A_W_WeatherWindDirectionArrow' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.Width := 64;
  vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.Height := 64;
  vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.Position.X := 280;
  vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.Position.Y := 340;
  // vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.WrapMode := TImageWrapMode.Fit;
  // vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_wind_arrow.png');
  vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.RotationAngle := StrToFloat(vDay.Wind_Direction);
  vWeather.Scene.Tab[vTabNum].Wind.Direction_Arrow.Visible := True;

  vWeather.Scene.Tab[vTabNum].Wind.Chill := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Wind.Chill.Name := 'A_W_WeatherWindChill' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Wind.Chill.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Wind.Chill.Font.Size := 22;
  vWeather.Scene.Tab[vTabNum].Wind.Chill.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab[vTabNum].Wind.Chill.Position.X := 60;
  vWeather.Scene.Tab[vTabNum].Wind.Chill.Position.Y := 380;
  vWeather.Scene.Tab[vTabNum].Wind.Chill.text := 'Chill : '; // + vTown.Wind.Chill;
  vWeather.Scene.Tab[vTabNum].Wind.Chill.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab[vTabNum].Wind.Chill.Tag := vTabNum;
  vWeather.Scene.Tab[vTabNum].Wind.Chill.Visible := True;
  vWeather.Scene.Tab[vTabNum].Wind.Chill.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Wind.Chill);

  vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon := TImage.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon.Name := 'A_W_WeatherWindChillIcon' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon.Width := 24;
  vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon.Height := 24;
  vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon.Position.X := vWeather.Scene.Tab[vTabNum].Wind.Chill.Width + 70;
  vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon.Position.Y := 392;
  vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon.WrapMode := TImageWrapMode.Fit;
  vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_wind_chill.png');
  vWeather.Scene.Tab[vTabNum].Wind.Chill_Icon.Visible := True;

  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand := TImage.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand.Name := 'A_W_WeatherWindTurbineSmallStand_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand.Width := 43;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand.Height := 52;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand.Position.X := 318;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand.Position.Y := 270;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand.WrapMode := TImageWrapMode.Fit;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_stand.png');
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Stand.Visible := True;

  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small := TImage.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small.Name := 'A_W_WeatherWindSmallTurbine_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small.Width := 54;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small.Height := 54;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small.Position.X := 312;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small.Position.Y := 245;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small.WrapMode := TImageWrapMode.Stretch;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_turbine.png');
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small.Visible := True;

  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Animation := TFloatAnimation.Create(vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small);
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Animation.Name := 'A_W_WeatherWindSmallTurbineAnimation_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Animation.Parent := vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Animation.PropertyName := 'RotationAngle';
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Animation.Duration := uWeather_Convert_WindSpeed(StrToFloat(vDay.Wind_Speed));
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Animation.StartValue := 0;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Animation.StopValue := 360;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Animation.Loop := True;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Small_Animation.Enabled := True;

  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand := TImage.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand.Name := 'A_W_WeatherWindTurbineStand_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand.Width := 53;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand.Height := 64;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand.Position.X := 278;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand.Position.Y := 280;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand.WrapMode := TImageWrapMode.Fit;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_stand.png');
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Stand.Visible := True;

  vWeather.Scene.Tab[vTabNum].Wind.Turbine := TImage.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Wind.Turbine.Name := 'A_W_WeatherWindTurbine_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Wind.Turbine.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine.Width := 64;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine.Height := 64;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine.Position.X := 272;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine.Position.Y := 243;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine.WrapMode := TImageWrapMode.Stretch;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_turbine.png');
  vWeather.Scene.Tab[vTabNum].Wind.Turbine.Visible := True;

  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Animation := TFloatAnimation.Create(vWeather.Scene.Tab[vTabNum].Wind.Turbine);
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Animation.Name := 'A_W_WeatherWindTurbineAnimation_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Animation.Parent := vWeather.Scene.Tab[vTabNum].Wind.Turbine;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Animation.PropertyName := 'RotationAngle';
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Animation.Duration := uWeather_Convert_WindSpeed(StrToFloat(vDay.Wind_Speed));
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Animation.StartValue := 0;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Animation.StopValue := 360;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Animation.Loop := True;
  vWeather.Scene.Tab[vTabNum].Wind.Turbine_Animation.Enabled := True;

  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Name := 'A_W_WeatherAtmospherePressure' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Font.Size := 22;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Position.X := 60;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Position.Y := 470;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.text := 'Pressure : ' + vDay.Pressure + ' '; // +
  // vTown.UnitV.Pressure;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Tag := vTabNum;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Visible := True;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure);

  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon.Name := 'A_W_WeatherAtmospherePresureIcon' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon.Width := 24;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon.Height := 24;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon.Position.X := vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure.Width + 70;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon.Position.Y := 482;
  // vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon.WrapMode := TImageWrapMode.Fit;
  // vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_presure.png');
  vWeather.Scene.Tab[vTabNum].Atmosphere.Pressure_Icon.Visible := True;

  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Name := 'A_W_WeatherAtmosphereVisibility' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Font.Size := 22;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Position.X := 60;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Position.Y := 500;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.text := 'Visibility : ';
  // + vTown.Atmosphere.Visibility +
  // ' ' + vTown.UnitV.Distance;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Tag := vTabNum;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Visible := True;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility);

  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility_Icon := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility_Icon.Name := 'A_W_WeatherAtmosphereVisibilityIcon' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility_Icon.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility_Icon.Width := 24;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility_Icon.Height := 24;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility_Icon.Position.X := vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility.Width + 70;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility_Icon.Position.Y := 512;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Visibility_Icon.Visible := True;

  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.Name := 'A_W_WeatherAtmosphereHumidity' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.Font.Size := 22;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.Position.X := 60;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.Position.Y := 560;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.text := 'Humidity : ' + vDay.Humidity + '%';
  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.Tag := vTabNum;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.Visible := True;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity);

  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon.Name := 'A_W_WeatherAtmosphereHumidityIcon_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon.Width := 24;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon.Height := 24;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon.Position.X := 220;
  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon.Position.Y := 572;
  // vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon.WrapMode := TImageWrapMode.Fit;
  // vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_humidity.png');
  vWeather.Scene.Tab[vTabNum].Atmosphere.Humidity_Icon.Visible := True;

  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Name := 'A_W_WeatherAstronomySunrise_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Font.Size := 22;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Position.X := 60;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Position.Y := 650;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.text := 'Sunrise : ' + vDay.Sunrise;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Tag := vTabNum;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Visible := True;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise);

  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise_Image := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise_Image.Name := 'A_W_WeatherAstronomySunriseImage_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise_Image.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise_Image.SetBounds(60, 670, 42, 42);
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise_Image.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise_Image.Font.Size := 36;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise_Image.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise_Image.text := #$f051;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise_Image.Visible := True;

  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset.Name := 'A_W_WeatherAstronomySunset_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset.Font.Size := 22;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset.Position.X := 60;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset.Position.Y := 680;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset.text := 'Sunset : ' + vDay.Sunset;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset.Tag := vTabNum;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset.Visible := True;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Astronomy.Sunset);

  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset_Image := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset_Image.Name := 'A_W_WeatherAstronomySunsetImage_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset_Image.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset_Image.SetBounds(460, 670, 42, 42);
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset_Image.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset_Image.Font.Size := 36;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset_Image.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset_Image.text := #$f052;
  vWeather.Scene.Tab[vTabNum].Astronomy.Sunset_Image.Visible := True;

  vWeather.Scene.Tab[vTabNum].Astronomy.Spot := TImage.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot.Name := 'A_W_WeatherAstronomySpot_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot.Width := 24;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot.Height := 24;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot.Position.X := vWeather.Scene.Tab[vTabNum].Astronomy.Sunrise.Width + 120;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot.Position.Y := 670;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot.WrapMode := TImageWrapMode.Fit;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_sun.png');
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot.Visible := True;

  vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text := TText.Create(vWeather.Scene.Tab[vTabNum].Astronomy.Spot);
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.Name := 'A_W_Weather_Astronomy_Spot_Text_' + vTabNum.ToString;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.Parent := vWeather.Scene.Tab[vTabNum].Astronomy.Spot;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.Width := 100;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.Height := 18;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.Position.X := -38;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.Position.Y := -16;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.TextSettings.Font.Size := 10;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.TextSettings.FontColor := TAlphaColorRec.White;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.TextSettings.VertAlign := TTextAlign.Center;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Text.Visible := True;

  vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Ani := TPathAnimation.Create(vWeather.Scene.Tab[vTabNum].Astronomy.Spot);
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Ani.Name := 'A_W_Weather_Astronomy_Spot_Animation';
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Ani.Parent := vWeather.Scene.Tab[vTabNum].Astronomy.Spot;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Ani.Duration := 4;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Ani.Delay := 0.5;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Ani.OnFinish := vWeather_Animation.OnAniStop;
  vWeather.Scene.Tab[vTabNum].Astronomy.Spot_Ani.Enabled := False;

  vWeather.Scene.Tab[vTabNum].Server.LastUpDate := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Server.LastUpDate.Name := 'A_W_WeatherLastUpDate_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Server.LastUpDate.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Server.LastUpDate.Font.Size := 16;
  vWeather.Scene.Tab[vTabNum].Server.LastUpDate.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab[vTabNum].Server.LastUpDate.Position.X := 60;
  vWeather.Scene.Tab[vTabNum].Server.LastUpDate.Position.Y := 720;
  vWeather.Scene.Tab[vTabNum].Server.LastUpDate.text := 'Last Update: ' + vDay.Last_Checked;
  vWeather.Scene.Tab[vTabNum].Server.LastUpDate.Tag := vTabNum;
  vWeather.Scene.Tab[vTabNum].Server.LastUpDate.Visible := True;
  vWeather.Scene.Tab[vTabNum].Server.LastUpDate.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Server.LastUpDate);

  vWeather.Scene.Tab[vTabNum].Server.Powered_By := TText.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Server.Powered_By.Name := 'A_W_WeatherPoweredBy_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Server.Powered_By.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Server.Powered_By.Font.Size := 16;
  vWeather.Scene.Tab[vTabNum].Server.Powered_By.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab[vTabNum].Server.Powered_By.Position.Y := 710;
  vWeather.Scene.Tab[vTabNum].Server.Powered_By.text := 'Powered by : ';
  vWeather.Scene.Tab[vTabNum].Server.Powered_By.Tag := vTabNum;
  vWeather.Scene.Tab[vTabNum].Server.Powered_By.Visible := True;
  vWeather.Scene.Tab[vTabNum].Server.Powered_By.Width := uSnippet_Text_ToPixels(vWeather.Scene.Tab[vTabNum].Server.Powered_By);
  vWeather.Scene.Tab[vTabNum].Server.Powered_By.Position.X := vWeather.Scene.Tab[vTabNum].Tab.Width -
    (vWeather.Scene.Tab[vTabNum].Server.Powered_By.Width + 70);

  vWeather.Scene.Tab[vTabNum].Server.Icon := TImage.Create(vWeather.Scene.Tab[vTabNum].Tab);
  vWeather.Scene.Tab[vTabNum].Server.Icon.Name := 'A_W_WeatherPoweredByOpenWeatherMap_Icon_' + IntToStr(vTabNum);
  vWeather.Scene.Tab[vTabNum].Server.Icon.Parent := vWeather.Scene.Tab[vTabNum].Tab;
  vWeather.Scene.Tab[vTabNum].Server.Icon.Width := 64;
  vWeather.Scene.Tab[vTabNum].Server.Icon.Height := 64;
  vWeather.Scene.Tab[vTabNum].Server.Icon.Position.X := vWeather.Scene.Tab[vTabNum].Tab.Width - 70;
  vWeather.Scene.Tab[vTabNum].Server.Icon.Position.Y := 700;
  vWeather.Scene.Tab[vTabNum].Server.Icon.WrapMode := TImageWrapMode.Fit;
  vWeather.Scene.Tab[vTabNum].Server.Icon.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_openweathermap.png');
  vWeather.Scene.Tab[vTabNum].Server.Icon.Visible := True;

  { vWeather.Scene.Tab[vTabNum].Forcast.Box := TVertScrollBox.Create(vWeather.Scene.Tab[vTabNum].Tab);
    vWeather.Scene.Tab[vTabNum].Forcast.Box.Name := 'A_W_WeatherForcastBox_' + IntToStr(vTabNum);
    vWeather.Scene.Tab[vTabNum].Forcast.Box.Parent := vWeather.Scene.Tab[vTabNum].Tab;
    vWeather.Scene.Tab[vTabNum].Forcast.Box.Position.Y := 70;
    vWeather.Scene.Tab[vTabNum].Forcast.Box.Position.X := 800;
    vWeather.Scene.Tab[vTabNum].Forcast.Box.Width := 1000;
    vWeather.Scene.Tab[vTabNum].Forcast.Box.Height := 600;
    vWeather.Scene.Tab[vTabNum].Forcast.Box.ShowScrollBars := True;
    vWeather.Scene.Tab[vTabNum].Forcast.Box.Tag := vTabNum;
    vWeather.Scene.Tab[vTabNum].Forcast.Box.Visible := True; }
end;

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
  Result:= cLanguages[vi];
end;

end.
