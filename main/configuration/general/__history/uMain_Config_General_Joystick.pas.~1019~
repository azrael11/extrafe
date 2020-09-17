unit uMain_Config_General_Joystick;

interface

uses
  System.Classes,
  System.UITypes,
  System.SysUtils,
  System.StrUtils,
  FMX.StdCtrls,
  FMX.Listbox,
  FMX.Objects,
  FMX.Graphics,
  FMX.TabControl,
  FMX.Types,
  FMX.Layouts,
  uJoystick_mmsystem,
  DirectInput;

type
  TJOYSTICK_GENERAL_MMSYSTEM_TIMER = class
    procedure OnTimer(Sender: TObject);
  end;

procedure Load;

procedure Move(vAction: String);
procedure Button_Down(myButtons: TJoyButtons);
procedure Button_Up(myButtons: TJoyButtons);

procedure Show_Options(vButtons: Boolean; vInfo: String);

procedure Set_Value_To_Database(vKey, vValue: String; vJoy_Num: Integer);

procedure Create_DirectX_Input;
procedure Create_XInput;

procedure UpDate_Info(vName, TagName: String; vType, vKind_Type: Integer);
procedure Remove_Info(vName, TagName: String; vType, vKind_Type: Integer);

procedure Refresh_Direct_Input_Joy(vType: Integer);
procedure Refresh_XInput_Joy(vType: Integer);

var
  vSelect_List: array [0 .. 1] of TListBoxItem;
  vJoy_Mapping: Boolean;

  vJoy_List: array [0 .. 2] of TListBoxItem;

  vJoy_mm_1: TMMJoystick;
  vJoy_mm_2: TMMJoystick;

  vSelected: Integer;
  vSelected_joy_Type: Integer;
  vSelected_joy_Tab: Integer;
  vSelected_joy_Timer: TTimer;
  vSelected_joy_label: String;
  vDots_joy: Integer;
  vTimes_joy: Integer;
  vTimer_Joy: TJOYSTICK_GENERAL_MMSYSTEM_TIMER;

implementation

uses
  uDB,
  uDB_AUser,
  main,
  uLoad_AllTypes,
  uMain_AllTypes,
  uMain_Config_General_Joystick_MMSystem;

procedure Load;
const
  cItem_Names: array [0 .. 2] of String = ('Type MMSystem', 'Type Direct Input', 'Type XIpnut');
var
  vI: Integer;
begin
  extrafe.prog.State := 'main_config_general_joystick_mmsystem';

  vJoy_Mapping := False;
  mainScene.Config.main.R.General.Joystick.Image := TImage.Create(mainScene.Config.main.R.General.Tab_Item[4]);
  mainScene.Config.main.R.General.Joystick.Image.Name := 'Main_Config_General_Joystick_Image';
  mainScene.Config.main.R.General.Joystick.Image.Parent := mainScene.Config.main.R.General.Tab_Item[4];
  mainScene.Config.main.R.General.Joystick.Image.Bitmap.LoadFromFile(ex_main.Paths.Config_Images + 'general\joystick.png');
  mainScene.Config.main.R.General.Joystick.Image.SetBounds(mainScene.Config.main.R.General.Contol.Width - 76, 6, 56, 56);
  mainScene.Config.main.R.General.Joystick.Image.WrapMode := TImageWrapMode.Stretch;
  mainScene.Config.main.R.General.Joystick.Image.Visible := True;

  mainScene.Config.main.R.General.Joystick.Panel := TPanel.Create(mainScene.Config.main.R.General.Tab_Item[4]);
  mainScene.Config.main.R.General.Joystick.Panel.Name := 'Main_Config_General_Joystick_Panel';
  mainScene.Config.main.R.General.Joystick.Panel.Parent := mainScene.Config.main.R.General.Tab_Item[4];
  mainScene.Config.main.R.General.Joystick.Panel.SetBounds(10, 66, mainScene.Config.main.R.General.Contol.Width - 20,
    mainScene.Config.main.R.General.Contol.Height - 100);
  mainScene.Config.main.R.General.Joystick.Panel.Visible := True;

  mainScene.Config.main.R.General.Joystick.Control := TTabControl.Create(mainScene.Config.main.R.General.Joystick.Panel);
  mainScene.Config.main.R.General.Joystick.Control.Name := 'Main_Config_General_Joystick_Control';
  mainScene.Config.main.R.General.Joystick.Control.Parent := mainScene.Config.main.R.General.Joystick.Panel;
  mainScene.Config.main.R.General.Joystick.Control.Align := TAlignLayout.Client;
  mainScene.Config.main.R.General.Joystick.Control.Visible := True;

  for vI := 0 to 2 do
  begin
    mainScene.Config.main.R.General.Joystick.Items[vI] := TTabItem.Create(mainScene.Config.main.R.General.Joystick.Control);
    mainScene.Config.main.R.General.Joystick.Items[vI].Name := 'Main_Config_General_Joystick_Item_' + vI.ToString;
    mainScene.Config.main.R.General.Joystick.Items[vI].Parent := mainScene.Config.main.R.General.Joystick.Control;
    mainScene.Config.main.R.General.Joystick.Items[vI].Text := cItem_Names[vI];
    mainScene.Config.main.R.General.Joystick.Items[vI].Visible := True;
  end;

  uMain_Config_General_Joystick_MMSystem.Create_MMSystem;
  Create_DirectX_Input;
  Create_XInput;
end;

{ Create DirextX Input }
procedure Create_DirectX_Input;
begin

end;

{ Create XInput }
procedure Create_XInput;
begin

