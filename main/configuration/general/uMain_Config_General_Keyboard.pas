unit uMain_Config_General_Keyboard;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UITypes,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.Types,
  FMX.Graphics;

type
  TKEYBOARD_TIMER = class(TObject)
    procedure OnTimer(Sender: TObject);
  end;

var
  vSelected_Tab: Integer;
  vSelected_Label: Integer;
  vSelected_Timer: TTimer;
  vDots: Integer;
  vTimes: Integer;
  vTimer: TKEYBOARD_TIMER;

procedure Load;

procedure Click_To_Accept_Key;
procedure Set_Key(vKey: String);
procedure Save_To_Database(vKey: String);

implementation

uses
  uDB,
  uDB_AUser,
  uLoad_AllTypes,
  uMain_AllTypes,
  uMain_Config_General;

procedure Load;
const
  cGen_Labels: array [0 .. 6] of string = ('Move UP', 'Move DOWN', 'Move LEFT', 'Move RIGHT', 'ACTION', 'ESCAPE', 'CONFIGURATION');
  cEmu_Labels: array [0 .. 11] of string = ('Move UP', 'Move DOWN', 'Move LEFT', 'Move RIGHT', 'ACTION', 'ESCAPE', 'FAVORITE LIST', 'ADD FAVORITE',
    'LISTS PANEL', 'FILTERS PANEL', 'SEARCH', 'CONFIGURATION');
var
  vi, vk, vl: Integer;
