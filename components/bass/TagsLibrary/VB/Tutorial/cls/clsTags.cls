VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTags"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Description = "Wrapper für die Tags Libray"
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public LngTags As Long

'// AudioAttributes
Private m_AttributesChannels As Long
Private m_AttributesSamplesPerSec As Long
Private m_AttributesBitsPerSample As Long
Private m_AttributesPlayTime As Double
Private m_AttributesSampleCount As Int64
Private m_AttributesBitrate As Long

'// MPGAudioAttributes
Private m_MPGAttributesPosition As Int64
Private m_MPGAttributesHeader As Long
Private m_MPGAttributesFrameSize As Long
Private m_MPGAttributesVersion As TMPEGVersion
Private m_MPGAttributesLayer As TMPEGLayer
Private m_MPGAttributesCRC As Long
Private m_MPGAttributesBitrate As Long
Private m_MPGAttributesSampleRate As Long
Private m_MPGAttributesPadding As Long
Private m_MPGAttributesPrivate_ As Long
Private m_MPGAttributesChannelMode As TMPEGChannelMode
Private m_MPGAttributesModeExtension As TMPEGModeExtension
Private m_MPGAttributesCopyrighted As Long
Private m_MPGAttributesOriginal As Long
Private m_MPGAttributesEmphasis As TMPEGEmphasis
Private m_MPGAttributesVBR As Long
Private m_MPGAttributesFrameCount As Int64
Private m_MPGAttributesQuality As Long
Private m_MPGAttributesBytes As Int64

'// FlacAudioAttributes
Private m_FlacAttributesChannels As Long
Private m_FlacAttributesSampleRate As Long
Private m_FlacAttributesBitsPerSample As Long
Private m_FlacAttributesSampleCount As Int64
Private m_FlacAttributesPlayTime As Double
Private m_FlacAttributesRatio As Double
Private m_FlacAttributesChannelMode As Long
Private m_FlacAttributesBitrate As Long

'// DSFAudioAttributes
Private m_DSFAttributesFormatVersion As Long
Private m_DSFAttributesFormatID As Long
Private m_DSFAttributesChannelType As TDSFChannelType
Private m_DSFAttributesChannelNumber As Long
Private m_DSFAttributesSamplingFrequency As Long
Private m_DSFAttributesBitsPerSample As Long
Private m_DSFAttributesBlockSizePerChannel As Long
Private m_DSFAttributesPlayTime As Long
Private m_DSFAttributesSampleCount As Int64
Private m_DSFAttributesBitrate As Long

'// MP4AudioAttributes
Private m_MP4AttributesChannels As Long
Private m_MP4AttributesSampleRate As Long
Private m_MP4AttributesBitsPerSample As Long
Private m_MP4AttributesPlayTime As Double
Private m_MP4AttributesBitrate As Long

'// OPUSAudioAttributes
Private m_OPUSAttributesBitstreamVersion As Long
Private m_OPUSAttributesChannelCount As Long
Private m_OPUSAttributesPreSkip As Long
Private m_OPUSAttributesSampleRate As Long
Private m_OPUSAttributesOutputGain As Long
Private m_OPUSAttributesMappingFamily As Long
Private m_OPUSAttributesPlayTime As Double
Private m_OPUSAttributesSampleCount As Int64
Private m_OPUSAttributesBitrate As Long

'// CoverArt
Private m_CoverArtName As Long
Private m_CoverArtData As Long
Private m_CoverArtDataSize As Int64
Private m_CoverArtDescription As Long
Private m_CoverArtCoverType As Long
Private m_CoverArtMIMEType As Long
Private m_CoverArtPictureFormat As TTagPictureFormat
Private m_CoverArtWidth As Long
Private m_CoverArtHeight As Long
Private m_CoverArtColorDepth As Long
Private m_CoverArtNoOfColors As Long
Private m_CoverArtID3v2TextEncoding As Long
Private m_CoverArtIndex As Long

'// ExtTag
Private m_ExtTagName As Long
Private m_ExtTagValue As Long
Private m_ExtTagValueSize As Long
Private m_ExtTagLanguage As Long
Private m_ExtTagDescription As Long
Private m_ExtTagExtTagType As TExtTagType
Private m_ExtTagIndex As Long

Private Declare Function GetTempPath Lib "kernel32" Alias "GetTempPathA" ( _
    ByVal nBufferLength As Long, ByVal lpBuffer As String) As Long

Public Property Let AttributesBitrate(ByVal PropVal As Long)

    m_AttributesBitrate = PropVal

End Property

Public Property Get AttributesBitrate() As Long

    AttributesBitrate = m_AttributesBitrate

End Property

Public Property Let AttributesBitsPerSample(ByVal PropVal As Long)

    m_AttributesBitsPerSample = PropVal

End Property

Public Property Get AttributesBitsPerSample() As Long

    AttributesBitsPerSample = m_AttributesBitsPerSample

End Property

Public Property Let AttributesChannels(ByVal PropVal As Long)

    m_AttributesChannels = PropVal

End Property

Public Property Get AttributesChannels() As Long

    AttributesChannels = m_AttributesChannels

End Property

