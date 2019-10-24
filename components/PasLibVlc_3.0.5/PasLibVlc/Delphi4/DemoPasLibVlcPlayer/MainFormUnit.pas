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
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, PasLibVlcUnit, PasLibVlcPlayerUnit;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    MenuFile: TMenuItem;
    MenuFileOpen: TMenuItem;
    MenuFileQuit: TMenuItem;
    OpenDialog: TOpenDialog;
    PasLibVlcPlayer: TPasLibVlcPlayer;
    procedure MenuFileQuitClick(Sender: TObject);
    procedure MenuFileOpenClick(Sender: TObject);
    procedure PasLibVlcPlayerMediaPlayerMediaChanged(Sender: TObject;
      mrl: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.MenuFileQuitClick(Sender: TObject);
begin
  Close();
end;

procedure TMainForm.MenuFileOpenClick(Sender: TObject);
var
  logo_file_1 : string;
  logo_file_2 : string;
begin
  if OpenDialog.Execute() then
  begin
    PasLibVlcPlayer.Play(OpenDialog.FileName);

    logo_file_1 := ExtractFilePath(Application.ExeName) + 'logo1.png';
    logo_file_2 := ExtractFilePath(Application.ExeName) + 'logo2.png';
    if (FileExists(logo_file_1) and FileExists(logo_file_2)) then
    begin
      PasLibVlcPlayer.LogoShowFiles([logo_file_1, logo_file_2], libvlc_position_top);
    end;
    PasLibVlcPlayer.MarqueeShowText('marquee test %H:%M:%S', libvlc_position_bottom);
  end;
end;

procedure TMainForm.PasLibVlcPlayerMediaPlayerMediaChanged(Sender: TObject;
  mrl: String);
begin
  Caption := mrl;
end;

end.
