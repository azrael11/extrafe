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

procedure Show_Password;

implementation

uses
  loading,
  uWindows,
  uLoad,
  uLoad_AllTypes,
  uLoad_SetAll,
  uDatabase,
  uDatabase_SqlCommands,
  uDatabase_ActiveUser,
  uInternet_Files;

procedure Login;
var
  vIP: TJSONValue;
begin
//  uDatabase_ActiveUser.Get_Online_Data;
//  ex_load.Scene.Progress.Value := 10;
  uDatabase_ActiveUser.Get_Local_Data;
  ex_load.Scene.Progress.Value := 20;
  if uDatabase.Online_Connect then
  begin
    if ex_load.Login.User_V.Text <> '' then
    begin
      if Is_User_Exists(ex_load.Login.User_V.Text) = True then
      begin
        if Is_Password_Correct_For_User(ex_load.Login.User_V.Text, ex_load.Login.Pass_V.Text) = True then
        begin
          ex_load.Login.Panel_Login_Correct.Start;
          uLoad.Start_ExtraFE;
          vIP := uInternet_Files.JSONValue('Register_IP_', 'http://ipinfo.io/json', TRESTRequestMethod.rmGET);
          uDatabase_SqlCommands.Update_Query('active', '1');
          uDatabase_SqlCommands.Update_Query('lastvisit', DateTimeToUnix(Now).ToString);
          uDatabase_SqlCommands.Update_Query('ip', vIP.GetValue<String>('ip'));
        end
        else
        begin
          Application.ProcessMessages;
          ex_load.Login.Warning.Visible := True;
          ex_load.Login.Warning.Text := 'Wrong Password for ' + ex_load.Login.User_V.Text;
          ex_load.Login.Panel_Login_Error.StartValue := extrafe.res.Half_Width - ((ex_load.Login.Panel.Width / 2) - 10);
          ex_load.Login.Panel_Login_Error.StopValue := extrafe.res.Half_Width - (ex_load.Login.Panel.Width / 2);
          ex_load.Login.Panel_Login_Error.Start;
          ex_load.Login.Pass_V.Text := '';
          ex_load.Login.Forget_Pass.Visible := True;
        end;
      end
      else
      begin
        ex_load.Login.Warning.Visible := True;
        ex_load.Login.Warning.Text := ' Can''t find " ' + ex_load.Login.User_V.Text + ' " in database.';
        ex_load.Login.Avatar.Bitmap.LoadFromFile(ex_main.Paths.Avatar_Images + '0.png');
        ex_load.Login.Panel_Login_Error.StartValue := extrafe.res.Half_Width - ((ex_load.Login.Panel.Width / 2) - 10);
        ex_load.Login.Panel_Login_Error.StopValue := extrafe.res.Half_Width - (ex_load.Login.Panel.Width / 2);
        ex_load.Login.Panel_Login_Error.Start;
      end;
    end;
  end
  else
  begin
    // This needs more work and configuration
    uDatabase_ActiveUser.Temp_User;
    uLoad.Start_ExtraFE;
  end;
end;

procedure Exit_Program;
begin
  Application.Terminate
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

end.
