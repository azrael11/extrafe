unit uMain_Config_Emulation_Consoles_Scripts_Nes_Install;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  System.Types,
  FMX.Types,
  FMX.StdCtrls,
  FMX.TabControl,
  FMX.ListBox,
  FMX.Objects,
  FMX.Dialogs,
  FMX.Edit,
  FMX.Forms,
  WinAPI.ShellApi,
  WinAPI.Windows,
  ALFMXObjects;

type
  TMAIN_NES_INSTALL_DIALOG = class(TObject)
    procedure OnClose(Sender: TObject);
  end;

type
  TMAIN_NES_INSTALL_TAB1 = record
    Box: TGroupBox;
    Text: TALText;
  end;

type
  TMAIN_NES_INSTALL_TAB2 = record
    Box: TGroupBox;
    List: TListBox;
    Image: TImage;
    Text: TALText;
  end;

type
  TMAIN_NES_INSTALL_TAB3 = record
    Box: TGroupBox;
    Radio_1: TRadioButton;
    Radio_2: TRadioButton;
    Text: TALText;
  end;

type
  TMAIN_NES_INSTALL_TAB4_COMPUTER = record
    Box: TGroupBox;
    Open_Dialog: TOpenDialog;
    Edit_Info: TLabel;
    Edit: TEdit;
    Find: TButton;
    Progress: TProgressBar;
    Start: TButton;
  end;

type
  TMAIN_NES_INSTALL_TAB4_SERVER = record

  end;

type
  TMAIN_NES_INSTALL_TAB5 = record
    Box: TGroupBox;
    Text: TALText;
    Close: TButton;
  end;

type
  TEMU_NES_INSTALL_MAIN = record
    Panel: TPanel;
    Dialog: TMAIN_NES_INSTALL_DIALOG;
    Control: TTabControl;
    Tabs: array [0 .. 5] of TTabItem;
    Tab1: TMAIN_NES_INSTALL_TAB1;
    Tab2: TMAIN_NES_INSTALL_TAB2;
    Tab3: TMAIN_NES_INSTALL_TAB3;
    Tab4_1: TMAIN_NES_INSTALL_TAB4_COMPUTER;
    Tab4_2: TMAIN_NES_INSTALL_TAB4_SERVER;
    Tab5: TMAIN_NES_INSTALL_TAB5;
    Cancel: TButton;
    Next: TButton;
    Back: TButton;
    Status: String;
    Choosen: String;
    Emu_Path: String;
  end;

type
  TEMU_NES_INSTALL = record
    Panel: TPanel;
    Main: TEMU_NES_INSTALL_MAIN;
  end;

procedure uEmulation_Consoles_Nes_Install;
procedure uEmulation_Consoles_Nes_Install_Free;

procedure uEmulation_Consoles_Nes_Slide_To_Next;
procedure uEmulation_Consoles_Nes_Slide_To_Previous;

procedure Create_Tab1;
procedure Create_Tab2;
procedure uEmulation_Consoles_Nes_ShowEmulatorInfo(vNum: Integer);
procedure Create_Tab3;
procedure Create_Tab4_1;
procedure Create_Tab4_2;
procedure Create_Tab5;

procedure ShowButtons;

procedure uEmulation_Consoles_Nes_Installation;

const
  cNes_Emu_Image: array [0 .. 3] of string = ('punes.png', 'ines.png', 'nestopia.png', 'mame_nes.png');

var
  Script_Nes_Install: TEMU_NES_INSTALL;

implementation

uses
  Main,
  uLoad_AllTypes,
  uMain_AllTypes,
  uMain_Emulation,
  uMain_Config_Emulators,
  uEmu_Consoles_Nes_AllTypes;

procedure uEmulation_Consoles_Nes_Install;
var
  vi: Integer;
