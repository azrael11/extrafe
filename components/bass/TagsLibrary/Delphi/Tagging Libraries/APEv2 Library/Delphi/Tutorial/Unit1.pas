//********************************************************************************************************************************
//*                                                                                                                              *
//*     APEv2 Library Tutorial © 3delite 2012-2014                                                                               *
//*     See APEv2 Library Readme.txt for details                                                                                 *
//*                                                                                                                              *
//* Two licenses are available for commercial usage of this component:                                                           *
//* Shareware License: 25 Euros                                                                                                  *
//* Commercial License: 100 Euros                                                                                                *
//*                                                                                                                              *
//*     http://www.shareit.com/product.html?productid=300517941                                                                  *
//*                                                                                                                              *
//* Using the component in free programs is free.                                                                                *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/APEv2Library.html                                          *
//*                                                                                                                              *
//* This component is also available as a part of Tags Library:                                                                  *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/TagsLibrary.html                                           *
//*                                                                                                                              *
//* There is also an ID3v2 Library available at:                                                                                 *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html                                          *
//*                                                                                                                              *
//* and also an MP4 Tag Library available at:                                                                                    *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/MP4TagLibrary.html                                         *
//*                                                                                                                              *
//* and also an Ogg Vorbis and Opus Tag Library available at:                                                                    *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/OpusTagLibrary.html                                        *
//*                                                                                                                              *
//* a Flac Tag Library available at:                                                                                             *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/FlacTagLibrary.html                                        *
//*                                                                                                                              *
//* an WMA Tag Library available at:                                                                                             *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WMATagLibrary.html                                         *
//*                                                                                                                              *
//* an WAV Tag Library available at:                                                                                             *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WAVTagLibrary.html                                         *
//*                                                                                                                              *
//* For other Delphi components see the home page:                                                                               *
//*                                                                                                                              *
//*     http://www.3delite.hu/                                                                                                   *
//*                                                                                                                              *
//* If you have any questions or enquiries please mail: 3delite@3delite.hu                                                       *
//*                                                                                                                              *
//* Good coding! :)                                                                                                              *
//* 3delite                                                                                                                      *
//********************************************************************************************************************************

unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, APEv2Library, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, JPEG, PNGImage, Vcl.ImgList, Vcl.ExtDlgs;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    Button3: TButton;
    Button4: TButton;
    ListView1: TListView;
    Image1: TImage;
    Panel1: TPanel;
    Button5: TButton;
    EditFieldValue: TEdit;
    ComboBoxFieldName: TComboBox;
    ButtonDeleteField: TButton;
    ButtonAddField: TButton;
    ImageList1: TImageList;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Button6: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure ButtonAddFieldClick(Sender: TObject);
    procedure ButtonDeleteFieldClick(Sender: TObject);
    procedure ComboBoxFieldNameExit(Sender: TObject);
    procedure EditFieldValueChange(Sender: TObject);
    procedure EditFieldValueKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
    FOldListviewWindowProc: TWndMethod;
    procedure ListviewWindowproc(var Message: TMessage);
  public
    { Public declarations }
    procedure ListFields;
    procedure AttachValueEdit;
    procedure AttachFieldNameCombobox;
  end;

Const
    STR_CLICK_HERE_TO_EDIT = ' > CLICK HERE TO EDIT < ';
    STR_SELECT_A_FIELD_TYPE = ' > SELECT A FIELD TYPE OR ENTER A NAME < ';

var
  Form1: TForm1;
  APEv2Tag: TAPEv2Tag;

implementation

{$R *.dfm}

Uses
    CommCtrl;

procedure TForm1.Button1Click(Sender: TObject);
begin
    Close;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    if OpenDialog1.Execute then begin
        Edit1.Text := OpenDialog1.FileName;
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    APEv2Tag.LoadFromFile(Edit1.Text);
    Label3.Caption := IntToStr(APEv2Tag.Version);
    Label5.Caption := IntToStr(APEv2Tag.Size) + ' bytes';
    //* To get a particular field use:
    //Showmessage(APEv2Tag.ReadFrameByNameAsText('Title'));
    ListView1.Clear;
    ListFields;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
    APEv2Tag.SaveToFile(Edit1.Text);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
    RemoveAPEv2FromFile(Edit1.Text);
end;

procedure TForm1.Button6Click(Sender: TObject);
var
    PictureStream: TFileStream;
    Description: String;
begin
    if OpenPictureDialog1.Execute then begin
        Description := 'No description';
        if InputQuery('Add cover art picture', 'Description:', Description) then begin
            PictureStream := TFileStream.Create(OpenPictureDialog1.FileName, fmOpenRead);
            try
                APEv2Tag.AddCoverArtFrame('Cover Art (Front)', PictureStream, Description);
                //APEv2Tag.AddCoverArtFrame('Cover Art (Back)', PictureStream, Description);
            finally
                FreeAndNil(PictureStream);
            end;
            //* Update display
            Label3.Caption := IntToStr(APEv2Tag.Version);
            Label5.Caption := IntToStr(APEv2Tag.Size) + ' bytes';
            ListView1.Clear;
            ListFields;
        end;
    end;
end;

procedure TForm1.ButtonAddFieldClick(Sender: TObject);
begin
    EditFieldValue.Hide;
    with ListView1.Items.Add do begin
        Caption := STR_SELECT_A_FIELD_TYPE;
        SubItems.Add(STR_CLICK_HERE_TO_EDIT);
        Selected := True;
    end;
    AttachFieldNameCombobox;
    ComboBoxFieldName.Text := STR_SELECT_A_FIELD_TYPE;
    ComboBoxFieldName.SetFocus;
end;

