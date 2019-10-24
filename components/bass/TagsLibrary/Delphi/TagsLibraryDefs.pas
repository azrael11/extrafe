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

unit TagsLibraryDefs;

interface

{$IFDEF MSWINDOWS}
Uses
    Windows;
{$ENDIF}

{$MINENUMSIZE 4}

type
    Bool = LongBool;
    DWord = Cardinal;

const
    NAME_TagsLibrary_Create                 = 'TagsLibrary_Create';
    NAME_TagsLibrary_Free                   = 'TagsLibrary_Free';
    NAME_TagsLibrary_Load                   = 'TagsLibrary_Load';
    NAME_TagsLibrary_LoadFromMemory         = 'TagsLibrary_LoadFromMemory';
    NAME_TagsLibrary_LoadFromBASS           = 'TagsLibrary_LoadFromBASS';
    NAME_TagsLibrary_Save                   = 'TagsLibrary_Save';
    NAME_TagsLibrary_SaveEx                 = 'TagsLibrary_SaveEx';
    NAME_TagsLibrary_SaveToMemory           = 'TagsLibrary_SaveToMemory';
    NAME_TagsLibrary_SaveToMemoryEx         = 'TagsLibrary_SaveToMemoryEx';
    NAME_TagsLibrary_FreeSaveHandle         = 'TagsLibrary_FreeSaveHandle';
    NAME_TagsLibrary_RemoveTag              = 'TagsLibrary_RemoveTag';
    NAME_TagsLibrary_RemoveTagFromMemory    = 'TagsLibrary_RemoveTagFromMemory';
    NAME_TagsLibrary_Loaded                 = 'TagsLibrary_Loaded';
    NAME_TagsLibrary_GetTag                 = 'TagsLibrary_GetTag';
    NAME_TagsLibrary_GetTagEx               = 'TagsLibrary_GetTagEx';
    NAME_TagsLibrary_GetTagByIndexEx        = 'TagsLibrary_GetTagByIndexEx';
    NAME_TagsLibrary_SetTag                 = 'TagsLibrary_SetTag';
    NAME_TagsLibrary_SetTagEx               = 'TagsLibrary_SetTagEx';
    NAME_TagsLibrary_AddTag                 = 'TagsLibrary_AddTag';
    NAME_TagsLibrary_AddTagEx               = 'TagsLibrary_AddTagEx';
    NAME_TagsLibrary_TagCount               = 'TagsLibrary_TagCount';
    NAME_TagsLibrary_DeleteTag              = 'TagsLibrary_DeleteTag';
    NAME_TagsLibrary_DeleteTagByIndex       = 'TagsLibrary_DeleteTagByIndex';
    NAME_TagsLibrary_CoverArtCount          = 'TagsLibrary_CoverArtCount';
    NAME_TagsLibrary_GetCoverArt            = 'TagsLibrary_GetCoverArt';
    NAME_TagsLibrary_GetCoverArtToFile      = 'TagsLibrary_GetCoverArtToFile';
    NAME_TagsLibrary_DeleteCoverArt         = 'TagsLibrary_DeleteCoverArt';
    NAME_TagsLibrary_SetCoverArt            = 'TagsLibrary_SetCoverArt';
    NAME_TagsLibrary_SetCoverArtFromFile    = 'TagsLibrary_SetCoverArtFromFile';
    NAME_TagsLibrary_AddCoverArt            = 'TagsLibrary_AddCoverArt';
    NAME_TagsLibrary_SetTagLoadPriority     = 'TagsLibrary_SetTagLoadPriority';
    NAME_TagsLibrary_GetTagData             = 'TagsLibrary_GetTagData';
    NAME_TagsLibrary_SetTagData             = 'TagsLibrary_SetTagData';
    NAME_TagsLibrary_GetCARTPostTimer       = 'TagsLibrary_GetCARTPostTimer';
    NAME_TagsLibrary_SetCARTPostTimer       = 'TagsLibrary_SetCARTPostTimer';
    NAME_TagsLibrary_ClearCARTPostTimer     = 'TagsLibrary_ClearCARTPostTimer';
    NAME_TagsLibrary_GetConfig              = 'TagsLibrary_GetConfig';
    NAME_TagsLibrary_SetConfig              = 'TagsLibrary_SetConfig';
    NAME_TagsLibrary_GetVendor              = 'TagsLibrary_GetVendor';
    NAME_TagsLibrary_SetVendor              = 'TagsLibrary_SetVendor';
    NAME_TagsLibrary_GetAudioAttributes     = 'TagsLibrary_GetAudioAttributes';
    NAME_TagsLibrary_GetAudioAttribute      = 'TagsLibrary_GetAudioAttribute';
    NAME_TagsLibrary_GetTagSize             = 'TagsLibrary_GetTagSize';
    NAME_TagsLibrary_GetAudioFormat         = 'TagsLibrary_GetAudioFormat';
    NAME_TagsLibrary_GetAudioFormatMemory   = 'TagsLibrary_GetAudioFormatMemory';

