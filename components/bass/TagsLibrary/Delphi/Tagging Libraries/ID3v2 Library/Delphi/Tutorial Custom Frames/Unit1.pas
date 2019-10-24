unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ID3v2Library, StdCtrls, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    GroupBox2: TGroupBox;
    Button4: TButton;
    Label2: TLabel;
    Edit2: TEdit;
    Memo1: TMemo;
    Label3: TLabel;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    GroupBox3: TGroupBox;
    ComboBox2: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit3: TEdit;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Selct(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure ComboBox2Select(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListCustomFrames;
    function GetCurrentCustomFramIndex(ItemIndex: Integer): Integer;
    procedure DisplayCustomFrame(Index: Integer);
    procedure ListRatings;
    function GetCurrentRatingFramIndex(ItemIndex: Integer): Integer;
    procedure DisplayRatingFrame(Index: Integer);
  end;

var
  Form1: TForm1;
  ID3v2: TID3v2Tag;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
    ID3v2 := TID3v2Tag.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    FreeAndNil(ID3v2);
end;

procedure TForm1.Button10Click(Sender: TObject);
var
    Index: Integer;
    AnsiEmail: AnsiString;
    Rating: Byte;
    PlayCount: Cardinal;
begin
    AnsiEmail := Edit3.Text;
    Rating := SpinEdit1.Value;
    PlayCount := SpinEdit2.Value;
    Index := ID3v2.AddFrame('POPM');
    if Index > -1 then begin
        ID3v2.SetPopularimeter(Index, AnsiEmail, Rating, PlayCount);
    end;
    ListRatings;
end;

procedure TForm1.Button11Click(Sender: TObject);
var
    Index: Integer;
    AnsiEmail: AnsiString;
    Rating: Byte;
    PlayCount: Cardinal;
begin
    AnsiEmail := Edit3.Text;
    Index := ID3v2.FindPopularimeter(AnsiEmail, Rating, PlayCount);
    if Index > - 1 then begin
        DisplayRatingFrame(Index);
    end;
end;

procedure TForm1.Button12Click(Sender: TObject);
var
    Index: Integer;
    AnsiEmail: AnsiString;
    Rating: Byte;
    PlayCount: Cardinal;
begin
    AnsiEmail := Edit3.Text;
    Index := ID3v2.FindPopularimeter(AnsiEmail, Rating, PlayCount);
    if Index > - 1 then begin
        Inc(PlayCount);
        ID3v2.SetPopularimeter(Index, AnsiEmail, Rating, PlayCount);
        SpinEdit2.Value := SpinEdit2.Value + 1;
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
    ID3v2.LoadFromFile(Edit1.Text);
    ListCustomFrames;
    ListRatings;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    ID3v2.SaveToFile(Edit1.Text);
end;

procedure TForm1.ListCustomFrames;
var
    i: Integer;
begin
    Edit2.Text := '';
    Memo1.Clear;
    ComboBox1.Clear;
    for i := 0 to ID3v2.FrameCount - 1 do begin
        if ID3v2.Frames[i].ID = 'TXXX' then begin
            ComboBox1.Items.Add(IntToStr(i) + '.) TXXX');
        end;
    end;
end;

procedure TForm1.ListRatings;
var
    i: Integer;
begin
    Edit3.Text := '';
    SpinEdit1.Value := 0;
    SpinEdit2.Value := 0;
    for i := 0 to ID3v2.FrameCount - 1 do begin
        if ID3v2.Frames[i].ID = 'POPM' then begin
            ComboBox2.Items.Add(IntToStr(i) + '.) POPM');
        end;
    end;
end;

function TForm1.GetCurrentCustomFramIndex(ItemIndex: Integer): Integer;
var
    i: Integer;
    CurentIndex: Integer;
begin
    CurentIndex := -1;
    for i := 0 to ID3v2.FrameCount - 1 do begin
        if ID3v2.Frames[i].ID = 'TXXX' then begin
            Inc(CurentIndex);
            if CurentIndex = ComboBox1.ItemIndex then begin
                Result := i;
                Break;
            end;
        end;
    end;
end;

function TForm1.GetCurrentRatingFramIndex(ItemIndex: Integer): Integer;
var
    i: Integer;
    CurentIndex: Integer;
begin
    CurentIndex := -1;
    for i := 0 to ID3v2.FrameCount - 1 do begin
        if ID3v2.Frames[i].ID = 'POPM' then begin
            Inc(CurentIndex);
            if CurentIndex = ComboBox2.ItemIndex then begin
                Result := i;
                Break;
            end;
        end;
    end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
    Index: Integer;
begin
    Index := GetCurrentCustomFramIndex(ComboBox1.ItemIndex);
    if Index > -1 then begin
        ID3v2.SetUnicodeUserDefinedTextInformation(Index, Edit2.Text, Memo1.Text);
    end;
end;

procedure TForm1.ComboBox1Selct(Sender: TObject);
var
    Index: Integer;
begin
    Index := GetCurrentCustomFramIndex(ComboBox1.ItemIndex);
    if Index > - 1 then begin
        DisplayCustomFrame(Index);
    end;
end;

procedure TForm1.ComboBox2Select(Sender: TObject);
var
    Index: Integer;
begin
    Index := GetCurrentRatingFramIndex(ComboBox2.ItemIndex);
    if Index > - 1 then begin
        DisplayRatingFrame(Index);
    end;
end;

procedure TForm1.DisplayCustomFrame(Index: Integer);
var
    Description: String;
    Text: String;
begin
    Edit2.Text := '';
    Memo1.Clear;
    Text := ID3v2.GetUnicodeUserDefinedTextInformation(Index, Description);
    Edit2.Text := Description;
    Memo1.Text := Text;
end;

procedure TForm1.DisplayRatingFrame(Index: Integer);
var
    Email: AnsiString;
    Rating: Byte;
    PlayCount: Cardinal;
begin
    Edit3.Text := '';
    SpinEdit1.Value := 0;
    SpinEdit2.Value := 0;
    if ID3v2.GetPopularimeter(Index, Email, Rating, PlayCount) then begin
        Edit3.Text := Email;
        SpinEdit1.Value := Rating;
        SpinEdit2.Value := PlayCount;
    end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
    Index: Integer;
begin
    Index := ID3v2.FindCustomFrame('TXXX', Edit2.Text);
    if Index > - 1 then begin
        DisplayCustomFrame(Index);
    end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
    Index: Integer;
begin
    Index := ID3v2.AddFrame('TXXX');
    if Index > -1 then begin
        ID3v2.SetUnicodeUserDefinedTextInformation(Index, Edit2.Text, Memo1.Text);
    end;
    ListCustomFrames;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
    Index: Integer;
begin
    Index := GetCurrentCustomFramIndex(ComboBox1.ItemIndex);
    if Index > -1 then begin
        ID3v2.DeleteFrame(Index);
    end;
    ListCustomFrames;
end;

procedure TForm1.Button8Click(Sender: TObject);
var
    Index: Integer;
    AnsiEmail: AnsiString;
    Rating: Byte;
    PlayCount: Cardinal;
begin
    Index := GetCurrentRatingFramIndex(ComboBox2.ItemIndex);
    AnsiEmail := Edit3.Text;
    Rating := SpinEdit1.Value;
    PlayCount := SpinEdit2.Value;
    if Index > -1 then begin
        ID3v2.SetPopularimeter(Index, AnsiEmail, Rating, PlayCount);
    end;
    ListRatings;
end;

procedure TForm1.Button9Click(Sender: TObject);
var
    Index: Integer;
begin
    Index := GetCurrentRatingFramIndex(ComboBox2.ItemIndex);
    if Index > -1 then begin
        ID3v2.DeleteFrame(Index);
    end;
    ListRatings;
end;

end.
