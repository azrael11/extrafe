//---------------------------------------------------------------------------
#include <JPEG.hpp>
#include <PNGImage.hpp>
#include <gifimg.hpp>
#include <vcl.h>
#pragma hdrstop

#undef AddAtom()
#undef FindAtom()

#include "Unit1.h"
#include "MP4TagLibrary.hpp"
#include "TagsLibraryDefs.hpp"


//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"


//NOTE: AddAtom() and FindAtom() had to be
//      undef`d for use in C++ Builder
//      due to winAPI name conflicts

TMP4Tag *MP4Tag;
int ErrorCode;
int CurrentAPICIndex = -1;
String LastArtPath;

//converted to C++ by RMJ 02/2015

TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner) : TForm(Owner)
{

   MP4Tag = new TMP4Tag;

}

//---------------------------------------------------------------------------

void __fastcall TForm1::FormDestroy(TObject *Sender)
{

   delete MP4Tag;

}

//---------------------------------------------------------------------------

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
   Edit10->Text = L"";
   Memo1->Clear();
   Image1->Picture = NULL;


   OpenDialog->FileName = L"";
   OpenDialog->Filter = "MP4 Files|*.mp4";
   OpenDialog->InitialDir = ExtractFilePath(Edit1->Text);

   if(OpenDialog->Execute())
   {
      Edit1->Text = OpenDialog->FileName;
      Button3->Click();
   }

}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button3Click(TObject *Sender)
{
   TJPEGImage        *JPEGPicture;
   TGIFImage         *GIFPicture;
   TPngImage         *PNGPicture;
   Graphics::TBitmap *BMPPicture;
   WORD               PictureMagic;
   int i, Index = 0;

   if(Edit1->Text.Length() <= 0)
      return;

   Image1->Picture = NULL;

   MP4Tag->LoadFromFile(Edit1->Text);

   //List specific tags
   Edit2->Text = MP4Tag->GetText(L"©nam");
   Edit3->Text = MP4Tag->GetText(L"©ART");
   Edit4->Text = MP4Tag->GetText(L"©alb");
   Edit5->Text = MP4Tag->GetGenre();
   Edit6->Text = MP4Tag->GetText(L"©day");

   //Some helper functions which extract the values from the stream
   Edit7->Text = IntToStr(MP4Tag->GetTrack());
   Edit10->Text = IntToStr(MP4Tag->GetTotalTracks());
   Edit8->Text = IntToStr(MP4Tag->GetDisc());
   Edit11->Text = IntToStr(MP4Tag->GetTotalDiscs());
   Edit9->Text = MP4Tag->GetText(L"©cmt");

   //List all atoms found and load the 1st cover art
   Memo1->Clear();
   for(i = 0; i < MP4Tag->Count(); i++)
   {
      if(IsSameAtomName(MP4Tag->Atoms[i]->ID, L"covr"))
      {
         Memo1->Lines->Add(AtomNameToString(MP4Tag->Atoms[i]->ID) + L" " + IntToStr((__int64)MP4Tag->Atoms[i]->Size) + L" bytes = " + IntToStr(MP4Tag->Atoms[i]->Count()) + L" covers");
      }
      else
      {
         if(IsSameAtomName(MP4Tag->Atoms[i]->ID, L"gnre"))
         {
            Memo1->Lines->Add(AtomNameToString(MP4Tag->Atoms[i]->ID) + " " + IntToStr((__int64)MP4Tag->Atoms[i]->Size) + L" bytes = " + ID3Genres[MP4Tag->Atoms[i]->GetAsInteger16()]);
         }
         else
         if(IsSameAtomName(MP4Tag->Atoms[i]->ID, L"----"))
         {
            Memo1->Lines->Add(AtomNameToString(MP4Tag->Atoms[i]->ID) + " " + IntToStr((__int64)MP4Tag->Atoms[i]->Size) + L" bytes = " + MP4Tag->Atoms[i]->name->GetAsText() + L" = " + MP4Tag->Atoms[i]->mean->GetAsText() + " = " + MP4Tag->Atoms[i]->GetAsText());
         }
         else
         {
            //note that GetAsText returns integers too and calls GetAsInteger() internally which automatically choses the appropriate GetAsInteger function
            Memo1->Lines->Add(AtomNameToString(MP4Tag->Atoms[i]->ID) + " " + IntToStr((__int64)MP4Tag->Atoms[i]->Size) + L" bytes = " + MP4Tag->Atoms[i]->GetAsText());
         }
      }

      if(MP4Tag->CoverArtCount() > 0)
      if(IsSameAtomName(MP4Tag->Atoms[i]->ID, L"covr"))
      {
         //position should be at start, just to be sure
         MP4Tag->Atoms[i]->Datas[Index]->Data->Seek((__int64)0, (WORD)soBeginning);
         MP4Tag->Atoms[i]->Datas[Index]->Data->Read(&PictureMagic, 2);

         if(PictureMagic == MAGIC_JPG)
         {
            JPEGPicture = new TJPEGImage;
            MP4Tag->Atoms[i]->Datas[Index]->Data->Seek((__int64)0, (WORD)soBeginning);
            JPEGPicture->LoadFromStream(MP4Tag->Atoms[i]->Datas[Index]->Data);
            Image1->Picture->Assign(JPEGPicture);
            delete JPEGPicture;
         }
         if(PictureMagic == MAGIC_BMP)
         {
            BMPPicture = new Graphics::TBitmap;
            MP4Tag->Atoms[i]->Datas[Index]->Data->Seek((__int64)0, (WORD)soBeginning);
            BMPPicture->LoadFromStream(MP4Tag->Atoms[i]->Datas[Index]->Data);
            Image1->Picture->Bitmap->Assign(BMPPicture);
            delete BMPPicture;
         }
         if(PictureMagic == MAGIC_PNG)
         {
            PNGPicture = new TPngImage;
            MP4Tag->Atoms[i]->Datas[Index]->Data->Seek((__int64)0, (WORD)soBeginning);
            PNGPicture->LoadFromStream(MP4Tag->Atoms[i]->Datas[Index]->Data);
            Image1->Picture->Assign(PNGPicture);
            delete PNGPicture;
         }
         if(PictureMagic == MAGIC_GIF)
         {
            GIFPicture = new TGIFImage;
            MP4Tag->Atoms[i]->Datas[Index]->Data->Seek((__int64)0, (WORD)soBeginning);
            GIFPicture->LoadFromStream(MP4Tag->Atoms[i]->Datas[Index]->Data);
            Image1->Picture->Assign(GIFPicture);
            delete GIFPicture;
         }

         Index++;
      }

   }

  CurrentAPICIndex = 0;

}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button4Click(TObject *Sender)
{

   Application->ProcessMessages();

   //set specific tags
   MP4Tag->SetText(L"©nam", Edit2->Text);
   MP4Tag->SetText(L"©ART", Edit3->Text);
   MP4Tag->SetText(L"©alb", Edit4->Text);

   //automatically set proper genre
   MP4Tag->SetGenre(Edit5->Text);

   //genre can be stored as an index to an ID3
   //genre + 1 or as a text (for custom genre)
   /*
   GenreIndex = GenreToIndex(Edit5->Text);
   if(GenreIndex > -1)
     MP4Tag->SetInteger16(L"gnre", GenreIndex);
   else
     MP4Tag->SetText("©gen", Edit5->Text);
   */

   MP4Tag->SetText(L"©day", Edit6->Text);

   //helper functions which encode the values to the stream
   MP4Tag->SetTrack(StrToIntDef(Edit7->Text, 0), StrToIntDef(Edit10->Text, 0));
   MP4Tag->SetDisc(StrToIntDef(Edit8->Text, 0), StrToIntDef(Edit11->Text, 0));
   MP4Tag->SetText(L"©cmt", Edit9->Text);

   ErrorCode = MP4Tag->SaveToFile(Edit1->Text);

   if(ErrorCode != MP4TAGLIBRARY_SUCCESS)
   {
      ShowMessage(String(L"Error while saving tag, error code: ") + IntToStr(ErrorCode));
   }

}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button5Click(TObject *Sender)
{
   //if 'KeepPadding' is true the file size will not change
   //if 'KeepPadding' is false then the file will shrink
   ErrorCode = RemoveMP4TagFromFile(Edit1->Text, false);
   if(ErrorCode != MP4TAGLIBRARY_SUCCESS)
   {
      ShowMessage(String(L"Error while removing tag, error code: ") + IntToStr(ErrorCode));
   }

}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{

   Close();
   Application->Terminate();

}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button6Click(TObject *Sender)
{
   WORD PictureMagic;
   bool GotCover = false;

   if(Edit1->Text.Length() <= 0)
      return;

   //add a new image to the tag
   OpenDialog->FileName = L"";
   OpenDialog->Filter = "Picture Files|*.jpg;*.bmp;*png;*gif|";
   OpenDialog->InitialDir = LastArtPath;

   if(OpenDialog->Execute())
   {
      LastArtPath = ExtractFilePath(OpenDialog->FileName);

      for(int i = 0; i < MP4Tag->Count(); i++)
      {
         if(IsSameAtomName(MP4Tag->Atoms[i]->ID, L"covr"))
         {
            //add additional cover if one already exists
            MP4Tag->FindAtom(L"covr")->AddData()->Data->LoadFromFile(OpenDialog->FileName);
            MP4Tag->SaveToFile(Edit1->Text);
            GotCover = true;
            break;
         }
      }
      //add new cover if there is not one present
      if(!GotCover)
      {
         MP4Tag->AddAtom(L"covr")->AddData()->Data->LoadFromFile(OpenDialog->FileName);
         MP4Tag->SaveToFile(Edit1->Text);
      }

      if(ErrorCode != MP4TAGLIBRARY_SUCCESS)
      {
         ShowMessage(String(L"Error while inserting tag image, error code: ") + IntToStr(ErrorCode));
      }
      else
      {
         Button3->Click(); //reload
      }

   }

}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button7Click(TObject *Sender)
{

   //delete current MP4 APIC
   for(int i = 0; i < MP4Tag->Count(); i++)
   {
     if(IsSameAtomName(MP4Tag->Atoms[i]->ID, L"covr"))
     {
        MP4Tag->Atoms[i]->Datas[CurrentAPICIndex]->Delete();
        MP4Tag->SaveToFile(Edit1->Text);
        Button3->Click(); //reload
        return;
     }

   }

}

