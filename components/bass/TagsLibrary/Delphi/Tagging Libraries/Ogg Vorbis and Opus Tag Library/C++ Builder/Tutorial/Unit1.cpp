//---------------------------------------------------------------------------
#include <JPEG.hpp>
#include <PNGImage.hpp>
#include <gifimg.hpp>
#include <vcl.h>
#pragma hdrstop

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"

#include "Unit1.h"
#include "OggVorbisAndOpusTagLibrary.hpp"


TOpusTag *OpusTag;
TOpusVorbisCoverArtInfo CoverArt;
static int CoverArtIndex;

//converted to C++ by RMJ 02/2015

TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner) : TForm(Owner)
{
}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{

   Close();

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button2Click(TObject *Sender)
{
   Edit2->Text = L"";
   Edit3->Text = L"";
   Edit4->Text = L"";
   Edit5->Text = L"";
   Edit6->Text = L"";
   Edit7->Text = L"";
   Edit8->Text = L"";
   Edit9->Text = L"";
   Image1->Picture = NULL;

   OpenDialog->FileName = L"";
   OpenDialog->Filter = L"OGG Files|*.OGG|";

   if(OpenDialog->Execute())
   {
      Edit1->Text = OpenDialog->FileName;
      Button3->Click();
   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button3Click(TObject *Sender)
{
   int i;

   OpusTag->LoadFromFile(Edit1->Text);

   //list specific tags
   Edit2->Text = OpusTag->ReadFrameByNameAsText(L"TITLE");
   Edit3->Text = OpusTag->ReadFrameByNameAsText(L"ARTIST");
   Edit4->Text = OpusTag->ReadFrameByNameAsText(L"ALBUM");
   Edit5->Text = OpusTag->ReadFrameByNameAsText(L"GENRE");
   Edit6->Text = OpusTag->ReadFrameByNameAsText(L"YEAR");
   Edit7->Text = OpusTag->ReadFrameByNameAsText(L"TRACK");
   Edit8->Text = OpusTag->ReadFrameByNameAsText(L"DISC");
   Edit9->Text = OpusTag->ReadFrameByNameAsText(L"COMMENT");

   Image1->Picture->Assign(NULL);
   CoverArtIndex = 0;

   //get first cover art if exists
   for(int t=0; t < OpusTag->Count(); t++)
   {
      if(OpusTag->Frames[t]->Name == OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE)
      {
         CoverArtIndex = t;
         break;
      }

   }

   DisplayCoverArt(CoverArtIndex);

   //list all tags found
   Memo1->Clear();
   Memo1->Lines->Add(L"Vendor = " + OpusTag->VendorString);

   for(i = 0; i < OpusTag->Count(); i++)
   {
      if(OpusTag->Frames[i]->Name == OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE)
      {
         Memo1->Lines->Add(OpusTag->Frames[i]->Name + " = " + IntToStr(OpusTag->Frames[i]->Stream->Size) + L" bytes");
      }
      else
      {
         Memo1->Lines->Add(OpusTag->Frames[i]->Name + " = " + OpusTag->Frames[i]->GetAsText());
      }

   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button4Click(TObject *Sender)
{
   int Error;

   //set specific tags
   OpusTag->SetTextFrameText(L"TITLE", Edit2->Text);
   OpusTag->SetTextFrameText(L"ARTIST", Edit3->Text);
   OpusTag->SetTextFrameText(L"ALBUM", Edit4->Text);
   OpusTag->SetTextFrameText(L"GENRE", Edit5->Text);
   OpusTag->SetTextFrameText(L"YEAR", Edit6->Text);
   OpusTag->SetTextFrameText(L"TRACK", Edit7->Text);
   OpusTag->SetTextFrameText(L"DISC", Edit8->Text);
   OpusTag->SetTextFrameText(L"COMMENT", Edit9->Text);

   //save the tag
   Error = OpusTag->SaveToFile(Edit1->Text);
   if(Error != OPUSTAGLIBRARY_SUCCESS)
   {
      ShowMessage(String(L"Error while saving tag, error code: ") + IntToStr(Error));
   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button5Click(TObject *Sender)
{

   int Error = RemoveOpusTagFromFile(Edit1->Text);
   if(Error != OPUSTAGLIBRARY_SUCCESS)
   {
      ShowMessage(String(L"Error while saving tag, error code: ") + IntToStr(Error));
   }

   Button3->Click(); //reload

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button6Click(TObject *Sender)
{
   TJPEGImage *JPEGPicture;
   TPngImage  *PNGPicture;
   TGIFImage  *GIFPicture;
   TBitmap *BMPPicture;
   TFileStream *NewPictureStream;
   int Index;
   int Error;
   String Fext, MIMETYPEStr;

   OpenDialog->FileName = L"";
   OpenDialog->Filter = L"Picture Files|*.BMP;*.JPG;*.PNG;*.GIF|";

   if(OpenDialog->Execute())
   {
      OpusTag->LoadFromFile(Edit1->Text);
      Fext = ExtractFileExt(OpenDialog->FileName).UpperCase();

      if((Fext == L".JPG") ||(Fext == L".JPEG"))
      {
         MIMETYPEStr = L"image/jpeg";
      }
      if(Fext == L".PNG")
      {
         MIMETYPEStr = L"image/png";
      }
      if(Fext == L".BMP")
      {
         MIMETYPEStr = L"image/bmp";
      }
      if(Fext == L".GIF")
      {
         MIMETYPEStr = L"image/gif";
      }

      NewPictureStream = new TFileStream(OpenDialog->FileName, fmOpenRead);

      try
      {
          //JPG
         if((MIMETYPEStr == L"image/jpeg") || (MIMETYPEStr == L"image/jpg"))
         {
            JPEGPicture = new TJPEGImage;
            JPEGPicture->LoadFromStream(NewPictureStream);
            JPEGPicture->DIBNeeded();
            CoverArt.Width  = JPEGPicture->Width;
            CoverArt.Height = JPEGPicture->Height;
            delete JPEGPicture;
         }
         //PNG
         if(MIMETYPEStr == L"image/png")
         {
            PNGPicture = new TPngImage;
            PNGPicture->LoadFromStream(NewPictureStream);
            CoverArt.Width  = PNGPicture->Width;
            CoverArt.Height = PNGPicture->Height;
            delete PNGPicture;
         }
         //GIF
         if(MIMETYPEStr == L"image/gif")
         {
            GIFPicture = new TGIFImage;
            GIFPicture->LoadFromStream(NewPictureStream);
            CoverArt.Width  = GIFPicture->Width;
            CoverArt.Height = GIFPicture->Height;
            delete GIFPicture;
         }
         //BMP
         if(MIMETYPEStr == L"image/bmp")
         {
            BMPPicture = new Graphics::TBitmap;
            BMPPicture->LoadFromStream(NewPictureStream);
            CoverArt.Width  = BMPPicture->Width;
            CoverArt.Height = BMPPicture->Height;
            delete BMPPicture;
         }

         CoverArt.PictureType = ((OpusTag->CoverArtCount() <= 1)? 3 : 0);
         CoverArt.MIMEType    = MIMETYPEStr;
         CoverArt.Description = ExtractFileName(OpenDialog->FileName);
         CoverArt.ColorDepth  = 24;
         CoverArt.NoOfColors  = 256;

         Image1->Picture->Assign(NULL);

         Index = OpusTag->AddCoverArtFrame(NewPictureStream, CoverArt);
         if(Index == -1)
         {
            ShowMessage(L"Error while adding cover art.");
            DisplayCoverArt(0);
            return;
         }

         CoverArtIndex = Index;
         DisplayCoverArt(CoverArtIndex);
         OpusTag->SaveToFile(Edit1->Text);

      }
      __finally
      {
         delete (NewPictureStream);
         UpDown1Click(NULL, btNext);
      }

   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button7Click(TObject *Sender)
{
   int Index = CoverArtIndex;
   TStream *PictureStream;
   String Fext;

   if(!OpusTag->FrameExists(OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE))
      return;

   if(Index > -1)
   {
      PictureStream = new TMemoryStream;

      try
      {
         if(OpusTag->GetCoverArtFromFrame(CoverArtIndex, PictureStream, CoverArt))
         {
            CoverArt.MIMEType = LowerCase(CoverArt.MIMEType);

            PictureStream->Seek((__int64)0, (WORD)soFromBeginning);
            //JPG
            if((CoverArt.MIMEType == L"image/jpeg") || (CoverArt.MIMEType == L"image/jpg"))
            {
               Fext = L".jpg";
               OpenDialog->Filter = L"JPG Files|*.JPG|";
            }
            //PNG
            if(CoverArt.MIMEType == L"image/png")
            {
               Fext = L".png";
               OpenDialog->Filter = L"PNG Files|*.PNG|";
            }
            //GIF
            if(CoverArt.MIMEType == L"image/gif")
            {
               Fext = L".gif";
               OpenDialog->Filter = L"GIF Files|*.GIF|";
            }
            //BMP
            if(CoverArt.MIMEType == L"image/bmp")
            {
               Fext = L".bmp";
               OpenDialog->Filter = L"BMP Files|*.BMP|";
            }

            OpenDialog->FileName = CoverArt.Description;

            if(OpenDialog->Execute())
            {
               ((TMemoryStream*)PictureStream)->SaveToFile(ChangeFileExt(OpenDialog->FileName, Fext));
            }

         }

      }
      __finally
      {
         delete (PictureStream);
      }

   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::DisplayCoverArt(int index)
{
   int ret = -1;
   TJPEGImage *JPEGPicture;
   TPngImage *PNGPicture;
   TGIFImage *GIFPicture;
   TStream *PictureStream;

   try
   {
      //make sure we at least have 1
      ret = OpusTag->FrameExists(OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE);

      if(ret <= -1)
        return;
      else if(index > -1)
      {
         PictureStream = new TMemoryStream;

         try
         {
            if(OpusTag->GetCoverArtFromFrame(index, PictureStream, CoverArt))
            {
               CoverArt.MIMEType = LowerCase(CoverArt.MIMEType);
               PictureStream->Seek((__int64)0, (WORD)soFromBeginning);

               //JPG
               if((CoverArt.MIMEType == L"image/jpeg") || (CoverArt.MIMEType == L"image/jpg"))
               {
                  JPEGPicture = new TJPEGImage;
                  JPEGPicture->LoadFromStream(PictureStream);
                  JPEGPicture->DIBNeeded();
                  Image1->Picture->Assign(JPEGPicture);
                  delete (JPEGPicture);
               }
               //PNG
               if(CoverArt.MIMEType == L"image/png")
               {
                  PNGPicture = new TPngImage;
                  PNGPicture->LoadFromStream(PictureStream);
                  Image1->Picture->Assign(PNGPicture);
                  delete (PNGPicture);
               }
               //GIF
               if(CoverArt.MIMEType == L"image/gif")
               {
                  GIFPicture = new TGIFImage;
                  GIFPicture->LoadFromStream(PictureStream);
                  Image1->Picture->Assign(GIFPicture);
                  delete (GIFPicture);
               }
               //BMP
               if(CoverArt.MIMEType == L"image/bmp")
               {
                  Image1->Picture->Bitmap->LoadFromStream(PictureStream);
               }

            }

         }
         __finally
         {
            delete (PictureStream);
         }

      }

   }
   catch(...)
   {
      ;
   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender)
{

   OpusTag = new TOpusTag;

   //Padding is useful when the new tag fits in the existing tag, the file is not re-created only the tag is re-written.
   //It also doesn't need exclusive access to the file, so the file can be locked.
   //For Opus files it will add a 'PADDING' tag filled with '#'.
   //Set to write padding globaly
   //OpusTagLibraryWritePadding = True;
   //Optionally set global padding size
   //OpusTagLibraryPaddingSize := 4096;
   //Also it is possible to specify the padding options for a particular object-> Note that global options are copied when creating an object
   //OpusTag->WritePadding = True;
   //OpusTag->PaddingSize = 1024;

}

//-------------------------------------------------------------------------

void __fastcall TForm1::FormDestroy(TObject *Sender)
{

   delete OpusTag;

}

//-------------------------------------------------------------------------

void __fastcall TForm1::UpDown1Click(TObject *Sender, TUDBtnType Button)
{
   int i = 0;

   Application->ProcessMessages();

   if(Button == btNext)
   {
      for(i = 0; i < OpusTag->Count(); i++)
      {
         if(OpusTag->Frames[i]->Name == OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE)
         {
            if(i > CoverArtIndex)
            {
               CoverArtIndex++;
               DisplayCoverArt(CoverArtIndex);
               break;
            }
         }
      }
   }
   if(Button == btPrev)
   {
      for(i = OpusTag->Count() - 1; i > 0; i--)
      {
         if(OpusTag->Frames[i]->Name == OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE)
         {
            if(i < CoverArtIndex)
            {
               CoverArtIndex--;
               DisplayCoverArt(CoverArtIndex);
               break;
            }
         }
      }
   }
}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button8Click(TObject *Sender)
{

    if(OpusTag->Frames[CoverArtIndex]->Name == OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE)
    {
       OpusTag->DeleteFrame(CoverArtIndex);
       UpDown1Click(NULL, btPrev);
    }

   Button4->Click(); //save
   Button3->Click(); //reload

}
//---------------------------------------------------------------------------

