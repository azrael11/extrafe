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

unit MainFormUnit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Menus,
  {$IFDEF MSWINDOWS}
  FMX.Platform.Win,
  {$ENDIF}
  {$IFDEF MACOS}
  FMX.Platform.Mac,
  Macapi.AppKit,
  Macapi.CocoaTypes,
  Macapi.Foundation,
  Macapi.Helpers,
  Macapi.ObjectiveC,
  Macapi.CoreGraphics,
  Macapi.CoreFoundation,
  {$ENDIF}
  FMX.StdCtrls, FMX.Viewport3D, FMX.Objects, FMX.Media,
  FMX.ExtCtrls, FMX.Advertising,
  PasLibVlcUnit;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    MenuFile: TMenuItem;
    MenuOpen: TMenuItem;
    OpenDialog: TOpenDialog;
    MenuQuit: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure MenuOpenClick(Sender: TObject);
    procedure MenuQuitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    p_li : libvlc_instance_t_ptr;
    p_mi : libvlc_media_t_ptr;
  public
    procedure PlayerInit();
    procedure PlayerStop();
    procedure PlayerPlay(fileName: WideString);
    procedure PlayerDestroy();
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}
{$R *.Surface.fmx MSWINDOWS}
{$R *.SmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPad.fmx IOS}
{$R *.iPhone55in.fmx IOS}

procedure TMainForm.PlayerInit();
begin
//  libvlc_dynamic_dll_init_with_path('C:\Program Files (x86)\VideoLAN\VLC');
  libvlc_dynamic_dll_init();

  if (libvlc_dynamic_dll_error <> '') then
  begin
    ShowMessage(libvlc_dynamic_dll_error);
    Application.Terminate;
    exit;
  end;

  with TArgcArgs.Create([
    libvlc_dynamic_dll_path,
    '--intf=dummy',
    '--ignore-config',
    '--quiet',
    '--no-video-title-show',
    '--no-video-on-top'
  ]) do
  begin
    p_li := libvlc_new(ARGC, ARGS);
    Free;
  end;

  if (p_li <> NIL) then
  begin
    p_mi := libvlc_media_player_new(p_li);
  end;
end;

procedure TMainForm.PlayerStop();
begin
  if (p_mi <> NIL) then
  begin
    if (libvlc_media_player_is_playing(p_mi) = 1) then
    begin
      libvlc_media_player_stop(p_mi);
      Sleep(50);
      while (libvlc_media_player_is_playing(p_mi) = 1) do
      begin
        Sleep(50);
      end;
    end;
    libvlc_media_player_release(p_mi);
    p_mi := NIL;
    Sleep(50);
  end;
end;

procedure TMainForm.PlayerPlay(fileName: WideString);
var
  p_md : libvlc_media_t_ptr;
begin
  if (p_li <> NIL) then
  begin
    p_md := libvlc_media_new_path(p_li, PAnsiChar(UTF8Encode(fileName)));
    if (p_md <> NIL) then
    begin
      if (p_mi <> NIL) then
      begin
        // libvlc_video_set_key_input(p_mi, 1);
        // libvlc_video_set_mouse_input(p_mi, 1);
        {$IFDEF MSWINDOWS}
        libvlc_media_player_set_display_window(p_mi, WindowHandleToPlatform(MainForm.Handle).Wnd);
        {$ENDIF}
        {$IFDEF MACOS}
        libvlc_media_player_set_display_window(p_mi, WindowHandleToPlatform(MainForm.Handle).View.superview);
        {$ENDIF}
        libvlc_media_player_set_media(p_mi, p_md);
        libvlc_media_player_play(p_mi);
      end;
      libvlc_media_release(p_md);
    end;
  end;
end;

procedure TMainForm.PlayerDestroy();
begin
  if (p_li <> NIL) then
  begin
    PlayerStop();
    libvlc_release(p_li);
    p_li := NIL;
  end;
  libvlc_dynamic_dll_done();
end;

procedure TMainForm.FormActivate(Sender: TObject);
{$IFDEF MACOS}
var
  windowHandle : TMacWindowHandle;
  size : NSSize;
begin
  windowHandle := WindowHandleToPlatform( Handle );

  // set the minimum size of the window
  size.width := 512;
  size.height := 512;
  windowHandle.Wnd.setContentMinSize( size );

  // set the maximum size of the window
  size.width := 1024;
  size.height := 768;
  windowHandle.Wnd.setContentMaxSize( size );

  // set window remember screen size
  windowHandle.Wnd.setFrameAutosaveName(StrToNSStr('MainForm'));

  // Allow dragging of an FMX form by clicking anywhere in the client area, not just the title bar
  windowHandle.Wnd.setMovableByWindowBackground( true );
end;
{$ELSE}
begin

end;
{$ENDIF}

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PlayerDestroy();
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  p_li := NIL;
  p_mi := NIL;
  PlayerInit();
  Caption := Caption + ' - ' + {$IFDEF CPUX64}'64'{$ELSE}'32'{$ENDIF} + ' bit';
  if (libvlc_dynamic_dll_error = '') then
  begin
    Caption := Caption + ', libvlc: ' + libvlc_dynamic_dll_vlc_version_str;
    if (ParamStr(1) <> '') then
    begin
      PlayerPlay(ParamStr(1));
    end;
  end;
end;

procedure TMainForm.MenuOpenClick(Sender: TObject);
begin
  if OpenDialog.Execute() then
  begin
    PlayerPlay(OpenDialog.FileName);
    OpenDialog.InitialDir := ExtractFilePath(OpenDialog.FileName);
  end;
end;

procedure TMainForm.MenuQuitClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.
