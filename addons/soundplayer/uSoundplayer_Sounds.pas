unit uSoundplayer_Sounds;

interface

uses
  System.Classes,
  Bass;

procedure Load;
procedure Free;

implementation

uses
  uLoad_AllTypes;

procedure Load;
begin
  //Lock
  addons.soundplayer.Sound.Effects[0] := BASS_StreamCreateFile(False,
    PChar(addons.soundplayer.Path.Sounds + 'a_sp_lock.mp3'), 0, 0, 0
    {$IFDEF UNICODE} or BASS_UNICODE{$ENDIF});
  //Lock
  addons.soundplayer.Sound.Effects[1] := BASS_StreamCreateFile(False,
    PChar(addons.soundplayer.Path.Sounds + 'a_sp_unlock.mp3'), 0, 0, 0
    {$IFDEF UNICODE} or BASS_UNICODE{$ENDIF});
end;

procedure Free;
begin
  BASS_StreamFree(addons.soundplayer.Sound.effects[0]);
  BASS_StreamFree(addons.soundplayer.Sound.effects[1]);
end;

end.
