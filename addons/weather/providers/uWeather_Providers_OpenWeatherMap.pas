unit uWeather_Providers_OpenWeatherMap;

interface

uses
  System.Classes,
  System.SysUtils,
  System.DateUtils,
  System.JSON,
  IPPeerClient,
  REST.Client,
  REST.Types,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  uWeather_AllTypes;

const
  cOWM_APPID = '5f1cc9b837706de78648b1de3443ccce';

procedure uWeather_Providers_OpenWeatherMap_AddTown(vID: String);
procedure uWeather_Providers_OpenWeatherMap_CreateConfigPanel(vNum: Integer);

function uWeather_Providers_OpenWeatherMap_Unit: String;
function uWeatehr_Providers_OpenWeatherMap_Unit_Word: String;
function uWeather_Providers_OpenWeatherMap_GetForcast(vID: String): TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP;
function uWeather_Providers_OpenWeatherMap_GetForecast_5Days(vID: String)
  : TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP_DAYS;

function uWeather_Providers_OpenWeatherMap_IconShow(vCode: String): String;
function uWeather_Providers_OpenWeatherMap_ConverHeadline_ConfigPanel(vUnixTime: String): String;

var
  vRESTClient: TRESTClient;
  vRESTRequest: TRESTRequest;
  vRESTResponse: TRESTResponse;
  vJSONValue: TJSONValue;
  vDay: TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP;
  vHours: TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP_DAYS;

implementation

uses
  uLoad_AllTypes,
  uWeather_Config_Towns,
  uWeather_Convert;

procedure uWeather_Providers_OpenWeatherMap_AddTown(vID: String);
begin
  inc(addons.weather.Action.Active_Total, 1);
  addons.weather.Ini.Ini.WriteInteger('Active', 'Active_Total', addons.weather.Action.Active_Total);
  if addons.weather.Action.Active_WEOID = -1 then
  begin
    addons.weather.Action.Active_WEOID := 0;
    addons.weather.Ini.Ini.WriteInteger('Active', 'Active_Woeid', addons.weather.Action.Active_WEOID);
  end;
  inc(addons.weather.Action.Provider_Total, 1);
  addons.weather.Ini.Ini.WriteString('openweathermap', addons.weather.Action.Provider_Total.ToString +
    '_WOEID', vID);
  vDay := uWeather_Providers_OpenWeatherMap_GetForcast(vID);
  vHours := uWeather_Providers_OpenWeatherMap_GetForecast_5Days(vID);

  uWeather_Providers_OpenWeatherMap_CreateConfigPanel(addons.weather.Action.Active_Total);
end;

procedure uWeather_Providers_OpenWeatherMap_CreateConfigPanel(vNum: Integer);
var
  vCreatePanel: TADDON_WEATHER_CONFIG_CREATE_PANEL;
begin
  vCreatePanel.Temp := vDay.Temp;
  vCreatePanel.Temp_Unit := uWeatehr_Providers_OpenWeatherMap_Unit_Word;
  vCreatePanel.Temp_Icon := uWeather_Providers_OpenWeatherMap_IconShow(vDay.Weather_ID);
  vCreatePanel.Temp_Description := vDay.Weather_Desc;
  vCreatePanel.City_Name := vDay.City;
  vCreatePanel.Country_Name := uWeather_Convert_CodeToCountryName(LowerCase(vDay.Country_FlagCode));
  vCreatePanel.Country_Flag := vDay.Country_FlagCode;
  // vCreatePanel.Last_Checked:= FormatDateTime('dd+mm-yyyy / hh*mm&ss', UnixToDateTime((vDay.Last_Checked.ToInt64)));
  vCreatePanel.Last_Checked := uWeather_Providers_OpenWeatherMap_ConverHeadline_ConfigPanel
    (vDay.Last_Checked);
  uWeather_Config_Towns_CreateTown_Panel(vNum, vCreatePanel);
end;

