unit uLoad_Joystics;

interface
uses
  System.Classes;

procedure Get_MMSystem_Joysticks;
procedure Get_Direct_Input_Joysticks;
procedure Get_X_Input_Joysticks;

implementation
uses
  uJoystick_mms;

procedure Get_MMSystem_Joysticks;
begin
  uJoystick_mms.Refresh_Joys;
end;

procedure Get_Direct_Input_Joysticks;
begin

end;

procedure Get_X_Input_Joysticks;
begin

end;

end.
