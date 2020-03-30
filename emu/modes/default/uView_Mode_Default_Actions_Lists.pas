unit uView_Mode_Default_Actions_Lists;

interface

uses
  System.Classes,
  System.UiTypes,
  System.SysUtils,
  FMX.Types,
  FMX.Layouts,
  FMX.Objects,
  FMX.Effects,
  FMX.Graphics,
  FMX.StdCtrls;

procedure Load;
procedure Free;

procedure Create_Lists;
procedure Create_Callout(vNum, vLine: Integer);

procedure Select_List(vList_Num: Integer);

var
  vLists: array of array of string;

implementation

uses
  uDB,
  uDB_AUser,
  uSnippet_Text,
  uLoad_AllTypes,
  uView_Mode_Default_Actions,
  uView_Mode_Default_Mouse,
  uView_Mode_Default_AllTypes;

procedure Load;
begin

  Emu_VM_Default.Gamelist.lists.Window.Panel := TLayout.Create(Emu_VM_Default.main);
  Emu_VM_Default.Gamelist.lists.Window.Panel.Name := 'Emu_Lists';
  Emu_VM_Default.Gamelist.lists.Window.Panel.Parent := Emu_VM_Default.main;
  Emu_VM_Default.Gamelist.lists.Window.Panel.SetBounds(extrafe.res.Half_Width - 500, 250, 1000, 700);
  Emu_VM_Default.Gamelist.lists.Window.Panel.Visible := True;

  Emu_VM_Default.Gamelist.lists.Window.Back := TImage.Create(Emu_VM_Default.Gamelist.lists.Window.Panel);
  Emu_VM_Default.Gamelist.lists.Window.Back.Name := 'Emu_Lists_Back';
  Emu_VM_Default.Gamelist.lists.Window.Back.Parent := Emu_VM_Default.Gamelist.lists.Window.Panel;
  Emu_VM_Default.Gamelist.lists.Window.Back.Align := TAlignLayout.Client;
  Emu_VM_Default.Gamelist.lists.Window.Back.Bitmap.LoadFromFile(Emu_XML.Images_Path + 'lists_back.png');
  Emu_VM_Default.Gamelist.lists.Window.Back.Visible := True;

  Emu_VM_Default.Gamelist.lists.Window.Add := TText.Create(Emu_VM_Default.Gamelist.lists.Window.Back);
  Emu_VM_Default.Gamelist.lists.Window.Add.Name := 'Emu_Lists_Add';
  Emu_VM_Default.Gamelist.lists.Window.Add.Parent := Emu_VM_Default.Gamelist.lists.Window.Back;
  Emu_VM_Default.Gamelist.lists.Window.Add.SetBounds(Emu_VM_Default.Gamelist.lists.Window.Back.Width - 70, -140, 60, 60);
  Emu_VM_Default.Gamelist.lists.Window.Add.Font.Family := 'IcoMoon-Free';
  Emu_VM_Default.Gamelist.lists.Window.Add.Font.Size := 48;
  Emu_VM_Default.Gamelist.lists.Window.Add.Text := #$ea0a;
  Emu_VM_Default.Gamelist.lists.Window.Add.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  Emu_VM_Default.Gamelist.lists.Window.Add.OnClick := Emu_VM_Default_Mouse.Text.OnMouseClick;
  Emu_VM_Default.Gamelist.lists.Window.Add.OnMouseEnter := Emu_VM_Default_Mouse.Text.OnMouseEnter;
  Emu_VM_Default.Gamelist.lists.Window.Add.OnDragLeave := Emu_VM_Default_Mouse.Text.OnMouseLeave;
  Emu_VM_Default.Gamelist.lists.Window.Add.Visible := True;

  Emu_VM_Default.Gamelist.lists.Window.Add_Glow := TGlowEffect.Create(Emu_VM_Default.Gamelist.lists.Window.Add);
  Emu_VM_Default.Gamelist.lists.Window.Add_Glow.Name := 'Emu_Lists_Add_Glow';
  Emu_VM_Default.Gamelist.lists.Window.Add_Glow.Parent := Emu_VM_Default.Gamelist.lists.Window.Add;
  Emu_VM_Default.Gamelist.lists.Window.Add_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  Emu_VM_Default.Gamelist.lists.Window.Add_Glow.Softness := 0.9;
  Emu_VM_Default.Gamelist.lists.Window.Add_Glow.Enabled := False;

  Create_Lists;