begin
  mainScene.Config.Main.R.General.Keyboard.Image := TImage.Create(mainScene.Config.Main.R.General.Tab_Item[3]);
  mainScene.Config.Main.R.General.Keyboard.Image.Name := 'Main_Config_General_Keyboard_Image';
  mainScene.Config.Main.R.General.Keyboard.Image.Parent := mainScene.Config.Main.R.General.Tab_Item[3];
  mainScene.Config.Main.R.General.Keyboard.Image.Bitmap.LoadFromFile(ex_main.Paths.Config_Images + 'general\keyboard.png');
  mainScene.Config.Main.R.General.Keyboard.Image.SetBounds(mainScene.Config.Main.R.General.Contol.Width - 84, 2, 64, 64);
  mainScene.Config.Main.R.General.Keyboard.Image.WrapMode := TImageWrapMode.Stretch;
  mainScene.Config.Main.R.General.Keyboard.Image.Visible := True;

  mainScene.Config.Main.R.General.Keyboard.Panel := TPanel.Create(mainScene.Config.Main.R.General.Tab_Item[3]);
  mainScene.Config.Main.R.General.Keyboard.Panel.Name := 'Main_Config_General_Keyboard_Panel';
  mainScene.Config.Main.R.General.Keyboard.Panel.Parent := mainScene.Config.Main.R.General.Tab_Item[3];
  mainScene.Config.Main.R.General.Keyboard.Panel.SetBounds(10, 66, mainScene.Config.Main.R.General.Contol.Width - 20,
    mainScene.Config.Main.R.General.Contol.Height - 100);
  mainScene.Config.Main.R.General.Keyboard.Panel.Visible := True;

  mainScene.Config.Main.R.General.Keyboard.TabControl := TTabControl.Create(mainScene.Config.Main.R.General.Keyboard.Panel);
  mainScene.Config.Main.R.General.Keyboard.TabControl.Name := 'Main_Config_General_Keyboard_TabControl';
  mainScene.Config.Main.R.General.Keyboard.TabControl.Parent := mainScene.Config.Main.R.General.Keyboard.Panel;
  mainScene.Config.Main.R.General.Keyboard.TabControl.Align := TAlignLayout.Client;
  mainScene.Config.Main.R.General.Keyboard.TabControl.Visible := True;

  for vi := 0 to 1 do
  begin
    mainScene.Config.Main.R.General.Keyboard.TabItems[vi] := TTabItem.Create(mainScene.Config.Main.R.General.Keyboard.TabControl);
    mainScene.Config.Main.R.General.Keyboard.TabItems[vi].Name := 'Main_Config_General_Keyboard_TabItem_' + vi.ToString;
    mainScene.Config.Main.R.General.Keyboard.TabItems[vi].Parent := mainScene.Config.Main.R.General.Keyboard.TabControl;
    if vi = 0 then
      mainScene.Config.Main.R.General.Keyboard.TabItems[vi].Text := 'General'
    else if vi = 1 then
      mainScene.Config.Main.R.General.Keyboard.TabItems[vi].Text := 'Emulators';
    mainScene.Config.Main.R.General.Keyboard.TabItems[vi].Visible := True;
  end;

  { General }
  vl := 0;
  vk := 20;
  for vi := 0 to 6 do
  begin
    mainScene.Config.Main.R.General.Keyboard.Gen_Labels[vi] := TLabel.Create(mainScene.Config.Main.R.General.Keyboard.TabItems[0]);
    mainScene.Config.Main.R.General.Keyboard.Gen_Labels[vi].Name := 'Main_Config_General_Keyboard_General_Label_' + vi.ToString;
    mainScene.Config.Main.R.General.Keyboard.Gen_Labels[vi].Parent := mainScene.Config.Main.R.General.Keyboard.TabItems[0];
    mainScene.Config.Main.R.General.Keyboard.Gen_Labels[vi].SetBounds(10 + (140 * vl), vk, 200, 24);
    mainScene.Config.Main.R.General.Keyboard.Gen_Labels[vi].Text := cGen_Labels[vi];
    mainScene.Config.Main.R.General.Keyboard.Gen_Labels[vi].Visible := True;

    mainScene.Config.Main.R.General.Keyboard.Gen_Panels[vi] := TRectangle.Create(mainScene.Config.Main.R.General.Keyboard.TabItems[0]);
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels[vi].Name := 'Main_Config_General_Keyboard_General_Panel_' + vi.ToString;
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels[vi].Parent := mainScene.Config.Main.R.General.Keyboard.TabItems[0];
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels[vi].SetBounds(10 + (140 * vl), vk + 22, 120, 24);
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels[vi].Fill.Kind := TBrushKind.Solid;
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels[vi].Fill.Color := TAlphaColorRec.Deepskyblue;
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels[vi].Stroke.Thickness := 1;
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels[vi].Stroke.Color := TAlphaColorRec.Blue;
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels[vi].Visible := True;

    mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi] := TText.Create(mainScene.Config.Main.R.General.Keyboard.Gen_Panels[vi]);
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].Name := 'Main_Config_General_Keyboard_General_Panel_Text_' + vi.ToString;
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].Parent := mainScene.Config.Main.R.General.Keyboard.Gen_Panels[vi];
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].Align := TAlignLayout.Client;
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].TextSettings.FontColor := TAlphaColorRec.White;
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].Text := 'Press Key ';
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].TextSettings.HorzAlign := TTextAlign.Center;
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].Font.Style := mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].Font.Style +
      [TFontStyle.fsBold];
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].OnClick := ex_main.Input.mouse_config.Text.OnMouseClick;
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].OnMouseEnter := ex_main.Input.mouse_config.Text.OnMouseEnter;
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].OnMouseLeave := ex_main.Input.mouse_config.Text.OnMouseLeave;
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].Tag := vi;
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].Visible := True;

    Inc(vl, 1);
    if vl = 4 then
    begin
      vl := 0;
      vk := vk + 130;
    end;
  end;

  { Emulators }
  vl := 0;
  vk := 20;
  for vi := 0 to 11 do
  begin
    mainScene.Config.Main.R.General.Keyboard.Emu_Labels[vi] := TLabel.Create(mainScene.Config.Main.R.General.Keyboard.TabItems[1]);
    mainScene.Config.Main.R.General.Keyboard.Emu_Labels[vi].Name := 'Main_Config_General_Keyboard_Emu_Label_' + vi.ToString;
    mainScene.Config.Main.R.General.Keyboard.Emu_Labels[vi].Parent := mainScene.Config.Main.R.General.Keyboard.TabItems[1];
    mainScene.Config.Main.R.General.Keyboard.Emu_Labels[vi].SetBounds(10 + (140 * vl), vk, 200, 24);
    mainScene.Config.Main.R.General.Keyboard.Emu_Labels[vi].Text := cEmu_Labels[vi];
    mainScene.Config.Main.R.General.Keyboard.Emu_Labels[vi].Visible := True;

    mainScene.Config.Main.R.General.Keyboard.Emu_Panels[vi] := TRectangle.Create(mainScene.Config.Main.R.General.Keyboard.TabItems[1]);
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels[vi].Name := 'Main_Config_General_Keyboard_Emu_Panel_' + vi.ToString;
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels[vi].Parent := mainScene.Config.Main.R.General.Keyboard.TabItems[1];
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels[vi].SetBounds(10 + (140 * vl), vk + 22, 120, 24);
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels[vi].Fill.Kind := TBrushKind.Solid;
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels[vi].Fill.Color := TAlphaColorRec.Deepskyblue;
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels[vi].Stroke.Thickness := 1;
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels[vi].Stroke.Color := TAlphaColorRec.Blue;
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels[vi].Visible := True;

    mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi] := TText.Create(mainScene.Config.Main.R.General.Keyboard.Emu_Panels[vi]);
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Name := 'Main_Config_General_Keyboard_Emu_Panel_Text_' + vi.ToString;
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Parent := mainScene.Config.Main.R.General.Keyboard.Emu_Panels[vi];
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Align := TAlignLayout.Client;
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].TextSettings.FontColor := TAlphaColorRec.White;
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Text := 'Press Key ';
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].TextSettings.HorzAlign := TTextAlign.Center;
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Font.Style := mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Font.Style +
      [TFontStyle.fsBold];
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].OnClick := ex_main.Input.mouse_config.Text.OnMouseClick;
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].OnMouseEnter := ex_main.Input.mouse_config.Text.OnMouseEnter;
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].OnMouseLeave := ex_main.Input.mouse_config.Text.OnMouseLeave;
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Tag := vi;
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Visible := True;

    Inc(vl, 1);
    if vl = 4 then
    begin
      vl := 0;
      vk := vk + 130;
    end;
  end;

