unit uMain_Mouse;

interface

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  FMX.Ani,
  FMX.Objects,
  FMX.Dialogs,
  FMX.Effects,
  FMX.StdCtrls,
  uMain_Config_Mouse,
  uMain_Config_Emulation_Arcade_Scripts_Mouse;

type
  TMAIN_ANIMATION = class(TObject)
    procedure OnFinish(Sender: TObject);
  end;

type
  TMAIN_IMAGE = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TMAIN_BUTTON = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TMAIN_TEXT = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TMAIN_EDIT = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
    procedure OnTyping(Sender: TObject);
  end;

type
  TMAIN_MOUSE_ACTIONS = record
    Image: TMAIN_IMAGE;
    Button: TMAIN_BUTTON;
    Text: TMAIN_TEXT;
    Edit: TMAIN_EDIT;
    Animation: TMAIN_ANIMATION;
  end;

type
  TMAIN_INPUT = record
    mouse: TMAIN_MOUSE_ACTIONS;
    mouse_config: TMAIN_MOUSE_CONFIG_ACTIONS;
    mouse_script_arcade: TMAIN_MOUSE_CONFIG_EMULATION_ARCADE_ACTIONS;
  end;

implementation

uses
  uLoad_AllTypes,
  uMain,
  uMain_Actions,
  uMain_Config,
  uMain_SetAll,
  uMain_AllTypes,
  uMain_Config_Emulators,
  uWeather_Actions,
  uTime_SetAll,
  uTime_AllTypes,
  uTime_Actions,
  uCalendar_SetAll,
  uWeather_AllTypes,
  uWeather_SetAll,
  uSoundplayer_SetAll,
  uSoundplayer,
  uSoundplayer_AllTypes,
  uPlay_AllTypes,
  uPlay_SetAll,
  uPlay_Actions;

{ TMAIN_IMAGE }
procedure TMAIN_IMAGE.OnMouseClick(Sender: TObject);
begin
  if extrafe.prog.State <> 'main_exit' then
  begin
    if not ContainsText(extrafe.prog.State, 'main_config') then
    begin
      if TImage(Sender).Name = 'Main_Header_Exit' then
        uMain_Exit
      else if TImage(Sender).Name = 'Main_Header_Minimize' then
        uMain_Minimized
      else if TImage(Sender).Name = 'Main_Header_Avatar' then
      begin
        if extrafe.prog.State = 'main' then
          uMain_Actions_ShowAvatar;
      end
      else if TImage(Sender).Name = 'Main_Header_Addon_Icon_' + IntToStr(TImage(Sender).Tag) then
      begin
        if (addons.Active_Now_Num = -1) or (addons.Active_Now_Num = TImage(Sender).Tag) then
          uMain_Actions_ShowHide_Addons(TImage(Sender).Tag)
      end;
    end;
    if TImage(Sender).Name = 'Main_Footer_Settings' then
    begin
      if mainScene.Footer.Back_Blur.Enabled = False then
        uMain_Config_ShowHide(extrafe.prog.State);
    end;
  end;
end;

procedure TMAIN_IMAGE.OnMouseEnter(Sender: TObject);
var
  vComp: TComponent;
begin
  if extrafe.prog.State <> 'main_exit' then
  begin
    if not ContainsText(extrafe.prog.State, 'main_config') then
    begin
      if TImage(Sender).Name = 'Main_Header_Exit' then
        mainScene.Header.Exit_Glow.Enabled := True
      else if TImage(Sender).Name = 'Main_Header_Minimize' then
        mainScene.Header.Minimize_Glow.Enabled := True
      else if TImage(Sender).Name = 'Main_Header_Avatar' then
      begin
        if extrafe.prog.State = 'main' then
          mainScene.Header.Avatar_Glow.Enabled := True
      end
      else if TImage(Sender).Name = 'Main_Header_Addon_Icon_' + IntToStr(TImage(Sender).Tag) then
      begin
        if (addons.Active_Now_Num = -1) or (addons.Active_Now_Num = TImage(Sender).Tag) then
        begin
          vComp := mainScene.Header.Addon_Icons[TImage(Sender).Tag].FindComponent
            ('Main_Header_Addon_Icon_Glow_' + IntToStr(TImage(Sender).Tag));
          TGlowEffect(vComp).Enabled := True;
        end;
      end;
    end;
    if TImage(Sender).Name = 'Main_Footer_Settings' then
    begin
      if mainScene.Footer.Back_Blur.Enabled = False then
        mainScene.Footer.Settings_Glow.Enabled := True;
    end;
  end;
end;

procedure TMAIN_IMAGE.OnMouseLeave(Sender: TObject);
var
  vComp: TComponent;
