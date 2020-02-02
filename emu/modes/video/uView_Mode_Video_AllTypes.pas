unit uView_Mode_Video_AllTypes;

interface

uses
  System.Classes,
  System.SysUtils,
  FMX.Objects,
  FMX.Ani,
  FMX.Effects,
  FMX.Layouts,
  FMX.TabControl,
  FMX.Filter.Effects,
  FMX.Edit,
  FMX.StdCtrls,
  FMX.Listbox,
  FMX.Types,
  FMX.ViewPort3D,
  FMX.Objects3d,
  FMX.MaterialSources,
  FMX.Controls3D,
  FMX.Layers3D,
  FireDAC.Comp.Client,
  Radiant.Shapes,
  FmxPasLibVlcPlayerUnit,
  ALFMXLayouts,
  BASS;

{ XML Variables }

type
  TEMU_VIEW_MODE_XML_MAIN_BACKGROUND_TYPES = record
    image: String;
    width: String;
    height: String;
    vType: String;
  end;

type
  TEMU_VIEW_MODE_XML_MAIN_IMAGE_GENERAL_TYPES = record
    image: string;
    width: string;
    height: string;
  end;

type
  TEMU_VIEW_MODE_XML_MAIN = record
    Background: TEMU_VIEW_MODE_XML_MAIN_BACKGROUND_TYPES;
    Black: TEMU_VIEW_MODE_XML_MAIN_IMAGE_GENERAL_TYPES;
    Black_Opacity: TEMU_VIEW_MODE_XML_MAIN_IMAGE_GENERAL_TYPES;
    Selection: TEMU_VIEW_MODE_XML_MAIN_IMAGE_GENERAL_TYPES;
  end;

type
  TEMU_VIEW_MODE_XML_CONFIG = record
    Left_Duration: String;
    Left_Limit: String;
    Right_Duration: String;
    Right_Limit: String;
  end;

type
  TEMU_VIEW_MODE_XML_GAME = record
    games: String;
    play_count_refresh_status: String;
    favorites: String;
  end;

type
  TEMU_VIEW_MODE_XML_EMU = record
    name: String;
    vType: String;
    exe: String;
    path: String;
  end;

type
  TEMU_VIEW_MODE_XML_FILTERS = record
    main: TstringList;
    main_num: String;
  end;

type
  TEMU_VIEW_MODE_XML = record
    emu: TEMU_VIEW_MODE_XML_EMU;
    main: TEMU_VIEW_MODE_XML_MAIN;
    config: TEMU_VIEW_MODE_XML_CONFIG;
    game: TEMU_VIEW_MODE_XML_GAME;
    filters: TEMU_VIEW_MODE_XML_FILTERS;
    Images_Path: String;
    Sounds_Path: String;
  end;

  { End XML Variables }

  { Game list objects }
type
  TEMU_VIEW_MODE_VIDEO_GAMELIST_SEARCH = record
    Back: TImage;
    Search: TText;
    Glow: TGlowEffect;
    Edit: TEdit;
    Edit_Ani: TFloatAnimation;
  end;

type
  TEMU_VIEW_MODE_VIDEO_GAMELIST_FILTERS_WINDOW_PANELS = record
    Panel: TPanel;
    Filter_Name: TText;
    Choose: TComboBox;
    Sec_Choose: TComboBox;
    Result: TText;
    Result_Num: TText;
    Result_Games: TText;
    Remove: TText;
    Remove_Glow: TGlowEffect;
  end;

type
  TEMU_VIEW_MODE_VIDEO_GAMELIST_FILTERS_WINDOW = record
    Panel: TPanel;
    Shadow: TShadowEffect;
    Clear: TText;
    Clear_Glow: TGlowEffect;
    Add: TText;
    Add_Glow: TGlowEffect;
    Info: TText;
    Games_Num: TText;
    Filter_Panels: array of TEMU_VIEW_MODE_VIDEO_GAMELIST_FILTERS_WINDOW_PANELS;
    OK: TButton;
    Cancel: TButton;
  end;

