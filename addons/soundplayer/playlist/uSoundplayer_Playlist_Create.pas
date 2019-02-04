unit uSoundplayer_Playlist_Create;

interface

uses
  System.Classes,
  System.UiTypes,
  System.SysUtils,
  FMX.StdCtrls,
  FMX.Edit,
  FMX.Objects,
  FMX.Listbox,
  FMX.Dialogs,
  Bass;

procedure uSoundPlayer_Playlist_Create_Panel;
procedure uSoundPlayer_Playlist_Create_Free;

procedure uSoundPlayer_Playlist_Create_NewPlaylist(vPlaylistName, vPlaylistType: string);

implementation

uses
  uLoad_AllTypes,
  uWindows,
  uSoundplayer_AllTypes,
  uSoundplayer,
  uSoundplayer_Playlist_Actions,
  uSoundplayer_Player;

procedure uSoundPlayer_Playlist_Create_Panel;
begin
  vSoundplayer.scene.Back_Blur.Enabled := True;

  uSoundplayer.Hide_Animations;

  vSoundplayer.Playlist.Create.Panel := TPanel.Create(vSoundplayer.scene.soundplayer);
  vSoundplayer.Playlist.Create.Panel.Name := 'A_SP_Playlist_Create_Panel';
  vSoundplayer.Playlist.Create.Panel.Parent := vSoundplayer.scene.soundplayer;
  vSoundplayer.Playlist.Create.Panel.SetBounds((vSoundplayer.scene.soundplayer.Width / 2) - 250,
    (vSoundplayer.scene.soundplayer.Height / 2) - 125, 500, 150);
  vSoundplayer.Playlist.Create.Panel.Visible := True;

  uLoad_SetAll_CreateHeader(vSoundplayer.Playlist.Create.Panel, 'A_SP_Playlist_Create_Panel',
    addons.soundplayer.Path.Images + 'sp_add.png', 'Create a new playlist.');

  vSoundplayer.Playlist.Create.main.Panel := TPanel.Create(vSoundplayer.Playlist.Create.Panel);
  vSoundplayer.Playlist.Create.main.Panel.Name := 'A_SP_Playlist_Create_Panel_Main';
  vSoundplayer.Playlist.Create.main.Panel.Parent := vSoundplayer.Playlist.Create.Panel;
  vSoundplayer.Playlist.Create.main.Panel.SetBounds(0, 30, vSoundplayer.Playlist.Create.Panel.Width,
    vSoundplayer.Playlist.Create.Panel.Height - 30);
  vSoundplayer.Playlist.Create.main.Panel.Visible := True;

  vSoundplayer.Playlist.Create.main.Text := TLabel.Create(vSoundplayer.Playlist.Create.main.Panel);
  vSoundplayer.Playlist.Create.main.Text.Name := 'A_SP_Playlist_Create_Label';
  vSoundplayer.Playlist.Create.main.Text.Parent := vSoundplayer.Playlist.Create.main.Panel;
  vSoundplayer.Playlist.Create.main.Text.SetBounds(10, 12, 300, 24);
  vSoundplayer.Playlist.Create.main.Text.Text := 'Write the name of the playlist';
  vSoundplayer.Playlist.Create.main.Text.Font.Style := vSoundplayer.Playlist.Create.main.Text.Font.Style +
    [TFontStyle.fsBold];
  vSoundplayer.Playlist.Create.main.Text.Visible := True;

  vSoundplayer.Playlist.Create.main.Edit := TEdit.Create(vSoundplayer.Playlist.Create.main.Panel);
  vSoundplayer.Playlist.Create.main.Edit.Name := 'A_SP_Playlist_Creat_Edit';
  vSoundplayer.Playlist.Create.main.Edit.Parent := vSoundplayer.Playlist.Create.main.Panel;
  vSoundplayer.Playlist.Create.main.Edit.SetBounds(10, 35, 400, 24);
  vSoundplayer.Playlist.Create.main.Edit.Text := '';
  vSoundplayer.Playlist.Create.main.Edit.Visible := True;

  vSoundplayer.Playlist.Create.main.Text_Type := TLabel.Create(vSoundplayer.Playlist.Create.main.Panel);
  vSoundplayer.Playlist.Create.main.Text_Type.Name := 'A_SP_Playlist_Create_Label_Type';
  vSoundplayer.Playlist.Create.main.Text_Type.Parent := vSoundplayer.Playlist.Create.main.Panel;
  vSoundplayer.Playlist.Create.main.Text_Type.SetBounds(420, 12, 100, 24);
  vSoundplayer.Playlist.Create.main.Text_Type.Text := 'Choose type';
  vSoundplayer.Playlist.Create.main.Text_Type.Font.Style :=
    vSoundplayer.Playlist.Create.main.Text_Type.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.Playlist.Create.main.Text_Type.Visible := True;

  vSoundplayer.Playlist.Create.main.Main_Type := TComboBox.Create(vSoundplayer.Playlist.Create.main.Panel);
  vSoundplayer.Playlist.Create.main.Main_Type.Name := 'A_SP_Playlist_Create_Type';
  vSoundplayer.Playlist.Create.main.Main_Type.Parent := vSoundplayer.Playlist.Create.main.Panel;
  vSoundplayer.Playlist.Create.main.Main_Type.SetBounds(420, 35, 70, 24);
  vSoundplayer.Playlist.Create.main.Main_Type.Items.Add('.m3u');
  vSoundplayer.Playlist.Create.main.Main_Type.ItemIndex := 0;
  vSoundplayer.Playlist.Create.main.Main_Type.Visible := True;

  vSoundplayer.Playlist.Create.main.Create := TButton.Create(vSoundplayer.Playlist.Create.main.Panel);
  vSoundplayer.Playlist.Create.main.Create.Name := 'A_SP_Playlist_Create_CreateButton';
  vSoundplayer.Playlist.Create.main.Create.Parent := vSoundplayer.Playlist.Create.main.Panel;
  vSoundplayer.Playlist.Create.main.Create.SetBounds(50, vSoundplayer.Playlist.Create.main.Panel.Height -
    40, 100, 25);
  vSoundplayer.Playlist.Create.main.Create.Text := 'Create';
  vSoundplayer.Playlist.Create.main.Create.OnClick := addons.soundplayer.Input.mouse.Button.OnMouseClick;
  vSoundplayer.Playlist.Create.main.Create.Visible := True;

  vSoundplayer.Playlist.Create.main.Cancel := TButton.Create(vSoundplayer.Playlist.Create.main.Panel);
  vSoundplayer.Playlist.Create.main.Cancel.Name := 'A_SP_Playlist_Create_CancelButton';
  vSoundplayer.Playlist.Create.main.Cancel.Parent := vSoundplayer.Playlist.Create.main.Panel;
  vSoundplayer.Playlist.Create.main.Cancel.SetBounds(vSoundplayer.Playlist.Create.main.Panel.Width - 150,
    vSoundplayer.Playlist.Create.main.Panel.Height - 40, 100, 25);
  vSoundplayer.Playlist.Create.main.Cancel.Text := 'Cancel';
  vSoundplayer.Playlist.Create.main.Cancel.OnClick := addons.soundplayer.Input.mouse.Button.OnMouseClick;
  vSoundplayer.Playlist.Create.main.Cancel.Visible := True;

  vSoundplayer.Playlist.Create.main.Edit.SetFocus;

  extrafe.prog.State := 'addon_soundplayer_create_playlist';
