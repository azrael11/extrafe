unit uMain_Config_Profile_Machine;

interface

uses
  System.Classes,
  System.SysUtils,
  FMX.StdCtrls,
  FMX.Layouts,
  FMX.Types,
  System.JSON,
  REST.Types;

procedure Load;

procedure Machine_Info;
procedure Internet_Network_Info;

procedure Free;

implementation

uses
  uLoad_AllTypes,
  uMain_AllTypes,
  uDB_AUser,
  uWindows,
  uInternet_Files;

procedure Load;
begin
  extrafe.prog.State := 'main_config_profile_machine';

  if mainScene.Config.main.R.Profile.Machine.Layout = nil then
  begin
    mainScene.Config.main.R.Profile.Machine.Layout := TLayout.Create(mainScene.Config.main.R.Profile.TabItem[2]);
    mainScene.Config.main.R.Profile.Machine.Layout.Name := 'Main_Config_Profile_Machine';
    mainScene.Config.main.R.Profile.Machine.Layout.Parent := mainScene.Config.main.R.Profile.TabItem[2];
    mainScene.Config.main.R.Profile.Machine.Layout.SetBounds(0, 0, mainScene.Config.main.R.Profile.TabControl.Width,
      mainScene.Config.main.R.Profile.TabControl.Height);
    mainScene.Config.main.R.Profile.Machine.Layout.Visible := True;

    mainScene.Config.main.R.Profile.Machine.VBox := TVertScrollBox.Create(mainScene.Config.main.R.Profile.Machine.Layout);
    mainScene.Config.main.R.Profile.Machine.VBox.Name := 'Main_Config_Profile_Machine_VerticalScrollBox';
    mainScene.Config.main.R.Profile.Machine.VBox.Parent := mainScene.Config.main.R.Profile.Machine.Layout;
    mainScene.Config.main.R.Profile.Machine.VBox.Align := TAlignLayout.Client;
    mainScene.Config.main.R.Profile.Machine.VBox.Visible := True;

    Machine_Info;
    Internet_Network_Info;
  end;
end;

