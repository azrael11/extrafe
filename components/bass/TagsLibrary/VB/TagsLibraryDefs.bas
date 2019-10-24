Attribute VB_Name = "modTagsLibrary"
Option Explicit
'1. Load the library by calling 'InitTagsLibrary
'2. Create a tags object by calling 'TagsLibrary_Create', will return the object handle to be used in the next steps
'3. Call 'TagsLibrary_Load' use 'ttAutomatic' for 'TagType' and use 'True' for 'ParseTags
'4. Get tag with the function 'TagsLibrary_GetTag'/ set tag with 'TagsLibrary_SetTag
'5. To save the tag use 'TagsLibrary_Save
'6. To free the resources used by the object call 'TagsLibrary_Free
'7. When exiting the application call 'FreeTagsLibrary
' Tags Library Visual Basic module
' Copyright (c) 2014-2015 3delite.

' See the Tags Library ReadMe.txt file for more detailed documentation

' NOTE: Use "StrPtr(string)" for functions expecting a wide string pointer.

' NOTE: Use the LPWSTRtoBSTR function to convert "char *" to VB "String".

' A number of incorrectly translated Declares & Types fixed by Bonnie West on Feb 6, 2015.

Private Const SIZEOF_INT64 As Long = 8

Public Const TagsLibraryName As String = "TagsLib.dll"

Public Const TAGSLIBRARY_SUCCESS                                           As Long = 0
Public Const TAGSLIBRARY_ERROR                                             As Long = &HFFFF '-1&
Public Const TAGSLIBRARY_ERROR_NO_TAG_FOUND                                As Long = 1
Public Const TAGSLIBRARY_ERROR_FILENOTFOUND                                As Long = 2
Public Const TAGSLIBRARY_ERROR_EMPTY_TAG                                   As Long = 3
Public Const TAGSLIBRARY_ERROR_EMPTY_FRAMES                                As Long = 4
Public Const TAGSLIBRARY_ERROR_OPENING_FILE                                As Long = 5
Public Const TAGSLIBRARY_ERROR_READING_FILE                                As Long = 6
Public Const TAGSLIBRARY_ERROR_WRITING_FILE                                As Long = 7
Public Const TAGSLIBRARY_ERROR_CORRUPT                                     As Long = 8
Public Const TAGSLIBRARY_ERROR_NOT_SUPPORTED_VERSION                       As Long = 9
Public Const TAGSLIBRARY_ERROR_NOT_SUPPORTED_FORMAT                        As Long = 10
Public Const TAGSLIBRARY_ERROR_BASS_NOT_LOADED                             As Long = 11
Public Const TAGSLIBRARY_ERROR_BASS_ChannelGetTags_NOT_FOUND               As Long = 12
Public Const TAGSLIBRARY_ERROR_DOESNT_FIT                                  As Long = 13
Public Const TAGSLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS                       As Long = 14
Public Const TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNTLOADDLL                As Long = 15
Public Const TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNOTCREATEMETADATAEDITOR  As Long = 16
Public Const TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNOTQIFORIWMHEADERINFO3   As Long = 17
Public Const TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNOTQUERY_ATTRIBUTE_COUNT As Long = 18
Public Const TAGSLIBRARY_ERROR_MP4TAGLIBRARY_UPDATE_stco                   As Long = 19
Public Const TAGSLIBRARY_ERROR_MP4TAGLIBRARY_UPDATE_co64                   As Long = 20
Public Const TAGSLIBRARY_ERROR_NOT_ENOUGH_MEMORY_OR_AV                     As Long = 21

Public Const TAGSLIBRARY_PADDING_SIZE_TO_WRITE                             As Long = 1
Public Const TAGSLIBRARY_PARSE_OGG_PLAYTIME                                As Long = 2
Public Const TAGSLIBRARY_PARSE_ID3v2_AUDIO_ATTRIBUTES                      As Long = 3
Public Const TAGSLIBRARY_MP4TAG_KEEP_PADDING                               As Long = 4
Public Const TAGSLIBRARY_PARSE_WAVPACK_AUDIO_ATTRIBUTES                    As Long = 5
Public Const TAGSLIBRARY_PARSE_MUSEPACK_AUDIO_ATTRIBUTES                   As Long = 6
Public Const TAGSLIBRARY_DEEP_OPUS_BITRATE_SCAN                            As Long = 7

