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
//* For other components see the home page:                                                                                      *
//*                                                                                                                              *
//*     http://www.3delite.hu/                                                                                                   *
//*                                                                                                                              *
//* If you have any questions or enquiries please mail: 3delite@3delite.hu                                                       *
//*                                                                                                                              *
//* Good coding! :)                                                                                                              *
//* 3delite                                                                                                                      *
//********************************************************************************************************************************

#pragma once

#ifdef _WIN32 // Windows
//* .dll file name
#define FILENAME_DLL_TAGS_LIBRARY               "TagsLib.dll"
#define TAGSLIBCALL __stdcall
#define GETTAGSLIBFUNCTION(f) *((void**)&f) = GetProcAddress(TagsLibraryDLLHandle, #f)
//* Exported function names (Windows)
#define NAME_TagsLibrary_Create                 "TagsLibrary_Create"
#define NAME_TagsLibrary_Free                   "TagsLibrary_Free"
#define NAME_TagsLibrary_Load                   "TagsLibrary_Load"
#define NAME_TagsLibrary_LoadFromMemory         "TagsLibrary_LoadFromMemory"
#define NAME_TagsLibrary_LoadFromBASS           "TagsLibrary_LoadFromBASS"
#define NAME_TagsLibrary_Save                   "TagsLibrary_Save"
#define NAME_TagsLibrary_SaveEx                 "TagsLibrary_SaveEx"
#define NAME_TagsLibrary_SaveToMemory           "TagsLibrary_SaveToMemory"
#define NAME_TagsLibrary_SaveToMemoryEx         "TagsLibrary_SaveToMemoryEx"
#define NAME_TagsLibrary_FreeSaveHandle         "TagsLibrary_FreeSaveHandle"
#define NAME_TagsLibrary_RemoveTag              "TagsLibrary_RemoveTag"
#define NAME_TagsLibrary_RemoveTagFromMemory    "TagsLibrary_RemoveTagFromMemory"
#define NAME_TagsLibrary_Loaded                 "TagsLibrary_Loaded"
#define NAME_TagsLibrary_GetTag                 "TagsLibrary_GetTag"
#define NAME_TagsLibrary_GetTagEx               "TagsLibrary_GetTagEx"
#define NAME_TagsLibrary_GetTagByIndexEx        "TagsLibrary_GetTagByIndexEx"
#define NAME_TagsLibrary_SetTag                 "TagsLibrary_SetTag"
#define NAME_TagsLibrary_SetTagEx               "TagsLibrary_SetTagEx"
#define NAME_TagsLibrary_AddTag                 "TagsLibrary_AddTag"
#define NAME_TagsLibrary_AddTagEx               "TagsLibrary_AddTagEx"
#define NAME_TagsLibrary_TagCount               "TagsLibrary_TagCount"
#define NAME_TagsLibrary_DeleteTag              "TagsLibrary_DeleteTag"
#define NAME_TagsLibrary_DeleteTagByIndex       "TagsLibrary_DeleteTagByIndex"
#define NAME_TagsLibrary_CoverArtCount          "TagsLibrary_CoverArtCount"
#define NAME_TagsLibrary_GetCoverArt            "TagsLibrary_GetCoverArt"
#define NAME_TagsLibrary_GetCoverArtToFile      "TagsLibrary_GetCoverArtToFile"
#define NAME_TagsLibrary_DeleteCoverArt         "TagsLibrary_DeleteCoverArt"
#define NAME_TagsLibrary_SetCoverArt            "TagsLibrary_SetCoverArt"
#define NAME_TagsLibrary_SetCoverArtFromFile    "TagsLibrary_SetCoverArtFromFile"
#define NAME_TagsLibrary_AddCoverArt            "TagsLibrary_AddCoverArt"
#define NAME_TagsLibrary_SetTagLoadPriority     "TagsLibrary_SetTagLoadPriority"
#define NAME_TagsLibrary_GetTagData            	"TagsLibrary_GetTagData"
#define NAME_TagsLibrary_SetTagData     		"TagsLibrary_SetTagData"
#define NAME_TagsLibrary_GetCARTPostTimer     	"TagsLibrary_GetCARTPostTimer"
#define NAME_TagsLibrary_SetCARTPostTimer     	"TagsLibrary_SetCARTPostTimer"
#define NAME_TagsLibrary_ClearCARTPostTimer     "TagsLibrary_ClearCARTPostTimer"
#define NAME_TagsLibrary_GetConfig     			"TagsLibrary_GetConfig"
#define NAME_TagsLibrary_SetConfig     			"TagsLibrary_SetConfig"
#define NAME_TagsLibrary_GetVendor     			"TagsLibrary_GetVendor"
#define NAME_TagsLibrary_SetVendor     			"TagsLibrary_SetVendor"
#define NAME_TagsLibrary_GetAudioAttributes     "TagsLibrary_GetAudioAttributes"
#define NAME_TagsLibrary_GetAudioAttribute      "TagsLibrary_GetAudioAttribute"
#define NAME_TagsLibrary_GetTagSize             "TagsLibrary_GetTagSize"
#define NAME_TagsLibrary_GetAudioFormat         "TagsLibrary_GetAudioFormat"
#define NAME_TagsLibrary_GetAudioFormatMemory   "TagsLibrary_GetAudioFormatMemory"

