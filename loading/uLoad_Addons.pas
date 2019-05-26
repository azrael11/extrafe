unit uLoad_Addons;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Inifiles;

procedure uLoad_Addons_FirstTime;
procedure uLoad_Addons_Load;

procedure uLoad_Addons_LoadDefaults;

// Addon Time
procedure uLoad_Addons_Time_FirstTime;
procedure uLoad_Addons_Time_Load;
// Addon Calendar
procedure uLoad_Addons_Calendar_FirstTime;
procedure uLoad_Addons_Calendar_Load;
// Addon Weather
procedure uLoad_Addons_Weather_FirstTime;
procedure uLoad_Addons_Weather_Load;
// Addon Soundplayer
procedure uLoad_Addons_Soundplayer_FirstTime;
procedure uLoad_Addons_Soundplayer_Load;
// Addon Play
procedure uLoad_Addons_Play_FirstTime;
procedure uLoad_Addons_Play_Load;

implementation

uses
  loading,
  uLoad_AllTypes,
  uWindows,
  uWeather_SetAll,
  uAzHung_AllTypes,
  uWeather_Providers_Yahoo;

procedure uLoad_Addons_FirstTime;
begin
  extrafe.ini.ini.WriteBool('Addons', 'Active', True);
  extrafe.ini.ini.WriteInteger('Addons', 'Active_Num', 1);
  extrafe.ini.ini.WriteInteger('Addons', 'Total_Num', 4);

  uLoad_Addons_Time_FirstTime;
  uLoad_Addons_Calendar_FirstTime;
  uLoad_Addons_Soundplayer_FirstTime;
  uLoad_Addons_Weather_FirstTime;
  uLoad_Addons_Play_FirstTime;
end;

procedure uLoad_Addons_Load;
var
  vi: Integer;
  Addon_Active: Boolean;
  Addon_Position: Integer;
  Addon_Name: String;
begin
  uLoad_Addons_Time_Load;
  uLoad_Addons_Calendar_Load;
  uLoad_Addons_Weather_Load;
  uLoad_Addons_Soundplayer_Load;
  uLoad_Addons_Play_Load;

  if addons.Active then
  begin
    for vi := 0 to addons.Total_Num do
    begin
      case vi of
        0:
          begin
            Addon_Name := addons.time.ini.ini.ReadString('TIME', 'Addon_Name', Addon_Name);
            Addon_Active := addons.time.ini.ini.ReadBool('TIME', 'Active', Addon_Active);
            Addon_Position := addons.time.ini.ini.ReadInteger('TIME', 'Menu_Position', Addon_Position);
          end;
        1:
          begin
            Addon_Name := addons.calendar.ini.ini.ReadString('CALENDAR', 'Addon_Name', Addon_Name);
            Addon_Active := addons.calendar.ini.ini.ReadBool('CALENDAR', 'Active', Addon_Active);
            Addon_Position := addons.calendar.ini.ini.ReadInteger('CALENDAR', 'Menu_Position', Addon_Position);
          end;
        2:
          begin
            Addon_Name := addons.weather.ini.ini.ReadString('WEATHER', 'Addon_Name', Addon_Name);
            Addon_Active := addons.weather.ini.ini.ReadBool('WEATHER', 'Active', Addon_Active);
            Addon_Position := addons.weather.ini.ini.ReadInteger('WEATHER', 'Menu_Position', Addon_Position);
          end;
        3:
          begin
            Addon_Name := addons.soundplayer.ini.ini.ReadString('SOUNDPLAYER', 'Addon_Name', Addon_Name);
            Addon_Active := addons.soundplayer.ini.ini.ReadBool('SOUNDPLAYER', 'Active', Addon_Active);
            Addon_Position := addons.soundplayer.ini.ini.ReadInteger('SOUNDPLAYER', 'Menu_Position', Addon_Position);
          end;
        4:
          begin
            Addon_Name := addons.play.ini.ini.ReadString('PLAY', 'Addon_Name', Addon_Name);
            Addon_Active := addons.play.ini.ini.ReadBool('PLAY', 'Active', Addon_Active);
            Addon_Position := addons.play.ini.ini.ReadInteger('PLAY', 'Menu_Position', Addon_Position);
          end;
      end;

      if (Addon_Active) and (Addon_Position <> -1) then
      begin
        addons.Active_PosNames[Addon_Position] := Addon_Name;
        if Addon_Name = 'soundplayer' then
          uLoad_Addons_Soundplayer_Load
        else if Addon_Name = 'weather' then
          uLoad_Addons_Weather_Load;
      end;
    end;
    ex_load.Scene.Progress.Value := 100;
  end;
end;

procedure uLoad_Addons_LoadDefaults;
begin
  // Addons
  addons.Active := extrafe.ini.ini.ReadBool('Addons', 'Active', addons.Active);
  addons.Active_Num := extrafe.ini.ini.ReadInteger('Addons', 'Active_num', addons.Active_Num);
  addons.Total_Num := extrafe.ini.ini.ReadInteger('Addons', 'Total_Num', addons.Total_Num);
