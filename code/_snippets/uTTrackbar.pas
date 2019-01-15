unit uTTrackbar;

interface
uses
  System.Classes;

  function PosToValue(MinValue, MaxValue, ViewportSize, ThumbSize, TrackSize, Pos: Single; IgnoreViewportSize: boolean): Single;

implementation


function PosToValue(MinValue, MaxValue, ViewportSize, ThumbSize, TrackSize, Pos: Single; IgnoreViewportSize: boolean): Single;
var ValRel: Double;
begin
  Result := MinValue;
  if (ViewportSize < 0) or IgnoreViewportSize then
    ViewportSize := 0;
  ValRel := TrackSize - ThumbSize;
  if ValRel > 0 then
  begin
    ValRel := (Pos - ThumbSize / 2) / ValRel;
    if ValRel < 0 then
      ValRel := 0;
    if ValRel > 1 then
      ValRel := 1;
    Result := MinValue + ValRel * (MaxValue - MinValue - ViewportSize);
  end;
end;

end.
