unit uMain_SetAll;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Effects,
  FMX.Types,
  FMX.Ani,
  FMX.Edit,
  FMX.Layouts,
  FMX.Graphics,
  FMX.Memo,
  FMX.Filter.Effects,
  FMX.Listbox,
  FMX.TabControl,
  FMX.Controls,
  FMX.Dialogs,
  FMX.Imglist,
  ALFMXObjects,
  IdHTTP,
  IdComponent,
  uMain_AllTypes;

procedure uMain_SetAll_Set;

procedure uMain_SetAll_Exit;
procedure Addon_Icon(vNum: integer);

implementation

uses
  uLoad,
  uLoad_AllTypes,
  main,
  uMain_Actions,
  uMain_Emulation,
  uMain_Config_Addons,
  uMain_Config,
  uMain_Config_Emulators,
  uMain_Config_Themes,
  uMain_Mouse,
  uDB_AUser;

procedure Addon_Icon(vNum: integer);
begin
  mainScene.Header.Addon_Icon.Frame[vNum] := TLayout.Create(mainScene.Header.Back);
  mainScene.Header.Addon_Icon.Frame[vNum].Name := 'Main_Header_Addon_Frame_' + vNum.ToString;
  mainScene.Header.Addon_Icon.Frame[vNum].Parent := mainScene.Header.Back;
  mainScene.Header.Addon_Icon.Frame[vNum].SetBounds(50 + (vNum * 55), mainScene.Header.Back.Height - 60, 50, 50);
  mainScene.Header.Addon_Icon.Frame[vNum].Visible := True;

  mainScene.Header.Addon_Icon.Icons[vNum] := TText.Create(mainScene.Header.Addon_Icon.Frame[vNum]);
  mainScene.Header.Addon_Icon.Icons[vNum].Name := 'Main_Header_Addon_Icon_' + vNum.ToString;
  mainScene.Header.Addon_Icon.Icons[vNum].Parent := mainScene.Header.Addon_Icon.Frame[vNum];
  mainScene.Header.Addon_Icon.Icons[vNum].SetBounds(0, 0, 50, 50);
  mainScene.Header.Addon_Icon.Icons[vNum].Font.Family := 'IcoMoon-Free';
  mainScene.Header.Addon_Icon.Icons[vNum].Font.Size := 48;
  mainScene.Header.Addon_Icon.Icons[vNum].Align := TAlignLayout.Center;
  mainScene.Header.Addon_Icon.Icons[vNum].TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  mainScene.Header.Addon_Icon.Icons[vNum].OnClick := ex_main.input.mouse.Text.OnMouseClick;
  mainScene.Header.Addon_Icon.Icons[vNum].OnMouseEnter := ex_main.input.mouse.Text.OnMouseEnter;
  mainScene.Header.Addon_Icon.Icons[vNum].OnMouseLeave := ex_main.input.mouse.Text.OnMouseLeave;
  mainScene.Header.Addon_Icon.Icons[vNum].Tag := vNum;
  mainScene.Header.Addon_Icon.Icons[vNum].Visible := True;

  mainScene.Header.Addon_Icon.Glow[vNum] := TGlowEffect.Create(mainScene.Header.Addon_Icon.Icons[vNum]);
  mainScene.Header.Addon_Icon.Glow[vNum].Name := 'Main_Header_Addon_Icon_Glow_' + IntToStr(vNum);
  mainScene.Header.Addon_Icon.Glow[vNum].Parent := mainScene.Header.Addon_Icon.Icons[vNum];
  mainScene.Header.Addon_Icon.Glow[vNum].GlowColor := TAlphaColorRec.Deepskyblue;
  mainScene.Header.Addon_Icon.Glow[vNum].Opacity := 0.9;
  mainScene.Header.Addon_Icon.Glow[vNum].Softness := 0.4;
  mainScene.Header.Addon_Icon.Glow[vNum].Enabled := False;

  mainScene.Header.Addon_Icon.Blur[vNum] := TGaussianBlurEffect.Create(mainScene.Header.Addon_Icon.Icons[vNum]);
  mainScene.Header.Addon_Icon.Blur[vNum].Name := 'Main_Header_Addon_Icon_Blur_' + IntToStr(vNum);
  mainScene.Header.Addon_Icon.Blur[vNum].Parent := mainScene.Header.Addon_Icon.Icons[vNum];
  mainScene.Header.Addon_Icon.Blur[vNum].BlurAmount := 0.2;
  mainScene.Header.Addon_Icon.Blur[vNum].Enabled := False;