Public Property Let AttributesPlayTime(ByVal PropVal As Double)

    m_AttributesPlayTime = PropVal

End Property

Public Property Get AttributesPlayTime() As Double

    AttributesPlayTime = m_AttributesPlayTime

End Property

Friend Property Let AttributesSampleCount(ByRef PropVal As Int64)

    m_AttributesSampleCount = PropVal

End Property

Friend Property Get AttributesSampleCount() As Int64

    AttributesSampleCount = m_AttributesSampleCount

End Property

Public Property Let AttributesSamplesPerSec(ByVal PropVal As Long)

    m_AttributesSamplesPerSec = PropVal

End Property

Public Property Get AttributesSamplesPerSec() As Long

    AttributesSamplesPerSec = m_AttributesSamplesPerSec

End Property

Private Sub Class_Terminate()

    TagsLibrary_Free LngTags
    LngTags = 0

End Sub

Public Property Let CoverArtColorDepth(ByVal PropVal As Long)

    m_CoverArtColorDepth = PropVal

End Property

Public Property Get CoverArtColorDepth() As Long

    CoverArtColorDepth = m_CoverArtColorDepth

End Property

Public Function CoverArtCount(ByVal TagType As TTagType) As Integer

    CoverArtCount = TagsLibrary_CoverArtCount(LngTags, TagType)

End Function

Public Property Let CoverArtCoverType(ByVal PropVal As Long)

    m_CoverArtCoverType = PropVal

End Property

Public Property Get CoverArtCoverType() As Long

    CoverArtCoverType = m_CoverArtCoverType

End Property

Public Property Let CoverArtData(ByVal PropVal As Long)

    m_CoverArtData = PropVal

End Property

Public Property Get CoverArtData() As Long

    CoverArtData = m_CoverArtData

End Property

Friend Property Let CoverArtDataSize(ByRef PropVal As Int64)

    m_CoverArtDataSize = PropVal

End Property

Friend Property Get CoverArtDataSize() As Int64

    CoverArtDataSize = m_CoverArtDataSize

End Property

Public Property Let CoverArtDescription(ByVal PropVal As Long)

    m_CoverArtDescription = PropVal

End Property

Public Property Get CoverArtDescription() As Long

    CoverArtDescription = m_CoverArtDescription

End Property

Public Property Let CoverArtHeight(ByVal PropVal As Long)

    m_CoverArtHeight = PropVal

End Property

Public Property Get CoverArtHeight() As Long

    CoverArtHeight = m_CoverArtHeight

End Property

Public Property Let CoverArtID3v2TextEncoding(ByVal PropVal As Long)

    m_CoverArtID3v2TextEncoding = PropVal

End Property

Public Property Get CoverArtID3v2TextEncoding() As Long

    CoverArtID3v2TextEncoding = m_CoverArtID3v2TextEncoding

End Property

Public Property Let CoverArtIndex(ByVal PropVal As Long)

    m_CoverArtIndex = PropVal

End Property

Public Property Get CoverArtIndex() As Long

    CoverArtIndex = m_CoverArtIndex

End Property

Public Property Let CoverArtMIMEType(ByVal PropVal As Long)

    m_CoverArtMIMEType = PropVal

End Property

Public Property Get CoverArtMIMEType() As Long

    CoverArtMIMEType = m_CoverArtMIMEType

End Property

Public Property Let CoverArtName(ByVal PropVal As Long)

    m_CoverArtName = PropVal

End Property

Public Property Get CoverArtName() As Long

    CoverArtName = m_CoverArtName

End Property

Public Property Let CoverArtNoOfColors(ByVal PropVal As Long)

    m_CoverArtNoOfColors = PropVal

End Property

Public Property Get CoverArtNoOfColors() As Long

    CoverArtNoOfColors = m_CoverArtNoOfColors

End Property

Public Property Let CoverArtPictureFormat(ByVal PropVal As TTagPictureFormat)

    m_CoverArtPictureFormat = PropVal

End Property

Public Property Get CoverArtPictureFormat() As TTagPictureFormat

    CoverArtPictureFormat = m_CoverArtPictureFormat

End Property

Public Function CoverArtPictureFormatToStr() As String

    Select Case CoverArtPictureFormat
    Case 0
        CoverArtPictureFormatToStr = "tpfUnknown"
    Case 1
        CoverArtPictureFormatToStr = "tpfJPEG"
    Case 2
        CoverArtPictureFormatToStr = "tpfPNG"
    Case 3
        CoverArtPictureFormatToStr = "tpfBMP"
    Case 4
        CoverArtPictureFormatToStr = "tpfGIF"
    End Select

End Function

Public Property Let CoverArtWidth(ByVal PropVal As Long)

    m_CoverArtWidth = PropVal

End Property

Public Property Get CoverArtWidth() As Long

    CoverArtWidth = m_CoverArtWidth

End Property

Public Function Create()

    LngTags = TagsLibrary_Create

End Function

Public Property Let DSFAttributesBitrate(ByVal PropVal As Long)

    m_DSFAttributesBitrate = PropVal

End Property

Public Property Get DSFAttributesBitrate() As Long

    DSFAttributesBitrate = m_DSFAttributesBitrate

End Property

