unit uMain_Config_Emulators;

interface

uses
  System.SysUtils,
  System.UITypes,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Layouts,
  FMX.Effects,
  FMX.Types,
  FMX.Filter.Effects,
  ALFMXObjects;

procedure Create;

procedure ShowCategory(vCategory: Integer);

procedure ShowArcade;
procedure CreateArcadePanel(vNum: Integer);

procedure ShowComputers;
procedure CreateComputersPanel(vNum: Integer);

procedure ShowConsoles;
procedure CreateConsolesPanel(vNum: Integer);

procedure ShowHandhelds;
procedure CreateHandheldsPanel(vNum: Integer);

procedure ShowPinballs;
procedure CreatePinballsPanel(vNum: Integer);

procedure Start_Emu_Wizard(vButton: TButton);

procedure Install_Emu(vEmu_Num: Integer; vEmu_Categorie: String);
procedure UnInstall_Emu(vEmu_Num: Integer; vEmu_Categorie: String);

implementation

uses
  uLoad_AllTypes,
  uDB_AUser,
  uMain_AllTypes,
  {Arcade}
  uMain_Config_Emulation_Arcade_Scripts_Mame_Install,
  uMain_Config_Emulation_Arcade_Scripts_Mame_Uninstall,
  {Computers}
  {Consoles}
  uMain_Config_Emulation_Consoles_Scripts_Nes_Install;
{ Handhelds }
{ Pinball }

procedure Create;
const
  cImages_Names: array [0 .. 4] of string = ('config_arcade.png', 'config_computers.png', 'config_consoles.png', 'config_handhelds.png', 'config_pinballs.png');
  cImages_Imagelist: array [0 .. 2] of string = ('config_computer.png', 'config_server.png', 'config_internet.png');
var
  vi: Integer;
begin

  extrafe.prog.State := 'main_config_emulators';

  mainScene.Config.main.R.Emulators.Panel := TPanel.Create(mainScene.Config.main.R.Panel[2]);
  mainScene.Config.main.R.Emulators.Panel.Name := 'Main_Config_Emulators_Main_Panel';
  mainScene.Config.main.R.Emulators.Panel.Parent := mainScene.Config.main.R.Panel[2];
  mainScene.Config.main.R.Emulators.Panel.Align := TAlignLayout.Client;
  mainScene.Config.main.R.Emulators.Panel.Visible := True;

  mainScene.Config.main.R.Emulators.Panel_Blur := TGaussianBlurEffect.Create(mainScene.Config.main.R.Emulators.Panel);
  mainScene.Config.main.R.Emulators.Panel_Blur.Name := 'Main_Config_Emulators_Main_Blur';
  mainScene.Config.main.R.Emulators.Panel_Blur.Parent := mainScene.Config.main.R.Emulators.Panel;
  mainScene.Config.main.R.Emulators.Panel_Blur.BlurAmount := 0.2;
  mainScene.Config.main.R.Emulators.Panel_Blur.Enabled := False;

  mainScene.Config.main.R.Emulators.Groupbox := TGroupBox.Create(mainScene.Config.main.R.Emulators.Panel);
  mainScene.Config.main.R.Emulators.Groupbox.Name := 'Main_Config_Emulators_Groupbox';
  mainScene.Config.main.R.Emulators.Groupbox.Parent := mainScene.Config.main.R.Emulators.Panel;
  mainScene.Config.main.R.Emulators.Groupbox.SetBounds(10, 10, mainScene.Config.main.R.Emulators.Panel.Width - 20, 98);
  mainScene.Config.main.R.Emulators.Groupbox.Text := 'Categories';
  mainScene.Config.main.R.Emulators.Groupbox.Visible := True;

  for vi := 0 to 4 do
  begin
    mainScene.Config.main.R.Emulators.Images[vi] := TImage.Create(mainScene.Config.main.R.Emulators.Groupbox);
    mainScene.Config.main.R.Emulators.Images[vi].Name := 'Main_Config_Emulators_Image_' + IntToStr(vi);
    mainScene.Config.main.R.Emulators.Images[vi].Parent := mainScene.Config.main.R.Emulators.Groupbox;
    mainScene.Config.main.R.Emulators.Images[vi].SetBounds(4 + (vi * 118), 20, 70, 70);
    mainScene.Config.main.R.Emulators.Images[vi].Bitmap.LoadFromFile(ex_main.Paths.Config_Images.emu + cImages_Names[vi]);
    mainScene.Config.main.R.Emulators.Images[vi].WrapMode := TImageWrapMode.Fit;
    mainScene.Config.main.R.Emulators.Images[vi].OnClick := ex_main.input.mouse_config.Image.OnMouseClick;
    mainScene.Config.main.R.Emulators.Images[vi].OnMouseEnter := ex_main.input.mouse_config.Image.OnMouseEnter;
    mainScene.Config.main.R.Emulators.Images[vi].OnMouseLeave := ex_main.input.mouse_config.Image.OnMouseLeave;
    mainScene.Config.main.R.Emulators.Images[vi].Tag := vi;
    mainScene.Config.main.R.Emulators.Images[vi].Visible := True;

    mainScene.Config.main.R.Emulators.Images_Glow[vi] := TGlowEffect.Create(mainScene.Config.main.R.Emulators.Images[vi]);
    mainScene.Config.main.R.Emulators.Images_Glow[vi].Name := 'Main_Config_Emulators_Image_Glow_' + IntToStr(vi);
    mainScene.Config.main.R.Emulators.Images_Glow[vi].Parent := mainScene.Config.main.R.Emulators.Images[vi];
    mainScene.Config.main.R.Emulators.Images_Glow[vi].GlowColor := TAlphaColorRec.Deepskyblue;
    mainScene.Config.main.R.Emulators.Images_Glow[vi].Softness := 0.5;
    mainScene.Config.main.R.Emulators.Images_Glow[vi].Opacity := 0.9;
    mainScene.Config.main.R.Emulators.Images_Glow[vi].Enabled := False;
  end;

  mainScene.Config.main.R.Emulators.Dialog := TOpenDialog.Create(mainScene.Config.main.R.Emulators.Panel);
  mainScene.Config.main.R.Emulators.Dialog.Name := 'Main_Config_Emulators_Dialog';
  mainScene.Config.main.R.Emulators.Dialog.Parent := mainScene.Config.main.R.Emulators.Panel;
  mainScene.Config.main.R.Emulators.Dialog.FileName := '';
  mainScene.Config.main.R.Emulators.Dialog.OnClose := mainScene.Config.main.R.Emulators.Dialog_Object.OnClose;
end;

procedure ShowCategory(vCategory: Integer);
var
  vi: Integer;
begin
  for vi := 0 to 4 do
  begin
    if Assigned(mainScene.Config.main.R.Emulators.Panels[vi]) then
      FreeAndNil(mainScene.Config.main.R.Emulators.Panels[vi]);
  end;
  case vCategory of
    0:
      ShowArcade;
    1:
      ShowComputers;
    2:
      ShowConsoles;
    3:
      ShowHandhelds;
    4:
      ShowPinballs;
  end;
  ex_main.Config.Emulators_Active_Tab := vCategory;
end;

procedure CreateArcadePanel(vNum: Integer);
const
  cEmu_Names: array [0 .. 10] of string = ('Mame', 'Fba', 'Zinc', 'Daphne', 'Kronos', 'Raine', 'Model2', 'SuperModel', 'Demul', '', '');
  cEmu_Image_Names: array [0 .. 10] of string = ('mame.png', 'fba.png', 'zinc.png', 'daphne.png', 'kronos.png', 'raine.png', 'model2.png', 'supermodel.png',
    'demul.png', '', '');
var
  vInstalled: Boolean;
