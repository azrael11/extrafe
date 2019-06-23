unit uWeather_AllTypes;

interface

uses
  System.Classes,
  System.IniFiles,
  FMX.Objects,
  FMX.Ani,
  FMX.Layouts,
  FMX.Effects,
  FMX.Filter.Effects,
  FMX.StdCtrls,
  FMX.Edit,
  FMX.Grid,
  FMX.ImgList,
  FMX.Controls,
  FMX.Graphics,
  FMX.Types,
  ALFmxTabControl,
  ALFmxObjects,
  uWeather_Mouse,
  uWeather_Config_Mouse,
  Radiant.Shapes,
  Bass;

type
  TADDON_WEATHER_MAINTIMER = class(TObject)
    procedure OnTimer(Sender: TObject);
  end;

type
  TADDON_WEATHER_PATHS = record
    Icon: String;
    Images: String;
    Iconsets: String;
    Sounds: String;
    Temp: String;
  end;

type
  TADDON_WEATHER_CONFIG = record
    Ini: TIniFile;
    Name: String;
    Path: String;
  end;

type
  TADDON_WEATHER_CHOOSENTOWN_UNIT = record
    Temperature: WideString;
    Speed: WideString;
    Pressure: WideString;
    Distance: WideString;
  end;

type
  TADDON_WEATHER_CHOOSENTOWN_WIND = record
    Speed: WideString;
    Direction: WideString;
    Chill: WideString;
  end;

type
  TADDON_WEATHER_CHOOSENTOWN_ATMOSPHERE = record
    Pressure: WideString;
    Visibility: WideString;
    Rising: WideString;
    Humidity: WideString;
  end;

type
  TADDON_WEATHER_CHOOSENTOWN_ASTRONOMY = record
    Sunset: WideString;
    Sunrise: WideString;
  end;

type
  TADDON_WEATHER_CHOOSENTOWN_DAY = record
    Text: WideString;
    Date: WideString;
    Forcast: WideString;
    Code: WideString;
    Low: WideString;
    High: WideString;
  end;

type
  TADDON_WEATHER_CONFIG_CREATE_PANEL = record
    Temp: String;
    Temp_Unit: String;
    Temp_Icon: String;
    Temp_Description: String;
    City_Name: String;
    Country_Name: String;
    Country_Flag: String;
    Last_Checked: String;
  end;

type
  TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP_DAYS_HOUR = record
    Time: String;
    Temp: String;
    Temp_Min: String;
    Temp_Max: String;
    Pressure: String;
    Pressure_Sea: String;
    Pressure_Ground: String;
    Humidity: String;
    Weather_ID: String;
    Weather_Main: String;
    Weather_Desc: String;
    Wetaher_Icon: String;
    Clouds: String;
    Wind_Speed: String;
    Wind_Direction: String;
    Rain_3H: String;
    Snow_3H: String;
    Last_Checked: String;
  end;

type
  TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP_DAYS = record
    City_ID: String;
    City_Name: String;
    Longitude: String;
    Latitude: String;
    Country: String;
    Count: String;
    Hour: array of TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP_DAYS_HOUR;
  end;

type
  TADDON_WEATHER_CHOOSENTOWN_OPENWEATHERMAP = record
    Provider: WideString;
    WoeID: WideString;
    Longitude: String;
    Latitude: String;
    Weather_ID: String;
    Weather_Main: String;
    Weather_Desc: String;
    Weather_Icon: String;
    Weather_Build_Icon: String;
    Temp: String;
    Temp_Unit: String;
    Pressure: String;
    Pressure_Sea: String;
    Pressure_Ground: String;
    Humidity: String;
    Now_Temp_Max: String;
    Now_Temp_Min: String;
    Visibility: String;
    Wind_Speed: String;
    Wind_Direction: String;
    Clounds: String;
    Rain_1H: String;
    Rain_3H: String;
    Snow_1H: String;
    Snow_3H: String;
    Last_Checked: String;
    Sunrise: String;
    Sunset: String;
    City: WideString;
    Country_FlagCode: string;
    Country: String;
  end;

