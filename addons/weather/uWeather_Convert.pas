unit uWeather_Convert;

interface

uses
  System.Classes,
  System.DateUtils,
  System.SysUtils,
  System.Types,
  System.IniFiles,
  FMX.Graphics;

function uWeather_Convert_Day(vDay: WideString): WideString;
function uWeather_Convert_Date(vDate: WideString): WideString;
function uWeather_Convert_Month(vMonth: WideString): WideString;

function uWeather_Convert_Update(vUpdate: WideString): WideString;

function uWeather_Convert_WindSpeed(vWindSpeed: Single): Single;

function uWeather_Convert_FixAstronomy(vValue: WideString): WideString;
function uWeather_Convert_SunSpot(vSunrise, vSunset: String): TPathData;


implementation
uses
  uLoad_AllTypes;

function uWeather_Convert_Day(vDay: WideString): WideString;
begin
  if vDay = 'Mon' then
    Result := 'Monday'
  else if vDay = 'Tue' then
    Result := 'Tuesday'
  else if vDay = 'Wed' then
    Result := 'Wednesday'
  else if vDay = 'Thu' then
    Result := 'Thursday'
  else if vDay = 'Fri' then
    Result := 'Friday'
  else if vDay = 'Sat' then
    Result := 'Saturday'
  else if vDay = 'Sun' then
    Result := 'Sunday'
  else
    Result := 'error...!!!';
end;

function uWeather_Convert_Date(vDate: WideString): WideString;
var
  vPos: Integer;
  vNum: String;
  vMonth: String;
  vYear: String;
begin
  vNum := Trim(Copy(vDate, 0, 3));
  vPos := Pos(' ', vDate);
  vMonth := Trim(Copy(vDate, vPos + 1, 3));
  vYear := Trim(Copy(vDate, length(vDate) - 4, 5));

  vMonth := uWeather_Convert_Month(vMonth);

  if Result <> 'error...!!!' then
    Result := vNum + ' ' + Result + ' ' + vYear;
end;

function uWeather_Convert_Month(vMonth: WideString): WideString;
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
  else if (vMonth = 'Aug') or (vMonth = '08')  then
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

function uWeather_Convert_Update(vUpdate: WideString): WideString;
var
  viPos: Integer;
  vText, vText1: WideString;
begin
  viPos := Pos(',', vUpdate);
  vText := Trim(Copy(vUpdate, 0, viPos - 1));
  Result := uWeather_Convert_Day(vText);
  vText1 := Trim(Copy(vUpdate, viPos + 1, length(vUpdate) - viPos));
  viPos := Pos(' ', vText1);
  vText := Trim(Copy(vText1, 0, viPos));
  vText1 := Trim(Copy(vText1, viPos, length(vText1) - (viPos - 1)));
  Result := Result + ' ' + vText;
  viPos := Pos(' ', vText1);
  vText := Trim(Copy(vText1, 0, viPos));
  vText1 := Trim(Copy(vText1, viPos, length(vText1) - (viPos - 1)));
  vText := uWeather_Convert_Month(vText);
  Result := Result + ' ' + vText + ' ' + vText1;
end;

function uWeather_Convert_WindSpeed(vWindSpeed: Single): Single;
begin
  if vWindSpeed > 118 then
    Result := 0.05
  else if vWindSpeed > 103 then
    Result := 0.1
  else if vWindSpeed > 89 then
    Result := 0.3
  else if vWindSpeed > 75 then
    Result := 0.5
  else if vWindSpeed > 62 then
    Result := 0.7
  else if vWindSpeed > 50 then
    Result := 0.9
  else if vWindSpeed > 39 then
    Result := 1.1
  else if vWindSpeed > 1 then
    Result := 20 - ((vWindSpeed * 10) / 20) + 1.1
  else
    Result := 0;
end;

function uWeather_Convert_FixAstronomy(vValue: WideString): WideString;
var
  vi, viPos: Integer;
  vt, vt1, vt2: String;
begin
  viPos := Pos(':', vValue);
  vt := Trim(Copy(vValue, 0, (viPos - 1)));
  vt2 := Trim(Copy(vValue, viPos + 1, length(vValue) - (viPos)));
  viPos := Pos(' ', vt2);
  vt1 := Trim(Copy(vt2, 0, (viPos - 1)));
  vt2 := Trim(Copy(vt2, viPos + 1, length(vValue) - (viPos)));
  if length(vt) <> 2 then
    vt := '0' + vt;
  if length(vt1) <> 2 then
    vt1 := '0' + vt1;
  Result := vt + ':' + vt1 + ' ' + vt2;
end;

