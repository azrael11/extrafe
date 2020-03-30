unit uMain_Keyboard;

interface

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils;

procedure SetKey(vKey: String);


implementation

uses
  uDB_AUser,
  uMain,
  uKeyboard,
  uLoad_AllTypes,
  uMain_Actions,
  uMain_Config,
  uMain_Emulation,
  uMain_Config_Keyboard;

procedure SetKey(vKey: String);
begin
  if extrafe.prog.State = 'main' then
  begin
    if Right_VKey(vKey) = uDB_AUser.Local.MAP.Keyboard.Right then
      uMain_Emulation.Slide_Right
    else if Right_VKey(vKey) = uDB_AUser.Local.MAP.Keyboard.Left then
      uMain_Emulation.Slide_Left
    else if Right_VKey(vKey) = uDB_AUser.Local.MAP.Keyboard.Action then
    begin
      if extrafe.prog.State = 'main' then
        uMain_Emulation.Trigger_Click(emulation.Selection.TabIndex)
    end
    else if Right_VKey(vKey) = uDB_AUser.Local.MAP.Keyboard.Escape then
    begin
      if emulation.Level <> 0 then
      begin
        emulation.level := 0;
        uMain_Emulation.Category(emulation.Level, emulation.Category_Num);
      end
      else
        uMain.Exit;
    end
    else if Right_VKey(vKey) = uDB_AUser.Local.MAP.Keyboard.Config then
      uMain_Config.ShowHide(extrafe.prog.State)
    else if UpperCase(vKey) = '1' then
      uMain_Actions.ShowHide_Addon(1000, extrafe.prog.State, 'time')
    else if UpperCase(vKey) = '2' then
      uMain_Actions.ShowHide_Addon(1001, extrafe.prog.State, 'calendar')
  end
  else if extrafe.prog.State = 'main_exit' then
  begin
    if Right_VKey(vKey) = uDB_AUser.Local.MAP.Keyboard.Escape then
      uMain.Exit_Stay
  end
  else if ContainsText(extrafe.prog.State, 'main_config') then
    uMain_Config_Keyboard.Set_Key(vKey);
end;

end.