end;

procedure uSoundPlayer_Playlist_Create_Free;
begin
  vSoundplayer.scene.Back_Blur.Enabled := False;
  FreeAndNil(vSoundplayer.Playlist.Create.Panel);
  uSoundplayer_Player.OnOver(vSoundplayer.Playlist.Create_Icon,
    vSoundplayer.Playlist.Create_Icon_Glow);
  extrafe.prog.State := 'addon_soundplayer';
end;

procedure uSoundPlayer_Playlist_Create_NewPlaylist(vPlaylistName, vPlaylistType: string);
var
  mNum: SmallInt;
  vLists: TStringList;
  vi: Integer;
  vFoundTheSame: Boolean;
begin
  vFoundTheSame := False;
  vLists := TStringList.Create;
  vLists := uWindows_GetFileNames(addons.soundplayer.Path.Playlists, '*.*');
  for vi := 0 to vLists.Count - 1 do
  begin
    if (vPlaylistName + vPlaylistType) = vLists.Strings[vi] then
      vFoundTheSame := True;
  end;

  if vFoundTheSame = False then
  begin
    mNum := addons.soundplayer.Playlist.Total;
    Inc(mNum, 1);
    if vPlaylistType = '.m3u' then
      NewPlaylist_m3u(vPlaylistName, mNum)
    else if vPlaylistType = 'pls' then
      NewPlaylist_pls(vPlaylistName, mNum)
    else if vPlaylistType = 'asx' then
      NewPlaylist_asx(vPlaylistName, mNum)
    else if vPlaylistType = 'xspf' then
      NewPlaylist_xspf(vPlaylistName, mNum)
    else if vPlaylistType = 'wpl' then
      NewPlaylist_wpl(vPlaylistName, mNum)
    else if vPlaylistType = 'expl' then
      NewPlaylist_expl(vPlaylistName, mNum);
    if addons.soundplayer.Player.Play then
    begin
      BASS_ChannelStop(sound.str_music[1]);
      vSoundplayer.Player.Song_Pos.Value := 0;
    end;
    uSoundPlayer.Set_FirstTime;
    vSoundplayer.info.Playlist_name.Text := vPlaylistName;
    vSoundplayer.info.Playlist_Type_Kind.Text := vPlaylistType;
    vSoundplayer.info.Total_Songs.Text := '0';
    vSoundplayer.info.Time_Total.Text := '00:00:00';
    vSoundplayer.Playlist.Manage_Icon_Grey.Enabled := False;
    vSoundplayer.Playlist.Remove_Icon_Grey.Enabled := False;
    vSoundplayer.Playlist.List.RowCount := -1;
    uSoundPlayer_Playlist_Create_Free;
  end
  else
    ShowMessage('There is allready a playlist with this name.');
end;

end.
