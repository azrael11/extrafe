unit uEmu_Arcade_Mame_Filters;

interface

uses
  System.Classes,
  System.UiTypes,
  System.SysUtils,
  System.Inifiles,
  System.StrUtils,
  FMX.Objects,
  FMX.Listbox,
  FMX.StdCtrls,
  FMX.Effects,
  FMX.Types;

procedure Load(vView_Mode: String);

procedure Add;
procedure Clear_Filters;

procedure Remove(vPanel_Num: Integer);
procedure Sort_Filter_Panels;

procedure Second_Choose(vName: String; vPanel: Integer);
procedure Combo_Create_Filter(vFilter: String; vPanel: Integer);

procedure Filter_Result(vFilter, vResponse: String; vPanel: Integer);

procedure List_Result;

procedure Return;

implementation

uses
  uDB,
  uDB_AUser,
  uLoad_AllTypes,
  emu,
  uWindows,
  uEmu_Arcade_Mame,
  uEmu_Arcade_Mame_SetAll,
  uEmu_Arcade_Mame_Gamelist,
  uEmu_Arcade_Mame_AllTypes,
  uEmu_Arcade_Mame_Ini,
  {View Modes}
  uView_Mode_Default_AllTypes;

procedure Load(vView_Mode: String);
var
  vMain: Timage;
