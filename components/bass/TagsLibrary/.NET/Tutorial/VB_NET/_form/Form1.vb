Option Explicit On

Imports System.IO
Imports System.IO.File
Imports TagsLib_API
Imports TagsLib_API.Utils
Imports System.Runtime.InteropServices
Imports System.Drawing.Imaging

Public Class Form1

    Dim Tags As HTAGS
    Dim TagsError As TTagError
    Dim CoverTypes As TCoverTypes
    Dim AudioFileFormat As TAudioFileFormat

    Private Sub CleanUp()

        ListView1.Items.Clear()
        ListView2.Items.Clear()
        lvThumb.Items.Clear()
        ImageListThumbs.Images.Clear()

        txtArtist.Text = ""
        txtTitle.Text = ""
        txtAlbum.Text = ""
        txtChannels.Text = ""
        txtSamplesPerSec.Text = ""
        txtBitsPerSample.Text = ""
        txtPlayTime.Text = ""
        txtSampleCount.Text = ""
        txtBitRate.Text = ""
        rbCoverfront.Checked = False
        rbLabel.Checked = False
        rbCoverback.Checked = False
        rbBand.Checked = False
        rbArtist.Checked = False
        rbConductor.Checked = False
        rbComposer.Checked = False
        rbBandLogo.Checked = False
        rbOther.Checked = False
        rbPerformance.Checked = False

        AudioFileFormat = TagsLib.TagsLibrary_GetAudioFormat(txtFilename.Text)

        ' Free TagsLib
        If Tags.HTags <> IntPtr.Zero Then
            TagsLib.TagsLibrary_Free(Tags)
            Tags.HTags = IntPtr.Zero
            SetConfig(AudioFileFormat)
        Else
            ' First start of Application
            SetConfig(AudioFileFormat)
        End If

    End Sub

    Private Sub SetConfig(ByVal AudioFileFormat As TAudioFileFormat)

        Select Case AudioFileFormat
            Case TAudioFileFormat.affOggFlac
                TagsLib.TagsLibrary_SetConfig(Tags, CType(1, IntPtr), TConfigFlags.TAGSLIBRARY_PARSE_OGG_PLAYTIME, TTagType.ttAutomatic)

            Case TAudioFileFormat.affOpus
                TagsLib.TagsLibrary_SetConfig(Tags, CType(1, IntPtr), TConfigFlags.TAGSLIBRARY_DEEP_OPUS_BITRATE_SCAN, TTagType.ttAutomatic)
                TagsLib.TagsLibrary_SetConfig(Tags, CType(1, IntPtr), TConfigFlags.TAGSLIBRARY_PARSE_OGG_PLAYTIME, TTagType.ttAutomatic)

            Case TAudioFileFormat.affMusePack
                TagsLib.TagsLibrary_SetConfig(Tags, CType(1, IntPtr), TConfigFlags.TAGSLIBRARY_PARSE_MUSEPACK_AUDIO_ATTRIBUTES, TTagType.ttAutomatic)

            Case TAudioFileFormat.affWavPack
                TagsLib.TagsLibrary_SetConfig(Tags, CType(1, IntPtr), TConfigFlags.TAGSLIBRARY_PARSE_WAVPACK_AUDIO_ATTRIBUTES, TTagType.ttAutomatic)

        End Select

    End Sub

    Private Sub LoadTag()

        CleanUp()

        If Not TagsLib.TagsLibrary_Loaded(Tags, TTagType.ttAutomatic) Then
            Tags = TagsLib.TagsLibrary_Create()
        End If

        If txtFilename.Text <> "" Then
            TagsError = TagsLib.TagsLibrary_Load(Tags, txtFilename.Text, TTagType.ttAutomatic, True)
            If TagsError = TTagError.TAGSLIBRARY_SUCCESS Then
                txtArtist.Text = TagsLib.TagsLibrary_GetTag(Tags, "ARTIST", TTagType.ttAutomatic)
                txtTitle.Text = TagsLib.TagsLibrary_GetTag(Tags, "TITLE", TTagType.ttAutomatic)
                txtAlbum.Text = TagsLib.TagsLibrary_GetTag(Tags, "ALBUM", TTagType.ttAutomatic)
            End If
        End If

        Dim arr(1) As String
        Dim itm As New ListViewItem
        ListView1.View = View.Details

        Select Case AudioFileFormat
            Case TAudioFileFormat.affMPEG
                Dim MPGAudioAttributes As New TMPEGAudioAttributes

                lblAttrib.Text = "Mpeg AudioAttributes"
                TagsLib.TagsLibrary_GetAudioAttributes(Tags, TAudioType.atMPEG, MPGAudioAttributes)

                arr(0) = "Position"
                arr(1) = MPGAudioAttributes.Position.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "FrameSize"
                arr(1) = MPGAudioAttributes.FrameSize.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Version"
                arr(1) = MPGAudioAttributes.Version.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Layer"
                arr(1) = MPGAudioAttributes.Layer.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "CRC"
                arr(1) = MPGAudioAttributes.CRC.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Bitrate"
                arr(1) = MPGAudioAttributes.BitRate.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "SampleRate"
                arr(1) = MPGAudioAttributes.SampleRate.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Padding"
                arr(1) = MPGAudioAttributes.Padding.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "_Private"
                arr(1) = MPGAudioAttributes._Private.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "ChannelMode"
                arr(1) = MPGAudioAttributes.ChannelMode.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "ModeExtension"
                arr(1) = MPGAudioAttributes.ModeExtension.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Copyrighted"
                arr(1) = MPGAudioAttributes.Copyrighted.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Original"
                arr(1) = MPGAudioAttributes.Original.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Emphasis"
                arr(1) = MPGAudioAttributes.Emphasis.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "VBR"
                arr(1) = MPGAudioAttributes.VBR.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "FrameCount"
                arr(1) = MPGAudioAttributes.FrameCount.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Quality"
                arr(1) = MPGAudioAttributes.Quality.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Bytes"
                arr(1) = MPGAudioAttributes.Bytes.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

            Case TAudioFileFormat.affFlac
                Dim FlacAudioAttributes As New TFlacAudioAttributes()

                lblAttrib.Text = "Flac AudioAttributes"
                TagsLib.TagsLibrary_GetAudioAttributes(Tags, TAudioType.atFlac, FlacAudioAttributes)

                arr(0) = "Channels"
                arr(1) = FlacAudioAttributes.Channels.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "SampleRate"
                arr(1) = FlacAudioAttributes.SampleRate.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "BitsPerSample"
                arr(1) = FlacAudioAttributes.BitsPerSample.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "SampleCount"
                arr(1) = FlacAudioAttributes.SampleCount.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "PlayTime"
                arr(1) = FlacAudioAttributes.Playtime.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Ratio"
                arr(1) = FlacAudioAttributes.Ratio.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "ChannelMode"
                arr(1) = Marshal.PtrToStringAuto(FlacAudioAttributes.ChannelModeSPtr)
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Bitrate"
                arr(1) = FlacAudioAttributes.Bitrate.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

            Case TAudioFileFormat.affMP4
                Dim MP4AudioAttributes As New TMP4AudioAttributes()

                lblAttrib.Text = "Mp4 AudioAttributes"
                TagsLib.TagsLibrary_GetAudioAttributes(Tags, TAudioType.atMP4, MP4AudioAttributes)

                arr(0) = "Channels"
                arr(1) = MP4AudioAttributes.Channels.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "SampleRate"
                arr(1) = MP4AudioAttributes.SampleRate.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "BitsPerSample"
                arr(1) = MP4AudioAttributes.BitsPerSample.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "PlayTime"
                arr(1) = MP4AudioAttributes.Playtime.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Bitrate"
                arr(1) = MP4AudioAttributes.Bitrate.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

            Case TAudioFileFormat.affOpus
                Dim OpusAudioAttributes As New TOpusAudioAttributes()

                lblAttrib.Text = "Opus AudioAttributes"
                TagsLib.TagsLibrary_GetAudioAttributes(Tags, TAudioType.atOpus, OpusAudioAttributes)

                arr(0) = "BitstreamVersion"
                arr(1) = OpusAudioAttributes.BitstreamVersion.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "ChannelCount"
                arr(1) = OpusAudioAttributes.ChannelCount.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "PreSkip"
                arr(1) = OpusAudioAttributes.PreSkip.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "SampleRate"
                arr(1) = OpusAudioAttributes.SampleRate.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "OutputGain"
                arr(1) = OpusAudioAttributes.OutputGain.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "MappingFamily"
                arr(1) = OpusAudioAttributes.MappingFamily.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "PlayTime"
                arr(1) = OpusAudioAttributes.PlayTime.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "SampleCount"
                arr(1) = OpusAudioAttributes.SampleCount.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Bitrate"
                arr(1) = OpusAudioAttributes.BitRate.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

            Case TAudioFileFormat.affMusePack
                Dim MusePackAttributes As New TMusePackAttributes()

                lblAttrib.Text = "MusePack AudioAttributes"
                TagsLib.TagsLibrary_GetAudioAttributes(Tags, TAudioType.atMusePack, MusePackAttributes)

                arr(0) = "ChannelModeID"
                arr(1) = MusePackAttributes.ChannelModeID.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "ChannelMode"
                arr(1) = Marshal.PtrToStringAuto(MusePackAttributes.ChannelModeSPtr)
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "FrameCount"
                arr(1) = MusePackAttributes.FrameCount.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "BitRate"
                arr(1) = MusePackAttributes.BitRate.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "StreamVersion"
                arr(1) = MusePackAttributes.StreamVersion.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "StreamStreamVersionString"
                arr(1) = Marshal.PtrToStringAuto(MusePackAttributes.StreamStreamVersionStringSPtr)
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "SampleRate"
                arr(1) = MusePackAttributes.SampleRate.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "ProfileID"
                arr(1) = MusePackAttributes.ProfileID.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Profile"
                arr(1) = Marshal.PtrToStringAuto(MusePackAttributes.ProfileSPtr)
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "PlayTime"
                arr(1) = MusePackAttributes.PlayTime.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Encoder"
                arr(1) = Marshal.PtrToStringAuto(MusePackAttributes.EncoderSPtr)
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Ratio"
                arr(1) = MusePackAttributes.Ratio.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

            Case TAudioFileFormat.affWavPack
                Dim WavePackAttributes As New TWAVPackAttributes()

                lblAttrib.Text = "WavePack AudioAttributes"
                TagsLib.TagsLibrary_GetAudioAttributes(Tags, TAudioType.atWAVPack, WavePackAttributes)

                arr(0) = "FormatTag"
                arr(1) = WavePackAttributes.FormatTag.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Version"
                arr(1) = WavePackAttributes.Version.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Channels"
                arr(1) = WavePackAttributes.Channels.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "ChannelMode"
                arr(1) = Marshal.PtrToStringAuto(WavePackAttributes.ChannelModeSPtr)
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "SampleRate"
                arr(1) = WavePackAttributes.SampleRate.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Bits"
                arr(1) = WavePackAttributes.Bits.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Bitrate"
                arr(1) = WavePackAttributes.Bitrate.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "PlayTime"
                arr(1) = WavePackAttributes.PlayTime.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Samples"
                arr(1) = WavePackAttributes.Samples.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "BSamples"
                arr(1) = WavePackAttributes.BSamples.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Ratio"
                arr(1) = WavePackAttributes.Ratio.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Encoder"
                arr(1) = Marshal.PtrToStringAuto(WavePackAttributes.EncoderSPtr)
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

            Case TAudioFileFormat.affWAV
                Dim WaveAudioAttributes As New TWAVEAudioAttributes()

                lblAttrib.Text = "WavePack AudioAttributes"
                TagsLib.TagsLibrary_GetAudioAttributes(Tags, TAudioType.atWAV, WaveAudioAttributes)

                arr(0) = "FormatTag"
                arr(1) = WaveAudioAttributes.FormatTag.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Channels"
                arr(1) = WaveAudioAttributes.Channels.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "SamplesPerSec"
                arr(1) = WaveAudioAttributes.SamplesPerSec.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "AvgBytesPerSec"
                arr(1) = WaveAudioAttributes.AvgBytesPerSec.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "BlockAlign"
                arr(1) = WaveAudioAttributes.BlockAlign.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "BitsPerSample"
                arr(1) = WaveAudioAttributes.BitsPerSample.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "PlayTime"
                arr(1) = WaveAudioAttributes.PlayTime.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "SampleCount"
                arr(1) = WaveAudioAttributes.SampleCount.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "cbSize"
                arr(1) = WaveAudioAttributes.cbSize.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "ValidBitsPerSample"
                arr(1) = WaveAudioAttributes.ValidBitsPerSample.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "ChannelMask"
                arr(1) = WaveAudioAttributes.ChannelMask.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "SubFormat"
                arr(1) = WaveAudioAttributes.SubFormat.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "BitRate"
                arr(1) = WaveAudioAttributes.BitRate.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

            Case TAudioFileFormat.affDSF
                Dim DSFAudioAttributes As New TDSFAudioAttributes()

                lblAttrib.Text = "DSF AudioAttributes"
                TagsLib.TagsLibrary_GetAudioAttributes(Tags, TAudioType.atDSDDSF, DSFAudioAttributes)

                arr(0) = "FormatVersion"
                arr(1) = DSFAudioAttributes.FormatVersion.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "FormatID"
                arr(1) = DSFAudioAttributes.FormatID.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "ChannelType"
                arr(1) = DSFAudioAttributes.ChannelType.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "ChannelNumber"
                arr(1) = DSFAudioAttributes.ChannelNumber.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "SamplingFrequency"
                arr(1) = DSFAudioAttributes.SamplingFrequency.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "BitsPerSample"
                arr(1) = DSFAudioAttributes.BitsPerSample.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "BlockSizePerChannel"
                arr(1) = DSFAudioAttributes.BlockSizePerChannel.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "PlayTime"
                arr(1) = DSFAudioAttributes.PlayTime.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "SampleCount"
                arr(1) = DSFAudioAttributes.SampleCount.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

                arr(0) = "Bitrate"
                arr(1) = DSFAudioAttributes.Bitrate.ToString()
                itm = New ListViewItem(arr)
                ListView1.Items.Add(itm)

        End Select

        Dim AudioAttributes As New TAudioAttributes

        TagsError = TagsLib.TagsLibrary_GetAudioAttributes(Tags, TAudioType.atAutomatic, AudioAttributes)
        If TagsError = TTagError.TAGSLIBRARY_SUCCESS Then
            txtChannels.Text = AudioAttributes.Channels.ToString()
            txtSamplesPerSec.Text = AudioAttributes.SamplesPerSec.ToString()
            txtBitsPerSample.Text = AudioAttributes.BitsPerSample.ToString()
            txtPlayTime.Text = Utils.GetTimeString(AudioAttributes.PlayTime)
            txtSampleCount.Text = AudioAttributes.SampleCount.ToString()
            txtBitRate.Text = AudioAttributes.Bitrate.ToString()
        End If

        Dim TagData As New TTagData
        Dim IntI As Integer
        Dim Count As Integer
        Dim ExtTag As New TExtTag

        Count = TagsLib.TagsLibrary_TagCount(Tags, TTagType.ttAutomatic) - 1

        ListView2.View = View.Details

        For IntI = 0 To Count
            If TagsLib.TagsLibrary_GetTagByIndexEx(Tags, IntI, TTagType.ttAutomatic, ExtTag) Then
                ListView2.Items.Add(ExtTag.Name)
                ListView2.Items(IntI).SubItems.Add(ExtTag.Value)
            End If
        Next

        For IntI = 0 To Count
            If TagsLib.TagsLibrary_GetTagData(Tags, IntI, TTagType.ttAutomatic, TagData) Then
                Debug.Print(Marshal.PtrToStringAuto(TagData.NameSPtr))
                Debug.Print(TagData.Data.ToString())
                Debug.Print(TagData.DataSize.ToString())
                Debug.Print(TagData.DataType.ToString())
            End If
        Next

        Dim CoverArt As New TCoverArtData()
        Dim CoverArtCount As Integer

        CoverArtCount = TagsLib.TagsLibrary_CoverArtCount(Tags, TTagType.ttAutomatic)

        For IntI = 0 To CoverArtCount - 1
            If TagsLib.TagsLibrary_GetCoverArt(Tags, TTagType.ttAutomatic, IntI, CoverArt) Then
                Debug.Print(Marshal.PtrToStringAuto(CoverArt.NameSPtr))
                Debug.Print(CoverArt.Data.ToString())
                Debug.Print(CoverArt.DataSize.ToString())
                Debug.Print(Marshal.PtrToStringAuto(CoverArt.DescriptionSPtr))
                Debug.Print(CoverArt.CoverType.ToString())
                Debug.Print(Marshal.PtrToStringAuto(CoverArt.MIMETypeSPtr))
                Debug.Print(CoverArt.PictureFormat.ToString())
                Debug.Print(CoverArt.Width.ToString())
                Debug.Print(CoverArt.Height.ToString())
                Debug.Print(CoverArt.ColorDepth.ToString())
                Debug.Print(CoverArt.NoOfColors.ToString())
                Debug.Print(CoverArt.ID3v2TextEncoding.ToString())
                Debug.Print(CoverArt.Index.ToString())
            End If
            '// GetCoverArtFromMemoryPtr over GetImageFromMemPtr
            If CoverArt.Data <> IntPtr.Zero Then
                Dim image As Image
                Dim MyImageKey As String = Guid.NewGuid().ToString()

                image = PicFromMem.GetImageFromMemPtr(CoverArt.Data, CoverArt.DataSize)
                ImageListThumbs.Images.Add(MyImageKey, image)

                Dim lvi As New ListViewItem(Marshal.PtrToStringAuto(CoverArt.NameSPtr))

                lvi.ImageKey = MyImageKey
                lvThumb.Items.Add(lvi)

                Select Case (CoverArt.CoverType)
                    Case TCoverTypes.ctCoverFront
                        rbCoverfront.Checked = True
                        lvi.Text = "Front Cover"
                    Case TCoverTypes.ctCoverback
                        rbCoverback.Checked = True
                        lvi.Text = "Back Cover"
                    Case TCoverTypes.ctLabel
                        rbLabel.Checked = True
                        lvi.Text = "Label"
                    Case TCoverTypes.ctArtist
                        rbArtist.Checked = True
                        lvi.Text = "Artist"
                    Case TCoverTypes.ctConductor
                        rbConductor.Checked = True
                        lvi.Text = "Conductor"
                    Case TCoverTypes.ctBand
                        lvi.Text = "Band"
                        rbBand.Checked = True
                    Case TCoverTypes.ctPerformance
                        lvi.Text = "Performance"
                        rbPerformance.Checked = True
                    Case TCoverTypes.ctComposer
                        lvi.Text = "Composer"
                        rbComposer.Checked = True
                    Case TCoverTypes.ctBandLogo
                        lvi.Text = "Band Logo"
                        rbBandLogo.Checked = True
                    Case TCoverTypes.ctOther
                        lvi.Text = "Other"
                        rbOther.Checked = True
                End Select

            End If
        Next

    End Sub

    Private Sub Form1_FormClosing(sender As Object, e As FormClosingEventArgs) Handles MyBase.FormClosing

        If Tags.HTags <> IntPtr.Zero Then
            If Not TagsLib.TagsLibrary_Free(Tags) Then
                MessageBox.Show("Error TagsLibrary_Free is not free", "TagsLibrary_Free!", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            End If
        End If

    End Sub

    Private Sub btnOpen_MouseDown(sender As Object, e As MouseEventArgs) Handles btnOpen.MouseDown

        With OpenFileDialog1
            .FileName = ""
            .Title = "Select a File..."
            .Filter = "MPG files (*.mp3*,*.mp1*,*.mp2*,*.mpa*)|*.mp3*;*.mp1*;*.mp2*;*.mpa*|" + _
                                     "FLAC files (*.flac*,*.ogg flac*)|*.flac*;*.ogg*|" + _
                                     "MP4 files (*.m4a*)|*.m4a*|" + _
                                     "OPUS files (*.opus*,*.ogg vorbis*)|*.opus*;*.ogg*|" + _
                                     "MusePack (*.mpc*)|*.mpc*|" + _
                                     "WavePack (*.wv*)|*.wv*|" + _
                                     "Wave (*.wav*)|*.wav*|" + _
                                     "DSD/DSF (*.dsd,*.dsf*)|*.dsd*;*.dsf*"
            .ShowDialog()

            txtFilename.Text = .FileName
            If txtFilename.Text <> "" Then
                LoadTag()
            End If
        End With

    End Sub

    Private Sub btnAttribute_MouseDown(sender As Object, e As MouseEventArgs) Handles btnAttribute.MouseDown

        If Tags.HTags <> IntPtr.Zero Then
            txtChannels.Text = TagsLib.TagsLibrary_GetAudioAttribute(Tags, TAudioAttribute.aaChannels).ToString()
            txtSamplesPerSec.Text = TagsLib.TagsLibrary_GetAudioAttribute(Tags, TAudioAttribute.aaSamplesPerSec).ToString()
            txtBitsPerSample.Text = TagsLib.TagsLibrary_GetAudioAttribute(Tags, TAudioAttribute.aaBitsPerSample).ToString()
            txtPlayTime.Text = Utils.GetTimeString(TagsLib.TagsLibrary_GetAudioAttribute(Tags, TAudioAttribute.aaPlayTime))
            txtSampleCount.Text = TagsLib.TagsLibrary_GetAudioAttribute(Tags, TAudioAttribute.aaSampleCount).ToString()
            txtBitRate.Text = TagsLib.TagsLibrary_GetAudioAttribute(Tags, TAudioAttribute.aaBitRate).ToString()
        End If

    End Sub

    Private Sub btnSave_MouseDown(sender As Object, e As MouseEventArgs) Handles btnSave.MouseDown

        If Tags.HTags <> IntPtr.Zero Then
            ' Set specific tags
            TagsLib.TagsLibrary_SetTag(Tags, ("ARTIST"), (txtArtist.Text), TTagType.ttAutomatic)
            TagsLib.TagsLibrary_SetTag(Tags, ("TITLE"), (txtTitle.Text), TTagType.ttAutomatic)
            TagsLib.TagsLibrary_SetTag(Tags, ("ALBUM"), (txtAlbum.Text), TTagType.ttAutomatic)

            TagsError = TagsLib.TagsLibrary_Save(Tags, (txtFilename.Text), TTagType.ttAutomatic)
            If TagsError <> TTagError.TAGSLIBRARY_SUCCESS Then
                MessageBox.Show("Error while saving tag.", "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Else
                ' Reload
                Dim CoverArt As TCoverArtData = New TCoverArtData()
                TagsLib.TagsLibrary_GetCoverArt(Tags, TTagType.ttAutomatic, 0, CoverArt)
                LoadTag()
            End If
        End If

    End Sub

    Private Sub btnExport_MouseDown(sender As Object, e As MouseEventArgs) Handles btnExport.MouseDown

        If Tags.HTags <> IntPtr.Zero Then

            Dim CoverArt As New TCoverArtData()
            Dim Fext As String

            If lvThumb.SelectedItems.Count <> 1 Then
                MessageBox.Show("Please select one cover art.", "Information!", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Exit Sub
            Else
                If TagsLib.TagsLibrary_GetCoverArt(Tags, TTagType.ttAutomatic, lvThumb.SelectedItems(0).Index, CoverArt) Then
                    Select Case CoverArt.PictureFormat
                        Case TTagPictureFormat.tpfJPEG
                            Fext = ".jpg"
                        Case TTagPictureFormat.tpfPNG
                            Fext = ".png"
                        Case TTagPictureFormat.tpfGIF
                            Fext = ".gif"
                        Case TTagPictureFormat.tpfBMP
                            Fext = ".bmp"
                        Case Else
                            Fext = ".unknown"
                    End Select

                    If Marshal.PtrToStringAuto(CoverArt.DescriptionSPtr) <> "" Then
                        Dim newExt As String = Path.ChangeExtension(Marshal.PtrToStringAuto(CoverArt.DescriptionSPtr), Fext)
                        saveFileDialog1.FileName = newExt
                    Else
                        saveFileDialog1.FileName = Fext
                    End If

                    If saveFileDialog1.ShowDialog() = DialogResult.OK Then
                        Dim CoverArtFileStream As System.IO.FileStream = CType(saveFileDialog1.OpenFile(), System.IO.FileStream)
                        Dim bArray() As Byte
                        ReDim bArray(CInt(CoverArt.DataSize))

                        Marshal.Copy(CoverArt.Data, bArray, 0, CInt(CoverArt.DataSize))
                        CoverArtFileStream.Write(bArray, 0, CInt(CoverArt.DataSize))

                        CoverArtFileStream.Close()
                    End If
                End If
            End If
        End If

    End Sub

    Private Sub btnDelete_MouseDown(sender As Object, e As MouseEventArgs) Handles btnDelete.MouseDown

        If Tags.HTags <> IntPtr.Zero Then

            If lvThumb.SelectedItems.Count <> 1 Then
                MessageBox.Show("Please select one cover art.", "Information!", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Exit Sub
            Else
                If (TagsLib.TagsLibrary_DeleteCoverArt(Tags, TTagType.ttAutomatic, lvThumb.SelectedItems(0).Index)) Then
                    btnSave_MouseDown(sender, e)
                End If
            End If
        End If

    End Sub

    Private Sub AddCover(sender As Object, e As MouseEventArgs)

        If Tags.HTags <> IntPtr.Zero Then

            '//* Clear the cover art data
            Dim MIMEType As String = ""
            Dim Description As String = ""
            Dim Width As Integer = 0
            Dim Height As Integer = 0
            Dim ColorDepth As Integer = 0
            Dim NoOfColors As Integer = 0
            Dim pval As IntPtr = IntPtr.Zero

            Dim CoverArtData As TCoverArtData = New TCoverArtData()
            Dim CoverArtPictureFormat As TTagPictureFormat = TTagPictureFormat.tpfUnknown

            OpenFileDialog1.FileName = ""
            OpenFileDialog1.Title = "Select a File..."
            OpenFileDialog1.Filter = "Picture files (*.jpg*,*.jpeg*,*.bmp*,*.png*,*.gif*)|*.jpg*;*.jpeg*;*.bmp*;*.png*;*.gif*"

            If OpenFileDialog1.ShowDialog() = DialogResult.OK Then

                If (File.Exists(OpenFileDialog1.FileName)) Then

                    Dim BitmapStream = New MemoryStream()
                    Dim fs As FileStream = File.Open(OpenFileDialog1.FileName, FileMode.Open)

                    fs.CopyTo(BitmapStream)
                    BitmapStream.Position = 0

                    Dim img As Image = Image.FromStream(BitmapStream)
                    fs.Close()

                    If (img.RawFormat.Equals(System.Drawing.Imaging.ImageFormat.Jpeg)) Then

                        MIMEType = "image/jpeg"
                        CoverArtPictureFormat = TTagPictureFormat.tpfJPEG
                        Description = Path.GetFileName(OpenFileDialog1.FileName)
                        Width = img.Width
                        Height = img.Height
                        NoOfColors = 0
                        ColorDepth = 24

                    ElseIf (img.RawFormat.Equals(System.Drawing.Imaging.ImageFormat.Png)) Then

                        Width = img.Width
                        Height = img.Height
                        NoOfColors = 0
                        ColorDepth = Image.GetPixelFormatSize(img.PixelFormat)

                    ElseIf (img.RawFormat.Equals(System.Drawing.Imaging.ImageFormat.Gif)) Then

                        Width = img.Width
                        Height = img.Height
                        NoOfColors = 0
                        ColorDepth = Image.GetPixelFormatSize(img.PixelFormat)

                    ElseIf (img.RawFormat.Equals(System.Drawing.Imaging.ImageFormat.Bmp)) Then

                        Width = img.Width
                        Height = img.Height
                        NoOfColors = 0
                        ColorDepth = Image.GetPixelFormatSize(img.PixelFormat)
                    End If

                    Dim openFile As Byte()
                    openFile = File.ReadAllBytes(OpenFileDialog1.FileName)

                    Dim imagePtr As IntPtr = Utils.GetPointerfromByteArray(openFile)

                    CoverArtData.NameSPtr = Marshal.StringToHGlobalAuto(Description)
                    CoverArtData.CoverType = CoverTypes
                    CoverArtData.MIMETypeSPtr = Marshal.StringToHGlobalAuto(MIMEType)
                    CoverArtData.DescriptionSPtr = Marshal.StringToHGlobalAuto(Description)
                    CoverArtData.Width = Width
                    CoverArtData.Height = Height
                    CoverArtData.ColorDepth = ColorDepth
                    CoverArtData.NoOfColors = NoOfColors
                    CoverArtData.PictureFormat = CoverArtPictureFormat
                    CoverArtData.Data = imagePtr
                    CoverArtData.DataSize = BitmapStream.Length

                    If (TagsLib.TagsLibrary_AddCoverArt(Tags, TTagType.ttAutomatic, CoverArtData) = -1) Then

                        MessageBox.Show("Error while adding cover art: ", OpenFileDialog1.FileName, MessageBoxButtons.AbortRetryIgnore, MessageBoxIcon.Error)
                    End If
                    imagePtr = IntPtr.Zero

                    BitmapStream.Close()
                    btnSave_MouseDown(sender, e)
                End If
            End If
        End If

    End Sub

    Private Sub btnRemove_MouseDown(sender As Object, e As MouseEventArgs) Handles btnRemove.MouseDown

        If Tags.HTags <> IntPtr.Zero Then
            TagsError = TagsLib.TagsLibrary_RemoveTag(txtFilename.Text, TTagType.ttID3v2)
            If TagsError <> TTagError.TAGSLIBRARY_SUCCESS Then
                MessageBox.Show("Error while removing tags from file.", "", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            End If
            LoadTag()
        End If

    End Sub

    Private Sub rbCoverfront_MouseDown(sender As Object, e As MouseEventArgs) Handles rbCoverfront.MouseDown

        If (Tags.HTags <> IntPtr.Zero) Then
            If (rbCoverfront.Checked) Then
                Exit Sub
            Else
                CoverTypes = TCoverTypes.ctCoverFront
                AddCover(sender, e)
                rbCoverfront.Checked = True
            End If
        End If

    End Sub

    Private Sub rbCoverback_MouseDown(sender As Object, e As MouseEventArgs) Handles rbCoverback.MouseDown

        ' MusePack and WavePack and MP4 used only Cover (front) 
        If ((AudioFileFormat = TAudioFileFormat.affWavPack) Or (AudioFileFormat = TAudioFileFormat.affMusePack)) Then
            MessageBox.Show("CoverType is not supported by APEv2 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Exit Sub
        ElseIf (AudioFileFormat = TAudioFileFormat.affMP4) Then
            MessageBox.Show("CoverType is not supported by MP4 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Exit Sub
        End If

        If (Tags.HTags <> IntPtr.Zero) Then
            If rbCoverback.Checked Then
                Exit Sub
            Else
                CoverTypes = TCoverTypes.ctCoverback
                AddCover(sender, e)
                rbCoverback.Checked = True
            End If
        End If

    End Sub

    Private Sub rbLabel_MouseDown(sender As Object, e As MouseEventArgs) Handles rbLabel.MouseDown

        ' MusePack and WavePack and MP4 used only Cover (front) 
        If ((AudioFileFormat = TAudioFileFormat.affWavPack) Or (AudioFileFormat = TAudioFileFormat.affMusePack)) Then
            MessageBox.Show("CoverType is not supported by APEv2 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Exit Sub
        ElseIf (AudioFileFormat = TAudioFileFormat.affMP4) Then
            MessageBox.Show("CoverType is not supported by MP4 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Exit Sub
        End If

        If (Tags.HTags <> IntPtr.Zero) Then
            If rbLabel.Checked Then
                Exit Sub
            Else
                CoverTypes = TCoverTypes.ctLabel
                AddCover(sender, e)
                rbLabel.Checked = True
            End If
        End If

    End Sub

    Private Sub rbArtist_MouseDown(sender As Object, e As MouseEventArgs) Handles rbArtist.MouseDown

        ' MusePack and WavePack and MP4 used only Cover (front) 
        If ((AudioFileFormat = TAudioFileFormat.affWavPack) Or (AudioFileFormat = TAudioFileFormat.affMusePack)) Then
            MessageBox.Show("CoverType is not supported by APEv2 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Exit Sub
        ElseIf (AudioFileFormat = TAudioFileFormat.affMP4) Then
            MessageBox.Show("CoverType is not supported by MP4 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Exit Sub
        End If

        If (Tags.HTags <> IntPtr.Zero) Then
            If rbArtist.Checked Then
                Exit Sub
            Else
                CoverTypes = TCoverTypes.ctArtist
                AddCover(sender, e)
                rbArtist.Checked = True
            End If
        End If

    End Sub

    Private Sub rbConductor_MouseDown(sender As Object, e As MouseEventArgs) Handles rbConductor.MouseDown

        ' MusePack and WavePack and MP4 used only Cover (front) 
        If ((AudioFileFormat = TAudioFileFormat.affWavPack) Or (AudioFileFormat = TAudioFileFormat.affMusePack)) Then
            MessageBox.Show("CoverType is not supported by APEv2 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Exit Sub
        ElseIf (AudioFileFormat = TAudioFileFormat.affMP4) Then
            MessageBox.Show("CoverType is not supported by MP4 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Exit Sub
        End If

        If (Tags.HTags <> IntPtr.Zero) Then
            If rbConductor.Checked Then
                Exit Sub
            Else
                CoverTypes = TCoverTypes.ctConductor
                AddCover(sender, e)
                rbConductor.Checked = True
            End If
        End If

    End Sub

    Private Sub rbBand_MouseDown(sender As Object, e As MouseEventArgs) Handles rbBand.MouseDown

        ' MusePack and WavePack and MP4 used only Cover (front) 
        If ((AudioFileFormat = TAudioFileFormat.affWavPack) Or (AudioFileFormat = TAudioFileFormat.affMusePack)) Then
            MessageBox.Show("CoverType is not supported by APEv2 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Exit Sub
        ElseIf (AudioFileFormat = TAudioFileFormat.affMP4) Then
            MessageBox.Show("CoverType is not supported by MP4 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Exit Sub
        End If

        If (Tags.HTags <> IntPtr.Zero) Then
            If rbBand.Checked Then
                Exit Sub
            Else
                CoverTypes = TCoverTypes.ctBand
                AddCover(sender, e)
                rbBand.Checked = True
            End If
        End If

    End Sub

    Private Sub rbPerformance_MouseDown(sender As Object, e As MouseEventArgs) Handles rbPerformance.MouseDown

        ' MusePack and WavePack and MP4 used only Cover (front) 
        If ((AudioFileFormat = TAudioFileFormat.affWavPack) Or (AudioFileFormat = TAudioFileFormat.affMusePack)) Then
            MessageBox.Show("CoverType is not supported by APEv2 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Exit Sub
        ElseIf (AudioFileFormat = TAudioFileFormat.affMP4) Then
            MessageBox.Show("CoverType is not supported by MP4 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Exit Sub
        End If

        If (Tags.HTags <> IntPtr.Zero) Then
            If rbPerformance.Checked Then
                Exit Sub
            Else
                CoverTypes = TCoverTypes.ctPerformance
                AddCover(sender, e)
                rbPerformance.Checked = True
            End If
        End If

    End Sub

    Private Sub rbComposer_MouseDown(sender As Object, e As MouseEventArgs) Handles rbComposer.MouseDown

        ' MusePack and WavePack and MP4 used only Cover (front) 
        If ((AudioFileFormat = TAudioFileFormat.affWavPack) Or (AudioFileFormat = TAudioFileFormat.affMusePack)) Then
            MessageBox.Show("CoverType is not supported by APEv2 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Exit Sub
        ElseIf (AudioFileFormat = TAudioFileFormat.affMP4) Then
            MessageBox.Show("CoverType is not supported by MP4 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Exit Sub
        End If

        If (Tags.HTags <> IntPtr.Zero) Then
            If rbComposer.Checked Then
                Exit Sub
            Else
                CoverTypes = TCoverTypes.ctComposer
                AddCover(sender, e)
                rbComposer.Checked = True
            End If
        End If

    End Sub

    Private Sub rbBandLogo_MouseDown(sender As Object, e As MouseEventArgs) Handles rbBandLogo.MouseDown

        ' MusePack and WavePack and MP4 used only Cover (front) 
        If ((AudioFileFormat = TAudioFileFormat.affWavPack) Or (AudioFileFormat = TAudioFileFormat.affMusePack)) Then
            MessageBox.Show("CoverType is not supported by APEv2 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Exit Sub
        ElseIf (AudioFileFormat = TAudioFileFormat.affMP4) Then
            MessageBox.Show("CoverType is not supported by MP4 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Exit Sub
        End If

        If (Tags.HTags <> IntPtr.Zero) Then
            If rbBandLogo.Checked Then
                Exit Sub
            Else
                CoverTypes = TCoverTypes.ctBandLogo
                AddCover(sender, e)
                rbBandLogo.Checked = True
            End If
        End If

    End Sub

    Private Sub rbOther_MouseDown(sender As Object, e As MouseEventArgs) Handles rbOther.MouseDown

        ' MusePack and WavePack and MP4 used only Cover (front) 
        If ((AudioFileFormat = TAudioFileFormat.affWavPack) Or (AudioFileFormat = TAudioFileFormat.affMusePack)) Then
            MessageBox.Show("CoverType is not supported by APEv2 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Exit Sub
        ElseIf (AudioFileFormat = TAudioFileFormat.affMP4) Then
            MessageBox.Show("CoverType is not supported by MP4 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Exit Sub
        End If

        If (Tags.HTags <> IntPtr.Zero) Then
            If rbOther.Checked Then
                Exit Sub
            Else
                CoverTypes = TCoverTypes.ctOther
                AddCover(sender, e)
                rbOther.Checked = True
            End If
        End If

    End Sub

End Class