unit uMain_Config_Addons_Actions;

interface

uses
  System.Classes,
  System.UITypes,
  System.SysUtils,
  FMX.Objects,
  FMX.StdCtrls,
  BASS;

procedure Activation(vAddonNum: integer);
procedure Set_Icons(vDeletedIcon: integer);

procedure LeftArrow;
procedure RightArrow;

{ Weather }
procedure Weather_Activate;
procedure Weather_Deactivate;
{ Soundplayer }
procedure Soundplayer_Activate;
procedure Soundplayer_Deactivate;
{ Play }
procedure AzPlay_Activate;
procedure AzPlay_Deactivate;

implementation

uses
  uLoad_AllTypes,
  main,
  uDB,
  uDB_AUser,
  uWindows,
  uMain_SetAll,
  uMain_AllTypes,
  uMain_Config_Addons,
  uSoundplayer_AllTypes,
  uMain_Config_Addons_Weather,
  uSoundplayer_Actions,
  uMain_Config_Addons_Soundplayer,
  uMain_Config_Addons_AzPlay;

procedure Set_Icons(vDeletedIcon: integer);
var
  vi: integer;
begin
  if vDeletedIcon = uDB_AUser.Local.addons.Active then
  begin
    FreeAndNil(mainScene.Header.Addon_Icon.Frame[vDeletedIcon]);
    uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDON_' + UpperCase(uDB_AUser.Local.addons.Names[vDeletedIcon]), 'MENU_POSITION', '-1', 'USER_ID',
      uDB_AUser.Local.USER.Num.ToString);
    uDB_AUser.Local.addons.Names[vDeletedIcon] := '';
  end
  else
  begin
    for vi := vDeletedIcon + 1 to uDB_AUser.Local.addons.Active do
    begin
      mainScene.Header.Addon_Icon.Icons[vi - 1] := mainScene.Header.Addon_Icon.Icons[vi];
      uDB_AUser.Local.addons.Names[vi - 1] := uDB_AUser.Local.addons.Names[vi];
      uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDON_' + UpperCase(uDB_AUser.Local.addons.Names[vi - 1]), 'MENU_POSITION', (vi - 1).ToString, 'USER_ID',
        uDB_AUser.Local.USER.Num.ToString);
      if vi = uDB_AUser.Local.addons.Active then
      begin
        FreeAndNil(mainScene.Header.Addon_Icon.Frame[vi]);
        uDB_AUser.Local.addons.Names[vi] := '';
      end;
    end;
  end;
end;

procedure LeftArrow;
begin
  Dec(ex_main.Config.Addons_Tab_First);
  Dec(ex_main.Config.Addons_Tab_Last);
  if ex_main.Config.Addons_Tab_First = 0 then
  begin
    mainScene.Config.main.R.addons.Left_Num.Visible := False;
    mainScene.Config.main.R.addons.Arrow_Left.TextSettings.FontColor := TAlphaColorRec.Grey;
  end;
  if ex_main.Config.Addons_Tab_Last <> uDB_AUser.Local.addons.Active then
  begin
    mainScene.Config.main.R.addons.Right_Num.Visible := True;
    mainScene.Config.main.R.addons.Right_Num.Text := (ex_main.Config.Addons_Tab_Last - 2).ToString;
    mainScene.Config.main.R.addons.Arrow_Right.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  end;
  mainScene.Config.main.R.addons.Left_Num.Text := ex_main.Config.Addons_Tab_First.ToString;
  uMain_Config_Addons.Icons_Free;
  uMain_Config_Addons.Icons(ex_main.Config.Addons_Tab_First);
  if ex_main.Config.Addons_Active_Tab <> -1 then
  begin
    if ex_main.Config.Addons_Active_Tab = uDB_AUser.Local.addons.Active then
      FreeAndNil(mainScene.Config.main.R.addons.Icons_Panel[uDB_AUser.Local.addons.Active])
    else
      uMain_Config_Addons.ShowInfo(ex_main.Config.Addons_Active_Tab);
  end;