Public Type Int64 'LowPart must be the first one in LittleEndian systems
    'required part
    LowPart  As Long
    HighPart As Long

    'optional part
    'SignBit As Byte 'define this as long if you want to get minimum CPU access time.
End Type
'with the SignBit you can emulate both Int64 and UInt64 without changing the real sign bit in HighPart.
'but if you want to change it you can access it like this  mySign = (myVar.HighPart And &H80000000)
'or turn on the sign bit using  myVar.HighPart = (myVar.HighPart Or &H80000000)

Public Enum TTagType
    ttNone
    ttAutomatic
    ttAPEv2
    ttFlac
    ttID3v1
    ttID3v2
    ttMP4
    ttOpusVorbis
    ttWAV
    ttWMA
End Enum
#If False Then
Dim ttNone, ttAutomatic, ttAPEv2, ttFlac, ttID3v1, _
    ttID3v2, ttMP4, ttOpusVorbis, ttWAV, ttWMA
#End If

Public Enum TTagPictureFormat
    tpfUnknown
    tpfJPEG
    tpfPNG
    tpfBMP
    tpfGIF
End Enum
#If False Then
Dim tpfUnknown, tpfJPEG, tpfPNG, tpfBMP, tpfGIF
#End If

Public Type TTagPriority
    Values(0 To 8) As TTagType
End Type

Public Enum TExtTagType
    ettUnknown
    ettTXXX
    ettWXXX
End Enum
#If False Then
Dim ettUnknown, ettTXXX, ettWXXX
#End If

Public Type TExtTag
    Name        As Long                     '* LPWSTRtoBSTR(Name)
    Value       As Long                     '* LPWSTRtoBSTR(Value)
    ValueSize   As Long
    Language    As Long                     '* LPWSTRtoBSTR(Language)
    Description As Long                     '* LPWSTRtoBSTR(Description)
    ExtTagType  As TExtTagType
    index       As Long
End Type

Public Type TSimpleTag
    Name      As Long                       '* LPWSTRtoBSTR(Name)
    Value     As Long                       '* LPWSTRtoBSTR(Value)
    ValueSize As Long
    index     As Long
End Type

Public Enum TID3v2TagType
    id3v2ttUnknown
    id3v2ttText
    id3v2ttTextWithDescription
    id3v2ttTextWithDescriptionAndLangugageID
    id3v2ttURL
    id3v2ttUserDefinedURL
    id3v2ttPlayCount
    id3v2ttBinary
End Enum
#If False Then
Dim id3v2ttUnknown, id3v2ttText, id3v2ttTextWithDescription, _
    id3v2ttTextWithDescriptionAndLangugageID, id3v2ttURL, _
    id3v2ttUserDefinedURL, id3v2ttPlayCount, id3v2ttBinary
#End If

Public Type TID3v2TagEx
    Name        As Long                     '* LPWSTRtoBSTR(Name)
    Value       As Long                     '* LPWSTRtoBSTR(Value)
    ValueSize   As Long
    Language    As Long                     '* LPWSTRtoBSTR(Language)
    Description As Long                     '* LPWSTRtoBSTR(Description)
    TagType     As TID3v2TagType
    index       As Long
End Type

Public Enum TMP4TagType
    mp4ttUnknown
    mp4ttText
    mp4ttInteger8
    mp4ttInteger16
    mp4ttInteger32
    mp4ttInteger48
    mp4ttInteger64
End Enum
#If False Then
Dim mp4ttUnknown, mp4ttText, mp4ttInteger8, mp4ttInteger16, _
    mp4ttInteger32, mp4ttInteger48, mp4ttInteger64
#End If

Public Type TMP4TagEx
    Name      As Long                       '* LPWSTRtoBSTR(Name)
    Value     As Long                       '* LPWSTRtoBSTR(Value)
    ValueSize As Long
    NameValue As Long                       '* LPWSTRtoBSTR(NameValue)
    MeanValue As Long                       '* LPWSTRtoBSTR(MeanValue)
    TagType   As TMP4TagType
    DataType  As Long
    index     As Long
