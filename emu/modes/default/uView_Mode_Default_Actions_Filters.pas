unit uView_Mode_Default_Actions_Filters;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UITypes,
  System.StrUtils,
  FMX.Types,
  FMX.Objects,
  FMX.Effects,
  FMX.Listbox,
  FMX.Graphics,
  FMX.StdCtrls;

type
  TFILTERS = record
    year: Boolean;
    manufacturer: Boolean;
    genre: Boolean;
    adult: Boolean;
    original: Boolean;
    mechanical: Boolean;
    working: Boolean;
    monochrome: Boolean;
    screenless: Boolean;
    languages: Boolean;
  end;

procedure Create_Window;

procedure Add;
procedure Sort_Panels;

procedure Second_Choose(vName: String; vPanel: Integer);
procedure Combo_Create_Filter(vFilter: String; vPanel: Integer);
procedure Filter_Result(vFilter, vResponse: String; vPanel: Integer);
procedure List_Result;
procedure Clear_Filters;
procedure Remove(vPanel_Num: Integer);
procedure Sort_Filter_Panels;

procedure Close_Window;

procedure Return;

procedure set_filter(vName: String; vState: Boolean);

function Get_List(vList: String): TStringList;

var
  vState_Filters: TFILTERS;

implementation

uses
  uDB,
  UDB_AUser,
  uLoad_AllTypes,
  uView_Mode_Default_Actions,
  uView_Mode_Default_Mouse,
  uView_Mode_Default_AllTypes,
  {emulators Arcade}
  uEmu_Arcade_Mame_AllTypes;

procedure Create_Window;
var
  vi: Integer;
