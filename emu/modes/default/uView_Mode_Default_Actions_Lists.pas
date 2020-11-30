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
  FMX.StdCtrls,
  FMX.TabControl;

procedure Load;
procedure Free;

procedure Create_Lists;
procedure Select_List(vList_Num: Integer);
procedure Clear_List;

procedure Create_Info;
procedure Show_Info(vNum, vLine: Integer);
procedure Clear_Info(vNum: Integer);

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
  Emu_VM_Default.Gamelist.lists.Window.Panel.SetBounds(uDB_AUser.Local.SETTINGS.Resolution.Half_Width - 700, 0, 1400, 850);
  Emu_VM_Default.Gamelist.lists.Window.Panel.Visible := True;

  Emu_VM_Default.Gamelist.lists.Window.List_Control := TTabControl.Create(Emu_VM_Default.Gamelist.lists.Window.Panel);
  Emu_VM_Default.Gamelist.lists.Window.List_Control.Name := 'Emu_Lists_Control';
  Emu_VM_Default.Gamelist.lists.Window.List_Control.Parent := Emu_VM_Default.Gamelist.lists.Window.Panel;
  Emu_VM_Default.Gamelist.lists.Window.List_Control.SetBounds(180, 70, 1038, 711);
  Emu_VM_Default.Gamelist.lists.Window.List_Control.TabPosition := TTabPosition.None;
  Emu_VM_Default.Gamelist.lists.Window.List_Control.Visible := True;

  Emu_VM_Default.Gamelist.lists.Window.Back := TImage.Create(Emu_VM_Default.Gamelist.lists.Window.Panel);
  Emu_VM_Default.Gamelist.lists.Window.Back.Name := 'Emu_Lists_Back';
  Emu_VM_Default.Gamelist.lists.Window.Back.Parent := Emu_VM_Default.Gamelist.lists.Window.Panel;
  Emu_VM_Default.Gamelist.lists.Window.Back.Align := TAlignLayout.Client;
  Emu_VM_Default.Gamelist.lists.Window.Back.MultiResBitmap.Items[0].Bitmap.LoadFromFile(Emu_XML.Images_Path + 'lists_back.png');
  Emu_VM_Default.Gamelist.lists.Window.Back.MultiResBitmap.TransparentColor := TAlphaColorRec.Null;
  Emu_VM_Default.Gamelist.lists.Window.Back.HitTest := False;
  Emu_VM_Default.Gamelist.lists.Window.Back.Visible := True;

  Emu_VM_Default.Gamelist.lists.Window.Selected := TText.Create(Emu_VM_Default.Gamelist.lists.Window.Back);
  Emu_VM_Default.Gamelist.lists.Window.Selected.Name := 'Emu_Lists_Selected';
  Emu_VM_Default.Gamelist.lists.Window.Selected.Parent := Emu_VM_Default.Gamelist.lists.Window.Back;
  Emu_VM_Default.Gamelist.lists.Window.Selected.SetBounds(170, 38, 30, 30);
  Emu_VM_Default.Gamelist.lists.Window.Selected.Font.Family := 'IcoMoon-Free';
  Emu_VM_Default.Gamelist.lists.Window.Selected.Font.Size := 26;
  Emu_VM_Default.Gamelist.lists.Window.Selected.Text := #$e904;
  Emu_VM_Default.Gamelist.lists.Window.Selected.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  Emu_VM_Default.Gamelist.lists.Window.Selected.Visible := True;

  Emu_VM_Default.Gamelist.lists.Window.Selected_Value := TText.Create(Emu_VM_Default.Gamelist.lists.Window.Back);
  Emu_VM_Default.Gamelist.lists.Window.Selected_Value.Name := 'Emu_Lists_Selected_Value';
  Emu_VM_Default.Gamelist.lists.Window.Selected_Value.Parent := Emu_VM_Default.Gamelist.lists.Window.Back;
  Emu_VM_Default.Gamelist.lists.Window.Selected_Value.SetBounds(210, 38, 600, 30);
  Emu_VM_Default.Gamelist.lists.Window.Selected_Value.Font.Size := 16;
  Emu_VM_Default.Gamelist.lists.Window.Selected_Value.Text := Emu_VM_Default_Var.lists.Selected;
  Emu_VM_Default.Gamelist.lists.Window.Selected_Value.TextSettings.FontColor := TAlphaColorRec.White;
  Emu_VM_Default.Gamelist.lists.Window.Selected_Value.HorzTextAlign := TTextAlign.Leading;
  Emu_VM_Default.Gamelist.lists.Window.Selected_Value.Visible := True;

  Emu_VM_Default.Gamelist.lists.Window.Remove := TText.Create(Emu_VM_Default.Gamelist.lists.Window.Back);
  Emu_VM_Default.Gamelist.lists.Window.Remove.Name := 'Emu_Lists_Remove_Selected';
  Emu_VM_Default.Gamelist.lists.Window.Remove.Parent := Emu_VM_Default.Gamelist.lists.Window.Back;
  Emu_VM_Default.Gamelist.lists.Window.Remove.SetBounds(810, 38, 200, 30);
  Emu_VM_Default.Gamelist.lists.Window.Remove.Font.Size := 16;
  Emu_VM_Default.Gamelist.lists.Window.Remove.Text := 'Remove selected list';
  Emu_VM_Default.Gamelist.lists.Window.Remove.TextSettings.FontColor := TAlphaColorRec.White;
  Emu_VM_Default.Gamelist.lists.Window.Remove.HorzTextAlign := TTextAlign.Trailing;
  Emu_VM_Default.Gamelist.lists.Window.Remove.OnClick := Emu_VM_Default_Mouse.Text.OnMouseClick;
  Emu_VM_Default.Gamelist.lists.Window.Remove.OnMouseEnter := Emu_VM_Default_Mouse.Text.OnMouseEnter;
  Emu_VM_Default.Gamelist.lists.Window.Remove.OnMouseLeave := Emu_VM_Default_Mouse.Text.OnMouseLeave;
  if Emu_VM_Default_Var.lists.Selected <> 'None' then
    Emu_VM_Default.Gamelist.lists.Window.Remove.Visible := True
  else
    Emu_VM_Default.Gamelist.lists.Window.Remove.Visible := False;

  Emu_VM_Default.Gamelist.lists.Window.Add := TText.Create(Emu_VM_Default.Gamelist.lists.Window.Back);
  Emu_VM_Default.Gamelist.lists.Window.Add.Name := 'Emu_Lists_Add';
  Emu_VM_Default.Gamelist.lists.Window.Add.Parent := Emu_VM_Default.Gamelist.lists.Window.Back;
  Emu_VM_Default.Gamelist.lists.Window.Add.SetBounds(Emu_VM_Default.Gamelist.lists.Window.Back.Width - 160, 30, 30, 30);
  Emu_VM_Default.Gamelist.lists.Window.Add.Font.Family := 'IcoMoon-Free';
  Emu_VM_Default.Gamelist.lists.Window.Add.Font.Size := 26;
  Emu_VM_Default.Gamelist.lists.Window.Add.Text := #$ea0a;
  Emu_VM_Default.Gamelist.lists.Window.Add.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  Emu_VM_Default.Gamelist.lists.Window.Add.OnClick := Emu_VM_Default_Mouse.Text.OnMouseClick;
  Emu_VM_Default.Gamelist.lists.Window.Add.OnMouseEnter := Emu_VM_Default_Mouse.Text.OnMouseEnter;
  Emu_VM_Default.Gamelist.lists.Window.Add.OnMouseLeave := Emu_VM_Default_Mouse.Text.OnMouseLeave;
  Emu_VM_Default.Gamelist.lists.Window.Add.Visible := True;

  Emu_VM_Default.Gamelist.lists.Window.Add_Glow := TGlowEffect.Create(Emu_VM_Default.Gamelist.lists.Window.Add);
  Emu_VM_Default.Gamelist.lists.Window.Add_Glow.Name := 'Emu_Lists_Add_Glow';
  Emu_VM_Default.Gamelist.lists.Window.Add_Glow.Parent := Emu_VM_Default.Gamelist.lists.Window.Add;
  Emu_VM_Default.Gamelist.lists.Window.Add_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  Emu_VM_Default.Gamelist.lists.Window.Add_Glow.Softness := 0.9;
  Emu_VM_Default.Gamelist.lists.Window.Add_Glow.Enabled := False;

  Create_Info;
  Create_Lists;
