unit uMain_Actions;

interface

uses
  System.Classes,
  System.SysUtils,
  FMX.Types,
  BASS;

type
  TMAIN_TIMER = class(TObject)
    procedure OnTimer(Sender: TObject);
  end;

procedure ShowAvatar;

procedure ShowHide_Addon(vNum: Integer; mShow: String; mAddonName: string);
procedure Set_Addon_Icon_Active(vNum: Integer);
procedure All_Icons_Active(vNum: Integer);

procedure Update_All;
procedure Update_Footer_Timer;

var
  vMain_Timer: TMAIN_TIMER;

  // Emulator number
  // 0 MAME

implementation

uses
  uLoad_AllTypes,
  uDatabase_ActiveUser,
  uMain_AllTypes,
  uMain_Config,
  uTime_AllTypes,
  uWeather_AllTypes,
  uWeather_Actions,
  uSoundplayer_AllTypes,
  uSoundplayer_Player,
  uPlay_Actions;

procedure ShowAvatar;
begin
  mainScene.Header.Avatar_Glow.Enabled := False;
  uMain_Config_ShowHide('main');
  uMain_Config_ShowPanel(0);
  ex_main.Config.Active_Panel := 0;
end;

procedure ShowHide_Addon(vNum: Integer; mShow: string; mAddonName: string);
begin
  if mainScene.Header.Back_Blur.Enabled = False then
  begin
    if emulation.Selection_Ani.Enabled = False then
      if mShow = 'main' then
      begin
        emulation.Selection_Ani.StartValue := ex_main.Settings.MainSelection_Pos.Y;
        emulation.Selection_Ani.StopValue := extrafe.res.Height;
        mainScene.Footer.Back_Ani.StartValue := ex_main.Settings.Footer_Pos.Y;
        mainScene.Footer.Back_Ani.StopValue := extrafe.res.Height;
        emulation.Selection_Ani.Enabled := True;
        mainScene.Footer.Back_Ani.Enabled := True;
        Set_Addon_Icon_Active(vNum);
        extrafe.prog.State := 'addon_' + mAddonName;
        BASS_ChannelPlay(sound.str_fx.general[10], False);
      end
      else
      begin
        if mAddonName = 'weather' then
          uWeather_Actions.ReturnToMain(vNum)
        else if mAddonName = 'play' then
          uPlay_Actions_ReturnToMain(vNum)
        else
        begin
          emulation.Selection_Ani.StartValue := extrafe.res.Height;
          emulation.Selection_Ani.StopValue := ex_main.Settings.MainSelection_Pos.Y - 130;
          mainScene.Footer.Back_Ani.StartValue := extrafe.res.Height;
          mainScene.Footer.Back_Ani.StopValue := ex_main.Settings.Footer_Pos.Y;
          emulation.Selection_Ani.Enabled := True;
          if mShow = 'addon_time' then
            vTime.Time_Ani.Enabled := True
          else if mShow = 'addon_calendar' then
//            vCalendar.Calendar_Ani.Enabled:= True
          else if mShow = 'addon_weather' then
            vWeather.Scene.Weather_Ani.Enabled := True
          else if mShow = 'addon_soundplayer' then
            vSoundplayer.Scene.Soundplayer_Ani.Enabled := True;
          mainScene.Footer.Back_Ani.Enabled := True;
          All_Icons_Active(vNum);
          extrafe.prog.State := 'main';
        end;
        BASS_ChannelPlay(sound.str_fx.general[11], False);
      end;
  end;
end;

procedure Set_Addon_Icon_Active(vNum: Integer);
var
  vi: Integer;
begin
  for vi := 0 to user_Active_Local.ADDONS.Active do
  begin
    mainScene.Header.Addon_Icons[vi].Scale.X := 0.6;
    mainScene.Header.Addon_Icons[vi].Scale.Y := 0.6;
    mainScene.Header.Addon_Icons[vi].Align:= TAlignLayout.Center;
    mainScene.Header.Addon_Icons_GaussianBlur[vi].Enabled := True;
  end;

  mainScene.Header.Addon_Icons[vNum].Scale.X := 1.2;
  mainScene.Header.Addon_Icons[vNum].Scale.Y := 1.2;
  mainScene.Header.Addon_Icons[vNum].Align := TAlignLayout.Center;
  mainScene.Header.Addon_Icons_GaussianBlur[vNum].Enabled := False;
  ADDONS.Active_Now_Num := vNum;
end;

procedure All_Icons_Active(vNum: Integer);
var
  vi: Integer;
begin
  for vi := 0 to user_Active_Local.ADDONS.Active do
  begin
    mainScene.Header.Addon_Icons[vi].Scale.X := 1;
    mainScene.Header.Addon_Icons[vi].Scale.Y := 1;
    mainScene.Header.Addon_Icons_GaussianBlur[vi].Enabled := False;
  end;

  ADDONS.Active_Now_Num := -1;
end;
/// /////////////////////////////////////////////////////////////////////////////
procedure Update_Footer_Timer;
var
  vDate: TDateTime;
begin
  vDate := Now;
  mainScene.Footer.Addon_Calendar.Text.Text := formatdatetime('dd/mm/yyyy', vDate);
  mainScene.Footer.Addon_Time.Text.Text := TimeToStr(Now);
end;

procedure Update_All;
begin
  if extrafe.prog.State <> 'addon_soundplayer' then
    if ADDONS.soundplayer.Player.Play then
      uSoundplayer_Player.Refresh;
end;
{ TMAIN_TIMER }

procedure TMAIN_TIMER.OnTimer(Sender: TObject);
begin
  if TTimer(Sender).Name = 'Main_All_Timer' then
    Update_All
  else if TTimer(Sender).Name = 'Main_Footer_Timer' then
    Update_Footer_Timer
end;

initialization

vMain_Timer := TMAIN_TIMER.Create;

finalization

vMain_Timer.Free;

end.
