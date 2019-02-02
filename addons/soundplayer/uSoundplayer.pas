unit uSoundplayer;

interface

uses
  System.Classes,
  System.SysUtils;

procedure Load;
procedure Free;

procedure Set_FirstTime;
procedure Set_WithActivePlaylist(vPlaylist: Integer);
procedure Set_WithActiveSong;
procedure Set_Animations;

procedure CheckFirst(vCheched: Boolean);

implementation

uses
  uLoad_AllTypes,
  uSoundplayer_SetAll,
  uSoundplayer_AllTypes,
  uSoundplayer_Sounds,
  uSoundplayer_Player,
  uSoundplayer_Playlist_Actions,
  uSoundplayer_Player_Volume,
  uSoundplayer_Tag_Get,
  uSoundplayer_Tag_Mp3;

procedure Load;
begin
  extrafe.prog.State := 'addon_soundplayer_loading';

  uSoundplayer_Sounds.Load;

  if addons.Soundplayer.Player.Play = False then
  begin
    if (addons.Soundplayer.Playlist.Total <> -1) and (addons.Soundplayer.Playlist.Active <> -1) then
      Set_WithActivePlaylist(addons.Soundplayer.Playlist.Active)
    else
    begin
      Set_FirstTime;
      if addons.Soundplayer.Playlist.Total <> -1 then
        if addons.Soundplayer.Actions.First = False then
          uSoundplayer_SetAll.Set_First;
    end;
  end
  else
    Set_WithActiveSong;

  Set_Animations;
  extrafe.prog.State := 'addon_soundplayer';
  uSoundplayer_Player_Volume.Update(addons.Soundplayer.Volume.Vol);
end;

procedure Free;
begin
  if Assigned(vSoundplayer.scene.Soundplayer) then
  begin
    uSoundplayer_Sounds.Free;
    FreeAndNil(vSoundplayer.scene.ImgList);
    FreeAndNil(vSoundplayer.scene.Soundplayer);
  end;
end;

/// /////////////////////////////////////////////////////////////////////////////
procedure Set_FirstTime;
var
  vi, ki: Integer;
begin
  uSoundplayer_Player.State(False, False, False, False, False, '');
  addons.Soundplayer.Volume.Master := addons.Soundplayer.Ini.Ini.ReadFloat('Volume', 'Master',
    addons.Soundplayer.Volume.Master);
  addons.Soundplayer.Volume.Vol := addons.Soundplayer.Volume.Master * 100;
  addons.Soundplayer.Player.Song_State := 0;
  addons.Soundplayer.Player.Time_Negative := False;
  vSoundplayer.Player.Song_Pos.Value := 0;

  vSoundplayer.Player.Song_Title.Text := '';
  vSoundplayer.Player.Song_Tag.Visible := False;
  vSoundplayer.Player.Play_Grey.Enabled := True;
  vSoundplayer.Player.Stop_Grey.Enabled := True;
  vSoundplayer.Player.Previous_Grey.Enabled := True;
  vSoundplayer.Player.Next_Grey.Enabled := True;
  vSoundplayer.Player.Loop_Grey.Enabled := True;
  vSoundplayer.Player.Suffle_Grey.Enabled := True;
  vSoundplayer.Player.Song_Time.Text := '00:00:00';
  vSoundplayer.Player.Song_PlayTime.Text := '00:00:00';

  vSoundplayer.info.Song_Title.Text := '';
  vSoundplayer.info.Artist_Name.Text := '';
  vSoundplayer.info.Year_Publish.Text := '';
  vSoundplayer.info.Gerne_Kind.Text := '';
  vSoundplayer.info.Track_Num.Text := '';
  vSoundplayer.info.Playlist_Name.Text := '';
  vSoundplayer.info.Playlist_Type_Kind.Text := '';
  vSoundplayer.info.Total_Songs.Text := '';
  vSoundplayer.info.Time_Total.Text := '';
  vSoundplayer.info.Cover.Bitmap := nil;

  for vi := 0 to vSoundplayer.Playlist.List.ColumnCount - 1 do
    for ki := 0 to vSoundplayer.Playlist.List.RowCount - 1 do
      vSoundplayer.Playlist.List.Cells[vi, ki] := '';
  if addons.Soundplayer.Playlist.Total <> -1 then
    vSoundplayer.Playlist.Manage_Icon_Grey.Enabled := False
  else
    vSoundplayer.Playlist.Manage_Icon_Grey.Enabled := True;
  vSoundplayer.Playlist.Remove_Icon_Grey.Enabled := True;
  addons.Soundplayer.Playlist.Manage_Lock := False;
  addons.Soundplayer.Playlist.Edit := False;
  addons.Soundplayer.Player.Thumb_Active := False;