procedure TForm1.ButtonDeleteFieldClick(Sender: TObject);
begin
    if Assigned(ListView1.Selected) then begin
        APEv2Tag.DeleteFrame(ListView1.Selected.Index);
        ListView1.Selected.Delete;
        EditFieldValue.Hide;
    end;
end;

procedure TForm1.ComboBoxFieldNameExit(Sender: TObject);
begin
    if (ComboBoxFieldName.Text <> ComboBoxFieldName.Items[0])
    AND (ComboBoxFieldName.Text <> STR_SELECT_A_FIELD_TYPE)
    AND (ComboBoxFieldName.Text <> '')
    then begin
        APEv2Tag.AddTextFrame(ComboBoxFieldName.Text, '');
        ListView1.Selected.Caption := ComboBoxFieldName.Text;
    end else begin
        ListView1.Selected.Delete;
    end;
    ComboBoxFieldName.Hide;
end;

procedure TForm1.EditFieldValueChange(Sender: TObject);
begin
    ListView1.Selected.SubItems[0] := EditFieldValue.Text;
    APEv2Tag.Frames[ListView1.Selected.Index].SetAsText(EditFieldValue.Text);
end;

procedure TForm1.EditFieldValueKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if Key = 13 then begin
        EditFieldValue.Hide;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    FOldListviewWindowProc:= ListView1.WindowProc;
    ListView1.WindowProc := ListviewWindowproc;
    APEv2Tag := TAPEv2Tag.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    FreeAndNil(APEv2Tag);
end;

procedure TForm1.ListFields;
var
    i: Integer;
begin
    //* List all fields found in the tag
    for i := 0 to APEv2Tag.Count - 1 do begin
        with ListView1.Items.Add do begin
            Caption := APEv2Tag.Frames[i].Name;
            case APEv2Tag.Frames[i].Format of
                ffUnknown: begin
                    SubItems.Add('Unknown content format');
                end;
                ffText: begin
                    SubItems.Add(APEv2Tag.Frames[i].GetAsText);
                end;
                ffBinary: begin
                    SubItems.Add('BINARY ' + IntToStr(APEv2Tag.Frames[i].Stream.Size) + ' bytes');
                end;
            end;
        end;
    end;

end;

procedure TForm1.ListView1Click(Sender: TObject);
begin
    AttachValueEdit;
end;

procedure TForm1.ListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
    PictureStream: TStream;
    PictureFormat: TAPEv2PictureFormat;
    Description: String;
    PictureJPEG: TJPEGImage;
    PicturePNG: TPNGImage;
begin
    //* This demonstrates how to get and display a cover picture
    if Selected then begin
        PictureStream := TMemoryStream.Create;
        try
            if APEv2Tag.GetCoverArtFromFrame(Item.Index, PictureStream, PictureFormat, Description) then begin
                case PictureFormat of
                    pfJPEG: begin
                        PictureJPEG := TJPEGImage.Create;
                        PictureJPEG.LoadFromStream(PictureStream);
                        Image1.Picture.Assign(PictureJPEG);
                        FreeAndNil(PictureJPEG);
                    end;
                    pfPNG: begin
                        PicturePNG := TPNGImage.Create;
                        PicturePNG.LoadFromStream(PictureStream);
                        Image1.Picture.Assign(PicturePNG);
                        FreeAndNil(PicturePNG);
                    end;
                    pfBMP: begin
                        Image1.Picture.Bitmap.LoadFromStream(PictureStream);
                    end;
                end;
                Label7.Caption := Description;
            end;
        finally
            FreeAndNil(PictureStream);
        end;
    end;
end;

procedure TForm1.AttachValueEdit;
var
    Rect: TRect;
begin
    if (NOT Assigned(ListView1.Selected))
    OR (APEv2Tag.Frames[ListView1.Selected.Index].Format = ffBinary)
    then begin
        EditFieldValue.Visible := False;
        Exit;
    end;
    FillChar(Rect, SizeOf(Rect), 0);
    ListView_GetSubItemRect(ListView1.Handle, ListView1.Selected.Index, 1, LVIR_BOUNDS, @Rect);
    EditFieldValue.Parent := ListView1;
    Rect.Top := Rect.Top - 1;
    Rect.Bottom := Rect.Bottom - 0;
    Rect.Left := Rect.Left + 0;
    Rect.Right := Rect.Right + 1;
    EditFieldValue.BoundsRect := Rect;
    EditFieldValue.Visible := True;
    EditFieldValue.Text := ListView1.Selected.SubItems[0];
    EditFieldValue.SetFocus;
end;

procedure TForm1.AttachFieldNameCombobox;
var
    Rect: TRect;
begin
    if NOT Assigned(ListView1.Selected) then begin
        ComboBoxFieldName.Visible := False;
        Exit;
    end;
    FillChar(Rect, SizeOf(Rect), 0);
    ListView_GetSubItemRect(ListView1.Handle, ListView1.Selected.Index, 0, LVIR_BOUNDS, @Rect);
    ComboBoxFieldName.Parent := ListView1;
    Rect.Top := Rect.Top - 1;
    Rect.Bottom := Rect.Bottom + 0;
    Rect.Left := Rect.Left + 0;
    Rect.Right := ListView1.Columns.Items[0].Width;
    ComboBoxFieldName.BoundsRect := Rect;
    ComboBoxFieldName.Visible := True;
end;

procedure TForm1.ListviewWindowproc(var Message: TMessage);
begin
    FOldListviewWindowProc(Message);
    case Message.Msg of
        WM_VSCROLL, WM_HSCROLL, WM_MOUSEWHEEL: if Message.WParamLo <> SB_ENDSCROLL then begin
            if ComboBoxFieldName.Visible then begin
                AttachFieldNameCombobox;
            end;
            AttachValueEdit;
        end;
    end;
end;

end.
