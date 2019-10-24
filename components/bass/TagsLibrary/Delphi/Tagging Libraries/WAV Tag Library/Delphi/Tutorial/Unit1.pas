//********************************************************************************************************************************
//*                                                                                                                              *
//*     WAV Tag Library © 3delite 2014-2015                                                                                      *
//*     See WAV Tag Library Readme.txt for details                                                                               *
//*                                                                                                                              *
//* Two licenses are available for commercial usage of this component:                                                           *
//* Shareware License: €25                                                                                                       *
//*     http://www.shareit.com/product.html?productid=300625530                                                                  *
//* Commercial License: €100                                                                                                     *
//*     http://www.shareit.com/product.html?productid=300625529                                                                  *
//*                                                                                                                              *
//* Using the component in free programs is free.                                                                                *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WAVTagLibrary.html                                         *
//*                                                                                                                              *
//* This component is also available as a part of Tags Library:                                                                  *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/TagsLibrary.html                                           *
//*                                                                                                                              *
//* There is an ID3v2 Library available at:                                                                                      *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/id3v2library.html                                          *
//*                                                                                                                              *
//* and an APEv2 Library available at:                                                                                           *
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
//* a Flac Tag Library available at:                                                                                             *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/FlacTagLibrary.html                                        *
//*                                                                                                                              *
//* a WMA Tag Library available at:                                                                                              *
//*                                                                                                                              *
//*     http://www.3delite.hu/Object%20Pascal%20Developer%20Resources/WMATagLibrary.html                                         *
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
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, WAVTagLibrary, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
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
    Edit9: TEdit;
    Label9: TLabel;
    Button5: TButton;
    OpenDialogWAV: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
    Form1: TForm1;
    WAVTag: TWAVTag;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
    Close;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    if OpenDialogWAV.Execute then begin
        Edit1.Text := OpenDialogWAV.FileName;
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
    i: Integer;
    Error: Integer;