end;

procedure Free;
begin
  FreeAndNil(Emu_VM_Default.Gamelist.lists.Window.Back);
  FreeAndNil(Emu_VM_Default.Gamelist.lists.Window.Panel);
  FreeAndNil(Emu_VM_Default.Gamelist.lists.Window.Info.Back);
  FreeAndNil(Emu_VM_Default.Gamelist.lists.Window.Info.Panel);
end;

procedure Create_Info;
var
  vi: Integer;
begin
  Emu_VM_Default.Gamelist.lists.Window.Info.Panel := TLayout.Create(Emu_VM_Default.main);
  Emu_VM_Default.Gamelist.lists.Window.Info.Panel.Name := 'Emu_Lists_Info';
  Emu_VM_Default.Gamelist.lists.Window.Info.Panel.Parent := Emu_VM_Default.main;
  Emu_VM_Default.Gamelist.lists.Window.Info.Panel.SetBounds(uDB_AUser.Local.SETTINGS.Resolution.Half_Width - 700, 800, 1400, 300);
  Emu_VM_Default.Gamelist.lists.Window.Info.Panel.Visible := True;

  Emu_VM_Default.Gamelist.lists.Window.Info.Info := TPanel.Create(Emu_VM_Default.Gamelist.lists.Window.Info.Panel);
  Emu_VM_Default.Gamelist.lists.Window.Info.Info.Name := 'Emu_Lists_Info_Info';
  Emu_VM_Default.Gamelist.lists.Window.Info.Info.Parent := Emu_VM_Default.Gamelist.lists.Window.Info.Panel;
  Emu_VM_Default.Gamelist.lists.Window.Info.Info.SetBounds(356, 30, 688, 210);
  Emu_VM_Default.Gamelist.lists.Window.Info.Info.Visible := True;

  Emu_VM_Default.Gamelist.lists.Window.Info.Back := TImage.Create(Emu_VM_Default.Gamelist.lists.Window.Info.Panel);
  Emu_VM_Default.Gamelist.lists.Window.Info.Back.Name := 'Emu_Lists_Info_Back';
  Emu_VM_Default.Gamelist.lists.Window.Info.Back.Parent := Emu_VM_Default.Gamelist.lists.Window.Info.Panel;
  Emu_VM_Default.Gamelist.lists.Window.Info.Back.SetBounds(300, 10, 800, 250);
  Emu_VM_Default.Gamelist.lists.Window.Info.Back.Bitmap.LoadFromFile(Emu_XML.Images_Path + 'lists_back.png');
  Emu_VM_Default.Gamelist.lists.Window.Info.Back.WrapMode := TImageWrapMode.Stretch;
  Emu_VM_Default.Gamelist.lists.Window.Info.Back.Visible := True;

  Emu_VM_Default.Gamelist.lists.Window.Info.image := TImage.Create(Emu_VM_Default.Gamelist.lists.Window.Info.Back);
  Emu_VM_Default.Gamelist.lists.Window.Info.image.Name := 'Emu_Lists_Info_Image';
  Emu_VM_Default.Gamelist.lists.Window.Info.image.Parent := Emu_VM_Default.Gamelist.lists.Window.Info.Back;
  Emu_VM_Default.Gamelist.lists.Window.Info.image.SetBounds(80, 50, 160, 160);
  Emu_VM_Default.Gamelist.lists.Window.Info.image.WrapMode := TImageWrapMode.Fit;
  Emu_VM_Default.Gamelist.lists.Window.Info.image.Visible := True;

  Emu_VM_Default.Gamelist.lists.Window.Info.Count := TText.Create(Emu_VM_Default.Gamelist.lists.Window.Info.Back);
  Emu_VM_Default.Gamelist.lists.Window.Info.Count.Name := 'Emu_Lists_Info_Count';
  Emu_VM_Default.Gamelist.lists.Window.Info.Count.Parent := Emu_VM_Default.Gamelist.lists.Window.Info.Back;
  Emu_VM_Default.Gamelist.lists.Window.Info.Count.SetBounds(250, 80, 150, 20);
  Emu_VM_Default.Gamelist.lists.Window.Info.Count.Font.Size := 16;
  Emu_VM_Default.Gamelist.lists.Window.Info.Count.TextSettings.FontColor := TAlphaColorRec.White;
  Emu_VM_Default.Gamelist.lists.Window.Info.Count.Text := 'Games Count :';
  Emu_VM_Default.Gamelist.lists.Window.Info.Count.Visible := True;

  Emu_VM_Default.Gamelist.lists.Window.Info.Count_Value := TText.Create(Emu_VM_Default.Gamelist.lists.Window.Info.Back);
  Emu_VM_Default.Gamelist.lists.Window.Info.Count_Value.Name := 'Emu_Lists_Info_Count_Value';
  Emu_VM_Default.Gamelist.lists.Window.Info.Count_Value.Parent := Emu_VM_Default.Gamelist.lists.Window.Info.Back;
  Emu_VM_Default.Gamelist.lists.Window.Info.Count_Value.SetBounds(250, 100, 150, 20);
  Emu_VM_Default.Gamelist.lists.Window.Info.Count_Value.Font.Size := 16;
  Emu_VM_Default.Gamelist.lists.Window.Info.Count_Value.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  Emu_VM_Default.Gamelist.lists.Window.Info.Count_Value.Visible := True;

  Emu_VM_Default.Gamelist.lists.Window.Info.Text := TText.Create(Emu_VM_Default.Gamelist.lists.Window.Info.Back);
  Emu_VM_Default.Gamelist.lists.Window.Info.Text.Name := 'Emu_Lists_Info_Games_Like';
  Emu_VM_Default.Gamelist.lists.Window.Info.Text.Parent := Emu_VM_Default.Gamelist.lists.Window.Info.Back;
  Emu_VM_Default.Gamelist.lists.Window.Info.Text.SetBounds(420, 18, 310, 20);
  Emu_VM_Default.Gamelist.lists.Window.Info.Text.Font.Size := 16;
  Emu_VM_Default.Gamelist.lists.Window.Info.Text.TextSettings.FontColor := TAlphaColorRec.White;
  Emu_VM_Default.Gamelist.lists.Window.Info.Text.Text := 'Games Included :';
  Emu_VM_Default.Gamelist.lists.Window.Info.Text.Visible := True;

  Emu_VM_Default.Gamelist.lists.Window.Info.Black := TRectangle.Create(Emu_VM_Default.Gamelist.lists.Window.Info.Back);
  Emu_VM_Default.Gamelist.lists.Window.Info.Black.Name := 'Emu_Lists_Info_Black';
  Emu_VM_Default.Gamelist.lists.Window.Info.Black.Parent := Emu_VM_Default.Gamelist.lists.Window.Info.Back;
  Emu_VM_Default.Gamelist.lists.Window.Info.Black.SetBounds(420, 40, 310, 180);
  Emu_VM_Default.Gamelist.lists.Window.Info.Black.Fill.Kind := TBrushKind.Solid;
  Emu_VM_Default.Gamelist.lists.Window.Info.Black.Fill.Color := TAlphaColorRec.Black;
  Emu_VM_Default.Gamelist.lists.Window.Info.Black.Stroke.Thickness := 0;
  Emu_VM_Default.Gamelist.lists.Window.Info.Black.Visible := True;

  for vi := 0 to 9 do
  begin
    Emu_VM_Default.Gamelist.lists.Window.Info.Lines[vi] := TText.Create(Emu_VM_Default.Gamelist.lists.Window.Info.Black);
    Emu_VM_Default.Gamelist.lists.Window.Info.Lines[vi].Name := 'Emu_Lists_Info_Game_' + vi.ToString;
    Emu_VM_Default.Gamelist.lists.Window.Info.Lines[vi].Parent := Emu_VM_Default.Gamelist.lists.Window.Info.Black;
    Emu_VM_Default.Gamelist.lists.Window.Info.Lines[vi].SetBounds(4, 4 + (vi * 18), Emu_VM_Default.Gamelist.lists.Window.Info.Black.Width - 8, 16);
    Emu_VM_Default.Gamelist.lists.Window.Info.Lines[vi].Font.Size := 12;
    Emu_VM_Default.Gamelist.lists.Window.Info.Lines[vi].TextSettings.FontColor := TAlphaColorRec.White;
    Emu_VM_Default.Gamelist.lists.Window.Info.Lines[vi].Text := '';
    Emu_VM_Default.Gamelist.lists.Window.Info.Lines[vi].HorzTextAlign := TTextAlign.Leading;
    Emu_VM_Default.Gamelist.lists.Window.Info.Lines[vi].WordWrap := False;
    Emu_VM_Default.Gamelist.lists.Window.Info.Lines[vi].Visible := True;
  end;
