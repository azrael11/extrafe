{******************************************************************************}
{*                                                                            *}
{*  Copyright (C) Microsoft Corporation.  All Rights Reserved.                *}
{*                                                                            *}
{*  Files:      D3D10.h D3D10Misc.h D3D10Shader.h                             *}
{*  Content:    Direct3D10 include files                                      *}
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

{$I DirectX.inc}

unit D3D10;

interface

{$HPPEMIT '#include "D3D10.h"'}
{$HPPEMIT '#include "D3D10Misc.h"'}
{$HPPEMIT '#include "D3D10Shader.h"'}

{$DEFINE D3D10_NO_HELPERS}

uses
  Windows, DXTypes, DXGI;


//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//
//  File:       D3D10.h
//  Content:
//
//////////////////////////////////////////////////////////////////////////////

const
  D3D10dll = 'd3d10.dll';

const
  D3D10_16BIT_INDEX_STRIP_CUT_VALUE = $ffff;
  D3D10_32BIT_INDEX_STRIP_CUT_VALUE = $ffffffff;
  D3D10_8BIT_INDEX_STRIP_CUT_VALUE = $ff;
  D3D10_ARRAY_AXIS_ADDRESS_RANGE_BIT_COUNT = 9;
  D3D10_CLIP_OR_CULL_DISTANCE_COUNT = 8;
  D3D10_CLIP_OR_CULL_DISTANCE_ELEMENT_COUNT = 2;

  D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT	= 14;
  D3D10_COMMONSHADER_CONSTANT_BUFFER_COMPONENTS = 4;
  D3D10_COMMONSHADER_CONSTANT_BUFFER_COMPONENT_BIT_COUNT = 32;
  D3D10_COMMONSHADER_CONSTANT_BUFFER_HW_SLOT_COUNT = 15;
  D3D10_COMMONSHADER_CONSTANT_BUFFER_REGISTER_COMPONENTS = 4;
  D3D10_COMMONSHADER_CONSTANT_BUFFER_REGISTER_COUNT = 15;
  D3D10_COMMONSHADER_CONSTANT_BUFFER_REGISTER_READS_PER_INST = 1;
  D3D10_COMMONSHADER_CONSTANT_BUFFER_REGISTER_READ_PORTS = 1;

  D3D10_COMMONSHADER_FLOWCONTROL_NESTING_LIMIT = 64;

  D3D10_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_COMPONENTS = 4;
  D3D10_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_COUNT = 1;
  D3D10_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_READS_PER_INST = 1;
  D3D10_COMMONSHADER_IMMEDIATE_CONSTANT_BUFFER_REGISTER_READ_PORTS = 1;
  D3D10_COMMONSHADER_IMMEDIATE_VALUE_COMPONENT_BIT_COUNT = 32;

  D3D10_COMMONSHADER_INPUT_RESOURCE_REGISTER_COMPONENTS = 1;
  D3D10_COMMONSHADER_INPUT_RESOURCE_REGISTER_COUNT = 128;
  D3D10_COMMONSHADER_INPUT_RESOURCE_REGISTER_READS_PER_INST = 1;
  D3D10_COMMONSHADER_INPUT_RESOURCE_REGISTER_READ_PORTS = 1;
  D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT = 128;

  D3D10_COMMONSHADER_SAMPLER_REGISTER_COMPONENTS = 1;
  D3D10_COMMONSHADER_SAMPLER_REGISTER_COUNT = 16;
  D3D10_COMMONSHADER_SAMPLER_REGISTER_READS_PER_INST = 1;
  D3D10_COMMONSHADER_SAMPLER_REGISTER_READ_PORTS = 1;
  D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT = 16;

  D3D10_COMMONSHADER_SUBROUTINE_NESTING_LIMIT = 32;

  D3D10_COMMONSHADER_TEMP_REGISTER_COMPONENTS = 4;
  D3D10_COMMONSHADER_TEMP_REGISTER_COMPONENT_BIT_COUNT = 32;
  D3D10_COMMONSHADER_TEMP_REGISTER_COUNT = 4096;
  D3D10_COMMONSHADER_TEMP_REGISTER_READS_PER_INST = 3;
  D3D10_COMMONSHADER_TEMP_REGISTER_READ_PORTS = 3;

  D3D10_COMMONSHADER_TEXCOORD_RANGE_REDUCTION_MAX = 10;
  D3D10_COMMONSHADER_TEXCOORD_RANGE_REDUCTION_MIN = -10;

  D3D10_COMMONSHADER_TEXEL_OFFSET_MAX_NEGATIVE = -8;
  D3D10_COMMONSHADER_TEXEL_OFFSET_MAX_POSITIVE = 7;

  D3D10_DEFAULT_BLEND_FACTOR_ALPHA = 1.0;
  D3D10_DEFAULT_BLEND_FACTOR_BLUE = 1.0;
  D3D10_DEFAULT_BLEND_FACTOR_GREEN = 1.0;
  D3D10_DEFAULT_BLEND_FACTOR_RED = 1.0;

  D3D10_DEFAULT_BORDER_COLOR_COMPONENT = 0.0;

  D3D10_DEFAULT_DEPTH_BIAS = 0;
  D3D10_DEFAULT_DEPTH_BIAS_CLAMP = 0.0;

  D3D10_DEFAULT_MAX_ANISOTROPY = 16.0;
  D3D10_DEFAULT_MIP_LOD_BIAS = 0.0;
  D3D10_DEFAULT_RENDER_TARGET_ARRAY_INDEX = 0;

  D3D10_DEFAULT_SAMPLE_MASK = $ffffffff;

  D3D10_DEFAULT_SCISSOR_ENDX = 0;
  D3D10_DEFAULT_SCISSOR_ENDY = 0;
  D3D10_DEFAULT_SCISSOR_STARTX = 0;
  D3D10_DEFAULT_SCISSOR_STARTY = 0;

  D3D10_DEFAULT_SLOPE_SCALED_DEPTH_BIAS = 0.0;

  D3D10_DEFAULT_STENCIL_READ_MASK = $ff;

  D3D10_DEFAULT_STENCIL_REFERENCE = 0;

  D3D10_DEFAULT_STENCIL_WRITE_MASK = $ff;

  D3D10_DEFAULT_VIEWPORT_AND_SCISSORRECT_INDEX = 0;

  D3D10_DEFAULT_VIEWPORT_HEIGHT = 0;
  D3D10_DEFAULT_VIEWPORT_MAX_DEPTH = 0.0;
  D3D10_DEFAULT_VIEWPORT_MIN_DEPTH = 0.0;
  D3D10_DEFAULT_VIEWPORT_TOPLEFTX = 0;
  D3D10_DEFAULT_VIEWPORT_TOPLEFTY = 0;
  D3D10_DEFAULT_VIEWPORT_WIDTH = 0;

  D3D10_FLOAT16_FUSED_TOLERANCE_IN_ULP = 0.6;

  D3D10_FLOAT32_MAX = 3.402823466e+38;
  D3D10_FLOAT32_TO_INTEGER_TOLERANCE_IN_ULP = 0.6;
  D3D10_FLOAT_TO_SRGB_EXPONENT_DENOMINATOR = 2.4;
  D3D10_FLOAT_TO_SRGB_EXPONENT_NUMERATOR = 1.0;
  D3D10_FLOAT_TO_SRGB_OFFSET = 0.055;
  D3D10_FLOAT_TO_SRGB_SCALE_1 = 12.92;
  D3D10_FLOAT_TO_SRGB_SCALE_2 = 1.055;
  D3D10_FLOAT_TO_SRGB_THRESHOLD = 0.0031308;
  D3D10_FTOI_INSTRUCTION_MAX_INPUT = 2147483647.999;
  D3D10_FTOI_INSTRUCTION_MIN_INPUT = -2147483648.999;
  D3D10_FTOU_INSTRUCTION_MAX_INPUT = 4294967295.999;
  D3D10_FTOU_INSTRUCTION_MIN_INPUT = 0.0;
  D3D10_GS_INPUT_PRIM_CONST_REGISTER_COMPONENTS = 1;

  D3D10_GS_INPUT_PRIM_CONST_REGISTER_COMPONENT_BIT_COUNT = 32;
  D3D10_GS_INPUT_PRIM_CONST_REGISTER_COUNT = 1;
  D3D10_GS_INPUT_PRIM_CONST_REGISTER_READS_PER_INST = 2;
  D3D10_GS_INPUT_PRIM_CONST_REGISTER_READ_PORTS = 1;
  D3D10_GS_INPUT_REGISTER_COMPONENTS = 4;
  D3D10_GS_INPUT_REGISTER_COMPONENT_BIT_COUNT = 32;
  D3D10_GS_INPUT_REGISTER_COUNT = 16;
  D3D10_GS_INPUT_REGISTER_READS_PER_INST = 2;
  D3D10_GS_INPUT_REGISTER_READ_PORTS = 1;
  D3D10_GS_INPUT_REGISTER_VERTICES = 6;
  D3D10_GS_OUTPUT_ELEMENTS = 32;
  D3D10_GS_OUTPUT_REGISTER_COMPONENTS = 4;
  D3D10_GS_OUTPUT_REGISTER_COMPONENT_BIT_COUNT = 32;
  D3D10_GS_OUTPUT_REGISTER_COUNT = 32;

  D3D10_IA_DEFAULT_INDEX_BUFFER_OFFSET_IN_BYTES = 0;
  D3D10_IA_DEFAULT_PRIMITIVE_TOPOLOGY = 0;
  D3D10_IA_DEFAULT_VERTEX_BUFFER_OFFSET_IN_BYTES = 0;
  D3D10_IA_INDEX_INPUT_RESOURCE_SLOT_COUNT = 1;
  D3D10_IA_INSTANCE_ID_BIT_COUNT = 32;
  D3D10_IA_INTEGER_ARITHMETIC_BIT_COUNT = 32;
  D3D10_IA_PRIMITIVE_ID_BIT_COUNT = 32;
  D3D10_IA_VERTEX_ID_BIT_COUNT = 32;
  D3D10_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT = 16;
  D3D10_IA_VERTEX_INPUT_STRUCTURE_ELEMENTS_COMPONENTS = 64;
  D3D10_IA_VERTEX_INPUT_STRUCTURE_ELEMENT_COUNT = 16;

  D3D10_INTEGER_DIVIDE_BY_ZERO_QUOTIENT = $ffffffff;
  D3D10_INTEGER_DIVIDE_BY_ZERO_REMAINDER = $ffffffff;

  D3D10_LINEAR_GAMMA = 1.0;
  D3D10_MAX_BORDER_COLOR_COMPONENT = 1.0;
  D3D10_MAX_DEPTH = 1.0;
  D3D10_MAX_MAXANISOTROPY = 16;

  D3D10_MAX_MULTISAMPLE_SAMPLE_COUNT = 32;

  D3D10_MAX_POSITION_VALUE = 3.402823466e+34;
  D3D10_MAX_TEXTURE_DIMENSION_2_TO_EXP = 17;

  D3D10_MIN_BORDER_COLOR_COMPONENT = 0.0;
  D3D10_MIN_DEPTH = 0.0;
  D3D10_MIN_MAXANISOTROPY = 0;

  D3D10_MIP_LOD_BIAS_MAX = 15.99;
  D3D10_MIP_LOD_BIAS_MIN = -16.0;
  D3D10_MIP_LOD_FRACTIONAL_BIT_COUNT = 6;

  D3D10_MIP_LOD_RANGE_BIT_COUNT = 8;

  D3D10_MULTISAMPLE_ANTIALIAS_LINE_WIDTH = 1.4;
  D3D10_NONSAMPLE_FETCH_OUT_OF_RANGE_ACCESS_RESULT = 0;

  D3D10_PIXEL_ADDRESS_RANGE_BIT_COUNT = 13;

  D3D10_PRE_SCISSOR_PIXEL_ADDRESS_RANGE_BIT_COUNT = 15;

  D3D10_PS_FRONTFACING_DEFAULT_VALUE = $ffffffff;
  D3D10_PS_FRONTFACING_FALSE_VALUE = 0;
  D3D10_PS_FRONTFACING_TRUE_VALUE = $ffffffff;
  D3D10_PS_INPUT_REGISTER_COMPONENTS = 4;
  D3D10_PS_INPUT_REGISTER_COMPONENT_BIT_COUNT = 32;
  D3D10_PS_INPUT_REGISTER_COUNT = 32;
  D3D10_PS_INPUT_REGISTER_READS_PER_INST = 2;
  D3D10_PS_INPUT_REGISTER_READ_PORTS = 1;

  D3D10_PS_LEGACY_PIXEL_CENTER_FRACTIONAL_COMPONENT = 0.0;

  D3D10_PS_OUTPUT_DEPTH_REGISTER_COMPONENTS = 1;
  D3D10_PS_OUTPUT_DEPTH_REGISTER_COMPONENT_BIT_COUNT = 32;
  D3D10_PS_OUTPUT_DEPTH_REGISTER_COUNT = 1;
  D3D10_PS_OUTPUT_REGISTER_COMPONENTS = 4;
  D3D10_PS_OUTPUT_REGISTER_COMPONENT_BIT_COUNT = 32;
  D3D10_PS_OUTPUT_REGISTER_COUNT = 8;

  D3D10_PS_PIXEL_CENTER_FRACTIONAL_COMPONENT = 0.5;
  D3D10_REQ_BLEND_OBJECT_COUNT_PER_CONTEXT = 4096;

  D3D10_REQ_BUFFER_RESOURCE_TEXEL_COUNT_2_TO_EXP = 27;
  D3D10_REQ_CONSTANT_BUFFER_ELEMENT_COUNT = 4096;
  D3D10_REQ_DEPTH_STENCIL_OBJECT_COUNT_PER_CONTEXT = 4096;
  D3D10_REQ_DRAWINDEXED_INDEX_COUNT_2_TO_EXP = 32;
  D3D10_REQ_DRAW_VERTEX_COUNT_2_TO_EXP = 32;
  D3D10_REQ_FILTERING_HW_ADDRESSABLE_RESOURCE_DIMENSION = 8192;
  D3D10_REQ_GS_INVOCATION_32BIT_OUTPUT_COMPONENT_LIMIT = 1024;
  D3D10_REQ_IMMEDIATE_CONSTANT_BUFFER_ELEMENT_COUNT = 4096;
  D3D10_REQ_MAXANISOTROPY = 16;
  D3D10_REQ_MIP_LEVELS = 14;
  D3D10_REQ_MULTI_ELEMENT_STRUCTURE_SIZE_IN_BYTES = 2048;
  D3D10_REQ_RASTERIZER_OBJECT_COUNT_PER_CONTEXT = 4096;
  D3D10_REQ_RENDER_TO_BUFFER_WINDOW_WIDTH = 8192;
  D3D10_REQ_RESOURCE_SIZE_IN_MEGABYTES = 128;
  D3D10_REQ_RESOURCE_VIEW_COUNT_PER_CONTEXT_2_TO_EXP = 20;
  D3D10_REQ_SAMPLER_OBJECT_COUNT_PER_CONTEXT = 4096;
  D3D10_REQ_TEXTURE1D_ARRAY_AXIS_DIMENSION = 512;
  D3D10_REQ_TEXTURE1D_U_DIMENSION = 8192;
  D3D10_REQ_TEXTURE2D_ARRAY_AXIS_DIMENSION = 512;
  D3D10_REQ_TEXTURE2D_U_OR_V_DIMENSION = 8192;
  D3D10_REQ_TEXTURE3D_U_V_OR_W_DIMENSION = 2048;
  D3D10_REQ_TEXTURECUBE_DIMENSION = 8192;
  D3D10_RESINFO_INSTRUCTION_MISSING_COMPONENT_RETVAL = 0;

  D3D10_SHADER_MAJOR_VERSION = 4;
  D3D10_SHADER_MINOR_VERSION = 0;

  D3D10_SHIFT_INSTRUCTION_PAD_VALUE = 0;

  D3D10_SHIFT_INSTRUCTION_SHIFT_VALUE_BIT_COUNT = 5;

  D3D10_SIMULTANEOUS_RENDER_TARGET_COUNT = 8;

  D3D10_SO_BUFFER_MAX_STRIDE_IN_BYTES = 2048;
  D3D10_SO_BUFFER_MAX_WRITE_WINDOW_IN_BYTES = 256;
  D3D10_SO_BUFFER_SLOT_COUNT = 4;
  D3D10_SO_DDI_REGISTER_INDEX_DENOTING_GAP = $ffffffff;
  D3D10_SO_MULTIPLE_BUFFER_ELEMENTS_PER_BUFFER = 1;
  D3D10_SO_SINGLE_BUFFER_COMPONENT_LIMIT = 64;

  D3D10_SRGB_GAMMA = 2.2;
  D3D10_SRGB_TO_FLOAT_DENOMINATOR_1 = 12.92;
  D3D10_SRGB_TO_FLOAT_DENOMINATOR_2 = 1.055;
  D3D10_SRGB_TO_FLOAT_EXPONENT = 2.4;
  D3D10_SRGB_TO_FLOAT_OFFSET = 0.055;
  D3D10_SRGB_TO_FLOAT_THRESHOLD = 0.04045;
  D3D10_SRGB_TO_FLOAT_TOLERANCE_IN_ULP = 0.5;

  D3D10_STANDARD_COMPONENT_BIT_COUNT = 32;
  D3D10_STANDARD_COMPONENT_BIT_COUNT_DOUBLED = 64;
  D3D10_STANDARD_MAXIMUM_ELEMENT_ALIGNMENT_BYTE_MULTIPLE = 4;
  D3D10_STANDARD_PIXEL_COMPONENT_COUNT = 128;
  D3D10_STANDARD_PIXEL_ELEMENT_COUNT = 32;
  D3D10_STANDARD_VECTOR_SIZE = 4;
  D3D10_STANDARD_VERTEX_ELEMENT_COUNT = 16;
  D3D10_STANDARD_VERTEX_TOTAL_COMPONENT_COUNT = 64;

  D3D10_SUBPIXEL_FRACTIONAL_BIT_COUNT = 8;

  D3D10_SUBTEXEL_FRACTIONAL_BIT_COUNT = 6;

  D3D10_TEXEL_ADDRESS_RANGE_BIT_COUNT = 18;

  D3D10_UNBOUND_MEMORY_ACCESS_RESULT = 0;

  D3D10_VIEWPORT_AND_SCISSORRECT_MAX_INDEX = 15;

  D3D10_VIEWPORT_AND_SCISSORRECT_OBJECT_COUNT_PER_PIPELINE = 16;

  D3D10_VIEWPORT_BOUNDS_MAX = 16383;

  D3D10_VIEWPORT_BOUNDS_MIN = -16384;

  D3D10_VS_INPUT_REGISTER_COMPONENTS = 4;
  D3D10_VS_INPUT_REGISTER_COMPONENT_BIT_COUNT = 32;
  D3D10_VS_INPUT_REGISTER_COUNT = 16;
  D3D10_VS_INPUT_REGISTER_READS_PER_INST = 2;
  D3D10_VS_INPUT_REGISTER_READ_PORTS = 1;

  D3D10_VS_OUTPUT_REGISTER_COMPONENTS = 4;
  D3D10_VS_OUTPUT_REGISTER_COMPONENT_BIT_COUNT = 32;
  D3D10_VS_OUTPUT_REGISTER_COUNT = 16;

  D3D10_WHQL_CONTEXT_COUNT_FOR_RESOURCE_LIMIT = 10;
  D3D10_WHQL_DRAWINDEXED_INDEX_COUNT_2_TO_EXP = 25;
  D3D10_WHQL_DRAW_VERTEX_COUNT_2_TO_EXP = 25;

  D3D_MAJOR_VERSION   = 10;
  D3D_MINOR_VERSION   = 0;
  D3D_SPEC_DATE_DAY   = 8;
  D3D_SPEC_DATE_MONTH = 8;
  D3D_SPEC_DATE_YEAR  = 2006;
  D3D_SPEC_VERSION    = 1.050005;

  WGF_MAJOR_VERSION = 2;
  WGF_MINOR_VERSION = 0;

  _FACD3D10 = $879;
  _FACD3D10DEBUG = _FACD3D10 + 1;


// #define MAKE_D3D10_HRESULT( code )  MAKE_HRESULT( 1, _FACD3D10, code )
function MAKE_D3D10_HRESULT(Code: DWord): DWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM MAKE_D3D10_HRESULT}
//#define MAKE_D3D10_STATUS( code )    MAKE_HRESULT( 0, _FACD3D10, code )
function MAKE_D3D10_STATUS(Code: DWord): DWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM MAKE_D3D10_STATUS}

const
  MAKE_D3D10HRESULT_R     = (1 shl 31) or (_FACD3D10 shl 16);

  D3D10_ERROR_TOO_MANY_UNIQUE_STATE_OBJECTS = HResult(MAKE_D3D10HRESULT_R or 1);
  D3D10_ERROR_FILE_NOT_FOUND                = HResult(MAKE_D3D10HRESULT_R or 2);

type
  D3D10_INPUT_CLASSIFICATION = (
    D3D10_INPUT_PER_VERTEX_DATA{ = 0},
    D3D10_INPUT_PER_INSTANCE_DATA{ = 1}
  );
  TD3D10_InputClassification = D3D10_INPUT_CLASSIFICATION;

const
  D3D10_APPEND_ALIGNED_ELEMENT = $ffffffff;

type
  PD3D10_InputElementDesc = ^TD3D10_InputElementDesc;
  D3D10_INPUT_ELEMENT_DESC = record
    SemanticName: PAnsiChar;
    SemanticIndex: LongWord;
    Format: TDXGI_Format;
    InputSlot: LongWord;
    AlignedByteOffset: LongWord;
    InputSlotClass: TD3D10_InputClassification;
    InstanceDataStepRate: LongWord;
  end;
  TD3D10_InputElementDesc = D3D10_INPUT_ELEMENT_DESC;

  D3D10_FILL_MODE = (
    D3D10_FILL_WIREFRAME = 2,
    D3D10_FILL_SOLID     = 3
  );
  TD3D10_FillMode = D3D10_FILL_MODE;

  D3D10_PRIMITIVE_TOPOLOGY = (
    D3D10_PRIMITIVE_TOPOLOGY_UNDEFINED         = 0,
    D3D10_PRIMITIVE_TOPOLOGY_POINTLIST         = 1,
    D3D10_PRIMITIVE_TOPOLOGY_LINELIST          = 2,
    D3D10_PRIMITIVE_TOPOLOGY_LINESTRIP         = 3,
    D3D10_PRIMITIVE_TOPOLOGY_TRIANGLELIST      = 4,
    D3D10_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP     = 5,
    D3D10_PRIMITIVE_TOPOLOGY_LINELIST_ADJ      = 10,
    D3D10_PRIMITIVE_TOPOLOGY_LINESTRIP_ADJ     = 11,
    D3D10_PRIMITIVE_TOPOLOGY_TRIANGLELIST_ADJ  = 12,
    D3D10_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP_ADJ = 13
  );
  {$EXTERNALSYM D3D10_PRIMITIVE_TOPOLOGY}
  TD3D10_PrimitiveTopology = D3D10_PRIMITIVE_TOPOLOGY;

  D3D10_PRIMITIVE = (
    D3D10_PRIMITIVE_UNDEFINED	= 0,
    D3D10_PRIMITIVE_POINT	= 1,
    D3D10_PRIMITIVE_LINE	= 2,
    D3D10_PRIMITIVE_TRIANGLE	= 3,
    D3D10_PRIMITIVE_LINE_ADJ	= 6,
    D3D10_PRIMITIVE_TRIANGLE_ADJ	= 7
  );
  {$EXTERNALSYM D3D10_PRIMITIVE}
  TD3D10_Primitive = D3D10_PRIMITIVE;

  D3D10_CULL_MODE = (
    D3D10_CULL_NONE  = 1,
    D3D10_CULL_FRONT = 2,
    D3D10_CULL_BACK  = 3
  );
  {$EXTERNALSYM D3D10_CULL_MODE}
  TD3D10_CullMode = D3D10_CULL_MODE;

  PD3D10_SO_DeclarationEntry = ^TD3D10_SO_DeclarationEntry;
  D3D10_SO_DECLARATION_ENTRY = record
    SemanticName: PAnsiChar;
    SemanticIndex: LongWord;
    StartComponent: Byte;
    ComponentCount: Byte;
    OutputSlot: Byte;
  end;
  TD3D10_SO_DeclarationEntry = D3D10_SO_DECLARATION_ENTRY;

  PD3D10_Viewport = ^TD3D10_Viewport;
  D3D10_VIEWPORT = record
    TopLeftX: Longint;
    TopLeftY: Longint;
    Width: LongWord;
    Height: LongWord;
    MinDepth: Single;
    MaxDepth: Single;
  end;
  TD3D10_Viewport = D3D10_VIEWPORT;

  PD3D10_ResourceDimension = ^TD3D10_ResourceDimension;
  D3D10_RESOURCE_DIMENSION = (
    D3D10_RESOURCE_DIMENSION_UNKNOWN{ = 0},
    D3D10_RESOURCE_DIMENSION_BUFFER{ = 1},
    D3D10_RESOURCE_DIMENSION_TEXTURE1D{ = 2},
    D3D10_RESOURCE_DIMENSION_TEXTURE2D{ = 3},
    D3D10_RESOURCE_DIMENSION_TEXTURE3D{ = 4}
  );
  {$EXTERNALSYM D3D10_RESOURCE_DIMENSION}
  TD3D10_ResourceDimension = D3D10_RESOURCE_DIMENSION;

  PD3D10_SRV_Dimension = ^TD3D10_SRV_Dimension;
  D3D10_SRV_DIMENSION = (
    D3D10_SRV_DIMENSION_UNKNOWN{ = 0},
    D3D10_SRV_DIMENSION_BUFFER{= 1},
    D3D10_SRV_DIMENSION_TEXTURE1D{ = 2},
    D3D10_SRV_DIMENSION_TEXTURE1DARRAY{ = 3},
    D3D10_SRV_DIMENSION_TEXTURE2D{ = 4},
    D3D10_SRV_DIMENSION_TEXTURE2DARRAY{ = 5},
    D3D10_SRV_DIMENSION_TEXTURE2DMS{ = 6},
    D3D10_SRV_DIMENSION_TEXTURE2DMSARRAY{ = 7},
    D3D10_SRV_DIMENSION_TEXTURE3D{ = 8},
    D3D10_SRV_DIMENSION_TEXTURECUBE{ = 9}
  );
  {$EXTERNALSYM D3D10_SRV_DIMENSION}
  TD3D10_SRV_Dimension = D3D10_SRV_DIMENSION;

  PD3D10_DSV_Dimension = ^TD3D10_DSV_Dimension;
  D3D10_DSV_DIMENSION = (
    D3D10_DSV_DIMENSION_UNKNOWN{ = 0},
    D3D10_DSV_DIMENSION_TEXTURE1D{ = 1},
    D3D10_DSV_DIMENSION_TEXTURE1DARRAY{ = 2},
    D3D10_DSV_DIMENSION_TEXTURE2D{ = 3},
    D3D10_DSV_DIMENSION_TEXTURE2DARRAY{ = 4},
    D3D10_DSV_DIMENSION_TEXTURE2DMS{ = 5},
    D3D10_DSV_DIMENSION_TEXTURE2DMSARRAY{ = 6}
  );
  {$EXTERNALSYM D3D10_DSV_DIMENSION}
  TD3D10_DSV_Dimension = D3D10_DSV_DIMENSION;

  PD3D10_RTV_Dimension = ^TD3D10_RTV_Dimension;
  D3D10_RTV_DIMENSION = (
    D3D10_RTV_DIMENSION_UNKNOWN{ = 0},
    D3D10_RTV_DIMENSION_BUFFER{ = 1},
    D3D10_RTV_DIMENSION_TEXTURE1D{ = 2},
    D3D10_RTV_DIMENSION_TEXTURE1DARRAY{ = 3},
    D3D10_RTV_DIMENSION_TEXTURE2D{ = 4},
    D3D10_RTV_DIMENSION_TEXTURE2DARRAY{ = 5},
    D3D10_RTV_DIMENSION_TEXTURE2DMS{ = 6},
    D3D10_RTV_DIMENSION_TEXTURE2DMSARRAY{ = 7},
    D3D10_RTV_DIMENSION_TEXTURE3D{ = 8}
  );
  {$EXTERNALSYM D3D10_RTV_DIMENSION}
  TD3D10_RTV_Dimension = D3D10_RTV_DIMENSION;

  D3D10_USAGE = (
    D3D10_USAGE_DEFAULT{ = 0},
    D3D10_USAGE_IMMUTABLE{ = 1},
    D3D10_USAGE_DYNAMIC{ = 2},
    D3D10_USAGE_STAGING{ = 3}
  );
  TD3D10_Usage = D3D10_USAGE;

  D3D10_BIND_FLAG = LongWord;
  {$EXTERNALSYM D3D10_BIND_FLAG}
  TD3D10_BindFlag = D3D10_BIND_FLAG;
