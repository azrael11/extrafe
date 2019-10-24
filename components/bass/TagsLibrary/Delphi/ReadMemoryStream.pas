//********************************************************************************************************************************
//*                                                                                                                              *
//*     TReadMemoryStream 1.0.0.0 © 3delite 2015                                                                                 *
//*                                                                                                                              *
//* A simple TStream descendant wrapper class for accessing memory data to be used for functions requiring a TStream object.     *
//* The data is not freed when freeing the class, and no Write() is possible, only reading.                                      *
//*                                                                                                                              *
//* Can be used freely.                                                                                                          *
//*                                                                                                                              *
//* For other Delphi components see the home page:                                                                               *
//*                                                                                                                              *
//*     http://www.3delite.hu/                                                                                                   *
//*                                                                                                                              *
//* If you have any questions or enquiries please mail: 3delite@3delite.hu                                                       *
//*                                                                                                                              *
//* Good coding! :)                                                                                                              *
//* 3delite                                                                                                                      *
//********************************************************************************************************************************

unit ReadMemoryStream;

interface

Uses
    SysUtils,
    Classes;

type
    TReadMemoryStream = class (TCustomMemoryStream)
        Constructor Create(Address: Pointer; Size: NativeInt);
        Destructor Destroy; override;
        function Write(const Buffer; Count: Longint): Longint; override;
    end;

implementation

{ TReadMemoryStream }

constructor TReadMemoryStream.Create(Address: Pointer; Size: NativeInt);
begin
    inherited Create;
    SetPointer(Address, Size);
end;

destructor TReadMemoryStream.Destroy;
begin
    inherited;
end;

function TReadMemoryStream.Write(const Buffer; Count: Integer): Longint;
begin
    raise Exception.Create(Self.ClassName + ' does not support Write().');
end;

end.
