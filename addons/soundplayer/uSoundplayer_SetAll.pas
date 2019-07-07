unit uSoundplayer_SetAll;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UITypes,
  FMX.Objects,
  FMX.Dialogs,
  FMX.Grid,
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
  ALFMXObjects,
  ALFmxStdCtrls,
  main;

procedure Set_First;
procedure Set_Scene;

procedure Player;
procedure Info;
procedure Playlist;
procedure Cover;

procedure Band_Information;
procedure Lyrics;
procedure Album_Information;

procedure RemoveSong_Dialog;

implementation

uses
  uLoad,
  uSnippet_Text,
  uLoad_AllTypes,
  uMain_SetAll,
  uMain_AllTypes,
  uSoundplayer_AllTypes,
  uSoundplayer,
  uSoundplayer_Mouse,
  uSoundplayer_Player,
  uSoundplayer_Playlist,
  BASS;

Procedure Set_Scene;
var
  vi: Integer;
begin
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
  vSoundplayer.scene.Back.SetBounds(0, 0, vSoundplayer.scene.soundplayer.Width, vSoundplayer.scene.soundplayer.Height);
  vSoundplayer.scene.Back.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_back.png');
  vSoundplayer.scene.Back.WrapMode := TImageWrapMode.Tile;
  vSoundplayer.scene.Back.Visible := True;

  vSoundplayer.scene.Back_Blur := TGaussianBlurEffect.Create(vSoundplayer.scene.Back);
  vSoundplayer.scene.Back_Blur.Name := 'A_SP_Back_Blur';
  vSoundplayer.scene.Back_Blur.Parent := vSoundplayer.scene.Back;
  vSoundplayer.scene.Back_Blur.BlurAmount := 0.5;
  vSoundplayer.scene.Back_Blur.Enabled := False;

  vSoundplayer.scene.Back_Presentation := Timage.Create(vSoundplayer.scene.soundplayer);
  vSoundplayer.scene.Back_Presentation.Name := 'A_SP_Presentation';
  vSoundplayer.scene.Back_Presentation.Parent := vSoundplayer.scene.soundplayer;
  vSoundplayer.scene.Back_Presentation.SetBounds(extrafe.res.Half_Width - 700, 20, 1400, 900);
  vSoundplayer.scene.Back_Presentation.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_back_info.png');
  vSoundplayer.scene.Back_Presentation.WrapMode := TImageWrapMode.Tile;
  vSoundplayer.scene.Back_Presentation.Visible := False;

  // Up Line
  vSoundplayer.scene.UpLine := Timage.Create(vSoundplayer.scene.Back);
  vSoundplayer.scene.UpLine.Name := 'A_SP_UpLine_Image';
  vSoundplayer.scene.UpLine.Parent := vSoundplayer.scene.Back;
  vSoundplayer.scene.UpLine.SetBounds(0, 0, vSoundplayer.scene.soundplayer.Width, 10);
  vSoundplayer.scene.UpLine.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_spot.png');
  vSoundplayer.scene.UpLine.WrapMode := TImageWrapMode.Tile;
  vSoundplayer.scene.UpLine.Visible := True;

  Player;

  // Middle Line
  vSoundplayer.scene.MiddleLine := Timage.Create(vSoundplayer.scene.Back);
  vSoundplayer.scene.MiddleLine.Name := 'A_SP_MiddleLine_Image';
  vSoundplayer.scene.MiddleLine.Parent := vSoundplayer.scene.Back;
  vSoundplayer.scene.MiddleLine.SetBounds(0, 210, vSoundplayer.scene.Back.Width, 10);
  vSoundplayer.scene.MiddleLine.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_spot.png');
  vSoundplayer.scene.MiddleLine.WrapMode := TImageWrapMode.Tile;
  vSoundplayer.scene.MiddleLine.Visible := True;

  Info;

  // Playlist line
  vSoundplayer.scene.PlaylistLine := Timage.Create(vSoundplayer.scene.Back);
  vSoundplayer.scene.PlaylistLine.Name := 'A_SP_PlaylistLine_Image';
  vSoundplayer.scene.PlaylistLine.Parent := vSoundplayer.scene.Back;
  vSoundplayer.scene.PlaylistLine.SetBounds(0, extrafe.res.Height - 410, vSoundplayer.scene.Back.Width, 10);
  vSoundplayer.scene.PlaylistLine.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_spot.png');
  vSoundplayer.scene.PlaylistLine.WrapMode := TImageWrapMode.Tile;
  vSoundplayer.scene.PlaylistLine.Visible := True;

  Playlist;

  vSoundplayer.scene.Settings := Timage.Create(vSoundplayer.scene.Back);
  vSoundplayer.scene.Settings.Name := 'A_SP_Settings_Image';
  vSoundplayer.scene.Settings.Parent := vSoundplayer.scene.Back;
  vSoundplayer.scene.Settings.SetBounds(vSoundplayer.scene.Back.Width - 60, vSoundplayer.scene.Back.Height - 70, 50, 50);
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
  vSoundplayer.scene.DownLine.SetBounds(0, vSoundplayer.scene.soundplayer.Height - 10, vSoundplayer.scene.soundplayer.Width, 10);
  vSoundplayer.scene.DownLine.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_spot.png');
  vSoundplayer.scene.DownLine.WrapMode := TImageWrapMode.Tile;
  vSoundplayer.scene.DownLine.Visible := True;

  // Last the cover for can do fullscreen
  Cover;

  vSoundplayer.scene.OpenDialog := TOpenDialog.Create(vSoundplayer.scene.soundplayer);
  vSoundplayer.scene.OpenDialog.Name := 'A_SP_OpenDialog_AddSongs';
  vSoundplayer.scene.OpenDialog.Parent := vSoundplayer.scene.soundplayer;
  vSoundplayer.scene.OpenDialog.Options := vSoundplayer.scene.OpenDialog.Options + [TOpenOption.ofAllowMultiSelect, TOpenOption.ofPathMustExist,
    TOpenOption.ofFileMustExist];
  vSoundplayer.scene.OpenDialog.OnClose := vSoundplayer.scene.Dialog.OnClose;
  vSoundplayer.scene.OpenDialog.OnShow := vSoundplayer.scene.Dialog.OnShow;

  vSoundplayer.timer.Song := TTimer.Create(vSoundplayer.scene.soundplayer);
  vSoundplayer.timer.Song.Name := 'A_SP_Timer_Song';
  vSoundplayer.timer.Song.Parent := vSoundplayer.scene.soundplayer;
  vSoundplayer.timer.Song.Interval := 100;
  vSoundplayer.timer.Song.OnTimer := vSoundplayer.timer.timer.OnTimer;
  vSoundplayer.timer.Song.Enabled := False;

  uSoundplayer.Load;
end;

procedure Player;
var
  vi: Integer;
