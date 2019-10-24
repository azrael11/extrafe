//********************************************************************************************************************************
//*                                                                                                                              *
//*     Tags Library 1.0.54.94 © 3delite 2014-2016                                                                               *
//*     See Tags Library Readme.txt for details                                                                                  *
//*                                                                                                                              *
//* Two licenses are available for commercial usage of this component:                                                           *
//* Shareware License: €136                                                                                                      *
//* Commercial License: €625                                                                                                     *
//*                                                                                                                              *
//*     http://www.shareit.com/product.html?productid=300627308                                                                  *
//*                                                                                                                              *
//* Using the component in free programs is free.                                                                                *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/TagsLibrary.html                                           *
//*                                                                                                                              *
//* The used tagging libraries are also avilable separatelly:                                                                    *
//*                                                                                                                              *
//* APEv2 Library available at:                                                                                                  *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/apev2library.html                                          *
//*                                                                                                                              *
//* ID3v2 Library available at:                                                                                                  *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html                                          *
//*                                                                                                                              *
//* MP4 Tag Library available at:                                                                                                *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/MP4TagLibrary.html                                         *
//*                                                                                                                              *
//* Ogg Vorbis and Opus Tag Library available at:                                                                                *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/OpusTagLibrary.html                                        *
//*                                                                                                                              *
//* Flac Tag Library available at:                                                                                               *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/FlacTagLibrary.html                                        *
//*                                                                                                                              *
//* WMA Tag Library available at:                                                                                                *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WMATagLibrary.html                                         *
//*                                                                                                                              *
//* WAV Tag Library available at:                                                                                                *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WAVTagLibrary.html                                         *
//*                                                                                                                              *
//* For other Delphi components see the home page:                                                                               *
//*                                                                                                                              *
//*     http://www.3delite.hu/                                                                                                   *
//*                                                                                                                              *
//* If you have any questions or enquiries please mail: 3delite@3delite.hu                                                       *
//*                                                                                                                              *
//* Good coding! :)                                                                                                              *
//* 3delite                                                                                                                      *
//********************************************************************************************************************************

unit TagsLibrary;

interface

Uses
    SysUtils,
    Classes,
    //VCL.Dialogs,
    ReadMemoryStream,
    APEv2Library,
    FlacTagLibrary,
    ID3v1Library,
    ID3v2Library,
    MP4TagLibrary,
    OggVorbisAndOpusTagLibrary,
    {$IFDEF MSWINDOWS}
    Windows,
    WMATagLibrary,
    {$ENDIF}
    WAVTagLibrary,
    WAVPackfile,
    Musepack;

{$MINENUMSIZE 4}

Const
    TAGSLIBRARY_VERSION = $01005494;

Const
    TAGSLIBRARY_SUCCESS                                             = 0;
    TAGSLIBRARY_ERROR                                               = $FFFF;
    TAGSLIBRARY_ERROR_NO_TAG_FOUND                                  = 1;
    TAGSLIBRARY_ERROR_FILENOTFOUND                                  = 2;
    TAGSLIBRARY_ERROR_EMPTY_TAG                                     = 3;
    TAGSLIBRARY_ERROR_EMPTY_FRAMES                                  = 4;
    TAGSLIBRARY_ERROR_OPENING_FILE                                  = 5;
    TAGSLIBRARY_ERROR_READING_FILE                                  = 6;
    TAGSLIBRARY_ERROR_WRITING_FILE                                  = 7;
    TAGSLIBRARY_ERROR_CORRUPT                                       = 8;
    TAGSLIBRARY_ERROR_NOT_SUPPORTED_VERSION                         = 9;
    TAGSLIBRARY_ERROR_NOT_SUPPORTED_FORMAT                          = 10;
    TAGSLIBRARY_ERROR_BASS_NOT_LOADED                               = 11;
    TAGSLIBRARY_ERROR_BASS_ChannelGetTags_NOT_FOUND                 = 12;
    TAGSLIBRARY_ERROR_DOESNT_FIT                                    = 13;
    TAGSLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS                         = 14;
    TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNTLOADDLL                  = 15;
    TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNOTCREATEMETADATAEDITOR    = 16;
    TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNOTQIFORIWMHEADERINFO3     = 17;
    TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNOTQUERY_ATTRIBUTE_COUNT   = 18;
    TAGSLIBRARY_ERROR_MP4TAGLIBRARY_UPDATE_stco                     = 19;
    TAGSLIBRARY_ERROR_MP4TAGLIBRARY_UPDATE_co64                     = 20;

Const
    BEXT_Description = 'BEXT Description';
    BEXT_Originator = 'BEXT Originator';
    BEXT_OriginatorReference = 'BEXT OriginatorReference';
    BEXT_OriginationDate = 'BEXT OriginationDate';
    BEXT_OriginationTime = 'BEXT OriginationTime';
    BEXT_TimeReference = 'BEXT TimeReference';
    BEXT_Version = 'BEXT Version';
    BEXT_UMID = 'BEXT UMID';
    BEXT_CodingHistory = 'BEXT CodingHistory';

    CART_Version = 'CART Version';
    CART_Title = 'CART Title';
    CART_Artist = 'CART Artist';
    CART_CutID = 'CART CutID';
    CART_ClientID = 'CART ClientID';
    CART_Category = 'CART Category';
    CART_Classification = 'CART Classification';
    CART_OutCue = 'CART OutCue';
    CART_StartDate = 'CART StartDate';
    CART_StartTime = 'CART StartTime';
    CART_EndDate = 'CART EndDate';
    CART_EndTime = 'CART EndTime';
    CART_ProducerAppID = 'CART ProducerAppID';
    CART_ProducerAppVersion = 'CART ProducerAppVersion';
    CART_UserDef = 'CART UserDef';
    CART_LevelReference = 'CART LevelReference';
    CART_PostTimer = 'CART PostTimer';
    CART_URL = 'CART URL';
    CART_Reserved = 'CART Reserved';
    CART_TagText = 'CART TagText';

Const
    MAGIC_PNG = $5089;  //* Little endian form
    MAGIC_JPG = $d8ff;  //* Little endian form
    MAGIC_GIF = $4947;  //* Little endian form
    MAGIC_BMP = $4d42;  //* Little endian form

Const
    DEFAULT_UPPERCASE_FIELD_NAMES = True;

type
    TTagType = (ttNone, ttAutomatic, ttAPEv2, ttFlac, ttID3v1, ttID3v2, ttMP4, ttOpusVorbis, ttWAV, ttWMA);

    TTagTypes = set of TTagType;

type
    TAudioFileFormat = (affUnknown, affAPE, affFlac, affOggFlac, affMPEG, affMP4, affOpus, affVorbis, affTheora, affWAV, affRF64, affAIFF, affAIFC, affDFF, affDSF, affOptimFrog, affMusePack, affWavPack);

type
    TTagPictureFormat = (tpfUnknown, tpfJPEG, tpfPNG, tpfBMP, tpfGIF);

type
    TTagPriority = Array [0..8] of TTagType;

type
    TExtTagType = (ettUnknown, ettTXXX, ettWXXX);

type
    TTags = class;

    TTag = class
    private
    public
        Name: String;
        Value: String;
        Language: String;
        Description: String;
        ExtTagType: TExtTagType;
        Parent: TTags;
        Index: Integer;
        Constructor Create(Parent: TTags);
        Destructor Destroy; override;
        function GetAsList(var List: TStrings): Boolean;
        function SetAsList(List: TStrings): Boolean;
        procedure Clear;
        function Delete: Boolean;
        procedure Remove;
        function Assign(Tag: TTag): Boolean;
    end;

    TCoverArt = class
    private
    public
        Name: String;
        Stream: TStream;
        Description: String;
        CoverType: Cardinal;
        MIMEType: String;
        PictureFormat: TTagPictureFormat;
        Width: Cardinal;
        Height: Cardinal;
        ColorDepth: Cardinal;
        NoOfColors: Cardinal;
        Parent: TTags;
        Index: Integer;
        Constructor Create(Parent: TTags);
        Destructor Destroy; override;
        procedure Clear;
        procedure Delete;
        function Assign(CoverArt: TCoverArt): Boolean;
    end;

    TSourceAudioAttributes = class
    private
        function GetChannels: Word;
        function GetSamplesPerSec: DWord;
        function GetBitsPerSample: Word;
        function GetPlayTime: Double;
        function GetSampleCount: Int64;
        function GetBitRate: Integer;
    public
        WAVPackAttributes: TWAVPackfile;
        MusePackAttributes: TMPEGplus;
        Parent: TTags;
        Constructor Create(Parent: TTags);
        Destructor Destroy; override;
        property Channels: Word read GetChannels;
        property SamplesPerSec: DWord read GetSamplesPerSec;
        property BitsPerSample: Word read GetBitsPerSample;
        property PlayTime: Double read GetPlayTime;
        property SampleCount: Int64 read GetSampleCount;
        property BitRate: Integer read GetBitRate;
    end;

    TTags = class
    private
        function GetSize: Int64;
    public
        FileName: String;
        Loaded: Boolean;
        TagLoadPriority: TTagPriority;
        APEv2Tag: TAPEv2Tag;
        FlacTag: TFlacTag;
        ID3v1Tag: TID3v1Tag;
        ID3v2Tag: TID3v2Tag;
        MP4Tag: TMP4Tag;
        OggVorbisAndOpusTag: TOpusTag;
        WAVTag: TWAVTag;
        {$IFDEF MSWINDOWS}
        WMATag: TWMATag;
        {$ENDIF}
        Tags: Array of TTag;
        CoverArts: Array of TCoverArt;
        SourceAudioAttributes: TSourceAudioAttributes;
        UpperCaseFieldNamesToWrite: Boolean;
        MP4KeepPadding: Boolean;
        ParseWavPackAudioAttributes: Boolean;
        ParseMusePackAudioAttributes: Boolean;
        User1: TObject;
        User2: TObject;
        PreserveFileDate: Boolean;
        Constructor Create;
        Destructor Destroy; override;
        function LoadFromFile(FileName: String): Integer;
        function LoadFromBASS(Channel: Cardinal): Integer;
        function LoadFromStream(Stream: TStream): Integer;
        function LoadFromMemory(Address: Pointer; Size: NativeInt): Integer;
        function SaveToFile(FileName: String; TagType: TTagType = ttAutomatic): Integer;
        function SaveToStream(Stream: TStream; TagType: TTagType = ttAutomatic): Integer;
        procedure LoadTags;
        function Add(Name: String): TTag;
        function Tag(Name: String): TTag;
        function GetTag(Name: String): String;
        function SetTag(Name: String; Text: String): Integer;
        function SetList(Name: String; List: TStrings): Integer;
        function Delete(Index: Integer): Boolean; overload;
        function Delete(Name: String): Boolean; overload;
        function Remove(Index: Integer): Boolean;
        procedure DeleteAllTags;
        procedure Clear; overload;
        function Clear(Name: String): Integer; overload;
        function Count: Integer;
        function Exists(Name: String): Integer; overload;
        function TypeCount(Name: String): Integer;
        function ItemAlreadyOnList(List: TStrings; Item: String): Boolean;
        procedure GetMultipleList(Name: String; List: TStrings);
        procedure RemoveEmptyTags;
        function CoverArtCount: Integer;
        function CoverArt(Name: String): TCoverArt;
        function AddCoverArt(Name: String): TCoverArt; overload;
        function AddCoverArt(Name: String; Stream: TStream; MIMEType: String): TCoverArt; overload;
        function AddCoverArt(Name: String; FileName: String): TCoverArt; overload;
        function DeleteCoverArt(Index: Integer): Boolean;
        procedure DeleteAllCoverArts;
        function Assign(Source: TTags): Boolean;
        function ClearAllID3v2FramesByID(ID3v2Tag: TID3v2Tag; FrameID: String): Boolean;
        function ClearAllID3v2FramesTXXXByDescription(ID3v2Tag: TID3v2Tag; Description: String): Boolean;
        function SaveAPEv2Tag(FileName: String; Stream: TStream = nil): Integer;
        function SaveFlacTag(FileName: String; Stream: TStream = nil): Integer;
        function SaveID3v1Tag(FileName: String; Stream: TStream = nil): Integer;
        function SaveID3v2Tag(FileName: String; Stream: TStream = nil): Integer;
        function SaveMP4Tag(FileName: String; Stream: TStream = nil): Integer;
        function SaveOggVorbisAndOpusTag(FileName: String; Stream: TStream = nil): Integer;
        function SaveWAVTag(FileName: String; Stream: TStream = nil): Integer;
        {$IFDEF MSWINDOWS}
        function SaveWMATag(FileName: String): Integer;
        {$ENDIF}
        procedure LoadAPEv2Tags;
        procedure LoadFlacTags;
        procedure LoadOggVorbisAndOpusTags;
        procedure LoadID3v1Tags;
        procedure LoadID3v2Tags;
        procedure LoadMP4Tags;
        procedure LoadWAVTags;
        {$IFDEF MSWINDOWS}
        procedure LoadWMATags;
        {$ENDIF}
        procedure LoadNullTerminatedStrings(TagType: String; TagList: TStrings);
        procedure LoadNullTerminatedWAVRIFFINFOStrings(TagList: TStrings);
        function PictureStreamType(PictureStream: TStream): TTagPictureFormat;
        function PicturePointerType(Picture: Pointer; DataSize: UInt64): TTagPictureFormat;
    //published
        property Size: Int64 read GetSize;
    end;

    function RemoveTagsFromFile(FileName: String; TagType: TTagType = ttAutomatic): Integer;
    function RemoveTagsFromStream(Stream: TStream; TagType: TTagType = ttAutomatic): Integer;

    function TagsLibraryErrorCode2String(ErrorCode: Integer): String;

    function ID3v1TagLibraryErrorCodeToTagsLibraryErrorCode(ErrorCode: Integer): Integer;
    function ID3v2TagLibraryErrorCodeToTagsLibraryErrorCode(ErrorCode: Integer): Integer;
    function FlacTagLibraryErrorCodeToTagsLibraryErrorCode(ErrorCode: Integer): Integer;
    function MP4TagLibraryErrorCodeToTagsLibraryErrorCode(ErrorCode: Integer): Integer;
    function APEv2TagLibraryErrorCodeToTagsLibraryErrorCode(ErrorCode: Integer): Integer;
    function OpusVorbisTagLibraryErrorCodeToTagsLibraryErrorCode(ErrorCode: Integer): Integer;
    function WAVTagLibraryErrorCodeToTagsLibraryErrorCode(ErrorCode: Integer): Integer;
    {$IFDEF MSWINDOWS}
    function WMATagLibraryErrorCodeToTagsLibraryErrorCode(ErrorCode: Integer): Integer;
    {$ENDIF}

    function ID3v2FrameIDToFieldName(FrameID: TFrameID): String; overload;
    function ID3v2FrameIDToFieldName(FrameID: String): String; overload;
    function FieldNameToID3v2FrameID(FieldName: String): String;

    function MP4AtomNameToFieldName(AtomName: TAtomName): String; overload;
    function MP4AtomNameToFieldName(AtomName: String): String; overload;
    function FieldNameToMP4AtomName(FieldName: String): String; overload;

    function WAVChunkIDToFieldName(ChunkID: String): String;
    function FieldNameToWAVChunkID(FieldName: String): String;

    {$IFDEF MSWINDOWS}
    function WMATagIDToFieldName(TagID: String): String;
    function FieldNameToWMATagID(FieldName: String): String;
    {$ENDIF}

    function VorbisGetCoverArtFromFrame(PictureString: String; var PictureStream: TStream; var CoverArtInfo: TOpusVorbisCoverArtInfo): Boolean;

    function PictureFormatFromMIMEType(MIMEType: String): TTagPictureFormat;
    function TagTypeFromFileName(FileName: String): TTagTypes;

    function DetectAudioFileFormat(FileName: String): TAudioFileFormat; overload;
    function DetectAudioFileFormat(Stream: TStream): TAudioFileFormat; overload;

    {$IFDEF MSWINDOWS}
    function SetDateToFile(const FileName: string; Value: TDateTime): Boolean;
    {$ENDIF}

var
    TagsLibraryDefaultUpperCaseFieldNamesToWrite: Boolean = DEFAULT_UPPERCASE_FIELD_NAMES;
    TagsLibraryDefaultTagLoadPriority: TTagPriority;

    TagsLibraryPaddingSizeToWrite: Integer = 4096;
    TagsLibraryParseOggPlayTime: Boolean = False;
    TagsLibraryParseWavPackAudioAttributes: Boolean = False;
    TagsLibraryParseMusePackAudioAttributes: Boolean = False;
    TagsLibraryMP4KeepPadding: Boolean = True;

implementation

//Uses
    //Windows;

Constructor TTag.Create(Parent: TTags);
begin
    Inherited Create;
    Self.Parent := Parent;
end;

Destructor TTag.Destroy;
begin
    Inherited;
end;

function TTag.SetAsList(List: TStrings): Boolean;
var
    i: Integer;
begin
    //if Format <> ffText then begin
    //    Exit;
    //end;
    Self.Value := '';
    for i := 0 to List.Count - 1 do begin
        Self.Value := Self.Value + List.Names[i] + #13#10 + List.ValueFromIndex[i] + #13#10;
    end;
    Result := True;
end;

function TTag.GetAsList(var List: TStrings): Boolean;
var
    TempList: TStrings;
    i: Integer;
begin
    //Result := False;
    List.Clear;
    {
    if Format <> ffText then begin
        Exit;
    end;
    }
    TempList := TStringList.Create;
    try
        TempList.Text := Self.Value;
        for i := 0 to (TempList.Count - 1) div 2 do begin
            List.Append(TempList[i * 2] + '=' + TempList[i * 2 + 1]);
        end;
    finally
        FreeAndNil(TempList);
    end;
    Result := True;
end;

procedure TTag.Remove;
begin
    Parent.Remove(Index);
end;

procedure TTag.Clear;
begin
    Self.Name := '';
    Self.Value := '';
    Self.Language := '';
    Self.Description := '';
end;

function TTag.Delete: Boolean;
begin
    Result := Parent.Delete(Index);
end;

function TTag.Assign(Tag: TTag): Boolean;
begin
    Self.Clear;
    if Tag <> nil then begin
        Self.Name := Tag.Name;
        Self.Value := Tag.Value;
        Self.Language := Tag.Language;
        Self.Description := Tag.Description;
    end;
    Result := True;
end;

{ TCoverArt }

function TCoverArt.Assign(CoverArt: TCoverArt): Boolean;
begin
    Self.Clear;
    if CoverArt <> nil then begin
        Self.Name := CoverArt.Name;
        TMemoryStream(Stream).Clear;
        Stream.CopyFrom(CoverArt.Stream, 0);
        Self.CoverType := CoverArt.CoverType;
        Self.Description := CoverArt.Description;
        Self.MIMEType := CoverArt.MIMEType;
        Self.PictureFormat := CoverArt.PictureFormat;
        Self.Width := CoverArt.Width;
        Self.Height := CoverArt.Height;
        Self.ColorDepth := CoverArt.ColorDepth;
        Self.NoOfColors := CoverArt.NoOfColors;
    end;
    Result := True;
end;

procedure TCoverArt.Clear;
begin
    Self.Name := '';
    TMemoryStream(Stream).Clear;
    Self.CoverType := 0;
    Self.Description := '';
    Self.MIMEType := '';
    Self.PictureFormat := tpfUnknown;
    Self.Width := 0;
    Self.Height := 0;
    Self.ColorDepth := 0;
    Self.NoOfColors := 0;
end;

constructor TCoverArt.Create(Parent: TTags);
begin
    inherited Create;
    Self.Parent := Parent;
    Stream := TMemoryStream.Create;
end;

procedure TCoverArt.Delete;
begin
    Parent.DeleteCoverArt(Index);
end;

destructor TCoverArt.Destroy;
begin
    FreeAndNil(Stream);
    inherited;
end;

{ TTags }

Constructor TTags.Create;
begin
    Inherited;
    APEv2Tag := TAPEv2Tag.Create;
    FlacTag := TFlacTag.Create;
    ID3v1Tag := TID3v1Tag.Create;
    ID3v2Tag := TID3v2Tag.Create;
    MP4Tag := TMP4Tag.Create;
    OggVorbisAndOpusTag := TOpusTag.Create;
    WAVTag := TWAVTag.Create;
    {$IFDEF MSWINDOWS}
    WMATag := TWMATag.Create;
    {$ENDIF}
    SourceAudioAttributes := TSourceAudioAttributes.Create(Self);
    Clear;
    UpperCaseFieldNamesToWrite := TagsLibraryDefaultUpperCaseFieldNamesToWrite;
    TagLoadPriority := TagsLibraryDefaultTagLoadPriority;
    FlacTag.PaddingSizeToWrite := TagsLibraryPaddingSizeToWrite;
    ID3v2Tag.PaddingToWrite := TagsLibraryPaddingSizeToWrite;
    MP4Tag.PaddingToWrite := TagsLibraryPaddingSizeToWrite;
    OggVorbisAndOpusTag.PaddingSizeToWrite := TagsLibraryPaddingSizeToWrite;
    OggVorbisAndOpusTag.ParsePlayTime := TagsLibraryParseOggPlayTime;
    MP4KeepPadding := TagsLibraryMP4KeepPadding;
    ParseWavPackAudioAttributes := TagsLibraryParseWavPackAudioAttributes;
    ParseMusePackAudioAttributes := TagsLibraryParseMusePackAudioAttributes;
end;

Destructor TTags.Destroy;
begin
    Clear;
    FreeAndNil(APEv2Tag);
    FreeAndNil(FlacTag);
    FreeAndNil(ID3v1Tag);
    FreeAndNil(ID3v2Tag);
    FreeAndNil(MP4Tag);
    FreeAndNil(OggVorbisAndOpusTag);
    FreeAndNil(WAVTag);
    {$IFDEF MSWINDOWS}
    FreeAndNil(WMATag);
    {$ENDIF}
    FreeAndNil(SourceAudioAttributes);
    if Assigned(User1) then begin
        FreeAndNil(User1);
    end;
    if Assigned(User2) then begin
        FreeAndNil(User2);
    end;
    Inherited;
end;

procedure TTags.DeleteAllTags;
var
    i: Integer;
begin
    for i := 0 to Length(Tags) - 1 do begin
        FreeAndNil(Tags[i]);
    end;
    SetLength(Tags, 0);
end;

function TTags.DeleteCoverArt(Index: Integer): Boolean;
var
    i: Integer;
    j: Integer;
begin
    Result := False;
    if (Index >= Length(CoverArts))
    OR (Index < 0)
    then begin
        Exit;
    end;
    FreeAndNil(CoverArts[Index]);
    i := 0;
    j := 0;
    while i <= Length(CoverArts) - 1 do begin
        if CoverArts[i] <> nil then begin
            CoverArts[j] := CoverArts[i];
            CoverArts[j].Index := j;
            Inc(j);
        end;
        Inc(i);
    end;
    SetLength(CoverArts, j);
    Result := True;
end;

procedure TTags.DeleteAllCoverArts;
var
    i: Integer;
begin
    for i := 0 to Length(CoverArts) - 1 do begin
        FreeAndNil(CoverArts[i]);
    end;
    SetLength(CoverArts, 0);
end;

{
function TTags.LoadFromStream(TagStream: TStream): Integer;
var
    PreviousPosition: Int64;
    ReadID3v1ID: TID3v1ID;
    APEv2Header: TAPEv2Header;
    i: Integer;
    DataSize: Cardinal;
    DataFlags: Cardinal;
    Data: Byte;
    FrameName: String;
    Bytes: TBytes;
    ByteCounter: Integer;
begin
    Result := TAGSLIBRARY_ERROR;
    Loaded := False;
    Clear;
    try
        PreviousPosition := TagStream.Position;
        try
            Self.
                Loaded := True;
            end;
        finally
            TagStream.Seek(PreviousPosition, soBeginning);
        end;
        Result := APEV2LIBRARY_SUCCESS;
    except
        if Result <> APEV2LIBRARY_ERROR_CORRUPT then begin
            Result := APEV2LIBRARY_ERROR;
        end;
    end;
end;
}

function TTags.LoadFromBASS(Channel: Cardinal): Integer;
Const
  // BASS_ChannelGetTags types : what's returned
  BASS_TAG_ID3        = 0; // ID3v1 tags : TAG_ID3 structure
  BASS_TAG_ID3V2      = 1; // ID3v2 tags : variable length block
  BASS_TAG_OGG        = 2; // OGG comments : series of null-terminated UTF-8 strings
  BASS_TAG_HTTP       = 3; // HTTP headers : series of null-terminated ANSI strings
  BASS_TAG_ICY        = 4; // ICY headers : series of null-terminated ANSI strings
  BASS_TAG_META       = 5; // ICY metadata : ANSI string
  BASS_TAG_APE        = 6; // APEv2 tags : series of null-terminated UTF-8 strings
  BASS_TAG_MP4        = 7; // MP4/iTunes metadata : series of null-terminated UTF-8 strings
  BASS_TAG_VENDOR     = 9; // OGG encoder : UTF-8 string
  BASS_TAG_LYRICS3    = 10; // Lyric3v2 tag : ASCII string
  BASS_TAG_CA_CODEC   = 11;	// CoreAudio codec info : TAG_CA_CODEC structure
  BASS_TAG_MF         = 13;	// Media Foundation tags : series of null-terminated UTF-8 strings
  BASS_TAG_WAVEFORMAT = 14;	// WAVE format : WAVEFORMATEEX structure
  BASS_TAG_RIFF_INFO  = $100; // RIFF "INFO" tags : series of null-terminated ANSI strings
  BASS_TAG_RIFF_BEXT  = $101; // RIFF/BWF "bext" tags : TAG_BEXT structure
  BASS_TAG_RIFF_CART  = $102; // RIFF/BWF "cart" tags : TAG_CART structure
  BASS_TAG_RIFF_DISP  = $103; // RIFF "DISP" text tag : ANSI string
  BASS_TAG_APE_BINARY = $1000; // + index #, binary APEv2 tag : TAG_APE_BINARY structure
  BASS_TAG_MUSIC_NAME = $10000;	// MOD music name : ANSI string
  BASS_TAG_MUSIC_MESSAGE = $10001; // MOD message : ANSI string
  BASS_TAG_MUSIC_ORDERS = $10002; // MOD order list : BYTE array of pattern numbers
  BASS_TAG_MUSIC_INST = $10100;	// + instrument #, MOD instrument name : ANSI string
  BASS_TAG_MUSIC_SAMPLE = $10300; // + sample #, MOD sample name : ANSI string
  BASS_TAG_WMA        = 8; // WMA header tags : series of null-terminated UTF-8 strings
  BASS_TAG_DSD_ARTIST          = $13000; // DSDIFF artist : ASCII string
  BASS_TAG_DSD_TITLE           = $13001; // DSDIFF title : ASCII string
  BASS_TAG_DSD_COMMENT         = $13100; // + index, DSDIFF comment : TAG_DSD_COMMENT structure

type
  PTAG_DSD_COMMENT = ^TAG_DSD_COMMENT;
  TAG_DSD_COMMENT = packed record
	timeStampYear: Word; // creation year
	TimeStampMonth: Byte; // creation month
	timeStampDay: Byte; // creation day
	timeStampHour: Byte; // creation hour
	timeStampMinutes: Byte; // creation minutes
	cmtType: Word; // comment type
	cmtRef: Word; // comment reference
	count: DWORD; // string length
	commentText: Array[0..MaxInt div 2 - 1] of Byte; // text
  end;

Const
{$IFDEF MSWINDOWS}
  bassdll = 'bass.dll';
{$ENDIF}
{$IFDEF LINUX}
  bassdll = 'libbass.so';
{$ENDIF}
{$IFDEF MACOS}
  bassdll = 'libbass.dylib';
{$ENDIF}
{$IFDEF ANDROID}
  bassdll = 'libbass.so';
{$ENDIF}
{$IFDEF IOS}
  bassdll = 'libbass.dylib';
{$ENDIF}

var
    BASSDLLHandle: THandle;
    BASS_ChannelGetTags: function (Handle: Cardinal; Tags: DWORD): PByte; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    PTags: PByte;
    Bytes: TBytes;
    TagList: TStrings;
    PDSDTags: PTAG_DSD_COMMENT;

    function PCharLength(PCharPointer: PByte): Integer;
    begin
        Result := 0;
        repeat
            Inc(Result);
            Inc(PCharPointer);
        until PCharPointer^ = 0;
    end;

    procedure ParseTags;
    var
        Counter: Integer;
    begin
        TagList.Clear;
        repeat
            SetLength(Bytes, PCharLength(PTags));
            Counter := 0;
            repeat
                Bytes[Counter] := PTags^;
                Inc(Counter);
                Inc(PTags);
            until PTags^ = 0;
            TagList.Append(TEncoding.UTF8.GetString(Bytes));
            Inc(PTags);
        until PTags^ = 0;
    end;

    function BytesToString(P: PByte; MaxBytes: Integer): String;
    var
        Counter: Integer;
        Bytes: TBytes;
    begin
        SetLength(Bytes, MaxBytes);
        Counter := 0;
        repeat
            Bytes[Counter] := P^;
            Inc(Counter);
            Inc(P);
        until (Counter > MaxBytes - 1)
        OR (Bytes[Counter - 1] = 0);
        if Counter > MaxBytes - 1 then begin
            SetLength(Bytes, MaxBytes);
        end else begin
            SetLength(Bytes, Counter - 1);
        end;
        Result := TEncoding.UTF8.GetString(Bytes);
    end;