function uWeather_Convert_SunSpot(vSunrise, vSunset: String): TPathData;
var
  vi, viPos: Integer;
  vHour_Sunrise, vMinutes_Sunrise, vState_Sunrise: String;
  vSunrise_TotalMinutes: String;
  vHour_Sunset, vMinutes_Sunset, vState_Sunset: String;
  vSunset_TotalMinutes: String;
  vTotal_SunMinutes: Integer;
  vTimeNow: String;
  vTimeNow_Hours, vTimeNow_Minutes, vTimeNow_State: String;
  vTimeNow_TotalMinutes: String;
  vTotal_TimeMinutes: Integer;
  vTotal_End: Single;
  vTotal_UpCurve: Single;
  vTotal_Go: Single;
  vTotal_High: Single;

begin
  Result := TPathData.Create;
  viPos := Pos(':', vSunrise);
  vHour_Sunrise := Trim(Copy(vSunrise, 0, (viPos - 1)));
  vState_Sunrise := Trim(Copy(vSunrise, viPos + 1, length(vSunrise) - (viPos)));
  viPos := Pos(' ', vState_Sunrise);
  vMinutes_Sunrise := Trim(Copy(vState_Sunrise, 0, (viPos - 1)));
  vState_Sunrise := Trim(Copy(vState_Sunrise, viPos + 1, length(vSunrise) - (viPos)));

  vSunrise_TotalMinutes := MinuteOfTheDay(StrToTime(vHour_Sunrise + ':' + vMinutes_Sunrise + ':00')).ToString;

  viPos := Pos(':', vSunset);
  vHour_Sunset := Trim(Copy(vSunset, 0, (viPos - 1)));
  vState_Sunset := Trim(Copy(vSunset, viPos + 1, length(vSunset) - (viPos)));
  viPos := Pos(' ', vState_Sunset);
  vMinutes_Sunset := Trim(Copy(vState_Sunset, 0, (viPos - 1)));
  vState_Sunset := Trim(Copy(vState_Sunset, viPos + 1, length(vSunset) - (viPos)));
  if UpperCase(vState_Sunset) = 'PM' then
    vHour_Sunset := (vHour_Sunset.ToInteger + 12).ToString;

  vSunset_TotalMinutes := MinuteOfTheDay(StrToTime(vHour_Sunset + ':' + vMinutes_Sunset + ':00')).ToString;
  vTotal_SunMinutes := vSunset_TotalMinutes.ToInteger - vSunrise_TotalMinutes.ToInteger;

  vTimeNow := TimeToStr(Now);

  viPos := Pos(':', vTimeNow);
  vTimeNow_Hours := Trim(Copy(vTimeNow, 0, (viPos - 1)));
  vTimeNow_Minutes := Trim(Copy(vTimeNow, viPos + 1, length(vTimeNow) - (viPos)));
  viPos := Pos(':', vTimeNow_Minutes);
  vTimeNow_State := Trim(Copy(vTimeNow_Minutes, viPos + 1, length(vTimeNow_Minutes) - (viPos)));
  vTimeNow_Minutes := Trim(Copy(vTimeNow_Minutes, 0, (viPos - 1)));
  viPos := Pos(' ', vTimeNow_State);
  vTimeNow_State := Trim(Copy(vTimeNow_State, viPos + 1, length(vTimeNow_State) - viPos));
  if (UpperCase(vTimeNow_State)= 'PM') and (vTimeNow_Hours.ToInteger<> 12) then
    vTimeNow_Hours:= (vTimeNow_Hours.ToInteger+ 12).ToString;

  vTimeNow_TotalMinutes := MinuteOfTheDay(StrToTime(vTimeNow_Hours + ':' + vTimeNow_Minutes + ':00'))
    .ToString;

  if (vTimeNow_TotalMinutes.ToInteger >= vSunrise_TotalMinutes.ToInteger) and
    (vTimeNow_TotalMinutes.ToInteger <= vSunset_TotalMinutes.ToInteger) then
  begin
    vTotal_TimeMinutes := vTimeNow_TotalMinutes.ToInteger - vSunrise_TotalMinutes.ToInteger;

    vTotal_End := (vTotal_TimeMinutes * 300) / vTotal_SunMinutes;
    vTotal_UpCurve := (vTotal_End * 200) / 300;
    vTotal_Go := (vTotal_End * 150) / 300;
    if vTotal_UpCurve > 100 then
      vTotal_High := -(vTotal_UpCurve - 200)
    else
      vTotal_High := vTotal_UpCurve;

    Result.MoveTo(PointF(0, 0));
    Result.CurveTo(PointF(0, 0), PointF(vTotal_Go, -vTotal_UpCurve), PointF(vTotal_End, -vTotal_High));

    addons.weather.Action.PathAni_Show:= True;
  end
  else
  begin
    Result.MoveTo(PointF(-1000, 0));
    addons.weather.Action.PathAni_Show:= False;
  end;
end;
end.