begin
  vSoundplayer.scene.Back_Player := Timage.Create(vSoundplayer.scene.Back);
  vSoundplayer.scene.Back_Player.Name := 'A_SP_BackPlayer_Image';
  vSoundplayer.scene.Back_Player.Parent := vSoundplayer.scene.Back;
  vSoundplayer.scene.Back_Player.SetBounds(0, 10, vSoundplayer.scene.soundplayer.Width, 200);
  vSoundplayer.scene.Back_Player.Visible := True;

  vSoundplayer.Player.Play := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Play.Name := 'A_SP_Player_Play';
  vSoundplayer.Player.Play.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Play.SetBounds((extrafe.res.Width / 2) - 32, 137, 48, 48);
  vSoundplayer.Player.Play.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Player.Play.Text := #$ea1c;
  vSoundplayer.Player.Play.TextSettings.Font.Size := 48;
  vSoundplayer.Player.Play.TextSettings.FontColor := TAlphaColorRec.Grey;
  vSoundplayer.Player.Play.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Player.Play.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Player.Play.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Player.Play.Visible := True;

  vSoundplayer.Player.Play_Glow := TGlowEffect.Create(vSoundplayer.Player.Play);
  vSoundplayer.Player.Play_Glow.Name := 'A_SP_Player_Play_Glow';
  vSoundplayer.Player.Play_Glow.Parent := vSoundplayer.Player.Play;
  vSoundplayer.Player.Play_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Play_Glow.Softness := 0.4;
  vSoundplayer.Player.Play_Glow.Opacity := 0.9;
  vSoundplayer.Player.Play_Glow.Enabled := False;

  vSoundplayer.Player.Stop := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Stop.Name := 'A_SP_Player_Stop';
  vSoundplayer.Player.Stop.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Stop.SetBounds(vSoundplayer.Player.Play.Position.X - 62, 137, 48, 48);
  vSoundplayer.Player.Stop.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Player.Stop.Text := #$ea1e;
  vSoundplayer.Player.Stop.TextSettings.Font.Size := 48;
  vSoundplayer.Player.Stop.TextSettings.FontColor := TAlphaColorRec.Grey;
  vSoundplayer.Player.Stop.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Player.Stop.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Player.Stop.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Player.Stop.Visible := True;

  vSoundplayer.Player.Stop_Glow := TGlowEffect.Create(vSoundplayer.Player.Stop);
  vSoundplayer.Player.Stop_Glow.Name := 'A_SP_Player_Stop_Glow';
  vSoundplayer.Player.Stop_Glow.Parent := vSoundplayer.Player.Stop;
  vSoundplayer.Player.Stop_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Stop_Glow.Softness := 0.4;
  vSoundplayer.Player.Stop_Glow.Opacity := 0.9;
  vSoundplayer.Player.Stop_Glow.Enabled := False;

  vSoundplayer.Player.Previous := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Previous.Name := 'A_SP_Player_Previous';
  vSoundplayer.Player.Previous.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Previous.SetBounds(vSoundplayer.Player.Stop.Position.X - 52, 137, 48, 48);
  vSoundplayer.Player.Previous.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Player.Previous.Text := #$ea23;
  vSoundplayer.Player.Previous.TextSettings.Font.Size := 48;
  vSoundplayer.Player.Previous.TextSettings.FontColor := TAlphaColorRec.Grey;
  vSoundplayer.Player.Previous.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Player.Previous.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Player.Previous.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Player.Previous.Visible := True;

  vSoundplayer.Player.Previous_Glow := TGlowEffect.Create(vSoundplayer.Player.Previous);
  vSoundplayer.Player.Previous_Glow.Name := 'A_SP_Player_Previous_Glow';
  vSoundplayer.Player.Previous_Glow.Parent := vSoundplayer.Player.Previous;
  vSoundplayer.Player.Previous_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Previous_Glow.Softness := 0.4;
  vSoundplayer.Player.Previous_Glow.Opacity := 0.9;
  vSoundplayer.Player.Previous_Glow.Enabled := False;

  vSoundplayer.Player.Next := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Next.Name := 'A_SP_Player_Next';
  vSoundplayer.Player.Next.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Next.SetBounds(vSoundplayer.Player.Play.Position.X + 52, 137, 48, 48);
  vSoundplayer.Player.Next.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Player.Next.Text := #$ea24;
  vSoundplayer.Player.Next.Font.Size := 48;
  vSoundplayer.Player.Next.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Next.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Player.Next.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Player.Next.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Player.Next.Visible := True;

  vSoundplayer.Player.Next_Glow := TGlowEffect.Create(vSoundplayer.Player.Next);
  vSoundplayer.Player.Next_Glow.Name := 'A_SP_Player_Next_Glow';
  vSoundplayer.Player.Next_Glow.Parent := vSoundplayer.Player.Next;
  vSoundplayer.Player.Next_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Next_Glow.Softness := 0.4;
  vSoundplayer.Player.Next_Glow.Opacity := 0.9;
  vSoundplayer.Player.Next_Glow.Enabled := False;

  vSoundplayer.Player.Eject := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Eject.Name := 'A_SP_Player_Eject';
  vSoundplayer.Player.Eject.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Eject.SetBounds(vSoundplayer.Player.Next.Position.X + 72, 152, 32, 32);
  vSoundplayer.Player.Eject.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Player.Eject.Text := #$ea25;
  vSoundplayer.Player.Eject.Font.Size := 32;
  vSoundplayer.Player.Eject.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Eject.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Player.Eject.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Player.Eject.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Player.Eject.Visible := True;

  vSoundplayer.Player.Eject_Glow := TGlowEffect.Create(vSoundplayer.Player.Eject);
  vSoundplayer.Player.Eject_Glow.Name := 'A_SP_Player_Eject_Glow';
  vSoundplayer.Player.Eject_Glow.Parent := vSoundplayer.Player.Eject;
  vSoundplayer.Player.Eject_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Eject_Glow.Softness := 0.4;
  vSoundplayer.Player.Eject_Glow.Opacity := 0.9;
  vSoundplayer.Player.Eject_Glow.Enabled := False;

  vSoundplayer.Player.Loop := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Loop.Name := 'A_SP_Player_Loop';
  vSoundplayer.Player.Loop.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Loop.SetBounds(vSoundplayer.Player.Next.Position.X + 160, 159, 24, 24);
  vSoundplayer.Player.Loop.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Player.Loop.Text := #$ea2e;
  vSoundplayer.Player.Loop.TextSettings.Font.Size := 24;
  vSoundplayer.Player.Loop.TextSettings.FontColor := TAlphaColorRec.Grey;
  vSoundplayer.Player.Loop.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Player.Loop.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Player.Loop.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Player.Loop.Visible := True;

  vSoundplayer.Player.Loop_State := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Loop_State.Name := 'A_SP_Player_Loop_State';
  vSoundplayer.Player.Loop_State.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Loop_State.SetBounds((vSoundplayer.Player.Loop.Position.X - 8), vSoundplayer.Player.Loop.Position.Y - 20, 12, 12);
  vSoundplayer.Player.Loop_State.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Player.Loop_State.Text := '';
  vSoundplayer.Player.Loop_State.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Loop_State.TextSettings.Font.Size := 12;
  vSoundplayer.Player.Loop_State.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Player.Loop_State.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Player.Loop_State.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Player.Loop_State.Visible := True;

  vSoundplayer.Player.Loop_State_Glow := TGlowEffect.Create(vSoundplayer.Player.Loop_State);
  vSoundplayer.Player.Loop_State_Glow.Name := 'A_SP_Player_Loop_State_Glow';
  vSoundplayer.Player.Loop_State_Glow.Parent := vSoundplayer.Player.Loop_State;
  vSoundplayer.Player.Loop_State_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Loop_State_Glow.Softness := 0.4;
  vSoundplayer.Player.Loop_State_Glow.Opacity := 0.9;
  vSoundplayer.Player.Loop_State_Glow.Enabled := False;

  vSoundplayer.Player.Loop_To := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Loop_To.Name := 'A_SP_Player_Loop_To_Image';
  vSoundplayer.Player.Loop_To.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Loop_To.SetBounds((vSoundplayer.Player.Loop.Position.X) + (vSoundplayer.Player.Loop.Width - 4),
    (vSoundplayer.Player.Loop.Position.Y) - 20, 12, 12);
  vSoundplayer.Player.Loop_To.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Player.Loop_To.Text := '';
  vSoundplayer.Player.Loop_To.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Loop_To.TextSettings.Font.Size := 12;
  vSoundplayer.Player.Loop_To.Visible := False;

  vSoundplayer.Player.Loop_Glow := TGlowEffect.Create(vSoundplayer.Player.Loop);
  vSoundplayer.Player.Loop_Glow.Name := 'A_SP_Player_Loop_Glow';
  vSoundplayer.Player.Loop_Glow.Parent := vSoundplayer.Player.Loop;
  vSoundplayer.Player.Loop_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Loop_Glow.Softness := 0.4;
  vSoundplayer.Player.Loop_Glow.Opacity := 0.9;
  vSoundplayer.Player.Loop_Glow.Enabled := False;

  vSoundplayer.Player.Suffle := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Suffle.Name := 'A_SP_Player_Suffle';
  vSoundplayer.Player.Suffle.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Suffle.SetBounds(vSoundplayer.Player.Next.Position.X + 200, 159, 24, 24);
  vSoundplayer.Player.Suffle.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Player.Suffle.Text := #$ea30;
  vSoundplayer.Player.Suffle.TextSettings.Font.Size := 24;
  vSoundplayer.Player.Suffle.TextSettings.FontColor := TAlphaColorRec.Grey;
  vSoundplayer.Player.Suffle.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Player.Suffle.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Player.Suffle.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Player.Suffle.Visible := True;

  vSoundplayer.Player.Suffle_Glow := TGlowEffect.Create(vSoundplayer.Player.Suffle);
  vSoundplayer.Player.Suffle_Glow.Name := 'A_SP_Player_Suffle_Glow';
  vSoundplayer.Player.Suffle_Glow.Parent := vSoundplayer.Player.Suffle;
  vSoundplayer.Player.Suffle_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Suffle_Glow.Softness := 0.4;
  vSoundplayer.Player.Suffle_Glow.Opacity := 0.9;
  vSoundplayer.Player.Suffle_Glow.Enabled := False;

  vSoundplayer.Player.Album_Info := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Album_Info.Name := 'A_SP_AlbumInfo';
  vSoundplayer.Player.Album_Info.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Album_Info.SetBounds(vSoundplayer.Player.Suffle.Position.X + 110, 158, 26, 26);
  vSoundplayer.Player.Album_Info.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Player.Album_Info.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Album_Info.Font.Size := 24;
  vSoundplayer.Player.Album_Info.Text := #$ea55;
  vSoundplayer.Player.Album_Info.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Player.Album_Info.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Player.Album_Info.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Player.Album_Info.Visible := True;

  vSoundplayer.Player.Album_Info_Glow := TGlowEffect.Create(vSoundplayer.Player.Album_Info);
  vSoundplayer.Player.Album_Info_Glow.Name := 'A_SP_Album_Info_Glow';
  vSoundplayer.Player.Album_Info_Glow.Parent := vSoundplayer.Player.Album_Info;
  vSoundplayer.Player.Album_Info_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Album_Info_Glow.Opacity := 0.9;
  vSoundplayer.Player.Album_Info_Glow.Enabled := False;

  vSoundplayer.Player.Band_Info := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Band_Info.Name := 'A_SP_BandInfo';
  vSoundplayer.Player.Band_Info.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Band_Info.SetBounds(vSoundplayer.Player.Suffle.Position.X + 150, 158, 26, 26);
  vSoundplayer.Player.Band_Info.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Player.Band_Info.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Band_Info.Font.Size := 24;
  vSoundplayer.Player.Band_Info.Text := #$e923;
  vSoundplayer.Player.Band_Info.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Player.Band_Info.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Player.Band_Info.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Player.Band_Info.Visible := True;

  vSoundplayer.Player.Band_Info_Glow := TGlowEffect.Create(vSoundplayer.Player.Band_Info);
  vSoundplayer.Player.Band_Info_Glow.Name := 'A_SP_Band_Info_Glow';
  vSoundplayer.Player.Band_Info_Glow.Parent := vSoundplayer.Player.Band_Info;
  vSoundplayer.Player.Band_Info_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Band_Info_Glow.Opacity := 0.9;
  vSoundplayer.Player.Band_Info_Glow.Enabled := False;

  vSoundplayer.Player.Lyrics := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Lyrics.Name := 'A_SP_Lyrics';
  vSoundplayer.Player.Lyrics.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Lyrics.SetBounds(vSoundplayer.Player.Suffle.Position.X + 190, 158, 26, 26);
  vSoundplayer.Player.Lyrics.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Player.Lyrics.Text := #$e922;
  vSoundplayer.Player.Lyrics.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Lyrics.TextSettings.Font.Size := 24;
  vSoundplayer.Player.Lyrics.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Player.Lyrics.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Player.Lyrics.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Player.Lyrics.Visible := True;

  vSoundplayer.Player.Lyrics_Glow := TGlowEffect.Create(vSoundplayer.Player.Lyrics);
  vSoundplayer.Player.Lyrics_Glow.Name := 'A_SP_Lyrics_Glow';
  vSoundplayer.Player.Lyrics_Glow.Parent := vSoundplayer.Player.Lyrics;
  vSoundplayer.Player.Lyrics_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Lyrics_Glow.Opacity := 0.9;
  vSoundplayer.Player.Lyrics_Glow.Enabled := False;

  vSoundplayer.Player.Equalizer := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Equalizer.Name := 'A_SP_Equalizer';
  vSoundplayer.Player.Equalizer.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Equalizer.SetBounds(vSoundplayer.Player.Suffle.Position.X + 240, 159, 24, 24);
  vSoundplayer.Player.Equalizer.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Player.Equalizer.Text := #$e993;
  vSoundplayer.Player.Equalizer.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Equalizer.TextSettings.Font.Size := 24;
  vSoundplayer.Player.Equalizer.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Player.Equalizer.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Player.Equalizer.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Player.Equalizer.Visible := True;

  vSoundplayer.Player.Equalizer_Glow := TGlowEffect.Create(vSoundplayer.Player.Equalizer);
  vSoundplayer.Player.Equalizer_Glow.Name := 'A_SP_Equalizer_Glow';
  vSoundplayer.Player.Equalizer_Glow.Parent := vSoundplayer.Player.Equalizer;
  vSoundplayer.Player.Equalizer_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Equalizer_Glow.Opacity := 0.9;
  vSoundplayer.Player.Equalizer_Glow.Enabled := False;

  vSoundplayer.Player.Song_Title := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Song_Title.Name := 'A_SP_Player_SongTitle';
  vSoundplayer.Player.Song_Title.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Song_Title.SetBounds(extrafe.res.Half_Width - 800, 18, 1600, 80);
  vSoundplayer.Player.Song_Title.Font.Size := 44;
  vSoundplayer.Player.Song_Title.Color := TAlphaColorRec.White;
  vSoundplayer.Player.Song_Title.Text := '';
  vSoundplayer.Player.Song_Title.Visible := True;
  vSoundplayer.Player.Song_Title.WordWrap := False;

  vSoundplayer.Player.Song_Title_Cover_Left := TRectangle.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Song_Title_Cover_Left.Name := 'A_SP_Player_Title_Cover_Left';
  vSoundplayer.Player.Song_Title_Cover_Left.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Song_Title_Cover_Left.SetBounds(0, 14, 465, 88);
  vSoundplayer.Player.Song_Title_Cover_Left.Fill.Bitmap.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_back.png');
  vSoundplayer.Player.Song_Title_Cover_Left.Fill.Bitmap.WrapMode := TWrapMode.Tile;
  vSoundplayer.Player.Song_Title_Cover_Left.Fill.Kind := TBrushKind.Bitmap;
  vSoundplayer.Player.Song_Title_Cover_Left.Stroke.Thickness := 0;
  vSoundplayer.Player.Song_Title_Cover_Left.Visible := True;

  vSoundplayer.Player.Song_Title_Cover_Right := TRectangle.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Song_Title_Cover_Right.Name := 'A_SP_Player_Title_Cover_Right';
  vSoundplayer.Player.Song_Title_Cover_Right.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Song_Title_Cover_Right.SetBounds(1465, 14, 465, 88);
  vSoundplayer.Player.Song_Title_Cover_Right.Fill.Bitmap.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_back.png');
  vSoundplayer.Player.Song_Title_Cover_Right.Fill.Bitmap.WrapMode := TWrapMode.Tile;
  vSoundplayer.Player.Song_Title_Cover_Right.Fill.Kind := TBrushKind.Bitmap;
  vSoundplayer.Player.Song_Title_Cover_Right.Stroke.Thickness := 0;
  vSoundplayer.Player.Song_Title_Cover_Right.Visible := True;

  vSoundplayer.Player.Song_Title_Ani := TFloatAnimation.Create(vSoundplayer.Player.Song_Title);
  vSoundplayer.Player.Song_Title_Ani.Name := 'A_SP_Player_Song_Title_Animation';
  vSoundplayer.Player.Song_Title_Ani.Parent := vSoundplayer.Player.Song_Title;
  vSoundplayer.Player.Song_Title_Ani.Delay := 2;
  vSoundplayer.Player.Song_Title_Ani.Duration := 4;
  vSoundplayer.Player.Song_Title_Ani.PropertyName := 'Position.X';
  vSoundplayer.Player.Song_Title_Ani.AnimationType := TAnimationType.&InOut;
  vSoundplayer.Player.Song_Title_Ani.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.Player.Song_Title_Ani.Enabled := False;

  for vi := 0 to 4 do
  begin
    vSoundplayer.Player.Rate[vi] := TText.Create(vSoundplayer.scene.Back_Player);
    vSoundplayer.Player.Rate[vi].Name := 'A_SP_Player_Rate_' + vi.ToString;
    vSoundplayer.Player.Rate[vi].Parent := vSoundplayer.scene.Back_Player;
    vSoundplayer.Player.Rate[vi].SetBounds((610 + (vi * 28)), 170, 24, 24);
    vSoundplayer.Player.Rate[vi].Font.Family := 'IcoMoon-Free';
    vSoundplayer.Player.Rate[vi].TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vSoundplayer.Player.Rate[vi].Font.Size := 24;
    vSoundplayer.Player.Rate[vi].Text := #$e9d7;
    vSoundplayer.Player.Rate[vi].Visible := True;
  end;

  vSoundplayer.Player.Song_Pos := TALTrackbar.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Song_Pos.Name := 'A_SP_SongPos';
  vSoundplayer.Player.Song_Pos.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Song_Pos.SetBounds(460, 100, 1000, 30);
  vSoundplayer.Player.Song_Pos.Min := 0;
  vSoundplayer.Player.Song_Pos.Max := 1000;
  vSoundplayer.Player.Song_Pos.BackGround.Fill.Color := TAlphaColorRec.White;
  vSoundplayer.Player.Song_Pos.Highlight.Fill.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Song_Pos.Thumb.Name := 'A_SP_SongPos_Thumb';
  vSoundplayer.Player.Song_Pos.OnChange := addons.soundplayer.Input.mouse.Trackbar_Thumb.OnChange;
  vSoundplayer.Player.Song_Pos.Thumb.OnMouseDown := addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseDown;
  vSoundplayer.Player.Song_Pos.Thumb.OnMouseUp := addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseUp;
  vSoundplayer.Player.Song_Pos.Thumb.OnMouseMove := addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseMove;
  vSoundplayer.Player.Song_Pos.Thumb.OnMouseEnter := addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseEnter;
  vSoundplayer.Player.Song_Pos.Thumb.OnMouseLeave := addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseLeave;
  vSoundplayer.Player.Song_Pos.Visible := True;

  vSoundplayer.Player.Song_Tag := Timage.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Song_Tag.Name := 'A_SP_Player_Tag_Image';
  vSoundplayer.Player.Song_Tag.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Song_Tag.SetBounds(1490, 20, 48, 48);
  vSoundplayer.Player.Song_Tag.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.Player.Song_Tag.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.Player.Song_Tag.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.Player.Song_Tag.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.Player.Song_Tag.Visible := False;

  vSoundplayer.Player.Song_Tag_Glow := TGlowEffect.Create(vSoundplayer.Player.Song_Tag);
  vSoundplayer.Player.Song_Tag_Glow.Name := 'A_SP_Player_Tag_Glow';
  vSoundplayer.Player.Song_Tag_Glow.Parent := vSoundplayer.Player.Song_Tag;
  vSoundplayer.Player.Song_Tag_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Song_Tag_Glow.Softness := 0.4;
  vSoundplayer.Player.Song_Tag_Glow.Opacity := 0.9;
  vSoundplayer.Player.Song_Tag_Glow.Enabled := False;

  vSoundplayer.Player.Song_KBPS := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Song_KBPS.Name := 'A_SP_Player_KBPS';
  vSoundplayer.Player.Song_KBPS.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Song_KBPS.SetBounds(1490, 70, 200, 30);
  vSoundplayer.Player.Song_KBPS.Text := '------';
  vSoundplayer.Player.Song_KBPS.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.Player.Song_KBPS.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Player.Song_KBPS.TextSettings.Font.Size := 18;
  vSoundplayer.Player.Song_KBPS.TextSettings.Font.Style := vSoundplayer.Player.Song_KBPS.TextSettings.Font.Style + [TFontStyle.fsItalic];
  vSoundplayer.Player.Song_KBPS.Visible := True;

  vSoundplayer.Player.Song_SampleRate := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Song_SampleRate.Name := 'A_SP_Player_Song_SampleRate';
  vSoundplayer.Player.Song_SampleRate.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Song_SampleRate.SetBounds(1490, 110, 200, 30);
  vSoundplayer.Player.Song_SampleRate.Text := '------';
  vSoundplayer.Player.Song_SampleRate.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.Player.Song_SampleRate.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Player.Song_SampleRate.TextSettings.Font.Size := 18;
  vSoundplayer.Player.Song_SampleRate.TextSettings.Font.Style := vSoundplayer.Player.Song_SampleRate.TextSettings.Font.Style + [TFontStyle.fsItalic];
  vSoundplayer.Player.Song_SampleRate.Visible := True;

  vSoundplayer.Player.Song_Time := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Song_Time.Name := 'A_SP_SongTime';
  vSoundplayer.Player.Song_Time.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Song_Time.SetBounds(470, 140, 140, 30);
  vSoundplayer.Player.Song_Time.Font.Size := 22;
  vSoundplayer.Player.Song_Time.Color := TAlphaColorRec.White;
  vSoundplayer.Player.Song_Time.Text := '00:00:00';
  vSoundplayer.Player.Song_Time.Visible := True;
  vSoundplayer.Player.Song_Time.TextSettings.HorzAlign := TTextAlign.Center;

  vSoundplayer.Player.Song_PlayTime := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Song_PlayTime.Name := 'A_SP_SongTime_Play';
  vSoundplayer.Player.Song_PlayTime.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Song_PlayTime.SetBounds(440, 170, 140, 30);
  vSoundplayer.Player.Song_PlayTime.Font.Size := 22;
  vSoundplayer.Player.Song_PlayTime.Color := TAlphaColorRec.White;
  vSoundplayer.Player.Song_PlayTime.Text := '00:00:00';
  vSoundplayer.Player.Song_PlayTime.TextSettings.HorzAlign := TTextAlign.Trailing;
  vSoundplayer.Player.Song_PlayTime.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Player.Song_PlayTime.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Player.Song_PlayTime.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Player.Song_PlayTime.Visible := True;

  vSoundplayer.Player.Speaker_Left := Timage.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Speaker_Left.Name := 'A_SP_Player_Speaker_Left_Image';
  vSoundplayer.Player.Speaker_Left.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Speaker_Left.SetBounds(38, 15, 85, 150);
  vSoundplayer.Player.Speaker_Left.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_speaker.png');
  vSoundplayer.Player.Speaker_Left.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.Player.Speaker_Left.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.Player.Speaker_Left.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.Player.Speaker_Left.Visible := True;

  vSoundplayer.Player.Speaker_Left_Hue := THueAdjustEffect.Create(vSoundplayer.Player.Speaker_Left);
  vSoundplayer.Player.Speaker_Left_Hue.Name := 'A_SP_Player_Speaker_Left_Hue';
  vSoundplayer.Player.Speaker_Left_Hue.Parent := vSoundplayer.Player.Speaker_Left;
  vSoundplayer.Player.Speaker_Left_Hue.Hue := -1;
  vSoundplayer.Player.Speaker_Left_Hue.Enabled := False;

  vSoundplayer.Player.Speaker_Left_Percent := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Speaker_Left_Percent.Name := 'A_SP_Player_Speaker_Left_Percent';
  vSoundplayer.Player.Speaker_Left_Percent.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Speaker_Left_Percent.SetBounds(29, -5, 100, 24);
  vSoundplayer.Player.Speaker_Left_Percent.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Speaker_Left_Percent.Text := '';
  vSoundplayer.Player.Speaker_Left_Percent.Visible := True;

  vSoundplayer.Player.Speaker_Left_Percent_Ani := TFloatAnimation.Create(vSoundplayer.Player.Speaker_Left_Percent);
  vSoundplayer.Player.Speaker_Left_Percent_Ani.Name := 'A_SP_Player_Speaker_Left_Percent_Ani';
  vSoundplayer.Player.Speaker_Left_Percent_Ani.Parent := vSoundplayer.Player.Speaker_Left_Percent;
  vSoundplayer.Player.Speaker_Left_Percent_Ani.PropertyName := 'Opacity';
  vSoundplayer.Player.Speaker_Left_Percent_Ani.StartValue := 1;
  vSoundplayer.Player.Speaker_Left_Percent_Ani.StopValue := 0;
  vSoundplayer.Player.Speaker_Left_Percent_Ani.Duration := 2;
  vSoundplayer.Player.Speaker_Left_Percent_Ani.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.Player.Speaker_Left_Percent_Ani.Enabled := False;

  vSoundplayer.Player.Speaker_Left_Volume_Pos := TALTrackbar.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Speaker_Left_Volume_Pos.Name := 'A_SP_Player_Speaker_Left_VolumePos';
  vSoundplayer.Player.Speaker_Left_Volume_Pos.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Speaker_Left_Volume_Pos.SetBounds(10, 170, 138, 30);
  vSoundplayer.Player.Speaker_Left_Volume_Pos.BackGround.Fill.Color := TAlphaColorRec.White;
  vSoundplayer.Player.Speaker_Left_Volume_Pos.Highlight.Fill.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Speaker_Left_Volume_Pos.Thumb.CornerType := TCornerType.Bevel;
  vSoundplayer.Player.Speaker_Left_Volume_Pos.Thumb.Name := 'A_SP_Player_Speaker_Left_VolumePos_Thumb';
  vSoundplayer.Player.Speaker_Left_Volume_Pos.OnChange := addons.soundplayer.Input.mouse.Trackbar.OnChange;
  vSoundplayer.Player.Speaker_Left_Volume_Pos.OnMouseUp := addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseUp;
  vSoundplayer.Player.Speaker_Left_Volume_Pos.Thumb.OnMouseDown := addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseDown;
  vSoundplayer.Player.Speaker_Left_Volume_Pos.Thumb.OnMouseEnter := addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseEnter;
  vSoundplayer.Player.Speaker_Left_Volume_Pos.Thumb.OnMouseLeave := addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseLeave;
  vSoundplayer.Player.Speaker_Left_Volume_Pos.Visible := True;

  vSoundplayer.Player.Speaker_Right := Timage.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Speaker_Right.Name := 'A_SP_Player_Speaker_Right_Image';
  vSoundplayer.Player.Speaker_Right.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Speaker_Right.SetBounds(vSoundplayer.scene.Back_Player.Width - 123, 15, 85, 150);
  vSoundplayer.Player.Speaker_Right.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_speaker.png');
  vSoundplayer.Player.Speaker_Right.OnClick := addons.soundplayer.Input.mouse.Image.OnMouseClick;
  vSoundplayer.Player.Speaker_Right.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.Player.Speaker_Right.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.Player.Speaker_Right.Visible := True;

  vSoundplayer.Player.Speaker_Right_Hue := THueAdjustEffect.Create(vSoundplayer.Player.Speaker_Right);
  vSoundplayer.Player.Speaker_Right_Hue.Name := 'A_SP_Player_Speaker_Right_Hue';
  vSoundplayer.Player.Speaker_Right_Hue.Parent := vSoundplayer.Player.Speaker_Right;
  vSoundplayer.Player.Speaker_Right_Hue.Hue := -1;
  vSoundplayer.Player.Speaker_Right_Hue.Enabled := False;

  vSoundplayer.Player.Speaker_Right_Percent := TText.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Speaker_Right_Percent.Name := 'A_SP_Player_Speaker_Right_Percent';
  vSoundplayer.Player.Speaker_Right_Percent.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Speaker_Right_Percent.SetBounds(vSoundplayer.scene.Back_Player.Width - 132, -5, 100, 24);
  vSoundplayer.Player.Speaker_Right_Percent.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Speaker_Right_Percent.Text := '';
  vSoundplayer.Player.Speaker_Right_Percent.Visible := True;

  vSoundplayer.Player.Speaker_Right_Percent_Ani := TFloatAnimation.Create(vSoundplayer.Player.Speaker_Right_Percent);
  vSoundplayer.Player.Speaker_Right_Percent_Ani.Name := 'A_SP_Player_Speaker_Right_Percent_Ani';
  vSoundplayer.Player.Speaker_Right_Percent_Ani.Parent := vSoundplayer.Player.Speaker_Right_Percent;
  vSoundplayer.Player.Speaker_Right_Percent_Ani.PropertyName := 'Opacity';
  vSoundplayer.Player.Speaker_Right_Percent_Ani.StartValue := 1;
  vSoundplayer.Player.Speaker_Right_Percent_Ani.StopValue := 0;
  vSoundplayer.Player.Speaker_Right_Percent_Ani.Duration := 2;
  vSoundplayer.Player.Speaker_Right_Percent_Ani.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.Player.Speaker_Right_Percent_Ani.Enabled := False;

  vSoundplayer.Player.Speaker_Right_Volume_Pos := TALTrackbar.Create(vSoundplayer.scene.Back_Player);
  vSoundplayer.Player.Speaker_Right_Volume_Pos.Name := 'A_SP_Player_Speaker_Right_VolumePos';
  vSoundplayer.Player.Speaker_Right_Volume_Pos.Parent := vSoundplayer.scene.Back_Player;
  vSoundplayer.Player.Speaker_Right_Volume_Pos.SetBounds(vSoundplayer.scene.Back_Player.Width - 148, 170, 138, 30);
  vSoundplayer.Player.Speaker_Right_Volume_Pos.BackGround.Fill.Color := TAlphaColorRec.White;
  vSoundplayer.Player.Speaker_Right_Volume_Pos.Highlight.Fill.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Speaker_Right_Volume_Pos.Thumb.CornerType := TCornerType.Bevel;
  vSoundplayer.Player.Speaker_Right_Volume_Pos.Thumb.Name := 'A_SP_Player_Speaker_Right_VolumePos_Thumb';
  vSoundplayer.Player.Speaker_Right_Volume_Pos.OnChange := addons.soundplayer.Input.mouse.Trackbar.OnChange;
  vSoundplayer.Player.Speaker_Right_Volume_Pos.OnMouseUp := addons.soundplayer.Input.mouse.Trackbar.OnMouseUp;
  vSoundplayer.Player.Speaker_Right_Volume_Pos.OnMouseDown := addons.soundplayer.Input.mouse.Trackbar.OnMouseDown;
  vSoundplayer.Player.Speaker_Right_Volume_Pos.Thumb.OnMouseEnter := addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseEnter;
  vSoundplayer.Player.Speaker_Right_Volume_Pos.Thumb.OnMouseLeave := addons.soundplayer.Input.mouse.Trackbar_Thumb.OnMouseLeave;
  vSoundplayer.Player.Speaker_Right_Volume_Pos.Visible := True;