end;

procedure Create_Lists;
var
  vi, vk: Integer;
  vCount: Integer;
  vbig_num: Integer;

  vTabItem: Integer;
  vRow_Num: Integer;
  vCol_Num: Integer;
begin

  for vi := 0 to High(Emu_XML.lists.num) div 16 do
  begin
    SetLength(Emu_VM_Default.Gamelist.lists.Window.List_Control_Item, vi + 1);
    Emu_VM_Default.Gamelist.lists.Window.List_Control_Item[vi] := TTabItem.Create(Emu_VM_Default.Gamelist.lists.Window.List_Control);
    Emu_VM_Default.Gamelist.lists.Window.List_Control_Item[vi].Name := 'Emu_Lists_TabItem_' + vi.ToString;
    Emu_VM_Default.Gamelist.lists.Window.List_Control_Item[vi].Parent := Emu_VM_Default.Gamelist.lists.Window.List_Control;
    Emu_VM_Default.Gamelist.lists.Window.List_Control_Item[vi].Visible := True;
  end;

  SetLength(Emu_VM_Default.Gamelist.lists.Window.list, Emu_XML.lists.num.ToInteger + 1);

  vTabItem := 0;
  vRow_Num := 0;
  vCol_Num := 0;
  vbig_num := 0;
  for vi := 0 to Emu_XML.lists.num.ToInteger do
  begin
    uDB.Arcade_Query.Close;
    uDB.Arcade_Query.SQL.Clear;
    uDB.Arcade_Query.SQL.Text := 'SELECT COUNT("' + Emu_XML.lists.list[vi].Name + '") FROM mame_list WHERE "' + Emu_XML.lists.list[vi].Name + '" IS NOT NULL';
    uDB.Arcade_Query.Open;

    vCount := uDB.Arcade_Query.Fields[0].AsInteger;

    if vCount > vbig_num then
      vbig_num := vCount;

    SetLength(vLists, vi + 1, vbig_num + 1);

    uDB.Arcade_Query.Close;
    uDB.Arcade_Query.SQL.Clear;
    uDB.Arcade_Query.SQL.Text := 'SELECT "' + Emu_XML.lists.list[vi].Name + '" FROM mame_list WHERE "' + Emu_XML.lists.list[vi].Name + '" IS NOT NULL';
    uDB.Arcade_Query.DisableControls;
    uDB.Arcade_Query.Open;
    uDB.Arcade_Query.First;

    vk := 0;
    while not uDB.Arcade_Query.Eof do
    begin
      vLists[vi, vk] := uDB.Arcade_Query.FieldByName('' + Emu_XML.lists.list[vi].Name + '').AsString;

      Inc(vk, 1);
      uDB.Arcade_Query.Next;
    end;

    uDB.Arcade_Query.EnableControls;

    Emu_VM_Default.Gamelist.lists.Window.list[vi].item := TImage.Create(Emu_VM_Default.Gamelist.lists.Window.List_Control_Item[vTabItem]);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item.Name := 'Lists_List_' + vi.ToString;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item.Parent := Emu_VM_Default.Gamelist.lists.Window.List_Control_Item[vTabItem];
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item.SetBounds(40 + (vCol_Num * 250), 20 + (vRow_Num * 170), 200, 150);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item.Bitmap.LoadFromFile(Emu_XML.Images_Path + Emu_XML.lists.path + '\list.png');
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item.WrapMode := TImageWrapMode.Fit;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item.Visible := True;

    Emu_VM_Default.Gamelist.lists.Window.list[vi].image := TImage.Create(Emu_VM_Default.Gamelist.lists.Window.list[vi].item);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].image.Name := 'Lists_list_Image_' + vi.ToString;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].image.Parent := Emu_VM_Default.Gamelist.lists.Window.list[vi].item;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].image.Bitmap.LoadFromFile(Emu_XML.Images_Path + Emu_XML.lists.path + '\' + Emu_XML.lists.list[vi].path + '\' +
      Emu_XML.lists.list[vi].logo);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].image.SetBounds(26, 26, 148, 70);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].image.WrapMode := TImageWrapMode.Fit;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].image.Visible := True;

    Emu_VM_Default.Gamelist.lists.Window.list[vi].item_glow := TGlowEffect.Create(Emu_VM_Default.Gamelist.lists.Window.list[vi].image);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item_glow.Name := 'Lists_List_Glow_' + vi.ToString;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item_glow.Parent := Emu_VM_Default.Gamelist.lists.Window.list[vi].image;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item_glow.GlowColor := TAlphaColorRec.Yellow;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item_glow.Softness := 0.9;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].item_glow.Enabled := False;

    Emu_VM_Default.Gamelist.lists.Window.list[vi].Text := TText.Create(Emu_VM_Default.Gamelist.lists.Window.list[vi].item);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Text.Name := 'Lists_list_Text_' + vi.ToString;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Text.Parent := Emu_VM_Default.Gamelist.lists.Window.list[vi].item;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Text.SetBounds(26, 100, 148, 20);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Text.TextSettings.FontColor := TAlphaColorRec.White;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Text.Font.Size := 16;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Text.Text := Emu_XML.lists.list[vi].Name;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Text.Visible := True;

    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel := TPanel.Create(Emu_VM_Default.Gamelist.lists.Window.List_Control_Item[vTabItem]);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.Name := 'Lists_List_Item_Overlay_' + vi.ToString;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.Parent := Emu_VM_Default.Gamelist.lists.Window.List_Control_Item[vTabItem];
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.SetBounds(40 + (vCol_Num * 250), 20 + (vRow_Num * 170), 200, 150);
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.Opacity := 0.001;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.Tag := vi;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.TagString := vi.ToString;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.OnClick := Emu_VM_Default_Mouse.Panel.OnMouseClick;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.OnMouseEnter := Emu_VM_Default_Mouse.Panel.OnMouseEnter;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.OnMouseLeave := Emu_VM_Default_Mouse.Panel.OnMouseLeave;
    Emu_VM_Default.Gamelist.lists.Window.list[vi].Panel.Visible := True;

    if vCol_Num = 3 then
    begin
      vCol_Num := 0;
      if vRow_Num = 3 then
      begin
        vRow_Num := 0;
        Inc(vTabItem);
      end
      else
        Inc(vRow_Num);
    end
    else
      Inc(vCol_Num);
  end;
