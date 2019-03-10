unit uEmu_Arcade_Mame_SetAll;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UITypes,
  System.Types,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Types,
  FMX.Effects,
  FMX.Graphics,
  FMX.Layouts,
  FMX.Ani,
  FMX.Filter.Effects,
  FMX.Edit,
  FmxPasLibVlcPlayerUnit,
  PasLibVlcUnit;

procedure uEmu_Arcade_Mame_SetAll_Set;
procedure Create_Video_Scene;
procedure HideShow_Video_Scene(vShow: Boolean);
procedure Create_Image_Scene;
procedure HideShow_Image_Scene(vShow: Boolean);

implementation

uses
  uLoad,
  emu,
  uSnippet_Search,
  uEmu_SetAll,
  uEmu_Commands,
  uEmu_Arcade_Mame_Mouse,
  uEmu_Arcade_Mame_Ini,
  uEmu_Arcade_Mame_Support_Files,
  uEmu_Arcade_Mame_AllTypes;

procedure uEmu_Arcade_Mame_SetAll_Set;
var
  vList: TStringlist;
  viPos: Integer;
  vPoint: TPoint;
  vFilter_Selected_Name: string;
  vi: Integer;
begin
  vList := TStringlist.Create;

  vMame.Scene.Main := TImage.Create(Emu_Form);
  vMame.Scene.Main.Name := 'Mame_Main';
  vMame.Scene.Main.Parent := Emu_Form;
  vMame.Scene.Main.SetBounds(0, 0, Emu_Form.Width, Emu_Form.Height);
  // vMame.Scene.Main.Bitmap.LoadFromFile(mame.Prog.Images+ 'config_background.png');
  // vMame.Scene.Main.WrapMode:= TImageWrapMode;
  vMame.Scene.Main.Visible := True;

  vMame.Scene.Main_Blur := TGaussianBlurEffect.Create(vMame.Scene.Main);
  vMame.Scene.Main_Blur.Name := 'Mame_Main_Blur';
  vMame.Scene.Main_Blur.Parent := vMame.Scene.Main;
  vMame.Scene.Main_Blur.BlurAmount := 0;
  vMame.Scene.Main_Blur.Enabled := False;

  // Create Configuration panel
  vMame.Config.Scene.Main := TPanel.Create(vMame.Scene.Main);
  vMame.Config.Scene.Main.Name := 'Mame_Config';
  vMame.Config.Scene.Main.Parent := vMame.Scene.Main;
  vMame.Config.Scene.Main.SetBounds(((vMame.Scene.Main.Width / 2) - 350),
    ((vMame.Scene.Main.Height / 2) - 300), 700, 630);
  vMame.Config.Scene.Main.Visible := True;

  vMame.Config.Scene.Main_Blur := TGaussianBlurEffect.Create(vMame.Config.Scene.Main);
  vMame.Config.Scene.Main_Blur.Name := 'Mame_Config_Blur';
  vMame.Config.Scene.Main_Blur.Parent := vMame.Config.Scene.Main;
  vMame.Config.Scene.Main_Blur.BlurAmount := 0.6;
  vMame.Config.Scene.Main_Blur.Enabled := False;

  vMame.Config.Scene.Shadow := TShadowEffect.Create(vMame.Config.Scene.Main);
  vMame.Config.Scene.Shadow.Name := 'Mame_Config_Shadow';
  vMame.Config.Scene.Shadow.Parent := vMame.Config.Scene.Main;
  vMame.Config.Scene.Shadow.Direction := 90;
  vMame.Config.Scene.Shadow.Distance := 5;
  vMame.Config.Scene.Shadow.Opacity := 0.8;
  vMame.Config.Scene.Shadow.ShadowColor := TAlphaColorRec.Darkslategray;
  vMame.Config.Scene.Shadow.Softness := 0.5;
  vMame.Config.Scene.Shadow.Enabled := True;

  vMame.Config.Scene.Header := TPanel.Create(vMame.Config.Scene.Main);
  vMame.Config.Scene.Header.Name := 'Mame_Config_Header';
  vMame.Config.Scene.Header.Parent := vMame.Config.Scene.Main;
  vMame.Config.Scene.Header.SetBounds(0, 0, 700, 30);
  vMame.Config.Scene.Header.Visible := True;

  vMame.Config.Scene.Left := TPanel.Create(vMame.Config.Scene.Main);
  vMame.Config.Scene.Left.Name := 'Mame_Config_Left';
  vMame.Config.Scene.Left.Parent := vMame.Config.Scene.Main;
  vMame.Config.Scene.Left.SetBounds(0, 30, 150, 600);
  vMame.Config.Scene.Left.Visible := True;

  vMame.Config.Scene.Right := TPanel.Create(vMame.Config.Scene.Main);
  vMame.Config.Scene.Right.Name := 'Mame_Config_Right';
  vMame.Config.Scene.Right.Parent := vMame.Config.Scene.Main;
  vMame.Config.Scene.Right.SetBounds(150, 30, 550, 600);
  vMame.Config.Scene.Right.Visible := True;

  // Create main backs
  // vMame.Scene.Snap.Full_Video:= TFmxPasLibVlcPlayer.Create(vMame.Scene.Main);
  // vMame.Scene.Snap.Full_Video.Name:= 'Mame_Full_Video';
  // vMame.Scene.Snap.Full_Video.Parent:= vMame.Scene.Main;
  // vMame.Scene.Snap.Full_Video.Align:= TAlignLayout.Client;

  vMame.Scene.Right := TImage.Create(vMame.Scene.Main);
  vMame.Scene.Right.Name := 'Mame_Right';
  vMame.Scene.Right.Parent := vMame.Scene.Main;
  vMame.Scene.Right.SetBounds((vMame.Scene.Main.Width / 2), 0, (vMame.Scene.Main.Width / 2),
    (vMame.Scene.Main.Height));
  vMame.Scene.Right.Bitmap.LoadFromFile(mame.Prog.Images + 'background.png');
  vMame.Scene.Right.WrapMode := TImageWrapMode.Original;
  vMame.Scene.Right.BitmapMargins.Left := -(vMame.Scene.Main.Width / 2);
  vMame.Scene.Right.Visible := True;

  vMame.Scene.Right_Anim := TFloatAnimation.Create(vMame.Scene.Right);
  vMame.Scene.Right_Anim.Name := 'Mame_Right_Animation';
  vMame.Scene.Right_Anim.Parent := vMame.Scene.Right;
  vMame.Scene.Right_Anim.Duration := 0.2;
  vMame.Scene.Right_Anim.Interpolation := TInterpolationType.Cubic;
  vMame.Scene.Right_Anim.PropertyName := 'Position.X';
  vMame.Scene.Right_Anim.OnFinish := mame.Input.Mouse.Animation.OnFinish;
  vMame.Scene.Right_Anim.Enabled := False;

  vMame.Scene.Right_Blur := TBlurEffect.Create(vMame.Scene.Right);
  vMame.Scene.Right_Blur.Name := 'Mame_Blur_Right';
  vMame.Scene.Right_Blur.Parent := vMame.Scene.Right;
  vMame.Scene.Right_Blur.Enabled := False;

  vMame.Scene.Left := TImage.Create(vMame.Scene.Main);
  vMame.Scene.Left.Name := 'Mame_Left';
  vMame.Scene.Left.Parent := vMame.Scene.Main;
  vMame.Scene.Left.SetBounds(0, 0, (vMame.Scene.Main.Width / 2), (vMame.Scene.Main.Height));
  vMame.Scene.Left.Bitmap.LoadFromFile(mame.Prog.Images + 'background.png');
  vMame.Scene.Left.WrapMode := TImageWrapMode.Original;
  vMame.Scene.Left.Visible := True;

  vMame.Scene.Left_Anim := TFloatAnimation.Create(vMame.Scene.Left);
  vMame.Scene.Left_Anim.Name := 'Mame_Left_Animation';
  vMame.Scene.Left_Anim.Parent := vMame.Scene.Left;
  vMame.Scene.Left_Anim.Duration := 0.2;
  vMame.Scene.Left_Anim.Interpolation := TInterpolationType.Cubic;
  vMame.Scene.Left_Anim.PropertyName := 'Position.X';
  vMame.Scene.Left_Anim.OnFinish := mame.Input.Mouse.Animation.OnFinish;
  vMame.Scene.Left_Anim.Enabled := False;

  vMame.Scene.Left_Blur := TBlurEffect.Create(vMame.Scene.Left);
  vMame.Scene.Left_Blur.Name := 'Mame_Blur_Left';
  vMame.Scene.Left_Blur.Parent := vMame.Scene.Left;
  vMame.Scene.Left_Blur.Enabled := False;

  // Create actions
  vMame.Scene.Exit_Mame := TImage.Create(vMame.Scene.Right);
  vMame.Scene.Exit_Mame.Name := 'Mame_Exit';
  vMame.Scene.Exit_Mame.Parent := vMame.Scene.Right;
  vMame.Scene.Exit_Mame.SetBounds((vMame.Scene.Right.Width - 29), 5, 24, 24);
  vMame.Scene.Exit_Mame.Bitmap.LoadFromFile(mame.Prog.Images + 'exit_mame.png');
  vMame.Scene.Exit_Mame.WrapMode := TImageWrapMode.Fit;
  vMame.Scene.Exit_Mame.OnClick := mame.Input.Mouse.Image.OnMouseClick;
  vMame.Scene.Exit_Mame.OnMouseEnter := mame.Input.Mouse.Image.OnMouseEnter;
  vMame.Scene.Exit_Mame.OnMouseLeave := mame.Input.Mouse.Image.OnMouseLeave;
  vMame.Scene.Exit_Mame.Visible := True;

  vMame.Scene.Exit_Mame_Glow := TGlowEffect.Create(vMame.Scene.Exit_Mame);
  vMame.Scene.Exit_Mame_Glow.Name := 'Mame_Exit_Glow';
  vMame.Scene.Exit_Mame_Glow.Parent := vMame.Scene.Exit_Mame;
  vMame.Scene.Exit_Mame_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vMame.Scene.Exit_Mame_Glow.Opacity := 0.9;
  vMame.Scene.Exit_Mame_Glow.Softness := 0.4;
  vMame.Scene.Exit_Mame_Glow.Enabled := False;

  vMame.Scene.Settings := TImage.Create(vMame.Scene.Main);
  vMame.Scene.Settings.Name := 'Mame_Settings';
  vMame.Scene.Settings.Parent := vMame.Scene.Main;
  vMame.Scene.Settings.SetBounds(((vMame.Scene.Main.Width / 2) - 25), (vMame.Scene.Main.Height - 60), 50, 50);
  vMame.Scene.Settings.Bitmap.LoadFromFile(mame.Prog.Images + 'settings_blue.png');
  vMame.Scene.Settings.WrapMode := TImageWrapMode.Fit;
  vMame.Scene.Settings.OnClick := mame.Input.Mouse.Image.OnMouseClick;
  vMame.Scene.Settings.OnMouseEnter := mame.Input.Mouse.Image.OnMouseEnter;
  vMame.Scene.Settings.OnMouseLeave := mame.Input.Mouse.Image.OnMouseLeave;
  vMame.Scene.Settings.Tag := 1;
  vMame.Scene.Settings.Visible := True;

  vMame.Scene.Settings_Ani := TFloatAnimation.Create(vMame.Scene.Settings);
  vMame.Scene.Settings_Ani.Name := 'Mame_Settings_Ani';
  vMame.Scene.Settings_Ani.Parent := vMame.Scene.Settings;
  vMame.Scene.Settings_Ani.Duration := 4;
  vMame.Scene.Settings_Ani.Loop := True;
  vMame.Scene.Settings_Ani.PropertyName := 'RotationAngle';
  vMame.Scene.Settings_Ani.StartValue := 0;
  vMame.Scene.Settings_Ani.StopValue := 360;
  vMame.Scene.Settings_Ani.Enabled := True;

  vMame.Scene.Settings_Glow := TGlowEffect.Create(vMame.Scene.Settings);
  vMame.Scene.Settings_Glow.Name := 'Mame_Settings_Glow';
  vMame.Scene.Settings_Glow.Parent := vMame.Scene.Settings;
  vMame.Scene.Settings_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vMame.Scene.Settings_Glow.Opacity := 0.9;
  vMame.Scene.Settings_Glow.Softness := 0.4;
  vMame.Scene.Settings_Glow.Enabled := False;

  // Create gamelist
  vMame.Scene.Gamelist.List := TImage.Create(vMame.Scene.Left);
  vMame.Scene.Gamelist.List.Name := 'Mame_Gamelist_Image';
  vMame.Scene.Gamelist.List.Parent := vMame.Scene.Left;
  vMame.Scene.Gamelist.List.SetBounds(50, 50, 750, (vMame.Scene.Left.Height - 180));
  vMame.Scene.Gamelist.List.WrapMode := TImageWrapMode.Tile;
  vMame.Scene.Gamelist.List.Bitmap.LoadFromFile(mame.Prog.Images + 'black_menu.png');
  vMame.Scene.Gamelist.List.Visible := True;

  vMame.Scene.Gamelist.Listbox := TVertScrollBox.Create(vMame.Scene.Gamelist.List);
  vMame.Scene.Gamelist.Listbox.Name := 'Mame_Gamelist_Box';
  vMame.Scene.Gamelist.Listbox.Parent := vMame.Scene.Gamelist.List;
  vMame.Scene.Gamelist.Listbox.Align := TAlignLayout.Client;
  vMame.Scene.Gamelist.Listbox.ShowScrollBars := False;
  vMame.Scene.Gamelist.Listbox.Visible := True;

  for vi := 0 to 20 do
  begin
    vMame.Scene.Gamelist.List_Line[vi].Back := TImage.Create(vMame.Scene.Gamelist.Listbox);
    vMame.Scene.Gamelist.List_Line[vi].Back.Name := 'Mame_Gamelist_Back_' + IntToStr(vi);
    vMame.Scene.Gamelist.List_Line[vi].Back.Parent := vMame.Scene.Gamelist.Listbox;
    vMame.Scene.Gamelist.List_Line[vi].Back.SetBounds(0, ((vi * 40) + (vi + 10)),
      (vMame.Scene.Gamelist.Listbox.Width - 10), 40);
    vMame.Scene.Gamelist.List_Line[vi].Back.Tag := vi;
    vMame.Scene.Gamelist.List_Line[vi].Back.Visible := True;

    vMame.Scene.Gamelist.List_Line[vi].Icon := TImage.Create(vMame.Scene.Gamelist.List_Line[vi].Back);
    vMame.Scene.Gamelist.List_Line[vi].Icon.Name := 'Mame_Gamelist_Icon_' + IntToStr(vi);
    vMame.Scene.Gamelist.List_Line[vi].Icon.Parent := vMame.Scene.Gamelist.List_Line[vi].Back;
    vMame.Scene.Gamelist.List_Line[vi].Icon.SetBounds(4, 2, 38, 38);
    vMame.Scene.Gamelist.List_Line[vi].Icon.Tag := vi;
    vMame.Scene.Gamelist.List_Line[vi].Icon.Visible := True;

    vMame.Scene.Gamelist.List_Line[vi].Text := TText.Create(vMame.Scene.Gamelist.List_Line[vi].Back);
    vMame.Scene.Gamelist.List_Line[vi].Text.Name := 'Mame_Gamelist_Text_' + IntToStr(vi);
    vMame.Scene.Gamelist.List_Line[vi].Text.Parent := vMame.Scene.Gamelist.List_Line[vi].Back;
    vMame.Scene.Gamelist.List_Line[vi].Text.SetBounds(48, 3, 654, 34);
    vMame.Scene.Gamelist.List_Line[vi].Text.Text := IntToStr(vi);
    vMame.Scene.Gamelist.List_Line[vi].Text.Font.Family := 'Tahoma';
    vMame.Scene.Gamelist.List_Line[vi].Text.Color := TAlphaColorRec.White;
    vMame.Scene.Gamelist.List_Line[vi].Text.Font.Style := vMame.Scene.Gamelist.List_Line[vi].Text.Font.Style +
      [TFontStyle.fsBold];
    if vi = 10 then
      vMame.Scene.Gamelist.List_Line[vi].Text.Font.Size := 24
    else
      vMame.Scene.Gamelist.List_Line[vi].Text.Font.Size := 18;
    vMame.Scene.Gamelist.List_Line[vi].Text.HorzTextAlign := TTextAlign.Leading;
    vMame.Scene.Gamelist.List_Line[vi].Text.Tag := vi;
    vMame.Scene.Gamelist.List_Line[vi].Text.Visible := True;
  end;

  vMame.Scene.Gamelist.List_Selection_Glow := TGlowEffect.Create(vMame.Scene.Gamelist.List_Line[10].Text);
  vMame.Scene.Gamelist.List_Selection_Glow.Name := 'Mame_Gamelist_Glow_Selected';
  vMame.Scene.Gamelist.List_Selection_Glow.Parent := vMame.Scene.Gamelist.List_Line[10].Text;
  vMame.Scene.Gamelist.List_Selection_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vMame.Scene.Gamelist.List_Selection_Glow.Opacity := 0.9;
  vMame.Scene.Gamelist.List_Selection_Glow.Softness := 0.4;
  vMame.Scene.Gamelist.List_Selection_Glow.Enabled := True;

  vMame.Scene.Gamelist.List_Line[10].Back.Bitmap.LoadFromFile(mame.Prog.Images + 'selection.png');

  // Create all the other components
  vMame.Scene.Gamelist.Up_Back_Image := TImage.Create(vMame.Scene.Left);
  vMame.Scene.Gamelist.Up_Back_Image.Name := 'Mame_Gamelist_Up_Back_Image';
  vMame.Scene.Gamelist.Up_Back_Image.Parent := vMame.Scene.Left;
  vMame.Scene.Gamelist.Up_Back_Image.SetBounds(50, 18, 750, 26);
  vMame.Scene.Gamelist.Up_Back_Image.WrapMode := TImageWrapMode.Tile;
  vMame.Scene.Gamelist.Up_Back_Image.Bitmap.LoadFromFile(mame.Prog.Images + 'black_menu.png');
  vMame.Scene.Gamelist.Up_Back_Image.Visible := True;

  vMame.Scene.Gamelist.Filters := TImage.Create(vMame.Scene.Left);
  vMame.Scene.Gamelist.Filters.Name := 'Mame_Gamelist_Filters_Image';
  vMame.Scene.Gamelist.Filters.Parent := vMame.Scene.Left;
  vMame.Scene.Gamelist.Filters.SetBounds(4, 62, 24, 24);
  vMame.Scene.Gamelist.Filters.WrapMode := TImageWrapMode.Fit;
  vMame.Scene.Gamelist.Filters.Bitmap.LoadFromFile(mame.Prog.Images + 'filters.png');
  vMame.Scene.Gamelist.Filters.OnClick := mame.Input.Mouse.Image.OnMouseClick;
  vMame.Scene.Gamelist.Filters.OnMouseEnter := mame.Input.Mouse.Image.OnMouseEnter;
  vMame.Scene.Gamelist.Filters.OnMouseLeave := mame.Input.Mouse.Image.OnMouseLeave;
  vMame.Scene.Gamelist.Filters.Visible := True;

  vMame.Scene.Gamelist.Filters_Glow := TGlowEffect.Create(vMame.Scene.Gamelist.Filters);
  vMame.Scene.Gamelist.Filters_Glow.Name := 'Mame_Gamelist_Filters_Glow';
  vMame.Scene.Gamelist.Filters_Glow.Parent := vMame.Scene.Gamelist.Filters;
  vMame.Scene.Gamelist.Filters_Glow.Enabled := False;

  vMame.Scene.Gamelist.T_Games_Count_Info := TText.Create(vMame.Scene.Gamelist.Up_Back_Image);
  vMame.Scene.Gamelist.T_Games_Count_Info.Name := 'Mame_Gamelist_GameInfoShow_Text';
  vMame.Scene.Gamelist.T_Games_Count_Info.Parent := vMame.Scene.Gamelist.Up_Back_Image;
  vMame.Scene.Gamelist.T_Games_Count_Info.SetBounds(0, 1, 750, 22);
  vMame.Scene.Gamelist.T_Games_Count_Info.Text := '';
  vMame.Scene.Gamelist.T_Games_Count_Info.Color := TAlphaColorRec.White;
  vMame.Scene.Gamelist.T_Games_Count_Info.Font.Family := 'Tahoma';
  vMame.Scene.Gamelist.T_Games_Count_Info.Font.Style := vMame.Scene.Gamelist.T_Games_Count_Info.Font.Style +
    [TFontStyle.fsBold];
  vMame.Scene.Gamelist.T_Games_Count_Info.Font.Size := 20;
  vMame.Scene.Gamelist.T_Games_Count_Info.TextSettings.HorzAlign := TTextAlign.Trailing;
  vMame.Scene.Gamelist.T_Games_Count_Info.Visible := True;

  mame.emu.MameVer := mame.Prog.Ini.ReadString('MAME', 'mame_version', mame.emu.MameVer);
  if mame.emu.MameVer = '' then
  begin
    vList.LoadFromFile(mame.Prog.Data_Path + 'version.txt');
    viPos := Pos('(', vList.Strings[0]);
    mame.emu.MameVer := Trim(Copy(vList.Strings[0], 0, viPos - 1));
    mame.Prog.Ini.WriteString('MAME', 'mame_version', mame.emu.MameVer);
    DeleteFile(PChar(mame.Prog.Data_Path + 'version.txt'));
    vList.Free;
  end;

  vMame.Scene.Gamelist.T_MameVersion := TText.Create(vMame.Scene.Gamelist.Up_Back_Image);
  vMame.Scene.Gamelist.T_MameVersion.Name := 'Mame_Gamelist_MameVersion_Text';
  vMame.Scene.Gamelist.T_MameVersion.Parent := vMame.Scene.Gamelist.Up_Back_Image;
  vMame.Scene.Gamelist.T_MameVersion.SetBounds(0, 1, 750, 22);
  vMame.Scene.Gamelist.T_MameVersion.Color := TAlphaColorRec.White;
  vMame.Scene.Gamelist.T_MameVersion.Text := mame.emu.MameVer;
  vMame.Scene.Gamelist.T_MameVersion.Font.Family := 'Tahoma';
  vMame.Scene.Gamelist.T_MameVersion.Font.Style := vMame.Scene.Gamelist.T_MameVersion.Font.Style +
    [TFontStyle.fsBold];
  vMame.Scene.Gamelist.T_MameVersion.Font.Size := 20;
  vMame.Scene.Gamelist.T_MameVersion.TextSettings.HorzAlign := TTextAlign.Leading;
  vMame.Scene.Gamelist.T_MameVersion.Visible := True;

  vMame.Scene.Snap.SnapInfo := TText.Create(vMame.Scene.Right);
  vMame.Scene.Snap.SnapInfo.Name := 'Mame_Snap_SnapInfo_Text';
  vMame.Scene.Snap.SnapInfo.Parent := vMame.Scene.Right;
  vMame.Scene.Snap.SnapInfo.SetBounds(((vMame.Scene.Right.Width / 2) - 300), 20, 600, 22);
  vMame.Scene.Snap.SnapInfo.Color := TAlphaColorRec.White;
  vMame.Scene.Snap.SnapInfo.Font.Family := 'Tahoma';
  vMame.Scene.Snap.SnapInfo.Font.Style := vMame.Scene.Snap.SnapInfo.Font.Style + [TFontStyle.fsBold];
  vMame.Scene.Snap.SnapInfo.Font.Size := 20;
  vMame.Scene.Snap.SnapInfo.Text := 'Video Snaps';
  vMame.Scene.Snap.SnapInfo.TextSettings.HorzAlign := TTextAlign.Center;
  vMame.Scene.Snap.SnapInfo.Visible := True;

  Create_Video_Scene;
  HideShow_Video_Scene(True);
  Create_Image_Scene;
  HideShow_Image_Scene(False);

  mame.Actions.Video_Scene_Show:= True;

  vMame.Scene.Gamelist.Down_Back_Image := TImage.Create(vMame.Scene.Left);
  vMame.Scene.Gamelist.Down_Back_Image.Name := 'Mame_Gamelist_Down_Back_Image';
  vMame.Scene.Gamelist.Down_Back_Image.Parent := vMame.Scene.Left;
  vMame.Scene.Gamelist.Down_Back_Image.SetBounds(50, 958, 750, 26);
  vMame.Scene.Gamelist.Down_Back_Image.WrapMode := TImageWrapMode.Tile;
  vMame.Scene.Gamelist.Down_Back_Image.Bitmap.LoadFromFile(mame.Prog.Images + 'black_menu.png');
  vMame.Scene.Gamelist.Down_Back_Image.Visible := True;

  vMame.Scene.Gamelist.T_GamePlayers := TText.Create(vMame.Scene.Gamelist.Down_Back_Image);
  vMame.Scene.Gamelist.T_GamePlayers.Name := 'Mame_Gamelist_GamePlayers_Text';
  vMame.Scene.Gamelist.T_GamePlayers.Parent := vMame.Scene.Gamelist.Down_Back_Image;
  vMame.Scene.Gamelist.T_GamePlayers.SetBounds(0, 1, 750, 22);
  vMame.Scene.Gamelist.T_GamePlayers.Color := TAlphaColorRec.White;
  vMame.Scene.Gamelist.T_GamePlayers.Font.Family := 'Tahoma';
  vMame.Scene.Gamelist.T_GamePlayers.Font.Style := vMame.Scene.Gamelist.T_GamePlayers.Font.Style +
    [TFontStyle.fsBold];
  vMame.Scene.Gamelist.T_GamePlayers.Font.Size := 20;
  vMame.Scene.Gamelist.T_GamePlayers.TextSettings.HorzAlign := TTextAlign.Trailing;
  vMame.Scene.Gamelist.T_GamePlayers.Visible := True;

  vMame.Scene.Gamelist.T_GameCategory := TText.Create(vMame.Scene.Gamelist.Down_Back_Image);
  vMame.Scene.Gamelist.T_GameCategory.Name := 'Mame_Gamelist_GameCategory_Text';
  vMame.Scene.Gamelist.T_GameCategory.Parent := vMame.Scene.Gamelist.Down_Back_Image;
  vMame.Scene.Gamelist.T_GameCategory.SetBounds(0, 1, 750, 22);
  vMame.Scene.Gamelist.T_GameCategory.Color := TAlphaColorRec.White;
  vMame.Scene.Gamelist.T_GameCategory.Font.Family := 'Tahoma';
  vMame.Scene.Gamelist.T_GameCategory.Font.Style := vMame.Scene.Gamelist.T_GameCategory.Font.Style +
    [TFontStyle.fsBold];
  vMame.Scene.Gamelist.T_GameCategory.Font.Size := 20;
  vMame.Scene.Gamelist.T_GameCategory.TextSettings.HorzAlign := TTextAlign.Leading;
  vMame.Scene.Gamelist.T_GameCategory.Visible := True;

  vMame.Scene.Gamelist.Filters_Back_Image := TImage.Create(vMame.Scene.Left);
  vMame.Scene.Gamelist.Filters_Back_Image.Name := 'Mame_Gamelist_Filters_Back_Image';
  vMame.Scene.Gamelist.Filters_Back_Image.Parent := vMame.Scene.Left;
  vMame.Scene.Gamelist.Filters_Back_Image.SetBounds(50, 992, 750, 26);
  vMame.Scene.Gamelist.Filters_Back_Image.WrapMode := TImageWrapMode.Tile;
  vMame.Scene.Gamelist.Filters_Back_Image.Bitmap.LoadFromFile(mame.Prog.Images + 'black_menu.png');
  vMame.Scene.Gamelist.Filters_Back_Image.Visible := True;

  vMame.Scene.Gamelist.T_Filters := TText.Create(vMame.Scene.Gamelist.Filters_Back_Image);
  vMame.Scene.Gamelist.T_Filters.Name := 'Mame_Gamelist_Filters_Text';
  vMame.Scene.Gamelist.T_Filters.Parent := vMame.Scene.Gamelist.Filters_Back_Image;
  vMame.Scene.Gamelist.T_Filters.SetBounds(1, 1, 720, 22);
  vMame.Scene.Gamelist.T_Filters.Color := TAlphaColorRec.White;
  vFilter_Selected_Name := mame.Prog.Ini_Filters.ReadString('MASTER', 'Selected', vFilter_Selected_Name);
  vMame.Scene.Gamelist.T_Filters.Text := 'Filter : ' + vFilter_Selected_Name;
  vMame.Scene.Gamelist.T_Filters.Font.Family := 'Tahoma';
  vMame.Scene.Gamelist.T_Filters.Font.Style := vMame.Scene.Gamelist.T_MameVersion.Font.Style +
    [TFontStyle.fsBold];
  vMame.Scene.Gamelist.T_Filters.Font.Size := 20;
  vMame.Scene.Gamelist.T_Filters.TextSettings.HorzAlign := TTextAlign.Leading;
  vMame.Scene.Gamelist.T_Filters.Visible := True;

  uSnippet_Search.Create(vMame.Scene.Left, 50, 1026, 750, True);

  { vMame.Scene.Gamelist.Search_Back := TImage.Create(vMame.Scene.Left);
    vMame.Scene.Gamelist.Search_Back.Name := 'Mame_Gamelist_Search_Back';
    vMame.Scene.Gamelist.Search_Back.Parent := vMame.Scene.Left;
    vMame.Scene.Gamelist.Search_Back.SetBounds(50, 1026, 750, 26);
    vMame.Scene.Gamelist.Search_Back.WrapMode := TImageWrapMode.Tile;
    vMame.Scene.Gamelist.Search_Back.Bitmap.LoadFromFile(mame.Prog.Images + 'black_menu.png');
    vMame.Scene.Gamelist.Search_Back.Visible := True;

    vMame.Scene.Gamelist.Search := TImage.Create(vMame.Scene.Gamelist.Search_Back);
    vMame.Scene.Gamelist.Search.Name := 'Mame_Gamelist_Search_Image';
    vMame.Scene.Gamelist.Search.Parent := vMame.Scene.Gamelist.Search_Back;
    vMame.Scene.Gamelist.Search.SetBounds(1, 1, 24, 24);
    vMame.Scene.Gamelist.Search.WrapMode := TImageWrapMode.Fit;
    vMame.Scene.Gamelist.Search.Bitmap.LoadFromFile(mame.Prog.Images + 'search.png');
    vMame.Scene.Gamelist.Search.OnClick := mame.Input.Mouse.Image.OnMouseClick;
    vMame.Scene.Gamelist.Search.OnMouseEnter := mame.Input.Mouse.Image.OnMouseEnter;
    vMame.Scene.Gamelist.Search.OnMouseLeave := mame.Input.Mouse.Image.OnMouseLeave;
    vMame.Scene.Gamelist.Search.Visible := True;

    vMame.Scene.Gamelist.Search_Glow := TGlowEffect.Create(vMame.Scene.Gamelist.Search);
    vMame.Scene.Gamelist.Search_Glow.Name := 'Mame_Gamelist_Search_Glow';
    vMame.Scene.Gamelist.Search_Glow.Parent := vMame.Scene.Gamelist.Search;
    vMame.Scene.Gamelist.Search_Glow.Enabled := False;

    vMame.Scene.Gamelist.Search_Edit := TEdit.Create(vMame.Scene.Gamelist.Search_Back);
    vMame.Scene.Gamelist.Search_Edit.Name := 'Mame_Gamelist_Search_Edit';
    vMame.Scene.Gamelist.Search_Edit.Parent := vMame.Scene.Gamelist.Search_Back;
    vMame.Scene.Gamelist.Search_Edit.SetBounds(28, 1, 0, 24);
    vMame.Scene.Gamelist.Search_Edit.StyledSettings := vMame.Scene.Gamelist.Search_Edit.StyledSettings -
    [TStyledSetting.FontColor, TStyledSetting.Size];
    vMame.Scene.Gamelist.Search_Edit.Text:= '';
    vMame.Scene.Gamelist.Search_Edit.TextSettings.FontColor:= TAlphaColorRec.White;
    vMame.Scene.Gamelist.Search_Edit.TextSettings.Font.Size:= 16;
    vMame.Scene.Gamelist.Search_Edit.Visible := True;

    vMame.Scene.Gamelist.Search_Edit_Ani:= TFloatAnimation.Create(vMame.Scene.Gamelist.Search_Edit);
    vMame.Scene.Gamelist.Search_Edit_Ani.Name:= 'Mame_Gamelist_Search_Edit_Animation';
    vMame.Scene.Gamelist.Search_Edit_Ani.Parent:=  vMame.Scene.Gamelist.Search_Edit;
    vMame.Scene.Gamelist.Search_Edit_Ani.StartValue:= 0;
    vMame.Scene.Gamelist.Search_Edit_Ani.StopValue:=  vMame.Scene.Gamelist.Search_Back.Width - 38;
    vMame.Scene.Gamelist.Search_Edit_Ani.Duration:= 0.4;
    vMame.Scene.Gamelist.Search_Edit_Ani.PropertyName:= 'Width';
    vMame.Scene.Gamelist.Search_Edit_Ani.Enabled:= False; }

  vMame.Scene.Load_Game := TImage.Create(vMame.Scene.Main);
  vMame.Scene.Load_Game.Name := 'Mame_Loading_Game';
  vMame.Scene.Load_Game.Parent := vMame.Scene.Main;
  vMame.Scene.Load_Game.SetBounds(((vMame.Scene.Main.Width / 2) - 250), ((vMame.Scene.Main.Height / 2) - 150),
    500, 300);
  vMame.Scene.Load_Game.Bitmap.LoadFromFile(mame.Prog.Images + 'black_menu.png');
  vMame.Scene.Load_Game.WrapMode := TImageWrapMode.Tile;
  vMame.Scene.Load_Game.Visible := False;

  vMame.Scene.Load_Game_Line1 := TText.Create(vMame.Scene.Load_Game);
  vMame.Scene.Load_Game_Line1.Name := 'vMame_Loading_Game_Line1';
  vMame.Scene.Load_Game_Line1.Parent := vMame.Scene.Load_Game;
  vMame.Scene.Load_Game_Line1.SetBounds(20, 20, 480, 50);
  vMame.Scene.Load_Game_Line1.Text := 'Loading Game : ';
  vMame.Scene.Load_Game_Line1.Font.Family := 'Tahoma';
  vMame.Scene.Load_Game_Line1.Font.Size := 36;
  vMame.Scene.Load_Game_Line1.TextSettings.HorzAlign := TTextAlign.Center;
  vMame.Scene.Load_Game_Line1.Color := TAlphaColorRec.Deepskyblue;
  vMame.Scene.Load_Game_Line1.Font.Style := vMame.Scene.Load_Game_Line1.Font.Style + [TFontStyle.fsBold];
  vMame.Scene.Load_Game_Line1.Visible := True;

  vMame.Scene.Load_Game_Line2 := TText.Create(vMame.Scene.Load_Game);
  vMame.Scene.Load_Game_Line2.Name := 'Mame_Loading_Game_Line2';
  vMame.Scene.Load_Game_Line2.Parent := vMame.Scene.Load_Game;
  vMame.Scene.Load_Game_Line2.SetBounds(20, 90, 480, 50);
  vMame.Scene.Load_Game_Line2.Text := '';
  vMame.Scene.Load_Game_Line2.Font.Family := 'Tahoma';
  vMame.Scene.Load_Game_Line2.Font.Size := 36;
  vMame.Scene.Load_Game_Line2.TextSettings.HorzAlign := TTextAlign.Center;
  vMame.Scene.Load_Game_Line2.Color := TAlphaColorRec.White;
  vMame.Scene.Load_Game_Line2.Font.Style := vMame.Scene.Load_Game_Line2.Font.Style + [TFontStyle.fsBold];
  vMame.Scene.Load_Game_Line2.Visible := True;
