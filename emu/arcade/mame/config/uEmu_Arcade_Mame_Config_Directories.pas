unit uEmu_Arcade_Mame_Config_Directories;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UITypes,
  System.UIConsts,
  FMX.Edit,
  FMX.StdCtrls,
  FMX.Types,
  FMX.Layouts,
  FMX.TabControl,
  FMX.Objects,
  VCL.FileCtrl,
  ALFmxLayouts;

procedure uEmu_Arcade_Mame_Config_Create_Directories_Panel;
procedure uEmu_Arcade_Mame_Config_Create_RomPaths;

// Actions
procedure uEmu_Arcade_Mame_Config_CheckAndDownload(vNum: Integer);
procedure uEmu_Arcade_Mame_Config_CheckAndDownload_Free;
procedure uEmu_Arcade_Mame_Config_Media_Find(vNum: Integer);
procedure uEmu_Arcade_Mame_Config_Roms_Find;
procedure uEmu_Arcade_Mame_Config_RomPath_Delete(vRow: Integer);

procedure uEmu_Arcade_Mame_Config_Directories_TabItemClick(vName: String);

implementation

uses
  uLoad_AllTypes,
  uWindows,
  uSnippet_Text,
  uEmu_Arcade_Mame_AllTypes,
  uEmu_Arcade_Mame_Config,
  uEmu_Arcade_Mame_Gamelist;

procedure uEmu_Arcade_Mame_Config_CheckAndDownload_Free;
begin
  vMame.Config.Scene.Main_Blur.Enabled := False;
  FreeAndNil(vMame.Config.Panel.Dirs.Media.Check.Panel);
end;

