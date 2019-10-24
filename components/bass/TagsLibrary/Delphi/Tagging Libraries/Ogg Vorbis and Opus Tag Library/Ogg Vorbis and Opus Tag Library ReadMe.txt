Ogg Vorbis and Opus Tag Library - Copyright © 2012-2015 3delite. All rights reserved.
=====================================================================================

What's the point?
=================

Ogg Vorbis and Opus Tag Library is a component for use in Win32, Win64 (9x/ME/2K/XP/Vista/7/8), OSX, iOS and Android software.
Reads and writes Opus, Vorbis and Theora comments tags (tags in Opus, Ogg Vorbis audio files and Ogg Theora video files).

Features:

- Loading of Opus, Vorbis and Theora comments tags
- Saving of Opus, Vorbis and Theora comments tags
- Removing of Opus, Vorbis and Theora comments tags
- Supports binary frames and cover pictures
- Access directly all tag datas as a TMemoryStream (full controll of the tag contents)
- ID3v2 is supported and preserved, any kind of tag at the file and too (ID3v1, APE tags)
- Full unicode support
- Pure Delphi code, no external dependencies
- Delphi XE2 64bit and OSX, Delphi XE5 iOS and Android compatible

You should also see the included example program Tutorial's source-code for example of how to use Ogg Vorbis and Opus Tag Library in your own programs.

If you are interested in ID3v1 and ID3v2 tagging unit, please follow this link:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html

If you are interested in APEv2 tagging unit, please follow this link:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/APEv2Library.html

If you are interested in MP4 tagging unit, please follow this link:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/MP4TagLibrary.html

If you are interested in Flac tagging unit, please follow this link:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/FlacTagLibrary.html

If you are interested in WMA tagging unit, please follow this link:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WMATagLibrary.html

Ogg Vorbis and Opus Tag Library is also available as a part of Tags Library:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/TagsLibrary.html


Requirements:
=============

Delphi 2009 and above.


Latest Version
==============

The latest version of Ogg Vorbis and Opus Tag Library can always be found at 3delite's website:

http://www.3delite.hu/Object Pascal Developer Resources/OpusTagLibrary.html


Copyright, Disclaimer, and all that other jazz
==============================================

This software is provided "as is", without warranty of ANY KIND, either expressed or implied, including but not limited to the implied warranties of merchantability and/or fitness for a particular purpose. The author shall NOT be held liable for ANY damage to you, your computer, or to anyone or anything else, that may result from its use, or misuse. Basically, you use it at YOUR OWN RISK.

Usage of Ogg Vorbis and Opus Tag Library indicates that you agree to the above conditions.

You may freely distribute the Ogg Vorbis and Opus Tag Library package as long as NO FEE is charged and all the files remain INTACT AND UNMODIFIED.

All trademarks and other registered names contained in the Ogg Vorbis and Opus Tag Library package are the property of their respective owners.


Ogg Vorbis and Opus Tag Library in shareware and commercial software?
=====================================================================

You can use this component in your free programs for free. If like it and use it for shareware or commercial you have to buy a license.

Shareware License: €50, for usage of the component in an unlimited number of your shareware software.

http://www.shareit.com/product.html?productid=300552311

Commercial License: €250, for usage of the component in a single commercial product.

http://www.shareit.com/product.html?productid=300552310

In all cases there are no royalties to pay, and you can use all future updates without further cost, all you need to do is just obtain the newest version.

There is a discount when purchasing Ogg Vorbis and Opus Tag Library and ID3v2 and/or APEv2 and/or MP4 Tag Library together. Please checkmark the ID3v2 Library and/or APEv2 and/or MP4 Library on the order page when purchasing Ogg Vorbis and Opus Tag Library.

If none of these licenses match your requirements, or if you have any questions, get in touch (3delite@3delite.hu).


Installation:
=============

Add the directory to the search path, and to Uses list add: OggVorbisAndOpusTagLibrary.


