unit uSoundplayer_SetAll;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UITypes,
  FMX.Objects,
  FMX.Dialogs,
  FMX.Grid,
  FMX.Grid.Style,
  FMX.Effects,
  FMX.StdCtrls,
  FMX.Types,
  FMX.Ani,
  FMX.Filter.Effects,
  FMX.TabControl,
  FMX.Edit,
  FMX.ComboEdit,
  FMX.Memo,
  FMX.ListBox,
  FMX.Imglist,
  FMX.Graphics,
  FMX.Menus,
  FMX.ExtCtrls,
  FMX.Layouts,
  uSnippet_Image,
  ALFmxStdCtrls,
  main;

procedure uSoundPlayer_SetAll_Set;

procedure uSoundplayer_SetAll_Player;
procedure uSoundplayer_SetAll_Info;
procedure uSoundplayer_SetAll_Playlist;
procedure uSoundplayer_SetAll_Cover;

procedure uSoundplayer_SetRemoveSongDialog;

implementation

uses
  uLoad,
  uSnippet_Text,
  uLoad_AllTypes,
  uMain_SetAll,
  uMain_AllTypes,
  uSoundplayer_AllTypes,
  uSoundplayer_Actions,
  uSoundplayer_Mouse,
  uSoundplayer_Player_Actions,
  uSoundplayer_Playlist_Actions,
  BASS;

Procedure uSoundPlayer_SetAll_Set;
const
  cImgList: array [0 .. 9] of string = ('sp_play.png', 'sp_stop.png', 'sp_pause.png', 'sp_note.png',
    'sp_edit.png', 'sp_up.png', 'sp_down.png', 'sp_delete.png', 'sp_tag_mp3.png', 'sp_tag_ogg.png');
var
  vi: Integer;
  vImage: Timage;
begin
  vSoundplayer.scene.Imglist := TImageList.Create(Main_Form);
  vSoundplayer.scene.Imglist.Name := 'A_SP_Imagelist';

  for vi := 0 to 9 do
  begin
    vImage := Timage.Create(Main_Form);
    vImage.Width := 24;
    vImage.Height := 24;
    vImage.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + cImgList[vi]);
    vImage.WrapMode := TImageWrapMode.Fit;
    vSoundplayer.scene.Imglist.Add(vImage.Bitmap);
    FreeAndNil(vImage);
  end;

  vSoundplayer.scene.soundplayer := Timage.Create(mainScene.main.Down_Level);
  vSoundplayer.scene.soundplayer.Name := 'A_Soundplayer';
  vSoundplayer.scene.soundplayer.Parent := mainScene.main.Down_Level;
  vSoundplayer.scene.soundplayer.SetBounds(0, 130, extrafe.res.Width, extrafe.res.Height - 130);
  vSoundplayer.scene.soundplayer.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_back.png');
  vSoundplayer.scene.soundplayer.WrapMode := TImageWrapMode.Tile;
  vSoundplayer.scene.soundplayer.Visible := True;

  vSoundplayer.scene.Soundplayer_Ani := TFloatAnimation.Create(vSoundplayer.scene.soundplayer);
  vSoundplayer.scene.Soundplayer_Ani.Name := 'A_Soundplayer_Animation';
  vSoundplayer.scene.Soundplayer_Ani.Parent := vSoundplayer.scene.soundplayer;
  vSoundplayer.scene.Soundplayer_Ani.AnimationType := TAnimationType.&In;
  vSoundplayer.scene.Soundplayer_Ani.Duration := 0.4;
  vSoundplayer.scene.Soundplayer_Ani.PropertyName := 'Opacity';
  vSoundplayer.scene.Soundplayer_Ani.StartValue := 1;
  vSoundplayer.scene.Soundplayer_Ani.StopValue := 0;
  vSoundplayer.scene.Soundplayer_Ani.Enabled := False;

  // Back
  vSoundplayer.scene.Back := Timage.Create(vSoundplayer.scene.soundplayer);
  vSoundplayer.scene.Back.Name := 'A_SP_Back_Image';
  vSoundplayer.scene.Back.Parent := vSoundplayer.scene.soundplayer;
  vSoundplayer.scene.Back.SetBounds(0, 0, vSoundplayer.scene.soundplayer.Width,
    vSoundplayer.scene.soundplayer.Height);
  vSoundplayer.scene.Back.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_back.png');
  vSoundplayer.scene.Back.WrapMode := TImageWrapMode.Tile;
  vSoundplayer.scene.Back.Visible := True;

  vSoundplayer.scene.Back_Blur := TGaussianBlurEffect.Create(vSoundplayer.scene.Back);
  vSoundplayer.scene.Back_Blur.Name := 'A_SP_Back_Blur';
  vSoundplayer.scene.Back_Blur.Parent := vSoundplayer.scene.Back;
  vSoundplayer.scene.Back_Blur.BlurAmount := 0.5;
  vSoundplayer.scene.Back_Blur.Enabled := False;

  // Up Line
  vSoundplayer.scene.UpLine := Timage.Create(vSoundplayer.scene.Back);
  vSoundplayer.scene.UpLine.Name := 'A_SP_UpLine_Image';
  vSoundplayer.scene.UpLine.Parent := vSoundplayer.scene.Back;
  vSoundplayer.scene.UpLine.SetBounds(0, 0, vSoundplayer.scene.soundplayer.Width, 10);
  vSoundplayer.scene.UpLine.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_spot.png');
  vSoundplayer.scene.UpLine.WrapMode := TImageWrapMode.Tile;
  vSoundplayer.scene.UpLine.Visible := True;

  uSoundplayer_SetAll_Player;

  // Middle Line
  vSoundplayer.scene.MiddleLine := Timage.Create(vSoundplayer.scene.Back);
  vSoundplayer.scene.MiddleLine.Name := 'A_SP_MiddleLine_Image';
  vSoundplayer.scene.MiddleLine.Parent := vSoundplayer.scene.Back;
  vSoundplayer.scene.MiddleLine.SetBounds(0, 210, vSoundplayer.scene.Back.Width, 10);
  vSoundplayer.scene.MiddleLine.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_spot.png');
  vSoundplayer.scene.MiddleLine.WrapMode := TImageWrapMode.Tile;
  vSoundplayer.scene.MiddleLine.Visible := True;

  uSoundplayer_SetAll_Info;

  // Playlist line
  vSoundplayer.scene.PlaylistLine := Timage.Create(vSoundplayer.scene.Back);
  vSoundplayer.scene.PlaylistLine.Name := 'A_SP_PlaylistLine_Image';
  vSoundplayer.scene.PlaylistLine.Parent := vSoundplayer.scene.Back;
  vSoundplayer.scene.PlaylistLine.SetBounds(0, extrafe.res.Height - 410, vSoundplayer.scene.Back.Width, 10);
  vSoundplayer.scene.PlaylistLine.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_spot.png');
  vSoundplayer.scene.PlaylistLine.WrapMode := TImageWrapMode.Tile;
  vSoundplayer.scene.PlaylistLine.Visible := True;

  uSoundplayer_SetAll_Playlist;

  vSoundplayer.scene.Settings := Timage.Create(vSoundplayer.scene.Back);
  vSoundplayer.scene.Settings.Name := 'A_SP_Settings_Image';
  vSoundplayer.scene.Settings.Parent := vSoundplayer.scene.Back;
  vSoundplayer.scene.Settings.SetBounds(vSoundplayer.scene.Back.Width - 60, vSoundplayer.scene.Back.Height -
    70, 50, 50);
  vSoundplayer.scene.Settings.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_settings_blue.png');
  vSoundplayer.scene.Settings.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.scene.Settings.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.scene.Settings.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.scene.Settings.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.scene.Settings.Visible := True;

  vSoundplayer.scene.Settings_Ani := TFloatAnimation.Create(vSoundplayer.scene.Settings);
  vSoundplayer.scene.Settings_Ani.Name := 'A_SP_Settings_Animation';
  vSoundplayer.scene.Settings_Ani.Parent := vSoundplayer.scene.Settings;
  vSoundplayer.scene.Settings_Ani.Duration := 4;
  vSoundplayer.scene.Settings_Ani.Loop := True;
  vSoundplayer.scene.Settings_Ani.PropertyName := 'RotationAngle';
  vSoundplayer.scene.Settings_Ani.StartValue := 0;
  vSoundplayer.scene.Settings_Ani.StopValue := 360;
  vSoundplayer.scene.Settings_Ani.Enabled := True;

  vSoundplayer.scene.Settings_Glow := TGlowEffect.Create(vSoundplayer.scene.Settings);
  vSoundplayer.scene.Settings_Glow.Name := 'A_SP_Settings_Glow';
  vSoundplayer.scene.Settings_Glow.Parent := vSoundplayer.scene.Settings;
  vSoundplayer.scene.Settings_Glow.Softness := 0.4;
  vSoundplayer.scene.Settings_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.scene.Settings_Glow.Opacity := 0.9;
  vSoundplayer.scene.Settings_Glow.Enabled := False;

  // Down Line
  vSoundplayer.scene.DownLine := Timage.Create(vSoundplayer.scene.soundplayer);
  vSoundplayer.scene.DownLine.Name := 'A_SP_DownLine_Image';
  vSoundplayer.scene.DownLine.Parent := vSoundplayer.scene.soundplayer;
  vSoundplayer.scene.DownLine.SetBounds(0, vSoundplayer.scene.soundplayer.Height - 10,
    vSoundplayer.scene.soundplayer.Width, 10);
  vSoundplayer.scene.DownLine.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_spot.png');
  vSoundplayer.scene.DownLine.WrapMode := TImageWrapMode.Tile;
  vSoundplayer.scene.DownLine.Visible := True;

  // Last the cover for can do fullscreen
  uSoundplayer_SetAll_Cover;


  vSoundplayer.scene.OpenDialog := TOpenDialog.Create(vSoundplayer.scene.soundplayer);
  vSoundplayer.scene.OpenDialog.Name := 'A_SP_OpenDialog_AddSongs';
  vSoundplayer.scene.OpenDialog.Parent := vSoundplayer.scene.soundplayer;
  vSoundplayer.scene.OpenDialog.Options := vSoundplayer.scene.OpenDialog.Options +
    [TOpenOption.ofAllowMultiSelect, TOpenOption.ofPathMustExist, TOpenOption.ofFileMustExist];
  vSoundplayer.scene.OpenDialog.OnClose := vSoundplayer.scene.Dialog.OnClose;
  vSoundplayer.scene.OpenDialog.OnShow := vSoundplayer.scene.Dialog.OnShow;

  vSoundplayer.timer.Song := TTimer.Create(vSoundplayer.scene.soundplayer);
  vSoundplayer.timer.Song.Name := 'A_SP_Timer_Song';
  vSoundplayer.timer.Song.Parent := vSoundplayer.scene.soundplayer;
  vSoundplayer.timer.Song.Interval := 100;
  vSoundplayer.timer.Song.OnTimer := vSoundplayer.timer.timer.OnTimer;
  vSoundplayer.timer.Song.Enabled := False;

  uSoundPlayer_Actions_Load;
