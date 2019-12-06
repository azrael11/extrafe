unit uEmu_Commands;

interface

uses
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  FMX.Dialogs,
  FMX.Forms,
  Winapi.Windows,
  Winapi.ShellApi;

function Capture_Output(vDosProg, vParameters: WideString): TstringList;
function Capture_Output_Alt(const cDrive, vFullPath, vCMDLine, vOutSave: string): Boolean;

function Run_Game(const FileName, Parameters, dir: string; CmdShow: Integer): Boolean;


{Alternative options of exec and wait}
//function fEmu_Commands_RunCommand(const FileName, Parameters, dir: string; CmdShow: Integer): Boolean;
//function RunProcess(FileName: string; ShowCmd: DWORD; wait: Boolean; ProcID: PDWORD): Longword;
//function ShellExecAndWait(const FileName, Parameters, dir: string; CmdShow: Integer): Boolean;
//function ExecWithShellExecute(AName, CLine: string; run_mode: string; var iErr: int64): Boolean;
//function ExecWithShell(AName, CLine: string; run_mode: string; var hProcess: DWORD; var iErr: int64): Boolean;
//function ExecWithCmdLine(AName, CLine: string; var pInfo: TProcessInformation; var iErr: int64): Boolean;

implementation

uses
  emu;

function Capture_Output(vDosProg, vParameters: WideString): TstringList;
// procedure RunDosInMemo(DosApp: string; AMemo:TMemo);
const
  READ_BUFFER_SIZE = 10000000;
var
  Security: TSecurityAttributes;
  readableEndOfPipe, writeableEndOfPipe: THandle;
  start: TStartUpInfo;
  ProcessInfo: TProcessInformation;
  Buffer: PAnsiChar;
  BytesRead: DWORD;
  AppRunning: DWORD;
  vDosApp: string;
