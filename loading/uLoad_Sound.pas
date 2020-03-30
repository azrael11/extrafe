unit uLoad_Sound;

interface

uses
  System.Classes,
  System.SysUtils,
  Winapi.Windows,
  FMX.Dialogs,
  Bass,
  Bass_FX;

procedure Load;
procedure Load_Sounds;

implementation

uses
  main,
  uLoad_AllTypes;

procedure Load;
begin


  // Edo ola prepei na mpoune se katastasi try with expections.
  if (HiWord(BASS_GetVersion)) <> BASSVERSION then
  begin

  end;

  if (HiWord(BASS_GetVersion) <> BASSVERSION) then
  begin
    MessageBox(0, 'An incorrect version of BASS.DLL was loaded', nil, MB_ICONERROR);
    Halt;
  end;
  if not BASS_Init(-1, 44100, BASS_DEVICE_SPEAKERS, Winapi.Windows.HANDLE_PTR(Main_Form), nil) then
    MessageBox(0, 'Error initializing audio!', nil, MB_ICONERROR);
  if BASS_FX_GetVersion = 0 then
  begin
    ShowMessage('Plug in : BASS_FX not loading : incorrect version (Bass = ' + BASSVERSIONTEXT + ' <> ' + BASS_FX_GetVersion.ToString + ' (Bass error : ' +
      Bass_ErrorGetCode.ToString + ')');
  end;

  Load_Sounds;
end;

procedure Load_Sounds;
begin
  // Add Sound Effects
  // General
  sound.str_fx.general[0] := BASS_StreamCreateFile(False, PChar(extrafe.prog.Path + 'data\sounds\general\click.mp3'), 0, 0, 0
{$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
  sound.str_fx.general[1] := BASS_StreamCreateFile(False, PChar(extrafe.prog.Path + 'data\sounds\general\no.mp3'), 0, 0, 0
{$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
  sound.str_fx.general[2] := BASS_StreamCreateFile(False, PChar(extrafe.prog.Path + 'data\sounds\general\type.mp3'), 0, 0, 0
{$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
  sound.str_fx.general[3] := BASS_StreamCreateFile(False, PChar(extrafe.prog.Path + 'data\sounds\general\change.mp3'), 0, 0, 0
{$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
  sound.str_fx.general[4] := BASS_StreamCreateFile(False, PChar(extrafe.prog.Path + 'data\sounds\general\see.mp3'), 0, 0, 0
{$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
  sound.str_fx.general[5] := BASS_StreamCreateFile(False, PChar(extrafe.prog.Path + 'data\sounds\general\unsee.mp3'), 0, 0, 0
{$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
  sound.str_fx.general[10] := BASS_StreamCreateFile(False, PChar(extrafe.prog.Path + 'data\sounds\general\addon_open.mp3'), 0, 0, 0
{$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
  sound.str_fx.general[11] := BASS_StreamCreateFile(False, PChar(extrafe.prog.Path + 'data\sounds\general\addon_close.mp3'), 0, 0, 0
{$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
end;

end.
