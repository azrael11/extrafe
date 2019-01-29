unit uSoundplayer_Playlist_Manage;

interface

uses
  System.Classes,
  System.UiTypes,
  System.SysUtils,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Grid,
  FMX.Effects,
  FMX.Filter.Effects,
  FMX.Dialogs,
  Bass;

procedure uSoundPlayer_Playlist_Manage_Panel;
procedure uSoundPlayer_Playlist_Manage_Free;

procedure uSoundplayer_Playlist_Manage_AddPlaylistToGrid;

procedure uSoundplayer_Playlist_Manage_LoadPlaylist(vPlaylistNum: Integer);

procedure uSoundplayer_Playlist_Manage_Lock(vActive: Boolean);

procedure uSoundplayer_Playlist_Manage_Grid_SelectCell(vSelected: Integer);
procedure uSoundplayer_Playlist_Manage_Grid_SelectForMerge(vSelected: Integer);

procedure uSoundplayer_Playlist_Manage_MoveUp(vSelected: Integer);
procedure uSoundplayer_Playlist_Manage_MoveDown(vSelected: Integer);

implementation

uses
  uLoad_AllTypes,
  uSoundplayer_AllTypes,
  uSoundplayer_Playlist_Actions,
  uSoundplayer_Actions;

procedure uSoundPlayer_Playlist_Manage_Panel;
var
  vi: Integer;
