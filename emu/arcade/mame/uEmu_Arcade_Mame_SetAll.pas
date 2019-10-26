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
  ZConnection;

procedure Load;

procedure Create_Configuration;

procedure Create_GameList;

procedure Create_Media;
procedure Create_Video_Scene;
procedure HideShow_Video_Scene(vShow: Boolean);
procedure Free_Video_Scene;
procedure Create_Image_Scene;
procedure HideShow_Image_Scene(vShow: Boolean);
procedure Free_Image_Scene;

procedure Create_Loading_Game;
procedure Free_Loading_Game;

procedure Get_Set_Mame_Data;
procedure Set_Mame_Data;

procedure Connect_Database;
procedure Disconnect_Database;

var
  vMame_Database: TFDConnection;
  vMame_Query: TFDQuery;

implementation

uses
  uDatabase,
  uDatabase_SqlCommands,
  uDatabase_ActiveUser,
  uLoad_AllTypes,
  emu,
  uSnippet_Search,
  uEmu_Arcade_Mame,
  uEmu_Arcade_Mame_AllTypes,
  uEmu_Arcade_Mame_Ini;

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
  vMame.Scene.Right.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'background.png');
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
  vMame.Scene.Left.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'background.png');
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
  vMame.Scene.Gamelist.List.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'black_menu.png');
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

  vMame.Scene.Gamelist.List_Line[10].Back.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'selection.png');

  vMame.Scene.Gamelist.List_Blur := TBlurEffect.Create(vMame.Scene.Gamelist.Listbox);
  vMame.Scene.Gamelist.List_Blur.Name := 'Mame_Gamelist_ListBox_Blur';
  vMame.Scene.Gamelist.List_Blur.Parent:=  vMame.Scene.Gamelist.Listbox;
  vMame.Scene.Gamelist.List_Blur.Softness := 0.9;
  vMame.Scene.Gamelist.List_Blur.Enabled := False;

  vMame.Scene.Gamelist.Down_Back_Image := TImage.Create(vMame.Scene.Left);
  vMame.Scene.Gamelist.Down_Back_Image.Name := 'Mame_Gamelist_Down_Back_Image';
  vMame.Scene.Gamelist.Down_Back_Image.Parent := vMame.Scene.Left;
  vMame.Scene.Gamelist.Down_Back_Image.SetBounds(50, 958, 750, 26);
  vMame.Scene.Gamelist.Down_Back_Image.WrapMode := TImageWrapMode.Tile;
  vMame.Scene.Gamelist.Down_Back_Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'black_menu.png');
  vMame.Scene.Gamelist.Down_Back_Image.Visible := True;

  vMame.Scene.Gamelist.T_GamePlayers := TText.Create(vMame.Scene.Gamelist.Down_Back_Image);
  vMame.Scene.Gamelist.T_GamePlayers.Name := 'Mame_Gamelist_GamePlayers_Text';
  vMame.Scene.Gamelist.T_GamePlayers.Parent := vMame.Scene.Gamelist.Down_Back_Image;
  vMame.Scene.Gamelist.T_GamePlayers.SetBounds(0, 1, 750, 22);
  vMame.Scene.Gamelist.T_GamePlayers.Color := TAlphaColorRec.White;
  vMame.Scene.Gamelist.T_GamePlayers.Font.Family := 'Tahoma';
  vMame.Scene.Gamelist.T_GamePlayers.Font.Style := vMame.Scene.Gamelist.T_GamePlayers.Font.Style + [TFontStyle.fsBold];
  vMame.Scene.Gamelist.T_GamePlayers.Font.Size := 20;
  vMame.Scene.Gamelist.T_GamePlayers.TextSettings.HorzAlign := TTextAlign.Trailing;
  vMame.Scene.Gamelist.T_GamePlayers.Visible := True;

  vMame.Scene.Gamelist.T_GameCategory := TText.Create(vMame.Scene.Gamelist.Down_Back_Image);
  vMame.Scene.Gamelist.T_GameCategory.Name := 'Mame_Gamelist_GameCategory_Text';
  vMame.Scene.Gamelist.T_GameCategory.Parent := vMame.Scene.Gamelist.Down_Back_Image;
  vMame.Scene.Gamelist.T_GameCategory.SetBounds(0, 1, 750, 22);
  vMame.Scene.Gamelist.T_GameCategory.Color := TAlphaColorRec.White;
  vMame.Scene.Gamelist.T_GameCategory.Font.Family := 'Tahoma';
  vMame.Scene.Gamelist.T_GameCategory.Font.Style := vMame.Scene.Gamelist.T_GameCategory.Font.Style + [TFontStyle.fsBold];
  vMame.Scene.Gamelist.T_GameCategory.Font.Size := 20;
  vMame.Scene.Gamelist.T_GameCategory.TextSettings.HorzAlign := TTextAlign.Leading;
  vMame.Scene.Gamelist.T_GameCategory.Visible := True;


  vMame.Scene.Gamelist.Filters.Back := TImage.Create(vMame.Scene.Left);
  vMame.Scene.Gamelist.Filters.Back.Name := 'Mame_Gamelist_Filters_Back_Image';
  vMame.Scene.Gamelist.Filters.Back.Parent := vMame.Scene.Left;
  vMame.Scene.Gamelist.Filters.Back.SetBounds(50, 992, 750, 26);
  vMame.Scene.Gamelist.Filters.Back.WrapMode := TImageWrapMode.Tile;
  vMame.Scene.Gamelist.Filters.Back.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'black_menu.png');
  vMame.Scene.Gamelist.Filters.Back.Visible := True;

  vMame.Scene.Gamelist.Filters.Icon := TText.Create(vMame.Scene.Gamelist.Filters.Back);
  vMame.Scene.Gamelist.Filters.Icon.Name := 'Mame_Gamelist_Filters_Image';
  vMame.Scene.Gamelist.Filters.Icon.Parent := vMame.Scene.Gamelist.Filters.Back;
  vMame.Scene.Gamelist.Filters.Icon.SetBounds(2, 1, 24, 24);
  vMame.Scene.Gamelist.Filters.Icon.Font.Family := 'IcoMoon-Free';
  vMame.Scene.Gamelist.Filters.Icon.Font.Size := 22;
  vMame.Scene.Gamelist.Filters.Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vMame.Scene.Gamelist.Filters.Icon.Text:= #$ea5b;
  vMame.Scene.Gamelist.Filters.Icon.OnClick := mame.Input.Mouse.Text.OnMouseClick;
  vMame.Scene.Gamelist.Filters.Icon.OnMouseEnter := mame.Input.Mouse.Text.OnMouseEnter;
  vMame.Scene.Gamelist.Filters.Icon.OnMouseLeave := mame.Input.Mouse.Text.OnMouseLeave;
  vMame.Scene.Gamelist.Filters.Icon.Visible := True;

  vMame.Scene.Gamelist.Filters.Icon_Glow := TGlowEffect.Create(vMame.Scene.Gamelist.Filters.Icon);
  vMame.Scene.Gamelist.Filters.Icon_Glow.Name := 'Mame_Gamelist_Filters_Glow';
  vMame.Scene.Gamelist.Filters.Icon_Glow.Parent := vMame.Scene.Gamelist.Filters.Icon;
  vMame.Scene.Gamelist.Filters.Icon_Glow.GlowColor:= TAlphaColorRec.Deepskyblue;
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

  vMame.Scene.Gamelist.Up_Back_Image := TImage.Create(vMame.Scene.Left);
  vMame.Scene.Gamelist.Up_Back_Image.Name := 'Mame_Gamelist_Up_Back_Image';
  vMame.Scene.Gamelist.Up_Back_Image.Parent := vMame.Scene.Left;
  vMame.Scene.Gamelist.Up_Back_Image.SetBounds(50, 18, 750, 26);
  vMame.Scene.Gamelist.Up_Back_Image.WrapMode := TImageWrapMode.Tile;
  vMame.Scene.Gamelist.Up_Back_Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'black_menu.png');
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
  vMame.Scene.Gamelist.T_MameVersion.Text := user_Active_Local.EMULATORS.Arcade_D.Mame_D.Version;
  vMame.Scene.Gamelist.T_MameVersion.Font.Family := 'Tahoma';
  vMame.Scene.Gamelist.T_MameVersion.Font.Style := vMame.Scene.Gamelist.T_MameVersion.Font.Style + [TFontStyle.fsBold];
  vMame.Scene.Gamelist.T_MameVersion.Font.Size := 20;
  vMame.Scene.Gamelist.T_MameVersion.TextSettings.HorzAlign := TTextAlign.Leading;
  vMame.Scene.Gamelist.T_MameVersion.Visible := True;