type
  TEMU_VIEW_MODE_VIDEO_GAMELIST_FILTERS = record
    Back: TImage;
    Filter: TText;
    Filter_Glow: TGlowEffect;
    Filter_Text: TText;
    Window: TEMU_VIEW_MODE_VIDEO_GAMELIST_FILTERS_WINDOW;
  end;

type
  TEMU_VIEW_MODE_VIDEO_GAMELIST_LISTS_LIST = record
    image: TImage;
    OutLine: TRadiantRectangle;
    OutLine_Glow: TGlowEffect;
    Text: TText;
  end;

type
  TEMU_VIEW_MODE_VIDEO_GAMELIST_LISTS_WINDOW = record
    Panel: TLayout;
    Back: TImage;
    Add_Panel: TImage;
    Add: TText;
    Add_Glow: TGlowEffect;
    List_Control: TTabControl;
    List_Control_Item: array of TTabItem;
    List: array of TEMU_VIEW_MODE_VIDEO_GAMELIST_LISTS_LIST;
  end;

type
  TEMU_VIEW_MODE_VIDEO_GAMELIST_LISTS = record
    Back: TImage;
    Lists: TText;
    Lists_Glow: TGlowEffect;
    Lists_Text: TText;
    Window: TEMU_VIEW_MODE_VIDEO_GAMELIST_LISTS_WINDOW;
  end;

type
  TEMU_VIEW_MODE_VIDEO_GAMELIST_GAMES_LINE = record
    Back: TImage;
    Icon: TImage;
    Text: TText;
  end;

type
  TEMU_VIEW_MODE_VIDEO_GAMELIST_GAMES = record
    List: TImage;
    List_Blur: TBlurEffect;
    Listbox: TVertScrollBox;
    Line: array [0 .. 20] of TEMU_VIEW_MODE_VIDEO_GAMELIST_GAMES_LINE;
    Selection: TGlowEffect;
  end;

type
  TEMU_VIEW_MODE_VIDEO_GAMELIST_INFO = record
    Back: TImage;
    Games_Count: TText;
    Version: TText;
    Timer: TTimer;
  end;

type
  TEMU_VIEW_MODE_VIDEO_GAMELIST = record
    Info: TEMU_VIEW_MODE_VIDEO_GAMELIST_INFO;
    games: TEMU_VIEW_MODE_VIDEO_GAMELIST_GAMES;
    Lists: TEMU_VIEW_MODE_VIDEO_GAMELIST_LISTS;
    filters: TEMU_VIEW_MODE_VIDEO_GAMELIST_FILTERS;
    Search: TEMU_VIEW_MODE_VIDEO_GAMELIST_SEARCH;
    Gamelist: TEMU_VIEW_MODE_VIDEO_GAMELIST_INFO;
  end;
  { End of Game list objects }

  { Media objects }
type
  TEMU_VIEW_MODE_VIDEO_MEDIA_ACTION_GAMEINFO = record
    Layout: TLayout;
    Players: TText;
    Players_Value: TText;
    Favorite: TText;
  end;

type
  TEMU_VIEW_MODE_VIDEO_MEDIA_BAR = record
    Back: TImage;
    favorites: TText;
    Favorites_Glow: TGlowEffect;
  end;

type
  TEMU_VIEW_MODE_VIDEO_MEDIA_VIDEO = record
    Back: TImage;
    Game_Info: TEMU_VIEW_MODE_VIDEO_MEDIA_ACTION_GAMEINFO;
    Video_Back: TImage;
    Video: TFmxPasLibVlcPlayer;
    Video_Timer_Cont: TTimer;
  end;

type
  TEMU_VIEW_MODE_VIDEO_MEDIA = record
    Bar: TEMU_VIEW_MODE_VIDEO_MEDIA_BAR;
    Video: TEMU_VIEW_MODE_VIDEO_MEDIA_VIDEO;
  end;

  { End Of Media Objects }

  { Game menu Objects }