//---------------------------------------------------------------------------

int __fastcall TForm1::DisplayCoverArt(int index)
{
   TJPEGImage        *JPEGPicture;
   TGIFImage         *GIFPicture;
   TPngImage         *PNGPicture;
   TBitmap           *BMPPicture;
   WORD              PictureMagic;
   int i;

   //go thru all atoms and load the cover art
   for(int i = 0; i < MP4Tag->Count(); i++)
   {
      if(IsSameAtomName(MP4Tag->Atoms[i]->ID, L"covr"))
      {
         //position should be at start, just to be sure
         MP4Tag->Atoms[i]->Datas[index]->Data->Seek((__int64)0, (WORD)soBeginning);
         MP4Tag->Atoms[i]->Datas[index]->Data->Read(&PictureMagic, 2);

         if(PictureMagic == MAGIC_JPG)
         {
            JPEGPicture = new TJPEGImage;
            MP4Tag->Atoms[i]->Datas[index]->Data->Seek((__int64)0, (WORD)soBeginning);
            JPEGPicture->LoadFromStream(MP4Tag->Atoms[i]->Datas[index]->Data);
            Image1->Picture->Assign(JPEGPicture);
            delete JPEGPicture;
         }
         if(PictureMagic == MAGIC_BMP)
         {
            BMPPicture = new Graphics::TBitmap;
            MP4Tag->Atoms[i]->Datas[index]->Data->Seek((__int64)0, (WORD)soBeginning);
            BMPPicture->LoadFromStream(MP4Tag->Atoms[i]->Datas[index]->Data);
            Image1->Picture->Bitmap->Assign(BMPPicture);
            delete BMPPicture;
         }
         if(PictureMagic == MAGIC_PNG)
         {
            PNGPicture = new TPngImage;
            MP4Tag->Atoms[i]->Datas[index]->Data->Seek((__int64)0, (WORD)soBeginning);
            PNGPicture->LoadFromStream(MP4Tag->Atoms[i]->Datas[index]->Data);
            Image1->Picture->Assign(PNGPicture);
            delete PNGPicture;
         }
         if(PictureMagic == MAGIC_GIF)
         {
            GIFPicture = new TGIFImage;
            MP4Tag->Atoms[i]->Datas[index]->Data->Seek((__int64)0, (WORD)soBeginning);
            GIFPicture->LoadFromStream(MP4Tag->Atoms[i]->Datas[index]->Data);
            Image1->Picture->Assign(GIFPicture);
            delete GIFPicture;
         }

      }

   }

   return index;

}

