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
//procedure Array_Delete_Element(vArray: Array of record; vIndex: Cardinal);

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

//procedure Array_Delete_Element(vArray: Array of record; vIndex: Cardinal);
//var
//  ALength: Cardinal;
//  TailElements: Cardinal;
//begin
//  ALength := Length(A);
//  Assert(ALength > 0);
//  Assert(vIndex < ALength);
//  Finalize(A[vIndex]);
//  TailElements := ALength - vIndex;
//  if TailElements > 0 then
//    Move(A[vIndex + 1], A[Index], SizeOf(X) * TailElements);
//  Initialize(A[ALength - 1]);
//  SetLength(A, ALength - 1);
//end;

end.
