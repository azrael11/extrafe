//---------------------------------------------------------------------------
#include <JPEG.hpp>
#include <PNGImage.hpp>
#include <gifimg.hpp>
#include <vcl.h>
#pragma hdrstop

#undef AtomName
#undef AddAtom
#undef FindAtom

#include "Unit1.h"
#include "TagsLibraryDefs.h"

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"

const int MAGIC_PNG = 0x5089;
const int MAGIC_JPG = 0xd8ff;
const int MAGIC_GIF = 0x4947;
const int MAGIC_BMP = 0x4d42;

String LastArtPath;
bool TagsLibraryLoaded;
TCoverArtData CoverArtData;
HTAGS Tags;

#define min(a,b) (((a)<(b))?(a):(b))
#define max(a,b) (((a)>(b))?(a):(b))

//converted to C++ by RMJ 02/2015
//Note that full OGG support is not
//implimented into this version

TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner) : TForm(Owner)
{
}

//---------------------------------------------------------------------------

void __fastcall TForm1::ResizeBitmapScale(Graphics::TBitmap *SourceBmp, int width, int height, TPixelFormat ColorBit)
{
    Graphics::TBitmap *abmp, *bbmp;
    double scalex, scaley;

    abmp = new Graphics::TBitmap;
    bbmp = new Graphics::TBitmap;

    double WidthRequested = width;
    double WidthOriginal  = SourceBmp->Width;
    double HeightOriginal = SourceBmp->Height;
    double ratio = (WidthOriginal / WidthRequested);
    double HeightNeeded = (int)floor(HeightOriginal / ratio);

    try
    {
       abmp->Assign(SourceBmp);
       bbmp->Width  = WidthRequested;
       bbmp->Height = max(HeightNeeded, height);
       bbmp->PixelFormat = ColorBit;
       SetStretchBltMode(bbmp->Canvas->Handle, HALFTONE);
       StretchBlt(bbmp->Canvas->Handle, 0, 0, bbmp->Width, bbmp->Height, abmp->Canvas->Handle, 0, 0, abmp->Width, abmp->Height, SRCCOPY);
       SourceBmp->Assign(bbmp);
    }
    __finally
    {
       abmp->Free();
       bbmp->Free();
    }

}

//---------------------------------------------------------------------------

void __fastcall TForm1::ResizeBitmapBlt(Graphics::TBitmap *SrcBitmap, int width, int height)
{
    Graphics::TBitmap *abmp, *bbmp;
    abmp = new Graphics::TBitmap();
    bbmp = new Graphics::TBitmap();

    try
    {
       abmp->Assign(SrcBitmap);
       bbmp->Width  = width;
       bbmp->Height = height;
       bbmp->PixelFormat = pf24bit;

       SetBrushOrgEx(bbmp->Canvas->Handle, 0, 0,NULL);
       SetStretchBltMode(bbmp->Canvas->Handle, HALFTONE);
       StretchBlt(bbmp->Canvas->Handle, 0, 0, bbmp->Width, bbmp->Height, abmp->Canvas->Handle, 0, 0, abmp->Width, abmp->Height, SRCCOPY);
       SrcBitmap->Assign(bbmp);
    }

    __finally
    {
       delete abmp;
       delete bbmp;
       abmp = NULL;
       bbmp = NULL;
    }

}

//---------------------------------------------------------------------------

