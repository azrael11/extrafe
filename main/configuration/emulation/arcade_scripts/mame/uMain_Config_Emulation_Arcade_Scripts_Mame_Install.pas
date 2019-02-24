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
    Cancel: TButton;
    Next: TButton;
  end;

type
  TMAIN_MAME_INSTALL_TAB2 = record
    Box: TGroupBox;
    Radio_1: TRadioButton;
    Radio_2: TRadioButton;
    Text: TLabel;
    Cancel: TButton;
    Back: TButton;
    Next: TButton;
  end;

type
  TMAIN_MAME_INSTALL_TAB3 = record
    Box: TGroupBox; // Both
    Edit_Info: TLabel; // Computer
    Edit: TEdit; // Computer
    Find: TButton; // Computer
    Server_Info: array [0 .. 4] of TLabel; // Server
    Start: TButton; // Server
    Progress: TProgressBar; // Both
    Cancel: TButton; // Both
    Back: TButton; // Both
    Next: TButton; // Both
    Open_Dialog: TOpenDialog;
    Dialog: TMAIN_MAME_INSTALL_OPENDIALOG;
  end;

type
  TMAIN_MAME_INSTALL_TAB4 = record
    Box: TGroupBox;
    Text: TALText;
    Close: TButton;
  end;

type
  TEMU_MAME_INSTALL_HEADER = record
    Panel: TPanel;
    Icon: TImage;
    Text: TLabel;
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
  end;

type
  TEMU_MAME_INSTALL = record
    Panel: TPanel;
    Header: TEMU_MAME_INSTALL_HEADER;
    Main: TEMU_MAME_INSTALL_MAIN;
  end;

var
  Script_Mame_Install: TEMU_MAME_INSTALL;

procedure uEmulation_Arcade_Mame_Install;
procedure uEmulation_Arcade_Mame_Install_Free;

procedure uEmulation_Arcade_Mame_Install_CreateTab1;
procedure uEmulation_Arcade_Mame_Install_CreateTab2;
procedure uEmulation_Arcade_Mame_Install_CreateTab3_Computer;
procedure uEmulation_Arcade_Mame_Install_CreateTab3_Server;
procedure uEmulation_Arcade_Mame_Install_CreateTab4;

procedure uEmulation_Arcade_Mame_Install_ChooseInstallationType_ShowTab3;

procedure uEmulation_Arcade_Mame_Install_Start_FromComputer;

procedure uEmulation_Arcade_Mame_Install_IniValues;

implementation

uses
  uLoad_AllTypes,
  uLoad_Emulation,
  Main,
  uMain_AllTypes,
  uMain_Emulation,
  uMain_Config_Emulators,
  uEmu_Arcade_Mame_AllTypes;

procedure uEmulation_Arcade_Mame_Install;
var
  vi: Integer;
begin
  extrafe.prog.State := 'main_config_uninstall';

  mainScene.Config.Main.Left_Blur.Enabled := True;
  mainScene.Config.Main.R.Emulators.Panel_Blur.Enabled := True;

  Script_Mame_Install.Panel := TPanel.Create(Main_Form);
  Script_Mame_Install.Panel.Name := 'Script_Mame_Install';
  Script_Mame_Install.Panel.Parent := Main_Form;
  Script_Mame_Install.Panel.Width := 600;
  Script_Mame_Install.Panel.Height := 350;
  Script_Mame_Install.Panel.Position.X := extrafe.res.Half_Width - 300;
  Script_Mame_Install.Panel.Position.Y := extrafe.res.Half_Height - 175;
  Script_Mame_Install.Panel.Visible := True;

  Script_Mame_Install.Header.Panel := TPanel.Create(Script_Mame_Install.Panel);
  Script_Mame_Install.Header.Panel.Name := 'Script_Mame_Install_Header';
  Script_Mame_Install.Header.Panel.Parent := Script_Mame_Install.Panel;
  Script_Mame_Install.Header.Panel.Width := Script_Mame_Install.Panel.Width;
  Script_Mame_Install.Header.Panel.Height := 30;
  Script_Mame_Install.Header.Panel.Position.X := 0;
  Script_Mame_Install.Header.Panel.Position.Y := 0;
  Script_Mame_Install.Header.Panel.Visible := True;

  Script_Mame_Install.Header.Icon := TImage.Create(Script_Mame_Install.Header.Panel);
  Script_Mame_Install.Header.Icon.Name := 'Script_Mame_Install_Header_Icon';
  Script_Mame_Install.Header.Icon.Parent := Script_Mame_Install.Header.Panel;
  Script_Mame_Install.Header.Icon.Width := 24;
  Script_Mame_Install.Header.Icon.Height := 24;
  Script_Mame_Install.Header.Icon.Position.X := 6;
  Script_Mame_Install.Header.Icon.Position.Y := 3;
  Script_Mame_Install.Header.Icon.Bitmap.LoadFromFile(ex_main.Paths.Config_Images + 'emu\arcade\mame.png');
  Script_Mame_Install.Header.Icon.WrapMode := TImageWrapMode.Fit;
  Script_Mame_Install.Header.Icon.Visible := True;

  Script_Mame_Install.Header.Text := TLabel.Create(Script_Mame_Install.Header.Panel);
  Script_Mame_Install.Header.Text.Name := 'Script_Mame_Install_Header_Text';
  Script_Mame_Install.Header.Text.Parent := Script_Mame_Install.Header.Panel;
  Script_Mame_Install.Header.Text.Width := 300;
  Script_Mame_Install.Header.Text.Height := 24;
  Script_Mame_Install.Header.Text.Position.X := 36;
  Script_Mame_Install.Header.Text.Position.Y := 3;
  Script_Mame_Install.Header.Text.Text := 'Install Mame to ExtraFE.';
  Script_Mame_Install.Header.Text.TextSettings.Font.Style :=
    Script_Mame_Install.Header.Text.TextSettings.Font.Style + [TFontStyle.fsBold];
  Script_Mame_Install.Header.Text.Visible := True;

  Script_Mame_Install.Main.Panel := TPanel.Create(Script_Mame_Install.Panel);
  Script_Mame_Install.Main.Panel.Name := 'Script_Mame_Install_Main';
  Script_Mame_Install.Main.Panel.Parent := Script_Mame_Install.Panel;
  Script_Mame_Install.Main.Panel.Width := Script_Mame_Install.Panel.Width;
  Script_Mame_Install.Main.Panel.Height := Script_Mame_Install.Panel.Height - 30;
  Script_Mame_Install.Main.Panel.Position.X := 0;
  Script_Mame_Install.Main.Panel.Position.Y := 30;
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
    Script_Mame_Install.Main.Tabs[vi].Width := Script_Mame_Install.Main.Control.Width;
    Script_Mame_Install.Main.Tabs[vi].Height := Script_Mame_Install.Main.Control.Height;
    Script_Mame_Install.Main.Tabs[vi].Visible := True;
  end;

  uEmulation_Arcade_Mame_Install_CreateTab1;
  uEmulation_Arcade_Mame_Install_CreateTab2;
  uEmulation_Arcade_Mame_Install_CreateTab4;
