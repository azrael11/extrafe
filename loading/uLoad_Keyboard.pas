unit uLoad_Keyboard;

interface

uses
  System.Classes,
  System.SysUtils,
  FMX.Objects;

procedure SetKey(vKey: String);

implementation

uses
  loading,
  uLoad,
  uLoad_AllTypes,
  uLoad_Login;

procedure SetKey(vKey: String);
var
  vStr: String;
begin
  if extrafe.prog.State = 'load_login' then
  begin
    if UpperCase(vKey) = 'ENTER' then
    begin
      if ex_load.Login.User_V.IsFocused then
        ex_load.Login.Pass_V.SetFocus
      else if ex_load.Login.Pass_V.IsFocused then
        uLoad_Login.Login;
    end
    else if UpperCase(vKey) = 'CAPS LOCK' then
      ex_load.Login.CapsLock.Visible := not ex_load.Login.CapsLock.Visible;
  end
  else if extrafe.prog.State = 'load_register' then
  begin
    if UpperCase(vKey)= 'SPACE' then
    begin
      if ex_load.Reg.Edit_Select= 'username' then
      begin
        vStr:= ex_load.Reg.Main.User_V.Text;
        Delete(vStr, length(vStr), 1);
        ex_load.Reg.Main.User_V.Text:= vStr;
      end;
    end
  end
  else if extrafe.prog.State = 'load_forgat' then
  begin

  end;
end;

end.
