unit uEmu_Arcade_Mame_Actions;

interface

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.Zip,
  FMX.Objects,
  FMX.Types,
  FMX.Layouts,
  FMX.Graphics,
  FMX.Effects;

procedure uEmu_Arcade_Mame_Actions_ShowData;

var
  vMameVideoTimer: TTimer;

function uEmu_Arcade_Mame_Actions_LoadGameList(vGameSoundPath: String): TstringList;
procedure uEmu_Arcade_Mame_Actions_PlayGameMusic(vGameSoundPath: String);

procedure uEmu_Arcade_Mame_Actions_ChangeCategeroy(vDirection: String);
procedure uEmu_Arcade_Mame_Actions_ChangeSnapMode;
procedure uEmu_Arcade_Mame_Actions_OpenFilters;
procedure uEmu_Arcade_Mame_Actions_OpenSearch;
procedure uEmu_Arcade_Mame_Actions_CloseTopicSearch;
procedure uEmu_Arcade_Mame_Actions_OpenGlobalConfiguration;

procedure uEmu_Arcade_Mame_Actions_Escape;
procedure uEmu_Arcade_Mame_Actions_Enter;

var
  vMameGameMusicList: TstringList;
  vMame_VK: TImage;
  vMame_Search_Current_Selected: Integer;

implementation

uses
  uDatabase_ActiveUser,
  uDatabase_SQLCommands,
  emu,
  uLoad_AllTypes,
  uEmu_Commands,
  uVirtual_Keyboard,
  uSnippet_Search,
  uEmu_Arcade_Mame,
  uEmu_Arcade_Mame_SetAll,
  uEmu_Arcade_Mame_Gamelist,
  uEmu_Arcade_Mame_Ini,
  uEmu_Arcade_Mame_Filters,
  uEmu_Arcade_Mame_Support_Files,
  uEmu_Arcade_Mame_Game_SetAll,
  uEmu_Arcade_Mame_Config,
  uEmu_Arcade_Mame_AllTypes;

procedure uEmu_Arcade_Mame_Actions_ShowData;
var
  vImageExists: Boolean;
