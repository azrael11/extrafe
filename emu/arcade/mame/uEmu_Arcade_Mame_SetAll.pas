unit uEmu_Arcade_Mame_SetAll;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UITypes,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Types,
  FMX.Effects,
  FMX.Layouts,
  FMX.Ani,
  FMX.Filter.Effects,
  FmxPasLibVlcPlayerUnit,
  PasLibVlcUnit,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.FMXUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Phys.IB,
  FireDAC.Phys.IBLiteDef,
  FireDAC.Stan.StorageJSON,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.UI,
  ZAbstractRODataset,
  ZAbstractDataset,
  ZDataset,
  ZAbstractConnection,
  ZConnection,
  FMX.Controls,
  Mitov.FMXTypes,
  FMX.LPControl,
  FMX.SLControlCollection,
  FMX.VLCommonDisplay,
  FMX.VLImageDisplay,
  Mitov.Types,
  VLBasicVideoPlayer,
  VLLAVVideoPlayer;

procedure Load;

procedure Create_Configuration;

procedure Create_GameList;

procedure Create_Media(vView_Mode: String);
procedure Create_Mode_Video;

procedure Create_Video_Scene;
procedure HideShow_Video_Scene(vShow: Boolean);
procedure Free_Video_Scene;
procedure Create_Image_Scene;
procedure Show_Image_Scene(vShow: Boolean);

procedure Players;

procedure Get_Set_Mame_Data;
procedure Set_Mame_Data;

implementation

uses
  uDB,
  uDB_AUser,
  uLoad_AllTypes,
  emu,
  uSnippet_Search,
  uEmu_Arcade_Mame,
  uEmu_Arcade_Mame_AllTypes,
  uEmu_Arcade_Mame_Ini,
  uView_Mode_Default;

procedure Create_Configuration;
begin
  vMame.Config.Scene.Main := TPanel.Create(vMame.Scene.Main);
  vMame.Config.Scene.Main.Name := 'Mame_Config';
  vMame.Config.Scene.Main.Parent := vMame.Scene.Main;
  vMame.Config.Scene.Main.SetBounds(((vMame.Scene.Main.Width / 2) - 350), ((vMame.Scene.Main.Height / 2) - 300), 700, 630);
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

  vMame.Scene.Right := TImage.Create(vMame.Scene.Main);
  vMame.Scene.Right.Name := 'Mame_Right';
  vMame.Scene.Right.Parent := vMame.Scene.Main;
  vMame.Scene.Right.SetBounds((vMame.Scene.Main.Width / 2), 0, (vMame.Scene.Main.Width / 2), (vMame.Scene.Main.Height));
  vMame.Scene.Right.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'background.png');
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
  vMame.Scene.Left.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'background.png');
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
end;

procedure Create_GameList;
var
  vi: integer;
  viPos: integer;
