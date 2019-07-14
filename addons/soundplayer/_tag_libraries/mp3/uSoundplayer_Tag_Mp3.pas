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

procedure Get(vPath: String; vSongNum: Integer);
procedure Get_ID3v1(vPath: String);
procedure Set_Tag_ID3v1(vPath: String);
procedure Get_ID3v2(vPath: String);
procedure Set_Tag_ID3v2(vPath: String);
procedure Save;

// Check Difference between ID3v1 to ID3v2
procedure Transfer(vInto: String);

// Covers ID3v2
procedure Cover_SetArrows;
procedure Cover_Previous;
procedure Cover_Next;
procedure Cover_Select;
procedure Cover_Select_Cancel;
procedure Cover_SetFromComputer(vSelection: Integer);
procedure Cover_Remove;
function Cover_Get_Image(vFullPath: String; out vDesk: String; out vImage: TBitmap): Boolean;

// Lyrics ID3v2
procedure Lyrics_Add;
procedure Lyrics_Add_Cancel;
procedure Lyrics_Load;
procedure Lyrics_Delete;
procedure Lyrics_Get_Add;
procedure Lyrics_Get_Cancel;


// Rating System
procedure Rating_Set;
procedure Rating_Save;
procedure Rating_Stars(vStar: Integer; vLeave: Boolean);
procedure Rating_Select_Stars(vStarNum: Byte);
procedure Rating_RemoveAll_Stars;
function Rating_Get: Byte;

var
  vCurrentSongPath: String;
  vCurrentSongNum: Integer;
  CurrentAPICIndex: Integer;
  APICIndex: Integer;
  vLyricsList: Tstringlist;

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
end;

procedure Get_ID3v1(vPath: String);
begin
  addons.soundplayer.Player.Tag.mp3.ID3v1 := TID3v1Tag.Create;

  addons.soundplayer.Player.Tag.mp3.TagError := addons.soundplayer.Player.Tag.mp3.ID3v1.LoadFromFile(vPath);
  if addons.soundplayer.Player.Tag.mp3.TagError <> ID3V1LIBRARY_SUCCESS then
  begin
    // Show a message error
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

  addons.soundplayer.Player.Tag.mp3.Info.General.Filename := addons.soundplayer.Player.Tag.mp3.ID3v2.Filename;
  addons.soundplayer.Player.Tag.mp3.Info.General.Loaded := addons.soundplayer.Player.Tag.mp3.ID3v2.Loaded;
  addons.soundplayer.Player.Tag.mp3.Info.General.MajorVersion := addons.soundplayer.Player.Tag.mp3.ID3v2.MajorVersion;
  addons.soundplayer.Player.Tag.mp3.Info.General.MinorVersion := addons.soundplayer.Player.Tag.mp3.ID3v2.MinorVersion;
  addons.soundplayer.Player.Tag.mp3.Info.General.Size := addons.soundplayer.Player.Tag.mp3.ID3v2.Size;
  addons.soundplayer.Player.Tag.mp3.Info.General.FramesCount := addons.soundplayer.Player.Tag.mp3.ID3v2.FrameCount;
  addons.soundplayer.Player.Tag.mp3.Info.General.BitRate := addons.soundplayer.Player.Tag.mp3.ID3v2.BitRate;
  addons.soundplayer.Player.Tag.mp3.Info.General.CoverArtCount := addons.soundplayer.Player.Tag.mp3.ID3v2.CoverArtCount;
  addons.soundplayer.Player.Tag.mp3.Info.General.PlayTime := addons.soundplayer.Player.Tag.mp3.ID3v2.PlayTime;

  addons.soundplayer.Player.Tag.mp3.Info.MPEG.FrameSize := addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.FrameSize;
  addons.soundplayer.Player.Tag.mp3.Info.MPEG.SampleRate := addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.SampleRate;
  addons.soundplayer.Player.Tag.mp3.Info.MPEG.BitRate := addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.BitRate;
  addons.soundplayer.Player.Tag.mp3.Info.MPEG.Padding := addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.Padding;
  addons.soundplayer.Player.Tag.mp3.Info.MPEG.Copyrighted := addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.Copyrighted;
  addons.soundplayer.Player.Tag.mp3.Info.MPEG.Quality := addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.Quality;
  if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.ChannelMode = TMPEGChannelMode.tmpegcmUnknown then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.ChannelMode := 'Unknown Type'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.ChannelMode = TMPEGChannelMode.tmpegcmMono then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.ChannelMode := 'Mono'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.ChannelMode = TMPEGChannelMode.tmpegcmDualChannel then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.ChannelMode := 'Dual'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.ChannelMode = TMPEGChannelMode.tmpegcmJointStereo then
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
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.ModeExtension = TMPEGModeExtension.tmpegmeIntensity then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.ExtensionMode := 'Intensity'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.ModeExtension = TMPEGModeExtension.tmpegmeMS then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.ExtensionMode := 'meMs'
  else if addons.soundplayer.Player.Tag.mp3.ID3v2.MPEGInfo.ModeExtension = TMPEGModeExtension.tmpegmeIntensityMS then
    addons.soundplayer.Player.Tag.mp3.Info.MPEG.ExtensionMode := 'IntensityMS';


  // Implentamentions of Wav, Aiff, DS, DFF variables that not needed for mpeg
  // But must keep it for future use
  { addons.soundplayer.Player.Tag.mp3.Info.WAV.FmtSize :=
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
    addons.soundplayer.Player.Tag.mp3.Info.DFF.Ratio := addons.soundplayer.Player.Tag.mp3.ID3v2.DFFInfo.Ratio; }

  addons.soundplayer.Player.Tag.mp3.ID3v2.Loaded := True;