type
  TADDON_WEATHER_PROVIDER_YAHOO2_DATATOWN = record
    WoeID: WideString;
    vUnit: WideString;
    City: WideString;
    Country: WideString;
    Country_FlagCode: string;
    Temp_Condition: WideString;
    Text_Condtition: WideString;
    Code: WideString;
    LastChecked: WideString;
    LastUpdate: WideString;
    UnitV: TADDON_WEATHER_CHOOSENTOWN_UNIT;
    Wind: TADDON_WEATHER_CHOOSENTOWN_WIND;
    Atmosphere: TADDON_WEATHER_CHOOSENTOWN_ATMOSPHERE;
    Astronomy: TADDON_WEATHER_CHOOSENTOWN_ASTRONOMY;
    Current: TADDON_WEATHER_CHOOSENTOWN_DAY;
    Day_1: TADDON_WEATHER_CHOOSENTOWN_DAY;
    Day_2: TADDON_WEATHER_CHOOSENTOWN_DAY;
    Day_3: TADDON_WEATHER_CHOOSENTOWN_DAY;
    Day_4: TADDON_WEATHER_CHOOSENTOWN_DAY;
    Day_5: TADDON_WEATHER_CHOOSENTOWN_DAY;
    Day_6: TADDON_WEATHER_CHOOSENTOWN_DAY;
    Day_7: TADDON_WEATHER_CHOOSENTOWN_DAY;
    Day_8: TADDON_WEATHER_CHOOSENTOWN_DAY;
    Day_9: TADDON_WEATHER_CHOOSENTOWN_DAY;
  end;

  /// /Yahoo Weather Vars

type
  TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_LOCATION = record
    WoeID: WideString;
    Photo_WoeID: WideString;
    Country_Name: WideString;
    City_Name: WideString;
    Latitude: WideString;
    Longitude: WideString;
    OffSetSecs: WideString;
  end;

type
  TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_TIME = record
    Day: WideString;
    Hour: WideString;
    WeekDay: WideString;
    TimeStamp: WideString;
  end;

type
  TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_DAYPART = record
    Desc: WideString;
    Part: WideString;
  end;

type
  TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_OBSERVATION_TEMPRETURE = record
    Now: WideString;
    Now_Metric: String;
    High: WideString;
    High_Metric: String;
    Low: WideString;
    Low_Metric: String;
    FeelsLike: WideString;
    FeelsLike_Metric: String;
  end;

type
  TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_OBSERVATION = record
    BarometricPressure: String;
    BarometricPressure_Metric: String;
    ConditionCode: WideString;
    ConditionDescription: WideString;
    Day_Part: array [0 .. 1] of TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_DAYPART;
    Tempreture: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_OBSERVATION_TEMPRETURE;
    Time: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_TIME;
    Humidity: WideString;
    PrecipitationProbability: WideString;
    UVDescription: WideString;
    UVIndex: WideString;
    Visibility: String;
    Visibility_Metric: String;
    WindDirection: WideString;
    WindDirectionCode: WideString;
    WindSpeed: String;
    WindSpeed_Metric: String;
    LocalTime: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_TIME;
  end;

type
  TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_FORCASTS_HOURLY_TEMPERATURE = record
    Now: WideString;
    Now_Metric: String;
    FeelsLike: WideString;
    FeelsLike_Metric: String;
  end;

type
  TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_FORCASTS_HOURLY = record
    ConditionCode: WideString;
    ConditionDescription: WideString;
    Temperature: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_FORCASTS_HOURLY_TEMPERATURE;
    Time: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_TIME;
    Humidity: WideString;
    PrecipitationProbability: WideString;
    WindDirection: String;
    WindDirectionCode: WideString;
    WindSpeed: WideString;
    WindSpeed_Metric: String;
    LocalTime: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_TIME;
  end;

type
  TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_FORCASTS_DAILY_TEMPERATURE = record
    High: WideString;
    High_Metric: String;
    Low: WideString;
    Low_Metric: String;
  end;

