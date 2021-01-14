unit uView_Mode_Default_Joy_MMSystem;

interface

uses
  System.Classes,
  uJoystick_mmsystem;

procedure Move(vActions: String);
procedure Buttons_Down(myButtons: TJoyButtons);
procedure Buttons_Up(myButtons: TJoyButtons);

var
  vOld_Move_Actions: String;
  vButton_State: Boolean;

implementation

uses
  uDB_AUser,
  uView_Mode_Default_Actions, uView_Mode_Default_AllTypes;

procedure Move(vActions: String);
begin
  if vOld_Move_Actions <> vActions then
  begin
    if vActions = 'center' then
    begin
      uView_Mode_Default_Actions.vMove_Timer.Enabled := false;
      if Emu_VM_Default_Var.Favorites_Open then
        Refresh_Load_Icons(Emu_VM_Default_Var.Gamelist.Selected, Emu_VM_Default_Var.Gamelist.Total_Games, Emu_VM_Default_Var.favorites.Roms)
      else
        Refresh_Load_Icons(Emu_VM_Default_Var.Gamelist.Selected, Emu_VM_Default_Var.Gamelist.Total_Games, Emu_VM_Default_Var.Gamelist.Roms);

      Emu_VM_Default.Gamelist.Gamelist.Timer.Enabled := True;
    end
    else if uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Up = vActions then
      uView_Mode_Default_Actions.Move_Gamelist('UP')
    else if uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Down = vActions then
      uView_Mode_Default_Actions.Move_Gamelist('DOWN')
    else if uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Left = vActions then
      uView_Mode_Default_Actions.Move_Gamelist('PAGE UP')
    else if uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Right = vActions then
      uView_Mode_Default_Actions.Move_Gamelist('PAGE DOWN')
  end;
  vOld_Move_Actions := vActions
end;

procedure Buttons_Down(myButtons: TJoyButtons);
var
  vAction: String;
begin
  if uJoystick_mmsystem.TJoyButton.JoyBtn1 in myButtons then
    vAction := uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Button_1;
  if uJoystick_mmsystem.TJoyButton.JoyBtn2 in myButtons then
    vAction := uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Button_2;
  if uJoystick_mmsystem.TJoyButton.JoyBtn3 in myButtons then
    vAction := uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Button_3;
  if uJoystick_mmsystem.TJoyButton.JoyBtn4 in myButtons then
    vAction := uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Button_4;
  if uJoystick_mmsystem.TJoyButton.JoyBtn5 in myButtons then
    vAction := uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Button_5;
  if uJoystick_mmsystem.TJoyButton.JoyBtn6 in myButtons then
    vAction := uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Button_6;
  if uJoystick_mmsystem.TJoyButton.JoyBtn7 in myButtons then
    vAction := uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Button_7;
  if uJoystick_mmsystem.TJoyButton.JoyBtn8 in myButtons then
    vAction := uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Button_8;
  if uJoystick_mmsystem.TJoyButton.JoyBtn9 in myButtons then
    vAction := uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Button_9;
  if uJoystick_mmsystem.TJoyButton.JoyBtn10 in myButtons then
    vAction := uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Button_10;
  if uJoystick_mmsystem.TJoyButton.JoyBtn11 in myButtons then
    vAction := uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Button_11;
  if uJoystick_mmsystem.TJoyButton.JoyBtn12 in myButtons then
    vAction := uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Button_12;
  if uJoystick_mmsystem.TJoyButton.JoyBtn13 in myButtons then
    vAction := uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Button_13;
  if uJoystick_mmsystem.TJoyButton.JoyBtn14 in myButtons then
    vAction := uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Button_14;
  if uJoystick_mmsystem.TJoyButton.JoyBtn15 in myButtons then
    vAction := uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Button_15;
  if uJoystick_mmsystem.TJoyButton.JoyBtn16 in myButtons then
    vAction := uDB_AUser.Local.MAP.Joystick.mmSystem.Joy_1.Emulators.Button_16;

  if vButton_State = false then
  begin
    if vAction = 'Action' then
      uView_Mode_Default_Actions.Enter
    else if vAction = 'Escape' then
      uView_Mode_Default_Actions.Exit_Action
    else if vAction = 'Settings' then
      uView_Mode_Default_Actions.Configuration_Action
    else if vAction = 'Search' then
    begin
      Emu_VM_Default_Var.search.vString := 'First';
      uView_Mode_Default_Actions.Search_Open;
    end
    else if vAction = 'Favorites' then
      uView_Mode_Default_Actions.Favorites_Open
    else if vAction = 'Add Favorite' then
      uView_Mode_Default_Actions.Favorites_Add
    else if vAction = 'Lists' then
      uView_Mode_Default_Actions.Lists_Action
    else if vAction = 'Filters' then
      uView_Mode_Default_Actions.Filters_Action
    else if vAction = 'Screensaver' then
      uView_Mode_Default_Actions.Screensaver;
  end;
  vButton_State := True;
end;

procedure Buttons_Up(myButtons: TJoyButtons);
begin
  vButton_State := False;
end;

end.
