unit uMain_Config;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  FMX.Types,
  FMX.Effects,
  FMX.Filter.Effects,
  FMX.StdCtrls,
  FMX.Ani,
  FMX.Objects;

procedure uMain_Config_Load;
procedure uMain_COnfig_Free;

procedure uMain_Config_FreePanel(vPanel: Integer);

procedure uMain_Config_ShowHide(vMain_State: String);

procedure uMain_Config_ShowPanel(vPanel: Byte);

implementation

uses
  main,
  uLoad_AllTypes,
  uMain_SetAll,
  uMain_AllTypes,
  uMain_Mouse,
  uMain_Config_Profile,
  uMain_Config_Emulators,
  uMain_Config_Addons,
  uMain_Config_Themes,
  uMain_Config_Info,
  uMain_Config_Info_Credits;

procedure uMain_Config_Load;
const
  cButton_Names: array [0 .. 6] of string = ('Profile', 'General', 'Emulators', 'PC Games', 'Addons',
    'Themes', 'Info');
var
  vi: Integer;
begin
  if Assigned(mainScene.Config.Panel) then
    FreeAndNil(mainScene.Config.Panel);

  mainScene.Config.Panel := TPanel.Create(Main_Form);
  mainScene.Config.Panel.Name := 'Main_Config_Panel';
  mainScene.Config.Panel.Parent := Main_Form;
  mainScene.Config.Panel.Width := 810;
  mainScene.Config.Panel.Height := 620;
  mainScene.Config.Panel.Position.X := extrafe.res.Width + 810;
  mainScene.Config.Panel.Position.Y := (extrafe.res.Height / 2) - 310;
  mainScene.Config.Panel.Visible := True;

  mainScene.Config.Panel_Shadow := TShadowEffect.Create(mainScene.Config.Panel);
  mainScene.Config.Panel_Shadow.Name := 'Main_Config_Shadow';
  mainScene.Config.Panel_Shadow.Parent := mainScene.Config.Panel;
  mainScene.Config.Panel_Shadow.Direction := 45;
  mainScene.Config.Panel_Shadow.Opacity := 0.6;
  mainScene.Config.Panel_Shadow.ShadowColor := TAlphaColorRec.Deepskyblue;
  mainScene.Config.Panel_Shadow.Softness := 0.3;
  mainScene.Config.Panel_Shadow.Distance := 5;
  mainScene.Config.Panel_Shadow.Enabled := True;

  mainScene.Config.Panel_Ani := TFloatAnimation.Create(mainScene.Config.Panel);
  mainScene.Config.Panel_Ani.Name := 'Main_Config_Ani';
  mainScene.Config.Panel_Ani.Parent := mainScene.Config.Panel;
  mainScene.Config.Panel_Ani.Duration := 0.4;
  mainScene.Config.Panel_Ani.PropertyName := 'Position.X';
  mainScene.Config.Panel_Ani.OnFinish := ex_main.input.mouse.Animation.OnFinish;
  mainScene.Config.Panel_Ani.Enabled := False;

  mainScene.Config.Header.Panel := TPanel.Create(mainScene.Config.Panel);
  mainScene.Config.Header.Panel.Name := 'Main_Config_Header_Panel';
  mainScene.Config.Header.Panel.Parent := mainScene.Config.Panel;
  mainScene.Config.Header.Panel.Width := 810;
  mainScene.Config.Header.Panel.Height := 30;
  mainScene.Config.Header.Panel.Position.X := 0;
  mainScene.Config.Header.Panel.Position.Y := 0;
  mainScene.Config.Header.Panel.Visible := True;

  mainScene.Config.Header.Icon := TImage.Create(mainScene.Config.Header.Panel);
  mainScene.Config.Header.Icon.Name := 'Main_Config_Header_Icon';
  mainScene.Config.Header.Icon.Parent := mainScene.Config.Header.Panel;
  mainScene.Config.Header.Icon.Width := 24;
  mainScene.Config.Header.Icon.Height := 24;
  mainScene.Config.Header.Icon.Position.X := 6;
  mainScene.Config.Header.Icon.Position.Y := 3;
  mainScene.Config.Header.Icon.Bitmap.LoadFromFile(ex_main.Paths.Config_Images + 'config_settings.png');
  mainScene.Config.Header.Icon.WrapMode := TImageWrapMode.Fit;
  mainScene.Config.Header.Icon.Visible := True;

  mainScene.Config.Header.Text := TLabel.Create(mainScene.Config.Header.Panel);
  mainScene.Config.Header.Text.Name := 'Main_Config_Header_Label';
  mainScene.Config.Header.Text.Parent := mainScene.Config.Header.Panel;
  mainScene.Config.Header.Text.Width := mainScene.Config.Header.Panel.Width;
  mainScene.Config.Header.Text.Height := 24;
  mainScene.Config.Header.Text.Position.X := 36;
  mainScene.Config.Header.Text.Position.Y := 3;
  mainScene.Config.Header.Text.Text := 'Main configuration';
  mainScene.Config.Header.Text.Visible := True;

  mainScene.Config.main.Left := TPanel.Create(mainScene.Config.Panel);
  mainScene.Config.main.Left.Name := 'Main_Config_Left_Panel';
  mainScene.Config.main.Left.Parent := mainScene.Config.Panel;
  mainScene.Config.main.Left.Width := 210;
  mainScene.Config.main.Left.Height := 590;
  mainScene.Config.main.Left.Position.X := 0;
  mainScene.Config.main.Left.Position.Y := 30;
  mainScene.Config.main.Left.Visible := True;

  mainScene.Config.main.Left_Blur := TBlurEffect.Create(mainScene.Config.main.Left);
  mainScene.Config.main.Left_Blur.Name := 'Main_Config_Left_Blur';
  mainScene.Config.main.Left_Blur.Parent := mainScene.Config.main.Left;
  mainScene.Config.main.Left_Blur.Softness := 0.5;
  mainScene.Config.main.Left_Blur.Enabled := False;

  mainScene.Config.main.Right := TPanel.Create(mainScene.Config.Panel);
  mainScene.Config.main.Right.Name := 'Main_Config_Right_Panel';
  mainScene.Config.main.Right.Parent := mainScene.Config.Panel;
  mainScene.Config.main.Right.Width := 600;
  mainScene.Config.main.Right.Height := 590;
  mainScene.Config.main.Right.Position.X := 210;
  mainScene.Config.main.Right.Position.Y := 30;
  mainScene.Config.main.Right.Visible := True;

  for vi := 0 to 6 do
  begin
    mainScene.Config.main.L.Button[vi] := TButton.Create(mainScene.Config.main.Left);
    mainScene.Config.main.L.Button[vi].Name := 'Main_Config_Button_' + IntToStr(vi);
    mainScene.Config.main.L.Button[vi].Parent := mainScene.Config.main.Left;
    mainScene.Config.main.L.Button[vi].Width := 190;
    mainScene.Config.main.L.Button[vi].Height := 33;
    mainScene.Config.main.L.Button[vi].Position.X := 10;
    mainScene.Config.main.L.Button[vi].Position.Y := 30 + (vi * 40);
    mainScene.Config.main.L.Button[vi].Text := cButton_Names[vi];
    mainScene.Config.main.L.Button[vi].OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
    mainScene.Config.main.L.Button[vi].Tag := vi;
    mainScene.Config.main.L.Button[vi].Visible := True;
  end;

  for vi := 0 to 6 do
  begin
    mainScene.Config.main.R.Panel[vi] := TPanel.Create(mainScene.Config.main.Right);
    mainScene.Config.main.R.Panel[vi].Name := 'Main_Config_Panel_' + IntToStr(vi);
    mainScene.Config.main.R.Panel[vi].Parent := mainScene.Config.main.Right;
    mainScene.Config.main.R.Panel[vi].Align := TAlignLayout.Client;
    mainScene.Config.main.R.Panel[vi].Position.X := 0;
    mainScene.Config.main.R.Panel[vi].Position.Y := 0;
    mainScene.Config.main.R.Panel[vi].Visible := False;
  end;

  ex_main.Settings.Config_Pos.X := mainScene.Config.Panel.Position.X;
  ex_main.Settings.Config_Pos.Y := mainScene.Config.Panel.Position.Y;
  ex_main.Config.Active_Panel := -1;