begin
  if vSoundplayer.Playlist.Manage_Icon_Grey.Enabled = False then
  begin

    extrafe.prog.State := 'addon_soundplayer_manage_playlists';

    vSoundplayer.scene.Back_Blur.Enabled := True;

    vSoundplayer.Playlist.Manage.Panel := TPanel.Create(vSoundplayer.scene.soundplayer);
    vSoundplayer.Playlist.Manage.Panel.Name := 'A_SP_Playlist_Manage_Panel';
    vSoundplayer.Playlist.Manage.Panel.Parent := vSoundplayer.scene.soundplayer;
    vSoundplayer.Playlist.Manage.Panel.SetBounds((vSoundplayer.scene.soundplayer.Width / 2) - 300,
      (vSoundplayer.scene.soundplayer.Height / 2) - 200, 600, 450);
    vSoundplayer.Playlist.Manage.Panel.Visible := True;

    uLoad_SetAll_CreateHeader(vSoundplayer.Playlist.Manage.Panel, 'A_SP_Playlist_Manage_Panel',
      addons.soundplayer.Path.Images + 'sp_list.png', 'Manage playlists.');

    vSoundplayer.Playlist.Manage.main.Panel := TPanel.Create(vSoundplayer.Playlist.Manage.Panel);
    vSoundplayer.Playlist.Manage.main.Panel.Name := 'A_SP_Playlist_Manage_Main_Panel';
    vSoundplayer.Playlist.Manage.main.Panel.Parent := vSoundplayer.Playlist.Manage.Panel;
    vSoundplayer.Playlist.Manage.main.Panel.SetBounds(0, 30, 600,
      vSoundplayer.Playlist.Manage.Panel.Height - 30);
    vSoundplayer.Playlist.Manage.main.Panel.Visible := True;

    vSoundplayer.Playlist.Manage.main.Grid := TStringGrid.Create(vSoundplayer.Playlist.Manage.main.Panel);
    vSoundplayer.Playlist.Manage.main.Grid.Name := 'A_SP_Playlist_Manage_Grid';
    vSoundplayer.Playlist.Manage.main.Grid.Parent := vSoundplayer.Playlist.Manage.main.Panel;
    vSoundplayer.Playlist.Manage.main.Grid.SetBounds(10, 10, vSoundplayer.Playlist.Manage.Panel.Width - 70,
      vSoundplayer.Playlist.Manage.Panel.Height - 85);
    vSoundplayer.Playlist.Manage.main.Grid.Options := vSoundplayer.Playlist.Manage.main.Grid.Options +
      [TGridOption.AlternatingRowBackground, TGridOption.ColLines, TGridOption.RowLines,
      TGridOption.RowSelect, TGridOption.Tabs, TGridOption.Header, TGridOption.AutoDisplacement];
    vSoundplayer.Playlist.Manage.main.Grid.OnSelectCell :=
      addons.soundplayer.Input.mouse.Stringgrid.OnSelectSell;
    vSoundplayer.Playlist.Manage.main.Grid.Visible := True;

    for vi := 0 to 3 do
      vSoundplayer.Playlist.Manage.main.Grid.AddObject
        (TStringColumn.Create(vSoundplayer.Playlist.Manage.main.Grid));

    uSoundplayer_Playlist_Manage_AddPlaylistToGrid;
    if addons.soundplayer.Playlist.Active = -1 then
      vSoundplayer.Playlist.Manage.main.Grid.Selected := 0
    else
      vSoundplayer.Playlist.Manage.main.Grid.Selected := addons.soundplayer.Playlist.Active;

    vSoundplayer.Playlist.Manage.main.Grid.Columns[0].Header := 'Num';
    vSoundplayer.Playlist.Manage.main.Grid.Columns[0].Width := 40;
    vSoundplayer.Playlist.Manage.main.Grid.Columns[1].Header := 'Playlist Name';
    vSoundplayer.Playlist.Manage.main.Grid.Columns[1].Width := 100;
    vSoundplayer.Playlist.Manage.main.Grid.Columns[2].Header := 'Playlist Path';
    vSoundplayer.Playlist.Manage.main.Grid.Columns[2].Width :=
      vSoundplayer.Playlist.Manage.main.Grid.Width - 224;
    vSoundplayer.Playlist.Manage.main.Grid.Columns[3].Header := 'Songs';
    vSoundplayer.Playlist.Manage.main.Grid.Columns[3].Width := 60;

    vSoundplayer.Playlist.Manage.main.Load := TButton.Create(vSoundplayer.Playlist.Manage.main.Panel);
    vSoundplayer.Playlist.Manage.main.Load.Name := 'A_SP_Playlist_Manage_LoadButton';
    vSoundplayer.Playlist.Manage.main.Load.Parent := vSoundplayer.Playlist.Manage.main.Panel;
    vSoundplayer.Playlist.Manage.main.Load.SetBounds(50, vSoundplayer.Playlist.Manage.main.Panel.Height -
      36, 100, 25);
    vSoundplayer.Playlist.Manage.main.Load.Text := 'Load';
    vSoundplayer.Playlist.Manage.main.Load.OnClick := addons.soundplayer.Input.mouse.Button.OnMouseClick;
    vSoundplayer.Playlist.Manage.main.Load.Visible := True;

    vSoundplayer.Playlist.Manage.main.Cancel := TButton.Create(vSoundplayer.Playlist.Manage.main.Panel);
    vSoundplayer.Playlist.Manage.main.Cancel.Name := 'A_SP_Playlist_Manage_CancelButton';
    vSoundplayer.Playlist.Manage.main.Cancel.Parent := vSoundplayer.Playlist.Manage.main.Panel;
    vSoundplayer.Playlist.Manage.main.Cancel.SetBounds(vSoundplayer.Playlist.Manage.main.Grid.Width - 150,
      vSoundplayer.Playlist.Manage.main.Panel.Height - 36, 100, 25);
    vSoundplayer.Playlist.Manage.main.Cancel.Text := 'Cancel';
    vSoundplayer.Playlist.Manage.main.Cancel.OnClick := addons.soundplayer.Input.mouse.Button.OnMouseClick;
    vSoundplayer.Playlist.Manage.main.Cancel.Visible := True;

    vSoundplayer.Playlist.Manage.main.Edit := TImage.Create(vSoundplayer.Playlist.Manage.main.Panel);
    vSoundplayer.Playlist.Manage.main.Edit.Name := 'A_SP_Playlist_Manage_Edit';
    vSoundplayer.Playlist.Manage.main.Edit.Parent := vSoundplayer.Playlist.Manage.main.Panel;
    vSoundplayer.Playlist.Manage.main.Edit.SetBounds(vSoundplayer.Playlist.Manage.main.Panel.Width - 44,
      10, 34, 34);
    vSoundplayer.Playlist.Manage.main.Edit.Bitmap.LoadFromFile(addons.soundplayer.Path.Images +
      'sp_lock.png');
    vSoundplayer.Playlist.Manage.main.Edit.WrapMode := TImageWrapMode.Fit;
    vSoundplayer.Playlist.Manage.main.Edit.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
    vSoundplayer.Playlist.Manage.main.Edit.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
    vSoundplayer.Playlist.Manage.main.Edit.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
    vSoundplayer.Playlist.Manage.main.Edit.Visible := True;

    vSoundplayer.Playlist.Manage.main.Edit_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Manage.main.Edit);
    vSoundplayer.Playlist.Manage.main.Edit_Glow.Name := 'A_SP_Playlist_Manage_Edit_Glow';
    vSoundplayer.Playlist.Manage.main.Edit_Glow.Parent := vSoundplayer.Playlist.Manage.main.Edit;
    vSoundplayer.Playlist.Manage.main.Edit_Glow.Softness := 0.4;
    vSoundplayer.Playlist.Manage.main.Edit_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    vSoundplayer.Playlist.Manage.main.Edit_Glow.Opacity := 0.9;
    vSoundplayer.Playlist.Manage.main.Edit_Glow.Enabled := False;

    vSoundplayer.Playlist.Manage.main.Up := TImage.Create(vSoundplayer.Playlist.Manage.main.Panel);
    vSoundplayer.Playlist.Manage.main.Up.Name := 'A_SP_Playlist_Manage_Up';
    vSoundplayer.Playlist.Manage.main.Up.Parent := vSoundplayer.Playlist.Manage.main.Panel;
    vSoundplayer.Playlist.Manage.main.Up.SetBounds(vSoundplayer.Playlist.Manage.main.Panel.Width - 44,
      70, 34, 34);
    vSoundplayer.Playlist.Manage.main.Up.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_up.png');
    vSoundplayer.Playlist.Manage.main.Up.WrapMode := TImageWrapMode.Fit;
    vSoundplayer.Playlist.Manage.main.Up.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
    vSoundplayer.Playlist.Manage.main.Up.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
    vSoundplayer.Playlist.Manage.main.Up.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
    vSoundplayer.Playlist.Manage.main.Up.Visible := True;

    vSoundplayer.Playlist.Manage.main.Up_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Manage.main.Up);
    vSoundplayer.Playlist.Manage.main.Up_Glow.Name := 'A_SP_Playlist_Manage_Edit_Up_Glow';
    vSoundplayer.Playlist.Manage.main.Up_Glow.Parent := vSoundplayer.Playlist.Manage.main.Up;
    vSoundplayer.Playlist.Manage.main.Up_Glow.Softness := 0.4;
    vSoundplayer.Playlist.Manage.main.Up_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    vSoundplayer.Playlist.Manage.main.Up_Glow.Opacity := 0.9;
    vSoundplayer.Playlist.Manage.main.Up_Glow.Enabled := False;

    vSoundplayer.Playlist.Manage.main.Up_Grey :=
      TMonochromeEffect.Create(vSoundplayer.Playlist.Manage.main.Up);
    vSoundplayer.Playlist.Manage.main.Up_Grey.Name := 'A_SP_Playlist_Manage_Up_Grey';
    vSoundplayer.Playlist.Manage.main.Up_Grey.Parent := vSoundplayer.Playlist.Manage.main.Up;
    vSoundplayer.Playlist.Manage.main.Up_Grey.Enabled := True;

    vSoundplayer.Playlist.Manage.main.Down := TImage.Create(vSoundplayer.Playlist.Manage.main.Panel);
    vSoundplayer.Playlist.Manage.main.Down.Name := 'A_SP_Playlist_Manage_Down';
    vSoundplayer.Playlist.Manage.main.Down.Parent := vSoundplayer.Playlist.Manage.main.Panel;
    vSoundplayer.Playlist.Manage.main.Down.SetBounds(vSoundplayer.Playlist.Manage.main.Panel.Width - 44,
      110, 34, 34);
    vSoundplayer.Playlist.Manage.main.Down.Bitmap.LoadFromFile(addons.soundplayer.Path.Images +
      'sp_down.png');
    vSoundplayer.Playlist.Manage.main.Down.WrapMode := TImageWrapMode.Fit;
    vSoundplayer.Playlist.Manage.main.Down.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
    vSoundplayer.Playlist.Manage.main.Down.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
    vSoundplayer.Playlist.Manage.main.Down.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
    vSoundplayer.Playlist.Manage.main.Down.Visible := True;

    vSoundplayer.Playlist.Manage.main.Down_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Manage.main.Down);
    vSoundplayer.Playlist.Manage.main.Down_Glow.Name := 'A_SP_Playlist_Manage_Edit_Down_Glow';
    vSoundplayer.Playlist.Manage.main.Down_Glow.Parent := vSoundplayer.Playlist.Manage.main.Down;
    vSoundplayer.Playlist.Manage.main.Down_Glow.Softness := 0.4;
    vSoundplayer.Playlist.Manage.main.Down_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    vSoundplayer.Playlist.Manage.main.Down_Glow.Opacity := 0.9;
    vSoundplayer.Playlist.Manage.main.Down_Glow.Enabled := False;

    vSoundplayer.Playlist.Manage.main.Down_Grey :=
      TMonochromeEffect.Create(vSoundplayer.Playlist.Manage.main.Down);
    vSoundplayer.Playlist.Manage.main.Down_Grey.Name := 'A_SP_Playlist_Manage_Down_Grey';
    vSoundplayer.Playlist.Manage.main.Down_Grey.Parent := vSoundplayer.Playlist.Manage.main.Down;
    vSoundplayer.Playlist.Manage.main.Down_Grey.Enabled := True;

    vSoundplayer.Playlist.Manage.main.Merge := TImage.Create(vSoundplayer.Playlist.Manage.main.Panel);
    vSoundplayer.Playlist.Manage.main.Merge.Name := 'A_SP_Playlist_Manage_Merge';
    vSoundplayer.Playlist.Manage.main.Merge.Parent := vSoundplayer.Playlist.Manage.main.Panel;
    vSoundplayer.Playlist.Manage.main.Merge.SetBounds(vSoundplayer.Playlist.Manage.main.Panel.Width - 44, 160, 34, 34);
    vSoundplayer.Playlist.Manage.main.Merge.Bitmap.LoadFromFile(addons.soundplayer.Path.Images +
      'sp_merge.png');
    vSoundplayer.Playlist.Manage.main.Merge.WrapMode := TImageWrapMode.Fit;
    vSoundplayer.Playlist.Manage.main.Merge.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
    vSoundplayer.Playlist.Manage.main.Merge.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
    vSoundplayer.Playlist.Manage.main.Merge.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
    vSoundplayer.Playlist.Manage.main.Merge.Visible := True;

    vSoundplayer.Playlist.Manage.main.Merge_Glow :=
      TGlowEffect.Create(vSoundplayer.Playlist.Manage.main.Merge);
    vSoundplayer.Playlist.Manage.main.Merge_Glow.Name := 'A_SP_Playlist_Manage_Edit_Merge_Glow';
    vSoundplayer.Playlist.Manage.main.Merge_Glow.Parent := vSoundplayer.Playlist.Manage.main.Merge;
    vSoundplayer.Playlist.Manage.main.Merge_Glow.Softness := 0.4;
    vSoundplayer.Playlist.Manage.main.Merge_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    vSoundplayer.Playlist.Manage.main.Merge_Glow.Opacity := 0.9;
    vSoundplayer.Playlist.Manage.main.Merge_Glow.Enabled := False;

    vSoundplayer.Playlist.Manage.main.Merge_Grey :=
      TMonochromeEffect.Create(vSoundplayer.Playlist.Manage.main.Merge);
    vSoundplayer.Playlist.Manage.main.Merge_Grey.Name := 'A_SP_Playlist_Manage_Merge_Grey';
    vSoundplayer.Playlist.Manage.main.Merge_Grey.Parent := vSoundplayer.Playlist.Manage.main.Merge;
    vSoundplayer.Playlist.Manage.main.Merge_Grey.Enabled := True;

    vSoundplayer.Playlist.Manage.main.Split := TImage.Create(vSoundplayer.Playlist.Manage.main.Panel);
    vSoundplayer.Playlist.Manage.main.Split.Name := 'A_SP_Playlist_Manage_Split';
    vSoundplayer.Playlist.Manage.main.Split.Parent := vSoundplayer.Playlist.Manage.main.Panel;
    vSoundplayer.Playlist.Manage.main.Split.SetBounds(vSoundplayer.Playlist.Manage.main.Panel.Width - 44, 200, 34, 34);
    vSoundplayer.Playlist.Manage.main.Split.Bitmap.LoadFromFile(addons.soundplayer.Path.Images +
      'sp_split.png');
    vSoundplayer.Playlist.Manage.main.Split.WrapMode := TImageWrapMode.Fit;
    vSoundplayer.Playlist.Manage.main.Split.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
    vSoundplayer.Playlist.Manage.main.Split.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
    vSoundplayer.Playlist.Manage.main.Split.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
    vSoundplayer.Playlist.Manage.main.Split.Visible := True;

    vSoundplayer.Playlist.Manage.main.Split_Glow :=
      TGlowEffect.Create(vSoundplayer.Playlist.Manage.main.Split);
    vSoundplayer.Playlist.Manage.main.Split_Glow.Name := 'A_SP_Playlist_Manage_Edit_Split_Glow';
    vSoundplayer.Playlist.Manage.main.Split_Glow.Parent := vSoundplayer.Playlist.Manage.main.Split;
    vSoundplayer.Playlist.Manage.main.Split_Glow.Softness := 0.4;
    vSoundplayer.Playlist.Manage.main.Split_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    vSoundplayer.Playlist.Manage.main.Split_Glow.Opacity := 0.9;
    vSoundplayer.Playlist.Manage.main.Split_Glow.Enabled := False;

    vSoundplayer.Playlist.Manage.main.Split_Grey :=
      TMonochromeEffect.Create(vSoundplayer.Playlist.Manage.main.Split);
    vSoundplayer.Playlist.Manage.main.Split_Grey.Name := 'A_SP_Playlist_Manage_Split_Grey';
    vSoundplayer.Playlist.Manage.main.Split_Grey.Parent := vSoundplayer.Playlist.Manage.main.Split;
    vSoundplayer.Playlist.Manage.main.Split_Grey.Enabled := True;
    addons.soundplayer.Playlist.Manage_Lock := False;
  end;
