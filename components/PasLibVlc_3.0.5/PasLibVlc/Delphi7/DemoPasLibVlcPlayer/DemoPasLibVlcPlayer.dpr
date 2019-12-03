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

program DemoPasLibVlcPlayer;

uses
  Forms,
  PasLibVlcUnit in '..\..\source\PasLibVlcUnit.pas',
  PasLibVlcClassUnit in '..\..\source\PasLibVlcClassUnit.pas',
  PasLibVlcPlayerUnit in '..\..\source.vcl\PasLibVlcPlayerUnit.pas',
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  FullScreenFormUnit in 'FullScreenFormUnit.pas' {FullScreenForm},
  SetEqualizerPresetFormUnit in 'SetEqualizerPresetFormUnit.pas' {SetEqualizerPresetForm},
  SelectOutputDeviceFormUnit in 'SelectOutputDeviceFormUnit.pas' {SelectOutputDeviceForm},
  VideoAdjustFormUnit in 'VideoAdjustFormUnit.pas' {VideoAdjustForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'PasLibVlcPlayerDemo';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSetEqualizerPresetForm, SetEqualizerPresetForm);
  Application.CreateForm(TSelectOutputDeviceForm, SelectOutputDeviceForm);
  Application.CreateForm(TVideoAdjustForm, VideoAdjustForm);
  Application.Run;
end.