const
    {$IFDEF MSWINDOWS}
    TagsLibraryName = 'TagsLib.dll';
    {$ENDIF}
    {$IFDEF MACOS}
    TagsLibraryName = 'libTagsLib.dylib';
    {$ENDIF}

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
    TAGSLIBRARY_ERROR_NOT_ENOUGH_MEMORY_OR_AV                       = 21;

Const
    TAGSLIBRARY_PADDING_SIZE_TO_WRITE                               = 1;
    TAGSLIBRARY_PARSE_OGG_PLAYTIME                                  = 2;
    TAGSLIBRARY_PARSE_ID3v2_AUDIO_ATTRIBUTES                        = 3;
    TAGSLIBRARY_MP4TAG_KEEP_PADDING                                 = 4;
    TAGSLIBRARY_PARSE_WAVPACK_AUDIO_ATTRIBUTES                      = 5;
    TAGSLIBRARY_PARSE_MUSEPACK_AUDIO_ATTRIBUTES                     = 6;
    TAGSLIBRARY_DEEP_OPUS_BITRATE_SCAN                              = 7;

type
    HTags = Pointer;

type
    TTagType = (ttNone, ttAutomatic, ttAPEv2, ttFlac, ttID3v1, ttID3v2, ttMP4, ttOpusVorbis, ttWAV, ttWMA);

type
    TTagPictureFormat = (tpfUnknown, tpfJPEG, tpfPNG, tpfBMP, tpfGIF);

type
    TTagPriority = packed Array [0..8] of TTagType;

type
    TExtTagType = (ettUnknown, ettTXXX, ettWXXX);

type
    PExtTag = ^TExtTag;
    TExtTag = packed record
        Name: PWideChar;
        Value: PWideChar;
        ValueSize: Integer;
        Language: PWideChar;
        Description: PWideChar;
        ExtTagType: TExtTagType;
        Index: Integer;
    end;

type
    PSimpleTag = ^TSimpleTag;
    TSimpleTag = packed record
        Name: PWideChar;
        Value: PWideChar;
        ValueSize: Integer;
        Index: Integer;
    end;

type
    TID3v2TagType = (id3v2ttUnknown, id3v2ttText, id3v2ttTextWithDescription, id3v2ttTextWithDescriptionAndLangugageID, id3v2ttURL, id3v2ttUserDefinedURL, id3v2ttPlayCount, id3v2ttBinary);

type
    PID3v2TagEx = ^TID3v2TagEx;
    TID3v2TagEx = packed record
        Name: PWideChar;
        Value: PWideChar;
        ValueSize: Integer;
        Language: PWideChar;
        Description: PWideChar;
        TagType: TID3v2TagType;
        Index: Integer;
    end;

type
    TMP4TagType = (mp4ttUnknown, mp4ttText, mp4ttInteger8, mp4ttInteger16, mp4ttInteger32, mp4ttInteger48, mp4ttInteger64);

type
    PMP4TagEx = ^TMP4TagEx;
    TMP4TagEx = packed record
        Name: PWideChar;
        Value: PWideChar;
        ValueSize: Integer;
        NameValue: PWideChar;
        MeanValue: PWideChar;
        TagType: TMP4TagType;
        DataType: Integer;
        Index: Integer;
    end;

type
    TCoverArtData = packed record
        Name: PWideChar;
        Data: Pointer;
        DataSize: Int64;
        Description: PWideChar;
        CoverType: DWord;
        MIMEType: PWideChar;
        PictureFormat: TTagPictureFormat;
        Width: DWord;
        Height: DWord;
        ColorDepth: DWord;
        NoOfColors: DWord;
        ID3v2TextEncoding: Integer;
        Index: Integer;
    end;

