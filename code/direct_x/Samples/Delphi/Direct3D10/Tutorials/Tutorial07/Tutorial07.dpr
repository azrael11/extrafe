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
// File: Tutorial07.cpp
//
// This application demonstrates texturing
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//--------------------------------------------------------------------------------------

program Tutorial07;

// Resource file includes ICON that adds 25K to EXE size, so...
{$R 'Tutorial07.res' 'Tutorial07.rc'}
{%File 'Tutorial07.fx'}

uses
  Windows,
  Messages,
  Types,
  DXTypes,
  DXGI,
  D3D10,
  D3DX10;


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
// Structures
//--------------------------------------------------------------------------------------
type
  TSimpleVertex = record
    Pos: TD3DVector;
    Tex: TD3DXVector2;
  end;

function SimpleVertex(aPos: TD3DVector; aTex: TD3DXVector2): TSimpleVertex;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    Pos:= aPos;
    Tex:= aTex;
  end;
end;

//--------------------------------------------------------------------------------------
// Global Variables
//--------------------------------------------------------------------------------------
var
  g_hInst: THandle = 0;
  g_hWnd: HWND     = 0;
  g_driverType: TD3D10_DriverType = D3D10_DRIVER_TYPE_NULL;
  g_pd3dDevice: ID3D10Device;
  g_pSwapChain: IDXGISwapChain;
  g_pRenderTargetView: ID3D10RenderTargetView = nil;
  g_pEffect: ID3D10Effect = nil;
  g_pTechnique: ID3D10EffectTechnique = nil;
  g_pVertexLayout: ID3D10InputLayout = nil;
  g_pVertexBuffer: ID3D10Buffer = nil;
  g_pIndexBuffer: ID3D10Buffer = nil;
  g_pTextureRV: ID3D10ShaderResourceView = nil;
  g_pWorldVariable: ID3D10EffectMatrixVariable = nil;
  g_pViewVariable: ID3D10EffectMatrixVariable = nil;
  g_pProjectionVariable: ID3D10EffectMatrixVariable = nil;
  g_pMeshColorVariable: ID3D10EffectVectorVariable = nil;
  g_pDiffuseVariable: ID3D10EffectShaderResourceVariable = nil;
  g_World: TD3DXMatrix;
  g_View: TD3DXMatrix;
  g_Projection: TD3DXMatrix;
  g_vMeshColor: TD3DXVector4 = (x: 0.7; y: 0.7; z: 0.7; w: 1.0);


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
  g_hWnd := CreateWindow('TutorialWindowClass', 'Direct3D 10 Tutorial 7', WS_OVERLAPPEDWINDOW,
                         Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT), rc.right - rc.left, rc.bottom - rc.top, 0, 0, hInstance, nil);
  if (g_hWnd = 0) then Exit;

  ShowWindow(g_hWnd, nCmdShow);

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Create Direct3D device and swap chain
//--------------------------------------------------------------------------------------
var
  // Define the input layout
  layout: array [0..1] of TD3D10_InputElementDesc =
  (
    (
      SemanticName: 'POSITION'; SemanticIndex: 0; Format: DXGI_FORMAT_R32G32B32_FLOAT;
      InputSlot: 0; AlignedByteOffset: 0; InputSlotClass: D3D10_INPUT_PER_VERTEX_DATA;
      InstanceDataStepRate: 0
    ),
    (
      SemanticName: 'TEXCOORD'; SemanticIndex: 0; Format: DXGI_FORMAT_R32G32_FLOAT;
      InputSlot: 0; AlignedByteOffset: 12; InputSlotClass: D3D10_INPUT_PER_VERTEX_DATA;
      InstanceDataStepRate: 0
    )
  );

  indices: array[0..35] of DWORD =
  (
      3,1,0,
      2,1,3,

      6,4,5,
      7,4,6,

      11,9,8,
      10,9,11,

      14,12,13,
      15,12,14,

      19,17,16,
      18,17,19,

      22,20,21,
      23,20,22
  );

