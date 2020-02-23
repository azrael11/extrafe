(*----------------------------------------------------------------------------*
 *  Direct3D10 sample from DirectX SDK                                        *
 *  Delphi adaptation by Alexey Barkovoy (e-mail: directx@clootie.ru)         *
 *                                                                            *
 *  Supported compilers: Delphi 5,6,7,9; FreePascal 2.0                       *
 *                                                                            *
 *  Latest version can be downloaded from:                                    *
 *     http://www.clootie.ru                                                  *
 *     http://sourceforge.net/projects/delphi-dx9sdk                          *
 *----------------------------------------------------------------------------*
 *  $Id: $
 *----------------------------------------------------------------------------*)
//--------------------------------------------------------------------------------------
// File: Tutorial00.cpp
//
// This tutorial sets up a windows application with a window and a message pump
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//--------------------------------------------------------------------------------------

program Tutorial00;

// Resource file includes ICON that adds 25K to EXE size, so...
{$R 'Tutorial00.res' 'Tutorial00.rc'}

uses
  Windows, Messages;


const // from "resource.h"
  IDS_APP_TITLE           = 103;

  IDR_MAINFRAME           = 128;
  IDD_TUTORIAL1_DIALOG    = 102;
  IDD_ABOUTBOX            = 103;
  IDM_ABOUT               = 104;
  IDM_EXIT                = 105;
  IDI_TUTORIAL1           = 107;
  IDI_SMALL               = 108;
  IDC_TUTORIAL1           = 109;
  IDC_MYICON              = 2;
  IDC_STATIC              = -1;


//--------------------------------------------------------------------------------------
// Global Variables
//--------------------------------------------------------------------------------------
var
  g_hInst: THandle = 0;
  g_hWnd: HWND     = 0;


//--------------------------------------------------------------------------------------
// Forward declarations
//--------------------------------------------------------------------------------------
function InitWindow(hInstance: THandle; nCmdShow: Integer): HResult; forward;
function WndProc(hWnd: HWND; message: LongWord; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall; forward;


function Rect(Left, Top, Right, Bottom: Integer): TRect;
begin
  Result.Left := Left;
  Result.Top := Top;
  Result.Bottom := Bottom;
  Result.Right := Right;
end;


//--------------------------------------------------------------------------------------
// Register class and create window
//--------------------------------------------------------------------------------------
function InitWindow(hInstance: THandle; nCmdShow: Integer): HRESULT;
var
  wcex: TWndClassEx;
  rc: TRect;
begin
  Result:= E_FAIL;

  // Register class
  wcex.cbSize := SizeOf(wcex);
  wcex.style          := CS_HREDRAW or CS_VREDRAW;
  wcex.lpfnWndProc    := @WndProc;
  wcex.cbClsExtra     := 0;
  wcex.cbWndExtra     := 0;
  wcex.hInstance      := hInstance;
  wcex.hIcon          := LoadIcon(hInstance, PAnsiChar(IDI_TUTORIAL1));
  wcex.hCursor        := LoadCursor(0, IDC_ARROW);
  wcex.hbrBackground  := HBRUSH(COLOR_WINDOW+1);
  wcex.lpszMenuName   := nil;
  wcex.lpszClassName  := 'TutorialWindowClass';
  wcex.hIconSm        := LoadIcon(wcex.hInstance, PAnsiChar(IDI_TUTORIAL1));
  if RegisterClassEx(wcex) = 0 then Exit;

  // Create window
  g_hInst := hInstance;
  rc := Rect(0, 0, 640, 480);
  AdjustWindowRect(rc, WS_OVERLAPPEDWINDOW, False);
  g_hWnd := CreateWindow('TutorialWindowClass', 'Direct3D 10 Tutorial 0: Setting Up Window', WS_OVERLAPPEDWINDOW,
                         Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT), rc.right - rc.left, rc.bottom - rc.top, 0, 0, hInstance, nil);
  if (g_hWnd = 0) then Exit;

  ShowWindow(g_hWnd, nCmdShow);

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Called every time the application receives a message
//--------------------------------------------------------------------------------------
function WndProc(hWnd: HWND; message: LongWord; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  ps: PAINTSTRUCT;
  //hdc: Windows.HDC;
begin
  case message of
    WM_PAINT:
    begin
      {hdc := }BeginPaint(hWnd, ps);
      EndPaint(hWnd, ps);
    end;

    WM_DESTROY:
      PostQuitMessage(0);

   else
      Result:= DefWindowProc(hWnd, message, wParam, lParam);
      Exit;
  end;

  Result:= 0;
end;



//--------------------------------------------------------------------------------------
// Entry point to the program. Initializes everything and goes into a message processing
// loop. Idle time is used to render the scene.
//--------------------------------------------------------------------------------------
var
  msg: TMsg;
begin
  {$WARNINGS OFF} // turn off "platform specific" warning. Yes, we are compiling only for Windows!!!
  if FAILED(InitWindow(MainInstance, CmdShow)) then Exit;
  {$WARNINGS ON}

  // Main message loop
  while GetMessage(msg, 0, 0, 0) do
  begin
    TranslateMessage(msg);
    DispatchMessage(msg);
  end;

  ExitCode := msg.wParam;
end.