end;

procedure uSoundplayer_SetAll_Player;
var
  vi: Integer;
begin
  vSoundplayer.scene.Back_Player := Timage.Create(vSoundplayer.scene.Back);
  vSoundplayer.scene.Back_Player.Name := 'A_SP_BackPlayer_Image';
  vSoundplayer.scene.Back_Player.Parent := vSoundplayer.scene.Back;
  vSoundplayer.scene.Back_Player.SetBounds(0, 10, vSoundplayer.scene.soundplayer.Width, 200);
  vSoundplayer.scene.Back_Player.Visible := True;

  vSoundplayer.player.Play := Timage.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Play.Name := 'A_SP_Player_Play_Image';
  vSoundplayer.player.Play.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Play.SetBounds((extrafe.res.Width / 2) - 32, 137, 48, 48);
  vSoundplayer.player.Play.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_play.png');
  vSoundplayer.player.Play.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.player.Play.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.player.Play.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.player.Play.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.player.Play.Visible := True;

  vSoundplayer.player.Play_Glow := TGlowEffect.Create(vSoundplayer.player.Play);
  vSoundplayer.player.Play_Glow.Name := 'A_SP_Player_Play_Glow';
  vSoundplayer.player.Play_Glow.Parent := vSoundplayer.player.Play;
  vSoundplayer.player.Play_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.player.Play_Glow.Softness := 0.4;
  vSoundplayer.player.Play_Glow.Opacity := 0.9;
  vSoundplayer.player.Play_Glow.Enabled := False;

  vSoundplayer.player.Play_Grey := TMonochromeEffect.Create(vSoundplayer.player.Play);
  vSoundplayer.player.Play_Grey.Name := 'A_SP_Player_Play_Grey';
  vSoundplayer.player.Play_Grey.Parent := vSoundplayer.player.Play;
  vSoundplayer.player.Play_Grey.Enabled := False;

  vSoundplayer.player.Stop := Timage.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Stop.Name := 'A_SP_Player_Stop_Image';
  vSoundplayer.player.Stop.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Stop.SetBounds(vSoundplayer.player.Play.Position.X - 72, 137, 48, 48);
  vSoundplayer.player.Stop.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_stop.png');
  vSoundplayer.player.Stop.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.player.Stop.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.player.Stop.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.player.Stop.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.player.Stop.Visible := True;

  vSoundplayer.player.Stop_Glow := TGlowEffect.Create(vSoundplayer.player.Stop);
  vSoundplayer.player.Stop_Glow.Name := 'A_SP_Player_Stop_Glow';
  vSoundplayer.player.Stop_Glow.Parent := vSoundplayer.player.Stop;
  vSoundplayer.player.Stop_Glow.GlowColor := TAlphaColorRec.Red;
  vSoundplayer.player.Stop_Glow.Softness := 0.4;
  vSoundplayer.player.Stop_Glow.Opacity := 0.9;
  vSoundplayer.player.Stop_Glow.Enabled := False;

  vSoundplayer.player.Stop_Grey := TMonochromeEffect.Create(vSoundplayer.player.Stop);
  vSoundplayer.player.Stop_Grey.Name := 'A_SP_Player_Stop_Grey';
  vSoundplayer.player.Stop_Grey.Parent := vSoundplayer.player.Stop;
  vSoundplayer.player.Stop_Grey.Enabled := False;

  vSoundplayer.Player.Stop_Color:= TFillRGBEffect.Create(vSoundplayer.Player.Stop);
  vSoundplayer.Player.Stop_Color.Name:= 'A_SP_Player_Stop_Color';
  vSoundplayer.Player.Stop_Color.Parent:=  vSoundplayer.Player.Stop;
  vSoundplayer.Player.Stop_Color.Color:= TAlphaColorRec.Red;
  vSoundplayer.Player.Stop_Color.Enabled:= False;

  vSoundplayer.player.Previous := Timage.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Previous.Name := 'A_SP_Player_Previous_Image';
  vSoundplayer.player.Previous.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Previous.SetBounds(vSoundplayer.player.Stop.Position.X - 72, 137, 48, 48);
  vSoundplayer.player.Previous.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_previous.png');
  vSoundplayer.player.Previous.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.player.Previous.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.player.Previous.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.player.Previous.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.player.Previous.Visible := True;

  vSoundplayer.player.Previous_Glow := TGlowEffect.Create(vSoundplayer.player.Previous);
  vSoundplayer.player.Previous_Glow.Name := 'A_SP_Player_Previous_Glow';
  vSoundplayer.player.Previous_Glow.Parent := vSoundplayer.player.Previous;
  vSoundplayer.player.Previous_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.player.Previous_Glow.Softness := 0.4;
  vSoundplayer.player.Previous_Glow.Opacity := 0.9;
  vSoundplayer.player.Previous_Glow.Enabled := False;

  vSoundplayer.player.Previous_Grey := TMonochromeEffect.Create(vSoundplayer.player.Previous);
  vSoundplayer.player.Previous_Grey.Name := 'A_SP_Player_Previous_Grey';
  vSoundplayer.player.Previous_Grey.Parent := vSoundplayer.player.Previous;
  vSoundplayer.player.Previous_Grey.Enabled := False;

  vSoundplayer.player.Next := Timage.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Next.Name := 'A_SP_Player_Next_Image';
  vSoundplayer.player.Next.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Next.SetBounds(vSoundplayer.player.Play.Position.X + 72, 137, 48, 48);
  vSoundplayer.player.Next.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_next.png');
  vSoundplayer.player.Next.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.player.Next.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.player.Next.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.player.Next.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.player.Next.Visible := True;

  vSoundplayer.player.Next_Glow := TGlowEffect.Create(vSoundplayer.player.Next);
  vSoundplayer.player.Next_Glow.Name := 'A_SP_Player_Next_Glow';
  vSoundplayer.player.Next_Glow.Parent := vSoundplayer.player.Next;
  vSoundplayer.player.Next_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.player.Next_Glow.Softness := 0.4;
  vSoundplayer.player.Next_Glow.Opacity := 0.9;
  vSoundplayer.player.Next_Glow.Enabled := False;

  vSoundplayer.player.Next_Grey := TMonochromeEffect.Create(vSoundplayer.player.Next);
  vSoundplayer.player.Next_Grey.Name := 'A_SP_Player_Next_Grey';
  vSoundplayer.player.Next_Grey.Parent := vSoundplayer.player.Next;
  vSoundplayer.player.Next_Grey.Enabled := False;

  vSoundplayer.player.Eject := Timage.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Eject.Name := 'A_SP_Player_Eject_Image';
  vSoundplayer.player.Eject.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Eject.SetBounds(vSoundplayer.player.Next.Position.X + 72, 137, 48, 48);
  vSoundplayer.player.Eject.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_eject.png');
  vSoundplayer.player.Eject.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.player.Eject.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.player.Eject.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.player.Eject.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.player.Eject.Visible := True;

  vSoundplayer.player.Eject_Glow := TGlowEffect.Create(vSoundplayer.player.Eject);
  vSoundplayer.player.Eject_Glow.Name := 'A_SP_Player_Eject_Glow';
  vSoundplayer.player.Eject_Glow.Parent := vSoundplayer.player.Eject;
  vSoundplayer.player.Eject_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.player.Eject_Glow.Softness := 0.4;
  vSoundplayer.player.Eject_Glow.Opacity := 0.9;
  vSoundplayer.player.Eject_Glow.Enabled := False;

  vSoundplayer.player.Loop := Timage.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Loop.Name := 'A_SP_Player_Loop_Image';
  vSoundplayer.player.Loop.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Loop.SetBounds(vSoundplayer.player.Next.Position.X + 202, 137, 48, 48);
  vSoundplayer.player.Loop.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_loop.png');
  vSoundplayer.player.Loop.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.player.Loop.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.player.Loop.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.player.Loop.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.player.Loop.Visible := True;

  vSoundplayer.player.Loop_State := Timage.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Loop_State.Name := 'A_SP_Player_Loop_State_Image';
  vSoundplayer.player.Loop_State.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Loop_State.Width := 0;
  vSoundplayer.player.Loop_State.Height := 0;
  vSoundplayer.player.Loop_State.Position.X := 0;
  vSoundplayer.player.Loop_State.Position.Y := 0;
  vSoundplayer.player.Loop_State.Visible := True;

  vSoundplayer.player.Loop_To := Timage.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Loop_To.Name := 'A_SP_Player_Loop_To_Image';
  vSoundplayer.player.Loop_To.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Loop_To.Width := 10;
  vSoundplayer.player.Loop_To.Height := 10;
  vSoundplayer.player.Loop_To.Position.X := (vSoundplayer.player.Loop.Position.X) +
    (vSoundplayer.player.Loop.Width - 2);
  vSoundplayer.player.Loop_To.Position.Y := (vSoundplayer.player.Loop.Position.Y) - 4;
  vSoundplayer.player.Loop_To.Visible := False;

  vSoundplayer.player.Loop_Glow := TGlowEffect.Create(vSoundplayer.player.Loop);
  vSoundplayer.player.Loop_Glow.Name := 'A_SP_Player_Loop_Glow';
  vSoundplayer.player.Loop_Glow.Parent := vSoundplayer.player.Loop;
  vSoundplayer.player.Loop_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.player.Loop_Glow.Softness := 0.4;
  vSoundplayer.player.Loop_Glow.Opacity := 0.9;
  vSoundplayer.player.Loop_Glow.Enabled := False;

  vSoundplayer.player.Loop_Grey := TMonochromeEffect.Create(vSoundplayer.player.Loop);
  vSoundplayer.player.Loop_Grey.Name := 'A_SP_Player_Loop_Grey';
  vSoundplayer.player.Loop_Grey.Parent := vSoundplayer.player.Loop;
  vSoundplayer.player.Loop_Grey.Enabled := False;

  vSoundplayer.player.Suffle := Timage.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Suffle.Name := 'A_SP_Player_Suffle_Image';
  vSoundplayer.player.Suffle.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Suffle.SetBounds(vSoundplayer.player.Loop.Position.X + 64, 137, 48, 48);
  vSoundplayer.player.Suffle.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_suffle.png');
  vSoundplayer.player.Suffle.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.player.Suffle.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.player.Suffle.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.player.Suffle.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.player.Suffle.Visible := True;

  vSoundplayer.player.Suffle_Glow := TGlowEffect.Create(vSoundplayer.player.Suffle);
  vSoundplayer.player.Suffle_Glow.Name := 'A_SP_Player_Suffle_Glow';
  vSoundplayer.player.Suffle_Glow.Parent := vSoundplayer.player.Suffle;
  vSoundplayer.player.Suffle_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.player.Suffle_Glow.Softness := 0.4;
  vSoundplayer.player.Suffle_Glow.Opacity := 0.9;
  vSoundplayer.player.Suffle_Glow.Enabled := False;

  vSoundplayer.player.Suffle_Grey := TMonochromeEffect.Create(vSoundplayer.player.Suffle);
  vSoundplayer.player.Suffle_Grey.Name := 'A_SP_Player_Suffle_Grey';
  vSoundplayer.player.Suffle_Grey.Parent := vSoundplayer.player.Suffle;
  vSoundplayer.player.Suffle_Grey.Enabled := False;

  vSoundplayer.player.Song_Title := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Song_Title.Name := 'A_SP_Player_SongTitle';
  vSoundplayer.player.Song_Title.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Song_Title.SetBounds(extrafe.res.Half_Width - 800, 18, 1600, 80);
  vSoundplayer.player.Song_Title.Font.Size := 44;
  vSoundplayer.player.Song_Title.Color := TAlphaColorRec.White;
  vSoundplayer.player.Song_Title.Text := '';
  vSoundplayer.player.Song_Title.Visible := True;
  vSoundplayer.player.Song_Title.WordWrap := False;

  vSoundplayer.player.Song_Title_Cover_Left := TRectangle.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Song_Title_Cover_Left.Name := 'A_SP_Player_Title_Cover_Left';
  vSoundplayer.player.Song_Title_Cover_Left.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Song_Title_Cover_Left.SetBounds(0, 14, 465, 88);
  vSoundplayer.player.Song_Title_Cover_Left.Fill.Bitmap.Bitmap.LoadFromFile(addons.soundplayer.Path.Images +
    'sp_back.png');
  vSoundplayer.player.Song_Title_Cover_Left.Fill.Bitmap.WrapMode := TWrapMode.Tile;
  vSoundplayer.player.Song_Title_Cover_Left.Fill.Kind := TBrushKind.Bitmap;
  vSoundplayer.player.Song_Title_Cover_Left.Stroke.Thickness := 0;
  vSoundplayer.player.Song_Title_Cover_Left.Visible := True;

  vSoundplayer.player.Song_Title_Cover_Right := TRectangle.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Song_Title_Cover_Right.Name := 'A_SP_Player_Title_Cover_Right';
  vSoundplayer.player.Song_Title_Cover_Right.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Song_Title_Cover_Right.SetBounds(1465, 14, 465, 88);
  vSoundplayer.player.Song_Title_Cover_Right.Fill.Bitmap.Bitmap.LoadFromFile(addons.soundplayer.Path.Images +
    'sp_back.png');
  vSoundplayer.player.Song_Title_Cover_Right.Fill.Bitmap.WrapMode := TWrapMode.Tile;
  vSoundplayer.player.Song_Title_Cover_Right.Fill.Kind := TBrushKind.Bitmap;
  vSoundplayer.player.Song_Title_Cover_Right.Stroke.Thickness := 0;
  vSoundplayer.player.Song_Title_Cover_Right.Visible := True;

  vSoundplayer.player.Song_Title_Ani := TFloatAnimation.Create(vSoundplayer.player.Song_Title);
  vSoundplayer.player.Song_Title_Ani.Name := 'A_SP_Player_Song_Title_Animation';
  vSoundplayer.player.Song_Title_Ani.Parent := vSoundplayer.player.Song_Title;
  vSoundplayer.player.Song_Title_Ani.Delay := 2;
  vSoundplayer.player.Song_Title_Ani.Duration := 4;
  vSoundplayer.player.Song_Title_Ani.PropertyName := 'Position.X';
  vSoundplayer.player.Song_Title_Ani.AnimationType := TAnimationType.&InOut;
  vSoundplayer.player.Song_Title_Ani.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.player.Song_Title_Ani.Enabled := False;

  for vi := 0 to 4 do
  begin
    vSoundplayer.player.Rate[vi] := Timage.Create(vSoundplayer.scene.Back_Player);
    vSoundplayer.player.Rate[vi].Name := 'A_SP_Player_Rate_' + vi.ToString;
    vSoundplayer.player.Rate[vi].Parent := vSoundplayer.scene.Back_Player;
    vSoundplayer.player.Rate[vi].SetBounds((610 + (vi * 28)), 170, 24, 24);
    vSoundplayer.player.Rate[vi].Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_star.png');
    vSoundplayer.player.Rate[vi].WrapMode := TImageWrapMode.Fit;
    vSoundplayer.player.Rate[vi].Visible := False;

    vSoundplayer.player.Rate_Gray[vi] := TMonochromeEffect.Create(vSoundplayer.player.Rate[vi]);
    vSoundplayer.player.Rate_Gray[vi].Name := 'A_SP_Player_Rate_Grey_' + vi.ToString;
    vSoundplayer.player.Rate_Gray[vi].Parent := vSoundplayer.player.Rate[vi];
    vSoundplayer.player.Rate_Gray[vi].Enabled := False;
  end;

  vSoundplayer.player.Rate_No := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Rate_No.Name := 'A_SP_Player_Rate_No';
  vSoundplayer.player.Rate_No.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Rate_No.SetBounds(610, 170, 140, 30);
  vSoundplayer.player.Rate_No.Font.Size := 22;
  vSoundplayer.player.Rate_No.Text := 'Not Rated Yet.';
  vSoundplayer.player.Rate_No.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.player.Rate_No.Visible := False;

  vSoundplayer.player.Song_Pos := TALTrackbar.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Song_Pos.Name := 'A_SP_SongPos';
  vSoundplayer.player.Song_Pos.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Song_Pos.SetBounds(460, 100, 1000, 30);
  vSoundplayer.player.Song_Pos.Min := 0;
  vSoundplayer.player.Song_Pos.Max := 1000;
  vSoundplayer.player.Song_Pos.BackGround.Fill.Color := TAlphaColorRec.White;
  vSoundplayer.player.Song_Pos.Highlight.Fill.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.player.Song_Pos.Thumb.Name := 'A_SP_SongPos_Thumb';
  vSoundplayer.player.Song_Pos.OnChange := addons.soundplayer.Input.mouse.Trackbar_Thumb.OnChange;
  vSoundplayer.player.Song_Pos.Thumb.OnMouseDown := addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseDown;
  vSoundplayer.player.Song_Pos.Thumb.OnMouseUp := addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseUp;
  vSoundplayer.player.Song_Pos.Thumb.OnMouseMove := addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseMove;
  vSoundplayer.player.Song_Pos.Thumb.OnMouseEnter :=
    addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseEnter;
  vSoundplayer.player.Song_Pos.Thumb.OnMouseLeave :=
    addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseLeave;
  vSoundplayer.player.Song_Pos.Visible := True;

  vSoundplayer.player.Song_Tag := Timage.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Song_Tag.Name := 'A_SP_Player_Tag_Image';
  vSoundplayer.player.Song_Tag.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Song_Tag.SetBounds(1418, 137, 48, 48);
  vSoundplayer.player.Song_Tag.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.player.Song_Tag.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.player.Song_Tag.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.player.Song_Tag.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.player.Song_Tag.Visible := True;

  vSoundplayer.player.Song_Tag_Glow := TGlowEffect.Create(vSoundplayer.player.Song_Tag);
  vSoundplayer.player.Song_Tag_Glow.Name := 'A_SP_Player_Tag_Glow';
  vSoundplayer.player.Song_Tag_Glow.Parent := vSoundplayer.player.Song_Tag;
  vSoundplayer.player.Song_Tag_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.player.Song_Tag_Glow.Softness := 0.4;
  vSoundplayer.player.Song_Tag_Glow.Opacity := 0.9;
  vSoundplayer.player.Song_Tag_Glow.Enabled := False;

  vSoundplayer.player.Song_Time := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Song_Time.Name := 'A_SP_SongTime';
  vSoundplayer.player.Song_Time.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Song_Time.SetBounds(470, 140, 140, 30);
  vSoundplayer.player.Song_Time.Font.Size := 22;
  vSoundplayer.player.Song_Time.Color := TAlphaColorRec.White;
  vSoundplayer.player.Song_Time.Text := '00:00:00';
  vSoundplayer.player.Song_Time.Visible := True;
  vSoundplayer.player.Song_Time.TextSettings.HorzAlign := TTextAlign.Center;

  vSoundplayer.player.Song_PlayTime := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Song_PlayTime.Name := 'A_SP_SongTime_Play';
  vSoundplayer.player.Song_PlayTime.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Song_PlayTime.SetBounds(440, 170, 140, 30);
  vSoundplayer.player.Song_PlayTime.Font.Size := 22;
  vSoundplayer.player.Song_PlayTime.Color := TAlphaColorRec.White;
  vSoundplayer.player.Song_PlayTime.Text := '00:00:00';
  vSoundplayer.player.Song_PlayTime.TextSettings.HorzAlign := TTextAlign.Trailing;
  vSoundplayer.player.Song_PlayTime.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.player.Song_PlayTime.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.player.Song_PlayTime.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.player.Song_PlayTime.Visible := True;

  vSoundplayer.player.Speaker_Left := Timage.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Speaker_Left.Name := 'A_SP_Player_Speaker_Left_Image';
  vSoundplayer.player.Speaker_Left.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Speaker_Left.SetBounds(15, -25, 128, 250);
  vSoundplayer.player.Speaker_Left.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_speaker.png');
  vSoundplayer.player.Speaker_Left.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.player.Speaker_Left.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.player.Speaker_Left.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.player.Speaker_Left.Visible := True;

  vSoundplayer.player.Speaker_Left_Hue := THueAdjustEffect.Create(vSoundplayer.player.Speaker_Left);
  vSoundplayer.player.Speaker_Left_Hue.Name := 'A_SP_Player_Speaker_Left_Hue';
  vSoundplayer.player.Speaker_Left_Hue.Parent := vSoundplayer.player.Speaker_Left;
  vSoundplayer.player.Speaker_Left_Hue.Hue := -1;
  vSoundplayer.player.Speaker_Left_Hue.Enabled := False;

  vSoundplayer.player.Speaker_Left_Percent := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Speaker_Left_Percent.Name := 'A_SP_Player_Speaker_Left_Percent';
  vSoundplayer.player.Speaker_Left_Percent.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Speaker_Left_Percent.SetBounds(29, 10, 100, 24);
  vSoundplayer.player.Speaker_Left_Percent.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.player.Speaker_Left_Percent.Text := '';
  vSoundplayer.player.Speaker_Left_Percent.Visible := True;

  vSoundplayer.player.Speaker_Left_Percent_Ani :=
    TFloatAnimation.Create(vSoundplayer.player.Speaker_Left_Percent);
  vSoundplayer.player.Speaker_Left_Percent_Ani.Name := 'A_SP_Player_Speaker_Left_Percent_Ani';
  vSoundplayer.player.Speaker_Left_Percent_Ani.Parent := vSoundplayer.player.Speaker_Left_Percent;
  vSoundplayer.player.Speaker_Left_Percent_Ani.PropertyName := 'Opacity';
  vSoundplayer.player.Speaker_Left_Percent_Ani.StartValue := 1;
  vSoundplayer.player.Speaker_Left_Percent_Ani.StopValue := 0;
  vSoundplayer.player.Speaker_Left_Percent_Ani.Duration := 2;
  vSoundplayer.player.Speaker_Left_Percent_Ani.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.player.Speaker_Left_Percent_Ani.Enabled := False;

  vSoundplayer.player.Speaker_Left_Volume_Pos := TALTrackbar.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Speaker_Left_Volume_Pos.Name := 'A_SP_Player_Speaker_Left_VolumePos';
  vSoundplayer.player.Speaker_Left_Volume_Pos.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Speaker_Left_Volume_Pos.SetBounds(10, 170, 138, 30);
  vSoundplayer.player.Speaker_Left_Volume_Pos.BackGround.Fill.Color := TAlphaColorRec.White;
  vSoundplayer.player.Speaker_Left_Volume_Pos.Highlight.Fill.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.player.Speaker_Left_Volume_Pos.Thumb.CornerType := TCornerType.Bevel;
  vSoundplayer.player.Speaker_Left_Volume_Pos.Thumb.Name := 'A_SP_Player_Speaker_Left_VolumePos_Thumb';
  vSoundplayer.player.Speaker_Left_Volume_Pos.OnChange := addons.soundplayer.Input.mouse.Trackbar.OnChange;
  vSoundplayer.player.Speaker_Left_Volume_Pos.OnMouseUp := addons.soundplayer.Input.mouse.Trackbar.OnMouseUp;
  vSoundplayer.player.Speaker_Left_Volume_Pos.OnMouseDown :=
    addons.soundplayer.Input.mouse.Trackbar.OnMouseDown;
  vSoundplayer.player.Speaker_Left_Volume_Pos.Thumb.OnMouseEnter :=
    addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseEnter;
  vSoundplayer.player.Speaker_Left_Volume_Pos.Thumb.OnMouseLeave :=
    addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseLeave;
  vSoundplayer.player.Speaker_Left_Volume_Pos.Visible := True;

  vSoundplayer.player.Speaker_Left_Lock_Volume := Timage.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Speaker_Left_Lock_Volume.Name := 'A_SP_Player_Speaker_Lock_Left_Volume';
  vSoundplayer.player.Speaker_Left_Lock_Volume.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Speaker_Left_Lock_Volume.SetBounds(10, 5, 32, 32);
  vSoundplayer.player.Speaker_Left_Lock_Volume.Bitmap.LoadFromFile(addons.soundplayer.Path.Images +
    'sp_lock.png');
  vSoundplayer.player.Speaker_Left_Lock_Volume.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.player.Speaker_Left_Lock_Volume.OnMouseEnter :=
    addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.player.Speaker_Left_Lock_Volume.OnMouseLeave :=
    addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.player.Speaker_Left_Lock_Volume.Visible := True;

  vSoundplayer.player.Speaker_Left_Lock_Volume_Glow :=
    TGlowEffect.Create(vSoundplayer.player.Speaker_Left_Lock_Volume);
  vSoundplayer.player.Speaker_Left_Lock_Volume_Glow.Name := 'A_SP_Player_Speaker_Lock_Left_Volume_Glow';
  vSoundplayer.player.Speaker_Left_Lock_Volume_Glow.Parent := vSoundplayer.player.Speaker_Left_Lock_Volume;
  vSoundplayer.player.Speaker_Left_Lock_Volume_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.player.Speaker_Left_Lock_Volume_Glow.Softness := 0.4;
  vSoundplayer.player.Speaker_Left_Lock_Volume_Glow.Opacity := 0.9;
  vSoundplayer.player.Speaker_Left_Lock_Volume_Glow.Enabled := False;

  vSoundplayer.player.Speaker_Right := Timage.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Speaker_Right.Name := 'A_SP_Player_Speaker_Right_Image';
  vSoundplayer.player.Speaker_Right.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Speaker_Right.SetBounds(vSoundplayer.scene.Back_Player.Width - 143, -25, 128, 250);
  vSoundplayer.player.Speaker_Right.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_speaker.png');
  vSoundplayer.player.Speaker_Right.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.player.Speaker_Right.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.player.Speaker_Right.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.player.Speaker_Right.Visible := True;

  vSoundplayer.player.Speaker_Right_Hue := THueAdjustEffect.Create(vSoundplayer.player.Speaker_Right);
  vSoundplayer.player.Speaker_Right_Hue.Name := 'A_SP_Player_Speaker_Right_Hue';
  vSoundplayer.player.Speaker_Right_Hue.Parent := vSoundplayer.player.Speaker_Right;
  vSoundplayer.player.Speaker_Right_Hue.Hue := -1;
  vSoundplayer.player.Speaker_Right_Hue.Enabled := False;

  vSoundplayer.player.Speaker_Right_Percent := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Speaker_Right_Percent.Name := 'A_SP_Player_Speaker_Right_Percent';
  vSoundplayer.player.Speaker_Right_Percent.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Speaker_Right_Percent.SetBounds(vSoundplayer.scene.Back_Player.Width - 132, 10,
    100, 24);
  vSoundplayer.player.Speaker_Right_Percent.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.player.Speaker_Right_Percent.Text := '';
  vSoundplayer.player.Speaker_Right_Percent.Visible := True;

  vSoundplayer.player.Speaker_Right_Percent_Ani :=
    TFloatAnimation.Create(vSoundplayer.player.Speaker_Right_Percent);
  vSoundplayer.player.Speaker_Right_Percent_Ani.Name := 'A_SP_Player_Speaker_Right_Percent_Ani';
  vSoundplayer.player.Speaker_Right_Percent_Ani.Parent := vSoundplayer.player.Speaker_Right_Percent;
  vSoundplayer.player.Speaker_Right_Percent_Ani.PropertyName := 'Opacity';
  vSoundplayer.player.Speaker_Right_Percent_Ani.StartValue := 1;
  vSoundplayer.player.Speaker_Right_Percent_Ani.StopValue := 0;
  vSoundplayer.player.Speaker_Right_Percent_Ani.Duration := 2;
  vSoundplayer.player.Speaker_Right_Percent_Ani.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.player.Speaker_Right_Percent_Ani.Enabled := False;

  vSoundplayer.player.Speaker_Right_Volume_Pos := TALTrackbar.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Speaker_Right_Volume_Pos.Name := 'A_SP_Player_Speaker_Right_VolumePos';
  vSoundplayer.player.Speaker_Right_Volume_Pos.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Speaker_Right_Volume_Pos.SetBounds(vSoundplayer.scene.Back_Player.Width - 148,
    170, 138, 30);
  vSoundplayer.player.Speaker_Right_Volume_Pos.BackGround.Fill.Color := TAlphaColorRec.White;
  vSoundplayer.player.Speaker_Right_Volume_Pos.Highlight.Fill.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.player.Speaker_Right_Volume_Pos.Thumb.CornerType := TCornerType.Bevel;
  vSoundplayer.player.Speaker_Right_Volume_Pos.Thumb.Name := 'A_SP_Player_Speaker_Right_VolumePos_Thumb';
  vSoundplayer.player.Speaker_Right_Volume_Pos.OnChange := addons.soundplayer.Input.mouse.Trackbar.OnChange;
  vSoundplayer.player.Speaker_Right_Volume_Pos.OnMouseUp := addons.soundplayer.Input.mouse.Trackbar.OnMouseUp;
  vSoundplayer.player.Speaker_Right_Volume_Pos.OnMouseDown :=
    addons.soundplayer.Input.mouse.Trackbar.OnMouseDown;
  vSoundplayer.player.Speaker_Right_Volume_Pos.Thumb.OnMouseEnter :=
    addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseEnter;
  vSoundplayer.player.Speaker_Right_Volume_Pos.Thumb.OnMouseLeave :=
    addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseLeave;
  vSoundplayer.player.Speaker_Right_Volume_Pos.Visible := True;

  vSoundplayer.player.Speaker_Right_Lock_Volume := Timage.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.player.Speaker_Right_Lock_Volume.Name := 'A_SP_Player_Speaker_Lock_Right_Volume';
  vSoundplayer.player.Speaker_Right_Lock_Volume.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.player.Speaker_Right_Lock_Volume.SetBounds(vSoundplayer.scene.Back_Player.Width - 42,
    5, 32, 32);
  vSoundplayer.player.Speaker_Right_Lock_Volume.Bitmap.LoadFromFile(addons.soundplayer.Path.Images +
    'sp_lock.png');
  vSoundplayer.player.Speaker_Right_Lock_Volume.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.player.Speaker_Right_Lock_Volume.OnMouseEnter :=
    addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.player.Speaker_Right_Lock_Volume.OnMouseLeave :=
    addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.player.Speaker_Right_Lock_Volume.Visible := True;

  vSoundplayer.player.Speaker_Right_Lock_Volume_Glow :=
    TGlowEffect.Create(vSoundplayer.player.Speaker_Right_Lock_Volume);
  vSoundplayer.player.Speaker_Right_Lock_Volume_Glow.Name := 'A_SP_Player_Speaker_Lock_Right_Volume_Glow';
  vSoundplayer.player.Speaker_Right_Lock_Volume_Glow.Parent := vSoundplayer.player.Speaker_Right_Lock_Volume;
  vSoundplayer.player.Speaker_Right_Lock_Volume_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.player.Speaker_Right_Lock_Volume_Glow.Softness := 0.4;
  vSoundplayer.player.Speaker_Right_Lock_Volume_Glow.Opacity := 0.9;
  vSoundplayer.player.Speaker_Right_Lock_Volume_Glow.Enabled := False;