function InitDevice: HRESULT;
var
  rc: TRect;
  width: LongWord;
  height: LongWord;
  createDeviceFlags: LongWord;
  driverTypes: array [0..1] of TD3D10_DriverType;
  sd: TDXGI_SwapChainDesc;
  driverTypeIndex: LongWord;
  pBuffer: ID3D10Texture2D;
  vp: TD3D10_Viewport;
  dwShaderFlags: DWORD;
  PassDesc: TD3D10_PassDesc;
  vertices: array[0..23] of TSimpleVertex;
  bd: TD3D10_BufferDesc;
  InitData: TD3D10_SubresourceData;
  stride, offset: LongWord;
  Eye: TD3DXVector3;
  At: TD3DXVector3;
  Up: TD3DXVector3;
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
                                        D3D10_SDK_VERSION, @sd, g_pSwapChain, g_pd3dDevice);
    if SUCCEEDED(Result) then Break;
  end;
  if FAILED(Result) then Exit;

  // Create a render target view
  Result := g_pSwapChain.GetBuffer(0, ID3D10Texture2D, pBuffer);
  if FAILED(Result) then Exit;

  Result := g_pd3dDevice.CreateRenderTargetView(pBuffer, nil, @g_pRenderTargetView);
  pBuffer := nil;
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

  // Create the effect
  dwShaderFlags := D3D10_SHADER_ENABLE_STRICTNESS;
  {$IFDEF DEBUG}
  // Set the D3D10_SHADER_DEBUG flag to embed debug information in the shaders.
  // Setting this flag improves the shader debugging experience, but still allows
  // the shaders to be optimized and to run exactly the way they will run in
  // the release configuration of this program.
  dwShaderFlags := dwShaderFlags or D3D10_SHADER_DEBUG;
  {$ENDIF}
  Result := D3DX10CreateEffectFromFileA('Tutorial07.fx', nil, nil, 'fx_4_0', dwShaderFlags, 0, g_pd3dDevice, nil, nil, g_pEffect, nil, nil);
  if FAILED(Result) then
  begin
    MessageBox(0, 'The FX file cannot be located.  Please run this executable from the directory that contains the FX file.', 'Error', MB_OK );
    Exit;
  end;

  // Obtain the technique
  g_pTechnique := g_pEffect.GetTechniqueByName('Render');

  // Obtain the variables
  g_pWorldVariable := g_pEffect.GetVariableByName('World').AsMatrix;
  g_pViewVariable := g_pEffect.GetVariableByName('View').AsMatrix;
  g_pProjectionVariable := g_pEffect.GetVariableByName('Projection').AsMatrix;
  g_pMeshColorVariable := g_pEffect.GetVariableByName('vMeshColor').AsVector;
  g_pDiffuseVariable := g_pEffect.GetVariableByName('txDiffuse').AsShaderResource;

  // Create the input layout
  g_pTechnique.GetPassByIndex(0).GetDesc(PassDesc);
  Result := g_pd3dDevice.CreateInputLayout(@layout, 2, PassDesc.pIAInputSignature, PassDesc.IAInputSignatureSize, @g_pVertexLayout);
  if FAILED(Result) then Exit;

  // Set the input layout
  g_pd3dDevice.IASetInputLayout(g_pVertexLayout);

  // Create vertex buffer
  vertices[ 0] := SimpleVertex(D3DXVector3(-1.0,  1.0, -1.0), D3DXVector2(0.0, 0.0));
  vertices[ 1] := SimpleVertex(D3DXVector3( 1.0,  1.0, -1.0), D3DXVector2(1.0, 0.0));
  vertices[ 2] := SimpleVertex(D3DXVector3( 1.0,  1.0,  1.0), D3DXVector2(1.0, 1.0));
  vertices[ 3] := SimpleVertex(D3DXVector3(-1.0,  1.0,  1.0), D3DXVector2(0.0, 1.0));

  vertices[ 4] := SimpleVertex(D3DXVector3(-1.0, -1.0, -1.0), D3DXVector2(0.0, 0.0));
  vertices[ 5] := SimpleVertex(D3DXVector3( 1.0, -1.0, -1.0), D3DXVector2(1.0, 0.0));
  vertices[ 6] := SimpleVertex(D3DXVector3( 1.0, -1.0,  1.0), D3DXVector2(1.0, 1.0));
  vertices[ 7] := SimpleVertex(D3DXVector3(-1.0, -1.0,  1.0), D3DXVector2(0.0, 1.0));

  vertices[ 8] := SimpleVertex(D3DXVector3(-1.0, -1.0,  1.0), D3DXVector2(0.0, 0.0));
  vertices[ 9] := SimpleVertex(D3DXVector3(-1.0, -1.0, -1.0), D3DXVector2(1.0, 0.0));
  vertices[10] := SimpleVertex(D3DXVector3(-1.0,  1.0, -1.0), D3DXVector2(1.0, 1.0));
  vertices[11] := SimpleVertex(D3DXVector3(-1.0,  1.0,  1.0), D3DXVector2(0.0, 1.0));

  vertices[12] := SimpleVertex(D3DXVector3( 1.0, -1.0,  1.0), D3DXVector2(0.0, 0.0));
  vertices[13] := SimpleVertex(D3DXVector3( 1.0, -1.0, -1.0), D3DXVector2(1.0, 0.0));
  vertices[14] := SimpleVertex(D3DXVector3( 1.0,  1.0, -1.0), D3DXVector2(1.0, 1.0));
  vertices[15] := SimpleVertex(D3DXVector3( 1.0,  1.0,  1.0), D3DXVector2(0.0, 1.0));

  vertices[16] := SimpleVertex(D3DXVector3(-1.0, -1.0, -1.0), D3DXVector2(0.0, 0.0));
  vertices[17] := SimpleVertex(D3DXVector3( 1.0, -1.0, -1.0), D3DXVector2(1.0, 0.0));
  vertices[18] := SimpleVertex(D3DXVector3( 1.0,  1.0, -1.0), D3DXVector2(1.0, 1.0));
  vertices[19] := SimpleVertex(D3DXVector3(-1.0,  1.0, -1.0), D3DXVector2(0.0, 1.0));

  vertices[20] := SimpleVertex(D3DXVector3(-1.0, -1.0, 1.0), D3DXVector2(0.0, 0.0));
  vertices[21] := SimpleVertex(D3DXVector3( 1.0, -1.0, 1.0), D3DXVector2(1.0, 0.0));
  vertices[22] := SimpleVertex(D3DXVector3( 1.0,  1.0, 1.0), D3DXVector2(1.0, 1.0));
  vertices[23] := SimpleVertex(D3DXVector3(-1.0,  1.0, 1.0), D3DXVector2(0.0, 1.0));

  bd.Usage := D3D10_USAGE_DEFAULT;
  bd.ByteWidth := SizeOf(TSimpleVertex) * 24;
  bd.BindFlags := D3D10_BIND_VERTEX_BUFFER;
  bd.CPUAccessFlags := 0;
  bd.MiscFlags := 0;
  InitData.pSysMem := @vertices;
  Result := g_pd3dDevice.CreateBuffer(bd, @InitData, @g_pVertexBuffer);
  if FAILED(Result) then Exit;

  // Set vertex buffer
  stride := SizeOf(TSimpleVertex);
  offset := 0;
  g_pd3dDevice.IASetVertexBuffers(0, 1, @g_pVertexBuffer, @stride, @offset);

  // Create index buffer
  // Create vertex buffer
  bd.Usage := D3D10_USAGE_DEFAULT;
  bd.ByteWidth := SizeOf(DWORD) * 36;        
  bd.BindFlags := D3D10_BIND_INDEX_BUFFER;
  bd.CPUAccessFlags := 0;
  bd.MiscFlags := 0;
  InitData.pSysMem := @indices;
  Result := g_pd3dDevice.CreateBuffer(bd, @InitData, @g_pIndexBuffer);
  if FAILED(Result) then Exit;

  // Set index buffer
  g_pd3dDevice.IASetIndexBuffer(g_pIndexBuffer, DXGI_FORMAT_R32_UINT, 0);

  // Set primitive topology
  g_pd3dDevice.IASetPrimitiveTopology(D3D10_PRIMITIVE_TOPOLOGY_TRIANGLELIST);

  // Load the Texture
  Result := D3DX10CreateShaderResourceViewFromFileA(g_pd3dDevice, 'seafloor.dds', nil, nil, g_pTextureRV, nil);
  if FAILED(Result) then Exit;

  // Initialize the world matrices
  D3DXMatrixIdentity(g_World);

  // Initialize the view matrix
  Eye := D3DXVector3(0.0, 3.0, -6.0);
  At := D3DXVector3(0.0, 1.0, 0.0);
  Up := D3DXVector3(0.0, 1.0, 0.0);
  D3DXMatrixLookAtLH(g_View, Eye, At, Up);

  // Initialize the projection matrix
  D3DXMatrixPerspectiveFovLH(g_Projection, D3DX_PI * 0.25, width/height, 0.1, 100.0);

  // Update Variables that never change
  g_pViewVariable.SetMatrix(@g_View);
  g_pProjectionVariable.SetMatrix(@g_Projection);
  g_pDiffuseVariable.SetResource(g_pTextureRV);

  Result:= S_OK;
