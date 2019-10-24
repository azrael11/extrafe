//********************************************************************************************************************************
//*                                                                                                                              *
//*     Ogg Vorbis and Opus Tag Library © 3delite 2012-2015                                                                      *
//*     See Ogg Vorbis and Opus Tag Library Readme.txt for details                                                               *
//*                                                                                                                              *
//* Two licenses are available for commercial usage of this component:                                                           *
//* Shareware License: €50                                                                                                       *
//* Commercial License: €250                                                                                                     *
//*                                                                                                                              *
//*     http://www.shareit.com/product.html?productid=300552311                                                                  *
//*                                                                                                                              *
//* Using the component in free programs is free.                                                                                *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/OpusTagLibrary.html                                        *
//*                                                                                                                              *
//* This component is also available as a part of Tags Library:                                                                  *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/TagsLibrary.html                                           *
//*                                                                                                                              *
//* There is also an ID3v2 Library available at:                                                                                 *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html                                          *
//*                                                                                                                              *
//* an APEv2 Library available at:                                                                                               *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/APEv2Library.html                                          *
//*                                                                                                                              *
//* an MP4 Tag Library available at:                                                                                             *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/MP4TagLibrary.html                                         *
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
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, JPEG, PNGImage, OggVorbisAndOpusTagLibrary;

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
    Panel1: TPanel;
    Image1: TImage;
    Button6: TButton;
    Button7: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DisplayCoverArt;
  end;

var
    Form1: TForm1;
    OpusTag: TOpusTag;

implementation

{$R *.dfm}

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
    i: Integer;
begin
    OpusTag.LoadFromFile(Edit1.Text);
    //* List specific tags
    Edit2.Text := OpusTag.ReadFrameByNameAsText('TITLE');
    Edit3.Text := OpusTag.ReadFrameByNameAsText('ARTIST');
    Edit4.Text := OpusTag.ReadFrameByNameAsText('ALBUM');
    Edit5.Text := OpusTag.ReadFrameByNameAsText('GENRE');
    Edit6.Text := OpusTag.ReadFrameByNameAsText('YEAR');
    Edit7.Text := OpusTag.ReadFrameByNameAsText('TRACK');
    Edit8.Text := OpusTag.ReadFrameByNameAsText('DISC');
    Edit9.Text := OpusTag.ReadFrameByNameAsText('COMMENT');
    //* Display first cover art if exists
    Image1.Picture.Assign(nil);
    DisplayCoverArt;
    //* List all tags found
    Memo1.Clear;
    Memo1.Lines.Add('Vendor = ' + OpusTag.VendorString);
    for i := 0 to OpusTag.Count - 1 do begin
        if OpusTag.Frames[i].Name = OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE then begin
            Memo1.Lines.Add(OpusTag.Frames[i].Name + ' = ' + IntToStr(OpusTag.Frames[i].Stream.Size) + ' bytes');
        end else begin
            Memo1.Lines.Add(OpusTag.Frames[i].Name + ' = ' + OpusTag.Frames[i].GetAsText);
        end;
    end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
    Error: Integer;
begin
    //* Set specific tags
    OpusTag.SetTextFrameText('TITLE', Edit2.Text);
    OpusTag.SetTextFrameText('ARTIST', Edit3.Text);
    OpusTag.SetTextFrameText('ALBUM', Edit4.Text);
    OpusTag.SetTextFrameText('GENRE', Edit5.Text);
    OpusTag.SetTextFrameText('YEAR', Edit6.Text);
    OpusTag.SetTextFrameText('TRACK', Edit7.Text);
    OpusTag.SetTextFrameText('DISC', Edit8.Text);
    OpusTag.SetTextFrameText('COMMENT', Edit9.Text);
    //* Save the tag
    Error := OpusTag.SaveToFile(Edit1.Text);
    if Error <> OPUSTAGLIBRARY_SUCCESS then begin
        Showmessage('Error while saving tag, error code: ' + IntToStr(Error));
    end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
    Error: Integer;
begin
    Error := RemoveOpusTagFromFile(Edit1.Text);
    if Error <> OPUSTAGLIBRARY_SUCCESS then begin
        Showmessage('Error while removing tag, error code: ' + IntToStr(Error));
    end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
    CoverArt: TOpusVorbisCoverArtInfo;
    NewPictureStream: TFileStream;
