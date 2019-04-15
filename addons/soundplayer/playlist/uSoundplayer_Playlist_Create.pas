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

procedure Load;
procedure Free;

procedure New(vPlaylistName, vPlaylistType: string);

// Create playlist based types
procedure m3u(mPlaylistName: string; mNum: SmallInt);
procedure pls(mPlaylistName: string; mNum: SmallInt);
procedure asx(mPlaylistName: string; mNum: SmallInt);
procedure xspf(mPlaylistName: string; mNum: SmallInt);
procedure wpl(mPlaylistName: string; mNum: SmallInt);
procedure expl(mPlaylistName: string; mNum: SmallInt);

implementation
uses
  uLoad_AllTypes,
  uWindows,
  uSoundplayer_AllTypes,
  uSoundplayer,
  uSoundplayer_Playlist,
  uSoundplayer_Player,
  uSoundplayer_Playlist_Const;

procedure Load;
begin
  vSoundplayer.scene.Back_Blur.Enabled := True;

  uSoundplayer.Hide_Animations;

  vSoundplayer.Playlist.Create.Panel := TPanel.Create(vSoundplayer.scene.soundplayer);
  vSoundplayer.Playlist.Create.Panel.Name := 'A_SP_Playlist_Create_Panel';
  vSoundplayer.Playlist.Create.Panel.Parent := vSoundplayer.scene.soundplayer;
  vSoundplayer.Playlist.Create.Panel.SetBounds((vSoundplayer.scene.soundplayer.Width / 2) - 250, (vSoundplayer.scene.soundplayer.Height / 2) - 125, 500, 150);
  vSoundplayer.Playlist.Create.Panel.Visible := True;

  uLoad_SetAll_CreateHeader(vSoundplayer.Playlist.Create.Panel, 'A_SP_Playlist_Create_Panel', addons.soundplayer.Path.Images + 'sp_add.png',
    'Create a new playlist.');

  vSoundplayer.Playlist.Create.main.Panel := TPanel.Create(vSoundplayer.Playlist.Create.Panel);
  vSoundplayer.Playlist.Create.main.Panel.Name := 'A_SP_Playlist_Create_Panel_Main';
  vSoundplayer.Playlist.Create.main.Panel.Parent := vSoundplayer.Playlist.Create.Panel;
  vSoundplayer.Playlist.Create.main.Panel.SetBounds(0, 30, vSoundplayer.Playlist.Create.Panel.Width, vSoundplayer.Playlist.Create.Panel.Height - 30);
  vSoundplayer.Playlist.Create.main.Panel.Visible := True;

  vSoundplayer.Playlist.Create.main.Text := TLabel.Create(vSoundplayer.Playlist.Create.main.Panel);
  vSoundplayer.Playlist.Create.main.Text.Name := 'A_SP_Playlist_Create_Label';
  vSoundplayer.Playlist.Create.main.Text.Parent := vSoundplayer.Playlist.Create.main.Panel;
  vSoundplayer.Playlist.Create.main.Text.SetBounds(10, 12, 300, 24);
  vSoundplayer.Playlist.Create.main.Text.Text := 'Write the name of the playlist';
  vSoundplayer.Playlist.Create.main.Text.Font.Style := vSoundplayer.Playlist.Create.main.Text.Font.Style + [TFontStyle.fsBold];
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
  vSoundplayer.Playlist.Create.main.Text_Type.Font.Style := vSoundplayer.Playlist.Create.main.Text_Type.Font.Style + [TFontStyle.fsBold];
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
  vSoundplayer.Playlist.Create.main.Create.SetBounds(50, vSoundplayer.Playlist.Create.main.Panel.Height - 40, 100, 25);
  vSoundplayer.Playlist.Create.main.Create.Text := 'Create';
  vSoundplayer.Playlist.Create.main.Create.OnClick := addons.soundplayer.Input.mouse.Button.OnMouseClick;
  vSoundplayer.Playlist.Create.main.Create.Visible := True;

  vSoundplayer.Playlist.Create.main.Cancel := TButton.Create(vSoundplayer.Playlist.Create.main.Panel);
  vSoundplayer.Playlist.Create.main.Cancel.Name := 'A_SP_Playlist_Create_CancelButton';
  vSoundplayer.Playlist.Create.main.Cancel.Parent := vSoundplayer.Playlist.Create.main.Panel;
  vSoundplayer.Playlist.Create.main.Cancel.SetBounds(vSoundplayer.Playlist.Create.main.Panel.Width - 150, vSoundplayer.Playlist.Create.main.Panel.Height -
    40, 100, 25);
  vSoundplayer.Playlist.Create.main.Cancel.Text := 'Cancel';
  vSoundplayer.Playlist.Create.main.Cancel.OnClick := addons.soundplayer.Input.mouse.Button.OnMouseClick;
  vSoundplayer.Playlist.Create.main.Cancel.Visible := True;

  vSoundplayer.Playlist.Create.main.Edit.SetFocus;

  extrafe.prog.State := 'addon_soundplayer_create_playlist';