end;

procedure uSoundplayer_SetAll_Info;
begin
  vSoundplayer.scene.Back_Info := Timage.Create(vSoundplayer.scene.Back);
  vSoundplayer.scene.Back_Info.Name := 'A_SP_BackInfo_Image';
  vSoundplayer.scene.Back_Info.Parent := vSoundplayer.scene.Back;
  vSoundplayer.scene.Back_Info.SetBounds(0, 220, vSoundplayer.scene.Back.Width,
    (extrafe.res.Height - 410) - 220);
  vSoundplayer.scene.Back_Info.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_ilhm.png');
  vSoundplayer.scene.Back_Info.WrapMode := TImageWrapMode.Center;
  vSoundplayer.scene.Back_Info.Visible := True;

  vSoundplayer.info.Back_Left := Timage.Create(vSoundplayer.scene.Back_Info);
  vSoundplayer.info.Back_Left.Name := 'A_SP_BackInfo_BackLeft_Image';
  vSoundplayer.info.Back_Left.Parent := vSoundplayer.scene.Back_Info;
  vSoundplayer.info.Back_Left.SetBounds(2, 10, 600, vSoundplayer.scene.Back_Info.Height - 20);
  vSoundplayer.info.Back_Left.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_back_info.png');
  vSoundplayer.info.Back_Left.WrapMode := TImageWrapMode.Tile;
  vSoundplayer.info.Back_Left.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.info.Back_Left.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.info.Back_Left.Visible := True;

  vSoundplayer.info.Back_Left_Ani := TFloatAnimation.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Back_Left_Ani.Name := 'A_SP_BackInfo_BackLeft_Animation';
  vSoundplayer.info.Back_Left_Ani.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Back_Left_Ani.Delay := 6;
  vSoundplayer.info.Back_Left_Ani.Duration := 0.6;
  vSoundplayer.info.Back_Left_Ani.PropertyName := 'Position.X';
  vSoundplayer.info.Back_Left_Ani.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.info.Back_Left_Ani.Enabled := False;

  vSoundplayer.info.Song := TText.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Song.Name := 'A_SP_Info_SongTitle';
  vSoundplayer.info.Song.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Song.SetBounds(10, 30, 160, 22);
  vSoundplayer.info.Song.Font.Size := 18;
  vSoundplayer.info.Song.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.info.Song.Text := 'Song Title : ';
  vSoundplayer.info.Song.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.info.Song.Visible := True;

  vSoundplayer.info.Song_Title := TText.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Song_Title.Name := 'A_SP_Info_SongTitle_V';
  vSoundplayer.info.Song_Title.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Song_Title.SetBounds(160, 30, 530, 22);
  vSoundplayer.info.Song_Title.Font.Size := 18;
  vSoundplayer.info.Song_Title.Color := TAlphaColorRec.White;
  vSoundplayer.info.Song_Title.Text := '';
  vSoundplayer.info.Song_Title.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.info.Song_Title.Visible := True;

  vSoundplayer.info.Artist := TText.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Artist.Name := 'A_SP_Info_ArtistName';
  vSoundplayer.info.Artist.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Artist.SetBounds(10, 60, 160, 22);
  vSoundplayer.info.Artist.Font.Size := 18;
  vSoundplayer.info.Artist.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.info.Artist.Text := 'Artist Name : ';
  vSoundplayer.info.Artist.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.info.Artist.Visible := True;

  vSoundplayer.info.Artist_Name := TText.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Artist_Name.Name := 'A_SP_Info_ArtistName_V';
  vSoundplayer.info.Artist_Name.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Artist_Name.SetBounds(160, 60, 530, 22);
  vSoundplayer.info.Artist_Name.Font.Size := 18;
  vSoundplayer.info.Artist_Name.Color := TAlphaColorRec.White;
  vSoundplayer.info.Artist_Name.Text := '';
  vSoundplayer.info.Artist_Name.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.info.Artist_Name.Visible := True;

  vSoundplayer.info.Year := TText.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Year.Name := 'A_SP_Info_YearPublished';
  vSoundplayer.info.Year.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Year.SetBounds(10, 90, 160, 22);
  vSoundplayer.info.Year.Font.Size := 18;
  vSoundplayer.info.Year.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.info.Year.Text := 'Year Published : ';
  vSoundplayer.info.Year.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.info.Year.Visible := True;

  vSoundplayer.info.Year_Publish := TText.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Year_Publish.Name := 'A_SP_Info_YearPublished_V';
  vSoundplayer.info.Year_Publish.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Year_Publish.SetBounds(160, 90, 530, 22);
  vSoundplayer.info.Year_Publish.Font.Size := 18;
  vSoundplayer.info.Year_Publish.Color := TAlphaColorRec.White;
  vSoundplayer.info.Year_Publish.Text := '';
  vSoundplayer.info.Year_Publish.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.info.Year_Publish.Visible := True;

  vSoundplayer.info.Gerne := TText.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Gerne.Name := 'A_SP_Info_GerneType';
  vSoundplayer.info.Gerne.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Gerne.SetBounds(10, 120, 160, 22);
  vSoundplayer.info.Gerne.Font.Size := 18;
  vSoundplayer.info.Gerne.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.info.Gerne.Text := 'Gerne Type : ';
  vSoundplayer.info.Gerne.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.info.Gerne.Visible := True;

  vSoundplayer.info.Gerne_Kind := TText.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Gerne_Kind.Name := 'A_SP_Info_GerneType_V';
  vSoundplayer.info.Gerne_Kind.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Gerne_Kind.SetBounds(160, 120, 530, 22);
  vSoundplayer.info.Gerne_Kind.Font.Size := 18;
  vSoundplayer.info.Gerne_Kind.Color := TAlphaColorRec.White;
  vSoundplayer.info.Gerne_Kind.Text := '';
  vSoundplayer.info.Gerne_Kind.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.info.Gerne_Kind.Visible := True;

  vSoundplayer.info.Track := TText.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Track.Name := 'A_SP_Info_TrackNum';
  vSoundplayer.info.Track.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Track.SetBounds(10, 150, 160, 22);
  vSoundplayer.info.Track.Font.Size := 18;
  vSoundplayer.info.Track.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.info.Track.Text := 'Song Number : ';
  vSoundplayer.info.Track.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.info.Track.Visible := True;

  vSoundplayer.info.Track_Num := TText.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Track_Num.Name := 'A_SP_Info_TrackNum_V';
  vSoundplayer.info.Track_Num.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Track_Num.SetBounds(160, 150, 530, 22);
  vSoundplayer.info.Track_Num.Font.Size := 18;
  vSoundplayer.info.Track_Num.Color := TAlphaColorRec.White;
  vSoundplayer.info.Track_Num.Text := '';
  vSoundplayer.info.Track_Num.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.info.Track_Num.Visible := True;

  vSoundplayer.info.Playlist := TText.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Playlist.Name := 'A_SP_Info_PlaylistName';
  vSoundplayer.info.Playlist.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Playlist.SetBounds(10, 220, 160, 22);
  vSoundplayer.info.Playlist.Font.Size := 18;
  vSoundplayer.info.Playlist.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.info.Playlist.Text := 'Playlist Name : ';
  vSoundplayer.info.Playlist.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.info.Playlist.Visible := True;

  vSoundplayer.info.Playlist_Name := TText.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Playlist_Name.Name := 'A_SP_Info_PlaylistName_V';
  vSoundplayer.info.Playlist_Name.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Playlist_Name.SetBounds(160, 220, 530, 22);
  vSoundplayer.info.Playlist_Name.Font.Size := 18;
  vSoundplayer.info.Playlist_Name.Color := TAlphaColorRec.White;
  vSoundplayer.info.Playlist_Name.Text := '';
  vSoundplayer.info.Playlist_Name.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.info.Playlist_Name.Visible := True;

  vSoundplayer.info.Playlist_Type := TText.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Playlist_Type.Name := 'A_SP_Info_PlaylistType';
  vSoundplayer.info.Playlist_Type.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Playlist_Type.SetBounds(10, 250, 160, 22);
  vSoundplayer.info.Playlist_Type.Font.Size := 18;
  vSoundplayer.info.Playlist_Type.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.info.Playlist_Type.Text := 'Playlist Type : ';
  vSoundplayer.info.Playlist_Type.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.info.Playlist_Type.Visible := True;

  vSoundplayer.info.Playlist_Type_Kind := TText.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Playlist_Type_Kind.Name := 'A_SP_Info_PlaylistType_V';
  vSoundplayer.info.Playlist_Type_Kind.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Playlist_Type_Kind.SetBounds(160, 250, 530, 22);
  vSoundplayer.info.Playlist_Type_Kind.Font.Size := 18;
  vSoundplayer.info.Playlist_Type_Kind.Color := TAlphaColorRec.White;
  vSoundplayer.info.Playlist_Type_Kind.Text := '';
  vSoundplayer.info.Playlist_Type_Kind.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.info.Playlist_Type_Kind.Visible := True;

  vSoundplayer.info.Total := TText.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Total.Name := 'A_SP_Info_TotalTracks';
  vSoundplayer.info.Total.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Total.SetBounds(10, 280, 160, 22);
  vSoundplayer.info.Total.Font.Size := 18;
  vSoundplayer.info.Total.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.info.Total.Text := 'Total Songs : ';
  vSoundplayer.info.Total.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.info.Total.Visible := True;

  vSoundplayer.info.Total_Songs := TText.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Total_Songs.Name := 'A_SP_Info_TotalTracks_V';
  vSoundplayer.info.Total_Songs.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Total_Songs.SetBounds(160, 280, 530, 22);
  vSoundplayer.info.Total_Songs.Font.Size := 18;
  vSoundplayer.info.Total_Songs.Color := TAlphaColorRec.White;
  vSoundplayer.info.Total_Songs.Text := '';
  vSoundplayer.info.Total_Songs.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.info.Total_Songs.Visible := True;

  vSoundplayer.info.Time := TText.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Time.Name := 'A_SP_Info_TotalTime';
  vSoundplayer.info.Time.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Time.SetBounds(10, 310, 160, 22);
  vSoundplayer.info.Time.Font.Size := 18;
  vSoundplayer.info.Time.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.info.Time.Text := 'Total Time : ';
  vSoundplayer.info.Time.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.info.Time.Visible := True;

  vSoundplayer.info.Time_Total := TText.Create(vSoundplayer.info.Back_Left);
  vSoundplayer.info.Time_Total.Name := 'A_SP_Info_TotalTime_V';
  vSoundplayer.info.Time_Total.Parent := vSoundplayer.info.Back_Left;
  vSoundplayer.info.Time_Total.SetBounds(160, 310, 530, 22);
  vSoundplayer.info.Time_Total.Font.Size := 18;
  vSoundplayer.info.Time_Total.Color := TAlphaColorRec.White;
  vSoundplayer.info.Time_Total.Text := '';
  vSoundplayer.info.Time_Total.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.info.Time_Total.Visible := True;
