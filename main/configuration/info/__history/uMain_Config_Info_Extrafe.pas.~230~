unit uMain_Config_Info_Extrafe;

interface

uses
  System.Classes,
  System.UiTypes,
  System.SysUtils,
  Winapi.Windows,
  Winapi.ShellAPI,
  FMX.Types,
  FMX.StdCtrls,
  FMX.Effects,
  FMX.Objects,
  FMX.Memo;

procedure Load;

procedure Open_Link(vLink: String);

procedure Read_Build(mStable, mBuild: string);
procedure Previous_Stable;
procedure Next_Stable;
procedure Previous_Build;
procedure Next_Build;

function Get_Max_Build_Num(mPath: string): Integer;

implementation

uses
  uLoad_AllTypes,
  uMain_AllTypes;

var
  Major: Integer;
  Minor: Integer;
  Realeash: Integer;
  Build: Integer;
  MaxNumber_Build: Integer;

procedure Load;
begin
  mainScene.Config.Main.R.Info.Extrafe.Creator := TLabel.Create(mainScene.Config.Main.R.Info.TabItem[0]);
  mainScene.Config.Main.R.Info.Extrafe.Creator.Name := 'Main_Config_Info_ExtraFE_Creator';
  mainScene.Config.Main.R.Info.Extrafe.Creator.Parent := mainScene.Config.Main.R.Info.TabItem[0];
  mainScene.Config.Main.R.Info.Extrafe.Creator.SetBounds(10, 20, 100, 24);
  mainScene.Config.Main.R.Info.Extrafe.Creator.Text := 'Creator : ';
  mainScene.Config.Main.R.Info.Extrafe.Creator.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.Creator_V := TLabel.Create(mainScene.Config.Main.R.Info.TabItem[0]);
  mainScene.Config.Main.R.Info.Extrafe.Creator_V.Name := 'Main_Config_Info_ExtraFE_Creator_V';
  mainScene.Config.Main.R.Info.Extrafe.Creator_V.Parent := mainScene.Config.Main.R.Info.TabItem[0];
  mainScene.Config.Main.R.Info.Extrafe.Creator_V.SetBounds(120, 20, 400, 24);
  mainScene.Config.Main.R.Info.Extrafe.Creator_V.Text := 'Nikos Kordas [ AKA(azrael11) ]';
  mainScene.Config.Main.R.Info.Extrafe.Creator_V.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.Desc := TLabel.Create(mainScene.Config.Main.R.Info.TabItem[0]);
  mainScene.Config.Main.R.Info.Extrafe.Desc.Name := 'Main_Config_Info_ExtraFE_Description';
  mainScene.Config.Main.R.Info.Extrafe.Desc.Parent := mainScene.Config.Main.R.Info.TabItem[0];
  mainScene.Config.Main.R.Info.Extrafe.Desc.SetBounds(10, 40, 100, 24);
  mainScene.Config.Main.R.Info.Extrafe.Desc.Text := 'Description : ';
  mainScene.Config.Main.R.Info.Extrafe.Desc.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.Desc_V := TLabel.Create(mainScene.Config.Main.R.Info.TabItem[0]);
  mainScene.Config.Main.R.Info.Extrafe.Desc_V.Name := 'Main_Config_Info_ExtraFE_Description_V';
  mainScene.Config.Main.R.Info.Extrafe.Desc_V.Parent := mainScene.Config.Main.R.Info.TabItem[0];
  mainScene.Config.Main.R.Info.Extrafe.Desc_V.SetBounds(120, 40, 400, 24);
  mainScene.Config.Main.R.Info.Extrafe.Desc_V.Text := 'Fun platform for emulatos/games with great addons';
  mainScene.Config.Main.R.Info.Extrafe.Desc_V.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.Stable := TLabel.Create(mainScene.Config.Main.R.Info.TabItem[0]);
  mainScene.Config.Main.R.Info.Extrafe.Stable.Name := 'Main_Config_Info_ExtraFE_Stable';
  mainScene.Config.Main.R.Info.Extrafe.Stable.Parent := mainScene.Config.Main.R.Info.TabItem[0];
  mainScene.Config.Main.R.Info.Extrafe.Stable.SetBounds(10, 60, 100, 24);
  mainScene.Config.Main.R.Info.Extrafe.Stable.Text := 'Version : ';
  mainScene.Config.Main.R.Info.Extrafe.Stable.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.Stable_V := TLabel.Create(mainScene.Config.Main.R.Info.TabItem[0]);
  mainScene.Config.Main.R.Info.Extrafe.Stable_V.Name := 'Main_Config_Info_ExtraFE_Stable_V';
  mainScene.Config.Main.R.Info.Extrafe.Stable_V.Parent := mainScene.Config.Main.R.Info.TabItem[0];
  mainScene.Config.Main.R.Info.Extrafe.Stable_V.SetBounds(120, 60, 400, 24);
  mainScene.Config.Main.R.Info.Extrafe.Stable_V.Text := Extrafe.prog.Version.Major + '.' +
    Extrafe.prog.Version.Minor + '.' + Extrafe.prog.Version.Realeash + '.' + Extrafe.prog.Version.Build;
  mainScene.Config.Main.R.Info.Extrafe.Stable_V.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.Homepage := TLabel.Create(mainScene.Config.Main.R.Info.TabItem[0]);
  mainScene.Config.Main.R.Info.Extrafe.Homepage.Name := 'Main_Config_Info_ExtraFE_Homepage';
  mainScene.Config.Main.R.Info.Extrafe.Homepage.Parent := mainScene.Config.Main.R.Info.TabItem[0];
  mainScene.Config.Main.R.Info.Extrafe.Homepage.SetBounds(10, 90, 100, 24);
  mainScene.Config.Main.R.Info.Extrafe.Homepage.Text := 'Homepage :';
  mainScene.Config.Main.R.Info.Extrafe.Homepage.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.Homepage_V := TText.Create(mainScene.Config.Main.R.Info.TabItem[0]);
  mainScene.Config.Main.R.Info.Extrafe.Homepage_V.Name := 'Main_Config_Info_ExtraFE_Homepage_V';
  mainScene.Config.Main.R.Info.Extrafe.Homepage_V.Parent := mainScene.Config.Main.R.Info.TabItem[0];
  mainScene.Config.Main.R.Info.Extrafe.Homepage_V.SetBounds(120, 90, 400, 24);
  mainScene.Config.Main.R.Info.Extrafe.Homepage_V.TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.Main.R.Info.Extrafe.Homepage_V.TextSettings.HorzAlign := TTextAlign.Leading;
  mainScene.Config.Main.R.Info.Extrafe.Homepage_V.Text := 'http://extrafe.epizy.com';
  mainScene.Config.Main.R.Info.Extrafe.Homepage_V.OnClick := ex_main.Input.mouse_config.Text.OnMouseClick;
  mainScene.Config.Main.R.Info.Extrafe.Homepage_V.OnMouseEnter :=
    ex_main.Input.mouse_config.Text.OnMouseEnter;
  mainScene.Config.Main.R.Info.Extrafe.Homepage_V.OnMouseLeave :=
    ex_main.Input.mouse_config.Text.OnMouseLeave;
  mainScene.Config.Main.R.Info.Extrafe.Homepage_V.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.Documentation :=
    TLabel.Create(mainScene.Config.Main.R.Info.TabItem[0]);
  mainScene.Config.Main.R.Info.Extrafe.Documentation.Name := 'Main_Config_Info_ExtraFE_Documentation';
  mainScene.Config.Main.R.Info.Extrafe.Documentation.Parent := mainScene.Config.Main.R.Info.TabItem[0];
  mainScene.Config.Main.R.Info.Extrafe.Documentation.SetBounds(10, 110, 100, 24);
  mainScene.Config.Main.R.Info.Extrafe.Documentation.Text := 'Documentation :';
  mainScene.Config.Main.R.Info.Extrafe.Documentation.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.Documentation_V :=
    TText.Create(mainScene.Config.Main.R.Info.TabItem[0]);
  mainScene.Config.Main.R.Info.Extrafe.Documentation_V.Name := 'Main_Config_Info_ExtraFE_Documentation_V';
  mainScene.Config.Main.R.Info.Extrafe.Documentation_V.Parent := mainScene.Config.Main.R.Info.TabItem[0];
  mainScene.Config.Main.R.Info.Extrafe.Documentation_V.SetBounds(120, 110, 400, 24);
  mainScene.Config.Main.R.Info.Extrafe.Documentation_V.TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.Main.R.Info.Extrafe.Documentation_V.TextSettings.HorzAlign := TTextAlign.Leading;
  mainScene.Config.Main.R.Info.Extrafe.Documentation_V.Text := 'http://extrafe.epizy.com/doc/';
  mainScene.Config.Main.R.Info.Extrafe.Documentation_V.OnClick :=
    ex_main.Input.mouse_config.Text.OnMouseClick;
  mainScene.Config.Main.R.Info.Extrafe.Documentation_V.OnMouseEnter :=
    ex_main.Input.mouse_config.Text.OnMouseEnter;
  mainScene.Config.Main.R.Info.Extrafe.Documentation_V.OnMouseLeave :=
    ex_main.Input.mouse_config.Text.OnMouseLeave;
  mainScene.Config.Main.R.Info.Extrafe.Documentation_V.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.Forum := TLabel.Create(mainScene.Config.Main.R.Info.TabItem[0]);
  mainScene.Config.Main.R.Info.Extrafe.Forum.Name := 'Main_Config_Info_ExtraFE_Forum';
  mainScene.Config.Main.R.Info.Extrafe.Forum.Parent := mainScene.Config.Main.R.Info.TabItem[0];
  mainScene.Config.Main.R.Info.Extrafe.Forum.SetBounds(10, 130, 100, 24);
  mainScene.Config.Main.R.Info.Extrafe.Forum.Text := 'Forum :';
  mainScene.Config.Main.R.Info.Extrafe.Forum.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.Forum_V := TText.Create(mainScene.Config.Main.R.Info.TabItem[0]);
  mainScene.Config.Main.R.Info.Extrafe.Forum_V.Name := 'Main_Config_Info_ExtraFE_Forum_V';
  mainScene.Config.Main.R.Info.Extrafe.Forum_V.Parent := mainScene.Config.Main.R.Info.TabItem[0];
  mainScene.Config.Main.R.Info.Extrafe.Forum_V.SetBounds(120, 130, 400, 24);
  mainScene.Config.Main.R.Info.Extrafe.Forum_V.TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.Main.R.Info.Extrafe.Forum_V.TextSettings.HorzAlign := TTextAlign.Leading;
  mainScene.Config.Main.R.Info.Extrafe.Forum_V.OnClick := ex_main.Input.mouse_config.Text.OnMouseClick;
  mainScene.Config.Main.R.Info.Extrafe.Forum_V.OnMouseEnter := ex_main.Input.mouse_config.Text.OnMouseEnter;
  mainScene.Config.Main.R.Info.Extrafe.Forum_V.OnMouseLeave := ex_main.Input.mouse_config.Text.OnMouseLeave;
  mainScene.Config.Main.R.Info.Extrafe.Forum_V.Text := 'http://extrafe.epizy.com/smf/';
  mainScene.Config.Main.R.Info.Extrafe.Forum_V.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.History_Group :=
    TGroupBox.Create(mainScene.Config.Main.R.Info.TabItem[0]);
  mainScene.Config.Main.R.Info.Extrafe.History_Group.Name := 'Main_Config_Info_ExtrFE_History_Group';
  mainScene.Config.Main.R.Info.Extrafe.History_Group.Parent := mainScene.Config.Main.R.Info.TabItem[0];
  mainScene.Config.Main.R.Info.Extrafe.History_Group.SetBounds(10, 160,
    mainScene.Config.Main.R.Info.TabControl.Width - 20, mainScene.Config.Main.R.Info.TabControl.Height - 190);
  mainScene.Config.Main.R.Info.Extrafe.History_Group.Text := 'History :';
  mainScene.Config.Main.R.Info.Extrafe.History_Group.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.Stable_Left :=
    TSpeedbutton.Create(mainScene.Config.Main.R.Info.Extrafe.History_Group);
  mainScene.Config.Main.R.Info.Extrafe.Stable_Left.Name := 'Main_Config_Info_ExtraFE_Stable_Left';
  mainScene.Config.Main.R.Info.Extrafe.Stable_Left.Parent :=
    mainScene.Config.Main.R.Info.Extrafe.History_Group;
  mainScene.Config.Main.R.Info.Extrafe.Stable_Left.SetBounds(380, 10, 20, 20);
  mainScene.Config.Main.R.Info.Extrafe.Stable_Left.StyleLookup := 'arrowlefttoolbutton';
  mainScene.Config.Main.R.Info.Extrafe.Stable_Left.OnClick :=
    ex_main.Input.mouse_config.Speedbutton.OnMouseClick;
  mainScene.Config.Main.R.Info.Extrafe.Stable_Left.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.Stable_Right :=
    TSpeedbutton.Create(mainScene.Config.Main.R.Info.Extrafe.History_Group);
  mainScene.Config.Main.R.Info.Extrafe.Stable_Right.Name := 'Main_Config_Info_ExtraFE_Stable_Right';
  mainScene.Config.Main.R.Info.Extrafe.Stable_Right.Parent :=
    mainScene.Config.Main.R.Info.Extrafe.History_Group;
  mainScene.Config.Main.R.Info.Extrafe.Stable_Right.SetBounds(450, 10, 20, 20);
  mainScene.Config.Main.R.Info.Extrafe.Stable_Right.OnClick :=
    ex_main.Input.mouse_config.Speedbutton.OnMouseClick;
  mainScene.Config.Main.R.Info.Extrafe.Stable_Right.StyleLookup := 'arrowrighttoolbutton';
  mainScene.Config.Main.R.Info.Extrafe.Stable_Right.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.Stable_History_Num :=
    TLabel.Create(mainScene.Config.Main.R.Info.Extrafe.History_Group);
  mainScene.Config.Main.R.Info.Extrafe.Stable_History_Num.Name := 'Main_Config_Info_ExtraFE_Stable_History';
  mainScene.Config.Main.R.Info.Extrafe.Stable_History_Num.Parent :=
    mainScene.Config.Main.R.Info.Extrafe.History_Group;
  mainScene.Config.Main.R.Info.Extrafe.Stable_History_Num.SetBounds(410, 10, 50, 24);
  mainScene.Config.Main.R.Info.Extrafe.Stable_History_Num.Text := Extrafe.prog.Version.Major + '.' +
    Extrafe.prog.Version.Minor + '.' + Extrafe.prog.Version.Realeash;
  mainScene.Config.Main.R.Info.Extrafe.Stable_History_Num.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.Build_Left :=
    TSpeedbutton.Create(mainScene.Config.Main.R.Info.Extrafe.History_Group);
  mainScene.Config.Main.R.Info.Extrafe.Build_Left.Name := 'Main_Config_Info_ExtraFE_LastBuild_Left';
  mainScene.Config.Main.R.Info.Extrafe.Build_Left.Parent :=
    mainScene.Config.Main.R.Info.Extrafe.History_Group;
  mainScene.Config.Main.R.Info.Extrafe.Build_Left.SetBounds(480, 10, 20, 20);
  mainScene.Config.Main.R.Info.Extrafe.Build_Left.StyleLookup := 'arrowlefttoolbutton';
  mainScene.Config.Main.R.Info.Extrafe.Build_Left.OnClick :=
    ex_main.Input.mouse_config.Speedbutton.OnMouseClick;
  mainScene.Config.Main.R.Info.Extrafe.Build_Left.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.Build_Right :=
    TSpeedbutton.Create(mainScene.Config.Main.R.Info.Extrafe.History_Group);
  mainScene.Config.Main.R.Info.Extrafe.Build_Right.Name := 'Main_Config_Info_ExtraFE_LastBuild_Right';
  mainScene.Config.Main.R.Info.Extrafe.Build_Right.Parent :=
    mainScene.Config.Main.R.Info.Extrafe.History_Group;
  mainScene.Config.Main.R.Info.Extrafe.Build_Right.SetBounds(550, 10, 20, 20);
  mainScene.Config.Main.R.Info.Extrafe.Build_Right.StyleLookup := 'arrowrighttoolbutton';
  mainScene.Config.Main.R.Info.Extrafe.Build_Right.OnClick :=
    ex_main.Input.mouse_config.Speedbutton.OnMouseClick;
  mainScene.Config.Main.R.Info.Extrafe.Build_Right.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.Build_History_Num :=
    TLabel.Create(mainScene.Config.Main.R.Info.Extrafe.History_Group);
  mainScene.Config.Main.R.Info.Extrafe.Build_History_Num.Name := 'Main_Config_Info_ExtraFE_LastBuild_History';
  mainScene.Config.Main.R.Info.Extrafe.Build_History_Num.Parent :=
    mainScene.Config.Main.R.Info.Extrafe.History_Group;
  mainScene.Config.Main.R.Info.Extrafe.Build_History_Num.SetBounds(520, 10, 50, 24);
  mainScene.Config.Main.R.Info.Extrafe.Build_History_Num.Text := Extrafe.prog.Version.Build;
  mainScene.Config.Main.R.Info.Extrafe.Build_History_Num.Visible := True;

  mainScene.Config.Main.R.Info.Extrafe.History_Info :=
    TMemo.Create(mainScene.Config.Main.R.Info.Extrafe.History_Group);
  mainScene.Config.Main.R.Info.Extrafe.History_Info.Name := 'Main_Config_Info_ExtraFE_HistoryInfo';
  mainScene.Config.Main.R.Info.Extrafe.History_Info.Parent :=
    mainScene.Config.Main.R.Info.Extrafe.History_Group;
  mainScene.Config.Main.R.Info.Extrafe.History_Info.SetBounds(10, 40,
    mainScene.Config.Main.R.Info.Extrafe.History_Group.Width - 20,
    mainScene.Config.Main.R.Info.Extrafe.History_Group.Height - 50);
  mainScene.Config.Main.R.Info.Extrafe.History_Info.ReadOnly := True;
  mainScene.Config.Main.R.Info.Extrafe.History_Info.Visible := True;

  Read_Build((Extrafe.prog.Version.Major + '.' + Extrafe.prog.Version.Minor + '.' +
    Extrafe.prog.Version.Realeash), Extrafe.prog.Version.Build);
  Major := StrToInt(Extrafe.prog.Version.Major);
  Minor := StrToInt(Extrafe.prog.Version.Minor);
  Realeash := StrToInt(Extrafe.prog.Version.Realeash);
  Build := StrToInt(Extrafe.prog.Version.Build);
  MaxNumber_Build:= Build;
