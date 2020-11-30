unit uWeather_Providers_Yahoo;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  System.Inifiles,
  System.JSON,
  System.Types,
  FMX.Forms,
  FMX.Objects,
  FMX.Types,
  FMX.Ani,
  FMX.Layouts,
  FMX.Controls,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Effects,
  FMX.StdCtrls,
  FMX.Filter.Effects,
  IPPeerClient,
  REST.Client,
  REST.Types,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  uWeather_AllTypes,
  Radiant.Shapes,
  ALFmxTabControl,
  BASS, Winapi.ShellAPI;

type
  TWEATHER_PROVIDER_YAHOO_FIND_LIST = record
    Woeid: string;
    lat: string;
    lon: string;
    country: string;
    city: string;
    Text: string;
  end;

type
  TWEATHER_PROVIDER_YAHOO_DATE_TIME = record
    Full: String;
    Date: String;
    Time: String;
  end;

procedure Woeid_List;

procedure Main_Create_Towns;

procedure Find_Woeid_Locations(vText: String);
procedure Show_Locations;

procedure Main_Create_Hourly(vTown: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN; vTab: Integer);
procedure Main_Create_Daily(vTown: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN; vTab: Integer);
procedure Main_Create_Town(vTown: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN; vTab: Integer);
procedure Add_NewTown(vNum: Integer);

function Get_Forecast(vNum: Integer; vWoeid: String): TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN;
function Is_Town_Exists(vWoeid: String): Boolean;

function Get_Text_From_Meta(vConditionCode: String): String;
function Get_Icon_From_Text(vConditionCodeText: String): String;
function Get_Unit(vUnit: String): String;
function Get_Icon_Time(vTime: String): String;
function Get_Moon_Phase(vPhase: String): String;
function Get_Best_Img_Res(vTown: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN; vMax: Integer): TBitmap;
function Convert_Degree(vDegree_Num, vType: String): String;
function Convert_Time(vTime, vDay: String): TWEATHER_PROVIDER_YAHOO_DATE_TIME;
function Convert_Day(vDay: Integer): String;
function Convert_Month(vMonth: WideString): WideString;
function Convert_Astronomy(vTime: String): WideString;
function Convert_Wind(vWind: Integer): Single;
function Convert_To_Celcius(vImperial_Num: String): String;
function Convert_To_Millibar(vImperial_Num: String): String;
function Convert_To_Kilometres(vImperial_Num: String): String;
function Get_Flag(vCountry: String): TBitmap;

procedure Use_Imperial;
procedure Use_Metric;

procedure Apply_New_Forecast_To_Tonw(vRefreshed_Data: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN; vIndex: Integer);
procedure Refresh_Town(vTown_Index: Integer);
procedure Show_Hourly(IsShow: Boolean);
procedure Show_Daily(IsShow: Boolean);
procedure Show_Image;

procedure Show_Town_Image(vState: String);

procedure Show_Map(vTab_Num: String);
procedure Update_Time(vTab: Integer);

procedure Slide_Right;
procedure Slide_Left;

procedure UpDate_SunSpot;

procedure Go_To_Website;

var
  vYahoo_Find_List: array [0 .. 100] of TWEATHER_PROVIDER_YAHOO_FIND_LIST;
  vFound_Locations: Integer;
  vBest_Img_Num: Integer;
  // Time
  vTime: TTimer;

implementation

uses
  uLoad_AllTypes,
  uDB_AUser,
  uDB,
  uSnippet_Text,
  uSnippet_Convert,
  uInternet_Files,
  uWeather_Actions,
  uWeather_Config_Towns,
  uWeather_Config_Towns_Add,
  uWeather_Convert,
  uWeather_Providers_Yahoo_Config, uWeather_Sounds;

procedure Woeid_List;
var
  vi: Integer;
  vString: String;
  vIPos: Integer;
  vWoeid: String;
  vTown: String;
begin
  // weather.Action.Yahoo.Woeid_List := TStringList.Create;
  // weather.Action.Yahoo.Towns_List := TStringList.Create;

  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count <> -1 then
  begin
    for vi := 0 to uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count do
    begin
      // vString := addons.weather.Ini.Ini.ReadString('yahoo', 'woeid_' + vi.ToString, vString);
      vIPos := Pos('_', vString);
      vWoeid := Trim(Copy(vString, 0, vIPos - 1));
      vTown := Trim(Copy(vString, vIPos + 1, length(vString) - vIPos));
      // weather.Action.Yahoo.Woeid_List.Add(vWoeid);
      // weather.Action.Yahoo.Towns_List.Add(vTown);
    end;
  end;
end;

procedure Find_Woeid_Locations(vText: String);
var
  vJSONValue: TJSONValue;
  vOutValue: String;
  vi: Integer;
  function Fix_Country_Name(vCountry: string): string;
  begin
    if vCountry = 'United States' then
      Result := 'United States of America'
    else
      Result := vCountry;
  end;

begin
  vJSONValue := uInternet_Files.JSONValue('Yahoo', 'https://www.yahoo.com/news/_tdnews/api/resource/WeatherSearch;text=' + vText, TRESTRequestMethod.rmGET);
  vi := -1;
  repeat
    if vJSONValue.TryGetValue('[' + (vi + 1).ToString + '].woeid', vOutValue) then
    begin
      inc(vi, 1);
      vYahoo_Find_List[vi].Woeid := vOutValue;
      vYahoo_Find_List[vi].lat := vJSONValue.GetValue<String>('[' + vi.ToString + '].lat');
      vYahoo_Find_List[vi].lon := vJSONValue.GetValue<String>('[' + vi.ToString + '].lon');
      vYahoo_Find_List[vi].country := vJSONValue.GetValue<String>('[' + vi.ToString + '].country');
      vYahoo_Find_List[vi].city := vJSONValue.GetValue<String>('[' + vi.ToString + '].city');
      vYahoo_Find_List[vi].Text := vJSONValue.GetValue<String>('[' + vi.ToString + '].qualifiedName');
      vYahoo_Find_List[vi].country := Fix_Country_Name(vYahoo_Find_List[vi].country);
    end;
  until vOutValue = '';
  vFound_Locations := vi;
  FreeAndNil(vJSONValue);
end;

procedure Show_Locations;
var
  vi: Integer;
  vCountry_Code: String;
  vCodeFlag: Integer;
begin
  for vi := 0 to vFound_Locations do
  begin
    vWeather.Config.main.Right.Towns.Add.main.Grid.Cells[0, vi] := IntToStr(vi + 1);
    vCountry_Code := uSnippet_Convert.Country_Country_To_Code(vYahoo_Find_List[vi].country);
    vCodeFlag := vCodes.IndexOf(LowerCase(vCountry_Code) + '.png');
    vWeather.Config.main.Right.Towns.Add.main.Grid.Cells[1, vi] := vCodeFlag.ToString;
    vWeather.Config.main.Right.Towns.Add.main.Grid.Cells[2, vi] := vYahoo_Find_List[vi].city;
    vWeather.Config.main.Right.Towns.Add.main.Grid.Cells[3, vi] := vYahoo_Find_List[vi].Text;
    vWeather.Config.main.Right.Towns.Add.main.Grid.Cells[4, vi] := vYahoo_Find_List[vi].country;
  end;
  if vFound_Locations <> -1 then
  begin
    vWeather.Config.main.Right.Towns.Add.main.Add.Enabled := True;
    vWeather.Config.main.Right.Towns.Add.main.Add_Stay.Enabled := True;
  end;
end;

function Is_Town_Exists(vWoeid: String): Boolean;
begin
  Result := False;
  if uDB.Query_Count(uDB.ExtraFE_Query_Local, 'addon_weather_yahoo', 'TOWN_WOEID', vWoeid) <> 0 then
    Result := True;
end;

procedure Add_NewTown(vNum: Integer);
var
  vTemp_NewTown: TADDON_WEATHER_CONFIG_TOWNS_NEWTOWNPANEL;
  vi, vk, vTown_Num: Integer;
begin
  if Is_Town_Exists(vYahoo_Find_List[vNum].Woeid) then
    ShowMessage('This town already exists in your list')
  else
  begin
    inc(uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count, 1);
    vTown_Num := uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count;
    SetLength(uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns, vTown_Num + 1);
    SetLength(weather.Action.Yahoo.Data_Town, vTown_Num + 1);
    weather.Action.Yahoo.Data_Town[vTown_Num - 1] := Get_Forecast(vTown_Num, vYahoo_Find_List[vNum].Woeid);

    vTemp_NewTown.Time_Results := Convert_Time(weather.Action.Yahoo.Data_Town[vTown_Num - 1].Observation.Time.TimeStamp,
      weather.Action.Yahoo.Data_Town[vTown_Num - 1].Observation.Time.WeekDay).Full;
    vTemp_NewTown.Forecast_Image := Get_Icon_From_Text(weather.Action.Yahoo.Data_Town[vTown_Num - 1].Observation.ConditionCode);
    vTemp_NewTown.Temperature := weather.Action.Yahoo.Data_Town[vTown_Num - 1].Observation.Tempreture.Now;
    vTemp_NewTown.Temrerature_Unit := Get_Unit(weather.Action.Yahoo.Data_Town[vTown_Num - 1].vUnit);
    vTemp_NewTown.Temperature_Description := weather.Action.Yahoo.Data_Town[vTown_Num - 1].Observation.ConditionDescription;
    vTemp_NewTown.City_Name := weather.Action.Yahoo.Data_Town[vTown_Num - 1].Location.City_Name;
    vTemp_NewTown.Country_Name := weather.Action.Yahoo.Data_Town[vTown_Num - 1].Location.Country_Name;
    vTemp_NewTown.Country_Flag := Get_Flag(weather.Action.Yahoo.Data_Town[vTown_Num - 1].Location.Country_Name);

    uWeather_Providers_Yahoo_Config.Towns_Add_New_Town(vTown_Num - 1, vTemp_NewTown);

    uDB.vColumns := 'User_ID, Town_Num, Town_WOEID, Town_Name';
    uDB.vValues := '"' + uDB_AUser.Local.USER.Num.ToString + '", "' + (vTown_Num - 1).ToString + '", "' + vYahoo_Find_List[vNum].Woeid + '", "' +
      vTemp_NewTown.City_Name + '"';

    uDB.Query_Insert(uDB.ExtraFE_Query_Local, 'addon_weather_yahoo', uDB.vColumns, uDB.vValues);

    Main_Create_Town(weather.Action.Yahoo.Data_Town[vTown_Num - 1], vWeather.Scene.Control.TabCount);
    if vTown_Num > 1 then
      vWeather.Scene.Arrow_Right.Visible := True;

    uWeather_Actions.First_Info(False, '', '', '');

    vWeather.Config.main.Right.Towns.Add.main.FindTown_V.Text := '';
    for vi := 0 to vWeather.Config.main.Right.Towns.Add.main.Grid.ColumnCount - 1 do
      for vk := 0 to vWeather.Config.main.Right.Towns.Add.main.Grid.RowCount - 1 do
        vWeather.Config.main.Right.Towns.Add.main.Grid.Cells[vi, vk] := '';

    vWeather.Scene.Blur.Enabled := False;
    vWeather.Scene.Blur.Enabled := True;
    Show_Add_Messeage(True, '" ' + vTemp_NewTown.City_Name + ' " added successfully on your list.');
  end;
end;

function Get_Forecast(vNum: Integer; vWoeid: String): TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN;
var
  vJSONValue: TJSONValue;
  vi: Integer;
  vOutValue: String;
