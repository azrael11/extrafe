unit uMain_Emulation;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UITypes,
  System.UIConsts,
  FMX.Objects,
  FMX.Graphics,
  FMX.Effects,
  FMX.Ani,
  FMX.Types,
  FMX.Filter.Effects,
  ALFmxTabControl;

type
  TEMULATOR_INPUT_MOUSE_IMAGE = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TEMULATOR_INPUT_MOUSE_TEXT = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TEMULATOR_INPUT_MOUSE = record
    Image: TEMULATOR_INPUT_MOUSE_IMAGE;
    Text: TEMULATOR_INPUT_MOUSE_TEXT;
  end;

type
  TEMULATOR_INPUT = record
    mouse: TEMULATOR_INPUT_MOUSE;
  end;

function GetBitmap(vNum, vLevel: Integer; vType: String): TBitmap;

procedure Create_Selection_Control;
procedure Clear_Selection_Control;
procedure Create_Selection_Tab(vTab, vLevel: Integer; isActive: Boolean);

procedure Category(vMenuIndex: Integer);

procedure Trigger_Emulator;
procedure Trigger_Click(vTriggerImage: Integer; vBack: Boolean);

procedure Arcade_Category;
procedure SubHeader_Level(vCategory: Integer);

procedure Slide_Right;
procedure Slide_Left;

var
  vEmu_Input: TEMULATOR_INPUT;

implementation

uses
  uLoad_AllTypes,
  uDB_AUser,
  uMain_AllTypes,
  uMain_Actions,
  uEmu_Actions;

procedure Clear_Selection_Control;
begin
  FreeAndNil(emulation.Selection);
end;

function GetBitmap(vNum, vLevel: Integer; vType: String): TBitmap;
begin
  Result := TBitmap.Create;
  if vType = 'logo' then
  begin
    if vLevel = 0 then
      Result.LoadFromFile(emulation.Category[vNum].Logo)
    else if vLevel = 1 then
      Result.LoadFromFile(emulation.Arcade[vNum].Logo);
  end
  else if vType = 'background' then
  begin
    if vLevel = 0 then
      Result.LoadFromFile(emulation.Category[vNum].Background)
    else if vLevel = 1 then
      Result.LoadFromFile(emulation.Arcade[vNum].Background);
  end;
end;

procedure Create_Selection_Control;
var
  vi: Integer;
begin
  emulation.Selection := TALTabControl.Create(mainScene.Selection.Back);
  emulation.Selection.Name := 'MainMenu_Selection_Control';
  emulation.Selection.Parent := mainScene.Selection.Back;
  emulation.Selection.Width := mainScene.Selection.Back.Width;
  emulation.Selection.Height := mainScene.Selection.Back.Height;
  emulation.Selection.Visible := True;

  emulation.Selection_Ani := TFloatAnimation.Create(emulation.Selection);
  emulation.Selection_Ani.Name := 'MainMenu_Selection_Ani';
  emulation.Selection_Ani.Parent := emulation.Selection;
  emulation.Selection_Ani.Duration := 0.4;
  emulation.Selection_Ani.Interpolation := TInterpolationType.Quadratic;
  emulation.Selection_Ani.PropertyName := 'Position.Y';
  emulation.Selection_Ani.Loop := False;
  emulation.Selection_Ani.OnFinish := uMain_Actions.vMain_Ani.OnFinish;
  emulation.Selection_Ani.Enabled := False;
end;

