unit uEmu_Arcade_Mame_Keyboard;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  Bass;

procedure uEmu_Arcade_Mame_Keyboard_SetKey(vKey: string);

procedure uEmu_Arcade_Mame_Keyboard_VirtualKeyboard_SetKey(vKey: string);
procedure Search(vString: String);

implementation

uses
  uDatabase_ActiveUser,
  uLoad_AllTypes,
  uVirtual_Keyboard,
  uSnippet_Search,
  uEmu_Arcade_Mame_Gamelist,
  uEmu_Arcade_Mame_AllTypes,
  uEmu_Arcade_Mame_Actions,
  uEmu_Arcade_Mame_Game_Actions;

procedure uEmu_Arcade_Mame_Keyboard_SetKey(vKey: string);
begin
  if uSnippet_Search.vSearch.Actions.CanIType = False then
  begin
    if UpperCase(vKey) = 'ESC' then
      uEmu_Arcade_Mame_Actions.Return
    else
    begin
      if extrafe.prog.State = 'mame_filters' then
      begin

      end
      else if extrafe.prog.State = 'mame' then
      begin
        if UpperCase(vKey) = 'ENTER' then
        begin
          if uSnippet_Search.vSearch.Actions.ComesFromSearch = False then
            if vMame.Scene.Gamelist.List_Line[10].Text.Color <> TAlphaColorRec.Red then
              uEmu_Arcade_Mame_Actions_Enter;
        end
        else if UpperCase(vKey) = 'DOWN' then
          uEmu_Arcade_Mame_Gamelist_PushDown
        else if UpperCase(vKey) = 'UP' then
          uEmu_Arcade_Mame_Gamelist_PushUp
        else if UpperCase(vKey) = 'LEFT' then
          uEmu_Arcade_Mame_Gamelist_PushLeft
        else if UpperCase(vKey) = 'RIGHT' then
          uEmu_Arcade_Mame_Gamelist_PushRight
        else if UpperCase(vKey) = 'S' then
          uEmu_Arcade_Mame_Actions.Open_Search
        else if UpperCase(vKey) = 'Q' then
          uEmu_Arcade_Mame_Actions_OpenGlobalConfiguration
        else if UpperCase(vKey) = 'F' then
          uEmu_Arcade_Mame_Actions.Open_Filters
        else if UpperCase(vKey) = 'M' then
          uEmu_Arcade_Mame_Actions_ChangeSnapMode
        else if UpperCase(vKey) = 'K' then
          uEmu_Arcade_Mame_Actions_ChangeCategeroy('left')
        else if UpperCase(vKey) = 'L' then
          uEmu_Arcade_Mame_Actions_ChangeCategeroy('right');
      end
      else if extrafe.prog.State = 'mame_game' then
      begin
        if UpperCase(vKey) = 'ENTER' then
          uEmu_Arcade_Mame_Game_Actions.Enter
        else if UpperCase(vKey) = 'UP' then
          uEmu_Arcade_Mame_Game_Actions.ArrowUp
        else if UpperCase(vKey) = 'DOWN' then
          uEmu_Arcade_Mame_Game_Actions.ArrowDown;
      end;
    end;
  end
  else
    Search(uSnippet_Search.vSearch.Actions.Search_Str);

  uSnippet_Search.vSearch.Actions.ComesFromSearch := False;
end;

procedure uEmu_Arcade_Mame_Keyboard_VirtualKeyboard_SetKey(vKey: string);
var
  vStringResult: String;
  vIntegerResult: Integer;
  vGameName: String;
  vi, ri: Integer;
  vFoundResult: Boolean;
  vFoundDrop: Boolean;
