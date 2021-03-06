unit uEmu_Arcade_Mame_Config_Sound;

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

  procedure uEmu_Arcade_Mame_Config_Create_Sound_Panel;

  function uEmu_Arcade_Mame_Config_Sound_LoadAudioMode(vAudioMode: String): integer;
  function uEmu_Arcade_Mame_Config_Sound_LoadSampleRate(vSampleRate: String): integer;

  procedure uEmu_Arcade_Mame_Config_Sound_SetAudioMode(vItemIndex: integer);
  procedure uEmu_Arcade_Mame_Config_Sound_SetSampleRate(vItemIndex: integer);

  procedure uEmu_Arcade_Mame_Config_Sound_CheckboxClick(vName: String);
  procedure uEmu_Arcade_Mame_Config_Sound_TrackbarOnChange(vName: String);
  procedure uEmu_Arcade_Mame_Config_Sound_ComboboxOnChange(vName: String);

implementation
uses
  uEmu_Arcade_Mame_AllTypes;

procedure uEmu_Arcade_Mame_Config_Create_Sound_Panel;
begin
  vMame.Config.Panel.Sound.Labels[0]:= TLabel.Create(vMame.Config.Scene.Right_Panels[7]);
  vMame.Config.Panel.Sound.Labels[0].Name:= 'Mame_Sound_InfoLabel_1';
  vMame.Config.Panel.Sound.Labels[0].Parent:= vMame.Config.Scene.Right_Panels[7];
  vMame.Config.Panel.Sound.Labels[0].TextSettings.HorzAlign:= TTextAlign.Trailing;
  vMame.Config.Panel.Sound.Labels[0].Text:= 'Global Options';
  vMame.Config.Panel.Sound.Labels[0].Position.Y:= 5;
  vMame.Config.Panel.Sound.Labels[0].Position.X:= vMame.Config.Scene.Right_Panels[7].Width- vMame.Config.Panel.Sound.Labels[0].Width- 10;
  vMame.Config.Panel.Sound.Labels[0].Visible:= True;

  vMame.Config.Panel.Sound.Labels[1]:= TLabel.Create(vMame.Config.Scene.Right_Panels[7]);
  vMame.Config.Panel.Sound.Labels[1].Name:= 'Mame_Sound_InfoLabel_2';
  vMame.Config.Panel.Sound.Labels[1].Parent:= vMame.Config.Scene.Right_Panels[7];
  vMame.Config.Panel.Sound.Labels[1].TextSettings.HorzAlign:= TTextAlign.Trailing;
  vMame.Config.Panel.Sound.Labels[1].Text:= 'Default options used by all games';
  vMame.Config.Panel.Sound.Labels[1].Width:= 180;
  vMame.Config.Panel.Sound.Labels[1].Position.Y:= 22;
  vMame.Config.Panel.Sound.Labels[1].Position.X:= vMame.Config.Scene.Right_Panels[7].Width- vMame.Config.Panel.Sound.Labels[1].Width- 10;
  vMame.Config.Panel.Sound.Labels[1].Visible:= True;

  vMame.Config.Panel.Sound.Groupbox[0]:= TGroupBox.Create(vMame.Config.Scene.Right_Panels[7]);
  vMame.Config.Panel.Sound.Groupbox[0].Name:= 'Mame_Sound_Groupbox_SoundMode';
  vMame.Config.Panel.Sound.Groupbox[0].Parent:= vMame.Config.Scene.Right_Panels[7];
  vMame.Config.Panel.Sound.Groupbox[0].SetBounds(10,40,((vMame.Config.Scene.Right_Panels[7].Width/ 2)- 15),70);
  vMame.Config.Panel.Sound.Groupbox[0].Text:= 'Sound mode';
  vMame.Config.Panel.Sound.Groupbox[0].Visible:= True;

  vMame.Config.Panel.Sound.Combobox[0]:= TComboBox.Create(vMame.Config.Panel.Sound.Groupbox[0]);
  vMame.Config.Panel.Sound.Combobox[0].Name:= 'Mame_Sound_Combobox_SoundMode';
  vMame.Config.Panel.Sound.Combobox[0].Parent:= vMame.Config.Panel.Sound.Groupbox[0];
  vMame.Config.Panel.Sound.Combobox[0].SetBounds(5,25,(vMame.Config.Panel.Sound.Groupbox[0].Width- 10),25);
  vMame.Config.Panel.Sound.Combobox[0].Items.Add('Auto');
  vMame.Config.Panel.Sound.Combobox[0].Items.Add('DirectSound');
  vMame.Config.Panel.Sound.Combobox[0].Items.Add('PortAudio');
  vMame.Config.Panel.Sound.Combobox[0].Items.Add('None');
  vMame.Config.Panel.Sound.Combobox[0].ItemIndex:= uEmu_Arcade_Mame_Config_Sound_LoadAudioMode(mame.Emu.Ini.OSD_SOUND_sound);
  vMame.Config.Panel.Sound.Combobox[0].OnChange:= mame.Config.Input.Mouse.Combobox.OnChange;
  vMame.Config.Panel.Sound.Combobox[0].Visible:= True;

  vMame.Config.Panel.Sound.Groupbox[1]:= TGroupBox.Create(vMame.Config.Scene.Right_Panels[7]);
  vMame.Config.Panel.Sound.Groupbox[1].Name:= 'Mame_Sound_Groupbox_SampleRate';
  vMame.Config.Panel.Sound.Groupbox[1].Parent:= vMame.Config.Scene.Right_Panels[7];
  vMame.Config.Panel.Sound.Groupbox[1].SetBounds(10,115,((vMame.Config.Scene.Right_Panels[7].Width/ 2)- 15),70);
  vMame.Config.Panel.Sound.Groupbox[1].Text:= 'Sound mode';
  vMame.Config.Panel.Sound.Groupbox[1].Visible:= True;

  vMame.Config.Panel.Sound.Combobox[1]:= TComboBox.Create(vMame.Config.Panel.Sound.Groupbox[1]);
  vMame.Config.Panel.Sound.Combobox[1].Name:= 'Mame_Sound_Combobox_SampleRate';
  vMame.Config.Panel.Sound.Combobox[1].Parent:= vMame.Config.Panel.Sound.Groupbox[1];
  vMame.Config.Panel.Sound.Combobox[1].SetBounds(5,25,(vMame.Config.Panel.Sound.Groupbox[1].Width- 10),25);
  vMame.Config.Panel.Sound.Combobox[1].Items.Add('11025');
  vMame.Config.Panel.Sound.Combobox[1].Items.Add('22050');
  vMame.Config.Panel.Sound.Combobox[1].Items.Add('44100');
  vMame.Config.Panel.Sound.Combobox[1].Items.Add('48000');
  vMame.Config.Panel.Sound.Combobox[1].ItemIndex:= uEmu_Arcade_Mame_Config_Sound_LoadSampleRate(mame.Emu.Ini.CORE_SOUND_samplerate);
  vMame.Config.Panel.Sound.Combobox[1].OnChange:= mame.Config.Input.Mouse.Combobox.OnChange;
  vMame.Config.Panel.Sound.Combobox[1].Visible:= True;

  vMame.Config.Panel.Sound.Groupbox[2]:= TGroupBox.Create(vMame.Config.Scene.Right_Panels[7]);
  vMame.Config.Panel.Sound.Groupbox[2].Name:= 'Mame_Sound_Groupbox_VolumeAttenuation';
  vMame.Config.Panel.Sound.Groupbox[2].Parent:= vMame.Config.Scene.Right_Panels[7];
  vMame.Config.Panel.Sound.Groupbox[2].SetBounds(10,190,((vMame.Config.Scene.Right_Panels[7].Width/ 2)- 15),70);
  vMame.Config.Panel.Sound.Groupbox[2].Text:= 'Volume attenuation';
  vMame.Config.Panel.Sound.Groupbox[2].Visible:= True;

  vMame.Config.Panel.Sound.Trackbar[0]:= TTrackBar.Create(vMame.Config.Panel.Sound.Groupbox[2]);
  vMame.Config.Panel.Sound.Trackbar[0].Name:= 'Mame_Sound_Trackbar_VolumeAttenuation';
  vMame.Config.Panel.Sound.Trackbar[0].Parent:= vMame.Config.Panel.Sound.Groupbox[2];
  vMame.Config.Panel.Sound.Trackbar[0].SetBounds(5,35,(vMame.Config.Panel.Sound.Groupbox[2].Width- 45),25);
  vMame.Config.Panel.Sound.Trackbar[0].Min:= -32;
  vMame.Config.Panel.Sound.Trackbar[0].Max:= 0;
  vMame.Config.Panel.Sound.Trackbar[0].Frequency:= 1;
  vMame.Config.Panel.Sound.Trackbar[0].Value:= StrToFloat(mame.Emu.Ini.CORE_SOUND_volume);
  vMame.Config.Panel.Sound.Trackbar[0].OnChange:= mame.Config.Input.Mouse.Trackbar.OnChange;
  vMame.Config.Panel.Sound.Trackbar[0].Visible:= True;

  vMame.Config.Panel.Sound.Labels[2]:= TLabel.Create(vMame.Config.Panel.Sound.Groupbox[2]);
  vMame.Config.Panel.Sound.Labels[2].Name:= 'Mame_Sound_Label_VolumeAttenuation';
  vMame.Config.Panel.Sound.Labels[2].Parent:= vMame.Config.Panel.Sound.Groupbox[2];
  vMame.Config.Panel.Sound.Labels[2].TextSettings.HorzAlign:= TTextAlign.Trailing;
  vMame.Config.Panel.Sound.Labels[2].Text:= mame.Emu.Ini.CORE_SOUND_volume+ 'dB';
  vMame.Config.Panel.Sound.Labels[2].Position.X:= 125;
  vMame.Config.Panel.Sound.Labels[2].Position.Y:= 35;
  vMame.Config.Panel.Sound.Labels[2].Visible:= True;

  vMame.Config.Panel.Sound.Groupbox[3]:= TGroupBox.Create(vMame.Config.Scene.Right_Panels[7]);
  vMame.Config.Panel.Sound.Groupbox[3].Name:= 'Mame_Sound_Groupbox_AudioLatency';
  vMame.Config.Panel.Sound.Groupbox[3].Parent:= vMame.Config.Scene.Right_Panels[7];
  vMame.Config.Panel.Sound.Groupbox[3].SetBounds(10,265,((vMame.Config.Scene.Right_Panels[7].Width/ 2)- 15),70);
  vMame.Config.Panel.Sound.Groupbox[3].Text:= 'Audio latency';
  vMame.Config.Panel.Sound.Groupbox[3].Visible:= True;

  vMame.Config.Panel.Sound.Trackbar[1]:= TTrackBar.Create(vMame.Config.Panel.Sound.Groupbox[3]);
  vMame.Config.Panel.Sound.Trackbar[1].Name:= 'Mame_Sound_Trackbar_AudioLatency';
  vMame.Config.Panel.Sound.Trackbar[1].Parent:= vMame.Config.Panel.Sound.Groupbox[3];
  vMame.Config.Panel.Sound.Trackbar[1].SetBounds(5,35,(vMame.Config.Panel.Sound.Groupbox[3].Width- 45),25);
  vMame.Config.Panel.Sound.Trackbar[1].Min:= 1;
  vMame.Config.Panel.Sound.Trackbar[1].Max:= 5;
  vMame.Config.Panel.Sound.Trackbar[1].Frequency:= 1;
  vMame.Config.Panel.Sound.Trackbar[1].Value:= StrToFloat(mame.Emu.Ini.OSD_SOUND_audio_latency);
  vMame.Config.Panel.Sound.Trackbar[1].OnChange:= mame.Config.Input.Mouse.Trackbar.OnChange;
  vMame.Config.Panel.Sound.Trackbar[1].Visible:= True;

  vMame.Config.Panel.Sound.Labels[3]:= TLabel.Create(vMame.Config.Panel.Sound.Groupbox[3]);
  vMame.Config.Panel.Sound.Labels[3].Name:= 'Mame_Sound_Label_AudioLatency';
  vMame.Config.Panel.Sound.Labels[3].Parent:= vMame.Config.Panel.Sound.Groupbox[3];
  vMame.Config.Panel.Sound.Labels[3].TextSettings.HorzAlign:= TTextAlign.Trailing;
  vMame.Config.Panel.Sound.Labels[3].Text:= mame.Emu.Ini.OSD_SOUND_audio_latency+ '/5';
  vMame.Config.Panel.Sound.Labels[3].Position.X:= 125;
  vMame.Config.Panel.Sound.Labels[3].Position.Y:= 35;
  vMame.Config.Panel.Sound.Labels[3].Visible:= True;

  vMame.Config.Panel.Sound.Checkbox:= TCheckBox.Create(vMame.Config.Scene.Right_Panels[7]);
  vMame.Config.Panel.Sound.Checkbox.Name:= 'Mame_Sound_Checkbox_UseExternalSamples';
  vMame.Config.Panel.Sound.Checkbox.Parent:= vMame.Config.Scene.Right_Panels[7];
  vMame.Config.Panel.Sound.Checkbox.SetBounds(10,350,180,19);
  vMame.Config.Panel.Sound.Checkbox.Text:= 'Use external samples';
  vMame.Config.Panel.Sound.Checkbox.Font.Style:= vMame.Config.Panel.Sound.Checkbox.Font.Style+ [TFontStyle.fsBold];
  vMame.Config.Panel.Sound.Checkbox.IsChecked:= mame.Emu.Ini.CORE_SOUND_samples;
  vMame.Config.Panel.Sound.Checkbox.OnClick:= mame.Config.Input.Mouse.Checkbox.onMouseClick;
  vMame.Config.Panel.Sound.Checkbox.Visible:= True;