end;

procedure uSoundPlayer_Playlist_Manage_Free;
begin
  vSoundplayer.scene.Back_Blur.Enabled := False;
  FreeAndNil(vSoundplayer.Playlist.Manage.Panel);
  uSoundPlayer_Playlist_Actions_OnLeave(vSoundplayer.Playlist.Manage_Icon,
    vSoundplayer.Playlist.Manage_Icon_Glow);
  extrafe.prog.State := 'addon_soundplayer';
end;

///

procedure uSoundplayer_Playlist_Manage_AddPlaylistToGrid;
var
  vi: Integer;
begin
  for vi := 0 to addons.soundplayer.Playlist.Total do
  begin
    vSoundplayer.Playlist.Manage.main.Grid.RowCount := vi + 1;
    vSoundplayer.Playlist.Manage.main.Grid.Cells[0, vi] := (vi + 1).ToString;
    vSoundplayer.Playlist.Manage.main.Grid.Cells[1, vi] := addons.soundplayer.Playlist.List.Playlists
      [vi].Name;
    vSoundplayer.Playlist.Manage.main.Grid.Cells[2, vi] := addons.soundplayer.Playlist.List.Playlists
      [vi].Path;
    vSoundplayer.Playlist.Manage.main.Grid.Cells[3, vi] := addons.soundplayer.Playlist.List.Playlists[vi]
      .Songs.ToString;
  end;
