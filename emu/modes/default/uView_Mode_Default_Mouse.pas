unit uView_Mode_Default_Mouse;

interface

uses
  System.Classes,
  System.UiTypes,
  System.SysUtils,
  System.StrUtils,
  System.Types,
  FMX.Objects,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Edit,
  FMX.Objects3D,
  FMX.ListBox,
  FMX.Graphics,
  BASS;

type
  TEMU_VIEW_MODE_DEFAULT_IMAGE = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
    procedure onPaint(Canvas: FMX.Graphics.TCanvas; ARect: System.Types.TRectF);
  end;

type
  TEMU_VIEW_MODE_DEFAULT_TEXT = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
    procedure OnMouseUp(Sender: TObject; vButton: TMouseButton; vShift: TShiftState; vX, vY: Single);
  end;

type
  TEMU_VIEW_MODE_DEFAULT_BUTTON = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TEMU_VIEW_MODE_DEFAULT_MODEL3D = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TEMU_VIEW_MODE_DEFAULT_PANEL = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TEMU_VIEW_MODE_DEFAULT_EDIT = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnTyping(Sender: TObject);
  end;

type
  TEMU_VIEW_MODE_DEFAULT_COMBOBOX = class(TObject)
    procedure OnChange(Sender: TObject);
  end;

type
  TEMU_VIEW_MODE_VIDEO_MOUSE = record
    Image: TEMU_VIEW_MODE_DEFAULT_IMAGE;
    Text: TEMU_VIEW_MODE_DEFAULT_TEXT;
    Button: TEMU_VIEW_MODE_DEFAULT_BUTTON;
    Model3D: TEMU_VIEW_MODE_DEFAULT_MODEL3D;
    Edit: TEMU_VIEW_MODE_DEFAULT_EDIT;
    ComboBox: TEMU_VIEW_MODE_DEFAULT_COMBOBOX;
    Panel: TEMU_VIEW_MODE_DEFAULT_PANEL;
  end;

var
  Emu_VM_Default_Mouse: TEMU_VIEW_MODE_VIDEO_MOUSE;

implementation

uses
  uView_Mode_Default_AllTypes,
  uView_Mode_Default_Actions,
  uView_Mode_Default_Actions_Filters,
  uView_Mode_Default_Actions_Lists,
  uEmu_Emu;

{ TEMU_VIEW_MODE_VIDEO_IMAGE }

procedure TEMU_VIEW_MODE_DEFAULT_IMAGE.OnMouseClick(Sender: TObject);
begin

end;

procedure TEMU_VIEW_MODE_DEFAULT_IMAGE.OnMouseEnter(Sender: TObject);
begin

end;

procedure TEMU_VIEW_MODE_DEFAULT_IMAGE.OnMouseLeave(Sender: TObject);
begin

end;

procedure TEMU_VIEW_MODE_DEFAULT_IMAGE.onPaint(Canvas: FMX.Graphics.TCanvas; ARect: System.Types.TRectF);
begin

end;

{ TEMU_VIEW_MODE_VIDEO_TEXT }

procedure TEMU_VIEW_MODE_DEFAULT_TEXT.OnMouseClick(Sender: TObject);
begin
  if TText(Sender).TextSettings.FontColor <> TAlphaColorRec.Grey then
  begin
    if Emu_VM_Default_Var.Filters_Open then
    begin
      if TText(Sender).Name = 'Emu_Filters_Window_Clear' then
        uView_Mode_Default_Actions_Filters.Clear_Filters
      else if TText(Sender).Name = 'Emu_Filters_Window_Add' then
        uView_Mode_Default_Actions_Filters.Add;
    end
    else
    begin
      if TText(Sender).Name = 'Emu_Settings' then
        uView_Mode_Default_Actions.Configuration_Action
      else if TText(Sender).Name = 'Emu_Gamelist_Filters_Icon' then
        uView_Mode_Default_Actions.Filters_Action
      else if TText(Sender).Name = 'Emu_Gamelist_Lists_Icon' then
        uView_Mode_Default_Actions.Lists_Action
      else if TText(Sender).Name = 'Emu_Media_Bar_Favorites' then
        uView_Mode_Default_Actions.Favorites_Open
      else if TText(Sender).Name = 'Emu_Gamelist_Search_Icon' then
        uView_Mode_Default_Actions.Search_Open
      else
        uEmu_Emu.Mouse_Action(TText(Sender).Name);
    end;
    BASS_ChannelPlay(Emu_VM_Default_Var.sounds.Gen_Click, False);
  end;
