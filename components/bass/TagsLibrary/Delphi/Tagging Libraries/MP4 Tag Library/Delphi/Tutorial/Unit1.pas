//********************************************************************************************************************************
//*                                                                                                                              *
//*     MP4 Tag Library Tutorial © 3delite 2012-2015                                                                             *
//*     See MP4 Tag Library ReadMe.txt for details                                                                               *
//*                                                                                                                              *
//* Two licenses are available for commercial usage of this component:                                                           *
//* Shareware License: €50                                                                                                       *
//* Commercial License: €250                                                                                                     *
//*                                                                                                                              *
//*     http://www.shareit.com/product.html?productid=300548330                                                                  *
//*                                                                                                                              *
//* Using the component in free programs is free.                                                                                *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/MP4TagLibrary.html                                         *
//*                                                                                                                              *
//* This component is also available as a part of Tags Library:                                                                  *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/TagsLibrary.html                                           *
//*                                                                                                                              *
//* There is also an ID3v2 Library available at:                                                                                 *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html                                          *
//*                                                                                                                              *
//* and also an APEv2 Library available at:                                                                                      *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/APEv2Library.html                                          *
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
//* a WAV Tag Library available at:                                                                                              *
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
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, JPEG, PNGImage;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    OpenDialog: TOpenDialog;
    Button3: TButton;
    Memo1: TMemo;
    Panel1: TPanel;
    Image1: TImage;
    Button4: TButton;
    Label2: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label3: TLabel;
    Edit4: TEdit;
    Label4: TLabel;
    Edit5: TEdit;
    Label5: TLabel;
    Edit6: TEdit;
    Label6: TLabel;
    Edit7: TEdit;
    Label7: TLabel;
    Edit8: TEdit;
    Label8: TLabel;
    Edit9: TEdit;
    Label9: TLabel;
    Button5: TButton;
    Edit10: TEdit;
    Label10: TLabel;
    Edit11: TEdit;
    Label11: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

Uses
    MP4TagLibrary;

procedure TForm1.Button1Click(Sender: TObject);
begin
    Close;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    if OpenDialog.Execute then begin
        Edit1.Text := OpenDialog.FileName;
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
    MP4Tag: TMP4Tag;
    i: Integer;
    JPEGPicture: TJPEGImage;
    PNGPicture: TPNGImage;
    PictureMagic: Word;
begin
    MP4Tag := TMP4Tag.Create;
    MP4Tag.LoadFromFile(Edit1.Text);
    //* List specific tags
    Edit2.Text := MP4Tag.GetText('©nam');
    Edit3.Text := MP4Tag.GetText('©ART');
    Edit4.Text := MP4Tag.GetText('©alb');
    Edit5.Text := MP4Tag.GetGenre;
    Edit6.Text := MP4Tag.GetText('©day');
    //* Some helper functions which extract the values from the stream
    Edit7.Text := IntToStr(MP4Tag.GetTrack);
    Edit10.Text := IntToStr(MP4Tag.GetTotalTracks);
    Edit8.Text := IntToStr(MP4Tag.GetDisc);
    Edit11.Text := IntToStr(MP4Tag.GetTotalDiscs);
    Edit9.Text := MP4Tag.GetText('©cmt');
    //* List all atoms found and load the 1st cover art
    Memo1.Clear;
    for i := 0 to MP4Tag.Count - 1 do begin
        if IsSameAtomName(MP4Tag.Atoms[i].ID, 'covr') then begin
            Memo1.Lines.Add(AtomNameToString(MP4Tag.Atoms[i].ID) + ' ' + IntToStr(MP4Tag.Atoms[i].Size) + ' bytes = ' + IntToStr(MP4Tag.Atoms[i].Count) + ' covers');
        end else begin
            if IsSameAtomName(MP4Tag.Atoms[i].ID, 'gnre') then begin
                Memo1.Lines.Add(AtomNameToString(MP4Tag.Atoms[i].ID) + ' ' + IntToStr(MP4Tag.Atoms[i].Size) + ' bytes = ' + ID3Genres[MP4Tag.Atoms[i].GetAsInteger16]);
            end else if IsSameAtomName(MP4Tag.Atoms[i].ID, '----') then begin
                Memo1.Lines.Add(AtomNameToString(MP4Tag.Atoms[i].ID) + ' ' + IntToStr(MP4Tag.Atoms[i].Size) + ' bytes = ' + MP4Tag.Atoms[i].name.GetAsText + ' = ' + MP4Tag.Atoms[i].mean.GetAsText + ' = ' + MP4Tag.Atoms[i].GetAsText);
            end else begin
                //* Note that GetAsText returns integers too and calls GetAsInteger() internally which automatically choses the appropriate GetAsInteger function
                Memo1.Lines.Add(AtomNameToString(MP4Tag.Atoms[i].ID) + ' ' + IntToStr(MP4Tag.Atoms[i].Size) + ' bytes = ' + MP4Tag.Atoms[i].GetAsText);
            end;
        end;
        if IsSameAtomName(MP4Tag.Atoms[i].ID, 'covr') then begin
            //* Position should be at start, just to be sure
            MP4Tag.Atoms[i].Datas[0].Data.Seek(0, soBeginning);
            //* Datas[0] means the first cover stream
            MP4Tag.Atoms[i].Datas[0].Data.Read(PictureMagic, 2);
            if PictureMagic = MAGIC_JPG then begin
                JPEGPicture := TJPEGImage.Create;
                MP4Tag.Atoms[i].Datas[0].Data.Seek(0, soBeginning);
                JPEGPicture.LoadFromStream(MP4Tag.Atoms[i].Datas[0].Data);
                Image1.Picture.Assign(JPEGPicture);
                FreeAndNil(JPEGPicture);
            end;
            if PictureMagic = MAGIC_PNG then begin
                PNGPicture := TPNGImage.Create;
                MP4Tag.Atoms[i].Datas[0].Data.Seek(0, soBeginning);
                PNGPicture.LoadFromStream(MP4Tag.Atoms[i].Datas[0].Data);
                Image1.Picture.Assign(PNGPicture);
                FreeAndNil(PNGPicture);
            end;            
        end;
    end;
    FreeAndNil(MP4Tag);