type
    TTagData = packed record
        Name: PWideChar;
        Data: Pointer;
        DataSize: Int64;
        DataType: Integer;
    end;

type
    TCARTPostTimer = packed record
        Usage: PWideChar;
        Value: DWord;
    end;

type
    TAudioType = (atAutomatic, atFlac, atMPEG, atDSDDSF, atWAV, atAIFF, atMP4, atOpus, atVorbis, atWMA, atWAVPack, atMusePack, atDSDDFF);

type
    TMPEGVersion = (tmpegvUnknown, tmpegv1, tmpegv2, tmpegv25);

    TMPEGLayer = (tmpeglUnknown, tmpegl1, tmpegl2, tmpegl3);

    TMPEGChannelMode = (tmpegcmUnknown, tmpegcmMono, tmpegcmDualChannel, tmpegcmJointStereo, tmpegcmStereo);

    TMPEGModeExtension = (tmpegmeUnknown, tmpegmeNone, tmpegmeIntensity, tmpegmeMS, tmpegmeIntensityMS);

    TMPEGEmphasis = (tmpegeUnknown, tmpegeNo, tmpege5015, tmpegeCCITJ17);

    PMPEGAudioAttributes = ^TMPEGAudioAttributes;
    TMPEGAudioAttributes = packed record
        Position: Int64;                //* Position of header in bytes
        Header: DWord;                  //* The Headers bytes
        FrameSize: Integer;             //* Frame's length
        Version: TMPEGVersion;          //* MPEG Version
        Layer: TMPEGLayer;              //* MPEG Layer
        CRC: LongBool;                  //* Frame has CRC
        BitRate: DWord;                 //* Frame's bitrate
        SampleRate: DWord;              //* Frame's sample rate
        Padding: LongBool;              //* Frame is padded
        _Private: LongBool;             //* Frame's private bit is set
        ChannelMode: TMPEGChannelMode;  //* Frame's channel mode
        ModeExtension: TMPEGModeExtension; //* Joint stereo only
        Copyrighted: LongBool;          //* Frame's Copyright bit is set
        Original: LongBool;             //* Frame's Original bit is set
        Emphasis: TMPEGEmphasis;        //* Frame's emphasis mode
        VBR: LongBool;                  //* Stream is probably VBR
        FrameCount: Int64;              //* Total number of MPEG frames (by header)
        Quality: Integer;               //* MPEG quality (by header)
        Bytes: Int64;                   //* Total bytes (by header)
    end;

type
    PFlacAudioAttributes = ^TFlacAudioAttributes;
    TFlacAudioAttributes = packed record
        Channels: DWord;
        SampleRate: Integer;
        BitsPerSample: DWord;
        SampleCount: Int64;
        Playtime: Double;       // Duration (seconds)
        Ratio: Double;          // Compression ratio (%)
        ChannelMode: PWideChar;
        Bitrate: Integer;
    end;

type
    TDSFChannelType = (dsfctUnknown, dsfctMono, dsfctStereo, dsfct3Channels, dsfctQuad, dsfct4Channels, dsfct5Channels, dsfct51Channels);

type
    PDSFAudioAttributes = ^TDSFAudioAttributes;
    TDSFAudioAttributes = packed record
        FormatVersion: DWord;
        FormatID: DWord;
        ChannelType: TDSFChannelType;
        ChannelNumber: DWord;
        SamplingFrequency: DWord;
        BitsPerSample: DWord;
        BlockSizePerChannel: DWord;
        PlayTime: Double;
        SampleCount: UInt64;
        Bitrate: Integer;
    end;

type
    PDFFAudioAttributes = ^TDFFAudioAttributes;
    TDFFAudioAttributes = packed record
        FormatVersion: PChar;
        SampleRate: DWord;
        ChannelNumber: DWord;
        CompressionName: PChar;
        SampleCount: UInt64;
        PlayTime: Double;
        BitRate: DWord;
        SoundDataLength: UInt64;
        DSTFramesCount: DWord;
        DSTFramesRate: DWord;
        Ratio: Double;
    end;