Public Property Let DSFAttributesBitsPerSample(ByVal PropVal As Long)

    m_DSFAttributesBitsPerSample = PropVal

End Property

Public Property Get DSFAttributesBitsPerSample() As Long

    DSFAttributesBitsPerSample = m_DSFAttributesBitsPerSample

End Property

Public Property Let DSFAttributesBlockSizePerChannel(ByVal PropVal As Long)

    m_DSFAttributesBlockSizePerChannel = PropVal

End Property

Public Property Get DSFAttributesBlockSizePerChannel() As Long

    DSFAttributesBlockSizePerChannel = m_DSFAttributesBlockSizePerChannel

End Property

Public Property Let DSFAttributesChannelNumber(ByVal PropVal As Long)

    m_DSFAttributesChannelNumber = PropVal

End Property

Public Property Get DSFAttributesChannelNumber() As Long

    DSFAttributesChannelNumber = m_DSFAttributesChannelNumber

End Property

Public Property Let DSFAttributesChannelType(ByVal PropVal As TDSFChannelType)

    m_DSFAttributesChannelType = PropVal

End Property

Public Property Get DSFAttributesChannelType() As TDSFChannelType

    DSFAttributesChannelType = m_DSFAttributesChannelType

End Property

Public Function DSFAttributesChannelTypeToStr() As String

    Select Case DSFAttributesChannelType
    Case 0
        DSFAttributesChannelTypeToStr = "dsfctUnknown"
    Case 1
        DSFAttributesChannelTypeToStr = "dsfctMono"
    Case 2
        DSFAttributesChannelTypeToStr = "dsfctStereo"
    Case 3
        DSFAttributesChannelTypeToStr = "dsfct3Channels"
    Case 4
        DSFAttributesChannelTypeToStr = "dsfctQuad"
    Case 5
        DSFAttributesChannelTypeToStr = "dsfct4Channels"
    Case 6
        DSFAttributesChannelTypeToStr = "dsfct5Channels"
    Case 7
        DSFAttributesChannelTypeToStr = "dsfct51Channels"
    End Select

End Function

Public Property Let DSFAttributesFormatID(ByVal PropVal As Long)

    m_DSFAttributesFormatID = PropVal

End Property

Public Property Get DSFAttributesFormatID() As Long

    DSFAttributesFormatID = m_DSFAttributesFormatID

End Property

Public Property Let DSFAttributesFormatVersion(ByVal PropVal As Long)

    m_DSFAttributesFormatVersion = PropVal

End Property

Public Property Get DSFAttributesFormatVersion() As Long

    DSFAttributesFormatVersion = m_DSFAttributesFormatVersion

End Property

Public Property Let DSFAttributesPlayTime(ByVal PropVal As Long)

    m_DSFAttributesPlayTime = PropVal

End Property

Public Property Get DSFAttributesPlayTime() As Long

    DSFAttributesPlayTime = m_DSFAttributesPlayTime

End Property

Friend Property Let DSFAttributesSampleCount(ByRef PropVal As Int64)

    m_DSFAttributesSampleCount = PropVal

End Property

Friend Property Get DSFAttributesSampleCount() As Int64

    DSFAttributesSampleCount = m_DSFAttributesSampleCount

End Property

Public Property Let DSFAttributesSamplingFrequency(ByVal PropVal As Long)

    m_DSFAttributesSamplingFrequency = PropVal

End Property

Public Property Get DSFAttributesSamplingFrequency() As Long

    DSFAttributesSamplingFrequency = m_DSFAttributesSamplingFrequency

End Property

Public Property Let ExtTagDescription(ByVal PropVal As Long)

    m_ExtTagDescription = PropVal

End Property

Public Property Get ExtTagDescription() As Long

    ExtTagDescription = m_ExtTagDescription

End Property

Public Property Let ExtTagExtTagType(ByVal PropVal As TExtTagType)

    m_ExtTagExtTagType = PropVal

End Property

Public Property Get ExtTagExtTagType() As TExtTagType

    ExtTagExtTagType = m_ExtTagExtTagType

End Property

Public Property Let ExtTagIndex(ByVal PropVal As Long)

    m_ExtTagIndex = PropVal

End Property

Public Property Get ExtTagIndex() As Long

    ExtTagIndex = m_ExtTagIndex

End Property

Public Property Let ExtTagLanguage(ByVal PropVal As Long)

    m_ExtTagLanguage = PropVal

End Property

Public Property Get ExtTagLanguage() As Long

    ExtTagLanguage = m_ExtTagLanguage

End Property

Public Property Let ExtTagName(ByVal PropVal As Long)

    m_ExtTagName = PropVal

End Property

Public Property Get ExtTagName() As Long

    ExtTagName = m_ExtTagName

End Property

Public Function ExtTagToStr() As String

    Select Case ExtTagExtTagType
    Case 0
        ExtTagToStr = "ettUnknown"
    Case 1
        ExtTagToStr = "ettTXXX"
    Case 2
        ExtTagToStr = "ettWXXX"
    End Select

End Function

Public Property Let ExtTagValue(ByVal PropVal As Long)

    m_ExtTagValue = PropVal

End Property

