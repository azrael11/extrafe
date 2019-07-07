unit uLoad;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UIConsts,
  System.UiTypes,
  IniFiles,
  Winapi.Windows,
  FMX.Forms,
  FMX.Objects,
  FMX.Effects,
  FMX.Dialogs,
  FMX.Controls,
  FMX.Types,
  FMX.Layouts,
  FMX.Ani,
  ALFmxTabControl,
  FmxPasLibVlcPlayerUnit,
  BASS;

procedure uLoad_StartLoading;
procedure uLoad_SetDefaults;
procedure uLoad_FirstTimeLoading;
procedure uLoad_SetLoadingScreen;

procedure uLoad_Start_ExtraFE;
procedure Play_Intro_Video;
procedure Skip_Intro;
procedure IsDatabaseInternet;

var

  Default_Load: Boolean;
  KBHook: HHook;

implementation

uses
  uWindows,
  uKeyboard,
  loading,
  main,
  uMain_AllTypes,
  uMain_Config_Themes,
  uMain_Emulation,
  uWeather_SetAll,
  uLoad_SetAll,
  uLoad_AllTypes,
  uLoad_Login,
  uLoad_Addons,
  uLoad_Emulation,
  uLoad_Sound,
  uLoad_Stats,
  uDatabase;

procedure uLoad_StartLoading;
const
  res_4_3: array [0 .. 10] of string = ('640x480', '800x600', '1024x768', '1152x864', '1280x960', '1400x1050', '1600x1200', '2048x1536', '3200x2400',
    '4000x3000', '6400x4800');
  res_16_9: array [0 .. 4] of string = ('852x480', '1280x720', '1365x768', '1600x900', '1920x1080');
  res_16_10: array [0 .. 5] of string = ('1440x900', '1680x1050', '1920x1200', '2560x1600', '3840x2400', '7680x4800');
begin
  vMonitor_Resolution := uWindows_GetCurrent_Monitor_Resolution;
  Loading_Form.Width := vMonitor_Resolution.Horizontal;
  Loading_Form.Height := vMonitor_Resolution.Vertical;
  Loading_Form.FullScreen := True;
  // Program
  extrafe.prog.Path := ExtractFilePath(ParamStr(0));
  extrafe.prog.Name := ExtractFileName(ParamStr(0));

  extrafe.prog.Paths.Lib := extrafe.prog.Path + 'lib\';
  extrafe.ini.Path := extrafe.prog.Path + 'config\';
  extrafe.ini.Name := 'config.ini';

  uDatabase_Create;
  uLoad_Start_ExtraFE;
  // ex_load.Scene.Back.Visible := True;
  Play_Intro_Video;
end;

procedure uLoad_SetDefaults;
begin
  // Loading Program Defaults
  // program consts
  extrafe.prog.Version.Major := uWindows_GetVersionInfo(extrafe.prog.Path + extrafe.prog.Name).Strings[0];
  extrafe.prog.Version.Minor := uWindows_GetVersionInfo(extrafe.prog.Path + extrafe.prog.Name).Strings[1];
  extrafe.prog.Version.Realeash := uWindows_GetVersionInfo(extrafe.prog.Path + extrafe.prog.Name).Strings[2];
  extrafe.prog.Version.Build := uWindows_GetVersionInfo(extrafe.prog.Path + extrafe.prog.Name).Strings[3];
  extrafe.prog.Desc := 'Code name: Mnimi';
  extrafe.prog.Paths.History := extrafe.ini.Path + 'history\';
  extrafe.prog.Paths.Fonts := extrafe.ini.Path + 'fonts\';
  extrafe.prog.Virtual_Keyboard := extrafe.ini.ini.ReadBool('Visual', 'Virtual_Keyboard', extrafe.prog.Virtual_Keyboard);

  ex_main.Paths.Flags_Images := extrafe.prog.Path + 'data\main\flags\';
  ex_main.Paths.Avatar_Images := extrafe.prog.Path + 'data\main\avatars\';
  ex_main.Paths.Images := extrafe.prog.Path + 'data\main\images\';
  ex_main.Paths.Config_Images := extrafe.prog.Path + 'data\main\config_images\';
  ex_main.Paths.Sounds := extrafe.prog.Path + 'data\main\sounds\';

  // program graphics
  extrafe.res.Width := extrafe.ini.ini.ReadInteger('General_Graphics', 'Res_X', extrafe.res.Width);
  extrafe.res.Half_Width := extrafe.res.Width div 2;
  extrafe.res.Height := extrafe.ini.ini.ReadInteger('General_Graphics', 'Res_Y', extrafe.res.Height);
  extrafe.res.Half_Height := extrafe.res.Height div 2;
  extrafe.res.FullScreen := extrafe.ini.ini.ReadBool('General_Graphics', 'Fullscreen', extrafe.res.FullScreen);

  // program styles
  extrafe.style.Path := extrafe.ini.ini.ReadString('Themes', 'Path', extrafe.style.Path);
  extrafe.style.Name := extrafe.ini.ini.ReadString('Themes', 'Name', extrafe.style.Name);
  extrafe.style.Num := extrafe.ini.ini.ReadInteger('Themes', 'Number', extrafe.style.Num);

  mainScene.main.style := TStyleBook.Create(Main_Form);
  mainScene.main.style.Name := 'Main_StyleBook';
  mainScene.main.style.Parent := Main_Form;

  // Main Style
  extrafe.style.Name := extrafe.ini.ini.ReadString('Themes', 'Name', extrafe.style.Name);
  if extrafe.style.Name <> '' then
    uMain_Config_Themes_ApplyTheme(extrafe.style.Name);

  Loading_Form.StyleBook := mainScene.main.style;

  // program Loading Defaults
  ex_load.Path.Images := extrafe.prog.Path + 'data\loading\';

  // Emulators
  uLoad_Emulation_LoadDefaults;

  // Addons
  uLoad_Addons_LoadDefaults;
