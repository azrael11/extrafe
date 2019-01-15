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
  function uTText_TextToPixels(vText: TText): single;
  function uTText_SetTextInGivenPixels(vLength: Integer; vText: TText) : string;

  //HyperLink Mouse events
  procedure uTText_HyperLink_OnMouseEnter(Sender: TObject);
  procedure uTText_HyperLink_OnMouseLeave(Sender: TObject);

  //Change Color events
  procedure uTText_ChangeColor_OnMouseEnter(Sender: TObject; mColor: TColor);
  procedure uTText_ChangeColor_OnMouseLeave(Sender: TObject; mColor: TColor);

  function uTText_Occurrences(const Substring, Text: string): integer;
  function uTText_Occurrences_Where(const Substring, Text: string): TStringList;

implementation
uses
  loading,
  uload,
  uLoad_AllTypes;

function uTText_Occurrences(const Substring, Text: string): integer;
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

function uTText_Occurrences_Where(const Substring, Text: string): TStringList;
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

function uTText_TextToPixels(vText: TText): single;
var
  vBitmap: TBitmap;
begin
  vBitmap:= TBitmap.Create;
  vBitmap.Canvas.Font.Assign(vText.Font);
  Result:= vBitmap.Canvas.TextWidth(vText.Text);
  vBitmap.Free;
end;

function uTText_SetTextInGivenPixels(vLength: Integer; vText: TText) : string;
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
      if uTText_TextToPixels(aText) < (vLength- 6) then
        begin
          aText.Text:= aText.Text + '...';
          Result := aText.Text;
          Break;
        end;
    end;
end;

////////////////////////////////////////////////////////////////////////////////
//HyperLink Mouse events
procedure uTText_HyperLink_OnMouseEnter(Sender: TObject);
begin
  TText(Sender).TextSettings.Font.Style:= TText(Sender).TextSettings.Font.Style+ [TFontStyle.fsUnderline];
  TText(Sender).TextSettings.FontColor:= claDeepskyblue;
  TText(Sender).Cursor:= crHandPoint;
end;

procedure uTText_HyperLink_OnMouseLeave(Sender: TObject);
begin
  TText(Sender).TextSettings.Font.Style:= TText(Sender).TextSettings.Font.Style- [TFontStyle.fsUnderline];
  if (extrafe.style.Name= 'Amakrits') or (extrafe.style.Name= 'Dark') or (extrafe.style.Name= 'Air') then
    TText(Sender).TextSettings.FontColor:= claWhite
  else
    TText(Sender).TextSettings.FontColor:= claBlack;
  TText(Sender).Cursor:= crDefault;
end;

////////////////////////////////////////////////////////////////////////////////
//Change Color events
procedure uTText_ChangeColor_OnMouseEnter(Sender: TObject; mColor: TColor);
begin
  TText(Sender).TextSettings.FontColor:= mColor;
  TText(Sender).Cursor:= crHandPoint;
end;

procedure uTText_ChangeColor_OnMouseLeave(Sender: TObject; mColor: TColor);
begin
  TText(Sender).TextSettings.FontColor:= mColor;
  TText(Sender).Cursor:= crDefault;
end;


end.