procedure Create_Selection_Tab(vTab, vLevel: Integer; isActive: Boolean);
begin
  emulation.Selection_Tab[vTab].Tab := TALTabItem.Create(emulation.Selection);
  emulation.Selection_Tab[vTab].Tab.Name := 'Emulator_' + IntToStr(vTab);
  emulation.Selection_Tab[vTab].Tab.Parent := emulation.Selection;
  emulation.Selection_Tab[vTab].Tab.Visible := True;

  emulation.Selection_Tab[vTab].Background := TImage.Create(emulation.Selection_Tab[vTab].Tab);
  emulation.Selection_Tab[vTab].Background.Name := 'Emulator_Back_' + vTab.ToString;
  emulation.Selection_Tab[vTab].Background.Parent := emulation.Selection_Tab[vTab].Tab;
  emulation.Selection_Tab[vTab].Background.SetBounds(0, 4, emulation.Selection_Tab[vTab].Tab.Width, emulation.Selection_Tab[vTab].Tab.Height);
  emulation.Selection_Tab[vTab].Background.Bitmap := GetBitmap(vTab, vLevel, 'background');
  emulation.Selection_Tab[vTab].Background.Visible := True;

  emulation.Selection_Tab[vTab].Logo := TImage.Create(emulation.Selection_Tab[vTab].Tab);
  emulation.Selection_Tab[vTab].Logo.Name := 'Emulator_Logo_' + vTab.ToString;
  emulation.Selection_Tab[vTab].Logo.Parent := emulation.Selection_Tab[vTab].Tab;
  emulation.Selection_Tab[vTab].Logo.Width := 600;
  emulation.Selection_Tab[vTab].Logo.Height := 186;
  emulation.Selection_Tab[vTab].Logo.Position.X := (emulation.Selection.Width / 2) - 300;
  emulation.Selection_Tab[vTab].Logo.Position.Y := (emulation.Selection.Height / 2) - 93;
  emulation.Selection_Tab[vTab].Logo.Bitmap := GetBitmap(vTab, vLevel, 'logo');
  emulation.Selection_Tab[vTab].Logo.OnMouseEnter := vEmu_Input.mouse.Image.OnMouseEnter;
  emulation.Selection_Tab[vTab].Logo.OnMouseLeave := vEmu_Input.mouse.Image.OnMouseLeave;
  emulation.Selection_Tab[vTab].Logo.OnClick := vEmu_Input.mouse.Image.OnMouseClick;
  emulation.Selection_Tab[vTab].Logo.Tag := vTab;
  emulation.Selection_Tab[vTab].Logo.Visible := True;

  emulation.Selection_Tab[vTab].Logo_Gray := TMonochromeEffect.Create(emulation.Selection_Tab[vTab].Logo);
  emulation.Selection_Tab[vTab].Logo_Gray.Name := 'Emulator_Logo_Gray_' + IntToStr(vTab);
  emulation.Selection_Tab[vTab].Logo_Gray.Parent := emulation.Selection_Tab[vTab].Logo;
  emulation.Selection_Tab[vTab].Logo_Gray.Enabled := not isActive;

  emulation.Selection_Tab[vTab].Logo_Glow := TGlowEffect.Create(emulation.Selection_Tab[vTab].Logo);
  emulation.Selection_Tab[vTab].Logo_Glow.Name := 'Emulator_Logo_Glow_' + IntToStr(vTab);
  emulation.Selection_Tab[vTab].Logo_Glow.Parent := emulation.Selection_Tab[vTab].Logo;
  emulation.Selection_Tab[vTab].Logo_Glow.Opacity := 0.9;
  emulation.Selection_Tab[vTab].Logo_Glow.Softness := 0.4;
  emulation.Selection_Tab[vTab].Logo_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  emulation.Selection_Tab[vTab].Logo_Glow.Tag := vTab;
  emulation.Selection_Tab[vTab].Logo_Glow.Enabled := False;

  emulation.Selection_Tab[vTab].Story := TText.Create(emulation.Selection_Tab[vTab].Tab);
  emulation.Selection_Tab[vTab].Story.Name := 'Emulator_Story_' + IntToStr(vTab);
  emulation.Selection_Tab[vTab].Story.Parent := emulation.Selection_Tab[vTab].Tab;
  emulation.Selection_Tab[vTab].Story.Position.X := extrafe.res.Width - 200;
  emulation.Selection_Tab[vTab].Story.Position.Y := 100;
  emulation.Selection_Tab[vTab].Story.TextSettings.FontColor := claWhite;
  emulation.Selection_Tab[vTab].Story.Text := 'gaksfgsakd';
  emulation.Selection_Tab[vTab].Story.Visible := True;

  if vLevel > 0 then
  begin
    emulation.Selection_Tab[vTab].Back := TText.Create(emulation.Selection_Tab[vTab].Tab);
    emulation.Selection_Tab[vTab].Back.Name := 'Emulator_Back_Level_' + vTab.ToString;
    emulation.Selection_Tab[vTab].Back.Parent := emulation.Selection_Tab[vTab].Tab;
    emulation.Selection_Tab[vTab].Back.SetBounds(emulation.Selection.Width - 100, 60, 60, 60);
    emulation.Selection_Tab[vTab].Back.Font.Family := 'IcoMoon-Free';
    emulation.Selection_Tab[vTab].Back.Font.Size := 48;
    emulation.Selection_Tab[vTab].Back.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    emulation.Selection_Tab[vTab].Back.Text := #$e967;
    emulation.Selection_Tab[vTab].Back.Tag := vTab;
    emulation.Selection_Tab[vTab].Back.OnClick := vEmu_Input.mouse.Text.OnMouseClick;
    emulation.Selection_Tab[vTab].Back.OnMouseEnter := vEmu_Input.mouse.Text.OnMouseEnter;
    emulation.Selection_Tab[vTab].Back.OnMouseLeave := vEmu_Input.mouse.Text.OnMouseLeave;
    emulation.Selection_Tab[vTab].Back.Visible := True;

    emulation.Selection_Tab[vTab].Back_Glow := TGlowEffect.Create(emulation.Selection_Tab[vTab].Back);
    emulation.Selection_Tab[vTab].Back_Glow.Name := 'Emulator_Back_Glow_Level' + vTab.ToString;
    emulation.Selection_Tab[vTab].Back_Glow.Parent := emulation.Selection_Tab[vTab].Back;
    emulation.Selection_Tab[vTab].Back_Glow.Softness := 0.9;
    emulation.Selection_Tab[vTab].Back_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    emulation.Selection_Tab[vTab].Back_Glow.Enabled := False;
  end;