end;

procedure TForm1.Button4Click(Sender: TObject);
var
    MP4Tag: TMP4Tag;
    Error: Integer;
begin
    MP4Tag := TMP4Tag.Create;
    MP4Tag.LoadFromFile(Edit1.Text);
    //* Set specific tags
    MP4Tag.SetText('©nam', Edit2.Text);
    MP4Tag.SetText('©ART', Edit3.Text);
    MP4Tag.SetText('©alb', Edit4.Text);
    //* Automatically set proper genre
    MP4Tag.SetGenre(Edit5.Text);
    //* Genre can be stored as an index to an ID3 genre + 1 or as a text (for custom genre)
    {
    GenreIndex := GenreToIndex(Edit5.Text);
    if GenreIndex > - 1 then begin
        MP4Tag.SetInteger16('gnre', GenreIndex);
    end else begin
        MP4Tag.SetText('©gen', Edit5.Text);
    end;
    }
    MP4Tag.SetText('©day', Edit6.Text);
    //* Some helper functions which encode the values to the stream
    MP4Tag.SetTrack(StrToIntDef(Edit7.Text, 0), StrToIntDef(Edit10.Text, 0));
    MP4Tag.SetDisc(StrToIntDef(Edit8.Text, 0), StrToIntDef(Edit11.Text, 0));
    MP4Tag.SetText('©cmt', Edit9.Text);
    //* Set an album cover picture
    //MP4Tag.DeleteAtom('covr');
    //MP4Tag.AddAtom('covr').AddData.Data.LoadFromFile('H:\MP4 Files\Cover1.png');
    //* To add more pictures
    //MP4Tag.FindAtom('covr').AddData.Data.LoadFromFile('H:\MP4 Files\Cover2.jpg');
    Error := MP4Tag.SaveToFile(Edit1.Text);
    if Error <> MP4TAGLIBRARY_SUCCESS then begin
        Showmessage('Error while saving tag, error code: ' + IntToStr(Error));
    end;
    FreeAndNil(MP4Tag);
end;

procedure TForm1.Button5Click(Sender: TObject);
var
    Error: Integer;
begin
    //* If 'KeepPadding' is True the space of the existing tags will be converted to a 'free' atom so the file size will not change
    //* If 'KeepPadding' is False then the file will shrink
    Error := RemoveMP4TagFromFile(Edit1.Text, False);
    if Error <> MP4TAGLIBRARY_SUCCESS then begin
        Showmessage('Error while removing tag, error code: ' + IntToStr(Error));
    end;
end;

end.