end;

procedure UpDate_Info(vName, TagName: String; vType, vKind_Type: Integer);

  function Get_State_From_Database(vName: String; vType, vKind_Type: Integer): String;
  var
    vTable_Name: String;
    vCol_Name: String;
  begin
    case vType of
      0:
        vTable_Name := 'map_joystick_mmsystem';
      1:
        vTable_Name := 'map_joystick_direct_input';
      2:
        vTable_Name := 'map_joystick_xinput';
    end;

    vCol_Name := LowerCase(vName);
    if not AnsiMatchStr(vCol_Name, ['up', 'down', 'left', 'right']) then
    begin
      vCol_Name := (vCol_Name.ToInteger + 1).ToString;
      if vKind_Type = 0 then
        vCol_Name := 'button_' + vCol_Name
      else if vKind_Type = 1 then
        vCol_Name := 'emu_button_' + vCol_Name;
    end
    else
    begin
      if vKind_Type = 0 then
        vCol_Name := vName
      else if vKind_Type = 1 then
        vCol_Name := 'emu_' + vName;

    end;

    uDB.ExtraFE_Query_Local.Close;
    uDB.ExtraFE_Query_Local.SQL.Clear;
    uDB.ExtraFE_Query_Local.SQL.Text := 'SELECT ' + vCol_Name + ' FROM ' + vTable_Name + ' WHERE user_id="' + uDB_AUser.Local.USER.Num.ToString + '"';
    uDB.ExtraFE_Query_Local.Open;

    Result := uDB.ExtraFE_Query_Local.Fields[0].AsString;
    if Result = '' then
      Result := 'Not Defined';
  end;

var
  vText: String;
  vComp: TComponent;
  vState: Boolean;
begin
  vState := False;
  case vType of
    0:
      begin
        case vKind_Type of
          0:
            begin
              if AnsiMatchStr(TagName, ['UP', 'DOWN', 'LEFT', 'RIGHT']) then
              begin
                vComp := mainScene.Config.main.R.General.Joystick.Generic.General.Layout.FindComponent('Main_Config_General_Joystick_MMSystem_Generic_'
                  + TagName);
                if TRectangle(vComp).Fill.Color <> TAlphaColorRec.Grey then
                  vState := True;
              end
              else
              begin
                vComp := mainScene.Config.main.R.General.Joystick.Generic.General.Layout.FindComponent
                  ('Main_Config_General_Joystick_MMSystem_Generic_Button_' + vName);
                if TCircle(vComp).Fill.Color <> TAlphaColorRec.Grey then
                  vState := True;
              end;
              if vState then
              begin
                if AnsiMatchStr(TagName, ['UP', 'DOWN', 'LEFT', 'RIGHT']) then
                  TRectangle(vComp).Fill.Color := TAlphaColorRec.Red
                else
                  TCircle(vComp).Fill.Color := TAlphaColorRec.Red;

                if AnsiMatchStr(TagName, ['UP', 'DOWN', 'LEFT', 'RIGHT']) then
                  vText := Get_State_From_Database(TagName, vType, vKind_Type)
                else
                  vText := Get_State_From_Database(vName, vType, vKind_Type);
                if vText = 'Not Defined' then
                  vText := 'This Key is "' + vText + '"'
                else
                  vText := 'This key is defined as "' + vText + '"';
                mainScene.Config.main.R.General.Joystick.Generic.General.Info_Current.Text := vText;
                mainScene.Config.main.R.General.Joystick.Generic.General.Info_Current.Visible := True;
                mainScene.Config.main.R.General.Joystick.Generic.General.Info_Standard.Visible := True;
              end;
            end;
          1:
            begin
              if AnsiMatchStr(TagName, ['UP', 'DOWN', 'LEFT', 'RIGHT']) then
              begin
                vComp := mainScene.Config.main.R.General.Joystick.Generic.Emulators.Layout.FindComponent
                  ('Main_Config_General_Joystick_MMSystem_Generic_Emulators_' + TagName);
                if TRectangle(vComp).Fill.Color <> TAlphaColorRec.Grey then
                  vState := True;
              end
              else
              begin
                vComp := mainScene.Config.main.R.General.Joystick.Generic.Emulators.Layout.FindComponent
                  ('Main_Config_General_Joystick_MMSystem_Generic_Emulators_Button_' + vName);
                if TCircle(vComp).Fill.Color <> TAlphaColorRec.Grey then
                  vState := True;
              end;
              if vState then
              begin
                if AnsiMatchStr(TagName, ['UP', 'DOWN', 'LEFT', 'RIGHT']) then
                  TRectangle(vComp).Fill.Color := TAlphaColorRec.Red
                else
                  TCircle(vComp).Fill.Color := TAlphaColorRec.Red;

                if AnsiMatchStr(TagName, ['UP', 'DOWN', 'LEFT', 'RIGHT']) then
                  vText := Get_State_From_Database(TagName, vType, vKind_Type)
                else
                  vText := Get_State_From_Database(vName, vType, vKind_Type);
                if vText = 'Not Defined' then
                  vText := 'This Key is "' + vText + '"'
                else
                  vText := 'This key is defined as "' + vText + '"';
                mainScene.Config.main.R.General.Joystick.Generic.Emulators.Info_Current.Text := vText;
                mainScene.Config.main.R.General.Joystick.Generic.Emulators.Info_Current.Visible := True;
                mainScene.Config.main.R.General.Joystick.Generic.Emulators.Info_Standard.Visible := True;
              end;
            end;
        end;
      end;
  end;
end;