begin
  if uVirtual_Keyboard.vKey.Options.vType = 'Search' then
  begin
    if (UpperCase(vKey) <> 'ENTER') and (UpperCase(vKey) <> 'ESC') and (UpperCase(vKey) <> 'UP') and (UpperCase(vKey) <> 'DOWN') and (UpperCase(vKey) <> 'LEFT')
      and (UpperCase(vKey) <> 'RIGHT') then
    begin
      vFoundResult := False;
      vFoundDrop := False;
      vStringResult := uVirtual_Keyboard.vKey.Construct.Edit.Edit.Text;
      if vStringResult = '' then
      begin
        mame.Gamelist.Selected := mame.Gamelist.Search_Selected;
        uEmu_Arcade_Mame_Gamelist_Refresh;
        uEmu_Arcade_Mame_Actions.Show_Media;
        uVirtual_Keyboard.Clear_Drop;
        uVirtual_Keyboard.vKey.Construct.Title.Text.Text := 'Search for a game';
      end
      else
      begin
        vIntegerResult := length(vStringResult);
        for vi := 0 to mame.Gamelist.Games_Count-1 do
        begin
          vGameName := Copy(mame.Gamelist.ListGames[vi], 0, vIntegerResult);
          if UpperCase(vStringResult) = UpperCase(vGameName) then
          begin
            vFoundResult := True;
            Break
          end;
        end;

        if vFoundResult then
        begin
          mame.Gamelist.Selected := vi;
          uVirtual_Keyboard.vKey.Construct.Title.Text.Text := 'Found "' + mame.Gamelist.ListGames[vi] + '"';
          inc(vi, 1);
          uEmu_Arcade_Mame_Gamelist_Refresh;
          uEmu_Arcade_Mame_Actions.Show_Media;
          uVirtual_Keyboard.Clear_Drop;
          for ri := 0 to 20 do
          begin
            vGameName := Copy(mame.Gamelist.ListGames[vi + ri], 0, vIntegerResult);
            if UpperCase(vStringResult) = UpperCase(vGameName) then
            begin
              if ri = 20 then
                uVirtual_Keyboard.Drop(ri, '...', '')
              else
                uVirtual_Keyboard.Drop(ri, mame.Gamelist.ListGames[vi + ri], user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'emu_mame.png');
            end
          end;
        end
        else
        begin
          vStringResult := uVirtual_Keyboard.vKey.Construct.Edit.Edit.Text;
          Delete(vStringResult, length(vStringResult), 1);
          uVirtual_Keyboard.vKey.Construct.Edit.Edit.Text := vStringResult;
          uVirtual_Keyboard.vKey.Construct.Edit.Edit.SelStart := length(uVirtual_Keyboard.vKey.Construct.Edit.Edit.Text);
          BASS_ChannelPlay(mame.Sound.Effects[0], False);
        end;

      end;
    end
    else
    begin
      if UpperCase(vKey) = 'ESC' then
      begin
        mame.Gamelist.Selected := mame.Gamelist.Search_Selected;
        uEmu_Arcade_Mame_Gamelist_Refresh;
        uEmu_Arcade_Mame_Actions.Show_Media;
        uVirtual_Keyboard.Animation(False);
      end
      else if UpperCase(vKey) = 'ENTER' then
      begin
        vFoundDrop := False;
        for vi := 0 to 19 do
          if Assigned(uVirtual_Keyboard.vKey.Construct.Drop.Line_Back[vi]) then
            if uVirtual_Keyboard.vKey.Construct.Drop.Line_Back[vi].Fill.Color = TAlphaColorRec.Deepskyblue then
            begin
              vFoundDrop := True;
              Break
            end;
        if vFoundDrop then
        begin
          uVirtual_Keyboard.vKey.Construct.Edit.Edit.Text := uVirtual_Keyboard.vKey.Construct.Drop.Text[vi].Text;
          uVirtual_Keyboard.vKey.Construct.Edit.Edit.SelStart := length(uVirtual_Keyboard.vKey.Construct.Edit.Edit.Text);
          uVirtual_Keyboard.Press('Drop');
        end
        else
          uVirtual_Keyboard.Animation(False);
      end;
    end;
  end;
end;

procedure Search(vString: String);
var
  vGameName: String;
  vi: Integer;
begin
  if vString = '' then
  begin
    mame.Gamelist.Selected := mame.Gamelist.Search_Selected;
    uEmu_Arcade_Mame_Gamelist_Refresh;
    uEmu_Arcade_Mame_Actions.Show_Media;
  end
  else
  begin
    for vi := 0 to mame.Gamelist.Games_Count - 1 do
    begin
      vGameName := Copy(mame.Gamelist.ListGames[vi], 0, length(vString));
      if UpperCase(vString) = UpperCase(vGameName) then
      begin
        mame.Gamelist.Selected := vi;
        uEmu_Arcade_Mame_Gamelist_Refresh;
        uEmu_Arcade_Mame_Actions.Show_Media;
        Break
      end;
    end;
    if UpperCase(vString) <> UpperCase(vGameName) then
    begin
      Delete(vSearch.Actions.Search_Str, length(uSnippet_Search.vSearch.Actions.Search_Str), 1);
      uSnippet_Search.vSearch.Scene.Edit.Text := uSnippet_Search.vSearch.Actions.Search_Str_Clear;
      BASS_ChannelPlay(mame.Sound.Effects[0], False);
      uSnippet_Search.vSearch.Actions.Str_Error := True;
    end;
  end;
end;

end.
