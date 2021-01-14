unit uEmu_Emu;

interface

uses
  System.Classes,
  System.SysUtils, System.AnsiStrings;

procedure Action(vAction: String);

procedure Joy_Action(vAction: String);

procedure Key_View_Mode(vKey: String);
procedure Key_View_Mode_Up(vKey: String);

implementation

uses
  uDB_AUser,
  uEmu_Actions,
  {Arcade}
  uEmu_Arcade_Mame_Actions,

  {Consoles}
  uEmu_Consoles_Nes_Actions,

  {View Modes Keyboard}
  uView_Mode_Default_Key,
  {End View Modes Keyboard}
  emu,
  uLoad_AllTypes;


procedure Action(vAction: String);
begin
  if emulation.Category_Num = 0 then
  begin
    if ContainsText(extrafe.prog.State, 'emu_mame') then
      uEmu_Arcade_Mame_Actions.Action(vAction);
  end
  else if emulation.Category_Num = 2 then
  begin
    if ContainsText(extrafe.prog.State, 'emu_nes') then
      uEmu_Consoles_Nes_Actions.Action(vAction);
  end;
end;


procedure Joy_Action(vAction: String);
begin

end;

procedure Key_View_Mode(vKey: String);
begin
  if uEmu_Actions.vCurrent_View_Mode = 'Default' then
    uView_Mode_Default_Key.Key(vKey);
end;

procedure Key_View_Mode_Up(vKey: String);
begin
  if uEmu_Actions.vCurrent_View_Mode = 'Default' then
    uView_Mode_Default_Key.Key_Up(vKey);
end;

end.