begin
  vMame.Scene.Gamelist.List := TImage.Create(vMame.Scene.Left);
  vMame.Scene.Gamelist.List.Name := 'Mame_Gamelist_Image';
  vMame.Scene.Gamelist.List.Parent := vMame.Scene.Left;
  vMame.Scene.Gamelist.List.SetBounds(50, 50, 750, (vMame.Scene.Left.Height - 180));
  vMame.Scene.Gamelist.List.WrapMode := TImageWrapMode.Tile;
  vMame.Scene.Gamelist.List.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'black_menu.png');
  vMame.Scene.Gamelist.List.Visible := True;

  vMame.Scene.Gamelist.Up_Back_Image := TImage.Create(vMame.Scene.Left);
  vMame.Scene.Gamelist.Up_Back_Image.Name := 'Mame_Gamelist_Up_Back_Image';
  vMame.Scene.Gamelist.Up_Back_Image.Parent := vMame.Scene.Left;
  vMame.Scene.Gamelist.Up_Back_Image.SetBounds(50, 18, 750, 26);
  vMame.Scene.Gamelist.Up_Back_Image.WrapMode := TImageWrapMode.Tile;
  vMame.Scene.Gamelist.Up_Back_Image.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'black_menu.png');
  vMame.Scene.Gamelist.Up_Back_Image.Visible := True;

  vMame.Scene.Gamelist.T_Games_Count_Info := TText.Create(vMame.Scene.Gamelist.Up_Back_Image);
  vMame.Scene.Gamelist.T_Games_Count_Info.Name := 'Mame_Gamelist_GameInfoShow_Text';
  vMame.Scene.Gamelist.T_Games_Count_Info.Parent := vMame.Scene.Gamelist.Up_Back_Image;
  vMame.Scene.Gamelist.T_Games_Count_Info.SetBounds(0, 1, 750, 22);
  vMame.Scene.Gamelist.T_Games_Count_Info.Text := '';
  vMame.Scene.Gamelist.T_Games_Count_Info.Color := TAlphaColorRec.White;
  vMame.Scene.Gamelist.T_Games_Count_Info.Font.Family := 'Tahoma';
  vMame.Scene.Gamelist.T_Games_Count_Info.Font.Style := vMame.Scene.Gamelist.T_Games_Count_Info.Font.Style + [TFontStyle.fsBold];
  vMame.Scene.Gamelist.T_Games_Count_Info.Font.Size := 20;
  vMame.Scene.Gamelist.T_Games_Count_Info.TextSettings.HorzAlign := TTextAlign.Trailing;
  vMame.Scene.Gamelist.T_Games_Count_Info.Visible := True;

  vMame.Scene.Gamelist.T_MameVersion := TText.Create(vMame.Scene.Gamelist.Up_Back_Image);
  vMame.Scene.Gamelist.T_MameVersion.Name := 'Mame_Gamelist_MameVersion_Text';
  vMame.Scene.Gamelist.T_MameVersion.Parent := vMame.Scene.Gamelist.Up_Back_Image;
  vMame.Scene.Gamelist.T_MameVersion.SetBounds(0, 1, 750, 22);
  vMame.Scene.Gamelist.T_MameVersion.Color := TAlphaColorRec.White;
  vMame.Scene.Gamelist.T_MameVersion.Text := uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Version;
  vMame.Scene.Gamelist.T_MameVersion.Font.Family := 'Tahoma';
  vMame.Scene.Gamelist.T_MameVersion.Font.Style := vMame.Scene.Gamelist.T_MameVersion.Font.Style + [TFontStyle.fsBold];
  vMame.Scene.Gamelist.T_MameVersion.Font.Size := 20;
  vMame.Scene.Gamelist.T_MameVersion.TextSettings.HorzAlign := TTextAlign.Leading;
  vMame.Scene.Gamelist.T_MameVersion.Visible := True;

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
    vMame.Scene.Gamelist.List_Line[vi].Back.SetBounds(0, ((vi * 40) + (vi + 10)), (vMame.Scene.Gamelist.Listbox.Width - 10), 40);
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
    vMame.Scene.Gamelist.List_Line[vi].Text.Font.Style := vMame.Scene.Gamelist.List_Line[vi].Text.Font.Style + [TFontStyle.fsBold];
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

  vMame.Scene.Gamelist.List_Line[10].Back.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'selection.png');

  vMame.Scene.Gamelist.List_Blur := TBlurEffect.Create(vMame.Scene.Gamelist.Listbox);
  vMame.Scene.Gamelist.List_Blur.Name := 'Mame_Gamelist_ListBox_Blur';
  vMame.Scene.Gamelist.List_Blur.Parent := vMame.Scene.Gamelist.Listbox;
  vMame.Scene.Gamelist.List_Blur.Softness := 0.9;
  vMame.Scene.Gamelist.List_Blur.Enabled := False;

  vMame.Scene.Gamelist.Down_Back_Image := TImage.Create(vMame.Scene.Left);
  vMame.Scene.Gamelist.Down_Back_Image.Name := 'Mame_Gamelist_Down_Back_Image';
  vMame.Scene.Gamelist.Down_Back_Image.Parent := vMame.Scene.Left;
  vMame.Scene.Gamelist.Down_Back_Image.SetBounds(50, 958, 750, 26);
  vMame.Scene.Gamelist.Down_Back_Image.WrapMode := TImageWrapMode.Tile;
  vMame.Scene.Gamelist.Down_Back_Image.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'black_menu.png');
  vMame.Scene.Gamelist.Down_Back_Image.Visible := True;

  vMame.Scene.Gamelist.T_Lists := TText.Create(vMame.Scene.Gamelist.Down_Back_Image);
  vMame.Scene.Gamelist.T_Lists.Name := 'Mame_Gamelist_Lists';
  vMame.Scene.Gamelist.T_Lists.Parent := vMame.Scene.Gamelist.Down_Back_Image;
  vMame.Scene.Gamelist.T_Lists.SetBounds(2, 1, 24, 24);
  vMame.Scene.Gamelist.T_Lists.Font.Family := 'IcoMoon-Free';
  vMame.Scene.Gamelist.T_Lists.Font.Size := 22;
  vMame.Scene.Gamelist.T_Lists.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vMame.Scene.Gamelist.T_Lists.Text := #$e904;
  vMame.Scene.Gamelist.T_Lists.OnClick := mame.Input.Mouse.Text.OnMouseClick;
  vMame.Scene.Gamelist.T_Lists.OnMouseEnter := mame.Input.Mouse.Text.OnMouseEnter;
  vMame.Scene.Gamelist.T_Lists.OnMouseLeave := mame.Input.Mouse.Text.OnMouseLeave;
  vMame.Scene.Gamelist.T_Lists.Visible := True;

  vMame.Scene.Gamelist.T_Lists_Glow := TGlowEffect.Create(vMame.Scene.Gamelist.T_Lists);
  vMame.Scene.Gamelist.T_Lists_Glow.Name := 'Mame_Gamelist_Lists_Glow';
  vMame.Scene.Gamelist.T_Lists_Glow.Parent := vMame.Scene.Gamelist.T_Lists;
  vMame.Scene.Gamelist.T_Lists_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vMame.Scene.Gamelist.T_Lists_Glow.Softness := 0.9;
  vMame.Scene.Gamelist.T_Lists_Glow.Enabled := False;

  vMame.Scene.Gamelist.T_Lists_Text := TText.Create(vMame.Scene.Gamelist.Down_Back_Image);
  vMame.Scene.Gamelist.T_Lists_Text.Name := 'Mame_Gamelist_Lists_Text';
  vMame.Scene.Gamelist.T_Lists_Text.Parent := vMame.Scene.Gamelist.Down_Back_Image;
  vMame.Scene.Gamelist.T_Lists_Text.SetBounds(40, 1, 710, 22);
  vMame.Scene.Gamelist.T_Lists_Text.Color := TAlphaColorRec.White;
  vMame.Scene.Gamelist.T_Lists_Text.Font.Family := 'Tahoma';
  vMame.Scene.Gamelist.T_Lists_Text.Font.Size := 20;
  vMame.Scene.Gamelist.T_Lists_Text.TextSettings.HorzAlign := TTextAlign.Leading;
  vMame.Scene.Gamelist.T_Lists_Text.Visible := True;

  vMame.Scene.Gamelist.Filters.Back := TImage.Create(vMame.Scene.Left);
  vMame.Scene.Gamelist.Filters.Back.Name := 'Mame_Gamelist_Filters_Back_Image';
  vMame.Scene.Gamelist.Filters.Back.Parent := vMame.Scene.Left;
  vMame.Scene.Gamelist.Filters.Back.SetBounds(50, 992, 750, 26);
  vMame.Scene.Gamelist.Filters.Back.WrapMode := TImageWrapMode.Tile;
  vMame.Scene.Gamelist.Filters.Back.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'black_menu.png');
  vMame.Scene.Gamelist.Filters.Back.Visible := True;

  vMame.Scene.Gamelist.Filters.Icon := TText.Create(vMame.Scene.Gamelist.Filters.Back);
  vMame.Scene.Gamelist.Filters.Icon.Name := 'Mame_Gamelist_Filters_Image';
  vMame.Scene.Gamelist.Filters.Icon.Parent := vMame.Scene.Gamelist.Filters.Back;
  vMame.Scene.Gamelist.Filters.Icon.SetBounds(2, 1, 24, 24);
  vMame.Scene.Gamelist.Filters.Icon.Font.Family := 'IcoMoon-Free';
  vMame.Scene.Gamelist.Filters.Icon.Font.Size := 22;
  vMame.Scene.Gamelist.Filters.Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vMame.Scene.Gamelist.Filters.Icon.Text := #$ea5b;
  vMame.Scene.Gamelist.Filters.Icon.OnClick := mame.Input.Mouse.Text.OnMouseClick;
  vMame.Scene.Gamelist.Filters.Icon.OnMouseEnter := mame.Input.Mouse.Text.OnMouseEnter;
  vMame.Scene.Gamelist.Filters.Icon.OnMouseLeave := mame.Input.Mouse.Text.OnMouseLeave;
  vMame.Scene.Gamelist.Filters.Icon.Visible := True;

  vMame.Scene.Gamelist.Filters.Icon_Glow := TGlowEffect.Create(vMame.Scene.Gamelist.Filters.Icon);
  vMame.Scene.Gamelist.Filters.Icon_Glow.Name := 'Mame_Gamelist_Filters_Glow';
  vMame.Scene.Gamelist.Filters.Icon_Glow.Parent := vMame.Scene.Gamelist.Filters.Icon;
  vMame.Scene.Gamelist.Filters.Icon_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vMame.Scene.Gamelist.Filters.Icon_Glow.Softness := 0.9;
  vMame.Scene.Gamelist.Filters.Icon_Glow.Enabled := False;

  vMame.Scene.Gamelist.Filters.Text := TText.Create(vMame.Scene.Gamelist.Filters.Back);
  vMame.Scene.Gamelist.Filters.Text.Name := 'Mame_Gamelist_Filters_Text';
  vMame.Scene.Gamelist.Filters.Text.Parent := vMame.Scene.Gamelist.Filters.Back;
  vMame.Scene.Gamelist.Filters.Text.SetBounds(40, 1, 710, 22);
  vMame.Scene.Gamelist.Filters.Text.Color := TAlphaColorRec.White;
  vMame.Scene.Gamelist.Filters.Text.Font.Size := 20;
  vMame.Scene.Gamelist.Filters.Text.Text := 'All';
  vMame.Scene.Gamelist.Filters.Text.TextSettings.HorzAlign := TTextAlign.Leading;
  vMame.Scene.Gamelist.Filters.Text.Visible := True;