procedure uEmu_Arcade_Mame_Config_CheckAndDownload(vNum: Integer);
begin
  vMame.Config.Scene.Main_Blur.Enabled := True;

  vMame.Config.Panel.Dirs.Media.Check.Panel := TPanel.Create(vMame.Scene.Main);
  vMame.Config.Panel.Dirs.Media.Check.Panel.Name := 'Mame_Dir_Check';
  vMame.Config.Panel.Dirs.Media.Check.Panel.Parent := vMame.Scene.Main;
  vMame.Config.Panel.Dirs.Media.Check.Panel.SetBounds(((vMame.Scene.Main.Width / 2) - 400), ((vMame.Scene.Main.Height / 2) - 200), 800, 600);
  vMame.Config.Panel.Dirs.Media.Check.Panel.Visible := True;

  CreateHeader(vMame.Config.Panel.Dirs.Media.Check.Panel, 'IcoMoon-Free', #$e933,
    'Check and download "' + vMame.Config.Panel.Dirs.Media.Labels[vNum].Text + ' "', False, nil);

  vMame.Config.Panel.Dirs.Media.Check.Main := TPanel.Create(vMame.Config.Panel.Dirs.Media.Check.Panel);
  vMame.Config.Panel.Dirs.Media.Check.Main.Name := 'Mame_Dir_Check_Main';
  vMame.Config.Panel.Dirs.Media.Check.Main.Parent := vMame.Config.Panel.Dirs.Media.Check.Panel;
  vMame.Config.Panel.Dirs.Media.Check.Main.SetBounds(0, 30, vMame.Config.Panel.Dirs.Media.Check.Panel.Width,
    vMame.Config.Panel.Dirs.Media.Check.Panel.Height - 30);
  vMame.Config.Panel.Dirs.Media.Check.Main.Visible := True;

  vMame.Config.Panel.Dirs.Media.Check.Info := TLabel.Create(vMame.Config.Panel.Dirs.Media.Check.Main);
  vMame.Config.Panel.Dirs.Media.Check.Info.Name := 'Mame_Dir_Check_Main_Label';
  vMame.Config.Panel.Dirs.Media.Check.Info.Parent := vMame.Config.Panel.Dirs.Media.Check.Main;
  vMame.Config.Panel.Dirs.Media.Check.Info.SetBounds(10, 30, 400, 24);
  vMame.Config.Panel.Dirs.Media.Check.Info.Text := 'Now matching the versions between server and computer.';
  vMame.Config.Panel.Dirs.Media.Check.Info.Visible := True;

  vMame.Config.Panel.Dirs.Media.Check.ProgressBar := TProgressBar.Create(vMame.Config.Panel.Dirs.Media.Check.Main);
  vMame.Config.Panel.Dirs.Media.Check.ProgressBar.Name := 'Mame_Dir_Check_Progressbar';
  vMame.Config.Panel.Dirs.Media.Check.ProgressBar.Parent := vMame.Config.Panel.Dirs.Media.Check.Main;
  vMame.Config.Panel.Dirs.Media.Check.ProgressBar.SetBounds(10, 110, vMame.Config.Panel.Dirs.Media.Check.Panel.Width - 20, 20);
  vMame.Config.Panel.Dirs.Media.Check.ProgressBar.Value := 0;
  vMame.Config.Panel.Dirs.Media.Check.ProgressBar.Min := 0;
  vMame.Config.Panel.Dirs.Media.Check.ProgressBar.Max := 100;
  vMame.Config.Panel.Dirs.Media.Check.ProgressBar.Visible := True;

  vMame.Config.Panel.Dirs.Media.Check.Update := TButton.Create(vMame.Config.Panel.Dirs.Media.Check.Panel);
  vMame.Config.Panel.Dirs.Media.Check.Update.Name := 'Mame_Dir_Check_Update';
  vMame.Config.Panel.Dirs.Media.Check.Update.Parent := vMame.Config.Panel.Dirs.Media.Check.Panel;
  vMame.Config.Panel.Dirs.Media.Check.Update.SetBounds(50, vMame.Config.Panel.Dirs.Media.Check.Panel.Height - 40, 100, 30);
  vMame.Config.Panel.Dirs.Media.Check.Update.Text := 'Update';
  vMame.Config.Panel.Dirs.Media.Check.Update.Visible := True;

  vMame.Config.Panel.Dirs.Media.Check.Cancel := TButton.Create(vMame.Config.Panel.Dirs.Media.Check.Panel);
  vMame.Config.Panel.Dirs.Media.Check.Cancel.Name := 'Mame_Dir_Check_Cancel';
  vMame.Config.Panel.Dirs.Media.Check.Cancel.Parent := vMame.Config.Panel.Dirs.Media.Check.Panel;
  vMame.Config.Panel.Dirs.Media.Check.Cancel.SetBounds(vMame.Config.Panel.Dirs.Media.Check.Panel.Width - 150, vMame.Config.Panel.Dirs.Media.Check.Panel.Height -
    40, 100, 30);
  vMame.Config.Panel.Dirs.Media.Check.Cancel.Text := 'Cancel';
  vMame.Config.Panel.Dirs.Media.Check.Cancel.OnClick := mame.Config.Input.Mouse.Button.onMouseClick;
  vMame.Config.Panel.Dirs.Media.Check.Cancel.Visible := True;
end;

procedure uEmu_Arcade_Mame_Config_Create_RomPaths;
var
  vi: Integer;
  vRoms: WideString;
