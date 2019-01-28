unit uAzHung_Actions;

interface

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.IniFiles,
  System.UiTypes,
  FMX.Objects,
  FMX.Layouts;

procedure uAzHung_Actions_Load;
procedure uAzHung_Actions_Free;

procedure uAzHung_Actions_ReturnToPlay;

procedure uAzHung_Actions_Start;
procedure uAzHung_Actions_ReturnToFirst_From_Start;
procedure uAzHung_Actions_StartGame;

procedure uAzHung_Actions_Create_Modes;
procedure uAzHung_Actions_Choose_Word;

procedure uAzHung_Actions_ClickLetter(vText: TText; vLetter: String);
procedure uAzHung_Actions_SettleTheScore(vNum: Integer);

procedure uAzHung_Actions_ShowLose;
procedure uAzHung_Actions_ShowWin;
procedure uAzHung_Actions_ShowWinList;
procedure uAzHung_Actions_PlayWinListAnim;

procedure uAzHung_Actions_Reload_Game_Win;
procedure uAzHung_Actions_Reload_Game_Lose_WithNewWord;
procedure uAzHung_Actions_Reload_Game_Lose_New;

implementation

uses
  uSnippet_Text,
  uLoad_AllTypes,
  uPlay_AllTypes,
  uAzHung_AllTypes,
  uAzHung_SetAll;

procedure uAzHung_Actions_Load;
begin
  gAzHung.Path.Game := addons.play.Ini.Path + 'azhung\';
  gAzHung.Path.Sounds := gAzHung.Path.Game + 'sounds\';
  gAzHung.Path.Images := gAzHung.Path.Game + 'images\';
  gAzHung.Path.Score := gAzHung.Path.Game + 'score\';

  uAzHung_SetAll_Set;
end;

procedure uAzHung_Actions_Free;
begin
  FreeAndNil(vAzHung.Main);
  addons.play.Actions.Game := '';
end;

procedure uAzHung_Actions_ReturnToPlay;
begin
  uAzHung_Actions_Free;
  vPlay.Img_Box_Ani.StartValue := vPlay.Img_Box.Position.X;
  vPlay.Img_Box_Ani.StopValue := 0;
  vPlay.Info_Ani.StartValue := vPlay.Info.Position.X;
  vPlay.Info_Ani.StopValue := 510;
  vPlay.Img_Box_Ani.Start;
  vPlay.Info_Ani.Start;
end;

procedure uAzHung_Actions_ReturnToFirst_From_Start;
begin
  uAzHung_SetAll_Set_First;
  if Assigned(vAzHung.Load.Start.Select.Frame) then
    FreeAndNil(vAzHung.Load.Start.Select.Frame);
  FreeAndNil(vAzHung.Load.Start.Select.Back);
end;

procedure uAzHung_Actions_Start;
begin
  uAzHung_SetAll_Set_Start;
  FreeAndNil(vAzHung.Load.Back);
end;

procedure uAzHung_Actions_StartGame;
begin
  gAzHung.Actions.Score := 0;
  gAzHung.Actions.Score_Before := 0;
  uAzHung_Actions_Create_Modes;
  uAzHung_SetAll_Set_Game;
  uAzHung_SetAll_Create_Lives(gAzHung.Actions.Lives);
  uAzHung_Actions_Choose_Word;
  if Assigned(vAzHung.Load.Start.Select.Frame) then
    FreeAndNil(vAzHung.Load.Start.Select.Frame);
  FreeAndNil(vAzHung.Load.Start.Select.Back);
end;

procedure uAzHung_Actions_Create_Modes;
var
  vWords_Ini: TIniFile;
begin
  vWords_Ini := TIniFile.Create(gAzHung.Path.Words + gAzHung.Actions.Words);

  gAzHung.Actions.Easy := TStringList.Create;
  gAzHung.Actions.Medium := TStringList.Create;
  gAzHung.Actions.Hard := TStringList.Create;

  gAzHung.Actions.Correct.List := TStringList.Create;
  gAzHung.Actions.Correct.Num := -1;

  if gAzHung.Actions.GameMode = 'easy' then
  begin
    vWords_Ini.ReadSectionValues('EASY', gAzHung.Actions.Easy);
    gAzHung.Actions.Lives := 6;
  end
  else if gAzHung.Actions.GameMode = 'medium' then
  begin
    vWords_Ini.ReadSectionValues('MEDIUM', gAzHung.Actions.Medium);
    gAzHung.Actions.Lives := 4;
  end
  else if gAzHung.Actions.GameMode = 'hard' then
  begin
    vWords_Ini.ReadSectionValues('HARD', gAzHung.Actions.Hard);
    gAzHung.Actions.Lives := 3;
  end;
  FreeAndNil(vWords_Ini);