end;

procedure Show_Info(vNum, vLine: Integer);
var
  vi, vCount: Integer;
begin
  Emu_VM_Default.Gamelist.lists.Window.list[vNum].item_glow.Enabled := True;
  for vi := 0 to High(vLists[vNum]) do
    if vLists[vNum, vi] = '' then
      Break;

  vCount := vi;

  Emu_VM_Default.Gamelist.lists.Window.Info.image.Bitmap.LoadFromFile(Emu_XML.Images_Path + Emu_XML.lists.path + '\' + Emu_XML.lists.list[vNum].path + '\' +
    Emu_XML.lists.list[vNum].Pcb);

  Emu_VM_Default.Gamelist.lists.Window.Info.Count_Value.Text := vCount.ToString;

  for vi := 0 to 9 do
  begin
    uDB.Arcade_Query.Close;
    uDB.Arcade_Query.SQL.Clear;
    uDB.Arcade_Query.SQL.Text := 'SELECT gamename FROM games WHERE romname="' + vLists[vNum, vi] + '"';
    uDB.Arcade_Query.Open;

    if vi <= vCount - 1 then
    begin
      if (vi < vCount - 1) and (vi = 9) then
        Emu_VM_Default.Gamelist.lists.Window.Info.Lines[vi].Text := '...'
      else
      begin
        Emu_VM_Default.Gamelist.lists.Window.Info.Lines[vi].Text := uDB.Arcade_Query.Fields[0].AsString;
        if uSnippet_Text.uSnippet_Text_ToPixels(Emu_VM_Default.Gamelist.lists.Window.Info.Lines[vi]) > 300 then
          Emu_VM_Default.Gamelist.lists.Window.Info.Lines[vi].Text := uSnippet_Text.uSnippet_Text_SetInGivenPixels(300,
            Emu_VM_Default.Gamelist.lists.Window.Info.Lines[vi]);
      end;
    end;
  end;