end;

procedure Info;
begin
  vSoundplayer.scene.Back_Info := Timage.Create(vSoundplayer.scene.Back);
  vSoundplayer.scene.Back_Info.Name := 'A_SP_BackInfo_Image';
  vSoundplayer.scene.Back_Info.Parent := vSoundplayer.scene.Back;
  vSoundplayer.scene.Back_Info.SetBounds(0, 220, vSoundplayer.scene.Back.Width, (extrafe.res.Height - 410) - 220);
  vSoundplayer.scene.Back_Info.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_ilhm.png');
  vSoundplayer.scene.Back_Info.WrapMode := TImageWrapMode.Center;
  vSoundplayer.scene.Back_Info.Visible := True;

  vSoundplayer.Info.Back_Left := Timage.Create(vSoundplayer.scene.Back_Info);
  vSoundplayer.Info.Back_Left.Name := 'A_SP_BackInfo_BackLeft_Image';
  vSoundplayer.Info.Back_Left.Parent := vSoundplayer.scene.Back_Info;
  vSoundplayer.Info.Back_Left.SetBounds(2, 10, 600, vSoundplayer.scene.Back_Info.Height - 20);
  vSoundplayer.Info.Back_Left.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_back_info.png');
  vSoundplayer.Info.Back_Left.WrapMode := TImageWrapMode.Tile;
  vSoundplayer.Info.Back_Left.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.Info.Back_Left.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.Info.Back_Left.Visible := True;

  vSoundplayer.Info.Back_Left_Ani := TFloatAnimation.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Back_Left_Ani.Name := 'A_SP_BackInfo_BackLeft_Animation';
  vSoundplayer.Info.Back_Left_Ani.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Back_Left_Ani.Delay := 6;
  vSoundplayer.Info.Back_Left_Ani.Duration := 0.6;
  vSoundplayer.Info.Back_Left_Ani.PropertyName := 'Position.X';
  vSoundplayer.Info.Back_Left_Ani.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.Info.Back_Left_Ani.Enabled := False;

  vSoundplayer.Info.Song := TText.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Song.Name := 'A_SP_Info_SongTitle';
  vSoundplayer.Info.Song.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Song.SetBounds(10, 30, 160, 22);
  vSoundplayer.Info.Song.Font.Size := 18;
  vSoundplayer.Info.Song.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Info.Song.Text := 'Song Title : ';
  vSoundplayer.Info.Song.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Info.Song.Visible := True;

  vSoundplayer.Info.Song_Title := TText.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Song_Title.Name := 'A_SP_Info_SongTitle_V';
  vSoundplayer.Info.Song_Title.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Song_Title.SetBounds(160, 30, 530, 22);
  vSoundplayer.Info.Song_Title.Font.Size := 18;
  vSoundplayer.Info.Song_Title.Color := TAlphaColorRec.White;
  vSoundplayer.Info.Song_Title.Text := '';
  vSoundplayer.Info.Song_Title.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Info.Song_Title.Visible := True;

  vSoundplayer.Info.Artist := TText.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Artist.Name := 'A_SP_Info_ArtistName';
  vSoundplayer.Info.Artist.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Artist.SetBounds(10, 60, 160, 22);
  vSoundplayer.Info.Artist.Font.Size := 18;
  vSoundplayer.Info.Artist.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Info.Artist.Text := 'Artist Name : ';
  vSoundplayer.Info.Artist.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Info.Artist.Visible := True;

  vSoundplayer.Info.Artist_Name := TText.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Artist_Name.Name := 'A_SP_Info_ArtistName_V';
  vSoundplayer.Info.Artist_Name.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Artist_Name.SetBounds(160, 60, 530, 22);
  vSoundplayer.Info.Artist_Name.Font.Size := 18;
  vSoundplayer.Info.Artist_Name.Color := TAlphaColorRec.White;
  vSoundplayer.Info.Artist_Name.Text := '';
  vSoundplayer.Info.Artist_Name.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Info.Artist_Name.Visible := True;

  vSoundplayer.Info.Year := TText.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Year.Name := 'A_SP_Info_YearPublished';
  vSoundplayer.Info.Year.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Year.SetBounds(10, 90, 160, 22);
  vSoundplayer.Info.Year.Font.Size := 18;
  vSoundplayer.Info.Year.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Info.Year.Text := 'Year Published : ';
  vSoundplayer.Info.Year.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Info.Year.Visible := True;

  vSoundplayer.Info.Year_Publish := TText.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Year_Publish.Name := 'A_SP_Info_YearPublished_V';
  vSoundplayer.Info.Year_Publish.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Year_Publish.SetBounds(160, 90, 530, 22);
  vSoundplayer.Info.Year_Publish.Font.Size := 18;
  vSoundplayer.Info.Year_Publish.Color := TAlphaColorRec.White;
  vSoundplayer.Info.Year_Publish.Text := '';
  vSoundplayer.Info.Year_Publish.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Info.Year_Publish.Visible := True;

  vSoundplayer.Info.Gerne := TText.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Gerne.Name := 'A_SP_Info_GerneType';
  vSoundplayer.Info.Gerne.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Gerne.SetBounds(10, 120, 160, 22);
  vSoundplayer.Info.Gerne.Font.Size := 18;
  vSoundplayer.Info.Gerne.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Info.Gerne.Text := 'Gerne Type : ';
  vSoundplayer.Info.Gerne.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Info.Gerne.Visible := True;

  vSoundplayer.Info.Gerne_Kind := TText.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Gerne_Kind.Name := 'A_SP_Info_GerneType_V';
  vSoundplayer.Info.Gerne_Kind.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Gerne_Kind.SetBounds(160, 120, 530, 22);
  vSoundplayer.Info.Gerne_Kind.Font.Size := 18;
  vSoundplayer.Info.Gerne_Kind.Color := TAlphaColorRec.White;
  vSoundplayer.Info.Gerne_Kind.Text := '';
  vSoundplayer.Info.Gerne_Kind.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Info.Gerne_Kind.Visible := True;

  vSoundplayer.Info.Track := TText.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Track.Name := 'A_SP_Info_TrackNum';
  vSoundplayer.Info.Track.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Track.SetBounds(10, 150, 160, 22);
  vSoundplayer.Info.Track.Font.Size := 18;
  vSoundplayer.Info.Track.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Info.Track.Text := 'Song Number : ';
  vSoundplayer.Info.Track.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Info.Track.Visible := True;

  vSoundplayer.Info.Track_Num := TText.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Track_Num.Name := 'A_SP_Info_TrackNum_V';
  vSoundplayer.Info.Track_Num.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Track_Num.SetBounds(160, 150, 530, 22);
  vSoundplayer.Info.Track_Num.Font.Size := 18;
  vSoundplayer.Info.Track_Num.Color := TAlphaColorRec.White;
  vSoundplayer.Info.Track_Num.Text := '';
  vSoundplayer.Info.Track_Num.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Info.Track_Num.Visible := True;

  vSoundplayer.Info.Playlist := TText.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Playlist.Name := 'A_SP_Info_PlaylistName';
  vSoundplayer.Info.Playlist.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Playlist.SetBounds(10, 220, 160, 22);
  vSoundplayer.Info.Playlist.Font.Size := 18;
  vSoundplayer.Info.Playlist.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Info.Playlist.Text := 'Playlist Name : ';
  vSoundplayer.Info.Playlist.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Info.Playlist.Visible := True;

  vSoundplayer.Info.Playlist_Name := TText.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Playlist_Name.Name := 'A_SP_Info_PlaylistName_V';
  vSoundplayer.Info.Playlist_Name.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Playlist_Name.SetBounds(160, 220, 530, 22);
  vSoundplayer.Info.Playlist_Name.Font.Size := 18;
  vSoundplayer.Info.Playlist_Name.Color := TAlphaColorRec.White;
  vSoundplayer.Info.Playlist_Name.Text := '';
  vSoundplayer.Info.Playlist_Name.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Info.Playlist_Name.Visible := True;

  vSoundplayer.Info.Playlist_Type := TText.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Playlist_Type.Name := 'A_SP_Info_PlaylistType';
  vSoundplayer.Info.Playlist_Type.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Playlist_Type.SetBounds(10, 250, 160, 22);
  vSoundplayer.Info.Playlist_Type.Font.Size := 18;
  vSoundplayer.Info.Playlist_Type.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Info.Playlist_Type.Text := 'Playlist Type : ';
  vSoundplayer.Info.Playlist_Type.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Info.Playlist_Type.Visible := True;

  vSoundplayer.Info.Playlist_Type_Kind := TText.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Playlist_Type_Kind.Name := 'A_SP_Info_PlaylistType_V';
  vSoundplayer.Info.Playlist_Type_Kind.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Playlist_Type_Kind.SetBounds(160, 250, 530, 22);
  vSoundplayer.Info.Playlist_Type_Kind.Font.Size := 18;
  vSoundplayer.Info.Playlist_Type_Kind.Color := TAlphaColorRec.White;
  vSoundplayer.Info.Playlist_Type_Kind.Text := '';
  vSoundplayer.Info.Playlist_Type_Kind.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Info.Playlist_Type_Kind.Visible := True;

  vSoundplayer.Info.Total := TText.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Total.Name := 'A_SP_Info_TotalTracks';
  vSoundplayer.Info.Total.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Total.SetBounds(10, 280, 160, 22);
  vSoundplayer.Info.Total.Font.Size := 18;
  vSoundplayer.Info.Total.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Info.Total.Text := 'Total Songs : ';
  vSoundplayer.Info.Total.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Info.Total.Visible := True;

  vSoundplayer.Info.Total_Songs := TText.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Total_Songs.Name := 'A_SP_Info_TotalTracks_V';
  vSoundplayer.Info.Total_Songs.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Total_Songs.SetBounds(160, 280, 530, 22);
  vSoundplayer.Info.Total_Songs.Font.Size := 18;
  vSoundplayer.Info.Total_Songs.Color := TAlphaColorRec.White;
  vSoundplayer.Info.Total_Songs.Text := '';
  vSoundplayer.Info.Total_Songs.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Info.Total_Songs.Visible := True;

  vSoundplayer.Info.Time := TText.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Time.Name := 'A_SP_Info_TotalTime';
  vSoundplayer.Info.Time.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Time.SetBounds(10, 310, 160, 22);
  vSoundplayer.Info.Time.Font.Size := 18;
  vSoundplayer.Info.Time.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Info.Time.Text := 'Total Time : ';
  vSoundplayer.Info.Time.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Info.Time.Visible := True;

  vSoundplayer.Info.Time_Total := TText.Create(vSoundplayer.Info.Back_Left);
  vSoundplayer.Info.Time_Total.Name := 'A_SP_Info_TotalTime_V';
  vSoundplayer.Info.Time_Total.Parent := vSoundplayer.Info.Back_Left;
  vSoundplayer.Info.Time_Total.SetBounds(160, 310, 530, 22);
  vSoundplayer.Info.Time_Total.Font.Size := 18;
  vSoundplayer.Info.Time_Total.Color := TAlphaColorRec.White;
  vSoundplayer.Info.Time_Total.Text := '';
  vSoundplayer.Info.Time_Total.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.Info.Time_Total.Visible := True;