end;

procedure uAzHung_Actions_Choose_Word;
var
  vRandomMax: Integer;
  vRandomLetter: Integer;
  vCountLetter: Integer;
  vi: Integer;
begin
  if gAzHung.Actions.GameMode = 'easy' then
  begin
    vRandomMax := gAzHung.Actions.Easy.Count - 1;
    gAzHung.Actions.Errors := 6;
    vAzHung.Game.Errors_V.Text := '0/6';
  end
  else if gAzHung.Actions.GameMode = 'medium' then
  begin
    vRandomMax := gAzHung.Actions.Medium.Count - 1;
    gAzHung.Actions.Errors := 4;
    vAzHung.Game.Errors_V.Text := '0/4';
  end
  else if gAzHung.Actions.GameMode = 'hard' then
  begin
    vRandomMax := gAzHung.Actions.Hard.Count - 1;
    gAzHung.Actions.Errors := 3;
    vAzHung.Game.Errors_V.Text := '0/3';
  end;

  vRandomLetter := Random(vRandomMax);

  if gAzHung.Actions.GameMode = 'easy' then
    gAzHung.Actions.WordToFind := UpperCase(gAzHung.Actions.Easy.ValueFromIndex[vRandomLetter])
  else if gAzHung.Actions.GameMode = 'medium' then
    gAzHung.Actions.WordToFind := UpperCase(gAzHung.Actions.Medium.ValueFromIndex[vRandomLetter])
  else if gAzHung.Actions.GameMode = 'hard' then
    gAzHung.Actions.WordToFind := UpperCase(gAzHung.Actions.Hard.ValueFromIndex[vRandomLetter]);

  gAzHung.Actions.Num_In_List := vRandomLetter;

  vCountLetter := Length(gAzHung.Actions.WordToFind);
  gAzHung.Actions.WordCountChars := vCountLetter;

  SetLength(vAzHung.Game.Letter_Un, vCountLetter);

  for vi := 0 to vCountLetter - 1 do
    uAzHung_SetALL_Create_Letter_Un(vi);
end;

procedure uAzHung_Actions_ClickLetter(vText: TText; vLetter: String);
var
  vNumChars: Integer;
  vListChars: TStringList;
  vi: Integer;
  vCountErrors: Integer;
begin
  if ContainsStr(gAzHung.Actions.WordToFind, vLetter) then
  begin
    vNumChars := uSnippet_Text_Occurrences_Char(vLetter, gAzHung.Actions.WordToFind);
    vListChars := uSnippet_Text_Occurrences_Char_Where(vLetter, gAzHung.Actions.WordToFind);
    if vNumChars = 1 then
      uAzHung_Actions_SettleTheScore(100)
    else if vNumChars = 2 then
      uAzHung_Actions_SettleTheScore(250)
    else if vNumChars = 3 then
      uAzHung_Actions_SettleTheScore(400)
    else if vNumChars = 4 then
      uAzHung_Actions_SettleTheScore(600);

    for vi := 0 to vNumChars - 1 do
    begin
      vAzHung.Game.Letter_Un[(vListChars.Strings[vi]).ToInteger - 1].Text := vLetter;
      vAzHung.Game.Letter_Un[(vListChars.Strings[vi]).ToInteger - 1].TextSettings.FontColor :=
        TAlphaColorRec.White;
    end;

    Dec(gAzHung.Actions.WordCountChars, vNumChars);
    vText.Visible := False;
    if gAzHung.Actions.WordCountChars = 0 then
      uAzHung_Actions_ShowWin;
  end
  else
  begin
    vAzHung.Game.Letter_Glow[vText.Tag].Enabled := False;
    vText.Visible := False;
    Dec(gAzHung.Actions.Errors, 1);
    if gAzHung.Actions.GameMode = 'easy' then
    begin
      vCountErrors := 6 - gAzHung.Actions.Errors;
      vAzHung.Game.Errors_V.Text := vCountErrors.ToString + '/6';
    end
    else if gAzHung.Actions.GameMode = 'medium' then
    begin
      vCountErrors := 4 - gAzHung.Actions.Errors;
      vAzHung.Game.Errors_V.Text := vCountErrors.ToString + '/4';
    end
    else if gAzHung.Actions.GameMode = 'hard' then
    begin
      vCountErrors := 3 - gAzHung.Actions.Errors;
      vAzHung.Game.Errors_V.Text := vCountErrors.ToString + '/3';
    end;
    uAzHung_Actions_SettleTheScore(-20);
    if gAzHung.Actions.Errors = 0 then
      uAzHung_Actions_ShowLose;
  end;
