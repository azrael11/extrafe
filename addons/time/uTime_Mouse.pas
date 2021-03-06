unit uTime_Mouse;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  FMX.Objects,
  FMX.Listbox,
  FMX.Types,
  FMX.StdCtrls,
  FMX.Colors,
  FMX.Effects;

type
  TTIME_ADDON_IMAGE = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TTIME_ADDON_TEXT = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TTIME_ADDON_PANEL = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TTIME_ADDON_COMBOBOX = class(TObject)
    procedure OnChange(Sender: TObject);
  end;

type
  TTIME_ADDON_COLORCOMBOBOX = class(TObject)
    procedure OnChange(Sender: TObject);
  end;

type
  TTIME_ADDON_CHECKBOX = class(TObject)
    procedure OnMouseClick(Sender: TObject);
  end;

type
  TTIME_MOUSE_ACTIONS = record

    Image: TTIME_ADDON_IMAGE;
    Text: TTIME_ADDON_TEXT;
    Panel: TTIME_ADDON_PANEL;
    Combobox: TTIME_ADDON_COMBOBOX;
    ColorCombobox: TTIME_ADDON_COLORCOMBOBOX;
    Checkbox: TTIME_ADDON_CHECKBOX;
  end;

implementation

uses
  uLoad_AllTypes,
  uMain_SetAll,
  uTime_SetAll,
  uTime_AllTypes,
  uTime_Actions,
  uTime_Time_Actions,
  uTime_Time_SetAll;

{ TTIME_ADDON_IMAGE }

procedure TTIME_ADDON_IMAGE.OnMouseClick(Sender: TObject);
begin

end;

procedure TTIME_ADDON_IMAGE.OnMouseEnter(Sender: TObject);
begin

end;

procedure TTIME_ADDON_IMAGE.OnMouseLeave(Sender: TObject);
begin

end;

{ TTIME_ADDON_TEXT }

procedure TTIME_ADDON_TEXT.OnMouseClick(Sender: TObject);
begin

end;

procedure TTIME_ADDON_TEXT.OnMouseEnter(Sender: TObject);
begin

end;

procedure TTIME_ADDON_TEXT.OnMouseLeave(Sender: TObject);
begin

end;


{ TTIME_ADDON_COMBOBOX }
procedure TTIME_ADDON_COMBOBOX.OnChange(Sender: TObject);
begin

end;

{ TTIME_ADDON_CHECKBOX }
procedure TTIME_ADDON_CHECKBOX.OnMouseClick(Sender: TObject);
begin

end;

{ TTIME_ADDON_COLORCOMBOBOX }
procedure TTIME_ADDON_COLORCOMBOBOX.OnChange(Sender: TObject);
begin

end;

{ TTIME_ADDON_PANEL }

procedure TTIME_ADDON_PANEL.OnMouseClick(Sender: TObject);
begin
  if vTime.Tab_Selected <> TImage(Sender).Tag then
  begin
    if TPanel(Sender).Name = 'A_T_Tab_UpPanel_' + TPanel(Sender).Tag.ToString then
      uTime_Actions.ShowTab(TPanel(Sender).Tag)
  end;
end;

procedure TTIME_ADDON_PANEL.OnMouseEnter(Sender: TObject);
begin
  TPanel(Sender).Cursor := crHandPoint;
  if vTime.Tab_Selected <> TImage(Sender).Tag then
  begin
    if TPanel(Sender).Name = 'A_T_Tab_UpPanel_' + TPanel(Sender).Tag.ToString then
      vTime.Tab[TPanel(Sender).Tag].Back_Glow.Enabled := True;
  end;
end;

procedure TTIME_ADDON_PANEL.OnMouseLeave(Sender: TObject);
begin
  if vTime.Tab_Selected <> TImage(Sender).Tag then
  begin
    if TPanel(Sender).Name = 'A_T_Tab_UpPanel_' + TPanel(Sender).Tag.ToString then
      vTime.Tab[TPanel(Sender).Tag].Back_Glow.Enabled := False;
  end;
end;

initialization
addons.time.Input.mouse.Image := TTIME_ADDON_IMAGE.Create;
addons.time.Input.mouse.Text := TTIME_ADDON_TEXT.Create;
addons.time.Input.mouse.Panel := TTIME_ADDON_PANEL.Create;
addons.time.Input.mouse.Combobox := TTIME_ADDON_COMBOBOX.Create;
addons.time.Input.mouse.ColorCombobox := TTIME_ADDON_COLORCOMBOBOX.Create;
addons.time.Input.mouse.Checkbox := TTIME_ADDON_CHECKBOX.Create;

finalization
addons.time.Input.mouse.Image.Free;
addons.time.Input.mouse.Text.Free;
addons.time.Input.mouse.Panel.Free;
addons.time.Input.mouse.Combobox.Free;
addons.time.Input.mouse.ColorCombobox.Free;
addons.time.Input.mouse.Checkbox.Free;

end.