type
  TEMU_VIEW_MODE_GAMEMENU_INFO = record
    Layout: TLayout;
    Headline: TText;
    Line: TRadiantLine;
    Box: TALVertScrollBox;
    Text_Caption: array [0 .. 18] of TText;
    Text: array [0 .. 18] of TText;
  end;

type
  TEMU_VIEW_MODE_GAMEMENU_MANUAL = record
    Layout: TLayout;
    Headline: TText;
    Line: TRadiantLine;
    Box: TALVertScrollBox;
  end;

type
  TEMU_VIEW_MODE_GAMEMENU_MEDIA = record
    Layout: TLayout;
    Headline: TText;
    Line: TRadiantLine;
    Box: TALVertScrollBox;
  end;

type
  TEMU_VIEW_MODE_GAMEMENU_FULLSCREEN = record
    Layout: TLayout;
    Headline: TText;
    Line: TRadiantLine;
    Box: TALVertScrollBox;
  end;

type
  TEMU_VIEW_MODE_GAMEMENU_SOUNDTRACK = record
    Layout: TLayout;
    Headline: TText;
    Line: TRadiantLine;
    Box: TALVertScrollBox;
  end;

type
  TEMU_VIEW_MODE_GAMEMENU_FAVORITE = record
    Layout: TLayout;
    Headline: TText;
    Line: TRadiantLine;
    View: TViewport3D;
    Light: TLight;
    Heart: TModel3D;
    Material_Source: TColorMaterialSource;
    Ani: TFloatAnimation;
  end;

type
  TEMU_VIEW_MODE_GAMEMENU_PLAYLIST = record
    Layout: TLayout;
    Headline: TText;
    Line: TRadiantLine;
    Box: TALVertScrollBox;
  end;

type
  TEMU_VIEW_MODE_GAMEMENU_POPUP = record
    Back: TImage;
    Indicator: TAniIndicator;
    Line1: TText;
    Line2: TText;
    Snap: TImage;
    Play: TText;
    Play_V: TText;
  end;

type
  TEMU_VIEW_MODE_GAMEMENU = record
    Stamp: TImage;
    Info: TEMU_VIEW_MODE_GAMEMENU_INFO;
    Manual: TEMU_VIEW_MODE_GAMEMENU_MANUAL;
    Media: TEMU_VIEW_MODE_GAMEMENU_MEDIA;
    Fullscreen: TEMU_VIEW_MODE_GAMEMENU_FULLSCREEN;
    Soundtrack: TEMU_VIEW_MODE_GAMEMENU_SOUNDTRACK;
    Favorite: TEMU_VIEW_MODE_GAMEMENU_FAVORITE;
    Playlist: TEMU_VIEW_MODE_GAMEMENU_PLAYLIST;
    PopUp: TEMU_VIEW_MODE_GAMEMENU_POPUP;
  end;

  { End of Game menu Objects }

  { Configuration objects }

type
  TEMU_VIEW_MODE_VIDEO_CONFIGURATION = record
    main: TPanel;
    left: TPanel;
    right: TPanel;
    Blur: TGaussianBlurEffect;
    Shadow: TShadowEffect;
  end;
  { End of Configuration objects }

type
  TEMU_VIEW_MODE_VIDEO = record
    main: TImage;
    Blur: TGaussianBlurEffect;
    left: TImage;
    Left_Ani: TFloatAnimation;
    Left_Blur: TBlurEffect;
    right: TImage;
    Right_Ani: TFloatAnimation;
    Right_Blur: TBlurEffect;
    config: TEMU_VIEW_MODE_VIDEO_CONFIGURATION;
    Gamelist: TEMU_VIEW_MODE_VIDEO_GAMELIST;
    Media: TEMU_VIEW_MODE_VIDEO_MEDIA;
    GameMenu: TEMU_VIEW_MODE_GAMEMENU;
    Settings: TText;
    Settings_Ani: TFloatAnimation;
    Settings_Glow: TGlowEffect;
    Exit: TText;
    Exit_Glow: TGlowEffect;
  end;

  { End Of Objects types }

  { Variables needed }