end;

//

procedure Open_Link(vLink: String);
begin
  ShellExecute(0, 'open', PChar(vLink), nil, nil, SW_SHOWNORMAL);
end;

procedure Read_Build(mStable, mBuild: string);
var
  vFullPath: string;
  vTextFile: TextFile;
  vStr1: string;
  vStr_1: string;
  iPos: SmallInt;
begin
  mainScene.Config.Main.R.Info.Extrafe.History_Info.Lines.Clear;
  vStr_1 := 'nothing';
  vFullPath := StringReplace(mStable, '.', '_', [rfReplaceAll, rfIgnoreCase]);
  vFullPath := Extrafe.prog.Paths.History + 'history_' + vFullPath + '.txt';
  AssignFile(vTextFile, vFullPath);
  Reset(vTextFile);
  while not Eof(vTextFile) do
  begin
    Readln(vTextFile, vStr1);
    iPos := Pos('$', vStr1);
    if iPos <> 0 then
    begin
      vStr_1 := vStr1;
      Delete(vStr_1, 1, 1);
    end;
    if vStr_1 = mBuild then
      mainScene.Config.Main.R.Info.Extrafe.History_Info.Lines.Add(vStr1);
  end;
  CloseFile(vTextFile);
end;

procedure Previous_Stable;
var
  vPath: string;
  vFullPath: string;