Notes:
======

Parsing play time and bit rate is off by default. Setting it to 'True' increases loading time a bit. You can use the global variable 'OpusTagLibraryDefaultParsePlayTime' which all newly created TOpusTag classes get, or set 'TOpusTag.ParsePlayTime' to 'True' to turn it on per instance.


Notes for Ogg Theora:
=====================

Ogg Theora video file tagging support is experimental. Please keep backup copies of files that you want to save tags to in case something goes wrong.
In case it goes, please report it and send the problematic file before using the save function on it to 3delite@3delite.hu. Thank you!


Credits
=======

C++ Builder tutorial by Robert Jackson (hsialinboy@yahoo.com)


Bug reports, Suggestions, Comments, Enquiries, etc...
=====================================================

If you have any of the aforementioned please email:

3delite@3delite.hu


History
=======

1.0.0.0 02/12/2012
------------------
First release.

1.0.1.1 03/12/2012
------------------
* Fixed loading of tags that are empty (only tag name exists)
* Rejects saving when cover art tag is found, cover pictures are not yet supported

1.0.2.2 05/12/2012
------------------
* Completly rewritten OGG stream handling
* Cover pictures are supported

1.0.3.8 09/12/2012
------------------
+ Padding support (off by default)
* Fixed a case when the tag stream was divideable by $FF

1.0.4.10 22/12/2012
-------------------
+ Reading and writing support for Ogg Vorbis audio files tags
* Fixed a case when the tag stream was divideable by $FF (again)

1.0.5.11 23/12/2012
-------------------
+ Assign() copies 'Format' attribute too
* Fixed ID3v2 detection

1.0.6.11 02/03/2013
-------------------
* Fixed loading a tag creating a debug file on C:\

1.0.8.14 01/11/2013
-------------------
+ Added function GetCoverArtInfo()
+ Added support for Delphi XE5 iOS and Android build target

1.0.9.15 01/12/2013
-------------------
* Fixed writing tag corrupting the output file

1.0.10.16 08/03/2014
--------------------
* Fixed Ogg Vorbis padding (creation of Ogg Vorbis files with random size)

2.0.11.18 15/05/2014
--------------------
+ Added option to automatically convert field names to upper-case (there is a global 'OpusTagLibraryDefaultUpperCaseFieldNamesToWrite' flag which is used when a tag object is created and also a 'TOpusTag.UpperCaseFieldNamesToWrite' to specifically set a tag object's behaviour), default is True
+ Added OpusTagErrorCode2String() function
+ Added TOpusTag.DeleteAllCoverArts function
+ Calling TOpusTagFrame.GetAsText on binary (including cover art) frame returns a string with the frame's size
+ TOpusTag.AddCoverArtFrame() now returns the new frame's index

2.0.12.19 10/06/2014
--------------------
* Fixed getting basic audio properties
* Fixed setting 'PaddingSizeToWrite' to 0

2.0.13.20 12/06/2014
--------------------
+ Added TOpusTag.Info.PlayTime
+ Added TOpusTag.Info.Samples
+ Added TOpusTag.ParsePlayTime Boolean variable (False by default, global variable is 'OpusTagLibraryDefaultParsePlayTime')

2.0.14.21 14/06/2014
--------------------
+ Added TOpusTag.Info.BitRate property

2.0.15.22 10/10/2014
--------------------
* Fixed memory leak in the load tag function

2.0.16.26 31/12/2014
--------------------
+ Added functions for loading/saving/removing tags to TStream
* Fixed memory leak in the save tag function

2.0.17.32 03/02/2015
--------------------
+ Added tag reading and writing support for Ogg Theora video files (experimental)
+ Added C++ Builder tutorial

2.0.18.34 21/04/2015
--------------------
+ Improved bit rate calculation for Vorbis and Opus files
+ Added 'TOpusTag.DeepOpusBitRateScan' flag to deep scan Opus files to parse the bit rate
