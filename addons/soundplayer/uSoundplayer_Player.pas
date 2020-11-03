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
  FMX.Memo,
  bass;

procedure State;
procedure Set_Play(vPlay, vPause, vStop, vMute: Boolean);

procedure Refresh;
procedure Refresh_GoTo(vGo: Integer);

procedure Text_OnOver(vText: TText; vGlow: TGlowEffect);
procedure Text_OnLeave(vText: TText; vGlow: TGlowEffect);

procedure StartOrPause;
procedure Stop;
procedure Previous;
procedure Next;
procedure Set_Previous_Next;

procedure Repeat_Set;
procedure Repeat_Inc_LoopState;
procedure Repeat_Back;

procedure Suffle;
procedure Suffle_GoTo;
procedure Suffle_Create_List;
procedure Suffle_Back;

procedure Band_Info;
procedure Band_Info_Close;
procedure Lyrics;
procedure Lyrics_Close;
procedure Album;
procedure Album_Close;

procedure Show_Tag(vSongName: String; vSongNum: Integer);

procedure Title_Animation;
procedure Get_Tag(vSongNum: SmallInt);

// Song position
procedure Update_Thumb_Pos(Sender: TObject; vValue: Single; vKeep: Boolean);

// Add new songs
procedure Add_Songs;

// Add songs in playlist based types
procedure Add_Songs_m3u(mPlaylistNum: SmallInt; mTrackName, mTrackPath: string; mSongNum: SmallInt);

// Update last played song from the current playlist
procedure Update_Last_Song(vNum: Integer);

implementation

uses
  main,
  uLoad_AllTypes,
  uSnippet_Text,
  uInternet_Files,
  uWindows,
  uSnippet_Convert,
  uSoundplayer_Actions,
  uSoundplayer_AllTypes,
  uSoundplayer_SetAll,
  uSoundplayer_Playlist,
  uSoundplayer_Scrapers_LastFm,
  uSoundplayer_Playlist_Create,
  uSoundplayer_Tag_Get,
  uSoundplayer_Tag_Mp3_SetAll,
  uSoundplayer_Tag_Mp3,
  uSoundplayer_Tag_Ogg_SetAll,
  uSoundplayer_Tag_Ogg, uDB_AUser, uDB;

procedure State;
begin
  if soundplayer.player = sNone then
    Set_Play(False, False, False, False)
  else if soundplayer.player = sPlay then
    Set_Play(True, False, False, False)
  else if soundplayer.player = sPause then
    Set_Play(False, True, False, False)
  else if soundplayer.player = sStop then
    Set_Play(False, False, True, False);

  Set_Previous_Next;

  if uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[0].Songs_Count <= 0 then
  begin
    vSoundplayer.player.Loop.TextSettings.FontColor := TAlphaColorRec.Grey;
    vSoundplayer.player.Suffle.TextSettings.FontColor := TAlphaColorRec.Grey;
    vSoundplayer.player.Equalizer.TextSettings.FontColor := TAlphaColorRec.Grey;
    vSoundplayer.player.Lyrics.TextSettings.FontColor := TAlphaColorRec.Grey;
  end;
  if uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[0].Songs_Count > 0 then
  begin
    Repeat_Back;
    if soundplayer.player_actions.list_repeat.num = -1 then
      Suffle;
  end;
  soundplayer.player_actions.Time_Negative := soundplayer.player_actions.Time_Negative;
end;

procedure Set_Play(vPlay, vPause, vStop, vMute: Boolean);
begin
  if vPlay or vPause or vStop then
  begin

    if vPlay then
    begin
      vSoundplayer.player.Play.Text := #$ea1c;
      vSoundplayer.player.Play.TextSettings.FontColor := TAlphaColorRec.Blueviolet;
      vSoundplayer.player.Play_Glow.GlowColor := TAlphaColorRec.Blueviolet;
    end
    else
      vSoundplayer.player.Play.TextSettings.FontColor := TAlphaColorRec.Grey;

    if vPause then
    begin
      vSoundplayer.player.Play.Text := #$ea1d;
      vSoundplayer.player.Play.TextSettings.FontColor := TAlphaColorRec.Greenyellow;
      vSoundplayer.player.Play_Glow.GlowColor := TAlphaColorRec.Greenyellow;
    end;

    if vStop then
    begin
      vSoundplayer.player.Stop.TextSettings.FontColor := TAlphaColorRec.Red;
    end;
  end
  else
  begin
    vSoundplayer.player.Play.TextSettings.FontColor := TAlphaColorRec.Grey;
    vSoundplayer.player.Stop.TextSettings.FontColor := TAlphaColorRec.Grey;
  end;

{  if uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].Songs_Count = -1 then
  begin


  end
  else
  begin
    if soundplayer.player = sStop then
    begin
      vSoundplayer.player.Play.Text := #$ea1c;
      vSoundplayer.player.Play.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vSoundplayer.player.Play_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
      vSoundplayer.Playlist.List.Cells[1, soundplayer.player_actions.Playing_Now] := '2';
    end
    else
    begin
      if soundplayer.player = sPlay then
      begin
        vSoundplayer.player.Play.Text := #$ea1c;
        vSoundplayer.player.Play.TextSettings.FontColor := TAlphaColorRec.Blueviolet;
        vSoundplayer.player.Play_Glow.GlowColor := TAlphaColorRec.Blueviolet;
        vSoundplayer.player.Stop.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
        vSoundplayer.Playlist.List.Cells[1, soundplayer.player_actions.Playing_Now] := '0';
      end
      else if soundplayer.player = sPause then
      begin

        vSoundplayer.player.Stop.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
        vSoundplayer.Playlist.List.Cells[1, soundplayer.player_actions.Playing_Now] := '1';
      end
      else
      begin
        vSoundplayer.player.Stop.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
        vSoundplayer.player.Play.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      end;
    end;
  end; }
end;

/// /////////////////////////////////////////////

procedure Refresh;
var
  sCT, sFT: Real;
  vRand: Integer;
  vRand_Str: String;
  viPos: Integer;
  vi: Integer;