begin
  Dec(Realeash, 1);
  vPath := Extrafe.prog.Version.Major + '.' + Extrafe.prog.Version.Minor + '.' + IntToStr(Realeash);
  vFullPath := StringReplace(vPath, '.', '_', [rfReplaceAll, rfIgnoreCase]);
  vFullPath := Extrafe.prog.Paths.History + 'history_' + vFullPath + '.txt';
  if FileExists(vFullPath, True) then
  begin
    if Realeash > -1 then
    begin
      MaxNumber_Build := Get_Max_Build_Num(Extrafe.prog.Version.Major + '.' + Extrafe.prog.Version.Minor + '.'
        + IntToStr(Realeash));
      mainScene.Config.Main.R.Info.Extrafe.Stable_History_Num.Text := IntToStr(Major) + '.' + IntToStr(Minor)
        + '.' + IntToStr(Realeash);
      mainScene.Config.Main.R.Info.Extrafe.Build_History_Num.Text := IntToStr(MaxNumber_Build);
      Build := MaxNumber_Build;
      Read_Build(Extrafe.prog.Version.Major + '.' + Extrafe.prog.Version.Minor + '.' + IntToStr(Realeash),
        IntToStr(MaxNumber_Build));
    end;
  end
  else
    Inc(Realeash, 1);