end;

procedure Create_Video_Scene;
begin
  vMame.Scene.Media.Black_Image := TImage.Create(vMame.Scene.Right);
  vMame.Scene.Media.Black_Image.Name := 'Mame_Snap_Black_Image';
  vMame.Scene.Media.Black_Image.Parent := vMame.Scene.Right;
  vMame.Scene.Media.Black_Image.SetBounds(100, 150, 650, 600);
  vMame.Scene.Media.Black_Image.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'black.png');
  vMame.Scene.Media.Black_Image.Visible := True;

  { vMame.Scene.Media.Black_Image := TImage.Create(vMame.Scene.Right);
    vMame.Scene.Media.Black_Image.Name := 'Mame_Snap_Black_Image';
    vMame.Scene.Media.Black_Image.Parent := vMame.Scene.Right;
    vMame.Scene.Media.Black_Image.SetBounds(((vMame.Scene.Right.Width / 2) - 196), 278, 416, 226);
    vMame.Scene.Media.Black_Image.WrapMode := TImageWrapMode.Tile;
    vMame.Scene.Media.Black_Image.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'black.png');
    vMame.Scene.Media.Black_Image.Visible := True;

    vMame.Scene.Media.Black_Reflection := TReflectionEffect.Create(vMame.Scene.Media.Black_Image);
    vMame.Scene.Media.Black_Reflection.Name := 'Mame_Snap_Black_Reflaction';
    vMame.Scene.Media.Black_Reflection.Parent := vMame.Scene.Media.Black_Image;
    vMame.Scene.Media.Black_Reflection.Offset := 380;
    vMame.Scene.Media.Black_Reflection.Length := 0.3;
    vMame.Scene.Media.Black_Reflection.Opacity := 0.3;
    vMame.Scene.Media.Black_Reflection.Enabled := False; }

