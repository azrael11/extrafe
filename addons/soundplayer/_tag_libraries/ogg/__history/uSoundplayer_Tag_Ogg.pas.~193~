unit uSoundplayer_Tag_Ogg;

interface

uses
  System.Classes,
  System.SysUtils,
  FMX.Dialogs,
  OggVorbisAndOpusTagLibrary,
  Bass;

procedure uSoundplayer_Tag_Ogg_GetOgg(vPath: String);

procedure uSoundplayer_Tag_Ogg_GetOggCover;
procedure uSoundplayer_Tag_Ogg_Cover_Select;
procedure uSoundplayer_Tag_Ogg_Cover_Delete;

procedure uSoundplayer_Tag_Ogg_Save;

procedure uSoundplayer_Tag_Ogg_Cancel;

implementation

uses
  uLoad_AllTypes,
  uSoundplayer_AllTypes,
  uSoundplayer_Tag_Ogg_SetAll;

var
  vCurrentSongPath: String;

procedure uSoundplayer_Tag_Ogg_GetOgg(vPath: String);
begin
  vCurrentSongPath := vPath;
  addons.soundplayer.Player.Tag.ogg.Opus := TOpusTag.Create;

  addons.soundplayer.Player.Tag.ogg.TagError := addons.soundplayer.Player.Tag.ogg.Opus.LoadFromFile(vPath);

  if addons.soundplayer.Player.Tag.ogg.TagError = 0 then
  begin
    vSoundplayer.Tag.Opus.Title_V.Text :=
      addons.soundplayer.Player.Tag.ogg.Opus.ReadFrameByNameAsText('TITLE');
    vSoundplayer.Tag.Opus.Artist_V.Text := addons.soundplayer.Player.Tag.ogg.Opus.ReadFrameByNameAsText
      ('ARTIST');
    vSoundplayer.Tag.Opus.Album_V.Text :=
      addons.soundplayer.Player.Tag.ogg.Opus.ReadFrameByNameAsText('ALBUM');
    vSoundplayer.Tag.Opus.Genre_V.Text :=
      addons.soundplayer.Player.Tag.ogg.Opus.ReadFrameByNameAsText('GENRE');
    vSoundplayer.Tag.Opus.Date_V.Text := addons.soundplayer.Player.Tag.ogg.Opus.ReadFrameByNameAsText('YEAR');
    vSoundplayer.Tag.Opus.Track_V.Text :=
      addons.soundplayer.Player.Tag.ogg.Opus.ReadFrameByNameAsText('TRACK');
    vSoundplayer.Tag.Opus.Disk_V.Text := addons.soundplayer.Player.Tag.ogg.Opus.ReadFrameByNameAsText('DISC');
    vSoundplayer.Tag.Opus.Comment_V.Text := addons.soundplayer.Player.Tag.ogg.Opus.ReadFrameByNameAsText
      ('COMMENT');
  end;

  uSoundplayer_Tag_Ogg_GetOggCover;
end;

procedure uSoundplayer_Tag_Ogg_GetOggCover;
var
  Index: Integer;
  PictureStream: TStream;
  CoverArt: TOpusVorbisCoverArtInfo;
begin
  try
    Index := addons.soundplayer.Player.Tag.ogg.Opus.FrameExists
      (OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE);
    if Index > -1 then
    begin
      PictureStream := TMemoryStream.Create;
      try
        if addons.soundplayer.Player.Tag.ogg.Opus.GetCoverArtFromFrame(Index, PictureStream, CoverArt) then
        begin
          CoverArt.MIMEType := LowerCase(CoverArt.MIMEType);
          PictureStream.Seek(0, soFromBeginning);
          vSoundplayer.Tag.Opus.Cover.Bitmap.LoadFromStream(PictureStream);
        end;
      finally
        FreeAndNil(PictureStream);
      end;
    end
    else
      vSoundplayer.Tag.Opus.Cover.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_nocover.png');
  except
    // *
  end;
end;

procedure uSoundplayer_Tag_Ogg_Save;
var
  vGetSongPosition: word;