procedure Remove_Info(vName, TagName: String; vType, vKind_Type: Integer);
var
  vComp: TComponent;
  vState: Boolean;
begin
  vState := False;
  case vType of
    0:
      begin
        case vKind_Type of
          0:
            begin
              if AnsiMatchStr(TagName, ['UP', 'DOWN', 'LEFT', 'RIGHT']) then
              begin
                vComp := mainScene.Config.main.R.General.Joystick.Generic.General.Layout.FindComponent('Main_Config_General_Joystick_MMSystem_Generic_'
                  + TagName);
                if TRectangle(vComp).Fill.Color <> TAlphaColorRec.Grey then
                  vState := True;
              end
              else
              begin
                vComp := mainScene.Config.main.R.General.Joystick.Generic.General.Layout.FindComponent
                  ('Main_Config_General_Joystick_MMSystem_Generic_Button_' + vName);
                if TCircle(vComp).Fill.Color <> TAlphaColorRec.Grey then
                  vState := True;
              end;
              if vState then
              begin
                if AnsiMatchStr(TagName, ['UP', 'DOWN', 'LEFT', 'RIGHT']) then
                  TRectangle(vComp).Fill.Color := TAlphaColorRec.Deepskyblue
                else
                  TCircle(vComp).Fill.Color := TAlphaColorRec.Deepskyblue;
              end;
              mainScene.Config.main.R.General.Joystick.Generic.General.Info_Current.Text := '';;
              mainScene.Config.main.R.General.Joystick.Generic.General.Info_Current.Visible := False;
              mainScene.Config.main.R.General.Joystick.Generic.General.Info_Standard.Visible := False;
            end;
          1:
            begin
              if AnsiMatchStr(TagName, ['UP', 'DOWN', 'LEFT', 'RIGHT']) then
              begin
                vComp := mainScene.Config.main.R.General.Joystick.Generic.Emulators.Layout.FindComponent
                  ('Main_Config_General_Joystick_MMSystem_Generic_Emulators_' + TagName);
                if TRectangle(vComp).Fill.Color <> TAlphaColorRec.Grey then
                  vState := True;
              end
              else
              begin
                vComp := mainScene.Config.main.R.General.Joystick.Generic.Emulators.Layout.FindComponent
                  ('Main_Config_General_Joystick_MMSystem_Generic_Emulators_Button_' + vName);
                if TCircle(vComp).Fill.Color <> TAlphaColorRec.Grey then
                  vState := True;
              end;
              if vState then
              begin
                if AnsiMatchStr(TagName, ['UP', 'DOWN', 'LEFT', 'RIGHT']) then
                  TRectangle(vComp).Fill.Color := TAlphaColorRec.Deepskyblue
                else
                  TCircle(vComp).Fill.Color := TAlphaColorRec.Deepskyblue;
              end;
              mainScene.Config.main.R.General.Joystick.Generic.Emulators.Info_Current.Text := '';;
              mainScene.Config.main.R.General.Joystick.Generic.Emulators.Info_Current.Visible := False;
              mainScene.Config.main.R.General.Joystick.Generic.Emulators.Info_Standard.Visible := False;
            end;
        end;
      end;
  end;
end;

procedure Refresh_Direct_Input_Joy(vType: Integer);
begin

end;

procedure Refresh_XInput_Joy(vType: Integer);
begin

end;