end;

procedure uEmulation_Arcade_Mame_Install_CreateTab1;
begin
  Script_Mame_Install.Main.Tab1.Box := TGroupBox.Create(Script_Mame_Install.Main.Tabs[0]);
  Script_Mame_Install.Main.Tab1.Box.Name := 'Script_Mame_Install_Main_Tab1_Box';
  Script_Mame_Install.Main.Tab1.Box.Parent := Script_Mame_Install.Main.Tabs[0];
  Script_Mame_Install.Main.Tab1.Box.Width := Script_Mame_Install.Main.Control.Width - 20;
  Script_Mame_Install.Main.Tab1.Box.Height := 200;
  Script_Mame_Install.Main.Tab1.Box.Position.X := 10;
  Script_Mame_Install.Main.Tab1.Box.Position.Y := 10;
  Script_Mame_Install.Main.Tab1.Box.Text := 'Information.';
  Script_Mame_Install.Main.Tab1.Box.Visible := True;

  Script_Mame_Install.Main.Tab1.Text := TALText.Create(Script_Mame_Install.Main.Tab1.Box);
  Script_Mame_Install.Main.Tab1.Text.Name := 'Script_Mame_Install_Main_Tab1_Text';
  Script_Mame_Install.Main.Tab1.Text.Parent := Script_Mame_Install.Main.Tab1.Box;
  Script_Mame_Install.Main.Tab1.Text.Width := Script_Mame_Install.Main.Tab1.Box.Width - 20;
  Script_Mame_Install.Main.Tab1.Text.Height := 60;
  Script_Mame_Install.Main.Tab1.Text.Position.X := 10;
  Script_Mame_Install.Main.Tab1.Text.Position.Y := 40;
  Script_Mame_Install.Main.Tab1.Text.WordWrap := True;
  Script_Mame_Install.Main.Tab1.Text.TextIsHtml := True;
  Script_Mame_Install.Main.Tab1.Text.TextSettings.FontColor := TAlphaColorRec.White;
  Script_Mame_Install.Main.Tab1.Text.TextSettings.Font.Size := 14;
  Script_Mame_Install.Main.Tab1.Text.TextSettings.VertAlign := TTextAlign.Leading;
  Script_Mame_Install.Main.Tab1.Text.Text :=
    ' This action will "<font color="#ff63cbfc">install mame</font>" to "<font color="#ff63cbfc">ExtraFE</font>".'
    + #13#10 + ' If you wish to continue press next else press cancel.';
  Script_Mame_Install.Main.Tab1.Text.Visible := True;

  Script_Mame_Install.Main.Tab1.Next := TButton.Create(Script_Mame_Install.Main.Tabs[0]);
  Script_Mame_Install.Main.Tab1.Next.Name := 'Script_Mame_Install_Main_Tab1_Next';
  Script_Mame_Install.Main.Tab1.Next.Parent := Script_Mame_Install.Main.Tabs[0];
  Script_Mame_Install.Main.Tab1.Next.Width := 140;
  Script_Mame_Install.Main.Tab1.Next.Height := 40;
  Script_Mame_Install.Main.Tab1.Next.Position.X := Script_Mame_Install.Main.Control.Width - 190;
  Script_Mame_Install.Main.Tab1.Next.Position.Y := Script_Mame_Install.Main.Control.Height - 50;
  Script_Mame_Install.Main.Tab1.Next.Text := 'Next';
  Script_Mame_Install.Main.Tab1.Next.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Tab1.Next.Visible := True;

  Script_Mame_Install.Main.Tab1.Cancel := TButton.Create(Script_Mame_Install.Main.Tabs[0]);
  Script_Mame_Install.Main.Tab1.Cancel.Name := 'Script_Mame_Install_Main_Tab1_Cancel';
  Script_Mame_Install.Main.Tab1.Cancel.Parent := Script_Mame_Install.Main.Tabs[0];
  Script_Mame_Install.Main.Tab1.Cancel.Width := 140;
  Script_Mame_Install.Main.Tab1.Cancel.Height := 40;
  Script_Mame_Install.Main.Tab1.Cancel.Position.X := 50;
  Script_Mame_Install.Main.Tab1.Cancel.Position.Y := Script_Mame_Install.Main.Control.Height - 50;
  Script_Mame_Install.Main.Tab1.Cancel.Text := 'Cancel';
  Script_Mame_Install.Main.Tab1.Cancel.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Tab1.Cancel.Visible := True;
end;