begin
  vJSONValue := uInternet_Files.JSONValue('Yahoo_Town', 'https://www.yahoo.com/news/_tdnews/api/resource/WeatherService;woeids=%20[' + vWoeid + ']',
    TRESTRequestMethod.rmGET);

  Result.Woeid := vJSONValue.GetValue<String>('weathers[0].woeid');
  Result.vUnit := vJSONValue.GetValue<String>('weathers[0].unit');
  // Location
  Result.Location.Woeid := vJSONValue.GetValue<String>('weathers[0].location.woeid');
  Result.Location.Photo_WoeID := vJSONValue.GetValue<String>('weathers[0].location.photoWoeid');
  Result.Location.Country_Name := vJSONValue.GetValue<String>('weathers[0].location.countryName');
  Result.Location.City_Name := vJSONValue.GetValue<String>('weathers[0].location.displayName');
  Result.Location.Latitude := vJSONValue.GetValue<String>('weathers[0].location.latitude');
  Result.Location.Longitude := vJSONValue.GetValue<String>('weathers[0].location.longitude');
  Result.Location.OffSetSecs := vJSONValue.GetValue<String>('weathers[0].location.offsetSecs');
  // Observation
  Result.Observation.BarometricPressure := vJSONValue.GetValue<String>('weathers[0].observation.barometricPressure');
  Result.Observation.BarometricPressure_Metric := Convert_To_Millibar(Result.Observation.BarometricPressure);
  Result.Observation.ConditionCode := vJSONValue.GetValue<String>('weathers[0].observation.conditionCode');
  Result.Observation.ConditionDescription := vJSONValue.GetValue<String>('weathers[0].observation.conditionDescription');
  Result.Observation.Day_Part[0].Desc := vJSONValue.GetValue<String>('weathers[0].observation.dayPartTexts[0].text');
  Result.Observation.Day_Part[0].Part := vJSONValue.GetValue<String>('weathers[0].observation.dayPartTexts[0].dayPart');
  Result.Observation.Day_Part[1].Desc := vJSONValue.GetValue<String>('weathers[0].observation.dayPartTexts[1].text');
  Result.Observation.Day_Part[1].Part := vJSONValue.GetValue<String>('weathers[0].observation.dayPartTexts[1].dayPart');
  Result.Observation.Tempreture.Now := vJSONValue.GetValue<String>('weathers[0].observation.temperature.now');
  Result.Observation.Tempreture.Now_Metric := Convert_To_Celcius(Result.Observation.Tempreture.Now);
  Result.Observation.Tempreture.High := vJSONValue.GetValue<String>('weathers[0].observation.temperature.high');
  Result.Observation.Tempreture.High_Metric := Convert_To_Celcius(Result.Observation.Tempreture.High);
  Result.Observation.Tempreture.Low := vJSONValue.GetValue<String>('weathers[0].observation.temperature.low');
  Result.Observation.Tempreture.Low_Metric := Convert_To_Celcius(Result.Observation.Tempreture.Low);
  Result.Observation.Tempreture.FeelsLike := vJSONValue.GetValue<String>('weathers[0].observation.temperature.feelsLike');
  Result.Observation.Tempreture.FeelsLike_Metric := Convert_To_Celcius(Result.Observation.Tempreture.FeelsLike);
  Result.Observation.Time.Day := vJSONValue.GetValue<String>('weathers[0].observation.observationTime.day');
  Result.Observation.Time.Hour := vJSONValue.GetValue<String>('weathers[0].observation.observationTime.hour');
  Result.Observation.Time.WeekDay := vJSONValue.GetValue<String>('weathers[0].observation.observationTime.weekday');
  Result.Observation.Time.TimeStamp := vJSONValue.GetValue<String>('weathers[0].observation.observationTime.timestamp');
  Result.Observation.Humidity := vJSONValue.GetValue<String>('weathers[0].observation.humidity');
  Result.Observation.PrecipitationProbability := vJSONValue.GetValue<String>('weathers[0].observation.precipitationProbability');
  Result.Observation.UVDescription := vJSONValue.GetValue<String>('weathers[0].observation.uvDescription');
  Result.Observation.UVIndex := vJSONValue.GetValue<String>('weathers[0].observation.uvIndex');
  Result.Observation.Visibility := vJSONValue.GetValue<String>('weathers[0].observation.visibility');
  Result.Observation.Visibility_Metric := Convert_To_Kilometres(Result.Observation.Visibility);
  Result.Observation.WindDirection := vJSONValue.GetValue<String>('weathers[0].observation.windDirection');
  Result.Observation.WindDirectionCode := vJSONValue.GetValue<String>('weathers[0].observation.windDirectionCode');
  Result.Observation.WindSpeed := vJSONValue.GetValue<String>('weathers[0].observation.windSpeed');
  Result.Observation.WindSpeed_Metric := Convert_To_Kilometres(Result.Observation.WindSpeed);
  Result.Observation.LocalTime.Day := vJSONValue.GetValue<String>('weathers[0].observation.localTime.day');
  Result.Observation.LocalTime.Hour := vJSONValue.GetValue<String>('weathers[0].observation.localTime.hour');
  Result.Observation.LocalTime.WeekDay := vJSONValue.GetValue<String>('weathers[0].observation.localTime.weekday');
  Result.Observation.LocalTime.TimeStamp := vJSONValue.GetValue<String>('weathers[0].observation.localTime.timestamp');
  // Forecasts
  for vi := 0 to 24 do
  begin
    if vJSONValue.TryGetValue('weathers[0].forecasts.hourly[' + vi.ToString + '].conditionCode', vOutValue) then
    begin
      Result.Forcasts.Hourly[vi].ConditionCode := vJSONValue.GetValue<String>('weathers[0].forecasts.hourly[' + vi.ToString + '].conditionCode');
      Result.Forcasts.Hourly[vi].ConditionDescription := vJSONValue.GetValue<String>('weathers[0].forecasts.hourly[' + vi.ToString + '].conditionDescription');
      Result.Forcasts.Hourly[vi].Temperature.Now := vJSONValue.GetValue<String>('weathers[0].forecasts.hourly[' + vi.ToString + '].temperature.now');
      Result.Forcasts.Hourly[vi].Temperature.Now_Metric := Convert_To_Celcius(Result.Forcasts.Hourly[vi].Temperature.Now);
      Result.Forcasts.Hourly[vi].Temperature.FeelsLike := vJSONValue.GetValue<String>('weathers[0].forecasts.hourly[' + vi.ToString +
        '].temperature.feelsLike');
      Result.Forcasts.Hourly[vi].Temperature.FeelsLike_Metric := Convert_To_Celcius(Result.Forcasts.Hourly[vi].Temperature.FeelsLike);
      Result.Forcasts.Hourly[vi].Time.Day := vJSONValue.GetValue<String>('weathers[0].forecasts.hourly[' + vi.ToString + '].observationTime.day');
      Result.Forcasts.Hourly[vi].Time.Hour := vJSONValue.GetValue<String>('weathers[0].forecasts.hourly[' + vi.ToString + '].observationTime.hour');
      Result.Forcasts.Hourly[vi].Time.WeekDay := vJSONValue.GetValue<String>('weathers[0].forecasts.hourly[' + vi.ToString + '].observationTime.weekday');
      Result.Forcasts.Hourly[vi].Time.TimeStamp := vJSONValue.GetValue<String>('weathers[0].forecasts.hourly[' + vi.ToString + '].observationTime.timestamp');
      Result.Forcasts.Hourly[vi].Humidity := vJSONValue.GetValue<String>('weathers[0].forecasts.hourly[' + vi.ToString + '].humidity');
      Result.Forcasts.Hourly[vi].PrecipitationProbability :=
        vJSONValue.GetValue<String>('weathers[0].forecasts.hourly[' + vi.ToString + '].precipitationProbability');
      Result.Forcasts.Hourly[vi].WindDirection := vJSONValue.GetValue<String>('weathers[0].forecasts.hourly[' + vi.ToString + '].windDirection');
      Result.Forcasts.Hourly[vi].WindDirectionCode := vJSONValue.GetValue<String>('weathers[0].forecasts.hourly[' + vi.ToString + '].windDirectionCode');
      Result.Forcasts.Hourly[vi].WindSpeed := vJSONValue.GetValue<String>('weathers[0].forecasts.hourly[' + vi.ToString + '].windSpeed');
      Result.Forcasts.Hourly[vi].WindSpeed_Metric := Convert_To_Kilometres(Result.Forcasts.Hourly[vi].WindSpeed);
      Result.Forcasts.Hourly[vi].LocalTime.Day := vJSONValue.GetValue<String>('weathers[0].forecasts.hourly[' + vi.ToString + '].localTime.day');
      Result.Forcasts.Hourly[vi].LocalTime.Hour := vJSONValue.GetValue<String>('weathers[0].forecasts.hourly[' + vi.ToString + '].localTime.hour');
      Result.Forcasts.Hourly[vi].LocalTime.WeekDay := vJSONValue.GetValue<String>('weathers[0].forecasts.hourly[' + vi.ToString + '].localTime.weekday');
      Result.Forcasts.Hourly[vi].LocalTime.TimeStamp := vJSONValue.GetValue<String>('weathers[0].forecasts.hourly[' + vi.ToString + '].localTime.timestamp');
    end;
  end;
  for vi := 0 to 10 do
  begin
    Result.Forcasts.Daily[vi].ConditionCode := vJSONValue.GetValue<String>('weathers[0].forecasts.daily[' + vi.ToString + '].conditionCode');
    Result.Forcasts.Daily[vi].ConditionDescription := vJSONValue.GetValue<String>('weathers[0].forecasts.daily[' + vi.ToString + '].conditionDescription');
    Result.Forcasts.Daily[vi].Parts[0].Desc := vJSONValue.GetValue<String>('weathers[0].forecasts.daily[' + vi.ToString + '].dayPartTexts[0].text');
    Result.Forcasts.Daily[vi].Parts[0].Part := vJSONValue.GetValue<String>('weathers[0].forecasts.daily[' + vi.ToString + '].dayPartTexts[0].dayPart');
    if vi = 0 then
    begin
      Result.Forcasts.Daily[vi].Parts[1].Desc := vJSONValue.GetValue<String>('weathers[0].forecasts.daily[' + vi.ToString + '].dayPartTexts[1].text');
      Result.Forcasts.Daily[vi].Parts[1].Part := vJSONValue.GetValue<String>('weathers[0].forecasts.daily[' + vi.ToString + '].dayPartTexts[1].dayPart');
    end;
    Result.Forcasts.Daily[vi].Temperature.High := vJSONValue.GetValue<String>('weathers[0].forecasts.daily[' + vi.ToString + '].temperature.high');
    Result.Forcasts.Daily[vi].Temperature.High_Metric := Convert_To_Celcius(Result.Forcasts.Daily[vi].Temperature.High);
    Result.Forcasts.Daily[vi].Temperature.Low := vJSONValue.GetValue<String>('weathers[0].forecasts.daily[' + vi.ToString + '].temperature.low');
    Result.Forcasts.Daily[vi].Temperature.Low_Metric := Convert_To_Celcius(Result.Forcasts.Daily[vi].Temperature.Low);
    Result.Forcasts.Daily[vi].Time.Day := vJSONValue.GetValue<String>('weathers[0].forecasts.daily[' + vi.ToString + '].observationTime.day');
    Result.Forcasts.Daily[vi].Time.Hour := vJSONValue.GetValue<String>('weathers[0].forecasts.daily[' + vi.ToString + '].observationTime.hour');
    Result.Forcasts.Daily[vi].Time.WeekDay := vJSONValue.GetValue<String>('weathers[0].forecasts.daily[' + vi.ToString + '].observationTime.weekday');
    Result.Forcasts.Daily[vi].Time.TimeStamp := vJSONValue.GetValue<String>('weathers[0].forecasts.daily[' + vi.ToString + '].observationTime.timestamp');
    Result.Forcasts.Daily[vi].Humidity := vJSONValue.GetValue<String>('weathers[0].forecasts.daily[' + vi.ToString + '].humidity');
    Result.Forcasts.Daily[vi].PrecipitationProbability := vJSONValue.GetValue<String>('weathers[0].forecasts.daily[' + vi.ToString +
      '].precipitationProbability');
    Result.Forcasts.Daily[vi].LocalTime.Day := vJSONValue.GetValue<String>('weathers[0].forecasts.daily[' + vi.ToString + '].localTime.day');
    Result.Forcasts.Daily[vi].LocalTime.Hour := vJSONValue.GetValue<String>('weathers[0].forecasts.daily[' + vi.ToString + '].localTime.hour');
    Result.Forcasts.Daily[vi].LocalTime.WeekDay := vJSONValue.GetValue<String>('weathers[0].forecasts.daily[' + vi.ToString + '].localTime.weekday');
    Result.Forcasts.Daily[vi].LocalTime.TimeStamp := vJSONValue.GetValue<String>('weathers[0].forecasts.daily[' + vi.ToString + '].localTime.timestamp');
  end;
  // Precipitations
  for vi := 0 to 5 do
  begin
    Result.Precipitations[vi].TimeSlot := vJSONValue.GetValue<String>('weathers[0].precipitations[' + vi.ToString + '].timeSlot');
    Result.Precipitations[vi].Probability := vJSONValue.GetValue<String>('weathers[0].precipitations[' + vi.ToString + '].probability');
  end;
  // Sun and Moon
  Result.SunAndMoon.Sunrise := vJSONValue.GetValue<String>('weathers[0].sunAndMoon.sunrise');
  Result.SunAndMoon.Sunset := vJSONValue.GetValue<String>('weathers[0].sunAndMoon.sunset');
  Result.SunAndMoon.MoonPhase := vJSONValue.GetValue<String>('weathers[0].sunAndMoon.moonPhase');
  // Photos
  if vJSONValue.TryGetValue('weathers[0].photos[0].id', vOutValue) then
  begin
    Result.Photos.ID := vJSONValue.GetValue<String>('weathers[0].photos[0].id');
    Result.Photos.DayOrNight := vJSONValue.GetValue<String>('weathers[0].photos[0].dayOrNight');
    Result.Photos.Owner := vJSONValue.GetValue<String>('weathers[0].photos[0].owner');
    Result.Photos.OwnerName := vJSONValue.GetValue<String>('weathers[0].photos[0].ownerName');
    for vi := 0 to 5 do
    begin
      if vJSONValue.TryGetValue('weathers[0].photos[0].resolutions[' + vi.ToString + '].height', vOutValue) then
      begin
        Result.Photos.resolutions[vi].Height := vJSONValue.GetValue<String>('weathers[0].photos[0].resolutions[' + vi.ToString + '].height');
        Result.Photos.resolutions[vi].Width := vJSONValue.GetValue<String>('weathers[0].photos[0].resolutions[' + vi.ToString + '].width');
        Result.Photos.resolutions[vi].URL := vJSONValue.GetValue<String>('weathers[0].photos[0].resolutions[' + vi.ToString + '].url');
      end;
    end;
  end
  else
    Result.Photos.ID := '-1';
  // Provider
  Result.Provider.Name := vJSONValue.GetValue<String>('weathers[0].provider.name');
  // Meta
  for vi := 0 to 255 do
  begin
    if vJSONValue.TryGetValue('meta.skycode.' + vi.ToString, vOutValue) then
    begin
      Result.Meta.Skycode[vi].Number := vi.ToString;
      Result.Meta.Skycode[vi].Text := vOutValue;
    end
  end;
  for vi := 0 to 255 do
  begin
    if vJSONValue.TryGetValue('meta.conditionMap.' + vi.ToString, vOutValue) then
    begin
      Result.Meta.ConditionMap[vi].Number := vi.ToString;
      Result.Meta.ConditionMap[vi].Text := vOutValue;
    end;
  end;
end;

function Get_Text_From_Meta(vConditionCode: String): String;
var
  vi: Integer;
begin
  for vi := 0 to 255 do
  begin
    if weather.Action.Yahoo.Data_Town[uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count].Meta.Skycode[vi].Number = vConditionCode then
    begin
      Result := weather.Action.Yahoo.Data_Town[uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count].Meta.Skycode[vi].Text;
      Break
    end;
  end;
end;

function Get_Icon_From_Text(vConditionCodeText: String): String;
begin
  case vConditionCodeText.ToInteger of
    0:
      Result := #$f056;
    1:
      Result := #$f00e;
    2:
      Result := #$f073;
    3:
      Result := #$f01e;
    4:
      Result := #$f01e;
    5:
      Result := #$f017;
    6:
      Result := #$f017;
    7:
      Result := #$f017;
    8:
      Result := #$f004;
    9:
      Result := #$f009;
    10:
      Result := #$f004;
    11:
      Result := #$f009;
    12:
      Result := #$f009;
    13:
      Result := #$f01b;
    14:
      Result := #$f00a;
    15:
      Result := #$f065;
    16:
      Result := #$f01b;
    17:
      Result := #$f004;
    18:
      Result := #$f017;
    19:
      Result := #$f063;
    20:
      Result := #$f014;
    21:
      Result := #$f021;
    22:
      Result := #$f062;
    23:
      Result := #$f050;
    24:
      Result := #$f050;
    25:
      Result := #$f076;
    26:
      Result := #$f013;
    27:
      Result := #$f086;
    28:
      Result := #$f002;
    29:
      Result := #$f086;
    30:
      Result := #$f002;
    31:
      Result := #$f02e;
    32:
      Result := #$f00d;
    33:
      Result := #$f083;
    34:
      Result := #$f00c;
    35:
      Result := #$f017;
    36:
      Result := #$f072;
    37:
      Result := #$f00e;
    38:
      Result := #$f00e;
    39:
      Result := #$f00e;
    40:
      Result := #$f009;
    41:
      Result := #$f064;
    42:
      Result := #$f01b;
    43:
      Result := #$f064;
    44:
      Result := #$f00c;
    45:
      Result := #$f00e;
    46:
      Result := #$f01b;
    47:
      Result := #$f00e;
    3200:
      Result := #$f077;
  end;
end;

function Get_Unit(vUnit: String): String;
begin
  if vUnit = 'imperial' then
    Result := #$f045
  else if vUnit = 'celsius' then
    Result := #$f03c;
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

function Get_Moon_Phase(vPhase: String): String;
begin
  case vPhase.ToInteger of
    0:
      Result := #$f0eb;
    1:
      Result := #$f0d0;
    2:
      Result := #$f0d1;
    3:
      Result := #$f0d2;
    4:
      Result := #$f0d3;
    5:
      Result := #$f0d4;
    6:
      Result := #$f0d5;
    7:
      Result := #$f0d6;
    8:
      Result := #$f0d7;
    9:
      Result := #$f0d8;
    10:
      Result := #$f0d9;
    11:
      Result := #$f0da;
    12:
      Result := #$f0db;
    13:
      Result := #$f0dc;
    14:
      Result := #$f0dd;
    15:
      Result := #$f0de;
    16:
      Result := #$f0df;
    17:
      Result := #$f0e0;
    18:
      Result := #$f0e1;
    19:
      Result := #$f0e2;
    20:
      Result := #$f0e3;
    21:
      Result := #$f0e4;
    22:
      Result := #$f0e5;
    23:
      Result := #$f0e6;
    24:
      Result := #$f0e7;
    25:
      Result := #$f0e8;
    26:
      Result := #$f0e9;
    27:
      Result := #$f0ea;
  end;
end;

function Get_Best_Img_Res(vTown: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN; vMax: Integer): TBitmap;
var
  vi: Integer;
begin
  for vi := (vMax - 1) downto 0 do
  begin
    if vTown.Photos.resolutions[vi].URL <> '' then
    begin
      Result := uInternet_Files.Get_Image(vTown.Photos.resolutions[vi].URL);
      if Result <> nil then
      begin
        vBest_Img_Num := vi;
        Break
      end;
    end;
  end;
end;

function Convert_Degree(vDegree_Num, vType: String): String;
begin
  if vType = 'c' then
  begin
    if weather.Action.Yahoo.Data_Town[uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count].vUnit = 'imperial' then
      Result := (Round(vDegree_Num.ToInteger - 32) * (5 / 9)).ToString
    else if weather.Action.Yahoo.Data_Town[uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count].vUnit = 'kelvin' then
      Result := (Round(vDegree_Num.ToInteger - 273.15)).ToString
    else
      Result := vDegree_Num;
  end
  else if vType = 'f' then
  begin
    if weather.Action.Yahoo.Data_Town[uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count].vUnit = 'celsius' then
      Result := (Round((vDegree_Num.ToInteger * 9) / 5) + 32).ToString
    else if weather.Action.Yahoo.Data_Town[uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count].vUnit = 'kelvin' then
      Result := (Round((vDegree_Num.ToInteger * 9) / 5) - 459.67).ToString
    else
      Result := vDegree_Num;
  end
  else if vType = 'k' then
  begin
    if weather.Action.Yahoo.Data_Town[uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count].vUnit = 'celsius' then
      Result := (Round(vDegree_Num.ToInteger + 273.15)).ToString
    else if weather.Action.Yahoo.Data_Town[uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count].vUnit = 'imperial' then
      Result := (Round(vDegree_Num.ToInteger + 459.67) * (5 / 9)).ToString
    else
      Result := vDegree_Num;
  end;
