unit uDB_AUser;

interface

uses
  System.Classes,
  System.SysUtils,
  System.DateUtils,
  System.JSON,
  Rest.Types;

type
  TDATABASE_ACTIVE_USER_ONLINE = record
    Num: Integer;
    User_ID: String;
    Username: String;
    Password: String;
    Email: String;
    IP: String;
    Country: String;
    Name: String;
    Surname: String;
    Avatar: Integer;
    Registered: String;
    Last_Visit: String;
    Genre: Integer;
    Active: Integer;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_ADDONS_TIME_TIME = record
    vType: String;
    Analog_Width: Integer;
    Analog_Height: Integer;
    Analog_X: Integer;
    Analog_Y: Integer;
    Analog_Theme: String;
    Analog_Color: String;
    Analog_Font: String;
    Analog_Show_Ind: Boolean;
    Analog_Show_Nums: Boolean;
    Analog_Tick: Boolean;
    Digital_Width: Integer;
    Digital_Height: Integer;
    Digital_X: Integer;
    Digital_Y: Integer;
    Digital_Color: String;
    Digital_Font: String;
    Digital_Font_Color: String;
    Digital_Sep: String;
    Digital_Sep_Color: String;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_ADDONS_TIME_PATHS = record
    Images: String;
    Sounds: String;
    Clocks: String;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_ADDONS_TIME = record
    Menu_Position: Integer;
    First_Pop: Boolean;
    Path: TDATABASE_ACTIVE_USER_LOCAL_ADDONS_TIME_PATHS;
    Time: TDATABASE_ACTIVE_USER_LOCAL_ADDONS_TIME_TIME;

  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_ADDONS_CALENDAR = record
    Menu_Position: Integer;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_ADDONS_WEATHER_TOWNS_DATA = record
    Name: String;
    Num: Integer;
    Woeid: Integer;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_ADDONS_WEATHER_YAHOO = record
    Iconset_Count: Integer;
    Iconset: String;
    Iconset_Selected: Integer;
    Iconsets: TStringList;
    Towns_Count: Integer;
    Metric: String;
    Degree: String;
    Towns: array of TDATABASE_ACTIVE_USER_LOCAL_ADDONS_WEATHER_TOWNS_DATA;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_ADDONS_WEATHER_OPENWEATHERMAP = record
    Iconset_Count: Integer;
    Iconset: String;
    Iconset_Selected: Integer;
    Metric: String;
    Degree: String;
    Towns_Count: Integer;
    API: String;
    Language: String;
    Towns: array of TDATABASE_ACTIVE_USER_LOCAL_ADDONS_WEATHER_TOWNS_DATA;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_ADDONS_WEATHER = record
    Menu_Position: Integer;
    First_Pop: Boolean;
    Old_Backup: Boolean;
    Provider_Count: Integer;
    Provider: String;
    p_Icons: String;
    p_Images: String;
    p_Sounds: String;
    p_Temp: String;
    Yahoo: TDATABASE_ACTIVE_USER_LOCAL_ADDONS_WEATHER_YAHOO;
    OpenWeatherMap: TDATABASE_ACTIVE_USER_LOCAL_ADDONS_WEATHER_OPENWEATHERMAP;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_ADDONS_SOUNDPLAYER_PLAYLIST_SONGS = record
    Name: String;
    Artist: String;
    Path_Name: String;
    Path: String;
    Audio_Type: String;
    Pos: Integer;
    Time: Integer;
    Last: ShortInt;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_ADDONS_SOUNDPLAYER_PLAYLISTS = record
    ID: Integer;
    Name: String;
    Pos_Num: Integer;
    Songs_Count: Integer;
    Active: ShortInt;
    Songs: array of TDATABASE_ACTIVE_USER_LOCAL_ADDONS_SOUNDPLAYER_PLAYLIST_SONGS;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_ADDONS_SOUNDPLAYER = record
    Menu_Position: Integer;
    First_Pop: SmallInt;
    Volume: Integer;
    Last_Visit: String;
    Last_Playlist_Num: Integer;
    Playlist_Count: Integer;
    Total_Play_Click: Integer;
    Total_Play_Time: Integer;
    p_Images: String;
    p_Sounds: String;
    Playlists: array of TDATABASE_ACTIVE_USER_LOCAL_ADDONS_SOUNDPLAYER_PLAYLISTS;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_ADDONS_AZPLAY = record
    Menu_Position: Integer;
    First_Pop: Boolean;
    Count: Integer;
    Active: Integer;
    AzHung: Boolean;
    AzMatch: Boolean;
    AzOng: Boolean;
    AzSuko: Boolean;
    AzType: Boolean;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_ADDONS = record
    Count: Integer;
    Active: Integer;
    Names: TStringList;
    Time: Boolean;
    Time_D: TDATABASE_ACTIVE_USER_LOCAL_ADDONS_TIME;
    Calendar: Boolean;
    Calendar_D: TDATABASE_ACTIVE_USER_LOCAL_ADDONS_CALENDAR;
    Weather: Boolean;
    Weather_D: TDATABASE_ACTIVE_USER_LOCAL_ADDONS_WEATHER;
    Soundplayer: Boolean;
    Soundplayer_D: TDATABASE_ACTIVE_USER_LOCAL_ADDONS_SOUNDPLAYER;
    Azplay: Boolean;
    Azplay_D: TDATABASE_ACTIVE_USER_LOCAL_ADDONS_AZPLAY;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_MEDIA = record
    Artworks: String;
    Cabinets: String;
    Control_Panels: String;
    Covers: String;
    Flyers: String;
    Fanart: String;
    Game_Over: String;
    Icons: String;
    Manuals: String;
    Marquees: String;
    Pcbs: String;
    Snapshots: String;
    Titles: String;
    Artwork_Preview: String;
    Bosses: String;
    Ends: String;
    How_To: String;
    Logos: String;
    Scores: String;
    Selects: String;
    Stamps: String;
    Versus: String;
    Warnings: String;
    Soundtracks: String;
    Support_Files: String;
    Videos: String;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_MAME = record
    Installed: Boolean;
    Active: Boolean;
    Position: Integer;
    Unique: Single;
    Path: String;
    Name: String;
    Version: String;
    Ini: String;
    View_Mode: String;
    p_Path: String;
    p_Images: String;
    p_Sounds: String;
    p_Views: String;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_FBA = record

  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_ZINC = record

  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_DAPHNE = record

  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_KRONOS = record

  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_RAINE = record

  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_MODEL2 = record

  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_SUPERMODEL = record

  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_DEMUL = record

  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE = record
    Count: Integer;
    Active: Boolean;
    Position: Integer;
    Name: String;
    p_Images: String;
    p_Videos: String;
    Media: TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_MEDIA;
    Mame: Boolean;
    Mame_D: TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_MAME;
    FBA: Boolean;
    FBA_D: TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_FBA;
    Zinc: Boolean;
    Zinc_D: TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_ZINC;
    Daphne: Boolean;
    Daphne_D: TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_DAPHNE;
    Winkawaks: Boolean;
    Kronos_D: TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_KRONOS;
    Raine: Boolean;
    Raine_D: TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_RAINE;
    Model2: Boolean;
    Model2_D: TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_MODEL2;
    SuperModel: Boolean;
    SuperModel_D: TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_SUPERMODEL;
    Demul: Boolean;
    Demul_D: TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE_DEMUL;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_COMPUTERS = record
    Count: Integer;
    Active: Boolean;
    Position: Integer;
    Name: String;
    p_Images: String;
    p_Videos: String;
    Acorn_Archimedes: Boolean;
    Amiga: Boolean;
    Amstrad: Boolean;
    Atari_8Bit: Boolean;
    Atart_ST: Boolean;
    Commodore_64: Boolean;
    MsDos: Boolean;
    PCWindows: Boolean;
    Scummvm: Boolean;
    Spectrum: Boolean;
    X68000: Boolean;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_CONSOLES = record
    Count: Integer;
    Active: Boolean;
    Position: Integer;
    Name: String;
    p_Images: String;
    p_Videos: String;
    Panasonic_3DO: Boolean;
    Amiga_CD32: Boolean;
    Atari_2600: Boolean;
    Atari_5200: Boolean;
    Atari_7800: Boolean;
    Atari_Jaguar: Boolean;
    Neo_Geo: Boolean;
    Neo_Geo_CD: Boolean;
    NES: Boolean;
    SNES: Boolean;
    Nintendo_64: Boolean;
    Gamecube: Boolean;
    Wii: Boolean;
    Wii_U: Boolean;
    Nintendo_Switch: Boolean;
    PC_Engine: Boolean;
    PC_Engine_CD: Boolean;
    PX_FX: Boolean;
    Playstation: Boolean;
    Playstation_2: Boolean;
    Playstation_3: Boolean;
    SG_1000: Boolean;
    Master_System: Boolean;
    Mega_Drive: Boolean;
    Mega_Drive_32X: Boolean;
    Mega_Drive_CD: Boolean;
    Saturn: Boolean;
    Dreamcast: Boolean;
    XBOX: Boolean;
    XBOX_ONE: Boolean;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_HANDHELDS = record
    Count: Integer;
    Active: Boolean;
    Position: Integer;
    Name: String;
    p_Images: String;
    p_Videos: String;
    Atari_Lynx: Boolean;
    Neo_Geo_Pocket: Boolean;
    GameGear: Boolean;
    Game_And_Watch: Boolean;
    Gameboy: Boolean;
    Gameboy_Color: Boolean;
    Gameboy_VirtualBoy: Boolean;
    Gameboy_Advance: Boolean;
    Nintendo_DS: Boolean;
    Nintendo_3DS: Boolean;
    PSP: Boolean;
    PSP_Vita: Boolean;
    Wonderswan: Boolean;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_PINBALLS = record
    Count: Integer;
    Active: Boolean;
    Position: Integer;
    Name: String;
    p_Images: String;
    p_Videos: String;
    Visual_Pinball: Boolean;
    Future_Pinball: Boolean;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_EMULATORS = record
    Count: Integer;
    Active_Unique: Single;
    Arcade: Boolean;
    Arcade_D: TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_ARCADE;
    Computers: Boolean;
    Computers_D: TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_COMPUTERS;
    Consoles: Boolean;
    Consoles_D: TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_CONSOLES;
    Handhelds: Boolean;
    Handhelds_D: TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_HANDHELDS;
    Pinballs: Boolean;
    Pinballs_D: TDATABASE_ACTIVE_USER_LOCAL_EMULATORS_PINBALLS;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_OPTIONS_VISUAL = record
    Virtual_Keyboard: Boolean;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_OPTIONS_GRAPHICS = record

  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_OPTIONS_SOUND = record

  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_OPTIONS_INPUT = record

  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_OPTIONS = record
    Visual: TDATABASE_ACTIVE_USER_LOCAL_OPTIONS_VISUAL;
    Graphics: TDATABASE_ACTIVE_USER_LOCAL_OPTIONS_GRAPHICS;
    Sound: TDATABASE_ACTIVE_USER_LOCAL_OPTIONS_SOUND;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_USER = record
    Num: Integer;
    Unique_ID: String;
    Username: String;
    Password: String;
    Email: String;
    IP: String;
    Country: String;
    Name: String;
    Surname: String;
    Avatar: String;
    Registered: String;
    Last_Visit: String;
    Last_Visit_Online: String;
    Genre: Boolean;
    Active: Boolean;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_MAP_KEYBOARD = record
    Name: String;
    Up: String;
    Down: String;
    Left: String;
    Right: String;
    Action: String;
    Escape: String;
    Config: String;
    Emu_Up: String;
    Emu_Down: String;
    Emu_Left: String;
    Emu_Right: String;
    Emu_Action: String;
    Emu_Escape: String;
    Emu_Favorite: String;
    Emu_FavoriteAdd: String;
    Emu_Lists: String;
    Emu_Search: String;
    Emu_Config: String;
    Emu_Filters: String;
    Emu_ScreenSaver: String;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_MAP_MOUSE = record
    Name: String;
    Buttons_Num: String;
    Dpi: String;
    Y_Up: String;
    Y_Down: String;
    X_Left: String;
    X_Right: String;
    Button_1: String;
    Button_2: String;
    Button_3: String;
    Button_4: String;
    Button_5: String;
    Button_6: String;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_MAP_JOYSTICK_GENERAL = record
    Up: String;
    Down: String;
    Left: String;
    Right: String;
    Button_1: String;
    Button_2: String;
    Button_3: String;
    Button_4: String;
    Button_5: String;
    Button_6: String;
    Button_7: String;
    Button_8: String;
    Button_9: String;
    Button_10: String;
    Button_11: String;
    Button_12: String;
    Button_13: String;
    Button_14: String;
    Button_15: String;
    Button_16: String;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_MAP_JOYSTICK_EMULATORS = record
    Up: String;
    Down: String;
    Left: String;
    Right: String;
    Button_1: String;
    Button_2: String;
    Button_3: String;
    Button_4: String;
    Button_5: String;
    Button_6: String;
    Button_7: String;
    Button_8: String;
    Button_9: String;
    Button_10: String;
    Button_11: String;
    Button_12: String;
    Button_13: String;
    Button_14: String;
    Button_15: String;
    Button_16: String;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_MAP_JOYSTICK_MMSYSTEM = record
    Name: String;
    Manufacturer: String;
    Product: String;
    Reg: String;
    OEM: String;
    Button_Num: String;
    POV: String;
    ForceBack: String;
    General: TDATABASE_ACTIVE_USER_LOCAL_MAP_JOYSTICK_GENERAL;
    Emulators: TDATABASE_ACTIVE_USER_LOCAL_MAP_JOYSTICK_EMULATORS;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_MAP_JOYSTICK_JOY_MMSYSTEM = record
    Joy_1: TDATABASE_ACTIVE_USER_LOCAL_MAP_JOYSTICK_MMSYSTEM;
    Joy_2: TDATABASE_ACTIVE_USER_LOCAL_MAP_JOYSTICK_MMSYSTEM;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_MAP_JOYSTICK_DIRECT_INPUT = record
    // General:
    // Emulators:
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_MAP_JOYSTICK_DIRECT_X = record
    // General:
    // Emulators:
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_MAP_JOYSTICK = record
    mmSystem: TDATABASE_ACTIVE_USER_LOCAL_MAP_JOYSTICK_JOY_MMSYSTEM;
    // Direct_Input: TDATABASE_ACTIVE_USER_LOCAL_MAP_JOYSTICK_JOY;
    // Dirext_X: TDATABASE_ACTIVE_USER_LOCAL_MAP_JOYSTICK_JOY;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL_MAP = record
    Keyboard: TDATABASE_ACTIVE_USER_LOCAL_MAP_KEYBOARD;
    Mouse: TDATABASE_ACTIVE_USER_LOCAL_MAP_MOUSE;
    Joystick: TDATABASE_ACTIVE_USER_LOCAL_MAP_JOYSTICK;
  end;