{$IFDEF WIN32}
  libvlc_dynamic_dll_init_with_path('C:\Program Files (x86)\VideoLAN\VLC');
{$ENDIF}
  if (libvlc_dynamic_dll_error <> '') then
  begin
    ShowMessage(libvlc_dynamic_dll_error);
    exit;
  end;

  vMame.Scene.Media.Video := TFmxPasLibVlcPlayer.Create(vMame.Scene.Media.Black_Image);
  vMame.Scene.Media.Video.Name := 'Mame_Snap_Video';
  vMame.Scene.Media.Video.Parent := vMame.Scene.Media.Black_Image;
  vMame.Scene.Media.Video.Align := TAlignLayout.Client;
  vMame.Scene.Media.Video.SetVideoAspectRatio('4:3');
  vMame.Scene.Media.Video.WrapMode := TImageWrapMode.Stretch;
  vMame.Scene.Media.Video.Visible := True;

  { Extremly bugie for my program maybe in the future

    vMame.Scene.Media.Video_Display := TVLImageDisplay.Create(vMame.Scene.Media.Black_Image);
    vMame.Scene.Media.Video_Display.Name := 'Mame_Video';
    vMame.Scene.Media.Video_Display.Parent:=  vMame.Scene.Media.Black_Image;
    vMame.Scene.Media.Video_Display.Align := TAlignLayout.Client;
    vMame.Scene.Media.Video_Display.Visible := True;

    vMame.Scene.Media.Video_1 := TVLLAVVideoPlayer.Create(vMame.Scene.Media.Black_Image);
    vMame.Scene.Media.Video_1.FileName := '';

    vMame.Scene.Media.Video_Display.InputPin.SourcePin := vMame.Scene.Media.Video_1.OutputPin; }

  vMame.Scene.Media.Video_Timer_Cont := TTimer.Create(vMame.Scene.Main);
  vMame.Scene.Media.Video_Timer_Cont.Interval := 100;
  vMame.Scene.Media.Video_Timer_Cont.OnTimer := mame.Timers.Video_Cont.OnTimer;
  vMame.Scene.Media.Video_Timer_Cont.Enabled := False;

  { vMame.Scene.Media.Video_Reflaction := TReflectionEffect.Create(vMame.Scene.Media.Video);
    vMame.Scene.Media.Video_Reflaction.Name := 'Mame_Snap_Video_Reflaction';
    vMame.Scene.Media.Video_Reflaction.Parent := vMame.Scene.Media.Video;
    vMame.Scene.Media.Video_Reflaction.Offset := 330;
    vMame.Scene.Media.Video_Reflaction.Length := 0.3;
    vMame.Scene.Media.Video_Reflaction.Opacity := 0.4;
    vMame.Scene.Media.Video_Reflaction.Enabled := False;

    vMame.Scene.Media.Type_Arcade := TImage.Create(vMame.Scene.Right);
    vMame.Scene.Media.Type_Arcade.Name := 'Mame_Snap_Arcade_Image';
    vMame.Scene.Media.Type_Arcade.Parent := vMame.Scene.Right;
    vMame.Scene.Media.Type_Arcade.SetBounds(((vMame.Scene.Right.Width / 2) - 270), 148, 560, 560);
    vMame.Scene.Media.Type_Arcade.WrapMode := TImageWrapMode.Fit;
    vMame.Scene.Media.Type_Arcade.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'arcade.png');
    vMame.Scene.Media.Type_Arcade.Visible := True;

    vMame.Scene.Media.Type_Arcade_Reflection := TReflectionEffect.Create(vMame.Scene.Media.Type_Arcade);
    vMame.Scene.Media.Type_Arcade_Reflection.Name := 'Mame_Snap_TypeArcade_Reflaction';
    vMame.Scene.Media.Type_Arcade_Reflection.Parent := vMame.Scene.Media.Type_Arcade;
    vMame.Scene.Media.Type_Arcade_Reflection.Offset := -30;
    vMame.Scene.Media.Type_Arcade_Reflection.Enabled := True; }
end;

procedure HideShow_Video_Scene(vShow: Boolean);
begin
  // vMame.Scene.Media.Black_Image.Visible := vShow;
  // vMame.Scene.Media.Black_Reflection.Enabled := vShow;
  // vMame.Scene.Media.Video_Reflaction.Enabled := vShow;
  // vMame.Scene.Media.Type_Arcade.Visible := vShow;
  // vMame.Scene.Media.Type_Arcade_Reflection.Enabled := vShow;
  // vMame.Scene.Media.Video.Visible := vShow;
  // mame.Actions.Video_Scene_Show := vShow;
end;

procedure Free_Video_Scene;
begin
  FreeAndNil(vMame.Scene.Media.Video);
end;