end;

procedure Playlist;
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
//  vSoundplayer.Playlist.List.Images := vSoundplayer.scene.Imglist;
  vSoundplayer.Playlist.List.Options := vSoundplayer.Playlist.List.Options + [TGridOption.AlternatingRowBackground, TGridOption.ColLines, TGridOption.RowLines,
    TGridOption.RowSelect, TGridOption.Tabs, TGridOption.Header, TGridOption.AutoDisplacement];
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
//  vSoundplayer.Playlist.List_Popup_Memu.Images := vSoundplayer.scene.Imglist;

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
  vSoundplayer.Playlist.List_Line_Edit_Left.SetBounds(vSoundplayer.Playlist.List.Width, 0, 10, vSoundplayer.scene.Back_Playlist.Height);
  vSoundplayer.Playlist.List_Line_Edit_Left.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_spot.png');
  vSoundplayer.Playlist.List_Line_Edit_Left.WrapMode := TImageWrapMode.Stretch;
  vSoundplayer.Playlist.List_Line_Edit_Left.Visible := True;

  vSoundplayer.Playlist.Songs_Edit.Lock := TText.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.Songs_Edit.Lock.Name := 'A_SP_Playlist_Edit_Songs_Lock';
  vSoundplayer.Playlist.Songs_Edit.Lock.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.Songs_Edit.Lock.SetBounds(vSoundplayer.Playlist.List.Width + 32, 10, 36, 36);
  vSoundplayer.Playlist.Songs_Edit.Lock.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Playlist.Songs_Edit.Lock.Text := #$e98f;
  vSoundplayer.Playlist.Songs_Edit.Lock.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Playlist.Songs_Edit.Lock.TextSettings.Font.Size := 36;
  vSoundplayer.Playlist.Songs_Edit.Lock.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Playlist.Songs_Edit.Lock.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Playlist.Songs_Edit.Lock.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Playlist.Songs_Edit.Lock.Visible := True;

  vSoundplayer.Playlist.Songs_Edit.Lock_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Songs_Edit.Lock);
  vSoundplayer.Playlist.Songs_Edit.Lock_Glow.Name := 'A_SP_Playlist_Edit_Songs_Lock_Glow';
  vSoundplayer.Playlist.Songs_Edit.Lock_Glow.Parent := vSoundplayer.Playlist.Songs_Edit.Lock;
  vSoundplayer.Playlist.Songs_Edit.Lock_Glow.Softness := 0.4;
  vSoundplayer.Playlist.Songs_Edit.Lock_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Playlist.Songs_Edit.Lock_Glow.Opacity := 0.9;
  vSoundplayer.Playlist.Songs_Edit.Lock_Glow.Enabled := False;

  vSoundplayer.Playlist.Songs_Edit.Edit := TText.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.Songs_Edit.Edit.Name := 'A_SP_Playlist_Edit_Songs_Edit';
  vSoundplayer.Playlist.Songs_Edit.Edit.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.Songs_Edit.Edit.SetBounds(vSoundplayer.Playlist.List.Width + 29, 70, 32, 32);
  vSoundplayer.Playlist.Songs_Edit.Edit.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Playlist.Songs_Edit.Edit.TextSettings.FontColor := TAlphaColorRec.Grey;
  vSoundplayer.Playlist.Songs_Edit.Edit.Font.Size := 32;
  vSoundplayer.Playlist.Songs_Edit.Edit.Text := #$e906;
  vSoundplayer.Playlist.Songs_Edit.Edit.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Playlist.Songs_Edit.Edit.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Playlist.Songs_Edit.Edit.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Playlist.Songs_Edit.Edit.Visible := True;

  vSoundplayer.Playlist.Songs_Edit.Edit_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Songs_Edit.Edit);
  vSoundplayer.Playlist.Songs_Edit.Edit_Glow.Name := 'A_SP_Playlist_Edit_Songs_Edit_Glow';
  vSoundplayer.Playlist.Songs_Edit.Edit_Glow.Parent := vSoundplayer.Playlist.Songs_Edit.Edit;
  vSoundplayer.Playlist.Songs_Edit.Edit_Glow.Softness := 0.4;
  vSoundplayer.Playlist.Songs_Edit.Edit_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Playlist.Songs_Edit.Edit_Glow.Opacity := 0.9;
  vSoundplayer.Playlist.Songs_Edit.Edit_Glow.Enabled := False;

  vSoundplayer.Playlist.Songs_Edit.Up := TText.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.Songs_Edit.Up.Name := 'A_SP_Playlist_Edit_Songs_Up';
  vSoundplayer.Playlist.Songs_Edit.Up.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.Songs_Edit.Up.SetBounds(vSoundplayer.Playlist.List.Width + 29, 121, 32, 32);
  vSoundplayer.Playlist.Songs_Edit.Up.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Playlist.Songs_Edit.Up.TextSettings.FontColor := TAlphaColorRec.Grey;
  vSoundplayer.Playlist.Songs_Edit.Up.Font.Size := 32;
  vSoundplayer.Playlist.Songs_Edit.Up.Text := #$ea41;
  vSoundplayer.Playlist.Songs_Edit.Up.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Playlist.Songs_Edit.Up.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Playlist.Songs_Edit.Up.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Playlist.Songs_Edit.Up.Visible := True;

  vSoundplayer.Playlist.Songs_Edit.Up_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Songs_Edit.Up);
  vSoundplayer.Playlist.Songs_Edit.Up_Glow.Name := 'A_SP_Playlist_Edit_Songs_Up_Glow';
  vSoundplayer.Playlist.Songs_Edit.Up_Glow.Parent := vSoundplayer.Playlist.Songs_Edit.Up;
  vSoundplayer.Playlist.Songs_Edit.Up_Glow.Softness := 0.4;
  vSoundplayer.Playlist.Songs_Edit.Up_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Playlist.Songs_Edit.Up_Glow.Opacity := 0.9;
  vSoundplayer.Playlist.Songs_Edit.Up_Glow.Enabled := False;

  vSoundplayer.Playlist.Songs_Edit.Down := TText.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.Songs_Edit.Down.Name := 'A_SP_Playlist_Edit_Songs_Down';
  vSoundplayer.Playlist.Songs_Edit.Down.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.Songs_Edit.Down.SetBounds(vSoundplayer.Playlist.List.Width + 29, 162, 32, 32);
  vSoundplayer.Playlist.Songs_Edit.Down.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Playlist.Songs_Edit.Down.TextSettings.FontColor := TAlphaColorRec.Grey;
  vSoundplayer.Playlist.Songs_Edit.Down.Font.Size := 32;
  vSoundplayer.Playlist.Songs_Edit.Down.Text := #$ea43;
  vSoundplayer.Playlist.Songs_Edit.Down.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Playlist.Songs_Edit.Down.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Playlist.Songs_Edit.Down.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Playlist.Songs_Edit.Down.Visible := True;

  vSoundplayer.Playlist.Songs_Edit.Down_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Songs_Edit.Down);
  vSoundplayer.Playlist.Songs_Edit.Down_Glow.Name := 'A_SP_Playlist_Edit_Songs_Down_Glow';
  vSoundplayer.Playlist.Songs_Edit.Down_Glow.Parent := vSoundplayer.Playlist.Songs_Edit.Down;
  vSoundplayer.Playlist.Songs_Edit.Down_Glow.Softness := 0.4;
  vSoundplayer.Playlist.Songs_Edit.Down_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Playlist.Songs_Edit.Down_Glow.Opacity := 0.9;
  vSoundplayer.Playlist.Songs_Edit.Down_Glow.Enabled := False;

  vSoundplayer.Playlist.Songs_Edit.Delete := TText.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.Songs_Edit.Delete.Name := 'A_SP_Playlist_Edit_Songs_Delete';
  vSoundplayer.Playlist.Songs_Edit.Delete.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.Songs_Edit.Delete.SetBounds(vSoundplayer.Playlist.List.Width + 29, vSoundplayer.Playlist.List.Height - 45, 32, 32);
  vSoundplayer.Playlist.Songs_Edit.Delete.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Playlist.Songs_Edit.Delete.TextSettings.FontColor := TAlphaColorRec.Grey;
  vSoundplayer.Playlist.Songs_Edit.Delete.Font.Size := 32;
  vSoundplayer.Playlist.Songs_Edit.Delete.Text := #$e9ac;
  vSoundplayer.Playlist.Songs_Edit.Delete.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Playlist.Songs_Edit.Delete.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Playlist.Songs_Edit.Delete.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Playlist.Songs_Edit.Delete.Visible := True;

  vSoundplayer.Playlist.Songs_Edit.Delete_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Songs_Edit.Delete);
  vSoundplayer.Playlist.Songs_Edit.Delete_Glow.Name := 'A_SP_Playlist_Edit_Songs_Delete_Glow';
  vSoundplayer.Playlist.Songs_Edit.Delete_Glow.Parent := vSoundplayer.Playlist.Songs_Edit.Delete;
  vSoundplayer.Playlist.Songs_Edit.Delete_Glow.Softness := 0.4;
  vSoundplayer.Playlist.Songs_Edit.Delete_Glow.GlowColor := TAlphaColorRec.Red;
  vSoundplayer.Playlist.Songs_Edit.Delete_Glow.Opacity := 0.9;
  vSoundplayer.Playlist.Songs_Edit.Delete_Glow.Enabled := False;

  vSoundplayer.Playlist.List_Line_Edit_Right := Timage.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.List_Line_Edit_Right.Name := 'A_SP_Playlist_Edit_Right_Line_Image';
  vSoundplayer.Playlist.List_Line_Edit_Right.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.List_Line_Edit_Right.SetBounds(vSoundplayer.Playlist.List.Width + 80, 0, 10, vSoundplayer.scene.Back_Playlist.Height);
  vSoundplayer.Playlist.List_Line_Edit_Right.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_spot.png');
  vSoundplayer.Playlist.List_Line_Edit_Right.WrapMode := TImageWrapMode.Stretch;
  vSoundplayer.Playlist.List_Line_Edit_Right.Visible := True;

  vSoundplayer.Playlist.Manage_Icon := TText.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.Manage_Icon.Name := 'A_SP_Playlist_Manage';
  vSoundplayer.Playlist.Manage_Icon.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.Manage_Icon.SetBounds(vSoundplayer.Playlist.List.Width + 108, 10, 32, 32);
  vSoundplayer.Playlist.Manage_Icon.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Playlist.Manage_Icon.Text := #$e9bb;
  vSoundplayer.Playlist.Manage_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Playlist.Manage_Icon.TextSettings.Font.Size := 32;
  vSoundplayer.Playlist.Manage_Icon.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Playlist.Manage_Icon.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Playlist.Manage_Icon.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Playlist.Manage_Icon.Visible := True;

  vSoundplayer.Playlist.Manage_Icon_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Manage_Icon);
  vSoundplayer.Playlist.Manage_Icon_Glow.Name := 'A_SP_Playlist_Manage_Glow';
  vSoundplayer.Playlist.Manage_Icon_Glow.Parent := vSoundplayer.Playlist.Manage_Icon;
  vSoundplayer.Playlist.Manage_Icon_Glow.Softness := 0.4;
  vSoundplayer.Playlist.Manage_Icon_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Playlist.Manage_Icon_Glow.Opacity := 0.9;
  vSoundplayer.Playlist.Manage_Icon_Glow.Enabled := False;

  vSoundplayer.Playlist.Create_Icon := TText.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.Create_Icon.Name := 'A_SP_Playlist_Add';
  vSoundplayer.Playlist.Create_Icon.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.Create_Icon.SetBounds(vSoundplayer.Playlist.List.Width + 108, 62, 32, 32);
  vSoundplayer.Playlist.Create_Icon.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Playlist.Create_Icon.Text := #$ea0a;
  vSoundplayer.Playlist.Create_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Playlist.Create_Icon.TextSettings.Font.Size := 32;
  vSoundplayer.Playlist.Create_Icon.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Playlist.Create_Icon.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Playlist.Create_Icon.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Playlist.Create_Icon.Visible := True;

  vSoundplayer.Playlist.Create_Icon_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Create_Icon);
  vSoundplayer.Playlist.Create_Icon_Glow.Name := 'A_SP_Playlist_Add_Glow';
  vSoundplayer.Playlist.Create_Icon_Glow.Parent := vSoundplayer.Playlist.Create_Icon;
  vSoundplayer.Playlist.Create_Icon_Glow.Softness := 0.4;
  vSoundplayer.Playlist.Create_Icon_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Playlist.Create_Icon_Glow.Opacity := 0.9;
  vSoundplayer.Playlist.Create_Icon_Glow.Enabled := False;

  vSoundplayer.Playlist.Remove_Icon := TText.Create(vSoundplayer.scene.Back_Playlist);
  vSoundplayer.Playlist.Remove_Icon.Name := 'A_SP_Playlist_Remove';
  vSoundplayer.Playlist.Remove_Icon.Parent := vSoundplayer.scene.Back_Playlist;
  vSoundplayer.Playlist.Remove_Icon.SetBounds(vSoundplayer.Playlist.List.Width + 108, 114, 32, 32);
  vSoundplayer.Playlist.Remove_Icon.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Playlist.Remove_Icon.Text := #$ea0b;
  vSoundplayer.Playlist.Remove_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Playlist.Remove_Icon.TextSettings.Font.Size := 32;
  vSoundplayer.Playlist.Remove_Icon.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Playlist.Remove_Icon.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Playlist.Remove_Icon.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Playlist.Remove_Icon.Visible := True;

  vSoundplayer.Playlist.Remove_Icon_Glow := TGlowEffect.Create(vSoundplayer.Playlist.Remove_Icon);
  vSoundplayer.Playlist.Remove_Icon_Glow.Name := 'A_SP_Playlist_Remove_Glow';
  vSoundplayer.Playlist.Remove_Icon_Glow.Parent := vSoundplayer.Playlist.Remove_Icon;
  vSoundplayer.Playlist.Remove_Icon_Glow.Softness := 0.4;
  vSoundplayer.Playlist.Remove_Icon_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Playlist.Remove_Icon_Glow.Opacity := 0.9;
  vSoundplayer.Playlist.Remove_Icon_Glow.Enabled := False;