begin
  vDosApp := vDosProg + vParameters;
  Result := TstringList.Create;
  Security.nLength := SizeOf(TSecurityAttributes);
  Security.bInheritHandle := True;
  Security.lpSecurityDescriptor := nil;

  if CreatePipe( { var } readableEndOfPipe, { var } writeableEndOfPipe, @Security, 0) then
  begin
    Buffer := AllocMem(READ_BUFFER_SIZE + 1);
    FillChar(start, SizeOf(start), #0);
    start.cb := SizeOf(start);

    // Set up members of the STARTUPINFO structure.
    // This structure specifies the STDIN and STDOUT handles for redirection.
    // - Redirect the output and error to the writeable end of our pipe.
    // - We must still supply a valid StdInput handle (because we used STARTF_USESTDHANDLES to swear that all three handles will be valid)
    start.dwFlags := start.dwFlags or STARTF_USESTDHANDLES;
    start.hStdInput := GetStdHandle(STD_INPUT_HANDLE);
    // we're not redirecting stdInput; but we still have to give it a valid handle
    start.hStdOutput := writeableEndOfPipe;
    // we give the writeable end of the pipe to the child process; we read from the readable end
    start.hStdError := writeableEndOfPipe;

    // We can also choose to say that the wShowWindow member contains a value.
    // In our case we want to force the console window to be hidden.
    start.dwFlags := start.dwFlags + STARTF_USESHOWWINDOW;
    start.wShowWindow := SW_HIDE;

    // Don't forget to set up members of the PROCESS_INFORMATION structure.
    ProcessInfo := Default (TProcessInformation);

    // WARNING: The unicode version of CreateProcess (CreateProcessW) can modify the command-line "DosApp" string.
    // Therefore "DosApp" cannot be a pointer to read-only memory, or an ACCESS_VIOLATION will occur.
    // We can ensure it's not read-only with the RTL function: UniqueString
    UniqueString( { var } vDosApp);

    if CreateProcess(nil, PChar(vDosApp), nil, nil, True, NORMAL_PRIORITY_CLASS, nil, nil, start,
      { var } ProcessInfo) then
    begin
      // Wait for the application to terminate, as it writes it's output to the pipe.
      // WARNING: If the console app outputs more than 10000000 bytes (ReadBuffer),
      // it will block on writing to the pipe and *never* close.
      repeat
        AppRunning := WaitForSingleObject(ProcessInfo.hProcess, 1000);
        Application.ProcessMessages;
      until (AppRunning <> WAIT_TIMEOUT);

      // Read the contents of the pipe out of the readable end
      // WARNING: if the console app never writes anything to the StdOutput, then ReadFile will block and never return
      repeat
        BytesRead := 0;
        ReadFile(readableEndOfPipe, Buffer[0], READ_BUFFER_SIZE, { var } BytesRead, nil);
        Buffer[BytesRead] := #0;
        OemToAnsi(Buffer, Buffer);
        Result.Text := Result.Text + String(Buffer);
        // AMemo.Text := AMemo.text + String(Buffer);
      until (BytesRead < READ_BUFFER_SIZE);
    end;
    FreeMem(Buffer);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(readableEndOfPipe);
    CloseHandle(writeableEndOfPipe);
  end;
end;

function Capture_Output_Alt(const cDrive, vFullPath, vCMDLine, vOutSave: string): Boolean;
var
  start: TStartUpInfo;
  procInfo: TProcessInformation;
  tmpName: string;
  tmp: THandle;
  tmpSec: TSecurityAttributes;
  res: TstringList;
  return: Cardinal;
begin
  Result := False;
  try
    tmpName := 'Test.tmp';
    FillChar(tmpSec, SizeOf(tmpSec), #0);
    tmpSec.nLength := SizeOf(tmpSec);
    tmpSec.bInheritHandle := True;
    tmp := FileCreate(PChar(tmpName));
    try
      FillChar(start, SizeOf(start), #0);
      start.cb := SizeOf(start);
      start.hStdOutput := tmp;
      start.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
      start.wShowWindow := SW_HIDE;
      // Start The Program
      if CreateProcess(nil, PChar(vFullPath + vCMDLine), nil, nil, True, 0, nil, PChar(cDrive), start,
        procInfo) then
      begin
        SetPriorityClass(procInfo.hProcess, Idle_Priority_Class);
        WaitForSingleObject(procInfo.hProcess, Infinite);
        GetExitCodeProcess(procInfo.hProcess, return);
        Result := (return = 0);
        CloseHandle(procInfo.hThread);
        CloseHandle(procInfo.hProcess);
        CloseHandle(tmp);
        // Add the output
        res := TstringList.Create;
        try
          res.LoadFromFile(tmpName);
          res.SaveToFile('E:\game.txt');
        finally
          res.Free;
        end;
        // Windows.CopyFile(Pchar(tmpName),pchar(vOutSave),FALSE);
        DeleteFile(PChar(tmpName));
      end
      else
      begin
        ShowMessage(PChar(SysErrorMessage(GetLastError())) + ' RunCaptured Error');
      end;
    except
      CloseHandle(tmp);
      DeleteFile(PChar(tmpName)); { *Converted from DeleteFile* }
      raise;
    end;
  finally
  end;
end;

function ShellExecAndWait(const FileName, Parameters, dir: string; CmdShow: Integer): Boolean;
var
  Sei: TShellExecuteInfo;
  tmpProcessInformation: TProcessInformation;
begin
  FillChar(Sei, SizeOf(Sei), #0);
  Sei.cbSize := SizeOf(Sei);
  Sei.fMask := SEE_MASK_DOENVSUBST or SEE_MASK_FLAG_NO_UI or SEE_MASK_NOCLOSEPROCESS;
  Sei.lpFile := PChar(FileName);
  Sei.lpParameters := PChar(Parameters);
  Sei.lpdirectory := PChar(dir);
  Sei.nShow := CmdShow;
  Result := ShellExecuteEx(@Sei);
  if Result then
  begin
    while WaitForSingleObject(tmpProcessInformation.hProcess, 10) > 0 do
    begin
      Application.ProcessMessages;
      keybd_event(Ord('A'), 0, 0, 0);
    end;
    WaitForInputIdle(Sei.hProcess, Infinite);
    WaitForSingleObject(Sei.hProcess, Infinite);
    CloseHandle(Sei.hProcess);
  end;
end;

function fEmu_Commands_RunCommand(const FileName, Parameters, dir: string; CmdShow: Integer): Boolean;
var
  Sei: TShellExecuteInfo;
begin
  FillChar(Sei, SizeOf(Sei), #0);
  Sei.cbSize := SizeOf(Sei);
  Sei.fMask := SEE_MASK_DOENVSUBST or SEE_MASK_FLAG_NO_UI or SEE_MASK_NOCLOSEPROCESS;
  Sei.lpFile := PChar(FileName);
  Sei.lpParameters := PChar(Parameters);
  Sei.lpdirectory := PChar(dir);
  Sei.nShow := CmdShow;
  Result := ShellExecuteExW(@Sei);
end;

function Run_Game(const FileName, Parameters, dir: string; CmdShow: Integer): Boolean;
var
  Sei: TShellExecuteInfo;
  tmpProcessInformation: TProcessInformation;
begin
  FillChar(Sei, SizeOf(Sei), #0);
  Sei.cbSize := SizeOf(Sei);
  Sei.fMask := SEE_MASK_DOENVSUBST or SEE_MASK_FLAG_NO_UI or SEE_MASK_NOCLOSEPROCESS;
  Sei.lpFile := PChar(FileName);
  Sei.lpParameters := PChar(Parameters);
  Sei.lpdirectory := PChar(dir);
  Sei.nShow := CmdShow;
  Result := ShellExecuteExW(@Sei);
  if Result then
  begin
    // while WaitForSingleObject(tmpProcessInformation.hProcess, 10) > 0 do
    // begin
    // Application.ProcessMessages;
    // keybd_event(Ord('A'), 0, 0, 0);
    // end;
//    if WaitForInputIdle(Sei.hProcess, Infinite) = 0 then
//    begin
      if WaitForSingleObject(Sei.hProcess, Infinite) = 0 then
        CloseHandle(Sei.hProcess);
//    end;
  end;
end;

function RunProcess(FileName: string; ShowCmd: DWORD; wait: Boolean; ProcID: PDWORD): Longword;
var
  StartupInfo: TStartUpInfo;
  ProcessInfo: TProcessInformation;
begin
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
  StartupInfo.wShowWindow := ShowCmd;
  if not CreateProcess(nil, @FileName[1], nil, nil, False, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
    nil, StartupInfo, ProcessInfo) then
    Result := WAIT_FAILED
  else
  begin
    if wait = False then
    begin
      if ProcID <> nil then
        ProcID^ := ProcessInfo.dwProcessId;
      Result := WAIT_FAILED;
      exit;
    end;
    WaitForSingleObject(ProcessInfo.hProcess, Infinite);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
  end;
  if ProcessInfo.hProcess <> 0 then
    CloseHandle(ProcessInfo.hProcess);
  if ProcessInfo.hThread <> 0 then
    CloseHandle(ProcessInfo.hThread);
end;

function ExecWithShellExecute(AName, CLine: string; run_mode: string; var iErr: int64): Boolean;
begin
  if run_mode = '' then
    run_mode := 'open';
  iErr := ShellExecute(0, // PWideChar(run_mode
    nil, PWideChar('/C ' + AName), PWideChar(CLine), PWideChar(ExtractFilePath(AName)), SW_HIDE);
  Result := iErr > 32;
end;

function ExecWithShell(AName, CLine: string; run_mode: string; var hProcess: DWORD; var iErr: int64): Boolean;
var
  ShExecInfo: TShellExecuteInfo;
begin
  Result := False;
  hProcess := 0;
  ZeroMemory(@ShExecInfo, SizeOf(ShExecInfo));
  ShExecInfo.cbSize := SizeOf(ShExecInfo);
  ShExecInfo.fMask := SEE_MASK_NOCLOSEPROCESS;
  if run_mode = '' then
    ShExecInfo.lpVerb := nil
  else
    ShExecInfo.lpVerb := PWideChar(run_mode);
  ShExecInfo.lpFile := PWideChar(AName);
  ShExecInfo.lpParameters := PWideChar(CLine);
  ShExecInfo.lpdirectory := PWideChar(ExtractFilePath(AName));
  ShExecInfo.nShow := SW_HIDE;
  ShExecInfo.hInstApp := 0;
  if ShellExecuteEx(@ShExecInfo) then
  begin
    hProcess := ShExecInfo.hProcess;
    Result := hProcess > 0;
  end
  else
    iErr := GetLastError;
end;

function ExecWithCmdLine(AName, CLine: string; var pInfo: TProcessInformation; var iErr: int64): Boolean;
var
  sInfo: TStartUpInfo;
  AppName, AppWDir, CmdLine: string;
begin
  AppName := AName; // Full path & name of Your App.
  AppWDir := ExtractFileDir(AppName);
  CmdLine := ' ' + CLine;
  ZeroMemory(@pInfo, SizeOf(pInfo));
  ZeroMemory(@sInfo, SizeOf(TStartUpInfo));
  sInfo.cb := SizeOf(TStartUpInfo);
  sInfo.dwFlags := STARTF_FORCEONFEEDBACK or STARTF_FORCEOFFFEEDBACK;
  Result := CreateProcess(PWideChar(AppName), PWideChar(CmdLine), nil, nil, False,
    CREATE_DEFAULT_ERROR_MODE or CREATE_NEW_PROCESS_GROUP or NORMAL_PRIORITY_CLASS or CREATE_NO_WINDOW, nil,
    PWideChar(AppWDir), sInfo, pInfo);
  if not Result then
    iErr := GetLastError;
end;

end.
