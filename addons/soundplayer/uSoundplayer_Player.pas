unit uSoundplayer_Player;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UITypes,
  FMX.Types,
  FMX.Objects,
  FMX.Effects,
  FMX.Graphics,
  FMX.Grid,
  bass;

procedure State(vPlay, vPause, vStop, vMute, vSuffle: Boolean; vRepeat: String);

procedure Refresh;
procedure Refresh_GoTo(vGo: Integer; vPlay: Boolean);

procedure OnOver(vImage: TImage; vGlow: TGlowEffect);
procedure OnLeave(vImage: TImage; vGlow: TGlowEffect);

procedure Text_OnOver(vText: TText; vGlow: TGlowEffect);
procedure Text_OnLeave(vText: TText; vGlow: TGlowEffect);

procedure StartOrPause;
procedure Stop;
procedure Previous;
procedure Next;
procedure Set_Previous_Next;

procedure Set_Repeat(vCurrent: String);
procedure Inc_LoopState;
procedure Suffle;
procedure Suffle_GoTo;
procedure Show_Tag(vSongName: String; vSongNum: Integer);

procedure Title_Animation;
procedure Get_Tag(vSongNum: SmallInt);

// Song position
procedure Update_Thumb_Pos(Sender: TObject; vValue: Single; vKeep: Boolean);

// Add new songs
procedure uSoundplayer_Player_AddNewSongs;

// Add songs in playlist based types
procedure AddSongs_In_m3u(mPlaylistNum: SmallInt; mTrackName, mTrackPath: string; mSongNum: SmallInt);
procedure AddSongs_In_pls(mPlaylistNum: SmallInt; mTrackName, mTrackPath: string);
procedure AddSongs_In_asx(mPlaylistNum: SmallInt; mTrackName, mTrackPath: string);
procedure AddSongs_In_xspf(mPlaylistNum: SmallInt; mTrackName, mTrackPath: string);
procedure AddSongs_In_wpl(mPlaylistNum: SmallInt; mTrackName, mTrackPath: string);
procedure AddSongs_In_expl(mPlaylistNum: SmallInt; mTrackName, mTrackPath: string);

// Update last played song from the current playlist
procedure Update_Last_Song(vNum: Integer);

implementation

uses
  uLoad_AllTypes,
  uSnippet_Text,
  uWindows,
  uSoundplayer,
  uSoundplayer_AllTypes,
  uSoundplayer_Playlist_Create,
  uSoundplayer_Tag_Get,
  uSoundplayer_Tag_Mp3_SetAll,
  uSoundplayer_Tag_Mp3,
  uSoundplayer_Tag_Ogg_SetAll,
  uSoundplayer_Tag_Ogg;

var
  vPressed_Already: Boolean = False;

procedure State(vPlay, vPause, vStop, vMute, vSuffle: Boolean; vRepeat: String);
begin
  addons.soundplayer.Player.Play := vPlay;
  addons.soundplayer.Player.Pause := vPause;
  addons.soundplayer.Player.Stop := vStop;
  addons.soundplayer.Player.Mute := vMute;
  addons.soundplayer.Player.Suffle := vSuffle;
  addons.soundplayer.Player.vRepeat := vRepeat;

  if vStop then
  begin
    vSoundplayer.Player.Stop.TextSettings.FontColor := TAlphaColorRec.Red;
    vSoundplayer.Player.Play.Text := #$ea1c;
    vSoundplayer.Player.Play.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vSoundplayer.Player.Play_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  end
  else
  begin
    if vPlay then
    begin
      vSoundplayer.Player.Play.Text := #$ea1c;
      vSoundplayer.Player.Play.TextSettings.FontColor := TAlphaColorRec.Blueviolet;
      vSoundplayer.Player.Play_Glow.GlowColor := TAlphaColorRec.Blueviolet;
      vSoundplayer.Player.Stop.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end
    else if vPause then
    begin
      vSoundplayer.Player.Play.Text := #$ea1d;
      vSoundplayer.Player.Play.TextSettings.FontColor := TAlphaColorRec.Greenyellow;
      vSoundplayer.Player.Play_Glow.GlowColor := TAlphaColorRec.Greenyellow;
      vSoundplayer.Player.Stop.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end
    else
    begin
      vSoundplayer.Player.Stop.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vSoundplayer.Player.Play.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end;
  end;

  Set_Previous_Next;
  if addons.soundplayer.Playlist.List.Songs_Num > 0 then
  begin
    vSoundplayer.Player.Loop.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    if vRepeat = '' then
      Set_Repeat('List_Inf')
    else if vRepeat = 'Song_1' then
      Set_Repeat('')
    else if vRepeat = 'Song_Inf' then
      Set_Repeat('Song_1')
    else if vRepeat = 'List_1' then
      Set_Repeat('Song_Inf')
    else if vRepeat = 'List_Inf' then
      Set_Repeat('List_1');
    vSoundplayer.Player.Suffle.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    if addons.soundplayer.Player.VRepeat_Num = -1 then
    begin
      addons.soundplayer.Player.Suffle := not vSuffle;
      Suffle;
    end;
  end;
  addons.soundplayer.Player.Time_Negative := addons.soundplayer.Player.Time_Negative;
end;

procedure Refresh;
var
  sCT, sFT: Real;
  vRand: Integer;
  vRand_Str: String;
  viPos: Integer;
  vi: Integer;
