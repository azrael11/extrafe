{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) Microsoft Corporation.  All Rights Reserved.                *}
{*                                                                            *}
{*  Files:      D3DX10.h                              *}
{*  Content:    D3DX10 include files                                          *}
{*                                                                            *}
{*  DirectX Delphi / FreePascal adaptation by Alexey Barkovoy                 *}
{*  E-Mail: directx@clootie.ru                                                *}
{*                                                                            *}
{*  Latest version can be downloaded from:                                    *}
{*    http://www.clootie.ru                                                   *}
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

// Original source contained in "D3DX10.par"

{$I DirectX.inc}

unit D3DX10;

interface

{$HPPEMIT '#include "D3DX10.h"'}

uses
  Windows, DXTypes, DXGI, D3D10, D3D10_1, SysUtils, ActiveX,
  Direct3D9; //todo: later remove any dependencies on d3d9

const
  //////////// DLL export definitions ///////////////////////////////////////
  d3dx10_retail_DLL = 'd3dx10_41.dll';
  d3dx10_debug_DLL = 'd3dx10d_41.dll';
  d3dx10dll = {$IFDEF DEBUG}d3dx10_retail_DLL{$ELSE}d3dx10_debug_DLL{$ENDIF};


//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx10.h
//  Content:    D3DX10 utility library
//
//////////////////////////////////////////////////////////////////////////////

// Defines

const
  D3DX10_DEFAULT            = -1;
  {$EXTERNALSYM D3DX10_DEFAULT}
  D3DX10_FROM_FILE          = -3;
  {$EXTERNALSYM D3DX10_FROM_FILE}
  DXGI_FORMAT_FROM_FILE     = TDXGI_Format(-3);
  {$EXTERNALSYM DXGI_FORMAT_FROM_FILE}

//Clootie: has to temporary disable INLINE support for FreePascal
//         due to bug in compiler
{$IFNDEF D3DX10INLINE}
  {$IFDEF SUPPORTS_INLINE}{$IFNDEF FPC}
    {$DEFINE ALLOW_INLINE}
  {$ENDIF}{$ENDIF}
{$ENDIF}



// Errors
const
  _FACDD  = $876;

// #define MAKE_DDHRESULT( code )  MAKE_HRESULT( 1, _FACDD, code )
function MAKE_DDHRESULT(Code: DWord): DWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM MAKE_DDHRESULT}


type
  _D3DX10_ERR = DWORD;
  {$EXTERNALSYM _D3DX10_ERR}

const
  MAKE_DDHRESULT_R     = (1 shl 31) or (_FACDD shl 16);

const
  D3DX10_ERR_CANNOT_MODIFY_INDEX_BUFFER       = HResult(MAKE_DDHRESULT_R or 2900);
  {$EXTERNALSYM D3DX10_ERR_CANNOT_MODIFY_INDEX_BUFFER}
  D3DX10_ERR_INVALID_MESH                     = HResult(MAKE_DDHRESULT_R or 2901);
  {$EXTERNALSYM D3DX10_ERR_INVALID_MESH}
  D3DX10_ERR_CANNOT_ATTR_SORT                 = HResult(MAKE_DDHRESULT_R or 2902);
  {$EXTERNALSYM D3DX10_ERR_CANNOT_ATTR_SORT}
  D3DX10_ERR_SKINNING_NOT_SUPPORTED           = HResult(MAKE_DDHRESULT_R or 2903);
  {$EXTERNALSYM D3DX10_ERR_SKINNING_NOT_SUPPORTED}
  D3DX10_ERR_TOO_MANY_INFLUENCES              = HResult(MAKE_DDHRESULT_R or 2904);
  {$EXTERNALSYM D3DX10_ERR_TOO_MANY_INFLUENCES}
  D3DX10_ERR_INVALID_DATA                     = HResult(MAKE_DDHRESULT_R or 2905);
  {$EXTERNALSYM D3DX10_ERR_INVALID_DATA}
  D3DX10_ERR_LOADED_MESH_HAS_NO_DATA          = HResult(MAKE_DDHRESULT_R or 2906);
  {$EXTERNALSYM D3DX10_ERR_LOADED_MESH_HAS_NO_DATA}
  D3DX10_ERR_DUPLICATE_NAMED_FRAGMENT         = HResult(MAKE_DDHRESULT_R or 2907);
  {$EXTERNALSYM D3DX10_ERR_DUPLICATE_NAMED_FRAGMENT}
  D3DX10_ERR_CANNOT_REMOVE_LAST_ITEM		      = HResult(MAKE_DDHRESULT_R or 2908);
  {$EXTERNALSYM D3DX10_ERR_CANNOT_REMOVE_LAST_ITEM}


//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       D3DX10math.h, d3dx10math.inl
//  Content:    D3DX10 math types and functions
//
//////////////////////////////////////////////////////////////////////////////


//===========================================================================
//
// General purpose utilities
//
//===========================================================================
const
  D3DX_PI    = (3.14159265358979323846);
  {$EXTERNALSYM D3DX_PI}
  D3DX_1BYPI = (1.0 / D3DX_PI);
  {$EXTERNALSYM D3DX_1BYPI}

//#define D3DXToRadian( degree ) ((degree) * (D3DX_PI / 180.0))
function D3DXToRadian(Degree: Double): Double;{$IFDEF ALLOW_INLINE} inline;{$ENDIF} overload;
function D3DXToRadian(Degree: Single): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF} overload;
{$EXTERNALSYM D3DXToRadian}
//#define D3DXToDegree( radian ) ((radian) * (180.0 / D3DX_PI))
function D3DXToDegree(Radian: Double): Double;{$IFDEF ALLOW_INLINE} inline;{$ENDIF} overload;
function D3DXToDegree(Radian: Single): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF} overload;
{$EXTERNALSYM D3DXToDegree}



//===========================================================================
//
// 16 bit floating point numbers
//
//===========================================================================

const
  D3DX_16F_DIG          = 3;               // # of decimal digits of precision
  {$EXTERNALSYM D3DX_16F_DIG}
  D3DX_16F_EPSILON      = 4.8875809e-4;    // smallest such that 1.0 + epsilon <> 1.0
  {$EXTERNALSYM D3DX_16F_EPSILON}
  D3DX_16F_MANT_DIG     = 11;              // # of bits in mantissa
  {$EXTERNALSYM D3DX_16F_MANT_DIG}
  D3DX_16F_MAX          = 6.550400e+004;   // max value
  {$EXTERNALSYM D3DX_16F_MAX}
  D3DX_16F_MAX_10_EXP   = 4;               // max decimal exponent
  {$EXTERNALSYM D3DX_16F_MAX_10_EXP}
  D3DX_16F_MAX_EXP      = 15;              // max binary exponent
  {$EXTERNALSYM D3DX_16F_MAX_EXP}
  D3DX_16F_MIN          = 6.1035156e-5;    // min positive value
  {$EXTERNALSYM D3DX_16F_MIN}
  D3DX_16F_MIN_10_EXP   = -4;              // min decimal exponent
  {$EXTERNALSYM D3DX_16F_MIN_10_EXP}
  D3DX_16F_MIN_EXP      = -14;             // min binary exponent
  {$EXTERNALSYM D3DX_16F_MIN_EXP}
  D3DX_16F_RADIX        = 2;               // exponent radix
  {$EXTERNALSYM D3DX_16F_RADIX}
  D3DX_16F_ROUNDS       = 1;               // addition rounding: near
  {$EXTERNALSYM D3DX_16F_ROUNDS}
  D3DX_16F_SIGN_MASK    = $8000;
  {$EXTERNALSYM D3DX_16F_SIGN_MASK}
  D3DX_16F_EXP_MASK     = $7C00;
  {$EXTERNALSYM D3DX_16F_EXP_MASK}
  D3DX_16F_FRAC_MASK    = $03FF;
  {$EXTERNALSYM D3DX_16F_FRAC_MASK}


type
  (*$HPPEMIT 'typedef D3DXFLOAT16       TD3DXFloat16;' *)
  (*$HPPEMIT 'typedef D3DXFLOAT16      *PD3DXFloat16;' *)
  PD3DXFloat16 = ^TD3DXFloat16;
  {$EXTERNALSYM PD3DXFloat16}
  TD3DXFloat16 = packed record
    value: Word;
  end;
  {$NODEFINE TD3DXFloat16}

// Some pascal equalents of C++ class functions & operators
const D3DXFloat16Zero: TD3DXFloat16 = (value:0); // 0
function D3DXFloat16(value: Single): TD3DXFloat16;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXFloat16Equal(const v1, v2: TD3DXFloat16): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXFloat16NotEqual(const v1, v2: TD3DXFloat16): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXFloat16ToFloat(value: TD3DXFloat16): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}



//===========================================================================
//
// Vectors
//
//===========================================================================


//--------------------------
// 2D Vector
//--------------------------
type
  (*$HPPEMIT 'typedef D3DXVECTOR2       TD3DXVector2;' *)
  (*$HPPEMIT 'typedef D3DXVECTOR2      *PD3DXVector2;' *)
  PD3DXVector2 = ^TD3DXVector2;
  {$EXTERNALSYM PD3DXVector2}
  TD3DXVector2 = record
    x, y: Single;
  end;
  {$NODEFINE TD3DXVector2}

// Some pascal equalents of C++ class functions & operators
const D3DXVector2Zero: TD3DXVector2 = (x:0; y:0);  // (0,0)
function D3DXVector2(_x, _y: Single): TD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector2Equal(const v1, v2: TD3DXVector2): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}



//--------------------------
// 2D Vector (16 bit)
//--------------------------
type
  (*$HPPEMIT 'typedef D3DXVECTOR2_16F       TD3DXVector2_16F;' *)
  (*$HPPEMIT 'typedef D3DXVECTOR2_16F      *PD3DXVector2_16F;' *)
  PD3DXVector2_16F = ^TD3DXVector2_16F;
  {$EXTERNALSYM PD3DXVector2_16F}
  TD3DXVector2_16F = packed record
    x, y: TD3DXFloat16;
  end;
  {$NODEFINE TD3DXVector2_16F}

// Some pascal equalents of C++ class functions & operators
const D3DXVector2_16fZero: TD3DXVector2_16F = (x:(value:0); y:(value:0));  // (0,0)
function D3DXVector2_16F(_x, _y: TD3DXFloat16): TD3DXVector2_16F;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector2_16fEqual(const v1, v2: TD3DXVector2_16F): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector2_16fNotEqual(const v1, v2: TD3DXVector2_16F): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector2_16fFromVector2(const v: TD3DXVector2): TD3DXVector2_16f;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector2FromVector2_16f(const v: TD3DXVector2_16f): TD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}



//--------------------------
// 3D Vector
//--------------------------
type
  (*$HPPEMIT 'typedef D3DXVECTOR3       TD3DXVector3;' *)
  (*$HPPEMIT 'typedef D3DXVECTOR3      *PD3DXVector3;' *)
  PD3DXVector3 = ^TD3DXVector3;
  {$EXTERNALSYM PD3DXVector3}
  TD3DXVector3 = TD3DVector;
  {$NODEFINE TD3DXVector3}

// Some pascal equalents of C++ class functions & operators
const D3DXVector3Zero: TD3DXVector3 = (x:0; y:0; z:0);  // (0,0,0)
function D3DXVector3(_x, _y, _z: Single): TD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector3Equal(const v1, v2: TD3DXVector3): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}



//--------------------------
// 3D Vector (16 bit)
//--------------------------
type
  (*$HPPEMIT 'typedef D3DXVECTOR3_16F       TD3DXVector3_16F;' *)
  (*$HPPEMIT 'typedef D3DXVECTOR3_16F      *PD3DXVector3_16F;' *)
  PD3DXVector3_16F = ^TD3DXVector3_16F;
  {$EXTERNALSYM PD3DXVector3}
  TD3DXVector3_16F = packed record
    x, y, z: TD3DXFloat16;
  end;
  {$NODEFINE TD3DXVector3_16F}

// Some pascal equalents of C++ class functions & operators
const D3DXVector3_16fZero: TD3DXVector3_16F = (x:(value:0); y:(value:0); z:(value:0));  // (0,0,0)
function D3DXVector3_16F(_x, _y, _z: TD3DXFloat16): TD3DXVector3_16F;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector3_16fEqual(const v1, v2: TD3DXVector3_16F): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector3_16fNotEqual(const v1, v2: TD3DXVector3_16F): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector3_16fFromVector3(const v: TD3DXVector3): TD3DXVector3_16f;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector3FromVector3_16f(const v: TD3DXVector3_16f): TD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}



//--------------------------
// 4D Vector
//--------------------------
type
  (*$HPPEMIT 'typedef D3DXVECTOR4       TD3DXVector4;' *)
  (*$HPPEMIT 'typedef D3DXVECTOR4      *PD3DXVector4;' *)
  PD3DXVector4 = ^TD3DXVector4;
  {$EXTERNALSYM PD3DXVector4}
  TD3DXVector4 = record
    x, y, z, w: Single;
  end;
  {$NODEFINE TD3DXVector4}

// Some pascal equalents of C++ class functions & operators
const D3DXVector4Zero: TD3DXVector4 = (x:0; y:0; z:0; w:0);  // (0,0,0,0)
function D3DXVector4(_x, _y, _z, _w: Single): TD3DXVector4; overload;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector4(xyz: TD3DXVector3; _w: Single): TD3DXVector4; overload;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector4Equal(const v1, v2: TD3DXVector4): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}



//--------------------------
// 4D Vector (16 bit)
//--------------------------
type
  (*$HPPEMIT 'typedef D3DXVECTOR4_16F       TD3DXVector4_16F;' *)
  (*$HPPEMIT 'typedef D3DXVECTOR4_16F      *PD3DXVector4_16F;' *)
  PD3DXVector4_16F = ^TD3DXVector4_16F;
  {$EXTERNALSYM PD3DXVector4_16F}
  TD3DXVector4_16F = packed record
    x, y, z, w: TD3DXFloat16;
  end;
  {$NODEFINE TD3DXVector4_16F}

// Some pascal equalents of C++ class functions & operators
const D3DXVector4_16fZero: TD3DXVector4_16F = (x:(value:0); y:(value:0); z:(value:0); w:(value:0));  // (0,0,0,0)
function D3DXVector4_16F(_x, _y, _z, _w: TD3DXFloat16): TD3DXVector4_16F; overload;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector4_16F(xyz: TD3DXVector3_16f; _w: TD3DXFloat16): TD3DXVector4_16F; overload;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector4_16fEqual(const v1, v2: TD3DXVector4_16F): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector4_16fNotEqual(const v1, v2: TD3DXVector4_16F): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector4_16fFromVector4(const v: TD3DXVector4): TD3DXVector4_16f;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXVector4FromVector4_16f(const v: TD3DXVector4_16f): TD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}



//===========================================================================
//
// Matrices
//
//===========================================================================
type
  (*$HPPEMIT 'typedef D3DXMATRIX        TD3DXMatrix;' *)
  (*$HPPEMIT 'typedef D3DXMATRIX       *PD3DXMatrix;' *)
  (*$HPPEMIT 'typedef D3DXMATRIX      **PPD3DXMatrix;' *)
  PPD3DXMatrix = ^PD3DXMatrix;
  PD3DXMatrix = ^TD3DXMatrix;
  {$EXTERNALSYM PD3DXMatrix}
  TD3DXMatrix = TD3DMatrix;
  {$NODEFINE TD3DXMatrix}

// Some pascal equalents of C++ class functions & operators
function D3DXMatrix(
  _m00, _m01, _m02, _m03,
  _m10, _m11, _m12, _m13,
  _m20, _m21, _m22, _m23,
  _m30, _m31, _m32, _m33: Single): TD3DXMatrix;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXMatrixAdd(out mOut: TD3DXMatrix; const m1, m2: TD3DXMatrix): PD3DXMatrix;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXMatrixSubtract(out mOut: TD3DXMatrix; const m1, m2: TD3DXMatrix): PD3DXMatrix;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXMatrixMul(out mOut: TD3DXMatrix; const m: TD3DXMatrix; MulBy: Single): PD3DXMatrix;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXMatrixEqual(const m1, m2: TD3DXMatrix): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}


//---------------------------------------------------------------------------
// Aligned Matrices
//
// This class helps keep matrices 16-byte aligned as preferred by P4 cpus.
// It aligns matrices on the stack and on the heap or in global scope.
// It does this using __declspec(align(16)) which works on VC7 and on VC 6
// with the processor pack. Unfortunately there is no way to detect the
// latter so this is turned on only on VC7. On other compilers this is the
// the same as D3DXMATRIX.
//
// Using this class on a compiler that does not actually do the alignment
// can be dangerous since it will not expose bugs that ignore alignment.
// E.g if an object of this class in inside a struct or class, and some code
// memcopys data in it assuming tight packing. This could break on a compiler
// that eventually start aligning the matrix.
//---------------------------------------------------------------------------

// Translator comments: None of current pascal compilers can even align data
// inside records to 16 byte boundary, so we just leave aligned matrix
// declaration equal to standart matrix
type
  PD3DXMatrixA16 = ^TD3DXMatrixA16;
  TD3DXMatrixA16 = TD3DXMatrix;


//===========================================================================
//
//    Quaternions
//
//===========================================================================
type
  (*$HPPEMIT 'typedef D3DXQUATERNION TD3DXQuaternion;' *)
  PD3DXQuaternion = ^TD3DXQuaternion;
  TD3DXQuaternion = record
    x, y, z, w: Single;
  end;
  {$NODEFINE TD3DXQuaternion}

// Some pascal equalents of C++ class functions & operators
function D3DXQuaternion(_x, _y, _z, _w: Single): TD3DXQuaternion;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXQuaternionAdd(const q1, q2: TD3DXQuaternion): TD3DXQuaternion;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXQuaternionSubtract(const q1, q2: TD3DXQuaternion): TD3DXQuaternion;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXQuaternionEqual(const q1, q2: TD3DXQuaternion): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXQuaternionScale(out qOut: TD3DXQuaternion; const q: TD3DXQuaternion;
  s: Single): PD3DXQuaternion;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}



//===========================================================================
//
// Planes
//
//===========================================================================
type
  (*$HPPEMIT 'typedef D3DXPLANE TD3DXPlane;' *)
  PD3DXPlane = ^TD3DXPlane;
  TD3DXPlane = record
    a, b, c, d: Single;
  end;
  {$NODEFINE TD3DXPlane}

// Some pascal equalents of C++ class functions & operators
const D3DXPlaneZero: TD3DXPlane = (a:0; b:0; c:0; d:0);  // (0,0,0,0)
function D3DXPlane(_a, _b, _c, _d: Single): TD3DXPlane;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXPlaneEqual(const p1, p2: TD3DXPlane): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}


//===========================================================================
//
// Colors
//
//===========================================================================
type
  (*$HPPEMIT 'typedef D3DXCOLOR TD3DXColor;' *)
  (*$HPPEMIT 'typedef D3DXCOLOR *PD3DXColor;' *)
  PD3DXColor = PD3DColorValue;
  {$EXTERNALSYM PD3DXColor}
  TD3DXColor = TD3DColorValue;
  {$EXTERNALSYM TD3DXColor}

function D3DXColor(_r, _g, _b, _a: Single): TD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXColorToDWord(c: TD3DXColor): DWord;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXColorToUINT(c: TD3DXColor): UINT;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXColorFromDWord(c: DWord): TD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXColorFromUINT(c: UINT): TD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
function D3DXColorEqual(const c1, c2: TD3DXColor): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}


//===========================================================================
//
// D3DX math functions:
//
// NOTE:
//  * All these functions can take the same object as in and out parameters.
//
//  * Out parameters are typically also returned as return values, so that
//    the output of one function may be used as a parameter to another.
//
//===========================================================================

//--------------------------
// Float16
//--------------------------

// non-inline

// Converts an array 32-bit floats to 16-bit floats
function D3DXFloat32To16Array(pOut: PD3DXFloat16; pIn: PSingle; n: LongWord): PD3DXFloat16; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXFloat32To16Array}

// Converts an array 16-bit floats to 32-bit floats
function D3DXFloat16To32Array(pOut: PSingle; pIn: PD3DXFloat16; n: LongWord): PSingle; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXFloat16To32Array}


//--------------------------
// 2D Vector
//--------------------------

// inline

function D3DXVec2Length(const v: TD3DXVector2): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2Length}

function D3DXVec2LengthSq(const v: TD3DXVector2): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2LengthSq}

function D3DXVec2Dot(const v1, v2: TD3DXVector2): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2Dot}

// Z component of ((x1,y1,0) cross (x2,y2,0))
function D3DXVec2CCW(const v1, v2: TD3DXVector2): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2CCW}

function D3DXVec2Add(const v1, v2: TD3DXVector2): TD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2Add}

function D3DXVec2Subtract(const v1, v2: TD3DXVector2): TD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2Subtract}

// Minimize each component.  x = min(x1, x2), y = min(y1, y2)
function D3DXVec2Minimize(out vOut: TD3DXVector2; const v1, v2: TD3DXVector2): PD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2Minimize}

// Maximize each component.  x = max(x1, x2), y = max(y1, y2)
function D3DXVec2Maximize(out vOut: TD3DXVector2; const v1, v2: TD3DXVector2): PD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2Maximize}

function D3DXVec2Scale(out vOut: TD3DXVector2; const v: TD3DXVector2; s: Single): PD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2Scale}

// Linear interpolation. V1 + s(V2-V1)
function D3DXVec2Lerp(out vOut: TD3DXVector2; const v1, v2: TD3DXVector2; s: Single): PD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec2Lerp}

// non-inline
function D3DXVec2Normalize(out vOut: TD3DXVector2; const v: TD3DXVector2): PD3DXVector2; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec2Normalize}

// Hermite interpolation between position V1, tangent T1 (when s == 0)
// and position V2, tangent T2 (when s == 1).
function D3DXVec2Hermite(out vOut: TD3DXVector2;
   const v1, t1, v2, t2: TD3DXVector2; s: Single): PD3DXVector2; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec2Hermite}

// CatmullRom interpolation between V1 (when s == 0) and V2 (when s == 1)
function D3DXVec2CatmullRom(out vOut: TD3DXVector2;
   const v0, v1, v2, v3: TD3DXVector2; s: Single): PD3DXVector2; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec2CatmullRom}

// Barycentric coordinates.  V1 + f(V2-V1) + g(V3-V1)
function D3DXVec2BaryCentric(out vOut: TD3DXVector2;
   const v1, v2, v3: TD3DXVector2; f, g: Single): PD3DXVector2; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec2BaryCentric}

// Transform (x, y, 0, 1) by matrix.
function D3DXVec2Transform(out vOut: TD3DXVector4;
  const v: TD3DXVector2; const m: TD3DXMatrix): PD3DXVector4; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec2Transform}

// Transform (x, y, 0, 1) by matrix, project result back into w=1.
function D3DXVec2TransformCoord(out vOut: TD3DXVector2;
  const v: TD3DXVector2; const m: TD3DXMatrix): PD3DXVector2; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec2TransformCoord}