type
  TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_FORCASTS_DAILY = record
    ConditionCode: WideString;
    ConditionDescription: WideString;
    Parts: array [0 .. 1] of TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_DAYPART;
    Temperature: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_FORCASTS_DAILY_TEMPERATURE;
    Time: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_TIME;
    Humidity: WideString;
    PrecipitationProbability: WideString;
    LocalTime: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_TIME;
  end;

type
  TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_FORCASTS = record
    Hourly: array [0 .. 24] of TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_FORCASTS_HOURLY;
    Daily: array [0 .. 10] of TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_FORCASTS_DAILY;
  end;

type
  TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_PRECIPITATIONs = record
    TimeSlot: WideString;
    Probability: WideString;
  end;

type
  TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_SUNANDMOON = record
    Sunrise: WideString;
    Sunset: WideString;
    MoonPhase: WideString;
  end;

type
  TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_PHOTOS_RESOLUTIONS = record
    Height: WideString;
    Width: WideString;
    URL: WideString;
  end;

type
  TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_PHOTOS = record
    ID: WideString;
    DayOrNight: WideString;
    Owner: WideString;
    OwnerName: WideString;
    Picture_Used_Num: Integer;
    resolutions: array [0 .. 5] of TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_PHOTOS_RESOLUTIONS;
  end;

type
  TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_PROVIDER = record
    Name: WideString;
  end;

type
  TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_META_DATA = record
    Number: WideString;
    Text: WideString;
  end;

type
  TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_META = record
    Skycode: array [0 .. 255] of TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_META_DATA;
    ConditionMap: array [0 .. 255] of TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_META_DATA;
  end;

type
  TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN = record
    WoeID: WideString;
    vUnit: WideString;
    Location: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_LOCATION;
    Observation: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_OBSERVATION;
    Forcasts: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_FORCASTS;
    Precipitations: array [0 .. 6] of TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_PRECIPITATIONs;
    SunAndMoon: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_SUNANDMOON;
    Photos: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_PHOTOS;
    Provider: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_PROVIDER;
    Meta: TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN_META;
  end;
  /// /

type
  TADDON_WEATHER_PROVIDER_YAHOO = record
    Data_Town: array of TADDON_WEATHER_PROVIDER_YAHOO_DATATOWN;
    Total_WoeID: Integer;
    Selected_Unit: String;
    Iconset_Count: Integer;
    Iconset_Selected: Integer;
    Iconset_Name: String;
    Iconset_Names: TStringList;
    WoeID_List: TStringList;
    Towns_List: TStringList;
  end;

type
  TADDON_WEATHER_PROVIDER_OPENWEATHERMAP = record

  end;

type
  TADDON_WEATHER_ACTIONS = record
    Provider: String;
    Provider_Total: Integer;
    Active_WEOID: Integer;
    Active_Total: Integer;
    PathAni_Data: TPathData;
    PathAni_Show: Boolean;
    Effect_Active_Num: Integer;
    First: Boolean;
    Yahoo: TADDON_WEATHER_PROVIDER_YAHOO;
    OWM: TADDON_WEATHER_PROVIDER_OPENWEATHERMAP;
    WEOID_PER_Provider: array of array of Integer;
    Degree: String;
  end;

type
  TADDON_WEATHER_SETTINGS = record
    Edit_Lock: Boolean;
    Selected_Town: Integer;
    Refresh_Once: Boolean;
    Active_Panel: Integer;
  end;

type
  TADDON_WEATHER_SOUND = record
    Effects: array [0 .. 10] of HSAMPLE;
    mouse: array [0 .. 10] of HSAMPLE;
    warning: array [0 .. 2] of HSAMPLE;
  end;

type
  TADDON_WEATHER_INPUT = record
    mouse: TWEATHER_MOUSE;
    mouse_config: TWEATHER_CONFIG_MOUSE;
    // keyboard:
    // joystick:
  end;