End Type

Public Type TCoverArtData
    Name              As Long               '* LPWSTRtoBSTR(Name)
    Data              As Long               '* VarPtr(Data)
    DataSize          As Int64              '* DataSize.LowPart
    Description       As Long               '* LPWSTRtoBSTR(Description)
    CoverType         As Long
    MIMEType          As Long               '* LPWSTRtoBSTR(MIMEType)
    PictureFormat     As TTagPictureFormat
    width             As Long
    height            As Long
    ColorDepth        As Long
    NoOfColors        As Long
    ID3v2TextEncoding As Long
    index             As Long
End Type

Public Type TTagData
    Name     As Long                        '* LPWSTRtoBSTR(Name)
    Data     As Long
    DataSize As Int64                       '* DataSize.LowPart
    DataType As Long
End Type

Public Type TCARTPostTimer
    Usage As Long                           '* LPWSTRtoBSTR(Usage)
    Value As Long
End Type

Public Enum TAudioType
    atAutomatic
    atFlac
    atMPEG
    atDSDDSF
    atWAV
    atAIFF
    atMP4
    atOpus
    atVorbis
    atWMA
    atWAVPack
    atMusePack
    atDSDDFF
End Enum
#If False Then
Dim atAutomatic, atFlac, atMPEG, atDSDDSF, atWAV, _
    atAIFF, atMP4, atOpus, atVorbis, atWMA, atWAVPack, atMusePack, atDSDDFF
#End If

Public Enum TMPEGVersion
    tmpegvUnknown
    tmpegv1
    tmpegv2
    tmpegv25
End Enum
#If False Then
Dim tmpegvUnknown, tmpegv1, tmpegv2, tmpegv25
#End If

Public Enum TMPEGLayer
    tmpeglUnknown
    tmpegl1
    tmpegl2
    tmpegl3
End Enum
#If False Then
Dim tmpeglUnknown, tmpegl1, tmpegl2, tmpegl3
#End If

Public Enum TMPEGChannelMode
    tmpegcmUnknown
    tmpegcmMono
    tmpegcmDualChannel
    tmpegcmJointStereo
    tmpegcmStereo
End Enum
#If False Then
Dim tmpegcmUnknown, tmpegcmMono, tmpegcmDualChannel, tmpegcmJointStereo, tmpegcmStereo
#End If

Public Enum TMPEGModeExtension
    tmpegmeUnknown
    tmpegmeNone
    tmpegmeIntensity
    tmpegmeMS
    tmpegmeIntensityMS
End Enum
#If False Then
Dim tmpegmeUnknown, tmpegmeNone, tmpegmeIntensity, tmpegmeMS, tmpegmeIntensityMS
#End If

Public Enum TMPEGEmphasis
    tmpegeUnknown
    tmpegeNo
    tmpege5015
    tmpegeCCITJ17
End Enum
#If False Then
Dim tmpegeUnknown, tmpegeNo, tmpege5015, tmpegeCCITJ17
#End If

Public Type TMPEGAudioAttributes
    Position      As Int64                  '* Position of header in bytes             (Position.LowPart)
    Header        As Long                   '* The Headers bytes
    FrameSize     As Long                   '* Frame's length
    Version       As TMPEGVersion           '* MPEG Version
    Layer         As TMPEGLayer             '* MPEG Layer
    CRC           As Long                   '* Frame has CRC                           (boolean)
    Bitrate       As Long                   '* Frame's bitrate
    SampleRate    As Long                   '* Frame's sample rate
    Padding       As Long                   '* Frame is padded                         (boolean)
    Private_      As Long                   '* Frame's private bit is set              (boolean)
    ChannelMode   As TMPEGChannelMode       '* Frame's channel mode
    ModeExtension As TMPEGModeExtension     '* Joint stereo only
    Copyrighted   As Long                   '* Frame's Copyright bit is set            (boolean)
    Original      As Long                   '* Frame's Original bit is set             (boolean)
    Emphasis      As TMPEGEmphasis          '* Frame's emphasis mode
    VBR           As Long                   '* Stream is probably VBR                  (boolean)
    FrameCount    As Int64                  '* Total number of MPEG frames (by header) (FrameCount.LowPart)
    Quality       As Long                   '* MPEG quality (by header)
    Bytes         As Int64                  '* Total bytes (by header)                 (Bytes.LowPart)