end;

procedure uSoundplayer_SetAll_Playlist;
const
  cPopupItems: array [0 .. 4] of string = ('Edit Tag', 'Move up', 'Move Down', '----------', 'Delete');
var
  vi: Integer;
  vPopup_MenuItem: TMenuItem;
begin
  vSoundplayer.scene.Back_Playlist := Timage.Create(vSoundplayer.scene.Back);
  vSoundplayer.scene.Back_Playlist.Name := 'A_SP_BackPlaylist_Image';
  vSoundplayer.scene.Back_Playlist.Parent := vSoundplayer.scene.Back;
  vSoundplayer.scene.Back_Playlist.SetBounds(0, extrafe.res.Height - 400, vSoundplayer.scene.Back.Width, 260);
  vSoundplayer.scene.Back_Playlist.Visible := True;

  vSoundplayer.Playlist.List := TStringGrid.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.List.Name := 'A_SP_Playlist';
  vSoundplayer.Playlist.List.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.List.SetBounds(0, 0, vSoundplayer.scene.Back_Playlist.Width - 160, 260);
  vSoundplayer.Playlist.List.Images := vSoundplayer.scene.Imglist;
  vSoundplayer.Playlist.List.Options := vSoundplayer.Playlist.List.Options +
    [TGridOption.AlternatingRowBackground, TGridOption.ColLines, TGridOption.RowLines, TGridOption.RowSelect,
    TGridOption.Tabs, TGridOption.Header, TGridOption.AutoDisplacement];
  vSoundplayer.Playlist.List.Options := vSoundplayer.Playlist.List.Options - [TGridOption.Editing];
  vSoundplayer.Playlist.List.OnCellDblClick := addons.soundplayer.Input.mouse.Stringgrid.OnDoubleClick;
  vSoundplayer.Playlist.List.OnMouseDown := addons.soundplayer.Input.mouse.Stringgrid.OnMouseDown;
  vSoundplayer.Playlist.List.Visible := True;

  vSoundplayer.Playlist.List.AddObject(TStringColumn.Create(vSoundplayer.Playlist.List));
  vSoundplayer.Playlist.List.AddObject(TGlyphColumn.Create(vSoundplayer.Playlist.List));
  vSoundplayer.Playlist.List.AddObject(TStringColumn.Create(vSoundplayer.Playlist.List));
  vSoundplayer.Playlist.List.AddObject(TStringColumn.Create(vSoundplayer.Playlist.List));
  vSoundplayer.Playlist.List.AddObject(TStringColumn.Create(vSoundplayer.Playlist.List));
  vSoundplayer.Playlist.List.AddObject(TGlyphColumn.Create(vSoundplayer.Playlist.List));

  vSoundplayer.Playlist.List.Columns[0].Header := 'Num';
  vSoundplayer.Playlist.List.Columns[0].Width := 40;
  vSoundplayer.Playlist.List.Columns[1].Header := 'Act';
  vSoundplayer.Playlist.List.Columns[1].Width := 50;
  vSoundplayer.Playlist.List.Columns[2].Header := 'Song Title';
  vSoundplayer.Playlist.List.Columns[2].Width := 750;
  vSoundplayer.Playlist.List.Columns[3].Header := 'Song Artist';
  vSoundplayer.Playlist.List.Columns[3].Width := 720;
  vSoundplayer.Playlist.List.Columns[4].Header := 'Time';
  vSoundplayer.Playlist.List.Columns[4].Width := 120;
  vSoundplayer.Playlist.List.Columns[5].Header := 'Type';
  vSoundplayer.Playlist.List.Columns[5].Width := 50;

  vSoundplayer.Playlist.List_Popup_Memu := TPopupMenu.Create(vSoundplayer.Playlist.List);
  vSoundplayer.Playlist.List_Popup_Memu.Name := 'A_SP_Playlist_List_Popup_Menu';
  vSoundplayer.Playlist.List_Popup_Memu.Parent := vSoundplayer.Playlist.List;
  vSoundplayer.Playlist.List_Popup_Memu.Images := vSoundplayer.scene.Imglist;

  for vi := 0 to 4 do
  begin
    vPopup_MenuItem := TMenuItem.Create(vSoundplayer.Playlist.List_Popup_Memu);
    vPopup_MenuItem.Name := 'A_SP_Playlist_List_Popup_Item_' + vi.ToString;
    vPopup_MenuItem.Text := cPopupItems[vi];
    case vi of
      0:
        vPopup_MenuItem.ImageIndex := 4;
      1:
        vPopup_MenuItem.ImageIndex := 5;
      2:
        vPopup_MenuItem.ImageIndex := 6;
      3:
        vPopup_MenuItem.ImageIndex := -1;
      4:
        vPopup_MenuItem.ImageIndex := 7;
    end;
    vPopup_MenuItem.OnClick := addons.soundplayer.Input.mouse.Menuitem.OnMouseClick;
    vSoundplayer.Playlist.List_Popup_Memu.AddObject(vPopup_MenuItem);
  end;

  vSoundplayer.Playlist.List.OnSelectCell := addons.soundplayer.Input.mouse.Stringgrid.OnSelectSell;

  vSoundplayer.Playlist.List_Line_Edit_Left := Timage.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.List_Line_Edit_Left.Name := 'A_SP_Playlist_Edit_Left_Line_Image';
  vSoundplayer.Playlist.List_Line_Edit_Left.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.List_Line_Edit_Left.SetBounds(vSoundplayer.Playlist.List.Width, 0, 10,
    vSoundplayer.scene.Back_Playlist.Height);
  vSoundplayer.Playlist.List_Line_Edit_Left.Bitmap.LoadFromFile(addons.soundplayer.Path.Images +
    'sp_spot.png');
  vSoundplayer.Playlist.List_Line_Edit_Left.WrapMode := TImageWrapMode.Stretch;
  vSoundplayer.Playlist.List_Line_Edit_Left.Visible := True;

  vSoundplayer.Playlist.Songs_Edit.Lock := Timage.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.Songs_Edit.Lock.Name := 'A_SP_Playlist_Edit_Songs_Lock';
  vSoundplayer.Playlist.Songs_Edit.Lock.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.Songs_Edit.Lock.SetBounds(vSoundplayer.Playlist.List.Width + 25, 10, 36, 36);
  vSoundplayer.Playlist.Songs_Edit.Lock.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_lock.png');
  vSoundplayer.Playlist.Songs_Edit.Lock.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.Playlist.Songs_Edit.Lock.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.Playlist.Songs_Edit.Lock.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.Playlist.Songs_Edit.Lock.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.Playlist.Songs_Edit.Lock.Visible := True;

  vSoundplayer.Playlist.Songs_Edit.Lock_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Songs_Edit.Lock);
  vSoundplayer.Playlist.Songs_Edit.Lock_Glow.Name := 'A_SP_Playlist_Edit_Songs_Lock_Glow';
  vSoundplayer.Playlist.Songs_Edit.Lock_Glow.Parent := vSoundplayer.Playlist.Songs_Edit.Lock;
  vSoundplayer.Playlist.Songs_Edit.Lock_Glow.Softness := 0.4;
  vSoundplayer.Playlist.Songs_Edit.Lock_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Playlist.Songs_Edit.Lock_Glow.Opacity := 0.9;
  vSoundplayer.Playlist.Songs_Edit.Lock_Glow.Enabled := False;

  vSoundplayer.Playlist.Songs_Edit.Edit := Timage.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.Songs_Edit.Edit.Name := 'A_SP_Playlist_Edit_Songs_Edit';
  vSoundplayer.Playlist.Songs_Edit.Edit.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.Songs_Edit.Edit.SetBounds(vSoundplayer.Playlist.List.Width + 29, 70, 32, 32);
  vSoundplayer.Playlist.Songs_Edit.Edit.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_edit.png');
  vSoundplayer.Playlist.Songs_Edit.Edit.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.Playlist.Songs_Edit.Edit.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.Playlist.Songs_Edit.Edit.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.Playlist.Songs_Edit.Edit.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.Playlist.Songs_Edit.Edit.Visible := True;

  vSoundplayer.Playlist.Songs_Edit.Edit_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Songs_Edit.Edit);
  vSoundplayer.Playlist.Songs_Edit.Edit_Glow.Name := 'A_SP_Playlist_Edit_Songs_Edit_Glow';
  vSoundplayer.Playlist.Songs_Edit.Edit_Glow.Parent := vSoundplayer.Playlist.Songs_Edit.Edit;
  vSoundplayer.Playlist.Songs_Edit.Edit_Glow.Softness := 0.4;
  vSoundplayer.Playlist.Songs_Edit.Edit_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Playlist.Songs_Edit.Edit_Glow.Opacity := 0.9;
  vSoundplayer.Playlist.Songs_Edit.Edit_Glow.Enabled := False;

  vSoundplayer.Playlist.Songs_Edit.Edit_Grey :=
    TMonochromeEffect.Create(vSoundplayer.Playlist.Songs_Edit.Edit);
  vSoundplayer.Playlist.Songs_Edit.Edit_Grey.Name := 'A_SP_Playlist_Edit_Songs_Edit_Grey';
  vSoundplayer.Playlist.Songs_Edit.Edit_Grey.Parent := vSoundplayer.Playlist.Songs_Edit.Edit;
  vSoundplayer.Playlist.Songs_Edit.Edit_Grey.Enabled := True;

  vSoundplayer.Playlist.Songs_Edit.Up := Timage.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.Songs_Edit.Up.Name := 'A_SP_Playlist_Edit_Songs_Up';
  vSoundplayer.Playlist.Songs_Edit.Up.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.Songs_Edit.Up.SetBounds(vSoundplayer.Playlist.List.Width + 29, 125, 32, 32);
  vSoundplayer.Playlist.Songs_Edit.Up.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_up.png');
  vSoundplayer.Playlist.Songs_Edit.Up.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.Playlist.Songs_Edit.Up.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.Playlist.Songs_Edit.Up.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.Playlist.Songs_Edit.Up.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.Playlist.Songs_Edit.Up.Visible := True;

  vSoundplayer.Playlist.Songs_Edit.Up_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Songs_Edit.Up);
  vSoundplayer.Playlist.Songs_Edit.Up_Glow.Name := 'A_SP_Playlist_Edit_Songs_Up_Glow';
  vSoundplayer.Playlist.Songs_Edit.Up_Glow.Parent := vSoundplayer.Playlist.Songs_Edit.Up;
  vSoundplayer.Playlist.Songs_Edit.Up_Glow.Softness := 0.4;
  vSoundplayer.Playlist.Songs_Edit.Up_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Playlist.Songs_Edit.Up_Glow.Opacity := 0.9;
  vSoundplayer.Playlist.Songs_Edit.Up_Glow.Enabled := False;

  vSoundplayer.Playlist.Songs_Edit.Up_Grey := TMonochromeEffect.Create(vSoundplayer.Playlist.Songs_Edit.Up);
  vSoundplayer.Playlist.Songs_Edit.Up_Grey.Name := 'A_SP_Playlist_Edit_Songs_Up_Grey';
  vSoundplayer.Playlist.Songs_Edit.Up_Grey.Parent := vSoundplayer.Playlist.Songs_Edit.Up;
  vSoundplayer.Playlist.Songs_Edit.Up_Grey.Enabled := True;

  vSoundplayer.Playlist.Songs_Edit.Down := Timage.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.Songs_Edit.Down.Name := 'A_SP_Playlist_Edit_Songs_Down';
  vSoundplayer.Playlist.Songs_Edit.Down.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.Songs_Edit.Down.SetBounds(vSoundplayer.Playlist.List.Width + 29, 158, 32, 32);
  vSoundplayer.Playlist.Songs_Edit.Down.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_down.png');
  vSoundplayer.Playlist.Songs_Edit.Down.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.Playlist.Songs_Edit.Down.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.Playlist.Songs_Edit.Down.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.Playlist.Songs_Edit.Down.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.Playlist.Songs_Edit.Down.Visible := True;

  vSoundplayer.Playlist.Songs_Edit.Down_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Songs_Edit.Down);
  vSoundplayer.Playlist.Songs_Edit.Down_Glow.Name := 'A_SP_Playlist_Edit_Songs_Down_Glow';
  vSoundplayer.Playlist.Songs_Edit.Down_Glow.Parent := vSoundplayer.Playlist.Songs_Edit.Down;
  vSoundplayer.Playlist.Songs_Edit.Down_Glow.Softness := 0.4;
  vSoundplayer.Playlist.Songs_Edit.Down_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Playlist.Songs_Edit.Down_Glow.Opacity := 0.9;
  vSoundplayer.Playlist.Songs_Edit.Down_Glow.Enabled := False;

  vSoundplayer.Playlist.Songs_Edit.Down_Grey :=
    TMonochromeEffect.Create(vSoundplayer.Playlist.Songs_Edit.Down);
  vSoundplayer.Playlist.Songs_Edit.Down_Grey.Name := 'A_SP_Playlist_Edit_Songs_Down_Grey';
  vSoundplayer.Playlist.Songs_Edit.Down_Grey.Parent := vSoundplayer.Playlist.Songs_Edit.Down;
  vSoundplayer.Playlist.Songs_Edit.Down_Grey.Enabled := True;

  vSoundplayer.Playlist.Songs_Edit.Delete := Timage.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.Songs_Edit.Delete.Name := 'A_SP_Playlist_Edit_Songs_Delete';
  vSoundplayer.Playlist.Songs_Edit.Delete.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.Songs_Edit.Delete.SetBounds(vSoundplayer.Playlist.List.Width + 29,
    vSoundplayer.Playlist.List.Height - 45, 32, 32);
  vSoundplayer.Playlist.Songs_Edit.Delete.Bitmap.LoadFromFile(addons.soundplayer.Path.Images +
    'sp_delete.png');
  vSoundplayer.Playlist.Songs_Edit.Delete.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.Playlist.Songs_Edit.Delete.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.Playlist.Songs_Edit.Delete.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.Playlist.Songs_Edit.Delete.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.Playlist.Songs_Edit.Delete.Visible := True;

  vSoundplayer.Playlist.Songs_Edit.Delete_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Songs_Edit.Delete);
  vSoundplayer.Playlist.Songs_Edit.Delete_Glow.Name := 'A_SP_Playlist_Edit_Songs_Delete_Glow';
  vSoundplayer.Playlist.Songs_Edit.Delete_Glow.Parent := vSoundplayer.Playlist.Songs_Edit.Delete;
  vSoundplayer.Playlist.Songs_Edit.Delete_Glow.Softness := 0.4;
  vSoundplayer.Playlist.Songs_Edit.Delete_Glow.GlowColor := TAlphaColorRec.Red;
  vSoundplayer.Playlist.Songs_Edit.Delete_Glow.Opacity := 0.9;
  vSoundplayer.Playlist.Songs_Edit.Delete_Glow.Enabled := False;

  vSoundplayer.Playlist.Songs_Edit.Delete_Grey :=
    TMonochromeEffect.Create(vSoundplayer.Playlist.Songs_Edit.Delete);
  vSoundplayer.Playlist.Songs_Edit.Delete_Grey.Name := 'A_SP_Playlist_Edit_Songs_Delete_Grey';
  vSoundplayer.Playlist.Songs_Edit.Delete_Grey.Parent := vSoundplayer.Playlist.Songs_Edit.Delete;
  vSoundplayer.Playlist.Songs_Edit.Delete_Grey.Enabled := True;

  vSoundplayer.Playlist.List_Line_Edit_Right := Timage.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.List_Line_Edit_Right.Name := 'A_SP_Playlist_Edit_Right_Line_Image';
  vSoundplayer.Playlist.List_Line_Edit_Right.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.List_Line_Edit_Right.SetBounds(vSoundplayer.Playlist.List.Width + 80, 0, 10,
    vSoundplayer.scene.Back_Playlist.Height);
  vSoundplayer.Playlist.List_Line_Edit_Right.Bitmap.LoadFromFile(addons.soundplayer.Path.Images +
    'sp_spot.png');
  vSoundplayer.Playlist.List_Line_Edit_Right.WrapMode := TImageWrapMode.Stretch;
  vSoundplayer.Playlist.List_Line_Edit_Right.Visible := True;

  vSoundplayer.Playlist.Manage_Icon := Timage.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.Manage_Icon.Name := 'A_SP_Playlist_Manage_Image';
  vSoundplayer.Playlist.Manage_Icon.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.Manage_Icon.SetBounds(vSoundplayer.Playlist.List.Width + 108, 10, 32, 32);
  vSoundplayer.Playlist.Manage_Icon.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_list.png');
  vSoundplayer.Playlist.Manage_Icon.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.Playlist.Manage_Icon.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.Playlist.Manage_Icon.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.Playlist.Manage_Icon.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.Playlist.Manage_Icon.Visible := True;

  vSoundplayer.Playlist.Manage_Icon_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Manage_Icon);
  vSoundplayer.Playlist.Manage_Icon_Glow.Name := 'A_SP_Playlist_Manage_Glow';
  vSoundplayer.Playlist.Manage_Icon_Glow.Parent := vSoundplayer.Playlist.Manage_Icon;
  vSoundplayer.Playlist.Manage_Icon_Glow.Softness := 0.4;
  vSoundplayer.Playlist.Manage_Icon_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Playlist.Manage_Icon_Glow.Opacity := 0.9;
  vSoundplayer.Playlist.Manage_Icon_Glow.Enabled := False;

  vSoundplayer.Playlist.Manage_Icon_Grey := TMonochromeEffect.Create(vSoundplayer.Playlist.Manage_Icon);
  vSoundplayer.Playlist.Manage_Icon_Grey.Name := 'A_SP_Playlist_Manage_Grey';
  vSoundplayer.Playlist.Manage_Icon_Grey.Parent := vSoundplayer.Playlist.Manage_Icon;
  vSoundplayer.Playlist.Manage_Icon_Grey.Enabled := False;

  vSoundplayer.Playlist.Create_Icon := Timage.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.Create_Icon.Name := 'A_SP_Playlist_Add_Image';
  vSoundplayer.Playlist.Create_Icon.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.Create_Icon.SetBounds(vSoundplayer.Playlist.List.Width + 108, 62, 32, 32);
  vSoundplayer.Playlist.Create_Icon.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_add.png');
  vSoundplayer.Playlist.Create_Icon.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.Playlist.Create_Icon.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.Playlist.Create_Icon.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.Playlist.Create_Icon.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.Playlist.Create_Icon.Visible := True;

  vSoundplayer.Playlist.Create_Icon_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Create_Icon);
  vSoundplayer.Playlist.Create_Icon_Glow.Name := 'A_SP_Playlist_Add_Glow';
  vSoundplayer.Playlist.Create_Icon_Glow.Parent := vSoundplayer.Playlist.Create_Icon;
  vSoundplayer.Playlist.Create_Icon_Glow.Softness := 0.4;
  vSoundplayer.Playlist.Create_Icon_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Playlist.Create_Icon_Glow.Opacity := 0.9;
  vSoundplayer.Playlist.Create_Icon_Glow.Enabled := False;

  vSoundplayer.Playlist.Remove_Icon := Timage.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.Remove_Icon.Name := 'A_SP_Playlist_Remove_Image';
  vSoundplayer.Playlist.Remove_Icon.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.Remove_Icon.SetBounds(vSoundplayer.Playlist.List.Width + 108, 114, 32, 32);
  vSoundplayer.Playlist.Remove_Icon.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_remove.png');
  vSoundplayer.Playlist.Remove_Icon.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.Playlist.Remove_Icon.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.Playlist.Remove_Icon.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.Playlist.Remove_Icon.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.Playlist.Remove_Icon.Visible := True;

  vSoundplayer.Playlist.Remove_Icon_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Remove_Icon);
  vSoundplayer.Playlist.Remove_Icon_Glow.Name := 'A_SP_Playlist_Remove_Glow';
  vSoundplayer.Playlist.Remove_Icon_Glow.Parent := vSoundplayer.Playlist.Remove_Icon;
  vSoundplayer.Playlist.Remove_Icon_Glow.Softness := 0.4;
  vSoundplayer.Playlist.Remove_Icon_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Playlist.Remove_Icon_Glow.Opacity := 0.9;
  vSoundplayer.Playlist.Remove_Icon_Glow.Enabled := False;

  vSoundplayer.Playlist.Remove_Icon_Grey := TMonochromeEffect.Create(vSoundplayer.Playlist.Remove_Icon);
  vSoundplayer.Playlist.Remove_Icon_Grey.Name := 'A_SP_Playlist_Remove_Grey';
  vSoundplayer.Playlist.Remove_Icon_Grey.Parent := vSoundplayer.Playlist.Remove_Icon;
  vSoundplayer.Playlist.Remove_Icon_Grey.Enabled := False;