begin
  if addons.soundplayer.Playlist.List.Songs.Strings[addons.soundplayer.Player.Playing_Now] = vCurrentSongPath
  then
  begin
    vGetSongPosition := BASS_ChannelGetPosition(sound.str_music[1], 0);
    BASS_ChannelStop(sound.str_music[1]);
    BASS_StreamFree(sound.str_music[1]);
  end;

  addons.soundplayer.Player.Tag.ogg.Opus.SetTextFrameText('TITLE', vSoundplayer.Tag.Opus.Title_V.Text);
  addons.soundplayer.Player.Tag.ogg.Opus.SetTextFrameText('ARTIST', vSoundplayer.Tag.Opus.Artist_V.Text);
  addons.soundplayer.Player.Tag.ogg.Opus.SetTextFrameText('ALBUM', vSoundplayer.Tag.Opus.Album_V.Text);
  addons.soundplayer.Player.Tag.ogg.Opus.SetTextFrameText('GENRE', vSoundplayer.Tag.Opus.Genre_V.Text);
  addons.soundplayer.Player.Tag.ogg.Opus.SetTextFrameText('YEAR', vSoundplayer.Tag.Opus.Date_V.Text);
  addons.soundplayer.Player.Tag.ogg.Opus.SetTextFrameText('TRACK', vSoundplayer.Tag.Opus.Track_V.Text);
  addons.soundplayer.Player.Tag.ogg.Opus.SetTextFrameText('DISC', vSoundplayer.Tag.Opus.Disk_V.Text);
  addons.soundplayer.Player.Tag.ogg.Opus.SetTextFrameText('COMMENT', vSoundplayer.Tag.Opus.Comment_V.Text);

  addons.soundplayer.Player.Tag.ogg.TagError := addons.soundplayer.Player.Tag.ogg.Opus.SaveToFile
    (vCurrentSongPath);
  if addons.soundplayer.Player.Tag.ogg.TagError <> OPUSTAGLIBRARY_SUCCESS then
  begin
    Showmessage('Error while saving tag, error code: ' +
      IntToStr(addons.soundplayer.Player.Tag.ogg.TagError));
  end;

  addons.soundplayer.Player.Tag.ogg.Opus.Free;

  if addons.soundplayer.Playlist.List.Songs.Strings[addons.soundplayer.Player.Playing_Now] = vCurrentSongPath
  then
  begin
    sound.str_music[1] := BASS_StreamCreateFile(False,
      PChar(addons.soundplayer.Playlist.List.Songs.Strings[addons.soundplayer.Player.Playing_Now]), 0, 0,
      BASS_SAMPLE_FLOAT {$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
    BASS_ChannelSetAttribute(sound.str_music[1], BASS_ATTRIB_VOL, addons.soundplayer.Volume.Vol / 100);
    if addons.soundplayer.Player.Play then
    begin
      BASS_ChannelPlay(sound.str_music[1], False);
      BASS_ChannelPause(sound.str_music[1]);
      BASS_ChannelSetPosition(sound.str_music[1], vGetSongPosition, 0);
      BASS_ChannelPlay(sound.str_music[1], False);
    end;
  end;

  uSoundplayer_TagSet_Opus_Free;
end;

procedure uSoundplayer_Tag_Ogg_Cover_Select;
var
  CoverArt: TOpusVorbisCoverArtInfo;
  NewPictureStream: TFileStream;
  vMimeType: String;
begin
  vMimeType := ExtractFileExt(vSoundplayer.scene.OpenDialog.FileName);
  if vMimeType = '.bmp' then
    vMimeType := 'image/bmp'
  else if vMimeType = '.jpg' then
    vMimeType := 'image/jpeg'
  else if vMimeType = '.jpeg' then
    vMimeType := 'image/jpeg'
  else if vMimeType = '.png' then
    vMimeType := 'image/png';

  if vSoundplayer.scene.OpenDialog.FileName <> '' then
  begin
    NewPictureStream := TFileStream.Create(vSoundplayer.scene.OpenDialog.FileName, fmOpenRead);
    try
      with CoverArt do
      begin
        PictureType := 3;
        MIMEType := vMimeType;
        Description := 'Front Cover';
        Width := 1000;
        Height := 1000;
        ColorDepth := 24;
        NoOfColors := 0;
      end;

      if addons.soundplayer.Player.Tag.ogg.Opus.AddCoverArtFrame(NewPictureStream, CoverArt) > -1 then
      begin
        uSoundplayer_Tag_Ogg_GetOggCover;
        addons.soundplayer.Player.Tag.ogg.Opus.SaveToFile(vCurrentSongPath);
      end
      else
        Showmessage('Something wrong with adding this cover');
    finally
      FreeAndNil(NewPictureStream);
      vSoundplayer.Info.Cover.Bitmap.LoadFromFile(vSoundplayer.scene.OpenDialog.FileName);
    end;
  end;
end;

procedure uSoundplayer_Tag_Ogg_Cover_Delete;
var
  vi: integer;
begin
  vSoundplayer.Tag.Opus.Cover.Bitmap:= nil;
  for vi :=  0 to high(addons.soundplayer.Player.Tag.ogg.Opus.Frames) do
    begin
      if addons.soundplayer.Player.Tag.ogg.Opus.Frames[vi].IsCoverArt then
        addons.soundplayer.Player.Tag.ogg.Opus.DeleteFrame(vi);
    end;
  vSoundplayer.Info.Cover.Bitmap.LoadFromFile(addons.soundplayer.Path.Images+ 'sp_nocover.png');
end;

procedure uSoundplayer_Tag_Ogg_Cancel;
begin
  addons.soundplayer.Player.Tag.ogg.Opus.Free;
  uSoundplayer_TagSet_Opus_Free;
end;

end.