end;

procedure uMain_SetAll_Set;
var
  vi: integer;
  vCol: TGridPanelLayout.TColumnItem;
  vRow: TGridPanelLayout.TRowItem;
begin
  // Main
  mainScene.main.Back := TImage.Create(Main_Form);
  mainScene.main.Back.Name := 'Main_Down_Back';
  mainScene.main.Back.Parent := Main_Form;
  mainScene.main.Back.SetBounds(0, 0, extrafe.res.Width, extrafe.res.Height);
  mainScene.main.Back.Bitmap.LoadFromFile(ex_main.Paths.Images + 'back.png');
  mainScene.main.Back.WrapMode := TImageWrapMode.Tile;
  mainScene.main.Back.Visible := True;

  mainScene.main.Down_Level := TImage.Create(mainScene.main.Back);
  mainScene.main.Down_Level.Name := 'Main_Down';
  mainScene.main.Down_Level.Parent := mainScene.main.Back;
  mainScene.main.Down_Level.SetBounds(0, 0, extrafe.res.Width, extrafe.res.Height);
  mainScene.main.Down_Level.Bitmap.LoadFromFile(ex_main.Paths.Images + 'back.png');
  mainScene.main.Down_Level.WrapMode := TImageWrapMode.Tile;
  mainScene.main.Down_Level.Visible := True;

  mainScene.main.Down_Level_Ani := TFloatAnimation.Create(mainScene.main.Down_Level);
  mainScene.main.Down_Level_Ani.Name := 'Main_Down_Animation';
  mainScene.main.Down_Level_Ani.Parent := mainScene.main.Down_Level;
  mainScene.main.Down_Level_Ani.PropertyName := 'Opacity';
  mainScene.main.Down_Level_Ani.Duration := 1.8;
  mainScene.main.Down_Level_Ani.Interpolation := TInterpolationType.Linear;
  mainScene.main.Down_Level_Ani.StartValue := 1;
  mainScene.main.Down_Level_Ani.StopValue := 0.1;
  mainScene.main.Down_Level_Ani.OnFinish := mainScene.Animation.OnFinish;
  mainScene.main.Down_Level_Ani.Enabled := False;

  mainScene.main.Up_Level := TImage.Create(mainScene.main.Down_Level);
  mainScene.main.Up_Level.Name := 'Main_Up';
  mainScene.main.Up_Level.Parent := mainScene.main.Down_Level;
  mainScene.main.Up_Level.SetBounds(0, 0, extrafe.res.Width, extrafe.res.Height);
  mainScene.main.Up_Level.Bitmap.LoadFromFile(ex_main.Paths.Images + 'back.png');
  mainScene.main.Up_Level.WrapMode := TImageWrapMode.Tile;
  mainScene.main.Up_Level.Visible := True;

  Main_Form.StyleBook := mainScene.main.Style;

  // Global timer for all addon and other actions

  mainScene.main.Timer := TTimer.Create(mainScene.main.Down_Level);
  mainScene.main.Timer.Name := 'Main_All_Timer';
  mainScene.main.Timer.Parent := mainScene.main.Down_Level;
  mainScene.main.Timer.Interval := 10;
  mainScene.main.Timer.OnTimer := vMain_Timer.OnTimer;
  mainScene.main.Timer.Enabled := True;

  // Header
  mainScene.Header.Back := TImage.Create(mainScene.main.Down_Level);
  mainScene.Header.Back.Name := 'Main_Header';
  mainScene.Header.Back.Parent := mainScene.main.Down_Level;
  mainScene.Header.Back.SetBounds(0, 0, extrafe.res.Width, 130);
  mainScene.Header.Back.Bitmap.LoadFromFile(ex_main.Paths.Images + 'back.png');
  mainScene.Header.Back.WrapMode := TImageWrapMode.Tile;
  mainScene.Header.Back.Visible := True;

  mainScene.Header.Back_Blur := TGaussianBlurEffect.Create(mainScene.Header.Back);
  mainScene.Header.Back_Blur.Name := 'Main_Header_Blur';
  mainScene.Header.Back_Blur.Parent := mainScene.Header.Back;
  mainScene.Header.Back_Blur.BlurAmount := 0.2;
  mainScene.Header.Back_Blur.Enabled := False;

  mainScene.Header.Exit := TImage.Create(mainScene.Header.Back);
  mainScene.Header.Exit.Name := 'Main_Header_Exit';
  mainScene.Header.Exit.Parent := mainScene.Header.Back;
  mainScene.Header.Exit.SetBounds(mainScene.Header.Back.Width - 29, 5, 24, 24);
  mainScene.Header.Exit.Bitmap.LoadFromFile(ex_main.Paths.Images + 'exit_program.png');
  mainScene.Header.Exit.WrapMode := TImageWrapMode.Fit;
  mainScene.Header.Exit.OnClick := ex_main.input.mouse.Image.OnMouseClick;
  mainScene.Header.Exit.OnMouseEnter := ex_main.input.mouse.Image.OnMouseEnter;
  mainScene.Header.Exit.OnMouseLeave := ex_main.input.mouse.Image.OnMouseLeave;
  mainScene.Header.Exit.Visible := True;

  mainScene.Header.Exit_Glow := TGlowEffect.Create(mainScene.Header.Exit);
  mainScene.Header.Exit_Glow.Name := 'Main_Header_Exit_Glow';
  mainScene.Header.Exit_Glow.Parent := mainScene.Header.Exit;
  mainScene.Header.Exit_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  mainScene.Header.Exit_Glow.Opacity := 0.9;
  mainScene.Header.Exit_Glow.Softness := 0.4;
  mainScene.Header.Exit_Glow.Enabled := False;

  mainScene.Header.Minimize := TImage.Create(mainScene.Header.Back);
  mainScene.Header.Minimize.Name := 'Main_Header_Minimize';
  mainScene.Header.Minimize.Parent := mainScene.Header.Back;
  mainScene.Header.Minimize.SetBounds(mainScene.Header.Back.Width - 29, 39, 24, 24);
  mainScene.Header.Minimize.Bitmap.LoadFromFile(ex_main.Paths.Images + 'minimize_program.png');
  mainScene.Header.Minimize.WrapMode := TImageWrapMode.Fit;
  mainScene.Header.Minimize.OnClick := ex_main.input.mouse.Image.OnMouseClick;
  mainScene.Header.Minimize.OnMouseEnter := ex_main.input.mouse.Image.OnMouseEnter;
  mainScene.Header.Minimize.OnMouseLeave := ex_main.input.mouse.Image.OnMouseLeave;
  mainScene.Header.Minimize.Visible := True;

  mainScene.Header.Minimize_Glow := TGlowEffect.Create(mainScene.Header.Minimize);
  mainScene.Header.Minimize_Glow.Name := 'Main_Header_Minimize_Glow';
  mainScene.Header.Minimize_Glow.Parent := mainScene.Header.Minimize;
  mainScene.Header.Minimize_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  mainScene.Header.Minimize_Glow.Opacity := 0.9;
  mainScene.Header.Minimize_Glow.Softness := 0.4;
  mainScene.Header.Minimize_Glow.Enabled := False;

  mainScene.Header.Avatar := TImage.Create(mainScene.Header.Back);
  mainScene.Header.Avatar.Name := 'Main_Header_Avatar';
  mainScene.Header.Avatar.Parent := mainScene.Header.Back;
  mainScene.Header.Avatar.SetBounds(mainScene.Header.Back.Width - 179, 5, 120, 120);
  mainScene.Header.Avatar.Bitmap.LoadFromFile(ex_main.Paths.Avatar_Images + uDB_AUser.Local.Avatar + '.png');
  mainScene.Header.Avatar.WrapMode := TImageWrapMode.Fit;
  mainScene.Header.Avatar.OnClick := ex_main.input.mouse.Image.OnMouseClick;
  mainScene.Header.Avatar.OnMouseEnter := ex_main.input.mouse.Image.OnMouseEnter;
  mainScene.Header.Avatar.OnMouseLeave := ex_main.input.mouse.Image.OnMouseLeave;
  mainScene.Header.Avatar.Visible := True;

  mainScene.Header.Avatar_Glow := TGlowEffect.Create(mainScene.Header.Avatar);
  mainScene.Header.Avatar_Glow.Name := 'Main_Header_Avatar_Glow';
  mainScene.Header.Avatar_Glow.Parent := mainScene.Header.Avatar;
  mainScene.Header.Avatar_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  mainScene.Header.Avatar_Glow.Opacity := 0.9;
  mainScene.Header.Avatar_Glow.Softness := 0.4;
  mainScene.Header.Avatar_Glow.Enabled := False;

  for vi := 0 to uDB_AUser.Local.ADDONS.Active do
    Addon_Icon(vi);

  { Time }
  mainScene.Header.Addon_Icon.Icons[0].Text := #$e94e;
  { Calendar }
  mainScene.Header.Addon_Icon.Icons[1].Text := #$e953;
  { Weather IF }
  if uDB_AUser.Local.ADDONS.Weather then
    mainScene.Header.Addon_Icon.Icons[uDB_AUser.Local.ADDONS.Weather_D.Menu_Position].Text := #$e9c1;
  { Soundplayer IF }
  if uDB_AUser.Local.ADDONS.Soundplayer then
    mainScene.Header.Addon_Icon.Icons[uDB_AUser.Local.ADDONS.Soundplayer_D.Menu_Position].Text := #$ea15;
  { AzPlay IF }
  if uDB_AUser.Local.ADDONS.Azplay then
    mainScene.Header.Addon_Icon.Icons[uDB_AUser.Local.ADDONS.Azplay_D.Menu_Position].Text := #$e915;

  ADDONS.Active_Now_Num := -1;

  // Footer
  mainScene.Footer.Back := TImage.Create(mainScene.main.Down_Level);
  mainScene.Footer.Back.Name := 'Main_Footer';
  mainScene.Footer.Back.Parent := mainScene.main.Down_Level;
  mainScene.Footer.Back.SetBounds(0, extrafe.res.Height - 226, extrafe.res.Width, 226);
  mainScene.Footer.Back.Bitmap.LoadFromFile(ex_main.Paths.Images + 'back.png');
  mainScene.Footer.Back.WrapMode := TImageWrapMode.Tile;
  mainScene.Footer.Back.Visible := True;

  mainScene.Footer.Back_Line := TImage.Create(mainScene.Footer.Back);
  mainScene.Footer.Back_Line.Name := 'Main_Footer_Line';
  mainScene.Footer.Back_Line.Parent := mainScene.Footer.Back;
  mainScene.Footer.Back_Line.SetBounds(0, 0, extrafe.res.Width, 10);
  mainScene.Footer.Back_Line.Bitmap.LoadFromFile(ex_main.Paths.Images + 'line.png');
  mainScene.Footer.Back_Line.WrapMode := TImageWrapMode.Tile;
  mainScene.Footer.Back_Line.Visible := True;

  mainScene.Footer.Back_Ani := TFloatAnimation.Create(mainScene.Footer.Back);
  mainScene.Footer.Back_Ani.Name := 'Main_Footer_Animation';
  mainScene.Footer.Back_Ani.Parent := mainScene.Footer.Back;
  mainScene.Footer.Back_Ani.Duration := 0.2;
  mainScene.Footer.Back_Ani.PropertyName := 'Position.Y';
  // mainScene.Footer.Back_Ani.OnFinish:= vMain_Animation.OnFinish;
  mainScene.Footer.Back_Ani.Enabled := False;

  mainScene.Footer.Back_Blur := TGaussianBlurEffect.Create(mainScene.Footer.Back);
  mainScene.Footer.Back_Blur.Name := 'Main_Footer_Blur';
  mainScene.Footer.Back_Blur.Parent := mainScene.Footer.Back;
  mainScene.Footer.Back_Blur.BlurAmount := 0.5;
  mainScene.Footer.Back_Blur.Enabled := False;

  mainScene.Footer.GridPanel := TGridPanelLayout.Create(mainScene.Footer.Back);
  mainScene.Footer.GridPanel.Name := 'Main_Footer_GridPanel';
  mainScene.Footer.GridPanel.Parent := mainScene.Footer.Back;
  mainScene.Footer.GridPanel.Width := mainScene.Footer.Back.Width;
  mainScene.Footer.GridPanel.Height := mainScene.Footer.Back.Height;
  mainScene.Footer.GridPanel.Visible := True;

  for vi := 0 to 50 do
  begin
    mainScene.Footer.GridPanel.ColumnCollection.BeginUpdate;
    vCol := mainScene.Footer.GridPanel.ColumnCollection.Add;
    vCol.SizeStyle := TGridPanelLayout.TSizeStyle.Absolute;
    vCol.Value := 36;
    mainScene.Footer.GridPanel.ColumnCollection.EndUpdate;
  end;

  for vi := 0 to 3 do
  begin
    mainScene.Footer.GridPanel.RowCollection.BeginUpdate;
    vRow := mainScene.Footer.GridPanel.RowCollection.Add;
    vRow.SizeStyle := TGridPanelLayout.TSizeStyle.Absolute;
    vRow.Value := 36;
  end;

  mainScene.Footer.Settings := TText.Create(mainScene.Footer.Back);
  mainScene.Footer.Settings.Name := 'Main_Footer_Settings';
  mainScene.Footer.Settings.Parent := mainScene.Footer.Back;
  mainScene.Footer.Settings.SetBounds(mainScene.Footer.Back.Width - 100, (mainScene.Footer.Back.Height / 2) - 40, 80, 80);
  mainScene.Footer.Settings.Font.Family := 'IcoMoon-Free';
  mainScene.Footer.Settings.Font.Size := 72;
  mainScene.Footer.Settings.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  mainScene.Footer.Settings.Text := #$e994;
  mainScene.Footer.Settings.OnClick := ex_main.input.mouse.Text.OnMouseClick;
  mainScene.Footer.Settings.OnMouseEnter := ex_main.input.mouse.Text.OnMouseEnter;
  mainScene.Footer.Settings.OnMouseLeave := ex_main.input.mouse.Text.OnMouseLeave;
  mainScene.Footer.Settings.Visible := True;

  mainScene.Footer.Settings_Ani := TFloatAnimation.Create(mainScene.Footer.Settings);
  mainScene.Footer.Settings_Ani.Name := 'Main_Footer_Settings_Animation';
  mainScene.Footer.Settings_Ani.Parent := mainScene.Footer.Settings;
  mainScene.Footer.Settings_Ani.Duration := 4;
  mainScene.Footer.Settings_Ani.Loop := True;
  mainScene.Footer.Settings_Ani.PropertyName := 'RotationAngle';
  mainScene.Footer.Settings_Ani.StartValue := 0;
  mainScene.Footer.Settings_Ani.StopValue := 360;
  mainScene.Footer.Settings_Ani.Enabled := True;

  mainScene.Footer.Settings_Glow := TGlowEffect.Create(mainScene.Footer.Settings);
  mainScene.Footer.Settings_Glow.Name := 'Main_Footer_Settings_Glow';
  mainScene.Footer.Settings_Glow.Parent := mainScene.Footer.Settings;
  mainScene.Footer.Settings_Glow.GlowColor := TAlphaColorRec.Lightblue;
  mainScene.Footer.Settings_Glow.Opacity := 0.9;
  mainScene.Footer.Settings_Glow.Softness := 0.4;
  mainScene.Footer.Settings_Glow.Enabled := False;

  mainScene.Footer.Addon_Calendar.Icon := TImage.Create(mainScene.Footer.Back);
  mainScene.Footer.Addon_Calendar.Icon.Name := 'Main_Footer_Addon_Calendar_Icon';
  mainScene.Footer.Addon_Calendar.Icon.Parent := mainScene.Footer.Back;
  mainScene.Footer.Addon_Calendar.Icon.SetBounds(10, 10, 22, 22);
  mainScene.Footer.Addon_Calendar.Icon.Bitmap.LoadFromFile(ex_main.Paths.Images + 'calendar.png');
  mainScene.Footer.Addon_Calendar.Icon.WrapMode := TImageWrapMode.Fit;
  mainScene.Footer.Addon_Calendar.Icon.OnClick := ex_main.input.mouse.Image.OnMouseClick;
  mainScene.Footer.Addon_Calendar.Icon.OnMouseEnter := ex_main.input.mouse.Image.OnMouseEnter;
  mainScene.Footer.Addon_Calendar.Icon.OnMouseLeave := ex_main.input.mouse.Image.OnMouseLeave;
  mainScene.Footer.Addon_Calendar.Icon.Visible := True;

  mainScene.Footer.Addon_Calendar.Text := TText.Create(mainScene.Footer.Addon_Calendar.Icon);
  mainScene.Footer.Addon_Calendar.Text.Name := 'Main_Footer_Addon_Calendar_Text';
  mainScene.Footer.Addon_Calendar.Text.Parent := mainScene.Footer.Addon_Calendar.Icon;
  mainScene.Footer.Addon_Calendar.Text.SetBounds(28, 2, 96, 24); // Width Multiple to 24
  mainScene.Footer.Addon_Calendar.Text.Text := '';
  mainScene.Footer.Addon_Calendar.Text.Color := TAlphaColorRec.Deepskyblue;
  mainScene.Footer.Addon_Calendar.Text.Font.Family := 'Tahoma';
  mainScene.Footer.Addon_Calendar.Text.Font.Style := mainScene.Footer.Addon_Calendar.Text.Font.Style + [TFontStyle.fsBold];
  mainScene.Footer.Addon_Calendar.Text.Font.Size := 15;
  mainScene.Footer.Addon_Calendar.Text.TextSettings.HorzAlign := TTextAlign.Trailing;
  mainScene.Footer.Addon_Calendar.Text.TextSettings.VertAlign := TTextAlign.Center;
  mainScene.Footer.Addon_Calendar.Text.Visible := True;

  mainScene.Footer.Addon_Time.Icon := TImage.Create(mainScene.Footer.Back);
  mainScene.Footer.Addon_Time.Icon.Name := 'Main_Footer_Addon_Time_Icon';
  mainScene.Footer.Addon_Time.Icon.Parent := mainScene.Footer.Back;
  mainScene.Footer.Addon_Time.Icon.SetBounds(10, 34, 22, 22);
  mainScene.Footer.Addon_Time.Icon.Bitmap.LoadFromFile(ex_main.Paths.Images + 'time.png');
  mainScene.Footer.Addon_Time.Icon.WrapMode := TImageWrapMode.Fit;
  mainScene.Footer.Addon_Time.Icon.OnClick := ex_main.input.mouse.Image.OnMouseClick;
  mainScene.Footer.Addon_Time.Icon.OnMouseEnter := ex_main.input.mouse.Image.OnMouseEnter;
  mainScene.Footer.Addon_Time.Icon.OnMouseLeave := ex_main.input.mouse.Image.OnMouseLeave;
  mainScene.Footer.Addon_Time.Icon.Visible := True;

  mainScene.Footer.Addon_Time.Text := TText.Create(mainScene.Footer.Addon_Time.Icon);
  mainScene.Footer.Addon_Time.Text.Name := 'Main_Footer_Addon_Time_Text';
  mainScene.Footer.Addon_Time.Text.Parent := mainScene.Footer.Addon_Time.Icon;
  mainScene.Footer.Addon_Time.Text.SetBounds(28, 2, 96, 24);
  mainScene.Footer.Addon_Time.Text.Text := '';
  mainScene.Footer.Addon_Time.Text.Color := TAlphaColorRec.Deepskyblue;
  mainScene.Footer.Addon_Time.Text.Font.Family := 'Tahoma';
  mainScene.Footer.Addon_Time.Text.Font.Style := mainScene.Footer.Addon_Calendar.Text.Font.Style + [TFontStyle.fsBold];
  mainScene.Footer.Addon_Time.Text.Font.Size := 15;
  mainScene.Footer.Addon_Time.Text.TextSettings.HorzAlign := TTextAlign.Trailing;
  mainScene.Footer.Addon_Time.Text.TextSettings.VertAlign := TTextAlign.Center;
  mainScene.Footer.Addon_Time.Text.Visible := True;

  mainScene.Footer.Timer := TTimer.Create(mainScene.Footer.Back);
  mainScene.Footer.Timer.Name := 'Main_Footer_Timer';
  mainScene.Footer.Timer.Parent := mainScene.Footer.Back;
  mainScene.Footer.Timer.Interval := 30;
  mainScene.Footer.Timer.OnTimer := vMain_Timer.OnTimer;
  mainScene.Footer.Timer.Enabled := True;

  // Selection
  mainScene.Selection.Back := TImage.Create(mainScene.main.Down_Level);
  mainScene.Selection.Back.Name := 'Main_Selection_Back';
  mainScene.Selection.Back.Parent := mainScene.main.Down_Level;
  mainScene.Selection.Back.SetBounds(0, 130, extrafe.res.Width, 724);
  mainScene.Selection.Back.Bitmap.LoadFromFile(ex_main.Paths.Images + 'back.png');
  mainScene.Selection.Back.WrapMode := TImageWrapMode.Tile;
  mainScene.Selection.Back.Visible := True;

  mainScene.Selection.Line := TImage.Create(mainScene.Selection.Back);
  mainScene.Selection.Line.Name := 'Main_Selection_Line';
  mainScene.Selection.Line.Parent := mainScene.Selection.Back;
  mainScene.Selection.Line.SetBounds(0, 0, extrafe.res.Width, 10);
  mainScene.Selection.Line.Bitmap.LoadFromFile(ex_main.Paths.Images + 'line.png');
  mainScene.Selection.Line.WrapMode := TImageWrapMode.Tile;
  mainScene.Selection.Line.Visible := True;

  mainScene.Selection.Blur := TGaussianBlurEffect.Create(mainScene.Selection.Back);
  mainScene.Selection.Blur.Name := 'Main_Selection_Blur';
  mainScene.Selection.Blur.Parent := mainScene.Selection.Back;
  mainScene.Selection.Blur.BlurAmount := 0.5;
  mainScene.Selection.Blur.Enabled := False;

  uMain_Emulation.Create_Selection_Control;