type
  TDATABASE_ACTIVE_USER_LOCAL = record
    USER: TDATABASE_ACTIVE_USER_LOCAL_USER;
    MAP: TDATABASE_ACTIVE_USER_LOCAL_MAP;
    OPTIONS: TDATABASE_ACTIVE_USER_LOCAL_OPTIONS;
    ADDONS: TDATABASE_ACTIVE_USER_LOCAL_ADDONS;
    Emulators: TDATABASE_ACTIVE_USER_LOCAL_EMULATORS;
  end;

procedure Get_Online_Data(vUser_ID: String);
procedure Get_Local_Data(vUser_Num: String);

function Find_User_Online_Num(vUser_ID: String): Integer;

procedure update_time;

var
  Local: TDATABASE_ACTIVE_USER_LOCAL;
  Online: TDATABASE_ACTIVE_USER_ONLINE;

implementation

uses
  load,
  uLoad,
  uLoad_AllTypes,
  uDB,
  uInternet_files;

procedure Get_Online_Data(vUser_ID: String);
var
  vQuery: String;
begin
  vQuery := 'SELECT * FROM USERS WHERE USER_ID=' + vUser_ID;
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add(vQuery);
  ExtraFE_Query.ExecSQL;
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Online.Num := ExtraFE_Query.FieldByName('NUM').AsInteger;
  Online.User_ID := ExtraFE_Query.FieldByName('USER_ID').AsString;
  Online.Username := ExtraFE_Query.FieldByName('USERNAME').AsString;
  Online.Password := ExtraFE_Query.FieldByName('PASSWORD').AsString;
  Online.Email := ExtraFE_Query.FieldByName('EMAIL').AsString;
  Online.IP := ExtraFE_Query.FieldByName('IP').AsString;
  Online.Avatar := ExtraFE_Query.FieldByName('AVATAR').AsInteger;
  Online.Country := ExtraFE_Query.FieldByName('COUNTRY').AsString;
  Online.Name := ExtraFE_Query.FieldByName('NAME').AsString;
  Online.Surname := ExtraFE_Query.FieldByName('SURNAME').AsString;
  Online.Registered := ExtraFE_Query.FieldByName('REGISTERED').AsString;
  Online.Last_Visit := ExtraFE_Query.FieldByName('LAST_VISIT').AsString;
  Online.Genre := ExtraFE_Query.FieldByName('GENDER').AsInteger;
  Online.Active := ExtraFE_Query.FieldByName('ACTIVE').AsInteger;