begin
  vMame.Config.Panel.Dirs.Roms.Box := TVertScrollBox.Create(vMame.Config.Panel.Dirs.Roms_Tab);
  vMame.Config.Panel.Dirs.Roms.Box.Name := 'Mame_Dir_Roms_VertScrollbox';
  vMame.Config.Panel.Dirs.Roms.Box.Parent := vMame.Config.Panel.Dirs.Roms_Tab;
  vMame.Config.Panel.Dirs.Roms.Box.SetBounds(10, 34, vMame.Config.Panel.Dirs.TabControl.Width - 20, vMame.Config.Panel.Dirs.TabControl.Height - 64);
  vMame.Config.Panel.Dirs.Roms.Box.ShowScrollBars := True;
  vMame.Config.Panel.Dirs.Roms.Box.Visible := True;

  for vi := 0 to mame.Emu.Ini.CORE_SEARCH_rompath.Count - 1 do
  begin
    vMame.Config.Panel.Dirs.Roms.Edit[vi] := TEdit.Create(vMame.Config.Panel.Dirs.Roms.Box);
    vMame.Config.Panel.Dirs.Roms.Edit[vi].Name := 'Mame_Dir_Roms_Dir_' + IntToStr(vi);
    vMame.Config.Panel.Dirs.Roms.Edit[vi].Parent := vMame.Config.Panel.Dirs.Roms.Box;
    vMame.Config.Panel.Dirs.Roms.Edit[vi].SetBounds(5, (5 + ((vi * 30) + (vi * 10))), vMame.Config.Panel.Dirs.Roms.Box.Width - 64, 30);
    if mame.Emu.Ini.CORE_SEARCH_rompath.Strings[vi] = 'roms' then
      vRoms := mame.Emu.Path + 'roms'
    else
      vRoms := mame.Emu.Ini.CORE_SEARCH_rompath.Strings[vi];
    vMame.Config.Panel.Dirs.Roms.Edit[vi].Text := vRoms;
    vMame.Config.Panel.Dirs.Roms.Edit[vi].Visible := True;

    if mame.Emu.Ini.CORE_SEARCH_rompath.Strings[vi] <> 'roms' then
    begin
      vMame.Config.Panel.Dirs.Roms.Del[vi] := TSpeedButton.Create(vMame.Config.Panel.Dirs.Roms.Box);
      vMame.Config.Panel.Dirs.Roms.Del[vi].Name := 'Mame_Dir_Roms_Del_' + IntToStr(vi);
      vMame.Config.Panel.Dirs.Roms.Del[vi].Parent := vMame.Config.Panel.Dirs.Roms.Box;
      vMame.Config.Panel.Dirs.Roms.Del[vi].SetBounds((vMame.Config.Panel.Dirs.Roms.Box.Width - 50), (5 + ((vi * 30) + (vi * 10))), 50, 30);
      vMame.Config.Panel.Dirs.Roms.Del[vi].StyleLookup := 'delettoolbutton';
      vMame.Config.Panel.Dirs.Roms.Del[vi].StyledSettings := vMame.Config.Panel.Dirs.Roms.Del[vi].StyledSettings - [TstyledSetting.FontColor];
      vMame.Config.Panel.Dirs.Roms.Del[vi].TextSettings.FontColor := TAlphaColorRec.Red;
      vMame.Config.Panel.Dirs.Roms.Del[vi].Text := 'Delete';
      vMame.Config.Panel.Dirs.Roms.Del[vi].OnClick := mame.Config.Input.Mouse.SpeedButton.onMouseClick;
      vMame.Config.Panel.Dirs.Roms.Del[vi].TagFloat := 10;
      vMame.Config.Panel.Dirs.Roms.Del[vi].Tag := vi;
      vMame.Config.Panel.Dirs.Roms.Del[vi].Visible := True;
    end;
  end;
end;

// Directories
procedure uEmu_Arcade_Mame_Config_Create_Directories_Panel;
var
  vi: Integer;
  vType: String;
