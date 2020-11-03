unit uSoundplayer_Keyboard;

interface

uses
  System.Classes,
  System.SysUtils;

procedure uSoundplayer_Keyboard_SetKey(vKey: string);

implementation

uses
  uLoad_AllTypes,
  uSoundplayer_AllTypes,
  uSoundplayer_Playlist,
  uSoundplayer_Playlist_Create;

procedure uSoundplayer_Keyboard_SetKey(vKey: string);
begin
  addons.soundplayer.Playlist.Manage_CtrlKey := False;
  if extrafe.prog.State = 'addon_soundplayer_create_playlist' then
  begin
    if UpperCase(vKey) = 'ESC' then
      uSoundplayer_Playlist_Create.Free
    else if UpperCase(vKey) = 'ENTER' then
      uSoundplayer_Playlist_Create.New(vSoundplayer.Playlist.Create.Main.Edit.Text);
  end
  else if extrafe.prog.State = 'addon_soundplayer_manage_playlists' then
  begin
    if UpperCase(vKey) = 'CTRL' then
      addons.soundplayer.Playlist.Manage_CtrlKey := True;
  end;

end;

end.
