unit uView_Mode_Video_Actions;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UITypes;

procedure Start_View_Mode(vSelected, vGames_Count: Integer; vList_Games, vList_Roms, vList_Path: TStringlist);

procedure Configuration_Action;
procedure Filters_Action;

procedure Refresh_Gamelist(vSelected, vGames_Count: Integer; vList_Games, vList_Roms, vList_Path: TStringlist);
procedure Refresh_Scene(vSelected: Integer; vList_Roms: TStringlist);

procedure Exit_Action;
procedure Move_Gamelist(vMove_Action: String);

implementation
uses
  uDB,
  uDB_AUser,
  uEmu_Emu,
  uSnippet_Text,
  uView_Mode_Video,
  uView_Mode_Video_Game,
  uView_Mode_Video_AllTypes,
  uView_Mode_Video_Actions_Filters;

procedure Configuration_Action;
begin
  if Emu_VM_Video_Var.Config_Open = False then
  begin
    Emu_VM_Video.Left_Ani.StartValue := 0;
    Emu_VM_Video.Left_Ani.StopValue := Emu_XML.config.Left_Limit.ToSingle;
    Emu_VM_Video.Right_Ani.StartValue := 960;
    Emu_VM_Video.Right_Ani.StopValue := Emu_XML.config.Right_Limit.ToSingle;
  end
  else
  begin
    uView_Mode_Video.Free_Configuarion;
    Emu_VM_Video.Left_Ani.StartValue := Emu_XML.config.Left_Limit.ToSingle;;
    Emu_VM_Video.Left_Ani.StopValue := 0;
    Emu_VM_Video.Right_Ani.StartValue := Emu_XML.config.Right_Limit.ToSingle;;
    Emu_VM_Video.Right_Ani.StopValue := 960;
  end;
  Emu_VM_Video_Var.Config_Open := not Emu_VM_Video_Var.Config_Open;
  Emu_VM_Video.Left_Ani.Start;
  Emu_VM_Video.Right_Ani.Start;
  Emu_VM_Video.Left_Blur.Enabled := Emu_VM_Video_Var.Config_Open;
  Emu_VM_Video.Right_Blur.Enabled := Emu_VM_Video_Var.Config_Open;
end;

procedure Filters_Action;
begin
  if Emu_VM_Video_Var.Filters_Open then
  begin
    Emu_VM_Video.Gamelist.Filters.Window.Panel.Visible:= False;
    Emu_VM_Video.Settings_Ani.Start;
    if Emu_VM_Video.Media.Video.Video.IsPause then
      Emu_VM_Video.Media.Video.Video.Resume;
  end
  else
  begin
    uView_Mode_Video_Actions_Filters.Create_Window;
    if Emu_VM_Video.Media.Video.Video.IsPlay then
      Emu_VM_Video.Media.Video.Video.Pause;
    Emu_VM_Video.Settings_Ani.Stop;
  end;
  Emu_VM_Video.Left_Blur.Enabled := not Emu_VM_Video_Var.Filters_Open;
  Emu_VM_Video.Right_Blur.Enabled := not Emu_VM_Video_Var.Filters_Open;

  Emu_VM_Video_Var.Filters_Open := not Emu_VM_Video_Var.Filters_Open;
  uEmu_Emu.Mouse_Action('Emu_Gamelist_Filters_Icon');
end;

procedure Refresh_Gamelist(vSelected, vGames_Count: Integer; vList_Games, vList_Roms, vList_Path: TStringlist);
var
  vi, ri, ki: Integer;
