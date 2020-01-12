unit uView_Mode_Video_Key;

interface
uses
  System.Classes,
  System.SysUtils;

procedure Key(vKey: String);

implementation
uses
  uView_Mode_Video_Actions;

procedure Key(vKey: String);
begin
  if UpperCase(vKey) = 'ESC' then
    uView_Mode_Video_Actions.Exit_Action
  else if UpperCase(vKey) = 'DOWN' then
    uView_Mode_Video_Actions.Move_Gamelist('DOWN')
  else if UpperCase(vKey) = 'UP' then
    uView_Mode_Video_Actions.Move_Gamelist('UP')
  else if UpperCase(vKey) = 'PAGE UP' then
    uView_Mode_Video_Actions.Move_Gamelist('PAGE UP')
  else if UpperCase(vKey) = 'PAGE DOWN' then
    uView_Mode_Video_Actions.Move_Gamelist('PAGE DOWN')
  else if UpperCase(vKey) = 'HOME' then
    uView_Mode_Video_Actions.Move_Gamelist('HOME')
  else if UpperCase(vKey) = 'END' then
    uView_Mode_Video_Actions.Move_Gamelist('END');



end;

end.