begin
    Clear;
    Loaded := False;
    WAVTag.BEXT.Loaded := False;
    WAVTag.CART.Loaded := False;
    // Dynamic BASS API linking
    BASSDLLHandle := GetModuleHandle(bassdll);
    if BASSDLLHandle = 0 then begin
        Result := TAGSLIBRARY_ERROR_BASS_NOT_LOADED;
        Exit;
    end;
    BASS_ChannelGetTags := GetProcAddress(BASSDLLHandle, 'BASS_ChannelGetTags');
    if NOT Assigned(BASS_ChannelGetTags) then begin
        Result := TAGSLIBRARY_ERROR_BASS_ChannelGetTags_NOT_FOUND;
        Exit;
    end;
    TagList := TStringList.Create;
    try
        //* Query BASS for ID3v1 tags
        PTags := BASS_ChannelGetTags(Channel, BASS_TAG_ID3);
        if Assigned(PTags) then begin
            ID3v1Tag.LoadFromMemory(PTags);
        end;
        //* Query BASS for ID3v2 tags
        PTags := BASS_ChannelGetTags(Channel, BASS_TAG_ID3V2);
        if Assigned(PTags) then begin
            ID3v2Tag.LoadFromMemory(PTags);
        end;
        //* Query BASS for OGG tags
        PTags := BASS_ChannelGetTags(Channel, BASS_TAG_OGG);
        if Assigned(PTags) then begin
            ParseTags;
            LoadNullTerminatedStrings('OGG TAG', TagList);
        end;
        //* Query BASS for HTTP tags
        PTags := BASS_ChannelGetTags(Channel, BASS_TAG_HTTP);
        if Assigned(PTags) then begin
            ParseTags;
            LoadNullTerminatedStrings('HTTP TAG', TagList);
        end;
        //* Query BASS for ICY tags
        PTags := BASS_ChannelGetTags(Channel, BASS_TAG_ICY);
        if Assigned(PTags) then begin
            ParseTags;
            LoadNullTerminatedStrings('ICY TAG', TagList);
        end;
        //* Query BASS for META tags
        PTags := BASS_ChannelGetTags(Channel, BASS_TAG_META);
        if Assigned(PTags) then begin
            ParseTags;
            LoadNullTerminatedStrings('META TAG', TagList);
        end;
        //* Query BASS for APE tags
        PTags := BASS_ChannelGetTags(Channel, BASS_TAG_APE);
        if Assigned(PTags) then begin
            ParseTags;
            LoadNullTerminatedStrings('APE TAG', TagList);
        end;
        //* Query BASS for MP4 tags
        PTags := BASS_ChannelGetTags(Channel, BASS_TAG_MP4);
        if Assigned(PTags) then begin
            ParseTags;
            LoadNullTerminatedStrings('MP4 TAG', TagList);
        end;
        //* Query BASS for LYRICS3 tags
        PTags := BASS_ChannelGetTags(Channel, BASS_TAG_LYRICS3);
        if Assigned(PTags) then begin
            ParseTags;
            LoadNullTerminatedStrings('LYRICS3 TAG', TagList);
        end;
        //* Query BASS for MF tags
        PTags := BASS_ChannelGetTags(Channel, BASS_TAG_MF);
        if Assigned(PTags) then begin
            ParseTags;
            LoadNullTerminatedStrings('MF TAG', TagList);
        end;
        //* Query BASS for RIFF INFO tags
        PTags := BASS_ChannelGetTags(Channel, BASS_TAG_RIFF_INFO);
        if Assigned(PTags) then begin
            ParseTags;
            LoadNullTerminatedWAVRIFFINFOStrings(TagList);
        end;
        //* Query BASS for RIFF BEXT tags
        PTags := BASS_ChannelGetTags(Channel, BASS_TAG_RIFF_BEXT);
        if Assigned(PTags) then begin
            //FillChar(Pointer(@BEXT)^, SizeOf(BEXT), 0);
            //Move(PTags^, BEXT.Description[0], SizeOf(BEXT));
            //ParseTagsBEXT;
            WAVTag.BEXT.Clear;
            Move(PTags^, WAVTag.BEXT.BEXTChunk.Description[0], SizeOf(TAG_BEXT));
            Inc(PTags, SizeOf(TAG_BEXT));
            //TagList.Append(BEXT_CodingHistory + '=' + BytesToString(PTags, PCharLength(PTags)));
            //LoadNullTerminatedStrings('BEXT TAG', TagList);
            WAVTag.BEXT.CodingHistory := BytesToString(PTags, PCharLength(PTags));
            WAVTag.BEXT.Loaded := True;
        end;
        //* Query BASS for RIFF CART tags
        PTags := BASS_ChannelGetTags(Channel, BASS_TAG_RIFF_CART);
        if Assigned(PTags) then begin
            //FillChar(Pointer(@CART)^, SizeOf(CART), 0);
            //Move(PTags^, CART.Version[1], SizeOf(CART));
            //ParseTagsCART;
            WAVTag.CART.Clear;
            Move(PTags^, WAVTag.CART.CARTChunk.Version[0], SizeOf(TAG_CART));
            Inc(PTags, SizeOf(TAG_CART));
            //TagList.Append(CART_TagText + '=' + BytesToString(PTags, PCharLength(PTags)));
            //LoadNullTerminatedStrings('CART TAG', TagList);
            WAVTag.CART.TagText := BytesToString(PTags, PCharLength(PTags));
            WAVTag.CART.Loaded := True;
        end;
        //* Query BASS for RIFF DISP tags
        PTags := BASS_ChannelGetTags(Channel, BASS_TAG_RIFF_DISP);
        if Assigned(PTags) then begin
            ParseTags;
            LoadNullTerminatedStrings('RIFF DISP TAG', TagList);
        end;
        //* Query BASS for MOD music name
        PTags := BASS_ChannelGetTags(Channel, BASS_TAG_MUSIC_NAME);
        if Assigned(PTags) then begin
            ParseTags;
            LoadNullTerminatedStrings('MOD MUSIC NAME', TagList);
        end;
        //* Query BASS for WMA tags
        PTags := BASS_ChannelGetTags(Channel, BASS_TAG_WMA);
        if Assigned(PTags) then begin
            ParseTags;
            LoadNullTerminatedStrings('WMA TAG', TagList);
        end;
        //* Query BASS for DSD comment tags
        PDSDTags := PTAG_DSD_COMMENT(BASS_ChannelGetTags(Channel, BASS_TAG_DSD_COMMENT));
        if Assigned(PDSDTags) then begin
            TagList.Clear;
            TagList.Append('RECORDINGDATE='
                + IntToStr(PDSDTags.timeStampYear) + '-'
                + IntToStr(PDSDTags.TimeStampMonth) + '-'
                + IntToStr(PDSDTags.timeStampDay) + ' '
                + IntToStr(PDSDTags.timeStampHour) + ':'
                + IntToStr(PDSDTags.timeStampMinutes)
            );
            SetLength(Bytes, PDSDTags.count);
            Move(PDSDTags.commentText[0], Bytes[0], PDSDTags.count);
            TagList.Append('COMMENT=' + TEncoding.ANSI.GetString(Bytes));
            LoadNullTerminatedStrings('DSD IFF TAG', TagList);
        end;
        //* Query BASS for DSD artist tag
        PTags := BASS_ChannelGetTags(Channel, BASS_TAG_DSD_ARTIST);
        if Assigned(PTags) then begin
            TagList.Clear;
            SetLength(Bytes, PCharLength(PTags));
            Move(PTags, Bytes[0], Length(Bytes));
            TagList.Append('ARTIST=' + TEncoding.ANSI.GetString(Bytes));
            LoadNullTerminatedStrings('DSD IFF TAG', TagList);
        end;
        //* Query BASS for DSD artist tag
        PTags := BASS_ChannelGetTags(Channel, BASS_TAG_DSD_TITLE);
        if Assigned(PTags) then begin
            TagList.Clear;
            SetLength(Bytes, PCharLength(PTags));
            Move(PTags, Bytes[0], Length(Bytes));
            TagList.Append('TITLE=' + TEncoding.ANSI.GetString(Bytes));
            LoadNullTerminatedStrings('DSD IFF TAG', TagList);
        end;
    finally
        //* TODO: process the list
        FreeAndNil(TagList);
    end;
    LoadTags;
    Result := TAGSLIBRARY_SUCCESS;
end;

function TTags.LoadFromFile(FileName: String): Integer;
var
    Fext: String;
    TagsSize: Integer;
begin
    Clear;
    Loaded := False;
    if NOT FileExists(FileName) then begin
        Result := TAGSLIBRARY_ERROR_OPENING_FILE;
        Exit;
    end;
    Fext := UpperCase(ExtractFileExt(FileName));
    try
        APEv2Tag.LoadFromFile(FileName);
    except
        //* Error
    end;
    try
        FlacTag.LoadFromFile(FileName);
    except
        //* Error
    end;
    try
        ID3v1Tag.LoadFromFile(FileName);
    except
        //* Error
    end;
    try
        ID3v2Tag.LoadFromFile(FileName);
    except
        //* Error
    end;
    try
        MP4Tag.LoadFromFile(FileName);
    except
        //* Error
    end;
    try
        OggVorbisAndOpusTag.LoadFromFile(FileName);
    except
        //* Error
    end;
    try
        WAVTag.LoadFromFile(FileName);
    except
        //* Error
    end;
    {$IFDEF MSWINDOWS}
    //* WMA tag also loads ID3v2 tags, so avoid reading it twice
    try
        if NOT ID3v2Tag.Loaded then begin
            WMATag.LoadFromFile(FileName);
        end;
    except
        //* Error
    end;
    {$ENDIF}
    //* Load WavPack audio attributes
    if ParseWavPackAudioAttributes then begin
        if Fext = '.WV' then begin
            SourceAudioAttributes.WAVPackAttributes := TWAVPackfile.Create;
            SourceAudioAttributes.WAVPackAttributes.LoadFromFile(FileName, APEv2Tag.Size);
            if NOT SourceAudioAttributes.WAVPackAttributes.Valid then begin
                FreeAndNil(SourceAudioAttributes.WAVPackAttributes);
            end;
        end;
    end;
    //* Load MusePack audio attributes
    if ParseMusePackAudioAttributes then begin
        if Fext = '.MPC' then begin
            SourceAudioAttributes.MusePackAttributes := TMPEGplus.Create;
            TagsSize := APEv2Tag.Size;
            if ID3v1Tag.Loaded then begin
                Inc(TagsSize, 128);
            end;
            SourceAudioAttributes.MusePackAttributes.LoadFromFile(FileName, ID3v2Tag.Size, TagsSize);
            if NOT SourceAudioAttributes.MusePackAttributes.Valid then begin
                FreeAndNil(SourceAudioAttributes.MusePackAttributes);
            end;
        end;
    end;
    Self.FileName := FileName;
    Loaded := APEv2Tag.Loaded
        OR FlacTag.Loaded
        OR ID3v1Tag.Loaded
        OR ID3v2Tag.Loaded
        OR MP4Tag.Loaded
        OR OggVorbisAndOpusTag.Loaded
        {$IFDEF MSWINDOWS}
        OR WMATag.Loaded
        {$ENDIF}
        OR WAVTag.Loaded;
    LoadTags;
    Result := TAGSLIBRARY_SUCCESS;
end;

function TTags.LoadFromMemory(Address: Pointer; Size: NativeInt): Integer;
var
    Stream: TReadMemoryStream;
begin
    if NOT Assigned(Address)
    OR (Size < 1)
    then begin
        Result := TAGSLIBRARY_ERROR_FILENOTFOUND;
        Exit;
    end;
    Stream := TReadMemoryStream.Create(Address, Size);
    try
        Result := LoadFromStream(Stream);
    finally
        FreeAndNil(Stream);
    end;
end;

function TTags.LoadFromStream(Stream: TStream): Integer;
var
    TagsSize: Integer;
begin
    Clear;
    Loaded := False;
    if Stream.Size = 0 then begin
        Result := TAGSLIBRARY_ERROR_OPENING_FILE;
        Exit;
    end;
    try
        Stream.Seek(0, soBeginning);
        APEv2Tag.LoadFromStream(Stream);
    except
        //* Error
    end;
    try
        Stream.Seek(0, soBeginning);
        FlacTag.LoadFromStream(Stream);
    except
        //* Error
    end;
    try
        Stream.Seek(0, soBeginning);
        ID3v1Tag.LoadFromStream(Stream);
    except
        //* Error
    end;
    try
        Stream.Seek(0, soBeginning);
        ID3v2Tag.LoadFromStream(Stream);
    except
        //* Error
    end;
    try
        Stream.Seek(0, soBeginning);
        MP4Tag.LoadFromStream(Stream);
    except
        //* Error
    end;
    try
        Stream.Seek(0, soBeginning);
        OggVorbisAndOpusTag.LoadFromStream(Stream);
    except
        //* Error
    end;
    try
        Stream.Seek(0, soBeginning);
        WAVTag.LoadFromStream(Stream);
    except
        //* Error
    end;
    {$IFDEF MSWINDOWS}
    //* Not supported
    {
    //* WMA tag also loads ID3v2 tags, so avoid reading it twice
    if NOT ID3v2Tag.Loaded then begin
        WMATag.LoadFromFile(FileName);
    end;
    }
    {$ENDIF}
    //* Load WavPack audio attributes
    if ParseWavPackAudioAttributes then begin
        SourceAudioAttributes.WAVPackAttributes := TWAVPackfile.Create;
        Stream.Seek(0, soBeginning);
        SourceAudioAttributes.WAVPackAttributes.LoadFromStream(Stream, APEv2Tag.Size);
        if NOT SourceAudioAttributes.WAVPackAttributes.Valid then begin
            FreeAndNil(SourceAudioAttributes.WAVPackAttributes);
        end;
    end;
    //* Load MusePack audio attributes
    if ParseMusePackAudioAttributes then begin
        SourceAudioAttributes.MusePackAttributes := TMPEGplus.Create;
        TagsSize := APEv2Tag.Size;
        if ID3v1Tag.Loaded then begin
            Inc(TagsSize, 128);
        end;
        Stream.Seek(0, soBeginning);
        SourceAudioAttributes.MusePackAttributes.LoadFromStream(Stream, ID3v2Tag.Size, TagsSize);
        if NOT SourceAudioAttributes.MusePackAttributes.Valid then begin
            FreeAndNil(SourceAudioAttributes.MusePackAttributes);
        end;
    end;
    Self.FileName := '';
    Loaded := APEv2Tag.Loaded
        OR FlacTag.Loaded
        OR ID3v1Tag.Loaded
        OR ID3v2Tag.Loaded
        OR MP4Tag.Loaded
        OR OggVorbisAndOpusTag.Loaded
        {$IFDEF MSWINDOWS}
        OR WMATag.Loaded
        {$ENDIF}
        OR WAVTag.Loaded;
    LoadTags;
    Result := TAGSLIBRARY_SUCCESS;
end;

procedure TTags.LoadTags;
var
    i: Integer;
begin
    for i := High(TagLoadPriority) downto Low(TagLoadPriority) do begin
        if TagLoadPriority[i] = ttID3v1 then begin
            if ID3v1Tag.Loaded then begin
                LoadID3v1Tags;
            end;
        end;
        if TagLoadPriority[i] = ttWAV then begin
            if WAVTag.Loaded then begin
                LoadWAVTags;
            end;
        end;
        if TagLoadPriority[i] = ttAPEv2 then begin
            if APEv2Tag.Loaded then begin
                LoadAPEv2Tags;
            end;
        end;
        if TagLoadPriority[i] = ttOpusVorbis then begin
            if OggVorbisAndOpusTag.Loaded then begin
                LoadOggVorbisAndOpusTags;
            end;
        end;
        {$IFDEF MSWINDOWS}
        if TagLoadPriority[i] = ttWMA then begin
            if WMATag.Loaded then begin
                LoadWMATags;
            end;
        end;
        {$ENDIF}
        if TagLoadPriority[i] = ttMP4 then begin
            if MP4Tag.Loaded then begin
                LoadMP4Tags;
            end;
        end;
        if TagLoadPriority[i] = ttID3v2 then begin
            if ID3v2Tag.Loaded then begin
                LoadID3v2Tags;
            end;
        end;
        if TagLoadPriority[i] = ttFlac then begin
            if FlacTag.Loaded then begin
                LoadFlacTags;
            end;
        end;
    end;
end;

procedure TTags.LoadAPEv2Tags;
var
    i, k: Integer;
    APEv2PictureFormat: TAPEv2PictureFormat;
    List: TStrings;
begin
    //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
    for i := 0 to APEv2Tag.Count - 1 do begin
        if APEv2Tag.Frames[i].Format = APEv2Library.ffText then begin
            for k := Count - 1 downto 0 do begin
                if SameText(Tags[k].Name, APEv2Tag.Frames[i].Name) then begin
                    Tags[k].Remove;
                end;
            end;
        end;
    end;
    //* If we have cover art delete any exisitng cover arts (so tag type priority decides which cover arts are actually loaded)
    for i := 0 to APEv2Tag.Count - 1 do begin
        if APEv2Tag.Frames[i].IsCoverArt then begin
            DeleteAllCoverArts;
            Break;
        end;
    end;
    //* Load the tags
    for i := 0 to APEv2Tag.Count - 1 do begin
        if i >= APEv2Tag.Count then begin
            Break;
        end;
        if APEv2Tag.Frames[i].Format = APEv2Library.ffText then begin
            if (SameText(APEv2Tag.Frames[i].Name, 'TRACKNUMBER') OR SameText(APEv2Tag.Frames[i].Name, 'TRACK'))
            AND (Pos('/', APEv2Tag.Frames[i].GetAsText) > 0)
            then begin
                Add('TRACKNUMBER').Value := Copy(APEv2Tag.Frames[i].GetAsText, 1, Pos('/', APEv2Tag.Frames[i].GetAsText) - 1);
                Delete(Exists('TOTALTRACKS'));
                Add('TOTALTRACKS').Value := Copy(APEv2Tag.Frames[i].GetAsText, Pos('/', APEv2Tag.Frames[i].GetAsText) + 1, Length(APEv2Tag.Frames[i].GetAsText));
            end else if SameText(APEv2Tag.Frames[i].Name, 'TIPL')
            OR SameText(APEv2Tag.Frames[i].Name, 'TMCL')
            then begin
                List := TStringList.Create;
                try
                    APEv2Tag.Frames[i].GetAsList(List);
                    Add(APEv2Tag.Frames[i].Name).Value := List.Text;
                finally
                    FreeAndNil(List);
                end;
            end else begin
                Add(APEv2Tag.Frames[i].Name).Value := APEv2Tag.Frames[i].GetAsText;
            end;
        end;
        //* Load cover arts
        if APEv2Tag.Frames[i].IsCoverArt then begin
            with AddCoverArt(APEv2Tag.Frames[i].Name) do begin
                APEv2Tag.GetCoverArtFromFrame(i, Stream, APEv2PictureFormat, Description);
                case APEv2PictureFormat of
                    APEv2Library.pfUnknown: begin
                        MIMEType := '';
                        PictureFormat := tpfUnknown;
                    end;
                    APEv2Library.pfJPEG: begin
                        MIMEType := 'image/jpeg';
                        PictureFormat := tpfJPEG;
                    end;
                    APEv2Library.pfPNG: begin
                        MIMEType := 'image/png';
                        PictureFormat := tpfPNG;
                    end;
                    APEv2Library.pfBMP: begin
                        MIMEType := 'image/bmp';
                        PictureFormat := tpfBMP;
                    end;
                    APEv2Library.pfGIF: begin
                        MIMEType := 'image/gif';
                        PictureFormat := tpfGIF;
                    end;
                end;
                CoverType := 3;
            end;
        end;
    end;
end;

procedure TTags.LoadFlacTags;
var
    i, k: Integer;
    CoverArtInfo: TFlacTagCoverArtInfo;
    List: TStrings;
begin
    //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
    for i := 0 to FlacTag.Count - 1 do begin
        if FlacTag.Tags[i].Format = FlacTagLibrary.vcfText then begin
            for k := Count - 1 downto 0 do begin
                if SameText(Tags[k].Name, FlacTag.Tags[i].Name) then begin
                    Tags[k].Remove;
                end;
            end;
        end;
    end;
    //* If we have cover art delete any exisitng cover arts (so tag type priority decides which cover arts are actually loaded)
    if FlacTag.CoverArtCount > 0 then begin
        DeleteAllCoverArts;
    end;
    //* Load the tags
    for i := 0 to FlacTag.Count - 1 do begin
        if i >= FlacTag.Count then begin
            Break;
        end;
        if FlacTag.Tags[i].Format = FlacTagLibrary.vcfText then begin
            if (SameText(FlacTag.Tags[i].Name, 'TRACKNUMBER') OR SameText(FlacTag.Tags[i].Name, 'TRACK'))
            AND (Pos('/', FlacTag.Tags[i].GetAsText) > 0)
            then begin
                Add('TRACKNUMBER').Value := Copy(FlacTag.Tags[i].GetAsText, 1, Pos('/', FlacTag.Tags[i].GetAsText) - 1);
                Delete(Exists('TOTALTRACKS'));
                Add('TOTALTRACKS').Value := Copy(FlacTag.Tags[i].GetAsText, Pos('/', FlacTag.Tags[i].GetAsText) + 1, Length(FlacTag.Tags[i].GetAsText));
            end else if SameText(FlacTag.Tags[i].Name, 'TIPL')
            OR SameText(FlacTag.Tags[i].Name, 'TMCL')
            then begin
                List := TStringList.Create;
                try
                    FlacTag.Tags[i].GetAsList(List);
                    Add(FlacTag.Tags[i].Name).Value := List.Text;
                finally
                    FreeAndNil(List);
                end;
            end else begin
                Add(FlacTag.Tags[i].Name).Value := FlacTag.Tags[i].GetAsText;
            end;
        end;
    end;
    //* Load the cover arts
    for i := 0 to FlacTag.CoverArtCount - 1 do begin
        with AddCoverArt('Cover art ' + IntToStr(i + 1)) do begin
            FlacTag.GetCoverArt(i, Stream, CoverArtInfo);
            CoverType := CoverArtInfo.PictureType;
            MIMEType := CoverArtInfo.MIMEType;
            Description := CoverArtInfo.Description;
            Width := CoverArtInfo.Width;
            Height := CoverArtInfo.Height;
            ColorDepth := CoverArtInfo.ColorDepth;
            NoOfColors := CoverArtInfo.NoOfColors;
            PictureFormat := PictureStreamType(Stream);
        end;
    end;
end;

procedure TTags.LoadOggVorbisAndOpusTags;
var
    i, k: Integer;
    CoverArtInfo: TOpusVorbisCoverArtInfo;
    List: TStrings;
begin
    //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
    for i := 0 to OggVorbisAndOpusTag.Count - 1 do begin
        if OggVorbisAndOpusTag.Frames[i].Format = OggVorbisAndOpusTagLibrary.otffText then begin
            for k := Count - 1 downto 0 do begin
                if SameText(Tags[k].Name, OggVorbisAndOpusTag.Frames[i].Name) then begin
                    Tags[k].Remove;
                end;
            end;
        end;
    end;
    //* If we have cover art delete any exisitng cover arts (so tag type priority decides which cover arts are actually loaded)
    for i := 0 to OggVorbisAndOpusTag.Count - 1 do begin
        if OggVorbisAndOpusTag.Frames[i].IsCoverArt then begin
            DeleteAllCoverArts;
            Break;
        end;
    end;
    //* Load the tags
    for i := 0 to OggVorbisAndOpusTag.Count - 1 do begin
        if i >= OggVorbisAndOpusTag.Count then begin
            Break;
        end;
        if OggVorbisAndOpusTag.Frames[i].Format = OggVorbisAndOpusTagLibrary.otffText then begin
            if (SameText(OggVorbisAndOpusTag.Frames[i].Name, 'TRACKNUMBER') OR SameText(OggVorbisAndOpusTag.Frames[i].Name, 'TRACK'))
            AND (Pos('/', OggVorbisAndOpusTag.Frames[i].GetAsText) > 0)
            then begin
                Add('TRACKNUMBER').Value := Copy(OggVorbisAndOpusTag.Frames[i].GetAsText, 1, Pos('/', OggVorbisAndOpusTag.Frames[i].GetAsText) - 1);
                Delete(Exists('TOTALTRACKS'));
                Add('TOTALTRACKS').Value := Copy(OggVorbisAndOpusTag.Frames[i].GetAsText, Pos('/', OggVorbisAndOpusTag.Frames[i].GetAsText) + 1, Length(OggVorbisAndOpusTag.Frames[i].GetAsText));
            end else if SameText(OggVorbisAndOpusTag.Frames[i].Name, 'TIPL')
            OR SameText(OggVorbisAndOpusTag.Frames[i].Name, 'TMCL')
            then begin
                List := TStringList.Create;
                try
                    OggVorbisAndOpusTag.Frames[i].GetAsList(List);
                    Add(OggVorbisAndOpusTag.Frames[i].Name).Value := List.Text;
                finally
                    FreeAndNil(List);
                end;
            end else begin
                Add(OggVorbisAndOpusTag.Frames[i].Name).Value := OggVorbisAndOpusTag.Frames[i].GetAsText;
            end;
        end;
        //* Load cover art
        if OggVorbisAndOpusTag.Frames[i].IsCoverArt then begin
            with AddCoverArt(OggVorbisAndOpusTag.Frames[i].Name) do begin
                OggVorbisAndOpusTag.GetCoverArtFromFrame(i, Stream, CoverArtInfo);
                CoverType := CoverArtInfo.PictureType;
                MIMEType := CoverArtInfo.MIMEType;
                Description := CoverArtInfo.Description;
                Width := CoverArtInfo.Width;
                Height := CoverArtInfo.Height;
                ColorDepth := CoverArtInfo.ColorDepth;
                NoOfColors := CoverArtInfo.NoOfColors;
                PictureFormat := PictureStreamType(Stream);
            end;
        end;
    end;
end;

procedure TTags.LoadID3v1Tags;
var
    i: Integer;
begin
    //* Load the tags
    if ID3v1Tag.Title <> '' then begin
        //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
        for i := Count - 1 downto 0 do begin
            if SameText(Tags[i].Name, 'TITLE') then begin
                Tags[i].Remove;
            end;
        end;
        //* Add the new tag
        Add('TITLE').Value := ID3v1Tag.Title;
    end;
    if ID3v1Tag.Artist <> '' then begin
        //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
        for i := Count - 1 downto 0 do begin
            if SameText(Tags[i].Name, 'ARTIST') then begin
                Tags[i].Remove;
            end;
        end;
        //* Add the new tag
        Add('ARTIST').Value := ID3v1Tag.Artist;
    end;
    if ID3v1Tag.Album <> '' then begin
        //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
        for i := Count - 1 downto 0 do begin
            if SameText(Tags[i].Name, 'ALBUM') then begin
                Tags[i].Remove;
            end;
        end;
        //* Add the new tag
        Add('ALBUM').Value := ID3v1Tag.Album;
    end;
    if ID3v1Tag.Year <> '' then begin
        //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
        for i := Count - 1 downto 0 do begin
            if SameText(Tags[i].Name, 'YEAR') then begin
                Tags[i].Remove;
            end;
        end;
        //* Add the new tag
        Add('YEAR').Value := ID3v1Tag.Year;
    end;
    if ID3v1Tag.Comment <> '' then begin
        //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
        for i := Count - 1 downto 0 do begin
            if SameText(Tags[i].Name, 'COMMENT') then begin
                Tags[i].Remove;
            end;
        end;
        //* Add the new tag
        Add('COMMENT').Value := ID3v1Tag.Comment;
    end;
    if ID3v1Tag.Track <> 0 then begin
        //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
        for i := Count - 1 downto 0 do begin
            if SameText(Tags[i].Name, 'TRACKNUMBER')
            OR SameText(Tags[i].Name, 'TRACK')
            then begin
                Tags[i].Remove;
            end;
        end;
        //* Add the new tag
        Add('TRACKNUMBER').Value := IntToStr(ID3v1Tag.Track);
    end;
    if ID3v1Tag.Genre <> '' then begin
        //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
        for i := Count - 1 downto 0 do begin
            if SameText(Tags[i].Name, 'GENRE') then begin
                Tags[i].Remove;
            end;
        end;
        //* Add the new tag
        Add('GENRE').Value := ID3v1Tag.Genre;
    end;
    //* TODO: is this needed or needs enhancement?
    {
    for i := 0 to Length(ID3v1Tag.LyricsFrames) - 1 do begin
        Add(ID3v1Tag.LyricsFrames[i].ID).Value := ID3v1Tag.LyricsFrames[i].Data;
    end;
    }
    Self.Loaded := True;
end;

procedure TTags.LoadID3v2Tags;
var
    i, k: Integer;
    FieldName: String;
    Description: String;
    ID3v2Value: String;
    CoverArtType: Integer;
    ID3v2FrameType: TID3v2FrameType;
    LanguageID: TLanguageID;
    ID3v2Description: String;
    MuitpleValues: TStrings;
    EMail: String;
    Rating: Byte;
    PlayCounter: Cardinal;
begin
    ID3v2Tag.RemoveUnsynchronisationOnAllFrames;
    //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
    for i := 0 to ID3v2Tag.FrameCount - 1 do begin
        FieldName := ID3v2FrameIDToFieldName(ID3v2Tag.Frames[i].ID);
        if FieldName <> '' then begin
            for k := Count - 1 downto 0 do begin
                if SameText(Tags[k].Name, FieldName) then begin
                    Tags[k].Remove;
                end;
            end;
        end else begin
            if IsSameFrameID(ID3v2Tag.Frames[i].ID, 'TXXX') then begin
                ID3v2Tag.GetUnicodeUserDefinedTextInformation(i, Description);
                for k := Count - 1 downto 0 do begin
                    if SameText(Tags[k].Name, Description) then begin
                        Tags[k].Remove;
                    end;
                end;
            end;
            if IsSameFrameID(ID3v2Tag.Frames[i].ID, 'WXXX') then begin
                ID3v2Tag.GetUnicodeUserDefinedURLLink(i, Description);
                for k := Count - 1 downto 0 do begin
                    if SameText(Tags[k].Name, Description) then begin
                        Tags[k].Remove;
                    end;
                end;
            end;
        end;
    end;
    //* If we have cover art delete any exisitng cover arts (so tag type priority decides which cover arts are actually loaded)
    if ID3v2Tag.FrameTypeCount('APIC') > 0 then begin
        DeleteAllCoverArts;
    end;
    //* Load the tags
    MuitpleValues := TStringList.Create;
    try
        for i := 0 to ID3v2Tag.FrameCount - 1 do begin
            if i >= ID3v2Tag.FrameCount then begin
                Break;
            end;
            FieldName := ID3v2FrameIDToFieldName(ID3v2Tag.Frames[i].ID);
            if FieldName <> '' then begin
                ID3v2Value := '';
                ID3v2Description := '';
                FillChar(LanguageID, SizeOf(TLanguageID), 0);
                MuitpleValues.Clear;
                ID3v2FrameType := GetID3v2FrameType(ID3v2Tag.Frames[i].ID);
                case ID3v2FrameType of
                    ftUnknown: {ID3v2Value :=} ID3v2Tag.GetUnicodeTextMultiple(i, MuitpleValues);
                    ftText: {ID3v2Value :=} ID3v2Tag.GetUnicodeTextMultiple(i, MuitpleValues);
                    ftTextList: begin
                        ID3v2Tag.GetUnicodeListFrame(i, MuitpleValues);
                        ID3v2Value := MuitpleValues.Text;
                        MuitpleValues.Clear;
                    end;
                    ftTextWithDescription: {ID3v2Value :=} ID3v2Tag.GetUnicodeUserDefinedTextInformationMultiple(i, ID3v2Description, MuitpleValues);
                    ftTextWithDescriptionAndLangugageID: ID3v2Value := ID3v2Tag.GetUnicodeContent(i, LanguageID, ID3v2Description);
                    ftURL: ID3v2Value := ID3v2Tag.GetURL(i);
                    ftUserDefinedURL: ID3v2Value := ID3v2Tag.GetUnicodeUserDefinedURLLink(i, ID3v2Description);
                else ID3v2Value := ID3v2Tag.GetUnicodeText(i)
                end;
                if (SameText(FieldName, 'TRACKNUMBER') OR SameText(FieldName, 'TRACK'))
                AND (Pos('/', ID3v2Value) > 0)
                then begin
                    Add('TRACKNUMBER').Value := Copy(ID3v2Value, 1, Pos('/', ID3v2Value) - 1);
                    Delete(Exists('TOTALTRACKS'));
                    Add('TOTALTRACKS').Value := Copy(ID3v2Value, Pos('/', ID3v2Value) + 1, Length(ID3v2Value));
                end else if (SameText(FieldName, 'DISCNUMBER') OR SameText(FieldName, 'DISC'))
                    AND (Pos('/', ID3v2Value) > 0)
                    then begin
                        Add('DISCNUMBER').Value := Copy(ID3v2Value, 1, Pos('/', ID3v2Value) - 1);
                        Delete(Exists('TOTALDISCS'));
                        Add('TOTALDISCS').Value := Copy(ID3v2Value, Pos('/', ID3v2Value) + 1, Length(ID3v2Value));
                    end else begin
                        if MuitpleValues.Count > 0 then begin
                            for k := 0 to MuitpleValues.Count - 1 do begin
                                with Add(FieldName) do begin
                                    Value := MuitpleValues[k];
                                    Description := ID3v2Description;
                                    Language := LanguageIDtoString(LanguageID);
                                end;
                            end;
                        end else begin
                            with Add(FieldName) do begin
                                Value := ID3v2Value;
                                Description := ID3v2Description;
                                Language := LanguageIDtoString(LanguageID);
                            end;
                        end;
                    end;
            end else begin
                if IsSameFrameID(ID3v2Tag.Frames[i].ID, 'TXXX') then begin
                    {ID3v2Value :=} ID3v2Tag.GetUnicodeUserDefinedTextInformationMultiple(i, ID3v2Description, MuitpleValues);
                    if (MuitpleValues.Count > 0)
                    AND (ID3v2Description <> '')
                    then begin
                        for k := 0 to MuitpleValues.Count - 1 do begin
                            if Trim(MuitpleValues[k]) <> '' then begin
                                with Add(ID3v2Description) do begin
                                    Value := MuitpleValues[k];
                                    Description := ID3v2Description;
                                    ExtTagType := ettTXXX;
                                end;
                            end;
                        end;
                    end;
                end;
                if IsSameFrameID(ID3v2Tag.Frames[i].ID, 'WXXX') then begin
                    ID3v2Value := ID3v2Tag.GetUnicodeUserDefinedURLLink(i, ID3v2Description);
                    if (ID3v2Value <> '')
                    AND (ID3v2Description <> '')
                    then begin
                        if ID3v2Description <> '' then begin
                            with Add(ID3v2Description)do begin
                                Value := ID3v2Value;
                                Description := ID3v2Description;
                                ExtTagType := ettWXXX;
                            end;
                        end else begin
                            with Add('URL') do begin
                                Value := ID3v2Value;
                                ExtTagType := ettWXXX;
                            end;
                        end;
                    end;
                end;
                if IsSameFrameID(ID3v2Tag.Frames[i].ID, 'APIC') then begin
                    with AddCoverArt('Cover art ' + IntToStr(CoverArtCount + 1)) do begin
                        ID3v2Tag.GetUnicodeCoverPictureStream(i, Stream, MIMEType, ID3v2Description, CoverArtType);
                        CoverType := CoverArtType;
                        MIMEType := MIMEType;
                        Description := ID3v2Description;
                        PictureFormat := PictureStreamType(Stream);
                    end;
                end;
                if IsSameFrameID(ID3v2Tag.Frames[i].ID, 'PCNT') then begin
                    with Add('PLAYCOUNT') do begin
                        Value := IntToStr(ID3v2Tag.GetPlayCount(i));
                    end;
                end;
                if IsSameFrameID(ID3v2Tag.Frames[i].ID, 'POPM') then begin
                    ID3v2Tag.GetPopularimeter(i, EMail, Rating, PlayCounter);
                    with Add('RATING') do begin
                        Value := IntToStr(Rating);
                    end;
                end;
            end;
        end;
    finally
        FreeAndNil(MuitpleValues);
    end;
    Self.Loaded := True;