begin
  if vView_Mode = 'video' then
    vMain := Emu_VM_Video.main;

  if not Assigned(vMame.Scene.Gamelist.Filters.Window.Panel) then
  begin
    mame.Filters.Filter_Done := False;

    mame.Filters.Added := 0;
    mame.Filters.List_Added := TStringList.Create;
    mame.Filters.List_Added.NameValueSeparator := '=';
    mame.Filters.List := TStringList.Create;
    mame.Filters.List.Add('Year');
    mame.Filters.List.Add('Manufacturer');
    mame.Filters.List.Add('Genre');
    mame.Filters.List.Add('Adult');
    mame.Filters.List.Add('Original');
    mame.Filters.List.Add('Mechanical');
    mame.Filters.List.Add('Working');
    mame.Filters.List.Add('Monochrome');
    mame.Filters.List.Add('Screenless');
    mame.Filters.List.Add('Languages');

    mame.Filters.Temp_ListRoms := TStringList.Create;
    mame.Filters.Temp_ListGames := TStringList.Create;

    vMame.Scene.Gamelist.Filters.Window.Panel := TPanel.Create(vMain);
    vMame.Scene.Gamelist.Filters.Window.Panel.Name := 'Mame_Window_Filters';
    vMame.Scene.Gamelist.Filters.Window.Panel.Parent := vMain;
    vMame.Scene.Gamelist.Filters.Window.Panel.SetBounds(extrafe.res.Half_Width - 275, 250, 550, 300);
    vMame.Scene.Gamelist.Filters.Window.Panel.Visible := True;

    vMame.Scene.Gamelist.Filters.Window.Shadow := TShadowEffect.Create(vMame.Scene.Gamelist.Filters.Window.Panel);
    vMame.Scene.Gamelist.Filters.Window.Shadow.Name := 'Main_Window_Filters_Shadow';
    vMame.Scene.Gamelist.Filters.Window.Shadow.Parent := vMame.Scene.Gamelist.Filters.Window.Panel;
    vMame.Scene.Gamelist.Filters.Window.Shadow.Enabled := True;

    CreateHeader(vMame.Scene.Gamelist.Filters.Window.Panel, 'IcoMoon-Free', #$ea5b, TAlphaColorRec.DeepSkyBlue, 'Select desire filters to narrow the list', False, nil);

    vMame.Scene.Gamelist.Filters.Window.Info := TText.Create(vMame.Scene.Gamelist.Filters.Window.Panel);
    vMame.Scene.Gamelist.Filters.Window.Info.Name := 'Main_Window_Filters_Info';
    vMame.Scene.Gamelist.Filters.Window.Info.Parent := vMame.Scene.Gamelist.Filters.Window.Panel;
    vMame.Scene.Gamelist.Filters.Window.Info.SetBounds(10, 35, 400, 30);
    vMame.Scene.Gamelist.Filters.Window.Info.Font.Size := 14;
    vMame.Scene.Gamelist.Filters.Window.Info.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vMame.Scene.Gamelist.Filters.Window.Info.HorzTextAlign := TTextAlign.Leading;
    vMame.Scene.Gamelist.Filters.Window.Info.Text := 'Filtering list games : ';
    vMame.Scene.Gamelist.Filters.Window.Info.Visible := True;

    vMame.Scene.Gamelist.Filters.Window.Games_Num := TText.Create(vMame.Scene.Gamelist.Filters.Window.Panel);
    vMame.Scene.Gamelist.Filters.Window.Games_Num.Name := 'Main_Window_Filters_Games_Num';
    vMame.Scene.Gamelist.Filters.Window.Games_Num.Parent := vMame.Scene.Gamelist.Filters.Window.Panel;
    vMame.Scene.Gamelist.Filters.Window.Games_Num.SetBounds(136, 35, 400, 30);
    vMame.Scene.Gamelist.Filters.Window.Games_Num.Font.Size := 14;
    vMame.Scene.Gamelist.Filters.Window.Games_Num.TextSettings.FontColor := TAlphaColorRec.Limegreen;
    vMame.Scene.Gamelist.Filters.Window.Games_Num.HorzTextAlign := TTextAlign.Leading;
    vMame.Scene.Gamelist.Filters.Window.Games_Num.Text := mame.Gamelist.ListRoms.Count.ToString;
    vMame.Scene.Gamelist.Filters.Window.Games_Num.Visible := True;

    vMame.Scene.Gamelist.Filters.Window.Clear := TText.Create(vMame.Scene.Gamelist.Filters.Window.Panel);
    vMame.Scene.Gamelist.Filters.Window.Clear.Name := 'Mame_Window_Filters_Clear';
    vMame.Scene.Gamelist.Filters.Window.Clear.Parent := vMame.Scene.Gamelist.Filters.Window.Panel;
    vMame.Scene.Gamelist.Filters.Window.Clear.SetBounds(vMame.Scene.Gamelist.Filters.Window.Panel.Width - 80, 34, 30, 30);
    vMame.Scene.Gamelist.Filters.Window.Clear.Font.Family := 'IcoMoon-Free';
    vMame.Scene.Gamelist.Filters.Window.Clear.Font.Size := 24;
    vMame.Scene.Gamelist.Filters.Window.Clear.TextSettings.FontColor := TAlphaColorRec.Grey;
    vMame.Scene.Gamelist.Filters.Window.Clear.Text := #$e9ad;
    vMame.Scene.Gamelist.Filters.Window.Clear.OnClick := mame.Input.Mouse.Text.OnMouseClick;
    vMame.Scene.Gamelist.Filters.Window.Clear.OnMouseEnter := mame.Input.Mouse.Text.OnMouseEnter;
    vMame.Scene.Gamelist.Filters.Window.Clear.OnMouseLeave := mame.Input.Mouse.Text.OnMouseLeave;
    vMame.Scene.Gamelist.Filters.Window.Clear.Visible := True;

    vMame.Scene.Gamelist.Filters.Window.Clear_Glow := TGlowEffect.Create(vMame.Scene.Gamelist.Filters.Window.Clear);
    vMame.Scene.Gamelist.Filters.Window.Clear_Glow.Name := 'Mame_Window_Filters_Clear_Glow';
    vMame.Scene.Gamelist.Filters.Window.Clear_Glow.Parent := vMame.Scene.Gamelist.Filters.Window.Clear;
    vMame.Scene.Gamelist.Filters.Window.Clear_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    vMame.Scene.Gamelist.Filters.Window.Clear_Glow.Softness := 0.9;
    vMame.Scene.Gamelist.Filters.Window.Clear_Glow.Enabled := False;

    vMame.Scene.Gamelist.Filters.Window.Add := TText.Create(vMame.Scene.Gamelist.Filters.Window.Panel);
    vMame.Scene.Gamelist.Filters.Window.Add.Name := 'Mame_Window_Filters_Add';
    vMame.Scene.Gamelist.Filters.Window.Add.Parent := vMame.Scene.Gamelist.Filters.Window.Panel;
    vMame.Scene.Gamelist.Filters.Window.Add.SetBounds(vMame.Scene.Gamelist.Filters.Window.Panel.Width - 40, 34, 30, 30);
    vMame.Scene.Gamelist.Filters.Window.Add.Font.Family := 'IcoMoon-Free';
    vMame.Scene.Gamelist.Filters.Window.Add.Font.Size := 24;
    vMame.Scene.Gamelist.Filters.Window.Add.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vMame.Scene.Gamelist.Filters.Window.Add.Text := #$ea0a;
    vMame.Scene.Gamelist.Filters.Window.Add.OnClick := mame.Input.Mouse.Text.OnMouseClick;
    vMame.Scene.Gamelist.Filters.Window.Add.OnMouseEnter := mame.Input.Mouse.Text.OnMouseEnter;
    vMame.Scene.Gamelist.Filters.Window.Add.OnMouseLeave := mame.Input.Mouse.Text.OnMouseLeave;
    vMame.Scene.Gamelist.Filters.Window.Add.Visible := True;

    vMame.Scene.Gamelist.Filters.Window.Add_Glow := TGlowEffect.Create(vMame.Scene.Gamelist.Filters.Window.Add);
    vMame.Scene.Gamelist.Filters.Window.Add_Glow.Name := 'Mame_Window_Filters_Add_Glow';
    vMame.Scene.Gamelist.Filters.Window.Add_Glow.Parent := vMame.Scene.Gamelist.Filters.Window.Add;
    vMame.Scene.Gamelist.Filters.Window.Add_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    vMame.Scene.Gamelist.Filters.Window.Add_Glow.Softness := 0.9;
    vMame.Scene.Gamelist.Filters.Window.Add_Glow.Enabled := False;

    vMame.Scene.Gamelist.Filters.Window.OK := TButton.Create(vMame.Scene.Gamelist.Filters.Window.Panel);
    vMame.Scene.Gamelist.Filters.Window.OK.Name := 'Mame_Window_Filters_OK';
    vMame.Scene.Gamelist.Filters.Window.OK.Parent := vMame.Scene.Gamelist.Filters.Window.Panel;
    vMame.Scene.Gamelist.Filters.Window.OK.SetBounds(50, vMame.Scene.Gamelist.Filters.Window.Panel.Height - 40, 100, 30);
    vMame.Scene.Gamelist.Filters.Window.OK.Text := 'OK';
    vMame.Scene.Gamelist.Filters.Window.OK.Anchors := [TAnchorKind.akBottom, TAnchorKind.akLeft];
    vMame.Scene.Gamelist.Filters.Window.OK.OnClick := mame.Input.Mouse.Button.OnMouseClick;
    vMame.Scene.Gamelist.Filters.Window.OK.Visible := True;

    vMame.Scene.Gamelist.Filters.Window.Cancel := TButton.Create(vMame.Scene.Gamelist.Filters.Window.Panel);
    vMame.Scene.Gamelist.Filters.Window.Cancel.Name := 'Mame_Window_Filters_Cancel';
    vMame.Scene.Gamelist.Filters.Window.Cancel.Parent := vMame.Scene.Gamelist.Filters.Window.Panel;
    vMame.Scene.Gamelist.Filters.Window.Cancel.SetBounds(412, vMame.Scene.Gamelist.Filters.Window.Panel.Height - 40, 100, 30);
    vMame.Scene.Gamelist.Filters.Window.Cancel.Text := 'Cancel';
    vMame.Scene.Gamelist.Filters.Window.Cancel.Anchors := [TAnchorKind.akBottom, TAnchorKind.akRight];
    vMame.Scene.Gamelist.Filters.Window.Cancel.OnClick := mame.Input.Mouse.Button.OnMouseClick;
    vMame.Scene.Gamelist.Filters.Window.Cancel.Visible := True;
  end
  else
    vMame.Scene.Gamelist.Filters.Window.Panel.Visible := True;
end;

procedure Clear_Filters;
var
  vQuery: String;
  vi: Integer;
begin
  mame.Filters.Temp_ListRoms_Final.Clear;
  mame.Filters.Temp_ListGames_Final.Clear;

  for vi := 0 to mame.Filters.List_Added.Count - 1 do
    FreeAndNil(vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vi].Panel);

  mame.Filters.Added := 0;
  mame.Filters.List_Added.Clear;
  mame.Filters.Temp_ListRoms.Clear;
  mame.Filters.Temp_ListGames.Clear;

  vQuery := 'select gamename, romname from games order by gamename asc';
  uDB.Arcade_Query.Close;
  uDB.Arcade_Query.SQL.Clear;
  uDB.Arcade_Query.SQL.Text := vQuery;
  uDB.Arcade_Query.DisableControls;
  uDB.Arcade_Query.Open;
  uDB.Arcade_Query.First;

  try
    uDB.Arcade_Query.First;
    while not uDB.Arcade_Query.Eof do
    begin
      mame.Filters.Temp_ListGames_Final.Add(uDB.Arcade_Query.FieldByName('gamename').AsString);
      mame.Filters.Temp_ListRoms_Final.Add(uDB.Arcade_Query.FieldByName('romname').AsString);
      uDB.Arcade_Query.Next;
    end;
  finally
    uDB.Arcade_Query.EnableControls;
  end;

  vMame.Scene.Gamelist.Filters.Window.Games_Num.Text := mame.Filters.Temp_ListRoms_Final.Count.ToString;
  vMame.Scene.Gamelist.Filters.Window.Clear.TextSettings.FontColor := TAlphaColorRec.Grey;