end;

procedure Create_Video_Scene;
begin
  { vMame.Scene.Media.Black_Image := TImage.Create(vMame.Scene.Right);
    vMame.Scene.Media.Black_Image.Name := 'Mame_Snap_Black_Image';
    vMame.Scene.Media.Black_Image.Parent := vMame.Scene.Right;
    vMame.Scene.Media.Black_Image.SetBounds(((vMame.Scene.Right.Width / 2) - 196), 278, 416, 226);
    vMame.Scene.Media.Black_Image.WrapMode := TImageWrapMode.Tile;
    vMame.Scene.Media.Black_Image.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'black.png');
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

  vMame.Scene.Media.Video := TFmxPasLibVlcPlayer.Create(vMame.Scene.Media.Back);
  vMame.Scene.Media.Video.Name := 'Mame_Snap_Video';
  vMame.Scene.Media.Video.Parent := vMame.Scene.Media.Back;
  vMame.Scene.Media.Video.SetBounds(50, 100, 650, 600);
  vMame.Scene.Media.Video.WrapMode := TImageWrapMode.Stretch;

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
    vMame.Scene.Media.Type_Arcade.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'arcade.png');
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
  vMame.Scene.Media.Video.Visible := vShow;
  // mame.Actions.Video_Scene_Show := vShow;