end;

procedure uSoundplayer_SetAll_Cover;
begin
  vSoundplayer.info.Back_Right := Timage.Create(vSoundplayer.scene.Back);
  vSoundplayer.info.Back_Right.Name := 'A_SP_BackInfo_BackRight_Image';
  vSoundplayer.info.Back_Right.Parent := vSoundplayer.scene.Back;
  vSoundplayer.info.Back_Right.SetBounds(vSoundplayer.scene.Back_Info.Width - 602,
    vSoundplayer.scene.Back_Info.Position.Y + 10, 600, vSoundplayer.scene.Back_Info.Height - 20);
  vSoundplayer.info.Back_Right.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_back_info.png');
  vSoundplayer.info.Back_Right.WrapMode := TImageWrapMode.Tile;
  vSoundplayer.info.Back_Right.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.info.Back_Right.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.info.Back_Right.Visible := True;

  vSoundplayer.info.Back_Right_Ani := TFloatAnimation.Create(vSoundplayer.info.Back_Right);
  vSoundplayer.info.Back_Right_Ani.Name := 'A_SP_BackInfo_BackRight_Animation';
  vSoundplayer.info.Back_Right_Ani.Parent := vSoundplayer.info.Back_Right;
  vSoundplayer.info.Back_Right_Ani.Delay := 6;
  vSoundplayer.info.Back_Right_Ani.Duration := 0.6;
  vSoundplayer.info.Back_Right_Ani.PropertyName := 'Position.X';
  vSoundplayer.info.Back_Right_Ani.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.info.Back_Right_Ani.Enabled := False;

  vSoundplayer.info.Cover := Timage.Create(vSoundplayer.info.Back_Right);
  vSoundplayer.info.Cover.Name := 'A_SP_Info_Cover';
  vSoundplayer.info.Cover.Parent := vSoundplayer.info.Back_Right;
  vSoundplayer.info.Cover.SetBounds(50, 50, 500, vSoundplayer.info.Back_Right.Height - 100);
  vSoundplayer.info.Cover.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_nocover.png');
  vSoundplayer.info.Cover.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.info.Cover.Visible := True;

  vSoundplayer.info.Cover_Fade_Ani := TFloatAnimation.Create(vSoundplayer.info.Cover);
  vSoundplayer.info.Cover_Fade_Ani.Name := 'A_SP_Info_Cover_Fade_Animation';
  vSoundplayer.info.Cover_Fade_Ani.Parent := vSoundplayer.info.Cover;
  vSoundplayer.info.Cover_Fade_Ani.Duration := 0.4;
  vSoundplayer.info.Cover_Fade_Ani.PropertyName := 'Opacity';
  vSoundplayer.info.Cover_Fade_Ani.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.info.Cover_Fade_Ani.Enabled := False;

  vSoundplayer.info.Cover_Fullscreen := Timage.Create(vSoundplayer.info.Back_Right);
  vSoundplayer.info.Cover_Fullscreen.Name := 'A_SP_Info_Cover_Fullscreen';
  vSoundplayer.info.Cover_Fullscreen.Parent := vSoundplayer.info.Back_Right;
  vSoundplayer.info.Cover_Fullscreen.SetBounds(40, 20, 48, 48);
  vSoundplayer.info.Cover_Fullscreen.Bitmap.LoadFromFile(addons.soundplayer.Path.Images +
    'sp_fullscreen.png');
  vSoundplayer.info.Cover_Fullscreen.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.info.Cover_Fullscreen.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.info.Cover_Fullscreen.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.info.Cover_Fullscreen.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.info.Cover_Fullscreen.Visible := True;

  vSoundplayer.info.Cover_Fullscreen_Glow := TGlowEffect.Create(vSoundplayer.info.Cover_Fullscreen);
  vSoundplayer.info.Cover_Fullscreen_Glow.Name := 'A_SP_Info_Cover_Fullscreen_Glow';
  vSoundplayer.info.Cover_Fullscreen_Glow.Parent := vSoundplayer.info.Cover_Fullscreen;
  vSoundplayer.info.Cover_Fullscreen_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.info.Cover_Fullscreen_Glow.Softness := 0.4;
  vSoundplayer.info.Cover_Fullscreen_Glow.Opacity := 0.9;
  vSoundplayer.info.Cover_Fullscreen_Glow.Enabled := False;

  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_X := TFloatAnimation.Create(vSoundplayer.info.Back_Right);
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_X.Name := 'A_SP_Info_Cover_Fullscreen_Animation_Pos_X';
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_X.Parent := vSoundplayer.info.Back_Right;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_X.Duration := 0.2;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_X.PropertyName := 'Position.X';
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_X.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_X.Enabled := False;

  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_Y := TFloatAnimation.Create(vSoundplayer.info.Back_Right);
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_Y.Name := 'A_SP_Info_Cover_Fullscreen_Animation_Pos_Y';
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_Y.Parent := vSoundplayer.info.Back_Right;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_Y.Duration := 0.2;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_Y.PropertyName := 'Position.Y';
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_Y.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_Y.Enabled := False;

  vSoundplayer.info.Cover_Fullscreen_Ani_Width := TFloatAnimation.Create(vSoundplayer.info.Back_Right);
  vSoundplayer.info.Cover_Fullscreen_Ani_Width.Name := 'A_SP_Info_Cover_Fullscreen_Animation_Width';
  vSoundplayer.info.Cover_Fullscreen_Ani_Width.Parent := vSoundplayer.info.Back_Right;
  vSoundplayer.info.Cover_Fullscreen_Ani_Width.Duration := 0.2;
  vSoundplayer.info.Cover_Fullscreen_Ani_Width.PropertyName := 'Width';
  vSoundplayer.info.Cover_Fullscreen_Ani_Width.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.info.Cover_Fullscreen_Ani_Width.Enabled := False;

  vSoundplayer.info.Cover_Fullscreen_Ani_Height := TFloatAnimation.Create(vSoundplayer.info.Back_Right);
  vSoundplayer.info.Cover_Fullscreen_Ani_Height.Name := 'A_SP_Info_Cover_Fullscreen_Animation_Height';
  vSoundplayer.info.Cover_Fullscreen_Ani_Height.Parent := vSoundplayer.info.Back_Right;
  vSoundplayer.info.Cover_Fullscreen_Ani_Height.Duration := 0.2;
  vSoundplayer.info.Cover_Fullscreen_Ani_Height.PropertyName := 'Height';
  vSoundplayer.info.Cover_Fullscreen_Ani_Height.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.info.Cover_Fullscreen_Ani_Height.Enabled := False;