Public Property Get ExtTagValue() As Long

    ExtTagValue = m_ExtTagValue

End Property

Public Property Let ExtTagValueSize(ByVal PropVal As Long)

    m_ExtTagValueSize = PropVal

End Property

Public Property Get ExtTagValueSize() As Long

    ExtTagValueSize = m_ExtTagValueSize

End Property

Private Function FileExists(ByVal Bestand As String) As Boolean

    If InStr(1, Bestand, ".") = 0 Then
        FileExists = False
        Exit Function
    End If

    On Error Resume Next
        FileLen Bestand
        FileExists = (Err = 0)
    On Error GoTo 0

End Function

Public Property Let FlacAttributesBitrate(ByVal PropVal As Long)

    m_FlacAttributesBitrate = PropVal

End Property

Public Property Get FlacAttributesBitrate() As Long

    FlacAttributesBitrate = m_FlacAttributesBitrate

End Property

Public Property Let FlacAttributesBitsPerSample(ByVal PropVal As Long)

    m_FlacAttributesBitsPerSample = PropVal

End Property

Public Property Get FlacAttributesBitsPerSample() As Long

    FlacAttributesBitsPerSample = m_FlacAttributesBitsPerSample

End Property

Public Property Let FlacAttributesChannelMode(ByVal PropVal As Long)

    m_FlacAttributesChannelMode = PropVal

End Property

Public Property Get FlacAttributesChannelMode() As Long

    FlacAttributesChannelMode = m_FlacAttributesChannelMode

End Property

Public Property Let FlacAttributesChannels(ByVal PropVal As Long)

    m_FlacAttributesChannels = PropVal

End Property

Public Property Get FlacAttributesChannels() As Long

    FlacAttributesChannels = m_FlacAttributesChannels

End Property

Public Property Let FlacAttributesPlayTime(ByVal PropVal As Double)

    m_FlacAttributesPlayTime = PropVal

End Property

Public Property Get FlacAttributesPlayTime() As Double

    FlacAttributesPlayTime = m_FlacAttributesPlayTime

End Property

Public Property Let FlacAttributesRatio(ByVal PropVal As Double)

    m_FlacAttributesRatio = PropVal

End Property

Public Property Get FlacAttributesRatio() As Double

    FlacAttributesRatio = m_FlacAttributesRatio

End Property

Friend Property Let FlacAttributesSampleCount(ByRef PropVal As Int64)

    m_FlacAttributesSampleCount = PropVal

End Property

Friend Property Get FlacAttributesSampleCount() As Int64

    FlacAttributesSampleCount = m_FlacAttributesSampleCount

End Property

Public Property Let FlacAttributesSampleRate(ByVal PropVal As Long)

    m_FlacAttributesSampleRate = PropVal

End Property

Public Property Get FlacAttributesSampleRate() As Long

    FlacAttributesSampleRate = m_FlacAttributesSampleRate

End Property

Public Function GetAudioAttribute(ByVal Attrib As TAudioAttribute) As Long

    GetAudioAttribute = TagsLibrary_GetAudioAttribute(LngTags, Attrib)

End Function

Public Sub GetAudioAttributes(ByVal AudioType As TAudioType)

Dim AudioAttributes As TAudioAttributes

    If AudioType = atAutomatic Then
        TagsLibrary_GetAudioAttributes LngTags, AudioType, ByVal VarPtr(AudioAttributes)

        AttributesChannels = AudioAttributes.Channels
        AttributesSamplesPerSec = AudioAttributes.SamplesPerSec
        AttributesBitsPerSample = AudioAttributes.BitsPerSample
        AttributesPlayTime = AudioAttributes.PlayTime
        AttributesSampleCount = AudioAttributes.SampleCount
        AttributesBitrate = AudioAttributes.Bitrate
    End If

End Sub

Public Function GetAudioFormat(ByVal FileName As Long) As TAudioFileFormat

    GetAudioFormat = TagsLibrary_GetAudioFormat(FileName)

End Function

Public Function GetCoverArt(ByVal TagType As TTagType, ByVal index As Long) As Long

Dim CoverArt As TCoverArtData

    GetCoverArt = TagsLibrary_GetCoverArt(LngTags, TagType, index, CoverArt)

    CoverArtName = CoverArt.Name
    CoverArtData = CoverArt.Data
    CoverArtDataSize = CoverArt.DataSize
    CoverArtDescription = CoverArt.Description
    CoverArtCoverType = CoverArt.CoverType
    CoverArtMIMEType = CoverArt.MIMEType
    CoverArtPictureFormat = CoverArt.PictureFormat
    CoverArtWidth = CoverArt.width
    CoverArtHeight = CoverArt.height
    CoverArtColorDepth = CoverArt.ColorDepth
    CoverArtNoOfColors = CoverArt.NoOfColors
    CoverArtID3v2TextEncoding = CoverArt.ID3v2TextEncoding
    CoverArtIndex = CoverArt.index

End Function

Public Function GetCoverArtToFile(TagType As TTagType, CoverArtIndex As Integer, CoverArtName As String) As Long

    GetCoverArtToFile = TagsLibrary_GetCoverArtToFile(LngTags, ttAutomatic, CoverArtIndex, StrPtr(CoverArtName))