end;

function Convert_Time(vTime, vDay: String): TWEATHER_PROVIDER_YAHOO_DATE_TIME;
var
  vIPos: Integer;
  vCDate: String;
  vCYear, vCMonth, vCDay: String;
  vCTime: String;
  vCDay_Text: String;
begin
  vCDay_Text := Convert_Day(vDay.ToInteger);
  vIPos := Pos('T', vTime);
  vCDate := Trim(Copy(vTime, 0, vIPos - 1));
  vCTime := Trim(Copy(vTime, vIPos + 1, length(vTime) - (vIPos + 1)));
  vIPos := Pos('-', vCDate);
  vCYear := Trim(Copy(vCDate, 0, vIPos - 1));
  vCMonth := Trim(Copy(vCDate, vIPos + 1, length(vCDate) - (vIPos - 1)));
  vIPos := Pos('-', vCMonth);
  vCDay := Trim(Copy(vCMonth, vIPos + 1, length(vCMonth) - (vIPos - 1)));
  vCMonth := Trim(Copy(vCMonth, 0, vIPos - 1));
  vCMonth := Convert_Month(vCMonth);
  vIPos := Pos(':', vCTime);
  vCTime := Trim(Copy(vCTime, 0, vIPos + 2));
  Result.Date := vCDay_Text + ' ' + vCDay + ' ' + vCMonth + ' ' + vCYear;
  Result.Time := vCTime;
  Result.Full := vCDay_Text + ' ' + vCDay + ' ' + vCMonth + ' ' + vCYear + ' : ' + vCTime;
end;

function Convert_Day(vDay: Integer): String;
begin
  case vDay of
    0:
      Result := 'Sunday';
    1:
      Result := 'Monday';
    2:
      Result := 'Tuesday';
    3:
      Result := 'Wednesday';
    4:
      Result := 'Thursday';
    5:
      Result := 'Friday';
    6:
      Result := 'Saturday';
  end;
end;

function Convert_Month(vMonth: WideString): WideString;
begin
  if (vMonth = 'Jan') or (vMonth = '01') then
    Result := 'January'
  else if (vMonth = 'Feb') or (vMonth = '02') then
    Result := 'February'
  else if (vMonth = 'Mar') or (vMonth = '03') then
    Result := 'March'
  else if (vMonth = 'Apr') or (vMonth = '04') then
    Result := 'April'
  else if (vMonth = 'May') or (vMonth = '05') then
    Result := 'May'
  else if (vMonth = 'Jun') or (vMonth = '06') then
    Result := 'June'
  else if (vMonth = 'Jul') or (vMonth = '07') then
    Result := 'Jul'
  else if (vMonth = 'Aug') or (vMonth = '08') then
    Result := 'August'
  else if (vMonth = 'Sep') or (vMonth = '09') then
    Result := 'Septemper'
  else if (vMonth = 'Okt') or (vMonth = '10') then
    Result := 'Oktober'
  else if (vMonth = 'Nov') or (vMonth = '11') then
    Result := 'November'
  else if (vMonth = 'Dec') or (vMonth = '12') then
    Result := 'December'
  else
    Result := 'error...!!!';
end;

function Convert_Astronomy(vTime: String): WideString;
var
  vHour, vMinutes: Integer;
  vHourStr, vMinutesStr: String;
begin
  vHour := Trunc(vTime.ToExtended / 3600);
  vMinutes := vTime.ToInteger - (vHour * 3600);
  vMinutes := Trunc(vMinutes / 60);
  if vHour < 10 then
    vHourStr := '0' + vHour.ToString
  else
    vHourStr := vHour.ToString;
  if vMinutes < 10 then
    vMinutesStr := '0' + vMinutes.ToString
  else
    vMinutesStr := vMinutes.ToString;
  Result := vHourStr + ':' + vMinutesStr;
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

function Convert_To_Celcius(vImperial_Num: String): String;
begin
  Result := Round((vImperial_Num.ToInteger - 32) / 1.8).ToString;
end;

function Convert_To_Millibar(vImperial_Num: String): String;
begin
  Result := Round(vImperial_Num.ToSingle / 0.029530).ToString;
end;

function Convert_To_Kilometres(vImperial_Num: String): String;
begin
  Result := Round(vImperial_Num.ToSingle * 1.6).ToString;
end;

function Get_Flag(vCountry: String): TBitmap;
var
  vCode: String;
begin
  Result := TBitmap.Create;
  vCode := uSnippet_Convert.Country_Country_To_Code(vCountry);
  Result.LoadFromFile(ex_main.Paths.Flags_Images + vCode + '.png');
end;

procedure Main_Create_Towns;
var
  vi: Integer;
  vBackground: TImage;
  vProgress: TProgressBar;
  vProgress_Text, vIcon, vText: TText;
  vProgress_Num: Single;
begin
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count > 0 then
  begin
    vBackground := TImage.Create(vWeather.Scene.Back);
    vBackground.Name := 'A_W_Providers_Yahoo_Loading_Background';
    vBackground.Parent := vWeather.Scene.Back;
    vBackground.SetBounds(0, 10, vWeather.Scene.Back.Width, vWeather.Scene.Back.Height);
    vBackground.Bitmap.LoadFromFile(uDB_AUser.Local.ADDONS.Weather_D.p_Images + 'w_yahoo_loading.png');
    vBackground.WrapMode := TImageWrapMode.Original;
    vBackground.Visible := True;

    vText := TText.Create(vWeather.Scene.Back);
    vText.Name := 'A_W_Providers_Yahoo_Loading_Please_Wait';
    vText.Parent := vWeather.Scene.Back;
    vText.SetBounds(50, 80, 400, 50);
    vText.Font.Family := 'Tahoma';
    vText.Font.Size := 38;
    vText.Text := 'Please Wait...';
    vText.TextSettings.FontColor := TAlphaColorRec.White;
    vText.HorzTextAlign := TTextAlign.Center;
    vText.Visible := True;

    vIcon := TText.Create(vWeather.Scene.Back);
    vIcon.Name := 'A_W_Providers_Yahoo_Loading_Icon';
    vIcon.Parent := vWeather.Scene.Back;
    vIcon.SetBounds(uDB_AUser.Local.SETTINGS.Resolution.Half_Width - 40, vWeather.Scene.Back.Height - 400, 100, 100);
    vIcon.Font.Family := 'Weather Icons';
    vIcon.Font.Size := 72;
    vIcon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vIcon.Text := Get_Icon_From_Text(Random(47).ToString);
    vIcon.Visible := True;

    vProgress_Text := TText.Create(vWeather.Scene.Back);
    vProgress_Text.Name := 'A_W_Providers_Yahoo_Loading_Progress_Text';
    vProgress_Text.Parent := vWeather.Scene.Back;
    vProgress_Text.SetBounds(300, vWeather.Scene.Back.Height - 300, 1320, 50);
    vProgress_Text.Font.Family := 'Tahoma';
    vProgress_Text.Font.Size := 24;
    vProgress_Text.Text := '';
    vProgress_Text.TextSettings.FontColor := TAlphaColorRec.White;
    vProgress_Text.HorzTextAlign := TTextAlign.Leading;
    vProgress_Text.Visible := True;

    vProgress := TProgressBar.Create(vWeather.Scene.Back);
    vProgress.Name := 'A_W_Providers_Yahoo_Loading_Progress';
    vProgress.Parent := vWeather.Scene.Back;
    vProgress.SetBounds(300, vWeather.Scene.Back.Height - 250, 1320, 30);
    vProgress.Max := 100;
    vProgress.Min := 0;
    vProgress.Value := 0;
    vProgress.Visible := True;

    vProgress_Num := 100 / uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count;
    SetLength(weather.Action.Yahoo.Data_Town, uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count + 1);
    for vi := 0 to uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count - 1 do
    begin
      vProgress_Text.Text := 'Getting forecast for "' + uDB.Query_Select(uDB.ExtraFE_Query_Local, 'Town_Name', 'addon_weather_yahoo', 'Town_Num',
        vi.ToString) + '"';
      Application.ProcessMessages;
      weather.Action.Yahoo.Data_Town[vi] := Get_Forecast(vi, uDB.Query_Select(uDB.ExtraFE_Query_Local, 'Town_WOEID', 'addon_weather_yahoo', 'Town_Num',
        vi.ToString));
      Main_Create_Town(weather.Action.Yahoo.Data_Town[vi], vi);
      weather.Action.Yahoo.Data_Town[vi].Photos.Picture_Used_Num := vBest_Img_Num;
      vProgress.Value := vProgress.Value + vProgress_Num;
      vIcon.Text := Get_Icon_From_Text(Random(47).ToString);
      Application.ProcessMessages;
    end;
    vTime := TTimer.Create(vWeather.Scene.Back);
    vTime.Name := 'A_W_Providers_Yahoo_Time';
    vTime.Parent := vWeather.Scene.Back;
    vTime.Interval := 1000;
    vTime.OnTimer := weather.timer.main.OnTimer;
    vTime.Enabled := True;

    if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count > 1 then
    begin
      vWeather.Scene.Arrow_Right.Visible := True;
      vWeather.Scene.Arrow_Right_Text.Visible := True;
      vWeather.Scene.Arrow_Right_Text.Text := 'Next : ' + weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex + 2].Location.City_Name;
    end;

    FreeAndNil(vProgress);
    FreeAndNil(vProgress_Text);
    FreeAndNil(vText);
    FreeAndNil(vIcon);
    FreeAndNil(vBackground);
    uWeather_Actions.First_Info(False, '', '', '');
  end
  else
    uWeather_Actions.First_Info(True, 'Please to add towns select the spinning gear from here ', 'select "Towns" button and then press the + button', '');
end;

procedure Main_Create_Hourly(vTown: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN; vTab: Integer);
var
  vi: Integer;
begin
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Title := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Title.Name := 'A_W_Provider_Yahoo_Hourly_Title';
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Title.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Title.SetBounds(540, 10, 600, 30);
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Title.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Title.Text := 'Hourly forecast : ';
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Title.TextSettings.FontColor := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Title.HorzTextAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Title.Tag := vTab;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Title.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Line := TRadiantLine.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Line.Name := 'A_W_Provider_Yahoo_Hourly_Line';
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Line.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Line.SetBounds(530, 40, 1110, 5);
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Line.LineSlope := TRadiantLineSlope.Horizontal;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Line.Stroke.Kind := TBrushKind.Solid;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Line.Stroke.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Line.Stroke.Thickness := 3;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Line.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Box := THorzScrollBox.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Box.Name := 'A_W_Provider_Yahoo_Hourly_Box';
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Box.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Box.SetBounds(540, 60, 1090, 190);
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Box.ShowScrollBars := True;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Box.Visible := True;

  for vi := 0 to 24 do
  begin
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout := TLayout.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Box);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout.Name := 'A_W_Provider_Yahoo_Hourly_Info_' + vi.ToString;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Box;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout.SetBounds(5 + (vi * 180), 5, 170, 180);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Glow := TInnerGlowEffect.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Glow.Name := 'A_W_Provider_Yahoo_Hourly_Info_Glow';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Glow.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Glow.Opacity := 0.9;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Glow.Enabled := False;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Hour := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Hour.Name := 'A_W_Provider_Yahoo_Hourly_Info_Hour';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Hour.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Hour.SetBounds(5, 5, 170, 30);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Hour.Font.Family := 'Weather Icons';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Hour.Font.Size := 14;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Hour.HorzTextAlign := TTextAlign.Leading;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Hour.TextSettings.FontColor := TAlphaColorRec.White;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Hour.Text := Get_Icon_Time(vTown.Forcasts.Hourly[vi].Time.Hour + ':00') + ' ' +
      vTown.Forcasts.Hourly[vi].Time.Hour + ':00';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Hour.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Text_Icon := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Text_Icon.Name := 'A_W_Provider_Yahoo_Hourly_Info_Text_Image';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Text_Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Text_Icon.SetBounds(15, 25, 90, 90);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Text_Icon.Font.Family := 'Weather Icons';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Text_Icon.Font.Size := 48;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Text_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Text_Icon.Text := Get_Icon_From_Text(vTown.Forcasts.Hourly[vi].ConditionCode);

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Icon := TImage.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Icon.Name := 'A_W_Provider_Yahoo_Hourly_Info_Image';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Icon.SetBounds(15, 25, 90, 90);
    if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Iconset <> 'default' then
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Icon.Bitmap.LoadFromFile(uDB_AUser.Local.ADDONS.Weather_D.p_Icons + 'yahoo\' +
        uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Iconset + '\w_w_' + vTown.Forcasts.Hourly[vi].ConditionCode + '.png');
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Icon.WrapMode := TImageWrapMode.Fit;

    if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Iconset_Selected = 0 then
    begin
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Text_Icon.Visible := True;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Icon.Visible := False;
    end
    else
    begin
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Text_Icon.Visible := False;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Icon.Visible := True;
    end;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Temperature := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Temperature.Name := 'A_W_Provider_Yahoo_Hourly_Info_Temp';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Temperature.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Temperature.SetBounds(100, 25, 50, 30);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Temperature.Font.Family := 'Weather Icons';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Temperature.Font.Size := 18;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Temperature.TextSettings.FontColor := TAlphaColorRec.White;
    if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Temperature.Text := vTown.Forcasts.Hourly[vi].Temperature.Now + #$f042
    else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Temperature.Text := vTown.Forcasts.Hourly[vi].Temperature.Now_Metric + #$f042;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Temperature.HorzTextAlign := TTextAlign.Leading;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Temperature.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Condition := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Condition.Name := 'A_W_Provider_Yahoo_Hourly_Info_Condition';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Condition.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Condition.SetBounds(5, 110, 170, 30);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Condition.Font.Size := 14;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Condition.HorzTextAlign := TTextAlign.Leading;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Condition.TextSettings.FontColor := TAlphaColorRec.White;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Condition.Text := vTown.Forcasts.Hourly[vi].ConditionDescription;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Condition.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity_Icon := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity_Icon.Name := 'A_W_Provider_Yahoo_Hourly_Info_Humidity_Icon';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity_Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity_Icon.SetBounds(5, 164, 24, 24);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity_Icon.Font.Family := 'Weather Icons';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity_Icon.Font.Size := 14;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity_Icon.HorzTextAlign := TTextAlign.Leading;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity_Icon.Text := #$f07a;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity_Icon.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity.Name := 'A_W_Provider_Yahoo_Hourly_Info_Humidity';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity.SetBounds(20, 164, 50, 24);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity.Font.Size := 12;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity.HorzTextAlign := TTextAlign.Leading;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity.TextSettings.FontColor := TAlphaColorRec.White;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity.Text := vTown.Forcasts.Hourly[vi].Humidity + '%';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Humidity.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability_Icon :=
      TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability_Icon.Name := 'A_W_Provider_Yahoo_Hourly_Info_Probability_Icon';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability_Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability_Icon.SetBounds(80, 164, 24, 24);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability_Icon.Font.Family := 'Weather Icons';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability_Icon.Font.Size := 14;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability_Icon.HorzTextAlign := TTextAlign.Leading;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability_Icon.Text := #$f019;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability_Icon.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability.Name := 'A_W_Provider_Yahoo_Hourly_Info_Probability';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability.SetBounds(100, 164, 50, 24);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability.Font.Size := 12;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability.HorzTextAlign := TTextAlign.Leading;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability.TextSettings.FontColor := TAlphaColorRec.White;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability.Text := vTown.Forcasts.Hourly[vi].PrecipitationProbability + '%';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Probability.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Icon := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Icon.Name := 'A_W_Provider_Yahoo_Hourly_Info_Wind_Icon';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Icon.SetBounds(5, 140, 24, 24);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Icon.Font.Family := 'Weather Icons';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Icon.Font.Size := 14;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Icon.HorzTextAlign := TTextAlign.Leading;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Icon.Text := #$f050;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Icon.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind.Name := 'A_W_Provider_Yahoo_Hourly_Info_Wind';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind.SetBounds(25, 140, 30, 24);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind.Font.Size := 12;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind.HorzTextAlign := TTextAlign.Leading;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind.TextSettings.FontColor := TAlphaColorRec.White;
    if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind.Text := vTown.Forcasts.Hourly[vi].WindSpeed
    else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind.Text := vTown.Forcasts.Hourly[vi].WindSpeed_Metric;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Direction := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Direction.Name := 'A_W_Provider_Yahoo_Hourly_Info_Wind_Direction';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Direction.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Direction.SetBounds(38, 134, 24, 24);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Direction.Font.Family := 'Weather Icons';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Direction.Font.Size := 16;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Direction.HorzTextAlign := TTextAlign.Leading;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Direction.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Direction.Text := #$f0b1;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Direction.RotationAngle := vTown.Forcasts.Hourly[vi].WindDirection.ToInteger;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Direction.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Description :=
      TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Description.Name := 'A_W_Provider_Yahoo_Hourly_Info_Wind_Description';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Description.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Description.SetBounds(64, 140, 100, 24);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Description.Font.Size := 12;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Description.HorzTextAlign := TTextAlign.Leading;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Description.TextSettings.FontColor := TAlphaColorRec.White;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Description.Text := vTown.Forcasts.Hourly[vi].WindDirectionCode;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Hourly.Hourly[vi].Wind_Description.Visible := True;
  end;