end;

procedure uMain_COnfig_Free;
var
  vi: Integer;
begin
  FreeAndNil(mainScene.Config.Panel);
end;

procedure uMain_Config_ShowHide(vMain_State: String);
begin
  if vMain_State = 'main' then
  begin
    extrafe.prog.State := 'main_config';
    uMain_Config_Load;
    mainScene.Config.Panel_Ani.AnimationType := TAnimationType.Out;
    mainScene.Config.Panel_Ani.Interpolation := TInterpolationType.Bounce;
    mainScene.Config.Panel_Ani.StartValue := ex_main.Settings.Config_Pos.X;
    mainScene.Config.Panel_Ani.StopValue := (extrafe.res.Width / 2) - 405;
    mainScene.Config.Panel_Ani.Start;
    mainScene.Header.Back_Blur.Enabled := True;
    mainScene.Selection.Blur.Enabled := True;
  end
  else
  begin
    mainScene.Config.Panel_Ani.AnimationType := TAnimationType.In;
    mainScene.Config.Panel_Ani.Interpolation := TInterpolationType.Elastic;
    mainScene.Config.Panel_Ani.StartValue := (extrafe.res.Width / 2) - 405;
    mainScene.Config.Panel_Ani.StopValue := ex_main.Settings.Config_Pos.X;
    mainScene.Config.Panel_Ani.Start;
    mainScene.Header.Back_Blur.Enabled := False;
    mainScene.Selection.Blur.Enabled := False;
    uMain_Config_FreePanel(ex_main.Config.Active_Panel);
    extrafe.prog.State := 'main';
  end;
