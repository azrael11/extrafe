unit uLoad;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  IniFiles,
  Winapi.Windows,
  FMX.Objects,
  FMX.Controls,
  FMX.Types,
  FMX.Layouts,
  FMX.Ani,
  FmxPasLibVlcPlayerUnit;

procedure Load_Consts;
procedure Load_First_User_Settings;
procedure Load_Default_Settings;

procedure Prepare;
procedure SetLoadingScreen;

procedure Start_ExtraFE;
procedure Play_Intro_Video;
procedure Skip_Intro;

var
  Default_Load: Boolean;
  KBHook: HHook;

implementation

uses
  uWindows,
  uKeyboard,
  load,
  main,
  uMain,
  uMain_AllTypes,
  uMain_Config_Themes,
  uLoad_SetAll,
  uLoad_AllTypes,
  uLoad_Addons,
  uLoad_Emulation,
  uLoad_Sound,
  uLoad_Stats,
  uDatabase,
  uDatabase_ActiveUser,
  uDatabase_SQLCommands;

procedure Load_Consts;
begin
  { Version }
  extrafe.prog.Version.Major := uWindows_GetVersionInfo(extrafe.prog.Path + extrafe.prog.Name).Strings[0];
  extrafe.prog.Version.Minor := uWindows_GetVersionInfo(extrafe.prog.Path + extrafe.prog.Name).Strings[1];
  extrafe.prog.Version.Realeash := uWindows_GetVersionInfo(extrafe.prog.Path + extrafe.prog.Name).Strings[2];
  extrafe.prog.Version.Build := uWindows_GetVersionInfo(extrafe.prog.Path + extrafe.prog.Name).Strings[3];
  { Code Name }
  extrafe.prog.Desc := 'Code name: Mnimi';
  { Virtual Keybord show }
  extrafe.prog.Virtual_Keyboard := False;
  { Main Defaults }
  ex_main.Paths.Flags_Images := extrafe.prog.Path + 'data\main\flags\';
  ex_main.Paths.Avatar_Images := extrafe.prog.Path + 'data\main\avatars\';
  ex_main.Paths.Images := extrafe.prog.Path + 'data\main\images\';
  ex_main.Paths.Config_Images := extrafe.prog.Path + 'data\main\config_images\';
  ex_main.Paths.Sounds := extrafe.prog.Path + 'data\main\sounds\';

end;

procedure Load_First_User_Settings;
begin
  extrafe.res.Width := uDatabase_SQLCommands.Get_Local_Query('RESOLUTION_WIDTH', 'SETTINGS', '1').ToInteger;
  extrafe.res.Height := uDatabase_SQLCommands.Get_Local_Query('RESOLUTION_HEIGHT', 'SETTINGS', '1').ToInteger;
  extrafe.res.Half_Width := extrafe.res.Width div 2;
  extrafe.res.Half_Height := extrafe.res.Height div 2;
  extrafe.res.Fullscreen := uDatabase_SQLCommands.Get_Local_Query('FOULSCREEN', 'SETTINGS', '1').ToBoolean;
  if extrafe.res.Width <> extrafe.res.Monitor.Horizontal then
  begin

  end;

  load.Loading.Width := extrafe.res.Width;
  load.Loading.Height := extrafe.res.Height;
  load.Loading.Fullscreen := extrafe.res.Fullscreen;

  extrafe.prog.Path := uDatabase_SQLCommands.Get_Local_Query('PATH', 'SETTINGS', '1');
  extrafe.prog.Name := uDatabase_SQLCommands.Get_Local_Query('NAME', 'SETTINGS', '1');
  extrafe.prog.Lib_Path := uDatabase_SQLCommands.Get_Local_Query('PATH_LIB', 'SETTINGS', '1');
  extrafe.prog.History_Path := uDatabase_SQLCommands.Get_Local_Query('PATH_HISTORY', 'SETTINGS', '1');
  extrafe.prog.Fonts_Path := uDatabase_SQLCommands.Get_Local_Query('PATH_FONTS', 'SETTINGS', '1');

  extrafe.style.Path := uDatabase_SQLCommands.Get_Local_Query('THEME_PATH', 'SETTINGS', '1');
  extrafe.style.Name := uDatabase_SQLCommands.Get_Local_Query('THEME_NAME', 'SETTINGS', '1');
  extrafe.style.Num := uDatabase_SQLCommands.Get_Local_Query('THEME_NUM', 'SETTINGS', '1').ToInteger;

  emulation.Path := uDatabase_SQLCommands.Get_Local_Query('PATH', 'EMULATORS', '1');

  Load_Consts;
end;

procedure Load_Default_Settings;
begin
  extrafe.res.Width := extrafe.res.Monitor.Horizontal;
  extrafe.res.Height := extrafe.res.Monitor.Vertical;
  extrafe.res.Half_Width := extrafe.res.Width div 2;
  extrafe.res.Half_Height := extrafe.res.Height div 2;

  load.Loading.Width := extrafe.res.Width;
  load.Loading.Height := extrafe.res.Height;
  load.Loading.Fullscreen := True;

  extrafe.prog.Path := ExtractFilePath(ParamStr(0));
  extrafe.prog.Name := ExtractFileName(ParamStr(0));

  extrafe.prog.Lib_Path := extrafe.prog.Path + 'lib\';
  extrafe.prog.History_Path := extrafe.prog.Path + 'data\database\history\';
  extrafe.prog.Fonts_Path := extrafe.prog.Path + 'data\main\fonts\';

  extrafe.style.Path := extrafe.prog.Path + 'data\themes\';
  extrafe.style.Name := 'Air';
  extrafe.style.Num := 20;

  Load_Consts;
