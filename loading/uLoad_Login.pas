unit uLoad_Login;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  FMX.Forms,
  FMX.Types,
  IdExplicitTLSClientServerBase,
  IdSMTP,
  IdSSLOpenSSL,
  IdMessage,
  IdGlobal;

procedure Login;
procedure Exit_Program;

implementation

uses
  loading,
  uWindows,
  uLoad,
  uLoad_AllTypes,
  uLoad_SetAll,
  uDatabase,
  uDatabase_SqlCommands,
  uDatabase_ActiveUser;

procedure Login;
begin
  if uDatabase_Connect then
  begin
    if ex_load.Login.User_V.Text <> '' then
    begin
      if uDatabase_Is_User_Exists(ex_load.Login.User_V.Text) = True then
      begin
        if uDatabase_Is_Password_Correct_For_User(ex_load.Login.User_V.Text, ex_load.Login.Pass_V.Text) = True
        then
        begin
          uDatabase_Active_User_Collect_Info_From_Database;
          ex_load.Login.Panel_Login_Correct.Start;
          uLoad_Start_ExtraFE;
        end
        else
        begin
          Application.ProcessMessages;
          ex_load.Login.Warning.Visible := True;
          ex_load.Login.Warning.Text := 'Wrong Password for ' + ex_load.Login.User_V.Text;
          ex_load.Login.Panel_Login_Error.StartValue := extrafe.res.Half_Width -
            ((ex_load.Login.Panel.Width / 2) - 10);
          ex_load.Login.Panel_Login_Error.StopValue := extrafe.res.Half_Width -
            (ex_load.Login.Panel.Width / 2);
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
        ex_load.Login.Panel_Login_Error.StartValue := extrafe.res.Half_Width -
          ((ex_load.Login.Panel.Width / 2) - 10);
        ex_load.Login.Panel_Login_Error.StopValue := extrafe.res.Half_Width - (ex_load.Login.Panel.Width / 2);
        ex_load.Login.Panel_Login_Error.Start;
      end;
    end;
  end;
end;

procedure Exit_Program;
begin
  Application.Terminate
end;

end.