end;

procedure uMain_Config_FreePanel(vPanel: Integer);
var
  vi: Integer;
begin
  case ex_main.Config.Active_Panel of
    0:
      FreeAndNil(mainScene.Config.main.R.Profile.Panel);
    1:
      ; // mainScene.Config.R.General
    2:
      begin
        for vi := 0 to 4 do
          FreeAndNil(mainScene.Config.main.R.Emulators.Panels[vi]);
        FreeAndNil(mainScene.Config.main.R.Emulators.Panel);
      end;
    3:
      ; // mainScene.Config.R.PCGames
    4:
      FreeAndNil(mainScene.Config.main.R.Addons.Panel);
    5:
      FreeAndNil(mainScene.Config.main.R.Themes.Panel);
    6:
      begin
        uMain_Config_Info_Credits_ClearBrands;
        FreeAndNil(mainScene.Config.main.R.Info.Panel);
      end;
  end;
end;

procedure uMain_Config_ShowPanel(vPanel: Byte);
var
  vi: Integer;
begin
  if ex_main.Config.Active_Panel <> vPanel then
  begin
    uMain_Config_FreePanel(vPanel);
    for vi := 0 to 6 do
      mainScene.Config.main.R.Panel[vi].Visible := False;
    mainScene.Config.main.R.Panel[vPanel].Visible := True;

    case vPanel of
      0:
        uMain_Config_Profile_Create;
      1:
        ;
      2:
        uMain_Config_Emulators_Create;
      3:
        ;
      4:
        uMain_Config_Addons_Create;
      5:
        uMain_Config_Themes_Create;
      6:
        uMain_Config_Info_Create;
    end;
    ex_main.Config.Active_Panel := vPanel;
  end;
end;

end.
