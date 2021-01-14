unit uEmu_Arcade_Mame_Actions;

interface
uses
  System.Classes,
  System.SysUtils, FMX.StdCtrls, System.StrUtils;

procedure Action(vAction: String);

procedure Exit_Mame;
procedure Open_Config(vMain_Panel, vRight_Panel, vLeft_Panel: TPanel);

implementation

uses
  uDB_AUser,
  uEmu_Arcade_Mame_AllTypes,
  uLoad_AllTypes,
  uEmu_Actions,
  uView_Mode_Default_AllTypes, uEmu_Arcade_Mame_Config;

procedure Action(vAction: String);
begin
  if vAction = 'Emu_Exit' then
    Exit_Mame
  else if vAction = 'Emu_Settings' then
  begin
    if uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.View_Mode = 'Default' then
      Open_Config(uView_Mode_Default_AllTypes.Emu_VM_Default.config.main,
        uView_Mode_Default_AllTypes.Emu_VM_Default.config.right, uView_Mode_Default_AllTypes.Emu_VM_Default.config.left);
  end;
end;

procedure Exit_Mame;
begin
  FreeAndNil(vMame.Scene.Main);
  extrafe.prog.State := 'main';
  uEmu_Actions.Exit;
end;

procedure Open_Config(vMain_Panel, vRight_Panel, vLeft_Panel: TPanel);
begin
  if not ContainsText(extrafe.prog.State, 'emu_mame_config') then
  begin
    uEmu_Arcade_Mame_Config.Load(vMain_Panel, vRight_Panel, vLeft_Panel);
    extrafe.prog.State := 'emu_mame_config';
  end
  else
    extrafe.prog.State := 'emu_mame';
end;

end.
