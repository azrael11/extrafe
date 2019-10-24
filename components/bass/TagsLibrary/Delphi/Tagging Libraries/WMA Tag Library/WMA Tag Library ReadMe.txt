WMA Tag Library - Copyright © 2013-2014 3delite. All rights reserved.
================================================================

What's the point?
=================

WMA Tag Library is a component for use in Win32 (9x/ME/2K/XP/Vista/7/8) and Win64 software.
Reads and writes WMA tags (tags in WMA audio and WM video files).

Features:

- Loading of WMA tags
- Saving of WMA tags
- Supports managing cover pictures
- Loading and saving of WMV (Windows Media Video) files tags is also supported
- Full unicode support
- Delphi XE2 64bit compatible

You should also see the included example program Tutorial's source-code for example of how to use WMA Tag Library in your own programs.

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


Requirements:
=============

Delphi 2009 and above.
Windows Media Player installed.


Latest Version
==============

The latest version of WMA Tag Library can always be found at 3delite's website:

http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WMATagLibrary.html


Copyright, Disclaimer, and all that other jazz
==============================================

This software is provided "as is", without warranty of ANY KIND, either expressed or implied, including but not limited to the implied warranties of merchantability and/or fitness for a particular purpose. The author shall NOT be held liable for ANY damage to you, your computer, or to anyone or anything else, that may result from its use, or misuse. Basically, you use it at YOUR OWN RISK.

Usage of WMA Tag Library indicates that you agree to the above conditions.

You may freely distribute the WMA Tag Library package as long as NO FEE is charged and all the files remain INTACT AND UNMODIFIED.

All trademarks and other registered names contained in the WMA Tag Library package are the property of their respective owners.


WMA Tag Library in shareware and commercial software?
=====================================================

You can use WMA Tag Library for free for free programs/projects but for shareware or commerical programs you need one of the following licenses:

Shareware License: €25, for usage of the component in an unlimited number of your shareware software.

http://www.shareit.com/product.html?productid=300579129

Commercial License: €100, for usage of the component in a single commercial product.

http://www.shareit.com/product.html?productid=300579128

In all cases there are no royalties to pay, and you can use all future updates without further cost, all you need to do is just obtain the newest version.

There is a discount when purchasing WMA Tag Library and ID3v2 and/or APEv2 and/or MP4 Tag Library and/or Ogg Vorbis and Opus Tag Library and/or Flac Tag Library together. Please checkmark the ID3v2 Library and/or APEv2 and/or MP4 Library and/or Ogg Vorbis and Opus Tag Library and/or Flac Tag Library on the order page when purchasing WMA Tag Library.

If none of these licenses match your requirements, or if you have any questions, get in touch (3delite@3delite.hu).


Installation:
=============

Add the directory to the search path, and to Uses list add: WMATagLibrary.


Credits
=======

C++ Builder tutorial by Robert Jackson (hsialinboy@yahoo.com)


Bug reports, Suggestions, Comments, Enquiries, etc...
=====================================================

If you have any of the aforementioned please email:

3delite@3delite.hu


History
=======

1.0.1.1 01/03/2013
------------------
First release.

1.0.2.2 05/03/2013
------------------
+ Added attribute name constants
+ ReadAsInteger() and SetAsInteger() functions added
* Fixed reading of empty list frames

1.0.3.3 24/03/2013
------------------
+ Added function GetCoverArtInfo()
* Fixed writing cover arts on Win64

1.0.4.6 20/04/2013
------------------
+ Added support for multiple tags of the same type
+ Setting a tag value to nothing ('') results deleting the frame in the class
+ Added properties for basic attributes

1.0.5.8 07/11/2013
------------------
+ Fixed getting cover art in Win64 mode

1.0.6.9 15/05/2014
------------------
+ Added TWMATag.DeleteAllCoverArts() function
+ Added TWMATagFrame.Delete() function
+ Added TWMATag.AddCoverArtFrame() function
+ Added TWMATag.GetCoverArtInfoPointer() function

1.0.7.10 10/10/2014
------------------
* Fixed memory leak in load tag function

1.0.8.11 30/11/2014
------------------
* Fixed memory leak when freeing the class

1.0.9.12 03/02/2015
------------------
+ Added C++ Builder tutorial
* Fixed SetAsInteger() function
* Fixed issues related to attribute indexes