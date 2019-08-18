unit uMain_Config_Profile_Machine;

interface

uses
  System.Classes,
  System.SysUtils,
  FMX.StdCtrls,
  IdStack;

procedure Load;
procedure Free;

implementation

uses
  uLoad_AllTypes,
  uMain_AllTypes,
  uDatabase_ActiveUser,
  uWindows;

procedure Load;
var
  vStack: TIdStack;
  vList: TIdStackLocalAddressList;
begin
  // vStack:= TIdStack.Create;
  // vList:= TIdStackLocalAddressList.Create;
  // vStack.GetLocalAddressList(vList);
  mainScene.Config.main.R.Profile.Machine.Panel := TPanel.Create(mainScene.Config.main.R.Profile.TabItem[2]);
  mainScene.Config.main.R.Profile.Machine.Panel.Name := 'Main_Config_Profile_Machine';
  mainScene.Config.main.R.Profile.Machine.Panel.Parent := mainScene.Config.main.R.Profile.TabItem[2];
  mainScene.Config.main.R.Profile.Machine.Panel.SetBounds(0, 0, mainScene.Config.main.R.Profile.TabControl.Width,
    mainScene.Config.main.R.Profile.TabControl.Height);
  mainScene.Config.main.R.Profile.Machine.Panel.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Computer := TGroupBox.Create(mainScene.Config.main.R.Profile.Machine.Panel);
  mainScene.Config.main.R.Profile.Machine.Computer.Name := 'Main_Config_Profile_Machine_Computer';
  mainScene.Config.main.R.Profile.Machine.Computer.Parent := mainScene.Config.main.R.Profile.Machine.Panel;
  mainScene.Config.main.R.Profile.Machine.Computer.SetBounds(10, 10, 580, 210);
  mainScene.Config.main.R.Profile.Machine.Computer.Text := 'Computer : ';
  mainScene.Config.main.R.Profile.Machine.Computer.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Computer_Info := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Computer);
  mainScene.Config.main.R.Profile.Machine.Computer_Info.Name := 'Main_Config_Profile_Machine_Computer_Info_Label';
  mainScene.Config.main.R.Profile.Machine.Computer_Info.Parent := mainScene.Config.main.R.Profile.Machine.Computer;
  mainScene.Config.main.R.Profile.Machine.Computer_Info.SetBounds(10, 20, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Computer_Info.Text := 'Information : ';
  mainScene.Config.main.R.Profile.Machine.Computer_Info.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Computer_Info_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Computer);
  mainScene.Config.main.R.Profile.Machine.Computer_Info_V.Name := 'Main_Config_Profile_Machine_Computer_Info_V_Label';
  mainScene.Config.main.R.Profile.Machine.Computer_Info_V.Parent := mainScene.Config.main.R.Profile.Machine.Computer;
  mainScene.Config.main.R.Profile.Machine.Computer_Info_V.SetBounds(140, 20, 440, 24);
  mainScene.Config.main.R.Profile.Machine.Computer_Info_V.Text := TOSVersion.ToString;
  mainScene.Config.main.R.Profile.Machine.Computer_Info_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Computer_Architecture := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Computer);
  mainScene.Config.main.R.Profile.Machine.Computer_Architecture.Name := 'Main_Config_Profile_Machine_Computer_Architecture_Label';
  mainScene.Config.main.R.Profile.Machine.Computer_Architecture.Parent := mainScene.Config.main.R.Profile.Machine.Computer;
  mainScene.Config.main.R.Profile.Machine.Computer_Architecture.SetBounds(10, 60, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Computer_Architecture.Text := 'Architecture : ';
  mainScene.Config.main.R.Profile.Machine.Computer_Architecture.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Computer_Architecture_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Computer);
  mainScene.Config.main.R.Profile.Machine.Computer_Architecture_V.Name := 'Main_Config_Profile_Machine_Computer_Architecture_V_Label';
  mainScene.Config.main.R.Profile.Machine.Computer_Architecture_V.Parent := mainScene.Config.main.R.Profile.Machine.Computer;
  mainScene.Config.main.R.Profile.Machine.Computer_Architecture_V.SetBounds(140, 60, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Computer_Architecture_V.Text := uWindows_OsArchitectureToStr(TOSVersion.Architecture);
  mainScene.Config.main.R.Profile.Machine.Computer_Architecture_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Computer_Platform := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Computer);
  mainScene.Config.main.R.Profile.Machine.Computer_Platform.Name := 'Main_Config_Profile_Machine_Computer_Platform_Label';
  mainScene.Config.main.R.Profile.Machine.Computer_Platform.Parent := mainScene.Config.main.R.Profile.Machine.Computer;
  mainScene.Config.main.R.Profile.Machine.Computer_Platform.SetBounds(10, 84, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Computer_Platform.Text := 'Platform : ';
  mainScene.Config.main.R.Profile.Machine.Computer_Platform.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Computer_Platform_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Computer);
  mainScene.Config.main.R.Profile.Machine.Computer_Platform_V.Name := 'Main_Config_Profile_Machine_Computer_Platform_V_Label';
  mainScene.Config.main.R.Profile.Machine.Computer_Platform_V.Parent := mainScene.Config.main.R.Profile.Machine.Computer;
  mainScene.Config.main.R.Profile.Machine.Computer_Platform_V.SetBounds(140, 84, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Computer_Platform_V.Text := uWindows_OsPlatformToStr(TOSVersion.Platform) + ' ' +
    IntToStr(uWindoes_OsPlatformPointerToInt) + ' bit';
  mainScene.Config.main.R.Profile.Machine.Computer_Platform_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Computer_Operating_System := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Computer);
  mainScene.Config.main.R.Profile.Machine.Computer_Operating_System.Name := 'Main_Config_Profile_Machine_Computer_OperatingSystem_Label';
  mainScene.Config.main.R.Profile.Machine.Computer_Operating_System.Parent := mainScene.Config.main.R.Profile.Machine.Computer;
  mainScene.Config.main.R.Profile.Machine.Computer_Operating_System.SetBounds(10, 108, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Computer_Operating_System.Text := 'Operating System : ';
  mainScene.Config.main.R.Profile.Machine.Computer_Operating_System.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Computer_Operating_System_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Computer);
  mainScene.Config.main.R.Profile.Machine.Computer_Operating_System_V.Name := 'Main_Config_Profile_Machine_Computer_OperatingSystem_V_Label';
  mainScene.Config.main.R.Profile.Machine.Computer_Operating_System_V.Parent := mainScene.Config.main.R.Profile.Machine.Computer;
  mainScene.Config.main.R.Profile.Machine.Computer_Operating_System_V.SetBounds(140, 108, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Computer_Operating_System_V.Text := TOSVersion.Name;
  mainScene.Config.main.R.Profile.Machine.Computer_Operating_System_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Computer_Major := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Computer);
  mainScene.Config.main.R.Profile.Machine.Computer_Major.Name := 'Main_Config_Profile_Machine_Computer_Major_Label';
  mainScene.Config.main.R.Profile.Machine.Computer_Major.Parent := mainScene.Config.main.R.Profile.Machine.Computer;
  mainScene.Config.main.R.Profile.Machine.Computer_Major.SetBounds(10, 132, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Computer_Major.Text := 'Major : ';
  mainScene.Config.main.R.Profile.Machine.Computer_Major.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Computer_Major_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Computer);
  mainScene.Config.main.R.Profile.Machine.Computer_Major_V.Name := 'Main_Config_Profile_Machine_Computer_Major_V_Label';
  mainScene.Config.main.R.Profile.Machine.Computer_Major_V.Parent := mainScene.Config.main.R.Profile.Machine.Computer;
  mainScene.Config.main.R.Profile.Machine.Computer_Major_V.SetBounds(140, 132, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Computer_Major_V.Text := IntToStr(TOSVersion.Major);
  mainScene.Config.main.R.Profile.Machine.Computer_Major_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Computer_Minor := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Computer);
  mainScene.Config.main.R.Profile.Machine.Computer_Minor.Name := 'Main_Config_Profile_Machine_Computer_Minor_Label';
  mainScene.Config.main.R.Profile.Machine.Computer_Minor.Parent := mainScene.Config.main.R.Profile.Machine.Computer;
  mainScene.Config.main.R.Profile.Machine.Computer_Minor.SetBounds(10, 156, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Computer_Minor.Text := 'Minor : ';
  mainScene.Config.main.R.Profile.Machine.Computer_Minor.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Computer_Minor_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Computer);
  mainScene.Config.main.R.Profile.Machine.Computer_Minor_V.Name := 'Main_Config_Profile_Machine_Computer_Minor_V_Label';
  mainScene.Config.main.R.Profile.Machine.Computer_Minor_V.Parent := mainScene.Config.main.R.Profile.Machine.Computer;
  mainScene.Config.main.R.Profile.Machine.Computer_Minor_V.SetBounds(140, 156, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Computer_Minor_V.Text := IntToStr(TOSVersion.Minor);
  mainScene.Config.main.R.Profile.Machine.Computer_Minor_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Computer_Build := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Computer);
  mainScene.Config.main.R.Profile.Machine.Computer_Build.Name := 'Main_Config_Profile_Machine_Computer_Build_Label';
  mainScene.Config.main.R.Profile.Machine.Computer_Build.Parent := mainScene.Config.main.R.Profile.Machine.Computer;
  mainScene.Config.main.R.Profile.Machine.Computer_Build.SetBounds(10, 180, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Computer_Build.Text := 'Build : ';
  mainScene.Config.main.R.Profile.Machine.Computer_Build.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Computer_Build_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Computer);
  mainScene.Config.main.R.Profile.Machine.Computer_Build_V.Name := 'Main_Config_Profile_Machine_Computer_Build_V_Label';
  mainScene.Config.main.R.Profile.Machine.Computer_Build_V.Parent := mainScene.Config.main.R.Profile.Machine.Computer;
  mainScene.Config.main.R.Profile.Machine.Computer_Build_V.SetBounds(140, 180, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Computer_Build_V.Text := IntToStr(TOSVersion.Build);
  mainScene.Config.main.R.Profile.Machine.Computer_Build_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Interner := TGroupBox.Create(mainScene.Config.main.R.Profile.Machine.Panel);
  mainScene.Config.main.R.Profile.Machine.Interner.Name := 'Main_Config_Profile_Machine_Internet';
  mainScene.Config.main.R.Profile.Machine.Interner.Parent := mainScene.Config.main.R.Profile.Machine.Panel;
  mainScene.Config.main.R.Profile.Machine.Interner.SetBounds(10, 230, 580, 150);
  mainScene.Config.main.R.Profile.Machine.Interner.Text := 'Internet : ';
  mainScene.Config.main.R.Profile.Machine.Interner.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Interner_Internet := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Interner);
  mainScene.Config.main.R.Profile.Machine.Interner_Internet.Name := 'Main_Config_Profile_Machine_Internet_Internet_Label';
  mainScene.Config.main.R.Profile.Machine.Interner_Internet.Parent := mainScene.Config.main.R.Profile.Machine.Interner;
  mainScene.Config.main.R.Profile.Machine.Interner_Internet.SetBounds(10, 20, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Interner_Internet.Text := 'Internet : ';
  mainScene.Config.main.R.Profile.Machine.Interner_Internet.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Interner_Internet_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Interner);
  mainScene.Config.main.R.Profile.Machine.Interner_Internet_V.Name := 'Main_Config_Profile_Machine_Info_V_Label';
  mainScene.Config.main.R.Profile.Machine.Interner_Internet_V.Parent := mainScene.Config.main.R.Profile.Machine.Interner;
  mainScene.Config.main.R.Profile.Machine.Interner_Internet_V.SetBounds(140, 20, 440, 24);
  if uWindows_IsConected_ToInternet then
    mainScene.Config.main.R.Profile.Machine.Interner_Internet_V.Text := 'Connected'
  else
    mainScene.Config.main.R.Profile.Machine.Interner_Internet_V.Text := 'Disconnected';
  mainScene.Config.main.R.Profile.Machine.Interner_Internet_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Interner_Local_IP := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Interner);
  mainScene.Config.main.R.Profile.Machine.Interner_Local_IP.Name := 'Main_Config_Profile_Machine_Internet_Local_IP_Label';
  mainScene.Config.main.R.Profile.Machine.Interner_Local_IP.Parent := mainScene.Config.main.R.Profile.Machine.Interner;
  mainScene.Config.main.R.Profile.Machine.Interner_Local_IP.SetBounds(10, 44, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Interner_Local_IP.Text := 'Local IP : ';
  mainScene.Config.main.R.Profile.Machine.Interner_Local_IP.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Interner_Local_IP_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Interner);
  mainScene.Config.main.R.Profile.Machine.Interner_Local_IP_V.Name := 'Main_Config_Profile_Machine_Internet_Local_IP_V_Label';
  mainScene.Config.main.R.Profile.Machine.Interner_Local_IP_V.Parent := mainScene.Config.main.R.Profile.Machine.Interner;
  mainScene.Config.main.R.Profile.Machine.Interner_Local_IP_V.SetBounds(140, 44, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Interner_Local_IP_V.Text := uWindows.GetIPAddress;
  mainScene.Config.main.R.Profile.Machine.Interner_Local_IP_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Interner_Public_IP := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Interner);
  mainScene.Config.main.R.Profile.Machine.Interner_Public_IP.Name := 'Main_Config_Profile_Machine_Internet_Public_IP_Label';
  mainScene.Config.main.R.Profile.Machine.Interner_Public_IP.Parent := mainScene.Config.main.R.Profile.Machine.Interner;
  mainScene.Config.main.R.Profile.Machine.Interner_Public_IP.SetBounds(10, 68, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Interner_Public_IP.Text := 'Public IP : ';
  mainScene.Config.main.R.Profile.Machine.Interner_Public_IP.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Interner_Public_IP := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Interner);
  mainScene.Config.main.R.Profile.Machine.Interner_Public_IP.Name := 'Main_Config_Profile_Machine_Internet_Public_IP_V_Label';
  mainScene.Config.main.R.Profile.Machine.Interner_Public_IP.Parent := mainScene.Config.main.R.Profile.Machine.Interner;
  mainScene.Config.main.R.Profile.Machine.Interner_Public_IP.SetBounds(140, 68, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Interner_Public_IP.Text := user_Active_Online.IP;
  mainScene.Config.main.R.Profile.Machine.Interner_Public_IP.Visible := True;
end;

procedure Free;
begin
  FreeAndNil(mainScene.Config.main.R.Profile.Machine.Panel);
end;

end.