#else // OSX
//* .dll file name
#define FILENAME_DLL_TAGS_LIBRARY               "libTagsLib.dylib"
#define TAGSLIBCALL __cdecl
#define GETTAGSLIBFUNCTION(f) *((void**)&f) = dlsym(TagsLibraryDLLHandle, #f)
//* Exported function names (OSX)
#define NAME_TagsLibrary_Create                 "_TagsLibrary_Create"
#define NAME_TagsLibrary_Free                   "_TagsLibrary_Free"
#define NAME_TagsLibrary_Load                   "_TagsLibrary_Load"
#define NAME_TagsLibrary_LoadFromMemory         "_TagsLibrary_LoadFromMemory"
#define NAME_TagsLibrary_LoadFromBASS           "_TagsLibrary_LoadFromBASS"
#define NAME_TagsLibrary_Save                   "_TagsLibrary_Save"
#define NAME_TagsLibrary_SaveEx                 "_TagsLibrary_SaveEx"
#define NAME_TagsLibrary_SaveToMemory           "_TagsLibrary_SaveToMemory"
#define NAME_TagsLibrary_SaveToMemoryEx         "_TagsLibrary_SaveToMemoryEx"
#define NAME_TagsLibrary_FreeSaveHandle         "_TagsLibrary_FreeSaveHandle"
#define NAME_TagsLibrary_RemoveTag              "_TagsLibrary_RemoveTag"
#define NAME_TagsLibrary_RemoveTagFromMemory    "_TagsLibrary_RemoveTagFromMemory"
#define NAME_TagsLibrary_Loaded                 "_TagsLibrary_Loaded"
#define NAME_TagsLibrary_GetTag                 "_TagsLibrary_GetTag"
#define NAME_TagsLibrary_GetTagEx               "_TagsLibrary_GetTagEx"
#define NAME_TagsLibrary_GetTagByIndexEx        "_TagsLibrary_GetTagByIndexEx"
#define NAME_TagsLibrary_SetTag                 "_TagsLibrary_SetTag"
#define NAME_TagsLibrary_SetTagEx               "_TagsLibrary_SetTagEx"
#define NAME_TagsLibrary_AddTag                 "_TagsLibrary_AddTag"
#define NAME_TagsLibrary_AddTagEx               "_TagsLibrary_AddTagEx"
#define NAME_TagsLibrary_TagCount               "_TagsLibrary_TagCount"
#define NAME_TagsLibrary_DeleteTag              "_TagsLibrary_DeleteTag"
#define NAME_TagsLibrary_DeleteTagByIndex       "_TagsLibrary_DeleteTagByIndex"
#define NAME_TagsLibrary_CoverArtCount          "_TagsLibrary_CoverArtCount"
#define NAME_TagsLibrary_GetCoverArt            "_TagsLibrary_GetCoverArt"
#define NAME_TagsLibrary_GetCoverArtToFile      "_TagsLibrary_GetCoverArtToFile"
#define NAME_TagsLibrary_DeleteCoverArt         "_TagsLibrary_DeleteCoverArt"
#define NAME_TagsLibrary_SetCoverArt            "_TagsLibrary_SetCoverArt"
#define NAME_TagsLibrary_SetCoverArtFromFile    "_TagsLibrary_SetCoverArtFromFile"
#define NAME_TagsLibrary_AddCoverArt            "_TagsLibrary_AddCoverArt"
#define NAME_TagsLibrary_SetTagLoadPriority     "_TagsLibrary_SetTagLoadPriority"
#define NAME_TagsLibrary_GetTagData            	"_TagsLibrary_GetTagData"
#define NAME_TagsLibrary_SetTagData     		"_TagsLibrary_SetTagData"
#define NAME_TagsLibrary_GetCARTPostTimer     	"_TagsLibrary_GetCARTPostTimer"
#define NAME_TagsLibrary_SetCARTPostTimer     	"_TagsLibrary_SetCARTPostTimer"
#define NAME_TagsLibrary_ClearCARTPostTimer     "_TagsLibrary_ClearCARTPostTimer"
#define NAME_TagsLibrary_GetConfig     			"_TagsLibrary_GetConfig"
#define NAME_TagsLibrary_SetConfig     			"_TagsLibrary_SetConfig"
#define NAME_TagsLibrary_GetVendor     			"_TagsLibrary_GetVendor"
#define NAME_TagsLibrary_SetVendor     			"_TagsLibrary_SetVendor"
#define NAME_TagsLibrary_GetAudioAttributes     "_TagsLibrary_GetAudioAttributes"
#define NAME_TagsLibrary_GetAudioAttribute      "_TagsLibrary_GetAudioAttribute"
#define NAME_TagsLibrary_GetTagSize             "_TagsLibrary_GetTagSize"
#define NAME_TagsLibrary_GetAudioFormat         "_TagsLibrary_GetAudioFormat"
#define NAME_TagsLibrary_GetAudioFormatMemory   "_TagsLibrary_GetAudioFormatMemory"
#endif