end;

procedure Set_Tag_ID3v2(vPath: String);
var
  vDescription: String;
  vImage: TBitmap;
  vTextFile: TextFile;
  vString: String;

begin
  Get_ID3v2(vPath);
  vSoundplayer.Tag.mp3.ID3v2.Title_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeText('TIT2');
  vSoundplayer.Tag.mp3.ID3v2.Artist_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeText('TPE1');
  vSoundplayer.Tag.mp3.ID3v2.Album_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeText('TALB');
  vSoundplayer.Tag.mp3.ID3v2.Year_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeText('TYER');
  vSoundplayer.Tag.mp3.ID3v2.Genre_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeText('TCON');
  vSoundplayer.Tag.mp3.ID3v2.Track_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeText('TRCK');
  vSoundplayer.Tag.mp3.ID3v2.Comment_V.Text := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeComment('TCOMM',
    addons.soundplayer.Player.Tag.mp3.Lyrics_LanguageID, addons.soundplayer.Player.Tag.mp3.Lyrics_Description);

  addons.soundplayer.Player.Tag.mp3.Lyrics := Tstringlist.Create;
  addons.soundplayer.Player.Tag.mp3.Lyrics.Add(addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeLyrics('USLT',
    addons.soundplayer.Player.Tag.mp3.Lyrics_LanguageID, addons.soundplayer.Player.Tag.mp3.Lyrics_Description));
  addons.soundplayer.Player.Tag.mp3.Lyrics.SaveToFile(addons.soundplayer.Path.Files + 'templyric.txt');
  addons.soundplayer.Player.Tag.mp3.Lyrics.Clear;

  AssignFile(vTextFile, addons.soundplayer.Path.Files + 'templyric.txt');
  Reset(vTextFile);
  while Not EOF(vTextFile) do
  begin
    Readln(vTextFile, vString);
    addons.soundplayer.Player.Tag.mp3.Lyrics.Add(vString);
  end;
  CloseFile(vTextFile);
  DeleteFile(addons.soundplayer.Path.Files+ 'templyric.txt');

  vSoundplayer.Tag.mp3.ID3v2.Lyrics_Memo.Lines.Clear;
  vSoundplayer.Tag.mp3.ID3v2.Lyrics_Memo.Lines.AddStrings(addons.soundplayer.Player.Tag.mp3.Lyrics);

  if vSoundplayer.Tag.mp3.ID3v2.Lyrics_Memo.Lines.Count - 1 > 1 then
    vSoundplayer.Tag.mp3.ID3v2.Lyrics_Remove.TextSettings.FontColor := TAlphaColorRec.Red
  else
    vSoundplayer.Tag.mp3.ID3v2.Lyrics_Remove.TextSettings.FontColor := TAlphaColorRec.Grey;

  //  Count lines in one line with #10#13 seperators
  // vMemoChars: Integer;
  // vMemoChars := Length(StringReplace(StringReplace(vSoundplayer.Tag.mp3.ID3v2.Lyrics_Memo.Text, #10, '', [rfReplaceAll]), #13, '', [rfReplaceAll]));

  if addons.soundplayer.Player.Tag.mp3.Info.General.CoverArtCount = 0 then
  begin
    vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowRight.TextSettings.FontColor := TAlphaColorRec.Grey;
    vSoundplayer.Tag.mp3.ID3v2.Cover_Remove.TextSettings.FontColor := TAlphaColorRec.Grey;
    vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowLeft.TextSettings.FontColor := TAlphaColorRec.Grey;
  end;

  // Cover Related
  APICIndex := 0;

  Cover_SetArrows;
  if Cover_Get_Image(vPath, vDescription, vImage) then
  begin
    vSoundplayer.Tag.mp3.ID3v2.Cover_Label.Text := vDescription;
    vSoundplayer.Tag.mp3.ID3v2.Cover.Bitmap := vImage;
  end;

  Rating_Set;
  addons.soundplayer.Player.Tag.mp3.ID3v2.Free;