type
  TADDON_WEATHER = record
    Name: String;
    Active: Boolean;
    Main_Menu_Position: Integer;
    Loaded: Boolean;
    Action: TADDON_WEATHER_ACTIONS;
    Config: TADDON_WEATHER_SETTINGS;
    Ini: TADDON_WEATHER_CONFIG;
    Path: TADDON_WEATHER_PATHS;
    Sound: TADDON_WEATHER_SOUND;
    Input: TADDON_WEATHER_INPUT;
  end;

  /// /////////////////////////////////////////////////////////////////////////////
  /// Construction

type
  TWEATHER_GLOBAL_HEADER = record
    Panel: TPanel;
    Icon: TImage;
    Text: TLabel;
  end;

type
  TGENERAL_INFO = record
    Town_Image_Left_Arrow: TText;
    Town_Image_Left_Arrow_Glow: TGlowEffect;
    Town_Image_Right_Arrow: TText;
    Town_Image_Right_Arrow_Glow: TGlowEffect;
    Town_Image_Resolution: TText;
    Town_Image_Resolution_Value: TText;
    Town_Image_Click_Fullscreen: TText;
    Town_Image: TImage;
    Town_Image_Blur: TGaussianBlurEffect;
    Town_Image_Owner: TText;
    Temprature_Unit_F: TText;
    Temprature_Unit_F_Glow: TGlowEffect;
    Temprature_Unit_C: TText;
    Temprature_Unit_C_Glow: TGlowEffect;
    Date: TText;
    Time: TText;
    Time_Icon: TText;
    Image: TImage;
    Text_Image: TText;
    Town_and_Country: TText;
    Latidute: TText;
    Earth: TText;
    Earth_Glow: TGlowEffect;
    Longidute: TText;
    Condtition: TText;
    Day_Icon: TText;
    Day: TText;
    Night_Icon: TText;
    Night: TText;
    Temprature: TText;
    Thermometer: TText;
    Low: TText;
    Low_Icon: TText;
    High: TText;
    High_Icon: TText;
    FeelsLike: TText;
    Moon: TText;
    Moon_Phase: TText;
    Refresh_Text: TText;
    Refresh: TText;
    Refresh_Glow: TGlowEffect;
    ShowImage: TText;
    ShowImage_Blur: TGaussianBlurEffect;
    ShowImage_Glow: TGlowEffect;
  end;

type
  TWIND_INFO = record
    Text: TText;
    Turbine: TImage;
    Turbine_Stand: TImage;
    Turbine_Animation: TFloatAnimation;
    Turbine_Small: TImage;
    Turbine_Small_Stand: TImage;
    Turbine_Small_Animation: TFloatAnimation;
    Speed: TText;
    Direction: TText;
    Direction_Arrow: TText;
    Chill: TText;
    Chill_Icon: TImage;
  end;

type
  TATMOSPHERE_INFO = record
    UV: TText;
    UV_Index: TText;
    Pressure: TText;
    Pressure_Icon: TText;
    Visibility: TText;
    Visibility_Icon: TText;
    Humidity: TText;
    Humidity_Icon: TText;
  end;

type
  TASTRONOMY_INFO = record
    Sunset: TText;
    Sunrise: TText;
    Sunrise_Image: TText;
    Sunset_Image: TText;
    Spot: TImage;
    Spot_Text: TText;
    Spot_Ani: TPathAnimation;
  end;

type
  TFORCAST_DAY_INFO = record
    Layout: TLayout;
    Text: TText;
    Date: TText;
    Image: TImage;
    Condition: TText;
    Low: TText;
    Low_TU: TText;
    Low_Image: TImage;
    High: TText;
    High_TU: TText;
    High_Image: TImage;
  end;

type
  TFORECAST_HOURLY_PANEL_INFO = record
    Layout: TLayout;
    Glow: TInnerGlowEffect;
    Icon: TImage;
    Text_Icon: TText;
    Temperature: TText;
    Condition: TText;
    Humidity_Icon: TText;
    Humidity: TText;
    Wind_Icon: TText;
    Wind: TText;
    Wind_Description: TText;
    Wind_Direction: TText;
    Hour: TText;
  end;