end;

procedure uSoundplayer_Playlist_Manage_LoadPlaylist(vPlaylistNum: Integer);
begin
  if vPlaylistNum <> addons.soundplayer.Playlist.Active then
  begin
    addons.soundplayer.Playlist.Active := vPlaylistNum;
    FreeAndNil(addons.soundplayer.Playlist.List.Playlist);
    FreeAndNil(addons.soundplayer.Playlist.List.Songs);
    BASS_ChannelStop(sound.str_music[1]);
    addons.soundplayer.Ini.Ini.WriteString('Playlists', 'ActivePlaylistName',
      vSoundplayer.Playlist.Manage.main.Grid.Cells[1, vPlaylistNum]);
    addons.soundplayer.Ini.Ini.WriteInteger('Playlists', 'ActivePlaylist',
      addons.soundplayer.Playlist.Active);
    addons.soundplayer.Player.Playing_Now := 0;
    vSoundplayer.Player.Song_Pos.Value := 0;
    vSoundplayer.Player.Song_PlayTime.Text := '00:00:00';
    uSoundPlayer_Actions.Set_WithActivePlaylist(addons.soundplayer.Playlist.Active);
    vSoundplayer.info.Back_Left_Ani.Enabled := True;
    vSoundplayer.info.Back_Left.Position.X := 2;
    vSoundplayer.info.Back_Right_Ani.Enabled := True;
    vSoundplayer.info.Back_Right.Position.X := vSoundplayer.scene.Back_Info.Width - 602;
    uSoundPlayer_Playlist_Manage_Free;
    if vSoundplayer.Playlist.Remove_Icon_Grey.Enabled then
      vSoundplayer.Playlist.Remove_Icon_Grey.Enabled := False
  end;