type
    POpusAudioAttributes = ^TOpusAudioAttributes;
    TOpusAudioAttributes = packed record
        BitstreamVersion: DWord;                        { Bitstream version number }
        ChannelCount: DWord;                                  { Number of channels }
        PreSkip: DWord;
        SampleRate: DWord;                                     { Sample rate (hz) }
        OutputGain: DWord;
        MappingFamily: DWord;                                            { 0,1,255 }
        PlayTime: Double;
        SampleCount: UInt64;
        BitRate: Integer;
    end;

type
    PVorbisAudioAttributes = ^TVorbisAudioAttributes;
    TVorbisAudioAttributes = packed record
        BitstreamVersion: packed array [1..4] of Byte;        { Bitstream version number }
        ChannelMode: DWord;                                   { Number of channels }
        SampleRate: Integer;                                   { Sample rate (hz) }
        BitRateMaximal: Integer;                           { Bit rate upper limit }
        BitRateNominal: Integer;                               { Nominal bit rate }
        BitRateMinimal: Integer;                           { Bit rate lower limit }
        BlockSize: DWord;                   { Coded size for small and long blocks }
        PlayTime: Double;
        SampleCount: UInt64;
        BitRate: Integer;
    end;

type
    PWAVEAudioAttributes = ^TWAVEAudioAttributes;
    TWAVEAudioAttributes = packed record
        FormatTag: DWord;                    // format type
        Channels: DWord;                     // number of channels (i.e. mono, stereo, etc.)
        SamplesPerSec: DWord;               //sample rate
        AvgBytesPerSec: DWord;              //for buffer estimation
        BlockAlign: DWord;                   //block size of data
        BitsPerSample: DWord;                //number of bits per sample of mono data
        PlayTime: Double;
        SampleCount: UInt64;
        cbSize: DWord;	                    // Size of the extension: 22
        ValidBitsPerSample: DWord;	        // at most 8 *  M
        ChannelMask: DWord;	                // Speaker position mask: 0
        SubFormat: packed Array[0..15] of Byte;    // 16
        BitRate: Integer;
    end;

type
    PAIFFAttributes = ^TAIFFAttributes;
    TAIFFAttributes = packed record
        Channels: DWord;
        SampleCount: DWord;
        SampleSize: DWord;
        SampleRate: Double;
        CompressionID: packed Array [0..3] of Byte;  // http://en.wikipedia.org/wiki/Audio_Interchange_File_Format
        Compression: PWideChar;
        PlayTime: Double;
        BitRate: Integer;
    end;

type
    PMP4AudioAttributes = ^TMP4AudioAttributes;
    TMP4AudioAttributes = packed record
        Channels: DWord;
        SampleRate: Integer;
        BitsPerSample: DWord;
        Playtime: Double;       // Duration (seconds)
        Bitrate: Integer;
    end;

{$IFDEF MSWINDOWS}
type
    PWMAAttributes = ^TWMAAttributes;
    TWMAAttributes = packed record
        PlayTime: Double;
        BitRate: Integer;
    end;
{$ENDIF}

type
    PAudioAttributes = ^TAudioAttributes;
    TAudioAttributes = packed record
        Channels: DWord;                     // number of channels (i.e. mono, stereo, etc.)
        SamplesPerSec: DWord;               //sample rate
        BitsPerSample: DWord;                //number of bits per sample of mono data
        PlayTime: Double;
        SampleCount: UInt64;
        BitRate: Integer;
    end;

type
    TAudioAttribute = (aaChannels, aaSamplesPerSec, aaBitsPerSample, aaPlayTime, aaSampleCount, aaBitRate);

type
    PWAVPackAttributes = ^TWAVPackAttributes;
    TWAVPackAttributes = packed record
        FormatTag: Integer;
        Version: Integer;
		Channels: Integer;
		ChannelMode: PChar;
		SampleRate: Integer;
		Bits: Integer;
		Bitrate: Double;
		PlayTime: Double;
        Samples: Int64;
        BSamples: Int64;
        Ratio: Double;
        Encoder: PChar;
    end;

type
    PMusePackAttributes = ^TMusePackAttributes;
    TMusePackAttributes = packed record
        ChannelModeID: Byte;                { Channel mode code }
        ChannelMode: PChar;                 { Channel mode name }
        FrameCount: Integer;                { Number of frames }
        BitRate: Word;                      { Bit rate }
        StreamVersion: Byte;                { Stream version }
        StreamStreamVersionString: PChar;
        SampleRate: Integer;
        ProfileID: Byte;                    { Profile code }
        Profile: PChar;                     { Profile name }
        PlayTime: Double;                   { Duration (seconds) }
        Encoder: PChar;                     { Encoder used }
        Ratio: Double;                      { Compression ratio (%) }
    end;