end;

procedure Cover;
begin
  vSoundplayer.Info.Back_Right := Timage.Create(vSoundplayer.scene.Back);
  vSoundplayer.Info.Back_Right.Name := 'A_SP_BackInfo_BackRight_Image';
  vSoundplayer.Info.Back_Right.Parent := vSoundplayer.scene.Back;
  vSoundplayer.Info.Back_Right.SetBounds(vSoundplayer.scene.Back_Info.Width - 602, vSoundplayer.scene.Back_Info.Position.Y + 10, 600,
    vSoundplayer.scene.Back_Info.Height - 20);
  vSoundplayer.Info.Back_Right.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_back_info.png');
  vSoundplayer.Info.Back_Right.WrapMode := TImageWrapMode.Tile;
  vSoundplayer.Info.Back_Right.OnMouseEnter := addons.soundplayer.Input.mouse.Image.OnMouseEnter;
  vSoundplayer.Info.Back_Right.OnMouseLeave := addons.soundplayer.Input.mouse.Image.OnMouseLeave;
  vSoundplayer.Info.Back_Right.Visible := True;

  vSoundplayer.Info.Back_Right_Ani := TFloatAnimation.Create(vSoundplayer.Info.Back_Right);
  vSoundplayer.Info.Back_Right_Ani.Name := 'A_SP_BackInfo_BackRight_Animation';
  vSoundplayer.Info.Back_Right_Ani.Parent := vSoundplayer.Info.Back_Right;
  vSoundplayer.Info.Back_Right_Ani.Delay := 6;
  vSoundplayer.Info.Back_Right_Ani.Duration := 0.6;
  vSoundplayer.Info.Back_Right_Ani.PropertyName := 'Position.X';
  vSoundplayer.Info.Back_Right_Ani.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.Info.Back_Right_Ani.Enabled := False;

  vSoundplayer.Info.Cover := Timage.Create(vSoundplayer.Info.Back_Right);
  vSoundplayer.Info.Cover.Name := 'A_SP_Info_Cover';
  vSoundplayer.Info.Cover.Parent := vSoundplayer.Info.Back_Right;
  vSoundplayer.Info.Cover.SetBounds(50, 50, 500, vSoundplayer.Info.Back_Right.Height - 100);
  vSoundplayer.Info.Cover.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_nocover.png');
  vSoundplayer.Info.Cover.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.Info.Cover.Visible := True;

  vSoundplayer.Info.Cover_Label := TText.Create(vSoundplayer.Info.Back_Right);
  vSoundplayer.Info.Cover_Label.Name := 'A_SP_Info_Cover_Label';
  vSoundplayer.Info.Cover_Label.Parent := vSoundplayer.Info.Back_Right;
  vSoundplayer.Info.Cover_Label.SetBounds(0, vSoundplayer.Info.Back_Right.Height - 30, vSoundplayer.Info.Back_Right.Width, 26);
  vSoundplayer.Info.Cover_Label.Color := TAlphaColorRec.White;
  vSoundplayer.Info.Cover_Label.Text := '';
  vSoundplayer.Info.Cover_Label.TextSettings.HorzAlign := TTextAlign.Center;
  vSoundplayer.Info.Cover_Label.TextSettings.Font.Size := 22;
  vSoundplayer.Info.Cover_Label.Visible := True;

  vSoundplayer.Info.Cover_Fade_Ani := TFloatAnimation.Create(vSoundplayer.Info.Cover);
  vSoundplayer.Info.Cover_Fade_Ani.Name := 'A_SP_Info_Cover_Fade_Animation';
  vSoundplayer.Info.Cover_Fade_Ani.Parent := vSoundplayer.Info.Cover;
  vSoundplayer.Info.Cover_Fade_Ani.Duration := 0.4;
  vSoundplayer.Info.Cover_Fade_Ani.PropertyName := 'Opacity';
  vSoundplayer.Info.Cover_Fade_Ani.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.Info.Cover_Fade_Ani.Enabled := False;

  vSoundplayer.Info.Cover_Fullscreen := TText.Create(vSoundplayer.Info.Back_Right);
  vSoundplayer.Info.Cover_Fullscreen.Name := 'A_SP_Info_Cover_Fullscreen';
  vSoundplayer.Info.Cover_Fullscreen.Parent := vSoundplayer.Info.Back_Right;
  vSoundplayer.Info.Cover_Fullscreen.SetBounds(20, 20, 36, 36);
  vSoundplayer.Info.Cover_Fullscreen.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Info.Cover_Fullscreen.Text := #$e989;
  vSoundplayer.Info.Cover_Fullscreen.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Info.Cover_Fullscreen.TextSettings.Font.Size := 36;
  vSoundplayer.Info.Cover_Fullscreen.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Info.Cover_Fullscreen.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Info.Cover_Fullscreen.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Info.Cover_Fullscreen.Visible := True;

  vSoundplayer.Info.Cover_Fullscreen_Glow := TGlowEffect.Create(vSoundplayer.Info.Cover_Fullscreen);
  vSoundplayer.Info.Cover_Fullscreen_Glow.Name := 'A_SP_Info_Cover_Fullscreen_Glow';
  vSoundplayer.Info.Cover_Fullscreen_Glow.Parent := vSoundplayer.Info.Cover_Fullscreen;
  vSoundplayer.Info.Cover_Fullscreen_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Info.Cover_Fullscreen_Glow.Softness := 0.4;
  vSoundplayer.Info.Cover_Fullscreen_Glow.Opacity := 0.9;
  vSoundplayer.Info.Cover_Fullscreen_Glow.Enabled := False;

  vSoundplayer.Info.Cover_Fullscreen_Ani_Pos_X := TFloatAnimation.Create(vSoundplayer.Info.Back_Right);
  vSoundplayer.Info.Cover_Fullscreen_Ani_Pos_X.Name := 'A_SP_Info_Cover_Fullscreen_Animation_Pos_X';
  vSoundplayer.Info.Cover_Fullscreen_Ani_Pos_X.Parent := vSoundplayer.Info.Back_Right;
  vSoundplayer.Info.Cover_Fullscreen_Ani_Pos_X.Duration := 0.2;
  vSoundplayer.Info.Cover_Fullscreen_Ani_Pos_X.PropertyName := 'Position.X';
  vSoundplayer.Info.Cover_Fullscreen_Ani_Pos_X.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.Info.Cover_Fullscreen_Ani_Pos_X.Enabled := False;

  vSoundplayer.Info.Cover_Fullscreen_Ani_Pos_Y := TFloatAnimation.Create(vSoundplayer.Info.Back_Right);
  vSoundplayer.Info.Cover_Fullscreen_Ani_Pos_Y.Name := 'A_SP_Info_Cover_Fullscreen_Animation_Pos_Y';
  vSoundplayer.Info.Cover_Fullscreen_Ani_Pos_Y.Parent := vSoundplayer.Info.Back_Right;
  vSoundplayer.Info.Cover_Fullscreen_Ani_Pos_Y.Duration := 0.2;
  vSoundplayer.Info.Cover_Fullscreen_Ani_Pos_Y.PropertyName := 'Position.Y';
  vSoundplayer.Info.Cover_Fullscreen_Ani_Pos_Y.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.Info.Cover_Fullscreen_Ani_Pos_Y.Enabled := False;

  vSoundplayer.Info.Cover_Fullscreen_Ani_Width := TFloatAnimation.Create(vSoundplayer.Info.Back_Right);
  vSoundplayer.Info.Cover_Fullscreen_Ani_Width.Name := 'A_SP_Info_Cover_Fullscreen_Animation_Width';
  vSoundplayer.Info.Cover_Fullscreen_Ani_Width.Parent := vSoundplayer.Info.Back_Right;
  vSoundplayer.Info.Cover_Fullscreen_Ani_Width.Duration := 0.2;
  vSoundplayer.Info.Cover_Fullscreen_Ani_Width.PropertyName := 'Width';
  vSoundplayer.Info.Cover_Fullscreen_Ani_Width.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.Info.Cover_Fullscreen_Ani_Width.Enabled := False;

  vSoundplayer.Info.Cover_Fullscreen_Ani_Height := TFloatAnimation.Create(vSoundplayer.Info.Back_Right);
  vSoundplayer.Info.Cover_Fullscreen_Ani_Height.Name := 'A_SP_Info_Cover_Fullscreen_Animation_Height';
  vSoundplayer.Info.Cover_Fullscreen_Ani_Height.Parent := vSoundplayer.Info.Back_Right;
  vSoundplayer.Info.Cover_Fullscreen_Ani_Height.Duration := 0.2;
  vSoundplayer.Info.Cover_Fullscreen_Ani_Height.PropertyName := 'Height';
  vSoundplayer.Info.Cover_Fullscreen_Ani_Height.OnFinish := vSoundplayer.Ani.OnFinish;
  vSoundplayer.Info.Cover_Fullscreen_Ani_Height.Enabled := False;