begin
  extrafe.prog.State := 'main_config_install_emulator';
  Script_Nes_Install.Main.Status := 'phase_1';

  mainScene.Config.Main.Left_Blur.Enabled := True;
  mainScene.Config.Main.R.Emulators.Panel_Blur.Enabled := True;

  Script_Nes_Install.Panel := TPanel.Create(Main_Form);
  Script_Nes_Install.Panel.Name := 'Script_Nes_Install';
  Script_Nes_Install.Panel.Parent := Main_Form;
  Script_Nes_Install.Panel.SetBounds(extrafe.res.Half_Width - 300, extrafe.res.Half_Height - 175, 600, 350);
  Script_Nes_Install.Panel.Visible := True;

  CreateHeader(Script_Nes_Install.Panel, 'IcoMoon-Free', #$e997, 'Install a nes emulator', false, nil);

  Script_Nes_Install.Main.Panel := TPanel.Create(Script_Nes_Install.Panel);
  Script_Nes_Install.Main.Panel.Name := 'Script_Nes_Install_Main';
  Script_Nes_Install.Main.Panel.Parent := Script_Nes_Install.Panel;
  Script_Nes_Install.Main.Panel.SetBounds(0, 30, Script_Nes_Install.Panel.Width, Script_Nes_Install.Panel.Height - 30);
  Script_Nes_Install.Main.Panel.Visible := True;

  Script_Nes_Install.Main.Control := TTabControl.Create(Script_Nes_Install.Main.Panel);
  Script_Nes_Install.Main.Control.Name := 'Script_Nes_Install_Main_Control';
  Script_Nes_Install.Main.Control.Parent := Script_Nes_Install.Main.Panel;
  Script_Nes_Install.Main.Control.Align := TAlignLayout.Client;
  Script_Nes_Install.Main.Control.TabPosition := TTabPosition.None;
  Script_Nes_Install.Main.Control.Visible := True;

  for vi := 0 to 5 do
  begin
    Script_Nes_Install.Main.Tabs[vi] := TTabItem.Create(Script_Nes_Install.Main.Control);
    Script_Nes_Install.Main.Tabs[vi].Name := 'Script_Nes_Install_Main_Tab_' + vi.ToString;
    Script_Nes_Install.Main.Tabs[vi].Parent := Script_Nes_Install.Main.Control;
    Script_Nes_Install.Main.Tabs[vi].SetBounds(0, 0, Script_Nes_Install.Main.Control.Width, 200);
    Script_Nes_Install.Main.Tabs[vi].Visible := True;
  end;

  Create_Tab1;
  Create_Tab2;
  Create_Tab3;
  Create_Tab4_1;
  Create_Tab4_2;
  Create_Tab5;

  Script_Nes_Install.Main.Next := TButton.Create(Script_Nes_Install.Main.Panel);
  Script_Nes_Install.Main.Next.Name := 'Script_Nes_Install_Main_Next';
  Script_Nes_Install.Main.Next.Parent := Script_Nes_Install.Main.Panel;
  Script_Nes_Install.Main.Next.SetBounds(Script_Nes_Install.Main.Control.Width - 190, Script_Nes_Install.Main.Control.Height - 50, 140, 40);
  Script_Nes_Install.Main.Next.Text := 'Next';
  Script_Nes_Install.Main.Next.OnClick := ex_main.Input.mouse_script_consoles.Button.OnMouseClick;
  Script_Nes_Install.Main.Next.Visible := false;

  Script_Nes_Install.Main.Back := TButton.Create(Script_Nes_Install.Main.Panel);
  Script_Nes_Install.Main.Back.Name := 'Script_Nes_Install_Main_Back';
  Script_Nes_Install.Main.Back.Parent := Script_Nes_Install.Main.Panel;
  Script_Nes_Install.Main.Back.SetBounds((Script_Nes_Install.Main.Control.Width / 2) - 70, Script_Nes_Install.Main.Control.Height - 50, 140, 40);
  Script_Nes_Install.Main.Back.Text := 'Back';
  Script_Nes_Install.Main.Back.OnClick := ex_main.Input.mouse_script_consoles.Button.OnMouseClick;
  Script_Nes_Install.Main.Back.Visible := false;

  Script_Nes_Install.Main.Cancel := TButton.Create(Script_Nes_Install.Main.Panel);
  Script_Nes_Install.Main.Cancel.Name := 'Script_Nes_Install_Main_Cancel';
  Script_Nes_Install.Main.Cancel.Parent := Script_Nes_Install.Main.Panel;
  Script_Nes_Install.Main.Cancel.SetBounds(50, Script_Nes_Install.Main.Control.Height - 50, 140, 40);
  Script_Nes_Install.Main.Cancel.Text := 'Cancel';
  Script_Nes_Install.Main.Cancel.OnClick := ex_main.Input.mouse_script_consoles.Button.OnMouseClick;
  Script_Nes_Install.Main.Cancel.Visible := false;

  ShowButtons;
end;

procedure uEmulation_Consoles_Nes_Install_Free;
begin
  extrafe.prog.State := 'main_config_emulators';
  mainScene.Config.Main.Left_Blur.Enabled := false;
  mainScene.Config.Main.R.Emulators.Panel_Blur.Enabled := false;
  FreeAndNil(Script_Nes_Install.Panel);
  mainScene.Footer.Back_Blur.Enabled := false;
end;

procedure ShowButtons;
begin
  if Script_Nes_Install.Main.Status = 'phase_1' then
  begin
    Script_Nes_Install.Main.Next.Visible := True;
    Script_Nes_Install.Main.Back.Visible := false;
    Script_Nes_Install.Main.Cancel.Visible := True;
  end
  else if (Script_Nes_Install.Main.Status = 'phase_2') or (Script_Nes_Install.Main.Status = 'phase_3') or (Script_Nes_Install.Main.Status = 'phase_4_1') or
    (Script_Nes_Install.Main.Status = 'phase_4_2') then
  begin
    Script_Nes_Install.Main.Next.Visible := True;
    Script_Nes_Install.Main.Back.Visible := True;
    Script_Nes_Install.Main.Cancel.Visible := True;
  end
  else if Script_Nes_Install.Main.Status = 'final' then
  begin
    Script_Nes_Install.Main.Next.Visible := false;
    Script_Nes_Install.Main.Back.Visible := false;
    Script_Nes_Install.Main.Cancel.Visible := false;
  end;
end;

procedure uEmulation_Consoles_Nes_Slide_To_Next;
begin
  if Script_Nes_Install.Main.Status = 'phase_1' then
  begin
    Script_Nes_Install.Main.Control.SetActiveTabWithTransition(Script_Nes_Install.Main.Tabs[1], TTabTransition.Slide, TTabTransitionDirection.Normal);
    Script_Nes_Install.Main.Status := 'phase_2';
  end
  else if Script_Nes_Install.Main.Status = 'phase_2' then
  begin
    if Script_Nes_Install.Main.Choosen = 'Mame NES' then
    begin
      Script_Nes_Install.Main.Control.SetActiveTabWithTransition(Script_Nes_Install.Main.Tabs[2], TTabTransition.Slide, TTabTransitionDirection.Normal);
      Script_Nes_Install.Main.Status := 'phase_3';
    end
    else
      ShowMessage('Please Select an emulator with ready installation script');
  end
  else if Script_Nes_Install.Main.Status = 'phase_3' then
  begin
    if Script_Nes_Install.Main.Tab3.Radio_1.IsChecked then
    begin
      Script_Nes_Install.Main.Control.SetActiveTabWithTransition(Script_Nes_Install.Main.Tabs[3], TTabTransition.Slide, TTabTransitionDirection.Normal);
      Script_Nes_Install.Main.Status := 'phase_4_1';
    end
    else if Script_Nes_Install.Main.Tab3.Radio_2.IsChecked then
    begin
      Script_Nes_Install.Main.Control.SetActiveTabWithTransition(Script_Nes_Install.Main.Tabs[4], TTabTransition.Slide, TTabTransitionDirection.Normal);
      Script_Nes_Install.Main.Status := 'phase_4_2';
    end;
  end
  else if (Script_Nes_Install.Main.Status = 'phase_4_1') or (Script_Nes_Install.Main.Status = 'phase_4_2') then
  begin
    Script_Nes_Install.Main.Control.SetActiveTabWithTransition(Script_Nes_Install.Main.Tabs[5], TTabTransition.Slide, TTabTransitionDirection.Normal);
    Script_Nes_Install.Main.Status := 'final';
  end;
  ShowButtons;
end;

procedure uEmulation_Consoles_Nes_Slide_To_Previous;
begin
  if (Script_Nes_Install.Main.Status = 'phase_4_1') or (Script_Nes_Install.Main.Status = 'phase_4_2') then
  begin
    Script_Nes_Install.Main.Control.SetActiveTabWithTransition(Script_Nes_Install.Main.Tabs[2], TTabTransition.Slide, TTabTransitionDirection.Reversed);
    Script_Nes_Install.Main.Status := 'phase_3';
  end
  else if Script_Nes_Install.Main.Status = 'phase_3' then
  begin
    Script_Nes_Install.Main.Control.SetActiveTabWithTransition(Script_Nes_Install.Main.Tabs[1], TTabTransition.Slide, TTabTransitionDirection.Reversed);
    Script_Nes_Install.Main.Status := 'phase_2';
  end
  else if Script_Nes_Install.Main.Status = 'phase_2' then
  begin
    Script_Nes_Install.Main.Control.SetActiveTabWithTransition(Script_Nes_Install.Main.Tabs[0], TTabTransition.Slide, TTabTransitionDirection.Reversed);
    Script_Nes_Install.Main.Status := 'phase_1';
  end;
  ShowButtons;
end;

procedure Create_Tab1;
begin
  Script_Nes_Install.Main.Tab1.Box := TGroupBox.Create(Script_Nes_Install.Main.Tabs[0]);
  Script_Nes_Install.Main.Tab1.Box.Name := 'Script_Nes_Install_Main_Tab1_Box';
  Script_Nes_Install.Main.Tab1.Box.Parent := Script_Nes_Install.Main.Tabs[0];
  Script_Nes_Install.Main.Tab1.Box.SetBounds(10, 10, Script_Nes_Install.Main.Control.Width - 20, 200);
  Script_Nes_Install.Main.Tab1.Box.Text := 'Welcome to ExtraFE wizard setup "Nes" emulator.';
  Script_Nes_Install.Main.Tab1.Box.Visible := True;

  Script_Nes_Install.Main.Tab1.Text := TALText.Create(Script_Nes_Install.Main.Tab1.Box);
  Script_Nes_Install.Main.Tab1.Text.Name := 'Script_Nes_Install_Main_Tab1_Text';
  Script_Nes_Install.Main.Tab1.Text.Parent := Script_Nes_Install.Main.Tab1.Box;
  Script_Nes_Install.Main.Tab1.Text.SetBounds(10, 40, Script_Nes_Install.Main.Tab1.Box.Width - 20, 60);
  Script_Nes_Install.Main.Tab1.Text.WordWrap := True;
  Script_Nes_Install.Main.Tab1.Text.TextIsHtml := True;
  Script_Nes_Install.Main.Tab1.Text.TextSettings.FontColor := TAlphaColorRec.White;
  Script_Nes_Install.Main.Tab1.Text.TextSettings.Font.Size := 14;
  Script_Nes_Install.Main.Tab1.Text.TextSettings.VertAlign := TTextAlign.Leading;
  Script_Nes_Install.Main.Tab1.Text.Text :=
    ' This action will "<font color="#ff63cbfc">install a Nes Emulator</font>" to "<font color="#ff63cbfc">ExtraFE</font>".' + #13#10 +
    ' If you wish to continue press next else press cancel.';
  Script_Nes_Install.Main.Tab1.Text.Visible := True;
end;

procedure Create_Tab2;
begin
  Script_Nes_Install.Main.Tab2.Box := TGroupBox.Create(Script_Nes_Install.Main.Tabs[1]);
  Script_Nes_Install.Main.Tab2.Box.Name := 'Script_Nes_Install_Main_Tab2_Box';
  Script_Nes_Install.Main.Tab2.Box.Parent := Script_Nes_Install.Main.Tabs[1];
  Script_Nes_Install.Main.Tab2.Box.SetBounds(10, 10, Script_Nes_Install.Main.Control.Width - 20, 200);
  Script_Nes_Install.Main.Tab2.Box.Text := 'Choose an emulator.';
  Script_Nes_Install.Main.Tab2.Box.Visible := True;

  Script_Nes_Install.Main.Tab2.List := TListBox.Create(Script_Nes_Install.Main.Tab2.Box);
  Script_Nes_Install.Main.Tab2.List.Name := 'Script_Nes_Install_Main_Tab2_Listbox';
  Script_Nes_Install.Main.Tab2.List.Parent := Script_Nes_Install.Main.Tab2.Box;
  Script_Nes_Install.Main.Tab2.List.SetBounds(10, 20, 250, 160);
  Script_Nes_Install.Main.Tab2.List.Items.Add('puNes (Not Ready Yet)');
  Script_Nes_Install.Main.Tab2.List.Items.Add('iNes (Not Ready Yet)');
  Script_Nes_Install.Main.Tab2.List.Items.Add('Nestopia (Not Ready Yet)');
  Script_Nes_Install.Main.Tab2.List.Items.Add('Mame Nes');
  Script_Nes_Install.Main.Tab2.List.ItemIndex := -1;
  Script_Nes_Install.Main.Tab2.List.OnClick := ex_main.Input.mouse_script_consoles.ListBox.OnMouseClick;
  Script_Nes_Install.Main.Tab2.List.Visible := True;

  Script_Nes_Install.Main.Tab2.Image := TImage.Create(Script_Nes_Install.Main.Tab2.Box);
  Script_Nes_Install.Main.Tab2.Image.Name := 'Script_Nes_Install_Main_Tab2_Image';
  Script_Nes_Install.Main.Tab2.Image.Parent := Script_Nes_Install.Main.Tab2.Box;
  Script_Nes_Install.Main.Tab2.Image.SetBounds(300, 20, 200, 150);
  Script_Nes_Install.Main.Tab2.Image.WrapMode := TImageWrapMode.Original;
  Script_Nes_Install.Main.Tab2.Image.Visible := True;

end;

procedure uEmulation_Consoles_Nes_ShowEmulatorInfo(vNum: Integer);
begin
  case vNum of
    0:
      begin
        Script_Nes_Install.Main.Tab2.Image.Bitmap.LoadFromFile(extrafe.prog.Path + 'emu\consoles\nes\images\supported\punes.png');
        Script_Nes_Install.Main.Choosen := 'puNes';
      end;
    1:
      begin
        Script_Nes_Install.Main.Tab2.Image.Bitmap.LoadFromFile(extrafe.prog.Path + 'emu\consoles\nes\images\supported\ines.png');
        Script_Nes_Install.Main.Choosen := 'iNES';
      end;
    2:
      begin
        Script_Nes_Install.Main.Tab2.Image.Bitmap.LoadFromFile(extrafe.prog.Path + 'emu\consoles\nes\images\supported\nestopia.png');
        Script_Nes_Install.Main.Choosen := 'Nestopia';
      end;
    3:
      begin
        Script_Nes_Install.Main.Tab2.Image.Bitmap.LoadFromFile(extrafe.prog.Path + 'emu\consoles\nes\images\supported\mame_nes.png');
        Script_Nes_Install.Main.Choosen := 'Mame NES';
      end;
  end;
  Script_Nes_Install.Main.Tab3.Radio_1.Text := 'Install "' + Script_Nes_Install.Main.Choosen + '" to ExtaFE from computer';
  Script_Nes_Install.Main.Tab3.Radio_2.Text := 'Install "' + Script_Nes_Install.Main.Choosen + '" to ExtaFE from "ExtraFE Server".';
  Script_Nes_Install.Main.Tab4_1.Box.Text := 'Install "' + Script_Nes_Install.Main.Choosen + '" from computer.';
  Script_Nes_Install.Main.Tab4_1.Edit_Info.Text := 'Find the executable file of  "' + Script_Nes_Install.Main.Choosen + '" emulator.';
  Script_Nes_Install.Main.Tab5.Text.Text := ' Installation of "<font color="#ff63cbfc">' + Script_Nes_Install.Main.Choosen + '</font>" is completed.' + #13#10 +
    '   Close and enjoy the thousands retro games of Nintendo NES.' + #13#10 + '   P.S. You must have the roms to play, ExtraFE provide no roms.';
end;

procedure Create_Tab3;
begin
  Script_Nes_Install.Main.Tab3.Box := TGroupBox.Create(Script_Nes_Install.Main.Tabs[2]);
  Script_Nes_Install.Main.Tab3.Box.Name := 'Script_Nes_Install_Main_Tab3_Box';
  Script_Nes_Install.Main.Tab3.Box.Parent := Script_Nes_Install.Main.Tabs[2];
  Script_Nes_Install.Main.Tab3.Box.SetBounds(10, 10, Script_Nes_Install.Main.Control.Width - 20, 200);
  Script_Nes_Install.Main.Tab3.Box.Text := 'Please choose installation type.';
  Script_Nes_Install.Main.Tab3.Box.Visible := True;

  Script_Nes_Install.Main.Tab3.Radio_1 := TRadioButton.Create(Script_Nes_Install.Main.Tab3.Box);
  Script_Nes_Install.Main.Tab3.Radio_1.Name := 'Script_Nes_Install_Main_Tab3_Radio_1';
  Script_Nes_Install.Main.Tab3.Radio_1.Parent := Script_Nes_Install.Main.Tab3.Box;
  Script_Nes_Install.Main.Tab3.Radio_1.SetBounds(20, 30, 400, 24);
  Script_Nes_Install.Main.Tab3.Radio_1.OnClick := ex_main.Input.mouse_script_arcade.Radio.OnMouseClick;
  Script_Nes_Install.Main.Tab3.Radio_1.Visible := True;

  Script_Nes_Install.Main.Tab3.Radio_2 := TRadioButton.Create(Script_Nes_Install.Main.Tab3.Box);
  Script_Nes_Install.Main.Tab3.Radio_2.Name := 'Script_Nes_Install_Main_Tab3__Radio_2';
  Script_Nes_Install.Main.Tab3.Radio_2.Parent := Script_Nes_Install.Main.Tab3.Box;
  Script_Nes_Install.Main.Tab3.Radio_2.SetBounds(20, 90, 400, 24);
  Script_Nes_Install.Main.Tab3.Radio_2.OnClick := ex_main.Input.mouse_script_arcade.Radio.OnMouseClick;
  Script_Nes_Install.Main.Tab3.Radio_2.Visible := True;
end;

procedure Create_Tab4_1;
begin
  Script_Nes_Install.Main.Tab4_1.Box := TGroupBox.Create(Script_Nes_Install.Main.Tabs[3]);
  Script_Nes_Install.Main.Tab4_1.Box.Name := 'Script_Nes_Install_Main_Tab4_Computer_Box';
  Script_Nes_Install.Main.Tab4_1.Box.Parent := Script_Nes_Install.Main.Tabs[3];
  Script_Nes_Install.Main.Tab4_1.Box.SetBounds(10, 10, Script_Nes_Install.Main.Control.Width - 20, 200);
  Script_Nes_Install.Main.Tab4_1.Box.Visible := True;

  Script_Nes_Install.Main.Tab4_1.Edit_Info := TLabel.Create(Script_Nes_Install.Main.Tab4_1.Box);
  Script_Nes_Install.Main.Tab4_1.Edit_Info.Name := 'Script_Nes_Install_Main_Tab4_EditLabel';
  Script_Nes_Install.Main.Tab4_1.Edit_Info.Parent := Script_Nes_Install.Main.Tab4_1.Box;
  Script_Nes_Install.Main.Tab4_1.Edit_Info.SetBounds(20, 40, 300, 24);
  Script_Nes_Install.Main.Tab4_1.Edit_Info.TextSettings.Font.Style := Script_Nes_Install.Main.Tab4_1.Edit_Info.TextSettings.Font.Style + [TFontStyle.fsBold];
  Script_Nes_Install.Main.Tab4_1.Edit_Info.Visible := True;

  Script_Nes_Install.Main.Tab4_1.Open_Dialog := TOpenDialog.Create(Script_Nes_Install.Main.Tab4_1.Box);
  Script_Nes_Install.Main.Tab4_1.Open_Dialog.Name := 'Script_Nes_Install_Main_Tab4_OpenDialog';
  Script_Nes_Install.Main.Tab4_1.Open_Dialog.Parent := Script_Nes_Install.Main.Tab4_1.Box;
  Script_Nes_Install.Main.Tab4_1.Open_Dialog.FileName := '';
  Script_Nes_Install.Main.Tab4_1.Open_Dialog.Filter := 'Mame64|mame64.exe|Mame32|mame.exe|Mame64, Mame32|mame64.exe; mame.exe';
  Script_Nes_Install.Main.Tab4_1.Open_Dialog.OnClose := Script_Nes_Install.Main.Dialog.OnClose;

  Script_Nes_Install.Main.Tab4_1.Edit := TEdit.Create(Script_Nes_Install.Main.Tab4_1.Box);
  Script_Nes_Install.Main.Tab4_1.Edit.Name := 'Script_Nes_Install_Main_Tab4_Edit';
  Script_Nes_Install.Main.Tab4_1.Edit.Parent := Script_Nes_Install.Main.Tab4_1.Box;
  Script_Nes_Install.Main.Tab4_1.Edit.SetBounds(20, 60, Script_Nes_Install.Main.Tab4_1.Box.Width - 80, 26);
  Script_Nes_Install.Main.Tab4_1.Edit.Text := '';
  Script_Nes_Install.Main.Tab4_1.Edit.ReadOnly := True;
  Script_Nes_Install.Main.Tab4_1.Edit.Caret.Color := TAlphaColorRec.Deepskyblue;
  Script_Nes_Install.Main.Tab4_1.Edit.Visible := True;

  Script_Nes_Install.Main.Tab4_1.Find := TButton.Create(Script_Nes_Install.Main.Tab4_1.Box);
  Script_Nes_Install.Main.Tab4_1.Find.Name := 'Script_Nes_Install_Main_Tab4_Find';
  Script_Nes_Install.Main.Tab4_1.Find.Parent := Script_Nes_Install.Main.Tab4_1.Box;
  Script_Nes_Install.Main.Tab4_1.Find.SetBounds(Script_Nes_Install.Main.Tab4_1.Box.Width - 60, 60, 50, 26);
  Script_Nes_Install.Main.Tab4_1.Find.Text := 'Find';
  Script_Nes_Install.Main.Tab4_1.Find.OnClick := ex_main.Input.mouse_script_consoles.Button.OnMouseClick;
  Script_Nes_Install.Main.Tab4_1.Find.Visible := True;

  Script_Nes_Install.Main.Tab4_1.Progress := TProgressBar.Create(Script_Nes_Install.Main.Tab4_1.Box);
  Script_Nes_Install.Main.Tab4_1.Progress.Name := 'Script_Nes_Install_Main_Tab4_Progress';
  Script_Nes_Install.Main.Tab4_1.Progress.Parent := Script_Nes_Install.Main.Tab4_1.Box;
  Script_Nes_Install.Main.Tab4_1.Progress.SetBounds(20, 60, Script_Nes_Install.Main.Tab4_1.Box.Width - 40, 26);
  Script_Nes_Install.Main.Tab4_1.Progress.Min := 0;
  Script_Nes_Install.Main.Tab4_1.Progress.Max := 100;
  Script_Nes_Install.Main.Tab4_1.Progress.Value := 0;
  Script_Nes_Install.Main.Tab4_1.Progress.Visible := false;

  Script_Nes_Install.Main.Tab4_1.Start := TButton.Create(Script_Nes_Install.Main.Tab4_1.Box);
  Script_Nes_Install.Main.Tab4_1.Start.Name := 'Script_Nes_Install_Main_Tab4_Start';
  Script_Nes_Install.Main.Tab4_1.Start.Parent := Script_Nes_Install.Main.Tab4_1.Box;
  Script_Nes_Install.Main.Tab4_1.Start.SetBounds(30, 120, 200, 26);
  Script_Nes_Install.Main.Tab4_1.Start.Text := 'Start the installation.';
  Script_Nes_Install.Main.Tab4_1.Start.OnClick := ex_main.Input.mouse_script_consoles.Button.OnMouseClick;
  Script_Nes_Install.Main.Tab4_1.Start.Visible := false;
end;

procedure Create_Tab4_2;
begin

end;

procedure Create_Tab5;
begin
  Script_Nes_Install.Main.Tab5.Box := TGroupBox.Create(Script_Nes_Install.Main.Tabs[5]);
  Script_Nes_Install.Main.Tab5.Box.Name := 'Script_Nes_Install_Main_Tab5_Box';
  Script_Nes_Install.Main.Tab5.Box.Parent := Script_Nes_Install.Main.Tabs[5];
  Script_Nes_Install.Main.Tab5.Box.SetBounds(10, 10, Script_Nes_Install.Main.Control.Width - 20, 200);
  Script_Nes_Install.Main.Tab5.Box.Text := 'Congratulatinos';
  Script_Nes_Install.Main.Tab5.Box.Visible := True;

  Script_Nes_Install.Main.Tab5.Text := TALText.Create(Script_Nes_Install.Main.Tab5.Box);
  Script_Nes_Install.Main.Tab5.Text.Name := 'Script_Nes_Install_Main_Tab5_Text';
  Script_Nes_Install.Main.Tab5.Text.Parent := Script_Nes_Install.Main.Tab5.Box;
  Script_Nes_Install.Main.Tab5.Text.SetBounds(10, 40, Script_Nes_Install.Main.Tab5.Box.Width - 20, 60);
  Script_Nes_Install.Main.Tab5.Text.WordWrap := True;
  Script_Nes_Install.Main.Tab5.Text.TextIsHtml := True;
  Script_Nes_Install.Main.Tab5.Text.TextSettings.FontColor := TAlphaColorRec.White;
  Script_Nes_Install.Main.Tab5.Text.TextSettings.Font.Size := 14;
  Script_Nes_Install.Main.Tab5.Text.TextSettings.VertAlign := TTextAlign.Leading;
  Script_Nes_Install.Main.Tab5.Text.Visible := True;

  Script_Nes_Install.Main.Tab5.Close := TButton.Create(Script_Nes_Install.Main.Tab5.Box);
  Script_Nes_Install.Main.Tab5.Close.Name := 'Script_Nes_Install_Main_Tab5_Close';
  Script_Nes_Install.Main.Tab5.Close.Parent := Script_Nes_Install.Main.Tab5.Box;
  Script_Nes_Install.Main.Tab5.Close.SetBounds((Script_Nes_Install.Main.Control.Width / 2) - 70, Script_Nes_Install.Main.Control.Height - 80, 140, 40);
  Script_Nes_Install.Main.Tab5.Close.Text := 'Close and enjoy';
  Script_Nes_Install.Main.Tab5.Close.OnClick := ex_main.Input.mouse_script_consoles.Button.OnMouseClick;
  Script_Nes_Install.Main.Tab5.Close.Visible := True;
end;

procedure uEmulation_Consoles_Nes_Installation;
begin
  Script_Nes_Install.Main.Tab4_1.Edit.Visible := false;
  Script_Nes_Install.Main.Tab4_1.Progress.Visible := True;
  Script_Nes_Install.Main.Back.Enabled := false;
  Script_Nes_Install.Main.Cancel.Enabled := false;
  Script_Nes_Install.Main.Next.Enabled := false;
  Script_Nes_Install.Main.Tab4_1.Start.Visible := false;
  Script_Nes_Install.Main.Tab4_1.Find.Visible := false;
  Script_Nes_Install.Main.Tab4_1.Edit_Info.Text := 'Start the installation.';

  nes.Mame.Name := ExtractFileName(Script_Nes_Install.Main.Tab4_1.Edit.Text);
  nes.Mame.Path := ExtractFilePath(Script_Nes_Install.Main.Tab4_1.Edit.Text);

  // Create mame ini if dont exist
  if not FileExists(nes.Mame.Path + 'mame.ini') then
    ShellExecute(0, nil, 'cmd.exe', PChar('/C ' + AnsiQuotedStr(nes.Mame.Path + nes.Mame.Name, Char(34)) + ' -cc'), PChar(nes.Mame.Path), SW_HIDE);
  nes.Mame.p_Ini_Path := nes.Mame.Path;

  Script_Nes_Install.Main.Tab4_1.Progress.Value := 20;
  Application.ProcessMessages;

  nes.Mame.Database := extrafe.prog.Path + 'emu\consoles\nes\database\';
  ShellExecute(0, nil, 'cmd.exe', PChar('/C ' + AnsiQuotedStr(nes.Mame.Path + nes.Mame.Name, Char(34)) + ' nes -glist > ' + nes.Mame.Database +
    'mame_data_games.xml'), nil, SW_HIDE);

  Script_Nes_Install.Main.Tab4_1.Progress.Value := 40;
  Application.ProcessMessages;

  if emulation.Level = 0 then
    emulation.Selection_Tab[2].Logo_Gray.Enabled := false;
  inc(emulation.Category[2].Second_Level, 1);
  Script_Nes_Install.Main.Tab4_1.Progress.Value := 100;
  Script_Nes_Install.Main.Tab4_1.Edit_Info.Text := 'Installation complete. Click next to start using it.';

  emulation.emu[2, 8] := 'active';
  emulation.Consoles[8].Installed := True;

  // Clear and create the main control tab
  uMain_Emulation.Clear_Selection_Control;
  uMain_Emulation.Create_Selection_Control;
  uMain_Emulation.Category(2, 0);

  FreeAndNil(mainScene.Config.Main.R.Emulators.Consoles[8].Panel);
  uMain_Config_Emulators.CreateConsolesPanel(8);

  Script_Nes_Install.Main.Cancel.Visible := false;
  Script_Nes_Install.Main.Back.Visible := false;
  Script_Nes_Install.Main.Next.Enabled := True;
end;

{ TMAIN_NES_INSTALL_DIALOG }

procedure TMAIN_NES_INSTALL_DIALOG.OnClose(Sender: TObject);
begin
  Script_Nes_Install.Main.Emu_Path := Script_Nes_Install.Main.Tab4_1.Open_Dialog.FileName;
  Script_Nes_Install.Main.Tab4_1.Start.Visible := True;
  Script_Nes_Install.Main.Tab4_1.Edit.Text := Script_Nes_Install.Main.Emu_Path;
end;

initialization

Script_Nes_Install.Main.Dialog := TMAIN_NES_INSTALL_DIALOG.Create;

finalization

Script_Nes_Install.Main.Dialog.Free;

end.