type
    TAudioFileFormat = (affUnknown, affAPE, affFlac, affOggFlac, affMPEG, affMP4, affOpus, affVorbis, affTheora, affWAV, affRF64, affAIFF, affAIFC, affDFF, affDSF, affOptimFrog, affMusePack, affWavPack);

type
    t_TagsLibrary_Create                = function : HTags; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_Free                  = function (Tags: HTags): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_Load                  = function (Tags: HTags; FileName: PWideChar; TagType: TTagType; ParseTags: LongBool): Integer; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_LoadFromMemory        = function (Tags: HTags; MemoryAddress: Pointer; Size: UInt64; TagType: TTagType; ParseTags: LongBool): Integer; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_LoadFromBASS          = function (Tags: HTags; Channel: Cardinal): Integer; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_Save                  = function (Tags: HTags; FileName: PWideChar; TagType: TTagType): Integer; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_SaveEx                = function (Tags: HTags; FileName: PWideChar; TagType: TTagType): Integer; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_SaveToMemory          = function (Tags: HTags; MemoryAddress: Pointer; Size: UInt64; TagType: TTagType; var SavedAddress: Pointer; var SavedSize: UInt64; var SaveHandle: Pointer): Integer; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_SaveToMemoryEx        = function (Tags: HTags; MemoryAddress: Pointer; Size: UInt64; TagType: TTagType; var SavedAddress: Pointer; var SavedSize: UInt64; var SaveHandle: Pointer): Integer; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_FreeSaveHandle        = function (var SaveHandle: Pointer): Integer; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_RemoveTag             = function (FileName: PWideChar; TagType: TTagType): Integer; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_RemoveTagFromMemory   = function (MemoryAddress: Pointer; Size: UInt64; TagType: TTagType; var SavedAddress: Pointer; var SavedSize: UInt64; var SaveHandle: Pointer): Integer; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_GetTag                = function (Tags: HTags; Name: PWideChar; TagType: TTagType): PWideChar; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_Loaded                = function (Tags: HTags; TagType: TTagType): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_GetTagEx              = function (Tags: HTags; Name: PWideChar; TagType: TTagType; ExtTag: Pointer): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_GetTagByIndexEx       = function (Tags: HTags; Index: Integer; TagType: TTagType; ExtTag: Pointer): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_SetTag                = function (Tags: HTags; Name: PWideChar; Value: PWideChar; TagType: TTagType): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_SetTagEx              = function (Tags: HTags; TagType: TTagType; ExtTag: Pointer): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_AddTag                = function (Tags: HTags; Name: PWideChar; Value: PWideChar; TagType: TTagType): Integer; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_AddTagEx              = function (Tags: HTags; TagType: TTagType; ExtTag: Pointer): Integer; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_TagCount              = function (Tags: HTags; TagType: TTagType): Integer; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_DeleteTag             = function (Tags: HTags; Name: PWideChar; TagType: TTagType): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_DeleteTagByIndex      = function (Tags: HTags; Index: Integer; TagType: TTagType): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_CoverArtCount         = function (Tags: HTags; TagType: TTagType): Integer; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_GetCoverArt           = function (Tags: HTags; TagType: TTagType; Index: Integer; var CoverArt: TCoverArtData): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_GetCoverArtToFile     = function (Tags: HTags; TagType: TTagType; Index: Integer; FileName: PChar): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_DeleteCoverArt        = function (Tags: HTags; TagType: TTagType; Index: Integer): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_SetCoverArt           = function (Tags: HTags; TagType: TTagType; Index: Integer; var CoverArt: TCoverArtData): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_SetCoverArtFromFile   = function (Tags: HTags; TagType: TTagType; Index: Integer; FileName: PChar; CoverArt: TCoverArtData): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_AddCoverArt           = function (Tags: HTags; TagType: TTagType; CoverArt: TCoverArtData): Integer; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_SetTagLoadPriority    = function (Tags: HTags; TagPriorities: TTagPriority): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_GetTagData            = function (Tags: HTags; Index: Integer; TagType: TTagType; var TagData: TTagData): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_SetTagData            = function (Tags: HTags; Index: Integer; TagType: TTagType; TagData: TTagData): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_GetCARTPostTimer      = function (Tags: HTags; Index: Integer; var PostTimer: TCARTPostTimer): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_SetCARTPostTimer      = function (Tags: HTags; Index: Integer; PostTimer: TCARTPostTimer): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_ClearCARTPostTimer    = function (Tags: HTags; Index: Integer): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_GetConfig             = function (Tags: HTags; Option: Integer; TagType: TTagType): Pointer; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_SetConfig             = function (Tags: HTags; Value: Pointer{NativeUInt}; Option: Integer; TagType: TTagType): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_GetVendor             = function (Tags: HTags; TagType: TTagType): PWideChar; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_SetVendor             = function (Tags: HTags; Vendor: PWideChar; TagType: TTagType): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_GetAudioAttributes    = function (Tags: HTags; AudioType: TAudioType; Attributes: Pointer): LongBool; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_GetAudioAttribute     = function (Tags: HTags; Attribute: TAudioAttribute): Double; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_GetTagSize            = function (Tags: HTags; TagType: TTagType): DWORD; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_GetAudioFormat        = function (FileName: PChar): TAudioFileFormat; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};
    t_TagsLibrary_GetAudioFormatMemory  = function (MemoryAddress: Pointer; Size: UInt64): TAudioFileFormat; {$IFDEF MSWINDOWS}stdcall{$ELSE}cdecl{$ENDIF};

