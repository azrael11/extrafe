//---------------------------------------------------------------------------
#include <JPEG.hpp>
#include <PNGImage.hpp>
#include <gifimg.hpp>
#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include "TagsLibraryDefs.hpp"

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"

const int MAGIC_PNG = 0x5089;
const int MAGIC_JPG = 0xd8ff;
const int MAGIC_GIF = 0x4947;
const int MAGIC_BMP = 0x4d42;


HTags Tags;
TTagType TagType = ttID3v2;
TCoverArtData CoverArtData;
String LastArtPath;

//converted to C++ by RMJ 02/2015
//Note that full OGG support is not
//implimented into this version

TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent *Owner): TForm(Owner){}

//---------------------------------------------------------------------------

void __fastcall ResizeBitmap(Graphics::TBitmap *Bitmap, int iWidth, int iHeight, TColor Background)
{
   TRect R;
   TBitmap *B;
   int x, y;

   if(Bitmap != NULL)
   {
      B = new TBitmap;

      try
      {
         if(Bitmap->Width > Bitmap->Height)
         {
            R.Right = iWidth;
            R.Bottom = (((iWidth) * Bitmap->Height) / Bitmap->Width);
            x = 0;
            y = (iHeight / 2) - (R.Bottom / 2);
         }
         else
         {
            R.Right = (((iHeight) * Bitmap->Width) / Bitmap->Height);
            R.Bottom = iHeight;
            x = (iWidth / 2) - (R.Right / 2);
            y = 0;
         }
         R.Left = 0;
         R.Top = 0;

         B->PixelFormat = Bitmap->PixelFormat;
         B->Width = iWidth;
         B->Height = iHeight;
         B->Canvas->Brush->Color = Background;
         B->Canvas->FillRect(B->Canvas->ClipRect);
         B->Canvas->StretchDraw(R, Bitmap);
         B->Canvas->FillRect(Bitmap->Canvas->ClipRect);

         SetBrushOrgEx(B->Canvas->Handle, 0, 0, NULL);
         SetStretchBltMode(B->Canvas->Handle, HALFTONE);
         StretchBlt(B->Canvas->Handle, x, y, R.Right, R.Bottom, Bitmap->Canvas->Handle, 0, 0, Bitmap->Width, Bitmap->Height, SRCCOPY);
         Bitmap->Assign(B);

      }
      __finally
      {
         B->Free();
         B = NULL;
      }

   }

}


//-------------------------------------------------------------------------

