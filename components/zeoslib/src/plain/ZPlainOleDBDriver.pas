{*********************************************************}
{                                                         }
{                 Zeos Database Objects                   }
{             Native Plain Drivers for OleDB              }
{                                                         }
{            Originally written by EgonHugeist            }
{                                                         }
{*********************************************************}

{@********************************************************}
{    Copyright (c) 1999-2012 Zeos Development Group       }
{                                                         }
{ License Agreement:                                      }
{                                                         }
{ This library is distributed in the hope that it will be }
{ useful, but WITHOUT ANY WARRANTY; without even the      }
{ implied warranty of MERCHANTABILITY or FITNESS FOR      }
{ A PARTICULAR PURPOSE.  See the GNU Lesser General       }
{ Public License for more details.                        }
{                                                         }
{ The source code of the ZEOS Libraries and packages are  }
{ distributed under the Library GNU General Public        }
{ License (see the file COPYING / COPYING.ZEOS)           }
{ with the following  modification:                       }
{ As a special exception, the copyright holders of this   }
{ library give you permission to link this library with   }
{ independent modules to produce an executable,           }
{ regardless of the license terms of these independent    }
{ modules, and to copy and distribute the resulting       }
{ executable under terms of your choice, provided that    }
{ you also meet, for each linked independent module,      }
{ the terms and conditions of the license of that module. }
{ An independent module is a module which is not derived  }
{ from or based on this library. If you modify this       }
{ library, you may extend this exception to your version  }
{ of the library, but you are not obligated to do so.     }
{ If you do not wish to do so, delete this exception      }
{ statement from your version.                            }
{                                                         }
{                                                         }
{ The project web site is located on:                     }
{   http://zeos.firmos.at  (FORUM)                        }
{   http://sourceforge.net/p/zeoslib/tickets/ (BUGTRACKER)}
{   svn://svn.code.sf.net/p/zeoslib/code-0/trunk (SVN)    }
{                                                         }
{   http://www.sourceforge.net/projects/zeoslib.          }
{                                                         }
{                                                         }
{                                 Zeos Development Group. }
{********************************************************@}

unit ZPlainOleDBDriver;

interface

{$I ZPlain.inc}

{$IFNDEF ZEOS_DISABLE_OLEDB}

uses ZPlainDriver;

type
  TZOleDBPlainDriver = class (TZAbstractPlainDriver)
  public
    constructor Create;

    procedure LoadCodePages; override;
    function GetProtocol: string; override;
    function GetDescription: string; override;
    procedure Initialize(const {%H-}Location: String = ''); override;
    function Clone: IZPlainDriver; override;
  end;

{$ENDIF ZEOS_DISABLE_OLEDB}

implementation

{$IFNDEF ZEOS_DISABLE_OLEDB}

uses ZCompatibility, Windows;

procedure TZOleDBPlainDriver.LoadCodePages;
begin
  AddCodePage('CP_UTF16', 0, ceUTF16, GetACP,'', 1, False);
end;

constructor TZOleDBPlainDriver.Create;
begin
  LoadCodePages;
end;

function TZOleDBPlainDriver.GetProtocol: string;
begin
  Result := 'OleDB';
end;

function TZOleDBPlainDriver.GetDescription: string;
begin
  Result := 'Native driver for Microsoft OleDB';
end;

procedure TZOleDBPlainDriver.Initialize(const Location: String = '');
begin
end;

function TZOleDBPlainDriver.Clone: IZPlainDriver;
begin
  Result := Self;
end;

{$ENDIF ZEOS_DISABLE_OLEDB}

end.
