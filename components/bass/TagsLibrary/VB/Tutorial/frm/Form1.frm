VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmMain 
   BorderStyle     =   3  'Fester Dialog
   Caption         =   "Tags Library Tutorial for VB6"
   ClientHeight    =   10590
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   9825
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   706
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   655
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows-Standard
   Begin VB.CommandButton cmdAttribute 
      Caption         =   "Attribute instead of Attributes"
      Height          =   735
      Left            =   8280
      TabIndex        =   30
      Top             =   9360
      Width           =   1215
   End
   Begin VB.CommandButton cmdExport 
      Caption         =   "Export"
      Enabled         =   0   'False
      Height          =   375
      Left            =   8280
      TabIndex        =   14
      Top             =   8880
      Width           =   1215
   End
   Begin VB.CommandButton cmdDelete 
      Caption         =   "Delete"
      Enabled         =   0   'False
      Height          =   375
      Left            =   8280
      TabIndex        =   13
      Top             =   8400
      Width           =   1215
   End
   Begin VB.CommandButton cmdAdd 
      Caption         =   "Add"
      Enabled         =   0   'False
      Height          =   375
      Left            =   8280
      TabIndex        =   12
      Top             =   7920
      Width           =   1215
   End
   Begin VB.Frame fraCoverarts 
      Caption         =   "Cover arts:"
      Height          =   2655
      Left            =   240
      TabIndex        =   11
      Top             =   7800
      Width           =   7935
      Begin VB.TextBox txtBitRate 
         Height          =   285
         Left            =   5520
         TabIndex        =   29
         Top             =   2160
         Width           =   2175
      End
      Begin VB.TextBox txtSampleCount 
         Height          =   285
         Left            =   5520
         TabIndex        =   28
         Top             =   1800
         Width           =   2175
      End
      Begin VB.TextBox txtPlayTime 
         Height          =   285
         Left            =   5520
         TabIndex        =   27
         Top             =   1440
         Width           =   2175
      End
      Begin VB.TextBox txtBitsPerSample 
         Height          =   285
         Left            =   5520
         TabIndex        =   26
         Top             =   1080
         Width           =   2175
      End
      Begin VB.TextBox txtSamplesPerSec 
         Height          =   285
         Left            =   5520
         TabIndex        =   25
         Top             =   720
         Width           =   2175
      End
      Begin VB.TextBox txtChannels 
         Height          =   285
         Left            =   5520
         TabIndex        =   24
         Top             =   360
         Width           =   2175
      End
      Begin VB.Image Image1 
         Height          =   1920
         Left            =   120
         Top             =   240
         Width           =   2640
      End
      Begin VB.Label lblCoverName 
         Alignment       =   2  'Zentriert
         AutoSize        =   -1  'True
         Caption         =   "Cover"
         Height          =   195
         Left            =   1200
         TabIndex        =   31
         Top             =   2280
         Width           =   435
      End
      Begin VB.Label lblBitRate 
         AutoSize        =   -1  'True
         Caption         =   "BitRate:"
         Height          =   195
         Left            =   4080
         TabIndex        =   23
         Top             =   2160
         Width           =   570
      End
      Begin VB.Label lblSampleCount 
         AutoSize        =   -1  'True
         Caption         =   "SampleCount:"
         Height          =   195
         Left            =   4080
         TabIndex        =   22
         Top             =   1800
         Width           =   990
      End
      Begin VB.Label lblPlayTime 
         AutoSize        =   -1  'True
         Caption         =   "PlayTime:"
         Height          =   195
         Left            =   4080
         TabIndex        =   21
         Top             =   1440
         Width           =   690
      End
      Begin VB.Label lblBitsPerSample 
         AutoSize        =   -1  'True
         Caption         =   "BitsPerSample:"
         Height          =   195
         Left            =   4080
         TabIndex        =   20
         Top             =   1080
         Width           =   1065
      End
      Begin VB.Label lblSamplesPerSec 
         AutoSize        =   -1  'True
         Caption         =   "SamplesPerSec:"
         Height          =   195
         Left            =   4080
         TabIndex        =   19
         Top             =   720
         Width           =   1170
      End
      Begin VB.Label lblChannels 
         AutoSize        =   -1  'True
         Caption         =   "Channels:"
         Height          =   195
         Left            =   4080
         TabIndex        =   18
         Top             =   360
         Width           =   705
      End
   End
   Begin VB.Frame fraAllTags 
      Height          =   4815
      Left            =   240
      TabIndex        =   9
      Top             =   2880
      Width           =   9255
      Begin MSComctlLib.ListView ListView1 
         Height          =   4425
         Left            =   120
         TabIndex        =   10
         Top             =   240
         Width           =   9015
         _ExtentX        =   15901
         _ExtentY        =   7805
         View            =   3
         Arrange         =   2
         MultiSelect     =   -1  'True
         LabelWrap       =   -1  'True
         HideSelection   =   -1  'True
         AllowReorder    =   -1  'True
         FullRowSelect   =   -1  'True
         GridLines       =   -1  'True
         _Version        =   393217
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         BorderStyle     =   1
         Appearance      =   1
         NumItems        =   4
         BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            Key             =   "Name"
            Text            =   "Name"
            Object.Width           =   2540
         EndProperty
         BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   1
            Key             =   "Value"
            Text            =   "Value"
            Object.Width           =   2893
         EndProperty
         BeginProperty ColumnHeader(3) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   2
            Key             =   "TagsName"
            Text            =   "Tags Name"
            Object.Width           =   3246
         EndProperty
         BeginProperty ColumnHeader(4) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
            SubItemIndex    =   3
            Key             =   "TagsValue"
            Text            =   "Tags Value"
            Object.Width           =   5716
         EndProperty
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "All Tags"
         Height          =   195
         Left            =   3240
         TabIndex        =   33
         Top             =   0
         Width           =   570
      End
      Begin VB.Label lblAttrib 
         AutoSize        =   -1  'True
         Caption         =   "Various AudioAttributes"
         Height          =   195
         Left            =   120
         TabIndex        =   32
         Top             =   0
         Width           =   1635
      End
   End
   Begin VB.Frame fraTags 
      Caption         =   "Tags:"
      Height          =   1455
      Left            =   240
      TabIndex        =   5
      Top             =   1320
      Width           =   9255
      Begin VB.TextBox txtAlbum 
         Height          =   285
         Left            =   840
         TabIndex        =   17
         Top             =   1080
         Width           =   8295
      End
      Begin VB.TextBox txtTitle 
         Height          =   285
         Left            =   840
         TabIndex        =   16
         Top             =   720
         Width           =   8295
      End
      Begin VB.TextBox txtArtist 
         Height          =   285
         Left            =   840
         TabIndex        =   15
         Top             =   360
         Width           =   8295
      End
      Begin VB.Label lblAlbum 
         AutoSize        =   -1  'True
         Caption         =   "Album:"
         Height          =   195
         Left            =   240
         TabIndex        =   8
         Top             =   1080
         Width           =   480
      End
      Begin VB.Label lblTitle 
         AutoSize        =   -1  'True
         Caption         =   "Title:"
         Height          =   195
         Left            =   240
         TabIndex        =   7
         Top             =   720
         Width           =   345
      End
      Begin VB.Label lblArtist 
         AutoSize        =   -1  'True
         Caption         =   "Artist:"
         Height          =   195
         Left            =   240
         TabIndex        =   6
         Top             =   360
         Width           =   390
      End
   End
   Begin MSComDlg.CommonDialog comdlgOpen 
      Left            =   9240
      Top             =   11040
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton cmdSave 
      Caption         =   "Save"
      Enabled         =   0   'False
      Height          =   375
      Left            =   8280
      TabIndex        =   4
      Top             =   720
      Width           =   1215
   End
   Begin VB.CommandButton cmdRemove 
      Caption         =   "Remove"
      Enabled         =   0   'False
      Height          =   375
      Left            =   6960
      TabIndex        =   3
      Top             =   720
      Width           =   1215
   End
   Begin VB.CommandButton cmdOpen 
      Caption         =   "..."
      Height          =   255
      Left            =   9000
      TabIndex        =   2
      Top             =   360
      Width           =   495
   End
   Begin VB.TextBox txtFilename 
      Height          =   285
      Left            =   1080
      TabIndex        =   1
      Top             =   360
      Width           =   7815
   End
   Begin VB.Label lblFilename 
      Caption         =   "Filename:"
      Height          =   195
      Left            =   240
      TabIndex        =   0
      Top             =   360
      Width           =   675
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Tags As clsTags
Private PicFromMem As clsPicFromMem