end;

procedure Free_Video_Scene;
begin
  FreeAndNil(vMame.Scene.Media.Video);
end;

procedure Create_Image_Scene;
begin
  vMame.Scene.Media.Image := TImage.Create(vMame.Scene.Media.Back);
  vMame.Scene.Media.Image.Name := 'Mame_Snap_Snapshot_Image';
  vMame.Scene.Media.Image.Parent := vMame.Scene.Media.Back;
  vMame.Scene.Media.Image.SetBounds(50, 100, 650, 600);
  vMame.Scene.Media.Image.WrapMode := TImageWrapMode.Stretch;
  vMame.Scene.Media.Image.Visible := True;

  vMame.Scene.Media.Image_X_Ani := TFloatAnimation.Create(vMame.Scene.Media.Image);
  vMame.Scene.Media.Image_X_Ani.Name := 'Mame_Snap_Snapshot_Image__Animation';
  vMame.Scene.Media.Image_X_Ani.Parent := vMame.Scene.Media.Image;
  vMame.Scene.Media.Image_X_Ani.PropertyName := 'Position.X';
  vMame.Scene.Media.Image_X_Ani.Duration := 0.5;
  vMame.Scene.Media.Image_X_Ani.Loop := False;
  vMame.Scene.Media.Image_X_Ani.OnFinish := mame.Ani.Gamelist.OnFinish;
  vMame.Scene.Media.Image_X_Ani.Enabled := False;

  vMame.Scene.Media.Image_Y_Ani := TFloatAnimation.Create(vMame.Scene.Media.Image);
  vMame.Scene.Media.Image_Y_Ani.Name := 'Mame_Snap_Snapshot_Image_Y_Animation';
  vMame.Scene.Media.Image_Y_Ani.Parent := vMame.Scene.Media.Image;
  vMame.Scene.Media.Image_Y_Ani.PropertyName := 'Position.Y';
  vMame.Scene.Media.Image_Y_Ani.Duration := 0.5;
  vMame.Scene.Media.Image_Y_Ani.Loop := False;
  vMame.Scene.Media.Image_Y_Ani.OnFinish := mame.Ani.Gamelist.OnFinish;
  vMame.Scene.Media.Image_Y_Ani.Enabled := False;

  vMame.Scene.Media.Image_Width_Ani := TFloatAnimation.Create(vMame.Scene.Media.Image);
  vMame.Scene.Media.Image_Width_Ani.Name := 'Mame_Snap_Snapshot_Image_Width_Animation';
  vMame.Scene.Media.Image_Width_Ani.Parent := vMame.Scene.Media.Image;
  vMame.Scene.Media.Image_Width_Ani.PropertyName := 'Width';
  vMame.Scene.Media.Image_Width_Ani.Duration := 0.5;
  vMame.Scene.Media.Image_Width_Ani.Loop := False;
  vMame.Scene.Media.Image_Width_Ani.OnFinish := mame.Ani.Gamelist.OnFinish;
  vMame.Scene.Media.Image_Width_Ani.Enabled := False;

  vMame.Scene.Media.Image_Height_Ani := TFloatAnimation.Create(vMame.Scene.Media.Image);
  vMame.Scene.Media.Image_Height_Ani.Name := 'Mame_Snap_Snapshot_Image_Height_Animation';
  vMame.Scene.Media.Image_Height_Ani.Parent := vMame.Scene.Media.Image_Fade;
  vMame.Scene.Media.Image_Height_Ani.PropertyName := 'Height';
  vMame.Scene.Media.Image_Height_Ani.Duration := 0.5;
  vMame.Scene.Media.Image_Height_Ani.Loop := False;
  vMame.Scene.Media.Image_Height_Ani.OnFinish := mame.Ani.Gamelist.OnFinish;
  vMame.Scene.Media.Image_Height_Ani.Enabled := False;

  vMame.Scene.Media.Image_Reflaction := TReflectionEffect.Create(vMame.Scene.Media.Image);
  vMame.Scene.Media.Image_Reflaction.Name := 'Mame_Snap_Snapshot_Reflaction';
  vMame.Scene.Media.Image_Reflaction.Parent := vMame.Scene.Media.Image;
  vMame.Scene.Media.Image_Reflaction.Offset := 380;
  vMame.Scene.Media.Image_Reflaction.Length := 0.3;
  vMame.Scene.Media.Image_Reflaction.Opacity := 0.4;
  vMame.Scene.Media.Image_Reflaction.Enabled := False;
  vMame.Scene.Media.Image_Reflaction.Offset := 12;

  vMame.Scene.Media.Image_Fade := TFadeTransitionEffect.Create(vMame.Scene.Media.Image);
  vMame.Scene.Media.Image_Fade.Name := 'Mame_Snap_Snapshot_Image_Fade_Effect';
  vMame.Scene.Media.Image_Fade.Parent := vMame.Scene.Media.Image;

  vMame.Scene.Media.Image_Fade_Ani := TFloatAnimation.Create(vMame.Scene.Media.Image_Fade);
  vMame.Scene.Media.Image_Fade_Ani.Name := 'Mame_Snap_Snapshot_Image_Fade_Effect_Animation';
  vMame.Scene.Media.Image_Fade_Ani.Parent := vMame.Scene.Media.Image_Fade;
  vMame.Scene.Media.Image_Fade_Ani.PropertyName := 'Progress';
  vMame.Scene.Media.Image_Fade_Ani.Duration := 0.5;
  vMame.Scene.Media.Image_Fade_Ani.StartValue := 0;
  vMame.Scene.Media.Image_Fade_Ani.StopValue := 100;
  vMame.Scene.Media.Image_Fade_Ani.Loop := False;
  vMame.Scene.Media.Image_Fade_Ani.OnFinish := mame.Ani.Gamelist.OnFinish;
  vMame.Scene.Media.Image_Fade_Ani.Enabled := False;
