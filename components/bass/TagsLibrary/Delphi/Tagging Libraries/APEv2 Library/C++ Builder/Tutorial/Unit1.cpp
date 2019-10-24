//-----------------------------------------------------------------------------
#include <JPEG.hpp>
#include <PNGImage.hpp>
#include <gifimg.hpp>
#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
#include "APEv2Library.hpp"
//-----------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"



const WCHAR STR_CLICK_HERE_TO_EDIT[] = L" > CLICK HERE TO EDIT < ";
const WCHAR STR_SELECT_A_FIELD_TYPE[] = L" > SELECT A FIELD TYPE OR ENTER A NAME < ";

TAPEv2Tag *APEv2Tag;

//converted to C++ by RMJ 02/2015


TForm1 *Form1;
//-----------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent *Owner): TForm(Owner){}

//---------------------------------------------------------------------------

void __fastcall TForm1::ListviewWindowproc(TMessage &Message)
{

   FOldListviewWindowProc(Message);

   switch(Message.Msg)
   {
      case WM_VSCROLL:
      case WM_HSCROLL:
      case WM_MOUSEWHEEL:
         if(Message.WParamLo != SB_ENDSCROLL)
         {
            if(ComboBoxFieldName->Visible)
            {
               AttachFieldNameCombobox();
            }

            AttachValueEdit();
         }
         break;
   }

}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{

   Close();

}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button2Click(TObject *Sender)
{
   OpenDialog1->Filter = L"APE Files|*.APE|";

   if(OpenDialog1->Execute())
   {
      Edit1->Text = OpenDialog1->FileName;
   }
}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button3Click(TObject *Sender)
{
   int idx = ListView1->ItemIndex;

   EditFieldValue->Hide();

   APEv2Tag->LoadFromFile(Edit1->Text);
   Label3->Caption = IntToStr((__int64)APEv2Tag->Version);
   Label5->Caption = IntToStr((__int64)APEv2Tag->Size) + L" bytes";

   //* To get a particular field use:
   //Showmessage(APEv2Tag->ReadFrameByNameAsText(L"Title"));

   Image1->Picture = NULL;
   ListView1->Clear();
   ListFields();
   ListView1->SetFocus();
   ListView1->ItemIndex = ((idx > -1) ? idx : -1);

}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button4Click(TObject *Sender)
{

   EditFieldValue->Hide();
   APEv2Tag->SaveToFile(Edit1->Text);
   ListView1->SetFocus();

}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button5Click(TObject *Sender)
{

   RemoveAPEv2FromFile(Edit1->Text);
   Button3->Click();
}

//---------------------------------------------------------------------------

void __fastcall TForm1::Button6Click(TObject *Sender)
{
   TFileStream *PictureStream;
   String Description;


   if(OpenPictureDialog1->Execute())
   {
      Description = L"No description";

      if(InputQuery(L"Add cover art picture", L"Description:", Description))
      {
         PictureStream = new TFileStream(OpenPictureDialog1->FileName, fmOpenRead);

         try
         {
            APEv2Tag->AddCoverArtFrame(L"Cover Art (Front)", PictureStream, Description);
            //APEv2Tag.AddCoverArtFrame('Cover Art (Back)', PictureStream, Description);
         }
         __finally
         {
            delete (PictureStream);
         }

         //Update display
         Label3->Caption = IntToStr((__int64)APEv2Tag->Version);
         Label5->Caption = IntToStr((__int64)APEv2Tag->Size) + L" bytes";
         ListView1->Clear();
         ListFields();

      }

   }

}

//---------------------------------------------------------------------------

void __fastcall TForm1::ButtonAddFieldClick(TObject *Sender)
{

   EditFieldValue->Hide();

   TListItem *Item = ListView1->Items->Add();
   Item->Caption = STR_SELECT_A_FIELD_TYPE;
   Item->SubItems->Add(STR_CLICK_HERE_TO_EDIT);
   Item->Selected = true;

   AttachFieldNameCombobox();
   ComboBoxFieldName->Text = STR_SELECT_A_FIELD_TYPE;
   ComboBoxFieldName->SetFocus();

}

//---------------------------------------------------------------------------

void __fastcall TForm1::ButtonDeleteFieldClick(TObject *Sender)
{

   if((ListView1->Selected != NULL))
   {
      APEv2Tag->DeleteFrame(ListView1->Selected->Index);
      ListView1->Selected->Delete();
      EditFieldValue->Hide();
      Button3->Click();
   }

}

//---------------------------------------------------------------------------

void __fastcall TForm1::ComboBoxFieldNameExit(TObject *Sender)
{

   if((ComboBoxFieldName->Text != ComboBoxFieldName->Items[0].ToString()) && (ComboBoxFieldName->Text != STR_SELECT_A_FIELD_TYPE) && (ComboBoxFieldName->Text != L""))
   {
      APEv2Tag->AddTextFrame(ComboBoxFieldName->Text, L"");
      ListView1->Selected->Caption = ComboBoxFieldName->Text;
   }
   else
   {
      ListView1->Selected->Delete();
   }

   ComboBoxFieldName->Hide();

}

//---------------------------------------------------------------------------

