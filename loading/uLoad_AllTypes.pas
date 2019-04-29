unit uLoad_AllTypes;

interface

uses
  System.Classes,
  System.Inifiles,
  System.SysUtils,
  System.UiTypes,
  FMX.OBjects,
  FMX.StdCtrls,
  FMX.Effects,
  FMX.Filter.Effects,
  FMX.Ani,
  FMX.Edit,
  FMX.Types,
  FMX.Memo,
  FMX.Layouts,
  ALFmxTabControl,
  BASS,
  FmxPasLibVlcPlayerUnit,
  uLoad_Mouse,
  uMain_AllTypes,
  uTime_AllTypes,
  uSoundplayer_AllTypes,
  uWeather_AllTypes,
  uPlay_AllTypes;

/// Global Window Header
///
type
  TGLOBAL_HEADER = record
    Panel: TPanel;
    Icon: TImage;
    Text: Tlabel;
  end;

  /// /////////////////////////////////////////////////////////////////////////////
  /// Extrafe variable types
type
  TEXTRAFE_BUILD_INFO = record
    Major: String;
    Minor: String;
    Realeash: String;
    Build: String;
  end;

type
  TEXTRAFE_PROGRAM_PATHS = record
    Lib: String;
    History: String;
    Fonts: String;
  end;

type
  TEXTRAFE_PROGRAM = record
    State: String;
    Path: String;
    Name: String;
    Desc: String;
    Virtual_Keyboard: Boolean;
    Paths: TEXTRAFE_PROGRAM_PATHS;
    Version: TEXTRAFE_BUILD_INFO;
  end;

type
  TEXTRAFE_INI = record
    Path: String;
    Name: String;
    Ini: TIniFile;
  end;

type
  TEXTRAFE_RESOLUTION = Record
    Fullscreen: Boolean;
    Width: Integer;
    Half_Width: Integer;
    Height: Integer;
    Half_Height: Integer;
  end;

type
  TEXTRAFE_STYLES = record
    Path: String;
    Num: Integer;
    Name: String;
    Names: TStringList;
  end;

type
  TEXTRAFE_STATISTICS_ADDON = record
    Path: String;
    Name: String;
    OpenTimes: Integer;
    SumTime: Integer;
    LastVisit: TDateTime;
  end;

type
  TEXTRAFE_STATISTICS_EMU_INFO = record
    Path: String;
    Name: String;
    OpenTimes: Integer;
    SumTime: TTime;
    PlayGames: Integer;
    LastPlayGame: String;
    PlayTotalTime: TTime;
    LastVisit: TDateTime;
  end;

type
  TEXTRAFE_STATISTICS_EMU = record
    Arcade: array [0 .. 7] of TEXTRAFE_STATISTICS_EMU_INFO;
    Computers: array [0 .. 12] of TEXTRAFE_STATISTICS_EMU_INFO;
    Consoles: array [0 .. 32] of TEXTRAFE_STATISTICS_EMU_INFO;
    Handhelds: array [0 .. 12] of TEXTRAFE_STATISTICS_EMU_INFO;
    Pinballs: array [0 .. 1] of TEXTRAFE_STATISTICS_EMU_INFO;
  end;

type
  TEXTRAFE_STATISTICS = record
    Path: String;
    Name: String;
    Ini: TIniFile;
    Timer: TTimer;
    SumTime: Integer;
    Login_Success: Integer;
    Login_Fails: Integer;
    Login_Last: TDateTime;
    Addon: array [0 .. 4] of TEXTRAFE_STATISTICS_ADDON;
    Emu: TEXTRAFE_STATISTICS_EMU;
  end;

type
  TEXTRAFE = record
    prog: TEXTRAFE_PROGRAM;
    Ini: TEXTRAFE_INI;
    users_active: Integer;
    users_total: Integer;
    user_login: Boolean;
    res: TEXTRAFE_RESOLUTION;
    style: TEXTRAFE_STYLES;
    database_is_connected: Boolean;
    stats: TEXTRAFE_STATISTICS;
  end;
  /// /////////////////////////////////////////////////////////////////////////////
  /// Addons Variable Types

  // Widget for the main menu
