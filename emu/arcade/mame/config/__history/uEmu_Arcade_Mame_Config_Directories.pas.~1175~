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
  FMX.Effects,
  FMX.Dialogs,
  ALFmxLayouts;

procedure Load;
procedure Tab_Click(vName: String);

{Tab Roms Actions}
procedure Rom_Find_Path;
procedure Rom_Create_Path;
procedure Rom_Delete_Path(vRow: Integer);

{Tab Directories Actions}
procedure Media_Find_Path(vNum: Integer);
procedure Media_Create_Path;
procedure Media_Download(vNum: Integer);
procedure Media_Download_Free;

implementation

uses
  uDB_AUser,
  uDB,
  uLoad_AllTypes,
  uWindows,
  uSnippet_Text,
  uEmu_Arcade_Mame_AllTypes,
  uEmu_Arcade_Mame_Config,
  uEmu_Arcade_Mame_Gamelist;

procedure Media_Download_Free;
begin
  vMame.Config.Scene.Main_Blur.Enabled := False;
  FreeAndNil(vMame.Config.Panel.Dirs.Media.Check.Panel);
end;

procedure Media_Download(vNum: Integer);
begin
  vMame.Config.Scene.Main_Blur.Enabled := True;

  vMame.Config.Panel.Dirs.Media.Check.Panel := TPanel.Create(vMame.Scene.Main);
  vMame.Config.Panel.Dirs.Media.Check.Panel.Name := 'Mame_Dir_Check';
  vMame.Config.Panel.Dirs.Media.Check.Panel.Parent := vMame.Scene.Main;
  vMame.Config.Panel.Dirs.Media.Check.Panel.SetBounds(((vMame.Scene.Main.Width / 2) - 400), ((vMame.Scene.Main.Height / 2) - 200), 800, 600);
  vMame.Config.Panel.Dirs.Media.Check.Panel.Visible := True;

  CreateHeader(vMame.Config.Panel.Dirs.Media.Check.Panel, 'IcoMoon-Free', #$e933, 'Check and download "' + vMame.Config.Panel.Dirs.Media.Labels[vNum].Text +
    ' "', False, nil);

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

procedure Rom_Create_Path;
var
  vi: Integer;
  vRoms: WideString;