end;

procedure Create_Video_Scene;
begin
  vMame.Scene.Snap.Black_Image := TImage.Create(vMame.Scene.Right);
  vMame.Scene.Snap.Black_Image.Name := 'Mame_Snap_Black_Image';
  vMame.Scene.Snap.Black_Image.Parent := vMame.Scene.Right;
  vMame.Scene.Snap.Black_Image.SetBounds(((vMame.Scene.Right.Width / 2) - 196), 278, 416, 226);
  vMame.Scene.Snap.Black_Image.WrapMode := TImageWrapMode.Tile;
  vMame.Scene.Snap.Black_Image.Bitmap.LoadFromFile(mame.Prog.Images + 'black.png');
  vMame.Scene.Snap.Black_Image.Visible := True;

  vMame.Scene.Snap.Black_Reflection := TReflectionEffect.Create(vMame.Scene.Snap.Black_Image);
  vMame.Scene.Snap.Black_Reflection.Name := 'Mame_Snap_Black_Reflaction';
  vMame.Scene.Snap.Black_Reflection.Parent := vMame.Scene.Snap.Black_Image;
  vMame.Scene.Snap.Black_Reflection.Offset := 380;
  vMame.Scene.Snap.Black_Reflection.Length := 0.3;
  vMame.Scene.Snap.Black_Reflection.Opacity := 0.3;
  vMame.Scene.Snap.Black_Reflection.Enabled := False;