end;

procedure Trigger_Emulator;
begin
  uEmu_LoadEmulator(emulation.Number);
  mainScene.Main.Down_Level_Ani.Name := 'Main_Down_Animation';
  mainScene.Main.Down_Level_Ani.Duration := 1.8;
  mainScene.Main.Down_Level_Ani.StartValue:= 1;
  mainScene.Main.Down_Level_Ani.StopValue := 0.1;
  mainScene.Main.Down_Level_Ani.Start;
end;

procedure Arcade_Category;
begin
  emulation.Level := 1;
  emulation.Category_Num := 0;
  Clear_Selection_Control;
  Create_Selection_Control;
  Create_Selection_Tab(0, emulation.Level, emulation.Arcade[0].Active);
  emulation.Selection.TabIndex := 0;
end;

procedure SubHeader_Level(vCategory: Integer);
begin
  case vCategory of
    0:
      Arcade_Category;
    1:
      ;
    2:
      ;
    3:
      ;
    4:
      ;
  end;
end;

procedure Trigger_Click(vTriggerImage: Integer; vBack: Boolean);
begin
  if vBack then
  begin
    if emulation.Level <> 0 then
    begin
      Clear_Selection_Control;
      Create_Selection_Control;
      Category(emulation.Category_Num);
    end;
  end
  else
  begin
    if emulation.Level = 0 then
    begin
      SubHeader_Level(vTriggerImage);
    end
    else
    begin
      emulation.Number := vTriggerImage;
      Trigger_Emulator;
    end;
  end;
end;

procedure Category(vMenuIndex: Integer);
var
  vi, ki: Integer;
  vActive: Boolean;
  vEmu_Num: Integer;