begin
  if mame.Main.SnapCategory = 'Video Snaps' then
  begin
    if mame.Actions.Video_Scene_Show= False then
    begin
      uEmu_Arcade_Mame_SetAll.HideShow_Image_Scene(False);
      uEmu_Arcade_Mame_SetAll.HideShow_Video_Scene(True);
    end;
    mame.Gamelist.Timer.Enabled := False;
    if Assigned(vMameVideoTimer) then
      FreeAndNil(vMameVideoTimer);
    vMame.Scene.Snap.Video.Stop;
    if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Videos + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.mp4') then
    begin
      vMameVideoTimer := TTimer.Create(vMame.Scene.Main);
      vMameVideoTimer.Enabled := True;
      vMameVideoTimer.OnTimer := mame.Timers.Video.OnTimer;
      vMame.Scene.Snap.Video.Visible := True;
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Snapshots + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
      begin
        vMame.Scene.Snap.Video.PlayNormal(user_Active_Local.EMULATORS.Arcade_D.Media.Snapshots + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
      end
    end
    else
    begin
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Snapshots + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
      begin
        vMame.Scene.Snap.Video.PlayNormal(user_Active_Local.EMULATORS.Arcade_D.Media.Snapshots + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
      end
      else
      begin
        vMame.Scene.Snap.Video.PlayNormal(user_Active_Local.EMULATORS.Arcade_D.Media.Snapshots + 'imagenotfound.png');
      end;
    end;
  end
  else
  begin
    if mame.Actions.Video_Scene_Show then
    begin
      uEmu_Arcade_Mame_SetAll.HideShow_Image_Scene(True);
      uEmu_Arcade_Mame_SetAll.HideShow_Video_Scene(False);
      vMame.Scene.Snap.Video.Stop;
    end;
    vImageExists := False;
    vMame.Scene.Snap.Image_Reflaction.Enabled := False;
    if mame.Main.SnapCategory = 'Snapshots' then
    begin
      uEmu_Arcade_Mame_Actions_PlayGameMusic(user_Active_Local.EMULATORS.Arcade_D.Media.Soundtracks + mame.Gamelist.List[0,
        mame.Gamelist.Selected, 0] + '.zip');
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Snapshots + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
      begin
        vMame.Scene.Snap.Image_Fade.Target.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Snapshots + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
        vMame.Scene.Snap.Image_Fade_Ani.Enabled := True;
        vImageExists := True;
      end
    end
    else if mame.Main.SnapCategory = 'Cabinets' then
    begin
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Cabinets + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
      begin
        vMame.Scene.Snap.Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Cabinets + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
        vImageExists := True;
      end
    end
    else if mame.Main.SnapCategory = 'Control Panels' then
    begin
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Control_Panels + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png')
      then
      begin
        vMame.Scene.Snap.Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Control_Panels + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
        vImageExists := True;
      end
    end
    else if mame.Main.SnapCategory = 'Flyers' then
    begin
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Flyers + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
      begin
        vMame.Scene.Snap.Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Flyers + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
        vImageExists := True;
      end
    end
    else if mame.Main.SnapCategory = 'Marquees' then
    begin
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Marquees + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
      begin
        vMame.Scene.Snap.Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Marquees + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
        vImageExists := True;
      end
    end
    else if mame.Main.SnapCategory = 'Pcbs' then
    begin
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Pcbs + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
      begin
        vMame.Scene.Snap.Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Pcbs + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
        vImageExists := True;
      end
    end
    else if mame.Main.SnapCategory = 'Artwork Preview' then
    begin
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Artwork_Preview + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png')
      then
      begin
        vMame.Scene.Snap.Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Artwork_Preview + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
        vImageExists := True;
      end;
    end
    else if mame.Main.SnapCategory = 'Bosses' then
    begin
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Bosses + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
      begin
        vMame.Scene.Snap.Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Bosses + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
        vImageExists := True;
      end
    end
    else if mame.Main.SnapCategory = 'How To' then
    begin
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.How_To + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
      begin
        vMame.Scene.Snap.Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.How_To + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
        vImageExists := True;
      end
    end
    else if mame.Main.SnapCategory = 'Logos' then
    begin
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Logos + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
      begin
        vMame.Scene.Snap.Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Logos + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
        vImageExists := True;
      end
    end
    else if mame.Main.SnapCategory = 'Scores' then
    begin
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Scores + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
      begin
        vMame.Scene.Snap.Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Scores + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
        vImageExists := True;
      end
    end
    else if mame.Main.SnapCategory = 'Selects' then
    begin
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Selects + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
      begin
        vMame.Scene.Snap.Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Selects + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
        vImageExists := True;
      end
    end
    else if mame.Main.SnapCategory = 'Titles' then
    begin
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Titles + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
      begin
        vMame.Scene.Snap.Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Titles + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
        vImageExists := True;
      end
    end
    else if mame.Main.SnapCategory = 'Versus' then
    begin
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Versus + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
      begin
        vMame.Scene.Snap.Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Versus + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
        vImageExists := True;
      end
    end
    else if mame.Main.SnapCategory = 'Game Over' then
    begin
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Game_Over + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
      begin
        vMame.Scene.Snap.Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Game_Over + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
        vImageExists := True;
      end
    end
    else if mame.Main.SnapCategory = 'Ends' then
    begin
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Ends + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
      begin
        vMame.Scene.Snap.Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Ends + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
        vImageExists := True;
      end;
    end
    else if mame.Main.SnapCategory = 'Warnings' then
    begin
      if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Warnings + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
      begin
        vMame.Scene.Snap.Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Warnings + mame.Gamelist.List[0,
          mame.Gamelist.Selected, 0] + '.png');
        vImageExists := True;
      end
    end;

    if vImageExists = False then
      vMame.Scene.Snap.Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Snapshots + 'imagenotfound.png');
  end;

  if mame.Main.SnapCategory = 'Video Snaps' then
  begin
    if mame.Main.SnapMode = 'frame' then
    begin
      if vMame.Scene.Snap.Image.Bitmap.Width > vMame.Scene.Snap.Image.Bitmap.Height then
        vMame.Scene.Snap.Image.SetBounds((vMame.Scene.Right.Width / 2) - 315, 215, 630, 470)
      else
        vMame.Scene.Snap.Image.SetBounds((vMame.Scene.Right.Width / 2) - 235, 55, 470, 630);
    end
  end
  else
  begin
    if vMame.Scene.Snap.Image_Fade.Target.Width > vMame.Scene.Snap.Image_Fade.Target.Height then
      vMame.Scene.Snap.Image.SetBounds((vMame.Scene.Right.Width / 2) - 315, 215, 630, 470)
    else
      vMame.Scene.Snap.Image.SetBounds((vMame.Scene.Right.Width / 2) - 235, 55, 470, 630);
  end;

  if mame.Support.List_Active[0] then
    vMame.Scene.Gamelist.T_GamePlayers.Text := uEmu_Arcade_Mame_Support_Files_NPlayers_GetGame
      (mame.Gamelist.List[0, mame.Gamelist.Selected, 0]);
  if mame.Support.List_Active[1] then
    vMame.Scene.Gamelist.T_GameCategory.Text := uEmu_Arcade_Mame_Support_Files_Catver_GetGame
      (mame.Gamelist.List[0, mame.Gamelist.Selected, 0]);
