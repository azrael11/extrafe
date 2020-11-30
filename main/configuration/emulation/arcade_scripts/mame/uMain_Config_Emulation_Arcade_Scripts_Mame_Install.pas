unit uMain_Config_Emulation_Arcade_Scripts_Mame_Install;

interface

uses
  System.Classes,
  System.UiTypes,
  System.SysUtils,
  System.IniFiles,
  Winapi.ShellApi,
  Winapi.Windows,
  FMX.Forms,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.TabControl,
  FMX.Types,
  FMX.Edit,
  FMX.Dialogs,
  ALFMXObjects;

type
  TMAIN_MAME_INSTALL_OPENDIALOG = class(TObject)
    procedure OnClose(Sender: TObject);
  end;

type
  TMAIN_MAME_INSTALL_TAB1 = record
    Box: TGroupBox;
    Text: TALText;
  end;

type
  TMAIN_MAME_INSTALL_TAB2 = record
    Box: TGroupBox;
    Radio_1: TRadioButton;
    Radio_2: TRadioButton;
    Warning: TText;
    Text: TLabel;
  end;

type
  TMAIN_MAME_INSTALL_TAB3 = record
    Box: TGroupBox;
    Edit_Info: TLabel;
    Edit: TEdit;
    Find: TButton;
    Server_Info: array [0 .. 4] of TLabel;
    Start: TButton;
    Progress: TProgressBar;
    Open_Dialog: TOpenDialog;
    Dialog: TMAIN_MAME_INSTALL_OPENDIALOG;
  end;

type
  TMAIN_MAME_INSTALL_TAB4 = record
    Box: TGroupBox;
    Text: TALText;
    Success: TButton;
  end;

type
  TEMU_MAME_INSTALL_MAIN = record
    Panel: TPanel;
    Control: TTabControl;
    Tabs: array [0 .. 3] of TTabItem;
    Tab1: TMAIN_MAME_INSTALL_TAB1;
    Tab2: TMAIN_MAME_INSTALL_TAB2;
    Tab3: TMAIN_MAME_INSTALL_TAB3;
    Tab4: TMAIN_MAME_INSTALL_TAB4;
    Cancel: TButton;
    Back: TButton;
    Next: TButton;
    Status: String;
  end;

type
  TEMU_MAME_INSTALL = record
    Panel: TPanel;
    Main: TEMU_MAME_INSTALL_MAIN;
  end;

var
  Script_Mame_Install: TEMU_MAME_INSTALL;

procedure uEmulation_Arcade_Mame_Install;
procedure uEmulation_Arcade_Mame_Install_Free;

procedure CreateTab1;
procedure CreateTab2;
procedure CreateTab3_Computer;
procedure CreateTab3_Server;
procedure CreateTab4;

procedure uEmulation_Arcade_Mame_Install_Start_FromComputer;

procedure uEmulation_Arcade_Mame_Install_Slide_To_Next;
procedure uEmulation_Arcade_Mame_Install_Slide_To_Previous;

procedure uEmulation_Arcade_Mame_Install_Final;

procedure Update_Database;

procedure ShowButtons;

implementation

uses
  uDB_AUser,
  uDB,
  uLoad_AllTypes,
  uLoad_Emulation,
  Main,
  uMain_AllTypes,
  uMain_Emulation,
  uEmu_Arcade_Mame_SetAll,
  uMain_Config_Emulators,
  uEmu_Arcade_Mame_AllTypes;

procedure uEmulation_Arcade_Mame_Install;
var
  vi: Integer;
