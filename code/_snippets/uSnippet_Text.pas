unit uSnippet_Text;

interface
uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.UITypes,
  System.UIConsts,
  FMX.Objects,
  FMX.Graphics;


  //Counts Text string to pixels
  function uSnippet_Text_ToPixels(vText: TText): single;
  function uSnippet_Text_SetInGivenPixels(vLength: Integer; vText: TText) : string;

  //Change Color events
  procedure uSnippet_Text_ChangeColor_OnMouseEnter(Sender: TObject; mColor: TColor);
  procedure uSnippet_Text_ChangeColor_OnMouseLeave(Sender: TObject; mColor: TColor);

  function uSnippet_Text_Occurrences_Char(const Substring, Text: string): integer;
  function uSnippet_Text_Occurrences_Char_Where(const Substring, Text: string): TStringList;

implementation
uses
  loading,
  uload,
  uLoad_AllTypes;

function uSnippet_Text_Occurrences_Char(const Substring, Text: string): integer;
var
  offset: integer;
begin
  result := 0;
  offset := PosEx(Substring, Text, 1);
  while offset <> 0 do
  begin
    inc(result);
    offset := PosEx(Substring, Text, offset + length(Substring));
  end;
end;

function uSnippet_Text_Occurrences_Char_Where(const Substring, Text: string): TStringList;
var
  offset: integer;
begin
  Result:= TStringList.Create;
  offset := PosEx(Substring, Text, 1);
  Result.Add(offset.ToString);
  while offset <> 0 do
  begin
    offset := PosEx(Substring, Text, offset + length(Substring));
    Result.Add(offset.ToString);
  end;
end;

function uSnippet_Text_ToPixels(vText: TText): single;
var
  vBitmap: TBitmap;
begin
  vBitmap:= TBitmap.Create;
  vBitmap.Canvas.Font.Assign(vText.Font);
  Result:= vBitmap.Canvas.TextWidth(vText.Text);
  vBitmap.Free;
end;

function uSnippet_Text_SetInGivenPixels(vLength: Integer; vText: TText) : string;
var
  aString: String;
  aText: TText;
  i: Integer;
begin
  aText:= vText;
  aString:= vText.Text;
  for i := vLength downto 0 do
    begin
      Delete(aString,length(aString), 1);
      aText.Text:= aString;
      if uSnippet_Text_ToPixels(aText) < (vLength- 6) then
        begin
          aText.Text:= aText.Text + '...';
          Result := aText.Text;
          Break;
        end;
    end;
end;

////////////////////////////////////////////////////////////////////////////////
//Change Color events
procedure uSnippet_Text_ChangeColor_OnMouseEnter(Sender: TObject; mColor: TColor);
begin
  TText(Sender).TextSettings.FontColor:= mColor;
  TText(Sender).Cursor:= crHandPoint;
end;

procedure uSnippet_Text_ChangeColor_OnMouseLeave(Sender: TObject; mColor: TColor);
begin
  TText(Sender).TextSettings.FontColor:= mColor;
  TText(Sender).Cursor:= crDefault;
end;


end.