begin
  if soundplayer.player = sPlay then
  begin
    sCT := trunc(BASS_ChannelBytes2Seconds(sound.str_music[1], BASS_ChannelGetPosition(sound.str_music[1], BASS_POS_BYTE)));
    sFT := trunc(BASS_ChannelBytes2Seconds(sound.str_music[1], BASS_ChannelGetLength(sound.str_music[1], BASS_POS_BYTE)));

    viPos := Pos('addon_soundplayer', extrafe.prog.State);

    if viPos <> 0 then
      if soundplayer.player_actions.Thumb_Active = False then
      begin
        if soundplayer.player_actions.Time_Negative = False then
          vSoundplayer.player.Song_PlayTime.Text := FormatDateTime('hh:mm:ss', uSnippet_Convert.Time_Seconds_To_Time(sCT))
        else
          vSoundplayer.player.Song_PlayTime.Text := '-' + FormatDateTime('hh:mm:ss', uSnippet_Convert.Time_Seconds_To_Time(sFT - sCT));
        vSoundplayer.player.Song_Pos.Value := (sCT * 1000 / sFT);
        soundplayer.player_actions.Song_State := vSoundplayer.player.Song_Pos.Value;
      end;

    if BASS_ChannelGetPosition(sound.str_music[1], BASS_POS_BYTE) >= BASS_ChannelGetLength(sound.str_music[1], BASS_POS_BYTE) then
    begin
      if (soundplayer.player_actions.list_repeat.action = rNone) and (soundplayer.player_actions.Suffle.active = False) then
      begin
        if soundplayer.player_actions.Playing_Now + 1 <= uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].Songs_Count
        then
          Refresh_GoTo(soundplayer.player_actions.Playing_Now + 1)
        else
          Refresh_GoTo(0);
      end
      else if (soundplayer.player_actions.list_repeat.action = rNone) and (soundplayer.player_actions.Suffle.active) then
        Suffle_GoTo
      else if (soundplayer.player_actions.list_repeat.action <> rNone) and (soundplayer.player_actions.Suffle.active) then
      begin
        if soundplayer.player_actions.list_repeat.action = rList_One then
        begin
          if soundplayer.player_actions.Suffle.List.Count = 1 then
          begin
            if soundplayer.player_actions.list_repeat.num = 1 then
              soundplayer.player_actions.list_repeat.num := -1
            else
              Dec(soundplayer.player_actions.list_repeat.num, 1);
          end;
          Suffle_GoTo;
        end
        else if soundplayer.player_actions.list_repeat.action = rList_Inf then
          Suffle_GoTo;
      end
      else if soundplayer.player_actions.list_repeat.action <> rNone then
      begin
        if soundplayer.player_actions.list_repeat.action = rSong_One then
        begin
          if soundplayer.player_actions.list_repeat.num = 1 then
            Repeat_Set
          else
          begin
            Dec(soundplayer.player_actions.list_repeat.num, 1);
            vSoundplayer.player.Loop_State.Text := soundplayer.player_actions.list_repeat.num.ToString;
          end;
          Refresh_GoTo(soundplayer.player_actions.Playing_Now);
        end
        else if soundplayer.player_actions.list_repeat.action = rSong_Inf then
          Refresh_GoTo(soundplayer.player_actions.Playing_Now)
        else if soundplayer.player_actions.list_repeat.action = rList_One then
        begin
          vSoundplayer.Playlist.List.Cells[1, soundplayer.player_actions.Playing_Now] := '3';
          if soundplayer.player_actions.list_repeat.songs = 0 then
          begin
            if soundplayer.player_actions.list_repeat.num = 1 then
              Repeat_Set
            else
            begin
              Dec(soundplayer.player_actions.list_repeat.num, 1);
              vSoundplayer.player.Loop_State.Text := soundplayer.player_actions.list_repeat.num.ToString;
              soundplayer.player_actions.list_repeat.songs := ADDONS.soundplayer.Playlist.List.Songs_Num - 1;
            end;
            soundplayer.player_actions.Playing_Now := 0;
          end
          else
          begin
            Inc(soundplayer.player_actions.Playing_Now, 1);
            Dec(soundplayer.player_actions.list_repeat.songs, 1);
          end;
          Refresh_GoTo(soundplayer.player_actions.Playing_Now);
        end
        else if soundplayer.player_actions.list_repeat.action = rList_Inf then
        begin
          vSoundplayer.Playlist.List.Cells[1, soundplayer.player_actions.Playing_Now] := '3';
          if soundplayer.player_actions.Playing_Now = ADDONS.soundplayer.Playlist.List.Songs_Num - 1 then
            soundplayer.player_actions.Playing_Now := 0
          else
            Inc(soundplayer.player_actions.Playing_Now, 1);
          Refresh_GoTo(soundplayer.player_actions.Playing_Now);
        end;
      end;
    end;
  end;
end;

procedure Set_Previous_Next;
begin
  if uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].Songs_Count = 0 then
  begin
    vSoundplayer.player.Next.TextSettings.FontColor := TAlphaColorRec.Grey;
    vSoundplayer.player.Previous.TextSettings.FontColor := TAlphaColorRec.Grey;
  end
  else
  begin
    if (soundplayer.player_actions.Playing_Now = 0) and (uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].Songs_Count = 1)
    then
    begin
      vSoundplayer.player.Previous.TextSettings.FontColor := TAlphaColorRec.Grey;
      vSoundplayer.player.Next.TextSettings.FontColor := TAlphaColorRec.Grey;
      if ADDONS.soundplayer.Playlist.Edit then
      begin
        vSoundplayer.Playlist.Songs_Edit.Down.TextSettings.FontColor := TAlphaColorRec.Grey;
        vSoundplayer.Playlist.Songs_Edit.Up.TextSettings.FontColor := TAlphaColorRec.Grey;
      end;
    end
    else if (soundplayer.player_actions.Playing_Now + 1 < uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].Songs_Count)
      and (soundplayer.player_actions.Playing_Now <> 0) then
    begin
      vSoundplayer.player.Previous.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vSoundplayer.player.Next.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      if ADDONS.soundplayer.Playlist.Edit then
      begin
        vSoundplayer.Playlist.Songs_Edit.Down.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
        vSoundplayer.Playlist.Songs_Edit.Up.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      end;
    end
    else if soundplayer.player_actions.Playing_Now = 0 then
    begin
      vSoundplayer.player.Previous.TextSettings.FontColor := TAlphaColorRec.Grey;
      vSoundplayer.player.Next.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      if ADDONS.soundplayer.Playlist.Edit then
      begin
        vSoundplayer.Playlist.Songs_Edit.Down.TextSettings.FontColor := TAlphaColorRec.Grey;
        vSoundplayer.Playlist.Songs_Edit.Up.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      end;
    end
    else
    begin
      vSoundplayer.player.Previous.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vSoundplayer.player.Next.TextSettings.FontColor := TAlphaColorRec.Grey;
      if ADDONS.soundplayer.Playlist.Edit then
      begin
        vSoundplayer.Playlist.Songs_Edit.Down.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
        vSoundplayer.Playlist.Songs_Edit.Up.TextSettings.FontColor := TAlphaColorRec.Grey;
      end;
    end;
  end;
end;