procedure Machine_Info;
begin
  mainScene.Config.main.R.Profile.Machine.OS.Box := TGroupBox.Create(mainScene.Config.main.R.Profile.Machine.VBox);
  mainScene.Config.main.R.Profile.Machine.OS.Box.Name := 'Main_Config_Profile_Machine_OS_Box';
  mainScene.Config.main.R.Profile.Machine.OS.Box.Parent := mainScene.Config.main.R.Profile.Machine.VBox;
  mainScene.Config.main.R.Profile.Machine.OS.Box.SetBounds(10, 10, 560, 210);
  mainScene.Config.main.R.Profile.Machine.OS.Box.Text := 'Operating System : ';
  mainScene.Config.main.R.Profile.Machine.OS.Box.Visible := True;

  mainScene.Config.main.R.Profile.Machine.OS.Info := TLabel.Create(mainScene.Config.main.R.Profile.Machine.OS.Box);
  mainScene.Config.main.R.Profile.Machine.OS.Info.Name := 'Main_Config_Profile_Machine_OS_Info';
  mainScene.Config.main.R.Profile.Machine.OS.Info.Parent := mainScene.Config.main.R.Profile.Machine.OS.Box;
  mainScene.Config.main.R.Profile.Machine.OS.Info.SetBounds(10, 20, 140, 24);
  mainScene.Config.main.R.Profile.Machine.OS.Info.Text := 'Information : ';
  mainScene.Config.main.R.Profile.Machine.OS.Info.Visible := True;

  mainScene.Config.main.R.Profile.Machine.OS.Info_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.OS.Box);
  mainScene.Config.main.R.Profile.Machine.OS.Info_V.Name := 'Main_Config_Profile_Machine_OS_Info_V';
  mainScene.Config.main.R.Profile.Machine.OS.Info_V.Parent := mainScene.Config.main.R.Profile.Machine.OS.Box;
  mainScene.Config.main.R.Profile.Machine.OS.Info_V.SetBounds(140, 20, 440, 24);
  mainScene.Config.main.R.Profile.Machine.OS.Info_V.Text := TOSVersion.ToString;
  mainScene.Config.main.R.Profile.Machine.OS.Info_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.OS.Architecture := TLabel.Create(mainScene.Config.main.R.Profile.Machine.OS.Box);
  mainScene.Config.main.R.Profile.Machine.OS.Architecture.Name := 'Main_Config_Profile_Machine_OS_Architecture';
  mainScene.Config.main.R.Profile.Machine.OS.Architecture.Parent := mainScene.Config.main.R.Profile.Machine.OS.Box;
  mainScene.Config.main.R.Profile.Machine.OS.Architecture.SetBounds(10, 60, 140, 24);
  mainScene.Config.main.R.Profile.Machine.OS.Architecture.Text := 'Architecture : ';
  mainScene.Config.main.R.Profile.Machine.OS.Architecture.Visible := True;

  mainScene.Config.main.R.Profile.Machine.OS.Architecture_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.OS.Box);
  mainScene.Config.main.R.Profile.Machine.OS.Architecture_V.Name := 'Main_Config_Profile_Machine_OS_Architecture_V';
  mainScene.Config.main.R.Profile.Machine.OS.Architecture_V.Parent := mainScene.Config.main.R.Profile.Machine.OS.Box;
  mainScene.Config.main.R.Profile.Machine.OS.Architecture_V.SetBounds(140, 60, 140, 24);
  mainScene.Config.main.R.Profile.Machine.OS.Architecture_V.Text := uWindows.Os_Architecture(TOSVersion.Architecture);
  mainScene.Config.main.R.Profile.Machine.OS.Architecture_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.OS.VPlatform := TLabel.Create(mainScene.Config.main.R.Profile.Machine.OS.Box);
  mainScene.Config.main.R.Profile.Machine.OS.VPlatform.Name := 'Main_Config_Profile_Machine_OS_VPlatform';
  mainScene.Config.main.R.Profile.Machine.OS.VPlatform.Parent := mainScene.Config.main.R.Profile.Machine.OS.Box;
  mainScene.Config.main.R.Profile.Machine.OS.VPlatform.SetBounds(10, 84, 140, 24);
  mainScene.Config.main.R.Profile.Machine.OS.VPlatform.Text := 'Platform : ';
  mainScene.Config.main.R.Profile.Machine.OS.VPlatform.Visible := True;

  mainScene.Config.main.R.Profile.Machine.OS.VPlatform_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.OS.Box);
  mainScene.Config.main.R.Profile.Machine.OS.VPlatform_V.Name := 'Main_Config_Profile_Machine_OS_VPlatform_V';
  mainScene.Config.main.R.Profile.Machine.OS.VPlatform_V.Parent := mainScene.Config.main.R.Profile.Machine.OS.Box;
  mainScene.Config.main.R.Profile.Machine.OS.VPlatform_V.SetBounds(140, 84, 140, 24);
  mainScene.Config.main.R.Profile.Machine.OS.VPlatform_V.Text := uWindows.Os_Platform(TOSVersion.Platform) + ' ' + uWindows.Os_Platform_Point.ToString + ' bit';
  mainScene.Config.main.R.Profile.Machine.OS.VPlatform_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.OS.Operating_System := TLabel.Create(mainScene.Config.main.R.Profile.Machine.OS.Box);
  mainScene.Config.main.R.Profile.Machine.OS.Operating_System.Name := 'Main_Config_Profile_Machine_OS_Operating_System';
  mainScene.Config.main.R.Profile.Machine.OS.Operating_System.Parent := mainScene.Config.main.R.Profile.Machine.OS.Box;
  mainScene.Config.main.R.Profile.Machine.OS.Operating_System.SetBounds(10, 108, 140, 24);
  mainScene.Config.main.R.Profile.Machine.OS.Operating_System.Text := 'Operating System : ';
  mainScene.Config.main.R.Profile.Machine.OS.Operating_System.Visible := True;

  mainScene.Config.main.R.Profile.Machine.OS.Operating_System_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.OS.Box);
  mainScene.Config.main.R.Profile.Machine.OS.Operating_System_V.Name := 'Main_Config_Profile_Machine_OS_Operating_System_V';
  mainScene.Config.main.R.Profile.Machine.OS.Operating_System_V.Parent := mainScene.Config.main.R.Profile.Machine.OS.Box;
  mainScene.Config.main.R.Profile.Machine.OS.Operating_System_V.SetBounds(140, 108, 140, 24);
  mainScene.Config.main.R.Profile.Machine.OS.Operating_System_V.Text := TOSVersion.Name;
  mainScene.Config.main.R.Profile.Machine.OS.Operating_System_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.OS.Major := TLabel.Create(mainScene.Config.main.R.Profile.Machine.OS.Box);
  mainScene.Config.main.R.Profile.Machine.OS.Major.Name := 'Main_Config_Profile_Machine_OS_Major';
  mainScene.Config.main.R.Profile.Machine.OS.Major.Parent := mainScene.Config.main.R.Profile.Machine.OS.Box;
  mainScene.Config.main.R.Profile.Machine.OS.Major.SetBounds(10, 132, 140, 24);
  mainScene.Config.main.R.Profile.Machine.OS.Major.Text := 'Major : ';
  mainScene.Config.main.R.Profile.Machine.OS.Major.Visible := True;

  mainScene.Config.main.R.Profile.Machine.OS.Major_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.OS.Box);
  mainScene.Config.main.R.Profile.Machine.OS.Major_V.Name := 'Main_Config_Profile_Machine_OS_Major_V';
  mainScene.Config.main.R.Profile.Machine.OS.Major_V.Parent := mainScene.Config.main.R.Profile.Machine.OS.Box;
  mainScene.Config.main.R.Profile.Machine.OS.Major_V.SetBounds(140, 132, 140, 24);
  mainScene.Config.main.R.Profile.Machine.OS.Major_V.Text := IntToStr(TOSVersion.Major);
  mainScene.Config.main.R.Profile.Machine.OS.Major_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.OS.Minor := TLabel.Create(mainScene.Config.main.R.Profile.Machine.OS.Box);
  mainScene.Config.main.R.Profile.Machine.OS.Minor.Name := 'Main_Config_Profile_Machine_OS_Minor';
  mainScene.Config.main.R.Profile.Machine.OS.Minor.Parent := mainScene.Config.main.R.Profile.Machine.OS.Box;
  mainScene.Config.main.R.Profile.Machine.OS.Minor.SetBounds(10, 156, 140, 24);
  mainScene.Config.main.R.Profile.Machine.OS.Minor.Text := 'Minor : ';
  mainScene.Config.main.R.Profile.Machine.OS.Minor.Visible := True;

  mainScene.Config.main.R.Profile.Machine.OS.Minor_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.OS.Box);
  mainScene.Config.main.R.Profile.Machine.OS.Minor_V.Name := 'Main_Config_Profile_Machine_OS_Minor_V';
  mainScene.Config.main.R.Profile.Machine.OS.Minor_V.Parent := mainScene.Config.main.R.Profile.Machine.OS.Box;
  mainScene.Config.main.R.Profile.Machine.OS.Minor_V.SetBounds(140, 156, 140, 24);
  mainScene.Config.main.R.Profile.Machine.OS.Minor_V.Text := IntToStr(TOSVersion.Minor);
  mainScene.Config.main.R.Profile.Machine.OS.Minor_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.OS.Build := TLabel.Create(mainScene.Config.main.R.Profile.Machine.OS.Box);
  mainScene.Config.main.R.Profile.Machine.OS.Build.Name := 'Main_Config_Profile_Machine_OS_Build';
  mainScene.Config.main.R.Profile.Machine.OS.Build.Parent := mainScene.Config.main.R.Profile.Machine.OS.Box;
  mainScene.Config.main.R.Profile.Machine.OS.Build.SetBounds(10, 180, 140, 24);
  mainScene.Config.main.R.Profile.Machine.OS.Build.Text := 'Build : ';
  mainScene.Config.main.R.Profile.Machine.OS.Build.Visible := True;

  mainScene.Config.main.R.Profile.Machine.OS.Build_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.OS.Box);
  mainScene.Config.main.R.Profile.Machine.OS.Build_V.Name := 'Main_Config_Profile_Machine_OS_Build_V';
  mainScene.Config.main.R.Profile.Machine.OS.Build_V.Parent := mainScene.Config.main.R.Profile.Machine.OS.Box;
  mainScene.Config.main.R.Profile.Machine.OS.Build_V.SetBounds(140, 180, 140, 24);
  mainScene.Config.main.R.Profile.Machine.OS.Build_V.Text := IntToStr(TOSVersion.Build);
  mainScene.Config.main.R.Profile.Machine.OS.Build_V.Visible := True;