end;

/// /////////////////////////////////////////////////////////////////////////////
// Addon Time
procedure uLoad_Addons_Time_FirstTime;
begin
  CreateDir(extrafe.prog.Path + 'data');
  CreateDir(extrafe.prog.Path + 'data\addons');
  CreateDir(extrafe.prog.Path + 'data\addons\time');
  CreateDir(extrafe.prog.Path + 'data\addons\time\images');
  CreateDir(extrafe.prog.Path + 'data\addons\time\icon');
  CreateDir(extrafe.prog.Path + 'data\addons\time\clock');
  CreateDir(extrafe.prog.Path + 'data\addons\time\sounds');

  addons.time.ini.Path := extrafe.prog.Path + 'data\addons\time\';
  addons.time.ini.Name := 'time.ini';
  addons.time.ini.ini := TIniFile.Create(addons.time.ini.Path + addons.time.ini.Name);

  addons.time.Path.Icon := addons.time.ini.Path + 'icon\';
  addons.time.Path.Images := addons.time.ini.Path + 'images\';
  addons.time.Path.Clock := addons.time.ini.Path + 'clock\';
  addons.time.Path.Sounds := addons.time.ini.Path + 'sounds\';

  // Time addon
  addons.time.ini.ini.WriteString('TIME', 'Addon_Name', 'time');
  addons.time.ini.ini.WriteBool('TIME', 'Active', True);
  addons.time.ini.ini.WriteInteger('TIME', 'Menu_Position', 0);
  // P_Time
  addons.time.ini.ini.WriteString('TIME_LOCAL', 'Visible_Type', 'Analog');
  addons.time.ini.ini.WriteString('TIME_LOCAL', 'Analog_Circle', 'System');
  addons.time.ini.ini.WriteString('TIME_LOCAL', 'Analog_Hour_Image', addons.time.Path.Clock + 'default\t_analog_hour_image.png');
  addons.time.ini.ini.WriteString('TIME_LOCAL', 'Analog_Minutes_Image', 'System');
  addons.time.ini.ini.WriteString('TIME_LOCAL', 'Analog_Hour_Indicator', addons.time.Path.Clock + 'default\t_analog_hour.png');
  addons.time.ini.ini.WriteString('TIME_LOCAL', 'Analog_Minutes_Indicator', addons.time.Path.Clock + 'default\t_analog_minutes.png');
  addons.time.ini.ini.WriteString('TIME_LOCAL', 'Analog_Seconds_Indicator', addons.time.Path.Clock + 'default\t_analog_seconds.png');
  addons.time.ini.ini.WriteString('TIME_LOCAL', 'Analog_Quarters', addons.time.Path.Clock + 'default\t_analog_quarters.png');
  addons.time.ini.ini.WriteBool('TIME_LOCAL', 'Analog_ShowQuarters', False);
  addons.time.ini.ini.WriteBool('TIME_LOCAL', 'Analog_ShowHours', False);
  addons.time.ini.ini.WriteString('TIME_LOCAL', 'Analog_Image_Minutes', addons.time.Path.Clock + 'default\t_image_minutes.png');
  addons.time.ini.ini.WriteBool('TIME_LOCAL', 'Analog_ShowMinutes', False);
  addons.time.ini.ini.WriteBool('TIME_LOCAL', 'Analog_ShowSecondsIndicator', True);
  addons.time.ini.ini.WriteString('TIME_LOCAL', 'Digital_Type', 'System');
  addons.time.ini.ini.WriteString('TIME_LOCAL', 'Digital_Font', 'Tahoma');
  addons.time.ini.ini.WriteString('TIME_LOCAL', 'Digital_Color', 'White');
  addons.time.ini.ini.WriteString('TIME_LOCAL', 'Digital_Sep', ':');
  addons.time.ini.ini.WriteString('TIME_LOCAL', 'Digital_Color_Back', 'Deepskyblue');
  addons.time.ini.ini.WriteString('TIME_LOCAL', 'Digital_Color_Back_Stroke', 'White');
  addons.time.ini.ini.WriteString('TIME_LOCAL', 'Digital_ImageFolder', addons.time.Path.Clock + 'default\');
  addons.time.ini.ini.WriteString('TIME_LOCAL', 'Digital_Matrix', addons.time.Path.Clock + 'default\');

  addons.time.ini.ini.WriteString('ALARM', 'Set_0', '');
  addons.time.ini.ini.WriteString('COUNTDWN', 'Last', '');
  addons.time.ini.ini.WriteString('COUNTTIME', 'Lap_0', '');
  addons.time.ini.ini.WriteString('WORLD_TIME', 'Time_0', '');
end;

procedure uLoad_Addons_Time_Load;
begin
  addons.time.ini.Path := extrafe.prog.Path + 'data\addons\time\';
  addons.time.ini.Name := 'time.ini';
  addons.time.ini.ini := TIniFile.Create(addons.time.ini.Path + addons.time.ini.Name);

  addons.time.Name := addons.time.ini.ini.ReadString('TIME', 'Addon_Name', addons.time.Name);
  addons.time.Active := addons.time.ini.ini.ReadBool('TIME', 'Active', addons.time.Active);
  addons.time.Main_Menu_Position := addons.time.ini.ini.ReadInteger('Addons', 'Menu_Position', addons.time.Main_Menu_Position);
  addons.time.Path.Icon := addons.time.ini.Path + 'icon\';
  addons.time.Path.Images := addons.time.ini.Path + 'images\';
  addons.time.Path.Clock := addons.time.ini.Path + 'clock\';
  addons.time.Path.Sounds := addons.time.ini.Path + 'sounds\';

  // P_Local Time
  addons.time.P_Time.Clock_Type := addons.time.ini.ini.ReadString('TIME_LOCAL', 'Visible_Type', addons.time.P_Time.Clock_Type);
  addons.time.P_Time.Analog_Circle_Path := addons.time.ini.ini.ReadString('TIME_LOCAL', 'Analog_Circle', addons.time.P_Time.Analog_Circle_Path);
  addons.time.P_Time.Analog_Hour_Indicator_Path := addons.time.ini.ini.ReadString('TIME_LOCAL', 'Analog_Hour_Indicator',
    addons.time.P_Time.Analog_Hour_Indicator_Path);
  addons.time.P_Time.Analog_Minutes_Indicator_Path := addons.time.ini.ini.ReadString('TIME_LOCAL', 'Analog_Minutes_Indicator',
    addons.time.P_Time.Analog_Minutes_Indicator_Path);
  addons.time.P_Time.Analog_Seconds_Indicator_Path := addons.time.ini.ini.ReadString('TIME_LOCAL', 'Analog_Seconds_Indicator',
    addons.time.P_Time.Analog_Seconds_Indicator_Path);
  addons.time.P_Time.Analog_Hour_Path := addons.time.ini.ini.ReadString('TIME_LOCAL', 'Analog_Hour_Image', addons.time.P_Time.Analog_Hour_Path);
  addons.time.P_Time.Analog_Minutes_Path := addons.time.ini.ini.ReadString('TIME_LOCAL', 'Analog_Minutes_Image', addons.time.P_Time.Analog_Minutes_Path);
  addons.time.P_Time.Analog_Img_Quarters_Path := addons.time.ini.ini.ReadString('TIME_LOCAL', 'Analog_Quarters', addons.time.P_Time.Analog_Img_Quarters_Path);
  addons.time.P_Time.Analog_Img_Quarters_Show := addons.time.ini.ini.ReadBool('TIME_LOCAL', 'Analog_ShowQuarters', addons.time.P_Time.Analog_Img_Quarters_Show);
  addons.time.P_Time.Analog_Img_Hours_Show := addons.time.ini.ini.ReadBool('TIME_LOCAL', 'Analog_ShowHours', addons.time.P_Time.Analog_Img_Hours_Show);
  addons.time.P_Time.Analog_Img_Minutes_Path := addons.time.ini.ini.ReadString('TIME_LOCAL', 'Analog_Image_Minutes',
    addons.time.P_Time.Analog_Img_Minutes_Path);
  addons.time.P_Time.Analog_Img_Minutes_Show := addons.time.ini.ini.ReadBool('TIME_LOCAL', 'Analog_ShowMinutes', addons.time.P_Time.Analog_Img_Minutes_Show);
  addons.time.P_Time.Analog_Seconds_Indicator := addons.time.ini.ini.ReadBool('TIME_LOCAL', 'Analog_ShowSecondsIndicator',
    addons.time.P_Time.Analog_Seconds_Indicator);
  addons.time.P_Time.Digital_Type := addons.time.ini.ini.ReadString('TIME_LOCAL', 'Digital_Type', addons.time.P_Time.Digital_Type);
  addons.time.P_Time.Digital_Font := addons.time.ini.ini.ReadString('TIME_LOCAL', 'Digital_Font', addons.time.P_Time.Digital_Font);
  addons.time.P_Time.Digital_Color := addons.time.ini.ini.ReadString('TIME_LOCAL', 'Digital_Color', addons.time.P_Time.Digital_Color);
  addons.time.P_Time.Digital_Sep := addons.time.ini.ini.ReadString('TIME_LOCAL', 'Digital_Sep', addons.time.P_Time.Digital_Sep);
  addons.time.P_Time.Digital_Color_Back := addons.time.ini.ini.ReadString('TIME_LOCAL', 'Digital_Color_Back', addons.time.P_Time.Digital_Color_Back);
  addons.time.P_Time.Digital_Color_Back_Stroke := addons.time.ini.ini.ReadString('TIME_LOCAL', 'Digital_Color_Back_Stroke',
    addons.time.P_Time.Digital_Color_Back_Stroke);
  addons.time.P_Time.Digital_Img_Folder := addons.time.ini.ini.ReadString('TIME_LOCAL', 'Digital_ImageFolder', addons.time.P_Time.Digital_Img_Folder);
  addons.time.P_Time.Digital_Matrix := addons.time.ini.ini.ReadString('TIME_LOCAL', 'Digital_Matrix', addons.time.P_Time.Digital_Matrix);
end;

/// /////////////////////////////////////////////////////////////////////////////
// Addon Calendar
procedure uLoad_Addons_Calendar_FirstTime;
begin
  CreateDir(extrafe.prog.Path + 'data');
  CreateDir(extrafe.prog.Path + 'data\addons');
  CreateDir(extrafe.prog.Path + 'data\addons\calendar');
  CreateDir(extrafe.prog.Path + 'data\addons\calendar\images');
  CreateDir(extrafe.prog.Path + 'data\addons\calendar\icon');

  addons.calendar.ini.Path := extrafe.prog.Path + 'data\addons\calendar\';
  addons.calendar.ini.Name := 'calendar.ini';
  addons.calendar.ini.ini := TIniFile.Create(addons.calendar.ini.Path + addons.calendar.ini.Name);
  addons.calendar.Path.Icon := addons.calendar.ini.Path + 'icon\';
  addons.calendar.Path.Images := addons.calendar.ini.Path + 'images\';

  addons.calendar.ini.ini.WriteString('CALENDAR', 'Addon_Name', 'calendar');
  addons.calendar.ini.ini.WriteBool('CALENDAR', 'Active', True);
  addons.calendar.ini.ini.WriteInteger('CALENDAR', 'Menu_Position', 1);

  addons.time.ini.ini.WriteInteger('BOOK', 'Books', 0);
  addons.time.ini.ini.WriteString('BOOK_0', 'Event_0', '');
end;

procedure uLoad_Addons_Calendar_Load;
begin
  addons.calendar.ini.Path := extrafe.prog.Path + 'data\addons\calendar\';
  addons.calendar.ini.Name := 'calendar.ini';
  addons.calendar.ini.ini := TIniFile.Create(addons.calendar.ini.Path + addons.calendar.ini.Name);
  addons.calendar.Path.Icon := addons.calendar.ini.Path + 'icon\';
  addons.calendar.Path.Images := addons.calendar.ini.Path + 'images\';

  addons.calendar.Name := addons.calendar.ini.ini.ReadString('CALENDAR', 'Addon_Name', addons.calendar.Name);
  addons.calendar.Active := addons.calendar.ini.ini.ReadBool('CALENDAR', 'Active', addons.calendar.Active);
  addons.calendar.Main_Menu_Position := addons.calendar.ini.ini.ReadInteger('CALENDAR', 'Menu_Position', addons.calendar.Main_Menu_Position);
end;

/// /////////////////////////////////////////////////////////////////////////////
// Addon Weather
procedure uLoad_Addons_Weather_FirstTime;
begin
  CreateDir(extrafe.prog.Path + 'data');
  CreateDir(extrafe.prog.Path + 'data\addons');
  CreateDir(extrafe.prog.Path + 'data\addons\weather');
  CreateDir(extrafe.prog.Path + 'data\addons\weather\temp');
  CreateDir(extrafe.prog.Path + 'data\addons\weather\docs');
  CreateDir(extrafe.prog.Path + 'data\addons\weather\icon');
  CreateDir(extrafe.prog.Path + 'data\addons\weather\icons');
  CreateDir(extrafe.prog.Path + 'data\addons\weather\images');
  CreateDir(extrafe.prog.Path + 'data\addons\weather\sounds');
  CreateDir(extrafe.prog.Path + 'data\addons\weather\temp');

  addons.weather.ini.Path := extrafe.prog.Path + 'data\addons\weather\';
  addons.weather.ini.Name := 'weather.ini';
  addons.weather.ini.ini := TIniFile.Create(addons.weather.ini.Path + addons.weather.ini.Name);
  addons.weather.Path.Icon := addons.weather.ini.Path + 'icon\';
  addons.weather.Path.Images := addons.weather.ini.Path + 'images\';
  addons.weather.Path.Iconsets := addons.weather.ini.Path + 'icons\';
  addons.weather.Path.Temp := addons.weather.ini.Path + 'temp\';

  addons.weather.ini.ini.WriteString('WEATHER', 'Addon_Name', 'weather');
  addons.weather.ini.ini.WriteBool('WEATHER', 'Active', False);
  addons.weather.ini.ini.WriteInteger('WEATHER', 'Menu_Position', -1);

  addons.weather.ini.ini.WriteBool('General', 'First', False);
  addons.weather.ini.ini.WriteInteger('Active', 'Active_Woeid', -1);
  addons.weather.ini.ini.WriteInteger('Active', 'Active_Total', -1);
  addons.weather.ini.ini.WriteString('Options', 'Degree', 'Celcius');
  addons.weather.ini.ini.WriteInteger('Options', 'Refresh', 0);
  addons.weather.ini.ini.WriteInteger('Iconset', 'Count', 2);
  addons.weather.ini.ini.WriteString('Iconset', 'Name', 'pengui');
  addons.weather.ini.ini.WriteString('Provider', 'Name', '');
  addons.weather.ini.ini.WriteInteger('openweathermap', 'Total', -1);
  // Yahoo specific
  addons.weather.Action.Yahoo.Total_WoeID := -1;
  addons.weather.Action.Yahoo.Selected_Unit:= 'imperial';

end;

procedure uLoad_Addons_Weather_Load;
begin
  addons.weather.ini.Path := extrafe.prog.Path + 'data\addons\weather\';
  addons.weather.ini.Name := 'weather.ini';
  addons.weather.ini.ini := TIniFile.Create(addons.weather.ini.Path + addons.weather.ini.Name);

  addons.weather.Name := addons.weather.ini.ini.ReadString('WEATHER', 'Addon_Name', addons.weather.Name);
  addons.weather.Active := addons.weather.ini.ini.ReadBool('WEATHER', 'Active', addons.weather.Active);
  addons.weather.Main_Menu_Position := addons.weather.ini.ini.ReadInteger('WEATHER', 'Menu_Position', addons.weather.Main_Menu_Position);
  addons.weather.Path.Icon := addons.weather.ini.Path + 'icon\';
  addons.weather.Path.Images := addons.weather.ini.Path + 'images\';
  addons.weather.Path.Iconsets := addons.weather.ini.Path + 'icons\';
  addons.weather.Path.Sounds := addons.weather.ini.Path + 'sounds\';
  addons.weather.Path.Temp := addons.weather.ini.Path + 'temp\';

  addons.weather.Action.First := addons.weather.ini.ini.ReadBool('General', 'First', addons.weather.Action.First);
  addons.weather.Action.Provider := addons.weather.ini.ini.ReadString('Provider', 'Name', addons.weather.Action.Provider);
  addons.weather.Action.Provider_Total := addons.weather.ini.ini.ReadInteger(addons.weather.Action.Provider, 'Total', addons.weather.Action.Provider_Total);
  addons.weather.Action.Active_WEOID := addons.weather.ini.ini.ReadInteger('Provider', 'Active_Woeid', addons.weather.Action.Active_WEOID);
  addons.weather.Action.Active_Total := addons.weather.ini.ini.ReadInteger('Active', 'Active_Total', addons.weather.Action.Active_Total);
  addons.weather.Action.Degree := addons.weather.ini.ini.ReadString('Options', 'Degree', addons.weather.Action.Degree);
  addons.weather.Config.Refresh_Once := addons.weather.ini.ini.ReadBool('Options', 'Refresh', addons.weather.Config.Refresh_Once);
  addons.weather.Config.Iconset.Name := addons.weather.ini.ini.ReadString('Iconset', 'Name', addons.weather.Config.Iconset.Name);

  // Yahoo specific
  if addons.weather.Action.Provider = 'yahoo' then
  begin
    if addons.weather.ini.ini.ValueExists('yahoo', 'total') then
      addons.weather.Action.Yahoo.Total_WoeID := addons.weather.ini.ini.ReadInteger('yahoo', 'total', addons.weather.Action.Yahoo.Total_WoeID)
    else
      addons.weather.Action.Yahoo.Total_WoeID := -1;
    if addons.weather.ini.ini.ValueExists('yahoo', 'selected_unit') then
      addons.weather.Action.Yahoo.Selected_Unit := addons.weather.Ini.Ini.ReadString('yahoo', 'Selected_Unit', addons.weather.Action.Yahoo.Selected_Unit)
    else
      addons.weather.Action.Yahoo.Selected_Unit:= 'imperial';
    uWeather_Providers_Yahoo.Woeid_List;
  end;

  addons.weather.Config.Iconset.Count := uWindows_CountFilesOrFolders(addons.weather.Path.Iconsets, False, '');
  addons.weather.Config.Iconset.Names := TStringList.Create;
  addons.weather.Config.Iconset.Names := uWindows_GetFolderNames(addons.weather.Path.Iconsets);
end;

/// /////////////////////////////////////////////////////////////////////////////
// Addon Soundplayer
procedure uLoad_Addons_Soundplayer_FirstTime;
begin
  CreateDir(extrafe.prog.Path + 'data');
  CreateDir(extrafe.prog.Path + 'data\addons');
  CreateDir(extrafe.prog.Path + 'data\addons\soundplayer');
  CreateDir(extrafe.prog.Path + 'data\addons\soundplayer\icon');
  CreateDir(extrafe.prog.Path + 'data\addons\soundplayer\images');
  CreateDir(extrafe.prog.Path + 'data\addons\soundplayer\files');
  CreateDir(extrafe.prog.Path + 'data\addons\soundplayer\playlists');
  CreateDir(extrafe.prog.Path + 'data\addons\soundplayer\sounds');

  addons.soundplayer.ini.Path := extrafe.prog.Path + 'data\addons\soundplayer\';
  addons.soundplayer.ini.Name := 'soundplayer.ini';
  addons.soundplayer.ini.ini := TIniFile.Create(addons.soundplayer.ini.Path + addons.soundplayer.ini.Name);
  addons.soundplayer.Path.Icon := addons.soundplayer.ini.Path + 'icon\';
  addons.soundplayer.Path.Images := addons.soundplayer.ini.Path + 'images\';
  addons.soundplayer.Path.Files := addons.soundplayer.ini.Path + 'files\';
  addons.soundplayer.Path.Playlists := addons.soundplayer.ini.Path + 'playlists\';
  addons.soundplayer.Path.Sounds := addons.soundplayer.ini.Path + 'sounds\';

  addons.soundplayer.ini.ini.WriteString('SOUNDPLAYER', 'Addon_Name', 'soundplayer');
  addons.soundplayer.ini.ini.WriteBool('SOUNDPLAYER', 'Active', False);
  addons.soundplayer.ini.ini.WriteInteger('SOUNDPLAYER', 'Menu_Position', -1);

  addons.soundplayer.ini.ini.WriteBool('General', 'First', False);

  addons.soundplayer.ini.ini.WriteInteger('Playlists', 'TotalPlaylists', -1);
  addons.soundplayer.ini.ini.WriteInteger('Playlists', 'ActivePlaylist', -1);
  addons.soundplayer.ini.ini.WriteString('Playlists', 'ActivePlaylistName', '');
  addons.soundplayer.ini.ini.WriteInteger('Song', 'LastPlayed', -1);
  addons.soundplayer.ini.ini.WriteString('Volume', 'State', 'Master');
  addons.soundplayer.ini.ini.WriteInteger('Volume', 'Master', 1);
  addons.soundplayer.ini.ini.WriteInteger('Volume', 'Left', 1);
  addons.soundplayer.ini.ini.WriteInteger('Volume', 'Right', 1);
  addons.soundplayer.ini.ini.WriteFloat('Equalizer', 'Pan', 0);
  addons.soundplayer.ini.ini.WriteFloat('Equalizer', 'PreAMP', 0);
  addons.soundplayer.ini.ini.WriteFloat('Equalizer', 'Param_0', 0);
  addons.soundplayer.ini.ini.WriteFloat('Equalizer', 'Param_1', 0);
  addons.soundplayer.ini.ini.WriteFloat('Equalizer', 'Param_2', 0);
  addons.soundplayer.ini.ini.WriteFloat('Equalizer', 'Param_3', 0);
  addons.soundplayer.ini.ini.WriteFloat('Equalizer', 'Param_4', 0);
  addons.soundplayer.ini.ini.WriteFloat('Equalizer', 'Param_5', 0);
  addons.soundplayer.ini.ini.WriteFloat('Equalizer', 'Param_6', 0);
  addons.soundplayer.ini.ini.WriteFloat('Equalizer', 'Param_7', 0);
  addons.soundplayer.ini.ini.WriteFloat('Equalizer', 'Param_8', 0);
  addons.soundplayer.ini.ini.WriteFloat('Equalizer', 'Param_9', 0);
  addons.soundplayer.ini.ini.WriteString('Equalizer', 'Preset', 'Default');
  addons.soundplayer.ini.ini.WriteBool('Equalizer', 'Cross_Fade', False);
  addons.soundplayer.ini.ini.WriteInteger('Equalizer', 'Cross_Fade_Secs', 0);
end;

procedure uLoad_Addons_Soundplayer_Load;
begin
  addons.soundplayer.ini.Path := extrafe.prog.Path + 'data\addons\soundplayer\';
  addons.soundplayer.ini.Name := 'soundplayer.ini';
  addons.soundplayer.ini.ini := TIniFile.Create(addons.soundplayer.ini.Path + addons.soundplayer.ini.Name);

  addons.soundplayer.Name := addons.soundplayer.ini.ini.ReadString('SOUNDPLAYER', 'Addon_Name', addons.soundplayer.Name);
  addons.soundplayer.Active := addons.soundplayer.ini.ini.ReadBool('SOUNDPLAYER', 'Active', addons.soundplayer.Active);
  addons.soundplayer.Main_Menu_Position := addons.soundplayer.ini.ini.ReadInteger('SOUNDPLAYER', 'Menu_Position', addons.soundplayer.Main_Menu_Position);
  addons.soundplayer.Path.Icon := addons.soundplayer.ini.Path + 'icon\';
  addons.soundplayer.Path.Images := addons.soundplayer.ini.Path + 'images\';
  addons.soundplayer.Path.Files := addons.soundplayer.ini.Path + 'files\';
  addons.soundplayer.Path.Playlists := addons.soundplayer.ini.Path + 'playlists\';
  addons.soundplayer.Path.Sounds := addons.soundplayer.ini.Path + 'sounds\';

  addons.soundplayer.Actions.First := addons.soundplayer.ini.ini.ReadBool('General', 'First', addons.soundplayer.Actions.First);

  addons.soundplayer.Playlist.Total := addons.soundplayer.ini.ini.ReadInteger('Playlists', 'TotalPlaylists', addons.soundplayer.Playlist.Total);
  addons.soundplayer.Playlist.Active := addons.soundplayer.ini.ini.ReadInteger('Playlists', 'ActivePlaylist', addons.soundplayer.Playlist.Active);
  addons.soundplayer.Playlist.List.Name := addons.soundplayer.ini.ini.ReadString('Playlists', 'ActivePlaylistName', addons.soundplayer.Playlist.List.Name);
  addons.soundplayer.Player.LastPlayed := addons.soundplayer.ini.ini.ReadInteger('Song', 'LastPlayed', addons.soundplayer.Player.LastPlayed);
  addons.soundplayer.Volume.State := addons.soundplayer.ini.ini.ReadString('Volume', 'State', addons.soundplayer.Volume.State);
  addons.soundplayer.Volume.Master := addons.soundplayer.ini.ini.ReadFloat('Volume', 'Master', addons.soundplayer.Volume.Master);
  addons.soundplayer.Volume.Left := addons.soundplayer.ini.ini.ReadFloat('Volume', 'Left', addons.soundplayer.Volume.Left);
  addons.soundplayer.Volume.Right := addons.soundplayer.ini.ini.ReadFloat('Volume', 'Right', addons.soundplayer.Volume.Right);

  addons.soundplayer.Equalizer.PreAmp := addons.soundplayer.ini.ini.ReadFloat('Equalizer', 'PreAMP', addons.soundplayer.Equalizer.PreAmp);
  addons.soundplayer.Equalizer.Pan := addons.soundplayer.ini.ini.ReadFloat('Equalizer', 'Pan', addons.soundplayer.Equalizer.Pan);
  addons.soundplayer.Equalizer.Param[0] := addons.soundplayer.ini.ini.ReadFloat('Equalizer', 'Param_0', addons.soundplayer.Equalizer.Param[0]);
  addons.soundplayer.Equalizer.Param[1] := addons.soundplayer.ini.ini.ReadFloat('Equalizer', 'Param_1', addons.soundplayer.Equalizer.Param[1]);
  addons.soundplayer.Equalizer.Param[2] := addons.soundplayer.ini.ini.ReadFloat('Equalizer', 'Param_2', addons.soundplayer.Equalizer.Param[2]);
  addons.soundplayer.Equalizer.Param[3] := addons.soundplayer.ini.ini.ReadFloat('Equalizer', 'Param_3', addons.soundplayer.Equalizer.Param[3]);
  addons.soundplayer.Equalizer.Param[4] := addons.soundplayer.ini.ini.ReadFloat('Equalizer', 'Param_4', addons.soundplayer.Equalizer.Param[4]);
  addons.soundplayer.Equalizer.Param[5] := addons.soundplayer.ini.ini.ReadFloat('Equalizer', 'Param_5', addons.soundplayer.Equalizer.Param[5]);
  addons.soundplayer.Equalizer.Param[6] := addons.soundplayer.ini.ini.ReadFloat('Equalizer', 'Param_6', addons.soundplayer.Equalizer.Param[6]);
  addons.soundplayer.Equalizer.Param[7] := addons.soundplayer.ini.ini.ReadFloat('Equalizer', 'Param_7', addons.soundplayer.Equalizer.Param[7]);
  addons.soundplayer.Equalizer.Param[8] := addons.soundplayer.ini.ini.ReadFloat('Equalizer', 'Param_8', addons.soundplayer.Equalizer.Param[8]);
  addons.soundplayer.Equalizer.Param[9] := addons.soundplayer.ini.ini.ReadFloat('Equalizer', 'Param_9', addons.soundplayer.Equalizer.Param[9]);
  addons.soundplayer.Equalizer.Preset := addons.soundplayer.ini.ini.ReadString('Equalizer', 'Preset', addons.soundplayer.Equalizer.Preset);
  addons.soundplayer.Equalizer.Live_Preview := False;
  addons.soundplayer.Equalizer.Cross_Fade := addons.soundplayer.ini.ini.ReadBool('Equalizer', 'Cross_Fade', addons.soundplayer.Equalizer.Cross_Fade);
  addons.soundplayer.Equalizer.Cross_Fade_Sec := addons.soundplayer.ini.ini.ReadInteger('Equalizer', 'Cross_Fade_Secs',
    addons.soundplayer.Equalizer.Cross_Fade_Sec);
end;

/// //////////////////////////////////////////////////////////////////////////////////////////////////////////
// Addon Play

procedure uLoad_Addons_Play_FirstTime;
begin
  CreateDir(extrafe.prog.Path + 'data');
  CreateDir(extrafe.prog.Path + 'data\addons');
  CreateDir(extrafe.prog.Path + 'data\addons\play');
  CreateDir(extrafe.prog.Path + 'data\addons\play\azhung');
  CreateDir(extrafe.prog.Path + 'data\addons\play\azmatch');
  CreateDir(extrafe.prog.Path + 'data\addons\play\azong');
  CreateDir(extrafe.prog.Path + 'data\addons\play\azsuko');
  CreateDir(extrafe.prog.Path + 'data\addons\play\aztype');

  addons.play.ini.Path := extrafe.prog.Path + 'data\addons\play\';
  addons.play.ini.Name := 'play.ini';
  addons.play.ini.ini := TIniFile.Create(addons.play.ini.Path + addons.play.ini.Name);
  addons.play.Path.Icon := addons.soundplayer.ini.Path + 'icon\';
  addons.play.Path.Images := addons.soundplayer.ini.Path + 'images\';
  addons.play.Path.Sounds := addons.soundplayer.ini.Path + 'sounds\';

  addons.play.ini.ini.WriteString('PLAY', 'Addon_Name', 'play');
  addons.play.ini.ini.WriteBool('PLAY', 'Active', False);
  addons.play.ini.ini.WriteInteger('PLAY', 'Menu_Position', -1);

  // Game AzHung
  gAzHung.Path.Game := addons.play.ini.Path + 'azhung\';
  gAzHung.Path.Icon := gAzHung.Path.Game + 'icon\';
  gAzHung.Path.Sounds := gAzHung.Path.Game + 'sounds\';
  gAzHung.Path.Images := gAzHung.Path.Game + 'images\';
  gAzHung.Path.Score := gAzHung.Path.Game + 'score\';
  gAzHung.Path.Words := gAzHung.Path.Game + 'words\';

  gAzHung.ini.Name := 'azhung.ini';
  gAzHung.ini.Path := gAzHung.Path.Game;
  gAzHung.ini.ini := TIniFile.Create(gAzHung.ini.Path + gAzHung.ini.Name);

  gAzHung.ini.ini.WriteBool('AZHUNG', 'Active', False);
  gAzHung.ini.ini.WriteBool('AZHUNG', 'Pause', False);
  gAzHung.ini.ini.WriteString('AZHUNG', 'Words', 'words.ini');

end;

procedure uLoad_Addons_Play_Load;
begin
  addons.play.ini.Path := extrafe.prog.Path + 'data\addons\play\';
  addons.play.ini.Name := 'play.ini';
  addons.play.ini.ini := TIniFile.Create(addons.play.ini.Path + addons.play.ini.Name);

  addons.play.Name := addons.play.ini.ini.ReadString('PLAY', 'Addon_Name', addons.play.Name);
  addons.play.Active := addons.play.ini.ini.ReadBool('PLAY', 'Active', addons.play.Active);
  addons.play.Main_Menu_Position := addons.play.ini.ini.ReadInteger('PLAY', 'Menu_Position', addons.play.Main_Menu_Position);
  addons.play.Path.Icon := addons.play.ini.Path + 'icon\';
  addons.play.Path.Images := addons.play.ini.Path + 'images\';
  addons.play.Path.Sounds := addons.play.ini.Path + 'sounds\';

  // Game AzHung
  gAzHung.Path.Game := addons.play.ini.Path + 'azhung\';
  gAzHung.Path.Icon := gAzHung.Path.Game + 'icon\';
  gAzHung.Path.Sounds := gAzHung.Path.Game + 'sounds\';
  gAzHung.Path.Images := gAzHung.Path.Game + 'images\';
  gAzHung.Path.Score := gAzHung.Path.Game + 'score\';
  gAzHung.Path.Words := gAzHung.Path.Game + 'words\';

  gAzHung.ini.Name := 'azhung.ini';
  gAzHung.ini.Path := gAzHung.Path.Game;
  gAzHung.ini.ini := TIniFile.Create(gAzHung.ini.Path + gAzHung.ini.Name);

  gAzHung.Actions.Active := gAzHung.ini.ini.ReadBool('AZHUNG', 'Active', gAzHung.Actions.Active);
  gAzHung.Actions.Paused := gAzHung.ini.ini.ReadBool('AZHUNG', 'Pause', gAzHung.Actions.Paused);
  gAzHung.Actions.Words := gAzHung.ini.ini.ReadString('AZHUNG', 'Words', gAzHung.Actions.Words);
end;

end.