#define TAGSLIBRARY_SUCCESS                                             0
#define TAGSLIBRARY_ERROR                                               0xFFFF
#define TAGSLIBRARY_ERROR_NO_TAG_FOUND                                  1
#define TAGSLIBRARY_ERROR_FILENOTFOUND                                  2
#define TAGSLIBRARY_ERROR_EMPTY_TAG                                     3
#define TAGSLIBRARY_ERROR_EMPTY_FRAMES                                  4
#define TAGSLIBRARY_ERROR_OPENING_FILE                                  5
#define TAGSLIBRARY_ERROR_READING_FILE                                  6
#define TAGSLIBRARY_ERROR_WRITING_FILE                                  7
#define TAGSLIBRARY_ERROR_CORRUPT                                       8
#define TAGSLIBRARY_ERROR_NOT_SUPPORTED_VERSION                         9
#define TAGSLIBRARY_ERROR_NOT_SUPPORTED_FORMAT                          10
#define TAGSLIBRARY_ERROR_BASS_NOT_LOADED                               11
#define TAGSLIBRARY_ERROR_BASS_ChannelGetTags_NOT_FOUND                 12
#define TAGSLIBRARY_ERROR_DOESNT_FIT                                    13
#define TAGSLIBRARY_ERROR_NEED_EXCLUSIVE_ACCESS                         14
#define TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNTLOADDLL                  15
#define TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNOTCREATEMETADATAEDITOR    16
#define TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNOTQIFORIWMHEADERINFO3     17
#define TAGSLIBRARY_ERROR_WMATAGLIBRARY_COULDNOTQUERY_ATTRIBUTE_COUNT   18
#define TAGSLIBRARY_ERROR_MP4TAGLIBRARY_UPDATE_stco                     19
#define TAGSLIBRARY_ERROR_MP4TAGLIBRARY_UPDATE_co64                     20
#define TAGSLIBRARY_ERROR_NOT_ENOUGH_MEMORY_OR_AV                       21

#define TAGSLIBRARY_PADDING_SIZE_TO_WRITE                               1
#define TAGSLIBRARY_PARSE_OGG_PLAYTIME                               	2
#define TAGSLIBRARY_PARSE_ID3v2_AUDIO_ATTRIBUTES                        3
#define TAGSLIBRARY_MP4TAG_KEEP_PADDING                                 4
#define TAGSLIBRARY_PARSE_WAVPACK_AUDIO_ATTRIBUTES                      5
#define TAGSLIBRARY_PARSE_MUSEPACK_AUDIO_ATTRIBUTES                     6
#define TAGSLIBRARY_DEEP_OPUS_BITRATE_SCAN                              7

#ifdef _WIN32
#include <wtypes.h>
typedef unsigned __int64 QWORD;
#else
#include <stdint.h>
#define WINAPI
#define CALLBACK
typedef uint8_t BYTE;
typedef uint16_t WORD;
typedef uint32_t DWORD;
typedef uint64_t QWORD;
#ifndef __OBJC__
typedef int BOOL;
#endif
#ifndef TRUE
#define TRUE 1
#define FALSE 0
#endif
#endif

#pragma pack(push,1)

typedef void* HTAGS;

typedef enum
{
	ttNone			= 0,
	ttAutomatic		= 1,
	ttAPEv2			= 2,
	ttFlac			= 3,
	ttID3v1			= 4,
	ttID3v2			= 5,
	ttMP4			= 6,
	ttOpusVorbis	= 7,
	ttWAV			= 8,
	ttWMA			= 9
} TTagType;

typedef enum
{
	tpfUnknown		= 0,
	tpfJPEG			= 1,
	tpfPNG			= 2,
	tpfBMP			= 3,
	tpfGIF			= 4
} TTagPictureFormat;

typedef TTagType TTagPriority[8];

typedef enum
{
	ettUnknown		= 0,
	ettTXXX			= 1,
	ettWXXX			= 2
} TExtTagType;

typedef struct {
	LPWSTR Name;
	LPWSTR Value;
	int ValueSize;
	LPWSTR Language;
	LPWSTR Description;
	TExtTagType ExtTagType;
	int Index;
} *PTExtTag, TExtTag;

typedef struct {
	LPWSTR Name;
	LPWSTR Value;
	int ValueSize;
	int Index;
} *PTSimpleTag, TSimpleTag;

typedef enum
{
	id3v2ttUnknown = 0,
	id3v2ttText = 1,
	id3v2ttTextWithDescription = 2,
	id3v2ttTextWithDescriptionAndLangugageID = 3,
	id3v2ttURL = 4,
	id3v2ttUserDefinedURL = 5,
	id3v2ttPlayCount = 6,
	id3v2ttBinary = 7
} TID3v2TagType;

typedef struct {
	LPWSTR Name;
	LPWSTR Value;
	int ValueSize;
	LPWSTR Language;
	LPWSTR Description;
	TID3v2TagType TagType;
	int Index;
} *PTID3v2TagEx, TID3v2TagEx;

typedef enum
{
	mp4ttUnknown = 0,
	mp4ttText = 1,
	mp4ttInteger8 = 2,
	mp4ttInteger16 = 3,
	mp4ttInteger32 = 4,
	mp4ttInteger48 = 5,
	mp4ttInteger64 = 6
} TMP4TagType;

typedef struct {
	LPWSTR Name;
	LPWSTR Value;
	int	ValueSize;
	LPWSTR NameValue;
	LPWSTR MeanValue;
	TMP4TagType TagType;
	int DataType;
	int Index;
} *PTMP4TagEx, TMP4TagEx;

typedef struct {
	LPWSTR Name;
	void* Data;
	QWORD DataSize;
	LPWSTR Description;
	DWORD CoverType;
	LPWSTR MIMEType;
	TTagPictureFormat PictureFormat;
	DWORD Width;
	DWORD Height;
	DWORD ColorDepth;
	DWORD NoOfColors;
	int ID3v2TextEncoding;
	int Index;
} *PTCoverArtData, TCoverArtData;

typedef struct {
	LPWSTR Name;
	void* Data;
	QWORD DataSize;
	int DataType;
} *PTTagData, TTagData;