end;

///
procedure Set_First;
begin
  vSoundplayer.scene.Back_Blur.Enabled := True;

  vSoundplayer.scene.First.Panel := TPanel.Create(vSoundplayer.scene.soundplayer);
  vSoundplayer.scene.First.Panel.Name := 'A_SP_First';
  vSoundplayer.scene.First.Panel.Parent := vSoundplayer.scene.soundplayer;
  vSoundplayer.scene.First.Panel.SetBounds(extrafe.res.Half_Width - 400, extrafe.res.Half_Height - 500, 800, 600);
  vSoundplayer.scene.First.Panel.Visible := True;

  vSoundplayer.scene.First.Panel_Shadow := TShadowEffect.Create(vSoundplayer.scene.First.Panel);
  vSoundplayer.scene.First.Panel_Shadow.Name := 'A_SP_Fist_Shadow';
  vSoundplayer.scene.First.Panel_Shadow.Parent := vSoundplayer.scene.First.Panel;
  vSoundplayer.scene.First.Panel_Shadow.ShadowColor := TAlphaColorRec.Black;
  vSoundplayer.scene.First.Panel_Shadow.Opacity := 0.9;
  vSoundplayer.scene.First.Panel_Shadow.Distance := 2;
  vSoundplayer.scene.First.Panel_Shadow.Direction := 90;
  vSoundplayer.scene.First.Panel_Shadow.Enabled := True;

  CreateHeader(vSoundplayer.scene.First.Panel, 'IcoMoon-Free', #$ea1c, 'Welcome to "Soundplayer" addon.');

  vSoundplayer.scene.First.main.Panel := TPanel.Create(vSoundplayer.scene.First.Panel);
  vSoundplayer.scene.First.main.Panel.Name := 'A_SP_Firt_Main';
  vSoundplayer.scene.First.main.Panel.Parent := vSoundplayer.scene.First.Panel;
  vSoundplayer.scene.First.main.Panel.SetBounds(0, 30, vSoundplayer.scene.First.Panel.Width, vSoundplayer.scene.First.Panel.Height - 30);
  vSoundplayer.scene.First.main.Panel.Visible := True;

  vSoundplayer.scene.First.main.Line_1 := TALText.Create(vSoundplayer.scene.First.main.Panel);
  vSoundplayer.scene.First.main.Line_1.Name := 'A_SP_First_Main_Line_1';
  vSoundplayer.scene.First.main.Line_1.Parent := vSoundplayer.scene.First.main.Panel;
  vSoundplayer.scene.First.main.Line_1.Width := 700;
  vSoundplayer.scene.First.main.Line_1.Height := 150;
  vSoundplayer.scene.First.main.Line_1.Position.X := 50;
  vSoundplayer.scene.First.main.Line_1.Position.Y := 30;
  vSoundplayer.scene.First.main.Line_1.TextIsHtml := True;
  vSoundplayer.scene.First.main.Line_1.TextSettings.Font.Size := 14;
  vSoundplayer.scene.First.main.Line_1.TextSettings.VertAlign := TTextAlign.Leading;
  vSoundplayer.scene.First.main.Line_1.WordWrap := True;
  vSoundplayer.scene.First.main.Line_1.Text := 'I assume this is your first time that open "<font color="#ff63cbfc">Soundplayer</font>" addon.';
  vSoundplayer.scene.First.main.Line_1.Color := TAlphaColorRec.White;
  vSoundplayer.scene.First.main.Line_1.Visible := True;

  vSoundplayer.scene.First.main.Line_2 := TALText.Create(vSoundplayer.scene.First.main.Panel);
  vSoundplayer.scene.First.main.Line_2.Name := 'A_SP_First_Main_Line_2';
  vSoundplayer.scene.First.main.Line_2.Parent := vSoundplayer.scene.First.main.Panel;
  vSoundplayer.scene.First.main.Line_2.Width := 700;
  vSoundplayer.scene.First.main.Line_2.Height := 150;
  vSoundplayer.scene.First.main.Line_2.Position.X := 50;
  vSoundplayer.scene.First.main.Line_2.Position.Y := 60;
  vSoundplayer.scene.First.main.Line_2.TextIsHtml := True;
  vSoundplayer.scene.First.main.Line_2.TextSettings.Font.Size := 14;
  vSoundplayer.scene.First.main.Line_2.TextSettings.VertAlign := TTextAlign.Leading;
  vSoundplayer.scene.First.main.Line_2.WordWrap := True;
  vSoundplayer.scene.First.main.Line_2.Text :=
    'To start listening song just <font color="#ff63cbfc">create a playlist, push the "+" button</font> and then add songs in playlist with the <font color="#ff63cbfc">eject button</font>, push play to start listening.'
    + #13#10 + 'Or just push the <font color="#ff63cbfc">eject button</font> to listen song in unamed playlist.';
  vSoundplayer.scene.First.main.Line_2.Color := TAlphaColorRec.White;
  vSoundplayer.scene.First.main.Line_2.Visible := True;

  vSoundplayer.scene.First.main.Line_3 := TALText.Create(vSoundplayer.scene.First.main.Panel);
  vSoundplayer.scene.First.main.Line_3.Name := 'A_SP_First_Main_Line_3';
  vSoundplayer.scene.First.main.Line_3.Parent := vSoundplayer.scene.First.main.Panel;
  vSoundplayer.scene.First.main.Line_3.Width := 700;
  vSoundplayer.scene.First.main.Line_3.Height := 150;
  vSoundplayer.scene.First.main.Line_3.Position.X := 50;
  vSoundplayer.scene.First.main.Line_3.Position.Y := 120;
  vSoundplayer.scene.First.main.Line_3.TextIsHtml := True;
  vSoundplayer.scene.First.main.Line_3.TextSettings.Font.Size := 14;
  vSoundplayer.scene.First.main.Line_3.TextSettings.VertAlign := TTextAlign.Leading;
  vSoundplayer.scene.First.main.Line_3.WordWrap := True;
  vSoundplayer.scene.First.main.Line_3.Text :=
    'This message also appears when you deactivate the soundplayer addon and delete all playlists and clear the addon.';
  vSoundplayer.scene.First.main.Line_3.Color := TAlphaColorRec.White;
  vSoundplayer.scene.First.main.Line_3.Visible := True;

  vSoundplayer.scene.First.main.Line_4 := TALText.Create(vSoundplayer.scene.First.main.Panel);
  vSoundplayer.scene.First.main.Line_4.Name := 'A_SP_First_Main_Line_4';
  vSoundplayer.scene.First.main.Line_4.Parent := vSoundplayer.scene.First.main.Panel;
  vSoundplayer.scene.First.main.Line_4.Width := 700;
  vSoundplayer.scene.First.main.Line_4.Height := 150;
  vSoundplayer.scene.First.main.Line_4.Position.X := 50;
  vSoundplayer.scene.First.main.Line_4.Position.Y := 180;
  vSoundplayer.scene.First.main.Line_4.TextIsHtml := True;
  vSoundplayer.scene.First.main.Line_4.TextSettings.Font.Size := 14;
  vSoundplayer.scene.First.main.Line_4.TextSettings.VertAlign := TTextAlign.Leading;
  vSoundplayer.scene.First.main.Line_4.WordWrap := True;
  vSoundplayer.scene.First.main.Line_4.Text := '" <font color="#ffff0000">I love home music. Have Fun </font>" ';
  vSoundplayer.scene.First.main.Line_4.Color := TAlphaColorRec.White;
  vSoundplayer.scene.First.main.Line_4.Visible := True;

  vSoundplayer.scene.First.main.Check := TCheckBox.Create(vSoundplayer.scene.First.main.Panel);
  vSoundplayer.scene.First.main.Check.Name := 'A_SP_First_Main_Check';
  vSoundplayer.scene.First.main.Check.Parent := vSoundplayer.scene.First.main.Panel;
  vSoundplayer.scene.First.main.Check.Width := 400;
  vSoundplayer.scene.First.main.Check.Height := 24;
  vSoundplayer.scene.First.main.Check.Position.X := 20;
  vSoundplayer.scene.First.main.Check.Position.Y := vSoundplayer.scene.First.main.Panel.Height - 70;
  vSoundplayer.scene.First.main.Check.Text := 'Check to never see this message again.';
  vSoundplayer.scene.First.main.Check.FontColor := TAlphaColorRec.White;
  vSoundplayer.scene.First.main.Check.OnClick := addons.soundplayer.Input.mouse.Checkbox.OnMouseClick;
  vSoundplayer.scene.First.main.Check.Visible := True;

  vSoundplayer.scene.First.main.Done := TButton.Create(vSoundplayer.scene.First.main.Panel);
  vSoundplayer.scene.First.main.Done.Name := 'A_SP_First_Main_Done';
  vSoundplayer.scene.First.main.Done.Parent := vSoundplayer.scene.First.main.Panel;
  vSoundplayer.scene.First.main.Done.Width := 120;
  vSoundplayer.scene.First.main.Done.Height := 30;
  vSoundplayer.scene.First.main.Done.Position.X := (vSoundplayer.scene.First.main.Panel.Width / 2) - 60;
  vSoundplayer.scene.First.main.Done.Position.Y := vSoundplayer.scene.First.main.Panel.Height - 40;
  vSoundplayer.scene.First.main.Done.Text := 'Done';
  vSoundplayer.scene.First.main.Done.OnClick := addons.soundplayer.Input.mouse.Button.OnMouseClick;
  vSoundplayer.scene.First.main.Done.Visible := True;
end;

///
procedure RemoveSong_Dialog;
begin
  vSoundplayer.Playlist.Remove_Song.Remove := TPanel.Create(vSoundplayer.scene.soundplayer);
  vSoundplayer.Playlist.Remove_Song.Remove.Name := 'A_SP_Playlist_Edit_Song_Remove';
  vSoundplayer.Playlist.Remove_Song.Remove.Parent := vSoundplayer.scene.soundplayer;
  vSoundplayer.Playlist.Remove_Song.Remove.SetBounds(extrafe.res.Half_Width - 250, extrafe.res.Half_Height - 75, 500, 140);
  vSoundplayer.Playlist.Remove_Song.Remove.Visible := True;

  CreateHeader(vSoundplayer.Playlist.Remove_Song.Remove, 'IcoMoon-Free', #$ea0f, 'remove this song from the playlist?');

  vSoundplayer.Playlist.Remove_Song.main.Panel := TPanel.Create(vSoundplayer.Playlist.Remove_Song.Remove);
  vSoundplayer.Playlist.Remove_Song.main.Panel.Name := 'A_SP_Playlist_Edit_Song_Remove_Main';
  vSoundplayer.Playlist.Remove_Song.main.Panel.Parent := vSoundplayer.Playlist.Remove_Song.Remove;
  vSoundplayer.Playlist.Remove_Song.main.Panel.SetBounds(0, 30, vSoundplayer.Playlist.Remove_Song.Remove.Width,
    vSoundplayer.Playlist.Remove_Song.Remove.Height - 30);
  vSoundplayer.Playlist.Remove_Song.main.Panel.Visible := True;

  vSoundplayer.Playlist.Remove_Song.main.Icon := Timage.Create(vSoundplayer.Playlist.Remove_Song.main.Panel);
  vSoundplayer.Playlist.Remove_Song.main.Icon.Name := 'A_SP_Playlist_Edit_Song_Remove_Icon';
  vSoundplayer.Playlist.Remove_Song.main.Icon.Parent := vSoundplayer.Playlist.Remove_Song.main.Panel;
  vSoundplayer.Playlist.Remove_Song.main.Icon.SetBounds(20, 20, 36, 36);
  vSoundplayer.Playlist.Remove_Song.main.Icon.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'sp_warning.png');
  vSoundplayer.Playlist.Remove_Song.main.Icon.Visible := True;

  vSoundplayer.Playlist.Remove_Song.main.Text := TLabel.Create(vSoundplayer.Playlist.Remove_Song.main.Panel);
  vSoundplayer.Playlist.Remove_Song.main.Text.Name := 'A_SP_Playlist_Edit_Song_Remove_Text';
  vSoundplayer.Playlist.Remove_Song.main.Text.Parent := vSoundplayer.Playlist.Remove_Song.main.Panel;
  vSoundplayer.Playlist.Remove_Song.main.Text.SetBounds(70, 28, 420, 24);
  vSoundplayer.Playlist.Remove_Song.main.Text.Text := 'Do you want to remove the "' + addons.soundplayer.Playlist.List.Song_Info
    [vSoundplayer.Playlist.List.Selected].Title + '" ?';
  vSoundplayer.Playlist.Remove_Song.main.Text.Font.Style := vSoundplayer.Playlist.Remove_Song.main.Text.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.Playlist.Remove_Song.main.Text.Visible := True;

  vSoundplayer.Playlist.Remove_Song.main.Erase := TButton.Create(vSoundplayer.Playlist.Remove_Song.main.Panel);
  vSoundplayer.Playlist.Remove_Song.main.Erase.Name := 'A_SP_Playlist_Edit_Song_Remove_Erase';
  vSoundplayer.Playlist.Remove_Song.main.Erase.Parent := vSoundplayer.Playlist.Remove_Song.main.Panel;
  vSoundplayer.Playlist.Remove_Song.main.Erase.SetBounds(100, vSoundplayer.Playlist.Remove_Song.main.Panel.Height - 34, 100, 24);
  vSoundplayer.Playlist.Remove_Song.main.Erase.Text := 'Remove';
  vSoundplayer.Playlist.Remove_Song.main.Erase.OnClick := addons.soundplayer.Input.mouse.Button.OnMouseClick;
  vSoundplayer.Playlist.Remove_Song.main.Erase.Visible := True;

  vSoundplayer.Playlist.Remove_Song.main.Cancel := TButton.Create(vSoundplayer.Playlist.Remove_Song.main.Panel);
  vSoundplayer.Playlist.Remove_Song.main.Cancel.Name := 'A_SP_Playlist_Edit_Song_Remove_Cancel';
  vSoundplayer.Playlist.Remove_Song.main.Cancel.Parent := vSoundplayer.Playlist.Remove_Song.main.Panel;
  vSoundplayer.Playlist.Remove_Song.main.Cancel.SetBounds(vSoundplayer.Playlist.Remove_Song.main.Panel.Width - 200,
    vSoundplayer.Playlist.Remove_Song.main.Panel.Height - 34, 100, 24);
  vSoundplayer.Playlist.Remove_Song.main.Cancel.Text := 'Cancel';
  vSoundplayer.Playlist.Remove_Song.main.Cancel.OnClick := addons.soundplayer.Input.mouse.Button.OnMouseClick;
  vSoundplayer.Playlist.Remove_Song.main.Cancel.Visible := True;
end;

procedure Band_Information;
begin
  vSoundplayer.scene.Back_Blur.Enabled := True;
  vSoundplayer.scene.Back_Presentation.Visible := True;

  vSoundplayer.Player.Band_Info_Press.Box := TVertScrollBox.Create(vSoundplayer.scene.Back_Presentation);
  vSoundplayer.Player.Band_Info_Press.Box.Name := 'A_SP_Bandinfo_Box';
  vSoundplayer.Player.Band_Info_Press.Box.Parent := vSoundplayer.scene.Back_Presentation;
  vSoundplayer.Player.Band_Info_Press.Box.SetBounds(0, 0, vSoundplayer.scene.Back_Presentation.Width, vSoundplayer.scene.Back_Presentation.Height);
  vSoundplayer.Player.Band_Info_Press.Box.Visible := True;

  vSoundplayer.Player.Band_Info_Press.Header := TRectangle.Create(vSoundplayer.scene.Back_Presentation);
  vSoundplayer.Player.Band_Info_Press.Header.Name := 'A_SP_BandInfo_Header';
  vSoundplayer.Player.Band_Info_Press.Header.Parent := vSoundplayer.scene.Back_Presentation;
  vSoundplayer.Player.Band_Info_Press.Header.SetBounds(0, 0, vSoundplayer.scene.Back_Presentation.Width, 80);
  vSoundplayer.Player.Band_Info_Press.Header.Fill.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Band_Info_Press.Header.Opacity := 0.5;
  vSoundplayer.Player.Band_Info_Press.Header.Visible := True;

  vSoundplayer.Player.Band_Info_Press.Name := TText.Create(vSoundplayer.scene.Back_Presentation);
  vSoundplayer.Player.Band_Info_Press.Name.Name := 'A_SP_Bandinfo_Text';
  vSoundplayer.Player.Band_Info_Press.Name.Parent := vSoundplayer.scene.Back_Presentation;
  vSoundplayer.Player.Band_Info_Press.Name.SetBounds(30, 20, vSoundplayer.Player.Band_Info_Press.Box.Width - 60, 40);
  vSoundplayer.Player.Band_Info_Press.Name.Font.Family := 'Tahoma';
  vSoundplayer.Player.Band_Info_Press.Name.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.Player.Band_Info_Press.Name.Font.Size := 36;
  vSoundplayer.Player.Band_Info_Press.Name.Text := '';
  vSoundplayer.Player.Band_Info_Press.Name.Visible := True;

  vSoundplayer.Player.Band_Info_Press.Powered_By := TText.Create(vSoundplayer.scene.Back_Presentation);
  vSoundplayer.Player.Band_Info_Press.Powered_By.Name := 'A_SP_BandInfo_Powered_Text';
  vSoundplayer.Player.Band_Info_Press.Powered_By.Parent := vSoundplayer.scene.Back_Presentation;
  vSoundplayer.Player.Band_Info_Press.Powered_By.SetBounds(vSoundplayer.scene.Back_Presentation.Width - 190, 48, 160, 30);
  vSoundplayer.Player.Band_Info_Press.Powered_By.Font.Family := 'Tahoma';
  vSoundplayer.Player.Band_Info_Press.Powered_By.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.Player.Band_Info_Press.Powered_By.Font.Size := 18;
  vSoundplayer.Player.Band_Info_Press.Powered_By.Text := 'Powered by : ';
  vSoundplayer.Player.Band_Info_Press.Powered_By.Visible := True;

  vSoundplayer.Player.Band_Info_Press.Powered_Img := Timage.Create(vSoundplayer.scene.Back_Presentation);
  vSoundplayer.Player.Band_Info_Press.Powered_Img.Name := 'A_SP_BandInfo_Powered_Image';
  vSoundplayer.Player.Band_Info_Press.Powered_Img.Parent := vSoundplayer.scene.Back_Presentation;
  vSoundplayer.Player.Band_Info_Press.Powered_Img.SetBounds(vSoundplayer.scene.Back_Presentation.Width - 48, 38, 36, 36);
  vSoundplayer.Player.Band_Info_Press.Powered_Img.WrapMode := TImageWrapMode.Stretch;
  vSoundplayer.Player.Band_Info_Press.Powered_Img.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'scrapers/lastfm.png');
  vSoundplayer.Player.Band_Info_Press.Powered_Img.WrapMode := TImageWrapMode.Stretch;
  vSoundplayer.Player.Band_Info_Press.Powered_Img.Visible := True;

  vSoundplayer.Player.Band_Info_Press.Close := TText.Create(vSoundplayer.scene.Back_Presentation);
  vSoundplayer.Player.Band_Info_Press.Close.Name := 'A_SP_Bandinfo_Close';
  vSoundplayer.Player.Band_Info_Press.Close.Parent := vSoundplayer.scene.Back_Presentation;
  vSoundplayer.Player.Band_Info_Press.Close.SetBounds(vSoundplayer.scene.Back_Presentation.Width - 12, -12, 24, 24);
  vSoundplayer.Player.Band_Info_Press.Close.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Player.Band_Info_Press.Close.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Band_Info_Press.Close.Font.Size := 24;
  vSoundplayer.Player.Band_Info_Press.Close.Text := #$ea0f;
  vSoundplayer.Player.Band_Info_Press.Close.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Player.Band_Info_Press.Close.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Player.Band_Info_Press.Close.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Player.Band_Info_Press.Close.Visible := True;

  vSoundplayer.Player.Band_Info_Press.Close_Glow := TGlowEffect.Create(vSoundplayer.Player.Band_Info_Press.Close);
  vSoundplayer.Player.Band_Info_Press.Close_Glow.Name := 'A_SP_Bandinfo_Close_Glow';
  vSoundplayer.Player.Band_Info_Press.Close_Glow.Parent := vSoundplayer.Player.Band_Info_Press.Close;
  vSoundplayer.Player.Band_Info_Press.Close_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Band_Info_Press.Close_Glow.Opacity := 0.9;
  vSoundplayer.Player.Band_Info_Press.Close_Glow.Enabled := False;

  vSoundplayer.Player.Band_Info_Press.Image := Timage.Create(vSoundplayer.Player.Band_Info_Press.Box);
  vSoundplayer.Player.Band_Info_Press.Image.Name := 'A_SP_Bandinfo_Image';
  vSoundplayer.Player.Band_Info_Press.Image.Parent := vSoundplayer.Player.Band_Info_Press.Box;
  vSoundplayer.Player.Band_Info_Press.Image.SetBounds(30, 85, 300, 300);
  vSoundplayer.Player.Band_Info_Press.Image.WrapMode := TImageWrapMode.Stretch;
  vSoundplayer.Player.Band_Info_Press.Image.Visible := True;

  vSoundplayer.Player.Band_Info_Press.Memo_Sum := TMemo.Create(vSoundplayer.Player.Band_Info_Press.Box);
  vSoundplayer.Player.Band_Info_Press.Memo_Sum.Name := 'A_SP_Bandinfo_MemoSum';
  vSoundplayer.Player.Band_Info_Press.Memo_Sum.Parent := vSoundplayer.Player.Band_Info_Press.Box;
  vSoundplayer.Player.Band_Info_Press.Memo_Sum.SetBounds(360, 85, vSoundplayer.Player.Band_Info_Press.Box.Width - 390, 300);
  vSoundplayer.Player.Band_Info_Press.Memo_Sum.ReadOnly := True;
  vSoundplayer.Player.Band_Info_Press.Memo_Sum.WordWrap := True;
  vSoundplayer.Player.Band_Info_Press.Memo_Sum.Visible := True;

  vSoundplayer.Player.Band_Info_Press.Memo_Comm := TMemo.Create(vSoundplayer.Player.Band_Info_Press.Box);
  vSoundplayer.Player.Band_Info_Press.Memo_Comm.Name := 'A_SP_Bandinfo_MemoComm';
  vSoundplayer.Player.Band_Info_Press.Memo_Comm.Parent := vSoundplayer.Player.Band_Info_Press.Box;
  vSoundplayer.Player.Band_Info_Press.Memo_Comm.SetBounds(30, 405, vSoundplayer.Player.Band_Info_Press.Box.Width - 60,
    vSoundplayer.Player.Band_Info_Press.Box.Height - 425);
  vSoundplayer.Player.Band_Info_Press.Memo_Comm.ReadOnly := True;
  vSoundplayer.Player.Band_Info_Press.Memo_Comm.WordWrap := True;
  vSoundplayer.Player.Band_Info_Press.Memo_Comm.Visible := True;