end;

procedure Internet_Network_Info;
var
  myJSON_Value: TJSONValue;
  vOutValue: String;
begin
  mainScene.Config.main.R.Profile.Machine.Net.Box := TGroupBox.Create(mainScene.Config.main.R.Profile.Machine.VBox);
  mainScene.Config.main.R.Profile.Machine.Net.Box.Name := 'Main_Config_Profile_Machine_Net_Box';
  mainScene.Config.main.R.Profile.Machine.Net.Box.Parent := mainScene.Config.main.R.Profile.Machine.VBox;
  mainScene.Config.main.R.Profile.Machine.Net.Box.SetBounds(10, 230, 560, 210);
  mainScene.Config.main.R.Profile.Machine.Net.Box.Text := 'Network : ';
  mainScene.Config.main.R.Profile.Machine.Net.Box.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.Internet := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.Internet.Name := 'Main_Config_Profile_Machine_Net_Internet';
  mainScene.Config.main.R.Profile.Machine.Net.Internet.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.Internet.SetBounds(10, 20, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Net.Internet.Text := 'Internet : ';
  mainScene.Config.main.R.Profile.Machine.Net.Internet.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.Internet_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.Internet_V.Name := 'Main_Config_Profile_Machine_Net_Internet_V';
  mainScene.Config.main.R.Profile.Machine.Net.Internet_V.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.Internet_V.SetBounds(140, 20, 440, 24);
  if uInternet_Files.Internet_Connected then
    mainScene.Config.main.R.Profile.Machine.Net.Internet_V.Text := 'Connected'
  else
    mainScene.Config.main.R.Profile.Machine.Net.Internet_V.Text := 'Disconnected';
  mainScene.Config.main.R.Profile.Machine.Net.Internet_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.Local_IP := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.Local_IP.Name := 'Main_Config_Profile_Machine_Net_Local_IP';
  mainScene.Config.main.R.Profile.Machine.Net.Local_IP.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.Local_IP.SetBounds(10, 68, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Net.Local_IP.Text := 'Local IP : ';
  mainScene.Config.main.R.Profile.Machine.Net.Local_IP.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.Local_IP_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.Local_IP_V.Name := 'Main_Config_Profile_Machine_Net_Local_IP_V';
  mainScene.Config.main.R.Profile.Machine.Net.Local_IP_V.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.Local_IP_V.SetBounds(140, 68, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Net.Local_IP_V.Text := uInternet_Files.IP_Get_Address;
  mainScene.Config.main.R.Profile.Machine.Net.Local_IP_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.Public_IP := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.Public_IP.Name := 'Main_Config_Profile_Machine_Net_Public_IP';
  mainScene.Config.main.R.Profile.Machine.Net.Public_IP.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.Public_IP.SetBounds(10, 92, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Net.Public_IP.Text := 'Public IP : ';
  mainScene.Config.main.R.Profile.Machine.Net.Public_IP.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.Public_IP_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.Public_IP_V.Name := 'Main_Config_Profile_Machine_Net_Public_IP_V';
  mainScene.Config.main.R.Profile.Machine.Net.Public_IP_V.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.Public_IP_V.SetBounds(140, 92, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Net.Public_IP_V.Text := uDB_AUser.Online.IP;
  mainScene.Config.main.R.Profile.Machine.Net.Public_IP_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.Mac_Address := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.Mac_Address.Name := 'Main_Config_Profile_Machine_Net_Mac_Address';
  mainScene.Config.main.R.Profile.Machine.Net.Mac_Address.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.Mac_Address.SetBounds(10, 116, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Net.Mac_Address.Text := 'Mac Address : ';
  mainScene.Config.main.R.Profile.Machine.Net.Mac_Address.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.Mac_Address_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.Mac_Address_V.Name := 'Main_Config_Profile_Machine_Net_Mac_Address_V';
  mainScene.Config.main.R.Profile.Machine.Net.Mac_Address_V.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.Mac_Address_V.SetBounds(140, 116, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Net.Mac_Address_V.Text := uInternet_Files.GetMACAdress.Strings[0];
  mainScene.Config.main.R.Profile.Machine.Net.Mac_Address_V.Visible := True;

  myJSON_Value := uInternet_Files.JSONValue('Global_IP', 'ipinfo.io/json', TRESTRequestMethod.rmGET);

  mainScene.Config.main.R.Profile.Machine.Net.HostName := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.HostName.Name := 'Main_Config_Profile_Machine_Net_HostName';
  mainScene.Config.main.R.Profile.Machine.Net.HostName.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.HostName.SetBounds(280, 20, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Net.HostName.Text := 'Organization : ';
  mainScene.Config.main.R.Profile.Machine.Net.HostName.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.HostName_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.HostName_V.Name := 'Main_Config_Profile_Machine_Net_HostName_V';
  mainScene.Config.main.R.Profile.Machine.Net.HostName_V.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.HostName_V.SetBounds(380, 20, 180, 50);
  if myJSON_Value.TryGetValue('org', vOutValue) then
    mainScene.Config.main.R.Profile.Machine.Net.HostName_V.Text := myJSON_Value.GetValue<String>('org')
  else
    mainScene.Config.main.R.Profile.Machine.Net.HostName_V.Text := 'unknown';
  mainScene.Config.main.R.Profile.Machine.Net.HostName_V.TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Profile.Machine.Net.HostName_V.WordWrap := True;
  mainScene.Config.main.R.Profile.Machine.Net.HostName_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.City := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.City.Name := 'Main_Config_Profile_Machine_Net_City';
  mainScene.Config.main.R.Profile.Machine.Net.City.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.City.SetBounds(280, 68, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Net.City.Text := 'City : ';
  mainScene.Config.main.R.Profile.Machine.Net.City.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.City_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.City_V.Name := 'Main_Config_Profile_Machine_Net_City_V';
  mainScene.Config.main.R.Profile.Machine.Net.City_V.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.City_V.SetBounds(380, 68, 440, 24);
  mainScene.Config.main.R.Profile.Machine.Net.City_V.Text := myJSON_Value.GetValue<String>('city');
  mainScene.Config.main.R.Profile.Machine.Net.City_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.Region := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.Region.Name := 'Main_Config_Profile_Machine_Net_Region';
  mainScene.Config.main.R.Profile.Machine.Net.Region.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.Region.SetBounds(280, 92, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Net.Region.Text := 'Region : ';
  mainScene.Config.main.R.Profile.Machine.Net.Region.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.Region_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.Region_V.Name := 'Main_Config_Profile_Machine_Net_Region_V';
  mainScene.Config.main.R.Profile.Machine.Net.Region_V.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.Region_V.SetBounds(380, 92, 440, 24);
  mainScene.Config.main.R.Profile.Machine.Net.Region_V.Text := myJSON_Value.GetValue<String>('region');
  mainScene.Config.main.R.Profile.Machine.Net.Region_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.Country_Symbol := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.Country_Symbol.Name := 'Main_Config_Profile_Machine_Net_Country_Symbol';
  mainScene.Config.main.R.Profile.Machine.Net.Country_Symbol.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.Country_Symbol.SetBounds(280, 116, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Net.Country_Symbol.Text := 'Country_Symbol : ';
  mainScene.Config.main.R.Profile.Machine.Net.Country_Symbol.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.Country_Symbol_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.Country_Symbol_V.Name := 'Main_Config_Profile_Machine_Net_Country_Symbol_V';
  mainScene.Config.main.R.Profile.Machine.Net.Country_Symbol_V.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.Country_Symbol_V.SetBounds(380, 116, 440, 24);
  mainScene.Config.main.R.Profile.Machine.Net.Country_Symbol_V.Text := myJSON_Value.GetValue<String>('country');
  mainScene.Config.main.R.Profile.Machine.Net.Country_Symbol_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.Localization := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.Localization.Name := 'Main_Config_Profile_Machine_Net_Localization';
  mainScene.Config.main.R.Profile.Machine.Net.Localization.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.Localization.SetBounds(280, 140, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Net.Localization.Text := 'Localization : ';
  mainScene.Config.main.R.Profile.Machine.Net.Localization.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.Localization_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.Localization_V.Name := 'Main_Config_Profile_Machine_Net_Localization_V';
  mainScene.Config.main.R.Profile.Machine.Net.Localization_V.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.Localization_V.SetBounds(380, 140, 440, 24);
  mainScene.Config.main.R.Profile.Machine.Net.Localization_V.Text := myJSON_Value.GetValue<String>('loc');
  mainScene.Config.main.R.Profile.Machine.Net.Localization_V.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.Time_Zone := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.Time_Zone.Name := 'Main_Config_Profile_Machine_Net_Time_Zone';
  mainScene.Config.main.R.Profile.Machine.Net.Time_Zone.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.Time_Zone.SetBounds(280, 164, 140, 24);
  mainScene.Config.main.R.Profile.Machine.Net.Time_Zone.Text := 'Time Zone : ';
  mainScene.Config.main.R.Profile.Machine.Net.Time_Zone.Visible := True;

  mainScene.Config.main.R.Profile.Machine.Net.Time_Zone_V := TLabel.Create(mainScene.Config.main.R.Profile.Machine.Net.Box);
  mainScene.Config.main.R.Profile.Machine.Net.Time_Zone_V.Name := 'Main_Config_Profile_Machine_Net_Time_Zone_V';
  mainScene.Config.main.R.Profile.Machine.Net.Time_Zone_V.Parent := mainScene.Config.main.R.Profile.Machine.Net.Box;
  mainScene.Config.main.R.Profile.Machine.Net.Time_Zone_V.SetBounds(380, 164, 440, 24);
  mainScene.Config.main.R.Profile.Machine.Net.Time_Zone_V.Text := myJSON_Value.GetValue<String>('timezone');
  mainScene.Config.main.R.Profile.Machine.Net.Time_Zone_V.Visible := True;

end;

procedure Free;
begin
  FreeAndNil(mainScene.Config.main.R.Profile.Machine.VBox);
end;

end.