begin
  extrafe.prog.State := 'main_config_install_emulator';
  Script_Mame_Install.Main.Status := 'phase_1';

  mainScene.Config.Main.Left_Blur.Enabled := True;
  mainScene.Config.Main.R.Emulators.Panel_Blur.Enabled := True;

  Script_Mame_Install.Panel := TPanel.Create(Main_Form);
  Script_Mame_Install.Panel.Name := 'Script_Mame_Install';
  Script_Mame_Install.Panel.Parent := Main_Form;
  Script_Mame_Install.Panel.SetBounds(uDB_AUser.Local.SETTINGS.Resolution.Half_Width - 300, uDB_AUser.Local.SETTINGS.Resolution.Half_Height - 175, 600, 350);
  Script_Mame_Install.Panel.Visible := True;

  CreateHeader(Script_Mame_Install.Panel, 'IcoMoon-Free', #$e997, TAlphaColorRec.DeepSkyBlue, 'Install a Mame emulator', false, nil);

  Script_Mame_Install.Main.Panel := TPanel.Create(Script_Mame_Install.Panel);
  Script_Mame_Install.Main.Panel.Name := 'Script_Mame_Install_Main';
  Script_Mame_Install.Main.Panel.Parent := Script_Mame_Install.Panel;
  Script_Mame_Install.Main.Panel.SetBounds(0, 30, Script_Mame_Install.Panel.Width, Script_Mame_Install.Panel.Height - 30);
  Script_Mame_Install.Main.Panel.Visible := True;

  Script_Mame_Install.Main.Control := TTabControl.Create(Script_Mame_Install.Main.Panel);
  Script_Mame_Install.Main.Control.Name := 'Script_Mame_Install_Main_Control';
  Script_Mame_Install.Main.Control.Parent := Script_Mame_Install.Main.Panel;
  Script_Mame_Install.Main.Control.Align := TAlignLayout.Client;
  Script_Mame_Install.Main.Control.TabPosition := TTabPosition.None;
  Script_Mame_Install.Main.Control.Visible := True;

  for vi := 0 to 3 do
  begin
    Script_Mame_Install.Main.Tabs[vi] := TTabItem.Create(Script_Mame_Install.Main.Control);
    Script_Mame_Install.Main.Tabs[vi].Name := 'Script_Mame_Install_Main_Tab_' + vi.ToString;
    Script_Mame_Install.Main.Tabs[vi].Parent := Script_Mame_Install.Main.Control;
    Script_Mame_Install.Main.Tabs[vi].SetBounds(0, 0, Script_Mame_Install.Main.Control.Width, 200);
    Script_Mame_Install.Main.Tabs[vi].Visible := True;
  end;

  CreateTab1;
  CreateTab2;
  CreateTab4;

  Script_Mame_Install.Main.Next := TButton.Create(Script_Mame_Install.Panel);
  Script_Mame_Install.Main.Next.Name := 'Script_Mame_Install_Main_Next';
  Script_Mame_Install.Main.Next.Parent := Script_Mame_Install.Panel;
  Script_Mame_Install.Main.Next.SetBounds(Script_Mame_Install.Main.Control.Width - 190, Script_Mame_Install.Main.Control.Height - 50, 140, 40);
  Script_Mame_Install.Main.Next.Text := 'Next';
  Script_Mame_Install.Main.Next.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Next.Visible := false;

  Script_Mame_Install.Main.Back := TButton.Create(Script_Mame_Install.Panel);
  Script_Mame_Install.Main.Back.Name := 'Script_Mame_Install_Main_Back';
  Script_Mame_Install.Main.Back.Parent := Script_Mame_Install.Panel;
  Script_Mame_Install.Main.Back.SetBounds((Script_Mame_Install.Main.Control.Width / 2) - 70, Script_Mame_Install.Main.Control.Height - 50, 140, 40);
  Script_Mame_Install.Main.Back.Text := 'Back';
  Script_Mame_Install.Main.Back.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Back.Visible := True;

  Script_Mame_Install.Main.Cancel := TButton.Create(Script_Mame_Install.Panel);
  Script_Mame_Install.Main.Cancel.Name := 'Script_Mame_Install_Main_Cancel';
  Script_Mame_Install.Main.Cancel.Parent := Script_Mame_Install.Panel;
  Script_Mame_Install.Main.Cancel.SetBounds(50, Script_Mame_Install.Main.Control.Height - 50, 140, 40);
  Script_Mame_Install.Main.Cancel.Text := 'Cancel';
  Script_Mame_Install.Main.Cancel.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Cancel.Visible := True;

  ShowButtons;
end;

procedure CreateTab1;
begin
  Script_Mame_Install.Main.Tab1.Box := TGroupBox.Create(Script_Mame_Install.Main.Tabs[0]);
  Script_Mame_Install.Main.Tab1.Box.Name := 'Script_Mame_Install_Main_Tab1_Box';
  Script_Mame_Install.Main.Tab1.Box.Parent := Script_Mame_Install.Main.Tabs[0];
  Script_Mame_Install.Main.Tab1.Box.SetBounds(10, 10, Script_Mame_Install.Main.Control.Width - 20, 200);
  Script_Mame_Install.Main.Tab1.Box.Text := 'Information.';
  Script_Mame_Install.Main.Tab1.Box.Visible := True;

  Script_Mame_Install.Main.Tab1.Text := TALText.Create(Script_Mame_Install.Main.Tab1.Box);
  Script_Mame_Install.Main.Tab1.Text.Name := 'Script_Mame_Install_Main_Tab1_Text';
  Script_Mame_Install.Main.Tab1.Text.Parent := Script_Mame_Install.Main.Tab1.Box;
  Script_Mame_Install.Main.Tab1.Text.SetBounds(10, 40, Script_Mame_Install.Main.Tab1.Box.Width - 20, 60);
  Script_Mame_Install.Main.Tab1.Text.WordWrap := True;
  Script_Mame_Install.Main.Tab1.Text.TextIsHtml := True;
  Script_Mame_Install.Main.Tab1.Text.TextSettings.FontColor := TAlphaColorRec.White;
  Script_Mame_Install.Main.Tab1.Text.TextSettings.Font.Size := 14;
  Script_Mame_Install.Main.Tab1.Text.TextSettings.VertAlign := TTextAlign.Leading;
  Script_Mame_Install.Main.Tab1.Text.Text := ' This action will "<font color="#ff63cbfc">install mame</font>" to "<font color="#ff63cbfc">ExtraFE</font>".' +
    #13#10 + ' If you wish to continue press next else press cancel.';
  Script_Mame_Install.Main.Tab1.Text.Visible := True;
end;

procedure CreateTab2;
begin
  Script_Mame_Install.Main.Tab2.Box := TGroupBox.Create(Script_Mame_Install.Main.Tabs[1]);
  Script_Mame_Install.Main.Tab2.Box.Name := 'Script_Mame_Install_Main_Tab2_Box';
  Script_Mame_Install.Main.Tab2.Box.Parent := Script_Mame_Install.Main.Tabs[1];
  Script_Mame_Install.Main.Tab2.Box.SetBounds(10, 10, Script_Mame_Install.Main.Control.Width - 20, 200);
  Script_Mame_Install.Main.Tab2.Box.Text := 'Install options.';
  Script_Mame_Install.Main.Tab2.Box.Visible := True;

  Script_Mame_Install.Main.Tab2.Radio_1 := TRadioButton.Create(Script_Mame_Install.Main.Tab2.Box);
  Script_Mame_Install.Main.Tab2.Radio_1.Name := 'Script_Mame_Install_Main_Tab2_Radio_1';
  Script_Mame_Install.Main.Tab2.Radio_1.Parent := Script_Mame_Install.Main.Tab2.Box;
  Script_Mame_Install.Main.Tab2.Radio_1.SetBounds(20, 30, 400, 24);
  Script_Mame_Install.Main.Tab2.Radio_1.Text := 'Install mame to ExtaFE from mame found in my computer';
  Script_Mame_Install.Main.Tab2.Radio_1.OnClick := ex_main.Input.mouse_script_arcade.Radio.OnMouseClick;
  Script_Mame_Install.Main.Tab2.Radio_1.Visible := True;

  Script_Mame_Install.Main.Tab2.Radio_2 := TRadioButton.Create(Script_Mame_Install.Main.Tab2.Box);
  Script_Mame_Install.Main.Tab2.Radio_2.Name := 'Script_Mame_Install_Main_Tab2_Radio_2';
  Script_Mame_Install.Main.Tab2.Radio_2.Parent := Script_Mame_Install.Main.Tab2.Box;
  Script_Mame_Install.Main.Tab2.Radio_2.SetBounds(20, 90, 400, 24);
  Script_Mame_Install.Main.Tab2.Radio_2.Text := 'Install mame to ExtaFE from ExtraFE Server. *';
  Script_Mame_Install.Main.Tab2.Radio_2.OnClick := ex_main.Input.mouse_script_arcade.Radio.OnMouseClick;
  Script_Mame_Install.Main.Tab2.Radio_2.Visible := True;

  Script_Mame_Install.Main.Tab2.Warning := TText.Create(Script_Mame_Install.Main.Tab2.Box);
  Script_Mame_Install.Main.Tab2.Warning.Name := 'Script_Mame_Install_Main_Tab2_Warning';
  Script_Mame_Install.Main.Tab2.Warning.Parent := Script_Mame_Install.Main.Tab2.Box;
  Script_Mame_Install.Main.Tab2.Warning.SetBounds(20, 120, 300, 24);
  Script_Mame_Install.Main.Tab2.Warning.Text := 'You must select at least one option';
  Script_Mame_Install.Main.Tab2.Warning.TextSettings.FontColor := TAlphaColorRec.Red;
  Script_Mame_Install.Main.Tab2.Warning.TextSettings.Font.Style := Script_Mame_Install.Main.Tab2.Warning.TextSettings.Font.Style + [TFontStyle.fsBold];
  Script_Mame_Install.Main.Tab2.Warning.Visible := false;

  Script_Mame_Install.Main.Tab2.Text := TLabel.Create(Script_Mame_Install.Main.Tab2.Box);
  Script_Mame_Install.Main.Tab2.Text.Name := 'Script_Mame_Install_Main_Tab2_Label';
  Script_Mame_Install.Main.Tab2.Text.Parent := Script_Mame_Install.Main.Tab2.Box;
  Script_Mame_Install.Main.Tab2.Text.SetBounds((Script_Mame_Install.Main.Tab2.Box.Width - 10) - 200, Script_Mame_Install.Main.Tab2.Box.Height - 30, 300, 24);
  Script_Mame_Install.Main.Tab2.Text.Text := '* Must have active internet connection';
  Script_Mame_Install.Main.Tab2.Text.TextSettings.VertAlign := TTextAlign.Trailing;
  Script_Mame_Install.Main.Tab2.Text.TextSettings.Font.Style := Script_Mame_Install.Main.Tab2.Text.TextSettings.Font.Style + [TFontStyle.fsBold];
  Script_Mame_Install.Main.Tab2.Text.Visible := True;

end;

procedure CreateTab3_Computer;
begin
  Script_Mame_Install.Main.Tab3.Box := TGroupBox.Create(Script_Mame_Install.Main.Tabs[2]);
  Script_Mame_Install.Main.Tab3.Box.Name := 'Script_Mame_Install_Main_Tab3_Box';
  Script_Mame_Install.Main.Tab3.Box.Parent := Script_Mame_Install.Main.Tabs[2];
  Script_Mame_Install.Main.Tab3.Box.SetBounds(10, 10, Script_Mame_Install.Main.Control.Width - 20, 200);
  Script_Mame_Install.Main.Tab3.Box.Text := 'Install mame from computer.';
  Script_Mame_Install.Main.Tab3.Box.Visible := True;

  Script_Mame_Install.Main.Tab3.Edit_Info := TLabel.Create(Script_Mame_Install.Main.Tab3.Box);
  Script_Mame_Install.Main.Tab3.Edit_Info.Name := 'Script_Mame_Install_Main_Tab3_EditLabel';
  Script_Mame_Install.Main.Tab3.Edit_Info.Parent := Script_Mame_Install.Main.Tab3.Box;
  Script_Mame_Install.Main.Tab3.Edit_Info.SetBounds(20, 40, 300, 24);
  Script_Mame_Install.Main.Tab3.Edit_Info.Text := 'Find the executable file of mame emulator.';
  Script_Mame_Install.Main.Tab3.Edit_Info.TextSettings.Font.Style := Script_Mame_Install.Main.Tab3.Edit_Info.TextSettings.Font.Style + [TFontStyle.fsBold];
  Script_Mame_Install.Main.Tab3.Edit_Info.Visible := True;

  Script_Mame_Install.Main.Tab3.Open_Dialog := TOpenDialog.Create(Script_Mame_Install.Main.Tab3.Box);
  Script_Mame_Install.Main.Tab3.Open_Dialog.Name := 'Script_Mame_Install_Main_Tab3_OpenDialog';
  Script_Mame_Install.Main.Tab3.Open_Dialog.Parent := Script_Mame_Install.Main.Tab3.Box;
  Script_Mame_Install.Main.Tab3.Open_Dialog.FileName := '';
  Script_Mame_Install.Main.Tab3.Open_Dialog.Filter := 'Mame64|mame64.exe|Mame32|mame.exe|Mame64, Mame32|mame64.exe; mame.exe';
  Script_Mame_Install.Main.Tab3.Open_Dialog.OnClose := Script_Mame_Install.Main.Tab3.Dialog.OnClose;

  Script_Mame_Install.Main.Tab3.Edit := TEdit.Create(Script_Mame_Install.Main.Tab3.Box);
  Script_Mame_Install.Main.Tab3.Edit.Name := 'Script_Mame_Install_Main_Tab3_Edit';
  Script_Mame_Install.Main.Tab3.Edit.Parent := Script_Mame_Install.Main.Tab3.Box;
  Script_Mame_Install.Main.Tab3.Edit.SetBounds(20, 60, Script_Mame_Install.Main.Tab3.Box.Width - 80, 26);
  Script_Mame_Install.Main.Tab3.Edit.Text := '';
  Script_Mame_Install.Main.Tab3.Edit.ReadOnly := True;
  Script_Mame_Install.Main.Tab3.Edit.Caret.Color := TAlphaColorRec.DeepSkyBlue;
  Script_Mame_Install.Main.Tab3.Edit.Visible := True;

  Script_Mame_Install.Main.Tab3.Find := TButton.Create(Script_Mame_Install.Main.Tabs[2]);
  Script_Mame_Install.Main.Tab3.Find.Name := 'Script_Mame_Install_Main_Tab3_Find';
  Script_Mame_Install.Main.Tab3.Find.Parent := Script_Mame_Install.Main.Tabs[2];
  Script_Mame_Install.Main.Tab3.Find.SetBounds(Script_Mame_Install.Main.Tab3.Box.Width - 48, 70, 50, 26);
  Script_Mame_Install.Main.Tab3.Find.Text := 'Find';
  Script_Mame_Install.Main.Tab3.Find.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Tab3.Find.Visible := True;

  Script_Mame_Install.Main.Tab3.Progress := TProgressBar.Create(Script_Mame_Install.Main.Tab3.Box);
  Script_Mame_Install.Main.Tab3.Progress.Name := 'Script_Mame_Install_Main_Tab3_Progress';
  Script_Mame_Install.Main.Tab3.Progress.Parent := Script_Mame_Install.Main.Tab3.Box;
  Script_Mame_Install.Main.Tab3.Progress.SetBounds(20, 60, Script_Mame_Install.Main.Tab3.Box.Width - 40, 26);
  Script_Mame_Install.Main.Tab3.Progress.Min := 0;
  Script_Mame_Install.Main.Tab3.Progress.Max := 100;
  Script_Mame_Install.Main.Tab3.Progress.Value := 0;
  Script_Mame_Install.Main.Tab3.Progress.Visible := false;

  Script_Mame_Install.Main.Tab3.Start := TButton.Create(Script_Mame_Install.Main.Tabs[2]);
  Script_Mame_Install.Main.Tab3.Start.Name := 'Script_Mame_Install_Main_Start_Computer';
  Script_Mame_Install.Main.Tab3.Start.Parent := Script_Mame_Install.Main.Tabs[2];
  Script_Mame_Install.Main.Tab3.Start.SetBounds(30, 120, 200, 26);
  Script_Mame_Install.Main.Tab3.Start.Text := 'Start the installation.';
  Script_Mame_Install.Main.Tab3.Start.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Tab3.Start.Visible := false;
end;

procedure CreateTab3_Server;
begin
  Script_Mame_Install.Main.Tab3.Box := TGroupBox.Create(Script_Mame_Install.Main.Tabs[2]);
  Script_Mame_Install.Main.Tab3.Box.Name := 'Script_Mame_Install_Main_Tab3_Box';
  Script_Mame_Install.Main.Tab3.Box.Parent := Script_Mame_Install.Main.Tabs[2];
  Script_Mame_Install.Main.Tab3.Box.SetBounds(10, 10, Script_Mame_Install.Main.Control.Width - 20, 200);
  Script_Mame_Install.Main.Tab3.Box.Text := 'Install mame from server.';
  Script_Mame_Install.Main.Tab3.Box.Visible := True;
end;

procedure CreateTab4;
begin
  Script_Mame_Install.Main.Tab4.Box := TGroupBox.Create(Script_Mame_Install.Main.Tabs[3]);
  Script_Mame_Install.Main.Tab4.Box.Name := 'Script_Mame_Install_Main_Tab4_Box';
  Script_Mame_Install.Main.Tab4.Box.Parent := Script_Mame_Install.Main.Tabs[3];
  Script_Mame_Install.Main.Tab4.Box.SetBounds(10, 10, Script_Mame_Install.Main.Control.Width - 20, 200);
  Script_Mame_Install.Main.Tab4.Box.Text := 'Congratulatinos';
  Script_Mame_Install.Main.Tab4.Box.Visible := True;

  Script_Mame_Install.Main.Tab4.Text := TALText.Create(Script_Mame_Install.Main.Tab4.Box);
  Script_Mame_Install.Main.Tab4.Text.Name := 'Script_Mame_Install_Main_Tab4_Text';
  Script_Mame_Install.Main.Tab4.Text.Parent := Script_Mame_Install.Main.Tab4.Box;
  Script_Mame_Install.Main.Tab4.Text.SetBounds(10, 40, Script_Mame_Install.Main.Tab4.Box.Width - 20, 60);
  Script_Mame_Install.Main.Tab4.Text.WordWrap := True;
  Script_Mame_Install.Main.Tab4.Text.TextIsHtml := True;
  Script_Mame_Install.Main.Tab4.Text.TextSettings.FontColor := TAlphaColorRec.White;
  Script_Mame_Install.Main.Tab4.Text.TextSettings.Font.Size := 14;
  Script_Mame_Install.Main.Tab4.Text.TextSettings.VertAlign := TTextAlign.Leading;
  Script_Mame_Install.Main.Tab4.Text.Text := ' Installation of "<font color="#ff63cbfc">mame</font>" is completed.' + #13#10 +
    '   Close and enjoy the thousands retro games of mame.' + #13#10 + '   P.S. You must have the roms to play, ExtraFE provide no roms.';
  Script_Mame_Install.Main.Tab4.Text.Visible := True;

  Script_Mame_Install.Main.Tab4.Success := TButton.Create(Script_Mame_Install.Main.Tab4.Box);
  Script_Mame_Install.Main.Tab4.Success.Name := 'Script_Mame_Install_Main_Final';
  Script_Mame_Install.Main.Tab4.Success.Parent := Script_Mame_Install.Main.Tab4.Box;
  Script_Mame_Install.Main.Tab4.Success.SetBounds((Script_Mame_Install.Main.Tab4.Box.Width / 2) - 70, 140, 140, 30);
  Script_Mame_Install.Main.Tab4.Success.Text := 'Close';
  Script_Mame_Install.Main.Tab4.Success.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Tab4.Success.OnMouseEnter := ex_main.Input.mouse_script_arcade.Button.OnMouseEnter;
  Script_Mame_Install.Main.Tab4.Success.Visible := True;
end;

procedure uEmulation_Arcade_Mame_Install_Free;
begin
  extrafe.prog.State := 'main_config_emulators';
  mainScene.Config.Main.Left_Blur.Enabled := false;
  mainScene.Config.Main.R.Emulators.Panel_Blur.Enabled := false;
  FreeAndNil(Script_Mame_Install.Panel);
  mainScene.Footer.Back_Blur.Enabled := false;
end;

//

procedure uEmulation_Arcade_Mame_Install_Start_FromComputer;
begin
  Script_Mame_Install.Main.Tab3.Edit.Visible := false;
  Script_Mame_Install.Main.Tab3.Progress.Visible := True;
  Script_Mame_Install.Main.Tab3.Start.Visible := false;
  Script_Mame_Install.Main.Tab3.Find.Visible := false;
  Script_Mame_Install.Main.Tab3.Edit_Info.Text := 'Start the installation.';

  uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Name := ExtractFileName(Script_Mame_Install.Main.Tab3.Edit.Text);
  uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Path := ExtractFilePath(Script_Mame_Install.Main.Tab3.Edit.Text);
  uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Ini := uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Path + 'mame.ini';
  uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Version := '';

  uDB_AUser.Local.Emulators.Arcade_D.Mame_D.p_Path := extrafe.prog.Path + 'emu\arcade\mame\';
  uDB_AUser.Local.Emulators.Arcade_D.Mame_D.p_Images := uDB_AUser.Local.Emulators.Arcade_D.Mame_D.p_Path + 'images\';
  uDB_AUser.Local.Emulators.Arcade_D.Mame_D.p_Sounds := uDB_AUser.Local.Emulators.Arcade_D.Mame_D.p_Path + 'sounds\';
  uDB_AUser.Local.Emulators.Arcade_D.Mame_D.p_Views := uDB_AUser.Local.Emulators.Arcade_D.Mame_D.p_Path + 'views\';

  if not FileExists(uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Ini) then
    ShellExecute(0, nil, 'cmd.exe', PChar('/C ' + AnsiQuotedStr(uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Path + uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Name,
      Char(34)) + ' -cc'), PChar(uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Path), SW_HIDE);
  Script_Mame_Install.Main.Tab3.Progress.Value := 20;
  // Application.ProcessMessages;
  Script_Mame_Install.Main.Tab3.Progress.Value := 50;

  // Active the main control tab
  if emulation.Level = 0 then
    emulation.Selection_Tab[0].Logo_Gray.Enabled := false;
  inc(emulation.Category[0].Second_Level, 1);
  Script_Mame_Install.Main.Tab3.Progress.Value := 100;
  Script_Mame_Install.Main.Tab3.Edit_Info.Text := 'Installation complete. Click next to start using it.';

  Update_Database;

  // Clear and create the main control tab
  uMain_Emulation.Clear_Selection_Control;
  uMain_Emulation.Create_Selection_Control;

  uLoad_Emulation.Get_Arcade_Media_Data;
  uEmu_Arcade_Mame_SetAll.Get_Set_Mame_Data;

  uMain_Emulation.Category(0, 0);

  Script_Mame_Install.Main.Control.SetActiveTabWithTransition(Script_Mame_Install.Main.Tabs[3], TTabTransition.Slide);
  Script_Mame_Install.Main.Status := 'phase_4';

  ShowButtons;
end;

procedure Update_Database;
begin
  uDB_AUser.Local.Emulators.Arcade := True;
  uDB_AUser.Local.Emulators.Arcade_D.mame := True;
  inc(uDB_AUser.Local.Emulators.Count, 1);
  inc(uDB_AUser.Local.Emulators.Arcade_D.Count, 1);

  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Emulators', 'ARCADE', 'True', 'User_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Emulators', 'Count', uDB_AUser.Local.Emulators.Count.ToString, 'User_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Arcade', 'Mame', 'True', 'User_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Arcade', 'Count', uDB_AUser.Local.Emulators.Arcade_D.Count.ToString, 'User_ID', uDB_AUser.Local.USER.Num.ToString);

  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Arcade_Mame', 'ExtraFE_Mame_Path', uDB_AUser.Local.Emulators.Arcade_D.Mame_D.p_Path, 'User_ID',
    uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Arcade_Mame', 'ExtraFE_Mame_Images', uDB_AUser.Local.Emulators.Arcade_D.Mame_D.p_Images, 'User_ID',
    uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Arcade_Mame', 'ExtraFE_Mame_Sounds', uDB_AUser.Local.Emulators.Arcade_D.Mame_D.p_Sounds, 'User_ID',
    uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Arcade_Mame', 'ExtraFE_Mame_Views', uDB_AUser.Local.Emulators.Arcade_D.Mame_D.p_Views, 'User_ID',
    uDB_AUser.Local.USER.Num.ToString);

  uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Installed := True;
  uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Active := True;
  uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Position := 0;
  uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Unique := 0;

  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Arcade_Mame', 'Installed', 'True', 'User_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Arcade_Mame', 'Emu_Active', 'TRUE', 'User_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Arcade_Mame', 'Emu_Position', uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Position.ToString, 'User_ID',
    uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Arcade_Mame', 'Emu_Unique', '0.0', 'User_ID', uDB_AUser.Local.USER.Num.ToString);

  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Arcade_Mame', 'Mame_Name', uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Name, 'User_ID',
    uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Arcade_Mame', 'Mame_Path', uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Path, 'User_ID',
    uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Arcade_Mame', 'Mame_Ini', uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Ini, 'User_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'Arcade_Mame', 'Mame_Version', uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Version, 'User_ID',
    uDB_AUser.Local.USER.Num.ToString);

  if Query_Check_If_Column_Exists(uDB.Arcade_Query, 'mame_status', 'fav_id_' + uDB_AUser.Local.USER.Num.ToString) then
  begin
    { Create message procedure to user select option from new fav or existence one }
  end
  else
    uDB.Query_Create_New_Column(uDB.Arcade_Query, 'mame_status', 'fav_id_' + uDB_AUser.Local.USER.Num.ToString + ' BOOLEAN DEFAULT False');

  if Query_Check_If_Column_Exists(uDB.Arcade_Query, 'mame_status', 'play_count_id_' + uDB_AUser.Local.USER.Num.ToString) then
  begin
    { Create message procedure to user select option from new playcount or existence one }
  end
  else
    uDB.Query_Create_New_Column(uDB.Arcade_Query, 'mame_status', 'play_count_id_' + uDB_AUser.Local.USER.Num.ToString + ' INTEGER DEFAULT 0');

  if Query_Check_If_Column_Exists(uDB.Arcade_Query, 'games', 'hidden_id_' + uDB_AUser.Local.USER.Num.ToString) then
  begin
    { Create message procedure to user select option from new hidden games  or existence one }
  end
  else
    uDB.Query_Create_New_Column(uDB.Arcade_Query, 'games', 'hidden_id_' + uDB_AUser.Local.USER.Num.ToString + ' BOOLEAN DEFAULT False');

