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
  FMX.Graphics,
  WinAPI.ShellApi,
  WinAPI.Windows,
  ALFMXObjects, FMX.Memo;

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
    Items: array of TListBoxItem;
    Image: TImage;
    Memo: TMemo;
    Status: TALText;
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
    Image: TImage;
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
procedure uEmulation_Consoles_Nes_ShowEmulatorInfo(vName: String);
procedure Create_Tab3;
procedure Create_Tab4_1;
procedure Create_Tab4_2;
procedure Create_Tab5;

procedure ShowButtons;

procedure uEmulation_Consoles_Nes_Installation;

const
  cNes_Emu_Image: array [0 .. 3] of string = ('punes.png', 'ines.png', 'nestopia.png', 'mame_nes.png');

var
  Nes_I: TEMU_NES_INSTALL;

implementation

uses
  Main,
  uLoad_AllTypes,
  uMain_AllTypes,
  uMain_Emulation,
  uMain_Config_Emulators,
  uEmu_Consoles_Nes_AllTypes,
  uMain_Config_Emulation_Consoles_Scripts_Mouse,
  uDB_AUser,
  uDB;

procedure uEmulation_Consoles_Nes_Install;
var
  vi: Integer;
begin
  extrafe.prog.State := 'main_config_install_emulator';
  Nes_I.Main.Status := 'phase_1';

  mainScene.Config.Main.Left_Blur.Enabled := True;
  mainScene.Config.Main.R.Emulators.Panel_Blur.Enabled := True;

  Nes_I.Panel := TPanel.Create(Main_Form);
  Nes_I.Panel.Name := 'Nes_I';
  Nes_I.Panel.Parent := Main_Form;
  Nes_I.Panel.SetBounds(uDB_AUser.Local.SETTINGS.Resolution.Half_Width - 350, uDB_AUser.Local.SETTINGS.Resolution.Half_Height - 250, 700, 500);
  Nes_I.Panel.Visible := True;

  CreateHeader(Nes_I.Panel, 'IcoMoon-Free', #$e997, TAlphaColorRec.DeepSkyBlue, 'Install a nes emulator', false, nil);

  Nes_I.Main.Panel := TPanel.Create(Nes_I.Panel);
  Nes_I.Main.Panel.Name := 'Script_Nes_Install_Main';
  Nes_I.Main.Panel.Parent := Nes_I.Panel;
  Nes_I.Main.Panel.SetBounds(0, 30, Nes_I.Panel.Width, Nes_I.Panel.Height - 30);
  Nes_I.Main.Panel.Visible := True;

  Nes_I.Main.Image := TImage.Create(Nes_I.Panel);
  Nes_I.Main.Image.Name := 'Scritp_Nes_Install_Logo';
  Nes_I.Main.Image.Parent := Nes_I.Panel;
  Nes_I.Main.Image.SetBounds((Nes_I.Main.Panel.Width / 2 - 75), 35, 150, 60);
  Nes_I.Main.Image.Bitmap.LoadFromFile(ex_main.Paths.Config_Images.emu + 'consoles\nintendo_nes_logo.png');
  Nes_I.Main.Image.Visible := True;

  Nes_I.Main.Control := TTabControl.Create(Nes_I.Main.Panel);
  Nes_I.Main.Control.Name := 'Script_Nes_Install_Main_Control';
  Nes_I.Main.Control.Parent := Nes_I.Main.Panel;
  Nes_I.Main.Control.Align := TAlignLayout.Client;
  Nes_I.Main.Control.TabPosition := TTabPosition.None;
  Nes_I.Main.Control.Visible := True;

  for vi := 0 to 5 do
  begin
    Nes_I.Main.Tabs[vi] := TTabItem.Create(Nes_I.Main.Control);
    Nes_I.Main.Tabs[vi].Name := 'Script_Nes_Install_Main_Tab_' + vi.ToString;
    Nes_I.Main.Tabs[vi].Parent := Nes_I.Main.Control;
    Nes_I.Main.Tabs[vi].SetBounds(0, 0, Nes_I.Main.Control.Width, 400);
    Nes_I.Main.Tabs[vi].Visible := True;
  end;

  Create_Tab1;
  Create_Tab2;
  Create_Tab3;
  Create_Tab4_1;
  Create_Tab4_2;
  Create_Tab5;

  Nes_I.Main.Next := TButton.Create(Nes_I.Main.Panel);
  Nes_I.Main.Next.Name := 'Script_Nes_Install_Main_Next';
  Nes_I.Main.Next.Parent := Nes_I.Main.Panel;
  Nes_I.Main.Next.SetBounds(Nes_I.Main.Control.Width - 190, Nes_I.Main.Control.Height - 40, 140, 30);
  Nes_I.Main.Next.Text := 'Next';
  Nes_I.Main.Next.OnClick := ex_main.Input.mouse_script_consoles.Button.OnMouseClick;
  Nes_I.Main.Next.Visible := false;

  Nes_I.Main.Back := TButton.Create(Nes_I.Main.Panel);
  Nes_I.Main.Back.Name := 'Script_Nes_Install_Main_Back';
  Nes_I.Main.Back.Parent := Nes_I.Main.Panel;
  Nes_I.Main.Back.SetBounds((Nes_I.Main.Control.Width / 2) - 70, Nes_I.Main.Control.Height - 40, 140, 30);
  Nes_I.Main.Back.Text := 'Back';
  Nes_I.Main.Back.OnClick := ex_main.Input.mouse_script_consoles.Button.OnMouseClick;
  Nes_I.Main.Back.Visible := false;

  Nes_I.Main.Cancel := TButton.Create(Nes_I.Main.Panel);
  Nes_I.Main.Cancel.Name := 'Script_Nes_Install_Main_Cancel';
  Nes_I.Main.Cancel.Parent := Nes_I.Main.Panel;
  Nes_I.Main.Cancel.SetBounds(50, Nes_I.Main.Control.Height - 40, 140, 30);
  Nes_I.Main.Cancel.Text := 'Cancel';
  Nes_I.Main.Cancel.OnClick := ex_main.Input.mouse_script_consoles.Button.OnMouseClick;
  Nes_I.Main.Cancel.Visible := false;

  ShowButtons;
end;

procedure uEmulation_Consoles_Nes_Install_Free;
begin
  extrafe.prog.State := 'main_config_emulators';
  mainScene.Config.Main.Left_Blur.Enabled := false;
  mainScene.Config.Main.R.Emulators.Panel_Blur.Enabled := false;
  FreeAndNil(Nes_I.Panel);
  mainScene.Footer.Back_Blur.Enabled := false;
end;

procedure ShowButtons;
begin
  if Nes_I.Main.Status = 'phase_1' then
  begin
    Nes_I.Main.Next.Visible := True;
    Nes_I.Main.Back.Visible := false;
    Nes_I.Main.Cancel.Visible := True;
  end
  else if (Nes_I.Main.Status = 'phase_2') or (Nes_I.Main.Status = 'phase_3') or (Nes_I.Main.Status = 'phase_4_1') or
    (Nes_I.Main.Status = 'phase_4_2') then
  begin
    Nes_I.Main.Next.Visible := True;
    Nes_I.Main.Back.Visible := True;
    Nes_I.Main.Cancel.Visible := True;
  end
  else if Nes_I.Main.Status = 'final' then
  begin
    Nes_I.Main.Next.Visible := false;
    Nes_I.Main.Back.Visible := false;
    Nes_I.Main.Cancel.Visible := false;
  end;
end;

procedure uEmulation_Consoles_Nes_Slide_To_Next;
begin
  if Nes_I.Main.Status = 'phase_1' then
  begin
    Nes_I.Main.Control.SetActiveTabWithTransition(Nes_I.Main.Tabs[1], TTabTransition.Slide, TTabTransitionDirection.Normal);
    Nes_I.Main.Status := 'phase_2';
  end
  else if Nes_I.Main.Status = 'phase_2' then
  begin
    if Nes_I.Main.Choosen = 'Mame NES' then
    begin
      Nes_I.Main.Control.SetActiveTabWithTransition(Nes_I.Main.Tabs[2], TTabTransition.Slide, TTabTransitionDirection.Normal);
      Nes_I.Main.Status := 'phase_3';
    end
    else
      ShowMessage('Please Select an emulator with ready installation script');
  end
  else if Nes_I.Main.Status = 'phase_3' then
  begin
    if Nes_I.Main.Tab3.Radio_1.IsChecked then
    begin
      Nes_I.Main.Control.SetActiveTabWithTransition(Nes_I.Main.Tabs[3], TTabTransition.Slide, TTabTransitionDirection.Normal);
      Nes_I.Main.Status := 'phase_4_1';
    end
    else if Nes_I.Main.Tab3.Radio_2.IsChecked then
    begin
      Nes_I.Main.Control.SetActiveTabWithTransition(Nes_I.Main.Tabs[4], TTabTransition.Slide, TTabTransitionDirection.Normal);
      Nes_I.Main.Status := 'phase_4_2';
    end;
  end
  else if (Nes_I.Main.Status = 'phase_4_1') or (Nes_I.Main.Status = 'phase_4_2') then
  begin
    Nes_I.Main.Control.SetActiveTabWithTransition(Nes_I.Main.Tabs[5], TTabTransition.Slide, TTabTransitionDirection.Normal);
    Nes_I.Main.Status := 'final';
  end;
  ShowButtons;
end;

procedure uEmulation_Consoles_Nes_Slide_To_Previous;
begin
  if (Nes_I.Main.Status = 'phase_4_1') or (Nes_I.Main.Status = 'phase_4_2') then
  begin
    Nes_I.Main.Control.SetActiveTabWithTransition(Nes_I.Main.Tabs[2], TTabTransition.Slide, TTabTransitionDirection.Reversed);
    Nes_I.Main.Status := 'phase_3';
  end
  else if Nes_I.Main.Status = 'phase_3' then
  begin
    Nes_I.Main.Control.SetActiveTabWithTransition(Nes_I.Main.Tabs[1], TTabTransition.Slide, TTabTransitionDirection.Reversed);
    Nes_I.Main.Status := 'phase_2';
  end
  else if Nes_I.Main.Status = 'phase_2' then
  begin
    Nes_I.Main.Control.SetActiveTabWithTransition(Nes_I.Main.Tabs[0], TTabTransition.Slide, TTabTransitionDirection.Reversed);
    Nes_I.Main.Status := 'phase_1';
  end;
  ShowButtons;
end;

procedure Create_Tab1;
begin
  Nes_I.Main.Tab1.Box := TGroupBox.Create(Nes_I.Main.Tabs[0]);
  Nes_I.Main.Tab1.Box.Name := 'Script_Nes_Install_Main_Tab1_Box';
  Nes_I.Main.Tab1.Box.Parent := Nes_I.Main.Tabs[0];
  Nes_I.Main.Tab1.Box.SetBounds(10, 65, Nes_I.Main.Control.Width - 20, Nes_I.Main.Control.Height - 130);
  Nes_I.Main.Tab1.Box.Text := 'Welcome to ExtraFE wizard setup "Nes_I" emulator.';
  Nes_I.Main.Tab1.Box.Visible := True;

  Nes_I.Main.Tab1.Text := TALText.Create(Nes_I.Main.Tab1.Box);
  Nes_I.Main.Tab1.Text.Name := 'Script_Nes_Install_Main_Tab1_Text';
  Nes_I.Main.Tab1.Text.Parent := Nes_I.Main.Tab1.Box;
  Nes_I.Main.Tab1.Text.SetBounds(10, 40, Nes_I.Main.Tab1.Box.Width - 20, 60);
  Nes_I.Main.Tab1.Text.WordWrap := True;
  Nes_I.Main.Tab1.Text.TextIsHtml := True;
  Nes_I.Main.Tab1.Text.TextSettings.FontColor := TAlphaColorRec.White;
  Nes_I.Main.Tab1.Text.TextSettings.Font.Size := 14;
  Nes_I.Main.Tab1.Text.TextSettings.VertAlign := TTextAlign.Leading;
  Nes_I.Main.Tab1.Text.Text :=
    ' This action will "<font color="#ff63cbfc">install a Nes_I Emulator</font>" to "<font color="#ff63cbfc">ExtraFE</font>".' + #13#10 +
    ' If you wish to continue press next else press cancel.';
  Nes_I.Main.Tab1.Text.Visible := True;
end;

procedure Create_Tab2;
var
  vCount: Integer;
  vi: Integer;
begin
  Nes_I.Main.Tab2.Box := TGroupBox.Create(Nes_I.Main.Tabs[1]);
  Nes_I.Main.Tab2.Box.Name := 'Script_Nes_Install_Main_Tab2_Box';
  Nes_I.Main.Tab2.Box.Parent := Nes_I.Main.Tabs[1];
  Nes_I.Main.Tab2.Box.SetBounds(10, 65, Nes_I.Main.Control.Width - 20, Nes_I.Main.Control.Height - 130);
  Nes_I.Main.Tab2.Box.Text := 'Choose an emulator.';
  Nes_I.Main.Tab2.Box.Visible := True;

  Nes_I.Main.Tab2.List := TListBox.Create(Nes_I.Main.Tab2.Box);
  Nes_I.Main.Tab2.List.Name := 'Script_Nes_Install_Main_Tab2_Listbox';
  Nes_I.Main.Tab2.List.Parent := Nes_I.Main.Tab2.Box;
  Nes_I.Main.Tab2.List.SetBounds(10, 20, 250, Nes_I.Main.Tab2.Box.Height - 30);
  Nes_I.Main.Tab2.List.ItemIndex := -1;
  Nes_I.Main.Tab2.List.Visible := True;

  vCount := uDB.Query_Count(uDB.ExtraFE_Query_Local, 'consoles_nes_emus', '', '');

  SetLength(Nes_I.Main.Tab2.Items, vCount + 1);

  uDB.ExtraFE_Query_Local.Close;
  uDB.ExtraFE_Query_Local.SQL.Clear;
  uDB.ExtraFE_Query_Local.SQL.Text := 'SELECT Name FROM consoles_nes_emus ORDER BY Emu_ID Asc';
  uDB.ExtraFE_Query_Local.Open;

  vi := 0;
  while not uDB.ExtraFE_Query_Local.Eof do
  begin
    Nes_I.Main.Tab2.Items[vi] := TListBoxItem.Create(Nes_I.Main.Tab2.List);
    Nes_I.Main.Tab2.Items[vi].Name := 'Script_Nes_Install_Main_Tab2_Listbox_Item_' + vi.ToString;
    Nes_I.Main.Tab2.Items[vi].Parent := Nes_I.Main.Tab2.List;
    Nes_I.Main.Tab2.Items[vi].Text := uDB.ExtraFE_Query_Local.Fields[0].AsString;
    Nes_I.Main.Tab2.Items[vi].OnClick := ex_main.Input.mouse_script_consoles.ListBoxItem.OnClick;
    Nes_I.Main.Tab2.Items[vi].Visible := True;

    inc(vi);
    uDB.ExtraFE_Query_Local.Next;
  end;

  Nes_I.Main.Tab2.Image := TImage.Create(Nes_I.Main.Tab2.Box);
  Nes_I.Main.Tab2.Image.Name := 'Script_Nes_Install_Main_Tab2_Image';
  Nes_I.Main.Tab2.Image.Parent := Nes_I.Main.Tab2.Box;
  Nes_I.Main.Tab2.Image.SetBounds(280, 20, 380, 180);
  Nes_I.Main.Tab2.Image.WrapMode := TImageWrapMode.Fit;
  Nes_I.Main.Tab2.Image.Visible := True;

  Nes_I.Main.Tab2.Memo := TMemo.Create(Nes_I.Main.Tab2.Box);
  Nes_I.Main.Tab2.Memo.Name := 'Script_Nes_Install_Main_Tab2_Memo';
  Nes_I.Main.Tab2.Memo.Parent := Nes_I.Main.Tab2.Box;
  Nes_I.Main.Tab2.Memo.SetBounds(280, 215, 380, 90);
  Nes_I.Main.Tab2.Memo.WordWrap := True;
  Nes_I.Main.Tab2.Memo.Text := '';
  Nes_I.Main.Tab2.Memo.Visible := True;

  Nes_I.Main.Tab2.Status := TALText.Create(Nes_I.Main.Tab2.Box);
  Nes_I.Main.Tab2.Status.Name := 'Script_Nes_Install_Main_Tab2_Status';
  Nes_I.Main.Tab2.Status.Parent := Nes_I.Main.Tab2.Box;
  Nes_I.Main.Tab2.Status.SetBounds(Nes_I.Main.Tab2.Box.Width - 220, Nes_I.Main.Tab2.Box.Height - 40, 200, 30);
  Nes_I.Main.Tab2.Status.TextIsHtml := True;
  Nes_I.Main.Tab2.Status.Color := TAlphaColorRec.White;
  Nes_I.Main.Tab2.Status.Text := '';
  Nes_I.Main.Tab2.Status.TextSettings.HorzAlign := TTextAlign.Trailing;
  Nes_I.Main.Tab2.Status.Visible := True;

end;

procedure uEmulation_Consoles_Nes_ShowEmulatorInfo(vName: String);
var
  vImg: FMX.Graphics.TBitmap;
  vText: String;
  vStatus: String;
begin

  uDB.ExtraFE_Query_Local.Close;
  uDB.ExtraFE_Query_Local.SQL.Clear;
  uDB.ExtraFE_Query_Local.SQL.Text := 'SELECT * FROM consoles_nes_emus WHERE Name=''' + vName + '''';
  uDB.ExtraFE_Query_Local.Open;

  vImg := FMX.Graphics.TBitmap.Create;

  vImg.Assign(uDB.ExtraFE_Query_Local.FieldByName('Image'));

  vText := uDB.ExtraFE_Query_Local.FieldByName('Text').AsString;
  vStatus := uDB.ExtraFE_Query_Local.FieldByName('Status').AsString;
  if vStatus <> 'Full' then
    Nes_I.Main.Next.Enabled := False
  else
    Nes_I.Main.Next.Enabled := True;

  vStatus := 'Status : ' + vStatus;

  Nes_I.Main.Tab2.Image.Bitmap := vImg;
  Nes_I.Main.Tab2.Memo.Text := vText;
  Nes_I.Main.Tab2.Status.Text := vStatus;

  Nes_I.Main.Tab3.Radio_1.Text := 'Install "' + Nes_I.Main.Choosen + '" to ExtaFE from computer';
  Nes_I.Main.Tab3.Radio_2.Text := 'Install "' + Nes_I.Main.Choosen + '" to ExtaFE from "ExtraFE Server".';
  Nes_I.Main.Tab4_1.Box.Text := 'Install "' + Nes_I.Main.Choosen + '" from computer.';
  Nes_I.Main.Tab4_1.Edit_Info.Text := 'Find the executable file of  "' + Nes_I.Main.Choosen + '" emulator.';
  Nes_I.Main.Tab5.Text.Text := ' Installation of "<font color="#ff63cbfc">' + Nes_I.Main.Choosen + '</font>" is completed.' + #13#10 +
    '   Close and enjoy the thousands retro games of Nintendo NES.' + #13#10 + '   P.S. You must have the roms to play, ExtraFE provide no roms.';
end;

procedure Create_Tab3;
begin
  Nes_I.Main.Tab3.Box := TGroupBox.Create(Nes_I.Main.Tabs[2]);
  Nes_I.Main.Tab3.Box.Name := 'Script_Nes_Install_Main_Tab3_Box';
  Nes_I.Main.Tab3.Box.Parent := Nes_I.Main.Tabs[2];
  Nes_I.Main.Tab3.Box.SetBounds(10, 10, Nes_I.Main.Control.Width - 20, 200);
  Nes_I.Main.Tab3.Box.Text := 'Please choose installation type.';
  Nes_I.Main.Tab3.Box.Visible := True;

  Nes_I.Main.Tab3.Radio_1 := TRadioButton.Create(Nes_I.Main.Tab3.Box);
  Nes_I.Main.Tab3.Radio_1.Name := 'Script_Nes_Install_Main_Tab3_Radio_1';
  Nes_I.Main.Tab3.Radio_1.Parent := Nes_I.Main.Tab3.Box;
  Nes_I.Main.Tab3.Radio_1.SetBounds(20, 30, 400, 24);
  Nes_I.Main.Tab3.Radio_1.OnClick := ex_main.Input.mouse_script_arcade.Radio.OnMouseClick;
  Nes_I.Main.Tab3.Radio_1.Visible := True;

  Nes_I.Main.Tab3.Radio_2 := TRadioButton.Create(Nes_I.Main.Tab3.Box);
  Nes_I.Main.Tab3.Radio_2.Name := 'Script_Nes_Install_Main_Tab3__Radio_2';
  Nes_I.Main.Tab3.Radio_2.Parent := Nes_I.Main.Tab3.Box;
  Nes_I.Main.Tab3.Radio_2.SetBounds(20, 90, 400, 24);
  Nes_I.Main.Tab3.Radio_2.OnClick := ex_main.Input.mouse_script_arcade.Radio.OnMouseClick;
  Nes_I.Main.Tab3.Radio_2.Visible := True;
end;

procedure Create_Tab4_1;
begin
  Nes_I.Main.Tab4_1.Box := TGroupBox.Create(Nes_I.Main.Tabs[3]);
  Nes_I.Main.Tab4_1.Box.Name := 'Script_Nes_Install_Main_Tab4_Computer_Box';
  Nes_I.Main.Tab4_1.Box.Parent := Nes_I.Main.Tabs[3];
  Nes_I.Main.Tab4_1.Box.SetBounds(10, 10, Nes_I.Main.Control.Width - 20, 200);
  Nes_I.Main.Tab4_1.Box.Visible := True;

  Nes_I.Main.Tab4_1.Edit_Info := TLabel.Create(Nes_I.Main.Tab4_1.Box);
  Nes_I.Main.Tab4_1.Edit_Info.Name := 'Script_Nes_Install_Main_Tab4_EditLabel';
  Nes_I.Main.Tab4_1.Edit_Info.Parent := Nes_I.Main.Tab4_1.Box;
  Nes_I.Main.Tab4_1.Edit_Info.SetBounds(20, 40, 300, 24);
  Nes_I.Main.Tab4_1.Edit_Info.TextSettings.Font.Style := Nes_I.Main.Tab4_1.Edit_Info.TextSettings.Font.Style + [TFontStyle.fsBold];
  Nes_I.Main.Tab4_1.Edit_Info.Visible := True;

  Nes_I.Main.Tab4_1.Open_Dialog := TOpenDialog.Create(Nes_I.Main.Tab4_1.Box);
  Nes_I.Main.Tab4_1.Open_Dialog.Name := 'Script_Nes_Install_Main_Tab4_OpenDialog';
  Nes_I.Main.Tab4_1.Open_Dialog.Parent := Nes_I.Main.Tab4_1.Box;
  Nes_I.Main.Tab4_1.Open_Dialog.FileName := '';
  Nes_I.Main.Tab4_1.Open_Dialog.Filter := 'Mame64|mame64.exe|Mame32|mame.exe|Mame64, Mame32|mame64.exe; mame.exe';
  Nes_I.Main.Tab4_1.Open_Dialog.OnClose := Nes_I.Main.Dialog.OnClose;

  Nes_I.Main.Tab4_1.Edit := TEdit.Create(Nes_I.Main.Tab4_1.Box);
  Nes_I.Main.Tab4_1.Edit.Name := 'Script_Nes_Install_Main_Tab4_Edit';
  Nes_I.Main.Tab4_1.Edit.Parent := Nes_I.Main.Tab4_1.Box;
  Nes_I.Main.Tab4_1.Edit.SetBounds(20, 60, Nes_I.Main.Tab4_1.Box.Width - 80, 26);
  Nes_I.Main.Tab4_1.Edit.Text := '';
  Nes_I.Main.Tab4_1.Edit.ReadOnly := True;
  Nes_I.Main.Tab4_1.Edit.Caret.Color := TAlphaColorRec.DeepSkyBlue;
  Nes_I.Main.Tab4_1.Edit.Visible := True;

  Nes_I.Main.Tab4_1.Find := TButton.Create(Nes_I.Main.Tab4_1.Box);
  Nes_I.Main.Tab4_1.Find.Name := 'Script_Nes_Install_Main_Tab4_Find';
  Nes_I.Main.Tab4_1.Find.Parent := Nes_I.Main.Tab4_1.Box;
  Nes_I.Main.Tab4_1.Find.SetBounds(Nes_I.Main.Tab4_1.Box.Width - 60, 60, 50, 26);
  Nes_I.Main.Tab4_1.Find.Text := 'Find';
  Nes_I.Main.Tab4_1.Find.OnClick := ex_main.Input.mouse_script_consoles.Button.OnMouseClick;
  Nes_I.Main.Tab4_1.Find.Visible := True;

  Nes_I.Main.Tab4_1.Progress := TProgressBar.Create(Nes_I.Main.Tab4_1.Box);
  Nes_I.Main.Tab4_1.Progress.Name := 'Script_Nes_Install_Main_Tab4_Progress';
  Nes_I.Main.Tab4_1.Progress.Parent := Nes_I.Main.Tab4_1.Box;
  Nes_I.Main.Tab4_1.Progress.SetBounds(20, 60, Nes_I.Main.Tab4_1.Box.Width - 40, 26);
  Nes_I.Main.Tab4_1.Progress.Min := 0;
  Nes_I.Main.Tab4_1.Progress.Max := 100;
  Nes_I.Main.Tab4_1.Progress.Value := 0;
  Nes_I.Main.Tab4_1.Progress.Visible := false;

  Nes_I.Main.Tab4_1.Start := TButton.Create(Nes_I.Main.Tab4_1.Box);
  Nes_I.Main.Tab4_1.Start.Name := 'Script_Nes_Install_Main_Tab4_Start';
  Nes_I.Main.Tab4_1.Start.Parent := Nes_I.Main.Tab4_1.Box;
  Nes_I.Main.Tab4_1.Start.SetBounds(30, 120, 200, 26);
  Nes_I.Main.Tab4_1.Start.Text := 'Start the installation.';
  Nes_I.Main.Tab4_1.Start.OnClick := ex_main.Input.mouse_script_consoles.Button.OnMouseClick;
  Nes_I.Main.Tab4_1.Start.Visible := false;
end;

procedure Create_Tab4_2;
begin

end;

procedure Create_Tab5;
begin
  Nes_I.Main.Tab5.Box := TGroupBox.Create(Nes_I.Main.Tabs[5]);
  Nes_I.Main.Tab5.Box.Name := 'Script_Nes_Install_Main_Tab5_Box';
  Nes_I.Main.Tab5.Box.Parent := Nes_I.Main.Tabs[5];
  Nes_I.Main.Tab5.Box.SetBounds(10, 10, Nes_I.Main.Control.Width - 20, 200);
  Nes_I.Main.Tab5.Box.Text := 'Congratulatinos';
  Nes_I.Main.Tab5.Box.Visible := True;

  Nes_I.Main.Tab5.Text := TALText.Create(Nes_I.Main.Tab5.Box);
  Nes_I.Main.Tab5.Text.Name := 'Script_Nes_Install_Main_Tab5_Text';
  Nes_I.Main.Tab5.Text.Parent := Nes_I.Main.Tab5.Box;
  Nes_I.Main.Tab5.Text.SetBounds(10, 40, Nes_I.Main.Tab5.Box.Width - 20, 60);
  Nes_I.Main.Tab5.Text.WordWrap := True;
  Nes_I.Main.Tab5.Text.TextIsHtml := True;
  Nes_I.Main.Tab5.Text.TextSettings.FontColor := TAlphaColorRec.White;
  Nes_I.Main.Tab5.Text.TextSettings.Font.Size := 14;
  Nes_I.Main.Tab5.Text.TextSettings.VertAlign := TTextAlign.Leading;
  Nes_I.Main.Tab5.Text.Visible := True;

  Nes_I.Main.Tab5.Close := TButton.Create(Nes_I.Main.Tab5.Box);
  Nes_I.Main.Tab5.Close.Name := 'Script_Nes_Install_Main_Tab5_Close';
  Nes_I.Main.Tab5.Close.Parent := Nes_I.Main.Tab5.Box;
  Nes_I.Main.Tab5.Close.SetBounds((Nes_I.Main.Control.Width / 2) - 70, Nes_I.Main.Control.Height - 80, 140, 40);
  Nes_I.Main.Tab5.Close.Text := 'Close and enjoy';
  Nes_I.Main.Tab5.Close.OnClick := ex_main.Input.mouse_script_consoles.Button.OnMouseClick;
  Nes_I.Main.Tab5.Close.Visible := True;
end;

procedure uEmulation_Consoles_Nes_Installation;
begin
  Nes_I.Main.Tab4_1.Edit.Visible := false;
  Nes_I.Main.Tab4_1.Progress.Visible := True;
  Nes_I.Main.Back.Enabled := false;
  Nes_I.Main.Cancel.Enabled := false;
  Nes_I.Main.Next.Enabled := false;
  Nes_I.Main.Tab4_1.Start.Visible := false;
  Nes_I.Main.Tab4_1.Find.Visible := false;
  Nes_I.Main.Tab4_1.Edit_Info.Text := 'Start the installation.';

  nes.Mame.Name := ExtractFileName(Nes_I.Main.Tab4_1.Edit.Text);
  nes.Mame.Path := ExtractFilePath(Nes_I.Main.Tab4_1.Edit.Text);

  // Create mame ini if dont exist
  if not FileExists(nes.Mame.Path + 'mame.ini') then
    ShellExecute(0, nil, 'cmd.exe', PChar('/C ' + AnsiQuotedStr(nes.Mame.Path + nes.Mame.Name, Char(34)) + ' -cc'), PChar(nes.Mame.Path), SW_HIDE);
  nes.Mame.p_Ini_Path := nes.Mame.Path;

  Nes_I.Main.Tab4_1.Progress.Value := 20;
  Application.ProcessMessages;

  nes.Mame.Database := extrafe.prog.Path + 'emu\consoles\nes\database\';
  ShellExecute(0, nil, 'cmd.exe', PChar('/C ' + AnsiQuotedStr(nes.Mame.Path + nes.Mame.Name, Char(34)) + ' nes -glist > ' + nes.Mame.Database +
    'mame_data_games.xml'), nil, SW_HIDE);

  Nes_I.Main.Tab4_1.Progress.Value := 40;
  Application.ProcessMessages;

  if emulation.Level = 0 then
    emulation.Selection_Tab[2].Logo_Gray.Enabled := false;
  inc(emulation.Category[2].Second_Level, 1);
  Nes_I.Main.Tab4_1.Progress.Value := 100;
  Nes_I.Main.Tab4_1.Edit_Info.Text := 'Installation complete. Click next to start using it.';

  emulation.emu[2, 8] := 'active';
  emulation.Consoles[8].Installed := True;

  // Clear and create the main control tab
  uMain_Emulation.Clear_Selection_Control;
  uMain_Emulation.Create_Selection_Control;
  uMain_Emulation.Category(2, 0);

  FreeAndNil(mainScene.Config.Main.R.Emulators.Consoles[8].Panel);
  uMain_Config_Emulators.CreateConsolesPanel(8);

  Nes_I.Main.Cancel.Visible := false;
  Nes_I.Main.Back.Visible := false;
  Nes_I.Main.Next.Enabled := True;
end;

{ TMAIN_NES_INSTALL_DIALOG }

procedure TMAIN_NES_INSTALL_DIALOG.OnClose(Sender: TObject);
begin
  Nes_I.Main.Emu_Path := Nes_I.Main.Tab4_1.Open_Dialog.FileName;
  Nes_I.Main.Tab4_1.Start.Visible := True;
  Nes_I.Main.Tab4_1.Edit.Text := Nes_I.Main.Emu_Path;
end;

initialization

Nes_I.Main.Dialog := TMAIN_NES_INSTALL_DIALOG.Create;

finalization

Nes_I.Main.Dialog.Free;

end.
