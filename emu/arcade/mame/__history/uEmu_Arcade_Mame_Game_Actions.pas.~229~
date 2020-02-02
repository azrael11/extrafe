unit uEmu_Arcade_Mame_Game_Actions;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  FMX.Types;

const
  cShowGamePanelMenu: array [0 .. 10] of string = ('Play game', 'Read manual', 'Open media folder', 'View images in fullscreen', 'Sound Tracks', '', 'Add to playlist', '', '', '', '');

type
  TGAME_TIMER = class(TObject)
    procedure OnTimer(Sender: TObject);
  end;

procedure Refresh;

procedure Up;
procedure Down;
procedure Enter;

procedure Add_To_Favorites;

var
  vGame_Timer: TTimer;
  vGame_Timer_Action: TGAME_TIMER;
  play_count: String;

implementation

uses
  uDB,
  uDB_AUser,
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
  uEmu_Arcade_Mame_Gamelist.Clear;
  ri := 0;
  for vi := 10 - (mame.Game.Menu_Selected) to 20 - (mame.Game.Menu_Selected) do
  begin
    if ri = 5 then
    begin
      if vMame.Scene.Media.T_Players.Favorite.Visible then
        vMame.Scene.Gamelist.List_Line[vi].Text.Text := 'Remove from favorites'
      else
        vMame.Scene.Gamelist.List_Line[vi].Text.Text := 'Add to favorites';
    end
    else
      vMame.Scene.Gamelist.List_Line[vi].Text.Text := cShowGamePanelMenu[ri];
    inc(ri, 1);
  end;
  if not FileExists(uDB_AUser.Local.EMULATORS.Arcade_D.Media.Manuals + mame.Gamelist.ListRoms[mame.Gamelist.Selected] + '.pdf') then
    vMame.Scene.Gamelist.List_Line[11 - (mame.Game.Menu_Selected)].Text.Color := TAlphaColorRec.Red;
  if not FileExists(uDB_AUser.Local.EMULATORS.Arcade_D.Media.Soundtracks + mame.Gamelist.ListRoms[mame.Gamelist.Selected] + '.zip') then
    vMame.Scene.Gamelist.List_Line[14 - (mame.Game.Menu_Selected)].Text.Color := TAlphaColorRec.Red;

  uEmu_Arcade_Mame_Gamelist.Glow_Selected
end;

procedure Enter;
begin
  case mame.Game.Menu_Selected of
    0:
      begin
        uEmu_Arcade_Mame_Game_SetAll.Create_Loading_Game;
        play_count := uDB.Query_Select(uDB.Arcade_Query, 'play_count_id_'+ uDB_AUser.Local.Num.ToString , 'mame_status', 'romname', mame.Gamelist.ListRoms[mame.Gamelist.Selected]);
        vMame.Scene.PopUp.Line3_Value.Text := play_count;
        vGame_Timer := TTimer.Create(Emu_Form);
        vGame_Timer.Interval := 2500;
        vGame_Timer.OnTimer := vGame_Timer_Action.OnTimer;
        vGame_Timer.Enabled := True;
      end;
    1:
      ;
    2:
      ;
    3:
      ;
    4:
      ;
    5:
      Add_To_Favorites;
    6:
      ;
  end;
end;

procedure Up;
begin
  if mame.Game.Menu_Selected > 0 then
  begin
    dec(mame.Game.Menu_Selected, 1);
    Refresh;
  end;
end;

procedure Down;
begin
  if mame.Game.Menu_Selected < 6 then
  begin
    inc(mame.Game.Menu_Selected, 1);
    Refresh;
  end
end;

procedure Add_To_Favorites;
begin
  if vMame.Scene.Gamelist.List_Line[10].Text.Text = 'Add to favorites' then
  begin
    uDB.Query_Update(uDB.Arcade_Query, 'mame_status', 'fav_id_' + uDB_AUser.Local.Num.ToString, '1', 'romname', mame.Gamelist.ListRoms[mame.Gamelist.Selected]);
    vMame.Scene.Gamelist.List_Line[10].Text.Text := 'Remove from favorites';
    inc(mame.Favorites.Count, 1);
  end
  else
  begin
    uDB.Query_Update(uDB.Arcade_Query, 'mame_status', 'fav_id_' + uDB_AUser.Local.Num.ToString, '0', 'romname', mame.Gamelist.ListRoms[mame.Gamelist.Selected]);
    vMame.Scene.Gamelist.List_Line[10].Text.Text := 'Add to favorites';
    dec(mame.Favorites.Count, 1);
  end;
  vMame.Scene.Media.T_Players.Favorite.Visible := not vMame.Scene.Media.T_Players.Favorite.Visible;
end;

{ TGAME_TIMER }

procedure TGAME_TIMER.OnTimer(Sender: TObject);
var
  romName: WideString;
  play_int: Integer;
begin
  romName := mame.Gamelist.ListRoms[mame.Gamelist.Selected];
  vGame_Timer.Enabled := False;
  uEmu_Commands.Run_Game(emulation.Arcade[0].Name_Exe, romName, emulation.Arcade[0].Emu_Path, 0);
  play_int := play_count.ToInteger;
  inc(play_int, 1);
  uDB.Query_Update(uDB.Arcade_Query, 'mame_status', 'play_count_id_' + uDB_AUser.Local.Num.ToString, play_int.ToString, 'romname', mame.Gamelist.ListRoms[mame.Gamelist.Selected]);
  uEmu_Arcade_Mame_Game_SetAll.Free_Loading_Game;
  FreeAndNil(vGame_Timer);
end;

end.
