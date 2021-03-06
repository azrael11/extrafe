unit uMain_Config_Emulation_Consoles_Scripts_Nes_Install_Emulators;

interface

uses
  System.Classes,
  System.SysUtils,
  Winapi.ShellAPI,
  FMX.Forms,
  Winapi.Windows;

procedure Mame_Nes;
procedure PuNes;
procedure FCEUX;
procedure MESEN;
procedure Nestopia_EU;
procedure Higan;
procedure JNes;
procedure Nintendulator;
procedure Quick_Nes;
procedure Rock_Nes;

implementation

uses
  uEmu_Consoles_Nes_AllTypes,
  uMain_Config_Emulation_Consoles_Scripts_Nes_Install, uLoad_AllTypes,
  uMain_Emulation,
  uMain_AllTypes,
  uMain_Config_Emulators, uDB_AUser, uDB, uEmu_Consoles_Nes_SetAll;

procedure Mame_Nes;
begin
  uDB_AUser.Local.Emulators.Consoles := True;
  uDB_AUser.Local.Emulators.Consoles_D.NES := True;
  Inc(uDB_AUser.Local.Emulators.Count);
  Inc(uDB_AUser.Local.Emulators.Consoles_D.Count);

  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Emulators', 'Consoles', 'True', 'User_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Emulators', 'Count', uDB_AUser.Local.Emulators.Count.ToString, 'User_ID', uDB_AUser.Local.USER.Num.ToString);

  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Consoles', 'NES', 'True', 'User_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Consoles', 'Count', uDB_AUser.Local.Emulators.Consoles_D.Count.ToString, 'User_ID',
    uDB_AUser.Local.USER.Num.ToString);

  uDB_AUser.Local.Emulators.Consoles_D.NES_D.Installed := True;
  uDB_AUser.Local.Emulators.Consoles_D.NES_D.Active := True;
  uDB_AUser.Local.Emulators.Consoles_D.NES_D.Position := 2;
  uDB_AUser.Local.Emulators.Consoles_D.NES_D.Unique := 0;
  uDB_AUser.Local.Emulators.Consoles_D.NES_D.Active_Emu := CE_NES_MameNes;

  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'consoles_nes', 'Installed', 'True', 'User_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'consoles_nes', 'Emu_Active', 'TRUE', 'User_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'consoles_nes', 'Emu_Position', uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Position.ToString, 'User_ID',
    uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'consoles_nes', 'Emu_Unique', '2.8', 'User_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'consoles_nes', 'Active_Emulator', 'Mame Nes', 'User_ID', uDB_AUser.Local.USER.Num.ToString);

  if Nes_I.Main.IsEmuAlReadyInstalled then
  begin
    uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_p_Path := extrafe.prog.Path + 'emu\consoles\nes\';
    uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_p_Images := uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_p_Path + 'images\';
    uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_p_Sounds := uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_p_Path + 'sounds\';
    uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_p_Views := uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_p_Path + 'views\';

    uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_Name := uDB_AUser.Local.Emulators.Arcade_D.Mame_D.p_Path;
    uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_Path := uDB_AUser.Local.Emulators.Arcade_D.Mame_D.p_Images;
    uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_Ini := uDB_AUser.Local.Emulators.Arcade_D.Mame_D.p_Sounds;
    uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_Version := uDB_AUser.Local.Emulators.Arcade_D.Mame_D.p_Views;

    uDB.Query_Update(uDB.ExtraFE_Query_Local, 'consoles_nes', 'Mame_Ex_Path', uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_p_Path, 'User_ID',
      uDB_AUser.Local.USER.Num.ToString);
    uDB.Query_Update(uDB.ExtraFE_Query_Local, 'consoles_nes', 'Mame_Ex_Images', uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_p_Images, 'User_ID',
      uDB_AUser.Local.USER.Num.ToString);
    uDB.Query_Update(uDB.ExtraFE_Query_Local, 'consoles_nes', 'Mame_Ex_Sounds', uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_p_Sounds, 'User_ID',
      uDB_AUser.Local.USER.Num.ToString);
    uDB.Query_Update(uDB.ExtraFE_Query_Local, 'consoles_nes', 'Mame_Ex_Views', uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_p_Views, 'User_ID',
      uDB_AUser.Local.USER.Num.ToString);

    uDB.Query_Update(uDB.ExtraFE_Query_Local, 'consoles_nes', 'Mame_Name', uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_Name, 'User_ID',
      uDB_AUser.Local.USER.Num.ToString);
    uDB.Query_Update(uDB.ExtraFE_Query_Local, 'consoles_nes', 'Mame_Path', uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_Path, 'User_ID',
      uDB_AUser.Local.USER.Num.ToString);
    uDB.Query_Update(uDB.ExtraFE_Query_Local, 'consoles_nes', 'Mame_Ini', uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_Ini, 'User_ID',
      uDB_AUser.Local.USER.Num.ToString);
    uDB.Query_Update(uDB.ExtraFE_Query_Local, 'consoles_nes', 'Mame_Version', uDB_AUser.Local.Emulators.Consoles_D.NES_D.Mame_Version, 'User_ID',
      uDB_AUser.Local.USER.Num.ToString);
  end
  else
  begin
    uEmu_Consoles_Nes_AllTypes.NES.Mame.Name := ExtractFileName(Nes_I.Main.Tab4_1.Edit.Text);
    uEmu_Consoles_Nes_AllTypes.NES.Mame.Path := ExtractFilePath(Nes_I.Main.Tab4_1.Edit.Text);

    // Create mame ini if dont exist
    if not FileExists(uEmu_Consoles_Nes_AllTypes.NES.Mame.Path + 'mame.ini') then
      ShellExecute(0, nil, 'cmd.exe', PChar('/C ' + AnsiQuotedStr(uEmu_Consoles_Nes_AllTypes.NES.Mame.Path + uEmu_Consoles_Nes_AllTypes.NES.Mame.Name,
        Char(34)) + ' -cc'), PChar(uEmu_Consoles_Nes_AllTypes.NES.Mame.Path), SW_HIDE);
    uEmu_Consoles_Nes_AllTypes.NES.Mame.p_Ini_Path := uEmu_Consoles_Nes_AllTypes.NES.Mame.Path;

    Nes_I.Main.Tab4_1.Progress.Value := 20;
    Application.ProcessMessages;

    // NES.Mame.Database := extrafe.prog.Path + 'emu\consoles\nes\database\';
    // ShellExecute(0, nil, 'cmd.exe', PChar('/C ' + AnsiQuotedStr(NES.Mame.Path + NES.Mame.Name, Char(34)) + ' nes -glist > ' + NES.Mame.Database +
    // 'mame_data_games.xml'), nil, SW_HIDE);

    Nes_I.Main.Tab4_1.Progress.Value := 40;
    Application.ProcessMessages;

  end;
  if emulation.Level = 0 then
    emulation.Selection_Tab[2].Logo_Gray.Enabled := false;
  Inc(emulation.Category[2].Second_Level, 1);
  Nes_I.Main.Tab4_1.Progress.Value := 100;
  Nes_I.Main.Tab4_1.Edit_Info.Text := 'Installation complete. Click next to start using it.';

  emulation.emu[2, 8] := 'active';
  emulation.Consoles[8].Installed := True;

  // Clear and create the main control tab
  uMain_Emulation.Clear_Selection_Control;
  uMain_Emulation.Create_Selection_Control;
  uMain_Emulation.Category(2, 0);

  FreeAndNil(mainScene.Config.Main.R.Emulators.Consoles[8].Panel);
  uMain_Config_Emulators.CreateConsolesPanel(8);
end;

procedure PuNes;
begin

end;

procedure FCEUX;
begin

end;

procedure MESEN;
begin

end;

procedure Nestopia_EU;
begin

end;

procedure Higan;
begin

end;

procedure JNes;
begin

end;

procedure Nintendulator;
begin

end;

procedure Quick_Nes;
begin

end;

procedure Rock_Nes;
begin

end;

end.
