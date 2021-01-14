unit uEmu_Consoles_Nes;

interface

uses
  System.Classes,
  System.SysUtils;

procedure Load;

implementation

uses
  uDB,
  uLoad_AllTypes,
  uDB_AUser,
  uView_Mode,
  uEmu_Consoles_Nes_SetAll,
  uEmu_Consoles_Nes_AllTypes,
  uEmu_Consoles_Nes_Mame_Ini,
  uEmu_Arcade_Mame_AllTypes,
  uEmu_Actions,
  uView_Mode_Default_AllTypes;

procedure Load;
begin
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'emulators', 'ACTIVE_UNIQUE', uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Unique.ToString, 'User_ID',
    uDB_AUser.Local.USER.Num.ToString);
  extrafe.prog.State := 'emu_nes';
  uView_Mode_Default_AllTypes.Emu_VM_Default_Var.State := extrafe.prog.State;
  uEmu_Actions.vCurrent_View_Mode := uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.View_Mode;


  uView_Mode_Default_AllTypes.Emu_VM_Default_Var.Emulator_Name := uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Name;
  uView_Mode_Default_AllTypes.Emu_VM_Default_Var.Emulator_Path := uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Mame_Path;
  uView_Mode_Default_AllTypes.Emu_VM_Default_Var.Emulator_Extra_Commands := ' nes';

  uEmu_Consoles_Nes_SetAll.Load;

  nes.Mame.Ini.CORE_SEARCH_rompath := nes.Gamelist.RomsPath;
  uEmu_Consoles_Nes_Mame_Ini.Save;

  uView_Mode.Start(uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.View_Mode, 0, nes.Gamelist.total_games, nes.Gamelist.games, nes.Gamelist.roms,
    nes.Mame.Ini.CORE_SEARCH_rompath);
end;

end.