begin
  emulation.Level := 0;
  for vi := 0 to 4 do
  begin
    case vi of
      0:
        begin
          vEmu_Num := 8;
          vActive := uDB_AUser.Local.EMULATORS.Arcade;
        end;
      1:
        begin
          vEmu_Num := 30;
          vActive := uDB_AUser.Local.EMULATORS.Computers;
        end;
      2:
        begin
          vEmu_Num := 40;
          vActive := uDB_AUser.Local.EMULATORS.Consoles;
        end;
      3:
        begin
          vEmu_Num := 10;
          vActive := uDB_AUser.Local.EMULATORS.Handhelds;
        end;
      4:
        begin
          vEmu_Num := 1;
          vActive := uDB_AUser.Local.EMULATORS.Pinballs;
        end;
    end;
    Create_Selection_Tab(vi, emulation.Level, vActive);
  end;
  emulation.Selection.TabIndex := vMenuIndex;
  emulation.Category_Num := -1;
end;

/// /////////////////////////////////////////////////////////////////////////////
procedure Slide_Right;
begin
  if extrafe.prog.State = 'main' then
    if emulation.Selection.TabCount - 1 <> emulation.Selection.TabIndex then
      emulation.Selection.Next();
end;

procedure Slide_Left;
begin
  if extrafe.prog.State = 'main' then
    if emulation.Selection.TabIndex <> 0 then
      emulation.Selection.Previous();
end;

{ TEMULATOR_IMAGE }

procedure TEMULATOR_INPUT_MOUSE_IMAGE.OnMouseClick(Sender: TObject);
begin
  if extrafe.prog.State = 'main' then
    if emulation.Selection_Tab[TImage(Sender).Tag].Logo_Gray.Enabled = False then
    begin
      Trigger_Click(TImage(Sender).Tag, False);
    end;
end;

procedure TEMULATOR_INPUT_MOUSE_IMAGE.OnMouseEnter(Sender: TObject);
begin
  if extrafe.prog.State = 'main' then
  begin
    emulation.Selection_Tab[TImage(Sender).Tag].Logo_Glow.Enabled := True;
    emulation.Selection_Tab[TImage(Sender).Tag].Logo.Cursor := crHandPoint;
  end;
end;

procedure TEMULATOR_INPUT_MOUSE_IMAGE.OnMouseLeave(Sender: TObject);
begin
  if extrafe.prog.State = 'main' then
  begin
    emulation.Selection_Tab[TImage(Sender).Tag].Logo_Glow.Enabled := False;
  end;
end;

{ TEMULATOR_INPUT_MOUSE_TEXT }

procedure TEMULATOR_INPUT_MOUSE_TEXT.OnMouseClick(Sender: TObject);
begin
  if TText(Sender).Name = 'Emulator_Back_Level_' + TText(Sender).Tag.ToString then
    Trigger_Click(TText(Sender).Tag, True);
end;

procedure TEMULATOR_INPUT_MOUSE_TEXT.OnMouseEnter(Sender: TObject);
begin
  if TText(Sender).Name = 'Emulator_Back_Level_' + TText(Sender).Tag.ToString then
    emulation.Selection_Tab[TText(Sender).Tag].Back_Glow.Enabled := True;
  TText(Sender).Cursor := crHandPoint;
end;

procedure TEMULATOR_INPUT_MOUSE_TEXT.OnMouseLeave(Sender: TObject);
begin
  if TText(Sender).Name = 'Emulator_Back_Level_' + TText(Sender).Tag.ToString then
    emulation.Selection_Tab[TText(Sender).Tag].Back_Glow.Enabled := False;
end;

initialization

vEmu_Input.mouse.Image := TEMULATOR_INPUT_MOUSE_IMAGE.Create;
vEmu_Input.mouse.Text := TEMULATOR_INPUT_MOUSE_TEXT.Create;

finalization

vEmu_Input.mouse.Image.Free;
vEmu_Input.mouse.Text.Free;

end.