end;

procedure TTags.LoadMP4Tags;
var
    i, k: Integer;
    FieldName: String;
    List: TStrings;
begin
    //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
    for i := 0 to MP4Tag.Count - 1 do begin
        FieldName := MP4AtomNameToFieldName(MP4Tag.Atoms[i].ID);
        if FieldName <> '' then begin
            for k := Count - 1 downto 0 do begin
                if SameText(Tags[k].Name, FieldName) then begin
                    Tags[k].Remove;
                end;
            end;
        end;
    end;
    //* If we have cover art delete any exisitng cover arts (so tag type priority decides which cover arts are actually loaded)
    if MP4Tag.FindAtom('covr') <> nil then begin
        DeleteAllCoverArts;
    end;
    //* Load the tags
    for i := 0 to MP4Tag.Count - 1 do begin
        FieldName := MP4AtomNameToFieldName(MP4Tag.Atoms[i].ID);
        if FieldName <> '' then begin
            if SameText(FieldName, 'TIPL')
            OR SameText(FieldName, 'TMCL')
            then begin
                List := TStringList.Create;
                try
                    MP4Tag.Atoms[i].GetAsList(List);
                    Add(AtomNameToString(MP4Tag.Atoms[i].ID)).Value := List.Text;
                finally
                    FreeAndNil(List);
                end;
            end else begin
                Add(FieldName).Value := MP4Tag.Atoms[i].GetAsText;
            end;
        end else begin
            if IsSameAtomName(MP4Tag.Atoms[i].ID, 'covr') then begin
                for k := 0 to Length(MP4Tag.Atoms[i].Datas) - 1 do begin
                    with AddCoverArt('Cover art ' + IntToStr(k + 1)) do begin
                        //* Position should be at start, just to be sure
                        MP4Tag.Atoms[i].Datas[k].Data.Seek(0, soBeginning);
                        //* Datas[0] means the first cover stream
                        Stream.CopyFrom(MP4Tag.Atoms[i].Datas[k].Data, 0);
                        PictureFormat := PictureStreamType(Stream);
                        if PictureFormat = tpfJPEG then begin
                            MIMEType := 'image/jpeg';
                        end;
                        if PictureFormat = tpfPNG then begin
                            MIMEType := 'image/png';
                        end;
                        if PictureFormat = tpfGIF then begin
                            MIMEType := 'image/gif';
                        end;
                        if PictureFormat = tpfBMP then begin
                            MIMEType := 'image/bmp';
                        end;
                        CoverType := 3;
                    end;
                end;
            end else if IsSameAtomName(MP4Tag.Atoms[i].ID, '----') then begin
                Add(MP4Tag.Atoms[i].name.GetAsText).Value := MP4Tag.Atoms[i].GetAsText;
            end;
        end;
    end;
    if MP4Tag.GetGenre <> '' then begin
        //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
        for i := Count - 1 downto 0 do begin
            if SameText(Tags[i].Name, 'GENRE') then begin
                Tags[i].Remove;
            end;
        end;
        //* Add the new tag
        Add('GENRE').Value := MP4Tag.GetGenre;
    end;
    if MP4Tag.GetMediaType <> '' then begin
        //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
        for i := Count - 1 downto 0 do begin
            if SameText(Tags[i].Name, 'MEDIA') then begin
                Tags[i].Remove;
            end;
        end;
        //* Add the new tag
        Add('MEDIA').Value := MP4Tag.GetMediaType;
    end;
    if MP4Tag.GetTrack <> 0 then begin
        //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
        for i := Count - 1 downto 0 do begin
            if SameText(Tags[i].Name, 'TRACKNUMBER')
            OR SameText(Tags[i].Name, 'TRACK')
            then begin
                Tags[i].Remove;
            end;
        end;
        //* Add the new tag
        Add('TRACKNUMBER').Value := IntToStr(MP4Tag.GetTrack);
    end;
    if MP4Tag.GetTotalTracks <> 0 then begin
        //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
        for i := Count - 1 downto 0 do begin
            if SameText(Tags[i].Name, 'TOTALTRACKS') then begin
                Tags[i].Remove;
            end;
        end;
        //* Add the new tag
        Add('TOTALTRACKS').Value := IntToStr(MP4Tag.GetTotalTracks);
    end;
    if MP4Tag.GetDisc <> 0 then begin
        //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
        for i := Count - 1 downto 0 do begin
            if SameText(Tags[i].Name, 'DISCNUMBER')
            OR SameText(Tags[i].Name, 'DISC')
            then begin
                Tags[i].Remove;
            end;
        end;
        //* Add the new tag
        Add('DISCNUMBER').Value := IntToStr(MP4Tag.GetDisc);
    end;
    if MP4Tag.GetTotalDiscs <> 0 then begin
        //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
        for i := Count - 1 downto 0 do begin
            if SameText(Tags[i].Name, 'TOTALDISCS') then begin
                Tags[i].Remove;
            end;
        end;
        //* Add the new tag
        Add('TOTALDISCS').Value := IntToStr(MP4Tag.GetTotalDiscs);
    end;
    if MP4Tag.GetPurchaseCountry <> '' then begin
        //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
        for i := Count - 1 downto 0 do begin
            if SameText(Tags[i].Name, 'PURCHASECOUNTRY') then begin
                Tags[i].Remove;
            end;
        end;
        //* Add the new tag
        Add('PURCHASECOUNTRY').Value := MP4Tag.GetPurchaseCountry;
    end;
    Self.Loaded := True;
end;

procedure TTags.LoadWAVTags;
var
    i, k: Integer;
    FieldName: String;
    CART_TIMERS: TTAG_CART_TIMERS;
    CART_TIMER: TCART_TIMER;
    List: TStrings;
begin
    //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
    for i := 0 to WAVTag.Count - 1 do begin
        FieldName := WAVChunkIDToFieldName(WAVTag.Frames[i].Name);
        if FieldName <> '' then begin
            for k := Count - 1 downto 0 do begin
                if SameText(Tags[k].Name, FieldName) then begin
                    Tags[k].Remove;
                end;
            end;
        end;
    end;
    //* Load the tags
    for i := 0 to WAVTag.Count - 1 do begin
        if i >= WAVTag.Count then begin
            Break;
        end;
        FieldName := WAVChunkIDToFieldName(WAVTag.Frames[i].Name);
        if FieldName <> '' then begin
            if (SameText(FieldName, 'TRACKNUMBER') OR SameText(FieldName, 'TRACK'))
            AND (Pos('/', WAVTag.Frames[i].GetAsText) > 0)
            then begin
                Add('TRACKNUMBER').Value := Copy(WAVTag.Frames[i].GetAsText, 1, Pos('/', WAVTag.Frames[i].GetAsText) - 1);
                Delete(Exists('TOTALTRACKS'));
                Add('TOTALTRACKS').Value := Copy(WAVTag.Frames[i].GetAsText, Pos('/', WAVTag.Frames[i].GetAsText) + 1, Length(WAVTag.Frames[i].GetAsText));
            end else if SameText(WAVTag.Frames[i].Name, 'TIPL')
            OR SameText(WAVTag.Frames[i].Name, 'TMCL')
            then begin
                List := TStringList.Create;
                try
                    WAVTag.Frames[i].GetAsList(List);
                    Add(WAVTag.Frames[i].Name).Value := List.Text;
                finally
                    FreeAndNil(List);
                end;
            end else begin
                Add(FieldName).Value := WAVTag.Frames[i].GetAsText;
            end;
        end;
    end;
    //* Load BEXT tags
    if WAVTag.BEXT.Loaded then begin
        Add(BEXT_Description).Value := WAVTag.BEXT.Description;
        Add(BEXT_Originator).Value := WAVTag.BEXT.Originator;
        Add(BEXT_OriginatorReference).Value := WAVTag.BEXT.OriginatorReference;
        Add(BEXT_OriginationDate).Value := WAVTag.BEXT.OriginationDate;
        Add(BEXT_OriginationTime).Value := WAVTag.BEXT.OriginationTime;
        Add(BEXT_TimeReference).Value := IntToStr(WAVTag.BEXT.TimeReference);
        Add(BEXT_Version).Value := IntToStr(WAVTag.BEXT.Version);
        Add(BEXT_UMID).Value := WAVTag.BEXT.UMID;
        Add(BEXT_CodingHistory).Value := WAVTag.BEXT.CodingHistory;
    end;
    //* Load CART tags
    if WAVTag.CART.Loaded then begin
        Add(CART_Version).Value := WAVTag.CART.Version;
        Add(CART_Title).Value := WAVTag.CART.Title;
        Add(CART_Artist).Value := WAVTag.CART.Artist;
        Add(CART_CutID).Value := WAVTag.CART.CutID;
        Add(CART_ClientID).Value := WAVTag.CART.ClientID;
        Add(CART_Category).Value := WAVTag.CART.Category;
        Add(CART_Classification).Value := WAVTag.CART.Classification;
        Add(CART_OutCue).Value := WAVTag.CART.OutCue;
        Add(CART_StartDate).Value := WAVTag.CART.StartDate;
        Add(CART_StartTime).Value := WAVTag.CART.StartTime;
        Add(CART_EndDate).Value := WAVTag.CART.EndDate;
        Add(CART_EndTime).Value := WAVTag.CART.EndTime;
        Add(CART_ProducerAppID).Value := WAVTag.CART.ProducerAppID;
        Add(CART_ProducerAppVersion).Value := WAVTag.CART.ProducerAppVersion;
        Add(CART_UserDef).Value := WAVTag.CART.UserDef;
        Add(CART_LevelReference).Value := IntToStr(WAVTag.CART.LevelReference);
        CART_TIMERS := WAVTag.CART.PostTimer;
        for i := 0 to High(CART_TIMERS) do begin
            WAVTag.CART.GetPostTimer(i, CART_TIMER);
            Add(CART_PostTimer + IntToStr(i)).Value := CART_TIMER.Usage + ' ' + IntToStr(CART_TIMER.Value);
        end;
        Add(CART_URL).Value := WAVTag.CART.URL;
        Add(CART_Reserved).Value := WAVTag.CART.Reserved;
        Add(CART_TagText).Value := WAVTag.CART.TagText;
    end;
    Self.Loaded := True;
end;

{$IFDEF MSWINDOWS}
procedure TTags.LoadWMATags;
var
    i, k: Integer;
    FieldName: String;
    CoverArtType: Byte;
    List: TStrings;
begin
    //* Delete any exisitng same tag (so tag type priority decides which tags are actually loaded)
    for i := 0 to WMATag.Count - 1 do begin
        FieldName := WMATagIDToFieldName(WMATag.Frames[i].Name);
        if FieldName <> '' then begin
            for k := Count - 1 downto 0 do begin
                if SameText(Tags[k].Name, FieldName) then begin
                    Tags[k].Remove;
                end;
            end;
        end;
    end;
    //* If we have cover art delete any exisitng cover arts (so tag type priority decides which cover arts are actually loaded)
    for i := 0 to WMATag.Count - 1 do begin
        if WMATag.Frames[i].Name = g_wszWMPicture then begin
            DeleteAllCoverArts;
            Break;
        end;
    end;
    //* Load the tags
    for i := 0 to WMATag.Count - 1 do begin
        if i >= WMATag.Count then begin
            Break;
        end;
        FieldName := WMATagIDToFieldName(WMATag.Frames[i].Name);
        if WMATag.Frames[i].Name = g_wszWMTrack then begin
            if Exists('TRACKNUMBER') = - 1 then begin
                Add('TRACKNUMBER').Value := IntToStr(StrToIntDef(WMATag.Frames[i].GetAsText, 0) + 1);
            end;
        end else if (WMATag.Frames[i].Name = g_wszWMInvolvedPeople)
        OR (WMATag.Frames[i].Name = g_wszWMMusicianCredits)
        then begin
            List := TStringList.Create;
            try
                WMATag.Frames[i].GetAsList(List);
                Add(WMATag.Frames[i].Name).Value := List.Text;
            finally
                FreeAndNil(List);
            end;
        end else begin
            if FieldName <> '' then begin
                if SameText(FieldName, 'TRACKNUMBER')
                AND (Pos('/', WMATag.Frames[i].GetAsText) > 0)
                then begin
                    Add('TRACKNUMBER').Value := Copy(WMATag.Frames[i].GetAsText, 1, Pos('/', WMATag.Frames[i].GetAsText) - 1);
                    Delete(Exists('TOTALTRACKS'));
                    Add('TOTALTRACKS').Value := Copy(WMATag.Frames[i].GetAsText, Pos('/', WMATag.Frames[i].GetAsText) + 1, Length(WMATag.Frames[i].GetAsText));
                end else if SameText(FieldName, 'DISCNUMBER')
                AND (Pos('/', WMATag.Frames[i].GetAsText) > 0)
                then begin
                    Add('DISCNUMBER').Value := Copy(WMATag.Frames[i].GetAsText, 1, Pos('/', WMATag.Frames[i].GetAsText) - 1);
                    Delete(Exists('TOTALDISCS'));
                    Add('TOTALDISCS').Value := Copy(WMATag.Frames[i].GetAsText, Pos('/', WMATag.Frames[i].GetAsText) + 1, Length(WMATag.Frames[i].GetAsText));
                end else begin
                    Add(FieldName).Value := WMATag.Frames[i].GetAsText;
                end;
            end;
            if WMATag.Frames[i].Name = g_wszWMPicture then begin
                with AddCoverArt('Cover art ' + IntToStr(CoverArtCount + 1)) do begin
                    WMATag.GetCoverArtFromFrame(i, Stream, MIMEType, CoverArtType , Description);
                    CoverType := CoverArtType;
                    PictureFormat := PictureStreamType(Stream);
                end;
            end;
        end;
    end;
    Self.Loaded := True;
end;
{$ENDIF}

procedure TTags.LoadNullTerminatedStrings(TagType: String; TagList: TStrings);
var
    i: Integer;
    CoverArtInfo: TOpusVorbisCoverArtInfo;
begin
    for i := 0 to TagList.Count - 1 do begin
        if TagList.Names[i] <> '' then begin
            if SameText(TagList.Names[i], OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE) then begin
                with AddCoverArt('Cover art ' + IntToStr(CoverArtCount + 1)) do begin
                    VorbisGetCoverArtFromFrame(TagList.ValueFromIndex[i], Stream, CoverArtInfo);
                    CoverType := CoverArtInfo.PictureType;
                    MIMEType := CoverArtInfo.MIMEType;
                    Description := CoverArtInfo.Description;
                    Width := CoverArtInfo.Width;
                    Height := CoverArtInfo.Height;
                    ColorDepth := CoverArtInfo.ColorDepth;
                    NoOfColors := CoverArtInfo.NoOfColors;
                    PictureFormat := PictureFormatFromMIMEType(MIMEType);
                end;
            end else begin
                Add(TagList.Names[i]).Value := TagList.ValueFromIndex[i];
            end;
        end else begin
            Add(TagType).Value := TagList[i];
        end;
        {
        FieldName := WAVChunkIDToFieldName(WAVTag.Frames[i].Name);
        if FieldName <> '' then begin
            if (FieldName = 'TRACKNUMBER')
            AND (Pos('/', WAVTag.Frames[i].GetAsText) > 0)
            then begin
                Add('TRACKNUMBER').Value := Copy(WAVTag.Frames[i].GetAsText, 1, Pos('/', WAVTag.Frames[i].GetAsText) - 1);
                Add('TOTALTRACKS').Value := Copy(WAVTag.Frames[i].GetAsText, Pos('/', WAVTag.Frames[i].GetAsText) + 1, Length(WAVTag.Frames[i].GetAsText));
            end else begin
                Add(FieldName).Value := WAVTag.Frames[i].GetAsText;
            end;
        end;
        }
    end;
    Self.Loaded := True;
end;

procedure TTags.LoadNullTerminatedWAVRIFFINFOStrings(TagList: TStrings);
var
    i: Integer;
begin
    Self.WAVTag.Clear;
    for i := 0 to TagList.Count - 1 do begin
        if TagList.Names[i] <> '' then begin
            with WAVTag.AddFrame(TagList.Names[i]) do begin
                SetAsText(TagList.ValueFromIndex[i]);
                Format := ffText;
            end;
        end;
    end;
    Self.WAVTag.Loaded := True;
    Self.Loaded := True;
end;

function TTags.Add(Name: String): TTag;
begin
    Result := nil;
    try
        SetLength(Tags, Length(Tags) + 1);
        Tags[Length(Tags) - 1] := TTag.Create(Self);
        Tags[Length(Tags) - 1].Name := Name;
        Tags[Length(Tags) - 1].Index := Length(Tags) - 1;
        Result := Tags[Length(Tags) - 1];
    except
        //*
    end;
end;

function TTags.Delete(Index: Integer): Boolean;
var
    i: Integer;
    j: Integer;
    FieldName: String;
    WMATagName: String;
    Text: String;
    Description: String;
    AtomName: String;
    Atom: TMP4Atom;
begin
    Result := False;
    if (Index >= Length(Tags))
    OR (Index < 0)
    then begin
        Exit;
    end;
    FieldName := UpperCase(Tags[Index].Name);
    //* Need to delete particular tag's field so that it's not re-saved on save
    for i := APEv2Tag.Count - 1 downto 0 do begin
        if SameText(Tags[Index].Name, FieldName)
        AND SameText(Tags[Index].Value, APEv2Tag.Frames[i].GetAsText)
        then begin
            APEv2Tag.DeleteFrame(i);
        end;
    end;
    for i := FlacTag.Count - 1 downto 0 do begin
        if SameText(Tags[Index].Name, FieldName)
        AND SameText(Tags[Index].Value, FlacTag.Tags[i].GetAsText)
        then begin
            FlacTag.DeleteFrame(i);
        end;
    end;
    for i := OggVorbisAndOpusTag.Count - 1 downto 0 do begin
        if SameText(Tags[Index].Name, FieldName)
        AND SameText(Tags[Index].Value, OggVorbisAndOpusTag.Frames[i].GetAsText)
        then begin
            OggVorbisAndOpusTag.DeleteFrame(i);
        end;
    end;
    if SameText(FieldName, 'TITLE') then begin
        ID3v1Tag.Title := '';
    end;
    if SameText(FieldName, 'ARTIST') then begin
        ID3v1Tag.Artist := '';
    end;
    if SameText(FieldName, 'ALBUM') then begin
        ID3v1Tag.Album := '';
    end;
    if SameText(FieldName, 'YEAR') then begin
        ID3v1Tag.Year := '';
    end;
    if SameText(FieldName, 'COMMENT') then begin
        ID3v1Tag.Comment := '';
    end;
    if SameText(FieldName, 'TRACKNUMBER')
    OR SameText(FieldName, 'TRACK')
    then begin
        ID3v1Tag.Track := 0;
    end;
    if SameText(FieldName, 'GENRE') then begin
        ID3v1Tag.Genre := '';
    end;
    if Tags[Index].ExtTagType = ettTXXX then begin
        for i := ID3v2Tag.FrameCount - 1 downto 0 do begin
            if IsSameFrameID(ID3v2Tag.Frames[i].ID, 'TXXX') then begin
                Text := ID3v2Tag.GetUnicodeUserDefinedTextInformation(i, Description);
                if SameText(Tags[Index].Name, Description)
                AND SameText(Tags[Index].Value, Text)
                then begin
                    ID3v2Tag.DeleteFrame(i);
                end;
            end;
        end;
    end else if Tags[Index].ExtTagType = ettWXXX then begin
        for i := ID3v2Tag.FrameCount - 1 downto 0 do begin
            if IsSameFrameID(ID3v2Tag.Frames[i].ID, 'WXXX') then begin
                Text := ID3v2Tag.GetUnicodeUserDefinedURLLink(i, Description);
                if SameText(Tags[Index].Name, Description)
                AND SameText(Tags[Index].Value, Text)
                then begin
                    ID3v2Tag.DeleteFrame(i);
                end;
            end;
        end;
    end else begin
        ID3v2Tag.DeleteFrame(FieldNameToID3v2FrameID(FieldName));
    end;
    AtomName := FieldNameToMP4AtomName(FieldName);
    MP4Tag.DeleteAtom(AtomName);
    Atom := MP4Tag.FindAtomCommon('----', Tags[Index].Name, 'com.apple.iTunes');
    if Assigned(Atom) then begin
        Atom.Delete;
    end;
    FieldName := UpperCase(FieldName);
    //* BEXT
    if SameText(FieldName, BEXT_Description) then begin
        WAVTag.BEXT.Description := '';
        //Result := True;
    end else if SameText(FieldName, BEXT_Originator) then begin
        WAVTag.BEXT.Originator := '';
        //Result := True;
    end else if SameText(FieldName, BEXT_OriginatorReference) then begin
        WAVTag.BEXT.OriginatorReference := '';
        //Result := True;
    end else if SameText(FieldName, BEXT_OriginationDate) then begin
        WAVTag.BEXT.OriginationDate := '';
        //Result := True;
    end else if SameText(FieldName, BEXT_OriginationTime) then begin
        WAVTag.BEXT.OriginationTime := '';
        //Result := True;
    end else if SameText(FieldName, BEXT_TimeReference) then begin
        WAVTag.BEXT.TimeReference := StrToIntDef('', 0);
        //Result := True;
    end else if SameText(FieldName, BEXT_Version) then begin
        WAVTag.BEXT.Version := StrToIntDef('', 0);
        //Result := True;
    end else if SameText(FieldName, BEXT_UMID) then begin
        WAVTag.BEXT.UMID := '';
        //Result := True;
    end else if SameText(FieldName, BEXT_CodingHistory) then begin
        WAVTag.BEXT.CodingHistory := '';
        //Result := True;
    //* CART
    end else if SameText(FieldName, CART_Version) then begin
        WAVTag.CART.Version := '';
        //Result := True;
    end else if SameText(FieldName, CART_Title) then begin
        WAVTag.CART.Title := '';
        //Result := True;
    end else if SameText(FieldName, CART_Artist) then begin
        WAVTag.CART.Artist := '';
        //Result := True;
    end else if SameText(FieldName, CART_CutID) then begin
        WAVTag.CART.CutID := '';
        //Result := True;
    end else if SameText(FieldName, CART_ClientID) then begin
        WAVTag.CART.ClientID := '';
        //Result := True;
    end else if SameText(FieldName, CART_Category) then begin
        WAVTag.CART.Category := '';
        //Result := True;
    end else if SameText(FieldName, CART_Classification) then begin
        WAVTag.CART.Classification := '';
        //Result := True;
    end else if SameText(FieldName, CART_OutCue) then begin
        WAVTag.CART.OutCue := '';
        //Result := True;
    end else if SameText(FieldName, CART_StartDate) then begin
        WAVTag.CART.StartDate := '';
        //Result := True;
    end else if SameText(FieldName, CART_StartTime) then begin
        WAVTag.CART.StartTime := '';
        //Result := True;
    end else if SameText(FieldName, CART_EndDate) then begin
        WAVTag.CART.EndDate := '';
        //Result := True;
    end else if SameText(FieldName, CART_EndTime) then begin
        WAVTag.CART.EndTime := '';
        //Result := True;
    end else if SameText(FieldName, CART_ProducerAppID) then begin
        WAVTag.CART.ProducerAppID := '';
        //Result := True;
    end else if SameText(FieldName, CART_ProducerAppVersion) then begin
        WAVTag.CART.ProducerAppVersion := '';
        //Result := True;
    end else if SameText(FieldName, CART_UserDef) then begin
        WAVTag.CART.UserDef := '';
        //Result := True;
    end else if SameText(FieldName, CART_LevelReference) then begin
        WAVTag.CART.LevelReference := 0;
        //Result := True;
    end else if SameText(FieldName, CART_PostTimer + '0') then begin
        WAVTag.CART.ClearPostTimer(0);
        //Result := True;
    end else if SameText(FieldName, CART_PostTimer + '1') then begin
        WAVTag.CART.ClearPostTimer(1);
        //Result := True;
    end else if SameText(FieldName, CART_PostTimer + '2') then begin
        WAVTag.CART.ClearPostTimer(2);
        //Result := True;
    end else if SameText(FieldName, CART_PostTimer + '3') then begin
        WAVTag.CART.ClearPostTimer(3);
        //Result := True;
    end else if SameText(FieldName, CART_PostTimer + '4') then begin
        WAVTag.CART.ClearPostTimer(4);
        //Result := True;
    end else if SameText(FieldName, CART_PostTimer + '5') then begin
        WAVTag.CART.ClearPostTimer(5);
        //Result := True;
    end else if SameText(FieldName, CART_PostTimer + '6') then begin
        WAVTag.CART.ClearPostTimer(6);
        //Result := True;
    end else if SameText(FieldName, CART_PostTimer + '7') then begin
        WAVTag.CART.ClearPostTimer(7);
        //Result := True;
    end else if SameText(FieldName, CART_URL) then begin
        WAVTag.CART.URL := '';
        //Result := True;
    end else if SameText(FieldName, CART_Reserved) then begin
        WAVTag.CART.Reserved := '';
        //Result := True;
    end else if SameText(FieldName, CART_TagText) then begin
        WAVTag.CART.TagText := '';
        //Result := True;
    end else begin
        WAVTag.DeleteFrameByName(FieldName);
    end;
    {$IFDEF MSWINDOWS}
    WMATagName := FieldNameToWMATagID(FieldName);
    for i := WMATag.Count - 1 downto 0 do begin
        if SameText(WMATagName, WMATag.Frames[i].Name) then begin
            WMATag.DeleteFrame(i);
        end;
    end;
    {$ENDIF}
    //* Do the delete from array
    FreeAndNil(Tags[Index]);
    i := 0;
    j := 0;
    while i <= Length(Tags) - 1 do begin
        if Tags[i] <> nil then begin
            Tags[j] := Tags[i];
            Tags[j].Index := j;
            Inc(j);
        end;
        Inc(i);
    end;
    SetLength(Tags, j);
    Result := True;
end;

function TTags.Delete(Name: String): Boolean;
var
    Tag: TTag;
begin
    Result := False;
    Tag := Self.Tag(Name);
    if Assigned(Tag) then begin
        Result := Tag.Delete;
    end;
end;

function TTags.Exists(Name: String): Integer;
var
    i: Integer;
begin
    Result := -1;
    for i := 0 to Length(Tags) - 1 do begin
        if SameText(Name, Tags[i].Name) then begin
            Result := i;
            Break;
        end;
    end;
end;

function TTags.Tag(Name: String): TTag;
var
    Index: Integer;
begin
    Result := nil;
    Index := Exists(Name);
    if Index > - 1 then begin
        Result := Tags[Index];
    end;
end;

function TTags.TypeCount(Name: String): Integer;
var
    i: Integer;
begin
    Result := 0;
    for i := 0 to Length(Tags) - 1 do begin
        if SameText(Name, Tags[i].Name) then begin
            Inc(Result);
        end;
    end;
end;

function TTags.Clear(Name: String): Integer;
var
    i: Integer;
begin
    Result := 0;
    for i := Length(Tags) - 1 downto 0 do begin
        if SameText(Name, Tags[i].Name) then begin
            Self.Delete(i);
            Inc(Result);
        end;
    end;
end;

function TTags.SaveToFile(FileName: String; TagType: TTagType = ttAutomatic): Integer;
var
    Error: Integer;
    Saved: Boolean;
    SaveTagTypes: TTagTypes;
    AudioFileFormat: TAudioFileFormat;
    FileDateTime: TDateTime;