End Function

Public Sub GetDSFAudioAttributes(ByVal AudioType As TAudioType)

Dim DSFAudioAttributes As TDSFAudioAttributes

    If AudioType = atDSDDSF Then
        TagsLibrary_GetAudioAttributes LngTags, AudioType, ByVal VarPtr(DSFAudioAttributes)

        DSFAttributesFormatVersion = DSFAudioAttributes.FormatVersion
        DSFAttributesFormatID = DSFAudioAttributes.FormatID
        DSFAttributesChannelType = DSFAudioAttributes.ChannelType
        DSFAttributesChannelNumber = DSFAudioAttributes.ChannelNumber
        DSFAttributesSamplingFrequency = DSFAudioAttributes.SamplingFrequency
        DSFAttributesBitsPerSample = DSFAudioAttributes.BitsPerSample
        DSFAttributesBlockSizePerChannel = DSFAudioAttributes.BlockSizePerChannel
        DSFAttributesPlayTime = DSFAudioAttributes.PlayTime
        DSFAttributesSampleCount = DSFAudioAttributes.SampleCount
        DSFAttributesBitrate = DSFAudioAttributes.Bitrate
    End If

End Sub

Public Sub GetFlacAudioAttributes(ByVal AudioType As TAudioType)

Dim FlacAudioAttributes As TFlacAudioAttributes

    If AudioType = atFlac Then
        TagsLibrary_GetAudioAttributes LngTags, AudioType, ByVal VarPtr(FlacAudioAttributes)

        FlacAttributesChannels = FlacAudioAttributes.Channels
        FlacAttributesSampleRate = FlacAudioAttributes.SampleRate
        FlacAttributesBitsPerSample = FlacAudioAttributes.BitsPerSample
        FlacAttributesSampleCount = FlacAudioAttributes.SampleCount
        FlacAttributesPlayTime = FlacAudioAttributes.PlayTime
        FlacAttributesRatio = FlacAudioAttributes.Ratio
        FlacAttributesChannelMode = FlacAudioAttributes.ChannelMode
        FlacAttributesBitrate = FlacAudioAttributes.Bitrate
    End If

End Sub

Public Sub GetMP4AudioAttributes(ByVal AudioType As TAudioType)

Dim MP4AudioAttributes As TMP4AudioAttributes

    If AudioType = atMP4 Then
        TagsLibrary_GetAudioAttributes LngTags, AudioType, ByVal VarPtr(MP4AudioAttributes)

        MP4AttributesChannels = MP4AudioAttributes.Channels
        MP4AttributesSampleRate = MP4AudioAttributes.SampleRate
        MP4AttributesBitsPerSample = MP4AudioAttributes.BitsPerSample
        MP4AttributesPlayTime = MP4AudioAttributes.PlayTime
        MP4AttributesBitrate = MP4AudioAttributes.Bitrate
    End If

End Sub

Public Sub GetMPEGAudioAttributes(ByVal AudioType As TAudioType)

Dim MPGAudioAttributes As TMPEGAudioAttributes

    If AudioType = atMPEG Then
        TagsLibrary_GetAudioAttributes LngTags, AudioType, ByVal VarPtr(MPGAudioAttributes)

        MPGAttributesPosition = MPGAudioAttributes.Position
        MPGAttributesHeader = MPGAudioAttributes.Header
        MPGAttributesFrameSize = MPGAudioAttributes.FrameSize
        MPGAttributesVersion = MPGAudioAttributes.Version
        MPGAttributesLayer = MPGAudioAttributes.Layer
        MPGAttributesCRC = MPGAudioAttributes.CRC
        MPGAttributesBitrate = MPGAudioAttributes.Bitrate
        MPGAttributesSampleRate = MPGAudioAttributes.SampleRate
        MPGAttributesPadding = MPGAudioAttributes.Padding
        MPGAttributesPrivate_ = MPGAudioAttributes.Private_
        MPGAttributesChannelMode = MPGAudioAttributes.ChannelMode
        MPGAttributesModeExtension = MPGAudioAttributes.ModeExtension
        MPGAttributesCopyrighted = MPGAudioAttributes.Copyrighted
        MPGAttributesOriginal = MPGAudioAttributes.Original
        MPGAttributesEmphasis = MPGAudioAttributes.Emphasis
        MPGAttributesVBR = MPGAudioAttributes.VBR
        MPGAttributesFrameCount = MPGAudioAttributes.FrameCount
        MPGAttributesQuality = MPGAudioAttributes.Quality
        MPGAttributesBytes = MPGAudioAttributes.Bytes
    End If

End Sub

Public Sub GetOpusAudioAttributes(ByVal AudioType As TAudioType)

