unit uView_Mode_Video_Mouse;

interface

uses
  System.Classes,
  System.UiTypes,
  System.StrUtils,
  FMX.Objects,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Edit,
  FMX.Objects3D,
  BASS;

type
  TEMU_VIEW_MODE_VIDEO_IMAGE = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TEMU_VIEW_MODE_VIDEO_TEXT = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TEMU_VIEW_MODE_VIDEO_BUTTON = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TEMU_VIEW_MODE_VIDEO_MODEL3D = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TEMU_VIEW_MODE_VIDEO_EDIT = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnTyping(Sender: TObject);
  end;

type
  TEMU_VIEW_MODE_VIDEO_MOUSE = record
    Image: TEMU_VIEW_MODE_VIDEO_IMAGE;
    Text: TEMU_VIEW_MODE_VIDEO_TEXT;
    Button: TEMU_VIEW_MODE_VIDEO_BUTTON;
    Model3D: TEMU_VIEW_MODE_VIDEO_MODEL3D;
    Edit: TEMU_VIEW_MODE_VIDEO_EDIT;
  end;

var
  Emu_VM_Video_Mouse: TEMU_VIEW_MODE_VIDEO_MOUSE;

implementation

uses
  uView_Mode_Video_AllTypes,
  uView_Mode_Video_Actions,
  uView_Mode_Video_Actions_Filters,
  uEmu_Emu;

{ TEMU_VIEW_MODE_VIDEO_IMAGE }

procedure TEMU_VIEW_MODE_VIDEO_IMAGE.OnMouseClick(Sender: TObject);
begin

end;

procedure TEMU_VIEW_MODE_VIDEO_IMAGE.OnMouseEnter(Sender: TObject);
begin

end;

procedure TEMU_VIEW_MODE_VIDEO_IMAGE.OnMouseLeave(Sender: TObject);
begin

end;

{ TEMU_VIEW_MODE_VIDEO_TEXT }

procedure TEMU_VIEW_MODE_VIDEO_TEXT.OnMouseClick(Sender: TObject);
begin
  if Emu_VM_Video_Var.Filters_Open then
  begin
    if TText(Sender).Name = 'Emu_Filters_Window_Clear' then

    else if TText(Sender).Name = 'Emu_Filters_Window_Add' then
      uView_Mode_Video_Actions_Filters.Add;
  end
  else
  begin
    if TText(Sender).Name = 'Emu_Settings' then
      uView_Mode_Video_Actions.Configuration_Action
    else if TText(Sender).Name = 'Emu_Gamelist_Filters_Icon' then
      uView_Mode_Video_Actions.Filters_Action
    else if TText(Sender).Name = 'Emu_Media_Bar_Favorites' then
      uView_Mode_Video_Actions.Favorites_Open
    else if TText(Sender).Name = 'Emu_Gamelist_Search_Icon' then
      uView_Mode_Video_Actions.Search_Open
    else
      uEmu_Emu.Mouse_Action(TText(Sender).Name);
  end;
end;

procedure TEMU_VIEW_MODE_VIDEO_TEXT.OnMouseEnter(Sender: TObject);
begin
  if TText(Sender).Name = 'Emu_Media_Bar_Favorites' then
  begin
    TText(Sender).Cursor := crHandPoint;
    Emu_VM_Video.Media.Bar.Favorites_Glow.Enabled := True;
  end;
  if TText(Sender).TextSettings.FontColor <> TAlphaColorRec.Grey then
  begin
    if Emu_VM_Video_Var.Filters_Open then
    begin
      if TText(Sender).Name = 'Emu_Filters_Window_Clear' then
        Emu_VM_Video.Gamelist.Filters.Window.Clear_Glow.Enabled := True
      else if TText(Sender).Name = 'Emu_Filters_Window_Add' then
        Emu_VM_Video.Gamelist.Filters.Window.Add_Glow.Enabled := True;
    end
    else
    begin
      if TText(Sender).Name = 'Emu_Exit' then
        Emu_VM_Video.Exit_Glow.Enabled := True
      else if TText(Sender).Name = 'Emu_Settings' then
        Emu_VM_Video.Settings_Glow.Enabled := True
      else if TText(Sender).Name = 'Emu_Gamelist_Filters_Icon' then
        Emu_VM_Video.Gamelist.Filters.Filter_Glow.Enabled := True
      else if TText(Sender).Name = 'Emu_Gamelist_Lists_Icon' then
        Emu_VM_Video.Gamelist.Lists.Lists_Glow.Enabled := True
      else if TText(Sender).Name = 'Emu_Gamelist_Search_Icon' then
        Emu_VM_Video.Gamelist.Search.Glow.Enabled := True
    end;
  end;
end;