end;

function Cover_Get_Image(vFullPath: String; out vDesk: String; out vImage: TBitmap): Boolean;
var
  PictureType: Integer;
  PictureStream: TStream;
  Success: Boolean;
  MIMEType: String;
  Description: String;
  vi: Integer;
begin
  Get_ID3v2(vFullPath);
  Result := False;
  try
    PictureStream := TMemoryStream.Create;
    try
      for vi := APICIndex to addons.soundplayer.Player.Tag.mp3.ID3v2.FrameCount - 1 do
      begin
        if IsSameFrameID(addons.soundplayer.Player.Tag.mp3.ID3v2.Frames[vi].ID, 'APIC') then
        begin
          Success := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeCoverPictureStream(vi, PictureStream, MIMEType, Description, PictureType);
          if (PictureStream.Size <> 0) OR Success then
            Break;
        end;
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
      APICIndex := vi;
    finally
      PictureStream.Free;
    end;
  except
    // *
  end;
end;

procedure Transfer(vInto: String);
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
end;

///

procedure Cover_SetArrows;
begin
  if addons.soundplayer.Player.Tag.mp3.Info.General.CoverArtCount > 1 then
  begin
    vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowLeft.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowRight.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  end
  else
  begin
    vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowLeft.TextSettings.FontColor := TAlphaColorRec.Grey;
    vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowRight.TextSettings.FontColor := TAlphaColorRec.Grey;
  end;
end;

procedure Cover_Previous;
var
  i: Integer;
  vDescription: String;
  vImage: TBitmap;
begin
  Get_ID3v2(addons.soundplayer.Player.Tag.mp3.Info.General.Filename);
  for i := 0 to addons.soundplayer.Player.Tag.mp3.ID3v2.FrameCount - 1 do
  begin
    if IsSameFrameID(addons.soundplayer.Player.Tag.mp3.ID3v2.Frames[i].ID, 'APIC') then
    begin
      if i < APICIndex then
      begin
        APICIndex := i;
        if Cover_Get_Image(vCurrentSongPath, vDescription, vImage) then
        begin
          vSoundplayer.Tag.mp3.ID3v2.Cover_Label.Text := vDescription;
          vSoundplayer.Tag.mp3.ID3v2.Cover.Bitmap := vImage;
        end;
        Break;
      end;
    end;
  end;

end;

procedure Cover_Next;
var
  i: Integer;
  vDescription: String;
  vImage: TBitmap;
