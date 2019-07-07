unit uSnippets;

interface
uses
  System.Classes,
  System.SysUtils,
  FMX.Controls;

// Free a control with all childs exept exeptions
procedure FreeAllChilds(vControl: TControl; vRemoveParent: Boolean);
function FreeChilds_Should_I(vChild: TControl): Boolean;

// Delete an element from a dynamic or static array
//procedure Array_Delete_Element(var vArray; vIndex: Cardinal);
//procedure Array_Insert_Element(var vArray; vIndex: Cardinal);

implementation


//
function FreeChilds_Should_I(vChild: TControl): Boolean;
begin
  //Here i must write some code for exeptions and other stuff
  Result:= True;
end;

procedure FreeAllChilds(vControl: TControl; vRemoveParent: Boolean);
var
  i : integer;
  Item : TControl;
begin

  if Assigned(vControl) then
  begin
    for i := (vControl.ControlsCount - 1) downto 0 do
    begin
      Item := vControl.controls[i];
      if assigned(item) then
        FreeAllChilds(item, FreeChilds_Should_I(item));
    end;

    if vRemoveParent then
      FreeAndNil(vControl);
  end;
end;
//

//procedure Array_Delete_Element(var vArray; vIndex: Cardinal);
//var
//  ALength: Cardinal;
//  TailElements: Cardinal;
//  vi: Integer;
//begin
//  ALength := Length(vArray);
//  Assert(ALength > 0);
//  Assert(vIndex < ALength);
//  for vi := vIndex + 1 to ALength - 1 do
//    vArray[vi - 1] := vArray[vi];
//  SetLength(vArray, ALength - 1);
//end;

//procedure InsertX(var A: TXArray; const Index: Cardinal; const Value: X);
//var
//  ALength: Cardinal;
//  TailElements: Cardinal;
//begin
//  ALength := Length(A);
//  Assert(Index <= ALength);
//  SetLength(A, ALength + 1);
//  Finalize(A[ALength]);
//  TailElements := ALength - Index;
//  if TailElements > 0 then begin
//    Move(A[Index], A[Index + 1], SizeOf(X) * TailElements);
//  Initialize(A[Index]);
//  A[Index] := Value;
//end;

end.