Dim OpusAudioAttributes As TOpusAudioAttributes

    If AudioType = atOpus Then
        TagsLibrary_GetAudioAttributes LngTags, AudioType, ByVal VarPtr(OpusAudioAttributes)

        OPUSAttributesBitstreamVersion = OpusAudioAttributes.BitstreamVersion
        OPUSAttributesChannelCount = OpusAudioAttributes.ChannelCount
        OPUSAttributesPreSkip = OpusAudioAttributes.PreSkip
        OPUSAttributesSampleRate = OpusAudioAttributes.SampleRate
        OPUSAttributesOutputGain = OpusAudioAttributes.OutputGain
        OPUSAttributesMappingFamily = OpusAudioAttributes.MappingFamily
        OPUSAttributesPlayTime = OpusAudioAttributes.PlayTime
        OPUSAttributesSampleCount = OpusAudioAttributes.SampleCount
        OPUSAttributesBitrate = OpusAudioAttributes.Bitrate
    End If

End Sub

Public Function GetPath(ByVal FileName As String) As String

Dim intP As Integer
Dim intJ As Integer

    intP = 0
    For intJ = Len(FileName) To 1 Step -1
        If Mid$(FileName, intJ, 1) = "\" Then
            intP = intJ
            Exit For
        End If
    Next

    If intP > 0 Then
        GetPath = Left$(FileName, intP)
    Else
        GetPath = vbNullString
    End If

End Function

Public Function GetTag(ByVal Name As String, ByVal TagType As TTagType) As String

    GetTag = LPWSTRtoBSTR(TagsLibrary_GetTag(LngTags, StrPtr(Name), TagType))

End Function

Public Function GetTagByIndexEx(ByVal index As Integer, ByVal TagType As TTagType) As Long

Dim ExtTag As TExtTag

    GetTagByIndexEx = TagsLibrary_GetTagByIndexEx(LngTags, index, TagType, ByVal VarPtr(ExtTag))

    ExtTagName = ExtTag.Name
    ExtTagValue = ExtTag.Value
    ExtTagValueSize = ExtTag.ValueSize
    ExtTagLanguage = ExtTag.Language
    ExtTagDescription = ExtTag.Description
    ExtTagExtTagType = ExtTag.ExtTagType
    ExtTagIndex = ExtTag.index

End Function

Public Function GetTempDir() As String

Dim sTmpPath    As String

'initialize string variable receiving OSTEMP directory path

    sTmpPath = String$(2000, " ")
    'Get OS TEMP directory path
    GetTempPath 2000, sTmpPath
    'trim string variable containing TEMP Directory path
    sTmpPath = Trim$(sTmpPath)
    'since it's a null-terminated string, get rid of the last character
    GetTempDir = Left$(sTmpPath, Len(sTmpPath) - 1)

End Function

Public Function GetTimeFormat(ByVal SongTime As Long) As String

Dim mpMin   As Long
Dim mpSec   As Long

    mpMin = SongTime \ 60
    mpSec = SongTime Mod 60

    On Error Resume Next

        GetTimeFormat = IIf(Trim$(mpMin) <= 9, "0" & Trim$(mpMin), Trim$(mpMin)) & ":" & _
                        IIf(Trim$(mpSec) <= 9, "0" & Trim$(mpSec), Trim$(mpSec))
    On Error GoTo 0

End Function

Public Function Load(ByVal FileName As String, ByVal TagType As TTagType) As Integer

    If Not FileExists(FileName) Then
        Load = TAGSLIBRARY_ERROR_OPENING_FILE
        Exit Function
    Else
        Load = TagsLibrary_Load(LngTags, StrPtr(FileName), TagType, True)
    End If

End Function

Public Function Loaded(ByVal TagType As TTagType) As Long

    Loaded = TagsLibrary_Loaded(LngTags, TagType)

End Function

Public Property Let MP4AttributesBitrate(ByVal PropVal As Long)

    m_MP4AttributesBitrate = PropVal

End Property

Public Property Get MP4AttributesBitrate() As Long

    MP4AttributesBitrate = m_MP4AttributesBitrate

End Property

Public Property Let MP4AttributesBitsPerSample(ByVal PropVal As Long)

    m_MP4AttributesBitsPerSample = PropVal

End Property

Public Property Get MP4AttributesBitsPerSample() As Long

    MP4AttributesBitsPerSample = m_MP4AttributesBitsPerSample

End Property

Public Property Let MP4AttributesChannels(ByVal PropVal As Long)

    m_MP4AttributesChannels = PropVal

End Property

Public Property Get MP4AttributesChannels() As Long

    MP4AttributesChannels = m_MP4AttributesChannels

End Property

Public Property Let MP4AttributesPlayTime(ByVal PropVal As Double)

    m_MP4AttributesPlayTime = PropVal

End Property

Public Property Get MP4AttributesPlayTime() As Double

    MP4AttributesPlayTime = m_MP4AttributesPlayTime

End Property

Public Property Let MP4AttributesSampleRate(ByVal PropVal As Long)

    m_MP4AttributesSampleRate = PropVal

End Property

Public Property Get MP4AttributesSampleRate() As Long

    MP4AttributesSampleRate = m_MP4AttributesSampleRate

End Property

Public Property Let MPGAttributesBitrate(ByVal PropVal As Long)

    m_MPGAttributesBitrate = PropVal

End Property

Public Property Get MPGAttributesBitrate() As Long

    MPGAttributesBitrate = m_MPGAttributesBitrate

End Property

Friend Property Let MPGAttributesBytes(ByRef PropVal As Int64)

    m_MPGAttributesBytes = PropVal

