﻿unit uDB_Check;

interface

uses
  System.Classes,
  CodeSiteLogging;

{ Check if Tables exists and create the missing one }
procedure Local_tables;

{ Check if Columns exits or have someone to delete }
procedure Local_Columns;
procedure Users;
procedure Users_Statistics;
procedure Settings;
procedure Options;
procedure Addons;
procedure Addon_Time;
procedure Addon_Time_Time;
procedure Addon_Calendar;
procedure Addon_Weather;
procedure Addon_Weather_OWM;
procedure Addon_Weather_Yahoo;
procedure Addon_Soundplayer;
procedure Addon_Soundplayer_Playlists;
procedure Addon_AzPlay;
procedure Emulators;
procedure Arcade;
procedure Arcade_Mame;
procedure Arcade_Media;
procedure Computers;
procedure Consoles;
procedure Handhelds;
procedure Pinballs;

implementation

uses
  uDB;

{ Check if Tables exists and create the missing one }
procedure Local_tables;
begin
  CodeSite.EnterMethod('Check Tables of Extrafe local database (SQLLite)');
  { 22 Tables }
  // Users ->
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text :=
    'CREATE TABLE IF NOT EXISTS users ("USER_ID" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "USERNAME" Text,	"PASSWORD" Text,	"NAME" Text, "SURNAME" Text, "IP" Text, "UNIQUE_ID" Integer, '
    + '"REGISTERED" Text, "GENDER" Boolean, "AVATAR" Text, "LAST_VISIT" Text, "LAST_VISIT_ONLINE" Text, "EMAIL" Text, "COUNTRY" Text, "ACTIVE_ONLINE" Boolean);';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "users" is checked and corrected');

  // Users_Statistics ->
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'CREATE TABLE IF NOT EXISTS users_statistics ("USER_ID" Integer);';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "users_statistics" is checked and corrected');

  // Settings ->
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text :=
    'CREATE TABLE IF NOT EXISTS settings ("USER_ID" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "THEME_PATH" Text,	"THEME_NUM" Integer,	"THEME_NAME" Text, "RESOLUTION_WIDTH" Integer, ' +
    '"RESOLUTION_HEIGHT" Integer, "PATH_LIB" Text, "PATH_HISTORY" Text, "PATH_FONTS" Text, "PATH" Text, "LOCAL_DATA" Boolean, "FOULSCREEN" Boolean, "DATABASE_PATH" Text );';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "settings" is checked and corrected');

  // Options ->
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'CREATE TABLE IF NOT EXISTS options ("USER_ID" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "VIRTUAL_KEYBOARD" Boolean);';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "options" is checked and corrected');

  // Addons ->
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text :=
    'CREATE TABLE IF NOT EXISTS addons ("USER_ID" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "ACTIVE" DEFAULT 1 Integer,	"COUNR" DEFAULT 4 Integer,	"TIME" Boolean, "CALENDAR" Boolean, "WEATHER" Boolean, "SOUNDPLAYER" Boolean, "AZPLAY" Boolean);';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "addons" is checked and corrected');

  // Addon_Time ->
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text :=
    'CREATE TABLE IF NOT EXISTS addon_time ("USER_ID" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "FIRST_POP" DEFAULT TRUE Boolean,	"MENU_POSITION" DEFAULT 0 Integer,	"PATH_CLOCKS" Text, "PATH_IMAGES" Text, "PATH_SOUNDS" Text);';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "addon_time" is checked and corrected');

  // Addon_Time_Time ?? Εδώ πρέπει λίγο να το ξανακοιτάξω πολλές στήλες γίνονται αρκετά λιγότερες
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'CREATE TABLE IF NOT EXISTS addon_time_time ("" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "sourcefile" Text,	"savestate" Boolean,	"width" Integer );';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "addon_time_time" is checked and corrected');

  // Addon_Calendar ->
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'CREATE TABLE IF NOT EXISTS addon_calendar ("USER_ID" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "MENU_POSITION" DEFAULT 1 Integer);';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "addon_calendar" is checked and corrected');

  // Addon_Weather
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text :=
    'CREATE TABLE IF NOT EXISTS addon_weather ("game_num" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "sourcefile" Text,	"savestate" Boolean,	"width" Integer );';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "addon_weather" is checked and corrected');

  // Addon_Weather_OWM
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text :=
    'CREATE TABLE IF NOT EXISTS addon_weather_owm ("game_num" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "sourcefile" Text,	"savestate" Boolean,	"width" Integer );';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "addon_weather_owm" is checked and corrected');

  // Addon_Weather_Yahoo
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text :=
    'CREATE TABLE IF NOT EXISTS addon_weather_yahoo ("game_num" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "sourcefile" Text,	"savestate" Boolean,	"width" Integer );';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "addon_weather_yahoo" is checked and corrected');

  // Addon_Soundplayer
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text :=
    'CREATE TABLE IF NOT EXISTS addon_soundplayer ("game_num" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "sourcefile" Text,	"savestate" Boolean,	"width" Integer );';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "addon_soundplayer" is checked and corrected');

  // Addon_Soundplayer_Playlists
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text :=
    'CREATE TABLE IF NOT EXISTS addon_soundplayer_playlists ("game_num" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "sourcefile" Text,	"savestate" Boolean,	"width" Integer );';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "addon_soundplayer_playlists" is checked and corrected');

  // Addon_AzPlay
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text :=
    'CREATE TABLE IF NOT EXISTS addon_azplay ("game_num" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "sourcefile" Text,	"savestate" Boolean,	"width" Integer );';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "addon_azplay" is checked and corrected');

  // Emulators
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'CREATE TABLE IF NOT EXISTS emulators ("game_num" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "sourcefile" Text,	"savestate" Boolean,	"width" Integer );';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "emulators" is checked and corrected');

  // Arcade
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'CREATE TABLE IF NOT EXISTS arcade ("game_num" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "sourcefile" Text,	"savestate" Boolean,	"width" Integer );';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "arcade" is checked and corrected');

  // Arcade_Mame
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text :=
    'CREATE TABLE IF NOT EXISTS arcade_mame ("game_num" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "sourcefile" Text,	"savestate" Boolean,	"width" Integer );';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "arcade_mame" is checked and corrected');

  // Arcade_Media
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text :=
    'CREATE TABLE IF NOT EXISTS arcade_media ("game_num" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "sourcefile" Text,	"savestate" Boolean,	"width" Integer );';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "arcade_media" is checked and corrected');

  // Computers
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'CREATE TABLE IF NOT EXISTS computers ("game_num" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "sourcefile" Text,	"savestate" Boolean,	"width" Integer );';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "computers" is checked and corrected');

  // Consoles
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'CREATE TABLE IF NOT EXISTS consoles ("game_num" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "sourcefile" Text,	"savestate" Boolean,	"width" Integer );';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "consoles" is checked and corrected');

  // Handhelds
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'CREATE TABLE IF NOT EXISTS handhelds ("game_num" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "sourcefile" Text,	"savestate" Boolean,	"width" Integer );';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "handhelds" is checked and corrected');

  // Pinballs
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'CREATE TABLE IF NOT EXISTS pinballs ("game_num" Integer NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT, "sourcefile" Text,	"savestate" Boolean,	"width" Integer );';
  ExtraFE_Query_Local.ExecSQL;
  CodeSite.Send('Table "pinballs" is checked and corrected');

  CodeSite.ExitMethod('All the tables of the database is checked and corrected');