end;

procedure uSoundplayer_Playlist_Manage_Lock(vActive: Boolean);
begin
  if vActive then
  begin
    vSoundplayer.Playlist.Manage.main.Edit.Bitmap.LoadFromFile(addons.soundplayer.Path.Images +
      'sp_unlock.png');
    BASS_ChannelPlay(addons.soundplayer.Sound.Effects[1], False);
    if vSoundplayer.Playlist.Manage.main.Grid.Selected <> 0 then
      vSoundplayer.Playlist.Manage.main.Up_Grey.Enabled := False;
    if vSoundplayer.Playlist.Manage.main.Grid.Selected <> vSoundplayer.Playlist.Manage.main.Grid.RowCount - 1
    then
      vSoundplayer.Playlist.Manage.main.Down_Grey.Enabled := False;
    vSoundplayer.Playlist.Manage.main.Merge_Grey.Enabled := True;
    vSoundplayer.Playlist.Manage.main.Split_Grey.Enabled := False;
  end
  else
  begin
    vSoundplayer.Playlist.Manage.main.Edit.Bitmap.LoadFromFile(addons.soundplayer.Path.Images +
      'sp_lock.png');
    BASS_ChannelPlay(addons.soundplayer.Sound.Effects[0], False);
    vSoundplayer.Playlist.Manage.main.Up_Grey.Enabled := True;
    vSoundplayer.Playlist.Manage.main.Down_Grey.Enabled := True;
    vSoundplayer.Playlist.Manage.main.Merge_Grey.Enabled := True;
    vSoundplayer.Playlist.Manage.main.Split_Grey.Enabled := True;
  end;
  addons.soundplayer.Playlist.Manage_Lock := vActive;
