(*==========================================================================;
 *
 *  One of the simplest Direct3D8 programs
 *  Original C++ source for that program was published by Sameer Nene (Microsoft)
 *    E-Mail: snene@MICROSOFT.COM)
 *  Delphi adaptation:
 *    E-Mail: clootie@reactor.ru
 *
 *  Modified: 14-Sep-2001
 *
 *  Lastest version can be downloaded from:
 *     http://www.delphi-jedi.org/DelphiGraphics/
 *     http://clootie.narod.ru/delphi/
 *
 *  This program included in Delphi adaptation package of Direct3D8   
 *
 ***************************************************************************)

program Simplest;

// People who find the SDK sample framework too huge may find this useful:
//      - Sameer Nene

uses Windows, Messages, Direct3D8;

var
  g_hwnd: HWND = 0;
  g_d3ddev: IDirect3DDevice8 = nil;
  ////////////////////////////////////
  hr: HResult;
  hdc: THandle;
  d3dpp: TD3DPresentParameters;

function GetPresentParameters(hdc: THandle): TD3DPresentParameters;
begin
  FillChar(Result, SizeOf(Result), 0);
  Result.Windowed:= True;
  Result.hDeviceWindow:= g_hwnd;
  Result.BackBufferWidth:= 320;
  Result.BackBufferHeight:= 240;
  if Windows.GetDeviceCaps(hdc, BITSPIXEL) = 16
    then Result.BackBufferFormat:= D3DFMT_R5G6B5
    else Result.BackBufferFormat:= D3DFMT_X8R8G8B8;
  Result.BackBufferCount:= 1;
  Result.EnableAutoDepthStencil:= True;
  Result.AutoDepthStencilFormat:= D3DFMT_D16;
  Result.SwapEffect:= D3DSWAPEFFECT_FLIP;
end;

function WndProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
type
  TMyVertex = packed record
    x, y, z, rhw: Single;
    Color: TD3DColor;
  end;
 procedure AssignMyVertex(var Vertex: TMyVertex; x, y, z, rhw: Single; Color: TD3DColor);
 begin
   Vertex.x:= x; Vertex.y:= y; Vertex.z:= z; Vertex.rhw:= rhw;
   Vertex.Color:= Color;
 end;
var
  vTriangle: array [0..2] of TMyVertex;
begin
  case uMsg of
    WM_PAINT:
    if (g_d3ddev <> nil) then
    begin
      AssignMyVertex(vTriangle[0], 160, 060, 0.5, 2, D3DCOLOR_XRGB($ff, $00, $00));
      AssignMyVertex(vTriangle[1], 240, 180, 0.5, 2, D3DCOLOR_XRGB($00, $ff, $00));
      AssignMyVertex(vTriangle[2], 080, 180, 0.5, 2, D3DCOLOR_XRGB($00, $00, $ff));

      g_d3ddev.BeginScene;
      g_d3ddev.Clear(0, nil, D3DCLEAR_TARGET or D3DCLEAR_ZBUFFER,
        D3DCOLOR_XRGB(0, 0, 0), 1, 0);
      g_d3ddev.SetRenderState(D3DRS_CLIPPING, Integer(FALSE));
      g_d3ddev.SetVertexShader(D3DFVF_XYZRHW or D3DFVF_DIFFUSE);
      g_d3ddev.DrawPrimitiveUP(D3DPT_TRIANGLELIST, 1, vTriangle, 20);
      g_d3ddev.EndScene;

      hr:= g_d3ddev.Present(nil, nil, 0, nil);
      while (hr = D3DERR_DEVICELOST) do
      begin
        repeat
          Sleep(1000);
          hr:= g_d3ddev.TestCooperativeLevel;
        until (hr = D3DERR_DEVICENOTRESET);

        hdc:= GetDC(hwnd);
        if(hdc = 0) then
        begin
          PostQuitMessage(-1);
          Result:= DefWindowProc(hwnd, uMsg, wParam, lParam);
          Exit;
        end;

        d3dpp:= GetPresentParameters(hdc);
        hr:= g_d3ddev.Reset(d3dpp);
        ReleaseDC(hwnd, hdc);

        if (FAILED(hr)) then hr:= D3DERR_DEVICELOST else Break;
      end; // while (hr = D3DERR_DEVICELOST)
      ValidateRect(g_hwnd, nil);
      Result:= 0;
      Exit;
    end;
  end;
  Result:= DefWindowProc(hwnd, uMsg, wParam, lParam);
end;

const
  APP_NAME = 'TRIANGLE';

var
  wc: TWndClass;
  pEnum: IDirect3D8 = nil;
  ret: LongBool;
  msg: TMsg;
begin
  // Register the window class for the main window.
  wc.style:= 0;
  wc.lpfnWndProc:= @WndProc;
  wc.cbClsExtra:= 0;
  wc.cbWndExtra:= 0;
  wc.hInstance:= hInstance;
  wc.hIcon:= 0;
  wc.hCursor:= 0;
  wc.hbrBackground:= GetStockObject(BLACK_BRUSH);
  wc.lpszMenuName:= nil;
  wc.lpszClassName:= APP_NAME;

  if RegisterClass(wc) = 0 then Halt(1);

  // Create the main window.
  g_hwnd:= CreateWindow(APP_NAME, APP_NAME, WS_OVERLAPPEDWINDOW,
    Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT), 320, 240, GetDesktopWindow,
    0, hInstance, nil);

  // If the main window cannot be created, terminate
  // the application.
  if g_hwnd = 0 then Halt(1);

  pEnum:= Direct3DCreate8(D3D_SDK_VERSION);
  if (pEnum = nil) then Halt(1);

  hdc:= GetDC(g_hwnd);
  if hdc = 0 then Halt(1);

  d3dpp:= GetPresentParameters(hdc);
  hr:= pEnum.CreateDevice(D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, g_hwnd,
    D3DCREATE_SOFTWARE_VERTEXPROCESSING, d3dpp, g_d3ddev);
  pEnum:= nil;

  ReleaseDC(g_hwnd, hdc);

  if (FAILED(hr)) then Halt(1);

  ShowWindow(g_hwnd, SW_SHOWDEFAULT);
  UpdateWindow(g_hwnd);

  // Now we're ready to recieve and process Windows messages.
  repeat
    ret:= GetMessage(msg, g_hwnd, 0, 0);
    if not ret then DispatchMessage(msg);
  until ret;

  DestroyWindow(g_hwnd);
  g_d3ddev:= nil;
end.
