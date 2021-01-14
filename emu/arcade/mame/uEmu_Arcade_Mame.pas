unit uEmu_Arcade_Mame;

interface

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  FMX.Types, FMX.StdCtrls;

procedure Load;
procedure Exit;

procedure Open_Global_Configuration(vMain_Panel, vRight_Panel, vLeft_Panel: TPanel);

implementation

uses
  uDB,
  uDB_AUser,
  uLoad_AllTypes,
  uEmu_Actions,
  uEmu_Arcade_Mame_SetAll,
  uEmu_Arcade_Mame_AllTypes,
  uEmu_Arcade_Mame_Config,
  uView_Mode, uEmu_Arcade_Mame_Ini, uView_Mode_Default_AllTypes;

{ Start Mame }
procedure Load;
begin
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'emulators', 'ACTIVE_UNIQUE', uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Unique.ToString, 'USER_ID',
    uDB_AUser.Local.USER.Num.ToString);
  extrafe.prog.State := 'emu_mame';

  uView_Mode_Default_AllTypes.Emu_VM_Default_Var.State := extrafe.prog.State;
  uEmu_Actions.vCurrent_View_Mode := uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.View_Mode;
  uView_Mode_Default_AllTypes.Emu_VM_Default_Var.Emulator_Name := uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Name;
  uView_Mode_Default_AllTypes.Emu_VM_Default_Var.Emulator_Path := uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Path;
  uView_Mode_Default_AllTypes.Emu_VM_Default_Var.Emulator_Extra_Commands := '';



  uEmu_Arcade_Mame_SetAll.Load;

  mame.Emu.Ini.CORE_SEARCH_rompath := mame.Gamelist.RomsPath;
  uEmu_Arcade_Mame_Ini.Save;

  uView_Mode.Start(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.View_Mode, 0, mame.Gamelist.Games_Count, mame.Gamelist.ListGames, mame.Gamelist.ListRoms,
    mame.Emu.Ini.CORE_SEARCH_rompath);
end;

{ Exit Mame }
Procedure Exit;
begin
  FreeAndNil(vMame.Scene.Main);
  extrafe.prog.State := 'main';
  uEmu_Actions.Exit;
end;

{ Open Close Configurtaion }
procedure Open_Global_Configuration(vMain_Panel, vRight_Panel, vLeft_Panel: TPanel);
var
  vi: Integer;
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
