//********************************************************************************************************************************
//*                                                                                                                              *
//*     Flac Tag Library Tutorial © 3delite 2013-2014                                                                            *
//*     See Flac Tag Library ReadMe.txt for details                                                                              *
//*                                                                                                                              *
//* This unit is based on ATL's FlacFile class but many new features were added, specially full support for managing cover arts  *
//* and support of Ogg Flac files.                                                                                               *
//* As the original unit is LGPL licensed you are entitled to use it for free given the LGPL license terms.                      *
//* If you are using the cover art managing functions (read and/or write) and/or Ogg Flac functions you can use it for free for  *
//* free programs/projects but for shareware or commerical programs you need one of the following licenses:                      *
//* Shareware License: €25                                                                                                       *
//* Commercial License: €100                                                                                                     *
//*                                                                                                                              *
//*     http://www.shareit.com/product.html?productid=300576722                                                                  *
//*                                                                                                                              *
//* Using the component in free programs is free.                                                                                *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/FlacTagLibrary.html                                        *
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
//* and an Ogg Vorbis and Opus Tag Library available at:                                                                         *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/OpusTagLibrary.html                                        *
//*                                                                                                                              *
//* and a WMA Tag Library available at:                                                                                          *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WMATagLibrary.html                                         *
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
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, JPEG, PNGImage, FlacTagLibrary,
    Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    OpenDialogCoverArt: TOpenDialog;
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
    UpDown1: TUpDown;
    OpenDialogFlac: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    CoverArtIndex: Integer;
    { Public declarations }
    procedure DisplayCoverArt(Index: Integer);
  end;

var
    Form1: TForm1;
    FLACfile: TFlacTag;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
    Close;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    if OpenDialogFlac.Execute then begin
        Edit1.Text := OpenDialogFlac.FileName;
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
    i: Integer;
    iMetaType: Integer;
    Error: Integer;
begin
    CoverArtIndex := - 1;
    Error := FLACfile.LoadFromFile(Edit1.Text);
    Edit2.Text := FLACfile.ReadFrameByNameAsText('TITLE');
    Edit3.Text := FLACfile.ReadFrameByNameAsText('ARTIST');
    Edit4.Text := FLACfile.ReadFrameByNameAsText('ALBUM');
    Edit5.Text := FLACfile.ReadFrameByNameAsText('GENRE');
    Edit6.Text := FLACfile.ReadFrameByNameAsText('DATE');
    Edit7.Text := FLACfile.ReadFrameByNameAsText('TRACKNUMBER');
    Edit8.Text := FLACfile.ReadFrameByNameAsText('DISC');
    Edit9.Text := FLACfile.ReadFrameByNameAsText('COMMENT');
    //* List other meta blocks found
    Memo1.Clear;
    for i := 0 to Length(FLACfile.aMetaBlockOther) - 1 do begin
        iMetaType := (FLACfile.aMetaBlockOther[i].MetaDataBlockHeader[1] and $7F); // decode metablock type
        Memo1.Lines.Add('Meta block ' + IntToStr(iMetaType) + ' = ' + IntToStr(FLACfile.aMetaBlockOther[i].Data.Size) + ' bytes');
    end;
    for i := 0 to Length(FLACfile.MetaBlocksCoverArts) - 1 do begin
        Memo1.Lines.Add('Cover art block = ' + IntToStr(FLACfile.MetaBlocksCoverArts[i].Data.Size) + ' bytes');
    end;
    DisplayCoverArt(0);
    if Error <> FLACTAGLIBRARY_SUCCESS then begin
        Showmessage('Error while loading tag, error code: ' + IntToStr(Error));
    end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
    Error: Integer;
begin
    FLACfile.SetTextFrameText('TITLE', Edit2.Text);
    FLACfile.SetTextFrameText('ARTIST', Edit3.Text);
    FLACfile.SetTextFrameText('ALBUM', Edit4.Text);
    FLACfile.SetTextFrameText('GENRE', Edit5.Text);
    FLACfile.SetTextFrameText('DATE', Edit6.Text);
    FLACfile.SetTextFrameText('TRACKNUMBER', Edit7.Text);
    FLACfile.SetTextFrameText('DISC', Edit8.Text);
    FLACfile.SetTextFrameText('COMMENT', Edit9.Text);
    //* Remove first cover art from tag
    //FLACfile.DeleteCoverArt(0);
    Error := FLACfile.SaveToFile(Edit1.Text);
    if Error <> FLACTAGLIBRARY_SUCCESS then begin
        Showmessage('Error while saving tag, error code: ' + IntToStr(Error));
    end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
    Error: Integer;
begin
    Error := RemoveFlacTagFromFile(Edit1.Text);
    if Error <> FLACTAGLIBRARY_SUCCESS then begin
        Showmessage('Error while removing tag, error code: ' + IntToStr(Error));
    end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
    NewPictureStream: TFileStream;
    Index: Integer;
    Error: Integer;
    FlacTagCoverArt: TFlacTagCoverArtInfo;
