unit uMain_Widgets;

interface

uses
  System.Classes,
  System.UiTypes,
  FMX.StdCtrls,
  FMX.Layouts,
  FMX.Types,
  FMX.Graphics,
  FMX.Objects,
  FMX.Effects;

{
  Widget must be multiple to 36.
  Limit width 360  (36x10)
  Limit Height 144 (36x4)
}

procedure Create_Time;
procedure Create_Calendar;

implementation

uses
  uLoad_AllTypes,
  uMain_AllTypes;

procedure Create_Time;
begin
  mainScene.Footer.Widgets.Time.Panel := TLayout.Create(mainScene.Footer.Back);
  mainScene.Footer.Widgets.Time.Panel.Name := 'Main_Footer_Widget_Time';
  mainScene.Footer.Widgets.Time.Panel.Parent := mainScene.Footer.Back;
  mainScene.Footer.Widgets.Time.Panel.SetBounds(0, 0, 216, 36);
  mainScene.Footer.Widgets.Time.Panel.Visible := True;

  mainScene.Footer.Widgets.Time.Icon := TText.Create(mainScene.Footer.Widgets.Time.Panel);
  mainScene.Footer.Widgets.Time.Icon.Name := 'Main_Footer_Widget_Time_Icon';
  mainScene.Footer.Widgets.Time.Icon.Parent := mainScene.Footer.Widgets.Time.Panel;
  mainScene.Footer.Widgets.Time.Icon.SetBounds(2, 2, 32, 32);
  mainScene.Footer.Widgets.Time.Icon.Font.Family := 'IcoMoon-Free';
  mainScene.Footer.Widgets.Time.Icon.Font.Size := 28;
  mainScene.Footer.Widgets.Time.Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  mainScene.Footer.Widgets.Time.Icon.Text := #$e94e;
  // mainScene.Footer.Widgets.Time.Icon.OnClick := ex_main.input.mouse.Image.OnMouseClick;
  // mainScene.Footer.Widgets.Time.Icon.OnMouseEnter := ex_main.input.mouse.Image.OnMouseEnter;
  // mainScene.Footer.Widgets.Time.Icon.OnMouseLeave := ex_main.input.mouse.Image.OnMouseLeave;
  mainScene.Footer.Widgets.Time.Icon.Visible := True;

  mainScene.Footer.Widgets.Time.Text := TText.Create(mainScene.Footer.Widgets.Time.Panel);
  mainScene.Footer.Widgets.Time.Text.Name := 'Main_Footer_Widget_Time_Text';
  mainScene.Footer.Widgets.Time.Text.Parent := mainScene.Footer.Widgets.Time.Panel;
  mainScene.Footer.Widgets.Time.Text.SetBounds(36, 2, 180, 32);
  mainScene.Footer.Widgets.Time.Text.Text := '';
  mainScene.Footer.Widgets.Time.Text.Color := TAlphaColorRec.Deepskyblue;
  mainScene.Footer.Widgets.Time.Text.Font.Family := 'Tahoma';
  mainScene.Footer.Widgets.Time.Text.Font.Style := mainScene.Footer.Widgets.Time.Text.Font.Style + [TFontStyle.fsBold];
  mainScene.Footer.Widgets.Time.Text.Font.Size := 22;
  mainScene.Footer.Widgets.Time.Text.TextSettings.HorzAlign := TTextAlign.Trailing;
  mainScene.Footer.Widgets.Time.Text.TextSettings.VertAlign := TTextAlign.Center;
  mainScene.Footer.Widgets.Time.Text.Visible := True;
end;

