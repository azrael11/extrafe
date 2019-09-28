unit uLoad_Login;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  System.DateUtils,
  System.JSON,
  FMX.Forms,
  FMX.Types,
  IdExplicitTLSClientServerBase,
  IdSMTP,
  IdSSLOpenSSL,
  IdMessage,
  IdGlobal,
  Rest.Types,
  BASS;

procedure Login;
procedure Exit_Program;

procedure Update_Password(vValue: String);

procedure Show_Password;
procedure CapsLock(vActive: Boolean);

implementation

uses
  load,
  uWindows,
  uLoad,
  uLoad_AllTypes,
  uLoad_SetAll,
  uDatabase,
  uDatabase_SqlCommands,
  uDatabase_ActiveUser,
  uInternet_Files;

var
  vPassword_Count: Integer;

procedure Login;
var
  vIP: TJSONValue;
begin
  if (ex_load.Login.User_V.Items.Strings[ex_load.Login.User_V.ItemIndex] = user_Active_Local.Username) and
    (ex_load.Login.Pass_V.Text = user_Active_Local.Password) then
    uLoad.Start_ExtraFE
  else
  begin
    if (ex_load.Login.User_V.Items.Strings[ex_load.Login.User_V.ItemIndex] = user_Active_Local.Username) then
      ex_load.Login.Warning.Text := 'Password is incorrect';
    ex_load.Login.Warning.Visible := True;
    ex_load.Login.Forget_Pass.Visible := True;
    ex_load.Login.Panel_Login_Error.Start;
    BASS_ChannelStop(sound.str_fx.general[0]);
    BASS_ChannelSetPosition(sound.str_fx.general[0], 0, 0);
    BASS_ChannelPlay(sound.str_fx.general[1], false);
  end;
end;

procedure Exit_Program;
begin
  if extrafe.databases.online_connected then
  begin
    uDatabase.ExtraFE_DB.Disconnect;
    FreeAndNil(uDatabase.ExtraFE_DB);
  end;
  uDatabase.ExtraFE_DB_Local.Connected := false;
  FreeAndNil(uDatabase.ExtraFE_DB_Local);
  load.loading.Close;
end;

procedure Show_Password;
begin
  if ex_load.Login.Pass_V.Password then
  begin
    ex_load.Login.Pass_Show.Text := #$e9ce;
    ex_load.Login.Pass_Show.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    BASS_ChannelStop(sound.str_fx.general[5]);
    BASS_ChannelSetPosition(sound.str_fx.general[5], 0, 0);
    BASS_ChannelPlay(sound.str_fx.general[4], false);
  end
  else
  begin
    ex_load.Login.Pass_Show.Text := #$e9d1;
    ex_load.Login.Pass_Show.TextSettings.FontColor := TAlphaColorRec.Blueviolet;
    BASS_ChannelStop(sound.str_fx.general[4]);
    BASS_ChannelSetPosition(sound.str_fx.general[4], 0, 0);
    BASS_ChannelPlay(sound.str_fx.general[5], false);
  end;
  ex_load.Login.Pass_V.Password := not ex_load.Login.Pass_V.Password;
end;

procedure CapsLock(vActive: Boolean);
begin
  vActive := not vActive;
  if vActive then
  begin
    ex_load.Login.CapsLock_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    ex_load.Login.CapsLock_Icon.Font.Size := 36;
    ex_load.Login.CapsLock.Text := 'Caps lock is Active';
  end
  else
  begin
    ex_load.Login.CapsLock_Icon.TextSettings.FontColor := TAlphaColorRec.Grey;
    ex_load.Login.CapsLock_Icon.Font.Size := 24;
    ex_load.Login.CapsLock.Text := 'Caps lock is Inactive';
  end;
  ex_load.Login.CapsLock_Icon.Locked := vActive;
end;

procedure Update_Password(vValue: String);
begin
  vPassword_Count := Length(vValue);

  if ex_load.Login.Warning.Visible then
  begin
    ex_load.Login.Warning.Visible := false;
    ex_load.Login.Forget_Pass.Visible := false;
  end;

  if vPassword_Count > 0 then
  begin
    if ex_load.Login.Pass_V.Password then
      ex_load.Login.Pass_Show.TextSettings.FontColor := TAlphaColorRec.Blueviolet
    else
      ex_load.Login.Pass_Show.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  end
  else
    ex_load.Login.Pass_Show.TextSettings.FontColor := TAlphaColorRec.Grey;

end;

end.