begin
  vMame.Config.Panel.Dirs.Roms.Find := TText.Create(vMame.Config.Panel.Dirs.Roms_Tab);
  vMame.Config.Panel.Dirs.Roms.Find.Name := 'Mame_Dir_Roms_Add';
  vMame.Config.Panel.Dirs.Roms.Find.Parent := vMame.Config.Panel.Dirs.Roms_Tab;
  vMame.Config.Panel.Dirs.Roms.Find.SetBounds(vMame.Config.Panel.Dirs.TabControl.Width - 42, 10, 24, 24);
  vMame.Config.Panel.Dirs.Roms.Find.Font.Family := 'IcoMoon-Free';
  vMame.Config.Panel.Dirs.Roms.Find.Font.Size := 18;
  vMame.Config.Panel.Dirs.Roms.Find.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vMame.Config.Panel.Dirs.Roms.Find.Text := #$ea0a;
  vMame.Config.Panel.Dirs.Roms.Find.OnClick := mame.Config.Input.Mouse.Text.onMouseClick;
  vMame.Config.Panel.Dirs.Roms.Find.OnMouseEnter := mame.Config.Input.Mouse.Text.OnMouseEnter;
  vMame.Config.Panel.Dirs.Roms.Find.OnMouseLeave := mame.Config.Input.Mouse.Text.OnMouseLeave;
  vMame.Config.Panel.Dirs.Roms.Find.Visible := True;

  vMame.Config.Panel.Dirs.Roms.Find_Glow := TGlowEffect.Create(vMame.Config.Panel.Dirs.Roms.Find);
  vMame.Config.Panel.Dirs.Roms.Find_Glow.Name := 'Mame_Dirs_Roms_Add_Glow';
  vMame.Config.Panel.Dirs.Roms.Find_Glow.Parent := vMame.Config.Panel.Dirs.Roms.Find;
  vMame.Config.Panel.Dirs.Roms.Find_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vMame.Config.Panel.Dirs.Roms.Find_Glow.Softness := 0.9;
  vMame.Config.Panel.Dirs.Roms.Find_Glow.Enabled := False;

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
      vRoms := uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Path + 'roms'
    else
      vRoms := mame.Emu.Ini.CORE_SEARCH_rompath.Strings[vi];
    vMame.Config.Panel.Dirs.Roms.Edit[vi].Text := vRoms;
    vMame.Config.Panel.Dirs.Roms.Edit[vi].Visible := True;

    if mame.Emu.Ini.CORE_SEARCH_rompath.Strings[vi] <> 'roms' then
    begin
      vMame.Config.Panel.Dirs.Roms.Del[vi] := TText.Create(vMame.Config.Panel.Dirs.Roms.Box);
      vMame.Config.Panel.Dirs.Roms.Del[vi].Name := 'Mame_Dir_Roms_Del_' + vi.ToString;
      vMame.Config.Panel.Dirs.Roms.Del[vi].Parent := vMame.Config.Panel.Dirs.Roms.Box;
      vMame.Config.Panel.Dirs.Roms.Del[vi].SetBounds((vMame.Config.Panel.Dirs.Roms.Box.Width - 50), (5 + ((vi * 30) + (vi * 10))), 50, 30);
      vMame.Config.Panel.Dirs.Roms.Del[vi].Font.Family := 'IcoMoon-Free';
      vMame.Config.Panel.Dirs.Roms.Del[vi].Font.Size := 24;
      vMame.Config.Panel.Dirs.Roms.Del[vi].TextSettings.FontColor := TAlphaColorRec.Red;
      vMame.Config.Panel.Dirs.Roms.Del[vi].Text := #$e9ac;
      vMame.Config.Panel.Dirs.Roms.Del[vi].OnClick := mame.Config.Input.Mouse.Text.onMouseClick;
      vMame.Config.Panel.Dirs.Roms.Del[vi].OnMouseEnter := mame.Config.Input.Mouse.Text.OnMouseEnter;
      vMame.Config.Panel.Dirs.Roms.Del[vi].OnMouseLeave := mame.Config.Input.Mouse.Text.OnMouseLeave;
      vMame.Config.Panel.Dirs.Roms.Del[vi].TagFloat := 10;
      vMame.Config.Panel.Dirs.Roms.Del[vi].Tag := vi;
      vMame.Config.Panel.Dirs.Roms.Del[vi].Visible := True;

      vMame.Config.Panel.Dirs.Roms.Del_Glow[vi] := TGlowEffect.Create(vMame.Config.Panel.Dirs.Roms.Del[vi]);
      vMame.Config.Panel.Dirs.Roms.Del_Glow[vi].Name := 'Mame_Dir_Roms_Del_Glow' + vi.ToString;
      vMame.Config.Panel.Dirs.Roms.Del_Glow[vi].Parent := vMame.Config.Panel.Dirs.Roms.Del[vi];
      vMame.Config.Panel.Dirs.Roms.Del_Glow[vi].GlowColor := TAlphaColorRec.Red;
      vMame.Config.Panel.Dirs.Roms.Del_Glow[vi].Softness := 0.9;
      vMame.Config.Panel.Dirs.Roms.Del_Glow[vi].Enabled := False;
    end;
  end;
end;

procedure Media_Create_Path;
var
  vi: Integer;
  vType: String;