const
  D3D10_BIND_VERTEX_BUFFER   = $1;
  {$EXTERNALSYM D3D10_BIND_VERTEX_BUFFER}
  D3D10_BIND_INDEX_BUFFER    = $2;
  {$EXTERNALSYM D3D10_BIND_INDEX_BUFFER}
  D3D10_BIND_CONSTANT_BUFFER = $4;
  {$EXTERNALSYM D3D10_BIND_CONSTANT_BUFFER}
  D3D10_BIND_SHADER_RESOURCE = $8;
  {$EXTERNALSYM D3D10_BIND_SHADER_RESOURCE}
  D3D10_BIND_STREAM_OUTPUT   = $10;
  {$EXTERNALSYM D3D10_BIND_STREAM_OUTPUT}
  D3D10_BIND_RENDER_TARGET   = $20;
  {$EXTERNALSYM D3D10_BIND_RENDER_TARGET}
  D3D10_BIND_DEPTH_STENCIL   = $40;
  {$EXTERNALSYM D3D10_BIND_DEPTH_STENCIL}

type
  D3D10_CPU_ACCESS_FLAG = LongWord;
  {$EXTERNALSYM D3D10_CPU_ACCESS_FLAG}
  TD3D10_CpuAccessFlag = D3D10_CPU_ACCESS_FLAG;
const
  D3D10_CPU_ACCESS_WRITE = $10000;
  {$EXTERNALSYM D3D10_CPU_ACCESS_WRITE}
  D3D10_CPU_ACCESS_READ  = $20000;
  {$EXTERNALSYM D3D10_CPU_ACCESS_READ}

type
  D3D10_RESOURCE_MISC_FLAG = LongWord;
  {$EXTERNALSYM D3D10_RESOURCE_MISC_FLAG}
  TD3D10_RresourceMiscFlag = D3D10_RESOURCE_MISC_FLAG;
const
  D3D10_RESOURCE_MISC_GENERATE_MIPS    = $1;
  {$EXTERNALSYM D3D10_RESOURCE_MISC_GENERATE_MIPS}
  D3D10_RESOURCE_MISC_SHARED	         = $2;
  {$EXTERNALSYM D3D10_RESOURCE_MISC_SHARED}
  D3D10_RESOURCE_MISC_TEXTURECUBE	     = $4;
  {$EXTERNALSYM D3D10_RESOURCE_MISC_TEXTURECUBE}
	D3D10_RESOURCE_MISC_SHARED_KEYEDMUTEX	= $10;
  {$EXTERNALSYM D3D10_RESOURCE_MISC_SHARED_KEYEDMUTEX}
	D3D10_RESOURCE_MISC_GDI_COMPATIBLE   = $20;
  {$EXTERNALSYM D3D10_RESOURCE_MISC_GDI_COMPATIBLE}

type
  D3D10_MAP = (
    D3D10_MAP_READ = 1,
    D3D10_MAP_WRITE = 2,
    D3D10_MAP_READ_WRITE = 3,
    D3D10_MAP_WRITE_DISCARD = 4,
    D3D10_MAP_WRITE_NO_OVERWRITE = 5
  );
  {$EXTERNALSYM D3D10_MAP}
  TD3D10_Map = D3D10_MAP;

  D3D10_MAP_FLAG = (
    D3D10_MAP_FLAG_DO_NOT_WAIT = $100000
  );
  {$EXTERNALSYM D3D10_MAP_FLAG}
  TD3D10_MapFlag = D3D10_MAP_FLAG;

  D3D10_RAISE_FLAG = (
    D3D10_RAISE_FLAG_DRIVER_INTERNAL_ERROR = $1
  );
  {$EXTERNALSYM D3D10_RAISE_FLAG}
  TD3D10_RaiseFlag = D3D10_RAISE_FLAG;

type
  D3D10_CLEAR_FLAG = LongWord;
  {$EXTERNALSYM D3D10_CLEAR_FLAG}
  TD3D10_ClearFlag = D3D10_CLEAR_FLAG;

const
  D3D10_CLEAR_DEPTH     = TD3D10_ClearFlag($1);
  {$EXTERNALSYM D3D10_CLEAR_DEPTH}
  D3D10_CLEAR_STENCIL   = TD3D10_ClearFlag($2);
  {$EXTERNALSYM D3D10_CLEAR_STENCIL}

type
  D3D10_RECT = TRect;
  {$EXTERNALSYM D3D10_RECT}
  TD3D10_Rect = TRect;
  PD3D10_Rect = ^TD3D10_Rect;

  PD3D10_Box = ^TD3D10_Box;
  D3D10_BOX = record
    left: LongWord;
    top: LongWord;
    front: LongWord;
    right: LongWord;
    bottom: LongWord;
    back: LongWord;
  end;
  {$EXTERNALSYM D3D10_BOX}
  TD3D10_Box = D3D10_BOX;


type
  D3D10_FORMAT_SUPPORT = LongWord;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT}
  TD3D10_FormatSupport = D3D10_FORMAT_SUPPORT;

const
  D3D10_FORMAT_SUPPORT_BUFFER                     = $1;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_BUFFER}
  D3D10_FORMAT_SUPPORT_IA_VERTEX_BUFFER           = $2;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_IA_VERTEX_BUFFER}
  D3D10_FORMAT_SUPPORT_IA_INDEX_BUFFER            = $4;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_IA_INDEX_BUFFER}
  D3D10_FORMAT_SUPPORT_SO_BUFFER                  = $8;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_SO_BUFFER}
  D3D10_FORMAT_SUPPORT_TEXTURE1D                  = $10;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_TEXTURE1D}
  D3D10_FORMAT_SUPPORT_TEXTURE2D                  = $20;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_TEXTURE2D}
  D3D10_FORMAT_SUPPORT_TEXTURE3D                  = $40;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_TEXTURE3D}
  D3D10_FORMAT_SUPPORT_TEXTURECUBE                = $80;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_TEXTURECUBE}
  D3D10_FORMAT_SUPPORT_SHADER_LOAD                = $100;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_SHADER_LOAD}
  D3D10_FORMAT_SUPPORT_SHADER_SAMPLE              = $200;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_SHADER_SAMPLE}
  D3D10_FORMAT_SUPPORT_SHADER_SAMPLE_COMPARISON   = $400;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_SHADER_SAMPLE_COMPARISON}
  D3D10_FORMAT_SUPPORT_SHADER_SAMPLE_MONO_TEXT    = $800;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_SHADER_SAMPLE_MONO_TEXT}
  D3D10_FORMAT_SUPPORT_MIP                        = $1000;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_MIP}
  D3D10_FORMAT_SUPPORT_MIP_AUTOGEN                = $2000;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_MIP_AUTOGEN}
  D3D10_FORMAT_SUPPORT_RENDER_TARGET              = $4000;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_RENDER_TARGET}
  D3D10_FORMAT_SUPPORT_BLENDABLE                  = $8000;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_BLENDABLE}
  D3D10_FORMAT_SUPPORT_DEPTH_STENCIL              = $10000;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_DEPTH_STENCIL}
  D3D10_FORMAT_SUPPORT_CPU_LOCKABLE               = $20000;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_CPU_LOCKABLE}
  D3D10_FORMAT_SUPPORT_MULTISAMPLE_RESOLVE        = $40000;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_MULTISAMPLE_RESOLVE}
  D3D10_FORMAT_SUPPORT_DISPLAY                    = $80000;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_DISPLAY}
  D3D10_FORMAT_SUPPORT_CAST_WITHIN_BIT_LAYOUT     = $100000;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_CAST_WITHIN_BIT_LAYOUT}
  D3D10_FORMAT_SUPPORT_MULTISAMPLE_RENDERTARGET	  = $200000;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_MULTISAMPLE_RENDERTARGET}
  D3D10_FORMAT_SUPPORT_MULTISAMPLE_LOAD	          = $400000;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_MULTISAMPLE_LOAD}
  D3D10_FORMAT_SUPPORT_SHADER_GATHER              = $800000;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_SHADER_GATHER}
	D3D10_FORMAT_SUPPORT_BACK_BUFFER_CAST	          = $1000000;
  {$EXTERNALSYM D3D10_FORMAT_SUPPORT_BACK_BUFFER_CAST}


type
  ID3D10DeviceChild = interface;
  ID3D10DepthStencilState = interface;
  ID3D10BlendState = interface;
  ID3D10RasterizerState = interface;
  ID3D10Resource = interface;
  ID3D10Buffer = interface;
  ID3D10Texture1D = interface;
  ID3D10Texture2D = interface;
  ID3D10Texture3D = interface;
  ID3D10View = interface;
  ID3D10ShaderResourceView = interface;
  ID3D10RenderTargetView = interface;
  ID3D10DepthStencilView = interface;
  ID3D10VertexShader = interface;
  ID3D10GeometryShader = interface;
  ID3D10PixelShader = interface;
  ID3D10InputLayout = interface;
  ID3D10SamplerState = interface;
  ID3D10Asynchronous = interface;
  ID3D10Query = interface;
  ID3D10Predicate = interface;
  ID3D10Counter = interface;
  ID3D10Device = interface;
  ID3D10Multithread = interface;


  PID3D10DeviceChild = ^ID3D10DeviceChild;
  PID3D10DepthStencilState = ^ID3D10DepthStencilState;
  PID3D10BlendState = ^ID3D10BlendState;
  PID3D10RasterizerState = ^ID3D10RasterizerState;
  PID3D10Resource = ^ID3D10Resource;
  PID3D10Buffer = ^ID3D10Buffer;
  PID3D10Texture1D = ^ID3D10Texture1D;
  PID3D10Texture2D = ^ID3D10Texture2D;
  PID3D10Texture3D = ^ID3D10Texture3D;
  PID3D10View = ^ID3D10View;
  PID3D10ShaderResourceView = ^ID3D10ShaderResourceView;
  PID3D10RenderTargetView = ^ID3D10RenderTargetView;
  PID3D10DepthStencilView = ^ID3D10DepthStencilView;
  PID3D10VertexShader = ^ID3D10VertexShader;
  PID3D10GeometryShader = ^ID3D10GeometryShader;
  PID3D10PixelShader = ^ID3D10PixelShader;
  PID3D10InputLayout = ^ID3D10InputLayout;
  PID3D10SamplerState = ^ID3D10SamplerState;
  PID3D10Asynchronous = ^ID3D10Asynchronous;
  PID3D10Query = ^ID3D10Query;
  PID3D10Predicate = ^ID3D10Predicate;
  PID3D10Counter = ^ID3D10Counter;
  PID3D10Device = ^ID3D10Device;
  PID3D10Multithread = ^ID3D10Multithread;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10DeviceChild);'}
  {$EXTERNALSYM ID3D10DeviceChild}
  ID3D10DeviceChild = interface (IUnknown)
    ['{9B7E4C00-342C-4106-A19F-4F2704F689F0}']
    procedure GetDevice(
            (* [retval][out] *) out ppDevice: ID3D10Device); stdcall;

    function GetPrivateData(
            (* __in *) const guid: TGUID;
            (* __inout *) var pDataSize: LongWord;
            (* __out_bcount_opt(*pDataSize) *) pData: Pointer): HResult; stdcall;

    function SetPrivateData(
            (* __in *) const guid: TGUID;
            (* __in *) DataSize: LongWord;
            (* __in_bcount_opt(DataSize) *) pData: Pointer): HResult; stdcall;

    function SetPrivateDataInterface(
            (* __in *) const guid: TGUID;
            (* __in_opt *) const pData: IUnknown): HResult; stdcall;
  end;

  IID_ID3D10DeviceChild = ID3D10DeviceChild;
  {$EXTERNALSYM IID_ID3D10DeviceChild}



  D3D10_COMPARISON_FUNC = (
    D3D10_COMPARISON_NEVER         = 1,
    D3D10_COMPARISON_LESS          = 2,
    D3D10_COMPARISON_EQUAL         = 3,
    D3D10_COMPARISON_LESS_EQUAL    = 4,
    D3D10_COMPARISON_GREATER       = 5,
    D3D10_COMPARISON_NOT_EQUAL     = 6,
    D3D10_COMPARISON_GREATER_EQUAL = 7,
    D3D10_COMPARISON_ALWAYS        = 8
  );
  {$EXTERNALSYM D3D10_COMPARISON_FUNC}
  TD3D10_ComparisonFunc = D3D10_COMPARISON_FUNC;

  D3D10_DEPTH_WRITE_MASK = (
    D3D10_DEPTH_WRITE_MASK_ZERO = 0,
    D3D10_DEPTH_WRITE_MASK_ALL  = 1
  );
  {$EXTERNALSYM D3D10_DEPTH_WRITE_MASK}
  TD3D10_DepthWriteMask  = D3D10_DEPTH_WRITE_MASK;

  D3D10_STENCIL_OP = (
    D3D10_STENCIL_OP_KEEP     = 1,
    D3D10_STENCIL_OP_ZERO     = 2,
    D3D10_STENCIL_OP_REPLACE  = 3,
    D3D10_STENCIL_OP_INCR_SAT = 4,
    D3D10_STENCIL_OP_DECR_SAT = 5,
    D3D10_STENCIL_OP_INVERT   = 6,
    D3D10_STENCIL_OP_INCR     = 7,
    D3D10_STENCIL_OP_DECR     = 8
  );
  {$EXTERNALSYM D3D10_STENCIL_OP}
  TD3D10_StencilOp = D3D10_STENCIL_OP;

  D3D10_DEPTH_STENCILOP_DESC = record
    StencilFailOp: TD3D10_StencilOp;
    StencilDepthFailOp: TD3D10_StencilOp;
    StencilPassOp: TD3D10_StencilOp;
    StencilFunc: TD3D10_ComparisonFunc;
  end;
  {$EXTERNALSYM D3D10_DEPTH_STENCILOP_DESC}
  TD3D10_DepthStencilOpDesc = D3D10_DEPTH_STENCILOP_DESC;

  D3D10_DEPTH_STENCIL_DESC = record
    DepthEnable: BOOL;
    DepthWriteMask: TD3D10_DepthWriteMask;
    DepthFunc: TD3D10_ComparisonFunc;
    StencilEnable: BOOL;
    StencilReadMask: Byte;
    StencilWriteMask: Byte;
    FrontFace: TD3D10_DepthStencilOpDesc;
    BackFace: TD3D10_DepthStencilOpDesc;
  end;
  {$EXTERNALSYM D3D10_DEPTH_STENCIL_DESC}
  TD3D10_DepthStencilDesc = D3D10_DEPTH_STENCIL_DESC;



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10DepthStencilState);'}
  {$EXTERNALSYM ID3D10DepthStencilState}
  ID3D10DepthStencilState = interface (ID3D10DeviceChild)
    ['{2B4B1CC8-A4AD-41f8-8322-CA86FC3EC675}']
    procedure GetDesc(
            (* [retval][out] *) out pDesc: TD3D10_DepthStencilDesc); stdcall;
  end;

  IID_ID3D10DepthStencilState = ID3D10DepthStencilState;
  {$EXTERNALSYM IID_ID3D10DepthStencilState}

  PD3D10_Blend = ^TD3D10_Blend;
  D3D10_BLEND = (
    D3D10_BLEND_ZERO             = 1,
    D3D10_BLEND_ONE              = 2,
    D3D10_BLEND_SRC_COLOR        = 3,
    D3D10_BLEND_INV_SRC_COLOR    = 4,
    D3D10_BLEND_SRC_ALPHA        = 5,
    D3D10_BLEND_INV_SRC_ALPHA    = 6,
    D3D10_BLEND_DEST_ALPHA       = 7,
    D3D10_BLEND_INV_DEST_ALPHA   = 8,
    D3D10_BLEND_DEST_COLOR       = 9,
    D3D10_BLEND_INV_DEST_COLOR   = 10,
    D3D10_BLEND_SRC_ALPHA_SAT    = 11,
    D3D10_BLEND_BLEND_FACTOR     = 14,
    D3D10_BLEND_INV_BLEND_FACTOR = 15,
    D3D10_BLEND_SRC1_COLOR       = 16,
    D3D10_BLEND_INV_SRC1_COLOR   = 17,
    D3D10_BLEND_SRC1_ALPHA       = 18,
    D3D10_BLEND_INV_SRC1_ALPHA   = 19
  );
  {$EXTERNALSYM D3D10_BLEND}
  TD3D10_Blend = D3D10_BLEND;

  D3D10_BLEND_OP = (
    D3D10_BLEND_OP_ADD          = 1,
    D3D10_BLEND_OP_SUBTRACT     = 2,
    D3D10_BLEND_OP_REV_SUBTRACT = 3,
    D3D10_BLEND_OP_MIN          = 4,
    D3D10_BLEND_OP_MAX          = 5
  );
  {$EXTERNALSYM D3D10_BLEND_OP}
  TD3D10_BlendOp = D3D10_BLEND_OP;

  D3D10_COLOR_WRITE_ENABLE = (
    D3D10_COLOR_WRITE_ENABLE_RED   = 1,
    D3D10_COLOR_WRITE_ENABLE_GREEN = 2,
    D3D10_COLOR_WRITE_ENABLE_BLUE  = 4,
    D3D10_COLOR_WRITE_ENABLE_ALPHA = 8,
    D3D10_COLOR_WRITE_ENABLE_ALL   = D3D10_COLOR_WRITE_ENABLE_RED +
                                     D3D10_COLOR_WRITE_ENABLE_GREEN +
                                     D3D10_COLOR_WRITE_ENABLE_BLUE +
                                     D3D10_COLOR_WRITE_ENABLE_ALPHA
  );
  {$EXTERNALSYM D3D10_COLOR_WRITE_ENABLE}
  TD3D10_ColorWriteEnable = D3D10_COLOR_WRITE_ENABLE;

  D3D10_BLEND_DESC = record
    AlphaToCoverageEnable: BOOL;
    BlendEnable: array[0..7] of BOOL;
    SrcBlend: TD3D10_Blend;
    DestBlend: TD3D10_Blend;
    BlendOp: TD3D10_BlendOp;
    SrcBlendAlpha: TD3D10_Blend;
    DestBlendAlpha: TD3D10_Blend;
    BlendOpAlpha: TD3D10_Blend;
    RenderTargetWriteMask: array[0..7] of Byte;
  end;
  {$EXTERNALSYM D3D10_BLEND_DESC}
  TD3D10_BlendDesc = D3D10_BLEND_DESC;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10BlendState);'}
  {$EXTERNALSYM ID3D10BlendState}
  ID3D10BlendState = interface (ID3D10DeviceChild)
    ['{EDAD8D19-8A35-4d6d-8566-2EA276CDE161}']
    procedure GetDesc(
            (* [retval][out] *) out pDesc: TD3D10_BlendDesc); stdcall;
  end;

  IID_ID3D10BlendState = ID3D10BlendState;
  {$EXTERNALSYM IID_ID3D10BlendState}


  D3D10_RASTERIZER_DESC = record
    FillMode: TD3D10_FillMode;
    CullMode: TD3D10_CullMode;
    FrontCounterClockwise: BOOL;
    DepthBias: Longint;
    DepthBiasClamp: Single;
    SlopeScaledDepthBias: Single;
    DepthClipEnable: BOOL;
    ScissorEnable: BOOL;
    MultisampleEnable: BOOL;
    AntialiasedLineEnable: BOOL;
  end;
  {$EXTERNALSYM D3D10_RASTERIZER_DESC}
  TD3D10_RasterizerDesc = D3D10_RASTERIZER_DESC;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10RasterizerState);'}
  {$EXTERNALSYM ID3D10RasterizerState}
  ID3D10RasterizerState = interface (ID3D10DeviceChild)
    ['{A2A07292-89AF-4345-BE2E-C53D9FBB6E9F}']
    procedure GetDesc(
            (* [retval][out] *) out pDesc: TD3D10_RasterizerDesc); stdcall;
  end;

  IID_ID3D10RasterizerState = ID3D10RasterizerState;
  {$EXTERNALSYM IID_ID3D10RasterizerState}


  PD3D10_SubresourceData = ^TD3D10_SubresourceData;
  D3D10_SUBRESOURCE_DATA = record
    pSysMem: {const} Pointer;
    SysMemPitch: LongWord;
    SysMemSlicePitch: LongWord;
  end;
  {$EXTERNALSYM D3D10_SUBRESOURCE_DATA}
  TD3D10_SubresourceData = D3D10_SUBRESOURCE_DATA;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10Resource);'}
  {$EXTERNALSYM ID3D10Resource}
  ID3D10Resource = interface (ID3D10DeviceChild)
    ['{9B7E4C01-342C-4106-A19F-4F2704F689F0}']
    function GetType(
            (* [out] *) out rType: TD3D10_ResourceDimension): HResult; stdcall;

    function SetEvictionPriority(
            (* [in] *) EvictionPriority: LongWord): HResult; stdcall;

    function GetEvictionPriority(): LongWord; stdcall;
  end;

  IID_ID3D10Resource = ID3D10Resource;
  {$EXTERNALSYM IID_ID3D10Resource}


  D3D10_BUFFER_DESC = record
    ByteWidth: LongWord;
    Usage: TD3D10_Usage;
    BindFlags: TD3D10_BindFlag; //Clootie: changed from LongWord;
    CPUAccessFlags: TD3D10_CpuAccessFlag; //Clootie: changed from LongWord;
    MiscFlags: LongWord;
  end;
  TD3D10_BufferDesc = D3D10_BUFFER_DESC;

{$IFNDEF D3D10_NO_HELPERS}
#if !defined( D3D10_NO_HELPERS ) && defined( __cplusplus )
struct CD3D10_BUFFER_DESC : public D3D10_BUFFER_DESC
{
    CD3D10_BUFFER_DESC()
    {}
    explicit CD3D10_BUFFER_DESC( const D3D10_BUFFER_DESC& o ) :
        D3D10_BUFFER_DESC( o )
    {}
    explicit CD3D10_BUFFER_DESC(
        UINT byteWidth,
        UINT bindFlags,
        D3D10_USAGE usage = D3D10_USAGE_DEFAULT,
        UINT cpuaccessFlags = 0,
        UINT miscFlags = 0 )
    {
        ByteWidth = byteWidth;
        Usage = usage;
        BindFlags = bindFlags;
        CPUAccessFlags = cpuaccessFlags ;
        MiscFlags = miscFlags;
    }
    ~CD3D10_BUFFER_DESC() {}
    operator const D3D10_BUFFER_DESC&() const { return *this; }
};
{$ENDIF}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10Buffer);'}
  {$EXTERNALSYM ID3D10Buffer}
  ID3D10Buffer = interface (ID3D10Resource)
    ['{9B7E4C02-342C-4106-A19F-4F2704F689F0}']
    function Map(
            (* [in] *) MapType: TD3D10_Map;
            (* [in] *) MapFlags: LongWord;
            (* [out] *) out ppData: Pointer): HResult; stdcall;

    procedure Unmap(); stdcall;

    procedure GetDesc(
            (* [retval][out] *) out pDesc: TD3D10_BufferDesc); stdcall;
  end;

  IID_ID3D10Buffer = ID3D10Buffer;
  {$EXTERNALSYM IID_ID3D10Buffer}



  D3D10_TEXTURE1D_DESC = record
    Width: SIZE_T;
    MipLevels: LongWord;
    ArraySize: LongWord;
    Format: DXGI_FORMAT;
    SampleDesc: DXGI_SAMPLE_DESC;
    Usage: D3D10_USAGE;
    BindFlags: LongWord;
    CPUAccessFlags: LongWord;
    MiscFlags: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEXTURE1D_DESC}
  TD3D10_Texture1DDesc = D3D10_TEXTURE1D_DESC;

{$IFNDEF D3D10_NO_HELPERS}
struct CD3D10_TEXTURE1D_DESC : public D3D10_TEXTURE1D_DESC
{
    CD3D10_TEXTURE1D_DESC()
    {}
    explicit CD3D10_TEXTURE1D_DESC( const D3D10_TEXTURE1D_DESC& o ) :
        D3D10_TEXTURE1D_DESC( o )
    {}
    explicit CD3D10_TEXTURE1D_DESC(
        DXGI_FORMAT format,
        UINT width,
        UINT arraySize = 1,
        UINT mipLevels = 0,
        UINT bindFlags = D3D10_BIND_SHADER_RESOURCE,
        D3D10_USAGE usage = D3D10_USAGE_DEFAULT,
        UINT cpuaccessFlags= 0,
        UINT miscFlags = 0 )
    {
        Width = width;
        MipLevels = mipLevels;
        ArraySize = arraySize;
        Format = format;
        Usage = usage;
        BindFlags = bindFlags;
        CPUAccessFlags = cpuaccessFlags;
        MiscFlags = miscFlags;
    }
    ~CD3D10_TEXTURE1D_DESC() {}
    operator const D3D10_TEXTURE1D_DESC&() const { return *this; }
};
{$ENDIF}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10Texture1D);'}
  {$EXTERNALSYM ID3D10Texture1D}
  ID3D10Texture1D = interface (ID3D10Resource)
    ['{9B7E4C03-342C-4106-A19F-4F2704F689F0}']

    function Map(
            (* [in] *) Subresource: LongWord;
            (* [in] *) MapType: TD3D10_Map;
            (* [in] *) MapFlags: LongWord;
            (* [out] *) out ppData: Pointer): HResult; stdcall;

    procedure Unmap(
            (* [in] *) Subresource: LongWord); stdcall;

    procedure GetDesc(
            (* [retval][out] *) out pDesc: TD3D10_Texture1DDesc); stdcall;
  end;

  IID_ID3D10Texture1D = ID3D10Texture1D;
  {$EXTERNALSYM IID_ID3D10Texture1D}



  D3D10_TEXTURE2D_DESC = record
    Width: LongWord;
    Height: LongWord;
    MipLevels: LongWord;
    ArraySize: LongWord;
    Format: TDXGI_Format;
    SampleDesc: TDXGI_SampleDesc;
    Usage: TD3D10_Usage;
    BindFlags: LongWord;
    CPUAccessFlags: LongWord;
    MiscFlags: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEXTURE2D_DESC}
  TD3D10_Texture2DDesc = D3D10_TEXTURE2D_DESC;

{$IFNDEF D3D10_NO_HELPERS}
struct CD3D10_TEXTURE2D_DESC : public D3D10_TEXTURE2D_DESC
{
    CD3D10_TEXTURE2D_DESC()
    {}
    explicit CD3D10_TEXTURE2D_DESC( const D3D10_TEXTURE2D_DESC& o ) :
        D3D10_TEXTURE2D_DESC( o )
    {}
    explicit CD3D10_TEXTURE2D_DESC(
        DXGI_FORMAT format,
        UINT width,
        UINT height,
        UINT arraySize = 1,
        UINT mipLevels = 0,
        UINT bindFlags = D3D10_BIND_SHADER_RESOURCE,
        D3D10_USAGE usage = D3D10_USAGE_DEFAULT,
        UINT cpuaccessFlags = 0,
        UINT sampleCount = 1,
        UINT sampleQuality = 0,
        UINT miscFlags = 0 )
    {
        Width = width;
        Height = height;
        MipLevels = mipLevels;
        ArraySize = arraySize;
        Format = format;
        SampleDesc.Count = sampleCount;
        SampleDesc.Quality = sampleQuality;
        Usage = usage;
        BindFlags = bindFlags;
        CPUAccessFlags = cpuaccessFlags;
        MiscFlags = miscFlags;
    }
    ~CD3D10_TEXTURE2D_DESC() {}
    operator const D3D10_TEXTURE2D_DESC&() const { return *this; }
};
{$ENDIF}

  D3D10_MAPPED_TEXTURE2D = record
    pData: Pointer;
    RowPitch: LongWord;
  end;
  {$EXTERNALSYM D3D10_MAPPED_TEXTURE2D}
  TD3D10_MappedTexture2D = D3D10_MAPPED_TEXTURE2D;



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10Texture2D);'}
  {$EXTERNALSYM ID3D10Texture2D}
  ID3D10Texture2D = interface (ID3D10Resource)
    ['{9B7E4C04-342C-4106-A19F-4F2704F689F0}']
    function Map(
            (* [in] *) Subresource: LongWord;
            (* [in] *) MapType: D3D10_MAP;
            (* [in] *) MapFlags: LongWord;
            (* [out] *) out pMappedTex2D: TD3D10_MappedTexture2D): HResult; stdcall;

    procedure Unmap(
            (* [in] *) Subresource: LongWord); stdcall;

    procedure GetDesc(
            (* [retval][out] *) out pDesc: TD3D10_Texture2DDesc); stdcall;
  end;

  IID_ID3D10Texture2D = ID3D10Texture2D;
  {$EXTERNALSYM IID_ID3D10Texture2D}


  D3D10_TEXTURE3D_DESC = record
    Width: LongWord;
    Height: LongWord;
    Depth: LongWord;
    MipLevels: LongWord;
    Format: TDXGI_Format;
    SampleDesc: TDXGI_SampleDesc;
    Usage: TD3D10_Usage;
    BindFlags: LongWord;
    CPUAccessFlags: LongWord;
    MiscFlags: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEXTURE3D_DESC}
  TD3D10_Texture3DDesc = D3D10_TEXTURE3D_DESC;

