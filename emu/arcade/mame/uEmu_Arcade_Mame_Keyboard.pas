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
      uEmu_Arcade_Mame_Actions_Escape
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
          uEmu_Arcade_Mame_Actions_OpenSearch
        else if UpperCase(vKey) = 'Q' then
          uEmu_Arcade_Mame_Actions_OpenGlobalConfiguration
        else if UpperCase(vKey) = 'F' then
          uEmu_Arcade_Mame_Actions_OpenFilters
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
          uEmu_Arcade_Mame_Game_Actions_Enter
        else if UpperCase(vKey) = 'UP' then
          uEmu_Arcade_Mame_Game_Actions_ArrowUp
        else if UpperCase(vKey) = 'DOWN' then
          uEmu_Arcade_Mame_Game_Actions_ArrowDown;
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
    if (UpperCase(vKey) <> 'ENTER') and (UpperCase(vKey) <> 'ESC') and (UpperCase(vKey) <> 'UP') and
      (UpperCase(vKey) <> 'DOWN') then
    begin
      vFoundResult := False;
      vFoundDrop := False;
      vStringResult := uVirtual_Keyboard.vKey.Construct.Edit.Edit.Text;
      if vStringResult = '' then
      begin
        mame.Gamelist.Selected := vMame_Search_Current_Selected;
        uEmu_Arcade_Mame_Gamelist_Refresh;
        uEmu_Arcade_Mame_Actions_ShowData;
        uVirtual_Keyboard.vKey.Options.Drop_Num := -1;
        uVirtual_Keyboard.vKey.Options.Drop_Current := -1;
        for ri := 20 downto 0 do
          if Assigned(uVirtual_Keyboard.vKey.Construct.Drop.Line_Back[ri]) then
            FreeAndNil(uVirtual_Keyboard.vKey.Construct.Drop.Line_Back[ri]);
        uVirtual_Keyboard.vKey.Construct.Drop.Back.Height := 0;
        uVirtual_Keyboard.vKey.Construct.Title.Text.Text := 'Search for a game';
      end
      else
      begin
        vIntegerResult := length(vStringResult);
        for vi := 0 to mame.Gamelist.Games_Count do
        begin
          vGameName := Copy(mame.Gamelist.List[0, vi, 1], 0, vIntegerResult);
          if UpperCase(vStringResult) = UpperCase(vGameName) then
          begin
            vFoundResult := True;
            Break
          end;
        end;

        if vFoundResult then
        begin
          mame.Gamelist.Selected := vi;
          uVirtual_Keyboard.vKey.Construct.Title.Text.Text := 'Found "' + mame.Gamelist.List[0, vi, 1] + '"';
          inc(vi, 1);
          uEmu_Arcade_Mame_Gamelist_Refresh;
          uEmu_Arcade_Mame_Actions_ShowData;
          uVirtual_Keyboard.vKey.Options.Drop_Num := -1;
          uVirtual_Keyboard.vKey.Options.Drop_Current := -1;
          for ri := 20 downto 0 do
          begin
            if Assigned(uVirtual_Keyboard.vKey.Construct.Drop.Line_Back[ri]) then
              FreeAndNil(uVirtual_Keyboard.vKey.Construct.Drop.Line_Back[ri]);
          end;
          uVirtual_Keyboard.vKey.Construct.Drop.Back.Height := 0;
          for ri := 0 to 20 do
          begin
            vGameName := Copy(mame.Gamelist.List[0, vi + ri, 1], 0, vIntegerResult);
            if UpperCase(vStringResult) = UpperCase(vGameName) then
            begin
              if ri = 20 then
                uVirtual_Keyboard.Drop(ri, '...', '')
              else
                uVirtual_Keyboard.Drop(ri, mame.Gamelist.List[0, vi + ri, 1],
                  mame.prog.Images + 'emu_mame.png');
            end
          end;
        end
        else
        begin
          vStringResult := uVirtual_Keyboard.vKey.Construct.Edit.Edit.Text;
          Delete(vStringResult, length(vStringResult), 1);
          uVirtual_Keyboard.vKey.Construct.Edit.Edit.Text := vStringResult;
          uVirtual_Keyboard.vKey.Construct.Edit.Edit.SelStart :=
            length(uVirtual_Keyboard.vKey.Construct.Edit.Edit.Text);
          // Put code what to do if result not found like (warning, sound etc)
        end;

      end;
    end
    else
    begin
      if UpperCase(vKey) = 'ESC' then
      begin
        mame.Gamelist.Selected := vMame_Search_Current_Selected;
        uEmu_Arcade_Mame_Gamelist_Refresh;
        uEmu_Arcade_Mame_Actions_ShowData;
        uVirtual_Keyboard.Animation(False);
      end
      else if UpperCase(vKey) = 'ENTER' then
      begin
        vFoundDrop := False;
        for vi := 0 to 19 do
          if Assigned(uVirtual_Keyboard.vKey.Construct.Drop.Line_Back[vi]) then
            if uVirtual_Keyboard.vKey.Construct.Drop.Line_Back[vi].Fill.Color = TAlphaColorRec.Deepskyblue
            then
            begin
              vFoundDrop := True;
              Break
            end;
        if vFoundDrop then
        begin
          uVirtual_Keyboard.vKey.Construct.Edit.Edit.Text :=
            uVirtual_Keyboard.vKey.Construct.Drop.Text[vi].Text;
          uVirtual_Keyboard.vKey.Construct.Edit.Edit.SelStart :=
            length(uVirtual_Keyboard.vKey.Construct.Edit.Edit.Text);
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
  vIntegerResult: Integer;
  vGameName: String;
  vi, ri: Integer;
  vFoundResult: Boolean;
begin

  vFoundResult := False;
  if vString = '' then
  begin
    mame.Gamelist.Selected := vMame_Search_Current_Selected;
    vFoundResult:= True;
  end
  else
  begin
    vIntegerResult := length(vString);
    for vi := 0 to mame.Gamelist.Games_Count do
    begin
      vGameName := Copy(mame.Gamelist.List[0, vi, 1], 0, vIntegerResult);
      if UpperCase(vString) = UpperCase(vGameName) then
      begin
        vFoundResult := True;
        Break
      end;
    end;
    mame.Gamelist.Selected := vi;
  end;

  if vFoundResult then
  begin
    uEmu_Arcade_Mame_Gamelist_Refresh;
    uEmu_Arcade_Mame_Actions_ShowData;
  end
  else
  begin
    Delete(vSearch.Actions.Search_Str, length(uSnippet_Search.vSearch.Actions.Search_Str), 1);
    uSnippet_Search.vSearch.Scene.Edit.Text := uSnippet_Search.vSearch.Actions.Search_Str_Clear;
    BASS_ChannelPlay(mame.Sound.Effects[0], False);
    uSnippet_Search.vSearch.Actions.Str_Error:= True;
  end;
end;

end.