begin
  Get_ID3v2(addons.soundplayer.Player.Tag.mp3.Info.General.Filename);
  for i := 0 to addons.soundplayer.Player.Tag.mp3.ID3v2.FrameCount - 1 do
  begin
    if IsSameFrameID(addons.soundplayer.Player.Tag.mp3.ID3v2.Frames[i].ID, 'APIC') then
    begin
      if i > CurrentAPICIndex then
      begin
        APICIndex := i;
        if Cover_Get_Image(vCurrentSongPath, vDescription, vImage) then
        begin
          vSoundplayer.Tag.mp3.ID3v2.Cover_Label.Text := vDescription;
          vSoundplayer.Tag.mp3.ID3v2.Cover.Bitmap := vImage;
        end;
        Break;
      end;
    end;
  end;
end;

procedure Cover_Select;
begin
  if vSoundplayer.scene.OpenDialog.Filename <> '' then
  begin
    extrafe.prog.State := 'addon_soundplayer_tag_mp3_cover_select';
    uSoundplayer_Tag_Mp3_SetAll.SelectCover;
  end;
end;

procedure Cover_Select_Cancel;
begin
  extrafe.prog.State := 'addon_soundplayer_tag_mp3';
  vSoundplayer.Tag.mp3.Back_Blur.Enabled := False;
  vSoundplayer.Tag.mp3.TabControl.Enabled := True;
  FreeAndNil(vSoundplayer.Tag.mp3.Cover_Select.Panel);
end;

procedure Cover_SetFromComputer(vSelection: Integer);
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
      Success := addons.soundplayer.Player.Tag.mp3.ID3v2.GetUnicodeCoverPictureStream(vi, PictureStream, MIMEType, Description, PictureType);
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

  addons.soundplayer.Player.Tag.mp3.ID3v2.SetUnicodeCoverPictureFromFile(FrameIndex, Description, vSoundplayer.scene.OpenDialog.Filename, MIMEType,
    PictureType);
  vSoundplayer.Tag.mp3.ID3v2.Cover.Bitmap.LoadFromFile(vSoundplayer.scene.OpenDialog.Filename);
  vSoundplayer.Info.Cover.Bitmap.LoadFromFile(vSoundplayer.scene.OpenDialog.Filename);

  vSoundplayer.Tag.mp3.ID3v2.Cover_Label.Text := Description;

  vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowLeft.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowRight.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Tag.mp3.ID3v2.Cover_Remove.TextSettings.FontColor := TAlphaColorRec.Red;

  Cover_Select_Cancel;
end;

procedure Cover_Remove;
var
  vDescription: String;
  vImage: TBitmap;
begin
  vSoundplayer.Tag.mp3.ID3v2.Cover.Bitmap := nil;
  addons.soundplayer.Player.Tag.mp3.ID3v2.DeleteFrame(CurrentAPICIndex);
  addons.soundplayer.Player.Tag.mp3.Info.General.CoverArtCount := addons.soundplayer.Player.Tag.mp3.ID3v2.CoverArtCount;
  if addons.soundplayer.Player.Tag.mp3.Info.General.CoverArtCount = 0 then
  begin
    vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowLeft.TextSettings.FontColor := TAlphaColorRec.Grey;
    vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowRight.TextSettings.FontColor := TAlphaColorRec.Grey;
    vSoundplayer.Tag.mp3.ID3v2.Cover_Remove_Glow.Enabled := False;
    vSoundplayer.Tag.mp3.ID3v2.Cover_Remove.TextSettings.FontColor := TAlphaColorRec.Grey;
    vSoundplayer.Tag.mp3.ID3v2.Cover_Label.Text := '';
  end
  else
  begin
    APICIndex := 0;
    if Cover_Get_Image(vCurrentSongPath, vDescription, vImage) then
    begin
      vSoundplayer.Tag.mp3.ID3v2.Cover_Label.Text := vDescription;
      vSoundplayer.Tag.mp3.ID3v2.Cover.Bitmap := vImage;
    end;
  end;
end;

///
procedure Lyrics_Add;
var
  vTextFile: TextFile;
  vText: String;