type
  TADDON_WIDGET = record
    position_x: Single;
    position_y: Single;
    Width: Integer;
    Height: Integer;
    blocks_getin_x: Integer;
    blocks_getin_y: Integer;
    blocks_start_block_x: Integer;
    blocks_start_block_y: Integer;
    Name: string;
    place: Integer;
  end;

  // CALENDAR Addon
type
  TADDON_CALENDAR_PATHS = record
    Icon: string;
    Images: string;
  end;

type
  TADDON_CALENDAR_CONFIG = record
    Ini: TIniFile;
    Name: String;
    Path: String;
  end;

type
  TADDON_CALENDAR = record
    Name: String;
    Active: Boolean;
    Main_Menu_Position: Integer;
    Ini: TADDON_CALENDAR_CONFIG;
    Path: TADDON_CALENDAR_PATHS;
    widget: TADDON_WIDGET;
  end;

  // SOUNDPLAYR Addon

  // WEATHER ADDON

  // GENERAL ADDON TYPE
type
  TADDON = record
    Active: Boolean;
    Active_Num: Integer;
    Active_Now_Num: Integer;
    Total_Num: Integer;
    Active_PosNames: array [0 .. 255] of string;
    time: TADDON_TIME;
    calendar: TADDON_CALENDAR;
    weather: TADDON_WEATHER;
    soundplayer: TADDON_SOUNDPLAYER;
    play: TADDON_PLAY;
    Widget_Active: Boolean;
    Widget_Active_Num: Integer;
    Widget_Total_Num: Integer;
    Widget_Active_Names: array [0 .. 100] of TADDON_WIDGET;
  end;

  /// /////////////////////////////////////////////////////////////////////////////
  /// Emulators variables types
type
  TEXTRAFE_MAIN_MENU_EMULATOR = record
    Prog_Path: String;
    Emu_Path: String;
    Active: Boolean;
    Active_Place: Integer;
    Name: String;
    Name_Exe: String;
    Menu_Image: String;
    Menu_Image_Path: String;
    Second_Level: Integer;
    Installed: Boolean;
    Unique_Num: Integer;
  end;

type
  TEXTRAFE_MAIN_MENU_EMULATOR_TAB = record
    IsMainActive: Boolean;
    Tab: TALTabItem;
    Logo: TImage;
    Logo_Gray: TMonochromeEffect;
    Logo_Glow: TGlowEffect;
    Story: TText;
    Long_Icons: TImage;
  end;

type
  TEMULATORS = record
    Active: Boolean; // Is emulation active
    ShowCat: Boolean; // Is show category active. if false then show emulators in raw
    Path: String; // Keeps the path of emu in general
    Unique_Num: Integer; // Keeps the last num of all emulators
    Active_Num: Integer; // Keeps the num of all active emulators
    Level: Integer; // Keeps the level of category emulation
    Category_Num: Integer; // Keeps the num of category that called
    Number: Integer;

    Selection: TALTabControl;
    Selection_Ani: TFloatAnimation;
    Selection_Tab: array [0 .. 255] of TEXTRAFE_MAIN_MENU_EMULATOR_TAB;
    Category: array [0 .. 4] of TEXTRAFE_MAIN_MENU_EMULATOR;
    Arcade: array [0 .. 10] of TEXTRAFE_MAIN_MENU_EMULATOR;
    Computers: array [0 .. 10] of TEXTRAFE_MAIN_MENU_EMULATOR;
    Consoles: array [0 .. 10] of TEXTRAFE_MAIN_MENU_EMULATOR;
    Handhelds: array [0 .. 10] of TEXTRAFE_MAIN_MENU_EMULATOR;
    Pinballs: array [0 .. 10] of TEXTRAFE_MAIN_MENU_EMULATOR;
    Emu: array of array of string;
  end;
  /// /////////////////////////////////////////////////////////////////////////////
  /// Sound variables types

type
  TSOUND = record
    bass_ver: string;
    str_music: array [0 .. 128] of HSAMPLE;
    str_fx: array [0 .. 1024] of HSAMPLE;
  end;

  /// /////////////////////////////////////////////////////////////////////////////

  /// /////////////////////////////////////////////////////////////////////////////

  /// // Constructur Section of Loading
  ///
  ///