begin
  if not Assigned(Emu_VM_Default.Gamelist.Filters.Window.Panel) then
  begin
    Emu_VM_Default_Var.Filters.Added := 0;
    Emu_VM_Default_Var.Filters.List := TStringList.Create;
    Emu_VM_Default_Var.Filters.List_Added := TStringList.Create;
    Emu_VM_Default_Var.Filters.List_Added.NameValueSeparator := '=';

    for vi := 0 to Emu_XML.Filters.main.Count - 1 do
      Emu_VM_Default_Var.Filters.List.Add(Emu_XML.Filters.main[vi]);

    Emu_VM_Default_Var.Filters.Roms := TStringList.Create;
    Emu_VM_Default_Var.Filters.Games := TStringList.Create;
    Emu_VM_Default_Var.Filters.Temp_Roms := TStringList.Create;
    Emu_VM_Default_Var.Filters.Temp_Games := TStringList.Create;

    Emu_VM_Default_Var.Filters.Roms := Emu_VM_Default_Var.Gamelist.Roms;
    Emu_VM_Default_Var.Filters.Games := Emu_VM_Default_Var.Gamelist.Games;

    Emu_VM_Default.Gamelist.Filters.Window.Panel := TPanel.Create(Emu_VM_Default.main);
    Emu_VM_Default.Gamelist.Filters.Window.Panel.name := 'Emu_Filters_Window';
    Emu_VM_Default.Gamelist.Filters.Window.Panel.Parent := Emu_VM_Default.main;
    Emu_VM_Default.Gamelist.Filters.Window.Panel.SetBounds(extrafe.res.Half_Width - 275, 250, 550, 300);
    Emu_VM_Default.Gamelist.Filters.Window.Panel.Visible := True;

    Emu_VM_Default.Gamelist.Filters.Window.Shadow := TShadowEffect.Create(Emu_VM_Default.Gamelist.Filters.Window.Panel);
    Emu_VM_Default.Gamelist.Filters.Window.Shadow.name := 'Emu_Filters_Window_Shadow';
    Emu_VM_Default.Gamelist.Filters.Window.Shadow.Parent := Emu_VM_Default.Gamelist.Filters.Window.Panel;
    Emu_VM_Default.Gamelist.Filters.Window.Shadow.Enabled := True;

    CreateHeader(Emu_VM_Default.Gamelist.Filters.Window.Panel, 'IcoMoon-Free', #$ea5b, TAlphaColorRec.Deepskyblue, 'Select desire filters to narrow the list',
      False, nil);

    Emu_VM_Default.Gamelist.Filters.Window.Info := TText.Create(Emu_VM_Default.Gamelist.Filters.Window.Panel);
    Emu_VM_Default.Gamelist.Filters.Window.Info.name := 'Emu_Filters_Window_Info';
    Emu_VM_Default.Gamelist.Filters.Window.Info.Parent := Emu_VM_Default.Gamelist.Filters.Window.Panel;
    Emu_VM_Default.Gamelist.Filters.Window.Info.SetBounds(10, 35, 400, 30);
    Emu_VM_Default.Gamelist.Filters.Window.Info.Font.Size := 14;
    Emu_VM_Default.Gamelist.Filters.Window.Info.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    Emu_VM_Default.Gamelist.Filters.Window.Info.HorzTextAlign := TTextAlign.Leading;
    Emu_VM_Default.Gamelist.Filters.Window.Info.Text := 'Filtering list games : ';
    Emu_VM_Default.Gamelist.Filters.Window.Info.Visible := True;

    Emu_VM_Default.Gamelist.Filters.Window.Games_Num := TText.Create(Emu_VM_Default.Gamelist.Filters.Window.Panel);
    Emu_VM_Default.Gamelist.Filters.Window.Games_Num.name := 'Emu_Filters_Window_Games_Num';
    Emu_VM_Default.Gamelist.Filters.Window.Games_Num.Parent := Emu_VM_Default.Gamelist.Filters.Window.Panel;
    Emu_VM_Default.Gamelist.Filters.Window.Games_Num.SetBounds(136, 35, 400, 30);
    Emu_VM_Default.Gamelist.Filters.Window.Games_Num.Font.Size := 14;
    Emu_VM_Default.Gamelist.Filters.Window.Games_Num.TextSettings.FontColor := TAlphaColorRec.Limegreen;
    Emu_VM_Default.Gamelist.Filters.Window.Games_Num.HorzTextAlign := TTextAlign.Leading;
    Emu_VM_Default.Gamelist.Filters.Window.Games_Num.Text := Emu_VM_Default_Var.Gamelist.Total_Games.ToString;
    Emu_VM_Default.Gamelist.Filters.Window.Games_Num.Visible := True;

    Emu_VM_Default.Gamelist.Filters.Window.Clear := TText.Create(Emu_VM_Default.Gamelist.Filters.Window.Panel);
    Emu_VM_Default.Gamelist.Filters.Window.Clear.name := 'Emu_Filters_Window_Clear';
    Emu_VM_Default.Gamelist.Filters.Window.Clear.Parent := Emu_VM_Default.Gamelist.Filters.Window.Panel;
    Emu_VM_Default.Gamelist.Filters.Window.Clear.SetBounds(Emu_VM_Default.Gamelist.Filters.Window.Panel.width - 80, 34, 30, 30);
    Emu_VM_Default.Gamelist.Filters.Window.Clear.Font.Family := 'IcoMoon-Free';
    Emu_VM_Default.Gamelist.Filters.Window.Clear.Font.Size := 24;
    Emu_VM_Default.Gamelist.Filters.Window.Clear.TextSettings.FontColor := TAlphaColorRec.Grey;
    Emu_VM_Default.Gamelist.Filters.Window.Clear.Text := #$e9ad;
    Emu_VM_Default.Gamelist.Filters.Window.Clear.OnClick := Emu_VM_Default_Mouse.Text.OnMouseClick;
    Emu_VM_Default.Gamelist.Filters.Window.Clear.OnMouseEnter := Emu_VM_Default_Mouse.Text.OnMouseEnter;
    Emu_VM_Default.Gamelist.Filters.Window.Clear.OnMouseLeave := Emu_VM_Default_Mouse.Text.OnMouseLeave;
    Emu_VM_Default.Gamelist.Filters.Window.Clear.Visible := True;

    Emu_VM_Default.Gamelist.Filters.Window.Clear_Glow := TGlowEffect.Create(Emu_VM_Default.Gamelist.Filters.Window.Clear);
    Emu_VM_Default.Gamelist.Filters.Window.Clear_Glow.name := 'Emu_Filters_Window_Clear_Glow';
    Emu_VM_Default.Gamelist.Filters.Window.Clear_Glow.Parent := Emu_VM_Default.Gamelist.Filters.Window.Clear;
    Emu_VM_Default.Gamelist.Filters.Window.Clear_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    Emu_VM_Default.Gamelist.Filters.Window.Clear_Glow.Softness := 0.9;
    Emu_VM_Default.Gamelist.Filters.Window.Clear_Glow.Enabled := False;

    Emu_VM_Default.Gamelist.Filters.Window.Add := TText.Create(Emu_VM_Default.Gamelist.Filters.Window.Panel);
    Emu_VM_Default.Gamelist.Filters.Window.Add.name := 'Emu_Filters_Window_Add';
    Emu_VM_Default.Gamelist.Filters.Window.Add.Parent := Emu_VM_Default.Gamelist.Filters.Window.Panel;
    Emu_VM_Default.Gamelist.Filters.Window.Add.SetBounds(Emu_VM_Default.Gamelist.Filters.Window.Panel.width - 40, 34, 30, 30);
    Emu_VM_Default.Gamelist.Filters.Window.Add.Font.Family := 'IcoMoon-Free';
    Emu_VM_Default.Gamelist.Filters.Window.Add.Font.Size := 24;
    Emu_VM_Default.Gamelist.Filters.Window.Add.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    Emu_VM_Default.Gamelist.Filters.Window.Add.Text := #$ea0a;
    Emu_VM_Default.Gamelist.Filters.Window.Add.OnClick := Emu_VM_Default_Mouse.Text.OnMouseClick;
    Emu_VM_Default.Gamelist.Filters.Window.Add.OnMouseEnter := Emu_VM_Default_Mouse.Text.OnMouseEnter;
    Emu_VM_Default.Gamelist.Filters.Window.Add.OnMouseLeave := Emu_VM_Default_Mouse.Text.OnMouseLeave;
    Emu_VM_Default.Gamelist.Filters.Window.Add.Visible := True;

    Emu_VM_Default.Gamelist.Filters.Window.Add_Glow := TGlowEffect.Create(Emu_VM_Default.Gamelist.Filters.Window.Add);
    Emu_VM_Default.Gamelist.Filters.Window.Add_Glow.name := 'Emu_Filters_Window_Add_Glow';
    Emu_VM_Default.Gamelist.Filters.Window.Add_Glow.Parent := Emu_VM_Default.Gamelist.Filters.Window.Add;
    Emu_VM_Default.Gamelist.Filters.Window.Add_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    Emu_VM_Default.Gamelist.Filters.Window.Add_Glow.Softness := 0.9;
    Emu_VM_Default.Gamelist.Filters.Window.Add_Glow.Enabled := False;

    Emu_VM_Default.Gamelist.Filters.Window.OK := TButton.Create(Emu_VM_Default.Gamelist.Filters.Window.Panel);
    Emu_VM_Default.Gamelist.Filters.Window.OK.name := 'Emu_Filters_Window_OK';
    Emu_VM_Default.Gamelist.Filters.Window.OK.Parent := Emu_VM_Default.Gamelist.Filters.Window.Panel;
    Emu_VM_Default.Gamelist.Filters.Window.OK.SetBounds(50, Emu_VM_Default.Gamelist.Filters.Window.Panel.height - 40, 100, 30);
    Emu_VM_Default.Gamelist.Filters.Window.OK.Text := 'OK';
    Emu_VM_Default.Gamelist.Filters.Window.OK.Anchors := [TAnchorKind.akBottom, TAnchorKind.akLeft];
    Emu_VM_Default.Gamelist.Filters.Window.OK.OnClick := Emu_VM_Default_Mouse.Button.OnMouseClick;
    Emu_VM_Default.Gamelist.Filters.Window.OK.Visible := True;

    Emu_VM_Default.Gamelist.Filters.Window.Cancel := TButton.Create(Emu_VM_Default.Gamelist.Filters.Window.Panel);
    Emu_VM_Default.Gamelist.Filters.Window.Cancel.name := 'Emu_Filters_Window_Cancel';
    Emu_VM_Default.Gamelist.Filters.Window.Cancel.Parent := Emu_VM_Default.Gamelist.Filters.Window.Panel;
    Emu_VM_Default.Gamelist.Filters.Window.Cancel.SetBounds(412, Emu_VM_Default.Gamelist.Filters.Window.Panel.height - 40, 100, 30);
    Emu_VM_Default.Gamelist.Filters.Window.Cancel.Text := 'Cancel';
    Emu_VM_Default.Gamelist.Filters.Window.Cancel.Anchors := [TAnchorKind.akBottom, TAnchorKind.akRight];
    Emu_VM_Default.Gamelist.Filters.Window.Cancel.OnClick := Emu_VM_Default_Mouse.Button.OnMouseClick;
    Emu_VM_Default.Gamelist.Filters.Window.Cancel.Visible := True;
  end
  else
    Emu_VM_Default.Gamelist.Filters.Window.Panel.Visible := True;
