unit uSoundplayer_AllTypes;

interface

uses
  System.Classes,
  System.IniFiles,
  System.SysUtils,
  System.UITypes,
  FMX.Objects,
  FMX.Dialogs,
  FMX.Grid,
  FMX.Grid.Style,
  FMX.Effects,
  FMX.StdCtrls,
  FMX.Types,
  FMX.Ani,
  FMX.Filter.Effects,
  FMX.TabControl,
  FMX.Edit,
  FMX.ComboEdit,
  FMX.Memo,
  FMX.ListBox,
  FMX.Imglist,
  FMX.Menus,
  FMX.ExtCtrls,
  FMX.Layouts,
  ALFmxStdCtrls,
  ID3v1Library,
  ID3v2Library,
  ALFmxObjects,
  OggVorbisAndOpusTagLibrary,
  uSoundplayer_Mouse,
  uSoundplayer_Tag_Mouse,
  Bass;

type
  TADDON_SOUNDPLAYER_PLAYER_TAGS_MP3 = record
    ID3v1: TID3v1Tag;
    ID3v2: TID3v2Tag;
    Lyrics: TStringList;
    Lyrics_LanguageID: TLanguageID;
    Lyrics_Description: String;
    TagError: Integer;
    Rating_Before_Save: Integer;
    Rating: Integer;
  end;

type
  TADDON_SOUNDPLAYER_PLAYER_TAGS_OGG = record
    Opus: TOpusTag;
    TagError: Integer;
  end;

type
  TADDON_SOUNDPLAYER_PLAYER_TAGS = record
    mp3: TADDON_SOUNDPLAYER_PLAYER_TAGS_MP3;
    ogg: TADDON_SOUNDPLAYER_PLAYER_TAGS_OGG;
    // mp4:
    // flac:
    // ape:
    // wav:
    // wma:
  end;

type
  TADDON_SOUNDPLAYER_PLAYER = record
    Play: Boolean;
    Pause: Boolean;
    Stop: Boolean;
    HasNext_Track: Boolean;
    HasPrevious_Track: Boolean;
    VRepeat: String;
    Suffle: Boolean;
    Mute: Boolean;
    Playing_Now: SmallInt;
    LastPlayed: SmallInt;
    Thumb_Active: Boolean;
    Volume_Changed: Boolean;
    Song_State: Single;
    Time_Negative: Boolean;
    Title_Ani: Boolean;
    Title_Ani_Left: Boolean;
    Tag: TADDON_SOUNDPLAYER_PLAYER_TAGS;
  end;

type
  TADDON_SOUNDPLAYER_INFO = record
    isCoverInFullscreen: Boolean;
  end;

type
  TADDON_SOUNDPLAYER_CONFIG = record
    Ini: TIniFile;
    Name: string;
    Path: string;
  end;

type
  TADDON_SOUNDPLAYER_PLAYLIST_INFO_TAG = record
    Disk_Name: String;
    Disk_Path: String;
    Disk_Type: String;
    Title: string;
    Artist: string;
    Album: string;
    Year: string;
    Track: string;
    Genre: string;
    Comment: String;
    Track_Seconds: string;
    Rate: String;
    // Cover_A: TBitmap;
    // Cover_B: TBitmap;
    // Cover_C: TBitmap;
    // Cover_Num: Byte;
  end;

type
  TADDON_SOUNDPLAYER_PLAYLIST_PLAYLISTS = record
    Name: String;
    VType: String;
    Path: String;
    Songs: Integer;
    Played: Integer;
    LastPlayed: String;
  end;

type
  TADDON_SOUNDPLAYER_PLAYLIST_LIST = record
    Name: String;
    VType: String;
    Num: Integer;
    Playlist: TStringList;
    Playlists: array of TADDON_SOUNDPLAYER_PLAYLIST_PLAYLISTS;
    Songs: TStringList;
    Song_Info: array of TADDON_SOUNDPLAYER_PLAYLIST_INFO_TAG;
    Songs_Num: Integer;
    Songs_Total_Time: String;
    Played: Integer;
    Last_Played: String;
  end;