type
  TLOADING_FLOATANIMATION = Class(TObject)
    procedure OnFinish(Sender: TObject);
  End;

type
  TLOADING_TIMER_ONTIMER = class(TObject)
    procedure OnTimer(Sender: TObject);
  end;

type
  TLOADING_SCENE = record
    Back: TImage;
    Back_Fade: TFloatAnimation;
    Back_Fade_Float: TLOADING_FLOATANIMATION;
    Logo: TImage;
    Logo_Shadow: TShadowEffect;
    Progress: TProgressBar;
    Progress_Text: Tlabel;
    Code_Name: TText;
    Ver: TText;
    Timer: TTimer;
    Timer_Pros: TLOADING_TIMER_ONTIMER;
  end;

type
  TLOADING_INTRO = record
    Back: TLayout;
    Video: TFmxPasLibVlcPlayer;
    Text: TText;
    Text_Ani: TFloatAnimation;
    Timer: TTimer;
    Fade_Count: Integer;
  end;

type
  TLOGIN_SCENE = record
    Panel: TPanel;
    Main: TPanel;
    Panel_Login_Error: TFloatAnimation;
    Panel_Login_Correct: TFloatAnimation;
    Panel_Shadow: TShadowEffect;
    Avatar: TImage;
    CapsLock: TText;
    User: Tlabel;
    User_V: TEdit;
    Pass: Tlabel;
    Pass_V: TEdit;
    Pass_Show: TText;
    Pass_Show_Glow: TGlowEffect;
    NotRegister: TText;
    Warning: Tlabel;
    Forget_Pass: TText;
    Login: TButton;
    Exit_ExtraFE: TButton;
    Internet: Tlabel;
    Int_Icon: TText;
    Database: Tlabel;
    Data_Icon: TText;
  end;

type
  TLOADING_FORGET_PASSWORD_MAIN = record
    Panel: TPanel;
    User: TText;
    Avatar: TImage;
    Email: Tlabel;
    Email_V: TEdit;
    Send: TButton;
    Cancel: TButton;
    Warning: Tlabel;
  end;

type
  TLOADING_FORGET_PASSWORD = record
    Panel: TPanel;
    Main: TLOADING_FORGET_PASSWORD_MAIN;
  end;

type
  TLOADING_REGISTER_MAIN_DATA = record
    Panel: TCalloutPanel;
    Headers: array [0 .. 7] of Tlabel;
    User: array [0 .. 4] of Tlabel;
    Pass: array [0 .. 1] of Tlabel;
    RePass: array [0 .. 1] of Tlabel;
    Email: array [0 .. 1] of Tlabel;
    ReEmail: array [0 .. 1] of Tlabel;
    Terms: Tlabel;
    Accept_Terms: Tlabel;
    Captcha: array [0 .. 1] of Tlabel;
    Check: array [0 .. 16] of TCheckBox;
  end;

type
  TLOADING_REGISTER_MAIN = record
    Panel: TPanel;
    Data: TLOADING_REGISTER_MAIN_DATA;
    User: Tlabel;
    User_V: TEdit;
    Pass: Tlabel;
    Pass_V: TEdit;
    Pass_Show: TText;
    Pass_Show_Glow: TGlowEffect;
    RePass: Tlabel;
    RePass_V: TEdit;
    RePass_Show: TText;
    RePass_Show_Glow: TGlowEffect;
    Email: Tlabel;
    Email_V: TEdit;
    ReEmail: Tlabel;
    ReEmail_V: TEdit;
    Capt: Tlabel;
    Capt_Img: TImage;
    Capt_Img_Word: array [0 .. 5] of TText;
    Capt_Refresh: TText;
    Capt_Refresh_Glow: TGlowEffect;
    Capt_V: TEdit;
    Terms: TText;
    Terms_Check: TCheckBox;
    Reg: TButton;
    Cancel: TButton;
  end;

type
  TLOADING_REGISTER = record
    Panel: TPanel;
    Main: TLOADING_REGISTER_MAIN;
    Edit_Select: String;
  end;