int __fastcall TForm1::FreeAndNULL(TObject *Obj)
{

   if(Obj->InheritsFrom(__classid(TStream)))
   {
      delete ((TStream*)Obj);
      Obj = NULL;
      return 1;
   }
   if(Obj->InheritsFrom(__classid(TMemoryStream)))
   {
      delete ((TMemoryStream*)Obj);
      Obj = NULL;
      return 1;
   }
   if(Obj->InheritsFrom(__classid(TFileStream)))
   {
      delete ((TFileStream*)Obj);
      Obj = NULL;
      return 1;
   }
   if(Obj->InheritsFrom(__classid(TJPEGImage)))
   {
      delete ((TJPEGImage*)Obj);
      Obj = NULL;
      return 1;
   }
   if(Obj->InheritsFrom(__classid(TPngImage)))
   {
      delete ((TPngImage*)Obj);
      Obj = NULL;
      return 1;
   }
   if(Obj->InheritsFrom(__classid(TGIFImage)))
   {
      delete ((TGIFImage*)Obj);
      Obj = NULL;
      return 1;
   }
   if(Obj->InheritsFrom(__classid(TBitmap)))
   {
      delete ((Graphics::TBitmap*)Obj);
      Obj = NULL;
      return 1;
   }

   return 0;

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{

   OpenDialog1->FileName = L"";
   OpenDialog1->Filter = L"Media Files|*.WMV;*.WMA;*.MP4;*MP3;*OGG;*.FLAC;*.OPUS|";
   OpenDialog1->InitialDir = ExtractFilePath(Edit1->Text);

   if(OpenDialog1->Execute())
   {
      String Fext = ExtractFileExt(OpenDialog1->FileName).UpperCase();

      if(SameText(Fext, L".APE"))
       ComboBox1->ItemIndex = 0;
      if(SameText(Fext, L".FLAC"))
       ComboBox1->ItemIndex = 1;
      if(SameText(Fext, L".MP3"))
       ComboBox1->ItemIndex = 3;
      if(SameText(Fext, L".MP4"))
       ComboBox1->ItemIndex = 4;
      if(SameText(Fext, L".OGG") || SameText(Fext, L".OGV") || SameText(Fext, L".OPUS"))
       ComboBox1->ItemIndex = 5;
      if(SameText(Fext, L".WAV"))
       ComboBox1->ItemIndex = 6;
      if(SameText(Fext, L".WMA") || SameText(Fext, L".WMV"))
       ComboBox1->ItemIndex = 7;

      ComboBox1Change(Sender);
      Edit1->Text = OpenDialog1->FileName;
      Button4->Click();
   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button2Click(TObject *Sender)
{

   int Error = TagsLibrary_RemoveTag(Edit1->Text.c_str(), TagType);
   if(Error != TAGSLIBRARY_SUCCESS)
   {
      ShowMessage(L"Error while removing tags from file.");
   }

   //reload
   Button4Click(Sender);

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button3Click(TObject *Sender)
{
   int Error;

   //Set specific tags
   //TagsLibrary_SetTag(Tags, L"ARTIST", Edit2->Text.c_str(), TagType);
   //TagsLibrary_SetTag(Tags, L"TITLE",  Edit3->Text.c_str(), TagType);
   //TagsLibrary_SetTag(Tags, L"ALBUM",  Edit4->Text.c_str(), TagType);

   Error = TagsLibrary_SaveEx(Tags, Edit1->Text.c_str(), TagType);
   if(Error != TAGSLIBRARY_SUCCESS)
   {
      ShowMessage(L"Error while saving tag.");
   }

   Button4Click(Sender);

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button4Click(TObject *Sender)
{
   ListView1->Clear();
   ListView2->Clear();
   ImageListThumbs->Clear();

   //parsetags is false as we are not using the 'ttAutomatic' at all, so there's no need to parse the tags
   TagsLibrary_Load(Tags, Edit1->Text.c_str(), TagType, false);

   if(TagsLibrary_Loaded(Tags, TagType))
   {
      ListTags();
      ListCoverArts();
   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::ListTags()
{
   int i;
   TExtTag     ExtTag;
   TSimpleTag  SimpleTag;
   TID3v2TagEx ID3v2TagEx;
   TMP4TagEx   MP4TagEx;

   ListView1->Clear();

   //list specific tags
   //Edit2->Text := TagsLibrary_GetTag(Tags, PWideChar('ARTIST'), TagType);
   //Edit3->Text := TagsLibrary_GetTag(Tags, PWideChar('TITLE'), TagType);
   //Edit4->Text := TagsLibrary_GetTag(Tags, PWideChar('ALBUM'), TagType);

   //list all tags
   for(i = 0; i < TagsLibrary_TagCount(Tags, TagType); i++)
   {
      //different tag formats need different tag data structures
      switch(TagType)
      {
         case ttAutomatic:
            ZeroMemory(&ExtTag, sizeof(ExtTag));
            if(TagsLibrary_GetTagByIndexEx(Tags, i, TagType, &ExtTag))
            {
               TListItem *Item = ListView1->Items->Add();
               Item->Caption = ExtTag.Name;
               Item->SubItems->Add(ExtTag.Value);
            }

            break;

         //SimpleTag
         case ttAPEv2:
         case ttFlac:
         case ttID3v1:
         case ttOpusVorbis:
         case ttWAV:
         case ttWMA:
            ZeroMemory(&SimpleTag, sizeof(SimpleTag));
            if(TagsLibrary_GetTagByIndexEx(Tags, i, TagType, &SimpleTag))
            {
               TListItem *Item = ListView1->Items->Add();
               Item->Caption = SimpleTag.Name;
               Item->SubItems->Add(SimpleTag.Value);
            }
            break;

         //ID3v2TagEx
         case ttID3v2:
            ZeroMemory(&ID3v2TagEx, sizeof(ID3v2TagEx));
            if(TagsLibrary_GetTagByIndexEx(Tags, i, TagType, &ID3v2TagEx))
            {
               TListItem *Item = ListView1->Items->Add();
               Item->Caption = ID3v2TagEx.Name;
               Item->SubItems->Add(ID3v2TagEx.Value);
            }
            break;

         //MP4TagEx
         case ttMP4:
            ZeroMemory(&MP4TagEx, sizeof(MP4TagEx));
            if(TagsLibrary_GetTagByIndexEx(Tags, i, TagType, &MP4TagEx))
            {
               TListItem *Item = ListView1->Items->Add();
               Item->Caption = MP4TagEx.Name;
               Item->SubItems->Add(MP4TagEx.Value);
            }
            break;
      }

   }

}

//-------------------------------------------------------------------------


void __fastcall TForm1::Button5Click(TObject *Sender)
{
   TMemoryStream *PictureStream;
   String Description;
   String MIMEType;
   TJPEGImage *JPEGPicture;
   TPngImage *PNGPicture;
   TGIFImage *GIFPicture;
   TBitmap *BMPPicture;
   int iWidth, iHeight;
   int NoOfColors;
   int ColorDepth;
   WORD PictureMagic;
   TTagPictureFormat CoverArtPictureFormat;

   int arts = TagsLibrary_CoverArtCount(Tags, TagType);

   if(TagType == ttWAV)
   {
      ShowMessage(L"WAV tag does not support cover arts.");
      return;
   }

   OpenDialog1->FileName = L"";
   OpenDialog1->Filter = L"Image Files|*.bmp;*.jpg;*png;*.gif|";
   OpenDialog1->InitialDir = LastArtPath;

   if(!OpenDialog1->Execute())
   {
      return;
   }

   MIMEType    = L"";
   Description = L"";
   iWidth      = 0;
   iHeight     = 0;
   ColorDepth  = 0;
   NoOfColors  = 0;
   CoverArtPictureFormat = (TTagPictureFormat)tpfUnknown;

   if(FileExists(OpenDialog1->FileName))
   {
      try
      {
         PictureStream = new TMemoryStream;

         try
         {
            PictureStream->LoadFromFile(OpenDialog1->FileName);
            PictureStream->Seek((__int64)0, (WORD)soBeginning);
            Description = ExtractFileName(OpenDialog1->FileName);
            PictureStream->Read(&PictureMagic, 2);
            PictureStream->Seek((__int64)0, (WORD)soBeginning);

            if(PictureMagic == MAGIC_JPG)
            {
               MIMEType = L"image/jpeg";
               CoverArtPictureFormat = tpfJPEG;
               JPEGPicture = new TJPEGImage;
               JPEGPicture->LoadFromStream(PictureStream);
               iWidth = JPEGPicture->Width;
               iHeight = JPEGPicture->Height;
               NoOfColors = 256;
               ColorDepth = 24;
               FreeAndNULL(JPEGPicture);
            }

            if(PictureMagic == MAGIC_PNG)
            {
               MIMEType = L"image/png";
               CoverArtPictureFormat = tpfPNG;
               PNGPicture = new TPngImage;
               PNGPicture->LoadFromStream(PictureStream);
               iWidth = PNGPicture->Width;
               iHeight = PNGPicture->Height;
               NoOfColors = 256;
               ColorDepth = PNGPicture->PixelInformation->Header->BitDepth;
               FreeAndNULL(PNGPicture);
            }

            if(PictureMagic == MAGIC_GIF)
            {
               MIMEType = L"image/gif";
               CoverArtPictureFormat = tpfGIF;
               GIFPicture = new TGIFImage;
               GIFPicture->LoadFromStream(PictureStream);
               iWidth = GIFPicture->Width;
               iHeight = GIFPicture->Height;
               NoOfColors = 256;
               ColorDepth = GIFPicture->BitsPerPixel;
               FreeAndNULL(GIFPicture);
            }

            if(PictureMagic == MAGIC_BMP)
            {
               MIMEType = L"image/bmp";
               CoverArtPictureFormat = tpfBMP;
               BMPPicture = new TBitmap;
               BMPPicture->LoadFromStream(PictureStream);
               iWidth  = BMPPicture->Width;
               iHeight = BMPPicture->Height;
               NoOfColors = 256;
               switch(BMPPicture->PixelFormat)
               {
                  case pfDevice:   ColorDepth = 32; break;
                  case pf1bit:     ColorDepth = 1;  break;
                  case pf4bit:     ColorDepth = 4;  break;
                  case pf8bit:     ColorDepth = 8;  break;
                  case pf15bit:    ColorDepth = 15; break;
                  case pf16bit:    ColorDepth = 16; break;
                  case pf24bit:    ColorDepth = 24; break;
                  case pf32bit:    ColorDepth = 32; break;
                  case pfCustom:   ColorDepth = 32; break;
                  default:         ColorDepth = 24;
               }

               FreeAndNULL(BMPPicture);
            }

            PictureStream->Seek((__int64)0, (WORD)soBeginning);

            CoverArtData.Name          = L"Cover Art (Front)"; //only used for APEv2 should be always 'Cover Art (Front)'
            CoverArtData.CoverType     = ((arts > 1) ? 0 : 3);
            CoverArtData.MIMEType      = MIMEType.c_str();
            CoverArtData.Description   = Description.c_str();
            CoverArtData.Width         = iWidth;
            CoverArtData.Height        = iHeight;
            CoverArtData.ColorDepth    = ColorDepth;
            CoverArtData.NoOfColors    = NoOfColors;
            CoverArtData.PictureFormat = CoverArtPictureFormat;
            CoverArtData.Data          = PictureStream->Memory;
            CoverArtData.DataSize      = PictureStream->Size;

            if(TagsLibrary_AddCoverArt(Tags, TagType, CoverArtData) == -1)
            {
               ShowMessage(L"Error while adding cover art: " + SaveDialog1->FileName);
            }

         }
         __finally
         {
            FreeAndNULL(PictureStream);
         }
      }
      catch(...)
      {
         ShowMessage(L"Error while adding cover art: " + SaveDialog1->FileName);
      }
   }

   ListCoverArts();

}


//-------------------------------------------------------------------------


void __fastcall TForm1::Button6Click(TObject *Sender)
{

   if(ListView2->SelCount != 1)
   {
      ShowMessage(L"Please select one cover art.");
      return ;
   }

   TagsLibrary_DeleteCoverArt(Tags, TagType, ListView2->Selected->Index);

   ListCoverArts();

}

//-------------------------------------------------------------------------


void __fastcall TForm1::Button7Click(TObject *Sender)
{
   String Fext;
   TFileStream *CoverArtFileStream;

   if(ListView2->SelCount != 1)
   {
      ShowMessage(L"Please select one cover art.");
      return ;
   }

   if(TagsLibrary_GetCoverArt(Tags, TagType, ListView2->Selected->Index, CoverArtData))
   {
      switch(CoverArtData.PictureFormat)
      {
         case tpfJPEG:  Fext = L".jpg";  break;
         case tpfPNG:   Fext = L".png";  break;
         case tpfGIF:   Fext = L".gif";  break;
         case tpfBMP:   Fext = L".bmp";  break;
         default:       Fext = L".jpg";
      }

      SaveDialog1->FileName = ChangeFileExt(CoverArtData.Description, Fext);

      if(SaveDialog1->Execute())
      {
         CoverArtFileStream = new TFileStream(SaveDialog1->FileName, fmCreate);
         try
         {
            CoverArtFileStream->Write(CoverArtData.Data, CoverArtData.DataSize);
         }
         __finally
         {
            FreeAndNULL(CoverArtFileStream);
         }

      }

   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::ComboBox1Change(TObject *Sender)
{

   switch(ComboBox1->ItemIndex)
   {
      case 0: TagType = ttAPEv2;      break;
      case 1: TagType = ttFlac;       break;
      case 2: TagType = ttID3v1;      break;
      case 3: TagType = ttID3v2;      break;
      case 4: TagType = ttMP4;        break;
      case 5: TagType = ttOpusVorbis; break;
      case 6: TagType = ttWAV;        break;
      case 7: TagType = ttWMA;        break;
   }

   ListTags();
   ListCoverArts();

}

//-------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender)
{

   InitTagsLibrary();

   if(!TagsLibraryLoaded)
   {
      ShowMessage(L"Error while loading TagsLib.dll.");
      Application->Terminate();
      return;
   }

   Tags = TagsLibrary_Create();

}

//-------------------------------------------------------------------------

void __fastcall TForm1::FormDestroy(TObject *Sender)
{

   TagsLibrary_Free(Tags);
   FreeTagsLibrary();

}

//-------------------------------------------------------------------------

void __fastcall TForm1::ListCoverArts()
{
   int i;
   TMemoryStream *PictureStream;
   TJPEGImage *ImageJPEG;
   TPngImage *ImagePNG;
   TGIFImage *ImageGIF;
   TBitmap *Bitmap;

   ListView2->Clear();
   ImageListThumbs->Clear();


   //list cover arts
   for(i = 0; i < TagsLibrary_CoverArtCount(Tags, TagType); i++)
   {
      if(TagsLibrary_GetCoverArt(Tags, TagType, i, CoverArtData))
      {
         Bitmap = new TBitmap;
         PictureStream = new TMemoryStream;

         try
         {
            PictureStream->Write(CoverArtData.Data, CoverArtData.DataSize);
            PictureStream->Seek((__int64) 0, (WORD) soBeginning);

            switch(CoverArtData.PictureFormat)
            {
               case tpfJPEG:
                    ImageJPEG = new TJPEGImage;
                    ImageJPEG->LoadFromStream(PictureStream);
                    Bitmap->Assign(ImageJPEG);
                    FreeAndNULL(ImageJPEG);
                    break;

               case tpfPNG:
                    ImagePNG = new TPngImage;
                    ImagePNG->LoadFromStream(PictureStream);
                    Bitmap->Assign(ImagePNG);
                    FreeAndNULL(ImagePNG);
                    break;

               case tpfGIF:
                    ImageGIF = new TGIFImage;
                    ImageGIF->LoadFromStream(PictureStream);
                    Bitmap->Assign(ImageGIF);
                    FreeAndNULL(ImageGIF);
                    break;

               case tpfBMP:
                    Bitmap->LoadFromStream(PictureStream);
                    break;
            }

            ResizeBitmap(Bitmap, ImageListThumbs->Width, ImageListThumbs->Height, clWhite);

            TListItem *Item = ListView2->Items->Add();
            Item->Caption = CoverArtData.Name;
            Item->ImageIndex = ImageListThumbs->Add(Bitmap, NULL);

         }
         __finally
         {
            FreeAndNULL(Bitmap);
            FreeAndNULL(PictureStream);
         }

      }

   }

}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