procedure uEmulation_Arcade_Mame_Install_CreateTab2;
begin
  Script_Mame_Install.Main.Tab2.Box := TGroupBox.Create(Script_Mame_Install.Main.Tabs[1]);
  Script_Mame_Install.Main.Tab2.Box.Name := 'Script_Mame_Install_Main_Tab2_Box';
  Script_Mame_Install.Main.Tab2.Box.Parent := Script_Mame_Install.Main.Tabs[1];
  Script_Mame_Install.Main.Tab2.Box.Width := Script_Mame_Install.Main.Control.Width - 20;
  Script_Mame_Install.Main.Tab2.Box.Height := 200;
  Script_Mame_Install.Main.Tab2.Box.Position.X := 10;
  Script_Mame_Install.Main.Tab2.Box.Position.Y := 10;
  Script_Mame_Install.Main.Tab2.Box.Text := 'Install options.';
  Script_Mame_Install.Main.Tab2.Box.Visible := True;

  Script_Mame_Install.Main.Tab2.Radio_1 := TRadioButton.Create(Script_Mame_Install.Main.Tab2.Box);
  Script_Mame_Install.Main.Tab2.Radio_1.Name := 'Script_Mame_Install_Main_Tab2_Radio_1';
  Script_Mame_Install.Main.Tab2.Radio_1.Parent := Script_Mame_Install.Main.Tab2.Box;
  Script_Mame_Install.Main.Tab2.Radio_1.Width := 400;
  Script_Mame_Install.Main.Tab2.Radio_1.Height := 24;
  Script_Mame_Install.Main.Tab2.Radio_1.Position.X := 20;
  Script_Mame_Install.Main.Tab2.Radio_1.Position.Y := 30;
  Script_Mame_Install.Main.Tab2.Radio_1.Text := 'Install mame to ExtaFE from mame found in my computer';
  Script_Mame_Install.Main.Tab2.Radio_1.OnClick := ex_main.Input.mouse_script_arcade.Radio.OnMouseClick;
  Script_Mame_Install.Main.Tab2.Radio_1.Visible := True;

  Script_Mame_Install.Main.Tab2.Radio_2 := TRadioButton.Create(Script_Mame_Install.Main.Tab2.Box);
  Script_Mame_Install.Main.Tab2.Radio_2.Name := 'Script_Mame_Install_Main_Tab2_Radio_2';
  Script_Mame_Install.Main.Tab2.Radio_2.Parent := Script_Mame_Install.Main.Tab2.Box;
  Script_Mame_Install.Main.Tab2.Radio_2.Width := 400;
  Script_Mame_Install.Main.Tab2.Radio_2.Height := 24;
  Script_Mame_Install.Main.Tab2.Radio_2.Position.X := 20;
  Script_Mame_Install.Main.Tab2.Radio_2.Position.Y := 90;
  Script_Mame_Install.Main.Tab2.Radio_2.Text := 'Install mame to ExtaFE from ExtraFE Server.';
  Script_Mame_Install.Main.Tab2.Radio_2.OnClick := ex_main.Input.mouse_script_arcade.Radio.OnMouseClick;
  Script_Mame_Install.Main.Tab2.Radio_2.Visible := True;

  Script_Mame_Install.Main.Tab2.Text := TLabel.Create(Script_Mame_Install.Main.Tab2.Box);
  Script_Mame_Install.Main.Tab2.Text.Name := 'Script_Mame_Install_Main_Tab2_Label';
  Script_Mame_Install.Main.Tab2.Text.Parent := Script_Mame_Install.Main.Tab2.Box;
  Script_Mame_Install.Main.Tab2.Text.Width := 300;
  Script_Mame_Install.Main.Tab2.Text.Height := 24;
  Script_Mame_Install.Main.Tab2.Text.Position.X := (Script_Mame_Install.Main.Tab2.Box.Width - 10) - 200;
  Script_Mame_Install.Main.Tab2.Text.Position.Y := Script_Mame_Install.Main.Tab2.Box.Height - 30;
  Script_Mame_Install.Main.Tab2.Text.Text := '* Must have active internet connection';
  Script_Mame_Install.Main.Tab2.Text.TextSettings.VertAlign := TTextAlign.Trailing;
  Script_Mame_Install.Main.Tab2.Text.TextSettings.Font.Style :=
    Script_Mame_Install.Main.Tab2.Text.TextSettings.Font.Style + [TFontStyle.fsBold];
  Script_Mame_Install.Main.Tab2.Text.Visible := True;

  Script_Mame_Install.Main.Tab2.Next := TButton.Create(Script_Mame_Install.Main.Tabs[1]);
  Script_Mame_Install.Main.Tab2.Next.Name := 'Script_Mame_Install_Main_Tab2_Next';
  Script_Mame_Install.Main.Tab2.Next.Parent := Script_Mame_Install.Main.Tabs[1];
  Script_Mame_Install.Main.Tab2.Next.Width := 140;
  Script_Mame_Install.Main.Tab2.Next.Height := 40;
  Script_Mame_Install.Main.Tab2.Next.Position.X := Script_Mame_Install.Main.Control.Width - 190;
  Script_Mame_Install.Main.Tab2.Next.Position.Y := Script_Mame_Install.Main.Control.Height - 50;
  Script_Mame_Install.Main.Tab2.Next.Text := 'Next';
  Script_Mame_Install.Main.Tab2.Next.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Tab2.Next.Visible := False;

  Script_Mame_Install.Main.Tab2.Back := TButton.Create(Script_Mame_Install.Main.Tabs[1]);
  Script_Mame_Install.Main.Tab2.Back.Name := 'Script_Mame_Install_Main_Tab2_Back';
  Script_Mame_Install.Main.Tab2.Back.Parent := Script_Mame_Install.Main.Tabs[1];
  Script_Mame_Install.Main.Tab2.Back.Width := 140;
  Script_Mame_Install.Main.Tab2.Back.Height := 40;
  Script_Mame_Install.Main.Tab2.Back.Position.X := (Script_Mame_Install.Main.Control.Width / 2) - 70;
  Script_Mame_Install.Main.Tab2.Back.Position.Y := Script_Mame_Install.Main.Control.Height - 50;
  Script_Mame_Install.Main.Tab2.Back.Text := 'Back';
  Script_Mame_Install.Main.Tab2.Back.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Tab2.Back.Visible := True;

  Script_Mame_Install.Main.Tab2.Cancel := TButton.Create(Script_Mame_Install.Main.Tabs[1]);
  Script_Mame_Install.Main.Tab2.Cancel.Name := 'Script_Mame_Install_Main_Tab2_Cancel';
  Script_Mame_Install.Main.Tab2.Cancel.Parent := Script_Mame_Install.Main.Tabs[1];
  Script_Mame_Install.Main.Tab2.Cancel.Width := 140;
  Script_Mame_Install.Main.Tab2.Cancel.Height := 40;
  Script_Mame_Install.Main.Tab2.Cancel.Position.X := 50;
  Script_Mame_Install.Main.Tab2.Cancel.Position.Y := Script_Mame_Install.Main.Control.Height - 50;
  Script_Mame_Install.Main.Tab2.Cancel.Text := 'Cancel';
  Script_Mame_Install.Main.Tab2.Cancel.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Tab2.Cancel.Visible := True;
end;