end;

procedure Add;
var
  vi, vNum: Integer;
  vPanel_Height: Integer;
  vFilter_Index: Integer;
begin

  for vi := 0 to mame.Filters.List_Added.Count - 1 do
  begin
    if mame.Filters.List.IndexOf(mame.Filters.List_Added.Names[vi]) <> -1 then
    begin
      vFilter_Index := mame.Filters.List.IndexOf(mame.Filters.List_Added.Names[vi]);
      mame.Filters.List.Delete(vFilter_Index);
    end;
  end;

  for vi := 0 to mame.Filters.List_Added.Count - 1 do
  begin
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vi].Choose.Enabled := False;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vi].Sec_Choose.Enabled := False;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vi].Remove.TextSettings.FontColor := TAlphaColorRec.Grey;
  end;

  if (mame.Filters.Filter_Done) or (mame.Filters.Added = 0) then
  begin
    vPanel_Height := 0;
    inc(mame.Filters.Added, 1);
    SetLength(vMame.Scene.Gamelist.Filters.Window.Filter_Panels, mame.Filters.Added);

    vNum := mame.Filters.Added - 1;

    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Panel := TPanel.Create(vMame.Scene.Gamelist.Filters.Window.Panel);
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Panel.Name := 'Mame_Window_Filters_Filter_Panel_' + (vNum).ToString;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Panel.Parent := vMame.Scene.Gamelist.Filters.Window.Panel;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Panel.SetBounds(10, 70 + ((vNum) * 70), vMame.Scene.Gamelist.Filters.Window.Panel.Width - 20, 60);
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Panel.Visible := True;

    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove := TText.Create(vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Panel);
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.Name := 'Mame_Window_Filters_Filter_Remove_' + (vNum).ToString;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.Parent := vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Panel;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.SetBounds(vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Panel.Width - 36,
      15, 30, 30);
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.Font.Family := 'IcoMoon-Free';
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.Font.Size := 24;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.TextSettings.FontColor := TAlphaColorRec.Grey;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.Text := #$e9ac;
    // vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.OnClick := mame.Input.Mouse.Text.OnMouseClick;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.OnMouseEnter := mame.Input.Mouse.Text.OnMouseEnter;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.OnMouseLeave := mame.Input.Mouse.Text.OnMouseLeave;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.OnMouseUp := mame.Input.Mouse.Text.OnMouseUp;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.Tag := vNum;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.Visible := True;

    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove_Glow := TGlowEffect.Create(vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove);
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove_Glow.Name := 'Mame_Window_Filter_Remove_Glow_' + vNum.ToString;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove_Glow.Parent := vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove_Glow.Softness := 0.9;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Remove_Glow.Enabled := False;

    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Filter_Name := TText.Create(vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Panel);
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Filter_Name.Name := 'Mame_Window_Filters_Filter_Name_' + (vNum).ToString;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Filter_Name.Parent := vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Panel;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Filter_Name.SetBounds(10, 2, 300, 20);
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Filter_Name.Text := 'Filter : ';
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Filter_Name.Font.Size := 14;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Filter_Name.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Filter_Name.HorzTextAlign := TTextAlign.Leading;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Filter_Name.Visible := True;

    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Choose := TComboBox.Create(vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Panel);
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Choose.Name := 'Mame_Window_Filters_Filter_Combo_' + (vNum).ToString;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Choose.Parent := vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Panel;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Choose.SetBounds(10, 25, 150, 28);
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Choose.Tag := mame.Filters.Added - 1;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Choose.OnChange := mame.Input.Mouse.ComboBox.OnChange;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Choose.Visible := True;

    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result := TText.Create(vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Panel);
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result.Name := 'Mame_Window_Filters_Filter_Result_' + (vNum).ToString;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result.Parent := vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Panel;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result.SetBounds(340, 2, 150, 20);
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result.Text := 'Result';
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result.Font.Size := 14;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result.HorzTextAlign := TTextAlign.Center;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result.Visible := False;

    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Num := TText.Create(vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Panel);
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Num.Name := 'Mame_Window_Filters_Filter_Result_Num_' + (vNum).ToString;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Num.Parent := vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Panel;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Num.SetBounds(340, 20, 150, 20);
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Num.Text := '';
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Num.Font.Size := 14;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Num.TextSettings.FontColor := TAlphaColorRec.Limegreen;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Num.HorzTextAlign := TTextAlign.Center;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Num.Visible := False;

    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Games := TText.Create(vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Panel);
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Games.Name := 'Mame_Window_Filters_Filter_Result_Games_' + (vNum).ToString;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Games.Parent := vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Panel;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Games.SetBounds(340, 40, 150, 20);
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Games.Text := 'Games';
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Games.Font.Size := 14;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Games.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Games.HorzTextAlign := TTextAlign.Center;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Games.Visible := False;

    for vi := 0 to mame.Filters.List.Count do
    begin
      if vi = 0 then
        vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Choose.Items.Add('Choose...')
      else
        vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Choose.Items.Add(mame.Filters.List.Strings[vi - 1]);
    end;

    mame.Filters.Compo_Done := True;
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vNum].Choose.ItemIndex := 0;
    mame.Filters.Compo_Done := False;
    mame.Filters.Filter_Done := False;

    Sort_Filter_Panels;
    vMame.Scene.Gamelist.Filters.Window.Add.TextSettings.FontColor := TAlphaColorRec.Grey;
    vMame.Scene.Gamelist.Filters.Window.Clear.TextSettings.FontColor := TAlphaColorRec.Grey;
    vMame.Scene.Gamelist.Filters.Window.Add_Glow.Enabled := False;
  end;