begin
    if OpenDialog.Execute then begin
        OpusTag.LoadFromFile(Edit1.Text);
        NewPictureStream := TFileStream.Create(OpenDialog.FileName, fmOpenRead);
        try
            //* Here the attributes of the picture are not set properly, please get and set these values when using this function
            with CoverArt do begin
                PictureType := 3;
                MIMEType := 'image/jpeg';
                Description := 'Description of cover art';
                Width := 500;
                Height := 500;
                ColorDepth := 24;
                NoOfColors := 0;
            end;
            if OpusTag.AddCoverArtFrame(NewPictureStream, CoverArt) > - 1 then begin
                Image1.Picture.Assign(nil);
                //* Note: the following will display the first cover art, so if you add more adjust the code
                DisplayCoverArt;
                OpusTag.SaveToFile(Edit1.Text);
            end else begin
                MessageDlg('Error while adding cover art.', mtError, [mbOk], 0);
            end;
        finally
            FreeAndNil(NewPictureStream);
        end;
    end;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
    Index: Integer;
    PictureStream: TStream;
    CoverArt: TOpusVorbisCoverArtInfo;
    Fext: String;
begin
    Index := OpusTag.FrameExists(OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE);
    if Index > - 1 then begin
        PictureStream := TMemoryStream.Create;
        try
            if OpusTag.GetCoverArtFromFrame(Index, PictureStream, CoverArt) then begin
                CoverArt.MIMEType := LowerCase(CoverArt.MIMEType);
                PictureStream.Seek(0, soFromBeginning);
                //* If JPG
                if (CoverArt.MIMEType = 'image/jpeg')
                OR (CoverArt.MIMEType = 'image/jpg')
                then begin
                    Fext := '.jpg';
                end;
                //* If PNG
                if (CoverArt.MIMEType = 'image/png')
                then begin
                    Fext := '.png';
                end;
                //* If GIF
                if (CoverArt.MIMEType = 'image/gif')
                then begin
                    Fext := '.gif';
                end;
                //* If BMP
                if CoverArt.MIMEType = 'image/bmp' then begin
                    Fext := '.bmp';
                end;
                OpenDialog.FileName := CoverArt.Description + Fext;
                if OpenDialog.Execute then begin
                    TMemoryStream(PictureStream).SaveToFile(ChangeFileExt(OpenDialog.FileName, Fext));
                end;
            end;
        finally
            FreeAndNil(PictureStream);
        end;
    end;
end;

procedure TForm1.DisplayCoverArt;
var
    Index: Integer;
    JPEGPicture: TJPEGImage;
    PNGPicture: TPNGImage;
    PictureStream: TStream;
    CoverArt: TOpusVorbisCoverArtInfo;
begin
    try
        Index := OpusTag.FrameExists(OPUSTAGLIBRARY_FRAMENAME_METADATA_BLOCK_PICTURE);
        if Index > - 1 then begin
            PictureStream := TMemoryStream.Create;
            try
                if OpusTag.GetCoverArtFromFrame(Index, PictureStream, CoverArt) then begin
                    CoverArt.MIMEType := LowerCase(CoverArt.MIMEType);
                    PictureStream.Seek(0, soFromBeginning);
                    //* Do what you want with PictureStream here
                    //* We load the APIC picture into a TPicture
                    //* If JPG
                    if (CoverArt.MIMEType = 'image/jpeg')
                    OR (CoverArt.MIMEType = 'image/jpg')
                    then begin
                        JPEGPicture := TJPEGImage.Create;
                        JPEGPicture.LoadFromStream(PictureStream);
                        JPEGPicture.DIBNeeded;
                        Image1.Picture.Assign(JPEGPicture);
                        FreeAndNil(JPEGPicture);
                    end;
                    //* If PNG
                    if (CoverArt.MIMEType = 'image/png')
                    then begin
                        PNGPicture := TPNGImage.Create;
                        PNGPicture.LoadFromStream(PictureStream);
                        Image1.Picture.Assign(PNGPicture);
                        FreeAndNil(PNGPicture);
                    end;
                    //* If BMP
                    if CoverArt.MIMEType = 'image/bmp' then begin
                        Image1.Picture.Bitmap.LoadFromStream(PictureStream);
                    end;
                end;
            finally
                FreeAndNil(PictureStream);
            end;
        end;
    except
        //*
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    //* Padding is useful when the new tag fits in the existing tag, the file is not re-created only the tag is re-written.
    //* It also doesn't need exclusive access to the file, so the file can be locked.
    //* For Opus files it will add a 'PADDING' tag filled with '#'.
    //* Set to write padding globaly
    //OpusTagLibraryWritePadding := True;
    //* Optionally set global padding size
    //* OpusTagLibraryPaddingSize := 4096;
    OpusTag := TOpusTag.Create;
    //* Also it is possible to specify the padding options for a particular object. Note that global options are copied when creating an object.
    //OpusTag.WritePadding := True;
    //OpusTag.PaddingSize := 1024;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    FreeAndNil(OpusTag);
end;

end.