procedure Move(vAction: String);
begin
  if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 0) then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Top.Fill.Color := TAlphaColorRec.Deepskyblue;
    mainScene.Config.main.R.General.Joystick.Generic.General.Down.Fill.Color := TAlphaColorRec.Deepskyblue;
    mainScene.Config.main.R.General.Joystick.Generic.General.Left.Fill.Color := TAlphaColorRec.Deepskyblue;
    mainScene.Config.main.R.General.Joystick.Generic.General.Right.Fill.Color := TAlphaColorRec.Deepskyblue;
  end
  else if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 1) then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.Emulators.Top.Fill.Color := TAlphaColorRec.Deepskyblue;
    mainScene.Config.main.R.General.Joystick.Generic.Emulators.Down.Fill.Color := TAlphaColorRec.Deepskyblue;
    mainScene.Config.main.R.General.Joystick.Generic.Emulators.Left.Fill.Color := TAlphaColorRec.Deepskyblue;
    mainScene.Config.main.R.General.Joystick.Generic.Emulators.Right.Fill.Color := TAlphaColorRec.Deepskyblue;
  end;

  if vAction = 'center' then
  begin
    if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 0) then
      mainScene.Config.main.R.General.Joystick.Generic.General.Place_dot.SetBounds(62, 62, 16, 16)
    else if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 1) then
      mainScene.Config.main.R.General.Joystick.Generic.Emulators.Place_dot.SetBounds(62, 62, 16, 16)
  end
  else if vAction = 'up_left' then
  begin
    if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 0) then
    begin
      if (uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.General.Up <> '') and (uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.General.Left <> '') then
      begin
        mainScene.Config.main.R.General.Joystick.Generic.General.Place_dot.SetBounds(18, 18, 16, 16);
        mainScene.Config.main.R.General.Joystick.Generic.General.Top.Fill.Color := TAlphaColorRec.Red;
        mainScene.Config.main.R.General.Joystick.Generic.General.Left.Fill.Color := TAlphaColorRec.Red;
      end
    end
    else if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 1) then
    begin
      if (uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Up <> '') and (uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Left <> '') then
      begin
        mainScene.Config.main.R.General.Joystick.Generic.Emulators.Place_dot.SetBounds(18, 18, 16, 16);
        mainScene.Config.main.R.General.Joystick.Generic.Emulators.Top.Fill.Color := TAlphaColorRec.Red;
        mainScene.Config.main.R.General.Joystick.Generic.Emulators.Left.Fill.Color := TAlphaColorRec.Red;
      end;
    end
  end
  else if vAction = 'down_left' then
  begin
    if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 0) then
    begin
      if (uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.General.Down <> '') and (uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.General.Left <> '') then
      begin
        mainScene.Config.main.R.General.Joystick.Generic.General.Place_dot.SetBounds(18, 106, 16, 16);
        mainScene.Config.main.R.General.Joystick.Generic.General.Down.Fill.Color := TAlphaColorRec.Red;
        mainScene.Config.main.R.General.Joystick.Generic.General.Left.Fill.Color := TAlphaColorRec.Red;
      end;
    end
    else if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 1) then
    begin
      if (uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Down <> '') and (uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Left <> '') then
      begin
        mainScene.Config.main.R.General.Joystick.Generic.Emulators.Place_dot.SetBounds(18, 106, 16, 16);
        mainScene.Config.main.R.General.Joystick.Generic.Emulators.Down.Fill.Color := TAlphaColorRec.Red;
        mainScene.Config.main.R.General.Joystick.Generic.Emulators.Left.Fill.Color := TAlphaColorRec.Red;
      end;
    end;
  end
  else if vAction = 'up_right' then
  begin
    if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 0) then
    begin
      if (uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.General.Up <> '') and (uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.General.Right <> '') then
      begin
        mainScene.Config.main.R.General.Joystick.Generic.General.Place_dot.SetBounds(106, 18, 16, 16);
        mainScene.Config.main.R.General.Joystick.Generic.General.Top.Fill.Color := TAlphaColorRec.Red;
        mainScene.Config.main.R.General.Joystick.Generic.General.Right.Fill.Color := TAlphaColorRec.Red;
      end;
    end
    else if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 1) then
    begin
      if (uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Up <> '') and (uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Right <> '') then
      begin
        mainScene.Config.main.R.General.Joystick.Generic.Emulators.Place_dot.SetBounds(106, 18, 16, 16);
        mainScene.Config.main.R.General.Joystick.Generic.Emulators.Top.Fill.Color := TAlphaColorRec.Red;
        mainScene.Config.main.R.General.Joystick.Generic.Emulators.Right.Fill.Color := TAlphaColorRec.Red;
      end;
    end;
  end
  else if vAction = 'down_right' then
  begin
    if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 0) then
    begin
      if (uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.General.Down <> '') and (uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.General.Right <> '') then
      begin
        mainScene.Config.main.R.General.Joystick.Generic.General.Place_dot.SetBounds(106, 106, 16, 16);
        mainScene.Config.main.R.General.Joystick.Generic.General.Down.Fill.Color := TAlphaColorRec.Red;
        mainScene.Config.main.R.General.Joystick.Generic.General.Right.Fill.Color := TAlphaColorRec.Red;
      end;
    end
    else if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 1) then
    begin
      if (uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Down <> '') and (uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Right <> '') then
      begin
        mainScene.Config.main.R.General.Joystick.Generic.Emulators.Place_dot.SetBounds(106, 106, 16, 16);
        mainScene.Config.main.R.General.Joystick.Generic.Emulators.Down.Fill.Color := TAlphaColorRec.Red;
        mainScene.Config.main.R.General.Joystick.Generic.Emulators.Right.Fill.Color := TAlphaColorRec.Red;
      end;
    end;
  end
  else if vAction = 'up' then
  begin
    if uMain_Config_General_Joystick.vJoy_Mapping then
    begin
      Set_Value_To_Database(uMain_Config_General_Joystick.vSelected_joy_label, 'up', 1)
    end
    else
    begin
      if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 0) then
      begin
        if uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.General.Up <> '' then
        begin
          mainScene.Config.main.R.General.Joystick.Generic.General.Place_dot.SetBounds(62, 0, 16, 16);
          mainScene.Config.main.R.General.Joystick.Generic.General.Top.Fill.Color := TAlphaColorRec.Red;
        end;
      end
      else if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 1) then
      begin
        if uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Up <> '' then
        begin
          mainScene.Config.main.R.General.Joystick.Generic.Emulators.Place_dot.SetBounds(62, 0, 16, 16);
          mainScene.Config.main.R.General.Joystick.Generic.Emulators.Top.Fill.Color := TAlphaColorRec.Red;
        end;
      end;
    end;
  end
  else if vAction = 'down' then
  begin
    if uMain_Config_General_Joystick.vJoy_Mapping then
    begin
      Set_Value_To_Database(uMain_Config_General_Joystick.vSelected_joy_label, 'down', 1)
    end
    else
    begin
      if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 0) then
      begin
        if uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.General.Down <> '' then
        begin
          mainScene.Config.main.R.General.Joystick.Generic.General.Place_dot.SetBounds(62, 124, 16, 16);
          mainScene.Config.main.R.General.Joystick.Generic.General.Down.Fill.Color := TAlphaColorRec.Red;
        end;
      end
      else if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 1) then
      begin
        if uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Down <> '' then
        begin
          mainScene.Config.main.R.General.Joystick.Generic.Emulators.Place_dot.SetBounds(62, 124, 16, 16);
          mainScene.Config.main.R.General.Joystick.Generic.Emulators.Down.Fill.Color := TAlphaColorRec.Red;
        end;
      end;
    end;
  end
  else if vAction = 'left' then
  begin
    if uMain_Config_General_Joystick.vJoy_Mapping then
    begin
      Set_Value_To_Database(uMain_Config_General_Joystick.vSelected_joy_label, 'left', 1)
    end
    else
    begin
      if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 0) then
      begin
        if uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.General.Left <> '' then
        begin
          mainScene.Config.main.R.General.Joystick.Generic.General.Place_dot.SetBounds(0, 62, 16, 16);
          mainScene.Config.main.R.General.Joystick.Generic.General.Left.Fill.Color := TAlphaColorRec.Red;
        end;
      end
      else if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 1) then
      begin
        if uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Left <> '' then
        begin
          mainScene.Config.main.R.General.Joystick.Generic.Emulators.Place_dot.SetBounds(0, 62, 16, 16);
          mainScene.Config.main.R.General.Joystick.Generic.Emulators.Left.Fill.Color := TAlphaColorRec.Red;
        end;
      end;
    end;
  end
  else if vAction = 'right' then
  begin
    if uMain_Config_General_Joystick.vJoy_Mapping then
    begin
      Set_Value_To_Database(uMain_Config_General_Joystick.vSelected_joy_label, 'right', 1)
    end
    else
    begin
      if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 0) then
      begin
        if uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.General.Right <> '' then
        begin
          mainScene.Config.main.R.General.Joystick.Generic.General.Place_dot.SetBounds(124, 62, 16, 16);
          mainScene.Config.main.R.General.Joystick.Generic.General.Right.Fill.Color := TAlphaColorRec.Red;
        end;
      end
      else if (uMain_Config_General_Joystick.vSelected_joy_Type = 0) and (uMain_Config_General_Joystick.vSelected_joy_Tab = 1) then
      begin
        if uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Right <> '' then
        begin
          mainScene.Config.main.R.General.Joystick.Generic.Emulators.Place_dot.SetBounds(124, 62, 16, 16);
          mainScene.Config.main.R.General.Joystick.Generic.Emulators.Right.Fill.Color := TAlphaColorRec.Red;
        end;
      end;
    end;
  end;
