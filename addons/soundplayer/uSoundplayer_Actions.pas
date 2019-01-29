unit uSoundplayer_Actions;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  System.DateUtils,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Grid,
  FMX.Effects,
  FMX.Types,
  FMX.ImgList,
  ALFmxObjects,
  BASS;

procedure Load;
procedure Free;

procedure Set_FirstTime;
procedure Set_WithActivePlaylist(vPlaylist: Integer);
procedure Set_WithActiveSong;

procedure ShowFirst_Scene(vFirst: Boolean);
procedure CheckFirst(vCheched: Boolean);

implementation

uses
  main,
  uLoad,
  uLoad_AllTypes,
  uMain,
  uWindows,
  uSnippet_Image,
  uSoundplayer_SetAll,
  uSoundplayer_AllTypes,
  uSoundplayer_Sounds,
  uSoundplayer_Player_Actions,
  uSoundplayer_Playlist_Actions,
  uSoundplayer_Player_Volume,
  uSoundplayer_Tag_Mp3_SetAll,
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
        ShowFirst_Scene(addons.Soundplayer.Actions.First);
    end;
  end
  else
    Set_WithActiveSong;

  vSoundplayer.info.Back_Left_Ani.StartValue := vSoundplayer.info.Back_Left.Position.X;
  vSoundplayer.info.Back_Left_Ani.StopValue := vSoundplayer.info.Back_Left.Position.X -
    (vSoundplayer.info.Back_Left.Width - 40);

  vSoundplayer.info.Back_Right_Ani.StartValue := vSoundplayer.info.Back_Right.Position.X;
  vSoundplayer.info.Back_Right_Ani.StopValue := vSoundplayer.info.Back_Right.Position.X +
    (vSoundplayer.info.Back_Right.Width - 40);

  vSoundplayer.info.Back_Left_Ani.Enabled := True;
  vSoundplayer.info.Back_Right_Ani.Enabled := True;

  addons.Soundplayer.info.isCoverInFullscreen := False;

  extrafe.prog.State := 'addon_soundplayer';

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
  addons.Soundplayer.Player.Play := False;
  addons.Soundplayer.Player.Pause := False;
  addons.Soundplayer.Player.Stop := False;
  addons.Soundplayer.Player.Mute := False;
  addons.Soundplayer.Player.Suffle := False;
  addons.Soundplayer.Player.VRepeat := '';
  addons.Soundplayer.Volume.Master := addons.Soundplayer.Ini.Ini.ReadFloat('Volume', 'Master',
    addons.Soundplayer.Volume.Master);
  addons.Soundplayer.Volume.Vol := addons.Soundplayer.Volume.Master * 100;
  uSoundplayer_Player_Volume_Update(addons.Soundplayer.Volume.Vol, 'Both');
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
  addons.Soundplayer.Player.Play := False;
  addons.Soundplayer.Player.Pause := False;
  addons.Soundplayer.Player.Stop := False;
  addons.Soundplayer.Player.Mute := False;
  addons.Soundplayer.Player.Suffle := False;
  addons.Soundplayer.Player.VRepeat := '';
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

  if addons.Soundplayer.Playlist.List.Songs_Num > 0 then
  begin
    uSoundplayer_Playlist_Actions_AddSongs_Load(addons.Soundplayer.Playlist.List.VType, vPlaylist);
    uSoundPlayer_PAction_ShowTagDetails(addons.Soundplayer.Player.Playing_Now);
    vSoundplayer.Player.Play_Grey.Enabled := False;
    vSoundplayer.Player.Stop_Grey.Enabled := False;
    vSoundplayer.Player.Loop_Grey.Enabled := False;
    vSoundplayer.Player.Suffle_Grey.Enabled := False;
    uSoundplayer_Player_Actions_Refresh_SetTheIcons(addons.Soundplayer.Player.Play);
    uSoundplayer_Tag_LoadIcon;
  end
  else
  begin
    addons.Soundplayer.Player.Play := False;
    addons.Soundplayer.Player.Pause := False;
    addons.Soundplayer.Player.Stop := False;
    addons.Soundplayer.Player.Mute := False;
    addons.Soundplayer.Player.Suffle := False;
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
  uSoundplayer_Player_Volume_Update(addons.Soundplayer.Volume.Vol, 'Both');
  addons.Soundplayer.Playlist.Manage_Lock := False;
  addons.Soundplayer.Playlist.Edit := False;
  addons.Soundplayer.Player.Thumb_Active := False;
  uSoundplayer_Playlist_Actions_LoadPlaylists;