end;

function uEmu_Arcade_Mame_Config_Sound_LoadAudioMode(vAudioMode: String): integer;
begin
  if vAudioMode= 'auto' then
    Result:= 0
  else if vAudioMode= 'dsound' then
    Result:= 1
  else if vAudioMode= 'portaudio' then
    Result:= 2
  else if vAudioMode= 'none' then
    Result:= 3;
end;

function uEmu_Arcade_Mame_Config_Sound_LoadSampleRate(vSampleRate: String): integer;
begin
  if vSampleRate= '11025' then
    Result:= 0
  else if vSampleRate= '22050' then
    Result:= 1
  else if vSampleRate= '44100' then
    Result:= 2
  else if vSampleRate= '48000' then
    Result:= 3;
end;

procedure uEmu_Arcade_Mame_Config_Sound_SetAudioMode(vItemIndex: integer);
begin
  case vItemIndex of
    0 : mame.Emu.Ini.OSD_SOUND_sound:= 'auto';
    1 : mame.Emu.Ini.OSD_SOUND_sound:= 'dsound';
    2 : mame.Emu.Ini.OSD_SOUND_sound:= 'portaudio';
    3 : mame.Emu.Ini.OSD_SOUND_sound:= 'none';
  end;
end;

procedure uEmu_Arcade_Mame_Config_Sound_SetSampleRate(vItemIndex: integer);
begin
  case vItemIndex of
    0 : mame.Emu.Ini.CORE_SOUND_samplerate:= '11025';
    1 : mame.Emu.Ini.CORE_SOUND_samplerate:= '22050';
    2 : mame.Emu.Ini.CORE_SOUND_samplerate:= '44100';
    3 : mame.Emu.Ini.CORE_SOUND_samplerate:= '48000';
  end;