// Transform (x, y, 0, 0) by matrix.
function D3DXVec2TransformNormal(out vOut: TD3DXVector2;
  const v: TD3DXVector2; const m: TD3DXMatrix): PD3DXVector2; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec2TransformNormal}


// Transform Array (x, y, 0, 1) by matrix.
function D3DXVec2TransformArray(pOut: PD3DXVector4; OutStride: LongWord;
  pV: PD3DXVector2; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector4; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec2TransformArray}

// Transform Array (x, y, 0, 1) by matrix, project result back into w=1.
function D3DXVec2TransformCoordArray(pOut: PD3DXVector2; OutStride: LongWord;
  pV: PD3DXVector2; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector2; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec2TransformCoordArray}

// Transform Array (x, y, 0, 0) by matrix.
function D3DXVec2TransformNormalArray(pOut: PD3DXVector2; OutStride: LongWord;
  pV: PD3DXVector2; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector2; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec2TransformNormalArray}


//--------------------------
// 3D Vector
//--------------------------

// inline

function D3DXVec3Length(const v: TD3DXVector3): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3Length}

function D3DXVec3LengthSq(const v: TD3DXVector3): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3LengthSq}

function D3DXVec3Dot(const v1, v2: TD3DXVector3): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3Dot}

function D3DXVec3Cross(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3Cross}

function D3DXVec3Add(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3Add}

function D3DXVec3Subtract(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3Subtract}

// Minimize each component.  x = min(x1, x2), y = min(y1, y2), ...
function D3DXVec3Minimize(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3Minimize}

// Maximize each component.  x = max(x1, x2), y = max(y1, y2), ...
function D3DXVec3Maximize(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3Maximize}

function D3DXVec3Scale(out vOut: TD3DXVector3; const v: TD3DXVector3; s: Single): PD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3Scale}

// Linear interpolation. V1 + s(V2-V1)
function D3DXVec3Lerp(out vOut: TD3DXVector3;
  const v1, v2: TD3DXVector3; s: Single): PD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec3Lerp}

// non-inline

function D3DXVec3Normalize(out vOut: TD3DXVector3;
   const v: TD3DXVector3): PD3DXVector3; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec3Normalize}

// Hermite interpolation between position V1, tangent T1 (when s == 0)
// and position V2, tangent T2 (when s == 1).
function D3DXVec3Hermite(out vOut: TD3DXVector3;
   const v1, t1, v2, t2: TD3DXVector3; s: Single): PD3DXVector3; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec3Hermite}

// CatmullRom interpolation between V1 (when s == 0) and V2 (when s == 1)
function D3DXVec3CatmullRom(out vOut: TD3DXVector3;
   const v0, v1, v2, v3: TD3DXVector3; s: Single): PD3DXVector3; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec3CatmullRom}

// Barycentric coordinates.  V1 + f(V2-V1) + g(V3-V1)
function D3DXVec3BaryCentric(out vOut: TD3DXVector3;
   const v1, v2, v3: TD3DXVector3; f, g: Single): PD3DXVector3; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec3BaryCentric}

// Transform (x, y, z, 1) by matrix.
function D3DXVec3Transform(out vOut: TD3DXVector4;
  const v: TD3DXVector3; const m: TD3DXMatrix): PD3DXVector4; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec3Transform}

// Transform (x, y, z, 1) by matrix, project result back into w=1.
function D3DXVec3TransformCoord(out vOut: TD3DXVector3;
  const v: TD3DXVector3; const m: TD3DXMatrix): PD3DXVector3; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec3TransformCoord}

// Transform (x, y, z, 0) by matrix.  If you transforming a normal by a
// non-affine matrix, the matrix you pass to this function should be the
// transpose of the inverse of the matrix you would use to transform a coord.
function D3DXVec3TransformNormal(out vOut: TD3DXVector3;
  const v: TD3DXVector3; const m: TD3DXMatrix): PD3DXVector3; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec3TransformNormal}


// Transform Array (x, y, z, 1) by matrix.
function D3DXVec3TransformArray(pOut: PD3DXVector4; OutStride: LongWord;
  pV: PD3DXVector3; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector4; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec3TransformArray}

// Transform Array (x, y, z, 1) by matrix, project result back into w=1.
function D3DXVec3TransformCoordArray(pOut: PD3DXVector3; OutStride: LongWord;
  pV: PD3DXVector3; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector3; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec3TransformCoordArray}

// Transform (x, y, z, 0) by matrix.  If you transforming a normal by a
// non-affine matrix, the matrix you pass to this function should be the
// transpose of the inverse of the matrix you would use to transform a coord.
function D3DXVec3TransformNormalArray(pOut: PD3DXVector3; OutStride: LongWord;
  pV: PD3DXVector3; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector3; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec3TransformNormalArray}

// Project vector from object space into screen space
function D3DXVec3Project(out vOut: TD3DXVector3;
  const v: TD3DXVector3; const pViewport: TD3D10_Viewport;
  const pProjection, pView, pWorld: TD3DXMatrix): PD3DXVector3; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec3Project}

// Project vector from screen space into object space
function D3DXVec3Unproject(out vOut: TD3DXVector3;
  const v: TD3DXVector3; const pViewport: TD3D10_Viewport;
  const pProjection, pView, pWorld: TD3DXMatrix): PD3DXVector3; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec3Unproject}

// Project vector Array from object space into screen space
function D3DXVec3ProjectArray(pOut: PD3DXVector3; OutStride: LongWord;
  pV: PD3DXVector3; VStride: LongWord; const pViewport: TD3D10_Viewport;
  const pProjection, pView, pWorld: TD3DXMatrix; n: LongWord): PD3DXVector3; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec3ProjectArray}

// Project vector Array from screen space into object space
function D3DXVec3UnprojectArray(pOut: PD3DXVector3; OutStride: LongWord;
  pV: PD3DXVector3; VStride: LongWord; const pViewport: TD3D10_Viewport;
  const pProjection, pView, pWorld: TD3DXMatrix; n: LongWord): PD3DXVector3; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec3UnprojectArray}


//--------------------------
// 4D Vector
//--------------------------

// inline

function D3DXVec4Length(const v: TD3DXVector4): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec4Length}

function D3DXVec4LengthSq(const v: TD3DXVector4): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec4LengthSq}

function D3DXVec4Dot(const v1, v2: TD3DXVector4): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec4Dot}

function D3DXVec4Add(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec4Add}

function D3DXVec4Subtract(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec4Subtract}

// Minimize each component.  x = min(x1, x2), y = min(y1, y2), ...
function D3DXVec4Minimize(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec4Minimize}

// Maximize each component.  x = max(x1, x2), y = max(y1, y2), ...
function D3DXVec4Maximize(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec4Maximize}

function D3DXVec4Scale(out vOut: TD3DXVector4; const v: TD3DXVector4; s: Single): PD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec4Scale}

// Linear interpolation. V1 + s(V2-V1)
function D3DXVec4Lerp(out vOut: TD3DXVector4;
  const v1, v2: TD3DXVector4; s: Single): PD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXVec4Lerp}

// non-inline

// Cross-product in 4 dimensions.
function D3DXVec4Cross(out vOut: TD3DXVector4;
  const v1, v2, v3: TD3DXVector4): PD3DXVector4; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec4Cross}

function D3DXVec4Normalize(out vOut: TD3DXVector4;
  const v: TD3DXVector4): PD3DXVector4; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec4Normalize}

// Hermite interpolation between position V1, tangent T1 (when s == 0)
// and position V2, tangent T2 (when s == 1).
function D3DXVec4Hermite(out vOut: TD3DXVector4;
   const v1, t1, v2, t2: TD3DXVector4; s: Single): PD3DXVector4; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec4Hermite}

// CatmullRom interpolation between V1 (when s == 0) and V2 (when s == 1)
function D3DXVec4CatmullRom(out vOut: TD3DXVector4;
   const v0, v1, v2, v3: TD3DXVector4; s: Single): PD3DXVector4; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec4CatmullRom}

// Barycentric coordinates.  V1 + f(V2-V1) + g(V3-V1)
function D3DXVec4BaryCentric(out vOut: TD3DXVector4;
   const v1, v2, v3: TD3DXVector4; f, g: Single): PD3DXVector4; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec4BaryCentric}

// Transform vector by matrix.
function D3DXVec4Transform(out vOut: TD3DXVector4;
  const v: TD3DXVector4; const m: TD3DXMatrix): PD3DXVector4; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec4Transform}

// Transform vector array by matrix.
function D3DXVec4TransformArray(pOut: PD3DXVector4; OutStride: LongWord;
  pV: PD3DXVector4; VStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXVector4; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXVec4TransformArray}


//--------------------------
// 4D Matrix
//--------------------------

// inline

function D3DXMatrixIdentity(out mOut: TD3DXMatrix): PD3DXMatrix;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXMatrixIdentity}

function D3DXMatrixIsIdentity(const m: TD3DXMatrix): BOOL;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXMatrixIsIdentity}

// non-inline

function D3DXMatrixDeterminant(const m: TD3DXMatrix): Single; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixDeterminant}

function D3DXMatrixDecompose(pOutScale: PD3DXVector3; pOutRotation: PD3DXQuaternion;
   pOutTranslation: PD3DXVector3; const M: TD3DXMatrix): HRESULT; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixDecompose}

function D3DXMatrixTranspose(out pOut: TD3DXMatrix; const pM: TD3DXMatrix): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixTranspose}

// Matrix multiplication.  The result represents the transformation M2
// followed by the transformation M1.  (Out = M1 * M2)
function D3DXMatrixMultiply(out mOut: TD3DXMatrix; const m1, m2: TD3DXMatrix): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixMultiply}

// Matrix multiplication, followed by a transpose. (Out = T(M1 * M2))
function D3DXMatrixMultiplyTranspose(out pOut: TD3DXMatrix; const pM1, pM2: TD3DXMatrix): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixMultiplyTranspose}

// Calculate inverse of matrix.  Inversion my fail, in which case NULL will
// be returned.  The determinant of pM is also returned it pfDeterminant
// is non-NULL.
function D3DXMatrixInverse(out mOut: TD3DXMatrix; pfDeterminant: PSingle;
    const m: TD3DXMatrix): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixInverse}

// Build a matrix which scales by (sx, sy, sz)
function D3DXMatrixScaling(out mOut: TD3DXMatrix; sx, sy, sz: Single): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixScaling}

// Build a matrix which translates by (x, y, z)
function D3DXMatrixTranslation(out mOut: TD3DXMatrix; x, y, z: Single): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixTranslation}

// Build a matrix which rotates around the X axis
function D3DXMatrixRotationX(out mOut: TD3DXMatrix; angle: Single): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixRotationX}

// Build a matrix which rotates around the Y axis
function D3DXMatrixRotationY(out mOut: TD3DXMatrix; angle: Single): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixRotationY}

// Build a matrix which rotates around the Z axis
function D3DXMatrixRotationZ(out mOut: TD3DXMatrix; angle: Single): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixRotationZ}

// Build a matrix which rotates around an arbitrary axis
function D3DXMatrixRotationAxis(out mOut: TD3DXMatrix; const v: TD3DXVector3;
  angle: Single): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixRotationAxis}

// Build a matrix from a quaternion
function D3DXMatrixRotationQuaternion(out mOut: TD3DXMatrix; const Q: TD3DXQuaternion): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixRotationQuaternion}

// Yaw around the Y axis, a pitch around the X axis,
// and a roll around the Z axis.
function D3DXMatrixRotationYawPitchRoll(out mOut: TD3DXMatrix; yaw, pitch, roll: Single): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixRotationYawPitchRoll}

// Build transformation matrix.  NULL arguments are treated as identity.
// Mout = Msc-1 * Msr-1 * Ms * Msr * Msc * Mrc-1 * Mr * Mrc * Mt
function D3DXMatrixTransformation(out mOut: TD3DXMatrix;
   pScalingCenter: PD3DXVector3;
   pScalingRotation: PD3DXQuaternion; pScaling, pRotationCenter: PD3DXVector3;
   pRotation: PD3DXQuaternion; pTranslation: PD3DXVector3): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixTransformation}

// Build 2D transformation matrix in XY plane.  NULL arguments are treated as identity.
// Mout = Msc-1 * Msr-1 * Ms * Msr * Msc * Mrc-1 * Mr * Mrc * Mt
function D3DXMatrixTransformation2D(out pOut: TD3DXMatrix;
   pScalingCenter: PD3DXVector2;
   ScalingRotation: Single; pScaling: PD3DXVector2; pRotationCenter: PD3DXVector2;
   Rotation: Single; pTranslation: PD3DXVector2): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixTransformation2D}

// Build affine transformation matrix.  NULL arguments are treated as identity.
// Mout = Ms * Mrc-1 * Mr * Mrc * Mt
function D3DXMatrixAffineTransformation(out mOut: TD3DXMatrix;
   Scaling: Single; pRotationCenter: PD3DXVector3;
   pRotation: PD3DXQuaternion; pTranslation: PD3DXVector3): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixAffineTransformation}

// Build 2D affine transformation matrix in XY plane.  NULL arguments are treated as identity.
// Mout = Ms * Mrc-1 * Mr * Mrc * Mt
function D3DXMatrixAffineTransformation2D(out mOut: TD3DXMatrix;
   Scaling: Single; pRotationCenter: PD3DXVector2;
   Rotation: Single; pTranslation: PD3DXVector2): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixAffineTransformation2D}

// Build a lookat matrix. (right-handed)
function D3DXMatrixLookAtRH(out mOut: TD3DXMatrix; const Eye, At, Up: TD3DXVector3): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixLookAtRH}

// Build a lookat matrix. (left-handed)
function D3DXMatrixLookAtLH(out mOut: TD3DXMatrix; const Eye, At, Up: TD3DXVector3): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixLookAtLH}

// Build a perspective projection matrix. (right-handed)
function D3DXMatrixPerspectiveRH(out mOut: TD3DXMatrix; w, h, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixPerspectiveRH}

// Build a perspective projection matrix. (left-handed)
function D3DXMatrixPerspectiveLH(out mOut: TD3DXMatrix; w, h, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixPerspectiveLH}

// Build a perspective projection matrix. (right-handed)
function D3DXMatrixPerspectiveFovRH(out mOut: TD3DXMatrix; flovy, aspect, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixPerspectiveFovRH}

// Build a perspective projection matrix. (left-handed)
function D3DXMatrixPerspectiveFovLH(out mOut: TD3DXMatrix; flovy, aspect, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixPerspectiveFovLH}

// Build a perspective projection matrix. (right-handed)
function D3DXMatrixPerspectiveOffCenterRH(out mOut: TD3DXMatrix;
   l, r, b, t, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixPerspectiveOffCenterRH}

// Build a perspective projection matrix. (left-handed)
function D3DXMatrixPerspectiveOffCenterLH(out mOut: TD3DXMatrix;
   l, r, b, t, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixPerspectiveOffCenterLH}

// Build an ortho projection matrix. (right-handed)
function D3DXMatrixOrthoRH(out mOut: TD3DXMatrix; w, h, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixOrthoRH}

// Build an ortho projection matrix. (left-handed)
function D3DXMatrixOrthoLH(out mOut: TD3DXMatrix; w, h, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixOrthoLH}

// Build an ortho projection matrix. (right-handed)
function D3DXMatrixOrthoOffCenterRH(out mOut: TD3DXMatrix;
  l, r, b, t, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixOrthoOffCenterRH}

// Build an ortho projection matrix. (left-handed)
function D3DXMatrixOrthoOffCenterLH(out mOut: TD3DXMatrix;
  l, r, b, t, zn, zf: Single): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixOrthoOffCenterLH}

// Build a matrix which flattens geometry into a plane, as if casting
// a shadow from a light.
function D3DXMatrixShadow(out mOut: TD3DXMatrix;
  const Light: TD3DXVector4; const Plane: TD3DXPlane): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixShadow}

// Build a matrix which reflects the coordinate system about a plane
function D3DXMatrixReflect(out mOut: TD3DXMatrix;
   const Plane: TD3DXPlane): PD3DXMatrix; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXMatrixReflect}


//--------------------------
// Quaternion
//--------------------------

// inline

function D3DXQuaternionLength(const q: TD3DXQuaternion): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXQuaternionLength}

// Length squared, or "norm"
function D3DXQuaternionLengthSq(const q: TD3DXQuaternion): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXQuaternionLengthSq}

function D3DXQuaternionDot(const q1, q2: TD3DXQuaternion): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXQuaternionDot}

// (0, 0, 0, 1)
function D3DXQuaternionIdentity(out qOut: TD3DXQuaternion): PD3DXQuaternion;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXQuaternionIdentity}

function D3DXQuaternionIsIdentity (const q: TD3DXQuaternion): BOOL;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXQuaternionIsIdentity}

// (-x, -y, -z, w)
function D3DXQuaternionConjugate(out qOut: TD3DXQuaternion;
  const q: TD3DXQuaternion): PD3DXQuaternion;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXQuaternionConjugate}


// non-inline

// Compute a quaternin's axis and angle of rotation. Expects unit quaternions.
procedure D3DXQuaternionToAxisAngle(const q: TD3DXQuaternion;
  out Axis: TD3DXVector3; out Angle: Single); stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXQuaternionToAxisAngle}

// Build a quaternion from a rotation matrix.
function D3DXQuaternionRotationMatrix(out qOut: TD3DXQuaternion;
  const m: TD3DXMatrix): PD3DXQuaternion; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXQuaternionRotationMatrix}

// Rotation about arbitrary axis.
function D3DXQuaternionRotationAxis(out qOut: TD3DXQuaternion;
  const v: TD3DXVector3; Angle: Single): PD3DXQuaternion; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXQuaternionRotationAxis}

// Yaw around the Y axis, a pitch around the X axis,
// and a roll around the Z axis.
function D3DXQuaternionRotationYawPitchRoll(out qOut: TD3DXQuaternion;
  yaw, pitch, roll: Single): PD3DXQuaternion; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXQuaternionRotationYawPitchRoll}

// Quaternion multiplication.  The result represents the rotation Q2
// followed by the rotation Q1.  (Out = Q2 * Q1)
function D3DXQuaternionMultiply(out qOut: TD3DXQuaternion;
   const q1, q2: TD3DXQuaternion): PD3DXQuaternion; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXQuaternionMultiply}

function D3DXQuaternionNormalize(out qOut: TD3DXQuaternion;
   const q: TD3DXQuaternion): PD3DXQuaternion; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXQuaternionNormalize}

// Conjugate and re-norm
function D3DXQuaternionInverse(out qOut: TD3DXQuaternion;
   const q: TD3DXQuaternion): PD3DXQuaternion; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXQuaternionInverse}

// Expects unit quaternions.
// if q = (cos(theta), sin(theta) * v); ln(q) = (0, theta * v)
function D3DXQuaternionLn(out qOut: TD3DXQuaternion;
   const q: TD3DXQuaternion): PD3DXQuaternion; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXQuaternionLn}

// Expects pure quaternions. (w == 0)  w is ignored in calculation.
// if q = (0, theta * v); exp(q) = (cos(theta), sin(theta) * v)
function D3DXQuaternionExp(out qOut: TD3DXQuaternion;
   const q: TD3DXQuaternion): PD3DXQuaternion; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXQuaternionExp}

// Spherical linear interpolation between Q1 (s == 0) and Q2 (s == 1).
// Expects unit quaternions.
function D3DXQuaternionSlerp(out qOut: TD3DXQuaternion;
   const q1, q2: TD3DXQuaternion; t: Single): PD3DXQuaternion; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXQuaternionSlerp}

// Spherical quadrangle interpolation.
// Slerp(Slerp(Q1, C, t), Slerp(A, B, t), 2t(1-t))
function D3DXQuaternionSquad(out qOut: TD3DXQuaternion;
   const pQ1, pA, pB, pC: TD3DXQuaternion; t: Single): PD3DXQuaternion; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXQuaternionSquad}

// Setup control points for spherical quadrangle interpolation
// from Q1 to Q2.  The control points are chosen in such a way
// to ensure the continuity of tangents with adjacent segments.
procedure D3DXQuaternionSquadSetup(out pAOut, pBOut, pCOut: TD3DXQuaternion;
   const pQ0, pQ1, pQ2, pQ3: TD3DXQuaternion); stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXQuaternionSquadSetup}

// Barycentric interpolation.
// Slerp(Slerp(Q1, Q2, f+g), Slerp(Q1, Q3, f+g), g/(f+g))
function D3DXQuaternionBaryCentric(out qOut: TD3DXQuaternion;
   const q1, q2, q3: TD3DXQuaternion; f, g: Single): PD3DXQuaternion; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXQuaternionBaryCentric}


//--------------------------
// Plane
//--------------------------

// inline

// ax + by + cz + dw
function D3DXPlaneDot(const p: TD3DXPlane; const v: TD3DXVector4): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXPlaneDot}

// ax + by + cz + d
function D3DXPlaneDotCoord(const p: TD3DXPlane; const v: TD3DXVector3): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXPlaneDotCoord}

// ax + by + cz
function D3DXPlaneDotNormal(const p: TD3DXPlane; const v: TD3DXVector3): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXPlaneDotNormal}

function D3DXPlaneScale(out pOut: TD3DXPlane; const pP: TD3DXPlane; s: Single): PD3DXPlane;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXPlaneScale}


// non-inline

// Normalize plane (so that |a,b,c| == 1)
function D3DXPlaneNormalize(out pOut: TD3DXPlane; const p: TD3DXPlane): PD3DXPlane; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXPlaneNormalize}

// Find the intersection between a plane and a line.  If the line is
// parallel to the plane, NULL is returned.
function D3DXPlaneIntersectLine(out pOut: TD3DXVector3;
   const p: TD3DXPlane; const v1, v2: TD3DXVector3): PD3DXVector3; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXPlaneIntersectLine}

// Construct a plane from a point and a normal
function D3DXPlaneFromPointNormal(out pOut: TD3DXPlane;
   const vPoint, vNormal: TD3DXVector3): PD3DXPlane; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXPlaneFromPointNormal}

// Construct a plane from 3 points
function D3DXPlaneFromPoints(out pOut: TD3DXPlane;
   const v1, v2, v3: TD3DXVector3): PD3DXPlane; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXPlaneFromPoints}

// Transform a plane by a matrix.  The vector (a,b,c) must be normal.
// M should be the inverse transpose of the transformation desired.
function D3DXPlaneTransform(out pOut: TD3DXPlane; const p: TD3DXPlane; const m: TD3DXMatrix): PD3DXPlane; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXPlaneTransform}

// Transform an array of planes by a matrix.  The vectors (a,b,c) must be normal.
// M should be the inverse transpose of the transformation desired.
function D3DXPlaneTransformArray(pOut: PD3DXPlane; OutStride: LongWord;
  pP: PD3DXPlane; PStride: LongWord; const m: TD3DXMatrix; n: LongWord): PD3DXPlane; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXPlaneTransformArray}


//--------------------------
// Color
//--------------------------

// inline

// (1-r, 1-g, 1-b, a)
function D3DXColorNegative(out cOut: TD3DXColor; const c: TD3DXColor): PD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXColorNegative}