end;

procedure Get_Local_Data(vUser_Num: String);
var
  vQuery: String;
begin
  vQuery := 'SELECT * FROM USERS WHERE USER_ID=' + vUser_Num;
  uDB.ExtraFE_Query_Local.Close;
  uDB.ExtraFE_Query_Local.SQL.Clear;
  uDB.ExtraFE_Query_Local.SQL.Add(vQuery);
  uDB.ExtraFE_Query_Local.Open;
  uDB.ExtraFE_Query_Local.First;
  Local.USER.Num := uDB.ExtraFE_Query_Local.FieldByName('USER_ID').AsInteger;
  Local.USER.Unique_ID := uDB.ExtraFE_Query_Local.FieldByName('UNIQUE_ID').AsString;
  Local.USER.Username := uDB.ExtraFE_Query_Local.FieldByName('USERNAME').AsString;
  Local.USER.Password := uDB.ExtraFE_Query_Local.FieldByName('PASSWORD').AsString;
  Local.USER.Email := uDB.ExtraFE_Query_Local.FieldByName('EMAIL').AsString;
  Local.USER.IP := uDB.ExtraFE_Query_Local.FieldByName('IP').AsString;
  Local.USER.Country := uDB.ExtraFE_Query_Local.FieldByName('COUNTRY').AsString;
  Local.USER.Name := uDB.ExtraFE_Query_Local.FieldByName('NAME').AsString;
  Local.USER.Surname := uDB.ExtraFE_Query_Local.FieldByName('SURNAME').AsString;
  Local.USER.Avatar := uDB.ExtraFE_Query_Local.FieldByName('AVATAR').AsString;
  Local.USER.Registered := uDB.ExtraFE_Query_Local.FieldByName('REGISTERED').AsString;
  Local.USER.Last_Visit := uDB.ExtraFE_Query_Local.FieldByName('LAST_VISIT').AsString;
  Local.USER.Last_Visit_Online := uDB.ExtraFE_Query_Local.FieldByName('LAST_VISIT_ONLINE').AsString;
  Local.USER.Genre := uDB.ExtraFE_Query_Local.FieldByName('GENDER').AsBoolean;
  Local.USER.Active := uDB.ExtraFE_Query_Local.FieldByName('ACTIVE_ONLINE').AsBoolean;

  { GENERAL }
  vQuery := 'SELECT * FROM OPTIONS WHERE USER_ID=' + vUser_Num;
  uDB.ExtraFE_Query_Local.Close;
  uDB.ExtraFE_Query_Local.SQL.Clear;
  uDB.ExtraFE_Query_Local.SQL.Add(vQuery);
  uDB.ExtraFE_Query_Local.Open;
  uDB.ExtraFE_Query_Local.First;
  Local.OPTIONS.Visual.Virtual_Keyboard := uDB.ExtraFE_Query_Local.FieldByName('VIRTUAL_KEYBOARD').AsBoolean;

  vQuery := 'SELECT * FROM map_keyboard WHERE user_id=' + vUser_Num;
  uDB.ExtraFE_Query_Local.Close;
  uDB.ExtraFE_Query_Local.SQL.Clear;
  uDB.ExtraFE_Query_Local.SQL.Add(vQuery);
  uDB.ExtraFE_Query_Local.Open;
  uDB.ExtraFE_Query_Local.First;

  Local.MAP.Keyboard.Up := uDB.ExtraFE_Query_Local.FieldByName('main_up').AsString;
  Local.MAP.Keyboard.Down := uDB.ExtraFE_Query_Local.FieldByName('main_down').AsString;
  Local.MAP.Keyboard.Left := uDB.ExtraFE_Query_Local.FieldByName('main_left').AsString;
  Local.MAP.Keyboard.Right := uDB.ExtraFE_Query_Local.FieldByName('main_right').AsString;
  Local.MAP.Keyboard.Action := uDB.ExtraFE_Query_Local.FieldByName('main_action').AsString;
  Local.MAP.Keyboard.Escape := uDB.ExtraFE_Query_Local.FieldByName('main_escape').AsString;
  Local.MAP.Keyboard.Config := uDB.ExtraFE_Query_Local.FieldByName('main_config').AsString;
  Local.MAP.Keyboard.Emu_Up := uDB.ExtraFE_Query_Local.FieldByName('emu_up').AsString;
  Local.MAP.Keyboard.Emu_Down := uDB.ExtraFE_Query_Local.FieldByName('emu_down').AsString;
  Local.MAP.Keyboard.Emu_Left := uDB.ExtraFE_Query_Local.FieldByName('emu_left').AsString;
  Local.MAP.Keyboard.Emu_Right := uDB.ExtraFE_Query_Local.FieldByName('emu_right').AsString;
  Local.MAP.Keyboard.Emu_Action := uDB.ExtraFE_Query_Local.FieldByName('emu_action').AsString;
  Local.MAP.Keyboard.Emu_Escape := uDB.ExtraFE_Query_Local.FieldByName('emu_escape').AsString;
  Local.MAP.Keyboard.Emu_Favorite := uDB.ExtraFE_Query_Local.FieldByName('emu_fav').AsString;
  Local.MAP.Keyboard.Emu_FavoriteAdd := uDB.ExtraFE_Query_Local.FieldByName('emu_addfav').AsString;
  Local.MAP.Keyboard.Emu_Filters := uDB.ExtraFE_Query_Local.FieldByName('emu_filters').AsString;
  Local.MAP.Keyboard.Emu_Lists := uDB.ExtraFE_Query_Local.FieldByName('emu_lists').AsString;
  Local.MAP.Keyboard.Emu_Search := uDB.ExtraFE_Query_Local.FieldByName('emu_search').AsString;
  Local.MAP.Keyboard.Emu_Config := uDB.ExtraFE_Query_Local.FieldByName('emu_config').AsString;
  Local.MAP.Keyboard.Emu_ScreenSaver := uDB.ExtraFE_Query_Local.FieldByName('emu_screensaver').AsString;

  { EMULATORS }
  vQuery := 'SELECT * FROM EMULATORS WHERE USER_ID=' + vUser_Num;
  uDB.ExtraFE_Query_Local.Close;
  uDB.ExtraFE_Query_Local.SQL.Clear;
  uDB.ExtraFE_Query_Local.SQL.Add(vQuery);
  uDB.ExtraFE_Query_Local.Open;
  uDB.ExtraFE_Query_Local.First;
  Local.Emulators.Count := uDB.ExtraFE_Query_Local.FieldByName('COUNT').AsInteger;
  Local.Emulators.Active_Unique := uDB.ExtraFE_Query_Local.FieldByName('ACTIVE_UNIQUE').AsSingle;
  Local.Emulators.Arcade := uDB.ExtraFE_Query_Local.FieldByName('ARCADE').AsBoolean;
  Local.Emulators.Computers := uDB.ExtraFE_Query_Local.FieldByName('COMPUTERS').AsBoolean;
  Local.Emulators.Consoles := uDB.ExtraFE_Query_Local.FieldByName('CONSOLES').AsBoolean;
  Local.Emulators.Handhelds := uDB.ExtraFE_Query_Local.FieldByName('HANDHELDS').AsBoolean;
  Local.Emulators.Pinballs := uDB.ExtraFE_Query_Local.FieldByName('PINBALLS').AsBoolean;

  vQuery := 'SELECT * FROM ARCADE WHERE USER_ID=' + vUser_Num;
  uDB.ExtraFE_Query_Local.Close;
  uDB.ExtraFE_Query_Local.SQL.Clear;
  uDB.ExtraFE_Query_Local.SQL.Add(vQuery);
  uDB.ExtraFE_Query_Local.Open;
  uDB.ExtraFE_Query_Local.First;
  Local.Emulators.Arcade_D.Count := uDB.ExtraFE_Query_Local.FieldByName('COUNT').AsInteger;
  Local.Emulators.Arcade_D.Active := uDB.ExtraFE_Query_Local.FieldByName('ACTIVE').AsBoolean;
  Local.Emulators.Arcade_D.Position := uDB.ExtraFE_Query_Local.FieldByName('POSITION').AsInteger;
  Local.Emulators.Arcade_D.Name := uDB.ExtraFE_Query_Local.FieldByName('NAME').AsString;
  Local.Emulators.Arcade_D.p_Images := uDB.ExtraFE_Query_Local.FieldByName('PATH_IMAGES').AsString;
  Local.Emulators.Arcade_D.Mame := uDB.ExtraFE_Query_Local.FieldByName('MAME').AsBoolean;
  Local.Emulators.Arcade_D.FBA := uDB.ExtraFE_Query_Local.FieldByName('FBA').AsBoolean;
  Local.Emulators.Arcade_D.Zinc := uDB.ExtraFE_Query_Local.FieldByName('ZINC').AsBoolean;
  Local.Emulators.Arcade_D.Daphne := uDB.ExtraFE_Query_Local.FieldByName('DAPHNE').AsBoolean;
  Local.Emulators.Arcade_D.Winkawaks := uDB.ExtraFE_Query_Local.FieldByName('WINKAWAKS').AsBoolean;
  Local.Emulators.Arcade_D.Raine := uDB.ExtraFE_Query_Local.FieldByName('RAINE').AsBoolean;
  Local.Emulators.Arcade_D.Model2 := uDB.ExtraFE_Query_Local.FieldByName('MODEL2').AsBoolean;
  Local.Emulators.Arcade_D.SuperModel := uDB.ExtraFE_Query_Local.FieldByName('SUPERMODEL').AsBoolean;
  Local.Emulators.Arcade_D.Demul := uDB.ExtraFE_Query_Local.FieldByName('DEMUL').AsBoolean;

  if Local.Emulators.Arcade_D.p_Images = '' then
  begin
    Local.Emulators.Arcade_D.p_Images := extrafe.prog.Path + 'emu\arcade\images\';
    uDB.Query_Update(uDB.ExtraFE_Query_Local, 'arcade', 'PATH_IMAGES', Local.Emulators.Arcade_D.p_Images, 'USER_ID', uDB_AUser.Local.USER.Num.ToString);
  end;

  if Local.Emulators.Arcade_D.p_Videos = '' then
  begin
    Local.Emulators.Arcade_D.p_Videos := extrafe.prog.Path + 'emu\arcade\videos\';
    uDB.Query_Update(uDB.ExtraFE_Query_Local, 'arcade', 'PATH_VIDEOS', Local.Emulators.Arcade_D.p_Videos, 'USER_ID', uDB_AUser.Local.USER.Num.ToString);
  end;

  vQuery := 'SELECT * FROM COMPUTERS WHERE USER_ID=' + vUser_Num;
  uDB.ExtraFE_Query_Local.Close;
  uDB.ExtraFE_Query_Local.SQL.Clear;
  uDB.ExtraFE_Query_Local.SQL.Add(vQuery);
  uDB.ExtraFE_Query_Local.Open;
  uDB.ExtraFE_Query_Local.First;
  Local.Emulators.Computers_D.Count := uDB.ExtraFE_Query_Local.FieldByName('COUNT').AsInteger;
  Local.Emulators.Computers_D.Active := uDB.ExtraFE_Query_Local.FieldByName('ACTIVE').AsBoolean;
  Local.Emulators.Computers_D.Position := uDB.ExtraFE_Query_Local.FieldByName('POSITION').AsInteger;
  Local.Emulators.Computers_D.Name := uDB.ExtraFE_Query_Local.FieldByName('NAME').AsString;
  Local.Emulators.Computers_D.p_Images := uDB.ExtraFE_Query_Local.FieldByName('PATH_IMAGES').AsString;
  Local.Emulators.Computers_D.Acorn_Archimedes := uDB.ExtraFE_Query_Local.FieldByName('ACORN_ARCHIMEDES').AsBoolean;
  Local.Emulators.Computers_D.Amiga := uDB.ExtraFE_Query_Local.FieldByName('AMIGA').AsBoolean;
  Local.Emulators.Computers_D.Amstrad := uDB.ExtraFE_Query_Local.FieldByName('AMSTRAD').AsBoolean;
  Local.Emulators.Computers_D.Atari_8Bit := uDB.ExtraFE_Query_Local.FieldByName('ATARI_8BIT').AsBoolean;
  Local.Emulators.Computers_D.Atart_ST := uDB.ExtraFE_Query_Local.FieldByName('ATARI_ST').AsBoolean;
  Local.Emulators.Computers_D.Commodore_64 := uDB.ExtraFE_Query_Local.FieldByName('COMMODORE_64').AsBoolean;
  Local.Emulators.Computers_D.MsDos := uDB.ExtraFE_Query_Local.FieldByName('MSDOS').AsBoolean;
  Local.Emulators.Computers_D.PCWindows := uDB.ExtraFE_Query_Local.FieldByName('OLD_PC_WINDOWS').AsBoolean;
  Local.Emulators.Computers_D.Scummvm := uDB.ExtraFE_Query_Local.FieldByName('SCUMMVM').AsBoolean;
  Local.Emulators.Computers_D.Spectrum := uDB.ExtraFE_Query_Local.FieldByName('SPECTRUM').AsBoolean;
  Local.Emulators.Computers_D.X68000 := uDB.ExtraFE_Query_Local.FieldByName('X68000').AsBoolean;

  if Local.Emulators.Computers_D.p_Images = '' then
  begin
    Local.Emulators.Computers_D.p_Images := extrafe.prog.Path + 'emu\computers\images\';
    uDB.Query_Update(uDB.ExtraFE_Query_Local, 'computers', 'PATH_IMAGES', Local.Emulators.Computers_D.p_Images, 'USER_ID', uDB_AUser.Local.USER.Num.ToString);
  end;

  vQuery := 'SELECT * FROM CONSOLES WHERE USER_ID=' + vUser_Num;
  uDB.ExtraFE_Query_Local.Close;
  uDB.ExtraFE_Query_Local.SQL.Clear;
  uDB.ExtraFE_Query_Local.SQL.Add(vQuery);
  uDB.ExtraFE_Query_Local.Open;
  uDB.ExtraFE_Query_Local.First;
  Local.Emulators.Consoles_D.Count := uDB.ExtraFE_Query_Local.FieldByName('COUNT').AsInteger;
  Local.Emulators.Consoles_D.Active := uDB.ExtraFE_Query_Local.FieldByName('ACTIVE').AsBoolean;
  Local.Emulators.Consoles_D.Position := uDB.ExtraFE_Query_Local.FieldByName('POSITION').AsInteger;
  Local.Emulators.Consoles_D.Name := uDB.ExtraFE_Query_Local.FieldByName('NAME').AsString;
  Local.Emulators.Consoles_D.p_Images := uDB.ExtraFE_Query_Local.FieldByName('PATH_IMAGES').AsString;
  Local.Emulators.Consoles_D.Panasonic_3DO := uDB.ExtraFE_Query_Local.FieldByName('3DO').AsBoolean;
  Local.Emulators.Consoles_D.Amiga_CD32 := uDB.ExtraFE_Query_Local.FieldByName('AMIGA_CD32').AsBoolean;
  Local.Emulators.Consoles_D.Atari_2600 := uDB.ExtraFE_Query_Local.FieldByName('ATARI_2600').AsBoolean;
  Local.Emulators.Consoles_D.Atari_5200 := uDB.ExtraFE_Query_Local.FieldByName('ATARI_5200').AsBoolean;
  Local.Emulators.Consoles_D.Atari_7800 := uDB.ExtraFE_Query_Local.FieldByName('ATARI_7800').AsBoolean;
  Local.Emulators.Consoles_D.Atari_Jaguar := uDB.ExtraFE_Query_Local.FieldByName('ATARI_JAGUAR').AsBoolean;
  Local.Emulators.Consoles_D.Neo_Geo := uDB.ExtraFE_Query_Local.FieldByName('NEO_GEO').AsBoolean;
  Local.Emulators.Consoles_D.Neo_Geo_CD := uDB.ExtraFE_Query_Local.FieldByName('NEO_GEO_CD').AsBoolean;
  Local.Emulators.Consoles_D.NES := uDB.ExtraFE_Query_Local.FieldByName('NES').AsBoolean;
  Local.Emulators.Consoles_D.SNES := uDB.ExtraFE_Query_Local.FieldByName('SNES').AsBoolean;
  Local.Emulators.Consoles_D.Nintendo_64 := uDB.ExtraFE_Query_Local.FieldByName('NINTENDO_64').AsBoolean;
  Local.Emulators.Consoles_D.Gamecube := uDB.ExtraFE_Query_Local.FieldByName('GAMECUBE').AsBoolean;
  Local.Emulators.Consoles_D.Wii := uDB.ExtraFE_Query_Local.FieldByName('WII').AsBoolean;
  Local.Emulators.Consoles_D.Wii_U := uDB.ExtraFE_Query_Local.FieldByName('WII_U').AsBoolean;
  Local.Emulators.Consoles_D.Nintendo_Switch := uDB.ExtraFE_Query_Local.FieldByName('NINTENDO_SWITCH').AsBoolean;
  Local.Emulators.Consoles_D.PC_Engine := uDB.ExtraFE_Query_Local.FieldByName('PC_ENGINE').AsBoolean;
  Local.Emulators.Consoles_D.PC_Engine_CD := uDB.ExtraFE_Query_Local.FieldByName('PC_ENGINE_CD').AsBoolean;
  Local.Emulators.Consoles_D.PX_FX := uDB.ExtraFE_Query_Local.FieldByName('PC_FX').AsBoolean;
  Local.Emulators.Consoles_D.Playstation := uDB.ExtraFE_Query_Local.FieldByName('PLAYSTATION').AsBoolean;
  Local.Emulators.Consoles_D.Playstation_2 := uDB.ExtraFE_Query_Local.FieldByName('PLAYSTATION_2').AsBoolean;
  Local.Emulators.Consoles_D.Playstation_3 := uDB.ExtraFE_Query_Local.FieldByName('PLAYSTATION_3').AsBoolean;
  Local.Emulators.Consoles_D.SG_1000 := uDB.ExtraFE_Query_Local.FieldByName('SG_1000').AsBoolean;
  Local.Emulators.Consoles_D.Master_System := uDB.ExtraFE_Query_Local.FieldByName('MASTER_SYSTEM').AsBoolean;
  Local.Emulators.Consoles_D.Mega_Drive := uDB.ExtraFE_Query_Local.FieldByName('MEGA_DRIVE').AsBoolean;
  Local.Emulators.Consoles_D.Mega_Drive_32X := uDB.ExtraFE_Query_Local.FieldByName('MEGA_DRIVE_32X').AsBoolean;
  Local.Emulators.Consoles_D.Mega_Drive_CD := uDB.ExtraFE_Query_Local.FieldByName('MEGA_DRIVE_CD').AsBoolean;
  Local.Emulators.Consoles_D.Saturn := uDB.ExtraFE_Query_Local.FieldByName('SATURN').AsBoolean;
  Local.Emulators.Consoles_D.Dreamcast := uDB.ExtraFE_Query_Local.FieldByName('DREAMCAST').AsBoolean;
  Local.Emulators.Consoles_D.XBOX := uDB.ExtraFE_Query_Local.FieldByName('XBOX').AsBoolean;
  Local.Emulators.Consoles_D.XBOX_ONE := uDB.ExtraFE_Query_Local.FieldByName('XBOX_ONE').AsBoolean;

  if Local.Emulators.Consoles_D.p_Images = '' then
  begin
    Local.Emulators.Consoles_D.p_Images := extrafe.prog.Path + 'emu\consoles\images\';
    uDB.Query_Update(uDB.ExtraFE_Query_Local, 'consoles', 'PATH_IMAGES', Local.Emulators.Consoles_D.p_Images, 'USER_ID', uDB_AUser.Local.USER.Num.ToString);
  end;

  vQuery := 'SELECT * FROM HANDHELDS WHERE USER_ID=' + vUser_Num;
  uDB.ExtraFE_Query_Local.Close;
  uDB.ExtraFE_Query_Local.SQL.Clear;
  uDB.ExtraFE_Query_Local.SQL.Add(vQuery);
  uDB.ExtraFE_Query_Local.Open;
  uDB.ExtraFE_Query_Local.First;
  Local.Emulators.Handhelds_D.Count := uDB.ExtraFE_Query_Local.FieldByName('COUNT').AsInteger;
  Local.Emulators.Handhelds_D.Active := uDB.ExtraFE_Query_Local.FieldByName('ACTIVE').AsBoolean;
  Local.Emulators.Handhelds_D.Position := uDB.ExtraFE_Query_Local.FieldByName('POSITION').AsInteger;
  Local.Emulators.Handhelds_D.Name := uDB.ExtraFE_Query_Local.FieldByName('NAME').AsString;
  Local.Emulators.Handhelds_D.p_Images := uDB.ExtraFE_Query_Local.FieldByName('PATH_IMAGES').AsString;
  Local.Emulators.Handhelds_D.Atari_Lynx := uDB.ExtraFE_Query_Local.FieldByName('ATARI_LYNX').AsBoolean;
  Local.Emulators.Handhelds_D.Neo_Geo_Pocket := uDB.ExtraFE_Query_Local.FieldByName('NEO_GEO_POCKET').AsBoolean;
  Local.Emulators.Handhelds_D.GameGear := uDB.ExtraFE_Query_Local.FieldByName('GAMEGEAR').AsBoolean;
  Local.Emulators.Handhelds_D.Game_And_Watch := uDB.ExtraFE_Query_Local.FieldByName('GAME_AND_WATCH').AsBoolean;
  Local.Emulators.Handhelds_D.Gameboy := uDB.ExtraFE_Query_Local.FieldByName('GAMEBOY').AsBoolean;
  Local.Emulators.Handhelds_D.Gameboy_Color := uDB.ExtraFE_Query_Local.FieldByName('GAMEBOY_COLOR').AsBoolean;
  Local.Emulators.Handhelds_D.Gameboy_VirtualBoy := uDB.ExtraFE_Query_Local.FieldByName('GAMEBOY_VIRTUALBOY').AsBoolean;
  Local.Emulators.Handhelds_D.Gameboy_Advance := uDB.ExtraFE_Query_Local.FieldByName('GAMEBOY_ADVANCE').AsBoolean;
  Local.Emulators.Handhelds_D.Nintendo_DS := uDB.ExtraFE_Query_Local.FieldByName('NINTENDO_DS').AsBoolean;
  Local.Emulators.Handhelds_D.Nintendo_3DS := uDB.ExtraFE_Query_Local.FieldByName('NINTENDO_3DS').AsBoolean;
  Local.Emulators.Handhelds_D.PSP := uDB.ExtraFE_Query_Local.FieldByName('PSP').AsBoolean;
  Local.Emulators.Handhelds_D.PSP_Vita := uDB.ExtraFE_Query_Local.FieldByName('PSP_VITA').AsBoolean;
  Local.Emulators.Handhelds_D.Wonderswan := uDB.ExtraFE_Query_Local.FieldByName('WONDERSWAN').AsBoolean;

  if Local.Emulators.Handhelds_D.p_Images = '' then
  begin
    Local.Emulators.Handhelds_D.p_Images := extrafe.prog.Path + 'emu\handhelds\images\';
    uDB.Query_Update(uDB.ExtraFE_Query_Local, 'handhelds', 'PATH_IMAGES', Local.Emulators.Handhelds_D.p_Images, 'USER_ID', uDB_AUser.Local.USER.Num.ToString);
  end;

  vQuery := 'SELECT * FROM PINBALLS WHERE USER_ID=' + vUser_Num;
  uDB.ExtraFE_Query_Local.Close;
  uDB.ExtraFE_Query_Local.SQL.Clear;
  uDB.ExtraFE_Query_Local.SQL.Add(vQuery);
  uDB.ExtraFE_Query_Local.Open;
  uDB.ExtraFE_Query_Local.First;
  Local.Emulators.Pinballs_D.Count := uDB.ExtraFE_Query_Local.FieldByName('COUNT').AsInteger;
  Local.Emulators.Pinballs_D.Active := uDB.ExtraFE_Query_Local.FieldByName('ACTIVE').AsBoolean;
  Local.Emulators.Pinballs_D.Position := uDB.ExtraFE_Query_Local.FieldByName('POSITION').AsInteger;
  Local.Emulators.Pinballs_D.Name := uDB.ExtraFE_Query_Local.FieldByName('NAME').AsString;
  Local.Emulators.Pinballs_D.p_Images := uDB.ExtraFE_Query_Local.FieldByName('PATH_IMAGES').AsString;
  Local.Emulators.Pinballs_D.Visual_Pinball := uDB.ExtraFE_Query_Local.FieldByName('VISUAL_PINBALL').AsBoolean;
  Local.Emulators.Pinballs_D.Future_Pinball := uDB.ExtraFE_Query_Local.FieldByName('FUTURE_PINBALL').AsBoolean;

  if Local.Emulators.Pinballs_D.p_Images = '' then
  begin
    Local.Emulators.Pinballs_D.p_Images := extrafe.prog.Path + 'emu\pinball\images\';
    uDB.Query_Update(uDB.ExtraFE_Query_Local, 'pinballs', 'PATH_IMAGES', Local.Emulators.Pinballs_D.p_Images, 'USER_ID', uDB_AUser.Local.USER.Num.ToString);
  end;

  vQuery := 'SELECT * FROM ADDONS WHERE USER_ID=' + vUser_Num;
  uDB.ExtraFE_Query_Local.Close;
  uDB.ExtraFE_Query_Local.SQL.Clear;
  uDB.ExtraFE_Query_Local.SQL.Add(vQuery);
  uDB.ExtraFE_Query_Local.Open;
  uDB.ExtraFE_Query_Local.First;
  Local.ADDONS.Active := uDB.ExtraFE_Query_Local.FieldByName('ACTIVE').AsInteger;
  Local.ADDONS.Count := uDB.ExtraFE_Query_Local.FieldByName('COUNT').AsInteger;
  Local.ADDONS.Time := uDB.ExtraFE_Query_Local.FieldByName('TIME').AsBoolean;
  Local.ADDONS.Calendar := uDB.ExtraFE_Query_Local.FieldByName('CALENDAR').AsBoolean;
  Local.ADDONS.Weather := uDB.ExtraFE_Query_Local.FieldByName('WEATHER').AsBoolean;
  Local.ADDONS.Soundplayer := uDB.ExtraFE_Query_Local.FieldByName('SOUNDPLAYER').AsBoolean;
  Local.ADDONS.Azplay := uDB.ExtraFE_Query_Local.FieldByName('AZPLAY').AsBoolean;