procedure Refresh_GoTo(vGo: Integer);
begin
  Update_Last_Song(soundplayer.player_actions.Playing_Now);
  soundplayer.player_actions.LastPlayed := vGo;
  soundplayer.player_actions.Playing_Now := vGo;
  if extrafe.prog.State = 'addon_soundplayer' then
  begin
    uSoundplayer_Playlist.Set_Action_Line(pl_l_Note);
    vSoundplayer.Playlist.List.Selected := soundplayer.player_actions.Playing_Now;
    uSoundplayer_Player.Get_Tag(soundplayer.player_actions.Playing_Now);
    uSoundplayer_Tag_Get.Set_Icon;
    uSoundplayer_Playlist.Set_Action_Line(pl_l_Play);
  end;
  BASS_StreamFree(sound.str_music[1]);
  sound.str_music[1] := BASS_StreamCreateFile(False, PChar(uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].songs
    [soundplayer.player_actions.Playing_Now].Path + uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].songs
    [soundplayer.player_actions.Playing_Now].Path_Name), 0, 0, BASS_SAMPLE_FLOAT {$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
  BASS_ChannelSetPosition(sound.str_music[1], 0, 0);
  BASS_ChannelSetAttribute(sound.str_music[1], BASS_ATTRIB_VOL, soundplayer.player_actions.volume.Vol / 100);
  BASS_ChannelFlags(sound.str_music[1], BASS_MUSIC_POSRESET, 0);
  if soundplayer.player = sPlay then
    BASS_ChannelPlay(sound.str_music[1], False)
  else
  begin
    vSoundplayer.player.Song_PlayTime.Text := '00:00:00';
    soundplayer.player_actions.Time_Negative := False;
    vSoundplayer.player.Play.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vSoundplayer.player.Play_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  end;

  if extrafe.prog.State = 'addon_soundplayer' then
  begin
    vSoundplayer.player.Song_Pos.Value := 0;
    soundplayer.player_actions.Song_State := vSoundplayer.player.Song_Pos.Value;
  end;
  if soundplayer.player_actions.Suffle.active then
  begin

  end
  else
  begin
    if ((soundplayer.player_actions.list_repeat.action <> rSong_One) and (soundplayer.player_actions.list_repeat.action <> rSong_Inf)) then
      Set_Previous_Next;
  end;
end;

// Click actions
procedure StartOrPause;
begin
  if (soundplayer.player = sPause) or (soundplayer.player = sStop) then
  begin
    if soundplayer.player = sPause then
    begin
      BASS_ChannelPlay(sound.str_music[1], False);
      soundplayer.player := sPlay;
    end
    else
    begin
      soundplayer.player := sPlay;
      Refresh_GoTo(soundplayer.player_actions.Playing_Now);
    end;
    vSoundplayer.player.Stop.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vSoundplayer.player.Stop_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  end
  else
  begin
    BASS_ChannelPause(sound.str_music[1]);
    vSoundplayer.player.Play.Text := #$ea1d;
    vSoundplayer.player.Play.TextSettings.FontColor := TAlphaColorRec.Greenyellow;
    vSoundplayer.player.Play_Glow.GlowColor := TAlphaColorRec.Greenyellow;
    soundplayer.player := sPause;
    uSoundplayer_Playlist.Set_Action_Line(pl_l_Pause);
  end;
  vSoundplayer.timer.Song.Enabled := True;
end;

procedure Stop;
begin
  if vSoundplayer.player.Stop.TextSettings.FontColor = TAlphaColorRec.Deepskyblue then
  begin
    if sound.str_music[1] <> 0 then
      if (soundplayer.player = sPause) or (soundplayer.player = sPlay) then
      begin
        BASS_ChannelStop(sound.str_music[1]);
        BASS_ChannelSetPosition(sound.str_music[1], 0, 0);
        vSoundplayer.player.Song_Pos.Value := 0;
        vSoundplayer.player.Stop.TextSettings.FontColor := TAlphaColorRec.Red;
        vSoundplayer.player.Play.Text := #$ea1c;
        vSoundplayer.player.Play.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
        vSoundplayer.player.Play_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
        soundplayer.player := sStop;
        uSoundplayer_Player.Text_OnLeave(vSoundplayer.player.Stop, vSoundplayer.player.Stop_Glow);
        uSoundplayer_Playlist.Set_Action_Line(pl_l_Stop);
      end;
  end;
end;

procedure Previous;
begin
  if vSoundplayer.player.Previous.TextSettings.FontColor = TAlphaColorRec.Deepskyblue then
  begin
    if (soundplayer.player_actions.Suffle.active = False) and
      ((soundplayer.player_actions.list_repeat.action = rNone) or (soundplayer.player_actions.list_repeat.action = rList_One) or
      (soundplayer.player_actions.list_repeat.action = rList_Inf)) then
    begin
      if sound.str_music[1] <> 0 then
        if soundplayer.player_actions.Playing_Now > 0 then
        begin
          Refresh_GoTo(soundplayer.player_actions.Playing_Now - 1);
          if extrafe.prog.State = 'addon_soundplayer' then
          begin
            if soundplayer.player_actions.Playing_Now = 0 then
              uSoundplayer_Player.Text_OnLeave(vSoundplayer.player.Previous, vSoundplayer.player.Previous_Glow);
            vSoundplayer.info.Total_Songs.Text := IntToStr(soundplayer.player_actions.Playing_Now + 1) + '/' +
              ADDONS.soundplayer.Playlist.List.Songs_Num.ToString;
            uSoundplayer_Actions.Set_Animations;
          end;
        end;
    end
    else if (soundplayer.player_actions.Suffle.active) then
    begin
      Suffle_GoTo;
      if soundplayer.player_actions.Suffle.List.Count = 1 then
        uSoundplayer_Player.Text_OnLeave(vSoundplayer.player.Previous, vSoundplayer.player.Previous_Glow);
    end;
  end;
end;

procedure Next;
begin
  if vSoundplayer.player.Next.TextSettings.FontColor = TAlphaColorRec.Deepskyblue then
  begin
    if (soundplayer.player_actions.Suffle.active = False) and
      ((soundplayer.player_actions.list_repeat.action = rNone) or (soundplayer.player_actions.list_repeat.action = rList_One) or
      (soundplayer.player_actions.list_repeat.action = rList_Inf)) then
    begin
      if soundplayer.player_actions.Playing_Now < vSoundplayer.Playlist.List.RowCount - 1 then
      begin
        Refresh_GoTo(soundplayer.player_actions.Playing_Now + 1);
        if extrafe.prog.State = 'addon_soundplayer' then
        begin
          if soundplayer.player_actions.Playing_Now = vSoundplayer.Playlist.List.RowCount - 1 then
            uSoundplayer_Player.Text_OnLeave(vSoundplayer.player.Next, vSoundplayer.player.Next_Glow);
          vSoundplayer.info.Total_Songs.Text := IntToStr(soundplayer.player_actions.Playing_Now + 1) + '/' + uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists
            [soundplayer.player_actions.Playlist_Now].Songs_Count.ToString;
          uSoundplayer_Actions.Set_Animations;
        end;
      end;
    end
    else if (soundplayer.player_actions.Suffle.active) then
    begin
      Suffle_GoTo;
      if soundplayer.player_actions.Suffle.List.Count = 1 then
        uSoundplayer_Player.Text_OnLeave(vSoundplayer.player.Next, vSoundplayer.player.Next_Glow);
    end;
  end
end;

procedure Repeat_Set;
begin
  if vSoundplayer.player.Loop.TextSettings.FontColor <> TAlphaColorRec.Grey then
  begin
    if soundplayer.player_actions.list_repeat.action = rNone then
      soundplayer.player_actions.list_repeat.action := rSong_One
    else if soundplayer.player_actions.list_repeat.action = rSong_One then
      soundplayer.player_actions.list_repeat.action := rSong_Inf
    else if soundplayer.player_actions.list_repeat.action = rSong_Inf then
      soundplayer.player_actions.list_repeat.action := rList_One
    else if soundplayer.player_actions.list_repeat.action = rList_One then
    begin
      soundplayer.player_actions.list_repeat.action := rList_Inf;
      if soundplayer.player_actions.Suffle.active then
        Suffle;
    end
    else if soundplayer.player_actions.list_repeat.action = rList_Inf then
    begin
      soundplayer.player_actions.list_repeat.action := rNone;
      if soundplayer.player_actions.Suffle.active then
        Suffle;
    end;

    if soundplayer.player_actions.list_repeat.action = rNone then
    begin
      vSoundplayer.player.Loop_State.Visible := False;
      vSoundplayer.player.Loop_To.Visible := False;
      vSoundplayer.player.Loop.RotationAngle := 360;
      vSoundplayer.player.Loop.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vSoundplayer.player.Loop_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
      soundplayer.player_actions.list_repeat.num := -1;
      soundplayer.player_actions.list_repeat.songs := -1;
      if ADDONS.soundplayer.Playlist.List.Songs_Num = soundplayer.player_actions.Playing_Now then
        vSoundplayer.player.Next.TextSettings.FontColor := TAlphaColorRec.Grey
      else
        vSoundplayer.player.Next.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      if soundplayer.player_actions.Playing_Now = 0 then
        vSoundplayer.player.Previous.TextSettings.FontColor := TAlphaColorRec.Grey
      else
        vSoundplayer.player.Previous.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end
    else if soundplayer.player_actions.list_repeat.action = rSong_One then
    begin
      vSoundplayer.player.Loop.RotationAngle := -72;
      vSoundplayer.player.Loop_State.Visible := True;
      if soundplayer.player_actions.list_repeat.num = -1 then
        soundplayer.player_actions.list_repeat.num := 1;
      soundplayer.player_actions.list_repeat.num := soundplayer.player_actions.list_repeat.num;
      vSoundplayer.player.Loop_State.Text := soundplayer.player_actions.list_repeat.num.ToString;
      vSoundplayer.player.Loop_To.Text := #$e911;
      vSoundplayer.player.Loop_To.Visible := True;
      vSoundplayer.player.Loop.TextSettings.FontColor := TAlphaColorRec.Darkturquoise;
      vSoundplayer.player.Loop_Glow.GlowColor := TAlphaColorRec.Darkturquoise;
      vSoundplayer.player.Next.TextSettings.FontColor := TAlphaColorRec.Grey;
      vSoundplayer.player.Previous.TextSettings.FontColor := TAlphaColorRec.Grey;
      vSoundplayer.player.Suffle.TextSettings.FontColor := TAlphaColorRec.Grey;
    end
    else if soundplayer.player_actions.list_repeat.action = rSong_Inf then
    begin
      vSoundplayer.player.Loop.RotationAngle := -144;
      vSoundplayer.player.Loop_State.Visible := True;
      vSoundplayer.player.Loop_State.Text := #$ea2f;
      soundplayer.player_actions.list_repeat.num := -1;
      vSoundplayer.player.Loop_To.Text := #$e911;
      vSoundplayer.player.Loop_To.Visible := True;
      vSoundplayer.player.Loop.TextSettings.FontColor := TAlphaColorRec.Darkseagreen;
      vSoundplayer.player.Loop_Glow.GlowColor := TAlphaColorRec.Darkseagreen;
      vSoundplayer.player.Next.TextSettings.FontColor := TAlphaColorRec.Grey;
      vSoundplayer.player.Previous.TextSettings.FontColor := TAlphaColorRec.Grey;
    end
    else if soundplayer.player_actions.list_repeat.action = rList_One then
    begin
      vSoundplayer.player.Loop.RotationAngle := -216;
      vSoundplayer.player.Loop_State.Visible := True;
      if soundplayer.player_actions.list_repeat.num = -1 then
      begin
        if soundplayer.player_actions.list_repeat.songs = -1 then
          soundplayer.player_actions.list_repeat.songs := (ADDONS.soundplayer.Playlist.List.Songs_Num - 1) - soundplayer.player_actions.Playing_Now;
      end;
      soundplayer.player_actions.list_repeat.songs := soundplayer.player_actions.list_repeat.songs;
      if soundplayer.player_actions.list_repeat.num = -1 then
        soundplayer.player_actions.list_repeat.num := 1;
      soundplayer.player_actions.list_repeat.num := soundplayer.player_actions.list_repeat.num;
      vSoundplayer.player.Loop_State.Text := soundplayer.player_actions.list_repeat.num.ToString;
      vSoundplayer.player.Loop_To.Text := #$e9bb;
      vSoundplayer.player.Loop_To.Visible := True;
      vSoundplayer.player.Loop.TextSettings.FontColor := TAlphaColorRec.Lightsalmon;
      vSoundplayer.player.Loop_Glow.GlowColor := TAlphaColorRec.Lightsalmon;
      vSoundplayer.player.Next.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vSoundplayer.player.Previous.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vSoundplayer.player.Suffle.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end
    else if soundplayer.player_actions.list_repeat.action = rList_Inf then
    begin
      vSoundplayer.player.Loop.RotationAngle := -288;
      vSoundplayer.player.Loop_State.Visible := True;
      vSoundplayer.player.Loop_State.Text := #$ea2f;
      soundplayer.player_actions.list_repeat.num := -1;
      soundplayer.player_actions.list_repeat.songs := -1;
      vSoundplayer.player.Loop_To.Text := #$e9bb;
      vSoundplayer.player.Loop_To.Visible := True;
      vSoundplayer.player.Loop.TextSettings.FontColor := TAlphaColorRec.Lightpink;
      vSoundplayer.player.Loop_Glow.GlowColor := TAlphaColorRec.Lightpink;
      vSoundplayer.player.Next.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vSoundplayer.player.Previous.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end;
  end;
end;

procedure Repeat_Inc_LoopState;
begin
  if soundplayer.player_actions.list_repeat.num <> -1 then
  begin
    if soundplayer.player_actions.list_repeat.num = 9 then
      soundplayer.player_actions.list_repeat.num := 0;
    Inc(soundplayer.player_actions.list_repeat.num, 1);
    vSoundplayer.player.Loop_State.Text := soundplayer.player_actions.list_repeat.num.ToString;
  end;
end;

procedure Repeat_Back;
begin
  vSoundplayer.player.Loop.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  if soundplayer.player_actions.list_repeat.action = rNone then
    soundplayer.player_actions.list_repeat.action := rList_Inf
  else if soundplayer.player_actions.list_repeat.action = rSong_One then
    soundplayer.player_actions.list_repeat.action := rNone
  else if soundplayer.player_actions.list_repeat.action = rSong_Inf then
    soundplayer.player_actions.list_repeat.action := rSong_One
  else if soundplayer.player_actions.list_repeat.action = rList_One then
    soundplayer.player_actions.list_repeat.action := rSong_Inf
  else if soundplayer.player_actions.list_repeat.action = rList_Inf then
    soundplayer.player_actions.list_repeat.action := rList_One;
  Repeat_Set;
  vSoundplayer.player.Suffle.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
end;
/// //////////////////////////////////////

procedure Suffle;
var
  vi: Integer;
begin
  if (soundplayer.player_actions.list_repeat.action = rSong_One) or (soundplayer.player_actions.list_repeat.action = rSong_Inf) then
  begin
    vSoundplayer.player.Suffle.TextSettings.FontColor := TAlphaColorRec.Grey;
    soundplayer.player_actions.Suffle.active := False;
  end;
  if vSoundplayer.player.Suffle.TextSettings.FontColor <> TAlphaColorRec.Grey then
  begin
    if soundplayer.player_actions.Suffle.active then
    begin
      vSoundplayer.player.Suffle.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      FreeAndNil(soundplayer.player_actions.Suffle.List);
      for vi := 0 to ADDONS.soundplayer.Playlist.List.Songs_Num - 1 do
        vSoundplayer.Playlist.List.Cells[1, vi] := '3';
      vSoundplayer.Playlist.List.Cells[1, soundplayer.player_actions.Playing_Now] := '0';
    end
    else
    begin
      Suffle_Create_List;
      vSoundplayer.player.Suffle.TextSettings.FontColor := TAlphaColorRec.Limegreen;
      if vSoundplayer.player.Next.TextSettings.FontColor = TAlphaColorRec.Grey then
        vSoundplayer.player.Next.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      if vSoundplayer.player.Previous.TextSettings.FontColor = TAlphaColorRec.Grey then
        vSoundplayer.player.Previous.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end;
    soundplayer.player_actions.Suffle.active := not soundplayer.player_actions.Suffle.active;
  end;
end;

procedure Suffle_GoTo;
var
  vRand_Str: String;
  vRand: Integer;
  vi: Integer;
begin
  vRand_Str := soundplayer.player_actions.Playing_Now.ToString;
  soundplayer.player_actions.Suffle.List.Delete(soundplayer.player_actions.Suffle.List.IndexOf(vRand_Str));
  if soundplayer.player_actions.Suffle.List.Count > 0 then
  begin
    vRand := Random(soundplayer.player_actions.Suffle.List.Count);
    vRand := soundplayer.player_actions.Suffle.List.Strings[vRand].ToInteger;
    if extrafe.prog.State = 'addon_soundplayer' then
      vSoundplayer.Playlist.List.Cells[1, soundplayer.player_actions.Playing_Now] := '12';
    soundplayer.player_actions.Playing_Now := vRand;
    Refresh_GoTo(soundplayer.player_actions.Playing_Now);
    if soundplayer.player_actions.Suffle.List.Count = 1 then
    begin
      vSoundplayer.player.Next.TextSettings.FontColor := TAlphaColorRec.Grey;
      vSoundplayer.player.Next_Glow.Enabled := False;
      vSoundplayer.player.Previous.TextSettings.FontColor := TAlphaColorRec.Grey;
      vSoundplayer.player.Previous_Glow.Enabled := False;
    end;
  end
  else
  begin
    for vi := 0 to ADDONS.soundplayer.Playlist.List.Songs_Num - 1 do
      vSoundplayer.Playlist.List.Cells[1, vi] := '3';
    if soundplayer.player_actions.list_repeat.action = rList_One then
    begin
      if soundplayer.player_actions.list_repeat.num = -1 then
      begin
        soundplayer.player_actions.list_repeat.action := rList_Inf;
        Repeat_Set;
        Suffle;
        Set_Previous_Next;
      end
      else
      begin
        vSoundplayer.player.Loop_State.Text := soundplayer.player_actions.list_repeat.num.ToString;
        Suffle_Create_List;
        vSoundplayer.player.Next.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
        vSoundplayer.player.Previous.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      end;
    end
    else if soundplayer.player_actions.list_repeat.action = rList_Inf then
    begin
      Suffle_Create_List;
      vSoundplayer.player.Next.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vSoundplayer.player.Previous.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end
    else
      Suffle;
    Refresh_GoTo(0);
  end;
end;

procedure Suffle_Create_List;
var
  vi: Integer;
begin
  if Assigned(soundplayer.player_actions.Suffle.List) then
    FreeAndNil(soundplayer.player_actions.Suffle.List);
  if not Assigned(soundplayer.player_actions.Suffle.List) then
  begin
    soundplayer.player_actions.Suffle.List := TStringList.Create;
    for vi := 0 to ADDONS.soundplayer.Playlist.List.Songs_Num - 1 do
      soundplayer.player_actions.Suffle.List.Add(vi.ToString);
  end;
end;

procedure Suffle_Back;
var
  vi: Integer;
  list_num: String;
begin
  for vi := 0 to ADDONS.soundplayer.Playlist.List.Songs_Num - 1 do
    vSoundplayer.Playlist.List.Cells[1, vi] := '12';
  for vi := 0 to soundplayer.player_actions.Suffle.List.Count - 1 do
  begin
    list_num := soundplayer.player_actions.Suffle.List.Strings[vi];
    vSoundplayer.Playlist.List.Cells[1, list_num.ToInteger] := '3';
  end;
  if soundplayer.player = sPlay then
    vSoundplayer.Playlist.List.Cells[1, soundplayer.player_actions.Playing_Now] := '0';
  vSoundplayer.player.Suffle.TextSettings.FontColor := TAlphaColorRec.Greenyellow;
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
  if soundplayer.player_actions.Time_Negative = False then
    vSoundplayer.player.Song_PlayTime.Text := FormatDateTime('hh:mm:ss', uSnippet_Convert.Time_Seconds_To_Time(vCurrent_Position_Song))
  else
    vSoundplayer.player.Song_PlayTime.Text := '-' + FormatDateTime('hh:mm:ss', uSnippet_Convert.Time_Seconds_To_Time(sFT - vCurrent_Position_Song));
  if vKeep then
  begin
    BASS_ChannelSetPosition(sound.str_music[1], BASS_ChannelSeconds2Bytes(sound.str_music[1], vCurrent_Position_Song), BASS_POS_BYTE);
    soundplayer.player_actions.Thumb_Active := False;
  end;
end;

///

procedure Add_Songs_m3u(mPlaylistNum: SmallInt; mTrackName, mTrackPath: string; mSongNum: SmallInt);
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
  vSongTime := FormatDateTime('hh:mm:ss', uSnippet_Convert.Time_Seconds_To_Time(song_seconds));
  ADDONS.soundplayer.Playlist.List.Playlist.Add('#EXTINF:' + vss + ',' + mTrackName);
  ADDONS.soundplayer.Playlist.List.Playlist.Add(mTrackPath + mTrackName);
  ADDONS.soundplayer.Playlist.List.Playlist.SaveToFile(ADDONS.soundplayer.Path.Playlists + ADDONS.soundplayer.Playlist.List.Name + '.m3u');
  ADDONS.soundplayer.Playlist.List.songs.Add(mTrackPath + mTrackName);
  uSoundPlayer_GetTag_Details(mTrackPath + mTrackName, ADDONS.soundplayer.Playlist.active, mSongNum, vSongTime);
  BASS_StreamFree(sound.str_music[2]);
end;

procedure Add_Songs;
var
  vSongNum: SmallInt;
  vi: SmallInt;
  vSong_Time: Real;
  vSong_Time_Str: String;
  vSong_Pos: Integer;
  vSong_Name: String;
  vList_Num: Integer;
  vSong_Artist: String;
  vSong_Audio_Type: String;
  vSong_Path_Name: String;
  vSong_Path: String;
  vSong_Last: ShortInt;
  vLength_Num: Integer;
begin
  if vSoundplayer.scene.OpenDialog.FileName <> '' then
  begin
    vSongNum := soundplayer.player_actions.Playing_Now;

    for vi := 0 to vSoundplayer.scene.OpenDialog.Files.Count - 1 do
    begin
      vSong_Path_Name := ExtractFileName(vSoundplayer.scene.OpenDialog.Files[vi]);
      vSong_Path := ExtractFilePath(vSoundplayer.scene.OpenDialog.Files[vi]);
      vSong_Audio_Type := ExtractFileExt(vSoundplayer.scene.OpenDialog.Files[vi]);

      uSoundplayer_Tag_Get.Details(vSong_Path + vSong_Path_Name, vSong_Audio_Type);

      vSong_Name := uSoundplayer_AllTypes.vTag_MP3.Title;
      vSong_Artist := uSoundplayer_AllTypes.vTag_MP3.Artist;
      vSong_Audio_Type := vSong_Audio_Type;
      vSong_Path := vSong_Path;
      vList_Num := uDB_AUser.Local.ADDONS.Soundplayer_D.Last_Playlist_Num;

      Inc(uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].Songs_Count);
      vSong_Pos := uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].Songs_Count;
      sound.str_music[2] := BASS_StreamCreateFile(False, PChar(vSong_Path + vSong_Path_Name), 0, 0, BASS_SAMPLE_FLOAT
{$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
      BASS_ChannelFlags(sound.str_music[2], BASS_MUSIC_POSRESET, 0);
      vSong_Time := trunc(BASS_ChannelBytes2Seconds(sound.str_music[2], BASS_ChannelGetLength(sound.str_music[2], BASS_POS_BYTE)));
      vSong_Last := 1;
      vSong_Time_Str := uSoundplayer_Actions.Time_From_Seconds(FloatToStr(vSong_Time).ToInteger);

      vSong_Name := StringReplace(vSong_Name, '''', '~%', [rfReplaceAll, rfIgnoreCase]);
      vSong_Path_Name := StringReplace(vSong_Path_Name, '''', '~%', [rfReplaceAll, rfIgnoreCase]);

      uDB.ExtraFE_Query_Local.Close;
      uDB.ExtraFE_Query_Local.SQL.Clear;
      uDB.ExtraFE_Query_Local.SQL.Text := 'UPDATE addon_soundplayer_playlists SET Songs_Count=''' + uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists
        [soundplayer.player_actions.Playlist_Now].Songs_Count.ToString + ''' WHERE id=''' + vList_Num.ToString + ''' ';
      uDB.ExtraFE_Query_Local.ExecSQL;

      uDB.ExtraFE_Query_Local.Close;
      uDB.ExtraFE_Query_Local.SQL.Clear;
      uDB.ExtraFE_Query_Local.SQL.Text := 'UPDATE addon_soundplayer_playlists_songs SET Song_Last=''0''';
      uDB.ExtraFE_Query_Local.ExecSQL;

      uDB.ExtraFE_Query_Local.Close;
      uDB.ExtraFE_Query_Local.SQL.Clear;
      uDB.ExtraFE_Query_Local.SQL.Text :=
        'INSERT INTO addon_soundplayer_playlists_songs (Song_Name, Song_Artist, Song_Audio_Type, Song_Path_Name, Song_Path, Song_Position, Song_Time, Song_Time_Str, Song_Last, Playlist_Num) VALUES ('''
        + vSong_Name + ''', ''' + vSong_Artist + ''', ''' + vSong_Audio_Type + ''', ''' + vSong_Path_Name + ''',  ''' + vSong_Path + ''', ''' +
        vSong_Pos.ToString + ''',  ''' + FloatToStr(vSong_Time) + ''', ''' + vSong_Time_Str + ''', ''' + vSong_Last.ToString + ''', ''' +
        vList_Num.ToString + ''')';
      uDB.ExtraFE_Query_Local.ExecSQL;

      BASS_StreamFree(sound.str_music[2]);

      vSoundplayer.Playlist.List.RowCount := vSoundplayer.Playlist.List.RowCount + 1;

      vSong_Name := StringReplace(vSong_Name, '~%', '''', [rfReplaceAll, rfIgnoreCase]);
      vSoundplayer.Playlist.List.Cells[0, vSoundplayer.Playlist.List.RowCount - 1] := (vSoundplayer.Playlist.List.RowCount + 1).ToString;
      vSoundplayer.Playlist.List.Cells[1, vSoundplayer.Playlist.List.RowCount - 1] := '0';
      vSoundplayer.Playlist.List.Cells[2, vSoundplayer.Playlist.List.RowCount - 1] := vSong_Name;
      vSoundplayer.Playlist.List.Cells[3, vSoundplayer.Playlist.List.RowCount - 1] := vSong_Artist;
      vSoundplayer.Playlist.List.Cells[4, vSoundplayer.Playlist.List.RowCount - 1] := uSoundplayer_Actions.Time_From_Seconds(FloatToStr(vSong_Time).ToInteger);
      if vSong_Audio_Type = '.mp3' then
        vSoundplayer.Playlist.List.Cells[5, vSoundplayer.Playlist.List.RowCount - 1] := '4'
      else if vSong_Audio_Type = '.ogg' then
        vSoundplayer.Playlist.List.Cells[5, vSoundplayer.Playlist.List.RowCount - 1] := '5'
      else
        vSoundplayer.Playlist.List.Cells[5, vSoundplayer.Playlist.List.RowCount - 1] := '10';
    end;

    uSoundplayer_Actions.Get_Data;
  end;
end;

procedure Get_Tag(vSongNum: SmallInt);
var
  vSong: string;
  vi, vk: Integer;
  vDescription: String;
  vImage: TBitmap;
  vPath: String;

  vRating: Single;
  vRate: Integer;
begin
  uSoundplayer_Tag_Mp3.Get_ID3v1(uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].songs
    [soundplayer.player_actions.Playing_Now].Path + uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].songs
    [soundplayer.player_actions.Playing_Now].Path_Name);
  uSoundplayer_Tag_Mp3.Get_ID3v2(uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].songs
    [soundplayer.player_actions.Playing_Now].Path + uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].songs
    [soundplayer.player_actions.Playing_Now].Path_Name);

  vSoundplayer.player.Song_Title.Text := '"' + soundplayer.player_actions.Tag.mp3.Info_ID3v2.Song.Title + '" by "' +
    soundplayer.player_actions.Tag.mp3.Info_ID3v2.Song.Artist + '"';
  if uSnippet_Text_ToPixels(vSoundplayer.player.Song_Title) < 990 then
  begin
    vSoundplayer.player.Song_Title_Ani.Stop;
    soundplayer.player_actions.Title_Ani := False;
    vSoundplayer.player.Song_Title.Position.X := extrafe.res.Half_Width - 800;
    vSoundplayer.player.Song_Title.TextSettings.HorzAlign := TTextAlign.Center;
  end
  else
  begin
    vSoundplayer.player.Song_Title.Position.X := 465;
    vSoundplayer.player.Song_Title.TextSettings.HorzAlign := TTextAlign.Leading;
    soundplayer.player_actions.Title_Ani := True;
    Title_Animation;
  end;
  if uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].songs[vSongNum].Time > 3600 then
    vSoundplayer.player.Song_Time.Text := '0' + uSoundplayer_Actions.Time_From_Seconds
      (uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].songs[vSongNum].Time)
  else
    vSoundplayer.player.Song_Time.Text := '00:' + uSoundplayer_Actions.Time_From_Seconds
      (uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].songs[vSongNum].Time);
  if uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].songs[vSongNum].Audio_Type = '.mp3' then
  begin
    vk := 0;
    for vi := 0 to 4 do
    begin
      vSoundplayer.player.Rate[vi].Text := #$e9d7;
      vSoundplayer.player.Rate[vi].Visible := True;
    end;
    vRating := uSoundplayer_Tag_Mp3.Rating_Get;
    vRate := round(vRating / 25.5);
    vk := 0;
    for vi := 0 to vRate - 1 do
    begin
      if not odd(vi) then
        vSoundplayer.player.Rate[vk].Text := #$e9d8
      else
      begin
        vSoundplayer.player.Rate[vk].Text := #$e9d9;
        Inc(vk);
      end;
    end;

    { if ADDONS.soundplayer.Playlist.List.Song_Info[vSongNum].Lyrics.Count - 1 > 1 then
      vSoundplayer.Player.Lyrics.TextSettings.FontColor := TAlphaColorRec.Deepskyblue
      else
      vSoundplayer.Player.Lyrics.TextSettings.FontColor := TAlphaColorRec.Grey; }
  end
  else if uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].songs[vSongNum].Audio_Type = '.ogg' then
  begin

  end;

  vSoundplayer.info.Song_Title.Text := soundplayer.player_actions.Tag.mp3.Info_ID3v2.Song.Title;
  if uSnippet_Text_ToPixels(vSoundplayer.info.Song_Title) > 422 then
    vSoundplayer.info.Song_Title.Text := uSnippet_Text_SetInGivenPixels(422, vSoundplayer.info.Song_Title);
  vSoundplayer.info.Artist_Name.Text := soundplayer.player_actions.Tag.mp3.Info_ID3v2.Song.Artist;
  vSoundplayer.info.Year_Publish.Text := soundplayer.player_actions.Tag.mp3.Info_ID3v2.Song.Year;
  vSoundplayer.info.Gerne_Kind.Text := soundplayer.player_actions.Tag.mp3.Info_ID3v2.Song.Genre;
  vSoundplayer.info.Track_Num.Text := soundplayer.player_actions.Tag.mp3.Info_ID3v2.Song.Track;

  if uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].songs[vSongNum].Audio_Type = '.mp3' then
  begin
    vSoundplayer.info.Cover.Bitmap := soundplayer.player_actions.Tag.mp3.Info_ID3v2.Song.Covers[0];
    vSoundplayer.info.Cover_Label.Text := soundplayer.player_actions.Tag.mp3.Info_ID3v2.Song.Cover_Description[0];
    { vPath := uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].songs[vSongNum].Path +
      uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].songs[vSongNum].Path_Name;
      uSoundplayer_Tag_Mp3.APICIndex := 0;
      if uSoundplayer_Tag_Mp3.Cover_Get_Image(vDescription, vImage) then
      begin
      vSoundplayer.info.Cover.Bitmap := vImage;
      vSoundplayer.info.Cover_Label.Text := vDescription;
      end
      else
      begin
      vSoundplayer.info.Cover.Bitmap := nil;
      vSoundplayer.info.Cover_Label.Text := '';
      end; }
  end
  else if uDB_AUser.Local.ADDONS.Soundplayer_D.Playlists[soundplayer.player_actions.Playlist_Now].songs[vSongNum].Audio_Type = '.ogg' then
    // This must be function and return boolean with out from function
    GetTags_OGG_Cover(vSongNum);
  // vSong := ADDONS.soundplayer.Playlist.List.Songs.Strings[vSongNum];
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

    if ADDONS.soundplayer.Playlist.List.Song_Info[vSongNum].Disk_Type = '.mp3' then
    begin
      uSoundplayer_Tag_Mp3_SetAll.Load;
      uSoundplayer_Tag_Mp3.Get(vSongName, vSongNum);
    end
    else if ADDONS.soundplayer.Playlist.List.Song_Info[vSongNum].Disk_Type = '.ogg' then
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
    if soundplayer.player = sPlay then
    begin
      vGlow.GlowColor := TAlphaColorRec.Greenyellow;
      vText.Text := #$ea1d;
      vText.TextSettings.FontColor := TAlphaColorRec.Greenyellow;
    end
    else if soundplayer.player = sPause then
    begin
      vGlow.GlowColor := TAlphaColorRec.Blueviolet;
      vText.Text := #$ea1c;
      vText.TextSettings.FontColor := TAlphaColorRec.Blueviolet;
    end
    else
    begin
      vGlow.GlowColor := TAlphaColorRec.Deepskyblue;
      vText.Text := #$ea1c;
      vText.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end;
  end
  else if vText.Name = 'A_SP_Player_Suffle' then
  begin
    if soundplayer.player_actions.Suffle.active then
      vGlow.GlowColor := TAlphaColorRec.Limegreen
    else if soundplayer.player_actions.Suffle.active = False then
      vGlow.GlowColor := TAlphaColorRec.Deepskyblue;
  end;
  Text_ScaleUp;
  BASS_ChannelPlay(ADDONS.soundplayer.sound.Effects[2], False);
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
    if soundplayer.player = sPlay then
    begin
      vText.Text := #$ea1c;
      vText.TextSettings.FontColor := TAlphaColorRec.Blueviolet;
    end
    else if soundplayer.player = sPause then
    begin
      vText.Text := #$ea1d;
      vText.TextSettings.FontColor := TAlphaColorRec.Greenyellow;
    end
    else if soundplayer.player = sStop then
    begin
      vSoundplayer.player.Stop_Glow.Enabled := False;
    end;
  end;
  Text_ScaleDown;