function D3DXColorAdd(out cOut: TD3DXColor; const c1, c2: TD3DXColor): PD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXColorAdd}

function D3DXColorSubtract(out cOut: TD3DXColor; const c1, c2: TD3DXColor): PD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXColorSubtract}

function D3DXColorScale(out cOut: TD3DXColor; const c: TD3DXColor; s: Single): PD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXColorScale}

// (r1*r2, g1*g2, b1*b2, a1*a2)
function D3DXColorModulate(out cOut: TD3DXColor; const c1, c2: TD3DXColor): PD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXColorModulate}

// Linear interpolation of r,g,b, and a. C1 + s(C2-C1)
function D3DXColorLerp(out cOut: TD3DXColor; const c1, c2: TD3DXColor; s: Single): PD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3DXColorLerp}

// non-inline

// Interpolate r,g,b between desaturated color and color.
// DesaturatedColor + s(Color - DesaturatedColor)
function D3DXColorAdjustSaturation(out cOut: TD3DXColor;
   const pC: TD3DXColor; s: Single): PD3DXColor; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXColorAdjustSaturation}

// Interpolate r,g,b between 50% grey and color.  Grey + s(Color - Grey)
function D3DXColorAdjustContrast(out cOut: TD3DXColor;
   const pC: TD3DXColor; c: Single): PD3DXColor; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXColorAdjustContrast}


//--------------------------
// Misc
//--------------------------

// Calculate Fresnel term given the cosine of theta (likely obtained by
// taking the dot of two normals), and the refraction index of the material.
function D3DXFresnelTerm(CosTheta, RefractionIndex: Single): Single; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXFresnelTerm}



//===========================================================================
//
//    Matrix Stack
//
//===========================================================================

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DXMatrixStack);'}
  {$EXTERNALSYM ID3DXMatrixStack}
  ID3DXMatrixStack = interface(IUnknown)
    ['{C7885BA7-F990-4fe7-922D-8515E477DD85}']
    //
    // ID3DXMatrixStack methods
    //

    // Pops the top of the stack, returns the current top
    // *after* popping the top.
    function Pop: HResult; stdcall;

    // Pushes the stack by one, duplicating the current matrix.
    function Push: HResult; stdcall;

    // Loads identity in the current matrix.
    function LoadIdentity: HResult; stdcall;

    // Loads the given matrix into the current matrix
    function LoadMatrix(const M: TD3DXMatrix): HResult; stdcall;

    // Right-Multiplies the given matrix to the current matrix.
    // (transformation is about the current world origin)
    function MultMatrix(const M: TD3DXMatrix): HResult; stdcall;

    // Left-Multiplies the given matrix to the current matrix
    // (transformation is about the local origin of the object)
    function MultMatrixLocal(const M: TD3DXMatrix): HResult; stdcall;

    // Right multiply the current matrix with the computed rotation
    // matrix, counterclockwise about the given axis with the given angle.
    // (rotation is about the current world origin)
    function RotateAxis(const V: TD3DXVector3; Angle: Single): HResult; stdcall;

    // Left multiply the current matrix with the computed rotation
    // matrix, counterclockwise about the given axis with the given angle.
    // (rotation is about the local origin of the object)
    function RotateAxisLocal(const V: TD3DXVector3; Angle: Single): HResult; stdcall;

    // Right multiply the current matrix with the computed rotation
    // matrix. All angles are counterclockwise. (rotation is about the
    // current world origin)

    // The rotation is composed of a yaw around the Y axis, a pitch around
    // the X axis, and a roll around the Z axis.
    function RotateYawPitchRoll(yaw, pitch, roll: Single): HResult; stdcall;

    // Left multiply the current matrix with the computed rotation
    // matrix. All angles are counterclockwise. (rotation is about the
    // local origin of the object)

    // The rotation is composed of a yaw around the Y axis, a pitch around
    // the X axis, and a roll around the Z axis.
    function RotateYawPitchRollLocal(yaw, pitch, roll: Single): HResult; stdcall;

    // Right multiply the current matrix with the computed scale
    // matrix. (transformation is about the current world origin)
    function Scale(x, y, z: Single): HResult; stdcall;

    // Left multiply the current matrix with the computed scale
    // matrix. (transformation is about the local origin of the object)
    function ScaleLocal(x, y, z: Single): HResult; stdcall;

    // Right multiply the current matrix with the computed translation
    // matrix. (transformation is about the current world origin)
    function Translate(x, y, z: Single): HResult; stdcall;

    // Left multiply the current matrix with the computed translation
    // matrix. (transformation is about the local origin of the object)
    function TranslateLocal(x, y, z: Single): HResult; stdcall;

    // Obtain the current matrix at the top of the stack
    function GetTop: PD3DXMatrix; stdcall;
  end;

  IID_ID3DXMatrixStack = ID3DXMatrixStack;
  {$EXTERNALSYM IID_ID3DXMatrixStack}

function D3DXCreateMatrixStack(Flags: UINT; out Stack: ID3DXMatrixStack): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXCreateMatrixStack}

//===========================================================================
//
//  Spherical Harmonic Runtime Routines
//
// NOTE:
//  * Most of these functions can take the same object as in and out parameters.
//    The exceptions are the rotation functions.
//
//  * Out parameters are typically also returned as return values, so that
//    the output of one function may be used as a parameter to another.
//
//============================================================================


//============================================================================
//
//  Basic Spherical Harmonic math routines
//
//============================================================================

const
  D3DXSH_MINORDER = 2;
  {$EXTERNALSYM D3DXSH_MINORDER}
  D3DXSH_MAXORDER = 6;
  {$EXTERNALSYM D3DXSH_MAXORDER}

//============================================================================
//
//  D3DXSHEvalDirection:
//  --------------------
//  Evaluates the Spherical Harmonic basis functions
//
//  Parameters:
//   pOut
//      Output SH coefficients - basis function Ylm is stored at l*l + m+l
//      This is the pointer that is returned.
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pDir
//      Direction to evaluate in - assumed to be normalized
//
//============================================================================

function D3DXSHEvalDirection(pOut: PSingle; Order: LongWord;
    const pDir: TD3DXVector3): PSingle; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXSHEvalDirection}

//============================================================================
//
//  D3DXSHRotate:
//  --------------------
//  Rotates SH vector by a rotation matrix
//
//  Parameters:
//   pOut
//      Output SH coefficients - basis function Ylm is stored at l*l + m+l
//      This is the pointer that is returned (should not alias with pIn.)
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pMatrix
//      Matrix used for rotation - rotation sub matrix should be orthogonal
//      and have a unit determinant.
//   pIn
//      Input SH coeffs (rotated), incorect results if this is also output.
//
//============================================================================

function D3DXSHRotate(pOut: PSingle; Order: LongWord;
    const pMatrix: TD3DXMatrix; pIn: PSingle): PSingle; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXSHRotate}

//============================================================================
//
//  D3DXSHRotateZ:
//  --------------------
//  Rotates the SH vector in the Z axis by an angle
//
//  Parameters:
//   pOut
//      Output SH coefficients - basis function Ylm is stored at l*l + m+l
//      This is the pointer that is returned (should not alias with pIn.)
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   Angle
//      Angle in radians to rotate around the Z axis.
//   pIn
//      Input SH coeffs (rotated), incorect results if this is also output.
//
//============================================================================

function D3DXSHRotateZ(pOut: PSingle; Order: LongWord;
    Angle: Single; pIn: PSingle): PSingle; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXSHRotateZ}

//============================================================================
//
//  D3DXSHAdd:
//  --------------------
//  Adds two SH vectors, pOut[i] = pA[i] + pB[i];
//
//  Parameters:
//   pOut
//      Output SH coefficients - basis function Ylm is stored at l*l + m+l
//      This is the pointer that is returned.
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pA
//      Input SH coeffs.
//   pB
//      Input SH coeffs (second vector.)
//
//============================================================================

function D3DXSHAdd(pOut: PSingle; Order: LongWord;
    pA, pB: PSingle): PSingle; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXSHAdd}

//============================================================================
//
//  D3DXSHScale:
//  --------------------
//  Adds two SH vectors, pOut[i] = pA[i]*Scale;
//
//  Parameters:
//   pOut
//      Output SH coefficients - basis function Ylm is stored at l*l + m+l
//      This is the pointer that is returned.
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pIn
//      Input SH coeffs.
//   Scale
//      Scale factor.
//
//============================================================================

function D3DXSHScale(pOut: PSingle; Order: LongWord;
    pIn: PSingle; Scale: Single): PSingle; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXSHScale}

//============================================================================
//
//  D3DXSHDot:
//  --------------------
//  Computes the dot product of two SH vectors
//
//  Parameters:
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pA
//      Input SH coeffs.
//   pB
//      Second set of input SH coeffs.
//
//============================================================================

function D3DXSHDot(Order: LongWord; pA, pB: PSingle): Single; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXSHDot}

//============================================================================
//
//  D3DXSHMultiply[O]:
//  --------------------
//  Computes the product of two functions represented using SH (f and g), where:
//  pOut[i] = int(y_i(s) * f(s) * g(s)), where y_i(s) is the ith SH basis
//  function, f(s) and g(s) are SH functions (sum_i(y_i(s)*c_i)).  The order O
//  determines the lengths of the arrays, where there should always be O^2
//  coefficients.  In general the product of two SH functions of order O generates
//  and SH function of order 2*O - 1, but we truncate the result.  This means
//  that the product commutes (f*g == g*f) but doesn't associate
//  (f*(g*h) != (f*g)*h.
//
//  Parameters:
//   pOut
//      Output SH coefficients - basis function Ylm is stored at l*l + m+l
//      This is the pointer that is returned.
//   pF
//      Input SH coeffs for first function.
//   pG
//      Second set of input SH coeffs.
//
//============================================================================

function D3DXSHMultiply2(pOut: PSingle; const pF, pG: PSingle): PSingle; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXSHMultiply2}
function D3DXSHMultiply3(pOut: PSingle; const pF, pG: PSingle): PSingle; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXSHMultiply3}
function D3DXSHMultiply4(pOut: PSingle; const pF, pG: PSingle): PSingle; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXSHMultiply4}
function D3DXSHMultiply5(pOut: PSingle; const pF, pG: PSingle): PSingle; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXSHMultiply5}
function D3DXSHMultiply6(pOut: PSingle; const pF, pG: PSingle): PSingle; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXSHMultiply6}

//============================================================================
//
//  Basic Spherical Harmonic lighting routines
//
//============================================================================

//============================================================================
//
//  D3DXSHEvalDirectionalLight:
//  --------------------
//  Evaluates a directional light and returns spectral SH data.  The output 
//  vector is computed so that if the intensity of R/G/B is unit the resulting
//  exit radiance of a point directly under the light on a diffuse object with
//  an albedo of 1 would be 1.0.  This will compute 3 spectral samples, pROut
//  has to be specified, while pGout and pBout are optional.
//
//  Parameters:
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pDir
//      Direction light is coming from (assumed to be normalized.)
//   RIntensity
//      Red intensity of light.
//   GIntensity
//      Green intensity of light.
//   BIntensity
//      Blue intensity of light.
//   pROut
//      Output SH vector for Red.
//   pGOut
//      Output SH vector for Green (optional.)
//   pBOut
//      Output SH vector for Blue (optional.)
//
//============================================================================

function D3DXSHEvalDirectionalLight(Order: LongWord; const pDir: TD3DXVector3;
    RIntensity: Single; GIntensity: Single; BIntensity: Single;
    pROut, pGOut, pBOut: PSingle): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXSHEvalDirectionalLight}

//============================================================================
//
//  D3DXSHEvalSphericalLight:
//  --------------------
//  Evaluates a spherical light and returns spectral SH data.  There is no
//  normalization of the intensity of the light like there is for directional
//  lights, care has to be taken when specifiying the intensities.  This will
//  compute 3 spectral samples, pROut has to be specified, while pGout and
//  pBout are optional.
//
//  Parameters:
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pPos
//      Position of light - reciever is assumed to be at the origin.
//   Radius
//      Radius of the spherical light source.
//   RIntensity
//      Red intensity of light.
//   GIntensity
//      Green intensity of light.
//   BIntensity
//      Blue intensity of light.
//   pROut
//      Output SH vector for Red.
//   pGOut
//      Output SH vector for Green (optional.)
//   pBOut
//      Output SH vector for Blue (optional.)
//
//============================================================================

function D3DXSHEvalSphericalLight(Order: LongWord; const pPos: TD3DXVector3; Radius: Single;
    RIntensity: Single; GIntensity: Single; BIntensity: Single;
    pROut, pGOut, pBOut: PSingle): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXSHEvalSphericalLight}

//============================================================================
//
//  D3DXSHEvalConeLight:
//  --------------------
//  Evaluates a light that is a cone of constant intensity and returns spectral
//  SH data.  The output vector is computed so that if the intensity of R/G/B is
//  unit the resulting exit radiance of a point directly under the light oriented
//  in the cone direction on a diffuse object with an albedo of 1 would be 1.0.
//  This will compute 3 spectral samples, pROut has to be specified, while pGout
//  and pBout are optional.
//
//  Parameters:
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pDir
//      Direction light is coming from (assumed to be normalized.)
//   Radius
//      Radius of cone in radians.
//   RIntensity
//      Red intensity of light.
//   GIntensity
//      Green intensity of light.
//   BIntensity
//      Blue intensity of light.
//   pROut
//      Output SH vector for Red.
//   pGOut
//      Output SH vector for Green (optional.)
//   pBOut
//      Output SH vector for Blue (optional.)
//
//============================================================================

function D3DXSHEvalConeLight(Order: LongWord; const pDir: TD3DXVector3; Radius: Single;
    RIntensity: Single; GIntensity: Single; BIntensity: Single;
    pROut, pGOut, pBOut: PSingle): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXSHEvalConeLight}
      
//============================================================================
//
//  D3DXSHEvalHemisphereLight:
//  --------------------
//  Evaluates a light that is a linear interpolant between two colors over the
//  sphere.  The interpolant is linear along the axis of the two points, not
//  over the surface of the sphere (ie: if the axis was (0,0,1) it is linear in
//  Z, not in the azimuthal angle.)  The resulting spherical lighting function
//  is normalized so that a point on a perfectly diffuse surface with no
//  shadowing and a normal pointed in the direction pDir would result in exit
//  radiance with a value of 1 if the top color was white and the bottom color
//  was black.  This is a very simple model where Top represents the intensity 
//  of the "sky" and Bottom represents the intensity of the "ground".
//
//  Parameters:
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pDir
//      Axis of the hemisphere.
//   Top
//      Color of the upper hemisphere.
//   Bottom
//      Color of the lower hemisphere.
//   pROut
//      Output SH vector for Red.
//   pGOut
//      Output SH vector for Green
//   pBOut
//      Output SH vector for Blue        
//
//============================================================================

function D3DXSHEvalHemisphereLight(Order: LongWord; const pDir: TD3DXVector3;
    Top, Bottom: TD3DXColor;
    pROut, pGOut, pBOut: PSingle): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXSHEvalHemisphereLight}


// Math intersection functions

function D3DXIntersectTri(
    const p0: TD3DXVector3;           // Triangle vertex 0 position
    const p1: TD3DXVector3;           // Triangle vertex 1 position
    const p2: TD3DXVector3;           // Triangle vertex 2 position
    const pRayPos: TD3DXVector3;      // Ray origin
    const pRayDir: TD3DXVector3;      // Ray direction
    pU: PSingle;                        // Barycentric Hit Coordinates
    pV: PSingle;                        // Barycentric Hit Coordinates
    pDist: PSingle                      // Ray-Intersection Parameter Distance
  ): BOOL; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXIntersectTri}

function D3DXSphereBoundProbe(
    const pCenter: TD3DXVector3;
    Radius: Single;
    const pRayPosition: TD3DXVector3;
    const pRayDirection: TD3DXVector3): BOOL; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXSphereBoundProbe}

function D3DXBoxBoundProbe(
    const pMin: TD3DXVector3;
    const pMax: TD3DXVector3;
    const pRayPosition: TD3DXVector3;
    const pRayDirection: TD3DXVector3): BOOL; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXBoxBoundProbe}

function D3DXComputeBoundingSphere(
    const pFirstPosition: PD3DXVector3;	// pointer to first position
    NumVertices: DWORD;
    dwStride: DWORD;							// count in bytes to subsequent position vectors
    pCenter: PD3DXVector3;//todo: check if we need Pointers here and in D3DXComputeBoundingBox
    pRadius: PSingle): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXComputeBoundingSphere}

function D3DXComputeBoundingBox(
    const pFirstPosition: PD3DXVector3;	// pointer to first position
    NumVertices: DWORD;
    dwStride: DWORD;							// count in bytes to subsequent position vectors
    pMin: PD3DXVector3;
    pMax: PD3DXVector3): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXComputeBoundingBox}


///////////////////////////////////////////////////////////////////////////
// CPU Optimization:
///////////////////////////////////////////////////////////////////////////

//-------------------------------------------------------------------------
// D3DX_CPU_OPTIMIZATION flags:
// ----------------------------
// D3DX_NOT_OPTIMIZED       Use Intel Pentium optimizations
// D3DX_3DNOW_OPTIMIZED     Use AMD 3DNow optimizations
// D3DX_SSE_OPTIMIZED       Use Intel Pentium III SSE optimizations
// D3DX_SSE2_OPTIMIZED      Use Intel Pentium IV SSE2 optimizations
//-------------------------------------------------------------------------


type
  _D3DX_CPU_OPTIMIZATION = (
    D3DX_NOT_OPTIMIZED = 0,
    D3DX_3DNOW_OPTIMIZED,
    D3DX_SSE2_OPTIMIZED,
    D3DX_SSE_OPTIMIZED
  );
  {$EXTERNALSYM _D3DX_CPU_OPTIMIZATION}
  D3DX_CPU_OPTIMIZATION = _D3DX_CPU_OPTIMIZATION;
  {$EXTERNALSYM D3DX_CPU_OPTIMIZATION}
  TD3DXCpuOptimization = _D3DX_CPU_OPTIMIZATION;
  PD3DXCpuOptimization = ^TD3DXCpuOptimization;


//-------------------------------------------------------------------------
// D3DXCpuOptimizations:
// ---------------------
// Enables or disables CPU optimizations. Returns the type of CPU, which
// was detected, and for which optimizations exist.
//
// Parameters:
//  Enable
//      TRUE to enable CPU optimizations. FALSE to disable.
//-------------------------------------------------------------------------

function D3DXCpuOptimizations(Enable: BOOL): TD3DXCpuOptimization; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DXCpuOptimizations}





///////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx10core.h
//  Content:    D3DX10 core types and functions
//
///////////////////////////////////////////////////////////////////////////

// Current name of the DLL shipped in the same SDK as this header.
const
  D3DX10_DLL_W = d3dx10_retail_DLL;
  {$EXTERNALSYM D3DX10_DLL_W}
  D3DX10_DLL_A = d3dx10_retail_DLL;
  {$EXTERNALSYM D3DX10_DLL_A}
  D3DX10_DLL = d3dx10_retail_DLL;
  {$EXTERNALSYM D3DX10_DLL}


///////////////////////////////////////////////////////////////////////////
// D3DX10_SDK_VERSION:
// -----------------
// This identifier is passed to D3DX10CheckVersion in order to ensure that an
// application was built against the correct header files and lib files.
// This number is incremented whenever a header (or other) change would
// require applications to be rebuilt. If the version doesn't match,
// D3DX10CreateVersion will return FALSE. (The number itself has no meaning.)
///////////////////////////////////////////////////////////////////////////

const
  D3DX10_SDK_VERSION = 41;
  {$EXTERNALSYM D3DX10_SDK_VERSION}

///////////////////////////////////////////////////////////////////////////
// D3DX10CreateDevice
// D3DX10CreateDeviceAndSwapChain
// D3DX10GetFeatureLevel1
///////////////////////////////////////////////////////////////////////////
function D3DX10CreateDevice(
    pAdapter: IDXGIAdapter;
    DriverType: TD3D10_DriverType;
    Software: HMODULE;
    Flags: LongWord;
    out ppDevice: ID3D10Device): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CreateDevice}

function D3DX10CreateDeviceAndSwapChain(
    pAdapter: IDXGIAdapter;
    DriverType: TD3D10_DriverType;
    Software: HMODULE;
    Flags: LongWord;
    pSwapChainDesc: PDXGI_SwapChainDesc;
    out ppSwapChain: IDXGISwapChain;
    out ppDevice: ID3D10Device): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CreateDeviceAndSwapChain}

function D3DX10GetFeatureLevel1(pDevice: ID3D10Device; out ppDevice1: ID3D10Device1): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10GetFeatureLevel1}


//{$IFDEF D3D_DIAG_DLL}
function D3DX10DebugMute(Mute: BOOL): BOOL; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10DebugMute}
//{$ENDIF}


function D3DX10CheckVersion(D3DSdkVersion: LongWord; D3DX10SdkVersion: LongWord): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CheckVersion}
//function D3DX10GetDriverLevel(const pDevice: ID3D10Device): UINT; stdcall; external d3dx10dll;
//{$EXTERNALSYM D3DX10GetDriverLevel}



//////////////////////////////////////////////////////////////////////////////
// D3DX10_SPRITE flags:
// -----------------
// D3DX10_SPRITE_SAVE_STATE
//   Specifies device state should be saved and restored in Begin/End.
// D3DX10SPRITE_SORT_TEXTURE
//   Sprites are sorted by texture prior to drawing.  This is recommended when
//   drawing non-overlapping sprites of uniform depth.  For example, drawing
//   screen-aligned text with ID3DX10Font.
// D3DX10SPRITE_SORT_DEPTH_FRONT_TO_BACK
//   Sprites are sorted by depth front-to-back prior to drawing.  This is
//   recommended when drawing opaque sprites of varying depths.
// D3DX10SPRITE_SORT_DEPTH_BACK_TO_FRONT
//   Sprites are sorted by depth back-to-front prior to drawing.  This is 
//   recommended when drawing transparent sprites of varying depths.
// D3DX10SPRITE_ADDREF_TEXTURES
//   AddRef/Release all textures passed in to DrawSpritesBuffered
//////////////////////////////////////////////////////////////////////////////

type
  D3DX10_SPRITE_FLAG = Byte; // Byte or DWORD?
  {$EXTERNALSYM D3DX10_SPRITE_FLAG}
  _D3DX10_SPRITE_FLAG = Byte;
  {$EXTERNALSYM _D3DX10_SPRITE_FLAG}

const
  D3DX10_SPRITE_SORT_TEXTURE              = $01;
  {$EXTERNALSYM D3DX10_SPRITE_SORT_TEXTURE}
  D3DX10_SPRITE_SORT_DEPTH_BACK_TO_FRONT  = $02;
  {$EXTERNALSYM D3DX10_SPRITE_SORT_DEPTH_BACK_TO_FRONT}
  D3DX10_SPRITE_SORT_DEPTH_FRONT_TO_BACK  = $04;
  {$EXTERNALSYM D3DX10_SPRITE_SORT_DEPTH_FRONT_TO_BACK}
  D3DX10_SPRITE_SAVE_STATE                = $08;
  {$EXTERNALSYM D3DX10_SPRITE_SAVE_STATE}
  D3DX10_SPRITE_ADDREF_TEXTURES           = $10;
  {$EXTERNALSYM D3DX10_SPRITE_ADDREF_TEXTURES}