end;

procedure RightArrow;
begin
  Inc(ex_main.Config.Addons_Tab_First);
  Inc(ex_main.Config.Addons_Tab_Last);
  if ex_main.Config.Addons_Tab_First > 0 then
  begin
    mainScene.Config.main.R.addons.Left_Num.Visible := True;
    mainScene.Config.main.R.addons.Left_Num.Text := ex_main.Config.Addons_Tab_First.ToString;
    mainScene.Config.main.R.addons.Arrow_Left.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  end;
  if ex_main.Config.Addons_Tab_Last = uDB_AUser.Local.addons.Count then
  begin
    mainScene.Config.main.R.addons.Right_Num.Visible := False;
    mainScene.Config.main.R.addons.Right_Num.Text := '0';
    mainScene.Config.main.R.addons.Arrow_Right.TextSettings.FontColor := TAlphaColorRec.Grey;
  end;
  mainScene.Config.main.R.addons.Right_Num.Text := (ex_main.Config.Addons_Tab_Last - 4).ToString;
  uMain_Config_Addons.Icons_Free;
  uMain_Config_Addons.Icons(ex_main.Config.Addons_Tab_First);
  if ex_main.Config.Addons_Active_Tab <> -1 then
  begin
    if ex_main.Config.Addons_Active_Tab = 0 then
      FreeAndNil(mainScene.Config.main.R.addons.Icons_Panel[0])
    else
      uMain_Config_Addons.ShowInfo(ex_main.Config.Addons_Active_Tab);
  end;
end;

{ Addon Soundplayer }
procedure Soundplayer_Activate;
begin
  uSoundplayer_Actions.Get_Data;

  if uDB_AUser.Local.addons.Soundplayer_D.Playlist_Count <> -1 then
    uMain_Config_Addons_Soundplayer.Show_Select_Message
  else
    uMain_Config_Addons_Soundplayer.Fresh_Start(True);
end;

procedure Soundplayer_Deactivate;
begin
  if uDB_AUser.Local.addons.Soundplayer_D.Playlist_Count <> -1 then
    uMain_Config_Addons_Soundplayer.Show_D_Select_Message
  else
    uMain_Config_Addons_Soundplayer.Deactivate;
end;

{ Addon Weather }
procedure Weather_Activate;
begin
  if uDB_AUser.Local.addons.Weather_D.Old_Backup then
    uMain_Config_Addons_Weather.Show_Select_Message
  else
    uMain_Config_Addons_Weather.Fresh_Start(True);
end;

procedure Weather_Deactivate;
begin
  if uDB_AUser.Local.addons.Weather_D.Yahoo.Towns_Count > -1 then
    uMain_Config_Addons_Weather.Show_D_Select_Message
  else
    uMain_Config_Addons_Weather.Deactivate;
end;

{ Addon AzPlay }
procedure AzPlay_Activate;
begin
  uMain_Config_Addons_AzPlay.Fresh_Start(True);
end;

procedure AzPlay_Deactivate;
begin
  uMain_Config_Addons_AzPlay.Deactivate;
end;

{ Main activation\deactivation action }
procedure Activation(vAddonNum: integer);
begin
  if vAddonNum = 2 then
  begin
    case uDB_AUser.Local.addons.weather of
      True:
        Weather_Deactivate;
      False:
        Weather_Activate;
    end;
  end
  else if vAddonNum = 3 then
  begin
    case uDB_AUser.Local.addons.soundplayer of
      True:
        Soundplayer_Deactivate;
      False:
        Soundplayer_Activate;
    end;
  end
  else if vAddonNum = 4 then
  begin
    case uDB_AUser.Local.addons.Azplay of
      True:
        AzPlay_Deactivate;
      False:
        AzPlay_Activate;
    end;
  end;
end;

end.