var
    TagsLibrary_Create: t_TagsLibrary_Create;
    TagsLibrary_Free: t_TagsLibrary_Free;
    TagsLibrary_Load: t_TagsLibrary_Load;
    TagsLibrary_LoadFromMemory: t_TagsLibrary_LoadFromMemory;
    TagsLibrary_LoadFromBASS: t_TagsLibrary_LoadFromBASS;
    TagsLibrary_Save: t_TagsLibrary_Save;
    TagsLibrary_SaveEx: t_TagsLibrary_SaveEx;
    TagsLibrary_SaveToMemory: t_TagsLibrary_SaveToMemory;
    TagsLibrary_SaveToMemoryEx: t_TagsLibrary_SaveToMemoryEx;
    TagsLibrary_FreeSaveHandle: t_TagsLibrary_FreeSaveHandle;
    TagsLibrary_RemoveTag: t_TagsLibrary_RemoveTag;
    TagsLibrary_RemoveTagFromMemory: t_TagsLibrary_RemoveTagFromMemory;
    TagsLibrary_Loaded: t_TagsLibrary_Loaded;
    TagsLibrary_GetTag: t_TagsLibrary_GetTag;
    TagsLibrary_GetTagEx: t_TagsLibrary_GetTagEx;
    TagsLibrary_GetTagByIndexEx: t_TagsLibrary_GetTagByIndexEx;
    TagsLibrary_SetTag: t_TagsLibrary_SetTag;
    TagsLibrary_SetTagEx: t_TagsLibrary_SetTagEx;
    TagsLibrary_AddTag: t_TagsLibrary_AddTag;
    TagsLibrary_AddTagEx: t_TagsLibrary_AddTagEx;
    TagsLibrary_TagCount: t_TagsLibrary_TagCount;
    TagsLibrary_DeleteTag: t_TagsLibrary_DeleteTag;
    TagsLibrary_DeleteTagByIndex: t_TagsLibrary_DeleteTagByIndex;
    TagsLibrary_CoverArtCount: t_TagsLibrary_CoverArtCount;
    TagsLibrary_GetCoverArt: t_TagsLibrary_GetCoverArt;
    TagsLibrary_GetCoverArtToFile: t_TagsLibrary_GetCoverArtToFile;
    TagsLibrary_DeleteCoverArt: t_TagsLibrary_DeleteCoverArt;
    TagsLibrary_SetCoverArt: t_TagsLibrary_SetCoverArt;
    TagsLibrary_SetCoverArtFromFile: t_TagsLibrary_SetCoverArtFromFile;
    TagsLibrary_AddCoverArt: t_TagsLibrary_AddCoverArt;
    TagsLibrary_SetTagLoadPriority: t_TagsLibrary_SetTagLoadPriority;
    TagsLibrary_GetTagData: t_TagsLibrary_GetTagData;
    TagsLibrary_SetTagData: t_TagsLibrary_SetTagData;
    TagsLibrary_GetCARTPostTimer: t_TagsLibrary_GetCARTPostTimer;
    TagsLibrary_SetCARTPostTimer: t_TagsLibrary_SetCARTPostTimer;
    TagsLibrary_ClearCARTPostTimer: t_TagsLibrary_ClearCARTPostTimer;
    TagsLibrary_GetConfig: t_TagsLibrary_GetConfig;
    TagsLibrary_SetConfig: t_TagsLibrary_SetConfig;
    TagsLibrary_GetVendor: t_TagsLibrary_GetVendor;
    TagsLibrary_SetVendor: t_TagsLibrary_SetVendor;
    TagsLibrary_GetAudioAttributes: t_TagsLibrary_GetAudioAttributes;
    TagsLibrary_GetAudioAttribute: t_TagsLibrary_GetAudioAttribute;
    TagsLibrary_GetTagSize: t_TagsLibrary_GetTagSize;
    TagsLibrary_GetAudioFormat: t_TagsLibrary_GetAudioFormat;
    TagsLibrary_GetAudioFormatMemory: t_TagsLibrary_GetAudioFormatMemory;