end;

procedure TEMU_VIEW_MODE_DEFAULT_TEXT.OnMouseEnter(Sender: TObject);
begin
  if TText(Sender).Name = 'Emu_Media_Bar_Favorites' then
  begin
    TText(Sender).Cursor := crHandPoint;
    Emu_VM_Default.Media.Bar.Favorites_Glow.Enabled := True;
  end;
  if TText(Sender).TextSettings.FontColor <> TAlphaColorRec.Grey then
  begin
    TText(Sender).Cursor := crHandPoint;
    if Emu_VM_Default_Var.Lists_Open then
    begin
      if TText(Sender).Name = 'Emu_Lists_Add' then
        Emu_VM_Default.Gamelist.Lists.Window.Add_Glow.Enabled := True;
    end
    else if Emu_VM_Default_Var.Filters_Open then
    begin
      if TText(Sender).Name = 'Emu_Filters_Window_Clear' then
        Emu_VM_Default.Gamelist.Filters.Window.Clear_Glow.Enabled := True
      else if TText(Sender).Name = 'Emu_Filters_Window_Add' then
        Emu_VM_Default.Gamelist.Filters.Window.Add_Glow.Enabled := True
      else if TText(Sender).Name = 'Emu_Filters_Window_Filter_Remove_' + TText(Sender).Tag.ToString then
        Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[TText(Sender).Tag].Remove_Glow.Enabled := True;
    end
    else
    begin
      if TText(Sender).Name = 'Emu_Exit' then
        Emu_VM_Default.Exit_Glow.Enabled := True
      else if TText(Sender).Name = 'Emu_Settings' then
        Emu_VM_Default.Settings_Glow.Enabled := True
      else if TText(Sender).Name = 'Emu_Gamelist_Filters_Icon' then
        Emu_VM_Default.Gamelist.Filters.Filter_Glow.Enabled := True
      else if TText(Sender).Name = 'Emu_Gamelist_Lists_Icon' then
        Emu_VM_Default.Gamelist.Lists.Lists_Glow.Enabled := True
      else if TText(Sender).Name = 'Emu_Gamelist_Search_Icon' then
        Emu_VM_Default.Gamelist.Search.Glow.Enabled := True
    end;
  end;
end;

procedure TEMU_VIEW_MODE_DEFAULT_TEXT.OnMouseLeave(Sender: TObject);
begin
  if Emu_VM_Default_Var.Lists_Open then
  begin
    if TText(Sender).Name = 'Emu_Lists_Add' then
      Emu_VM_Default.Gamelist.Lists.Window.Add_Glow.Enabled := False;
  end
  else if Emu_VM_Default_Var.Filters_Open then
  begin
    if TText(Sender).Name = 'Emu_Filters_Window_Clear' then
      Emu_VM_Default.Gamelist.Filters.Window.Clear_Glow.Enabled := False
    else if TText(Sender).Name = 'Emu_Filters_Window_Add' then
      Emu_VM_Default.Gamelist.Filters.Window.Add_Glow.Enabled := False
    else if TText(Sender).Name = 'Emu_Filters_Window_Filter_Remove_' + TText(Sender).Tag.ToString then
      Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[TText(Sender).Tag].Remove_Glow.Enabled := False;
  end
  else
  begin
    if TText(Sender).Name = 'Emu_Exit' then
      Emu_VM_Default.Exit_Glow.Enabled := False
    else if TText(Sender).Name = 'Emu_Settings' then
      Emu_VM_Default.Settings_Glow.Enabled := False
    else if TText(Sender).Name = 'Emu_Gamelist_Filters_Icon' then
      Emu_VM_Default.Gamelist.Filters.Filter_Glow.Enabled := False
    else if TText(Sender).Name = 'Emu_Gamelist_Lists_Icon' then
      Emu_VM_Default.Gamelist.Lists.Lists_Glow.Enabled := False
    else if TText(Sender).Name = 'Emu_Media_Bar_Favorites' then
      Emu_VM_Default.Media.Bar.Favorites_Glow.Enabled := False
    else if TText(Sender).Name = 'Emu_Gamelist_Search_Icon' then
      Emu_VM_Default.Gamelist.Search.Glow.Enabled := False
  end;