procedure Create_Image_Scene;
begin
  vMame.Scene.Media.T_Image.Image := TImage.Create(vMame.Scene.Media.Back);
  vMame.Scene.Media.T_Image.Image.Name := 'Mame_Snap_Snapshot_Image';
  vMame.Scene.Media.T_Image.Image.Parent := vMame.Scene.Media.Back;
  vMame.Scene.Media.T_Image.Image.SetBounds(50, 100, 650, 600);
  vMame.Scene.Media.T_Image.Image.WrapMode := TImageWrapMode.Stretch;
  vMame.Scene.Media.T_Image.Image.Visible := True;

  vMame.Scene.Media.T_Image.Image_X_Ani := TFloatAnimation.Create(vMame.Scene.Media.T_Image.Image);
  vMame.Scene.Media.T_Image.Image_X_Ani.Name := 'Mame_Snap_Snapshot_Image__Animation';
  vMame.Scene.Media.T_Image.Image_X_Ani.Parent := vMame.Scene.Media.T_Image.Image;
  vMame.Scene.Media.T_Image.Image_X_Ani.PropertyName := 'Position.X';
  vMame.Scene.Media.T_Image.Image_X_Ani.Duration := 0.5;
  vMame.Scene.Media.T_Image.Image_X_Ani.Loop := False;
  vMame.Scene.Media.T_Image.Image_X_Ani.OnFinish := mame.Ani.Gamelist.OnFinish;
  vMame.Scene.Media.T_Image.Image_X_Ani.Enabled := False;

  vMame.Scene.Media.T_Image.Image_Y_Ani := TFloatAnimation.Create(vMame.Scene.Media.T_Image.Image);
  vMame.Scene.Media.T_Image.Image_Y_Ani.Name := 'Mame_Snap_Snapshot_Image_Y_Animation';
  vMame.Scene.Media.T_Image.Image_Y_Ani.Parent := vMame.Scene.Media.T_Image.Image;
  vMame.Scene.Media.T_Image.Image_Y_Ani.PropertyName := 'Position.Y';
  vMame.Scene.Media.T_Image.Image_Y_Ani.Duration := 0.5;
  vMame.Scene.Media.T_Image.Image_Y_Ani.Loop := False;
  vMame.Scene.Media.T_Image.Image_Y_Ani.OnFinish := mame.Ani.Gamelist.OnFinish;
  vMame.Scene.Media.T_Image.Image_Y_Ani.Enabled := False;

  vMame.Scene.Media.T_Image.Image_Width_Ani := TFloatAnimation.Create(vMame.Scene.Media.T_Image.Image);
  vMame.Scene.Media.T_Image.Image_Width_Ani.Name := 'Mame_Snap_Snapshot_Image_Width_Animation';
  vMame.Scene.Media.T_Image.Image_Width_Ani.Parent := vMame.Scene.Media.T_Image.Image;
  vMame.Scene.Media.T_Image.Image_Width_Ani.PropertyName := 'Width';
  vMame.Scene.Media.T_Image.Image_Width_Ani.Duration := 0.5;
  vMame.Scene.Media.T_Image.Image_Width_Ani.Loop := False;
  vMame.Scene.Media.T_Image.Image_Width_Ani.OnFinish := mame.Ani.Gamelist.OnFinish;
  vMame.Scene.Media.T_Image.Image_Width_Ani.Enabled := False;

  vMame.Scene.Media.T_Image.Image_Height_Ani := TFloatAnimation.Create(vMame.Scene.Media.T_Image.Image);
  vMame.Scene.Media.T_Image.Image_Height_Ani.Name := 'Mame_Snap_Snapshot_Image_Height_Animation';
  vMame.Scene.Media.T_Image.Image_Height_Ani.Parent := vMame.Scene.Media.T_Image.Image_Fade;
  vMame.Scene.Media.T_Image.Image_Height_Ani.PropertyName := 'Height';
  vMame.Scene.Media.T_Image.Image_Height_Ani.Duration := 0.5;
  vMame.Scene.Media.T_Image.Image_Height_Ani.Loop := False;
  vMame.Scene.Media.T_Image.Image_Height_Ani.OnFinish := mame.Ani.Gamelist.OnFinish;
  vMame.Scene.Media.T_Image.Image_Height_Ani.Enabled := False;

  vMame.Scene.Media.T_Image.Image_Fade := TFadeTransitionEffect.Create(vMame.Scene.Media.T_Image.Image);
  vMame.Scene.Media.T_Image.Image_Fade.Name := 'Mame_Snap_Snapshot_Image_Fade_Effect';
  vMame.Scene.Media.T_Image.Image_Fade.Parent := vMame.Scene.Media.T_Image.Image;

  vMame.Scene.Media.T_Image.Image_Fade_Ani := TFloatAnimation.Create(vMame.Scene.Media.T_Image.Image_Fade);
  vMame.Scene.Media.T_Image.Image_Fade_Ani.Name := 'Mame_Snap_Snapshot_Image_Fade_Effect_Animation';
  vMame.Scene.Media.T_Image.Image_Fade_Ani.Parent := vMame.Scene.Media.T_Image.Image_Fade;
  vMame.Scene.Media.T_Image.Image_Fade_Ani.PropertyName := 'Progress';
  vMame.Scene.Media.T_Image.Image_Fade_Ani.Duration := 0.5;
  vMame.Scene.Media.T_Image.Image_Fade_Ani.StartValue := 0;
  vMame.Scene.Media.T_Image.Image_Fade_Ani.StopValue := 100;
  vMame.Scene.Media.T_Image.Image_Fade_Ani.Loop := False;
  vMame.Scene.Media.T_Image.Image_Fade_Ani.OnFinish := mame.Ani.Gamelist.OnFinish;
  vMame.Scene.Media.T_Image.Image_Fade_Ani.Enabled := False;
end;

procedure Show_Image_Scene(vShow: Boolean);
begin
  vMame.Scene.Media.T_Image.Image.Visible := vShow;
  vMame.Scene.Media.T_Image.Image_Fade.Enabled := vShow;
  vMame.Scene.Media.T_Image.Image_Fade_Ani.Enabled := vShow;
end;

