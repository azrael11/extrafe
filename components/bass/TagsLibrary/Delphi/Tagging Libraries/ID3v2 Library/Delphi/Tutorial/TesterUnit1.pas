//********************************************************************************************************************************
//*                                                                                                                              *
//*     ID3v2 Library 2.0 © 3delite 2010-2015                                                                                    *
//*     See ID3v2 Library 2.0 ReadMe.txt for details                                                                             *
//*                                                                                                                              *
//* Two licenses are available for commercial usage of this component:                                                           *
//* Shareware License: €50                                                                                                       *
//* Commercial License: €250                                                                                                     *
//*                                                                                                                              *
//*     http://www.shareit.com/product.html?productid=300294127                                                                  *
//*                                                                                                                              *
//* Using the component in free programs is free.                                                                                *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html                                          *
//*                                                                                                                              *
//* This component is also available as a part of Tags Library:                                                                  *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/TagsLibrary.html                                           *
//*                                                                                                                              *
//* There is an APEv2 Library available at:                                                                                      *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/APEv2Library.html                                          *
//*                                                                                                                              *
//* and an MP4 Tag Library available at:                                                                                         *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/MP4TagLibrary.html                                         *
//*                                                                                                                              *
//* and an Ogg Vorbis and Opus Tag Library available at:                                                                         *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/OpusTagLibrary.html                                        *
//*                                                                                                                              *
//* and a Flac Tag Library available at:                                                                                         *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/FlacTagLibrary.html                                        *
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

unit TesterUnit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ID3v1Library,
  ID3v2Library, Dialogs, StdCtrls, ExtCtrls, JPEG, PNGImage, ComCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button3: TButton;
    GroupBox1: TGroupBox;
    Button5: TButton;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit8: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Button6: TButton;
    GroupBox2: TGroupBox;
    OpenDialog1: TOpenDialog;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    SaveDialog1: TSaveDialog;
    Button12: TButton;
    Image1: TImage;
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox3: TGroupBox;
    Button15: TButton;
    Button16: TButton;
    Edit15: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Edit16: TEdit;
    Label22: TLabel;
    GroupBox4: TGroupBox;
    Memo3: TMemo;
    Label23: TLabel;
    Edit17: TEdit;
    Label24: TLabel;
    GroupBox5: TGroupBox;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    Label2: TLabel;
    GroupBox6: TGroupBox;
    Memo2: TMemo;
    Edit18: TEdit;
    Label26: TLabel;
    Edit19: TEdit;
    Label25: TLabel;
    Edit20: TEdit;
    ComboBoxID3v1_Genre: TComboBox;
    UpDown1: TUpDown;
    Button17: TButton;
    GroupBox7: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    GroupBox8: TGroupBox;
    Edit14: TEdit;
    Label18: TLabel;
    Edit9: TEdit;
    Label15: TLabel;
    Edit12: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    ComboBox2: TComboBox;
    Edit11: TEdit;
    Label12: TLabel;
    Label11: TLabel;
    Edit10: TEdit;
    Edit3: TEdit;
    Label10: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Button4: TButton;
    Button7: TButton;
    CheckBox4: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ClearDatav1;
    procedure ClearDatav2;
    function LoadAPIC(Index: Integer): Boolean;
    procedure SetFrameAttributes;
    procedure SetFrameCommandButtons;
  end;

var
    Form1: TForm1;
    ID3v1Tag: TID3v1Tag = nil;
    ID3v2Tag: TID3v2Tag = nil;
    CurrentAPICIndex: Integer = - 1;

implementation

{$R *.dfm}

    {
Uses
    Helper3delite;
    }

procedure TForm1.FormCreate(Sender: TObject);
begin
    //* Create both Tag classes
    ID3v1Tag := TID3v1Tag.Create;
    ID3v2Tag := TID3v2Tag.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    //* Free the class
    if ID3v1Tag <> nil
        then FreeAndNil(ID3v1Tag);
    //* Free the class
    if ID3v2Tag <> nil
        then FreeAndNil(ID3v2Tag);