end;

/// ///////////////////////////////////////////////////////////////////////////////////////////
procedure Update_Last_Song(vNum: Integer);
begin
  soundplayer.player_actions.LastPlayed := vNum;
  // addons.soundplayer.Ini.Ini.WriteInteger('Song', 'LastPlayed', vNum);
end;

procedure Title_Animation;
begin
  if soundplayer.player_actions.Title_Ani then
  begin
    if soundplayer.player_actions.Title_Ani_Left = False then
    begin
      vSoundplayer.player.Song_Title_Ani.StartValue := 465;
      vSoundplayer.player.Song_Title_Ani.StopValue := 465 - ((uSnippet_Text_ToPixels(vSoundplayer.player.Song_Title) + 5) - 1000);
    end
    else if soundplayer.player_actions.Title_Ani_Left then
    begin
      vSoundplayer.player.Song_Title_Ani.StartValue := vSoundplayer.player.Song_Title_Ani.StopValue;
      vSoundplayer.player.Song_Title_Ani.StopValue := 465;
    end;
    vSoundplayer.player.Song_Title_Ani.Start;
  end;
end;

/// Band Info Presentation
procedure Band_Info;
begin
  extrafe.prog.State := 'addon_soundplayer_player_band';

  Text_OnLeave(vSoundplayer.player.Band_Info, vSoundplayer.player.Band_Info_Glow);
  uSoundplayer_SetAll.Band_Information;

  uSoundplayer_Scrapers_LastFm.Artist_Company;