end;

procedure Add;
var
  vi, vNum: Integer;
  vPanel_Height: Integer;
begin
  for vi := 0 to Emu_VM_Default_Var.Filters.List_Added.Count - 1 do
  begin
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi].Choose.Enabled := False;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi].Sec_Choose.Enabled := False;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi].Remove.TextSettings.FontColor := TAlphaColorRec.Grey;
  end;

  if (Emu_VM_Default_Var.Filters.Done) or (Emu_VM_Default_Var.Filters.Added = 0) then
  begin
    vPanel_Height := 0;
    inc(Emu_VM_Default_Var.Filters.Added, 1);
    SetLength(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels, Emu_VM_Default_Var.Filters.Added);

    vNum := Emu_VM_Default_Var.Filters.Added - 1;

    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel := TPanel.Create(Emu_VM_Default.Gamelist.Filters.Window.Panel);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel.name := 'Emu_Filters_Window_Filter_Panel_' + (vNum).ToString;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel.Parent := Emu_VM_Default.Gamelist.Filters.Window.Panel;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel.SetBounds(10, 70 + ((vNum) * 70), Emu_VM_Default.Gamelist.Filters.Window.Panel.width
      - 20, 60);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel.Visible := True;

    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Combine := TRectangle.Create(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Combine.name := 'Emu_Filters_Window_Filter_Combine_' + vNum.ToString;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Combine.Parent := Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Combine.SetBounds(10, 6, 14, 14);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Combine.Fill.Kind := TBrushKind.Solid;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Combine.Visible := False;

    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove := TText.Create(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.name := 'Emu_Filters_Window_Filter_Remove_' + (vNum).ToString;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.Parent := Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.SetBounds(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel.width - 36,
      15, 30, 30);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.Font.Family := 'IcoMoon-Free';
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.Font.Size := 24;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.TextSettings.FontColor := TAlphaColorRec.Grey;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.Text := #$e9ac;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.OnMouseEnter := Emu_VM_Default_Mouse.Text.OnMouseEnter;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.OnMouseLeave := Emu_VM_Default_Mouse.Text.OnMouseLeave;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.OnMouseUp := Emu_VM_Default_Mouse.Text.OnMouseUp;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.Tag := vNum;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove.Visible := True;

    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove_Glow :=
      TGlowEffect.Create(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove_Glow.name := 'Emu_Filters_Window_Filter_Remove_Glow_' + vNum.ToString;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove_Glow.Parent := Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove_Glow.Softness := 0.9;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Remove_Glow.Enabled := False;

    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Filter_Name := TText.Create(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Filter_Name.name := 'Emu_Filters_Window_Filter_Name_' + (vNum).ToString;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Filter_Name.Parent := Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Filter_Name.SetBounds(30, 2, 290, 20);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Filter_Name.Text := 'Filter : ';
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Filter_Name.Font.Size := 14;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Filter_Name.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Filter_Name.HorzTextAlign := TTextAlign.Leading;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Filter_Name.Visible := True;

    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Choose := TComboBox.Create(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Choose.name := 'Emu_Filters_Window_Filter_Combo_' + (vNum).ToString;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Choose.Parent := Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Choose.SetBounds(10, 25, 150, 28);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Choose.Tag := Emu_VM_Default_Var.Filters.Added - 1;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Choose.OnChange := Emu_VM_Default_Mouse.ComboBox.OnChange;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Choose.Visible := True;

    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Sec_Choose := TComboBox.Create(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Sec_Choose.name := 'Emu_Filters_Window_Filter_Combo_Second_' + vNum.ToString;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Sec_Choose.Parent := Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Sec_Choose.SetBounds(180, 25, 150, 28);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Sec_Choose.OnChange := Emu_VM_Default_Mouse.ComboBox.OnChange;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Sec_Choose.Tag := vNum;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Sec_Choose.Visible := False;

    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result := TText.Create(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result.name := 'Emu_Filters_Window_Filter_Result_' + (vNum).ToString;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result.Parent := Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result.SetBounds(340, 2, 150, 20);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result.Text := 'Result';
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result.Font.Size := 14;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result.HorzTextAlign := TTextAlign.Center;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result.Visible := False;

    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Num := TText.Create(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Num.name := 'Emu_Filters_Window_Filter_Result_Num_' + (vNum).ToString;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Num.Parent := Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Num.SetBounds(340, 20, 150, 20);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Num.Text := '';
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Num.Font.Size := 14;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Num.TextSettings.FontColor := TAlphaColorRec.Limegreen;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Num.HorzTextAlign := TTextAlign.Center;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Num.Visible := False;

    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Games := TText.Create(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Games.name := 'Emu_Filters_Window_Filter_Result_Games_' + (vNum).ToString;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Games.Parent := Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Panel;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Games.SetBounds(340, 40, 150, 20);
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Games.Text := 'Games';
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Games.Font.Size := 14;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Games.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Games.HorzTextAlign := TTextAlign.Center;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Result_Games.Visible := False;

    for vi := 0 to Emu_VM_Default_Var.Filters.List.Count do
    begin
      if vi = 0 then
        Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Choose.Items.Add('Choose...')
      else
        Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Choose.Items.Add(Emu_VM_Default_Var.Filters.List.Strings[vi - 1]);
    end;

    Emu_VM_Default_Var.Filters.Done := True;
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vNum].Choose.ItemIndex := 0;
    Emu_VM_Default_Var.Filters.Done := False;
    Emu_VM_Default_Var.Filters.Done := False;

    Sort_Panels;
    Emu_VM_Default.Gamelist.Filters.Window.Add.TextSettings.FontColor := TAlphaColorRec.Grey;
    Emu_VM_Default.Gamelist.Filters.Window.Clear.TextSettings.FontColor := TAlphaColorRec.Grey;
    Emu_VM_Default.Gamelist.Filters.Window.Add_Glow.Enabled := False;
  end;
end;

procedure Sort_Panels;
var
  vi: Integer;
  vSum_Height: Single;
begin
  if Emu_VM_Default_Var.Filters.Added > -1 then
  begin
    vSum_Height := 0;
    for vi := 0 to Emu_VM_Default_Var.Filters.Added - 1 do
      vSum_Height := Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi].Panel.Position.Y;

    if vSum_Height + 130 < 300 then
      Emu_VM_Default.Gamelist.Filters.Window.Panel.height := 300
    else
      Emu_VM_Default.Gamelist.Filters.Window.Panel.height := vSum_Height + 130;
  end;
end;

procedure Second_Choose(vName: String; vPanel: Integer);
begin
  Emu_VM_Default_Var.Filters.First_Selection := True;
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
  Emu_VM_Default_Var.Filters.First_Selection := False;
end;

procedure Combo_Create_Filter(vFilter: String; vPanel: Integer);
var
  vList_Filters, vBool_Filters: String;
  vi: Integer;
  vTemp_List: TStringList;
begin
  Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel].Filter_Name.Text := 'Filter : ' + vFilter;

  vList_Filters := 'Year Manufacturer Genre Monochrome Languages';
  vBool_Filters := 'Adult Original Mechanical Working Screenless';
  vTemp_List := TStringList.Create;

  Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel].Sec_Choose.Clear;
  Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel].Sec_Choose.Visible := True;

  Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel].Sec_Choose.TagString := vFilter;

  if AnsiContainsStr(vList_Filters, vFilter) then
  begin
    vTemp_List := Get_List(vFilter);

    for vi := 0 to vTemp_List.Count do
    begin
      if vi = 0 then
        Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[Emu_VM_Default_Var.Filters.Added - 1].Sec_Choose.Items.Add('Choose...')
      else
      begin
        if vTemp_List.Strings[vi - 1] <> '' then
          Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[Emu_VM_Default_Var.Filters.Added - 1].Sec_Choose.Items.Add(vTemp_List.Strings[vi - 1]);
      end;
    end;
  end
  else if AnsiContainsStr(vBool_Filters, vFilter) then
  begin
    Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[Emu_VM_Default_Var.Filters.Added - 1].Sec_Choose.Items.Add('Choose...');
    if vFilter = 'Adult' then
    begin
      Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[Emu_VM_Default_Var.Filters.Added - 1].Sec_Choose.Items.Add('All');
      Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[Emu_VM_Default_Var.Filters.Added - 1].Sec_Choose.Items.Add('Adult');
    end
    else if vFilter = 'Original' then
    begin
      Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[Emu_VM_Default_Var.Filters.Added - 1].Sec_Choose.Items.Add('Authentic');
      Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[Emu_VM_Default_Var.Filters.Added - 1].Sec_Choose.Items.Add('Clone');
    end
    else
    begin
      Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[Emu_VM_Default_Var.Filters.Added - 1].Sec_Choose.Items.Add('Yes');
      Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[Emu_VM_Default_Var.Filters.Added - 1].Sec_Choose.Items.Add('No');
    end;
  end;

  Emu_VM_Default_Var.Filters.Done := True;
  Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[Emu_VM_Default_Var.Filters.Added - 1].Sec_Choose.ItemIndex := 0;
  Emu_VM_Default_Var.Filters.Done := False;

  Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel].Result.Visible := False;
  Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel].Result_Num.Visible := False;
  Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel].Result_Games.Visible := False;

  Emu_VM_Default.Gamelist.Filters.Window.Add.TextSettings.FontColor := TAlphaColorRec.Grey;
  Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel].Remove.TextSettings.FontColor := TAlphaColorRec.Grey;
