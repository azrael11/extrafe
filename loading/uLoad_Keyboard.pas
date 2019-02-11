unit uLoad_Keyboard;

interface
uses
  System.Classes,
  System.SysUtils,
  FMX.Objects;

  procedure uLoad_Keyboard_SetKey(vKey: String);

implementation
uses
  loading,
  uLoad,
  uLoad_AllTypes,
  uLoad_Login;

procedure uLoad_Keyboard_SetKey(vKey: String);
begin
  if UpperCase(vKey)= 'ENTER' then
    begin
      if ex_load.Login.User_V.IsFocused then
        ex_load.Login.Pass_V.SetFocus
      else if ex_load.Login.Pass_V.IsFocused then
        uLoad_Login.Login;
    end
  else if UpperCase(vKey) = 'CAPS LOCK' then
    ex_load.Login.CapsLock.Visible := not ex_load.Login.CapsLock.Visible;
end;

end.