end;


//--------------------------------------------------------------------------------------
// Clean up the objects we've created
//--------------------------------------------------------------------------------------
procedure CleanupDevice;
begin
  if Assigned(g_pd3dDevice) then g_pd3dDevice.ClearState;

  g_pVertexBuffer := nil;
  g_pIndexBuffer := nil;
  g_pVertexLayout := nil;
//todo: What is this!!!??  
{  if (g_pTextureRV )
  begin
      ID3D10Resource* pRes;
      g_pTextureRV.GetResource( @pRes);
      pRes.Release;
      pRes.Release;
  end; }
  g_pTextureRV := nil;
  g_pEffect := nil;
  g_pRenderTargetView := nil;
  g_pSwapChain := nil;
  g_pd3dDevice := nil;
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
// Render the frame
//--------------------------------------------------------------------------------------
var
  t: Single = 0.0;
  dwTimeStart: DWORD = 0;

procedure Render;
var
  ClearColor: TColorArray;
  techDesc: TD3D10_TechniqueDesc;
  dwTimeCur: DWORD;
  p: LongWord;
begin
  // Update our time
  if (g_driverType = D3D10_DRIVER_TYPE_REFERENCE) then
  begin
    t := t + D3DX_PI * 0.0125;
  end else
  begin
    dwTimeCur := GetTickCount;
    if (dwTimeStart = 0) then dwTimeStart := dwTimeCur;
    t := (dwTimeCur - dwTimeStart) / 1000.0;
  end;

  // Rotate cube around the origin
  D3DXMatrixRotationY(g_World, t);

  // Modify the color
  g_vMeshColor.x := ( sin( t * 1.0 ) + 1.0 ) * 0.5;
  g_vMeshColor.y := ( cos( t * 3.0 ) + 1.0 ) * 0.5;
  g_vMeshColor.z := ( sin( t * 5.0 ) + 1.0 ) * 0.5;

  //
  // Clear the back buffer
  //
  ClearColor := ColorArray(0.0, 0.125, 0.3, 1.0); //red,green,blue,alpha
  g_pd3dDevice.ClearRenderTargetView(g_pRenderTargetView, ClearColor);

  //
  // Update variables that change once per frame
  //
  g_pWorldVariable.SetMatrix(@g_World);
  g_pMeshColorVariable.SetFloatVector(@g_vMeshColor);

  //
  // Render the cube
  //
  g_pTechnique.GetDesc(techDesc);
  for p := 0 to techDesc.Passes - 1 do
  begin
    g_pTechnique.GetPassByIndex(p).Apply(0);
    g_pd3dDevice.DrawIndexed(36, 0, 0);
  end;

  //
  // Present our back buffer to our front buffer
  //
  g_pSwapChain.Present(0, 0);
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