begin
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
    vMame.Config.Panel.Dirs.Media.Edit[vi].SetBounds(5, 25 + ((vi * 30) + (vi * 25)), vMame.Config.Panel.Dirs.Media.Box.Width - 60, 30);
    case vi of
      0:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Artworks;
      1:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Cabinets;
      2:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Control_Panels;
      3:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Covers;
      4:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Flyers;
      5:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Fanart;
      6:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Icons;
      7:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Manuals;
      8:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Marquees;
      9:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Pcbs;
      10:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Snapshots;
      11:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Titles;
      12:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Artwork_Preview;
      13:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Bosses;
      14:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Ends;
      15:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.How_To;
      16:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Logos;
      17:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Scores;
      18:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Selects;
      19:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Versus;
      20:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Game_Over;
      21:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Warnings;
      22:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Stamps;
      23:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Soundtracks;
      24:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Support_Files;
      25:
        vMame.Config.Panel.Dirs.Media.Edit[vi].Text := uDB_AUser.Local.EMULATORS.Arcade_D.Media.Videos;
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
    vMame.Config.Panel.Dirs.Media.Found[vi].Text := '(Found : ' + uWindows.File_Count(vMame.Config.Panel.Dirs.Media.Edit[vi].Text, vType)
      .ToString + ' files)';
    vMame.Config.Panel.Dirs.Media.Found[vi].TextSettings.FontColor := claDeepskyblue;
    vMame.Config.Panel.Dirs.Media.Found[vi].TextSettings.Font.Style := vMame.Config.Panel.Dirs.Media.Found[vi].TextSettings.Font.Style + [TFontStyle.fsItalic];
    vMame.Config.Panel.Dirs.Media.Found[vi].TextSettings.HorzAlign := TTextAlign.Leading;
    vMame.Config.Panel.Dirs.Media.Found[vi].Visible := True;

    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi] := TText.Create(vMame.Config.Panel.Dirs.Media.Box);
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Name := 'Mame_Dir_Media_CAD_' + IntToStr(vi);
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Parent := vMame.Config.Panel.Dirs.Media.Box;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].SetBounds(vMame.Config.Panel.Dirs.Media.Box.Width - 80, 5 + ((vi * 30) + (vi * 25)), 24, 24);
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Font.Family := 'IcoMoon-Free';
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Text := #$e9c7;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Visible := True;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].OnClick := mame.Config.Input.Mouse.Text.onMouseClick;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].OnMouseEnter := mame.Config.Input.Mouse.Text.OnMouseEnter;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].OnMouseLeave := mame.Config.Input.Mouse.Text.OnMouseLeave;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Tag := vi;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi].Visible := True;

    vMame.Config.Panel.Dirs.Media.CheckAndDownload_Glow[vi] := TGlowEffect.Create(vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi]);
    vMame.Config.Panel.Dirs.Media.CheckAndDownload_Glow[vi].Name := 'Mame_Dir_Media_CAD_Glow_' + vi.ToString;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload_Glow[vi].Parent := vMame.Config.Panel.Dirs.Media.CheckAndDownload[vi];
    vMame.Config.Panel.Dirs.Media.CheckAndDownload_Glow[vi].GlowColor := TAlphaColorRec.Deepskyblue;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload_Glow[vi].Softness := 0.9;
    vMame.Config.Panel.Dirs.Media.CheckAndDownload_Glow[vi].Enabled := False;

    vMame.Config.Panel.Dirs.Media.Change[vi] := TText.Create(vMame.Config.Panel.Dirs.Media.Box);
    vMame.Config.Panel.Dirs.Media.Change[vi].Name := 'Mame_Dir_Media_Change_' + IntToStr(vi);
    vMame.Config.Panel.Dirs.Media.Change[vi].Parent := vMame.Config.Panel.Dirs.Media.Box;
    vMame.Config.Panel.Dirs.Media.Change[vi].SetBounds((vMame.Config.Panel.Dirs.Media.Box.Width - 50), (25 + ((vi * 30) + (vi * 25))), 30, 30);
    vMame.Config.Panel.Dirs.Media.Change[vi].Font.Family := 'IcoMoon-Free';
    vMame.Config.Panel.Dirs.Media.Change[vi].Font.Size := 24;
    vMame.Config.Panel.Dirs.Media.Change[vi].TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vMame.Config.Panel.Dirs.Media.Change[vi].Text := #$e930;
    vMame.Config.Panel.Dirs.Media.Change[vi].OnClick := mame.Config.Input.Mouse.Text.onMouseClick;
    vMame.Config.Panel.Dirs.Media.Change[vi].OnMouseEnter := mame.Config.Input.Mouse.Text.OnMouseEnter;
    vMame.Config.Panel.Dirs.Media.Change[vi].OnMouseLeave := mame.Config.Input.Mouse.Text.OnMouseLeave;
    vMame.Config.Panel.Dirs.Media.Change[vi].Tag := vi;
    vMame.Config.Panel.Dirs.Media.Change[vi].Visible := True;

    vMame.Config.Panel.Dirs.Media.Change_Glow[vi] := TGlowEffect.Create(vMame.Config.Panel.Dirs.Media.Change[vi]);
    vMame.Config.Panel.Dirs.Media.Change_Glow[vi].Name := 'Mame_Dir_Media_Change_Glow_' + vi.ToString;
    vMame.Config.Panel.Dirs.Media.Change_Glow[vi].Parent := vMame.Config.Panel.Dirs.Media.Change[vi];
    vMame.Config.Panel.Dirs.Media.Change_Glow[vi].GlowColor := TAlphaColorRec.Deepskyblue;
    vMame.Config.Panel.Dirs.Media.Change_Glow[vi].Softness := 0.9;
    vMame.Config.Panel.Dirs.Media.Change_Glow[vi].Enabled := False;
  end;