end;

procedure uMain_SetAll_Exit;
begin
  mainScene.Header.Back_Blur.Enabled := True;
  mainScene.Selection.Blur.Enabled := True;
  mainScene.Footer.Back_Blur.Enabled := True;

  extrafe.prog.State := 'main_exit';

  mainScene.Header.Exit_Glow.Enabled := False;

  mainScene.main.Prog_Exit.Panel := TPanel.Create(mainScene.main.Down_Level);
  mainScene.main.Prog_Exit.Panel.Name := 'Main_Exit';
  mainScene.main.Prog_Exit.Panel.Parent := mainScene.main.Down_Level;
  mainScene.main.Prog_Exit.Panel.SetBounds(extrafe.res.Half_Width - 300, extrafe.res.Half_Height - 150, 600, 300);
  mainScene.main.Prog_Exit.Panel.Visible := True;

  mainScene.main.Prog_Exit.Panel_Shadow := TShadowEffect.Create(mainScene.main.Prog_Exit.Panel);
  mainScene.main.Prog_Exit.Panel_Shadow.Name := 'Main_Exit_Shadow';
  mainScene.main.Prog_Exit.Panel_Shadow.Parent := mainScene.main.Prog_Exit.Panel;
  mainScene.main.Prog_Exit.Panel_Shadow.ShadowColor := TAlphaColorRec.Deepskyblue;
  mainScene.main.Prog_Exit.Panel_Shadow.Direction := 90;
  mainScene.main.Prog_Exit.Panel_Shadow.Distance := 3;
  mainScene.main.Prog_Exit.Panel_Shadow.Enabled := True;

  CreateHeader(mainScene.main.Prog_Exit.Panel, 'IcoMoon-Free', #$ea0f, 'Exit ExtrFE?', False, nil);

  mainScene.main.Prog_Exit.main.Panel := TPanel.Create(mainScene.main.Prog_Exit.Panel);
  mainScene.main.Prog_Exit.main.Panel.Name := 'Main_Exit_Main';
  mainScene.main.Prog_Exit.main.Panel.Parent := mainScene.main.Prog_Exit.Panel;
  mainScene.main.Prog_Exit.main.Panel.SetBounds(0, 30, mainScene.main.Prog_Exit.Panel.Width, mainScene.main.Prog_Exit.Panel.Height - 30);
  mainScene.main.Prog_Exit.main.Panel.Visible := True;

  mainScene.main.Prog_Exit.main.Logo := TImage.Create(mainScene.main.Prog_Exit.main.Panel);
  mainScene.main.Prog_Exit.main.Logo.Name := 'Main_Exit_Main_Logo';
  mainScene.main.Prog_Exit.main.Logo.Parent := mainScene.main.Prog_Exit.main.Panel;
  mainScene.main.Prog_Exit.main.Logo.SetBounds(50, 30, 500, 150);
  mainScene.main.Prog_Exit.main.Logo.Bitmap.LoadFromFile(ex_main.Paths.Images + 'logo.png');
  mainScene.main.Prog_Exit.main.Logo.WrapMode := TImageWrapMode.Fit;
  mainScene.main.Prog_Exit.main.Logo.Visible := True;

  mainScene.main.Prog_Exit.main.Text := TText.Create(mainScene.main.Prog_Exit.main.Panel);
  mainScene.main.Prog_Exit.main.Text.Name := 'Main_Exit_Main_Text';
  mainScene.main.Prog_Exit.main.Text.Parent := mainScene.main.Prog_Exit.main.Panel;
  mainScene.main.Prog_Exit.main.Text.SetBounds(150, 10, 300, 50);
  mainScene.main.Prog_Exit.main.Text.Text := 'EXIT?';
  mainScene.main.Prog_Exit.main.Text.Font.Size := 18;
  mainScene.main.Prog_Exit.main.Text.Color := TAlphaColorRec.White;
  mainScene.main.Prog_Exit.main.Text.VertTextAlign := TTextAlign.Center;
  mainScene.main.Prog_Exit.main.Text.Visible := True;

  mainScene.main.Prog_Exit.main.Yes := TButton.Create(mainScene.main.Prog_Exit.main.Panel);
  mainScene.main.Prog_Exit.main.Yes.Name := 'Main_Exit_Main_Yes';
  mainScene.main.Prog_Exit.main.Yes.Parent := mainScene.main.Prog_Exit.main.Panel;
  mainScene.main.Prog_Exit.main.Yes.SetBounds(50, mainScene.main.Prog_Exit.main.Panel.Height - 38, 150, 28);
  mainScene.main.Prog_Exit.main.Yes.Text := 'Sorry, I have to go';
  mainScene.main.Prog_Exit.main.Yes.OnClick := ex_main.input.mouse.Button.OnMouseClick;
  mainScene.main.Prog_Exit.main.Yes.OnMouseEnter := ex_main.input.mouse.Button.OnMouseEnter;
  mainScene.main.Prog_Exit.main.Yes.OnMouseLeave := ex_main.input.mouse.Button.OnMouseLeave;
  mainScene.main.Prog_Exit.main.Yes.Visible := True;

  mainScene.main.Prog_Exit.main.No := TButton.Create(mainScene.main.Prog_Exit.main.Panel);
  mainScene.main.Prog_Exit.main.No.Name := 'Main_Exit_Main_No';
  mainScene.main.Prog_Exit.main.No.Parent := mainScene.main.Prog_Exit.main.Panel;
  mainScene.main.Prog_Exit.main.No.SetBounds(mainScene.main.Prog_Exit.main.Panel.Width - 200, mainScene.main.Prog_Exit.main.Panel.Height - 38, 150, 28);
  mainScene.main.Prog_Exit.main.No.Text := 'One minute more, please';
  mainScene.main.Prog_Exit.main.No.OnClick := ex_main.input.mouse.Button.OnMouseClick;
  mainScene.main.Prog_Exit.main.No.OnMouseEnter := ex_main.input.mouse.Button.OnMouseEnter;
  mainScene.main.Prog_Exit.main.No.OnMouseLeave := ex_main.input.mouse.Button.OnMouseLeave;
  mainScene.main.Prog_Exit.main.No.Visible := True;

end;

end.
