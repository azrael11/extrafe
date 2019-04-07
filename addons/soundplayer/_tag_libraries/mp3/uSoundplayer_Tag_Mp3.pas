unit uSoundplayer_Tag_Mp3;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  FMX.Dialogs,
  FMX.Graphics,
  FMX.StdCtrls,
  ID3v1Library,
  ID3v2Library,
  Bass;

// procedure uTag_ID3v2_GetPicture(mNext: Boolean);
// function uTag_ID3v2_GetPic(mNum: byte): Boolean;

procedure Get(vPath: String; vSongNum: Integer);

procedure Get_ID3v1(vPath: String);
procedure Set_Tag_ID3v1(vPath: String);

procedure Get_ID3v2(vPath: String);
procedure Set_Tag_ID3v2(vPath: String);

procedure uSoundplayer_Tag_Mp3_Transfer(vInto: String);
procedure uSoundplayer_Tag_Mp3_CheckDifference;

procedure uSoundplayer_Tag_Mp3_Cover_Previous;
procedure uSoundplayer_Tag_Mp3_Cover_Next;
procedure uSoundplayer_Tag_Mp3_Cover_Select;
procedure uSoundplayer_Tag_Mp3_Cover_Select_Cancel;
procedure uSoundplayer_Tag_Mp3_Cover_SetFromComputer(vSelection: Integer);
procedure uSoundplayer_Tag_Mp3_Cover_Remove;

procedure uSoundplayer_Tag_Mp3_Lyrics_Add;
procedure uSoundplayer_Tag_Mp3_Lyrics_Load;
procedure uSoundplayer_Tag_Mp3_Lyrics_Add_Cancel;
procedure uSoundplayer_Tag_Mp3_Lyrics_Delete;

procedure uSoundplayer_Tag_Mp3_Save;

function Get_Cover_Image(vFullPath: String; out vDesk: String; out vImage: TBitmap): Boolean;

// Rating System
procedure SetRate;
procedure SaveRate;
function GetRate: Byte;
procedure Show_RateStars(vStar: Integer; vLeave: Boolean);
procedure Rate_SelectStars(vStarNum: Byte);
procedure Rate_RemoveAll;

var
  vCurrentSongPath: String;
  vCurrentSongNum: Integer;
  CurrentAPICIndex: Integer;
  APICIndex: Integer;
  vLyricsList: Tstringlist;
  vFoundAPIC_Frames: Integer;

implementation

uses
  uLoad_AllTypes,
  uSoundplayer_SetAll,
  uSoundplayer_AllTypes,
  uSoundplayer_Tag_Mp3_SetAll,
  uSoundplayer_Player;

procedure Get(vPath: String; vSongNum: Integer);
begin
  vCurrentSongPath := vPath;
  vCurrentSongNum := vSongNum;
  Set_Tag_ID3v1(vPath);
  Set_Tag_ID3v2(vPath);
  uSoundplayer_Tag_Mp3_CheckDifference;
end;

procedure Get_ID3v1(vPath: String);
begin
  addons.soundplayer.Player.Tag.mp3.ID3v1 := TID3v1Tag.Create;

  addons.soundplayer.Player.Tag.mp3.TagError := addons.soundplayer.Player.Tag.mp3.ID3v1.LoadFromFile(vPath);
  if addons.soundplayer.Player.Tag.mp3.TagError <> ID3V1LIBRARY_SUCCESS then
  begin
    // Show a messge error
    // Get major and minor version num of mp3
  end;

  addons.soundplayer.Player.Tag.mp3.ID3v1.Loaded := True;
end;

procedure Set_Tag_ID3v1(vPath: String);
begin
  Get_ID3v1(vPath);

  vSoundplayer.Tag.mp3.ID3v1.Title_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v1.Title;
  vSoundplayer.Tag.mp3.ID3v1.Artist_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v1.Artist;
  vSoundplayer.Tag.mp3.ID3v1.Album_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v1.Album;
  vSoundplayer.Tag.mp3.ID3v1.Year_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v1.Year;
  vSoundplayer.Tag.mp3.ID3v1.Genre_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v1.Genre;
  vSoundplayer.Tag.mp3.ID3v1.Track_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v1.Track.ToString;
  vSoundplayer.Tag.mp3.ID3v1.Comment_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v1.Comment;

  addons.soundplayer.Player.Tag.mp3.ID3v1.Free;
end;