end;

{ Check if Columns exits or have someone to delete }
procedure Users;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("users");';
  ExtraFE_Query_Local.Open;
  ExtraFE_Query_Local.First;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Users_Statistics;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("users_statistcs");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Settings;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("settings");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Options;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("options");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Addons;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("addons");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Addon_Time;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("addon_time");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Addon_Time_Time;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("addon_time_time");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Addon_Calendar;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("addon_calendar");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Addon_Weather;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("addon_weather");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Addon_Weather_OWM;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("addon_weather_owm");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Addon_Weather_Yahoo;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("addon_weather_yahoo");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Addon_Soundplayer;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("addon_soundplayer");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Addon_Soundplayer_Playlists;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("addon_soundplayer_playlists");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Addon_AzPlay;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("addon_azplay");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Emulators;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("emulators");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Arcade;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("arcade");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Arcade_Mame;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("arcade_mame");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Arcade_Media;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("arcade_media");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Computers;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("computers");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Consoles;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("consoles");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Handhelds;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("handhelds");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Pinballs;
const
  cColumns_Names: array [0 .. 10] of string = ('', '', '', '', '', '', '', '', '', '', '');
var
  vi: Integer;
  vList: TStringlist;
begin
  vList := TStringlist.Create;

  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text := 'PRAGMA table_info("pinballs");';
  ExtraFE_Query_Local.Open;

  for vi := 0 to ExtraFE_Query_Local.FieldList.Count - 1 do
  begin

  end;
end;

procedure Local_Columns;
begin
  Users;
  Users_Statistics;
  Settings;
  Options;
  Addons;
  Addon_Time;
  Addon_Time_Time;
  Addon_Calendar;
  Addon_Weather;
  Addon_Weather_OWM;
  Addon_Weather_Yahoo;
  Addon_Soundplayer;
  Addon_Soundplayer_Playlists;
  Addon_AzPlay;
  Emulators;
  Arcade;
  Arcade_Mame;
  Arcade_Media;
  Computers;
  Consoles;
  Handhelds;
  Pinballs;
end;

end.