end;

procedure Main_Create_Daily(vTown: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN; vTab: Integer);
var
  vi: Integer;
begin
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Title := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Title.Name := 'A_W_Provider_Yahoo_Daily_Title';
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Title.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Title.SetBounds(540, 246, 600, 30);
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Title.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Title.Text := 'Daily forecast : ';
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Title.TextSettings.FontColor := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Title.HorzTextAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Title.Tag := vTab;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Title.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Line := TRadiantLine.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Line.Name := 'A_W_Provider_Yahoo_Daily_Line';
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Line.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Line.SetBounds(530, 276, 1110, 5);
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Line.LineSlope := TRadiantLineSlope.Horizontal;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Line.Stroke.Kind := TBrushKind.Solid;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Line.Stroke.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Line.Stroke.Thickness := 3;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Line.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Box := TVertScrollBox.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Box.Name := 'A_W_Provider_Yahoo_Daily_Box';
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Box.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Box.SetBounds(540, 288, 1090, 472);
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Box.ShowScrollBars := True;
  vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Box.Visible := True;

  for vi := 0 to 10 do
  begin
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout := TLayout.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Box);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout.Name := 'A_W_Provider_Yahoo_Daily_Layout_' + vi.ToString;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Box;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout.SetBounds(10, 10 + (vi * 120), vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Box.Width
      - 10, 120);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Text_Icon := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Text_Icon.Name := 'A_W_Provider_Yahoo_Daily_Text_Icon_' + vi.ToString;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Text_Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Text_Icon.SetBounds(5, 5, 100, 100);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Text_Icon.Font.Family := 'Weather Icons';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Text_Icon.Font.Size := 56;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Text_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Text_Icon.Text := Get_Icon_From_Text(vTown.Forcasts.Daily[vi].ConditionCode);

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Icon := TImage.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Icon.Name := 'A_W_Provider_Yahoo_Daily_Icon_' + vi.ToString;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Icon.SetBounds(5, 5, 100, 100);
    if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Iconset <> 'default' then
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Icon.Bitmap.LoadFromFile(uDB_AUser.Local.ADDONS.Weather_D.p_Icons + 'yahoo\' +
        uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Iconset + '\w_w_' + vTown.Forcasts.Daily[vi].ConditionCode + '.png');
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Icon.WrapMode := TImageWrapMode.Fit;

    if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Iconset_Selected > 0 then
    begin
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Text_Icon.Visible := False;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Icon.Visible := True;
    end
    else
    begin
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Text_Icon.Visible := True;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Icon.Visible := False;
    end;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Condition := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Condition.Name := 'A_W_Provider_Yahoo_Daily_Condition_' + vi.ToString;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Condition.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Condition.SetBounds(110, 80, 200, 30);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Condition.Font.Size := 16;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Condition.TextSettings.FontColor := TAlphaColorRec.White;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Condition.HorzTextAlign := TTextAlign.Leading;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Condition.Text := vTown.Forcasts.Daily[vi].ConditionDescription;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Condition.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Thermometre := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Thermometre.Name := 'A_W_Provider_Yahoo_Daily_Thermometre_' + vi.ToString;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Thermometre.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Thermometre.SetBounds(110, 25, 52, 52);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Thermometre.Font.Family := 'Weather Icons';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Thermometre.Font.Size := 38;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Thermometre.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Thermometre.Text := #$f055;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Thermometre.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up.Name := 'A_W_Provider_Yahoo_Daily_Temp_Up_' + vi.ToString;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up.SetBounds(140, 20, 32, 32);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up.Font.Family := 'Weather Icons';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up.Font.Size := 24;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up.TextSettings.FontColor := TAlphaColorRec.Red;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up.Text := #$f058;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up_Value := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up_Value.Name := 'A_W_Provider_Yahoo_Daily_Temp_Up_Value_' + vi.ToString;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up_Value.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up_Value.SetBounds(160, 20, 32, 32);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up_Value.Font.Family := 'Weather Icons';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up_Value.Font.Size := 16;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up_Value.TextSettings.FontColor := TAlphaColorRec.Red;
    if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up_Value.Text := vTown.Forcasts.Daily[vi].Temperature.High + #$f042
    else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up_Value.Text := vTown.Forcasts.Daily[vi].Temperature.High_Metric + #$f042;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Up_Value.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down.Name := 'A_W_Provider_Yahoo_Daily_Temp_Down_' + vi.ToString;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down.SetBounds(140, 46, 32, 32);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down.Font.Family := 'Weather Icons';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down.Font.Size := 24;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down.TextSettings.FontColor := TAlphaColorRec.Whitesmoke;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down.Text := #$f044;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down_Value := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down_Value.Name := 'A_W_Provider_Yahoo_Daily_Temp_Down_Value_' + vi.ToString;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down_Value.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down_Value.SetBounds(160, 46, 32, 32);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down_Value.Font.Family := 'Weather Icons';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down_Value.Font.Size := 16;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down_Value.TextSettings.FontColor := TAlphaColorRec.Whitesmoke;
    if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down_Value.Text := vTown.Forcasts.Daily[vi].Temperature.Low + #$f042
    else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down_Value.Text := vTown.Forcasts.Daily[vi].Temperature.Low_Metric + #$f042;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Temp_Down_Value.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Humidity := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Humidity.Name := 'A_W_Provider_Yahoo_Daily_Humidity_' + vi.ToString;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Humidity.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Humidity.SetBounds(210, (vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout.Height / 2)
      - 16, 28, 28);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Humidity.Font.Family := 'Weather Icons';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Humidity.Font.Size := 20;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Humidity.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Humidity.Text := #$f07a;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Humidity.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Humidity_Value := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Humidity_Value.Name := 'A_W_Provider_Yahoo_Daily_Humidity_Value_' + vi.ToString;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Humidity_Value.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Humidity_Value.SetBounds(244,
      (vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout.Height / 2) - 16, 32, 32);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Humidity_Value.Font.Size := 16;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Humidity_Value.TextSettings.FontColor := TAlphaColorRec.White;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Humidity_Value.Text := vTown.Forcasts.Daily[vi].Humidity + '%';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Humidity_Value.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Probability_Icon := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Probability_Icon.Name := 'A_W_Provider_Yahoo_Daily_Probability_Icon_' + vi.ToString;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Probability_Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Probability_Icon.SetBounds(210, 20, 28, 28);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Probability_Icon.Font.Family := 'Weather Icons';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Probability_Icon.Font.Size := 20;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Probability_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Probability_Icon.Text := #$f019;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Probability_Icon.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Probability := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Probability.Name := 'A_W_Provider_Yahoo_Daily_Probability_' + vi.ToString;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Probability.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Probability.SetBounds(244, 20, 32, 32);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Probability.Font.Size := 16;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Probability.TextSettings.FontColor := TAlphaColorRec.White;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Probability.Text := vTown.Forcasts.Daily[vi].PrecipitationProbability + '%';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Probability.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Date := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Date.Name := 'A_W_Provider_Yahoo_Daily_Date_' + vi.ToString;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Date.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Date.SetBounds(348, 4, 300, 22);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Date.Font.Size := 16;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Date.TextSettings.FontColor := TAlphaColorRec.White;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Date.Text := Convert_Time(vTown.Forcasts.Daily[vi].Time.TimeStamp,
      vTown.Forcasts.Daily[vi].Time.WeekDay).Date;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Date.HorzTextAlign := TTextAlign.Leading;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Date.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Line := TRadiantLine.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Line.Name := 'A_W_Provider_Yahoo_Daily_Line_' + vi.ToString;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Line.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Line.SetBounds(340, 15, 10, 90);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Line.LineSlope := TRadiantLineSlope.Vertical;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Line.Stroke.Kind := TBrushKind.Solid;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Line.Stroke.Color := TAlphaColorRec.Deepskyblue;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Line.Stroke.Thickness := 3;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Line.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day.Name := 'A_W_Provider_Yahoo_Daily_Day_' + vi.ToString;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day.SetBounds(360, 25, 48, 48);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day.Font.Family := 'Weather Icons';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day.Font.Size := 30;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day.Text := #$f00d;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day.Visible := True;

    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night.Name := 'A_W_Provider_Yahoo_Daily_Night_' + vi.ToString;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night.SetBounds(360, 72, 48, 48);
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night.Font.Family := 'Weather Icons';
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night.Font.Size := 30;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night.Text := #$f02e;
    vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night.Visible := True;

    if vTown.Forcasts.Daily[vi].Parts[0].Part = 'DAY' then
    begin
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.Name := 'A_W_Provider_Yahoo_Daily_Day_Value_' + vi.ToString;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.SetBounds(410, 34, 670, 34);
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.Font.Size := 14;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.TextSettings.FontColor := TAlphaColorRec.White;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.Text := vTown.Forcasts.Daily[vi].Parts[0].Desc;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.HorzTextAlign := TTextAlign.Leading;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.Visible := True;

      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night_Value := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night_Value.Name := 'A_W_Provider_Yahoo_Daily_Night_Value_' + vi.ToString;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night_Value.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night_Value.SetBounds(410, 80, 670, 34);
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night_Value.Font.Size := 14;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night_Value.TextSettings.FontColor := TAlphaColorRec.White;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night_Value.Text := vTown.Forcasts.Daily[vi].Parts[1].Desc;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night_Value.HorzTextAlign := TTextAlign.Leading;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night_Value.Visible := True;
    end
    else if vTown.Forcasts.Daily[vi].Parts[0].Part = 'NIGHT' then
    begin
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night.SetBounds(360, 25, 48, 48);

      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night_Value := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night_Value.Name := 'A_W_Provider_Yahoo_Daily_Night_Value_' + vi.ToString;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night_Value.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night_Value.SetBounds(410, 34, 670, 34);
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night_Value.Font.Size := 14;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night_Value.TextSettings.FontColor := TAlphaColorRec.White;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night_Value.Text := vTown.Forcasts.Daily[vi].Parts[0].Desc;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night_Value.HorzTextAlign := TTextAlign.Leading;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Night_Value.Visible := True;

      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day.SetBounds(360, 72, 48, 48);
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.Name := 'A_W_Provider_Yahoo_Daily_Day_Value_' + vi.ToString;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.SetBounds(410, 80, 670, 34);
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.Font.Size := 14;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.TextSettings.FontColor := TAlphaColorRec.White;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.Text := vTown.Forcasts.Daily[vi].Parts[1].Desc;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.HorzTextAlign := TTextAlign.Leading;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.Visible := True;
    end
    else if vTown.Forcasts.Daily[vi].Parts[0].Part = 'BOTH' then
    begin
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.Name := 'A_W_Provider_Yahoo_Daily_Day_Value_' + vi.ToString;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.SetBounds(440, 57, 640, 34);
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.Font.Size := 14;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.TextSettings.FontColor := TAlphaColorRec.White;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.Text := vTown.Forcasts.Daily[vi].Parts[0].Desc;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.HorzTextAlign := TTextAlign.Leading;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Day_Value.Visible := True;

      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Both := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout);
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Both.Name := 'A_W_Provider_Yahoo_Daily_Day_Both_' + vi.ToString;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Both.Parent := vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Layout;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Both.Font.Family := 'IcoMoon-Free';
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Both.SetBounds(410, 57, 32, 32);
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Both.Font.Size := 28;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Both.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Both.Text := #$e9cb;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Both.RotationAngle := -45;
      vWeather.Scene.Tab_Yahoo[vTab].Forecast_Daily.Daily[vi].Both.Visible := True;
    end;
  end;
end;

procedure Main_Create_Town(vTown: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN; vTab: Integer);
var
  vi: Integer;
  vPath_Data: TPathData;
