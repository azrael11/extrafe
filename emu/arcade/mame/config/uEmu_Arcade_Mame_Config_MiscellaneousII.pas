unit uEmu_Arcade_Mame_Config_MiscellaneousII;

interface
uses
  System.Classes,
  System.UITypes,
  System.SysUtils,
  FMX.StdCtrls,
  FMX.Types,
  FMX.Edit,
  FMX.Listbox,
  FMX.Dialogs;

  procedure uEmu_Arcade_Mame_Config_Create_MiscellaneousII_Panel;

  procedure uEmu_Arcade_Mame_Config_MiscII_CheckboxClick(vName: String);
  procedure uEmu_Arcade_Mame_Config_MiscII_TrackbarOnChange(vName: String);
  procedure uEmu_Arcade_Mame_Config_MiscII_ButtonClick(vName: String);
  procedure uEmu_Arcade_Mame_Config_MiscII_ComboboxOnChange(vName: String);
  procedure uEmu_Arcade_Mame_Config_MiscII_Opendialog;

implementation
uses
  uDB_AUser,
  uWindows,
  uEmu_Arcade_Mame_AllTypes;

procedure uEmu_Arcade_Mame_Config_Create_MiscellaneousII_Panel;
var
  vi: Integer;
begin
  mame.Config.Panel.Misc_II.ComboIsSet:= False;

  vMame.Config.Panel.Misc_II.OpenDialog:= TOpenDialog.Create(vMame.Config.Scene.Right_Panels[11]);
  vMame.Config.Panel.Misc_II.OpenDialog.Name:= 'Mame_Misc_Cheat_OpenDialog';
  vMame.Config.Panel.Misc_II.OpenDialog.Filter:= 'scripts (*.lua)|*.lua';
  vMame.Config.Panel.Misc_II.OpenDialog.OnClose:= mame.Config.Input.Mouse.OpenDialog.OnClose;

  vMame.Config.Panel.Misc_II.Labels[0]:= TLabel.Create(vMame.Config.Scene.Right_Panels[11]);
  vMame.Config.Panel.Misc_II.Labels[0].Name:= 'Mame_MiscII_InfoLabel_1';
  vMame.Config.Panel.Misc_II.Labels[0].Parent:= vMame.Config.Scene.Right_Panels[11];
  vMame.Config.Panel.Misc_II.Labels[0].TextSettings.HorzAlign:= TTextAlign.Trailing;
  vMame.Config.Panel.Misc_II.Labels[0].Text:= 'Global Options';
  vMame.Config.Panel.Misc_II.Labels[0].Position.Y:= 5;
  vMame.Config.Panel.Misc_II.Labels[0].Position.X:= vMame.Config.Scene.Right_Panels[11].Width- vMame.Config.Panel.Misc_II.Labels[0].Width- 10;
  vMame.Config.Panel.Misc_II.Labels[0].Visible:= True;

  vMame.Config.Panel.Misc_II.Labels[1]:= TLabel.Create(vMame.Config.Scene.Right_Panels[11]);
  vMame.Config.Panel.Misc_II.Labels[1].Name:= 'Mame_MiscII_InfoLabel_2';
  vMame.Config.Panel.Misc_II.Labels[1].Parent:= vMame.Config.Scene.Right_Panels[11];
  vMame.Config.Panel.Misc_II.Labels[1].TextSettings.HorzAlign:= TTextAlign.Trailing;
  vMame.Config.Panel.Misc_II.Labels[1].Text:= 'Default options used by all games';
  vMame.Config.Panel.Misc_II.Labels[1].Width:= 180;
  vMame.Config.Panel.Misc_II.Labels[1].Position.Y:= 22;
  vMame.Config.Panel.Misc_II.Labels[1].Position.X:= vMame.Config.Scene.Right_Panels[11].Width- vMame.Config.Panel.Misc_II.Labels[1].Width- 10;
  vMame.Config.Panel.Misc_II.Labels[1].Visible:= True;

  vMame.Config.Panel.Misc_II.Groupbox[0]:= TGroupBox.Create(vMame.Config.Scene.Right_Panels[11]);
  vMame.Config.Panel.Misc_II.Groupbox[0].Name:= 'Mame_MiscII_Groupbox_AutobootDelay';
  vMame.Config.Panel.Misc_II.Groupbox[0].Parent:= vMame.Config.Scene.Right_Panels[11];
  vMame.Config.Panel.Misc_II.Groupbox[0].SetBounds(10,40,((vMame.Config.Scene.Right_Panels[11].Width/ 2)- 15),70);
  vMame.Config.Panel.Misc_II.Groupbox[0].Text:= 'Autoboot delay';
  vMame.Config.Panel.Misc_II.Groupbox[0].Visible:= True;

  vMame.Config.Panel.Misc_II.Trackbar:= TTrackBar.Create(vMame.Config.Panel.Misc_II.Groupbox[0]);
  vMame.Config.Panel.Misc_II.Trackbar.Name:= 'Mame_MiscII_Trackbar_AutobootDelay';
  vMame.Config.Panel.Misc_II.Trackbar.Parent:= vMame.Config.Panel.Misc_II.Groupbox[0];
  vMame.Config.Panel.Misc_II.Trackbar.SetBounds(5,35,(vMame.Config.Panel.Misc_II.Groupbox[0].Width- 45),25);
  vMame.Config.Panel.Misc_II.Trackbar.Min:= 0;
  vMame.Config.Panel.Misc_II.Trackbar.Max:= 5;
  vMame.Config.Panel.Misc_II.Trackbar.Frequency:= 1;
  vMame.Config.Panel.Misc_II.Trackbar.Value:= 0;
  vMame.Config.Panel.Misc_II.Trackbar.Value:= StrToFloat(mame.Emu.Ini.SCRIPTING_autoboot_delay);
  vMame.Config.Panel.Misc_II.Trackbar.OnChange:= mame.Config.Input.Mouse.Trackbar.OnChange;
  vMame.Config.Panel.Misc_II.Trackbar.Visible:= True;

  vMame.Config.Panel.Misc_II.Labels[2]:= TLabel.Create(vMame.Config.Panel.Misc_II.Groupbox[0]);
  vMame.Config.Panel.Misc_II.Labels[2].Name:= 'Mame_MiscII_Label_AutobootDelay';
  vMame.Config.Panel.Misc_II.Labels[2].Parent:= vMame.Config.Panel.Misc_II.Groupbox[0];
  vMame.Config.Panel.Misc_II.Labels[2].TextSettings.HorzAlign:= TTextAlign.Trailing;
  vMame.Config.Panel.Misc_II.Labels[2].Text:= mame.Emu.Ini.SCRIPTING_autoboot_delay;
  vMame.Config.Panel.Misc_II.Labels[2].Position.X:= 125;
  vMame.Config.Panel.Misc_II.Labels[2].Position.Y:= 35;
  vMame.Config.Panel.Misc_II.Labels[2].Visible:= True;

  vMame.Config.Panel.Misc_II.Groupbox[1]:= TGroupBox.Create(vMame.Config.Scene.Right_Panels[11]);
  vMame.Config.Panel.Misc_II.Groupbox[1].Name:= 'Mame_MiscII_Groupbox_AutobootScript';
  vMame.Config.Panel.Misc_II.Groupbox[1].Parent:= vMame.Config.Scene.Right_Panels[11];
  vMame.Config.Panel.Misc_II.Groupbox[1].SetBounds(10,115,(vMame.Config.Scene.Right_Panels[11].Width- 20),100);
  vMame.Config.Panel.Misc_II.Groupbox[1].Text:= 'Autoboot script';
  vMame.Config.Panel.Misc_II.Groupbox[1].Visible:= True;

  vMame.Config.Panel.Misc_II.Edit[0]:= TEdit.Create(vMame.Config.Panel.Misc_II.Groupbox[1]);
  vMame.Config.Panel.Misc_II.Edit[0].Name:= 'Mame_MiscII_Edit_AutobootScript';
  vMame.Config.Panel.Misc_II.Edit[0].Parent:= vMame.Config.Panel.Misc_II.Groupbox[1];
  vMame.Config.Panel.Misc_II.Edit[0].SetBounds(5,30,(vMame.Config.Panel.Misc_II.Groupbox[1].Width- 10),20);
  if mame.Emu.Ini.SCRIPTING_autoboot_script= '' then
    vMame.Config.Panel.Misc_II.Edit[0].Text:= 'None'
  else
    vMame.Config.Panel.Misc_II.Edit[0].Text:= mame.Emu.Ini.SCRIPTING_autoboot_script;
  vMame.Config.Panel.Misc_II.Edit[0].Visible:= True;

  vMame.Config.Panel.Misc_II.Button[0]:= TButton.Create(vMame.Config.Panel.Misc_II.Groupbox[1]);
  vMame.Config.Panel.Misc_II.Button[0].Name:= 'Mame_MiscII_Button_SelectLUAScript';
  vMame.Config.Panel.Misc_II.Button[0].Parent:= vMame.Config.Panel.Misc_II.Groupbox[1];
  vMame.Config.Panel.Misc_II.Button[0].SetBounds(10,60,100,20);
  vMame.Config.Panel.Misc_II.Button[0].Text:= 'Select LUA script';
  vMame.Config.Panel.Misc_II.Button[0].OnClick:= mame.Config.Input.Mouse.Button.onMouseClick;
  vMame.Config.Panel.Misc_II.Button[0].Visible:= True;

  vMame.Config.Panel.Misc_II.Button[1]:= TButton.Create(vMame.Config.Panel.Misc_II.Groupbox[1]);
  vMame.Config.Panel.Misc_II.Button[1].Name:= 'Mame_MiscII_Button_ReseLUAScript';
  vMame.Config.Panel.Misc_II.Button[1].Parent:= vMame.Config.Panel.Misc_II.Groupbox[1];
  vMame.Config.Panel.Misc_II.Button[1].SetBounds((vMame.Config.Panel.Misc_II.Groupbox[1].Width- 110),60,100,20);
  vMame.Config.Panel.Misc_II.Button[1].Text:= 'Reset LUA script';
  vMame.Config.Panel.Misc_II.Button[1].OnClick:= mame.Config.Input.Mouse.Button.onMouseClick;
  vMame.Config.Panel.Misc_II.Button[1].Visible:= True;

  vMame.Config.Panel.Misc_II.Groupbox[2]:= TGroupBox.Create(vMame.Config.Scene.Right_Panels[11]);
  vMame.Config.Panel.Misc_II.Groupbox[2].Name:= 'Mame_MiscII_Groupbox_InGameMameInterfaceLanguage';
  vMame.Config.Panel.Misc_II.Groupbox[2].Parent:= vMame.Config.Scene.Right_Panels[11];
  vMame.Config.Panel.Misc_II.Groupbox[2].SetBounds(10,220,(vMame.Config.Scene.Right_Panels[11].Width- 20),70);
  vMame.Config.Panel.Misc_II.Groupbox[2].Text:= 'In game MAME interface language';
  vMame.Config.Panel.Misc_II.Groupbox[2].Visible:= True;

  vMame.Config.Panel.Misc_II.Combobox[0]:= TComboBox.Create(vMame.Config.Panel.Misc_II.Groupbox[2]);
  vMame.Config.Panel.Misc_II.Combobox[0].Name:= 'Mame_MiscII_Combobox_Language';
  vMame.Config.Panel.Misc_II.Combobox[0].Parent:= vMame.Config.Panel.Misc_II.Groupbox[2];
  vMame.Config.Panel.Misc_II.Combobox[0].SetBounds(5,30,(vMame.Config.Panel.Misc_II.Groupbox[2].Width- 10),25);
  vMame.Config.Panel.Misc_II.Combobox[0].Items.AddStrings(uWindows.Folder_Names(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.Path+ 'language'));
  vMame.Config.Panel.Misc_II.Combobox[0].ItemIndex:= vMame.Config.Panel.Misc_II.Combobox[0].Items.IndexOf(mame.Emu.Ini.CORE_MISC_language);
  vMame.Config.Panel.Misc_II.Combobox[0].OnChange:= mame.Config.Input.Mouse.Combobox.OnChange;
  vMame.Config.Panel.Misc_II.Combobox[0].Visible:= True;

  vMame.Config.Panel.Misc_II.Checkbox[0]:= TCheckBox.Create(vMame.Config.Scene.Right_Panels[11]);
  vMame.Config.Panel.Misc_II.Checkbox[0].Name:= 'Mame_MiscII_Checkbox_EnableInternalLUAPlugins';
  vMame.Config.Panel.Misc_II.Checkbox[0].Parent:= vMame.Config.Scene.Right_Panels[11];
  vMame.Config.Panel.Misc_II.Checkbox[0].SetBounds(10,295,180,19);
  vMame.Config.Panel.Misc_II.Checkbox[0].Text:= 'Enable internal LUA plugins';
  vMame.Config.Panel.Misc_II.Checkbox[0].Font.Style:= vMame.Config.Panel.Misc_II.Checkbox[0].Font.Style+ [TFontStyle.fsBold];
  vMame.Config.Panel.Misc_II.Checkbox[0].IsChecked:= mame.Emu.Ini.SCRIPTING_plugins;
  vMame.Config.Panel.Misc_II.Checkbox[0].OnClick:= mame.Config.Input.Mouse.Checkbox.onMouseClick;
  vMame.Config.Panel.Misc_II.Checkbox[0].Visible:= True;

  vMame.Config.Panel.Misc_II.Groupbox[3]:= TGroupBox.Create(vMame.Config.Scene.Right_Panels[11]);
  vMame.Config.Panel.Misc_II.Groupbox[3].Name:= 'Mame_MiscII_Groupbox_EnableLUAPlugins';
  vMame.Config.Panel.Misc_II.Groupbox[3].Parent:= vMame.Config.Scene.Right_Panels[11];
  vMame.Config.Panel.Misc_II.Groupbox[3].SetBounds(10,315,(vMame.Config.Scene.Right_Panels[11].Width- 20),100);
  vMame.Config.Panel.Misc_II.Groupbox[3].Text:= 'Enable plugins';
  vMame.Config.Panel.Misc_II.Groupbox[3].Visible:= True;

  vMame.Config.Panel.Misc_II.Edit[1]:= TEdit.Create(vMame.Config.Panel.Misc_II.Groupbox[3]);
  vMame.Config.Panel.Misc_II.Edit[1].Name:= 'Mame_MiscII_Edit_EnableLUAPlugins';
  vMame.Config.Panel.Misc_II.Edit[1].Parent:= vMame.Config.Panel.Misc_II.Groupbox[3];
  vMame.Config.Panel.Misc_II.Edit[1].SetBounds(10,30,(vMame.Config.Panel.Misc_II.Groupbox[3].Width- 20),20);
  if mame.Emu.Ini.SCRIPTING_plugin= '' then
    vMame.Config.Panel.Misc_II.Edit[1].Text:= 'None'
  else
    vMame.Config.Panel.Misc_II.Edit[1].Text:= mame.Emu.Ini.SCRIPTING_plugin;
  vMame.Config.Panel.Misc_II.Edit[1].Visible:= True;

  vMame.Config.Panel.Misc_II.Combobox[1]:= TComboBox.Create(vMame.Config.Panel.Misc_II.Groupbox[3]);
  vMame.Config.Panel.Misc_II.Combobox[1].Name:= 'Mame_MiscII_Combobox_LUAPlugin';
  vMame.Config.Panel.Misc_II.Combobox[1].Parent:= vMame.Config.Panel.Misc_II.Groupbox[3];
  vMame.Config.Panel.Misc_II.Combobox[1].SetBounds(15,58,120,25);
  vMame.Config.Panel.Misc_II.Combobox[1].Items.Add('Select a plugin');
  vMame.Config.Panel.Misc_II.Combobox[1].Items.Add('cheat');
  vMame.Config.Panel.Misc_II.Combobox[1].Items.Add('cheatfind');
  vMame.Config.Panel.Misc_II.Combobox[1].Items.Add('console');
  vMame.Config.Panel.Misc_II.Combobox[1].Items.Add('data');
  vMame.Config.Panel.Misc_II.Combobox[1].Items.Add('dummy');
  vMame.Config.Panel.Misc_II.Combobox[1].Items.Add('gdbstub');
  vMame.Config.Panel.Misc_II.Combobox[1].Items.Add('hiscore');
  vMame.Config.Panel.Misc_II.Combobox[1].Items.Add('layout');
  vMame.Config.Panel.Misc_II.Combobox[1].Items.Add('portname');
  vMame.Config.Panel.Misc_II.Combobox[1].Items.Add('timer');
  vMame.Config.Panel.Misc_II.Combobox[1].ItemIndex:= 0;
  vMame.Config.Panel.Misc_II.Combobox[1].OnChange:= mame.Config.Input.Mouse.Combobox.OnChange;
  vMame.Config.Panel.Misc_II.Combobox[1].Visible:= True;

  vMame.Config.Panel.Misc_II.Button[2]:= TButton.Create(vMame.Config.Panel.Misc_II.Groupbox[3]);
  vMame.Config.Panel.Misc_II.Button[2].Name:= 'Mame_MiscII_Button_ResetLUAPlugins';
  vMame.Config.Panel.Misc_II.Button[2].Parent:= vMame.Config.Panel.Misc_II.Groupbox[3];
  vMame.Config.Panel.Misc_II.Button[2].SetBounds((vMame.Config.Panel.Misc_II.Groupbox[3].Width- 135),60,100,20);
  vMame.Config.Panel.Misc_II.Button[2].Text:= 'Reset LUA plugins';
  vMame.Config.Panel.Misc_II.Button[2].OnClick:= mame.Config.Input.Mouse.Button.onMouseClick;
  vMame.Config.Panel.Misc_II.Button[2].Visible:= True;

  vMame.Config.Panel.Misc_II.Checkbox[1]:= TCheckBox.Create(vMame.Config.Scene.Right_Panels[11]);
  vMame.Config.Panel.Misc_II.Checkbox[1].Name:= 'Mame_MiscII_Checkbox_SaveNVRAMOnExit';
  vMame.Config.Panel.Misc_II.Checkbox[1].Parent:= vMame.Config.Scene.Right_Panels[11];
  vMame.Config.Panel.Misc_II.Checkbox[1].SetBounds(10,430,180,19);
  vMame.Config.Panel.Misc_II.Checkbox[1].Text:= 'Save NVRAM on exit';
  vMame.Config.Panel.Misc_II.Checkbox[1].Font.Style:= vMame.Config.Panel.Misc_II.Checkbox[1].Font.Style+ [TFontStyle.fsBold];
  vMame.Config.Panel.Misc_II.Checkbox[1].IsChecked:= mame.Emu.Ini.CORE_MISC_nvram_save;
  vMame.Config.Panel.Misc_II.Checkbox[1].OnClick:= mame.Config.Input.Mouse.Checkbox.onMouseClick;
  vMame.Config.Panel.Misc_II.Checkbox[1].Visible:= True;

  vMame.Config.Panel.Misc_II.Checkbox[2]:= TCheckBox.Create(vMame.Config.Scene.Right_Panels[11]);
  vMame.Config.Panel.Misc_II.Checkbox[2].Name:= 'Mame_MiscII_Checkbox_EnableRewindSavestates';
  vMame.Config.Panel.Misc_II.Checkbox[2].Parent:= vMame.Config.Scene.Right_Panels[11];
  vMame.Config.Panel.Misc_II.Checkbox[2].SetBounds(10,450,480,19);
  vMame.Config.Panel.Misc_II.Checkbox[2].Text:= 'Enable rewind savestates';
  vMame.Config.Panel.Misc_II.Checkbox[2].Font.Style:= vMame.Config.Panel.Misc_II.Checkbox[2].Font.Style+ [TFontStyle.fsBold];
  vMame.Config.Panel.Misc_II.Checkbox[2].IsChecked:= mame.Emu.Ini.CORE_STATE_rewind;
  vMame.Config.Panel.Misc_II.Checkbox[2].OnClick:= mame.Config.Input.Mouse.Checkbox.onMouseClick;
  vMame.Config.Panel.Misc_II.Checkbox[2].Visible:= True;

