{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) Microsoft Corporation.  All Rights Reserved.                *}
{*                                                                            *}
{*  Files:      DXGIType.h DXGI.h                                             *}
{*  Content:    DXGI include files                                            *}
{*                                                                            *}
{*  DirectX Delphi / FreePascal adaptation by Alexey Barkovoy                 *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Latest version can be downloaded from:                                    *}
{*    http://clootie.ru                                                       *}
{*    http://sourceforge.net/projects/delphi-dx9sdk                           *}
{*                                                                            *}
{*----------------------------------------------------------------------------*}
{*  $Id: $ }
{******************************************************************************}
{                                                                              }
{ Obtained through: Joint Endeavour of Delphi Innovators (Project JEDI)        }
{                                                                              }
{ The contents of this file are used with permission, subject to the Mozilla   }
{ Public License Version 1.1 (the "License"); you may not use this file except }
{ in compliance with the License. You may obtain a copy of the License at      }
{ http://www.mozilla.org/MPL/MPL-1.1.html                                      }
{                                                                              }
{ Software distributed under the License is distributed on an "AS IS" basis,   }
{ WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for }
{ the specific language governing rights and limitations under the License.    }
{                                                                              }
{ Alternatively, the contents of this file may be used under the terms of the  }
{ GNU Lesser General Public License (the  "LGPL License"), in which case the   }
{ provisions of the LGPL License are applicable instead of those above.        }
{ If you wish to allow use of your version of this file only under the terms   }
{ of the LGPL License and not to allow others to use your version of this file }
{ under the MPL, indicate your decision by deleting  the provisions above and  }
{ replace  them with the notice and other provisions required by the LGPL      }
{ License.  If you do not delete the provisions above, a recipient may use     }
{ your version of this file under either the MPL or the LGPL License.          }
{                                                                              }
{ For more information about the LGPL: http://www.gnu.org/copyleft/lesser.html }
{                                                                              }
{******************************************************************************}

{$I DirectX.inc}

unit DXGI;

interface

{$HPPEMIT '#include "DXGIType.h"'}
{$HPPEMIT '#include "DXGI.h"'}


//todo: FIX ME: add pointer types (to records)...
uses
  Windows, MultiMon, ActiveX,
  DXTypes;

(*==========================================================================;
 *  File:    DXGIType.h
 *  Content: DXGI types include file
 ****************************************************************************)

const
  _FACDXGI    = $87a;

//#define MAKE_DXGI_HRESULT( code )    MAKE_HRESULT( 1, _FACDXGI, code )
function MAKE_DXGI_HRESULT(Code: LongWord): LongWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM MAKE_DXGI_HRESULT}
//#define MAKE_DXGI_STATUS( code )    MAKE_HRESULT( 0, _FACDXGI, code )
function MAKE_DXGI_STATUS(Code: LongWord): LongWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM MAKE_DXGI_STATUS}

const
  MAKE_DXGI_HRESULT_R     = (1 shl 31) or (_FACDXGI shl 16);
  MAKE_DXGI_STATUS_R      = (0 shl 31) or (_FACDXGI shl 16);

  (* DXGI Errors *)

  DXGI_STATUS_OCCLUDED                     = HResult(MAKE_DXGI_STATUS_R or 1);
  DXGI_STATUS_CLIPPED                      = HResult(MAKE_DXGI_STATUS_R or 2);
  DXGI_STATUS_NO_REDIRECTION               = HResult(MAKE_DXGI_STATUS_R or 4);
  DXGI_STATUS_NO_DESKTOP_ACCESS            = HResult(MAKE_DXGI_STATUS_R or 5);
  DXGI_STATUS_GRAPHICS_VIDPN_SOURCE_IN_USE = HResult(MAKE_DXGI_STATUS_R or 6);
  DXGI_STATUS_MODE_CHANGED                 = HResult(MAKE_DXGI_STATUS_R or 7);
  DXGI_STATUS_MODE_CHANGE_IN_PROGRESS      = HResult(MAKE_DXGI_STATUS_R or 8);


  DXGI_ERROR_INVALID_CALL                  = HResult(MAKE_DXGI_HRESULT_R or 1);
  DXGI_ERROR_NOT_FOUND                     = HResult(MAKE_DXGI_HRESULT_R or 2);
  DXGI_ERROR_MORE_DATA                     = HResult(MAKE_DXGI_HRESULT_R or 3);
  DXGI_ERROR_UNSUPPORTED                   = HResult(MAKE_DXGI_HRESULT_R or 4);
  DXGI_ERROR_DEVICE_REMOVED                = HResult(MAKE_DXGI_HRESULT_R or 5);
  DXGI_ERROR_DEVICE_HUNG                   = HResult(MAKE_DXGI_HRESULT_R or 6);
  DXGI_ERROR_DEVICE_RESET                  = HResult(MAKE_DXGI_HRESULT_R or 7);
  DXGI_ERROR_WAS_STILL_DRAWING             = HResult(MAKE_DXGI_HRESULT_R or 10);
  DXGI_ERROR_FRAME_STATISTICS_DISJOINT     = HResult(MAKE_DXGI_HRESULT_R or 11);
  DXGI_ERROR_GRAPHICS_VIDPN_SOURCE_IN_USE  = HResult(MAKE_DXGI_HRESULT_R or 12);
  DXGI_ERROR_DRIVER_INTERNAL_ERROR         = HResult(MAKE_DXGI_HRESULT_R or 32);
  DXGI_ERROR_NONEXCLUSIVE                  = HResult(MAKE_DXGI_HRESULT_R or 33);
  DXGI_ERROR_NOT_CURRENTLY_AVAILABLE       = HResult(MAKE_DXGI_HRESULT_R or 34);
  DXGI_ERROR_REMOTE_CLIENT_DISCONNECTED    = HResult(MAKE_DXGI_HRESULT_R or 35);
  DXGI_ERROR_REMOTE_OUTOFMEMORY            = HResult(MAKE_DXGI_HRESULT_R or 36);

const
  DXGI_CPU_ACCESS_NONE             = 0;
  {$EXTERNALSYM DXGI_CPU_ACCESS_NONE}
  DXGI_CPU_ACCESS_DYNAMIC          = 1;
  {$EXTERNALSYM DXGI_CPU_ACCESS_DYNAMIC}
  DXGI_CPU_ACCESS_READ_WRITE       = 2;
  {$EXTERNALSYM DXGI_CPU_ACCESS_READ_WRITE}
  DXGI_CPU_ACCESS_SCRATCH          = 3;
  {$EXTERNALSYM DXGI_CPU_ACCESS_SCRATCH}
  DXGI_CPU_ACCESS_FIELD            = 15;
  {$EXTERNALSYM DXGI_CPU_ACCESS_FIELD}

  DXGI_USAGE_SHADER_INPUT          = (1 shl (0 + 4));
  {$EXTERNALSYM DXGI_USAGE_SHADER_INPUT}
  DXGI_USAGE_RENDER_TARGET_OUTPUT  = (1 shl (1 + 4));
  {$EXTERNALSYM DXGI_USAGE_RENDER_TARGET_OUTPUT}
  DXGI_USAGE_BACK_BUFFER           = (1 shl (2 + 4));
  {$EXTERNALSYM DXGI_USAGE_BACK_BUFFER}
  DXGI_USAGE_SHARED                = (1 shl (3 + 4));
  {$EXTERNALSYM DXGI_USAGE_SHARED}
  DXGI_USAGE_READ_ONLY             = (1 shl (4 + 4));
  {$EXTERNALSYM DXGI_USAGE_READ_ONLY}
  DXGI_USAGE_DISCARD_ON_PRESENT    = (1 shl (5 + 4));
  {$EXTERNALSYM DXGI_USAGE_DISCARD_ON_PRESENT}
  DXGI_USAGE_UNORDERED_ACCESS      = (1 shl (6 + 4));
  {$EXTERNALSYM DXGI_USAGE_UNORDERED_ACCESS}


type
  DXGI_RGB = record
    Red: Single;
    Green: Single;
    Blue: Single;
  end;
  TDXGI_RGB = DXGI_RGB;

  DXGI_GAMMA_CONTROL = record
    Scale: TDXGI_RGB;
    Offset: TDXGI_RGB;
    GammaCurve: array[0..1024] of TDXGI_RGB;
  end;
  TDXGI_GammaControl = DXGI_GAMMA_CONTROL;

  DXGI_GAMMA_CONTROL_CAPABILITIES = record
    ScaleAndOffsetSupported: BOOL;
    MaxConvertedValue: Single;
    MinConvertedValue: Single;
    NumGammaControlPoints: LongWord;
    ControlPointPositions: array[0..1024] of Single;
  end;
  TDXGI_GammaControlCapabilities = DXGI_GAMMA_CONTROL_CAPABILITIES;

  DXGI_RATIONAL = record
    Numerator: LongWord;
    Denominator: LongWord;
  end;
  TDXGI_Rational = DXGI_RATIONAL;

  //Clootie: These small enums are checked to be 4 byte size.
  //todo: How to declare in Pascal: TDXGI_Mode_Xxx or TDXGI_ModeXxx ???
  DXGI_MODE_SCANLINE_ORDER = (
    DXGI_MODE_SCANLINE_ORDER_UNSPECIFIED{ = 0},
    DXGI_MODE_SCANLINE_ORDER_PROGRESSIVE{= 1},
    DXGI_MODE_SCANLINE_ORDER_UPPER_FIELD_FIRST{= 2},
    DXGI_MODE_SCANLINE_ORDER_LOWER_FIELD_FIRST{= 3}
  );
  TDXGI_Mode_ScanlineOrder = DXGI_MODE_SCANLINE_ORDER;

  DXGI_MODE_SCALING = (
    DXGI_MODE_SCALING_UNSPECIFIED{ = 0},
    DXGI_MODE_SCALING_CENTERED{ = 1},
    DXGI_MODE_SCALING_STRETCHED{ = 2}
  );
  TDXGI_Mode_Scaling = DXGI_MODE_SCALING;

  DXGI_MODE_ROTATION = (
    DXGI_MODE_ROTATION_UNSPECIFIED{ = 0},
    DXGI_MODE_ROTATION_IDENTITY{ = 1},
    DXGI_MODE_ROTATION_ROTATE90{ = 2},
    DXGI_MODE_ROTATION_ROTATE180{ = 3},
    DXGI_MODE_ROTATION_ROTATE270{= 4}
  );
  TDXGI_Mode_Rotation = DXGI_MODE_ROTATION;

  DXGI_SAMPLE_DESC = record
    Count: LongWord;
    Quality: LongWord;
  end;
  TDXGI_SampleDesc = DXGI_SAMPLE_DESC;



(*==========================================================================;
 *  File:    DXGIFormat.h
 *  Content: DXGI formats include file
 ****************************************************************************)

const
  DXGI_FORMAT_DEFINED = 1;

//todo: FIX Delphi5 & BCB compilers here...
//{$ELSE}
type
  PDXGI_Format = ^TDXGI_Format;
  DXGI_FORMAT = (
    DXGI_FORMAT_UNKNOWN                  = 0,
    DXGI_FORMAT_R32G32B32A32_TYPELESS    = 1,
    DXGI_FORMAT_R32G32B32A32_FLOAT       = 2,
    DXGI_FORMAT_R32G32B32A32_UINT        = 3,
    DXGI_FORMAT_R32G32B32A32_SINT        = 4,
    DXGI_FORMAT_R32G32B32_TYPELESS       = 5,
    DXGI_FORMAT_R32G32B32_FLOAT          = 6,
    DXGI_FORMAT_R32G32B32_UINT           = 7,
    DXGI_FORMAT_R32G32B32_SINT           = 8,
    DXGI_FORMAT_R16G16B16A16_TYPELESS    = 9,
    DXGI_FORMAT_R16G16B16A16_FLOAT       = 10,
    DXGI_FORMAT_R16G16B16A16_UNORM       = 11,
    DXGI_FORMAT_R16G16B16A16_UINT        = 12,
    DXGI_FORMAT_R16G16B16A16_SNORM       = 13,
    DXGI_FORMAT_R16G16B16A16_SINT        = 14,
    DXGI_FORMAT_R32G32_TYPELESS          = 15,
    DXGI_FORMAT_R32G32_FLOAT             = 16,
    DXGI_FORMAT_R32G32_UINT              = 17,
    DXGI_FORMAT_R32G32_SINT              = 18,
    DXGI_FORMAT_R32G8X24_TYPELESS        = 19,
    DXGI_FORMAT_D32_FLOAT_S8X24_UINT     = 20,
    DXGI_FORMAT_R32_FLOAT_X8X24_TYPELESS = 21,
    DXGI_FORMAT_X32_TYPELESS_G8X24_UINT  = 22,
    DXGI_FORMAT_R10G10B10A2_TYPELESS     = 23,
    DXGI_FORMAT_R10G10B10A2_UNORM        = 24,
    DXGI_FORMAT_R10G10B10A2_UINT         = 25,
    DXGI_FORMAT_R11G11B10_FLOAT          = 26,
    DXGI_FORMAT_R8G8B8A8_TYPELESS        = 27,
    DXGI_FORMAT_R8G8B8A8_UNORM           = 28,
    DXGI_FORMAT_R8G8B8A8_UNORM_SRGB      = 29,
    DXGI_FORMAT_R8G8B8A8_UINT            = 30,
    DXGI_FORMAT_R8G8B8A8_SNORM           = 31,
    DXGI_FORMAT_R8G8B8A8_SINT            = 32,
    DXGI_FORMAT_R16G16_TYPELESS          = 33,
    DXGI_FORMAT_R16G16_FLOAT             = 34,
    DXGI_FORMAT_R16G16_UNORM             = 35,
    DXGI_FORMAT_R16G16_UINT              = 36,
    DXGI_FORMAT_R16G16_SNORM             = 37,
    DXGI_FORMAT_R16G16_SINT              = 38,
    DXGI_FORMAT_R32_TYPELESS             = 39,
    DXGI_FORMAT_D32_FLOAT                = 40,
    DXGI_FORMAT_R32_FLOAT                = 41,
    DXGI_FORMAT_R32_UINT                 = 42,
    DXGI_FORMAT_R32_SINT                 = 43,
    DXGI_FORMAT_R24G8_TYPELESS           = 44,
    DXGI_FORMAT_D24_UNORM_S8_UINT        = 45,
    DXGI_FORMAT_R24_UNORM_X8_TYPELESS    = 46,
    DXGI_FORMAT_X24_TYPELESS_G8_UINT     = 47,
    DXGI_FORMAT_R8G8_TYPELESS            = 48,
    DXGI_FORMAT_R8G8_UNORM               = 49,
    DXGI_FORMAT_R8G8_UINT                = 50,
    DXGI_FORMAT_R8G8_SNORM               = 51,
    DXGI_FORMAT_R8G8_SINT                = 52,
    DXGI_FORMAT_R16_TYPELESS             = 53,
    DXGI_FORMAT_R16_FLOAT                = 54,
    DXGI_FORMAT_D16_UNORM                = 55,
    DXGI_FORMAT_R16_UNORM                = 56,
    DXGI_FORMAT_R16_UINT                 = 57,
    DXGI_FORMAT_R16_SNORM                = 58,
    DXGI_FORMAT_R16_SINT                 = 59,
    DXGI_FORMAT_R8_TYPELESS              = 60,
    DXGI_FORMAT_R8_UNORM                 = 61,
    DXGI_FORMAT_R8_UINT                  = 62,
    DXGI_FORMAT_R8_SNORM                 = 63,
    DXGI_FORMAT_R8_SINT                  = 64,
    DXGI_FORMAT_A8_UNORM                 = 65,
    DXGI_FORMAT_R1_UNORM                 = 66,
    DXGI_FORMAT_R9G9B9E5_SHAREDEXP       = 67,
    DXGI_FORMAT_R8G8_B8G8_UNORM          = 68,
    DXGI_FORMAT_G8R8_G8B8_UNORM          = 69,
    DXGI_FORMAT_BC1_TYPELESS             = 70,
    DXGI_FORMAT_BC1_UNORM                = 71,
    DXGI_FORMAT_BC1_UNORM_SRGB           = 72,
    DXGI_FORMAT_BC2_TYPELESS             = 73,
    DXGI_FORMAT_BC2_UNORM                = 74,
    DXGI_FORMAT_BC2_UNORM_SRGB           = 75,
    DXGI_FORMAT_BC3_TYPELESS             = 76,
    DXGI_FORMAT_BC3_UNORM                = 77,
    DXGI_FORMAT_BC3_UNORM_SRGB           = 78,
    DXGI_FORMAT_BC4_TYPELESS             = 79,
    DXGI_FORMAT_BC4_UNORM                = 80,
    DXGI_FORMAT_BC4_SNORM                = 81,
    DXGI_FORMAT_BC5_TYPELESS             = 82,
    DXGI_FORMAT_BC5_UNORM                = 83,
    DXGI_FORMAT_BC5_SNORM                = 84,
    DXGI_FORMAT_B5G6R5_UNORM             = 85,
    DXGI_FORMAT_B5G5R5A1_UNORM           = 86,
    DXGI_FORMAT_B8G8R8A8_UNORM           = 87,
    DXGI_FORMAT_B8G8R8X8_UNORM           = 88,
    DXGI_FORMAT_R10G10B10_XR_BIAS_A2_UNORM=89,
    DXGI_FORMAT_B8G8R8A8_TYPELESS        = 90,
    DXGI_FORMAT_B8G8R8A8_UNORM_SRGB      = 91,
    DXGI_FORMAT_B8G8R8X8_TYPELESS        = 92,
    DXGI_FORMAT_B8G8R8X8_UNORM_SRGB      = 93,
    DXGI_FORMAT_BC6H_TYPELESS            = 94,
    DXGI_FORMAT_BC6H_UF16                = 95,
    DXGI_FORMAT_BC6H_SF16                = 96,
    DXGI_FORMAT_BC7_TYPELESS             = 97,
    DXGI_FORMAT_BC7_UNORM                = 98,
    DXGI_FORMAT_BC7_UNORM_SRGB           = 99,
    DXGI_FORMAT_FORCE_UINT               = $7fffffff // $ffffffff
  );
  TDXGI_Format = DXGI_FORMAT;


  PDXGI_Mode_Desc = ^TDXGI_Mode_Desc;
  DXGI_MODE_DESC = record
    Width: LongWord;
    Height: LongWord;
    RefreshRate: TDXGI_Rational;
    Format: TDXGI_Format;
    ScanlineOrdering: TDXGI_Mode_ScanlineOrder;
    Scaling: TDXGI_Mode_Scaling;
  end;
  TDXGI_Mode_Desc = DXGI_MODE_DESC;



(*==========================================================================;
 *  File:    DXGI.h
 *  Content: DXGI include file
 ****************************************************************************)

type
  DXGI_USAGE = {$IFDEF TYPE_IDENTITY}type {$ENDIF}LongWord;
  TDXGI_Usage = DXGI_USAGE;

  DXGI_FRAME_STATISTICS = record
    PresentCount: LongWord;
    PresentRefreshCount: LongWord;
    SyncRefreshCount: LongWord;
    SyncQPCTime: LARGE_INTEGER;
    SyncGPUTime: LARGE_INTEGER;
  end;
  TDXGI_FrameStatistics = DXGI_FRAME_STATISTICS;


  DXGI_MAPPED_RECT = record
    Pitch: Integer;
    pBits: PByte;
  end;
  TDXGI_MappedRect = DXGI_MAPPED_RECT;

  DXGI_ADAPTER_DESC = record
    Description: array[0..127] of WideChar;
    VendorId: LongWord;
    DeviceId: LongWord;
    SubSysId: LongWord;
    Revision: LongWord;
    DedicatedVideoMemory: SIZE_T;
    SharedVideoMemory: SIZE_T;
  end;
  TDXGI_AdapterDesc = DXGI_ADAPTER_DESC;

  DXGI_OUTPUT_DESC = record
    DeviceName: array[0..31] of WideChar;
    DesktopCoordinates: TRect;
    AttachedToDesktop: BOOL;
    Rotation: TDXGI_Mode_Rotation;
    Monitor: HMONITOR;
  end;
  TDXGI_OutputDesc = DXGI_OUTPUT_DESC;

  PDXGI_SharedResource = ^TDXGI_SharedResource;
  DXGI_SHARED_RESOURCE = record
    Handle: THandle;
    OpenUsage: TDXGI_Usage;
  end;
  TDXGI_SharedResource = DXGI_SHARED_RESOURCE;

const
  DXGI_RESOURCE_PRIORITY_MINIMUM   = $28000000;
  DXGI_RESOURCE_PRIORITY_LOW       = $50000000;
  DXGI_RESOURCE_PRIORITY_NORMAL    = $78000000;
  DXGI_RESOURCE_PRIORITY_HIGH      = $a0000000;
  DXGI_RESOURCE_PRIORITY_MAXIMUM   = $c8000000;

type
  PDXGI_Residency = ^TDXGI_Residency;
  DXGI_RESIDENCY = (
    DXGI_RESIDENCY_FULLY_RESIDENT = 1,
    DXGI_RESIDENCY_RESIDENT_IN_SHARED_MEMORY = 2,
    DXGI_RESIDENCY_EVICTED_TO_DISK = 3
  );
  TDXGI_Residency = DXGI_RESIDENCY;

  PDXGI_SurfaceDesc = ^TDXGI_SurfaceDesc;
  DXGI_SURFACE_DESC = record
    Width: LongWord;
    Height: LongWord;
    Format: TDXGI_Format;
    SampleDesc: TDXGI_SampleDesc;
  end;
  TDXGI_SurfaceDesc = DXGI_SURFACE_DESC;

  PDXGI_SwapEffect = ^TDXGI_SwapEffect;
  DXGI_SWAP_EFFECT = (
    DXGI_SWAP_EFFECT_DISCARD{ = 0},
    DXGI_SWAP_EFFECT_SEQUENTIAL{ = 1}
  );
  TDXGI_SwapEffect = DXGI_SWAP_EFFECT;

const
  DXGI_SWAP_CHAIN_FLAG_NONPREROTATED     = 1;
  DXGI_SWAP_CHAIN_FLAG_ALLOW_MODE_SWITCH = 2;
	DXGI_SWAP_CHAIN_FLAG_GDI_COMPATIBLE	   = 4;

type
  PDXGI_SwapChainFlag = ^TDXGI_SwapChainFlag;
  DXGI_SWAP_CHAIN_FLAG = {$IFDEF TYPE_IDENTITY}type {$ENDIF}LongWord;
  TDXGI_SwapChainFlag = DXGI_SWAP_CHAIN_FLAG;

  PDXGI_SwapChainDesc = ^TDXGI_SwapChainDesc;
  DXGI_SWAP_CHAIN_DESC = record
    BufferDesc: TDXGI_Mode_Desc;
    SampleDesc: TDXGI_SampleDesc;
    BufferUsage: TDXGI_Usage;
    BufferCount: LongWord;
    OutputWindow: HWND;
    Windowed: BOOL;
    SwapEffect: TDXGI_SwapEffect;
    Flags: LongWord;
  end;
  TDXGI_SwapChainDesc = DXGI_SWAP_CHAIN_DESC;


const
  DXGI_ENUM_MODES_INTERLACED    = LongWord(1);
  DXGI_ENUM_MODES_SCALING       = LongWord(2);

  DXGI_MAX_SWAP_CHAIN_BUFFERS   = 16;
  DXGI_PRESENT_TEST             = LongWord($00000001);
  DXGI_PRESENT_DO_NOT_SEQUENCE  = LongWord($00000002);
  DXGI_PRESENT_RESTART          = LongWord($00000004);

  DXGI_MWA_NO_WINDOW_CHANGES = 1 shl 0;
  DXGI_MWA_NO_ALT_ENTER      = 1 shl 1;
  DXGI_MWA_NO_PRINT_SCREEN   = 1 shl 2;
  DXGI_MWA_VALID             = $7;

  
type
  IDXGIObject = interface;
  IDXGIDeviceSubObject = interface;
  IDXGIResource = interface;
  IDXGIKeyedMutex = interface;
  IDXGISurface = interface;
  IDXGISurface1 = interface;
  IDXGIAdapter = interface;
  IDXGIOutput = interface;
  IDXGISwapChain = interface;
  IDXGIFactory = interface;
  IDXGIDevice = interface;
  IDXGIFactory1 = interface;
  IDXGIAdapter1 = interface;
  IDXGIDevice1 = interface;



  IID_IDXGIObject              = IDXGIObject;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIObject);'}
  {$EXTERNALSYM IDXGIObject}
  IDXGIObject = interface(IUnknown)
    ['{aec22fb8-76f3-4639-9be0-28eb43a67a2e}']
    function SetPrivateData(
            (* [in] *) const Name: TGUID;
            (* [in] *) DataSize: LongWord;
            (* [in] *) pData: Pointer): HResult; stdcall;

    function SetPrivateDataInterface(
            (* [in] *) const Name: TGUID;
            (* [in] *) const pUnknown: IUnknown): HResult; stdcall;

    function GetPrivateData(
            (* [in] *) const Name: TGUID;
            (* [out][in] *) var pDataSize: LongWord;
            (* [out] *) pData: Pointer): HResult; stdcall;

    function GetParent(
            (* [in] *) const riid: TIID;
            (* [retval][out] *) out ppParent{IUnknown}): HResult; stdcall;
  end;


  IID_IDXGIDeviceSubObject = IDXGIDeviceSubObject;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIDeviceSubObject);'}
  {$EXTERNALSYM IDXGIDeviceSubObject}
  IDXGIDeviceSubObject = interface(IDXGIObject)
    ['{3d3e0379-f9de-4d58-bb6c-18d62992f1a6}']
    function GetDevice(
            (* [in] *) const riid: TIID;
            (* [retval][out] *) out ppDevice{IUnknown}): HResult; stdcall;
  end;


  IID_IDXGIResource = IDXGIResource;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIResource);'}
  {$EXTERNALSYM IDXGIResource}
  IDXGIResource = interface(IDXGIDeviceSubObject)
    ['{035f3ab4-482e-4e50-b41f-8a7f8bd8960b}']
    function GetSharedHandle(
            (* [out] *) out pSharedHandle: THandle): HResult; stdcall;

    function GetUsage(
            (* [out] *) out pUsage: TDXGI_Usage): HResult; stdcall;

    function SetEvictionPriority(
            (* [in] *) EvictionPriority: LongWord): HResult; stdcall;

    function GetEvictionPriority(
            (* [retval][out] *) out pEvictionPriority: LongWord): HResult; stdcall;
  end;


  IID_IDXGIKeyedMutex = IDXGIKeyedMutex;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIKeyedMutex);'}
  {$EXTERNALSYM IDXGIKeyedMutex}
  IDXGIKeyedMutex = interface(IDXGIDeviceSubObject)
    ['{9d8e1289-d7b3-465f-8126-250e349af85d}']
    function AcquireSync(
            (* [in] *) Key: UINT64;
            (* [in] *) dwMilliseconds: DWORD): HResult; stdcall;

    function ReleaseSync(
            (* [in] *) Key: UINT64): HResult; stdcall;

  end;


  IID_IDXGISurface = IDXGISurface;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGISurface);'}
  {$EXTERNALSYM IDXGISurface}
  IDXGISurface = interface(IDXGIDeviceSubObject)
    ['{cafcb56c-6ac3-4889-bf47-9e23bbd260ec}']
    function GetDesc(
            (* [out] *) out pDesc: TDXGI_SurfaceDesc): HResult; stdcall;

    function Map(
            (* [out] *) out pLockedRect: TDXGI_MappedRect;
            (* [in] *) MapFlags: LongWord): HResult; stdcall;

    function Unmap(): HResult; stdcall;
  end;


  IID_IDXGISurface1 = IDXGISurface1;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGISurface1);'}
  {$EXTERNALSYM IDXGISurface1}
  IDXGISurface1 = interface(IDXGISurface)
    ['{4AE63092-6327-4c1b-80AE-BFE12EA32B86}']
    function GetDC(
            (* [in] *) Discard: BOOL;
            (* [out] *) out hdc: HDC): HResult; stdcall;

    function ReleaseDC(
            (* [in] *) pDirtyRect: PRect): HResult; stdcall;
  end;


  IID_IDXGIAdapter = IDXGIAdapter;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIAdapter);'}
  {$EXTERNALSYM IDXGIAdapter}
  IDXGIAdapter = interface(IDXGIObject)
    ['{2411e7e1-12ac-4ccf-bd14-9798e8534dc0}']
    function EnumOutputs(
            (* [in] *) Output: LongWord;
            (* [out][in] *) out ppOutput: IDXGIOutput): HResult; stdcall;

    function GetDesc(
            (* [out] *) out pDesc: TDXGI_AdapterDesc): HResult; stdcall;

    function CheckInterfaceSupport(
            (* [in] *) InterfaceName: TGUID;
            (* [out] *) out pUMDVersion: LARGE_INTEGER): HResult; stdcall;
  end;


  IID_IDXGIOutput = IDXGIOutput;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIOutput);'}
  {$EXTERNALSYM IDXGIOutput}
  IDXGIOutput = interface(IDXGIObject)
    ['{ae02eedb-c735-4690-8d52-5a8dc20213aa}']
    function GetDesc(
            (* [out] *) out pDesc: TDXGI_OutputDesc): HResult; stdcall;

    function GetDisplayModeList(
            (* [in] *) EnumFormat: TDXGI_Format;
            (* [in] *) Flags: LongWord;
            (* [out][in] *) var pNumModes: LongWord;
            (* [out] *) pDesc: PDXGI_Mode_Desc): HResult; stdcall;

    function FindClosestMatchingMode(
            (* [in] *) const pModeToMatch: TDXGI_Mode_Desc;
            (* [out] *) out pClosestMatch: TDXGI_Mode_Desc;
            (* [in] *) const pConcernedDevice: IUnknown): HResult; stdcall;

    function WaitForVBlank(): HResult; stdcall;

    function TakeOwnership(
            (* [in] *) const pDevice: IUnknown;
            Exclusive: BOOL): HResult; stdcall;

    function ReleaseOwnership(): HResult; stdcall;

    function GetGammaControlCapabilities(
           (* [out] *) out pGammaCaps: TDXGI_GammaControlCapabilities): HResult; stdcall;

    function SetGammaControl(
           (* [in] *) const pArray: TDXGI_GammaControl): HResult; stdcall;

    function GetGammaControl(
           (* [out] *) out pArray: TDXGI_GammaControl): HResult; stdcall;

    function SetDisplaySurface(
            (* [in] *) const pScanoutSurface: IDXGISurface): HResult; stdcall;

    function GetDisplaySurfaceData(
            (* [in] *) const pDestination: IDXGISurface): HResult; stdcall;

    function GetFrameStatistics(
            (* [out] *) out pStats: TDXGI_FrameStatistics): HResult; stdcall;
  end;


  IID_IDXGISwapChain = IDXGISwapChain;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGISwapChain);'}
  {$EXTERNALSYM IDXGISwapChain}
  IDXGISwapChain = interface(IDXGIDeviceSubObject)
    ['{310d36a0-d2e7-4c0a-aa04-6a9d23b8886a}']
    function Present(
            (* [in] *) SyncInterval: LongWord;
            (* [in] *) Flags: LongWord): HResult; stdcall;

    function GetBuffer(
            (* [in] *) Buffer: LongWord;
            (* [in] *) const riid: TIID;
            (* [out][in] *) out ppSurface{IUnknown}): HResult; stdcall;

    function SetFullscreenState(
            (* [in] *) Fullscreen: BOOL;
            (* [in] *) const pTarget: IDXGIOutput): HResult; stdcall;

    function GetFullscreenState(
            (* [out] *) out pFullscreen: BOOL;
            (* [out] *) out ppTarget: IDXGIOutput): HResult; stdcall;

    function GetDesc(
            (* [out] *) out pDesc: TDXGI_SwapChainDesc): HResult; stdcall;

    function ResizeBuffers(
            (* [in] *) BufferCount: LongWord;
            (* [in] *) Width: LongWord;
            (* [in] *) Height: LongWord;
            (* [in] *) NewFormat: TDXGI_Format;
            (* [in] *) SwapChainFlags: LongWord): HResult; stdcall;

    function ResizeTarget(
            (* [in] *) const pNewTargetParameters: TDXGI_Mode_Desc): HResult; stdcall;

    function GetContainingOutput(
            out ppOutput: IDXGIOutput): HResult; stdcall;

    function GetFrameStatistics(
            (* [out] *) out pStats: TDXGI_FrameStatistics): HResult; stdcall;

    function GetLastPresentCount(
            (* [out] *) out pLastPresentCount: LongWord): HResult; stdcall;

  end;


  IID_IDXGIFactory = IDXGIFactory;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIFactory);'}
  {$EXTERNALSYM IDXGIFactory}
  IDXGIFactory = interface(IDXGIObject)
    ['{7b7166ec-21c7-44ae-b21a-c9ae321ae369}']
    function EnumAdapters(
            (* [in] *) Adapter: LongWord;
            (* [out] *) out ppAdapter: IDXGIAdapter): HResult; stdcall;

    function MakeWindowAssociation(
            WindowHandle: HWND;
            Flags: LongWord): HResult; stdcall;

    function GetWindowAssociation(
            out pWindowHandle: HWND): HResult; stdcall;

    function CreateSwapChain(
            const pDevice: IUnknown;
            const pDesc: TDXGI_SwapChainDesc;
            out ppSwapChain: IDXGISwapChain): HResult; stdcall;

    function CreateSoftwareAdapter(
            (* [in] *) Module: HMODULE;
            (* [out] *) out ppAdapter: IDXGIAdapter): HResult; stdcall;
  end;



  PIUnknown = ^IUnknown;

  IID_IDXGIDevice = IDXGIDevice;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIDevice);'}
  {$EXTERNALSYM IDXGIDevice}
  IDXGIDevice = interface(IDXGIObject)
    ['{54ec77fa-1377-44e6-8c32-88fd5f44c84c}']
    function GetAdapter(
            (* [out] *) out pAdapter: IDXGIAdapter): HResult; stdcall;

    function CreateSurface(
            (* [in] *) const pDesc: TDXGI_SurfaceDesc;
            (* [in] *) NumSurfaces: LongWord;
            (* [in] *) Usage: TDXGI_Usage;
            (* [in] *) const pSharedResource: TDXGI_SharedResource;
            (* [out] *) out ppSurface: IDXGISurface): HResult; stdcall;

    function QueryResourceResidency(
    //todo: FIX ME: arrays of IUnknown and Residency
            (* [size_is][in] *) const ppResources: PIUnknown;
            (* [size_is][out] *) out pResidencyStatus: PDXGI_Residency;
            (* [in] *) NumResources: LongWord): HResult; stdcall;

    function SetGPUThreadPriority(
            (* [in] *) Priority: Integer): HResult; stdcall;

    function GetGPUThreadPriority(
            (* [retval][out] *) out pPriority: Integer): HResult; stdcall;
  end;


  DXGI_ADAPTER_FLAG = (
    DXGI_ADAPTER_FLAG_NONE	{= 0},
    DXGI_ADAPTER_FLAG_REMOTE{= 1,}
    //DXGI_ADAPTER_FLAG_FORCE_DWORD	= 0xffffffff
  );
  {$EXTERNALSYM DXGI_ADAPTER_FLAG}
  TDXGI_AdapterFlag = DXGI_ADAPTER_FLAG;
  PDXGI_AdapterFlag = ^TDXGI_AdapterFlag;

  DXGI_ADAPTER_DESC1 = record
    Description: array [0..127] of WideChar;
    VendorId: LongWord;
    DeviceId: LongWord;
    SubSysId: LongWord;
    Revision: LongWord;
    DedicatedVideoMemory: SIZE_T;
    DedicatedSystemMemory: SIZE_T;
    SharedSystemMemory: SIZE_T;
    AdapterLuid: TGUID;
    Flags: LongWord;
  end;
  {$EXTERNALSYM DXGI_ADAPTER_DESC1}
  TDXGI_AdapterDesc1 = DXGI_ADAPTER_DESC1;
  PDXGI_AdapterDesc1 = ^TDXGI_AdapterDesc1;

  DXGI_DISPLAY_COLOR_SPACE = record
    PrimaryCoordinates: array [0..7, 0..1] of Single;
    WhitePoints: array [0..15, 0..1] of Single;
  end;


  IID_IDXGIFactory1 = IDXGIFactory1;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIFactory1);'}
  {$EXTERNALSYM IDXGIFactory1}
  IDXGIFactory1 = interface(IDXGIFactory)
    ['{770aae78-f26f-4dba-a829-253c83d1b387}']
    function EnumAdapters1(
            (* [in] *) Adapter: LongWord;
            (* [out] *) out ppAdapter: IDXGIAdapter1): HResult; stdcall;

    function IsCurrent(): BOOL; stdcall;
  end;


  IID_IDXGIAdapter1 = IDXGIAdapter1;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIAdapter1);'}
  {$EXTERNALSYM IDXGIAdapter1}
  IDXGIAdapter1 = interface(IDXGIAdapter)
    ['{29038f61-3839-4626-91fd-086879011a05}']
    function GetDesc1(
            (* [out] *) out pDesc: TDXGI_AdapterDesc1): HResult; stdcall;
  end;


  IID_IDXGIDevice1 = IDXGIDevice1;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IDXGIDevice1);'}
  {$EXTERNALSYM IDXGIDevice1}
  IDXGIDevice1 = interface(IDXGIDevice)
    ['{77db970f-6276-48ba-ba28-070143b4392c}']
    function SetMaximumFrameLatency(
            (* [in] *) MaxLatency: LongWord): HResult; stdcall;

    function GetMaximumFrameLatency(
            (* [out] *) out MaxLatency: LongWord): HResult; stdcall;
  end;

  