end;

////////////////////////////////////////////////////////////////////////////////
procedure uEmu_Arcade_Mame_Config_Sound_CheckboxClick(vName: String);
begin
  if vName= 'Mame_Sound_Checkbox_UseExternalSamples' then
    mame.Emu.Ini.CORE_SOUND_samples:= vMame.Config.Panel.Sound.Checkbox.IsChecked;
end;

procedure uEmu_Arcade_Mame_Config_Sound_TrackbarOnChange(vName: String);
begin
  if vName= 'Mame_Sound_Trackbar_VolumeAttenuation' then
    begin
      mame.Emu.Ini.CORE_SOUND_volume:= FloatToStr(vMame.Config.Panel.Sound.Trackbar[0].Value);
      vMame.Config.Panel.Sound.Labels[2].Text:= mame.Emu.Ini.CORE_SOUND_volume+ 'dB';
    end
  else if vName= 'Mame_Sound_Trackbar_AudioLatency' then
    begin
      mame.Emu.Ini.OSD_SOUND_audio_latency:= FloatToStr(vMame.Config.Panel.Sound.Trackbar[1].Value);
      vMame.Config.Panel.Sound.Labels[3].Text:= mame.Emu.Ini.OSD_SOUND_audio_latency+ '/5';
    end;
end;

procedure uEmu_Arcade_Mame_Config_Sound_ComboboxOnChange(vName: String);
begin
  if vName= 'Mame_Sound_Combobox_SoundMode' then
    uEmu_Arcade_Mame_Config_Sound_SetAudioMode(vMame.Config.Panel.Sound.Combobox[0].ItemIndex)
  else if vName= 'Mame_Sound_Combobox_SampleRate' then
    uEmu_Arcade_Mame_Config_Sound_SetSampleRate(vMame.Config.Panel.Sound.Combobox[1].ItemIndex);
end;

end.