end;

procedure Button_Down(myButtons: TJoyButtons);
var
  vName: String;
begin
  if uJoystick_mmsystem.TJoyButton.JoyBtn1 in myButtons then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[0].Fill.Color := TAlphaColorRec.Red;
    vName := '0';
  end;
  if uJoystick_mmsystem.TJoyButton.JoyBtn2 in myButtons then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[1].Fill.Color := TAlphaColorRec.Red;
    vName := '1';
  end;
  if uJoystick_mmsystem.TJoyButton.JoyBtn3 in myButtons then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[2].Fill.Color := TAlphaColorRec.Red;
    vName := '2';
  end;
  if uJoystick_mmsystem.TJoyButton.JoyBtn4 in myButtons then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[3].Fill.Color := TAlphaColorRec.Red;
    vName := '3';
  end;
  if uJoystick_mmsystem.TJoyButton.JoyBtn5 in myButtons then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[4].Fill.Color := TAlphaColorRec.Red;
    vName := '4';
  end;
  if uJoystick_mmsystem.TJoyButton.JoyBtn6 in myButtons then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[5].Fill.Color := TAlphaColorRec.Red;
    vName := '5';
  end;
  if uJoystick_mmsystem.TJoyButton.JoyBtn7 in myButtons then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[6].Fill.Color := TAlphaColorRec.Red;
    vName := '6';
  end;
  if uJoystick_mmsystem.TJoyButton.JoyBtn8 in myButtons then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[7].Fill.Color := TAlphaColorRec.Red;
    vName := '7';
  end;
  if uJoystick_mmsystem.TJoyButton.JoyBtn9 in myButtons then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[8].Fill.Color := TAlphaColorRec.Red;
    vName := '8';
  end;
  if uJoystick_mmsystem.TJoyButton.JoyBtn10 in myButtons then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[9].Fill.Color := TAlphaColorRec.Red;
    vName := '9';
  end;
  if uJoystick_mmsystem.TJoyButton.JoyBtn11 in myButtons then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[10].Fill.Color := TAlphaColorRec.Red;
    vName := '10';
  end;
  if uJoystick_mmsystem.TJoyButton.JoyBtn12 in myButtons then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[11].Fill.Color := TAlphaColorRec.Red;
    vName := '11';
  end;
  if uJoystick_mmsystem.TJoyButton.JoyBtn13 in myButtons then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[12].Fill.Color := TAlphaColorRec.Red;
    vName := '12';
  end;
  if uJoystick_mmsystem.TJoyButton.JoyBtn14 in myButtons then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[13].Fill.Color := TAlphaColorRec.Red;
    vName := '13';
  end;
  if uJoystick_mmsystem.TJoyButton.JoyBtn15 in myButtons then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[14].Fill.Color := TAlphaColorRec.Red;
    vName := '14';
  end;
  if uJoystick_mmsystem.TJoyButton.JoyBtn16 in myButtons then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[15].Fill.Color := TAlphaColorRec.Red;
    vName := '15';
  end;

  uMain_Config_General_Joystick.UpDate_Info(vName, vName, uMain_Config_General_Joystick.vSelected_joy_Type, uMain_Config_General_Joystick.vSelected_joy_Tab);
end;

procedure Button_Up(myButtons: TJoyButtons);
var
  vName: String;