begin
  if addons.soundplayer.Player.Play then
  begin
    sCT := trunc(BASS_ChannelBytes2Seconds(sound.str_music[1], BASS_ChannelGetPosition(sound.str_music[1], BASS_POS_BYTE)));
    sFT := trunc(BASS_ChannelBytes2Seconds(sound.str_music[1], BASS_ChannelGetLength(sound.str_music[1], BASS_POS_BYTE)));

    viPos := Pos('addon_soundplayer', extrafe.prog.State);

    if viPos <> 0 then
      if addons.soundplayer.Player.Thumb_Active = False then
      begin
        if addons.soundplayer.Player.Time_Negative = False then
          vSoundplayer.Player.Song_PlayTime.Text := FormatDateTime('hh:mm:ss', uWindows_ConvertSecondsFromTime(sCT))
        else
          vSoundplayer.Player.Song_PlayTime.Text := '-' + FormatDateTime('hh:mm:ss', uWindows_ConvertSecondsFromTime(sFT - sCT));
        vSoundplayer.Player.Song_Pos.Value := (sCT * 1000 / sFT);
        addons.soundplayer.Player.Song_State := vSoundplayer.Player.Song_Pos.Value;
      end;

    if BASS_ChannelGetPosition(sound.str_music[1], BASS_POS_BYTE) >= BASS_ChannelGetLength(sound.str_music[1], BASS_POS_BYTE) then
    begin
      if (addons.soundplayer.Player.vRepeat = '') and (addons.soundplayer.Player.Suffle = False) then
      begin
        if addons.soundplayer.Player.HasNext_Track then
          uSoundplayer_Player.Next
        else
          Refresh_GoTo(0, False);
      end
      else if (addons.soundplayer.Player.vRepeat = '') and (addons.soundplayer.Player.Suffle) then
        Suffle_GoTo
      else if (addons.soundplayer.Player.vRepeat <> '') and (addons.soundplayer.Player.Suffle) then
      begin
        if addons.soundplayer.Player.vRepeat = 'List_1' then
        begin
          if addons.soundplayer.Player.Suffle_List.Count = 1 then
          begin
            if addons.soundplayer.Player.VRepeat_Num = 1 then
            begin
              addons.soundplayer.Player.VRepeat_Num := -1;
            end
            else
            begin
              Dec(addons.soundplayer.Player.VRepeat_Num, 1);
            end;
          end;
          Suffle_GoTo;
        end
        else if addons.soundplayer.Player.vRepeat = 'List_Inf' then
        begin
          Suffle_GoTo;
        end;
      end
      else if addons.soundplayer.Player.vRepeat <> '' then
      begin
        if addons.soundplayer.Player.vRepeat = 'Song_1' then
        begin
          if addons.soundplayer.Player.VRepeat_Num = 1 then
            Set_Repeat('List_Inf')
          else
          begin
            Dec(addons.soundplayer.Player.VRepeat_Num, 1);
            vSoundplayer.Player.Loop_State.Text := addons.soundplayer.Player.VRepeat_Num.ToString;
          end;
          Refresh_GoTo(addons.soundplayer.Player.Playing_Now, addons.soundplayer.Player.Play);
        end
        else if addons.soundplayer.Player.vRepeat = 'Song_Inf' then
        begin
          Refresh_GoTo(addons.soundplayer.Player.Playing_Now, True);
        end
        else if addons.soundplayer.Player.vRepeat = 'List_1' then
        begin
          vSoundplayer.Playlist.List.Cells[1, addons.soundplayer.Player.Playing_Now] := '3';
          if addons.soundplayer.Player.VRepeat_Songs_Num = 0 then
          begin
            if addons.soundplayer.Player.VRepeat_Num = 1 then
            begin
              Set_Repeat('List_Inf');
            end
            else
            begin
              Dec(addons.soundplayer.Player.VRepeat_Num, 1);
              vSoundplayer.Player.Loop_State.Text := addons.soundplayer.Player.VRepeat_Num.ToString;
              addons.soundplayer.Player.VRepeat_Songs_Num := addons.soundplayer.Playlist.List.Songs_Num - 1;
            end;
            addons.soundplayer.Player.Playing_Now := 0;
          end
          else
          begin
            Inc(addons.soundplayer.Player.Playing_Now, 1);
            Dec(addons.soundplayer.Player.VRepeat_Songs_Num, 1);
          end;
          Refresh_GoTo(addons.soundplayer.Player.Playing_Now, addons.soundplayer.Player.Play);
        end
        else if addons.soundplayer.Player.vRepeat = 'List_Inf' then
        begin
          vSoundplayer.Playlist.List.Cells[1, addons.soundplayer.Player.Playing_Now] := '3';
          if addons.soundplayer.Player.Playing_Now = addons.soundplayer.Playlist.List.Songs_Num - 1 then
            addons.soundplayer.Player.Playing_Now := 0
          else
            Inc(addons.soundplayer.Player.Playing_Now, 1);
          Refresh_GoTo(addons.soundplayer.Player.Playing_Now, addons.soundplayer.Player.Play);
        end;
      end;
    end;
  end;
end;

procedure Set_Previous_Next;
begin
  if (addons.soundplayer.Player.Playing_Now = 0) and (addons.soundplayer.Playlist.List.Songs_Num = 0) then
  begin
    addons.soundplayer.Player.HasPrevious_Track := False;
    vSoundplayer.Player.Previous.TextSettings.FontColor := TAlphaColorRec.Grey;
    addons.soundplayer.Player.HasNext_Track := False;
    vSoundplayer.Player.Next.TextSettings.FontColor := TAlphaColorRec.Grey;
    if addons.soundplayer.Playlist.Edit then
    begin
      vSoundplayer.Playlist.Songs_Edit.Down.TextSettings.FontColor := TAlphaColorRec.Grey;
      vSoundplayer.Playlist.Songs_Edit.Up.TextSettings.FontColor := TAlphaColorRec.Grey;
    end;
  end
  else if (addons.soundplayer.Player.Playing_Now + 1 < addons.soundplayer.Playlist.List.Songs_Num) and (addons.soundplayer.Player.Playing_Now <> 0) then
  begin
    addons.soundplayer.Player.HasPrevious_Track := True;
    vSoundplayer.Player.Previous.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    addons.soundplayer.Player.HasNext_Track := True;
    vSoundplayer.Player.Next.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    if addons.soundplayer.Playlist.Edit then
    begin
      vSoundplayer.Playlist.Songs_Edit.Down.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vSoundplayer.Playlist.Songs_Edit.Up.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end;
  end
  else if addons.soundplayer.Player.Playing_Now = 0 then
  begin
    addons.soundplayer.Player.HasPrevious_Track := False;
    vSoundplayer.Player.Previous.TextSettings.FontColor := TAlphaColorRec.Grey;
    addons.soundplayer.Player.HasNext_Track := True;
    vSoundplayer.Player.Next.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    if addons.soundplayer.Playlist.Edit then
    begin
      vSoundplayer.Playlist.Songs_Edit.Down.TextSettings.FontColor := TAlphaColorRec.Grey;
      vSoundplayer.Playlist.Songs_Edit.Up.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end;
  end
  else
  begin
    addons.soundplayer.Player.HasPrevious_Track := True;
    vSoundplayer.Player.Previous.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    addons.soundplayer.Player.HasNext_Track := False;
    vSoundplayer.Player.Next.TextSettings.FontColor := TAlphaColorRec.Grey;
    if addons.soundplayer.Playlist.Edit then
    begin
      vSoundplayer.Playlist.Songs_Edit.Down.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vSoundplayer.Playlist.Songs_Edit.Up.TextSettings.FontColor := TAlphaColorRec.Grey;
    end;
  end;
end;

