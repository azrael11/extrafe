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
  DateTime_Created: String;
  Last_DateTime_Visit: String;
  Country: String;
  Country_Code: String;
  Genre: String;
  Game_Play: String;
  Game_Emulator: String;
  Total_Time: String;
  Server_Folder: String;
end;

  procedure uDatabase_Active_User_Collect_Info_From_Database;

  var
    user_Active: TDATABASE_ACTIVEUSER;
implementation
uses
  loading,
  uLoad,
  uDatabase_SQLCommands;

procedure uDatabase_Active_User_Collect_Info_From_Database;
begin
  user_Active.Email:= uDatabase_SQLCommands_Get_Email(user_Active.Database_Num);
  user_Active.IP:= uDatabase_SQLCommands.Get_IP(user_Active.Database_Num);
  user_Active.Name:= uDatabase_SQLCommands_Get_RealName(user_Active.Database_Num);
  user_Active.Surname:= uDatabase_SQLCommands_Get_SurName(user_Active.Database_Num);
  user_Active.DateTime_Created:= uDatabase_SQLCommands.Get_DateTime_Created(user_Active.Database_Num);
  user_Active.Last_DateTime_Visit:= uDatabase_SQLCommands.Get_LastDateTimeVisit(user_Active.Database_Num);
  user_Active.Country:= uDatabase_SQLCommands_Get_Country(user_Active.Database_Num);
  user_Active.Country_Code:= uDatabase_SQLCommands_Get_Country_Code(user_Active.Database_Num);
  user_Active.Genre:= uDatabase_SQLCommands_Get_Genre(user_Active.Database_Num);
  user_Active.Game_Play:= uDatabase_SQLCommands_Get_LastGame(user_Active.Database_Num);
  user_Active.Game_Emulator:= uDatabase_SQLCommands_Get_LastEmulator(user_Active.Database_Num);
  user_Active.Total_Time:= uDatabase_SQLCommands_Get_TimePlay(user_Active.Database_Num);
  user_Active.Server_Folder:= uDatabase_SQLCommands.Get_ServerFolder(user_Active.Database_Num);
end;

end.