procedure Get_ID3v2(vPath: String);
begin
  addons.soundplayer.Player.Tag.mp3.ID3v2 := TID3v2Tag.Create;

  addons.soundplayer.Player.Tag.mp3.TagError := addons.soundplayer.Player.Tag.mp3.ID3v2.LoadFromFile(vPath);
  if addons.soundplayer.Player.Tag.mp3.TagError <> ID3V2LIBRARY_SUCCESS then
  begin
    // Show an error message
    // Get major and minor version num of mp3
  end;
  addons.soundplayer.Player.Tag.mp3.ID3v2.RemoveUnsynchronisationOnAllFrames;
  addons.soundplayer.Player.Tag.mp3.ID3v2.ExtendedHeader := True;
  addons.soundplayer.Player.Tag.mp3.ID3v2.ExtendedHeader3.CRCPresent := True;

  addons.soundplayer.Player.Tag.mp3.Info.General.Filename :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.FileName;
  addons.soundplayer.Player.Tag.mp3.Info.General.Loaded := addons.soundplayer.Player.Tag.mp3.ID3v2.Loaded;
  addons.soundplayer.Player.Tag.mp3.Info.General.MajorVersion :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.MajorVersion;
  addons.soundplayer.Player.Tag.mp3.Info.General.MinorVersion :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.MinorVersion;
  addons.soundplayer.Player.Tag.mp3.Info.General.Size := addons.soundplayer.Player.Tag.mp3.ID3v2.Size;
  addons.soundplayer.Player.Tag.mp3.Info.General.FramesCount :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.FrameCount;
  addons.soundplayer.Player.Tag.mp3.Info.General.BitRate := addons.soundplayer.Player.Tag.mp3.ID3v2.BitRate;
  addons.soundplayer.Player.Tag.mp3.Info.General.CoverArtCount :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.CoverArtCount;
  addons.soundplayer.Player.Tag.mp3.Info.General.PlayTime := addons.soundplayer.Player.Tag.mp3.ID3v2.PlayTime;

  addons.soundplayer.Player.Tag.mp3.Info.MPEG.FrameSize :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.FrameSize;
  addons.soundplayer.Player.Tag.mp3.Info.MPEG.SampleRate :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.SampleRate;
  addons.soundplayer.Player.Tag.mp3.Info.MPEG.BitRate :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.BitRate;
  addons.soundplayer.Player.Tag.mp3.Info.MPEG.Padding :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.Padding;
  addons.soundplayer.Player.Tag.mp3.Info.MPEG.Copyrighted :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.Copyrighted;
  addons.soundplayer.Player.Tag.mp3.Info.MPEG.Quality :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.Quality;
  if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.ChannelMode = TMPEGChannelMode.tmpegcmUnknown then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.ChannelMode := 'Unknown Type'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.ChannelMode = TMPEGChannelMode.tmpegcmMono then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.ChannelMode := 'Mono'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.ChannelMode = TMPEGChannelMode.tmpegcmDualChannel
  then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.ChannelMode := 'Dual'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.ChannelMode = TMPEGChannelMode.tmpegcmJointStereo
  then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.ChannelMode := 'Joint'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.ChannelMode = TMPEGChannelMode.tmpegcmStereo then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.ChannelMode := 'Stereo';
  if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.Layer = TMPEGLayer.tmpeglUnknown then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.Layer := 'Unknown Type'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.Layer = TMPEGLayer.tmpegl1 then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.Layer := 'Mpeg Layer 1'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.Layer = TMPEGLayer.tmpegl2 then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.Layer := 'Mpeg Layer 2'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.Layer = TMPEGLayer.tmpegl3 then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.Layer := 'Mpeg Layer 3';
  if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.ModeExtension = TMPEGModeExtension.tmpegmeUnknown then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.ExtensionMode := 'Unknown Type'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.ModeExtension = TMPEGModeExtension.tmpegmeNone then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.ExtensionMode := 'None'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.ModeExtension = TMPEGModeExtension.tmpegmeIntensity
  then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.ExtensionMode := 'Intensity'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.ModeExtension = TMPEGModeExtension.tmpegmeMS then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.ExtensionMode := 'meMs'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.ModeExtension = TMPEGModeExtension.tmpegmeIntensityMS
  then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.ExtensionMode := 'IntensityMS';


// Implentamentions of Wav, Aiff, DS, DFF variables that not needed for mpeg
// But must keep it for future use
  {addons.soundplayer.Player.Tag.mp3.Info.WAV.FmtSize :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.WAVInfo.FmtSize;
  addons.soundplayer.Player.Tag.mp3.Info.WAV.FormatTag :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.WAVInfo.FormatTag;
  addons.soundplayer.Player.Tag.mp3.Info.WAV.Channels :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.WAVInfo.Channels;
  addons.soundplayer.Player.Tag.mp3.Info.WAV.AvgBytesPerSec :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.WAVInfo.AvgBytesPerSec;
  addons.soundplayer.Player.Tag.mp3.Info.WAV.BlockAlign :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.WAVInfo.BlockAlign;
  addons.soundplayer.Player.Tag.mp3.Info.WAV.BitsPerSamples :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.WAVInfo.BitsPerSample;
  addons.soundplayer.Player.Tag.mp3.Info.WAV.CbSize := addons.soundplayer.Player.Tag.mp3.ID3v2.WAVInfo.CbSize;
  addons.soundplayer.Player.Tag.mp3.Info.WAV.ChannelMask :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.WAVInfo.ChannelMask;

  addons.soundplayer.Player.Tag.mp3.Info.AIFF.Channels :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.AIFFInfo.Channels;
  addons.soundplayer.Player.Tag.mp3.Info.AIFF.SampleFrames :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.AIFFInfo.SampleFrames;
  addons.soundplayer.Player.Tag.mp3.Info.AIFF.SampleSize :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.AIFFInfo.SampleSize;
  addons.soundplayer.Player.Tag.mp3.Info.AIFF.SampleRate :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.AIFFInfo.SampleRate;
  addons.soundplayer.Player.Tag.mp3.Info.AIFF.CompressionID :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.AIFFInfo.CompressionID;
  addons.soundplayer.Player.Tag.mp3.Info.AIFF.Compression :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.AIFFInfo.Compression;

  addons.soundplayer.Player.Tag.mp3.Info.DS.FormatVersion :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.DSFInfo.FormatVersion;
  addons.soundplayer.Player.Tag.mp3.Info.DS.FormatID :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.DSFInfo.FormatID;
  addons.soundplayer.Player.Tag.mp3.Info.DS.SamplingFrequency :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.DSFInfo.SamplingFrequency;
  addons.soundplayer.Player.Tag.mp3.Info.DS.SampleCount :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.DSFInfo.SampleCount;
  if addons.soundplayer.Player.Tag.mp3.ID3v2.DSFInfo.ChannelType = TDSFChannelType.dsfctUnknown then
    addons.soundplayer.Player.Tag.mp3.Info.DS.ChannelType := 'Unknown Type'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.DSFInfo.ChannelType = TDSFChannelType.dsfctMono then
    addons.soundplayer.Player.Tag.mp3.Info.DS.ChannelType := 'Mono'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.DSFInfo.ChannelType = TDSFChannelType.dsfctStereo then
    addons.soundplayer.Player.Tag.mp3.Info.DS.ChannelType := 'Stereo'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.DSFInfo.ChannelType = TDSFChannelType.dsfct3Channels then
    addons.soundplayer.Player.Tag.mp3.Info.DS.ChannelType := 'Three Channels'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.DSFInfo.ChannelType = TDSFChannelType.dsfctQuad then
    addons.soundplayer.Player.Tag.mp3.Info.DS.ChannelType := 'Quad Sound System'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.DSFInfo.ChannelType = TDSFChannelType.dsfct4Channels then
    addons.soundplayer.Player.Tag.mp3.Info.DS.ChannelType := 'Four Channels'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.DSFInfo.ChannelType = TDSFChannelType.dsfct5Channels then
    addons.soundplayer.Player.Tag.mp3.Info.DS.ChannelType := 'Five Channels'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.DSFInfo.ChannelType = TDSFChannelType.dsfct51Channels then
    addons.soundplayer.Player.Tag.mp3.Info.DS.ChannelType := 'Five Channels Plus One';
  addons.soundplayer.Player.Tag.mp3.Info.DS.BlockSizePerChannel :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.DSFInfo.BlockSizePerChannel;

  addons.soundplayer.Player.Tag.mp3.Info.DFF.FormatVersion :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.DFFInfo.FormatVersion;
  addons.soundplayer.Player.Tag.mp3.Info.DFF.SampleRate :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.DFFInfo.SampleRate;
  addons.soundplayer.Player.Tag.mp3.Info.DFF.ChannelNumber :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.DFFInfo.ChannelNumber;
  addons.soundplayer.Player.Tag.mp3.Info.DFF.CompressionName :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.DFFInfo.CompressionName;
  addons.soundplayer.Player.Tag.mp3.Info.DFF.SampleCount :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.DFFInfo.SampleCount;
  addons.soundplayer.Player.Tag.mp3.Info.DFF.PlayTime :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.DFFInfo.PlayTime;
  addons.soundplayer.Player.Tag.mp3.Info.DFF.BitRate :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.DFFInfo.BitRate;
  addons.soundplayer.Player.Tag.mp3.Info.DFF.SoundDateLenght :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.DFFInfo.SoundDataLength;
  addons.soundplayer.Player.Tag.mp3.Info.DFF.DSTFramesCount :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.DFFInfo.DSTFramesCount;
  addons.soundplayer.Player.Tag.mp3.Info.DFF.DSTFramesRate :=
    addons.soundplayer.Player.Tag.mp3.ID3v2.DFFInfo.DSTFramesRate;
  addons.soundplayer.Player.Tag.mp3.Info.DFF.Ratio := addons.soundplayer.Player.Tag.mp3.ID3v2.DFFInfo.Ratio;}

  addons.soundplayer.Player.Tag.mp3.ID3v2.Loaded := True;
