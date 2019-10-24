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
  {$IFDEF UNIX}Unix,{$ENDIF}
  {$IFDEF MSWINDOWS}Windows,{$ENDIF}
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, PasLibVlcPlayerUnit;

type
  TMainForm = class(TForm)
    mrlEdit: TEdit;
    player: TPasLibVlcPlayer;
    playButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure playerMediaPlayerTimeChanged(Sender: TObject;
      time: Int64);
    procedure playButtonClick(Sender: TObject);
  private
    needStop : Boolean;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  needStop := TRUE;
  mrlEdit.Text := '..'+PathDelim+'..'+PathDelim+'_testFiles'+PathDelim+'test.ts';
  player.Play(mrlEdit.Text);
end;

procedure TMainForm.playButtonClick(Sender: TObject);
begin
  player.Resume();
end;

procedure TMainForm.playerMediaPlayerTimeChanged(Sender: TObject;
  time: Int64);
begin
  if (needStop) and (time > 100) then
  begin
    needStop := FALSE;
    player.Pause();
  end;
end;

end.