end;

procedure HideShow_Image_Scene(vShow: Boolean);
begin
  vMame.Scene.Media.Image.Visible := vShow;
  vMame.Scene.Media.Image_Reflaction.Enabled := vShow;
  vMame.Scene.Media.Image_Fade.Enabled := vShow;
  vMame.Scene.Media.Image_Fade_Ani.Enabled := vShow;
end;

procedure Free_Image_Scene;
begin
  FreeAndNil(vMame.Scene.Media.Image);
end;

procedure Create_Media;
begin
  vMame.Scene.Media.Back := TImage.Create(vMame.Scene.Right);
  vMame.Scene.Media.Back.Name := 'Mame_Media_Back';
  vMame.Scene.Media.Back.Parent := vMame.Scene.Right;
  vMame.Scene.Media.Back.SetBounds(50, 50, 750, (vMame.Scene.Right.Height - 180));
  vMame.Scene.Media.Back.WrapMode := TImageWrapMode.Tile;
  vMame.Scene.Media.Back.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'black_menu.png');
  vMame.Scene.Media.Back.Visible := True;

  Create_Video_Scene;
  HideShow_Video_Scene(False);
  Create_Image_Scene;
  HideShow_Image_Scene(True);
end;

procedure Create_Loading_Game;
begin
  vMame.Scene.Left_Blur.Enabled := True;
  vMame.Scene.Right_Blur.Enabled := True;
  vMame.Scene.Gamelist.List.Visible := False;
  vMame.Scene.Media.Back.Visible := False;

  vMame.Scene.PopUp.Back := TImage.Create(vMame.Scene.Main);
  vMame.Scene.PopUp.Back.Name := 'Mame_Loading_Game';
  vMame.Scene.PopUp.Back.Parent := vMame.Scene.Main;
  vMame.Scene.PopUp.Back.SetBounds(((vMame.Scene.Main.Width / 2) - 500), ((vMame.Scene.Main.Height / 2 - 200) - 150), 1000, 500);
  vMame.Scene.PopUp.Back.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'black_menu.png');
  vMame.Scene.PopUp.Back.WrapMode := TImageWrapMode.Tile;
  vMame.Scene.PopUp.Back.Visible := True;

  vMame.Scene.PopUp.Line1 := TText.Create(vMame.Scene.PopUp.Back);
  vMame.Scene.PopUp.Line1.Name := 'vMame_Loading_Game_Line1';
  vMame.Scene.PopUp.Line1.Parent := vMame.Scene.PopUp.Back;
  vMame.Scene.PopUp.Line1.SetBounds(0, 20, 1000, 50);
  vMame.Scene.PopUp.Line1.Text := 'Loading Game : ';
  vMame.Scene.PopUp.Line1.Font.Family := 'Tahoma';
  vMame.Scene.PopUp.Line1.Font.Size := 36;
  vMame.Scene.PopUp.Line1.TextSettings.HorzAlign := TTextAlign.Center;
  vMame.Scene.PopUp.Line1.Color := TAlphaColorRec.Deepskyblue;
  vMame.Scene.PopUp.Line1.Font.Style := vMame.Scene.PopUp.Line1.Font.Style + [TFontStyle.fsBold];
  vMame.Scene.PopUp.Line1.Visible := True;

  vMame.Scene.PopUp.Line2 := TText.Create(vMame.Scene.PopUp.Back);
  vMame.Scene.PopUp.Line2.Name := 'Mame_Loading_Game_Line2';
  vMame.Scene.PopUp.Line2.Parent := vMame.Scene.PopUp.Back;
  vMame.Scene.PopUp.Line2.SetBounds(0, 90, 1000, 50);
  vMame.Scene.PopUp.Line2.Text := mame.Gamelist.ListGames[mame.Gamelist.Selected];
  vMame.Scene.PopUp.Line2.Font.Family := 'Tahoma';
  vMame.Scene.PopUp.Line2.Font.Size := 36;
  vMame.Scene.PopUp.Line2.TextSettings.HorzAlign := TTextAlign.Center;
  vMame.Scene.PopUp.Line2.Color := TAlphaColorRec.White;
  vMame.Scene.PopUp.Line2.Font.Style := vMame.Scene.PopUp.Line2.Font.Style + [TFontStyle.fsBold];
  vMame.Scene.PopUp.Line2.Visible := True;

  vMame.Scene.PopUp.Line3_Text := TText.Create(vMame.Scene.PopUp.Back);
  vMame.Scene.PopUp.Line3_Text.Name := 'Mame_Loading_Game_Line3_Text';
  vMame.Scene.PopUp.Line3_Text.Parent := vMame.Scene.PopUp.Back;
  vMame.Scene.PopUp.Line3_Text.SetBounds(0, 440, 200, 50);
  vMame.Scene.PopUp.Line3_Text.Text := 'Was played : ';
  vMame.Scene.PopUp.Line3_Text.Font.Family := 'Tahoma';
  vMame.Scene.PopUp.Line3_Text.Font.Size := 24;
  vMame.Scene.PopUp.Line3_Text.TextSettings.HorzAlign := TTextAlign.Leading;
  vMame.Scene.PopUp.Line3_Text.Color := TAlphaColorRec.White;
  vMame.Scene.PopUp.Line3_Text.Font.Style := vMame.Scene.PopUp.Line2.Font.Style + [TFontStyle.fsBold];
  vMame.Scene.PopUp.Line3_Text.Visible := True;

  vMame.Scene.PopUp.Line3_Value:= TText.Create(vMame.Scene.PopUp.Back);
  vMame.Scene.PopUp.Line3_Value.Name := 'Mame_Loading_Game_Line3_Value';
  vMame.Scene.PopUp.Line3_Value.Parent := vMame.Scene.PopUp.Back;
  vMame.Scene.PopUp.Line3_Value.SetBounds(140, 440, 200, 50);
  vMame.Scene.PopUp.Line3_Value.Text := '0';
  vMame.Scene.PopUp.Line3_Value.Font.Family := 'Tahoma';
  vMame.Scene.PopUp.Line3_Value.Font.Size := 24;
  vMame.Scene.PopUp.Line3_Value.TextSettings.HorzAlign := TTextAlign.Leading;
  vMame.Scene.PopUp.Line3_Value.Color := TAlphaColorRec.Deepskyblue;
  vMame.Scene.PopUp.Line3_Value.Font.Style := vMame.Scene.PopUp.Line2.Font.Style + [TFontStyle.fsBold];
  vMame.Scene.PopUp.Line3_Value.Visible := True;

