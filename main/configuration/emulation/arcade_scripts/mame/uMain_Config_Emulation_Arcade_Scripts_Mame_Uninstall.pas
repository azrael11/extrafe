unit uMain_Config_Emulation_Arcade_Scripts_Mame_Uninstall;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.TabControl,
  FMX.Types,
  ALFMXObjects;

type
  TEMU_MAME_UNINSTALL_MAIN_TAB1 = record
    Box: TGroupBox;
    Text: TALText;
    Cancel: TButton;
    Next: TButton;
  end;

type
  TEMU_MAME_UNINSTALL_MAIN_TAB2 = record
    Box: TGroupBox;
    Check_1: TCheckBox;
    Check_2: TCheckBox;
    Check_3: TCheckBox;
    Cancel: TButton;
    Back: TButton;
    Next: TButton;
  end;

type
  TEMU_MAME_UNINSTALL_MAIN = record
    Panel: TPanel;
    Control: TTabControl;
    Tabs: array [0 .. 1] of TTabItem;
    Tab1: TEMU_MAME_UNINSTALL_MAIN_TAB1;
    Tab2: TEMU_MAME_UNINSTALL_MAIN_TAB2;
  end;

type
  TEMU_MAME_UNINSTALL_HEADER = record
    Panel: TPanel;
    Icon: TImage;
    Text: TLabel;
  end;

type
  TEMU_MAME_UNINSTALL = record
    Panel: TPanel;
    Header: TEMU_MAME_UNINSTALL_HEADER;
    Main: TEMU_MAME_UNINSTALL_MAIN;
  end;

procedure uEmulation_Arcade_Mame_Uninstall;
procedure uEmulation_Arcade_Mame_Uninstall_Free;

procedure uEmulation_Arcade_Mame_Uninstall_CreateTab1;
procedure uEmulation_Arcade_Mame_Uninstall_CreateTab2;

procedure uEmulation_Arcade_Mame_Uninstall_Remove;

var
  Script_Mame_Uninstall: TEMU_MAME_UNINSTALL;

implementation

uses
  uLoad_AllTypes,
  Main,
  uMain_Emulation,
  uMain_AllTypes,
  uMain_Config_Emulators,
  uMain_Config_Emulation_Arcade_Scripts_Mouse,
  uWindows,
  uLoad_Emulation;

procedure uEmulation_Arcade_Mame_Uninstall;
var
  vi: Integer;