function uWeatehr_Providers_OpenWeatherMap_Unit_Word: String;
begin
  if addons.weather.Action.Degree = 'Celcius' then
    Result := 'C'
  else if addons.weather.Action.Degree = 'Fahrenheit' then
    Result := 'F'
  else if addons.weather.Action.Degree = 'Kelvin' then
    Result := 'K';
end;

function uWeather_Providers_OpenWeatherMap_Unit: String;
begin
  if addons.weather.Action.Degree = 'Celcius' then
    Result := 'metric'
  else if addons.weather.Action.Degree = 'Fahrenheit' then
    Result := 'imperial'
  else if addons.weather.Action.Degree = 'Kelvin' then
    Result := '';
end;

function uWeather_Providers_OpenWeatherMap_GetForcast(vID: String): TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP;
var
  vOutValue: String;
begin

  vJSONValue := TJSONValue.Create;

  vRESTClient := TRESTClient.Create('');
  vRESTClient.Name := 'OpenWeatherMap_RestClient';
  vRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
  vRESTClient.BaseURL := 'http://api.openweathermap.org/data/2.5/weather?id=' + vID + '&APPID=' + cOWM_APPID +
    '&units=' + uWeather_Providers_OpenWeatherMap_Unit;
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
  Result.WoeID := vID;
  Result.Longitude := vJSONValue.GetValue<String>('coord.lon');
  Result.Latitude := vJSONValue.GetValue<String>('coord.lat');
  Result.Weather_ID := vJSONValue.GetValue<String>('weather[0].id');
  Result.Weather_Main := vJSONValue.GetValue<String>('weather[0].main');
  Result.Weather_Desc := vJSONValue.GetValue<String>('weather[0].description');
  Result.Weather_Icon := vJSONValue.GetValue<String>('weather[0].icon');
  Result.Temp := vJSONValue.GetValue<String>('main.temp');
  Result.Pressure := vJSONValue.GetValue<String>('main.pressure');
  Result.Humidity := vJSONValue.GetValue<String>('main.humidity');
  Result.Now_Temp_Max := vJSONValue.GetValue<String>('main.temp_max');
  Result.Now_Temp_Min := vJSONValue.GetValue<String>('main.temp_min');
  if vJSONValue.TryGetValue('main.sea_level', vOutValue) then
    Result.Pressure_Sea := vOutValue;
  if vJSONValue.TryGetValue('main.grnd_level', vOutValue) then
    Result.Pressure_Ground := vJSONValue.GetValue<String>('main.grnd_level');
  Result.Visibility := vJSONValue.GetValue<String>('visibility');
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
  Result.Country_FlagCode := vJSONValue.GetValue<String>('sys.country');
  Result.Sunrise := vJSONValue.GetValue<String>('sys.sunrise');
  Result.Sunset := vJSONValue.GetValue<String>('sys.sunset');
  Result.City := vJSONValue.GetValue<String>('name');

  FreeAndNil(vJSONValue);
  FreeAndNil(vRESTRequest);
end;

function uWeather_Providers_OpenWeatherMap_GetForecast_5Days(vID: String)
  : TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP_DAYS;
var
  vOutValue: String;
  vi: Integer;
begin

  vJSONValue := TJSONValue.Create;

  vRESTClient := TRESTClient.Create('');
  vRESTClient.Name := 'OpenWeatherMap_RestClient';
  vRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  vRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
  vRESTClient.BaseURL := 'http://api.openweathermap.org/data/2.5/forecast?id=' + vID + '&APPID=' + cOWM_APPID
    + '&units=' + uWeather_Providers_OpenWeatherMap_Unit;
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
  Result.Country := vJSONValue.GetValue<String>('city.country');
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
    Result.Hour[vi].Weather_Desc := vJSONValue.GetValue<String>
      ('list[' + vi.ToString + '].weather[0].description');
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

function uWeather_Providers_OpenWeatherMap_ConverHeadline_ConfigPanel(vUnixTime: String): String;
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

end.