end;

procedure TEMU_VIEW_MODE_DEFAULT_TEXT.OnMouseUp(Sender: TObject; vButton: TMouseButton; vShift: TShiftState; vX, vY: Single);
begin
  if TText(Sender).TextSettings.FontColor <> TAlphaColorRec.Grey then
  begin
    if TText(Sender).Name = 'Emu_Filters_Window_Filter_Remove_' + TText(Sender).Tag.ToString then
      uView_Mode_Default_Actions_Filters.Remove(TText(Sender).Tag);
  end;
end;

{ TEMU_VIEW_MODE_VIDEO_BUTTON }

procedure TEMU_VIEW_MODE_DEFAULT_BUTTON.OnMouseClick(Sender: TObject);
begin
  if Emu_VM_Default_Var.Filters_Open then
  begin
    if TButton(Sender).Name = 'Emu_Filters_Window_Cancel' then
      uView_Mode_Default_Actions_Filters.Close_Window
    else if TButton(Sender).Name = 'Emu_Filters_Window_OK' then
      uView_Mode_Default_Actions_Filters.Return;

  end;
end;

procedure TEMU_VIEW_MODE_DEFAULT_BUTTON.OnMouseEnter(Sender: TObject);
begin

end;

procedure TEMU_VIEW_MODE_DEFAULT_BUTTON.OnMouseLeave(Sender: TObject);
begin

end;

{ TEMU_VIEW_MODE_VIDEO_MODEL3D }

procedure TEMU_VIEW_MODE_DEFAULT_MODEL3D.OnMouseClick(Sender: TObject);
begin
  if TModel3D(Sender).Name = 'Emu_Game_Favorite_3D_Viewport' then
  begin
    if Emu_VM_Default_Var.favorites.game_is then
      Emu_VM_Default.GameMenu.Favorite.Heart.MeshCollection[0].MaterialSource := Emu_VM_Default.GameMenu.Favorite.Material_Source
    else
      Emu_VM_Default.GameMenu.Favorite.Heart.MeshCollection[0].MaterialSource := nil;
    uView_Mode_Default_Actions.Favorites_Add;
    Emu_VM_Default.GameMenu.Favorite.Ani.Stop;
    Emu_VM_Default.GameMenu.Favorite.Ani_Selected.Start;
  end;
end;

procedure TEMU_VIEW_MODE_DEFAULT_MODEL3D.OnMouseEnter(Sender: TObject);
begin
  Emu_VM_Default.GameMenu.Favorite.View.Cursor := crHandPoint;
  Emu_VM_Default.GameMenu.Favorite.Ani.Duration := 0.8;
end;

procedure TEMU_VIEW_MODE_DEFAULT_MODEL3D.OnMouseLeave(Sender: TObject);
begin
  Emu_VM_Default.GameMenu.Favorite.Ani.Duration := 2;
end;

{ TEMU_VIEW_MODE_VIDEO_EDIT }

procedure TEMU_VIEW_MODE_DEFAULT_EDIT.OnMouseClick(Sender: TObject);
begin

end;

procedure TEMU_VIEW_MODE_DEFAULT_EDIT.OnTyping(Sender: TObject);
begin
  if Emu_VM_Default_Var.Search_Open then
    uView_Mode_Default_Actions.Search_Find(Emu_VM_Default_Var.Search.vstring);
end;