typedef struct {
	LPWSTR Usage;
	DWORD Value;
} *PTCARTPostTimer, TCARTPostTimer;

typedef enum
{
	atAutomatic		= 0,
	atFlac			= 1,
	atMPEG			= 2,
	atDSDDSF		= 3,
	atWAV			= 4,
	atAIFF			= 5,
	atMP4			= 6,
	atOpus			= 7,
	atVorbis		= 8,
	atWMA			= 9,
	atWAVPack       = 10,
	atMusePack      = 11,
	atDSDDFF		= 12
} TAudioType;

typedef enum
{
	tmpegvUnknown	= 0,
	tmpegv1			= 1,
	tmpegv2			= 2,
	tmpegv25		= 3
} TMPEGVersion;

typedef enum
{
	tmpeglUnknown	= 0,
	tmpegl1			= 1,
	tmpegl2			= 2,
	tmpegl3			= 3
} TMPEGLayer;

typedef enum
{
	tmpegcmUnknown		= 0,
	tmpegcmMono			= 1,
	tmpegcmDualChannel	= 2,
	tmpegcmJointStereo	= 3,
	tmpegcmStereo		= 4
} TMPEGChannelMode;

typedef enum
{
	tmpegmeUnknown		= 0,
	tmpegmeNone			= 1,
	tmpegmeIntensity	= 2,
	tmpegmeMS			= 3,
	tmpegmeIntensityMS	= 4
} TMPEGModeExtension;

typedef enum
{
	tmpegeUnknown		= 0,
	tmpegeNo			= 1,
	tmpege5015			= 2,
	tmpegeCCITJ17		= 3
} TMPEGEmphasis;

typedef struct {
	QWORD Position;                		//* Position of header in bytes
	DWORD Header;                  		//* The Headers bytes
	int	FrameSize;             			//* Frame's length
	TMPEGVersion Version;          		//* MPEG Version
	TMPEGLayer Layer;              		//* MPEG Layer
	BOOL CRC;                  			//* Frame has CRC
	DWORD BitRate;                 		//* Frame's bitrate
	DWORD SampleRate;                   //* Frame's sample rate
	BOOL Padding;              			//* Frame is padded
	BOOL _Private;             			//* Frame's private bit is set
	TMPEGChannelMode ChannelMode;  		//* Frame's channel mode
	TMPEGModeExtension ModeExtension; 	//* Joint stereo only
	BOOL Copyrighted;          			//* Frame's Copyright bit is set
	BOOL Original;             			//* Frame's Original bit is set
	TMPEGEmphasis Emphasis;        		//* Frame's emphasis mode
	BOOL VBR;                  			//* Stream is probably VBR
	QWORD FrameCount;              		//* Total number of MPEG frames (by header)
	int Quality;               			//* MPEG quality (by header)
	QWORD Bytes;                   		//* Total bytes (by header)
} *PTMPEGAudioAttributes, TMPEGAudioAttributes;

typedef struct {
	DWORD Channels;
	int SampleRate;
	DWORD BitsPerSample;
	QWORD SampleCount;
	double Playtime;       // Duration (seconds)
	double Ratio;          // Compression ratio (%)
	LPWSTR ChannelMode;
	int Bitrate;
} *PTFlacAudioAttributes, TFlacAudioAttributes;

typedef enum
{
	dsfctUnknown		= 0,
	dsfctMono			= 1,
	dsfctStereo			= 2,
	dsfct3Channels      = 3,
	dsfctQuad           = 4,
	dsfct4Channels      = 5,
	dsfct5Channels      = 6,
	dsfct51Channels     = 7
} TDSFChannelType;

typedef struct {
	DWORD FormatVersion;
	DWORD FormatID;
	TDSFChannelType ChannelType;
	DWORD ChannelNumber;
	DWORD SamplingFrequency;
	DWORD BitsPerSample;
	DWORD BlockSizePerChannel;
	double PlayTime;
	QWORD SampleCount;
	int Bitrate;
} *PTDSFAudioAttributes, TDSFAudioAttributes;

typedef struct {
	LPWSTR FormatVersion;
	DWORD SampleRate;
	WORD ChannelNumber;
	LPWSTR CompressionName;
	QWORD SampleCount;
	double PlayTime;
	DWORD BitRate;
	QWORD SoundDataLength;
	DWORD DSTFramesCount;
	WORD DSTFramesRate;
	double Ratio;
} *PTDFFAudioAttributes, TDFFAudioAttributes;

typedef struct {
	DWORD BitstreamVersion;                       	//{ Bitstream version number }
	DWORD ChannelCount;                           	//      { Number of channels }
	DWORD PreSkip;
	DWORD SampleRate;                             	//        { Sample rate (hz) }
	DWORD OutputGain;
	DWORD MappingFamily;                          	//                 { 0,1,255 }
	double PlayTime;
	QWORD SampleCount;
	int Bitrate;
} *PTOpusAudioAttributes, TOpusAudioAttributes;

typedef struct {
	BYTE BitstreamVersion[4];        				//{ Bitstream version number }
	DWORD ChannelMode;                          	//      { Number of channels }
	int SampleRate;                           		//        { Sample rate (hz) }
	int BitRateMaximal;                       		//    { Bit rate upper limit }
	int BitRateNominal;                       		//        { Nominal bit rate }
	int BitRateMinimal;                       		//    { Bit rate lower limit }
	DWORD BlockSize;                    			//{ Coded size for small and long blocks }
	double PlayTime;
	QWORD SampleCount;
	int Bitrate;
} *PTVorbisAudioAttributes, TVorbisAudioAttributes;