begin
  extrafe.prog.State := 'main_config_uninstall';

  mainScene.Config.Main.Left_Blur.Enabled := True;
  mainScene.Config.Main.R.Emulators.Panel_Blur.Enabled := True;

  Script_Mame_Uninstall.Panel := TPanel.Create(Main_Form);
  Script_Mame_Uninstall.Panel.Name := 'Script_Mame_Uninstall';
  Script_Mame_Uninstall.Panel.Parent := Main_Form;
  Script_Mame_Uninstall.Panel.Width := 600;
  Script_Mame_Uninstall.Panel.Height := 350;
  Script_Mame_Uninstall.Panel.Position.X := extrafe.res.Half_Width - 300;
  Script_Mame_Uninstall.Panel.Position.Y := extrafe.res.Half_Height - 175;
  Script_Mame_Uninstall.Panel.Visible := True;

  Script_Mame_Uninstall.Header.Panel := TPanel.Create(Script_Mame_Uninstall.Panel);
  Script_Mame_Uninstall.Header.Panel.Name := 'Script_Mame_Uninstall_Header';
  Script_Mame_Uninstall.Header.Panel.Parent := Script_Mame_Uninstall.Panel;
  Script_Mame_Uninstall.Header.Panel.Width := Script_Mame_Uninstall.Panel.Width;
  Script_Mame_Uninstall.Header.Panel.Height := 30;
  Script_Mame_Uninstall.Header.Panel.Position.X := 0;
  Script_Mame_Uninstall.Header.Panel.Position.Y := 0;
  Script_Mame_Uninstall.Header.Panel.Visible := True;

  Script_Mame_Uninstall.Header.Icon := TImage.Create(Script_Mame_Uninstall.Header.Panel);
  Script_Mame_Uninstall.Header.Icon.Name := 'Script_Mame_Uninstall_Header_Icon';
  Script_Mame_Uninstall.Header.Icon.Parent := Script_Mame_Uninstall.Header.Panel;
  Script_Mame_Uninstall.Header.Icon.Width := 24;
  Script_Mame_Uninstall.Header.Icon.Height := 24;
  Script_Mame_Uninstall.Header.Icon.Position.X := 6;
  Script_Mame_Uninstall.Header.Icon.Position.Y := 3;
  Script_Mame_Uninstall.Header.Icon.Bitmap.LoadFromFile(ex_main.Paths.Config_Images + 'emu\arcade\mame.png');
  Script_Mame_Uninstall.Header.Icon.WrapMode := TImageWrapMode.Fit;
  Script_Mame_Uninstall.Header.Icon.Visible := True;

  Script_Mame_Uninstall.Header.Text := TLabel.Create(Script_Mame_Uninstall.Header.Panel);
  Script_Mame_Uninstall.Header.Text.Name := 'Script_Mame_Uninstall_Header_Text';
  Script_Mame_Uninstall.Header.Text.Parent := Script_Mame_Uninstall.Header.Panel;
  Script_Mame_Uninstall.Header.Text.Width := 300;
  Script_Mame_Uninstall.Header.Text.Height := 24;
  Script_Mame_Uninstall.Header.Text.Position.X := 36;
  Script_Mame_Uninstall.Header.Text.Position.Y := 3;
  Script_Mame_Uninstall.Header.Text.Text := 'Uninstall Mame from ExtraFE.';
  Script_Mame_Uninstall.Header.Text.TextSettings.Font.Style :=
    Script_Mame_Uninstall.Header.Text.TextSettings.Font.Style + [TFontStyle.fsBold];
  Script_Mame_Uninstall.Header.Text.Visible := True;

  Script_Mame_Uninstall.Main.Panel := TPanel.Create(Script_Mame_Uninstall.Panel);
  Script_Mame_Uninstall.Main.Panel.Name := 'Script_Mame_Uninstall_Main';
  Script_Mame_Uninstall.Main.Panel.Parent := Script_Mame_Uninstall.Panel;
  Script_Mame_Uninstall.Main.Panel.Width := Script_Mame_Uninstall.Panel.Width;
  Script_Mame_Uninstall.Main.Panel.Height := Script_Mame_Uninstall.Panel.Height - 30;
  Script_Mame_Uninstall.Main.Panel.Position.X := 0;
  Script_Mame_Uninstall.Main.Panel.Position.Y := 30;
  Script_Mame_Uninstall.Main.Panel.Visible := True;

  Script_Mame_Uninstall.Main.Control := TTabControl.Create(Script_Mame_Uninstall.Main.Panel);
  Script_Mame_Uninstall.Main.Control.Name := 'Script_Mame_Uninstall_Main_Control';
  Script_Mame_Uninstall.Main.Control.Parent := Script_Mame_Uninstall.Main.Panel;
  Script_Mame_Uninstall.Main.Control.Align := TAlignLayout.Client;
  Script_Mame_Uninstall.Main.Control.TabPosition := TTabPosition.None;
  Script_Mame_Uninstall.Main.Control.Visible := True;

  for vi := 0 to 1 do
  begin
    Script_Mame_Uninstall.Main.Tabs[vi] := TTabItem.Create(Script_Mame_Uninstall.Main.Control);
    Script_Mame_Uninstall.Main.Tabs[vi].Name := 'Script_Mame_Uninstall_Main_Tab_' + vi.ToString;
    Script_Mame_Uninstall.Main.Tabs[vi].Parent := Script_Mame_Uninstall.Main.Control;
    Script_Mame_Uninstall.Main.Tabs[vi].Width := Script_Mame_Uninstall.Main.Control.Width;
    Script_Mame_Uninstall.Main.Tabs[vi].Height := Script_Mame_Uninstall.Main.Control.Height;
    Script_Mame_Uninstall.Main.Tabs[vi].Visible := True;
  end;

  uEmulation_Arcade_Mame_Uninstall_CreateTab1;
  uEmulation_Arcade_Mame_Uninstall_CreateTab2;
