//-----------------------------------------------------------------------------
#include <JPEG.hpp>
#include <PNGImage.hpp>
#include <gifimg.hpp>
#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include "WMATagLibrary.hpp"

#pragma package(smart_init)
#pragma resource "*.dfm"


TWMATag *WMATag;
int CoverArtIndex;
bool IsSaving;
String LastArtPath;
String LastWMAPath;

//converted to C++ by RMJ 02/2015

TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner) : TForm(Owner)
{
}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button2Click(TObject *Sender)
{
   Edit2->Text = "";
   Edit3->Text = "";
   Edit4->Text = "";
   Memo1->Clear();
   Image1->Picture = NULL;

   OpenDialog1->Filter = L"WM* Files|*.WMV;*.WMA|";
   OpenDialog1->InitialDir = LastWMAPath;
   OpenDialog1->FileName = L"";

   if(OpenDialog1->Execute())
   {
      Edit1->Text = OpenDialog1->FileName;
      LastWMAPath = ExtractFilePath(OpenDialog1->FileName);
   }

   Button4->Click();

}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button4Click(TObject *Sender)
{

   //Load the tag
   WMATag->LoadFromFile(Edit1->Text);
   //Display some fields
   Edit2->Text = WMATag->ReadFrameByNameAsText(g_wszWMAuthor);
   Edit3->Text = WMATag->ReadFrameByNameAsText(g_wszWMTitle);
   Edit4->Text = WMATag->ReadFrameByNameAsText(g_wszWMAlbumTitle);

   //List all attributes
   Memo1->Clear();
   Image1->Picture = NULL;

   for(int i = 0; i < WMATag->Count(); i++)
   {
      if(WMATag->Frames[i]->Format == WMT_TYPE_STRING)
      {
         Memo1->Lines->Add(WMATag->Frames[i]->Name + L" = " + WMATag->Frames[i]->GetAsText());
      }
      else
      {
         Memo1->Lines->Add(WMATag->Frames[i]->Name + L" = " + IntToStr(WMATag->Frames[i]->GetAsInteger()) + " (" + IntToStr(WMATag->Frames[i]->Stream->Size) + " bytes)");
      }
   }

   //Display 1st cover art
   DisplayCoverArt(0);

}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button3Click(TObject *Sender)
{
   String oldCaption = Form1->Caption;
   Form1->Caption = "Saving...please be patient";

   IsSaving = true;
   Button1->Enabled = false;
   Button2->Enabled = false;
   Button3->Enabled = false;
   Button4->Enabled = false;
   Button5->Enabled = false;
   Button7->Enabled = false;
   Button8->Enabled = false;

   //Set some fields
   //Note: if value is set it to nothing L"" it will delete the frame
   WMATag->SetTextFrameText(g_wszWMAuthor, Edit2->Text);
   WMATag->SetTextFrameText(g_wszWMTitle, Edit3->Text);
   WMATag->SetTextFrameText(g_wszWMAlbumTitle, Edit4->Text);

   //Save the tag
   WMATag->SaveToFile(Edit1->Text);

   Button1->Enabled = true;
   Button2->Enabled = true;
   Button3->Enabled = true;
   Button4->Enabled = true;
   Button5->Enabled = true;
   Button7->Enabled = true;
   Button8->Enabled = true;
   Form1->Caption = oldCaption;
   IsSaving = false;

   Button4->Click(); //reload

}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button5Click(TObject *Sender)
{
   TStream *PictureStream;
   String MIMEType, Fext, Description;
   int Index;

   OpenDialog2->Filter = L"Picture Files|*.BMP;*.JPG;*.PNG;*.GIF|";
   OpenDialog2->InitialDir = LastArtPath;
   OpenDialog2->FileName = L"";

   if(OpenDialog2->Execute())
   {
      //Add a cover art
      PictureStream = new TFileStream(OpenDialog2->FileName, fmOpenRead);

      Fext = ExtractFileExt(OpenDialog2->FileName).UpperCase();
      if((Fext == L".JPG") ||(Fext == L".JPEG"))
      {
         MIMEType = L"image/jpg";
      }
      if(Fext == L".PNG")
      {
         MIMEType = L"image/png";
      }
      if(Fext == L".BMP")
      {
         MIMEType = L"image/bmp";
      }
      if(Fext == L".GIF")
      {
         MIMEType = L"image/gif";
      }

      try
      {
         Description = MIMEType; //"No description";
         Index = WMATag->AddFrame(g_wszWMPicture)->Index;
         WMATag->SetCoverArtFrame(Index, PictureStream, MIMEType, 3, Description);
         LastArtPath = ExtractFilePath(OpenDialog2->FileName);

         Button3->Click(); //save
      }
      __finally
      {
         delete PictureStream;
      }

   }

}