begin
  if not(uJoystick_mmsystem.TJoyButton.JoyBtn1 in myButtons) then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[0].Fill.Color := TAlphaColorRec.Deepskyblue;
    vName := '0';
  end;
  if not(uJoystick_mmsystem.TJoyButton.JoyBtn2 in myButtons) then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[1].Fill.Color := TAlphaColorRec.Deepskyblue;
    vName := '1';
  end;
  if not(uJoystick_mmsystem.TJoyButton.JoyBtn3 in myButtons) then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[2].Fill.Color := TAlphaColorRec.Deepskyblue;
    vName := '2';
  end;
  if not(uJoystick_mmsystem.TJoyButton.JoyBtn4 in myButtons) then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[3].Fill.Color := TAlphaColorRec.Deepskyblue;
    vName := '3';
  end;
  if not(uJoystick_mmsystem.TJoyButton.JoyBtn5 in myButtons) then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[4].Fill.Color := TAlphaColorRec.Deepskyblue;
    vName := '4';
  end;
  if not(uJoystick_mmsystem.TJoyButton.JoyBtn6 in myButtons) then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[5].Fill.Color := TAlphaColorRec.Deepskyblue;
    vName := '5';
  end;
  if not(uJoystick_mmsystem.TJoyButton.JoyBtn7 in myButtons) then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[6].Fill.Color := TAlphaColorRec.Deepskyblue;
    vName := '6';
  end;
  if not(uJoystick_mmsystem.TJoyButton.JoyBtn8 in myButtons) then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[7].Fill.Color := TAlphaColorRec.Deepskyblue;
    vName := '7';
  end;
  if not(uJoystick_mmsystem.TJoyButton.JoyBtn9 in myButtons) then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[8].Fill.Color := TAlphaColorRec.Deepskyblue;
    vName := '8';
  end;
  if not(uJoystick_mmsystem.TJoyButton.JoyBtn10 in myButtons) then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[9].Fill.Color := TAlphaColorRec.Deepskyblue;
    vName := '9';
  end;
  if not(uJoystick_mmsystem.TJoyButton.JoyBtn11 in myButtons) then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[10].Fill.Color := TAlphaColorRec.Deepskyblue;
    vName := '10';
  end;
  if not(uJoystick_mmsystem.TJoyButton.JoyBtn12 in myButtons) then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[11].Fill.Color := TAlphaColorRec.Deepskyblue;
    vName := '11';
  end;
  if not(uJoystick_mmsystem.TJoyButton.JoyBtn13 in myButtons) then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[12].Fill.Color := TAlphaColorRec.Deepskyblue;
    vName := '12';
  end;
  if not(uJoystick_mmsystem.TJoyButton.JoyBtn14 in myButtons) then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[13].Fill.Color := TAlphaColorRec.Deepskyblue;
    vName := '13';
  end;
  if not(uJoystick_mmsystem.TJoyButton.JoyBtn15 in myButtons) then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[14].Fill.Color := TAlphaColorRec.Deepskyblue;
    vName := '14';
  end;
  if not(uJoystick_mmsystem.TJoyButton.JoyBtn16 in myButtons) then
  begin
    mainScene.Config.main.R.General.Joystick.Generic.General.Buttons[15].Fill.Color := TAlphaColorRec.Deepskyblue;
    vName := '15';
  end;
  uMain_Config_General_Joystick.Remove_Info(vName, vName, uMain_Config_General_Joystick.vSelected_joy_Type, uMain_Config_General_Joystick.vSelected_joy_Tab);

  { if uJoystick_MMSystem.TJoyButton.JoyBtn17 in myButtons then
    vAction := 'button_17';
    if uJoystick_MMSystem.TJoyButton.JoyBtn18 in myButtons then
    vAction := 'button_18';
    if uJoystick_MMSystem.TJoyButton.JoyBtn19 in myButtons then
    vAction := 'button_19';
    if uJoystick_MMSystem.TJoyButton.JoyBtn20 in myButtons then
    vAction := 'button_20';
    if uJoystick_MMSystem.TJoyButton.JoyBtn21 in myButtons then
    vAction := 'button_21';
    if uJoystick_MMSystem.TJoyButton.JoyBtn22 in myButtons then
    vAction := 'button_22';
    if uJoystick_MMSystem.TJoyButton.JoyBtn23 in myButtons then
    vAction := 'button_23';
    if uJoystick_MMSystem.TJoyButton.JoyBtn24 in myButtons then
    vAction := 'button_24';
    if uJoystick_MMSystem.TJoyButton.JoyBtn25 in myButtons then
    vAction := 'button_25';
    if uJoystick_MMSystem.TJoyButton.JoyBtn26 in myButtons then
    vAction := 'button_26';
    if uJoystick_MMSystem.TJoyButton.JoyBtn27 in myButtons then
    vAction := 'button_27';
    if uJoystick_MMSystem.TJoyButton.JoyBtn28 in myButtons then
    vAction := 'button_28';
    if uJoystick_MMSystem.TJoyButton.JoyBtn29 in myButtons then
    vAction := 'button_29';
    if uJoystick_MMSystem.TJoyButton.JoyBtn30 in myButtons then
    vAction := 'button_30';
    if uJoystick_MMSystem.TJoyButton.JoyBtn31 in myButtons then
    vAction := 'button_31';
    if uJoystick_MMSystem.TJoyButton.JoyBtn32 in myButtons then
    vAction := 'button_32'; }
end;

procedure Show_Options(vButtons: Boolean; vInfo: String);
const
  cItems: array [0 .. 2] of String = ('Action', 'Escape', 'Settings');
  cItems_Emu: array [0 .. 8] of String = ('Action', 'Escape', 'Settings', 'Search', 'Favorites', 'Add Favorite', 'Lists', 'Filters', 'Screensaver');
