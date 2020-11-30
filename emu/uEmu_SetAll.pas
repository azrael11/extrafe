unit uEmu_SetAll;

interface
uses
  System.Classes,
  System.SysUtils,
  System.UITypes,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Effects,
  FMX.Graphics,
  FMX.Types;


  const
    cEmu_Arcade_Path= 'emu\arcade\';
    cEmu_Computers_Path= 'emu\computers\';
    cEmu_Consoles_Path= 'emu\consoles\';
    cEmu_Handhelds_Path= 'emu\handhelds\';
    cEmu_Pinballs_Path= 'emu\Pinballs\';


  procedure uEmu_SetComponentsToRightPlace;


implementation
uses
  uLoad,
  uLoad_AllTypes,
  emu,
  main, uDB_AUser;

procedure uEmu_SetComponentsToRightPlace;
begin
  Emu_Form.Width:= uDB_AUser.Local.SETTINGS.Resolution.Width;
  Emu_Form.Height:= uDB_AUser.Local.SETTINGS.Resolution.Height;

  Emu_Form.Emu_Stylebook.loadFromFile(extrafe.style.Path+ extrafe.style.Name+ '.style');
  Emu_Form.StyleBook:= Emu_Form.Emu_Stylebook;
end;

end.