procedure uEmulation_Arcade_Mame_Install_CreateTab3_Computer;
begin
  Script_Mame_Install.Main.Tab3.Box := TGroupBox.Create(Script_Mame_Install.Main.Tabs[2]);
  Script_Mame_Install.Main.Tab3.Box.Name := 'Script_Mame_Install_Main_Tab3_Box';
  Script_Mame_Install.Main.Tab3.Box.Parent := Script_Mame_Install.Main.Tabs[2];
  Script_Mame_Install.Main.Tab3.Box.Width := Script_Mame_Install.Main.Control.Width - 20;
  Script_Mame_Install.Main.Tab3.Box.Height := 200;
  Script_Mame_Install.Main.Tab3.Box.Position.X := 10;
  Script_Mame_Install.Main.Tab3.Box.Position.Y := 10;
  Script_Mame_Install.Main.Tab3.Box.Text := 'Install mame from computer.';
  Script_Mame_Install.Main.Tab3.Box.Visible := True;

  Script_Mame_Install.Main.Tab3.Edit_Info := TLabel.Create(Script_Mame_Install.Main.Tab3.Box);
  Script_Mame_Install.Main.Tab3.Edit_Info.Name := 'Script_Mame_Install_Main_Tab3_EditLabel';
  Script_Mame_Install.Main.Tab3.Edit_Info.Parent := Script_Mame_Install.Main.Tab3.Box;
  Script_Mame_Install.Main.Tab3.Edit_Info.Width := 300;
  Script_Mame_Install.Main.Tab3.Edit_Info.Height := 24;
  Script_Mame_Install.Main.Tab3.Edit_Info.Position.X := 20;
  Script_Mame_Install.Main.Tab3.Edit_Info.Position.Y := 40;
  Script_Mame_Install.Main.Tab3.Edit_Info.Text := 'Find the executable file of mame emulator.';
  Script_Mame_Install.Main.Tab3.Edit_Info.TextSettings.Font.Style :=
    Script_Mame_Install.Main.Tab3.Edit_Info.TextSettings.Font.Style + [TFontStyle.fsBold];
  Script_Mame_Install.Main.Tab3.Edit_Info.Visible := True;

  Script_Mame_Install.Main.Tab3.Open_Dialog := TOpenDialog.Create(Script_Mame_Install.Main.Tab3.Box);
  Script_Mame_Install.Main.Tab3.Open_Dialog.Name := 'Script_Mame_Install_Main_Tab3_OpenDialog';
  Script_Mame_Install.Main.Tab3.Open_Dialog.Parent := Script_Mame_Install.Main.Tab3.Box;
  Script_Mame_Install.Main.Tab3.Open_Dialog.FileName := '';
  Script_Mame_Install.Main.Tab3.Open_Dialog.Filter :=
    'Mame64|mame64.exe|Mame32|mame.exe|Mame64, Mame32|mame64.exe; mame.exe';
  Script_Mame_Install.Main.Tab3.Open_Dialog.OnClose := Script_Mame_Install.Main.Tab3.Dialog.OnClose;

  Script_Mame_Install.Main.Tab3.Edit := TEdit.Create(Script_Mame_Install.Main.Tab3.Box);
  Script_Mame_Install.Main.Tab3.Edit.Name := 'Script_Mame_Install_Main_Tab3_Edit';
  Script_Mame_Install.Main.Tab3.Edit.Parent := Script_Mame_Install.Main.Tab3.Box;
  Script_Mame_Install.Main.Tab3.Edit.Width := Script_Mame_Install.Main.Tab3.Box.Width - 80;
  Script_Mame_Install.Main.Tab3.Edit.Height := 26;
  Script_Mame_Install.Main.Tab3.Edit.Position.X := 20;
  Script_Mame_Install.Main.Tab3.Edit.Position.Y := 60;
  Script_Mame_Install.Main.Tab3.Edit.Text := '';
  Script_Mame_Install.Main.Tab3.Edit.ReadOnly := True;
  Script_Mame_Install.Main.Tab3.Edit.Caret.Color := TAlphaColorRec.Deepskyblue;
  Script_Mame_Install.Main.Tab3.Edit.Visible := True;

  Script_Mame_Install.Main.Tab3.Find := TButton.Create(Script_Mame_Install.Main.Tabs[2]);
  Script_Mame_Install.Main.Tab3.Find.Name := 'Script_Mame_Install_Main_Tab3_Find';
  Script_Mame_Install.Main.Tab3.Find.Parent := Script_Mame_Install.Main.Tabs[2];
  Script_Mame_Install.Main.Tab3.Find.Width := 50;
  Script_Mame_Install.Main.Tab3.Find.Height := 26;
  Script_Mame_Install.Main.Tab3.Find.Position.X := Script_Mame_Install.Main.Tab3.Box.Width - 48;
  Script_Mame_Install.Main.Tab3.Find.Position.Y := 70;
  Script_Mame_Install.Main.Tab3.Find.Text := 'Find';
  Script_Mame_Install.Main.Tab3.Find.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Tab3.Find.Visible := True;

  Script_Mame_Install.Main.Tab3.Progress := TProgressBar.Create(Script_Mame_Install.Main.Tab3.Box);
  Script_Mame_Install.Main.Tab3.Progress.Name := 'Script_Mame_Install_Main_Tab3_Progress';
  Script_Mame_Install.Main.Tab3.Progress.Parent := Script_Mame_Install.Main.Tab3.Box;
  Script_Mame_Install.Main.Tab3.Progress.Width := Script_Mame_Install.Main.Tab3.Box.Width - 40;
  Script_Mame_Install.Main.Tab3.Progress.Height := 26;
  Script_Mame_Install.Main.Tab3.Progress.Position.X := 20;
  Script_Mame_Install.Main.Tab3.Progress.Position.Y := 60;
  Script_Mame_Install.Main.Tab3.Progress.Min := 0;
  Script_Mame_Install.Main.Tab3.Progress.Max := 100;
  Script_Mame_Install.Main.Tab3.Progress.Value := 0;
  Script_Mame_Install.Main.Tab3.Progress.Visible := False;

  Script_Mame_Install.Main.Tab3.Start := TButton.Create(Script_Mame_Install.Main.Tabs[2]);
  Script_Mame_Install.Main.Tab3.Start.Name := 'Script_Mame_Install_Main_Tab3_Start';
  Script_Mame_Install.Main.Tab3.Start.Parent := Script_Mame_Install.Main.Tabs[2];
  Script_Mame_Install.Main.Tab3.Start.Width := 200;
  Script_Mame_Install.Main.Tab3.Start.Height := 26;
  Script_Mame_Install.Main.Tab3.Start.Position.X := 30;
  Script_Mame_Install.Main.Tab3.Start.Position.Y := 120;
  Script_Mame_Install.Main.Tab3.Start.Text := 'Start the installation.';
  Script_Mame_Install.Main.Tab3.Start.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Tab3.Start.Visible := False;

  Script_Mame_Install.Main.Tab3.Next := TButton.Create(Script_Mame_Install.Main.Tabs[2]);
  Script_Mame_Install.Main.Tab3.Next.Name := 'Script_Mame_Install_Main_Tab3_Next';
  Script_Mame_Install.Main.Tab3.Next.Parent := Script_Mame_Install.Main.Tabs[2];
  Script_Mame_Install.Main.Tab3.Next.Width := 140;
  Script_Mame_Install.Main.Tab3.Next.Height := 40;
  Script_Mame_Install.Main.Tab3.Next.Position.X := Script_Mame_Install.Main.Control.Width - 190;
  Script_Mame_Install.Main.Tab3.Next.Position.Y := Script_Mame_Install.Main.Control.Height - 50;
  Script_Mame_Install.Main.Tab3.Next.Text := 'Next';
  Script_Mame_Install.Main.Tab3.Next.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Tab3.Next.Visible := False;

  Script_Mame_Install.Main.Tab3.Back := TButton.Create(Script_Mame_Install.Main.Tabs[2]);
  Script_Mame_Install.Main.Tab3.Back.Name := 'Script_Mame_Install_Main_Tab3_Back';
  Script_Mame_Install.Main.Tab3.Back.Parent := Script_Mame_Install.Main.Tabs[2];
  Script_Mame_Install.Main.Tab3.Back.Width := 140;
  Script_Mame_Install.Main.Tab3.Back.Height := 40;
  Script_Mame_Install.Main.Tab3.Back.Position.X := (Script_Mame_Install.Main.Control.Width / 2) - 70;
  Script_Mame_Install.Main.Tab3.Back.Position.Y := Script_Mame_Install.Main.Control.Height - 50;
  Script_Mame_Install.Main.Tab3.Back.Text := 'Back';
  Script_Mame_Install.Main.Tab3.Back.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Tab3.Back.Visible := True;

  Script_Mame_Install.Main.Tab3.Cancel := TButton.Create(Script_Mame_Install.Main.Tabs[2]);
  Script_Mame_Install.Main.Tab3.Cancel.Name := 'Script_Mame_Install_Main_Tab3_Cancel';
  Script_Mame_Install.Main.Tab3.Cancel.Parent := Script_Mame_Install.Main.Tabs[2];
  Script_Mame_Install.Main.Tab3.Cancel.Width := 140;
  Script_Mame_Install.Main.Tab3.Cancel.Height := 40;
  Script_Mame_Install.Main.Tab3.Cancel.Position.X := 50;
  Script_Mame_Install.Main.Tab3.Cancel.Position.Y := Script_Mame_Install.Main.Control.Height - 50;
  Script_Mame_Install.Main.Tab3.Cancel.Text := 'Cancel';
  Script_Mame_Install.Main.Tab3.Cancel.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Tab3.Cancel.Visible := True;
