unit uEmu_Arcade_Mame_Game_Actions;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes;

const
  cShowGamePanelMenu: array [0 .. 10] of string = ('Play game', 'Read manual', 'Open media folder',
    'View images in fullscreen', 'Sound Tracks', 'Add to favorites', 'Add to playlist', '', '', '', '');

procedure Refresh;

procedure ArrowUp;
procedure ArrowDown;
procedure Enter;

implementation

uses
  uDatabase_ActiveUser,
  uDatabase_SQLCommands,
  emu,
  uLoad_AllTypes,
  uEmu_Commands,
  uEmu_Arcade_Mame_SetAll,
  uEmu_Arcade_Mame_AllTypes,
  uEmu_Arcade_Mame_Gamelist,
  uEmu_Arcade_Mame_Game_SetAll;

procedure Refresh;
var
  vi, ri: Integer;
begin
  uEmu_Arcade_Mame_Gamelist_Clear;
  ri := 0;
  for vi := 10 - (mame.Game.Menu_Selected) to 20 - (mame.Game.Menu_Selected) do
  begin
    vMame.Scene.Gamelist.List_Line[vi].Text.Text := cShowGamePanelMenu[ri];
    inc(ri, 1);
  end;
  if not FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Manuals + mame.Gamelist.ListRoms[mame.Gamelist.Selected] + '.pdf') then
    vMame.Scene.Gamelist.List_Line[11 - (mame.Game.Menu_Selected)].Text.Color := TAlphaColorRec.Red;
  if not FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Soundtracks + mame.Gamelist.ListRoms[mame.Gamelist.Selected] + '.zip')
  then
    vMame.Scene.Gamelist.List_Line[14 - (mame.Game.Menu_Selected)].Text.Color := TAlphaColorRec.Red;

  uEmu_Arcade_Mame_Gamelist_GlowSelected
end;

procedure Enter;
var
  romName: WideString;
begin
  romName := mame.Gamelist.ListRoms[mame.Gamelist.Selected];
  uEmu_Arcade_Mame_SetAll.Create_Loading_Game;
  case mame.Game.Menu_Selected of
    0:
      fEmu_Commands_RunGame(emulation.Arcade[0].Name_Exe, romName, emulation.Arcade[0].Emu_Path, 0);
    1:
      ;
    2:
      ;
    3:
      ;
    4:
      ;
    5:
      ;
    6:
      ;
  end;
  uEmu_Arcade_Mame_SetAll.Free_Loading_Game;
end;

procedure ArrowUp;
begin
  if mame.Game.Menu_Selected > 0 then
  begin
    dec(mame.Game.Menu_Selected, 1);
    Refresh;
  end;
end;

procedure ArrowDown;
begin
  if mame.Game.Menu_Selected < 6 then
  begin
    inc(mame.Game.Menu_Selected, 1);
    Refresh;
  end
end;

end.