end;

procedure Set_WithActivePlaylist(vPlaylist: Integer);
begin
  uSoundplayer_Player.State(False, False, addons.Soundplayer.Player.Stop, False,
    addons.Soundplayer.Player.Suffle, '');
  addons.Soundplayer.Volume.Vol := addons.Soundplayer.Volume.Master * 100;
  addons.Soundplayer.Player.Song_State := 0;
  addons.Soundplayer.Player.Time_Negative := False;

  addons.Soundplayer.Playlist.List.Num := vPlaylist;

  addons.Soundplayer.Playlist.List.Playlist := TStringList.Create;
  addons.Soundplayer.Playlist.List.Songs := TStringList.Create;

  addons.Soundplayer.Playlist.List.Name := addons.Soundplayer.Ini.Ini.ReadString('Playlists',
    'ActivePlaylistName', addons.Soundplayer.Playlist.List.Name);
  addons.Soundplayer.Playlist.List.VType := addons.Soundplayer.Ini.Ini.ReadString('Playlists',
    'PL_' + IntToStr(addons.Soundplayer.Playlist.Active) + '_Type', addons.Soundplayer.Playlist.List.VType);
  addons.Soundplayer.Playlist.List.Songs_Num := addons.Soundplayer.Ini.Ini.ReadInteger('Playlists',
    'PL_' + IntToStr(vPlaylist) + '_Songs', addons.Soundplayer.Playlist.List.Songs_Num);

  addons.Soundplayer.Playlist.List.Playlist.LoadFromFile(addons.Soundplayer.Path.Playlists +
    addons.Soundplayer.Playlist.List.Name + addons.Soundplayer.Playlist.List.VType);
  uSoundplayer_Tag_Mp3.APICIndex := 0;

  if addons.Soundplayer.Playlist.List.Songs_Num > 0 then
  begin
    uSoundplayer_Playlist_Actions_AddSongs_Load(addons.Soundplayer.Playlist.List.VType, vPlaylist);
    uSoundplayer_Player.Get_Tag(addons.Soundplayer.Player.Playing_Now);
    vSoundplayer.Player.Play_Grey.Enabled := False;
    vSoundplayer.Player.Stop_Grey.Enabled := False;
    vSoundplayer.Player.Loop_Grey.Enabled := False;
    vSoundplayer.Player.Suffle_Grey.Enabled := False;
    uSoundplayer_Player.Set_ActionsButtons(addons.Soundplayer.Player.Play);
    uSoundplayer_Tag_Get.Set_Icon;
  end
  else
  begin
    vSoundplayer.Player.Song_Tag.Visible := False;
    vSoundplayer.Player.Play_Grey.Enabled := True;
    vSoundplayer.Player.Stop_Grey.Enabled := True;
    vSoundplayer.Player.Previous_Grey.Enabled := True;
    vSoundplayer.Player.Next_Grey.Enabled := True;
    vSoundplayer.Player.Loop_Grey.Enabled := True;
    vSoundplayer.Player.Suffle_Grey.Enabled := True;
  end;
  vSoundplayer.info.Playlist_Name.Text := addons.Soundplayer.Playlist.List.Name;
  vSoundplayer.info.Playlist_Type_Kind.Text := addons.Soundplayer.Playlist.List.VType;
  addons.Soundplayer.Playlist.Manage_Lock := False;
  addons.Soundplayer.Playlist.Edit := False;
  addons.Soundplayer.Player.Thumb_Active := False;
  uSoundplayer_Playlist_Actions_LoadPlaylists;
end;

procedure Set_WithActiveSong;
var
  vi: Integer;