end;

procedure Remove(vPanel_Num: Integer);
var
  vi: Integer;
  vSum_Height: Single;
  vRemoved_Filter, vQuery: String;
  vFind_Removed_Filter: Boolean;
begin
  vRemoved_Filter := mame.Filters.List_Added.Names[vPanel_Num];
  vFind_Removed_Filter := False;
  for vi := 0 to mame.Filters.List.Count - 1 do
    if mame.Filters.List.Strings[vi] = vRemoved_Filter then
    begin
      vFind_Removed_Filter := True;
      Break
    end;

  if vFind_Removed_Filter = False then
    mame.Filters.List.Add(vRemoved_Filter);

  Dec(mame.Filters.Added, 1);
  mame.Filters.List_Added.Delete(vPanel_Num);
  SetLength(vMame.Scene.Gamelist.Filters.Window.Filter_Panels, mame.Filters.Added + 1);

  vSum_Height := 0;

  if vPanel_Num = mame.Filters.Added then
  begin
    List_Result;
    FreeAndNil(vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel_Num].Sec_Choose);
    FreeAndNil(vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel_Num].Panel);
  end
  else
  begin
    List_Result;
    FreeAndNil(vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel_Num].Sec_Choose);
    FreeAndNil(vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel_Num].Panel);
    for vi := 0 to mame.Filters.Added do
    begin
      if vi >= vPanel_Num then
      begin
        if Assigned(vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vi + 1].Panel) then
        begin
          vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vi] := vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vi + 1];
          vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vi].Panel.Name := 'Mame_Window_Filters_Filter_Panel_' + vi.ToString;
          vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vi].Panel.Position.Y := 70 + (vi * 70);
        end;
        vSum_Height := vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vi].Panel.Position.Y;
      end;
    end;
  end;

  Sort_Filter_Panels;