begin
    Saved := False;
    Result := TAGSLIBRARY_ERROR;
    Error := TAGSLIBRARY_ERROR;
    FileAge(FileName, FileDateTime);
    //* Automatic 1st step check if the source and destination file names are equal, then use the same tag type as loaded
    if TagType = ttAutomatic then begin
        if SameText(FileName, Self.FileName) then begin
            if APEv2Tag.Loaded then begin
                Error := SaveAPEv2Tag(FileName);
                Result := APEv2TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                if Result = TAGSLIBRARY_SUCCESS then begin
                    Saved := True;
                end;
            end;
            if FlacTag.Loaded then begin
                Error := SaveFlacTag(FileName);
                Result := FlacTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                if Result = TAGSLIBRARY_SUCCESS then begin
                    Saved := True;
                end;
            end;
            if ID3v1Tag.Loaded then begin
                Error := SaveID3v1Tag(FileName);
                Result := ID3v1TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                if Result = TAGSLIBRARY_SUCCESS then begin
                    //Saved := True;
                end;
            end;
            if ID3v2Tag.Loaded then begin
                Error := SaveID3v2Tag(FileName);
                Result := ID3v2TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                if Result = TAGSLIBRARY_SUCCESS then begin
                    Saved := True;
                end;
            end;
            if MP4Tag.Loaded then begin
                Error := SaveMP4Tag(FileName);
                Result := MP4TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                if Result = TAGSLIBRARY_SUCCESS then begin
                    Saved := True;
                end;
            end;
            if OggVorbisAndOpusTag.Loaded then begin
                Error := SaveOggVorbisAndOpusTag(FileName);
                Result := OpusVorbisTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                if Result = TAGSLIBRARY_SUCCESS then begin
                    Saved := True;
                end;
            end;
            if WAVTag.Loaded then begin
                Error := SaveWAVTag(FileName);
                Result := WAVTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                if Result = TAGSLIBRARY_SUCCESS then begin
                    Saved := True;
                end;
            end;
            {$IFDEF MSWINDOWS}
            if WMATag.Loaded then begin
                Error := SaveWMATag(FileName);
                Result := WMATagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                if Result = TAGSLIBRARY_SUCCESS then begin
                    Saved := True;
                end;
            end;
            {$ENDIF}
        end;
        //* Automatic 2nd step check the destination file's format
        if NOT Saved then begin
            AudioFileFormat := DetectAudioFileFormat(FileName);
            case AudioFileFormat of
                affAPE, affOptimFrog, affMusePack, affWavPack: begin
                    Error := SaveAPEv2Tag(FileName);
                    Result := APEv2TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                    if Result = TAGSLIBRARY_SUCCESS then begin
                        Saved := True;
                    end;
                end;
                affFlac, affOggFlac: begin
                    Error := SaveFlacTag(FileName);
                    Result := FlacTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                    if Result = TAGSLIBRARY_SUCCESS then begin
                        Saved := True;
                    end;
                end;
                affMPEG, affWAV, affRF64, affAIFF, affAIFC, affDFF ,affDSF: begin
                    Error := SaveID3v2Tag(FileName);
                    Result := ID3v2TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                    if Result = TAGSLIBRARY_SUCCESS then begin
                        Saved := True;
                    end;
                    if (AudioFileFormat = affWAV)
                    OR (AudioFileFormat = affRF64)
                    then begin
                        Error := SaveWAVTag(FileName);
                        Result := WAVTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                        if Result = TAGSLIBRARY_SUCCESS then begin
                            Saved := True;
                        end;
                    end;
                end;
                affMP4: begin
                    Error := SaveMP4Tag(FileName);
                    Result := MP4TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                    if Result = TAGSLIBRARY_SUCCESS then begin
                        Saved := True;
                    end;
                end;
                affOpus, affVorbis, affTheora: begin
                    Error := SaveOggVorbisAndOpusTag(FileName);
                    Result := OpusVorbisTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                    if Result = TAGSLIBRARY_SUCCESS then begin
                        Saved := True;
                    end;
                end;
            end;
        end;
        //* Automatic 3rd step check the destination file names' extension
        if NOT Saved then begin
            SaveTagTypes := TagTypeFromFileName(FileName);
            if ttAPEv2 in SaveTagTypes then begin
                Error := SaveAPEv2Tag(FileName);
                Result := APEv2TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            if ttFlac in SaveTagTypes then begin
                Error := SaveFlacTag(FileName);
                Result := FlacTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            if ttID3v1 in SaveTagTypes then begin
                Error := SaveID3v1Tag(FileName);
                Result := ID3v1TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            if ttID3v2 in SaveTagTypes then begin
                Error := SaveID3v2Tag(FileName);
                Result := ID3v2TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            if ttMP4 in SaveTagTypes then begin
                Error := SaveMP4Tag(FileName);
                Result := MP4TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            if ttOpusVorbis in SaveTagTypes then begin
                Error := SaveOggVorbisAndOpusTag(FileName);
                Result := OpusVorbisTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            if ttWAV in SaveTagTypes then begin
                Error := SaveWAVTag(FileName);
                Result := WAVTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            {$IFDEF MSWINDOWS}
            if ttWMA in SaveTagTypes then begin
                Error := SaveWMATag(FileName);
                Result := WMATagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            {$ENDIF}
        end;
    //* Particular tag type was specified explicitly
    end else begin
        case TagType of
            ttAPEv2: begin
                Error := SaveAPEv2Tag(FileName);
                Result := APEv2TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttFlac: begin
                Error := SaveFlacTag(FileName);
                Result := FlacTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttID3v1: begin
                Error := SaveID3v1Tag(FileName);
                Result := ID3v1TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttID3v2: begin
                Error := SaveID3v2Tag(FileName);
                Result := ID3v2TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttMP4: begin
                Error := SaveMP4Tag(FileName);
                Result := MP4TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttOpusVorbis: begin
                Error := SaveOggVorbisAndOpusTag(FileName);
                Result := OpusVorbisTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttWAV: begin
                Error := SaveWAVTag(FileName);
                Result := WAVTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            {$IFDEF MSWINDOWS}
            ttWMA: begin
                Error := SaveWMATag(FileName);
                Result := WMATagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            {$ENDIF}
        end;
    end;
    if Self.PreserveFileDate then begin
        {$IFDEF MSWINDOWS}
        SetDateToFile(FileName, FileDateTime);
        {$ELSE}
        FileSetDate(FileName, DateTimeToFileDate(FileDateTime));
        {$ENDIF}
    end;
    if Error = 0 then begin
        Result := TAGSLIBRARY_SUCCESS;
    end;
end;

function TTags.SaveToStream(Stream: TStream; TagType: TTagType = ttAutomatic): Integer;
var
    Error: Integer;
    AudioFileFormat: TAudioFileFormat;
begin
    Result := TAGSLIBRARY_ERROR;
    Error := TAGSLIBRARY_ERROR;
    if TagType = ttAutomatic then begin
        //* Automatic step: check the destination file's format
        AudioFileFormat := DetectAudioFileFormat(Stream);
        case AudioFileFormat of
            affAPE, affOptimFrog, affMusePack, affWavPack: begin
                Error := SaveAPEv2Tag('', Stream);
                Result := APEv2TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            affFlac, affOggFlac: begin
                Error := SaveFlacTag('', Stream);
                Result := FlacTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            affMPEG, affWAV, affRF64, affAIFF, affAIFC, affDFF, affDSF: begin
                Error := SaveID3v2Tag('', Stream);
                Result := ID3v2TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                if (AudioFileFormat = affWAV)
                OR (AudioFileFormat = affRF64)
                then begin
                    Error := SaveWAVTag('', Stream);
                    Result := WAVTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                end;
            end;
            affMP4: begin
                Error := SaveMP4Tag('', Stream);
                Result := MP4TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            affOpus, affVorbis: begin
                Error := SaveOggVorbisAndOpusTag('', Stream);
                Result := OpusVorbisTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
        end;
    //* Particular tag type was specified explicitly
    end else begin
        case TagType of
            ttAPEv2: begin
                Error := SaveAPEv2Tag('', Stream);
                Result := APEv2TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttFlac: begin
                Error := SaveFlacTag('', Stream);
                Result := FlacTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttID3v1: begin
                Error := SaveID3v1Tag('', Stream);
                Result := ID3v1TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttID3v2: begin
                Error := SaveID3v2Tag('', Stream);
                Result := ID3v2TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttMP4: begin
                Error := SaveMP4Tag('', Stream);
                Result := MP4TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttOpusVorbis: begin
                Error := SaveOggVorbisAndOpusTag('', Stream);
                Result := OpusVorbisTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttWAV: begin
                Error := SaveWAVTag('', Stream);
                Result := WAVTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            {$IFDEF MSWINDOWS}
            ttWMA: begin
                {
                Error := SaveWMATag(FileName);
                Result := WMATagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                }
                Result := TAGSLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
                Exit;
            end;
            {$ENDIF}
        end;
    end;
    if Error = 0 then begin
        Result := TAGSLIBRARY_SUCCESS;
    end;
end;

function TTags.SaveAPEv2Tag(FileName: String; Stream: TStream = nil): Integer;
var
    i, k: Integer;
    List: TStrings;
begin
    APEv2Tag.UpperCaseFieldNamesToWrite := UpperCaseFieldNamesToWrite;
    //* Clear tags
    for i := 0 to Count - 1 do begin
        for k := APEv2Tag.Count - 1 downto 0 do begin
            if Copy(Tags[i].Value, 1, 6) = 'BINARY' then begin
                Continue;
            end;
            if SameText(Tags[i].Name, APEv2Tag.Frames[k].Name) then begin
                APEv2Tag.DeleteFrame(k);
            end;
        end;
    end;
    //* Set tags
    for i := 0 to Count - 1 do begin
        if SameText(Tags[i].Name, 'TIPL')
        OR SameText(Tags[i].Name, 'TMCL')
        then begin
            List := TStringList.Create;
            try
                List.Text := Tags[i].Value;
                APEv2Tag.AddFrame(Tags[i].Name).SetAsList(List);
            finally
                FreeAndNil(List);
            end;
        end else begin
            if Copy(Tags[i].Value, 1, 6) = 'BINARY' then begin
                Continue;
            end;
            APEv2Tag.AddFrame(Tags[i].Name).SetAsText(Tags[i].Value);
        end;
    end;
    //* Delete existing cover arts
    APEv2Tag.DeleteAllCoverArts;
    //* Set cover arts
    for i := 0 to CoverArtCount - 1 do begin
        CoverArts[i].Stream.Seek(0, soBeginning);
        APEv2Tag.AddCoverArtFrame('Cover Art (Front)', CoverArts[i].Stream, CoverArts[i].Description);
    end;
    //* Save the tag
    if Assigned(Stream) then begin
        Stream.Seek(0, soBeginning);
        Result := APEv2Tag.SaveToStream(Stream);
    end else begin
        Result := APEv2Tag.SaveToFile(FileName);
    end;
end;

function TTags.SaveFlacTag(FileName: String; Stream: TStream = nil): Integer;
var
    i, k: Integer;
    FlacTagCoverArtInfo: TFlacTagCoverArtInfo;
    List: TStrings;
begin
    FlacTag.UpperCaseFieldNamesToWrite := UpperCaseFieldNamesToWrite;
    //* Clear tags
    for i := 0 to Count - 1 do begin
        for k := FlacTag.Count - 1 downto 0 do begin
            if SameText(Tags[i].Name, FlacTag.Tags[k].Name) then begin
                FlacTag.DeleteFrame(k);
            end;
        end;
    end;
    //* Set tags
    for i := 0 to Count - 1 do begin
        if SameText(Tags[i].Name, 'TIPL')
        OR SameText(Tags[i].Name, 'TMCL')
        then begin
            List := TStringList.Create;
            try
                List.Text := Tags[i].Value;
                FlacTag.AddTag(Tags[i].Name).SetAsList(List);
            finally
                FreeAndNil(List);
            end;
        end else begin
            FlacTag.AddTag(Tags[i].Name).SetAsText(Tags[i].Value);
        end;
    end;
    //* Delete existing cover arts
    FlacTag.DeleteAllCoverArts;
    //* Set cover arts
    for i := 0 to CoverArtCount - 1 do begin
        CoverArts[i].Stream.Seek(0, soBeginning);
        FlacTagCoverArtInfo.PictureType := CoverArts[i].CoverType;
        FlacTagCoverArtInfo.MIMEType := CoverArts[i].MIMEType;
        FlacTagCoverArtInfo.Description := CoverArts[i].Description;
        //* TODO: get these values correctly
        FlacTagCoverArtInfo.Width := CoverArts[i].Width;
        FlacTagCoverArtInfo.Height := CoverArts[i].Height;
        FlacTagCoverArtInfo.ColorDepth := CoverArts[i].ColorDepth;
        FlacTagCoverArtInfo.NoOfColors := CoverArts[i].NoOfColors;
        FlacTagCoverArtInfo.SizeOfPictureData := CoverArts[i].Stream.Size;
        FlacTag.SetCoverArt(FlacTag.AddMetaDataCoverArt(nil, 0), CoverArts[i].Stream, FlacTagCoverArtInfo);
    end;
    //* Save the tag
    if Assigned(Stream) then begin
        Stream.Seek(0, soBeginning);
        Result := FlacTag.SaveToStream(Stream);
    end else begin
        Result := FlacTag.SaveToFile(FileName);
    end;
end;

function TTags.SaveID3v1Tag(FileName: String; Stream: TStream = nil): Integer;
begin
    //* Set tags
    ID3v1Tag.Revision1 := True;
    ID3v1Tag.Title := GetTag('TITLE');
    ID3v1Tag.Artist := GetTag('ARTIST');
    ID3v1Tag.Album := GetTag('ALBUM');
    ID3v1Tag.Year := GetTag('YEAR');
    if ID3v1Tag.Year = '' then begin
        ID3v1Tag.Year := GetTag('RELEASEDATE');
    end;
    if ID3v1Tag.Year = '' then begin
        ID3v1Tag.Year := GetTag('RECORDINGDATE');
    end;
    ID3v1Tag.Comment := GetTag('COMMENT');
    ID3v1Tag.Track := StrToIntDef(GetTag('TRACKNUMBER'), 0);
    if ID3v1Tag.Track = 0 then begin
        ID3v1Tag.Track := StrToIntDef(GetTag('TRACK'), 0);
    end;
    ID3v1Tag.Genre := GetTag('GENRE');
    //* Save the tag
    if Assigned(Stream) then begin
        Stream.Seek(0, soBeginning);
        Result := ID3v1Tag.SaveToStream(Stream);
    end else begin
        Result := ID3v1Tag.SaveToFile(FileName);
    end;
end;

function TTags.ClearAllID3v2FramesByID(ID3v2Tag: TID3v2Tag; FrameID: String): Boolean;
var
    i: Integer;
begin
    Result := False;
    for i := ID3v2Tag.FrameCount - 1 downto 0 do begin
        if IsSameFrameID(ID3v2Tag.Frames[i].ID, FrameID) then begin
            ID3v2Tag.DeleteFrame(i);
            Result := True;
        end;
    end;
end;


function TTags.ClearAllID3v2FramesTXXXByDescription(ID3v2Tag: TID3v2Tag; Description: String): Boolean;
var
    i: Integer;
    GetContent, GetDescription: String;
begin
    Result := False;
    for i := ID3v2Tag.FrameCount - 1 downto 0 do begin
        if IsSameFrameID(ID3v2Tag.Frames[i].ID, 'TXXX') then begin
            GetContent := ID3v2Tag.GetUnicodeUserDefinedTextInformation(i, GetDescription);
            if UpperCase(GetDescription) = UpperCase(Description) then begin
                ID3v2Tag.DeleteFrame(i);
                Result := True;
            end;
        end;
    end;
end;

function TTags.SaveID3v2Tag(FileName: String; Stream: TStream = nil): Integer;
var
    i: Integer;
    FrameName: String;
    FrameID: TFrameID;
    ID3v2FrameType: TID3v2FrameType;
    LanguageID: TLanguageID;
    Value: String;
    MultipleValues: TStrings;
begin
    MultipleValues := TStringList.Create;
    try
        //* Set tags
        for i := 0 to Count - 1 do begin
            FrameName := FieldNameToID3v2FrameID(Tags[i].Name);
            //* Track/total tracks needs separate processing
            if SameText(Tags[i].Name, 'TRACKNUMBER')
            OR SameText(Tags[i].Name, 'TRACK')
            then begin
                if GetTag('TOTALTRACKS') <> '' then begin
                    Value := Tags[i].Value + '/' + GetTag('TOTALTRACKS');
                end else if GetTag('TRACKTOTAL') <> '' then begin
                    Value := Tags[i].Value + '/' + GetTag('TRACKTOTAL');
                end else begin
                    Value := Tags[i].Value;
                end;
                ClearAllID3v2FramesByID(ID3v2Tag, FrameName);
                ID3v2Tag.SetUnicodeText(FrameName, Value);
            //* Disc/total discs needs separate processing
            end else if SameText(Tags[i].Name, 'DISCNUMBER')
            OR SameText(Tags[i].Name, 'DISC')
            then begin
                if GetTag('TOTALDISCS') <> '' then begin
                    Value := Tags[i].Value + '/' + GetTag('TOTALDISCS');
                end else if GetTag('DISCTOTAL') <> '' then begin
                    Value := Tags[i].Value + '/' + GetTag('DISCTOTAL');
                end else begin
                    Value := Tags[i].Value;
                end;
                ClearAllID3v2FramesByID(ID3v2Tag, FrameName);
                ID3v2Tag.SetUnicodeText(FrameName, Value);
            //* Known fields
            end else if FrameName <> '' then begin
                ConvertString2FrameID(FrameName, FrameID);
                ID3v2FrameType := GetID3v2FrameType(FrameID);
                if Length(Tags[i].Language) = 3 then begin
                    StringToLanguageID(Tags[i].Language, LanguageID);
                end else begin
                    StringToLanguageID('eng', LanguageID);
                end;
                //* TODO: multiple values will be set for every item (which is not needed)
                ClearAllID3v2FramesByID(ID3v2Tag, FrameName);
                GetMultipleList(Tags[i].Name, MultipleValues);
                case ID3v2FrameType of
                    ftUnknown: ID3v2Tag.SetUnicodeTextMultiple(FrameName, MultipleValues);
                    ftText: ID3v2Tag.SetUnicodeTextMultiple(FrameName, MultipleValues);
                    ftTextList: begin
                        MultipleValues.Text := Tags[i].Value;
                        ID3v2Tag.SetUnicodeListFrame(FrameName, MultipleValues);
                    end;
                    ftTextWithDescription: ID3v2Tag.SetUnicodeUserDefinedTextInformationMultiple(FrameName, Tags[i].Description, MultipleValues);
                    ftTextWithDescriptionAndLangugageID: ID3v2Tag.SetUnicodeContent(FrameName, Tags[i].Value, LanguageID, Tags[i].Description);
                    ftURL: ID3v2Tag.SetURL(FrameName, Tags[i].Value);
                    ftUserDefinedURL: ID3v2Tag.SetUnicodeUserDefinedURLLink(FrameName, Tags[i].Value, Tags[i].Description);
                else ID3v2Tag.SetUnicodeText(FrameName, Tags[i].Value)
                end;
            //* Unknown fields processing + playcount
            end else begin
                if SameText(Tags[i].Name, 'PLAYCOUNT') then begin
                    ClearAllID3v2FramesByID(ID3v2Tag, 'PCNT');
                    ID3v2Tag.SetPlayCount('PCNT', StrToIntDef(Tags[i].Value, 0));
                end else begin
                    if Tags[i].ExtTagType = ettWXXX then begin
                        ID3v2Tag.SetUnicodeUserDefinedURLLinkByDescription(Tags[i].Description, Tags[i].Value);
                    end else begin
                        //* TODO: multiple values will be set for every item (which is not needed)
                        GetMultipleList(Tags[i].Name, MultipleValues);
                        ClearAllID3v2FramesTXXXByDescription(ID3v2Tag, Tags[i].Name);
                        ID3v2Tag.SetUnicodeTXXXByDescriptionMultiple(Tags[i].Name, MultipleValues);
                    end;
                end;
            end;
        end;
    finally
        FreeAndNil(MultipleValues);
    end;
    //* Delete existing cover arts
    ID3v2Tag.DeleteAllCoverArts;
    //* Set cover arts
    for i := 0 to CoverArtCount - 1 do begin
        CoverArts[i].Stream.Seek(0, soBeginning);
        ID3v2Tag.SetUnicodeCoverPictureFromStream(ID3v2Tag.AddFrame('APIC'), CoverArts[i].Description, CoverArts[i].Stream, CoverArts[i].MIMEType, CoverArts[i].CoverType);
    end;
    //* Save the tag
    if Assigned(Stream) then begin
        Stream.Seek(0, soBeginning);
        Result := ID3v2Tag.SaveToStream(Stream);
    end else begin
        Result := ID3v2Tag.SaveToFile(FileName);
    end;
end;

function TTags.SaveMP4Tag(FileName: String; Stream: TStream = nil): Integer;
var
    i: Integer;
    AtomName: String;
    Atom: TMP4Atom;
    MultipleValues: TStrings;
    List: TStrings;
begin
    //* Remove deprecated tags
    MP4Tag.DeleteAtom('SErg');
    MP4Tag.DeleteAtom('SEpc');
    MP4Tag.DeleteAtom('TIPL');
    MP4Tag.DeleteAtom('TMCL');
    //* Set tags
    for i := 0 to Count - 1 do begin
        //* Not needed to set, as set by other
        if SameText(Tags[i].Name, 'TOTALTRACKS')
        OR SameText(Tags[i].Name, 'TOTALDISCS')
        then begin
            Continue;
        end;
        //* Tags needed to set separatelly
        if SameText(Tags[i].Name, 'GENRE') then begin
            MP4Tag.SetGenre(Tags[i].Value);
            Continue;
        end;
        if SameText(Tags[i].Name, 'MEDIA') then begin
            MP4Tag.SetMediaType(Tags[i].Value);
            Continue;
        end;
        if SameText(Tags[i].Name, 'TRACKNUMBER')
        OR SameText(Tags[i].Name, 'TRACK')
        then begin
            if Pos('/', Tags[i].Value) > 0 then begin
                MP4Tag.SetTrack(StrToIntDef(Copy(Tags[i].Value, 1, Pos('/', Tags[i].Value) - 1), 0), StrToIntDef(Copy(Tags[i].Value, Pos('/', Tags[i].Value) + 1, Length(Tags[i].Value)), 0));
            end else begin
                if GetTag('TOTALTRACKS') <> '' then begin
                    MP4Tag.SetTrack(StrToIntDef(Tags[i].Value, 0), StrToIntDef(GetTag('TOTALTRACKS'), 0));
                end else begin
                    MP4Tag.SetTrack(StrToIntDef(Tags[i].Value, 0), StrToIntDef(GetTag('TRACKTOTAL'), 0));
                end;
            end;
            Continue;
        end;
        if SameText(Tags[i].Name, 'DISCNUMBER')
        OR SameText(Tags[i].Name, 'DISC')
        then begin
            if Pos('/', Tags[i].Value) > 0 then begin
                MP4Tag.SetDisc(StrToIntDef(Copy(Tags[i].Value, 1, Pos('/', Tags[i].Value) - 1), 0), StrToIntDef(Copy(Tags[i].Value, Pos('/', Tags[i].Value) + 1, Length(Tags[i].Value)), 0));
            end else begin
                if GetTag('TOTALDISCS') <> '' then begin
                    MP4Tag.SetDisc(StrToIntDef(Tags[i].Value, 0), StrToIntDef(GetTag('TOTALDISCS'), 0));
                end else begin
                    MP4Tag.SetDisc(StrToIntDef(Tags[i].Value, 0), StrToIntDef(GetTag('DISCTOTAL'), 0));
                end;
            end;
            Continue;
        end;
        if SameText(Tags[i].Name, 'PURCHASECOUNTRY') then begin
            MP4Tag.SetPurchaseCountry(Tags[i].Value);
            Continue;
        end;
        //* Rest
        AtomName := FieldNameToMP4AtomName(Tags[i].Name);
        if AtomName = '' then begin
            //* No suitable atom name found, write as a common atom
            Atom := MP4Tag.FindAtomCommon('----', Tags[i].Name, 'com.apple.iTunes');
            if NOT Assigned(Atom) then begin
                Atom := MP4Tag.AddAtom('----');
                Atom.name.SetAsText(Tags[i].Name);
                Atom.mean.SetAsText('com.apple.iTunes');
            end;
            Atom.SetAsCommonText(Tags[i].Name, 'com.apple.iTunes', Tags[i].Value);
        end else begin
            if AtomName = 'pgap' then begin
                MP4Tag.SetBool('pgap', Tags[i].Value <> '0');
            end else if AtomName = 'cpil' then begin
                MP4Tag.SetBool('cpil', Tags[i].Value <> '0');
            end else if AtomName = 'tmpo' then begin
                MP4Tag.SetInteger16('tmpo', StrToInt(Tags[i].Value));
            end else if AtomName = 'tvsn' then begin
                MP4Tag.SetInteger32('tvsn', StrToIntDef(Tags[i].Value, 0));
            end else if AtomName = 'tves' then begin
                MP4Tag.SetInteger32('tves', StrToIntDef(Tags[i].Value, 0));
            end else if AtomName = 'hdvd' then begin
                MP4Tag.SetBool('hdvd', Tags[i].Value <> '0');
            end else if AtomName = 'pcst' then begin
                MP4Tag.SetBool('pcst', Tags[i].Value <> '0');
            end else if AtomName = 'akID' then begin
                MP4Tag.SetInteger8('akID', StrToIntDef(Tags[i].Value, 0));
            end else if AtomName = 'TMCL' then begin
                List := TStringList.Create;
                try
                    List.Text := Tags[i].Value;
                    Atom := MP4Tag.FindAtomCommon('----', 'TMCL', 'com.apple.iTunes');
                    if NOT Assigned(Atom) then begin
                        Atom := MP4Tag.AddAtom('----');
                        Atom.name.SetAsText('TMCL');
                        Atom.mean.SetAsText('com.apple.iTunes');
                    end;
                    Atom.SetAsList(List);
                finally
                    FreeAndNil(List);
                end;
            end else if AtomName = 'TIPL' then begin
                List := TStringList.Create;
                try
                    List.Text := Tags[i].Value;
                    Atom := MP4Tag.FindAtomCommon('----', 'TIPL', 'com.apple.iTunes');
                    if NOT Assigned(Atom) then begin
                        Atom := MP4Tag.AddAtom('----');
                        Atom.name.SetAsText('TIPL');
                        Atom.mean.SetAsText('com.apple.iTunes');
                    end;
                    Atom.SetAsList(List);
                finally
                    FreeAndNil(List);
                end;
            end else begin
                //* TODO: multiple values will be set for every item (which is not needed)
                if TypeCount(Tags[i].Name) > 1 then begin
                    MultipleValues := TStringList.Create;
                    try
                        GetMultipleList(Tags[i].Name, MultipleValues);
                        MP4Tag.SetMultipleValues(AtomName, MultipleValues);
                    finally
                        FreeAndNil(MultipleValues);
                    end;
                end else begin
                    MP4Tag.SetText(AtomName, Tags[i].Value);
                end;
            end;
        end;
    end;
    //* Delete existing cover arts
    if Assigned(MP4Tag.FindAtom('covr')) then begin
        MP4Tag.DeleteAtom(MP4Tag.FindAtom('covr').Index);
    end;
    //* Set cover arts
    for i := 0 to CoverArtCount - 1 do begin
        CoverArts[i].Stream.Seek(0, soBeginning);
        Atom := MP4Tag.FindAtom('covr');
        if Atom = nil then begin
            Atom := MP4Tag.AddAtom('covr');
        end;
        with Atom.AddData do begin
            DataType := 13;
            Data.CopyFrom(CoverArts[i].Stream, 0);
        end;
    end;
    //* Save the tag
    if Assigned(Stream) then begin
        Stream.Seek(0, soBeginning);
        Result := MP4Tag.SaveToStream(Stream, MP4KeepPadding);
    end else begin
        Result := MP4Tag.SaveToFile(FileName, MP4KeepPadding);
    end;
end;

function TTags.SaveOggVorbisAndOpusTag(FileName: String; Stream: TStream = nil): Integer;
var
    i, k: Integer;
    CoverArtInfo: TOpusVorbisCoverArtInfo;
    List: TStrings;
begin
    OggVorbisAndOpusTag.UpperCaseFieldNamesToWrite := UpperCaseFieldNamesToWrite;
    //* Clear tags
    for i := 0 to Count - 1 do begin
        for k := OggVorbisAndOpusTag.Count - 1 downto 0 do begin
            if SameText(Tags[i].Name, OggVorbisAndOpusTag.Frames[k].Name) then begin
                OggVorbisAndOpusTag.DeleteFrame(k);
            end;
        end;
    end;
    //* Set tags
    for i := 0 to Count - 1 do begin
        if SameText(Tags[i].Name, 'TIPL')
        OR SameText(Tags[i].Name, 'TMCL')
        then begin
            List := TStringList.Create;
            try
                List.Text := Tags[i].Value;
                OggVorbisAndOpusTag.AddFrame(Tags[i].Name).SetAsList(List);
            finally
                FreeAndNil(List);
            end;
        end else begin
            OggVorbisAndOpusTag.AddFrame(Tags[i].Name).SetAsText(Tags[i].Value);
        end;
    end;
    //* Delete existing cover arts
    OggVorbisAndOpusTag.DeleteAllCoverArts;
    //* Set cover arts
    for i := 0 to CoverArtCount - 1 do begin
        CoverArts[i].Stream.Seek(0, soBeginning);
        CoverArtInfo.PictureType := CoverArts[i].CoverType;
        CoverArtInfo.MIMEType := CoverArts[i].MIMEType;
        CoverArtInfo.Description := CoverArts[i].Description;
        //* TODO: get these values correctly
        CoverArtInfo.Width := CoverArts[i].Width;
        CoverArtInfo.Height := CoverArts[i].Height;
        CoverArtInfo.ColorDepth := CoverArts[i].ColorDepth;
        CoverArtInfo.NoOfColors := CoverArts[i].NoOfColors;
        CoverArtInfo.SizeOfPictureData := CoverArts[i].Stream.Size;
        OggVorbisAndOpusTag.AddCoverArtFrame(CoverArts[i].Stream, CoverArtInfo);
    end;
    //* Save the tag
    if Assigned(Stream) then begin
        Stream.Seek(0, soBeginning);
        Result := OggVorbisAndOpusTag.SaveToStream(Stream);
    end else begin
        Result := OggVorbisAndOpusTag.SaveToFile(FileName);
    end;
end;

function TTags.SaveWAVTag(FileName: String; Stream: TStream = nil): Integer;
var
    i, k: Integer;
    FrameName: String;
    //FieldName: String;
    CART_TIMER: TCART_TIMER;
    MultipleValues: TStrings;
    SumValues: String;
    List: TStrings;