type
  TADDON_SOUNDPLAYER_PLAYLIST = record
    Total: SmallInt;
    Active: SmallInt;
    List: TADDON_SOUNDPLAYER_PLAYLIST_LIST;
    Manage_Lock: Boolean;
    Manage_CtrlKey: Boolean;
    Manage_Selected: Integer;
    Edit: Boolean;
  end;

type
  TADDON_SOUNDPLAYER_VOLUME = record
    Vol: Real;
    State: String;
    Speakers: String;
    Mute: Real;
    Master: Real;
    Left: Real;
    Right: Real;
  end;

type
  TADDON_SOUNDPLAYER_PATHS = record
    Icon: String;
    Images: String;
    Files: String;
    Playlists: string;
    Sounds: String;
  end;

type
  TADDON_SOUNDPLAYER_INPUT = record
    mouse: TSOUNDPLAYER_MOUSE_ACTIONS;
    mouse_tag: TSOUNDPLAYER_MOUSE_TAG_ACTIONS;
    // keyboard:
    // joystick:
  end;

type
  TADDON_SOUNDPLAYER_ACTIONS = record
    First: Boolean;
  end;

type
  TADDON_SOUNDPLAYER_SOUND = record
    Effects: array [0 .. 10] of HSAMPLE;
    mouse: array [0 .. 10] of HSAMPLE;
    warning: array [0 .. 2] of HSAMPLE;
  end;

type
  TADDON_SOUNDPLAYER = record
    Name: String;
    Active: Boolean;
    Main_Menu_Position: Integer;
    Actions: TADDON_SOUNDPLAYER_ACTIONS;
    Player: TADDON_SOUNDPLAYER_PLAYER;
    Info: TADDON_SOUNDPLAYER_INFO;
    Playlist: TADDON_SOUNDPLAYER_PLAYLIST;
    Volume: TADDON_SOUNDPLAYER_VOLUME;
    Path: TADDON_SOUNDPLAYER_PATHS;
    Input: TADDON_SOUNDPLAYER_INPUT;
    Ini: TADDON_SOUNDPLAYER_CONFIG;
    Sound: TADDON_SOUNDPLAYER_SOUND;
  end;

  /// /////////////////////////////////////////////////////////////////////////////
  /// Construction
  ///

type
  TSOUNDPLAYER_ADDON_FLOATANIMATION = class(TObject)
    procedure OnFinish(Sender: TObject);
  end;

type
  TSOUNDPLAYER_ADDON_SCENE_OPENDIALOG = class(TObject)
    procedure OnClose(Sender: TObject);
    procedure OnShow(Sender: TObject);
  end;

type
  TSOUNDPLAYER_ADDON_SCENE_FIRST_MAIN = record
    Panel: Tpanel;
    Line_1: TALText;
    Line_2: TALText;
    Line_3: TALText;
    Line_4: TALText;
    Check: TCheckBox;
    Done: TButton;
  end;

type
  TSOUNDPLAYER_ADDON_SCENE_FIRST = record
    Panel: Tpanel;
    Panel_Shadow: TShadowEffect;
    Main: TSOUNDPLAYER_ADDON_SCENE_FIRST_MAIN;
  end;

type
  TSOUNDPLAYER_ADDON_SCENE = record
    Soundplayer: TImage;
    Soundplayer_Ani: TFloatAnimation;
    Back: TImage;
    Back_Blur: TGaussianBlurEffect;
    Back_Player: TImage;
    UpLine: TImage;
    Back_Info: TImage;
    MiddleLine: TImage;
    PlaylistLine: TImage;
    Back_Playlist: TImage;
    DownLine: TImage;
    Dialog: TSOUNDPLAYER_ADDON_SCENE_OPENDIALOG;
    OpenDialog: TOpenDialog;
    Imglist: TImageList;
    Settings: TImage;
    Settings_Ani: TFloatAnimation;
    Settings_Glow: TGlowEffect;
    First: TSOUNDPLAYER_ADDON_SCENE_FIRST;
  end;