end;

procedure uEmulation_Arcade_Mame_Install_Final;
begin
  FreeAndNil(mainScene.Config.Main.R.Emulators.Arcade[0].Panel);
  uMain_Config_Emulators.CreateArcadePanel(0);

  uEmulation_Arcade_Mame_Install_Free;
end;

procedure uEmulation_Arcade_Mame_Install_Slide_To_Next;
begin
  if Script_Mame_Install.Main.Status = 'phase_1' then
  begin
    Script_Mame_Install.Main.Control.SetActiveTabWithTransition(Script_Mame_Install.Main.Tabs[1], TTabTransition.Slide);
    Script_Mame_Install.Main.Status := 'phase_2';
  end
  else if Script_Mame_Install.Main.Status = 'phase_2' then
  begin
    if Script_Mame_Install.Main.Tab2.Radio_1.IsChecked then
      CreateTab3_Computer
    else if Script_Mame_Install.Main.Tab2.Radio_1.IsChecked then
      CreateTab3_Server
    else
      Script_Mame_Install.Main.Tab2.Warning.Visible := True;

    if (Script_Mame_Install.Main.Tab2.Radio_1.IsChecked) or (Script_Mame_Install.Main.Tab2.Radio_2.IsChecked) then
    begin
      Script_Mame_Install.Main.Control.SetActiveTabWithTransition(Script_Mame_Install.Main.Tabs[2], TTabTransition.Slide);
      Script_Mame_Install.Main.Status := 'phase_3';
    end;
  end;
  ShowButtons;
