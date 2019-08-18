unit uDatabase_ActiveUser;

interface
uses
  System.Classes,
  System.SysUtils;

type TDATABASE_ACTIVEUSER= record
  Database_Num: Integer;
  Username: String;
  Password: String;
  Email: String;
  IP: String;
  Name: String;
  Surname: String;
  Avatar: String;
  Registered: String;
  Last_Visit: String;
  Genre: String;
end;

procedure uDatabase_Active_User_Collect_Info_From_Database;

procedure Temp_User;

var
  user_Active_Online: TDATABASE_ACTIVEUSER;

implementation
uses
  loading,
  uLoad,
  uDatabase_SQLCommands;

procedure uDatabase_Active_User_Collect_Info_From_Database;
begin
  user_Active_Online.Email:= uDatabase_SQLCommands.Get_Query(user_Active_Online.Database_Num, 'email');
  user_Active_Online.IP:= uDatabase_SQLCommands.Get_Query(user_Active_Online.Database_Num, 'ip');
  user_Active_Online.Name:= uDatabase_SQLCommands.Get_Query(user_Active_Online.Database_Num, 'name');
  user_Active_Online.Surname:= uDatabase_SQLCommands.Get_Query(user_Active_Online.Database_Num, 'surname');
  user_Active_Online.Registered:= uDatabase_SQLCommands.Get_Query(user_Active_Online.Database_Num, 'registered');
  user_Active_Online.Last_Visit:= uDatabase_SQLCommands.Get_Query(user_Active_Online.Database_Num, 'lastvisit');
  user_Active_Online.Genre:= uDatabase_SQLCommands.Get_Query(user_Active_Online.Database_Num, 'gender');
end;

procedure Temp_User;
begin
  user_Active_Online.Database_Num := 0;
  user_Active_Online.Username := 'JohnDoe';
  user_Active_Online.Password := '123456';
  user_Active_Online.Email := 'JohnDoe@temp.com';
  user_Active_Online.IP := '100.100.100.100';
  user_Active_Online.Name := 'Jonh';
  user_Active_Online.Surname := 'Doe';
  user_Active_Online.Avatar := '0';
  user_Active_Online.Registered := '00:00:00:00';
  user_Active_Online.Last_Visit := '00:00:00:00';
end;
end.
