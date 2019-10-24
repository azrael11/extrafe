APEv2 Library - Copyright © 2012-2016 3delite. All rights reserved.
===================================================================

What's the point?
=================

APEv2 Library is a component for use in Win32 (9x/ME/2K/XP/Vista/7/8), Win64, OSX, iOS and Android software.
Reads APEv1 and APEv2, and writes APEv2 Tags.

Features:

- Loading of APEv1 and APEv2 Tags
- Saving of APEv2 Tags
- Removing of APE Tags
- Supports ID3v1 tags after the APE tag
- Supports binary frames
- Bulit in support for extracting and inserting album cover pictures
- Access directly all frames as a TMemoryStream (full controll of the frame contents)
- Full unicode support
- Pure Delphi code, no external dependencies
- Delphi XE2 64bit and OSX, Delphi XE5 iOS and Android compatible

You should also see the included example program Tutorial's source-code for example of how to use APEv2 Library in your own programs.

If you are interested in ID3v1 and ID3v2 tagging unit, please follow this link:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html

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

APEv2 Library is also available as a part of Tags Library:
http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/TagsLibrary.html


Requirements:
=============

Delphi 2009 and above.


Latest Version
==============

The latest version of APEv2 Library can always be found at 3delite's website:

http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/APEv2Library.html


Copyright, Disclaimer, and all that other jazz
==============================================

This software is provided "as is", without warranty of ANY KIND, either expressed or implied, including but not limited to the implied warranties of merchantability and/or fitness for a particular purpose. The author shall NOT be held liable for ANY damage to you, your computer, or to anyone or anything else, that may result from its use, or misuse. Basically, you use it at YOUR OWN RISK.

Usage of APEv2 Library indicates that you agree to the above conditions.

You may freely distribute the APEv2 Library package as long as NO FEE is charged and all the files remain INTACT AND UNMODIFIED.

All trademarks and other registered names contained in the APEv2 Library package are the property of their respective owners.


APEv2 Library in shareware and commercial software?
===================================================

You can use this component in your free programs for free. If like it and use it for shareware or commercial (or any other money making - advertising, in app. selling, etc.) product you have to buy a license.

Shareware License: €25, for usage of the component in an unlimited number of your shareware software.

http://www.shareit.com/product.html?productid=300517941

Commercial License: €100, for usage of the component in a single commercial product.

http://www.shareit.com/product.html?productid=300517939

In all cases there are no royalties to pay, and you can use all future updates without further cost, all you need to do is just obtain the newest version.

There is a discount when purchasing APEv2 Library and ID3v2 Library and/or MP4 Tag Library and/or Ogg Vorbis and Opus Tag Library together. Please check the ID3v2 Library  and/or MP4 Tag Library and/or Ogg Vorbis and Opus Tag Library on the order page when purchasing APEv2 Library.

If none of these licenses match your requirements, or if you have any questions, get in touch (3delite@3delite.hu).


Installation:
=============

Add the directory to the search path, and to Uses list add: APEv2Library.


Credits
=======

C++ Builder tutorial by Robert Jackson (hsialinboy@yahoo.com)


Bug reports, Suggestions, Comments, Enquiries, etc...
=====================================================

If you have any of the aforementioned please email:

3delite@3delite.hu


History
=======

1.0.0.0 11/04/2012
------------------
First release.

1.0.1.1 20/01/2013
------------------
* Fixed reading of corrupt tags when a tag size is reported larger then the whole tag size

1.0.2.2 31/10/2013
------------------
+ Added support for Delphi XE5 iOS and Android build target
+ Added function GetCoverArtInfo()
* Fixed all hints and warnings

1.0.2.3 03/02/2014
------------------
+ Added cover art embeding code to tutorial

1.0.3.4 15/05/2014
------------------
+ Added option to automatically convert field names to upper-case (there is a global 'APEv2TagLibraryDefaultUpperCaseFieldNamesToWrite' flag which is used when a tag object is created and also a 'TAPEv2Tag.UpperCaseFieldNamesToWrite' to specifically set a tag object's behaviour), default is True
+ Added APEv2TagErrorCode2String() function
+ Added TAPEv2Tag.DeleteAllCoverArts function

1.0.4.5 06/09/2014
------------------
+ Renamed 'FrameCount' to 'Count'

1.0.5.6 12/12/2014
------------------
* Fixed loading of tags with 0 length field values
* Fixed GetAsText functions with illegal UTF-8 field values, for the second try now they are read as ANSI

1.0.6.8 31/12/2014
------------------
+ Added functions for loading/saving/removing tags to TStream

1.0.7.9 03/02/2015
------------------
+ Added C++ Builder tutorial

1.0.8.12 03/10/2015
-------------------
* Fixed on tag value convert error frame is reported as binary

1.0.9.15 06/05/2016
-------------------
+ Improvements in tag parsing (more error tolerant)
* Fixed loading an APEv1 tag and saving it (as APEv2 - ANSI to UTF8 conversion should be fixed now)