end;

procedure Set_WithActiveSong;
var
  vi: Integer;
begin
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

  uSoundPlayer_PAction_ShowTagDetails(addons.Soundplayer.Player.Playing_Now);
  vSoundplayer.info.Playlist_Name.Text := addons.Soundplayer.Playlist.List.Name;
  vSoundplayer.info.Playlist_Type_Kind.Text := addons.Soundplayer.Playlist.List.VType;
  vSoundplayer.info.Total_Songs.Text := (addons.Soundplayer.Player.Playing_Now + 1).ToString + '/' +
    addons.Soundplayer.Playlist.List.Songs_Num.ToString;
  vSoundplayer.info.Time_Total.Text := addons.soundplayer.Playlist.List.Songs_Total_Time;
  vSoundplayer.timer.Song.Enabled := True;
  vSoundplayer.Playlist.List.Selected := addons.Soundplayer.Player.Playing_Now;
  uSoundplayer_Player_Actions_Refresh_SetTheIcons(True);
  uSoundplayer_Player_Volume_Update(addons.Soundplayer.Volume.Vol, 'Both');

  if addons.Soundplayer.Player.VRepeat <> '' then
  begin
    if addons.Soundplayer.Player.VRepeat = 'Song_1' then
      uSoundplayer_Player_Actions_SetRepeat('')
    else if addons.Soundplayer.Player.VRepeat = 'Song_Inf' then
      uSoundplayer_Player_Actions_SetRepeat('Song_1')
    else if addons.Soundplayer.Player.VRepeat = 'List_1' then
      uSoundplayer_Player_Actions_SetRepeat('Song_Inf')
    else if addons.Soundplayer.Player.VRepeat = 'List_Inf' then
      uSoundplayer_Player_Actions_SetRepeat('List_1');
  end;
  addons.Soundplayer.Player.Thumb_Active := False;
  uSoundplayer_Playlist_Actions_LoadPlaylists;
  uSoundplayer_Tag_LoadIcon;
end;

