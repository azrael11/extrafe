unit uEmu_Consoles_Nes_Actions;

interface
uses
  System.Classes,
  System.SysUtils;

procedure Action(vAction: String);

procedure Exit_Nes;

implementation
uses
  uEmu_Consoles_Nes_AllTypes,
  uLoad_AllTypes,
  uEmu_Actions;

procedure Action(vAction: String);
begin
  if vAction = 'Emu_Exit' then
    Exit_Nes;
  
end;

procedure Exit_Nes;
begin
  FreeAndNil(vNES.Scene.Main);
  extrafe.prog.State := 'main';
  uEmu_Actions.Exit;
end;


end.