begin
  if vSoundplayer.scene.OpenDialog.Filename <> '' then
  begin
    vLyricsList := Tstringlist.Create;

    AssignFile(vTextFile, vSoundplayer.scene.OpenDialog.Filename);
    Reset(vTextFile);
    while not EOF(vTextFile) do
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
      uSoundplayer_Tag_Mp3_SetAll.Lyrics_Add;
    end;
  end;
end;

procedure Lyrics_Load;
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
  Lyrics_Add_Cancel;
end;

procedure Lyrics_Add_Cancel;
begin
  extrafe.prog.State := 'addon_soundplayer_tag_mp3';
  vSoundplayer.Tag.mp3.Back_Blur.Enabled := False;
  vSoundplayer.Tag.mp3.TabControl.Enabled := True;
  FreeAndNil(vSoundplayer.Tag.mp3.Lyrics_Add.Panel);
end;

procedure Lyrics_Get_Add;
begin
  vSoundplayer.Tag.mp3.ID3v2.Lyrics_Memo.Lines:= vSoundplayer.Tag.mp3.Lyrics_Int.Lyrics_Box.Lines;
  Lyrics_Get_Cancel;
end;

procedure Lyrics_Get_Cancel;
begin
  extrafe.prog.State := 'addon_soundplayer_tag_mp3';
  vSoundplayer.Tag.mp3.Back_Blur.Enabled := False;
  vSoundplayer.Tag.mp3.TabControl.Enabled := True;
  FreeAndNil(vSoundplayer.Tag.mp3.Lyrics_Int.Panel);
end;

procedure Lyrics_Delete;
begin
  vSoundplayer.Tag.mp3.ID3v2.Lyrics_Memo.Lines.Clear;
end;

///
procedure Save;
var
  vGetSongPosition: Integer;
  vi, vk: Integer;
