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
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  PasLibVlcPlayerUnit, PasLibVlcUnit;

type

  { TMainForm }

  TMainForm = class(TForm)
    EventsMemo: TMemo;
    LeftPanel: TPanel;
    InfoPanel: TPanel;
    PauseBtn: TButton;
    TimePanel: TPanel;
    RightPanel: TPanel;
    PlayModeDefaultBtn: TButton;
    PasLibVlcMediaList1: TPasLibVlcMediaList;
    PlayListBox: TListBox;
    BottomPanel: TPanel;
    Player: TPasLibVlcPlayer;
    PlayBtn: TButton;
    PlayModeLoopBtn: TButton;
    PlayModeRepeatBtn: TButton;
    PrevBtn: TButton;
    NextBtn: TButton;
    StopBtn: TButton;
    ClearBtn: TButton;
    InfoTrackBar: TTrackBar;
    procedure ClearBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure InfoTrackBarChange(Sender: TObject);
    procedure PasLibVlcMediaList1MediaListItemAdded(Sender: TObject;
      mrl: WideString; item: Pointer; index: Integer);
    procedure PauseBtnClick(Sender: TObject);
    procedure PlayerMediaPlayerEndReached(Sender: TObject);
    procedure PlayerMediaPlayerLengthChanged(Sender: TObject; time: Int64);
    procedure PlayerMediaPlayerMediaChanged(Sender: TObject; mrl: string);
    procedure PlayerMediaPlayerPositionChanged(Sender: TObject; position: Single
      );
    procedure PlayerMediaPlayerTimeChanged(Sender: TObject; time: Int64);
    procedure PlayListBoxClick(Sender: TObject);
    procedure PasLibVlcMediaList1NextItemSet(Sender: TObject; mrl: WideString;
      item: Pointer; index: Integer);
    procedure PasLibVlcMediaList1ItemAdded(Sender: TObject; mrl: WideString;
      item: Pointer; index: Integer);
    procedure PasLibVlcMediaList1ItemDeleted(Sender: TObject; mrl: WideString;
      item: Pointer; index: Integer);
    procedure PlayerMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PlayBtnClick(Sender: TObject);
    procedure PlayModeDefaultBtnClick(Sender: TObject);
    procedure PlayModeLoopBtnClick(Sender: TObject);
    procedure PlayModeRepeatBtnClick(Sender: TObject);
    procedure PrevBtnClick(Sender: TObject);
    procedure NextBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  {$IFDEF LCLGTK2}
    Caption := Caption + ' LCL GTK2';
  {$ELSE}
    {$IFDEF LCLQT5}
      Caption := Caption + ' LCL QT5';
    {$ELSE}
      {$IFDEF LCLQT}
        Caption := Caption + ' LCL QT';
      {$ELSE}
        {$IFDEF LCLWIN32}
          Caption := Caption + ' LCL WIN';
        {$ELSE}
          Caption := Caption + ' LCL ???';
        {$ENDIF}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  Caption := Caption + ' x' + {$IFDEF CPUX32}'32'{$ELSE}'64'{$ENDIF};

  PasLibVlcMediaList1.Add('https://www.youtube.com/watch?v=8JnfIa84TnU');
  //
  PasLibVlcMediaList1.Add('..'+PathDelim+'..'+PathDelim+'_testFiles'+PathDelim+'Maximize.mp4');
  PasLibVlcMediaList1.Add('..'+PathDelim+'..'+PathDelim+'_testFiles'+PathDelim+'test.ts');
  PasLibVlcMediaList1.Add('http://www.miastomuzyki.pl/odbior/rmf_aacp.pls');
  PasLibVlcMediaList1.Add('http://www.radio-canada.ca/util/endirect/premiere.asx');
end;

procedure TMainForm.ClearBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.Clear();
end;

procedure TMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  EventsMemo.Lines.Add('From MouseDown at ' + IntToStr(x) + ',' + IntToStr(y));
end;