type
  PD3DX10_Sprite = ^TD3DX10_Sprite;
  _D3DX10_SPRITE = record
    matWorld:  TD3DXMatrix;

    TexCoord: TD3DXVector2;
    TexSize: TD3DXVector2;

    ColorModulate: TD3DXColor;

    pTexture: ID3D10ShaderResourceView;
    TextureIndex: LongWord;
  end;
  {$EXTERNALSYM _D3DX10_SPRITE}
  D3DX10_SPRITE = _D3DX10_SPRITE;
  {$EXTERNALSYM D3DX10_SPRITE}
  TD3DX10_Sprite = _D3DX10_SPRITE;


//////////////////////////////////////////////////////////////////////////////
// ID3DX10Sprite:
// ------------
// This object intends to provide an easy way to drawing sprites using D3D.
//
// Begin -
//    Prepares device for drawing sprites.
//
// Draw -
//    Draws a sprite
//
// Flush -
//    Forces all batched sprites to submitted to the device.
//
// End - 
//    Restores device state to how it was when Begin was called.
//
//////////////////////////////////////////////////////////////////////////////

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DX10Sprite);'}
  {$EXTERNALSYM ID3DX10Sprite}
  ID3DX10Sprite = interface (IUnknown)
    ['{BA0B762D-8D28-43ec-B9DC-2F84443B0614}']
    // ID3DX10Sprite
    function _Begin(flags: LongWord): HResult; stdcall;

    function DrawSpritesBuffered(pSprites: PD3DX10_Sprite; cSprites: LongWord): HResult; stdcall;
    function Flush(): HResult; stdcall;

    function DrawSpritesImmediate(pSprites: PD3DX10_Sprite; cSprites: LongWord; cbSprite: LongWord; flags: LongWord): HResult; stdcall;
    function _End(): HResult; stdcall;

    function GetViewTransform(out pViewTransform: TD3DXMatrix): HResult; stdcall;
    function SetViewTransform(const pViewTransform: TD3DXMatrix): HResult; stdcall; //todo: Can it be NULL (for identity matrix?)
    function GetProjectionTransform(out pProjectionTransform: TD3DXMatrix): HResult; stdcall;
    function SetProjectionTransform(const pProjectionTransform: TD3DXMatrix): HResult; stdcall;

    function GetDevice(out ppDevice: ID3D10Device): HResult; stdcall;
  end;

  IID_ID3DX10Sprite = ID3DX10Sprite;
  {$EXTERNALSYM IID_ID3DX10Sprite}


function D3DX10CreateSprite(
    const pDevice: ID3D10Device;
    cDeviceBufferSize: LongWord;
    out ppSprite: ID3DX10Sprite): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CreateSprite}



//////////////////////////////////////////////////////////////////////////////
// ID3DX10ThreadPump:
//////////////////////////////////////////////////////////////////////////////

type
  {$EXTERNALSYM ID3DX10DataLoader}
  {$IFDEF FPC}{$INTERFACES CORBA} { To expose FreePascal class as abstract C++ class }{$ENDIF}
  ID3DX10DataLoader = {$IFDEF FPC}interface{$ELSE}class{$ENDIF}
    function Load(): HResult; {$IFDEF FPC}stdcall{$ELSE}virtual; stdcall; abstract{$ENDIF};
    function Decompress(ppData: PPointer; pcBytes: PSIZE_T): HResult; {$IFDEF FPC}stdcall{$ELSE}virtual; stdcall; abstract{$ENDIF};
    {$WARNINGS OFF}
    function Destroy(): HResult; {$IFDEF FPC}stdcall{$ELSE}virtual; stdcall; abstract{$ENDIF};
    {$WARNINGS ON}
  end;
  {$IFDEF FPC}{$INTERFACES DEFAULT}{$ENDIF}


  {$EXTERNALSYM ID3DX10DataProcessor}
  {$IFDEF FPC}{$INTERFACES CORBA} { To expose FreePascal class as abstract C++ class }{$ENDIF}
  ID3DX10DataProcessor = {$IFDEF FPC}interface{$ELSE}class{$ENDIF}
    function Process(pData: Pointer; cBytes: SIZE_T): HResult; {$IFDEF FPC}stdcall{$ELSE}virtual; stdcall; abstract{$ENDIF};
    function CreateDeviceObject(out ppDataObject: Pointer): HResult; {$IFDEF FPC}stdcall{$ELSE}virtual; stdcall; abstract{$ENDIF};
    {$WARNINGS OFF}
    function Destroy(): HResult; {$IFDEF FPC}stdcall{$ELSE}virtual; stdcall; abstract{$ENDIF};
    {$WARNINGS ON}
  end;
  {$IFDEF FPC}{$INTERFACES DEFAULT}{$ENDIF}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DX10ThreadPump);'}
  {$EXTERNALSYM ID3DX10ThreadPump}
  ID3DX10ThreadPump = interface (IUnknown)
    ['{C93FECFA-6967-478a-ABBC-402D90621FCB}']
    // ID3DX10ThreadPump
    function AddWorkItem(const pDataLoader: ID3DX10DataLoader; const pDataProcessor: ID3DX10DataProcessor; pHResult: PHRESULT; ppDeviceObject: PPointer): HResult; stdcall;
    function GetWorkItemCount(): LongWord; stdcall;

    function WaitForAllItems(): HResult; stdcall;
    function ProcessDeviceWorkItems(iWorkItemCount: LongWord): HResult; stdcall;
    //todo: Report bug: Lacks PURE definition -- STDMETHOD(ProcessDeviceWorkItems)(THIS_ UINT iWorkItemCount); PURE

    function PurgeAllItems(): HResult; stdcall;
    function GetQueueStatus(pIoQueue: PLongWord; pProcessQueue: PLongWord; pDeviceQueue: PLongWord): HResult; stdcall; //todo: Check parameters
  end;


function D3DX10CreateThreadPump(cIoThreads: LongWord; cProcThreads: LongWord; out ppThreadPump: ID3DX10ThreadPump): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CreateThreadPump}


//////////////////////////////////////////////////////////////////////////////
// ID3DX10Font:
// ----------
// Font objects contain the textures and resources needed to render a specific
// font on a specific device.
//
// GetGlyphData -
//    Returns glyph cache data, for a given glyph.
//
// PreloadCharacters/PreloadGlyphs/PreloadText -
//    Preloads glyphs into the glyph cache textures.
//
// DrawText -
//    Draws formatted text on a D3D device.  Some parameters are
//    surprisingly similar to those of GDI's DrawText function.  See GDI
//    documentation for a detailed description of these parameters.
//    If pSprite is NULL, an internal sprite object will be used.
//
//////////////////////////////////////////////////////////////////////////////

type
  PD3DX10_FontDescA = ^TD3DX10_FontDescA;
  PD3DX10_FontDescW = ^TD3DX10_FontDescW;
  PD3DX10_FontDesc = PD3DX10_FontDescA;
  _D3DX10_FONT_DESCA = record
    Height: Integer;
    Width: LongWord;
    Weight: LongWord;
    MipLevels: LongWord;
    Italic: BOOL;
    CharSet: Byte;
    OutputPrecision: Byte;
    Quality: Byte;
    PitchAndFamily: Byte;
    FaceName: array[0..LF_FACESIZE-1] of AnsiChar;
  end;
  {$EXTERNALSYM _D3DX10_FONT_DESCA}
  _D3DX10_FONT_DESCW = record
    Height: Integer;
    Width: LongWord;
    Weight: LongWord;
    MipLevels: LongWord;
    Italic: BOOL;
    CharSet: Byte;
    OutputPrecision: Byte;
    Quality: Byte;
    PitchAndFamily: Byte;
    FaceName: array[0..LF_FACESIZE-1] of WideChar;
  end;
  {$EXTERNALSYM _D3DX10_FONT_DESCW}
  _D3DX10_FONT_DESC = _D3DX10_FONT_DESCA;
  {$EXTERNALSYM _D3DX10_FONT_DESC}
  D3DX10_FONT_DESCA = _D3DX10_FONT_DESCA;
  {$EXTERNALSYM D3DX10_FONT_DESCA}
  D3DX10_FONT_DESCW = _D3DX10_FONT_DESCW;
  {$EXTERNALSYM D3DX10_FONT_DESCW}
  D3DX10_FONT_DESC = D3DX10_FONT_DESCA;
  {$EXTERNALSYM D3DX10_FONT_DESC}
  TD3DX10_FontDescA = _D3DX10_FONT_DESCA;
  TD3DX10_FontDescW = _D3DX10_FONT_DESCW;
  TD3DX10_FontDesc = TD3DX10_FontDescA;
//{$IFDEF FPC}
//
//  TTextMetricA = TTextMetric;
//  TTextMetricW = tagTextMetricW;
//{$ENDIF}

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DX10Font);'}
  {$EXTERNALSYM ID3DX10Font}
  ID3DX10Font = interface (IUnknown)
    ['{D79DBB70-5F21-4d36-BBC2-FF525C213CDC}']
    // ID3DX10Font
    function GetDevice(out ppDevice: ID3D10Device): HResult; stdcall;
    function GetDescA(out pDesc: TD3DX10_FontDescA): HResult; stdcall;
    function GetDescW(out pDesc: TD3DX10_FontDescW): HResult; stdcall;
    function GetTextMetricsA(out pTextMetrics: TTextMetricA): BOOL; stdcall;
    function GetTextMetricsW(out pTextMetrics: TTextMetricW): BOOL; stdcall;

    function GetDC(): HDC; stdcall;
    function GetGlyphData(Glyph: LongWord; out ppTexture: ID3D10ShaderResourceView; pBlackBox: PRect; pCellInc: PPoint): HResult; stdcall; //todo: Check parameters

    function PreloadCharacters(First: LongWord; Last: LongWord): HResult; stdcall;
    function PreloadGlyphs(First: LongWord; Last: LongWord): HResult; stdcall;
    function PreloadTextA(pString: PAnsiChar; Count: Integer): HResult; stdcall;
    function PreloadTextW(pString: PWideChar; Count: Integer): HResult; stdcall;

    function DrawTextA(pSprite: ID3DX10Sprite; pString: PAnsiChar; Count: Integer; pRect: PRect; Format: LongWord; Color: TD3DXColor): Integer; stdcall; //todo: check PRect
    function DrawTextW(pSprite: ID3DX10Sprite; pString: PWideChar; Count: Integer; pRect: PRect; Format: LongWord; Color: TD3DXColor): Integer; stdcall; //todo: check PRect
  end;

  IID_ID3DX10Font = ID3DX10Font;
  {$EXTERNALSYM IID_ID3DX10Font}


function D3DX10CreateFontA(
    pDevice: ID3D10Device;
    Height: Integer;
    Width: Longint;
    Weight: LongWord;
    MipLevels: LongWord;
    Italic: BOOL;
    CharSet: DWORD;
    OutputPrecision: DWORD;
    Quality: DWORD;
    PitchAndFamily: DWORD;
    pFaceName: PAnsiChar;
    out ppFont: ID3DX10Font): HResult; stdcall; external d3dx10dll name 'D3DX10CreateFontA';
{$EXTERNALSYM D3DX10CreateFontA}

function D3DX10CreateFontW(
    pDevice: ID3D10Device;
    Height: Integer;
    Width: Longint;
    Weight: LongWord;
    MipLevels: LongWord;
    Italic: BOOL;
    CharSet: DWORD;
    OutputPrecision: DWORD;
    Quality: DWORD;
    PitchAndFamily: DWORD;
    pFaceName: PWideChar;
    out ppFont: ID3DX10Font): HResult; stdcall; external d3dx10dll name 'D3DX10CreateFontW';
{$EXTERNALSYM D3DX10CreateFontW}

function D3DX10CreateFont(
    pDevice: ID3D10Device;
    Height: Integer;
    Width: Longint;
    Weight: LongWord;
    MipLevels: LongWord;
    Italic: BOOL;
    CharSet: DWORD;
    OutputPrecision: DWORD;
    Quality: DWORD;
    PitchAndFamily: DWORD;
    pFaceName: PChar;
    out ppFont: ID3DX10Font): HResult; stdcall; external d3dx10dll name 'D3DX10CreateFontA';
{$EXTERNALSYM D3DX10CreateFont}


function D3DX10CreateFontIndirectA(
    pDevice: ID3D10Device;
    const pDesc: TD3DX10_FontDescA;
    out ppFont: ID3DX10Font): HResult; stdcall; external d3dx10dll name 'D3DX10CreateFontIndirectA';
{$EXTERNALSYM D3DX10CreateFontIndirectA}

function D3DX10CreateFontIndirectW(
    pDevice: ID3D10Device;
    const pDesc: TD3DX10_FontDescW;
    out ppFont: ID3DX10Font): HResult; stdcall; external d3dx10dll name 'D3DX10CreateFontIndirectW';
{$EXTERNALSYM D3DX10CreateFontIndirectW}

function D3DX10CreateFontIndirect(
    pDevice: ID3D10Device;
    const pDesc: TD3DX10_FontDesc;
    out ppFont: ID3DX10Font): HResult; stdcall; external d3dx10dll name 'D3DX10CreateFontIndirectA';
{$EXTERNALSYM D3DX10CreateFontIndirect}


function D3DX10UnsetAllDeviceObjects(const pDevice: ID3D10Device): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10UnsetAllDeviceObjects}

//todo: Remove these declarations (no more supported in current D3DX10 dlls?)
(*
//////////////////////////////////////////////////////////////////////////////
// D3DX10ReflectShader
// ----------
// Shader code contains metadata that can be inspected via the
// reflection APIs.
//
// Parameters:
//  ppReflector -
//    Returns a reflection API interface for the given shader code.
//
//////////////////////////////////////////////////////////////////////////////

function D3DX10ReflectShader(
    const pShaderBytecode: Pointer;
    BytecodeLength: SIZE_T;
    out ppReflector: ID3D10ShaderReflection): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10ReflectShader}

//----------------------------------------------------------------------------
// D3DX10DisassembleShader:
// ----------------------
// Takes a binary shader, and returns a buffer containing text assembly.
//
// Parameters:
//  pShader
//      Pointer to the shader byte code.
//  BytecodeLength
//      Size of the shader byte code in bytes.
//  EnableColorCode
//      Emit HTML tags for color coding the output?
//  pComments
//      Pointer to a comment string to include at the top of the shader.
//  ppDisassembly
//      Returns a buffer containing the disassembled shader.
//----------------------------------------------------------------------------

function D3DX10DisassembleShader(
    const pShader: Pointer;
    BytecodeLength: SIZE_T;
    EnableColorCode: BOOL;
    pComments: PAnsiChar;
    out ppDisassembly: ID3D10Blob): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10DisassembleShader}

//----------------------------------------------------------------------------
// D3DX10DisassembleEffect:
// -----------------------
// Takes an effect interface, and returns a buffer containing text assembly.
//
// Parameters:
//  pEffect
//      Pointer to the runtime effect interface.
//  EnableColorCode
//      Emit HTML tags for color coding the output?
//  ppDisassembly
//      Returns a buffer containing the disassembled effect.
//----------------------------------------------------------------------------

function D3DX10DisassembleEffect(
    const pEffect: ID3D10Effect;
    EnableColorCode: BOOL;
    out ppDisassembly: ID3D10Blob): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10DisassembleEffect}

///////////////////////////////////////////////////////////////////////////
*)

const
  _FACD3D = $876;

// #define MAKE_D3DHRESULT( code )  MAKE_HRESULT( 1, _FACD3D, code )
function MAKE_D3DHRESULT(Code: DWord): DWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM MAKE_D3DHRESULT}
// #define MAKE_D3DSTATUS( code )  MAKE_HRESULT( 0, _FACD3D, code )
function MAKE_D3DSTATUS(Code: DWord): DWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM MAKE_D3DSTATUS}

const
  MAKE_D3DHRESULT_R     = (1 shl 31) or (_FACD3D shl 16);

const
  D3DERR_INVALIDCALL                          = HResult(MAKE_D3DHRESULT_R or 2156);
  {$EXTERNALSYM D3DERR_INVALIDCALL}
  D3DERR_WASSTILLDRAWING                      = HResult(MAKE_D3DHRESULT_R or 540);
  {$EXTERNALSYM D3DERR_WASSTILLDRAWING}





//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx10tex.h
//  Content:    D3DX10 texturing APIs
//
//////////////////////////////////////////////////////////////////////////////


//----------------------------------------------------------------------------
// D3DX10_FILTER flags:
// ------------------
//
// A valid filter must contain one of these values:
//
//  D3DX10_FILTER_NONE
//      No scaling or filtering will take place.  Pixels outside the bounds
//      of the source image are assumed to be transparent black.
//  D3DX10_FILTER_POINT
//      Each destination pixel is computed by sampling the nearest pixel
//      from the source image.
//  D3DX10_FILTER_LINEAR
//      Each destination pixel is computed by linearly interpolating between
//      the nearest pixels in the source image.  This filter works best 
//      when the scale on each axis is less than 2.
//  D3DX10_FILTER_TRIANGLE
//      Every pixel in the source image contributes equally to the
//      destination image.  This is the slowest of all the filters.
//  D3DX10_FILTER_BOX
//      Each pixel is computed by averaging a 2x2(x2) box pixels from 
//      the source image. Only works when the dimensions of the 
//      destination are half those of the source. (as with mip maps)
//
// And can be OR'd with any of these optional flags:
//
//  D3DX10_FILTER_MIRROR_U
//      Indicates that pixels off the edge of the texture on the U-axis
//      should be mirrored, not wraped.
//  D3DX10_FILTER_MIRROR_V
//      Indicates that pixels off the edge of the texture on the V-axis
//      should be mirrored, not wraped.
//  D3DX10_FILTER_MIRROR_W
//      Indicates that pixels off the edge of the texture on the W-axis
//      should be mirrored, not wraped.
//  D3DX10_FILTER_MIRROR
//      Same as specifying D3DX10_FILTER_MIRROR_U | D3DX10_FILTER_MIRROR_V |
//      D3DX10_FILTER_MIRROR_V
//  D3DX10_FILTER_DITHER
//      Dithers the resulting image using a 4x4 order dither pattern.
//  D3DX10_FILTER_SRGB_IN
//      Denotes that the input data is in sRGB (gamma 2.2) colorspace.
//  D3DX10_FILTER_SRGB_OUT
//      Denotes that the output data is in sRGB (gamma 2.2) colorspace.
//  D3DX10_FILTER_SRGB
//      Same as specifying D3DX10_FILTER_SRGB_IN | D3DX10_FILTER_SRGB_OUT
//
//----------------------------------------------------------------------------

type
  D3DX10_FILTER_FLAG = Cardinal;
  {$EXTERNALSYM D3DX10_FILTER_FLAG}

const
  D3DX10_FILTER_NONE            = (1 shl 0);
  {$EXTERNALSYM D3DX10_FILTER_NONE}
  D3DX10_FILTER_POINT           = (2 shl 0);
  {$EXTERNALSYM D3DX10_FILTER_POINT}
  D3DX10_FILTER_LINEAR          = (3 shl 0);
  {$EXTERNALSYM D3DX10_FILTER_LINEAR}
  D3DX10_FILTER_TRIANGLE        = (4 shl 0);
  {$EXTERNALSYM D3DX10_FILTER_TRIANGLE}
  D3DX10_FILTER_BOX             = (5 shl 0);
  {$EXTERNALSYM D3DX10_FILTER_BOX}

  D3DX10_FILTER_MIRROR_U        = (1 shl 16);
  {$EXTERNALSYM D3DX10_FILTER_MIRROR_U}
  D3DX10_FILTER_MIRROR_V        = (2 shl 16);
  {$EXTERNALSYM D3DX10_FILTER_MIRROR_V}
  D3DX10_FILTER_MIRROR_W        = (4 shl 16);
  {$EXTERNALSYM D3DX10_FILTER_MIRROR_W}
  D3DX10_FILTER_MIRROR          = (7 shl 16);
  {$EXTERNALSYM D3DX10_FILTER_MIRROR}

  D3DX10_FILTER_DITHER          = (1 shl 19);
  {$EXTERNALSYM D3DX10_FILTER_DITHER}
  D3DX10_FILTER_DITHER_DIFFUSION= (2 shl 19);
  {$EXTERNALSYM D3DX10_FILTER_DITHER_DIFFUSION}

  D3DX10_FILTER_SRGB_IN         = (1 shl 21);
  {$EXTERNALSYM D3DX10_FILTER_SRGB_IN}
  D3DX10_FILTER_SRGB_OUT        = (2 shl 21);
  {$EXTERNALSYM D3DX10_FILTER_SRGB_OUT}
  D3DX10_FILTER_SRGB            = (3 shl 21);
  {$EXTERNALSYM D3DX10_FILTER_SRGB}


//----------------------------------------------------------------------------
// D3DX10_NORMALMAP flags:
// ---------------------
// These flags are used to control how D3DX10ComputeNormalMap generates normal
// maps.  Any number of these flags may be OR'd together in any combination.
//
//  D3DX10_NORMALMAP_MIRROR_U
//      Indicates that pixels off the edge of the texture on the U-axis
//      should be mirrored, not wraped.
//  D3DX10_NORMALMAP_MIRROR_V
//      Indicates that pixels off the edge of the texture on the V-axis
//      should be mirrored, not wraped.
//  D3DX10_NORMALMAP_MIRROR
//      Same as specifying D3DX10_NORMALMAP_MIRROR_U | D3DX10_NORMALMAP_MIRROR_V
//  D3DX10_NORMALMAP_INVERTSIGN
//      Inverts the direction of each normal
//  D3DX10_NORMALMAP_COMPUTE_OCCLUSION
//      Compute the per pixel Occlusion term and encodes it into the alpha.
//      An Alpha of 1 means that the pixel is not obscured in anyway, and
//      an alpha of 0 would mean that the pixel is completly obscured.
//
//----------------------------------------------------------------------------

type
  D3DX10_NORMALMAP_FLAG = Cardinal;
  {$EXTERNALSYM D3DX10_NORMALMAP_FLAG}

const
  D3DX10_NORMALMAP_MIRROR_U          = (1 shl 16);
  {$EXTERNALSYM D3DX10_NORMALMAP_MIRROR_U}
  D3DX10_NORMALMAP_MIRROR_V          = (2 shl 16);
  {$EXTERNALSYM D3DX10_NORMALMAP_MIRROR_V}
  D3DX10_NORMALMAP_MIRROR            = (3 shl 16);
  {$EXTERNALSYM D3DX10_NORMALMAP_MIRROR}
  D3DX10_NORMALMAP_INVERTSIGN        = (8 shl 16);
  {$EXTERNALSYM D3DX10_NORMALMAP_INVERTSIGN}
  D3DX10_NORMALMAP_COMPUTE_OCCLUSION = (16 shl 16);
  {$EXTERNALSYM D3DX10_NORMALMAP_COMPUTE_OCCLUSION}