end;

procedure uLoad_FirstTimeLoading;
begin
  if not FileExists(extrafe.ini.Path + extrafe.ini.Name) then
  begin
    CreateDir(extrafe.prog.Path + 'config');
    CreateDir(extrafe.prog.Path + 'config\fonts');
    CreateDir(extrafe.prog.Path + 'config\history');

    extrafe.ini.ini := TIniFile.Create(extrafe.ini.Path + extrafe.ini.Name);

    // General Graphics
    extrafe.ini.ini.WriteInteger('General_Graphics', 'Res_X', 1920);
    extrafe.ini.ini.WriteInteger('General_Graphics', 'Res_Y', 1080);
    extrafe.ini.ini.WriteBool('General_Graphics', 'Fullscreen', True);
    // Visual
    extrafe.ini.ini.WriteBool('Visual', 'Virtual_Keyoard', True);
    extrafe.prog.Virtual_Keyboard := True;

    // User
    extrafe.ini.ini.WriteInteger('Users', 'Active', -1);
    extrafe.users_active := -1;
    extrafe.ini.ini.WriteInteger('Users', 'Total', -1);
    extrafe.users_total := -1;
    // Themes
    extrafe.ini.ini.WriteString('Themes', 'Path', extrafe.prog.Path + 'data\themes\');
    extrafe.ini.ini.WriteInteger('Themes', 'Number', 20);
    extrafe.ini.ini.WriteString('Themes', 'Name', 'Air');
    // Volume Master
    extrafe.ini.ini.WriteString('Volume', 'Master', '1');
    addons.soundplayer.Volume.Master := 1;

    // Emulators
    uLoad_Emulation_FirstTime;
    // Addons
    uLoad_Addons_FirstTime;
    // Statistics
    uLoad_Stats_FirstTime;
  end
  else
  begin
    extrafe.ini.ini := TIniFile.Create(extrafe.ini.Path + extrafe.ini.Name);
  end;
end;

procedure uLoad_SetLoadingScreen;
begin
  uKeyboard_HookKeyboard;
  FHook.Active := True;
  uLoad_SetAll_Load;
end;

/// /////////////////////////////////////////////////////////////////////////////

/// /////////////////////////////////////////////////////////////////////////////
procedure uLoad_Start_ExtraFE;
begin
  if Default_Load = False then
  begin
    extrafe.prog.State := 'loading';
    uLoad_FirstTimeLoading;
    uLoad_SetDefaults;
    uLoad_Sound_StartSoundSystem;
    uLoad_Sound_LoadSounds;
    uLoad_SetLoadingScreen;
    extrafe.user_login := False;
    extrafe.users_active := -1;
    IsDatabaseInternet;
    Default_Load := True;
  end
  else
  begin
    if (emulation.Active = False) and (addons.Active = False) then
    begin
      ex_load.Scene.Progress.Value := 100;
    end
    else
    begin
      uLoad_Emulation_Load;
      uLoad_Addons_Load;
    end;
    ex_load.Scene.Back_Fade.Start;
  end;
end;

procedure IsDatabaseInternet;
begin
  if uWindows_IsConected_ToInternet then
  begin
    ex_load.Login.Internet.Text := 'Connected';
    if uDatabase_Connect then
    begin
      ex_load.Login.Database.Text := 'Connected';
      extrafe.database_is_connected := True;
    end
    else
    begin
      ex_load.Login.Data_Icon.TextSettings.FontColor := TAlphaColorRec.Red;
      ex_load.Login.Database.Text := 'Not Connected';
      extrafe.database_is_connected := False;
    end;
  end
  else
  begin
    ex_load.Login.Int_Icon.TextSettings.FontColor := TAlphaColorRec.Red;
    ex_load.Login.Internet.Text := 'Not Connected';
    extrafe.database_is_connected := False;
    ex_load.Login.Data_Icon.TextSettings.FontColor := TAlphaColorRec.Red;
    ex_load.Login.Database.Text := 'Not Connected';
    extrafe.database_is_connected := False;
  end;
end;

procedure Play_Intro_Video;
begin
  ex_load.Intro.Back := TLayout.Create(Loading_Form);
  ex_load.Intro.Back.Name := 'Loading_Intro_Back';
  ex_load.Intro.Back.Parent := Loading_Form;
  ex_load.Intro.Back.Align := TAlignLayout.Client;
  ex_load.Intro.Back.Cursor := crDefault;
  ex_load.Intro.Back.Visible := True;

  ex_load.Intro.Video := TFmxPasLibVlcPlayer.Create(ex_load.Intro.Back);
  ex_load.Intro.Video.Name := 'Loading_Intro';
  ex_load.Intro.Video.Parent := ex_load.Intro.Back;
  ex_load.Intro.Video.Align := TAlignLayout.Client;
//  ex_load.Intro.Video.Play(ex_load.Path.Images + 'intro.mp4');
  ex_load.Intro.Video.WrapMode := TImageWrapMode.Stretch;
  ex_load.Intro.Video.Cursor := crDefault;
  ex_load.Intro.Video.OnMouseMove := ex_load.Input.mouse.Layout.OnMouseMove;
  ex_load.Intro.Video.Visible := True;

  ex_load.Intro.Text := TText.Create(ex_load.Intro.Video);
  ex_load.Intro.Text.Name := 'Loading_Intro_Text';
  ex_load.Intro.Text.Parent := ex_load.Intro.Video;
  ex_load.Intro.Text.SetBounds(extrafe.res.Width - 310, 10, 300, 30);
  ex_load.Intro.Text.Font.Family := 'IcoMoon-Free';
  ex_load.Intro.Text.Text := 'Skip Video ' + #$ea14;
  ex_load.Intro.Text.TextSettings.FontColor := TAlphaColorRec.White;
  ex_load.Intro.Text.TextSettings.Font.Size := 24;
  ex_load.Intro.Text.Opacity := 1;
  ex_load.Intro.Text.TextSettings.HorzAlign := TTextAlign.Trailing;
  ex_load.Intro.Text.OnClick := ex_load.Input.mouse.Text.OnMouseClick;
  ex_load.Intro.Text.OnMouseEnter := ex_load.Input.mouse.Text.OnMouseEnter;
  ex_load.Intro.Text.OnMouseLeave := ex_load.Input.mouse.Text.OnMouseLeave;
  ex_load.Intro.Text.Visible := True;

  ex_load.Intro.Text_Ani := TFloatAnimation.Create(ex_load.Intro.Text);
  ex_load.Intro.Text_Ani.Name := 'Loading_Intro_Text_Ani';
  ex_load.Intro.Text_Ani.Parent := ex_load.Intro.Text;
  ex_load.Intro.Text_Ani.Duration := 0.3;
  ex_load.Intro.Text_Ani.StopValue := 0;
  ex_load.Intro.Text_Ani.PropertyName := 'Opacity';
  ex_load.Intro.Text_Ani.Enabled := False;

  ex_load.Intro.Timer := TTimer.Create(Loading_Form);
  ex_load.Intro.Timer.Name := 'Loading_Intro_Timer';
  ex_load.Intro.Timer.Parent := Loading_Form;
  ex_load.Intro.Timer.Interval := 1;
  ex_load.Intro.Timer.OnTimer := ex_load.Scene.Timer_Pros.OnTimer;
  ex_load.Intro.Timer.Enabled := True;

  ex_load.Intro.Fade_Count := 0;
end;

procedure Skip_Intro;
begin
  ex_load.Intro.Video.Stop;
  FreeAndNil(ex_load.Intro.Back);
  ex_load.Intro.Timer.Enabled := False;
  ex_load.Scene.Back.Visible := True;
end;

end.