end;

procedure Free;
begin
  vSoundplayer.scene.Back_Blur.Enabled := False;
  FreeAndNil(vSoundplayer.Playlist.Create.Panel);
  uSoundplayer_Player.Text_OnLeave(vSoundplayer.Playlist.Create_Icon, vSoundplayer.Playlist.Create_Icon_Glow);
  extrafe.prog.State := 'addon_soundplayer';
end;

procedure New(vPlaylistName, vPlaylistType: string);
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
      uSoundplayer_Playlist_Create.m3u(vPlaylistName, mNum)
    else if vPlaylistType = 'pls' then
      uSoundplayer_Playlist_Create.pls(vPlaylistName, mNum)
    else if vPlaylistType = 'asx' then
      uSoundplayer_Playlist_Create.asx(vPlaylistName, mNum)
    else if vPlaylistType = 'xspf' then
      uSoundplayer_Playlist_Create.xspf(vPlaylistName, mNum)
    else if vPlaylistType = 'wpl' then
      uSoundplayer_Playlist_Create.wpl(vPlaylistName, mNum)
    else if vPlaylistType = 'expl' then
      uSoundplayer_Playlist_Create.expl(vPlaylistName, mNum);

    uSoundplayer_Playlist_Const.New_State(vPlaylistName, vPlaylistType);
    Free;
  end
  else
    ShowMessage('There is allready a playlist with this name.');
end;

// Create playlist based types
procedure m3u(mPlaylistName: string; mNum: SmallInt);
begin
  addons.soundplayer.Playlist.List.Playlist := TStringList.Create;
  addons.soundplayer.Playlist.List.Playlist.Add('#EXTM3U');
  addons.soundplayer.Playlist.List.Playlist.SaveToFile(addons.soundplayer.Path.Playlists + mPlaylistName + '.m3u');
  addons.soundplayer.Playlist.List.Name := mPlaylistName;
  addons.soundplayer.Playlist.List.vType := '.m3u';
  addons.soundplayer.Playlist.List.Num := mNum;
  addons.soundplayer.Playlist.List.Played := 0;
  addons.soundplayer.Playlist.List.Last_Played := DateTimeToStr(Now);
  addons.soundplayer.Playlist.List.Songs_Num := 0;
  addons.soundplayer.Playlist.List.Songs := TStringList.Create;

  addons.soundplayer.Playlist.Total := mNum;
  addons.soundplayer.Playlist.Active := mNum;
  addons.soundplayer.Playlist.List.Name := mPlaylistName;

  addons.soundplayer.Ini.Ini.WriteInteger('Playlists', 'TotalPlaylists', addons.soundplayer.Playlist.Total);
  addons.soundplayer.Ini.Ini.WriteInteger('Playlists', 'ActivePlaylist', addons.soundplayer.Playlist.Active);
  addons.soundplayer.Ini.Ini.WriteString('Playlists', 'ActivePlaylistName', addons.soundplayer.Playlist.List.Name);
  addons.soundplayer.Ini.Ini.WriteString('Playlists', 'PL_' + IntToStr(mNum) + '_Name', addons.soundplayer.Playlist.List.Name);
  addons.soundplayer.Ini.Ini.WriteString('Playlists', 'PL_' + IntToStr(mNum) + '_Path', addons.soundplayer.Path.Playlists);
  addons.soundplayer.Ini.Ini.WriteString('Playlists', 'PL_' + IntToStr(mNum) + '_Type', '.m3u');
  addons.soundplayer.Ini.Ini.WriteInteger('Playlists', 'PL_' + IntToStr(mNum) + '_Songs', 0);
  addons.soundplayer.Ini.Ini.WriteInteger('Playlists', 'Pl_' + IntToStr(mNum) + '_Played', 0);
  addons.soundplayer.Ini.Ini.WriteString('Playlists', 'PL_' + IntToStr(mNum) + '_LastPlayed', DateTimeToStr(Now));

  vSoundplayer.info.Playlist_name.Text := mPlaylistName;
end;

procedure pls(mPlaylistName: string; mNum: SmallInt);
begin

end;

procedure asx(mPlaylistName: string; mNum: SmallInt);
begin

end;

procedure xspf(mPlaylistName: string; mNum: SmallInt);
begin

end;

procedure wpl(mPlaylistName: string; mNum: SmallInt);
begin

end;

procedure expl(mPlaylistName: string; mNum: SmallInt);
begin

end;

end.