void __fastcall TForm1::EditFieldValueChange(TObject *Sender)
{

   ListView1->Selected->SubItems[0].Text = EditFieldValue->Text;
   APEv2Tag->Frames[ListView1->Selected->Index]->SetAsText(EditFieldValue->Text);

}

//---------------------------------------------------------------------------

void __fastcall TForm1::EditFieldValueKeyDown(TObject *Sender, WORD &Key, TShiftState Shift)
{

   if(Key == 13)
   {
      EditFieldValue->Hide();
   }

}

//---------------------------------------------------------------------------

void __fastcall TForm1::FormCreate(TObject *Sender)
{

   FOldListviewWindowProc = ListView1->WindowProc;
   ListView1->WindowProc = ListviewWindowproc;

   APEv2Tag = new TAPEv2Tag;

}

//---------------------------------------------------------------------------

void __fastcall TForm1::FormDestroy(TObject *Sender)
{

   delete APEv2Tag;

}

//---------------------------------------------------------------------------

void __fastcall TForm1::ListFields()
{
   int i;

   //List all fields found in the tag
   for(i = 0; i < APEv2Tag->Count(); i++)
   {
      TListItem *Item = ListView1->Items->Add();
      Item->Caption = APEv2Tag->Frames[i]->Name;
      switch(APEv2Tag->Frames[i]->Format)
      {
         case ffUnknown:
            Item->SubItems->Add(L"Unknown content format");
            break;
         case ffText:
            Item->SubItems->Add(APEv2Tag->Frames[i]->GetAsText());
            break;
         case ffBinary:
            Item->SubItems->Add(String(L"BINARY ") + IntToStr(APEv2Tag->Frames[i]->Stream->Size) + L" bytes");
            break;
      }
   }
}

//---------------------------------------------------------------------------

void __fastcall TForm1::ListView1Click(TObject *Sender)
{

   AttachValueEdit();

}

//---------------------------------------------------------------------------

void __fastcall TForm1::ListView1SelectItem(TObject *Sender, TListItem *Item, bool Selected)
{
   TStream *PictureStream;
   TAPEv2PictureFormat PictureFormat;
   String Description;
   TJPEGImage *PictureJPEG;
   TPngImage *PicturePNG;
   TGIFImage *PictureGIF;

   //This demonstrates how to get and display a cover picture
   if(Selected)
   {
      PictureStream = new TMemoryStream;

      try
      {
         if(APEv2Tag->GetCoverArtFromFrame(Item->Index, PictureStream, PictureFormat, Description))
         {
            switch(PictureFormat)
            {
               case pfJPEG:
                  {
                     PictureJPEG = new TJPEGImage;
                     PictureJPEG->LoadFromStream(PictureStream);
                     Image1->Picture->Assign(PictureJPEG);
                     delete PictureJPEG;
                  }
                  break;
               case pfPNG:
                  {
                     PicturePNG = new TPngImage;
                     PicturePNG->LoadFromStream(PictureStream);
                     Image1->Picture->Assign(PicturePNG);
                     delete PicturePNG;
                  }
                  break;
               case pfGIF:
                  {
                     PictureGIF = new TGIFImage;
                     PictureGIF->LoadFromStream(PictureStream);
                     Image1->Picture->Assign(PictureGIF);
                     delete PictureGIF;
                  }
                  break;
               case pfBMP:
                  {
                     Image1->Picture->Bitmap->LoadFromStream(PictureStream);
                  }
                  break;
            }

            Label7->Caption = Description;
         }

      }
      __finally
      {
         delete PictureStream;
      }

   }

}

//---------------------------------------------------------------------------

void __fastcall TForm1::AttachValueEdit()
{
   TRect Rect;

   if((!(ListView1->Selected != NULL)) || (APEv2Tag->Frames[ListView1->Selected->Index]->Format == ffBinary))
   {
      EditFieldValue->Visible = false;
      return ;
   }

   ZeroMemory(&Rect, sizeof(Rect));
   ListView_GetSubItemRect(ListView1->Handle, ListView1->Selected->Index, 1, LVIR_BOUNDS, &Rect);
   EditFieldValue->Parent = ListView1;
   Rect.Top = Rect.Top - 1;
   Rect.Bottom = Rect.Bottom - 0;
   Rect.Left = Rect.Left + 0;
   Rect.Right = Rect.Right + 1;
   EditFieldValue->BoundsRect = Rect;
   EditFieldValue->Visible = true;
   EditFieldValue->Text = ListView1->Selected->SubItems[0].Text;
   EditFieldValue->SetFocus();

}

//---------------------------------------------------------------------------

void __fastcall TForm1::AttachFieldNameCombobox()
{
   TRect Rect;

   if(!(ListView1->Selected != NULL))
   {
      ComboBoxFieldName->Visible = false;
      return ;
   }

   ZeroMemory(&Rect, sizeof(Rect));
   ListView_GetSubItemRect(ListView1->Handle, ListView1->Selected->Index, 0, LVIR_BOUNDS, &Rect);
   ComboBoxFieldName->Parent = ListView1;

   Rect.Top = Rect.Top - 1;
   Rect.Bottom = Rect.Bottom + 0;
   Rect.Left = Rect.Left + 0;
   Rect.Right = ListView1->Columns->Items[0]->Width;

   ComboBoxFieldName->BoundsRect = Rect;
   ComboBoxFieldName->Visible = true;

}

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
