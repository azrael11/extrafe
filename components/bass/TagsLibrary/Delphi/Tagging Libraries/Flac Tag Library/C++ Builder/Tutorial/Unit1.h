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
    TLabel *Label2;
    TLabel *Label3;
    TLabel *Label4;
    TLabel *Label5;
    TLabel *Label6;
    TLabel *Label7;
    TLabel *Label8;
    TLabel *Label9;
    TEdit *Edit1;
    TButton *Button2;
    TButton *Button3;
    TMemo *Memo1;
    TButton *Button4;
    TEdit *Edit2;
    TEdit *Edit3;
    TEdit *Edit4;
    TEdit *Edit5;
    TEdit *Edit6;
    TEdit *Edit7;
    TEdit *Edit8;
    TEdit *Edit9;
    TButton *Button5;
    TPanel *Panel1;
    TImage *Image1;
    TButton *Button6;
    TButton *Button7;
    TButton *Button1;
    TUpDown *UpDown1;
    TOpenDialog *OpenDialogCoverArt;
    TOpenDialog *OpenDialogFlac;
    TButton *Button8;
    void __fastcall Button5Click(TObject *Sender);
    void __fastcall Button3Click(TObject *Sender);
    void __fastcall Button4Click(TObject *Sender);
    void __fastcall Button2Click(TObject *Sender);
    void __fastcall Button7Click(TObject *Sender);
    void __fastcall Button6Click(TObject *Sender);
    void __fastcall UpDown1Click(TObject *Sender, TUDBtnType Button);
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall FormDestroy(TObject *Sender);
    void __fastcall Button1Click(TObject *Sender);
    void __fastcall Button8Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
         __fastcall TForm1(TComponent* Owner);
    void __fastcall DisplayCoverArt(int Index);
     int __fastcall FreeAndNULL(TObject *Obj);

};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