end;

procedure Close_Window;
begin
  uView_Mode_Default_Actions.Filters_Action;
end;

function Get_List(vList: String): TStringList;
begin
  Result := TStringList.Create;
  if vList = 'Year' then
  begin
    if extrafe.prog.State = 'emu_mame' then
      Result := mame.Gamelist.ListYear;
  end
  else if vList = 'Manufacturer' then
  begin
    if extrafe.prog.State = 'emu_mame' then
      Result := mame.Gamelist.ListManufaturer;
  end
  else if vList = 'Genre' then
  begin
    if extrafe.prog.State = 'emu_mame' then
      Result := mame.Gamelist.ListGenre;
  end
  else if vList = 'Monochrome' then
  begin
    if extrafe.prog.State = 'emu_mame' then
      Result := mame.Gamelist.ListMonochrome;
  end
  else if vList = 'Languages' then
  begin
    if extrafe.prog.State = 'emu_mame' then
      Result := mame.Gamelist.ListLanguages;
  end
end;

procedure Filter_Result(vFilter, vResponse: String; vPanel: Integer);
var
  vQuery, vTitle, vValue: String;
  vFilter_Index, vi: Integer;
  vFilter_Found: Boolean;
  vList_Filters: String;
begin
  Emu_VM_Default_Var.Filters.Temp_Roms.Clear;
  Emu_VM_Default_Var.Filters.Temp_Games.Clear;

  vList_Filters := 'Year Manufacturer Genre Monochrome Languages';
  if AnsiContainsStr(vList_Filters, vFilter) then
    vValue := vResponse
  else
    vValue := LowerCase(vResponse);
  vTitle := LowerCase(vFilter);

  vQuery := 'SELECT romname, gamename FROM games WHERE ' + vTitle + '="' + vValue + '" ORDER BY romname ASC';
  Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel].Filter_Name.Text := 'Filter : ' + vFilter + ' (' + vResponse + ')';

  uDB.Arcade_Query.Close;
  uDB.Arcade_Query.SQL.Clear;
  uDB.Arcade_Query.SQL.Text := vQuery;
  uDB.Arcade_Query.DisableControls;
  uDB.Arcade_Query.Open;

  try
    uDB.Arcade_Query.First;
    while not uDB.Arcade_Query.Eof do
    begin
      Emu_VM_Default_Var.Filters.Temp_Roms.Add(uDB.Arcade_Query.FieldByName('romname').AsString);
      Emu_VM_Default_Var.Filters.Temp_Games.Add(uDB.Arcade_Query.FieldByName('gamename').AsString);
      uDB.Arcade_Query.Next;
    end;
  finally
    uDB.Arcade_Query.EnableControls;
  end;

  Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel].Result.Visible := True;
  Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel].Result_Num.Text := Emu_VM_Default_Var.Filters.Temp_Roms.Count.ToString;
  Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel].Result_Num.Visible := True;
  Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel].Result_Games.Visible := True;

  if Emu_VM_Default_Var.Filters.List.IndexOf(vFilter) <> -1 then
  begin
    Emu_VM_Default_Var.Filters.List_Added.Insert(vPanel, vFilter + '=' + vResponse);
    if Emu_VM_Default_Var.Filters.List_Added.Count - 1 >= vPanel + 1 then
      Emu_VM_Default_Var.Filters.List_Added.Delete(vPanel + 1);
  end;

  List_Result;
  Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel].Remove.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