begin
  vWeather.Scene.Tab_Yahoo[vTab].Tab := TALTabItem.Create(vWeather.Scene.Control);
  vWeather.Scene.Tab_Yahoo[vTab].Tab.Name := 'A_W_WeatherTab_Yahoo_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Tab.Parent := vWeather.Scene.Control;
  vWeather.Scene.Tab_Yahoo[vTab].Tab.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_1 := TRadiantLine.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_1.Name := 'A_W_WeatherTab_Yahoo_Vert_Line_1_' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_1.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_1.SetBounds(520, 18, 5, vWeather.Scene.Control.Height - 190);
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_1.LineSlope := TRadiantLineSlope.Vertical;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_1.Stroke.Kind := TBrushKind.Solid;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_1.Stroke.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_1.Stroke.Thickness := 3;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_1.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_2 := TRadiantLine.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_2.Name := 'A_W_WeatherTab_Yahoo_Vert_Line_2_' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_2.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_2.SetBounds(1646, 18, 5, vWeather.Scene.Control.Height - 190);
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_2.LineSlope := TRadiantLineSlope.Vertical;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_2.Stroke.Kind := TBrushKind.Solid;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_2.Stroke.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_2.Stroke.Thickness := 3;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_2.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow.Name := 'A_W_Provider_Yahoo_Town_Image_Left_Arrow';
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow.SetBounds(800, 10, 32, 32);
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow.Font.Family := 'IcoMoon-Free';
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow.Font.Size := 28;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow.Text := #$ea44;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow.OnClick := weather.Input.mouse.Text.OnMouseClick;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow.OnMouseEnter := weather.Input.mouse.Text.OnMouseEnter;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow.OnMouseLeave := weather.Input.mouse.Text.OnMouseLeave;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow.Visible := False;

  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow_Glow := TGlowEffect.Create(vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow);
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow_Glow.Name := 'A_W_Provider_Yahoo_Town_Image_Left_Arrow_Glow';
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow_Glow.Parent := vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow_Glow.Opacity := 0.9;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow_Glow.Softness := 0.4;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Left_Arrow_Glow.Enabled := False;

  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution.Name := 'A_W_Provider_Yahoo_Town_Image_Resolution';
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution.SetBounds(950, 5, 200, 20);
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution.Text := 'Image Resolution';
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution.HorzTextAlign := TTextAlign.Center;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution.Visible := False;

  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution_Value := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution_Value.Name := 'A_W_Provider_Yahoo_Town_Image_Resolution_Value';
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution_Value.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution_Value.SetBounds(950, 25, 200, 20);
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution_Value.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution_Value.Text := '1280 x 720';
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution_Value.HorzTextAlign := TTextAlign.Center;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution_Value.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution_Value.Visible := False;

  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow.Name := 'A_W_Provider_Yahoo_Town_Image_Right_Arrow';
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow.SetBounds(1290, 10, 32, 32);
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow.Font.Family := 'IcoMoon-Free';
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow.Font.Size := 28;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow.Text := #$ea42;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow.Color := TAlphaColorRec.Grey;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow.OnClick := weather.Input.mouse.Text.OnMouseClick;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow.OnMouseEnter := weather.Input.mouse.Text.OnMouseEnter;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow.OnMouseLeave := weather.Input.mouse.Text.OnMouseLeave;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow.Visible := False;

  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow_Glow := TGlowEffect.Create(vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow);
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow_Glow.Name := 'A_W_Provider_Yahoo_Town_Image_Right_Arrow_Glow';
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow_Glow.Parent := vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow_Glow.Opacity := 0.9;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow_Glow.Softness := 0.4;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Right_Arrow_Glow.Enabled := False;

  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image := TImage.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image.Name := 'A_W_Provider_Yahoo_WeatherBackground_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image.SetBounds(538, 60, 1090, 700);
  if vTown.Photos.ID <> '-1' then
    vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image.Bitmap := Get_Best_Img_Res(vTown, length(vTown.Photos.resolutions))
  else
    vBest_Img_Num := -1;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image.WrapMode := TImageWrapMode.Fit;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image.Tag := vTab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Owner := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Owner.Name := 'A_W_Provider_Yahoo_Town_Image_Owner';
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Owner.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Owner.SetBounds(1590 - 300, 750, 300, 30);
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Owner.Font.Size := 14;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Owner.Text := 'Image Owner : ' + vTown.Photos.OwnerName;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Owner.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Owner.HorzTextAlign := TTextAlign.Trailing;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Owner.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Resolution_Value.Text := vTown.Photos.resolutions[vBest_Img_Num].Width + ' x ' + vTown.Photos.resolutions
    [vBest_Img_Num].Height;

  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Blur := TGaussianBlurEffect.Create(vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image);
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Blur.Name := 'A_W_Provider_Yahoo_WeatherBlur';
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Blur.Parent := vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Blur.BlurAmount := 0.9;
  if vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image.Bitmap <> nil then
    vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Blur.Enabled := True
  else
    vWeather.Scene.Tab_Yahoo[vTab].General.Town_Image_Blur.Enabled := False;

  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage.Name := 'A_W_Provider_Yahoo_ShowImage';
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage.SetBounds(1580, 10, 32, 32);
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage.Font.Family := 'IcoMoon-Free';
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage.Text := #$e9ce;
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage.Font.Size := 24;
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage.OnClick := weather.Input.mouse.Text.OnMouseClick;
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage.OnMouseEnter := weather.Input.mouse.Text.OnMouseEnter;
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage.OnMouseLeave := weather.Input.mouse.Text.OnMouseLeave;
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F.Name := 'A_W_Provider_Yahoo_Unit_F';
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F.SetBounds(10, 70, 42, 42);
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F.Font.Size := 36;
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F.Color := TAlphaColorRec.Deepskyblue
  else
    vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F.Text := #$f045;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F.OnClick := weather.Input.mouse.Text.OnMouseClick;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F.OnMouseEnter := weather.Input.mouse.Text.OnMouseEnter;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F.OnMouseLeave := weather.Input.mouse.Text.OnMouseLeave;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F_Glow := TGlowEffect.Create(vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F);
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F_Glow.Name := 'A_W_Provider_Yahoo_Unit_F_Glow';
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F_Glow.Parent := vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F_Glow.Opacity := 0.9;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F_Glow.Softness := 0.4;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_F_Glow.Enabled := False;

  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C.Name := 'A_W_Provider_Yahoo_Unit_C';
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C.SetBounds(10, 120, 42, 42);
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C.Font.Size := 36;
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C.Color := TAlphaColorRec.Deepskyblue
  else
    vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C.Text := #$f03c;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C.OnClick := weather.Input.mouse.Text.OnMouseClick;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C.OnMouseEnter := weather.Input.mouse.Text.OnMouseEnter;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C.OnMouseLeave := weather.Input.mouse.Text.OnMouseLeave;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C_Glow := TGlowEffect.Create(vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C);
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C_Glow.Name := 'A_W_Provider_Yahoo_Unit_C_Glow';
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C_Glow.Parent := vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C_Glow.Opacity := 0.9;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C_Glow.Softness := 0.4;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature_Unit_C_Glow.Enabled := False;

  vWeather.Scene.Tab_Yahoo[vTab].General.Date := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Date.Name := 'A_W_Provider_Yahoo_Date_' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].General.Date.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Date.SetBounds(16, 10, 300, 30);
  vWeather.Scene.Tab_Yahoo[vTab].General.Date.Text := Convert_Time(vTown.Observation.LocalTime.TimeStamp, vTown.Observation.LocalTime.WeekDay).Date;
  vWeather.Scene.Tab_Yahoo[vTab].General.Date.Font.Size := 18;
  vWeather.Scene.Tab_Yahoo[vTab].General.Date.TextSettings.FontColor := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].General.Date.HorzTextAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].General.Date.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Time := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Time.Name := 'A_W_Provider_Yahoo_Time_' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].General.Time.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Time.SetBounds(440, 10, 100, 30);
  vWeather.Scene.Tab_Yahoo[vTab].General.Time.Text := FormatDateTime('hh:mm', Now);
  vWeather.Scene.Tab_Yahoo[vTab].General.Time.Font.Size := 18;
  vWeather.Scene.Tab_Yahoo[vTab].General.Time.TextSettings.FontColor := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].General.Time.HorzTextAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].General.Time.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Time_Icon := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Time_Icon.Name := 'A_W_Provider_Yahoo_Time_Icon_' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].General.Time_Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Time_Icon.SetBounds(416, 10, 32, 32);
  vWeather.Scene.Tab_Yahoo[vTab].General.Time_Icon.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].General.Time_Icon.Text := Get_Icon_Time(FormatDateTime('hh', Now) + ':00');
  vWeather.Scene.Tab_Yahoo[vTab].General.Time_Icon.Font.Size := 24;
  vWeather.Scene.Tab_Yahoo[vTab].General.Time_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Time_Icon.HorzTextAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].General.Time_Icon.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Gen := TRadiantLine.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Gen.Name := 'A_W_Provider_Yahoo_Line_Gen' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Gen.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Gen.SetBounds(4, 40, 510, 5);
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Gen.LineSlope := TRadiantLineSlope.Horizontal;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Gen.Stroke.Kind := TBrushKind.Solid;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Gen.Stroke.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Gen.Stroke.Thickness := 3;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Gen.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_3 := TRadiantLine.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_3.Name := 'A_W_WeatherTab_Yahoo_Vert_Line_3_' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_3.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_3.SetBounds(42, 52, 5, vWeather.Scene.Control.Height - 224);
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_3.LineSlope := TRadiantLineSlope.Vertical;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_3.Stroke.Kind := TBrushKind.Solid;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_3.Stroke.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_3.Stroke.Thickness := 3;
  vWeather.Scene.Tab_Yahoo[vTab].General.Line_Vert_3.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage_Glow := TGlowEffect.Create(vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage);
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage_Glow.Name := 'A_W_Provider_Yahoo_ShowImage_Glow';
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage_Glow.Parent := vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage;
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage_Glow.Opacity := 0.9;
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage_Glow.Softness := 0.4;
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage_Glow.Enabled := False;

  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage_Blur := TGaussianBlurEffect.Create(vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage);
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage_Blur.Name := 'A_W_Provider_Yahoo_ShowImage_Blur';
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage_Blur.Parent := vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage;
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage_Blur.BlurAmount := 0.2;
  vWeather.Scene.Tab_Yahoo[vTab].General.ShowImage_Blur.Enabled := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Text_Image := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Text_Image.Name := 'A_W_Provider_Yahoo_Text_Image_' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].General.Text_Image.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Text_Image.SetBounds(50, 60, 150, 150);
  vWeather.Scene.Tab_Yahoo[vTab].General.Text_Image.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].General.Text_Image.Font.Size := 72;
  vWeather.Scene.Tab_Yahoo[vTab].General.Text_Image.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Iconset = 'default' then
    vWeather.Scene.Tab_Yahoo[vTab].General.Text_Image.Text := Get_Icon_From_Text(vTown.Observation.ConditionCode)
  else
    vWeather.Scene.Tab_Yahoo[vTab].General.Text_Image.Text := '';

  vWeather.Scene.Tab_Yahoo[vTab].General.Image := TImage.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Image.Name := 'A_W_Provider_Yahoo_Image_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Image.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Image.SetBounds(50, 60, 150, 150);
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Iconset <> 'default' then
    vWeather.Scene.Tab_Yahoo[vTab].General.Image.Bitmap.LoadFromFile(uDB_AUser.Local.ADDONS.Weather_D.p_Icons + 'yahoo\' +
      uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Iconset + '\w_w_' + vTown.Observation.ConditionCode + '.png')
  else
    vWeather.Scene.Tab_Yahoo[vTab].General.Image.Bitmap := nil;

  vWeather.Scene.Tab_Yahoo[vTab].General.Image.Tag := vTab;

  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Iconset_Selected = 0 then
  begin
    vWeather.Scene.Tab_Yahoo[vTab].General.Text_Image.Visible := True;
    vWeather.Scene.Tab_Yahoo[vTab].General.Image.Visible := False;
  end
  else
  begin
    vWeather.Scene.Tab_Yahoo[vTab].General.Text_Image.Visible := False;
    vWeather.Scene.Tab_Yahoo[vTab].General.Image.Visible := True;
  end;

  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature.Name := 'A_W_Provider_Yahoo_Temprature_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature.SetBounds(220, 100, 120, 50);
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature.Font.Size := 48;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature.Color := TAlphaColorRec.White;
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vTab].General.Temprature.Text := vTown.Observation.Tempreture.Now + '' + #$f042
  else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vTab].General.Temprature.Text := vTown.Observation.Tempreture.Now_Metric + '' + #$f042;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].General.Temprature.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.FeelsLike := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.FeelsLike.Name := 'A_W_Provider_Yahoo_Temprature_FeelsLike';
  vWeather.Scene.Tab_Yahoo[vTab].General.FeelsLike.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.FeelsLike.SetBounds(220, 142, 200, 30);
  vWeather.Scene.Tab_Yahoo[vTab].General.FeelsLike.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].General.FeelsLike.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].General.FeelsLike.Color := TAlphaColorRec.White;
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vTab].General.FeelsLike.Text := 'Feels like : ' + vTown.Observation.Tempreture.FeelsLike + '' + #$f042
  else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vTab].General.FeelsLike.Text := 'Feels like : ' + vTown.Observation.Tempreture.FeelsLike_Metric + '' + #$f042;
  vWeather.Scene.Tab_Yahoo[vTab].General.FeelsLike.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].General.FeelsLike.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Thermometer := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Thermometer.Name := 'A_W_Provider_Yahoo_Thermometer';
  vWeather.Scene.Tab_Yahoo[vTab].General.Thermometer.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Thermometer.SetBounds(320, 110, 60, 60);
  vWeather.Scene.Tab_Yahoo[vTab].General.Thermometer.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].General.Thermometer.Font.Size := 48;
  vWeather.Scene.Tab_Yahoo[vTab].General.Thermometer.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Thermometer.Text := #$f055;
  vWeather.Scene.Tab_Yahoo[vTab].General.Thermometer.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Low_Icon := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Low_Icon.Name := 'A_W_Provider_Yahoo_Low_Icon';
  vWeather.Scene.Tab_Yahoo[vTab].General.Low_Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Low_Icon.SetBounds(350, 128, 60, 60);
  vWeather.Scene.Tab_Yahoo[vTab].General.Low_Icon.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].General.Low_Icon.Font.Size := 24;
  vWeather.Scene.Tab_Yahoo[vTab].General.Low_Icon.Color := TAlphaColorRec.Whitesmoke;
  vWeather.Scene.Tab_Yahoo[vTab].General.Low_Icon.Text := #$f044;
  vWeather.Scene.Tab_Yahoo[vTab].General.Low_Icon.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Low := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Low.Name := 'A_W_Provider_Yahoo_Low';
  vWeather.Scene.Tab_Yahoo[vTab].General.Low.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Low.SetBounds(370, 142, 70, 30);
  vWeather.Scene.Tab_Yahoo[vTab].General.Low.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].General.Low.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].General.Low.Color := TAlphaColorRec.Whitesmoke;
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vTab].General.Low.Text := vTown.Observation.Tempreture.Low + #$f042
  else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vTab].General.Low.Text := vTown.Observation.Tempreture.Low_Metric + #$f042;
  vWeather.Scene.Tab_Yahoo[vTab].General.Low.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.High_Icon := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.High_Icon.Name := 'A_W_Provider_Yahoo_High_Icon';
  vWeather.Scene.Tab_Yahoo[vTab].General.High_Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.High_Icon.SetBounds(350, 90, 60, 60);
  vWeather.Scene.Tab_Yahoo[vTab].General.High_Icon.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].General.High_Icon.Font.Size := 24;
  vWeather.Scene.Tab_Yahoo[vTab].General.High_Icon.Color := TAlphaColorRec.Red;
  vWeather.Scene.Tab_Yahoo[vTab].General.High_Icon.Text := #$f058;
  vWeather.Scene.Tab_Yahoo[vTab].General.High_Icon.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.High := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.High.Name := 'A_W_Provider_Yahoo_High';
  vWeather.Scene.Tab_Yahoo[vTab].General.High.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.High.SetBounds(370, 104, 70, 30);
  vWeather.Scene.Tab_Yahoo[vTab].General.High.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].General.High.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].General.High.Color := TAlphaColorRec.Red;
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vTab].General.High.Text := vTown.Observation.Tempreture.High + #$f042
  else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vTab].General.High.Text := vTown.Observation.Tempreture.High_Metric + #$f042;
  vWeather.Scene.Tab_Yahoo[vTab].General.High.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Condtition := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Condtition.Name := 'A_W_Provider_Yahoo_Condtition_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Condtition.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Condtition.SetBounds(60, 200, 600, 30);
  vWeather.Scene.Tab_Yahoo[vTab].General.Condtition.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].General.Condtition.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].General.Condtition.Text := vTown.Observation.ConditionDescription;
  vWeather.Scene.Tab_Yahoo[vTab].General.Condtition.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].General.Condtition.Tag := vTab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Condtition.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Day_Icon := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Day_Icon.Name := 'A_W_Provider_Yahoo_Day_Icon';
  vWeather.Scene.Tab_Yahoo[vTab].General.Day_Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Day_Icon.SetBounds(60, 240, 32, 32);
  vWeather.Scene.Tab_Yahoo[vTab].General.Day_Icon.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].General.Day_Icon.Font.Size := 24;
  vWeather.Scene.Tab_Yahoo[vTab].General.Day_Icon.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Day_Icon.Text := #$f00d;
  vWeather.Scene.Tab_Yahoo[vTab].General.Day_Icon.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Day := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Day.Name := 'A_W_Provider_Yahoo_Day';
  vWeather.Scene.Tab_Yahoo[vTab].General.Day.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Day.SetBounds(100, 232, 400, 50);
  vWeather.Scene.Tab_Yahoo[vTab].General.Day.Font.Size := 14;
  vWeather.Scene.Tab_Yahoo[vTab].General.Day.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].General.Day.Text := vTown.Observation.Day_Part[0].Desc;
  vWeather.Scene.Tab_Yahoo[vTab].General.Day.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].General.Day.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Night_Icon := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Night_Icon.Name := 'A_W_Provider_Yahoo_Night_Icon';
  vWeather.Scene.Tab_Yahoo[vTab].General.Night_Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Night_Icon.SetBounds(60, 290, 32, 32);
  vWeather.Scene.Tab_Yahoo[vTab].General.Night_Icon.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].General.Night_Icon.Font.Size := 24;
  vWeather.Scene.Tab_Yahoo[vTab].General.Night_Icon.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Night_Icon.Text := #$f02e;
  vWeather.Scene.Tab_Yahoo[vTab].General.Night_Icon.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Night := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Night.Name := 'A_W_Provider_Yahoo_Night';
  vWeather.Scene.Tab_Yahoo[vTab].General.Night.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Night.SetBounds(100, 286, 400, 50);
  vWeather.Scene.Tab_Yahoo[vTab].General.Night.Font.Size := 14;
  vWeather.Scene.Tab_Yahoo[vTab].General.Night.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].General.Night.Text := vTown.Observation.Day_Part[1].Desc;
  vWeather.Scene.Tab_Yahoo[vTab].General.Night.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].General.Night.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line := TRadiantLine.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line.Name := 'A_W_WeatherTab_Yahoo_Info_Line_' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line.SetBounds(280, 344, 5, 230);
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line.LineSlope := TRadiantLineSlope.Vertical;
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line.Stroke.Kind := TBrushKind.Solid;
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line.Stroke.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line.Stroke.Thickness := 3;
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line_wind := TRadiantLine.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line_wind.Name := 'A_W_WeatherTab_Yahoo_Info_Line_Wind_' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line_wind.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line_wind.SetBounds(52, 360, 224, 5);
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line_wind.LineSlope := TRadiantLineSlope.Horizontal;
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line_wind.Stroke.Kind := TBrushKind.Solid;
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line_wind.Stroke.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line_wind.Stroke.Thickness := 3;
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line_wind.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line_atmosphere := TRadiantLine.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line_atmosphere.Name := 'A_W_WeatherTab_Yahoo_Info_Line_Athmosphere_' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line_atmosphere.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line_atmosphere.SetBounds(290, 360, 222, 5);
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line_atmosphere.LineSlope := TRadiantLineSlope.Horizontal;
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line_atmosphere.Stroke.Kind := TBrushKind.Solid;
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line_atmosphere.Stroke.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line_atmosphere.Stroke.Thickness := 3;
  vWeather.Scene.Tab_Yahoo[vTab].General.Info_Line_atmosphere.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Wind.Header := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Header.Name := 'A_W_Provider_Yahoo_Wind_Header_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Header.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Header.SetBounds(62, 332, 200, 32);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Header.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Header.TextSettings.FontColor := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Header.Text := 'Wind : ';
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Header.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Header.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed_Icon := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed_Icon.Name := 'A_W_Provider_Yahoo_Wind_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed_Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed_Icon.SetBounds(60, 530, 32, 32);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed_Icon.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed_Icon.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed_Icon.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed_Icon.Text := #$f050 + ' Speed : ';
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed_Icon.Visible := True;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed_Icon.Width := 80;

  vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed.Name := 'A_W_Provider_Yahoo_WindSpeed' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed.SetBounds(160, 530, 200, 32);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed.Color := TAlphaColorRec.White;
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed.Text := 'Speed : ' + vTown.Observation.WindSpeed + ' mph'
  else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed.Text := vTown.Observation.WindSpeed + ' kmph';
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Speed.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Icon := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Icon.Name := 'A_W_Provider_Yahoo_WindDirection_Icon_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Icon.SetBounds(50, 490, 32, 32);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Icon.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Icon.Font.Size := 26;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Icon.Text := #$f058;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Icon.RotationAngle := StrToFloat(vTown.Observation.WindDirection);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Icon.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Text := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Text.Name := 'A_W_Provider_Yahoo_WindDiretion_Text_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Text.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Text.SetBounds(84, 490, 200, 30);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Text.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Text.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Text.Text := 'Direction : ';
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Text.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction_Text.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction.Name := 'A_W_Provider_Yahoo_WindDiretion_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction.SetBounds(160, 490, 200, 32);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction.Text := vTown.Observation.WindDirectionCode;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Direction.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small_Stand := TImage.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small_Stand.Name := 'A_W_Provider_Yahoo_Wind_Small_Turbine_Stand_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small_Stand.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small_Stand.SetBounds(100, 400, 43, 52);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small_Stand.WrapMode := TImageWrapMode.Fit;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small_Stand.Bitmap.LoadFromFile(uDB_AUser.Local.ADDONS.Weather_D.p_Images + 'w_stand.png');
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small_Stand.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small := TImage.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small.Name := 'A_W_Provider_Yahoo_Wind_Small_Turbine_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small.SetBounds(94, 375, 54, 54);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small.WrapMode := TImageWrapMode.Stretch;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small.Bitmap.LoadFromFile(uDB_AUser.Local.ADDONS.Weather_D.p_Images + 'w_turbine.png');
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small_Animation := TFloatAnimation.Create(vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small_Animation.Name := 'A_W_Provider_Yahoo_Wind_Small_Turbine_Animation_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small_Animation.Parent := vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small_Animation.PropertyName := 'RotationAngle';
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small_Animation.Duration := Convert_Wind((Round(StrToFloat(vTown.Observation.WindSpeed) * 1.8)))
  else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small_Animation.Duration := Convert_Wind(vTown.Observation.WindSpeed.ToInteger);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small_Animation.StartValue := 0;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small_Animation.StopValue := 360;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small_Animation.Loop := True;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Small_Animation.Enabled := True;

  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Stand := TImage.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Stand.Name := 'A_W_Provider_Yahoo_Wind_Turbine_Stand_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Stand.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Stand.SetBounds(60, 410, 53, 64);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Stand.WrapMode := TImageWrapMode.Fit;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Stand.Bitmap.LoadFromFile(uDB_AUser.Local.ADDONS.Weather_D.p_Images + 'w_stand.png');
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Stand.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine := TImage.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine.Name := 'A_W_Provider_Yahoo_Wind_Turbine_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine.SetBounds(54, 375, 64, 64);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine.WrapMode := TImageWrapMode.Stretch;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine.Bitmap.LoadFromFile(uDB_AUser.Local.ADDONS.Weather_D.p_Images + 'w_turbine.png');
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Animation := TFloatAnimation.Create(vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Animation.Name := 'A_W_Provider_Yahoo_Wind_Turbine_Animation_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Animation.Parent := vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Animation.PropertyName := 'RotationAngle';
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Animation.Duration := Convert_Wind((Round(StrToFloat(vTown.Observation.WindSpeed) * 1.8) - 1))
  else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Animation.Duration := Convert_Wind(vTown.Observation.WindSpeed.ToInteger);
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Animation.StartValue := 0;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Animation.StopValue := 360;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Animation.Loop := True;
  vWeather.Scene.Tab_Yahoo[vTab].Wind.Turbine_Animation.Enabled := True;

  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Header := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Header.Name := 'A_W_Provider_Yahoo_Atmosphere_Header_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Header.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Header.SetBounds(298, 332, 200, 32);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Header.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Header.TextSettings.FontColor := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Header.Text := 'Atmosphere : ';
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Header.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Header.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure_Icon := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure_Icon.Name := 'A_W_Provider_Yahoo_Atmosphere_Pressure_Icon_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure_Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure_Icon.SetBounds(292, 370, 200, 32);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure_Icon.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure_Icon.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure_Icon.Text := #$f079 + ' Pressure : ';
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure_Icon.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure_Icon.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure.Name := 'A_W_Provider_Yahoo_Atmosphere_Pressure' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure.SetBounds(410, 370, 200, 30);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure.Color := TAlphaColorRec.White;
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure.Text := Round(vTown.Observation.BarometricPressure.ToSingle).ToString + ' inHg'
  else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure.Text := vTown.Observation.BarometricPressure_Metric + ' mb';
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure.Tag := vTab;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Pressure.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility_Icon := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility_Icon.Name := 'A_W_Provider_Yahoo_Atmosphere_Visibility_Icon' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility_Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility_Icon.SetBounds(292, 410, 200, 32);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility_Icon.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility_Icon.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility_Icon.Text := #$f075 + ' Visibility : ';
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility_Icon.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility_Icon.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility.Name := 'A_W_Provider_Yahoo_Atmosphere_Visibility' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility.SetBounds(410, 410, 200, 30);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility.Color := TAlphaColorRec.White;
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility.Text := Round(vTown.Observation.Visibility.ToSingle).ToString + '  mph'
  else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility.Text := vTown.Observation.Visibility_Metric + '  kmph';
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility.Tag := vTab;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Visibility.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity_Icon := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity_Icon.Name := 'A_W_Provider_Yahoo_Atmosphere_Humidity_Icon_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity_Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity_Icon.SetBounds(292, 450, 200, 32);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity_Icon.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity_Icon.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity_Icon.Text := #$f07a + ' Humidity : ';
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity_Icon.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity_Icon.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity.Name := 'A_W_Provider_Yahoo_Atmosphere_Humidity' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity.SetBounds(410, 450, 200, 30);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity.Text := vTown.Observation.Humidity + '%';
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Humidity.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV.Name := 'A_W_Provider_Yahoo_Atmosphere_Ultraviolet_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV.SetBounds(292, 490, 200, 32);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV.Text := #$f00d + ' UltraViolet : ';
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV_Index := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV_Index.Name := 'A_W_Provider_Yahoo_Atmosphere_Ultraviolet_Index' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV_Index.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV_Index.SetBounds(410, 490, 300, 30);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV_Index.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV_Index.Color := TAlphaColorRec.White;;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV_Index.Text := vTown.Observation.UVIndex + ' (' + vTown.Observation.UVDescription + ')';
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV_Index.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.UV_Index.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability_Icon := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability_Icon.Name := 'A_W_Provider_Yahoo_Rain_Probability_Icon_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability_Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability_Icon.SetBounds(292, 530, 200, 32);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability_Icon.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability_Icon.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability_Icon.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability_Icon.Text := #$f019 + ' Probability : ';
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability_Icon.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability_Icon.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability.Name := 'A_W_Provider_Yahoo_Rain_Probability_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability.SetBounds(410, 530, 200, 32);
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability.Text := vTown.Observation.PrecipitationProbability + '%';
  vWeather.Scene.Tab_Yahoo[vTab].Atmosphere.Probability.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Header := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Header.Name := 'A_W_Provider_Yahoo_Astronomy_Header_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Header.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Header.SetBounds(62, 570, 200, 32);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Header.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Header.TextSettings.FontColor := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Header.Text := 'Astronomy : ';
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Header.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Header.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Line := TRadiantLine.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Line.Name := 'A_W_WeatherTab_Yahoo_Astronomy_Line_' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Line.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Line.SetBounds(52, 600, 450, 5);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Line.LineSlope := TRadiantLineSlope.Horizontal;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Line.Stroke.Kind := TBrushKind.Solid;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Line.Stroke.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Line.Stroke.Thickness := 3;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Line.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Moon := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Moon.Name := 'A_W_Provider_Yahoo_Moon';
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Moon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Moon.SetBounds(64, 660, 300, 30);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Moon.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Moon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Moon.Text := 'Moon';
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Moon.HorzTextAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Moon.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Moon_Phase := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Moon_Phase.Name := 'A_W_Provider_Yahoo_Moon_Phase';
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Moon_Phase.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Moon_Phase.SetBounds(70, 626, 32, 32);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Moon_Phase.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Moon_Phase.Font.Size := 28;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Moon_Phase.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Moon_Phase.Text := Get_Moon_Phase(vTown.SunAndMoon.MoonPhase);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Moon_Phase.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise_Image := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise_Image.Name := 'A_W_Provider_Yahoo_Astronomy_Sunrise_Image_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise_Image.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise_Image.SetBounds(200, 710, 42, 42);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise_Image.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise_Image.Font.Size := 28;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise_Image.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise_Image.Text := #$f051;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise_Image.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise.Name := 'A_W_Provider_Yahoo_Astronomy_Sunrise_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise.SetBounds(200, 740, 100, 30);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise.Text := Convert_Astronomy(vTown.SunAndMoon.Sunrise);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise.Tag := vTab;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunrise.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset_Image := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset_Image.Name := 'A_W_Provider_Yahoo_Astronomy_Sunset_Image_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset_Image.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset_Image.SetBounds(450, 710, 42, 42);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset_Image.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset_Image.Font.Size := 28;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset_Image.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset_Image.Text := #$f052;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset_Image.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset.Name := 'A_W_Provider_Yahoo_Astronomy_Sunset_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset.SetBounds(450, 740, 100, 30);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset.Text := Convert_Astronomy(vTown.SunAndMoon.Sunset);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset.Tag := vTab;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Sunset.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot.Name := 'A_W_Provider_Yahoo_Astronomy_Spot_' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot.SetBounds(200, 680, 40, 40);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot.Text := #$f00d;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot.Tag := vTab;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot_Text := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot_Text.Name := 'A_W_Provider_Yahoo_Astronomy_Spot_Text_' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot_Text.Parent := vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot_Text.SetBounds(0, -50, 100, 40);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot_Text.Font.Family := '';
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot_Text.Font.Size := 12;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot_Text.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot_Text.Text := '';
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot_Text.Tag := vTab;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot_Text.Visible := True;

  vPath_Data := TPathData.Create;
  vPath_Data.MoveTo(PointF(0, 0));
  vPath_Data.CurveTo(PointF(0, 0), PointF(125, -160), PointF(250, 0));

  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot_Ani := TPathAnimation.Create(vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot);
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot_Ani.Name := 'A_W_Weather_Astronomy_Spot_Animation_' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot_Ani.Parent := vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot_Ani.Path := vPath_Data;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot_Ani.Tag := vTab;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot_Ani.Duration := 4;
  vWeather.Scene.Tab_Yahoo[vTab].Astronomy.Spot_Ani.Enabled := False;

  vWeather.Scene.Tab_Yahoo[vTab].Server.Powered_By := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Server.Powered_By.Name := 'A_W_Provider_Yahoo_Powered_By_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Server.Powered_By.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Powered_By.SetBounds(1664, 650, 300, 30);
  vWeather.Scene.Tab_Yahoo[vTab].Server.Powered_By.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Powered_By.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Powered_By.Text := 'Powered by : ';
  vWeather.Scene.Tab_Yahoo[vTab].Server.Powered_By.Tag := vTab;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Powered_By.TextSettings.HorzAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Powered_By.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Server.Line := TRadiantLine.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Server.Line.Name := 'A_W_WeatherTab_Yahoo_Server_Line_' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Line.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Line.SetBounds(1658, 680, 286, 5);
  vWeather.Scene.Tab_Yahoo[vTab].Server.Line.LineSlope := TRadiantLineSlope.Horizontal;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Line.Stroke.Kind := TBrushKind.Solid;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Line.Stroke.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Line.Stroke.Thickness := 3;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Line.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Server.Icon := TImage.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Server.Icon.Name := 'A_W_Provider_Yahoo_Powered_By_Yahoo_Icon_' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Icon.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Icon.SetBounds(vWeather.Scene.Tab_Yahoo[vTab].Tab.Width - 143, vWeather.Scene.Tab_Yahoo[vTab].Tab.Height - 240, 64, 64);
  vWeather.Scene.Tab_Yahoo[vTab].Server.Icon.WrapMode := TImageWrapMode.Fit;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Icon.Bitmap.LoadFromFile(uDB_AUser.Local.ADDONS.Weather_D.p_Images + 'w_yahoo.png');
  vWeather.Scene.Tab_Yahoo[vTab].Server.Icon.Tag := vTab;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Icon.OnClick := weather.Input.mouse.Image.OnMouseClick;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Icon.OnMouseEnter := weather.Input.mouse.Image.OnMouseEnter;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Icon.OnMouseLeave := weather.Input.mouse.Image.OnMouseLeave;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Icon.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].Server.Icon_Glow := TGlowEffect.Create(vWeather.Scene.Tab_Yahoo[vTab].Server.Icon);
  vWeather.Scene.Tab_Yahoo[vTab].Server.Icon_Glow.Name := 'A_W_Provider_Yahoo_Powered_By_Yahoo_Icon_Glow_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].Server.Icon_Glow.Parent := vWeather.Scene.Tab_Yahoo[vTab].Server.Icon;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Icon_Glow.Softness := 0.9;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Icon_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Server.Icon_Glow.Enabled := False;

  vWeather.Scene.Tab_Yahoo[vTab].Server.LastUpDate := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].Server.LastUpDate.Name := 'A_W_Provider_Yahoo_Last_UpDate';
  vWeather.Scene.Tab_Yahoo[vTab].Server.LastUpDate.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].Server.LastUpDate.SetBounds(uDB_AUser.Local.SETTINGS.Resolution.Half_Width - 200,
    vWeather.Scene.Tab_Yahoo[vTab].Tab.Height - 146, 400, 30);
  vWeather.Scene.Tab_Yahoo[vTab].Server.LastUpDate.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].Server.LastUpDate.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].Server.LastUpDate.Text := 'Last Update: ' + Convert_Time(vTown.Observation.Time.TimeStamp, vTown.Observation.Time.Day).Full;
  vWeather.Scene.Tab_Yahoo[vTab].Server.LastUpDate.HorzTextAlign := TTextAlign.Center;
  vWeather.Scene.Tab_Yahoo[vTab].Server.LastUpDate.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Town_and_Country := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_and_Country.Name := 'A_W_Provider_Yahoo_TownAndCountry_' + IntToStr(vTab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_and_Country.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_and_Country.SetBounds(0, vWeather.Scene.Tab_Yahoo[vTab].Tab.Height - 120,
    uDB_AUser.Local.SETTINGS.Resolution.Width, 60);
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_and_Country.Font.Size := 42;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_and_Country.Color := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_and_Country.Text := vTown.Location.City_Name + ' - ' + vTown.Location.Country_Name;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_and_Country.TextSettings.HorzAlign := TTextAlign.Center;
  vWeather.Scene.Tab_Yahoo[vTab].General.Town_and_Country.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Latidute := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Latidute.Name := 'A_W_Provider_Yahoo_CountryLatitude';
  vWeather.Scene.Tab_Yahoo[vTab].General.Latidute.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Latidute.SetBounds(uDB_AUser.Local.SETTINGS.Resolution.Half_Width - 200,
    vWeather.Scene.Tab_Yahoo[vTab].Tab.Height - 60, 200, 30);
  vWeather.Scene.Tab_Yahoo[vTab].General.Latidute.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].General.Latidute.TextSettings.FontColor := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].General.Latidute.Text := 'Latitude : ' + vTown.Location.Latitude;
  vWeather.Scene.Tab_Yahoo[vTab].General.Latidute.HorzTextAlign := TTextAlign.Center;
  vWeather.Scene.Tab_Yahoo[vTab].General.Latidute.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Earth := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth.Name := 'A_W_Provider_Yahoo_Earth_' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth.SetBounds(uDB_AUser.Local.SETTINGS.Resolution.Half_Width - 16,
    vWeather.Scene.Tab_Yahoo[vTab].Tab.Height - 60, 32, 32);
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth.Font.Family := 'IcoMoon-Free';
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth.Font.Size := 26;
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth.Text := #$e9ca;
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth.OnClick := weather.Input.mouse.Text.OnMouseClick;
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth.OnMouseEnter := weather.Input.mouse.Text.OnMouseEnter;
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth.OnMouseLeave := weather.Input.mouse.Text.OnMouseLeave;
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth.HorzTextAlign := TTextAlign.Center;
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth.TagString := vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Earth_Glow := TGlowEffect.Create(vWeather.Scene.Tab_Yahoo[vTab].General.Earth);
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth_Glow.Name := 'A_W_Provider_Yahoo_Earth_Glow';
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth_Glow.Parent := vWeather.Scene.Tab_Yahoo[vTab].General.Earth;
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth_Glow.Opacity := 0.9;
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth_Glow.Softness := 0.4;
  vWeather.Scene.Tab_Yahoo[vTab].General.Earth_Glow.Enabled := False;

  vWeather.Scene.Tab_Yahoo[vTab].General.Longidute := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Longidute.Name := 'A_W_Provider_Yahoo_Country_Longidute';
  vWeather.Scene.Tab_Yahoo[vTab].General.Longidute.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Longidute.SetBounds(uDB_AUser.Local.SETTINGS.Resolution.Half_Width + 4,
    vWeather.Scene.Tab_Yahoo[vTab].Tab.Height - 60, 200, 30);
  vWeather.Scene.Tab_Yahoo[vTab].General.Longidute.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].General.Longidute.TextSettings.FontColor := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].General.Longidute.Text := 'Longitude : ' + vTown.Location.Longitude;
  vWeather.Scene.Tab_Yahoo[vTab].General.Longidute.HorzTextAlign := TTextAlign.Center;
  vWeather.Scene.Tab_Yahoo[vTab].General.Longidute.Visible := True;

  Main_Create_Hourly(vTown, vTab);

  Main_Create_Daily(vTown, vTab);

  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Text := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Text.Name := 'A_W_Provider_Yahoo_Refresh_Text';
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Text.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Text.SetBounds(1664, 520, 300, 30);
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Text.Font.Size := 16;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Text.TextSettings.FontColor := TAlphaColorRec.White;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Text.Text := 'Refresh : ';
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Text.HorzTextAlign := TTextAlign.Leading;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Text.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Line := TRadiantLine.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Line.Name := 'A_W_WeatherTab_Yahoo_Vert_Refresh_Line_' + vTab.ToString;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Line.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Line.SetBounds(1658, 550, 286, 5);
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Line.LineSlope := TRadiantLineSlope.Horizontal;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Line.Stroke.Kind := TBrushKind.Solid;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Line.Stroke.Color := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Line.Stroke.Thickness := 3;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Line.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh := TText.Create(vWeather.Scene.Tab_Yahoo[vTab].Tab);
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh.Name := 'A_W_Provider_Yahoo_Refresh';
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh.Parent := vWeather.Scene.Tab_Yahoo[vTab].Tab;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh.SetBounds(vWeather.Scene.Tab_Yahoo[vTab].Tab.Width - 140, 570, 60, 60);
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh.Font.Family := 'Weather Icons';
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh.Font.Size := 48;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh.Text := #$f04c;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh.OnClick := weather.Input.mouse.Text.OnMouseClick;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh.OnMouseEnter := weather.Input.mouse.Text.OnMouseEnter;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh.OnMouseLeave := weather.Input.mouse.Text.OnMouseLeave;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh.Visible := True;

  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Glow := TGlowEffect.Create(vWeather.Scene.Tab_Yahoo[vTab].General.Refresh);
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Glow.Name := 'A_W_Provider_Yahoo_Refresh_Glow';
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Glow.Parent := vWeather.Scene.Tab_Yahoo[vTab].General.Refresh;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Glow.Opacity := 0.9;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Glow.Softness := 0.4;
  vWeather.Scene.Tab_Yahoo[vTab].General.Refresh_Glow.Enabled := False;