type
  TFORECAST_HOURLY_INFO = record
    Title: TText;
    Left: TText;
    Left_Glow: TGlowEffect;
    Right: TText;
    Right_Glow: TGlowEffect;
    Box: THorzScrollBox;
    Hourly: array [0 .. 24] of TFORECAST_HOURLY_PANEL_INFO;
  end;

type
  TFORECAST_DAILY_PANEL_INFO = record
    Layout: TLayout;
    Glow: TInnerGlowEffect;
    Date: TText;
    Icon: TImage;
    Text_Icon: TText;
    Condition: TText;
    Thermometre: TText;
    Temp_Up: TText;
    Temp_Up_Value: TText;
    Temp_Down: TText;
    Temp_Down_Value: TText;
    Humidity: TText;
    Humidity_Value: TText;
    Line: TRadiantLine;
    Day: TText;
    Day_Value: TText;
    Night: TText;
    Night_Value: TText;
    Both: TText;
  end;

type
  TFORECAST_DAILY_INFO = record
    Line: TRadiantLine;
    Up: TText;
    Up_Glow: TGlowEffect;
    Box: TVertScrollBox;
    Down: TText;
    Down_Glow: TGlowEffect;
    Daily: array [0 .. 10] of TFORECAST_DAILY_PANEL_INFO;
  end;

type
  TFORCAST_INFO = record
    Box: TVertScrollBox;
    Current: TFORCAST_DAY_INFO;
    Day_1: TFORCAST_DAY_INFO;
    Day_2: TFORCAST_DAY_INFO;
    Day_3: TFORCAST_DAY_INFO;
    Day_4: TFORCAST_DAY_INFO;
    Day_5: TFORCAST_DAY_INFO;
    Day_6: TFORCAST_DAY_INFO;
    Day_7: TFORCAST_DAY_INFO;
    Day_8: TFORCAST_DAY_INFO;
    Day_9: TFORCAST_DAY_INFO;
  end;

type
  TSERVER_INFO = record
    LastUpdate: TText;
    Powered_By: TText;
    Icon: TImage;
  end;

type
  TTAB_PANEL = record
    Tab: TALTabItem;
    General: TGENERAL_INFO;
    Wind: TWIND_INFO;
    Atmosphere: TATMOSPHERE_INFO;
    Astronomy: TASTRONOMY_INFO;
    Forecast_Hourly: TFORECAST_HOURLY_INFO;
    Forecast_Daily: TFORECAST_DAILY_INFO;
    Forcast: TFORCAST_INFO;
    Server: TSERVER_INFO;
  end;

type
  TWEATHER_SCENE_FIRST_MAIN = record
    Panel: TPanel;
    Line_1: TALText;
    Line_2: TALText;
    Line_3: TALText;
    Line_4: TALText;
    Check: TCheckBox;
    Done: TButton;
  end;

type
  TWEATHER_SCENE_FIRST = record
    Panel: TPanel;
    Panel_Shadow: TShadowEffect;
    Main: TWEATHER_SCENE_FIRST_MAIN;
  end;

type
  TWEATHER_SCENE = record
    Weather: TImage;
    Weather_Ani: TFloatAnimation;
    Back: TImage;
    Blur: TGaussianBlurEffect;
    Control: TALTabControl;
    Control_Ani: TFloatAnimation;
    Settings: TImage;
    Settings_Ani: TFloatAnimation;
    Settings_Glow: TGlowEffect;
    UpLine: TImage;
    MiddleLine: TImage;
    DownLine: TImage;
    Arrow_Left: TImage;
    Arrow_Left_Glow: TGlowEffect;
    Arrow_Right: TImage;
    Arrow_Right_Glow: TGlowEffect;
    Effect_Timer: TTimer;
    Timer: TADDON_WEATHER_MAINTIMER;
    Tab: array [0 .. 255] of TTAB_PANEL;
    First: TWEATHER_SCENE_FIRST;
  end;