end;

procedure set_filter(vName: String; vState: Boolean);
begin
  if vName = 'Year' then
    vState_Filters.year := vState
  else if vName = 'Manufactorer' then
    vState_Filters.manufacturer := vState
  else if vName = 'Genre' then
    vState_Filters.genre := vState
  else if vName = 'Adult' then
    vState_Filters.adult := vState
  else if vName = 'Original' then
    vState_Filters.original := vState
  else if vName = 'Mechanical' then
    vState_Filters.mechanical := vState
  else if vName = 'Working' then
    vState_Filters.working := vState
  else if vName = 'Monochrome' then
    vState_Filters.monochrome := vState
  else if vName = 'Screenless' then
    vState_Filters.screenless := vState
  else if vName = 'Languages' then
    vState_Filters.languages := vState;
end;

procedure List_Result;
const
  first= TAlphaColorRec.Deepskyblue;
  second = TAlphaColorRec.Red;
  third = TAlphaColorRec.Pink;
  fourth = TAlphaColorRec.Green;
  fifth = TAlphaColorRec.Black;

var
  vQuery, vConditions, vFilter_name, vFilter_Value: String;
  vi, vk, vl: Integer;
  vList_Filters: String;
  vFilter: TStringList;
  vFinal_Condition: String;
  vFilter_Multple: String;
  vCount: Integer;

  function is_Filter_set(vName: String): Boolean;
  begin
    if vName = 'Year' then
      Result := vState_Filters.year
    else if vName = 'Manufactorer' then
      Result := vState_Filters.manufacturer
    else if vName = 'Genre' then
      Result := vState_Filters.genre
    else if vName = 'Adult' then
      Result := vState_Filters.adult
    else if vName = 'Original' then
      Result := vState_Filters.original
    else if vName = 'Mechanical' then
      Result := vState_Filters.mechanical
    else if vName = 'Working' then
      Result := vState_Filters.working
    else if vName = 'Monochrome' then
      Result := vState_Filters.monochrome
    else if vName = 'Screenless' then
      Result := vState_Filters.screenless
    else if vName = 'Languages' then
      Result := vState_Filters.languages;
  end;