begin
  if addons.soundplayer.Playlist.List.Songs.Strings[addons.soundplayer.Player.Playing_Now] = vCurrentSongPath then
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
  addons.soundplayer.Player.Tag.mp3.ID3v2.SetUnicodeComment('TCOMM', vSoundplayer.Tag.mp3.ID3v2.Comment_V.Text,
    addons.soundplayer.Player.Tag.mp3.Lyrics_LanguageID, '');

  addons.soundplayer.Player.Tag.mp3.ID3v2.SetUnicodeLyrics('USLT', vSoundplayer.Tag.mp3.ID3v2.Lyrics_Memo.Text,
    addons.soundplayer.Player.Tag.mp3.Lyrics_LanguageID, addons.soundplayer.Player.Tag.mp3.Lyrics_Description);

  Rating_Save;

  addons.soundplayer.Player.Tag.mp3.TagError := addons.soundplayer.Player.Tag.mp3.ID3v2.SaveToFile(vCurrentSongPath);

  addons.soundplayer.Player.Tag.mp3.ID3v2.Unsynchronised := False;

  if addons.soundplayer.Player.Tag.mp3.TagError <> ID3V2LIBRARY_SUCCESS then
  begin
    Showmessage('Error saving ID3v2 tag, error code: ' + IntToStr(addons.soundplayer.Player.Tag.mp3.TagError) + #13#10 +
      ID3v2TagErrorCode2String(addons.soundplayer.Player.Tag.mp3.TagError));
  end;

  // Save it to songs info
  // Title
  if vSoundplayer.Tag.mp3.ID3v2.Title_V.Text = '' then
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Title := vSoundplayer.Tag.mp3.ID3v1.Title_V.Text
  else
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Title := vSoundplayer.Tag.mp3.ID3v2.Title_V.Text;
  // Artist
  if vSoundplayer.Tag.mp3.ID3v2.Artist_V.Text = '' then
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Artist := vSoundplayer.Tag.mp3.ID3v1.Artist_V.Text
  else
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Artist := vSoundplayer.Tag.mp3.ID3v2.Artist_V.Text;
  // Album
  if vSoundplayer.Tag.mp3.ID3v2.Album_V.Text = '' then
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Album := vSoundplayer.Tag.mp3.ID3v1.Album_V.Text
  else
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Album := vSoundplayer.Tag.mp3.ID3v2.Album_V.Text;
  // Year
  if vSoundplayer.Tag.mp3.ID3v2.Year_V.Text = '' then
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Year := vSoundplayer.Tag.mp3.ID3v1.Year_V.Text
  else
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Year := vSoundplayer.Tag.mp3.ID3v2.Year_V.Text;
  // Genre
  if vSoundplayer.Tag.mp3.ID3v2.Genre_V.Text = '' then
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Genre := vSoundplayer.Tag.mp3.ID3v1.Genre_V.Text
  else
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Genre := vSoundplayer.Tag.mp3.ID3v2.Genre_V.Text;
  // Track
  if vSoundplayer.Tag.mp3.ID3v2.Track_V.Text = '' then
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Track := vSoundplayer.Tag.mp3.ID3v1.Track_V.Text
  else
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Track := vSoundplayer.Tag.mp3.ID3v2.Track_V.Text;
  // Comments
  if vSoundplayer.Tag.mp3.ID3v2.Comment_V.Text = '' then
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Comment := vSoundplayer.Tag.mp3.ID3v1.Comment_V.Text
  else
    addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Comment := vSoundplayer.Tag.mp3.ID3v2.Comment_V.Text;
  // Rating
  addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Rate := addons.soundplayer.Player.Tag.mp3.Rating.ToString;
  if addons.soundplayer.Playlist.List.Songs.Strings[addons.soundplayer.Player.Playing_Now] = vCurrentSongPath then
  begin
    vk := 0;
    vSoundplayer.Tag.mp3.ID3v2.Rate_Label.Text := 'Rating : Not Rating';
    for vi := 0 to 4 do
    begin
      vSoundplayer.Player.Rate[vi].Text := #$e9d7;
      vSoundplayer.Player.Rate[vi].Visible := True;
    end;
    if addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Rate > IntToStr(0) then
    begin
      for vi := 0 to (addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Rate.ToInteger) - 1 do
      begin
        if not Odd(vi) then
          vSoundplayer.Player.Rate[vk].Text := #$e9d8
        else
        begin
          vSoundplayer.Player.Rate[vk].Text := #$e9d9;
          inc(vk, 1);
        end;
      end;
      vSoundplayer.Tag.mp3.ID3v2.Rate_Label.Text := 'Rating : ' + addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Rate + '/10';
    end;
  end;
  addons.soundplayer.Playlist.List.Song_Info[vCurrentSongNum].Rate := Rating_Get.ToString;
  addons.soundplayer.Player.Tag.mp3.ID3v2.Free;

  if addons.soundplayer.Playlist.List.Songs.Strings[addons.soundplayer.Player.Playing_Now] = vCurrentSongPath then
  begin
    sound.str_music[1] := BASS_StreamCreateFile(False, PChar(addons.soundplayer.Playlist.List.Songs.Strings[addons.soundplayer.Player.Playing_Now]), 0, 0,
      BASS_SAMPLE_FLOAT {$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
    if addons.soundplayer.Player.Play then
    begin
      BASS_ChannelPlay(sound.str_music[1], True);
      BASS_ChannelSetPosition(sound.str_music[1], vGetSongPosition, BASS_POS_BYTE);
      BASS_ChannelSetAttribute(sound.str_music[1], BASS_ATTRIB_VOL, addons.soundplayer.Volume.Vol / 100);
    end;
  end;

  uSoundplayer_Tag_Mp3_SetAll.Free;
end;

// rating system
procedure Rating_Stars(vStar: Integer; vLeave: Boolean);
var
  vi: Integer;
begin
  for vi := 0 to 9 do
  begin
    vSoundplayer.Tag.mp3.ID3v2.Rate[vi].Visible := True;
    vSoundplayer.Tag.mp3.ID3v2.Rate_Dot[vi].Visible := True;
  end;

  if vLeave = False then
  begin
    for vi := 9 downto vStar + 1 do
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
      for vi := 0 to 9 do
      begin
        vSoundplayer.Tag.mp3.ID3v2.Rate[vi].Visible := False;
        vSoundplayer.Tag.mp3.ID3v2.Rate_Dot[vi].Visible := True;
      end;
    end
    else
    begin
      for vi := 0 to 9 do
        vSoundplayer.Tag.mp3.ID3v2.Rate_Glow[vi].Enabled := False;
      for vi := 9 downto addons.soundplayer.Player.Tag.mp3.Rating do
        vSoundplayer.Tag.mp3.ID3v2.Rate[vi].Visible := False;
      for vi := 0 to addons.soundplayer.Player.Tag.mp3.Rating - 1 do
        vSoundplayer.Tag.mp3.ID3v2.Rate_Dot[vi].Visible := False;
    end;
  end;
end;

procedure Rating_Select_Stars(vStarNum: Byte);
var
  vi: Integer;
begin
  for vi := 0 to 9 do
    vSoundplayer.Tag.mp3.ID3v2.Rate_Glow[vi].Enabled := False;
  for vi := 9 downto vStarNum + 1 do
    vSoundplayer.Tag.mp3.ID3v2.Rate[vi].Visible := False;
  for vi := 0 to vStarNum do
    vSoundplayer.Tag.mp3.ID3v2.Rate_Dot[vi].Visible := False;

  addons.soundplayer.Player.Tag.mp3.Rating := vStarNum + 1;
  vSoundplayer.Tag.mp3.ID3v2.Rate_Label.Text := 'Rating : ' + addons.soundplayer.Player.Tag.mp3.Rating.ToString + '/10';
end;

procedure Rating_RemoveAll_Stars;
var
  vi: Integer;
begin
  for vi := 0 to 9 do
  begin
    vSoundplayer.Tag.mp3.ID3v2.Rate[vi].Visible := False;
    vSoundplayer.Tag.mp3.ID3v2.Rate_Dot[vi].Visible := True;
  end;
  addons.soundplayer.Player.Tag.mp3.Rating := 0;
  vSoundplayer.Tag.mp3.ID3v2.Rate_Label.Text := 'Rating : Not Rating';
end;

procedure Rating_Save;
var
  vIndex: Integer;
  vFound: Boolean;
  vRating: Integer;
begin
  vFound := False;
  if addons.soundplayer.Player.Tag.mp3.Rating_Before_Save <> addons.soundplayer.Player.Tag.mp3.Rating then
  begin
    if addons.soundplayer.Player.Tag.mp3.Rating > 0 then
      vRating := round((addons.soundplayer.Player.Tag.mp3.Rating) * 25.5)
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

procedure Rating_Set;
var
  vi: Integer;
  vRating: Single;
begin
  for vi := 0 to 9 do
  begin
    vSoundplayer.Tag.mp3.ID3v2.Rate[vi].Visible := True;
    vSoundplayer.Tag.mp3.ID3v2.Rate_Dot[vi].Visible := True;
  end;

  vRating := Rating_Get;

  if vRating <> 0 then
  begin
    vRating := (vRating / 25.5);
    for vi := 9 downto round(vRating) do
      vSoundplayer.Tag.mp3.ID3v2.Rate[vi].Visible := False;
    for vi := 0 to round(vRating) - 1 do
      vSoundplayer.Tag.mp3.ID3v2.Rate_Dot[vi].Visible := False;
    addons.soundplayer.Player.Tag.mp3.Rating := round(vRating);
    addons.soundplayer.Player.Tag.mp3.Rating_Before_Save := round(vRating);
    vSoundplayer.Tag.mp3.ID3v2.Rate_Label.Text := 'Rating : ' + addons.soundplayer.Player.Tag.mp3.Rating.ToString + '/10';
  end
  else
  begin
    for vi := 0 to 9 do
      vSoundplayer.Tag.mp3.ID3v2.Rate[vi].Visible := False;
    addons.soundplayer.Player.Tag.mp3.Rating := -1;
    addons.soundplayer.Player.Tag.mp3.Rating_Before_Save := -1;
    vSoundplayer.Tag.mp3.ID3v2.Rate_Label.Text := 'Rating : Not Rating';
  end;
end;

function Rating_Get: Byte;
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