end;

procedure Click_To_Accept_Key;
begin
  if vSelected_Tab = 0 then
  begin
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vSelected_Label].Text := 'Waiting ...';
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vSelected_Label].TextSettings.FontColor := TAlphaColorRec.White;
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels[vSelected_Label].Fill.Color := TAlphaColorRec.Black;
  end
  else
  begin
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vSelected_Label].Text := 'Waiting ...';
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vSelected_Label].TextSettings.FontColor := TAlphaColorRec.White;
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels[vSelected_Label].Fill.Color := TAlphaColorRec.Black;
  end;

  vSelected_Timer := TTimer.Create(mainScene.Config.Main.R.General.Keyboard.Image);
  vSelected_Timer.Name := 'Main_Config_General_Keyboard_Timer';
  vSelected_Timer.Parent := mainScene.Config.Main.R.General.Keyboard.Image;
  vSelected_Timer.Interval := 500;
  vSelected_Timer.OnTimer := vTimer.OnTimer;
  vSelected_Timer.Enabled := True;

  vTimes := 0;
  vDots := 2;
  vKey_Waiting := True;
end;

procedure Save_To_Database(vKey: String);
begin
  if vSelected_Tab = 0 then
  begin
    case vSelected_Label of
      0:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'up', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
      1:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'down', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
      2:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'left', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
      3:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'right', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
      4:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'enter', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
      5:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'esc', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
      6:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'config', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
    end;
  end
  else
  begin
    case vSelected_Label of
      0:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_up', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
      1:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_down', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
      2:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_left', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
      3:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_right', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
      4:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_action', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
      5:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_back', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
      6:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_favorite', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
      7:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_addfavorite', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
      8:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_lists', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
      9:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_search', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
      10:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_filters', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
      11:
        uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_config', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
    end;
  end;
end;

procedure Set_Key(vKey: String);
begin
  if vSelected_Tab = 0 then
  begin
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vSelected_Label].Text := vKey;
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vSelected_Label].TextSettings.FontColor := TAlphaColorRec.White;
    mainScene.Config.Main.R.General.Keyboard.Gen_Panels[vSelected_Label].Fill.Color := TAlphaColorRec.Deepskyblue;
  end
  else
  begin
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vSelected_Label].Text := vKey;
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vSelected_Label].TextSettings.FontColor := TAlphaColorRec.White;
    mainScene.Config.Main.R.General.Keyboard.Emu_Panels[vSelected_Label].Fill.Color := TAlphaColorRec.Deepskyblue;
  end;
  Save_To_Database(vKey);
  vKey_Waiting := False;
  FreeAndNil(vSelected_Timer);
end;

{ TKEYBOARD_TIMER }

procedure TKEYBOARD_TIMER.OnTimer(Sender: TObject);
var
  vPhrase: String;
begin
  if vTimes < 5 then
  begin
    Inc(vDots, 1);
    case vDots of
      0:
        vPhrase := 'Waiting';
      1:
        vPhrase := 'Waiting .';
      2:
        vPhrase := 'Waiting ..';
      3:
        begin
          vPhrase := 'Waiting ...';
          vDots := -1;
          Inc(vTimes, 1);
        end;
    end;

    if vSelected_Tab = 0 then
      mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vSelected_Label].Text := vPhrase
    else
      mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vSelected_Label].Text := vPhrase;
  end
  else
  begin
    if vSelected_Tab = 0 then
    begin
      mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vSelected_Label].Text := 'Press Key';
      mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vSelected_Label].TextSettings.FontColor := TAlphaColorRec.White;
      mainScene.Config.Main.R.General.Keyboard.Gen_Panels[vSelected_Label].Fill.Color := TAlphaColorRec.Deepskyblue;
    end
    else
    begin
      mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vSelected_Label].Text := 'Press Key';
      mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vSelected_Label].TextSettings.FontColor := TAlphaColorRec.White;
      mainScene.Config.Main.R.General.Keyboard.Emu_Panels[vSelected_Label].Fill.Color := TAlphaColorRec.Deepskyblue;
    end;
    vKey_Waiting := False;
    FreeAndNil(vSelected_Timer);
  end;
end;

initialization

vTimer := TKEYBOARD_TIMER.Create;

finalization

vTimer.Free;

end.