type
  TSOUNDPLAYER_ADDON_PLAYER = record
    Play: TImage;
    Play_Glow: TGlowEffect;
    Play_Grey: TMonochromeEffect;
    Play_Color: TFillRGBEffect;
    Stop: TImage;
    Stop_Glow: TGlowEffect;
    Stop_Grey: TMonochromeEffect;
    Stop_Color: TFillRGBEffect;
    Previous: TImage;
    Previous_Glow: TGlowEffect;
    Previous_Grey: TMonochromeEffect;
    Next: TImage;
    Next_Glow: TGlowEffect;
    Next_Grey: TMonochromeEffect;
    Eject: TImage;
    Eject_Glow: TGlowEffect;
    Loop: TImage;
    Loop_State: TImage;
    Loop_To: TImage;
    Loop_Glow: TGlowEffect;
    Loop_Grey: TMonochromeEffect;
    Song_Title: TText;
    Song_Title_Cover_Left: TRectangle;
    Song_Title_Cover_Right: TRectangle;
    Song_Title_Ani: TFloatAnimation;
    Rate_No: TText;
    Rate: array [0 .. 4] of TImage;
    Rate_Gray: array [0 .. 4] of TMonochromeEffect;
    Song_Pos: TALTrackBar;
    Song_Tag: TImage;
    Song_Tag_Glow: TGlowEffect;
    Song_Time: TText;
    Song_PlayTime: TText;
    Suffle: TImage;
    Suffle_Glow: TGlowEffect;
    Suffle_Grey: TMonochromeEffect;
    Suffle_Color: TFillRGBEffect;
    Speaker_Left: TImage;
    Speaker_Left_Hue: THueAdjustEffect;
    Speaker_Left_Percent: TText;
    Speaker_Left_Percent_Ani: TFloatAnimation;
    Speaker_Left_Lock_Volume: TImage;
    Speaker_Left_Lock_Volume_Glow: TGlowEffect;
    Speaker_Left_Volume_Pos: TALTrackBar;
    Speaker_Right: TImage;
    Speaker_Right_Hue: THueAdjustEffect;
    Speaker_Right_Percent: TText;
    Speaker_Right_Percent_Ani: TFloatAnimation;
    Speaker_Right_Lock_Volume: TImage;
    Speaker_Right_Lock_Volume_Glow: TGlowEffect;
    Speaker_Right_Volume_Pos: TALTrackBar;
  end;

type
  TSOUNDPLAYER_ADDON_INFO = record
    Back_Left: TImage;
    Back_Left_Ani: TFloatAnimation;
    Song: TText;
    Song_Title: TText;
    Artist: TText;
    Artist_Name: TText;
    Year: TText;
    Year_Publish: TText;
    Gerne: TText;
    Gerne_Kind: TText;
    Track: TText;
    Track_Num: TText;
    Playlist: TText;
    Playlist_Name: TText;
    Playlist_Type: TText;
    Playlist_Type_Kind: TText;
    Total: TText;
    Total_Songs: TText;
    Time: TText;
    Time_Total: TText;
    Back_Right: TImage;
    Back_Right_Ani: TFloatAnimation;
    Cover: TImage;
    Cover_Fade_Ani: TFloatAnimation;
    Cover_Fullscreen: TImage;
    Cover_Fullscreen_Glow: TGlowEffect;
    Cover_Fullscreen_Ani_Width: TFloatAnimation;
    Cover_Fullscreen_Ani_Height: TFloatAnimation;
    Cover_Fullscreen_Ani_Pos_X: TFloatAnimation;
    Cover_Fullscreen_Ani_Pos_Y: TFloatAnimation;
  end;

type
  TSOUNDPLAYER_ADDON_PLAYLIST_MANAGE_MAIN = record
    Panel: Tpanel;
    Grid: TStringGrid;
    Edit: TImage;
    Edit_Glow: TGlowEffect;
    Up: TImage;
    Up_Glow: TGlowEffect;
    Up_Grey: TMonochromeEffect;
    Down: TImage;
    Down_Glow: TGlowEffect;
    Down_Grey: TMonochromeEffect;
    Merge: TImage;
    Merge_Glow: TGlowEffect;
    Merge_Grey: TMonochromeEffect;
    Split: TImage;
    Split_Glow: TGlowEffect;
    Split_Grey: TMonochromeEffect;
    Load: TButton;
    Cancel: TButton;

  end;