end;

procedure uSoundplayer_Playlist_Manage_Grid_SelectCell(vSelected: Integer);
begin
  if addons.soundplayer.Playlist.Manage_Lock then
  begin
    if vSelected = 0 then
    begin
      vSoundplayer.Playlist.Manage.main.Up_Grey.Enabled := True;
      if vSoundplayer.Playlist.Manage.main.Grid.RowCount - 1 = 0 then
        vSoundplayer.Playlist.Manage.main.Down_Grey.Enabled := True
      else
        vSoundplayer.Playlist.Manage.main.Down_Grey.Enabled := False;
      vSoundplayer.Playlist.Manage.main.Merge_Grey.Enabled := True;
      vSoundplayer.Playlist.Manage.main.Split_Grey.Enabled := False;
    end
    else if vSelected = vSoundplayer.Playlist.Manage.main.Grid.RowCount - 1 then
    begin
      if vSelected <> 0 then
        vSoundplayer.Playlist.Manage.main.Up_Grey.Enabled := False
      else
        vSoundplayer.Playlist.Manage.main.Up_Grey.Enabled := True;
      vSoundplayer.Playlist.Manage.main.Down_Grey.Enabled := True;
      vSoundplayer.Playlist.Manage.main.Merge_Grey.Enabled := True;
      vSoundplayer.Playlist.Manage.main.Split_Grey.Enabled := False;
    end
    else
    begin
      vSoundplayer.Playlist.Manage.main.Up_Grey.Enabled := False;
      vSoundplayer.Playlist.Manage.main.Down_Grey.Enabled := False;
      vSoundplayer.Playlist.Manage.main.Merge_Grey.Enabled := True;
      vSoundplayer.Playlist.Manage.main.Split_Grey.Enabled := False;
    end;

  end;
  addons.soundplayer.Playlist.Manage_Selected := vSelected;
