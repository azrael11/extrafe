//---------------------------------------------------------------------------
#include <JPEG.hpp>
#include <PNGImage.hpp>
#include <gifimg.hpp>
#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include "FlacTagLibrary.hpp"



//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"


TFlacTag *FLACfile;
TFlacTagCoverArtInfo FlacTagCoverArt;

static int CoverArtIndex = -1;

//converted to C++ by RMJ 02/2015


TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner) : TForm(Owner)
{
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

//---------------------------------------------------------------------------

void __fastcall TForm1::Button2Click(TObject *Sender)
{
   OpenDialogFlac->Filter = L"FLAC Files|*.FLAC|";

   Image1->Picture = NULL;

   Edit1->Text = L"";
   Edit2->Text = L"";
   Edit3->Text = L"";
   Edit4->Text = L"";
   Edit5->Text = L"";
   Edit6->Text = L"";
   Edit7->Text = L"";
   Edit8->Text = L"";
   Edit9->Text = L"";
   Memo1->Clear();

   if(OpenDialogFlac->Execute())
   {
      Edit1->Text = OpenDialogFlac->FileName;
      Button3->Click(); //reload
   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button3Click(TObject *Sender)
{
   int i;
   int iMetaType;
   int Error;
   CoverArtIndex =  - 1;

   Image1->Picture = NULL;
   Edit2->Text = L"";
   Edit3->Text = L"";
   Edit4->Text = L"";
   Edit5->Text = L"";
   Edit6->Text = L"";
   Edit7->Text = L"";
   Edit8->Text = L"";
   Edit9->Text = L"";
   Memo1->Clear();

   Error = FLACfile->LoadFromFile(Edit1->Text);
   if(Error != FLACTAGLIBRARY_SUCCESS)
   {
      ShowMessage(L"Error while loading tag, error code: " + IntToStr(Error));
      return;
   }

   Edit2->Text = FLACfile->ReadFrameByNameAsText(L"TITLE");
   Edit3->Text = FLACfile->ReadFrameByNameAsText(L"ARTIST");
   Edit4->Text = FLACfile->ReadFrameByNameAsText(L"ALBUM");
   Edit5->Text = FLACfile->ReadFrameByNameAsText(L"GENRE");
   Edit6->Text = FLACfile->ReadFrameByNameAsText(L"DATE");
   Edit7->Text = FLACfile->ReadFrameByNameAsText(L"TRACKNUMBER");
   Edit8->Text = FLACfile->ReadFrameByNameAsText(L"DISC");
   Edit9->Text = FLACfile->ReadFrameByNameAsText(L"COMMENT");

   //List other meta blocks found
   Memo1->Clear();

   //i have no idea what this is for, nor how to use it
   //you will have to experiment with this yourself     -RMJ
   for(i = 0; i < FLACfile->aMetaBlockOther.Length; i++)
   {
       iMetaType = (FLACfile->aMetaBlockOther[i].MetaDataBlockHeader[1] & 0x7F);
       Memo1->Lines->Add(String(L"Meta block ") + IntToStr(iMetaType) + " = " + IntToStr(FLACfile->aMetaBlockOther[i].Data->Size) + " bytes");
   }
   //

   for(i = 0; i < FLACfile->CoverArtCount(); i++)
   {
       Memo1->Lines->Add(String(L"Cover art block = ") + IntToStr(FLACfile->MetaBlocksCoverArts[i].Data->Size) + " bytes");
   }

   CoverArtIndex = 0;
   DisplayCoverArt(CoverArtIndex);

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button4Click(TObject *Sender)
{
   int Error;

   FLACfile->SetTextFrameText(L"TITLE", Edit2->Text);
   FLACfile->SetTextFrameText(L"ARTIST", Edit3->Text);
   FLACfile->SetTextFrameText(L"ALBUM", Edit4->Text);
   FLACfile->SetTextFrameText(L"GENRE", Edit5->Text);
   FLACfile->SetTextFrameText(L"DATE", Edit6->Text);
   FLACfile->SetTextFrameText(L"TRACKNUMBER", Edit7->Text);
   FLACfile->SetTextFrameText(L"DISC", Edit8->Text);
   FLACfile->SetTextFrameText(L"COMMENT", Edit9->Text);

   Error = FLACfile->SaveToFile(Edit1->Text);
   if(Error != FLACTAGLIBRARY_SUCCESS)
   {
      ShowMessage(L"Error while saving tag, error code: " + IntToStr(Error));
   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button5Click(TObject *Sender)
{

   int Error;
   Error = RemoveFlacTagFromFile(Edit1->Text);
   if(Error != FLACTAGLIBRARY_SUCCESS)
   {
      ShowMessage(L"Error while removing tag, error code: " + IntToStr(Error));
   }

   Button3->Click(); //reload

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button6Click(TObject *Sender)
{
   TJPEGImage *JPEGPicture;
   TPngImage  *PNGPicture;
   TGIFImage  *GIFPicture;
   Graphics::TBitmap *BMPPicture;
   TFileStream *NewPictureStream;
   int Index;
   int Error;
   String Fext, MIMETYPEStr;

   Image1->Picture = NULL;
   Index = 0;

   OpenDialogCoverArt->Title = L"Open";
   OpenDialogCoverArt->Filter = L"Picture Files|*.BMP;*.JPG;*.PNG;*.GIF|";

   if(OpenDialogCoverArt->Execute())
   {
      try
      {
         FLACfile->LoadFromFile(Edit1->Text);

         Fext = ExtractFileExt(OpenDialogCoverArt->FileName).UpperCase();
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

         Index = FLACfile->AddMetaDataCoverArt(NULL, 0);
         NewPictureStream = new TFileStream(OpenDialogCoverArt->FileName, fmOpenRead);

         try
         {
            //JPG
            if((MIMETYPEStr == L"image/jpeg") || (MIMETYPEStr == L"image/jpg"))
            {
               JPEGPicture = new TJPEGImage;
               JPEGPicture->LoadFromStream(NewPictureStream);
               JPEGPicture->DIBNeeded();
               FlacTagCoverArt.Width  = JPEGPicture->Width;
               FlacTagCoverArt.Height = JPEGPicture->Height;
               FreeAndNULL(JPEGPicture);
            }
            //PNG
            if(MIMETYPEStr == L"image/png")
            {
               PNGPicture = new TPngImage;
               PNGPicture->LoadFromStream(NewPictureStream);
               FlacTagCoverArt.Width  = PNGPicture->Width;
               FlacTagCoverArt.Height = PNGPicture->Height;
               FreeAndNULL(PNGPicture);
            }
            //GIF
            if(MIMETYPEStr == L"image/gif")
            {
               GIFPicture = new TGIFImage;
               GIFPicture->LoadFromStream(NewPictureStream);
               FlacTagCoverArt.Width  = GIFPicture->Width;
               FlacTagCoverArt.Height = GIFPicture->Height;
               FreeAndNULL(GIFPicture);
            }
            //BMP
            if(MIMETYPEStr == L"image/bmp")
            {
               BMPPicture = new Graphics::TBitmap;
               BMPPicture->LoadFromStream(NewPictureStream);
               FlacTagCoverArt.Width  = BMPPicture->Width;
               FlacTagCoverArt.Height = BMPPicture->Height;
               FreeAndNULL(BMPPicture);
            }

            FlacTagCoverArt.PictureType = ((FLACfile->CoverArtCount() <= 1)? 3 : 0);
            FlacTagCoverArt.MIMEType    = MIMETYPEStr;
            FlacTagCoverArt.Description = MIMETYPEStr; //ExtractFileName(OpenDialogCoverArt->FileName);
            FlacTagCoverArt.ColorDepth  = 24;
            FlacTagCoverArt.NoOfColors  = 256;

            if(!FLACfile->SetCoverArt(Index, NewPictureStream, FlacTagCoverArt))
            {
               ShowMessage(L"Error while adding cover art.");
            }

            UpDown1Click(Sender, btNext);

         }
         __finally
         {
            FreeAndNULL(NewPictureStream);
         }

         Error = FLACfile->SaveToFile(Edit1->Text);
         if(Error != FLACTAGLIBRARY_SUCCESS)
         {
            ShowMessage(L"Error while saving tag, error code: " + IntToStr(Error));
         }

      }
      __finally
      {
         //reload
         Button3Click(Sender);

         //display added cover art
         DisplayCoverArt(Index);
      }

   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button7Click(TObject *Sender)
{
   int Index;
   TStream *PictureStream;
   String Fext;

   Index = CoverArtIndex;

   if(Index > -1)
   {
      PictureStream = new TMemoryStream;

      try
      {
         if(FLACfile->GetCoverArt(Index, PictureStream, FlacTagCoverArt)
         )
         {
            FlacTagCoverArt.MIMEType = LowerCase(FlacTagCoverArt.MIMEType);
            PictureStream->Seek(0, soFromBeginning);

            //JPG
            if((FlacTagCoverArt.MIMEType == L"image/jpeg") || (FlacTagCoverArt.MIMEType == L"image/jpg"))
            {
               Fext = L".jpg";
               OpenDialogCoverArt->Filter = L"Picture Files|*.JPG|";
            }
            //PNG
            if(FlacTagCoverArt.MIMEType == L"image/png")
            {
               Fext = L".png";
               OpenDialogCoverArt->Filter = L"Picture Files|*.PNG|";
            }
            //GIF
            if(FlacTagCoverArt.MIMEType == L"image/gif")
            {
               Fext = L".gif";
               OpenDialogCoverArt->Filter = L"Picture Files|*.GIF|";
            }
            //BMP
            if(FlacTagCoverArt.MIMEType == L"image/bmp")
            {
               Fext = L".bmp";
               OpenDialogCoverArt->Filter = L"Picture Files|*.BMP|";
            }

            OpenDialogCoverArt->Title = L"Save";
            OpenDialogCoverArt->FileName = FlacTagCoverArt.Description;

            if(OpenDialogCoverArt->Execute())
            {
              ((TMemoryStream*)PictureStream)->SaveToFile(ChangeFileExt(OpenDialogCoverArt->FileName, Fext));
            }

         }

      }
      __finally
      {
         FreeAndNULL(PictureStream);
      }

   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::DisplayCoverArt(int Index)
{
   TJPEGImage *JPEGPicture;
   TPngImage  *PNGPicture;
   TGIFImage  *GIFPicture;
   TStream    *PictureStream;

   try
   {
      if(Index >  - 1)
      {
         PictureStream = new TMemoryStream;

         try
         {
            if(FLACfile->GetCoverArt(Index, PictureStream, FlacTagCoverArt))
            {
               PictureStream->Seek(0, soFromBeginning);

               //JPG
               if((FlacTagCoverArt.MIMEType == L"image/jpeg") || (FlacTagCoverArt.MIMEType == L"image/jpg"))
               {
                  JPEGPicture = new TJPEGImage;
                  JPEGPicture->LoadFromStream(PictureStream);
                  JPEGPicture->DIBNeeded();
                  Image1->Picture->Assign(JPEGPicture);
                  FreeAndNULL(JPEGPicture);
               }
               //PNG
               if(FlacTagCoverArt.MIMEType == L"image/png")
               {
                  PNGPicture = new TPngImage;
                  PNGPicture->LoadFromStream(PictureStream);
                  Image1->Picture->Assign(PNGPicture);
                  FreeAndNULL(PNGPicture);
               }
               //GIF
               if(FlacTagCoverArt.MIMEType == L"image/gif")
               {
                  GIFPicture = new TGIFImage;
                  GIFPicture->LoadFromStream(PictureStream);
                  Image1->Picture->Assign(GIFPicture);
                  FreeAndNULL(GIFPicture);
               }
               //BMP
               if(FlacTagCoverArt.MIMEType == L"image/bmp")
               {
                  Image1->Picture->Bitmap->LoadFromStream(PictureStream);
               }

               CoverArtIndex = Index;
            }

         }
         __finally
         {
            FreeAndNULL(PictureStream);
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

   FLACfile = new TFlacTag;

}

//-------------------------------------------------------------------------

void __fastcall TForm1::FormDestroy(TObject *Sender)
{

   delete FLACfile;

}

//-------------------------------------------------------------------------

void __fastcall TForm1::UpDown1Click(TObject *Sender, TUDBtnType Button)
{

   Application->ProcessMessages();

   if(Button == btNext)
   {
      DisplayCoverArt(CoverArtIndex + 1);
   }
   if(Button == btPrev)
   {
      DisplayCoverArt(CoverArtIndex - 1);
   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{

    Close();

}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button8Click(TObject *Sender)
{

   FLACfile->DeleteCoverArt(CoverArtIndex);

   Button4->Click(); //save
   Button3->Click(); //reload

}

//---------------------------------------------------------------------------

