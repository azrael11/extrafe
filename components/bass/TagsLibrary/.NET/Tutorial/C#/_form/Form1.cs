using System;
using System.Drawing;
using System.IO;
using System.Runtime.InteropServices;
using System.Windows.Forms;
using TagsLib_API;
using TagsLib_API.Utils;

namespace TagsLibraryTutorialDLLC
{
  public partial class Form1 : Form
  {
    private HTAGS Tags;
    private TTagError TagsError;
    private TCoverTypes CoverTypes;
    private TAudioFileFormat AudioFileFormat;

    public Form1()
    {
      InitializeComponent();
    }

    private void CleanUp()
    {
      ListView1.Items.Clear();
      ListView2.Items.Clear();
      lvThumb.Items.Clear();
      ImageListThumbs.Images.Clear();
      txtArtist.Text = "";
      txtTitle.Text = "";
      txtAlbum.Text = "";
      txtChannels.Text = "";
      txtSamplesPerSec.Text = "";
      txtBitsPerSample.Text = "";
      txtPlayTime.Text = "";
      txtSampleCount.Text = "";
      txtBitRate.Text = "";
      rbCoverfront.Checked = false;
      rbLabel.Checked = false;
      rbCoverback.Checked = false;
      rbBand.Checked = false;
      rbArtist.Checked = false;
      rbConductor.Checked = false;
      rbComposer.Checked = false;
      rbBandLogo.Checked = false;
      rbOther.Checked = false;
      rbPerformance.Checked = false;

      AudioFileFormat = TagsLib.TagsLibrary_GetAudioFormat(txtFilename.Text);

      // Free TagsLib
      if (Tags.HTags != IntPtr.Zero)
      {
        TagsLib.TagsLibrary_Free(Tags);
        Tags.HTags = IntPtr.Zero;
        SetConfig(AudioFileFormat);
      }
      else
      {
        // First start of Application
        SetConfig(AudioFileFormat);
      }
    }

    private void SetConfig(TAudioFileFormat AudioFileFormat)
    {
      switch (AudioFileFormat)
      {
        case TAudioFileFormat.affOggFlac:
          {
            TagsLib.TagsLibrary_SetConfig(Tags, (IntPtr)1, TConfigFlags.TAGSLIBRARY_PARSE_OGG_PLAYTIME, TTagType.ttAutomatic);
            break;
          }
        case TAudioFileFormat.affOpus:
          {
            TagsLib.TagsLibrary_SetConfig(Tags, (IntPtr)1, TConfigFlags.TAGSLIBRARY_DEEP_OPUS_BITRATE_SCAN, TTagType.ttAutomatic);
            TagsLib.TagsLibrary_SetConfig(Tags, (IntPtr)1, TConfigFlags.TAGSLIBRARY_PARSE_OGG_PLAYTIME, TTagType.ttAutomatic);
            break;
          }
        case TAudioFileFormat.affMusePack:
          {
            TagsLib.TagsLibrary_SetConfig(Tags, (IntPtr)1, TConfigFlags.TAGSLIBRARY_PARSE_MUSEPACK_AUDIO_ATTRIBUTES, TTagType.ttAutomatic);
            break;
          }
        case TAudioFileFormat.affWavPack:
          {
            TagsLib.TagsLibrary_SetConfig(Tags, (IntPtr)1, TConfigFlags.TAGSLIBRARY_PARSE_WAVPACK_AUDIO_ATTRIBUTES, TTagType.ttAutomatic);
            break;
          }
      }
    }

