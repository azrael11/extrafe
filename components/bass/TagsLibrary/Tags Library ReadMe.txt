Tags Library - Copyright © 2014-2016 3delite. All rights reserved.
==================================================================

What's the point?
=================

Tags Library is a tag reader-writer component for Delphi (Win32, Win64, OSX, iOS and Android) and a .dll for developer environments supporting usage of Win32, Win64 or OSX32 .dlls (C++, VB, C#, VB.NET etc.).
The component reads and writes all common audio file tag formats additionaly tags in MP4 video files.

Features:

- Loading of ID3v1, ID3v2, Lyrics3, APEv1, APEv2, Flac (including Ogg Flac), Ogg Vorbis, Opus, MP4 (including video files and 64bit atom size files), WAV LIST INFO, BEXT and CART (including RF64 WAV files) and WMA tags
- Saving of ID3v1, ID3v2, Lyrics3, APEv2, Flac (including Ogg Flac), Ogg Vorbis, Opus, MP4 (including video files and 64bit atom size files), WAV LIST INFO, BEXT and CART (including RF64 WAV files) and WMA tags
- Removing of all the supported tags
- Functions for reading/writing/removing tags for a file in memory
- Bulit in support for extracting and inserting album cover pictures for all the supported tag formats
- Handle the tags transparently or call direct functions for particular tags
- Integration with BASS, load tags from BASS channel handles (local or URL streams)
- Get source audio file's attributes (MPEG, AIFF/AIFC, Flac, Ogg Vorbis, Opus, MP4, DSF, DFF, WAV, MusePack, WacPack)
- Fully unicode
- Pure Delphi code, no external dependencies (except the WMA format, which is available only on Windows), Delphi XE2 64bit and OSX, Delphi XE5 iOS and Android compatible
- .dll version provided for Win32, Win64 and OSX32 (.NET wrapper .dll also included)

You should also see the included example program Tutorial's source-code for example of how to use the library in your own programs.
Note that for the .NET examples to work (in '\.NET\Bin\' folder) you have to copy 'TagsLib.dll' and 'TagsLibraryDefs.Net.dll' into the same folder as the .exes.

The used Delphi tagging libraries are also available separatelly:

If you are interested in ID3v1 and ID3v2 tagging unit, please follow this link:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html

If you are interested in APEv2 tagging unit, please follow this link:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/APEv2Library.html

If you are interested in MP4 tagging unit, please follow this link:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/MP4TagLibrary.html

If you are interested in Ogg Vorbis and Opus Tag Library unit, please follow this link:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/OpusTagLibrary.html

If you are interested in Flac Tag Library unit, please follow this link:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/FlacTagLibrary.html

If you are interested in WMA Tag Library unit, please follow this link:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WMATagLibrary.html

If you are interested in WAV Tag Library unit, please follow this link:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WAVTagLibrary.html


Requirements:
=============

Delphi 2009 and above for the Delphi class or a developer environment supporting usage of Win32, Win64 or OSX32 .dlls.


Latest Version
==============

The latest version of Tags Library can always be found at 3delite's website:

http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/TagsLibrary.html


Support:
========

If you have any question, please use the forum: http://www.un4seen.com/forum/?topic=15754.0
or write to: 3delite@3delite.hu


Copyright, Disclaimer, and all that other jazz
==============================================

This software is provided "as is", without warranty of ANY KIND, either expressed or implied, including but not limited to the implied warranties of merchantability and/or fitness for a particular purpose. The author shall NOT be held liable for ANY damage to you, your computer, or to anyone or anything else, that may result from its use, or misuse. Basically, you use it at YOUR OWN RISK.

Usage of Tags Library indicates that you agree to the above conditions.

You may freely distribute the Tags Library package as long as NO FEE is charged and all the files remain INTACT AND UNMODIFIED.

All trademarks and other registered names contained in the Tags Library package are the property of their respective owners.


Tags Library in shareware and commercial software?
==================================================

You can use this component in your free programs for free. If like it and use it for shareware or commercial (or any other money making - advertising, in app. selling, etc.) product you have to buy a license.

Shareware License: €136, for usage of the component in an unlimited number of your shareware software.

http://www.shareit.com/product.html?productid=300627309

Commercial License: €625, for usage of the component in a single commercial product.

http://www.shareit.com/product.html?productid=300627308

For the shareware license, the product must sell for no more than €40 each. The price limit can be raised by purchasing duplicate licences, eg. 2 licences doubles it.

In all cases there are no royalties to pay, and you can use all future updates without further cost, all you need to do is just obtain the newest version.

If none of these licenses match your requirements, or if you have any questions, get in touch (3delite@3delite.hu).

If you plan using BASS in you programs (shareware or commercial), you'll also need a BASS license available separatelly from:

http://www.un4seen.com/


Installation:
=============

Add the directories to the tagging libraries ('..\Delphi\Tagging Libraries\APEv2 Library\' etc.) to the search path, and to Uses list add: TagsLibrary.


Using the component, loading tags:
==================================

TagsLibraryDefaultTagLoadPriority array holds the default values specifying the tag type preference (priority) when loading the tags (element 0 has the highest priority). These values are applied for the newly created TTags classes. So to have effect it has to be specified before creating a TTags class instance.
First create a TTags class, and then call the LoadFromFile() or the LoadFromBASS() function. If tags are found the .Loaded property is set to True.
To extract the tags you can use TTags.GetTag('TITLE') function to get the 'title' tag, returns an empty string if no such tag is present. To get more details use the TTags.Tag('TITLE') function which returns a TTag class or nil if no such tag is present. On how to iterate over the tags please see the tutorials.
To extract the cover arts, use the TTags.CoverArts[i] array, you can obtain the cover art count with TTags.CoverArtCount.
Note that the tag loading is 'joining' all the found tags by the specified preference, so if there's an ID3v1 tag with a title and there's an ID3v2 tag also with a title the title will be listed as by the ID3v2 tag's field as it has higher priority by the default TagsLibraryDefaultTagLoadPriority.
If you want to load a particular tag type directly, or access a particular tag class, you can always use the 'sub-classes', like TTags.APEv2Tag.LoadFromFile('FileName'), to read-in the tags use the TTags.LoadAPEv2Tags function after loading the tags directly.
To understand the functions and usage of these tagging 'sub-classes' please see the provided tutorials in the folders of the tagging libraries.


Saving tags:
============

The library is designed to provide the functionality to load any tag and save to any tag format after. So you can load an ID3v2 taged file and then save this tag as a Flac or MP4 tag afterwards. As much information as possible is preserved.
To set a tag field use TTags.SetTag('TITLE', 'Song title'), the TTags.SetList() function can be used to set the 'TIPL' (involved people) and 'TMCL' (musician credits) tags.
The tags can be saved automatically (default behaviour) with TTags.SaveToFile('FileName.mp3'), or explicitly specifying the tag format to be written with TTags.SaveToFile('FileName.mp3', ttID3v2) for example.


Basic steps for using the .dll version:
=======================================

1. Load the library by calling 'InitTagsLibrary'
2. Create a tags object by calling 'TagsLibrary_Create', will return the object handle to be used in the next steps
3. Call 'TagsLibrary_Load' use 'ttAutomatic' for 'TagType' and use 'True' for 'ParseTags'
4. Get tag with the function 'TagsLibrary_GetTag'/ set tag with 'TagsLibrary_SetTag'
5. To save the tag use 'TagsLibrary_Save'
6. To free the resources used by the object call 'TagsLibrary_Free'
7. When exiting the application call 'FreeTagsLibrary'


Overview of the .dll functions:
===============================

    TagsLibrary_Create: HTags;
    	Create a tag library object.
    	Return value is a handle to the object.
    
    TagsLibrary_Free(Tags: HTags): LongBool;
    	Free the object created with 'TagsLibrary_Create'.
    	Note: there's no clear function for the object, always re-create the tags library object if you want to clear it.
    
    TagsLibrary_Load(Tags: HTags; FileName: PWideChar; TagType: TTagType; ParseTags: LongBool): Integer;
    	Loads the tags from the specified 'FileName'. When 'TagType' is 'ttAutomatic' all the supported tag types are loaded (in the order specified by 'TagsLibrary_SetTagLoadPriority'), to load a particular tag type, specify 'TagType' to something other then 'ttAutomatic'.
    	To check if tags are found use the function 'TagsLibrary_Loaded'.
    	'ParseTags' should be always 'True', but if you want to load a particular tag type then this flag specifies wheather to parse the tags to be used by 'ttAutomatic'. In other words, set 'ParseTags' to 'False' if you will use for example 'ttID3v2' in all function calls (so then there's no need to parset the tags).
    	Return value is an error code, '0' means success.
    
    TagsLibrary_LoadFromMemory(Tags: HTags; MemoryAddress: Pointer; Size: UInt64; TagType: TTagType; ParseTags: LongBool): Integer;
	Load the tags from a memory "file". This function allocates 'Size' bytes to load the tags. So if the 'Size' variable is 100MB then this function will allocate another 100MBs.
	'MemoryAddress': pointer to start of data.
	'Size': size of memory object.
	Other parameters are the same as for 'TagsLibrary_Load' (see above).
	Return value is an error code, '0' means success.

    TagsLibrary_LoadFromBASS(Tags: HTags; Channel: Cardinal): Integer;
    	Load the tags from a BASS channel handle. Usefull for URL (internet) streams. But can be used for local (file) streams also. 
    	Return value is an error code, '0' means success.
    	
    TagsLibrary_Save(Tags: HTags; FileName: PWideChar; TagType: TTagType): Integer;
    	Save the tags to file specified by 'FileName'. Using 'TagType' 'ttAutomatic' will decide the format by the following:
    		- If the 'FileName' is the same as the one used for loading, the tags will be saved in all formats which were present in the source file.
    		- Try to detect the following formats: affAPE, affFlac, affOggFlac, affMPEG, affMP4, affOpus, affVorbis, affWAV, affRF64, affAIFF, affAIFC, affDFF, affDSF, affOptimFrog, affMusePack and use the usual tagging format for the detected specific format
		- If the 'FileName' is different, format will be decided by the file extension.
    	To save a particular tag type specify it with 'TagType' as eg. 'ttID3v2'.
    	Return value is an error code, '0' means success.
    
    TagsLibrary_SaveEx(Tags: HTags; FileName: PWideChar; TagType: TTagType): Integer;
    	Save the tags without conversion ('ParseTag' and tags set with 'ttAutomatic' option will not have effect). Usefull if you want to work with a particular tag type.
    	Return value is an error code, '0' means success.
    
    TagsLibrary_SaveToMemory(Tags: HTags; MemoryAddress: Pointer; Size: UInt64; TagType: TTagType; var SavedAddress: Pointer; var SavedSize: UInt64; var SaveHandle: Pointer): Integer;
	Save the tags to a file in memory. This function allocates 'Size' bytes to save the tags and if the new tag doesn't fit in the file, it will allocate 'Size' bytes again. So if the 'Size' variable is 100MB then this function might allocate another 200MBs.
	'MemoryAddress': pointer to start of data.
	'Size': size of memory object.
	'TagType': if 'tcAutomatic' then try to detect the following formats: affAPE, affFlac, affOggFlac, affMPEG, affMP4, affOpus, affVorbis, affWAV, affRF64, affAIFF, affAIFC, affDFF, affDSF, affOptimFrog, affMusePack and use the usual tagging format for the detected specific format
	'SavedAddress': pointer to the saved "file" object. Is nil (null) on error.
	'SavedSize': size of the new object. Is '0' on error.
	'SaveHandle': use this handle with 'TagsLibrary_FreeSaveHandle' to free the saved object.

    TagsLibrary_SaveToMemoryEx(Tags: HTags; MemoryAddress: Pointer; Size: UInt64; TagType: TTagType; var SavedAddress: Pointer; var SavedSize: UInt64; var SaveHandle: Pointer): Integer; 
	Save a specific tag type directly (same as 'TagsLibrary_SaveEx') to a file in memory.
	Parameters and usage is the same as with 'TagsLibrary_SaveToMemory' above.

    TagsLibrary_FreeSaveHandle(var SaveHandle: Pointer): Integer;
	Free the generated (tagged) saved object. It is needed to free the save handle to free memory allocated for the in-memory saving.
    	Return value is an error code, '0' means success.

    TagsLibrary_RemoveTag(FileName: PWideChar; TagType: TTagType): Integer;
    	Remove all tags from 'FileName', to delete a particular tags type set it with 'TagType'.
    	Return value is an error code, '0' means success.

    TagsLibrary_RemoveTagFromMemory(Tags: HTags; MemoryAddress: Pointer; Size: UInt64; TagType: TTagType; var SavedAddress: Pointer; var SavedSize: UInt64; var SaveHandle: Pointer): Integer;
    	Remove all tags from memory "file", to delete a particular tags type set it with 'TagType'.
	'MemoryAddress': pointer to start of data.
	'Size': size of memory object.
	'TagType': 'tcAutomatic' is not supported, specify a tag format explicitly.
	'SavedAddress': pointer to the saved "file" object. Is nil (null) on error.
	'SavedSize': size of the new object. Is '0' on error.
	'SaveHandle': use this handle with 'TagsLibrary_FreeSaveHandle' to free the saved object.
    	Return value is an error code, '0' means success.
    
    TagsLibrary_GetTag(Tags: HTags; Name: PWideChar; TagType: TTagType): PWideChar;
    	Get a pointer to a unicode (wide) string tag specified by 'Name' (for example 'TITLE').
    	Return value is pointing to an empty string if no such tag found.  
    
    TagsLibrary_Loaded(Tags: HTags; TagType: TTagType): LongBool;
    	Test if tags are loaded. If 'TagType' is 'ttAutomatic' then the return value is 'False' if no tag exists in the file at all, 'True' otherwise.
    	
    TagsLibrary_GetTagEx(Tags: HTags; Name: PWideChar; TagType: TTagType; ExtTag: Pointer): LongBool;
    	Get extended (detailed) information about a tag. Usefull for 'ttID3v2' TXXX, WXXX, COMM frames and MP4 tags.
    	Return value is 'False' if no tag specified by 'Name' (eg. 'TITLE') is present in the tags.
              'TagType' values need a specific 'ExtTag' pointer to different structures:
              	ttAutomatic: 'ExtTag'  needs to point to a 'TExtTag' structure.
		ttAPEv2: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttFlac: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttID3v1: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttID3v2: 'ExtTag'  needs to point to a 'TID3v2TagEx' structure.
		ttMP4: 'ExtTag'  needs to point to a 'TMP4TagEx' structure.
		ttOpusVorbis: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttWAV: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttWMA: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
	Always clear (zero memory) the 'TagType' structures before calling this function with it.
	Set 'TID3v2TagEx.TagType' to extract ID3v2 tags using a concrete format before calling this function. Seting it to 'id3v2ttUnknown' (0) uses automatically choosen format.
    
    TagsLibrary_GetTagByIndexEx(Tags: HTags; Index: Integer; TagType: TTagType; ExtTag: Pointer): LongBool;
    	Same as 'TagsLibrary_GetTagEx' just get the tag details by index. To iterate over all the tags use the 'TagsLibrary_TagCount' function and this function in a for loop.
    	Return value is 'False' if 'Index' is invalid.
              'TagType' values need a specific 'ExtTag' pointer to different structures:
              	ttAutomatic: 'ExtTag'  needs to point to a 'TExtTag' structure.
		ttAPEv2: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttFlac: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttID3v1: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttID3v2: 'ExtTag'  needs to point to a 'TID3v2TagEx' structure.
		ttMP4: 'ExtTag'  needs to point to a 'TMP4TagEx' structure.
		ttOpusVorbis: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttWAV: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttWMA: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
	Always clear (zero memory) the 'TagType' structures before calling this function with it.
	Set 'TID3v2TagEx.TagType' to extract ID3v2 tags using a concrete format before calling this function. Seting it to 'id3v2ttUnknown' (0) uses automatically choosen format.
    
    TagsLibrary_SetTag(Tags: HTags; Name: PWideChar; Value: PWideChar; TagType: TTagType): LongBool; 
    	Simply set a tag specified by 'Name' to value specified by 'Value'. If there's already a field with the specified name it will be replaced with the new value.
    	When using with a particular tag type, eg. 'ttID3v2', 'Name' specifies an ID3v2 frame type, eg. 'TIT2' (which is title), or an MP4 tag atom name, for example '©ART' (artist).
    	Return value is 'True' on success.
    
    TagsLibrary_SetTagEx(Tags: HTags; TagType: TTagType; ExtTag: Poiter): LongBool;
    	Set a tag with extended (detailed) attributes. 'ExtTag.Name' specifies the tag's name, an ID3v2 frame type, eg. 'TIT2' (which is title), or an MP4 tag atom name, for example '©ART' (artist).
    	ExtTag.ValueSize specifies ExtTag.Value length in bytes.
	For using it in 'ttAutomatic' mode, use 'ExtTag.Name' as 'TITLE'.
    	This function is mostly usefull for 'ttID3v2' WXXX and TXXX frames and MP4 tags.
              'TagType' values need a specific 'ExtTag' pointer to different structures:
              	ttAutomatic: 'ExtTag'  needs to point to a 'TExtTag' structure.
		ttAPEv2: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttFlac: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttID3v1: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttID3v2: 'ExtTag'  needs to point to a 'TID3v2TagEx' structure.
		ttMP4: 'ExtTag'  needs to point to a 'TMP4TagEx' structure.
		ttOpusVorbis: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttWAV: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttWMA: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
	Always clear (zero memory) the 'TagType' structures before calling this function with it.
    	Return value is 'True' on success.
    
    TagsLibrary_AddTag(Tags: HTags; Name: PWideChar; Value: PWideChar; TagType: TTagType): Integer;
    	Add a tag specified by 'Name' to value specified by 'Value'. If there's already a field with the specified name a new one will added, and the previous is preserved.
    	When using with a particular tag type, eg. 'ttID3v2', 'Name' specifies an ID3v2 frame type, eg. 'TIT2' (which is title), or an MP4 tag atom name, for example '©ART' (artist). 
    	But be carefull because eg. MP4 tags canot contain multiple atoms of the same type.
    	Return value is 'True' on success.    
    
    TagsLibrary_AddTagEx(Tags: HTags; TagType: TTagType; ExtTag: Pointer): Integer; 
    	Add a tag with extended (detailed) attributes. 'ExtTag.Name' specifies the tag's name, an ID3v2 frame type, eg. 'TIT2' (which is title), or an MP4 tag atom name, for example '©ART' (artist).
	ExtTag.ValueSize specifies ExtTag.Value length in bytes.    	
	For using it in 'ttAutomatic' mode, use 'ExtTag.Name' as 'TITLE'.
    	This function is mostly usefull for 'ttID3v2' WXXX and TXXX frames and MP4 tags.
              'TagType' values need a specific 'ExtTag' pointer to different structures:
              	ttAutomatic: 'ExtTag'  needs to point to a 'TExtTag' structure.
		ttAPEv2: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttFlac: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttID3v1: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttID3v2: 'ExtTag'  needs to point to a 'TID3v2TagEx' structure.
		ttMP4: 'ExtTag'  needs to point to a 'TMP4TagEx' structure.
		ttOpusVorbis: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttWAV: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
		ttWMA: 'ExtTag'  needs to point to a 'TSimpleTag' structure.
	Always clear (zero memory) the 'TagType' structures before calling this function with it.
    	Return value is 'True' on success.   
    	
    TagsLibrary_TagCount(Tags: HTags; TagType: TTagType): Integer; 
    	Retrieve the tag count for the specified 'TagType' tag type.
    	Note that for example for ID3v2 tags the cover art is also a tag (frame) so will be included in the return value.
    
    TagsLibrary_DeleteTag(Tags: HTags; Name: PWideChar; TagType: TTagType): LongBool;
	Delete the first occurance of tag specified by 'Name'.
	Result is 'False' if no such tag found.

    TagsLibrary_DeleteTagByIndex(Tags: HTags; Index: Integer; TagType: TTagType): LongBool;
	Delete the tag specified by 'Index'.
	Result is 'False' if 'Index' is out of bounds.

    TagsLibrary_CoverArtCount(Tags: HTags; TagType: TTagType): Integer;
    	Retrieve the cover art count for the 'TagType'.
    	
    TagsLibrary_GetCoverArt(Tags: HTags; TagType: TTagType; Index: Integer; var CoverArt: TCoverArtData): LongBool;
    	Extract the cover art specified by 'Index' into the 'CoverArt' structure.
    	'CoverArt.Data' points to the cover art data bytes, 'CoverArt.DataSize' specifies the data size. You can use 'CoverArt.MIMEType' or 'CoverArt.PictureFormat' to identify the cover art picture format.
    	Return value is 'True' on success.	
    
    TagsLibrary_GetCoverArtToFile(Tags: HTags; TagType: TTagType; Index: Integer; FileName: PChar): LongBool; 
	Extract a cover art specified by 'Index' and save to a file specified by 'FileName'.

    TagsLibrary_DeleteCoverArt(Tags: HTags; TagType: TTagType; Index: Integer): LongBool; 
    	Delete a cover art specified by 'Index'. Use 'TagsLibrary_CoverArtCount' to check how many cover arts are in the tag.
    	Return value is 'True' on success.
    	
    TagsLibrary_SetCoverArt(Tags: HTags; TagType: TTagType; Index: Integer; var CoverArt: TCoverArtData): LongBool;
    	Set cover art specified by 'Index'.
    	Try to fill in all the attributes in 'CoverArt', although not all are needed for all the tag types.
    	Return value is 'True' on success.
    	
    TagsLibrary_SetCoverArtFromFile(Tags: HTags; TagType: TTagType; Index: Integer; FileName: PChar; CoverArt: TCoverArtData): LongBool;
    	Set cover art specified by 'Index' from file specified by 'FileName'
	Before calling this function add a cover art with the TagsLibrary_AddCoverArt() function with CoverArt.Data = nil and CoverArt.DataSize = 0 and use the 'Index' returned.
    	Try to fill in all the attributes in 'CoverArt', although not all are needed for all the tag types.
    	Return value is 'True' on success.

    TagsLibrary_AddCoverArt(Tags: HTags; TagType: TTagType; var CoverArt: TCoverArtData): Integer;
    	Add a new cover art.
    	Try to fill in all the attributes in 'CoverArt', although not all are needed for all the tag types.
    	Return value is 'True' on success.    
    
    TagsLibrary_SetTagLoadPriority(Tags: HTags; TagPriorities: TTagPriority): LongBool;
    	Set the tag loading priority array. The value in 'TagPriorities[0]' has the highest priority.
    	Use 'Tags' = 'nil' or 'null' to set the global tag load priority. All tag library classes created after calling this function will use these settings.
    	Return value should be always 'True'.
    	
    TagsLibrary_GetTagData(Tags: HTags; Index: Integer; TagType: TTagType; var TagData: TTagData): LongBool;
    	Get binary data of a tag frame. Usefull for ID3v2 GEOB, etc. binary frames and MP4 binary atoms.
    	When using 'TagType' = 'ttMP4', 'TagData.DataType' is for example:
    		0: binary
	        1: text
	        13: cover art
	        14: cover art
                21: binary
       	Return value is 'True' on success.
    
    TagsLibrary_SetTagData(Tags: HTags; Index: Integer; TagType: TTagType; TagData: TTagData): LongBool; 
    	Set binary data of a tag frame. Usefull for ID3v2 GEOB, APEv2 binary frames, etc. and MP4 tags.
    	When using 'TagType' = 'ttMP4', 'TagData.DataType' is needed for example:
    		0: binary
	        1: text
	        13: cover art
	        14: cover art
                21: binary
       	Return value is 'True' on success.

    TagsLibrary_GetCARTPostTimer(Tags: HTags; Index: Integer; var PostTimer: TCARTPostTimer): LongBool;
	Get WAV CART post timer specified by 'Index'. There are 8 CART post timers, Index range is 0 to 7.
	Result is 'False' if 'Index' is out of bounds.

    TagsLibrary_SetCARTPostTimer(Tags: HTags; Index: Integer; PostTimer: TCARTPostTimer): LongBool;
	Set WAV CART post timer specified by 'Index'. There are 8 CART post timers, Index range is 0 to 7.
	Result is 'False' if 'Index' is out of bounds.

    TagsLibrary_ClearCARTPostTimer(Tags: HTags; Index: Integer): LongBool;
	Clear WAV CART post timer specified by 'Index'. There are 8 CART post timers, Index range is 0 to 7.
	Result is 'False' if 'Index' is out of bounds.

    TagsLibrary_GetConfig(Tags: TTags; Option: Integer; TagType: TagsLibrary.TTagType): Pointer;
	Return value is 0 = False, non-zero value is True. Options listed below.
    TagsLibrary_SetConfig(Tags: HTags; Value: Pointer; Option: Integer; TagType: TTagType): LongBool;
	Get and set configuration settings. If 'Tags' = nil then means global parameters.
	'Option' can be:
		TAGSLIBRARY_PADDING_SIZE_TO_WRITE: set padding size to write when saving the tags. When set as global, setting will affect all newly created Tags objects.
		TAGSLIBRARY_PARSE_OGG_PLAYTIME: set getting of Ogg Vorbis and Opus audio file's play time. Setting to 'True' results longer loading time. Default is 'True'. When set as global, setting will affect all newly created Tags objects.
		TAGSLIBRARY_PARSE_ID3v2_AUDIO_ATTRIBUTES: set getting of MPEG, WAV, AIFF/AIFC, DSD .dsf audio file's attributes. Setting to 'False' results quicker loading. Default is 'True'. When set as global, setting will affect all newly created Tags objects.
                            TAGSLIBRARY_MP4TAG_KEEP_PADDING: set to preserve padding (add as much as needed to fit the new tag) or always write 'TAGSLIBRARY_PADDING_SIZE_TO_WRITE' value padding.
    		TAGSLIBRARY_PARSE_WAVPACK_AUDIO_ATTRIBUTES: set getting of WavPack audio file's attributes. Setting to 'False' results quicker loading. Default is 'False'. When set as global, setting will affect all newly created Tags objects.
    		TAGSLIBRARY_PARSE_MUSEPACK_AUDIO_ATTRIBUTES: set getting of MusePack audio file's attributes. Setting to 'False' results quicker loading. Default is 'False'. When set as global, setting will affect all newly created Tags objects.
		TAGSLIBRARY_DEEP_OPUS_BITRATE_SCAN: set deep scanning of Opus audio files and get true w/o overhead bit rate. Results slower loading of Opus audio files, default is 'False'.

    TagsLibrary_GetVendor(Tags: HTags; TagType: TTagType): PWideChar;
    TagsLibrary_SetVendor(Tags: HTags; Vendor: PWideChar; TagType: TTagType): LongBool;
	Get and set vendor string. Applies to Ogg Vorbis, Opus and Flac.
	Return value is nil/False otherwise.

    TagsLibrary_GetAudioAttributes(Tags: HTags; AudioType: TAudioType; Attributes: Pointer): LongBool;
	Get source audio file's attributes.
	Supported 'AudioTypes's:
	    atAutomatic: expects and returns a 'TAudioAttributes' structure (automatic source detection) in 'Attributes'
	    atFlac: expects and returns a 'TFlacAudioAttributes' structure (Flac and Ogg Flac) in 'Attributes'
	    atMPEG: expects and returns a 'TMPEGAudioAttributes' structure (.mp3, .mp2, .mp1, .mpa) in 'Attributes'
	    atDSDDSF: expects and returns a 'TDSFAudioAttributes' structure (DSD .dsf) in 'Attributes'
            atMP4: expects and returns a 'TMP4AudioAttributes' structure (MP4 audio) in 'Attributes'
	    atOpus: expects and returns a 'TOpusAudioAttributes' structure (Opus) in 'Attributes'
	    atVorbis: expects and returns a 'TVorbisAudioAttributes' structure (Vorbis) in 'Attributes'
	    atWAV: expects and returns a 'TWAVEAudioAttributes' structure (WAV and RF64) in 'Attributes'
	    atAIFF: expects and returns a 'TAIFFAudioAttributes' structure (AIFF and AIFC) in 'Attributes'
	    atWMA: expects and returns a 'TWMAAudioAttributes' structure (WMA) in 'Attributes'
            atWAVPack: expects and returns a 'TWAVPackAttributes' structure (WV) in 'Attributes'
            atMusePack: expects and returns a 'TMusePackAttributes' structure (MPC) in 'Attributes'
	    atDSDDFF: expects and returns a 'TDFFAudioAttributes' structure (DSD .dff) in 'Attributes'

    TagsLibrary_GetTagSize(Tags: HTags; TagType: TTagType): DWord;
	Get size of the specified tag.
	if TagType = ttAutomatic then retrieve sum size of all tags present in the file.

    TagsLibrary_GetAudioFormat(FileName: PChar): TAudioFileFormat;
        	Determine audio file format of the specified file name.

    TagsLibrary_GetAudioFormatMemory(MemoryAddress: Pointer; Size: UInt64): TAudioFileFormat;
	Determine audio file format of the specified "memory" file.


WAV BEXT and CART tags (.dll version):
======================================

To set BEXT and CART tags use the 'TagsLibrary_SetTag()' function with TagType = ttWAV, available 'Name' fields:

    'BEXT Description'
    'BEXT Originator'
    'BEXT OriginatorReference'
    'BEXT OriginationDate'
    'BEXT OriginationTime'
    'BEXT TimeReference'
    'BEXT Version'
    'BEXT UMID'
    'BEXT CodingHistory'

    'CART Version'
    'CART Title'
    'CART Artist'
    'CART CutID'
    'CART ClientID'
    'CART Category'
    'CART Classification'
    'CART OutCue'
    'CART StartDate'
    'CART StartTime'
    'CART EndDate'
    'CART EndTime'
    'CART ProducerAppID'
    'CART ProducerAppVersion'
    'CART UserDef'
    'CART LevelReference'
    'CART PostTimer' - use as 'CART PostTimer0' through 'CART PostTimer7' with two values (for example 'MRK1 222') separated by a space character.
    'CART URL'
    'CART Reserved'
    'CART TagText'


Notes for custom MP4 tags:
==========================

To add custom MP4 tags, use '----' as atom name, and set 'name' value to your ID, like 'CUST' and standard 'mean' value is 'com.apple.iTunes'.


Notes for the .dll version:
===========================

All pointers to tag data are valid only until changing the tag (setting the particular value, or loading new data), or as long as the tags library class is valid, so copy the returned strings if you need them afterwards.


Notes for WMA support:
======================

As WMA is supported through WMVCORE.DLL which is part of Windows, WMA reading/writing is only supported on the Windows platform.


Credits
=======

C++ Builder tutorial by Robert Jackson (hsialinboy@yahoo.com)
.NET wrapper .dll and C#, VB.NET tutorial by EWeiss (http://www.un4seen.com/)


Bug reports, Suggestions, Comments, Enquiries, etc...
=====================================================

If you have any of the aforementioned please email:

3delite@3delite.hu


History
=======

0.1.3.4 08/05/2014
------------------
First alpha release.

0.1.5.5 11/05/2014
------------------
Second alpha release with compiled Win32, Win64 and OSX32 .dll.

0.1.6.4 12/05/2014
------------------
First beta release.

0.2.7.7 14/05/2014
------------------
Second beta release.

0.3.9.8 20/05/2014
------------------
Third beta release.

0.4.9.9 23/05/2014
------------------
4th beta release.
+ Added TagsLibrary_GetCARTPostTimer(), TagsLibrary_SetCARTPostTimer() and TagsLibrary_ClearCARTPostTimer() functions

1.0.10.10 27/05/2014
------------------
First stable release.

1.0.11.11 29/05/2014
------------------
* Fixed WAV tag reading and writing of ANSI field values with extended characters

1.0.12.12 30/05/2014
------------------
+ Improved WAV tags UTF8 field values setting
* Fixed WAV RF64 tag writing support

1.0.13.13 06/06/2014
------------------
+ Support of DSD .dsf audio files (ID3v2)

1.0.14.14 10/06/2014
------------------
+ Added DSD .dsf audio file attributes parsing (Delphi class)
+ Added TagsLibrary_GetConfig() and TagsLibrary_SetConfig() functions (.dll version)
+ Added TagsLibrary_GetVendor() and TagsLibrary_SetVendor() functions (.dll version)
+ Added TagsLibrary_GetAudioAttributes() (.dll version)

1.0.15.15 12/06/2014
------------------
+ Added new config option TAGSLIBRARY_PARSE_OGG_PLAYTIME (.dll version), 'TagsLibraryParseOggPlayTime' (Delphi class)
+ Added 'PlayTime' and 'SampleCount' to TOpusTag.Info (Delphi class)
+ Added 'PlayTime' and 'SampleCount' to TagsLibrary_GetAudioAttributes() with 'ttVorbis' and 'ttOpus' (.dll version)
+ Added TWAVTag.Attributes and TWAVTag.PlayTime and TWAVTag.SampleCount (Delphi class)
+ Added TTags.SourceAudioAttributes class (Delphi class)
+ Added 'ttWAV' support for TagsLibrary_GetAudioAttributes() (.dll version)
* Fixed TagsLibrary_GetAudioAttributes() (.dll version)

1.0.16.22 14/06/2014
------------------
+ Added MPEG, AIFF/AIFC, WAV attributes to TID3v2Tag (Delphi class)
+ Added 'ttAIFF', 'ttMPEG' and 'ttWMA' support for TagsLibrary_GetAudioAttributes() (.dll version)

1.0.17.23 16/06/2014
------------------
+ Added 'TAGSLIBRARY_PARSE_ID3v2_AUDIO_ATTRIBUTES' config option (.dll version)

1.0.18.24 18/06/2014
------------------
+ Modified all structure members to return at least a DWord (.dll version)
+ Updated C++ header file (.dll version)
+ Updated VB header file (.dll version)

1.0.19.25 28/06/2014
------------------
* Fixed ID3v2 Library nextgen (Android/iOS) compile, won't read AIFF/AIFC files' sample rate though (no extended (10 byte float) support in nextgen)
* Fixed WAV tag processing with >4GB files

1.0.20.31 17/07/2014
------------------
+ Cover art 'PictureFormat' is now determined from the first 2 bytes of the picture data, so it will be more precise than checking the returned mimetype (which can occasionaly report false values)
* Fixed C++ header files
+ Added a simple console test tutorial app. with source code (C++)

1.0.21.32 26/07/2014
------------------
* Fixed WMA track value

1.0.22.37 06/09/2014
------------------
+ Added support for multiple tags of the same type

1.0.23.38 10/10/2014
------------------
* Fixed memory leak in Ogg load tag function
* Fixed memory leak in WMA load tag function
* Fixed clearing TRACKNUMBER for ID3v1 tag

1.0.24.39 17/11/2014
------------------
* Fixed reading ID3v2 UTF-8 TXXX frames

1.0.25.40 30/11/2014
------------------
+ To get MPEG file information for the ID3v2 tag, the next 4096 bytes are scanned for a valid MPEG frame after the ID3v2 tag
* Fixed memory leak in free WMA tag class function

1.0.26.41 10/12/2014
------------------
+ Completely re-written MP4 tag writing
* Fixed memory leak in the Ogg save tag function
* Fixed platform compiler warning for Flac and Ogg unit

1.0.27.42 12/12/2014
------------------
* Fixed loading of APE tags with 0 length field values
* Fixed APE tags GetAsText functions with illegal UTF-8 field values, for the second try now thay are read as ANSI

1.0.28.43 16/12/2014
------------------
* Fixed 'Corrupted MP4 file' error for non-MP4 files when loading tags

1.0.29.49 19/12/2014
------------------
+ .dll version: modified all tag get/set "Ex" functions to work with specific tag data structures, see the usage above
* .dll version: fixed TagsLibrary_GetCoverArt() 'PictureFormat' with 'ttID3v2' and 'ttFlac'

1.0.30.53 31/12/2014
------------------
+ New functions for reading and writing and removing tags from/to memory
+ Added support for DSD tags for the BASS channel handle loader

1.0.31.54 05/01/2015
------------------
+ Added file format (and thus tag format) detection for the save functions for tcAutomatic mode

1.0.32.55 22/01/2015
------------------
+ Added functions for getting/setting MP4 list tags (TIPL, TMCL)
* Fixed setting ID3v2 COMMENT tag
* Fixed TagsLibrary_GetTagData() function

1.0.33.56 03/02/2015
------------------
+ Added parsing of MP4 play time (TMP4Tag.Playtime)
+ Added parsing of MP4 audio attributes
* Fixed MP4 atom data delete function
+ Added tag reading and writing support for Ogg Theora video files (experimental)
* Fixed issues related to WMA tag stream indexes

1.0.34.58 08/02/2015
------------------
+ Added support of TIPL and TMCL for all tag formats
* Fixed writing MP4 atoms with empty name
* Fixed VB header file

1.0.35.60 11/02/2015
------------------
+ Converting tags to MP4 now transfers all unknown fields to '----' atoms
+ Added functions for managing MP4 tag '----' atoms (Delphi class)
* Fixed field names managing is now case insensitive

1.0.36.61 18/02/2015
------------------
+ Added support of parsing ID3v2 'POPM' rating value (tag named 'RATING')
+ MP4 '----' atoms (GetCommon/SetCommon function) parameters are searched case insensitive
+ Added TagsLibrary_GetAudioAttribute() function (.dll version)
* Fixed AV when parsing cover art tags with 0 size data

1.0.37.67 23/02/2015
------------------
+ Added audio attributes parsing for WavPack and MusePack files
+ Added TagsLibrary_GetTagSize() for the .dll version
+ Added TagsLibrary_GetAudioFormat() and TagsLibrary_GetAudioFormatMemory() functions for the .dll version
* All records are packed, as needed for VB
* All enums are 4 bytes
* Fixed ID3v2 POPM parsing with non-default value

1.0.37.68 23/02/2015
------------------
+ Added TagsLibrary_GetCoverArtToFile() and TagsLibrary_SetCoverArtFromFile() functions for the .dll version

1.0.38.69 25/02/2015
------------------
* Fixed TMPEGAudioAttributes.ModeExtension when not avialable
* Improvements to the VB header

1.0.39.74 28/02/2015
------------------
+ Added audio attribute parsing for MusePack, and WavPack files
* Fixed deleting tags for MP4 '----' atom tags
* Improvements to the VB header
+ Added VB tutorial for loading cover arts

1.0.40.75 01/04/2015
------------------
+ Speed-up for the 'read from memory' functions, now the data is not copied into a TMemoryStream class but used directly (.dll version)
+ Speed-up for the set cover art function, now the data is not copied into a TMemoryStream class but read directly from the file or from the memory location (.dll version)
+ Added LoadFromMemory() function for the Delphi class

1.0.41.76 19/04/2015
------------------
* Fixed writing ID3v2 tags with multiple frames with the same ID (on saving duplicates are removed now)
* Fixes and improvements for the .NET wrapper

1.0.42.78 21/04/2015
------------------
+ Improved bit rate calculation for Vorbis and Opus files
+ Added 'TAGSLIBRARY_DEEP_OPUS_BITRATE_SCAN' config option to deep scan Opus files to parse the bit rate
* Fixed parsing MPEG audio attributes when there is no ID3v2 tag in the file
* Fixes and improvements for the .NET wrapper

1.0.43.80 24/04/2015
------------------
* Fixed loading of big endian unicode ID3v2 tags
* Fixed APEv2 and MP4 cover arts are now classified as cover type 3 (front cover)
* Fixes and improvements for the .NET wrapper and tutorial
* Fixed missing 'atWAVPack' and 'atMusePack' enums from the VB header

1.0.44.81 25/04/2015
------------------
* Fixed infinite loop for unicode tags in ID3v2 GetUnicodeUserDefinedTextInformation() introduced with the previous update
* Fixed loading of (type 2) big endian unicode ID3v2 tags
* Fixes and improvements for the .NET wrapper .dll and tutorial

1.0.45.82 02/09/2015
------------------
* Fixed saving ID3v2 tags to file if there is no existing ID3v2 tag in the file

1.0.46.84 03/10/2015
--------------------
* Fixed APE tags, on tag value convert error frame is reported as binary
* Fixed FLAC tags writing padding bytes slow-down
* Fixed MP4 tags writing padding bytes slow-down
* Fixed writing WMA tags, multiple same field name values

1.0.47.85 12/10/2015
--------------------
* Fixed array overrun bug when loading tags in some cases
* Fixed range check errors for ID3v2

1.0.48.86 18/03/2016
--------------------
* Fixed C++ header TagsLibrary_GetConfig() function and the description in this ReadMe

1.0.49.88 06/05/2016
--------------------
+ Improvements in APE tag parsing (more error tolerant)
* Fixed loading an APEv1 tag and saving it (as APEv2 - ANSI to UTF8 conversion should be fixed now)

1.0.50.89 20/05/2016
--------------------
* Fixed RemoveID3v2TagFromStream() and related functionality

1.0.51.90 22/05/2016
--------------------
+ Added support of tagging (read/write/remove) .DFF files with ID3v2

1.0.52.92 08/06/2016
--------------------
+ Added function 'TTags.Clear(Name: String)' to remove all tags by the specified field name
* Fixed ID3v2 getting multiple values

1.0.53.93 16/06/2016
--------------------
+ Improved ID3v2 Tag Library .DFF audio attributes parsing
* Fixed TID3v2Tag.GetSEFC()
* Fixed loading WAV tags when no LIST INFO chunk is present in the file

1.0.54.94 08/09/2016
--------------------
* Fixed WMA tag loading exception when TRACKNUMBER is not an integer