typedef struct {
	DWORD FormatTag;                   	// format type
	DWORD Channels;                    	// number of channels (i.e. mono, stereo, etc.)
	DWORD SamplesPerSec;              	// sample rate
	DWORD AvgBytesPerSec;             	// for buffer estimation
	DWORD BlockAlign;                  	// block size of data
	DWORD BitsPerSample;               	// number of bits per sample of mono data
	double PlayTime;
	QWORD SampleCount;
	DWORD cbSize;	                    // Size of the extension: 22
	DWORD ValidBitsPerSample;	        // at most 8 *  M
	DWORD ChannelMask;	                // Speaker position mask: 0
	BYTE SubFormat[16];
	int Bitrate;
} *PTWAVEAudioAttributes, TWAVEAudioAttributes;

typedef struct {
	DWORD Channels;
	DWORD SampleCount;
	DWORD SampleSize;
	double SampleRate;
	BYTE CompressionID[4];  // http://en.wikipedia.org/wiki/Audio_Interchange_File_Format
	LPWSTR Compression;
	double PlayTime;
	int	BitRate;
} *PTAIFFAttributes, TAIFFAttributes;

typedef struct {
	DWORD Channels;
	int SampleRate;
	DWORD BitsPerSample;
	double Playtime;       // Duration (seconds)
	int Bitrate;
} *PTMP4AudioAttributes, TMP4AudioAttributes;

typedef struct {
	double PlayTime;
	int BitRate;
} *PTWMAAttributes, TWMAAttributes;

typedef struct {
	DWORD Channels;                     	// number of channels (i.e. mono, stereo, etc.)
	DWORD SamplesPerSec;               		// sample rate
	DWORD BitsPerSample;                	// number of bits per sample of mono data
	double PlayTime;                        // duration in seconds
	QWORD SampleCount;                   	// number of total samples
	int Bitrate;
} *PTAudioAttributes, TAudioAttributes;

typedef enum
{
	aaChannels			= 0,
	aaSamplesPerSec		= 1,
	aaBitsPerSample		= 2,
	aaPlayTime      	= 3,
	aaSampleCount       = 4,
	aaBitRate      		= 5
} TAudioAttribute;

typedef struct {
	int FormatTag;
	int Version;
	int Channels;
	LPWSTR ChannelMode;
	int SampleRate;
	int Bits;
	double Bitrate;
	double PlayTime;
	QWORD Samples;
	QWORD BSamples;
	double Ratio;
	LPWSTR Encoder;
} *PTWAVPackAttributes, TWAVPackAttributes;

typedef struct {
	BYTE ChannelModeID;                	//{ Channel mode code }
	LPWSTR ChannelMode;                	//{ Channel mode name }
	int FrameCount;                		//{ Number of frames }
	WORD BitRate;                      	//{ Bit rate }
	BYTE StreamVersion;                	//{ Stream version }
	LPWSTR StreamStreamVersionString;
	int SampleRate;
	BYTE ProfileID;                    	//{ Profile code }
	LPWSTR Profile;                     //{ Profile name }
	double PlayTime;                   	//{ Duration (seconds) }
	LPWSTR Encoder;                     //{ Encoder used }
	double Ratio;                      	//{ Compression ratio (%) }
} *PTMusePackAttributes, TMusePackAttributes;

typedef enum
{
	affUnknown		= 0,
	affAPE          = 1,
	affFlac         = 2,
	affOggFlac      = 3,
	affMPEG         = 4,
	affMP4          = 5,
	affOpus         = 6,
	affVorbis       = 7,
	affTheora       = 8,
	affWAV          = 9,
	affRF64         = 10,
	affAIFF         = 11,
	affAIFC         = 12,
	affDFF          = 13,
	affDSF          = 14,
	affOptimFrog    = 15,
	affMusePack     = 16,
	affWavPack      = 17
} TAudioFileFormat;

#pragma pack(pop)

