{*********************************************************}
{                                                         }
{                 Zeos Database Objects                   }
{         PostgreSQL Database Connectivity Classes        }
{                                                         }
{        Originally written by Sergey Seroukhov           }
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

unit ZDbcPostgreSql;

interface

{$I ZDbc.inc}

{$IFNDEF ZEOS_DISABLE_POSTGRESQL} //if set we have an empty unit
uses
  Classes, {$IFDEF MSEgui}mclasses,{$ENDIF} SysUtils,
  {$IF defined(DELPHI) and defined(MSWINDOWS)}Windows,{$IFEND}
  ZDbcIntfs, ZDbcConnection, ZPlainPostgreSqlDriver, ZDbcLogging, ZTokenizer,
  ZGenericSqlAnalyser, ZURL, ZCompatibility;

type

  {** Implements PostgreSQL Database Driver. }
  TZPostgreSQLDriver = class(TZAbstractDriver)
  public
    constructor Create; override;
    function Connect(const Url: TZURL): IZConnection; override;
    function GetMajorVersion: Integer; override;
    function GetMinorVersion: Integer; override;

    function GetTokenizer: IZTokenizer; override;
    function GetStatementAnalyser: IZStatementAnalyser; override;
  end;

  {** Defines a PostgreSQL specific connection. }
  IZPostgreSQLConnection = interface(IZConnection)
    ['{8E62EA93-5A49-4F20-928A-0EA44ABCE5DB}']

    function IsOidAsBlob: Boolean;
    function integer_datetimes: Boolean;
    function Is_bytea_output_hex: Boolean;

    function GetTypeNameByOid(Id: Oid): string;
    function GetPlainDriver: TZPostgreSQLPlainDriver;
    function GetPGconnAddress: PPGconn;
    function GetServerMajorVersion: Integer;
    function GetServerMinorVersion: Integer;
    function EncodeBinary(Buf: Pointer; Len: Integer; Quoted: Boolean): RawByteString; overload;
    function EncodeBinary(const Value: TBytes; Quoted: Boolean): RawByteString; overload;
    function EscapeString(const FromChar: PAnsiChar; len: NativeUInt; Quoted: Boolean): RawByteString; overload;
    procedure RegisterTrashPreparedStmtName(const value: String);
    function ClientSettingsChanged: Boolean;
    function GetUndefinedVarcharAsStringLength: Integer;
    function CheckFieldVisibility: Boolean;
  end;

  {** Implements PostgreSQL Database Connection. }

  { TZPostgreSQLConnection }

  TZPostgreSQLConnection = class(TZAbstractDbcConnection, IZPostgreSQLConnection)
  private
    FUndefinedVarcharAsStringLength: Integer;
    FStandardConformingStrings: Boolean;
    Fconn: TPGconn;
//  Jan: Not sure wether we still need that. What was its intended use?
//    FBeginRequired: Boolean;
    FTypeList: TStrings;
    FOidAsBlob, Finteger_datetimes: Boolean;
    FServerMajorVersion: Integer;
    FServerMinorVersion: Integer;
    FServerSubVersion: Integer;
    FNoticeProcessor: TZPostgreSQLNoticeProcessor;
    //a collection of statement handles that are not used anymore. These can be
    //safely deallocated upon the next transaction start or immediately if we
    //are in autocommit mode. See SF#137:
    FPreparedStatementTrashBin: TStringList;
    FClientSettingsChanged: Boolean;
    FIs_bytea_output_hex: Boolean;
    FCheckFieldVisibility: Boolean;
    FNoTableInfoCache: Boolean;
    fPlainDriver: TZPostgreSQLPlainDriver;
  protected
    procedure InternalCreate; override;
    function GetUndefinedVarcharAsStringLength: Integer;
    function BuildConnectStr: RawByteString;
    procedure DeallocatePreparedStatements;
    procedure DoStartTransaction;
    procedure DoCommit;
    procedure DoRollback;
    procedure LoadServerVersion;
    procedure OnPropertiesChange(Sender: TObject); override;
    procedure SetStandardConformingStrings(const Value: Boolean);
    function EncodeBinary(const Value: RawByteString; Quoted: Boolean): RawByteString; overload;
    function EncodeBinary(const Value: TBytes; Quoted: Boolean): RawByteString; overload;
    function EncodeBinary(Buf: Pointer; Len: Integer; Quoted: Boolean): RawByteString; overload;
    function EscapeString(const FromChar: PAnsiChar; len: NativeUInt; Quoted: Boolean): RawByteString; overload;
    procedure RegisterTrashPreparedStmtName(const value: String);
    function ClientSettingsChanged: Boolean;
  public
    destructor Destroy; override;

    function CreateRegularStatement(Info: TStrings): IZStatement; override;
    function CreatePreparedStatement(const SQL: string; Info: TStrings):
      IZPreparedStatement; override;
    function CreateCallableStatement(const SQL: string; Info: TStrings):
      IZCallableStatement; override;

    function CreateSequence(const Sequence: string; BlockSize: Integer): IZSequence; override;

    procedure SetAutoCommit(Value: Boolean); override;

    procedure Commit; override;
    procedure Rollback; override;
    //2Phase Commit Support initially for PostgresSQL (firmos) 21022006
    procedure PrepareTransaction(const transactionid: string);override;
    procedure CommitPrepared(const transactionid:string);override;
    procedure RollbackPrepared(const transactionid:string);override;

    procedure Open; override;
    procedure InternalClose; override;
    procedure ReleaseImmediat(const Sender: IImmediatelyReleasable); override;

    procedure SetTransactionIsolation(Level: TZTransactIsolationLevel); override;

    function IsOidAsBlob: Boolean;
    function Is_bytea_output_hex: Boolean;
    function integer_datetimes: Boolean;
    function CheckFieldVisibility: Boolean;

    function GetTypeNameByOid(Id: Oid): string;
    function GetPlainDriver: TZPostgreSQLPlainDriver;
    function GetPGconnAddress: PPGconn;

    function GetHostVersion: Integer; override;
    function GetServerMajorVersion: Integer;
    function GetServerMinorVersion: Integer;
    function GetServerSubVersion: Integer;

    function PingServer: Integer; override;

    procedure SetReadOnly(Value: Boolean); override;

    function EscapeString(const Value: RawByteString): RawByteString; overload; override;
    function GetBinaryEscapeString(const Value: RawByteString): String; overload; override;
    function GetBinaryEscapeString(const Value: TBytes): String; overload; override;
    procedure GetBinaryEscapeString(Buf: Pointer; Len: LengthInt; out Result: RawByteString); override;
    function GetEscapeString(const Value: ZWideString): ZWideString; overload; override;
    procedure GetEscapeString(Buf: PAnsichar; Len: LengthInt; out Result: RawByteString); override;
    function GetEscapeString(const Value: RawByteString): RawByteString; overload; override;
    function GetServerSetting(const AName: RawByteString): string;
    procedure SetServerSetting(const AName, AValue: RawbyteString);
    {$IFDEF ZEOS_TEST_ONLY}
    constructor Create(const ZUrl: TZURL);
    {$ENDIF}
    function GetServerProvider: TZServerProvider; override;
  end;

  {** Implements a Postgres sequence. }
  TZPostgreSQLSequence = class(TZAbstractSequence)
  public
    function GetCurrentValue: Int64; override;
    function GetNextValue: Int64; override;
    function GetCurrentValueSQL:String;override;
    function GetNextValueSQL:String;override;
  end;