end;

procedure Use_Imperial;
var
  vi, vk: Integer;
begin
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count > 0 then
  begin
    for vk := 0 to uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count - 1 do
    begin
      vWeather.Scene.Tab_Yahoo[vk].General.Temprature.Text := weather.Action.Yahoo.Data_Town[vk].Observation.Tempreture.Now + '' + #$f042;
      vWeather.Scene.Tab_Yahoo[vk].General.FeelsLike.Text := 'Feels like : ' + weather.Action.Yahoo.Data_Town[vk].Observation.Tempreture.FeelsLike + ''
        + #$f042;
      vWeather.Scene.Tab_Yahoo[vk].General.Low.Text := weather.Action.Yahoo.Data_Town[vk].Observation.Tempreture.Low + #$f042;
      vWeather.Scene.Tab_Yahoo[vk].General.High.Text := weather.Action.Yahoo.Data_Town[vk].Observation.Tempreture.High + #$f042;
      vWeather.Scene.Tab_Yahoo[vk].Wind.Speed.Text := weather.Action.Yahoo.Data_Town[vk].Observation.WindSpeed + ' mph';
      vWeather.Scene.Tab_Yahoo[vk].Atmosphere.Pressure.Text := Round(weather.Action.Yahoo.Data_Town[vk].Observation.BarometricPressure.ToSingle).ToString
        + ' inHg';
      vWeather.Scene.Tab_Yahoo[vk].Atmosphere.Visibility.Text := Round(weather.Action.Yahoo.Data_Town[vk].Observation.Visibility.ToSingle).ToString + '  miles';
      for vi := 0 to 24 do
      begin
        vWeather.Scene.Tab_Yahoo[vk].Forecast_Hourly.Hourly[vi].Temperature.Text := weather.Action.Yahoo.Data_Town[vk].Forcasts.Hourly[vi]
          .Temperature.Now + #$f042;
        vWeather.Scene.Tab_Yahoo[vk].Forecast_Hourly.Hourly[vi].Wind.Text := weather.Action.Yahoo.Data_Town[vk].Forcasts.Hourly[vi].WindSpeed;
      end;
      for vi := 0 to 10 do
      begin
        vWeather.Scene.Tab_Yahoo[vk].Forecast_Daily.Daily[vi].Temp_Up_Value.Text := weather.Action.Yahoo.Data_Town[vk].Forcasts.Daily[vi]
          .Temperature.High + #$f042;
        vWeather.Scene.Tab_Yahoo[vk].Forecast_Daily.Daily[vi].Temp_Down_Value.Text := weather.Action.Yahoo.Data_Town[vk].Forcasts.Daily[vi]
          .Temperature.Low + #$f042;
      end;
    end;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Temprature_Unit_F.Color := TAlphaColorRec.Deepskyblue;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Temprature_Unit_F_Glow.Enabled := False;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Temprature_Unit_C.Color := TAlphaColorRec.White;
    uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric := 'imperial';
    uDB.Query_Update(uDB.ExtraFE_Query_Local, 'addon_weather', 'Yahoo_Metric', 'imperial', 'User_ID', uDB_AUser.Local.USER.Num.ToString);
  end;
