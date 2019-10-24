{*********************************************************}
{                                                         }
{                 Zeos Database Objects                   }
{        Test Cases for MSSql Component Bug Reports       }
{                                                         }
{*********************************************************}

{@********************************************************}
{    Copyright (c) 1999-2006 Zeos Development Group       }
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
{   http://zeosbugs.firmos.at (BUGTRACKER)                }
{   svn://zeos.firmos.at/zeos/trunk (SVN Repository)      }
{                                                         }
{   http://www.sourceforge.net/projects/zeoslib.          }
{   http://www.zeoslib.sourceforge.net                    }
{                                                         }
{                                                         }
{                                                         }
{                                 Zeos Development Group. }
{********************************************************@}

unit ZTestBugCompMSSql;

interface

{$I ZBugReport.inc}

uses
{$IFNDEF VER130BELOW}
  Variants,
{$ENDIF}
  Classes, DB, {$IFDEF FPC}testregistry{$ELSE}TestFramework{$ENDIF}, ZDataset,
  ZDbcIntfs, ZSqlTestCase,ZCompatibility;

type

  {** Implements a bug report test case for MSSql components. }
  TZTestCompMSSqlBugReport = class(TZAbstractCompSQLTestCase)
  protected
    function GetSupportedProtocols: string; override;

    procedure Test959307; //wrong defined????
    procedure Test953072; //is this test really solvable? I don't think so
  published
    procedure Test728955;
    procedure Test833489;
    procedure Test907497;
    procedure Mantis54;
    procedure Mantis164;
    procedure Test_SelectInformation_Schema;
  end;

implementation

uses SysUtils, Types, ZStoredProcedure, ZTestCase;

{ TZTestCompMSSqlBugReport }

function TZTestCompMSSqlBugReport.GetSupportedProtocols: string;
begin
  Result := 'mssql,FreeTDS_MsSQL<=6.5,FreeTDS_MsSQL-7.0,FreeTDS_MsSQL-2000,FreeTDS_MsSQL>=2005';
end;

{**
  Access Violation during ZReadOnlyQuery.Open
  In method TZAbstractRODataset.InternalInitFieldDefs: 
}
procedure TZTestCompMSSqlBugReport.Test728955;
var
  Query: TZReadOnlyQuery;
begin
  if SkipForReason(srClosedBug) then Exit;

  Query := CreateReadOnlyQuery;
  try
    Query.SQL.Text := 'SELECT * FROM department';
    Query.Open;
    CheckEquals(4, Query.FieldCount);

    CheckEquals(1, Query.FieldByName('dep_id').AsInteger);
    CheckEquals('Line agency', Query.FieldByName('dep_name').AsString);
    Query.Next;
    CheckEquals(2, Query.FieldByName('dep_id').AsInteger);
    CheckEquals('Container agency', Query.FieldByName('dep_name').AsString);
    Query.Close;
  finally
    Query.Free;
  end;
end;

{**
   Runs a test for bug report #833489
   AutoCommit=FALSE starting a transaction causing an error
}
procedure TZTestCompMSSqlBugReport.Test833489;
begin
  if SkipForReason(srClosedBug) then Exit;

  Connection.Disconnect;
  Connection.AutoCommit := False;
  Connection.Connect;
end;

procedure TZTestCompMSSqlBugReport.Test907497;
var
  StoredProc: TZStoredProc;
begin
  if SkipForReason(srClosedBug) then Exit;

  StoredProc := TZStoredProc.Create(nil);
  try
    StoredProc.Connection := Connection;
    StoredProc.StoredProcName := 'proc907497';
    StoredProc.ParamByName('@zzz').AsInteger := 12345;
    StoredProc.ExecProc;
    CheckEquals(7890, StoredProc.ParamByName('@zzz').AsInteger);
  finally
    StoredProc.Free;
  end;
end;

{**
   test for Bug#953072 - problem with queries with empty owner name
}
procedure TZTestCompMSSqlBugReport.Test953072;
var
  Query: TZQuery;
begin
  if SkipForReason(srClosedBug) then Exit;

  Query := CreateQuery;
  try
    Query.SQL.Text := 'select * from master..sysobjects';
    Query.Open;
    CheckEquals(False, Query.IsEmpty);
  finally
    Query.Free;
  end;
end;

{**
  test for Bug#959307 - empty string parameter translate as null
}
procedure TZTestCompMSSqlBugReport.Test959307;
var
  Query: TZQuery;
  StoredProc: TZStoredProc;
begin
  if SkipForReason(srClosedBug) then Exit;

  StoredProc := TZStoredProc.Create(nil);
  Query := CreateQuery;
  try
    StoredProc.Connection := Connection;
    StoredProc.StoredProcName := 'proc959307';
    Query.SQL.Text := 'select * from table959307';

    StoredProc.ParamByName('@p').AsString := 'xyz';
    StoredProc.ExecProc;
    Query.Open;
    CheckEquals('xyz', Query.FieldByName('fld1').AsString);
    Query.Close;

    StoredProc.ParamByName('@p').AsString := '';
    StoredProc.ExecProc;
    Query.Open;
    CheckEquals('', Query.FieldByName('fld1').AsString);
    CheckEquals(False, Query.FieldByName('fld1').IsNull);
    Query.Close;

    StoredProc.ParamByName('@p').Value := Null;
    StoredProc.ExecProc;
    CheckEquals('', Query.FieldByName('fld1').AsString);
    CheckEquals(True, Query.FieldByName('fld1').IsNull);
    Query.Close;
  finally
    StoredProc.Free;
    Query.Free;
  end;
end;

{ Mantis #54 }
{
The fields with data type "BigInt" in "MS-SQL" behave like "float" and not like Integer.
For example:
Suppose that 2 data bases are had. The one in MySQL and the other in MS-SQL Server, with a table each one.
The structure of the tables is the following one:

MS-SQL Server
CREATE TABLE Mantis54 (
    Key1 int NOT NULL ,
    BI bigint NULL ,
    F float NULL)

EgonHugeist:
  The resultset-Metadata returning 8, which is probably a floating type..
}
procedure TZTestCompMSSqlBugReport.Mantis54;
var
  Query: TZQuery;
begin
//??  if SkipForReason(srClosedBug) then Exit;

  Query := CreateQuery;
  try
    Query.SQL.Text := 'select * from mantis54';
    Query.Open;
    CheckEquals(ord(ftInteger), ord(Query.Fields[0].DataType));
    CheckEquals(ord(ftLargeInt), ord(Query.Fields[1].DataType), 'Int64/LongInt expected');
    CheckEquals(ord(ftFloat), ord(Query.Fields[2].DataType));
  finally
    Query.Free;
  end;
end;

procedure TZTestCompMSSqlBugReport.Mantis164;
const
  sGUID1 = '{546ED716-BB88-468C-8CCE-D7111CF5E1EF}';
  sGUID2 = '{BAF24A92-C8CE-4AB4-AEBC-3D4A9BCB0946}';
var
  Query: TZQuery;
  GUID1, GUID2: TGUID;
  Bts1, Bts2: TByteDynArray;
begin
  if SkipForReason(srClosedBug) then Exit;

  Query := CreateQuery;
  try
    Query.SQL.Text := 'select * from Mantis164';
    Query.Open;
    CheckEquals(9, Query.Fields.Count);
    CheckStringFieldType(Query.Fields[0].DataType, Connection.DbcConnection.GetConSettings);
    CheckEquals(ord(ftSmallInt), ord(Query.Fields[1].DataType));
    CheckEquals(ord(ftDateTime), ord(Query.Fields[2].DataType));
    {$IFDEF WITH_FTGUID}
    CheckEquals(ord(ftGUID), ord(Query.Fields[3].DataType), 'uniqueidentifier (GUID)');
    CheckEquals(ord(ftGUID), ord(Query.Fields[4].DataType), 'uniqueidentifier (GUID)');
    {$ELSE}
    CheckEquals(ord(ftBytes), ord(Query.Fields[3].DataType), 'uniqueidentifier (GUID)');
    CheckEquals(ord(ftBytes), ord(Query.Fields[4].DataType), 'uniqueidentifier (GUID)');
    {$ENDIF}
    CheckEquals(ord(ftBoolean), ord(Query.Fields[5].DataType));
    CheckEquals(ord(ftBytes), ord(Query.Fields[6].DataType), 'binary(16)');
    CheckEquals(ord(ftBytes), ord(Query.Fields[7].DataType), 'varbinary(16)');
    CheckEquals(ord(ftBlob), ord(Query.Fields[8].DataType));
    Query.Insert;
    Query.Fields[0].AsString := 'abc';
    Query.Fields[1].AsInteger := 1;
    Query.Fields[2].AsDateTime := Now;
    GUID1 := StringToGUID(sGUID1);
    GUID2 := StringToGUID(sGUID2);
    System.SetLength(Bts1, 16);
    System.SetLength(Bts2, 16);
    System.Move(Pointer(@GUID1)^, Pointer(Bts1)^, 16);
    System.Move(Pointer(@GUID2)^, Pointer(Bts2)^, 16);
    Query.Fields[6].Value := Bts1;
    Query.Fields[7].Value := Bts2;

    {$IFDEF WITH_FTGUID}
    Query.Fields[3].AsString := sGUID1;
    Query.Fields[4].AsString := sGUID2;
    {$ELSE}
    Query.Fields[3].Value := Bts1;
    Query.Fields[4].Value := Bts2;
    {$ENDIF}
    Query.Fields[5].AsBoolean := True;
    Query.Post;

    Query.Insert;
    Query.Fields[0].AsString := 'abc';
    Query.Fields[1].AsInteger := 2;
    Query.Fields[2].AsDateTime := Now;
    GUID1 := StringToGUID(sGUID1);
    GUID2 := StringToGUID(sGUID2);
    System.SetLength(Bts1, 16);
    System.Move(Pointer(@GUID1)^, Pointer(Bts1)^, 16);
    Query.Fields[6].Value := Bts1;

    {$IFDEF WITH_FTGUID}
    Query.Fields[3].AsString := sGUID1;
    {$ELSE}
    Query.Fields[3].Value := Bts1;
    {$ENDIF}
    Query.Fields[5].AsBoolean := True;
    Query.Post;

    Query.Close;
    Query.Open;
    CheckEquals('abc', Query.Fields[0].AsString);
    CheckEquals(1, Query.Fields[1].AsInteger);
    CheckEquals(True, Query.Fields[5].AsBoolean);
    {$IFDEF WITH_FTGUID}
    CheckEquals(sGUID1, Query.Fields[3].AsString);
    CheckEquals(sGUID2, Query.Fields[4].AsString);
    {$ELSE}
    Query.Fields[3].GetData(@GUID1);
    Query.Fields[4].GetData(@GUID2);
    CheckEquals(sGUID1, GUIDToString(GUID1));
    CheckEquals(sGUID2, GUIDToString(GUID2));
    {$ENDIF}
    Query.Delete;
    Query.Close;
  finally
    Query.SQL.Text := 'delete from Mantis164';
    Query.ExecSQL;
    Query.Free;
  end;
end;

procedure TZTestCompMSSqlBugReport.Test_SelectInformation_Schema;
var
  Query: TZQuery;
begin
  Query := CreateQuery;
  try
    Query.SQL.Text := 'select * from INFORMATION_SCHEMA.TABLES';
    Query.Open;
    Check(Query.Active);
  finally
    Query.Free;
  end;
end;

initialization
  RegisterTest('bugreport',TZTestCompMSSqlBugReport.Suite);
end.