void __fastcall ResizeBitmap(Graphics::TBitmap *Bitmap, int iWidth, int iHeight, TColor Background)
{
   TRect R;
   TBitmap *B;
   int x, y;
   int offset1 = (iHeight - iWidth);

   if(Bitmap != NULL)
   {
      B = new TBitmap;

      try
      {
         if(Bitmap->Width > Bitmap->Height)
         {
            R.Right = iWidth;
            R.Bottom = (((iWidth) * Bitmap->Height ) / Bitmap->Width)  - offset1;
            x = 0;
            y = (iHeight / 2) - (R.Bottom / 2);
         }
         else
         {
            R.Right  = (((iHeight) * Bitmap->Width ) / Bitmap->Height) + offset1;
            R.Bottom = iHeight;
            x = (iWidth / 2) - (R.Right / 2);
            y = 0;
         }
         R.Left = 0;
         R.Top = 0;
         B->PixelFormat = Bitmap->PixelFormat;
         B->Width  = iWidth;
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
      }

   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{

   OpenDialog2->FileName = L"";
   OpenDialog2->Filter = L"Media Files|*.WMV;*.WMA;*.MP4;*MP3;*OGG;*.FLAC|";
   OpenDialog2->InitialDir = ExtractFilePath(Edit1->Text);

   if(OpenDialog2->Execute())
   {
      Edit1->Text = OpenDialog2->FileName;
      Button4->Click();
   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button2Click(TObject *Sender)
{
   int Error;

   //Remove all tags from file
   Error = TagsLibrary_RemoveTag(Edit1->Text.c_str(), ttAutomatic);
   if(Error != TAGSLIBRARY_SUCCESS)
   {
      ShowMessage(L"Error while removing tags from file.");
   }

   //Re-load tags
   Button4Click(Sender);

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button3Click(TObject *Sender)
{
   int Error;

   //Set specific tags
   TagsLibrary_SetTag(Tags, L"ARTIST", Edit2->Text.c_str(), ttAutomatic);
   TagsLibrary_SetTag(Tags, L"TITLE",  Edit3->Text.c_str(), ttAutomatic);
   TagsLibrary_SetTag(Tags, L"ALBUM",  Edit4->Text.c_str(), ttAutomatic);

   //Do the save
   Error = TagsLibrary_Save(Tags, Edit1->Text.c_str(), ttAutomatic);
   if(Error != TAGSLIBRARY_SUCCESS)
   {
      ShowMessage(L"Error while saving tag.");
   }

   //Re-load
   Button4Click(Sender);

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button4Click(TObject *Sender)
{
   int i;
   TExtTag ExtTag;

   ListView1->Clear();
   ListView2->Clear();
   ImageListThumbs->Clear();

   TagsLibrary_Load(Tags, Edit1->Text.c_str(), ttAutomatic, true);

   if(TagsLibrary_Loaded(Tags, ttAutomatic))
   {
      //List specific tags
      Edit2->Text = TagsLibrary_GetTag(Tags, L"ARTIST", ttAutomatic);
      Edit3->Text = TagsLibrary_GetTag(Tags, L"TITLE", ttAutomatic);
      Edit4->Text = TagsLibrary_GetTag(Tags, L"ALBUM", ttAutomatic);

      //List all tags
      for(i = 0; i < TagsLibrary_TagCount(Tags, ttAutomatic); i++)
      {
         if(TagsLibrary_GetTagByIndexEx(Tags, i, ttAutomatic, &ExtTag))
         {

            TListItem *Item = ListView1->Items->Add();
            {
               Item->Caption = ExtTag.Name;
               Item->SubItems->Add(ExtTag.Value);
            }

         }

      }

      //List cover arts
      ListCoverArts();

   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button5Click(TObject *Sender)
{
   TMemoryStream *PictureStream;
   String Description;
   String MIMEType;
   TJPEGImage *JPEGPicture;
   TPngImage  *PNGPicture;
   TGIFImage  *GIFPicture;
   Graphics::TBitmap *BMPPicture;

   int iWidth, iHeight;
   int NoOfColors;
   int ColorDepth;

   WORD PictureMagic;
   TTagPictureFormat CoverArtPictureFormat;

   OpenDialog1->FileName = L"";
   OpenDialog1->Filter = L"Image Files|*.bmp;*.jpg;*png;*.gif|";
   OpenDialog1->InitialDir = LastArtPath;

   if(!OpenDialog1->Execute())
   {
      return;
   }

   //Clear the cover art data
   LastArtPath = ExtractFilePath(OpenDialog1->FileName);
   MIMEType = L"";
   Description = L"";
   iWidth = 0;
   iHeight = 0;
   ColorDepth = 0;
   NoOfColors = 0;
   CoverArtPictureFormat = (TTagPictureFormat)tpfUnknown;

   if(FileExists(OpenDialog1->FileName))
   {
      try
      {
            PictureStream = new TMemoryStream;

            PictureStream->LoadFromFile(OpenDialog1->FileName);
            PictureStream->Seek((__int64) 0, (WORD) soBeginning);
            PictureStream->Read(&PictureMagic, 2);
            PictureStream->Seek((__int64) 0, (WORD) soBeginning);
            Description = ExtractFileName(OpenDialog1->FileName);

            if(PictureMagic == MAGIC_JPG)
            {
               MIMEType = L"image/jpeg";
               CoverArtPictureFormat = tpfJPEG;
               JPEGPicture = new TJPEGImage;
               JPEGPicture->LoadFromStream(PictureStream);
               iWidth = JPEGPicture->Width;
               iHeight = JPEGPicture->Height;
               NoOfColors = 0;
               ColorDepth = 24;
               delete (JPEGPicture);
            }

            if(PictureMagic == MAGIC_PNG)
            {
               MIMEType = L"image/png";
               CoverArtPictureFormat = tpfPNG;
               PNGPicture = new TPngImage;
               PNGPicture->LoadFromStream(PictureStream);
               iWidth = PNGPicture->Width;
               iHeight = PNGPicture->Height;
               NoOfColors = 0;
               ColorDepth = PNGPicture->PixelInformation->Header->BitDepth;
               delete (PNGPicture);
            }

            if(PictureMagic == MAGIC_GIF)
            {
               MIMEType = L"image/gif";
               CoverArtPictureFormat = tpfGIF;
               GIFPicture = new TGIFImage;
               GIFPicture->LoadFromStream(PictureStream);
               iWidth  = GIFPicture->Width;
               iHeight = GIFPicture->Height;
               NoOfColors = GIFPicture->ColorResolution;
               ColorDepth = GIFPicture->BitsPerPixel;
               delete (GIFPicture);
            }

            if(PictureMagic == MAGIC_BMP)
            {
               MIMEType = L"image/bmp";
               CoverArtPictureFormat = tpfBMP;
               BMPPicture = new Graphics::TBitmap;
               BMPPicture->LoadFromStream(PictureStream);
               iWidth = BMPPicture->Width;
               iHeight = BMPPicture->Height;
               NoOfColors = 0;
               switch(BMPPicture->PixelFormat)
               {
                  case pfDevice: ColorDepth = 32; break;
                  case pf1bit:   ColorDepth = 1;  break;
                  case pf4bit:   ColorDepth = 4;  break;
                  case pf8bit:   ColorDepth = 8;  break;
                  case pf15bit:  ColorDepth = 15; break;
                  case pf16bit:  ColorDepth = 16; break;
                  case pf24bit:  ColorDepth = 24; break;
                  case pf32bit:  ColorDepth = 32; break;
                  case pfCustom: ColorDepth = 32; break;
               }
               delete (BMPPicture);
            }

            PictureStream->Seek((__int64) 0, (WORD) soBeginning);

            //Add the cover art
            CoverArtData.Name = Description.c_str();
            CoverArtData.CoverType = 3; //front cover
            CoverArtData.MIMEType = MIMEType.c_str();
            CoverArtData.Description = Description.c_str();
            CoverArtData.Width = iWidth;
            CoverArtData.Height = iHeight;
            CoverArtData.ColorDepth = ColorDepth;
            CoverArtData.NoOfColors = NoOfColors;
            CoverArtData.PictureFormat = CoverArtPictureFormat;
            CoverArtData.Data = PictureStream->Memory;
            CoverArtData.DataSize = PictureStream->Size;

            if(TagsLibrary_AddCoverArt(Tags, ttAutomatic, CoverArtData) == -1)
            {
               ShowMessage(L"Error while adding cover art: " + SaveDialog1->FileName);
            }

            delete (PictureStream);

      }
      catch(...)
      {
         ShowMessage(L"Error while adding cover art: " + SaveDialog1->FileName);
      }

   }

   //Display added cover art
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

   TagsLibrary_DeleteCoverArt(Tags, ttAutomatic, ListView2->Selected->Index);

   //Re-display cover arts
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

   if(TagsLibrary_GetCoverArt(Tags, ttAutomatic, ListView2->Selected->Index, &CoverArtData))
   {
      switch(CoverArtData.PictureFormat)
      {
         case tpfJPEG:  Fext = L".jpg";   break;
         case tpfPNG:   Fext = L".png";   break;
         case tpfGIF:   Fext = L".gif";   break;
         case tpfBMP:   Fext = L".bmp";   break;
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
            delete (CoverArtFileStream);
         }

      }

   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender)
{

   TagsLibraryLoaded = InitTagsLibrary();

   if(!TagsLibraryLoaded)
   {
      ShowMessage(L"Error while loading TagsLib.dll");
      Application->Terminate();
      ;
   }

   Tags = TagsLibrary_Create();

   if(!Tags)
   {
      ShowMessage(L"DLL error: program will now close.");
      Application->Terminate();
   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::FormDestroy(TObject *Sender)
{

   //Free the Tags Library instance
   TagsLibrary_Free(Tags);

   //This is automatically called when using Delphi
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
   Graphics::TBitmap *Bitmap;

   ListView2->Clear();
   ImageListThumbs->Clear();

   //List cover arts
   for(i = 0; i < TagsLibrary_CoverArtCount(Tags, ttAutomatic); i++)
   {
      if(TagsLibrary_GetCoverArt(Tags, ttAutomatic, i, &CoverArtData))
      {
         Bitmap = new Graphics::TBitmap;
         PictureStream = new TMemoryStream;
         try
         {
            //Transfer the memory bytes to a TStream
            PictureStream->Write(CoverArtData.Data, CoverArtData.DataSize);
            PictureStream->Seek((__int64) 0, (WORD) soBeginning);
            switch(CoverArtData.PictureFormat)
            {
               case tpfJPEG:
                     ImageJPEG = new TJPEGImage;
                     ImageJPEG->LoadFromStream(PictureStream);
                     Bitmap->Assign(ImageJPEG);
                     delete (ImageJPEG);
                     break;

               case tpfPNG:
                     ImagePNG = new TPngImage;
                     ImagePNG->LoadFromStream(PictureStream);
                     Bitmap->Assign(ImagePNG);
                     delete (ImagePNG);
                     break;

               case tpfGIF:
                     ImageGIF = new TGIFImage;
                     ImageGIF->LoadFromStream(PictureStream);
                     Bitmap->Assign(ImageGIF);
                     delete (ImageGIF);
                     break;

               case tpfBMP:
                     Bitmap->LoadFromStream(PictureStream);
                     break;
            }

            ResizeBitmap(Bitmap, ImageListThumbs->Width, ImageListThumbs->Height, clWhite);
            //ResizeBitmapBlt(Bitmap, ImageListThumbs->Width, ImageListThumbs->Height);
            //ResizeBitmapScale(Bitmap, ImageListThumbs->Width, ImageListThumbs->Height, pf24bit);

            TListItem *Item = ListView2->Items->Add();
            Item->Caption = CoverArtData.Name;
            Item->ImageIndex = ImageListThumbs->Add(Bitmap, NULL);

         }
         __finally
         {
            delete (Bitmap);
            delete (PictureStream);
         }

      }

   }

}

//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------