type
  TWEATHER_CONFIG_TOWN_PANEL = record
    Panel: TPanel;
    Glow_Panel: TGlowEffect;
    Image: TText;
    Date: TLabel;
    Temp: TLabel;
    Temp_Unit: TText;
    Temp_Comment: TLabel;
    City_Name: TLabel;
    City_Name_V: TLabel;
    Country_Name: TLabel;
    Country_Name_V: TLabel;
    Country_Flag: TImage;
  end;

type
  TWEATHER_CONFOG_PANEL_RIGHT_PROVIDER_PROV = record
    Panel: TPanel;
    Check: TCheckBox;
    Icon: TImage;
    Desc: TALText;
  end;

type
  TWEATHER_CONFOG_PANEL_RIGHT_PROVIDER = record
    Choose: TLabel;
    Box: TVertScrollBox;
    Prov: array [0 .. 1] of TWEATHER_CONFOG_PANEL_RIGHT_PROVIDER_PROV;
    Text: TLabel;
  end;

type
  TWEATHER_CONFIG_PANEL_RIGHT_TOWNS_ADD_MAIN = record
    Panel: TPanel;
    FindTown: TLabel;
    FindTown_V: TEdit;
    Search: TText;
    Search_Glow: TGlowEffect;
    Grid: TStringGrid;
    Add: TButton;
    Add_Stay: TButton;
    Cancel: TButton;
    ImageList: TImageList;
    Ani_Panel: TPanel;
    Ani_Text: TLabel;
    Ani: TFloatAnimation;
  end;

type
  TWEATHER_CONFIG_PANEL_RIGHT_TOWNS_ADD = record
    Panel: TPanel;
    Main: TWEATHER_CONFIG_PANEL_RIGHT_TOWNS_ADD_MAIN;
  end;

type
  TWEATHER_CONFIG_PANEL_RIGHT_TOWNS_DELETE_MAIN = record
    Panel: TPanel;
    Icon: TImage;
    Line_1: TLabel;
    Line_2: TLabel;
    Delete: TButton;
    Cancel: TButton;
  end;

type
  TWEATHER_CONFIG_PANEL_RIGHT_TOWNS_DELETE = record
    Panel: TPanel;
    Main: TWEATHER_CONFIG_PANEL_RIGHT_TOWNS_DELETE_MAIN;
  end;

type
  TWEATHER_CONFIG_PANEL_RIGHT_TOWNS_REFRESH_MAIN = record
    Panel: TPanel;
    Choice1: TRadioButton;
    Choice2: TRadioButton;
    Refresh: TButton;
    Cancel: TButton;
  end;

type
  TWEATHER_CONFIG_PANEL_RIGHT_TOWNS_REFRESH = record
    Panel: TPanel;
    Main: TWEATHER_CONFIG_PANEL_RIGHT_TOWNS_REFRESH_MAIN;
  end;

type
  TWEATHER_CONFIG_PANEL_RIGHT_TOWNS = record
    CityList: TVertScrollBox;
    Town: array of TWEATHER_CONFIG_TOWN_PANEL;
    Action: TPanel;
    Add_Town: TText;
    Add_Town_Glow: TGlowEffect;
    EditLock: TText;
    EditLock_Glow: TGlowEffect;
    GoUp: TText;
    GoUp_Glow: TGlowEffect;
    GoDown: TText;
    GoDown_Glow: TGlowEffect;
    Refresh_Icon: TText;
    Refresh_Glow: TGlowEffect;
    Delete_Icon: TText;
    Delete_Glow: TGlowEffect;
    Add: TWEATHER_CONFIG_PANEL_RIGHT_TOWNS_ADD;
    Delete: TWEATHER_CONFIG_PANEL_RIGHT_TOWNS_DELETE;
    Refresh: TWEATHER_CONFIG_PANEL_RIGHT_TOWNS_REFRESH;
  end;