procedure TMainForm.InfoTrackBarChange(Sender: TObject);
begin
  if Player.CanSeek() then
  begin
    Player.SetVideoPosInMs(InfoTrackBar.Position);
    TimePanel.Caption := time2str(InfoTrackBar.Position) + '/' + time2str(InfoTrackBar.Max);
  end;
end;

procedure TMainForm.PlayListBoxClick(Sender: TObject);
var
  idx: Integer;
  item: TObject;
begin
  if (PlayListBox.ItemIndex < 0) then exit;
  if (PlayListBox.ItemIndex >= PlayListBox.Count) then exit;

  // check for item stil exists in play list
  item := PlayListBox.Items.Objects[PlayListBox.ItemIndex];
  idx := PasLibVlcMediaList1.IndexOfItem(item);

  // if exists then play it
  if (idx > -1) then
  begin
    PasLibVlcMediaList1.PlayItem(item);
  end;
end;

procedure TMainForm.NextBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.Next();
end;

procedure TMainForm.PasLibVlcMediaList1ItemAdded(Sender: TObject;
  mrl: WideString; item: Pointer; index: Integer);
begin
  PlayListBox.Items.AddObject(string(mrl), item);
end;

procedure TMainForm.PasLibVlcMediaList1ItemDeleted(Sender: TObject;
  mrl: WideString; item: Pointer; index: Integer);
begin
  PlayListBox.Items.Delete(index);
end;

procedure TMainForm.PlayerMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  EventsMemo.Lines.Add('Player MouseDown at ' + IntToStr(x) + ',' + IntToStr(y));
end;

procedure TMainForm.PasLibVlcMediaList1MediaListItemAdded(Sender: TObject;
  mrl: WideString; item: Pointer; index: Integer);
begin
  PlayListBox.Items.AddObject(string(mrl), item);
end;

procedure TMainForm.PauseBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.Pause();
  if (PauseBtn.Caption = 'Pause') then PauseBtn.Caption := 'Resume'
  else PauseBtn.Caption := 'Pause';
  InfoTrackBar.OnChange := InfoTrackBarChange;
end;

procedure TMainForm.PlayerMediaPlayerEndReached(Sender: TObject);
begin
  TimePanel.Caption := '';
  InfoTrackBar.Position := 0;
end;

procedure TMainForm.PlayerMediaPlayerLengthChanged(Sender: TObject; time: Int64
  );
begin
  InfoTrackBar.Max := time;
  TimePanel.Caption := time2str(InfoTrackBar.Position) + '/' + time2str(InfoTrackBar.Max);
end;

procedure TMainForm.PlayerMediaPlayerMediaChanged(Sender: TObject; mrl: string);
begin
  Caption := mrl;
end;

procedure TMainForm.PlayerMediaPlayerPositionChanged(Sender: TObject;
  position: Single);
begin
  //InfoTrackBar.Position := Round(MaxInt * position);
end;

procedure TMainForm.PlayerMediaPlayerTimeChanged(Sender: TObject; time: Int64);
begin
  InfoTrackBar.Position := time;
  TimePanel.Caption := time2str(InfoTrackBar.Position) + '/' + time2str(InfoTrackBar.Max);
end;

procedure TMainForm.PasLibVlcMediaList1NextItemSet(Sender: TObject;
  mrl: WideString; item: Pointer; index: Integer);
begin
  if (index < PlayListBox.Count) then
  begin
    PlayListBox.ItemIndex := index;
  end;
  EventsMemo.Lines.Add('Play ' + string(mrl));
end;

procedure TMainForm.PlayBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.Play();
  InfoTrackBar.OnChange := NIL;
  PauseBtn.Caption := 'Pause';
end;

procedure TMainForm.PlayModeDefaultBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.SetPlayModeNormal();
end;

procedure TMainForm.PlayModeLoopBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.SetPlayModeLoop();
end;

procedure TMainForm.PlayModeRepeatBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.SetPlayModeRepeat();
end;

procedure TMainForm.PrevBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.Prev();
end;

procedure TMainForm.StopBtnClick(Sender: TObject);
begin
  PasLibVlcMediaList1.Stop();
end;

end.