    private void LoadTag()
    {
      CleanUp();

      if (!TagsLib.TagsLibrary_Loaded(Tags, TTagType.ttAutomatic))
      {
        Tags = TagsLib.TagsLibrary_Create();
      }

      if (txtFilename.Text != "")
      {
        TagsError = TagsLib.TagsLibrary_Load(Tags, txtFilename.Text, TTagType.ttAutomatic, true);
        if (TagsError == TTagError.TAGSLIBRARY_SUCCESS)
        {
          txtArtist.Text = TagsLib.TagsLibrary_GetTag(Tags, "ARTIST", TTagType.ttAutomatic);
          txtTitle.Text = TagsLib.TagsLibrary_GetTag(Tags, "TITLE", TTagType.ttAutomatic);
          txtAlbum.Text = TagsLib.TagsLibrary_GetTag(Tags, "ALBUM", TTagType.ttAutomatic);
        }
      }

      string[] arr = new string[2];
      ListViewItem itm;
      ListView1.View = View.Details;

      switch (AudioFileFormat)
      {
        case TAudioFileFormat.affMPEG:
          {
            TMPEGAudioAttributes MPGAudioAttributes = new TMPEGAudioAttributes();

            lblAttrib.Text = "Mpeg AudioAttributes";
            TagsLib.TagsLibrary_GetAudioAttributes(Tags, TAudioType.atMPEG, ref MPGAudioAttributes);

            arr[0] = "Position";
            arr[1] = MPGAudioAttributes.Position.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "FrameSize";
            arr[1] = MPGAudioAttributes.FrameSize.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Version";
            arr[1] = MPGAudioAttributes.Version.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Layer";
            arr[1] = MPGAudioAttributes.Layer.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "CRC";
            arr[1] = MPGAudioAttributes.CRC.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Bitrate";
            arr[1] = MPGAudioAttributes.BitRate.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "SampleRate";
            arr[1] = MPGAudioAttributes.SampleRate.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Padding";
            arr[1] = MPGAudioAttributes.Padding.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "_Private";
            arr[1] = MPGAudioAttributes._Private.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "ChannelMode";
            arr[1] = MPGAudioAttributes.ChannelMode.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "ModeExtension";
            arr[1] = MPGAudioAttributes.ModeExtension.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Copyrighted";
            arr[1] = MPGAudioAttributes.Copyrighted.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Original";
            arr[1] = MPGAudioAttributes.Original.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Emphasis";
            arr[1] = MPGAudioAttributes.Emphasis.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "VBR";
            arr[1] = MPGAudioAttributes.VBR.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "FrameCount";
            arr[1] = MPGAudioAttributes.FrameCount.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Quality";
            arr[1] = MPGAudioAttributes.Quality.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Bytes";
            arr[1] = MPGAudioAttributes.Bytes.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);
            break;
          }
        case TAudioFileFormat.affFlac:
          {
            TFlacAudioAttributes FlacAudioAttributes = new TFlacAudioAttributes();

            lblAttrib.Text = "Flac AudioAttributes";
            TagsLib.TagsLibrary_GetAudioAttributes(Tags, TAudioType.atFlac, ref FlacAudioAttributes);

            arr[0] = "Channels";
            arr[1] = FlacAudioAttributes.Channels.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "SampleRate";
            arr[1] = FlacAudioAttributes.SampleRate.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "BitsPerSample";
            arr[1] = FlacAudioAttributes.BitsPerSample.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "SampleCount";
            arr[1] = FlacAudioAttributes.SampleCount.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "PlayTime";
            arr[1] = FlacAudioAttributes.Playtime.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Ratio";
            arr[1] = FlacAudioAttributes.Ratio.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "ChannelMode";
            arr[1] = Marshal.PtrToStringAuto(FlacAudioAttributes.ChannelModeSPtr);
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Bitrate";
            arr[1] = FlacAudioAttributes.Bitrate.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);
            break;
          }

        case TAudioFileFormat.affMP4:
          {
            TMP4AudioAttributes MP4AudioAttributes = new TMP4AudioAttributes();

            lblAttrib.Text = "Mp4 AudioAttributes";
            TagsLib.TagsLibrary_GetAudioAttributes(Tags, TAudioType.atMP4, ref MP4AudioAttributes);

            arr[0] = "Channels";
            arr[1] = MP4AudioAttributes.Channels.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "SampleRate";
            arr[1] = MP4AudioAttributes.SampleRate.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "BitsPerSample";
            arr[1] = MP4AudioAttributes.BitsPerSample.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "PlayTime";
            arr[1] = MP4AudioAttributes.Playtime.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Bitrate";
            arr[1] = MP4AudioAttributes.Bitrate.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            break;
          }