End Type

Public Type TFlacAudioAttributes
    Channels      As Long
    SampleRate    As Long
    BitsPerSample As Long
    SampleCount   As Int64                  '* SampleCount.LowPart
    PlayTime      As Double                 '* Duration (seconds)
    Ratio         As Double                 '* Compression ratio (%)
    ChannelMode   As Long                   '* LPWSTRtoBSTR(ChannelMode)
    Bitrate       As Long
End Type

Public Enum TDSFChannelType
    dsfctUnknown
    dsfctMono
    dsfctStereo
    dsfct3Channels
    dsfctQuad
    dsfct4Channels
    dsfct5Channels
    dsfct51Channels
End Enum
#If False Then
Dim dsfctUnknown, dsfctMono, dsfctStereo, dsfct3Channels, _
    dsfctQuad, dsfct4Channels, dsfct5Channels, dsfct51Channels
#End If

Public Type TDSFAudioAttributes
    FormatVersion       As Long
    FormatID            As Long
    ChannelType         As TDSFChannelType
    ChannelNumber       As Long
    SamplingFrequency   As Long
    BitsPerSample       As Long
    BlockSizePerChannel As Long
    PlayTime            As Double
    SampleCount         As Int64            '* SampleCount.LowPart
    Bitrate             As Long
End Type

Public Type TDFFAudioAttributes
    FormatVersion       As Long
    SampleRate          As Long
    ChannelNumber       As Long
    CompressionName     As Long
    SampleCount         As Int64            '* SampleCount.LowPart
    PlayTime            As Double
    BitRate             As Long
    SoundDataLength     As Int64            '* SoundDataLength.LowPart
    DSTFramesCount      As Long
    DSTFramesRate       As Long
    Ratio               As Double
End Type

Public Type TOpusAudioAttributes
    BitstreamVersion As Long                '* Bitstream version number
    ChannelCount     As Long                '* Number of channels
    PreSkip          As Long
    SampleRate       As Long                '* Sample rate (hz)
    OutputGain       As Long
    MappingFamily    As Long                '* 0,1,255
    PlayTime         As Double
    SampleCount      As Int64               '* SampleCount.LowPart
    Bitrate          As Long
End Type

Public Type TVorbisAudioAttributes
    BitstreamVersion(1 To 4) As Byte        '* Bitstream version number
    ChannelMode              As Long        '* Number of channels
    SampleRate               As Long        '* Sample rate (hz)
    BitRateMaximal           As Long        '* Bit rate upper limit
    BitRateNominal           As Long        '* Nominal bit rate
    BitRateMinimal           As Long        '* Bit rate lower limit
    BlockSize                As Long        '* Coded size for small and long blocks
    PlayTime                 As Double
    SampleCount              As Int64       '* SampleCount.LowPart
    Bitrate                  As Long
End Type

Public Type TWAVEAudioAttributes
    FormatTag          As Long              '* format type
    Channels           As Long              '* number of channels (i.e. mono, stereo, etc.)
    SamplesPerSec      As Long              '* sample rate
    AvgBytesPerSec     As Long              '* for buffer estimation
    BlockAlign         As Long              '* block size of data
    BitsPerSample      As Long              '* number of bits per sample of mono data
    PlayTime           As Double
    SampleCount        As Int64             '* SampleCount.LowPart
    cbSize             As Long              '* Size of the extension: 22
    ValidBitsPerSample As Long              '* at most 8 *  M
    ChannelMask        As Long              '* Speaker position mask: 0
    SubFormat(0 To 15) As Byte
    Bitrate            As Long
End Type

Public Type TAIFFAttributes
    Channels              As Long
    SampleCount           As Long
    SampleSize            As Long
    SampleRate            As Double
    CompressionID(0 To 3) As Byte           '* http://en.wikipedia.org/wiki/Audio_Interchange_File_Format
    Compression           As Long
    PlayTime              As Double
    Bitrate               As Long
End Type

Public Type TMP4AudioAttributes
    Channels      As Long
    SampleRate    As Long
    BitsPerSample As Long
    PlayTime      As Double                 '* Duration (seconds)
    Bitrate       As Long
