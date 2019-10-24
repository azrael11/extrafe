//---------------------------------------------------------------------------

#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ExtDlgs.hpp>
#include <Vcl.ImgList.hpp>


//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
    TGroupBox *GroupBox1;
    TLabel *Label1;
    TLabel *Label2;
    TLabel *Label3;
    TLabel *Label4;
    TLabel *Label5;
    TLabel *Label6;
    TLabel *Label7;
    TEdit *Edit1;
    TButton *Button2;
    TButton *Button3;
    TButton *Button4;
    TListView *ListView1;
    TPanel *Panel1;
    TImage *Image1;
    TButton *Button5;
    TEdit *EditFieldValue;
    TComboBox *ComboBoxFieldName;
    TButton *ButtonDeleteField;
    TButton *ButtonAddField;
    TButton *Button6;
    TButton *Button1;
    TOpenDialog *OpenDialog1;
    TImageList *ImageList1;
    TOpenPictureDialog *OpenPictureDialog1;
    void __fastcall Button2Click(TObject *Sender);
    void __fastcall Button5Click(TObject *Sender);
    void __fastcall Button4Click(TObject *Sender);
    void __fastcall Button3Click(TObject *Sender);
    void __fastcall Button6Click(TObject *Sender);
    void __fastcall ButtonDeleteFieldClick(TObject *Sender);
    void __fastcall ButtonAddFieldClick(TObject *Sender);

    void __fastcall Button1Click(TObject *Sender);
    void __fastcall ComboBoxFieldNameExit(TObject *Sender);
    void __fastcall EditFieldValueChange(TObject *Sender);
    void __fastcall EditFieldValueKeyDown(TObject *Sender, WORD &Key, TShiftState Shift);
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall FormDestroy(TObject *Sender);
    void __fastcall ListView1Click(TObject *Sender);
    void __fastcall ListView1SelectItem(TObject *Sender, TListItem *Item, bool Selected);





private:	// User declarations
     TWndMethod FOldListviewWindowProc;
   void __fastcall ListviewWindowproc(TMessage &Message);

public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
   void __fastcall AttachFieldNameCombobox();
   void __fastcall AttachValueEdit();
   void __fastcall ListFields();

};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