var
  {** The common driver manager object. }
  PostgreSQLDriver: IZDriver;

{$ENDIF ZEOS_DISABLE_POSTGRESQL} //if set we have an empty unit
implementation
{$IFNDEF ZEOS_DISABLE_POSTGRESQL} //if set we have an empty unit

uses
  ZFastCode, ZMessages, ZSysUtils, ZDbcPostgreSqlStatement,
  ZDbcPostgreSqlUtils, ZDbcPostgreSqlMetadata, ZPostgreSqlToken,
  ZPostgreSqlAnalyser, ZEncoding, ZConnProperties, ZDbcProperties,
  ZDbcUtils;

const
  FON = String('ON');
  cBegin: {$IFDEF NO_ANSISTRING}RawByteString{$ELSE}AnsiString{$ENDIF} = 'BEGIN';
  cCommit: {$IFDEF NO_ANSISTRING}RawByteString{$ELSE}AnsiString{$ENDIF} = 'COMMIT';
  cRollback: {$IFDEF NO_ANSISTRING}RawByteString{$ELSE}AnsiString{$ENDIF} = 'ROLLBACK';

procedure DefaultNoticeProcessor({%H-}arg: Pointer; message: PAnsiChar); cdecl;
begin
  DriverManager.LogMessage(lcOther,'Postgres NOTICE', message);
end;

{ TZPostgreSQLDriver }

{**
  Constructs this object with default properties.
}
constructor TZPostgreSQLDriver.Create;
begin
  inherited Create;
  AddSupportedProtocol(AddPlainDriverToCache(TZPostgreSQLPlainDriver.Create));
end;

{**
  Attempts to make a database connection to the given URL.
  The driver should return "null" if it realizes it is the wrong kind
  of driver to connect to the given URL.  This will be common, as when
  the JDBC driver manager is asked to connect to a given URL it passes
  the URL to each loaded driver in turn.

  <P>The driver should raise a SQLException if it is the right
  driver to connect to the given URL, but has trouble connecting to
  the database.

  <P>The java.util.Properties argument can be used to passed arbitrary
  string tag/value pairs as connection arguments.
  Normally at least "user" and "password" properties should be
  included in the Properties.

  @param url the URL of the database to which to connect
  @param info a list of arbitrary string tag/value pairs as
    connection arguments. Normally at least a "user" and
    "password" property should be included.
  @return a <code>Connection</code> object that represents a
    connection to the URL
}
function TZPostgreSQLDriver.Connect(const Url: TZURL): IZConnection;
begin
  Result := TZPostgreSQLConnection.Create(Url);
end;

{**
  Gets the driver's major version number. Initially this should be 1.
  @return this driver's major version number
}
function TZPostgreSQLDriver.GetMajorVersion: Integer;
begin
  Result := 1;
end;

{**
  Gets the driver's minor version number. Initially this should be 0.
  @return this driver's minor version number
}
function TZPostgreSQLDriver.GetMinorVersion: Integer;
begin
  Result := 3;
end;

{**
  Gets a SQL syntax tokenizer.
  @returns a SQL syntax tokenizer object.
}
function TZPostgreSQLDriver.GetTokenizer: IZTokenizer;
begin
  Result := TZPostgreSQLTokenizer.Create; { thread save! Allways return a new Tokenizer! }
end;

{**
  Creates a statement analyser object.
  @returns a statement analyser object.
}
function TZPostgreSQLDriver.GetStatementAnalyser: IZStatementAnalyser;
begin
  Result := TZPostgreSQLStatementAnalyser.Create; { thread save! Allways return a new Analyser! }
end;

{ TZPostgreSQLConnection }

{**
  Constructs this object and assignes the main properties.
}
procedure TZPostgreSQLConnection.InternalCreate;
begin
  FMetaData := TZPostgreSQLDatabaseMetadata.Create(Self, Url);
  FPlainDriver := TZPostgreSQLPlainDriver(PlainDriver.GetInstance);
  FPreparedStatementTrashBin := nil;
  { Sets a default PostgreSQL port }
  if Self.Port = 0 then
     Self.Port := 5432;

  { Define connect options. }
//  Jan: Not sure wether we still need that. What was its intended use?
//  if Info.Values['beginreq'] <> '' then
//    FBeginRequired := StrToBoolEx(Info.Values['beginreq'])
//  else
//    FBeginRequired := True;

  inherited SetTransactionIsolation(tiReadCommitted);

  { Processes connection properties. }
  FOidAsBlob := StrToBoolEx(Info.Values[DSProps_OidAsBlob]);
  FUndefinedVarcharAsStringLength := StrToIntDef(Info.Values[DSProps_UndefVarcharAsStringLength], 0);
  FCheckFieldVisibility := StrToBoolEx(Info.Values[ConnProps_CheckFieldVisibility]);
  FNoTableInfoCache := StrToBoolEx(Info.Values[ConnProps_NoTableInfoCache]);
  OnPropertiesChange(nil);

  FNoticeProcessor := DefaultNoticeProcessor;
end;


function TZPostgreSQLConnection.GetUndefinedVarcharAsStringLength: Integer;
begin
  Result := FUndefinedVarcharAsStringLength;
end;

function TZPostgreSQLConnection.integer_datetimes: Boolean;
begin
  Result := Finteger_datetimes;
end;

{**
  Destroys this object and cleanups the memory.
}
destructor TZPostgreSQLConnection.Destroy;
begin
  if FTypeList <> nil then
    FreeAndNil(FTypeList);
  inherited Destroy;
  FreeAndNil(FPreparedStatementTrashBin);
end;

