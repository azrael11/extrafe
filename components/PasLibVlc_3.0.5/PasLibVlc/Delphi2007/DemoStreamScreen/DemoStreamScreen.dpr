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

program DemoStreamScreen;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  SysUtils,
  PasLibVlcUnit in '..\..\source\PasLibVlcUnit.pas';

const
  media_name  : PAnsiChar = 'Screen streaming test';
  media_input : PAnsiChar = 'screen://';
  media_sout  : PAnsiChar = '#transcode{vcodec=h264,vb=56,fps=4,scale=1,acodec=mp4a,ab=24,channels=1,samplerate=44100}:http{mux=ts,dst=:8090/}';
//  media_sout : PAnsiChar = '#transcode{vcodec=h264,acodec=mpga,ab=128,channels=2,samplerate=44100}:rtp{mux=ts,dst=127.0.0.1:8090/}';
//  media_sout : PAnsiChar = '#transcode{vcodec=h264,vb=800,scale=1,acodec=mpga,ab=128,channels=2,samplerate=44100}:http{mux=ts,dst=:8090/}';
//  media_sout : PAnsiChar = '#rtp{access=udp,mux=ts,dst=127.0.0.1,port=8090}'; // ,group="Video",name=Jumper Movie"
//  media_sout : PAnsiChar = '#standard{access=http,mux=ogg,dst=127.0.0.1:8090}';

var  
  p_li : libvlc_instance_t_ptr;

begin
  {$IFDEF DELPHI2007_UP}
  ReportMemoryLeaksOnShutdown := TRUE;
  {$ENDIF}
  
  try
    libvlc_dynamic_dll_init();

    if (libvlc_dynamic_dll_error <> '') then
    begin
      raise Exception.Create(libvlc_dynamic_dll_error);
    end;

    with TArgcArgs.Create([
      libvlc_dynamic_dll_path,
      '--intf=dummy',
      '--ignore-config',
      '--quiet',
      '--no-video-title-show',
      '--no-video-on-top'
      // '--vout=vdummy',
      // '--aout=adummy'
    ]) do
    begin
      p_li := libvlc_new(ARGC, ARGS);
      Free;
    end;

    with TArgcArgs.Create([
      libvlc_dynamic_dll_path,
      'screen-top=0',
      'screen-left=0',
      'screen-width=640',
      'screen-height=480',
      'screen-fps=10'
    ]) do
    begin
      libvlc_vlm_add_broadcast(p_li, media_name, media_input, media_sout, ARGC, ARGS, 1, 0);
      Free;
    end;

//    libvlc_vlm_add_broadcast(p_li, media_name, media_input, media_sout, 0, NIL, 1, 0);
    libvlc_vlm_play_media(p_li, media_name);

    Sleep(60 * 1000);

    libvlc_vlm_stop_media(p_li, media_name);
    libvlc_vlm_release(p_li);

    libvlc_dynamic_dll_done();

  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
