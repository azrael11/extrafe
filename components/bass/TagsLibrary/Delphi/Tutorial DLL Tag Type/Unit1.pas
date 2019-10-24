//********************************************************************************************************************************
//*                                                                                                                              *
//*     Tags Library Tutorial © 3delite 2014-2015                                                                                *
//*     See Tags Library Readme.txt for details                                                                                  *
//*                                                                                                                              *
//* Two licenses are available for commercial usage of this component:                                                           *
//* Shareware License: €136                                                                                                      *
//* Commercial License: €625                                                                                                     *
//*                                                                                                                              *
//*     http://www.shareit.com/product.html?productid=300627308                                                                  *
//*                                                                                                                              *
//* Using the component in free programs is free.                                                                                *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/TagsLibrary.html                                           *
//*                                                                                                                              *
//* The used tagging libraries are also avilable separatelly:                                                                    *
//*                                                                                                                              *
//* APEv2 Library available at:                                                                                                  *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/apev2library.html                                          *
//*                                                                                                                              *
//* ID3v2 Library available at:                                                                                                  *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html                                          *
//*                                                                                                                              *
//* MP4 Tag Library available at:                                                                                                *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/MP4TagLibrary.html                                         *
//*                                                                                                                              *
//* Ogg Vorbis and Opus Tag Library available at:                                                                                *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/OpusTagLibrary.html                                        *
//*                                                                                                                              *
//* Flac Tag Library available at:                                                                                               *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/FlacTagLibrary.html                                        *
//*                                                                                                                              *
//* WMA Tag Library available at:                                                                                                *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WMATagLibrary.html                                         *
//*                                                                                                                              *
//* WAV Tag Library available at:                                                                                                *
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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, TagsLibraryDefs, JPEG, PNGImage, GIFImg, Vcl.ImgList;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    GroupBox2: TGroupBox;
    ListView1: TListView;
    OpenDialog1: TOpenDialog;
    GroupBox3: TGroupBox;
    ListView2: TListView;
    ImageListThumbs: TImageList;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    SaveDialog1: TSaveDialog;
    ComboBox1: TComboBox;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListTags;
    procedure ListCoverArts;
  end;

Const
    MAGIC_PNG = $5089;  //* Little endian form
    MAGIC_JPG = $d8ff;  //* Little endian form
    MAGIC_GIF = $4947;  //* Little endian form
    MAGIC_BMP = $4d42;  //* Little endian form

var
  Form1: TForm1;
  Tags: HTags;
  TagType: TTagType = ttID3v2;

implementation

{$R *.dfm}

procedure ResizeBitmap(Bitmap: TBitmap; Width, Height: Integer; Background: TColor);
var
  R: TRect;
  B: TBitmap;
  X, Y: Integer;
begin
  if assigned(Bitmap) then begin
    B:= TBitmap.Create;
    try
      if Bitmap.Width > Bitmap.Height then begin
        R.Right:= Width;
        R.Bottom:= ((Width * Bitmap.Height) div Bitmap.Width);
        X:= 0;
        Y:= (Height div 2) - (R.Bottom div 2);
      end else begin
        R.Right:= ((Height * Bitmap.Width) div Bitmap.Height);
        R.Bottom:= Height;
        X:= (Width div 2) - (R.Right div 2);
        Y:= 0;
      end;
      R.Left:= 0;
      R.Top:= 0;
      B.PixelFormat:= Bitmap.PixelFormat;
      B.Width:= Width;
      B.Height:= Height;
      B.Canvas.Brush.Color:= Background;
      B.Canvas.FillRect(B.Canvas.ClipRect);
      B.Canvas.StretchDraw(R, Bitmap);
      Bitmap.Width:= Width;
      Bitmap.Height:= Height;
      Bitmap.Canvas.Brush.Color:= Background;
      Bitmap.Canvas.FillRect(Bitmap.Canvas.ClipRect);
      Bitmap.Canvas.Draw(X, Y, B);
    finally
      B.Free;
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    if OpenDialog1.Execute then begin
        Edit1.Text := OpenDialog1.FileName;
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
    Error: Integer;
begin
    //* Remove all tags from file
    Error := TagsLibrary_RemoveTag(PWideChar(Edit1.Text), TagType);
    if Error <> TAGSLIBRARY_SUCCESS then begin
        MessageDlg('Error while removing tags from file.', mtWarning, [mbOk], 0);
    end;
    //* Re-load tags
    Button4Click(Sender);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
    Error: Integer;