end;

procedure Lyrics;
begin
  vSoundplayer.scene.Back_Blur.Enabled := True;
  vSoundplayer.scene.Back_Presentation.Visible := True;

  vSoundplayer.Player.Lyrics_Press.Box := TVertScrollBox.Create(vSoundplayer.scene.Back_Presentation);
  vSoundplayer.Player.Lyrics_Press.Box.Name := 'A_SP_Lyrics_Box';
  vSoundplayer.Player.Lyrics_Press.Box.Parent := vSoundplayer.scene.Back_Presentation;
  vSoundplayer.Player.Lyrics_Press.Box.SetBounds(0, 80, vSoundplayer.scene.Back_Presentation.Width, vSoundplayer.scene.Back_Presentation.Height - 80);
  vSoundplayer.Player.Lyrics_Press.Box.Visible := True;

  vSoundplayer.Player.Lyrics_Press.Header := TRectangle.Create(vSoundplayer.scene.Back_Presentation);
  vSoundplayer.Player.Lyrics_Press.Header.Name := 'A_SP_Lyrics_Header';
  vSoundplayer.Player.Lyrics_Press.Header.Parent := vSoundplayer.scene.Back_Presentation;
  vSoundplayer.Player.Lyrics_Press.Header.SetBounds(0, 0, vSoundplayer.scene.Back_Presentation.Width, 80);
  vSoundplayer.Player.Lyrics_Press.Header.Fill.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Lyrics_Press.Header.Opacity := 0.5;
  vSoundplayer.Player.Lyrics_Press.Header.Visible := True;

  vSoundplayer.Player.Lyrics_Press.Name := TText.Create(vSoundplayer.scene.Back_Presentation);
  vSoundplayer.Player.Lyrics_Press.Name.Name := 'A_SP_Lyrics_SongName';
  vSoundplayer.Player.Lyrics_Press.Name.Parent := vSoundplayer.scene.Back_Presentation;
  vSoundplayer.Player.Lyrics_Press.Name.SetBounds(30, 20, vSoundplayer.scene.Back_Presentation.Width - 60, 40);
  vSoundplayer.Player.Lyrics_Press.Name.Font.Family := 'Tahoma';
  vSoundplayer.Player.Lyrics_Press.Name.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.Player.Lyrics_Press.Name.Font.Size := 36;
  vSoundplayer.Player.Lyrics_Press.Name.Opacity := 1;
  vSoundplayer.Player.Lyrics_Press.Name.Text := '';
  vSoundplayer.Player.Lyrics_Press.Name.Visible := True;

  vSoundplayer.Player.Lyrics_Press.Close := TText.Create(vSoundplayer.scene.Back_Presentation);
  vSoundplayer.Player.Lyrics_Press.Close.Name := 'A_SP_Lyrics_Close';
  vSoundplayer.Player.Lyrics_Press.Close.Parent := vSoundplayer.scene.Back_Presentation;
  vSoundplayer.Player.Lyrics_Press.Close.SetBounds(vSoundplayer.scene.Back_Presentation.Width - 12, -12, 24, 24);
  vSoundplayer.Player.Lyrics_Press.Close.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Player.Lyrics_Press.Close.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Lyrics_Press.Close.Font.Size := 24;
  vSoundplayer.Player.Lyrics_Press.Close.Text := #$ea0f;
  vSoundplayer.Player.Lyrics_Press.Close.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Player.Lyrics_Press.Close.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Player.Lyrics_Press.Close.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Player.Lyrics_Press.Close.Visible := True;

  vSoundplayer.Player.Lyrics_Press.Close_Glow := TGlowEffect.Create(vSoundplayer.Player.Lyrics_Press.Close);
  vSoundplayer.Player.Lyrics_Press.Close_Glow.Name := 'A_SP_Lyrics_Close_Glow';
  vSoundplayer.Player.Lyrics_Press.Close_Glow.Parent := vSoundplayer.Player.Lyrics_Press.Close;
  vSoundplayer.Player.Lyrics_Press.Close_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Lyrics_Press.Close_Glow.Opacity := 0.9;
  vSoundplayer.Player.Lyrics_Press.Close_Glow.Enabled := False;