//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender)
{

   WMATag = new TWMATag;

}

//---------------------------------------------------------------------------

void __fastcall TForm1::FormDestroy(TObject *Sender)
{
   delete (WMATag);
}

//---------------------------------------------------------------------------

void __fastcall TForm1::DisplayCoverArt(int Index)
{
   TStream    *PictureStream;
   TJPEGImage *ImageJPEG;
   TPngImage  *ImagePNG;
   TGIFImage  *ImageGIF;
   TBitmap    *ImageBMP;
   int i, CoverArtCounter;
   String MIMEType, Description;
   BYTE PictureType;

   CoverArtCounter = -1;

   for(i = 0; i < WMATag->Count(); i++)
   {
      if(WMATag->Frames[i]->Name == g_wszWMPicture)
      {
         CoverArtCounter++;
         if(CoverArtCounter == Index)
         {
            PictureStream = new TMemoryStream;
            try
            {
               if(WMATag->GetCoverArtFromFrame(i, PictureStream, MIMEType, PictureType, Description))
               {
                  MIMEType = LowerCase(MIMEType);
                  PictureStream->Seek((__int64)0, (WORD)soBeginning);
                  if((MIMEType == L"image/jpeg") || (MIMEType == L"image/jpg"))
                  {
                     ImageJPEG = new TJPEGImage;
                     ImageJPEG->LoadFromStream(PictureStream);
                     Image1->Picture->Assign(ImageJPEG);
                     delete (ImageJPEG);
                  }
                  if(MIMEType == L"image/gif")
                  {
                     ImageGIF = new TGIFImage;
                     ImagePNG->LoadFromStream(PictureStream);
                     Image1->Picture->Assign(ImageGIF);
                     delete (ImageGIF);
                  }
                  if(MIMEType == L"image/png")
                  {
                     ImagePNG = new TPngImage;
                     ImagePNG->LoadFromStream(PictureStream);
                     Image1->Picture->Assign(ImagePNG);
                     delete (ImagePNG);
                  }
                  if(MIMEType == L"image/bmp")
                  {
                     ImageBMP = new TBitmap;
                     ImageBMP->LoadFromStream(PictureStream);
                     Image1->Picture->Assign(ImageBMP);
                     delete (ImageBMP);
                  }

                  CoverArtIndex = Index;
               }
            }
            __finally
            {
               delete (PictureStream);
            }

         }

      }

   }

}

//---------------------------------------------------------------------------