{ TEMU_VIEW_MODE_DEFAULT_COMBOBOX }

procedure TEMU_VIEW_MODE_DEFAULT_COMBOBOX.OnChange(Sender: TObject);
begin
  if Emu_VM_Default_Var.Filters_Open then
  begin
    if TComboBox(Sender).Name = 'Emu_Filters_Window_Filter_Combo_' + TComboBox(Sender).Tag.ToString then
      uView_Mode_Default_Actions_Filters.Second_Choose(TComboBox(Sender).Items.Strings[TComboBox(Sender).ItemIndex], TComboBox(Sender).Tag)
    else if (TComboBox(Sender).Name = 'Emu_Filters_Window_Filter_Combo_Second_' + TComboBox(Sender).Tag.ToString) and (TComboBox(Sender).ItemIndex > 0) then
      uView_Mode_Default_Actions_Filters.Filter_Result(TComboBox(Sender).TagString, TComboBox(Sender).Items.Strings[TComboBox(Sender).ItemIndex],
        TComboBox(Sender).Tag);
  end;
end;

{ TEMU_VIEW_MODE_DEFAULT_PANEL }

procedure TEMU_VIEW_MODE_DEFAULT_PANEL.OnMouseClick(Sender: TObject);
begin
  TPanel(Sender).Cursor := crHandPoint;
  if TPanel(Sender).Name = 'Lists_List_Item_Overlay_' + TPanel(Sender).Tag.ToString then
    uView_Mode_Default_Actions_Lists.Select_List(TPanel(Sender).Tag);
end;

procedure TEMU_VIEW_MODE_DEFAULT_PANEL.OnMouseEnter(Sender: TObject);
begin
  TPanel(Sender).Cursor := crHandPoint;
  if TPanel(Sender).Name = 'Lists_List_Item_Overlay_' + TPanel(Sender).Tag.ToString then
  begin
    // Emu_VM_Default.Gamelist.Lists.Window.list[TPanel(Sender).Tag].item_glow.Enabled := True;
    uView_Mode_Default_Actions_Lists.Create_Callout(TPanel(Sender).Tag, TPanel(Sender).TagString.ToInteger);
  end;
end;

procedure TEMU_VIEW_MODE_DEFAULT_PANEL.OnMouseLeave(Sender: TObject);
begin
  if TPanel(Sender).Name = 'Lists_List_Item_Overlay_' + TPanel(Sender).Tag.ToString then
  begin
    // Emu_VM_Default.Gamelist.Lists.Window.list[TPanel(Sender).Tag].item_glow.Enabled := False;
    Emu_VM_Default.Gamelist.Lists.Window.call[TPanel(Sender).Tag].Panel.Visible := False;
  end;
end;

initialization

Emu_VM_Default_Mouse.Image := TEMU_VIEW_MODE_DEFAULT_IMAGE.Create;
Emu_VM_Default_Mouse.Text := TEMU_VIEW_MODE_DEFAULT_TEXT.Create;
Emu_VM_Default_Mouse.Button := TEMU_VIEW_MODE_DEFAULT_BUTTON.Create;
Emu_VM_Default_Mouse.Model3D := TEMU_VIEW_MODE_DEFAULT_MODEL3D.Create;
Emu_VM_Default_Mouse.Edit := TEMU_VIEW_MODE_DEFAULT_EDIT.Create;
Emu_VM_Default_Mouse.ComboBox := TEMU_VIEW_MODE_DEFAULT_COMBOBOX.Create;
Emu_VM_Default_Mouse.Panel := TEMU_VIEW_MODE_DEFAULT_PANEL.Create;

finalization

Emu_VM_Default_Mouse.Image.Free;
Emu_VM_Default_Mouse.Text.Free;
Emu_VM_Default_Mouse.Button.Free;
Emu_VM_Default_Mouse.Model3D.Free;
Emu_VM_Default_Mouse.Edit.Free;
Emu_VM_Default_Mouse.ComboBox.Free;
Emu_VM_Default_Mouse.Panel.Free;

end.