{$IFDEF WIN32}
  libvlc_dynamic_dll_init_with_path('C:\Program Files (x86)\VideoLAN\VLC');
{$ENDIF}
  if (libvlc_dynamic_dll_error <> '') then
  begin
    ShowMessage(libvlc_dynamic_dll_error);
    exit;
  end;

  vMame.Scene.Snap.Video := TFmxPasLibVlcPlayer.Create(vMame.Scene.Snap.Black_Image);
  vMame.Scene.Snap.Video.Name := 'Mame_Snap_Video';
  vMame.Scene.Snap.Video.Parent := vMame.Scene.Snap.Black_Image;
  vMame.Scene.Snap.Video.Align := TAlignLayout.Client;
  vMame.Scene.Snap.Video.WrapMode:= TImageWrapMode.Stretch;

  vMame.Scene.Snap.Video_Reflaction := TReflectionEffect.Create(vMame.Scene.Snap.Video);
  vMame.Scene.Snap.Video_Reflaction.Name := 'Mame_Snap_Video_Reflaction';
  vMame.Scene.Snap.Video_Reflaction.Parent := vMame.Scene.Snap.Video;
  vMame.Scene.Snap.Video_Reflaction.Offset := 330;
  vMame.Scene.Snap.Video_Reflaction.Length := 0.3;
  vMame.Scene.Snap.Video_Reflaction.Opacity := 0.4;
  vMame.Scene.Snap.Video_Reflaction.Enabled := False;

  vMame.Scene.Snap.Type_Arcade := TImage.Create(vMame.Scene.Right);
  vMame.Scene.Snap.Type_Arcade.Name := 'Mame_Snap_Arcade_Image';
  vMame.Scene.Snap.Type_Arcade.Parent := vMame.Scene.Right;
  vMame.Scene.Snap.Type_Arcade.SetBounds(((vMame.Scene.Right.Width / 2) - 270), 148, 560, 560);
  vMame.Scene.Snap.Type_Arcade.WrapMode := TImageWrapMode.Fit;
  vMame.Scene.Snap.Type_Arcade.Bitmap.LoadFromFile(mame.Prog.Images + 'arcade.png');
  vMame.Scene.Snap.Type_Arcade.Visible := True;

  vMame.Scene.Snap.Type_Arcade_Reflection := TReflectionEffect.Create(vMame.Scene.Snap.Type_Arcade);
  vMame.Scene.Snap.Type_Arcade_Reflection.Name := 'Mame_Snap_TypeArcade_Reflaction';
  vMame.Scene.Snap.Type_Arcade_Reflection.Parent := vMame.Scene.Snap.Type_Arcade;
  vMame.Scene.Snap.Type_Arcade_Reflection.Offset := -30;
  vMame.Scene.Snap.Type_Arcade_Reflection.Enabled := True;