const
  DXGI_MAP_READ	= 1;
  {$EXTERNALSYM DXGI_MAP_READ}
  DXGI_MAP_WRITE = 2;
  {$EXTERNALSYM DXGI_MAP_WRITE}
  DXGI_MAP_DISCARD = 4;
  {$EXTERNALSYM DXGI_MAP_DISCARD}


const
  DXGI_dll = 'dxgi.dll';

//todo: Create DYNAMIC loading for DXGI
function CreateDXGIFactory(const riid: TIID; out ppFactory: IDXGIFactory): HResult; stdcall; external DXGI_dll;
function CreateDXGIFactory1(const riid: TIID; out ppFactory: IDXGIFactory): HResult; stdcall; external DXGI_dll;


implementation


//todo: FIX header below (decode DXGI, etc.)...
(*==========================================================================;
 *  File:    DXGIType.h
 *  Content: DXGI types include file
 ****************************************************************************)

//#define MAKE_DXGI_HRESULT( code )    MAKE_HRESULT( 1, _FACDXGI, code )
function MAKE_DXGI_HRESULT(Code: LongWord): LongWord;
begin
  Result:= DWord((1 shl 31) or (_FACDXGI shl 16)) or Code;
end;

//#define MAKE_DXGI_STATUS( code )    MAKE_HRESULT( 0, _FACDXGI, code )
function MAKE_DXGI_STATUS(Code: LongWord): LongWord;
begin
  Result:= DWord((0 shl 31) or (_FACDXGI shl 16)) or Code;
end;

end.