begin
  if Assigned(Emu_VM_Default_Var.Filters.Temp_Roms_Final) then
    FreeAndNil(Emu_VM_Default_Var.Filters.Temp_Roms_Final);
  if Assigned(Emu_VM_Default_Var.Filters.Temp_Games_Final) then
    FreeAndNil(Emu_VM_Default_Var.Filters.Temp_Games_Final);

  Emu_VM_Default_Var.Filters.Temp_Roms_Final := TStringList.Create;
  Emu_VM_Default_Var.Filters.Temp_Games_Final := TStringList.Create;

  vFilter := TStringList.Create;

  vCount := 0;
  vConditions := '';
  for vi := 0 to Emu_VM_Default_Var.Filters.List_Added.Count - 1 do
  begin
    vList_Filters := 'Year Manufacturer Genre Monochrome Languages';
    if AnsiContainsStr(vList_Filters, Emu_VM_Default_Var.Filters.List_Added.Names[vi]) then
      vFilter_Value := Emu_VM_Default_Var.Filters.List_Added.ValueFromIndex[vi]
    else
      vFilter_Value := LowerCase(Emu_VM_Default_Var.Filters.List_Added.ValueFromIndex[vi]);
    vFilter.Add(Emu_VM_Default_Var.Filters.List_Added.Names[vi] + '=' + vFilter_Value);
    vFilter_name := Emu_VM_Default_Var.Filters.List_Added.Names[vi];

    for vk := 0 to vFilter.Count - 1 do
      if (vFilter.Names[vk] = vFilter_name) and (vk <> vi) and (is_Filter_set(vFilter.Names[vi]) = True) then
      begin
        vFinal_Condition := '';
        for vl := 0 to vFilter.Count - 1 do
        begin
          vFilter_Multple := vFilter.Names[vl];
          if vFilter_Multple = vFilter_name then
          begin
            if vFinal_Condition = '' then
              vFinal_Condition := vFilter_name + ' IN ("' + vFilter.ValueFromIndex[vl] + '"'
            else
              vFinal_Condition := vFinal_Condition + ', "' + vFilter.ValueFromIndex[vl] + '"';
          end;
        end;
        if vCount = 0 then
          vConditions := vFinal_Condition + ')'
        else
          vConditions := vConditions + ' AND ' + vFinal_Condition + ')';
        inc(vCount, 1);
      end
      else
      begin
        if is_Filter_set(vFilter.Names[vi]) = False then
        begin
          if vConditions <> '' then
            vConditions := vConditions + ' AND ' + vFilter.Names[vi] + '="' + vFilter_Value + '" '
          else
            vConditions := vFilter.Names[vi] + '="' + vFilter_Value + '" ';
        end;

        if is_Filter_set(vFilter.Names[vi]) = False then
          set_filter(vFilter.Names[vi], True);
      end;
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
        Emu_VM_Default_Var.Filters.Temp_Roms_Final.Add(uDB.Arcade_Query.FieldByName('romname').AsString);
        Emu_VM_Default_Var.Filters.Temp_Games_Final.Add(uDB.Arcade_Query.FieldByName('gamename').AsString);
        uDB.Arcade_Query.Next;
      end;
    finally
      uDB.Arcade_Query.EnableControls;
    end;

    if Emu_VM_Default_Var.Filters.Temp_Roms_Final.Count = 0 then
    begin
      Emu_VM_Default.Gamelist.Filters.Window.OK.Enabled := False;
      Emu_VM_Default.Gamelist.Filters.Window.Add.TextSettings.FontColor := TAlphaColorRec.Grey;
      Emu_VM_Default.Gamelist.Filters.Window.Clear.TextSettings.FontColor := TAlphaColorRec.Grey;
    end
    else
    begin
      Emu_VM_Default.Gamelist.Filters.Window.OK.Enabled := True;
      Emu_VM_Default.Gamelist.Filters.Window.Add.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      Emu_VM_Default.Gamelist.Filters.Window.Clear.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end;

    for vi := 0 to Emu_VM_Default_Var.Filters.List_Added.Count - 1 do
    begin
      Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi].Choose.Enabled := True;
      Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi].Sec_Choose.Enabled := True;
      Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi].Remove.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end;

    if Emu_VM_Default_Var.Filters.First_Selection = False then
      Emu_VM_Default.Gamelist.Filters.Window.Games_Num.Text := Emu_VM_Default_Var.Filters.Temp_Roms_Final.Count.ToString;
    Emu_VM_Default.Gamelist.Filters.Window.Clear.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    Emu_VM_Default_Var.Filters.Done := True;
  end
  else
    Clear_Filters;