end;

procedure Sort_Filter_Panels;
var
  vi: Integer;
  vSum_Height: Single;
begin
  if mame.Filters.Added > -1 then
  begin
    vSum_Height := 0;
    for vi := 0 to mame.Filters.Added - 1 do
      vSum_Height := vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vi].Panel.Position.Y;

    if vSum_Height + 130 < 300 then
      vMame.Scene.Gamelist.Filters.Window.Panel.Height := 300
    else
      vMame.Scene.Gamelist.Filters.Window.Panel.Height := vSum_Height + 130;
  end;
end;

procedure Combo_Create_Filter(vFilter: String; vPanel: Integer);
var
  vList_Filters, vBool_Filters: String;
  vi: Integer;
  vTemp_List: TStringList;
begin
  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Filter_Name.Text := 'Filter : ' + vFilter;

  vList_Filters := 'Year Manufacturer Genre Monochrome Languages';
  vBool_Filters := 'Adult Original Mechanical Working Screenless';
  vTemp_List := TStringList.Create;

  if Assigned(vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Sec_Choose) then
    FreeAndNil(vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Sec_Choose);

  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Sec_Choose := TComboBox.Create(vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Panel);
  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Sec_Choose.Name := 'Mame_Window_Filters_Filter_Combo_' + vFilter;
  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Sec_Choose.Parent := vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Panel;
  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Sec_Choose.SetBounds(180, 25, 150, 28);
  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Sec_Choose.OnChange := mame.Input.Mouse.ComboBox.OnChange;
  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Sec_Choose.TagString := vFilter;
  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Sec_Choose.Tag := vPanel;
  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Sec_Choose.Visible := True;

  // if mame.Filters.List_Added.Count <> 0 then
  // if mame.Filters.List_Added.Names[vPanel] <> vFilter then
  // vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Sec_Choose.Name := 'Mame_Window_Filters_Filter_Combo_' + vFilter;
  // vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Sec_Choose.Clear;
  // end;

  if AnsiContainsStr(vList_Filters, vFilter) then
  begin
    if vFilter = 'Year' then
      vTemp_List := mame.Gamelist.ListYear
    else if vFilter = 'Manufacturer' then
      vTemp_List := mame.Gamelist.ListManufaturer
    else if vFilter = 'Genre' then
      vTemp_List := mame.Gamelist.ListGenre
    else if vFilter = 'Monochrome' then
      vTemp_List := mame.Gamelist.ListMonochrome
    else if vFilter = 'Languages' then
      vTemp_List := mame.Gamelist.ListLanguages;

    for vi := 0 to vTemp_List.Count do
    begin
      if vi = 0 then
        vMame.Scene.Gamelist.Filters.Window.Filter_Panels[mame.Filters.Added - 1].Sec_Choose.Items.Add('Choose...')
      else
      begin
        if vTemp_List.Strings[vi - 1] <> '' then
          vMame.Scene.Gamelist.Filters.Window.Filter_Panels[mame.Filters.Added - 1].Sec_Choose.Items.Add(vTemp_List.Strings[vi - 1]);
      end;
    end;
  end
  else if AnsiContainsStr(vBool_Filters, vFilter) then
  begin
    vMame.Scene.Gamelist.Filters.Window.Filter_Panels[mame.Filters.Added - 1].Sec_Choose.Items.Add('Choose...');
    if vFilter = 'Adult' then
    begin
      vMame.Scene.Gamelist.Filters.Window.Filter_Panels[mame.Filters.Added - 1].Sec_Choose.Items.Add('All');
      vMame.Scene.Gamelist.Filters.Window.Filter_Panels[mame.Filters.Added - 1].Sec_Choose.Items.Add('Adult');
    end
    else if vFilter = 'Original' then
    begin
      vMame.Scene.Gamelist.Filters.Window.Filter_Panels[mame.Filters.Added - 1].Sec_Choose.Items.Add('Authentic');
      vMame.Scene.Gamelist.Filters.Window.Filter_Panels[mame.Filters.Added - 1].Sec_Choose.Items.Add('Clone');
    end
    else
    begin
      vMame.Scene.Gamelist.Filters.Window.Filter_Panels[mame.Filters.Added - 1].Sec_Choose.Items.Add('Yes');
      vMame.Scene.Gamelist.Filters.Window.Filter_Panels[mame.Filters.Added - 1].Sec_Choose.Items.Add('No');
    end;
  end;

  mame.Filters.Compo_Done := True;
  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[mame.Filters.Added - 1].Sec_Choose.ItemIndex := 0;
  mame.Filters.Compo_Done := False;

  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Result.Visible := False;
  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Result_Num.Visible := False;
  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Result_Games.Visible := False;

  vMame.Scene.Gamelist.Filters.Window.Add.TextSettings.FontColor := TAlphaColorRec.Grey;
  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Remove.TextSettings.FontColor := TAlphaColorRec.Grey;