end;

procedure Use_Metric;
var
  vi, vk: Integer;
begin
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count > 0 then
  begin
    for vk := 0 to uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count - 1 do
    begin
      vWeather.Scene.Tab_Yahoo[vk].General.Temprature.Text := weather.Action.Yahoo.Data_Town[vk].Observation.Tempreture.Now_Metric + '' + #$f042;
      vWeather.Scene.Tab_Yahoo[vk].General.FeelsLike.Text := 'Feels like : ' + weather.Action.Yahoo.Data_Town[vk].Observation.Tempreture.FeelsLike_Metric +
        '' + #$f042;
      vWeather.Scene.Tab_Yahoo[vk].General.Low.Text := weather.Action.Yahoo.Data_Town[vk].Observation.Tempreture.Low_Metric + #$f042;
      vWeather.Scene.Tab_Yahoo[vk].General.High.Text := weather.Action.Yahoo.Data_Town[vk].Observation.Tempreture.High_Metric + #$f042;
      vWeather.Scene.Tab_Yahoo[vk].Wind.Speed.Text := weather.Action.Yahoo.Data_Town[vk].Observation.WindSpeed_Metric + ' kmph';
      vWeather.Scene.Tab_Yahoo[vk].Atmosphere.Pressure.Text := weather.Action.Yahoo.Data_Town[vk].Observation.BarometricPressure_Metric + ' mb';
      vWeather.Scene.Tab_Yahoo[vk].Atmosphere.Visibility.Text := weather.Action.Yahoo.Data_Town[vk].Observation.Visibility_Metric + '  kmph';
      for vi := 0 to 24 do
      begin
        vWeather.Scene.Tab_Yahoo[vk].Forecast_Hourly.Hourly[vi].Temperature.Text := weather.Action.Yahoo.Data_Town[vk].Forcasts.Hourly[vi]
          .Temperature.Now_Metric + #$f042;
        vWeather.Scene.Tab_Yahoo[vk].Forecast_Hourly.Hourly[vi].Wind.Text := weather.Action.Yahoo.Data_Town[vk].Forcasts.Hourly[vi].WindSpeed_Metric;
      end;
      for vi := 0 to 10 do
      begin
        vWeather.Scene.Tab_Yahoo[vk].Forecast_Daily.Daily[vi].Temp_Up_Value.Text := weather.Action.Yahoo.Data_Town[vk].Forcasts.Daily[vi]
          .Temperature.High_Metric + #$f042;
        vWeather.Scene.Tab_Yahoo[vk].Forecast_Daily.Daily[vi].Temp_Down_Value.Text := weather.Action.Yahoo.Data_Town[vk].Forcasts.Daily[vi]
          .Temperature.Low_Metric + #$f042;
      end;
    end;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Temprature_Unit_F.Color := TAlphaColorRec.White;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Temprature_Unit_C.Color := TAlphaColorRec.Deepskyblue;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Temprature_Unit_C_Glow.Enabled := False;
    uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric := 'metric';
    uDB.Query_Update(uDB.ExtraFE_Query_Local, 'addon_weather', 'Yahoo_Metric', 'metric', 'User_ID', uDB_AUser.Local.USER.Num.ToString);
  end;
end;

procedure Apply_New_Forecast_To_Tonw(vRefreshed_Data: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN; vIndex: Integer);
var
  vi: Integer;