procedure Create_Mode_Video;
begin
  vMame.Scene.Media.Back := TImage.Create(vMame.Scene.Right);
  vMame.Scene.Media.Back.Name := 'Mame_Media_Back';
  vMame.Scene.Media.Back.Parent := vMame.Scene.Right;
  vMame.Scene.Media.Back.SetBounds(50, 50, 750, (vMame.Scene.Right.Height - 180));
  vMame.Scene.Media.Back.WrapMode := TImageWrapMode.Tile;
  vMame.Scene.Media.Back.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'black_menu.png');
  vMame.Scene.Media.Back.Visible := True;

  vMame.Scene.Media.Up_Back_Image := TImage.Create(vMame.Scene.Right);
  vMame.Scene.Media.Up_Back_Image.Name := 'Mame_Media_Up_Back_Image';
  vMame.Scene.Media.Up_Back_Image.Parent := vMame.Scene.Right;
  vMame.Scene.Media.Up_Back_Image.SetBounds(50, 18, 750, 26);
  vMame.Scene.Media.Up_Back_Image.WrapMode := TImageWrapMode.Tile;
  vMame.Scene.Media.Up_Back_Image.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'black_menu.png');
  vMame.Scene.Media.Up_Back_Image.Visible := True;

  vMame.Scene.Media.Up_Favorites := TText.Create(vMame.Scene.Media.Up_Back_Image);
  vMame.Scene.Media.Up_Favorites.Name := 'Mame_Media_Up_Favorites';
  vMame.Scene.Media.Up_Favorites.Parent := vMame.Scene.Media.Up_Back_Image;
  vMame.Scene.Media.Up_Favorites.SetBounds(2, 1, 24, 24);
  vMame.Scene.Media.Up_Favorites.Font.Family := 'IcoMoon-Free';
  vMame.Scene.Media.Up_Favorites.Font.Size := 22;
  vMame.Scene.Media.Up_Favorites.TextSettings.FontColor := TAlphaColorRec.Grey;
  vMame.Scene.Media.Up_Favorites.Text := #$e9d9;
  vMame.Scene.Media.Up_Favorites.OnClick := mame.Input.Mouse.Text.OnMouseClick;
  vMame.Scene.Media.Up_Favorites.OnMouseEnter := mame.Input.Mouse.Text.OnMouseEnter;
  vMame.Scene.Media.Up_Favorites.OnMouseLeave := mame.Input.Mouse.Text.OnMouseLeave;
  vMame.Scene.Media.Up_Favorites.Visible := True;

  vMame.Scene.Media.Up_Favorites_Glow := TGlowEffect.Create(vMame.Scene.Media.Up_Favorites);
  vMame.Scene.Media.Up_Favorites_Glow.Name := 'Mame_Media_Up_Favorites_Glow';
  vMame.Scene.Media.Up_Favorites_Glow.Parent := vMame.Scene.Media.Up_Favorites;
  vMame.Scene.Media.Up_Favorites_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vMame.Scene.Media.Up_Favorites_Glow.Softness := 0.9;
  vMame.Scene.Media.Up_Favorites_Glow.Enabled := False;

  mame.Favorites.Count := uDB.Query_Count(Arcade_Query, 'mame_status', 'fav_id_' + uDB_AUser.Local.USER.Num.ToString, '1');
  mame.Favorites.Open := False;

  vMame.Scene.Media.Black_Image := TImage.Create(vMame.Scene.Right);
  vMame.Scene.Media.Black_Image.Name := 'Mame_Snap_Black_Image';
  vMame.Scene.Media.Black_Image.Parent := vMame.Scene.Right;
  vMame.Scene.Media.Black_Image.SetBounds(100, 150, 650, 600);
  vMame.Scene.Media.Black_Image.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'black.png');
  vMame.Scene.Media.Black_Image.Visible := True;

{$IFDEF WIN32}
  libvlc_dynamic_dll_init_with_path('C:\Program Files (x86)\VideoLAN\VLC');
{$ENDIF}
  if (libvlc_dynamic_dll_error <> '') then
  begin
    ShowMessage(libvlc_dynamic_dll_error);
    exit;
  end;

  vMame.Scene.Media.Video := TFmxPasLibVlcPlayer.Create(vMame.Scene.Media.Black_Image);
  vMame.Scene.Media.Video.Name := 'Mame_Snap_Video';
  vMame.Scene.Media.Video.Parent := vMame.Scene.Media.Black_Image;
  vMame.Scene.Media.Video.Align := TAlignLayout.Client;
  vMame.Scene.Media.Video.SetVideoAspectRatio('4:3');
  vMame.Scene.Media.Video.WrapMode := TImageWrapMode.Stretch;
  vMame.Scene.Media.Video.Visible := True;

  vMame.Scene.Media.Video_Timer_Cont := TTimer.Create(vMame.Scene.Main);
  vMame.Scene.Media.Video_Timer_Cont.Interval := 100;
  vMame.Scene.Media.Video_Timer_Cont.OnTimer := mame.Timers.Video_Cont.OnTimer;
  vMame.Scene.Media.Video_Timer_Cont.Enabled := False;
end;

procedure Create_Media(vView_Mode: String);
begin
  if vView_Mode = 'video' then
    Create_Mode_Video;

  Players;
  // Create_Video_Scene;
  // HideShow_Video_Scene(False);
  Create_Image_Scene;
  // Show_Image_Scene(False);
end;

procedure Load;
begin
  vMame.Scene.Main := TImage.Create(Emu_Form);
  vMame.Scene.Main.Name := 'Mame_Main';
  vMame.Scene.Main.Parent := Emu_Form;
  vMame.Scene.Main.SetBounds(0, 0, Emu_Form.Width, Emu_Form.Height);