end;

procedure Select_List(vList_Num: Integer);
var
  vi: Integer;
  vCount: Integer;
begin
  Emu_VM_Default_Var.lists.Selected := Emu_XML.lists.list[vList_Num].Name;

  for vi := 0 to High(vLists[vList_Num]) do
    if vLists[vList_Num, vi] = '' then
      Break;

  vCount := vi;
  Emu_VM_Default_Var.Gamelist.Roms.Clear;
  Emu_VM_Default_Var.Gamelist.Games.Clear;
  for vi := 0 to vCount do
  begin

    uDB.Arcade_Query.Close;
    uDB.Arcade_Query.SQL.Clear;
    uDB.Arcade_Query.SQL.Text := 'SELECT gamename, romname FROM games WHERE romname=''' + vLists[vList_Num, vi] + ''' ORDER BY gamename ASC';
    uDB.Arcade_Query.Open;

    Emu_VM_Default_Var.Gamelist.Games.Add(uDB.Arcade_Query.FieldByName('gamename').AsString);
    Emu_VM_Default_Var.Gamelist.Roms.Add(uDB.Arcade_Query.FieldByName('romname').AsString);
  end;

  Emu_VM_Default_Var.Gamelist.Total_Games := vCount;
  Emu_VM_Default.Gamelist.lists.Lists_Text.Text := Emu_XML.lists.list[vList_Num].Name;
  Emu_VM_Default_Var.Gamelist.Selected := 0;
  Emu_VM_Default_Var.Gamelist.Old_Selected := -100;

  uView_Mode_Default_Actions.Refresh;
  uView_Mode_Default_Actions.Lists_Action;
end;

procedure Clear_Info(vNum: Integer);
var
  vi: Integer;
begin
  Emu_VM_Default.Gamelist.lists.Window.Info.image.Bitmap := nil;
  Emu_VM_Default.Gamelist.lists.Window.Info.Count_Value.Text := '';

  for vi := 0 to 9 do
    Emu_VM_Default.Gamelist.lists.Window.Info.Lines[vi].Text := '';
  Emu_VM_Default.Gamelist.lists.Window.list[vNum].item_glow.Enabled := False;
end;

procedure Clear_List;
begin
  Emu_VM_Default_Var.Gamelist.Games.Clear;
  Emu_VM_Default_Var.Gamelist.Roms.Clear;

  uDB.Arcade_Query.Close;
  uDB.Arcade_Query.SQL.Clear;
  uDB.Arcade_Query.SQL.Text := 'SELECT gamename, romname FROM games ORDER BY gamename ASC';
  uDB.Arcade_Query.DisableControls;
  uDB.Arcade_Query.Open;
  uDB.Arcade_Query.First;

  try
    uDB.Arcade_Query.First;
    while not uDB.Arcade_Query.Eof do
    begin
      Emu_VM_Default_Var.Gamelist.Games.Add(uDB.Arcade_Query.FieldByName('gamename').AsString);
      Emu_VM_Default_Var.Gamelist.Roms.Add(uDB.Arcade_Query.FieldByName('romname').AsString);
      uDB.Arcade_Query.Next;
    end;
  finally
    uDB.Arcade_Query.EnableControls;
  end;

  Emu_VM_Default_Var.lists.Selected := 'None';

  Emu_VM_Default_Var.Gamelist.Total_Games := uDB.Arcade_Query.RecordCount;
  Emu_VM_Default.Gamelist.lists.Lists_Text.Text := Emu_VM_Default_Var.lists.Selected;
  Emu_VM_Default_Var.Gamelist.Selected := 0;
  Emu_VM_Default_Var.Gamelist.Old_Selected := -100;

  uView_Mode_Default_Actions.Refresh;

  Emu_VM_Default.Gamelist.lists.Window.Remove.Visible := False;
  Emu_VM_Default.Gamelist.lists.Window.Selected_Value.Text := Emu_VM_Default_Var.lists.Selected;
end;

end.