end;

procedure Free_Loading_Game;
begin
  FreeAndNil(vMame.Scene.PopUp.Back);
  vMame.Scene.Left_Blur.Enabled := False;
  vMame.Scene.Right_Blur.Enabled := False;
  vMame.Scene.Gamelist.List.Visible := True;
  vMame.Scene.Media.Back.Visible := True;
end;

procedure Load;
begin
  vMame.Scene.Main := TImage.Create(Emu_Form);
  vMame.Scene.Main.Name := 'Mame_Main';
  vMame.Scene.Main.Parent := Emu_Form;
  vMame.Scene.Main.SetBounds(0, 0, Emu_Form.Width, Emu_Form.Height);
  vMame.Scene.Main.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'config.jpg');
  vMame.Scene.Main.WrapMode := TImageWrapMode.Stretch;
  vMame.Scene.Main.Visible := True;

  vMame.Scene.Main_Blur := TGaussianBlurEffect.Create(vMame.Scene.Main);
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
  vMame.Scene.Exit_Mame.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'exit_mame.png');
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

  Create_GameList;
  Create_Media;

  uSnippet_Search.Create(vMame.Scene.Left, 50, 1026, 750, True);
end;

procedure Get_Set_Mame_Data;
var
  vQuery: String;
  vi: integer;