{$IFNDEF D3D10_NO_HELPERS}
struct CD3D10_TEXTURE3D_DESC : public D3D10_TEXTURE3D_DESC
{
    CD3D10_TEXTURE3D_DESC()
    {}
    explicit CD3D10_TEXTURE3D_DESC( const D3D10_TEXTURE3D_DESC& o ) :
        D3D10_TEXTURE3D_DESC( o )
    {}
    explicit CD3D10_TEXTURE3D_DESC(
        DXGI_FORMAT format,
        UINT width,
        UINT height,
        UINT depth,
        UINT mipLevels = 0,
        UINT bindFlags = D3D10_BIND_SHADER_RESOURCE,
        D3D10_USAGE usage = D3D10_USAGE_DEFAULT,
        UINT cpuaccessFlags = 0,
        UINT sampleCount = 1,
        UINT sampleQuality = 0,
        UINT miscFlags = 0 )
    {
        Width = width;
        Height = height;
        Depth = depth;
        MipLevels = mipLevels;
        Format = format;
        SampleDesc.Count = sampleCount;
        SampleDesc.Quality = sampleQuality;
        Usage = usage;
        BindFlags = bindFlags;
        CPUAccessFlags = cpuaccessFlags;
        MiscFlags = miscFlags;
    }
    ~CD3D10_TEXTURE3D_DESC() {}
    operator const D3D10_TEXTURE3D_DESC&() const { return *this; }
};
{$ENDIF}

  D3D10_MAPPED_TEXTURE3D = record
    pData: Pointer;
    RowPitch: LongWord;
    DepthPitch: LongWord;
  end;
  {$EXTERNALSYM D3D10_MAPPED_TEXTURE3D}
  TD3D10_MappedTexture3D = D3D10_MAPPED_TEXTURE3D;



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10Texture3D);'}
  {$EXTERNALSYM ID3D10Texture3D}
  ID3D10Texture3D = interface (ID3D10Resource)
    ['{9B7E4C05-342C-4106-A19F-4F2704F689F0}']
    function Map(
            (* [in] *) Subresource: LongWord;
            (* [in] *) MapType: D3D10_MAP;
            (* [in] *) MapFlags: LongWord;
            (* [out] *) out pMappedTex3D: TD3D10_MappedTexture2D): HResult; stdcall;

    procedure Unmap(
            (* [in] *) Subresource: LongWord); stdcall;

    procedure GetDesc(
            (* [retval][out] *) out pDesc: TD3D10_Texture3DDesc); stdcall;
  end;

  IID_ID3D10Texture3D = ID3D10Texture3D;
  {$EXTERNALSYM IID_ID3D10Texture3D}


  D3D10_TEXTURECUBE_FACE = (
    D3D10_TEXTURECUBE_FACE_POSITIVE_X{ = 0},
    D3D10_TEXTURECUBE_FACE_NEGATIVE_X{ = 1},
    D3D10_TEXTURECUBE_FACE_POSITIVE_Y{ = 2},
    D3D10_TEXTURECUBE_FACE_NEGATIVE_Y{ = 3},
    D3D10_TEXTURECUBE_FACE_POSITIVE_Z{ = 4},
    D3D10_TEXTURECUBE_FACE_NEGATIVE_Z{ = 5}
  );
  {$EXTERNALSYM D3D10_TEXTURECUBE_FACE}
  TD3D10_TextureCubeFace = D3D10_TEXTURECUBE_FACE;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10View);'}
  {$EXTERNALSYM ID3D10View}
  ID3D10View = interface (ID3D10DeviceChild)
    ['{C902B03F-60A7-49BA-9936-2A3AB37A7E33}']
    procedure GetResource(
            (* [retval][out] *) out ppResource: ID3D10Resource); stdcall;
  end;

  IID_ID3D10View = ID3D10View;
  {$EXTERNALSYM IID_ID3D10View}


  D3D10_BUFFER_SRV = record
  case Byte of
    0: (
      ElementOffset: LongWord;
      ElementWidth: LongWord;
    );
   1: (
      FirstElement: LongWord;
      NumElements: LongWord;
    );
  end;
  {$EXTERNALSYM D3D10_BUFFER_SRV}
  TD3D10_Buffer_SRV = D3D10_BUFFER_SRV;

  D3D10_TEX1D_SRV = record
    MostDetailedMip: LongWord;
    MipLevels: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX1D_SRV}
  TD3D10_Tex1D_SRV = D3D10_TEX1D_SRV;

  D3D10_TEX1D_ARRAY_SRV = record
    MostDetailedMip: LongWord;
    MipLevels: LongWord;
    FirstArraySlice: LongWord;
    ArraySize: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX1D_ARRAY_SRV}
  TD3D10_Tex1DArraySRV = D3D10_TEX1D_ARRAY_SRV;

  D3D10_TEX2D_SRV = record
    MostDetailedMip: LongWord;
    MipLevels: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX2D_SRV}
  TD3D10_Tex2D_SRV = D3D10_TEX2D_SRV;

  D3D10_TEX2D_ARRAY_SRV = record
    MostDetailedMip: LongWord;
    MipLevels: LongWord;
    FirstArraySlice: LongWord;
    ArraySize: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX2D_ARRAY_SRV}
  TD3D10_Tex2DArraySRV = D3D10_TEX2D_ARRAY_SRV;

  D3D10_TEX3D_SRV = record
    MostDetailedMip: LongWord;
    MipLevels: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX3D_SRV}
  TD3D10_Tex3D_SRV = D3D10_TEX3D_SRV;

  D3D10_TEXCUBE_SRV = record
    MostDetailedMip: LongWord;
    MipLevels: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEXCUBE_SRV}
  TD3D10_TexCube_SRV = D3D10_TEXCUBE_SRV;

  D3D10_TEX2DMS_SRV = record
    UnusedField_NothingToDefine: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX2DMS_SRV}
  TD3D10_Tex2DMS_SRV = D3D10_TEX2DMS_SRV;

  D3D10_TEX2DMS_ARRAY_SRV = record
  {$EXTERNALSYM D3D10_TEX2DMS_ARRAY_SRV}
    FirstArraySlice: LongWord;
    ArraySize: LongWord;
  end;

  PD3D10_ShaderResourceViewDesc = ^TD3D10_ShaderResourceViewDesc;
  D3D10_SHADER_RESOURCE_VIEW_DESC = record
    Format: TDXGI_Format;
    ViewDimension: D3D10_SRV_DIMENSION;
    case Byte of
      0: (Buffer: TD3D10_Buffer_SRV);
      1: (Texture1D: TD3D10_Tex1D_SRV);
      2: (Texture1DArray: D3D10_TEX1D_ARRAY_SRV);
      3: (Texture2D: TD3D10_Tex2D_SRV);
      4: (Texture2DArray: D3D10_TEX2D_ARRAY_SRV);
      5: (Texture2DMS: D3D10_TEX2DMS_SRV);
      6: (Texture2DMSArray: D3D10_TEX2DMS_ARRAY_SRV);
      7: (Texture3D: TD3D10_Tex3D_SRV);
      8: (TextureCube: TD3D10_TexCube_SRV);
  end;
  {$EXTERNALSYM D3D10_SHADER_RESOURCE_VIEW_DESC}
  TD3D10_ShaderResourceViewDesc = D3D10_SHADER_RESOURCE_VIEW_DESC;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10ShaderResourceView);'}
  {$EXTERNALSYM ID3D10ShaderResourceView}
  ID3D10ShaderResourceView = interface (ID3D10View)
    ['{9B7E4C07-342C-4106-A19F-4F2704F689F0}']
    procedure GetDesc(
            (* [retval][out] *) out pDesc: TD3D10_ShaderResourceViewDesc); stdcall;
  end;

  IID_ID3D10ShaderResourceView = ID3D10ShaderResourceView;
  {$EXTERNALSYM IID_ID3D10ShaderResourceView}


  D3D10_BUFFER_RTV = record
  case Byte of
    0: (
      ElementOffset: LongWord;
      ElementWidth: LongWord;
    );
   1: (
      FirstElement: LongWord;
      NumElements: LongWord;
    );
  end;
  {$EXTERNALSYM D3D10_BUFFER_RTV}
  TD3D10_Buffer_RTV = D3D10_BUFFER_RTV;

  D3D10_TEX1D_RTV = record
    MipSlice: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX1D_RTV}
  TD3D10_Tex1D_RTV = D3D10_TEX1D_RTV;

  D3D10_TEX1D_ARRAY_RTV = record
    MipSlice: LongWord;
    FirstArraySlice: LongWord;
    ArraySize: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX1D_ARRAY_RTV}
  TD3D10_Tex1DArray_RTV = D3D10_TEX1D_ARRAY_RTV;

  D3D10_TEX2D_RTV = record
    MipSlice: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX2D_RTV}
  TD3D10_Tex2D_RTV = D3D10_TEX2D_RTV;

  D3D10_TEX2DMS_RTV = record
    UnusedField_NothingToDefine: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX2DMS_RTV}
  TD3D10_Tex2DMS_RTV = D3D10_TEX2DMS_RTV;

  D3D10_TEX2D_ARRAY_RTV = record
    MipSlice: LongWord;
    FirstArraySlice: LongWord;
    ArraySize: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX2D_ARRAY_RTV}
  TD3D10_Tex2DArray_RTV = D3D10_TEX2D_ARRAY_RTV;

  D3D10_TEX2DMS_ARRAY_RTV = record
    MipSlice: LongWord;
    FirstArraySlice: LongWord;
    ArraySize: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX2DMS_ARRAY_RTV}
  TD3D10_Tex2DMSArray_RTV = D3D10_TEX2DMS_ARRAY_RTV;

  D3D10_TEX3D_RTV = record
    MipSlice: LongWord;
    FirstWSlice: LongWord;
    WSize: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX3D_RTV}
  TD3D10_Tex3D_RTV = D3D10_TEX3D_RTV;

  PD3D10_RenderTargetViewDesc = ^TD3D10_RenderTargetViewDesc;
  D3D10_RENDER_TARGET_VIEW_DESC = record
    Format: TDXGI_Format;
    ViewDimension: TD3D10_RTV_Dimension;
    case Byte of
      0: (Buffer: TD3D10_Buffer_RTV);
      1: (Texture1D: TD3D10_Tex1D_RTV);
      2: (Texture1DArray: TD3D10_Tex1DArray_RTV);
      3: (Texture2D: TD3D10_Tex2D_RTV);
      4: (Texture2DArray: TD3D10_Tex2DArray_RTV);
      5: (Texture2DMS: TD3D10_Tex2DMS_RTV);
      6: (Texture2DMSArray: TD3D10_Tex2DMSArray_RTV);
      7: (Texture3D: TD3D10_Tex3D_RTV);
  end;
  {$EXTERNALSYM D3D10_RENDER_TARGET_VIEW_DESC}
  TD3D10_RenderTargetViewDesc = D3D10_RENDER_TARGET_VIEW_DESC;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10RenderTargetView);'}
  {$EXTERNALSYM ID3D10RenderTargetView}
  ID3D10RenderTargetView = interface (ID3D10View)
    ['{9B7E4C08-342C-4106-A19F-4F2704F689F0}']
    procedure GetDesc(
            (* [retval][out] *) out pDesc: TD3D10_RenderTargetViewDesc); stdcall;
  end;

  IID_ID3D10RenderTargetView = ID3D10RenderTargetView;
  {$EXTERNALSYM IID_ID3D10RenderTargetView}


  D3D10_TEX1D_DSV = record
    MipSlice: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX1D_DSV}
  TD3D10_Tex1D_DSV = D3D10_TEX1D_DSV;

  D3D10_TEX1D_ARRAY_DSV = record
    MipSlice: LongWord;
    FirstArraySlice: LongWord;
    ArraySize: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX1D_ARRAY_DSV}
  TD3D10_Tex1DArray_DSV = D3D10_TEX1D_ARRAY_DSV;

  D3D10_TEX2D_DSV = record
    MipSlice: LongWord;
    FirstArraySlice: LongWord;
    ArraySize: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX2D_DSV}
  TD3D10_Tex2D_DSV = D3D10_TEX2D_DSV;

  D3D10_TEX2D_ARRAY_DSV = record
    MipSlice: LongWord;
    FirstArraySlice: LongWord;
    ArraySize: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX2D_ARRAY_DSV}
  TD3D10_Tex2DArray_DSV = D3D10_TEX2D_ARRAY_DSV;

  D3D10_TEX2DMS_DSV = record
    UnusedField_NothingToDefine: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX2DMS_DSV}
  TD3D10_Tex2DMS_DSV = D3D10_TEX2DMS_DSV;

  D3D10_TEX2DMS_ARRAY_DSV = record
    FirstArraySlice: LongWord;
    ArraySize: LongWord;
  end;
  {$EXTERNALSYM D3D10_TEX2DMS_ARRAY_DSV}
  TD3D10_Tex2DMSArray_DSV = D3D10_TEX2DMS_ARRAY_DSV;

  PD3D10_DepthStencilViewDesc = ^TD3D10_DepthStencilViewDesc;
  D3D10_DEPTH_STENCIL_VIEW_DESC = record
    Format: DXGI_FORMAT;
    ViewDimension: TD3D10_DSV_Dimension;
    case Byte of
      0: (Texture1D: TD3D10_Tex1D_DSV);
      1: (Texture1DArray: TD3D10_Tex1DArray_DSV);
      2: (Texture2D: TD3D10_Tex2D_DSV);
      3: (Texture2DArray: TD3D10_Tex2DArray_DSV);
      4: (Texture2DMS: TD3D10_Tex2DMS_DSV);
      5: (Texture2DMSArray: TD3D10_Tex2DMSArray_DSV);
  end;
  {$EXTERNALSYM D3D10_DEPTH_STENCIL_VIEW_DESC}
  TD3D10_DepthStencilViewDesc = D3D10_DEPTH_STENCIL_VIEW_DESC;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10DepthStencilView);'}
  {$EXTERNALSYM ID3D10DepthStencilView}
  ID3D10DepthStencilView = interface (ID3D10View)
    ['{9B7E4C09-342C-4106-A19F-4F2704F689F0}']
    procedure GetDesc(
            (* [retval][out] *) out pDesc: TD3D10_DepthStencilViewDesc); stdcall;
  end;

  IID_ID3D10DepthStencilView = ID3D10DepthStencilView;
  {$EXTERNALSYM IID_ID3D10DepthStencilView}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10VertexShader);'}
  {$EXTERNALSYM ID3D10VertexShader}
  ID3D10VertexShader = interface (ID3D10DeviceChild)
    ['{9B7E4C0A-342C-4106-A19F-4F2704F689F0}']
  end;

  IID_ID3D10VertexShader = ID3D10VertexShader;
  {$EXTERNALSYM IID_ID3D10VertexShader}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10GeometryShader);'}
  {$EXTERNALSYM ID3D10GeometryShader}
  ID3D10GeometryShader = interface (ID3D10DeviceChild)
    ['{6316BE88-54CD-4040-AB44-20461BC81F68}']
  end;

  IID_ID3D10GeometryShader = ID3D10GeometryShader;
  {$EXTERNALSYM IID_ID3D10GeometryShader}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10PixelShader);'}
  {$EXTERNALSYM ID3D10PixelShader}
  ID3D10PixelShader = interface (ID3D10DeviceChild)
    ['{4968B601-9D00-4cde-8346-8E7F675819B6}']
  end;

  IID_ID3D10PixelShader = ID3D10PixelShader;
  {$EXTERNALSYM IID_ID3D10PixelShader}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10InputLayout);'}
  {$EXTERNALSYM ID3D10InputLayout}
  ID3D10InputLayout = interface (ID3D10DeviceChild)
    ['{9B7E4C0B-342C-4106-A19F-4F2704F689F0}']
  end;

  IID_ID3D10InputLayout = ID3D10InputLayout;
  {$EXTERNALSYM IID_ID3D10InputLayout}


  D3D10_FILTER = (
    D3D10_FILTER_MIN_MAG_MIP_POINT = 0,
    D3D10_FILTER_MIN_MAG_POINT_MIP_LINEAR = $1,
    D3D10_FILTER_MIN_POINT_MAG_LINEAR_MIP_POINT = $4,
    D3D10_FILTER_MIN_POINT_MAG_MIP_LINEAR = $5,
    D3D10_FILTER_MIN_LINEAR_MAG_MIP_POINT = $10,
    D3D10_FILTER_MIN_LINEAR_MAG_POINT_MIP_LINEAR = $11,
    D3D10_FILTER_MIN_MAG_LINEAR_MIP_POINT = $14,
    D3D10_FILTER_MIN_MAG_MIP_LINEAR = $15,
    D3D10_FILTER_ANISOTROPIC = $55,
    D3D10_FILTER_COMPARISON_MIN_MAG_MIP_POINT = $80,
    D3D10_FILTER_COMPARISON_MIN_MAG_POINT_MIP_LINEAR = $81,
    D3D10_FILTER_COMPARISON_MIN_POINT_MAG_LINEAR_MIP_POINT = $84,
    D3D10_FILTER_COMPARISON_MIN_POINT_MAG_MIP_LINEAR = $85,
    D3D10_FILTER_COMPARISON_MIN_LINEAR_MAG_MIP_POINT = $90,
    D3D10_FILTER_COMPARISON_MIN_LINEAR_MAG_POINT_MIP_LINEAR = $91,
    D3D10_FILTER_COMPARISON_MIN_MAG_LINEAR_MIP_POINT = $94,
    D3D10_FILTER_COMPARISON_MIN_MAG_MIP_LINEAR = $95,
    D3D10_FILTER_COMPARISON_ANISOTROPIC = $d5
    // D3D10_FILTER_TEXT_1BIT = $80000000
    //todo: Check in "Future Delphi versions"
  );
  {$EXTERNALSYM D3D10_FILTER}
  TD3D10_Filter = D3D10_FILTER;

//todo: FIX me! Move Const declaration.
{const
  D3D10_FILTER_TEXT_1BIT = D3D10_FILTER($80000000);}

  D3D10_FILTER_TYPE = (
    D3D10_FILTER_TYPE_POINT = 0,
    D3D10_FILTER_TYPE_LINEAR = 1
  );
  {$EXTERNALSYM D3D10_FILTER_TYPE}
  TD3D10_FilterType = D3D10_FILTER_TYPE;

//todo: FIX me! Move Const declaration. 2.
{const
  D3D10_FILTER_TYPE_MASK = $3;

  D3D10_MIN_FILTER_SHIFT = 4;
  D3D10_MAG_FILTER_SHIFT = 2;
  D3D10_MIP_FILTER_SHIFT = 0;

  D3D10_COMPARISON_FILTERING_BIT = $80;

  D3D10_ANISOTROPIC_FILTERING_BIT = $40;

  D3D10_TEXT_1BIT_BIT = $80000000; }

