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
  vBefore_Text: String;

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
  cGen_Labels: array [0 .. 6] of string = ('MOVE UP', 'MOVE DOWN', 'MOVE LEFT', 'MOVE RIGHT', 'ACTION', 'ESCAPE', 'CONFIGURATION');
  cEmu_Labels: array [0 .. 12] of string = ('MOVE UP', 'MOVE DOWN', 'MOVE LEFT', 'MOVE RIGHT', 'ACTION', 'ESCAPE', 'FAVORITE LIST', 'ADD FAVORITE',
    'LISTS PANEL', 'FILTERS PANEL', 'SEARCH', 'SCREEN SAVER', 'CONFIGURATION');
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

  { Main }
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
    case vi of
      0:
        mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Up;
      1:
        mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Down;
      2:
        mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Left;
      3:
        mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Right;
      4:
        mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Action;
      5:
        mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Escape;
      6:
        mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Config;
    end;
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
  for vi := 0 to 12 do
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
    case vi of
      0:
        mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Emu_Up;
      1:
        mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Emu_Down;
      2:
        mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Emu_Left;
      3:
        mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Emu_Right;
      4:
        mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Emu_Action;
      5:
        mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Emu_Escape;
      6:
        mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Emu_Favorite;
      7:
        mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Emu_FavoriteAdd;
      8:
        mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Emu_Lists;
      9:
        mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Emu_Search;
      10:
        mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Emu_Filters;
      11:
        mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Emu_ScreenSaver;
      12:
        mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vi].Text := uDB_AUser.Local.MAP.Keyboard.Emu_Config;
    end;
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
  if UpperCase(vKey) = 'LEFT' then
    vKey := 'LEFT_ARROW'
  else if UpperCase(vKey) = 'RIGHT' then
    vKey := 'RIGHT_ARROW'
  else if UpperCase(vKey) = 'UP' then
    vKey := 'UP_ARROW'
  else if UpperCase(vKey) = 'DOWN' then
    vKey := 'DOWN_ARROW'
  else
    vKey := UpperCase(vKey);

  if vSelected_Tab = 0 then
  begin
    case vSelected_Label of
      0:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'main_up', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Up := vKey;
        end;
      1:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'main_down', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Down := vKey;
        end;
      2:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'main_left', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Left := vKey;
        end;
      3:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'main_right', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Right := vKey;
        end;
      4:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'main_action', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Action := vKey;
        end;
      5:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'main_esc', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Escape := vKey;
        end;
      6:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'main_config', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Config := vKey;
        end;
    end;
  end
  else
  begin
    case vSelected_Label of
      0:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_up', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Emu_Up := vKey;
        end;
      1:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_down', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Emu_Down := vKey;
        end;
      2:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_left', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Emu_Left := vKey;
        end;
      3:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_right', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Emu_Right := vKey;
        end;
      4:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_action', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Emu_Action := vKey;
        end;
      5:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_esc', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Emu_Escape := vKey;
        end;
      6:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_fav', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Emu_Favorite := vKey;
        end;
      7:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_addfav', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Emu_FavoriteAdd := vKey;
        end;
      8:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_lists', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Emu_Lists := vKey;
        end;
      9:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_search', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Emu_Search := vKey;
        end;
      10:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_filters', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Emu_Filters := vKey;
        end;
      11:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_screensaver', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Emu_ScreenSaver := vKey;
        end;
      12:
        begin
          uDB.Query_Update(uDB.ExtraFE_Query_Local, 'map_keyboard', 'emu_config', vKey, 'user_id', uDB_AUser.Local.USER.Num.ToString);
          uDB_AUser.Local.MAP.Keyboard.Emu_Config := vKey;
        end;
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
      mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vSelected_Label].Text := vBefore_Text;
      mainScene.Config.Main.R.General.Keyboard.Gen_Panels_Text[vSelected_Label].TextSettings.FontColor := TAlphaColorRec.White;
      mainScene.Config.Main.R.General.Keyboard.Gen_Panels[vSelected_Label].Fill.Color := TAlphaColorRec.Deepskyblue;
    end
    else if vSelected_Tab = 1 then         
    begin
      mainScene.Config.Main.R.General.Keyboard.Emu_Panels_Text[vSelected_Label].Text := vBefore_Text;
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
