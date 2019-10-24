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
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, TagsLibrary, JPEG, PNGImage, GIFImg, BASS, Vcl.ImgList;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button4: TButton;
    GroupBox2: TGroupBox;
    ListView1: TListView;
    OpenDialog1: TOpenDialog;
    GroupBox3: TGroupBox;
    ListView2: TListView;
    ImageListThumbs: TImageList;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Label2: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListTags;
    procedure ListCoverArts;
  end;

var
  Form1: TForm1;
  Tags: TTags;
  Channel: HStream;

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
begin
    BASS_StreamFree(Channel);
    Channel := BASS_StreamCreateURL(PChar(Edit2.Text), 0, BASS_STREAM_DECODE OR BASS_UNICODE, nil, nil);
    if Channel = 0 then begin
        MessageDlg('Could not open specified URL for BASS.', mtError, [mbCancel], 0);
        Exit;
    end;
    ListView1.Clear;
    ListView2.Clear;
    ImageListThumbs.Clear;
    Tags.LoadFromBASS(Channel);
    if Tags.Loaded then begin
        //* List all tags
        ListTags;
        //* List cover arts
        ListCoverArts;
    end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
    BASS_StreamFree(Channel);
    Channel := BASS_StreamCreateFile(False, PChar(Edit1.Text), 0, 0, BASS_STREAM_DECODE OR BASS_UNICODE);
    if Channel = 0 then begin
        MessageDlg('Could not open specified file for BASS.', mtError, [mbCancel], 0);
        Exit;
    end;
    ListView1.Clear;
    ListView2.Clear;
    ImageListThumbs.Clear;
    Tags.LoadFromBASS(Channel);
    if Tags.Loaded then begin
        //* List all tags
        ListTags;
        //* List cover arts
        ListCoverArts;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    Tags := TTags.Create;
    //* Add support for MP4 files
    BASS_PluginLoad('bass_aac.dll', BASS_UNICODE);
    //* Add support for multichannel WMA audio files
    BASS_PluginLoad('Basswma.dll', BASS_UNICODE);
    //* Add support for DSD audio files
    BASS_PluginLoad('bassdsd.dll', BASS_UNICODE);
    //* Initialize BASS
	if (HIWORD(BASS_GetVersion) <> BASSVERSION) then begin
		MessageDlg('BASS version 2.4 was not loaded!', mtError, [mbOk], 0);
		Halt;
	end;
	if not BASS_Init(-1, 44100, 0, Handle, nil) then begin
		MessageDlg('Cannot start default audio device!', mtError, [mbOk], 0);
	end;
    MessageDlg('This tutorial uses BASS for demonstration.'
        + (#13#10) + 'You need a separate license to use BASS in your application.'
        + (#13#10) + 'Available from: http://www.un4seen.com/',
        mtInformation, [mbOk], 0
    );
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    FreeAndNil(Tags);
    //* Unload BASS
    BASS_Stop;
    BASS_Free;
end;

procedure TForm1.ListTags;
var
    i: Integer;
begin
    //* List all tags
    for i := 0 to Tags.Count - 1 do begin
        with ListView1.Items.Add do begin
            Caption := Tags.Tags[i].Name;
            Subitems.Add(Tags.Tags[i].Value);
        end;
    end;
end;

procedure TForm1.ListCoverArts;
var
    i: Integer;
    ImageJPEG: TJPEGImage;
    ImagePNG: TPNGImage;
    ImageGIF: TGIFImage;
    Bitmap: TBitmap;
begin
    ListView2.Clear;
    ImageListThumbs.Clear;
    //* List cover arts
    for i := 0 to Tags.CoverArtCount - 1 do begin
        Bitmap := TBitmap.Create;
        try
            with Tags.CoverArts[i] do begin
                Stream.Seek(0, soBeginning);
                case PictureFormat of
                    tpfJPEG: begin
                        ImageJPEG := TJPEGImage.Create;
                        try
                            ImageJPEG.LoadFromStream(Stream);
                            Bitmap.Assign(ImageJPEG);
                        finally
                            FreeAndNil(ImageJPEG);
                        end;
                    end;
                    tpfPNG: begin
                        ImagePNG := TPNGImage.Create;
                        try
                            ImagePNG.LoadFromStream(Stream);
                            Bitmap.Assign(ImagePNG);
                        finally
                            FreeAndNil(ImagePNG);
                        end;
                    end;
                    tpfGIF: begin
                        ImageGIF := TGIFImage.Create;
                        try
                            ImageGIF.LoadFromStream(Stream);
                            Bitmap.Assign(ImageGIF);
                        finally
                            FreeAndNil(ImageGIF);
                        end;
                    end;
                    tpfBMP: begin
                        Bitmap.LoadFromStream(Stream);
                    end;
                end;
                //* This function resizes with nearest-neighbour mode (which is not recommended as it gives the worst quality possible),
                //* if you need a top-quality lanczos resizer which uses Graphics32, please contact me.
                ResizeBitmap(Bitmap, 160, 120, clWhite);
                with ListView2.Items.Add do begin
                    Caption := Tags.CoverArts[i].Name;
                    ImageIndex := ImageListThumbs.Add(Bitmap, nil);
                end;
            end;
        finally
            FreeAndNil(Bitmap);
        end;
    end;
end;

end.