End Property

Friend Property Get MPGAttributesBytes() As Int64

    MPGAttributesBytes = m_MPGAttributesBytes

End Property

Public Property Let MPGAttributesChannelMode(ByVal PropVal As TMPEGChannelMode)

    m_MPGAttributesChannelMode = PropVal

End Property

Public Property Get MPGAttributesChannelMode() As TMPEGChannelMode

    MPGAttributesChannelMode = m_MPGAttributesChannelMode

End Property

Public Function MPGAttributesChannelModeToStr() As String

    Select Case MPGAttributesLayer
    Case 0
        MPGAttributesChannelModeToStr = "tmpegcmUnknown"
    Case 1
        MPGAttributesChannelModeToStr = "tmpegcmMono"
    Case 2
        MPGAttributesChannelModeToStr = "tmpegcmDualChannel"
    Case 3
        MPGAttributesChannelModeToStr = "tmpegcmJointStereo"
    Case 4
        MPGAttributesChannelModeToStr = "tmpegcmStereo"
    End Select

End Function

Public Property Get MPGAttributesCopyrighted() As Long

    MPGAttributesCopyrighted = m_MPGAttributesCopyrighted

End Property

Public Property Let MPGAttributesCopyrighted(ByVal PropVal As Long)

    m_MPGAttributesCopyrighted = PropVal

End Property

Public Property Get MPGAttributesCRC() As Long

    MPGAttributesCRC = m_MPGAttributesCRC

End Property

Public Property Let MPGAttributesCRC(ByVal PropVal As Long)

    m_MPGAttributesCRC = PropVal

End Property

Public Property Get MPGAttributesEmphasis() As TMPEGEmphasis

    MPGAttributesEmphasis = m_MPGAttributesEmphasis

End Property

Public Property Let MPGAttributesEmphasis(ByVal PropVal As TMPEGEmphasis)

    m_MPGAttributesEmphasis = PropVal

End Property

Public Function MPGAttributesEmphasisToStr() As String

    Select Case MPGAttributesEmphasis
    Case 0
        MPGAttributesEmphasisToStr = "tmpegeUnknown"
    Case 1
        MPGAttributesEmphasisToStr = "tmpegeNo"
    Case 2
        MPGAttributesEmphasisToStr = "tmpege5015"
    Case 3
        MPGAttributesEmphasisToStr = "tmpegeCCITJ17"
    End Select

End Function

Friend Property Get MPGAttributesFrameCount() As Int64

    MPGAttributesFrameCount = m_MPGAttributesFrameCount

End Property

Friend Property Let MPGAttributesFrameCount(ByRef PropVal As Int64)

    m_MPGAttributesFrameCount = PropVal

End Property

Public Property Get MPGAttributesFrameSize() As Long

    MPGAttributesFrameSize = m_MPGAttributesFrameSize

End Property

Public Property Let MPGAttributesFrameSize(ByVal PropVal As Long)

    m_MPGAttributesFrameSize = PropVal

End Property

Public Property Get MPGAttributesHeader() As Long

    MPGAttributesHeader = m_MPGAttributesHeader

End Property

Public Property Let MPGAttributesHeader(ByVal PropVal As Long)

    m_MPGAttributesHeader = PropVal

End Property

Public Property Get MPGAttributesLayer() As TMPEGLayer

    MPGAttributesLayer = m_MPGAttributesLayer

End Property

Public Property Let MPGAttributesLayer(ByVal PropVal As TMPEGLayer)

    m_MPGAttributesLayer = PropVal

End Property

Public Function MPGAttributesLayerToStr() As String

    Select Case MPGAttributesLayer
    Case 0
        MPGAttributesLayerToStr = "tmpeglUnknown"
    Case 1
        MPGAttributesLayerToStr = "tmpegl1"
    Case 2
        MPGAttributesLayerToStr = "tmpegl2"
    Case 3
        MPGAttributesLayerToStr = "tmpegl3"
    End Select

End Function

Public Property Get MPGAttributesModeExtension() As TMPEGModeExtension

    MPGAttributesModeExtension = m_MPGAttributesModeExtension

End Property

Public Property Let MPGAttributesModeExtension(ByVal PropVal As TMPEGModeExtension)

    m_MPGAttributesModeExtension = PropVal

End Property

Public Function MPGAttributesModeExtensionToStr() As String

    Select Case MPGAttributesModeExtension
    Case 0
        MPGAttributesModeExtensionToStr = "tmpegmeUnknown"
    Case 1
        MPGAttributesModeExtensionToStr = "tmpegmeNone"
    Case 2
        MPGAttributesModeExtensionToStr = "tmpegmeIntensity"
    Case 3
        MPGAttributesModeExtensionToStr = "tmpegmeMS"
    Case 4
        MPGAttributesModeExtensionToStr = "tmpegmeIntensityMS"
    End Select

End Function

Public Property Get MPGAttributesOriginal() As Long

    MPGAttributesOriginal = m_MPGAttributesOriginal

End Property

Public Property Let MPGAttributesOriginal(ByVal PropVal As Long)

    m_MPGAttributesOriginal = PropVal

End Property

