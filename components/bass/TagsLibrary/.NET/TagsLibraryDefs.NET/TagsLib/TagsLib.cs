namespace TagsLib_API
{
  using System;
  using System.Runtime.InteropServices;
  using System.Security;

  [Serializable, StructLayout(LayoutKind.Sequential)]
  public struct HTAGS
  {
    private IntPtr _htags;
    public IntPtr HTags
    {
      get { return _htags; }
      set { _htags = value; }
    }
  }

  [Serializable, StructLayout(LayoutKind.Sequential)]
  public struct TTagPriority
  {
    [MarshalAs(UnmanagedType.ByValArray, SizeConst = 8)]
    public TTagType[] Values;
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public sealed class TExtTag
  {
    private IntPtr NameSPtr;
    private IntPtr ValueSPtr;
    public int ValueSize;
    private IntPtr LanguageSPtr;
    private IntPtr DescriptionSPtr;
    public TExtTagType ExtTagType;
    public int Index;

    public string Name
    {
      get
      {
        if (NameSPtr == IntPtr.Zero)
          return null;
        else
          return Marshal.PtrToStringAuto(NameSPtr);
      }
    }

    public string Value
    {
      get
      {
        if (ValueSPtr == IntPtr.Zero)
          return null;
        else
          return Marshal.PtrToStringAuto(ValueSPtr);
      }
    }

    public string Language
    {
      get
      {
        if (LanguageSPtr == IntPtr.Zero)
          return null;
        else
          return Marshal.PtrToStringAuto(LanguageSPtr);
      }
    }

    public string Description
    {
      get
      {
        if (DescriptionSPtr == IntPtr.Zero)
          return null;
        else
          return Marshal.PtrToStringAuto(DescriptionSPtr);
      }
    }
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public sealed class TSimpleTag
  {
    private IntPtr NameSPtr;
    private IntPtr ValueSPtr;
    public int ValueSize;
    public int Index;

    public string Name
    {
      get
      {
        if (NameSPtr == IntPtr.Zero)
          return null;
        else
          return Marshal.PtrToStringAuto(NameSPtr);
      }
    }

    public string Value
    {
      get
      {
        if (ValueSPtr == IntPtr.Zero)
          return null;
        else
          return Marshal.PtrToStringAuto(ValueSPtr);
      }
    }
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public sealed class TID3v2TagEx
  {
    private IntPtr NameSPtr;
    private IntPtr ValueSPtr;
    public int ValueSize;
    private IntPtr LanguageSPtr;
    private IntPtr DescriptionSPtr;
    public TID3v2TagType TagType;
    public int Index;

    public string Name
    {
      get
      {
        if (NameSPtr == IntPtr.Zero)
          return null;
        else
          return Marshal.PtrToStringAuto(NameSPtr);
      }
    }

    public string Value
    {
      get
      {
        if (ValueSPtr == IntPtr.Zero)
          return null;
        else
          return Marshal.PtrToStringAuto(ValueSPtr);
      }
    }

    public string Language
    {
      get
      {
        if (LanguageSPtr == IntPtr.Zero)
          return null;
        else
          return Marshal.PtrToStringAuto(LanguageSPtr);
      }
    }

    public string Description
    {
      get
      {
        if (DescriptionSPtr == IntPtr.Zero)
          return null;
        else
          return Marshal.PtrToStringAuto(DescriptionSPtr);
      }
    }
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public sealed class TMP4TagEx
  {
    private IntPtr NameSPtr;
    private IntPtr ValueSPtr;
    public int ValueSize;
    private IntPtr NameValueSPtr;
    private IntPtr MeanValueSPtr;
    public TMP4TagType TagType;
    public int DataType;
    public int Index;

    public string Name
    {
      get
      {
        if (NameSPtr == IntPtr.Zero)
          return null;
        else
          return Marshal.PtrToStringAuto(NameSPtr);
      }
    }

    public string Value
    {
      get
      {
        if (ValueSPtr == IntPtr.Zero)
          return null;
        else
          return Marshal.PtrToStringAuto(ValueSPtr);
      }
    }

    public string NameValue
    {
      get
      {
        if (NameValueSPtr == IntPtr.Zero)
          return null;
        else
          return Marshal.PtrToStringAuto(NameValueSPtr);
      }
    }

    public string MeanValue
    {
      get
      {
        if (MeanValueSPtr == IntPtr.Zero)
          return null;
        else
          return Marshal.PtrToStringAuto(MeanValueSPtr);
      }
    }
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public struct TCoverArtData
  {
    public IntPtr NameSPtr;
    public IntPtr Data;
    public long DataSize;
    public IntPtr DescriptionSPtr;
    public TCoverTypes CoverType;
    public IntPtr MIMETypeSPtr;
    public TTagPictureFormat PictureFormat;
    public int Width;
    public int Height;
    public int ColorDepth;
    public int NoOfColors;
    public int ID3v2TextEncoding;
    public int Index;
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public struct TTagData
  {
    public IntPtr NameSPtr;
    public IntPtr Data;
    public long DataSize;
    public int DataType;
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public struct TCARTPostTimer
  {
    public IntPtr UsageSPtr;
    public int Value;
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public struct TMPEGAudioAttributes
  {
    public long Position;                     //* Position of header in bytes
    public int Header;                        //* The Headers bytes
    public int FrameSize;                     //* Frame's length
    public TMPEGVersion Version;              //* MPEG Version
    public TMPEGLayer Layer;                  //* MPEG Layer
    public bool CRC;                          //* Frame has CRC
    public int BitRate;                       //* Frame's bitrate
    public int SampleRate;                    //* Frame's sample rate
    public bool Padding;                      //* Frame is padded
    public bool _Private;                     //* Frame's private bit is set
    public TMPEGChannelMode ChannelMode;      //* Frame's channel mode
    public TMPEGModeExtension ModeExtension;  //* Joint stereo only
    public bool Copyrighted;                  //* Frame's Copyright bit is set
    public bool Original;                     //* Frame's Original bit is set
    public TMPEGEmphasis Emphasis;            //* Frame's emphasis mode
    public bool VBR;                          //* Stream is probably VBR
    public long FrameCount;                   //* Total number of MPEG frames (by header)
    public int Quality;                       //* MPEG quality
    public long Bytes;                        //* Total bytes
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public struct TFlacAudioAttributes
  {
    public int Channels;
    public int SampleRate;
    public int BitsPerSample;
    public long SampleCount;
    public double Playtime;                   //* Duration (seconds)
    public double Ratio;                      //* Compression ratio (%)    
    public IntPtr ChannelModeSPtr;
    public int Bitrate;
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public struct TDSFAudioAttributes
  {
    public int FormatVersion;
    public int FormatID;
    public TDSFChannelType ChannelType;
    public int ChannelNumber;
    public int SamplingFrequency;
    public int BitsPerSample;
    public int BlockSizePerChannel;
    public double PlayTime;
    public UInt64 SampleCount;
    public int Bitrate;
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public struct TOpusAudioAttributes
  {
    public int BitstreamVersion;              //* Bitstream version number
    public int ChannelCount;                  //* Number of channels
    public int PreSkip;
    public int SampleRate;                    //* Sample rate (hz)
    public int OutputGain;
    public int MappingFamily;                 //* 0,1,255 
    public double PlayTime;
    public UInt64 SampleCount;
    public int BitRate;
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public struct TVorbisAudioAttributes
  {
    [MarshalAs(UnmanagedType.ByValArray, SizeConst = 4)]
    public byte[] BitstreamVersion;           //* Bitstream version number
    public int ChannelMode;                   //* Number of channels 
    public int SampleRate;                    //* Sample rate (hz)
    public int BitRateMaximal;                //* Bit rate upper limit 
    public int BitRateNominal;                //* Nominal bit rate 
    public int BitRateMinimal;                //* Bit rate lower limit
    public int BlockSize;                     //* Coded size for small and long blocks 
    public double PlayTime;
    public UInt64 SampleCount;
    public int BitRate;
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public struct TWAVEAudioAttributes
  {
    public int FormatTag;                     //* format type
    public int Channels;                      //* number of channels (i.e. mono, stereo, etc.)
    public int SamplesPerSec;                 //* sample rate
    public int AvgBytesPerSec;                //* for buffer estimation
    public int BlockAlign;                    //* block size of data
    public int BitsPerSample;                 //+ number of bits per sample of mono data
    public double PlayTime;
    public UInt64 SampleCount;
    public int cbSize;	                      //* Size of the extension: 22
    public int ValidBitsPerSample;	          //* at most 8 *  M
    public int ChannelMask;	                  //* Speaker position mask: 0
    [MarshalAs(UnmanagedType.U1, SizeConst = 15)]
    public byte SubFormat;                    //* 16
    public int BitRate;
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public struct TAIFFAttributes
  {
    public int Channels;
    public int SampleCount;
    public int SampleSize;
    public double SampleRate;
    [MarshalAs(UnmanagedType.ByValArray, SizeConst = 3)]
    public byte[] CompressionID;              // http://en.wikipedia.org/wiki/Audio_Interchange_File_Format
    public IntPtr CompressionSPtr;
    public double PlayTime;
    public int BitRate;
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public struct TMP4AudioAttributes
  {
    public int Channels;
    public int SampleRate;
    public int BitsPerSample;
    public double Playtime;                   //* Duration (seconds)
    public int Bitrate;
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public struct TWMAAttributes
  {
    public double PlayTime;
    public int BitRate;
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public struct TAudioAttributes
  {
    public int Channels;
    public int SamplesPerSec;
    public int BitsPerSample;
    public double PlayTime;
    public UInt64 SampleCount;
    public int Bitrate;
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public struct TWAVPackAttributes
  {
    public int FormatTag;
    public int Version;
    public int Channels;
    public IntPtr ChannelModeSPtr;
    public int SampleRate;
    public int Bits;
    public double Bitrate;
    public double PlayTime;
    public long Samples;
    public long BSamples;
    public double Ratio;
    public IntPtr EncoderSPtr;
  }

  [Serializable, StructLayout(LayoutKind.Sequential, Pack = 1)]
  public struct TMusePackAttributes
  {
    public byte ChannelModeID;                //* Channel mode code 
    public IntPtr ChannelModeSPtr;            //* Channel mode name
    public int FrameCount;                    //* Number of frames 
    public ushort BitRate;                    //* Bit rate 
    public byte StreamVersion;                //* Stream version
    public IntPtr StreamStreamVersionStringSPtr;
    public int SampleRate;
    public byte ProfileID;                    //* Profile code 
    public IntPtr ProfileSPtr;                //* Profile name
    public double PlayTime;                   //* Duration (seconds) 
    public IntPtr EncoderSPtr;                //* Encoder used
    public double Ratio;                      //* Compression ratio (%) 
  }

  /// <summary>
  /// Imports from TagsLib.DLL
  /// </summary>
  [SuppressUnmanagedCodeSecurity]
  public sealed class TagsLib
  {
    const string TagsLibraryName = "TagsLib.dll";
    
    //* TagsLibrary_Create
    /// <summary>
    /// Create a tag library object.
    /// </summary>
    /// <returns>value is a handle to the object. </returns>        
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_Create", CharSet = CharSet.Auto)]
    public static extern HTAGS TagsLibrary_Create();

    //* TagsLibrary_Free    
    /// <summary>
    /// Free the object created with 'TagsLibrary_Create'
    /// </summary>
    /// <returns>value is a true means success.</returns>   
    /// <remarks> there's no clear function for the object, 
    /// always re-create the tags library object if you want to clear it.</remarks>      
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_Free", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_Free(HTAGS Tags);

    //* TagsLibrary_Load    
    /// <summary> Loads the tags from the specified 'FileName'. When 'TagType' is 'ttAutomatic' 
    /// all the supported tag types are loaded (in the order specified by 'TagsLibrary_SetTagLoadPriority'), 
    /// to load a particular tag type, specify 'TagType' to something other then 'ttAutomatic'.
    ///	To check if tags are found use the function 'TagsLibrary_Loaded'.
    ///	'ParseTags' should be always 'True', 
    ///	but if you want to load a particular tag type then this flag specifies wheather to parse the tags to be used by 'ttAutomatic'. 
    ///	In other words, set 'ParseTags' to 'False' if you will use for example 'ttID3v2' in all function calls (so then there's no need to parset the tags).
    ///</summary> 
    /// <returns>value is an error code of TTagError, 'TAGSLIBRARY_SUCCESS' means success. </returns>    
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_Load", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_Load(HTAGS Tags, [In, MarshalAs(UnmanagedType.LPWStr)] string FileName, TTagType TagType, bool ParseTags);

    //TagsLibrary_LoadFromMemory
    /// <summary>
	  ///Load the tags from a memory "file". This function allocates 'Size' bytes to load the tags. 
    ///So if the 'Size' variable is 100MB then this function will allocate another 100MBs.
    /// </summary>
    /// <param name="MemoryAddress">pointer to start of data.</param>
    /// <param name="Size">size of memory object.</param>
    /// <returns>value is an error code of TTagError, 'TAGSLIBRARY_SUCCESS' means success..</returns>
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_LoadFromMemory", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_LoadFromMemory(HTAGS Tags, IntPtr MemoryAddress, UInt64 Size, TTagType TagType, bool ParseTags);

    //TagsLibrary_LoadFromBASS
    /// <summary>
    /// Load the tags from a BASS channel handle. Usefull for URL (internet) streams. 
    /// But can be used for local (file) streams also.     
    /// </summary>
    /// <returns>value is an error code of TTagError, 'TAGSLIBRARY_SUCCESS' means success..</returns>    
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_LoadFromBASS", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_LoadFromBASS(HTAGS Tags, uint Channel);

    //* TagsLibrary_Save
    /// <summary>
    /// Save the tags to file specified by 'FileName'. Using 'TagType' 'ttAutomatic' will decide the format by the following:
    ///	- If the 'FileName' is the same as the one used for loading, the tags will be saved in all formats which were present in the source file.
    ///	- Try to detect the following formats: affAPE, affFlac, affOggFlac, affMPEG, affMP4, affOpus, affVorbis, affWAV, affRF64, 
    ///	affAIFF, affAIFC, affDFF, affDSF, affOptimFrog, affMusePack and use the usual tagging format for the detected specific format
		/// - If the 'FileName' is different, format will be decided by the file extension.
    ///	To save a particular tag type specify it with 'TagType' as eg. 'ttID3v2'.
    /// </summary>
    /// <returns>value is an error code of TTagError, 'TAGSLIBRARY_SUCCESS' means success..</returns>
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_Save", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_Save(HTAGS Tags, [In, MarshalAs(UnmanagedType.LPWStr)] string FileName, TTagType TagType);

    //TagsLibrary_SaveEx    
    /// <summary>
    /// Save the tags without conversion ('ParseTag' and tags set with 'ttAutomatic' option will not have effect). 
    /// Usefull if you want to work with a particular tag type.
    /// </summary>
    /// <returns>value is an error code of TTagError, 'TAGSLIBRARY_SUCCESS' means success..</returns>    
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_SaveEx", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_SaveEx(HTAGS Tags, [In, MarshalAs(UnmanagedType.LPWStr)] string FileName, TTagType TagType);

    //TagsLibrary_SaveToMemory
    /// <summary>
    /// Save the tags to a file in memory. 
    /// This function allocates 'Size' bytes to save the tags and if the new tag doesn't fit in the file, it will allocate 
    /// 'Size' bytes again. So if the 'Size' variable is 100MB then this function might allocate another 200MBs.
    /// </summary>
    /// <param name="MemoryAddress">pointer to start of data.</param>
    /// <param name="Size">size of memory object.</param>
    /// <param name="TagType">if 'tcAutomatic' then try to detect the following formats: 
    /// affAPE, affFlac, affOggFlac, affMPEG, affMP4, affOpus, affVorbis, affWAV, affRF64, affAIFF, affAIFC, affDFF, affDSF, 
    /// affOptimFrog, affMusePack and use the usual tagging format for the detected specific format</param>
    /// <param name="SavedAddress">pointer to the saved "file" object. Is nil (null) on error.</param>
    /// <param name="SavedSize">size of the new object. Is '0' on error.</param>
    /// <param name="SaveHandle">use this handle with 'TagsLibrary_FreeSaveHandle' to free the saved object.</param>
    /// <returns>value is an error code of TTagError, 'TAGSLIBRARY_SUCCESS' means success..</returns>
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_SaveToMemory", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_SaveToMemory(HTAGS Tags, IntPtr MemoryAddress, UInt64 Size, TTagType TagType,
      ref IntPtr SavedAddress, ref UInt64 SavedSize, ref IntPtr SaveHandle);

    //TagsLibrary_SaveToMemoryEx
    /// <summary>
    /// Save a specific tag type directly to a file in memory.
    /// </summary>
    /// <param name="MemoryAddress">pointer to start of data.</param>
    /// <param name="Size">size of memory object.</param>
    /// <param name="TagType">if 'tcAutomatic' then try to detect the following formats: 
    /// affAPE, affFlac, affOggFlac, affMPEG, affMP4, affOpus, affVorbis, affWAV, affRF64, affAIFF, affAIFC, affDFF, affDSF, 
    /// affOptimFrog, affMusePack and use the usual tagging format for the detected specific format</param>
    /// <param name="SavedAddress">pointer to the saved "file" object. Is nil (null) on error.</param>
    /// <param name="SavedSize">size of the new object. Is '0' on error.</param>
    /// <param name="SaveHandle">use this handle with 'TagsLibrary_FreeSaveHandle' to free the saved object.</param>
    /// <returns>value is an error code of TTagError, 'TAGSLIBRARY_SUCCESS' means success..</returns>
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_SaveToMemoryEx", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_SaveToMemoryEx(HTAGS Tags, IntPtr MemoryAddress, UInt64 Size, TTagType TagType,
      ref IntPtr SavedAddress, ref UInt64 SavedSize, ref IntPtr SaveHandle);

    //TagsLibrary_FreeSaveHandle
    /// <summary>
    /// 	Free the generated (tagged) saved object. 
    /// 	It is needed to free the save handle to free memory allocated for the in-memory saving.
    /// </summary>
    /// <returns>value is an error code of TTagError, 'TAGSLIBRARY_SUCCESS' means success..</returns>
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_FreeSaveHandle", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_FreeSaveHandle(ref IntPtr SaveHandle);

    //* TagsLibrary_RemoveTag
    /// <summary>
    /// Remove all tags from 'FileName', 
    /// to delete a particular tags type set it with 'TagType'.
    /// </summary>
    /// <returns>value is an error code of TTagError, 'TAGSLIBRARY_SUCCESS' means success..</returns>
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_RemoveTag", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_RemoveTag([In, MarshalAs(UnmanagedType.LPWStr)] string FileName, TTagType TagType);

    //TagsLibrary_RemoveTagFromMemory
    /// <summary>
    /// Remove all tags from memory "file", to delete a particular tags type set it with 'TagType'.
    /// </summary>
    /// <param name="MemoryAddress">pointer to start of data.</param>
    /// <param name="Size">size of memory object.</param>
    /// <param name="TagType">'tcAutomatic' is not supported, specify a tag format explicitly.</param>
    /// <param name="SavedAddress">pointer to the saved "file" object. Is nil (null) on error.</param>
    /// <param name="SavedSize">size of the new object. Is '0' on error.</param>
    /// <param name="SaveHandle">use this handle with 'TagsLibrary_FreeSaveHandle' to free the saved object.</param>
    /// <returns>value is an error code of TTagError, 'TAGSLIBRARY_SUCCESS' means success..</returns>    
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_RemoveTagFromMemory", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_RemoveTagFromMemory(IntPtr MemoryAddress, UInt64 Size, TTagType TagType, ref IntPtr SavedAddress, 
      ref UInt64 SavedSize, ref IntPtr SaveHandle);

    //* TagsLibrary_GetTag
    /// <summary>
    /// Get a pointer to a unicode (wide) string tag specified by 'Name' (for example 'TITLE').
    /// </summary>
    /// <returns>value is pointing to an empty string if no such tag found. </returns>    
    public static string TagsLibrary_GetTag(HTAGS Tags, string Name, TTagType TagType)
    {
      IntPtr ptr = TagsLibrary_GetTagPtr(Tags, Name, TagType);
      if (ptr != IntPtr.Zero)
      {
        return Marshal.PtrToStringAuto(ptr);
      }
      return null;
    }
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetTag", CharSet = CharSet.Auto)]
    private static extern IntPtr TagsLibrary_GetTagPtr(HTAGS Tags, [In, MarshalAs(UnmanagedType.LPWStr)] string Name, TTagType TagType);

    //* TagsLibrary_Loaded
    /// <summary>
    /// Test if tags are loaded. If 'TagType' is 'ttAutomatic' then the return value is 'False'
    /// </summary>
    /// <returns>value is 'False' if no tag exists in the file at all, 'True' otherwise</returns>   
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_Loaded", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_Loaded(HTAGS Tags, TTagType TagType);

    //TagsLibrary_GetTagEx
    /// <summary>
    /// Get extended (detailed) information about a tag. Usefull for 'ttID3v2' TXXX, WXXX, COMM frames and MP4 tags.
    /// </summary> 
    /// <returns>value is 'False' if no tag specified by 'Name' (eg. 'TITLE') is present in the tags.</returns>
    /// <remarks>TagType' values need a specific 'ExtTag' pointer to different structures:</remarks>
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetTagEx", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_GetTagEx(HTAGS Tags, [In, MarshalAs(UnmanagedType.LPWStr)] string Name, TTagType TagType,  TExtTag ExtTag);

    //* TagsLibrary_GetTagByIndexEx
    /// <summary>
    /// Get extended (detailed) information about a ExtTag.
    /// </summary> 
    /// <returns>value is 'False' if 'Index' is invalid..</returns>
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetTagByIndexEx", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_GetTagByIndexEx(HTAGS Tags, int Index, TTagType TagType, TExtTag ExtTag);
    /// <summary>
    /// Get extended (detailed) information about a SimpleTag.
    /// </summary> 
    /// <returns>value is 'False' if 'Index' is invalid..</returns>    
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetTagByIndexEx", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_GetTagByIndexEx(HTAGS Tags, int Index, TTagType TagType, TSimpleTag SimpleTag);
    /// <summary>
    /// Get extended (detailed) information about a ID3v2TagEx.
    /// </summary> 
    /// <returns>value is 'False' if 'Index' is invalid..</returns>   
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetTagByIndexEx", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_GetTagByIndexEx(HTAGS Tags, int Index, TTagType TagType, TID3v2TagEx ID3v2TagEx);
    /// <summary>
    /// Get extended (detailed) information about a MP4TagEx.
    /// </summary> 
    /// <returns>value is 'False' if 'Index' is invalid..</returns>   
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetTagByIndexEx", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_GetTagByIndexEx(HTAGS Tags, int Index, TTagType TagType, TMP4TagEx MP4TagEx);

    //TagsLibrary_SetTag
    /// <summary>
    /// Simply set a tag specified by 'Name' to value specified by 'Value'. 
    /// If there's already a field with the specified name it will be replaced with the new value.
    ///	When using with a particular tag type, eg. 'ttID3v2', 'Name' 
    ///	specifies an ID3v2 frame type, eg. 'TIT2' (which is title), or an MP4 tag atom name, for example '©ART' (artist).
    /// </summary>
    /// <returns>value is 'True' on success.</returns>
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_SetTag", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_SetTag(HTAGS Tags,   [In, MarshalAs(UnmanagedType.LPWStr)] string Name,  
      [In, MarshalAs(UnmanagedType.LPWStr)] string Value, TTagType TagType);

    //TagsLibrary_SetTagEx
    /// <summary>
    /// Set a tag with extended (detailed) attributes. 'ExtTag.Name' specifies the tag's name, an ID3v2 frame type, 
    /// eg. 'TIT2' (which is title), or an MP4 tag atom name, for example '©ART' (artist).
    //	ExtTag.ValueSize specifies ExtTag.Value length in bytes.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>    
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_SetTagEx", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_SetTagEx(HTAGS Tags, TTagType TagType, IntPtr ExtTag);

    //TagsLibrary_AddTag
    /// <summary>
    /// Add a tag specified by 'Name' to value specified by 'Value'. 
    /// If there's already a field with the specified name a new one will added, and the previous is preserved.
    ///	When using with a particular tag type, eg. 'ttID3v2', 'Name' specifies an ID3v2 frame type, 
    ///	eg. 'TIT2' (which is title), or an MP4 tag atom name, for example '©ART' (artist). 
    ///	But be carefull because eg. MP4 tags canot contain multiple atoms of the same type.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>
    [return: MarshalAs(UnmanagedType.SysInt)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_AddTag", CharSet = CharSet.Auto)]
    public static extern int TagsLibrary_AddTag(HTAGS Tags,  [In, MarshalAs(UnmanagedType.LPWStr)] string Name,  
      [In, MarshalAs(UnmanagedType.LPWStr)] string Value, TTagType TagType);

    //TagsLibrary_AddTagEx
    /// <summary>
    /// Add a tag with extended (detailed) attributes. 'ExtTag.Name' specifies the tag's name, an ID3v2 frame type, 
    /// eg. 'TIT2' (which is title), or an MP4 tag atom name, for example '©ART' (artist).
    /// </summary>
    /// <returns>Return value is 'True' on success</returns>    
    [return: MarshalAs(UnmanagedType.SysInt)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_AddTagEx", CharSet = CharSet.Auto)]
    public static extern int TagsLibrary_AddTagEx(HTAGS Tags, TTagType TagType, IntPtr ExtTag);

    //* TagsLibrary_TagCount
    /// <summary>
    /// Retrieve the tag count for the specified 'TagType' tag type.
    /// </summary>
    /// <returns>value Tag Count</returns>
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_TagCount", CharSet = CharSet.Auto)]
    public static extern int TagsLibrary_TagCount(HTAGS Tags, TTagType TagType);

    //TagsLibrary_DeleteTag
    /// <summary>
    /// Delete the first occurance of tag specified by 'Name'.
    /// </summary>
    /// <returns>is 'False' if no such tag found.</returns>    
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_DeleteTag", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_DeleteTag(HTAGS Tags,  [In, MarshalAs(UnmanagedType.LPWStr)] string Name, TTagType TagType);

    //TagsLibrary_DeleteTagByIndex
    /// <summary>
    /// Delete the tag specified by 'Index'.
    /// </summary>
    /// <returns>is 'False' if 'Index' is out of bounds.</returns>
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_DeleteTagByIndex", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_DeleteTagByIndex(HTAGS Tags, int Index, TTagType TagType);

    //* TagsLibrary_CoverArtCount
    /// <summary>
    /// Retrieve the cover art count for the 'TagType'.
    /// </summary>
    /// <returns>cover art count</returns>
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_CoverArtCount", CharSet = CharSet.Auto)]
    public static extern int TagsLibrary_CoverArtCount(HTAGS Tags, TTagType TagType);

    //* TagsLibrary_GetCoverArt
    /// <summary>
    ///  Extract the cover art specified by 'Index' into the 'CoverArt' structure.
    ///	'CoverArt.Data' points to the cover art data bytes, 'CoverArt.DataSize' specifies the data size. 
    ///	You can use 'CoverArt.MIMEType' or 'CoverArt.PictureFormat' to identify the cover art picture format.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetCoverArt", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_GetCoverArt(HTAGS Tags, TTagType TagType, int Index,  ref TCoverArtData CoverArt);

    //* TagsLibrary_GetCoverArtToFile
    /// <summary>
    /// Save Coverart to specified path which can load then from Path in a PictureBox
    /// </summary>
    /// <returns>value is 'True' on success.</returns>    
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetCoverArtToFile", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_GetCoverArtToFile(HTAGS Tags, TTagType TagType, int Index, [In, MarshalAs(UnmanagedType.LPWStr)] string FileName);

    //* TagsLibrary_DeleteCoverArt
    /// <summary>
    /// Delete a cover art specified by 'Index'. Use 'TagsLibrary_CoverArtCount' 
    /// to check how many cover arts are in the tag.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>    
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_DeleteCoverArt", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_DeleteCoverArt(HTAGS Tags, TTagType TagType, int Index);

    //TagsLibrary_SetCoverArt
    /// <summary>
    /// Set cover art specified by 'Index'.
    ///	Try to fill in all the attributes in 'CoverArt', although not all are needed for all the tag types.
    /// </summary>
    /// <returns>value is 'True' on success</returns>
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_SetCoverArt", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_SetCoverArt(HTAGS Tags, TTagType TagType, int Index, ref TCoverArtData CoverArt);

    //TagsLibrary_SetCoverArtFromFile
    /// <summary>
    /// Set cover art specified by 'Index' to a file which load before
    /// </summary>
    /// <returns>value is 'True' on success</returns>
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_SetCoverArtFromFile", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_SetCoverArtFromFile(HTAGS Tags, TTagType TagType, int Index,  [In, MarshalAs(UnmanagedType.LPWStr)] string FileName, TCoverArtData CoverArt);

    //TagsLibrary_AddCoverArt
    /// <summary>
    /// Add a new cover art.
    /// Try to fill in all the attributes in 'CoverArt', although not all are needed for all the tag types.
    /// </summary>
    /// <returns>value is 'True' on success.  </returns>        
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_AddCoverArt", CharSet = CharSet.Auto)]
    public static extern int TagsLibrary_AddCoverArt(HTAGS Tags,  TTagType TagType, TCoverArtData CoverArt);

    //TagsLibrary_SetTagLoadPriority
    /// <summary>
    /// Set the tag loading priority array. The value in 'TagPriorities[0]' has the highest priority.
    ///	Use 'Tags' = 'nil' or 'null' to set the global tag load priority. 
    ///	All tag library classes created after calling this function will use these settings.
    /// </summary>
    /// <returns>value should be always 'True'.</returns>
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_SetTagLoadPriority", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_SetTagLoadPriority(HTAGS Tags, TTagPriority TagPriorities);

    //* TagsLibrary_GetTagData
    /// <summary>
    /// Get binary data of a tag frame. Usefull for ID3v2 GEOB, etc. binary frames and MP4 binary atoms.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>    
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetTagData", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_GetTagData(HTAGS Tags, int Index, TTagType TagType, ref TTagData TagData);

    //TagsLibrary_SetTagData
    /// <summary>
    /// Set binary data of a tag frame. Usefull for ID3v2 GEOB, APEv2 binary frames, etc. and MP4 tags.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>    
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_SetTagData", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_SetTagData(HTAGS Tags, int Index, TTagType TagType, TTagData TagData);

    //TagsLibrary_GetCARTPostTimer
    /// <summary>
    /// Get WAV CART post timer specified by 'Index'. There are 8 CART post timers, Index range is 0 to 7.
    /// </summary>
    /// <returns>is 'False' if 'Index' is out of bounds.</returns>    
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetCARTPostTimer", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_GetCARTPostTimer(HTAGS Tags, int Index, ref TCARTPostTimer PostTimer);

    //TagsLibrary_SetCARTPostTimer
    /// <summary>
    /// Set WAV CART post timer specified by 'Index'. There are 8 CART post timers, Index range is 0 to 7.
    /// </summary>
    /// <returns>is 'False' if 'Index' is out of bounds.</returns>
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_SetCARTPostTimer", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_SetCARTPostTimer(HTAGS Tags, int Index, TCARTPostTimer PostTimer);

    //TagsLibrary_ClearCARTPostTimer
    /// <summary>
    /// Clear WAV CART post timer specified by 'Index'. There are 8 CART post timers, Index range is 0 to 7.
    /// </summary>
    /// <returns>is 'False' if 'Index' is out of bounds.</returns>    
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_ClearCARTPostTimer", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_ClearCARTPostTimer(HTAGS Tags, int Index);

    //TagsLibrary_GetConfig
    /// <summary>
    /// configuration settings. If 'Tags' = nil then means global parameters.
    /// </summary>
    [return: MarshalAs(UnmanagedType.SysInt)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetConfig", CharSet = CharSet.Auto)]
    public static extern IntPtr TagsLibrary_GetConfig(HTAGS Tags, TConfigFlags Config, TTagType TagType);

    //* TagsLibrary_SetConfig
    /// <summary>
    /// configuration settings. If 'Tags' = nil then means global parameters.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_SetConfig", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_SetConfig(HTAGS Tags, IntPtr Value, TConfigFlags Config, TTagType TagType);

    //TagsLibrary_GetVendor
    /// <summary>
    /// Vendor string. Applies to Ogg Vorbis, Opus and Flac.
    /// </summary>
    /// <returns>value is null otherwise string.</returns>    
    public static string TagsLibrary_GetVendor(HTAGS Tags, TTagType TagType)
    {
      IntPtr ptr = TagsLibrary_GetVendorPtr(Tags, TagType);
      if (ptr != IntPtr.Zero)
      {
        return Marshal.PtrToStringAuto(ptr);
      }
      return null;
    }
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetVendor", CharSet = CharSet.Auto)]
    private static extern IntPtr TagsLibrary_GetVendorPtr(HTAGS Tags, TTagType TagType);    
    
    //TagsLibrary_SetVendor
    /// <summary>
    /// Vendor string. Applies to Ogg Vorbis, Opus and Flac.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>    
    [return: MarshalAs(UnmanagedType.Bool)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_SetVendor", CharSet = CharSet.Auto)]
    public static extern bool TagsLibrary_SetVendor(HTAGS Tags, [In, MarshalAs(UnmanagedType.LPWStr)] string Vendor, TTagType TagType);

    //* TagsLibrary_GetAudioAttributes
    /// <summary>
    /// Get TMPEGAudioAttributes audio file's attributes.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetAudioAttributes", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_GetAudioAttributes(HTAGS Tags, TAudioType AudioType, ref TMPEGAudioAttributes Attributes);
    /// <summary>
    /// Get TFlacAudioAttributes audio file's attributes.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>    
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetAudioAttributes", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_GetAudioAttributes(HTAGS Tags, TAudioType AudioType, ref TFlacAudioAttributes Attributes);
    /// <summary>
    /// Get TDSFAudioAttributes audio file's attributes.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>    
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetAudioAttributes", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_GetAudioAttributes(HTAGS Tags, TAudioType AudioType, ref TDSFAudioAttributes Attributes);
    /// <summary>
    /// Get TOpusAudioAttributes audio file's attributes.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>    
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetAudioAttributes", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_GetAudioAttributes(HTAGS Tags, TAudioType AudioType, ref TOpusAudioAttributes Attributes);
    /// <summary>
    /// Get TVorbisAudioAttributes audio file's attributes.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>    
    [return: MarshalAs(UnmanagedType.U4)]    
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetAudioAttributes", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_GetAudioAttributes(HTAGS Tags, TAudioType AudioType, ref TVorbisAudioAttributes Attributes);
    /// <summary>
    /// Get TWAVEAudioAttributes audio file's attributes.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>    
    [return: MarshalAs(UnmanagedType.U4)]    
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetAudioAttributes", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_GetAudioAttributes(HTAGS Tags, TAudioType AudioType, ref TWAVEAudioAttributes Attributes);
    /// <summary>
    /// Get TAIFFAttributes audio file's attributes.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>    
    [return: MarshalAs(UnmanagedType.U4)]    
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetAudioAttributes", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_GetAudioAttributes(HTAGS Tags, TAudioType AudioType, ref TAIFFAttributes Attributes);
    /// <summary>
    /// Get TMP4AudioAttributes audio file's attributes.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>    
    [return: MarshalAs(UnmanagedType.U4)]    
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetAudioAttributes", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_GetAudioAttributes(HTAGS Tags, TAudioType AudioType, ref TMP4AudioAttributes Attributes);
    /// <summary>
    /// Get TWMAAttributes audio file's attributes.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>    
    [return: MarshalAs(UnmanagedType.U4)]    
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetAudioAttributes", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_GetAudioAttributes(HTAGS Tags, TAudioType AudioType, ref TWMAAttributes Attributes);
    /// <summary>
    /// Get TMPEGAudioAttributes audio file's attributes.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>    
    [return: MarshalAs(UnmanagedType.U4)]    
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetAudioAttributes", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_GetAudioAttributes(HTAGS Tags, TAudioType AudioType, ref TAudioAttributes Attributes);
    /// <summary>
    /// Get TWAVPackAttributes audio file's attributes.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>    
    [return: MarshalAs(UnmanagedType.U4)]    
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetAudioAttributes", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_GetAudioAttributes(HTAGS Tags, TAudioType AudioType, ref TWAVPackAttributes Attributes);
    /// <summary>
    /// Get TMusePackAttributes audio file's attributes.
    /// </summary>
    /// <returns>value is 'True' on success.</returns>    
    [return: MarshalAs(UnmanagedType.U4)]    
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetAudioAttributes", CharSet = CharSet.Auto)]
    public static extern TTagError TagsLibrary_GetAudioAttributes(HTAGS Tags, TAudioType AudioType, ref TMusePackAttributes Attributes);

    //* TagsLibrary_GetAudioAttribute
    /// <summary>
    /// Get source audio file's attributes.
    /// </summary>
    [return: MarshalAs(UnmanagedType.R8)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetAudioAttribute", CharSet = CharSet.Auto)]
    public static extern double TagsLibrary_GetAudioAttribute(HTAGS Tags, TAudioAttribute Attribute);

    //TagsLibrary_GetTagSize
    [return: MarshalAs(UnmanagedType.SysInt)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetTagSize", CharSet = CharSet.Auto)]
    public static extern int TagsLibrary_GetTagSize(HTAGS Tags, TTagType TagType);

    //TagsLibrary_GetAudioFormat
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetAudioFormat", CharSet = CharSet.Auto)]
    public static extern TAudioFileFormat TagsLibrary_GetAudioFormat([In, MarshalAs(UnmanagedType.LPWStr)] string FileName);

    //TagsLibrary_GetAudioFormatMemory
    [return: MarshalAs(UnmanagedType.U4)]
    [DllImport(TagsLibraryName, EntryPoint = "TagsLibrary_GetAudioFormatMemory", CharSet = CharSet.Auto)]
    public static extern TAudioFileFormat TagsLibrary_GetAudioFormatMemory(IntPtr MemoryAddress, UInt64 Size);
  }
}