var
  vI: Integer;

  procedure Create_List(vNum: Integer; vText: String);
  begin
    mainScene.Config.main.R.General.Joystick.Options.VBox_Items[vNum] := TRectangle.Create(mainScene.Config.main.R.General.Joystick.Options.VBox);
    mainScene.Config.main.R.General.Joystick.Options.VBox_Items[vNum].Name := 'Main_Config_General_Joystick_MMSystem_Generic_General_Options_VBox_Item_' +
      vNum.ToString;
    mainScene.Config.main.R.General.Joystick.Options.VBox_Items[vNum].Parent := mainScene.Config.main.R.General.Joystick.Options.VBox;
    mainScene.Config.main.R.General.Joystick.Options.VBox_Items[vNum].SetBounds(0, 0 + (vI * 30),
      mainScene.Config.main.R.General.Joystick.Options.VBox.Width, 30);
    mainScene.Config.main.R.General.Joystick.Options.VBox_Items[vNum].Fill.Kind := TBrushKind.Solid;
    mainScene.Config.main.R.General.Joystick.Options.VBox_Items[vNum].Fill.Color := TAlphaColorRec.White;
    mainScene.Config.main.R.General.Joystick.Options.VBox_Items[vNum].Visible := True;

    mainScene.Config.main.R.General.Joystick.Options.VBox_Texts[vNum] := TText.Create(mainScene.Config.main.R.General.Joystick.Options.VBox_Items[vNum]);
    mainScene.Config.main.R.General.Joystick.Options.VBox_Texts[vNum].Name := 'Main_Config_General_Joystick_MMSystem_Generic_General_Options_VBox_Text_' +
      vI.ToString;
    mainScene.Config.main.R.General.Joystick.Options.VBox_Texts[vNum].Parent := mainScene.Config.main.R.General.Joystick.Options.VBox_Items[vNum];
    mainScene.Config.main.R.General.Joystick.Options.VBox_Texts[vNum].Align := TAlignLayout.Client;
    mainScene.Config.main.R.General.Joystick.Options.VBox_Texts[vNum].Font.Size := 20;
    mainScene.Config.main.R.General.Joystick.Options.VBox_Texts[vNum].TextSettings.FontColor := TAlphaColorRec.Black;
    mainScene.Config.main.R.General.Joystick.Options.VBox_Texts[vNum].Text := vText;
    mainScene.Config.main.R.General.Joystick.Options.VBox_Texts[vNum].Tag := vNum;
    mainScene.Config.main.R.General.Joystick.Options.VBox_Texts[vNum].OnClick := ex_main.Input.mouse_config.Text.OnMouseClick;
    mainScene.Config.main.R.General.Joystick.Options.VBox_Texts[vNum].OnMouseEnter := ex_main.Input.mouse_config.Text.OnMouseEnter;
    mainScene.Config.main.R.General.Joystick.Options.VBox_Texts[vNum].OnMouseLeave := ex_main.Input.mouse_config.Text.OnMouseLeave;
    mainScene.Config.main.R.General.Joystick.Options.VBox_Texts[vNum].Visible := True;
  end;