procedure Refresh_GoTo(vGo: Integer; vPlay: Boolean);
begin
  if extrafe.prog.State = 'addon_soundplayer' then
    vSoundplayer.Playlist.List.Cells[1, addons.soundplayer.Player.Playing_Now] := '3';
  Update_Last_Song(addons.soundplayer.Player.Playing_Now);
  addons.soundplayer.Player.LastPlayed := vGo;
  addons.soundplayer.Player.Playing_Now := vGo;
  addons.soundplayer.Player.Play := vPlay;
  if extrafe.prog.State = 'addon_soundplayer' then
  begin
    vSoundplayer.Playlist.List.Selected := addons.soundplayer.Player.Playing_Now;
    uSoundplayer_Tag_Mp3.APICIndex := 0;
    uSoundplayer_Player.Get_Tag(addons.soundplayer.Player.Playing_Now);
    uSoundplayer_Tag_Get.Set_Icon;
    vSoundplayer.Playlist.List.Cells[1, addons.soundplayer.Player.Playing_Now] := '0';
  end;
  BASS_StreamFree(sound.str_music[1]);
  sound.str_music[1] := BASS_StreamCreateFile(False, PChar(addons.soundplayer.Playlist.List.Songs.Strings[addons.soundplayer.Player.Playing_Now]), 0, 0,
    BASS_SAMPLE_FLOAT {$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
  BASS_ChannelSetPosition(sound.str_music[1], 0, 0);
  BASS_ChannelSetAttribute(sound.str_music[1], BASS_ATTRIB_VOL, addons.soundplayer.Volume.Vol / 100);
  if addons.soundplayer.Player.Play then
    BASS_ChannelPlay(sound.str_music[1], False)
  else
  begin
    vSoundplayer.Player.Song_PlayTime.Text := '00:00:00';
    addons.soundplayer.Player.Time_Negative := False;
    vSoundplayer.Player.Play.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vSoundplayer.Player.Play_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  end;
  if extrafe.prog.State = 'addon_soundplayer' then
  begin
    vSoundplayer.Player.Song_Pos.Value := 0;
    addons.soundplayer.Player.Song_State := vSoundplayer.Player.Song_Pos.Value;
  end;
  if addons.soundplayer.Player.Suffle then
  begin

  end
  else
  begin
    if ((addons.soundplayer.Player.vRepeat <> 'Song_1') and (addons.soundplayer.Player.vRepeat <> 'Song_Inf')) then
      Set_Previous_Next;
  end;
end;

// Click actions
procedure StartOrPause;
begin
  if (addons.soundplayer.Player.Play = False) or (addons.soundplayer.Player.Pause = True) then
  begin
    if addons.soundplayer.Player.Pause then
      BASS_ChannelPlay(sound.str_music[1], False)
    else
    begin
      Refresh_GoTo(addons.soundplayer.Player.Playing_Now, True);
      vSoundplayer.Playlist.List.Cells[1, addons.soundplayer.Player.Playing_Now] := '0';
    end;
    vSoundplayer.Player.Play.TextSettings.FontColor := TAlphaColorRec.Blueviolet;
    vSoundplayer.Player.Play_Glow.GlowColor := TAlphaColorRec.Blueviolet;
    vSoundplayer.Player.Stop.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vSoundplayer.Player.Stop_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    addons.soundplayer.Player.Stop := False;
    addons.soundplayer.Player.Pause := False;
    addons.soundplayer.Player.Play := True;
    vSoundplayer.timer.Song.Enabled := True;
    uSoundplayer_Player.Update_Last_Song(addons.soundplayer.Player.Playing_Now);
  end
  else
  begin
    BASS_ChannelPause(sound.str_music[1]);
    vSoundplayer.Player.Play.Text := #$ea1d;
    vSoundplayer.Player.Play.TextSettings.FontColor := TAlphaColorRec.Greenyellow;
    vSoundplayer.Player.Play_Glow.GlowColor := TAlphaColorRec.Greenyellow;
    vSoundplayer.Player.Stop.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vSoundplayer.Player.Stop_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    addons.soundplayer.Player.Stop := False;
    addons.soundplayer.Player.Play := False;
    addons.soundplayer.Player.Pause := True;
    vSoundplayer.Playlist.List.Cells[1, addons.soundplayer.Player.Playing_Now] := '2';
    vSoundplayer.timer.Song.Enabled := True;
  end;
  vPressed_Already := True;
end;

procedure Stop;
begin
  if vSoundplayer.Player.Stop.TextSettings.FontColor = TAlphaColorRec.Deepskyblue then
  begin
    if sound.str_music[1] <> 0 then
      if (addons.soundplayer.Player.Play = True) or (addons.soundplayer.Player.Pause = True) then
      begin
        BASS_ChannelStop(sound.str_music[1]);
        BASS_ChannelSetPosition(sound.str_music[1], 0, 0);
        vSoundplayer.Player.Song_Pos.Value := 0;
        vSoundplayer.Player.Stop.TextSettings.FontColor := TAlphaColorRec.Red;
        vSoundplayer.Player.Play.Text := #$ea1c;
        vSoundplayer.Player.Play.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
        vSoundplayer.Player.Play_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
        addons.soundplayer.Player.Stop := True;
        addons.soundplayer.Player.Play := False;
        addons.soundplayer.Player.Pause := False;
        uSoundplayer_Player.Text_OnLeave(vSoundplayer.Player.Stop, vSoundplayer.Player.Stop_Glow);
        vSoundplayer.Playlist.List.Cells[1, addons.soundplayer.Player.Playing_Now] := '1';
        vPressed_Already := True;
      end;
  end;
end;

procedure Previous;
begin
  if vSoundplayer.Player.Previous.TextSettings.FontColor = TAlphaColorRec.Deepskyblue then
  begin
    if (addons.soundplayer.Player.Suffle = False) and (addons.soundplayer.Player.vRepeat = '') then
    begin
      if sound.str_music[1] <> 0 then
        if addons.soundplayer.Player.Playing_Now > 0 then
        begin
          Refresh_GoTo(addons.soundplayer.Player.Playing_Now - 1, addons.soundplayer.Player.Play);
          if extrafe.prog.State = 'addon_soundplayer' then
          begin
            if addons.soundplayer.Player.Playing_Now = 0 then
              uSoundplayer_Player.Text_OnLeave(vSoundplayer.Player.Previous, vSoundplayer.Player.Previous_Glow);
            vSoundplayer.info.Total_Songs.Text := IntToStr(addons.soundplayer.Player.Playing_Now + 1) + '/' +
              addons.soundplayer.Playlist.List.Songs_Num.ToString;
            uSoundplayer.Set_Animations;
          end;
        end;
    end
    else if (addons.soundplayer.Player.Suffle) then
    begin
      Suffle_GoTo;
      if addons.soundplayer.Player.Suffle_List.Count = 1 then
        uSoundplayer_Player.Text_OnLeave(vSoundplayer.Player.Previous, vSoundplayer.Player.Previous_Glow);
    end;
  end;
end;

procedure Next;
begin
  if vSoundplayer.Player.Next.TextSettings.FontColor = TAlphaColorRec.Deepskyblue then
  begin
    if (addons.soundplayer.Player.Suffle = False) and (addons.soundplayer.Player.vRepeat = '') then
    begin
      if addons.soundplayer.Player.Playing_Now < vSoundplayer.Playlist.List.RowCount - 1 then
      begin
        Refresh_GoTo(addons.soundplayer.Player.Playing_Now + 1, addons.soundplayer.Player.Play);
        if extrafe.prog.State = 'addon_soundplayer' then
        begin
          if addons.soundplayer.Player.Playing_Now = vSoundplayer.Playlist.List.RowCount - 1 then
            uSoundplayer_Player.Text_OnLeave(vSoundplayer.Player.Next, vSoundplayer.Player.Next_Glow);
          vSoundplayer.info.Total_Songs.Text := IntToStr(addons.soundplayer.Player.Playing_Now + 1) + '/' + addons.soundplayer.Playlist.List.Songs_Num.ToString;
          uSoundplayer.Set_Animations;
        end;
      end;
    end
    else if (addons.soundplayer.Player.Suffle) then
    begin
      Suffle_GoTo;
      if addons.soundplayer.Player.Suffle_List.Count = 1 then
        uSoundplayer_Player.Text_OnLeave(vSoundplayer.Player.Next, vSoundplayer.Player.Next_Glow);
    end;
  end
end;

procedure Set_Repeat(vCurrent: String);
begin
  if vSoundplayer.Player.Loop.TextSettings.FontColor <> TAlphaColorRec.Grey then
  begin
    if vCurrent = '' then
      addons.soundplayer.Player.vRepeat := 'Song_1'
    else if vCurrent = 'Song_1' then
      addons.soundplayer.Player.vRepeat := 'Song_Inf'
    else if vCurrent = 'Song_Inf' then
      addons.soundplayer.Player.vRepeat := 'List_1'
    else if vCurrent = 'List_1' then
      addons.soundplayer.Player.vRepeat := 'List_Inf'
    else if vCurrent = 'List_Inf' then
      addons.soundplayer.Player.vRepeat := '';

    if addons.soundplayer.Player.vRepeat = '' then
    begin
      vSoundplayer.Player.Loop_State.Visible := False;
      vSoundplayer.Player.Loop_To.Visible := False;
      vSoundplayer.Player.Loop.RotationAngle := 360;
      vSoundplayer.Player.Loop.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vSoundplayer.Player.Loop_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
      addons.soundplayer.Player.VRepeat_Num := -1;
      addons.soundplayer.Player.VRepeat_Songs_Num := -1;
      if addons.soundplayer.Playlist.List.Songs_Num = addons.soundplayer.Player.Playing_Now then
        vSoundplayer.Player.Next.TextSettings.FontColor := TAlphaColorRec.Grey
      else
        vSoundplayer.Player.Next.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      if addons.soundplayer.Player.Playing_Now = 0 then
        vSoundplayer.Player.Previous.TextSettings.FontColor := TAlphaColorRec.Grey
      else
        vSoundplayer.Player.Previous.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end
    else if addons.soundplayer.Player.vRepeat = 'Song_1' then
    begin
      vSoundplayer.Player.Loop.RotationAngle := -72;
      vSoundplayer.Player.Loop_State.Visible := True;
      if addons.soundplayer.Player.VRepeat_Num = -1 then
        addons.soundplayer.Player.VRepeat_Num := 1;
      addons.soundplayer.Player.VRepeat_Num := addons.soundplayer.Player.VRepeat_Num;
      vSoundplayer.Player.Loop_State.Text := addons.soundplayer.Player.VRepeat_Num.ToString;
      vSoundplayer.Player.Loop_To.Text := #$e911;
      vSoundplayer.Player.Loop_To.Visible := True;
      vSoundplayer.Player.Loop.TextSettings.FontColor := TAlphaColorRec.Darkturquoise;
      vSoundplayer.Player.Loop_Glow.GlowColor := TAlphaColorRec.Darkturquoise;
      vSoundplayer.Player.Next.TextSettings.FontColor := TAlphaColorRec.Grey;
      vSoundplayer.Player.Previous.TextSettings.FontColor := TAlphaColorRec.Grey;
      vSoundplayer.Player.Suffle.TextSettings.FontColor := TAlphaColorRec.Grey;
    end
    else if addons.soundplayer.Player.vRepeat = 'Song_Inf' then
    begin
      vSoundplayer.Player.Loop.RotationAngle := -144;
      vSoundplayer.Player.Loop_State.Visible := True;
      vSoundplayer.Player.Loop_State.Text := #$ea2f;
      addons.soundplayer.Player.VRepeat_Num := -1;
      vSoundplayer.Player.Loop_To.Text := #$e911;
      vSoundplayer.Player.Loop_To.Visible := True;
      vSoundplayer.Player.Loop.TextSettings.FontColor := TAlphaColorRec.Darkseagreen;
      vSoundplayer.Player.Loop_Glow.GlowColor := TAlphaColorRec.Darkseagreen;
      vSoundplayer.Player.Next.TextSettings.FontColor := TAlphaColorRec.Grey;
      vSoundplayer.Player.Previous.TextSettings.FontColor := TAlphaColorRec.Grey;
    end
    else if addons.soundplayer.Player.vRepeat = 'List_1' then
    begin
      vSoundplayer.Player.Loop.RotationAngle := -216;
      vSoundplayer.Player.Loop_State.Visible := True;
      if addons.soundplayer.Player.VRepeat_Num = -1 then
      begin
        if addons.soundplayer.Player.VRepeat_Songs_Num = -1 then
          addons.soundplayer.Player.VRepeat_Songs_Num := (addons.soundplayer.Playlist.List.Songs_Num - 1) - addons.soundplayer.Player.Playing_Now;
      end;
      addons.soundplayer.Player.VRepeat_Songs_Num := addons.soundplayer.Player.VRepeat_Songs_Num;
      if addons.soundplayer.Player.VRepeat_Num = -1 then
        addons.soundplayer.Player.VRepeat_Num := 1;
      addons.soundplayer.Player.VRepeat_Num := addons.soundplayer.Player.VRepeat_Num;
      vSoundplayer.Player.Loop_State.Text := addons.soundplayer.Player.VRepeat_Num.ToString;
      vSoundplayer.Player.Loop_To.Text := #$e9bb;
      vSoundplayer.Player.Loop_To.Visible := True;
      vSoundplayer.Player.Loop.TextSettings.FontColor := TAlphaColorRec.Lightsalmon;
      vSoundplayer.Player.Loop_Glow.GlowColor := TAlphaColorRec.Lightsalmon;
      vSoundplayer.Player.Next.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vSoundplayer.Player.Previous.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vSoundplayer.Player.Suffle.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end
    else if addons.soundplayer.Player.vRepeat = 'List_Inf' then
    begin
      vSoundplayer.Player.Loop.RotationAngle := -288;
      vSoundplayer.Player.Loop_State.Visible := True;
      vSoundplayer.Player.Loop_State.Text := #$ea2f;
      addons.soundplayer.Player.VRepeat_Num := -1;
      addons.soundplayer.Player.VRepeat_Songs_Num := -1;
      vSoundplayer.Player.Loop_To.Text := #$e9bb;
      vSoundplayer.Player.Loop_To.Visible := True;
      vSoundplayer.Player.Loop.TextSettings.FontColor := TAlphaColorRec.Lightpink;
      vSoundplayer.Player.Loop_Glow.GlowColor := TAlphaColorRec.Lightpink;
      vSoundplayer.Player.Next.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vSoundplayer.Player.Previous.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end;
  end;
end;

procedure Inc_LoopState;
begin
  if addons.soundplayer.Player.VRepeat_Num <> -1 then
  begin
    if addons.soundplayer.Player.VRepeat_Num = 9 then
      addons.soundplayer.Player.VRepeat_Num := 0;
    Inc(addons.soundplayer.Player.VRepeat_Num, 1);
    vSoundplayer.Player.Loop_State.Text := addons.soundplayer.Player.VRepeat_Num.ToString;
  end;
end;

procedure Suffle;
var
  vi: Integer;
begin
  if (addons.soundplayer.Player.vRepeat = 'Song_1') or (addons.soundplayer.Player.vRepeat = 'Song_Inf') then
  begin
    vSoundplayer.Player.Suffle.TextSettings.FontColor := TAlphaColorRec.Grey;
    addons.soundplayer.Player.Suffle := False;
  end;
  if vSoundplayer.Player.Suffle.TextSettings.FontColor <> TAlphaColorRec.Grey then
  begin
    if addons.soundplayer.Player.Suffle then
    begin
      vSoundplayer.Player.Suffle.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      FreeAndNil(addons.soundplayer.Player.Suffle_List);
      for vi := 0 to addons.soundplayer.Playlist.List.Songs_Num - 1 do
        vSoundplayer.Playlist.List.Cells[1, vi] := '3';
      vSoundplayer.Playlist.List.Cells[1, addons.soundplayer.Player.Playing_Now] := '0';
      vPressed_Already := True;
    end
    else
    begin
      vSoundplayer.Player.Suffle.TextSettings.FontColor := TAlphaColorRec.Limegreen;
      if Assigned(addons.soundplayer.Player.Suffle_List) then
        FreeAndNil(addons.soundplayer.Player.Suffle_List);
      if not Assigned(addons.soundplayer.Player.Suffle_List) then
      begin
        addons.soundplayer.Player.Suffle_List := TStringList.Create;
        for vi := 0 to addons.soundplayer.Playlist.List.Songs_Num - 1 do
          addons.soundplayer.Player.Suffle_List.Add(vi.ToString);
      end;
      if vSoundplayer.Player.Next.TextSettings.FontColor = TAlphaColorRec.Grey then
        vSoundplayer.Player.Next.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      if vSoundplayer.Player.Previous.TextSettings.FontColor = TAlphaColorRec.Grey then
        vSoundplayer.Player.Previous.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vPressed_Already := True;
    end;
    addons.soundplayer.Player.Suffle := not addons.soundplayer.Player.Suffle;
  end;
end;

procedure Suffle_GoTo;
var
  vRand_Str: String;
  vRand: Integer;
  vi: Integer;
begin
  vRand_Str := addons.soundplayer.Player.Playing_Now.ToString;
  addons.soundplayer.Player.Suffle_List.Delete(addons.soundplayer.Player.Suffle_List.IndexOf(vRand_Str));
  if addons.soundplayer.Player.Suffle_List.Count > 0 then
  begin
    vRand := Random(addons.soundplayer.Player.Suffle_List.Count);
    vRand := addons.soundplayer.Player.Suffle_List.Strings[vRand].ToInteger;
    if extrafe.prog.State = 'addon_soundplayer' then
      vSoundplayer.Playlist.List.Cells[1, addons.soundplayer.Player.Playing_Now] := '12';
    addons.soundplayer.Player.Playing_Now := vRand;
    Refresh_GoTo(addons.soundplayer.Player.Playing_Now, True);
    if addons.soundplayer.Player.Suffle_List.Count = 1 then
    begin
      vSoundplayer.Player.Next.TextSettings.FontColor := TAlphaColorRec.Grey;
      vSoundplayer.Player.Next_Glow.Enabled := False;
      vSoundplayer.Player.Previous.TextSettings.FontColor := TAlphaColorRec.Grey;
      vSoundplayer.Player.Previous_Glow.Enabled := False;
    end;
  end
  else
  begin
    if addons.soundplayer.Player.vRepeat = 'List_1' then
    begin
      for vi := 0 to addons.soundplayer.Playlist.List.Songs_Num - 1 do
        vSoundplayer.Playlist.List.Cells[1, vi] := '3';
      if addons.soundplayer.Player.VRepeat_Num = -1 then
      begin
        Set_Repeat('List_Inf');
        Suffle;
        Refresh_GoTo(0, True);
        Set_Previous_Next;
      end
      else
      begin
        vSoundplayer.Player.Loop_State.Text := addons.soundplayer.Player.VRepeat_Num.ToString;
        if Assigned(addons.soundplayer.Player.Suffle_List) then
          FreeAndNil(addons.soundplayer.Player.Suffle_List);
        if not Assigned(addons.soundplayer.Player.Suffle_List) then
        begin
          addons.soundplayer.Player.Suffle_List := TStringList.Create;
          for vi := 0 to addons.soundplayer.Playlist.List.Songs_Num - 1 do
            addons.soundplayer.Player.Suffle_List.Add(vi.ToString);
        end;
        vSoundplayer.Player.Next.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
        vSoundplayer.Player.Previous.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
        Refresh_GoTo(0, True);
      end;
    end
    else if addons.soundplayer.Player.vRepeat = 'List_Inf' then
    begin
      for vi := 0 to addons.soundplayer.Playlist.List.Songs_Num - 1 do
        vSoundplayer.Playlist.List.Cells[1, vi] := '3';
      if Assigned(addons.soundplayer.Player.Suffle_List) then
        FreeAndNil(addons.soundplayer.Player.Suffle_List);
      if not Assigned(addons.soundplayer.Player.Suffle_List) then
      begin
        addons.soundplayer.Player.Suffle_List := TStringList.Create;
        for vi := 0 to addons.soundplayer.Playlist.List.Songs_Num - 1 do
          addons.soundplayer.Player.Suffle_List.Add(vi.ToString);
      end;
      vSoundplayer.Player.Next.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vSoundplayer.Player.Previous.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      Refresh_GoTo(0, True);
    end
    else
    begin
      for vi := 0 to addons.soundplayer.Playlist.List.Songs_Num - 1 do
        vSoundplayer.Playlist.List.Cells[1, vi] := '3';
      Suffle;
      Refresh_GoTo(0, True);
    end;
    // if (addons.soundplayer.Player.vRepeat = 'List_1') and (addons.soundplayer.Player.VRepeat_Num > 0) then
    // begin
    // vSoundplayer.Player.Loop_State.Text := addons.soundplayer.Player.VRepeat_Num.ToString;
    //
    // end;
    { if (addons.soundplayer.Player.vRepeat <> 'List_1') or (addons.soundplayer.Player.vRepeat <> 'List_Inf') then
      begin
      Refresh_GoTo(0, False);
      Suffle;
      end
      else
      begin
      if (addons.soundplayer.Player.vRepeat = 'List_1') and (addons.soundplayer.Player.VRepeat_Num > 0) then
      Refresh_GoTo(0, True)
      else
      begin
      Refresh_GoTo(0, False);
      end;
      end; }
  end;
end;

/// /////////////////////////////////////////////////////////////////////////////
// Song Position Trackbar
procedure Update_Thumb_Pos(Sender: TObject; vValue: Single; vKeep: Boolean);
var
  vCurrent_Position_Song: Single;
  sFT: Real;
begin
  sFT := trunc(BASS_ChannelBytes2Seconds(sound.str_music[1], BASS_ChannelGetLength(sound.str_music[1], BASS_POS_BYTE)));
  vCurrent_Position_Song := (sFT * vValue) / 1000;
  if addons.soundplayer.Player.Time_Negative = False then
    vSoundplayer.Player.Song_PlayTime.Text := FormatDateTime('hh:mm:ss', uWindows_ConvertSecondsFromTime(vCurrent_Position_Song))
  else
    vSoundplayer.Player.Song_PlayTime.Text := '-' + FormatDateTime('hh:mm:ss', uWindows_ConvertSecondsFromTime(sFT - vCurrent_Position_Song));
  if vKeep then
  begin
    BASS_ChannelSetPosition(sound.str_music[1], BASS_ChannelSeconds2Bytes(sound.str_music[1], vCurrent_Position_Song), BASS_POS_BYTE);
    addons.soundplayer.Player.Thumb_Active := False;
  end;
end;

///
procedure AddSongs_In_m3u(mPlaylistNum: SmallInt; mTrackName, mTrackPath: string; mSongNum: SmallInt);
var
  vss: string;
  vSongTime: string;
  song_seconds: Real;
begin
  sound.str_music[2] := BASS_StreamCreateFile(False, PChar(mTrackPath + mTrackName), 0, 0, BASS_SAMPLE_FLOAT
{$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
  BASS_ChannelFlags(sound.str_music[2], BASS_MUSIC_POSRESET, 0);
  song_seconds := trunc(BASS_ChannelBytes2Seconds(sound.str_music[2], BASS_ChannelGetLength(sound.str_music[2], BASS_POS_BYTE)));
  vss := FloatToStr(song_seconds);
  vSongTime := FormatDateTime('hh:mm:ss', uWindows_ConvertSecondsFromTime(song_seconds));
  addons.soundplayer.Playlist.List.Playlist.Add('#EXTINF:' + vss + ',' + mTrackName);
  addons.soundplayer.Playlist.List.Playlist.Add(mTrackPath + mTrackName);
  addons.soundplayer.Playlist.List.Playlist.SaveToFile(addons.soundplayer.Path.Playlists + addons.soundplayer.Playlist.List.Name + '.m3u');
  addons.soundplayer.Playlist.List.Songs.Add(mTrackPath + mTrackName);
  uSoundPlayer_GetTag_Details(mTrackPath + mTrackName, addons.soundplayer.Playlist.Active, mSongNum, vSongTime);
  BASS_StreamFree(sound.str_music[2]);
end;

procedure AddSongs_In_pls(mPlaylistNum: SmallInt; mTrackName, mTrackPath: string);
begin

end;

procedure AddSongs_In_asx(mPlaylistNum: SmallInt; mTrackName, mTrackPath: string);
begin

end;

procedure AddSongs_In_xspf(mPlaylistNum: SmallInt; mTrackName, mTrackPath: string);
begin

end;

procedure AddSongs_In_wpl(mPlaylistNum: SmallInt; mTrackName, mTrackPath: string);
begin

end;

procedure AddSongs_In_expl(mPlaylistNum: SmallInt; mTrackName, mTrackPath: string);
begin

end;

procedure uSoundplayer_Player_AddNewSongs;
var
  vSongList: TStringList;
  vi: SmallInt;
  vSongsInPlaylist: SmallInt;
  vPlaylistName: string;
  vPlaylistNum: SmallInt;
  vPlaylistType: string;
  vPlaylistPlayingSong: SmallInt;
  vPlaylistRowsCount: SmallInt;
  vSongNum: SmallInt;
begin
  if vSoundplayer.scene.OpenDialog.FileName <> '' then
  begin
    // Needed data for playlist
    vPlaylistName := addons.soundplayer.Playlist.List.Name;
    if vPlaylistName = '' then
    begin
      vPlaylistName := 'temp';
      vPlaylistNum := 0;
      vPlaylistType := '.m3u';
      vSongsInPlaylist := 0;
      vPlaylistPlayingSong := 0;
    end
    else
    begin
      vPlaylistNum := addons.soundplayer.Playlist.Active;
      vPlaylistPlayingSong := addons.soundplayer.Player.LastPlayed;
      vSongsInPlaylist := addons.soundplayer.Ini.Ini.ReadInteger('Playlists', 'PL_' + IntToStr(vPlaylistNum) + '_Songs', vSongsInPlaylist);
      vPlaylistType := addons.soundplayer.Ini.Ini.ReadString('Playlists', 'PL_' + IntToStr(vPlaylistNum) + '_Type', vPlaylistType);
    end;
    // Add list of songs in stringlist
    vSongList := TStringList.Create;
    vSongList.AddStrings(vSoundplayer.scene.OpenDialog.Files);
    // Add rows in stringgrid
    if vSoundplayer.Playlist.List.Cells[0, 0] = '' then
      vSoundplayer.Playlist.List.RowCount := vSongList.Count
    else
      vSoundplayer.Playlist.List.RowCount := vSoundplayer.Playlist.List.RowCount + vSongList.Count;
    // Add songs in Playlist and Stringgrid
    if vPlaylistName = 'temp' then
    begin
      uSoundPlayer_Playlist_Create_NewPlaylist(vPlaylistName, vPlaylistType);
    end;
    addons.soundplayer.Playlist.List.Playlist.LoadFromFile(addons.soundplayer.Path.Playlists + addons.soundplayer.Playlist.List.Name + vPlaylistType);
    addons.soundplayer.Playlist.List.Songs := TStringList.Create;
    for vi := 0 to vSongList.Count - 1 do
    begin
      vSongNum := vSongsInPlaylist + vi;
      if vPlaylistType = '.m3u' then
        AddSongs_In_m3u(vPlaylistNum, ExtractFileName(vSongList.Strings[vi]), ExtractFilePath(vSongList.Strings[vi]), vSongNum)
        // AddSongs_In_pls
      else if vPlaylistType = 'pls' then
        // AddSongs_In_asx
      else if vPlaylistType = 'asx' then
        // AddSongs_In_xspf
      else if vPlaylistType = 'xspf' then
        // AddSongs_In_wpl
      else if vPlaylistType = 'wpl' then
        // AddSongs_In_expl;
      else if vPlaylistType = 'expl' then
      begin

      end;
      vSoundplayer.Playlist.List.Cells[0, vSongNum] := IntToStr(vSongNum + 1);
      vSoundplayer.Playlist.List.Cells[1, vSongNum] := '3';
      vSoundplayer.Playlist.List.Cells[2, vSongNum] := addons.soundplayer.Playlist.List.Song_Info[vSongNum].Title;
      vSoundplayer.Playlist.List.Cells[3, vSongNum] := addons.soundplayer.Playlist.List.Song_Info[vSongNum].Artist;
      vSoundplayer.Playlist.List.Cells[4, vSongNum] := addons.soundplayer.Playlist.List.Song_Info[vSongNum].Track_Seconds;
      if addons.soundplayer.Playlist.List.Song_Info[vSongNum].Disk_Type = '.mp3' then
        vSoundplayer.Playlist.List.Cells[5, vSongNum] := '7'
      else
        vSoundplayer.Playlist.List.Cells[5, vSongNum] := '8'
    end;
    // update playlist config ini
    addons.soundplayer.Ini.Ini.WriteInteger('Playlists', 'PL_' + IntToStr(vPlaylistNum) + '_Songs', (vSongsInPlaylist + vSongList.Count));
    // update playlist array
    addons.soundplayer.Playlist.List.Songs_Num := vSongsInPlaylist + vSongList.Count;
    // update soundplayer face vars
    if vPlaylistPlayingSong <> -1 then
      addons.soundplayer.Player.Playing_Now := 0;
    vSoundplayer.info.Total_Songs.Text := IntToStr(addons.soundplayer.Player.Playing_Now) + '/' + IntToStr(addons.soundplayer.Playlist.List.Songs_Num);
    // Select the first song if playlist was empty and get tag details
    if vSongsInPlaylist = 0 then
    begin
      vSoundplayer.Playlist.List.Cells[1, 0] := '2';
      vSoundplayer.Playlist.List.SelectRow(0);
      uSoundplayer_Player.Get_Tag(0);
      sound.str_music[1] := BASS_StreamCreateFile(False, PChar(vSongList.Strings[0]), 0, 0, BASS_SAMPLE_FLOAT
{$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
      addons.soundplayer.Player.Stop := True;
      addons.soundplayer.Player.LastPlayed := 0;
      addons.soundplayer.Player.Playing_Now := addons.soundplayer.Player.LastPlayed;
    end;
    FreeAndNil(vSongList);
    vSoundplayer.Player.Song_Tag.Visible := True;

    vSoundplayer.Player.Play.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vSoundplayer.Player.Stop.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    if addons.soundplayer.Player.Playing_Now > 1 then
      vSoundplayer.Player.Previous.TextSettings.FontColor := TAlphaColorRec.Deepskyblue
    else
      vSoundplayer.Player.Previous.TextSettings.FontColor := TAlphaColorRec.Grey;
    if addons.soundplayer.Playlist.List.Songs_Num > 1 then
      vSoundplayer.Player.Next.TextSettings.FontColor := TAlphaColorRec.Deepskyblue
    else
      vSoundplayer.Player.Next.TextSettings.FontColor := TAlphaColorRec.Grey;

    vSoundplayer.Player.Loop.TextSettings.FontColor := TAlphaColorRec.Grey;

    if addons.soundplayer.Playlist.List.Songs_Num > 1 then
      vSoundplayer.Player.Suffle.TextSettings.FontColor := TAlphaColorRec.Deepskyblue
    else
      vSoundplayer.Player.Suffle.TextSettings.FontColor := TAlphaColorRec.Grey;

    vSoundplayer.info.Back_Left_Ani.Enabled := True;
    vSoundplayer.info.Back_Left.Position.X := 2;
    vSoundplayer.info.Back_Right_Ani.Enabled := True;
    vSoundplayer.info.Back_Right.Position.X := vSoundplayer.scene.Back_Info.Width - 602;
  end;
end;

procedure Get_Tag(vSongNum: SmallInt);
var
  vSong: string;
  vi: Integer;
  vDescription: String;
  vImage: TBitmap;
  vPath: String;
begin
  vSoundplayer.Player.Song_Title.Text := '"' + addons.soundplayer.Playlist.List.Song_Info[vSongNum].Title + '" by "' +
    addons.soundplayer.Playlist.List.Song_Info[vSongNum].Artist + '"';
  if uSnippet_Text_ToPixels(vSoundplayer.Player.Song_Title) < 990 then
  begin
    vSoundplayer.Player.Song_Title_Ani.Stop;
    addons.soundplayer.Player.Title_Ani := False;
    vSoundplayer.Player.Song_Title.Position.X := extrafe.res.Half_Width - 800;
    vSoundplayer.Player.Song_Title.TextSettings.HorzAlign := TTextAlign.Center;
  end
  else
  begin
    vSoundplayer.Player.Song_Title.Position.X := 465;
    vSoundplayer.Player.Song_Title.TextSettings.HorzAlign := TTextAlign.Leading;
    addons.soundplayer.Player.Title_Ani := True;
    Title_Animation;
  end;
  vSoundplayer.info.Song_Title.Text := addons.soundplayer.Playlist.List.Song_Info[vSongNum].Title;
  if uSnippet_Text_ToPixels(vSoundplayer.info.Song_Title) > 422 then
    vSoundplayer.info.Song_Title.Text := uSnippet_Text_SetInGivenPixels(422, vSoundplayer.info.Song_Title);
  vSoundplayer.info.Artist_Name.Text := addons.soundplayer.Playlist.List.Song_Info[vSongNum].Artist;
  vSoundplayer.info.Year_Publish.Text := addons.soundplayer.Playlist.List.Song_Info[vSongNum].Year;
  vSoundplayer.info.Gerne_Kind.Text := addons.soundplayer.Playlist.List.Song_Info[vSongNum].Genre;
  vSoundplayer.info.Track_Num.Text := addons.soundplayer.Playlist.List.Song_Info[vSongNum].Track;
  vSoundplayer.Player.Song_Time.Text := addons.soundplayer.Playlist.List.Song_Info[vSongNum].Track_Seconds;

  if addons.soundplayer.Playlist.List.Song_Info[addons.soundplayer.Player.Playing_Now].Disk_Type = '.mp3' then
  begin
    for vi := 0 to 4 do
    begin
      vSoundplayer.Player.Rate[vi].Visible := True;
      vSoundplayer.Player.Rate_No.Visible := True;
    end;
    vSoundplayer.Player.Rate_No.Visible := True;
    if addons.soundplayer.Playlist.List.Song_Info[vSongNum].Rate > IntToStr(0) then
    begin
      for vi := 0 to 4 do
        vSoundplayer.Player.Rate[vi].Visible := True;
      for vi := 0 to 4 do
        vSoundplayer.Player.Rate_Gray[vi].Enabled := True;
      for vi := 0 to ((addons.soundplayer.Playlist.List.Song_Info[vSongNum].Rate.ToInteger) div 51) - 1 do
        vSoundplayer.Player.Rate_Gray[vi].Enabled := False;
      vSoundplayer.Player.Rate_No.Visible := False;
    end
    else
    begin
      for vi := 0 to 4 do
        vSoundplayer.Player.Rate[vi].Visible := False;
      vSoundplayer.Player.Rate_No.Visible := True;
    end;
  end
  else if addons.soundplayer.Playlist.List.Song_Info[addons.soundplayer.Player.Playing_Now].Disk_Type = '.ogg' then
  begin
    for vi := 0 to 4 do
    begin
      vSoundplayer.Player.Rate[vi].Visible := False;
      vSoundplayer.Player.Rate_No.Visible := False;
    end;
    vSoundplayer.Player.Rate_No.Visible := False;
  end;

  if addons.soundplayer.Playlist.List.Song_Info[addons.soundplayer.Player.Playing_Now].Disk_Type = '.mp3' then
  begin
    vPath := addons.soundplayer.Playlist.List.Song_Info[addons.soundplayer.Player.Playing_Now].Disk_Path + addons.soundplayer.Playlist.List.Song_Info
      [addons.soundplayer.Player.Playing_Now].Disk_Name + addons.soundplayer.Playlist.List.Song_Info[addons.soundplayer.Player.Playing_Now].Disk_Type;
    uSoundplayer_Tag_Mp3.Get_Cover_Image(vPath, vDescription, vImage);
    vSoundplayer.info.Cover.Bitmap := vImage;
    vSoundplayer.info.Cover_Label.Text := vDescription;
  end
  else if addons.soundplayer.Playlist.List.Song_Info[addons.soundplayer.Player.Playing_Now].Disk_Type = '.ogg' then
    GetTags_OGG_Cover(vSongNum);
  vSong := addons.soundplayer.Playlist.List.Songs.Strings[vSongNum];
end;

/// /////////////////////////////////////////////////////////////////////////////
procedure Show_Tag(vSongName: String; vSongNum: Integer);
begin
  if extrafe.prog.State = 'addon_soundplayer' then
  begin
    vSoundplayer.info.Back_Left_Ani.Stop;
    vSoundplayer.info.Back_Left.Position.X := -558;
    vSoundplayer.info.Back_Right_Ani.Stop;
    vSoundplayer.info.Back_Right.Position.X := vSoundplayer.scene.Back_Info.Width - 42;
    vSoundplayer.scene.Back_Blur.Enabled := True;

    if addons.soundplayer.Playlist.List.Song_Info[vSongNum].Disk_Type = '.mp3' then
    begin
      uSoundplayer_TagSet_Mp3;
      uSoundplayer_Tag_Mp3.Get(vSongName, vSongNum);
    end
    else if addons.soundplayer.Playlist.List.Song_Info[vSongNum].Disk_Type = '.ogg' then
    begin
      uSoundplayer_TagSet_Opus;
      uSoundplayer_Tag_Ogg_GetOgg(vSongName);
    end;
  end;
end;

/// /////////////////////////////////////////////////////////////////////////////
procedure Text_OnOver(vText: TText; vGlow: TGlowEffect);
  procedure Text_ScaleUp;
  begin
    vText.Scale.X := 1.1;
    vText.Scale.Y := 1.1;
    vText.Position.X := vText.Position.X - ((vText.Width * 0.1) / 2);
    vText.Position.Y := vText.Position.Y - ((vText.Height * 0.1) / 2);
    vGlow.Enabled := True;
  end;

begin
  if vText.Name = 'A_SP_Player_Play' then
  begin
    if addons.soundplayer.Player.Play then
    begin
      vGlow.GlowColor := TAlphaColorRec.Greenyellow;
      vText.Text := #$ea1d;
      vText.TextSettings.FontColor := TAlphaColorRec.Greenyellow;
    end
    else if addons.soundplayer.Player.Pause then
    begin
      vGlow.GlowColor := TAlphaColorRec.Blueviolet;
      vText.Text := #$ea1c;
      vText.TextSettings.FontColor := TAlphaColorRec.Blueviolet;
    end
    else if addons.soundplayer.Player.Play = False then
    begin
      vGlow.GlowColor := TAlphaColorRec.Deepskyblue;
      vText.Text := #$ea1c;
      vText.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end;
  end
  else if vText.Name = 'A_SP_Player_Suffle' then
  begin
    if addons.soundplayer.Player.Suffle then
      vGlow.GlowColor := TAlphaColorRec.Limegreen
    else if addons.soundplayer.Player.Suffle = False then
      vGlow.GlowColor := TAlphaColorRec.Deepskyblue;
  end;
  Text_ScaleUp;
  BASS_ChannelPlay(addons.soundplayer.sound.Effects[2], False);
end;

procedure Text_OnLeave(vText: TText; vGlow: TGlowEffect);
  procedure Text_ScaleDown;
  begin
    vText.Scale.X := 1;
    vText.Scale.Y := 1;
    vText.Position.X := vText.Position.X + ((vText.Width * 0.1) / 2);
    vText.Position.Y := vText.Position.Y + ((vText.Height * 0.1) / 2);
    vGlow.Enabled := False;
  end;

begin
  if vText.Name = 'A_SP_Player_Play' then
  begin
    if addons.soundplayer.Player.Play then
    begin
      vText.Text := #$ea1c;
      vText.TextSettings.FontColor := TAlphaColorRec.Blueviolet;
    end
    else if addons.soundplayer.Player.Pause then
    begin
      vText.Text := #$ea1d;
      vText.TextSettings.FontColor := TAlphaColorRec.Greenyellow;
    end
    else if addons.soundplayer.Player.Stop then
    begin
      vSoundplayer.Player.Stop_Glow.Enabled := False;
    end;
  end;
  Text_ScaleDown;
end;

procedure OnOver(vImage: TImage; vGlow: TGlowEffect);
  procedure ScaleUp;
  begin
    vImage.Scale.X := 1.1;
    vImage.Scale.Y := 1.1;
    vImage.Position.X := vImage.Position.X - ((vImage.Width * 0.1) / 2);
    vImage.Position.Y := vImage.Position.Y - ((vImage.Height * 0.1) / 2);
    vGlow.Enabled := True;
  end;

begin
  if vImage.Name = 'A_SP_Player_Play_Image' then
  begin
    if (addons.soundplayer.Player.Play) or (addons.soundplayer.Player.Pause) then
    begin
      if addons.soundplayer.Player.Pause then
      begin
        vImage.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_play.png');
        vGlow.GlowColor := TAlphaColorRec.Blueviolet;
        vSoundplayer.Player.Play.TextSettings.FontColor := TAlphaColorRec.Blueviolet;
      end
      else
      begin
        vImage.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_pause.png');
        vGlow.GlowColor := TAlphaColorRec.Greenyellow;
        vSoundplayer.Player.Play.TextSettings.FontColor := TAlphaColorRec.Greenyellow;
      end;
    end;
    ScaleUp;
  end
  else if vImage.Name = 'A_SP_Player_Stop_Image' then
  begin
    if addons.soundplayer.Player.Stop = False then
      ScaleUp;
  end
  else
  begin
    ScaleUp;
  end;
  BASS_ChannelPlay(addons.soundplayer.sound.Effects[2], False);
end;

procedure OnLeave(vImage: TImage; vGlow: TGlowEffect);
  procedure ScaleDown;
  begin
    vImage.Scale.X := 1;
    vImage.Scale.Y := 1;
    vImage.Position.X := vImage.Position.X + ((vImage.Width * 0.1) / 2);
    vImage.Position.Y := vImage.Position.Y + ((vImage.Height * 0.1) / 2);
    vGlow.Enabled := False;
  end;

begin
  if vPressed_Already = False then
  begin
    if vImage.Name = 'A_SP_Player_Play_Image' then
    begin
      if (addons.soundplayer.Player.Play) or (addons.soundplayer.Player.Pause) then
      begin
        if addons.soundplayer.Player.Pause then
        begin
          vImage.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_pause.png');
          vSoundplayer.Player.Play.TextSettings.FontColor := TAlphaColorRec.Greenyellow;
        end
        else
        begin
          vImage.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_play.png');
          vSoundplayer.Player.Play.TextSettings.FontColor := TAlphaColorRec.Blueviolet;
        end;

      end;
      ScaleDown;
    end
    else if vImage.Name = 'A_SP_Player_Stop_Image' then
    begin
      if addons.soundplayer.Player.Stop = False then
        ScaleDown;
    end
    else
      ScaleDown;
  end
  else
    vPressed_Already := False;
end;

/// ///////////////////////////////////////////////////////////////////////////////////////////
procedure Update_Last_Song(vNum: Integer);
begin
  addons.soundplayer.Player.LastPlayed := vNum;
  addons.soundplayer.Ini.Ini.WriteInteger('Song', 'LastPlayed', vNum);
end;

procedure Title_Animation;
begin
  if addons.soundplayer.Player.Title_Ani then
  begin
    if addons.soundplayer.Player.Title_Ani_Left = False then
    begin
      vSoundplayer.Player.Song_Title_Ani.StartValue := 465;
      vSoundplayer.Player.Song_Title_Ani.StopValue := 465 - ((uSnippet_Text_ToPixels(vSoundplayer.Player.Song_Title) + 5) - 1000);
    end
    else if addons.soundplayer.Player.Title_Ani_Left then
    begin
      vSoundplayer.Player.Song_Title_Ani.StartValue := vSoundplayer.Player.Song_Title_Ani.StopValue;
      vSoundplayer.Player.Song_Title_Ani.StopValue := 465;
    end;
    vSoundplayer.Player.Song_Title_Ani.Start;
  end;
end;

end.
