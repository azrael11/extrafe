unit uWeather_Convert;

interface

uses
  System.TimeSpan,
  System.Classes,
  System.DateUtils,
  System.SysUtils,
  System.Types,
  System.IniFiles,
  FMX.Graphics;

function Day(vDay: WideString): WideString;
function Date(vDate: WideString): WideString;
function Month(vMonth: WideString): WideString;

function Update(vUpdate: WideString): WideString;

function WindSpeed(vWindSpeed: Single): Single;

function FixAstronomy(vValue: WideString): WideString;
function SunSpot(vSunrise, vSunset: Single): Single;

implementation

uses
  uWeather_AllTypes, uDB_AUser, Winapi.Windows;

function Day(vDay: WideString): WideString;
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

function Date(vDate: WideString): WideString;
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

  vMonth := Month(vMonth);

  if Result <> 'error...!!!' then
    Result := vNum + ' ' + Result + ' ' + vYear;
end;

function Month(vMonth: WideString): WideString;
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

function Update(vUpdate: WideString): WideString;
var
  viPos: Integer;
  vText, vText1: WideString;
begin
  viPos := Pos(',', vUpdate);
  vText := Trim(Copy(vUpdate, 0, viPos - 1));
  Result := Day(vText);
  vText1 := Trim(Copy(vUpdate, viPos + 1, length(vUpdate) - viPos));
  viPos := Pos(' ', vText1);
  vText := Trim(Copy(vText1, 0, viPos));
  vText1 := Trim(Copy(vText1, viPos, length(vText1) - (viPos - 1)));
  Result := Result + ' ' + vText;
  viPos := Pos(' ', vText1);
  vText := Trim(Copy(vText1, 0, viPos));
  vText1 := Trim(Copy(vText1, viPos, length(vText1) - (viPos - 1)));
  vText := Month(vText);
  Result := Result + ' ' + vText + ' ' + vText1;
end;

function WindSpeed(vWindSpeed: Single): Single;
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

function FixAstronomy(vValue: WideString): WideString;
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

function SunSpot(vSunrise, vSunset: Single): Single;
var
  vTime_Now: TTimeSpan;
  vTime_Now_Sec: Single;

  vTime_Now_Sel_Country: Single;

  vTime_Total: Single;
  vReal_Total: Single;
  vReal_To_100: Single;

  vZone: TTimeZoneInformation;
  vSecods_zone: Single;
begin
  GetTimeZoneInformation(vZone);
  vSecods_zone := (vZone.Bias.ToSingle) * 60;

  vTime_Now := TTimeSpan.Parse(FormatDateTime('hh:mm:ss', now));
  vTime_Now_Sec := vTime_Now.TotalSeconds;
  vTime_Now_Sec := vTime_Now_Sec + vSecods_zone;

  if uDB_AUser.Local.ADDONS.Weather_D.Provider = 'yahoo' then
  begin
    vTime_Now_Sel_Country := StrToFloat(weather.Action.Yahoo.Data_Town[vWeather.Scene.Control.TabIndex].Location.OffSetSecs);
    vTime_Now_Sel_Country := vTime_Now_Sec + vTime_Now_Sel_Country;
  end
  else
  begin

  end;

  if (vTime_Now_Sel_Country >= vSunrise) and (vTime_Now_Sel_Country <= vSunset) then
  begin
    vTime_Total := vSunset - vSunrise;
    vReal_Total := vTime_Now_Sel_Country - vSunrise;

    vReal_To_100 := (vReal_Total * 100) / vTime_Total;

    Result := (vReal_To_100 * 250) / 100;
  end
  else
    Result := -1;
end;

end.