end;

procedure Next_Stable;
var
  mPath: string;
begin
  Inc(Realeash, 1);
  mPath := Extrafe.prog.Version.Major + '.' + Extrafe.prog.Version.Minor + '.' + IntToStr(Realeash);
  mPath := StringReplace(mPath, '.', '_', [rfReplaceAll, rfIgnoreCase]);
  mPath := Extrafe.prog.Paths.History + 'history_' + mPath + '.txt';
  if FileExists(mPath, False) then
  begin
    if Realeash <= StrToInt(Extrafe.prog.Version.Realeash) then
    begin
      MaxNumber_Build := Get_Max_Build_Num(Extrafe.prog.Version.Major + '.' + Extrafe.prog.Version.Minor + '.'
        + IntToStr(Realeash));
      mainScene.Config.Main.R.Info.Extrafe.Stable_History_Num.Text := IntToStr(Major) + '.' + IntToStr(Minor)
        + '.' + IntToStr(Realeash);
      mainScene.Config.Main.R.Info.Extrafe.Build_History_Num.Text := IntToStr(MaxNumber_Build);
      Build := MaxNumber_Build;
      Read_Build(Extrafe.prog.Version.Major + '.' + Extrafe.prog.Version.Minor + '.' + IntToStr(Realeash),
        IntToStr(MaxNumber_Build));
    end;
  end
  else
    Dec(Realeash, 1);