//  vMame.Scene.Main.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'config.jpg');
  vMame.Scene.Main.WrapMode := TImageWrapMode.Stretch;
  vMame.Scene.Main.Visible := True;

  if uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.View_Mode = 'video' then
    uView_Mode_Default.Create_Scene(uDB_AUser.Local.USER.Num, uDB.Arcade_Query, vMame.Scene.Main, uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Views,
      uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images, uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Sounds);

  { vMame.Scene.Main_Blur := TGaussianBlurEffect.Create(vMame.Scene.Main);
    vMame.Scene.Main_Blur.Name := 'Mame_Main_Blur';
    vMame.Scene.Main_Blur.Parent := vMame.Scene.Main;
    vMame.Scene.Main_Blur.BlurAmount := 0;
    vMame.Scene.Main_Blur.Enabled := False;

    Create_Configuration;

    // Create actions
    vMame.Scene.Exit_Mame := TImage.Create(vMame.Scene.Right);
    vMame.Scene.Exit_Mame.Name := 'Mame_Exit';
    vMame.Scene.Exit_Mame.Parent := vMame.Scene.Right;
    vMame.Scene.Exit_Mame.SetBounds((vMame.Scene.Right.Width - 29), 5, 24, 24);
    vMame.Scene.Exit_Mame.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'exit_mame.png');
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

    vMame.Scene.Settings := TText.Create(vMame.Scene.Main);
    vMame.Scene.Settings.Name := 'Mame_Settings';
    vMame.Scene.Settings.Parent := vMame.Scene.Main;
    vMame.Scene.Settings.SetBounds(((vMame.Scene.Main.Width / 2) - 25), (vMame.Scene.Main.Height - 60), 48, 48);
    vMame.Scene.Settings.Font.Family := 'IcoMoon-Free';
    vMame.Scene.Settings.Font.Size := 48;
    vMame.Scene.Settings.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vMame.Scene.Settings.Text := #$e994;
    vMame.Scene.Settings.OnClick := mame.Input.Mouse.Text.OnMouseClick;
    vMame.Scene.Settings.OnMouseEnter := mame.Input.Mouse.Text.OnMouseEnter;
    vMame.Scene.Settings.OnMouseLeave := mame.Input.Mouse.Text.OnMouseLeave;
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

    if uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.View_Mode = 'video' then
    uView_Mode_Default.Create_Scene;

    //  Create_GameList;
    //  Create_Media(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.View_Mode);

    uSnippet_Search.Create(vMame.Scene.Left, 50, 1026, 750, True); }
end;

procedure Get_Set_Mame_Data;
var
  vQuery: String;
  vi: integer;
begin

  uDB.Arcade_Query.Close;
  uDB.Arcade_Query.SQL.Clear;
  uDB.Arcade_Query.SQL.Text := 'SELECT COUNT(*) FROM GAMES';
  uDB.Arcade_Query.Open;
  mame.Gamelist.Games_Count := uDB.Arcade_Query.Fields[0].AsInteger;

  vQuery := 'SELECT gamename, romname FROM games ORDER BY gamename ASC';
  uDB.Arcade_Query.Close;
  uDB.Arcade_Query.SQL.Clear;
  uDB.Arcade_Query.SQL.Text := vQuery;
  uDB.Arcade_Query.DisableControls;
  uDB.Arcade_Query.Open;
  uDB.Arcade_Query.First;

  mame.Gamelist.ListGames := TStringlist.Create;
  mame.Gamelist.ListRoms := TStringlist.Create;

  mame.Gamelist.ListYear := TStringlist.Create;
  mame.Gamelist.ListManufaturer := TStringlist.Create;
  mame.Gamelist.ListGenre := TStringlist.Create;
  mame.Gamelist.ListMonochrome := TStringlist.Create;
  mame.Gamelist.ListLanguages := TStringlist.Create;

  try
    uDB.Arcade_Query.First;
    while not uDB.Arcade_Query.Eof do
    begin
      mame.Gamelist.ListGames.Add(uDB.Arcade_Query.FieldByName('gamename').AsString);
      mame.Gamelist.ListRoms.Add(uDB.Arcade_Query.FieldByName('romname').AsString);
      uDB.Arcade_Query.Next;
    end;
  finally
    uDB.Arcade_Query.EnableControls;
  end;

  vQuery := 'SELECT DISTINCT year FROM games';
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
      mame.Gamelist.ListYear.Add(uDB.Arcade_Query.FieldByName('year').AsString);
      uDB.Arcade_Query.Next;
    end;
  finally
    uDB.Arcade_Query.EnableControls;
  end;

  vQuery := 'SELECT DISTINCT manufacturer FROM games';
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
      mame.Gamelist.ListManufaturer.Add(uDB.Arcade_Query.FieldByName('manufacturer').AsString);
      uDB.Arcade_Query.Next;
    end;
  finally
    uDB.Arcade_Query.EnableControls;
  end;

  vQuery := 'SELECT DISTINCT genre FROM games';
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
      mame.Gamelist.ListGenre.Add(uDB.Arcade_Query.FieldByName('genre').AsString);
      uDB.Arcade_Query.Next;
    end;
  finally
    uDB.Arcade_Query.EnableControls;
  end;

  vQuery := 'SELECT DISTINCT monochrome FROM games';
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
      mame.Gamelist.ListMonochrome.Add(uDB.Arcade_Query.FieldByName('monochrome').AsString);
      uDB.Arcade_Query.Next;
    end;
  finally
    uDB.Arcade_Query.EnableControls;
  end;

  vQuery := 'SELECT DISTINCT languages FROM games';
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
      mame.Gamelist.ListLanguages.Add(uDB.Arcade_Query.FieldByName('languages').AsString);
      uDB.Arcade_Query.Next;
    end;
  finally
    uDB.Arcade_Query.EnableControls;
  end;

  mame.Gamelist.ListManufaturer.Sort;
  mame.Gamelist.ListYear.Sort;
  mame.Gamelist.ListMonochrome.Sort;
  mame.Gamelist.ListLanguages.Sort;

  vQuery := 'SELECT * FROM ARCADE_MAME WHERE USER_ID=' + uDB_AUser.Local.USER.Num.ToString;
  uDB.ExtraFE_Query_Local.Close;
  uDB.ExtraFE_Query_Local.SQL.Clear;
  uDB.ExtraFE_Query_Local.SQL.Add(vQuery);
  uDB.ExtraFE_Query_Local.Open;
  uDB.ExtraFE_Query_Local.First;
  uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Installed := uDB.ExtraFE_Query_Local.FieldByName('INSTALLED').AsBoolean;
  uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Active := uDB.ExtraFE_Query_Local.FieldByName('EMU_ACTIVE').AsBoolean;
  uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Position := uDB.ExtraFE_Query_Local.FieldByName('EMU_POSITION').AsInteger;
  uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Unique := uDB.ExtraFE_Query_Local.FieldByName('EMU_UNIQUE').AsSingle;
  uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.View_Mode := uDB.ExtraFE_Query_Local.FieldByName('VIEW_MODE').AsString;
  uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Path := uDB.ExtraFE_Query_Local.FieldByName('EXTRAFE_MAME_PATH').AsString;
  uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images := uDB.ExtraFE_Query_Local.FieldByName('EXTRAFE_MAME_IMAGES').AsString;
  uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Sounds := uDB.ExtraFE_Query_Local.FieldByName('EXTRAFE_MAME_SOUNDS').AsString;
  uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Views := uDB.ExtraFE_Query_Local.FieldByName('EXTRAFE_MAME_VIEWS').AsString;
  uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Name := uDB.ExtraFE_Query_Local.FieldByName('MAME_NAME').AsString;
  uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Path := uDB.ExtraFE_Query_Local.FieldByName('MAME_PATH').AsString;
  uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Ini := uDB.ExtraFE_Query_Local.FieldByName('MAME_INI').AsString;
  uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Version := uDB.ExtraFE_Query_Local.FieldByName('MAME_VERSION').AsString;

  uDB.ExtraFE_Query_Local.Close;

  Set_Mame_Data;