begin
    Error := WAVTag.LoadFromFile(Edit1.Text);
    if Error > WAVTAGLIBRARY_ERROR_NO_TAG_FOUND then begin
        Showmessage('Error while loading tag, error code: ' + IntToStr(Error) + #13#10
            + WAVTagErrorCode2String(Error)
        );
    end;
    {
    Info    ID	The corresponding text describes
    "iart"	The artist of the original subject of the file
    "icms"	The name of the person or organization that commissioned the original subject of the file
    "icmt"	General comments about the file or its subject
    "icop"	Copyright information about the file (e.g., "Copyright Some Company 2011")
    "icrd"	The date the subject of the file was created (creation date)
    "ieng"	The name of the engineer who worked on the file
    "ignr"	The genre of the subject
    "ikey"	A list of keywords for the file or its subject
    "imed"	Medium for the original subject of the file
    "inam"	Title of the subject of the file (name)
    "iprd"	Name of the title the subject was originally intended for
    "isbj"	Description of the contents of the file (subject)
    "isft"	Name of the software package used to create the file
    "isrc"	The name of the person or organization that supplied the original subject of the file
    "isrf"	The original form of the material that was digitized (source form)
    "itch"	The name of the technician who digitized the subject file
    IPRD = Album name
    IART = Artist name
    INAM = Track Title
    ICMT = Comment
    ICRD = Year
    IGNR = Genre
    ITRK = Track Number
    
	Wave Chunk	Description	ID3 v2.3.0	ID3 TXXX Record
	DISP	Title / Description	TIT2	 
	INFO,IART	Artist / Advertiser	TPE1	 
	INFO,IALB	Album	TALB	 
	INFO,IYER	Year	TYER	 
	INFO,ITRK	Track Number	TRCK	'TrackNum'
	INFO,ICMT	Comments	COMM []	'Comments'
	INFO,ISRF	Intro Time (in msec)	ETCO,$10	'Intro'
	INFO,IMED	Segue Time (in msec)	ETCO,$??	'Sec Tone'
	INFO,ISRC	Category	 	'Category'
	INFO,BFAD	No fade at segue (0/-1)	 	'No fade'
	INFO,IGRE	Genre	TCON	 
	INFO,IENG	Producer	 	'Producer'
	INFO,ITCH	Talent	 	'Talent'
	INFO,ICOM	Composer	TCOM	 
	INFO,IPUB	Publisher	TPUB	 
	INFO,BCPR	Copyright / Record Company	TCOP	 
	INFO,INAM	OutCue	 	'OutCue'
	INFO,ICOP	Agency	 	'Agency'
	INFO,ISFT	Account Executive / Sales person	 	'Account Exec'
	INFO,ISBJ	Copy	 	'Copy'
	INFO,IURL	URL	WXXX	'URL'
	INFO,IBPM	Music BPM	TBPM	'BPM'
	INFO,BKEY	Music Key (C, D, F#, G...)	TKEY	'Key'
	INFO,BEND	Music End (Cold, Fade, Long Fade...)	 	'End'
	INFO,BERG	Music Energy	 	'Energy'
	INFO,BTXR	Music Texture (Active, Mainstream...)	 	'Texture'
	INFO,BTPO	Music Tempo (slow, medium slow...)	 	'Tempo'
	INFO,HKST	Hook Start (in msec)	ETCO,$09	'Hook Start'
	INFO,HKEN	Hook End (in msec)	ETCO,$14	'Hook End'
	INFO,IGNR	Start Date (YYYY/MM/DD)	 	'Start Date'
	INFO,IKEY	End Date (YYYY/MM/DD)	 	'End Date'
	INFO,BSTM	Start Time (HH:MM)	 	'Start Time'
	INFO,BETM	End Time (HH:MM)	 	'End Time'
	INFO,BSTW	Time Window Start (HH:MM)	 	'Start Window'
	INFO,BETW	Time Window End (HH:MM)	 	'End Window'    
    }
    //* Use all upper-case IDs!
    Edit2.Text := WAVTag.ReadFrameByNameAsText('INAM');
    Edit3.Text := WAVTag.ReadFrameByNameAsText('IART');
    Edit4.Text := WAVTag.ReadFrameByNameAsText('IPRD');
    Edit5.Text := WAVTag.ReadFrameByNameAsText('IGNR');
    Edit6.Text := WAVTag.ReadFrameByNameAsText('ICRD');
    Edit7.Text := WAVTag.ReadFrameByNameAsText('ITRK');
    Edit9.Text := WAVTag.ReadFrameByNameAsText('ICMT');
    //* List all chunks found
    Memo1.Clear;
    for i := 0 to WAVTag.Count - 1 do begin
        Memo1.Lines.Add(WAVTag.Frames[i].Name + ' = ' + WAVTag.Frames[i].GetAsText);
    end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
    Error: Integer;
begin
    WAVTag.SetTextFrameText('INAM', Edit2.Text);
    WAVTag.SetTextFrameText('IART', Edit3.Text);
    WAVTag.SetTextFrameText('IPRD', Edit4.Text);
    WAVTag.SetTextFrameText('IGNR', Edit5.Text);
    WAVTag.SetTextFrameText('ICRD', Edit6.Text);
    WAVTag.SetTextFrameText('ITRK', Edit7.Text);
    WAVTag.SetTextFrameText('ICMT', Edit9.Text);
    Error := WAVTag.SaveToFile(Edit1.Text);
    if Error <> WAVTAGLIBRARY_SUCCESS then begin
        Showmessage('Error while saving tag, error code: ' + IntToStr(Error) + #13#10
            + WAVTagErrorCode2String(Error)
        );
    end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
    Error: Integer;
begin
    Error := RemoveWAVTagFromFile(Edit1.Text);
    if Error <> WAVTAGLIBRARY_SUCCESS then begin
        Showmessage('Error while removing tag, error code: ' + IntToStr(Error) + #13#10
            + WAVTagErrorCode2String(Error)
        );
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    WAVTag := TWAVTag.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    FreeAndNil(WAVTag);
end;

end.
