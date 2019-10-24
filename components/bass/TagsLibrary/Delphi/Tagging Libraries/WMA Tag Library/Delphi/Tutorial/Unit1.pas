//********************************************************************************************************************************
//*                                                                                                                              *
//*     WMA Tag Library 1.0 © 3delite 2013-2014                                                                                  *
//*     See WMA Tag Library ReadMe.txt for details                                                                               *
//*                                                                                                                              *
//* Two licenses are available for commercial usage of this component:                                                           *
//* Shareware License: €25                                                                                                       *
//* Commercial License: €100                                                                                                     *
//*                                                                                                                              *
//*     http://www.shareit.com/product.html?productid=300579129                                                                  *
//*                                                                                                                              *
//* Using the component in free programs is free.                                                                                *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WMATagLibrary.html                                         *
//*                                                                                                                              *
//* This component is also available as a part of Tags Library:                                                                  *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/TagsLibrary.html                                           *
//*                                                                                                                              *
//* There is an ID3v2 Library available at:                                                                                      *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html                                          *
//*                                                                                                                              *
//* and an MP4 Tag Library available at:                                                                                         *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/MP4TagLibrary.html                                         *
//*                                                                                                                              *
//* and an Ogg Vorbis and Opus Tag Library available at:                                                                         *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/OpusTagLibrary.html                                        *
//*                                                                                                                              *
//* and an APEv2 Tag Library available at:                                                                                       *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/APEv2Library.html                                          *
//*                                                                                                                              *
//* and a Flac Tag Library available at:                                                                                         *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/FlacTagLibrary.html                                        *
//*                                                                                                                              *
//* and a WAV Tag Library available at:                                                                                          *
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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WMATagLibrary, Vcl.StdCtrls, Vcl.ExtCtrls, JPEG, PNGImage, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Panel1: TPanel;
    Image1: TImage;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    UpDown1: TUpDown;
    Memo1: TMemo;
    OpenDialog2: TOpenDialog;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure UpDown1ChangingEx(Sender: TObject; var AllowChange: Boolean; NewValue: SmallInt; Direction: TUpDownDirection);
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CoverArtIndex: Integer;
    procedure DisplayCoverArt(Index: Integer);
  end;

var
  Form1: TForm1;
  WMATag: TWMATag;

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
    WMATag.LoadFromFile(Edit1.Text);
    //* Display some fields
    Edit2.Text := WMATag.ReadFrameByNameAsText(g_wszWMAuthor);
    Edit3.Text := WMATag.ReadFrameByNameAsText(g_wszWMTitle);
    Edit4.Text := WMATag.ReadFrameByNameAsText(g_wszWMAlbumTitle);
    //* List all attributes
    Memo1.Clear;
    for i := 0 to WMATag.Count - 1 do begin
        if WMATag.Frames[i].Format = WMT_TYPE_STRING then begin
            Memo1.Lines.Add(WMATag.Frames[i].Name + ' = ' + WMATag.Frames[i].GetAsText);
        end else begin
            Memo1.Lines.Add(WMATag.Frames[i].Name + ' = ' + IntToStr(WMATag.Frames[i].GetAsInteger) + ' ('+ IntToStr(WMATag.Frames[i].Stream.Size) + ' bytes)');
        end;
    end;
    //* Display 1st cover art
    DisplayCoverArt(0);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    //* Set some fields
    WMATag.SetTextFrameText(g_wszWMAuthor, Edit2.Text);
    WMATag.SetTextFrameText(g_wszWMTitle, Edit3.Text);
    WMATag.SetTextFrameText(g_wszWMAlbumTitle, Edit4.Text);
    //* Note: if value is set it to nothing ('') it will delete the frame
    //* Save the tag
    WMATag.SaveToFile(Edit1.Text);
end;

procedure TForm1.Button5Click(Sender: TObject);
var
    PictureStream: TStream;
    MIMEType: String;
    Description: String;
    Index: Integer;
begin
    if OpenDialog2.Execute then begin
        //* Add a JPEG cover art
        PictureStream := TFileStream.Create(OpenDialog2.FileName, fmOpenRead);
        try
            MIMEType := 'image/jpeg';
            Description := 'No description';
            Index := WMATag.AddFrame(g_wszWMPicture).Index;
            WMATag.SetCoverArtFrame(Index, PictureStream, MIMEType, 3, Description);
        finally
            FreeAndNil(PictureStream);
        end;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    WMATag := TWMATag.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    FreeAndNil(WMATag);
end;

procedure TForm1.UpDown1ChangingEx(Sender: TObject; var AllowChange: Boolean; NewValue: SmallInt; Direction: TUpDownDirection);
begin
    if Direction = updUp then begin
        DisplayCoverArt(CoverArtIndex + 1);
    end;
    if Direction = updDown then begin
        DisplayCoverArt(CoverArtIndex - 1);
    end;
end;

procedure TForm1.DisplayCoverArt(Index: Integer);
var
    ImageJPEG: TJPEGImage;
    ImagePNG: TPNGImage;
    i: Integer;
    CoverArtCounter: Integer;
    MIMEType: String;
    PictureStream: TStream;
    PictureType: Byte;
    Description: String;
begin
    CoverArtCounter := - 1;
    for i := 0 to WMATag.Count - 1 do begin
        if WMATag.Frames[i].Name = g_wszWMPicture then begin
            Inc(CoverArtCounter);
            if CoverArtCounter = Index then begin
                PictureStream := TMemoryStream.Create;
                try
                    if WMATag.GetCoverArtFromFrame(i, PictureStream, MIMEType, PictureType, Description) then begin
                        MIMEType := LowerCase(MIMEType);
                        PictureStream.Seek(0, soBeginning);
                        if (MIMEType = 'image/jpeg')
                        OR (MIMEType = 'image/jpg')
                        then begin
                            ImageJPEG := TJPEGImage.Create;
                            try
                                ImageJPEG.LoadFromStream(PictureStream);
                                Image1.Picture.Assign(ImageJPEG);
                            finally
                                FreeAndNil(ImageJPEG);
                            end;
                        end;
                        if MIMEType = 'image/png' then begin
                            ImagePNG := TPNGImage.Create;
                            try
                                ImagePNG.LoadFromStream(PictureStream);
                                Image1.Picture.Assign(ImagePNG);
                            finally
                                FreeAndNil(ImagePNG);
                            end;
                        end;
                        CoverArtIndex := Index;
                    end;
                finally
                    FreeAndNil(PictureStream);
                end;
            end;
        end;
    end;
end;

end.