//todo: FIX ME! Filter helpers.
{#define D3D10_ENCODE_BASIC_FILTER( min, mag, mip, bComparison )                                           \
                                   ( ( D3D10_FILTER ) (                                                   \
                                   ( ( bComparison ) ? D3D10_COMPARISON_FILTERING_BIT : 0 ) |             \
                                   ( ( ( min ) & D3D10_FILTER_TYPE_MASK ) << D3D10_MIN_FILTER_SHIFT ) |   \
                                   ( ( ( mag ) & D3D10_FILTER_TYPE_MASK ) << D3D10_MAG_FILTER_SHIFT ) |   \
                                   ( ( ( mip ) & D3D10_FILTER_TYPE_MASK ) << D3D10_MIP_FILTER_SHIFT ) ) )
#define D3D10_ENCODE_ANISOTROPIC_FILTER( bComparison )                                                \
                                         ( ( D3D10_FILTER ) (                                         \
                                         D3D10_ANISOTROPIC_FILTERING_BIT |                            \
                                         D3D10_ENCODE_BASIC_FILTER( D3D10_FILTER_TYPE_LINEAR,         \
                                                                    D3D10_FILTER_TYPE_LINEAR,         \
                                                                    D3D10_FILTER_TYPE_LINEAR,         \
                                                                    bComparison ) ) )
#define D3D10_DECODE_MIN_FILTER( d3d10Filter )                                                              \
                                 ( ( D3D10_FILTER_TYPE )                                                    \
                                 ( ( ( d3d10Filter ) >> D3D10_MIN_FILTER_SHIFT ) & D3D10_FILTER_TYPE_MASK ) )
#define D3D10_DECODE_MAG_FILTER( d3d10Filter )                                                              \
                                 ( ( D3D10_FILTER_TYPE )                                                    \
                                 ( ( ( d3d10Filter ) >> D3D10_MAG_FILTER_SHIFT ) & D3D10_FILTER_TYPE_MASK ) )
#define D3D10_DECODE_MIP_FILTER( d3d10Filter )                                                              \
                                 ( ( D3D10_FILTER_TYPE )                                                    \
                                 ( ( ( d3d10Filter ) >> D3D10_MIP_FILTER_SHIFT ) & D3D10_FILTER_TYPE_MASK ) )
#define D3D10_DECODE_IS_COMPARISON_FILTER( d3d10Filter )                                                    \
                                 ( ( d3d10Filter ) & D3D10_COMPARISON_FILTERING_BIT )
#define D3D10_DECODE_IS_ANISOTROPIC_FILTER( d3d10Filter )                                               \
                            ( ( ( d3d10Filter ) & D3D10_ANISOTROPIC_FILTERING_BIT ) &&                  \
                            ( D3D10_FILTER_TYPE_LINEAR == D3D10_DECODE_MIN_FILTER( d3d10Filter ) ) &&   \
                            ( D3D10_FILTER_TYPE_LINEAR == D3D10_DECODE_MAG_FILTER( d3d10Filter ) ) &&   \
                            ( D3D10_FILTER_TYPE_LINEAR == D3D10_DECODE_MIP_FILTER( d3d10Filter ) ) )
#define D3D10_DECODE_IS_TEXT_1BIT_FILTER( d3d10Filter )                                             \
                                 ( ( d3d10Filter ) == D3D10_TEXT_1BIT_BIT )
}

  D3D10_TEXTURE_ADDRESS_MODE = (
    D3D10_TEXTURE_ADDRESS_WRAP = 1,
    D3D10_TEXTURE_ADDRESS_MIRROR = 2,
    D3D10_TEXTURE_ADDRESS_CLAMP = 3,
    D3D10_TEXTURE_ADDRESS_BORDER = 4,
    D3D10_TEXTURE_ADDRESS_MIRROR_ONCE = 5
  );
  {$EXTERNALSYM D3D10_TEXTURE_ADDRESS_MODE}
  TD3D10_TextureAddressMode = D3D10_TEXTURE_ADDRESS_MODE;

  D3D10_SAMPLER_DESC = record
    Filter: D3D10_FILTER;
    AddressU: D3D10_TEXTURE_ADDRESS_MODE;
    AddressV: D3D10_TEXTURE_ADDRESS_MODE;
    AddressW: D3D10_TEXTURE_ADDRESS_MODE;
    MipLODBias: Single;
    MaxAnisotropy: LongWord;
    ComparisonFunc: D3D10_COMPARISON_FUNC;
    BorderColor: array[0..3] of Single;
    MinLOD: Single;
    MaxLOD: Single;
  end;
  {$EXTERNALSYM D3D10_SAMPLER_DESC}
  TD3D10_SamplerDesc = D3D10_SAMPLER_DESC;



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10SamplerState);'}
  {$EXTERNALSYM ID3D10SamplerState}
  ID3D10SamplerState = interface (ID3D10DeviceChild)
    ['{9B7E4C0C-342C-4106-A19F-4F2704F689F0}']
    procedure GetDesc(
            (* [retval][out] *) out pDesc: TD3D10_SamplerDesc); stdcall;
  end;

  IID_ID3D10SamplerState = ID3D10SamplerState;
  {$EXTERNALSYM IID_ID3D10SamplerState}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10Asynchronous);'}
  {$EXTERNALSYM ID3D10Asynchronous}
  ID3D10Asynchronous = interface (ID3D10DeviceChild)
    ['{9B7E4C0D-342C-4106-A19F-4F2704F689F0}']
    procedure _Begin; stdcall;
    procedure _End; stdcall;

    function GetData(
            (* __out_bcount_opt(DataSize) *) pData: Pointer;
            (* [in] *) DataSize: LongWord;
            (* [in] *) GetDataFlags: LongWord): HResult; stdcall;

    function GetDataSize: LongWord; stdcall;
  end;

  IID_ID3D10Asynchronous = ID3D10Asynchronous;
  {$EXTERNALSYM IID_ID3D10Asynchronous}


  D3D10_ASYNC_GETDATA_FLAG = (
    D3D10_ASYNC_GETDATA_DONOTFLUSH = $1
  );
  {$EXTERNALSYM D3D10_ASYNC_GETDATA_FLAG}
  TD3D10_AsyncGetDataFlag = D3D10_ASYNC_GETDATA_FLAG;


  D3D10_QUERY = (
    D3D10_QUERY_EVENT = 0,
    D3D10_QUERY_OCCLUSION = (D3D10_QUERY_EVENT + 1),
    D3D10_QUERY_TIMESTAMP = (D3D10_QUERY_OCCLUSION + 1),
    D3D10_QUERY_TIMESTAMP_DISJOINT = (D3D10_QUERY_TIMESTAMP + 1),
    D3D10_QUERY_PIPELINE_STATISTICS = (D3D10_QUERY_TIMESTAMP_DISJOINT + 1),
    D3D10_QUERY_OCCLUSION_PREDICATE = (D3D10_QUERY_PIPELINE_STATISTICS + 1),
    D3D10_QUERY_SO_STATISTICS = (D3D10_QUERY_OCCLUSION_PREDICATE + 1),
    D3D10_QUERY_SO_OVERFLOW_PREDICATE = (D3D10_QUERY_SO_STATISTICS + 1)
  );
  {$EXTERNALSYM D3D10_QUERY}
  TD3D10_Query = D3D10_QUERY;

  D3D10_QUERY_MISC_FLAG = (
    D3D10_QUERY_MISC_PREDICATEHINT = $1
  );
  {$EXTERNALSYM D3D10_QUERY_MISC_FLAG}
  TD3D10_QueryMiscFlag = D3D10_QUERY_MISC_FLAG;

  D3D10_QUERY_DESC = record
    Query: TD3D10_Query;
    MiscFlags: LongWord;
  end;
  {$EXTERNALSYM D3D10_QUERY_DESC}
  TD3D10_QueryDesc = D3D10_QUERY_DESC;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10Query);'}
  {$EXTERNALSYM ID3D10Query}
  ID3D10Query = interface (ID3D10Asynchronous)
    ['{9B7E4C0E-342C-4106-A19F-4F2704F689F0}']
    procedure GetDesc(
            (* __out *) out pDesc: TD3D10_QueryDesc); stdcall;
  end;

  IID_ID3D10Query = ID3D10Query;
  {$EXTERNALSYM IID_ID3D10Query}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10Predicate);'}
  {$EXTERNALSYM ID3D10Predicate}
  ID3D10Predicate = interface (ID3D10Query)
    ['{9B7E4C10-342C-4106-A19F-4F2704F689F0}']
  end;

  IID_ID3D10Predicate = ID3D10Predicate;
  {$EXTERNALSYM IID_ID3D10Predicate}


  D3D10_QUERY_DATA_TIMESTAMP_DISJOINT = record
    Frequency: UINT64;
    Disjoint: BOOL;
  end;
  {$EXTERNALSYM D3D10_QUERY_DATA_TIMESTAMP_DISJOINT}
  TD3D10_QueryData_Timestamp_Disjoint = D3D10_QUERY_DATA_TIMESTAMP_DISJOINT;

  D3D10_QUERY_DATA_PIPELINE_STATISTICS = record
    IAVertices: UINT64;
    IAPrimitives: UINT64;
    VSInvocations: UINT64;
    GSInvocations: UINT64;
    GSPrimitives: UINT64;
    CInvocations: UINT64;
    CPrimitives: UINT64;
    PSInvocations: UINT64;
  end;
  {$EXTERNALSYM D3D10_QUERY_DATA_PIPELINE_STATISTICS}
  TD3D10_QueryData_Pipeline_Statistics = D3D10_QUERY_DATA_PIPELINE_STATISTICS;

  D3D10_QUERY_DATA_SO_STATISTICS = record
    NumPrimitivesWritten: UINT64;
    PrimitivesStorageNeeded: UINT64;
  end;
  {$EXTERNALSYM D3D10_QUERY_DATA_SO_STATISTICS}
  TD3D10_QueryData_SO_Statistics  = D3D10_QUERY_DATA_SO_STATISTICS;

  D3D10_COUNTER = (
    D3D10_COUNTER_GPU_IDLE = 0,
    D3D10_COUNTER_VERTEX_PROCESSING = (D3D10_COUNTER_GPU_IDLE + 1),
    D3D10_COUNTER_GEOMETRY_PROCESSING = (D3D10_COUNTER_VERTEX_PROCESSING + 1),
    D3D10_COUNTER_PIXEL_PROCESSING = (D3D10_COUNTER_GEOMETRY_PROCESSING + 1),
    D3D10_COUNTER_OTHER_GPU_PROCESSING = (D3D10_COUNTER_PIXEL_PROCESSING + 1),
    D3D10_COUNTER_HOST_ADAPTER_BANDWIDTH_UTILIZATION = (D3D10_COUNTER_OTHER_GPU_PROCESSING + 1),
    D3D10_COUNTER_LOCAL_VIDMEM_BANDWIDTH_UTILIZATION = (D3D10_COUNTER_HOST_ADAPTER_BANDWIDTH_UTILIZATION + 1),
    D3D10_COUNTER_VERTEX_THROUGHPUT_UTILIZATION = (D3D10_COUNTER_LOCAL_VIDMEM_BANDWIDTH_UTILIZATION + 1),
    D3D10_COUNTER_TRIANGLE_SETUP_THROUGHPUT_UTILIZATION = (D3D10_COUNTER_VERTEX_THROUGHPUT_UTILIZATION + 1),
    D3D10_COUNTER_FILLRATE_THROUGHPUT_UTILIZATION = (D3D10_COUNTER_TRIANGLE_SETUP_THROUGHPUT_UTILIZATION + 1),
    D3D10_COUNTER_VS_MEMORY_LIMITED = (D3D10_COUNTER_FILLRATE_THROUGHPUT_UTILIZATION + 1),
    D3D10_COUNTER_VS_COMPUTATION_LIMITED = (D3D10_COUNTER_VS_MEMORY_LIMITED + 1),
    D3D10_COUNTER_GS_MEMORY_LIMITED = (D3D10_COUNTER_VS_COMPUTATION_LIMITED + 1),
    D3D10_COUNTER_GS_COMPUTATION_LIMITED = (D3D10_COUNTER_GS_MEMORY_LIMITED + 1),
    D3D10_COUNTER_PS_MEMORY_LIMITED = (D3D10_COUNTER_GS_COMPUTATION_LIMITED + 1),
    D3D10_COUNTER_PS_COMPUTATION_LIMITED = (D3D10_COUNTER_PS_MEMORY_LIMITED + 1),
    D3D10_COUNTER_POST_TRANSFORM_CACHE_HIT_RATE = (D3D10_COUNTER_PS_COMPUTATION_LIMITED + 1),
    D3D10_COUNTER_TEXTURE_CACHE_HIT_RATE = (D3D10_COUNTER_POST_TRANSFORM_CACHE_HIT_RATE + 1),
    D3D10_COUNTER_DEVICE_DEPENDENT_0 = $40000000
  );
  {$EXTERNALSYM D3D10_COUNTER}
  TD3D10_Counter = D3D10_COUNTER;

  D3D10_COUNTER_TYPE = (
    D3D10_COUNTER_TYPE_FLOAT32 = 0,
    D3D10_COUNTER_TYPE_UINT16 = (D3D10_COUNTER_TYPE_FLOAT32 + 1),
    D3D10_COUNTER_TYPE_UINT32 = (D3D10_COUNTER_TYPE_UINT16 + 1),
    D3D10_COUNTER_TYPE_UINT64 = (D3D10_COUNTER_TYPE_UINT32 + 1)
  );
  {$EXTERNALSYM D3D10_COUNTER_TYPE}
  TD3D10_CounterType = D3D10_COUNTER_TYPE;

  D3D10_COUNTER_DESC = record
    Counter: TD3D10_Counter;
    MiscFlags: LongWord;
  end;
  {$EXTERNALSYM D3D10_COUNTER_DESC}
  TD3D10_CounterDesc = D3D10_COUNTER_DESC;

  D3D10_COUNTER_INFO = record
    LastDeviceDependentCounter: TD3D10_Counter;
    NumSimultaneousCounters: LongWord;
    NumDetectableParallelUnits: Byte;
  end;
  {$EXTERNALSYM D3D10_COUNTER_INFO}
  TD3D10_CounterInfo = D3D10_COUNTER_INFO;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10Counter);'}
  {$EXTERNALSYM ID3D10Counter}
  ID3D10Counter = interface (ID3D10Asynchronous)
    ['{9B7E4C11-342C-4106-A19F-4F2704F689F0}']
    procedure GetDesc(
            (* __out *)
            out pDesc: TD3D10_CounterDesc); stdcall;
  end;

  IID_ID3D10Counter = ID3D10Counter;
  {$EXTERNALSYM IID_ID3D10Counter}


  PColorArray = ^TColorArray;
  TColorArray = array[0..3] of Single;

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10Device);'}
  {$EXTERNALSYM ID3D10Device}
  ID3D10Device = interface (IUnknown)
    ['{9B7E4C0F-342C-4106-A19F-4F2704F689F0}']
    procedure VSSetConstantBuffers(
            (* __in_range( 0, D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot ) *)
            NumBuffers: LongWord;
            (* __in_ecount(NumBuffers) *)
            ppConstantBuffers: PID3D10Buffer); stdcall;

    procedure PSSetShaderResources(
            (* __in_range( 0, D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - StartSlot ) *)
            NumViews: LongWord;
            (* __in_ecount(NumViews) *)
            ppShaderResourceViews: PID3D10ShaderResourceView); stdcall;

    procedure PSSetShader(
            (* __in_opt *)
            pPixelShader: ID3D10PixelShader); stdcall;

    procedure PSSetSamplers(
            (* __in_range( 0, D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT - StartSlot ) *)
            NumSamplers: LongWord;
            (* __in_ecount(NumSamplers) *)
            ppSamplers: PID3D10SamplerState); stdcall;

    procedure VSSetShader(
            (* __in_opt *) pVertexShader: ID3D10VertexShader); stdcall;

    procedure DrawIndexed(
            (* __in *)
            IndexCount: LongWord;
            (* __in *)
            StartIndexLocation: LongWord;
            (* __in *)
            BaseVertexLocation: Integer); stdcall;

    procedure Draw(
            (* __in *)
            VertexCount: LongWord;
            (* __in *)
            StartVertexLocation: LongWord); stdcall;

    procedure PSSetConstantBuffers(
            (* __in_range( 0, D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot ) *)
            NumBuffers: LongWord;
            (* __in_ecount(NumBuffers) *)
            ppConstantBuffers: PID3D10Buffer); stdcall;

    procedure IASetInputLayout(
            (* __in_opt *)
            pInputLayout: ID3D10InputLayout); stdcall;

    procedure IASetVertexBuffers(
            (* __in_range( 0, D3D10_1_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_1_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT - StartSlot ) *)
            NumBuffers: LongWord;
            (* __in_ecount(NumBuffers) *)
            ppVertexBuffers: pID3D10Buffer;
            (* __in_ecount(NumBuffers) *)
            const pStrides: PLongWord;
            (* __in_ecount(NumBuffers) *)
            const pOffsets: PLongWord); stdcall;

    procedure IASetIndexBuffer(
            (* __in_opt *)
            pIndexBuffer: ID3D10Buffer;
            (* __in *)
            Format: TDXGI_Format;
            (* __in *)
            Offset: LongWord); stdcall;

    procedure DrawIndexedInstanced(
            (* __in *)
            IndexCountPerInstance: LongWord;
            (* __in *)
            InstanceCount: LongWord;
            (* __in *)
            StartIndexLocation: LongWord;
            (* __in *)
            BaseVertexLocation: Longint;
            (* __in *)
            StartInstanceLocation: LongWord); stdcall;

    procedure DrawInstanced(
            (* [in] *) VertexCountPerInstance: LongWord;
            (* [in] *) InstanceCount: LongWord;
            (* [in] *) StartVertexLocation: LongWord;
            (* [in] *) StartInstanceLocation: LongWord); stdcall;

    procedure GSSetConstantBuffers(
            (* __in_range( 0, D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot ) *)
            NumBuffers: LongWord;
            (* __in_ecount(NumBuffers) *)
            ppConstantBuffers: PID3D10Buffer); stdcall;

    procedure GSSetShader(
            (* __in_opt *)
            pShader: ID3D10GeometryShader); stdcall;

    procedure IASetPrimitiveTopology(
            (* __in *)
            Topology: TD3D10_PrimitiveTopology); stdcall;

    procedure VSSetShaderResources(
            (* __in_range( 0, D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - StartSlot ) *)
            NumViews: LongWord;
            (* __in_ecount(NumViews) *)
            ppShaderResourceViews: ID3D10ShaderResourceView); stdcall;

    procedure VSSetSamplers( 
            (* __in_range( 0, D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT - StartSlot ) *)
            NumSamplers: LongWord;
            (* __in_ecount(NumSamplers) *)
            ppSamplers: PID3D10SamplerState); stdcall;

    procedure SetPredication(
            (* __in_opt *)
            pPredicate: ID3D10Predicate;
            (* __in  *)
            PredicateValue: BOOL); stdcall;
        
    procedure GSSetShaderResources( 
            (* __in_range( 0, D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - StartSlot ) *)
            NumViews: LongWord;
            (* __in_ecount(NumViews) *)
            ppShaderResourceViews: PID3D10ShaderResourceView); stdcall;

    procedure GSSetSamplers(
            (* __in_range( 0, D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT - StartSlot ) *)
            NumSamplers: LongWord;
            (* __in_ecount(NumSamplers) *)
            ppSamplers: PID3D10SamplerState); stdcall;
        
    procedure OMSetRenderTargets( 
            (* __in_range( 0, D3D10_SIMULTANEOUS_RENDER_TARGET_COUNT ) *)
            NumViews: LongWord;
            (* __in_ecount_opt(NumViews) *)
            ppRenderTargetViews: PID3D10RenderTargetView;
            (* __in_opt *)
            pDepthStencilView: ID3D10DepthStencilView); stdcall;
        
    procedure OMSetBlendState( 
            (* __in_opt *)
            pBlendState: ID3D10BlendState;
            (* __in *)
            const BlendFactor: TColorArray; // FLOAT BlendFactor[ 4 ],
            (* __in *)
            SampleMask: LongWord); stdcall;

    procedure OMSetDepthStencilState(
            (* __in_opt *)
            pDepthStencilState: ID3D10DepthStencilState;
            (* __in *)
            StencilRef: LongWord); stdcall;

    procedure SOSetTargets(
            (* __in_range( 0, D3D10_SO_BUFFER_SLOT_COUNT) *)
            NumBuffers: LongWord;
            (* __in_ecount_opt(NumBuffers) *)
            ppSOTargets: PID3D10Buffer;
            (* __in_ecount_opt(NumBuffers) *)
            const pOffsets: PLongWord); stdcall;

    procedure DrawAuto(); stdcall;

    procedure RSSetState( 
            (* __in_opt *)
            pRasterizerState: ID3D10RasterizerState); stdcall;
        
    procedure RSSetViewports(
            (* __in_range(0, D3D10_VIEWPORT_AND_SCISSORRECT_OBJECT_COUNT_PER_PIPELINE) *)
            NumViewports: LongWord;
            (* __in_ecount_opt(NumViewports) *)
            const pViewports: PD3D10_Viewport); stdcall;

    procedure RSSetScissorRects( 
            (* __in_range(0, D3D10_VIEWPORT_AND_SCISSORRECT_OBJECT_COUNT_PER_PIPELINE) *)
            NumRects: LongWord;
            (* __in_ecount_opt(NumRects) *)
            const pRects: PD3D10_Rect); stdcall;

    procedure CopySubresourceRegion(
            (* __in *)
            pDstResource: ID3D10Resource;
            (* __in *)
            DstSubresource: LongWord;
            (* __in *)
            DstX: LongWord;
            (* __in *)
            DstY: LongWord;
            (* __in *)
            DstZ: LongWord;
            (* __in *)
            pSrcResource: ID3D10Resource;
            (* __in *)
            SrcSubresource: LongWord;
            (* __in_opt *)
            const pSrcBox: PD3D10_Box); stdcall;

    procedure CopyResource(
            (* __in *)
            const pDstResource: ID3D10Resource;
            (* __in *)
            const pSrcResource: ID3D10Resource); stdcall;

    procedure UpdateSubresource(
            (* __in *)
            const pDstResource: ID3D10Resource;
            (* __in *)
            DstSubresource: LongWord;
            (* __in_opt *)
            const pDstBox: PD3D10_Box;
            (* __in *)
            const pSrcData: Pointer;
            (* __in *)
            SrcRowPitch: LongWord;
            (* __in *)
            SrcDepthPitch: LongWord); stdcall;

    procedure ClearRenderTargetView(
            (* __in *)
            const pRenderTargetView: ID3D10RenderTargetView;
            (* __in *)
            const ColorRGBA: TColorArray); stdcall;

    procedure ClearDepthStencilView(
            (* __in *)
            const pDepthStencilView: ID3D10DepthStencilView;
            (* __in *)
            ClearFlags: TD3D10_ClearFlag; // LongWord;
            (* __in *)
            Depth: Single;
            (* __in *)
            Stencil: Byte); stdcall;

    procedure GenerateMips(
            (* __in *)
            pShaderResourceView: ID3D10ShaderResourceView); stdcall;

    procedure ResolveSubresource(
            (* __in *)
            const pDstResource: ID3D10Resource;
            (* __in *)
            DstSubresource: LongWord;
            (* __in *)
            const pSrcResource: ID3D10Resource;
            (* __in *)
            SrcSubresource: LongWord;
            (* __in *)
            Format: TDXGI_Format); stdcall;

    procedure VSGetConstantBuffers(
            (* __in_range( 0, D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot ) *)
            NumBuffers: LongWord;
            (* __out_ecount(NumBuffers) *)
            ppConstantBuffers: PID3D10Buffer); stdcall;

    procedure PSGetShaderResources(
            (* __in_range( 0, D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - StartSlot ) *)
            NumViews: LongWord;
            (* __out_ecount(NumViews) *)
            ppShaderResourceViews: PID3D10ShaderResourceView); stdcall;
        
    procedure PSGetShader( 
            (* __out *)
            out ppPixelShader: ID3D10PixelShader); stdcall;

    procedure PSGetSamplers( 
            (* __in_range( 0, D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT - StartSlot ) *)
            NumSamplers: LongWord;
            (* __out_ecount(NumSamplers) *)
            ppSamplers: PID3D10SamplerState); stdcall;

    procedure VSGetShader( 
            (* __out *)
            out ppVertexShader: ID3D10VertexShader); stdcall;

    procedure PSGetConstantBuffers(
            (* __in_range( 0, D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot ) *)
            NumBuffers: LongWord;
            (* __out_ecount(NumBuffers) *)
            ppConstantBuffers: PID3D10Buffer); stdcall;
        
    procedure IAGetInputLayout(
            (* __out *)
            out ppInputLayout: ID3D10InputLayout); stdcall;
        
    procedure IAGetVertexBuffers(
            (* __in_range( 0, D3D10_1_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_1_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT - StartSlot ) *)
            NumBuffers: LongWord;
            (* __out_ecount_opt(NumBuffers) *)
            ppVertexBuffers: PID3D10Buffer;
            (* __out_ecount_opt(NumBuffers) *)
            pStrides: PLongWord;
            (* __out_ecount_opt(NumBuffers) *)
            pOffsets: PLongWord); stdcall;

    procedure IAGetIndexBuffer( //todo: Check if all OUT are not NULL?
            (* __out_opt *)
            pIndexBuffer: PID3D10Buffer;
            (* __out_opt *)
            Format: PDXGI_Format;
            (* __out_opt *)
            Offset: PLongWord); stdcall;

    procedure GSGetConstantBuffers(
            (* __in_range( 0, D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT - StartSlot ) *)
            NumBuffers: LongWord;
            (* __out_ecount(NumBuffers) *)
            ppConstantBuffers: PID3D10Buffer); stdcall;

    procedure GSGetShader( 
            (* __out *)
            out ppGeometryShader: ID3D10GeometryShader); stdcall;

    procedure IAGetPrimitiveTopology(
            (* __out *)
            out pTopology: TD3D10_PrimitiveTopology); stdcall;
        
    procedure VSGetShaderResources( 
            (* __in_range( 0, D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - StartSlot ) *)
            NumViews: LongWord;
            (* __out_ecount(NumViews) *)
            ppShaderResourceViews: PID3D10ShaderResourceView); stdcall;
        
    procedure VSGetSamplers( 
            (* __in_range( 0, D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT - StartSlot ) *)
            NumSamplers: LongWord;
            (* __out_ecount(NumSamplers) *)
            ppSamplers: PID3D10SamplerState); stdcall;

    procedure GetPredication(
            (* __out_opt *)
            ppPredicate: PID3D10Predicate;
            (* __out_opt *)
            pPredicateValue: PBOOL); stdcall;

    procedure GSGetShaderResources( 
            (* __in_range( 0, D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT - StartSlot ) *)
            NumViews: LongWord;
            (* __out_ecount(NumViews) *)
            ppShaderResourceViews: PID3D10ShaderResourceView); stdcall;
        
    procedure GSGetSamplers( 
            (* __in_range( 0, D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT - 1 ) *)
            StartSlot: LongWord;
            (* __in_range( 0, D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT - StartSlot ) *)
            NumSamplers: LongWord;
            (* __out_ecount(NumSamplers) *)
            ppSamplers: PID3D10SamplerState); stdcall;

    procedure OMGetRenderTargets(
            (* __in_range( 0, D3D10_SIMULTANEOUS_RENDER_TARGET_COUNT ) *)
            NumViews: LongWord;
            (* __out_ecount_opt(NumViews) *)
            ppRenderTargetViews: PID3D10RenderTargetView;
            (* __out_opt *)
            ppDepthStencilView: PID3D10DepthStencilView); stdcall;
        
    procedure OMGetBlendState( 
            (* __out_opt *)
            ppBlendState: PID3D10BlendState;
            (* __out_opt *)
            BlendFactor: PColorArray;
            (* __out_opt *)
            pSampleMask: PLongWord); stdcall;
        
    procedure OMGetDepthStencilState( 
            (* __out_opt *)
            ppDepthStencilState: PID3D10DepthStencilState;
            (* __out_opt *)
            pStencilRef: PLongWord); stdcall;

    procedure SOGetTargets(
            (* __in_range( 0, D3D10_SO_BUFFER_SLOT_COUNT ) *)
            NumBuffers: LongWord;
            (* __out_ecount_opt(NumBuffers) *)
            ppSOTargets: PID3D10Buffer;
            (* __out_ecount_opt(NumBuffers) *)
            pOffsets: PLongWord); stdcall;
        
    procedure RSGetState( 
            (* __out *)
            out ppRasterizerState: ID3D10RasterizerState); stdcall;
        
    procedure RSGetViewports(
            (* __inout ( *_range(0, D3D10_VIEWPORT_AND_SCISSORRECT_OBJECT_COUNT_PER_PIPELINE )* )  *)
            var NumViewports: LongWord;
            (* __out_ecount_opt(*NumViewports) *)
            pViewports: PD3D10_Viewport); stdcall;

    procedure RSGetScissorRects(
            (* __inout ( *_range(0, D3D10_VIEWPORT_AND_SCISSORRECT_OBJECT_COUNT_PER_PIPELINE )* )  *)
            var NumRects: LongWord;
            (* __out_ecount_opt(*NumRects) *)
            pRects: PD3D10_Rect); stdcall;

    function GetDeviceRemovedReason(): HResult; stdcall;

    function SetExceptionMode(RaiseFlags: LongWord): HResult; stdcall;

    function GetExceptionMode(): LongWord; stdcall;

    function GetPrivateData(
            (* __in *)
            guid: TGUID;
            (* __inout *)
            var pDataSize: LongWord;
            (* __out_bcount_opt(*pDataSize) *)
            pData: Pointer): HResult; stdcall;
        
    function SetPrivateData(
            (* __in *)
            guid: TGUID;
            (* __in *)
            DataSize: LongWord;
            (* __in_bcount_opt(DataSize) *)
            const pData: Pointer): HResult; stdcall;
        
    function SetPrivateDataInterface(
            (* __in *)
            guid: TGUID;
            (* __in_opt *)
            const pData: IUnknown): HResult; stdcall;

    procedure ClearState(); stdcall;

    procedure Flush(); stdcall;

    function CreateBuffer(
            (* __in *)
            const pDesc: TD3D10_BufferDesc;
            (* __in_opt *)
            const pInitialData: PD3D10_SubresourceData;
            (* __out_opt *)
            ppBuffer: PID3D10Buffer): HResult; stdcall;

    function CreateTexture1D(
            (* __in *)
            const pDesc: TD3D10_Texture1DDesc;
            (* __in_xcount_opt(pDesc.MipLevels * pDesc.ArraySize) *)
            const pInitialData: PD3D10_SubresourceData;
            (* __out *)
            out ppTexture1D: ID3D10Texture1D): HResult; stdcall;

    function CreateTexture2D(
            (* __in *)
            const pDesc: TD3D10_Texture2DDesc;
            (* __in_xcount_opt(pDesc.MipLevels * pDesc.ArraySize) *)
            const pInitialData: PD3D10_SubresourceData;
            (* __out *)
            out ppTexture2D: ID3D10Texture2D): HResult; stdcall;

    function CreateTexture3D(
            (* __in *)
            const pDesc: TD3D10_Texture3DDesc;
            (* __in_xcount_opt(pDesc.MipLevels) *)
            const pInitialData: PD3D10_SubresourceData;
            (* __out *)
            out ppTexture3D: ID3D10Texture3D): HResult; stdcall;

    function CreateShaderResourceView(
            (* __in *)
            const pResource: ID3D10Resource;
            (* __in_opt *)
            pDesc: PD3D10_ShaderResourceViewDesc;
            (* __out_opt *)
            ppSRView: PID3D10ShaderResourceView): HResult; stdcall;

    function CreateRenderTargetView(
            (* __in *)
            const pResource: ID3D10Resource;
            (* __in_opt *)
            const pDesc: PD3D10_RenderTargetViewDesc;
            (* __out_opt *)
            ppRTView: PID3D10RenderTargetView): HResult; stdcall;

    function CreateDepthStencilView(
            (* __in *)
            const pResource: ID3D10Resource;
            (* __in_opt *)
            const pDesc: PD3D10_DepthStencilViewDesc;
            (* __out_opt *)
            ppDepthStencilView: PID3D10DepthStencilView): HResult; stdcall;

    function CreateInputLayout(
            (* __in_ecount(NumElements) *)
            const pInputElementDescs: PD3D10_InputElementDesc;
            (* __in_range( 0, D3D10_1_IA_VERTEX_INPUT_STRUCTURE_ELEMENT_COUNT ) *)
            NumElements: LongWord;
            (* __in *)
            const pShaderBytecodeWithInputSignature: Pointer;
            (* __in *)
            BytecodeLength: SIZE_T;
            (* __out_opt *)
            ppInputLayout: PID3D10InputLayout): HResult; stdcall;

    function CreateVertexShader(
            (* __in *)
            const pShaderBytecode: Pointer;
            (* __in *)
            BytecodeLength: SIZE_T;
            (* __out_opt *)
            ppVertexShader: PID3D10VertexShader): HResult; stdcall;

    function CreateGeometryShader(
            (* __in *)
            const pShaderBytecode: Pointer;
            (* __in *)
            BytecodeLength: SIZE_T;
            (* __out_opt *)
            ppGeometryShader: PID3D10GeometryShader): HResult; stdcall;

    function CreateGeometryShaderWithStreamOutput(
            (* __in *)
            const pShaderBytecode: Pointer;
            (* __in *)
            BytecodeLength: SIZE_T;
            (* __in_ecount_opt(NumEntries) *)
            const pSODeclaration: PD3D10_SO_DeclarationEntry;
            (* __in_range( 0, D3D10_SO_SINGLE_BUFFER_COMPONENT_LIMIT ) *)
            NumEntries: LongWord;
            (* __in *)
            OutputStreamStride: LongWord;
            (* __out_opt *)
            ppGeometryShader: PID3D10GeometryShader): HResult; stdcall;

    function CreatePixelShader(
            (* __in   *)
            const pShaderBytecode: Pointer;
            (* __in *)
            BytecodeLength: SIZE_T;
            (* __out_opt *)
            ppPixelShader: PID3D10PixelShader): HResult; stdcall;

    function CreateBlendState(
            (* __in *)
            const pBlendStateDesc: TD3D10_BlendDesc;
            (* __out_opt *)
            ppBlendState: PID3D10BlendState): HResult; stdcall;

    function CreateDepthStencilState(
            (* __in *)
            const pDepthStencilDesc: TD3D10_DepthStencilDesc;
            (* __out_opt *)
            ppDepthStencilState: PID3D10DepthStencilState): HResult; stdcall;

    function CreateRasterizerState(
            (* __in *)
            const pRasterizerDesc: TD3D10_RasterizerDesc;
            (* __out_opt *)
            ppRasterizerState: PID3D10RasterizerState): HResult; stdcall;

    function CreateSamplerState(
            (* __in *)
            const pSamplerDesc: TD3D10_SamplerDesc;
            (* __out_opt *)
            ppSamplerState: PID3D10SamplerState): HResult; stdcall;

    function CreateQuery(
            (* __in *)
            const pQueryDesc: TD3D10_QueryDesc;
            (* __out_opt *)
            ppQuery: PID3D10Query): HResult; stdcall;

    function CreatePredicate(
            (* __in *)
            const pPredicateDesc: TD3D10_QueryDesc;
            (* __out_opt *)
            ppPredicate: PID3D10Predicate): HResult; stdcall;

    function CreateCounter(
            (* __in *)
            const pCounterDesc: TD3D10_CounterDesc;
            (* __out_opt *)
            ppCounter: PID3D10Counter): HResult; stdcall;

    function CheckFormatSupport(
            (* __in *)
            Format: TDXGI_Format;
            (* __out *)
            out pFormatSupport: LongWord): HResult; stdcall;

    function CheckMultisampleQualityLevels(
            (* __in *)
            Format: TDXGI_Format;
            (* __in *)
            SampleCount: LongWord;
            (* __out *)
            out pNumQualityLevels: LongWord): HResult; stdcall;

    procedure CheckCounterInfo(
            (* __out *)
            out pCounterInfo: TD3D10_CounterInfo); stdcall;

        //todo: Check OUT - 6
    function CheckCounter(
            (* __in  *)
            const pDesc: TD3D10_CounterDesc;
            (* __out *)
            out pType: TD3D10_CounterType;
            (* __out *)
            out pActiveCounters: LongWord;
            (* __out_ecount_opt(*pNameLength) *)
            szName: PAnsiChar;
            (* __inout_opt *)
            pNameLength: PLongWord;
            (* __out_ecount_opt(*pUnitsLength) *)
            szUnits: PAnsiChar;
            (* __inout_opt *)
            pUnitsLength: PLongWord;
            (* __out_ecount_opt(*pDescriptionLength) *)
            szDescription: PAnsiChar;
            (* __inout_opt *)
            pDescriptionLength: PLongWord): HResult; stdcall;

    function GetCreationFlags(): LongWord; stdcall;

    function OpenSharedResource(
            (* __in *)
            hResource: THandle;
            (* __in *)
            const ReturnedInterface: TGUID;
            (* __out_opt *)
            ppResource: PPointer): HResult; stdcall;

    procedure SetTextFilterSize(
            (* __in *)
            Width: LongWord;
            (* __in *)
            Height: LongWord); stdcall;

    procedure GetTextFilterSize(
            (* __out_opt *)
            pWidth: PLongWord;
            (* __out_opt *)
            pHeight: PLongWord); stdcall;
  end;

  IID_ID3D10Device = ID3D10Device;
  {$EXTERNALSYM IID_ID3D10Device}



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10Multithread);'}
  {$EXTERNALSYM ID3D10Multithread}
  ID3D10Multithread = interface (IUnknown)
    ['{9B7E4E00-342C-4106-A19F-4F2704F689F0}']
    procedure Enter(); stdcall;

    procedure Leave(); stdcall;

    function SetMultithreadProtected(
            (* __in *)
            bMTProtect: BOOL): BOOL; stdcall;

    function GetMultithreadProtected(): BOOL; stdcall;
  end;

  IID_ID3D10Multithread = ID3D10Multithread;
  {$EXTERNALSYM IID_ID3D10Multithread}


  PD3D10_CreateDeviceFlag = ^TD3D10_CreateDeviceFlag;
  D3D10_CREATE_DEVICE_FLAG = LongWord;
  {$EXTERNALSYM D3D10_CREATE_DEVICE_FLAG}
  TD3D10_CreateDeviceFlag = D3D10_CREATE_DEVICE_FLAG;

const
  D3D10_CREATE_DEVICE_SINGLETHREADED = TD3D10_CreateDeviceFlag($1);
  {$EXTERNALSYM D3D10_CREATE_DEVICE_SINGLETHREADED}
  D3D10_CREATE_DEVICE_DEBUG	         = TD3D10_CreateDeviceFlag($2);
  {$EXTERNALSYM D3D10_CREATE_DEVICE_DEBUG}
  D3D10_CREATE_DEVICE_SWITCH_TO_REF	 = TD3D10_CreateDeviceFlag($4);
  {$EXTERNALSYM D3D10_CREATE_DEVICE_SWITCH_TO_REF}
  D3D10_CREATE_DEVICE_PREVENT_INTERNAL_THREADING_OPTIMIZATIONS	= TD3D10_CreateDeviceFlag($8);
  {$EXTERNALSYM D3D10_CREATE_DEVICE_PREVENT_INTERNAL_THREADING_OPTIMIZATIONS}
	D3D10_CREATE_DEVICE_ALLOW_NULL_FROM_MAP	= TD3D10_CreateDeviceFlag($10);
  {$EXTERNALSYM D3D10_CREATE_DEVICE_ALLOW_NULL_FROM_MAP}
	D3D10_CREATE_DEVICE_BGRA_SUPPORT	= TD3D10_CreateDeviceFlag($20);
  {$EXTERNALSYM D3D10_CREATE_DEVICE_BGRA_SUPPORT}