begin
  vMame.Config.Panel.Dirs.TabControl := TTabControl.Create(vMame.Config.Scene.Right_Panels[0]);
  vMame.Config.Panel.Dirs.TabControl.Name := 'Mame_Dir_Master_TabControl';
  vMame.Config.Panel.Dirs.TabControl.Parent := vMame.Config.Scene.Right_Panels[0];
  vMame.Config.Panel.Dirs.TabControl.Align := TAlignLayout.Client;
  vMame.Config.Panel.Dirs.TabControl.Visible := True;

  vMame.Config.Panel.Dirs.Roms_Tab := TTabItem.Create(vMame.Config.Panel.Dirs.TabControl);
  vMame.Config.Panel.Dirs.Roms_Tab.Name := 'Mame_Dir_Tab_Roms';
  vMame.Config.Panel.Dirs.Roms_Tab.Parent := vMame.Config.Panel.Dirs.TabControl;
  vMame.Config.Panel.Dirs.Roms_Tab.Text := 'Roms';
  vMame.Config.Panel.Dirs.Roms_Tab.OnClick := mame.Config.Input.Mouse.TabItem.onMouseClick;
  vMame.Config.Panel.Dirs.Roms_Tab.Visible := True;

  vMame.Config.Panel.Dirs.Media_Tab := TTabItem.Create(vMame.Config.Panel.Dirs.TabControl);
  vMame.Config.Panel.Dirs.Media_Tab.Name := 'Mame_Dir_Tab_Media';
  vMame.Config.Panel.Dirs.Media_Tab.Parent := vMame.Config.Panel.Dirs.TabControl;
  vMame.Config.Panel.Dirs.Media_Tab.Text := 'Media';
  vMame.Config.Panel.Dirs.Media_Tab.OnClick := mame.Config.Input.Mouse.TabItem.onMouseClick;
  vMame.Config.Panel.Dirs.Media_Tab.Visible := True;

  // Roms
  vMame.Config.Panel.Dirs.Roms.Find := TSpeedButton.Create(vMame.Config.Panel.Dirs.Roms_Tab);
  vMame.Config.Panel.Dirs.Roms.Find.Name := 'Mame_Dir_Roms_Add_Button';
  vMame.Config.Panel.Dirs.Roms.Find.Parent := vMame.Config.Panel.Dirs.Roms_Tab;
  vMame.Config.Panel.Dirs.Roms.Find.SetBounds(vMame.Config.Panel.Dirs.TabControl.Width - 42, 10, 24, 24);
  vMame.Config.Panel.Dirs.Roms.Find.StyleLookup := 'addtoolbutton';
  vMame.Config.Panel.Dirs.Roms.Find.Hint := 'Add new rom path';
  vMame.Config.Panel.Dirs.Roms.Find.ShowHint := True;
  vMame.Config.Panel.Dirs.Roms.Find.OnClick := mame.Config.Input.Mouse.SpeedButton.onMouseClick;
  vMame.Config.Panel.Dirs.Roms.Find.Tag := -1;
  vMame.Config.Panel.Dirs.Roms.Find.Visible := True;

  uEmu_Arcade_Mame_Config_Create_RomPaths;

  // Media
  vMame.Config.Panel.Dirs.Media.Box := TVertScrollBox.Create(vMame.Config.Panel.Dirs.Media_Tab);
  vMame.Config.Panel.Dirs.Media.Box.Name := 'Mame_Dir_Media_VertScrollbox';
  vMame.Config.Panel.Dirs.Media.Box.Parent := vMame.Config.Panel.Dirs.Media_Tab;
  vMame.Config.Panel.Dirs.Media.Box.SetBounds(10, 10, (vMame.Config.Panel.Dirs.TabControl.Width - 20), (vMame.Config.Panel.Dirs.TabControl.Height - 60));
  vMame.Config.Panel.Dirs.Media.Box.ShowScrollBars := True;
  vMame.Config.Panel.Dirs.Media.Box.Visible := True;

  for vi := 0 to 25 do
  begin
    vMame.Config.Panel.Dirs.Media.Labels[vi] := TText.Create(vMame.Config.Panel.Dirs.Media.Box);
    vMame.Config.Panel.Dirs.Media.Labels[vi].Name := 'Mame_Dir_Media_Label_' + IntToStr(vi);
    vMame.Config.Panel.Dirs.Media.Labels[vi].Parent := vMame.Config.Panel.Dirs.Media.Box;
    vMame.Config.Panel.Dirs.Media.Labels[vi].SetBounds(5, (5 + ((vi * 30) + (vi * 25))), 0, 24);
    vMame.Config.Panel.Dirs.Media.Labels[vi].TextSettings.FontColor := TAlphaColorRec.White;
    vMame.Config.Panel.Dirs.Media.Labels[vi].Text := cMame_Config_Media_dirs[vi];
    vMame.Config.Panel.Dirs.Media.Labels[vi].Visible := True;
    vMame.Config.Panel.Dirs.Media.Labels[vi].Width := uSnippet_Text_ToPixels(vMame.Config.Panel.Dirs.Media.Labels[vi]);

    vMame.Config.Panel.Dirs.Media.Edit[vi] := TEdit.Create(vMame.Config.Panel.Dirs.Media.Box);
    vMame.Config.Panel.Dirs.Media.Edit[vi].Name := 'Mame_Dir_Media_Path_' + IntToStr(vi);
    vMame.Config.Panel.Dirs.Media.Edit[vi].Parent := vMame.Config.Panel.Dirs.Media.Box;
    vMame.Config.Panel.Dirs.Media.Edit[vi].Width := vMame.Config.Panel.Dirs.Media.Box.Width - 60;
    vMame.Config.Panel.Dirs.Media.Edit[vi].Height := 30;
    vMame.Config.Panel.Dirs.Media.Edit[vi].Position.X := 5;
    vMame.Config.Panel.Dirs.Media.Edit[vi].Position.Y := 25 + ((vi * 30) + (vi * 25));
    case vi of
      0:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Artworks;
      1:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Cabinets;
      2:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Control_Panels;
      3:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Covers;
      4:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Flyers;
      5:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Fanart;
      6:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Icons;
      7:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Manuals;
      8:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Marquees;
      9:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Pcbs;
      10:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Snapshots;
      11:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Titles;
      12:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Artwork_Preview;
      13:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Bosses;
      14:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Ends;
      15:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.How_To;
      16:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Logos;
      17:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Scores;
      18:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Selects;
      19:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Versus;
      20:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Game_Over;
      21:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Warnings;
      22:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Stamps;
      23:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Soundtracks;
      24:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Support_Files;
      25:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := mame.Emu.Media.Videos;
    end;
    vMame.Config.Panel.Dirs.Media.Edit[vi].Visible := True;

    if vi = 1 then
      vType := '*.zip'
    else
      vType := '*.png';

    vMame.Config.Panel.Dirs.Media.Found[vi] := TText.Create(vMame.Config.Panel.Dirs.Media.Box);
    vMame.Config.Panel.Dirs.Media.Found[vi].Name := 'Mame_Dir_Media_Found_' + IntToStr(vi);
    vMame.Config.Panel.Dirs.Media.Found[vi].Parent := vMame.Config.Panel.Dirs.Media.Box;
    vMame.Config.Panel.Dirs.Media.Found[vi].SetBounds((vMame.Config.Panel.Dirs.Media.Labels[vi].Position.X + vMame.Config.Panel.Dirs.Media.Labels[vi].Width +
      10), (5 + ((vi * 30) + (vi * 25))), 400, 24);
    vMame.Config.Panel.Dirs.Media.Found[vi].Text := '(Found : ' + uWindows_CountFilesOrFolders(vMame.Config.Panel.Dirs.Media.Edit[vi].Text, False, vType)
      .ToString + ' files)';
    vMame.Config.Panel.Dirs.Media.Found[vi].TextSettings.FontColor := claDeepskyblue;
    vMame.Config.Panel.Dirs.Media.Found[vi].TextSettings.Font.Style := vMame.Config.Panel.Dirs.Media.Found[vi].TextSettings.Font.Style + [TFontStyle.fsItalic];
    vMame.Config.Panel.Dirs.Media.Found[vi].TextSettings.HorzAlign := TTextAlign.Leading;
    vMame.Config.Panel.Dirs.Media.Found[vi].Visible := True;

    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi] := TText.Create(vMame.Config.Panel.Dirs.Media.Box);
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Name := 'Mame_Dir_Media_CAD_' + IntToStr(vi);
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Parent := vMame.Config.Panel.Dirs.Media.Box;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].TextSettings.FontColor := claWhite;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Font.Style := vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Font.Style + [TFontStyle.fsBold];
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].TextSettings.HorzAlign := TTextAlign.Trailing;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Text := 'Check and Download ' + cMame_Config_Media_dirs[vi];
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Position.Y := 5 + ((vi * 30) + (vi * 25));
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Height := 22;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Visible := True;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Width := uSnippet_Text_ToPixels(vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi]);
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Position.X := vMame.Config.Panel.Dirs.Media.Edit[vi].Width -
      vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Width;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].OnMouseEnter := mame.Config.Input.Mouse.Text.OnMouseEnter;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].OnMouseLeave := mame.Config.Input.Mouse.Text.OnMouseLeave;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].OnClick := mame.Config.Input.Mouse.Text.onMouseClick;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Tag := vi;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Visible := True;

    vMame.Config.Panel.Dirs.Media.Change[vi] := TSpeedButton.Create(vMame.Config.Panel.Dirs.Media.Box);
    vMame.Config.Panel.Dirs.Media.Change[vi].Name := 'Mame_Dir_Media_Change_' + IntToStr(vi);
    vMame.Config.Panel.Dirs.Media.Change[vi].Parent := vMame.Config.Panel.Dirs.Media.Box;
    vMame.Config.Panel.Dirs.Media.Change[vi].SetBounds((vMame.Config.Panel.Dirs.Media.Box.Width - 50), (25 + ((vi * 30) + (vi * 25))), 30, 30);
    vMame.Config.Panel.Dirs.Media.Change[vi].StyleLookup := 'delettoolbutton';
    vMame.Config.Panel.Dirs.Media.Change[vi].Text := '...';
    vMame.Config.Panel.Dirs.Media.Change[vi].OnClick := mame.Config.Input.Mouse.SpeedButton.onMouseClick;
    vMame.Config.Panel.Dirs.Media.Change[vi].Tag := vi;
    vMame.Config.Panel.Dirs.Media.Change[vi].Visible := True;
  end;

  vMame.Config.Panel.Dirs.TabControl.TabIndex := 0;
