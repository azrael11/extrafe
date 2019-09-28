unit uLoad_Emulation;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Inifiles,
  FMX.Forms,
  FMX.Graphics;

type
  TLOAD_EMU_TAB_DATA = record
    Prog_Path: String;
    Emu_Path: String;
    Emu_Name: String;
    Emu_Name_Exe: String;
    Active: Boolean;
    Categorie: Integer;
    Place_Num: Integer;
    Unique_Num: Integer;
    Installed: Boolean;
    Images_Path: String;
  end;

procedure uLoad_Emulation_FirstTime;
procedure Load;

procedure uLoad_Emulation_SetTabs;

procedure Get_Arcade_Data;
procedure Get_Computers_Data;
procedure Get_Consoles_Data;
procedure Get_Handhelds_Data;
procedure Get_Pinballs_Data;

implementation

uses
  load,
  uLoad,
  uLoad_AllTypes,
  uDatabase,
  uDatabase_ActiveUser,
  uEmu_Arcade_Mame,
  uEmu_Arcade_Mame_SetAll;

procedure uLoad_Emulation_FirstTime;
begin
  CreateDir(extrafe.prog.Path + 'emu');
  // Arcade
  CreateDir(extrafe.prog.Path + 'emu\arcade');
  CreateDir(extrafe.prog.Path + 'emu\arcade\mame');
  CreateDir(extrafe.prog.Path + 'emu\arcade\mame\config');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\artworks');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\cabinets');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\control_panels');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\covers');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\flyers');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\fanart');
  CreateDir(extrafe.prog.Path + 'emu\arcade\medis\game_over');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\icons');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\manuals');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\marquees');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\pcbs');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\snapshots');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\titles');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\artwork_preview');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\bosses');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\ends');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\how_to');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\logos');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\scores');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\selects');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\stamps');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\versus');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\warnings');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\soundtracks');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\support_files');
  CreateDir(extrafe.prog.Path + 'emu\arcade\media\videos');
  // Computers
  CreateDir(extrafe.prog.Path + 'emu\computers');
  // Consoles
  CreateDir(extrafe.prog.Path + 'emu\consoles');
  CreateDir(extrafe.prog.Path + 'emu\conlosles\nes');
  CreateDir(extrafe.prog.Path + 'emu\conlosles\snes');
  CreateDir(extrafe.prog.Path + 'emu\conlosles\master_system');
  CreateDir(extrafe.prog.Path + 'emu\conlosles\mega_drive');
  // Handhelds
  CreateDir(extrafe.prog.Path + 'emu\handhelds');
  CreateDir(extrafe.prog.Path + 'emu\handhelds\gameboy');
  // Pinball
  CreateDir(extrafe.prog.Path + 'emu\pinball');

  extrafe.ini.ini.WriteBool('Emulation', 'Active', true);
  emulation.Active := true;
  extrafe.ini.ini.WriteInteger('Emulation', 'Active_Num', -1);
  emulation.Active_Num := -1;
  extrafe.ini.ini.WriteInteger('Emulation', 'Unique_Num', -1);
  emulation.Unique_Num := -1;
  extrafe.ini.ini.WriteBool('Emulation', 'ShowCat', true);
  emulation.ShowCat := true;
end;

procedure Load;
begin
  ex_load.Scene.Progress_Text.Text := 'Configurate and loading "Emulators" ...';
  // Create the emulators string multi array
  SetLength(emulation.Emu, 5);

  SetLength(emulation.Emu[0], 255);
  SetLength(emulation.Emu[1], 255);
  SetLength(emulation.Emu[2], 255);
  SetLength(emulation.Emu[3], 255);
  SetLength(emulation.Emu[4], 255);

  //

  emulation.Category[0].Active := true;
  emulation.Category[0].Active_Place := 0;
  emulation.Category[0].Name := 'Arcade';
  emulation.Category[0].Menu_Image_Path := emulation.Path + 'arcade\images\';
  emulation.Category[0].Logo := emulation.Category[0].Menu_Image_Path + 'arcade.png';
  emulation.Category[0].Background := emulation.Category[0].Menu_Image_Path + 'background.png';
  emulation.Category[0].Second_Level := -1;
  emulation.Category[0].Installed := user_Active_Local.EMULATORS.Arcade;
  emulation.Category[0].Unique_Num := -1;

  emulation.Category[1].Active := true;
  emulation.Category[1].Active_Place := 1;
  emulation.Category[1].Name := 'Computers';
  emulation.Category[1].Menu_Image_Path := emulation.Path + 'computers\images\';
  emulation.Category[1].Logo := emulation.Category[1].Menu_Image_Path + 'computers.png';
  emulation.Category[1].Background := emulation.Category[1].Menu_Image_Path + 'background.png';
  emulation.Category[1].Second_Level := -1;
  emulation.Category[1].Installed := user_Active_Local.EMULATORS.Computers;
  emulation.Category[1].Unique_Num := -1;

  emulation.Category[2].Active := true;
  emulation.Category[2].Active_Place := 2;
  emulation.Category[2].Name := 'Consoles';
  emulation.Category[2].Menu_Image_Path := emulation.Path + 'consoles\images\';
  emulation.Category[2].Logo := emulation.Category[2].Menu_Image_Path + 'consoles.png';
  emulation.Category[2].Background := emulation.Category[2].Menu_Image_Path + 'background.png';
  emulation.Category[2].Second_Level := -1;
  emulation.Category[2].Installed := user_Active_Local.EMULATORS.Consoles;
  emulation.Category[2].Unique_Num := -1;

  emulation.Category[3].Active := true;
  emulation.Category[3].Active_Place := 3;
  emulation.Category[3].Name := 'Handhelds';
  emulation.Category[3].Menu_Image_Path := emulation.Path + 'handhelds\images\';
  emulation.Category[3].Logo := emulation.Category[3].Menu_Image_Path + 'handhelds.png';
  emulation.Category[3].Background := emulation.Category[3].Menu_Image_Path + 'background.png';
  emulation.Category[3].Second_Level := -1;
  emulation.Category[3].Installed := user_Active_Local.EMULATORS.Handhelds;
  emulation.Category[3].Unique_Num := -1;

  emulation.Category[4].Active := true;
  emulation.Category[4].Active_Place := 4;
  emulation.Category[4].Name := 'Pinball';
  emulation.Category[4].Menu_Image_Path := emulation.Path + 'pinball\images\';
  emulation.Category[4].Logo := emulation.Category[4].Menu_Image_Path + 'pinballs.png';
  emulation.Category[4].Background := emulation.Category[4].Menu_Image_Path + 'background.png';
  emulation.Category[4].Second_Level := -1;
  emulation.Category[4].Installed := user_Active_Local.EMULATORS.Pinballs;
  emulation.Category[4].Unique_Num := -1;

  uLoad_Emulation_SetTabs;

  ex_load.Scene.Progress.Value := 60;