end;

function Find_User_Online_Num(vUser_ID: String): Integer;
begin
  ExtraFE_Query.Close;
  ExtraFE_Query.SQL.Clear;
  ExtraFE_Query.SQL.Add('SELECT * FROM USERS WHERE USER_ID=' + vUser_ID);
  ExtraFE_Query.ExecSQL;
  ExtraFE_Query.Open;
  ExtraFE_Query.First;
  Result := ExtraFE_Query.FieldByName('NUM').AsInteger;
end;

procedure update_time;
var
  vCurFinal: String;
  vIP: TJsonValue;
  vIP_Value: String;
begin
  vCurFinal := FormatDateTime('dd/mm/yyyy  hh:mm:ss ampm', now);

  vIP := uInternet_files.JSONValue('Register_IP_', 'http://ipinfo.io/json', TRESTRequestMethod.rmGET);
  vIP_Value := vIP.GetValue<String>('ip');
  uDB.Query_Update_Online('USERS', 'IP', vIP_Value, Online.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'users', 'IP', vIP_Value, 'USER_ID', uDB_AUser.Local.USER.Num.ToString);
  Local.USER.IP := vIP_Value;
  Online.IP := vIP_Value;
  uDB.Query_Update_Online('USERS', 'LAST_VISIT', vCurFinal, Online.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'users', 'LAST_VISIT', vCurFinal, 'USER_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'users', 'LAST_VISIT_ONLINE', vCurFinal, 'USER_ID', uDB_AUser.Local.USER.Num.ToString);
end;

end.