type
  TSOUNDPLAYER_ADDON_PLAYLIST_MANAGE = record
    Panel: Tpanel;
    Main: TSOUNDPLAYER_ADDON_PLAYLIST_MANAGE_MAIN;
  end;

type
  TSOUNDPLAYER_ADDON_PLAYLIST_CREATE_MAIN = record
    Panel: Tpanel;
    Text: TLabel;
    Edit: TEdit;
    Text_Type: TLabel;
    Main_Type: TComboBox;
    Create: TButton;
    Cancel: TButton;
  end;

type
  TSOUNDPLAYER_ADDON_PLAYLIST_CREATE = record
    Panel: Tpanel;
    Main: TSOUNDPLAYER_ADDON_PLAYLIST_CREATE_MAIN;
  end;

type
  TSOUNDPLAYER_ADDON_PLAYLIST_REMOVE_MAIN = record
    Panel: Tpanel;
    Icon: TImage;
    Line_1: TLabel;
    Line_2: TLabel;
    Remove: TButton;
    Cancel: TButton;
  end;

type
  TSOUNDPLAYER_ADDON_PLAYLIST_REMOVE = record
    Panel: Tpanel;
    Main: TSOUNDPLAYER_ADDON_PLAYLIST_REMOVE_MAIN;
  end;

type
  TSOUNDPLAYER_ADDON_PLAYLIST_SONGS_EDIT = record
    Lock: TImage;
    Lock_Glow: TGlowEffect;
    Edit: TImage;
    Edit_Glow: TGlowEffect;
    Edit_Grey: TMonochromeEffect;
    Up: TImage;
    Up_Glow: TGlowEffect;
    Up_Grey: TMonochromeEffect;
    Down: TImage;
    Down_Glow: TGlowEffect;
    Down_Grey: TMonochromeEffect;
    Delete: TImage;
    Delete_Glow: TGlowEffect;
    Delete_Grey: TMonochromeEffect;
  end;

type
  TSOUNDPLAYER_ADDON_PLAYLIST_REMOVE_SONG_MAIN = record
    Panel: Tpanel;
    Icon: TImage;
    Text: TLabel;
    Erase: TButton;
    Cancel: TButton;
  end;

type
  TSOUNDPLAYER_ADDON_PLAYLIST_REMOVE_SONG = record
    Remove: Tpanel;
    Main: TSOUNDPLAYER_ADDON_PLAYLIST_REMOVE_SONG_MAIN;
  end;

type
  TSOUNDPLAYER_ADDON_PLAYLIST = record
    List: TStringGrid;
    List_Popup_Memu: TPopupMenu;
    List_Line_Edit_Left: TImage;
    List_Line_Edit_Right: TImage;
    Songs_Edit: TSOUNDPLAYER_ADDON_PLAYLIST_SONGS_EDIT;
    Manage_Icon: TImage;
    Manage_Icon_Glow: TGlowEffect;
    Manage_Icon_Grey: TMonochromeEffect;
    Manage: TSOUNDPLAYER_ADDON_PLAYLIST_MANAGE;
    Create_Icon: TImage;
    Create_Icon_Glow: TGlowEffect;
    Create: TSOUNDPLAYER_ADDON_PLAYLIST_CREATE;
    Remove_Icon: TImage;
    Remove_Icon_Glow: TGlowEffect;
    Remove_Icon_Grey: TMonochromeEffect;
    Remove: TSOUNDPLAYER_ADDON_PLAYLIST_REMOVE;
    Remove_Song: TSOUNDPLAYER_ADDON_PLAYLIST_REMOVE_SONG;
  end;

type
  TSOUNDPLAYER_ADDON_TIMER_ONTIMER = class(TObject)
    procedure OnTimer(Sender: TObject);
  end;

type
  TSOUNDPLAYER_ADDON_TIMER = record
    Timer: TSOUNDPLAYER_ADDON_TIMER_ONTIMER;
    Song: TTimer;
  end;

type
  TSOUNDPLAYER_ADDON_CONFIG_MAIN = record
    Panel: Tpanel;

  end;

