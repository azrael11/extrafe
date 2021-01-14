unit uEmu_Consoles_Nes_SetAll;

interface

uses
  System.Classes,
  System.SysUtils,
  FireDAC.Comp.Client,
  FMX.Objects;

procedure Load;

procedure Get_Set_Nes_Data;
procedure Set_Nes_Data;

implementation

uses
  uDB,
  uEmu_Consoles_Nes_AllTypes,
  emu,
  uDB_AUser,
  uLoad_AllTypes,
  uView_Mode, uEmu_Consoles_Nes_Mame_Ini;

procedure Load;
begin
  vNes.Scene.Main := TImage.Create(Emu_Form);
  vNes.Scene.Main.Name := 'Nes_Main';
  vNes.Scene.Main.Parent := Emu_Form;
  vNes.Scene.Main.SetBounds(0, 0, Emu_Form.Width, Emu_Form.Height);
  vNes.Scene.Main.WrapMode := TImageWrapMode.Stretch;
  vNes.Scene.Main.Visible := True;

  uView_Mode.Scene(uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.View_Mode, uDB_AUser.Local.USER.Num, uDB.Nes_Query, vNes.Scene.Main,
    uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Mame_p_Views, uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Mame_p_Images,
    uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Mame_p_Sounds);
end;

procedure Get_Set_Nes_Data;
var
  vQuery: String;
  vi: integer;
  vDatabase_Name: String;
  vIPos: integer;
  Active_Emulator: String;