end;

procedure Album_Information;
begin
  vSoundplayer.scene.Back_Blur.Enabled := True;
  vSoundplayer.scene.Back_Presentation.Visible := True;

  vSoundplayer.Player.Album_Info_Press.Box := TVertScrollBox.Create(vSoundplayer.scene.Back_Presentation);
  vSoundplayer.Player.Album_Info_Press.Box.Name := 'A_SP_Album_Box';
  vSoundplayer.Player.Album_Info_Press.Box.Parent := vSoundplayer.scene.Back_Presentation;
  vSoundplayer.Player.Album_Info_Press.Box.SetBounds(0, 0, vSoundplayer.scene.Back_Presentation.Width, vSoundplayer.scene.Back_Presentation.Height);
  vSoundplayer.Player.Album_Info_Press.Box.Visible := True;

  vSoundplayer.Player.Album_Info_Press.Header := TRectangle.Create(vSoundplayer.scene.Back_Presentation);
  vSoundplayer.Player.Album_Info_Press.Header.Name := 'A_SP_Album_Header';
  vSoundplayer.Player.Album_Info_Press.Header.Parent := vSoundplayer.scene.Back_Presentation;
  vSoundplayer.Player.Album_Info_Press.Header.SetBounds(0, 0, vSoundplayer.scene.Back_Presentation.Width, 80);
  vSoundplayer.Player.Album_Info_Press.Header.Fill.Color := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Album_Info_Press.Header.Opacity := 0.5;
  vSoundplayer.Player.Album_Info_Press.Header.Visible := True;

  vSoundplayer.Player.Album_Info_Press.Name := TText.Create(vSoundplayer.scene.Back_Presentation);
  vSoundplayer.Player.Album_Info_Press.Name.Name := 'A_SP_Album_SongName';
  vSoundplayer.Player.Album_Info_Press.Name.Parent := vSoundplayer.scene.Back_Presentation;
  vSoundplayer.Player.Album_Info_Press.Name.SetBounds(30, 20, vSoundplayer.scene.Back_Presentation.Width - 60, 40);
  vSoundplayer.Player.Album_Info_Press.Name.Font.Family := 'Tahoma';
  vSoundplayer.Player.Album_Info_Press.Name.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.Player.Album_Info_Press.Name.Font.Size := 36;
  vSoundplayer.Player.Album_Info_Press.Name.Text := '';
  vSoundplayer.Player.Album_Info_Press.Name.Visible := True;

  vSoundplayer.Player.Album_Info_Press.Powered_By := TText.Create(vSoundplayer.scene.Back_Presentation);
  vSoundplayer.Player.Album_Info_Press.Powered_By.Name := 'A_SP_Album_Powered_Text';
  vSoundplayer.Player.Album_Info_Press.Powered_By.Parent := vSoundplayer.scene.Back_Presentation;
  vSoundplayer.Player.Album_Info_Press.Powered_By.SetBounds(vSoundplayer.scene.Back_Presentation.Width - 190, 48, 160, 30);
  vSoundplayer.Player.Album_Info_Press.Powered_By.Font.Family := 'Tahoma';
  vSoundplayer.Player.Album_Info_Press.Powered_By.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.Player.Album_Info_Press.Powered_By.Font.Size := 18;
  vSoundplayer.Player.Album_Info_Press.Powered_By.Text := 'Powered by : ';
  vSoundplayer.Player.Album_Info_Press.Powered_By.Visible := True;

  vSoundplayer.Player.Album_Info_Press.Powered_Img := Timage.Create(vSoundplayer.scene.Back_Presentation);
  vSoundplayer.Player.Album_Info_Press.Powered_Img.Name := 'A_SP_Album_Powered_Image';
  vSoundplayer.Player.Album_Info_Press.Powered_Img.Parent := vSoundplayer.scene.Back_Presentation;
  vSoundplayer.Player.Album_Info_Press.Powered_Img.SetBounds(vSoundplayer.scene.Back_Presentation.Width - 48, 38, 36, 36);
  vSoundplayer.Player.Album_Info_Press.Powered_Img.WrapMode := TImageWrapMode.Stretch;
  vSoundplayer.Player.Album_Info_Press.Powered_Img.Bitmap.LoadFromFile(addons.soundplayer.Path.Images + 'scrapers/lastfm.png');
  vSoundplayer.Player.Album_Info_Press.Powered_Img.WrapMode := TImageWrapMode.Stretch;
  vSoundplayer.Player.Album_Info_Press.Powered_Img.Visible := True;

  vSoundplayer.Player.Album_Info_Press.Close := TText.Create(vSoundplayer.scene.Back_Presentation);
  vSoundplayer.Player.Album_Info_Press.Close.Name := 'A_SP_Album_Close';
  vSoundplayer.Player.Album_Info_Press.Close.Parent := vSoundplayer.scene.Back_Presentation;
  vSoundplayer.Player.Album_Info_Press.Close.SetBounds(vSoundplayer.scene.Back_Presentation.Width - 12, -12, 24, 24);
  vSoundplayer.Player.Album_Info_Press.Close.Font.Family := 'IcoMoon-Free';
  vSoundplayer.Player.Album_Info_Press.Close.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Album_Info_Press.Close.Font.Size := 24;
  vSoundplayer.Player.Album_Info_Press.Close.Text := #$ea0f;
  vSoundplayer.Player.Album_Info_Press.Close.OnClick := addons.soundplayer.Input.mouse.Text.OnMouseClick;
  vSoundplayer.Player.Album_Info_Press.Close.OnMouseEnter := addons.soundplayer.Input.mouse.Text.OnMouseEnter;
  vSoundplayer.Player.Album_Info_Press.Close.OnMouseLeave := addons.soundplayer.Input.mouse.Text.OnMouseLeave;
  vSoundplayer.Player.Album_Info_Press.Close.Visible := True;

  vSoundplayer.Player.Album_Info_Press.Close_Glow := TGlowEffect.Create(vSoundplayer.Player.Band_Info_Press.Close);
  vSoundplayer.Player.Album_Info_Press.Close_Glow.Name := 'A_SP_Album_Close_Glow';
  vSoundplayer.Player.Album_Info_Press.Close_Glow.Parent := vSoundplayer.Player.Album_Info_Press.Close;
  vSoundplayer.Player.Album_Info_Press.Close_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.Player.Album_Info_Press.Close_Glow.Opacity := 0.9;
  vSoundplayer.Player.Album_Info_Press.Close_Glow.Enabled := False;

  vSoundplayer.Player.Album_Info_Press.Image := Timage.Create(vSoundplayer.Player.Album_Info_Press.Box);
  vSoundplayer.Player.Album_Info_Press.Image.Name := 'A_SP_Album_Image';
  vSoundplayer.Player.Album_Info_Press.Image.Parent := vSoundplayer.Player.Album_Info_Press.Box;
  vSoundplayer.Player.Album_Info_Press.Image.SetBounds(30, 85, 400, 400);
  vSoundplayer.Player.Album_Info_Press.Image.WrapMode := TImageWrapMode.Stretch;
  vSoundplayer.Player.Album_Info_Press.Image.Visible := True;

  vSoundplayer.Player.Album_Info_Press.TrackBox := TVertScrollBox.Create(vSoundplayer.Player.Album_Info_Press.Box);
  vSoundplayer.Player.Album_Info_Press.TrackBox.Name := 'A_SP_Album_Tracks';
  vSoundplayer.Player.Album_Info_Press.TrackBox.Parent := vSoundplayer.Player.Album_Info_Press.Box;
  vSoundplayer.Player.Album_Info_Press.TrackBox.SetBounds(30, 495, 400, vSoundplayer.Player.Album_Info_Press.Box.Height - 505);
  vSoundplayer.Player.Album_Info_Press.TrackBox.Visible := True;

  vSoundplayer.Player.Album_Info_Press.Memo_Sum := TMemo.Create(vSoundplayer.Player.Album_Info_Press.Box);
  vSoundplayer.Player.Album_Info_Press.Memo_Sum.Name := 'A_SP_Album_Summary';
  vSoundplayer.Player.Album_Info_Press.Memo_Sum.Parent := vSoundplayer.Player.Album_Info_Press.Box;
  vSoundplayer.Player.Album_Info_Press.Memo_Sum.SetBounds(440, 85, vSoundplayer.Player.Album_Info_Press.Box.Width - 450,
    vSoundplayer.Player.Album_Info_Press.Box.Height - 95);
  vSoundplayer.Player.Album_Info_Press.Memo_Sum.ReadOnly := True;
  vSoundplayer.Player.Album_Info_Press.Memo_Sum.WordWrap := True;
  vSoundplayer.Player.Album_Info_Press.Memo_Sum.Visible := True;
end;

end.