end;

procedure Second_Choose(vName: String; vPanel: Integer);
begin
  case IndexStr(vName, ['Year', 'Manufacturer', 'Genre', 'Adult', 'Original', 'Mechanical', 'Working', 'Monochrome', 'Screenless', 'Languages']) of
    0:
      Combo_Create_Filter('Year', vPanel);
    1:
      Combo_Create_Filter('Manufacturer', vPanel);
    2:
      Combo_Create_Filter('Genre', vPanel);
    3:
      Combo_Create_Filter('Adult', vPanel);
    4:
      Combo_Create_Filter('Original', vPanel);
    5:
      Combo_Create_Filter('Mechanical', vPanel);
    6:
      Combo_Create_Filter('Working', vPanel);
    7:
      Combo_Create_Filter('Monochrome', vPanel);
    8:
      Combo_Create_Filter('Screenless', vPanel);
    9:
      Combo_Create_Filter('Languages', vPanel);
  end;
end;

procedure Filter_Result(vFilter, vResponse: String; vPanel: Integer);
var
  vQuery, vTitle, vValue: String;
  vFilter_Index, vi: Integer;
  vFilter_Found: Boolean;
begin

  mame.Filters.Temp_ListRoms.Clear;
  mame.Filters.Temp_ListGames.Clear;

  if (vFilter = 'Genre') or (vFilter = 'Manufacturer') or (vFilter = 'Year') then
    vValue := vResponse
  else
    vValue := LowerCase(vResponse);

  if vFilter = 'Adult' then
    vTitle := 'mature'
  else
    vTitle := LowerCase(vFilter);

  vQuery := 'SELECT romname, gamename FROM games WHERE ' + vTitle + '="' + vValue + '" ORDER BY romname ASC';
  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Filter_Name.Text := 'Filter : ' + vFilter + ' (' + vResponse + ')';

  uDB.Arcade_Query.Close;
  uDB.Arcade_Query.SQL.Clear;
  uDB.Arcade_Query.SQL.Text := vQuery;
  uDB.Arcade_Query.DisableControls;
  uDB.Arcade_Query.Open;

  try
    uDB.Arcade_Query.First;
    while not uDB.Arcade_Query.Eof do
    begin
      mame.Filters.Temp_ListRoms.Add(uDB.Arcade_Query.FieldByName('romname').AsString);
      mame.Filters.Temp_ListGames.Add(uDB.Arcade_Query.FieldByName('gamename').AsString);
      uDB.Arcade_Query.Next;
    end;
  finally
    uDB.Arcade_Query.EnableControls;
  end;

  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Result.Visible := True;
  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Result_Num.Text := mame.Filters.Temp_ListRoms.Count.ToString;
  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Result_Num.Visible := True;
  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Result_Games.Visible := True;

  if mame.Filters.List.IndexOf(vFilter) <> -1 then
  begin
    vFilter_Found := False;
    for vi := 0 to mame.Filters.List_Added.Count - 1 do
    begin
      if mame.Filters.List_Added.Names[vi] = vFilter then
      begin
        mame.Filters.List_Added.Insert(vi, vFilter + '=' + vResponse);
        mame.Filters.List_Added.Delete(vi + 1);
        mame.Filters.Filter_Done := True;
        vFilter_Found := True;
        Break
      end
    end;
    if vFilter_Found = False then
    begin
      mame.Filters.List_Added.Add(vFilter + '=' + vResponse);
      mame.Filters.Filter_Done := True;
    end;
  end
  else
  begin
    for vi := 0 to mame.Filters.List_Added.Count - 1 do
    begin
      if mame.Filters.List_Added.Names[vi] = vFilter then
      begin
        mame.Filters.List_Added.Insert(vi, vFilter + '=' + vResponse);
        mame.Filters.List_Added.Delete(vi + 1);
        mame.Filters.Filter_Done := True;
        vFilter_Found := True;
        Break
      end
    end;
  end;

  List_Result;
  vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vPanel].Remove.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