type
  TSOUNDPLAYER_ADDON_CONFIG = record
    Panel: Tpanel;
    Main: TSOUNDPLAYER_ADDON_CONFIG_MAIN;
  end;

type
  TSOUNDPLAYER_ADDON_TAGS_MP3_ID3v1 = record
    Title: TLabel;
    Title_V: TEdit;
    Title_Differ: TImage;
    Artist: TLabel;
    Artist_V: TEdit;
    Artist_Differ: TImage;
    Album: TLabel;
    Album_V: TEdit;
    Album_Differ: TImage;
    Year: TLabel;
    Year_V: TEdit;
    Year_Differ: TImage;
    Genre: TLabel;
    Genre_V: TComboEdit;
    Genre_Differ: TImage;
    Track: TLabel;
    Track_V: TEdit;
    Track_Differ: TImage;
    Comment: TLabel;
    Comment_V: TEdit;
    Comment_Differ: TImage;
    Transfer: TText;
  end;

type
  TSOUNDPLAYER_ADDON_TAGS_MP3_ID3v2 = record
    Title: TLabel;
    Title_V: TEdit;
    Title_Differ: TImage;
    Artist: TLabel;
    Artist_V: TEdit;
    Artist_Differ: TImage;
    Album: TLabel;
    Album_V: TEdit;
    Album_Differ: TImage;
    Year: TLabel;
    Year_V: TEdit;
    Year_Differ: TImage;
    Genre: TLabel;
    Genre_V: TComboEdit;
    Genre_Differ: TImage;
    Track: TLabel;
    Track_V: TEdit;
    Track_Differ: TImage;
    Comment: TLabel;
    Comment_V: TEdit;
    Comment_Differ: TImage;
    Transfer: TText;
    Rate_Label: TLabel;
    Rate: array [0 .. 4] of TImage;
    Rate_Glow: array [0 .. 4] of TGlowEffect;
    Rate_Dot: array [0 .. 4] of TCircle;
    Covers: TGroupBox;
    Cover: TImage;
    Cover_Label: TLabel;
    Cover_ArrowLeft: TImage;
    Cover_ArrowLeft_Glow: TGlowEffect;
    Cover_ArrowLeft_Grey: TMonochromeEffect;
    Cover_ArrowRight: TImage;
    Cover_ArrowRight_Glow: TGlowEffect;
    Cover_ArrowRight_Grey: TMonochromeEffect;
    Cover_Num: TLabel;
    Cover_Add_Computer: TImage;
    Cover_Add_Computer_Glow: TGlowEffect;
    Cover_Add_Internet: TImage;
    Cover_Add_Internet_Glow: TGlowEffect;
    Cover_Remove: TImage;
    Cover_Remove_Glow: TGlowEffect;
    Cover_Remove_Grey: TMonochromeEffect;
    Lyrics: TGroupBox;
    Lyrics_Memo: TMemo;
    Lyrics_Add_Computer: TImage;
    Lyrics_Add_Computer_Glow: TGlowEffect;
    Lyrics_Add_Internet: TImage;
    Lyrics_Add_Internet_Glow: TGlowEffect;
    Lyrics_Remove: TImage;
    Lyrics_Remove_Glow: TGlowEffect;
    Lyrics_Remove_Grey: TMonochromeEffect;
  end;

type
  TSOUNDPLAYER_ADDON_TAGS_MP3_ID3V2_COVER_SELECT = record
    Panel: Tpanel;
    Main: Tpanel;
    List: TListBox;
    Load: TButton;
    Cancel: TButton;
  end;

type
  TSOUNDPLAYER_ADDON_TAGS_MP3_ID3V2_LYRICS_ADD = record
    Panel: Tpanel;
    Main: Tpanel;
    Radio_Above: TRadioButton;
    Radio_Clear: TRadioButton;
    Add: TButton;
    Cancel: TButton;
  end;