end;

procedure uEmulation_Arcade_Mame_Install_CreateTab3_Server;
begin
  Script_Mame_Install.Main.Tab3.Box := TGroupBox.Create(Script_Mame_Install.Main.Tabs[2]);
  Script_Mame_Install.Main.Tab3.Box.Name := 'Script_Mame_Install_Main_Tab3_Box';
  Script_Mame_Install.Main.Tab3.Box.Parent := Script_Mame_Install.Main.Tabs[2];
  Script_Mame_Install.Main.Tab3.Box.Width := Script_Mame_Install.Main.Control.Width - 20;
  Script_Mame_Install.Main.Tab3.Box.Height := 200;
  Script_Mame_Install.Main.Tab3.Box.Position.X := 10;
  Script_Mame_Install.Main.Tab3.Box.Position.Y := 10;
  Script_Mame_Install.Main.Tab3.Box.Text := 'Install mame from server.';
  Script_Mame_Install.Main.Tab3.Box.Visible := True;

  Script_Mame_Install.Main.Tab3.Next := TButton.Create(Script_Mame_Install.Main.Tabs[2]);
  Script_Mame_Install.Main.Tab3.Next.Name := 'Script_Mame_Install_Main_Tab3_Next';
  Script_Mame_Install.Main.Tab3.Next.Parent := Script_Mame_Install.Main.Tabs[2];
  Script_Mame_Install.Main.Tab3.Next.Width := 140;
  Script_Mame_Install.Main.Tab3.Next.Height := 40;
  Script_Mame_Install.Main.Tab3.Next.Position.X := Script_Mame_Install.Main.Control.Width - 190;
  Script_Mame_Install.Main.Tab3.Next.Position.Y := Script_Mame_Install.Main.Control.Height - 50;
  Script_Mame_Install.Main.Tab3.Next.Text := 'Next';
  Script_Mame_Install.Main.Tab3.Next.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Tab3.Next.Visible := False;

  Script_Mame_Install.Main.Tab3.Back := TButton.Create(Script_Mame_Install.Main.Tabs[2]);
  Script_Mame_Install.Main.Tab3.Back.Name := 'Script_Mame_Install_Main_Tab3_Back';
  Script_Mame_Install.Main.Tab3.Back.Parent := Script_Mame_Install.Main.Tabs[2];
  Script_Mame_Install.Main.Tab3.Back.Width := 140;
  Script_Mame_Install.Main.Tab3.Back.Height := 40;
  Script_Mame_Install.Main.Tab3.Back.Position.X := (Script_Mame_Install.Main.Control.Width / 2) - 70;
  Script_Mame_Install.Main.Tab3.Back.Position.Y := Script_Mame_Install.Main.Control.Height - 50;
  Script_Mame_Install.Main.Tab3.Back.Text := 'Back';
  Script_Mame_Install.Main.Tab3.Back.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Tab3.Back.Visible := True;

  Script_Mame_Install.Main.Tab3.Cancel := TButton.Create(Script_Mame_Install.Main.Tabs[2]);
  Script_Mame_Install.Main.Tab3.Cancel.Name := 'Script_Mame_Install_Main_Tab3_Cancel';
  Script_Mame_Install.Main.Tab3.Cancel.Parent := Script_Mame_Install.Main.Tabs[2];
  Script_Mame_Install.Main.Tab3.Cancel.Width := 140;
  Script_Mame_Install.Main.Tab3.Cancel.Height := 40;
  Script_Mame_Install.Main.Tab3.Cancel.Position.X := 50;
  Script_Mame_Install.Main.Tab3.Cancel.Position.Y := Script_Mame_Install.Main.Control.Height - 50;
  Script_Mame_Install.Main.Tab3.Cancel.Text := 'Cancel';
  Script_Mame_Install.Main.Tab3.Cancel.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Tab3.Cancel.Visible := True;
end;

