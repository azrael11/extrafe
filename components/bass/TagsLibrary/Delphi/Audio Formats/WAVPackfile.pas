{ *************************************************************************** }
{                                                                             }
{ Audio Tools Library                                                         }
{ Class TWAVPackFile - for manipulating with WAVPack Files                    }
{                                                                             }
{ http://mac.sourceforge.net/atl/                                             }
{ e-mail: macteam@users.sourceforge.net                                       }
{                                                                             }
{ Copyright (c) 2003-2005 by Mattias Dahlberg                                 }
{                                                                             }
{ Version 1.3 (February 2015) by 3delite                                      }
{   - Added support for the NextGen compiler                                  }
{   - Added LoadFromStream() function                                         }
{                                                                             }
{ Version 1.2 (09 August 2004) by jtclipper                                   }
{   - updated to support WavPack version 4 files                              }
{   - added encoder detection                                                 }
{                                                                             }
{ Version 1.1 (April 2004) by Gambit                                          }
{   - Added Ratio and Samples property                                        }
{                                                                             }
{ Version 1.0 (August 2003)                                                   }
{                                                                             }
{ This library is free software; you can redistribute it and/or               }
{ modify it under the terms of the GNU Lesser General Public                  }
{ License as published by the Free Software Foundation; either                }
{ version 2.1 of the License, or (at your option) any later version.          }
{                                                                             }
{ This library is distributed in the hope that it will be useful,             }
{ but WITHOUT ANY WARRANTY; without even the implied warranty of              }
{ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU           }
{ Lesser General Public License for more details.                             }
{                                                                             }
{ You should have received a copy of the GNU Lesser General Public            }
{ License along with this library; if not, write to the Free Software         }
{ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA   }
{                                                                             }
{ *************************************************************************** }

unit WAVPackFile;

interface

uses
	Classes,
    SysUtils;

type
    TWAVPackfile = class(TObject)
    private
   	    FFileSize: int64;
		FValid: boolean;
		FFormatTag: integer;
        FVersion: integer;
		FChannels: integer;
		FSampleRate: integer;
		FBits: integer;
		FBitrate: double;
		FDuration: double;
        FEncoder: string;
        FTagSize: integer;
        FSamples: Int64;
        FBSamples: Int64;
        procedure FResetData;
        function FGetRatio: Double;
        function FGetChannelMode: string;
    public
        constructor Create;
        destructor Destroy; override;
        function LoadFromFile(const FileName: String; TagSize: Integer): Boolean;
        function LoadFromStream(Stream: TStream; TagSize: Integer): Boolean;
        function _ReadV3( f: TStream ): boolean;
        function _ReadV4( f: TStream ): boolean;
        property FileSize: int64 read FFileSize;
		property Valid: boolean read FValid;
		property FormatTag: integer	read FFormatTag;
        property Version: integer read FVersion;
		property Channels: integer read FChannels;
		property ChannelMode: string read FGetChannelMode;
		property SampleRate: integer read FSamplerate;
		property Bits: integer read FBits;
		property Bitrate: double read FBitrate;
		property Duration: double read FDuration;
        property Samples: Int64 read FSamples;
        property BSamples: Int64 read FBSamples;
        property Ratio: Double read FGetRatio;
        property Encoder: string read FEncoder;
	end;

implementation

type
	wavpack_header3 = record
		ckID: array[0..3] of Byte;
		ckSize: longword;
		version: word;
		bits: word  ;
		flags: word;
		shift: word;
		total_samples: longword;
		crc: longword;
		crc2: longword;
		extension: array[0..3] of Byte;
		extra_bc: byte;
		extras: array[0..2] of Byte;
	end;

	wavpack_header4 = record
		ckID: array[0..3] of Byte;
		ckSize: longword;
		version: word;
		track_no: byte;
		index_no: byte;
		total_samples: longword;
		block_index: longword;
		block_samples: longword;
		flags: longword;
		crc: longword;
	end;

	fmt_chunk = record
		wformattag: word;
		wchannels: word;
		dwsamplespersec: longword;
		dwavgbytespersec: longword;
		wblockalign: word;
		wbitspersample: word;
	end;

	riff_chunk = record
		id: array[0..3] of Byte;
		size: longword;
	end;

const

  //version 3 flags
  MONO_FLAG_v3	     = 1;	    // not stereo
  FAST_FLAG_v3	     = 2;	    // non-adaptive predictor and stereo mode
//  RAW_FLAG_v3	       = 4;	    // raw mode (no .wav header)
//  CALC_NOISE_v3	     = 8;	    // calc noise in lossy mode (no longer stored)
  HIGH_FLAG_v3	     = $10;	  // high quality mode (all modes)
//  BYTES_3_v3		     = $20;	  // files have 3-byte samples
//  OVER_20_v3		     = $40;	  // samples are over 20 bits
  WVC_FLAG_v3	       = $80;	  // create/use .wvc (no longer stored)
//  LOSSY_SHAPE_v3     = $100;  // noise shape (lossy mode only)
//  VERY_FAST_FLAG_v3	 = $200;  // double fast (no longer stored)
  NEW_HIGH_FLAG_v3	 = $400;  // new high quality mode (lossless only)
//  CANCEL_EXTREME_v3	 = $800;  // cancel EXTREME_DECORR
//  CROSS_DECORR_v3	   = $1000; // decorrelate chans (with EXTREME_DECORR flag)
//  NEW_DECORR_FLAG_v3 = $2000; // new high-mode decorrelator
//  JOINT_STEREO_v3	   = $4000; // joint stereo (lossy and high lossless)
  EXTREME_DECORR_v3	 = $8000; // extra decorrelation (+ enables other flags)

  sample_rates: array[0..14] of integer = ( 6000, 8000, 9600, 11025, 12000, 16000, 22050,
                                            24000, 32000, 44100, 48000, 64000, 88200, 96000, 192000 );

{ --------------------------------------------------------------------------- }

procedure TWAVPackfile.FResetData;
begin
	FFileSize := 0;
    FTagSize := 0;
	FValid := false;
	FFormatTag := 0;
	FChannels := 0;
	FSampleRate := 0;
	FBits := 0;
	FBitrate := 0;
	FDuration := 0;
    FVersion := 0;
    FEncoder := '';
    FSamples := 0;
    FBSamples := 0;
    //FAPEtag.Clear;
end;

{ --------------------------------------------------------------------------- }

constructor TWAVPackfile.Create;
begin
	inherited;
    //FAPEtag  := TAPEv2Tag.Create;
	FResetData;
end;

destructor TWAVPackfile.Destroy;
begin
    //FAPEtag.Free;
    inherited;
end;

{ --------------------------------------------------------------------------- }

function TWAVPackfile.FGetChannelMode: string;
begin
    case FChannels of
        1: result := 'Mono';
        2: result := 'Stereo';
    else result := 'Surround';
    end;
end;

{ --------------------------------------------------------------------------- }

function TWAVPackfile.LoadFromFile(const FileName: String; TagSize: Integer): Boolean;
var
    f: TStream;
begin
    FResetData;
    try
        f := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
        Result := LoadFromStream(f, TagSize);
    finally
        FreeAndNil(f);
    end;
end;

function TWAVPackfile.LoadFromStream(Stream: TStream; TagSize: Integer): Boolean;
var
    marker: array[0..3] of Byte;
begin
    FResetData;
    FTagSize := TagSize;
    FFileSize := Stream.Size;
    //read first bytes
    FillChar( marker, SizeOf(marker), 0);
    Stream.Read(marker, SizeOf(marker));
    Stream.Seek(0, soBeginning);
    if (marker[0] = Ord('R'))
    AND (marker[1] = Ord('I'))
    AND (marker[2] = Ord('F'))
    AND (marker[3] = Ord('F'))
    then begin
        result := _ReadV3(Stream);
    end else if (marker[0] = Ord('w'))
    AND (marker[1] = Ord('v'))
    AND (marker[2] = Ord('p'))
    AND (marker[3] = Ord('k'))
    then begin
        Result := _ReadV4(Stream);
    end else begin
        Result := False;
    end;
end;
{ --------------------------------------------------------------------------- }

function TWAVPackfile._ReadV4(f: TStream): boolean;
var
    wvh4: wavpack_header4;
    EncBuf : array[1..4096] of Byte;
    tempo : Integer;
    encoderbyte: Byte;
begin
    Result := False;
    FillChar( wvh4, SizeOf(wvh4) ,0);
    f.Read(wvh4, SizeOf(wvh4));
    if (wvh4.ckID[0] = Ord('w'))
    AND (wvh4.ckID[1] = Ord('v'))
    AND (wvh4.ckID[2] = Ord('p'))
    AND (wvh4.ckID[3] = Ord('k'))
    then // wavpack header found
    begin
        Result := true;
        FValid := true;
        FVersion := wvh4.version shr 8;
        FChannels := 2 - (wvh4.flags and 4);  // mono flag
        FBits := ((wvh4.flags and 3) * 16);   // bytes stored flag
        FSamples := wvh4.total_samples;
        FBSamples := wvh4.block_samples;
        FSampleRate := (wvh4.flags and ($1F shl 23)) shr 23;
        if (FSampleRate > 14) or (FSampleRate < 0) then begin
            FSampleRate := 44100;
        end else begin
            FSampleRate := sample_rates[FSampleRate];
        end;

        if ((wvh4.flags and 8) = 8) then // hybrid flag
        begin
            FEncoder := 'hybrid lossy';
        end else begin //if ((wvh4.flags and 2) = 2) then begin  // lossless flag
            FEncoder := 'lossless';
        end;
{
    if ((wvh4.flags and $20) > 0) then // MODE_HIGH
    begin
      FEncoder := FEncoder + ' (high)';
    end
    else if ((wvh4.flags and $40) > 0) then // MODE_FAST
    begin
      FEncoder := FEncoder + ' (fast)';
    end;
}
        FDuration := wvh4.total_samples / FSampleRate;
        if FDuration > 0 then begin
            FBitrate := (FFileSize - int64( FTagSize ) ) * 8 / (FSamples / FSampleRate) / 1000;
        end;
        FillChar(EncBuf, SizeOf(EncBuf), 0);
        f.Read(EncBuf, SizeOf(EncBuf));
        for tempo := 1 to 4094 do begin
            If EncBuf[tempo] = $65 then if
                EncBuf[tempo + 1] = $02 then begin
                    encoderbyte := EncBuf[tempo + 2];
                if encoderbyte = 8 then
                    FEncoder := FEncoder + ' (high)'
                else if encoderbyte = 0 then
                    FEncoder := FEncoder + ' (normal)'
                else if encoderbyte = 2 then
                    FEncoder := FEncoder + ' (fast)'
                else if encoderbyte = 6 then
                    FEncoder := FEncoder + ' (very fast)';
                Break;
            end;
        end;
    end;
end;

{ --------------------------------------------------------------------------- }

function TWAVPackfile._ReadV3(f: TStream): boolean;
var
    chunk: riff_chunk;
    wavchunk: array[0..3] of Byte;
    fmt: fmt_chunk;
    hasfmt: boolean;
    fpos: int64;
    wvh3: wavpack_header3;
begin
    Result := False;
    hasfmt := False;
    // read and evaluate header
    FillChar( chunk, sizeof(chunk), 0 );
    if (f.Read(chunk, sizeof(chunk)) <> SizeOf( chunk )) or
    (f.Read(wavchunk, sizeof(wavchunk)) <> SizeOf(wavchunk))
    or (wavchunk[0] <> Ord('W'))
    or (wavchunk[1] <> Ord('A'))
    or (wavchunk[2] <> Ord('V'))
    or (wavchunk[3] <> Ord('E'))
    then exit;
    // start looking for chunks
    FillChar( chunk, SizeOf(chunk), 0 );
    while (f.Position < f.Size) do begin
        if (f.read(chunk, sizeof(chunk)) < sizeof(chunk)) or (chunk.size <= 0) then break;
        fpos := f.Position;
        if (chunk.id[0] = Ord('f'))
        AND (chunk.id[1] = Ord('m'))
        AND (chunk.id[2] = Ord('t'))
        AND (chunk.id[3] = Ord(' '))
        then begin // Format chunk found read it
            if (chunk.size >= sizeof(fmt)) and (f.Read(fmt, sizeof(fmt)) = sizeof(fmt)) then begin
                hasfmt := true;
                result := True;
                FValid := true;
                FFormatTag := fmt.wformattag;
                FChannels := fmt.wchannels;
                FSampleRate := fmt.dwsamplespersec;
                FBits := fmt.wbitspersample;
                FBitrate := fmt.dwavgbytespersec / 125.0; // 125 = 1/8*1000
            end else begin
                Break;
            end;
        end else if (chunk.id[0] = Ord('d'))
        AND (chunk.id[1] = Ord('a'))
        AND (chunk.id[2] = Ord('t'))
        AND (chunk.id[3] = Ord('a'))
        and hasfmt
        then begin
            FillChar( wvh3, SizeOf(wvh3) ,0);
            f.Read( wvh3, SizeOf(wvh3) );
            if (wvh3.ckID[0] = Ord('w'))
            AND (wvh3.ckID[1] = Ord('v'))
            AND (wvh3.ckID[2] = Ord('p'))
            AND (wvh3.ckID[3] = Ord('k'))
            then begin // wavpack header found
                result := true;
                FValid := true;
                FVersion := wvh3.version;
                FChannels := 2 - (wvh3.flags and 1);  // mono flag
                FSamples := wvh3.total_samples;
                // Encoder guess
                if wvh3.bits > 0 then begin
                    if (wvh3.flags and NEW_HIGH_FLAG_v3) > 0 then begin
                        FEncoder := 'hybrid';
                        if (wvh3.flags and WVC_FLAG_v3) > 0 then begin
                            FEncoder := FEncoder + ' lossless';
                        end else begin
                            FEncoder := FEncoder + ' lossy';
                        end;
                        if (wvh3.flags and EXTREME_DECORR_v3) > 0 then FEncoder := FEncoder + ' (high)';
                        end else if (wvh3.flags and (HIGH_FLAG_v3 or FAST_FLAG_v3)) = 0 then begin
                            FEncoder := IntToStr( wvh3.bits + 3 ) + '-bit lossy';
                        end else begin
                            FEncoder := IntToStr( wvh3.bits + 3 ) + '-bit lossy';
                            if (wvh3.flags and HIGH_FLAG_v3) > 0 then begin
                                FEncoder := FEncoder + ' high';
                            end else begin
                                FEncoder := FEncoder + ' fast';
                            end
                        end;
                    end else begin
                        if (wvh3.flags and HIGH_FLAG_v3) = 0 then begin
                            FEncoder := 'lossless (fast mode)';
                        end else if (wvh3.flags and EXTREME_DECORR_v3) > 0 then begin
                            FEncoder := 'lossless (high mode)';
                        end else begin
                            FEncoder := 'lossless';
                        end;
                    end;

                if FSampleRate <= 0 then FSampleRate := 44100;
                FDuration := wvh3.total_samples / FSampleRate;
                if FDuration > 0 then FBitrate := 8.0*(FFileSize  - int64( FTagSize )  - int64(wvh3.ckSize))/(FDuration*1000.0);
            end;
            Break;
        end else begin // not a wv file
            Break;
        end;
        f.seek(fpos + chunk.size, soBeginning);
    end; // while
end;

{ --------------------------------------------------------------------------- }

function TWAVPackfile.FGetRatio: Double;
begin
    { Get compression ratio }
    if FValid then
        Result := FFileSize / (FSamples * (FChannels * FBits / 8) + 44) * 100
    else
        Result := 0;
end;
     
{ --------------------------------------------------------------------------- }

end.