type
  TWEATHER_CONFIG_PANEL_RIGHT_OPTIONS_YAHOO = record
    System_Type: TGroupBox;
    Type_Text: TALText;
    Metric: TCheckBox;
    Imperial: TCheckBox;
    Refresh: TGroupBox;
    Refresh_Every: TCheckBox;
    Refresh_Once: TCheckBox;
  end;

type
  TWEATHER_CONFIG_PANEL_RIGHT_OPTIONS_OWM = record
    Degree: TGroupBox;
    Degree_Text: TALText;
    Degree_C: TCheckBox;
    Degree_F: TCheckBox;
    Degree_K: TCheckBox;
    Refresh: TGroupBox;
    Refresh_Every: TCheckBox;
    Refresh_Once: TCheckBox;
    User_ID: TGroupBox;
    Text: TLabel;
    ID: TEdit;
    Lock: TImage;
    Desc: TALText;
  end;

type
  TWEATHER_CONFIG_PANEL_RIGHT_ICONSETS_ICONSET_MINI = record
    Name: TLabel;
    Panel: TPanel;
    Panel_Glow: TGlowEffect;
    Text_Image: array [0 .. 8] of TText;
    Text_Image_Glow: TGlowEffect;
    Image: array [0 .. 8] of TImage;
    Preview: TImage;
    Preview_Glow: TGlowEffect;
  end;

type
  TWEATHER_CONFIG_PANEL_RIGHT_ICONSETS_ICONSET_FULL = record
    Panel: TPanel;
    Images: array [0 .. 48] of TImage;
    Texts: array [0 ..48] of TText;
    Back: TText;
    Back_Glow: TGlowEffect;
  end;

type
  TWEATHER_CONFIG_PANEL_RIGHT_ICONSETS = record
    Text: TLabel;
    Box: TVertScrollBox;
    Mini: array [0 .. 30] of TWEATHER_CONFIG_PANEL_RIGHT_ICONSETS_ICONSET_MINI;
    Full: TWEATHER_CONFIG_PANEL_RIGHT_ICONSETS_ICONSET_FULL;
  end;

type
  TWEATHER_CONFIG_PANEL_RIGHT = record
    Panel: TPanel;
    Panels: array [0 .. 3] of TPanel;
    Provider: TWEATHER_CONFOG_PANEL_RIGHT_PROVIDER;
    Towns: TWEATHER_CONFIG_PANEL_RIGHT_TOWNS;
    Options_Yahoo: TWEATHER_CONFIG_PANEL_RIGHT_OPTIONS_YAHOO;
    Options_OWM: TWEATHER_CONFIG_PANEL_RIGHT_OPTIONS_OWM;
    Iconsets: TWEATHER_CONFIG_PANEL_RIGHT_ICONSETS;
    NoProvider_Selected: TText;
  end;

type
  TWEATHER_CONFIG_PANEL_LEFT = record
    Panel: TPanel;
    Buttons: array [0 .. 3] of TButton;
    Provider: TImage;
  end;

type
  TWEATHER_CONFIG_MAIN = record
    Panel: TPanel;
    Left: TWEATHER_CONFIG_PANEL_LEFT;
    Right: TWEATHER_CONFIG_PANEL_RIGHT;
  end;

type
  TWEATHER_CONFIG = record
    Panel: TPanel;
    Panel_Blur: TGaussianBlurEffect;
    Ani: TFloatAnimation;
    Main: TWEATHER_CONFIG_MAIN;
  end;

type
  TWEATHER = record
    Scene: TWEATHER_SCENE;
    Config: TWEATHER_CONFIG;
  end;

var

  vWeather: TWEATHER;

implementation

uses
  uWeather_Sounds;

{ TADDON_WEATHER_MAINTIMER }

procedure TADDON_WEATHER_MAINTIMER.OnTimer(Sender: TObject);
begin
  if TTimer(Sender).Name = 'A_W_Effect_Timer' then
    uWeather_Sounds_Refresh_Effect;
end;

initialization

vWeather.Scene.Timer := TADDON_WEATHER_MAINTIMER.Create;

finalization

vWeather.Scene.Timer.Free;

end.