begin
  // Update the playlist
  vSoundplayer.Playlist.List.RowCount := addons.Soundplayer.Playlist.List.Songs_Num;
  for vi := 0 to addons.Soundplayer.Playlist.List.Songs_Num - 1 do
  begin
    vSoundplayer.Playlist.List.Cells[0, vi] := IntToStr(vi + 1);
    vSoundplayer.Playlist.List.Cells[1, vi] := '3';
    vSoundplayer.Playlist.List.Cells[2, vi] := addons.Soundplayer.Playlist.List.Song_Info[vi].Title;
    vSoundplayer.Playlist.List.Cells[3, vi] := addons.Soundplayer.Playlist.List.Song_Info[vi].Artist;
    vSoundplayer.Playlist.List.Cells[4, vi] := addons.Soundplayer.Playlist.List.Song_Info[vi].Track_Seconds;
    if addons.Soundplayer.Playlist.List.Song_Info[vi].Disk_Type = '.mp3' then
      vSoundplayer.Playlist.List.Cells[5, vi] := '8'
    else if addons.Soundplayer.Playlist.List.Song_Info[vi].Disk_Type = '.ogg' then
      vSoundplayer.Playlist.List.Cells[5, vi] := '9'
    else
      vSoundplayer.Playlist.List.Cells[5, vi] := '10';
  end;

  if addons.Soundplayer.Player.Play then
    vSoundplayer.Playlist.List.Cells[1, addons.Soundplayer.Player.Playing_Now] := '0'
  else if addons.Soundplayer.Player.Stop then
    vSoundplayer.Playlist.List.Cells[1, addons.Soundplayer.Player.Playing_Now] := '1'
  else if addons.Soundplayer.Player.Pause then
    vSoundplayer.Playlist.List.Cells[1, addons.Soundplayer.Player.Playing_Now] := '2';
  vSoundplayer.Playlist.List.Selected := addons.Soundplayer.Player.Playing_Now;
  uSoundplayer_Playlist_Actions_LoadPlaylists;
  // Get Tag and full info with details
  uSoundplayer_Player.Get_Tag(addons.Soundplayer.Player.Playing_Now);
  vSoundplayer.info.Playlist_Name.Text := addons.Soundplayer.Playlist.List.Name;
  vSoundplayer.info.Playlist_Type_Kind.Text := addons.Soundplayer.Playlist.List.VType;
  vSoundplayer.info.Total_Songs.Text := (addons.Soundplayer.Player.Playing_Now + 1).ToString + '/' +
    addons.Soundplayer.Playlist.List.Songs_Num.ToString;
  vSoundplayer.info.Time_Total.Text := addons.Soundplayer.Playlist.List.Songs_Total_Time;
  vSoundplayer.timer.Song.Enabled := True;
  uSoundplayer_Tag_Get.Set_Icon;
  // Set the buttons
  uSoundplayer_Player.Set_ActionsButtons(True);
  if addons.Soundplayer.Player.VRepeat <> '' then
  begin
    if addons.Soundplayer.Player.VRepeat = 'Song_1' then
      uSoundplayer_Player.Set_Repeat('')
    else if addons.Soundplayer.Player.VRepeat = 'Song_Inf' then
      uSoundplayer_Player.Set_Repeat('Song_1')
    else if addons.Soundplayer.Player.VRepeat = 'List_1' then
      uSoundplayer_Player.Set_Repeat('Song_Inf')
    else if addons.Soundplayer.Player.VRepeat = 'List_Inf' then
      uSoundplayer_Player.Set_Repeat('List_1');
  end;
  addons.Soundplayer.Player.Thumb_Active := False;
end;

procedure Set_Animations;
begin
  vSoundplayer.Info.Back_Left.Position.X:= 2;
  vSoundplayer.info.Back_Left_Ani.StartValue := 2;
  vSoundplayer.info.Back_Left_Ani.StopValue := -558;

  vSoundplayer.Info.Back_Right.Position.X:= 1318;
  vSoundplayer.info.Back_Right_Ani.StartValue := 1318;
  vSoundplayer.info.Back_Right_Ani.StopValue := 1878;

  vSoundplayer.info.Back_Left_Ani.Start;
  vSoundplayer.info.Back_Right_Ani.Start;

  addons.Soundplayer.info.isCoverInFullscreen := False;
end;

procedure CheckFirst(vCheched: Boolean);
begin
  addons.Soundplayer.Actions.First := vCheched;
  addons.Soundplayer.Ini.Ini.WriteBool('General', 'First', vCheched);
end;

end.