type
  TEMU_VIEW_MODE_VIDEO_VARIABLES_VIDEO = record
    Active_Video: String;
    Old_Width: Integer;
    Loaded: Boolean;
  end;

type
  TEMU_VIEW_MODE_VIDEO_VARIABLES_GAMELIST = record
    Loaded: Boolean;
    games: TstringList;
    Roms: TstringList;
    Paths: TstringList;
    Selected: Integer;
    Total_Games: Integer;
  end;

type
  TEMU_VIEW_MODE_VIDEO_VARIABLES_FILTERS = record
    Roms: TstringList;
    games: TstringList;
    List: TstringList;
    List_Added: TstringList;
    Added: Integer;
    Done: Boolean;
  end;

type
  TEMU_VIEW_MODE_VIDEO_VARIABLES_ANIMATIONS_CONFIG = class(TObject)
    procedure OnFinish(Sender: TObject);
  end;

type
  TEMU_VIEW_MODE_VIDEO_VARIABLES_ANIMATIONS = record
    config: TEMU_VIEW_MODE_VIDEO_VARIABLES_ANIMATIONS_CONFIG;
  end;

type
  TEMU_VIEW_MODE_VIDEO_VARIABLES_TIMERS_GAMELIST = class(TObject)
    procedure OnTimer(Sender: TObject);
  end;

type
  TEMU_VIEW_MODE_VIDEO_VARIABLES_TIMERS_VIDEO = class(TObject)
    procedure OnTimer(Sender: TObject);
  end;

type
  TEMU_VIEW_MODE_VIDEO_VARIABLES_TIMERS = record
    Gamelist: TEMU_VIEW_MODE_VIDEO_VARIABLES_TIMERS_GAMELIST;
    Video: TEMU_VIEW_MODE_VIDEO_VARIABLES_TIMERS_VIDEO;
  end;

type
  TEMU_VIEW_MODE_VIDEO_VARIABLES_GAME = record
    Selected: Integer;
  end;

type
  TEMU_VIEW_MODE_VIDEO_VARIABLES_SOUNDS = record
    Fav_add: HSAMPLE;
    Fav_remove: HSAMPLE;
    VK_Click: HSAMPLE;
    VK_Wrong: HSAMPLE;
  end;

type
  TEMU_VIEW_MODE_VIDEO_VARIABLES_FAVORITES = record
    game_is: Boolean;
    count: Integer;
    roms: TstringList;
    games: TstringList;
  end;

type
  TEMU_VIEW_MODE_VIDEO_VARIABLES_SEARCH = record
    selected: integer;
    vstring: String;
    vkey: String;
  end;

type
  TEMU_VIEW_MODE_VIDEO_VARIABLES = record
    Query: TFDQuery;
    User_Num: Integer;
    Config_Open: Boolean;
    Filters_Open: Boolean;
    Game_Mode: Boolean;
    Game_Loading: Boolean;
    Favorites_Open: Boolean;
    Search_Open: Boolean;
    search: TEMU_VIEW_MODE_VIDEO_VARIABLES_SEARCH;
    game: TEMU_VIEW_MODE_VIDEO_VARIABLES_GAME;
    filters: TEMU_VIEW_MODE_VIDEO_VARIABLES_FILTERS;
    favorites: TEMU_VIEW_MODE_VIDEO_VARIABLES_FAVORITES;
    gamelist: TEMU_VIEW_MODE_VIDEO_VARIABLES_GAMELIST;
    video: TEMU_VIEW_MODE_VIDEO_VARIABLES_VIDEO;
    ani: TEMU_VIEW_MODE_VIDEO_VARIABLES_ANIMATIONS;
    timer: TEMU_VIEW_MODE_VIDEO_VARIABLES_TIMERS;
    sounds: TEMU_VIEW_MODE_VIDEO_VARIABLES_SOUNDS;
  end;

  { End of Variables needed }