end;

procedure Clear_Filters;
var
  vQuery: String;
  vi: Integer;
begin
  Emu_VM_Default_Var.Filters.Temp_Roms_Final.Clear;
  Emu_VM_Default_Var.Filters.Temp_Games_Final.Clear;

  for vi := 0 to Emu_VM_Default_Var.Filters.List_Added.Count - 1 do
    FreeAndNil(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi].Panel);

  Emu_VM_Default_Var.Filters.Added := 0;
  Emu_VM_Default_Var.Filters.List_Added.Clear;
  Emu_VM_Default_Var.Filters.Temp_Roms_Final.Clear;
  Emu_VM_Default_Var.Filters.Temp_Games_Final.Clear;
  Emu_VM_Default_Var.Filters.Temp_Roms.Clear;
  Emu_VM_Default_Var.Filters.Temp_Games.Clear;

  vQuery := 'SELECT gamename, romname FROM games ORDER BY gamename ASC';
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
      Emu_VM_Default_Var.Filters.Temp_Games_Final.Add(uDB.Arcade_Query.FieldByName('gamename').AsString);
      Emu_VM_Default_Var.Filters.Temp_Roms_Final.Add(uDB.Arcade_Query.FieldByName('romname').AsString);
      uDB.Arcade_Query.Next;
    end;
  finally
    uDB.Arcade_Query.EnableControls;
  end;

  Emu_VM_Default.Gamelist.Filters.Window.Games_Num.Text := Emu_VM_Default_Var.Filters.Temp_Roms_Final.Count.ToString;
  Emu_VM_Default.Gamelist.Filters.Window.Clear.TextSettings.FontColor := TAlphaColorRec.Grey;
  Emu_VM_Default.Gamelist.Filters.Window.Add.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