var
    TagsLibraryHandle: THandle = 0;
    TagsLibraryLoaded: Boolean = False;

    function InitTagsLibrary: Boolean;
    function FreeTagsLibrary: Boolean;

implementation

Uses
    SysUtils;

function InitTagsLibrary: Boolean;
begin
    TagsLibraryHandle := LoadLibrary(PChar(TagsLibraryName));
    Result := TagsLibraryHandle <> 0;
    if Result then begin
        TagsLibrary_Create              := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_Create));
        TagsLibrary_Free                := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_Free));
        TagsLibrary_Load                := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_Load));
        TagsLibrary_LoadFromMemory      := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_LoadFromMemory));
        TagsLibrary_LoadFromBASS        := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_LoadFromBASS));
        TagsLibrary_Save                := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_Save));
        TagsLibrary_SaveEx              := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_SaveEx));
        TagsLibrary_SaveToMemory        := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_SaveToMemory));
        TagsLibrary_SaveToMemoryEx      := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_SaveToMemoryEx));
        TagsLibrary_FreeSaveHandle      := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_FreeSaveHandle));
        TagsLibrary_RemoveTag           := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_RemoveTag));
        TagsLibrary_RemoveTagFromMemory := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_RemoveTagFromMemory));
        TagsLibrary_Loaded              := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_Loaded));
        TagsLibrary_GetTag              := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_GetTag));
        TagsLibrary_GetTagEx            := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_GetTagEx));
        TagsLibrary_GetTagByIndexEx     := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_GetTagByIndexEx));
        TagsLibrary_SetTag              := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_SetTag));
        TagsLibrary_SetTagEx            := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_SetTagEx));
        TagsLibrary_AddTag              := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_AddTag));
        TagsLibrary_AddTagEx            := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_AddTagEx));
        TagsLibrary_TagCount            := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_TagCount));
        TagsLibrary_DeleteTag           := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_DeleteTag));
        TagsLibrary_DeleteTagByIndex    := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_DeleteTagByIndex));
        TagsLibrary_CoverArtCount       := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_CoverArtCount));
        TagsLibrary_GetCoverArt         := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_GetCoverArt));
        TagsLibrary_GetCoverArtToFile   := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_GetCoverArtToFile));
        TagsLibrary_DeleteCoverArt      := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_DeleteCoverArt));
        TagsLibrary_SetCoverArt         := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_SetCoverArt));
        TagsLibrary_SetCoverArtFromFile := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_SetCoverArtFromFile));
        TagsLibrary_AddCoverArt         := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_AddCoverArt));
        TagsLibrary_SetTagLoadPriority  := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_SetTagLoadPriority));
        TagsLibrary_GetTagData          := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_GetTagData));
        TagsLibrary_SetTagData          := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_SetTagData));
        TagsLibrary_GetCARTPostTimer    := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_GetCARTPostTimer));
        TagsLibrary_SetCARTPostTimer    := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_SetCARTPostTimer));
        TagsLibrary_ClearCARTPostTimer  := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_ClearCARTPostTimer));
        TagsLibrary_GetConfig           := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_GetConfig));
        TagsLibrary_SetConfig           := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_SetConfig));
        TagsLibrary_GetVendor           := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_GetVendor));
        TagsLibrary_SetVendor           := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_SetVendor));
        TagsLibrary_GetAudioAttributes  := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_GetAudioAttributes));
        TagsLibrary_GetAudioAttribute   := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_GetAudioAttribute));
        TagsLibrary_GetTagSize          := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_GetTagSize));
        TagsLibrary_GetAudioFormat      := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_GetAudioFormat));
        TagsLibrary_GetAudioFormatMemory := GetProcAddress(TagsLibraryHandle, PWideChar(NAME_TagsLibrary_GetAudioFormatMemory));
    end;
    if (@TagsLibrary_Create = nil)
    OR (@TagsLibrary_Free = nil)
    OR (@TagsLibrary_Load = nil)
    OR (@TagsLibrary_LoadFromMemory = nil)
    OR (@TagsLibrary_LoadFromBASS = nil)
    OR (@TagsLibrary_Save = nil)
    OR (@TagsLibrary_SaveEx = nil)
    OR (@TagsLibrary_SaveToMemory = nil)
    OR (@TagsLibrary_SaveToMemoryEx = nil)
    OR (@TagsLibrary_FreeSaveHandle = nil)
    OR (@TagsLibrary_RemoveTag = nil)
    OR (@TagsLibrary_RemoveTagFromMemory = nil)
    OR (@TagsLibrary_Loaded = nil)
    OR (@TagsLibrary_GetTag = nil)
    OR (@TagsLibrary_GetTagEx = nil)
    OR (@TagsLibrary_GetTagByIndexEx = nil)
    OR (@TagsLibrary_SetTag = nil)
    OR (@TagsLibrary_SetTagEx = nil)
    OR (@TagsLibrary_AddTag = nil)
    OR (@TagsLibrary_AddTagEx = nil)
    OR (@TagsLibrary_TagCount = nil)
    OR (@TagsLibrary_DeleteTag = nil)
    OR (@TagsLibrary_DeleteTagByIndex = nil)
    OR (@TagsLibrary_CoverArtCount = nil)
    OR (@TagsLibrary_GetCoverArt = nil)
    OR (@TagsLibrary_GetCoverArtToFile = nil)
    OR (@TagsLibrary_DeleteCoverArt = nil)
    OR (@TagsLibrary_SetCoverArt = nil)
    OR (@TagsLibrary_SetCoverArtFromFile = nil)
    OR (@TagsLibrary_AddCoverArt = nil)
    OR (@TagsLibrary_SetTagLoadPriority = nil)
    OR (@TagsLibrary_GetTagData = nil)
    OR (@TagsLibrary_SetTagData = nil)
    OR (@TagsLibrary_GetCARTPostTimer = nil)
    OR (@TagsLibrary_SetCARTPostTimer = nil)
    OR (@TagsLibrary_ClearCARTPostTimer = nil)
    OR (@TagsLibrary_GetConfig = nil)
    OR (@TagsLibrary_SetConfig = nil)
    OR (@TagsLibrary_GetVendor = nil)
    OR (@TagsLibrary_SetVendor = nil)
    OR (@TagsLibrary_GetAudioAttributes = nil)
    OR (@TagsLibrary_GetAudioAttribute = nil)
    OR (@TagsLibrary_GetTagSize = nil)
    OR (@TagsLibrary_GetAudioFormat = nil)
    OR (@TagsLibrary_GetAudioFormatMemory = nil)
    then begin
    	FreeLibrary(TagsLibraryHandle);
    	Result := False;
    end;
    if Result
        then TagsLibraryLoaded := True;
end;

function FreeTagsLibrary: Boolean;
begin
    Result := False;
    if TagsLibraryHandle <> 0 then begin
        Result := FreeLibrary(TagsLibraryHandle);
        if Result then begin
            TagsLibraryHandle := 0;
            TagsLibraryLoaded := False;
        end;
    end;
end;

Initialization

    InitTagsLibrary;

Finalization

    FreeTagsLibrary;

end.