begin
    //* Set tags
    for i := 0 to Count - 1 do begin
        //FieldName := UpperCase(Tags[i].Name);
        //* BEXT
        if SameText(Tags[i].Name, BEXT_Description) then begin
            WAVTag.BEXT.Description := Tags[i].Value;
        end else if SameText(Tags[i].Name, BEXT_Originator) then begin
            WAVTag.BEXT.Originator := Tags[i].Value;
        end else if SameText(Tags[i].Name, BEXT_OriginatorReference) then begin
            WAVTag.BEXT.OriginatorReference := Tags[i].Value;
        end else if SameText(Tags[i].Name, BEXT_OriginationDate) then begin
            WAVTag.BEXT.OriginationDate := Tags[i].Value;
        end else if SameText(Tags[i].Name, BEXT_OriginationTime) then begin
            WAVTag.BEXT.OriginationTime := Tags[i].Value;
        end else if SameText(Tags[i].Name, BEXT_TimeReference) then begin
            WAVTag.BEXT.TimeReference := StrToIntDef(Tags[i].Value, 0);
        end else if SameText(Tags[i].Name, BEXT_Version) then begin
            WAVTag.BEXT.Version := StrToIntDef(Tags[i].Value, 0);
        end else if SameText(Tags[i].Name, BEXT_UMID) then begin
            WAVTag.BEXT.UMID := Tags[i].Value;
        end else if SameText(Tags[i].Name, BEXT_CodingHistory) then begin
            WAVTag.BEXT.CodingHistory := Tags[i].Value;
        //* CART
        end else if SameText(Tags[i].Name, CART_Version) then begin
            WAVTag.CART.Version := Tags[i].Value;
        end else if SameText(Tags[i].Name, CART_Title) then begin
            WAVTag.CART.Title := Tags[i].Value;
        end else if SameText(Tags[i].Name, CART_Artist) then begin
            WAVTag.CART.Artist := Tags[i].Value;
        end else if SameText(Tags[i].Name, CART_CutID) then begin
            WAVTag.CART.CutID := Tags[i].Value;
        end else if SameText(Tags[i].Name, CART_ClientID) then begin
            WAVTag.CART.ClientID := Tags[i].Value;
        end else if SameText(Tags[i].Name, CART_Category) then begin
            WAVTag.CART.Category := Tags[i].Value;
        end else if SameText(Tags[i].Name, CART_Classification) then begin
            WAVTag.CART.Classification := Tags[i].Value;
        end else if SameText(Tags[i].Name, CART_OutCue) then begin
            WAVTag.CART.OutCue := Tags[i].Value;
        end else if SameText(Tags[i].Name, CART_StartDate) then begin
            WAVTag.CART.StartDate := Tags[i].Value;
        end else if SameText(Tags[i].Name, CART_StartTime) then begin
            WAVTag.CART.StartTime := Tags[i].Value;
        end else if SameText(Tags[i].Name, CART_EndDate) then begin
            WAVTag.CART.EndDate := Tags[i].Value;
        end else if SameText(Tags[i].Name, CART_EndTime) then begin
            WAVTag.CART.EndTime := Tags[i].Value;
        end else if SameText(Tags[i].Name, CART_ProducerAppID) then begin
            WAVTag.CART.ProducerAppID := Tags[i].Value;
        end else if SameText(Tags[i].Name, CART_ProducerAppVersion) then begin
            WAVTag.CART.ProducerAppVersion := Tags[i].Value;
        end else if SameText(Tags[i].Name, CART_UserDef) then begin
            WAVTag.CART.UserDef := Tags[i].Value;
        end else if SameText(Tags[i].Name, CART_LevelReference) then begin
            WAVTag.CART.LevelReference := StrToIntDef(Tags[i].Value, 0);
        end else if SameText(Tags[i].Name, CART_PostTimer + '0') then begin
            CART_TIMER.Usage := Copy(Tags[i].Value, 1, Pos(' ', Tags[i].Value) - 1);
            CART_TIMER.Value := StrToIntDef(Copy(Tags[i].Value, Pos(' ', Tags[i].Value) + 1, Length(Tags[i].Value)), 0);
            WAVTag.CART.SetPostTimer(0, CART_TIMER);
        end else if SameText(Tags[i].Name, CART_PostTimer + '1') then begin
            CART_TIMER.Usage := Copy(Tags[i].Value, 1, Pos(' ', Tags[i].Value) - 1);
            CART_TIMER.Value := StrToIntDef(Copy(Tags[i].Value, Pos(' ', Tags[i].Value) + 1, Length(Tags[i].Value)), 0);
            WAVTag.CART.SetPostTimer(1, CART_TIMER);
        end else if SameText(Tags[i].Name, CART_PostTimer + '2') then begin
            CART_TIMER.Usage := Copy(Tags[i].Value, 1, Pos(' ', Tags[i].Value) - 1);
            CART_TIMER.Value := StrToIntDef(Copy(Tags[i].Value, Pos(' ', Tags[i].Value) + 1, Length(Tags[i].Value)), 0);
            WAVTag.CART.SetPostTimer(2, CART_TIMER);
        end else if SameText(Tags[i].Name, CART_PostTimer + '3') then begin
            CART_TIMER.Usage := Copy(Tags[i].Value, 1, Pos(' ', Tags[i].Value) - 1);
            CART_TIMER.Value := StrToIntDef(Copy(Tags[i].Value, Pos(' ', Tags[i].Value) + 1, Length(Tags[i].Value)), 0);
            WAVTag.CART.SetPostTimer(3, CART_TIMER);
        end else if SameText(Tags[i].Name, CART_PostTimer + '4') then begin
            CART_TIMER.Usage := Copy(Tags[i].Value, 1, Pos(' ', Tags[i].Value) - 1);
            CART_TIMER.Value := StrToIntDef(Copy(Tags[i].Value, Pos(' ', Tags[i].Value) + 1, Length(Tags[i].Value)), 0);
            WAVTag.CART.SetPostTimer(4, CART_TIMER);
        end else if SameText(Tags[i].Name, CART_PostTimer + '5') then begin
            CART_TIMER.Usage := Copy(Tags[i].Value, 1, Pos(' ', Tags[i].Value) - 1);
            CART_TIMER.Value := StrToIntDef(Copy(Tags[i].Value, Pos(' ', Tags[i].Value) + 1, Length(Tags[i].Value)), 0);
            WAVTag.CART.SetPostTimer(5, CART_TIMER);
        end else if SameText(Tags[i].Name, CART_PostTimer + '6') then begin
            CART_TIMER.Usage := Copy(Tags[i].Value, 1, Pos(' ', Tags[i].Value) - 1);
            CART_TIMER.Value := StrToIntDef(Copy(Tags[i].Value, Pos(' ', Tags[i].Value) + 1, Length(Tags[i].Value)), 0);
            WAVTag.CART.SetPostTimer(6, CART_TIMER);
        end else if SameText(Tags[i].Name, CART_PostTimer + '7') then begin
            CART_TIMER.Usage := Copy(Tags[i].Value, 1, Pos(' ', Tags[i].Value) - 1);
            CART_TIMER.Value := StrToIntDef(Copy(Tags[i].Value, Pos(' ', Tags[i].Value) + 1, Length(Tags[i].Value)), 0);
            WAVTag.CART.SetPostTimer(7, CART_TIMER);
        end else if SameText(Tags[i].Name, CART_URL) then begin
            WAVTag.CART.URL := Tags[i].Value;
        end else if SameText(Tags[i].Name, CART_Reserved) then begin
            WAVTag.CART.Reserved := Tags[i].Value;
        end else if SameText(Tags[i].Name, CART_TagText) then begin
            WAVTag.CART.TagText := Tags[i].Value;
        end else begin
            FrameName := FieldNameToWAVChunkID(Tags[i].Name);
            if FrameName <> '' then begin
                if TypeCount(Tags[i].Name) > 1 then begin
                    SumValues := '';
                    MultipleValues := TStringList.Create;
                    try
                        GetMultipleList(Tags[i].Name, MultipleValues);
                        for k := 0 to MultipleValues.Count - 1 do begin
                            if k = MultipleValues.Count - 1 then begin
                                SumValues := SumValues + MultipleValues[k];
                            end else begin
                                SumValues := SumValues + MultipleValues[k] + ', ';
                            end;
                        end;
                        WAVTag.SetTextFrameText(FrameName, SumValues);
                    finally
                        FreeAndNil(MultipleValues);
                    end;
                end else begin
                    if SameText(Tags[i].Name, 'TIPL')
                    OR SameText(Tags[i].Name, 'TMCL')
                    then begin
                        List := TStringList.Create;
                        try
                            List.Text := Tags[i].Value;
                            WAVTag.AddFrame(Tags[i].Name).SetAsList(List);
                        finally
                            FreeAndNil(List);
                        end;
                    end else begin
                        WAVTag.SetTextFrameText(FrameName, Tags[i].Value);
                    end;
                end;
            end;
        end;
    end;
    //* Save the tag
    if Assigned(Stream) then begin
        Stream.Seek(0, soBeginning);
        Result := WAVTag.SaveToStream(Stream);
    end else begin
        Result := WAVTag.SaveToFile(FileName);
    end;
end;

{$IFDEF MSWINDOWS}
function TTags.SaveWMATag(FileName: String): Integer;
var
    i, k: Integer;
    Value: String;
    FrameName: String;
    List: TStrings;
begin
    //* Clear existing values
    for i := 0 to Count - 1 do begin
        FrameName := FieldNameToWMATagID(Tags[i].Name);
        for k := WMATag.Count - 1 downto 0 do begin
            if SameText(FrameName, WMATag.Frames[k].Name) then begin
                WMATag.DeleteFrame(k);
            end;
        end;
    end;
    //* Set tags
    for i := 0 to Count - 1 do begin
        FrameName := FieldNameToWMATagID(Tags[i].Name);
        if SameText(Tags[i].Name, 'TRACKNUMBER')
        OR SameText(Tags[i].Name, 'TRACK')
        then begin
            WMATag.SetTextFrameText(g_wszWMTrack, IntToStr(StrToIntDef(Tags[i].Value, 1) - 1));
            if GetTag('TOTALTRACKS') <> '' then begin
                Value := Tags[i].Value + '/' + GetTag('TOTALTRACKS');
            end else begin
                Value := Tags[i].Value;
            end;
            WMATag.SetTextFrameText(g_wszWMTrackNumber, Value);
        end else if SameText(Tags[i].Name, 'DISCNUMBER')
        OR SameText(Tags[i].Name, 'DISC')
        then begin
            if GetTag('TOTALDISCS') <> '' then begin
                Value := Tags[i].Value + '/' + GetTag('TOTALDISCS');
            end else begin
                Value := Tags[i].Value;
            end;
            WMATag.SetTextFrameText(g_wszWMPartOfSet, Value);
        end else if FrameName <> '' then begin
            //* TODO: multiple values will be set for every item (which is not needed)
            (*
            for k := WMATag.Count - 1 downto 0 do begin
                if SameText(FrameName {Tags[i].Name}, WMATag.Frames[k].Name) then begin
                    WMATag.DeleteFrame(k);
                end;
            end;
            *)
            if SameText(Tags[i].Name, 'TIPL') then begin
                List := TStringList.Create;
                try
                    List.Text := Tags[i].Value;
                    WMATag.AddFrame(g_wszWMInvolvedPeople).SetAsList(List);
                finally
                    FreeAndNil(List);
                end;
            end else if SameText(Tags[i].Name, 'TMCL') then begin
                List := TStringList.Create;
                try
                    List.Text := Tags[i].Value;
                    WMATag.AddFrame(g_wszWMMusicianCredits).SetAsList(List);
                finally
                    FreeAndNil(List);
                end;
            end else begin
                WMATag.AddFrame(FrameName).SetAsText(Tags[i].Value);
            end;
        end;
    end;
    //* Delete existing cover arts
    WMATag.DeleteAllCoverArts;
    //* Set cover arts
    for i := 0 to CoverArtCount - 1 do begin
        CoverArts[i].Stream.Seek(0, soBeginning);
        WMATag.AddCoverArtFrame(CoverArts[i].Stream, CoverArts[i].MIMEType, CoverArts[i].CoverType, CoverArts[i].Description);
    end;
    //* Save the tag
    Result := WMATag.SaveToFile(FileName);
end;
{$ENDIF}

function TTags.ItemAlreadyOnList(List: TStrings; Item: String): Boolean;
var
    i: Integer;
begin
    Result := False;
    for i := 0 to List.Count - 1 do begin
        if SameText(Item, List[i]) then begin
            Result := True;
            Break;
        end;
    end;
end;

procedure TTags.GetMultipleList(Name: String; List: TStrings);
var
    i: Integer;
begin
    List.Clear;
    for i := 0 to Length(Tags) - 1 do begin
        if SameText(Name, Tags[i].Name) then begin
            if NOT ItemAlreadyOnList(List, Tags[i].Value) then begin
                List.Append(Tags[i].Value);
            end;
        end;
    end;
end;

function TTags.GetSize: Int64;
begin
    Result := 0;
    if APEv2Tag.Loaded then begin
        Result := Result + APEv2Tag.CalculateTagSize;
    end;
    if FlacTag.Loaded then begin
        Result := Result + FlacTag.CalculateTagSize(True)
    end;
    if ID3v1Tag.Loaded then begin
        Result := Result + 128;
    end;
    if ID3v2Tag.Loaded then begin
        Result := Result + ID3v2Tag.Size;
    end;
    if MP4Tag.Loaded then begin
        Result := Result + MP4Tag.Size;
    end;
    if OggVorbisAndOpusTag.Loaded then begin
        Result := Result + OggVorbisAndOpusTag.CalculateTagSize(True);
    end;
    if WAVTag.Loaded then begin
        Result := Result + WAVTag.Size;
    end;
    {$IFDEF MSWINDOWS}
    if WMATag.Loaded then begin
        Result := Result + WMATag.CalculateTagSize;
    end;
    {$ENDIF}
end;

function TTags.GetTag(Name: String): String;
var
    Index: Integer;
begin
    Result := '';
    Index := Exists(Name);
    if Index > - 1 then begin
        Result := Tags[Index].Value;
    end;
end;

procedure TTags.Clear;
begin
    DeleteAllTags;
    DeleteAllCoverArts;
    APEv2Tag.Clear;
    FlacTag.Clear;
    ID3v1Tag.Clear;
    ID3v2Tag.Clear;
    MP4Tag.Clear;
    OggVorbisAndOpusTag.Clear;
    WAVTag.Clear;
    {$IFDEF MSWINDOWS}
    WMATag.Clear;
    {$ENDIF}
    if Assigned(SourceAudioAttributes.WAVPackAttributes) then begin
        FreeAndNil(SourceAudioAttributes.WAVPackAttributes);
    end;
    if Assigned(SourceAudioAttributes.MusePackAttributes) then begin
        FreeAndNil(SourceAudioAttributes.MusePackAttributes);
    end;
    FileName := '';
    Loaded := False;
end;

function TTags.Count: Integer;
begin
    Result := Length(Tags);
end;

function TTags.CoverArtCount: Integer;
begin
    Result := Length(CoverArts);
end;

function TTags.CoverArt(Name: String): TCoverArt;
var
    i: Integer;
begin
    Result := nil;
    for i := 0 to Length(CoverArts) - 1 do begin
        if SameText(Name, CoverArts[i].Name) then begin
            Result := CoverArts[i];
            Break;
        end;
    end;
end;

{
procedure TTags.AddBinaryFrame(Name: String; BinaryStream: TStream; Size: Integer);
var
    PreviousPosition: Int64;
begin
    with AddFrame(Name) do begin
        PreviousPosition := BinaryStream.Position;
        Stream.CopyFrom(BinaryStream, Size);
        Format := ffBinary;
        BinaryStream.Seek(PreviousPosition, soBeginning);
    end;
end;
}

function TTags.SetTag(Name: String; Text: String): Integer;
var
    i: Integer;
    l: Integer;
begin
    i := 0;
    l := Length(Tags);
    while (i < l)
    AND (NOT SameText(Tags[i].Name, Name))
    do begin
        inc(i);
    end;
    if i = l then begin
        with Add(Name) do begin
            Value := Text;
            Result := Index;
        end;
    end else begin
        Tags[i].Value := Text;
        Result := i;
    end;
end;

function TTags.SetList(Name: String; List: TStrings): Integer;
var
    i: Integer;
    l: Integer;
begin
    i := 0;
    l := Length(Tags);
    while (i < l)
    AND SameText(Tags[i].Name, Name)
    do begin
        inc(i);
    end;
    if i = l then begin
        with Add(Name) do begin
            SetAsList(List);
            Result := Index;
        end;
    end else begin
        Tags[i].SetAsList(List);
        Result := i;
    end;
end;

function TTags.Remove(Index: Integer): Boolean;
var
    i, j: Integer;
begin
    Result := False;
    if (Index >= Length(Tags))
    OR (Index < 0)
    then begin
        Exit;
    end;
    //* Do the delete from array
    FreeAndNil(Tags[Index]);
    i := 0;
    j := 0;
    while i <= Length(Tags) - 1 do begin
        if Tags[i] <> nil then begin
            Tags[j] := Tags[i];
            Tags[j].Index := j;
            Inc(j);
        end;
        Inc(i);
    end;
    SetLength(Tags, j);
    Result := True;
end;

procedure TTags.RemoveEmptyTags;
var
    i: Integer;
begin
    for i := Length(Tags) - 1 downto 0 do begin
        if Tags[i].Value = '' then begin
            Delete(i);
        end;
    end;
end;

function TTags.AddCoverArt(Name: String): TCoverArt;
begin
    Result := nil;
    try
        SetLength(CoverArts, Length(CoverArts) + 1);
        CoverArts[Length(CoverArts) - 1] := TCoverArt.Create(Self);
        CoverArts[Length(CoverArts) - 1].Name := Name;
        CoverArts[Length(CoverArts) - 1].Description := 'No description';
        CoverArts[Length(CoverArts) - 1].PictureFormat := tpfUnknown;
        CoverArts[Length(CoverArts) - 1].Index := Length(CoverArts) - 1;
        Result := CoverArts[Length(CoverArts) - 1];
    except
        //*
    end;
end;

function TTags.AddCoverArt(Name: String; Stream: TStream; MIMEType: String): TCoverArt;
var
    CoverArt: TCoverArt;
begin
    Result := nil;
    CoverArt := AddCoverArt(Name);
    if Assigned(CoverArt) then begin
        CoverArt.MIMEType := MIMEType;
        CoverArt.PictureFormat := PictureFormatFromMIMEType(MIMEType);
        CoverArt.Stream.CopyFrom(Stream, 0);
        Result := CoverArt;
    end;
end;

function TTags.AddCoverArt(Name, FileName: String): TCoverArt;
var
    PictureStream: TFileStream;
    PictureMagic: Word;
    MIMEType: String;
begin
    Result := nil;
    if FileExists(FileName) then begin
        try
            PictureStream := TFileStream.Create(FileName, fmOpenRead);
            try
                PictureStream.Seek(0, soBeginning);
                PictureStream.Read(PictureMagic, 2);
                PictureStream.Seek(0, soBeginning);
                if PictureMagic = MAGIC_JPG then begin
                    MIMEType := 'image/jpeg';
                    {
                    JPEGPicture := TJPEGImage.Create;
                    try
                        JPEGPicture.LoadFromStream(PictureStream);
                        Width := JPEGPicture.Width;
                        Height := JPEGPicture.Height;
                        NoOfColors := 0;
                        ColorDepth := 24;
                    finally
                        FreeAndNil(JPEGPicture);
                    end;
                    }
                end;
                if PictureMagic = MAGIC_PNG then begin
                    MIMEType := 'image/png';
                    {
                    PNGPicture := TPNGImage.Create;
                    try
                        PNGPicture.LoadFromStream(PictureStream);
                        Width := PNGPicture.Width;
                        Height := PNGPicture.Height;
                        NoOfColors := 0;
                        ColorDepth := PNGPicture.PixelInformation.Header.BitDepth;
                    finally
                        FreeAndNil(PNGPicture);
                    end;
                    }
                end;
                if PictureMagic = MAGIC_GIF then begin
                    MIMEType := 'image/gif';
                    {
                    GIFPicture := TGIFImage.Create;
                    try
                        GIFPicture.LoadFromStream(PictureStream);
                        Width := GIFPicture.Width;
                        Height := GIFPicture.Height;
                        NoOfColors := 0;   //GIFPicture.ColorResolution
                        ColorDepth := GIFPicture.BitsPerPixel;
                    finally
                        FreeAndNil(GIFPicture);
                    end;
                    }
                end;
                if PictureMagic = MAGIC_BMP then begin
                    MIMEType := 'image/bmp';
                    {
                    BMPPicture := TBitmap.Create;
                    try
                        BMPPicture.LoadFromStream(PictureStream);
                        Width := BMPPicture.Width;
                        Height := BMPPicture.Height;
                        NoOfColors := 0;
                        case BMPPicture.PixelFormat of
                            pfDevice: ColorDepth := 32;
                            pf1bit: ColorDepth := 1;
                            pf4bit: ColorDepth := 4;
                            pf8bit: ColorDepth := 8;
                            pf15bit: ColorDepth := 15;
                            pf16bit: ColorDepth := 16;
                            pf24bit: ColorDepth := 24;
                            pf32bit: ColorDepth := 32;
                            pfCustom: ColorDepth := 32;
                        end;
                    finally
                        FreeAndNil(BMPPicture);
                    end;
                    }
                end;
            finally
                PictureStream.Seek(0, soBeginning);
                Result := AddCoverArt(Name, PictureStream, MIMEType);
            end;
        finally
            FreeAndNil(PictureStream);
        end;
    end;
    if Assigned(Result) then begin
        Result.Description := ExtractFileName(FileName);
    end;
end;

function TTags.Assign(Source: TTags): Boolean;
begin
    Clear;
    try
        FileName := Source.FileName;
        Loaded := Source.Loaded;
        if Source.APEv2Tag.Loaded then begin
            APEv2Tag.Assign(Source.APEv2Tag);
        end;
        if Source.FlacTag.Loaded then begin
            FlacTag.Assign(Source.FlacTag);
        end;
        if Source.ID3v1Tag.Loaded then begin
            ID3v1Tag.Assign(Source.ID3v1Tag);
        end;
        if Source.ID3v2Tag.Loaded then begin
            ID3v2Tag.Assign(Source.ID3v2Tag);
        end;
        if Source.MP4Tag.Loaded then begin
            MP4Tag.Assign(Source.MP4Tag);
        end;
        if Source.OggVorbisAndOpusTag.Loaded then begin
            OggVorbisAndOpusTag.Assign(Source.OggVorbisAndOpusTag);
        end;
        if Source.WAVTag.Loaded then begin
            WAVTag.Assign(Source.WAVTag);
        end;
        {$IFDEF MSWINDOWS}
        if Source.WMATag.Loaded then begin
            WMATag.Assign(Source.WMATag);
        end;
        {$ENDIF}
        LoadTags;
        Result := True;
    except
        Result := False;
    end;
end;

function TagsLibraryErrorCode2String(ErrorCode: Integer): String;
begin
    Result := 'Unknown error code.';
    case ErrorCode of
        TAGSLIBRARY_SUCCESS: Result := 'Success.';
        TAGSLIBRARY_ERROR: Result := 'Unknown error occured.';
        TAGSLIBRARY_ERROR_NO_TAG_FOUND: Result := 'No tag found.';
        TAGSLIBRARY_ERROR_FILENOTFOUND: Result := 'Specified file not found.';
        TAGSLIBRARY_ERROR_EMPTY_TAG: Result := 'Tag is empty.';
        TAGSLIBRARY_ERROR_EMPTY_FRAMES: Result := 'Tag contains only empty frames.';
        TAGSLIBRARY_ERROR_OPENING_FILE: Result := 'Error opening file.';
        TAGSLIBRARY_ERROR_READING_FILE: Result := 'Error reading file.';
        TAGSLIBRARY_ERROR_WRITING_FILE: Result := 'Error writing file.';
        TAGSLIBRARY_ERROR_CORRUPT: Result := 'Error: corrupt file.';
        TAGSLIBRARY_ERROR_NOT_SUPPORTED_VERSION: Result := 'Error: not supported tag version.';
        TAGSLIBRARY_ERROR_NOT_SUPPORTED_FORMAT: Result := 'Error: not supported file format.';
        TAGSLIBRARY_ERROR_BASS_NOT_LOADED: Result := 'Error: BASS has not yet been loaded into this process.';
        TAGSLIBRARY_ERROR_BASS_ChannelGetTags_NOT_FOUND: Result := 'Error: acquiring BASS_ChannelGetTags() function from BASS.dll.';
        TAGSLIBRARY_ERROR_DOESNT_FIT: Result := 'Error: tag doesn''t fit into the file.';
        TAGSLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS: Result := 'Error: file is locked. Need exclusive access to write tag to this file.';
        TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNTLOADDLL: Result := 'Error loading WMVCORE.DLL.';
        TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNOTCREATEMETADATAEDITOR: Result := 'Error: could not create WMA meta data editor.';
        TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNOTQIFORIWMHEADERINFO3: Result := 'Error: could not query for WMA IWMHeaderInfo3.';
        TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNOTQUERY_ATTRIBUTE_COUNT: Result := 'Error: could not query WMA attribute count.';
        TAGSLIBRARY_ERROR_MP4TAGLIBRARY_UPDATE_stco: Result := 'Error: updating MP4 ''stco'' atom.';
        TAGSLIBRARY_ERROR_MP4TAGLIBRARY_UPDATE_co64: Result := 'Error: updating MP4 ''co64'' atom.';
    end;
end;

function ID3v2FrameIDToFieldName(FrameID: TFrameID): String;
var
    ID: String;
begin
    ID := ConvertFrameID2String(FrameID);
    Result := ID3v2FrameIDToFieldName(ID);
end;

function ID3v2FrameIDToFieldName(FrameID: String): String;
begin
    Result := '';
    if FrameID = 'TPE1' then begin
        Result := 'ARTIST';
        Exit;
    end;
    if FrameID = 'TIT2' then begin
        Result := 'TITLE';
        Exit;
    end;
    if FrameID = 'TPE2' then begin
        Result := 'ALBUMARTIST';
        Exit;
    end;
    if FrameID = 'TCOM' then begin
        Result := 'COMPOSER';
        Exit;
    end;
    if FrameID = 'TIT3' then begin
        Result := 'SUBTITLE';
        Exit;
    end;
    if FrameID = 'TPE4' then begin
        Result := 'MIXARTIST';
        Exit;
    end;
    if FrameID = 'TALB' then begin
        Result := 'ALBUM';
        Exit;
    end;
    if FrameID = 'TCOP' then begin
        Result := 'COPYRIGHT';
        Exit;
    end;
    if FrameID = 'TIT1' then begin
        Result := 'GROUPING';
        Exit;
    end;
    if FrameID = 'TCON' then begin
        Result := 'GENRE';
        Exit;
    end;
    if FrameID = 'TDRL' then begin
        Result := 'RELEASEDATE';
        Exit;
    end;
    if FrameID = 'TDRC' then begin
        Result := 'RECORDINGDATE';
        Exit;
    end;
    if FrameID = 'TYER' then begin
        Result := 'YEAR';
        Exit;
    end;
    if FrameID = 'TRCK' then begin
        Result := 'TRACKNUMBER';
        Exit;
    end;
    if FrameID = 'TPOS' then begin
        Result := 'DISCNUMBER';
        Exit;
    end;
    if FrameID = 'TBPM' then begin
        Result := 'BPM';
        Exit;
    end;
    if FrameID = 'TKEY' then begin
        Result := 'KEY';
        Exit;
    end;
    if FrameID = 'TPE3' then begin
        Result := 'CONDUCTOR';
        Exit;
    end;
    if FrameID = 'TEXT' then begin
        Result := 'LYRICIST';
        Exit;
    end;
    if FrameID = 'TPRO' then begin
        Result := 'PRODUCED';
        Exit;
    end;
    if FrameID = 'TSTU' then begin
        Result := 'STUDIO'; //* 'Record Location'
        Exit;
    end;
    if FrameID = 'TPUB' then begin
        Result := 'PUBLISHER'; //* 'Label'
        Exit;
    end;
    if FrameID = 'TENC' then begin
        Result := 'ENCODEDBY';
        Exit;
    end;
    if FrameID = 'TSSE' then begin
        Result := 'SOFTWARESETTINGS';
        Exit;
    end;
    if FrameID = 'TSRC' then begin
        Result := 'ISRC';
        Exit;
    end;
    if FrameID = 'TSST' then begin
        Result := 'DISCSUBTITLE';
        Exit;
    end;
    if FrameID = 'TLAN' then begin
        Result := 'LANGUAGE';
        Exit;
    end;
    if FrameID = 'TMED' then begin
        Result := 'MEDIA';
        Exit;
    end;
    if FrameID = 'TIPL' then begin
        Result := 'TIPL';
        Exit;
    end;
    if FrameID = 'TMCL' then begin
        Result := 'TMCL';
        Exit;
    end;
    if FrameID = 'TMOO' then begin
        Result := 'MOOD';
        Exit;
    end;
    if FrameID = 'COMM' then begin
        Result := 'COMMENT';
        Exit;
    end;
    if FrameID = 'USLT' then begin
        Result := 'LYRICS';
        Exit;
    end;
    if FrameID = 'TSOP' then begin
        Result := 'ARTISTSORT';
        Exit;
    end;
    if FrameID = 'TSOT' then begin
        Result := 'TITLESORT';
        Exit;
    end;
    if FrameID = 'TSO2' then begin
        Result := 'ALBUMARTISTSORT';
        Exit;
    end;
    if FrameID = 'TSOA' then begin
        Result := 'ALBUMSORT';
        Exit;
    end;
    if FrameID = 'TOPE' then begin
        Result := 'ORIGINALARTIST';
        Exit;
    end;
    if FrameID = 'TOAL' then begin
        Result := 'ORIGINALTITLE';
        Exit;
    end;
    if FrameID = 'TOLY' then begin
        Result := 'ORIGINALLYRICIST';
        Exit;
    end;
    if FrameID = 'TOFN' then begin
        Result := 'ORIGINALFILENAME';
        Exit;
    end;
    if FrameID = 'TDOR' then begin
        Result := 'ORIGINALRELEASEDATE';
        Exit;
    end;
    {
    if FrameID = 'WXXX' then begin
        Result := 'URL';
        Exit;
    end;
    }
    if FrameID = 'WOAR' then begin
        Result := 'ARTISTURL';
        Exit;
    end;
    if FrameID = 'WOAF' then begin
        Result := 'AUDIOFILEURL';
        Exit;
    end;
    if FrameID = 'WCOM' then begin
        Result := 'BUYCDURL';
        Exit;
    end;
    if FrameID = 'WPUB' then begin
        Result := 'PUBLISHERURL';
        Exit;
    end;
    if FrameID = 'WORS' then begin
        Result := 'RADIOSTATIONURL';
        Exit;
    end;
    if FrameID = 'WCOP' then begin
        Result := 'COPYRIGHTURL';
        Exit;
    end;
    if FrameID = 'WOAS' then begin
        Result := 'OFFICIALAUDIOSOURCEURL';
        Exit;
    end;
    if FrameID = 'WPAY' then begin
        Result := 'PAYMENTURL';
        Exit;
    end;
    if FrameID = 'TOWN' then begin
        Result := 'FILEOWNER';
        Exit;
    end;
    if FrameID = 'TRSN' then begin
        Result := 'RADIOSTATIONNAME';
        Exit;
    end;
    if FrameID = 'TRSO' then begin
        Result := 'RADIOSTATIONOWNER';
        Exit;
    end;
end;