procedure uEmulation_Arcade_Mame_Install_CreateTab4;
begin
  Script_Mame_Install.Main.Tab4.Box := TGroupBox.Create(Script_Mame_Install.Main.Tabs[3]);
  Script_Mame_Install.Main.Tab4.Box.Name := 'Script_Mame_Install_Main_Tab4_Box';
  Script_Mame_Install.Main.Tab4.Box.Parent := Script_Mame_Install.Main.Tabs[3];
  Script_Mame_Install.Main.Tab4.Box.Width := Script_Mame_Install.Main.Control.Width - 20;
  Script_Mame_Install.Main.Tab4.Box.Height := 200;
  Script_Mame_Install.Main.Tab4.Box.Position.X := 10;
  Script_Mame_Install.Main.Tab4.Box.Position.Y := 10;
  Script_Mame_Install.Main.Tab4.Box.Text := 'Congratulatinos';
  Script_Mame_Install.Main.Tab4.Box.Visible := True;

  Script_Mame_Install.Main.Tab4.Text := TALText.Create(Script_Mame_Install.Main.Tab4.Box);
  Script_Mame_Install.Main.Tab4.Text.Name := 'Script_Mame_Install_Main_Tab4_Text';
  Script_Mame_Install.Main.Tab4.Text.Parent := Script_Mame_Install.Main.Tab4.Box;
  Script_Mame_Install.Main.Tab4.Text.Width := Script_Mame_Install.Main.Tab4.Box.Width - 20;
  Script_Mame_Install.Main.Tab4.Text.Height := 60;
  Script_Mame_Install.Main.Tab4.Text.Position.X := 10;
  Script_Mame_Install.Main.Tab4.Text.Position.Y := 40;
  Script_Mame_Install.Main.Tab4.Text.WordWrap := True;
  Script_Mame_Install.Main.Tab4.Text.TextIsHtml := True;
  Script_Mame_Install.Main.Tab4.Text.TextSettings.FontColor := TAlphaColorRec.White;
  Script_Mame_Install.Main.Tab4.Text.TextSettings.Font.Size := 14;
  Script_Mame_Install.Main.Tab4.Text.TextSettings.VertAlign := TTextAlign.Leading;
  Script_Mame_Install.Main.Tab4.Text.Text :=
    ' Installation of "<font color="#ff63cbfc">mame</font>" is completed.' + #13#10 +
    '   Close and enjoy the thousands retro games of mame.' + #13#10 +
    '   P.S. You must have the roms to play, ExtraFE provide no roms.';
  Script_Mame_Install.Main.Tab4.Text.Visible := True;

  Script_Mame_Install.Main.Tab4.Close := TButton.Create(Script_Mame_Install.Main.Tabs[3]);
  Script_Mame_Install.Main.Tab4.Close.Name := 'Script_Mame_Install_Main_Tab4_Close';
  Script_Mame_Install.Main.Tab4.Close.Parent := Script_Mame_Install.Main.Tabs[3];
  Script_Mame_Install.Main.Tab4.Close.Width := 140;
  Script_Mame_Install.Main.Tab4.Close.Height := 40;
  Script_Mame_Install.Main.Tab4.Close.Position.X := (Script_Mame_Install.Main.Control.Width / 2) - 70;
  Script_Mame_Install.Main.Tab4.Close.Position.Y := Script_Mame_Install.Main.Control.Height - 50;
  Script_Mame_Install.Main.Tab4.Close.Text := 'Close and enjoy';
  Script_Mame_Install.Main.Tab4.Close.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Install.Main.Tab4.Close.Visible := True;
end;

procedure uEmulation_Arcade_Mame_Install_ChooseInstallationType_ShowTab3;
begin
  if Script_Mame_Install.Main.Tab2.Radio_1.IsChecked then
    uEmulation_Arcade_Mame_Install_CreateTab3_Computer
  else
    uEmulation_Arcade_Mame_Install_CreateTab3_Server;

  Script_Mame_Install.Main.Control.SetActiveTabWithTransition(Script_Mame_Install.Main.Tabs[2],
    TTabTransition.Slide);
end;

procedure uEmulation_Arcade_Mame_Install_Free;
begin
  extrafe.prog.State := 'main_config';
  mainScene.Config.Main.Left_Blur.Enabled := False;
  mainScene.Config.Main.R.Emulators.Panel_Blur.Enabled := False;
  FreeAndNil(Script_Mame_Install.Panel);
  mainScene.Footer.Back_Blur.Enabled:= False;
end;

//

procedure uEmulation_Arcade_Mame_Install_Start_FromComputer;
begin
  Script_Mame_Install.Main.Tab3.Edit.Visible := False;
  Script_Mame_Install.Main.Tab3.Progress.Visible := True;
  Script_Mame_Install.Main.Tab3.Back.Enabled := False;
  Script_Mame_Install.Main.Tab3.Cancel.Enabled := False;
  Script_Mame_Install.Main.Tab3.Start.Visible := False;
  Script_Mame_Install.Main.Tab3.Find.Visible := False;
  Script_Mame_Install.Main.Tab3.Edit_Info.Text := 'Start the installation.';

  mame.Emu.Name := ExtractFileName(Script_Mame_Install.Main.Tab3.Edit.Text);
  mame.Emu.Path := ExtractFilePath(Script_Mame_Install.Main.Tab3.Edit.Text);
  // Create mame ini if dont exist
  if not FileExists(mame.Emu.Path + 'mame.ini') then
    ShellExecute(0, nil, 'cmd.exe', PChar('/C ' + AnsiQuotedStr(mame.Emu.Path + mame.Emu.Name, Char(34)) +
      ' -cc'), PChar(mame.Emu.Path), SW_HIDE);
  mame.Emu.Ini_Path := mame.Emu.Path;

  Script_Mame_Install.Main.Tab3.Progress.Value := 20;
//  Application.ProcessMessages;
  if mame.prog.Path = '' then
    uEmulation_Arcade_Mame_Install_IniValues;
  // Take the full list of games
  ShellExecute(0, nil, 'cmd.exe', PChar('/C '+ AnsiQuotedStr(mame.Emu.Path + mame.Emu.Name, Char(34)) + ' -listfull > ' +
    mame.prog.Data_Path + mame.prog.Games_List), nil, SW_HIDE);
  // Take the version of mame
  ShellExecute(0, nil, 'cmd.exe', PChar('/C '+ AnsiQuotedStr(mame.Emu.Path + mame.Emu.Name, Char(34)) + ' -h > ' + mame.prog.Data_Path
    + 'version.txt'), nil, SW_HIDE);

  Script_Mame_Install.Main.Tab3.Progress.Value := 40;
//  Application.ProcessMessages;
  uLoad_Emulation_Collect_Arcade_Mame;
  Script_Mame_Install.Main.Tab3.Progress.Value := 50;

  // Create the big xml game file
  Script_Mame_Install.Main.Tab3.Edit_Info.Text :=
    'Generate the xml file. This will take some time please wait';
