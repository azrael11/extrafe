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

unit VideoAdjustFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TVideoAdjustForm = class(TForm)
    chkVideoAdjustEnable: TCheckBox;
    tbVideoAdjustContrast: TTrackBar;
    labVideoAdjustContrast: TLabel;
    tbVideoAdjustBrightness: TTrackBar;
    labVideoAdjustBrightness: TLabel;
    tbVideoAdjustHue: TTrackBar;
    labVideoAdjustHue: TLabel;
    tbVideoAdjustSaturation: TTrackBar;
    labVideoAdjustSaturation: TLabel;
    tbVideoAdjustGamma: TTrackBar;
    labVideoAdjustGamma: TLabel;
    procedure chkVideoAdjustEnableClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbVideoAdjustContrastChange(Sender: TObject);
    procedure tbVideoAdjustBrightnessChange(Sender: TObject);
    procedure tbVideoAdjustHueChange(Sender: TObject);
    procedure tbVideoAdjustSaturationChange(Sender: TObject);
    procedure tbVideoAdjustGammaChange(Sender: TObject);
  private
    FHandleChanges : Boolean;
  public
    
  end;

var
  VideoAdjustForm: TVideoAdjustForm;

implementation

{$R *.dfm}

uses
  MainFormUnit;

procedure TVideoAdjustForm.chkVideoAdjustEnableClick(Sender: TObject);
begin
  MainForm.PasLibVlcPlayer1.SetVideoAdjustEnable(chkVideoAdjustEnable.Checked);

  tbVideoAdjustContrast.Enabled    := chkVideoAdjustEnable.Checked;
  labVideoAdjustContrast.Enabled   := chkVideoAdjustEnable.Checked;
  tbVideoAdjustBrightness.Enabled  := chkVideoAdjustEnable.Checked;
  labVideoAdjustBrightness.Enabled := chkVideoAdjustEnable.Checked;
  tbVideoAdjustHue.Enabled         := chkVideoAdjustEnable.Checked;
  labVideoAdjustHue.Enabled        := chkVideoAdjustEnable.Checked;
  tbVideoAdjustSaturation.Enabled  := chkVideoAdjustEnable.Checked;
  labVideoAdjustSaturation.Enabled := chkVideoAdjustEnable.Checked;
  tbVideoAdjustGamma.Enabled       := chkVideoAdjustEnable.Checked;
  labVideoAdjustGamma.Enabled      := chkVideoAdjustEnable.Checked;
end;

procedure TVideoAdjustForm.FormShow(Sender: TObject);
begin
  FHandleChanges := FALSE;

//  chkVideoAdjustEnable.Checked := MainForm.PasLibVlcPlayer1.GetVideoAdjustEnable();
  chkVideoAdjustEnableClick(SELF);

  with MainForm.PasLibVlcPlayer1 do
  begin
    tbVideoAdjustContrast.Position   := Round(100 * GetVideoAdjustContrast());
    tbVideoAdjustBrightness.Position := Round(100 * GetVideoAdjustBrightness());
    tbVideoAdjustHue.Position        := Round(GetVideoAdjustHue());
    tbVideoAdjustSaturation.Position := Round(100 * GetVideoAdjustSaturation());
    tbVideoAdjustGamma.Position      := Round(100 * GetVideoAdjustGamma());
  end;

  FHandleChanges := TRUE;
end;

procedure TVideoAdjustForm.tbVideoAdjustBrightnessChange(Sender: TObject);
begin
  if FHandleChanges then
  begin
    with MainForm.PasLibVlcPlayer1 do
    begin
      SetVideoAdjustBrightness(tbVideoAdjustBrightness.Position / 100);
    end;
  end;
end;

procedure TVideoAdjustForm.tbVideoAdjustContrastChange(Sender: TObject);
begin
  if FHandleChanges then
  begin
    with MainForm.PasLibVlcPlayer1 do
    begin
      SetVideoAdjustContrast(tbVideoAdjustContrast.Position / 100);
    end;
  end;
end;

procedure TVideoAdjustForm.tbVideoAdjustGammaChange(Sender: TObject);
begin
  if FHandleChanges then
  begin
    with MainForm.PasLibVlcPlayer1 do
    begin
      SetVideoAdjustGamma(tbVideoAdjustGamma.Position / 100);
    end;
  end;
end;

procedure TVideoAdjustForm.tbVideoAdjustHueChange(Sender: TObject);
begin
  if FHandleChanges then
  begin
    with MainForm.PasLibVlcPlayer1 do
    begin
      SetVideoAdjustHue(tbVideoAdjustHue.Position);
    end;
  end;
end;

procedure TVideoAdjustForm.tbVideoAdjustSaturationChange(Sender: TObject);
begin
  if FHandleChanges then
  begin
    with MainForm.PasLibVlcPlayer1 do
    begin
      SetVideoAdjustSaturation(tbVideoAdjustSaturation.Position);
    end;
  end;
end;

end.