void __fastcall TForm1::UpDown1ChangingEx(TObject *Sender, bool &AllowChange, int NewValue, TUpDownDirection Direction)
{

   if(Direction == updUp)
   {
      DisplayCoverArt(CoverArtIndex + 1);
   }
   if(Direction == updDown)
   {
      DisplayCoverArt(CoverArtIndex - 1);
   }

}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{

   Close();

}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button7Click(TObject *Sender)
{
    int CoverArtCounter = -1;

   if(Application->MessageBox(L"Are you sure you want to delete the \r\ndisplayed cover from the tag?", L"Confirm",
      MB_YESNO | MB_ICONWARNING | MB_DEFBUTTON1 | MB_APPLMODAL | MB_SETFOREGROUND | MB_TOPMOST) == IDYES)
   {
       //delete the displayed art index
      for(int i = 0; i < WMATag->Count(); i++)
      {
         if(WMATag->Frames[i]->Name == g_wszWMPicture)
         {
            CoverArtCounter++;
            if(CoverArtCounter == CoverArtIndex)
            {
                WMATag->DeleteFrame(i);
                Button3->Click(); //save
                break;
            }
         }
      }
   }
}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button8Click(TObject *Sender)
{
   TStream    *PictureStream;
   TJPEGImage *ImageJPEG;
   TPngImage  *ImagePNG;
   TGIFImage  *ImageGIF;
   TBitmap    *ImageBMP;
   int i, CoverArtCounter;
   String MIMEType, Description, FName;
   BYTE PictureType;

   CoverArtCounter = -1;

   for(i = 0; i < WMATag->Count(); i++)
   {
      if(WMATag->Frames[i]->Name == g_wszWMPicture)
      {
         CoverArtCounter++;
         if(CoverArtCounter == CoverArtIndex)
         {
            PictureStream = new TMemoryStream;

            try
            {
               if(WMATag->GetCoverArtFromFrame(i, PictureStream, MIMEType, PictureType, Description))
               {
                  MIMEType = LowerCase(MIMEType);
                  PictureStream->Seek((__int64)0, (WORD)soBeginning);

                  //JPG
                  if((MIMEType == L"image/jpeg") || (MIMEType == L"image/jpg"))
                  {
                     FName = L"Image.jpg";
                     SaveDialog1->Filter = L"Picture Files|*.JPG|";
                  }
                  //PNG
                  if(MIMEType == L"image/png")
                  {
                     FName = L"Image.png";
                     SaveDialog1->Filter = L"Picture Files|*.PNG|";
                  }
                  //GIF
                  if(MIMEType == L"image/gif")
                  {
                     FName = L"Image.gif";
                     SaveDialog1->Filter = L"Picture Files|*.GIF|";
                  }
                  //BMP
                  if(MIMEType == L"image/bmp")
                  {
                     FName = L"Image.bmp";
                     SaveDialog1->Filter = L"Picture Files|*.BMP|";
                  }

                  SaveDialog1->FileName = FName;

                  if(SaveDialog1->Execute())
                  {
                     if((MIMEType == L"image/jpeg") || (MIMEType == L"image/jpg"))
                     {
                        ImageJPEG = new TJPEGImage;
                        ImageJPEG->LoadFromStream(PictureStream);
                        ImageJPEG->SaveToFile(SaveDialog1->FileName);
                        delete (ImageJPEG);
                     }
                     if(MIMEType == L"image/gif")
                     {
                        ImageGIF = new TGIFImage;
                        ImageGIF->LoadFromStream(PictureStream);
                        ImageGIF->SaveToFile(SaveDialog1->FileName);
                        delete (ImageGIF);
                     }
                     if(MIMEType == L"image/png")
                     {
                        ImagePNG = new TPngImage;
                        ImagePNG->LoadFromStream(PictureStream);
                        ImagePNG->SaveToFile(SaveDialog1->FileName);
                        delete (ImagePNG);
                     }
                     if(MIMEType == L"image/bmp")
                     {
                        ImageBMP = new TBitmap;
                        ImageBMP->LoadFromStream(PictureStream);
                        ImageBMP->SaveToFile(SaveDialog1->FileName);
                        delete (ImageBMP);
                     }

                   }


               }
               else
               {
                  ShowMessage(L"Could not find art data!");
               }

            }
            __finally
            {
               delete (PictureStream);
            }

         }

      }

   }

}

//---------------------------------------------------------------------------

void __fastcall TForm1::FormCloseQuery(TObject *Sender, bool &CanClose)
{

    //try to keep user from corrupting their file
    CanClose = (IsSaving == false);
    if(!CanClose)
      ShowMessage(L"You can not quit while a save is in progress.");

}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button6Click(TObject *Sender)
{
   if(Edit1->Text <= L"")
      return;

   if(Application->MessageBox(L"Are you sure you want to remove the entire tag?\r\n", L"Confirm",
      MB_YESNO|MB_ICONWARNING|MB_DEFBUTTON1|MB_APPLMODAL|MB_SETFOREGROUND|MB_TOPMOST) == IDYES)
   {
      WMATag->DeleteAllFrames();
      WMATag->SaveToFile(Edit1->Text);

      Button4->Click(); //reload
   }

}

//---------------------------------------------------------------------------