end;

procedure uEmulation_Arcade_Mame_Install_Slide_To_Previous;
begin
  if Script_Mame_Install.Main.Status = 'phase_3' then
  begin
    Script_Mame_Install.Main.Control.SetActiveTabWithTransition(Script_Mame_Install.Main.Tabs[1], TTabTransition.Slide, TTabTransitionDirection.Reversed);
    Script_Mame_Install.Main.Status := 'phase_2';
  end
  else if Script_Mame_Install.Main.Status = 'phase_2' then
  begin
    Script_Mame_Install.Main.Control.SetActiveTabWithTransition(Script_Mame_Install.Main.Tabs[0], TTabTransition.Slide, TTabTransitionDirection.Reversed);
    Script_Mame_Install.Main.Status := 'phase_1';
  end;
  ShowButtons;
end;

procedure ShowButtons;
begin
  if Script_Mame_Install.Main.Status = 'phase_1' then
  begin
    Script_Mame_Install.Main.Cancel.Visible := True;
    Script_Mame_Install.Main.Back.Visible := false;
    Script_Mame_Install.Main.Next.Visible := True;
  end
  else if Script_Mame_Install.Main.Status = 'phase_2' then
  begin
    Script_Mame_Install.Main.Cancel.Visible := True;
    Script_Mame_Install.Main.Back.Visible := True;
    Script_Mame_Install.Main.Next.Visible := True;
  end
  else if Script_Mame_Install.Main.Status = 'phase_3' then
  begin
    Script_Mame_Install.Main.Cancel.Visible := True;
    Script_Mame_Install.Main.Back.Visible := True;
    Script_Mame_Install.Main.Next.Visible := false;
  end
  else if Script_Mame_Install.Main.Status = 'phase_4' then
  begin
    Script_Mame_Install.Main.Cancel.Visible := false;
    Script_Mame_Install.Main.Back.Visible := false;
    Script_Mame_Install.Main.Next.Visible := false;
  end

