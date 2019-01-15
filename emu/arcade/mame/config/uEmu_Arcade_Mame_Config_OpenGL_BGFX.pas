unit uEmu_Arcade_Mame_Config_OpenGL_BGFX;

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

  procedure uEmu_Arcade_Mame_Config_Create_OpenGL_BGFX_Panel;

  procedure uEmu_Arcade_Mame_Config_OpenGL_BGFX_CheckboxClick(vName: String);
  procedure uEmu_Arcade_Mame_Config_OpenGL_BGFX_ButtonClick(vName: String);
  procedure uEmu_Arcade_Mame_Config_OpenGL_BGFX_ComboboxOnChange(vName: String);
  procedure uEmu_Arcade_Mame_Config_OpenGL_BGFX_OpenDialogOnClose;


implementation
uses
  uEmu_Arcade_Mame_AllTypes;

procedure uEmu_Arcade_Mame_Config_Create_OpenGL_BGFX_Panel;
begin
  vMame.Config.Panel.OGL_BGFX.OpenDialog:= TOpenDialog.Create(vMame.Config.Scene.Right_Panels[4]);
  vMame.Config.Panel.OGL_BGFX.OpenDialog.Name:= 'Mame_OpenGL_Chains_OpenDialog';
  vMame.Config.Panel.OGL_BGFX.OpenDialog.Filter:= 'Chains (*.json)|*.json';
  vMame.Config.Panel.OGL_BGFX.OpenDialog.OnClose:= mame.Config.Input.Mouse.OpenDialog.OnClose;

  vMame.Config.Panel.OGL_BGFX.Labels[0]:= TLabel.Create(vMame.Config.Scene.Right_Panels[4]);
  vMame.Config.Panel.OGL_BGFX.Labels[0].Name:= 'Mame_OpenGL_InfoLabel_1';
  vMame.Config.Panel.OGL_BGFX.Labels[0].Parent:= vMame.Config.Scene.Right_Panels[4];
  vMame.Config.Panel.OGL_BGFX.Labels[0].TextSettings.HorzAlign:= TTextAlign.Trailing;
  vMame.Config.Panel.OGL_BGFX.Labels[0].Text:= 'Global Options';
  vMame.Config.Panel.OGL_BGFX.Labels[0].Position.Y:= 5;
  vMame.Config.Panel.OGL_BGFX.Labels[0].Position.X:= vMame.Config.Scene.Right_Panels[4].Width- vMame.Config.Panel.OGL_BGFX.Labels[0].Width- 10;
  vMame.Config.Panel.OGL_BGFX.Labels[0].Visible:= True;

  vMame.Config.Panel.OGL_BGFX.Labels[1]:= TLabel.Create(vMame.Config.Scene.Right_Panels[4]);
  vMame.Config.Panel.OGL_BGFX.Labels[1].Name:= 'Mame_OpenGL_InfoLabel_2';
  vMame.Config.Panel.OGL_BGFX.Labels[1].Parent:= vMame.Config.Scene.Right_Panels[4];
  vMame.Config.Panel.OGL_BGFX.Labels[1].TextSettings.HorzAlign:= TTextAlign.Trailing;
  vMame.Config.Panel.OGL_BGFX.Labels[1].Text:= 'Default options used by all games';
  vMame.Config.Panel.OGL_BGFX.Labels[1].Width:= 180;
  vMame.Config.Panel.OGL_BGFX.Labels[1].Position.Y:= 22;
  vMame.Config.Panel.OGL_BGFX.Labels[1].Position.X:= vMame.Config.Scene.Right_Panels[4].Width- vMame.Config.Panel.OGL_BGFX.Labels[1].Width- 10;
  vMame.Config.Panel.OGL_BGFX.Labels[1].Visible:= True;

  vMame.Config.Panel.OGL_BGFX.Groupbox[0]:= TGroupBox.Create(vMame.Config.Scene.Right_Panels[4]);
  vMame.Config.Panel.OGL_BGFX.Groupbox[0].Name:= 'Mame_OpenGL_Groupbox_OpenGLSettings';
  vMame.Config.Panel.OGL_BGFX.Groupbox[0].Parent:= vMame.Config.Scene.Right_Panels[4];
  vMame.Config.Panel.OGL_BGFX.Groupbox[0].SetBounds(10,40,(vMame.Config.Scene.Right_Panels[4].Width- 20),240);
  vMame.Config.Panel.OGL_BGFX.Groupbox[0].Text:= 'OpenGL settings';
  vMame.Config.Panel.OGL_BGFX.Groupbox[0].Visible:= True;

  vMame.Config.Panel.OGL_BGFX.Groupbox[1]:= TGroupBox.Create(vMame.Config.Panel.OGL_BGFX.Groupbox[0]);
  vMame.Config.Panel.OGL_BGFX.Groupbox[1].Name:= 'Mame_OpenGL_Groupbox_GLSLFilter';
  vMame.Config.Panel.OGL_BGFX.Groupbox[1].Parent:= vMame.Config.Panel.OGL_BGFX.Groupbox[0];
  vMame.Config.Panel.OGL_BGFX.Groupbox[1].SetBounds(5,25,(vMame.Config.Panel.OGL_BGFX.Groupbox[0].Width/ 2),70);
  vMame.Config.Panel.OGL_BGFX.Groupbox[1].Text:= 'GLSL filter';
  vMame.Config.Panel.OGL_BGFX.Groupbox[1].Visible:= True;

  vMame.Config.Panel.OGL_BGFX.Combobox:= TComboBox.Create(vMame.Config.Panel.OGL_BGFX.Groupbox[1]);
  vMame.Config.Panel.OGL_BGFX.Combobox.Name:= 'Mame_OpenGL_Combobox_GLSLFilter';
  vMame.Config.Panel.OGL_BGFX.Combobox.Parent:= vMame.Config.Panel.OGL_BGFX.Groupbox[1];
  vMame.Config.Panel.OGL_BGFX.Combobox.SetBounds(5,25,(vMame.Config.Panel.OGL_BGFX.Groupbox[1].Width- 10),25);
  vMame.Config.Panel.OGL_BGFX.Combobox.Items.Add('Plain');
  vMame.Config.Panel.OGL_BGFX.Combobox.Items.Add('Bilinear');
  vMame.Config.Panel.OGL_BGFX.Combobox.Items.Add('Bicubic');
  vMame.Config.Panel.OGL_BGFX.Combobox.ItemIndex:= mame.Emu.Ini.OpenGL_gl_glsl_filter;
  vMame.Config.Panel.OGL_BGFX.Combobox.OnChange:= mame.Config.Input.Mouse.Combobox.OnChange;
  vMame.Config.Panel.OGL_BGFX.Combobox.Visible:= True;

  vMame.Config.Panel.OGL_BGFX.Checkbox[0]:= TCheckBox.Create(vMame.Config.Panel.OGL_BGFX.Groupbox[0]);
  vMame.Config.Panel.OGL_BGFX.Checkbox[0].Name:= 'Mame_OpenGL_Checkbox_EnableGLSL';
  vMame.Config.Panel.OGL_BGFX.Checkbox[0].Parent:= vMame.Config.Panel.OGL_BGFX.Groupbox[0];
  vMame.Config.Panel.OGL_BGFX.Checkbox[0].SetBounds(10,100,180,19);
  vMame.Config.Panel.OGL_BGFX.Checkbox[0].Text:= 'Enable GLSL';
  vMame.Config.Panel.OGL_BGFX.Checkbox[0].Font.Style:= vMame.Config.Panel.OGL_BGFX.Checkbox[0].Font.Style+ [TFontStyle.fsBold];
  vMame.Config.Panel.OGL_BGFX.Checkbox[0].IsChecked:= mame.Emu.Ini.OpenGL_gl_glsl;
  vMame.Config.Panel.OGL_BGFX.Checkbox[0].OnClick:= mame.Config.Input.Mouse.Checkbox.onMouseClick;
  vMame.Config.Panel.OGL_BGFX.Checkbox[0].Visible:= True;

  vMame.Config.Panel.OGL_BGFX.Checkbox[1]:= TCheckBox.Create(vMame.Config.Panel.OGL_BGFX.Groupbox[0]);
  vMame.Config.Panel.OGL_BGFX.Checkbox[1].Name:= 'Mame_OpenGL_Checkbox_ForcePowerOfTwoTextures';
  vMame.Config.Panel.OGL_BGFX.Checkbox[1].Parent:= vMame.Config.Panel.OGL_BGFX.Groupbox[0];
  vMame.Config.Panel.OGL_BGFX.Checkbox[1].SetBounds(10,120,180,19);
  vMame.Config.Panel.OGL_BGFX.Checkbox[1].Text:= 'Force powere of two textures';
  vMame.Config.Panel.OGL_BGFX.Checkbox[1].Font.Style:= vMame.Config.Panel.OGL_BGFX.Checkbox[1].Font.Style+ [TFontStyle.fsBold];
  vMame.Config.Panel.OGL_BGFX.Checkbox[1].IsChecked:= mame.Emu.Ini.OpenGL_gl_forcepow2texture;
  vMame.Config.Panel.OGL_BGFX.Checkbox[1].OnClick:= mame.Config.Input.Mouse.Checkbox.onMouseClick;
  vMame.Config.Panel.OGL_BGFX.Checkbox[1].Visible:= True;

  vMame.Config.Panel.OGL_BGFX.Checkbox[2]:= TCheckBox.Create(vMame.Config.Panel.OGL_BGFX.Groupbox[0]);
  vMame.Config.Panel.OGL_BGFX.Checkbox[2].Name:= 'Mame_OpenGL_Checkbox_DontUseGL_ARB_texture_rectangle';
  vMame.Config.Panel.OGL_BGFX.Checkbox[2].Parent:= vMame.Config.Panel.OGL_BGFX.Groupbox[0];
  vMame.Config.Panel.OGL_BGFX.Checkbox[2].SetBounds(10,140,180,19);
  vMame.Config.Panel.OGL_BGFX.Checkbox[2].Text:= 'Don''t use GL_ARB_texture_rectangle';
  vMame.Config.Panel.OGL_BGFX.Checkbox[2].Font.Style:= vMame.Config.Panel.OGL_BGFX.Checkbox[2].Font.Style+ [TFontStyle.fsBold];
  vMame.Config.Panel.OGL_BGFX.Checkbox[2].IsChecked:= mame.Emu.Ini.OpenGL_gl_notexturerect;
  vMame.Config.Panel.OGL_BGFX.Checkbox[2].OnClick:= mame.Config.Input.Mouse.Checkbox.onMouseClick;
  vMame.Config.Panel.OGL_BGFX.Checkbox[2].Visible:= True;

  vMame.Config.Panel.OGL_BGFX.Checkbox[3]:= TCheckBox.Create(vMame.Config.Panel.OGL_BGFX.Groupbox[0]);
  vMame.Config.Panel.OGL_BGFX.Checkbox[3].Name:= 'Mame_OpenGL_Checkbox_EnableVBO';
  vMame.Config.Panel.OGL_BGFX.Checkbox[3].Parent:= vMame.Config.Panel.OGL_BGFX.Groupbox[0];
  vMame.Config.Panel.OGL_BGFX.Checkbox[3].SetBounds(10,160,180,19);
  vMame.Config.Panel.OGL_BGFX.Checkbox[3].Text:= 'Enable VBO';
  vMame.Config.Panel.OGL_BGFX.Checkbox[3].Font.Style:= vMame.Config.Panel.OGL_BGFX.Checkbox[3].Font.Style+ [TFontStyle.fsBold];
  vMame.Config.Panel.OGL_BGFX.Checkbox[3].IsChecked:= mame.Emu.Ini.OpenGL_gl_vbo;
  vMame.Config.Panel.OGL_BGFX.Checkbox[3].OnClick:= mame.Config.Input.Mouse.Checkbox.onMouseClick;
  vMame.Config.Panel.OGL_BGFX.Checkbox[3].Visible:= True;

  vMame.Config.Panel.OGL_BGFX.Checkbox[4]:= TCheckBox.Create(vMame.Config.Panel.OGL_BGFX.Groupbox[0]);
  vMame.Config.Panel.OGL_BGFX.Checkbox[4].Name:= 'Mame_OpenGL_Checkbox_EnablePBO';
  vMame.Config.Panel.OGL_BGFX.Checkbox[4].Parent:= vMame.Config.Panel.OGL_BGFX.Groupbox[0];
  vMame.Config.Panel.OGL_BGFX.Checkbox[4].SetBounds(10,180,180,19);
  vMame.Config.Panel.OGL_BGFX.Checkbox[4].Text:= 'Enable PBO';
  vMame.Config.Panel.OGL_BGFX.Checkbox[4].Font.Style:= vMame.Config.Panel.OGL_BGFX.Checkbox[4].Font.Style+ [TFontStyle.fsBold];
  vMame.Config.Panel.OGL_BGFX.Checkbox[4].IsChecked:= mame.Emu.Ini.OpenGL_gl_pbo;
  vMame.Config.Panel.OGL_BGFX.Checkbox[4].OnClick:= mame.Config.Input.Mouse.Checkbox.onMouseClick;
  vMame.Config.Panel.OGL_BGFX.Checkbox[4].Visible:= True;

  vMame.Config.Panel.OGL_BGFX.Checkbox[5]:= TCheckBox.Create(vMame.Config.Panel.OGL_BGFX.Groupbox[0]);
  vMame.Config.Panel.OGL_BGFX.Checkbox[5].Name:= 'Mame_OpenGL_Checkbox_ForceSynchronyBetweenCPUAndGPU';
  vMame.Config.Panel.OGL_BGFX.Checkbox[5].Parent:= vMame.Config.Panel.OGL_BGFX.Groupbox[0];
  vMame.Config.Panel.OGL_BGFX.Checkbox[5].SetBounds(10,200,380,19);
  vMame.Config.Panel.OGL_BGFX.Checkbox[5].Text:= 'Force synchrony between CPU and GPU (your own risk)';
  vMame.Config.Panel.OGL_BGFX.Checkbox[5].Font.Style:= vMame.Config.Panel.OGL_BGFX.Checkbox[5].Font.Style+ [TFontStyle.fsBold];
  vMame.Config.Panel.OGL_BGFX.Checkbox[5].IsChecked:= mame.Emu.Ini.OpenGL_gl_glsl_sync;
  vMame.Config.Panel.OGL_BGFX.Checkbox[5].OnClick:= mame.Config.Input.Mouse.Checkbox.onMouseClick;
  vMame.Config.Panel.OGL_BGFX.Checkbox[5].Visible:= True;

  vMame.Config.Panel.OGL_BGFX.Groupbox[2]:= TGroupBox.Create(vMame.Config.Scene.Right_Panels[4]);
  vMame.Config.Panel.OGL_BGFX.Groupbox[2].Name:= 'Mame_OpenGL_Groupbox_BGFXScreenChains';
  vMame.Config.Panel.OGL_BGFX.Groupbox[2].Parent:= vMame.Config.Scene.Right_Panels[4];
  vMame.Config.Panel.OGL_BGFX.Groupbox[2].SetBounds(10,285,(vMame.Config.Scene.Right_Panels[4].Width- 20),120);
  vMame.Config.Panel.OGL_BGFX.Groupbox[2].Text:= 'BGFX screen chains';
  vMame.Config.Panel.OGL_BGFX.Groupbox[2].Visible:= True;

  vMame.Config.Panel.OGL_BGFX.Edit:= TEdit.Create(vMame.Config.Panel.OGL_BGFX.Groupbox[2]);
  vMame.Config.Panel.OGL_BGFX.Edit.Name:= 'Mame_OpenGL_Edit_BGFXScreenChains';
  vMame.Config.Panel.OGL_BGFX.Edit.Parent:= vMame.Config.Panel.OGL_BGFX.Groupbox[2];
  vMame.Config.Panel.OGL_BGFX.Edit.SetBounds(10,40,(vMame.Config.Panel.OGL_BGFX.Groupbox[2].Width - 20),20);
  vMame.Config.Panel.OGL_BGFX.Edit.Text:= mame.Emu.Ini.BGFX_bgfx_screen_chains;
  vMame.Config.Panel.OGL_BGFX.Edit.Visible:= True;

  vMame.Config.Panel.OGL_BGFX.Button[0]:= TButton.Create(vMame.Config.Panel.OGL_BGFX.Groupbox[2]);
  vMame.Config.Panel.OGL_BGFX.Button[0].Name:= 'Mame_OpenGL_Button_SelectChain';
  vMame.Config.Panel.OGL_BGFX.Button[0].Parent:= vMame.Config.Panel.OGL_BGFX.Groupbox[2];
  vMame.Config.Panel.OGL_BGFX.Button[0].SetBounds(10,80,100,20);
  vMame.Config.Panel.OGL_BGFX.Button[0].Text:= 'Select chain';
  vMame.Config.Panel.OGL_BGFX.Button[0].OnClick:= mame.Config.Input.Mouse.Button.onMouseClick;
  vMame.Config.Panel.OGL_BGFX.Button[0].Visible:= True;

  vMame.Config.Panel.OGL_BGFX.Button[1]:= TButton.Create(vMame.Config.Panel.OGL_BGFX.Groupbox[2]);
  vMame.Config.Panel.OGL_BGFX.Button[1].Name:= 'Mame_OpenGL_Button_ResetChain';
  vMame.Config.Panel.OGL_BGFX.Button[1].Parent:= vMame.Config.Panel.OGL_BGFX.Groupbox[2];
  vMame.Config.Panel.OGL_BGFX.Button[1].SetBounds((vMame.Config.Panel.OGL_BGFX.Groupbox[2].Width- 110),80,100,20);
  vMame.Config.Panel.OGL_BGFX.Button[1].Text:= 'Reset chain';
  vMame.Config.Panel.OGL_BGFX.Button[1].OnClick:= mame.Config.Input.Mouse.Button.onMouseClick;
  vMame.Config.Panel.OGL_BGFX.Button[1].Visible:= True;