end;

procedure Free;
begin
  FreeAndNil(Emu_VM_Default.Gamelist.lists.Window.Back);
  FreeAndNil(Emu_VM_Default.Gamelist.lists.Window.Panel);
end;

procedure Create_Lists;
var
  vi, vk: Integer;
begin
  SetLength(Emu_VM_Default.Gamelist.lists.Window.list, Emu_XML.lists.num.ToInteger + 1);
  SetLength(Emu_VM_Default.Gamelist.lists.Window.call, Emu_XML.lists.num.ToInteger + 1);

  vk := 0;
  for vi := 0 to Emu_XML.lists.num.ToInteger do
  begin
    uDB.Arcade_Query.Close;
    uDB.Arcade_Query.SQL.Clear;
    uDB.Arcade_Query.SQL.Text := 'SELECT COUNT("' + Emu_XML.lists.list[vi].Name + '") FROM mame_list';
    uDB.Arcade_Query.Open;

    SetLength(vLists, vi + 1, uDB.Arcade_Query.Fields[0].AsInteger + 1);

    uDB.Arcade_Query.Close;
    uDB.Arcade_Query.SQL.Clear;
    uDB.Arcade_Query.SQL.Text := 'SELECT "' + Emu_XML.lists.list[vi].Name + '" FROM mame_list';
    uDB.Arcade_Query.DisableControls;
    uDB.Arcade_Query.Open;
    uDB.Arcade_Query.First;

    while not uDB.Arcade_Query.Eof do
    begin
      vLists[vi, vk] := uDB.Arcade_Query.FieldByName('' + Emu_XML.lists.list[vi].Name + '').AsString;

      Inc(vk, 1);
      uDB.Arcade_Query.Next;
    end;

    uDB.Arcade_Query.EnableControls;

    Emu_VM_Default.Gamelist.lists.Window.list[vi].item := TImage.Create(Emu_VM_Default.Gamelist.lists.Window.Back);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item.Name := 'Lists_List_' + vi.ToString;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item.Parent := Emu_VM_Default.Gamelist.lists.Window.Back;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item.SetBounds(50, -130, 200, 150);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item.Bitmap.LoadFromFile(Emu_XML.Images_Path + Emu_XML.lists.path + '\list.png');
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item.WrapMode := TImageWrapMode.Fit;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item.Visible := True;

    Emu_VM_Default.Gamelist.lists.Window.list[vi].item_glow := TGlowEffect.Create(Emu_VM_Default.Gamelist.lists.Window.list[vi].item);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item_glow.Name := 'Lists_List_Glow_' + vi.ToString;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item_glow.Parent := Emu_VM_Default.Gamelist.lists.Window.list[vi].item;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item_glow.GlowColor := TAlphaColorRec.Yellow;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item_glow.Softness := 0.9;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item_glow.Enabled := False;

    Emu_VM_Default.Gamelist.lists.Window.list[vi].item_ref := TReflectionEffect.Create(Emu_VM_Default.Gamelist.lists.Window.list[vi].item);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item_ref.Name := 'Lists_List_Reflaction_' + vi.ToString;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item_ref.Parent := Emu_VM_Default.Gamelist.lists.Window.list[vi].item;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item_ref.Opacity := 0.5;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item_ref.Offset := -14;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item_ref.Enabled := True;

    Emu_VM_Default.Gamelist.lists.Window.list[vi].image := TImage.Create(Emu_VM_Default.Gamelist.lists.Window.list[vi].item);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].image.Name := 'Lists_list_Image_' + vi.ToString;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].image.Parent := Emu_VM_Default.Gamelist.lists.Window.list[vi].item;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].image.Bitmap.LoadFromFile(Emu_XML.Images_Path + Emu_XML.lists.path + '\' + Emu_XML.lists.list[vi].path + '\' +
      Emu_XML.lists.list[vi].logo);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].image.SetBounds(26, 26, 148, 70);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].image.WrapMode := TImageWrapMode.Fit;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].image.Visible := True;

    Emu_VM_Default.Gamelist.lists.Window.list[vi].Text := TText.Create(Emu_VM_Default.Gamelist.lists.Window.list[vi].item);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Text.Name := 'Lists_list_Text_' + vi.ToString;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Text.Parent := Emu_VM_Default.Gamelist.lists.Window.list[vi].item;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Text.SetBounds(26, 100, 148, 20);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Text.TextSettings.FontColor := TAlphaColorRec.White;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Text.Font.Size := 16;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Text.Text := Emu_XML.lists.list[vi].Name;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Text.Visible := True;

    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel := TPanel.Create(Emu_VM_Default.Gamelist.lists.Window.list[vi].item);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.Name := 'Lists_List_Item_Overlay_' + vi.ToString;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.Parent := Emu_VM_Default.Gamelist.lists.Window.list[vi].item;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.Align := TAlignLayout.Client;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.Opacity := 0.001;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.Tag := vi;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.TagString := vi.ToString;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.OnClick := Emu_VM_Default_Mouse.Panel.OnMouseClick;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.OnMouseEnter := Emu_VM_Default_Mouse.Panel.OnMouseEnter;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.OnMouseLeave := Emu_VM_Default_Mouse.Panel.OnMouseLeave;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.Visible := True;

  end;