end;

procedure uAzHung_Actions_SettleTheScore(vNum: Integer);
begin
  if vNum = -20 then
  begin
    if gAzHung.Actions.Score > 19 then
      gAzHung.Actions.Score := gAzHung.Actions.Score + vNum;
  end
  else
    gAzHung.Actions.Score := gAzHung.Actions.Score + vNum;

  vAzHung.Game.Score_V.Text := gAzHung.Actions.Score.ToString;
end;

procedure uAzHung_Actions_ShowWinList;
var
  vi: Integer;
begin
  if gAzHung.Actions.Correct.Num <> -1 then
  begin
    SetLength(vAzHung.Game.Correct_ListWord, gAzHung.Actions.Correct.Num + 1);
    for vi := 0 to gAzHung.Actions.Correct.Num do
    begin
      if Assigned(vAzHung.Game.Correct_ListWord[vi]) then
        vAzHung.Game.Correct_ListWord[vi] := nil;
    end;

    for vi := 0 to gAzHung.Actions.Correct.Num do
      uAzHung_SetAll_Create_WinWord_InList(vi);
  end;
end;

procedure uAzHung_Actions_ShowWin;
begin
  vAzHung.Game.Back_Blur.Enabled := True;
  uAzHung_SetAll_CreateWin(gAzHung.Actions.WordToFind);
end;

procedure uAzHung_Actions_ShowLose;
begin
  vAzHung.Game.Back_Blur.Enabled := True;
  uAzHung_SetAll_CreateLose(gAzHung.Actions.WordToFind);
end;

procedure uAzHung_Actions_Reload_Game_Win;
begin

  if gAzHung.Actions.GameMode = 'easy' then
    gAzHung.Actions.Easy.Delete(gAzHung.Actions.Num_In_List)
  else if gAzHung.Actions.GameMode = 'medium' then
    gAzHung.Actions.Medium.Delete(gAzHung.Actions.Num_In_List)
  else if gAzHung.Actions.GameMode = 'hard' then
    gAzHung.Actions.Hard.Delete(gAzHung.Actions.Num_In_List);

  gAzHung.Actions.Score_Before := gAzHung.Actions.Score;
  FreeAndNil(vAzHung.Game.Lose.Back);
  FreeAndNil(vAzHung.Game.Back);
  uAzHung_SetAll_Set_Game;
  uAzHung_SetAll_Create_Lives(gAzHung.Actions.Lives);
  Inc(gAzHung.Actions.Correct.Num, 1);
  gAzHung.Actions.Correct.List.Add(gAzHung.Actions.WordToFind);
  uAzHung_Actions_ShowWinList;
  uAzHung_Actions_Choose_Word;
  vAzHung.Game.Score_V.Text := gAzHung.Actions.Score_Before.ToString;
  vAzHung.Game.Correct_Catch_Num.Text := (gAzHung.Actions.Correct.Num + 1).ToString;
end;

procedure uAzHung_Actions_Reload_Game_Lose_WithNewWord;
begin
  Dec(gAzHung.Actions.Lives, 1);
  FreeAndNil(vAzHung.Game.Lose.Back);
  FreeAndNil(vAzHung.Game.Back);
  uAzHung_SetAll_Set_Game;
  uAzHung_SetAll_Create_Lives(gAzHung.Actions.Lives);
  uAzHung_Actions_Choose_Word;
  vAzHung.Game.Score_V.Text := gAzHung.Actions.Score_Before.ToString;
end;

procedure uAzHung_Actions_Reload_Game_Lose_New;
begin
  FreeAndNil(vAzHung.Game.Lose.Back);
  FreeAndNil(vAzHung.Game.Back);
  uAzHung_SetAll_Set_First;
end;

procedure uAzHung_Actions_PlayWinListAnim;
begin
  if vAzHung.Game.Correct_Back.Position.X = vAzHung.Game.Back.Width then
  begin
    vAzHung.Game.Correct_Back_Ani.StartValue := vAzHung.Game.Back.Width;
    vAzHung.Game.Correct_Back_Ani.StopValue := vAzHung.Game.Back.Width - 240;
  end
  else
  begin
    vAzHung.Game.Correct_Back_Ani.StartValue := vAzHung.Game.Back.Width - 240;
    vAzHung.Game.Correct_Back_Ani.StopValue := vAzHung.Game.Back.Width;
  end;
  vAzHung.Game.Correct_Back_Ani.Start;
end;

end.
