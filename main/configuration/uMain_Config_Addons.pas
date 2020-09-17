unit uMain_Config_Addons;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UITypes,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Layouts,
  FMX.Effects,
  FMX.Types,
  FMX.Filter.Effects,
  ALFMXObjects,
  bass;

const
  cFist_Group_Images: array [0 .. 4] of string = (#$e94e, #$e953, #$e9c1, #$ea15, #$e915);

procedure Icons(vStart: Integer);
procedure Icons_Free;

procedure Create;

procedure ShowInfo(vAddon_Num: Integer);


implementation

uses
  uDB_AUser,
  uMain_AllTypes,
  uLoad_AllTypes,
  uMain_Config_Addons_Weather,
  uMain_Config_Addons_Soundplayer,
  uMain_Config_Addons_Time,
  uMain_Config_Addons_AzPlay,
  uMain_Config_Addons_Calendar;

procedure Icons_Free;
var
  vi: Integer;
begin
  for vi := 0 to 3 do
    FreeAndNil(mainScene.Config.main.R.Addons.Icons[vi]);
end;

procedure Icons(vStart: Integer);
var
  vi: Integer;
begin
  for vi := 0 to 3 do
  begin
    mainScene.Config.main.R.Addons.Icons[vi] := TText.Create(mainScene.Config.main.R.Addons.Groupbox);
    mainScene.Config.main.R.Addons.Icons[vi].Name := 'Main_Config_Addons_Groupbox_0_Image_' + IntToStr(vStart + vi);
    mainScene.Config.main.R.Addons.Icons[vi].Parent := mainScene.Config.main.R.Addons.Groupbox;
    mainScene.Config.main.R.Addons.Icons[vi].SetBounds(74 + (vi * 118), 20, 70, 70);
    mainScene.Config.main.R.Addons.Icons[vi].Font.Family := 'IcoMoon-Free';
    mainScene.Config.main.R.Addons.Icons[vi].Font.Size := 64;
    mainScene.Config.main.R.Addons.Icons[vi].TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    mainScene.Config.main.R.Addons.Icons[vi].Text := cFist_Group_Images[vi + vStart];
    mainScene.Config.main.R.Addons.Icons[vi].OnClick := ex_main.input.mouse_config.Text.OnMouseClick;
    mainScene.Config.main.R.Addons.Icons[vi].OnMouseEnter := ex_main.input.mouse_config.Text.OnMouseEnter;
    mainScene.Config.main.R.Addons.Icons[vi].OnMouseLeave := ex_main.input.mouse_config.Text.OnMouseLeave;
    mainScene.Config.main.R.Addons.Icons[vi].Tag := vStart + vi;
    mainScene.Config.main.R.Addons.Icons[vi].Visible := True;

    mainScene.Config.main.R.Addons.Icons_Glow[vStart + vi] := TGlowEffect.Create(mainScene.Config.main.R.Addons.Icons[vStart + vi]);
    mainScene.Config.main.R.Addons.Icons_Glow[vStart + vi].Name := 'Main_Config_Addons_Groupbox_0_Image_Glow_' + (vStart + vi).ToString;
    mainScene.Config.main.R.Addons.Icons_Glow[vStart + vi].Parent := mainScene.Config.main.R.Addons.Icons[vi];
    mainScene.Config.main.R.Addons.Icons_Glow[vStart + vi].GlowColor := TAlphaColorRec.Deepskyblue;
    mainScene.Config.main.R.Addons.Icons_Glow[vStart + vi].Softness := 0.5;
    mainScene.Config.main.R.Addons.Icons_Glow[vStart + vi].Opacity := 0.9;
    mainScene.Config.main.R.Addons.Icons_Glow[vStart + vi].Enabled := False;
  end;
end;

procedure ShowInfo(vAddon_Num: Integer);
var
  vi: Integer;
  vPos_Num: Integer;
begin
  for vi := 0 to 5 do
    if Assigned(mainScene.Config.main.R.Addons.Icons_Panel[vi]) then
      FreeAndNil(mainScene.Config.main.R.Addons.Icons_Panel[vi]);

  mainScene.Config.main.R.Addons.Icons_Panel[vAddon_Num] := TCalloutPanel.Create(mainScene.Config.main.R.Addons.Panel);
  mainScene.Config.main.R.Addons.Icons_Panel[vAddon_Num].Name := 'Main_Config_Addons_Addon_Panel';
  mainScene.Config.main.R.Addons.Icons_Panel[vAddon_Num].Parent := mainScene.Config.main.R.Addons.Panel;
  mainScene.Config.main.R.Addons.Icons_Panel[vAddon_Num].SetBounds(10, 110, mainScene.Config.main.R.Addons.Groupbox.Width,
    mainScene.Config.main.R.Addons.Panel.Height - 118);

  vPos_Num := vAddon_Num - ex_main.Config.Addons_Tab_First;

  case vPos_Num of
    0:
      mainScene.Config.main.R.Addons.Icons_Panel[vAddon_Num].CalloutOffset := 97;
    1:
      mainScene.Config.main.R.Addons.Icons_Panel[vAddon_Num].CalloutOffset := 212;
    2:
      mainScene.Config.main.R.Addons.Icons_Panel[vAddon_Num].CalloutOffset := 330;
    3:
      mainScene.Config.main.R.Addons.Icons_Panel[vAddon_Num].CalloutOffset := 454;
  end;

  mainScene.Config.main.R.Addons.Icons_Panel[vAddon_Num].Visible := True;

  case vAddon_Num of
    0:
      uMain_Config_Addons_Time.Show(vPos_Num);
    1:
      uMain_Config_Addons_Calendar.Show(vPos_Num);
    2:
      uMain_Config_Addons_Weather.Show(vPos_Num);
    3:
      uMain_Config_Addons_Soundplayer.Show(vPos_Num);
    4:
      uMain_Config_Addons_AzPlay.Show(vPos_Num);
  end;

  ex_main.Config.Addons_Active_Tab := vAddon_Num;
end;

procedure Create;
var
  vi: Integer;
begin
  extrafe.prog.State := 'main_config_addons';

  mainScene.Config.main.R.Addons.Panel := TPanel.Create(mainScene.Config.main.R.Panel[4]);
  mainScene.Config.main.R.Addons.Panel.Name := 'Main_Config_Addons_Panel';
  mainScene.Config.main.R.Addons.Panel.Parent := mainScene.Config.main.R.Panel[4];
  mainScene.Config.main.R.Addons.Panel.Align := TAlignLayout.Client;
  mainScene.Config.main.R.Addons.Panel.Visible := True;

  mainScene.Config.main.R.Addons.Panel_Blur := TGaussianBlurEffect.Create(mainScene.Config.main.R.Addons.Panel);
  mainScene.Config.main.R.Addons.Panel_Blur.Name := 'Main_Config_Addons_Panel_Blur';
  mainScene.Config.main.R.Addons.Panel_Blur.Parent := mainScene.Config.main.R.Addons.Panel;
  mainScene.Config.main.R.Addons.Panel_Blur.BlurAmount := 0.5;
  mainScene.Config.main.R.Addons.Panel_Blur.Enabled := False;

  mainScene.Config.main.R.Addons.Groupbox := TGroupBox.Create(mainScene.Config.main.R.Addons.Panel);
  mainScene.Config.main.R.Addons.Groupbox.Name := 'Main_Config_Addons_Groupbox_0';
  mainScene.Config.main.R.Addons.Groupbox.Parent := mainScene.Config.main.R.Addons.Panel;
  mainScene.Config.main.R.Addons.Groupbox.SetBounds(10, 10, mainScene.Config.main.R.Addons.Panel.Width - 20, 98);
  mainScene.Config.main.R.Addons.Groupbox.Text := 'Addons';
  mainScene.Config.main.R.Addons.Groupbox.Visible := True;

  mainScene.Config.main.R.Addons.Arrow_Left := TText.Create(mainScene.Config.main.R.Addons.Groupbox);
  mainScene.Config.main.R.Addons.Arrow_Left.Name := 'Main_Config_Addons_Arrow_Left';
  mainScene.Config.main.R.Addons.Arrow_Left.Parent := mainScene.Config.main.R.Addons.Groupbox;
  mainScene.Config.main.R.Addons.Arrow_Left.SetBounds(4, 20, 70, 70);
  mainScene.Config.main.R.Addons.Arrow_Left.Font.Family := 'IcoMoon-Free';
  mainScene.Config.main.R.Addons.Arrow_Left.Font.Size := 56;
  mainScene.Config.main.R.Addons.Arrow_Left.TextSettings.FontColor := TAlphaColorRec.Grey;
  mainScene.Config.main.R.Addons.Arrow_Left.Text := #$ea38;
  mainScene.Config.main.R.Addons.Arrow_Left.OnClick := ex_main.input.mouse_config.Text.OnMouseClick;
  mainScene.Config.main.R.Addons.Arrow_Left.OnMouseEnter := ex_main.input.mouse_config.Text.OnMouseEnter;
  mainScene.Config.main.R.Addons.Arrow_Left.OnMouseLeave := ex_main.input.mouse_config.Text.OnMouseLeave;
  mainScene.Config.main.R.Addons.Arrow_Left.Visible := True;

  mainScene.Config.main.R.Addons.Arrow_Left_Glow := TGlowEffect.Create(mainScene.Config.main.R.Addons.Arrow_Left);
  mainScene.Config.main.R.Addons.Arrow_Left_Glow.Name := 'Main_Config_Addons_Arrow_Left_Glow';
  mainScene.Config.main.R.Addons.Arrow_Left_Glow.Parent := mainScene.Config.main.R.Addons.Arrow_Left;
  mainScene.Config.main.R.Addons.Arrow_Left_Glow.Softness := 0.4;
  mainScene.Config.main.R.Addons.Arrow_Left_Glow.Opacity := 0.9;
  mainScene.Config.main.R.Addons.Arrow_Left_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  mainScene.Config.main.R.Addons.Arrow_Left_Glow.Enabled := False;

  mainScene.Config.main.R.Addons.Left_Num := TText.Create(mainScene.Config.main.R.Addons.Groupbox);
  mainScene.Config.main.R.Addons.Left_Num.Name := 'Main_Config_Addons_Left_Num';
  mainScene.Config.main.R.Addons.Left_Num.Parent := mainScene.Config.main.R.Addons.Groupbox;
  mainScene.Config.main.R.Addons.Left_Num.SetBounds(-10, 76, 50, 20);
  mainScene.Config.main.R.Addons.Left_Num.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  mainScene.Config.main.R.Addons.Left_Num.TextSettings.Font.Size := 12;
  mainScene.Config.main.R.Addons.Left_Num.Text := '';
  mainScene.Config.main.R.Addons.Left_Num.Visible := False;

  mainScene.Config.main.R.Addons.Arrow_Right := TText.Create(mainScene.Config.main.R.Addons.Groupbox);
  mainScene.Config.main.R.Addons.Arrow_Right.Name := 'Main_Config_Addons_Arrow_Right';
  mainScene.Config.main.R.Addons.Arrow_Right.Parent := mainScene.Config.main.R.Addons.Groupbox;
  mainScene.Config.main.R.Addons.Arrow_Right.SetBounds(mainScene.Config.main.R.Addons.Groupbox.Width - 74, 20, 70, 70);
  mainScene.Config.main.R.Addons.Arrow_Right.Font.Family := 'IcoMoon-Free';
  mainScene.Config.main.R.Addons.Arrow_Right.Font.Size := 56;
  mainScene.Config.main.R.Addons.Arrow_Right.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  mainScene.Config.main.R.Addons.Arrow_Right.Text := #$ea34;
  mainScene.Config.main.R.Addons.Arrow_Right.OnClick := ex_main.input.mouse_config.Text.OnMouseClick;
  mainScene.Config.main.R.Addons.Arrow_Right.OnMouseEnter := ex_main.input.mouse_config.Text.OnMouseEnter;
  mainScene.Config.main.R.Addons.Arrow_Right.OnMouseLeave := ex_main.input.mouse_config.Text.OnMouseLeave;
  mainScene.Config.main.R.Addons.Arrow_Right.Visible := True;

  mainScene.Config.main.R.Addons.Arrow_Right_Glow := TGlowEffect.Create(mainScene.Config.main.R.Addons.Arrow_Right);
  mainScene.Config.main.R.Addons.Arrow_Right_Glow.Name := 'Main_Config_Addons_Arrow_Right_Glow';
  mainScene.Config.main.R.Addons.Arrow_Right_Glow.Parent := mainScene.Config.main.R.Addons.Arrow_Right;
  mainScene.Config.main.R.Addons.Arrow_Right_Glow.Softness := 0.4;
  mainScene.Config.main.R.Addons.Arrow_Right_Glow.Opacity := 0.9;
  mainScene.Config.main.R.Addons.Arrow_Right_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  mainScene.Config.main.R.Addons.Arrow_Right_Glow.Enabled := False;

  mainScene.Config.main.R.Addons.Right_Num := TText.Create(mainScene.Config.main.R.Addons.Groupbox);
  mainScene.Config.main.R.Addons.Right_Num.Name := 'Main_Config_Addons_Right_Num';
  mainScene.Config.main.R.Addons.Right_Num.Parent := mainScene.Config.main.R.Addons.Groupbox;
  mainScene.Config.main.R.Addons.Right_Num.SetBounds(mainScene.Config.main.R.Addons.Groupbox.Width - 40, 76, 50, 20);
  mainScene.Config.main.R.Addons.Right_Num.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  mainScene.Config.main.R.Addons.Right_Num.TextSettings.Font.Size := 12;
  mainScene.Config.main.R.Addons.Right_Num.Text := '';
  mainScene.Config.main.R.Addons.Right_Num.Visible := True;

  ex_main.Config.Addons_Active_Tab := -1;
  ex_main.Config.Addons_Tab_First := 0;
  ex_main.Config.Addons_Tab_Last := 3;

  Icons(ex_main.Config.Addons_Tab_First);

  if uDB_AUser.Local.Addons.Count > 3 then
  begin
    mainScene.Config.main.R.Addons.Right_Num.Visible := True;
    mainScene.Config.main.R.Addons.Right_Num.Text := (uDB_AUser.Local.Addons.Count - 3).ToString;
  end;
end;

end.