end;

///
procedure uSoundplayer_SetRemoveSongDialog;
begin
  vSoundplayer.Playlist.Remove_Song.Remove := TPanel.Create(vSoundplayer.scene.soundplayer);
  vSoundplayer.Playlist.Remove_Song.Remove.Name := 'A_SP_Playlist_Edit_Song_Remove';
  vSoundplayer.Playlist.Remove_Song.Remove.Parent := vSoundplayer.scene.soundplayer;
  vSoundplayer.Playlist.Remove_Song.Remove.SetBounds(extrafe.res.Half_Width - 250,
    extrafe.res.Half_Height - 75, 500, 140);
  vSoundplayer.Playlist.Remove_Song.Remove.Visible := True;

  uLoad_SetAll_CreateHeader(vSoundplayer.Playlist.Remove_Song.Remove, 'A_SP_Playlist_Edit_Song_Remove',
    addons.soundplayer.Path.Images + 'sp_note.png', 'emove this song from the playlist?');

  vSoundplayer.Playlist.Remove_Song.main.Panel := TPanel.Create(vSoundplayer.Playlist.Remove_Song.Remove);
  vSoundplayer.Playlist.Remove_Song.main.Panel.Name := 'A_SP_Playlist_Edit_Song_Remove_Main';
  vSoundplayer.Playlist.Remove_Song.main.Panel.Parent := vSoundplayer.Playlist.Remove_Song.Remove;
  vSoundplayer.Playlist.Remove_Song.main.Panel.SetBounds(0, 30,
    vSoundplayer.Playlist.Remove_Song.Remove.Width, vSoundplayer.Playlist.Remove_Song.Remove.Height - 30);
  vSoundplayer.Playlist.Remove_Song.main.Panel.Visible := True;

  vSoundplayer.Playlist.Remove_Song.main.Icon := Timage.Create(vSoundplayer.Playlist.Remove_Song.main.Panel);
  vSoundplayer.Playlist.Remove_Song.main.Icon.Name := 'A_SP_Playlist_Edit_Song_Remove_Icon';
  vSoundplayer.Playlist.Remove_Song.main.Icon.Parent := vSoundplayer.Playlist.Remove_Song.main.Panel;
  vSoundplayer.Playlist.Remove_Song.main.Icon.SetBounds(20, 20, 36, 36);
  vSoundplayer.Playlist.Remove_Song.main.Icon.Bitmap.LoadFromFile(addons.soundplayer.Path.Images +
    'sp_warning.png');
  vSoundplayer.Playlist.Remove_Song.main.Icon.Visible := True;

  vSoundplayer.Playlist.Remove_Song.main.Text := TLabel.Create(vSoundplayer.Playlist.Remove_Song.main.Panel);
  vSoundplayer.Playlist.Remove_Song.main.Text.Name := 'A_SP_Playlist_Edit_Song_Remove_Text';
  vSoundplayer.Playlist.Remove_Song.main.Text.Parent := vSoundplayer.Playlist.Remove_Song.main.Panel;
  vSoundplayer.Playlist.Remove_Song.main.Text.SetBounds(70, 28, 420, 24);
  vSoundplayer.Playlist.Remove_Song.main.Text.Text := 'Do you want to remove the "' +
    addons.soundplayer.Playlist.List.Song_Info[vSoundplayer.Playlist.List.Selected].Title + '" ?';
  vSoundplayer.Playlist.Remove_Song.main.Text.Font.Style :=
    vSoundplayer.Playlist.Remove_Song.main.Text.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.Playlist.Remove_Song.main.Text.Visible := True;

  vSoundplayer.Playlist.Remove_Song.main.Erase :=
    TButton.Create(vSoundplayer.Playlist.Remove_Song.main.Panel);
  vSoundplayer.Playlist.Remove_Song.main.Erase.Name := 'A_SP_Playlist_Edit_Song_Remove_Erase';
  vSoundplayer.Playlist.Remove_Song.main.Erase.Parent := vSoundplayer.Playlist.Remove_Song.main.Panel;
  vSoundplayer.Playlist.Remove_Song.main.Erase.SetBounds(100,
    vSoundplayer.Playlist.Remove_Song.main.Panel.Height - 34, 100, 24);
  vSoundplayer.Playlist.Remove_Song.main.Erase.Text := 'Remove';
  vSoundplayer.Playlist.Remove_Song.main.Erase.OnClick := addons.soundplayer.Input.mouse.Button.OnMouseClick;
  vSoundplayer.Playlist.Remove_Song.main.Erase.Visible := True;

  vSoundplayer.Playlist.Remove_Song.main.Cancel :=
    TButton.Create(vSoundplayer.Playlist.Remove_Song.main.Panel);
  vSoundplayer.Playlist.Remove_Song.main.Cancel.Name := 'A_SP_Playlist_Edit_Song_Remove_Cancel';
  vSoundplayer.Playlist.Remove_Song.main.Cancel.Parent := vSoundplayer.Playlist.Remove_Song.main.Panel;
  vSoundplayer.Playlist.Remove_Song.main.Cancel.SetBounds(vSoundplayer.Playlist.Remove_Song.main.Panel.Width -
    200, vSoundplayer.Playlist.Remove_Song.main.Panel.Height - 34, 100, 24);
  vSoundplayer.Playlist.Remove_Song.main.Cancel.Text := 'Cancel';
  vSoundplayer.Playlist.Remove_Song.main.Cancel.OnClick := addons.soundplayer.Input.mouse.Button.OnMouseClick;
  vSoundplayer.Playlist.Remove_Song.main.Cancel.Visible := True;
end;

end.
