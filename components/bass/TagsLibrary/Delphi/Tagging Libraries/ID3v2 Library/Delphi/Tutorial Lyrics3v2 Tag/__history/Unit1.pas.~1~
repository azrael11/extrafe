//********************************************************************************************************************************
//*                                                                                                                              *
//*     ID3v1 Library Lyrics Tag Tutorial © 3delite 2010-2015                                                                    *
//*     See ID3v2 Library 2.0 ReadMe.txt for details                                                                             *
//*                                                                                                                              *
//* Two licenses are available for commercial usage of this component:                                                           *
//* Shareware License: 50 Euros                                                                                                  *
//* Commercial License: 250 Euros                                                                                                *
//*                                                                                                                              *
//*     http://www.shareit.com/product.html?productid=300294127                                                                  *
//*                                                                                                                              *
//* Using the component in free programs is free.                                                                                *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html                                          *
//*                                                                                                                              *
//* There is also an APEv2 Library available at:                                                                                 *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/APEv2Library.html                                          *
//*                                                                                                                              *
//* and also an MP4 Tag Library available at:                                                                                    *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/MP4TagLibrary.html                                         *
//*                                                                                                                              *
//* and also an Ogg Vorbis and Opus Tag Library available at:                                                                    *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/OpusTagLibrary.html                                        *
//*                                                                                                                              *
//* and also a Flac Tag Library available at:                                                                                    *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/FlacTagLibrary.html                                        *
//*                                                                                                                              *
//* and also a WMA Tag Library available at:                                                                                     *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WMATagLibrary.html                                        *
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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ID3v1Library, Vcl.StdCtrls, Vcl.ExtCtrls, JPEG, PNGImage, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    GroupBox2: TGroupBox;
    Button3: TButton;
    Button4: TButton;
    Memo1: TMemo;
    MemoLyrics: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  LyricsTag: TID3v1Tag;

implementation

{$R *.dfm}

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

procedure TForm1.Button4Click(Sender: TObject);
var
    i: Integer;
begin
    //* Load the tag
    LyricsTag.LoadFromFile(Edit1.Text);
    //* Display lyrics
    MemoLyrics.Clear;
    MemoLyrics.Text := LyricsTag.Lyrics;
    //* List all other fields
    Memo1.Clear;
    for i := 0 to Length(LyricsTag.LyricsFrames) - 1 do begin
        if LyricsTag.LyricsFrames[i].ID <> 'LYR' then begin
            Memo1.Lines.Add(LyricsTag.LyricsFrames[i].ID + ' = ' + LyricsTag.LyricsFrames[i].Data);
        end;
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    LyricsTag.Lyrics := MemoLyrics.Text;
    //* Save the tag (including Lyrics tag)
    LyricsTag.SaveToFile(Edit1.Text, True);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    LyricsTag := TID3v1Tag.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    FreeAndNil(LyricsTag);
end;

end.