end;

////////////////////////////////////////////////////////////////////////////////
procedure uEmu_Arcade_Mame_Config_MiscII_CheckboxClick(vName: String);
begin
  if vName= 'Mame_MiscII_Checkbox_EnableInternalLUAPlugins' then
    mame.Emu.Ini.SCRIPTING_plugins:= vMame.Config.Panel.Misc_II.Checkbox[0].IsChecked
  else if vName= 'Mame_MiscII_Checkbox_SaveNVRAMOnExit' then
    mame.Emu.Ini.CORE_MISC_nvram_save:= vMame.Config.Panel.Misc_II.Checkbox[1].IsChecked
  else if vName= 'Mame_MiscII_Checkbox_EnableRewindSavestates' then
    mame.Emu.Ini.CORE_STATE_rewind:= vMame.Config.Panel.Misc_II.Checkbox[2].IsChecked;
end;

procedure uEmu_Arcade_Mame_Config_MiscII_TrackbarOnChange(vName: String);
begin
  if vName= 'Mame_MiscII_Trackbar_AutobootDelay' then
    begin
      mame.Emu.Ini.SCRIPTING_autoboot_delay:= FloatToStr(vMame.Config.Panel.Misc_II.Trackbar.Value);
      vMame.Config.Panel.Misc_II.Labels[2].Text:= mame.Emu.Ini.SCRIPTING_autoboot_delay;
    end;