begin
  Emu_VM_Video_Var.Gamelist.Loaded := False;
  for vi := 0 to 20 do
  begin
    Emu_VM_Video.Gamelist.Games.Line[vi].Text.Text := '';
    Emu_VM_Video.Gamelist.Games.Line[vi].Text.Color := TAlphaColorRec.White;
  end;

  ri := vSelected - 10;
  for vi := 0 to 20 do
  begin
    if ((vSelected + 10) + vi < 20) or (vSelected + vi >= vGames_Count + 10) then
    begin
      Emu_VM_Video.Gamelist.Games.Line[vi].Text.Text := '';
      ri := -1;
    end
    else
    begin
      Emu_VM_Video.Gamelist.Games.Line[vi].Text.Text := vList_Games.Strings[ri];
      if vi = 10 then
      begin
        if uSnippet_Text_ToPixels(Emu_VM_Video.Gamelist.Games.Line[vi].Text) > 640 then
          Emu_VM_Video.Gamelist.Games.Line[vi].Text.Text := uSnippet_Text_SetInGivenPixels(620, Emu_VM_Video.Gamelist.Games.Line[vi].Text);
      end
      else
      begin
        if uSnippet_Text_ToPixels(Emu_VM_Video.Gamelist.Games.Line[vi].Text) > 640 then
          Emu_VM_Video.Gamelist.Games.Line[vi].Text.Text := uSnippet_Text_SetInGivenPixels(640, Emu_VM_Video.Gamelist.Games.Line[vi].Text);
      end;
      for ki := 0 to vList_Path.Count - 1 do
      begin
        if FileExists(vList_Path.Strings[ki] + '\' + vList_Roms[ri] + '.zip') then
          Emu_VM_Video.Gamelist.Games.Line[vi].Text.Color := TAlphaColorRec.White
        else
          Emu_VM_Video.Gamelist.Games.Line[vi].Text.Color := TAlphaColorRec.Red;
      end;
    end;
    inc(ri, 1);

  end;

  Emu_VM_Video.Gamelist.Games.Selection.Enabled := False;
  Emu_VM_Video.Gamelist.Games.Selection.Enabled := True;

  Emu_VM_Video.Gamelist.Info.Games_Count.Text := IntToStr(vSelected + 1) + '/' + IntToStr(vGames_Count);
  Emu_VM_Video_Var.Gamelist.Loaded := True;
end;

procedure Refresh_Scene(vSelected: Integer; vList_Roms: TStringlist);
begin
  if FileExists(uDB_AUser.Local.Emulators.Arcade_D.Media.Videos + vList_Roms[vSelected] + '.mp4') then
  begin
    // Emu_VM_Video.Media.Video.Video_Timer_Cont.Enabled := False;
    // Emu_VM_Video_Var.Video.Loaded := False;
    // Emu_VM_Video_Var.Video.Active_Video := uDB_AUser.Local.Emulators.Arcade_D.Media.Videos + vList_Roms[vSelected] + '.mp4';
    // Emu_VM_Video.Media.Video.Video.Play(uDB_AUser.Local.Emulators.Arcade_D.Media.Videos + vList_Roms[vSelected] + '.mp4');
    // Emu_VM_Video.Media.Video.Game_Info.Players_Value.Text := uDB.Query_Select(uDB.Arcade_Query, 'nplayers', 'games', 'romname', vList_Roms[vSelected]);
    // Emu_VM_Video.Media.Video.Game_Info.Favorite.Visible := uDB.Query_Select(uDB.Arcade_Query, 'fav_id_' + uDB_AUser.Local.Num.ToString, 'mame_status',
    // 'romname', vList_Roms[vSelected]).ToBoolean;
  end
  else
  begin
    if FileExists(uDB_AUser.Local.Emulators.Arcade_D.Media.Snapshots + vList_Roms[vSelected] + '.png') then
      Emu_VM_Video.Media.Video.Video.PlayNormal(uDB_AUser.Local.Emulators.Arcade_D.Media.Snapshots + vList_Roms[vSelected] + '.png')
    else
      Emu_VM_Video.Media.Video.Video.PlayNormal(uDB_AUser.Local.Emulators.Arcade_D.Media.Snapshots + 'imagenotfound.png');
  end;
end;

procedure Start_View_Mode(vSelected, vGames_Count: Integer; vList_Games, vList_Roms, vList_Path: TStringlist);
begin
  Emu_VM_Video_Var.Gamelist.Games := TStringlist.Create;
  Emu_VM_Video_Var.Gamelist.Roms := TStringlist.Create;
  Emu_VM_Video_Var.Gamelist.Paths := TStringlist.Create;

  Emu_VM_Video_Var.Gamelist.Selected := vSelected;
  Emu_VM_Video_Var.Gamelist.Total_Games := vGames_Count;
  Emu_VM_Video_Var.Gamelist.Roms := vList_Roms;
  Emu_VM_Video_Var.Gamelist.Games := vList_Games;
  Emu_VM_Video_Var.Gamelist.Paths := vList_Path;

  Refresh_Gamelist(Emu_VM_Video_Var.Gamelist.Selected, Emu_VM_Video_Var.Gamelist.Total_Games, Emu_VM_Video_Var.Gamelist.Games, Emu_VM_Video_Var.Gamelist.Roms,
    Emu_VM_Video_Var.Gamelist.Paths);
  Refresh_Scene(Emu_VM_Video_Var.Gamelist.Selected, Emu_VM_Video_Var.Gamelist.Roms);
end;

procedure Move_Gamelist(vMove_Action: String);
begin
  if vMove_Action = 'DOWN' then
  begin
    if Emu_VM_Video_Var.Gamelist.Selected < Emu_VM_Video_Var.Gamelist.Total_Games - 1 then
      inc(Emu_VM_Video_Var.Gamelist.Selected, 1);
  end
  else if vMove_Action = 'UP' then
  begin
    if Emu_VM_Video_Var.Gamelist.Selected > 0 then
      Dec(Emu_VM_Video_Var.Gamelist.Selected, 1);
  end
  else if vMove_Action = 'PAGE UP' then
  begin
    if Emu_VM_Video_Var.Gamelist.Selected > 20 then
      Dec(Emu_VM_Video_Var.Gamelist.Selected, 20);
  end
  else if vMove_Action = 'PAGE DOWN' then
  begin
    if Emu_VM_Video_Var.Gamelist.Selected < Emu_VM_Video_Var.Gamelist.Total_Games - 20 then
      inc(Emu_VM_Video_Var.Gamelist.Selected, 20);
  end
  else if vMove_Action = 'HOME' then
    Emu_VM_Video_Var.Gamelist.Selected := 0
  else if vMove_Action = 'END' then
    Emu_VM_Video_Var.Gamelist.Selected := Emu_VM_Video_Var.Gamelist.Total_Games - 1;

  Refresh_Gamelist(Emu_VM_Video_Var.Gamelist.Selected, Emu_VM_Video_Var.Gamelist.Total_Games, Emu_VM_Video_Var.Gamelist.Games, Emu_VM_Video_Var.Gamelist.Roms,
    Emu_VM_Video_Var.Gamelist.Paths);
  Emu_VM_Video.Gamelist.Gamelist.Timer.Enabled := True;
end;

procedure Exit_Action;
begin
  if Emu_VM_Video_Var.Config_Open then
    Configuration_Action
  else if Emu_VM_Video_Var.Game_Mode then
    uView_Mode_Video_Game.Return
  else if Emu_VM_Video_Var.Filters_Open then
    Filters_Action
  else
    uEmu_Emu.Key_Action('Exit');
end;

end.