end;

procedure Set_Tag_ID3v2(vPath: String);
var
  vi: Integer;
  vDescription: String;
  vImage: TBitmap;
  vMemoChars: Integer;
begin
  Get_ID3v2(vPath);
  vSoundplayer.Tag.mp3.ID3v2.Title_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeText('TIT2');
  vSoundplayer.Tag.mp3.ID3v2.Artist_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeText('TPE1');
  vSoundplayer.Tag.mp3.ID3v2.Album_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeText('TALB');
  vSoundplayer.Tag.mp3.ID3v2.Year_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeText('TYER');
  vSoundplayer.Tag.mp3.ID3v2.Genre_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeText('TCON');
  vSoundplayer.Tag.mp3.ID3v2.Track_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeText('TRCK');
  vSoundplayer.Tag.mp3.ID3v2.Comment_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeComment
    ('TCOMM', addons.soundplayer.Player.Tag.mp3.Lyrics_LanguageID,
    addons.soundplayer.Player.Tag.mp3.Lyrics_Description);

  addons.soundplayer.Player.Tag.mp3.Lyrics := Tstringlist.Create;
  addons.soundplayer.Player.Tag.mp3.Lyrics.Add(addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeLyrics
    ('USLT', addons.soundplayer.Player.Tag.mp3.Lyrics_LanguageID,
    addons.soundplayer.Player.Tag.mp3.Lyrics_Description));

  vSoundplayer.Tag.mp3.ID3v2.Lyrics_Memo.Lines.Clear;

  vSoundplayer.Tag.mp3.ID3v2.Lyrics_Memo.Lines.AddStrings(addons.soundplayer.Player.Tag.mp3.Lyrics);
  vMemoChars := Length(StringReplace(StringReplace( vSoundplayer.Tag.mp3.ID3v2.Lyrics_Memo.Text , #10, '', [rfReplaceAll]), #13, '', [rfReplaceAll]));
  if vMemoChars> 1 then
    vSoundplayer.Tag.mp3.ID3v2.Lyrics_Remove.TextSettings.FontColor := TAlphaColorRec.Red
  else
    vSoundplayer.Tag.mp3.ID3v2.Lyrics_Remove.TextSettings.FontColor := TAlphaColorRec.Grey;

  vFoundAPIC_Frames := 0;
  for vi := addons.soundplayer.Player.Tag.mp3.ID3v2.FrameCount - 1 downto 0 do
  begin
    if IsSameFrameID(addons.soundplayer.Player.Tag.mp3.ID3v2.Frames[vi].ID, 'APIC') then
    begin
      inc(vFoundAPIC_Frames, 1);
    end;
  end;

  if vFoundAPIC_Frames = 0 then
  begin
    vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowRight_Grey.Enabled := True;
    vSoundplayer.Tag.mp3.ID3v2.Cover_Remove.TextSettings.FontColor:= TAlphaColorRec.Grey;
    vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowLeft_Grey.Enabled := True;
  end;

  APICIndex := 0;

  SetRate;
  addons.soundplayer.Player.Tag.mp3.ID3v2.Free;

  if Get_Cover_Image(vPath, vDescription, vImage) then
  begin
    vSoundplayer.Tag.mp3.ID3v2.Cover_Label.Text := vDescription;
    vSoundplayer.Tag.mp3.ID3v2.Cover.Bitmap := vImage;
  end;
end;

function Get_Cover_Image(vFullPath: String; out vDesk: String; out vImage: TBitmap): Boolean;
var
  PictureType: Integer;
  PictureStream: TStream;
  Success: Boolean;
  MIMEType: String;
  Description: String;
begin
  Get_ID3v2(vFullPath);
  Result := False;
  try
    PictureStream := TMemoryStream.Create;
    try
      if APICIndex = 0 then
      begin
        for APICIndex := 0 to addons.soundplayer.Player.Tag.mp3.ID3v2.FrameCount - 1 do
        begin
          if IsSameFrameID(addons.soundplayer.Player.Tag.mp3.ID3v2.Frames[APICIndex].ID, 'APIC') then
          begin
            Success := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeCoverPictureStream(APICIndex,
              PictureStream, MIMEType, Description, PictureType);
            if (PictureStream.Size <> 0) OR Success then
            begin
              Break;
            end;
          end;
        end
      end
      else
      begin
        Success := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeCoverPictureStream(APICIndex,
          PictureStream, MIMEType, Description, PictureType);
      end;

      if PictureType in [0, 3, 4, 6, 20] then
      begin
        case PictureType of
          0:
            vDesk := 'Other';
          3:
            vDesk := 'Front Cover';
          4:
            vDesk := 'Back Cover';
          6:
            vDesk := 'CD Cover';
          20:
            vDesk := 'Company Logo';
        end;
      end;
      vImage := TBitmap.Create;
      vImage.LoadFromStream(PictureStream);

      Result := True;
      CurrentAPICIndex := APICIndex;
    finally
      PictureStream.Free;
    end;
  except
    // *
  end;
  addons.soundplayer.Player.Tag.mp3.ID3v2.Free;
end;

procedure uSoundplayer_Tag_Mp3_Transfer(vInto: String);
begin
  if vInto = 'to_2' then
  begin
    vSoundplayer.Tag.mp3.ID3v2.Title_V.Text := vSoundplayer.Tag.mp3.ID3v1.Title_V.Text;
    vSoundplayer.Tag.mp3.ID3v2.Artist_V.Text := vSoundplayer.Tag.mp3.ID3v1.Artist_V.Text;
    vSoundplayer.Tag.mp3.ID3v2.Album_V.Text := vSoundplayer.Tag.mp3.ID3v1.Album_V.Text;
    vSoundplayer.Tag.mp3.ID3v2.Year_V.Text := vSoundplayer.Tag.mp3.ID3v1.Year_V.Text;
    vSoundplayer.Tag.mp3.ID3v2.Genre_V.Text := vSoundplayer.Tag.mp3.ID3v1.Genre_V.Text;
    vSoundplayer.Tag.mp3.ID3v2.Track_V.Text := vSoundplayer.Tag.mp3.ID3v1.Track_V.Text;
    vSoundplayer.Tag.mp3.ID3v2.Comment_V.Text := vSoundplayer.Tag.mp3.ID3v1.Comment_V.Text;
    vSoundplayer.Tag.mp3.TabControl.TabIndex := 1;
  end
  else if vInto = 'to_1' then
  begin
    vSoundplayer.Tag.mp3.ID3v1.Title_V.Text := vSoundplayer.Tag.mp3.ID3v2.Title_V.Text;
    vSoundplayer.Tag.mp3.ID3v1.Artist_V.Text := vSoundplayer.Tag.mp3.ID3v2.Artist_V.Text;
    vSoundplayer.Tag.mp3.ID3v1.Album_V.Text := vSoundplayer.Tag.mp3.ID3v2.Album_V.Text;
    vSoundplayer.Tag.mp3.ID3v1.Year_V.Text := vSoundplayer.Tag.mp3.ID3v2.Year_V.Text;
    vSoundplayer.Tag.mp3.ID3v1.Genre_V.Text := vSoundplayer.Tag.mp3.ID3v2.Genre_V.Text;
    vSoundplayer.Tag.mp3.ID3v1.Track_V.Text := vSoundplayer.Tag.mp3.ID3v2.Track_V.Text;
    vSoundplayer.Tag.mp3.ID3v1.Comment_V.Text := vSoundplayer.Tag.mp3.ID3v2.Comment_V.Text;
    vSoundplayer.Tag.mp3.TabControl.TabIndex := 0;
  end;

  vSoundplayer.Tag.mp3.ID3v1.Title_Differ.Visible := False;
  vSoundplayer.Tag.mp3.ID3v2.Title_Differ.Visible := False;
  vSoundplayer.Tag.mp3.ID3v1.Artist_Differ.Visible := False;
  vSoundplayer.Tag.mp3.ID3v2.Artist_Differ.Visible := False;
  vSoundplayer.Tag.mp3.ID3v1.Album_Differ.Visible := False;
  vSoundplayer.Tag.mp3.ID3v2.Album_Differ.Visible := False;
  vSoundplayer.Tag.mp3.ID3v1.Year_Differ.Visible := False;
  vSoundplayer.Tag.mp3.ID3v2.Year_Differ.Visible := False;
  vSoundplayer.Tag.mp3.ID3v1.Genre_Differ.Visible := False;
  vSoundplayer.Tag.mp3.ID3v2.Genre_Differ.Visible := False;
  vSoundplayer.Tag.mp3.ID3v1.Track_Differ.Visible := False;
  vSoundplayer.Tag.mp3.ID3v2.Track_Differ.Visible := False;
  vSoundplayer.Tag.mp3.ID3v1.Comment_Differ.Visible := False;
  vSoundplayer.Tag.mp3.ID3v2.Comment_Differ.Visible := False;
end;

procedure uSoundplayer_Tag_Mp3_CheckDifference;
begin
  if vSoundplayer.Tag.mp3.ID3v1.Title_V.Text <> vSoundplayer.Tag.mp3.ID3v2.Title_V.Text then
  begin
    vSoundplayer.Tag.mp3.ID3v1.Title_Differ.Visible := True;
    vSoundplayer.Tag.mp3.ID3v2.Title_Differ.Visible := True;
  end;
  if vSoundplayer.Tag.mp3.ID3v1.Artist_V.Text <> vSoundplayer.Tag.mp3.ID3v2.Artist_V.Text then
  begin
    vSoundplayer.Tag.mp3.ID3v1.Artist_Differ.Visible := True;
    vSoundplayer.Tag.mp3.ID3v2.Artist_Differ.Visible := True;
  end;
  if vSoundplayer.Tag.mp3.ID3v1.Album_V.Text <> vSoundplayer.Tag.mp3.ID3v2.Album_V.Text then
  begin
    vSoundplayer.Tag.mp3.ID3v1.Album_Differ.Visible := True;
    vSoundplayer.Tag.mp3.ID3v2.Album_Differ.Visible := True;
  end;
  if vSoundplayer.Tag.mp3.ID3v1.Year_V.Text <> vSoundplayer.Tag.mp3.ID3v2.Year_V.Text then
  begin
    vSoundplayer.Tag.mp3.ID3v1.Year_Differ.Visible := True;
    vSoundplayer.Tag.mp3.ID3v2.Year_Differ.Visible := True;
  end;
  if vSoundplayer.Tag.mp3.ID3v1.Genre_V.Text <> vSoundplayer.Tag.mp3.ID3v2.Genre_V.Text then
  begin
    vSoundplayer.Tag.mp3.ID3v1.Genre_Differ.Visible := True;
    vSoundplayer.Tag.mp3.ID3v2.Genre_Differ.Visible := True;
  end;
  if vSoundplayer.Tag.mp3.ID3v1.Track_V.Text <> vSoundplayer.Tag.mp3.ID3v2.Track_V.Text then
  begin
    vSoundplayer.Tag.mp3.ID3v1.Track_Differ.Visible := True;
    vSoundplayer.Tag.mp3.ID3v2.Track_Differ.Visible := True;
  end;
  if vSoundplayer.Tag.mp3.ID3v1.Comment_V.Text <> vSoundplayer.Tag.mp3.ID3v2.Comment_V.Text then
  begin
    vSoundplayer.Tag.mp3.ID3v1.Comment_Differ.Visible := True;
    vSoundplayer.Tag.mp3.ID3v2.Comment_Differ.Visible := True;
  end;
  if (vSoundplayer.Tag.mp3.ID3v1.Title_V.Text = vSoundplayer.Tag.mp3.ID3v2.Title_V.Text) and
    (vSoundplayer.Tag.mp3.ID3v1.Artist_V.Text = vSoundplayer.Tag.mp3.ID3v2.Artist_V.Text) and
    (vSoundplayer.Tag.mp3.ID3v1.Album_V.Text = vSoundplayer.Tag.mp3.ID3v2.Album_V.Text) and
    (vSoundplayer.Tag.mp3.ID3v1.Year_V.Text = vSoundplayer.Tag.mp3.ID3v2.Year_V.Text) and
    (vSoundplayer.Tag.mp3.ID3v1.Genre_V.Text = vSoundplayer.Tag.mp3.ID3v2.Genre_V.Text) and
    (vSoundplayer.Tag.mp3.ID3v1.Track_V.Text = vSoundplayer.Tag.mp3.ID3v2.Track_V.Text) and
    (vSoundplayer.Tag.mp3.ID3v1.Comment_V.Text = vSoundplayer.Tag.mp3.ID3v2.Comment_V.Text) then
  begin
    vSoundplayer.Tag.mp3.ID3v1.Transfer.Enabled := False;
    vSoundplayer.Tag.mp3.ID3v2.Transfer.Enabled := False;
  end
  else
  begin
    vSoundplayer.Tag.mp3.ID3v1.Transfer.Enabled := True;
    vSoundplayer.Tag.mp3.ID3v2.Transfer.Enabled := True;
  end;
end;

///
procedure uSoundplayer_Tag_Mp3_Cover_Previous;
var
  i: Integer;
  vDescription: String;
  vImage: TBitmap;
begin
  for i := 0 to addons.soundplayer.Player.Tag.mp3.ID3v2.FrameCount - 1 do
  begin
    if IsSameFrameID(addons.soundplayer.Player.Tag.mp3.ID3v2.Frames[i].ID, 'APIC') then
    begin
      if i < CurrentAPICIndex then
      begin
        APICIndex := i;
        if Get_Cover_Image(vCurrentSongPath, vDescription, vImage) then
        begin
          vSoundplayer.Tag.mp3.ID3v2.Cover_Label.Text := vDescription;
          vSoundplayer.Tag.mp3.ID3v2.Cover.Bitmap := vImage;
        end;
        Break;
      end;
    end;
  end;

end;

procedure uSoundplayer_Tag_Mp3_Cover_Next;
var
  i: Integer;
  vDescription: String;
  vImage: TBitmap;
begin
  for i := 0 to addons.soundplayer.Player.Tag.mp3.ID3v2.FrameCount - 1 do
  begin
    if IsSameFrameID(addons.soundplayer.Player.Tag.mp3.ID3v2.Frames[i].ID, 'APIC') then
    begin
      if i > CurrentAPICIndex then
      begin
        APICIndex := i;
        if Get_Cover_Image(vCurrentSongPath, vDescription, vImage) then
        begin
          vSoundplayer.Tag.mp3.ID3v2.Cover_Label.Text := vDescription;
          vSoundplayer.Tag.mp3.ID3v2.Cover.Bitmap := vImage;
        end;
        Break;
      end;
    end;
  end;
end;

procedure uSoundplayer_Tag_Mp3_Cover_Select;
begin
  if vSoundplayer.scene.OpenDialog.Filename <> '' then
  begin
    extrafe.prog.State := 'addon_soundplayer_tag_mp3_cover_select';
    uSoundplayer_TagSet_Mp3_SelectCover;
  end;
end;

procedure uSoundplayer_Tag_Mp3_Cover_Select_Cancel;
begin
  extrafe.prog.State := 'addon_soundplayer_tag_mp3';
  vSoundplayer.Tag.mp3.Back_Blur.Enabled := False;
  vSoundplayer.Tag.mp3.TabControl.Enabled := True;
  FreeAndNil(vSoundplayer.Tag.mp3.Cover_Select.Panel);
end;

procedure uSoundplayer_Tag_Mp3_Cover_SetFromComputer(vSelection: Integer);
var
  Fext: String;
  MIMEType: String;
  FrameIndex: Integer;
  Description: String;
  PictureType: Integer;
  Success: Boolean;
  vi: Integer;
  PictureStream: TStream;
  vFoundAPIC_PictureType: Boolean;
begin
  vFoundAPIC_PictureType := False;
  case vSelection of
    0:
      begin
        vSelection := 3;
        Description := 'Front Cover';
      end;
    1:
      begin
        vSelection := 4;
        Description := 'Back Cover';
      end;
    2:
      begin
        vSelection := 6;
        Description := 'CD Cover';
      end;
    3:
      begin
        vSelection := 20;
        Description := 'Company Logo';
      end;
    4:
      begin
        vSelection := 0;
        Description := 'Other';
      end;
  end;

  PictureStream := TMemoryStream.Create;

  for vi := addons.soundplayer.Player.Tag.mp3.ID3v2.FrameCount - 1 downto 0 do
  begin
    if IsSameFrameID(addons.soundplayer.Player.Tag.mp3.ID3v2.Frames[vi].ID, 'APIC') then
    begin
      Success := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeCoverPictureStream(vi, PictureStream,
        MIMEType, Description, PictureType);
      if vSelection = PictureType then
      begin
        addons.soundplayer.Player.Tag.mp3.ID3v2.DeleteFrame(vi);
      end;
    end;
  end;

  PictureStream.Free;

  Fext := UpperCase(ExtractFileExt(vSoundplayer.scene.OpenDialog.Filename));
  if (Fext = '.JPG') or (Fext = '.JPEG') then
  begin
    MIMEType := 'image/jpeg';
  end;
  if (Fext = '.PNG') then
  begin
    MIMEType := 'image/png';
  end;
  if (Fext = '.BMP') then
  begin
    MIMEType := 'image/bmp';
  end;
  if (Fext = '.GIF') then
  begin
    MIMEType := 'image/gif';
  end;

  PictureType := vSelection;

  FrameIndex := addons.soundplayer.Player.Tag.mp3.ID3v2.AddFrame('APIC');

  addons.soundplayer.Player.Tag.mp3.ID3v2.SetUnicodeCoverPictureFromFile(FrameIndex, Description,
    vSoundplayer.scene.OpenDialog.Filename, MIMEType, PictureType);
  vSoundplayer.Tag.mp3.ID3v2.Cover.Bitmap.LoadFromFile(vSoundplayer.scene.OpenDialog.Filename);
  vSoundplayer.Info.Cover.Bitmap.LoadFromFile(vSoundplayer.scene.OpenDialog.Filename);

  vSoundplayer.Tag.mp3.ID3v2.Cover_Label.Text := Description;
  inc(vFoundAPIC_Frames, 1);

  vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowLeft_Grey.Enabled := False;
  vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowRight_Grey.Enabled := False;
  vSoundplayer.Tag.mp3.ID3v2.Cover_Remove.TextSettings.FontColor := TAlphaColorRec.Red;

  uSoundplayer_Tag_Mp3_Cover_Select_Cancel;
end;

procedure uSoundplayer_Tag_Mp3_Cover_Remove;
var
  vDescription: String;
  vImage: TBitmap;
begin
  vSoundplayer.Tag.mp3.ID3v2.Cover.Bitmap := nil;
  addons.soundplayer.Player.Tag.mp3.ID3v2.DeleteFrame(CurrentAPICIndex);
  dec(vFoundAPIC_Frames, 1);
  if vFoundAPIC_Frames = 0 then
  begin
    vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowLeft_Grey.Enabled := True;
    vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowRight_Grey.Enabled := True;
    vSoundplayer.Tag.mp3.ID3v2.Cover_Remove_Glow.Enabled := False;
    vSoundplayer.Tag.mp3.ID3v2.Cover_Remove.TextSettings.FontColor := TAlphaColorRec.Grey;
    vSoundplayer.Tag.mp3.ID3v2.Cover_Label.Text := '';
  end
  else
  begin
    APICIndex := 0;
    if Get_Cover_Image(vCurrentSongPath, vDescription, vImage) then
    begin
      vSoundplayer.Tag.mp3.ID3v2.Cover_Label.Text := vDescription;
      vSoundplayer.Tag.mp3.ID3v2.Cover.Bitmap := vImage;
    end;
  end;
end;

///
procedure uSoundplayer_Tag_Mp3_Lyrics_Add;
var
  vTextFile: TextFile;
  vText: String;
begin
  if vSoundplayer.scene.OpenDialog.Filename <> '' then
  begin
    vLyricsList := Tstringlist.Create;

    AssignFile(vTextFile, vSoundplayer.scene.OpenDialog.Filename);
    Reset(vTextFile);
    while not eof(vTextFile) do
    begin
      Readln(vTextFile, vText);
      vLyricsList.Add(vText);
    end;
    CloseFile(vTextFile);

    if vSoundplayer.Tag.mp3.ID3v2.Lyrics_Memo.Lines.GetText = '' then
    begin
      vSoundplayer.Tag.mp3.ID3v2.Lyrics_Memo.Lines.Clear;
      vSoundplayer.Tag.mp3.ID3v2.Lyrics_Memo.Lines.AddStrings(vLyricsList);
    end
    else
    begin
      extrafe.prog.State := 'addon_soundplayer_tag_mp3_Lyrics_Add';
      uSoundplayer_TagSet_Mp3_ShowLyrics_AddDialog;
    end;
  end;
end;

procedure uSoundplayer_Tag_Mp3_Lyrics_Load;
begin
  if vSoundplayer.Tag.mp3.Lyrics_Add.Radio_Above.IsChecked then
  begin
    vSoundplayer.Tag.mp3.ID3v2.Lyrics_Memo.Lines.AddStrings(vLyricsList);
  end
  else if vSoundplayer.Tag.mp3.Lyrics_Add.Radio_Clear.IsChecked then
  begin
    vSoundplayer.Tag.mp3.ID3v2.Lyrics_Memo.Lines.Clear;
    vSoundplayer.Tag.mp3.ID3v2.Lyrics_Memo.Lines.AddStrings(vLyricsList);
  end;
  uSoundplayer_Tag_Mp3_Lyrics_Add_Cancel;
end;

procedure uSoundplayer_Tag_Mp3_Lyrics_Add_Cancel;
begin
  extrafe.prog.State := 'addon_soundplayer_tag_mp3';
  vSoundplayer.Tag.mp3.Back_Blur.Enabled := False;
  vSoundplayer.Tag.mp3.TabControl.Enabled := True;
  FreeAndNil(vSoundplayer.Tag.mp3.Lyrics_Add.Panel);
end;

procedure uSoundplayer_Tag_Mp3_Lyrics_Delete;
begin
  vSoundplayer.Tag.mp3.ID3v2.Lyrics_Memo.Lines.Clear;
end;

///
procedure uSoundplayer_Tag_Mp3_Save;
var
  vGetSongPosition: Integer;
  vi: Integer;
begin
  if addons.soundplayer.Playlist.List.Songs.Strings[addons.soundplayer.Player.Playing_Now] = vCurrentSongPath
  then
  begin
    vGetSongPosition := BASS_ChannelGetPosition(sound.str_music[1], BASS_POS_BYTE);
    BASS_ChannelStop(sound.str_music[1]);
    BASS_StreamFree(sound.str_music[1]);
  end;

  Get_ID3v1(vCurrentSongPath);

  addons.soundplayer.Player.Tag.mp3.ID3v1.Title := vSoundplayer.Tag.mp3.ID3v1.Title_V.Text;
  addons.soundplayer.Player.Tag.mp3.ID3v1.Artist := vSoundplayer.Tag.mp3.ID3v1.Artist_V.Text;
  addons.soundplayer.Player.Tag.mp3.ID3v1.Album := vSoundplayer.Tag.mp3.ID3v1.Album_V.Text;
  addons.soundplayer.Player.Tag.mp3.ID3v1.Year := vSoundplayer.Tag.mp3.ID3v1.Year_V.Text;
  addons.soundplayer.Player.Tag.mp3.ID3v1.Genre := vSoundplayer.Tag.mp3.ID3v1.Genre_V.Text;
  addons.soundplayer.Player.Tag.mp3.ID3v1.Track := vSoundplayer.Tag.mp3.ID3v1.Track_V.Text.ToInteger;
  addons.soundplayer.Player.Tag.mp3.ID3v1.Comment := vSoundplayer.Tag.mp3.ID3v1.Comment_V.Text;

  addons.soundplayer.Player.Tag.mp3.ID3v1.SaveToFile(vCurrentSongPath);

  addons.soundplayer.Player.Tag.mp3.ID3v1.Free;

  Get_ID3v2(vCurrentSongPath);

  addons.soundplayer.Player.Tag.mp3.ID3v2.SetUnicodeText('TIT2', vSoundplayer.Tag.mp3.ID3v2.Title_V.Text);
  addons.soundplayer.Player.Tag.mp3.ID3v2.SetUnicodeText('TPE1', vSoundplayer.Tag.mp3.ID3v2.Artist_V.Text);
  addons.soundplayer.Player.Tag.mp3.ID3v2.SetUnicodeText('TALB', vSoundplayer.Tag.mp3.ID3v2.Album_V.Text);
  addons.soundplayer.Player.Tag.mp3.ID3v2.SetUnicodeText('TYER', vSoundplayer.Tag.mp3.ID3v2.Year_V.Text);
  addons.soundplayer.Player.Tag.mp3.ID3v2.SetUnicodeText('TCON', vSoundplayer.Tag.mp3.ID3v2.Genre_V.Text);
  addons.soundplayer.Player.Tag.mp3.ID3v2.SetUnicodeText('TRCK', vSoundplayer.Tag.mp3.ID3v2.Track_V.Text);
  addons.soundplayer.Player.Tag.mp3.ID3v2.SetUnicodeComment('TCOMM',
    vSoundplayer.Tag.mp3.ID3v2.Comment_V.Text, addons.soundplayer.Player.Tag.mp3.Lyrics_LanguageID, '');

  addons.soundplayer.Player.Tag.mp3.ID3v2.SetUnicodeLyrics('USLT',
    vSoundplayer.Tag.mp3.ID3v2.Lyrics_Memo.Text, addons.soundplayer.Player.Tag.mp3.Lyrics_LanguageID,
    addons.soundplayer.Player.Tag.mp3.Lyrics_Description);

  SaveRate;

  addons.soundplayer.Player.Tag.mp3.TagError := addons.soundplayer.Player.Tag.mp3.ID3v2.SaveToFile
    (vCurrentSongPath);

  addons.soundplayer.Player.Tag.mp3.ID3v2.Unsynchronised := False;

  if addons.soundplayer.Player.Tag.mp3.TagError <> ID3V2LIBRARY_SUCCESS then
  begin
    Showmessage('Error saving ID3v2 tag, error code: ' + IntToStr(addons.soundplayer.Player.Tag.mp3.TagError)
      + #13#10 + ID3v2TagErrorCode2String(addons.soundplayer.Player.Tag.mp3.TagError));
  end;

  // Save it to songs info
  // Title
  if vSoundplayer.Tag.mp3.ID3v2.Title_V.Text = '' then
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Title :=
      vSoundplayer.Tag.mp3.ID3v1.Title_V.Text
  else
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Title :=
      vSoundplayer.Tag.mp3.ID3v2.Title_V.Text;
  // Artist
  if vSoundplayer.Tag.mp3.ID3v2.Artist_V.Text = '' then
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Artist :=
      vSoundplayer.Tag.mp3.ID3v1.Artist_V.Text
  else
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Artist :=
      vSoundplayer.Tag.mp3.ID3v2.Artist_V.Text;
  // Album
  if vSoundplayer.Tag.mp3.ID3v2.Album_V.Text = '' then
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Album :=
      vSoundplayer.Tag.mp3.ID3v1.Album_V.Text
  else
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Album :=
      vSoundplayer.Tag.mp3.ID3v2.Album_V.Text;
  // Year
  if vSoundplayer.Tag.mp3.ID3v2.Year_V.Text = '' then
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Year := vSoundplayer.Tag.mp3.ID3v1.Year_V.Text
  else
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Year :=
      vSoundplayer.Tag.mp3.ID3v2.Year_V.Text;
  // Genre
  if vSoundplayer.Tag.mp3.ID3v2.Genre_V.Text = '' then
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Genre :=
      vSoundplayer.Tag.mp3.ID3v1.Genre_V.Text
  else
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Genre :=
      vSoundplayer.Tag.mp3.ID3v2.Genre_V.Text;
  // Track
  if vSoundplayer.Tag.mp3.ID3v2.Track_V.Text = '' then
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Track :=
      vSoundplayer.Tag.mp3.ID3v1.Track_V.Text
  else
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Track :=
      vSoundplayer.Tag.mp3.ID3v2.Track_V.Text;
  // Comments
  if vSoundplayer.Tag.mp3.ID3v2.Comment_V.Text = '' then
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Comment :=
      vSoundplayer.Tag.mp3.ID3v1.Comment_V.Text
  else
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Comment :=
      vSoundplayer.Tag.mp3.ID3v2.Comment_V.Text;
  // Rating
  addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Rate :=
    addons.soundplayer.Player.Tag.mp3.Rating.ToString;
  if addons.soundplayer.Playlist.List.Songs.Strings[addons.soundplayer.Player.Playing_Now] = vCurrentSongPath
  then
  begin
    if addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Rate > IntToStr(0) then
    begin
      for vi := 0 to 4 do
        vSoundplayer.Player.Rate[vi].Visible := True;
      for vi := 0 to 4 do
        vSoundplayer.Player.Rate_Gray[vi].Enabled := True;
      for vi := 0 to addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Rate.ToInteger - 1 do
        vSoundplayer.Player.Rate_Gray[vi].Enabled := False;
      vSoundplayer.Player.Rate_No.Visible := False;
    end
    else
    begin
      for vi := 0 to 4 do
        vSoundplayer.Player.Rate[vi].Visible := False;
      vSoundplayer.Player.Rate_No.Visible := True;
    end;
  end;
  addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Rate := GetRate.ToString;
  addons.soundplayer.Player.Tag.mp3.ID3v2.Free;

  if addons.soundplayer.Playlist.List.Songs.Strings[addons.soundplayer.Player.Playing_Now] = vCurrentSongPath
  then
  begin
    sound.str_music[1] := BASS_StreamCreateFile(False,
      PChar(addons.soundplayer.Playlist.List.Songs.Strings[addons.soundplayer.Player.Playing_Now]), 0, 0,
      BASS_SAMPLE_FLOAT {$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
    if addons.soundplayer.Player.Play then
    begin
      BASS_ChannelPlay(sound.str_music[1], True);
      BASS_ChannelSetPosition(sound.str_music[1], vGetSongPosition, BASS_POS_BYTE);
      BASS_ChannelSetAttribute(sound.str_music[1], BASS_ATTRIB_VOL, addons.soundplayer.Volume.Vol / 100);
    end;
  end;

  uSoundplayer_TagSet_Mp3_Free;
end;

// rating system
procedure Show_RateStars(vStar: Integer; vLeave: Boolean);
var
  vi: Integer;
begin
  for vi := 0 to 4 do
  begin
    vSoundplayer.Tag.mp3.ID3v2.Rate[vi].Visible := True;
    vSoundplayer.Tag.mp3.ID3v2.Rate_Dot[vi].Visible := True;
  end;

  if vLeave = False then
  begin
    for vi := 4 downto vStar + 1 do
      vSoundplayer.Tag.mp3.ID3v2.Rate[vi].Visible := False;
    for vi := 0 to vStar do
    begin
      vSoundplayer.Tag.mp3.ID3v2.Rate_Dot[vi].Visible := False;
      vSoundplayer.Tag.mp3.ID3v2.Rate_Glow[vi].Enabled := True;
    end;
  end
  else
  begin
    if vStar = -1 then
    begin
      for vi := 0 to 4 do
      begin
        vSoundplayer.Tag.mp3.ID3v2.Rate[vi].Visible := False;
        vSoundplayer.Tag.mp3.ID3v2.Rate_Dot[vi].Visible := True;
      end;
    end
    else
    begin
      for vi := 0 to 4 do
        vSoundplayer.Tag.mp3.ID3v2.Rate_Glow[vi].Enabled := False;
      for vi := 4 downto addons.soundplayer.Player.Tag.mp3.Rating do
        vSoundplayer.Tag.mp3.ID3v2.Rate[vi].Visible := False;
      for vi := 0 to addons.soundplayer.Player.Tag.mp3.Rating - 1 do
        vSoundplayer.Tag.mp3.ID3v2.Rate_Dot[vi].Visible := False;
    end;
  end;
end;

procedure Rate_SelectStars(vStarNum: Byte);
var
  vi: Integer;
begin
  for vi := 0 to 4 do
    vSoundplayer.Tag.mp3.ID3v2.Rate_Glow[vi].Enabled := False;
  for vi := 4 downto vStarNum + 1 do
    vSoundplayer.Tag.mp3.ID3v2.Rate[vi].Visible := False;
  for vi := 0 to vStarNum do
    vSoundplayer.Tag.mp3.ID3v2.Rate_Dot[vi].Visible := False;

  addons.soundplayer.Player.Tag.mp3.Rating := vStarNum + 1;
end;

procedure Rate_RemoveAll;
var
  vi: Integer;
begin
  for vi := 0 to 4 do
  begin
    vSoundplayer.Tag.mp3.ID3v2.Rate[vi].Visible := False;
    vSoundplayer.Tag.mp3.ID3v2.Rate_Dot[vi].Visible := True;
  end;
  addons.soundplayer.Player.Tag.mp3.Rating := 0;
end;

procedure SaveRate;
var
  vIndex: Integer;
  vFound: Boolean;
  vRating: Integer;
begin
  vFound := False;
  if addons.soundplayer.Player.Tag.mp3.Rating_Before_Save <> addons.soundplayer.Player.Tag.mp3.Rating then
  begin
    if addons.soundplayer.Player.Tag.mp3.Rating > 0 then
      vRating := (addons.soundplayer.Player.Tag.mp3.Rating) * 51
    else
      vRating := 0;
    for vIndex := 0 to addons.soundplayer.Player.Tag.mp3.ID3v2.FrameCount - 1 do
    begin
      if IsSameFrameID(addons.soundplayer.Player.Tag.mp3.ID3v2.Frames[vIndex].ID, 'POPM') then
      begin
        addons.soundplayer.Player.Tag.mp3.ID3v2.SetPopularimeter(vIndex, 'spoooky11@hotmail.gr', vRating, 0);
        vFound := True;
      end;
    end;
    if vFound = False then
    begin
      vIndex := addons.soundplayer.Player.Tag.mp3.ID3v2.AddFrame('POPM');
      addons.soundplayer.Player.Tag.mp3.ID3v2.SetPopularimeter(vIndex, 'spoooky11@hotmail.gr', vRating, 0);
    end;
  end;
end;

procedure SetRate;
var
  vi: Integer;
  vRating: Byte;
begin
  for vi := 0 to 4 do
  begin
    vSoundplayer.Tag.mp3.ID3v2.Rate[vi].Visible := True;
    vSoundplayer.Tag.mp3.ID3v2.Rate_Dot[vi].Visible := True;
  end;

  vRating := GetRate;

  if vRating <> 0 then
  begin
    vRating := (vRating div 51);
    for vi := 4 downto vRating do
      vSoundplayer.Tag.mp3.ID3v2.Rate[vi].Visible := False;
    for vi := 0 to vRating - 1 do
      vSoundplayer.Tag.mp3.ID3v2.Rate_Dot[vi].Visible := False;
    addons.soundplayer.Player.Tag.mp3.Rating := vRating;
    addons.soundplayer.Player.Tag.mp3.Rating_Before_Save := vRating;
  end
  else
  begin
    for vi := 0 to 4 do
      vSoundplayer.Tag.mp3.ID3v2.Rate[vi].Visible := False;
    addons.soundplayer.Player.Tag.mp3.Rating := -1;
    addons.soundplayer.Player.Tag.mp3.Rating_Before_Save := -1;
  end;
end;

function GetRate: Byte;
var
  vEmail: String;
  vRating: Byte;
  vCounter: Cardinal;
  vi: Integer;
  vFound: Boolean;
begin
  vFound := False;
  for vi := 0 to addons.soundplayer.Player.Tag.mp3.ID3v2.FrameCount - 1 do
  begin
    if IsSameFrameID(addons.soundplayer.Player.Tag.mp3.ID3v2.Frames[vi].ID, 'POPM') then
    begin
      vFound := True;
      if addons.soundplayer.Player.Tag.mp3.ID3v2.GetPopularimeter(vi, vEmail, vRating, vCounter) = True then
        Result := vRating;
    end
  end;
  if vFound = False then
    Result := 0;
end;

end.