end;

procedure uEmu_Arcade_Mame_Config_MiscII_ButtonClick(vName: String);
begin
  if vName= 'Mame_MiscII_Button_SelectLUAScript' then
    begin
      mame.Config.Panel.Misc_II.OpenDialog_Result:= 'Select_LUA_Script';
      vMame.Config.Panel.Misc_II.OpenDialog.Execute;
    end
  else if vName= 'Mame_MiscII_Button_ReseLUAScript' then
    begin
      mame.Emu.Ini.SCRIPTING_autoboot_script:= '';
      vMame.Config.Panel.Misc_II.Edit[0].Text:= 'None';
    end
  else if vName= 'Mame_MiscII_Button_ResetLUAPlugins' then
    begin
      mame.Emu.Ini.SCRIPTING_plugin:= '';
      vMame.Config.Panel.Misc_II.Edit[1].Text:= 'None';
    end;
end;

procedure uEmu_Arcade_Mame_Config_MiscII_ComboboxOnChange(vName: String);
var
  vLanguage: String;
  vItemIndex: Integer;
begin
  if vName= 'Mame_MiscII_Combobox_Language' then
    begin
      vLanguage:=  vMame.Config.Panel.Misc_II.Combobox[0].Items.Strings[vMame.Config.Panel.Misc_II.Combobox[0].ItemIndex];
      if vLanguage= 'Ellinika' then
        vLanguage:= 'Greek'
      else if vLanguage= 'Skopjie' then
        vLanguage:= 'Macedonian';
      mame.Emu.Ini.CORE_MISC_language:= vLanguage;
    end
  else if vName= 'Mame_MiscII_Combobox_LUAPlugin' then
    begin
      vItemIndex:= vMame.Config.Panel.Misc_II.Combobox[1].ItemIndex;
      if vItemIndex<> 0 then
        if mame.Config.Panel.Misc_II.ComboIsSet= False then
          begin
            if mame.Emu.Ini.SCRIPTING_plugin='' then
              mame.Emu.Ini.SCRIPTING_plugin:= vMame.Config.Panel.Misc_II.Combobox[1].Items.Strings[vItemIndex]
            else
              mame.Emu.Ini.SCRIPTING_plugin:= mame.Emu.Ini.SCRIPTING_plugin+ ','+ vMame.Config.Panel.Misc_II.Combobox[1].Items.Strings[vItemIndex];
            vMame.Config.Panel.Misc_II.Edit[1].Text:= mame.Emu.Ini.SCRIPTING_plugin;
            mame.Config.Panel.Misc_II.ComboIsSet:= True;
            vMame.Config.Panel.Misc_II.Combobox[1].ItemIndex:= 0;
          end
        else
          mame.Config.Panel.Misc_II.ComboIsSet:= False;
    end;
end;

procedure uEmu_Arcade_Mame_Config_MiscII_Opendialog;
var
  vString: String;
begin
  if mame.Config.Panel.Misc_II.OpenDialog_Result= 'Select_LUA_Script' then
    begin
      mame.Emu.Ini.SCRIPTING_autoboot_script:= ExtractFileName(vMame.Config.Panel.Misc_II.OpenDialog.FileName);
      vString:= Trim(Copy(mame.Emu.Ini.SCRIPTING_autoboot_script, 0 , length(mame.Emu.Ini.SCRIPTING_autoboot_script)- 4));
      vMame.Config.Panel.Misc_II.Edit[0].Text:= vString;
    end;
end;

end.