Private Sub CleanUp()

    ListView1.ListItems.Clear
    txtArtist.Text = ""
    txtTitle.Text = ""
    txtAlbum.Text = ""
    txtChannels.Text = ""
    txtSamplesPerSec.Text = ""
    txtBitsPerSample.Text = ""
    txtPlayTime.Text = ""
    txtSampleCount.Text = ""
    txtBitRate.Text = ""
    Set Image1 = Nothing
    lblCoverName.Caption = "Cover"
    Set PicFromMem = Nothing
    Set Tags = Nothing

End Sub

Private Sub cmdAttribute_Click()

Dim SongTime As Long

    txtChannels.Text = Tags.GetAudioAttribute(aaChannels)
    txtSamplesPerSec.Text = Tags.GetAudioAttribute(aaSamplesPerSec)
    txtBitsPerSample.Text = Tags.GetAudioAttribute(aaBitsPerSample)
    SongTime = CLng(Tags.GetAudioAttribute(aaPlayTime))
    txtPlayTime.Text = Tags.GetTimeFormat(SongTime)
    txtSampleCount.Text = Tags.GetAudioAttribute(aaSampleCount)
    txtBitRate.Text = Tags.GetAudioAttribute(aaBitRate)

End Sub

Private Sub cmdOpen_Click()

    comdlgOpen.DialogTitle = "Select a File..."
    comdlgOpen.CancelError = False
    comdlgOpen.Flags = cdlOFNExplorer Or cdlOFNHideReadOnly
    comdlgOpen.Filter = "MPG files (*.mp3*,*.mp1*,*.mp2*,*.mpa*,*.mpc*)|*.mp3*;*.mp1*;*.mp2*;*.mpa*;*.mpc*|" + _
                        "FLAC files (*.flac*,*.ogg*)|*.flac*;*.ogg*|" + _
                        "MP4 files (*.m4a*)|*.m4a*|" + _
                        "OPUS files (*.opus*)|*.opus*"
                        '"All files (*.mp1*,*.mp2*,*.mp3*,*.mpa*,*.flac*,*.ogg*,*.mpc*)|*.mp1*;*.mp2*;*.mp3*;*.mpa*;*.flac*;*.ogg*;*.mpc*"
    comdlgOpen.ShowOpen
    txtFilename.Text = comdlgOpen.FileName

    If txtFilename.Text <> "" Then
        LoadTag comdlgOpen.FilterIndex
    End If