typedef HTAGS(TAGSLIBCALL *t_TagsLibrary_Create)();
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_Free)(HTAGS Tags);
typedef int(TAGSLIBCALL *t_TagsLibrary_Load)(HTAGS Tags, LPWSTR FileName, TTagType TagType, BOOL ParseTags);
typedef int(TAGSLIBCALL *t_TagsLibrary_LoadFromMemory)(HTAGS Tags, void *MemoryAddress, QWORD Size, TTagType TagType, BOOL ParseTags);
typedef int(TAGSLIBCALL *t_TagsLibrary_LoadFromBASS)(HTAGS Tags, DWORD Channel);
typedef int(TAGSLIBCALL *t_TagsLibrary_Save)(HTAGS Tags, LPWSTR FileName, TTagType TagType);
typedef int(TAGSLIBCALL *t_TagsLibrary_SaveEx)(HTAGS Tags, LPWSTR FileName, TTagType TagType);
typedef int(TAGSLIBCALL *t_TagsLibrary_SaveToMemory)(HTAGS Tags, void *MemoryAddress, QWORD Size, TTagType TagType, void *SavedAddress, QWORD *SavedSize, void *SaveHandle);
typedef int(TAGSLIBCALL *t_TagsLibrary_SaveToMemoryEx)(HTAGS Tags, void *MemoryAddress, QWORD Size, TTagType TagType, void *SavedAddress, QWORD *SavedSize, void *SaveHandle);
typedef int(TAGSLIBCALL *t_TagsLibrary_FreeSaveHandle)(void *SaveHandle);
typedef int(TAGSLIBCALL *t_TagsLibrary_RemoveTag)(LPWSTR FileName, TTagType TagType);
typedef int(TAGSLIBCALL *t_TagsLibrary_RemoveTagFromMemory)(void *MemoryAddress, QWORD Size, TTagType TagType, void *SavedAddress, QWORD *SavedSize, void *SaveHandle);
typedef LPWSTR(TAGSLIBCALL *t_TagsLibrary_GetTag)(HTAGS Tags, LPWSTR Name, TTagType TagType);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_Loaded)(HTAGS Tags, TTagType TagType);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_GetTagEx)(HTAGS Tags, LPWSTR Name, TTagType TagType, void *ExtTag);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_GetTagByIndexEx)(HTAGS Tags, int Index, TTagType TagType, void *ExtTag);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_SetTag)(HTAGS Tags, LPWSTR Name, LPWSTR Value, TTagType TagType);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_SetTagEx)(HTAGS Tags, TTagType TagType, void *ExtTag);
typedef int(TAGSLIBCALL *t_TagsLibrary_AddTag)(HTAGS Tags, LPWSTR Name, LPWSTR Value, TTagType TagType);
typedef int(TAGSLIBCALL *t_TagsLibrary_AddTagEx)(HTAGS Tags, TTagType TagType, void *ExtTag);
typedef int(TAGSLIBCALL *t_TagsLibrary_TagCount)(HTAGS Tags, TTagType TagType);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_DeleteTag)(HTAGS Tags, LPWSTR Name, TTagType TagType);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_DeleteTagByIndex)(HTAGS Tags, int Index, TTagType TagType);
typedef int(TAGSLIBCALL *t_TagsLibrary_CoverArtCount)(HTAGS Tags, TTagType TagType);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_GetCoverArt)(HTAGS Tags, TTagType TagType, int Index, TCoverArtData *CoverArt);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_GetCoverArtToFile)(HTAGS Tags, TTagType TagType, int Index, LPWSTR FileName);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_DeleteCoverArt)(HTAGS Tags, TTagType TagType, int Index);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_SetCoverArt)(HTAGS Tags, TTagType TagType, int Index, TCoverArtData CoverArt);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_SetCoverArtFromFile)(HTAGS Tags, TTagType TagType, int Index, LPWSTR FileName, TCoverArtData CoverArt);
typedef int(TAGSLIBCALL *t_TagsLibrary_AddCoverArt)(HTAGS Tags, TTagType TagType, TCoverArtData CoverArt);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_SetTagLoadPriority)(HTAGS Tags, TTagPriority TagPriority);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_GetTagData)(HTAGS Tags, int Index, TTagType TagType, TTagData *TagData);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_SetTagData)(HTAGS Tags, int Index, TTagType TagType, TTagData TagData);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_GetCARTPostTimer)(HTAGS Tags, int Index, TCARTPostTimer *PostTimer);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_SetCARTPostTimer)(HTAGS Tags, int Index, TCARTPostTimer PostTimer);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_ClearCARTPostTimer)(HTAGS Tags, int Index);
typedef void*(TAGSLIBCALL *t_TagsLibrary_GetConfig)(HTAGS Tags, int Option, TTagType TagType);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_SetConfig)(HTAGS Tags, void *Value, int Option, TTagType TagType);
typedef LPWSTR(TAGSLIBCALL *t_TagsLibrary_GetVendor)(HTAGS Tags, TTagType TagType);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_SetVendor)(HTAGS Tags, LPWSTR Vendor, TTagType TagType);
typedef BOOL(TAGSLIBCALL *t_TagsLibrary_GetAudioAttributes)(HTAGS Tags, TAudioType AudioType, void *Attributes);
typedef double(TAGSLIBCALL *t_TagsLibrary_GetAudioAttribute)(HTAGS Tags, TAudioAttribute Attribute);
typedef DWORD(TAGSLIBCALL *t_TagsLibrary_GetTagSize)(HTAGS Tags, TTagType TagType);
typedef TAudioFileFormat(TAGSLIBCALL *t_TagsLibrary_GetAudioFormat)(LPWSTR FileName);
typedef TAudioFileFormat(TAGSLIBCALL *t_TagsLibrary_GetAudioFormatMemory)(void *MemoryAddress, QWORD Size);
//* Exported functions
#ifdef __cplusplus
extern "C" {
#endif

	static HMODULE TagsLibraryDLLHandle = NULL;
	BOOL TagsLibraryDLLLoaded = FALSE;

	t_TagsLibrary_Create TagsLibrary_Create = NULL;
	t_TagsLibrary_Free TagsLibrary_Free = NULL;
	t_TagsLibrary_Load TagsLibrary_Load = NULL;
	t_TagsLibrary_Load TagsLibrary_LoadFromMemory = NULL;
	t_TagsLibrary_LoadFromBASS TagsLibrary_LoadFromBASS = NULL;
	t_TagsLibrary_Save TagsLibrary_Save = NULL;
	t_TagsLibrary_SaveEx TagsLibrary_SaveEx = NULL;
	t_TagsLibrary_SaveToMemory TagsLibrary_SaveToMemory = NULL;
	t_TagsLibrary_SaveToMemoryEx TagsLibrary_SaveToMemoryEx = NULL;
	t_TagsLibrary_FreeSaveHandle TagsLibrary_FreeSaveHandle = NULL;
	t_TagsLibrary_RemoveTag TagsLibrary_RemoveTag = NULL;
	t_TagsLibrary_RemoveTagFromMemory TagsLibrary_RemoveTagFromMemory = NULL;
	t_TagsLibrary_Loaded TagsLibrary_Loaded = NULL;
	t_TagsLibrary_GetTag TagsLibrary_GetTag = NULL;
	t_TagsLibrary_GetTagEx TagsLibrary_GetTagEx = NULL;
	t_TagsLibrary_GetTagByIndexEx TagsLibrary_GetTagByIndexEx = NULL;
	t_TagsLibrary_SetTag TagsLibrary_SetTag = NULL;
	t_TagsLibrary_SetTagEx TagsLibrary_SetTagEx = NULL;
	t_TagsLibrary_AddTag TagsLibrary_AddTag = NULL;
	t_TagsLibrary_AddTagEx TagsLibrary_AddTagEx = NULL;
	t_TagsLibrary_TagCount TagsLibrary_TagCount = NULL;
	t_TagsLibrary_DeleteTag TagsLibrary_DeleteTag = NULL;
	t_TagsLibrary_DeleteTagByIndex TagsLibrary_DeleteTagByIndex = NULL;
	t_TagsLibrary_CoverArtCount TagsLibrary_CoverArtCount = NULL;
	t_TagsLibrary_GetCoverArt TagsLibrary_GetCoverArt = NULL;
	t_TagsLibrary_GetCoverArtToFile TagsLibrary_GetCoverArtToFile = NULL;
	t_TagsLibrary_DeleteCoverArt TagsLibrary_DeleteCoverArt = NULL;
	t_TagsLibrary_SetCoverArt TagsLibrary_SetCoverArt = NULL;
	t_TagsLibrary_SetCoverArtFromFile TagsLibrary_SetCoverArtFromFile = NULL;
	t_TagsLibrary_AddCoverArt TagsLibrary_AddCoverArt = NULL;
	t_TagsLibrary_SetTagLoadPriority TagsLibrary_SetTagLoadPriority = NULL;
	t_TagsLibrary_GetTagData TagsLibrary_GetTagData = NULL;
	t_TagsLibrary_SetTagData TagsLibrary_SetTagData = NULL;
	t_TagsLibrary_GetCARTPostTimer TagsLibrary_GetCARTPostTimer = NULL;
	t_TagsLibrary_SetCARTPostTimer TagsLibrary_SetCARTPostTimer = NULL;
	t_TagsLibrary_ClearCARTPostTimer TagsLibrary_ClearCARTPostTimer = NULL;
	t_TagsLibrary_GetConfig TagsLibrary_GetConfig = NULL;
	t_TagsLibrary_SetConfig TagsLibrary_SetConfig = NULL;
	t_TagsLibrary_GetVendor TagsLibrary_GetVendor = NULL;
	t_TagsLibrary_SetVendor TagsLibrary_SetVendor = NULL;
	t_TagsLibrary_GetAudioAttributes TagsLibrary_GetAudioAttributes = NULL;
	t_TagsLibrary_GetAudioAttribute TagsLibrary_GetAudioAttribute = NULL;
	t_TagsLibrary_GetTagSize TagsLibrary_GetTagSize = NULL;
	t_TagsLibrary_GetAudioFormat TagsLibrary_GetAudioFormat = NULL;
	t_TagsLibrary_GetAudioFormatMemory TagsLibrary_GetAudioFormatMemory = NULL;

#ifdef __cplusplus
}
#endif

