WAV Tag Library - Copyright © 2014-2015 3delite. All rights reserved.
================================================================

What's the point?
=================

WAV Tag Library is a component for use in Win32 (9x/ME/2K/XP/Vista/7/8), Win64, OSX, iOS and Android software.
Reads and writes WAV LIST INFO, BEXT and CART tags.

Features:

- Loading of WAV LIST INFO, BEXT and CART tags
- Saving of WAV LIST INFO, BEXT and CART tags
- Removing of WAV LIST INFO, BEXT and CART tags
- Supports ID3v2 at the beginning and ID3v1 or APE(v2) tags at the end of the file
- WAV RF64 files are also supported
- Supports binary frames
- Access directly all frames as a TMemoryStream (full controll of the frame contents)
- Full unicode support
- Pure Delphi code, no external dependencies
- Delphi XE2 64bit and OSX, Delphi XE5 iOS and Android compatible

You should also see the included example program Tutorial's source-code for example of how to use WAV Tag Library in your own programs.

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

WAV Tag Library is also available as a part of Tags Library:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/TagsLibrary.html


Requirements:
=============

Delphi 2009 and above.


Latest Version
==============

The latest version of WAV Tag Library can always be found at 3delite's website:

http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WAVTagLibrary.html


Notes:
======

Unicode strings are written as UTF8. The official WAV spec. doesn't supoort this, only ANSI characters, so always use ANSI strings for the tags.
WAV Tag Library will read and write UTF8 tags correctly though.


Copyright, Disclaimer, and all that other jazz
==============================================

This software is provided "as is", without warranty of ANY KIND, either expressed or implied, including but not limited to the implied warranties of merchantability and/or fitness for a particular purpose. The author shall NOT be held liable for ANY damage to you, your computer, or to anyone or anything else, that may result from its use, or misuse. Basically, you use it at YOUR OWN RISK.

Usage of WAV Tag Library indicates that you agree to the above conditions.

You may freely distribute the WAV Tag Library package as long as NO FEE is charged and all the files remain INTACT AND UNMODIFIED.

All trademarks and other registered names contained in the WAV Tag Library package are the property of their respective owners.


WAV Tag Library in shareware and commercial software?
===================================================

You can use this component in your free programs for free. If like it and use it for shareware or commercial (or any other money making - advertising, in app. selling, etc.) product you have to buy a license.

Shareware License: €25, for usage of the component in an unlimited number of your shareware software.

http://www.shareit.com/product.html?productid=300625530

Commercial License: €100 Euros, for usage of the component in a single commercial product.

http://www.shareit.com/product.html?productid=300625529

In all cases there are no royalties to pay, and you can use all future updates without further cost, all you need to do is just obtain the newest version.

There is a discount when purchasing WAV Tag Library and ID3v2 Library and/or APEv2 Library and/or MP4 Tag Library and/or Ogg Vorbis and Opus Tag Library and/or Flac Tag Library and/or WMA Tag Library together. Please check the ID3v2 Library  and/or MP4 Tag Library and/or Ogg Vorbis and Opus Tag Library and/or Flac Tag Library and/or WMA Tag Library on the order page when purchasing WAV Tag Library.

If none of these licenses match your requirements, or if you have any questions, get in touch (3delite@3delite.hu).


Installation:
=============

Add the directory to the search path, and to Uses list add: WAVTagLibrary.


Credits
=======

C++ Builder tutorial by Robert Jackson (hsialinboy@yahoo.com)


Bug reports, Suggestions, Comments, Enquiries, etc...
=====================================================

If you have any of the aforementioned please email:

3delite@3delite.hu


History
=======

0.0.0.9 16/04/2014
------------------
First beta release.

1.0.0.0 17/04/2014
------------------
First stable release.

1.0.1.1 21/04/2014
------------------
* Re-written LIST INFO chunk writing, now the LIST INFO chunk is written as the first chunk, which is required by MS software
+ Added support for creating a new file with SaveToFile(), which creates a WAV RIFF file with only a LIST INFO chunk (useful for saving tag information for 'later' use)
+ Added return value WAVTAGLIBRARY_ERROR_NOT_SUPPORTED_FORMAT for the load tag and save tag methods

1.0.2.2 23/04/2014
------------------
+ Added TWAVTag.DeleteFrame(Name: String): Boolean function
* Fixed GetAsText() and GetAsList() trailing zero character

1.0.3.4 15/05/2014
------------------
+ Changed all function to handle frame names case sensitive
+ 'FrameCount' renamed to 'Count'
+ TWAVTag.AddTextFrame() now returns the new frame's index

1.0.4.5 20/05/2014
------------------
+ Added reading and writing support of BEXT and CART tags

1.0.4.6 23/05/2014
------------------
+ BEXT UMID string is now returned as hex values
* Fixed getting of BEXT coding history and CART tag text when their length is 0
* A padding 0 byte is added after BEXT.CodingHistory and CART.TagText on save

1.0.5.8 30/05/2014
------------------
+ Improved WAV tags UTF8 field values setting
* Fixed reading and writing of ANSI field values with extended characters
* Fixed RF64 writing support

1.0.6.9 12/06/2014
------------------
+ Added TWAVTag.Attributes property

1.0.7.0 12/06/2014
------------------
+ Added TWAVTag.BitRate property

1.0.8.1 28/06/2014
------------------
* Fixed WAV tag processing with >4GB files

1.0.9.4 31/12/2014
------------------
+ Added functions for loading/saving/removing tags to TStream

1.0.10.5 03/02/2015
-------------------
+ Added C++ Builder tutorial

1.0.11.8 16/06/2016
-------------------
* Fixed loading tags when no LIST INFO chunk is present in the file