end;

procedure Previous_Build;
begin
  Dec(Build, 1);
  if Build > -1 then
  begin
    mainScene.Config.Main.R.Info.Extrafe.Build_History_Num.Text := IntToStr(Build);
    Read_Build(Extrafe.prog.Version.Major + '.' + Extrafe.prog.Version.Minor + '.' + IntToStr(Realeash),
      IntToStr(Build));
  end;
end;

procedure Next_Build;
begin
  Inc(Build, 1);
  if Build <= MaxNumber_Build then
  begin
    mainScene.Config.Main.R.Info.Extrafe.Build_History_Num.Text := IntToStr(Build);
    Read_Build(Extrafe.prog.Version.Major + '.' + Extrafe.prog.Version.Minor + '.' + IntToStr(Realeash),
      IntToStr(Build));
  end
  else
    Build := MaxNumber_Build;
end;

function Get_Max_Build_Num(mPath: string): Integer;
var
  vFullPath: string;
  vTextFile: TextFile;
  vStr1: string;
  vStr_1: string;
  iPos: SmallInt;
begin
  vStr_1 := 'nothing';
  vFullPath := StringReplace(mPath, '.', '_', [rfReplaceAll, rfIgnoreCase]);
  vFullPath := Extrafe.prog.Paths.History + 'history_' + vFullPath + '.txt';
  AssignFile(vTextFile, vFullPath);
  Reset(vTextFile);
  while not Eof(vTextFile) do
  begin
    Readln(vTextFile, vStr1);
    iPos := Pos('$', vStr1);
    if iPos <> 0 then
    begin
      vStr_1 := vStr1;
      Delete(vStr_1, 1, 1);
      Result := StrToInt(vStr_1);
      Break
    end;
  end;
  CloseFile(vTextFile);
end;

end.