end;

procedure uEmulation_Arcade_Mame_Uninstall_CreateTab1;
begin
  Script_Mame_Uninstall.Main.Tab1.Box := TGroupBox.Create(Script_Mame_Uninstall.Main.Tabs[0]);
  Script_Mame_Uninstall.Main.Tab1.Box.Name := 'Script_Mame_Uninstall_Main_Tab1_Box';
  Script_Mame_Uninstall.Main.Tab1.Box.Parent := Script_Mame_Uninstall.Main.Tabs[0];
  Script_Mame_Uninstall.Main.Tab1.Box.Width := Script_Mame_Uninstall.Main.Control.Width - 20;
  Script_Mame_Uninstall.Main.Tab1.Box.Height := 200;
  Script_Mame_Uninstall.Main.Tab1.Box.Position.X := 10;
  Script_Mame_Uninstall.Main.Tab1.Box.Position.Y := 10;
  Script_Mame_Uninstall.Main.Tab1.Box.Text := 'Information.';
  Script_Mame_Uninstall.Main.Tab1.Box.Visible := True;

  Script_Mame_Uninstall.Main.Tab1.Text := TALText.Create(Script_Mame_Uninstall.Main.Tab1.Box);
  Script_Mame_Uninstall.Main.Tab1.Text.Name := 'Script_Mame_Uninstall_Main_Tab1_Text';
  Script_Mame_Uninstall.Main.Tab1.Text.Parent := Script_Mame_Uninstall.Main.Tab1.Box;
  Script_Mame_Uninstall.Main.Tab1.Text.Width := Script_Mame_Uninstall.Main.Tab1.Box.Width - 20;
  Script_Mame_Uninstall.Main.Tab1.Text.Height := 60;
  Script_Mame_Uninstall.Main.Tab1.Text.Position.X := 10;
  Script_Mame_Uninstall.Main.Tab1.Text.Position.Y := 40;
  Script_Mame_Uninstall.Main.Tab1.Text.WordWrap := True;
  Script_Mame_Uninstall.Main.Tab1.Text.TextIsHtml := True;
  Script_Mame_Uninstall.Main.Tab1.Text.TextSettings.FontColor := TAlphaColorRec.White;
  Script_Mame_Uninstall.Main.Tab1.Text.TextSettings.Font.Size := 14;
  Script_Mame_Uninstall.Main.Tab1.Text.TextSettings.VertAlign := TTextAlign.Leading;
  Script_Mame_Uninstall.Main.Tab1.Text.Text :=
    ' This action will "<font color="#ff63cbfc">uninstall mame</font>" from "<font color="#ff63cbfc">ExtraFE</font>".'
    + #13#10 + ' If you wish to continue press next else press cancel.';
  Script_Mame_Uninstall.Main.Tab1.Text.Visible := True;

  Script_Mame_Uninstall.Main.Tab1.Next := TButton.Create(Script_Mame_Uninstall.Main.Tabs[0]);
  Script_Mame_Uninstall.Main.Tab1.Next.Name := 'Script_Mame_Uninstall_Main_Tab1_Next';
  Script_Mame_Uninstall.Main.Tab1.Next.Parent := Script_Mame_Uninstall.Main.Tabs[0];
  Script_Mame_Uninstall.Main.Tab1.Next.Width := 140;
  Script_Mame_Uninstall.Main.Tab1.Next.Height := 40;
  Script_Mame_Uninstall.Main.Tab1.Next.Position.X := Script_Mame_Uninstall.Main.Control.Width - 190;
  Script_Mame_Uninstall.Main.Tab1.Next.Position.Y := Script_Mame_Uninstall.Main.Control.Height - 50;
  Script_Mame_Uninstall.Main.Tab1.Next.Text := 'Next';
  Script_Mame_Uninstall.Main.Tab1.Next.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Uninstall.Main.Tab1.Next.Visible := True;

  Script_Mame_Uninstall.Main.Tab1.Cancel := TButton.Create(Script_Mame_Uninstall.Main.Tabs[0]);
  Script_Mame_Uninstall.Main.Tab1.Cancel.Name := 'Script_Mame_Uninstall_Main_Tab1_Cancel';
  Script_Mame_Uninstall.Main.Tab1.Cancel.Parent := Script_Mame_Uninstall.Main.Tabs[0];
  Script_Mame_Uninstall.Main.Tab1.Cancel.Width := 140;
  Script_Mame_Uninstall.Main.Tab1.Cancel.Height := 40;
  Script_Mame_Uninstall.Main.Tab1.Cancel.Position.X := 50;
  Script_Mame_Uninstall.Main.Tab1.Cancel.Position.Y := Script_Mame_Uninstall.Main.Control.Height - 50;
  Script_Mame_Uninstall.Main.Tab1.Cancel.Text := 'Cancel';
  Script_Mame_Uninstall.Main.Tab1.Cancel.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Uninstall.Main.Tab1.Cancel.Visible := True;

