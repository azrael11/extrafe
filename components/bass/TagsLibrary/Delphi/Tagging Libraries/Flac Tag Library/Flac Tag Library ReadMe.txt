Flac Tag Library - Copyright © 2013-2015 3delite. All rights reserved.
=================================================================

What's the point?
=================

Flac Tag Library is a component for use in Win32 (9x/ME/2K/XP/Vista/7/8), Win64, OSX, iOS and Android software.
Reads and writes Flac vorbis comments tags (tags in Flac and Ogg Flac audio files).

Features:

- Loading of Flac tags
- Saving of Flac tags
- Removing of Flac tags
- Ogg Flac audio files are also supported
- Supports managing cover pictures
- ID3v2 is supported and preserved, any kind of tag at the file and also (ID3v1, APE tags)
- Full unicode support
- Pure Delphi code, no external dependencies
- Delphi XE2 64bit and OSX, Delphi XE5 iOS and Android compatible

You should also see the included example program Tutorial's source-code for example of how to use Flac Tag Library in your own programs.

If you are interested in ID3v1 and ID3v2 tagging unit, please follow this link:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html

If you are interested in APEv2 tagging unit, please follow this link:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/APEv2Library.html

If you are interested in MP4 tagging unit, please follow this link:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/MP4TagLibrary.html

If you are interested in Ogg Vorbis and Opus Tag Library unit, please follow this link:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/OpusTagLibrary.html

If you are interested in WMA Tag Library unit, please follow this link:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WMATagLibrary.html


Requirements:
=============

Delphi 2009 and above.


Note:
=====

In case of native Flac when the meta data block size is not changed the meta data block is not saved. So if for example when the order of cover arts is changed, which doesn't change the size of the meta data block, set ForceReWrite to True to force re-writing the meta data block.


Latest Version
==============

The latest version of Flac Tag Library can always be found at 3delite's website:

http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/FlacTagLibrary.html


Copyright, Disclaimer, and all that other jazz
==============================================

This software is provided "as is", without warranty of ANY KIND, either expressed or implied, including but not limited to the implied warranties of merchantability and/or fitness for a particular purpose. The author shall NOT be held liable for ANY damage to you, your computer, or to anyone or anything else, that may result from its use, or misuse. Basically, you use it at YOUR OWN RISK.

Usage of Flac Tag Library indicates that you agree to the above conditions.

You may freely distribute the Flac Tag Library package as long as NO FEE is charged and all the files remain INTACT AND UNMODIFIED.

All trademarks and other registered names contained in the Flac Tag Library package are the property of their respective owners.


Flac Tag Library in shareware and commercial software?
======================================================

This unit is based on ATL's FlacFile class but many new features were added, specially full support for managing cover arts and full support of Ogg Flac files.
As the original unit is LGPL licensed you are entitled to use it for free given the LGPL license terms.
If you are using the cover art managing functions (read and/or write) and/or Ogg Flac functions you can use it for free for free programs/projects (non money making use) but for shareware or commerical programs (or money making) you need one of the following licenses:

Shareware License: €25, for usage of the component in an unlimited number of your shareware software.

http://www.shareit.com/product.html?productid=300576722

Commercial License: €100, for usage of the component in a single commercial product.

http://www.shareit.com/product.html?productid=300576720

In all cases there are no royalties to pay, and you can use all future updates without further cost, all you need to do is just obtain the newest version.

There is a discount when purchasing Flac Tag Library and ID3v2 and/or APEv2 and/or MP4 Tag Library and/or Ogg Vorbis and Opus Tag Library together. Please checkmark the ID3v2 Library and/or APEv2 and/or MP4 Library and/or Ogg Vorbis and Opus Tag Library on the order page when purchasing Flac Tag Library.

If none of these licenses match your requirements, or if you have any questions, get in touch (3delite@3delite.hu).


Installation:
=============

Add the directory to the search path, and to Uses list add: FlacTagLibrary.


Credits
=======

C++ Builder tutorial by Robert Jackson (hsialinboy@yahoo.com)


Bug reports, Suggestions, Comments, Enquiries, etc...
=====================================================

If you have any of the aforementioned please email:

3delite@3delite.hu


History
=======

2.0.0.1 07/02/2013
------------------
First release.

2.0.1.2 24/03/2013
------------------
+ Added Delete function for tag objects
+ If SetText() is called with an empty value the tag frame is deleted
+ Added new functions GetCoverArtInfo() and CoverArtCount()
* Fixed opening file for save when it is allocated already (eg. playback)
* Fixed Tutorial file dialogs

2.0.2.6 06/04/2013
------------------
+ Faster loading of tags
+ Fixed reading fields larger then 8192 bytes
* Fixed reading of tag which has a 0 length vendor or tag string

2.0.3.8 11/04/2013
------------------
* Fixed reading tags bug introduced in the previous version

2.0.4.9 20/04/2013
------------------
* Fixed re-writing the tag in most cases even when not needed

2.0.5.20 09/05/2013
-------------------
+ Added full support of reading/saving of Ogg Flac tags
* Fixed possible bug when adding cover arts
* Fixed error return value when file couldn't be opened

2.0.6.22 11/05/2013
-------------------
* Fixed loading of files with a 0 length meta block

2.0.9.27 02/11/2013
-------------------
* Added support for Delphi XE5 iOS and Android build target
* Fixed adding a space character after the tag field value
* Fixed all hints and warnings (for iOS/Android)

2.0.9.28 24/02/2014
-------------------
* Fixed SetCoverArt() function

2.0.10.29 08/03/2014
--------------------
+ When saving the tag and the new tag + padding is smaller then the existing tag, the tag is re-written with new padding (this means if for example a large cover art is removed the new file size will be smaller)

2.0.10.31 10/04/2014
--------------------
+ Added option to automatically convert field names to upper-case (there is a global 'FlacTagLibraryDefaultUpperCaseFieldNamesToWrite' flag which is used when a tag object is created and also a 'TFlacTag.UpperCaseFieldNamesToWrite' to specifically set a tag object's behaviour), default is True
* Fixed cover art functions when 'description' was 0 bytes long

2.0.11.32 15/05/2014
--------------------
+ Added TFlacTag.DeleteAllCoverArts function

2.0.14.38 31/12/2014
--------------------
+ Added functions for loading/saving/removing tags to TStream

2.0.15.39 03/02/2015
--------------------
+ Added C++ Builder tutorial

2.0.16.41 03/10/2015
--------------------
* Fixed writing padding bytes slow-down
