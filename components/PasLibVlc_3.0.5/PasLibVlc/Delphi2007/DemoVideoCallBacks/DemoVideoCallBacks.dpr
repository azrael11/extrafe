(*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * Any non-GPL usage of this software or parts of this software is strictly
 * forbidden.
 *
 * The "appropriate copyright message" mentioned in section 2c of the GPLv2
 * must read: "Code from FAAD2 is copyright (c) Nero AG, www.nero.com"
 *
 *)

{$I ..\..\source\compiler.inc}

program DemoVideoCallBacks;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Windows, SysUtils, Graphics, SyncObjs,
  PasLibVlcUnit in '..\..\source\PasLibVlcUnit.pas';

const
//  DEMO_FILE = '..\..\_testFiles\Maximize.mp4';
//  DEMO_FILE = '..\..\_testFiles\test.ts';
  DEMO_FILE = '..\..\_testFiles\1941.mp4';

var
  p_li : libvlc_instance_t_ptr;
  p_md : libvlc_media_t_ptr;
  p_mi : libvlc_media_player_t_ptr;

  vctx : TVideoCbCtx;
  bmpi : TBitmap;
  bmpc : LongWord;

function libvlc_video_lock_cb(ptr : Pointer; planes : PVCBPlanes) : Pointer; cdecl;
var
  pIdx : Integer;
begin
  with PVideoCbCtx(ptr)^ do
  begin
    lock.Enter;
    for pIdx := 0 to VOUT_MAX_PLANES-1 do
    begin
      planes^[pIdx] := buff_a32[pIdx];
    end;
    Result := buff_ptr[0];
  end;
end;

procedure libvlc_video_unlock_cb(ptr : Pointer; picture : Pointer; planes : PVCBPlanes); cdecl;
begin
  with PVideoCbCtx(ptr)^ do
  begin
    lock.Release;
  end;
end;

procedure libvlc_video_display_cb(ptr : Pointer; picture : Pointer); cdecl;
var
  y        : Integer;
  from_ptr : PByte;
  pIdx     : Integer;
  fileNumb : ShortString;
  fileName : ShortString;
begin
  with PVideoCbCtx(ptr)^ do
  begin
    lock.Enter;

    for pIdx := 0 to VOUT_MAX_PLANES-1 do
    begin

      if (pIdx > 0) then continue;

      from_ptr := buff_a32[pIdx];

      for y := 0 to video_h - 1 do
      begin
        Move(from_ptr^, bmpi.ScanLine[y]^, pitch_w);
        Inc(from_ptr, pitch_w_a32);
      end;

      Inc(bmpc);
      Str(bmpc, fileNumb);

      fileName := Copy('000000', 1, 6 - Length(fileNumb)) + fileNumb + '_p' + IntToStr(pIdx) + '.bmp';
      WriteLn(fileName);

      bmpi.SaveToFile(fileName);
    end;

    lock.Leave;
  end;
end;

function libvlc_video_format_cb(var ptr : Pointer; chroma : PAnsiChar; var width : LongWord; var height : LongWord; pitches : PVCBPitches; lines : PVCBLines) : LongWord; cdecl;
begin

  chroma^ := AnsiChar('B'); Inc(chroma);
  chroma^ := AnsiChar('G'); Inc(chroma);
  chroma^ := AnsiChar('R'); Inc(chroma);
  chroma^ := AnsiChar('A');

  with PVideoCbCtx(ptr)^ do
  begin
    lock.Enter;

    libvlc_video_cb_vctx_set_buffers(PVideoCbCtx(ptr), width, height, 4, pitches, lines);

    bmpi.SetSize(video_w, video_h);

    lock.Release;
  end;

  Result := 1;
end;

procedure libvlc_video_cleanup_cb(ptr : Pointer); cdecl;
begin
  with PVideoCbCtx(ptr)^ do
  begin
    lock.Enter;

    libvlc_video_cb_vctx_clr_buffers(PVideoCbCtx(ptr));

    bmpi.SetSize(0, 0);

    lock.Release;
  end;
end;

begin

  try

    FillChar(vctx, sizeof(vctx), 0);

    with vctx do
    begin
      lock := TCriticalSection.Create;
    end;

    libvlc_video_cb_vctx_set_buffers(@vctx, 320, 240, 4);

    bmpi := Graphics.TBitmap.Create;
    bmpi.PixelFormat := pf32bit;
    bmpi.SetSize(vctx.video_w, vctx.video_h);

    libvlc_dynamic_dll_init();

    if (libvlc_dynamic_dll_error <> '') then
    begin
      raise Exception.Create(libvlc_dynamic_dll_error);
    end;

    with TArgcArgs.Create([
      libvlc_dynamic_dll_path,
      '--intf=dummy',
      '--ignore-config'
//      '--quiet',
//      '--no-video-title-show',
//      '--no-video-on-top'
//       '--vout=vdummy',
//       '--aout=adummy'
    ]) do
    begin
      p_li := libvlc_new(ARGC, ARGS);
      Free;
    end;

    p_md := libvlc_media_new_path(p_li, PAnsiChar(UTF8Encode(DEMO_FILE)));
    libvlc_media_parse(p_md);

    p_mi := libvlc_media_player_new_from_media(p_md);

    libvlc_video_set_callbacks(p_mi, libvlc_video_lock_cb, libvlc_video_unlock_cb, libvlc_video_display_cb, @vctx);

    // use this for set video size to your needs
//    libvlc_video_set_format(p_mi, 'RV32', vctx.video_w, vctx.video_h, vctx.pitch_w);

    // use this for handle change video size etc.
    libvlc_video_set_format_callbacks(p_mi, libvlc_video_format_cb, libvlc_video_cleanup_cb);

    libvlc_media_player_play(p_mi);

    while (libvlc_media_player_get_state(p_mi) <> libvlc_Ended) do
    begin
      Sleep(50);
    end;

    libvlc_media_release(p_md);
    libvlc_media_player_release(p_mi);
    libvlc_release(p_li);

    WriteLn('Press ENTER to quit...');

  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;

  ReadLn;
end.