function FieldNameToID3v2FrameID(FieldName: String): String;
begin
    Result := '';
    FieldName := UpperCase(FieldName);
    if FieldName = 'ARTIST' then begin
        Result := 'TPE1';
        Exit;
    end;
    if FieldName = 'TITLE' then begin
        Result := 'TIT2';
        Exit;
    end;
    if FieldName = 'ALBUMARTIST' then begin
        Result := 'TPE2';
        Exit;
    end;
    if FieldName = 'COMPOSER' then begin
        Result := 'TCOM';
        Exit;
    end;
    if FieldName = 'SUBTITLE' then begin
        Result := 'TIT3';
        Exit;
    end;
    if FieldName = 'MIXARTIST' then begin
        Result := 'TPE4';
        Exit;
    end;
    if FieldName = 'ALBUM' then begin
        Result := 'TALB';
        Exit;
    end;
    if FieldName = 'COPYRIGHT' then begin
        Result := 'TCOP';
        Exit;
    end;
    if FieldName = 'GROUPING' then begin
        Result := 'TIT1';
        Exit;
    end;
    if FieldName = 'GENRE' then begin
        Result := 'TCON';
        Exit;
    end;
    if FieldName = 'RELEASEDATE' then begin
        Result := 'TDRL';
        Exit;
    end;
    if FieldName = 'RECORDINGDATE' then begin
        Result := 'TDRC';
        Exit;
    end;
    if FieldName = 'YEAR' then begin
        Result := 'TYER';
        Exit;
    end;
    if FieldName = 'TRACKNUMBER' then begin
        Result := 'TRCK';
        Exit;
    end;
    if FieldName = 'TRACK' then begin
        Result := 'TRCK';
        Exit;
    end;
    if FieldName = 'DISCNUMBER' then begin
        Result := 'TPOS';
        Exit;
    end;
    if FieldName = 'DISC' then begin
        Result := 'TPOS';
        Exit;
    end;
    if FieldName = 'BPM' then begin
        Result := 'TBPM';
        Exit;
    end;
    if FieldName = 'KEY' then begin
        Result := 'TKEY';
        Exit;
    end;
    if FieldName = 'CONDUCTOR' then begin
        Result := 'TPE3';
        Exit;
    end;
    if FieldName = 'LYRICIST' then begin
        Result := 'TEXT';
        Exit;
    end;
    if FieldName = 'PRODUCED' then begin
        Result := 'TPRO';
        Exit;
    end;
    if FieldName = 'STUDIO' then begin
        Result := 'TSTU'; //* 'Record Location'
        Exit;
    end;
    if FieldName = 'PUBLISHER' then begin
        Result := 'TPUB'; //* 'Label'
        Exit;
    end;
    if FieldName = 'ENCODEDBY' then begin
        Result := 'TENC';
        Exit;
    end;
    if FieldName = 'SOFTWARESETTINGS' then begin
        Result := 'TSSE';
        Exit;
    end;
    if FieldName = 'ISRC' then begin
        Result := 'TSRC';
        Exit;
    end;
    if FieldName = 'DISCSUBTITLE' then begin
        Result := 'TSST';
        Exit;
    end;
    if FieldName = 'LANGUAGE' then begin
        Result := 'TLAN';
        Exit;
    end;
    if FieldName = 'MEDIA' then begin
        Result := 'TMED';
        Exit;
    end;
    if FieldName = 'TIPL' then begin
        Result := 'TIPL';
        Exit;
    end;
    if FieldName = 'TMCL' then begin
        Result := 'TMCL';
        Exit;
    end;
    if FieldName = 'MOOD' then begin
        Result := 'TMOO';
        Exit;
    end;
    if FieldName = 'COMMENT' then begin
        Result := 'COMM';
        Exit;
    end;
    if FieldName = 'LYRICS' then begin
        Result := 'USLT';
        Exit;
    end;
    if FieldName = 'ARTISTSORT' then begin
        Result := 'TSOP';
        Exit;
    end;
    if FieldName = 'TITLESORT' then begin
        Result := 'TSOT';
        Exit;
    end;
    if FieldName = 'ALBUMARTISTSORT' then begin
        Result := 'TSO2';
        Exit;
    end;
    if FieldName = 'ALBUMSORT' then begin
        Result := 'TSOA';
        Exit;
    end;
    if FieldName = 'ORIGINALARTIST' then begin
        Result := 'TOPE';
        Exit;
    end;
    if FieldName = 'ORIGINALTITLE' then begin
        Result := 'TOAL';
        Exit;
    end;
    if FieldName = 'ORIGINALLYRICIST' then begin
        Result := 'TOLY';
        Exit;
    end;
    if FieldName = 'ORIGINALFILENAME' then begin
        Result := 'TOFN';
        Exit;
    end;
    if FieldName = 'ORIGINALRELEASEDATE' then begin
        Result := 'TDOR';
        Exit;
    end;
    {
    if FieldName = 'WXXX' then begin
        Result := 'URL';
        Exit;
    end;
    }
    if FieldName = 'ARTISTURL' then begin
        Result := 'WOAR';
        Exit;
    end;
    if FieldName = 'AUDIOFILEURL' then begin
        Result := 'WOAF';
        Exit;
    end;
    if FieldName = 'BUYCDURL' then begin
        Result := 'WCOM';
        Exit;
    end;
    if FieldName = 'PUBLISHERURL' then begin
        Result := 'WPUB';
        Exit;
    end;
    if FieldName = 'RADIOSTATIONURL' then begin
        Result := 'WORS';
        Exit;
    end;
    if FieldName = 'COPYRIGHTURL' then begin
        Result := 'WCOP';
        Exit;
    end;
    if FieldName = 'OFFICIALAUDIOSOURCEURL' then begin
        Result := 'WOAS';
        Exit;
    end;
    if FieldName = 'PAYMENTURL' then begin
        Result := 'WPAY';
        Exit;
    end;
    if FieldName = 'FILEOWNER' then begin
        Result := 'TOWN';
        Exit;
    end;
    if FieldName = 'RADIOSTATIONNAME' then begin
        Result := 'TRSN';
        Exit;
    end;
    if FieldName = 'RADIOSTATIONOWNER' then begin
        Result := 'TRSO';
        Exit;
    end;
end;

function MP4AtomNameToFieldName(AtomName: TAtomName): String;
var
    ID: String;
begin
    ID := AtomNameToString(AtomName);
    Result := MP4AtomNameToFieldName(ID);
end;

function MP4AtomNameToFieldName(AtomName: String): String;
begin
    Result := '';
    if AtomName = '©ART' then begin
        Result := 'ARTIST';
        Exit;
    end;
    if AtomName = '©nam' then begin
        Result := 'TITLE';
        Exit;
    end;
    if AtomName = 'aART' then begin
        Result := 'ALBUMARTIST';
        Exit;
    end;
    if AtomName = '©wrt' then begin
        Result := 'COMPOSER';
        Exit;
    end;
    if AtomName = '©alb' then begin
        Result := 'ALBUM';
        Exit;
    end;
    if AtomName = 'cprt' then begin
        Result := 'COPYRIGHT';
        Exit;
    end;
    if AtomName = '©grp' then begin
        Result := 'GROUPING';
        Exit;
    end;
    if AtomName = '©day' then begin
        Result := 'RELEASEDATE';
        Exit;
    end;
    if AtomName = 'pgap' then begin
        Result := 'GAPLESSPLAYBACK';
        Exit;
    end;
    if AtomName = 'cpil' then begin
        Result := 'PARTOFCOMPILATION';
        Exit;
    end;
    if AtomName = 'tmpo' then begin
        Result := 'BPM';
        Exit;
    end;
    if AtomName = 'SErg' then begin
        Result := 'RATING';
        Exit;
    end;
    if AtomName = 'tvnn' then begin
        Result := 'TVNETWORK';
        Exit;
    end;
    if AtomName = 'tvsh' then begin
        Result := 'SHOW';
        Exit;
    end;
    if AtomName = 'tven' then begin
        Result := 'EPISODE';
        Exit;
    end;
    if AtomName = 'tvsn' then begin
        Result := 'SEASONNUMBER';
        Exit;
    end;
    if AtomName = 'tves' then begin
        Result := 'EPISODENUMBER';
        Exit;
    end;
    if AtomName = 'hdvd' then begin
        Result := 'HDVIDEO';
        Exit;
    end;
    if AtomName = 'desc' then begin
        Result := 'DESCRIPTION';
        Exit;
    end;
    if AtomName = 'ldes' then begin
        Result := 'LONGDESCRIPTION';
        Exit;
    end;
    if AtomName = '©cmt' then begin
        Result := 'COMMENT';
        Exit;
    end;
    if AtomName = 'stdo' then begin
        Result := 'STUDIO'; //* 'Record Location'
        Exit;
    end;
    if AtomName = 'TPUB' then begin
        Result := 'PUBLISHER'; //* 'Label'
        Exit;
    end;
    if AtomName = '©enc' then begin
        Result := 'ENCODEDBY';
        Exit;
    end;
    if AtomName = '©too' then begin
        Result := 'ENCODERTOOL';
        Exit;
    end;
    if AtomName = 'TIPL' then begin
        Result := 'TIPL';
        Exit;
    end;
    if AtomName = 'TMCL' then begin
        Result := 'TMCL';
        Exit;
    end;
    if AtomName = '©lyr' then begin
        Result := 'LYRICS';
        Exit;
    end;
    if AtomName = 'soar' then begin
        Result := 'ARTISTSORT';
        Exit;
    end;
    if AtomName = 'sonm' then begin
        Result := 'TITLESORT';
        Exit;
    end;
    if AtomName = 'soaa' then begin
        Result := 'ALBUMARTISTSORT';
        Exit;
    end;
    if AtomName = 'soal' then begin
        Result := 'ALBUMSORT';
        Exit;
    end;
    if AtomName = 'soco' then begin
        Result := 'COMPOSERSORT';
        Exit;
    end;
    if AtomName = 'sosn' then begin
        Result := 'SHOWSORT';
        Exit;
    end;
    if AtomName = 'pcst' then begin
        Result := 'PODCAST';
        Exit;
    end;
    if AtomName = 'purl' then begin
        Result := 'PODCASTURL';
        Exit;
    end;
    if AtomName = 'keyw' then begin
        Result := 'PODCASTKEYWORDS';
        Exit;
    end;
    if AtomName = 'catg' then begin
        Result := 'PODCASTCATEGORY';
        Exit;
    end;
    if AtomName = 'apID' then begin
        Result := 'PURCHASEACCOUNT';
        Exit;
    end;
    if AtomName = 'akID' then begin
        Result := 'PURCHASEACCOUNTTYPE';
        Exit;
    end;
    if AtomName = 'purd' then begin
        Result := 'PURCHASEDATE';
        Exit;
    end;
    if AtomName = 'SEpc' then begin
        Result := 'PLAYCOUNT';
        Exit;
    end;
end;

function FieldNameToMP4AtomName(FieldName: String): String;
begin
    Result := '';
    FieldName := UpperCase(FieldName);
    if FieldName = 'ARTIST' then begin
        Result := '©ART';
        Exit;
    end;
    if FieldName = 'TITLE' then begin
        Result := '©nam';
        Exit;
    end;
    if FieldName = 'ALBUMARTIST' then begin
        Result := 'aART';
        Exit;
    end;
    if FieldName = 'ALBUM ARTIST' then begin
        Result := 'aART';
        Exit;
    end;
    if FieldName = 'COMPOSER' then begin
        Result := '©wrt';
        Exit;
    end;
    if FieldName = 'ALBUM' then begin
        Result := '©alb';
        Exit;
    end;
    if FieldName = 'COPYRIGHT' then begin
        Result := 'cprt';
        Exit;
    end;
    if FieldName = 'GROUPING' then begin
        Result := '©grp';
        Exit;
    end;
    if FieldName = 'RELEASEDATE' then begin
        Result := '©day';
        Exit;
    end;
    if FieldName = 'RELEASE DATE' then begin
        Result := '©day';
        Exit;
    end;
    if FieldName = 'YEAR' then begin
        Result := '©day';
        Exit;
    end;
    if FieldName = 'GAPLESSPLAYBACK' then begin
        Result := 'pgap';
        Exit;
    end;
    if FieldName = 'PARTOFCOMPILATION' then begin
        Result := 'cpil';
        Exit;
    end;
    if FieldName = 'PART OF COMPILATION' then begin
        Result := 'cpil';
        Exit;
    end;
    if FieldName = 'BPM' then begin
        Result := 'tmpo';
        Exit;
    end;
    if FieldName = 'TVNETWORK' then begin
        Result := 'tvnn';
        Exit;
    end;
    if FieldName = 'SHOW' then begin
        Result := 'tvsh';
        Exit;
    end;
    if FieldName = 'EPISODE' then begin
        Result := 'tven';
        Exit;
    end;
    if FieldName = 'SEASONNUMBER' then begin
        Result := 'tvsn';
        Exit;
    end;
    if FieldName = 'EPISODENUMBER' then begin
        Result := 'tves';
        Exit;
    end;
    if FieldName = 'HDVIDEO' then begin
        Result := 'hdvd';
        Exit;
    end;
    if FieldName = 'DESCRIPTION' then begin
        Result := 'desc';
        Exit;
    end;
    if FieldName = 'LONGDESCRIPTION' then begin
        Result := 'ldes';
        Exit;
    end;
    if FieldName = 'COMMENT' then begin
        Result := '©cmt';
        Exit;
    end;
    if FieldName = 'STUDIO' then begin
        Result := 'stdo'; //* 'Record Location'
        Exit;
    end;
    if FieldName = 'ENCODEDBY' then begin
        Result := '©enc';
        Exit;
    end;
    if FieldName = 'ENCODERTOOL' then begin
        Result := '©too';
        Exit;
    end;
    if FieldName = 'TIPL' then begin
        Result := 'TIPL';
        Exit;
    end;
    if FieldName = 'TMCL' then begin
        Result := 'TMCL';
        Exit;
    end;
    if FieldName = 'LYRICS' then begin
        Result := '©lyr';
        Exit;
    end;
    if FieldName = 'ARTISTSORT' then begin
        Result := 'soar';
        Exit;
    end;
    if FieldName = 'TITLESORT' then begin
        Result := 'sonm';
        Exit;
    end;
    if FieldName = 'ALBUMARTISTSORT' then begin
        Result := 'soaa';
        Exit;
    end;
    if FieldName = 'ALBUMSORT' then begin
        Result := 'soal';
        Exit;
    end;
    if FieldName = 'COMPOSERSORT' then begin
        Result := 'soco';
        Exit;
    end;
    if FieldName = 'SHOWSORT' then begin
        Result := 'sosn';
        Exit;
    end;
    if FieldName = 'PODCAST' then begin
        Result := 'pcst';
        Exit;
    end;
    if FieldName = 'PODCASTURL' then begin
        Result := 'purl';
        Exit;
    end;
    if FieldName = 'PODCASTKEYWORDS' then begin
        Result := 'keyw';
        Exit;
    end;
    if FieldName = 'PODCASTCATEGORY' then begin
        Result := 'catg';
        Exit;
    end;
    if FieldName = 'PURCHASEACCOUNT' then begin
        Result := 'apID';
        Exit;
    end;
    if FieldName = 'PURCHASEACCOUNTTYPE' then begin
        Result := 'akID';
        Exit;
    end;
    if FieldName = 'PURCHASEDATE' then begin
        Result := 'purd';
        Exit;
    end;
end;

function WAVChunkIDToFieldName(ChunkID: String): String;
begin
    Result := '';
    if ChunkID = 'IART' then begin
        Result := 'ARTIST';
        Exit;
    end;
    if ChunkID = 'INAM' then begin
        Result := 'TITLE';
        Exit;
    end;
    if ChunkID = 'ICOM' then begin
        Result := 'COMPOSER';
        Exit;
    end;
    if ChunkID = 'IURL' then begin
        Result := 'URL';
        Exit;
    end;
    if ChunkID = 'IALB' then begin
        Result := 'ALBUM';
        Exit;
    end;
    if ChunkID = 'IPRD' then begin
        Result := 'ALBUM';
        Exit;
    end;
    if ChunkID = 'ICOP' then begin
        Result := 'COPYRIGHT';
        Exit;
    end;
    if ChunkID = 'BCPR' then begin
        Result := 'COPYRIGHT';
        Exit;
    end;
    if ChunkID = 'IGNR' then begin
        Result := 'GENRE';
        Exit;
    end;
    if ChunkID = 'ICRD' then begin
        Result := 'RECORDINGDATE';
        Exit;
    end;
    if ChunkID = 'IYER' then begin
        Result := 'YEAR';
        Exit;
    end;
    if ChunkID = 'ITRK' then begin
        Result := 'TRACKNUMBER';
        Exit;
    end;
    if ChunkID = 'itrk' then begin
        Result := 'TRACKNUMBER';
        Exit;
    end;
    if ChunkID = 'IBPM' then begin
        Result := 'BPM';
        Exit;
    end;
    if ChunkID = 'BKEY' then begin
        Result := 'KEY';
        Exit;
    end;
    if ChunkID = 'BTPO' then begin
        Result := 'TEMPO';
        Exit;
    end;
    if ChunkID = 'IENG' then begin
        Result := 'PRODUCED';
        Exit;
    end;
    if ChunkID = 'STDO' then begin
        Result := 'STUDIO'; //* 'Record Location'
        Exit;
    end;
    if ChunkID = 'IPUB' then begin
        Result := 'PUBLISHER'; //* 'Label'
        Exit;
    end;
    if ChunkID = 'ITCH' then begin
        Result := 'ENCODEDBY';
        Exit;
    end;
    if ChunkID = 'ISFT' then begin
        Result := 'ENCODERTOOL';
        Exit;
    end;
    if ChunkID = 'IKEY' then begin
        Result := 'KEYWORDS';
        Exit;
    end;
    if ChunkID = 'ISRF' then begin
        Result := 'MEDIA';
        Exit;
    end;
    if ChunkID = 'TIPL' then begin
        Result := 'TIPL';
        Exit;
    end;
    if ChunkID = 'TMCL' then begin
        Result := 'TMCL';
        Exit;
    end;
    if ChunkID = 'BEND' then begin
        Result := 'MUSICEND';
        Exit;
    end;
    if ChunkID = 'BERG' then begin
        Result := 'MUSICENERGY';
        Exit;
    end;
    if ChunkID = 'BTXR' then begin
        Result := 'MUSICTEXTURE';
        Exit;
    end;
    if ChunkID = 'HKST' then begin
        Result := 'HOOKSTART';
        Exit;
    end;
    if ChunkID = 'HKEN' then begin
        Result := 'HOOKEND';
        Exit;
    end;
    if ChunkID = 'ICMT' then begin
        Result := 'COMMENT';
        Exit;
    end;
    if ChunkID = 'ILYR' then begin
        Result := 'LYRICS';
        Exit;
    end;
    if ChunkID = 'ISBJ' then begin
        Result := 'SUBJECT';
        Exit;
    end;
    if ChunkID = 'IARL' then begin
        Result := 'ARCHIVAL LOCATION';
        Exit;
    end;
end;

function FieldNameToWAVChunkID(FieldName: String): String;
begin
    Result := '';
    FieldName := UpperCase(FieldName);
    if FieldName = 'ARTIST' then begin
        Result := 'IART';
        Exit;
    end;
    if FieldName = 'TITLE' then begin
        Result := 'INAM';
        Exit;
    end;
    if FieldName = 'COMPOSER' then begin
        Result := 'ICOM';
        Exit;
    end;
    if FieldName = 'URL' then begin
        Result := 'IURL';
        Exit;
    end;
    {
    if FieldName = 'ALBUM' then begin
        Result := 'IALB';
        Exit;
    end;
    }
    if FieldName = 'ALBUM' then begin
        Result := 'IPRD';
        Exit;
    end;
    if FieldName = 'COPYRIGHT' then begin
        Result := 'ICOP';
        Exit;
    end;
    if FieldName = 'COPYRIGHT' then begin //* which one?
        Result := 'BCPR';
        Exit;
    end;
    if FieldName = 'GENRE' then begin
        Result := 'IGNR';
        Exit;
    end;
    if FieldName = 'RECORDINGDATE' then begin
        Result := 'ICRD';
        Exit;
    end;
    if FieldName = 'YEAR' then begin
        Result := 'IYER';
        Exit;
    end;
    if FieldName = 'TRACKNUMBER' then begin
        Result := 'ITRK';
        Exit;
    end;
    if FieldName = 'TRACK' then begin
        Result := 'ITRK';
        Exit;
    end;
    if FieldName = 'TRACKNUMBER' then begin //* which one?
        Result := 'itrk';
        Exit;
    end;
    if FieldName = 'TRACK' then begin //* which one?
        Result := 'itrk';
        Exit;
    end;
    if FieldName = 'BPM' then begin
        Result := 'IBPM';
        Exit;
    end;
    if FieldName = 'KEY' then begin
        Result := 'BKEY';
        Exit;
    end;
    if FieldName = 'TEMPO' then begin
        Result := 'BTPO';
        Exit;
    end;
    if FieldName = 'PRODUCED' then begin
        Result := 'IENG';
        Exit;
    end;
    if FieldName = 'STUDIO' then begin
        Result := 'STDO'; //* 'Record Location'
        Exit;
    end;
    if FieldName = 'PUBLISHER' then begin
        Result := 'IPUB'; //* 'Label'
        Exit;
    end;
    if FieldName = 'ENCODEDBY' then begin
        Result := 'ITCH';
        Exit;
    end;
    if FieldName = 'ENCODERTOOL' then begin
        Result := 'ISFT';
        Exit;
    end;
    if FieldName = 'KEYWORDS' then begin
        Result := 'IKEY';
        Exit;
    end;
    if FieldName ='MEDIA'  then begin
        Result := 'ISRF';
        Exit;
    end;
    if FieldName = 'TIPL' then begin
        Result := 'TIPL';
        Exit;
    end;
    if FieldName = 'TMCL' then begin
        Result := 'TMCL';
        Exit;
    end;
    if FieldName = 'MUSICEND' then begin
        Result := 'BEND';
        Exit;
    end;
    if FieldName = 'MUSICENERGY' then begin
        Result := 'BERG';
        Exit;
    end;
    if FieldName = 'MUSICTEXTURE' then begin
        Result := 'BTXR';
        Exit;
    end;
    if FieldName = 'HOOKSTART' then begin
        Result := 'HKST';
        Exit;
    end;
    if FieldName = 'HOOKEND' then begin
        Result := 'HKEN';
        Exit;
    end;
    if FieldName = 'COMMENT' then begin
        Result := 'ICMT';
        Exit;
    end;
    if FieldName = 'LYRICS' then begin
        Result := 'ILYR';
        Exit;
    end;
    if FieldName = 'SUBJECT' then begin
        Result := 'ISBJ';
        Exit
    end;
    if FieldName = 'ARCHIVAL LOCATION' then begin
        Result := 'IARL';
        Exit;
    end;
end;

{$IFDEF MSWINDOWS}
function WMATagIDToFieldName(TagID: String): String;
begin
    Result := '';
    if TagID = g_wszWMAuthor then begin
        Result := 'ARTIST';
        Exit;
    end;
    if TagID = g_wszWMTitle then begin
        Result := 'TITLE';
        Exit;
    end;
    if TagID = g_wszWMAlbumArtist then begin
        Result := 'ALBUMARTIST';
        Exit;
    end;
    if TagID = g_wszWMComposer then begin
        Result := 'COMPOSER';
        Exit;
    end;
    if TagID = g_wszWMSubTitle then begin
        Result := 'SUBTITLE';
        Exit;
    end;
    if TagID = g_wszWMModifiedBy then begin
        Result := 'MIXARTIST';
        Exit;
    end;
    if TagID = g_wszWMAlbumTitle then begin
        Result := 'ALBUM';
        Exit;
    end;
    if TagID = g_wszWMCopyright then begin
        Result := 'COPYRIGHT';
        Exit;
    end;
    if TagID = g_wszWMContentGroupDescription then begin
        Result := 'GROUPING';
        Exit;
    end;
    if TagID = g_wszWMGenre then begin
        Result := 'GENRE';
        Exit;
    end;
    if TagID = g_wszWMReleaseYear then begin
        Result := 'RELEASEDATE';
        Exit;
    end;
    if TagID = g_wszWMYear then begin
        Result := 'RECORDINGDATE';
        Exit;
    end;
    if TagID = g_wszWMYear then begin
        Result := 'YEAR';
        Exit;
    end;
    if TagID = g_wszWMTrack then begin
        Result := 'TRACKNUMBER';
        Exit;
    end;
    if TagID = g_wszWMPartOfSet then begin
        Result := 'DISC';
        Exit;
    end;
    if TagID = g_wszWMBeatsPerMinute then begin
        Result := 'BPM';
        Exit;
    end;
    if TagID = g_wszWMInitialKey then begin
        Result := 'KEY';
        Exit;
    end;
    if TagID = g_wszWMConductor then begin
        Result := 'CONDUCTOR';
        Exit;
    end;
    if TagID = g_wszWMWriter then begin
        Result := 'LYRICIST';
        Exit;
    end;
    if TagID = g_wszWMProduced then begin
        Result := 'PRODUCED';
        Exit;
    end;
    if TagID = g_wszWMStudio then begin
        Result := 'STUDIO'; //* 'Record Location'
        Exit;
    end;
    if TagID = g_wszWMPublisher then begin
        Result := 'PUBLISHER'; //* 'Label'
        Exit;
    end;
    if TagID = g_wszWMEncodedBy then begin
        Result := 'ENCODEDBY';
        Exit;
    end;
    if TagID = g_wszWMEncodingSettings then begin
        Result := 'SOFTWARESETTINGS';
        Exit;
    end;
    if TagID = g_wszWMISRC then begin
        Result := 'ISRC';
        Exit;
    end;
    if TagID = g_wszWMCatalogNo then begin
        Result := 'CATALOGNUMBER';
        Exit;
    end;
    if TagID = g_wszWMSetSubTitle then begin
        Result := 'DISCSUBTITLE';
        Exit;
    end;
    if TagID = g_wszWMPartOfSeries then begin
        Result := 'PARTOFSERIES';
        Exit;
    end;
    if TagID = g_wszWMLanguage then begin
        Result := 'LANGUAGE';
        Exit;
    end;
    if TagID = g_wszWMMedia then begin
        Result := 'MEDIA';
        Exit;
    end;
    if TagID = g_wszWMProducer then begin
        Result := 'PRODUCER';
        Exit;
    end;
    if TagID = g_wszWMArranger then begin
        Result := 'ARRANGER';
        Exit;
    end;
    if TagID = g_wszWMEngineer then begin
        Result := 'ENGINEER';
        Exit;
    end;
    if TagID = g_wszWMDJMixer then begin
        Result := 'DJMIXER';
        Exit;
    end;
    if TagID = g_wszWMMixer then begin
        Result := 'MIXER';
        Exit;
    end;
    if TagID = g_wszWMInvolvedPeople then begin
        Result := 'TIPL';
        Exit;
    end;
    if TagID = g_wszWMMusicianCredits then begin
        Result := 'TMCL';
        Exit;
    end;
    if TagID = g_wszWMSharedUserRating then begin
        Result := 'RATING';
        Exit;
    end;
    if TagID = g_wszWMPopularity then begin
        Result := 'POPULARITY';
        Exit;
    end;
    if TagID = g_wszWMQuality then begin
        Result := 'QUALITY';
        Exit;
    end;
    if TagID = g_wszWMMood then begin
        Result := 'MOOD';
        Exit;
    end;
    if TagID = g_wszWMSituation then begin
        Result := 'SITUATION';
        Exit;
    end;
    if TagID = g_wszWMPreference then begin
        Result := 'PREFERENCE';
        Exit;
    end;
    if TagID = g_wszWMDescription then begin
        Result := 'COMMENT';
        Exit;
    end;
    if TagID = g_wszWMLyrics then begin
        Result := 'LYRICS';
        Exit;
    end;
    if TagID = g_wszWMTempo then begin
        Result := 'TEMPO';
        Exit;
    end;
    if TagID = g_wszWMArtistSortOrder then begin
        Result := 'ARTISTSORT';
        Exit;
    end;
    if TagID = g_wszWMTitleSortOrder then begin
        Result := 'TITLESORT';
        Exit;
    end;
    if TagID = g_wszWMAlbumArtistSortOrder then begin
        Result := 'ALBUMARTISTSORT';
        Exit;
    end;
    if TagID = g_wszWMAlbumSortOrder then begin
        Result := 'ALBUMSORT';
        Exit;
    end;
    if TagID = g_wszWMOriginalArtist then begin
        Result := 'ORIGINALARTIST';
        Exit;
    end;
    if TagID = g_wszWMOriginalTitle then begin
        Result := 'ORIGINALTITLE';
        Exit;
    end;
    if TagID = g_wszWMOriginalLyricist then begin
        Result := 'ORIGINALLYRICIST';
        Exit;
    end;
    if TagID = g_wszWMOriginalFilename then begin
        Result := 'ORIGINALFILENAME';
        Exit;
    end;
    if TagID = g_wszWMOriginalReleaseYear then begin
        Result := 'ORIGINALRELEASEDATE';
        Exit;
    end;
    {
    if TagID = 'WXXX' then begin
        Result := 'URL';
        Exit;
    end;
    }
    if TagID = g_wszWMPromotionURL then begin
        Result := 'URL';
        Exit;
    end;
    if TagID = g_wszWMAuthorURL then begin
        Result := 'ARTISTURL';
        Exit;
    end;
    if TagID = g_wszWMAudioFileURL then begin
        Result := 'AUDIOFILEURL';
        Exit;
    end;
    if TagID = g_wszWMBuyCDURL then begin
        Result := 'BUYCDURL';
        Exit;
    end;
    if TagID = g_wszWMPublisherURL then begin
        Result := 'PUBLISHERURL';
        Exit;
    end;
    if TagID = g_wszWMRadioURL then begin
        Result := 'RADIOSTATIONURL';
        Exit;
    end;
    if TagID = g_wszWMCopyrightURL then begin
        Result := 'COPYRIGHTURL';
        Exit;
    end;
    if TagID = g_wszWMAudioSourceURL then begin
        Result := 'OFFICIALAUDIOSOURCEURL';
        Exit;
    end;
    if TagID = g_wszWMPaymentURL then begin
        Result := 'PAYMENTURL';
        Exit;
    end;
    if TagID = g_wszWMFileOwner then begin
        Result := 'FILEOWNER';
        Exit;
    end;
    if TagID = g_wszWMRadioStationName then begin
        Result := 'RADIOSTATIONNAME';
        Exit;
    end;
    if TagID = g_wszWMRadioStationOwner then begin
        Result := 'RADIOSTATIONOWNER';
        Exit;
    end;
    if TagID = g_wszWMPlaycount then begin
        Result := 'PLAYCOUNT';
        Exit;
    end;
end;