end;

procedure uEmulation_Arcade_Mame_Uninstall_CreateTab2;
begin
  Script_Mame_Uninstall.Main.Tab2.Box := TGroupBox.Create(Script_Mame_Uninstall.Main.Tabs[1]);
  Script_Mame_Uninstall.Main.Tab2.Box.Name := 'Script_Mame_Uninstall_Main_Tab2_Box';
  Script_Mame_Uninstall.Main.Tab2.Box.Parent := Script_Mame_Uninstall.Main.Tabs[1];
  Script_Mame_Uninstall.Main.Tab2.Box.Width := Script_Mame_Uninstall.Main.Control.Width - 20;
  Script_Mame_Uninstall.Main.Tab2.Box.Height := 200;
  Script_Mame_Uninstall.Main.Tab2.Box.Position.X := 10;
  Script_Mame_Uninstall.Main.Tab2.Box.Position.Y := 10;
  Script_Mame_Uninstall.Main.Tab2.Box.Text := 'Uninstall options.';
  Script_Mame_Uninstall.Main.Tab2.Box.Visible := True;

  Script_Mame_Uninstall.Main.Tab2.Check_1 := TCheckBox.Create(Script_Mame_Uninstall.Main.Tab2.Box);
  Script_Mame_Uninstall.Main.Tab2.Check_1.Name := 'Script_Mame_Uninstall_Main_Tab2_Check_1';
  Script_Mame_Uninstall.Main.Tab2.Check_1.Parent := Script_Mame_Uninstall.Main.Tab2.Box;
  Script_Mame_Uninstall.Main.Tab2.Check_1.Width := 300;
  Script_Mame_Uninstall.Main.Tab2.Check_1.Height := 24;
  Script_Mame_Uninstall.Main.Tab2.Check_1.Position.X := 20;
  Script_Mame_Uninstall.Main.Tab2.Check_1.Position.Y := 30;
  Script_Mame_Uninstall.Main.Tab2.Check_1.Text := 'Remove Mame emulator from ExtraFE.';
  Script_Mame_Uninstall.Main.Tab2.Check_1.IsChecked := True;
  Script_Mame_Uninstall.Main.Tab2.Check_1.Enabled := False;
  Script_Mame_Uninstall.Main.Tab2.Check_1.Visible := True;

  Script_Mame_Uninstall.Main.Tab2.Check_2 := TCheckBox.Create(Script_Mame_Uninstall.Main.Tab2.Box);
  Script_Mame_Uninstall.Main.Tab2.Check_2.Name := 'Script_Mame_Uninstall_Main_Tab2_Check_2';
  Script_Mame_Uninstall.Main.Tab2.Check_2.Parent := Script_Mame_Uninstall.Main.Tab2.Box;
  Script_Mame_Uninstall.Main.Tab2.Check_2.Width := 300;
  Script_Mame_Uninstall.Main.Tab2.Check_2.Height := 24;
  Script_Mame_Uninstall.Main.Tab2.Check_2.Position.X := 20;
  Script_Mame_Uninstall.Main.Tab2.Check_2.Position.Y := 60;
  Script_Mame_Uninstall.Main.Tab2.Check_2.Text := 'Remove favorites, categories, e.t.c.';
  Script_Mame_Uninstall.Main.Tab2.Check_2.Visible := True;

  Script_Mame_Uninstall.Main.Tab2.Check_3 := TCheckBox.Create(Script_Mame_Uninstall.Main.Tab2.Box);
  Script_Mame_Uninstall.Main.Tab2.Check_3.Name := 'Script_Mame_Uninstall_Main_Tab2_Check_3';
  Script_Mame_Uninstall.Main.Tab2.Check_3.Parent := Script_Mame_Uninstall.Main.Tab2.Box;
  Script_Mame_Uninstall.Main.Tab2.Check_3.Width := 300;
  Script_Mame_Uninstall.Main.Tab2.Check_3.Height := 24;
  Script_Mame_Uninstall.Main.Tab2.Check_3.Position.X := 20;
  Script_Mame_Uninstall.Main.Tab2.Check_3.Position.Y := 90;
  Script_Mame_Uninstall.Main.Tab2.Check_3.Text := 'Delete Mame folder and all subcategories.';
  Script_Mame_Uninstall.Main.Tab2.Check_3.IsChecked := False;
  Script_Mame_Uninstall.Main.Tab2.Check_3.Visible := True;

  Script_Mame_Uninstall.Main.Tab2.Next := TButton.Create(Script_Mame_Uninstall.Main.Tabs[1]);
  Script_Mame_Uninstall.Main.Tab2.Next.Name := 'Script_Mame_Uninstall_Main_Tab2_Next';
  Script_Mame_Uninstall.Main.Tab2.Next.Parent := Script_Mame_Uninstall.Main.Tabs[1];
  Script_Mame_Uninstall.Main.Tab2.Next.Width := 140;
  Script_Mame_Uninstall.Main.Tab2.Next.Height := 40;
  Script_Mame_Uninstall.Main.Tab2.Next.Position.X := Script_Mame_Uninstall.Main.Control.Width - 190;
  Script_Mame_Uninstall.Main.Tab2.Next.Position.Y := Script_Mame_Uninstall.Main.Control.Height - 50;
  Script_Mame_Uninstall.Main.Tab2.Next.Text := 'Next';
  Script_Mame_Uninstall.Main.Tab2.Next.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Uninstall.Main.Tab2.Next.Visible := True;

  Script_Mame_Uninstall.Main.Tab2.Back := TButton.Create(Script_Mame_Uninstall.Main.Tabs[1]);
  Script_Mame_Uninstall.Main.Tab2.Back.Name := 'Script_Mame_Uninstall_Main_Tab2_Back';
  Script_Mame_Uninstall.Main.Tab2.Back.Parent := Script_Mame_Uninstall.Main.Tabs[1];
  Script_Mame_Uninstall.Main.Tab2.Back.Width := 140;
  Script_Mame_Uninstall.Main.Tab2.Back.Height := 40;
  Script_Mame_Uninstall.Main.Tab2.Back.Position.X := (Script_Mame_Uninstall.Main.Control.Width / 2) - 70;
  Script_Mame_Uninstall.Main.Tab2.Back.Position.Y := Script_Mame_Uninstall.Main.Control.Height - 50;
  Script_Mame_Uninstall.Main.Tab2.Back.Text := 'Back';
  Script_Mame_Uninstall.Main.Tab2.Back.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Uninstall.Main.Tab2.Back.Visible := True;

  Script_Mame_Uninstall.Main.Tab2.Cancel := TButton.Create(Script_Mame_Uninstall.Main.Tabs[1]);
  Script_Mame_Uninstall.Main.Tab2.Cancel.Name := 'Script_Mame_Uninstall_Main_Tab2_Cancel';
  Script_Mame_Uninstall.Main.Tab2.Cancel.Parent := Script_Mame_Uninstall.Main.Tabs[1];
  Script_Mame_Uninstall.Main.Tab2.Cancel.Width := 140;
  Script_Mame_Uninstall.Main.Tab2.Cancel.Height := 40;
  Script_Mame_Uninstall.Main.Tab2.Cancel.Position.X := 50;
  Script_Mame_Uninstall.Main.Tab2.Cancel.Position.Y := Script_Mame_Uninstall.Main.Control.Height - 50;
  Script_Mame_Uninstall.Main.Tab2.Cancel.Text := 'Cancel';
  Script_Mame_Uninstall.Main.Tab2.Cancel.OnClick := ex_main.Input.mouse_script_arcade.Button.OnMouseClick;
  Script_Mame_Uninstall.Main.Tab2.Cancel.Visible := True;