begin
  nes.gamelist.games := TStringList.Create;
  nes.gamelist.roms := TStringList.Create;
  nes.gamelist.year := TStringList.Create;
  nes.gamelist.publisher := TStringList.Create;

  nes.gamelist.romspath := TStringList.Create;

  uDB.Nes_Query.Close;
  uDB.Nes_Query.SQL.Clear;
  uDB.Nes_Query.SQL.Text := 'SELECT Count(*) FROM games';
  uDB.Nes_Query.DisableControls;
  uDB.Nes_Query.Open;

  nes.gamelist.total_games := uDB.Nes_Query.Fields[0].AsInteger;

  uDB.Nes_Query.Close;
  uDB.Nes_Query.SQL.Clear;
  uDB.Nes_Query.SQL.Text := 'SELECT * FROM games ORDER BY gamename ASC';
  uDB.Nes_Query.DisableControls;
  uDB.Nes_Query.Open;

  try
    uDB.Nes_Query.First;
    while not uDB.Nes_Query.Eof do
    begin

      nes.gamelist.games.Add(uDB.Nes_Query.FieldByName('gamename').AsString);
      nes.gamelist.roms.Add(uDB.Nes_Query.FieldByName('romname').AsString);
      nes.gamelist.year.Add(uDB.Nes_Query.FieldByName('year').AsString);
      nes.gamelist.publisher.Add(uDB.Nes_Query.FieldByName('publisher').AsString);

      uDB.Nes_Query.Next;
    end;

  finally
    uDB.Nes_Query.EnableControls;
  end;

  vQuery := 'SELECT * FROM paths';
  uDB.Nes_Query.Close;
  uDB.Nes_Query.SQL.Clear;
  uDB.Nes_Query.SQL.Text := vQuery;
  uDB.Nes_Query.DisableControls;
  uDB.Nes_Query.Open;

  try
    uDB.Nes_Query.First;
    while not uDB.Nes_Query.Eof do
    begin

      nes.gamelist.romspath.Add(uDB.Nes_Query.FieldByName('path').AsString);

      uDB.Nes_Query.Next;
    end;
  finally
    uDB.Nes_Query.EnableControls;
  end;


  uDB.ExtraFE_Query_Local.Close;
  uDB.ExtraFE_Query_Local.SQL.Clear;
  uDB.ExtraFE_Query_Local.SQL.Text := 'SELECT * FROM consoles_nes WHERE User_ID=''' + uDB_AUser.Local.USER.Num.ToString + '''';
  uDB.ExtraFE_Query_Local.Open;

  uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Installed := uDB.ExtraFE_Query_Local.FieldByName('Installed').AsBoolean;
  uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Active := uDB.ExtraFE_Query_Local.FieldByName('Emu_Active').AsBoolean;
  uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Position := uDB.ExtraFE_Query_Local.FieldByName('Emu_Position').AsInteger;
  uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Unique := uDB.ExtraFE_Query_Local.FieldByName('Emu_Unique').AsSingle;
  uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.View_Mode := uDB.ExtraFE_Query_Local.FieldByName('View_Mode').AsString;
  Active_Emulator := uDB.ExtraFE_Query_Local.FieldByName('Active_Emulator').AsString;

  if Active_Emulator = 'Mame NES' then
    uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Active_Emu := CE_NES_MameNes
  else if Active_Emulator = 'PuNes' then
    uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Active_Emu := CE_NES_PuNes
  else if Active_Emulator = 'FCEUX' then
    uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Active_Emu := CE_NES_FCEUX
  else if Active_Emulator = 'MESEN' then
    uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Active_Emu := CE_NES_MESEN
  else if Active_Emulator = 'Nestopia EU' then
    uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Active_Emu := CE_NES_Nestopia_EU
  else if Active_Emulator = 'Higan' then
    uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Active_Emu := CE_NES_Higan
  else if Active_Emulator = 'JNes' then
    uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Active_Emu := CE_NES_JNes
  else if Active_Emulator = 'Nintendulator' then
    uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Active_Emu := CE_NES_Nintendulator
  else if Active_Emulator = 'QuickNes' then
    uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Active_Emu := CE_NES_QuickNes
  else if Active_Emulator = 'RockNes' then
    uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Active_Emu := CE_NES_RockNes;

  uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Mame_p_Path := uDB.ExtraFE_Query_Local.FieldByName('Mame_Ex_Path').AsString;
  uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Mame_p_Images := uDB.ExtraFE_Query_Local.FieldByName('Mame_Ex_Images').AsString;
  uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Mame_p_Sounds := uDB.ExtraFE_Query_Local.FieldByName('Mame_Ex_Sounds').AsString;
  uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Mame_p_Views := uDB.ExtraFE_Query_Local.FieldByName('Mame_Ex_Views').AsString;
  uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Mame_Name := uDB.ExtraFE_Query_Local.FieldByName('Mame_Name').AsString;
  uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Mame_Path := uDB.ExtraFE_Query_Local.FieldByName('Mame_Path').AsString;
  uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Mame_Ini := uDB.ExtraFE_Query_Local.FieldByName('Mame_Ini').AsString;
  uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Mame_Version := uDB.ExtraFE_Query_Local.FieldByName('Mame_Version').AsString;

  uDB.ExtraFE_Query_Local.Close;

  Set_Nes_Data;
end;

procedure Set_Nes_Data;
begin
  emulation.emu[2, 8] := uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Name;
  emulation.Consoles[8].Prog_Path := uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Mame_p_Path;
  emulation.Consoles[8].Emu_Path := uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Mame_Path;
  emulation.Consoles[8].Active := uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Active;
  emulation.Consoles[8].Active_Place := uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Position;
  emulation.Consoles[8].Name := uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Name;
  emulation.Consoles[8].Name_Exe := uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Name;
  emulation.Consoles[8].Menu_Image_Path := uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Mame_p_Images;
  emulation.Consoles[8].Background := uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Mame_p_Images + 'main_background.png';
  emulation.Consoles[8].Logo := uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Mame_p_Images + 'mame.png';
  emulation.Consoles[8].Second_Level := -1;
  emulation.Consoles[8].Unique_Num := uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Unique;
  emulation.Consoles[8].Installed := uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Installed;

  if uDB_AUser.Local.EMULATORS.Consoles_D.NES_D.Active_Emu = CE_NES_MameNes then
    uEmu_Consoles_Nes_Mame_Ini.Load;
end;

end.
