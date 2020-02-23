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
// File: Tutorial01.cpp
//
// This application demonstrates creating a Direct3D 10 device
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//--------------------------------------------------------------------------------------

program Tutorial01;

// Resource file includes ICON that adds 25K to EXE size, so...
{$R 'Tutorial01.res' 'Tutorial01.rc'}

uses
  Windows,
  Messages,
  Types,
  DXGI, 
  D3D10;

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
  g_driverType: TD3D10_DriverType = D3D10_DRIVER_TYPE_NULL;
  g_pd3dDevice: ID3D10Device;
  g_pSwapChain: IDXGISwapChain;
  g_pRenderTargetView: ID3D10RenderTargetView;


//--------------------------------------------------------------------------------------
// Forward declarations
//--------------------------------------------------------------------------------------
function InitWindow(hInstance: THandle; nCmdShow: Integer): HResult; forward;
function InitDevice: HRESULT; forward;
procedure CleanupDevice; forward;
function WndProc(hWnd: HWND; message: LongWord; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall; forward;
procedure Render; forward;



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
  g_hWnd := CreateWindow('TutorialWindowClass', 'Direct3D 10 Tutorial 1: Direct3D 10 Basics', WS_OVERLAPPEDWINDOW,
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
// Create Direct3D device and swap chain
//--------------------------------------------------------------------------------------
function InitDevice: HRESULT;
var
  rc: TRect;
  width: LongWord;
  height: LongWord;
  createDeviceFlags: LongWord;
  driverTypes: array [0..1] of TD3D10_DriverType;
  sd: TDXGI_SwapChainDesc;
  driverTypeIndex: LongWord;
  pBackBuffer: ID3D10Texture2D;
  vp: TD3D10_Viewport;
begin
  GetClientRect(g_hWnd, rc);
  width := rc.right - rc.left;
  height := rc.bottom - rc.top;

  createDeviceFlags := 0;
{$IFDEF DEBUG}
  createDeviceFlags := createDeviceFlags or D3D10_CREATE_DEVICE_DEBUG;
{$ENDIF}

  driverTypes[0]:= D3D10_DRIVER_TYPE_HARDWARE;
  driverTypes[1]:= D3D10_DRIVER_TYPE_REFERENCE;

  ZeroMemory(@sd, SizeOf(sd));
  sd.BufferCount := 1;
  sd.BufferDesc.Width := width;
  sd.BufferDesc.Height := height;
  sd.BufferDesc.Format := DXGI_FORMAT_R8G8B8A8_UNORM;
  sd.BufferDesc.RefreshRate.Numerator := 60;
  sd.BufferDesc.RefreshRate.Denominator := 1;
  sd.BufferUsage := DXGI_USAGE_RENDER_TARGET_OUTPUT;
  sd.OutputWindow := g_hWnd;
  sd.SampleDesc.Count := 1;
  sd.SampleDesc.Quality := 0;
  sd.Windowed := True;

  for driverTypeIndex := 0 to High(driverTypes) do
  begin
    g_driverType := driverTypes[driverTypeIndex];
    Result := D3D10CreateDeviceAndSwapChain(nil, g_driverType, 0, createDeviceFlags,
                                        D3D10_SDK_VERSION, sd, g_pSwapChain, g_pd3dDevice);
    if SUCCEEDED(Result) then Break;
  end;
  if FAILED(Result) then Exit;

  // Create a render target view
  Result := g_pSwapChain.GetBuffer(0, ID3D10Texture2D, pBackBuffer);
  if FAILED(Result) then Exit;

  Result := g_pd3dDevice.CreateRenderTargetView(pBackBuffer, nil, @g_pRenderTargetView);
  pBackBuffer := nil;
  if FAILED(Result) then Exit;

  g_pd3dDevice.OMSetRenderTargets(1, @g_pRenderTargetView, nil);

  // Setup the viewport
  vp.Width := width;
  vp.Height := height;
  vp.MinDepth := 0.0;
  vp.MaxDepth := 1.0;
  vp.TopLeftX := 0;
  vp.TopLeftY := 0;
  g_pd3dDevice.RSSetViewports(1, @vp);

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Render the frame
//--------------------------------------------------------------------------------------
procedure Render;
var
  ClearColor: TColorArray;
begin
  // Just clear the backbuffer
  ClearColor := ColorArray(0.0, 0.125, 0.3, 1.0); //red,green,blue,alpha
  g_pd3dDevice.ClearRenderTargetView(g_pRenderTargetView, ClearColor);
  g_pSwapChain.Present(0, 0);
end;


//--------------------------------------------------------------------------------------
// Clean up the objects we've created
//--------------------------------------------------------------------------------------
procedure CleanupDevice;
begin
  if Assigned(g_pd3dDevice) then g_pd3dDevice.ClearState;

  g_pRenderTargetView := nil;
  g_pSwapChain := nil;
  g_pd3dDevice := nil;
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

  if FAILED(InitDevice) then
  begin
    CleanupDevice;
    Exit;
  end;

  // Main message loop
  while (WM_QUIT <> msg.message) do
  begin
    if PeekMessage(msg, 0, 0, 0, PM_REMOVE) then
    begin
      TranslateMessage(msg);
      DispatchMessage(msg);
    end else
      Render;
  end;

  CleanupDevice;
  
  ExitCode := msg.wParam;
end.