//----------------------------------------------------------------------------
// D3DX10_CHANNEL flags:
// -------------------
// These flags are used by functions which operate on or more channels
// in a texture.
//
// D3DX10_CHANNEL_RED
//     Indicates the red channel should be used
// D3DX10_CHANNEL_BLUE
//     Indicates the blue channel should be used
// D3DX10_CHANNEL_GREEN
//     Indicates the green channel should be used
// D3DX10_CHANNEL_ALPHA
//     Indicates the alpha channel should be used
// D3DX10_CHANNEL_LUMINANCE
//     Indicates the luminaces of the red green and blue channels should be 
//     used.
//
//----------------------------------------------------------------------------

type
  D3DX10_CHANNEL_FLAG = Cardinal;
  {$EXTERNALSYM D3DX10_CHANNEL_FLAG}

const
  D3DX10_CHANNEL_RED           = (1 shl 0);
  {$EXTERNALSYM D3DX10_CHANNEL_RED}
  D3DX10_CHANNEL_BLUE          = (1 shl 1);
  {$EXTERNALSYM D3DX10_CHANNEL_BLUE}
  D3DX10_CHANNEL_GREEN         = (1 shl 2);
  {$EXTERNALSYM D3DX10_CHANNEL_GREEN}
  D3DX10_CHANNEL_ALPHA         = (1 shl 3);
  {$EXTERNALSYM D3DX10_CHANNEL_ALPHA}
  D3DX10_CHANNEL_LUMINANCE     = (1 shl 4);
  {$EXTERNALSYM D3DX10_CHANNEL_LUMINANCE}


//----------------------------------------------------------------------------
// D3DX10_IMAGE_FILE_FORMAT:
// ---------------------
// This enum is used to describe supported image file formats.
//
//----------------------------------------------------------------------------

type
  PD3DX10_ImageFileFormat = ^TD3DX10_ImageFileFormat;
  D3DX10_IMAGE_FILE_FORMAT =
   (
    D3DX10_IFF_BMP      = 0,
    D3DX10_IFF_JPG      = 1,
    D3DX10_IFF_PNG      = 3,
    D3DX10_IFF_DDS      = 4,
    D3DX10_IFF_TIFF		  = 10,
    D3DX10_IFF_GIF		  = 11,
    D3DX10_IFF_WMP		  = 12,
    D3DX10_IFF_FORCE_DWORD = $7fffffff
   );
  {$EXTERNALSYM D3DX10_IMAGE_FILE_FORMAT}
  TD3DX10_ImageFileFormat = D3DX10_IMAGE_FILE_FORMAT;


//----------------------------------------------------------------------------
// D3DX10_SAVE_TEXTURE_FLAG:
// ---------------------
// This enum is used to support texture saving options.
//
//----------------------------------------------------------------------------

type
  D3DX10_SAVE_TEXTURE_FLAG = Cardinal;
  {$EXTERNALSYM D3DX10_SAVE_TEXTURE_FLAG}

const
  D3DX10_STF_USEINPUTBLOB      = $0001;
  {$EXTERNALSYM D3DX10_STF_USEINPUTBLOB}


//----------------------------------------------------------------------------
// D3DX10_IMAGE_INFO:
// ---------------
// This structure is used to return a rough description of what the
// the original contents of an image file looked like.
// 
//  Width
//      Width of original image in pixels
//  Height
//      Height of original image in pixels
//  Depth
//      Depth of original image in pixels
//  ArraySize
//      Array size in textures
//  MipLevels
//      Number of mip levels in original image
//  MiscFlags
//      Miscellaneous flags
//  Format
//      D3D format which most closely describes the data in original image
//  ResourceDimension
//      D3D10_RESOURCE_DIMENSION representing the dimension of texture stored in the file.
//      D3D10_RESOURCE_DIMENSION_TEXTURE1D, 2D, 3D
//  ImageFileFormat
//      D3DX10_IMAGE_FILE_FORMAT representing the format of the image file.
//----------------------------------------------------------------------------

type
  PD3DX10_ImageInfo = ^TD3DX10_ImageInfo;
  D3DX10_IMAGE_INFO = record
    Width:             LongWord;
    Height:            LongWord;
    Depth:             LongWord;
    ArraySize:         LongWord;
    MipLevels:         LongWord;
    MiscFlags:         LongWord;
    Format:            TDXGI_Format;
    ResourceDimension: TD3D10_ResourceDimension;
    ImageFileFormat:   TD3DX10_ImageFileFormat;
  end;
  {$EXTERNALSYM D3DX10_IMAGE_INFO}
  TD3DX10_ImageInfo = D3DX10_IMAGE_INFO;


//////////////////////////////////////////////////////////////////////////////
// Image File APIs ///////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------
// D3DX10_IMAGE_LOAD_INFO:
// ---------------
// This structure can be optionally passed in to texture loader APIs to
// control how textures get loaded. Pass in D3DX10_DEFAULT for any of these
// to have D3DX automatically pick defaults based on the source file.
//
//  Width
//      Rescale texture to Width texels wide
//  Height
//      Rescale texture to Height texels high
//  Depth
//      Rescale texture to Depth texels deep
//  FirstMipLevel
//      First mip level to load
//  MipLevels
//      Number of mip levels to load after the first level
//  Usage
//      D3D10_USAGE flag for the new texture
//  BindFlags
//      D3D10 Bind flags for the new texture
//  CpuAccessFlags
//      D3D10 CPU Access flags for the new texture
//  MiscFlags
//      Reserved. Must be 0
//  Format
//      Resample texture to the specified format
//  Filter
//      Filter the texture using the specified filter (only when resampling)
//  MipFilter
//      Filter the texture mip levels using the specified filter (only if
//      generating mips)
//  pSrcInfo
//      (optional) pointer to a D3DX10_IMAGE_INFO structure that will get
//      populated with source image information
//----------------------------------------------------------------------------


type
  PD3DX10_ImageLoadInfo = ^TD3DX10_ImageLoadInfo;
  D3DX10_IMAGE_LOAD_INFO = record
    Width:             LongWord;
    Height:            LongWord;
    Depth:             LongWord;
    FirstMipLevel:     LongWord;
    MipLevels:         LongWord;
    Usage:             TD3D10_Usage;
    BindFlags:         LongWord;
    CpuAccessFlags:    LongWord;
    MiscFlags:         LongWord;
    Format:            TDXGI_Format;
    Filter:            LongWord;
    MipFilter:         LongWord;
    pSrcInfo:          PD3DX10_ImageInfo;
  end;
  {$EXTERNALSYM D3DX10_IMAGE_LOAD_INFO}
  TD3DX10_ImageLoadInfo = D3DX10_IMAGE_LOAD_INFO;

const
  D3DX10_IMAGE_LOAD_INFO_default : TD3DX10_ImageLoadInfo =
    (
        Width         : LongWord(D3DX10_DEFAULT);
        Height        : LongWord(D3DX10_DEFAULT);
        Depth         : LongWord(D3DX10_DEFAULT);
        FirstMipLevel : LongWord(D3DX10_DEFAULT);
        MipLevels     : LongWord(D3DX10_DEFAULT);
        Usage         : D3D10_USAGE(D3DX10_DEFAULT);
        BindFlags     : LongWord(D3DX10_DEFAULT);
        CpuAccessFlags: LongWord(D3DX10_DEFAULT);
        MiscFlags     : LongWord(D3DX10_DEFAULT);
        Format        : DXGI_FORMAT_FROM_FILE;
        Filter        : LongWord(D3DX10_DEFAULT);
        MipFilter     : LongWord(D3DX10_DEFAULT);
        pSrcInfo      : nil;
    );


//-------------------------------------------------------------------------------
// GetImageInfoFromFile/Resource/Memory:
// ------------------------------
// Fills in a D3DX10_IMAGE_INFO struct with information about an image file.
//
// Parameters:
//  pSrcFile
//      File name of the source image.
//  pSrcModule
//      Module where resource is located, or NULL for module associated
//      with image the os used to create the current process.
//  pSrcResource
//      Resource name.
//  pSrcData
//      Pointer to file in memory.
//  SrcDataSize
//      Size in bytes of file in memory.
//  pPump
//      Optional pointer to a thread pump object to use.
//  pSrcInfo
//      Pointer to a D3DX10_IMAGE_INFO structure to be filled in with the 
//      description of the data in the source image file.
//  pHResult
//      Pointer to a memory location to receive the return value upon completion.
//      Maybe NULL if not needed.
//      If pPump != NULL, pHResult must be a valid memory location until the
//      the asynchronous execution completes.
//-------------------------------------------------------------------------------