end;

procedure uEmulation_Arcade_Mame_Uninstall_Free;
begin
  extrafe.prog.State := 'main_config';
  mainScene.Config.Main.Left_Blur.Enabled := False;
  mainScene.Config.Main.R.Emulators.Panel_Blur.Enabled := False;
  FreeAndNil(Script_Mame_Uninstall.Panel);
  mainScene.Footer.Back_Blur.Enabled:= False;
end;

///

procedure uEmulation_Arcade_Mame_Uninstall_Remove;
var
  vMame_Prog_Path: String;
  vMame_Prog_Data: String;
  vMame_Emu_Path: String;
begin
  vMame_Prog_Path:= emulation.Arcade[0].Prog_Path;
  vMame_Prog_Data:= vMame_Prog_Path+ 'database\';
  vMame_Emu_Path:= emulation.Arcade[0].Emu_Path;

  if Script_Mame_Uninstall.Main.Tab2.Check_2.IsChecked then
    uWindows_DeleteDirectory(vMame_Prog_Data, '*.*', False);
  if Script_Mame_Uninstall.Main.Tab2.Check_3.IsChecked then
    uWindows_DeleteDirectory(vMame_Emu_Path, '*.*', True);
  uWindows_DeleteDirectory(vMame_Prog_Path+ 'config\', '*.*', False );

  Dec(emulation.Unique_Num);
  Dec(emulation.Active_Num);

  emulation.Emu[0,0]:= 'nil';
  emulation.Arcade[0].Prog_Path:= '';
  emulation.Arcade[0].Emu_Path:= '';
  emulation.Arcade[0].Active:= False;
  emulation.Arcade[0].Active_Place:= -1;
  emulation.Arcade[0].Name:= '';
  emulation.Arcade[0].Menu_Image:= '';
  emulation.Arcade[0].Menu_Image_Path:= '';
  emulation.Arcade[0].Second_Level:= -1;
  emulation.Arcade[0].Installed:= False;
  emulation.Arcade[0].Unique_Num:= -1;

  uLoad_Emulation_SetTabs;

  uMain_Emulation_Clear_Selection_Control;
  uMain_Emulation_Create_Selection_Control;
  uMain_Emulation_Category(0);

  FreeAndNil(mainScene.Config.main.R.Emulators.Arcade[0].Panel);
  uMain_Config_Emulators_CreateArcadePanel(0);

  uEmulation_Arcade_Mame_Uninstall_Free;
end;

end.