var
  Emu_VM_Video: TEMU_VIEW_MODE_VIDEO;
  Emu_XML: TEMU_VIEW_MODE_XML;
  Emu_VM_Video_Var: TEMU_VIEW_MODE_VIDEO_VARIABLES;

implementation

uses
  uEmu_Emu,
  uView_Mode_Video,
  uView_Mode_Video_Actions;

{ TEMU_VIEW_MODE_VIDEO_VARIABLES_ANIMATIONS_CONFIG }

procedure TEMU_VIEW_MODE_VIDEO_VARIABLES_ANIMATIONS_CONFIG.OnFinish(Sender: TObject);
begin
  if TFloatAnimation(Sender).name = 'Main_Right_Animation' then
  begin
    if Emu_VM_Video_Var.Config_Open then
      uView_Mode_Video.Create_Configuration(Emu_VM_Video.main);
    uEmu_Emu.Mouse_Action('Emu_Settings');
  end;
end;

{ TEMU_VIEW_MODE_VIDEO_VARIABLES_TIMERS_GAMELIST }

procedure TEMU_VIEW_MODE_VIDEO_VARIABLES_TIMERS_GAMELIST.OnTimer(Sender: TObject);
begin
  if Emu_VM_Video_Var.Favorites_Open then
    uView_Mode_Video_Actions.Refresh_Scene(Emu_VM_Video_Var.Gamelist.Selected, Emu_VM_Video_Var.favorites.Roms)
  else
    uView_Mode_Video_Actions.Refresh_Scene(Emu_VM_Video_Var.Gamelist.Selected, Emu_VM_Video_Var.Gamelist.Roms);
  Emu_VM_Video.Gamelist.Gamelist.Timer.Enabled := False;
end;

{ TEMU_VIEW_MODE_VIDEO_VARIABLES_TIMERS_VIDEO }

procedure TEMU_VIEW_MODE_VIDEO_VARIABLES_TIMERS_VIDEO.OnTimer(Sender: TObject);
var
  vWidth, vHeight: Cardinal;
begin
  if Emu_VM_Video_Var.Video.Loaded = False then
  begin
    if Emu_VM_Video.Media.Video.Video.GetVideoDimension(vWidth, vHeight) then
    begin
      if Emu_VM_Video.Media.Video.Video.GetVideoWidth <> 0 then
      begin
        if Emu_VM_Video.Media.Video.Video.GetVideoWidth <> Emu_VM_Video_Var.Video.Old_Width then
        begin
          if Emu_VM_Video.Media.Video.Video.GetVideoWidth > Emu_VM_Video.Media.Video.Video.GetVideoHeight then
            Emu_VM_Video.Media.Video.Video_Back.SetBounds(50, 150, 650, 488)
          else
            Emu_VM_Video.Media.Video.Video_Back.SetBounds(137, 100, 488, 650);
        end;
        Emu_VM_Video.Media.Video.Game_Info.Layout.SetBounds(0, -50, Emu_VM_Video.Media.Video.Video_Back.width, 50);
        Emu_VM_Video.Media.Video.Game_Info.Favorite.SetBounds(Emu_VM_Video.Media.Video.Game_Info.Layout.width - 60, 5, 60, 50);
        Emu_VM_Video_Var.Video.Old_Width := Emu_VM_Video.Media.Video.Video.GetVideoWidth;
        Emu_VM_Video_Var.Video.Loaded := True;
      end;
    end;
  end;
  if Emu_VM_Video_Var.Video.Loaded then
  begin
    if Emu_VM_Video.Media.Video.Video.GetVideoPosInPercent > 98 then
      Emu_VM_Video.Media.Video.Video.Play(Emu_VM_Video_Var.Video.Active_Video);
  end;
end;

end.
