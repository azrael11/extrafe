unit uMain_Sounds;

interface
uses
  System.Classes,
  BASS;

procedure Load;
procedure Free;

implementation
uses
  uLoad_AllTypes;

procedure Load;
begin
  //Effects
  ex_main.Sounds.effects[0] := BASS_StreamCreateFile(False,
    PChar(ex_main.Paths.Sounds + 'main_addon_open.mp3'), 0, 0, 0
    {$IFDEF UNICODE} or BASS_UNICODE{$ENDIF});
  ex_main.Sounds.effects[1] := BASS_StreamCreateFile(False,
    PChar(ex_main.Paths.Sounds + 'main_addon_close.mp3'), 0, 0, 0
    {$IFDEF UNICODE} or BASS_UNICODE{$ENDIF});
  //Mouse Effects
  ex_main.Sounds.mouse[0] :=  BASS_StreamCreateFile(False,
    PChar(ex_main.Paths.Sounds + 'main_blob.mp3'), 0, 0, 0
    {$IFDEF UNICODE} or BASS_UNICODE{$ENDIF});
end;

procedure Free;
begin
  //Effects
  BASS_StreamFree(ex_main.Sounds.effects[0]);
  BASS_StreamFree(ex_main.Sounds.effects[1]);
  //Mouse Effects
  BASS_StreamFree(ex_main.Sounds.mouse[0]);
end;

end.