type
  TLOADING_TERMS_MAIN = record
    Panel: TPanel;
    Text: Tlabel;
    Memo: TMemo;
    Close: TButton;
  end;

type
  TLOADING_TERMS = record
    Panel: TPanel;
    Header: TGLOBAL_HEADER;
    Main: TLOADING_TERMS_MAIN;
  end;

type
  TLOADING_INPUT = record
    mouse: TLOADING_INPUT_MOUSE;
  end;

type
  TLOADING_PATHS = record
    Images: String;
  end;

type
  TLOADING = record
    Scene: TLOADING_SCENE;
    Intro: TLOADING_INTRO;
    Login: TLOGIN_SCENE;
    F_Pass: TLOADING_FORGET_PASSWORD;
    Reg: TLOADING_REGISTER;
    Terms: TLOADING_TERMS;
    Input: TLOADING_INPUT;
    Path: TLOADING_PATHS;
  end;

var
  extrafe: TEXTRAFE;
  ex_main: TMAIN;
  sound: TSOUND;
  addons: TADDON;
  emulation: TEMULATORS;
  ex_load: TLOADING;

procedure uLoad_SetAll_CreateHeader(vPanel: TPanel; vName, vIcon, vText: String);

implementation

uses
  loading,
  Main,
  uMain;

procedure uLoad_SetAll_CreateHeader(vPanel: TPanel; vName, vIcon, vText: String);
var
  vHeader: TGLOBAL_HEADER;
begin
  vHeader.Panel := TPanel.Create(vPanel);
  vHeader.Panel.Name := vName + '_Header';
  vHeader.Panel.Parent := vPanel;
  vHeader.Panel.SetBounds(0, 0, vPanel.Width, 30);
  vHeader.Panel.Visible := True;

  vHeader.Icon := TImage.Create(vHeader.Panel);
  vHeader.Icon.Name := vName + '_Header_Icon';
  vHeader.Icon.Parent := vHeader.Panel;
  vHeader.Icon.SetBounds(6, 3, 24, 24);
  vHeader.Icon.Bitmap.LoadFromFile(vIcon);
  vHeader.Icon.WrapMode := TImageWrapMode.Fit;
  vHeader.Icon.Visible := True;

  vHeader.Text := Tlabel.Create(vHeader.Panel);
  vHeader.Text.Name := vName + '_Header_Text';
  vHeader.Text.Parent := vHeader.Panel;
  vHeader.Text.SetBounds(36, 3, 300, 24);
  vHeader.Text.Text := vText;
  vHeader.Text.Font.style := vHeader.Text.Font.style + [TFontStyle.fsBold];
  vHeader.Text.Visible := True;
end;

{ TLOADING_FLOATANIMATION }

procedure TLOADING_FLOATANIMATION.OnFinish(Sender: TObject);
begin
  if TFloatAnimation(Sender).Name = 'Loading_FadeOut' then
  begin
    uMain_Load;
    Main_Form.Show;
    FreeAndNil(Loading_Form);
  end;
end;

{ TLOADING_TIMER_ONTIMER }

procedure TLOADING_TIMER_ONTIMER.OnTimer(Sender: TObject);
begin
  if TTimer(Sender).Name = 'Loading_Intro_Timer' then
  begin
    if ex_load.Intro.Fade_Count > 150 then
    begin
      ex_load.Intro.Video.Cursor := crNone;
      ex_load.Intro.Text.Cursor:= crNone;
      ex_load.Intro.Text_Ani.Start;
    end;
    if ex_load.Intro.Video.IsPlay = False then
    begin
      FreeAndNil(ex_load.Intro.Back);
      ex_load.Intro.Timer.Enabled := False;
      ex_load.Scene.Back.Visible := True;
    end;
    if ex_load.Intro.Video.Cursor = crDefault then
      Inc(ex_load.Intro.Fade_Count, 1);
  end;
end;

initialization

ex_load.Scene.Back_Fade_Float := TLOADING_FLOATANIMATION.Create;
ex_load.Scene.Timer_Pros := TLOADING_TIMER_ONTIMER.Create;

finalization

ex_load.Scene.Back_Fade_Float.Free;
ex_load.Scene.Timer_Pros.Free;

end.