end;

procedure uEmu_Arcade_Mame_Actions_PlayGameMusic(vGameSoundPath: String);
begin
  if FileExists(vGameSoundPath) then
    vMameGameMusicList := uEmu_Arcade_Mame_Actions_LoadGameList(vGameSoundPath);
end;

function uEmu_Arcade_Mame_Actions_LoadGameList(vGameSoundPath: String): TstringList;
var
  vZip: TZipFile;
  vLocalHeader: TZipHeader;
  vStream: TMemoryStream;
  vi: Integer;
  vString: String;
begin
  { if FileExists(vGameSoundPath) then
    begin
    Result:= TStringList.Create;
    vZip:= TZipFile.Create;
    vZip.Open(vGameSoundPath, zmRead);
    vStream:= TMemoryStream.Create;
    for vi:= 0 to vZip.FileCount- 1 do
    begin
    if ExtractFileExt(vZip.FileName[vi])= '.mp3' then
    Result.Add(vZip.FileName[vi]);
    //          vString:= Result.Strings[vi];
    //          vZip.Read(vString, vStream, vLocalHeader);
    end;
    end
    else
    Result:= nil; }
end;

/// /////////////////////////////////////////////////////////////////////////////
procedure uEmu_Arcade_Mame_Actions_OpenFilters;
begin
  uEmu_Arcade_Mame_Filters_SetAll;
end;

procedure uEmu_Arcade_Mame_Actions_OpenSearch;
begin
  if extrafe.Prog.Virtual_Keyboard then
  begin
    vMame_VK := TImage.Create(Emu_Form);
    vMame_VK.Name := 'Search_VK_Panel';
    vMame_VK.Parent := Emu_Form;
    vMame_VK.Visible := True;

    vMame_Search_Current_Selected := mame.Gamelist.Selected;
    uVirtual_Keyboard.Create(vMame_VK, 'Search', 'Search for a game', vMame.Scene.Main);
  end
  else if uSnippet_Search.vSearch.Scene.Edit.Width = 0 then
  begin
    uSnippet_Search.vSearch.Scene.Edit_Ani.Start;
  end;
end;

procedure uEmu_Arcade_Mame_Actions_CloseTopicSearch;
begin

  vMame.Scene.Gamelist.Search_Edit.Width := 0;
  vMame.Scene.Gamelist.Listbox.SetFocus;
end;

procedure uEmu_Arcade_Mame_Actions_ChangeSnapMode;
begin
  if mame.Main.SnapMode = 'arcade' then
    mame.Main.SnapMode := 'frame'
  else
    mame.Main.SnapMode := 'arcade';
  uEmu_Arcade_Mame_Actions_ShowData;
end;

procedure uEmu_Arcade_Mame_Actions_ChangeCategeroy(vDirection: String);
const
  cSnapCategory: array [0 .. 17] of string = ('Video Snaps', 'Snapshots', 'Cabinets', 'Control Panels',
    'Flyers', 'Marquees', 'Pcbs', 'Artwork Preview', 'Bosses', 'How To', 'Logos', 'Scores', 'Selects',
    'Titles', 'Versus', 'Game Over', 'Ends', 'Warnings');