End Type

Public Type TWMAAttributes
    PlayTime As Double
    Bitrate  As Long
End Type

Public Type TAudioAttributes
    Channels      As Long                   '* number of channels (i.e. mono, stereo, etc.)
    SamplesPerSec As Long                   '* sample rate
    BitsPerSample As Long                   '* number of bits per sample of mono data
    PlayTime      As Double                 '* duration in seconds
    SampleCount   As Int64                  '* number of total samples (SampleCount.LowPart)
    Bitrate       As Long
End Type

Public Enum TAudioAttribute
    aaChannels
    aaSamplesPerSec
    aaBitsPerSample
    aaPlayTime
    aaSampleCount
    aaBitRate
End Enum
#If False Then
Dim aaChannels, aaSamplesPerSec, aaBitsPerSample, aaPlayTime, aaSampleCount, aaBitRate
#End If

Public Enum TAudioFileFormat
    affUnknown
    affAPE
    affFlac
    affOggFlac
    affMPEG
    affMP4
    affOpus
    affVorbis
    affTheora
    affWAV
    affRF64
    affAIFF
    affAIFC
    affDFF
    affDSF
    affOptimFrog
    affMusePack
    affWavPack
End Enum
#If False Then
Dim affUnknown, affAPE, affFlac, affOggFlac, affMPEG, affMP4, affOpus, affVorbis, affTheora, affWAV, affRF64, affAIFF, affAIFC, affDFF, affDSF, affOptimFrog, affMusePack, affWavPack
#End If