end;

procedure uSoundplayer_Playlist_Manage_Grid_SelectForMerge(vSelected: Integer);
begin
  ShowMessage('You have selected the ' + addons.soundplayer.Playlist.Manage_Selected.ToString + ' and the ' +
    vSelected.ToString);
  addons.soundplayer.Playlist.Manage_CtrlKey := False;
end;

procedure uSoundplayer_Playlist_Manage_MoveUp(vSelected: Integer);
var
  vPLSelected, vPLMove: TADDON_SOUNDPLAYER_PLAYLIST_PLAYLISTS;
begin
  if addons.soundplayer.Playlist.Manage_Lock then
  begin
    if vSelected = addons.soundplayer.Playlist.Active then
    begin
      Dec(addons.soundplayer.Playlist.Active, 1);
      addons.soundplayer.Ini.Ini.WriteInteger('Playlists', 'ActivePlaylist',
        addons.soundplayer.Playlist.Active);
    end;

    if (vSelected - 1) = addons.soundplayer.Playlist.Active then
    begin
      Inc(addons.soundplayer.Playlist.Active, 1);
      addons.soundplayer.Ini.Ini.WriteInteger('Playlists', 'ActivePlaylist',
        addons.soundplayer.Playlist.Active);
    end;

    vPLSelected := addons.soundplayer.Playlist.List.Playlists[vSelected];
    vPLMove := addons.soundplayer.Playlist.List.Playlists[vSelected - 1];
    addons.soundplayer.Playlist.List.Playlists[vSelected] := vPLMove;
    addons.soundplayer.Playlist.List.Playlists[vSelected - 1] := vPLSelected;
    vSoundplayer.Playlist.Manage.main.Grid.Selected := vSelected - 1;

    uSoundplayer_Playlist_Manage_AddPlaylistToGrid;
    uSoundplayer_Playlist_Actions_SortPlaylistIni;
    if vSelected - 1 = 0 then
    begin
      vSoundplayer.Playlist.Manage.main.Up_Glow.Enabled := False;
      vSoundplayer.Playlist.Manage.main.Up_Grey.Enabled := True;
    end;
  end;
end;

procedure uSoundplayer_Playlist_Manage_MoveDown(vSelected: Integer);
var
  vPLSelected, vPLMove: TADDON_SOUNDPLAYER_PLAYLIST_PLAYLISTS;
begin
  if addons.soundplayer.Playlist.Manage_Lock then
  begin
    if vSelected = addons.soundplayer.Playlist.Active then
    begin
      Inc(addons.soundplayer.Playlist.Active, 1);
      addons.soundplayer.Ini.Ini.WriteInteger('Playlists', 'ActivePlaylist',
        addons.soundplayer.Playlist.Active);
    end;

    if (vSelected + 1) = addons.soundplayer.Playlist.Active then
    begin
      Dec(addons.soundplayer.Playlist.Active, 1);
      addons.soundplayer.Ini.Ini.WriteInteger('Playlists', 'ActivePlaylist',
        addons.soundplayer.Playlist.Active);
    end;

    vPLSelected := addons.soundplayer.Playlist.List.Playlists[vSelected];
    vPLMove := addons.soundplayer.Playlist.List.Playlists[vSelected + 1];
    addons.soundplayer.Playlist.List.Playlists[vSelected] := vPLMove;
    addons.soundplayer.Playlist.List.Playlists[vSelected + 1] := vPLSelected;
    vSoundplayer.Playlist.Manage.main.Grid.Selected := vSelected + 1;

    uSoundplayer_Playlist_Manage_AddPlaylistToGrid;
    uSoundplayer_Playlist_Actions_SortPlaylistIni;
    if vSelected + 1 = addons.soundplayer.Playlist.Total then
    begin
      vSoundplayer.Playlist.Manage.main.Down_Glow.Enabled := False;
      vSoundplayer.Playlist.Manage.main.Down_Grey.Enabled := True;
    end;
  end;
end;

end.