begin
  Connect_Database;

  vMame_Query.Close;
  vMame_Query.SQL.Clear;
  vMame_Query.SQL.Text := 'SELECT COUNT(*) FROM GAMES';
  vMame_Query.Open;
  mame.Gamelist.Games_Count := vMame_Query.Fields[0].AsInteger;

  vQuery := 'select gamename, romname from games order by gamename asc';
  vMame_Query.Close;
  vMame_Query.SQL.Clear;
  vMame_Query.SQL.Text := vQuery;
  vMame_Query.DisableControls;
  vMame_Query.Open;
  vMame_Query.First;

  mame.Gamelist.ListGames := TStringlist.Create;
  mame.Gamelist.ListRoms := TStringList.Create;

  mame.Gamelist.ListYear := TStringlist.Create;
  mame.Gamelist.ListManufaturer := TStringlist.Create;
  mame.Gamelist.ListGenre := TStringlist.Create;
  mame.Gamelist.ListMonochrome := TStringList.Create;
  mame.Gamelist.ListLanguages := TStringList.Create;

  try
    vMame_Query.First;
    while not vMame_Query.Eof do
    begin
      mame.Gamelist.ListGames.Add(vMame_Query.FieldByName('gamename').AsString);
      mame.Gamelist.ListRoms.Add(vMame_Query.FieldByName('romname').AsString);
      vMame_Query.Next;
    end;
  finally
    vMame_Query.EnableControls;
  end;

  vQuery := 'select distinct year from games';
  vMame_Query.Close;
  vMame_Query.SQL.Clear;
  vMame_Query.SQL.Text := vQuery;
  vMame_Query.DisableControls;
  vMame_Query.Open;
  vMame_Query.First;

  try
    vMame_Query.First;
    while not vMame_Query.Eof do
    begin
      mame.Gamelist.ListYear.Add(vMame_Query.FieldByName('year').AsString);
      vMame_Query.Next;
    end;
  finally
    vMame_Query.EnableControls;
  end;

  vQuery := 'select distinct manufacturer from games';
  vMame_Query.Close;
  vMame_Query.SQL.Clear;
  vMame_Query.SQL.Text := vQuery;
  vMame_Query.DisableControls;
  vMame_Query.Open;
  vMame_Query.First;

  try
    vMame_Query.First;
    while not vMame_Query.Eof do
    begin
      mame.Gamelist.ListManufaturer.Add(vMame_Query.FieldByName('manufacturer').AsString);
      vMame_Query.Next;
    end;
  finally
    vMame_Query.EnableControls;
  end;

  vQuery := 'select distinct genre from games';
  vMame_Query.Close;
  vMame_Query.SQL.Clear;
  vMame_Query.SQL.Text := vQuery;
  vMame_Query.DisableControls;
  vMame_Query.Open;
  vMame_Query.First;

  try
    vMame_Query.First;
    while not vMame_Query.Eof do
    begin
      mame.Gamelist.ListGenre.Add(vMame_Query.FieldByName('genre').AsString);
      vMame_Query.Next;
    end;
  finally
    vMame_Query.EnableControls;
  end;

  vQuery := 'select distinct monochrome from games';
  vMame_Query.Close;
  vMame_Query.SQL.Clear;
  vMame_Query.SQL.Text := vQuery;
  vMame_Query.DisableControls;
  vMame_Query.Open;
  vMame_Query.First;

  try
    vMame_Query.First;
    while not vMame_Query.Eof do
    begin
      mame.Gamelist.ListMonochrome.Add(vMame_Query.FieldByName('monochrome').AsString);
      vMame_Query.Next;
    end;
  finally
    vMame_Query.EnableControls;
  end;

  vQuery := 'select distinct languages from games';
  vMame_Query.Close;
  vMame_Query.SQL.Clear;
  vMame_Query.SQL.Text := vQuery;
  vMame_Query.DisableControls;
  vMame_Query.Open;
  vMame_Query.First;

  try
    vMame_Query.First;
    while not vMame_Query.Eof do
    begin
      mame.Gamelist.ListLanguages.Add(vMame_Query.FieldByName('languages').AsString);
      vMame_Query.Next;
    end;
  finally
    vMame_Query.EnableControls;
  end;

  mame.Gamelist.ListManufaturer.Sort;
  mame.Gamelist.ListYear.Sort;
  mame.Gamelist.ListMonochrome.Sort;
  mame.Gamelist.ListLanguages.Sort;

  vQuery := 'SELECT * FROM ARCADE_MAME WHERE USER_ID=' + user_Active_Local.Num.ToString;
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Add(vQuery);
  ExtraFE_Query_Local.Open;
  ExtraFE_Query_Local.First;
  user_Active_Local.EMULATORS.Arcade_D.Mame_D.Installed := ExtraFE_Query_Local.FieldByName('INSTALLED').AsBoolean;
  user_Active_Local.EMULATORS.Arcade_D.Mame_D.Active := ExtraFE_Query_Local.FieldByName('EMU_ACTIVE').AsBoolean;
  user_Active_Local.EMULATORS.Arcade_D.Mame_D.Position := ExtraFE_Query_Local.FieldByName('EMU_POSITION').AsInteger;
  user_Active_Local.EMULATORS.Arcade_D.Mame_D.Unique := ExtraFE_Query_Local.FieldByName('EMU_UNIQUE').AsInteger;
  user_Active_Local.EMULATORS.Arcade_D.Mame_D.Path := ExtraFE_Query_Local.FieldByName('MAME_PATH').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Mame_D.Name := ExtraFE_Query_Local.FieldByName('MAME_NAME').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Mame_D.Ini := ExtraFE_Query_Local.FieldByName('MAME_INI').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Mame_D.Version := ExtraFE_Query_Local.FieldByName('MAME_VERSION').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Path := ExtraFE_Query_Local.FieldByName('EXTRAFE_MAME_PATH').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Database := ExtraFE_Query_Local.FieldByName('EXTRAFE_MAME_DATABASE').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images := ExtraFE_Query_Local.FieldByName('EXTRAFE_MAME_IMAGES').AsString;
  user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Sounds := ExtraFE_Query_Local.FieldByName('EXTRAFE_MAME_SOUNDS').AsString;
  ExtraFE_Query_Local.Close;

  Set_Mame_Data;