BOOL InitTagsLibrary()
{
#ifdef _WIN32
	TagsLibraryDLLHandle = LoadLibrary(FILENAME_DLL_TAGS_LIBRARY);
#else //* OSX
	TagsLibraryDLLHandle = dlopen(FILENAME_DLL_TAGS_LIBRARY, RTLD_NOW);
#endif
	if (NULL != TagsLibraryDLLHandle)
	{
		GETTAGSLIBFUNCTION(TagsLibrary_Create);
		GETTAGSLIBFUNCTION(TagsLibrary_Free);
		GETTAGSLIBFUNCTION(TagsLibrary_Load);
		GETTAGSLIBFUNCTION(TagsLibrary_LoadFromMemory);
		GETTAGSLIBFUNCTION(TagsLibrary_LoadFromBASS);
		GETTAGSLIBFUNCTION(TagsLibrary_Save);
		GETTAGSLIBFUNCTION(TagsLibrary_SaveEx);
		GETTAGSLIBFUNCTION(TagsLibrary_SaveToMemory);
		GETTAGSLIBFUNCTION(TagsLibrary_SaveToMemoryEx);
		GETTAGSLIBFUNCTION(TagsLibrary_FreeSaveHandle);
		GETTAGSLIBFUNCTION(TagsLibrary_RemoveTag);
		GETTAGSLIBFUNCTION(TagsLibrary_RemoveTagFromMemory);
		GETTAGSLIBFUNCTION(TagsLibrary_Loaded);
		GETTAGSLIBFUNCTION(TagsLibrary_GetTag);
		GETTAGSLIBFUNCTION(TagsLibrary_GetTagEx);
		GETTAGSLIBFUNCTION(TagsLibrary_GetTagByIndexEx);
		GETTAGSLIBFUNCTION(TagsLibrary_SetTag);
		GETTAGSLIBFUNCTION(TagsLibrary_SetTagEx);
		GETTAGSLIBFUNCTION(TagsLibrary_AddTag);
		GETTAGSLIBFUNCTION(TagsLibrary_AddTagEx);
		GETTAGSLIBFUNCTION(TagsLibrary_TagCount);
		GETTAGSLIBFUNCTION(TagsLibrary_DeleteTag);
		GETTAGSLIBFUNCTION(TagsLibrary_DeleteTagByIndex);
		GETTAGSLIBFUNCTION(TagsLibrary_CoverArtCount);
		GETTAGSLIBFUNCTION(TagsLibrary_GetCoverArt);
		GETTAGSLIBFUNCTION(TagsLibrary_GetCoverArtToFile);
		GETTAGSLIBFUNCTION(TagsLibrary_DeleteCoverArt);
		GETTAGSLIBFUNCTION(TagsLibrary_SetCoverArt);
		GETTAGSLIBFUNCTION(TagsLibrary_SetCoverArtFromFile);
		GETTAGSLIBFUNCTION(TagsLibrary_AddCoverArt);
		GETTAGSLIBFUNCTION(TagsLibrary_SetTagLoadPriority);
		GETTAGSLIBFUNCTION(TagsLibrary_GetTagData);
		GETTAGSLIBFUNCTION(TagsLibrary_SetTagData);
		GETTAGSLIBFUNCTION(TagsLibrary_GetCARTPostTimer);
		GETTAGSLIBFUNCTION(TagsLibrary_SetCARTPostTimer);
		GETTAGSLIBFUNCTION(TagsLibrary_ClearCARTPostTimer);
		GETTAGSLIBFUNCTION(TagsLibrary_GetConfig);
		GETTAGSLIBFUNCTION(TagsLibrary_SetConfig);
		GETTAGSLIBFUNCTION(TagsLibrary_GetVendor);
		GETTAGSLIBFUNCTION(TagsLibrary_SetVendor);
		GETTAGSLIBFUNCTION(TagsLibrary_GetAudioAttributes);
		GETTAGSLIBFUNCTION(TagsLibrary_GetAudioAttribute);
		GETTAGSLIBFUNCTION(TagsLibrary_GetTagSize);
		GETTAGSLIBFUNCTION(TagsLibrary_GetAudioFormat);
		GETTAGSLIBFUNCTION(TagsLibrary_GetAudioFormatMemory);

		if ((NULL == TagsLibrary_Create)
			|| (NULL == TagsLibrary_Free)
			|| (NULL == TagsLibrary_Load)
            || (NULL == TagsLibrary_LoadFromMemory)
			|| (NULL == TagsLibrary_LoadFromBASS)
			|| (NULL == TagsLibrary_Save)
			|| (NULL == TagsLibrary_SaveEx)
			|| (NULL == TagsLibrary_SaveToMemory)
			|| (NULL == TagsLibrary_SaveToMemoryEx)
			|| (NULL == TagsLibrary_FreeSaveHandle)
			|| (NULL == TagsLibrary_RemoveTag)
			|| (NULL == TagsLibrary_RemoveTagFromMemory)
			|| (NULL == TagsLibrary_Loaded)
			|| (NULL == TagsLibrary_GetTag)
			|| (NULL == TagsLibrary_GetTagEx)
			|| (NULL == TagsLibrary_GetTagByIndexEx)
			|| (NULL == TagsLibrary_SetTag)
			|| (NULL == TagsLibrary_SetTagEx)
			|| (NULL == TagsLibrary_AddTag)
			|| (NULL == TagsLibrary_AddTagEx)
			|| (NULL == TagsLibrary_TagCount)
			|| (NULL == TagsLibrary_DeleteTag)
			|| (NULL == TagsLibrary_DeleteTagByIndex)
			|| (NULL == TagsLibrary_CoverArtCount)
			|| (NULL == TagsLibrary_GetCoverArt)
			|| (NULL == TagsLibrary_GetCoverArtToFile)
			|| (NULL == TagsLibrary_DeleteCoverArt)
			|| (NULL == TagsLibrary_SetCoverArt)
			|| (NULL == TagsLibrary_SetCoverArtFromFile)
			|| (NULL == TagsLibrary_AddCoverArt)
			|| (NULL == TagsLibrary_SetTagLoadPriority)
			|| (NULL == TagsLibrary_GetTagData)
			|| (NULL == TagsLibrary_SetTagData)
			|| (NULL == TagsLibrary_GetCARTPostTimer)
			|| (NULL == TagsLibrary_SetCARTPostTimer)
			|| (NULL == TagsLibrary_ClearCARTPostTimer)
			|| (NULL == TagsLibrary_GetConfig)
			|| (NULL == TagsLibrary_SetConfig)
			|| (NULL == TagsLibrary_GetVendor)
			|| (NULL == TagsLibrary_SetVendor)
			|| (NULL == TagsLibrary_GetAudioAttributes)
			|| (NULL == TagsLibrary_GetAudioAttribute)
			|| (NULL == TagsLibrary_GetTagSize)
			|| (NULL == TagsLibrary_GetAudioFormat)
			|| (NULL == TagsLibrary_GetAudioFormatMemory)
			)
		{
				TagsLibraryDLLLoaded = FALSE;
			}
		else
		{
			TagsLibraryDLLLoaded = TRUE;
		}
	}

	return TagsLibraryDLLLoaded;
}

BOOL FreeTagsLibrary()
{
	if (NULL != TagsLibraryDLLHandle)
	{
#ifdef _WIN32
		TagsLibraryDLLLoaded = !FreeLibrary(TagsLibraryDLLHandle);
#else //* OSX
		TagsLibraryDLLLoaded = dlclose(TagsLibraryDLLHandle);
#endif
	}
	return !TagsLibraryDLLLoaded;
}