end;

procedure Band_Info_Close;
begin
  extrafe.prog.State := 'addon_soundplayer';
  FreeAndNil(vSoundplayer.player.Band_Info_Press.Header);
  FreeAndNil(vSoundplayer.player.Band_Info_Press.Name);
  FreeAndNil(vSoundplayer.player.Band_Info_Press.Powered_By);
  FreeAndNil(vSoundplayer.player.Band_Info_Press.Powered_Img);
  FreeAndNil(vSoundplayer.player.Band_Info_Press.Close);
  FreeAndNil(vSoundplayer.player.Band_Info_Press.Box);
  vSoundplayer.scene.Back_Blur.Enabled := False;
  vSoundplayer.scene.Back_Presentation.Visible := False;
end;

/// Lyrics Presentation
procedure Lyrics;
var
  vi: Integer;
begin
  extrafe.prog.State := 'addon_soundplayer_player_lyrics';
  Text_OnLeave(vSoundplayer.player.Lyrics, vSoundplayer.player.Lyrics_Glow);
  uSoundplayer_SetAll.Lyrics;

  vSoundplayer.player.Lyrics_Press.Name.Text := ADDONS.soundplayer.Playlist.List.Song_Info[soundplayer.player_actions.Playing_Now].Title;

  SetLength(vSoundplayer.player.Lyrics_Press.Lyrics, ADDONS.soundplayer.Playlist.List.Song_Info[soundplayer.player_actions.Playing_Now].Lyrics.Count + 1);

  for vi := 0 to ADDONS.soundplayer.Playlist.List.Song_Info[soundplayer.player_actions.Playing_Now].Lyrics.Count do
  begin
    vSoundplayer.player.Lyrics_Press.Lyrics[vi] := TText.Create(vSoundplayer.player.Lyrics_Press.Box);
    vSoundplayer.player.Lyrics_Press.Lyrics[vi].Name := 'A_SP_Lyrics_Lyrics_' + vi.ToString;
    vSoundplayer.player.Lyrics_Press.Lyrics[vi].Parent := vSoundplayer.player.Lyrics_Press.Box;
    vSoundplayer.player.Lyrics_Press.Lyrics[vi].SetBounds(30, (vi * 34), vSoundplayer.player.Lyrics_Press.Box.Width - 30, 34);
    vSoundplayer.player.Lyrics_Press.Lyrics[vi].Font.Family := 'Tahoma';
    vSoundplayer.player.Lyrics_Press.Lyrics[vi].TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.player.Lyrics_Press.Lyrics[vi].Font.Size := 28;
    if vi = ADDONS.soundplayer.Playlist.List.Song_Info[soundplayer.player_actions.Playing_Now].Lyrics.Count then
      vSoundplayer.player.Lyrics_Press.Lyrics[vi].Text := ''
    else
      vSoundplayer.player.Lyrics_Press.Lyrics[vi].Text := ADDONS.soundplayer.Playlist.List.Song_Info[soundplayer.player_actions.Playing_Now].Lyrics.Strings[vi];
    vSoundplayer.player.Lyrics_Press.Lyrics[vi].Visible := True;
  end;
