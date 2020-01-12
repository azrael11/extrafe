unit uView_Mode_Video_Mouse;

interface

uses
  System.Classes,
  System.UiTypes,
  FMX.Objects;

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
  TEMU_VIEW_MODE_VIDEO_MOUSE = record
    Image: TEMU_VIEW_MODE_VIDEO_IMAGE;
    Text: TEMU_VIEW_MODE_VIDEO_TEXT;
    Button: TEMU_VIEW_MODE_VIDEO_BUTTON;
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
    else
      uEmu_Emu.Mouse_Action(TText(Sender).Name);
  end;
end;

procedure TEMU_VIEW_MODE_VIDEO_TEXT.OnMouseEnter(Sender: TObject);
begin
  if TText(Sender).TextSettings.FontColor <> TAlphaColorRec.Grey then
  begin
    TText(Sender).Cursor := crHandPoint;
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
      else if TText(Sender).Name = 'Emu_Media_Bar_Favorites' then
      begin

      end;
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
    begin

    end;
  end;
end;

{ TEMU_VIEW_MODE_VIDEO_BUTTON }

procedure TEMU_VIEW_MODE_VIDEO_BUTTON.OnMouseClick(Sender: TObject);
begin

end;

procedure TEMU_VIEW_MODE_VIDEO_BUTTON.OnMouseEnter(Sender: TObject);
begin

end;

procedure TEMU_VIEW_MODE_VIDEO_BUTTON.OnMouseLeave(Sender: TObject);
begin

end;

initialization

Emu_VM_Video_Mouse.Image := TEMU_VIEW_MODE_VIDEO_IMAGE.Create;
Emu_VM_Video_Mouse.Text := TEMU_VIEW_MODE_VIDEO_TEXT.Create;
Emu_VM_Video_Mouse.Button := TEMU_VIEW_MODE_VIDEO_BUTTON.Create;

finalization

Emu_VM_Video_Mouse.Image.Free;
Emu_VM_Video_Mouse.Text.Free;
Emu_VM_Video_Mouse.Button.Free;

end.