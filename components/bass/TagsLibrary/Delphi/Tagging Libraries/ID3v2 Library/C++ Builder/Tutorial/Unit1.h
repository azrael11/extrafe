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
    TLabel *Label1;
    TEdit *Edit1;
    TButton *Button8;
    TPageControl *PageControl1;
    TTabSheet *TabSheet1;
    TGroupBox *GroupBox1;
    TLabel *Label4;
    TLabel *Label5;
    TLabel *Label6;
    TLabel *Label7;
    TLabel *Label8;
    TLabel *Label9;
    TLabel *Label22;
    TButton *Button5;
    TEdit *Edit4;
    TEdit *Edit5;
    TEdit *Edit6;
    TEdit *Edit7;
    TEdit *Edit8;
    TButton *Button9;
    TButton *Button15;
    TEdit *Edit16;
    TComboBox *ComboBoxID3v1_Genre;
    TTabSheet *TabSheet2;
    TGroupBox *GroupBox2;
    TButton *Button3;
    TButton *Button6;
    TGroupBox *GroupBox3;
    TLabel *Label19;
    TLabel *Label20;
    TLabel *Label21;
    TPanel *Panel1;
    TImage *Image1;
    TButton *Button10;
    TButton *Button11;
    TButton *Button12;
    TEdit *Edit15;
    TUpDown *UpDown1;
    TButton *Button17;
    TButton *Button16;
    TGroupBox *GroupBox4;
    TLabel *Label23;
    TLabel *Label24;
    TMemo *Memo3;
    TEdit *Edit17;
    TEdit *Edit20;
    TGroupBox *GroupBox5;
    TLabel *Label2;
    TLabel *Label27;
    TLabel *Label28;
    TLabel *Label29;
    TLabel *Label30;
    TLabel *Label31;
    TLabel *Label32;
    TLabel *Label33;
    TLabel *Label34;
    TLabel *Label35;
    TLabel *Label36;
    TLabel *Label37;
    TLabel *Label38;
    TLabel *Label39;
    TLabel *Label40;
    TLabel *Label41;
    TLabel *Label42;
    TLabel *Label43;
    TLabel *Label44;
    TMemo *Memo1;
    TButton *Button1;
    TButton *Button2;
    TComboBox *ComboBox1;
    TButton *Button4;
    TButton *Button7;
    TGroupBox *GroupBox6;
    TLabel *Label26;
    TLabel *Label25;
    TMemo *Memo2;
    TEdit *Edit18;
    TEdit *Edit19;
    TGroupBox *GroupBox7;
    TLabel *Label16;
    TLabel *Label17;
    TCheckBox *CheckBox1;
    TCheckBox *CheckBox2;
    TCheckBox *CheckBox3;
    TCheckBox *CheckBox4;
    TGroupBox *GroupBox8;
    TLabel *Label18;
    TLabel *Label13;
    TLabel *Label14;
    TLabel *Label12;
    TLabel *Label11;
    TLabel *Label10;
    TLabel *Label3;
    TEdit *Edit14;
    TEdit *Edit12;
    TComboBox *ComboBox2;
    TEdit *Edit11;
    TEdit *Edit10;
    TEdit *Edit3;
    TEdit *Edit2;
    TOpenDialog *OpenDialog1;
    TSaveDialog *SaveDialog1;
    TEdit *Edit9;
    TLabel *Label15;
    TLabel *Label45;
    TLabel *LabelImgSize;
    void __fastcall Button8Click(TObject *Sender);
    void __fastcall Button6Click(TObject *Sender);
    void __fastcall Button16Click(TObject *Sender);
    void __fastcall Button12Click(TObject *Sender);
    void __fastcall Button17Click(TObject *Sender);
    void __fastcall Button11Click(TObject *Sender);
    void __fastcall Button10Click(TObject *Sender);
    void __fastcall Button2Click(TObject *Sender);
    void __fastcall Button1Click(TObject *Sender);
    void __fastcall Button7Click(TObject *Sender);
    void __fastcall Button4Click(TObject *Sender);
    void __fastcall UpDown1Click(TObject *Sender, TUDBtnType Button);
    void __fastcall Button5Click(TObject *Sender);
    void __fastcall Button9Click(TObject *Sender);
    void __fastcall Button15Click(TObject *Sender);
    void __fastcall FormDestroy(TObject *Sender);
    void __fastcall Button3Click(TObject *Sender);
    void __fastcall ComboBox1Change(TObject *Sender);
private:	// User declarations
public:		// User declarations
         __fastcall TForm1(TComponent* Owner);
    bool __fastcall LoadAPIC(int Index);
    void __fastcall ClearDatav1();
    void __fastcall ClearDatav2();
    void __fastcall SetFrameAttributes();
    void __fastcall SetFrameCommandButtons();
     int __fastcall FreeAndNULL(TObject *Obj);
    void __fastcall ResizeBitmapProportional(Graphics::TBitmap *Bitmap, int iWidth, int iHeight, TColor Background);
    void __fastcall ResizeBitmapBlt(Graphics::TBitmap *SrcBitmap, int width, int height);

};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