end;

{ TMAIN_MAME_INSTALL_OPENDIALOG }

procedure TMAIN_MAME_INSTALL_OPENDIALOG.OnClose(Sender: TObject);
begin
  if Script_Mame_Install.Main.Tab3.Open_Dialog.FileName <> '' then
  begin
    Script_Mame_Install.Main.Tab3.Edit.Text := Script_Mame_Install.Main.Tab3.Open_Dialog.FileName;
    Script_Mame_Install.Main.Tab3.Start.Visible := True;
  end;
end;

initialization

Script_Mame_Install.Main.Tab3.Dialog := TMAIN_MAME_INSTALL_OPENDIALOG.Create;

finalization

Script_Mame_Install.Main.Tab3.Dialog.Free;

end.

// must have for example

{ // Create the big xml game file
  Script_Mame_Install.Main.Tab3.Edit_Info.Text := 'Generate the xml file. This will take some time please wait';
  // Application.ProcessMessages;
  ShellExecute(0, nil, 'cmd.exe', PChar('/C ' + AnsiQuotedStr(uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Path +
  uDB_AUser.Local.Emulators.Arcade_D.Mame_D.Name, Char(34)) + ' -listxml > ' + uDB_AUser.Local.Emulators.Arcade_D.Mame_D.p_Database + 'gameslist.xml'),
  nil, SW_HIDE); }