begin
  mainScene.Config.main.R.Emulators.Arcade[vNum].Panel := TPanel.Create(mainScene.Config.main.R.Emulators.ScrollBox[0]);
  mainScene.Config.main.R.Emulators.Arcade[vNum].Panel.Name := 'Main_Config_Emulators_Arcade_' + cEmu_Names[vNum] + '_Panel';
  mainScene.Config.main.R.Emulators.Arcade[vNum].Panel.Parent := mainScene.Config.main.R.Emulators.ScrollBox[0];
  mainScene.Config.main.R.Emulators.Arcade[vNum].Panel.SetBounds(5, 20 + (vNum * 110), mainScene.Config.main.R.Emulators.ScrollBox[0].Width - 25, 100);
  mainScene.Config.main.R.Emulators.Arcade[vNum].Panel.Visible := True;

  mainScene.Config.main.R.Emulators.Arcade[vNum].Panel_Image := TPanel.Create(mainScene.Config.main.R.Emulators.Arcade[vNum].Panel);
  mainScene.Config.main.R.Emulators.Arcade[vNum].Panel_Image.Name := 'Main_Config_Emulators_Arcade_' + cEmu_Names[vNum] + '_Panel_Image';
  mainScene.Config.main.R.Emulators.Arcade[vNum].Panel_Image.Parent := mainScene.Config.main.R.Emulators.Arcade[vNum].Panel;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Panel_Image.SetBounds(0, 0, 100, 100);
  mainScene.Config.main.R.Emulators.Arcade[vNum].Panel_Image.Visible := True;

  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo := TImage.Create(mainScene.Config.main.R.Emulators.Arcade[vNum].Panel_Image);
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo.Name := 'Main_Config_Emulators_Arcade_' + cEmu_Names[vNum] + '_Logo';
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo.Parent := mainScene.Config.main.R.Emulators.Arcade[vNum].Panel_Image;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo.SetBounds(4, 4, 92, 92);
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo.Bitmap.LoadFromFile(ex_main.Paths.Config_Images.emu + 'arcade\' + cEmu_Image_Names[vNum]);
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo.WrapMode := TImageWrapMode.Fit;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo.OnClick := ex_main.input.mouse_config.Image.OnMouseClick;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo.OnMouseEnter := ex_main.input.mouse_config.Image.OnMouseEnter;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo.OnMouseLeave := ex_main.input.mouse_config.Image.OnMouseLeave;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo.Visible := True;

  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Check := TImage.Create(mainScene.Config.main.R.Emulators.Arcade[vNum].Logo);
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Check.Name := 'Main_Config_Emulators_Arcade_' + cEmu_Names[vNum] + '_Logo_Check';
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Check.Parent := mainScene.Config.main.R.Emulators.Arcade[vNum].Logo;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Check.SetBounds(2, 2, 34, 34);
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Check.Bitmap.LoadFromFile(ex_main.Paths.Config_Images.emu + 'config_check.png');
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Check.WrapMode := TImageWrapMode.Fit;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Check.OnClick := ex_main.input.mouse_config.Image.OnMouseClick;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Check.OnMouseEnter := ex_main.input.mouse_config.Image.OnMouseEnter;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Check.OnMouseLeave := ex_main.input.mouse_config.Image.OnMouseLeave;

  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Glow := TGlowEffect.Create(mainScene.Config.main.R.Emulators.Arcade[vNum].Logo);
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Glow.Name := 'Main_Config_Emulators_Arcade_' + cEmu_Names[vNum] + '_Logo_Glow';
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Glow.Parent := mainScene.Config.main.R.Emulators.Arcade[vNum].Logo;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Glow.Opacity := 0.9;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Glow.Softness := 0.4;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Glow.Enabled := False;

  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Gray := TMonochromeEffect.Create(mainScene.Config.main.R.Emulators.Arcade[vNum].Logo);
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Gray.Name := 'Main_Config_Emulators_Arcade_' + cEmu_Names[vNum] + '_Logo_Gray';
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Gray.Parent := mainScene.Config.main.R.Emulators.Arcade[vNum].Logo;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Gray.Enabled := not emulation.Arcade[vNum].Active;

  mainScene.Config.main.R.Emulators.Arcade[vNum].Info := TALText.Create(mainScene.Config.main.R.Emulators.Arcade[vNum].Panel);
  mainScene.Config.main.R.Emulators.Arcade[vNum].Info.Name := 'Main_Config_Emulators_' + cEmu_Names[vNum] + '_Info';
  mainScene.Config.main.R.Emulators.Arcade[vNum].Info.Parent := mainScene.Config.main.R.Emulators.Arcade[vNum].Panel;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Info.SetBounds(110, 20, mainScene.Config.main.R.Emulators.Arcade[vNum].Panel.Width - 100, 40);
  mainScene.Config.main.R.Emulators.Arcade[vNum].Info.WordWrap := True;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Info.TextIsHtml := True;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Info.TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Info.TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Info.TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Info.Visible := True;

  mainScene.Config.main.R.Emulators.Arcade[vNum].Action := TButton.Create(mainScene.Config.main.R.Emulators.Arcade[vNum].Panel);
  mainScene.Config.main.R.Emulators.Arcade[vNum].Action.Name := 'Main_Config_Emulators_' + cEmu_Names[vNum] + '_Action';;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Action.Parent := mainScene.Config.main.R.Emulators.Arcade[vNum].Panel;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Action.SetBounds(((mainScene.Config.main.R.Emulators.Arcade[vNum].Panel.Width / 2) - 120) + 50, 50, 240, 34);
  mainScene.Config.main.R.Emulators.Arcade[vNum].Action.StyledSettings := mainScene.Config.main.R.Emulators.Arcade[vNum].Action.StyledSettings -
    [TStyledSetting.FontColor];
  mainScene.Config.main.R.Emulators.Arcade[vNum].Action.OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Action.OnMouseEnter := ex_main.input.mouse_config.Button.OnMouseEnter;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Action.TagFloat := 1000;
  mainScene.Config.main.R.Emulators.Arcade[vNum].Action.Tag := vNum;

  case vNum of
    0:
      vInstalled := uDB_AUser.Local.Emulators.Arcade_D.Mame;
    1:
      vInstalled := uDB_AUser.Local.Emulators.Arcade_D.FBA;
    2:
      vInstalled := uDB_AUser.Local.Emulators.Arcade_D.Zinc;
    3:
      vInstalled := uDB_AUser.Local.Emulators.Arcade_D.Daphne;
    4:
      vInstalled := uDB_AUser.Local.Emulators.Arcade_D.Winkawaks;
    5:
      vInstalled := uDB_AUser.Local.Emulators.Arcade_D.Raine;
    6:
      vInstalled := uDB_AUser.Local.Emulators.Arcade_D.Model2;
    7:
      vInstalled := uDB_AUser.Local.Emulators.Arcade_D.SuperModel;
    8:
      vInstalled := uDB_AUser.Local.Emulators.Arcade_D.Demul;
  end;

  mainScene.Config.main.R.Emulators.Arcade[vNum].Logo_Check.Visible := vInstalled;;
  if vInstalled then
    mainScene.Config.main.R.Emulators.Arcade[vNum].Action.TextSettings.FontColor := TAlphaColorRec.Red
  else
    mainScene.Config.main.R.Emulators.Arcade[vNum].Action.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  if vInstalled then
  begin
    mainScene.Config.main.R.Emulators.Arcade[vNum].Info.Text := ' The emulator "<font color="#ff63cbfc">' + cEmu_Names[vNum] +
      '</font>" is installed in ExtraFE "<font color="#ff63cbfc">Successfully</font>".';
    mainScene.Config.main.R.Emulators.Arcade[vNum].Action.Text := 'Uninstall';
    mainScene.Config.main.R.Emulators.Arcade[vNum].Action.Enabled := True;
  end
  else
  begin
    if vNum <> 0 then
    begin
      mainScene.Config.main.R.Emulators.Arcade[vNum].Info.Text :=
        '"<font color="#ff63cbfc">WIP</font>" Script is not ready to install "<font color="#ff63cbfc">' + cEmu_Names[vNum] + '</font>" emulator.';
      mainScene.Config.main.R.Emulators.Arcade[vNum].Action.Enabled := False;
      mainScene.Config.main.R.Emulators.Arcade[vNum].Action.Text := 'Wait for update'
    end
    else
    begin
      mainScene.Config.main.R.Emulators.Arcade[vNum].Info.Text :=
        ' Click to start "<font color="#ff63cbfc">Installing</font>" to ExtraFE the "<font color="#ff63cbfc">' + cEmu_Names[vNum] + '</font>" emulator.';
      mainScene.Config.main.R.Emulators.Arcade[vNum].Action.Enabled := True;
      mainScene.Config.main.R.Emulators.Arcade[vNum].Action.Text := 'Install';
    end;
  end;
end;

procedure ShowArcade;
var
  vi: Integer;
begin
  mainScene.Config.main.R.Emulators.Panels[0] := TCalloutPanel.Create(mainScene.Config.main.R.Emulators.Panel);
  mainScene.Config.main.R.Emulators.Panels[0].Name := 'Main_Config_Emulators_CallPanel_' + IntToStr(0);
  mainScene.Config.main.R.Emulators.Panels[0].Parent := mainScene.Config.main.R.Emulators.Panel;
  mainScene.Config.main.R.Emulators.Panels[0].SetBounds(10, 110, mainScene.Config.main.R.Emulators.Panel.Width - 20,
    mainScene.Config.main.R.Emulators.Panel.Height - 120);
  mainScene.Config.main.R.Emulators.Panels[0].CalloutOffset := 25;
  mainScene.Config.main.R.Emulators.Panels[0].Visible := True;

  mainScene.Config.main.R.Emulators.ScrollBox[0] := TVertScrollBox.Create(mainScene.Config.main.R.Emulators.Panels[0]);
  mainScene.Config.main.R.Emulators.ScrollBox[0].Name := 'Main_Config_Emulators_Scrollbox_' + IntToStr(0);
  mainScene.Config.main.R.Emulators.ScrollBox[0].Parent := mainScene.Config.main.R.Emulators.Panels[0];
  mainScene.Config.main.R.Emulators.ScrollBox[0].SetBounds(5, 5, mainScene.Config.main.R.Emulators.Panels[0].Width - 10,
    mainScene.Config.main.R.Emulators.Panels[0].Height - 10);
  mainScene.Config.main.R.Emulators.ScrollBox[0].ShowScrollBars := True;
  mainScene.Config.main.R.Emulators.ScrollBox[0].Visible := True;

  for vi := 0 to 8 do
    CreateArcadePanel(vi);
end;

procedure CreateComputersPanel(vNum: Integer);
const
  cEmu_Names: array [0 .. 10] of string = ('Acorn Archimedes', 'Amiga 500/600/1000/4000', 'Amstrad 464/6128', 'Atari 800XL', 'Atari ST/STE/TT/Falcon',
    'Commodore 64', 'MsDOS', 'Old PC Windows', 'Scummvm', 'Spectrum', 'x68000');
  cEmu_Panel_Names: array [0 .. 10] of string = ('Acorn_Archimedes', 'Amiga_500', 'Amstrad_6128', 'Atari_800XL', 'Atari_ST', 'Commodore_64', 'MsDOS', 'Old_PC',
    'Scummvm', 'Spectrum', 'x68000');
  cEmu_Image_Names: array [0 .. 10] of string = ('acorn_archimedes.png', 'amiga.png', 'amstrad_6128.png', 'atari_800xl.png', 'atari_st.png', 'commodore_64.png',
    'msdos.png', 'old_pc.png', 'scummvm.png', 'spectrum.png', 'x68000.png');
var
  vInstalled: Boolean;
begin
  mainScene.Config.main.R.Emulators.Computers[vNum].Panel := TPanel.Create(mainScene.Config.main.R.Emulators.ScrollBox[1]);
  mainScene.Config.main.R.Emulators.Computers[vNum].Panel.Name := 'Main_Config_Emulators_Computers_' + cEmu_Panel_Names[vNum] + '_Panel';
  mainScene.Config.main.R.Emulators.Computers[vNum].Panel.Parent := mainScene.Config.main.R.Emulators.ScrollBox[1];
  mainScene.Config.main.R.Emulators.Computers[vNum].Panel.SetBounds(5, 20 + (vNum * 110), mainScene.Config.main.R.Emulators.ScrollBox[1].Width - 25, 100);
  mainScene.Config.main.R.Emulators.Computers[vNum].Panel.Visible := True;

  mainScene.Config.main.R.Emulators.Computers[vNum].Panel_Image := TPanel.Create(mainScene.Config.main.R.Emulators.Computers[vNum].Panel);
  mainScene.Config.main.R.Emulators.Computers[vNum].Panel_Image.Name := 'Main_Config_Emulators_Computers_' + cEmu_Panel_Names[vNum] + '_Panel_Image';
  mainScene.Config.main.R.Emulators.Computers[vNum].Panel_Image.Parent := mainScene.Config.main.R.Emulators.Computers[vNum].Panel;
  mainScene.Config.main.R.Emulators.Computers[vNum].Panel_Image.SetBounds(0, 0, 100, 100);
  mainScene.Config.main.R.Emulators.Computers[vNum].Panel_Image.Visible := True;

  mainScene.Config.main.R.Emulators.Computers[vNum].Logo := TImage.Create(mainScene.Config.main.R.Emulators.Computers[vNum].Panel_Image);
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo.Name := 'Main_Config_Emulators_Computers_' + cEmu_Panel_Names[vNum] + '_Logo';
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo.Parent := mainScene.Config.main.R.Emulators.Computers[vNum].Panel_Image;
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo.SetBounds(4, 4, 92, 92);
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo.Bitmap.LoadFromFile(ex_main.Paths.Config_Images.emu + 'computers\' + cEmu_Image_Names[vNum]);
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo.WrapMode := TImageWrapMode.Fit;
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo.OnClick := ex_main.input.mouse_config.Image.OnMouseClick;
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo.OnMouseEnter := ex_main.input.mouse_config.Image.OnMouseEnter;
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo.OnMouseLeave := ex_main.input.mouse_config.Image.OnMouseLeave;
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo.Visible := True;

  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Check := TImage.Create(mainScene.Config.main.R.Emulators.Computers[vNum].Logo);
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Check.Name := 'Main_Config_Emulators_Computers_' + cEmu_Panel_Names[vNum] + '_Logo_Check';
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Check.Parent := mainScene.Config.main.R.Emulators.Computers[vNum].Logo;
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Check.SetBounds(2, 2, 34, 34);
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Check.Bitmap.LoadFromFile(ex_main.Paths.Config_Images.emu + 'config_check.png');
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Check.WrapMode := TImageWrapMode.Fit;
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Check.OnClick := ex_main.input.mouse_config.Image.OnMouseClick;
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Check.OnMouseEnter := ex_main.input.mouse_config.Image.OnMouseEnter;
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Check.OnMouseLeave := ex_main.input.mouse_config.Image.OnMouseLeave;
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Check.Visible := False;

  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Glow := TGlowEffect.Create(mainScene.Config.main.R.Emulators.Computers[vNum].Logo);
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Glow.Name := 'Main_Config_Emulators_Computers_' + cEmu_Panel_Names[vNum] + '_Logo_Glow';
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Glow.Parent := mainScene.Config.main.R.Emulators.Computers[vNum].Logo;
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Glow.Opacity := 0.9;
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Glow.Softness := 0.4;
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Glow.Enabled := False;

  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Gray := TMonochromeEffect.Create(mainScene.Config.main.R.Emulators.Computers[vNum].Logo);
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Gray.Name := 'Main_Config_Emulators_Computers_' + cEmu_Panel_Names[vNum] + '_Logo_Gray';
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Gray.Parent := mainScene.Config.main.R.Emulators.Computers[vNum].Logo;
  mainScene.Config.main.R.Emulators.Computers[vNum].Logo_Gray.Enabled := not emulation.Computers[vNum].Active;

  mainScene.Config.main.R.Emulators.Computers[vNum].Info := TALText.Create(mainScene.Config.main.R.Emulators.Computers[vNum].Panel);
  mainScene.Config.main.R.Emulators.Computers[vNum].Info.Name := 'Main_Config_Emulators_' + cEmu_Panel_Names[vNum] + '_Info';
  mainScene.Config.main.R.Emulators.Computers[vNum].Info.Parent := mainScene.Config.main.R.Emulators.Computers[vNum].Panel;
  mainScene.Config.main.R.Emulators.Computers[vNum].Info.SetBounds(110, 20, mainScene.Config.main.R.Emulators.Computers[vNum].Panel.Width - 100, 40);
  mainScene.Config.main.R.Emulators.Computers[vNum].Info.WordWrap := True;
  mainScene.Config.main.R.Emulators.Computers[vNum].Info.TextIsHtml := True;
  mainScene.Config.main.R.Emulators.Computers[vNum].Info.TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Emulators.Computers[vNum].Info.TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Emulators.Computers[vNum].Info.TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Emulators.Computers[vNum].Info.Visible := True;

  mainScene.Config.main.R.Emulators.Computers[vNum].Action := TButton.Create(mainScene.Config.main.R.Emulators.Computers[vNum].Panel);
  mainScene.Config.main.R.Emulators.Computers[vNum].Action.Name := 'Main_Config_Emulators_' + cEmu_Panel_Names[vNum] + '_Action';;
  mainScene.Config.main.R.Emulators.Computers[vNum].Action.Parent := mainScene.Config.main.R.Emulators.Computers[vNum].Panel;
  mainScene.Config.main.R.Emulators.Computers[vNum].Action.SetBounds(((mainScene.Config.main.R.Emulators.Computers[vNum].Panel.Width / 2) - 120) + 50,
    50, 240, 34);
  mainScene.Config.main.R.Emulators.Computers[vNum].Action.StyledSettings := mainScene.Config.main.R.Emulators.Computers[vNum].Action.StyledSettings -
    [TStyledSetting.FontColor];
  mainScene.Config.main.R.Emulators.Computers[vNum].Action.OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
  mainScene.Config.main.R.Emulators.Computers[vNum].Action.TagFloat := 1000;
  mainScene.Config.main.R.Emulators.Computers[vNum].Action.Tag := vNum;
  mainScene.Config.main.R.Emulators.Computers[vNum].Action.Visible := True;

  case vNum of
    0:
      vInstalled := uDB_AUser.Local.Emulators.Computers_D.Acorn_Archimedes;
    1:
      vInstalled := uDB_AUser.Local.Emulators.Computers_D.Amiga;
    2:
      vInstalled := uDB_AUser.Local.Emulators.Computers_D.Amstrad;
    3:
      vInstalled := uDB_AUser.Local.Emulators.Computers_D.Atari_8Bit;
    4:
      vInstalled := uDB_AUser.Local.Emulators.Computers_D.Atart_ST;
    5:
      vInstalled := uDB_AUser.Local.Emulators.Computers_D.Commodore_64;
    6:
      vInstalled := uDB_AUser.Local.Emulators.Computers_D.MsDos;
    7:
      vInstalled := uDB_AUser.Local.Emulators.Computers_D.PCWindows;
    8:
      vInstalled := uDB_AUser.Local.Emulators.Computers_D.Scummvm;
    9:
      vInstalled := uDB_AUser.Local.Emulators.Computers_D.Spectrum;
    10:
      vInstalled := uDB_AUser.Local.Emulators.Computers_D.X68000;
  end;

  if vInstalled then
  begin
    mainScene.Config.main.R.Emulators.Computers[vNum].Info.Text := ' The emulator "<font color="#ff63cbfc">' + cEmu_Names[vNum] +
      '</font>" is installed in ExtraFE "<font color="#ff63cbfc">Successfully</font>".';
    mainScene.Config.main.R.Emulators.Computers[vNum].Action.Text := 'Uninstall';
    mainScene.Config.main.R.Emulators.Computers[vNum].Action.Enabled := True;
    mainScene.Config.main.R.Emulators.Computers[vNum].Action.TextSettings.FontColor := TAlphaColorRec.Red;
  end
  else
  begin
    mainScene.Config.main.R.Emulators.Computers[vNum].Info.Text :=
      '"<font color="#ff63cbfc">WIP</font>" Script is not ready to install "<font color="#ff63cbfc">' + cEmu_Names[vNum] + '</font>" emulator.';
    mainScene.Config.main.R.Emulators.Computers[vNum].Action.Text := 'Wait for update';
    mainScene.Config.main.R.Emulators.Computers[vNum].Action.Enabled := False;
    mainScene.Config.main.R.Emulators.Computers[vNum].Action.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  end;
end;

procedure ShowComputers;
var
  vi: Integer;
begin
  mainScene.Config.main.R.Emulators.Panels[1] := TCalloutPanel.Create(mainScene.Config.main.R.Emulators.Panel);
  mainScene.Config.main.R.Emulators.Panels[1].Name := 'Main_Config_Emulators_CallPanel_' + IntToStr(1);
  mainScene.Config.main.R.Emulators.Panels[1].Parent := mainScene.Config.main.R.Emulators.Panel;
  mainScene.Config.main.R.Emulators.Panels[1].SetBounds(10, 110, mainScene.Config.main.R.Emulators.Panel.Width - 20,
    mainScene.Config.main.R.Emulators.Panel.Height - 120);
  mainScene.Config.main.R.Emulators.Panels[1].CalloutOffset := 154;
  mainScene.Config.main.R.Emulators.Panels[1].Visible := True;

  mainScene.Config.main.R.Emulators.ScrollBox[1] := TVertScrollBox.Create(mainScene.Config.main.R.Emulators.Panels[1]);
  mainScene.Config.main.R.Emulators.ScrollBox[1].Name := 'Main_Config_Emulators_Scrollbox_' + IntToStr(1);
  mainScene.Config.main.R.Emulators.ScrollBox[1].Parent := mainScene.Config.main.R.Emulators.Panels[1];
  mainScene.Config.main.R.Emulators.ScrollBox[1].SetBounds(5, 5, mainScene.Config.main.R.Emulators.Panels[1].Width - 10,
    mainScene.Config.main.R.Emulators.Panels[1].Height - 10);
  mainScene.Config.main.R.Emulators.ScrollBox[1].ShowScrollBars := True;
  mainScene.Config.main.R.Emulators.ScrollBox[1].Visible := True;

  for vi := 0 to 10 do
    CreateComputersPanel(vi);
end;

procedure CreateConsolesPanel(vNum: Integer);
const
  cEmu_Names: array [0 .. 30] of string = ('3DO', 'Amiga CD32', 'Atari 2600', 'Atari 5200', 'Atari 7800', 'Atari Jaguar', 'Neo Geo', 'Neo Geo CD', 'NES',
    'Super NES', 'Nintendo 64', 'Gamecube', 'Wii', 'Wii U', 'Nintendo Switch', 'Pc Engine', 'Pc Engine CD/Duo', 'PC FX', 'Playstation', 'Playstation 2',
    'Playstation 3', 'Sg 1000', 'Sega Master System', 'Mega Drive', 'Mega Drive 32X', 'Mega Drive CD', 'Saturn', 'Dreamcast', 'XBOX', 'XBOX ONE', '');
  cEmu_Panel_Names: array [0 .. 30] of string = ('3DO', 'Amiga_CD32', 'Atari_2600', 'Atari_5200', 'Atari_7800', 'Atari_Jaguar', 'Neo_Geo', 'Neo_Geo_CD', 'NES',
    'Super_NES', 'Nintendo_64', 'Gamecube', 'Wii', 'Wii_U', 'Nintendo_Switch', 'Pc_Engine', 'Pc_Engine_CD_Duo', 'PC_FX', 'Playstation', 'Playstation_2',
    'Playstation_3', 'Sg_1000', 'Sega_Master_System', 'Mega_Drive', 'Mega_Drive_32X', 'Mega_Drive_CD', 'Saturn', 'Dreamcast', 'XBOX', 'XBOX_ONE', '');
  cEmu_Image_Names: array [0 .. 30] of string = ('3do.png', 'amiga_cd32.png', 'atari_2600.png', 'atari_5200.png', 'atari_7800.png', 'atari_jaguar.png',
    'neogeo.png', 'neogeo_cd.png', 'nintendo_nes.png', 'nintendo_supernes.png', 'nintendo_64.png', 'nintendo_gamecube.png', 'nintendo_wii.png',
    'nintendo_wiiu.png', 'nintendo_switch.png', 'pc_engine.png', 'pc_engine_cd.png', 'pc_fx.png', 'playstation_1.png', 'playstation_2.png', 'playstation_3.png',
    'sega_sg1000.png', 'sega_master_system.png', 'sega_megadrive.png', 'sega_megadrive_32x.png', 'sega_megadrive_cd.png', 'sega_saturn.png',
    'sega_dreamcast.png', 'xbox.png', 'xbox_one.png', '');
var
  vInstalled: Boolean;
begin
  mainScene.Config.main.R.Emulators.Consoles[vNum].Panel := TPanel.Create(mainScene.Config.main.R.Emulators.ScrollBox[2]);
  mainScene.Config.main.R.Emulators.Consoles[vNum].Panel.Name := 'Main_Config_Emulators_Consoles_' + cEmu_Panel_Names[vNum] + '_Panel';
  mainScene.Config.main.R.Emulators.Consoles[vNum].Panel.Parent := mainScene.Config.main.R.Emulators.ScrollBox[2];
  mainScene.Config.main.R.Emulators.Consoles[vNum].Panel.SetBounds(5, 20 + (vNum * 110), mainScene.Config.main.R.Emulators.ScrollBox[2].Width - 25, 100);
  mainScene.Config.main.R.Emulators.Consoles[vNum].Panel.Visible := True;

  mainScene.Config.main.R.Emulators.Consoles[vNum].Panel_Image := TPanel.Create(mainScene.Config.main.R.Emulators.Consoles[vNum].Panel);
  mainScene.Config.main.R.Emulators.Consoles[vNum].Panel_Image.Name := 'Main_Config_Emulators_Consoles_' + cEmu_Panel_Names[vNum] + '_Panel_Image';
  mainScene.Config.main.R.Emulators.Consoles[vNum].Panel_Image.Parent := mainScene.Config.main.R.Emulators.Consoles[vNum].Panel;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Panel_Image.SetBounds(0, 0, 100, 100);
  mainScene.Config.main.R.Emulators.Consoles[vNum].Panel_Image.Visible := True;

  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo := TImage.Create(mainScene.Config.main.R.Emulators.Consoles[vNum].Panel_Image);
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo.Name := 'Main_Config_Emulators_Consoles_' + cEmu_Panel_Names[vNum] + '_Logo';
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo.Parent := mainScene.Config.main.R.Emulators.Consoles[vNum].Panel_Image;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo.SetBounds(4, 4, 92, 92);
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo.Bitmap.LoadFromFile(ex_main.Paths.Config_Images.emu + 'consoles\' + cEmu_Image_Names[vNum]);
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo.WrapMode := TImageWrapMode.Fit;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo.OnClick := ex_main.input.mouse_config.Image.OnMouseClick;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo.OnMouseEnter := ex_main.input.mouse_config.Image.OnMouseEnter;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo.OnMouseLeave := ex_main.input.mouse_config.Image.OnMouseLeave;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo.Visible := True;

  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Check := TImage.Create(mainScene.Config.main.R.Emulators.Consoles[vNum].Logo);
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Check.Name := 'Main_Config_Emulators_Consoles_' + cEmu_Panel_Names[vNum] + '_Logo_Check';
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Check.Parent := mainScene.Config.main.R.Emulators.Consoles[vNum].Logo;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Check.SetBounds(2, 2, 34, 34);
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Check.Bitmap.LoadFromFile(ex_main.Paths.Config_Images.emu + 'config_check.png');
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Check.WrapMode := TImageWrapMode.Fit;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Check.OnClick := ex_main.input.mouse_config.Image.OnMouseClick;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Check.OnMouseEnter := ex_main.input.mouse_config.Image.OnMouseEnter;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Check.OnMouseLeave := ex_main.input.mouse_config.Image.OnMouseLeave;

  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Glow := TGlowEffect.Create(mainScene.Config.main.R.Emulators.Consoles[vNum].Logo);
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Glow.Name := 'Main_Config_Emulators_Consoles_' + cEmu_Panel_Names[vNum] + '_Logo_Glow';
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Glow.Parent := mainScene.Config.main.R.Emulators.Consoles[vNum].Logo;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Glow.Opacity := 0.9;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Glow.Softness := 0.4;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Glow.Enabled := False;

  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Gray := TMonochromeEffect.Create(mainScene.Config.main.R.Emulators.Consoles[vNum].Logo);
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Gray.Name := 'Main_Config_Emulators_Consoles_' + cEmu_Panel_Names[vNum] + '_Logo_Gray';
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Gray.Parent := mainScene.Config.main.R.Emulators.Consoles[vNum].Logo;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Gray.Enabled := not emulation.Consoles[vNum].Installed;

  mainScene.Config.main.R.Emulators.Consoles[vNum].Info := TALText.Create(mainScene.Config.main.R.Emulators.Consoles[vNum].Panel);
  mainScene.Config.main.R.Emulators.Consoles[vNum].Info.Name := 'Main_Config_Emulators_' + cEmu_Panel_Names[vNum] + '_Info';
  mainScene.Config.main.R.Emulators.Consoles[vNum].Info.Parent := mainScene.Config.main.R.Emulators.Consoles[vNum].Panel;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Info.SetBounds(110, 20, mainScene.Config.main.R.Emulators.Consoles[vNum].Panel.Width - 100, 40);
  mainScene.Config.main.R.Emulators.Consoles[vNum].Info.WordWrap := True;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Info.TextIsHtml := True;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Info.TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Info.TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Info.TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Info.Visible := True;

  mainScene.Config.main.R.Emulators.Consoles[vNum].Action := TButton.Create(mainScene.Config.main.R.Emulators.Consoles[vNum].Panel);
  mainScene.Config.main.R.Emulators.Consoles[vNum].Action.Name := 'Main_Config_Emulators_' + cEmu_Panel_Names[vNum] + '_Action';;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Action.Parent := mainScene.Config.main.R.Emulators.Consoles[vNum].Panel;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Action.SetBounds(((mainScene.Config.main.R.Emulators.Consoles[vNum].Panel.Width / 2) - 120) + 50,
    50, 240, 34);
  mainScene.Config.main.R.Emulators.Consoles[vNum].Action.StyledSettings := mainScene.Config.main.R.Emulators.Consoles[vNum].Action.StyledSettings -
    [TStyledSetting.FontColor];
  mainScene.Config.main.R.Emulators.Consoles[vNum].Action.OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Action.TagFloat := 1000;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Action.Tag := vNum;
  mainScene.Config.main.R.Emulators.Consoles[vNum].Action.Visible := True;

  case vNum of
    0:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Panasonic_3DO;
    1:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Amiga_CD32;
    2:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Atari_2600;
    3:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Atari_5200;
    4:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Atari_7800;
    5:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Atari_Jaguar;
    6:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Neo_Geo;
    7:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Neo_Geo_CD;
    8:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.NES;
    9:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.SNES;
    10:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Nintendo_64;
    11:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Gamecube;
    12:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Wii;
    13:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Wii_U;
    14:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Nintendo_Switch;
    15:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.PC_Engine;
    16:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.PC_Engine_CD;
    17:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.PX_FX;
    18:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Playstation;
    19:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Playstation_2;
    20:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Playstation_3;
    21:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.SG_1000;
    22:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Master_System;
    23:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Mega_Drive;
    24:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Mega_Drive_32X;
    25:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Mega_Drive_CD;
    26:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Saturn;
    27:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.Dreamcast;
    28:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.XBOX;
    29:
      vInstalled := uDB_AUser.Local.Emulators.Consoles_D.XBOX_ONE;
  end;

  if vInstalled then
  begin
    mainScene.Config.main.R.Emulators.Consoles[vNum].Info.Text := ' The emulator "<font color="#ff63cbfc">' + cEmu_Names[vNum] +
      '</font>" is installed in ExtraFE "<font color="#ff63cbfc">Successfully</font>".';
    mainScene.Config.main.R.Emulators.Consoles[vNum].Action.Text := 'Uninstall';
    mainScene.Config.main.R.Emulators.Consoles[vNum].Action.Enabled := True;
    mainScene.Config.main.R.Emulators.Consoles[vNum].Action.TextSettings.FontColor := TAlphaColorRec.Red;
    mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Check.Visible := True
  end
  else
  begin
    if vNum <> 8 then
    begin
      mainScene.Config.main.R.Emulators.Consoles[vNum].Info.Text :=
        '"<font color="#ff63cbfc">WIP</font>" Script is not ready to install "<font color="#ff63cbfc">' + cEmu_Names[vNum] + '</font>" emulator.';
      mainScene.Config.main.R.Emulators.Consoles[vNum].Action.Enabled := False;
      mainScene.Config.main.R.Emulators.Consoles[vNum].Action.Text := 'Wait for update';
      mainScene.Config.main.R.Emulators.Consoles[vNum].Action.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    end
    else
    begin
      mainScene.Config.main.R.Emulators.Consoles[vNum].Info.Text :=
        ' Click to start "<font color="#ff63cbfc">Install</font>" to ExtraFE the "<font color="#ff63cbfc">' + cEmu_Names[vNum] + '</font>" emulator.';
      mainScene.Config.main.R.Emulators.Consoles[vNum].Action.Enabled := True;
      mainScene.Config.main.R.Emulators.Consoles[vNum].Action.Text := 'Install';
      mainScene.Config.main.R.Emulators.Consoles[vNum].Action.TextSettings.FontColor := TAlphaColorRec.White;
    end;
    mainScene.Config.main.R.Emulators.Consoles[vNum].Logo_Check.Visible := False;
  end;

  if vInstalled then
  begin
    mainScene.Config.main.R.Emulators.Consoles[vNum].Add_New := TButton.Create(mainScene.Config.main.R.Emulators.Consoles[vNum].Panel);
    mainScene.Config.main.R.Emulators.Consoles[vNum].Add_New.Name := 'Main_Config_Emulators_' + cEmu_Panel_Names[vNum] + '_Add_New';;
    mainScene.Config.main.R.Emulators.Consoles[vNum].Add_New.Parent := mainScene.Config.main.R.Emulators.Consoles[vNum].Panel;
    mainScene.Config.main.R.Emulators.Consoles[vNum].Add_New.SetBounds(((mainScene.Config.main.R.Emulators.Consoles[vNum].Panel.Width / 2) - 120) + 50,
      50, 240, 34);
    mainScene.Config.main.R.Emulators.Consoles[vNum].Add_New.Text := 'Add New Emulator';
    mainScene.Config.main.R.Emulators.Consoles[vNum].Add_New.TextSettings.FontColor := TAlphaColorRec.Red;
    mainScene.Config.main.R.Emulators.Consoles[vNum].Add_New.StyledSettings := mainScene.Config.main.R.Emulators.Consoles[vNum].Action.StyledSettings -
      [TStyledSetting.FontColor];
    mainScene.Config.main.R.Emulators.Consoles[vNum].Add_New.OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
    mainScene.Config.main.R.Emulators.Consoles[vNum].Add_New.TagFloat := 1000;
    mainScene.Config.main.R.Emulators.Consoles[vNum].Add_New.Tag := vNum;
    mainScene.Config.main.R.Emulators.Consoles[vNum].Add_New.Enabled := True;
    mainScene.Config.main.R.Emulators.Consoles[vNum].Add_New.Visible := True;

    // ��� ������ �� ���� ��������� ��� �� ���� �� action button ��� �� �� ������ ��� �� ���
  end;
end;

procedure ShowConsoles;
var
  vi: Integer;
begin
  mainScene.Config.main.R.Emulators.Panels[2] := TCalloutPanel.Create(mainScene.Config.main.R.Emulators.Panel);
  mainScene.Config.main.R.Emulators.Panels[2].Name := 'Main_Config_Emulators_CallPanel_' + IntToStr(2);
  mainScene.Config.main.R.Emulators.Panels[2].Parent := mainScene.Config.main.R.Emulators.Panel;
  mainScene.Config.main.R.Emulators.Panels[2].SetBounds(10, 110, mainScene.Config.main.R.Emulators.Panel.Width - 20,
    mainScene.Config.main.R.Emulators.Panel.Height - 120);
  mainScene.Config.main.R.Emulators.Panels[2].CalloutOffset := 262;
  mainScene.Config.main.R.Emulators.Panels[2].Visible := True;

  mainScene.Config.main.R.Emulators.ScrollBox[2] := TVertScrollBox.Create(mainScene.Config.main.R.Emulators.Panels[2]);
  mainScene.Config.main.R.Emulators.ScrollBox[2].Name := 'Main_Config_Emulators_Scrollbox_' + IntToStr(2);
  mainScene.Config.main.R.Emulators.ScrollBox[2].Parent := mainScene.Config.main.R.Emulators.Panels[2];
  mainScene.Config.main.R.Emulators.ScrollBox[2].SetBounds(5, 5, mainScene.Config.main.R.Emulators.Panels[2].Width - 10,
    mainScene.Config.main.R.Emulators.Panels[2].Height - 10);
  mainScene.Config.main.R.Emulators.ScrollBox[2].ShowScrollBars := True;
  mainScene.Config.main.R.Emulators.ScrollBox[2].Visible := True;

  for vi := 0 to 29 do
    CreateConsolesPanel(vi);
end;

procedure CreateHandheldsPanel(vNum: Integer);
const
  cEmu_Names: array [0 .. 12] of string = ('Atari Lynx', 'NeoGeo Pocket', 'GameGear', 'Game & Watch', 'Gameboy', 'Gameboy Color', 'Gameboy VirtualBoy',
    'Gameboy Advance', 'Nintendo DS', 'Nintendo 3DS', 'PSP', 'PSP Vita', 'Wonderswan');
  cEmu_Panel_Names: array [0 .. 12] of string = ('Atari_Lynx', 'NeoGeo_Pocket', 'GameGear', 'Game_Watch', 'Gameboy', 'Gameboy_Color', 'Gameboy_VirtualBoy',
    'Gameboy_Advance', 'Nintendo_DS', 'Nintendo_3DS', 'PSP', 'PSP_Vita', 'Wonderswan');
  cEmu_Image_Names: array [0 .. 12] of string = ('lynx.png', 'neogeo_pocket.png', 'game_gear.png', 'game_watch.png', 'gameboy.png', 'gameboy_color.png',
    'gameboy_virtualboy.png', 'gameboy_advance.png', 'nintendo_ds.png', 'nintendo_3ds.png', 'psp.png', 'psp_vita.png', 'wonderswan.png');
var
  vInstalled: Boolean;
begin
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel := TPanel.Create(mainScene.Config.main.R.Emulators.ScrollBox[3]);
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel.Name := 'Main_Config_Emulators_Handhelds_' + cEmu_Panel_Names[vNum] + '_Panel';
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel.Parent := mainScene.Config.main.R.Emulators.ScrollBox[3];
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel.SetBounds(5, 20 + (vNum * 110), mainScene.Config.main.R.Emulators.ScrollBox[3].Width - 25, 100);
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel.Visible := True;

  mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel_Image := TPanel.Create(mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel);
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel_Image.Name := 'Main_Config_Emulators_Handhelds_' + cEmu_Panel_Names[vNum] + '_Panel_Image';
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel_Image.Parent := mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel_Image.SetBounds(0, 0, 100, 100);
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel_Image.Visible := True;

  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo := TImage.Create(mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel_Image);
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo.Name := 'Main_Config_Emulators_Handhelds_' + cEmu_Panel_Names[vNum] + '_Logo';
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo.Parent := mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel_Image;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo.SetBounds(4, 4, 92, 92);
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo.Bitmap.LoadFromFile(ex_main.Paths.Config_Images.emu + 'handhelds\' + cEmu_Image_Names[vNum]);
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo.WrapMode := TImageWrapMode.Fit;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo.OnClick := ex_main.input.mouse_config.Image.OnMouseClick;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo.OnMouseEnter := ex_main.input.mouse_config.Image.OnMouseEnter;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo.OnMouseLeave := ex_main.input.mouse_config.Image.OnMouseLeave;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo.Visible := True;

  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Check := TImage.Create(mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo);
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Check.Name := 'Main_Config_Emulators_Handhelds_' + cEmu_Panel_Names[vNum] + '_Logo_Check';
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Check.Parent := mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Check.SetBounds(2, 2, 34, 34);
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Check.Bitmap.LoadFromFile(ex_main.Paths.Config_Images.emu + 'config_check.png');
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Check.WrapMode := TImageWrapMode.Fit;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Check.OnClick := ex_main.input.mouse_config.Image.OnMouseClick;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Check.OnMouseEnter := ex_main.input.mouse_config.Image.OnMouseEnter;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Check.OnMouseLeave := ex_main.input.mouse_config.Image.OnMouseLeave;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Check.Visible := False;

  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Glow := TGlowEffect.Create(mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo);
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Glow.Name := 'Main_Config_Emulators_Handhelds_' + cEmu_Panel_Names[vNum] + '_Logo_Glow';
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Glow.Parent := mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Glow.Opacity := 0.9;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Glow.Softness := 0.4;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Glow.Enabled := False;

  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Gray := TMonochromeEffect.Create(mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo);
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Gray.Name := 'Main_Config_Emulators_Handhelds_' + cEmu_Panel_Names[vNum] + '_Logo_Gray';
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Gray.Parent := mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Gray.Enabled := not emulation.Computers[vNum].Installed;

  mainScene.Config.main.R.Emulators.Handhelds[vNum].Info := TALText.Create(mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel);
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Info.Name := 'Main_Config_Emulators_' + cEmu_Panel_Names[vNum] + '_Info';
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Info.Parent := mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Info.SetBounds(110, 20, mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel.Width - 100, 40);
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Info.WordWrap := True;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Info.TextIsHtml := True;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Info.TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Info.TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Info.TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Info.Visible := True;

  mainScene.Config.main.R.Emulators.Handhelds[vNum].Action := TButton.Create(mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel);
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Action.Name := 'Main_Config_Emulators_' + cEmu_Panel_Names[vNum] + '_Action';
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Action.Parent := mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Action.SetBounds(((mainScene.Config.main.R.Emulators.Handhelds[vNum].Panel.Width / 2) - 120) + 50,
    50, 240, 34);

  mainScene.Config.main.R.Emulators.Handhelds[vNum].Action.StyledSettings := mainScene.Config.main.R.Emulators.Handhelds[vNum].Action.StyledSettings -
    [TStyledSetting.FontColor];
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Action.OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Action.TagFloat := 1000;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Action.Tag := vNum;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Action.Visible := True;
  mainScene.Config.main.R.Emulators.Handhelds[vNum].Logo_Gray.Enabled := True;

  case vNum of
    0:
      vInstalled := uDB_AUser.Local.Emulators.Handhelds_D.Atari_Lynx;
    1:
      vInstalled := uDB_AUser.Local.Emulators.Handhelds_D.Neo_Geo_Pocket;
    2:
      vInstalled := uDB_AUser.Local.Emulators.Handhelds_D.GameGear;
    3:
      vInstalled := uDB_AUser.Local.Emulators.Handhelds_D.Game_And_Watch;
    4:
      vInstalled := uDB_AUser.Local.Emulators.Handhelds_D.Gameboy;
    5:
      vInstalled := uDB_AUser.Local.Emulators.Handhelds_D.Gameboy_Color;
    6:
      vInstalled := uDB_AUser.Local.Emulators.Handhelds_D.Gameboy_VirtualBoy;
    7:
      vInstalled := uDB_AUser.Local.Emulators.Handhelds_D.Gameboy_Advance;
    8:
      vInstalled := uDB_AUser.Local.Emulators.Handhelds_D.Nintendo_DS;
    9:
      vInstalled := uDB_AUser.Local.Emulators.Handhelds_D.Nintendo_3DS;
    10:
      vInstalled := uDB_AUser.Local.Emulators.Handhelds_D.PSP;
    11:
      vInstalled := uDB_AUser.Local.Emulators.Handhelds_D.PSP_Vita;
    12:
      vInstalled := uDB_AUser.Local.Emulators.Handhelds_D.Wonderswan;
  end;

  if vInstalled then
  begin
    mainScene.Config.main.R.Emulators.Handhelds[vNum].Info.Text := ' The emulator "<font color="#ff63cbfc">' + cEmu_Names[vNum] +
      '</font>" is installed in ExtraFE "<font color="#ff63cbfc">Successfully</font>".';
    mainScene.Config.main.R.Emulators.Handhelds[vNum].Action.Text := 'Uninstall';
    mainScene.Config.main.R.Emulators.Handhelds[vNum].Action.TextSettings.FontColor := TAlphaColorRec.Red;
    mainScene.Config.main.R.Emulators.Handhelds[vNum].Action.Enabled := True;
  end
  else
  begin
    mainScene.Config.main.R.Emulators.Handhelds[vNum].Info.Text :=
      '"<font color="#ff63cbfc">WIP</font>" Script is not ready to install "<font color="#ff63cbfc">' + cEmu_Names[vNum] + '</font>" emulator.';
    mainScene.Config.main.R.Emulators.Handhelds[vNum].Action.Text := 'Wait for update';
    mainScene.Config.main.R.Emulators.Handhelds[vNum].Action.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    mainScene.Config.main.R.Emulators.Handhelds[vNum].Action.Enabled := False;
  end;
end;

procedure ShowHandhelds;
var
  vi: Integer;
begin
  mainScene.Config.main.R.Emulators.Panels[3] := TCalloutPanel.Create(mainScene.Config.main.R.Emulators.Panel);
  mainScene.Config.main.R.Emulators.Panels[3].Name := 'Main_Config_Emulators_CallPanel_' + IntToStr(3);
  mainScene.Config.main.R.Emulators.Panels[3].Parent := mainScene.Config.main.R.Emulators.Panel;
  mainScene.Config.main.R.Emulators.Panels[3].SetBounds(10, 110, mainScene.Config.main.R.Emulators.Panel.Width - 20,
    mainScene.Config.main.R.Emulators.Panel.Height - 120);
  mainScene.Config.main.R.Emulators.Panels[3].CalloutOffset := 386;
  mainScene.Config.main.R.Emulators.Panels[3].Visible := True;

  mainScene.Config.main.R.Emulators.ScrollBox[3] := TVertScrollBox.Create(mainScene.Config.main.R.Emulators.Panels[3]);
  mainScene.Config.main.R.Emulators.ScrollBox[3].Name := 'Main_Config_Emulators_Scrollbox_' + IntToStr(3);
  mainScene.Config.main.R.Emulators.ScrollBox[3].Parent := mainScene.Config.main.R.Emulators.Panels[3];
  mainScene.Config.main.R.Emulators.ScrollBox[3].SetBounds(5, 5, mainScene.Config.main.R.Emulators.Panels[3].Width - 10,
    mainScene.Config.main.R.Emulators.Panels[3].Height - 10);
  mainScene.Config.main.R.Emulators.ScrollBox[3].ShowScrollBars := True;
  mainScene.Config.main.R.Emulators.ScrollBox[3].Visible := True;

  for vi := 0 to 12 do
    CreateHandheldsPanel(vi);
end;

procedure CreatePinballsPanel(vNum: Integer);
const
  cEmu_Names: array [0 .. 1] of string = ('Visual Pinball X', 'Future Pinball');
  cEmu_Panel_Names: array [0 .. 1] of string = ('Visual_PinballX', 'Future_Pinball');
  cEmu_Image_Names: array [0 .. 1] of string = ('visual.png', 'future.png');
var
  vInstalled: Boolean;
begin
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel := TPanel.Create(mainScene.Config.main.R.Emulators.ScrollBox[4]);
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel.Name := 'Main_Config_Emulators_Pinballs_' + cEmu_Panel_Names[vNum] + '_Panel';
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel.Parent := mainScene.Config.main.R.Emulators.ScrollBox[4];
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel.SetBounds(5, 20 + (vNum * 110), mainScene.Config.main.R.Emulators.ScrollBox[4].Width - 25, 100);
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel.Visible := True;

  mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel_Image := TPanel.Create(mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel);
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel_Image.Name := 'Main_Config_Emulators_Pinballs_' + cEmu_Panel_Names[vNum] + '_Panel_Image';
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel_Image.Parent := mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel_Image.SetBounds(0, 0, 100, 100);
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel_Image.Visible := True;

  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo := TImage.Create(mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel_Image);
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo.Name := 'Main_Config_Emulators_Pinballs_' + cEmu_Panel_Names[vNum] + '_Logo';
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo.Parent := mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel_Image;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo.SetBounds(4, 4, 92, 92);
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo.Bitmap.LoadFromFile(ex_main.Paths.Config_Images.emu + 'pinballs\' + cEmu_Image_Names[vNum]);
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo.WrapMode := TImageWrapMode.Fit;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo.OnClick := ex_main.input.mouse_config.Image.OnMouseClick;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo.OnMouseEnter := ex_main.input.mouse_config.Image.OnMouseEnter;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo.OnMouseLeave := ex_main.input.mouse_config.Image.OnMouseLeave;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo.Visible := True;

  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Check := TImage.Create(mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo);
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Check.Name := 'Main_Config_Emulators_Pinballs_' + cEmu_Panel_Names[vNum] + '_Logo_Check';
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Check.Parent := mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Check.SetBounds(2, 2, 34, 34);
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Check.Bitmap.LoadFromFile(ex_main.Paths.Config_Images.emu + 'config_check.png');
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Check.WrapMode := TImageWrapMode.Fit;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Check.OnClick := ex_main.input.mouse_config.Image.OnMouseClick;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Check.OnMouseEnter := ex_main.input.mouse_config.Image.OnMouseEnter;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Check.OnMouseLeave := ex_main.input.mouse_config.Image.OnMouseLeave;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Check.Visible := False;

  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Glow := TGlowEffect.Create(mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo);
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Glow.Name := 'Main_Config_Emulators_Pinballs_' + cEmu_Panel_Names[vNum] + '_Logo_Glow';
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Glow.Parent := mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Glow.Opacity := 0.9;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Glow.Softness := 0.4;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Glow.Enabled := False;

  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Gray := TMonochromeEffect.Create(mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo);
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Gray.Name := 'Main_Config_Emulators_Pinballs_' + cEmu_Panel_Names[vNum] + '_Logo_Gray';
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Gray.Parent := mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Gray.Enabled := not emulation.Pinballs[0].Active;

  mainScene.Config.main.R.Emulators.Pinballs[vNum].Info := TALText.Create(mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel);
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Info.Name := 'Main_Config_Emulators_' + cEmu_Panel_Names[vNum] + '_Info';
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Info.Parent := mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Info.SetBounds(110, 20, mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel.Width - 100, 40);
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Info.WordWrap := True;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Info.TextIsHtml := True;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Info.TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Info.TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Info.TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Info.Visible := True;

  mainScene.Config.main.R.Emulators.Pinballs[vNum].Action := TButton.Create(mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel);
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Action.Name := 'Main_Config_Emulators_' + cEmu_Panel_Names[vNum] + '_Action';
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Action.Parent := mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Action.SetBounds(((mainScene.Config.main.R.Emulators.Pinballs[vNum].Panel.Width / 2) - 120) + 50,
    50, 240, 34);
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Action.StyledSettings := mainScene.Config.main.R.Emulators.Pinballs[vNum].Action.StyledSettings -
    [TStyledSetting.FontColor];
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Action.OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Action.TagFloat := 1000;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Action.Tag := vNum;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Action.Visible := True;
  mainScene.Config.main.R.Emulators.Pinballs[vNum].Logo_Gray.Enabled := True;

  case vNum of
    0:
      vInstalled := uDB_AUser.Local.Emulators.Pinballs_D.Visual_Pinball;
    1:
      vInstalled := uDB_AUser.Local.Emulators.Pinballs_D.Future_Pinball;
  end;

  if vInstalled then
  begin
    mainScene.Config.main.R.Emulators.Pinballs[vNum].Info.Text := ' The emulator "<font color="#ff63cbfc">' + cEmu_Names[vNum] +
      '</font>" is installed in ExtraFE "<font color="#ff63cbfc">Successfully</font>".';
    mainScene.Config.main.R.Emulators.Pinballs[vNum].Action.Text := 'Uninstall';
    mainScene.Config.main.R.Emulators.Pinballs[vNum].Action.TextSettings.FontColor := TAlphaColorRec.Red;
    mainScene.Config.main.R.Emulators.Pinballs[vNum].Action.Enabled := True;
  end
  else
  begin
    mainScene.Config.main.R.Emulators.Pinballs[vNum].Info.Text :=
      '"<font color="#ff63cbfc">WIP</font>" Script is not ready to install "<font color="#ff63cbfc">' + cEmu_Names[vNum] + '</font>" emulator.';
    mainScene.Config.main.R.Emulators.Pinballs[vNum].Action.Text := 'Wait for update';
    mainScene.Config.main.R.Emulators.Pinballs[vNum].Action.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    mainScene.Config.main.R.Emulators.Pinballs[vNum].Action.Enabled := False;
  end;
end;

procedure ShowPinballs;
var
  vi: Integer;
begin
  mainScene.Config.main.R.Emulators.Panels[4] := TCalloutPanel.Create(mainScene.Config.main.R.Emulators.Panel);
  mainScene.Config.main.R.Emulators.Panels[4].Name := 'Main_Config_Emulators_CallPanel_' + IntToStr(4);
  mainScene.Config.main.R.Emulators.Panels[4].Parent := mainScene.Config.main.R.Emulators.Panel;
  mainScene.Config.main.R.Emulators.Panels[4].SetBounds(10, 110, mainScene.Config.main.R.Emulators.Panel.Width - 20,
    mainScene.Config.main.R.Emulators.Panel.Height - 120);
  mainScene.Config.main.R.Emulators.Panels[4].CalloutOffset := 500;
  mainScene.Config.main.R.Emulators.Panels[4].Visible := True;

  mainScene.Config.main.R.Emulators.ScrollBox[4] := TVertScrollBox.Create(mainScene.Config.main.R.Emulators.Panels[4]);
  mainScene.Config.main.R.Emulators.ScrollBox[4].Name := 'Main_Config_Emulators_Scrollbox_' + IntToStr(4);
  mainScene.Config.main.R.Emulators.ScrollBox[4].Parent := mainScene.Config.main.R.Emulators.Panels[4];
  mainScene.Config.main.R.Emulators.ScrollBox[4].SetBounds(5, 5, mainScene.Config.main.R.Emulators.Panels[4].Width - 10,
    mainScene.Config.main.R.Emulators.Panels[4].Height - 10);
  mainScene.Config.main.R.Emulators.ScrollBox[4].ShowScrollBars := True;
  mainScene.Config.main.R.Emulators.ScrollBox[4].Visible := True;
  for vi := 0 to 1 do
    CreatePinballsPanel(vi);
end;

procedure Install_Emu(vEmu_Num: Integer; vEmu_Categorie: String);
begin
  if vEmu_Categorie = 'Arcade' then
  begin
    case vEmu_Num of
      0:
        uEmulation_Arcade_Mame_Install; { Mame install script }
    end;
  end
  else if vEmu_Categorie = 'Consoles' then
  begin
    case vEmu_Num of
      8:
        uEmulation_Consoles_Nes_Install; { Nintendo NES System Install Script }
    end;
  end;

end;

procedure UnInstall_Emu(vEmu_Num: Integer; vEmu_Categorie: String);
begin
  if vEmu_Categorie = 'Arcade' then
  begin
    case vEmu_Num of
      0:
        uEmulation_Arcade_Mame_Uninstall; // Mame uninstall script
    end;
  end;
end;

procedure Start_Emu_Wizard(vButton: TButton);
var
  vEmu_Tab: String;
begin
  mainScene.Footer.Back_Blur.Enabled := True;
  case ex_main.Config.Emulators_Active_Tab of
    0:
      vEmu_Tab := 'Arcade';
    1:
      vEmu_Tab := 'Computers';
    2:
      vEmu_Tab := 'Consoles';
    3:
      vEmu_Tab := 'Handhelds';
    4:
      vEmu_Tab := 'Pinball';
  end;

  if vButton.Text = 'Install' then
    Install_Emu(vButton.Tag, vEmu_Tab)
  else if vButton.Text = 'Uninstall' then
    UnInstall_Emu(vButton.Tag, vEmu_Tab)
end;

end.