//---------------------------------------------------------------------------

void __fastcall TForm1::UpDown1Click(TObject *Sender, TUDBtnType Button)
{

   if(Button == btNext)
   {
      CurrentAPICIndex++;
      if(CurrentAPICIndex > MP4Tag->CoverArtCount() - 1)
         CurrentAPICIndex = MP4Tag->CoverArtCount() - 1;
      DisplayCoverArt(CurrentAPICIndex);
   }
   if(Button == btPrev)
   {
      CurrentAPICIndex--;
      if(CurrentAPICIndex < 0)
         CurrentAPICIndex = 0;
      DisplayCoverArt(CurrentAPICIndex);
   }


}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button8Click(TObject *Sender)
{
   TJPEGImage        *JPEGPicture;
   TGIFImage         *GIFPicture;
   TPngImage         *PNGPicture;
   TBitmap           *BMPPicture;
   WORD              PictureMagic;
   String Fext;

   SaveDialog1->FileName = L"Image.tmp";
   SaveDialog1->Filter = "Image File|*.jpg";
   SaveDialog1->InitialDir = ExtractFilePath(Edit1->Text);

   //decide what type picture it will be
   for(int i = 0; i < MP4Tag->Count(); i++)
   {
     if(IsSameAtomName(MP4Tag->Atoms[i]->ID, L"covr"))
     {
        MP4Tag->Atoms[i]->Datas[CurrentAPICIndex]->Data->Seek((__int64)0, (WORD)soBeginning);
        MP4Tag->Atoms[i]->Datas[CurrentAPICIndex]->Data->Read(&PictureMagic, 2);
        if(PictureMagic == MAGIC_JPG)
        {
           Fext = L".jpg";
           SaveDialog1->Filter = "Image File|*.jpg";
        }
        if(PictureMagic == MAGIC_BMP)
        {
           Fext = L".bmp";
           SaveDialog1->Filter = "Image File|*.bmp";
        }
        if(PictureMagic == MAGIC_PNG)
        {
           Fext = L".png";
           SaveDialog1->Filter = "Image File|*.png";
        }
        if(PictureMagic == MAGIC_GIF)
        {
           Fext = L".gif";
           SaveDialog1->Filter = "Image File|*.gif";
        }

     }
   }

   SaveDialog1->FileName = ChangeFileExt(SaveDialog1->FileName, Fext);

   if(SaveDialog1->Execute())
   {
      for(int i = 0; i < MP4Tag->Count(); i++)
      {
        if(IsSameAtomName(MP4Tag->Atoms[i]->ID, L"covr"))
        {
           //position should be at start, just to be sure
           MP4Tag->Atoms[i]->Datas[CurrentAPICIndex]->Data->Seek((__int64)0, (WORD)soBeginning);

           if(PictureMagic == MAGIC_JPG)
           {
              JPEGPicture = new TJPEGImage;
              JPEGPicture->LoadFromStream(MP4Tag->Atoms[i]->Datas[CurrentAPICIndex]->Data);
              JPEGPicture->SaveToFile(SaveDialog1->FileName);
              delete JPEGPicture;
           }
           if(PictureMagic == MAGIC_BMP)
           {
              BMPPicture = new TBitmap;
              BMPPicture->LoadFromStream(MP4Tag->Atoms[i]->Datas[CurrentAPICIndex]->Data);
              BMPPicture->SaveToFile(SaveDialog1->FileName);
              delete BMPPicture;
           }
           if(PictureMagic == MAGIC_PNG)
           {
              PNGPicture = new TPngImage;
              PNGPicture->LoadFromStream(MP4Tag->Atoms[i]->Datas[CurrentAPICIndex]->Data);
              PNGPicture->SaveToFile(SaveDialog1->FileName);
              delete PNGPicture;
           }
           if(PictureMagic == MAGIC_GIF)
           {
              GIFPicture = new TGIFImage;
              GIFPicture->LoadFromStream(MP4Tag->Atoms[i]->Datas[CurrentAPICIndex]->Data);
              GIFPicture->SaveToFile(SaveDialog1->FileName);
              delete GIFPicture;
           }

           //ShowMessage("Saved as: " + SaveDialog1->FileName);
        }

      }

   }


}

//---------------------------------------------------------------------------