type
  TSOUNDPLAYER_ADDON_TAGS_MP3 = record
    Back: Tpanel;
    Back_Blur: TGaussianBlurEffect;
    Logo: TImage;
    Button_Save: TButton;
    Button_Cancel: TButton;
    TabControl: TTabControl;
    TabItem: array [0 .. 1] of TTabItem;
    ID3v1: TSOUNDPLAYER_ADDON_TAGS_MP3_ID3v1;
    ID3v2: TSOUNDPLAYER_ADDON_TAGS_MP3_ID3v2;
    Cover_Select: TSOUNDPLAYER_ADDON_TAGS_MP3_ID3V2_COVER_SELECT;
    Lyrics_Add: TSOUNDPLAYER_ADDON_TAGS_MP3_ID3V2_LYRICS_ADD;
  end;

type
  TSOUNDPLAYER_ADDON_TAGS_APE = record

  end;

type
  TSOUNDPLAYER_ADDON_TAGS_FLAC = record

  end;

type
  TSOUNDPLAYER_ADDON_TAGS_MP4 = record

  end;

type
  TSOUNDPLAYER_ADDON_TAGS_OPUS = record
    Back: Tpanel;
    Back_Blur: TGaussianBlurEffect;
    Logo: TImage;
    Button_Save: TButton;
    Button_Cancel: TButton;
    Title: TLabel;
    Title_V: TEdit;
    Artist: TLabel;
    Artist_V: TEdit;
    Album: TLabel;
    Album_V: TEdit;
    Genre: TLabel;
    Genre_V: TComboEdit;
    Date: TLabel;
    Date_V: TEdit;
    Track: TLabel;
    Track_V: TEdit;
    Disk: TLabel;
    Disk_V: TEdit;
    Comment: TLabel;
    Comment_V: TEdit;
    CoverBox: TGroupBox;
    Cover_Label: TLabel;
    Cover: TImage;
    Cover_LoadFromComputer: TImage;
    Cover_LoadFromComputer_Glow: TGlowEffect;
    Cover_LoadFromInterent: TImage;
    Cover_LoadFromInterent_Glow: TGlowEffect;
    Cover_Delete: TImage;
    Cover_Delete_Glow: TGlowEffect;
    Cover_Delete_Grey: TMonochromeEffect;
  end;

type
  TSOUNDPLAYER_ADDON_TAGS_WMA = record

  end;

type
  TSOUNDPLAYER_ADDON_TAGS = record
    mp3: TSOUNDPLAYER_ADDON_TAGS_MP3;
    ape: TSOUNDPLAYER_ADDON_TAGS_APE;
    flac: TSOUNDPLAYER_ADDON_TAGS_FLAC;
    mp4: TSOUNDPLAYER_ADDON_TAGS_MP4;
    Opus: TSOUNDPLAYER_ADDON_TAGS_OPUS;
    wma: TSOUNDPLAYER_ADDON_TAGS_WMA;
  end;

type
  TSOUNDPLAYER_ADDON = record
    scene: TSOUNDPLAYER_ADDON_SCENE;
    Player: TSOUNDPLAYER_ADDON_PLAYER;
    Info: TSOUNDPLAYER_ADDON_INFO;
    Playlist: TSOUNDPLAYER_ADDON_PLAYLIST;
    Timer: TSOUNDPLAYER_ADDON_TIMER;
    Tag: TSOUNDPLAYER_ADDON_TAGS;
    config: TSOUNDPLAYER_ADDON_CONFIG;
    Ani: TSOUNDPLAYER_ADDON_FLOATANIMATION;
  end;

var
  vSoundplayer: TSOUNDPLAYER_ADDON;

implementation

uses
  uLoad_AllTypes,
  uSoundplayer_Info_Actions,
  uSoundplayer_Player_Actions,
  uSoundplayer_Tag_Mp3,
  uSoundplayer_Tag_Ogg;

{ TSOUNDPLAYER_ADDON_TIMER_ONTIMER }

procedure TSOUNDPLAYER_ADDON_TIMER_ONTIMER.OnTimer(Sender: TObject);
begin
  if TTimer(Sender).Name = 'A_SP_Timer_Song' then
    uSoundplayer_Player_Actions.Refresh;
end;

