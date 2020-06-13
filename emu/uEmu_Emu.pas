unit uEmu_Emu;

interface

uses
  System.Classes,
  System.SysUtils;

{ The system i create is simple the first number is the unique number of
  the executable emulator. The second number exists only if the emulator is
  multi emulator like mame, fbaneo, mendafan e.t.c.

  so for mame 0.0 First 0 is for Mame.exe and the second 0 is arcade version
  0.1 First 0 is for Mame.exe and the second 1 is nes version
  1.3 First 1 is for FbaNeo.exe and the second 3 is for pcengine version
  e.t.c............

}

{ Here is the Emulators Unique numbers

  working

  0.0 : Mame Arcade

  in progress


}

procedure Mouse_Action(vAction: String);
procedure Key_Action(vAction: String);
procedure Joy_Action(vAction: String);

procedure Key_View_Mode(vKey: String);
procedure Key_View_Mode_Up(vKey: String);

implementation

uses
  uDB_AUser,
  uEmu_Actions,
  {MAME ARCADE}
  uEmu_Arcade_Mame_Mouse,
  uEmu_Arcade_Mame_Keyboard,
  {END MAME ARCADE}

  {View Modes Keyboard}
  uView_Mode_Default_Key,
  {End View Modes Keyboard}
  emu;

procedure Mouse_Action(vAction: String);
var
  vInt: Integer;
  vInt2: Integer;
begin
  vInt := Trunc(uDB_AUser.Local.EMULATORS.Active_Unique);
  vInt2 := FloatToStr(Frac(uDB_AUser.Local.EMULATORS.Active_Unique)).ToInteger;
  case vInt of
    0:
      case vInt2 of
        0:
          uEmu_Arcade_Mame_Mouse.Action(vAction);
      end;
    1:
      ;
  end;

end;

procedure Key_Action(vAction: String);
var
  vInt: Integer;
  vInt2: Integer;
begin
  vInt := Trunc(uDB_AUser.Local.EMULATORS.Active_Unique);
  vInt2 := FloatToStr(Frac(uDB_AUser.Local.EMULATORS.Active_Unique)).ToInteger;
  case vInt of
    0:
      case vInt2 of
        0:
          uEmu_Arcade_Mame_Keyboard.Action(vAction);
      end;
    1:
      ;
  end;
end;

procedure Joy_Action(vAction: String);
begin

end;

procedure Key_View_Mode(vKey: String);
begin
  if uEmu_Actions.vCurrent_View_Mode = 'default' then
    uView_Mode_Default_Key.Key(vKey);
end;

procedure Key_View_Mode_Up(vKey: String);
begin
  if uEmu_Actions.vCurrent_View_Mode = 'default' then
    uView_Mode_Default_Key.Key_Up(vKey);
end;

end.