begin
  if extrafe.prog.State <> 'main_exit' then
  begin
    if not ContainsText(extrafe.prog.State, 'main_config') then
    begin
      if TImage(Sender).Name = 'Main_Header_Exit' then
        mainScene.Header.Exit_Glow.Enabled := False
      else if TImage(Sender).Name = 'Main_Header_Minimize' then
        mainScene.Header.Minimize_Glow.Enabled := False
      else if TImage(Sender).Name = 'Main_Header_Avatar' then
      begin
        if extrafe.prog.State = 'main' then
          mainScene.Header.Avatar_Glow.Enabled := False
      end
      else if TImage(Sender).Name = 'Main_Header_Addon_Icon_' + IntToStr(TImage(Sender).Tag) then
      begin
        if (addons.Active_Now_Num = -1) or (addons.Active_Now_Num = TImage(Sender).Tag) then
        begin
          vComp := mainScene.Header.Addon_Icons[TImage(Sender).Tag].FindComponent
            ('Main_Header_Addon_Icon_Glow_' + IntToStr(TImage(Sender).Tag));
          TGlowEffect(vComp).Enabled := False;
        end;
      end;
    end;
    if TImage(Sender).Name = 'Main_Footer_Settings' then
    begin
      if mainScene.Footer.Back_Blur.Enabled = False then
        mainScene.Footer.Settings_Glow.Enabled := False;
    end;
  end;
end;

{ TMAIN_ANIMATION }

procedure TMAIN_ANIMATION.OnFinish(Sender: TObject);
begin
  if TFloatAnimation(Sender).Name = 'MainMenu_Selection_Ani' then
  begin
    TFloatAnimation(Sender).Enabled := False;
    mainScene.Footer.Back_Ani.Enabled := False;
    if extrafe.prog.State <> 'main' then
    begin
      if extrafe.prog.State = 'addon_time' then
        uTime_Actions_Load
      else if extrafe.prog.State = 'addon_calendar' then
        uCalendar_SetComponentsToRightPlace
      else if extrafe.prog.State = 'addon_weather' then
        uWeather_SetComponentsToRightPlace
      else if extrafe.prog.State = 'addon_soundplayer' then
        uSoundPlayer_SetAll.Set_Scene
      else if extrafe.prog.State = 'addon_play' then
        uPlay_SetAll_Set;
    end
    else
    begin
      uTime_Actions_Free;
      if Assigned(vTime.Time_Ani) then
        vTime.Time_Ani.Enabled := False;
      uWeather_Actions_Free;
      if Assigned(vWeather.Scene.Weather_Ani) then
        vWeather.Scene.Weather_Ani.Enabled := False;
      uSoundPlayer.Free;
      if Assigned(vSoundplayer.Scene.Soundplayer_Ani) then
        vSoundplayer.Scene.Soundplayer_Ani.Enabled := False;
      uPlay_Actions_Free;
      if Assigned(vPlay.Main_Ani) then
        vPlay.Main_Ani.Enabled:= False;
    end;
  end
  else if TFloatAnimation(Sender).Name = 'Main_Config_Ani' then
  begin
    if extrafe.prog.State = 'main' then
      uMain_COnfig_Free;
  end
  else
    TFloatAnimation(Sender).Enabled := False;
end;

{ TMAIN_BUTTON }

procedure TMAIN_BUTTON.OnMouseClick(Sender: TObject);
begin
  if TButton(Sender).Name = 'Main_Exit_Main_Yes' then
    uMain_Exit_Exit
  else if TButton(Sender).Name = 'Main_Exit_Main_No' then
    uMain_Exit_Stay
end;

procedure TMAIN_BUTTON.OnMouseEnter(Sender: TObject);
begin
  if TButton(Sender).Name = 'Main_Exit_Main_Yes' then
    uMain_Exit_OnOverText('Yes', False)
  else if TButton(Sender).Name = 'Main_Exit_Main_No' then
    uMain_Exit_OnOverText('No', False);
end;

procedure TMAIN_BUTTON.OnMouseLeave(Sender: TObject);
begin
  if TButton(Sender).Name = 'Main_Exit_Main_Yes' then
    uMain_Exit_OnOverText('Yes', True)
  else if TButton(Sender).Name = 'Main_Exit_Main_No' then
    uMain_Exit_OnOverText('No', True);
end;

{ TMAIN_TEXT }

procedure TMAIN_TEXT.OnMouseClick(Sender: TObject);
begin

end;

procedure TMAIN_TEXT.OnMouseEnter(Sender: TObject);
begin

end;

procedure TMAIN_TEXT.OnMouseLeave(Sender: TObject);
begin

end;

{ TMAIN_EDIT }

procedure TMAIN_EDIT.OnMouseClick(Sender: TObject);
begin

end;

procedure TMAIN_EDIT.OnMouseEnter(Sender: TObject);
begin

end;

procedure TMAIN_EDIT.OnMouseLeave(Sender: TObject);
begin

end;

procedure TMAIN_EDIT.OnTyping(Sender: TObject);
begin

end;

initialization

ex_main.input.mouse.Animation := TMAIN_ANIMATION.Create;
ex_main.input.mouse.Image := TMAIN_IMAGE.Create;
ex_main.input.mouse.Button := TMAIN_BUTTON.Create;
ex_main.input.mouse.Text := TMAIN_TEXT.Create;
ex_main.input.mouse.Edit := TMAIN_EDIT.Create;

finalization

ex_main.input.mouse.Animation.Free;
ex_main.input.mouse.Image.Free;
ex_main.input.mouse.Button.Free;
ex_main.input.mouse.Text.Free;
ex_main.input.mouse.Edit.Free;

end.