Public Property Get MPGAttributesPadding() As Long

    MPGAttributesPadding = m_MPGAttributesPadding

End Property

Public Property Let MPGAttributesPadding(ByVal PropVal As Long)

    m_MPGAttributesPadding = PropVal

End Property

Friend Property Get MPGAttributesPosition() As Int64

    MPGAttributesPosition = m_MPGAttributesPosition

End Property

Friend Property Let MPGAttributesPosition(ByRef PropVal As Int64)

    m_MPGAttributesPosition = PropVal

End Property

Public Property Get MPGAttributesPrivate_() As Long

    MPGAttributesPrivate_ = m_MPGAttributesPrivate_

End Property

Public Property Let MPGAttributesPrivate_(ByVal PropVal As Long)

    m_MPGAttributesPrivate_ = PropVal

End Property

Public Property Get MPGAttributesQuality() As Long

    MPGAttributesQuality = m_MPGAttributesQuality

End Property

Public Property Let MPGAttributesQuality(ByVal PropVal As Long)

    m_MPGAttributesQuality = PropVal

End Property

Public Property Get MPGAttributesSampleRate() As Long

    MPGAttributesSampleRate = m_MPGAttributesSampleRate

End Property

Public Property Let MPGAttributesSampleRate(ByVal PropVal As Long)

    m_MPGAttributesSampleRate = PropVal

End Property

Public Property Get MPGAttributesVBR() As Long

    MPGAttributesVBR = m_MPGAttributesVBR

End Property

Public Property Let MPGAttributesVBR(ByVal PropVal As Long)

    m_MPGAttributesVBR = PropVal

End Property

Public Property Get MPGAttributesVersion() As TMPEGVersion

    MPGAttributesVersion = m_MPGAttributesVersion

End Property

Public Property Let MPGAttributesVersion(ByVal PropVal As TMPEGVersion)

    m_MPGAttributesVersion = PropVal

End Property

Public Function MPGAttributesVersionToStr() As String

    Select Case MPGAttributesVersion
    Case 0
        MPGAttributesVersionToStr = "tmpegvUnknown"
    Case 1
        MPGAttributesVersionToStr = "tmpegv1"
    Case 2
        MPGAttributesVersionToStr = "tmpegv2"
    Case 3
        MPGAttributesVersionToStr = "tmpegv25"
    End Select

End Function

Public Property Get OPUSAttributesBitrate() As Long

    OPUSAttributesBitrate = m_OPUSAttributesBitrate

End Property

Public Property Let OPUSAttributesBitrate(ByVal PropVal As Long)

    m_OPUSAttributesBitrate = PropVal

End Property

Public Property Get OPUSAttributesBitstreamVersion() As Long

    OPUSAttributesBitstreamVersion = m_OPUSAttributesBitstreamVersion

End Property

Public Property Let OPUSAttributesBitstreamVersion(ByVal PropVal As Long)

    m_OPUSAttributesBitstreamVersion = PropVal

End Property

Public Property Get OPUSAttributesChannelCount() As Long

    OPUSAttributesChannelCount = m_OPUSAttributesChannelCount

End Property

Public Property Let OPUSAttributesChannelCount(ByVal PropVal As Long)

    m_OPUSAttributesChannelCount = PropVal

End Property

Public Property Get OPUSAttributesMappingFamily() As Long

    OPUSAttributesMappingFamily = m_OPUSAttributesMappingFamily

End Property

Public Property Let OPUSAttributesMappingFamily(ByVal PropVal As Long)

    m_OPUSAttributesMappingFamily = PropVal

End Property

Public Property Get OPUSAttributesOutputGain() As Long

    OPUSAttributesOutputGain = m_OPUSAttributesOutputGain

End Property

Public Property Let OPUSAttributesOutputGain(ByVal PropVal As Long)

    m_OPUSAttributesOutputGain = PropVal

End Property

Public Property Get OPUSAttributesPlayTime() As Double

    OPUSAttributesPlayTime = m_OPUSAttributesPlayTime

End Property

Public Property Let OPUSAttributesPlayTime(ByVal PropVal As Double)

    m_OPUSAttributesPlayTime = PropVal

End Property

Public Property Get OPUSAttributesPreSkip() As Long

    OPUSAttributesPreSkip = m_OPUSAttributesPreSkip

End Property

Public Property Let OPUSAttributesPreSkip(ByVal PropVal As Long)

    m_OPUSAttributesPreSkip = PropVal

End Property

Friend Property Get OPUSAttributesSampleCount() As Int64

    OPUSAttributesSampleCount = m_OPUSAttributesSampleCount

End Property

Friend Property Let OPUSAttributesSampleCount(ByRef PropVal As Int64)

    m_OPUSAttributesSampleCount = PropVal

End Property

Public Property Get OPUSAttributesSampleRate() As Long

    OPUSAttributesSampleRate = m_OPUSAttributesSampleRate

End Property

Public Property Let OPUSAttributesSampleRate(ByVal PropVal As Long)

    m_OPUSAttributesSampleRate = PropVal

End Property

Public Function TagCount(ByVal TagType As TTagType) As Integer

    TagCount = TagsLibrary_TagCount(LngTags, TagType)

End Function