const
  D3D10_SDK_VERSION = 29;
  {$EXTERNALSYM D3D10_SDK_VERSION}


function D3D10CalcSubresource( MipSlice, ArraySlice, MipLevels: LongWord): UINT;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}

function ColorArray(a, b, c, d: Single): TColorArray;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}





//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//
//  File:       D3D10Misc.h
//  Content:    D3D10 Device Creation APIs
//
//////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////
// ID3D10Blob:
// ------------
// The buffer object is used by D3D10 to return arbitrary size data.
//
// GetBufferPointer -
//    Returns a pointer to the beginning of the buffer.
//
// GetBufferSize -
//    Returns the size of the buffer, in bytes.
///////////////////////////////////////////////////////////////////////////

type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10Blob);'}
  {$EXTERNALSYM ID3D10Blob}
  PID3D10Blob = ^ID3D10Blob;
  ID3D10Blob = interface (IUnknown)
    ['{8BA5FB08-5195-40e2-AC58-0D989C3A0102}']
    // ID3D10Blob
    function GetBufferPointer: Pointer; stdcall;
    function GetBufferSize: SIZE_T; stdcall;
  end;

  IID_ID3D10Blob = ID3D10Blob;


///////////////////////////////////////////////////////////////////////////
// D3D10_DRIVER_TYPE
// ----------------
//
// This identifier is used to determine the implementation of Direct3D10
// to be used.
//
// Pass one of these values to D3D10CreateDevice
//
///////////////////////////////////////////////////////////////////////////
  PD3D10_DriverType = ^TD3D10_DriverType;
  D3D10_DRIVER_TYPE = (
    D3D10_DRIVER_TYPE_HARDWARE  = 0,
    D3D10_DRIVER_TYPE_REFERENCE = 1,
    D3D10_DRIVER_TYPE_NULL      = 2,
    D3D10_DRIVER_TYPE_SOFTWARE  = 3,
    D3D10_DRIVER_TYPE_WARP      = 5
  );
  {$EXTERNALSYM D3D10_DRIVER_TYPE}
  TD3D10_DriverType = D3D10_DRIVER_TYPE;

const
  GUID_DeviceType: TGUID = '{d722fb4d-7a68-437a-b20c-5804ee2494a6}';
  {$EXTERNALSYM GUID_DeviceType}


///////////////////////////////////////////////////////////////////////////
// D3D10CreateDevice
// ------------------
//
// pAdapter
//      If NULL, D3D10CreateDevice will choose the primary adapter and
//      create a new instance from a temporarily created IDXGIFactory.
//      If non-NULL, D3D10CreateDevice will register the appropriate
//      device, if necessary (via IDXGIAdapter::RegisterDrver), before
//      creating the device.
// DriverType
//      Specifies the driver type to be created: hardware, reference or
//      null.
// Software
//      HMODULE of a DLL implementing a software rasterizer. Must be NULL for
//      non-Software driver types.
// Flags
//      Any of those documented for D3D10CreateDevice.
// SDKVersion
//      SDK version. Use the D3D10_SDK_VERSION macro.
// ppDevice
//      Pointer to returned interface.
//
// Return Values
//  Any of those documented for
//          CreateDXGIFactory
//          IDXGIFactory::EnumAdapters
//          IDXGIAdapter::RegisterDriver
//          D3D10CreateDevice
//
///////////////////////////////////////////////////////////////////////////
function D3D10CreateDevice(
    pAdapter: IDXGIAdapter;
    DriverType: TD3D10_DriverType;
    Software: HMODULE;
    Flags: LongWord;
    SDKVersion: LongWord;
    out ppDevice: ID3D10Device): HResult; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10CreateDevice}


///////////////////////////////////////////////////////////////////////////
// D3D10CreateDeviceAndSwapChain
// ------------------------------
//
// ppAdapter
//      If NULL, D3D10CreateDevice will choose the primary adapter and
//      create a new instance from a temporarily created IDXGIFactory.
//      If non-NULL, D3D10CreateDevice will register the appropriate
//      device, if necessary (via IDXGIAdapter::RegisterDrver), before
//      creating the device.
// DriverType
//      Specifies the driver type to be created: hardware, reference or
//      null.
// Software
//      HMODULE of a DLL implementing a software rasterizer. Must be NULL for
//      non-Software driver types.
// Flags
//      Any of those documented for D3D10CreateDevice.
// SDKVersion
//      SDK version. Use the D3D10_SDK_VERSION macro.
// pSwapChainDesc
//      Swap chain description, may be NULL.
// ppSwapChain
//      Pointer to returned interface. May be NULL.
// ppDevice
//      Pointer to returned interface.
//
// Return Values
//  Any of those documented for
//          CreateDXGIFactory
//          IDXGIFactory::EnumAdapters
//          IDXGIAdapter::RegisterDriver
//          D3D10CreateDevice
//          IDXGIFactory::CreateSwapChain
//
///////////////////////////////////////////////////////////////////////////
function D3D10CreateDeviceAndSwapChain(
    pAdapter: IDXGIAdapter;
    DriverType: TD3D10_DriverType;
    Software: HMODULE;
    Flags: LongWord;
    SDKVersion: LongWord;
    const pSwapChainDesc: TDXGI_SwapChainDesc;
    out ppSwapChain: IDXGISwapChain;
    out ppDevice: ID3D10Device): HResult; overload; deprecated; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10CreateDeviceAndSwapChain}

function D3D10CreateDeviceAndSwapChain(
    pAdapter: IDXGIAdapter;
    DriverType: TD3D10_DriverType;
    Software: HMODULE;
    Flags: LongWord;
    SDKVersion: LongWord;
    pSwapChainDesc: PDXGI_SwapChainDesc;
    out ppSwapChain: IDXGISwapChain;
    out ppDevice: ID3D10Device): HResult; overload; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10CreateDeviceAndSwapChain}


///////////////////////////////////////////////////////////////////////////
// D3D10CreateBlob:
// -----------------
// Creates a Buffer of n Bytes
//////////////////////////////////////////////////////////////////////////

function D3D10CreateBlob(NumBytes: SIZE_T; out ppBuffer: ID3D10Blob): HResult; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10CreateBlob}




//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//
//  File:       D3D10Shader.h
//  Content:    D3D10 Shader Types and APIs
//
//////////////////////////////////////////////////////////////////////////////


//---------------------------------------------------------------------------
// D3D10_TX_VERSION:
// --------------
// Version token used to create a procedural texture filler in effects
// Used by D3D10Fill[]TX functions
//---------------------------------------------------------------------------
//#define D3D10_TX_VERSION(_Major,_Minor) (('T' << 24) | ('X' << 16) | ((_Major) << 8) | (_Minor))
function D3D10_TX_VERSION(_Major, _Minor: Byte): DWORD; {$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
{$EXTERNALSYM D3D10_TX_VERSION}


//----------------------------------------------------------------------------
// D3D10SHADER flags:
// -----------------
// D3D10_SHADER_DEBUG
//   Insert debug file/line/type/symbol information.
//
// D3D10_SHADER_SKIP_VALIDATION
//   Do not validate the generated code against known capabilities and
//   constraints.  This option is only recommended when compiling shaders
//   you KNOW will work.  (ie. have compiled before without this option.)
//   Shaders are always validated by D3D before they are set to the device.
//
// D3D10_SHADER_SKIP_OPTIMIZATION
//   Instructs the compiler to skip optimization steps during code generation.
//   Unless you are trying to isolate a problem in your code using this option
//   is not recommended.
//
// D3D10_SHADER_PACK_MATRIX_ROW_MAJOR
//   Unless explicitly specified, matrices will be packed in row-major order
//   on input and output from the shader.
//
// D3D10_SHADER_PACK_MATRIX_COLUMN_MAJOR
//   Unless explicitly specified, matrices will be packed in column-major 
//   order on input and output from the shader.  This is generally more 
//   efficient, since it allows vector-matrix multiplication to be performed
//   using a series of dot-products.
//
// D3D10_SHADER_PARTIAL_PRECISION
//   Force all computations in resulting shader to occur at partial precision.
//   This may result in faster evaluation of shaders on some hardware.
//
// D3D10_SHADER_FORCE_VS_SOFTWARE_NO_OPT
//   Force compiler to compile against the next highest available software
//   target for vertex shaders.  This flag also turns optimizations off, 
//   and debugging on.  
//
// D3D10_SHADER_FORCE_PS_SOFTWARE_NO_OPT
//   Force compiler to compile against the next highest available software
//   target for pixel shaders.  This flag also turns optimizations off, 
//   and debugging on.
//
// D3D10_SHADER_NO_PRESHADER
//   Disables Preshaders. Using this flag will cause the compiler to not 
//   pull out static expression for evaluation on the host cpu
//
// D3D10_SHADER_AVOID_FLOW_CONTROL
//   Hint compiler to avoid flow-control constructs where possible.
//
// D3D10_SHADER_PREFER_FLOW_CONTROL
//   Hint compiler to prefer flow-control constructs where possible.
//
// D3D10_SHADER_ENABLE_STRICTNESS
//   By default, the HLSL/Effect compilers are not strict on deprecated syntax.
//   Specifying this flag enables the strict mode. Deprecated syntax may be
//   removed in a future release, and enabling syntax is a good way to make sure
//   your shaders comply to the latest spec.
//
// D3D10_SHADER_ENABLE_BACKWARDS_COMPATIBILITY
//   This enables older shaders to compile to 4_0 targets.
//
//----------------------------------------------------------------------------

const
  D3D10_SHADER_DEBUG                          = (1 shl 0);
  {$EXTERNALSYM D3D10_SHADER_DEBUG}
  D3D10_SHADER_SKIP_VALIDATION                = (1 shl 1);
  {$EXTERNALSYM D3D10_SHADER_SKIP_VALIDATION}
  D3D10_SHADER_SKIP_OPTIMIZATION              = (1 shl 2);
  {$EXTERNALSYM D3D10_SHADER_SKIP_OPTIMIZATION}
  D3D10_SHADER_PACK_MATRIX_ROW_MAJOR          = (1 shl 3);
  {$EXTERNALSYM D3D10_SHADER_PACK_MATRIX_ROW_MAJOR}
  D3D10_SHADER_PACK_MATRIX_COLUMN_MAJOR       = (1 shl 4);
  {$EXTERNALSYM D3D10_SHADER_PACK_MATRIX_COLUMN_MAJOR}
  D3D10_SHADER_PARTIAL_PRECISION              = (1 shl 5);
  {$EXTERNALSYM D3D10_SHADER_PARTIAL_PRECISION}
  D3D10_SHADER_FORCE_VS_SOFTWARE_NO_OPT       = (1 shl 6);
  {$EXTERNALSYM D3D10_SHADER_FORCE_VS_SOFTWARE_NO_OPT}
  D3D10_SHADER_FORCE_PS_SOFTWARE_NO_OPT       = (1 shl 7);
  {$EXTERNALSYM D3D10_SHADER_FORCE_PS_SOFTWARE_NO_OPT}
  D3D10_SHADER_NO_PRESHADER                   = (1 shl 8);
  {$EXTERNALSYM D3D10_SHADER_NO_PRESHADER}
  D3D10_SHADER_AVOID_FLOW_CONTROL             = (1 shl 9);
  {$EXTERNALSYM D3D10_SHADER_AVOID_FLOW_CONTROL}
  D3D10_SHADER_PREFER_FLOW_CONTROL            = (1 shl 10);
  {$EXTERNALSYM D3D10_SHADER_PREFER_FLOW_CONTROL}
  D3D10_SHADER_ENABLE_STRICTNESS              = (1 shl 11);
  {$EXTERNALSYM D3D10_SHADER_ENABLE_STRICTNESS}
  D3D10_SHADER_ENABLE_BACKWARDS_COMPATIBILITY = (1 shl 12);
  {$EXTERNALSYM D3D10_SHADER_ENABLE_BACKWARDS_COMPATIBILITY}
  D3D10_SHADER_IEEE_STRICTNESS                = (1 shl 13);
  {$EXTERNALSYM D3D10_SHADER_IEEE_STRICTNESS}


  // optimization level flags
  D3D10_SHADER_OPTIMIZATION_LEVEL0            = (1 shl 14);
  {$EXTERNALSYM D3D10_SHADER_OPTIMIZATION_LEVEL0}
  D3D10_SHADER_OPTIMIZATION_LEVEL1            = 0;
  {$EXTERNALSYM D3D10_SHADER_OPTIMIZATION_LEVEL1}
  D3D10_SHADER_OPTIMIZATION_LEVEL2            = ((1 shl 14) or (1 shl 15));
  {$EXTERNALSYM D3D10_SHADER_OPTIMIZATION_LEVEL2}
  D3D10_SHADER_OPTIMIZATION_LEVEL3            = (1 shl 15);
  {$EXTERNALSYM D3D10_SHADER_OPTIMIZATION_LEVEL3}




//----------------------------------------------------------------------------
// D3D10_SHADER_MACRO:
// ----------
// Preprocessor macro definition.  The application pass in a NULL-terminated
// array of this structure to various D3D10 APIs.  This enables the application
// to #define tokens at runtime, before the file is parsed.
//----------------------------------------------------------------------------

type
  PD3D10_ShaderMacro = ^TD3D10_ShaderMacro;
  _D3D10_SHADER_MACRO = record
    Name: PAnsiChar;
    Definition: PAnsiChar;
  end;
  {$EXTERNALSYM _D3D10_SHADER_MACRO}
  D3D10_SHADER_MACRO = _D3D10_SHADER_MACRO;
  {$EXTERNALSYM D3D10_SHADER_MACRO}
  TD3D10_ShaderMacro = _D3D10_SHADER_MACRO;


//----------------------------------------------------------------------------
// D3D10_SHADER_VARIABLE_CLASS:
//----------------------------------------------------------------------------

  PD3D10_ShaderVariableClass = ^TD3D10_ShaderVariableClass;
  _D3D10_SHADER_VARIABLE_CLASS = (
    D3D10_SVC_SCALAR,
    D3D10_SVC_VECTOR,
    D3D10_SVC_MATRIX_ROWS,
    D3D10_SVC_MATRIX_COLUMNS,
    D3D10_SVC_OBJECT,
    D3D10_SVC_STRUCT,

    D3D11_SVC_INTERFACE_CLASS,
    D3D11_SVC_INTERFACE_POINTER

    // force 32-bit size enum
    //D3D10_SVC_FORCE_DWORD = $7fffffff
  );
  {$EXTERNALSYM _D3D10_SHADER_VARIABLE_CLASS}
  D3D10_SHADER_VARIABLE_CLASS = _D3D10_SHADER_VARIABLE_CLASS;
  {$EXTERNALSYM D3D10_SHADER_VARIABLE_CLASS}
  TD3D10_ShaderVariableClass = _D3D10_SHADER_VARIABLE_CLASS;


  PD3D10_ShaderVariableFlags = ^TD3D10_ShaderVariableFlags;
  _D3D10_SHADER_VARIABLE_FLAGS = (
    D3D10_SVF_USERPACKED = 1,
    D3D10_SVF_USED       = 2,

    D3D11_SVF_INTERFACE_POINTER = 4,

    // force 32-bit size enum
    D3D10_SVF_FORCE_DWORD = $7fffffff
  );
  {$EXTERNALSYM _D3D10_SHADER_VARIABLE_FLAGS}
  D3D10_SHADER_VARIABLE_FLAGS = _D3D10_SHADER_VARIABLE_FLAGS;
  {$EXTERNALSYM D3D10_SHADER_VARIABLE_FLAGS}
  TD3D10_ShaderVariableFlags = _D3D10_SHADER_VARIABLE_FLAGS;


//----------------------------------------------------------------------------
// D3D10_SHADER_VARIABLE_TYPE:
//----------------------------------------------------------------------------

  PD3D10_ShaderVariableType = ^TD3D10_ShaderVariableType;
  _D3D10_SHADER_VARIABLE_TYPE = (
    D3D10_SVT_VOID = 0,
    D3D10_SVT_BOOL = 1,
    D3D10_SVT_INT = 2,
    D3D10_SVT_FLOAT = 3,
    D3D10_SVT_STRING = 4,
    D3D10_SVT_TEXTURE = 5,
    D3D10_SVT_TEXTURE1D = 6,
    D3D10_SVT_TEXTURE2D = 7,
    D3D10_SVT_TEXTURE3D = 8,
    D3D10_SVT_TEXTURECUBE = 9,
    D3D10_SVT_SAMPLER = 10,
    D3D10_SVT_PIXELSHADER = 15,
    D3D10_SVT_VERTEXSHADER = 16,
    D3D10_SVT_UINT = 19,
    D3D10_SVT_UINT8 = 20,
    D3D10_SVT_GEOMETRYSHADER = 21,
    D3D10_SVT_RASTERIZER = 22,
    D3D10_SVT_DEPTHSTENCIL = 23,
    D3D10_SVT_BLEND = 24,
    D3D10_SVT_BUFFER = 25,
    D3D10_SVT_CBUFFER = 26,
    D3D10_SVT_TBUFFER = 27,
    D3D10_SVT_TEXTURE1DARRAY = 28,
    D3D10_SVT_TEXTURE2DARRAY = 29,
    D3D10_SVT_RENDERTARGETVIEW = 30,
    D3D10_SVT_DEPTHSTENCILVIEW = 31,

    D3D10_SVT_TEXTURE2DMS = 32,
    D3D10_SVT_TEXTURE2DMSARRAY = 33,

    D3D10_SVT_TEXTURECUBEARRAY = 34,

    D3D11_SVT_HULLSHADER = 35,
    D3D11_SVT_DOMAINSHADER = 36,

    D3D11_SVT_INTERFACE_POINTER = 37,
    D3D11_SVT_COMPUTESHADER = 38,

    D3D11_SVT_DOUBLE = 39

    // force 32-bit size enum
    //D3D10_SVT_FORCE_DWORD = $7fffffff
  );
  {$EXTERNALSYM _D3D10_SHADER_VARIABLE_TYPE}
  D3D10_SHADER_VARIABLE_TYPE = _D3D10_SHADER_VARIABLE_TYPE;
  {$EXTERNALSYM D3D10_SHADER_VARIABLE_TYPE}
  TD3D10_ShaderVariableType = _D3D10_SHADER_VARIABLE_TYPE;


  PD3D10_ShaderInputFlags = ^TD3D10_ShaderInputFlags;
  _D3D10_SHADER_INPUT_FLAGS = (
    D3D10_SIF_USERPACKED = 1,
    D3D10_SIF_COMPARISON_SAMPLER = 2,  // is this a comparison sampler?
    D3D10_SIF_TEXTURE_COMPONENT_0 = 4, // this 2-bit value encodes c - 1, where c
    D3D10_SIF_TEXTURE_COMPONENT_1 = 8, // is the number of components in the texture
    D3D10_SIF_TEXTURE_COMPONENTS = 12,

    // force 32-bit size enum
    D3D10_SIF_FORCE_DWORD = $7fffffff
  );
  {$EXTERNALSYM _D3D10_SHADER_INPUT_FLAGS}
  D3D10_SHADER_INPUT_FLAGS = _D3D10_SHADER_INPUT_FLAGS;
  {$EXTERNALSYM D3D10_SHADER_INPUT_FLAGS}
  TD3D10_ShaderInputFlags = _D3D10_SHADER_INPUT_FLAGS;


//----------------------------------------------------------------------------
// D3D10_SHADER_INPUT_TYPE
//----------------------------------------------------------------------------

type
  PD3D10_ShaderInputType = ^TD3D10_ShaderInputType;
  _D3D10_SHADER_INPUT_TYPE = (
    D3D10_SIT_CBUFFER,
    D3D10_SIT_TBUFFER,
    D3D10_SIT_TEXTURE,
    D3D10_SIT_SAMPLER,
    D3D11_SIT_UAV_RWTYPED,
    D3D11_SIT_STRUCTURED,
    D3D11_SIT_UAV_RWSTRUCTURED,
    D3D11_SIT_BYTEADDRESS,
    D3D11_SIT_UAV_RWBYTEADDRESS,
    D3D11_SIT_UAV_APPEND_BYTEADDRESS,
    D3D11_SIT_UAV_CONSUME_BYTEADDRESS,
    D3D11_SIT_UAV_APPEND_STRUCTURED,
    D3D11_SIT_UAV_CONSUME_STRUCTURED
  );
  {$EXTERNALSYM _D3D10_SHADER_INPUT_TYPE}
  D3D10_SHADER_INPUT_TYPE = _D3D10_SHADER_INPUT_TYPE;
  {$EXTERNALSYM D3D10_SHADER_INPUT_TYPE}
  TD3D10_ShaderInputType = _D3D10_SHADER_INPUT_TYPE;


  PD3D10_ShaderCBufferFlags = ^TD3D10_ShaderCBufferFlags;
  _D3D10_SHADER_CBUFFER_FLAGS = (
    D3D10_CBF_USERPACKED = 1,

    // force 32-bit size enum
    D3D10_CBF_FORCE_DWORD = $7fffffff
  );
  {$EXTERNALSYM _D3D10_SHADER_CBUFFER_FLAGS}
  D3D10_SHADER_CBUFFER_FLAGS = _D3D10_SHADER_CBUFFER_FLAGS;
  {$EXTERNALSYM D3D10_SHADER_CBUFFER_FLAGS}
  TD3D10_ShaderCBufferFlags = _D3D10_SHADER_CBUFFER_FLAGS;

  
  PD3D10_CBufferType = ^TD3D10_CBufferType;
  _D3D10_CBUFFER_TYPE = (
    D3D10_CT_CBUFFER,
    D3D10_CT_TBUFFER
  );
  {$EXTERNALSYM _D3D10_CBUFFER_TYPE}
  D3D10_CBUFFER_TYPE = _D3D10_CBUFFER_TYPE;
  {$EXTERNALSYM D3D10_CBUFFER_TYPE}
  TD3D10_CBufferType = _D3D10_CBUFFER_TYPE;


  PD3D10_Name = ^TD3D10_Name;
  D3D10_NAME = (
    D3D10_NAME_UNDEFINED = 0,

    // Names meaningful to both HLSL and hardware
    D3D10_NAME_POSITION = 1,
    D3D10_NAME_CLIP_DISTANCE = 2,
    D3D10_NAME_CULL_DISTANCE = 3,
    D3D10_NAME_RENDER_TARGET_ARRAY_INDEX = 4,
    D3D10_NAME_VIEWPORT_ARRAY_INDEX = 5,
    D3D10_NAME_VERTEX_ID = 6,
    D3D10_NAME_PRIMITIVE_ID = 7,
    D3D10_NAME_INSTANCE_ID = 8,
    D3D10_NAME_IS_FRONT_FACE = 9,
    D3D10_NAME_SAMPLE_INDEX = 10,
    D3D11_NAME_FINAL_QUAD_EDGE_TESSFACTOR = 11, 
    D3D11_NAME_FINAL_QUAD_INSIDE_TESSFACTOR = 12, 
    D3D11_NAME_FINAL_TRI_EDGE_TESSFACTOR = 13, 
    D3D11_NAME_FINAL_TRI_INSIDE_TESSFACTOR = 14, 
    D3D11_NAME_FINAL_LINE_DETAIL_TESSFACTOR = 15,
    D3D11_NAME_FINAL_LINE_DENSITY_TESSFACTOR = 16,

    // Names meaningful to HLSL only
    D3D10_NAME_TARGET = 64,
    D3D10_NAME_DEPTH = 65,
    D3D10_NAME_COVERAGE = 66,
    D3D11_NAME_DEPTH_GREATER_EQUAL = 67,
    D3D11_NAME_DEPTH_LESS_EQUAL = 68
  );
  {$EXTERNALSYM D3D10_NAME}
  TD3D10_Name = D3D10_NAME;


  PD3D10_ResourceReturnType = ^TD3D10_ResourceReturnType;
  D3D10_RESOURCE_RETURN_TYPE = (
    D3D10_RETURN_TYPE_UNORM = 1,
    D3D10_RETURN_TYPE_SNORM = 2,
    D3D10_RETURN_TYPE_SINT = 3,
    D3D10_RETURN_TYPE_UINT = 4,
    D3D10_RETURN_TYPE_FLOAT = 5,
    D3D10_RETURN_TYPE_MIXED = 6
  );
  {$EXTERNALSYM D3D10_RESOURCE_RETURN_TYPE}
  TD3D10_ResourceReturnType = D3D10_RESOURCE_RETURN_TYPE;


  PD3D10_RegisterComponentType = ^TD3D10_RegisterComponentType;
  D3D10_REGISTER_COMPONENT_TYPE = (
    D3D10_REGISTER_COMPONENT_UNKNOWN = 0,
    D3D10_REGISTER_COMPONENT_UINT32 = 1,
    D3D10_REGISTER_COMPONENT_SINT32 = 2,
    D3D10_REGISTER_COMPONENT_FLOAT32 = 3
  );
  {$EXTERNALSYM D3D10_REGISTER_COMPONENT_TYPE}
  TD3D10_RegisterComponentType = D3D10_REGISTER_COMPONENT_TYPE;


//----------------------------------------------------------------------------
// D3D10_INCLUDE_TYPE:
//----------------------------------------------------------------------------

  PD3D10_IncludeType = ^TD3D10_IncludeType;
  _D3D10_INCLUDE_TYPE = (
    D3D10_INCLUDE_LOCAL,
    D3D10_INCLUDE_SYSTEM

    // force 32-bit size enum
    // D3D10_INCLUDE_FORCE_DWORD = 0x7fffffff
  );
  {$EXTERNALSYM _D3D10_INCLUDE_TYPE}
  D3D10_INCLUDE_TYPE = _D3D10_INCLUDE_TYPE;
  {$EXTERNALSYM D3D10_INCLUDE_TYPE}
  TD3D10_IncludeType = _D3D10_INCLUDE_TYPE;


//----------------------------------------------------------------------------
// ID3D10Include:
// -------------
// This interface is intended to be implemented by the application, and can
// be used by various D3D10 APIs.  This enables application-specific handling
// of #include directives in source files.
//
// Open()
//    Opens an include file.  If successful, it should fill in ppData and
//    pBytes.  The data pointer returned must remain valid until Close is
//    subsequently called.  The name of the file is encoded in UTF-8 format.
// Close()
//    Closes an include file.  If Open was successful, Close is guaranteed
//    to be called before the API using this interface returns.
//----------------------------------------------------------------------------

  {$EXTERNALSYM ID3D10Include}
  {$IFDEF FPC}{$INTERFACES CORBA} { To expose FreePascal class as abstract C++ class }{$ENDIF}
  ID3D10Include = {$IFDEF FPC}interface{$ELSE}class{$ENDIF}
    function Open(IncludeType: TD3D10_IncludeType; pFileName: PAnsiChar; pParentData: Pointer; out ppData: Pointer; out pBytes: LongWord): HResult; {$IFDEF FPC}stdcall{$ELSE}virtual; stdcall; abstract{$ENDIF};
    function Close(pData: Pointer): HResult; {$IFDEF FPC}stdcall{$ELSE}virtual; stdcall; abstract{$ENDIF};
  end;
  {$IFDEF FPC}{$INTERFACES DEFAULT}{$ENDIF}


//----------------------------------------------------------------------------
// ID3D10ShaderReflection:
//----------------------------------------------------------------------------

//
// Structure definitions
//

  PD3D10_ShaderDesc = ^TD3D10_ShaderDesc;
  _D3D10_SHADER_DESC = record
    Version:                     LongWord;   // Shader version
    Creator:                     PAnsiChar;  // Creator string
    Flags:                       LongWord;   // Shader compilation/parse flags

    ConstantBuffers:             LongWord;   // Number of constant buffers
    BoundResources:              LongWord;   // Number of bound resources
    InputParameters:             LongWord;   // Number of parameters in the input signature
    OutputParameters:            LongWord;   // Number of parameters in the output signature

    InstructionCount:            LongWord;   // Number of emitted instructions
    TempRegisterCount:           LongWord;   // Number of temporary registers used
    TempArrayCount:              LongWord;   // Number of temporary arrays used
    DefCount:                    LongWord;   // Number of constant defines
    DclCount:                    LongWord;   // Number of declarations (input + output)
    TextureNormalInstructions:   LongWord;   // Number of non-categorized texture instructions
    TextureLoadInstructions:     LongWord;   // Number of texture load instructions
    TextureCompInstructions:     LongWord;   // Number of texture comparison instructions
    TextureBiasInstructions:     LongWord;   // Number of texture bias instructions
    TextureGradientInstructions: LongWord;   // Number of texture gradient instructions
    FloatInstructionCount:       LongWord;   // Number of floating point arithmetic instructions used
    IntInstructionCount:         LongWord;   // Number of signed integer arithmetic instructions used
    UintInstructionCount:        LongWord;   // Number of unsigned integer arithmetic instructions used
    StaticFlowControlCount:      LongWord;   // Number of static flow control instructions used
    DynamicFlowControlCount:     LongWord;   // Number of dynamic flow control instructions used
    MacroInstructionCount:       LongWord;   // Number of macro instructions used
    ArrayInstructionCount:       LongWord;   // Number of array instructions used
    CutInstructionCount:         LongWord;   // Number of cut instructions used
    EmitInstructionCount:        LongWord;   // Number of emit instructions used
    GSOutputTopology:            TD3D10_PrimitiveTopology; // Geometry shader output topology
    GSMaxOutputVertexCount:      LongWord;   // Geometry shader maximum output vertex count
  end;
  {$EXTERNALSYM _D3D10_SHADER_DESC}
  D3D10_SHADER_DESC = _D3D10_SHADER_DESC;
  {$EXTERNALSYM D3D10_SHADER_DESC}
  TD3D10_ShaderDesc = _D3D10_SHADER_DESC;


  PD3D10_ShaderBufferDesc = ^TD3D10_ShaderBufferDesc;
  _D3D10_SHADER_BUFFER_DESC = record
    Name: PAnsiChar;               // Name of the constant buffer
    Type_: TD3D10_CBufferType;     // Indicates that this is a CBuffer or TBuffer
    Variables: LongWord;           // Number of member variables
    Size: LongWord;                // Size of CB (in bytes)
    uFlags: LongWord;              // Buffer description flags
  end;
  {$EXTERNALSYM _D3D10_SHADER_BUFFER_DESC}
  D3D10_SHADER_BUFFER_DESC = _D3D10_SHADER_BUFFER_DESC;
  {$EXTERNALSYM D3D10_SHADER_BUFFER_DESC}
  TD3D10_ShaderBufferDesc = _D3D10_SHADER_BUFFER_DESC;


  PD3D10_ShaderVariableDesc = ^TD3D10_ShaderVariableDesc;
  _D3D10_SHADER_VARIABLE_DESC = record
    Name: PAnsiChar;               // Name of the variable
    StartOffset: LongWord;         // Offset in constant buffer's backing store
    Size: LongWord;                // Size of variable (in bytes)
    DefaultValue: Pointer;         // Raw pointer to default value
    uFlags: LongWord;              // Variable flags
  end;
  {$EXTERNALSYM _D3D10_SHADER_VARIABLE_DESC}
  D3D10_SHADER_VARIABLE_DESC = _D3D10_SHADER_VARIABLE_DESC;
  {$EXTERNALSYM D3D10_SHADER_VARIABLE_DESC}
  TD3D10_ShaderVariableDesc = _D3D10_SHADER_VARIABLE_DESC;


  PD3D10_ShaderTypeDesc = ^TD3D10_ShaderTypeDesc;
  _D3D10_SHADER_TYPE_DESC = record
    Class_: TD3D10_ShaderVariableClass; // Variable class (e.g. object, matrix, etc.)
    Type_: TD3D10_ShaderVariableType;   // Variable type (e.g. float, sampler, etc.)
    Rows: LongWord;                // Number of rows (for matrices, 1 for other numeric, 0 if not applicable)
    Columns: LongWord;             // Number of columns (for vectors & matrices, 1 for other numeric, 0 if not applicable)
    Elements: LongWord;            // Number of elements (0 if not an array)
    Members: LongWord;             // Number of members (0 if not a structure)
    Offset: LongWord;              // Offset from the start of structure (0 if not a structure member) 
  end;
  {$EXTERNALSYM _D3D10_SHADER_TYPE_DESC}
  D3D10_SHADER_TYPE_DESC = _D3D10_SHADER_TYPE_DESC;
  {$EXTERNALSYM D3D10_SHADER_TYPE_DESC}
  TD3D10_ShaderTypeDesc = _D3D10_SHADER_TYPE_DESC;


  PD3D10_ShaderInputBindDesc = ^TD3D10_ShaderInputBindDesc;
  _D3D10_SHADER_INPUT_BIND_DESC = record
    Name: PAnsiChar;               // Name of the resource
    Type_: TD3D10_ShaderInputType; // Type of resource (e.g. texture, cbuffer, etc.)
    BindPoint: LongWord;           // Starting bind point
    BindCount: LongWord;           // Number of contiguous bind points (for arrays)

    uFlags: LongWord;              // Input binding flags
    ReturnType: TD3D10_ResourceReturnType; // Return type (if texture)
    Dimension: TD3D10_SRV_Dimension; // Dimension (if texture)
    NumSamples: LongWord;          // Number of samples (0 if not MS texture)
  end;
  {$EXTERNALSYM _D3D10_SHADER_INPUT_BIND_DESC}
  D3D10_SHADER_INPUT_BIND_DESC = _D3D10_SHADER_INPUT_BIND_DESC;
  {$EXTERNALSYM D3D10_SHADER_INPUT_BIND_DESC}
  TD3D10_ShaderInputBindDesc = _D3D10_SHADER_INPUT_BIND_DESC;


  PD3D10_SignatureParameterDesc = ^TD3D10_SignatureParameterDesc;
  _D3D10_SIGNATURE_PARAMETER_DESC = record
    SemanticName: PAnsiChar;       // Name of the semantic
    SemanticIndex: LongWord;       // Index of the semantic
    Register: LongWord;            // Number of member variables
    SystemValueType: TD3D10_Name;  // A predefined system value, or D3D10_NAME_UNDEFINED if not applicable
    ComponentType: TD3D10_RegisterComponentType; // Scalar type (e.g. uint, float, etc.)
    Mask: Byte;                    // Mask to indicate which components of the register
                                   // are used (combination of D3D10_COMPONENT_MASK values)
    ReadWriteMask: Byte;           // Mask to indicate whether a given component is
                                   // never written (if this is an output signature) or
                                   // always read (if this is an input signature).
                                   // (combination of D3D10_COMPONENT_MASK values)
  end;
  {$EXTERNALSYM _D3D10_SIGNATURE_PARAMETER_DESC}
  D3D10_SIGNATURE_PARAMETER_DESC = _D3D10_SIGNATURE_PARAMETER_DESC;
  {$EXTERNALSYM D3D10_SIGNATURE_PARAMETER_DESC}
  TD3D10_SignatureParameterDesc = _D3D10_SIGNATURE_PARAMETER_DESC;


//
// Interface definitions
//

  {$EXTERNALSYM ID3D10ShaderReflectionType}
  {$IFDEF FPC}{$INTERFACES CORBA} { To expose FreePascal class as abstract C++ class }{$ENDIF}
  ID3D10ShaderReflectionType = {$IFDEF FPC}interface{$ELSE}class{$ENDIF}
    function GetDesc(out pDesc: TD3D10_ShaderTypeDesc): HResult; {$IFDEF FPC}stdcall{$ELSE}virtual; stdcall; abstract{$ENDIF};

    function GetMemberTypeByIndex(Index: LongWord): ID3D10ShaderReflectionType; {$IFDEF FPC}stdcall{$ELSE}virtual; stdcall; abstract{$ENDIF};
    function GetMemberTypeByName(Name: LPCSTR): ID3D10ShaderReflectionType; {$IFDEF FPC}stdcall{$ELSE}virtual; stdcall; abstract{$ENDIF};
    function GetMemberTypeName(Index: LongWord): LPCSTR; {$IFDEF FPC}stdcall{$ELSE}virtual; stdcall; abstract{$ENDIF};
  end;
  {$IFDEF FPC}{$INTERFACES DEFAULT}{$ENDIF}

  {$EXTERNALSYM ID3D10ShaderReflectionVariable}
  {$IFDEF FPC}{$INTERFACES CORBA} { To expose FreePascal class as abstract C++ class }{$ENDIF}
  ID3D10ShaderReflectionVariable = {$IFDEF FPC}interface{$ELSE}class{$ENDIF}
    function GetDesc(out pDesc: TD3D10_ShaderVariableDesc): HResult; {$IFDEF FPC}stdcall{$ELSE}virtual; stdcall; abstract{$ENDIF};

    function GetType: ID3D10ShaderReflectionType; {$IFDEF FPC}stdcall{$ELSE}virtual; stdcall; abstract{$ENDIF};
  end;
  {$IFDEF FPC}{$INTERFACES DEFAULT}{$ENDIF}


  {$EXTERNALSYM ID3D10ShaderReflectionConstantBuffer}
  {$IFDEF FPC}{$INTERFACES CORBA} { To expose FreePascal class as abstract C++ class }{$ENDIF}
  ID3D10ShaderReflectionConstantBuffer = {$IFDEF FPC}interface{$ELSE}class{$ENDIF}
    function GetDesc(out pDesc: TD3D10_ShaderBufferDesc): HResult; {$IFDEF FPC}stdcall{$ELSE}virtual; stdcall; abstract{$ENDIF};

    function GetVariableByIndex(Index: LongWord): ID3D10ShaderReflectionVariable; {$IFDEF FPC}stdcall{$ELSE}virtual; stdcall; abstract{$ENDIF};
    function GetVariableByName(Name: PAnsiChar): ID3D10ShaderReflectionVariable; {$IFDEF FPC}stdcall{$ELSE}virtual; stdcall; abstract{$ENDIF};
  end;
  {$IFDEF FPC}{$INTERFACES DEFAULT}{$ENDIF}

const
  // {C530AD7D-9B16-4395-A979-BA2ECFF83ADD}
  IID_ID3D10ShaderReflectionType: TGUID = '{c530ad7d-9b16-4395-a979-ba2ecff83add}';
  {$EXTERNALSYM IID_ID3D10ShaderReflectionType}
  // {1BF63C95-2650-405d-99C1-3636BD1DA0A1}
  IID_ID3D10ShaderReflectionVariable: TGUID = '{1bf63c95-2650-405d-99c1-3636bd1da0a1}';
  {$EXTERNALSYM IID_ID3D10ShaderReflectionVariable}
  // {66C66A94-DDDD-4b62-A66A-F0DA33C2B4D0}
  IID_ID3D10ShaderReflectionConstantBuffer: TGUID = '{66c66a94-dddd-4b62-a66a-f0da33c2b4d0}';
  {$EXTERNALSYM IID_ID3D10ShaderReflectionConstantBuffer}


type
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10ShaderReflection);'}
  {$EXTERNALSYM ID3D10ShaderReflection}
  ID3D10ShaderReflection = interface (IUnknown)
    ['{D40E20B6-F8F7-42ad-AB20-4BAF8F15DFAA}']
    function GetDesc(out pDesc: TD3D10_ShaderDesc): HResult; stdcall;

    function GetConstantBufferByIndex(Index: LongWord): ID3D10ShaderReflectionConstantBuffer; stdcall;
    function GetConstantBufferByName(Name: PAnsiChar): ID3D10ShaderReflectionConstantBuffer; stdcall;

    function GetResourceBindingDesc(ResourceIndex: LongWord; out pDesc: TD3D10_ShaderInputBindDesc): HResult; stdcall;

    function GetInputParameterDesc(ParameterIndex: LongWord; pDesc: TD3D10_SignatureParameterDesc): HResult; stdcall;
    function GetOutputParameterDesc(ParameterIndex: LongWord; pDesc: TD3D10_SignatureParameterDesc): HResult; stdcall;
  end;

  IID_ID3D10ShaderReflection = ID3D10ShaderReflection;
  {$EXTERNALSYM IID_ID3D10ShaderReflection}