end;

////////////////////////////////////////////////////////////////////////////////
procedure uEmu_Arcade_Mame_Config_OpenGL_BGFX_CheckboxClick(vName: String);
begin
  if vName= 'Mame_OpenGL_Checkbox_EnableGLSL' then
    mame.Emu.Ini.OpenGL_gl_glsl:= vMame.Config.Panel.OGL_BGFX.Checkbox[0].IsChecked
  else if vName= 'Mame_OpenGL_Checkbox_ForcePowerOfTwoTextures' then
    mame.Emu.Ini.OpenGL_gl_forcepow2texture:= vMame.Config.Panel.OGL_BGFX.Checkbox[1].IsChecked
  else if vName= 'Mame_OpenGL_Checkbox_DontUseGL_ARB_texture_rectangle' then
    mame.Emu.Ini.OpenGL_gl_notexturerect:= vMame.Config.Panel.OGL_BGFX.Checkbox[2].IsChecked
  else if vName= 'Mame_OpenGL_Checkbox_EnableVBO' then
    mame.Emu.Ini.OpenGL_gl_vbo:= vMame.Config.Panel.OGL_BGFX.Checkbox[3].IsChecked
  else if vName= 'Mame_OpenGL_Checkbox_EnablePBO' then
    mame.Emu.Ini.OpenGL_gl_pbo:= vMame.Config.Panel.OGL_BGFX.Checkbox[4].IsChecked
  else if vName= 'Mame_OpenGL_Checkbox_ForceSynchronyBetweenCPUAndGPU' then
    mame.Emu.Ini.OpenGL_gl_glsl_sync:= vMame.Config.Panel.OGL_BGFX.Checkbox[5].IsChecked