end;

procedure Prepare;
const
  res_4_3: array [0 .. 8] of string = ('1024x768', '1152x864', '1280x960', '1400x1050', '1600x1200', '2048x1536', '3200x2400', '4000x3000', '6400x4800');
  res_16_9: array [0 .. 7] of string = ('852x480', '1280x720', '1365x768', '1600x900', '1920x1080', '2560x1440', '3840x2160', '4096x2160');
  res_16_10: array [0 .. 5] of string = ('1440x900', '1680x1050', '1920x1200', '2560x1600', '3840x2400', '7680x4800');
begin
  extrafe.users_total := -1;
  uDatabase.Local_Create;
  extrafe.databases.local_connected := uDatabase.Local_Connect;

  ExtraFE_Query_Local.close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Text:= 'SELECT COUNT(*) FROM USERS';
  ExtraFE_Query_Local.Open;
  extrafe.users_total := ExtraFE_Query_Local.Fields[0].AsInteger;

  extrafe.res.Monitor := uWindows.Get_Monitor_Resolution;

  if extrafe.users_total > 0 then
  begin
    Load_First_User_Settings;
    uDatabase_ActiveUser.Get_Local_Data('1');
  end
  else
    Load_Default_Settings;

  uDatabase_SQLCommands.Update_Local_Query('USERS', 'ACTIVE_ONLINE', 'FALSE', '0');
  user_Active_Local.Active := False;
  extrafe.Internet_Active := uWindows_IsConected_ToInternet;
  if extrafe.Internet_Active then
  begin
    uDatabase.Online_Create;
    extrafe.databases.online_connected := uDatabase.Online_Connect;
    if extrafe.databases.online_connected then
    begin
      if extrafe.users_total > 0 then
      begin
        user_Active_Online.Num := uDatabase_ActiveUser.Find_User_Online_Num(user_Active_Local.ID.ToString);
        uDatabase_ActiveUser.Get_Online_Data(user_Active_Online.Num.ToString);
        uDatabase_SQLCommands.Update_Query('USERS', 'ACTIVE', '1', user_Active_Online.Num.ToString);
        user_Active_Online.Active:= 1;
        uDatabase_SQLCommands.Update_Local_Query('USERS', 'ACTIVE_ONLINE', '1', '1');
        user_Active_Local.Active := True;
      end;
    end;
  end;

  mainScene.main.style := TStyleBook.Create(Main_Form);
  mainScene.main.style.Name := 'Main_StyleBook';
  mainScene.main.style.Parent := Main_Form;

  uMain_Config_Themes_ApplyTheme(extrafe.style.Name);
  load.Loading.StyleBook := mainScene.main.style;

  ex_load.Path.Images := extrafe.prog.Path + 'data\loading\';

  Start_ExtraFE;
  Play_Intro_Video;
end;

procedure SetLoadingScreen;
begin
  uKeyboard_HookKeyboard;
  FHook.Active := True;
  uLoad_SetAll_Load;
end;

procedure Start_ExtraFE;
begin
  if Default_Load = False then
  begin
    extrafe.prog.State := 'loading';
    uLoad_Sound.Start_Sound_System;
    SetLoadingScreen;
    extrafe.user_login := False;
    Default_Load := True;
  end
  else
  begin
    uLoad_Emulation.load;
    uLoad_Addons_Load;
    ex_load.Scene.Back_Fade.Start;
    ex_load.Scene.Progress.Value := 100;
    ex_load.Scene.Progress_Text.Text := 'Loading Complete. Accessing the ExtraFE.';
  end;
end;

procedure Play_Intro_Video;
begin
  ex_load.Intro.Back := TLayout.Create(load.Loading);
  ex_load.Intro.Back.Name := 'Loading_Intro_Back';
  ex_load.Intro.Back.Parent := load.Loading;
  ex_load.Intro.Back.Align := TAlignLayout.Client;
  ex_load.Intro.Back.Cursor := crDefault;
  ex_load.Intro.Back.Visible := True;

  ex_load.Intro.Video := TFmxPasLibVlcPlayer.Create(ex_load.Intro.Back);
  ex_load.Intro.Video.Name := 'Loading_Intro';
  ex_load.Intro.Video.Parent := ex_load.Intro.Back;
  ex_load.Intro.Video.Align := TAlignLayout.Client;
  // ex_load.Intro.Video.Play(ex_load.Path.Images + 'intro.mp4');
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

  ex_load.Intro.Timer := TTimer.Create(load.Loading);
  ex_load.Intro.Timer.Name := 'Loading_Intro_Timer';
  ex_load.Intro.Timer.Parent := load.Loading;
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