        case TAudioFileFormat.affOpus:
          {
            TOpusAudioAttributes OpusAudioAttributes = new TOpusAudioAttributes();

            lblAttrib.Text = "Opus AudioAttributes";
            TagsLib.TagsLibrary_GetAudioAttributes(Tags, TAudioType.atOpus, ref OpusAudioAttributes);

            arr[0] = "BitstreamVersion";
            arr[1] = OpusAudioAttributes.BitstreamVersion.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "ChannelCount";
            arr[1] = OpusAudioAttributes.ChannelCount.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "PreSkip";
            arr[1] = OpusAudioAttributes.PreSkip.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "SampleRate";
            arr[1] = OpusAudioAttributes.SampleRate.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "OutputGain";
            arr[1] = OpusAudioAttributes.OutputGain.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "MappingFamily";
            arr[1] = OpusAudioAttributes.MappingFamily.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "PlayTime";
            arr[1] = OpusAudioAttributes.PlayTime.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "SampleCount";
            arr[1] = OpusAudioAttributes.SampleCount.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Bitrate";
            arr[1] = OpusAudioAttributes.BitRate.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);
            break;
          }
        case TAudioFileFormat.affMusePack:
          {
            TMusePackAttributes MusePackAttributes = new TMusePackAttributes();

            lblAttrib.Text = "MusePack AudioAttributes";
            TagsLib.TagsLibrary_GetAudioAttributes(Tags, TAudioType.atMusePack, ref MusePackAttributes);

            arr[0] = "ChannelModeID";
            arr[1] = MusePackAttributes.ChannelModeID.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "ChannelMode";
            arr[1] = Marshal.PtrToStringAuto(MusePackAttributes.ChannelModeSPtr);
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "FrameCount";
            arr[1] = MusePackAttributes.FrameCount.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "BitRate";
            arr[1] = MusePackAttributes.BitRate.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "StreamVersion";
            arr[1] = MusePackAttributes.StreamVersion.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "StreamStreamVersionString";
            arr[1] = Marshal.PtrToStringAuto(MusePackAttributes.StreamStreamVersionStringSPtr);
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "SampleRate";
            arr[1] = MusePackAttributes.SampleRate.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "ProfileID";
            arr[1] = MusePackAttributes.ProfileID.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Profile";
            arr[1] = Marshal.PtrToStringAuto(MusePackAttributes.ProfileSPtr);
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "PlayTime";
            arr[1] = MusePackAttributes.PlayTime.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Encoder";
            arr[1] = Marshal.PtrToStringAuto(MusePackAttributes.EncoderSPtr);
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Ratio";
            arr[1] = MusePackAttributes.Ratio.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);
            break;
          }
        case TAudioFileFormat.affWavPack:
          {
            TWAVPackAttributes WavePackAttributes = new TWAVPackAttributes();

            lblAttrib.Text = "WavePack AudioAttributes";
            TagsLib.TagsLibrary_GetAudioAttributes(Tags, TAudioType.atWAVPack, ref WavePackAttributes);

            arr[0] = "FormatTag";
            arr[1] = WavePackAttributes.FormatTag.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Version";
            arr[1] = WavePackAttributes.Version.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Channels";
            arr[1] = WavePackAttributes.Channels.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "ChannelMode";
            arr[1] = Marshal.PtrToStringAuto(WavePackAttributes.ChannelModeSPtr);
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "SampleRate";
            arr[1] = WavePackAttributes.SampleRate.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Bits";
            arr[1] = WavePackAttributes.Bits.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Bitrate";
            arr[1] = WavePackAttributes.Bitrate.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "PlayTime";
            arr[1] = WavePackAttributes.PlayTime.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Samples";
            arr[1] = WavePackAttributes.Samples.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "BSamples";
            arr[1] = WavePackAttributes.BSamples.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Ratio";
            arr[1] = WavePackAttributes.Ratio.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Encoder";
            arr[1] = Marshal.PtrToStringAuto(WavePackAttributes.EncoderSPtr);
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);
            break;
          }
        case TAudioFileFormat.affWAV:
          {
            TWAVEAudioAttributes WaveAudioAttributes = new TWAVEAudioAttributes();

            lblAttrib.Text = "Wave AudioAttributes";
            TagsLib.TagsLibrary_GetAudioAttributes(Tags, TAudioType.atWAV, ref WaveAudioAttributes);

            arr[0] = "FormatTag";
            arr[1] = WaveAudioAttributes.FormatTag.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Channels";
            arr[1] = WaveAudioAttributes.Channels.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "SamplesPerSec";
            arr[1] = WaveAudioAttributes.SamplesPerSec.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "AvgBytesPerSec";
            arr[1] = WaveAudioAttributes.AvgBytesPerSec.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "BlockAlign";
            arr[1] = WaveAudioAttributes.BlockAlign.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "BitsPerSample";
            arr[1] = WaveAudioAttributes.BitsPerSample.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "PlayTime";
            arr[1] = WaveAudioAttributes.PlayTime.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "SampleCount";
            arr[1] = WaveAudioAttributes.SampleCount.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "cbSize";
            arr[1] = WaveAudioAttributes.cbSize.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "ValidBitsPerSample";
            arr[1] = WaveAudioAttributes.ValidBitsPerSample.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "ChannelMask";
            arr[1] = WaveAudioAttributes.ChannelMask.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "SubFormat";
            arr[1] = WaveAudioAttributes.SubFormat.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "BitRate";
            arr[1] = WaveAudioAttributes.BitRate.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);
            break;
          }
        case TAudioFileFormat.affDSF:
          {
            TDSFAudioAttributes DSFAudioAttributes = new TDSFAudioAttributes();

            lblAttrib.Text = "DSF AudioAttributes";
            TagsLib.TagsLibrary_GetAudioAttributes(Tags, TAudioType.atDSDDSF, ref DSFAudioAttributes);

            arr[0] = "FormatVersion";
            arr[1] = DSFAudioAttributes.FormatVersion.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "FormatID";
            arr[1] = DSFAudioAttributes.FormatID.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "ChannelType";
            arr[1] = DSFAudioAttributes.ChannelType.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "ChannelNumber";
            arr[1] = DSFAudioAttributes.ChannelNumber.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "SamplingFrequency";
            arr[1] = DSFAudioAttributes.SamplingFrequency.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "BitsPerSample";
            arr[1] = DSFAudioAttributes.BitsPerSample.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "BlockSizePerChannel";
            arr[1] = DSFAudioAttributes.BlockSizePerChannel.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "PlayTime";
            arr[1] = DSFAudioAttributes.PlayTime.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "SampleCount";
            arr[1] = DSFAudioAttributes.SampleCount.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);

            arr[0] = "Bitrate";
            arr[1] = DSFAudioAttributes.Bitrate.ToString();
            itm = new ListViewItem(arr);
            ListView1.Items.Add(itm);
            break;
          }

      }

      TAudioAttributes AudioAttributes = new TAudioAttributes();

      TagsError = TagsLib.TagsLibrary_GetAudioAttributes(Tags, TAudioType.atAutomatic, ref AudioAttributes);
      if (TagsError == TTagError.TAGSLIBRARY_SUCCESS)
      {
        txtChannels.Text = AudioAttributes.Channels.ToString();
        txtSamplesPerSec.Text = AudioAttributes.SamplesPerSec.ToString();
        txtBitsPerSample.Text = AudioAttributes.BitsPerSample.ToString();
        txtPlayTime.Text = Utils.GetTimeString(AudioAttributes.PlayTime);
        txtSampleCount.Text = AudioAttributes.SampleCount.ToString();
        txtBitRate.Text = AudioAttributes.Bitrate.ToString();
      }

      TTagData TagData = new TTagData();
      TExtTag ExtTag = new TExtTag();

      int Count = TagsLib.TagsLibrary_TagCount(Tags, TTagType.ttAutomatic) - 1;

      ListView2.View = View.Details;

      for (int IntI = 0; IntI <= (Count); IntI++)
      {
        if (TagsLib.TagsLibrary_GetTagByIndexEx(Tags, IntI, TTagType.ttAutomatic, ExtTag))
        {
          ListView2.Items.Add(ExtTag.Name);
          ListView2.Items[IntI].SubItems.Add(ExtTag.Value);
        }
      }

      for (int IntI = 0; IntI <= (Count); IntI++)
      {
        if (TagsLib.TagsLibrary_GetTagData(Tags, IntI, TTagType.ttAutomatic, ref TagData))
        {
          Console.WriteLine(Marshal.PtrToStringAuto(TagData.NameSPtr));
          Console.WriteLine(TagData.Data.ToString());
          Console.WriteLine(TagData.DataSize.ToString());
          Console.WriteLine(TagData.DataType.ToString());
        }
      }

      TCoverArtData CoverArt = new TCoverArtData();

      int CoverArtCount = TagsLib.TagsLibrary_CoverArtCount(Tags, TTagType.ttAutomatic);

      for (int IntI = 0; IntI < (CoverArtCount); IntI++)
      {
        if (TagsLib.TagsLibrary_GetCoverArt(Tags, TTagType.ttAutomatic, IntI, ref CoverArt))
        {
          Console.WriteLine(Marshal.PtrToStringAuto(CoverArt.NameSPtr));
          Console.WriteLine(CoverArt.Data.ToString());
          Console.WriteLine(CoverArt.DataSize.ToString());
          Console.WriteLine(Marshal.PtrToStringAuto(CoverArt.DescriptionSPtr));
          Console.WriteLine(CoverArt.CoverType.ToString());
          Console.WriteLine(Marshal.PtrToStringAuto(CoverArt.MIMETypeSPtr).ToString());
          Console.WriteLine(CoverArt.PictureFormat.ToString());
          Console.WriteLine(CoverArt.Width.ToString());
          Console.WriteLine(CoverArt.Height.ToString());
          Console.WriteLine(CoverArt.ColorDepth.ToString());
          Console.WriteLine(CoverArt.NoOfColors.ToString());
          Console.WriteLine(CoverArt.ID3v2TextEncoding.ToString());
          Console.WriteLine(CoverArt.Index.ToString());

          // GetCoverArtFromMemoryPtr over GetImageFromMemPtr
          if (CoverArt.Data != IntPtr.Zero)
          {
            Image image;
            string MyImageKey = Guid.NewGuid().ToString();

            image = PicFromMem.GetImageFromMemPtr(CoverArt.Data, CoverArt.DataSize);
            ImageListThumbs.Images.Add(MyImageKey, image);

            ListViewItem lvi = new ListViewItem(Marshal.PtrToStringAuto(CoverArt.NameSPtr));

            lvi.ImageKey = MyImageKey;
            lvThumb.Items.Add(lvi);
            switch (CoverArt.CoverType)
            {
              case TCoverTypes.ctCoverFront:
                rbCoverfront.Checked = true;
                lvi.Text = "Front Cover";
                break;
              case TCoverTypes.ctCoverback:
                rbCoverback.Checked = true;
                lvi.Text = "Back Cover";
                break;
              case TCoverTypes.ctLabel:
                rbLabel.Checked = true;
                lvi.Text = "Label";
                break;
              case TCoverTypes.ctArtist:
                rbArtist.Checked = true;
                lvi.Text = "Artist";
                break;
              case TCoverTypes.ctConductor:
                rbConductor.Checked = true;
                lvi.Text = "Conductor";
                break;
              case TCoverTypes.ctBand:
                lvi.Text = "Band";
                rbBand.Checked = true;
                break;
              case TCoverTypes.ctPerformance:
                lvi.Text = "Performance";
                rbPerformance.Checked = true;
                break;
              case TCoverTypes.ctComposer:
                lvi.Text = "Composer";
                rbComposer.Checked = true;
                break;
              case TCoverTypes.ctBandLogo:
                lvi.Text = "Band Logo";
                rbBandLogo.Checked = true;
                break;
              case TCoverTypes.ctOther:
                lvi.Text = "Other";
                rbOther.Checked = true;
                break;
            }
          }
        }
      }
    }

    private void Form1_FormClosing(object sender, FormClosingEventArgs e)
    {
      if (Tags.HTags != IntPtr.Zero)
      {
        if (!TagsLib.TagsLibrary_Free(Tags))
        {
          MessageBox.Show("Error TagsLibrary_Free is not free", "TagsLibrary_Free!", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }
      }
    }

    private void btnOpen_Click(object sender, EventArgs e)
    {
      OpenFileDialog1.FileName = "";
      OpenFileDialog1.Title = "Select a File...";
      OpenFileDialog1.Filter = "MPG files (*.mp3*,*.mp1*,*.mp2*,*.mpa*)|*.mp3*;*.mp1*;*.mp2*;*.mpa*|" +
                                  "FLAC files (*.flac*,*.ogg flac*)|*.flac*;*.ogg*|" +
                                  "MP4 files (*.m4a*)|*.m4a*|" +
                                  "OPUS files (*.opus*,*.ogg vorbis*)|*.opus*;*.ogg*|" +
                                  "MusePack (*.mpc*)|*.mpc*|" +
                                  "WavePack (*.wv*)|*.wv*|" +
                                  "Wave (*.wav*)|*.wav*|" +
                                  "DSD/DSF (*.dsd,*.dsf*)|*.dsd*;*.dsf*";

      OpenFileDialog1.ShowDialog();

      txtFilename.Text = OpenFileDialog1.FileName;
      if (txtFilename.Text != "")
        LoadTag();

    }

    private void btnAttribute_MouseDown(object sender, MouseEventArgs e)
    {
      if (Tags.HTags != IntPtr.Zero)
      {
        txtChannels.Text = TagsLib.TagsLibrary_GetAudioAttribute(Tags, TAudioAttribute.aaChannels).ToString();
        txtSamplesPerSec.Text = TagsLib.TagsLibrary_GetAudioAttribute(Tags, TAudioAttribute.aaSamplesPerSec).ToString();
        txtBitsPerSample.Text = TagsLib.TagsLibrary_GetAudioAttribute(Tags, TAudioAttribute.aaBitsPerSample).ToString();
        txtPlayTime.Text = Utils.GetTimeString(TagsLib.TagsLibrary_GetAudioAttribute(Tags, TAudioAttribute.aaPlayTime));
        txtSampleCount.Text = TagsLib.TagsLibrary_GetAudioAttribute(Tags, TAudioAttribute.aaSampleCount).ToString();
        txtBitRate.Text = TagsLib.TagsLibrary_GetAudioAttribute(Tags, TAudioAttribute.aaBitRate).ToString();
      }
    }

    private void btnSave_MouseDown(object sender, MouseEventArgs e)
    {
      if (Tags.HTags != IntPtr.Zero)
      {
        // Set specific tags
        TagsLib.TagsLibrary_SetTag(Tags, ("ARTIST"), (txtArtist.Text), TTagType.ttAutomatic);
        TagsLib.TagsLibrary_SetTag(Tags, ("TITLE"), (txtTitle.Text), TTagType.ttAutomatic);
        TagsLib.TagsLibrary_SetTag(Tags, ("ALBUM"), (txtAlbum.Text), TTagType.ttAutomatic);

        TagsError = TagsLib.TagsLibrary_Save(Tags, (txtFilename.Text), TTagType.ttAutomatic);
        if (TagsError != TTagError.TAGSLIBRARY_SUCCESS)
        {
          MessageBox.Show("Error while saving tag.", "Warning!", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }
        else
        {
          // Reload
          LoadTag();
        }
      }
    }

    private void btnExport_MouseDown(object sender, MouseEventArgs e)
    {
      if (Tags.HTags != IntPtr.Zero)
      {
        TCoverArtData CoverArt = new TCoverArtData();
        string Fext = ".unknown";

        if (lvThumb.SelectedItems.Count != 1)
        {
          MessageBox.Show("Please select one cover art.", "Information!", MessageBoxButtons.OK, MessageBoxIcon.Information);

        }
        else
        {
          if (TagsLib.TagsLibrary_GetCoverArt(Tags, TTagType.ttAutomatic, lvThumb.SelectedItems[0].Index, ref CoverArt))
          {

            switch (CoverArt.PictureFormat)
            {
              case TTagPictureFormat.tpfJPEG:
                Fext = ".jpg";
                break;
              case TTagPictureFormat.tpfPNG:
                Fext = ".png";
                break;
              case TTagPictureFormat.tpfGIF:
                Fext = ".gif";
                break;
              case TTagPictureFormat.tpfBMP:
                Fext = ".bmp";
                break;
            }
          }

          if (Marshal.PtrToStringAuto(CoverArt.DescriptionSPtr) != "")
          {
            string newExt = Path.ChangeExtension(Marshal.PtrToStringAuto(CoverArt.DescriptionSPtr), Fext);
            saveFileDialog1.FileName = newExt;
          }
          else
          {
            saveFileDialog1.FileName = Fext;
          }

          if (saveFileDialog1.ShowDialog() == DialogResult.OK)
          {
            System.IO.FileStream CoverArtFileStream = (System.IO.FileStream)saveFileDialog1.OpenFile();
            byte[] bArray = new byte[CoverArt.DataSize];

            Marshal.Copy(CoverArt.Data, bArray, 0, (int)CoverArt.DataSize);
            CoverArtFileStream.Write(bArray, 0, (int)CoverArt.DataSize);

            CoverArtFileStream.Close();
          }
        }
      }
    }

    private void btnDelete_MouseDown(object sender, MouseEventArgs e)
    {
      if (Tags.HTags != IntPtr.Zero)
      {
        if (lvThumb.SelectedItems.Count != 1)
        {
          MessageBox.Show("Please select one cover art.", "Information!", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
        else
        {
          if (TagsLib.TagsLibrary_DeleteCoverArt(Tags, TTagType.ttAutomatic, lvThumb.SelectedItems[0].Index))
          {
            btnSave_MouseDown(sender, e);
          }
        }
      }
    }

    private unsafe void AddCover(object sender, MouseEventArgs e)
    {
      if (Tags.HTags != IntPtr.Zero)
      {
        //* Clear the cover art data
        string MIMEType = "";
        string Description = "";
        int Width = 0;
        int Height = 0;
        int ColorDepth = 0;
        int NoOfColors = 0;
        IntPtr pval = IntPtr.Zero;

        TCoverArtData CoverArtData = new TCoverArtData();
        TTagPictureFormat CoverArtPictureFormat = TTagPictureFormat.tpfUnknown;

        OpenFileDialog1.FileName = "";
        OpenFileDialog1.Title = "Select a File...";
        OpenFileDialog1.Filter = "Picture files (*.jpg*,*.jpeg*,*.bmp*,*.png*,*.gif*)|*.jpg*;*.jpeg*;*.bmp*;*.png*;*.gif*";

        if (OpenFileDialog1.ShowDialog() == DialogResult.OK)
        {
          if (File.Exists(OpenFileDialog1.FileName))
          {
            var BitmapStream = new MemoryStream();

            using (var fs = System.IO.File.Open(OpenFileDialog1.FileName, System.IO.FileMode.Open))
            {
              fs.CopyTo(BitmapStream);
              BitmapStream.Position = 0;

              Image img = Image.FromStream(BitmapStream);
              fs.Close();

              if (img.RawFormat.Equals(System.Drawing.Imaging.ImageFormat.Jpeg))
              {
                MIMEType = "image/jpeg";
                CoverArtPictureFormat = TTagPictureFormat.tpfJPEG;
                Description = Path.GetFileName(OpenFileDialog1.FileName);
                Width = img.Width;
                Height = img.Height;
                NoOfColors = 0;
                ColorDepth = 24;
              }
              else if (img.RawFormat.Equals(System.Drawing.Imaging.ImageFormat.Png))
              {
                Width = img.Width;
                Height = img.Height;
                NoOfColors = 0;
                ColorDepth = Image.GetPixelFormatSize(img.PixelFormat);
              }
              else if (img.RawFormat.Equals(System.Drawing.Imaging.ImageFormat.Gif))
              {
                Width = img.Width;
                Height = img.Height;
                NoOfColors = 0;
                ColorDepth = Image.GetPixelFormatSize(img.PixelFormat);
              }
              else if (img.RawFormat.Equals(System.Drawing.Imaging.ImageFormat.Bmp))
              {
                Width = img.Width;
                Height = img.Height;
                NoOfColors = 0;
                ColorDepth = Image.GetPixelFormatSize(img.PixelFormat);
              }

              byte[] openFile = File.ReadAllBytes(OpenFileDialog1.FileName);
              fixed (byte* p = openFile)
              {
                IntPtr image = (IntPtr)p;

                CoverArtData.NameSPtr = Marshal.StringToHGlobalAuto(Description);
                CoverArtData.CoverType = CoverTypes;
                CoverArtData.MIMETypeSPtr = Marshal.StringToHGlobalAuto(MIMEType);
                CoverArtData.DescriptionSPtr = Marshal.StringToHGlobalAuto(Description);
                CoverArtData.Width = Width;
                CoverArtData.Height = Height;
                CoverArtData.ColorDepth = ColorDepth;
                CoverArtData.NoOfColors = NoOfColors;
                CoverArtData.PictureFormat = CoverArtPictureFormat;
                CoverArtData.Data = image;
                CoverArtData.DataSize = BitmapStream.Length;

                if (TagsLib.TagsLibrary_AddCoverArt(Tags, TTagType.ttAutomatic, CoverArtData) == -1)
                {
                  MessageBox.Show("Error while adding cover art: ", OpenFileDialog1.FileName, MessageBoxButtons.AbortRetryIgnore, MessageBoxIcon.Error);
                }
                image = IntPtr.Zero;

                BitmapStream.Close();
                btnSave_MouseDown(sender, e);
              }
            }
          }
        }
      }
    }

    private void btnRemove_MouseDown(object sender, MouseEventArgs e)
    {
      if (Tags.HTags != IntPtr.Zero)
      {
        TagsError = TagsLib.TagsLibrary_RemoveTag(txtFilename.Text, TTagType.ttID3v2);
        if (TagsError != TTagError.TAGSLIBRARY_SUCCESS)
        {
          MessageBox.Show("Error while removing tags from file.", "", MessageBoxButtons.OK, MessageBoxIcon.Warning);
        }
        LoadTag();
      }
    }

    private void rbCoverfront_MouseDown(object sender, MouseEventArgs e)
    {
      if (Tags.HTags != IntPtr.Zero)
      {
        if (rbCoverfront.Checked)
          return;

        CoverTypes = TCoverTypes.ctCoverFront;
        AddCover(sender, e);
        rbCoverfront.Checked = true;
      }
    }

    private void rbCoverback_MouseDown(object sender, MouseEventArgs e)
    {
      // MusePack and WavePack and MP4 used only Cover (front) 
      if ((AudioFileFormat == TAudioFileFormat.affWavPack) | (AudioFileFormat == TAudioFileFormat.affMusePack))
      {
        MessageBox.Show("CoverType is not supported by APEv2 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        return;
      }
      else if (AudioFileFormat == TAudioFileFormat.affMP4)
      {
        MessageBox.Show("CoverType is not supported by MP4 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        return;
      }

      if (Tags.HTags != IntPtr.Zero)
      {
        if (rbCoverback.Checked)
          return;

        CoverTypes = TCoverTypes.ctCoverback;
        AddCover(sender, e);
        rbCoverback.Checked = true;
      }
    }

    private void rbArtist_MouseDown(object sender, MouseEventArgs e)
    {
      // MusePack and WavePack and MP4 used only Cover (front) 
      if ((AudioFileFormat == TAudioFileFormat.affWavPack) | (AudioFileFormat == TAudioFileFormat.affMusePack))
      {
        MessageBox.Show("CoverType is not supported by APEv2 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        return;
      }
      else if (AudioFileFormat == TAudioFileFormat.affMP4)
      {
        MessageBox.Show("CoverType is not supported by MP4 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        return;
      }

      if (Tags.HTags != IntPtr.Zero)
      {
        if (rbArtist.Checked)
          return;

        CoverTypes = TCoverTypes.ctArtist;
        AddCover(sender, e);
        rbArtist.Checked = true;
      }
    }

    private void rbLabel_MouseDown(object sender, MouseEventArgs e)
    {
      // MusePack and WavePack and MP4 used only Cover (front) 
      if ((AudioFileFormat == TAudioFileFormat.affWavPack) | (AudioFileFormat == TAudioFileFormat.affMusePack))
      {
        MessageBox.Show("CoverType is not supported by APEv2 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        return;
      }
      else if (AudioFileFormat == TAudioFileFormat.affMP4)
      {
        MessageBox.Show("CoverType is not supported by MP4 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        return;
      }

      if (Tags.HTags != IntPtr.Zero)
      {
        if (rbLabel.Checked)
          return;

        CoverTypes = TCoverTypes.ctLabel;
        AddCover(sender, e);
        rbLabel.Checked = true;
      }
    }

    private void rbConductor_MouseDown(object sender, MouseEventArgs e)
    {
      // MusePack and WavePack and MP4 used only Cover (front) 
      if ((AudioFileFormat == TAudioFileFormat.affWavPack) | (AudioFileFormat == TAudioFileFormat.affMusePack))
      {
        MessageBox.Show("CoverType is not supported by APEv2 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        return;
      }
      else if (AudioFileFormat == TAudioFileFormat.affMP4)
      {
        MessageBox.Show("CoverType is not supported by MP4 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        return;
      }

      if (Tags.HTags != IntPtr.Zero)
      {
        if (rbConductor.Checked)
          return;

        CoverTypes = TCoverTypes.ctConductor;
        AddCover(sender, e);
        rbConductor.Checked = true;
      }
    }

    private void rbBand_MouseDown(object sender, MouseEventArgs e)
    {
      // MusePack and WavePack and MP4 used only Cover (front) 
      if ((AudioFileFormat == TAudioFileFormat.affWavPack) | (AudioFileFormat == TAudioFileFormat.affMusePack))
      {
        MessageBox.Show("CoverType is not supported by APEv2 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        return;
      }
      else if (AudioFileFormat == TAudioFileFormat.affMP4)
      {
        MessageBox.Show("CoverType is not supported by MP4 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        return;
      }

      if (Tags.HTags != IntPtr.Zero)
      {
        if (rbBand.Checked)
          return;

        CoverTypes = TCoverTypes.ctBand;
        AddCover(sender, e);
        rbBand.Checked = true;
      }
    }

    private void rbPerformance_MouseDown(object sender, MouseEventArgs e)
    {
      // MusePack and WavePack and MP4 used only Cover (front) 
      if ((AudioFileFormat == TAudioFileFormat.affWavPack) | (AudioFileFormat == TAudioFileFormat.affMusePack))
      {
        MessageBox.Show("CoverType is not supported by APEv2 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        return;
      }
      else if (AudioFileFormat == TAudioFileFormat.affMP4)
      {
        MessageBox.Show("CoverType is not supported by MP4 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        return;
      }

      if (Tags.HTags != IntPtr.Zero)
      {
        if (rbPerformance.Checked)
          return;

        CoverTypes = TCoverTypes.ctPerformance;
        AddCover(sender, e);
        rbPerformance.Checked = true;
      }
    }

    private void rbComposer_MouseDown(object sender, MouseEventArgs e)
    {
      // MusePack and WavePack and MP4 used only Cover (front) 
      if ((AudioFileFormat == TAudioFileFormat.affWavPack) | (AudioFileFormat == TAudioFileFormat.affMusePack))
      {
        MessageBox.Show("CoverType is not supported by APEv2 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        return;
      }
      else if (AudioFileFormat == TAudioFileFormat.affMP4)
      {
        MessageBox.Show("CoverType is not supported by MP4 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        return;
      }

      if (Tags.HTags != IntPtr.Zero)
      {
        if (rbComposer.Checked)
          return;

        CoverTypes = TCoverTypes.ctComposer;
        AddCover(sender, e);
        rbComposer.Checked = true;
      }
    }

    private void rbBandLogo_MouseDown(object sender, MouseEventArgs e)
    {
      // MusePack and WavePack and MP4 used only Cover (front) 
      if ((AudioFileFormat == TAudioFileFormat.affWavPack) | (AudioFileFormat == TAudioFileFormat.affMusePack))
      {
        MessageBox.Show("CoverType is not supported by APEv2 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        return;
      }
      else if (AudioFileFormat == TAudioFileFormat.affMP4)
      {
        MessageBox.Show("CoverType is not supported by MP4 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        return;
      }

      if (Tags.HTags != IntPtr.Zero)
      {
        if (rbBandLogo.Checked)
          return;

        CoverTypes = TCoverTypes.ctBandLogo;
        AddCover(sender, e);
        rbBandLogo.Checked = true;
      }
    }

    private void rbOther_MouseDown(object sender, MouseEventArgs e)
    {
      // MusePack and WavePack and MP4 used only Cover (front) 
      if ((AudioFileFormat == TAudioFileFormat.affWavPack) | (AudioFileFormat == TAudioFileFormat.affMusePack))
      {
        MessageBox.Show("CoverType is not supported by APEv2 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        return;
      }
      else if (AudioFileFormat == TAudioFileFormat.affMP4)
      {
        MessageBox.Show("CoverType is not supported by MP4 tags, only Cover (front)", "", MessageBoxButtons.OK, MessageBoxIcon.Information);
        return;
      }

      if (Tags.HTags != IntPtr.Zero)
      {
        if (rbOther.Checked)
          return;

        CoverTypes = TCoverTypes.ctOther;
        AddCover(sender, e);
        rbOther.Checked = true;
      }
    }
  }
}