procedure ShowFirst_Scene(vFirst: Boolean);
begin
  if vFirst = False then
  begin
    vSoundplayer.scene.Back_Blur.Enabled := True;

    vSoundplayer.scene.First.Panel := TPanel.Create(vSoundplayer.scene.Soundplayer);
    vSoundplayer.scene.First.Panel.Name := 'A_SP_First';
    vSoundplayer.scene.First.Panel.Parent := vSoundplayer.scene.Soundplayer;
    vSoundplayer.scene.First.Panel.SetBounds(extrafe.res.Half_Width - 400, extrafe.res.Half_Height - 500,
      800, 600);
    vSoundplayer.scene.First.Panel.Visible := True;

    vSoundplayer.scene.First.Panel_Shadow := TShadowEffect.Create(vSoundplayer.scene.First.Panel);
    vSoundplayer.scene.First.Panel_Shadow.Name := 'A_SP_Fist_Shadow';
    vSoundplayer.scene.First.Panel_Shadow.Parent := vSoundplayer.scene.First.Panel;
    vSoundplayer.scene.First.Panel_Shadow.ShadowColor := TAlphaColorRec.Black;
    vSoundplayer.scene.First.Panel_Shadow.Opacity := 0.9;
    vSoundplayer.scene.First.Panel_Shadow.Distance := 2;
    vSoundplayer.scene.First.Panel_Shadow.Direction := 90;
    vSoundplayer.scene.First.Panel_Shadow.Enabled := True;

    uLoad_SetAll_CreateHeader(vSoundplayer.scene.First.Panel, 'A_SP_First',
      addons.Soundplayer.Path.Icon + 'addons_soundplayer_icon.png', 'Welcome to "Soundplayer" addon.');

    vSoundplayer.scene.First.main.Panel := TPanel.Create(vSoundplayer.scene.First.Panel);
    vSoundplayer.scene.First.main.Panel.Name := 'A_SP_Firt_Main';
    vSoundplayer.scene.First.main.Panel.Parent := vSoundplayer.scene.First.Panel;
    vSoundplayer.scene.First.main.Panel.SetBounds(0, 30, vSoundplayer.scene.First.Panel.Width,
      vSoundplayer.scene.First.Panel.Height - 30);
    vSoundplayer.scene.First.main.Panel.Visible := True;

    vSoundplayer.scene.First.main.Line_1 := TALText.Create(vSoundplayer.scene.First.main.Panel);
    vSoundplayer.scene.First.main.Line_1.Name := 'A_SP_First_Main_Line_1';
    vSoundplayer.scene.First.main.Line_1.Parent := vSoundplayer.scene.First.main.Panel;
    vSoundplayer.scene.First.main.Line_1.Width := 700;
    vSoundplayer.scene.First.main.Line_1.Height := 150;
    vSoundplayer.scene.First.main.Line_1.Position.X := 50;
    vSoundplayer.scene.First.main.Line_1.Position.Y := 30;
    vSoundplayer.scene.First.main.Line_1.TextIsHtml := True;
    vSoundplayer.scene.First.main.Line_1.TextSettings.Font.Size := 14;
    vSoundplayer.scene.First.main.Line_1.TextSettings.VertAlign := TTextAlign.Leading;
    vSoundplayer.scene.First.main.Line_1.WordWrap := True;
    vSoundplayer.scene.First.main.Line_1.Text :=
      'I assume this is your first time that open "<font color="#ff63cbfc">Soundplayer</font>" addon.';
    vSoundplayer.scene.First.main.Line_1.Color := TAlphaColorRec.White;
    vSoundplayer.scene.First.main.Line_1.Visible := True;

    vSoundplayer.scene.First.main.Line_2 := TALText.Create(vSoundplayer.scene.First.main.Panel);
    vSoundplayer.scene.First.main.Line_2.Name := 'A_SP_First_Main_Line_2';
    vSoundplayer.scene.First.main.Line_2.Parent := vSoundplayer.scene.First.main.Panel;
    vSoundplayer.scene.First.main.Line_2.Width := 700;
    vSoundplayer.scene.First.main.Line_2.Height := 150;
    vSoundplayer.scene.First.main.Line_2.Position.X := 50;
    vSoundplayer.scene.First.main.Line_2.Position.Y := 60;
    vSoundplayer.scene.First.main.Line_2.TextIsHtml := True;
    vSoundplayer.scene.First.main.Line_2.TextSettings.Font.Size := 14;
    vSoundplayer.scene.First.main.Line_2.TextSettings.VertAlign := TTextAlign.Leading;
    vSoundplayer.scene.First.main.Line_2.WordWrap := True;
    vSoundplayer.scene.First.main.Line_2.Text :=
      'To start listening song just <font color="#ff63cbfc">create a playlist, push the "+" button</font> and then add songs in playlist with the <font color="#ff63cbfc">eject button</font>, push play to start listening.'
      + #13#10 +
      'Or just push the <font color="#ff63cbfc">eject button</font> to listen song in unamed playlist.';
    vSoundplayer.scene.First.main.Line_2.Color := TAlphaColorRec.White;
    vSoundplayer.scene.First.main.Line_2.Visible := True;

    vSoundplayer.scene.First.main.Line_3 := TALText.Create(vSoundplayer.scene.First.main.Panel);
    vSoundplayer.scene.First.main.Line_3.Name := 'A_SP_First_Main_Line_3';
    vSoundplayer.scene.First.main.Line_3.Parent := vSoundplayer.scene.First.main.Panel;
    vSoundplayer.scene.First.main.Line_3.Width := 700;
    vSoundplayer.scene.First.main.Line_3.Height := 150;
    vSoundplayer.scene.First.main.Line_3.Position.X := 50;
    vSoundplayer.scene.First.main.Line_3.Position.Y := 120;
    vSoundplayer.scene.First.main.Line_3.TextIsHtml := True;
    vSoundplayer.scene.First.main.Line_3.TextSettings.Font.Size := 14;
    vSoundplayer.scene.First.main.Line_3.TextSettings.VertAlign := TTextAlign.Leading;
    vSoundplayer.scene.First.main.Line_3.WordWrap := True;
    vSoundplayer.scene.First.main.Line_3.Text :=
      'This message also appears when you deactivate the soundplayer addon and delete all playlists and clear the addon.';
    vSoundplayer.scene.First.main.Line_3.Color := TAlphaColorRec.White;
    vSoundplayer.scene.First.main.Line_3.Visible := True;

    vSoundplayer.scene.First.main.Line_4 := TALText.Create(vSoundplayer.scene.First.main.Panel);
    vSoundplayer.scene.First.main.Line_4.Name := 'A_SP_First_Main_Line_4';
    vSoundplayer.scene.First.main.Line_4.Parent := vSoundplayer.scene.First.main.Panel;
    vSoundplayer.scene.First.main.Line_4.Width := 700;
    vSoundplayer.scene.First.main.Line_4.Height := 150;
    vSoundplayer.scene.First.main.Line_4.Position.X := 50;
    vSoundplayer.scene.First.main.Line_4.Position.Y := 180;
    vSoundplayer.scene.First.main.Line_4.TextIsHtml := True;
    vSoundplayer.scene.First.main.Line_4.TextSettings.Font.Size := 14;
    vSoundplayer.scene.First.main.Line_4.TextSettings.VertAlign := TTextAlign.Leading;
    vSoundplayer.scene.First.main.Line_4.WordWrap := True;
    vSoundplayer.scene.First.main.Line_4.Text :=
      '" <font color="#ffff0000">I love home music. Have Fun </font>" ';
    vSoundplayer.scene.First.main.Line_4.Color := TAlphaColorRec.White;
    vSoundplayer.scene.First.main.Line_4.Visible := True;

    vSoundplayer.scene.First.main.Check := TCheckBox.Create(vSoundplayer.scene.First.main.Panel);
    vSoundplayer.scene.First.main.Check.Name := 'A_SP_First_Main_Check';
    vSoundplayer.scene.First.main.Check.Parent := vSoundplayer.scene.First.main.Panel;
    vSoundplayer.scene.First.main.Check.Width := 400;
    vSoundplayer.scene.First.main.Check.Height := 24;
    vSoundplayer.scene.First.main.Check.Position.X := 20;
    vSoundplayer.scene.First.main.Check.Position.Y := vSoundplayer.scene.First.main.Panel.Height - 70;
    vSoundplayer.scene.First.main.Check.Text := 'Check to never see this message again.';
    vSoundplayer.scene.First.main.Check.FontColor := TAlphaColorRec.White;
    vSoundplayer.scene.First.main.Check.OnClick := addons.Soundplayer.Input.mouse.Checkbox.OnMouseClick;
    vSoundplayer.scene.First.main.Check.Visible := True;

    vSoundplayer.scene.First.main.Done := TButton.Create(vSoundplayer.scene.First.main.Panel);
    vSoundplayer.scene.First.main.Done.Name := 'A_SP_First_Main_Done';
    vSoundplayer.scene.First.main.Done.Parent := vSoundplayer.scene.First.main.Panel;
    vSoundplayer.scene.First.main.Done.Width := 120;
    vSoundplayer.scene.First.main.Done.Height := 30;
    vSoundplayer.scene.First.main.Done.Position.X := (vSoundplayer.scene.First.main.Panel.Width / 2) - 60;
    vSoundplayer.scene.First.main.Done.Position.Y := vSoundplayer.scene.First.main.Panel.Height - 40;
    vSoundplayer.scene.First.main.Done.Text := 'Done';
    vSoundplayer.scene.First.main.Done.OnClick := addons.Soundplayer.Input.mouse.Button.OnMouseClick;
    vSoundplayer.scene.First.main.Done.Visible := True;
  end;

end;

procedure CheckFirst(vCheched: Boolean);
begin
  addons.Soundplayer.Actions.First := vCheched;
  addons.Soundplayer.Ini.Ini.WriteBool('General', 'First', vCheched);
end;

end.
