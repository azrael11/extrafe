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
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
    TGroupBox *GroupBox1;
    TLabel *Label1;
    TEdit *Edit1;
    TButton *Button2;
    TGroupBox *GroupBox2;
    TLabel *Label2;
    TLabel *Label3;
    TLabel *Label4;
    TEdit *Edit2;
    TEdit *Edit3;
    TEdit *Edit4;
    TPanel *Panel1;
    TImage *Image1;
    TUpDown *UpDown1;
    TMemo *Memo1;
    TButton *Button3;
    TButton *Button4;
    TButton *Button1;
    TOpenDialog *OpenDialog1;
    TOpenDialog *OpenDialog2;
    TButton *Button5;
    TButton *Button7;
    TButton *Button8;
    TSaveDialog *SaveDialog1;
    TLabel *Label5;
    TButton *Button6;
    void __fastcall Button4Click(TObject *Sender);
    void __fastcall Button3Click(TObject *Sender);
    void __fastcall Button2Click(TObject *Sender);
    void __fastcall Button5Click(TObject *Sender);
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall FormDestroy(TObject *Sender);
    void __fastcall UpDown1ChangingEx(TObject *Sender, bool &AllowChange, int NewValue, TUpDownDirection Direction);
    void __fastcall Button1Click(TObject *Sender);
    void __fastcall Button7Click(TObject *Sender);
    void __fastcall Button8Click(TObject *Sender);
    void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
    void __fastcall Button6Click(TObject *Sender);


private:	// User declarations
public:		// User declarations
         __fastcall TForm1(TComponent* Owner);
    void __fastcall DisplayCoverArt(int Index);

};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