function FieldNameToWMATagID(FieldName: String): String;
begin
    Result := '';
    FieldName := UpperCase(FieldName);
    if FieldName = 'ARTIST' then begin
        Result := g_wszWMAuthor;
        Exit;
    end;
    if FieldName = 'TITLE' then begin
        Result := g_wszWMTitle;
        Exit;
    end;
    if FieldName = 'ALBUMARTIST' then begin
        Result := g_wszWMAlbumArtist;
        Exit;
    end;
    if FieldName = 'COMPOSER' then begin
        Result := g_wszWMComposer;
        Exit;
    end;
    if FieldName = 'SUBTITLE' then begin
        Result := g_wszWMSubTitle;
        Exit;
    end;
    if FieldName = 'MIXARTIST' then begin
        Result := g_wszWMModifiedBy;
        Exit;
    end;
    if FieldName = 'ALBUM' then begin
        Result := g_wszWMAlbumTitle;
        Exit;
    end;
    if FieldName = 'COPYRIGHT' then begin
        Result := g_wszWMCopyright;
        Exit;
    end;
    if FieldName = 'GROUPING' then begin
        Result := g_wszWMContentGroupDescription;
        Exit;
    end;
    if FieldName = 'GENRE' then begin
        Result := g_wszWMGenre;
        Exit;
    end;
    if FieldName = 'RELEASEDATE' then begin
        Result := g_wszWMReleaseYear;
        Exit;
    end;
    if FieldName = 'RECORDINGDATE' then begin
        Result := g_wszWMYear;
        Exit;
    end;
    if FieldName = 'YEAR' then begin
        Result := g_wszWMYear;
        Exit;
    end;
    if FieldName = 'TRACKNUMBER' then begin
        Result := g_wszWMTrackNumber;
        Exit;
    end;
    if FieldName = 'TRACK' then begin
        Result := g_wszWMTrackNumber;
        Exit;
    end;
    if FieldName = 'DISCNUMBER' then begin
        Result := g_wszWMPartOfSet;
        Exit;
    end;
    if FieldName = 'DISC' then begin
        Result := g_wszWMPartOfSet;
        Exit;
    end;
    if FieldName = 'BPM' then begin
        Result := g_wszWMBeatsPerMinute;
        Exit;
    end;
    if FieldName = 'KEY' then begin
        Result := g_wszWMInitialKey;
        Exit;
    end;
    if FieldName = 'CONDUCTOR' then begin
        Result := g_wszWMConductor;
        Exit;
    end;
    if FieldName = 'LYRICIST' then begin
        Result := g_wszWMWriter;
        Exit;
    end;
    if FieldName = 'PRODUCED' then begin
        Result := g_wszWMProduced;
        Exit;
    end;
    if FieldName = 'STUDIO' then begin
        Result := g_wszWMStudio; //* 'Record Location'
        Exit;
    end;
    if FieldName = 'PUBLISHER' then begin
        Result := g_wszWMPublisher; //* 'Label'
        Exit;
    end;
    if FieldName = 'ENCODEDBY' then begin
        Result := g_wszWMEncodedBy;
        Exit;
    end;
    if FieldName = 'SOFTWARESETTINGS' then begin
        Result := g_wszWMEncodingSettings;
        Exit;
    end;
    if FieldName = 'ISRC' then begin
        Result := g_wszWMISRC;
        Exit;
    end;
    if FieldName = 'CATALOGNUMBER' then begin
        Result := g_wszWMCatalogNo;
        Exit;
    end;
    if FieldName = 'DISCSUBTITLE' then begin
        Result := g_wszWMSetSubTitle;
        Exit;
    end;
    if FieldName = 'PARTOFSERIES' then begin
        Result := g_wszWMPartOfSeries;
        Exit;
    end;
    if FieldName = 'LANGUAGE' then begin
        Result := g_wszWMLanguage;
        Exit;
    end;
    if FieldName = 'MEDIA' then begin
        Result := g_wszWMMedia;
        Exit;
    end;
    if FieldName = 'PRODUCER' then begin
        Result := g_wszWMProducer;
        Exit;
    end;
    if FieldName = 'ARRANGER' then begin
        Result := g_wszWMArranger;
        Exit;
    end;
    if FieldName = 'ENGINEER' then begin
        Result := g_wszWMEngineer;
        Exit;
    end;
    if FieldName = 'DJMIXER' then begin
        Result := g_wszWMDJMixer;
        Exit;
    end;
    if FieldName = 'MIXER' then begin
        Result := g_wszWMMixer;
        Exit;
    end;
    if FieldName = 'TIPL' then begin
        Result := g_wszWMInvolvedPeople;
        Exit;
    end;
    if FieldName = 'TMCL' then begin
        Result := g_wszWMMusicianCredits;
        Exit;
    end;
    if FieldName = 'RATING' then begin
        Result := g_wszWMSharedUserRating;
        Exit;
    end;
    if FieldName = 'POPULARITY' then begin
        Result := g_wszWMPopularity;
        Exit;
    end;
    if FieldName = 'QUALITY' then begin
        Result := g_wszWMQuality;
        Exit;
    end;
    if FieldName = 'MOOD' then begin
        Result := g_wszWMMood;
        Exit;
    end;
    if FieldName = 'SITUATION' then begin
        Result := g_wszWMSituation;
        Exit;
    end;
    if FieldName = 'PREFERENCE' then begin
        Result := g_wszWMPreference;
        Exit;
    end;
    if FieldName = 'COMMENT' then begin
        Result := g_wszWMDescription;
        Exit;
    end;
    if FieldName = 'LYRICS' then begin
        Result := g_wszWMLyrics;
        Exit;
    end;
    if FieldName = 'TEMPO' then begin
        Result := g_wszWMTempo;
        Exit;
    end;
    if FieldName = 'ARTISTSORT' then begin
        Result := g_wszWMArtistSortOrder;
        Exit;
    end;
    if FieldName = 'TITLESORT' then begin
        Result := g_wszWMTitleSortOrder;
        Exit;
    end;
    if FieldName = 'ALBUMARTISTSORT' then begin
        Result := g_wszWMAlbumArtistSortOrder;
        Exit;
    end;
    if FieldName = 'ALBUMSORT' then begin
        Result := g_wszWMAlbumSortOrder;
        Exit;
    end;
    if FieldName = 'ORIGINALARTIST' then begin
        Result := g_wszWMOriginalArtist;
        Exit;
    end;
    if FieldName = 'ORIGINALTITLE' then begin
        Result := g_wszWMOriginalTitle;
        Exit;
    end;
    if FieldName = 'ORIGINALLYRICIST' then begin
        Result := g_wszWMOriginalLyricist;
        Exit;
    end;
    if FieldName = 'ORIGINALFILENAME' then begin
        Result := g_wszWMOriginalFilename;
        Exit;
    end;
    if FieldName = 'ORIGINALRELEASEDATE' then begin
        Result := g_wszWMOriginalReleaseYear;
        Exit;
    end;
    {
    if FieldName = 'WXXX' then begin
        Result := 'URL';
        Exit;
    end;
    }
    if FieldName = 'URL' then begin
        Result := g_wszWMPromotionURL;
        Exit;
    end;
    if FieldName = 'ARTISTURL' then begin
        Result := g_wszWMAuthorURL;
        Exit;
    end;
    if FieldName = 'AUDIOFILEURL' then begin
        Result := g_wszWMAudioFileURL;
        Exit;
    end;
    if FieldName = 'BUYCDURL' then begin
        Result := g_wszWMBuyCDURL;
        Exit;
    end;
    if FieldName = 'PUBLISHERURL' then begin
        Result := g_wszWMPublisherURL;
        Exit;
    end;
    if FieldName = 'RADIOSTATIONURL' then begin
        Result := g_wszWMRadioURL;
        Exit;
    end;
    if FieldName = 'COPYRIGHTURL' then begin
        Result := g_wszWMCopyrightURL;
        Exit;
    end;
    if FieldName = 'OFFICIALAUDIOSOURCEURL' then begin
        Result := g_wszWMAudioSourceURL;
        Exit;
    end;
    if FieldName = 'PAYMENTURL' then begin
        Result := g_wszWMPaymentURL;
        Exit;
    end;
    if FieldName = 'FILEOWNER' then begin
        Result := g_wszWMFileOwner;
        Exit;
    end;
    if FieldName = 'RADIOSTATIONNAME' then begin
        Result := g_wszWMRadioStationName;
        Exit;
    end;
    if FieldName = 'RADIOSTATIONOWNER' then begin
        Result := g_wszWMRadioStationOwner;
        Exit;
    end;
    if FieldName = 'PLAYCOUNT' then begin
        Result := g_wszWMPlaycount;
        Exit;
    end;
end;

function WMATagLibraryErrorCodeToTagsLibraryErrorCode(ErrorCode: Integer): Integer;
begin
    Result := TAGSLIBRARY_ERROR;
    case ErrorCode of
        WMATAGLIBRARY_SUCCESS: Result := TAGSLIBRARY_SUCCESS;
        WMATAGLIBRARY_ERROR_FILENOTFOUND: Result := TAGSLIBRARY_ERROR_FILENOTFOUND;
        WMATAGLIBRARY_ERROR_COULDNTLOADDLL: Result := TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNTLOADDLL;
        WMATAGLIBRARY_ERROR_COULDNOTCREATEMETADATAEDITOR: Result := TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNOTCREATEMETADATAEDITOR;
        WMATAGLIBRARY_ERROR_COULDNOTQIFORIWMHEADERINFO3: Result := TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNOTQIFORIWMHEADERINFO3;
        WMATAGLIBRARY_ERROR_COULDNOTQUERY_ATTRIBUTE_COUNT: Result := TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNOTQUERY_ATTRIBUTE_COUNT;
    end;
end;
{$ENDIF}

function ID3v1TagLibraryErrorCodeToTagsLibraryErrorCode(ErrorCode: Integer): Integer;
begin
    Result := TAGSLIBRARY_ERROR;
    case ErrorCode of
        ID3V1LIBRARY_SUCCESS: Result := TAGSLIBRARY_SUCCESS;
        ID3V1LIBRARY_ERROR_OPENING_FILE: Result := TAGSLIBRARY_ERROR_OPENING_FILE;
        ID3V1LIBRARY_ERROR_READING_FILE: Result := TAGSLIBRARY_ERROR_READING_FILE;
        ID3V1LIBRARY_ERROR_WRITING_FILE: Result := TAGSLIBRARY_ERROR_WRITING_FILE;
    end;
end;

function ID3v2TagLibraryErrorCodeToTagsLibraryErrorCode(ErrorCode: Integer): Integer;
begin
    Result := TAGSLIBRARY_ERROR;
    case ErrorCode of
        ID3V2LIBRARY_SUCCESS: Result := TAGSLIBRARY_SUCCESS;
        ID3V2LIBRARY_ERROR_NO_TAG_FOUND: Result := TAGSLIBRARY_ERROR_NO_TAG_FOUND;
        ID3V2LIBRARY_ERROR_EMPTY_TAG: Result := TAGSLIBRARY_ERROR_EMPTY_TAG;
        ID3V2LIBRARY_ERROR_EMPTY_FRAMES: Result := TAGSLIBRARY_ERROR_EMPTY_FRAMES;
        ID3V2LIBRARY_ERROR_OPENING_FILE: Result := TAGSLIBRARY_ERROR_OPENING_FILE;
        ID3V2LIBRARY_ERROR_READING_FILE: Result := TAGSLIBRARY_ERROR_READING_FILE;
        ID3V2LIBRARY_ERROR_WRITING_FILE: Result := TAGSLIBRARY_ERROR_WRITING_FILE;
        ID3V2LIBRARY_ERROR_CORRUPT: Result := TAGSLIBRARY_ERROR_CORRUPT;
        ID3V2LIBRARY_ERROR_NOT_SUPPORTED_VERSION: Result := TAGSLIBRARY_ERROR_NOT_SUPPORTED_VERSION;
        ID3V2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT: Result := TAGSLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
        ID3V2LIBRARY_ERROR_DOESNT_FIT: Result := TAGSLIBRARY_ERROR_DOESNT_FIT;
        ID3V2LIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS: Result := TAGSLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS;
    end;
end;

function WAVTagLibraryErrorCodeToTagsLibraryErrorCode(ErrorCode: Integer): Integer;
begin
    Result := TAGSLIBRARY_ERROR;
    case ErrorCode of
        WAVTAGLIBRARY_SUCCESS: Result := TAGSLIBRARY_SUCCESS;
        WAVTAGLIBRARY_ERROR_NO_TAG_FOUND: Result := TAGSLIBRARY_ERROR_NO_TAG_FOUND;
        WAVTAGLIBRARY_ERROR_EMPTY_TAG: Result := TAGSLIBRARY_ERROR_EMPTY_TAG;
        WAVTAGLIBRARY_ERROR_EMPTY_FRAMES: Result := TAGSLIBRARY_ERROR_EMPTY_FRAMES;
        WAVTAGLIBRARY_ERROR_OPENING_FILE: Result := TAGSLIBRARY_ERROR_OPENING_FILE;
        WAVTAGLIBRARY_ERROR_READING_FILE: Result := TAGSLIBRARY_ERROR_READING_FILE;
        WAVTAGLIBRARY_ERROR_WRITING_FILE: Result := TAGSLIBRARY_ERROR_WRITING_FILE;
        WAVTAGLIBRARY_ERROR_CORRUPT: Result := TAGSLIBRARY_ERROR_CORRUPT;
        WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_VERSION: Result := TAGSLIBRARY_ERROR_NOT_SUPPORTED_VERSION;
        WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT: Result := TAGSLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
        WAVTAGLIBRARY_ERROR_DOESNT_FIT: Result := TAGSLIBRARY_ERROR_DOESNT_FIT;
        WAVTAGLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS: Result := TAGSLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS;
    end;
end;

function MP4TagLibraryErrorCodeToTagsLibraryErrorCode(ErrorCode: Integer): Integer;
begin
    Result := TAGSLIBRARY_ERROR;
    case ErrorCode of
        MP4TAGLIBRARY_SUCCESS: Result := TAGSLIBRARY_SUCCESS;
        MP4TAGLIBRARY_ERROR_NO_TAG_FOUND: Result := TAGSLIBRARY_ERROR_NO_TAG_FOUND;
        MP4TAGLIBRARY_ERROR_EMPTY_TAG: Result := TAGSLIBRARY_ERROR_EMPTY_TAG;
        MP4TAGLIBRARY_ERROR_EMPTY_FRAMES: Result := TAGSLIBRARY_ERROR_EMPTY_FRAMES;
        MP4TAGLIBRARY_ERROR_OPENING_FILE: Result := TAGSLIBRARY_ERROR_OPENING_FILE;
        MP4TAGLIBRARY_ERROR_READING_FILE: Result := TAGSLIBRARY_ERROR_READING_FILE;
        MP4TAGLIBRARY_ERROR_WRITING_FILE: Result := TAGSLIBRARY_ERROR_WRITING_FILE;
        MP4TAGLIBRARY_ERROR_NOT_SUPPORTED_VERSION: Result := TAGSLIBRARY_ERROR_NOT_SUPPORTED_VERSION;
        MP4TAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT: Result := TAGSLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
        MP4TAGLIBRARY_ERROR_DOESNT_FIT: Result := TAGSLIBRARY_ERROR_DOESNT_FIT;
        MP4TAGLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS: Result := TAGSLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS;
        MP4TAGLIBRARY_ERROR_UPDATE_stco: Result := TAGSLIBRARY_ERROR_MP4TAGLIBRARY_UPDATE_stco;
        MP4TAGLIBRARY_ERROR_UPDATE_co64: Result := TAGSLIBRARY_ERROR_MP4TAGLIBRARY_UPDATE_co64;
    end;
end;

function APEv2TagLibraryErrorCodeToTagsLibraryErrorCode(ErrorCode: Integer): Integer;
begin
    Result := TAGSLIBRARY_ERROR;
    case ErrorCode of
        APEV2LIBRARY_SUCCESS: Result := TAGSLIBRARY_SUCCESS;
        APEV2LIBRARY_ERROR_NO_TAG_FOUND: Result := TAGSLIBRARY_ERROR_NO_TAG_FOUND;
        APEV2LIBRARY_ERROR_EMPTY_TAG: Result := TAGSLIBRARY_ERROR_EMPTY_TAG;
        APEV2LIBRARY_ERROR_EMPTY_FRAMES: Result := TAGSLIBRARY_ERROR_EMPTY_FRAMES;
        APEV2LIBRARY_ERROR_OPENING_FILE: Result := TAGSLIBRARY_ERROR_OPENING_FILE;
        APEV2LIBRARY_ERROR_READING_FILE: Result := TAGSLIBRARY_ERROR_READING_FILE;
        APEV2LIBRARY_ERROR_WRITING_FILE: Result := TAGSLIBRARY_ERROR_WRITING_FILE;
        APEV2LIBRARY_ERROR_CORRUPT: Result := TAGSLIBRARY_ERROR_CORRUPT;
        APEV2LIBRARY_ERROR_NOT_SUPPORTED_VERSION: Result := TAGSLIBRARY_ERROR_NOT_SUPPORTED_VERSION;
        APEV2LIBRARY_ERROR_NOT_SUPPORTED_FORMAT: Result := TAGSLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
    end;
end;

function OpusVorbisTagLibraryErrorCodeToTagsLibraryErrorCode(ErrorCode: Integer): Integer;
begin
    Result := TAGSLIBRARY_ERROR;
    case ErrorCode of
        OPUSTAGLIBRARY_SUCCESS: Result := TAGSLIBRARY_SUCCESS;
        OPUSTAGLIBRARY_ERROR_NO_TAG_FOUND: Result := TAGSLIBRARY_ERROR_NO_TAG_FOUND;
        OPUSTAGLIBRARY_ERROR_EMPTY_TAG: Result := TAGSLIBRARY_ERROR_EMPTY_TAG;
        OPUSTAGLIBRARY_ERROR_EMPTY_FRAMES: Result := TAGSLIBRARY_ERROR_EMPTY_FRAMES;
        OPUSTAGLIBRARY_ERROR_OPENING_FILE: Result := TAGSLIBRARY_ERROR_OPENING_FILE;
        OPUSTAGLIBRARY_ERROR_READING_FILE: Result := TAGSLIBRARY_ERROR_READING_FILE;
        OPUSTAGLIBRARY_ERROR_WRITING_FILE: Result := TAGSLIBRARY_ERROR_WRITING_FILE;
        OPUSTAGLIBRARY_ERROR_CORRUPT: Result := TAGSLIBRARY_ERROR_CORRUPT;
        OPUSTAGLIBRARY_ERROR_NOT_SUPPORTED_VERSION: Result := TAGSLIBRARY_ERROR_NOT_SUPPORTED_VERSION;
        OPUSTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT: Result := TAGSLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
        OPUSTAGLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS: Result := TAGSLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS;
    end;
end;

function FlacTagLibraryErrorCodeToTagsLibraryErrorCode(ErrorCode: Integer): Integer;
begin
    Result := TAGSLIBRARY_ERROR;
    case ErrorCode of
        FLACTAGLIBRARY_SUCCESS: Result := TAGSLIBRARY_SUCCESS;
        FLACTAGLIBRARY_ERROR_NO_TAG_FOUND: Result := TAGSLIBRARY_ERROR_NO_TAG_FOUND;
        FLACTAGLIBRARY_ERROR_EMPTY_TAG: Result := TAGSLIBRARY_ERROR_EMPTY_TAG;
        FLACTAGLIBRARY_ERROR_EMPTY_FRAMES: Result := TAGSLIBRARY_ERROR_EMPTY_FRAMES;
        FLACTAGLIBRARY_ERROR_OPENING_FILE: Result := TAGSLIBRARY_ERROR_OPENING_FILE;
        FLACTAGLIBRARY_ERROR_READING_FILE: Result := TAGSLIBRARY_ERROR_READING_FILE;
        FLACTAGLIBRARY_ERROR_WRITING_FILE: Result := TAGSLIBRARY_ERROR_WRITING_FILE;
        FLACTAGLIBRARY_ERROR_NOT_SUPPORTED_VERSION: Result := TAGSLIBRARY_ERROR_NOT_SUPPORTED_VERSION;
        FLACTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT: Result := TAGSLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
        FLACTAGLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS: Result := TAGSLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS;
    end;
end;

function VorbisGetCoverArtFromFrame(PictureString: String; var PictureStream: TStream; var CoverArtInfo: TOpusVorbisCoverArtInfo): Boolean;
var
    MIMETypeLength: Cardinal;
    DescriptionLength: Cardinal;
    LengthOfPictureData: Cardinal;
    Bytes: TBytes;
    DecodedStream: TMemoryStream;
    SourceStream: TMemoryStream;
begin
    with CoverArtInfo do begin
        PictureType := 0;
        MIMEType := '';
        Description := '';
        Width := 0;
        Height := 0;
        ColorDepth := 0;
        NoOfColors := 0;
    end;
    try
        //* Put cover art string to a stream
        SourceStream := TMemoryStream.Create;
        try
            Bytes := TEncoding.ANSI.GetBytes(PictureString);
            SourceStream.Write(Bytes[0], Length(Bytes));
        finally
            SetLength(Bytes, 0);
        end;
        //* Extract the cover art
        try
            with CoverArtInfo do begin
                DecodedStream := TMemoryStream.Create;
                SourceStream.Seek(0, soBeginning);
                DecodeStream(SourceStream, DecodedStream);
                DecodedStream.Seek(0, soBeginning);
                DecodedStream.Read(PictureType, 4);
                PictureType := ReverseBytes(PictureType);
                DecodedStream.Read(MIMETypeLength, 4);
                MIMETypeLength := ReverseBytes(MIMETypeLength);
                SetLength(Bytes, MIMETypeLength);
                DecodedStream.Read(Bytes[0], MIMETypeLength);
                CoverArtInfo.MIMEType := TEncoding.UTF8.GetString(Bytes);
                DecodedStream.Read(DescriptionLength, 4);
                DescriptionLength := ReverseBytes(DescriptionLength);
                SetLength(Bytes, DescriptionLength);
                DecodedStream.Read(Bytes[0], DescriptionLength);
                Description := TEncoding.UTF8.GetString(Bytes);
                DecodedStream.Read(Width, 4);
                Width := ReverseBytes(Width);
                DecodedStream.Read(Height, 4);
                Height := ReverseBytes(Height);
                DecodedStream.Read(ColorDepth, 4);
                ColorDepth := ReverseBytes(ColorDepth);
                DecodedStream.Read(NoOfColors, 4);
                NoOfColors := ReverseBytes(NoOfColors);
                DecodedStream.Read(LengthOfPictureData, 4);
                LengthOfPictureData := ReverseBytes(LengthOfPictureData);
                SizeOfPictureData := LengthOfPictureData;
                PictureStream.CopyFrom(DecodedStream, LengthOfPictureData);
                PictureStream.Seek(0, soBeginning);
            end;
            Result := True;
        finally
            FreeAndNil(DecodedStream);
            FreeAndNil(SourceStream);
        end;
    except
        Result := False;
    end;
end;

function PictureFormatFromMIMEType(MIMEType: String): TTagPictureFormat;
begin
    Result := tpfUnknown;
    if SameText(MIMEType, 'image/jpeg')
    OR SameText(MIMEType, 'image/jpg')
    then begin
        Result := tpfJPEG;
    end;
    if SameText(MIMEType, 'image/png') then begin
        Result := tpfPNG;
    end;
    if SameText(MIMEType, 'image/bmp') then begin
        Result := tpfBMP;
    end;
    if SameText(MIMEType, 'image/gif') then begin
        Result := tpfGIF;
    end;
end;

function TagTypeFromFileName(FileName: String): TTagTypes;
var
    Fext: String;
begin
    Result := [ttAPEv2];
    Fext := UpperCase(ExtractFileExt(FileName));
    if (Fext = '.WAV')
    OR (Fext = '.WAVE')
    OR (Fext = '.RF64')
    OR (Fext = '.BWF')
    then begin
        Result := [ttWAV, ttID3v2];
    end;
    if (Fext = '.APE')
    OR (Fext = '.MPC')
    OR (Fext = '.WV')
    OR (Fext = '.OFR')
    then begin
        Result := [ttAPEv2];
    end;
    if (Fext = '.MP4')
    OR (Fext = '.M4A')
    OR (Fext = '.M4B')
    OR (Fext = '.ALAC')
    then begin
        Result := [ttMP4];
    end;
    if (Fext = '.WMA')
    OR (Fext = '.WMV')
    OR (Fext = '.ASF')
    then begin
        Result := [ttWMA];
    end;
    if (Fext = '.FLAC')
    OR (Fext = '.FLA')
    OR (Fext = '.FLC')
    OR (Fext = '.OGA')
    then begin
        Result := [ttFlac];
    end;
    if (Fext = '.OGG')
    OR (Fext = '.OPUS')
    OR (Fext = '.OGV')
    then begin
        Result := [ttOpusVorbis];
    end;
    //* MPEG
    if (Fext = '.MPG')
    OR (Fext = '.MP1')
    OR (Fext = '.MP2')
    OR (Fext = '.MP3')
    OR (Fext = '.MPA')
    //* AIFF
    OR (Fext = '.AIFF')
    OR (Fext = '.AIF')
    OR (Fext = '.AIFC')
    OR (Fext = '.AFC')
    //* DSD DSF
    OR (Fext = '.DSF')
    OR (Fext = '.DFF')
    then begin
        Result := [ttID3v2];
    end;
end;

function RemoveTagsFromFile(FileName: String; TagType: TTagType = ttAutomatic): Integer;
var
    Error: Integer;
    {$IFDEF MSWINDOWS}
    WMATag: TWMATag;
    {$ENDIF}
    Fext: String;
begin
    Result := TAGSLIBRARY_ERROR;
    Error := TAGSLIBRARY_ERROR;
    if NOT FileExists(FileName) then begin
        Result := TAGSLIBRARY_ERROR_FILENOTFOUND;
        Exit;
    end;
    Fext := UpperCase(ExtractFileExt(FileName));
    if TagType = ttAutomatic then begin
        RemoveAPEv2FromFile(FileName);
        RemoveFlacTagFromFile(FileName);
        RemoveID3v1TagFromFile(FileName);
        RemoveID3v2TagFromFile(FileName);
        RemoveMP4TagFromFile(FileName, False);
        RemoveOpusTagFromFile(FileName);
        RemoveWAVTagFromFile(FileName);
        {$IFDEF MSWINDOWS}
        if (Fext = '.WMA')
        OR (Fext = '.WMV')
        OR (Fext = '.ASF')
        then begin
            WMATag := TWMATag.Create;
            try
                WMATag.LoadFromFile(FileName);
                WMATag.Clear;
                WMATag.SaveToFile(FileName);
            finally
                FreeAndNil(WMATag);
            end;
        end;
        {$ENDIF}
        Error := 0;
    //* Particular tag type was specified explicitly
    end else begin
        case TagType of
            ttAPEv2: begin
                Error := RemoveAPEv2FromFile(FileName);
                Result := APEv2TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttFlac: begin
                Error := RemoveFlacTagFromFile(FileName);
                Result := FlacTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttID3v1: begin
                Error := RemoveID3v1TagFromFile(FileName);
                Result := ID3v1TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttID3v2: begin
                Error := RemoveID3v2TagFromFile(FileName);
                Result := ID3v2TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttMP4: begin
                Error := RemoveMP4TagFromFile(FileName, False);
                Result := MP4TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttOpusVorbis: begin
                Error := RemoveOpusTagFromFile(FileName);
                Result := OpusVorbisTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttWAV: begin
                Error := RemoveWAVTagFromFile(FileName);
                Result := WAVTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            {$IFDEF MSWINDOWS}
            ttWMA: begin
                WMATag := TWMATag.Create;
                try
                    WMATag.LoadFromFile(FileName);
                    WMATag.Clear;
                    Error := WMATag.SaveToFile(FileName);
                    Result := WMATagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                finally
                    FreeAndNil(WMATag);
                end;
            end;
            {$ENDIF}
        end;
    end;
    if Error = 0 then begin
        Result := TAGSLIBRARY_SUCCESS;
    end;
end;

function RemoveTagsFromStream(Stream: TStream; TagType: TTagType = ttAutomatic): Integer;
var
    Error: Integer;
    {$IFDEF MSWINDOWS}
    //WMATag: TWMATag;
    {$ENDIF}
begin
    Result := TAGSLIBRARY_ERROR;
    Error := TAGSLIBRARY_ERROR;
    if Stream.Size = 0 then begin
        Result := TAGSLIBRARY_ERROR_FILENOTFOUND;
        Exit;
    end;
    if TagType = ttAutomatic then begin
        Stream.Seek(0, soBeginning);
        try
            RemoveAPEv2FromStream(Stream);
        except
            //*
        end;
        Stream.Seek(0, soBeginning);
        try
            RemoveFlacTagFromStream(Stream);
        except
            //*
        end;
        Stream.Seek(0, soBeginning);
        try
            RemoveID3v1TagFromStream(Stream);
        except
            //*
        end;
        Stream.Seek(0, soBeginning);
        try
            RemoveID3v2TagFromStream(Stream);
        except
            //*
        end;
        Stream.Seek(0, soBeginning);
        try
            RemoveMP4TagFromStream(Stream, False);
        except
            //*
        end;
        Stream.Seek(0, soBeginning);
        try
            RemoveOpusTagFromStream(Stream);
        except
            //*
        end;
        Stream.Seek(0, soBeginning);
        try
            RemoveWAVTagFromStream(Stream);
        except
            //*
        end;
        Stream.Seek(0, soBeginning);
        {$IFDEF MSWINDOWS}
        {
        WMATag := TWMATag.Create;
        try
            WMATag.LoadFromFile(FileName);
            WMATag.Clear;
            WMATag.SaveToFile(FileName);
        finally
            FreeAndNil(WMATag);
        end;
        }
        {$ENDIF}
        Error := 0;
    //* Particular tag type was specified explicitly
    end else begin
        case TagType of
            ttAPEv2: begin
                Stream.Seek(0, soBeginning);
                Error := RemoveAPEv2FromStream(Stream);
                Result := APEv2TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttFlac: begin
                Stream.Seek(0, soBeginning);
                Error := RemoveFlacTagFromStream(Stream);
                Result := FlacTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttID3v1: begin
                Stream.Seek(0, soBeginning);
                Error := RemoveID3v1TagFromStream(Stream);
                Result := ID3v1TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttID3v2: begin
                Stream.Seek(0, soBeginning);
                Error := RemoveID3v2TagFromStream(Stream);
                Result := ID3v2TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttMP4: begin
                Stream.Seek(0, soBeginning);
                Error := RemoveMP4TagFromStream(Stream, False);
                Result := MP4TagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttOpusVorbis: begin
                Stream.Seek(0, soBeginning);
                Error := RemoveOpusTagFromStream(Stream);
                Result := OpusVorbisTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            ttWAV: begin
                Stream.Seek(0, soBeginning);
                Error := RemoveWAVTagFromStream(Stream);
                Result := WAVTagLibraryErrorCodeToTagsLibraryErrorCode(Error);
            end;
            {$IFDEF MSWINDOWS}
            ttWMA: begin
                {
                WMATag := TWMATag.Create;
                try
                    WMATag.LoadFromFile(FileName);
                    WMATag.Clear;
                    Error := WMATag.SaveToFile(FileName);
                    Result := WMATagLibraryErrorCodeToTagsLibraryErrorCode(Error);
                finally
                    FreeAndNil(WMATag);
                end;
                }
                Result := TAGSLIBRARY_ERROR_NOT_SUPPORTED_FORMAT;
            end;
            {$ENDIF}
        end;
    end;
    if Error = 0 then begin
        Result := TAGSLIBRARY_SUCCESS;
    end;
end;

{ TSourceAudioAttributes }

constructor TSourceAudioAttributes.Create(Parent: TTags);
begin
    inherited Create;
    Self.Parent := Parent;
end;

destructor TSourceAudioAttributes.Destroy;
begin
    if Assigned(WAVPackAttributes) then begin
        FreeAndNil(WAVPackAttributes);
    end;
    if Assigned(MusePackAttributes) then begin
        FreeAndNil(MusePackAttributes);
    end;
    inherited;
end;

function TSourceAudioAttributes.GetBitRate: Integer;
var
    i: Integer;