end;

procedure Set_Mame_Data;
begin
  if FileExists(user_Active_Local.EMULATORS.Arcade_D.Mame_D.Ini) then
  begin
    emulation.emu[0, 0] := user_Active_Local.EMULATORS.Arcade_D.Mame_D.Name;
    emulation.Arcade[0].Prog_Path := user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Path;
    emulation.Arcade[0].Emu_Path := user_Active_Local.EMULATORS.Arcade_D.Mame_D.Path;
    emulation.Arcade[0].Active := user_Active_Local.EMULATORS.Arcade_D.Mame_D.Active;
    emulation.Arcade[0].Active_Place := user_Active_Local.EMULATORS.Arcade_D.Mame_D.Position;
    emulation.Arcade[0].Name := user_Active_Local.EMULATORS.Arcade_D.Mame_D.Name;
    emulation.Arcade[0].Name_Exe := user_Active_Local.EMULATORS.Arcade_D.Mame_D.Name;
    emulation.Arcade[0].Menu_Image_Path := user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images;
    emulation.Arcade[0].Background := user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'main_background.png';
    emulation.Arcade[0].Logo := user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'mame.png';
    emulation.Arcade[0].Second_Level := -1;
    emulation.Arcade[0].Unique_Num := user_Active_Local.EMULATORS.Arcade_D.Mame_D.Unique;
    emulation.Arcade[0].Installed := user_Active_Local.EMULATORS.Arcade_D.Mame_D.Installed;

    uEmu_Arcade_Mame_Ini.Load;
  end;
end;

procedure Connect_Database;
begin
  vMame_Database := TFDConnection.Create(emu.Emu_Form);
  vMame_Database.Name := 'Mame_Local_Database';
  with vMame_Database do
  begin
    Close;
    with Params do
    begin
      Add('DriverID=SQLITE');
      Add('Database=' + extrafe.Prog.Path + 'data\database\arcade\ARCADE.DB');
    end;
    Open;
  end;
  vMame_Database.LoginPrompt := False;

  vMame_Database.Connected := True;

  vMame_Query := TFDQuery.Create(emu.Emu_Form);
  vMame_Query.Name := 'Mame_Local_Query';
  vMame_Query.Connection := vMame_Database;
  vMame_Query.Active := False;

end;

procedure Disconnect_Database;
begin
  vMame_Database.Connected := False;
end;

end.