End Sub

Private Sub LoadTag(ByVal index As Integer)

Dim IntI As Integer
Dim SongTime As Long
Dim hBitmap As Long

    CleanUp

    If txtFilename.Text <> "" Then
        Set Tags = New clsTags

        If Not Tags.Loaded(ttAutomatic) Then
            Tags.Create
        End If

        Tags.Load txtFilename.Text, ttAutomatic

        txtArtist.Text = Tags.GetTag("ARTIST", ttAutomatic)
        txtTitle.Text = Tags.GetTag("TITLE", ttAutomatic)
        txtAlbum.Text = Tags.GetTag("ALBUM", ttAutomatic)

        Select Case index
        Case 1
            lblAttrib.Caption = "Mpeg AudioAttributes"
            Tags.GetMPEGAudioAttributes atMPEG

            ListView1.ListItems.Add (1), , "Position"
            ListView1.ListItems(1).ListSubItems.Add , , Tags.MPGAttributesPosition.LowPart
            ListView1.ListItems.Add (2), , "FrameSize"
            ListView1.ListItems(2).ListSubItems.Add , , Tags.MPGAttributesFrameSize
            ListView1.ListItems.Add (3), , "Version"
            ListView1.ListItems(3).ListSubItems.Add , , Tags.MPGAttributesVersionToStr
            ListView1.ListItems.Add (4), , "Layer"
            ListView1.ListItems(4).ListSubItems.Add , , Tags.MPGAttributesLayerToStr
            ListView1.ListItems.Add (5), , "CRC"
            ListView1.ListItems(5).ListSubItems.Add , , IIf(Tags.MPGAttributesCRC, "True", "False")
            ListView1.ListItems.Add (6), , "Bitrate"
            ListView1.ListItems(6).ListSubItems.Add , , Tags.MPGAttributesBitrate
            ListView1.ListItems.Add (7), , "SampleRate"
            ListView1.ListItems(7).ListSubItems.Add , , Tags.MPGAttributesSampleRate
            ListView1.ListItems.Add (8), , "Padding"
            ListView1.ListItems(8).ListSubItems.Add , , IIf(Tags.MPGAttributesPadding, "True", "False")
            ListView1.ListItems.Add (9), , "Private_"
            ListView1.ListItems(9).ListSubItems.Add , , IIf(Tags.MPGAttributesPrivate_, "True", "False")
            ListView1.ListItems.Add (10), , "ChannelMode"
            ListView1.ListItems(10).ListSubItems.Add , , Tags.MPGAttributesChannelModeToStr
            ListView1.ListItems.Add (11), , "ModeExtension"
            ListView1.ListItems(11).ListSubItems.Add , , Tags.MPGAttributesModeExtensionToStr
            ListView1.ListItems.Add (12), , "Copyrighted"
            ListView1.ListItems(12).ListSubItems.Add , , IIf(Tags.MPGAttributesCopyrighted, "True", "False")
            ListView1.ListItems.Add (13), , "Original"
            ListView1.ListItems(13).ListSubItems.Add , , IIf(Tags.MPGAttributesOriginal, "True", "False")
            ListView1.ListItems.Add (14), , "Emphasis"
            ListView1.ListItems(14).ListSubItems.Add , , Tags.MPGAttributesEmphasisToStr
            ListView1.ListItems.Add (15), , "VBR"
            ListView1.ListItems(15).ListSubItems.Add , , IIf(Tags.MPGAttributesVBR, "True", "False")
            ListView1.ListItems.Add (16), , "FrameCount"
            ListView1.ListItems(16).ListSubItems.Add , , Tags.MPGAttributesFrameCount.LowPart
            ListView1.ListItems.Add (17), , "Quality"
            ListView1.ListItems(17).ListSubItems.Add , , Tags.MPGAttributesQuality
            ListView1.ListItems.Add (18), , "Bytes"
            ListView1.ListItems(18).ListSubItems.Add , , Tags.MPGAttributesBytes.LowPart
        Case 2
            lblAttrib.Caption = "Flac AudioAttributes"
            Tags.GetFlacAudioAttributes atFlac

            ListView1.ListItems.Add (1), , "Channels"
            ListView1.ListItems(1).ListSubItems.Add , , Tags.FlacAttributesChannels
            ListView1.ListItems.Add (2), , "SampleRate"
            ListView1.ListItems(2).ListSubItems.Add , , Tags.FlacAttributesSampleRate
            ListView1.ListItems.Add (3), , "BitsPerSample"
            ListView1.ListItems(3).ListSubItems.Add , , Tags.FlacAttributesBitsPerSample
            ListView1.ListItems.Add (4), , "SampleCount"
            ListView1.ListItems(4).ListSubItems.Add , , Tags.FlacAttributesSampleCount.LowPart
            ListView1.ListItems.Add (5), , "PlayTime"
            SongTime = CLng(Tags.FlacAttributesPlayTime)
            ListView1.ListItems(5).ListSubItems.Add , , Tags.GetTimeFormat(SongTime)
            ListView1.ListItems.Add (6), , "Ratio"
            ListView1.ListItems(6).ListSubItems.Add , , Tags.FlacAttributesRatio
            ListView1.ListItems.Add (7), , "ChannelMode"
            ListView1.ListItems(7).ListSubItems.Add , , LPWSTRtoBSTR(Tags.FlacAttributesChannelMode)
            ListView1.ListItems.Add (8), , "Bitrate"
            ListView1.ListItems(8).ListSubItems.Add , , Tags.FlacAttributesBitrate
            For IntI = 9 To Tags.TagCount(ttAutomatic)
                ListView1.ListItems.Add (IntI)
                ListView1.ListItems(IntI).ListSubItems.Add
            Next
        Case 3
            lblAttrib.Caption = "Mp4 AudioAttributes"
            Tags.GetMP4AudioAttributes atMP4

            ListView1.ListItems.Add (1), , "Channels"
            ListView1.ListItems(1).ListSubItems.Add , , Tags.MP4AttributesChannels
            ListView1.ListItems.Add (2), , "SampleRate"
            ListView1.ListItems(2).ListSubItems.Add , , Tags.MP4AttributesSampleRate
            ListView1.ListItems.Add (3), , "BitsPerSample"
            ListView1.ListItems(3).ListSubItems.Add , , Tags.MP4AttributesBitsPerSample
            ListView1.ListItems.Add (4), , "PlayTime"
            SongTime = CLng(Tags.MP4AttributesPlayTime)
            ListView1.ListItems(4).ListSubItems.Add , , Tags.GetTimeFormat(SongTime)
            ListView1.ListItems.Add (5), , "Bitrate"
            ListView1.ListItems(5).ListSubItems.Add , , Tags.MP4AttributesBitrate
            For IntI = 6 To Tags.TagCount(ttAutomatic)
                ListView1.ListItems.Add (IntI)
                ListView1.ListItems(IntI).ListSubItems.Add
            Next
        Case 4
            lblAttrib.Caption = "Opus AudioAttributes"
            Tags.GetOpusAudioAttributes atOpus

            ListView1.ListItems.Add (1), , "BitstreamVersion"
            ListView1.ListItems(1).ListSubItems.Add , , Tags.OPUSAttributesBitstreamVersion
            ListView1.ListItems.Add (2), , "ChannelCount"
            ListView1.ListItems(2).ListSubItems.Add , , Tags.OPUSAttributesChannelCount
            ListView1.ListItems.Add (3), , "PreSkip"
            ListView1.ListItems(3).ListSubItems.Add , , Tags.OPUSAttributesPreSkip
            ListView1.ListItems.Add (4), , "SampleRate"
            ListView1.ListItems(4).ListSubItems.Add , , Tags.OPUSAttributesSampleRate
            ListView1.ListItems.Add (5), , "OutputGain"
            ListView1.ListItems(5).ListSubItems.Add , , Tags.OPUSAttributesOutputGain
            ListView1.ListItems.Add (6), , "MappingFamily"
            ListView1.ListItems(6).ListSubItems.Add , , Tags.OPUSAttributesMappingFamily
            ListView1.ListItems.Add (7), , "PlayTime"
            SongTime = CLng(Tags.OPUSAttributesPlayTime)
            ListView1.ListItems(7).ListSubItems.Add , , Tags.GetTimeFormat(SongTime)
            ListView1.ListItems.Add (8), , "SampleCount"
            ListView1.ListItems(8).ListSubItems.Add , , Tags.OPUSAttributesSampleCount.LowPart
            ListView1.ListItems.Add (9), , "Bitrate"
            ListView1.ListItems(9).ListSubItems.Add , , Tags.OPUSAttributesBitrate
            For IntI = 10 To Tags.TagCount(ttAutomatic)
                ListView1.ListItems.Add (IntI)
                ListView1.ListItems(IntI).ListSubItems.Add
            Next
        End Select

        Tags.GetAudioAttributes atAutomatic

        txtChannels.Text = Tags.AttributesChannels
        txtSamplesPerSec.Text = Tags.AttributesSamplesPerSec
        txtBitsPerSample.Text = Tags.AttributesBitsPerSample
        SongTime = CLng(Tags.AttributesPlayTime)
        txtPlayTime.Text = Tags.GetTimeFormat(SongTime)
        txtSampleCount.Text = Tags.AttributesSampleCount.LowPart
        txtBitRate.Text = Tags.AttributesBitrate

        For IntI = 0 To Tags.CoverArtCount(ttAutomatic) - 1
            If Tags.GetCoverArt(ttAutomatic, IntI) Then
                Debug.Print Tags.CoverArtName, LPWSTRtoBSTR(Tags.CoverArtName)
                Debug.Print Tags.CoverArtData, VarPtr(Tags.CoverArtData)
                Debug.Print Tags.CoverArtDataSize.LowPart
                Debug.Print Tags.CoverArtDescription, LPWSTRtoBSTR(Tags.CoverArtDescription)
                Debug.Print Tags.CoverArtCoverType
                Debug.Print Tags.CoverArtMIMEType, LPWSTRtoBSTR(Tags.CoverArtMIMEType)
                Debug.Print Tags.CoverArtPictureFormat, Tags.CoverArtPictureFormatToStr
                Debug.Print Tags.CoverArtWidth
                Debug.Print Tags.CoverArtHeight
                Debug.Print Tags.CoverArtColorDepth
                Debug.Print Tags.CoverArtNoOfColors
                Debug.Print Tags.CoverArtID3v2TextEncoding
                Debug.Print Tags.CoverArtIndex
            End If
        Next

        If Tags.CoverArtData <> 0 Then

            Set PicFromMem = New clsPicFromMem

            hBitmap = PicFromMem.MemToHBitmap(Tags.CoverArtData, Tags.CoverArtDataSize.LowPart)
            
            Image1.Picture = PicFromMem.HBitmapToStdPicture(hBitmap, vbPicTypeBitmap)
            
            Image1.width = 2640
            Image1.height = 1920
            Image1.Stretch = True
            
            lblCoverName.Caption = LPWSTRtoBSTR(Tags.CoverArtName)
        End If

        For IntI = 0 To Tags.TagCount(ttAutomatic) - 1
            If Tags.GetTagByIndexEx(IntI, ttAutomatic) Then
                ListView1.ListItems(IntI + 1).ListSubItems.Add , "TagsName", LPWSTRtoBSTR(Tags.ExtTagName)
                ListView1.ListItems(IntI + 1).ListSubItems.Add , "TagsValue", LPWSTRtoBSTR(Tags.ExtTagValue)
            End If
        Next

    End If

End Sub