end;

procedure List_Result;
var
  vQuery, vConditions, vFilter, vFilter_Value: String;
  vi: Integer;
begin
  if Assigned(mame.Filters.Temp_ListRoms_Final) then
    FreeAndNil(mame.Filters.Temp_ListRoms_Final);
  if Assigned(mame.Filters.Temp_ListGames_Final) then
    FreeAndNil(mame.Filters.Temp_ListGames_Final);

  mame.Filters.Temp_ListRoms_Final := TStringList.Create;
  mame.Filters.Temp_ListGames_Final := TStringList.Create;

  vConditions := '';
  for vi := 0 to mame.Filters.List_Added.Count - 1 do
  begin
    vFilter := mame.Filters.List_Added.Names[vi];
    vFilter_Value := mame.Filters.List_Added.ValueFromIndex[vi];
    if vFilter = 'Adult' then
    begin
      vFilter := 'Mature';
      vFilter_Value := LowerCase(vFilter_Value);
    end
    else if vFilter = 'Working' then
      vFilter_Value := LowerCase(vFilter_Value)
    else if vFilter = 'Screenless' then
      vFilter_Value := LowerCase(vFilter_Value)
    else if vFilter = 'Mechanical' then
      vFilter_Value := LowerCase(vFilter_Value)
    else if vFilter = 'Original' then
      vFilter_Value := LowerCase(vFilter_Value);

    vFilter := LowerCase(vFilter);

    if vi = 0 then
      vConditions := ' ' + vFilter + '="' + vFilter_Value + '" '
    else
      vConditions := vConditions + ' AND ' + vFilter + '="' + vFilter_Value + '" ';
  end;

  if vConditions <> '' then
  begin
    vQuery := 'SELECT romname, gamename FROM games  WHERE ' + vConditions;
    uDB.Arcade_Query.Close;
    uDB.Arcade_Query.SQL.Clear;
    uDB.Arcade_Query.SQL.Text := vQuery;
    uDB.Arcade_Query.DisableControls;
    uDB.Arcade_Query.Open;

    try
      uDB.Arcade_Query.First;
      while not uDB.Arcade_Query.Eof do
      begin
        mame.Filters.Temp_ListRoms_Final.Add(uDB.Arcade_Query.FieldByName('romname').AsString);
        mame.Filters.Temp_ListGames_Final.Add(uDB.Arcade_Query.FieldByName('gamename').AsString);
        uDB.Arcade_Query.Next;
      end;
    finally
      uDB.Arcade_Query.EnableControls;
    end;

    if mame.Filters.Temp_ListRoms_Final.Count = 0 then
    begin
      vMame.Scene.Gamelist.Filters.Window.OK.Enabled := False;
      vMame.Scene.Gamelist.Filters.Window.Add.TextSettings.FontColor := TAlphaColorRec.Grey;
      vMame.Scene.Gamelist.Filters.Window.Clear.TextSettings.FontColor := TAlphaColorRec.Grey;
    end
    else
    begin
      vMame.Scene.Gamelist.Filters.Window.OK.Enabled := True;
      vMame.Scene.Gamelist.Filters.Window.Add.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vMame.Scene.Gamelist.Filters.Window.Clear.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end;

    for vi := 0 to mame.Filters.List_Added.Count - 1 do
    begin
      vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vi].Choose.Enabled := True;
      vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vi].Sec_Choose.Enabled := True;
      vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vi].Remove.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end;

    vMame.Scene.Gamelist.Filters.Window.Games_Num.Text := mame.Filters.Temp_ListRoms_Final.Count.ToString;
    vMame.Scene.Gamelist.Filters.Window.Clear.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  end
  else
    Clear_Filters;
end;

procedure Return;
var
  vi: Integer;
  vFilter_Name: String;
begin
  mame.Gamelist.ListRoms := mame.Filters.Temp_ListRoms_Final;
  mame.Gamelist.ListGames := mame.Filters.Temp_ListGames_Final;
  mame.Gamelist.Games_Count := mame.Gamelist.ListRoms.Count;
  uEmu_Arcade_Mame.Main;

  if mame.Filters.Added = 0 then
    vMame.Scene.Gamelist.Filters.Text.Text := 'All'
  else
  begin
    for vi := 0 to mame.Filters.Added - 1 do
    begin
      vFilter_Name := vMame.Scene.Gamelist.Filters.Window.Filter_Panels[vi].Filter_Name.Text;
      Delete(vFilter_Name, 1, 9);
      if vi = 0 then
        vMame.Scene.Gamelist.Filters.Text.Text := vFilter_Name
      else
        vMame.Scene.Gamelist.Filters.Text.Text := vMame.Scene.Gamelist.Filters.Text.Text + ', ' + vFilter_Name;
    end;
  end;
  extrafe.Prog.State := 'emu_mame';
end;

end.