begin
    //* Set specific tags
    //TagsLibrary_SetTag(Tags, PWideChar('ARTIST'), PWideChar(Edit2.Text), TagType);
    //TagsLibrary_SetTag(Tags, PWideChar('TITLE'), PWideChar(Edit3.Text), TagType);
    //TagsLibrary_SetTag(Tags, PWideChar('ALBUM'), PWideChar(Edit4.Text), TagType);
    //* Do the save
    Error := TagsLibrary_SaveEx(Tags, PWideChar(Edit1.Text), TagType);
    if Error <> TAGSLIBRARY_SUCCESS then begin
        MessageDlg('Error while saving tag.' {TagsLibraryErrorCode2String(Error)}, mtWarning, [mbOk], 0);
    end;
    //* Re-load
    Button4Click(Sender);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
    ListView1.Clear;
    ListView2.Clear;
    ImageListThumbs.Clear;
    //* PraseTags is False as we are not using the 'ttAutomatic' at all, so there's no need to parse the tags
    TagsLibrary_Load(Tags, PWideChar(Edit1.Text), TagType, False);
    if TagsLibrary_Loaded(Tags, TagType) then begin
        //* List all tags
        ListTags;
        //* List cover arts
        ListCoverArts;
    end;
end;

procedure TForm1.ListTags;
var
    i: Integer;
    ExtTag: TExtTag;
    SimpleTag: TSimpleTag;
    ID3v2TagEx: TID3v2TagEx;
    MP4TagEx: TMP4TagEx;
begin
    ListView1.Clear;
    //* List specific tags
    //Edit2.Text := TagsLibrary_GetTag(Tags, PWideChar('ARTIST'), TagType);
    //Edit3.Text := TagsLibrary_GetTag(Tags, PWideChar('TITLE'), TagType);
    //Edit4.Text := TagsLibrary_GetTag(Tags, PWideChar('ALBUM'), TagType);
    //* List all tags
    for i := 0 to TagsLibrary_TagCount(Tags, TagType) - 1 do begin
        //* Different tag formats need different tag data structures
        case TagType of
            //* TExtTag
            ttAutomatic: begin
                FillChar(ExtTag, SizeOf(ExtTag), 0);
                if TagsLibrary_GetTagByIndexEx(Tags, i, TagType, @ExtTag) then begin
                    with ListView1.Items.Add do begin
                        Caption := ExtTag.Name;
                        Subitems.Add(ExtTag.Value);
                    end;
                end;
            end;
            //* TSimpleTag
            ttAPEv2, ttFlac, ttID3v1, ttOpusVorbis, ttWAV, ttWMA: begin
                FillChar(SimpleTag, SizeOf(SimpleTag), 0);
                if TagsLibrary_GetTagByIndexEx(Tags, i, TagType, @SimpleTag) then begin
                    with ListView1.Items.Add do begin
                        Caption := SimpleTag.Name;
                        Subitems.Add(SimpleTag.Value);
                    end;
                end;
            end;
            //* TID3v2TagEx
            ttID3v2: begin
                FillChar(ID3v2TagEx, SizeOf(ID3v2TagEx), 0);
                if TagsLibrary_GetTagByIndexEx(Tags, i, TagType, @ID3v2TagEx) then begin
                    with ListView1.Items.Add do begin
                        Caption := ID3v2TagEx.Name;
                        Subitems.Add(ID3v2TagEx.Value);
                    end;
                end;
            end;
            //* TMP4TagEx
            ttMP4: begin
                FillChar(MP4TagEx, SizeOf(MP4TagEx), 0);
                if TagsLibrary_GetTagByIndexEx(Tags, i, TagType, @MP4TagEx) then begin
                    with ListView1.Items.Add do begin
                        Caption := MP4TagEx.Name;
                        Subitems.Add(MP4TagEx.Value);
                    end;
                end;
            end;
        end;
    end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
    PictureStream: TMemoryStream;
    Description: String;
    MIMEType: String;
    JPEGPicture: TJPEGImage;
    PNGPicture: TPNGImage;
    GIFPicture: TGIFImage;
    BMPPicture: TBitmap;
    Width, Height: Integer;
    NoOfColors: Integer;
    ColorDepth: Integer;
    PictureMagic: Word;
    CoverArtPictureFormat: TTagPictureFormat;
    CoverArtData: TCoverArtData;
