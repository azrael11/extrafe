unit uWeather_SetAll;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UITypes,
  System.Math,
  FMX.Objects,
  FMX.Effects,
  FMX.Ani,
  FMX.StdCtrls,
  FMX.Layouts,
  FMX.Edit,
  FMX.Grid,
  FMX.Types,
  FMX.Filter.Effects,
  FMX.Graphics,
  FMX.Controls,
  ALFmxTabControl,
  main,
  uWeather_AllTypes;

procedure uWeather_SetComponentsToRightPlace;
procedure uWeather_SetAll_Create_Control;

implementation

uses
  uLoad,
  uLoad_AllTypes,
  uMain_SetAll,
  uMain_AllTypes,
  uWindows,
  uSnippet_Text,
  uWeather_Convert,
  uWeather_Mouse,
  uWeather_Actions,
  uWeather_MenuActions,
  uWeather_Config_Towns;

Procedure uWeather_SetComponentsToRightPlace;
const
  cLeft_Buttons_Names: array [0 .. 3] of string = ('Provider', 'Towns', 'Options', 'Iconsets');
var
  vComp: TComponent;
  vi, vl, vt: Integer;
begin
  // Main Form
  vWeather.Scene.Weather := TImage.Create(mainScene.main.Down_Level);
  vWeather.Scene.Weather.Name := 'A_Weather';
  vWeather.Scene.Weather.Parent := mainScene.main.Down_Level;
  vWeather.Scene.Weather.SetBounds(0, 130, extrafe.res.Width, extrafe.res.Height - 130);
  vWeather.Scene.Weather.Bitmap.LoadFromFile(addons.Weather.Path.Images + 'w_back.png');
  vWeather.Scene.Weather.WrapMode := TImageWrapMode.Tile;
  vWeather.Scene.Weather.Visible := True;

  vWeather.Scene.Weather_Ani := TFloatAnimation.Create(vWeather.Scene.Weather);
  vWeather.Scene.Weather_Ani.Name := 'A_Weather_Animation';
  vWeather.Scene.Weather_Ani.Parent := vWeather.Scene.Weather;
  vWeather.Scene.Weather_Ani.AnimationType := TAnimationType.&In;
  vWeather.Scene.Weather_Ani.Duration := 0.4;
  vWeather.Scene.Weather_Ani.PropertyName := 'Opacity';
  vWeather.Scene.Weather_Ani.StartValue := 1;
  vWeather.Scene.Weather_Ani.StopValue := 0;
  vWeather.Scene.Weather_Ani.Enabled := False;

  vWeather.Scene.Back := TImage.Create(vWeather.Scene.Weather);
  vWeather.Scene.Back.Name := 'A_W_Back';
  vWeather.Scene.Back.Parent := vWeather.Scene.Weather;
  vWeather.Scene.Back.SetBounds(0, 0, vWeather.Scene.Weather.Width, vWeather.Scene.Weather.Height);
  vWeather.Scene.Back.Bitmap.LoadFromFile(addons.Weather.Path.Images + 'w_back.png');
  vWeather.Scene.Back.WrapMode := TImageWrapMode.Tile;
  vWeather.Scene.Back.Visible := True;

  vWeather.Scene.Blur := TGaussianBlurEffect.Create(vWeather.Scene.Back);
  vWeather.Scene.Blur.Name := 'A_W_Blur';
  vWeather.Scene.Blur.Parent := vWeather.Scene.Back;
  vWeather.Scene.Blur.BlurAmount := 0.5;
  vWeather.Scene.Blur.Enabled := False;

  vWeather.Scene.UpLine := TImage.Create(vWeather.Scene.Weather);
  vWeather.Scene.UpLine.Name := 'A_W_UpLine_Image';
  vWeather.Scene.UpLine.Parent := vWeather.Scene.Weather;
  vWeather.Scene.UpLine.SetBounds(0, 0, vWeather.Scene.Weather.Width, 10);
  vWeather.Scene.UpLine.Bitmap.LoadFromFile(addons.Weather.Path.Images + 'w_spot.png');
  vWeather.Scene.UpLine.WrapMode := TImageWrapMode.Tile;
  vWeather.Scene.UpLine.Visible := True;

  vWeather.Scene.MiddleLine := TImage.Create(vWeather.Scene.Weather);
  vWeather.Scene.MiddleLine.Name := 'A_W_MiddleLine_Image';
  vWeather.Scene.MiddleLine.Parent := vWeather.Scene.Weather;
  vWeather.Scene.MiddleLine.SetBounds(0, vWeather.Scene.Weather.Height - 162,
    vWeather.Scene.Weather.Width, 10);
  vWeather.Scene.MiddleLine.Bitmap.LoadFromFile(addons.Weather.Path.Images + 'w_spot.png');
  vWeather.Scene.MiddleLine.WrapMode := TImageWrapMode.Tile;
  vWeather.Scene.MiddleLine.Visible := True;

  vWeather.Scene.Arrow_Left := TImage.Create(vWeather.Scene.Weather);
  vWeather.Scene.Arrow_Left.Name := 'A_W_ArrowLeft_Image';
  vWeather.Scene.Arrow_Left.Parent := vWeather.Scene.Weather;
  vWeather.Scene.Arrow_Left.SetBounds(20, vWeather.Scene.Back.Height - 130, 64, 64);
  vWeather.Scene.Arrow_Left.Bitmap.LoadFromFile(addons.Weather.Path.Images + 'w_arrow_left.png');
  vWeather.Scene.Arrow_Left.WrapMode := TImageWrapMode.Fit;
  vWeather.Scene.Arrow_Left.OnClick := addons.Weather.Input.mouse.Image.OnMouseClick;
  vWeather.Scene.Arrow_Left.OnMouseEnter := addons.Weather.Input.mouse.Image.OnMouseEnter;
  vWeather.Scene.Arrow_Left.OnMouseLeave := addons.Weather.Input.mouse.Image.OnMouseLeave;
  vWeather.Scene.Arrow_Left.Visible := False;

  vWeather.Scene.Arrow_Left_Glow := TGlowEffect.Create(vWeather.Scene.Arrow_Left);
  vWeather.Scene.Arrow_Left_Glow.Name := 'A_W_ArrowLeft_Glow';
  vWeather.Scene.Arrow_Left_Glow.Parent := vWeather.Scene.Arrow_Left;
  vWeather.Scene.Arrow_Left_Glow.Enabled := False;

  vWeather.Scene.Arrow_Right := TImage.Create(vWeather.Scene.Weather);
  vWeather.Scene.Arrow_Right.Name := 'A_W_ArrowRight_Image';
  vWeather.Scene.Arrow_Right.Parent := vWeather.Scene.Weather;
  vWeather.Scene.Arrow_Right.SetBounds(vWeather.Scene.Back.Width - 84,
    vWeather.Scene.Back.Height - 130, 64, 64);
  vWeather.Scene.Arrow_Right.Bitmap.LoadFromFile(addons.Weather.Path.Images + 'w_arrow_right.png');
  vWeather.Scene.Arrow_Right.WrapMode := TImageWrapMode.Fit;
  vWeather.Scene.Arrow_Right.OnClick := addons.Weather.Input.mouse.Image.OnMouseClick;
  vWeather.Scene.Arrow_Right.OnMouseEnter := addons.Weather.Input.mouse.Image.OnMouseEnter;
  vWeather.Scene.Arrow_Right.OnMouseLeave := addons.Weather.Input.mouse.Image.OnMouseLeave;
  vWeather.Scene.Arrow_Right.Visible := False;

  vWeather.Scene.Arrow_Right_Glow := TGlowEffect.Create(vWeather.Scene.Arrow_Right);
  vWeather.Scene.Arrow_Right_Glow.Name := 'A_W_ArrowRight_Glow';
  vWeather.Scene.Arrow_Right_Glow.Parent := vWeather.Scene.Arrow_Right;
  vWeather.Scene.Arrow_Right_Glow.Enabled := False;

  vWeather.Scene.DownLine := TImage.Create(vWeather.Scene.Back);
  vWeather.Scene.DownLine.Name := 'A_W_DownLine_Image';
  vWeather.Scene.DownLine.Parent := vWeather.Scene.Back;
  vWeather.Scene.DownLine.SetBounds(0, vWeather.Scene.Back.Height - 10, vWeather.Scene.Back.Width, 10);
  vWeather.Scene.DownLine.Bitmap.LoadFromFile(addons.Weather.Path.Images + 'w_spot.png');
  vWeather.Scene.DownLine.WrapMode := TImageWrapMode.Tile;
  vWeather.Scene.DownLine.Visible := True;

  // Control
  uWeather_SetAll_Create_Control;

  // Settings
  vWeather.Scene.Settings := TImage.Create(vWeather.Scene.Weather);
  vWeather.Scene.Settings.Name := 'A_W_Settings_Image';
  vWeather.Scene.Settings.Parent := vWeather.Scene.Weather;
  vWeather.Scene.Settings.SetBounds(vWeather.Scene.Weather.Width - 60, 20, 50, 50);
  vWeather.Scene.Settings.Bitmap.LoadFromFile(addons.Weather.Path.Images + 'w_settings_blue.png');
  vWeather.Scene.Settings.WrapMode := TImageWrapMode.Fit;
  vWeather.Scene.Settings.OnClick := addons.Weather.Input.mouse.Image.OnMouseClick;
  vWeather.Scene.Settings.OnMouseEnter := addons.Weather.Input.mouse.Image.OnMouseEnter;
  vWeather.Scene.Settings.OnMouseLeave := addons.Weather.Input.mouse.Image.OnMouseLeave;
  vWeather.Scene.Settings.Visible := False;

  vWeather.Scene.Settings_Ani := TFloatAnimation.Create(vWeather.Scene.Settings);
  vWeather.Scene.Settings_Ani.Name := 'A_W_Settings_Animation';
  vWeather.Scene.Settings_Ani.Parent := vWeather.Scene.Settings;
  vWeather.Scene.Settings_Ani.Duration := 4;
  vWeather.Scene.Settings_Ani.Loop := True;
  vWeather.Scene.Settings_Ani.PropertyName := 'RotationAngle';
  vWeather.Scene.Settings_Ani.StartValue := 0;
  vWeather.Scene.Settings_Ani.StopValue := 360;
  vWeather.Scene.Settings_Ani.Enabled := False;

  vWeather.Scene.Settings_Glow := TGlowEffect.Create(vWeather.Scene.Settings);
  vWeather.Scene.Settings_Glow.Name := 'A_W_Settings_Glow';
  vWeather.Scene.Settings_Glow.Parent := vWeather.Scene.Settings;
  vWeather.Scene.Settings_Glow.GlowColor := TAlphaColorRec.Lightblue;
  vWeather.Scene.Settings_Glow.Opacity := 0.9;
  vWeather.Scene.Settings_Glow.Softness := 0.4;
  vWeather.Scene.Settings_Glow.Enabled := False;

  // Config Panel
  vWeather.Config.Panel := Tpanel.Create(vWeather.Scene.Weather);
  vWeather.Config.Panel.Name := 'A_W_Config';
  vWeather.Config.Panel.Parent := vWeather.Scene.Weather;
  vWeather.Config.Panel.Width := 705;
  vWeather.Config.Panel.Height := 550;
  vWeather.Config.Panel.Position.X := (vWeather.Scene.Back.Width / 2) - (vWeather.Config.Panel.Width / 2);
  vWeather.Config.Panel.Position.Y := 90;
  vWeather.Config.Panel.Visible := False;

  vWeather.Config.Panel_Blur := TGaussianBlurEffect.Create(vWeather.Config.Panel);
  vWeather.Config.Panel_Blur.Name := 'A_W_Config_Main_Blur';
  vWeather.Config.Panel_Blur.Parent := vWeather.Config.Panel;
  vWeather.Config.Panel_Blur.BlurAmount := 0.5;
  vWeather.Config.Panel_Blur.Enabled := False;

  uLoad_SetAll_CreateHeader(vWeather.Config.Panel, 'A_W_Config', addons.Weather.Path.Images +
    'w_settings_blue.png', 'Weather configuration.');

  vWeather.Config.main.Panel := Tpanel.Create(vWeather.Config.Panel);
  vWeather.Config.main.Panel.Name := 'A_W_Config_Main';
  vWeather.Config.main.Panel.Parent := vWeather.Config.Panel;
  vWeather.Config.main.Panel.SetBounds(0, 30, vWeather.Config.Panel.Width, vWeather.Config.Panel.Height - 30);
  vWeather.Config.main.Panel.Visible := True;

  // Left Panel with action buttons
  vWeather.Config.main.Left.Panel := Tpanel.Create(vWeather.Config.main.Panel);
  vWeather.Config.main.Left.Panel.Name := 'Weather_Config_Left_Panel';
  vWeather.Config.main.Left.Panel.Parent := vWeather.Config.main.Panel;
  vWeather.Config.main.Left.Panel.SetBounds(0, 0, 210, vWeather.Config.main.Panel.Height);
  vWeather.Config.main.Left.Panel.Visible := True;

  for vi := 0 to 3 do
  begin
    vWeather.Config.main.Left.Buttons[vi] := TButton.Create(vWeather.Config.main.Left.Panel);
    vWeather.Config.main.Left.Buttons[vi].Name := 'A_W_Config_Left_Button_' + vi.ToString;
    vWeather.Config.main.Left.Buttons[vi].Parent := vWeather.Config.main.Left.Panel;
    vWeather.Config.main.Left.Buttons[vi].SetBounds(10, 30 + (vi * 40), 190, 33);
    vWeather.Config.main.Left.Buttons[vi].Text := cLeft_Buttons_Names[vi];
    vWeather.Config.main.Left.Buttons[vi].OnClick := addons.Weather.Input.mouse.Button.OnMouseClick;
    vWeather.Config.main.Left.Buttons[vi].Visible := True;
  end;

  addons.weather.Config.Active_Panel:= -1;

  // Right panel
  vWeather.Config.main.Right.Panel := Tpanel.Create(vWeather.Config.main.Panel);
  vWeather.Config.main.Right.Panel.Name := 'Weather_Config_Right_Panel';
  vWeather.Config.main.Right.Panel.Parent := vWeather.Config.main.Panel;
  vWeather.Config.main.Right.Panel.SetBounds(210, 0, vWeather.Config.main.Panel.Width - 210,
    vWeather.Config.main.Panel.Height);
  vWeather.Config.main.Right.Panel.Visible := True;

  vWeather.Config.Main.Right.NoProvider_Selected:= TText.Create(vWeather.Config.Main.Right.Panel);
  vWeather.Config.Main.Right.NoProvider_Selected.Name:= 'Weather_Config_Right_Panel_Text';
  vWeather.Config.Main.Right.NoProvider_Selected.Parent:=  vWeather.Config.Main.Right.Panel;
  vWeather.Config.Main.Right.NoProvider_Selected.SetBounds((vWeather.Config.Main.Right.Panel.Width /2)- 150, 100, 300, 30);
  vWeather.Config.Main.Right.NoProvider_Selected.TextSettings.FontColor:= TAlphaColorRec.White;
  vWeather.Config.Main.Right.NoProvider_Selected.TextSettings.Font.Size:= 16;
  vWeather.Config.Main.Right.NoProvider_Selected.TextSettings.HorzAlign:= TTextAlign.Center;
  if addons.weather.Action.provider= '' then
    vWeather.Config.Main.Right.NoProvider_Selected.Text:= 'Please select forecast provider first!!!';
  vWeather.Config.Main.Right.NoProvider_Selected.Visible:= True;

  uWeather_Actions_Load;
