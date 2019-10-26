unit uCalendar_Actions;

interface
uses
  System.Classes;

procedure Get_Data;

implementation
uses
  uDatabase,
  uDatabase_ActiveUser;

procedure Get_Data;
var
  vQuery: String;
begin
  vQuery := 'SELECT * FROM ADDON_CALENDAR';
  ExtraFE_Query_Local.Close;
  ExtraFE_Query_Local.SQL.Clear;
  ExtraFE_Query_Local.SQL.Add(vQuery);
  ExtraFE_Query_Local.Open;
  ExtraFE_Query_Local.First;

  user_Active_Local.ADDONS.Calendar_D.Menu_Position:= ExtraFE_Query_Local.FieldByName('MENU_POSITION').AsInteger;
end;

end.