function D3DX10GetImageInfoFromFileA(
    pSrcFile: PAnsiChar;
    pPump: ID3DX10ThreadPump;
    pSrcInfo: PD3DX10_ImageInfo;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10GetImageInfoFromFileA';
{$EXTERNALSYM D3DX10GetImageInfoFromFileA}

function D3DX10GetImageInfoFromFileW(
    pSrcFile: PWideChar;
    pPump: ID3DX10ThreadPump;
    pSrcInfo: PD3DX10_ImageInfo;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10GetImageInfoFromFileW';
{$EXTERNALSYM D3DX10GetImageInfoFromFileW}

function D3DX10GetImageInfoFromFile(
    pSrcFile: PChar;
    pPump: ID3DX10ThreadPump;
    pSrcInfo: PD3DX10_ImageInfo;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10GetImageInfoFromFileA';
{$EXTERNALSYM D3DX10GetImageInfoFromFile}


function D3DX10GetImageInfoFromResourceA(
    hSrcModule: HMODULE;
    pSrcResource: PAnsiChar;
    pPump: ID3DX10ThreadPump;
    pSrcInfo: TD3DX10_ImageInfo;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10GetImageInfoFromResourceA';
{$EXTERNALSYM D3DX10GetImageInfoFromResourceA}

function D3DX10GetImageInfoFromResourceW(
    hSrcModule: HMODULE;
    pSrcResource: PWideChar;
    pPump: ID3DX10ThreadPump;
    pSrcInfo: TD3DX10_ImageInfo;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10GetImageInfoFromResourceW';
{$EXTERNALSYM D3DX10GetImageInfoFromResourceW}

function D3DX10GetImageInfoFromResource(
    hSrcModule: HMODULE;
    pSrcResource: PChar;
    pPump: ID3DX10ThreadPump;
    pSrcInfo: TD3DX10_ImageInfo;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10GetImageInfoFromResourceA';
{$EXTERNALSYM D3DX10GetImageInfoFromResource}


function D3DX10GetImageInfoFromMemory(
    pSrcData: Pointer;
    SrcDataSize: SIZE_T;
    pPump: ID3DX10ThreadPump;
    pSrcInfo: TD3DX10_ImageInfo;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10GetImageInfoFromMemory}


//////////////////////////////////////////////////////////////////////////////
// Create/Save Texture APIs //////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------
// D3DX10CreateTextureFromFile/Resource/Memory:
// D3DX10CreateShaderResourceViewFromFile/Resource/Memory:
// -----------------------------------
// Create a texture object from a file or resource.
//
// Parameters:
//
//  pDevice
//      The D3D device with which the texture is going to be used.
//  pSrcFile
//      File name.
//  hSrcModule
//      Module handle. if NULL, current module will be used.
//  pSrcResource
//      Resource name in module
//  pvSrcData
//      Pointer to file in memory.
//  SrcDataSize
//      Size in bytes of file in memory.
//  pLoadInfo
//      Optional pointer to a D3DX10_IMAGE_LOAD_INFO structure that
//      contains additional loader parameters.
//  pPump
//      Optional pointer to a thread pump object to use.
//  ppTexture
//      [out] Created texture object.
//  ppShaderResourceView
//      [out] Shader resource view object created.
//  pHResult
//      Pointer to a memory location to receive the return value upon completion.
//      Maybe NULL if not needed.
//      If pPump != NULL, pHResult must be a valid memory location until the
//      the asynchronous execution completes.
//
//----------------------------------------------------------------------------


// FromFile

function D3DX10CreateShaderResourceViewFromFileA(
    const pDevice: ID3D10Device;
    pSrcFile: PAnsiChar;
    pLoadInfo: PD3DX10_ImageLoadInfo;
    pPump: ID3DX10ThreadPump;
    out ppShaderResourceView: ID3D10ShaderResourceView;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateShaderResourceViewFromFileA';
{$EXTERNALSYM D3DX10CreateShaderResourceViewFromFileA}

function D3DX10CreateShaderResourceViewFromFileW(
    const pDevice: ID3D10Device;
    pSrcFile: PWideChar;
    pLoadInfo: PD3DX10_ImageLoadInfo;
    pPump: ID3DX10ThreadPump;
    out ppShaderResourceView: ID3D10ShaderResourceView;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateShaderResourceViewFromFileW';
{$EXTERNALSYM D3DX10CreateShaderResourceViewFromFileW}

function D3DX10CreateShaderResourceViewFromFile(
    const pDevice: ID3D10Device;
    pSrcFile: PChar;
    pLoadInfo: PD3DX10_ImageLoadInfo;
    pPump: ID3DX10ThreadPump;
    out ppShaderResourceView: ID3D10ShaderResourceView;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateShaderResourceViewFromFileA';
{$EXTERNALSYM D3DX10CreateShaderResourceViewFromFile}


function D3DX10CreateTextureFromFileA(
    const pDevice: ID3D10Device;
    pSrcFile: PAnsiChar;
    pLoadInfo: PD3DX10_ImageLoadInfo;
    pPump: ID3DX10ThreadPump;
    out ppTexture: ID3D10Resource;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateTextureFromFileA';
{$EXTERNALSYM D3DX10CreateTextureFromFileA}

function D3DX10CreateTextureFromFileW(
    const pDevice: ID3D10Device;
    pSrcFile: PWideChar;
    pLoadInfo: PD3DX10_ImageLoadInfo;
    pPump: ID3DX10ThreadPump;
    out ppTexture: ID3D10Resource;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateTextureFromFileW';
{$EXTERNALSYM D3DX10CreateTextureFromFileW}

function D3DX10CreateTextureFromFile(
    const pDevice: ID3D10Device;
    pSrcFile: PChar;
    pLoadInfo: PD3DX10_ImageLoadInfo;
    pPump: ID3DX10ThreadPump;
    out ppTexture: ID3D10Resource;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateTextureFromFileA';
{$EXTERNALSYM D3DX10CreateTextureFromFile}


// FromResource (resources in dll/exes)

function D3DX10CreateShaderResourceViewFromResourceA(
    const pDevice: ID3D10Device;
    hSrcModule: HMODULE;
    pSrcResource: PAnsiChar;
    pLoadInfo: PD3DX10_ImageLoadInfo;
    pPump: ID3DX10ThreadPump;
    out ppShaderResourceView: ID3D10ShaderResourceView;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateShaderResourceViewFromResourceA';
{$EXTERNALSYM D3DX10CreateShaderResourceViewFromResourceA}

function D3DX10CreateShaderResourceViewFromResourceW(
    const pDevice: ID3D10Device;
    hSrcModule: HMODULE;
    pSrcResource: PWideChar;
    pLoadInfo: PD3DX10_ImageLoadInfo;
    pPump: ID3DX10ThreadPump;
    out ppShaderResourceView: ID3D10ShaderResourceView;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateShaderResourceViewFromResourceW';
{$EXTERNALSYM D3DX10CreateShaderResourceViewFromResourceW}

function D3DX10CreateShaderResourceViewFromResource(
    const pDevice: ID3D10Device;
    hSrcModule: HMODULE;
    pSrcResource: PChar;
    pLoadInfo: PD3DX10_ImageLoadInfo;
    pPump: ID3DX10ThreadPump;
    out ppShaderResourceView: ID3D10ShaderResourceView;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateShaderResourceViewFromResourceA';
{$EXTERNALSYM D3DX10CreateShaderResourceViewFromResource}


function D3DX10CreateTextureFromResourceA(
    const pDevice: ID3D10Device;
    hSrcModule: HMODULE;
    pSrcResource: PAnsiChar;
    pLoadInfo: PD3DX10_ImageLoadInfo;
    pPump: ID3DX10ThreadPump;
    out ppTexture: ID3D10Resource;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateTextureFromResourceA';
{$EXTERNALSYM D3DX10CreateTextureFromResourceA}

function D3DX10CreateTextureFromResourceW(
    const pDevice: ID3D10Device;
    hSrcModule: HMODULE;
    pSrcResource: PWideChar;
    pLoadInfo: PD3DX10_ImageLoadInfo;
    pPump: ID3DX10ThreadPump;
    out ppTexture: ID3D10Resource;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateTextureFromResourceW';
{$EXTERNALSYM D3DX10CreateTextureFromResourceW}

function D3DX10CreateTextureFromResource(
    const pDevice: ID3D10Device;
    hSrcModule: HMODULE;
    pSrcResource: PChar;
    pLoadInfo: PD3DX10_ImageLoadInfo;
    pPump: ID3DX10ThreadPump;
    out ppTexture: ID3D10Resource;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateTextureFromResourceA';
{$EXTERNALSYM D3DX10CreateTextureFromResource}


// FromFileInMemory

function D3DX10CreateShaderResourceViewFromMemory(
    const pDevice: ID3D10Device;
    pSrcData: Pointer;
    SrcDataSize: SIZE_T;
    pLoadInfo: PD3DX10_ImageLoadInfo;
    pPump: ID3DX10ThreadPump;
    out ppShaderResourceView: ID3D10ShaderResourceView;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CreateShaderResourceViewFromMemory}

function D3DX10CreateTextureFromMemory(
    const pDevice: ID3D10Device;
    pSrcData: Pointer;
    SrcDataSize: SIZE_T;
    pLoadInfo: PD3DX10_ImageLoadInfo;
    pPump: ID3DX10ThreadPump;
    out ppTexture: ID3D10Resource;
    pHResult: PHResult): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CreateTextureFromMemory}


//////////////////////////////////////////////////////////////////////////////
// Misc Texture APIs /////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------
// D3DX10_TEXTURE_LOAD_INFO:
// ------------------------
//
//----------------------------------------------------------------------------

type
  PD3DX10_TextureLoadInfo = ^TD3DX10_TextureLoadInfo;
  _D3DX10_TEXTURE_LOAD_INFO = record
    pSrcBox:          PD3D10_Box;
    pDstBox:          PD3D10_Box;
    SrcFirstMip:      LongWord;
    DstFirstMip:      LongWord;
    NumMips:          LongWord;
    SrcFirstElement:  LongWord;
    DstFirstElement:  LongWord;
    NumElements:      LongWord;
    Filter:           LongWord;
    MipFilter:        LongWord;
  end;
  {$EXTERNALSYM _D3DX10_TEXTURE_LOAD_INFO}
  D3DX10_TEXTURE_LOAD_INFO = _D3DX10_TEXTURE_LOAD_INFO;
  {$EXTERNALSYM D3DX10_TEXTURE_LOAD_INFO}
  TD3DX10_TextureLoadInfo = _D3DX10_TEXTURE_LOAD_INFO;

const
  D3DX10_TEXTURE_LOAD_INFO_default : TD3DX10_TextureLoadInfo =
    (
        pSrcBox         : nil;
        pDstBox         : nil;
        SrcFirstMip     : 0;
        DstFirstMip     : 0;
        NumMips         : Longword(D3DX10_DEFAULT);
        SrcFirstElement : 0;
        DstFirstElement : 0;
        NumElements     : Longword(D3DX10_DEFAULT);
        Filter          : Longword(D3DX10_DEFAULT);
        MipFilter       : Longword(D3DX10_DEFAULT);
    );


//----------------------------------------------------------------------------
// D3DX10LoadTextureFromTexture:
// ----------------------------
// Load a texture from a texture.
//
// Parameters:
//
//----------------------------------------------------------------------------

function D3DX10LoadTextureFromTexture(
    pSrcTexture: ID3D10Resource;
    pLoadInfo: PD3DX10_TextureLoadInfo;
    pDstTexture: ID3D10Resource): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10LoadTextureFromTexture}


//----------------------------------------------------------------------------
// D3DX10FilterTexture:
// ------------------
// Filters mipmaps levels of a texture.
//
// Parameters:
//  pBaseTexture
//      The texture object to be filtered
//  SrcLevel
//      The level whose image is used to generate the subsequent levels.
//  MipFilter
//      D3DX10_FILTER flags controlling how each miplevel is filtered.
//      Or D3DX10_DEFAULT for D3DX10_FILTER_BOX,
//
//----------------------------------------------------------------------------

function D3DX10FilterTexture(
    pTexture: ID3D10Resource;
    SrcLevel: LongWord;
    MipFilter: LongWord): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10FilterTexture}


//----------------------------------------------------------------------------
// D3DX10SaveTextureToFile:
// ----------------------
// Save a texture to a file.
//
// Parameters:
//  pDestFile
//      File name of the destination file
//  DestFormat
//      D3DX10_IMAGE_FILE_FORMAT specifying file format to use when saving.
//  pSrcTexture
//      Source texture, containing the image to be saved
//
//----------------------------------------------------------------------------

function D3DX10SaveTextureToFileA(
    pSrcTexture: ID3D10Resource;
    DestFormat: TD3DX10_ImageFileFormat;
    pDestFile: PAnsiChar): HResult; stdcall; external d3dx10dll name 'D3DX10SaveTextureToFileA';
{$EXTERNALSYM D3DX10SaveTextureToFileA}

function D3DX10SaveTextureToFileW(
    pSrcTexture: ID3D10Resource;
    DestFormat: TD3DX10_ImageFileFormat;
    pDestFile: PWideChar): HResult; stdcall; external d3dx10dll name 'D3DX10SaveTextureToFileW';
{$EXTERNALSYM D3DX10SaveTextureToFileW}

function D3DX10SaveTextureToFile(
    pSrcTexture: ID3D10Resource;
    DestFormat: TD3DX10_ImageFileFormat;
    pDestFile: PChar): HResult; stdcall; external d3dx10dll name 'D3DX10SaveTextureToFileA';
{$EXTERNALSYM D3DX10SaveTextureToFile}


//----------------------------------------------------------------------------
// D3DX10SaveTextureToMemory:
// ----------------------
// Save a texture to a blob.
//
// Parameters:
//  pSrcTexture
//      Source texture, containing the image to be saved
//  DestFormat
//      D3DX10_IMAGE_FILE_FORMAT specifying file format to use when saving.
//  ppDestBuf
//      address of a d3dxbuffer pointer to return the image data
//  Flags
//      optional flags
//----------------------------------------------------------------------------

function D3DX10SaveTextureToMemory(
    pSrcTexture: ID3D10Resource;
    DestFormat: TD3DX10_ImageFileFormat;
    out ppDestBuf: ID3D10Blob;
    Flags: LongWord): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10SaveTextureToMemory}


//----------------------------------------------------------------------------
// D3DX10ComputeNormalMap:
// ---------------------
// Converts a height map into a normal map.  The (x,y,z) components of each
// normal are mapped to the (r,g,b) channels of the output texture.
//
// Parameters
//  pSrcTexture
//      Pointer to the source heightmap texture
//  Flags
//      D3DX10_NORMALMAP flags
//  Channel
//      D3DX10_CHANNEL specifying source of height information
//  Amplitude
//      The constant value which the height information is multiplied by.
//  pDestTexture
//      Pointer to the destination texture
//---------------------------------------------------------------------------

function D3DX10ComputeNormalMap(
    pSrcTexture: ID3D10Texture2D;
    Flags: LongWord;
    Channel: LongWord;
    Amplitude: Single;
    pDestTexture:	ID3D10Texture2D): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10ComputeNormalMap}


//----------------------------------------------------------------------------
// D3DX10SHProjectCubeMap:
// ----------------------
//  Projects a function represented in a cube map into spherical harmonics.
//
//  Parameters:
//   Order
//      Order of the SH evaluation, generates Order^2 coefs, degree is Order-1
//   pCubeMap
//      CubeMap that is going to be projected into spherical harmonics
//   pROut
//      Output SH vector for Red.
//   pGOut
//      Output SH vector for Green
//   pBOut
//      Output SH vector for Blue
//
//---------------------------------------------------------------------------

function D3DX10SHProjectCubeMap(
    Order: LongWord;
    pCubeMap: ID3D10Texture2D;
    pROut: PSingle;
    pGOut: PSingle;
    pBOut: PSingle): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10SHProjectCubeMap}





//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx10mesh.h
//  Content:    D3DX10 mesh types and functions
//
//////////////////////////////////////////////////////////////////////////////

const
  // {7ED943DD-52E8-40b5-A8D8-76685C406330}
  IID_ID3DX10BaseMesh: TGUID = '{7ed943dd-52e8-40b5-a8d8-76685c406330}';
  {$EXTERNALSYM IID_ID3DX10BaseMesh}

  // {8875769A-D579-4088-AAEB-534D1AD84E96}
  IID_ID3DX10PMesh: TGUID = '{8875769a-d579-4088-aaeb-534d1ad84e96}';
  {$EXTERNALSYM IID_ID3DX10PMesh}

  // {667EA4C7-F1CD-4386-B523-7C0290B83CC5}
  IID_ID3DX10SPMesh: TGUID = '{667ea4c7-f1cd-4386-b523-7c0290b83cc5}';
  {$EXTERNALSYM IID_ID3DX10SPMesh}

  // {3CE6CC22-DBF2-44f4-894D-F9C34A337139}
  IID_ID3DX10PatchMesh: TGUID = '{3ce6cc22-dbf2-44f4-894d-f9c34a337139}';
  {$EXTERNALSYM IID_ID3DX10PatchMesh}


// Mesh options - lower 3 bytes only, upper byte used by _D3DX10MESHOPT option flags
const
  D3DX10_MESH_32_BIT         = $001; // If set, then use 32 bit indices, if not set use 16 bit indices.
  {$EXTERNALSYM D3DX10_MESH_32_BIT}
  D3DX10_MESH_GS_ADJACENCY   = $004; // If set, mesh contains GS adjacency info. Not valid on input.
  {$EXTERNALSYM D3DX10_MESH_GS_ADJACENCY}
type
  _D3DX10_MESH = Cardinal;
  {$EXTERNALSYM _D3DX10_MESH}


type
  PD3DX10_AttributeRange = ^TD3DX10_AttributeRange;
  _D3DX10_ATTRIBUTE_RANGE = record
    AttribId: LongWord;
    FaceStart: LongWord;
    FaceCount: LongWord;
    VertexStart: LongWord;
    VertexCount: LongWord;
  end;
  {$EXTERNALSYM _D3DX10_ATTRIBUTE_RANGE}
  D3DX10_ATTRIBUTE_RANGE = _D3DX10_ATTRIBUTE_RANGE;
  {$EXTERNALSYM D3DX10_ATTRIBUTE_RANGE}
  TD3DX10_AttributeRange = _D3DX10_ATTRIBUTE_RANGE;

type
  _D3DX10_MESH_DISCARD_FLAGS = Cardinal;
  {$EXTERNALSYM _D3DX10_MESH_DISCARD_FLAGS}
  D3DX10_MESH_DISCARD_FLAGS = _D3DX10_MESH_DISCARD_FLAGS;
  {$EXTERNALSYM D3DX10_MESH_DISCARD_FLAGS}
  TD3DX10_MeshDiscardFlags = D3DX10_MESH_DISCARD_FLAGS;

const
  D3DX10_MESH_DISCARD_ATTRIBUTE_BUFFER = $01;
  {$EXTERNALSYM D3DX10_MESH_DISCARD_ATTRIBUTE_BUFFER}
  D3DX10_MESH_DISCARD_ATTRIBUTE_TABLE  = $02;
  {$EXTERNALSYM D3DX10_MESH_DISCARD_ATTRIBUTE_TABLE}
  D3DX10_MESH_DISCARD_POINTREPS        = $04;
  {$EXTERNALSYM D3DX10_MESH_DISCARD_POINTREPS}
  D3DX10_MESH_DISCARD_ADJACENCY        = $08;
  {$EXTERNALSYM D3DX10_MESH_DISCARD_ADJACENCY}
  D3DX10_MESH_DISCARD_DEVICE_BUFFERS   = $10;
  {$EXTERNALSYM D3DX10_MESH_DISCARD_DEVICE_BUFFERS}

type
  PD3DX10_WeldEpsilons = ^TD3DX10_WeldEpsilons;
  _D3DX10_WELD_EPSILONS = record
    Position: Single;                 // NOTE: This does NOT replace the epsilon in GenerateAdjacency
                                      // in general, it should be the same value or greater than the one passed to GeneratedAdjacency
    BlendWeights: Single;
    Normal: Single;
    PSize: Single;
    Specular: Single;
    Diffuse: Single;
    Texcoord: array[0..7] of Single;
    Tangent: Single;
    Binormal: Single;
    TessFactor: Single;
  end;
  {$EXTERNALSYM _D3DX10_WELD_EPSILONS}
  D3DX10_WELD_EPSILONS = _D3DX10_WELD_EPSILONS;
  {$EXTERNALSYM D3DX10_WELD_EPSILONS}
  TD3DX10_WeldEpsilons = _D3DX10_WELD_EPSILONS;

  PD3DX10_IntersectInfo = ^TD3DX10_IntersectInfo;
  _D3DX10_INTERSECT_INFO = record
    FaceIndex:  LongWord;                // index of face intersected
    U: Single;                        // Barycentric Hit Coordinates
    V: Single;                        // Barycentric Hit Coordinates
    Dist: Single;                     // Ray-Intersection Parameter Distance
  end;
  {$EXTERNALSYM _D3DX10_INTERSECT_INFO}
  D3DX10_INTERSECT_INFO = _D3DX10_INTERSECT_INFO;
  {$EXTERNALSYM D3DX10_INTERSECT_INFO}
  TD3DX10_IntersectInfo = _D3DX10_INTERSECT_INFO;


  // ID3DX10MeshBuffer is used by D3DX10Mesh vertex and index buffers
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DX10MeshBuffer);'}
  {$EXTERNALSYM ID3DX10MeshBuffer}
  ID3DX10MeshBuffer = interface(IUnknown)
    ['{04B0D117-1041-46b1-AA8A-3952848BA22E}']
    // ID3DX10MeshBuffer
    function Map(ppData: PPointer; pSize: PSIZE_T): HResult; stdcall;
    function Unmap(): HResult; stdcall;
    function GetSize(): SIZE_T; stdcall;
  end;

  IID_ID3DX10MeshBuffer = ID3DX10MeshBuffer;
  {$EXTERNALSYM IID_ID3DX10MeshBuffer}


  // D3DX10 Mesh interfaces
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DX10Mesh);'}
  {$EXTERNALSYM ID3DX10Mesh}
  ID3DX10Mesh = interface(IUnknown)
    ['{4020E5C2-1403-4929-883F-E2E849FAC195}']
    // ID3DX10Mesh
    function GetFaceCount(): LongWord; stdcall;
    function GetVertexCount(): LongWord; stdcall;
    function GetVertexBufferCount(): LongWord; stdcall;
    function GetFlags(): LongWord; stdcall;
    function GetVertexDescription(var ppDesc: PD3D10_InputElementDesc; pDeclCount: PLongWord): HResult; stdcall; //todo: Check parameters

    function SetVertexData(iBuffer: LongWord; const pData: Pointer): HResult; stdcall;
    function GetVertexBuffer(iBuffer: LongWord; out ppVertexBuffer: ID3DX10MeshBuffer): HResult; stdcall;

    function SetIndexData(const pData: Pointer; cIndices: LongWord): HResult; stdcall;
    function GetIndexBuffer(out ppIndexBuffer: ID3DX10MeshBuffer): HResult; stdcall;

    function SetAttributeData(const pData: PLongWord): HResult; stdcall;
    function GetAttributeBuffer(out ppAttributeBuffer: ID3DX10MeshBuffer): HResult; stdcall;

    function SetAttributeTable(pAttribTable: PD3DX10_AttributeRange; cAttribTableSize: LongWord): HResult; stdcall;
    function GetAttributeTable(pAttribTable: PD3DX10_AttributeRange; var pAttribTableSize: LongWord): HResult; stdcall;

    function GenerateAdjacencyAndPointReps(Epsilon: Single): HResult; stdcall;
    function GenerateGSAdjacency(): HResult; stdcall;

    function SetAdjacencyData(const pAdjacency: PLongWord): HResult; stdcall;
    function GetAdjacencyBuffer(out ppAdjacency: ID3DX10MeshBuffer): HResult; stdcall;

    function SetPointRepData(const pPointReps: PLongWord): HResult; stdcall;
    function GetPointRepBuffer(out ppPointReps: ID3DX10MeshBuffer): HResult; stdcall;

    function Discard(dwDiscard: TD3DX10_MeshDiscardFlags): HResult; stdcall;
    function CloneMesh(Flags: LongWord; pPosSemantic: PAnsiChar; const pDesc: PD3D10_InputElementDesc; DeclCount: LongWord; out ppCloneMesh: ID3DX10Mesh): HResult; stdcall;

    function Optimize(Flags: LongWord; pFaceRemap: PLongWord; ppVertexRemap: ID3D10Blob): HResult; stdcall;
    function GenerateAttributeBufferFromTable(): HResult; stdcall;

    //todo: Intersect() / IntersectSubset() - doesn't have PURE in original C header
    function Intersect(const pRayPos, pRayDir: TD3DXVector3; out pHitCount: LongWord; pFaceIndex: PLongWord; pU, pV, pDist: PSingle; out ppAllHits: ID3D10Blob): HResult; stdcall;
    function IntersectSubset(AttribId: LongWord; pRayPos, pRayDir: PD3DXVector3; out pHitCount: LongWord; pFaceIndex: PLongWord; pU, pV, pDist: PSingle; out ppAllHits: ID3D10Blob): HResult; stdcall;

    // ID3DX10Mesh - Device functions
    function CommitToDevice(): HResult; stdcall;
    function DrawSubset(AttribId: LongWord): HResult; stdcall;
    function DrawSubsetInstanced(AttribId: LongWord; InstanceCount: LongWord; StartInstanceLocation: LongWord): HResult; stdcall;

    function GetDeviceVertexBuffer(iBuffer: LongWord; out ppVertexBuffer: ID3D10Buffer): HResult; stdcall;
    function GetDeviceIndexBuffer(out ppIndexBuffer: ID3D10Buffer): HResult; stdcall;
  end;

  IID_ID3DX10Mesh = ID3DX10Mesh;
  {$EXTERNALSYM IID_ID3DX10Mesh}

// Flat API

function D3DX10CreateMesh(
  pDevice: ID3D10Device;
  const pDeclaration: PD3D10_InputElementDesc;
  DeclCount:  UINT;
  pPositionSemantic: PAnsiChar;
  VertexCount:  UINT;
  FaceCount:  UINT;
  Options:  UINT;
  out pMeshq: ID3DX10Mesh): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CreateMesh}


// ID3DX10Mesh::Optimize options - upper byte only, lower 3 bytes used from _D3DX10MESH option flags
type
  _D3DX10_MESHOPT = DWORD;
  {$EXTERNALSYM _D3DX10_MESHOPT}
  D3DX10_MESHOPT = _D3DX10_MESHOPT;
  {$EXTERNALSYM D3DX10_MESHOPT}
  TD3DX10_MeshOpt = _D3DX10_MESHOPT;

const
  D3DX10_MESHOPT_COMPACT       = $01000000;
  {$EXTERNALSYM D3DX10_MESHOPT_COMPACT}
  D3DX10_MESHOPT_ATTR_SORT     = $02000000;
  {$EXTERNALSYM D3DX10_MESHOPT_ATTR_SORT}
  D3DX10_MESHOPT_VERTEX_CACHE  = $04000000;
  {$EXTERNALSYM D3DX10_MESHOPT_VERTEX_CACHE}
  D3DX10_MESHOPT_STRIP_REORDER = $08000000;
  {$EXTERNALSYM D3DX10_MESHOPT_STRIP_REORDER}
  D3DX10_MESHOPT_IGNORE_VERTS  = $10000000;  // optimize faces only, don't touch vertices
  {$EXTERNALSYM D3DX10_MESHOPT_IGNORE_VERTS}
  D3DX10_MESHOPT_DO_NOT_SPLIT  = $20000000;  // do not split vertices shared between attribute groups when attribute sorting
  {$EXTERNALSYM D3DX10_MESHOPT_DO_NOT_SPLIT}
  D3DX10_MESHOPT_DEVICE_INDEPENDENT = $00400000;  // Only affects VCache.  uses a static known good cache size for all cards
  {$EXTERNALSYM D3DX10_MESHOPT_DEVICE_INDEPENDENT}
  // D3DX10_MESHOPT_SHAREVB has been removed, please use D3DX10MESH_VB_SHARE instead


//////////////////////////////////////////////////////////////////////////
// ID3DXSkinInfo
//////////////////////////////////////////////////////////////////////////

const
  // scaling modes for ID3DX10SkinInfo::Compact() & ID3DX10SkinInfo::UpdateMesh()
  D3DX10_SKININFO_NO_SCALING = 0;
  {$EXTERNALSYM D3DX10_SKININFO_NO_SCALING}
  D3DX10_SKININFO_SCALE_TO_1 = 1;
  {$EXTERNALSYM D3DX10_SKININFO_SCALE_TO_1}
  D3DX10_SKININFO_SCALE_TO_TOTAL = 2;
  {$EXTERNALSYM D3DX10_SKININFO_SCALE_TO_TOTAL}

type
  PD3DX10_SkinningChannel = ^TD3DX10_SkinningChannel;
  _D3DX10_SKINNING_CHANNEL = record
    SrcOffset: LongWord;
    DestOffset: LongWord;
    IsNormal: BOOL;
  end;
  {$EXTERNALSYM _D3DX10_SKINNING_CHANNEL}
  D3DX10_SKINNING_CHANNEL = _D3DX10_SKINNING_CHANNEL;
  {$EXTERNALSYM D3DX10_SKINNING_CHANNEL}
  TD3DX10_SkinningChannel = D3DX10_SKINNING_CHANNEL;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3DX10SkinInfo);'}
  {$EXTERNALSYM ID3DX10SkinInfo}
  ID3DX10SkinInfo = interface(IUnknown)
    ['{420BD604-1C76-4a34-A466-E45D0658A32C}']
    function GetNumVertices(): LongWord; stdcall;
    function GetNumBones(): LongWord; stdcall;
    function GetMaxBoneInfluences(): LongWord; stdcall;

    function AddVertices(Count: LongWord): HResult; stdcall;
    function RemapVertices(NewVertexCount: LongWord; pVertexRemap: PLongWord): HResult; stdcall;

    function AddBones(Count: LongWord): HResult; stdcall;
    function RemoveBone(Index: LongWord): HResult; stdcall;
    function RemapBones(NewBoneCount: LongWord; pBoneRemap: PLongWord): HResult; stdcall;

    function AddBoneInfluences(BoneIndex, InfluenceCount: LongWord; pIndices: PLongWord; pWeights: PSingle): HResult; stdcall;
    function ClearBoneInfluences(BoneIndex: LongWord): HResult; stdcall;
    function GetBoneInfluenceCount(BoneIndex: LongWord): LongWord; stdcall;
    function GetBoneInfluences(BoneIndex: LongWord; Offset: LongWord; Count: LongWord; pDestIndices: PLongWord; pDestWeights: PSingle): HResult; stdcall;
    function FindBoneInfluenceIndex(BoneIndex: LongWord; VertexIndex: LongWord; pInfluenceIndex: PLongWord): HResult; stdcall;
    function SetBoneInfluence(BoneIndex: LongWord; InfluenceIndex: LongWord; Weight: Single): HResult; stdcall;
    function GetBoneInfluence(BoneIndex: LongWord; InfluenceIndex: LongWord; pWeight: PSingle): HResult; stdcall;

    function Compact(MaxPerVertexInfluences: LongWord; ScaleMode: LongWord; MinWeight: Single): HResult; stdcall;
    function DoSoftwareSkinning(StartVertex, VertexCount: LongWord;
        pSrcVertices: Pointer; SrcStride: LongWord;
        pDestVertices: Pointer; DestStride: LongWord;
        pBoneMatrices, pInverseTransposeBoneMatrices: PD3DXMatrix;
        pChannelDescs: PD3DX10_SkinningChannel; NumChannels: LongWord): HResult; stdcall;
  end;

type
  IID_ID3DX10SkinInfo = ID3DX10SkinInfo;
  {$EXTERNALSYM IID_ID3DX10SkinInfo}


function D3DX10CreateSkinInfo(out ppSkinInfo: ID3DX10SkinInfo): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CreateSkinInfo}


type
  PD3DX10_AttributeWeights = ^TD3DX10_AttributeWeights;
  _D3DX10_ATTRIBUTE_WEIGHTS = record
    Position: Single;
    Boundary: Single;
    Normal: Single;
    Diffuse: Single;
    Specular: Single;
    Texcoord: array[0..7] of Single;
    Tangent: Single;
    Binormal: Single;
  end;
  {$EXTERNALSYM _D3DX10_ATTRIBUTE_WEIGHTS}
  D3DX10_ATTRIBUTE_WEIGHTS = _D3DX10_ATTRIBUTE_WEIGHTS;
  {$EXTERNALSYM D3DX10_ATTRIBUTE_WEIGHTS}
  TD3DX10_AttributeWeights = _D3DX10_ATTRIBUTE_WEIGHTS;



//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//
//  File:       D3DX10Async.h
//  Content:    D3DX10 Asynchronous Effect / Shader loaders / compilers
//
//////////////////////////////////////////////////////////////////////////////


//----------------------------------------------------------------------------
// D3DX10Compile:
// ------------------
// Compiles an effect or shader.
//
// Parameters:
//  pSrcFile
//      Source file name.
//  hSrcModule
//      Module handle. if NULL, current module will be used.
//  pSrcResource
//      Resource name in module.
//  pSrcData
//      Pointer to source code.
//  SrcDataLen
//      Size of source code, in bytes.
//  pDefines
//      Optional NULL-terminated array of preprocessor macro definitions.
//  pInclude
//      Optional interface pointer to use for handling #include directives.
//      If this parameter is NULL, #includes will be honored when compiling
//      from file, and will error when compiling from resource or memory.
//  pFunctionName
//      Name of the entrypoint function where execution should begin.
//  pProfile
//      Instruction set to be used when generating code.  Currently supported
//      profiles are "vs_1_1",  "vs_2_0", "vs_2_a", "vs_2_sw", "vs_3_0",
//                   "vs_3_sw", "vs_4_0", "vs_4_1",
//                   "ps_2_0",  "ps_2_a", "ps_2_b", "ps_2_sw", "ps_3_0", 
//                   "ps_3_sw", "ps_4_0", "ps_4_1",
//                   "gs_4_0",  "gs_4_1",
//                   "tx_1_0",
//                   "fx_4_0",  "fx_4_1"
//      Note that this entrypoint does not compile fx_2_0 targets, for that
//      you need to use the D3DX9 function.
//      Note that this entrypoint does not compile fx_2_0 targets, for that
//      you need to use the D3DX9 function.
//  Flags1
//      See D3D10_SHADER_xxx flags.
//  Flags2
//      See D3D10_EFFECT_xxx flags.
//  ppShader
//      Returns a buffer containing the created shader.  This buffer contains
//      the compiled shader code, as well as any embedded debug and symbol
//      table info.  (See D3D10GetShaderConstantTable)
//  ppErrorMsgs
//      Returns a buffer containing a listing of errors and warnings that were
//      encountered during the compile.  If you are running in a debugger,
//      these are the same messages you will see in your debug output.
//  pHResult
//      Pointer to a memory location to receive the return value upon completion.
//      Maybe NULL if not needed.
//      If pPump != NULL, pHResult must be a valid memory location until the
//      the asynchronous execution completes.
//----------------------------------------------------------------------------

function D3DX10CompileFromFileA(
  pSrcFile: PAnsiChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pFunctionName: PAnsiChar;
  pProfile: PAnsiChar;
  Flags1, Flags2: LongWord;
  pPump: ID3DX10ThreadPump;
  out ppShader: ID3D10Blob;
  ppErrorMsgs: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CompileFromFileA';
{$EXTERNALSYM D3DX10CompileFromFileA}

function D3DX10CompileFromFileW(
  pSrcFile: PWideChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pFunctionName: PAnsiChar;
  pProfile: PAnsiChar;
  Flags1, Flags2: LongWord;
  pPump: ID3DX10ThreadPump;
  out ppShader: ID3D10Blob;
  ppErrorMsgs: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CompileFromFileW';
{$EXTERNALSYM D3DX10CompileFromFileW}

function D3DX10CompileFromFile(
  pSrcFile: PChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pFunctionName: PAnsiChar;
  pProfile: PAnsiChar;
  Flags1, Flags2: LongWord;
  pPump: ID3DX10ThreadPump;
  out ppShader: ID3D10Blob;
  ppErrorMsgs: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CompileFromFileA';
{$EXTERNALSYM D3DX10CompileFromFile}


function D3DX10CompileFromResourceA(
  hSrcModule: HMODULE;
  pSrcFileName: PAnsiChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pFunctionName: PAnsiChar;
  pProfile: PAnsiChar;
  Flags1, Flags2: LongWord;
  pPump: ID3DX10ThreadPump;
  out ppShader: ID3D10Blob;
  ppErrorMsgs: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CompileFromResourceA';
{$EXTERNALSYM D3DX10CompileFromResourceA}

function D3DX10CompileFromResourceW(
  hSrcModule: HMODULE;
  pSrcFileName: PWideChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pFunctionName: PAnsiChar;
  pProfile: PAnsiChar;
  Flags1, Flags2: LongWord;
  pPump: ID3DX10ThreadPump;
  out ppShader: ID3D10Blob;
  ppErrorMsgs: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CompileFromResourceW';
{$EXTERNALSYM D3DX10CompileFromResourceW}

function D3DX10CompileFromResource(
  hSrcModule: HMODULE;
  pSrcFileName: PChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pFunctionName: PAnsiChar;
  pProfile: PAnsiChar;
  Flags1, Flags2: LongWord;
  pPump: ID3DX10ThreadPump;
  out ppShader: ID3D10Blob;
  ppErrorMsgs: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CompileFromResourceA';
{$EXTERNALSYM D3DX10CompileFromResource}


function D3DX10CompileFromMemory(
  pSrcData: LPCSTR;
  SrcDataLen: SIZE_T;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pFunctionName: LPCSTR;
  pProfile: LPCSTR;
  Flags1, Flags2: LongWord;
  pPump: ID3DX10ThreadPump;
  out ppShader: ID3D10Blob;
  ppErrorMsgs: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CompileFromMemory}


//----------------------------------------------------------------------------
// D3DX10CreateEffectFromXXXX:
// --------------------------
// Creates an effect from a binary effect or file
//
// Parameters:
//
// [in]
//
//
//  pFileName
//      Name of the ASCII (uncompiled) or binary (compiled) Effect file to load
//
//  hModule
//      Handle to the module containing the resource to compile from
//  pResourceName
//      Name of the resource within hModule to compile from
//
//  pData
//      Blob of effect data, either ASCII (uncompiled) or binary (compiled)
//  DataLength
//      Length of the data blob
//
//  pDefines
//      Optional NULL-terminated array of preprocessor macro definitions.
//  pInclude
//      Optional interface pointer to use for handling #include directives.
//      If this parameter is NULL, #includes will be honored when compiling
//      from file, and will error when compiling from resource or memory.
//  pProfile
//      Profile to use when compiling the effect.
//  HLSLFlags
//      Compilation flags pertaining to shaders and data types, honored by
//      the HLSL compiler
//  FXFlags
//      Compilation flags pertaining to Effect compilation, honored
//      by the Effect compiler
//  pDevice
//      Pointer to the D3D10 device on which to create Effect resources
//  pEffectPool
//      Pointer to an Effect pool to share variables with or NULL
//
// [out]
//
//  ppEffect
//      Address of the newly created Effect interface
//  ppEffectPool
//      Address of the newly created Effect pool interface
//  ppErrors
//      If non-NULL, address of a buffer with error messages that occurred 
//      during parsing or compilation
//  pHResult
//      Pointer to a memory location to receive the return value upon completion.
//      Maybe NULL if not needed.
//      If pPump != NULL, pHResult must be a valid memory location until the
//      the asynchronous execution completes.
//----------------------------------------------------------------------------


function D3DX10CreateEffectFromFileA(
  pFileName: PAnsiChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pProfile: PAnsiChar;
  HLSLFlags: LongWord;
  FXFlags: LongWord;
  pDevice: ID3D10Device;
  pEffectPool: ID3D10EffectPool;
  pPump: ID3DX10ThreadPump;
  out ppEffect: ID3D10Effect;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateEffectFromFileA';
{$EXTERNALSYM D3DX10CreateEffectFromFileA}

function D3DX10CreateEffectFromFileW(
  pFileName: PWideChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pProfile: PAnsiChar;
  HLSLFlags: LongWord;
  FXFlags: LongWord;
  pDevice: ID3D10Device;
  pEffectPool: ID3D10EffectPool;
  pPump: ID3DX10ThreadPump;
  out ppEffect: ID3D10Effect;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateEffectFromFileW';
{$EXTERNALSYM D3DX10CreateEffectFromFileW}

function D3DX10CreateEffectFromFile(
  pFileName: PChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pProfile: PAnsiChar;
  HLSLFlags: LongWord;
  FXFlags: LongWord;
  pDevice: ID3D10Device;
  pEffectPool: ID3D10EffectPool;
  pPump: ID3DX10ThreadPump;
  out ppEffect: ID3D10Effect;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateEffectFromFileA';
{$EXTERNALSYM D3DX10CreateEffectFromFile}


function D3DX10CreateEffectFromMemory(
  pData: Pointer;
  DataLength: SIZE_T;
  pSrcFileName: LPCTSTR;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pProfile: LPCSTR;
  HLSLFlags: LongWord;
  FXFlags: LongWord;
  pDevice: ID3D10Device;
  pEffectPool: ID3D10EffectPool;
  pPump: ID3DX10ThreadPump;
  out ppEffect: ID3D10Effect;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CreateEffectFromMemory}

function D3DX10CreateEffectFromResourceA(
  hModule: HMODULE;
  pResourceName: PAnsiChar;
  pSrcFileName: PAnsiChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pProfile: PAnsiChar;
  HLSLFlags: LongWord;
  FXFlags: LongWord;
  pDevice: ID3D10Device;
  pEffectPool: ID3D10EffectPool;
  pPump: ID3DX10ThreadPump;
  out ppEffect: ID3D10Effect;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateEffectFromResourceA';
{$EXTERNALSYM D3DX10CreateEffectFromResourceA}

function D3DX10CreateEffectFromResourceW(
  hModule: HMODULE;
  pResourceName: PAnsiChar;
  pSrcFileName: PAnsiChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pProfile: PAnsiChar;
  HLSLFlags: LongWord;
  FXFlags: LongWord;
  pDevice: ID3D10Device;
  pEffectPool: ID3D10EffectPool;
  pPump: ID3DX10ThreadPump;
  out ppEffect: ID3D10Effect;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateEffectFromResourceW';
{$EXTERNALSYM D3DX10CreateEffectFromResourceW}

function D3DX10CreateEffectFromResource(
  hModule: HMODULE;
  pResourceName: PAnsiChar;
  pSrcFileName: PAnsiChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pProfile: PAnsiChar;
  HLSLFlags: LongWord;
  FXFlags: LongWord;
  pDevice: ID3D10Device;
  pEffectPool: ID3D10EffectPool;
  pPump: ID3DX10ThreadPump;
  out ppEffect: ID3D10Effect;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateEffectFromResourceA';
{$EXTERNALSYM D3DX10CreateEffectFromResource}


function D3DX10CreateEffectPoolFromFileA(
  pFileName: PAnsiChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pProfile: PAnsiChar;
  HLSLFlags: LongWord;
  FXFlags: LongWord;
  pDevice: ID3D10Device;
  pPump: ID3DX10ThreadPump;
  pEffectPool: ID3D10EffectPool;
  out ppEffect: ID3D10Effect;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateEffectPoolFromFileA';
{$EXTERNALSYM D3DX10CreateEffectPoolFromFileA}

function D3DX10CreateEffectPoolFromFileW(
  pFileName: PAnsiChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pProfile: PAnsiChar;
  HLSLFlags: LongWord;
  FXFlags: LongWord;
  pDevice: ID3D10Device;
  pPump: ID3DX10ThreadPump;
  pEffectPool: ID3D10EffectPool;
  out ppEffect: ID3D10Effect;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateEffectPoolFromFileW';
{$EXTERNALSYM D3DX10CreateEffectPoolFromFileW}

function D3DX10CreateEffectPoolFromFile(
  pFileName: PAnsiChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pProfile: PAnsiChar;
  HLSLFlags: LongWord;
  FXFlags: LongWord;
  pDevice: ID3D10Device;
  pPump: ID3DX10ThreadPump;
  pEffectPool: ID3D10EffectPool;
  out ppEffect: ID3D10Effect;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateEffectPoolFromFileA';
{$EXTERNALSYM D3DX10CreateEffectPoolFromFile}


function D3DX10CreateEffectPoolFromMemory(
  pData: Pointer;
  DataLength: SIZE_T;
  pSrcFileName: LPCSTR;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pProfile: LPCSTR;
  HLSLFlags: LongWord;
  FXFlags: LongWord;
  pDevice: ID3D10Device;
  pPump: ID3DX10ThreadPump;
  pEffectPool: ID3D10EffectPool;
  out ppEffect: ID3D10Effect;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CreateEffectPoolFromMemory}

function D3DX10CreateEffectPoolFromResourceA(
  hModule: HMODULE;
  pResourceName: PAnsiChar;
  pSrcFileName: PAnsiChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pProfile: PAnsiChar;
  HLSLFlags: LongWord;
  FXFlags: LongWord;
  pDevice: ID3D10Device;
  pPump: ID3DX10ThreadPump;
  pEffectPool: ID3D10EffectPool;
  out ppEffect: ID3D10Effect;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateEffectPoolFromResourceA';
{$EXTERNALSYM D3DX10CreateEffectPoolFromResourceA}

function D3DX10CreateEffectPoolFromResourceW(
  hModule: HMODULE;
  pResourceName: PAnsiChar;
  pSrcFileName: PAnsiChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pProfile: PAnsiChar;
  HLSLFlags: LongWord;
  FXFlags: LongWord;
  pDevice: ID3D10Device;
  pPump: ID3DX10ThreadPump;
  pEffectPool: ID3D10EffectPool;
  out ppEffect: ID3D10Effect;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateEffectPoolFromResourceW';
{$EXTERNALSYM D3DX10CreateEffectPoolFromResourceW}

function D3DX10CreateEffectPoolFromResource(
  hModule: HMODULE;
  pResourceName: PAnsiChar;
  pSrcFileName: PAnsiChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pProfile: PAnsiChar;
  HLSLFlags: LongWord;
  FXFlags: LongWord;
  pDevice: ID3D10Device;
  pPump: ID3DX10ThreadPump;
  pEffectPool: ID3D10EffectPool;
  out ppEffect: ID3D10Effect;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10CreateEffectPoolFromResourceA';
{$EXTERNALSYM D3DX10CreateEffectPoolFromResource}


function D3DX10PreprocessShaderFromFileA(
  pFileName: PAnsiChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pPump: ID3DX10ThreadPump;
  out ppShaderText: ID3D10Blob;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10PreprocessShaderFromFileA';
{$EXTERNALSYM D3DX10PreprocessShaderFromFileA}

function D3DX10PreprocessShaderFromFileW(
  pFileName: PAnsiChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pPump: ID3DX10ThreadPump;
  out ppShaderText: ID3D10Blob;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10PreprocessShaderFromFileW';
{$EXTERNALSYM D3DX10PreprocessShaderFromFileW}

function D3DX10PreprocessShaderFromFile(
  pFileName: PAnsiChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pPump: ID3DX10ThreadPump;
  out ppShaderText: ID3D10Blob;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10PreprocessShaderFromFileA';
{$EXTERNALSYM D3DX10PreprocessShaderFromFile}


function D3DX10PreprocessShaderFromMemory(
  pSrcData: LPCSTR;
  SrcDataSize: SIZE_T;
  pFileName: LPCSTR;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pPump: ID3DX10ThreadPump;
  out ppShaderText: ID3D10Blob;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10PreprocessShaderFromMemory}

function D3DX10PreprocessShaderFromResourceA(
  hModule: HMODULE;
  pResourceName: PAnsiChar;
  pSrcFileName: PAnsiChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pPump: ID3DX10ThreadPump;
  out ppShaderText: ID3D10Blob;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10PreprocessShaderFromResourceA';
{$EXTERNALSYM D3DX10PreprocessShaderFromResourceA}

function D3DX10PreprocessShaderFromResourceW(
  hModule: HMODULE;
  pResourceName: PAnsiChar;
  pSrcFileName: PAnsiChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pPump: ID3DX10ThreadPump;
  out ppShaderText: ID3D10Blob;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10PreprocessShaderFromResourceW';
{$EXTERNALSYM D3DX10PreprocessShaderFromResourceW}

function D3DX10PreprocessShaderFromResource(
  hModule: HMODULE;
  pResourceName: PAnsiChar;
  pSrcFileName: PAnsiChar;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pPump: ID3DX10ThreadPump;
  out ppShaderText: ID3D10Blob;
  ppErrors: PID3D10Blob;
  pHResult: PHResult): HResult; stdcall; external d3dx10dll name 'D3DX10PreprocessShaderFromResourceA';
{$EXTERNALSYM D3DX10PreprocessShaderFromResource}


//----------------------------------------------------------------------------
// Async processors
//----------------------------------------------------------------------------

function D3DX10CreateAsyncCompilerProcessor(
  pFileName: LPCSTR;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pFunctionName: LPCSTR;
  pProfile: LPCSTR;
  Flags1, Flags2: LongWord;
  out ppCompiledShader: ID3D10Blob;
  ppErrorBuffer: PID3D10Blob;
  out ppProcessor: ID3DX10DataProcessor): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CreateAsyncCompilerProcessor}

function D3DX10CreateAsyncEffectCreateProcessor(
  pFileName: LPCSTR;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pProfile: LPCSTR;
  Flags: LongWord;
  FXFlags: LongWord;
  pDevice: ID3D10Device;
  pPool: ID3D10EffectPool;
  ppErrorBuffer: PID3D10Blob;
  out ppProcessor: ID3DX10DataProcessor): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CreateAsyncEffectCreateProcessor}

function D3DX10CreateAsyncEffectPoolCreateProcessor(
  pFileName: LPCSTR;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  pProfile: LPCSTR;
  Flags: LongWord;
  FXFlags: LongWord;
  pDevice: ID3D10Device;
  ppErrorBuffer: PID3D10Blob;
  out ppProcessor: ID3DX10DataProcessor): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CreateAsyncEffectPoolCreateProcessor}

function D3DX10CreateAsyncShaderPreprocessProcessor(
  pFileName: LPCSTR;
  const pDefines: PD3D10_ShaderMacro;
  pInclude: ID3D10Include;
  out ppShaderText: ID3D10Blob;
  ppErrorBuffer: PID3D10Blob;
  out ppProcessor: ID3DX10DataProcessor): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CreateAsyncShaderPreprocessProcessor}



//----------------------------------------------------------------------------
// D3DX10 Asynchronous texture I/O (advanced mode)
//----------------------------------------------------------------------------

function D3DX10CreateAsyncFileLoaderA(pFileName: PAnsiChar; out ppDataLoader: ID3DX10DataLoader): HResult; stdcall; external d3dx10dll name 'D3DX10CreateAsyncFileLoaderA';
{$EXTERNALSYM D3DX10CreateAsyncFileLoaderA}
function D3DX10CreateAsyncFileLoaderW(pFileName: PWideChar; out ppDataLoader: ID3DX10DataLoader): HResult; stdcall; external d3dx10dll name 'D3DX10CreateAsyncFileLoaderW';
{$EXTERNALSYM D3DX10CreateAsyncFileLoaderW}
function D3DX10CreateAsyncFileLoader(pFileName: PChar; out ppDataLoader: ID3DX10DataLoader): HResult; stdcall; external d3dx10dll name 'D3DX10CreateAsyncFileLoaderA';
{$EXTERNALSYM D3DX10CreateAsyncFileLoader}
function D3DX10CreateAsyncMemoryLoader(pData: Pointer; cbData: SIZE_T; out ppDataLoader: ID3DX10DataLoader): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CreateAsyncMemoryLoader}
function D3DX10CreateAsyncResourceLoaderA(hSrcModule: HMODULE; pSrcResource: PAnsiChar; out ppDataLoader: ID3DX10DataLoader): HResult; stdcall; external d3dx10dll name 'D3DX10CreateAsyncResourceLoaderA';
{$EXTERNALSYM D3DX10CreateAsyncResourceLoaderA}
function D3DX10CreateAsyncResourceLoaderW(hSrcModule: HMODULE; pSrcResource: PWideChar; out ppDataLoader: ID3DX10DataLoader): HResult; stdcall; external d3dx10dll name 'D3DX10CreateAsyncResourceLoaderW';
{$EXTERNALSYM D3DX10CreateAsyncResourceLoaderW}
function D3DX10CreateAsyncResourceLoader(hSrcModule: HMODULE; pSrcResource: PChar; out ppDataLoader: ID3DX10DataLoader): HResult; stdcall; external d3dx10dll name 'D3DX10CreateAsyncResourceLoaderA';
{$EXTERNALSYM D3DX10CreateAsyncResourceLoader}


function D3DX10CreateAsyncTextureProcessor(pDevice: ID3D10Device; pLoadInfo: PD3DX10_ImageLoadInfo; out ppDataProcessor: ID3DX10DataProcessor): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CreateAsyncTextureProcessor}
function D3DX10CreateAsyncTextureInfoProcessor(pImageInfo: PD3DX10_ImageLoadInfo; out ppDataProcessor: ID3DX10DataProcessor): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CreateAsyncTextureInfoProcessor}
function D3DX10CreateAsyncShaderResourceViewProcessor(pDevice: ID3D10Device; pLoadInfo: PD3DX10_ImageLoadInfo; out ppDataProcessor: ID3DX10DataProcessor): HResult; stdcall; external d3dx10dll;
{$EXTERNALSYM D3DX10CreateAsyncShaderResourceViewProcessor}



implementation


//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx10.h
//  Content:    D3DX10 utility library
//
//////////////////////////////////////////////////////////////////////////////

// #define MAKE_DDHRESULT( code )  MAKE_HRESULT( 1, _FACDD, code )
function MAKE_DDHRESULT(Code: DWord): DWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
begin
  Result:= DWord((1 shl 31) or (_FACDD shl 16)) or Code;
end;



//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       D3DX10math.h, d3dx10math.inl
//  Content:    D3DX10 math types and functions
//
//////////////////////////////////////////////////////////////////////////////


//===========================================================================
//
// General purpose utilities
//
//===========================================================================

function D3DXToRadian(Degree: Single): Single;
begin
  Result:= Degree * (D3DX_PI / 180.0);
end;

function D3DXToDegree(Radian: Single): Single;
begin
  Result:= Radian * (180.0 / D3DX_PI);
end;

function D3DXToRadian(Degree: Double): Double;
begin
  Result:= Degree * (D3DX_PI / 180.0);
end;

function D3DXToDegree(Radian: Double): Double;
begin
  Result:= Radian * (180.0 / D3DX_PI);
end;


//===========================================================================
//
// 16 bit floating point numbers
//
//===========================================================================

function D3DXFloat16(value: Single): TD3DXFloat16;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  D3DXFloat32To16Array(@Result, @value, 1);
end;

function D3DXFloat16Equal(const v1, v2: TD3DXFloat16): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  // At least one is NaN
  if ( (v1.value and D3DX_16F_EXP_MASK = D3DX_16F_EXP_MASK) and (v1.value and D3DX_16F_FRAC_MASK <> 0) )
      or
     ( (v2.value and D3DX_16F_EXP_MASK = D3DX_16F_EXP_MASK) and (v2.value and D3DX_16F_FRAC_MASK <> 0) )
  then
    Result:= False
  // +/- Zero
  else if (v1.value and not D3DX_16F_SIGN_MASK = 0) and (v2.value and not D3DX_16F_SIGN_MASK = 0) then
    Result:= True
  else
    Result:= (v1.value = v2.value);
end;

function D3DXFloat16NotEqual(const v1, v2: TD3DXFloat16): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  // At least one is NaN
  if ( (v1.value and D3DX_16F_EXP_MASK = D3DX_16F_EXP_MASK) and (v1.value and D3DX_16F_FRAC_MASK <> 0) )
      or
     ( (v2.value and D3DX_16F_EXP_MASK = D3DX_16F_EXP_MASK) and (v2.value and D3DX_16F_FRAC_MASK <> 0))
  then
    Result:= True
  // +/- Zero
  else if (v1.value and not D3DX_16F_SIGN_MASK = 0) and (v2.value and not D3DX_16F_SIGN_MASK = 0) then
    Result:= False
  else
    Result:= (v1.value  <> v2.value);
end;

function D3DXFloat16ToFloat(value: TD3DXFloat16): Single;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  D3DXFloat16To32Array(@Result, @value, 1);
end;



//===========================================================================
//
// Vectors
//
//===========================================================================

//--------------------------
// 2D Vector
//--------------------------

function D3DXVector2(_x, _y: Single): TD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result.x:= _x; Result.y:= _y;
end;

function D3DXVector2Equal(const v1, v2: TD3DXVector2): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result:= (v1.x = v2.x) and (v1.y = v2.y);
end;


//--------------------------
// 2D Vector (16 bit)
//--------------------------
function D3DXVector2_16F(_x, _y: TD3DXFloat16): TD3DXVector2_16F;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= _x;
    y:= _y;
  end;
end;

function D3DXVector2_16fEqual(const v1, v2: TD3DXVector2_16F): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result:= D3DXFloat16Equal(v1.x, v2.x) and D3DXFloat16Equal(v1.y, v2.y);
end;

function D3DXVector2_16fNotEqual(const v1, v2: TD3DXVector2_16F): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result:= D3DXFloat16NotEqual(v1.x, v2.x) or D3DXFloat16NotEqual(v1.y, v2.y);
end;

function D3DXVector2_16fFromVector2(const v: TD3DXVector2): TD3DXVector2_16f;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  D3DXFloat32To16Array(@Result.x, @v.x, 2);
end;

function D3DXVector2FromVector2_16f(const v: TD3DXVector2_16f): TD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  D3DXFloat16To32Array(@Result.x, @v.x, 2);
end;


//--------------------------
// 3D Vector
//--------------------------

function D3DXVector3(_x, _y, _z: Single): TD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= _x; y:= _y; z:=_z;
  end;
end;

function D3DXVector3Equal(const v1, v2: TD3DXVector3): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result:= (v1.x = v2.x) and (v1.y = v2.y) and (v1.z = v2.z);
end;


//--------------------------
// 3D Vector (16 bit)
//--------------------------

function D3DXVector3_16F(_x, _y, _z: TD3DXFloat16): TD3DXVector3_16F;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= _x; y:= _y; z:= _z;
  end;
end;

function D3DXVector3_16fEqual(const v1, v2: TD3DXVector3_16F): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result:= D3DXFloat16Equal(v1.x, v2.x) and D3DXFloat16Equal(v1.y, v2.y) and D3DXFloat16Equal(v1.z, v2.z);
end;

function D3DXVector3_16fNotEqual(const v1, v2: TD3DXVector3_16F): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result:= D3DXFloat16NotEqual(v1.x, v2.x) or D3DXFloat16NotEqual(v1.y, v2.y) or D3DXFloat16NotEqual(v1.z, v2.z);
end;

function D3DXVector3_16fFromVector3(const v: TD3DXVector3): TD3DXVector3_16f;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  D3DXFloat32To16Array(@Result.x, @v.x, 3);
end;

function D3DXVector3FromVector3_16f(const v: TD3DXVector3_16f): TD3DXVector3;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  D3DXFloat16To32Array(@Result.x, @v.x, 3);
end;


//--------------------------
// 4D Vector
//--------------------------

function D3DXVector4(_x, _y, _z, _w: Single): TD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= _x; y:= _y; z:= _z; w:= _w;
  end;
end;

function D3DXVector4(xyz: TD3DXVector3; _w: Single): TD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= xyz.x; y:= xyz.y; z:= xyz.z; w:= _w;
  end;
end;

function D3DXVector4Equal(const v1, v2: TD3DXVector4): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result:= (v1.x = v2.x) and (v1.y = v2.y) and
    (v1.z = v2.z) and (v1.w = v2.w);
end;


//--------------------------
// 4D Vector (16 bit)
//--------------------------
function D3DXVector4_16F(_x, _y, _z, _w: TD3DXFloat16): TD3DXVector4_16F;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= _x; y:= _y; z:= _z; w:= _w;
  end;
end;

function D3DXVector4_16F(xyz: TD3DXVector3_16f; _w: TD3DXFloat16): TD3DXVector4_16F;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= xyz.x; y:= xyz.y; z:= xyz.z; w:= _w;
  end;
end;

function D3DXVector4_16fEqual(const v1, v2: TD3DXVector4_16F): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result:= D3DXFloat16Equal(v1.x, v2.x) and D3DXFloat16Equal(v1.y, v2.y) and
           D3DXFloat16Equal(v1.z, v2.z) and D3DXFloat16Equal(v1.w, v2.w);
end;

function D3DXVector4_16fNotEqual(const v1, v2: TD3DXVector4_16F): Boolean;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result:= D3DXFloat16NotEqual(v1.x, v2.x) or D3DXFloat16NotEqual(v1.y, v2.y) or
           D3DXFloat16NotEqual(v1.z, v2.z) or D3DXFloat16NotEqual(v1.w, v2.w);
end;

function D3DXVector4_16fFromVector4(const v: TD3DXVector4): TD3DXVector4_16f;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  D3DXFloat32To16Array(@Result.x, @v.x, 4);
end;

function D3DXVector4FromVector4_16f(const v: TD3DXVector4_16f): TD3DXVector4;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  D3DXFloat16To32Array(@Result.x, @v.x, 4);
end;


//--------------------------
// 4D Matrix
//--------------------------
function D3DXMatrix(
  _m00, _m01, _m02, _m03,
  _m10, _m11, _m12, _m13,
  _m20, _m21, _m22, _m23,
  _m30, _m31, _m32, _m33: Single): TD3DXMatrix;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    m[0,0]:= _m00; m[0,1]:= _m01; m[0,2]:= _m02; m[0,3]:= _m03;
    m[1,0]:= _m10; m[1,1]:= _m11; m[1,2]:= _m12; m[1,3]:= _m13;
    m[2,0]:= _m20; m[2,1]:= _m21; m[2,2]:= _m22; m[2,3]:= _m23;
    m[3,0]:= _m30; m[3,1]:= _m31; m[3,2]:= _m32; m[3,3]:= _m33;
  end;
end;

function D3DXMatrixAdd(out mOut: TD3DXMatrix; const m1, m2: TD3DXMatrix): PD3DXMatrix;
var
  pOut, p1, p2: PSingle; x: Integer;
begin
  pOut:= @mOut._11; p1:= @m1._11; p2:= @m2._11;
  for x:= 0 to 15 do
  begin
    pOut^:= p1^+p2^;
    Inc(pOut); Inc(p1); Inc(p2);
  end;
  Result:= @mOut;
end;

function D3DXMatrixSubtract(out mOut: TD3DXMatrix; const m1, m2: TD3DXMatrix): PD3DXMatrix;
var
  pOut, p1, p2: PSingle; x: Integer;
begin
  pOut:= @mOut._11; p1:= @m1._11; p2:= @m2._11;
  for x:= 0 to 15 do
  begin
    pOut^:= p1^-p2^;
    Inc(pOut); Inc(p1); Inc(p2);
  end;
  Result:= @mOut;
end;

function D3DXMatrixMul(out mOut: TD3DXMatrix; const m: TD3DXMatrix; MulBy: Single): PD3DXMatrix;
var
  pOut, p: PSingle; x: Integer;
begin
  pOut:= @mOut._11; p:= @m._11;
  for x:= 0 to 15 do
  begin
    pOut^:= p^* MulBy;
    Inc(pOut); Inc(p);
  end;
  Result:= @mOut;
end;

function D3DXMatrixEqual(const m1, m2: TD3DXMatrix): Boolean;
begin
  Result:= CompareMem(@m1, @m2, SizeOf(TD3DXMatrix));
end;

//--------------------------
// Quaternion
//--------------------------
function D3DXQuaternion(_x, _y, _z, _w: Single): TD3DXQuaternion;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= _x; y:= _y; z:= _z; w:= _w;
  end;
end;

function D3DXQuaternionAdd(const q1, q2: TD3DXQuaternion): TD3DXQuaternion;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= q1.x+q2.x; y:= q1.y+q2.y; z:= q1.z+q2.z; w:= q1.w+q2.w;
  end;
end;

function D3DXQuaternionSubtract(const q1, q2: TD3DXQuaternion): TD3DXQuaternion;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    x:= q1.x-q2.x; y:= q1.y-q2.y; z:= q1.z-q2.z; w:= q1.w-q2.w;
  end;
end;

function D3DXQuaternionEqual(const q1, q2: TD3DXQuaternion): Boolean;
begin
  Result:= (q1.x = q2.x) and (q1.y = q2.y) and
    (q1.z = q2.z) and (q1.w = q2.w);
end;

function D3DXQuaternionScale(out qOut: TD3DXQuaternion; const q: TD3DXQuaternion;
  s: Single): PD3DXQuaternion;
begin
  with qOut do
  begin
    x:= q.x*s; y:= q.y*s; z:= q.z*s; w:= q.w*s;
  end;
  Result:= @qOut;
end;


//--------------------------
// Plane
//--------------------------

function D3DXPlane(_a, _b, _c, _d: Single): TD3DXPlane;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    a:= _a; b:= _b; c:= _c; d:= _d;
  end;
end;

function D3DXPlaneEqual(const p1, p2: TD3DXPlane): Boolean;
begin
  Result:=
    (p1.a = p2.a) and (p1.b = p2.b) and
    (p1.c = p2.c) and (p1.d = p2.d);
end;


//--------------------------
// Color
//--------------------------

function D3DXColor(_r, _g, _b, _a: Single): TD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  with Result do
  begin
    r:= _r; g:= _g; b:= _b; a:= _a;
  end;
end;

function D3DXColorToDWord(c: TD3DXColor): DWord;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
var
  dwR, dwG, dwB, dwA: DWORD;
begin
  if c.r > 1.0 then dwR:= 255 else if c.r < 0 then dwR:= 0 else dwR:= DWORD(Trunc(c.r * 255.0 + 0.5));
  if c.g > 1.0 then dwG:= 255 else if c.g < 0 then dwG:= 0 else dwG:= DWORD(Trunc(c.g * 255.0 + 0.5));
  if c.b > 1.0 then dwB:= 255 else if c.b < 0 then dwB:= 0 else dwB:= DWORD(Trunc(c.b * 255.0 + 0.5));
  if c.a > 1.0 then dwA:= 255 else if c.a < 0 then dwA:= 0 else dwA:= DWORD(Trunc(c.a * 255.0 + 0.5));

  Result:= (dwA shl 24) or (dwR shl 16) or (dwG shl 8) or dwB;
end;

function D3DXColorToUINT(c: TD3DXColor): UINT;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
var
  dwR, dwG, dwB, dwA: UINT;
begin
  if c.r > 1.0 then dwR:= 255 else if c.r < 0 then dwR:= 0 else dwR:= DWORD(Trunc(c.r * 255.0 + 0.5));
  if c.g > 1.0 then dwG:= 255 else if c.g < 0 then dwG:= 0 else dwG:= DWORD(Trunc(c.g * 255.0 + 0.5));
  if c.b > 1.0 then dwB:= 255 else if c.b < 0 then dwB:= 0 else dwB:= DWORD(Trunc(c.b * 255.0 + 0.5));
  if c.a > 1.0 then dwA:= 255 else if c.a < 0 then dwA:= 0 else dwA:= DWORD(Trunc(c.a * 255.0 + 0.5));

  Result:= (dwA shl 24) or (dwR shl 16) or (dwG shl 8) or dwB;
end;

function D3DXColorFromDWord(c: DWord): TD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
var
  f: Single; // = 1/255; //Clootie: Changed from CONST due to Delphi9 inline bug
begin
  f:= (1/255);
  with Result do
  begin
    r:= f * Byte(c shr 16);
    g:= f * Byte(c shr  8);
    b:= f * Byte(c{shr 0});
    a:= f * Byte(c shr 24);
  end;
end;

function D3DXColorFromUINT(c: UINT): TD3DXColor;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
var
  f: Single; // = 1/255; //Clootie: Changed from CONST due to Delphi9 inline bug
begin
  f:= (1/255);
  with Result do
  begin
    r:= f * Byte(c shr 16);
    g:= f * Byte(c shr  8);
    b:= f * Byte(c{shr 0});
    a:= f * Byte(c shr 24);
  end;
end;

function D3DXColorEqual(const c1, c2: TD3DXColor): Boolean;
begin
  Result:= (c1.r = c2.r) and (c1.g = c2.g) and (c1.b = c2.b) and (c1.a = c2.a);
end;


//===========================================================================
//
// D3DX math functions:
//
// NOTE:
//  * All these functions can take the same object as in and out parameters.
//
//  * Out parameters are typically also returned as return values, so that
//    the output of one function may be used as a parameter to another.
//
//===========================================================================

//--------------------------
// 2D Vector
//--------------------------

// "inline"
function D3DXVec2Length(const v: TD3DXVector2): Single;
begin
  with v do Result:= Sqrt(x*x + y*y);
end;

function D3DXVec2LengthSq(const v: TD3DXVector2): Single;
begin
  with v do Result:= x*x + y*y;
end;

function D3DXVec2Dot(const v1, v2: TD3DXVector2): Single;
begin
  Result:= v1.x*v2.x + v1.y*v2.y;
end;

// Z component of ((x1,y1,0) cross (x2,y2,0))
function D3DXVec2CCW(const v1, v2: TD3DXVector2): Single;
begin
  Result:= v1.x*v2.y - v1.y*v2.x;
end;

function D3DXVec2Add(const v1, v2: TD3DXVector2): TD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result.x:= v1.x + v2.x;
  Result.y:= v1.y + v2.y;
end;

function D3DXVec2Subtract(const v1, v2: TD3DXVector2): TD3DXVector2;{$IFDEF ALLOW_INLINE} inline;{$ENDIF}
begin
  Result.x:= v1.x - v2.x;
  Result.y:= v1.y - v2.y;
end;

// Minimize each component.  x = min(x1, x2), y = min(y1, y2)
function D3DXVec2Minimize(out vOut: TD3DXVector2; const v1, v2: TD3DXVEctor2): PD3DXVector2;
begin
  if v1.x < v2.x then vOut.x:= v1.x else vOut.x:= v2.x;
  if v1.y < v2.y then vOut.y:= v1.y else vOut.y:= v2.y;
  Result:= @vOut;
end;

// Maximize each component.  x = max(x1, x2), y = max(y1, y2)
function D3DXVec2Maximize(out vOut: TD3DXVector2; const v1, v2: TD3DXVector2): PD3DXVector2;
begin
  if v1.x > v2.x then vOut.x:= v1.x else vOut.x:= v2.x;
  if v1.y > v2.y then vOut.y:= v1.y else vOut.y:= v2.y;
  Result:= @vOut;
end;

function D3DXVec2Scale(out vOut: TD3DXVector2; const v: TD3DXVector2; s: Single): PD3DXVector2;
begin
  vOut.x:= v.x*s; vOut.y:= v.y*s;
  Result:= @vOut;
end;

// Linear interpolation. V1 + s(V2-V1)
function D3DXVec2Lerp(out vOut: TD3DXVector2; const v1, v2: TD3DXVector2; s: Single): PD3DXVector2;
begin
  vOut.x:= v1.x + s * (v2.x-v1.x);
  vOut.y:= v1.y + s * (v2.y-v1.y);
  Result:= @vOut;
end;


//--------------------------
// 3D Vector
//--------------------------
function D3DXVec3Length(const v: TD3DXVector3): Single;
begin
  with v do Result:= Sqrt(x*x + y*y + z*z);
end;

function D3DXVec3LengthSq(const v: TD3DXVector3): Single;
begin
  with v do Result:= x*x + y*y + z*z;
end;

function D3DXVec3Dot(const v1, v2: TD3DXVector3): Single;
begin
  Result:= v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
end;

function D3DXVec3Cross(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;
begin
  vOut.x:= v1.y * v2.z - v1.z * v2.y;
  vOut.y:= v1.z * v2.x - v1.x * v2.z;
  vOut.z:= v1.x * v2.y - v1.y * v2.x;
  Result:= @vOut;
end;

function D3DXVec3Add(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;
begin
  with vOut do
  begin
    x:= v1.x + v2.x;
    y:= v1.y + v2.y;
    z:= v1.z + v2.z;
  end;
  Result:= @vOut;
end;

function D3DXVec3Subtract(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;
begin
  with vOut do
  begin
    x:= v1.x - v2.x;
    y:= v1.y - v2.y;
    z:= v1.z - v2.z;
  end;
  Result:= @vOut;
end;

// Minimize each component.  x = min(x1, x2), y = min(y1, y2)
function D3DXVec3Minimize(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;
begin
  if v1.x < v2.x then vOut.x:= v1.x else vOut.x:= v2.x;
  if v1.y < v2.y then vOut.y:= v1.y else vOut.y:= v2.y;
  if v1.z < v2.z then vOut.z:= v1.z else vOut.z:= v2.z;
  Result:= @vOut;
end;

// Maximize each component.  x = max(x1, x2), y = max(y1, y2)
function D3DXVec3Maximize(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3): PD3DXVector3;
begin
  if v1.x > v2.x then vOut.x:= v1.x else vOut.x:= v2.x;
  if v1.y > v2.y then vOut.y:= v1.y else vOut.y:= v2.y;
  if v1.z > v2.z then vOut.z:= v1.z else vOut.z:= v2.z;
  Result:= @vOut;
end;

function D3DXVec3Scale(out vOut: TD3DXVector3; const v: TD3DXVector3; s: Single): PD3DXVector3;
begin
  with vOut do
  begin
    x:= v.x * s; y:= v.y * s; z:= v.z * s;
  end;
  Result:= @vOut;
end;

// Linear interpolation. V1 + s(V2-V1)
function D3DXVec3Lerp(out vOut: TD3DXVector3; const v1, v2: TD3DXVector3; s: Single): PD3DXVector3;
begin
  vOut.x:= v1.x + s * (v2.x-v1.x);
  vOut.y:= v1.y + s * (v2.y-v1.y);
  vOut.z:= v1.z + s * (v2.z-v1.z);
  Result:= @vOut;
end;


//--------------------------
// 4D Vector
//--------------------------

function D3DXVec4Length(const v: TD3DXVector4): Single;
begin
  with v do Result:= Sqrt(x*x + y*y + z*z + w*w);
end;

function D3DXVec4LengthSq(const v: TD3DXVector4): Single;
begin
  with v do Result:= x*x + y*y + z*z + w*w
end;

function D3DXVec4Dot(const v1, v2: TD3DXVector4): Single;
begin
  Result:= v1.x * v2.x + v1.y * v2.y + v1.z * v2.z + v1.w * v2.w;
end;

function D3DXVec4Add(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;
begin
  with vOut do
  begin
    x:= v1.x + v2.x;
    y:= v1.y + v2.y;
    z:= v1.z + v2.z;
    w:= v1.w + v2.w;
  end;
  Result:= @vOut;
end;

function D3DXVec4Subtract(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;
begin
  with vOut do
  begin
    x:= v1.x - v2.x;
    y:= v1.y - v2.y;
    z:= v1.z - v2.z;
    w:= v1.w - v2.w;
  end;
  Result:= @vOut;
end;


// Minimize each component.  x = min(x1, x2), y = min(y1, y2)
function D3DXVec4Minimize(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;
begin
  if v1.x < v2.x then vOut.x:= v1.x else vOut.x:= v2.x;
  if v1.y < v2.y then vOut.y:= v1.y else vOut.y:= v2.y;
  if v1.z < v2.z then vOut.z:= v1.z else vOut.z:= v2.z;
  if v1.w < v2.w then vOut.w:= v1.w else vOut.w:= v2.w;
  Result:= @vOut;
end;

// Maximize each component.  x = max(x1, x2), y = max(y1, y2)
function D3DXVec4Maximize(out vOut: TD3DXVector4; const v1, v2: TD3DXVector4): PD3DXVector4;
begin
  if v1.x > v2.x then vOut.x:= v1.x else vOut.x:= v2.x;
  if v1.y > v2.y then vOut.y:= v1.y else vOut.y:= v2.y;
  if v1.z > v2.z then vOut.z:= v1.z else vOut.z:= v2.z;
  if v1.w > v2.w then vOut.w:= v1.w else vOut.w:= v2.w;
  Result:= @vOut;
end;

function D3DXVec4Scale(out vOut: TD3DXVector4; const v: TD3DXVector4; s: Single): PD3DXVector4;
begin
  with vOut do
  begin
    x:= v.x * s; y:= v.y * s; z:= v.z * s; w:= v.w * s;
  end;
  Result:= @vOut;
end;

// Linear interpolation. V1 + s(V2-V1)
function D3DXVec4Lerp(out vOut: TD3DXVector4;
  const v1, v2: TD3DXVector4; s: Single): PD3DXVector4;
begin
  with vOut do
  begin
    x:= v1.x + s * (v2.x - v1.x);
    y:= v1.y + s * (v2.y - v1.y);
    z:= v1.z + s * (v2.z - v1.z);
    w:= v1.w + s * (v2.w - v1.w);
  end;
  Result:= @vOut;
end;

//--------------------------
// 4D Matrix
//--------------------------

// inline
function D3DXMatrixIdentity(out mOut: TD3DXMatrix): PD3DXMatrix;
begin
  FillChar(mOut, SizeOf(mOut), 0);
  mOut._11:= 1; mOut._22:= 1; mOut._33:= 1; mOut._44:= 1;
  Result:= @mOut;
end;

function D3DXMatrixIsIdentity(const m: TD3DXMatrix): BOOL;
begin
  with m do Result:=
    (_11 = 1) and (_12 = 0) and (_13 = 0) and (_14 = 0) and
    (_21 = 0) and (_22 = 1) and (_23 = 0) and (_24 = 0) and
    (_31 = 0) and (_32 = 0) and (_33 = 1) and (_34 = 0) and
    (_41 = 0) and (_42 = 0) and (_43 = 0) and (_44 = 1);
end;


//--------------------------
// Quaternion
//--------------------------

// inline

function D3DXQuaternionLength(const q: TD3DXQuaternion): Single;
begin
  with q do Result:= Sqrt(x*x + y*y + z*z + w*w);
end;

// Length squared, or "norm"
function D3DXQuaternionLengthSq(const q: TD3DXQuaternion): Single;
begin
  with q do Result:= x*x + y*y + z*z + w*w;
end;

function D3DXQuaternionDot(const q1, q2: TD3DXQuaternion): Single;
begin
  Result:= q1.x * q2.x + q1.y * q2.y + q1.z * q2.z + q1.w * q2.w;
end;

function D3DXQuaternionIdentity(out qOut: TD3DXQuaternion): PD3DXQuaternion;
begin
  with qOut do
  begin
    x:= 0; y:= 0; z:= 0; w:= 1.0;
  end;
  Result:= @qOut;
end;

function D3DXQuaternionIsIdentity(const q: TD3DXQuaternion): BOOL;
begin
  with q do Result:= (x = 0) and (y = 0) and (z = 0) and (w = 1);
end;

// (-x, -y, -z, w)
function D3DXQuaternionConjugate(out qOut: TD3DXQuaternion;
  const q: TD3DXQuaternion): PD3DXQuaternion;
begin
  with qOut do
  begin
    x:= -q.x; y:= -q.y; z:= -q.z; w:= q.w;
  end;
  Result:= @qOut;
end;


//--------------------------
// Plane
//--------------------------

// ax + by + cz + dw
function D3DXPlaneDot(const p: TD3DXPlane; const v: TD3DXVector4): Single;
begin
  with p,v do Result:= a*x + b*y + c*z + d*w;
end;

// ax + by + cz + d
function D3DXPlaneDotCoord(const p: TD3DXPlane; const v: TD3DXVector3): Single;
begin
  with p,v do Result:= a*x + b*y + c*z + d;
end;

// ax + by + cz
function D3DXPlaneDotNormal(const p: TD3DXPlane; const v: TD3DXVector3): Single;
begin
  with p,v do Result:= a*x + b*y + c*z;
end;

function D3DXPlaneScale(out pOut: TD3DXPlane; const pP: TD3DXPlane; s: Single): PD3DXPlane;
begin
  pOut.a := pP.a * s;
  pOut.b := pP.b * s;
  pOut.c := pP.c * s;
  pOut.d := pP.d * s;
  Result := @pOut;
end;


//--------------------------
// Color
//--------------------------

// inline

function D3DXColorNegative(out cOut: TD3DXColor; const c: TD3DXColor): PD3DXColor;
begin
 with cOut do
 begin
   r:= 1.0 - c.r; g:= 1.0 - c.g; b:= 1.0 - c.b;
   a:= c.a;
 end;
 Result:= @cOut;
end;

function D3DXColorAdd(out cOut: TD3DXColor; const c1,c2: TD3DXColor): PD3DXColor;
begin
  with cOut do
  begin
    r:= c1.r + c2.r; g:= c1.g + c2.g; b:= c1.b + c2.b;
    a:= c1.a + c2.a;
  end;
  Result:= @cOut;
end;

function D3DXColorSubtract(out cOut: TD3DXColor; const c1,c2: TD3DXColor): PD3DXColor;
begin
  with cOut do
  begin
    r:= c1.r - c2.r; g:= c1.g - c2.g; b:= c1.b - c2.b;
    a:= c1.a - c2.a;
  end;
  Result:= @cOut;
end;

function D3DXColorScale(out cOut: TD3DXColor; const c: TD3DXColor; s: Single): PD3DXColor;
begin
  with cOut do
  begin
    r:= c.r * s; g:= c.g * s;
    b:= c.b * s; a:= c.a * s;
  end;
  Result:= @cOut;
end;

// (r1*r2, g1*g2, b1*b2, a1*a2)
function D3DXColorModulate(out cOut: TD3DXColor; const c1,c2: TD3DXColor): PD3DXColor;
begin
  with cOut do
  begin
    r:= c1.r * c2.r; g:= c1.g * c2.g;
    b:= c1.b * c2.b; a:= c1.a * c2.a;
  end;
  Result:= @cOut;
end;

// Linear interpolation of r,g,b, and a. C1 + s(C2-C1)
function D3DXColorLerp(out cOut: TD3DXColor; const c1,c2: TD3DXColor; s: Single): PD3DXColor;
begin
  with cOut do
  begin
    r:= c1.r + s * (c2.r - c1.r);
    g:= c1.g + s * (c2.g - c1.g);
    b:= c1.b + s * (c2.b - c1.b);
    a:= c1.a + s * (c2.a - c1.a);
  end;
  Result:= @cOut;
end;





///////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) Microsoft Corporation.  All Rights Reserved.
//
//  File:       d3dx10core.h
//  Content:    D3DX10 core types and functions
//
///////////////////////////////////////////////////////////////////////////

// #define MAKE_D3DHRESULT( code )  MAKE_HRESULT( 1, _FACD3D, code )
function MAKE_D3DHRESULT(Code: DWord): DWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
begin
  Result:= DWord((1 shl 31) or (_FACD3D shl 16)) or Code;
end;

// #define MAKE_D3DSTATUS( code )  MAKE_HRESULT( 0, _FACD3D, code )
function MAKE_D3DSTATUS(Code: DWord): DWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
begin
  Result:= DWord((0 shl 31) or (_FACD3D shl 16)) or Code;
end;

end.