begin
  weather.Action.Yahoo.Data_Town[vIndex] := vRefreshed_Data;
  if vRefreshed_Data.Photos.ID <> '-1' then
    vWeather.Scene.Tab_Yahoo[vIndex].General.Town_Image.Bitmap := Get_Best_Img_Res(vRefreshed_Data, length(vRefreshed_Data.Photos.resolutions));
  vWeather.Scene.Tab_Yahoo[vIndex].General.Date.Text := Convert_Time(vRefreshed_Data.Observation.LocalTime.TimeStamp,
    vRefreshed_Data.Observation.LocalTime.WeekDay).Date;
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Iconset_Selected = 0 then
    vWeather.Scene.Tab_Yahoo[vIndex].General.Text_Image.Text := Get_Icon_From_Text(weather.Action.Yahoo.Data_Town[vIndex].Observation.ConditionCode)
  else
    vWeather.Scene.Tab_Yahoo[vIndex].General.Image.Bitmap.LoadFromFile(uDB_AUser.Local.ADDONS.Weather_D.p_Icons + 'yahoo\' +
      uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Iconset + '\w_w_' + vRefreshed_Data.Observation.ConditionCode + '.png');
  vWeather.Scene.Tab_Yahoo[vIndex].General.Condtition.Text := vRefreshed_Data.Observation.ConditionDescription;
  vWeather.Scene.Tab_Yahoo[vIndex].General.Day.Text := vRefreshed_Data.Observation.Day_Part[0].Desc;
  vWeather.Scene.Tab_Yahoo[vIndex].General.Night.Text := vRefreshed_Data.Observation.Day_Part[1].Desc;
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vIndex].General.Temprature.Text := vRefreshed_Data.Observation.Tempreture.Now + '' + #$f042
  else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vIndex].General.Temprature.Text := vRefreshed_Data.Observation.Tempreture.Now_Metric + '' + #$f042;
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vIndex].General.Low.Text := vRefreshed_Data.Observation.Tempreture.Low + #$f042
  else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vIndex].General.Low.Text := vRefreshed_Data.Observation.Tempreture.Low_Metric + #$f042;
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vIndex].General.High.Text := vRefreshed_Data.Observation.Tempreture.High + #$f042
  else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vIndex].General.High.Text := vRefreshed_Data.Observation.Tempreture.High_Metric + #$f042;
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vIndex].General.FeelsLike.Text := 'Feels like : ' + vRefreshed_Data.Observation.Tempreture.FeelsLike + '' + #$f042
  else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vIndex].General.FeelsLike.Text := 'Feels like : ' + vRefreshed_Data.Observation.Tempreture.FeelsLike_Metric + '' + #$f042;
  vWeather.Scene.Tab_Yahoo[vIndex].Astronomy.Moon_Phase.Text := Get_Moon_Phase(vRefreshed_Data.SunAndMoon.MoonPhase);
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vIndex].Wind.Turbine_Animation.Duration := Convert_Wind((Round(StrToFloat(vRefreshed_Data.Observation.WindSpeed) * 1.8) - 1))
  else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vIndex].Wind.Turbine_Animation.Duration := Convert_Wind(vRefreshed_Data.Observation.WindSpeed.ToInteger);
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vIndex].Wind.Turbine_Small_Animation.Duration := Convert_Wind((Round(StrToFloat(vRefreshed_Data.Observation.WindSpeed) * 1.8)))
  else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vIndex].Wind.Turbine_Small_Animation.Duration := Convert_Wind(vRefreshed_Data.Observation.WindSpeed.ToInteger);
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vIndex].Wind.Speed.Text := vRefreshed_Data.Observation.WindSpeed + ' mph'
  else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vIndex].Wind.Speed.Text := vRefreshed_Data.Observation.WindSpeed + ' kmph';
  vWeather.Scene.Tab_Yahoo[vIndex].Wind.Direction.Text := vRefreshed_Data.Observation.WindDirectionCode;
  vWeather.Scene.Tab_Yahoo[vIndex].Wind.Direction_Icon.RotationAngle := StrToFloat(vRefreshed_Data.Observation.WindDirection);
  vWeather.Scene.Tab_Yahoo[vIndex].Atmosphere.UV_Index.Text := vRefreshed_Data.Observation.UVIndex + ' (' + vRefreshed_Data.Observation.UVDescription + ')';
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vIndex].Atmosphere.Pressure.Text := Round(vRefreshed_Data.Observation.BarometricPressure.ToSingle).ToString + ' inHg'
  else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vIndex].Atmosphere.Pressure.Text := vRefreshed_Data.Observation.BarometricPressure_Metric + ' mb';
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
    vWeather.Scene.Tab_Yahoo[vIndex].Atmosphere.Visibility.Text := Round(vRefreshed_Data.Observation.Visibility.ToSingle).ToString + '  mph'
  else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
    vWeather.Scene.Tab_Yahoo[vIndex].Atmosphere.Visibility.Text := vRefreshed_Data.Observation.Visibility_Metric + '  kmph';
  vWeather.Scene.Tab_Yahoo[vIndex].Atmosphere.Humidity.Text := vRefreshed_Data.Observation.Humidity + '%';;
  vWeather.Scene.Tab_Yahoo[vIndex].Astronomy.Sunset.Text := Convert_Astronomy(vRefreshed_Data.SunAndMoon.Sunset);
  vWeather.Scene.Tab_Yahoo[vIndex].Astronomy.Sunrise.Text := Convert_Astronomy(vRefreshed_Data.SunAndMoon.Sunrise);
  vWeather.Scene.Tab_Yahoo[vIndex].General.Town_and_Country.Text := vRefreshed_Data.Location.City_Name + ' - ' + vRefreshed_Data.Location.Country_Name;
  vWeather.Scene.Tab_Yahoo[vIndex].General.Latidute.Text := 'Latitude : ' + vRefreshed_Data.Location.Latitude;
  vWeather.Scene.Tab_Yahoo[vIndex].General.Longidute.Text := 'Longitude : ' + vRefreshed_Data.Location.Longitude;
  for vi := 0 to 24 do
  begin
    if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Iconset_Selected = 0 then
      vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Hourly.Hourly[vi].Text_Icon.Text :=
        Get_Icon_From_Text(weather.Action.Yahoo.Data_Town[vIndex].Forcasts.Hourly[vi].ConditionCode)
    else
      vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Hourly.Hourly[vi].Icon.Bitmap.LoadFromFile(uDB_AUser.Local.ADDONS.Weather_D.p_Icons + 'yahoo\' +
        uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Iconset + '\w_w_' + vRefreshed_Data.Forcasts.Hourly[vi].ConditionCode + '.png');
    if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
      vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Hourly.Hourly[vi].Temperature.Text := vRefreshed_Data.Forcasts.Hourly[vi].Temperature.Now + #$f042
    else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
      vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Hourly.Hourly[vi].Temperature.Text := vRefreshed_Data.Forcasts.Hourly[vi].Temperature.Now_Metric + #$f042;
    vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Hourly.Hourly[vi].Condition.Text := vRefreshed_Data.Forcasts.Hourly[vi].ConditionDescription;
    vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Hourly.Hourly[vi].Humidity.Text := vRefreshed_Data.Forcasts.Hourly[vi].Humidity + '%';
    if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
      vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Hourly.Hourly[vi].Wind.Text := vRefreshed_Data.Forcasts.Hourly[vi].WindSpeed
    else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
      vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Hourly.Hourly[vi].Wind.Text := vRefreshed_Data.Forcasts.Hourly[vi].WindSpeed_Metric;
    vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Hourly.Hourly[vi].Wind_Description.Text := vRefreshed_Data.Forcasts.Hourly[vi].WindDirectionCode;
    vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Hourly.Hourly[vi].Wind_Direction.RotationAngle := vRefreshed_Data.Forcasts.Hourly[vi].WindDirection.ToInteger;
    vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Hourly.Hourly[vi].Hour.Text := Get_Icon_Time(vRefreshed_Data.Forcasts.Hourly[vi].Time.Hour + ':00') + ' ' +
      vRefreshed_Data.Forcasts.Hourly[vi].Time.Hour + ':00';
  end;
  for vi := 0 to 10 do
  begin
    vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Daily.Daily[vi].Date.Text := Convert_Time(vRefreshed_Data.Forcasts.Daily[vi].Time.TimeStamp,
      vRefreshed_Data.Forcasts.Daily[vi].Time.WeekDay).Date;
    if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Iconset_Selected = 0 then
      vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Daily.Daily[vi].Text_Icon.Text :=
        Get_Icon_From_Text(weather.Action.Yahoo.Data_Town[vIndex].Forcasts.Daily[vi].ConditionCode)
    else
      vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Daily.Daily[vi].Icon.Bitmap.LoadFromFile(uDB_AUser.Local.ADDONS.Weather_D.p_Icons + 'yahoo\' +
        uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Iconset + '\w_w_' + vRefreshed_Data.Forcasts.Daily[vi].ConditionCode + '.png');
    vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Daily.Daily[vi].Condition.Text := vRefreshed_Data.Forcasts.Daily[vi].ConditionDescription;
    if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
      vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Daily.Daily[vi].Temp_Up_Value.Text := vRefreshed_Data.Forcasts.Daily[vi].Temperature.High + #$f042
    else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
      vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Daily.Daily[vi].Temp_Up_Value.Text := vRefreshed_Data.Forcasts.Daily[vi].Temperature.High_Metric + #$f042;
    if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'imperial' then
      vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Daily.Daily[vi].Temp_Down_Value.Text := vRefreshed_Data.Forcasts.Daily[vi].Temperature.Low + #$f042
    else if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Metric = 'metric' then
      vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Daily.Daily[vi].Temp_Down_Value.Text := vRefreshed_Data.Forcasts.Daily[vi].Temperature.Low_Metric + #$f042;
    vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Daily.Daily[vi].Humidity_Value.Text := vRefreshed_Data.Forcasts.Daily[vi].Humidity + '%';
    if vRefreshed_Data.Forcasts.Daily[vi].Parts[0].Part = 'DAY' then
    begin
      vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Daily.Daily[vi].Day_Value.Text := vRefreshed_Data.Forcasts.Daily[vi].Parts[0].Desc;
      vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Daily.Daily[vi].Night_Value.Text := vRefreshed_Data.Forcasts.Daily[vi].Parts[1].Desc;
    end
    else if vRefreshed_Data.Forcasts.Daily[vi].Parts[0].Part = 'BOTH' then
      vWeather.Scene.Tab_Yahoo[vIndex].Forecast_Daily.Daily[vi].Day_Value.Text := vRefreshed_Data.Forcasts.Daily[vi].Parts[0].Desc;
  end;
  vWeather.Scene.Tab_Yahoo[vIndex].Server.LastUpDate.Text := 'Last Update: ' + Convert_Time(vRefreshed_Data.Observation.Time.TimeStamp,
    vRefreshed_Data.Observation.Time.Day).Full;
end;

procedure Refresh_Town(vTown_Index: Integer);
var
  vInfo: TText;
  vRefreshed_Town: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN;
begin
  { This procedure must be in TTask Thread bcs Application.Proccess didt work well }
  vWeather.Scene.Blur.Enabled := True;
  vInfo := TText.Create(vWeather.Scene.weather);
  vInfo.Name := 'A_W_Provider_Yahoo_Refresh_Info';
  vInfo.Parent := vWeather.Scene.weather;
  vInfo.SetBounds(uDB_AUser.Local.SETTINGS.Resolution.Half_Width - 400, uDB_AUser.Local.SETTINGS.Resolution.Half_Height - 100, 800, 100);
  vInfo.Font.Size := 48;
  vInfo.Text := 'Please Wait Getting Forecast....';
  vInfo.TextSettings.FontColor := TAlphaColorRec.White;
  vInfo.Visible := True;

  vRefreshed_Town := Get_Forecast(vTown_Index, weather.Action.Yahoo.Data_Town[vTown_Index].Woeid);
  Apply_New_Forecast_To_Tonw(vRefreshed_Town, vWeather.Scene.Control.TabIndex);

  FreeAndNil(vInfo);
  vWeather.Scene.Blur.Enabled := False;
  uWeather_Actions.Show_AstronomyAnimation;
end;

procedure Show_Hourly(IsShow: Boolean);
begin
  vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].Forecast_Hourly.Title.Visible := IsShow;
  vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].Forecast_Hourly.Box.Visible := IsShow;
end;

procedure Show_Daily(IsShow: Boolean);
begin
  vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].Forecast_Daily.Line.Visible := IsShow;
  vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].Forecast_Daily.Box.Visible := IsShow;
end;

procedure Show_Image;
begin
  if vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.ShowImage_Blur.Enabled = True then
  begin
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.ShowImage_Blur.Enabled := False;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.ShowImage_Glow.Enabled := False;
    Show_Hourly(False);
    Show_Daily(False);
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Blur.Enabled := False;
    if vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image.Bitmap <> nil then
    begin
      vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Left_Arrow.Visible := True;
      vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Right_Arrow.Visible := True;
      vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Resolution.Visible := True;
      vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Resolution_Value.Visible := True;
    end;
  end
  else if vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.ShowImage.Text = #$e9ce then
  begin
    Show_Hourly(True);
    Show_Daily(True);
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Owner.Visible := False;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image.Visible := False;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.ShowImage.Text := #$e9d1;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Left_Arrow.Visible := False;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Right_Arrow.Visible := False;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Resolution.Visible := False;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Resolution_Value.Visible := False;
  end
  else if vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.ShowImage.Text = #$e9d1 then
  begin
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Owner.Visible := True;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.ShowImage.Text := #$e9ce;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.ShowImage_Blur.Enabled := True;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.ShowImage_Glow.Enabled := False;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image.Visible := True;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Blur.Enabled := True;
  end;
end;

procedure Show_Town_Image(vState: String);
begin
  if vState = 'next' then
  begin
    inc(weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex].Photos.Picture_Used_Num, 1);
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image.Bitmap :=
      uInternet_Files.Get_Image(weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex].Photos.resolutions
      [weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex].Photos.Picture_Used_Num].URL);
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Resolution_Value.Text :=
      weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex].Photos.resolutions
      [weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex].Photos.Picture_Used_Num].Width + ' x ' + weather.Action.Yahoo.Data_Town
      [vWeather.Scene.Control.TabIndex].Photos.resolutions[weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex].Photos.Picture_Used_Num].Height;
    if weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex].Photos.Picture_Used_Num = 5 then
    begin
      vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Right_Arrow.TextSettings.FontColor := TAlphaColorRec.Grey;
      vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Right_Arrow_Glow.Enabled := False;
    end;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Left_Arrow.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  end
  else if vState = 'previous' then
  begin
    Dec(weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex].Photos.Picture_Used_Num, 1);
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image.Bitmap :=
      uInternet_Files.Get_Image(weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex].Photos.resolutions
      [weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex].Photos.Picture_Used_Num].URL);
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Resolution_Value.Text :=
      weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex].Photos.resolutions
      [weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex].Photos.Picture_Used_Num].Width + ' x ' + weather.Action.Yahoo.Data_Town
      [vWeather.Scene.Control.TabIndex].Photos.resolutions[weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex].Photos.Picture_Used_Num].Height;
    if weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex].Photos.Picture_Used_Num = 0 then
    begin
      vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Left_Arrow.TextSettings.FontColor := TAlphaColorRec.Grey;
      vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Left_Arrow_Glow.Enabled := False;
    end;
    vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].General.Town_Image_Right_Arrow.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  end;
end;

procedure Show_Map(vTab_Num: String);
begin
  uWeather_Actions.Show_Map('yahoo', weather.Action.Yahoo.Data_Town[vTab_Num.ToInteger].Location.Latitude,
    weather.Action.Yahoo.Data_Town[vTab_Num.ToInteger].Location.Longitude);
end;

procedure Update_Time(vTab: Integer);
begin
  vWeather.Scene.Tab_Yahoo[vTab].General.Time.Text := FormatDateTime('hh:mm', Now);
  vWeather.Scene.Tab_Yahoo[vTab].General.Time_Icon.Text := Get_Icon_Time(FormatDateTime('hh', Now) + ':00');
end;

procedure Slide_Right;
begin
  vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].Astronomy.Spot_Ani.Stop;
  weather.Ani.main_stop := False;
  uWeather_Sounds.PlayEffect('', '', False);
  BASS_ChannelPlay(weather.Sound.mouse[0], True);
  if vWeather.Scene.Control.TabIndex = vWeather.Scene.Control.TabCount - 2 then
  begin
    vWeather.Scene.Arrow_Right.Visible := False;
    vWeather.Scene.Arrow_Right_Text.Visible := False;
  end
  else
  begin
    vWeather.Scene.Arrow_Right.Visible := True;
    vWeather.Scene.Arrow_Right_Text.Visible := True;
    vWeather.Scene.Arrow_Right_Text.Text := 'Next : ' + weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex + 2].Location.City_Name;
  end;
  vWeather.Scene.Arrow_Left.Visible := True;
  vWeather.Scene.Arrow_Left_Text.Visible := True;
  vWeather.Scene.Arrow_Left_Text.Text := 'Previous : ' + weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex].Location.City_Name;
  vWeather.Scene.Arrow_Right_Glow.Enabled := True;
  Close_Map;
  vWeather.Scene.Control.Next;
end;

procedure Slide_Left;
begin
  vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].Astronomy.Spot_Ani.Stop;
  weather.Ani.main_stop := False;
  uWeather_Sounds.PlayEffect('', '', False);
  BASS_ChannelPlay(weather.Sound.mouse[0], True);
  if vWeather.Scene.Control.TabIndex = 1 then
  begin
    vWeather.Scene.Arrow_Left.Visible := False;
    vWeather.Scene.Arrow_Left_Text.Visible := False;
  end
  else
  begin
    vWeather.Scene.Arrow_Left.Visible := True;
    vWeather.Scene.Arrow_Left_Text.Visible := True;
    vWeather.Scene.Arrow_Left_Text.Text := 'Previous : ' + weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex - 2].Location.City_Name;
  end;
  vWeather.Scene.Arrow_Right.Visible := True;
  vWeather.Scene.Arrow_Right_Text.Visible := True;
  vWeather.Scene.Arrow_Right_Text.Text := 'Next : ' + weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex].Location.City_Name;
  vWeather.Scene.Arrow_Left_Glow.Enabled := True;
  Close_Map;
  vWeather.Scene.Control.Previous;
end;

procedure UpDate_SunSpot;
begin
  if uDB_AUser.Local.ADDONS.Weather_D.Yahoo.Towns_Count > 0 then
  begin
    if vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].Astronomy.Spot_Ani.Enabled then
      if weather.Action.Yahoo.Spot_Stop + 200 <= vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].Astronomy.Spot.Position.X then
      begin
        vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].Astronomy.Spot_Ani.StopAtCurrent;
        vWeather.Scene.Tab_Yahoo[vWeather.Scene.Control.TabIndex].Astronomy.Spot_Ani.Enabled := False;
      end;
  end;
end;

procedure Go_To_Website;
const
  cURL = 'https://www.yahoo.com/news/weather/';
begin
  ShellExecute(0, PChar('open'), PChar(cURL), nil, nil, 0);
end;

end.