'// Public Declares
Public Declare Function TagsLibrary_Create Lib "TagsLib.dll" () As Long
Public Declare Function TagsLibrary_Free Lib "TagsLib.dll" (ByVal Tags As Long) As Long
Public Declare Function TagsLibrary_Load Lib "TagsLib.dll" (ByVal Tags As Long, ByVal FileName As Long, ByVal TagType As TTagType, ByVal ParseTags As Long) As Long
Public Declare Function TagsLibrary_LoadFromMemory Lib "TagsLib.dll" (ByVal Tags As Long, ByVal MemoryAddress As Long, ByVal Size As Int64, ByVal TagType As TTagType, ByVal ParseTags As Long) As Long
Public Declare Function TagsLibrary_LoadFromBASS Lib "TagsLib.dll" (ByVal Tags As Long, ByVal Channel As Long) As Long
Public Declare Function TagsLibrary_Save Lib "TagsLib.dll" (ByVal Tags As Long, ByVal FileName As Long, ByVal TagType As TTagType) As Long
Public Declare Function TagsLibrary_SaveEx Lib "TagsLib.dll" (ByVal Tags As Long, ByVal FileName As Long, ByVal TagType As TTagType) As Long
Public Declare Function TagsLibrary_SaveToMemory Lib "TagsLib.dll" (ByVal Tags As Long, ByVal MemoryAddress As Long, ByVal Size As Int64, ByVal TagType As TTagType, ByRef SavedAddress As Long, ByRef SavedSize As Int64, ByRef SaveHandle As Long) As Long
Public Declare Function TagsLibrary_SaveToMemoryEx Lib "TagsLib.dll" (ByVal Tags As Long, ByVal MemoryAddress As Long, ByVal Size As Int64, ByVal TagType As TTagType, ByRef SavedAddress As Long, ByRef SavedSize As Int64, ByRef SaveHandle As Long) As Long
Public Declare Function TagsLibrary_FreeSaveHandle Lib "TagsLib.dll" (ByRef SaveHandle As Long) As Long
Public Declare Function TagsLibrary_RemoveTag Lib "TagsLib.dll" (ByVal FileName As Long, ByVal TagType As TTagType) As Long
Public Declare Function TagsLibrary_RemoveTagFromMemory Lib "TagsLib.dll" (ByVal MemoryAddress As Long, ByVal Size As Int64, ByVal TagType As TTagType, ByRef SavedAddress As Long, ByRef SavedSize As Int64, ByRef SaveHandle As Long) As Long
Public Declare Function TagsLibrary_GetTag Lib "TagsLib.dll" (ByVal Tags As Long, ByVal Name As Long, ByVal TagType As TTagType) As Long
Public Declare Function TagsLibrary_Loaded Lib "TagsLib.dll" (ByVal Tags As Long, ByVal TagType As TTagType) As Long
Public Declare Function TagsLibrary_GetTagEx Lib "TagsLib.dll" (ByVal Tags As Long, ByVal Name As Long, ByVal TagType As TTagType, ByRef ExtTag As Long) As Long
Public Declare Function TagsLibrary_GetTagByIndexEx Lib "TagsLib.dll" (ByVal Tags As Long, ByVal index As Long, ByVal TagType As TTagType, ByRef ExtTag As Long) As Long
Public Declare Function TagsLibrary_SetTag Lib "TagsLib.dll" (ByVal Tags As Long, ByVal Name As Long, ByVal Value As Long, ByVal TagType As TTagType) As Long
Public Declare Function TagsLibrary_SetTagEx Lib "TagsLib.dll" (ByVal Tags As Long, ByVal TagType As TTagType, ByVal ExtTag As Long) As Long
Public Declare Function TagsLibrary_AddTag Lib "TagsLib.dll" (ByVal Tags As Long, ByVal Name As Long, ByVal Value As Long, ByVal TagType As TTagType) As Long
Public Declare Function TagsLibrary_AddTagEx Lib "TagsLib.dll" (ByVal Tags As Long, ByVal TagType As TTagType, ByVal ExtTag As Long) As Long
Public Declare Function TagsLibrary_TagCount Lib "TagsLib.dll" (ByVal Tags As Long, ByVal TagType As TTagType) As Long
Public Declare Function TagsLibrary_DeleteTag Lib "TagsLib.dll" (ByVal Tags As Long, ByVal Name As Long, ByVal TagType As TTagType) As Long
Public Declare Function TagsLibrary_DeleteTagByIndex Lib "TagsLib.dll" (ByVal Tags As Long, ByVal index As Long, ByVal TagType As TTagType) As Long
Public Declare Function TagsLibrary_CoverArtCount Lib "TagsLib.dll" (ByVal Tags As Long, ByVal TagType As TTagType) As Long
Public Declare Function TagsLibrary_GetCoverArt Lib "TagsLib.dll" (ByVal Tags As Long, ByVal TagType As TTagType, ByVal index As Long, ByRef CoverArt As TCoverArtData) As Long
Public Declare Function TagsLibrary_GetCoverArtToFile Lib "TagsLib.dll" (ByVal Tags As Long, ByVal TagType As TTagType, ByVal index As Long, ByVal FileName As Long) As Long
Public Declare Function TagsLibrary_DeleteCoverArt Lib "TagsLib.dll" (ByVal Tags As Long, ByVal TagType As TTagType, ByVal index As Long) As Long
Public Declare Function TagsLibrary_SetCoverArt Lib "TagsLib.dll" (ByVal Tags As Long, ByVal TagType As TTagType, ByVal index As Long, ByRef CoverArt As TCoverArtData) As Long
Public Declare Function TagsLibrary_SetCoverArtFromFile Lib "TagsLib.dll" (ByVal Tags As Long, ByVal TagType As TTagType, ByVal index As Long, ByVal FileName As Long, ByRef CoverArt As TCoverArtData) As Long
Public Declare Function TagsLibrary_AddCoverArt Lib "TagsLib.dll" (ByVal Tags As Long, ByVal TagType As TTagType, ByVal CoverArt_Name As Long, ByVal CoverArt_Data As Long, ByVal CoverArt_DataSize As Int64, ByVal CoverArt_Description As Long, ByVal CoverArt_CoverType As Long, ByVal CoverArt_MIMEType As Long, ByVal CoverArt_PictureFormat As TTagPictureFormat, ByVal CoverArt_Width As Long, ByVal CoverArt_Height As Long, ByVal CoverArt_ColorDepth As Long, ByVal CoverArt_NoOfColors As Long, ByVal CoverArt_ID3v2TextEncoding As Long, ByVal CoverArt_Index As Long) As Long
Public Declare Function TagsLibrary_SetTagLoadPriority Lib "TagsLib.dll" (ByVal Tags As Long, ByVal TagPriorities0 As TTagType, ByVal TagPriorities1 As TTagType, ByVal TagPriorities2 As TTagType, ByVal TagPriorities3 As TTagType, ByVal TagPriorities4 As TTagType, ByVal TagPriorities5 As TTagType, ByVal TagPriorities6 As TTagType, ByVal TagPriorities7 As TTagType, ByVal TagPriorities8 As TTagType) As Long
Public Declare Function TagsLibrary_GetTagData Lib "TagsLib.dll" (ByVal Tags As Long, ByVal index As Long, ByVal TagType As TTagType, ByRef TagData As TTagData) As Long
Public Declare Function TagsLibrary_SetTagData Lib "TagsLib.dll" (ByVal Tags As Long, ByVal index As Long, ByVal TagType As TTagType, ByVal TagData_Name As Long, ByVal TagData_Data As Long, ByVal TagData_DataSize As Int64, ByVal TagData_DataType As Long) As Long
Public Declare Function TagsLibrary_GetCARTPostTimer Lib "TagsLib.dll" (ByVal Tags As Long, ByVal index As Long, ByRef PostTimer As TCARTPostTimer) As Long
Public Declare Function TagsLibrary_SetCARTPostTimer Lib "TagsLib.dll" (ByVal Tags As Long, ByVal index As Long, ByVal PostTimer_Usage As Long, ByVal PostTimer_Value As Long) As Long
Public Declare Function TagsLibrary_ClearCARTPostTimer Lib "TagsLib.dll" (ByVal Tags As Long, ByVal index As Long) As Long
Public Declare Function TagsLibrary_GetConfig Lib "TagsLib.dll" (ByVal Tags As Long, ByVal nOption As Long, ByVal TagType As TTagType) As Long
Public Declare Function TagsLibrary_SetConfig Lib "TagsLib.dll" (ByVal Tags As Long, ByVal Value As Long, ByVal nOption As Long, ByVal TagType As TTagType) As Long
Public Declare Function TagsLibrary_GetVendor Lib "TagsLib.dll" (ByVal Tags As Long, ByVal TagType As TTagType) As Long
Public Declare Function TagsLibrary_SetVendor Lib "TagsLib.dll" (ByVal Tags As Long, ByVal Vendor As Long, ByVal TagType As TTagType) As Long
Public Declare Function TagsLibrary_GetAudioAttributes Lib "TagsLib.dll" (ByVal Tags As Long, ByVal AudioType As TAudioType, ByRef Attributes As Any) As Long
Public Declare Function TagsLibrary_GetAudioAttribute Lib "TagsLib.dll" (ByVal Tags As Long, ByVal Attrib As TAudioAttribute) As Double
Public Declare Function TagsLibrary_GetTagSize Lib "TagsLib.dll" (ByVal Tags As Long, ByVal TagType As TTagType) As Long
Public Declare Function TagsLibrary_GetAudioFormat Lib "TagsLib.dll" (ByVal FileName As Long) As TAudioFileFormat
Public Declare Function TagsLibrary_GetAudioFormatMemory Lib "TagsLib.dll" (ByVal MemoryAddress As Long, ByVal Size As Int64) As TAudioFileFormat

'"Reallocates a previously allocated string to be the size of a second string and copies the second string into the reallocated memory."
Private Declare Function SysReAllocString Lib "oleaut32.dll" (ByVal pBSTR As Long, Optional ByVal pszStrPtr As Long) As Long

Public Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)

Public Function LPWSTRtoBSTR(ByVal lpwsz As Long) As String

' Input:  a valid LPWSTR pointer lpwsz
' Return: a BSTR with the same character array
' Copy string from pointer

    SysReAllocString VarPtr(LPWSTRtoBSTR), lpwsz

End Function

Private Function CInt64(ByVal vCur As Currency) As Int64
    vCur = (CCur(vCur) * 0.0001@)
    Call CopyMemory(CInt64, vCur, SIZEOF_INT64)
End Function

' myRetVal = Win32APIFunctionWithOneInt64Param(CInt64(10000000))
' ----OR
' Dim myNum As Int64
' myNum = CInt64(10000000)
' Converting int64 to decimal could be something like this
' d = CDec(LowPart) * 2 ^ 32 + HighPart