procedure Create_Calendar;
begin
  mainScene.Footer.Widgets.Calendar.Panel := TLayout.Create(mainScene.Footer.Back);
  mainScene.Footer.Widgets.Calendar.Panel.Name := 'Main_Footer_Widget_Calendar';
  mainScene.Footer.Widgets.Calendar.Panel.Parent := mainScene.Footer.Back;
  mainScene.Footer.Widgets.Calendar.Panel.SetBounds(0, 0, 216, 36);
  mainScene.Footer.Widgets.Calendar.Panel.Visible := True;


  mainScene.Footer.Widgets.Calendar.Icon := TText.Create(mainScene.Footer.Widgets.Calendar.Panel);
  mainScene.Footer.Widgets.Calendar.Icon.Name := 'Main_Footer_Widget_Calendar_Icon';
  mainScene.Footer.Widgets.Calendar.Icon.Parent := mainScene.Footer.Widgets.Calendar.Panel;
  mainScene.Footer.Widgets.Calendar.Icon.SetBounds(2, 2, 32, 32);
  mainScene.Footer.Widgets.Calendar.Icon.Font.Family := 'IcoMoon-Free';
  mainScene.Footer.Widgets.Calendar.Icon.Font.Size := 28;
  mainScene.Footer.Widgets.Calendar.Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  mainScene.Footer.Widgets.Calendar.Icon.Text := #$e953;
  mainScene.Footer.Widgets.Calendar.Icon.Visible := True;

  mainScene.Footer.Widgets.Calendar.Text := TText.Create(mainScene.Footer.Widgets.Calendar.Panel);
  mainScene.Footer.Widgets.Calendar.Text.Name := 'Main_Footer_Widget_Calendar_Text';
  mainScene.Footer.Widgets.Calendar.Text.Parent := mainScene.Footer.Widgets.Calendar.Panel;
  mainScene.Footer.Widgets.Calendar.Text.SetBounds(36, 2, 180, 32);
  mainScene.Footer.Widgets.Calendar.Text.Text := '';
  mainScene.Footer.Widgets.Calendar.Text.Color := TAlphaColorRec.Deepskyblue;
  mainScene.Footer.Widgets.Calendar.Text.Font.Family := 'Tahoma';
  mainScene.Footer.Widgets.Calendar.Text.Font.Style := mainScene.Footer.Widgets.Calendar.Text.Font.Style + [TFontStyle.fsBold];
  mainScene.Footer.Widgets.Calendar.Text.Font.Size := 22;
  mainScene.Footer.Widgets.Calendar.Text.TextSettings.HorzAlign := TTextAlign.Trailing;
  mainScene.Footer.Widgets.Calendar.Text.TextSettings.VertAlign := TTextAlign.Center;
  mainScene.Footer.Widgets.Calendar.Text.Visible := True;

  mainScene.Footer.Widgets.Calendar.Above := TPanel.Create(mainScene.Footer.Widgets.Calendar.Panel);
  mainScene.Footer.Widgets.Calendar.Above.Name := 'Main_Footer_Widget_Calenadar_Above';
  mainScene.Footer.Widgets.Calendar.Above.Parent:=   mainScene.Footer.Widgets.Calendar.Panel;
  mainScene.Footer.Widgets.Calendar.Above.Align := TAlignLayout.Client;
  mainScene.Footer.Widgets.Calendar.Above.Opacity:= 0;
  mainScene.Footer.Widgets.Calendar.Above.OnClick := ex_main.input.mouse.Panel.OnMouseClick;
  mainScene.Footer.Widgets.Calendar.Above.OnMouseEnter := ex_main.input.mouse.Panel.OnMouseEnter;
  mainScene.Footer.Widgets.Calendar.Above.OnMouseLeave := ex_main.input.mouse.Panel.OnMouseLeave;
  mainScene.Footer.Widgets.Calendar.Above.Visible:= True;

  mainScene.Footer.Widgets.Calendar.Panel_Glow := TInnerGlowEffect.Create(mainScene.Footer.Widgets.Calendar.Above);
  mainScene.Footer.Widgets.Calendar.Panel_Glow.Name := 'Main_Footer_Widget_Calendar_Glow';
  mainScene.Footer.Widgets.Calendar.Panel_Glow.Parent := mainScene.Footer.Widgets.Calendar.Above;
  mainScene.Footer.Widgets.Calendar.Panel_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  mainScene.Footer.Widgets.Calendar.Panel_Glow.Softness := 0.9;
  mainScene.Footer.Widgets.Calendar.Panel_Glow.Enabled := False;
end;

end.
