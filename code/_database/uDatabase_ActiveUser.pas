unit uDatabase_ActiveUser;

interface
uses
  System.Classes,
  System.SysUtils;

type TDATABASE_ACTIVEUSER= record
  Database_Num: Integer;
  Username: String;
  Password: String;
  Avatar: String;
  Name: String;
  Surname: String;
  Email: String;
  Last_DateTime: String;
  Country: String;
  Country_Code: String;
  Genre: String;
  Game_Play: String;
  Game_Emulator: String;
  Total_Time: String;
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
  user_Active.Name:= uDatabase_SQLCommands_Get_RealName(user_Active.Database_Num);
  user_Active.Surname:= uDatabase_SQLCommands_Get_SurName(user_Active.Database_Num);
  user_Active.Email:= uDatabase_SQLCommands_Get_Email(user_Active.Database_Num);
  user_Active.Last_DateTime:= uDatabase_SQLCommands_Get_LastDateVisit(user_Active.Database_Num);
  user_Active.Country:= uDatabase_SQLCommands_Get_Country(user_Active.Database_Num);
  user_Active.Country_Code:= uDatabase_SQLCommands_Get_Country_Code(user_Active.Database_Num);
  user_Active.Genre:= uDatabase_SQLCommands_Get_Genre(user_Active.Database_Num);
  user_Active.Game_Play:= uDatabase_SQLCommands_Get_LastGame(user_Active.Database_Num);
  user_Active.Game_Emulator:= uDatabase_SQLCommands_Get_LastEmulator(user_Active.Database_Num);
  user_Active.Total_Time:= uDatabase_SQLCommands_Get_TimePlay(user_Active.Database_Num);
end;

end.