end;

procedure uEmu_Arcade_Mame_Config_Roms_Find;
const
  m = 1000;
var
  dir: string;
begin
  if SelectDirectory(dir, [sdAllowCreate, sdPerformCreate, sdPrompt], m) = True then
  begin
    mame.Emu.Ini.CORE_SEARCH_rompath.Insert(mame.Emu.Ini.CORE_SEARCH_rompath.Count, dir);
    FreeAndNil(vMame.Config.Panel.Dirs.Roms.Box);
    uEmu_Arcade_Mame_Config_Create_RomPaths;
    uEmu_Arcade_Mame_Gamelist_Refresh;
  end
end;

procedure uEmu_Arcade_Mame_Config_RomPath_Delete(vRow: Integer);
begin
  mame.Emu.Ini.CORE_SEARCH_rompath.Delete(vRow);
  FreeAndNil(vMame.Config.Panel.Dirs.Roms.Box);
  uEmu_Arcade_Mame_Config_Create_RomPaths;
  uEmu_Arcade_Mame_Gamelist_Refresh;
end;

///

procedure uEmu_Arcade_Mame_Config_Media_Find(vNum: Integer);
const
  m = 1000;
var
  vdir: string;
  vType: String;
begin
  vdir := vMame.Config.Panel.Dirs.Media.Edit[vNum].Text;
  if SelectDirectory(vdir, [sdAllowCreate, sdPerformCreate, sdPrompt], m) = True then
  begin
    if vNum = 1 then
      vType := '*.zip'
    else
      vType := '*.png';
    vMame.Config.Panel.Dirs.Media.Found[vNum].Text := '(Found : ' + uWindows_CountFilesOrFolders(vdir, False, vType).ToString + ' files)';
    vdir := vdir + '\';
    vMame.Config.Panel.Dirs.Media.Edit[vNum].Text := vdir;
    case vNum of
      0:
        mame.Emu.Media.Artworks := vdir;
      1:
        mame.Emu.Media.Cabinets := vdir;
      2:
        mame.Emu.Media.Control_Panels := vdir;
      3:
        mame.Emu.Media.Covers := vdir;
      4:
        mame.Emu.Media.Flyers := vdir;
      5:
        mame.Emu.Media.Fanart := vdir;
      6:
        mame.Emu.Media.Icons := vdir;
      7:
        mame.Emu.Media.Manuals := vdir;
      8:
        mame.Emu.Media.Marquees := vdir;
      9:
        mame.Emu.Media.Pcbs := vdir;
      10:
        mame.Emu.Media.Snapshots := vdir;
      11:
        mame.Emu.Media.Titles := vdir;
      12:
        mame.Emu.Media.Artwork_Preview := vdir;
      13:
        mame.Emu.Media.Bosses := vdir;
      14:
        mame.Emu.Media.Ends := vdir;
      15:
        mame.Emu.Media.How_To := vdir;
      16:
        mame.Emu.Media.Logos := vdir;
      17:
        mame.Emu.Media.Scores := vdir;
      18:
        mame.Emu.Media.Selects := vdir;
      19:
        mame.Emu.Media.Versus := vdir;
      20:
        mame.Emu.Media.Game_Over := vdir;
      21:
        mame.Emu.Media.Warnings := vdir;
      22:
        mame.Emu.Media.Stamps := vdir;
      23:
        mame.Emu.Media.Soundtracks := vdir;
      24:
        mame.Emu.Media.Support_Files := vdir;
      25:
        mame.Emu.Media.Videos := vdir;
    end;
  end;