//  Application.ProcessMessages;
  ShellExecute(0, nil, 'cmd.exe', PChar('/C '+ AnsiQuotedStr(mame.Emu.Path + mame.Emu.Name, Char(34)) + ' -listxml > ' +
    mame.prog.Data_Path + mame.prog.Games_XML), nil, SW_HIDE);

  // Active the main control tab
  if emulation.Level = 0 then
    emulation.Selection_Tab[0].Logo_Gray.Enabled := False;
  inc(emulation.Category[0].Second_Level, 1);
  Script_Mame_Install.Main.Tab3.Cancel.Visible := False;
  Script_Mame_Install.Main.Tab3.Back.Visible := False;
  Script_Mame_Install.Main.Tab3.Progress.Value := 100;
  Script_Mame_Install.Main.Tab3.Edit_Info.Text := 'Installation complete. Click next to start using it.';

  //Clear and create the main control tab
  uMain_Emulation_Clear_Selection_Control;
  uMain_Emulation_Create_Selection_Control;
  uMain_Emulation_Category(0);

  FreeAndNil(mainScene.Config.main.R.Emulators.Arcade[0].Panel);
  uMain_Config_Emulators_CreateArcadePanel(0);

  Script_Mame_Install.Main.Tab3.Next.Visible := True;
end;