procedure TEMU_VIEW_MODE_VIDEO_TEXT.OnMouseLeave(Sender: TObject);
begin
  if Emu_VM_Video_Var.Filters_Open then
  begin
    if TText(Sender).Name = 'Emu_Filters_Window_Clear' then
      Emu_VM_Video.Gamelist.Filters.Window.Clear_Glow.Enabled := False
    else if TText(Sender).Name = 'Emu_Filters_Window_Add' then
      Emu_VM_Video.Gamelist.Filters.Window.Add_Glow.Enabled := False;
  end
  else
  begin
    if TText(Sender).Name = 'Emu_Exit' then
      Emu_VM_Video.Exit_Glow.Enabled := False
    else if TText(Sender).Name = 'Emu_Settings' then
      Emu_VM_Video.Settings_Glow.Enabled := False
    else if TText(Sender).Name = 'Emu_Gamelist_Filters_Icon' then
      Emu_VM_Video.Gamelist.Filters.Filter_Glow.Enabled := False
    else if TText(Sender).Name = 'Emu_Gamelist_Lists_Icon' then
      Emu_VM_Video.Gamelist.Lists.Lists_Glow.Enabled := False
    else if TText(Sender).Name = 'Emu_Media_Bar_Favorites' then
      Emu_VM_Video.Media.Bar.Favorites_Glow.Enabled := False
    else if TText(Sender).Name = 'Emu_Gamelist_Search_Icon' then
      Emu_VM_Video.Gamelist.Search.Glow.Enabled := False
  end;
end;

{ TEMU_VIEW_MODE_VIDEO_BUTTON }

procedure TEMU_VIEW_MODE_VIDEO_BUTTON.OnMouseClick(Sender: TObject);
begin
  if TButton(Sender).Name = 'Emu_Filters_Window_Cancel' then
    uView_Mode_Video_Actions_Filters.Close_Window;

end;

procedure TEMU_VIEW_MODE_VIDEO_BUTTON.OnMouseEnter(Sender: TObject);
begin

end;

procedure TEMU_VIEW_MODE_VIDEO_BUTTON.OnMouseLeave(Sender: TObject);
begin

end;

{ TEMU_VIEW_MODE_VIDEO_MODEL3D }

procedure TEMU_VIEW_MODE_VIDEO_MODEL3D.OnMouseClick(Sender: TObject);
begin
  if TModel3D(Sender).Name = 'Emu_Game_Favorite_3D_Viewport' then
  begin
    if Emu_VM_Video_Var.favorites.game_is then
      Emu_VM_Video.GameMenu.Favorite.Heart.MeshCollection[0].MaterialSource := Emu_VM_Video.GameMenu.Favorite.Material_Source
    else
      Emu_VM_Video.GameMenu.Favorite.Heart.MeshCollection[0].MaterialSource := nil;
    uView_Mode_Video_Actions.Favorites_Add;
    Emu_VM_Video.GameMenu.Favorite.Ani.Stop;
    Emu_VM_Video.GameMenu.Favorite.Ani_Selected.Start;
  end;
end;

procedure TEMU_VIEW_MODE_VIDEO_MODEL3D.OnMouseEnter(Sender: TObject);
begin
  Emu_VM_Video.GameMenu.Favorite.View.Cursor := crHandPoint;
  Emu_VM_Video.GameMenu.Favorite.Ani.Duration := 0.8;
end;

procedure TEMU_VIEW_MODE_VIDEO_MODEL3D.OnMouseLeave(Sender: TObject);
begin
  Emu_VM_Video.GameMenu.Favorite.Ani.Duration := 2;
end;

{ TEMU_VIEW_MODE_VIDEO_EDIT }

procedure TEMU_VIEW_MODE_VIDEO_EDIT.OnMouseClick(Sender: TObject);
begin

end;

procedure TEMU_VIEW_MODE_VIDEO_EDIT.OnTyping(Sender: TObject);
begin
  if Emu_VM_Video_Var.Search_Open then
    uView_Mode_Video_Actions.Search_Find(Emu_VM_Video_Var.Search.vstring);
end;

initialization

Emu_VM_Video_Mouse.Image := TEMU_VIEW_MODE_VIDEO_IMAGE.Create;
Emu_VM_Video_Mouse.Text := TEMU_VIEW_MODE_VIDEO_TEXT.Create;
Emu_VM_Video_Mouse.Button := TEMU_VIEW_MODE_VIDEO_BUTTON.Create;
Emu_VM_Video_Mouse.Model3D := TEMU_VIEW_MODE_VIDEO_MODEL3D.Create;
Emu_VM_Video_Mouse.Edit := TEMU_VIEW_MODE_VIDEO_EDIT.Create;

finalization

Emu_VM_Video_Mouse.Image.Free;
Emu_VM_Video_Mouse.Text.Free;
Emu_VM_Video_Mouse.Button.Free;
Emu_VM_Video_Mouse.Model3D.Free;
Emu_VM_Video_Mouse.Edit.Free;

end.
