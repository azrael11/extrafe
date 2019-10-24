//---------------------------------------------------------------------------
#include <JPEG.hpp>
#include <PNGImage.hpp>
#include <gifimg.hpp>
#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include "ID3v1Library.hpp"
#include "ID3v2Library.hpp"

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"


TID3v1Tag *ID3v1Tag;
TID3v2Tag *ID3v2Tag;
int CurrentAPICIndex = -1;
String LastArtPath;

//converted to C++ by RMJ 02/2015

TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent *Owner): TForm(Owner)
{

   //create both Tag classes
   ID3v1Tag = new TID3v1Tag;
   ID3v2Tag = new TID3v2Tag;

}

//---------------------------------------------------------------------------

void __fastcall TForm1::FormDestroy(TObject *Sender)
{
   //free the class
   if(ID3v1Tag != NULL)
   {
      delete ID3v1Tag;
      ID3v1Tag =  NULL;
   }

   //free the class
   if(ID3v2Tag != NULL)
   {
      delete ID3v2Tag;
      ID3v2Tag =  NULL;
   }

}

//---------------------------------------------------------------------------

void __fastcall TForm1::ResizeBitmapProportional(Graphics::TBitmap *Bitmap, int iWidth, int iHeight, TColor Background)
{
   TRect R;
   TBitmap *B;
   int x, y;

   //NOTE this resize expects pic to be displayed
   //in an equal sided square, IE 150x150, displaying
   //the bmp in a rectangle destination will not keep
   //the aspect ratio intact

   if(Bitmap != NULL)
   {
      LabelImgSize->Caption = IntToStr(Bitmap->Width) + "x" + IntToStr(Bitmap->Height);

      B = new TBitmap;

      try
      {
         if(Bitmap->Width > Bitmap->Height)
         {
            R.Right = iWidth;
            R.Bottom = (((iWidth) * Bitmap->Height ) / Bitmap->Width);
            x = 0;
            y = (iHeight / 2) - (R.Bottom / 2);
         }
         else
         {
            R.Right  = (((iHeight) * Bitmap->Width ) / Bitmap->Height);
            R.Bottom = iHeight;
            x = (iWidth / 2) - (R.Right / 2);
            y = 0;
         }
         R.Left = 0;
         R.Top = 0;
         B->PixelFormat = pf24bit;
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
   else
   {
      LabelImgSize->Caption = IntToStr(0) + "x" + IntToStr(0);
   }

}

//---------------------------------------------------------------------------

void __fastcall TForm1::ResizeBitmapBlt(Graphics::TBitmap *SrcBitmap, int width, int height)
{
    Graphics::TBitmap *abmp, *bbmp;
    abmp = new Graphics::TBitmap();
    bbmp = new Graphics::TBitmap();

    LabelImgSize->Caption = IntToStr(SrcBitmap->Width) + "x" + IntToStr(SrcBitmap->Height);

    //this resizer will stretch the bmp to
    //whatever dimensions you tell it to use

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

void __fastcall TForm1::UpDown1Click(TObject *Sender, TUDBtnType Button)
{
   int i;

   //calculate next APIC index and load it
   if(Button == btNext)
   {
      for(i = 0; i < ID3v2Tag->FrameCount; i++)
      {
         if(IsSameFrameID(ID3v2Tag->Frames[i]->ID, L"APIC"))
         {
            if(i > CurrentAPICIndex)
            {
               LoadAPIC(i);
               break;
            }
         }
      }
   }
   //calculate previous APIC index and load it
   if(Button == btPrev)
   {
      for(i = ID3v2Tag->FrameCount - 1; i != 0; i--)
      {
         if(IsSameFrameID(ID3v2Tag->Frames[i]->ID, L"APIC"))
         {
            if(i < CurrentAPICIndex)
            {
               LoadAPIC(i);
               break;
            }
         }
      }
   }
}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button3Click(TObject *Sender)
{
   int i;
   TLanguageID LanguageID;
   String Description;
   TDateTime RecordingDateTime;
   int Error;
   String Text;

   //clear all the UI
   ClearDatav2();

   //load the ID3v2 Tag
   Error = ID3v2Tag->LoadFromFile(Edit1->Text);
   if(Error != ID3V2LIBRARY_SUCCESS)
   {
      ShowMessage(L"Error loading ID3v2 tag, error code: " + IntToStr(Error) + "\r\n" + ID3v2TagErrorCode2String(Error));
   }

   //get Tag version
   if(Error != ID3V2LIBRARY_SUCCESS)
   {
      Label17->Caption = IntToStr(ID3v2Tag->MajorVersion) + "." + IntToStr(ID3v2Tag->MinorVersion);
      return ;
   }
   else
   {
      Label17->Caption = IntToStr(ID3v2Tag->MajorVersion) + "." + IntToStr(ID3v2Tag->MinorVersion);
   }

   //unsynchronised?
   CheckBox1->Checked = ID3v2Tag->Unsynchronised;

   //to parse the tag properly deunsynchronisation is needed if applied
   //note that in 'All Frames' view all frames will appear as not unsynchronised becouse of this!
   ID3v2Tag->RemoveUnsynchronisationOnAllFrames();

   //extended header exists in tag?
   CheckBox2->Checked = ID3v2Tag->ExtendedHeader;

   //tag is in experimental stage?
   CheckBox3->Checked = ID3v2Tag->Experimental;

   //extended header CRC32 exists in extended header?
   if(ID3v2Tag->MajorVersion == 3)
   {
      CheckBox4->Checked = ID3v2Tag->ExtendedHeader3->CRCPresent;
   }

   //get Title
   Edit2->Text = ID3v2Tag->GetUnicodeText(L"TIT2");

   //get Artist
   Edit3->Text = ID3v2Tag->GetUnicodeText(L"TPE1");

   //get Album
   Edit10->Text = ID3v2Tag->GetUnicodeText(L"TALB");

   //get Year
   Edit11->Text = ID3v2Tag->GetUnicodeText(L"TYER");

   //get composer
   Edit9->Text = ID3v2Tag->GetUnicodeText(L"TCOM");

   //get track #
   Edit14->Text = ID3v2Tag->GetUnicodeText(L"TRCK");

   //get Genre
   ComboBox2->Text = ID3v2Tag->GetUnicodeText(L"TCON");
   //If genre is specified as numeric use ID3GenreDataToString() in ID3v1Library to convert to a string

   //get WXXX URL (most common)
   Edit12->Text = ID3v2Tag->GetUnicodeUserDefinedURLLink(L"WOAF", Description);
   //For other URLs use GetUnicodeURL()

   //get Comment
   Memo2->Text = ID3v2Tag->GetUnicodeComment(L"COMM", LanguageID, Description);
   Edit19->Text = LanguageIDtoString(LanguageID);
   Edit18->Text = Description;

   ID3v2Tag->FindTXXXByDescription(L"COMMENT", Text);

   for(i = 0; i < ID3v2Tag->FrameCount; i++)
   {
      if(IsSameFrameID(ID3v2Tag->Frames[i]->ID, L"TCOM"))
      {
         Text = ID3v2Tag->GetUnicodeUserDefinedTextInformation(i, Description);
      }
   }

   //lyrics
   Memo3->Text = ID3v2Tag->GetUnicodeLyrics(L"USLT", LanguageID, Description);
   Edit17->Text = LanguageIDtoString(LanguageID);
   Edit20->Text = Description;

   //load first cover picture
   LoadAPIC(0);

   //get all the frame ID's
   //See 'http://www.id3.org/id3v2.4.0-frames' for all the frame types and their description
   ComboBox1->Clear();

   for(i = 0; i < ID3v2Tag->FrameCount; i++)
   {
      ComboBox1->Items->Add(ConvertFrameID2String(ID3v2Tag->Frames[i]->ID));
   }

   ComboBox1->ItemIndex = 0;

   //display frame data
   ComboBox1Change(Owner);

   for(i = 0; i < ID3v2Tag->FrameCount; i++)
   {
      if(IsSameFrameID(ID3v2Tag->Frames[i]->ID, L"PRIV"))
      {
         //...
      }

   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button5Click(TObject *Sender)
{

   ClearDatav1();

   ID3v1Tag->LoadFromFile(Edit1->Text);

   Edit4->Text  = ID3v1Tag->Title;
   Edit5->Text  = ID3v1Tag->Artist;
   Edit6->Text  = ID3v1Tag->Album;
   Edit7->Text  = ID3v1Tag->Year;
   Edit8->Text  = ID3v1Tag->Comment;
   Edit16->Text = IntToStr(ID3v1Tag->Track);
   ComboBoxID3v1_Genre->Text = ID3v1Tag->Genre;

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button4Click(TObject *Sender)
{
   ID3v2Tag->Frames[ComboBox1->ItemIndex]->RemoveUnsynchronisation();
   ComboBox1Change(Sender);
}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button6Click(TObject *Sender)
{

   int ErrorCode;
   TLanguageID LanguageID;

   if(ID3v2Tag->MajorVersion == 2)
   {
      if(Application->MessageBox(L"The tag in the file is an ID3v2.2 tag, if you click 'Yes'"
                                 L" it will be \r\nsaved as an ID3v2.3 tag. Do you want to "
                                 L"save the tag?", L"Confirm",
                                 MB_YESNO|MB_ICONWARNING|MB_DEFBUTTON2|MB_APPLMODAL|MB_SETFOREGROUND|MB_TOPMOST) == IDNO)
      {
         return;
      }

   }

   if(Memo2->Text.Length() > 0)
   {
      if(Edit19->Text.Length() <= 0)
      {
         Edit19->Text = L"eng";
      }
      if(Edit18->Text.Length() <= 0)
      {
         Edit18->Text = L"comment";
      }
   }

   if(Memo3->Text.Length() > 0)
   {
      if(Edit17->Text.Length() <= 0)
      {
         Edit17->Text = L"eng";
      }
      if(Edit20->Text.Length() <= 0)
      {
         Edit20->Text = L"lyrics";
      }
   }

   //set Title
   ID3v2Tag->SetUnicodeText(L"TIT2", Edit2->Text);

   //set Artist
   ID3v2Tag->SetUnicodeText(L"TPE1", Edit3->Text);

   //set Album
   ID3v2Tag->SetUnicodeText(L"TALB", Edit10->Text);

   //set Composer
   ID3v2Tag->SetUnicodeText(L"TCOM", Edit9->Text);

   //set Year
   ID3v2Tag->SetUnicodeText(L"TYER", Edit11->Text);

   //set Genre
   ID3v2Tag->SetUnicodeText(L"TCON", ComboBox2->Text);

   //set track no.
   ID3v2Tag->SetUnicodeText(L"TRCK", Edit14->Text);

   //set WXXX URL (most common)
   ID3v2Tag->SetURL(L"WOAF", L"\r\n" + Edit12->Text); //bug fix - crlf gets eaten
   //For other URLs use SetUnicodeURL()

   //Set Comment
   if(Memo2->Text != L"")
   {
      //Language ID is 3 bytes long ANSI string
      StringToLanguageID(Edit19->Text, LanguageID);
      ID3v2Tag->SetUnicodeComment(L"COMM", Memo2->Text, LanguageID, Edit18->Text);
   }

   //Set lyrics
   if(Memo3->Text != L"")
   {
      //language ID is 3 bytes long string we convert it here
      StringToLanguageID(Edit17->Text, LanguageID);
      ID3v2Tag->SetUnicodeLyrics(L"USLT", Memo3->Text, LanguageID, Edit20->Text);
   }
   if(CheckBox1->Checked)
   {
      ID3v2Tag->ApplyUnsynchronisationOnAllFrames();
   }

   //save the ID3v2 Tag
   ErrorCode = ID3v2Tag->SaveToFile(Edit1->Text);
   if(ErrorCode != ID3V2LIBRARY_SUCCESS)
   {
      ShowMessage(L"Error saving ID3v2 tag, error code: " + IntToStr(ErrorCode) + "\r\n" + ID3v2TagErrorCode2String(ErrorCode));
   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button7Click(TObject *Sender)
{

   ID3v2Tag->Frames[ComboBox1->ItemIndex]->ApplyUnsynchronisation();
   ComboBox1Change(Sender);

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button8Click(TObject *Sender)
{

   OpenDialog1->FileName = L"";
   OpenDialog1->Filter = "MP3 Files|*.mp3";

   if(OpenDialog1->Execute())
   {
      Edit1->Text = OpenDialog1->FileName;
      Button3->Click();
      Button5->Click();
   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button9Click(TObject *Sender)
{
   int ErrorCode;

   ID3v1Tag->Title   = Edit4->Text;
   ID3v1Tag->Artist  = Edit5->Text;
   ID3v1Tag->Album   = Edit6->Text;
   ID3v1Tag->Year    = Edit7->Text;
   ID3v1Tag->Comment = Edit8->Text;
   ID3v1Tag->Track   = StrToIntDef(Edit16->Text, 0);
   ID3v1Tag->Genre   = ComboBoxID3v1_Genre->Text;

   ErrorCode = ID3v1Tag->SaveToFile(Edit1->Text);
   if(ErrorCode != ID3V1LIBRARY_SUCCESS)
   {
      ShowMessage(String(L"Error saving ID3v1 tag, error code: " + IntToStr(ErrorCode)));
   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button10Click(TObject *Sender)
{
   String Fext;
   String MIMEType;
   int FrameIndex;
   String Description;
   int PictureType;
   int picount = ID3v2Tag->CoverArtCount();

   //add an image to the tag
   OpenDialog1->FileName = L"";
   OpenDialog1->Filter = "Picture Files|*.jpg;*.bmp;*png;*gif|";
   OpenDialog1->InitialDir = LastArtPath;

   if(OpenDialog1->Execute())
   {
      //decide MIME type according to file extension
      Fext = UpperCase(ExtractFileExt(OpenDialog1->FileName));

      if((Fext == L".JPG") || (Fext == L".JPEG"))
      {
         MIMEType = L"image/jpeg";
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

      //image's short description
      Description = MIMEType; //ExtractFileName(OpenDialog1->FileName);
      //image's type, here front cover ($03), see http://www.id3.org/id3v2.4.0-frames (APIC) on all the image types
      PictureType = ((picount == 0) ? 0x03 : 0x00);
      //create a new APIC frame
      FrameIndex = ID3v2Tag->AddFrame(L"APIC");
      //set it's data
      ID3v2Tag->SetUnicodeCoverPictureFromFile(FrameIndex, Description, OpenDialog1->FileName, MIMEType, PictureType);

      Button6->Click(); //save tag
      Button3->Click(); //reload it

   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button11Click(TObject *Sender)
{
   TStream *PictureStream;
   String MIMEType;
   String Description;
   String FileName;
   int PictureType;
   bool Success;

   PictureStream = new TMemoryStream;

   Success = ID3v2Tag->GetUnicodeCoverPictureStream(ID3v2Tag->FrameExists(L"APIC"), PictureStream, MIMEType, Description, PictureType);
   if(!Success)
   {
      Application->MessageBox(L"Error getting tag data while saving picture.", L"Save Error", MB_OK | MB_ICONWARNING | MB_DEFBUTTON1 | MB_APPLMODAL | MB_SETFOREGROUND | MB_TOPMOST);
      PictureStream = NULL;
      return;
   }

   SaveDialog1->FileName = StringReplace(MIMEType, "/", ".", TReplaceFlags() << rfReplaceAll);
   SaveDialog1->FileName = StringReplace(SaveDialog1->FileName, "jpeg", "jpg", TReplaceFlags() << rfReplaceAll);

   //set file format
   if(MIMEType == L"image/jpeg")
   {
      SaveDialog1->Filter = "JPG File|*.jpg";
   }
   if(MIMEType == L"image/png")
   {
      SaveDialog1->Filter = "PNG File|*.png";
   }
   if(MIMEType == L"image/gif")
   {
      SaveDialog1->Filter = "GIF File|*.gif";
   }
   if(MIMEType == L"image/bmp")
   {
      SaveDialog1->Filter = "BMP File|*.bmp";
   }

   if(SaveDialog1->Execute())
   {
      FileName = SaveDialog1->FileName;

      try
      {
         //set file format
         if(MIMEType == L"image/jpeg")
         {
            FileName = ChangeFileExt(FileName, L".jpg");
         }
         if(MIMEType == L"image/png")
         {
            FileName = ChangeFileExt(FileName, L".png");
         }
         if(MIMEType == L"image/gif")
         {
            FileName = ChangeFileExt(FileName, L".gif");
         }
         if(MIMEType == L"image/bmp")
         {
            FileName = ChangeFileExt(FileName, L".bmp");
         }

         //save the stream to file
         ((TMemoryStream*)PictureStream)->SaveToFile(FileName);

      }
      __finally
      {
         PictureStream->Free();
         PictureStream =  NULL;
      }

   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button12Click(TObject *Sender)
{

   LoadAPIC(0);

}

//-------------------------------------------------------------------------

bool __fastcall TForm1::LoadAPIC(int Index)
{
   TStream    *PictureStream;
   TJPEGImage *JPEGPicture;
   TGIFImage  *GIFPicture;
   TPngImage  *PNGPicture;
   TBitmap    *BMPPicture;
   bool result;
   int PictureType;

   bool Success;
   String MIMEType;
   String Description;
   int i;
   result = false;

   try
   {
      PictureStream = new TMemoryStream;

      try
      {
         if(Index == 0)
         {
            Index = ID3v2Tag->FrameExists(L"APIC");
         }
         if(Index < 0)
         {
            return result;
         }

         Success = ID3v2Tag->GetUnicodeCoverPictureStream(Index, PictureStream, MIMEType, Description, PictureType);

         //no APIC pitcure found, exit
         if((PictureStream->Size == 0) || (!Success))
         {
            return result;
         }

         //get first APIC index
         if(Index == 0)
         {
            for(i = 0; i < ID3v2Tag->FrameCount; i++)
            {
               if(IsSameFrameID(ID3v2Tag->Frames[i]->ID, L"APIC"))
               {
                  CurrentAPICIndex = i;
                  break;
               }
            }
            //store the current APIC index as Index into frame index
         }
         else
         {
            CurrentAPICIndex = Index;
         }

         //display description
         Edit15->Text = Description;

         //display type
         Label21->Caption = APICType2Str(PictureType);

         //load the APIC picture into a TImage
         PictureStream->Seek((__int64)0, (WORD)soFromBeginning);
         MIMEType = LowerCase(MIMEType);

         BMPPicture = new TBitmap;

         //JPG
         if((MIMEType == L"image/jpeg") || (MIMEType == L"image/jpg"))
         {
            JPEGPicture = new TJPEGImage;
            JPEGPicture->LoadFromStream(PictureStream);
            JPEGPicture->DIBNeeded();
            BMPPicture->Assign(JPEGPicture);
            //ResizeBitmapBlt(BMPPicture, Image1->Width, Panel1->Height);
            ResizeBitmapProportional(BMPPicture, Image1->Width, Panel1->Height, clWhite);
            Image1->Picture->Assign(BMPPicture);
            JPEGPicture->Free();
            JPEGPicture = NULL;
            BMPPicture->Free();
         }

         //PNG
         if(MIMEType == L"image/png")
         {
            PNGPicture = new TPngImage;
            PNGPicture->LoadFromStream(PictureStream);
            BMPPicture->Assign(PNGPicture);
            //ResizeBitmapBlt(BMPPicture, Image1->Width, Panel1->Height);
            ResizeBitmapProportional(BMPPicture, Image1->Width, Image1->Height, clWhite);
            Image1->Picture->Assign(BMPPicture);
            PNGPicture->Free();
            PNGPicture = NULL;
            BMPPicture->Free();
         }

         //GIF
         if(MIMEType == L"image/gif")
         {
            GIFPicture = new TGIFImage;
            GIFPicture->LoadFromStream(PictureStream);
            BMPPicture->Assign(GIFPicture);
            //ResizeBitmapBlt(BMPPicture, Image1->Width, Panel1->Height);
            ResizeBitmapProportional(BMPPicture, Image1->Width, Image1->Height, clWhite);
            Image1->Picture->Assign(BMPPicture);
            GIFPicture->Free();
            GIFPicture = NULL;
            BMPPicture->Free();
         }

         //BMP
         if(MIMEType == L"image/bmp")
         {
            BMPPicture->LoadFromStream(PictureStream);
            //ResizeBitmapBlt(BMPPicture, Image1->Width, Panel1->Height);
            ResizeBitmapProportional(BMPPicture, Image1->Width, Image1->Height, clWhite);
            Image1->Picture->Assign(BMPPicture);
            BMPPicture->Free();
         }

         //load other formats a third party component is needed, for example GraphicEx or Free Image Library
         result = true;
      }
      __finally
      {
         PictureStream->Free();
         PictureStream = NULL;
      }

   }

   catch(...)
   {
     ;
   }

   return result;

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button15Click(TObject *Sender)
{
   int Error;

   Error = RemoveID3v1TagFromFile(Edit1->Text);
   if(Error != ID3V1LIBRARY_SUCCESS)
   {
      ShowMessage(L"Error while removing ID3v1 tag, error code: " + IntToStr(Error));
      return;
   }

   ID3v1Tag->Clear();
   ClearDatav1();

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button16Click(TObject *Sender)
{
   int Error;

   Error = RemoveID3v2TagFromFile(Edit1->Text);
   if(Error != ID3V2LIBRARY_SUCCESS)
   {
      ShowMessage(L"Error while removing ID3v2 tag, error code: " + IntToStr(Error) + "\r\n" + ID3v2TagErrorCode2String(Error));
      return ;
   }

   ID3v2Tag->Clear();
   ClearDatav2();

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button17Click(TObject *Sender)
{

   bool Success;
   Success = ID3v2Tag->DeleteFrame(CurrentAPICIndex);
   if(Success)
   {
      UpDown1Click(NULL, btPrev);
      Button6->Click(); //save tag
      Button3->Click(); //reload it
   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{

   ID3v2Tag->Frames[ComboBox1->ItemIndex]->DeCompress();
   ComboBox1Change(Sender);

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button2Click(TObject *Sender)
{

   ID3v2Tag->Frames[ComboBox1->ItemIndex]->Compress();
   ComboBox1Change(Sender);

}

//-------------------------------------------------------------------------

void __fastcall TForm1::ClearDatav1()
{

   //ID3v1
   Edit4->Text = L"";
   Edit5->Text = L"";
   Edit6->Text = L"";
   Edit7->Text = L"";
   Edit8->Text = L"";
   ComboBoxID3v1_Genre->Text = L"";
   Edit16->Text = L"";

}

//-------------------------------------------------------------------------

void __fastcall TForm1::ClearDatav2()
{

   //ID3v2
   Edit2->Text = L"";
   Edit3->Text = L"";
   Edit10->Text = L"";
   Edit11->Text = L"";
   Edit14->Text = L"";
   ComboBox2->Text = L"";
   Edit12->Text = L"";
   Edit17->Text = L"";
   Edit20->Text = L"";
   Memo3->Clear();
   Memo2->Clear();
   Edit19->Text = L"";
   Edit18->Text = L"";
   Edit15->Text = L"";
   Memo1->Clear();
   Image1->Picture = NULL;
   CurrentAPICIndex = -1;
   Edit9->Text = L"";
   Label30->Caption = L"Unknown";
   Label28->Caption = L"Unknown";
   Label31->Caption = L"Unknown";
   Label33->Caption = L"Unknown";
   Label35->Caption = L"Unknown";
   Label37->Caption = L"Unknown";
   Label39->Caption = L"Unknown";
   Label41->Caption = L"Unknown";
   Label43->Caption = L"Unknown";
   Label17->Caption = L"Unknown";
   ComboBox1->Items->Clear();
   CheckBox1->Checked = false;
   CheckBox2->Checked = false;
   CheckBox3->Checked = false;
   CheckBox4->Checked = false;

}

//-------------------------------------------------------------------------

void __fastcall TForm1::ComboBox1Change(TObject *Sender)
{
   String tempString, asciiString, rowNo;
   unsigned int Count, Remainder, LineCount, DataSize;
   unsigned char tempByte;

   if(ComboBox1->ItemIndex == -1)
   {
      return;
   }
   Screen->Cursor = crAppStart;
   Memo1->Clear();

   SetFrameAttributes();
   SetFrameCommandButtons();

   DataSize = ID3v2Tag->Frames[ComboBox1->ItemIndex]->Stream->Size;
   Count = 0;
   ID3v2Tag->Frames[ComboBox1->ItemIndex]->Stream->Seek((__int64)0, (WORD)soBeginning);
   Memo1->Lines->BeginUpdate();

   //function to display frame data as hex and string
   while(Count < DataSize)
   {
      tempString = L"";
      asciiString = L"";
      if(DataSize - Count >= 16)
      {
         Remainder = 16;
      }
      else
      {
         Remainder = DataSize - Count;
      }

      for(LineCount = 0; LineCount < Remainder; LineCount++)
      {
         ID3v2Tag->Frames[ComboBox1->ItemIndex]->Stream->Read(&tempByte, 1);
         tempString = tempString + IntToHex(tempByte, 2) + L" ";
         if((tempByte > 31) && (tempByte < 255))
         {
            asciiString = asciiString + char(tempByte);
         }
         else
         {
            asciiString = asciiString + char(95);
         }
      }
      LineCount = Remainder - 1;
      while(LineCount < 15)
      {
         tempString = tempString + L"   ";
         LineCount++;
      }

      rowNo = IntToStr((int)Count);
      switch(rowNo.Length())
      {
         case 1:    rowNo = String(L"000000") + rowNo;  break;
         case 2:    rowNo = String(L"00000") + rowNo;   break;
         case 3:    rowNo = String(L"0000") + rowNo;    break;
         case 4:    rowNo = String(L"000") + rowNo;     break;
         case 5:    rowNo = String(L"00") + rowNo;      break;
         case 6:    rowNo = L"0" + rowNo;               break;
      }
      rowNo = rowNo + L": ";

      Memo1->Lines->Append(rowNo + tempString + " " + asciiString);
      Count += Remainder;
   }

   Memo1->Lines->EndUpdate();
   Screen->Cursor = crDefault;

}

//-------------------------------------------------------------------------


void __fastcall TForm1::SetFrameAttributes()
{

   Label30->Caption =  IntToStr(ID3v2Tag->Frames[ComboBox1->ItemIndex]->Stream->Size);
   Label28->Caption = BoolToStr(ID3v2Tag->Frames[ComboBox1->ItemIndex]->TagAlterPreservation, true);
   Label31->Caption = BoolToStr(ID3v2Tag->Frames[ComboBox1->ItemIndex]->FileAlterPreservation, true);
   Label33->Caption = BoolToStr(ID3v2Tag->Frames[ComboBox1->ItemIndex]->ReadOnly, true);
   Label35->Caption = BoolToStr(ID3v2Tag->Frames[ComboBox1->ItemIndex]->GroupingIdentity, true);
   Label37->Caption = BoolToStr(ID3v2Tag->Frames[ComboBox1->ItemIndex]->Compressed, true);
   Label39->Caption = BoolToStr(ID3v2Tag->Frames[ComboBox1->ItemIndex]->Encrypted, true);
   Label41->Caption = BoolToStr(ID3v2Tag->Frames[ComboBox1->ItemIndex]->Unsynchronised, true);
   Label43->Caption = BoolToStr(ID3v2Tag->Frames[ComboBox1->ItemIndex]->DataLengthIndicator, true);

}

//-------------------------------------------------------------------------

void __fastcall TForm1::SetFrameCommandButtons()
{

   if(ID3v2Tag->Frames[ComboBox1->ItemIndex]->Compressed)
   {
      Button2->Enabled = false;
      Button1->Enabled = true;
   }
   else
   {
      Button2->Enabled = true;
      Button1->Enabled = false;
   }
   if(ID3v2Tag->Frames[ComboBox1->ItemIndex]->Unsynchronised)
   {
      Button7->Enabled = false;
      Button4->Enabled = true;
   }
   else
   {
      Button7->Enabled = true;
      Button4->Enabled = false;
   }

}

//-------------------------------------------------------------------------