begin
    if TagType = ttWAV then begin
        MessageDlg('WAV tag does not support cover arts.', mtError, [mbCancel], 0);
        Exit;
    end;
    if NOT OpenDialog1.Execute then begin
        Exit;
    end;
    //* Clear the cover art data
    MIMEType := '';
    Description := '';
    Width := 0;
    Height := 0;
    ColorDepth := 0;
    NoOfColors := 0;
    CoverArtPictureFormat := TTagPictureFormat.tpfUnknown;
    if FileExists(OpenDialog1.FileName) then begin
        try
            PictureStream := TMemoryStream.Create;
            try
                PictureStream.LoadFromFile(OpenDialog1.FileName);
                PictureStream.Seek(0, soBeginning);
                Description := ExtractFileName(OpenDialog1.FileName);
                PictureStream.Read(PictureMagic, 2);
                PictureStream.Seek(0, soBeginning);
                if PictureMagic = MAGIC_JPG then begin
                    MIMEType := 'image/jpeg';
                    CoverArtPictureFormat := tpfJPEG;
                    JPEGPicture := TJPEGImage.Create;
                    try
                        JPEGPicture.LoadFromStream(PictureStream);
                        Width := JPEGPicture.Width;
                        Height := JPEGPicture.Height;
                        NoOfColors := 0;
                        ColorDepth := 24;
                    finally
                        FreeAndNil(JPEGPicture);
                    end;
                end;
                if PictureMagic = MAGIC_PNG then begin
                    MIMEType := 'image/png';
                    CoverArtPictureFormat := tpfPNG;
                    PNGPicture := TPNGImage.Create;
                    try
                        PNGPicture.LoadFromStream(PictureStream);
                        Width := PNGPicture.Width;
                        Height := PNGPicture.Height;
                        NoOfColors := 0;
                        ColorDepth := PNGPicture.PixelInformation.Header.BitDepth;
                    finally
                        FreeAndNil(PNGPicture);
                    end;
                end;
                if PictureMagic = MAGIC_GIF then begin
                    MIMEType := 'image/gif';
                    CoverArtPictureFormat := tpfGIF;
                    GIFPicture := TGIFImage.Create;
                    try
                        GIFPicture.LoadFromStream(PictureStream);
                        Width := GIFPicture.Width;
                        Height := GIFPicture.Height;
                        NoOfColors := 0;   //GIFPicture.ColorResolution
                        ColorDepth := GIFPicture.BitsPerPixel;
                    finally
                        FreeAndNil(GIFPicture);
                    end;
                end;
                if PictureMagic = MAGIC_BMP then begin
                    MIMEType := 'image/bmp';
                    CoverArtPictureFormat := tpfBMP;
                    BMPPicture := TBitmap.Create;
                    try
                        BMPPicture.LoadFromStream(PictureStream);
                        Width := BMPPicture.Width;
                        Height := BMPPicture.Height;
                        NoOfColors := 0;
                        case BMPPicture.PixelFormat of
                            pfDevice: ColorDepth := 32;
                            pf1bit: ColorDepth := 1;
                            pf4bit: ColorDepth := 4;
                            pf8bit: ColorDepth := 8;
                            pf15bit: ColorDepth := 15;
                            pf16bit: ColorDepth := 16;
                            pf24bit: ColorDepth := 24;
                            pf32bit: ColorDepth := 32;
                            pfCustom: ColorDepth := 32;
                        end;
                    finally
                        FreeAndNil(BMPPicture);
                    end;
                end;
                PictureStream.Seek(0, soBeginning);
                //* Add the cover art
                CoverArtData.Name := PwideChar('Cover Art (Front)'); //* This field is only used for APEv2 and should be always 'Cover Art (Front)'
                CoverArtData.CoverType := 3; //* ID3v2 cover type (3: front cover)
                CoverArtData.MIMEType := PwideChar(MIMEType);
                CoverArtData.Description := PwideChar(Description);
                CoverArtData.Width := Width;
                CoverArtData.Height := Height;
                CoverArtData.ColorDepth := ColorDepth;
                CoverArtData.NoOfColors := NoOfColors;
                CoverArtData.PictureFormat := CoverArtPictureFormat;
                CoverArtData.Data := PictureStream.Memory;
                CoverArtData.DataSize := PictureStream.Size;
                if TagsLibrary_AddCoverArt(Tags, TagType, CoverArtData) = - 1 then begin
                    MessageDlg('Error while adding cover art: ' + SaveDialog1.FileName, mtError, [mbCancel], 0);
                end;
            finally
                FreeAndNil(PictureStream);
            end;
        except
            MessageDlg('Error while adding cover art: ' + SaveDialog1.FileName, mtError, [mbCancel], 0);
        end;
    end;
    //* Display added cover art
    ListCoverArts;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
    if ListView2.SelCount <> 1 then begin
        MessageDlg('Please select one cover art.', mtInformation, [mbOk], 0);
        Exit;
    end;
    TagsLibrary_DeleteCoverArt(Tags, TagType, ListView2.Selected.Index);
    //* Re-display cover arts
    ListCoverArts;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
    Fext: String;
    CoverArtData: TCoverArtData;
    CoverArtFileStream: TFileStream;