end;

procedure Set_Mame_Data;
begin
  if FileExists(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Ini) then
  begin
    emulation.emu[0, 0] := uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Name;
    emulation.Arcade[0].Prog_Path := uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Path;
    emulation.Arcade[0].Emu_Path := uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Path;
    emulation.Arcade[0].Active := uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Active;
    emulation.Arcade[0].Active_Place := uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Position;
    emulation.Arcade[0].Name := uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Name;
    emulation.Arcade[0].Name_Exe := uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Name;
    emulation.Arcade[0].Menu_Image_Path := uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images;
    emulation.Arcade[0].Background := uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'main_background.png';
    emulation.Arcade[0].Logo := uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'mame.png';
    emulation.Arcade[0].Second_Level := -1;
    emulation.Arcade[0].Unique_Num := uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Unique;
    emulation.Arcade[0].Installed := uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Installed;

    uEmu_Arcade_Mame_Ini.Load;
  end;
end;

procedure Players;
begin
  vMame.Scene.Media.T_Players.Layout := TLayout.Create(vMame.Scene.Media.Back);
  vMame.Scene.Media.T_Players.Layout.Name := 'Mame_Media_Players';
  vMame.Scene.Media.T_Players.Layout.Parent := vMame.Scene.Media.Back;
  vMame.Scene.Media.T_Players.Layout.SetBounds(0, 0, vMame.Scene.Media.Back.Width, 50);
  vMame.Scene.Media.T_Players.Layout.Visible := True;

  vMame.Scene.Media.T_Players.Players := TText.Create(vMame.Scene.Media.T_Players.Layout);
  vMame.Scene.Media.T_Players.Players.Name := 'Mame_Media_Players';
  vMame.Scene.Media.T_Players.Players.Parent := vMame.Scene.Media.T_Players.Layout;
  vMame.Scene.Media.T_Players.Players.SetBounds(10, 5, 60, 50);
  vMame.Scene.Media.T_Players.Players.Font.Family := 'IcoMoon-Free';
  vMame.Scene.Media.T_Players.Players.Font.Size := 24;
  vMame.Scene.Media.T_Players.Players.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vMame.Scene.Media.T_Players.Players.Text := #$e972;
  vMame.Scene.Media.T_Players.Players.Visible := True;

  vMame.Scene.Media.T_Players.Players_Value := TText.Create(vMame.Scene.Media.T_Players.Layout);
  vMame.Scene.Media.T_Players.Players_Value.Name := 'Mame_Media_Players_Value';
  vMame.Scene.Media.T_Players.Players_Value.Parent := vMame.Scene.Media.T_Players.Layout;
  vMame.Scene.Media.T_Players.Players_Value.SetBounds(60, 5, 500, 50);
  vMame.Scene.Media.T_Players.Players_Value.Font.Family := 'Tahome';
  vMame.Scene.Media.T_Players.Players_Value.Font.Size := 18;
  vMame.Scene.Media.T_Players.Players_Value.TextSettings.FontColor := TAlphaColorRec.White;
  vMame.Scene.Media.T_Players.Players_Value.HorzTextAlign := TTextAlign.Leading;
  vMame.Scene.Media.T_Players.Players_Value.Text := '';
  vMame.Scene.Media.T_Players.Players_Value.Visible := True;

  vMame.Scene.Media.T_Players.Favorite := TText.Create(vMame.Scene.Media.T_Players.Layout);
  vMame.Scene.Media.T_Players.Favorite.Name := 'Mame_Media_Favorite';
  vMame.Scene.Media.T_Players.Favorite.Parent := vMame.Scene.Media.T_Players.Layout;
  vMame.Scene.Media.T_Players.Favorite.SetBounds(vMame.Scene.Media.T_Players.Layout.Width - 60, 5, 60, 50);
  vMame.Scene.Media.T_Players.Favorite.Font.Family := 'IcoMoon-Free';
  vMame.Scene.Media.T_Players.Favorite.Font.Size := 24;
  vMame.Scene.Media.T_Players.Favorite.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vMame.Scene.Media.T_Players.Favorite.Text := #$e9d9;
  vMame.Scene.Media.T_Players.Favorite.Visible := False;
end;

end.