end;

procedure Create_Callout(vNum, vLine: Integer);
var
  vi, vCount: Integer;
begin
  if Assigned(Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel) then
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel.Visible := True
  else
  begin
    vCount := High(vLists[vNum]);
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel := TCalloutPanel.Create(Emu_VM_Default.Gamelist.lists.Window.list[vNum].item);
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel.Name := 'Lists_List_Item_Call_' + vNum.ToString;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel.Parent := Emu_VM_Default.Gamelist.lists.Window.list[vNum].item;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel.SetBounds(Emu_VM_Default.Gamelist.lists.Window.list[vNum].item.Position.X +
      Emu_VM_Default.Gamelist.lists.Window.list[vNum].item.Width - 54, 0, 250, 300);
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel.CalloutPosition := TCalloutPosition.Left;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel.CalloutOffset := 10;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel.Visible := True;

    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Pcb := TImage.Create(Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel);
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Pcb.Name := 'Lists_List_Item_Call_Pcb_' + vNum.ToString;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Pcb.Parent := Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Pcb.SetBounds(30, 5, 80, 80);
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Pcb.WrapMode := TImageWrapMode.Fit;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Pcb.Bitmap.LoadFromFile(Emu_XML.Images_Path + Emu_XML.lists.path + '\' + Emu_XML.lists.list[vNum].path + '\'
      + Emu_XML.lists.list[vNum].Pcb);
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Pcb.Visible := True;

    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Count := TText.Create(Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel);
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Count.Name := 'Lists_List_Item_Call_Count_' + vNum.ToString;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Count.Parent := Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Count.SetBounds(100, 10, 150, 20);
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Count.Font.Size := 16;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Count.TextSettings.FontColor := TAlphaColorRec.White;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Count.Text := 'Games Count :';
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Count.Visible := True;

    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Count_Value := TText.Create(Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel);
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Count_Value.Name := 'Lists_List_Item_Call_Count_Value_' + vNum.ToString;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Count_Value.Parent := Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Count_Value.SetBounds(100, 30, 150, 20);
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Count_Value.Font.Size := 16;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Count_Value.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Count_Value.Text := vCount.ToString;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Count_Value.Visible := True;

    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Text := TText.Create(Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel);
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Text.Name := 'Lists_List_Item_Call_Text_' + vNum.ToString;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Text.Parent := Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Text.SetBounds(10, 85, Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel.Width - 20, 20);
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Text.Font.Size := 16;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Text.TextSettings.FontColor := TAlphaColorRec.White;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Text.Text := 'Games Like :';
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Text.Visible := True;

    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Black := TRectangle.Create(Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel);
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Black.Name := 'Lists_List_Item_Call_Black_' + vNum.ToString;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Black.Parent := Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Black.SetBounds(21, 110, Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel.Width - 31,
      Emu_VM_Default.Gamelist.lists.Window.call[vNum].Panel.Height - 120);
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Black.Fill.Kind := TBrushKind.Solid;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Black.Fill.Color := TAlphaColorRec.Black;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Black.Stroke.Thickness := 0;
    Emu_VM_Default.Gamelist.lists.Window.call[vNum].Black.Visible := True;

    for vi := 0 to 9 do
    begin
      uDB.Arcade_Query.Close;
      uDB.Arcade_Query.SQL.Clear;
      uDB.Arcade_Query.SQL.Text := 'SELECT gamename FROM games WHERE romname="' + vLists[vNum, vi] + '"';
      uDB.Arcade_Query.Open;

      if vi <= vCount - 1 then
      begin
        Emu_VM_Default.Gamelist.lists.Window.call[vNum].Lines[vi] := TText.Create(Emu_VM_Default.Gamelist.lists.Window.call[vNum].Black);
        Emu_VM_Default.Gamelist.lists.Window.call[vNum].Lines[vi].Name := 'Lists_List_Item_' + vNum.ToString + '_Line_' + vi.ToString;
        Emu_VM_Default.Gamelist.lists.Window.call[vNum].Lines[vi].Parent := Emu_VM_Default.Gamelist.lists.Window.call[vNum].Black;
        Emu_VM_Default.Gamelist.lists.Window.call[vNum].Lines[vi].SetBounds(4, 4 + (vi * 18),
          Emu_VM_Default.Gamelist.lists.Window.call[vNum].Black.Width - 8, 16);
        Emu_VM_Default.Gamelist.lists.Window.call[vNum].Lines[vi].Font.Size := 12;
        Emu_VM_Default.Gamelist.lists.Window.call[vNum].Lines[vi].TextSettings.FontColor := TAlphaColorRec.White;
        if (vi < vCount - 1) and (vi = 9) then
          Emu_VM_Default.Gamelist.lists.Window.call[vNum].Lines[vi].Text := '...'
        else
        begin
          Emu_VM_Default.Gamelist.lists.Window.call[vNum].Lines[vi].Text := uDB.Arcade_Query.Fields[0].AsString;
          if uSnippet_Text.uSnippet_Text_ToPixels(Emu_VM_Default.Gamelist.lists.Window.call[vNum].Lines[vi]) > 220 then
            Emu_VM_Default.Gamelist.lists.Window.call[vNum].Lines[vi].Text := uSnippet_Text.uSnippet_Text_SetInGivenPixels(210,
              Emu_VM_Default.Gamelist.lists.Window.call[vNum].Lines[vi]) + '...';
        end;
        Emu_VM_Default.Gamelist.lists.Window.call[vNum].Lines[vi].HorzTextAlign := TTextAlign.Leading;
        Emu_VM_Default.Gamelist.lists.Window.call[vNum].Lines[vi].WordWrap := False;
        Emu_VM_Default.Gamelist.lists.Window.call[vNum].Lines[vi].Visible := True;
      end;
    end;

  end;
end;

procedure Select_List(vList_Num: Integer);
var
  vi: Integer;
  vCount: Integer;
begin
  vCount := High(vLists[vList_Num]);
  Emu_VM_Default_Var.Gamelist.Roms.Clear;
  Emu_VM_Default_Var.Gamelist.Games.Clear;
  for vi := 0 to vCount - 1 do
  begin
    Emu_VM_Default_Var.Gamelist.Roms.Add(vLists[vList_Num, vi]);

    uDB.Arcade_Query.Close;
    uDB.Arcade_Query.SQL.Clear;
    uDB.Arcade_Query.SQL.Text := 'SELECT gamename FROM games WHERE romname="' + vLists[vList_Num, vi] + '"';
    uDB.Arcade_Query.Open;

    Emu_VM_Default_Var.Gamelist.Games.Add(uDB.Arcade_Query.Fields[0].AsString);
  end;

  Emu_VM_Default_Var.Gamelist.Total_Games := vCount;
  Emu_VM_Default.Gamelist.lists.Lists_Text.Text := Emu_XML.lists.list[vList_Num].Name;
  uView_Mode_Default_Actions.Refresh;
  uView_Mode_Default_Actions.Lists_Action;
end;

end.