end;

procedure uWeather_SetAll_Create_Control;
begin
  vWeather.Scene.Control := TALTabControl.Create(vWeather.Scene.Back);
  vWeather.Scene.Control.Name := 'A_W_Control';
  vWeather.Scene.Control.Parent := vWeather.Scene.Back;
  vWeather.Scene.Control.Width := vWeather.Scene.Back.Width - 20;
  vWeather.Scene.Control.Height := vWeather.Scene.Back.Height - 10;
  vWeather.Scene.Control.Position.X := 10;
  vWeather.Scene.Control.Position.Y := 10;
  vWeather.Scene.Control.OnAniStop := vWeather_Animation.OnAniStop;
  vWeather.Scene.Control.Visible := True;

  vWeather.Scene.Control_Ani := TFloatAnimation.Create(vWeather.Scene.Control);
  vWeather.Scene.Control_Ani.Name := 'A_W_Control_Ani';
  vWeather.Scene.Control_Ani.Parent := vWeather.Scene.Control;
  vWeather.Scene.Control_Ani.Duration := 2;
  vWeather.Scene.Control_Ani.PropertyName := 'Opacity';
  vWeather.Scene.Control_Ani.StartValue := 0;
  vWeather.Scene.Control_Ani.StopValue := 1;
end;

end.