begin
    Result := 0;
    if Assigned(WAVPackAttributes) then begin
        //if Parent.WAVPackSourceAudioAttributes.Bitrate <> 0 then begin
            Result := Round(WAVPackAttributes.Bitrate);
            Exit;
        //end;
    end;
    if Assigned(MusePackAttributes) then begin
        //if Parent.MusePackSourceAudioAttributes.Bitrate <> 0 then begin
            Result := MusePackAttributes.Bitrate;
            Exit;
        //end;
    end;
    for i := High(Parent.TagLoadPriority) downto Low(Parent.TagLoadPriority) do begin
        if Parent.TagLoadPriority[i] = TagsLibrary.ttFlac then begin
            if Parent.FlacTag.BitRate <> 0 then begin
                Result := Parent.FlacTag.BitRate;
                Exit;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttID3v2 then begin
            if Parent.ID3v2Tag.SourceFileType = sftMPEG then begin
                if Parent.ID3v2Tag.BitRate <> 0 then begin
                    Result := Parent.ID3v2Tag.BitRate;
                    Exit;
                end;
            end;
            if (Parent.ID3v2Tag.SourceFileType = sftWAVE)
            OR (Parent.ID3v2Tag.SourceFileType = sftRF64)
            then begin
                if Parent.ID3v2Tag.BitRate <> 0 then begin
                    Result := Parent.ID3v2Tag.BitRate;
                    Exit;
                end;
            end;
            if Parent.ID3v2Tag.SourceFileType = sftAIFF then begin
                if Parent.ID3v2Tag.BitRate <> 0 then begin
                    Result := Parent.ID3v2Tag.BitRate;
                    Exit;
                end;
            end;
            if Parent.ID3v2Tag.SourceFileType = sftDSF then begin
                if Parent.ID3v2Tag.DSFInfo.BitRate <> 0 then begin
                    Result := Parent.ID3v2Tag.DSFInfo.BitRate;
                    Exit;
                end;
            end;
            if Parent.ID3v2Tag.SourceFileType = sftDFF then begin
                if Parent.ID3v2Tag.DFFInfo.BitRate <> 0 then begin
                    Result := Parent.ID3v2Tag.DFFInfo.BitRate;
                    Exit;
                end;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttOpusVorbis then begin
            if Parent.OggVorbisAndOpusTag.Format = ofOpus then begin
                if Parent.OggVorbisAndOpusTag.Info.BitRate <> 0 then begin
                    Result := Parent.OggVorbisAndOpusTag.Info.BitRate;
                    Exit;
                end;
            end;
            if Parent.OggVorbisAndOpusTag.Format = ofVorbis then begin
                if Parent.OggVorbisAndOpusTag.Info.VorbisParameters.BitRateNominal <> 0 then begin
                    Result := Parent.OggVorbisAndOpusTag.Info.VorbisParameters.BitRateNominal div 1000;
                end else begin
                    Result := Parent.OggVorbisAndOpusTag.Info.BitRate;
                end;
                Exit;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttWAV then begin
            if Parent.WAVTag.BitRate <> 0 then begin
                Result := Parent.WAVTag.BitRate;
                Exit;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttMP4 then begin
            if Parent.MP4Tag.mdatAtomSize <> 0 then begin
                //Result := Round(Parent.MP4Tag.mdatAtomSize / (125 * Parent.MP4Tag.Playtime) + 0.5); // bitrate (Kbps) ;
                Result := Parent.MP4Tag.BitRate;
                Exit;
            end;
        end;
        {$IFDEF MSWINDOWS}
        if Parent.TagLoadPriority[i] = TagsLibrary.ttWMA then begin
            if Parent.WMATag.BitRate <> 0 then begin
                Result := Parent.WMATag.BitRate;
                Exit;
            end;
        end;
        {$ENDIF}
    end;
end;

function TSourceAudioAttributes.GetBitsPerSample: Word;
var
    i: Integer;
begin
    Result := 0;
    if Assigned(WAVPackAttributes) then begin
        if WAVPackAttributes.Bits <> 0 then begin
            Result := WAVPackAttributes.Bits;
            Exit;
        end;
    end;
    if Assigned(MusePackAttributes) then begin
        //Result := 16;
        Exit;
    end;
    for i := High(Parent.TagLoadPriority) downto Low(Parent.TagLoadPriority) do begin
        if Parent.TagLoadPriority[i] = TagsLibrary.ttFlac then begin
            if Parent.FlacTag.BitsPerSample <> 0 then begin
                Result := Parent.FlacTag.BitsPerSample;
                Exit;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttID3v2 then begin
            if Parent.ID3v2Tag.SourceFileType = sftMPEG then begin
                if Parent.ID3v2Tag.MPEGInfo.SampleRate <> 0 then begin
                    Result := 0;
                    Exit;
                end;
            end;
            if (Parent.ID3v2Tag.SourceFileType = sftWAVE)
            OR (Parent.ID3v2Tag.SourceFileType = sftRF64)
            then begin
                if Parent.ID3v2Tag.WAVInfo.BitsPerSample <> 0 then begin
                    Result := Parent.ID3v2Tag.WAVInfo.BitsPerSample;
                    Exit;
                end;
            end;
            if Parent.ID3v2Tag.SourceFileType = sftAIFF then begin
                if Parent.ID3v2Tag.AIFFInfo.SampleSize <> 0 then begin
                    Result := Round(Parent.ID3v2Tag.AIFFInfo.SampleSize);
                    Exit;
                end;
            end;
            if Parent.ID3v2Tag.SourceFileType = sftDSF then begin
                if Parent.ID3v2Tag.DSFInfo.BitsPerSample <> 0 then begin
                    Result := Parent.ID3v2Tag.DSFInfo.BitsPerSample;
                    Exit;
                end;
            end;
            if Parent.ID3v2Tag.SourceFileType = sftDFF then begin
                Result := 1;
                Exit;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttOpusVorbis then begin
            if Parent.OggVorbisAndOpusTag.Format = ofOpus then begin
                if Parent.OggVorbisAndOpusTag.Info.OpusParameters.ChannelCount <> 0 then begin
                    Result := 0;
                    Exit;
                end;
            end;
            if Parent.OggVorbisAndOpusTag.Format = ofVorbis then begin
                if Parent.OggVorbisAndOpusTag.Info.VorbisParameters.ChannelMode <> 0 then begin
                    Result := 0;
                    Exit;
                end;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttWAV then begin
            if Parent.WAVTag.Attributes.BitsPerSample <> 0 then begin
                Result := Parent.WAVTag.Attributes.BitsPerSample;
                Exit;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttMP4 then begin
            if Parent.MP4Tag.Resolution <> 0 then begin
                Result := Parent.MP4Tag.Resolution;
                Exit;
            end;
        end;
        {$IFDEF MSWINDOWS}
        if Parent.TagLoadPriority[i] = TagsLibrary.ttWMA then begin
            if Parent.WMATag.Loaded then begin
                Result := 0;
                Exit;
            end;
        end;
        {$ENDIF}
    end;
end;

function TSourceAudioAttributes.GetChannels: Word;
var
    i: Integer;
begin
    Result := 0;
    if Assigned(WAVPackAttributes) then begin
        //if Parent.WAVPackSourceAudioAttributes.Channels <> 0 then begin
            Result := WAVPackAttributes.Channels;
            Exit;
        //end;
    end;
    if Assigned(MusePackAttributes) then begin
        if MusePackAttributes.ChannelCount <> 0 then begin
            Result := MusePackAttributes.ChannelCount;
        end else begin
            Result := 2;
        end;
        Exit;
    end;
    for i := High(Parent.TagLoadPriority) downto Low(Parent.TagLoadPriority) do begin
        if Parent.TagLoadPriority[i] = TagsLibrary.ttFlac then begin
            if Parent.FlacTag.Channels <> 0 then begin
                Result := Parent.FlacTag.Channels;
                Exit;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttID3v2 then begin
            if Parent.ID3v2Tag.SourceFileType = sftMPEG then begin
                if Parent.ID3v2Tag.MPEGInfo.ChannelMode <> tmpegcmUnknown then begin
                    case Parent.ID3v2Tag.MPEGInfo.ChannelMode of
                        tmpegcmUnknown: Result := 0;
                        tmpegcmMono: Result := 1;
                        tmpegcmDualChannel: Result := 2;
                        tmpegcmJointStereo: Result := 2;
                        tmpegcmStereo: Result := 2;
                    end;
                    Exit;
                end;
            end;
            if (Parent.ID3v2Tag.SourceFileType = sftWAVE)
            OR (Parent.ID3v2Tag.SourceFileType = sftRF64)
            then begin
                if Parent.ID3v2Tag.WAVInfo.Channels <> 0 then begin
                    Result := Parent.ID3v2Tag.WAVInfo.Channels;
                    Exit;
                end;
            end;
            if Parent.ID3v2Tag.SourceFileType = sftAIFF then begin
                if Parent.ID3v2Tag.AIFFInfo.Channels <> 0 then begin
                    Result := Round(Parent.ID3v2Tag.AIFFInfo.Channels);
                    Exit;
                end;
            end;
            if Parent.ID3v2Tag.SourceFileType = sftDSF then begin
                if Parent.ID3v2Tag.DSFInfo.ChannelNumber <> 0 then begin
                    Result := Parent.ID3v2Tag.DSFInfo.ChannelNumber;
                    Exit;
                end;
            end;
            if Parent.ID3v2Tag.SourceFileType = sftDFF then begin
                if Parent.ID3v2Tag.DFFInfo.ChannelNumber <> 0 then begin
                    Result := Parent.ID3v2Tag.DFFInfo.ChannelNumber;
                    Exit;
                end;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttOpusVorbis then begin
            if Parent.OggVorbisAndOpusTag.Format = ofOpus then begin
                if Parent.OggVorbisAndOpusTag.Info.OpusParameters.ChannelCount <> 0 then begin
                    Result := Parent.OggVorbisAndOpusTag.Info.OpusParameters.ChannelCount;
                    Exit;
                end;
            end;
            if Parent.OggVorbisAndOpusTag.Format = ofVorbis then begin
                if Parent.OggVorbisAndOpusTag.Info.VorbisParameters.ChannelMode <> 0 then begin
                    Result := Parent.OggVorbisAndOpusTag.Info.VorbisParameters.ChannelMode;
                    Exit;
                end;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttWAV then begin
            if Parent.WAVTag.Attributes.Channels <> 0 then begin
                Result := Parent.WAVTag.Attributes.Channels;
                Exit;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttMP4 then begin
            if Parent.MP4Tag.ChannelCount <> 0 then begin
                Result := Parent.MP4Tag.ChannelCount;
                Exit;
            end;
        end;
        {$IFDEF MSWINDOWS}
        if Parent.TagLoadPriority[i] = TagsLibrary.ttWMA then begin
            if Parent.WMATag.Loaded then begin
                Result := 0; //* Not implemented
                Exit;
            end;
        end;
        {$ENDIF}
    end;
end;

function TSourceAudioAttributes.GetPlayTime: Double;
var
    i: Integer;
begin
    Result := 0;
    if Assigned(WAVPackAttributes) then begin
        //if Parent.WAVPackSourceAudioAttributes.Duration <> 0 then begin
            Result := WAVPackAttributes.Duration;
            Exit;
        //end;
    end;
    if Assigned(MusePackAttributes) then begin
        //if Parent.MusePackSourceAudioAttributes.Duration <> 0 then begin
            Result := MusePackAttributes.Duration;
            Exit;
        //end;
    end;
    for i := High(Parent.TagLoadPriority) downto Low(Parent.TagLoadPriority) do begin
        if Parent.TagLoadPriority[i] = TagsLibrary.ttFlac then begin
            if Parent.FlacTag.Channels <> 0 then begin
                Result := Parent.FlacTag.PlayTime;
                Exit;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttID3v2 then begin
            if Parent.ID3v2Tag.SourceFileType = sftMPEG then begin
                if Parent.ID3v2Tag.PlayTime <> 0 then begin
                    Result := Parent.ID3v2Tag.PlayTime;
                    Exit;
                end;
            end;
            if (Parent.ID3v2Tag.SourceFileType = sftWAVE)
            OR (Parent.ID3v2Tag.SourceFileType = sftRF64)
            then begin
                if Parent.ID3v2Tag.PlayTime <> 0 then begin
                    Result := Parent.ID3v2Tag.PlayTime;
                    Exit;
                end;
            end;
            if Parent.ID3v2Tag.SourceFileType = sftAIFF then begin
                if Parent.ID3v2Tag.PlayTime <> 0 then begin
                    Result := Round(Parent.ID3v2Tag.PlayTime);
                    Exit;
                end;
            end;
            if Parent.ID3v2Tag.SourceFileType = sftDSF then begin
                if Parent.ID3v2Tag.DSFInfo.PlayTime <> 0 then begin
                    Result := Parent.ID3v2Tag.DSFInfo.PlayTime;
                    Exit;
                end;
            end;
            if Parent.ID3v2Tag.SourceFileType = sftDFF then begin
                if Parent.ID3v2Tag.DFFInfo.PlayTime <> 0 then begin
                    Result := Parent.ID3v2Tag.DFFInfo.PlayTime;
                    Exit;
                end;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttOpusVorbis then begin
            if Parent.OggVorbisAndOpusTag.Info.PlayTime <> 0 then begin
                Result := Parent.OggVorbisAndOpusTag.Info.PlayTime;
                Exit;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttWAV then begin
            if Parent.WAVTag.PlayTime <> 0 then begin
                Result := Parent.WAVTag.PlayTime;
                Exit;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttMP4 then begin
            if Parent.MP4Tag.PlayTime <> 0 then begin
                Result := Parent.MP4Tag.PlayTime;
                Exit;
            end;
        end;
        {$IFDEF MSWINDOWS}
        if Parent.TagLoadPriority[i] = TagsLibrary.ttWMA then begin
            if Parent.WMATag.Duration <> 0 then begin
                Result := Parent.WMATag.Duration / 1000;
                Exit;
            end;
        end;
        {$ENDIF}
    end;
end;

function TSourceAudioAttributes.GetSampleCount: Int64;
var
    i: Integer;
begin
    Result := 0;
    if Assigned(WAVPackAttributes) then begin
        //if Parent.WAVPackSourceAudioAttributes.Samples <> 0 then begin
            Result := WAVPackAttributes.Samples;
            Exit;
        //end;
    end;
    if Assigned(MusePackAttributes) then begin
        Result := MusePackAttributes.SampleCount;
        Exit;
    end;
    for i := High(Parent.TagLoadPriority) downto Low(Parent.TagLoadPriority) do begin
        if Parent.TagLoadPriority[i] = TagsLibrary.ttFlac then begin
            if Parent.FlacTag.SampleCount <> 0 then begin
                Result := Parent.FlacTag.SampleCount;
                Exit;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttID3v2 then begin
            if Parent.ID3v2Tag.SourceFileType = sftMPEG then begin
                if Parent.ID3v2Tag.SampleCount <> 0 then begin
                    Result := Parent.ID3v2Tag.SampleCount;
                    Exit;
                end;
            end;
            if (Parent.ID3v2Tag.SourceFileType = sftWAVE)
            OR (Parent.ID3v2Tag.SourceFileType = sftRF64)
            then begin
                if Parent.ID3v2Tag.SampleCount <> 0 then begin
                    Result := Parent.ID3v2Tag.SampleCount;
                    Exit;
                end;
            end;
            if Parent.ID3v2Tag.SourceFileType = sftAIFF then begin
                if Parent.ID3v2Tag.AIFFInfo.SampleFrames <> 0 then begin
                    Result := Round(Parent.ID3v2Tag.AIFFInfo.SampleFrames);
                    Exit;
                end;
            end;
            if Parent.ID3v2Tag.SourceFileType = sftDSF then begin
                if Parent.ID3v2Tag.DSFInfo.SampleCount <> 0 then begin
                    Result := Parent.ID3v2Tag.DSFInfo.SampleCount;
                    Exit;
                end;
            end;
            if Parent.ID3v2Tag.SourceFileType = sftDFF then begin
                if Parent.ID3v2Tag.DFFInfo.SampleCount <> 0 then begin
                    Result := Parent.ID3v2Tag.DFFInfo.SampleCount;
                    Exit;
                end;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttOpusVorbis then begin
            if Parent.OggVorbisAndOpusTag.Info.SampleCount <> 0 then begin
                Result := Parent.OggVorbisAndOpusTag.Info.SampleCount;
                Exit;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttWAV then begin
            if Parent.WAVTag.SampleCount <> 0 then begin
                Result := Parent.WAVTag.SampleCount;
                Exit;
            end;
        end;
        {$IFDEF MSWINDOWS}
        if Parent.TagLoadPriority[i] = TagsLibrary.ttWMA then begin
            if Parent.WMATag.NumberOfFrames <> 0 then begin
                Result := Parent.WMATag.NumberOfFrames;
                Exit;
            end;
        end;
        {$ENDIF}
    end;
end;

function TSourceAudioAttributes.GetSamplesPerSec: DWord;
var
    i: Integer;
begin
    Result := 0;
    if Assigned(WAVPackAttributes) then begin
        //if Parent.WAVPackSourceAudioAttributes.SampleRate <> 0 then begin
            Result := WAVPackAttributes.SampleRate;
            Exit;
        //end;
    end;
    if Assigned(MusePackAttributes) then begin
        //if Parent.MusePackSourceAudioAttributes.SampleRate <> 0 then begin
            Result := MusePackAttributes.SampleRate;
            Exit;
        //end;
    end;
    for i := High(Parent.TagLoadPriority) downto Low(Parent.TagLoadPriority) do begin
        if Parent.TagLoadPriority[i] = TagsLibrary.ttFlac then begin
            if Parent.FlacTag.SampleRate <> 0 then begin
                Result := Parent.FlacTag.SampleRate;
                Exit;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttID3v2 then begin
            if Parent.ID3v2Tag.SourceFileType = sftMPEG then begin
                if Parent.ID3v2Tag.MPEGInfo.SampleRate <> 0 then begin
                    Result := Parent.ID3v2Tag.MPEGInfo.SampleRate;
                    Exit;
                end;
            end;
            if (Parent.ID3v2Tag.SourceFileType = sftWAVE)
            OR (Parent.ID3v2Tag.SourceFileType = sftRF64)
            then begin
                if Parent.ID3v2Tag.WAVInfo.SamplesPerSec <> 0 then begin
                    Result := Parent.ID3v2Tag.WAVInfo.SamplesPerSec;
                    Exit;
                end;
            end;
            if Parent.ID3v2Tag.SourceFileType = sftAIFF then begin
                if Parent.ID3v2Tag.AIFFInfo.SampleRate <> 0 then begin
                    Result := Round(Parent.ID3v2Tag.AIFFInfo.SampleRate);
                    Exit;
                end;
            end;
            if Parent.ID3v2Tag.SourceFileType = sftDSF then begin
                if Parent.ID3v2Tag.DSFInfo.SamplingFrequency <> 0 then begin
                    Result := Parent.ID3v2Tag.DSFInfo.SamplingFrequency;
                    Exit;
                end;
            end;
            if Parent.ID3v2Tag.SourceFileType = sftDFF then begin
                if Parent.ID3v2Tag.DFFInfo.SampleRate <> 0 then begin
                    Result := Parent.ID3v2Tag.DFFInfo.SampleRate;
                    Exit;
                end;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttOpusVorbis then begin
            if Parent.OggVorbisAndOpusTag.Format = ofOpus then begin
                if Parent.OggVorbisAndOpusTag.Info.OpusParameters.SampleRate <> 0 then begin
                    Result := Parent.OggVorbisAndOpusTag.Info.OpusParameters.SampleRate;
                    Exit;
                end;
            end;
            if Parent.OggVorbisAndOpusTag.Format = ofVorbis then begin
                if Parent.OggVorbisAndOpusTag.Info.VorbisParameters.SampleRate <> 0 then begin
                    Result := Parent.OggVorbisAndOpusTag.Info.VorbisParameters.SampleRate;
                    Exit;
                end;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttWAV then begin
            if Parent.WAVTag.Attributes.SamplesPerSec <> 0 then begin
                Result := Parent.WAVTag.Attributes.SamplesPerSec;
                Exit;
            end;
        end;
        if Parent.TagLoadPriority[i] = TagsLibrary.ttMP4 then begin
            if Parent.MP4Tag.SampleRate <> 0 then begin
                Result := Parent.MP4Tag.SampleRate;
                Exit;
            end;
        end;
        {$IFDEF MSWINDOWS}
        if Parent.TagLoadPriority[i] = TagsLibrary.ttWMA then begin
            if Parent.WMATag.Loaded then begin
                Result := 0; //* Not implemented
                Exit;
            end;
        end;
        {$ENDIF}
    end;
end;

function TTags.PictureStreamType(PictureStream: TStream): TTagPictureFormat;
var
    Magic: Word;
begin
    Result := tpfUnknown;
    if NOT Assigned(PictureStream)
    OR (PictureStream.Size = 0)
    then begin
        Exit;
    end;
    try
        PictureStream.Seek(0, soBeginning);
        try
            PictureStream.Read(Magic, SizeOf(Magic));
            case Magic of
                MAGIC_PNG: Result := tpfPNG;
                MAGIC_JPG: Result := tpfJPEG;
                MAGIC_GIF: Result := tpfGIF;
                MAGIC_BMP: Result := tpfBMP;
            end;
        finally
            PictureStream.Seek(0, soBeginning);
        end;
    except
        Result := tpfUnknown;
    end;
end;

function TTags.PicturePointerType(Picture: Pointer; DataSize: UInt64): TTagPictureFormat;
var
    Magic: Word;
begin
    Result := tpfUnknown;
    if NOT Assigned(Picture) then begin
        Exit;
    end;
    if DataSize <= 2 then begin
        Exit;
    end;
    try
        Magic := PWord(Picture)^;
        case Magic of
            MAGIC_PNG: Result := tpfPNG;
            MAGIC_JPG: Result := tpfJPEG;
            MAGIC_GIF: Result := tpfGIF;
            MAGIC_BMP: Result := tpfBMP;
        end;
    except
        Result := tpfUnknown;
    end;
end;

function DetectAudioFileFormat(FileName: String): TAudioFileFormat;
var
    Stream: TStream;
begin
    Result := affUnknown;
    try
        Stream := TFileStream.Create(FileName, fmOpenRead OR fmShareDenyWrite);
    except
        Exit;
    end;
    try
        Result := DetectAudioFileFormat(Stream);
    finally
        FreeAndNil(Stream);
    end;
end;

function DetectAudioFileFormat(Stream: TStream): TAudioFileFormat;
Const
    MPEG_SEARCH_LENGTH = 1024;
var
    ID3v2Size: Cardinal;
    MagicBytes: Array [0..3] of Byte;
    AIFFChunkSize: Cardinal;
    i: Integer;
    Data: Byte;
    OggTag: TOpusTag;
    MP4AtomSize: Cardinal;
    WAVPackInfo: TWAVPackfile;
    MusePackInfo: TMPEGplus;
begin
    Result := affUnknown;
    try
        Stream.Seek(0, soBeginning);
        ID3v2Size := GetID3v2Size(Stream);
        Stream.Seek(ID3v2Size, soBeginning);
        Stream.Read(MagicBytes[0], SizeOf(MagicBytes));
        //* WAVE
        if (MagicBytes[0] = RIFFID[0])
        AND (MagicBytes[1] = RIFFID[1])
        AND (MagicBytes[2] = RIFFID[2])
        AND (MagicBytes[3] = RIFFID[3])
        then begin
            Result := affWAV;
            Exit;
        end;
        //* WAVE
        if (MagicBytes[0] = RF64ID[0])
        AND (MagicBytes[1] = RF64ID[1])
        AND (MagicBytes[2] = RF64ID[2])
        AND (MagicBytes[3] = RF64ID[3])
        then begin
            Result := affRF64;
            Exit;
        end;
        //* APE
        if (MagicBytes[0] = ORD('M'))
        AND (MagicBytes[1] = ORD('A'))
        AND (MagicBytes[2] = ORD('C'))
        then begin
            Result := affAPE;
            Exit;
        end;
        //* OFR
        if (MagicBytes[0] = Ord('O'))
        AND (MagicBytes[1] = Ord('F'))
        AND (MagicBytes[2] = Ord('R'))
        AND (MagicBytes[3] = Ord(' '))
        then begin
            Result := affOptimFrog;
            Exit;
        end;
        //* MusePack
        if (MagicBytes[0] = ORD('M'))
        AND (MagicBytes[1] = ORD('P'))
        AND (MagicBytes[2] = ORD('+'))
        then begin
            Result := affMusePack;
            Exit;
        end;
        //* FLAC
        if (MagicBytes[0] = ORD('f'))
        AND (MagicBytes[1] = ORD('L'))
        AND (MagicBytes[2] = ORD('a'))
        AND (MagicBytes[3] = ORD('C'))
        then begin
            Result := affFlac;
            Exit;
        end;
        //* DSF
        if (MagicBytes[0] = ORD('D'))
        AND (MagicBytes[1] = ORD('S'))
        AND (MagicBytes[2] = ORD('D'))
        AND (MagicBytes[3] = ORD(' '))
        then begin
            Result := affDSF;
            Exit;
        end;
        //* DFF
        if (MagicBytes[0] = ORD('F'))
        AND (MagicBytes[1] = ORD('R'))
        AND (MagicBytes[2] = ORD('M'))
        AND (MagicBytes[3] = ORD('8'))
        then begin
            Stream.Seek(ID3v2Size + 12, soBeginning);
            Stream.Read(MagicBytes[0], SizeOf(MagicBytes));
            if (MagicBytes[0] = ORD('D'))
            AND (MagicBytes[1] = ORD('S'))
            AND (MagicBytes[2] = ORD('D'))
            AND (MagicBytes[3] = ORD(' '))
            then begin
                Result := affDFF;
                Exit;
            end;
        end;
        //* Ogg container
        Stream.Seek(ID3v2Size, soBeginning);
        Stream.Read(MagicBytes[0], SizeOf(MagicBytes));
        if (MagicBytes[0] = Ord('O'))
        AND (MagicBytes[1] = Ord('g'))
        AND (MagicBytes[2] = Ord('g'))
        AND (MagicBytes[3] = Ord('S'))
        then begin
            //* Ogg FLAC
            Stream.Seek(ID3v2Size + $1C + 1, soBeginning);
            Stream.Read(MagicBytes[0], SizeOf(MagicBytes));
            if (MagicBytes[0] = ORD('F'))
            AND (MagicBytes[1] = ORD('L'))
            AND (MagicBytes[2] = ORD('A'))
            AND (MagicBytes[3] = ORD('C'))
            then begin
                Result := affOggFlac;
                Exit;
            end;
            //* Vorbis or Opus
            OggTag := TOpusTag.Create;
            try
                OggTag.LoadFromStream(Stream);
                if OggTag.Format = ofVorbis then begin
                    Result := affVorbis;
                    Exit;
                end;
                if OggTag.Format = ofOpus then begin
                    Result := affOpus;
                    Exit;
                end;
                if OggTag.Format = ofTheora then begin
                    Result := affTheora;
                    Exit;
                end;
            finally
                FreeAndNil(OggTag);
            end;
        end;
        //* AIFF
        Stream.Seek(ID3v2Size, soBeginning);
        Stream.Read(MagicBytes[0], SizeOf(MagicBytes));
        if (MagicBytes[0] = AIFFID[0])
        AND (MagicBytes[1] = AIFFID[1])
        AND (MagicBytes[2] = AIFFID[2])
        AND (MagicBytes[3] = AIFFID[3])
        then begin
            Stream.Read(AIFFChunkSize, 4);
            Stream.Read(MagicBytes[0], 4);
            //* AIFF
            if (MagicBytes[0] = AIFFChunkID[0])
            AND (MagicBytes[1] = AIFFChunkID[1])
            AND (MagicBytes[2] = AIFFChunkID[2])
            AND (MagicBytes[3] = AIFFChunkID[3])
            then begin
                Result := affAIFF;
                Exit;
            end;
            //* AIFC
            if (MagicBytes[0] = AIFCChunkID[0])
            AND (MagicBytes[1] = AIFCChunkID[1])
            AND (MagicBytes[2] = AIFCChunkID[2])
            AND (MagicBytes[3] = AIFCChunkID[3])
            then begin
                Result := affAIFC;
                Exit;
            end;
        end;
        //* MP4
        Stream.Seek(ID3v2Size, soBeginning);
        Stream.Read(MP4AtomSize, 4);
        MP4AtomSize := ReverseBytes32(MP4AtomSize);
        if MP4AtomSize = 1 then begin
            Stream.Seek(8, soCurrent);
        end;
        Stream.Read(MagicBytes[0], 4);
        if (MagicBytes[0] = ORD('f'))
        AND (MagicBytes[1] = ORD('t'))
        AND (MagicBytes[2] = ORD('y'))
        AND (MagicBytes[3] = ORD('p'))
        then begin
            Result := affMP4;
            Exit;
        end;
        //* WavPack
        WAVPackInfo := TWAVPackfile.Create;
        try
            Stream.Seek(0, soBeginning);
            WAVPackInfo.LoadFromStream(Stream, 0);
            if WAVPackInfo.Valid then begin
                Result := affWavPack;
                Exit;
            end;
        finally
            FreeAndNil(WAVPackInfo);
        end;
        //* MusePack 2nd try
        MusePackInfo := TMPEGplus.Create;
        try
            Stream.Seek(0, soBeginning);
            MusePackInfo.LoadFromStream(Stream, ID3v2Size, 0);
            if MusePackInfo.Valid then begin
                Result := affMusePack;
                Exit;
            end;
        finally
            FreeAndNil(MusePackInfo);
        end;
        //* MPEG
        Stream.Seek(ID3v2Size, soBeginning);
        i := 0;
        Data := 0;
        repeat
            Stream.Read(Data, 1);
            if Data = $FF then begin
                Stream.Read(Data, 1);
                if (Data = $F9)
                OR (Data = $FA)
                OR (Data = $FB)
                OR (Data = $FC)
                OR (Data = $FD)
                OR (Data = $F2)
                OR (Data = $F3)
                OR (Data = $E3)
                then begin
                    Stream.Seek(- 2, soCurrent);
                    Result := affMPEG;
                    Exit;
                end;
            end;
            Inc(i);
        until i > MPEG_SEARCH_LENGTH;
    except
        //*
    end;
end;

{$IFDEF MSWINDOWS}
{$WARN SYMBOL_PLATFORM OFF}
function SetDateToFile(const FileName: string; Value: TDateTime): Boolean;
var
    HFile: THandle;
begin
    Result := False;
    HFile := 0;
    try
        { Open a file handle }
        HFile := FileOpen(FileName, fmOpenWrite or fmShareDenyNone);
        { If opened succesfully }
        if (HFile > 0) then begin
            { Convert a datetime into DOS format and set a date }
            Result := (FileSetDate(HFile, DateTimeToFileDate(Value)) = 0);
        end;
    finally
        { Close an opened file handle }
        FileClose(HFile);
    end;
end;
{$WARN SYMBOL_PLATFORM ON}
{$ENDIF}

Initialization

    TagsLibraryDefaultTagLoadPriority[0] := ttFlac;
    TagsLibraryDefaultTagLoadPriority[1] := ttOpusVorbis;
    TagsLibraryDefaultTagLoadPriority[2] := ttMP4;
    TagsLibraryDefaultTagLoadPriority[3] := ttWMA;
    TagsLibraryDefaultTagLoadPriority[4] := ttID3v2;
    TagsLibraryDefaultTagLoadPriority[5] := ttAPEv2;
    TagsLibraryDefaultTagLoadPriority[6] := ttWAV;
    TagsLibraryDefaultTagLoadPriority[7] := ttID3v1;

end.