begin
    Index := 0;
    if OpenDialogCoverArt.Execute then begin
        try
            FLACfile.LoadFromFile(Edit1.Text);
            Index := FLACfile.AddMetaDataCoverArt(nil, 0);
            NewPictureStream := TFileStream.Create(OpenDialogCoverArt.FileName, fmOpenRead);
            try
                //* Here the attributes of the picture are not set properly, please get and set these values when using this function
                with FlacTagCoverArt do begin
                    PictureType := 3;
                    MIMEType := 'image/jpeg';
                    Description := 'Description of cover art';
                    Width := 500;
                    Height := 500;
                    ColorDepth := 24;
                    NoOfColors := 0;
                end;
                if NOT FLACfile.SetCoverArt(Index, NewPictureStream, FlacTagCoverArt) then begin
                    MessageDlg('Error while adding cover art.', mtError, [mbOk], 0);
                end;
            finally
                FreeAndNil(NewPictureStream);
            end;
            Error := FLACfile.SaveToFile(Edit1.Text);
            if Error <> FLACTAGLIBRARY_SUCCESS then begin
                Showmessage('Error while saving tag, error code: ' + IntToStr(Error));
            end;
        finally
            //* Re-load the tag information
            Button3Click(Sender);
            //* Display added cover art
            Image1.Picture.Assign(nil);
            DisplayCoverArt(Index);
        end;
    end;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
    Index: Integer;
    PictureStream: TStream;
    FlacTagCoverArt: TFlacTagCoverArtInfo;
    Fext: String;
begin
    Index := CoverArtIndex;
    if Index > - 1 then begin
        PictureStream := TMemoryStream.Create;
        try
            if FLACfile.GetCoverArt(Index, PictureStream, FlacTagCoverArt) then begin
                FlacTagCoverArt.MIMEType := LowerCase(FlacTagCoverArt.MIMEType);
                PictureStream.Seek(0, soFromBeginning);
                //* If JPG
                if (FlacTagCoverArt.MIMEType = 'image/jpeg')
                OR (FlacTagCoverArt.MIMEType = 'image/jpg')
                then begin
                    Fext := '.jpg';
                end;
                //* If PNG
                if (FlacTagCoverArt.MIMEType = 'image/png')
                then begin
                    Fext := '.png';
                end;
                //* If GIF
                if (FlacTagCoverArt.MIMEType = 'image/gif')
                then begin
                    Fext := '.gif';
                end;
                //* If BMP
                if FlacTagCoverArt.MIMEType = 'image/bmp' then begin
                    Fext := '.bmp';
                end;
                OpenDialogCoverArt.FileName := FlacTagCoverArt.Description + Fext;
                if OpenDialogCoverArt.Execute then begin
                    TMemoryStream(PictureStream).SaveToFile(ChangeFileExt(OpenDialogCoverArt.FileName, Fext));
                end;
            end;
        finally
            FreeAndNil(PictureStream);
        end;
    end;
end;

procedure TForm1.DisplayCoverArt(Index: Integer);
var
    JPEGPicture: TJPEGImage;
    PNGPicture: TPNGImage;
    PictureStream: TStream;
    FlacTagCoverArt: TFlacTagCoverArtInfo;
begin
    try
        if Index > - 1 then begin
            PictureStream := TMemoryStream.Create;
            try
                if FLACfile.GetCoverArt(Index, PictureStream, FlacTagCoverArt) then begin
                    PictureStream.Seek(0, soFromBeginning);
                    //* Do what you want with PictureStream here
                    //* We load the APIC picture into a TPicture
                    //* If JPG
                    if (FlacTagCoverArt.MIMEType = 'image/jpeg')
                    OR (FlacTagCoverArt.MIMEType = 'image/jpg')
                    then begin
                        JPEGPicture := TJPEGImage.Create;
                        JPEGPicture.LoadFromStream(PictureStream);
                        JPEGPicture.DIBNeeded;
                        Image1.Picture.Assign(JPEGPicture);
                        FreeAndNil(JPEGPicture);
                    end;
                    //* If PNG
                    if (FlacTagCoverArt.MIMEType = 'image/png')
                    then begin
                        PNGPicture := TPNGImage.Create;
                        PNGPicture.LoadFromStream(PictureStream);
                        Image1.Picture.Assign(PNGPicture);
                        FreeAndNil(PNGPicture);
                    end;
                    //* If BMP
                    if FlacTagCoverArt.MIMEType = 'image/bmp' then begin
                        Image1.Picture.Bitmap.LoadFromStream(PictureStream);
                    end;
                    CoverArtIndex := Index;
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
    FLACfile := TFlacTag.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    FreeAndNil(FLACfile);
end;

procedure TForm1.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
    Application.ProcessMessages;
    if Button = btNext then begin
        DisplayCoverArt(CoverArtIndex + 1);
    end;
    if Button = btPrev then begin
        DisplayCoverArt(CoverArtIndex - 1);
    end;
end;

end.