begin
  if vDirection = 'left' then
  begin
    if mame.Main.SnapCategory_Num > 0 then
    begin
      dec(mame.Main.SnapCategory_Num, 1);
      mame.Main.SnapCategory := cSnapCategory[mame.Main.SnapCategory_Num];
      vMame.Scene.Snap.SnapInfo.Text := cSnapCategory[mame.Main.SnapCategory_Num];
    end;
  end
  else
  begin
    if mame.Main.SnapCategory_Num < 17 then
    begin
      inc(mame.Main.SnapCategory_Num, 1);
      mame.Main.SnapCategory := cSnapCategory[mame.Main.SnapCategory_Num];
      vMame.Scene.Snap.SnapInfo.Text := cSnapCategory[mame.Main.SnapCategory_Num];
    end;
  end;
  uEmu_Arcade_Mame_Actions_ShowData;
end;

procedure uEmu_Arcade_Mame_Actions_OpenGlobalConfiguration;
var
  vi: Integer;
begin
  if not ContainsText(extrafe.Prog.State, 'mame_config') then
  begin
    uEmu_Arcade_Mame_Config_Load;
    vMame.Scene.Left_Anim.StartValue := 0;
    vMame.Scene.Left_Anim.StopValue := -460;

    vMame.Scene.Right_Anim.StartValue := 960;
    vMame.Scene.Right_Anim.StopValue := 1460;

    vMame.Scene.Left_Anim.Start;
    vMame.Scene.Right_Anim.Start;
    vMame.Scene.Left_Blur.Enabled := True;
    vMame.Scene.Right_Blur.Enabled := True;

    if mame.Main.SnapCategory = 'Video Snaps' then
      if vMame.Scene.Snap.Video.IsPlay then
        vMame.Scene.Snap.Video.Pause;

    if extrafe.Prog.State = 'mame_game' then
    begin
      vMame.Config.Scene.Header_Icon.Bitmap.LoadFromFile(mame.Prog.Images + 'settings_green.png');
      vMame.Config.Scene.Header_Label.Text := 'Configuration for "' + mame.Gamelist.List
        [0, mame.Gamelist.Selected, 0] + '" game rom.'
    end
    else
    begin
      vMame.Config.Scene.Header_Icon.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'settings_blue.png');
      vMame.Config.Scene.Header_Label.Text := 'Mame Global configuratin file';
    end;

    extrafe.Prog.State := 'mame_config';
  end
  else
  begin
    vMame.Scene.Left_Anim.StartValue := -460;
    vMame.Scene.Left_Anim.StopValue := 0;

    vMame.Scene.Right_Anim.StartValue := 1460;
    vMame.Scene.Right_Anim.StopValue := 960;

    vMame.Scene.Left_Anim.Enabled := True;
    vMame.Scene.Right_Anim.Enabled := True;

    uEmu_Arcade_Mame_Ini_Save;

    vMame.Scene.Left_Blur.Enabled := False;
    vMame.Scene.Right_Blur.Enabled := False;

    if mame.Main.SnapCategory = 'Video Snaps' then
      if vMame.Scene.Snap.Video.IsPause then
        vMame.Scene.Snap.Video.Resume;

    for vi := 0 to 12 do
      vMame.Config.Scene.Right_Panels[vi].Visible := False;

    if vMame.Scene.Settings.Tag = 1 then
      extrafe.Prog.State := 'mame'
    else if vMame.Scene.Settings.Tag = 2 then
      extrafe.Prog.State := 'mame_game';

    uEmu_Arcade_Mame_Config_Free;
  end;
end;

/// /////////////////////////////////////////////////////////////////////////////
procedure uEmu_Arcade_Mame_Actions_Escape;
var
  vi, ri: Integer;
begin
  if extrafe.Prog.State = 'mame_filters' then
    uEmu_Arcade_Mame_Filters_Free
  else if extrafe.Prog.State = 'mame_config' then
    uEmu_Arcade_Mame_Actions_OpenGlobalConfiguration
  else if extrafe.Prog.State = 'mame_game' then
    uEmu_Arcade_Mame_Game_Exit
  else if extrafe.Prog.State = 'mame' then
    uEmu_Arcade_Mame_Exit;
end;

procedure uEmu_Arcade_Mame_Actions_Enter;
begin

  uEmu_Arcade_Mame_Game_SetAll_Set;
  extrafe.Prog.State := 'mame_game';
  vMame.Scene.Settings.Tag := 2;
  uEmu_Arcade_Mame_Gamelist_GlowSelected
end;

end.