begin
    if ListView2.SelCount <> 1 then begin
        MessageDlg('Please select one cover art.', mtInformation, [mbOk], 0);
        Exit;
    end;
    if TagsLibrary_GetCoverArt(Tags, TagType, ListView2.Selected.Index, CoverArtData) then begin
        case CoverArtData.PictureFormat of
            tpfJPEG: Fext := '.jpg';
            tpfPNG: Fext := '.png';
            tpfGIF: Fext := '.gif';
            tpfBMP: Fext := '.bmp';
        else
            Fext := '.unknown';
        end;
        SaveDialog1.FileName := ChangeFileExt(CoverArtData.Description, Fext);
        if SaveDialog1.Execute then begin
            CoverArtFileStream := TFileStream.Create(SaveDialog1.FileName, fmCreate);
            try
                CoverArtFileStream.Write(CoverArtData.Data^, CoverArtData.DataSize);
            finally
                FreeAndNil(CoverArtFileStream);
            end;
        end;
    end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
    case ComboBox1.ItemIndex of
        0: TagType := ttAPEv2;
        1: TagType := ttFlac;
        2: TagType := ttID3v1;
        3: TagType := ttID3v2;
        4: TagType := ttMP4;
        5: TagType := ttOpusVorbis;
        6: TagType := ttWAV;
        7: TagType := ttWMA;
    end;
    ListTags;
    //* List cover arts
    ListCoverArts;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    //* This is automatically called when using Delphi
    InitTagsLibrary;
    //* Check if loaded
    if NOT TagsLibraryLoaded then begin
        MessageDlg('Error while loading TagsLib.dll.', mtError, [mbCancel], 0);
        Halt;
    end;
    //* Create a Tags Library instance
    Tags := TagsLibrary_Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    //* Free the Tags Library instance
    TagsLibrary_Free(Tags);
    //* This is automatically called when using Delphi
    FreeTagsLibrary;
end;

procedure TForm1.ListCoverArts;
var
    i: Integer;
    CoverArtData: TCoverArtData;
    PictureStream: TMemoryStream;
    ImageJPEG: TJPEGImage;
    ImagePNG: TPNGImage;
    ImageGIF: TGIFImage;
    Bitmap: TBitmap;
begin
    ListView2.Clear;
    ImageListThumbs.Clear;
    //* List cover arts
    for i := 0 to TagsLibrary_CoverArtCount(Tags, TagType) - 1 do begin
        if TagsLibrary_GetCoverArt(Tags, TagType, i, CoverArtData) then begin
            Bitmap := TBitmap.Create;
            PictureStream := TMemoryStream.Create;
            try
                //* Transfer the memory bytes to a TStream
                PictureStream.Write(CoverArtData.Data^, CoverArtData.DataSize);
                PictureStream.Seek(0, soBeginning);
                case CoverArtData.PictureFormat of
                    tpfJPEG: begin
                        ImageJPEG := TJPEGImage.Create;
                        try
                            ImageJPEG.LoadFromStream(PictureStream);
                            Bitmap.Assign(ImageJPEG);
                        finally
                            FreeAndNil(ImageJPEG);
                        end;
                    end;
                    tpfPNG: begin
                        ImagePNG := TPNGImage.Create;
                        try
                            ImagePNG.LoadFromStream(PictureStream);
                            Bitmap.Assign(ImagePNG);
                        finally
                            FreeAndNil(ImagePNG);
                        end;
                    end;
                    tpfGIF: begin
                        ImageGIF := TGIFImage.Create;
                        try
                            ImageGIF.LoadFromStream(PictureStream);
                            Bitmap.Assign(ImageGIF);
                        finally
                            FreeAndNil(ImageGIF);
                        end;
                    end;
                    tpfBMP: begin
                        Bitmap.LoadFromStream(PictureStream);
                    end;
                end;
                //* This function resizes with nearest-neighbour mode (which is not recommended as it gives the worst quality possible),
                //* if you need a top-quality lanczos resizer which uses Graphics32, please contact me.
                ResizeBitmap(Bitmap, 160, 120, clWhite);
                with ListView2.Items.Add do begin
                    Caption := CoverArtData.Name;
                    ImageIndex := ImageListThumbs.Add(Bitmap, nil);
                end;
            finally
                FreeAndNil(Bitmap);
                FreeAndNil(PictureStream);
            end;
        end;
    end;
end;

end.