end;

procedure Load;
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

  Rom_Create_Path;
  Media_Create_Path;

  vMame.Config.Panel.Dirs.TabControl.TabIndex := 0;
end;

procedure Rom_Find_Path;
var
  vdir: string;
begin
  if SelectDirectory('Select Rom path.', '' , vdir) = True then
  begin
    mame.Emu.Ini.CORE_SEARCH_rompath.Insert(mame.Emu.Ini.CORE_SEARCH_rompath.Count, vdir);
    FreeAndNil(vMame.Config.Panel.Dirs.Roms.Box);
    Rom_Create_Path;
    uEmu_Arcade_Mame_Gamelist.Refresh;
  end
end;

procedure Rom_Delete_Path(vRow: Integer);
begin
  mame.Emu.Ini.CORE_SEARCH_rompath.Delete(vRow);
  FreeAndNil(vMame.Config.Panel.Dirs.Roms.Box);
  Rom_Create_Path;
  uEmu_Arcade_Mame_Gamelist.Refresh;
end;

///

procedure Media_Find_Path(vNum: Integer);
var
  vdir: string;
  vType: String;
begin
  vdir := vMame.Config.Panel.Dirs.Media.Edit[vNum].Text;
  if SelectDirectory('Select Rom path.', '' , vdir) = True then
  begin
    if vNum = 1 then
      vType := '*.zip'
    else
      vType := '*.png';
    vMame.Config.Panel.Dirs.Media.Found[vNum].Text := '(Found : ' + uWindows.File_Count(vdir, vType).ToString + ' files)';
    vdir := vdir + '\';
    vMame.Config.Panel.Dirs.Media.Edit[vNum].Text := vdir;
    case vNum of
      0:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Artworks := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'ARTWORKS', vdir, 'USER_ID',  uDB_AUser.Local.Num.ToString);
        end;
      1:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Cabinets := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'CABINETS', vdir, 'USER_ID',uDB_AUser.Local.Num.ToString);
        end;
      2:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Control_Panels := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'CONTROL_PANELS', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      3:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Covers := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'COVERS', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      4:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Flyers := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'FLYERS', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      5:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Fanart := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'FANART', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      6:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Icons := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'ICONS', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      7:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Manuals := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'MANUALS', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      8:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Marquees := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'MARQUEES', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      9:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Pcbs := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'PCBS', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      10:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Snapshots := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'SNAPSHOTS', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      11:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Titles := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'TITLES', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      12:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Artwork_Preview := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'ARTWORK_PREVIEW', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      13:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Bosses := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'BOSSES', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      14:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Ends := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'ENDS', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      15:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.How_To := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'HOW_TO', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      16:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Logos := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'LOGOS', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      17:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Scores := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'SCORES', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      18:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Selects := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'SELECTS', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      19:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Versus := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'VERSUS', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      20:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Game_Over := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'GAME_OVER', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      21:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Warnings := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'WARNINGS', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      22:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Stamps := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'STAMPS', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      23:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Soundtracks := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'SOUNDTRACKS', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      24:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Support_Files := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'SUPPORT_FILES', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
      25:
        begin
          uDB_AUser.Local.EMULATORS.Arcade_D.Media.Videos := vdir;
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ARCADE_MEDIA', 'VIDEOS', vdir, 'USER_ID', uDB_AUser.Local.Num.ToString);
        end;
    end;
  end;
end;

procedure Tab_Click(vName: String);
begin
  if vName = 'Mame_Dir_Tab_Roms' then
    extrafe.prog.State := 'mame_config_dirs'
  else if vName = 'Mame_Dir_Tab_Media' then
    extrafe.prog.State := 'mame_config_media';
end;

end.
