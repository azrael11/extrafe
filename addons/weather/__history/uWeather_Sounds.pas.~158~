unit uWeather_Sounds;

interface

uses
  System.Classes,
  Bass;

procedure uWeather_Sounds_Load;
procedure uWeather_Sounds_Free;

procedure uWeather_Sounds_PlayEffect(vCode, vWindSpeed: String; vStart: Boolean);
procedure uWeather_Sounds_Refresh_Effect;

procedure uWeather_Sounds_PlayMouse(vPlayEffect: string);

procedure uWeather_Sounds_PlayWarning(vPlayEffect: String);

implementation

uses
  uDatabase_ActiveUser,
  uLoad_AllTypes,
  uWeather_AllTypes;

procedure uWeather_Sounds_Load;
begin
  // Effects

  // Rain light 0
  addons.weather.Sound.effects[0] := BASS_StreamCreateFile(False,
    PChar(user_Active_Local.ADDONS.Weather_D.p_Sounds + 'a_w_rain_light.mp3'), 0, 0, 0 {$IFDEF UNICODE} or BASS_UNICODE
{$ENDIF});
  // BASS_ChannelSlideAttribute(addons.weather.Sound.effects[0],BASS_ATTRIB_VOL, 0.5, )

  // Rain heavy 1
  addons.weather.Sound.effects[1] := BASS_StreamCreateFile(False,
    PChar(user_Active_Local.ADDONS.Weather_D.p_Sounds + 'a_w_rain_heavy.mp3'), 0, 0, 0 {$IFDEF UNICODE} or BASS_UNICODE
{$ENDIF});
  // Rain with thunder 2
  addons.weather.Sound.effects[2] := BASS_StreamCreateFile(False,
    PChar(user_Active_Local.ADDONS.Weather_D.p_Sounds + 'a_w_rain_thunder.mp3'), 0, 0, 0 {$IFDEF UNICODE} or BASS_UNICODE
{$ENDIF});
  // Thunder
  addons.weather.Sound.effects[3] := BASS_StreamCreateFile(False,
    PChar(user_Active_Local.ADDONS.Weather_D.p_Sounds + 'a_w_thunder.mp3'), 0, 0, 0 {$IFDEF UNICODE} or BASS_UNICODE
{$ENDIF});
  // Rain lound 4
  addons.weather.Sound.effects[4] := BASS_StreamCreateFile(False,
    PChar(user_Active_Local.ADDONS.Weather_D.p_Sounds + 'a_w_rain_thunder_loop.mp3'), 0, 0, 0 {$IFDEF UNICODE} or BASS_UNICODE
{$ENDIF});
  // Wind 5
  addons.weather.Sound.effects[5] := BASS_StreamCreateFile(False,
    PChar(user_Active_Local.ADDONS.Weather_D.p_Sounds + 'a_w_wind.mp3'), 0, 0, 0 {$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
  // Wind Light 6
  addons.weather.Sound.effects[6] := BASS_StreamCreateFile(False,
    PChar(user_Active_Local.ADDONS.Weather_D.p_Sounds + 'a_w_wind_light.mp3'), 0, 0, 0 {$IFDEF UNICODE} or BASS_UNICODE
{$ENDIF});
  // Wind hurricane 7
  addons.weather.Sound.effects[7] := BASS_StreamCreateFile(False,
    PChar(user_Active_Local.ADDONS.Weather_D.p_Sounds + 'a_w_hurricane.mp3'), 0, 0, 0 {$IFDEF UNICODE} or BASS_UNICODE
{$ENDIF});

  // Main
  // Slide
  addons.weather.Sound.mouse[0] := BASS_StreamCreateFile(False,
    PChar(user_Active_Local.ADDONS.Weather_D.p_Sounds + 'a_w_slide.mp3'), 0, 0, 0 {$IFDEF UNICODE} or BASS_UNICODE
{$ENDIF});
  // Lock
  addons.weather.Sound.mouse[1] := BASS_StreamCreateFile(False,
    PChar(user_Active_Local.ADDONS.Weather_D.p_Sounds + 'a_w_lock.mp3'), 0, 0, 0 {$IFDEF UNICODE} or BASS_UNICODE
{$ENDIF});
  // Unlock
  addons.weather.Sound.mouse[2] := BASS_StreamCreateFile(False,
    PChar(user_Active_Local.ADDONS.Weather_D.p_Sounds + 'a_w_unlock.mp3'), 0, 0, 0 {$IFDEF UNICODE} or BASS_UNICODE
{$ENDIF});
  // Delete warning
  addons.weather.Sound.warning[0] := BASS_StreamCreateFile(False,
    PChar(user_Active_Local.ADDONS.Weather_D.p_Sounds + 'a_w_delete_warning.mp3'), 0, 0, 0 {$IFDEF UNICODE} or BASS_UNICODE
{$ENDIF});

end;

procedure uWeather_Sounds_Free;
begin
  BASS_StreamFree(addons.weather.Sound.effects[0]);
  BASS_StreamFree(addons.weather.Sound.effects[1]);
  BASS_StreamFree(addons.weather.Sound.effects[2]);
  BASS_StreamFree(addons.weather.Sound.effects[3]);
  BASS_StreamFree(addons.weather.Sound.effects[4]);
  BASS_StreamFree(addons.weather.Sound.effects[5]);
  BASS_StreamFree(addons.weather.Sound.effects[6]);
  BASS_StreamFree(addons.weather.Sound.effects[7]);
  BASS_StreamFree(addons.weather.Sound.mouse[0]);
  BASS_StreamFree(addons.weather.Sound.mouse[1]);
  BASS_StreamFree(addons.weather.Sound.mouse[2]);
  BASS_StreamFree(addons.weather.Sound.warning[0]);
end;

///

procedure uWeather_Sounds_PlayEffect(vCode, vWindSpeed: String; vStart: Boolean);
begin
  if vStart then
  begin
    if vCode = '12' then
    begin
      BASS_ChannelPlay(addons.weather.Sound.effects[0], True);
      addons.weather.Action.Effect_Active_Num := 0;
    end
    else if vCode = '40' then
    begin
      BASS_ChannelPlay(addons.weather.Sound.effects[1], True);
      addons.weather.Action.Effect_Active_Num := 1;
    end;
    vWeather.Scene.Effect_Timer.Enabled := True;
  end
  else
  begin
    BASS_ChannelStop(addons.weather.Sound.effects[addons.weather.Action.Effect_Active_Num]);
  end;
end;

procedure uWeather_Sounds_Refresh_Effect;
begin
  if BASS_ChannelGetPosition(addons.weather.Sound.effects[addons.weather.Action.Effect_Active_Num],
    BASS_POS_BYTE) >= BASS_ChannelGetLength(addons.weather.Sound.effects
    [addons.weather.Action.Effect_Active_Num], BASS_POS_BYTE) then
  begin
    BASS_ChannelSetPosition(addons.weather.Sound.effects[addons.weather.Action.Effect_Active_Num], 0, 0);
    BASS_ChannelPlay(addons.weather.Sound.effects[addons.weather.Action.Effect_Active_Num], True);
  end;
end;

procedure uWeather_Sounds_PlayMouse(vPlayEffect: string);
begin
  if vPlayEffect = 'Slide' then
    BASS_ChannelPlay(addons.weather.Sound.mouse[0], True)
  else if vPlayEffect = 'Lock' then
    BASS_ChannelPlay(addons.weather.Sound.mouse[1], True)
  else if vPlayEffect = 'Unlock' then
    BASS_ChannelPlay(addons.weather.Sound.mouse[2], True)
end;

procedure uWeather_Sounds_PlayWarning(vPlayEffect: String);
begin
  if vPlayEffect = 'Delete' then
    BASS_ChannelPlay(addons.weather.Sound.warning[0], True)
end;

end.