end;

procedure HideShow_Video_Scene(vShow: Boolean);
begin
  vMame.Scene.Snap.Black_Image.Visible := vShow;
  vMame.Scene.Snap.Black_Reflection.Enabled := vShow;
  vMame.Scene.Snap.Video_Reflaction.Enabled := vShow;
  vMame.Scene.Snap.Type_Arcade.Visible := vShow;
  vMame.Scene.Snap.Type_Arcade_Reflection.Enabled := vShow;
  vMame.Scene.Snap.Video.Visible := vShow;
  mame.Actions.Video_Scene_Show := vShow;
end;

procedure Create_Image_Scene;
begin
  vMame.Scene.Snap.Image := TImage.Create(vMame.Scene.Right);
  vMame.Scene.Snap.Image.Name := 'Mame_Snap_Snapshot_Image';
  vMame.Scene.Snap.Image.Parent := vMame.Scene.Right;
  vMame.Scene.Snap.Image.SetBounds(((vMame.Scene.Right.Width / 2) - 190), 282, 400, 220);
  vMame.Scene.Snap.Image.WrapMode := TImageWrapMode.Stretch;
  vMame.Scene.Snap.Image.Visible := True;

  vMame.Scene.Snap.Image_Reflaction := TReflectionEffect.Create(vMame.Scene.Snap.Image);
  vMame.Scene.Snap.Image_Reflaction.Name := 'Mame_Snap_Snapshot_Reflaction';
  vMame.Scene.Snap.Image_Reflaction.Parent := vMame.Scene.Snap.Image;
  vMame.Scene.Snap.Image_Reflaction.Offset := 380;
  vMame.Scene.Snap.Image_Reflaction.Length := 0.3;
  vMame.Scene.Snap.Image_Reflaction.Opacity := 0.4;
  vMame.Scene.Snap.Image_Reflaction.Enabled := False;
  vMame.Scene.Snap.Image_Reflaction.Offset := 12;

  vMame.Scene.Snap.Image_Fade := TFadeTransitionEffect.Create(vMame.Scene.Snap.Image);
  vMame.Scene.Snap.Image_Fade.Name := 'Mame_Snap_Snapshot_Image_Fade_Effect';
  vMame.Scene.Snap.Image_Fade.Parent := vMame.Scene.Snap.Image;

  vMame.Scene.Snap.Image_Fade_Ani := TFloatAnimation.Create(vMame.Scene.Snap.Image_Fade);
  vMame.Scene.Snap.Image_Fade_Ani.Name := 'Mame_Snap_Snapshot_Image_Fade_Effect_Animation';
  vMame.Scene.Snap.Image_Fade_Ani.Parent := vMame.Scene.Snap.Image_Fade;
  vMame.Scene.Snap.Image_Fade_Ani.PropertyName := 'Progress';
  vMame.Scene.Snap.Image_Fade_Ani.Duration := 1;
  vMame.Scene.Snap.Image_Fade_Ani.StartValue := 0;
  vMame.Scene.Snap.Image_Fade_Ani.StopValue := 100;
  vMame.Scene.Snap.Image_Fade_Ani.Loop := False;
  vMame.Scene.Snap.Image_Fade_Ani.OnFinish := mame.Ani.Gamelist.OnFinish;
  vMame.Scene.Snap.Image_Fade_Ani.Enabled := False;
end;

procedure HideShow_Image_Scene(vShow: Boolean);
begin
  vMame.Scene.Snap.Image.Visible:= vShow;
  vMame.Scene.Snap.Image_Reflaction.Enabled:= vShow;
  vMame.Scene.Snap.Image_Fade.Enabled:= vShow;
  vMame.Scene.Snap.Image_Fade_Ani.Enabled:= vShow;
end;

end.