procedure uEmulation_Arcade_Mame_Install_IniValues;
begin
//Mame Defaults
  mame.Prog.Path:= extrafe.prog.Path+ 'emu\arcade\mame\';
  mame.Prog.Ini_Path:= mame.Prog.Path+ 'config\';
  mame.Prog.Ini:= TIniFile.Create(mame.Prog.Ini_Path+ 'prog_mame.ini');

  mame.Prog.Ini.WriteString('PROG', 'Path', mame.Prog.Path);
  mame.Prog.Ini.WriteString('PROG', 'Ini_Name', 'prog_mame.ini');
  mame.Prog.Ini.WriteString('PROG', 'Ini_Path', mame.Prog.Ini_Path);
  mame.Prog.Games_List:= 'gameslist.txt';
  mame.Prog.Ini.WriteString('PROG', 'Games_List', mame.Prog.Games_List);
  mame.Prog.Games_XML:= 'gamesxml.xml';
  mame.Prog.Ini.WriteString('PROG', 'Games_XML', mame.Prog.Games_XML);
  mame.Prog.Images:= mame.Prog.Path+ 'images\';
  mame.Prog.Ini.WriteString('PROG', 'Images', mame.Prog.Images);
  mame.Prog.Sounds:= mame.Prog.Path+ 'sounds\';
  mame.Prog.Ini.WriteString('PROG', 'Sounds', mame.Prog.Sounds);
  mame.Prog.Data_Path:= mame.Prog.Path+ 'database\';
  mame.Prog.Ini.WriteString('PROG', 'Data_Path', mame.Prog.Data_Path);

  mame.prog.Ini.WriteString('MAME', 'mame_path', mame.Emu.Path);
  mame.prog.Ini.WriteString('MAME', 'mame_name', mame.Emu.Exe);
  mame.prog.Ini.WriteString('MAME', 'mame_ini_path', mame.Emu.Ini_Path);
  mame.prog.Ini.WriteString('MAME', 'mame_version', '');

  inc(emulation.Unique_Num, 1);
  inc(emulation.Active_Num, 1);
  extrafe.ini.Ini.WriteString('Emulation', 'Emu_Name', emulation.Arcade[0].Name);
  extrafe.Ini.Ini.WriteInteger('Emulation', 'Unique_Num', emulation.Unique_Num);
  extrafe.Ini.Ini.WriteInteger('Emulation', 'Active_Num', emulation.Active_Num);
  mame.prog.Ini.WriteBool('Emulation', 'Active', True);
  mame.prog.Ini.WriteInteger('Emulation', 'Place_Num', 0);
  mame.prog.Ini.WriteString('Emulation', 'TabPath', emulation.Category[0].Menu_Image_Path + 'mame\');
  mame.prog.Ini.WriteString('Emulation', 'Images', 'mame.png');
  mame.prog.Ini.WriteString('Emulation', 'Emu_Name', 'mame');
  mame.prog.Ini.WriteInteger('Emulation', 'Unique_Num', emulation.Unique_Num);
  mame.prog.Ini.WriteBool('Emulation', 'Installed', True);

  mame.Prog.Ini_Filters:= TIniFile.Create(mame.Prog.Data_Path+ 'gamelist_filters.ini');
  mame.Prog.Ini_Filters.WriteString('MASTER', 'Selected', 'All_Unfiltered');
  mame.Prog.Ini_Filters.WriteString('ALL_UNFILTERED', 'MameVer', '');
  mame.Prog.Ini_Filters.WriteString('AVAILABLE', 'MameVer', '');
  mame.Prog.Ini_Filters.WriteString('UNAVAILABLE', 'MameVer', '');
  mame.Prog.Ini_Filters.WriteString('WORKING_ARCADE', 'MameVer', '');
  mame.Prog.Ini_Filters.WriteString('NOT_WORKING_ARCADE', 'MameVer', '');
  mame.Prog.Ini_Filters.WriteString('MECHANICAL_ARCADE', 'MameVer', '');
  mame.Prog.Ini_Filters.WriteString('NOT_MECHANICAL_ARCADE', 'MameVer', '');
  mame.Prog.Ini_Filters.WriteString('ORIGINAL_ARCADE', 'MameVer', '');
  mame.Prog.Ini_Filters.WriteString('CLONES_ARCADE', 'MameVer', '');
  mame.Prog.Ini_Filters.WriteString('SCREENLESS', 'MameVer', '');
  mame.Prog.Ini_Filters.WriteString('MANUFACTURER', 'MameVer', '');
  mame.Prog.Ini_Filters.WriteString('YEAR', 'MameVer', '');
  mame.Prog.Ini_Filters.WriteString('BEST_GAMES', 'MameVer', '');
  mame.Prog.Ini_Filters.WriteString('GERNE', 'MameVer', '');
  mame.Prog.Ini_Filters.WriteString('SERIES', 'MameVer', '');
  mame.Prog.Ini_Filters.WriteString('VERSION', 'MameVer', '');
  mame.Prog.Ini_Filters.WriteString('CUSTOM', 'MameVer', '');
  mame.Prog.Ini_Filters.WriteString('CUSTOM', 'Filter_1', '');
  mame.Prog.Ini_Filters.WriteString('CUSTOM', 'Filter_2', '');
  mame.Prog.Ini_Filters.WriteString('CUSTOM', 'Filter_3', '');
  mame.Prog.Ini_Filters.WriteString('CUSTOM', 'Filter_4', '');
  mame.Prog.Ini_Filters.WriteString('CUSTOM', 'Filter_5', '');
  mame.Prog.Media_Path:= extrafe.prog.Path+ 'emu\arcade\media\';

  mame.Prog.Ini.WriteString('PROG', 'Filter', 'All Unfiltered');

//Set Mame Extra Dirs thar mame dont have and save it to mame_prog.ini
  mame.Emu.Media.Artworks:= mame.Prog.Media_Path+ 'Artworks\';
  mame.Prog.Ini.WriteString('MEDIA', 'Artworks_Path', mame.Emu.Media.Artworks);

  mame.Emu.Media.Cabinets:= mame.Prog.Media_Path+  'Cabinets\';
  mame.Prog.Ini.WriteString('MEDIA', 'Cabinets_Path', mame.Emu.Media.Cabinets);

  mame.Emu.Media.Control_Panels:= mame.Prog.Media_Path+  'Control Panels\';
  mame.Prog.Ini.WriteString('MEDIA', 'Control_Panels_Path', mame.Emu.Media.Control_Panels);

  mame.Emu.Media.Covers:= mame.Prog.Media_Path+  'Covers\';
  mame.Prog.Ini.WriteString('MEDIA', 'Covers_Path', mame.Emu.Media.Covers);

  mame.Emu.Media.Flyers:= mame.Prog.Media_Path+  'Flyers\';
  mame.Prog.Ini.WriteString('MEDIA', 'Flyers_Path', mame.Emu.Media.Flyers);

  mame.Emu.Media.Fanart:= mame.Prog.Media_Path+ 'Fanart\';
  mame.Prog.Ini.WriteString('MEDIA', 'Fanart_Path', mame.Emu.Media.Fanart);

  mame.Emu.Media.Game_Over:= mame.Prog.Media_Path+ 'Game Over\';
  mame.Prog.Ini.WriteString('MEDIA', 'Game_Over_Path', mame.Emu.Media.Game_Over);

  mame.Emu.Media.Icons:= mame.Prog.Media_Path+  'Icons\';
  mame.Prog.Ini.WriteString('MEDIA', 'Icons_Path', mame.Emu.Media.Icons);

  mame.Emu.Media.Manuals:= mame.Prog.Media_Path+  'Manuals\';
  mame.Prog.Ini.WriteString('MEDIA', 'Manuals_Path', mame.Emu.Media.Manuals);

  mame.Emu.Media.Marquees:= mame.Prog.Media_Path+  'Marquees\';
  mame.Prog.Ini.WriteString('MEDIA', 'Marquees_Path', mame.Emu.Media.Marquees);

  mame.Emu.Media.Pcbs:= mame.Prog.Media_Path+  'Pcbs\';
  mame.Prog.Ini.WriteString('MEDIA', 'Pcbs_Path', mame.Emu.Media.Pcbs);

  mame.Emu.Media.Snapshots:= mame.Prog.Media_Path+  'Snapshots\';
  mame.Prog.Ini.WriteString('MEDIA', 'Snapshots_Path', mame.Emu.Media.Snapshots);

  mame.Emu.Media.Titles:= mame.Prog.Media_Path+  'Titles\';
  mame.Prog.Ini.WriteString('MEDIA', 'Titles_Path', mame.Emu.Media.Titles);

  mame.Emu.Media.Artwork_Preview:= mame.Prog.Media_Path+  'Artwork Preview\';
  mame.Prog.Ini.WriteString('MEDIA', 'Artwork_Preview_Path', mame.Emu.Media.Artwork_Preview);

  mame.Emu.Media.Bosses:= mame.Prog.Media_Path+  'Bosses\';
  mame.Prog.Ini.WriteString('MEDIA', 'Bosses_Path', mame.Emu.Media.Bosses);

  mame.Emu.Media.Ends:= mame.Prog.Media_Path+  'Ends\';
  mame.Prog.Ini.WriteString('MEDIA', 'Ends_Path', mame.Emu.Media.Ends);

  mame.Emu.Media.How_To:= mame.Prog.Media_Path+  'How To\';
  mame.Prog.Ini.WriteString('MEDIA', 'How_To_Path', mame.Emu.Media.How_To);

  mame.Emu.Media.Logos:= mame.Prog.Media_Path+  'Logos\';
  mame.Prog.Ini.WriteString('MEDIA', 'Logos_Path', mame.Emu.Media.Logos);

  mame.Emu.Media.Scores:= mame.Prog.Media_Path+  'Scores\';
  mame.Prog.Ini.WriteString('MEDIA', 'Scores_Path', mame.Emu.Media.Scores);

  mame.Emu.Media.Selects:= mame.Prog.Media_Path+  'Selects\';
  mame.Prog.Ini.WriteString('MEDIA', 'Selects_Path', mame.Emu.Media.Selects);

  mame.Emu.Media.Stamps:= mame.Prog.Path+ 'Stamps\';
  mame.Prog.Ini.WriteString('MEDIA', 'Stamps_Path', mame.Emu.Media.Stamps);

  mame.Emu.Media.Versus:= mame.Prog.Media_Path+  'Versus\';
  mame.Prog.Ini.WriteString('MEDIA', 'Versus_Path', mame.Emu.Media.Versus);

  mame.Emu.Media.Warnings:= mame.Prog.Media_Path+ 'Warnings\';
  mame.Prog.Ini.WriteString('MEDIA', 'Warnings_Path', mame.Emu.Media.Warnings);

  mame.Emu.Media.Soundtracks:= mame.Prog.Media_Path+  'Soundtracks\';
  mame.Prog.Ini.WriteString('MEDIA', 'Soundtracks_Path', mame.Emu.Media.Soundtracks);

  mame.Emu.Media.Support_Files:= mame.Prog.Media_Path+  'Support Files\';
  mame.Prog.Ini.WriteString('MEDIA', 'Support_Files_Path', mame.Emu.Media.Support_Files);

  mame.Emu.Media.Videos:= mame.Prog.Media_Path+  'Videos\';
  mame.Prog.Ini.WriteString('MEDIA', 'Videos_Path', mame.Emu.Media.Videos);

  mame.Samples:= mame.Emu.Path+ 'samples\';
  mame.Prog.Ini.WriteString('SAMPLES', 'Samples_Path', mame.Samples);

//DONE 1 -oNikos Kordas -cEmu_Arcade_Mame: Create Emu Mame Values
//DONE 1 -oNikos Kordas -cEmu_Arcade_Mame: Create Emu Mame Media and Info Values
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