end;

procedure Remove(vPanel_Num: Integer);
var
  vi: Integer;
  vSum_Height: Single;
  vQuery: String;
  vFilter_name, vFilter_Name_Curent: String;
  vCount: Integer;
begin
  vFilter_name := Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel_Num].Choose.Items
    [Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel_Num].Choose.ItemIndex];

  vCount := 0;

  for vi := 0 to High(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels) do
  begin
    vFilter_Name_Curent := Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi].Choose.Items
      [Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi].Choose.ItemIndex];
    if vFilter_name = vFilter_Name_Curent then
      inc(vCount, 1);
    if vCount > 1 then
      Break;
  end;

  if vCount <= 1 then
    set_filter(vFilter_name, False);

  Dec(Emu_VM_Default_Var.Filters.Added, 1);
  Emu_VM_Default_Var.Filters.List_Added.Delete(vPanel_Num);
  SetLength(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels, Emu_VM_Default_Var.Filters.Added + 1);

  vSum_Height := 0;

  if Emu_VM_Default_Var.Filters.Added = 0 then
  begin
    List_Result;
    FreeAndNil(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel_Num].Sec_Choose);
    FreeAndNil(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel_Num].Panel);
  end
  else
  begin
    List_Result;
    FreeAndNil(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel_Num].Sec_Choose);
    FreeAndNil(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vPanel_Num].Panel);
    for vi := 0 to Emu_VM_Default_Var.Filters.Added do
    begin
      if (vi >= vPanel_Num) and (vi <> Emu_VM_Default_Var.Filters.Added) then
      begin
        if Assigned(Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi + 1].Panel) then
        begin
          Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi] := Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi + 1];
          Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi].Panel.name := 'Emu_Filters_Window_Filter_Panel_' + vi.ToString;
          Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi].Panel.Position.Y := 70 + (vi * 70);
          Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi].Remove.name := 'Emu_Filters_Window_Filter_Remove_' + vi.ToString;
          Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi].Remove.Tag := vi;
        end;
        vSum_Height := Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi].Panel.Position.Y;
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
  if Emu_VM_Default_Var.Filters.Added > -1 then
  begin
    vSum_Height := 0;
    for vi := 0 to Emu_VM_Default_Var.Filters.Added - 1 do
      vSum_Height := Emu_VM_Default.Gamelist.Filters.Window.Filter_Panels[vi].Panel.Position.Y;

    if vSum_Height + 130 < 300 then
      Emu_VM_Default.Gamelist.Filters.Window.Panel.height := 300
    else
      Emu_VM_Default.Gamelist.Filters.Window.Panel.height := vSum_Height + 130;
  end;
end;

procedure Return;
var
  vi: Integer;
  vFilter_name: String;
begin
  Emu_VM_Default_Var.Gamelist.Roms := Emu_VM_Default_Var.Filters.Temp_Roms_Final;
  Emu_VM_Default_Var.Gamelist.Games := Emu_VM_Default_Var.Filters.Temp_Games_Final;
  Emu_VM_Default_Var.Gamelist.Total_Games := Emu_VM_Default_Var.Gamelist.Roms.Count;

  Emu_VM_Default_Var.Gamelist.Selected := 0;
  uView_Mode_Default_Actions.Refresh;

  if Emu_VM_Default_Var.Filters.Added = 0 then
    Emu_VM_Default.Gamelist.Filters.Filter_Text.Text := 'All'
  else
  begin
    for vi := 0 to Emu_VM_Default_Var.Filters.Added - 1 do
    begin
      vFilter_name := Emu_VM_Default_Var.Filters.List_Added.Names[vi] + '(' + Emu_VM_Default_Var.Filters.List_Added.ValueFromIndex[vi] + ')';
      if vi = 0 then
        Emu_VM_Default.Gamelist.Filters.Filter_Text.Text := vFilter_name
      else
        Emu_VM_Default.Gamelist.Filters.Filter_Text.Text := Emu_VM_Default.Gamelist.Filters.Filter_Text.Text + ', ' + vFilter_name;
    end;
  end;
  Close_Window;
end;

end.