end;

{ TEMU_ARCACE_MAME_CONFIG_DIRECTORIES_TEXT }
{ procedure TEMU_ARCACE_MAME_CONFIG_DIRECTORIES_TEXT.onMouseClick(
  Sender: TObject);
  begin
  uEmu_Arcade_Mame_Config_CheckAndDowload('');
  end; }

{ procedure TEMU_ARCACE_MAME_CONFIG_DIRECTORIES_TEXT.onMouseEnter(Sender: TObject);
  begin
  TText(Sender).TextSettings.Font.Style:= TText(Sender).TextSettings.Font.Style+ [TFontStyle.fsUnderline];
  TText(Sender).TextSettings.FontColor:= claDeepskyblue;
  TText(Sender).Cursor:= crHandPoint;
  end;
  {
  procedure TEMU_ARCACE_MAME_CONFIG_DIRECTORIES_TEXT.onMouseLeave(Sender: TObject);
  begin
  TText(Sender).TextSettings.Font.Style:= TText(Sender).TextSettings.Font.Style- [TFontStyle.fsUnderline];
  if (extrafe.style.Name= 'Amakrits') or (extrafe.style.Name= 'Dark') or (extrafe.style.Name= 'Air') then
  TText(Sender).TextSettings.FontColor:= claWhite
  else
  TText(Sender).TextSettings.FontColor:= claBlack;
  TText(Sender).Cursor:= crDefault;
  end; }

/// /////////////////////////////////////////////////////////////////////////////
procedure uEmu_Arcade_Mame_Config_Directories_TabItemClick(vName: String);
begin
  if vName = 'Mame_Dir_Tab_Roms' then
    extrafe.prog.State := 'mame_config_dirs'
  else if vName = 'Mame_Dir_Tab_Media' then
    extrafe.prog.State := 'mame_config_media';
end;

end.