begin
  mainScene.Config.main.Left_Blur.Enabled := True;
  mainScene.Config.main.R.General.Blur.Enabled := True;

  mainScene.Config.main.R.General.Joystick.Options.Panel := TPanel.Create(mainScene.Config.main.Right);
  mainScene.Config.main.R.General.Joystick.Options.Panel.Name := 'Main_Config_General_Joystick_MMSystem_Generic_General_Options_Panel';
  mainScene.Config.main.R.General.Joystick.Options.Panel.Parent := mainScene.Config.main.Right;
  mainScene.Config.main.R.General.Joystick.Options.Panel.SetBounds(100, 50, 400, 450);
  mainScene.Config.main.R.General.Joystick.Options.Panel.Visible := True;

  CreateHeader(mainScene.Config.main.R.General.Joystick.Options.Panel, 'IcoMoon-Free', #$e979, TAlphaColorRec.Deepskyblue, 'Selecte an option', False, nil);

  mainScene.Config.main.R.General.Joystick.Options.main := TPanel.Create(mainScene.Config.main.R.General.Joystick.Options.Panel);
  mainScene.Config.main.R.General.Joystick.Options.main.Name := 'Main_Config_General_Joystick_MMSystem_Generic_General_Options_Main';
  mainScene.Config.main.R.General.Joystick.Options.main.Parent := mainScene.Config.main.R.General.Joystick.Options.Panel;
  mainScene.Config.main.R.General.Joystick.Options.main.SetBounds(0, 30, mainScene.Config.main.R.General.Joystick.Options.Panel.Width,
    mainScene.Config.main.R.General.Joystick.Options.Panel.Height - 30);
  mainScene.Config.main.R.General.Joystick.Options.main.Visible := True;

  mainScene.Config.main.R.General.Joystick.Options.Info := TText.Create(mainScene.Config.main.R.General.Joystick.Options.main);
  mainScene.Config.main.R.General.Joystick.Options.Info.Name := 'Main_Config_General_Joystick_MMSystem_Generic_General_Options_Info';
  mainScene.Config.main.R.General.Joystick.Options.Info.Parent := mainScene.Config.main.R.General.Joystick.Options.main;
  mainScene.Config.main.R.General.Joystick.Options.Info.SetBounds(0, 2, mainScene.Config.main.R.General.Joystick.Options.main.Width, 30);
  mainScene.Config.main.R.General.Joystick.Options.Info.Font.Size := 16;
  mainScene.Config.main.R.General.Joystick.Options.Info.Text := vInfo;
  mainScene.Config.main.R.General.Joystick.Options.Info.TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.General.Joystick.Options.Info.Visible := True;

  mainScene.Config.main.R.General.Joystick.Options.VBox := TVertScrollBox.Create(mainScene.Config.main.R.General.Joystick.Options.main);
  mainScene.Config.main.R.General.Joystick.Options.VBox.Name := 'Main_Config_General_Joystick_MMSystem_Generic_General_Options_VBox';
  mainScene.Config.main.R.General.Joystick.Options.VBox.Parent := mainScene.Config.main.R.General.Joystick.Options.main;
  mainScene.Config.main.R.General.Joystick.Options.VBox.SetBounds(10, 40, mainScene.Config.main.R.General.Joystick.Options.main.Width - 20,
    mainScene.Config.main.R.General.Joystick.Options.main.Height - 90);
  mainScene.Config.main.R.General.Joystick.Options.VBox.Visible := True;

  if vButtons then
  begin
    if vSelected_joy_Tab = 0 then
    begin
      for vI := 0 to High(cItems) do
        Create_List(vI, cItems[vI]);
    end
    else
    begin
      for vI := 0 to High(cItems_Emu) do
        Create_List(vI, cItems_Emu[vI]);
    end;
  end;

  mainScene.Config.main.R.General.Joystick.Options.Wait := TText.Create(mainScene.Config.main.R.General.Joystick.Options.main);
  mainScene.Config.main.R.General.Joystick.Options.Wait.Name := 'Main_Config_General_Joystick_MMSystem_Generic_General_Options_Wait';
  mainScene.Config.main.R.General.Joystick.Options.Wait.Parent := mainScene.Config.main.R.General.Joystick.Options.main;
  mainScene.Config.main.R.General.Joystick.Options.Wait.SetBounds(0, mainScene.Config.main.R.General.Joystick.Options.main.Height - 40,
    mainScene.Config.main.R.General.Joystick.Options.main.Width, 30);
  mainScene.Config.main.R.General.Joystick.Options.Wait.Font.Size := 16;
  mainScene.Config.main.R.General.Joystick.Options.Wait.Text := 'Waiting ...';
  mainScene.Config.main.R.General.Joystick.Options.Wait.TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.General.Joystick.Options.Wait.Visible := True;
end;

procedure Set_Value_To_Database(vKey, vValue: String; vJoy_Num: Integer);
begin
  if vSelected_joy_Tab = 1 then
    vKey := 'Emu_' + vKey;
  if vJoy_Num = 1 then
  begin
    uDB.ExtraFE_Query_Local.Close;
    uDB.ExtraFE_Query_Local.SQL.Clear;
    uDB.ExtraFE_Query_Local.SQL.Add('UPDATE map_joystick_mmsystem SET ' + vKey + '=''' + vValue + ''' WHERE user_id="' + uDB_AUser.Local.USER.Num.ToString +
      '" AND manufacturer_name=''' + uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Manufacturer + ''' AND product_name=''' +
      uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Product + ''' AND regkey=''' + uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Reg + ''' AND szoem=''' +
      uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.OEM + ''' AND name=''' + uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Name + ''' AND position="1"');
    uDB.ExtraFE_Query_Local.ExecSQL;
  end
  else
  begin
    uDB.ExtraFE_Query_Local.Close;
    uDB.ExtraFE_Query_Local.SQL.Clear;
    uDB.ExtraFE_Query_Local.SQL.Add('UPDATE map_joystick_mmsystem SET ' + vKey + '=''' + vValue + ''' WHERE user_id="' + uDB_AUser.Local.USER.Num.ToString +
      '" AND manufacturer_name=''' + uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_2.Manufacturer + ''' AND product_name=''' +
      uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_2.Product + ''' AND regkey=''' + uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_2.Reg + ''' AND szoem=''' +
      uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_2.OEM + ''' AND name=''' + uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_2.Name + ''' AND position="2"');
    uDB.ExtraFE_Query_Local.ExecSQL;
  end;

  mainScene.Config.main.Left_Blur.Enabled := False;
  mainScene.Config.main.R.General.Blur.Enabled := False;
  FreeAndNil(vSelected_joy_Timer);
  FreeAndNil(mainScene.Config.main.R.General.Joystick.Options.Panel);
  uMain_Config_General_Joystick.vJoy_Mapping := False;
end;

{ TJOYSTICK_GENERAL_MMSYSTEM_TIMER }

procedure TJOYSTICK_GENERAL_MMSYSTEM_TIMER.OnTimer(Sender: TObject);
var
  vPhrase: String;
  vNum: Integer;
begin
  if vTimes_joy < 5 then
  begin
    Inc(vDots_joy, 1);
    case vDots_joy of
      0:
        vPhrase := 'Waiting';
      1:
        vPhrase := 'Waiting .';
      2:
        vPhrase := 'Waiting ..';
      3:
        begin
          vPhrase := 'Waiting ...';
          vDots_joy := -1;
          Inc(vTimes_joy, 1);
        end;
    end;
    mainScene.Config.main.R.General.Joystick.Options.Wait.Text := vPhrase;
  end
  else
  begin
    FreeAndNil(mainScene.Config.main.R.General.Joystick.Options.Panel);
    mainScene.Config.main.Left_Blur.Enabled := False;
    mainScene.Config.main.R.General.Blur.Enabled := False;
    FreeAndNil(vSelected_joy_Timer);
  end;
end;

initialization

vTimer_Joy := TJOYSTICK_GENERAL_MMSYSTEM_TIMER.Create;

finalization

vTimer_Joy.Free;

end.
