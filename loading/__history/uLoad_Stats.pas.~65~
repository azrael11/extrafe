unit uLoad_Stats;

interface

uses
  System.Classes,
  System.IniFiles;

procedure uLoad_Stats_FirstTime;
procedure uLoad_Stats_Load;

procedure uLoad_Stats_Clear;

implementation
uses
  main,
  uLoad_AllTypes;

procedure uLoad_Stats_FirstTime;
begin
  extrafe.stats.Name:= 'stats.ini';
  extrafe.stats.Path:= extrafe.Ini.Path;

  extrafe.stats.SumTime:= 0;
  extrafe.stats.Login_Success:= 0;
  extrafe.stats.Login_Fails:= 0;

  extrafe.stats.Addon[0].Path:= addons.time.Ini.Path;
  extrafe.stats.Addon[0].Name:= addons.time.Name+ '_stats.ini';
  extrafe.stats.Addon[0].OpenTimes:= 0;
  extrafe.stats.Addon[0].SumTime:= 0;

//  extrafe.stats.Addon[0].Path:= addons.calendar.Ini.Path;
  extrafe.stats.Addon[0].Name:= addons.calendar.Name+ '_stats.ini';
  extrafe.stats.Addon[0].OpenTimes:= 0;
  extrafe.stats.Addon[0].SumTime:= 0;

  extrafe.stats.Ini:= TIniFile.Create(extrafe.stats.Path+ extrafe.stats.Name);

  extrafe.stats.Ini.WriteString('PROG', 'Name', extrafe.stats.Name);
  extrafe.stats.Ini.WriteString('PROG', 'Path', extrafe.stats.Path);

  extrafe.stats.Ini.WriteInteger('EXTRAFE', 'Sum_Time', extrafe.stats.SumTime);
  extrafe.stats.Ini.WriteInteger('EXTRAFE', 'Login_Success',  extrafe.stats.Login_Success);
  extrafe.stats.Ini.WriteInteger('EXTRAFE', 'Login_Fails', extrafe.stats.Login_Fails);

  extrafe.stats.Ini.WriteString('ADDONS', 'Addon_0_Name', extrafe.stats.Addon[0].Name);
  extrafe.stats.Ini.WriteString('ADDONS', 'Addon_0_Path', extrafe.stats.Addon[0].Path);
  extrafe.stats.Ini.WriteInteger('ADDONS', 'Addon_0_OpenTimes', extrafe.stats.Addon[0].OpenTimes);
  extrafe.stats.Ini.WriteInteger('ADDONS', 'Addon_0_SumTime', extrafe.stats.Addon[0].SumTime);
end;

procedure uLoad_Stats_Load;
begin

end;

procedure uLoad_Stats_Clear;
begin

end;

end.