//////////////////////////////////////////////////////////////////////////////
// APIs //////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////



//----------------------------------------------------------------------------
// D3D10CompileShader:
// ------------------
// Compiles a shader.
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
//      Instruction set to be used when generating code.  The D3D10 entry
//      point currently supports only "vs_4_0", "ps_4_0", and "gs_4_0".
//  Flags
//      See D3D10_SHADER_xxx flags.
//  ppShader
//      Returns a buffer containing the created shader.  This buffer contains
//      the compiled shader code, as well as any embedded debug and symbol
//      table info.  (See D3D10GetShaderConstantTable)
//  ppErrorMsgs
//      Returns a buffer containing a listing of errors and warnings that were
//      encountered during the compile.  If you are running in a debugger,
//      these are the same messages you will see in your debug output.
//----------------------------------------------------------------------------

function D3D10CompileShader(pSrcData: PAnsiChar; SrcDataLen: SIZE_T;
    pFileName: PAnsiChar; const pDefines: PD3D10_ShaderMacro; pInclude: ID3D10Include;
    pFunctionName: PAnsiChar; pProfile: PAnsiChar; Flags: LongWord;
    out ppShader: ID3D10Blob; ppErrorMsgs: PID3D10Blob): HRESULT; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10CompileShader}

//----------------------------------------------------------------------------
// D3D10DisassembleShader:
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

function D3D10DisassembleShader(const pShader: Pointer; BytecodeLength: SIZE_T;
  EnableColorCode: BOOL; pComments: PAnsiChar; out ppDisassembly: ID3D10Blob): HRESULT; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10DisassembleShader}


//----------------------------------------------------------------------------
// D3D10GetPixelShaderProfile/D3D10GetVertexShaderProfile/D3D10GetGeometryShaderProfile:
// -----------------------------------------------------
// Returns the name of the HLSL profile best suited to a given device.
//
// Parameters:
//  pDevice
//      Pointer to the device in question
//----------------------------------------------------------------------------

function D3D10GetPixelShaderProfile(const pDevice: ID3D10Device): PAnsiChar; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10GetPixelShaderProfile}

function D3D10GetVertexShaderProfile(const pDevice: ID3D10Device): PAnsiChar; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10GetVertexShaderProfile}

function D3D10GetGeometryShaderProfile(const pDevice: ID3D10Device): PAnsiChar; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10GetGeometryShaderProfile}


//----------------------------------------------------------------------------
// D3D10ReflectShader:
// ------------------
// Creates a shader reflection object that can be used to retrieve information
// about a compiled shader
//
// Parameters:
//  pShaderBytecode
//      Pointer to a compiled shader (same pointer that is passed into
//      ID3D10Device::CreateShader)
//  BytecodeLength
//      Length of the shader bytecode buffer
//  ppReflector
//      [out] Returns a ID3D10ShaderReflection object that can be used to
//      retrieve shader resource and constant buffer information
//
//----------------------------------------------------------------------------

function D3D10ReflectShader(const pShaderBytecode: Pointer; BytecodeLength: SIZE_T;
    out ppReflector: ID3D10ShaderReflection): HRESULT; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10ReflectShader}

//----------------------------------------------------------------------------
// D3D10PreprocessShader
// ---------------------
// Creates a shader reflection object that can be used to retrieve information
// about a compiled shader
//
// Parameters:
//  pSrcData
//      Pointer to source code
//  SrcDataLen
//      Size of source code, in bytes
//  pFileName
//      Source file name (used for error output)
//  pDefines
//      Optional NULL-terminated array of preprocessor macro definitions.
//  pInclude
//      Optional interface pointer to use for handling #include directives.
//      If this parameter is NULL, #includes will be honored when assembling
//      from file, and will error when assembling from resource or memory.
//  ppShaderText
//      Returns a buffer containing a single large string that represents
//      the resulting formatted token stream
//  ppErrorMsgs
//      Returns a buffer containing a listing of errors and warnings that were
//      encountered during assembly.  If you are running in a debugger,
//      these are the same messages you will see in your debug output.
//----------------------------------------------------------------------------

function D3D10PreprocessShader(pSrcData: PAnsiChar; SrcDataSize: SIZE_T;
    pFileName: PAnsiChar; const pDefines: PD3D10_ShaderMacro; pInclude: ID3D10Include;
    out ppShaderText: ID3D10Blob; ppErrorMsgs: PID3D10Blob): HRESULT; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10PreprocessShader}

//////////////////////////////////////////////////////////////////////////
//
// Shader blob manipulation routines
// ---------------------------------
//
// void *pShaderBytecode - a buffer containing the result of an HLSL
//  compilation.  Typically this opaque buffer contains several
//  discrete sections including the shader executable code, the input
//  signature, and the output signature.  This can typically be retrieved 
//  by calling ID3D10Blob::GetBufferPointer() on the returned blob
//  from HLSL's compile APIs.
//
// UINT BytecodeLength - the length of pShaderBytecode.  This can 
//  typically be retrieved by calling ID3D10Blob::GetBufferSize() 
//  on the returned blob from HLSL's compile APIs.
//
// ID3D10Blob **ppSignatureBlob(s) - a newly created buffer that
//  contains only the signature portions of the original bytecode.
//  This is a copy; the original bytecode is not modified.  You may
//  specify NULL for this parameter to have the bytecode validated
//  for the presence of the corresponding signatures without actually
//  copying them and creating a new blob.
//
// Returns E_INVALIDARG if any required parameters are NULL
// Returns E_FAIL is the bytecode is corrupt or missing signatures
// Returns S_OK on success
//
//////////////////////////////////////////////////////////////////////////

function D3D10GetInputSignatureBlob(const pShaderBytecode: Pointer; BytecodeLength: SIZE_T; out ppSignatureBlob: ID3D10Blob): HRESULT; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10GetInputSignatureBlob}
function D3D10GetOutputSignatureBlob(const pShaderBytecode: Pointer; BytecodeLength: SIZE_T; out ppSignatureBlob: ID3D10Blob): HRESULT; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10GetOutputSignatureBlob}
function D3D10GetInputAndOutputSignatureBlob(const pShaderBytecode: Pointer; BytecodeLength: SIZE_T; out ppSignatureBlob: ID3D10Blob): HRESULT; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10GetInputAndOutputSignatureBlob}


//----------------------------------------------------------------------------
// D3D10GetShaderDebugInfo:
// -----------------------
// Gets shader debug info.  Debug info is generated by D3D10CompileShader and is
// embedded in the body of the shader.
//
// Parameters:
//  pShaderBytecode
//      Pointer to the function bytecode
//  BytecodeLength
//      Length of the shader bytecode buffer
//  ppDebugInfo
//      Buffer used to return debug info.  For information about the layout
//      of this buffer, see definition of D3D10_SHADER_DEBUG_INFO above.
//----------------------------------------------------------------------------

function D3D10GetShaderDebugInfo(const pShaderBytecode: Pointer; BytecodeLength: SIZE_T; out ppDebugInfo: ID3D10Blob): HRESULT; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10GetShaderDebugInfo}





//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//
//  File:       D3D10Effect.h
//  Content:    D3D10 Stateblock/Effect Types & APIs
//
//////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////
// File contents:
//
// 1) Stateblock enums, structs, interfaces, flat APIs
// 2) Effect enums, structs, interfaces, flat APIs
//////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------
// D3D10_DEVICE_STATE_TYPES:
//
// Used in ID3D10StateBlockMask function calls
//
//----------------------------------------------------------------------------

type
  PD3D10_DeviceStateTypes = ^TD3D10_DeviceStateTypes;
  _D3D10_DEVICE_STATE_TYPES = (
    D3D10_DST_INVALID_0,
    D3D10_DST_SO_BUFFERS{=1},           // Single-value state (atomical gets/sets)
    D3D10_DST_OM_RENDER_TARGETS,        // Single-value state (atomical gets/sets)
    D3D10_DST_OM_DEPTH_STENCIL_STATE,   // Single-value state
    D3D10_DST_OM_BLEND_STATE,           // Single-value state

    D3D10_DST_VS,                       // Single-value state
    D3D10_DST_VS_SAMPLERS,              // Count: D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT
    D3D10_DST_VS_SHADER_RESOURCES,      // Count: D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT
    D3D10_DST_VS_CONSTANT_BUFFERS,      // Count:

    D3D10_DST_GS,                       // Single-value state
    D3D10_DST_GS_SAMPLERS,              // Count: D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT
    D3D10_DST_GS_SHADER_RESOURCES,      // Count: D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT
    D3D10_DST_GS_CONSTANT_BUFFERS,      // Count: D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT

    D3D10_DST_PS,                       // Single-value state
    D3D10_DST_PS_SAMPLERS,              // Count: D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT
    D3D10_DST_PS_SHADER_RESOURCES,      // Count: D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT
    D3D10_DST_PS_CONSTANT_BUFFERS,      // Count: D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT

    D3D10_DST_IA_VERTEX_BUFFERS,        // Count: D3D10_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT
    D3D10_DST_IA_INDEX_BUFFER,          // Single-value state
    D3D10_DST_IA_INPUT_LAYOUT,          // Single-value state
    D3D10_DST_IA_PRIMITIVE_TOPOLOGY,    // Single-value state

    D3D10_DST_RS_VIEWPORTS,             // Single-value state (atomical gets/sets)
    D3D10_DST_RS_SCISSOR_RECTS,         // Single-value state (atomical gets/sets)
    D3D10_DST_RS_RASTERIZER_STATE,      // Single-value state

    D3D10_DST_PREDICATION               // Single-value state
  );
  {$EXTERNALSYM _D3D10_DEVICE_STATE_TYPES}
  D3D10_DEVICE_STATE_TYPES = _D3D10_DEVICE_STATE_TYPES;
  {$EXTERNALSYM D3D10_DEVICE_STATE_TYPES}
  TD3D10_DeviceStateTypes = _D3D10_DEVICE_STATE_TYPES;


//----------------------------------------------------------------------------
// D3D10_DEVICE_STATE_TYPES:
//
// Used in ID3D10StateBlockMask function calls
//
//----------------------------------------------------------------------------

// #define D3D10_BYTES_FROM_BITS(x) (((x) + 7) / 8)
function D3D10_BYTES_FROM_BITS(x: DWORD): DWORD;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}

type
  PD3D10_StateBlockMask = ^TD3D10_StateBlockMask;
  _D3D10_STATE_BLOCK_MASK = record
    VS: Byte;
//todo: FIX ME!!!    
(*  VSSamplers: array [0..D3D10_BYTES_FROM_BITS(D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT)-1] of Byte;
    BYTE VSShaderResources[D3D10_BYTES_FROM_BITS(D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT)];
    BYTE VSConstantBuffers[D3D10_BYTES_FROM_BITS(D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT)];

    GS: Byte;
    BYTE GSSamplers[D3D10_BYTES_FROM_BITS(D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT)];
    BYTE GSShaderResources[D3D10_BYTES_FROM_BITS(D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT)];
    BYTE GSConstantBuffers[D3D10_BYTES_FROM_BITS(D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT)];

    PS: Byte;
    BYTE PSSamplers[D3D10_BYTES_FROM_BITS(D3D10_COMMONSHADER_SAMPLER_SLOT_COUNT)];
    BYTE PSShaderResources[D3D10_BYTES_FROM_BITS(D3D10_COMMONSHADER_INPUT_RESOURCE_SLOT_COUNT)];
    BYTE PSConstantBuffers[D3D10_BYTES_FROM_BITS(D3D10_COMMONSHADER_CONSTANT_BUFFER_API_SLOT_COUNT)];

    BYTE IAVertexBuffers[D3D10_BYTES_FROM_BITS(D3D10_IA_VERTEX_INPUT_RESOURCE_SLOT_COUNT)];
*)    IAIndexBuffer: Byte;
    IAInputLayout: Byte;
    IAPrimitiveTopology: Byte;

    OMRenderTargets: Byte;
    OMDepthStencilState: Byte;
    OMBlendState: Byte;

    RSViewports: Byte;
    RSScissorRects: Byte;
    RSRasterizerState: Byte;

    SOBuffers: Byte;

    Predication: Byte;
  end;
  {$EXTERNALSYM _D3D10_STATE_BLOCK_MASK}
  D3D10_STATE_BLOCK_MASK = _D3D10_STATE_BLOCK_MASK;
  {$EXTERNALSYM D3D10_STATE_BLOCK_MASK}
  TD3D10_StateBlockMask = _D3D10_STATE_BLOCK_MASK;


//////////////////////////////////////////////////////////////////////////////
// ID3D10StateBlock //////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10StateBlock);'}
  {$EXTERNALSYM ID3D10StateBlock}
  ID3D10StateBlock = interface (IUnknown)
    ['{0803425A-57F5-4dd6-9465-A87570834A08}']
    function Capture(): HResult; stdcall;
    function Apply(): HResult; stdcall;
    function ReleaseAllDeviceObjects(): HResult; stdcall;
    function GetDevice(out ppDevice: ID3D10Device): HResult; stdcall;
  end;

  IID_ID3D10StateBlock = ID3D10StateBlock;
  {$EXTERNALSYM IID_ID3D10StateBlock}


//----------------------------------------------------------------------------
// D3D10_STATE_BLOCK_MASK and manipulation functions
// -------------------------------------------------
//
// These functions exist to facilitate working with the D3D10_STATE_BLOCK_MASK
// structure.
//
// D3D10_STATE_BLOCK_MASK *pResult or *pMask
//   The state block mask to operate on
//
// D3D10_STATE_BLOCK_MASK *pA, *pB
//   The source state block masks for the binary union/intersect/difference
//   operations.
//
// D3D10_DEVICE_STATE_TYPES StateType
//   The specific state type to enable/disable/query
//
// UINT RangeStart, RangeLength, Entry
//   The specific bit or range of bits for a given state type to operate on.
//   Consult the comments for D3D10_DEVICE_STATE_TYPES and
//   D3D10_STATE_BLOCK_MASK for information on the valid bit ranges for
//   each state.
//
//----------------------------------------------------------------------------

function D3D10StateBlockMaskUnion(const pA, pB: TD3D10_StateBlockMask; out pResult: TD3D10_StateBlockMask): HResult; external D3D10dll;
{$EXTERNALSYM D3D10StateBlockMaskUnion}
function D3D10StateBlockMaskIntersect(const pA, pB: TD3D10_StateBlockMask; out pResult: TD3D10_StateBlockMask): HResult; external D3D10dll;
{$EXTERNALSYM D3D10StateBlockMaskIntersect}
function D3D10StateBlockMaskDifference(const pA, pB: TD3D10_StateBlockMask; out pResult: TD3D10_StateBlockMask): HResult; external D3D10dll;
{$EXTERNALSYM D3D10StateBlockMaskDifference}
function D3D10StateBlockMaskEnableCapture(var pMask: TD3D10_StateBlockMask; StateType: TD3D10_DeviceStateTypes; RangeStart, RangeLength: LongWord): HResult; external D3D10dll;
{$EXTERNALSYM D3D10StateBlockMaskEnableCapture}
function D3D10StateBlockMaskDisableCapture(var pMask: TD3D10_StateBlockMask; StateType: TD3D10_DeviceStateTypes; RangeStart, RangeLength: LongWord): HResult; external D3D10dll;
{$EXTERNALSYM D3D10StateBlockMaskDisableCapture}
function D3D10StateBlockMaskEnableAll(var pMask: TD3D10_StateBlockMask): HResult; external D3D10dll;
{$EXTERNALSYM D3D10StateBlockMaskEnableAll}
function D3D10StateBlockMaskDisableAll(var pMask: TD3D10_StateBlockMask): HResult; external D3D10dll;
{$EXTERNALSYM D3D10StateBlockMaskDisableAll}
function D3D10StateBlockMaskGetSetting(const pMask: TD3D10_StateBlockMask; StateType: TD3D10_DeviceStateTypes; Entry: LongWord): BOOL; external D3D10dll;
{$EXTERNALSYM D3D10StateBlockMaskGetSetting}


//----------------------------------------------------------------------------
// D3D10CreateStateBlock
// ---------------------
//
// Creates a state block object based on the mask settings specified
//   in a D3D10_STATE_BLOCK_MASK structure.
//
// ID3D10Device *pDevice
//      The device interface to associate with this state block
//
// D3D10_STATE_BLOCK_MASK *pStateBlockMask
//      A bit mask whose settings are used to generate a state block
//      object.
//
// ID3D10StateBlock **ppStateBlock
//      The resulting state block object.  This object will save/restore
//      only those pieces of state that were set in the state block
//      bit mask
//----------------------------------------------------------------------------

function D3D10CreateStateBlock(const pDevice: ID3D10Device; const pStateBlockMask: TD3D10_StateBlockMask; out ppStateBlock: ID3D10StateBlock): HResult; external D3D10dll;
{$EXTERNALSYM D3D10CreateStateBlock}


//----------------------------------------------------------------------------
// D3D10_COMPILE & D3D10_EFFECT flags:
// -------------------------------------
//
// These flags are passed in when creating an effect, and affect
// either compilation behavior or runtime effect behavior
//
// D3D10_EFFECT_COMPILE_CHILD_EFFECT
//   Compile this .fx file to a child effect. Child effects have no initializers
//   for any shared values as these are initialied in the master effect (pool).
//
// D3D10_EFFECT_COMPILE_ALLOW_SLOW_OPS
//   By default, performance mode is enabled.  Performance mode disallows
//   mutable state objects by preventing non-literal expressions from appearing in
//   state object definitions.  Specifying this flag will disable the mode and allow
//   for mutable state objects.
//
// D3D10_EFFECT_SINGLE_THREADED
//   Do not attempt to synchronize with other threads loading effects into the
//   same pool.
//
//----------------------------------------------------------------------------