{**
  Builds a connection string for PostgreSQL.
  @return a built connection string.
}
function TZPostgreSQLConnection.BuildConnectStr: RawByteString;
var
  ConnectTimeout, Cnt: Integer;
  Buf: TRawBuff;
  //parameters should be separated by whitespace
  procedure AddParamToResult(const AParam: RawByteString;
    const AValue: String);
  begin
    if Cnt > 0 then
      ToBuff(AnsiChar(' '),Buf, Result);
    ToBuff(AParam, Buf, Result);
    ToBuff(AnsiChar('='),Buf, Result);
    // backslashes and single quotes must be escaped with backslashes
    ToBuff(SQLQuotedStr(EncodeCString({$IFDEF UNICODE}RawByteString{$ENDIF}(AValue)), AnsiChar(#39)),Buf, Result);
    Inc(Cnt);
  end;
begin
  //Init the result to empty string.
  Result := '';
  Cnt := 0;
  Buf.Pos := 0;
  //Entering parameters from the ZConnection
  If IsIpAddr(HostName) then
    AddParamToResult('hostaddr', HostName)
  else
    AddParamToResult('host', HostName);

  AddParamToResult('port', ZFastCode.IntToStr(Port));
  AddParamToResult('dbname', Database);
  if user <> '' then begin
    AddParamToResult('user', User);
    AddParamToResult('password', Password);
  end;

  If Info.Values[ConnProps_SSLMode] <> ''
    // the client (>= 7.3) sets the ssl mode for this connection
    // (possible values are: require, prefer, allow, disable)
  then AddParamToResult(ConnProps_SSLMode, Info.Values[ConnProps_SSLMode])
  else if Info.Values[ConnProps_RequireSSL] <> ''
    // the client (< 7.3) sets the ssl encription for this connection
    // (possible values are: 0,1)
  then AddParamToResult(ConnProps_RequireSSL, Info.Values[ConnProps_RequireSSL]);

  if Info.Values[ConnProps_SSLCompression] <> '' then AddParamToResult(ConnProps_SSLCompression, Info.Values[ConnProps_SSLCompression]);
  if Info.Values[ConnProps_SSLCert] <> '' then AddParamToResult(ConnProps_SSLCert, Info.Values[ConnProps_SSLCert]);
  if Info.Values[ConnProps_SSLKey] <> '' then AddParamToResult(ConnProps_SSLKey, Info.Values[ConnProps_SSLKey]);
  if Info.Values[ConnProps_SSLRootcert] <> '' then AddParamToResult(ConnProps_SSLRootcert, Info.Values[ConnProps_SSLRootcert]);
  if Info.Values[ConnProps_SSLCrl] <> '' then AddParamToResult(ConnProps_SSLCrl, Info.Values[ConnProps_SSLCrl]);

  { Sets a connection timeout. }
  ConnectTimeout := StrToIntDef(Info.Values[ConnProps_Timeout], -1);
  if ConnectTimeout >= 0 then
    AddParamToResult('connect_timeout', ZFastCode.IntToStr(ConnectTimeout));

  { Sets the application name }
  if Info.Values[ConnProps_ApplicationName] <> '' then
    AddParamToResult(ConnProps_ApplicationName, Info.Values[ConnProps_ApplicationName]);
  FlushBuff(Buf, Result);
end;

{**
  Checks is oid should be treated as Large Object.
  @return <code>True</code> if oid should represent a Large Object.
}
function TZPostgreSQLConnection.IsOidAsBlob: Boolean;
begin
  Result := FOidAsBlob;
end;

{**
  Checks is bytea_output hex.
  @return <code>True</code> if hex is set.
}
function TZPostgreSQLConnection.Is_bytea_output_hex: Boolean;
begin
  Result := FIs_bytea_output_hex;
end;

{**
  Checks if DataBaseMetaData should check FieldVisibility too.
  @return <code>True</code> if user did set it.
}
function TZPostgreSQLConnection.CheckFieldVisibility: Boolean;
begin
  Result := FCheckFieldVisibility;
end;

{**
  Deallocates prepared statements. This procedure is intended for driver internal
  use only and should normally only be called when in auto-commit mode. This
  either happens when unregistering a prepared statement and being in auto-commit
  mode or when committing or rolling back a transaction and before staring the
  next transaction block.
  @return <code>True</code> if user did set it.
}
procedure TZPostgreSQLConnection.DeallocatePreparedStatements;
var
  QueryHandle: TPGresult;
  SQL: RawByteString;
  x: Integer;
begin
  if Assigned(FPreparedStatementTrashBin) and (Fconn <> nil) and (FPreparedStatementTrashBin.Count > 0) then
    try
      for x := FPreparedStatementTrashBin.Count - 1 downto 0 do begin
        SQL := 'DEALLOCATE "' + {$IFDEF UNICODE}UnicodeStringToASCII7{$ENDIF}(FPreparedStatementTrashBin.Strings[x]) + '";';;
        QueryHandle := FPlainDriver.PQexec(Fconn, Pointer(SQL));
        FPreparedStatementTrashBin.Delete(x);
        if PGSucceeded(FPlainDriver.PQerrorMessage(Fconn)) then begin
          FPlainDriver.PQclear(QueryHandle);
          if DriverManager.HasLoggingListener then
            DriverManager.LogMessage(lcUnprepStmt, ConSettings^.Protocol, SQL);
        end else
          HandlePostgreSQLError(Self, FPlainDriver, Fconn, lcUnprepStmt, SQL,QueryHandle)
      end;
    finally
      FPreparedStatementTrashBin.Clear;
    end;
end;

{**
  Starts an explicit transaction.
}
procedure TZPostgreSQLConnection.DoStartTransaction;
var
  QueryHandle: TPGresult;
begin
//  Jan: Not sure wether we still need that. What was its intended use?
//  if FBeginRequired then begin
  QueryHandle := FPlainDriver.PQexec(Fconn, Pointer(cBegin));
  if PGSucceeded(FPlainDriver.PQerrorMessage(Fconn)) then begin
    FPlainDriver.PQclear(QueryHandle);
    if DriverManager.HasLoggingListener then
      DriverManager.LogMessage(lcTransaction, ConSettings^.Protocol, cBegin);
  end else
    HandlePostgreSQLError(Self, GetPlainDriver, Fconn, lcTransaction, cBegin, QueryHandle);
//  end;
end;

{**
  Commits an explicit transaction.
}
procedure TZPostgreSQLConnection.DoCommit;
var
  QueryHandle: TPGresult;
begin
  if not Closed then begin
    QueryHandle := FPlainDriver.PQexec(Fconn, Pointer(cCommit));
    if PGSucceeded(FPlainDriver.PQerrorMessage(Fconn)) then begin
      FPlainDriver.PQclear(QueryHandle);
      if DriverManager.HasLoggingListener then
        DriverManager.LogMessage(lcTransaction, ConSettings^.Protocol, cCommit);
    end else
      HandlePostgreSQLError(Self, GetPlainDriver, Fconn, lcTransaction,
        cCommit,QueryHandle);
  end;
end;

{**
  Rolls an explicit transaction back.
}
procedure TZPostgreSQLConnection.DoRollback;
var
  QueryHandle: TPGresult;
begin
  if not Closed then begin
    QueryHandle := FPlainDriver.PQexec(Fconn, Pointer(cRollback));
    if PGSucceeded(FPlainDriver.PQerrorMessage(Fconn)) then begin
      FPlainDriver.PQclear(QueryHandle);
      if DriverManager.HasLoggingListener then
        DriverManager.LogMessage(lcTransaction, ConSettings^.Protocol, cRollback);
    end else
      HandlePostgreSQLError(Self, FPlainDriver, Fconn, lcTransaction,
        cRollback,QueryHandle);
  end;
end;

{**
  Encodes a Binary-AnsiString to a PostgreSQL format
  @param Value the Binary String
  @result the encoded String
}
function TZPostgreSQLConnection.EncodeBinary(const Value: TBytes; Quoted: Boolean): RawByteString;
begin
  Result := EncodeBinary(Pointer(Value), Length(Value), Quoted);
end;

{**
  Encodes a Binary-AnsiString to a PostgreSQL format
  @param Value the Binary String
  @result the encoded String
}
function TZPostgreSQLConnection.EncodeBinary(const Value: RawByteString; Quoted: Boolean): RawByteString;
begin
  Result := EncodeBinary(Pointer(Value), Length(Value), Quoted);
end;

procedure TZPostgreSQLConnection.ReleaseImmediat(const Sender: IImmediatelyReleasable);
begin
  if Assigned(FPreparedStatementTrashBin) then
    FPreparedStatementTrashBin.Clear;
  Fconn := nil;
  inherited ReleaseImmediat(Sender);
end;

procedure TZPostgreSQLConnection.RegisterTrashPreparedStmtName(const value: String);
begin
  if FPreparedStatementTrashBin.IndexOf(Value) = -1 then
    FPreparedStatementTrashBin.Add(Value);
end;

function TZPostgreSQLConnection.ClientSettingsChanged: Boolean;
begin
  Result := FClientSettingsChanged;
end;
{**
  Opens a connection to database server with specified parameters.
}
procedure TZPostgreSQLConnection.Open;

var
  SCS, Temp: string;
  LogMessage: RawByteString;
begin
  if not Closed then
    Exit;

  LogMessage := 'CONNECT TO "'+ConSettings^.Database+'" AS USER "'+ConSettings^.User+'"';

  { Connect to PostgreSQL database. }
  Fconn := FPlainDriver.PQconnectdb(PAnsiChar(BuildConnectStr));
  try
    if FPlainDriver.PQstatus(Fconn) = CONNECTION_BAD then
      HandlePostgreSQLError(Self, GetPlainDriver, Fconn, lcConnect, LogMessage,nil)
    else if DriverManager.HasLoggingListener then
      DriverManager.LogMessage(lcConnect, ConSettings^.Protocol,
        'CONNECT TO "'+ConSettings^.Database+'" AS USER "'+ConSettings^.User+'"');

    { Set the notice processor (default = nil)}
    FPlainDriver.PQsetNoticeProcessor(Fconn,FNoticeProcessor,nil);

    { Gets the current codepage }
    Temp := GetPlainDriver.ValidateCharEncoding(FPlainDriver.PQclientEncoding(Fconn)).Name;

    { Sets a client codepage if necessary }
    if ( FClientCodePage <> '' ) and (Temp <> FClientCodePage) then
      SetServerSetting('CLIENT_ENCODING', {$IFDEF UNICODE}UnicodeStringToASCII7{$ENDIF}(FClientCodePage));

    inherited Open;

    SetTransactionIsolation(GetTransactionIsolation);
    if not GetAutoCommit then
      DoStartTransaction;

    { Gets the current codepage if it wasn't set..}
    if ( FClientCodePage = '') then
      CheckCharEncoding(Temp)
    else
    begin
      CheckCharEncoding(FClientCodePage);
      FClientSettingsChanged := True;
    end;

    if FPreparedStatementTrashBin = nil then
      FPreparedStatementTrashBin := TStringList.Create;

    { sets standard_conforming_strings according to Properties if available }
    SCS := Info.Values[ConnProps_StdConformingStrings];
    if SCS <> '' then begin
      SetServerSetting(ConnProps_StdConformingStrings, {$IFDEF UNICODE}UnicodeStringToASCII7{$ENDIF}(SCS));
      FClientSettingsChanged := True;
      SetStandardConformingStrings(StrToBoolEx(SCS));
    end else
      SetStandardConformingStrings(StrToBoolEx(GetServerSetting(#39+ConnProps_StdConformingStrings+#39)));
    {$IFDEF USE_SYNCOMMONS}
    SetServerSetting('DateStyle', 'ISO');
    {$ENDIF}
    Finteger_datetimes := StrToBoolEx(GetServerSetting(#39+ConnProps_integer_datetimes+#39));
    FIs_bytea_output_hex := UpperCase(GetServerSetting('''bytea_output''')) = 'HEX';
  finally
    if self.IsClosed and (Self.Fconn <> nil) then
    begin
      FPlainDriver.PQFinish(Fconn);
      Fconn := nil;
    end;
  end;
end;

procedure TZPostgreSQLConnection.PrepareTransaction(const transactionid: string);
var
   QueryHandle: TPGresult;
   SQL: RawByteString;
begin
  if not Closed then begin
    SQL:='PREPARE TRANSACTION '''+copy(ConSettings^.ConvFuncs.ZStringToRaw(transactionid,
      ConSettings^.CTRL_CP, ConSettings^.ClientCodePage^.CP),1,200)+'''';
    QueryHandle := FPlainDriver.PQexec(Fconn, PAnsiChar(SQL));
    if PGSucceeded(FPlainDriver.PQerrorMessage(Fconn)) then begin
      FPlainDriver.PQclear(QueryHandle);
      DriverManager.LogMessage(lcTransaction, ConSettings^.Protocol, SQL);
      DoStartTransaction;
    end else
      HandlePostgreSQLError(Self, GetPlainDriver, Fconn, lcExecute, SQL, QueryHandle);
  end;
end;

{**
  Creates a <code>Statement</code> object for sending
  SQL statements to the database.
  SQL statements without parameters are normally
  executed using Statement objects. If the same SQL statement
  is executed many times, it is more efficient to use a
  <code>PreparedStatement</code> object.
  <P>
  Result sets created using the returned <code>Statement</code>
  object will by default have forward-only type and read-only concurrency.

  @param Info a statement parameters.
  @return a new Statement object
}
function TZPostgreSQLConnection.CreateRegularStatement(Info: TStrings):
  IZStatement;
begin
  if IsClosed then
    Open;
  Result := TZPostgreSQLStatement.Create(Self, Info);
end;

{**
  Creates a <code>PreparedStatement</code> object for sending
  parameterized SQL statements to the database.

  A SQL statement with or without IN parameters can be
  pre-compiled and stored in a PreparedStatement object. This
  object can then be used to efficiently execute this statement
  multiple times.

  <P><B>Note:</B> This method is optimized for handling
  parametric SQL statements that benefit from precompilation. If
  the driver supports precompilation,
  the method <code>prepareStatement</code> will send
  the statement to the database for precompilation. Some drivers
  may not support precompilation. In this case, the statement may
  not be sent to the database until the <code>PreparedStatement</code> is
  executed.  This has no direct effect on users; however, it does
  affect which method throws certain SQLExceptions.

  Result sets created using the returned PreparedStatement will have
  forward-only type and read-only concurrency, by default.

  @param sql a SQL statement that may contain one or more '?' IN
    parameter placeholders
  @param Info a statement parameters.
  @return a new PreparedStatement object containing the
    pre-compiled statement
}
function TZPostgreSQLConnection.CreatePreparedStatement(
  const SQL: string; Info: TStrings): IZPreparedStatement;
begin
  if IsClosed then
     Open;
  if GetServerMajorVersion >= 3 then
    Result := TZPostgreSQLPreparedStatementV3.Create(Self, SQL, Info)
  else
    Result := TZPostgreSQLPreparedStatementV3.Create(Self, SQL, Info)
end;


{**
  Creates a <code>CallableStatement</code> object for calling
  database stored procedures (functions in PostgreSql).
  The <code>CallableStatement</code> object provides
  methods for setting up its IN and OUT parameters, and
  methods for executing the call to a stored procedure.

  <P><B>Note:</B> This method is optimized for handling stored
  procedure call statements. Some drivers may send the call
  statement to the database when the method <code>prepareCall</code>
  is done; others
  may wait until the <code>CallableStatement</code> object
  is executed. This has no
  direct effect on users; however, it does affect which method
  throws certain SQLExceptions.

  Result sets created using the returned CallableStatement will have
  forward-only type and read-only concurrency, by default.

  @param sql a SQL statement that may contain one or more '?'
    parameter placeholders. Typically this  statement is a JDBC
    function call escape string.
  @param Info a statement parameters.
  @return a new CallableStatement object containing the
    pre-compiled SQL statement
}
function TZPostgreSQLConnection.CreateCallableStatement(
  const SQL: string; Info: TStrings): IZCallableStatement;
begin
  if IsClosed then
     Open;
  Result := TZPostgreSQLCallableStatement.Create(Self, SQL, Info);
end;

{**
  Sets this connection's auto-commit mode.
  If a connection is in auto-commit mode, then all its SQL
  statements will be executed and committed as individual
  transactions.  Otherwise, its SQL statements are grouped into
  transactions that are terminated by a call to either
  the method <code>commit</code> or the method <code>rollback</code>.
  By default, new connections are in auto-commit mode.

  The commit occurs when the statement completes or the next
  execute occurs, whichever comes first. In the case of
  statements returning a ResultSet, the statement completes when
  the last row of the ResultSet has been retrieved or the
  ResultSet has been closed. In advanced cases, a single
  statement may return multiple results as well as output
  parameter values. In these cases the commit occurs when all results and
  output parameter values have been retrieved.

  @param autoCommit true enables auto-commit; false disables auto-commit.
}
procedure TZPostgreSQLConnection.SetAutoCommit(Value: Boolean);
begin
  if Value <> GetAutoCommit then begin
    if not Closed then
      if Value then
        DoCommit
      else
        DoStartTransaction;
    inherited SetAutoCommit(Value);
  end;
end;

{**
  Makes all changes made since the previous
  commit/rollback permanent and releases any database locks
  currently held by the Connection. This method should be
  used only when auto-commit mode has been disabled.
  @see #setAutoCommit
}
procedure TZPostgreSQLConnection.Commit;
begin
  if GetAutoCommit then
    raise Exception.Create(SInvalidOpInAutoCommit);

  if not Closed then begin
    DoCommit;
    DeallocatePreparedStatements;
    DoStartTransaction;
  end;
end;

{**
  Commits a prepared transaction in a 2-Phase commit.
  This method should be used only when in auto-commit mode.
  @see #setAutoCommit
}
procedure TZPostgreSQLConnection.CommitPrepared(const transactionid: string);
var
  QueryHandle: TPGresult;
  SQL: RawByteString;
begin
  if GetAutoCommit
  then raise Exception.Create('Commiting a prepared transaction is not supported while an explicit transaction is running.');

  if not Closed then begin
    SQL := 'COMMIT PREPARED '''+copy(RawByteString(transactionid),1,200)+'''';
    QueryHandle := FPlainDriver.PQexec(Fconn, Pointer(SQL));
    if PGSucceeded(FPlainDriver.PQerrorMessage(Fconn)) then begin
      FPlainDriver.PQclear(QueryHandle);
      if DriverManager.HasLoggingListener then
        DriverManager.LogMessage(lcTransaction, ConSettings^.Protocol, SQL);
    end else
      HandlePostgreSQLError(Self, GetPlainDriver, Fconn, lcExecute, SQL,QueryHandle);
  end;
end;

{**
  Drops all changes made since the previous
  commit/rollback and releases any database locks currently held
  by this Connection. This method should be used only when auto-
  commit has been disabled.

  @see #setAutoCommit
}
procedure TZPostgreSQLConnection.Rollback;
begin
  if GetAutoCommit then
    raise Exception.Create(SInvalidOpInAutoCommit);

  if not Closed then begin
    DoRollback;
    DeallocatePreparedStatements;
    DoStartTransaction;
  end;
end;


{**
  Rolls back a transaction that was prepared for 2-Phase commit.
  This method can only be used when auto-commit is enabled.
  @see #setAutoCommit
}
procedure TZPostgreSQLConnection.RollbackPrepared(const transactionid: string);
var
   QueryHandle: TPGresult;
   SQL: RawByteString;
begin
  if not GetAutoCommit
  then raise Exception.Create('Rolling back a prepared transaction is not supported while an explicit transaction is running.');

  if not Closed then begin
    SQL := 'ROLLBACK PREPARED '''+copy(RawByteString(transactionid),1,200)+'''';
    QueryHandle := FPlainDriver.PQexec(Fconn, Pointer(SQL));
    if PGSucceeded(FPlainDriver.PQerrorMessage(Fconn)) then begin
      FPlainDriver.PQclear(QueryHandle);
      DriverManager.LogMessage(lcTransaction, ConSettings^.Protocol, SQL);
    end else
      HandlePostgreSQLError(Self, GetPlainDriver, Fconn, lcTransaction, SQL,QueryHandle);
  end;
end;

{**
  Releases a Connection's database and JDBC resources
  immediately instead of waiting for
  them to be automatically released.

  <P><B>Note:</B> A Connection is automatically closed when it is
  garbage collected. Certain fatal errors also result in a closed
  Connection.
}
procedure TZPostgreSQLConnection.InternalClose;
var
  LogMessage: RawbyteString;
  QueryHandle: TPGresult;
  PError: PAnsiChar;
begin
  if ( Closed ) or (not Assigned(PlainDriver)) then
    Exit;
  //see https://sourceforge.net/p/zeoslib/tickets/246/
  if not GetAutoCommit then begin //try to commit
    QueryHandle := FPlainDriver.PQexec(Fconn, Pointer(cCommit));
    if PGSucceeded(FPlainDriver.PQerrorMessage(Fconn)) then begin
      FPlainDriver.PQclear(QueryHandle);
      if DriverManager.HasLoggingListener then
        DriverManager.LogMessage(lcTransaction, ConSettings^.Protocol, cCommit);
    end else begin
      if DriverManager.HasLoggingListener then
        DriverManager.LogMessage(lcTransaction, ConSettings^.Protocol, cCommit);
      if Assigned(FPlainDriver.PQresultErrorField) and Assigned(QueryHandle)
      then PError := FPlainDriver.PQresultErrorField(QueryHandle,Ord(PG_DIAG_SQLSTATE))
      else PError := FPLainDriver.PQerrorMessage(Fconn);
      //transaction aborted and in postre zombi status? If so a rollback is required
      if (ZSysUtils.ZMemLComp(PError, current_transaction_is_aborted, 5) = 0) then begin
        FPlainDriver.PQclear(QueryHandle);
        QueryHandle := FPlainDriver.PQexec(Fconn, Pointer(cRollback));
      end;
      if QueryHandle <> nil then
        FPlainDriver.PQclear(QueryHandle); //raise no exception
    end;
  end;
  try
    DeallocatePreparedStatements;
  finally
    if Fconn <> nil then
      FPlainDriver.PQFinish(Fconn);
    Fconn := nil;
    LogMessage := 'DISCONNECT FROM "'+ConSettings^.Database+'"';
    DriverManager.LogMessage(lcDisconnect, ConSettings^.Protocol, LogMessage);
  end;
end;

{**
  Sets a new transact isolation level. tiNone, tiReadUncommitted
  will be mapped to tiReadCommitted since PostgreSQL will treat
  them the same anyway.
  For Versions earlier than 8.0 tiRepeatableRead will be mapped
  to tiSerializable since versions priot to 8.0 don't support it.
  @param Level a new transact isolation level.
}
procedure TZPostgreSQLConnection.SetTransactionIsolation(
  Level: TZTransactIsolationLevel);
var
  QueryHandle: TPGresult;
  SQL: RawByteString;
begin
  if Level <> GetTransactionIsolation then begin
    if not IsClosed then begin
      SQL := RawByteString('SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL ');
      case level of
        tiNone, tiReadUncommitted, tiReadCommitted:
          SQL := SQL + RawByteString('READ COMMITTED');
        tiRepeatableRead:
          if (GetServerMajorVersion >= 8)
          then SQL := SQL + RawByteString('REPEATABLE READ')
          else SQL := SQL + RawByteString('SERIALIZABLE');
        tiSerializable:
          SQL := SQL + RawByteString('SERIALIZABLE');
      end;

      QueryHandle := FPlainDriver.PQexec(Fconn, Pointer(SQL));
      if PGSucceeded(FPlainDriver.PQerrorMessage(Fconn)) then begin
        if DriverManager.HasLoggingListener then
          DriverManager.LogMessage(lcTransaction, ConSettings^.Protocol, SQL);
        FPlainDriver.PQclear(QueryHandle);
      end else
        HandlePostgreSQLError(self, GetPlainDriver, Fconn, lcExecute, SQL ,QueryHandle);
    end;
    inherited SetTransactionIsolation(Level);
  end;
end;

procedure TZPostgreSQLConnection.GetBinaryEscapeString(Buf: Pointer;
  Len: LengthInt; out Result: RawByteString);
begin
  Result := Self.EncodeBinary(Buf, Len, True)
end;

{**
  Gets a reference to PostgreSQL connection handle.
  @return a reference to PostgreSQL connection handle.
}
function TZPostgreSQLConnection.GetPGconnAddress: PPGconn;
begin
  Result := @Fconn;
end;

procedure TZPostgreSQLConnection.GetEscapeString(Buf: PAnsichar; Len: LengthInt;
  out Result: RawByteString);
begin
  Result := EscapeString(Buf, Len, True)
end;

{**
  Gets a PostgreSQL plain driver interface.
  @return a PostgreSQL plain driver interface.
}
function TZPostgreSQLConnection.GetPlainDriver: TZPostgreSQLPlainDriver;
begin
  Result := FPlainDriver;
end;

{**
  Gets a type name by it's oid number.
  @param Id a type oid number.
  @return a type name or empty string if there was no such type found.
}
function TZPostgreSQLConnection.GetTypeNameByOid(Id: Oid): string;
var
  I, Index: Integer;
  QueryHandle: TPGresult;
  SQL: RawByteString;
  TypeCode, BaseTypeCode: Integer;
  TypeName: string;
  LastVersion: boolean;
  P: PAnsiChar;
begin
  if Closed then
     Open;

  LastVersion := (GetServerMajorVersion < 7 ) or
    ((GetServerMajorVersion = 7) and (GetServerMinorVersion < 3));
  { Fill the list with existed types }
  if not Assigned(FTypeList) then begin
    if LastVersion
    then SQL := 'SELECT oid, typname FROM pg_type WHERE oid<10000'
    else SQL := 'SELECT oid, typname, typbasetype, typtype FROM pg_type' +
             ' WHERE (typtype = ''b'' and oid < 10000) OR typtype = ''p'' OR typtype = ''e'' OR typbasetype<>0 ORDER BY oid';

    QueryHandle := FPlainDriver.PQexec(Fconn, Pointer(SQL));
    if PGSucceeded(FPlainDriver.PQerrorMessage(Fconn)) then begin
      if DriverManager.HasLoggingListener then
        DriverManager.LogMessage(lcExecute, ConSettings^.Protocol, SQL);

      FTypeList := TStringList.Create;
      for I := 0 to FPlainDriver.PQntuples(QueryHandle)-1 do begin
        TypeCode := RawToIntDef(FPlainDriver.PQgetvalue(QueryHandle, I, 0), 0);
        P := FPlainDriver.PQgetvalue(QueryHandle, I, 3);
        if (PByte(P)^ or $20) = ord('e') //lower 'E'
        then TypeName := 'enum'
        else begin
          P := FPlainDriver.PQgetvalue(QueryHandle, I, 1);
          {$IFDEF UNICODE}
          TypeName := ZSysUtils.ASCII7ToUnicodeString(P, ZFastCode.StrLen(P));
          {$ELSE}
          ZSetString(P, ZFastCode.StrLen(P), TypeName);
          {$ENDIF}
        end;
        if LastVersion
        then BaseTypeCode := 0
        else BaseTypeCode := RawToIntDef(FPlainDriver.PQgetvalue(QueryHandle, I, 2), 0);

        if BaseTypeCode <> 0 then begin
          Index := FTypeList.IndexOfObject(TObject(BaseTypeCode));
          if Index >= 0
          then TypeName := FTypeList[Index]
          else TypeName := '';
        end;
        FTypeList.AddObject(TypeName, TObject(TypeCode));
      end;
      GetPlainDriver.PQclear(QueryHandle);
    end else
      HandlePostgreSQLError(Self, FPlainDriver, Fconn, lcExecute, SQL, QueryHandle);
  end;

  I := FTypeList.IndexOfObject(TObject(Id));
  if I >= 0
  then Result := FTypeList[I]
  else Result := '';
end;

{**
  Gets the host's full version number. Initially this should be 0.
  The format of the version returned must be XYYYZZZ where
   X   = Major version
   YYY = Minor version
   ZZZ = Sub version
  @return this server's full version number
}
function TZPostgreSQLConnection.GetHostVersion: Integer;
begin
 Result := GetServerMajorVersion*1000000+GetServerMinorversion*1000+GetServerSubversion;
end;

{**
  Gets a server major version.
  @return a server major version number.
}
function TZPostgreSQLConnection.GetServerMajorVersion: Integer;
begin
  if (FServerMajorVersion = 0) and (FServerMinorVersion = 0) then
    LoadServerVersion;
  Result := FServerMajorVersion;
end;

{**
  Gets a server minor version.
  @return a server minor version number.
}
function TZPostgreSQLConnection.GetServerMinorVersion: Integer;
begin
  if (FServerMajorVersion = 0) and (FServerMinorVersion = 0) then
    LoadServerVersion;
  Result := FServerMinorVersion;
end;

function TZPostgreSQLConnection.GetServerProvider: TZServerProvider;
begin
  Result := spPostgreSQL;
end;

{**
  Gets a server sub version.
  @return a server sub version number.
}
function TZPostgreSQLConnection.GetServerSubVersion: Integer;
begin
  if (FServerMajorVersion = 0) and (FServerMinorVersion = 0) then
    LoadServerVersion;
  Result := FServerSubVersion;
end;

{**
  Loads a server major and minor version numbers.
}
procedure TZPostgreSQLConnection.LoadServerVersion;
var
  Temp: string;
  List: TStrings;
  QueryHandle: TPGresult;
  SQL: RawByteString;
  P: PAnsichar;
begin
  if Closed then
    Open;
  SQL := 'SELECT version()';
  QueryHandle := FPlainDriver.PQExec(Fconn, Pointer(SQL));
  if PGSucceeded(FPlainDriver.PQerrorMessage(Fconn)) then begin
    if DriverManager.HasLoggingListener then
      DriverManager.LogMessage(lcExecute, ConSettings^.Protocol, SQL);
    P := FPlainDriver.PQgetvalue(QueryHandle, 0, 0);
    {$IFDEF UNICODE}
    Temp := ZSysUtils.ASCII7ToUnicodeString(P, ZFastCode.StrLen(P));
    {$ELSE}
    ZSetString(P, ZFastCode.StrLen(P), Temp);
    {$ENDIF}
    FPlainDriver.PQclear(QueryHandle);

    List := TStringList.Create;
    try
      { Splits string by space }
      PutSplitString(List, Temp, ' ');
      { first - PostgreSQL, second X.Y.Z}
      Temp := List.Strings[1];
      { Splits string by dot }
      PutSplitString(List, Temp, '.');

      FServerMajorVersion := StrToIntDef(List.Strings[0], 0);
      if List.Count > 1 then
        FServerMinorVersion := GetMinorVersion(List.Strings[1])
      else
        FServerMinorVersion := 0;
      if List.Count > 2 then
        FServerSubVersion := GetMinorVersion(List.Strings[2])
      else
        FServerSubVersion := 0;
    finally
      List.Free;
    end;
  end else
    HandlePostgreSQLError(Self, GetPlainDriver, Fconn, lcExecute, SQL,QueryHandle);
end;

{** 
Ping Current Connection's server, if client was disconnected, 
the connection is resumed. 
@return 0 if succesfull or error code if any error occurs 
} 
function TZPostgreSQLConnection.PingServer: Integer; 
const 
  PING_ERROR_ZEOSCONNCLOSED = -1;
var
  res: TPGresult;
  isset: boolean;
begin
  Result := PING_ERROR_ZEOSCONNCLOSED;
  if Not Closed and (Fconn <> nil) then begin
    res := FPlainDriver.PQExec(Fconn,'');
    isset := assigned(res);
    GetPlainDriver.PQclear(res);
    if isset and (FPlainDriver.PQstatus(Fconn) = CONNECTION_OK) then
      Result := 0
    else
      try
        FPlainDriver.PQreset(Fconn);
        res := FPlainDriver.PQExec(Fconn,'');
        isset := assigned(res);
        GetPlainDriver.PQclear(res);
        if isset and (FPlainDriver.PQstatus(Fconn) = CONNECTION_OK) then
          Result := 0;
      except
        Result := 1;
      end;
  end;
end;

{**
  Puts this connection in read-only mode as a hint to enable
  database optimizations. This procedure does nothing for PosgreSQL
  versions prior to 7.4 because they don't support changing a transaction to
  read only.

  <P><B>Note:</B> This method cannot be called while in the
  middle of a transaction.

  @param readOnly true enables read-only mode; false disables
    read-only mode.
}
procedure TZPostgreSQLConnection.SetReadOnly(Value: Boolean);
var
  SQL: RawByteString;
  QueryHandle: TPGresult;
begin
  if (GetServerMajorVersion > 7) or ((GetServerMajorVersion = 7) and (GetServerMinorVersion >= 4)) then begin
    if Value <> isReadOnly then begin
      SQL := RawByteString('SET SESSION CHARACTERISTICS AS TRANSACTION ');
      case Value of
        true:
          SQL := SQL + RawByteString('READ ONLY');
        false:
          SQL := SQL + RawByteString('READ WRITE');
      end;
      QueryHandle := FPlainDriver.PQExec(Fconn, Pointer(SQL));
      if PGSucceeded(FPlainDriver.PQerrorMessage(Fconn)) then begin
        FPlainDriver.PQclear(QueryHandle);
        DriverManager.LogMessage(lcExecute, ConSettings^.Protocol, SQL);
      end else
        HandlePostgreSQLError(self, GetPlainDriver, Fconn, lcExecute, SQL ,QueryHandle);
    end;
  end;

  inherited SetReadOnly(Value);
end;

function TZPostgreSQLConnection.EscapeString(const Value: RawByteString): RawByteString;
begin
  Result := EscapeString(Pointer(Value), Length(Value), True)
end;
{**
  Creates a sequence generator object.
  @param Sequence a name of the sequence generator.
  @param BlockSize a number of unique keys requested in one trip to SQL server.
  @returns a created sequence object.
}
function TZPostgreSQLConnection.CreateSequence(const Sequence: string;
  BlockSize: Integer): IZSequence;
begin
  Result := TZPostgreSQLSequence.Create(Self, Sequence, BlockSize);
end;

{**
  EgonHugeist:
  Returns the BinaryString in a Tokenizer-detectable kind
  If the Tokenizer don't need to predetect it Result = BinaryString
  @param Value represents the Binary-String
  @param EscapeMarkSequence represents a Tokenizer detectable EscapeSequence (Len >= 3)
  @result the detectable Binary String
}
function TZPostgreSQLConnection.GetBinaryEscapeString(const Value: RawByteString): String;
begin
  Result := String(EncodeBinary(Value, True));
end;

{**
  EgonHugeist:
  Returns the BinaryString in a Tokenizer-detectable kind
  If the Tokenizer don't need to predetect it Result = BinaryString
  @param Value represents the Binary-String
  @param EscapeMarkSequence represents a Tokenizer detectable EscapeSequence (Len >= 3)
  @result the detectable Binary String
}
function TZPostgreSQLConnection.GetBinaryEscapeString(const Value: TBytes): String;
var Tmp: RawByteString;
begin
  ZSetString(PAnsiChar(Value), Length(Value), Tmp{%H-});
  Result := {$IFDEF UNICODE}ASCII7ToUnicodeString{$ENDIF}(EncodeBinary(Tmp, True));
end;

{**
  EgonHugeist:
  Returns a String in a Tokenizer-detectable kind
  If the Tokenizer don't need to predetect it Result = BinaryString
  @param Value represents the String
  @param EscapeMarkSequence represents a Tokenizer detectable EscapeSequence (Len >= 3)
  @result the detectable Postrgres-compatible String
}
function TZPostgreSQLConnection.GetEscapeString(const Value: ZWideString): ZWideString;
begin
  Result := ConSettings^.ConvFuncs.ZRawToUnicode(EscapeString(ConSettings.ConvFuncs.ZUnicodeToRaw(Value, ConSettings^.ClientCodePage^.CP)), ConSettings^.ClientCodePage^.CP);
end;

function TZPostgreSQLConnection.GetEscapeString(const Value: RawByteString): RawByteString;
begin
  Result := EscapeString(Value);
end;

{**
  Gets a current setting of run-time parameter.
  @param AName a parameter name.
  @result a parmeter value retrieved from server.
}
function TZPostgreSQLConnection.GetServerSetting(const AName: RawByteString): string;
var
  SQL: RawByteString;
  QueryHandle: TPGresult;
  P: PAnsichar;
begin
  SQL := 'select setting from pg_settings where name = '+AName;
  QueryHandle := FPlainDriver.PQExec(Fconn, Pointer(SQL));
  if PGSucceeded(FPlainDriver.PQerrorMessage(Fconn)) then begin
    if DriverManager.HasLoggingListener then
      DriverManager.LogMessage(lcExecute, ConSettings^.Protocol, SQL);
    P := FPlainDriver.PQgetvalue(QueryHandle, 0, 0);
    {$IFDEF UNICODE}
    Result := PRawToUnicode(P, ZFastCode.StrLen(P), ConSettings^.ClientCodePage^.CP);
    {$ELSE}
    ZSetString(P, ZFastCode.StrLen(P), Result);
    {$ENDIF}
    FPlainDriver.PQclear(QueryHandle);
  end else
    HandlePostgreSQLError(Self, GetPlainDriver, Fconn, lcExecute, SQL, QueryHandle);
end;

procedure TZPostgreSQLConnection.OnPropertiesChange(Sender: TObject);
var
  SCS: string;
begin
  inherited OnPropertiesChange(Sender);

  { Define standard_conforming_strings setting}
  SCS := Trim(Info.Values[ConnProps_StdConformingStrings]);
  if SCS <> ''
  then SetStandardConformingStrings(UpperCase(SCS) = FON)
  else SetStandardConformingStrings(True);
end;

{**
  Sets current setting of run-time parameter.
  String values should be already quoted.
  @param AName a parameter name.
  @param AValue a new parameter value.
}
procedure TZPostgreSQLConnection.SetServerSetting(const AName,
  AValue: RawbyteString);
var
  SQL: RawByteString;
  QueryHandle: TPGresult;
begin
  SQL := 'SET '+AName+' = '+AValue;
  QueryHandle := FPlainDriver.PQExec(Fconn, Pointer(SQL));
  if PGSucceeded(FPlainDriver.PQerrorMessage(Fconn)) then begin
    if DriverManager.HasLoggingListener then
      DriverManager.LogMessage(lcExecute, ConSettings^.Protocol, SQL);
    FPlainDriver.PQclear(QueryHandle);
  end else
    HandlePostgreSQLError(Self, GetPlainDriver, Fconn, lcExecute, SQL, QueryHandle);
end;

{$IFDEF ZEOS_TEST_ONLY}
constructor TZPostgreSQLConnection.Create(const ZUrl: TZURL);
begin
 inherited Create(ZUrl);
end;
{$ENDIF}

procedure TZPostgreSQLConnection.SetStandardConformingStrings(const Value: Boolean);
begin
  FStandardConformingStrings := Value;
end;


{ TZPostgreSQLSequence }
{**
  Gets the current unique key generated by this sequence.
  @param the last generated unique key.
}
function TZPostgreSQLSequence.GetCurrentValue: Int64;
var
  Statement: IZStatement;
  ResultSet: IZResultSet;
begin
  Statement := Connection.CreateStatement;
  ResultSet := Statement.ExecuteQuery(
    Format('SELECT %s', [GetCurrentValueSQL]));
  if ResultSet.Next then
    Result := ResultSet.GetLong(FirstDbcIndex)
  else
    Result := inherited GetCurrentValue;
  ResultSet.Close;
  Statement.Close;
end;

{**
  Gets the next unique key generated by this sequence.
  @param the next generated unique key.
}
function TZPostgreSQLSequence.GetCurrentValueSQL: String;
begin
  Result := Format(' CURRVAL(''%s'')', [Name]);
end;

function TZPostgreSQLSequence.GetNextValue: Int64;
var
  Statement: IZStatement;
  ResultSet: IZResultSet;
begin
  Statement := Connection.CreateStatement;
  ResultSet := Statement.ExecuteQuery(
    Format('SELECT %s', [GetNextValueSQL]));
  if ResultSet.Next then
    Result := ResultSet.GetLong(FirstDbcIndex)
  else
    Result := inherited GetNextValue;
  ResultSet.Close;
  Statement.Close;
end;

function TZPostgreSQLSequence.GetNextValueSQL: String;
begin
  Result := Format(' NEXTVAL(''%s'')', [Name]);
end;

function TZPostgreSQLConnection.EncodeBinary(Buf: Pointer;
  Len: Integer; Quoted: Boolean): RawByteString;
var
  escapedLen: LongWord;
  procedure SetResult(escapedBuf: PAnsichar; var Result: RawByteString);
  var P: PAnsiChar;
  begin
    escapedLen := escapedLen -1; //return length including #0
    ZSetString(nil, escapedLen+Byte(Ord(Quoted) shl 1), Result);
    P := Pointer(Result);
    if Quoted then begin
      P^ := #39;
      Inc(P);
    end;
    {$IFDEF FAST_MOVE}ZFastCode{$ELSE}System{$ENDIF}.Move(escapedBuf^, P^, escapedLen);
    FPlainDriver.PQFreemem(escapedBuf);
    if Quoted then
      (P+escapedLen)^ := #39;
  end;
begin
  if (Buf = nil) or (Len = 0) then
    if Quoted
    then Result := ''''''
    else Result := ''
  else if Assigned(Fconn) and Assigned(FPlainDriver.PQescapeByteaConn) then
    SetResult(FPlainDriver.PQescapeByteaConn(Fconn, Buf, Len, @escapedLen), Result)
  else if Assigned(FPlainDriver.PQescapeBytea) then
    SetResult(FPlainDriver.PQescapeBytea(Buf,Len,@escapedLen), Result)
  else
    Result := ZDbcPostgreSqlUtils.EncodeBinaryString(Buf, Len, Quoted);
end;

function TZPostgreSQLConnection.EscapeString(const FromChar: PAnsiChar;
  len: NativeUInt; Quoted: Boolean): RawByteString;
var
  Buf: Array[0..2048] of AnsiChar;
  iError: Integer;
  P: PAnsiChar;
  EscapedLen: NativeUInt;
begin
  if Assigned(FPlainDriver.PQescapeStringConn) or Assigned(FPlainDriver.PQescapeString) then begin
    if (Len+Byte(Ord(Quoted))) shl 1 > (SizeOf(Buf)-1) then begin
      SetLength(Result, (Len+Byte(Ord(Quoted))) shl 1);
      P := Pointer(Result);
    end else
      P := @Buf[0];
    if Quoted then
      P^ := #39;
    iError := 0;
    if Assigned(Fconn) and Assigned(FPlainDriver.PQescapeStringConn)
    then EscapedLen := FPlainDriver.PQescapeStringConn(Fconn, P+Ord(Quoted), FromChar, Len, @iError)
    else EscapedLen := FPlainDriver.PQescapeString(P+Ord(Quoted), FromChar, Len);
    if iError <> 0 then
      raise Exception.Create('Wrong string escape behavior!');
    if Quoted then
      (P+EscapedLen+(Byte(Ord(Quoted))))^ := #39;
    if P = @Buf[0]
    then ZSetString(@Buf[0], EscapedLen+(Byte(Ord(Quoted) shl 1)), Result)
    else SetLength(Result, EscapedLen+(Byte(Ord(Quoted)) shl 1));
  end else
    Result := ZDbcPostgreSqlUtils.PGEscapeString(FromChar, Len, ConSettings, Quoted);
end;

initialization
  PostgreSQLDriver := TZPostgreSQLDriver.Create;
  DriverManager.RegisterDriver(PostgreSQLDriver);
finalization
  if DriverManager <> nil then
    DriverManager.DeregisterDriver(PostgreSQLDriver);
  PostgreSQLDriver := nil;
{$ENDIF ZEOS_DISABLE_POSTGRESQL} //if set we have an empty unit
end.
