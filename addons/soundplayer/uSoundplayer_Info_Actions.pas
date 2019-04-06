unit uSoundplayer_Info_Actions;

interface

uses
  System.Classes,
  FMX.Types,
  FMX.Objects;

procedure uSoundplayer_Info_Actions_StartAnimationCoverFullscreen;
procedure uSoundplayer_Info_Actions_ShowCoverFullscreen;

procedure uSoundplayer_Info_Actions_StartAnimationCoverExitFullscreen;
procedure uSoundplayer_Info_Actions_ShowCoverExitFullscreen;

implementation

uses
  uLoad_AllTypes,
  uSoundplayer_AllTypes,
  uSoundplayer_SetAll;

procedure uSoundplayer_Info_Actions_StartAnimationCoverFullscreen;
begin
  vSoundplayer.info.Cover.Visible:= False;

  addons.soundplayer.Info.isCoverInFullscreen:= True;

  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_X.StartValue := vSoundplayer.info.Back_Right.Position.X;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_X.StopValue := 0;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_X.AnimationType:= TAnimationType.&Out;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_X.Loop:= False;

  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_Y.StartValue := vSoundplayer.info.Back_Right.Position.Y;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_Y.StopValue := 10;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_Y.AnimationType:= TAnimationType.&Out;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_Y.Loop:= False;

  vSoundplayer.info.Cover_Fullscreen_Ani_Width.StartValue:= vSoundplayer.info.Back_Right.Width;
  vSoundplayer.info.Cover_Fullscreen_Ani_Width.StopValue:= extrafe.res.Width;
  vSoundplayer.info.Cover_Fullscreen_Ani_Width.AnimationType:= TAnimationType.&Out;
  vSoundplayer.info.Cover_Fullscreen_Ani_Width.Loop:= False;

  vSoundplayer.info.Cover_Fullscreen_Ani_Height.StartValue:= vSoundplayer.info.Back_Right.Height;
  vSoundplayer.info.Cover_Fullscreen_Ani_Height.StopValue:= extrafe.res.Height- 130;
  vSoundplayer.info.Cover_Fullscreen_Ani_Height.AnimationType:= TAnimationType.&Out;
  vSoundplayer.info.Cover_Fullscreen_Ani_Height.Loop:= False;

  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_X.Start;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_Y.Start;
  vSoundplayer.info.Cover_Fullscreen_Ani_Width.Start;
  vSoundplayer.info.Cover_Fullscreen_Ani_Height.Start;

end;

procedure uSoundplayer_Info_Actions_StartAnimationCoverExitFullscreen;
begin
  vSoundplayer.info.Cover.Visible:= False;

  addons.soundplayer.Info.isCoverInFullscreen:= False;

  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_X.StartValue := 0;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_X.StopValue := vSoundplayer.scene.Back_Info.Width - 602;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_X.AnimationType:= TAnimationType.&Out;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_X.Loop:= False;

  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_Y.StartValue :=  10;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_Y.StopValue := vSoundplayer.scene.Back_Info.Position.Y + 10;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_Y.AnimationType:= TAnimationType.&Out;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_Y.Loop:= False;

  vSoundplayer.info.Cover_Fullscreen_Ani_Width.StartValue:= vSoundplayer.info.Back_Right.Width;
  vSoundplayer.info.Cover_Fullscreen_Ani_Width.StopValue:= 600;
  vSoundplayer.info.Cover_Fullscreen_Ani_Width.AnimationType:= TAnimationType.&Out;
  vSoundplayer.info.Cover_Fullscreen_Ani_Width.Loop:= False;

  vSoundplayer.info.Cover_Fullscreen_Ani_Height.StartValue:= vSoundplayer.info.Back_Right.Height;
  vSoundplayer.info.Cover_Fullscreen_Ani_Height.StopValue:= vSoundplayer.scene.Back_Info.Height - 20;
  vSoundplayer.info.Cover_Fullscreen_Ani_Height.AnimationType:= TAnimationType.&Out;
  vSoundplayer.info.Cover_Fullscreen_Ani_Height.Loop:= False;

  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_X.Start;
  vSoundplayer.info.Cover_Fullscreen_Ani_Pos_Y.Start;
  vSoundplayer.info.Cover_Fullscreen_Ani_Width.Start;
  vSoundplayer.info.Cover_Fullscreen_Ani_Height.Start;
end;

procedure uSoundplayer_Info_Actions_ShowCoverExitFullscreen;
begin
  vSoundplayer.info.Cover_Fullscreen.Text:= #$e989;

  vSoundplayer.info.Cover.Width:= 500;
  vSoundplayer.info.Cover.Height:= vSoundplayer.info.Back_Right.Height - 100;
  vSoundplayer.info.Cover.Position.X:= 50;
  vSoundplayer.info.Cover.Position.Y:= 50;
  vSoundplayer.info.Cover.Opacity:= 0;
  vSoundplayer.info.Cover.WrapMode:= TImageWrapMode.Fit;
  vSoundplayer.info.Cover.Visible:= True;

  vSoundplayer.info.Cover_Fade_Ani.StartValue:= vSoundplayer.info.Cover.Opacity;
  vSoundplayer.info.Cover_Fade_Ani.StopValue:= 1;
  vSoundplayer.info.Cover_Fade_Ani.AnimationType:= TAnimationType.&InOut;
  vSoundplayer.info.Cover_Fade_Ani.Start;
end;

procedure uSoundplayer_Info_Actions_ShowCoverFullscreen;
begin
  vSoundplayer.info.Cover_Fullscreen.Text:= #$e98a;

  vSoundplayer.info.Cover.Width:= extrafe.res.Width - 200;
  vSoundplayer.info.Cover.Height:= vSoundplayer.info.Back_Right.Height - 100;
  vSoundplayer.info.Cover.Position.X:= 100;
  vSoundplayer.info.Cover.Position.Y:= 50;
  vSoundplayer.info.Cover.Opacity:= 0;
  vSoundplayer.info.Cover.WrapMode:= TImageWrapMode.Center;
  vSoundplayer.info.Cover.WrapMode:= TImageWrapMode.Fit;
  vSoundplayer.info.Cover.Visible:= True;

  vSoundplayer.info.Cover_Fade_Ani.StartValue:= vSoundplayer.info.Cover.Opacity;
  vSoundplayer.info.Cover_Fade_Ani.StopValue:= 1;
  vSoundplayer.info.Cover_Fade_Ani.AnimationType:= TAnimationType.&InOut;
  vSoundplayer.info.Cover_Fade_Ani.Start;

end;

end.