{ TSOUNDPLAYER_ADDON_SCENE_OPENDIALOG }
procedure TSOUNDPLAYER_ADDON_SCENE_OPENDIALOG.OnClose(Sender: TObject);
begin
  if TOpenDialog(Sender).Name = 'A_SP_OpenDialog_AddSongs' then
    uSoundPlayer_Player_Actions_AddNewSongs
  else if TOpenDialog(Sender).Name = 'A_SP_OpenDialog_Cover_AddComputer' then
    uSoundplayer_Tag_Mp3_Cover_Select
  else if TOpenDialog(Sender).Name = 'A_SP_OpenDialog_Lyrics_AddComputer' then
    uSoundplayer_Tag_Mp3_Lyrics_Add
  else if TOpenDialog(Sender).Name = 'A_SP_OpenDialog_Ogg_Cover_AddComputer' then
    uSoundplayer_Tag_Ogg_Cover_Select;
end;

procedure TSOUNDPLAYER_ADDON_SCENE_OPENDIALOG.OnShow(Sender: TObject);
begin
  vSoundplayer.scene.OpenDialog.FileName := '';
  if TOpenDialog(Sender).Name = 'A_SP_OpenDialog_AddSongs' then
    vSoundplayer.scene.OpenDialog.Filter := 'mp3 files (*.mp3)|*.mp3|ogg files(*.ogg)|*.ogg'
  else if TOpenDialog(Sender).Name = 'A_SP_OpenDialog_Mp3_Cover_AddComputer' then
    vSoundplayer.scene.OpenDialog.Filter :=
      'All supported images (*.png , *.jpg , *.jpeg , *.bmp)|*.png; *.jpg; *.jpeg; *.bmp|png files (*.png)|*.png|jpeg files(*.jpeg, *.jpg)|*.jpeg;*.jpg |bitmap files(*.bmp)|*.bmp'
  else if TOpenDialog(Sender).Name = 'A_SP_OpenDialog_Mp3_Lyrics_AddComputer' then
    vSoundplayer.scene.OpenDialog.Filter := 'txt files (*.txt)|*.txt'
  else if TOpenDialog(Sender).Name = 'A_SP_OpenDialog_Ogg_Cover_AddComputer' then
    vSoundplayer.scene.OpenDialog.Filter :=
      'All supported images (*.png , *.jpg , *.jpeg , *.bmp)|*.png; *.jpg; *.jpeg; *.bmp|png files (*.png)|*.png|jpeg files(*.jpeg, *.jpg)|*.jpeg;*.jpg |bitmap files(*.bmp)|*.bmp'
end;

{ TSOUNDPLAYER_ADDON_FLOATANIMATION }
procedure TSOUNDPLAYER_ADDON_FLOATANIMATION.OnFinish(Sender: TObject);
begin
  TFloatAnimation(Sender).Enabled := False;
  if addons.Soundplayer.Info.isCoverInFullscreen then
  begin
    if TFloatAnimation(Sender).Name = 'A_SP_Info_Cover_Fullscreen_Animation_Height' then
      uSoundplayer_Info_Actions_ShowCoverFullscreen;
  end
  else
  begin
    if TFloatAnimation(Sender).Name = 'A_SP_Info_Cover_Fullscreen_Animation_Height' then
      uSoundplayer_Info_Actions_ShowCoverExitFullscreen;
  end;
  if TFloatAnimation(Sender).Name = 'A_SP_Player_Song_Title_Animation' then
  begin
    if addons.Soundplayer.Player.Title_Ani then
      addons.Soundplayer.Player.Title_Ani_Left := not addons.Soundplayer.Player.Title_Ani_Left;
    uSoundplayer_Player_Actions_Title_Animation;
  end;
end;

initialization

vSoundplayer.Ani := TSOUNDPLAYER_ADDON_FLOATANIMATION.Create;
vSoundplayer.scene.Dialog := TSOUNDPLAYER_ADDON_SCENE_OPENDIALOG.Create;
vSoundplayer.Timer.Timer := TSOUNDPLAYER_ADDON_TIMER_ONTIMER.Create;

finalization

vSoundplayer.Ani.Free;
vSoundplayer.scene.Dialog.Free;
vSoundplayer.Timer.Timer.Free;

end.
