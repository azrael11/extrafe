program ExtraFE;

uses
  System.StartUpCopy,
  FMX.Forms,
  main in 'main.pas' {Main_Form},
  loading in 'loading.pas' {Loading_Form},
  uLoad in 'loading\uLoad.pas',
  uWindows in 'code\_os\uWindows.pas',
  uMain in 'main\uMain.pas',
  uMain_Mouse in 'main\uMain_Mouse.pas',
  uSoundplayer_SetAll in 'addons\soundplayer\uSoundplayer_SetAll.pas',
  uWeather_Mouse in 'addons\weather\uWeather_Mouse.pas',
  uMain_Config_Info in 'main\configuration\uMain_Config_Info.pas',
  uMain_Actions in 'main\uMain_Actions.pas',
  uSoundplayer_Playlist_Actions in 'addons\soundplayer\uSoundplayer_Playlist_Actions.pas',
  uSoundplayer in 'addons\soundplayer\uSoundplayer.pas',
  uSoundplayer_Tag_Mp3 in 'addons\soundplayer\_tag_libraries\mp3\uSoundplayer_Tag_Mp3.pas',
  uWeather_SetAll in 'addons\weather\uWeather_SetAll.pas',
  uWeather_Config_Towns in 'addons\weather\configuration\uWeather_Config_Towns.pas',
  uWeather_Actions in 'addons\weather\uWeather_Actions.pas',
  uSnippet_Text in 'code\_snippets\uSnippet_Text.pas',
  uMain_Config_Themes in 'main\configuration\uMain_Config_Themes.pas',
  uMain_Config_Profile in 'main\configuration\uMain_Config_Profile.pas',
  uMain_Config_Addons in 'main\configuration\uMain_Config_Addons.pas',
  uMain_Config_Emulators in 'main\configuration\uMain_Config_Emulators.pas',
  uEmu_Arcade_Mame in 'emu\arcade\mame\uEmu_Arcade_Mame.pas',
  uEmu_Commands in 'code\_emu\uEmu_Commands.pas',
  uWeather_Config in 'addons\weather\uWeather_Config.pas',
  uWeather_Config_Provider in 'addons\weather\configuration\uWeather_Config_Provider.pas',
  uTTrackbar in 'code\_snippets\uTTrackbar.pas',
  uTLabel in 'code\_snippets\uTLabel.pas',
  uDatabase_ActiveUser in 'code\_database\uDatabase_ActiveUser.pas',
  uWeather_Config_Iconsets in 'addons\weather\configuration\uWeather_Config_Iconsets.pas',
  uWeather_Config_Options in 'addons\weather\configuration\uWeather_Config_Options.pas',
  emu in 'emu.pas' {Emu_Form},
  uEmu_SetAll in 'emu\uEmu_SetAll.pas',
  uEmu_Actions in 'emu\uEmu_Actions.pas',
  uEmu_Arcade_Mame_Config in 'emu\arcade\mame\uEmu_Arcade_Mame_Config.pas',
  uEmu_Arcade_Mame_Config_Directories in 'emu\arcade\mame\config\uEmu_Arcade_Mame_Config_Directories.pas',
  uEmu_Arcade_Mame_Keyboard in 'emu\arcade\mame\uEmu_Arcade_Mame_Keyboard.pas',
  uEmu_Arcade_Mame_Config_Display in 'emu\arcade\mame\config\uEmu_Arcade_Mame_Config_Display.pas',
  uEmu_Arcade_Mame_Config_Advanced in 'emu\arcade\mame\config\uEmu_Arcade_Mame_Config_Advanced.pas',
  uEmu_Arcade_Mame_Config_Screen in 'emu\arcade\mame\config\uEmu_Arcade_Mame_Config_Screen.pas',
  uEmu_Arcade_Mame_Config_OpenGL_BGFX in 'emu\arcade\mame\config\uEmu_Arcade_Mame_Config_OpenGL_BGFX.pas',
  uEmu_Arcade_Mame_Config_OpenGLShaders in 'emu\arcade\mame\config\uEmu_Arcade_Mame_Config_OpenGLShaders.pas',
  uEmu_Arcade_Mame_Config_Vector in 'emu\arcade\mame\config\uEmu_Arcade_Mame_Config_Vector.pas',
  uEmu_Arcade_Mame_Config_Sound in 'emu\arcade\mame\config\uEmu_Arcade_Mame_Config_Sound.pas',
  uEmu_Arcade_Mame_Config_Controllers in 'emu\arcade\mame\config\uEmu_Arcade_Mame_Config_Controllers.pas',
  uEmu_Arcade_Mame_Config_Controller_Mapping in 'emu\arcade\mame\config\uEmu_Arcade_Mame_Config_Controller_Mapping.pas',
  uEmu_Arcade_Mame_Config_Miscellaneous in 'emu\arcade\mame\config\uEmu_Arcade_Mame_Config_Miscellaneous.pas',
  uEmu_Arcade_Mame_Config_MiscellaneousII in 'emu\arcade\mame\config\uEmu_Arcade_Mame_Config_MiscellaneousII.pas',
  uEmu_Arcade_Mame_Config_Snap_Movie_Playback in 'emu\arcade\mame\config\uEmu_Arcade_Mame_Config_Snap_Movie_Playback.pas',
  uEmu_Arcade_Mame_Gamelist in 'emu\arcade\mame\uEmu_Arcade_Mame_Gamelist.pas',
  uEmu_Arcade_Mame_SetAll in 'emu\arcade\mame\uEmu_Arcade_Mame_SetAll.pas',
  uEmu_Arcade_Mame_Support_Files in 'emu\arcade\mame\uEmu_Arcade_Mame_Support_Files.pas',
  uEmu_Arcade_Mame_Actions in 'emu\arcade\mame\uEmu_Arcade_Mame_Actions.pas',
  uEmu_Arcade_Mame_Game_SetAll in 'emu\arcade\mame\uEmu_Arcade_Mame_Game_SetAll.pas',
  uKeyboard in 'code\_snippets\uKeyboard.pas',
  uEmu_Arcade_Mame_Filters in 'emu\arcade\mame\uEmu_Arcade_Mame_Filters.pas',
  uVirtual_Keyboard in 'code\_snippets\uVirtual_Keyboard.pas',
  uMain_Keyboard in 'main\uMain_Keyboard.pas',
  uMain_Emulation in 'main\uMain_Emulation.pas',
  uWeather_Keyboard in 'addons\weather\uWeather_Keyboard.pas',
  uWeather_MenuActions in 'addons\weather\uWeather_MenuActions.pas',
  uMain_SetAll in 'main\uMain_SetAll.pas',
  uDatabase_SqlCommands in 'code\_database\uDatabase_SqlCommands.pas',
  uEmu_Arcade_Mame_Mouse in 'emu\arcade\mame\uEmu_Arcade_Mame_Mouse.pas',
  uLoad_UserAccount in 'loading\uLoad_UserAccount.pas',
  uLoad_AllTypes in 'loading\uLoad_AllTypes.pas',
  uSoundplayer_Mouse in 'addons\soundplayer\uSoundplayer_Mouse.pas',
  uSoundplayer_Tag_Mp3_SetAll in 'addons\soundplayer\_tag_libraries\mp3\uSoundplayer_Tag_Mp3_SetAll.pas',
  uMain_Config in 'main\uMain_Config.pas',
  uTime_SetAll in 'addons\time\uTime_SetAll.pas',
  uCalendar_SetAll in 'addons\calendar\uCalendar_SetAll.pas',
  uTime_Actions in 'addons\time\uTime_Actions.pas',
  uTime_Mouse in 'addons\time\uTime_Mouse.pas',
  uTIme_Time_Actions in 'addons\time\time\uTIme_Time_Actions.pas',
  uLoad_Addons in 'loading\uLoad_Addons.pas',
  uSnippets_Colors in 'code\_snippets\uSnippets_Colors.pas',
  uMain_Config_Info_Actions in 'main\configuration\uMain_Config_Info_Actions.pas',
  uLoad_Emulation in 'loading\uLoad_Emulation.pas',
  uLoad_Sound in 'loading\uLoad_Sound.pas',
  uMain_Config_Addons_Actions in 'main\configuration\uMain_Config_Addons_Actions.pas',
  uInternet_files in 'code\_internet\uInternet_files.pas',
  uEmu_Arcade_Mame_Config_Mouse in 'emu\arcade\mame\config\uEmu_Arcade_Mame_Config_Mouse.pas',
  uEmu_Arcade_Mame_Config_Keyboard in 'emu\arcade\mame\config\uEmu_Arcade_Mame_Config_Keyboard.pas',
  uEmu_Arcade_Mame_Config_Joystick in 'emu\arcade\mame\config\uEmu_Arcade_Mame_Config_Joystick.pas',
  uEmu_Arcade_Mame_AllTypes in 'emu\arcade\mame\uEmu_Arcade_Mame_AllTypes.pas',
  uEmu_Arcade_Mame_Game_Actions in 'emu\arcade\mame\uEmu_Arcade_Mame_Game_Actions.pas',
  uSoundplayer_AllTypes in 'addons\soundplayer\uSoundplayer_AllTypes.pas',
  uSnippet_Image in 'code\_snippets\uSnippet_Image.pas',
  uSoundplayer_Keyboard in 'addons\soundplayer\uSoundplayer_Keyboard.pas',
  uSoundplayer_Playlist_Manage in 'addons\soundplayer\playlist\uSoundplayer_Playlist_Manage.pas',
  uSoundplayer_Playlist_Remove in 'addons\soundplayer\playlist\uSoundplayer_Playlist_Remove.pas',
  uSoundplayer_Playlist_Create in 'addons\soundplayer\playlist\uSoundplayer_Playlist_Create.pas',
  uSoundplayer_Player_Volume in 'addons\soundplayer\player\uSoundplayer_Player_Volume.pas',
  uSoundplayer_Tag_Get in 'addons\soundplayer\_tag_libraries\uSoundplayer_Tag_Get.pas',
  uSoundplayer_Tag_Ogg in 'addons\soundplayer\_tag_libraries\ogg\uSoundplayer_Tag_Ogg.pas',
  uSoundplayer_Tag_Ogg_SetAll in 'addons\soundplayer\_tag_libraries\ogg\uSoundplayer_Tag_Ogg_SetAll.pas',
  uSnippets in 'code\_snippets\uSnippets.pas',
  uSoundplayer_Info_Actions in 'addons\soundplayer\uSoundplayer_Info_Actions.pas',
  uSoundplayer_Tag_Mouse in 'addons\soundplayer\_tag_libraries\uSoundplayer_Tag_Mouse.pas',
  uSoundplayer_Settings_SetAll in 'addons\soundplayer\settings\uSoundplayer_Settings_SetAll.pas',
  uWeather_AllTypes in 'addons\weather\uWeather_AllTypes.pas',
  uWeather_Convert in 'addons\weather\uWeather_Convert.pas',
  uWeather_Config_Towns_Add in 'addons\weather\configuration\towns\uWeather_Config_Towns_Add.pas',
  uWeather_Config_Towns_Delete in 'addons\weather\configuration\towns\uWeather_Config_Towns_Delete.pas',
  uWeather_Config_Towns_Refresh in 'addons\weather\configuration\towns\uWeather_Config_Towns_Refresh.pas',
  uWeather_Sounds in 'addons\weather\uWeather_Sounds.pas',
  uMain_Config_Mouse in 'main\configuration\uMain_Config_Mouse.pas',
  uMain_AllTypes in 'main\uMain_AllTypes.pas',
  uMain_Config_Emulation_Arcade_Scripts_Mame_Install in 'main\configuration\emulation\arcade_scripts\mame\uMain_Config_Emulation_Arcade_Scripts_Mame_Install.pas',
  uMain_Config_Emulation_Arcade_Scripts_Mame_Uninstall in 'main\configuration\emulation\arcade_scripts\mame\uMain_Config_Emulation_Arcade_Scripts_Mame_Uninstall.pas',
  uMain_Config_Emulation_Arcade_Scripts_Mouse in 'main\configuration\emulation\arcade_scripts\uMain_Config_Emulation_Arcade_Scripts_Mouse.pas',
  uSnippet_StringGrid in 'code\_snippets\uSnippet_StringGrid.pas',
  uWeather_Forcast in 'addons\weather\uWeather_Forcast.pas',
  uEmu_Arcade_Mame_Ini in 'emu\arcade\mame\uEmu_Arcade_Mame_Ini.pas',
  uLoad_SetAll in 'loading\uLoad_SetAll.pas',
  uLoad_Actions in 'loading\uLoad_Actions.pas',
  uLoad_Mouse in 'loading\uLoad_Mouse.pas',
  uPlay_AllTypes in 'addons\play\uPlay_AllTypes.pas',
  uLoad_Stats in 'loading\uLoad_Stats.pas',
  uLoad_Keyboard in 'loading\uLoad_Keyboard.pas',
  uPlay_SetAll in 'addons\play\uPlay_SetAll.pas',
  uPlay_Mouse in 'addons\play\uPlay_Mouse.pas',
  uPlay_Actions in 'addons\play\uPlay_Actions.pas',
  uTime_Time_SetAll in 'addons\time\time\uTime_Time_SetAll.pas',
  uTime_Time_AllTypes in 'addons\time\time\uTime_Time_AllTypes.pas',
  uTime_Time_Mouse in 'addons\time\time\uTime_Time_Mouse.pas',
  uTime_AllTypes in 'addons\time\uTime_AllTypes.pas',
  uAzHung_AllTypes in 'addons\play\azhung\uAzHung_AllTypes.pas',
  uAzHung_SetAll in 'addons\play\azhung\uAzHung_SetAll.pas',
  uAzHung_Actions in 'addons\play\azhung\uAzHung_Actions.pas',
  uAzHung_Mouse in 'addons\play\azhung\uAzHung_Mouse.pas',
  uTime_Sounds in 'addons\time\uTime_Sounds.pas',
  uDatabase in 'code\_database\uDatabase.pas',
  uAzHung_Sound in 'addons\play\azhung\uAzHung_Sound.pas',
  uWeather_Providers_OpenWeatherMap in 'addons\weather\providers\uWeather_Providers_OpenWeatherMap.pas',
  uWeather_Providers_Yahoo in 'addons\weather\providers\uWeather_Providers_Yahoo.pas',
  uMain_Config_Info_Credits in 'main\configuration\uMain_Config_Info_Credits.pas',
  uSoundplayer_Sounds in 'addons\soundplayer\uSoundplayer_Sounds.pas',
  uSoundplayer_Player in 'addons\soundplayer\uSoundplayer_Player.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TLoading_Form, Loading_Form);
  Application.CreateForm(TMain_Form, Main_Form);
  Application.CreateForm(TEmu_Form, Emu_Form);
  Application.MainForm:= Loading_Form;
  Application.Run;
end.