const
  D3D10_EFFECT_COMPILE_CHILD_EFFECT              = (1 shl 0);
  {$EXTERNALSYM D3D10_EFFECT_COMPILE_CHILD_EFFECT}
  D3D10_EFFECT_COMPILE_ALLOW_SLOW_OPS            = (1 shl 1);
  {$EXTERNALSYM D3D10_EFFECT_COMPILE_ALLOW_SLOW_OPS}
  D3D10_EFFECT_SINGLE_THREADED                   = (1 shl 3);
  {$EXTERNALSYM D3D10_EFFECT_SINGLE_THREADED}


//----------------------------------------------------------------------------
// D3D10_EFFECT_VARIABLE flags:
// ----------------------------
//
// These flags describe an effect variable (global or annotation),
// and are returned in D3D10_EFFECT_VARIABLE_DESC::Flags.
//
// D3D10_EFFECT_VARIABLE_POOLED
//   Indicates that the this variable or constant buffer resides
//   in an effect pool. If this flag is not set, then the variable resides
//   in a standalone effect (if ID3D10Effect::GetPool returns NULL)
//   or a child effect (if ID3D10Effect::GetPool returns non-NULL)
//
// D3D10_EFFECT_VARIABLE_ANNOTATION
//   Indicates that this is an annotation on a technique, pass, or global
//   variable. Otherwise, this is a global variable. Annotations cannot
//   be shared.
//
// D3D10_EFFECT_VARIABLE_EXPLICIT_BIND_POINT
//   Indicates that the variable has been explicitly bound using the
//   register keyword.
//----------------------------------------------------------------------------

const
  D3D10_EFFECT_VARIABLE_POOLED                  = (1 shl 0);
  {$EXTERNALSYM D3D10_EFFECT_VARIABLE_POOLED}
  D3D10_EFFECT_VARIABLE_ANNOTATION              = (1 shl 1);
  {$EXTERNALSYM D3D10_EFFECT_VARIABLE_ANNOTATION}
  D3D10_EFFECT_VARIABLE_EXPLICIT_BIND_POINT     = (1 shl 2);
  {$EXTERNALSYM D3D10_EFFECT_VARIABLE_EXPLICIT_BIND_POINT}

//////////////////////////////////////////////////////////////////////////////
// ID3D10EffectType //////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------
// D3D10_EFFECT_TYPE_DESC:
//
// Retrieved by ID3D10EffectType::GetDesc()
//----------------------------------------------------------------------------

type
  PD3D10_EffectTypeDesc = ^TD3D10_EffectTypeDesc;
  _D3D10_EFFECT_TYPE_DESC = record
    TypeName:     PAnsiChar;        // Name of the type
                                    // (e.g. "float4" or "MyStruct")

    Class_: TD3D10_ShaderVariableClass;  // (e.g. scalar, vector, object, etc.)
    Type_:  TD3D10_ShaderVariableType;   // (e.g. float, texture, vertexshader, etc.)

    Elements:     LongWord;         // Number of elements in this type
                                    // (0 if not an array)
    Members:      LongWord;         // Number of members
                                    // (0 if not a structure)
    Rows:         LongWord;         // Number of rows in this type
                                    // (0 if not a numeric primitive)
    Columns:      LongWord;         // Number of columns in this type
                                    // (0 if not a numeric primitive)

    PackedSize:   LongWord;         // Number of bytes required to represent
                                    // this data type, when tightly packed
    UnpackedSize: LongWord;         // Number of bytes occupied by this data
                                    // type, when laid out in a constant buffer
    Stride:       LongWord;         // Number of bytes to seek between elements,
                                    // when laid out in a constant buffer
  end;
  {$EXTERNALSYM _D3D10_EFFECT_TYPE_DESC}
  D3D10_EFFECT_TYPE_DESC = _D3D10_EFFECT_TYPE_DESC;
  {$EXTERNALSYM D3D10_EFFECT_TYPE_DESC}
  TD3D10_EffectTypeDesc = _D3D10_EFFECT_TYPE_DESC;


const
  IID_ID3D10EffectType: TGUID = '{4E9E1DDC-CD9D-4772-A837-00180B9B88FD}';
  {$EXTERNALSYM IID_ID3D10EffectType}


type
{$IFDEF FPC}
  //----------------------------------------------------------------------------
  // To expose FreePascal class as abstract C++ class
  {$INTERFACES CORBA}
  ID3D10EffectType = interface
    function IsValid(): BOOL; stdcall;
    function GetDesc(out pDesc: TD3D10_EFFECTTYPEDESC): HResult; stdcall;
    function GetMemberTypeByIndex(Index: LongWord): ID3D10EffectType; stdcall; //Clootie: not real COM interface - no reference counting
    function GetMemberTypeByName(Name: PAnsiChar): ID3D10EffectType; stdcall;
    function GetMemberTypeBySemantic(Semantic: PAnsiChar): ID3D10EffectType; stdcall;
    function GetMemberName(Index: LongWord): PAnsiChar; stdcall;
    function GetMemberSemantic(Index: LongWord): PAnsiChar; stdcall;
  end;
  {$INTERFACES DEFAULT}

{$ENDIF}

  {$EXTERNALSYM ID3D10EffectType}
  {$IFDEF FPC}
  ID3D10EffectType_FPC = class(ID3D10EffectType)
  {$ELSE}
  ID3D10EffectType = class
  {$ENDIF}
    function IsValid(): BOOL; virtual; stdcall; abstract;
    function GetDesc(out pDesc: TD3D10_EFFECTTYPEDESC): HResult; virtual; stdcall; abstract;
    function GetMemberTypeByIndex(Index: LongWord): ID3D10EffectType; virtual; stdcall; abstract; //Clootie: not real COM interface - no reference counting
    function GetMemberTypeByName(Name: PAnsiChar): ID3D10EffectType; virtual; stdcall; abstract;
    function GetMemberTypeBySemantic(Semantic: PAnsiChar): ID3D10EffectType; virtual; stdcall; abstract;
    function GetMemberName(Index: LongWord): PAnsiChar; virtual; stdcall; abstract;
    function GetMemberSemantic(Index: LongWord): PAnsiChar; virtual; stdcall; abstract;
  end;


//////////////////////////////////////////////////////////////////////////////
// ID3D10EffectVariable //////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------
// D3D10_EFFECT_VARIABLE_DESC:
//
// Retrieved by ID3D10EffectVariable::GetDesc()
//----------------------------------------------------------------------------

  PD3D10_EffectVariableDesc = ^TD3D10_EffectVariableDesc;
  _D3D10_EFFECT_VARIABLE_DESC = record
    Name: PAnsiChar;                // Name of this variable, annotation,
                                    // or structure member
    Semantic:  PAnsiChar;           // Semantic string of this variable
                                    // or structure member (NULL for
                                    // annotations or if not present)

    Flags: LongWord;                // D3D10_EFFECT_VARIABLE_* flags
    Annotations: LongWord;          // Number of annotations on this variable
                                    // (always 0 for annotations)

    BufferOffset: LongWord;         // Offset into containing cbuffer or tbuffer
                                    // (always 0 for annotations or variables
                                    // not in constant buffers)

    ExplicitBindPoint: LongWord;    // Used if the variable has been explicitly bound
                                    // using the register keyword. Check Flags for
                                    // D3D10_EFFECT_VARIABLE_EXPLICIT_BIND_POINT;
  end;
  {$EXTERNALSYM _D3D10_EFFECT_VARIABLE_DESC}
  D3D10_EFFECT_VARIABLE_DESC = _D3D10_EFFECT_VARIABLE_DESC;
  {$EXTERNALSYM D3D10_EFFECT_VARIABLE_DESC}
  TD3D10_EffectVariableDesc = _D3D10_EFFECT_VARIABLE_DESC;


const
  IID_ID3D10EffectVariable: TGUID = '{AE897105-00E6-45bf-BB8E-281DD6DB8E1B}';
  {$EXTERNALSYM IID_ID3D10EffectVariable}


type
  // Forward defines
  ID3D10EffectScalarVariable = class;
  ID3D10EffectVectorVariable = class;
  ID3D10EffectMatrixVariable = class;
  ID3D10EffectStringVariable = class;
  ID3D10EffectShaderResourceVariable = class;
  ID3D10EffectRenderTargetViewVariable = class;
  ID3D10EffectDepthStencilViewVariable = class;
  ID3D10EffectConstantBuffer = class;
  ID3D10EffectShaderVariable = class;
  ID3D10EffectBlendVariable = class;
  ID3D10EffectDepthStencilVariable = class;
  ID3D10EffectRasterizerVariable = class;
  ID3D10EffectSamplerVariable = class;

{$IFDEF FPC}
  //----------------------------------------------------------------------------
  // To expose FreePascal class as abstract C++ class
  {$INTERFACES CORBA}
  ID3D10EffectVariable = interface
    function IsValid(): BOOL; stdcall;
    function GetType(): ID3D10EffectType; stdcall;
    function GetDesc(out pDesc: TD3D10_EffectVariableDesc): HResult; stdcall;

    function GetAnnotationByIndex(Index: LongWord): ID3D10EffectVariable; stdcall;
    function GetAnnotationByName(Name: PAnsiChar): ID3D10EffectVariable; stdcall;

    function GetMemberByIndex(Index: LongWord): ID3D10EffectVariable; stdcall;
    function GetMemberByName(Name: PAnsiChar): ID3D10EffectVariable; stdcall;
    function GetMemberBySemantic(Semantic: PAnsiChar): ID3D10EffectVariable; stdcall;

    function GetElement(Index: LongWord): ID3D10EffectVariable; stdcall;

    function GetParentConstantBuffer(): ID3D10EffectConstantBuffer; stdcall;

    function AsScalar(): ID3D10EffectScalarVariable; stdcall;
    function AsVector(): ID3D10EffectVectorVariable; stdcall;
    function AsMatrix(): ID3D10EffectMatrixVariable; stdcall;
    function AsString(): ID3D10EffectStringVariable; stdcall;
    function AsShaderResource(): ID3D10EffectShaderResourceVariable; stdcall;
    function AsRenderTargetView(): ID3D10EffectRenderTargetViewVariable; stdcall;
    function AsDepthStencilView(): ID3D10EffectDepthStencilViewVariable; stdcall;
    function AsConstantBuffer(): ID3D10EffectConstantBuffer; stdcall;
    function AsShader(): ID3D10EffectShaderVariable; stdcall;
    function AsBlend(): ID3D10EffectBlendVariable; stdcall;
    function AsDepthStencil(): ID3D10EffectDepthStencilVariable; stdcall;
    function AsRasterizer(): ID3D10EffectRasterizerVariable; stdcall;
    function AsSampler(): ID3D10EffectSamplerVariable; stdcall;

    function SetRawValue(const pData: Pointer; Offset, Count: LongWord): HResult; stdcall;
    function GetRawValue(pData: Pointer; Offset, Count: LongWord): HResult; stdcall;
  end;
  {$INTERFACES DEFAULT}

