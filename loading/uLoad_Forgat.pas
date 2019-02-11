unit uLoad_Forgat;

interface

uses
  System.Classes,
  System.SysUtils;

procedure Send_Pass_WithEmail(vEmail: string);
procedure Cancel;

implementation

uses
  uLoad_AllTypes,
  uLoad_SetAll,
  uInternet_Files;

procedure Cancel;
begin
  FreeAndNil(ex_load.F_Pass.Panel);
  uLoad_SetAll_Login;
  ex_load.Login.Pass_V.Text := '';
end;

procedure Send_Pass_WithEmail(vEmail: string);
begin
  if uInternet_Files.Send_HTML_Email(vEmail, 'forgat_password') then
    Cancel
  else
    ex_load.F_Pass.Main.Warning.Visible := True;
end;

end.
