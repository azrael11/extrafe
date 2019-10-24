//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include "WAVTagLibrary.hpp"

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"



TWAVTag *WAVTag;

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

   if(OpenDialogWAV->Execute())
   {
      Edit1->Text = OpenDialogWAV->FileName;
   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button3Click(TObject *Sender)
{
   int i;
   int Error;

   Edit2->Text = L"";
   Edit3->Text = L"";
   Edit4->Text = L"";
   Edit5->Text = L"";
   Edit6->Text = L"";
   Edit7->Text = L"";
   Edit9->Text = L"";

   Error = WAVTag->LoadFromFile(Edit1->Text);
   if(Error > WAVTAGLIBRARY_ERROR_NO_TAG_FOUND)
   {
      ShowMessage(String("Error loading wav tag, error code: ") + IntToStr(Error) + "\r\n" + WAVTagErrorCode2String(Error));
   }

   /*
    InfoID   The corresponding text describes
   "iart"    The artist of the original subject of the file
   "icms"    The name of the person or organization that commissioned the original subject of the file
   "icmt"    General comments about the file or its subject
   "icop"    Copyright information about the file (e.g., "Copyright Some Company 2011")
   "icrd"    The date the subject of the file was created (creation date)
   "ieng"    The name of the engineer who worked on the file
   "ignr"    The genre of the subject
   "ikey"    A list of keywords for the file or its subject
   "imed"    Medium for the original subject of the file
   "inam"    Title of the subject of the file (name)
   "iprd"    Name of the title the subject was originally intended for
   "isbj"    Description of the contents of the file (subject)
   "isft"    Name of the software package used to create the file
   "isrc"    The name of the person or organization that supplied the original subject of the file
   "isrf"    The original form of the material that was digitized (source form)
   "itch"    The name of the technician who digitized the subject file
   IPRD = Album name
   IART = Artist name
   INAM = Track Title
   ICMT = Comment
   ICRD = Year
   IGNR = Genre
   ITRK = Track Number

   Wave Chunk    Description    ID3 v2.3.0    ID3 TXXX Record

   DISP          Title / Description    TIT2
   INFO,IART    Artist / Advertiser    TPE1
   INFO,IALB    Album    TALB
   INFO,IYER    Year    TYER
   INFO,ITRK    Track Number    TRCK    'TrackNum'
   INFO,ICMT    Comments    COMM []    'Comments'
   INFO,ISRF    Intro Time (in msec)    ETCO,$10    'Intro'
   INFO,IMED    Segue Time (in msec)    ETCO,$??    'Sec Tone'
   INFO,ISRC    Category         'Category'
   INFO,BFAD    No fade at segue (0/-1)         'No fade'
   INFO,IGRE    Genre    TCON
   INFO,IENG    Producer         'Producer'
   INFO,ITCH    Talent         'Talent'
   INFO,ICOM    Composer    TCOM
   INFO,IPUB    Publisher    TPUB
   INFO,BCPR    Copyright / Record Company    TCOP
   INFO,INAM    OutCue         'OutCue'
   INFO,ICOP    Agency         'Agency'
   INFO,ISFT    Account Executive / Sales person         'Account Exec'
   INFO,ISBJ    Copy         'Copy'
   INFO,IURL    URL    WXXX    'URL'
   INFO,IBPM    Music BPM    TBPM    'BPM'
   INFO,BKEY    Music Key (C, D, F#, G...)    TKEY    'Key'
   INFO,BEND    Music End (Cold, Fade, Long Fade...)         'End'
   INFO,BERG    Music Energy         'Energy'
   INFO,BTXR    Music Texture (Active, Mainstream...)         'Texture'
   INFO,BTPO    Music Tempo (slow, medium slow...)         'Tempo'
   INFO,HKST    Hook Start (in msec)    ETCO,$09    'Hook Start'
   INFO,HKEN    Hook End (in msec)    ETCO,$14    'Hook End'
   INFO,IGNR    Start Date (YYYY/MM/DD)         'Start Date'
   INFO,IKEY    End Date (YYYY/MM/DD)         'End Date'
   INFO,BSTM    Start Time (HH:MM)         'Start Time'
   INFO,BETM    End Time (HH:MM)         'End Time'
   INFO,BSTW    Time Window Start (HH:MM)         'Start Window'
   INFO,BETW    Time Window End (HH:MM)         'End Window'
    */
   //* Use all upper-case IDs!
   Edit2->Text = WAVTag->ReadFrameByNameAsText("INAM");
   Edit3->Text = WAVTag->ReadFrameByNameAsText("IART");
   Edit4->Text = WAVTag->ReadFrameByNameAsText("IPRD");
   Edit5->Text = WAVTag->ReadFrameByNameAsText("IGNR");
   Edit6->Text = WAVTag->ReadFrameByNameAsText("ICRD");
   Edit7->Text = WAVTag->ReadFrameByNameAsText("ITRK");
   Edit9->Text = WAVTag->ReadFrameByNameAsText("ICMT");

   //List all chunks found
   Memo1->Clear();

   for(i = 0; i < WAVTag->Count(); i++)
   {
      Memo1->Lines->Add(WAVTag->Frames[i]->Name + " = " + WAVTag->Frames[i]->GetAsText());
   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button4Click(TObject *Sender)
{
   int Error;

   WAVTag->SetTextFrameText("INAM", Edit2->Text);
   WAVTag->SetTextFrameText("IART", Edit3->Text);
   WAVTag->SetTextFrameText("IPRD", Edit4->Text);
   WAVTag->SetTextFrameText("IGNR", Edit5->Text);
   WAVTag->SetTextFrameText("ICRD", Edit6->Text);
   WAVTag->SetTextFrameText("ITRK", Edit7->Text);
   WAVTag->SetTextFrameText("ICMT", Edit9->Text);

   Error = WAVTag->SaveToFile(Edit1->Text);

   if(Error != WAVTAGLIBRARY_SUCCESS)
   {
      ShowMessage(String("Error while saving tag, error code: ") + IntToStr(Error) + "\r\n" + WAVTagErrorCode2String(Error));
   }

}

//-------------------------------------------------------------------------

void __fastcall TForm1::Button5Click(TObject *Sender)
{
   int Error;

   Error = RemoveWAVTagFromFile(Edit1->Text);
   if(Error != WAVTAGLIBRARY_SUCCESS)
   {
      ShowMessage(String("Error while removing tag, error code: ") + IntToStr(Error) + "\t\n" + WAVTagErrorCode2String(Error));
   }
   else
   {
      Button3->Click();
   }
}

//-------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender)
{

   WAVTag = new TWAVTag;

}

//-------------------------------------------------------------------------

void __fastcall TForm1::FormDestroy(TObject *Sender)
{
   delete WAVTag;
}

//-------------------------------------------------------------------------