end;

procedure TForm1.UpDown1Click(Sender: TObject; Button: TUDBtnType);
var
    i: Integer;
begin
    //* Calculate next APIC index and load it
    if Button = btNext then begin
        for i := 0 to ID3v2Tag.FrameCount - 1 do begin
            if IsSameFrameID(ID3v2Tag.Frames[i].ID, 'APIC') then begin
                if i > CurrentAPICIndex then begin
                    LoadAPIC(i);
                    Break;
                end;
            end;
        end;
    end;
    //* Calculate previous APIC index and load it
    if Button = btPrev then begin
        for i := ID3v2Tag.FrameCount - 1 downto 0 do begin
            if IsSameFrameID(ID3v2Tag.Frames[i].ID, 'APIC') then begin
                if i < CurrentAPICIndex then begin
                    LoadAPIC(i);
                    Break;
                end;
            end;
        end;
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
    i: Integer;
    LanguageID: TLanguageID;
    Description: String;
    RecordingDateTime: TDateTime;
    Error: Integer;
    Text: String;
begin
    //* Clear all the UI
    ClearDatav2;

    //* Load the ID3v2 Tag
    Error := ID3v2Tag.LoadFromFile(Edit1.Text);

    if Error <> ID3V2LIBRARY_SUCCESS then begin
        MessageDlg('Error loading ID3v2 tag, error code: ' + IntToStr(Error) + #13#10 + ID3v2TagErrorCode2String(Error), mtError, [mbOk], 0);
    end;

    //* Get Tag version
    if Error <> ID3V2LIBRARY_SUCCESS then begin
        Label17.Caption := IntToStr(ID3v2Tag.MajorVersion) + '.' + IntToStr(ID3v2Tag.MinorVersion);
        Exit;
    end else begin
        Label17.Caption := IntToStr(ID3v2Tag.MajorVersion) + '.' + IntToStr(ID3v2Tag.MinorVersion);
    end;

    //* Unsynchronised
    CheckBox1.Checked := ID3v2Tag.Unsynchronised;

    //* To parse the tag properly deunsynchronisation is needed if applied
    //* Note that in 'All Frames' view all frames will appear as not unsynchronised becouse of this!
    ID3v2Tag.RemoveUnsynchronisationOnAllFrames;

    //* Extended header exists in tag
    CheckBox2.Checked := ID3v2Tag.ExtendedHeader;

    //* Tag is in experimental stage
    CheckBox3.Checked := ID3v2Tag.Experimental;

    //* Extended header CRC32 exists in extended header
    if ID3v2Tag.MajorVersion = 3 then begin
        CheckBox4.Checked := ID3v2Tag.ExtendedHeader3.CRCPresent;
    end;

    //* Get Title
    Edit2.Text := ID3v2Tag.GetUnicodeText('TIT2');

    //* Get Artist
    Edit3.Text := ID3v2Tag.GetUnicodeText('TPE1');

    //* Get Album
    Edit10.Text := ID3v2Tag.GetUnicodeText('TALB');

    //* Get Year
    Edit11.Text := ID3v2Tag.GetUnicodeText('TYER');

    //* Get recording time
    RecordingDateTime := ID3v2Tag.GetTime('TDRC');
    if RecordingDateTime <> 0 then begin
        Edit9.Text := DateTimeToStr(RecordingDateTime);
    end;

    //* Get track no.
    Edit14.Text := ID3v2Tag.GetUnicodeText('TRCK');

    //* Get Genre
    ComboBox2.Text := ID3v2Tag.GetUnicodeText('TCON');
    //* If genre is specified as numeric use ID3GenreDataToString() in ID3v1Library to convert to a string

    //* Get WXXX URL (most common)
    Edit12.Text := ID3v2Tag.GetUnicodeUserDefinedURLLink('WXXX', Description);
    //* For other URLs use GetUnicodeURL()

    //* Get Comment
    Memo2.Text := ID3v2Tag.GetUnicodeComment('COMM', LanguageID, Description);
    Edit19.Text := LanguageIDToString(LanguageID);
    Edit18.Text := Description;

    ID3v2Tag.FindTXXXByDescription('COMMENT', Text);
    for i := 0 to ID3v2Tag.FrameCount - 1 do begin
        if IsSameFrameID(ID3v2Tag.Frames[i].ID, 'TXXX') then begin
            Text := ID3v2Tag.GetUnicodeUserDefinedTextInformation(i, Description);
        end;
    end;

    //* Lyrics
    Memo3.Text := ID3v2Tag.GetUnicodeLyrics('USLT', LanguageID, Description);
    Edit17.Text := LanguageIDToString(LanguageID);
    Edit20.Text := Description;

    //* Load first cover picture
    LoadAPIC(0);

    //* Get all the frame ID's
    //* See 'http://www.id3.org/id3v2.4.0-frames' for all the frame types and their description
    ComboBox1.Clear;
    for i := 0 to ID3v2Tag.FrameCount - 1 do begin
        ComboBox1.Items.Add(ConvertFrameID2String(ID3v2Tag.Frames[i].ID));
    end;
    ComboBox1.ItemIndex := 0;
    //* Display frame data
    ComboBox1Change(Self);

    for i := 0 to ID3v2Tag.FrameCount - 1 do begin
        if IsSameFrameID(ID3v2Tag.Frames[i].ID, 'PRIV') then begin
            //...
        end;
    end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
    ClearDatav1;
    ID3v1Tag.LoadFromFile(Edit1.Text);
    Edit4.Text := ID3v1Tag.Title;
    Edit5.Text := ID3v1Tag.Artist;
    Edit6.Text := ID3v1Tag.Album;
    Edit7.Text := ID3v1Tag.Year;
    Edit8.Text := ID3v1Tag.Comment;
    Edit16.Text := IntToStr(ID3v1Tag.Track);
    ComboBoxID3v1_Genre.Text := ID3v1Tag.Genre;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
    ID3v2Tag.Frames[ComboBox1.ItemIndex].RemoveUnsynchronisation;
    ComboBox1Change(Sender);
end;

procedure TForm1.Button6Click(Sender: TObject);
var
    ErrorCode: Integer;
    LanguageID: TLanguageID;
begin
    if ID3v2Tag.MajorVersion = 2 then begin
        if MessageDlg('The tag in the file is an ID3v2.2 tag, if you click ''Yes'' it will be saved as an ID3v2.3 tag. Do you want to save the tag?', mtConfirmation, [mbYes, mbCancel], 0) <> mrYes then begin
            Exit;
        end;
    end;

    //* Set Title
    ID3v2Tag.SetUnicodeText('TIT2', Edit2.Text);

    //* Set Artist
    ID3v2Tag.SetUnicodeText('TPE1', Edit3.Text);

    //* Set Album
    ID3v2Tag.SetUnicodeText('TALB', Edit10.Text);

    //* Set Year
    ID3v2Tag.SetUnicodeText('TYER', Edit11.Text);

    //* Set Genre
    ID3v2Tag.SetUnicodeText('TCON', ComboBox2.Text);

    //* Set track no.
    ID3v2Tag.SetUnicodeText('TRCK', Edit14.Text);

    //* Set WXXX URL (most common)
    ID3v2Tag.SetUnicodeUserDefinedURLLink('WXXX', Edit12.Text, 'Description');
    //* For other URLs use SetUnicodeURL()

    //* Set Comment
    if Memo2.Text <> '' then begin
        //* Language ID is 3 bytes long ANSI string
        StringToLanguageID(Edit19.Text, LanguageID);
        ID3v2Tag.SetUnicodeComment('COMM', Memo2.Text, LanguageID, Edit18.Text);
    end;

    //* Set lyrics
    if Memo3.Text <> '' then begin
        //* Language ID is 3 bytes long ANSI string we convert it here
        StringToLanguageID(Edit17.Text, LanguageID);
        ID3v2Tag.SetUnicodeLyrics('USLT', Memo3.Text, LanguageID, Edit20.Text);
    end;

    if CheckBox1.Checked then begin
        ID3v2Tag.ApplyUnsynchronisationOnAllFrames;
    end;

    //* Save the ID3v2 Tag
    ErrorCode := ID3v2Tag.SaveToFile(Edit1.Text);

    if ErrorCode <> ID3V2LIBRARY_SUCCESS then begin
        MessageDlg('Error saving ID3v2 tag, error code: ' + IntToStr(ErrorCode) + #13#10 + ID3v2TagErrorCode2String(Error), mtError, [mbOk], 0);
    end;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
    ID3v2Tag.Frames[ComboBox1.ItemIndex].ApplyUnsynchronisation;
    ComboBox1Change(Sender);
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
    if OpenDialog1.Execute
        then Edit1.Text := OpenDialog1.FileName;
end;

procedure TForm1.Button9Click(Sender: TObject);
var
    ErrorCode: Integer;
begin
    ID3v1Tag.Title := Edit4.Text;
    ID3v1Tag.Artist := Edit5.Text;
    ID3v1Tag.Album := Edit6.Text;
    ID3v1Tag.Year := Edit7.Text;
    ID3v1Tag.Comment := Edit8.Text;
    ID3v1Tag.Track := StrToIntDef(Edit16.Text, 0);
    ID3v1Tag.Genre := ComboBoxID3v1_Genre.Text;
    ErrorCode := ID3v1Tag.SaveToFile(Edit1.Text);
    if ErrorCode <> ID3V1LIBRARY_SUCCESS then begin
        Showmessage('Error saving ID3v1 tag, error code: ' + IntToStr(ErrorCode));
    end;
end;

procedure TForm1.Button10Click(Sender: TObject);
var
    Fext: String;
    MIMEType: String;
    FrameIndex: Integer;
    Description: String;
    PictureType: Integer;
begin
    if OpenDialog1.Execute then begin
        //* Decide MIME type according to file extension
        Fext := UpperCase(ExtractFileExt(OpenDialog1.FileName));
        if (Fext = '.JPG')
        OR (Fext = '.JPEG')
        then begin
            MIMEType := 'image/jpeg';
        end;
        if (Fext = '.PNG')
        then begin
            MIMEType := 'image/png';
        end;
        if (Fext = '.BMP')
        then begin
            MIMEType := 'image/bmp';
        end;
        if (Fext = '.GIF')
        then begin
            MIMEType := 'image/gif';
        end;
        //* Image's short description
        Description := Edit15.Text;
        //* Image's type, here front cover ($03), see http://www.id3.org/id3v2.4.0-frames (APIC) on all the image types
        PictureType := $03;
        //* Create a new APIC frame
        FrameIndex := ID3v2Tag.AddFrame('APIC');
        //* Set it's data
        ID3v2Tag.SetUnicodeCoverPictureFromFile(FrameIndex, Description, OpenDialog1.FileName, MIMEType, PictureType);
    end;
end;

procedure TForm1.Button11Click(Sender: TObject);
var
    PictureType: Integer;
    PictureStream: TStream;
    Success: Boolean;
    MIMEType: String;
    Description: String;
    FileName: String;
begin
    if SaveDialog1.Execute then begin
        FileName := SaveDialog1.FileName;
        PictureStream := TMemoryStream.Create;
        try
            Success := ID3v2Tag.GetUnicodeCoverPictureStream(ID3v2Tag.FrameExists('APIC'), PictureStream, MIMEType, Description, PictureType);
            if NOT Success then begin
                Exit;
            end;
            //* Set file format
            if MIMEType = 'image/jpeg' then begin
                FileName := ChangeFileExt(FileName, '.jpg');
            end;
            if MIMEType = 'image/png' then begin
                FileName := ChangeFileExt(FileName, '.png');
            end;
            if MIMEType = 'image/gif' then begin
                FileName := ChangeFileExt(FileName, '.gif');
            end;
            if MIMEType = 'image/bmp' then begin
                FileName := ChangeFileExt(FileName, '.bmp');
            end;
            //* Save the stream to file
            TMemoryStream(PictureStream).SaveToFile(FileName);
        finally
            PictureStream.Free;
        end;
    end;
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
    LoadAPIC(0);
end;

function TForm1.LoadAPIC(Index: Integer): Boolean;
var
    PictureType: Integer;
    PictureStream: TStream;
    JPEGPicture: TJPEGImage;
    PNGPicture: TPNGImage;
    Success: Boolean;
    MIMEType: String;
    Description: String;
    i: Integer;
begin
    Result := False;
    try
        PictureStream := TMemoryStream.Create;
        try
            if Index = 0 then begin
                Index := ID3v2Tag.FrameExists('APIC');
            end;
            if Index < 0 then begin
                Exit;
            end;

            Success := ID3v2Tag.GetUnicodeCoverPictureStream(Index, PictureStream, MIMEType, Description, PictureType);
            //* No APIC pitcure found, exit
            if (PictureStream.Size = 0)
            OR (NOT Success)
            then begin
                Exit;
            end;

            //* Get first APIC index
            if Index = 0 then begin
                for i := 0 to ID3v2Tag.FrameCount - 1 do begin
                    if IsSameFrameID(ID3v2Tag.Frames[i].ID, 'APIC') then begin
                        CurrentAPICIndex := i;
                        Break;
                    end;
                end;
            //* Store the current APIC index as Index is frame index
            end else begin
                CurrentAPICIndex := Index;
            end;

            //* Display description
            Edit15.Text := Description;
            //* Display type
            Label21.Caption := APICType2Str(PictureType);
            //* Do what you want with PictureStream here
            //* We load the APIC picture into a TPicture
            PictureStream.Seek(0, soFromBeginning);
            MIMEType := LowerCase(MIMEType);
            //* If JPG
            if (MIMEType = 'image/jpeg')
            OR (MIMEType = 'image/jpg')
            then begin
                JPEGPicture := TJPEGImage.Create;
                JPEGPicture.LoadFromStream(PictureStream);
                JPEGPicture.DIBNeeded;
                Image1.Picture.Assign(JPEGPicture);
                JPEGPicture.Free;
            end;
            //* If PNG
            if MIMEType = 'image/png' then begin
                PNGPicture := TPNGImage.Create;
                PNGPicture.LoadFromStream(PictureStream);
                Image1.Picture.Assign(PNGPicture);
                PNGPicture.Free;
            end;            //* If BMP
            if MIMEType = 'image/bmp' then begin
                PictureStream.Seek(0, soFromBeginning);
                Image1.Picture.Bitmap.LoadFromStream(PictureStream);
            end;
            //* To load other formats a third party component is needed, for example GraphicEx or Free Image Library
            Result := True;
        finally
            PictureStream.Free;
        end;
    except
        //*
    end;
end;

procedure TForm1.Button15Click(Sender: TObject);
var
    Error: Integer;
begin
    Error := RemoveID3v1TagFromFile(Edit1.Text);
    if Error <> ID3V1LIBRARY_SUCCESS then begin
        MessageDlg('Error while removing ID3v1 tag, error code: ' + IntToStr(Error), mtError, [mbOk], 0);
        Exit;
    end;
    ID3v1Tag.Clear;
    ClearDatav1;
end;

procedure TForm1.Button16Click(Sender: TObject);
var
    Error: Integer;
begin
    Error := RemoveID3v2TagFromFile(Edit1.Text);
    if Error <> ID3V2LIBRARY_SUCCESS then begin
        MessageDlg('Error while removing ID3v2 tag, error code: ' + IntToStr(Error) + #13#10 + ID3v2TagErrorCode2String(Error), mtError, [mbOk], 0);
        Exit;
    end;
    ID3v2Tag.Clear;
    ClearDatav2;
end;

procedure TForm1.Button17Click(Sender: TObject);
var
    Success: Boolean;
begin
    Success := ID3v2Tag.DeleteFrame(CurrentAPICIndex);
    Showmessage(BoolToStr(Success, True));
    UpDown1Click(nil, btPrev);
end;

procedure TForm1.Button18Click(Sender: TObject);
var
    LangId: TLanguageID;
begin
    //* Set Title
    ID3v2Tag.SetUnicodeText('TIT2', Edit2.Text);

    //* Set Artist
    ID3v2Tag.SetUnicodeText('TPE1', Edit3.Text);

    //* Set Album
    ID3v2Tag.SetUnicodeText('TALB', Edit10.Text);

    //* Set Year
    ID3v2Tag.SetUnicodeText('TYER', Edit11.Text);

    //* Set Genre
    ID3v2Tag.SetUnicodeText('TCON', ComboBox2.Text);

    //* Set track no.
    ID3v2Tag.SetUnicodeText('TRCK', Edit14.Text);

    //* Set URL
    //AnsiStr := Edit12.Text;
    //ID3v2_SetWXXX(ID3v2Tag, PANSIChar(AnsiStr));

    //* Set Comment
    if Memo2.Text <> '' then begin
        //* Language ID is 3 bytes long ANSI string (lower case)
        StringToLanguageID(Edit19.Text, LangId);
        ID3v2Tag.SetUnicodeComment('COMM', Memo2.Text, LangId, Edit18.Text);
    end;

    //* Set lyrics
    if Memo3.Text <> '' then begin
        //* Language ID is 3 bytes long ANSI string (lower case)
        StringToLanguageID(Edit17.Text, LangId);
        ID3v2Tag.SetUnicodeLyrics('USLT', Memo3.Text, LangId, Edit20.Text);
    end;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    ID3v2Tag.Frames[ComboBox1.ItemIndex].DeCompress;
    ComboBox1Change(Sender);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    ID3v2Tag.Frames[ComboBox1.ItemIndex].Compress;
    ComboBox1Change(Sender);
end;

procedure TForm1.ClearDatav1;
begin
    //* ID3v1
    Edit4.Text := '';
    Edit5.Text := '';
    Edit6.Text := '';
    Edit7.Text := '';
    Edit8.Text := '';
    ComboBoxID3v1_Genre.Text := '';
    Edit16.Text := '';
end;

procedure TForm1.ClearDatav2;
begin
    //* ID3v2
    Edit2.Text := '';
    Edit3.Text := '';
    Edit10.Text := '';
    Edit11.Text := '';
    Edit14.Text := '';
    ComboBox2.Text := '';
    Edit12.Text := '';
    Edit17.Text := '';
    Edit20.Text := '';
    Memo3.Clear;
    Memo2.Clear;
    Edit19.Text := '';
    Edit18.Text := '';
    Edit15.Text := '';
    Memo1.Clear;
    Image1.Picture := nil;
    CurrentAPICIndex := -1;
    Edit9.Text := '';
    Label30.Caption := 'Unknown';
    Label28.Caption := 'Unknown';
    Label31.Caption := 'Unknown';
    Label33.Caption := 'Unknown';
    Label35.Caption := 'Unknown';
    Label37.Caption := 'Unknown';
    Label39.Caption := 'Unknown';
    Label41.Caption := 'Unknown';
    Label43.Caption := 'Unknown';
    Label17.Caption := 'Unknown';
    ComboBox1.Items.Clear;
    CheckBox1.Checked := False;
    CheckBox2.Checked := False;
    CheckBox3.Checked := False;
    CheckBox4.Checked := False;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
type
    StreamPointer = array of Byte;
var
    tempString, asciiString, rowNo : String;
    Count, Remainder, LineCount, DataSize: cardinal;
    tempByte: Byte;
begin
    if ComboBox1.ItemIndex = - 1 then begin
        Exit;
    end;
    Screen.Cursor := crAppStart;
    Memo1.Clear;
    SetFrameAttributes;
    SetFrameCommandButtons;
    DataSize := ID3v2Tag.Frames[ComboBox1.ItemIndex].Stream.Size;
    Count := 0;
    ID3v2Tag.Frames[ComboBox1.ItemIndex].Stream.Seek(0, soBeginning);
    Memo1.Lines.BeginUpdate;
    //* Function to display frame data as hex and string
    while Count < DataSize do begin
        tempString := '';
        asciiString := '';
        if DataSize - Count >= 16
            then Remainder := 16
            else Remainder := DataSize - Count;
        for LineCount := 0 to Remainder - 1 do begin
            ID3v2Tag.Frames[ComboBox1.ItemIndex].Stream.Read(tempByte, 1);
            tempString := tempString + inttohex(tempByte, 2) + ' ';
            if (tempByte > 31)
            and (tempByte < 255)
                then asciiString := asciiString + chr(tempByte)
                else asciiString := asciiString + chr(95);
        end;
        LineCount := Remainder - 1;
        while LineCount < 15 do begin
            tempString := tempString + '   ';
            Inc(LineCount);
        end;
        rowNo := IntToStr(Count);
        case Length(rowNo) of
            1: rowNo := '000000' + rowNo;
            2: rowNo := '00000' + rowNo;
            3: rowNo := '0000' + rowNo;
            4: rowNo := '000' + rowNo;
            5: rowNo := '00' + rowNo;
            6: rowNo := '0' + rowNo;
        end;
        rowNo := rowNo + ': ';
        Memo1.Lines.Append(rowNo + tempString + ' ' + asciiString);
        Inc(Count, Remainder);
    end;
    Memo1.Lines.EndUpdate;
    Screen.Cursor := crDefault;
end;

procedure TForm1.SetFrameAttributes;
begin
    Label30.Caption := IntToStr(ID3v2Tag.Frames[ComboBox1.ItemIndex].Stream.Size);
    Label28.Caption := BoolToStr(ID3v2Tag.Frames[ComboBox1.ItemIndex].TagAlterPreservation, True);
    Label31.Caption := BoolToStr(ID3v2Tag.Frames[ComboBox1.ItemIndex].FileAlterPreservation, True);
    Label33.Caption := BoolToStr(ID3v2Tag.Frames[ComboBox1.ItemIndex].ReadOnly, True);
    Label35.Caption := BoolToStr(ID3v2Tag.Frames[ComboBox1.ItemIndex].GroupingIdentity, True);
    Label37.Caption := BoolToStr(ID3v2Tag.Frames[ComboBox1.ItemIndex].Compressed, True);
    Label39.Caption := BoolToStr(ID3v2Tag.Frames[ComboBox1.ItemIndex].Encrypted, True);
    Label41.Caption := BoolToStr(ID3v2Tag.Frames[ComboBox1.ItemIndex].Unsynchronised, True);
    Label43.Caption := BoolToStr(ID3v2Tag.Frames[ComboBox1.ItemIndex].DataLengthIndicator, True);
end;

procedure TForm1.SetFrameCommandButtons;
begin
    if ID3v2Tag.Frames[ComboBox1.ItemIndex].Compressed then begin
        Button2.Enabled := False;
        Button1.Enabled := True;
    end else begin
        Button2.Enabled := True;
        Button1.Enabled := False;
    end;
    if ID3v2Tag.Frames[ComboBox1.ItemIndex].Unsynchronised then begin
        Button7.Enabled := False;
        Button4.Enabled := True;
    end else begin
        Button7.Enabled := True;
        Button4.Enabled := False;
    end;
end;

end.
