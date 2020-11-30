unit uMain;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UITypes,
  FMX.Forms;

procedure Load;

procedure Exit;
procedure Exit_Exit;
procedure Exit_SaveProgress;
procedure Exit_Stay;
procedure Exit_OnOverText(vButton_Text: String; vLeave: Boolean);

procedure Minimized;

implementation

uses
  main,
  uLoad_AllTypes,
  uEmu_SetAll,
  uDB,
  uDB_AUser,
  uMain_Emulation,
  uMain_SetAll,
  uMain_AllTypes;

procedure Load;
begin
  // Set the form state
  Main_Form.Width := uDB_AUser.Local.SETTINGS.Resolution.Width;
  Main_Form.Height := uDB_AUser.Local.SETTINGS.Resolution.Height;
  Main_Form.FullScreen := uDB_AUser.Local.SETTINGS.Resolution.Window;
  // Set all the components
  uMain_SetAll.Load;
  // Set the standard values
  // Header
  ex_main.Settings.Header_Pos.X := 0;
  ex_main.Settings.Header_Pos.Y := 0;
  // Selection
  ex_main.Settings.MainSelection_Pos.X := 0;
  ex_main.Settings.MainSelection_Pos.Y := mainScene.Selection.Back.Position.Y;
  // Footer
  ex_main.Settings.Footer_Pos.X := 0;
  ex_main.Settings.Footer_Pos.Y := mainScene.Footer.Back.Position.Y;

  // Emulators Default
  uEmu_SetComponentsToRightPlace;
  // if emulation.Active then
  // if emulation.ShowCat then

  emulation.Level := 0;
  emulation.Category_Num := 0;
  uMain_Emulation.Category(emulation.Level, emulation.Category_Num);

  // extrafe state
  extrafe.prog.State := 'main';
end;

procedure Exit;
begin
  uMain_SetAll.Free;
end;

procedure Exit_SaveProgress;
begin
  if extrafe.databases.online_connected then
  begin
    uDB.ExtraFE_DB.Disconnect;
    FreeAndNil(uDB.ExtraFE_DB);
  end;
  uDB.ExtraFE_Query_Local.Close;
  uDB.ExtraFE_DB_Local.Connected := False;
  FreeAndNil(uDB.ExtraFE_DB_Local);
end;

procedure Exit_Exit;
begin
  Exit_SaveProgress;
  // ReportMemoryLeaksOnShutdown:= True;
  Application.Terminate;
end;

procedure Exit_Stay;
begin
  mainScene.Header.Back_Blur.Enabled := False;
  mainScene.Selection.Blur.Enabled := False;
  mainScene.Footer.Back_Blur.Enabled := False;
  FreeAndNil(mainScene.main.Prog_Exit.Panel);
  extrafe.prog.State := 'main';
end;

procedure Exit_OnOverText(vButton_Text: String; vLeave: Boolean);
begin
  if vLeave then
  begin
    if vButton_Text = 'Yes' then
      mainScene.main.Prog_Exit.main.Yes.Text := 'Sorry, I have to go'
    else if vButton_Text = 'No' then
      mainScene.main.Prog_Exit.main.No.Text := 'One minute more, please';
  end
  else
  begin
    if vButton_Text = 'Yes' then
      mainScene.main.Prog_Exit.main.Yes.Text := 'No, no don''t push it'
    else if vButton_Text = 'No' then
      mainScene.main.Prog_Exit.main.No.Text := 'Push it damn it';
  end;
end;

procedure Minimized;
begin
  Main_Form.FullScreen := False;
  Main_Form.WindowState := TWindowState.wsMinimized;
end;

end.