end;

procedure uLoad_Emulation_SetTabs;
var
  vi, vk: Integer;
begin
  for vi := 0 to 4 do
    for vk := 0 to 254 do
      emulation.Emu[vi, vk] := 'nil';

  if user_Active_Local.EMULATORS.Arcade then
    Get_Arcade_Data;
  if user_Active_Local.EMULATORS.Computers then
    Get_Computers_Data;
  if user_Active_Local.EMULATORS.Consoles then
    Get_Consoles_Data;
  if user_Active_Local.EMULATORS.Handhelds then
    Get_Handhelds_Data;
  if user_Active_Local.EMULATORS.Pinballs then
    Get_Pinballs_Data;

  ex_load.Scene.Progress.Value := 70;
end;

procedure Get_Arcade_Data;
var
  vQuery : String;
begin
  vQuery := 'SELECT * FROM ARCADE_MEDIA WHERE USER_ID=' + user_Active_Local.Num.ToString;
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Add(vQuery);
  ExtraFE_Query_Local.Open;
  ExtraFE_Query_Local.First;
  user_Active_Local.EMULATORS.Arcade_D.Media.Artworks := ExtraFE_Query_Local.FieldByName('ARTWORKS').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Cabinets := ExtraFE_Query_Local.FieldByName('CABINETS').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Control_Panels := ExtraFE_Query_Local.FieldByName('CONTROL_PANELS').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Covers := ExtraFE_Query_Local.FieldByName('COVERS').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Flyers := ExtraFE_Query_Local.FieldByName('FLYERS').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Fanart := ExtraFE_Query_Local.FieldByName('FANART').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Game_Over := ExtraFE_Query_Local.FieldByName('GAME_OVER').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Icons := ExtraFE_Query_Local.FieldByName('ICONS').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Manuals := ExtraFE_Query_Local.FieldByName('MANUALS').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Marquees := ExtraFE_Query_Local.FieldByName('MARQUEES').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Pcbs := ExtraFE_Query_Local.FieldByName('PCBS').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Snapshots := ExtraFE_Query_Local.FieldByName('SNAPSHOTS').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Titles := ExtraFE_Query_Local.FieldByName('TITLES').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Artwork_Preview := ExtraFE_Query_Local.FieldByName('ARTWORK_PREVIEW').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Bosses := ExtraFE_Query_Local.FieldByName('BOSSES').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Ends := ExtraFE_Query_Local.FieldByName('ENDS').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.How_To := ExtraFE_Query_Local.FieldByName('HOW_TO').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Logos := ExtraFE_Query_Local.FieldByName('LOGOS').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Scores := ExtraFE_Query_Local.FieldByName('SCORES').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Selects := ExtraFE_Query_Local.FieldByName('SELECTS').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Stamps := ExtraFE_Query_Local.FieldByName('STAMPS').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Versus := ExtraFE_Query_Local.FieldByName('VERSUS').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Warnings := ExtraFE_Query_Local.FieldByName('WARNINGS').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Soundtracks := ExtraFE_Query_Local.FieldByName('SOUNDTRACKS').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Support_Files := ExtraFE_Query_Local.FieldByName('SUPPORT_FILES').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Media.Videos := ExtraFE_Query_Local.FieldByName('VIDEOS').AsString;
  ExtraFE_Query_Local.Close;


  if user_Active_Local.EMULATORS.Arcade_D.Mame then
    uEmu_Arcade_Mame_SetAll.Get_Set_Mame_Data;
  { if user_Active_Local.EMULATORS.Arcade_D.FBA then
    Get_Set_FBA_Data;
    if user_Active_Local.EMULATORS.Arcade_D.Zinc then
    Get_Set_Zinc_Data;
    if user_Active_Local.EMULATORS.Arcade_D.Daphne then
    Get_Set_Daphne_Data;
    if user_Active_Local.EMULATORS.Arcade_D.Kronos then
    Get_Set_Kronos_Data;
    if user_Active_Local.EMULATORS.Arcade_D.Raine then
    Get_Set_Raine_Data;
    if user_Active_Local.EMULATORS.Arcade_D.Model2 then
    Get_Set_Model2_Data;
    if user_Active_Local.EMULATORS.Arcade_D.SuperModel then
    Get_Set_SuperModel_Data;
    if user_Active_Local.EMULATORS.Arcade_D.Demul then
    Get_Set_Demul_Data; }
end;

procedure Get_Computers_Data;
begin
  //
end;

procedure Get_Consoles_Data;
begin

end;

procedure Get_Handhelds_Data;
begin

end;

procedure Get_Pinballs_Data;
begin

end;

end.