end;

procedure Lyrics_Close;
begin
  extrafe.prog.State := 'addon_soundplayer';
  FreeAndNil(vSoundplayer.player.Lyrics_Press.Header);
  FreeAndNil(vSoundplayer.player.Lyrics_Press.Name);
  FreeAndNil(vSoundplayer.player.Lyrics_Press.Close);
  FreeAndNil(vSoundplayer.player.Lyrics_Press.Box);
  vSoundplayer.scene.Back_Blur.Enabled := False;
  vSoundplayer.scene.Back_Presentation.Visible := False;
end;

/// Album Presentation
procedure Album;
begin
  extrafe.prog.State := 'addon_soundplayer_player_album';

  Text_OnLeave(vSoundplayer.player.Album_Info, vSoundplayer.player.Album_Info_Glow);
  uSoundplayer_SetAll.Album_Information;

  uSoundplayer_Scrapers_LastFm.Album;
end;

procedure Album_Close;
begin
  extrafe.prog.State := 'addon_soundplayer';
  FreeAndNil(vSoundplayer.player.Album_Info_Press.Powered_By);
  FreeAndNil(vSoundplayer.player.Album_Info_Press.Powered_Img);
  FreeAndNil(vSoundplayer.player.Album_Info_Press.Name);
  FreeAndNil(vSoundplayer.player.Album_Info_Press.Box);
  FreeAndNil(vSoundplayer.player.Album_Info_Press.Close);
  vSoundplayer.scene.Back_Blur.Enabled := False;
  vSoundplayer.scene.Back_Presentation.Visible := False;
end;

end.