{$ENDIF}

  {$EXTERNALSYM ID3D10EffectVariable}
  {$IFDEF FPC}
  ID3D10EffectVariable_FPC = class(ID3D10EffectVariable)
  {$ELSE}
  ID3D10EffectVariable = class
  {$ENDIF}
    function IsValid(): BOOL; virtual; stdcall; abstract;
    function GetType(): ID3D10EffectType; virtual; stdcall; abstract;
    function GetDesc(out pDesc: TD3D10_EffectVariableDesc): HResult; virtual; stdcall; abstract;

    function GetAnnotationByIndex(Index: LongWord): ID3D10EffectVariable; virtual; stdcall; abstract;
    function GetAnnotationByName(Name: PAnsiChar): ID3D10EffectVariable; virtual; stdcall; abstract;

    function GetMemberByIndex(Index: LongWord): ID3D10EffectVariable; virtual; stdcall; abstract;
    function GetMemberByName(Name: PAnsiChar): ID3D10EffectVariable; virtual; stdcall; abstract;
    function GetMemberBySemantic(Semantic: PAnsiChar): ID3D10EffectVariable; virtual; stdcall; abstract;

    function GetElement(Index: LongWord): ID3D10EffectVariable; virtual; stdcall; abstract;

    function GetParentConstantBuffer(): ID3D10EffectConstantBuffer; virtual; stdcall; abstract;

    function AsScalar(): ID3D10EffectScalarVariable; virtual; stdcall; abstract;
    function AsVector(): ID3D10EffectVectorVariable; virtual; stdcall; abstract;
    function AsMatrix(): ID3D10EffectMatrixVariable; virtual; stdcall; abstract;
    function AsString(): ID3D10EffectStringVariable; virtual; stdcall; abstract;
    function AsShaderResource(): ID3D10EffectShaderResourceVariable; virtual; stdcall; abstract;
    function AsRenderTargetView(): ID3D10EffectRenderTargetViewVariable; virtual; stdcall; abstract;
    function AsDepthStencilView(): ID3D10EffectDepthStencilViewVariable; virtual; stdcall; abstract;
    function AsConstantBuffer(): ID3D10EffectConstantBuffer; virtual; stdcall; abstract;
    function AsShader(): ID3D10EffectShaderVariable; virtual; stdcall; abstract;
    function AsBlend(): ID3D10EffectBlendVariable; virtual; stdcall; abstract;
    function AsDepthStencil(): ID3D10EffectDepthStencilVariable; virtual; stdcall; abstract;
    function AsRasterizer(): ID3D10EffectRasterizerVariable; virtual; stdcall; abstract;
    function AsSampler(): ID3D10EffectSamplerVariable; virtual; stdcall; abstract;

    function SetRawValue(const pData: Pointer; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;
    function GetRawValue(pData: Pointer; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;
  end;


//////////////////////////////////////////////////////////////////////////////
// ID3D10EffectScalarVariable ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////


// {00E48F7B-D2C8-49e8-A86C-022DEE53431F}
//DEFINE_GUID(IID_ID3D10EffectScalarVariable,
//0xe48f7b, 0xd2c8, 0x49e8, 0xa8, 0x6c, 0x2, 0x2d, 0xee, 0x53, 0x43, 0x1f);

{$IFDEF FPC}
  //----------------------------------------------------------------------------
  // To expose FreePascal class as abstract C++ class
  {$INTERFACES CORBA}
  ID3D10EffectScalarVariable = interface(ID3D10EffectVariable)
    function SetFloat(Value: Single): HResult; stdcall;
    function GetFloat(out pValue: Single): HResult; stdcall;

    function SetFloatArray(const pData: PSingle; Offset, Count: LongWord): HResult; stdcall;
    function GetFloatArray(pData: PSingle; Offset, Count: LongWord): HResult; stdcall;

    function SetInt(Value: Integer): HResult; stdcall;
    function GetInt(out pValue: Integer): HResult; stdcall;

    function SetIntArray(const pData: PInteger; Offset, Count: LongWord): HResult; stdcall;
    function GetIntArray(pData: PInteger; Offset, Count: LongWord): HResult; stdcall;

    function SetBool(Value: BOOL): HResult; stdcall;
    function GetBool(out pValue: BOOL): HResult; stdcall;

    function SetBoolArray(const pData: PBOOL; Offset, Count: LongWord): HResult; stdcall;
    function GetBoolArray(pData: PBOOL; Offset, Count: LongWord): HResult; stdcall;
  end;
  {$INTERFACES DEFAULT}

{$ENDIF}

  {$EXTERNALSYM ID3D10EffectScalarVariable}
  {$IFDEF FPC}
  ID3D10EffectScalarVariable_FPC = class(ID3D10EffectVariable_FPC, ID3D10EffectScalarVariable)
  {$ELSE}
  ID3D10EffectScalarVariable = class(ID3D10EffectVariable)
  {$ENDIF}
    function SetFloat(Value: Single): HResult; virtual; stdcall; abstract;
    function GetFloat(out pValue: Single): HResult; virtual; stdcall; abstract;

    function SetFloatArray(const pData: PSingle; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;
    function GetFloatArray(pData: PSingle; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;

    function SetInt(Value: Integer): HResult; virtual; stdcall; abstract;
    function GetInt(out pValue: Integer): HResult; virtual; stdcall; abstract;

    function SetIntArray(const pData: PInteger; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;
    function GetIntArray(pData: PInteger; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;

    function SetBool(Value: BOOL): HResult; virtual; stdcall; abstract;
    function GetBool(out pValue: BOOL): HResult; virtual; stdcall; abstract;

    function SetBoolArray(const pData: PBOOL; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;
    function GetBoolArray(pData: PBOOL; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;
  end;


//////////////////////////////////////////////////////////////////////////////
// ID3D10EffectVectorVariable ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// {62B98C44-1F82-4c67-BCD0-72CF8F217E81}
//DEFINE_GUID(IID_ID3D10EffectVectorVariable,
//0x62b98c44, 0x1f82, 0x4c67, 0xbc, 0xd0, 0x72, 0xcf, 0x8f, 0x21, 0x7e, 0x81);

{$IFDEF FPC}
  //----------------------------------------------------------------------------
  // To expose FreePascal class as abstract C++ class
  {$INTERFACES CORBA}
  ID3D10EffectVectorVariable = interface(ID3D10EffectVariable)
    procedure SetBoolVector(const pData: PBOOL); stdcall;
    procedure SetIntVector(const pData: PInteger); stdcall;
    function SetFloatVector(const pData: PSingle): HResult; stdcall;

    procedure GetBoolVector(pData: PBOOL); stdcall;
    procedure GetIntVector(pData: PInteger); stdcall;
    function GetFloatVector(pData: PSingle): HResult; stdcall;

    procedure SetBoolVectorArray(const pData: PBOOL; Offset, Count: LongWord); stdcall;
    procedure SetIntVectorArray(const pData: PInteger; Offset, Count: LongWord); stdcall;
    function SetFloatVectorArray(const pData: PSingle; Offset: LongWord; Count: LongWord): HResult; stdcall;

    procedure GetBoolVectorArray(pData: PBOOL; Offset, Count: LongWord); stdcall;
    procedure GetIntVectorArray(pData: PInteger; Offset, Count: LongWord); stdcall;
    function GetFloatVectorArray(pData: PSingle; Offset, Count: LongWord): HResult; stdcall;
  end;
  {$INTERFACES DEFAULT}

{$ENDIF}

  {$EXTERNALSYM ID3D10EffectVectorVariable}
  {$IFDEF FPC}
  ID3D10EffectVectorVariable_FPC = class(ID3D10EffectVariable_FPC, ID3D10EffectVectorVariable)
  {$ELSE}
  ID3D10EffectVectorVariable = class(ID3D10EffectVariable)
  {$ENDIF}
    procedure SetBoolVector(const pData: PBOOL); virtual; stdcall; abstract;
    procedure SetIntVector(const pData: PInteger); virtual; stdcall; abstract;
    function SetFloatVector(const pData: PSingle): HResult; virtual; stdcall; abstract;

    procedure GetBoolVector(pData: PBOOL); virtual; stdcall; abstract;
    procedure GetIntVector(pData: PInteger); virtual; stdcall; abstract;
    function GetFloatVector(pData: PSingle): HResult; virtual; stdcall; abstract;

    procedure SetBoolVectorArray(const pData: PBOOL; Offset, Count: LongWord); virtual; stdcall; abstract;
    procedure SetIntVectorArray(const pData: PInteger; Offset, Count: LongWord); virtual; stdcall; abstract;
    function SetFloatVectorArray(const pData: PSingle; Offset: LongWord; Count: LongWord): HResult; virtual; stdcall; abstract;

    procedure GetBoolVectorArray(pData: PBOOL; Offset, Count: LongWord); virtual; stdcall; abstract;
    procedure GetIntVectorArray(pData: PInteger; Offset, Count: LongWord); virtual; stdcall; abstract;
    function GetFloatVectorArray(pData: PSingle; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;
  end;


//////////////////////////////////////////////////////////////////////////////
// ID3D10EffectMatrixVariable ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// {50666C24-B82F-4eed-A172-5B6E7E8522E0}
//DEFINE_GUID(IID_ID3D10EffectMatrixVariable,
//0x50666c24, 0xb82f, 0x4eed, 0xa1, 0x72, 0x5b, 0x6e, 0x7e, 0x85, 0x22, 0xe0);

{$IFDEF FPC}
  //----------------------------------------------------------------------------
  // To expose FreePascal class as abstract C++ class
  {$INTERFACES CORBA}
  ID3D10EffectMatrixVariable = interface(ID3D10EffectVariable)
    function SetMatrix(const pData: PSingle): HResult; stdcall;
    function GetMatrix(pData: PSingle): HResult; stdcall;

    function SetMatrixArray(const pData: PSingle; Offset, Count: LongWord): HResult; stdcall;
    function GetMatrixArray(pData: PSingle; Offset, Count: LongWord): HResult; stdcall;

    function SetMatrixTranspose(pData: PSingle): HResult; stdcall;
    function GetMatrixTranspose(pData: PSingle): HResult; stdcall;

    function SetMatrixTransposeArray(const pData: PSingle; Offset, Count: LongWord): HResult; stdcall;
    function GetMatrixTransposeArray(pData: PSingle; Offset, Count: LongWord): HResult; stdcall;
  end;
  {$INTERFACES DEFAULT}

{$ENDIF}

  {$EXTERNALSYM ID3D10EffectMatrixVariable}
  {$IFDEF FPC}
  ID3D10EffectMatrixVariable_FPC = class(ID3D10EffectVariable_FPC, ID3D10EffectMatrixVariable)
  {$ELSE}
  ID3D10EffectMatrixVariable = class(ID3D10EffectVariable)
  {$ENDIF}
    function SetMatrix(const pData: PSingle): HResult; virtual; stdcall; abstract;
    function GetMatrix(pData: PSingle): HResult; virtual; stdcall; abstract;

    function SetMatrixArray(const pData: PSingle; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;
    function GetMatrixArray(pData: PSingle; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;

    function SetMatrixTranspose(pData: PSingle): HResult; virtual; stdcall; abstract;
    function GetMatrixTranspose(pData: PSingle): HResult; virtual; stdcall; abstract;

    function SetMatrixTransposeArray(const pData: PSingle; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;
    function GetMatrixTransposeArray(pData: PSingle; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;
  end;


//////////////////////////////////////////////////////////////////////////////
// ID3D10EffectStringVariable ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// {71417501-8DF9-4e0a-A78A-255F9756BAFF}
//DEFINE_GUID(IID_ID3D10EffectStringVariable,
//0x71417501, 0x8df9, 0x4e0a, 0xa7, 0x8a, 0x25, 0x5f, 0x97, 0x56, 0xba, 0xff);

{$IFDEF FPC}
  //----------------------------------------------------------------------------
  // To expose FreePascal class as abstract C++ class
  {$INTERFACES CORBA}
  ID3D10EffectStringVariable = interface(ID3D10EffectVariable)
    function GetString(ppString: PAnsiChar): HResult; stdcall;
    function GetStringArray(ppStrings: PAnsiChar; Offset, Count: LongWord): HResult; stdcall;
  end;
  {$INTERFACES DEFAULT}

{$ENDIF}

  {$EXTERNALSYM ID3D10EffectStringVariable}
  {$IFDEF FPC}
  ID3D10EffectStringVariable_FPC = class(ID3D10EffectVariable_FPC, ID3D10EffectStringVariable)
  {$ELSE}
  ID3D10EffectStringVariable = class(ID3D10EffectVariable)
  {$ENDIF}
    function GetString(ppString: PAnsiChar): HResult; virtual; stdcall; abstract;
    function GetStringArray(ppStrings: PAnsiChar; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;
  end;

//////////////////////////////////////////////////////////////////////////////
// ID3D10EffectShaderResourceVariable ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// {C0A7157B-D872-4b1d-8073-EFC2ACD4B1FC}
//DEFINE_GUID(IID_ID3D10EffectShaderResourceVariable,
//0xc0a7157b, 0xd872, 0x4b1d, 0x80, 0x73, 0xef, 0xc2, 0xac, 0xd4, 0xb1, 0xfc);


{$IFDEF FPC}
  //----------------------------------------------------------------------------
  // To expose FreePascal class as abstract C++ class
  {$INTERFACES CORBA}
  ID3D10EffectShaderResourceVariable = interface(ID3D10EffectVariable)
    function SetResource(pResource: ID3D10ShaderResourceView): HResult; stdcall;
    function GetResource(out ppResource: ID3D10ShaderResourceView): HResult; stdcall;

    function SetResourceArray(const ppResources: PID3D10ShaderResourceView; Offset, Count: LongWord): HResult; stdcall;
    function GetResourceArray(ppResources: PID3D10ShaderResourceView; Offset, Count: LongWord): HResult; stdcall;
  end;
  {$INTERFACES DEFAULT}

{$ENDIF}

  {$EXTERNALSYM ID3D10EffectShaderResourceVariable}
  {$IFDEF FPC}
  ID3D10EffectShaderResourceVariable_FPC = class(ID3D10EffectVariable_FPC, ID3D10EffectShaderResourceVariable)
  {$ELSE}
  ID3D10EffectShaderResourceVariable = class(ID3D10EffectVariable)
  {$ENDIF}
    function SetResource(pResource: ID3D10ShaderResourceView): HResult; virtual; stdcall; abstract;
    function GetResource(out ppResource: ID3D10ShaderResourceView): HResult; virtual; stdcall; abstract;

    function SetResourceArray(const ppResources: PID3D10ShaderResourceView; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;
    function GetResourceArray(ppResources: PID3D10ShaderResourceView; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;
  end;

//////////////////////////////////////////////////////////////////////////////
// ID3D10EffectRenderTargetViewVariable //////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// {28CA0CC3-C2C9-40bb-B57F-67B737122B17}
//DEFINE_GUID(IID_ID3D10EffectRenderTargetViewVariable,
//0x28ca0cc3, 0xc2c9, 0x40bb, 0xb5, 0x7f, 0x67, 0xb7, 0x37, 0x12, 0x2b, 0x17);

{$IFDEF FPC}
  //----------------------------------------------------------------------------
  // To expose FreePascal class as abstract C++ class
  {$INTERFACES CORBA}
  ID3D10EffectRenderTargetViewVariable = interface(ID3D10EffectVariable)
    function SetRenderTarget(const pResource: ID3D10RenderTargetView): HResult; stdcall;
    function GetRenderTarget(ppResource: PID3D10RenderTargetView): HResult; stdcall;

    function SetRenderTargetArray(const ppResources: PID3D10RenderTargetView; Offset, Count: LongWord): HResult; stdcall;
    function GetRenderTargetArray(ppResources: PID3D10RenderTargetView; Offset, Count: LongWord): HResult; stdcall;
  end;
  {$INTERFACES DEFAULT}

{$ENDIF}

  {$EXTERNALSYM ID3D10EffectRenderTargetViewVariable}
  {$IFDEF FPC}
  ID3D10EffectRenderTargetViewVariable_FPC = class(ID3D10EffectVariable_FPC, ID3D10EffectRenderTargetViewVariable)
  {$ELSE}
  ID3D10EffectRenderTargetViewVariable = class(ID3D10EffectVariable)
  {$ENDIF}
    function SetRenderTarget(const pResource: ID3D10RenderTargetView): HResult; virtual; stdcall; abstract;
    function GetRenderTarget(ppResource: PID3D10RenderTargetView): HResult; virtual; stdcall; abstract;

    function SetRenderTargetArray(const ppResources: PID3D10RenderTargetView; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;
    function GetRenderTargetArray(ppResources: PID3D10RenderTargetView; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;
  end;

//////////////////////////////////////////////////////////////////////////////
// ID3D10EffectDepthStencilViewVariable //////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// {3E02C918-CC79-4985-B622-2D92AD701623}
//DEFINE_GUID(IID_ID3D10EffectDepthStencilViewVariable,
//0x3e02c918, 0xcc79, 0x4985, 0xb6, 0x22, 0x2d, 0x92, 0xad, 0x70, 0x16, 0x23);

{$IFDEF FPC}
  //----------------------------------------------------------------------------
  // To expose FreePascal class as abstract C++ class
  {$INTERFACES CORBA}
  ID3D10EffectDepthStencilViewVariable = interface(ID3D10EffectVariable)
    function SetDepthStencil(const pResource: ID3D10DepthStencilView): HResult; stdcall;
    function GetDepthStencil(ppResource: PID3D10DepthStencilView): HResult; stdcall;

    function SetDepthStencilArray(const ppResources: PID3D10DepthStencilView; Offset, Count: LongWord): HResult; stdcall;
    function GetDepthStencilArray(ppResources: PID3D10DepthStencilView; Offset, Count: LongWord): HResult; stdcall;
  end;
  {$INTERFACES DEFAULT}

{$ENDIF}

  {$EXTERNALSYM ID3D10EffectDepthStencilViewVariable}
  {$IFDEF FPC}
  ID3D10EffectDepthStencilViewVariable_FPC = class(ID3D10EffectVariable_FPC, ID3D10EffectDepthStencilViewVariable)
  {$ELSE}
  ID3D10EffectDepthStencilViewVariable = class(ID3D10EffectVariable)
  {$ENDIF}
    function SetDepthStencil(const pResource: ID3D10DepthStencilView): HResult; virtual; stdcall; abstract;
    function GetDepthStencil(ppResource: PID3D10DepthStencilView): HResult; virtual; stdcall; abstract;

    function SetDepthStencilArray(const ppResources: PID3D10DepthStencilView; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;
    function GetDepthStencilArray(ppResources: PID3D10DepthStencilView; Offset, Count: LongWord): HResult; virtual; stdcall; abstract;
  end;


//////////////////////////////////////////////////////////////////////////////
// ID3D10EffectConstantBuffer ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// {56648F4D-CC8B-4444-A5AD-B5A3D76E91B3}
//DEFINE_GUID(IID_ID3D10EffectConstantBuffer,
//0x56648f4d, 0xcc8b, 0x4444, 0xa5, 0xad, 0xb5, 0xa3, 0xd7, 0x6e, 0x91, 0xb3);

{$IFDEF FPC}
  //----------------------------------------------------------------------------
  // To expose FreePascal class as abstract C++ class
  {$INTERFACES CORBA}
  ID3D10EffectConstantBuffer = interface(ID3D10EffectVariable)
    function SetConstantBuffer(const pConstantBuffer: ID3D10Buffer): HResult; stdcall;
    function GetConstantBuffer(ppConstantBuffer: PID3D10Buffer): HResult; stdcall;

    function SetTextureBuffer(const pTextureBuffer: ID3D10ShaderResourceView): HResult; stdcall;
    function GetTextureBuffer(ppTextureBuffer: PID3D10ShaderResourceView): HResult; stdcall;
  end;
  {$INTERFACES DEFAULT}

{$ENDIF}

  {$EXTERNALSYM ID3D10EffectConstantBuffer}
  {$IFDEF FPC}
  ID3D10EffectConstantBuffer_FPC = class(ID3D10EffectVariable_FPC, ID3D10EffectConstantBuffer)
  {$ELSE}
  ID3D10EffectConstantBuffer = class(ID3D10EffectVariable)
  {$ENDIF}
    function SetConstantBuffer(const pConstantBuffer: ID3D10Buffer): HResult; virtual; stdcall; abstract;
    function GetConstantBuffer(ppConstantBuffer: PID3D10Buffer): HResult; virtual; stdcall; abstract;

    function SetTextureBuffer(const pTextureBuffer: ID3D10ShaderResourceView): HResult; virtual; stdcall; abstract;
    function GetTextureBuffer(ppTextureBuffer: PID3D10ShaderResourceView): HResult; virtual; stdcall; abstract;
  end;


//////////////////////////////////////////////////////////////////////////////
// ID3D10EffectShaderVariable ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------
// D3D10_EFFECT_SHADER_DESC:
//
// Retrieved by ID3D10EffectShaderVariable::GetShaderDesc()
//----------------------------------------------------------------------------

  PD3D10_EffectShaderDesc = ^TD3D10_EffectShaderDesc;
  _D3D10_EFFECT_SHADER_DESC = record
    pInputSignature: PByte;         // Passed into CreateInputLayout,
                                    // valid on VS and GS only

    IsInline: BOOL;                 // Is this an anonymous shader variable
                                    // resulting from an inline shader assignment?


    // -- The following fields are not valid after Optimize() --
    pBytecode: PByte;               // Shader bytecode
    BytecodeLength: LongWord;

    SODecl: PAnsiChar;              // Stream out declaration string (for GS with SO)

    NumInputSignatureEntries: LongWord;  // Number of entries in the input signature
    NumOutputSignatureEntries: LongWord; // Number of entries in the output signature
  end;
  {$EXTERNALSYM _D3D10_EFFECT_SHADER_DESC}
  D3D10_EFFECT_SHADER_DESC = _D3D10_EFFECT_SHADER_DESC;
  {$EXTERNALSYM D3D10_EFFECT_SHADER_DESC}
  TD3D10_EffectShaderDesc = _D3D10_EFFECT_SHADER_DESC;


// {80849279-C799-4797-8C33-0407A07D9E06}
//DEFINE_GUID(IID_ID3D10EffectShaderVariable,
//0x80849279, 0xc799, 0x4797, 0x8c, 0x33, 0x4, 0x7, 0xa0, 0x7d, 0x9e, 0x6);

{$IFDEF FPC}
  //----------------------------------------------------------------------------
  // To expose FreePascal class as abstract C++ class
  {$INTERFACES CORBA}
  ID3D10EffectShaderVariable = interface(ID3D10EffectVariable)
    function GetShaderDesc(ShaderIndex: LongWord; out pDesc: TD3D10_EffectShaderDesc): HResult; stdcall;

    function GetVertexShader(ShaderIndex: LongWord; out ppVS: ID3D10VertexShader): HResult; stdcall;
    function GetGeometryShader(ShaderIndex: LongWord; out ppGS: ID3D10GeometryShader): HResult; stdcall;
    function GetPixelShader(ShaderIndex: LongWord; out ppPS: ID3D10PixelShader): HResult; stdcall;

    function GetInputSignatureElementDesc(ShaderIndex: LongWord; Element: LongWord; out pDesc: TD3D10_SignatureParameterDesc): HResult; stdcall;
    function GetOutputSignatureElementDesc(ShaderIndex: LongWord; Element: LongWord; out pDesc: TD3D10_SignatureParameterDesc): HResult; stdcall;
  end;
  {$INTERFACES DEFAULT}

{$ENDIF}

  {$EXTERNALSYM ID3D10EffectShaderVariable}
  {$IFDEF FPC}
  ID3D10EffectShaderVariable_FPC = class(ID3D10EffectVariable_FPC, ID3D10EffectShaderVariable)
  {$ELSE}
  ID3D10EffectShaderVariable = class(ID3D10EffectVariable)
  {$ENDIF}
    function GetShaderDesc(ShaderIndex: LongWord; out pDesc: TD3D10_EffectShaderDesc): HResult; virtual; stdcall; abstract;

    function GetVertexShader(ShaderIndex: LongWord; out ppVS: ID3D10VertexShader): HResult; virtual; stdcall; abstract;
    function GetGeometryShader(ShaderIndex: LongWord; out ppGS: ID3D10GeometryShader): HResult; virtual; stdcall; abstract;
    function GetPixelShader(ShaderIndex: LongWord; out ppPS: ID3D10PixelShader): HResult; virtual; stdcall; abstract;

    function GetInputSignatureElementDesc(ShaderIndex: LongWord; Element: LongWord; out pDesc: TD3D10_SignatureParameterDesc): HResult; virtual; stdcall; abstract;
    function GetOutputSignatureElementDesc(ShaderIndex: LongWord; Element: LongWord; out pDesc: TD3D10_SignatureParameterDesc): HResult; virtual; stdcall; abstract;
  end;


//////////////////////////////////////////////////////////////////////////////
// ID3D10EffectBlendVariable /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// {1FCD2294-DF6D-4eae-86B3-0E9160CFB07B}
//DEFINE_GUID(IID_ID3D10EffectBlendVariable,
//0x1fcd2294, 0xdf6d, 0x4eae, 0x86, 0xb3, 0xe, 0x91, 0x60, 0xcf, 0xb0, 0x7b);

{$IFDEF FPC}
  //----------------------------------------------------------------------------
  // To expose FreePascal class as abstract C++ class
  {$INTERFACES CORBA}
  ID3D10EffectBlendVariable = interface(ID3D10EffectVariable)
    function GetBlendState(Index: LongWord; out ppBlendState: ID3D10BlendState): HResult; stdcall;
    function GetBackingStore(Index: LongWord; out pBlendDesc: TD3D10_BlendDesc): HResult; stdcall;
  end;
  {$INTERFACES DEFAULT}

{$ENDIF}

  {$EXTERNALSYM ID3D10EffectBlendVariable}
  {$IFDEF FPC}
  ID3D10EffectBlendVariable_FPC = class(ID3D10EffectVariable_FPC, ID3D10EffectBlendVariable)
  {$ELSE}
  ID3D10EffectBlendVariable = class(ID3D10EffectVariable)
  {$ENDIF}
    function GetBlendState(Index: LongWord; out ppBlendState: ID3D10BlendState): HResult; virtual; stdcall; abstract;
    function GetBackingStore(Index: LongWord; out pBlendDesc: TD3D10_BlendDesc): HResult; virtual; stdcall; abstract;
  end;

//////////////////////////////////////////////////////////////////////////////
// ID3D10EffectDepthStencilVariable //////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// {AF482368-330A-46a5-9A5C-01C71AF24C8D}
//DEFINE_GUID(IID_ID3D10EffectDepthStencilVariable,
//0xaf482368, 0x330a, 0x46a5, 0x9a, 0x5c, 0x1, 0xc7, 0x1a, 0xf2, 0x4c, 0x8d);

{$IFDEF FPC}
  //----------------------------------------------------------------------------
  // To expose FreePascal class as abstract C++ class
  {$INTERFACES CORBA}
  ID3D10EffectDepthStencilVariable = interface(ID3D10EffectVariable)
    function GetDepthStencilState(Index: LongWord; out ppDepthStencilState: ID3D10DepthStencilState): HResult; stdcall;
    function GetBackingStore(Index: LongWord; out pDepthStencilDesc: TD3D10_DepthStencilDesc): HResult; stdcall;
  end;
  {$INTERFACES DEFAULT}

{$ENDIF}

  {$EXTERNALSYM ID3D10EffectDepthStencilVariable}
  {$IFDEF FPC}
  ID3D10EffectDepthStencilVariable_FPC = class(ID3D10EffectVariable_FPC, ID3D10EffectDepthStencilVariable)
  {$ELSE}
  ID3D10EffectDepthStencilVariable = class(ID3D10EffectVariable)
  {$ENDIF}
    function GetDepthStencilState(Index: LongWord; out ppDepthStencilState: ID3D10DepthStencilState): HResult; virtual; stdcall; abstract;
    function GetBackingStore(Index: LongWord; out pDepthStencilDesc: TD3D10_DepthStencilDesc): HResult; virtual; stdcall; abstract;
  end;


//////////////////////////////////////////////////////////////////////////////
// ID3D10EffectRasterizerVariable ////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// {21AF9F0E-4D94-4ea9-9785-2CB76B8C0B34}
//DEFINE_GUID(IID_ID3D10EffectRasterizerVariable,
//0x21af9f0e, 0x4d94, 0x4ea9, 0x97, 0x85, 0x2c, 0xb7, 0x6b, 0x8c, 0xb, 0x34);

{$IFDEF FPC}
  //----------------------------------------------------------------------------
  // To expose FreePascal class as abstract C++ class
  {$INTERFACES CORBA}
  ID3D10EffectRasterizerVariable = interface(ID3D10EffectVariable)
    function GetRasterizerState(Index: LongWord; out ppRasterizerState: ID3D10RasterizerState): HResult; stdcall;
    function GetBackingStore(Index: LongWord; out pRasterizerDesc: TD3D10_RasterizerDesc): HResult; stdcall;
  end;
  {$INTERFACES DEFAULT}

{$ENDIF}

  {$EXTERNALSYM ID3D10EffectRasterizerVariable}
  {$IFDEF FPC}
  ID3D10EffectRasterizerVariable_FPC = class(ID3D10EffectVariable_FPC, ID3D10EffectRasterizerVariable)
  {$ELSE}
  ID3D10EffectRasterizerVariable = class(ID3D10EffectVariable)
  {$ENDIF}
    function GetRasterizerState(Index: LongWord; out ppRasterizerState: ID3D10RasterizerState): HResult; virtual; stdcall; abstract;
    function GetBackingStore(Index: LongWord; out pRasterizerDesc: TD3D10_RasterizerDesc): HResult; virtual; stdcall; abstract;
  end;


//////////////////////////////////////////////////////////////////////////////
// ID3D10EffectSamplerVariable ///////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

// {6530D5C7-07E9-4271-A418-E7CE4BD1E480}
//DEFINE_GUID(IID_ID3D10EffectSamplerVariable,
//0x6530d5c7, 0x7e9, 0x4271, 0xa4, 0x18, 0xe7, 0xce, 0x4b, 0xd1, 0xe4, 0x80);

{$IFDEF FPC}
  //----------------------------------------------------------------------------
  // To expose FreePascal class as abstract C++ class
  {$INTERFACES CORBA}
  ID3D10EffectSamplerVariable = interface(ID3D10EffectVariable)
    function GetSampler(Index: LongWord; out ppSampler: ID3D10SamplerState): HResult; stdcall;
    function GetBackingStore(Index: LongWord; out pSamplerDesc: TD3D10_SamplerDesc): HResult; stdcall;
  end;
  {$INTERFACES DEFAULT}

{$ENDIF}

  {$EXTERNALSYM ID3D10EffectSamplerVariable}
  {$IFDEF FPC}
  ID3D10EffectSamplerVariable_FPC = class(ID3D10EffectVariable_FPC, ID3D10EffectSamplerVariable)
  {$ELSE}
  ID3D10EffectSamplerVariable = class(ID3D10EffectVariable)
  {$ENDIF}
    function GetSampler(Index: LongWord; out ppSampler: ID3D10SamplerState): HResult; virtual; stdcall; abstract;
    function GetBackingStore(Index: LongWord; out pSamplerDesc: TD3D10_SamplerDesc): HResult; virtual; stdcall; abstract;
  end;


//////////////////////////////////////////////////////////////////////////////
// ID3D10EffectPass //////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------
// D3D10_PASS_DESC:
//
// Retrieved by ID3D10EffectPass::GetDesc()
//----------------------------------------------------------------------------

  PD3D10_PassDesc = ^TD3D10_PassDesc;
  _D3D10_PASS_DESC = record
    Name: PAnsiChar;                // Name of this pass (NULL if not anonymous)
    Annotations: LongWord;          // Number of annotations on this pass

    pIAInputSignature: PByte;       // Signature from VS or GS (if there is no VS)
                                    // or NULL if neither exists
    IAInputSignatureSize: SIZE_T;   // Singature size in bytes

    StencilRef: LongWord;           // Specified in SetDepthStencilState()
    SampleMask: LongWord;           // Specified in SetBlendState()
    BlendFactor: TColorArray;       // Specified in SetBlendState()
  end;
 {$EXTERNALSYM _D3D10_PASS_DESC}
 D3D10_PASS_DESC = _D3D10_PASS_DESC;
 {$EXTERNALSYM D3D10_PASS_DESC}
 TD3D10_PassDesc = _D3D10_PASS_DESC;


//----------------------------------------------------------------------------
// D3D10_PASS_SHADER_DESC:
//
// Retrieved by ID3D10EffectPass::Get**ShaderDesc()
//----------------------------------------------------------------------------

  PD3D10_PassShaderDesc = ^TD3D10_PassShaderDesc;
  _D3D10_PASS_SHADER_DESC = record
    pShaderVariable: ID3D10EffectShaderVariable;    // The variable that this shader came from.
                                                    // If this is an inline shader assignment,
                                                    //   the returned interface will be an
                                                    //   anonymous shader variable, which is
                                                    //   not retrievable any other way.  It's
                                                    //   name in the variable description will
                                                    //   be "$Anonymous".
                                                    // If there is no assignment of this type in
                                                    //   the pass block, pShaderVariable != NULL,
                                                    //   but pShaderVariable->IsValid() == FALSE.

    ShaderIndex:                        LongWord;   // The element of pShaderVariable (if an array)
                                                    // or 0 if not applicable
  end;
  {$EXTERNALSYM _D3D10_PASS_SHADER_DESC}
  D3D10_PASS_SHADER_DESC = _D3D10_PASS_SHADER_DESC;
  {$EXTERNALSYM D3D10_PASS_SHADER_DESC}
  TD3D10_PassShaderDesc = _D3D10_PASS_SHADER_DESC;


// {5CFBEB89-1A06-46e0-B282-E3F9BFA36A54}
//DEFINE_GUID(IID_ID3D10EffectPass,
//0x5cfbeb89, 0x1a06, 0x46e0, 0xb2, 0x82, 0xe3, 0xf9, 0xbf, 0xa3, 0x6a, 0x54);


{$IFDEF FPC}
  //----------------------------------------------------------------------------
  // To expose FreePascal class as abstract C++ class
  {$INTERFACES CORBA}
  ID3D10EffectPass = interface
    function IsValid(): BOOL; stdcall;
    function GetDesc(out pDesc: TD3D10_PassDesc): HResult; stdcall;

    function GetVertexShaderDesc(out pDesc: TD3D10_PassShaderDesc): HResult; stdcall;
    function GetGeometryShaderDesc(out pDesc: TD3D10_PassShaderDesc): HResult; stdcall;
    function GetPixelShaderDesc(out pDesc: TD3D10_PassShaderDesc): HResult; stdcall;

    function GetAnnotationByIndex(Index: LongWord): ID3D10EffectVariable; stdcall;
    function GetAnnotationByName(Name: PAnsiChar): ID3D10EffectVariable; stdcall;

    function Apply(Flags: LongWord): HResult; stdcall;

    function ComputeStateBlockMask(out pStateBlockMask: TD3D10_StateBlockMask): HResult; stdcall;
  end;
  {$INTERFACES DEFAULT}

{$ENDIF}

  {$EXTERNALSYM ID3D10EffectPass}
  {$IFDEF FPC}
  ID3D10EffectPass_FPC = class(ID3D10EffectPass)
  {$ELSE}
  ID3D10EffectPass = class
  {$ENDIF}
    function IsValid(): BOOL; virtual; stdcall; abstract;
    function GetDesc(out pDesc: TD3D10_PassDesc): HResult; virtual; stdcall; abstract;

    function GetVertexShaderDesc(out pDesc: TD3D10_PassShaderDesc): HResult; virtual; stdcall; abstract;
    function GetGeometryShaderDesc(out pDesc: TD3D10_PassShaderDesc): HResult; virtual; stdcall; abstract;
    function GetPixelShaderDesc(out pDesc: TD3D10_PassShaderDesc): HResult; virtual; stdcall; abstract;

    function GetAnnotationByIndex(Index: LongWord): ID3D10EffectVariable; virtual; stdcall; abstract;
    function GetAnnotationByName(Name: PAnsiChar): ID3D10EffectVariable; virtual; stdcall; abstract;

    function Apply(Flags: LongWord): HResult; virtual; stdcall; abstract;

    function ComputeStateBlockMask(out pStateBlockMask: TD3D10_StateBlockMask): HResult; virtual; stdcall; abstract;
  end;


//////////////////////////////////////////////////////////////////////////////
// ID3D10EffectTechnique /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------
// D3D10_TECHNIQUE_DESC:
//
// Retrieved by ID3D10EffectTechnique::GetDesc()
//----------------------------------------------------------------------------

 PD3D10_TechniqueDesc = ^TD3D10_TechniqueDesc;
  _D3D10_TECHNIQUE_DESC = record
    Name: PAnsiChar;          // Name of this technique (NULL if not anonymous)
    Passes: LongWord;         // Number of passes contained within
    Annotations: LongWord;    // Number of annotations on this technique
  end;
 {$EXTERNALSYM _D3D10_TECHNIQUE_DESC}
 D3D10_TECHNIQUE_DESC = _D3D10_TECHNIQUE_DESC;
 {$EXTERNALSYM D3D10_TECHNIQUE_DESC}
 TD3D10_TechniqueDesc = _D3D10_TECHNIQUE_DESC;


// {DB122CE8-D1C9-4292-B237-24ED3DE8B175}
//DEFINE_GUID(IID_ID3D10EffectTechnique,
//0xdb122ce8, 0xd1c9, 0x4292, 0xb2, 0x37, 0x24, 0xed, 0x3d, 0xe8, 0xb1, 0x75);


{$IFDEF FPC}
  //----------------------------------------------------------------------------
  // To expose FreePascal class as abstract C++ class
  {$INTERFACES CORBA}
  ID3D10EffectTechnique = interface
    function IsValid(): BOOL; stdcall;
    function GetDesc(out pDesc: TD3D10_TechniqueDesc): HResult; stdcall;

    function GetAnnotationByIndex(Index: LongWord): ID3D10EffectVariable; stdcall;
    function GetAnnotationByName(Name: PAnsiChar): ID3D10EffectVariable; stdcall;

    function GetPassByIndex(Index: LongWord): ID3D10EffectPass; stdcall;
    function GetPassByName(Name: PAnsiChar): ID3D10EffectPass; stdcall;

    function ComputeStateBlockMask(out pStateBlockMask: TD3D10_StateBlockMask): HResult; stdcall;
  end;
  {$INTERFACES DEFAULT}

{$ENDIF}

  {$EXTERNALSYM ID3D10EffectTechnique}
  {$IFDEF FPC}
  ID3D10EffectTechnique_FPC = class(ID3D10EffectTechnique)
  {$ELSE}
  ID3D10EffectTechnique = class
  {$ENDIF}
    function IsValid(): BOOL; virtual; stdcall; abstract;
    function GetDesc(out pDesc: TD3D10_TechniqueDesc): HResult; virtual; stdcall; abstract;

    function GetAnnotationByIndex(Index: LongWord): ID3D10EffectVariable; virtual; stdcall; abstract;
    function GetAnnotationByName(Name: PAnsiChar): ID3D10EffectVariable; virtual; stdcall; abstract;

    function GetPassByIndex(Index: LongWord): ID3D10EffectPass; virtual; stdcall; abstract;
    function GetPassByName(Name: PAnsiChar): ID3D10EffectPass; virtual; stdcall; abstract;

    function ComputeStateBlockMask(out pStateBlockMask: TD3D10_StateBlockMask): HResult; virtual; stdcall; abstract;
  end;

//////////////////////////////////////////////////////////////////////////////
// ID3D10Effect //////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

//----------------------------------------------------------------------------
// D3D10_EFFECT_DESC:
//
// Retrieved by ID3D10Effect::GetDesc()
//----------------------------------------------------------------------------

  PD3D10_EffectDesc = ^TD3D10_EffectDesc;
  _D3D10_EFFECT_DESC = record

    IsChildEffect: BOOL;            // TRUE if this is a child effect,
                                    // FALSE if this is standalone or an effect pool.

    ConstantBuffers: LongWord;      // Number of constant buffers in this effect,
                                    // excluding the effect pool.
    SharedConstantBuffers: LongWord;// Number of constant buffers shared in this
                                    // effect's pool.

    GlobalVariables: LongWord;      // Number of global variables in this effect,
                                    // excluding the effect pool.
    SharedGlobalVariables: LongWord;// Number of global variables shared in this
                                    // effect's pool.

    Techniques: LongWord;           // Number of techniques in this effect,
                                    // excluding the effect pool.
  end;
  {$EXTERNALSYM _D3D10_EFFECT_DESC}
  D3D10_EFFECT_DESC = _D3D10_EFFECT_DESC;
  {$EXTERNALSYM D3D10_EFFECT_DESC}
  TD3D10_EffectDesc = _D3D10_EFFECT_DESC;



  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10Effect);'}
  {$EXTERNALSYM ID3D10Effect}
  ID3D10Effect = interface (IUnknown)
    ['{51B0CA8B-EC0B-4519-870D-8EE1CB5017C7}']
    function IsValid(): BOOL; stdcall;
    function IsPool(): BOOL; stdcall;

    // Managing D3D Device
    function GetDevice(out ppDevice: ID3D10Device): HResult; stdcall;

    // New Reflection APIs
    function GetDesc(out pDesc: TD3D10_EffectDesc): HResult; stdcall;

    function GetConstantBufferByIndex(Index: LongWord): ID3D10EffectConstantBuffer; stdcall;
    function GetConstantBufferByName(Name: PAnsiChar): ID3D10EffectConstantBuffer; stdcall;

    function GetVariableByIndex(Index: LongWord): ID3D10EffectVariable; stdcall;
    function GetVariableByName(Name: PAnsiChar): ID3D10EffectVariable; stdcall;
    function GetVariableBySemantic(Semantic: PAnsiChar): ID3D10EffectVariable; stdcall;

    function GetTechniqueByIndex(Index: LongWord): ID3D10EffectTechnique; stdcall;
    function GetTechniqueByName(Name: PAnsiChar): ID3D10EffectTechnique; stdcall;

    function Optimize(): HResult; stdcall;
    function IsOptimized(): BOOL; stdcall;
  end;

  IID_ID3D10Effect = ID3D10Effect;
  {$EXTERNALSYM IID_ID3D10Effect}


//////////////////////////////////////////////////////////////////////////////
// ID3D10EffectPool //////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D10EffectPool);'}
  {$EXTERNALSYM ID3D10EffectPool}
  ID3D10EffectPool = interface (IUnknown)
    ['{9537AB04-3250-412e-8213-FCD2F8677933}']
    function AsEffect(): ID3D10Effect; //todo: verify what this work correclty!!! -- returning COM objects...

    // No public methods
  end;

  IID_ID3D10EffectPool = ID3D10EffectPool;
  {$EXTERNALSYM IID_ID3D10EffectPool}



//////////////////////////////////////////////////////////////////////////////
// APIs //////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////


//----------------------------------------------------------------------------
// D3D10CreateEffectFromXXXX:
// --------------------------
// Creates an effect from a binary effect or file
//
// Parameters:
//
// [in]
//
//
//  pData
//      Blob of effect data, either ASCII (uncompiled, for D3D10CompileEffectFromMemory) or binary (compiled, for D3D10CreateEffect*)
//  DataLength
//      Length of the data blob
//
//  pSrcFileName
//      Name of the ASCII Effect file pData was obtained from
//
//  pDefines
//      Optional NULL-terminated array of preprocessor macro definitions.
//  pInclude
//      Optional interface pointer to use for handling #include directives.
//      If this parameter is NULL, #includes will be honored when compiling
//      from file, and will error when compiling from resource or memory.
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
//
//----------------------------------------------------------------------------

function D3D10CompileEffectFromMemory(const pData: Pointer; DataLength: SIZE_T; pSrcFileName: PAnsiChar; const pDefines: PD3D10_ShaderMacro;
    const pInclude: ID3D10Include; HLSLFlags: LongWord; FXFlags: LongWord;
    out ppCompiledEffect: ID3D10Blob; ppErrors: PID3D10Blob): HResult; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10CompileEffectFromMemory}

function D3D10CreateEffectFromMemory(const pData: Pointer; DataLength: SIZE_T; FXFlags: LongWord; const pDevice: ID3D10Device;
    const pEffectPool: ID3D10EffectPool; out ppEffect: ID3D10Effect): HResult; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10CreateEffectFromMemory}

function D3D10CreateEffectPoolFromMemory(const pData: Pointer; DataLength: SIZE_T; FXFlags: LongWord; const pDevice: ID3D10Device;
    out ppEffectPool: ID3D10EffectPool): HResult; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10CreateEffectPoolFromMemory}


//----------------------------------------------------------------------------
// D3D10DisassembleEffect:
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

function D3D10DisassembleEffect(const pEffect: ID3D10Effect; EnableColorCode: BOOL;
    out ppDisassembly: ID3D10Blob): HResult; stdcall; external D3D10dll;
{$EXTERNALSYM D3D10DisassembleEffect}




implementation



//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//
//  File:       D3D10.h
//  Content:
//
//////////////////////////////////////////////////////////////////////////////

// #define MAKE_D3D10_HRESULT( code )  MAKE_HRESULT( 1, _FACD3D10, code )
function MAKE_D3D10_HRESULT(Code: DWord): DWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
begin
  Result:= DWord((1 shl 31) or (_FACD3D10 shl 16)) or Code;
end;

//#define MAKE_D3D10_STATUS( code )    MAKE_HRESULT( 0, _FACD3D10, code )
function MAKE_D3D10_STATUS(Code: DWord): DWord;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
begin
  Result:= DWord((0 shl 31) or (_FACD3D10 shl 16)) or Code;
end;

function D3D10CalcSubresource( MipSlice, ArraySlice, MipLevels: LongWord): UINT;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
begin
  Result:= MipSlice + ArraySlice * MipLevels;
end;

function ColorArray(a, b, c, d: Single): TColorArray;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
begin
  Result[0]:= a;
  Result[1]:= b;
  Result[2]:= c;
  Result[3]:= d;
end;


//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//
//  File:       D3D10Shader.h
//  Content:    D3D10 Shader Types and APIs
//
//////////////////////////////////////////////////////////////////////////////


//---------------------------------------------------------------------------
// D3D10_TX_VERSION:
// --------------
// Version token used to create a procedural texture filler in effects
// Used by D3D10Fill[]TX functions
//---------------------------------------------------------------------------
//#define D3D10_TX_VERSION(_Major,_Minor) (('T' << 24) | ('X' << 16) | ((_Major) << 8) | (_Minor))
function D3D10_TX_VERSION(_Major, _Minor: Byte): DWORD; {$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
begin
  Result := (Byte('T') shl 24) or (Byte('X') shl 16) or (_Major shl 8) or _Minor;
end;



//////////////////////////////////////////////////////////////////////////////
//
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//
//  File:       D3D10Effect.h
//  Content:    D3D10 Stateblock/Effect Types & APIs
//
//////////////////////////////////////////////////////////////////////////////

// #define D3D10_BYTES_FROM_BITS(x) (((x) + 7) / 8)
function D3D10_BYTES_FROM_BITS(x: DWORD): DWORD;{$IFDEF SUPPORTS_INLINE} inline;{$ENDIF}
begin
  Result:=  (x + 7) mod 8;
end;

end.