end;

procedure uEmu_Arcade_Mame_Config_OpenGL_BGFX_ButtonClick(vName: String);
begin
  if vName= 'Mame_OpenGL_Button_SelectChain' then
    begin
      mame.Config.Panel.OGL_BGFX.OpenDialog_Result:= 'Select_Chain';
      vMame.Config.Panel.OGL_BGFX.OpenDialog.Execute;
    end
  else if vName= 'Mame_OpenGL_Button_ResetChain' then
    begin
      vMame.Config.Panel.OGL_BGFX.Edit.Text:= 'default';
      mame.Emu.Ini.BGFX_bgfx_screen_chains:= 'default';
    end;
end;

procedure uEmu_Arcade_Mame_Config_OpenGL_BGFX_ComboboxOnChange(vName: String);
begin
  if vName= 'Mame_OpenGL_Combobox_GLSLFilter' then
    mame.Emu.Ini.OpenGL_gl_glsl_filter:= vMame.Config.Panel.OGL_BGFX.Combobox.ItemIndex;
end;

procedure uEmu_Arcade_Mame_Config_OpenGL_BGFX_OpenDialogOnClose;
begin
  if mame.Config.Panel.OGL_BGFX.OpenDialog_Result= 'Select_Chain' then
    begin
      vMame.Config.Panel.OGL_BGFX.Edit.Text:= ExtractFileName(vMame.Config.Panel.OGL_BGFX.OpenDialog.FileName);
      mame.Emu.Ini.BGFX_bgfx_screen_chains:= vMame.Config.Panel.OGL_BGFX.Edit.Text;
    end;
end;

end.
