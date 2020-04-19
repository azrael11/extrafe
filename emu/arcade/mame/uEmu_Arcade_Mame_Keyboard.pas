unit uEmu_Arcade_Mame_Keyboard;

interface

uses
  System.Classes;

procedure Action(vAction: String);

implementation

uses
  uEmu_Arcade_Mame;

procedure Action(vAction: String);
begin
  if vAction = 'Exit' then
    uEmu_Arcade_Mame.Exit;
end;

end.
