unit uView_Mode_Video_Game;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UITypes,
  FMX.Layouts,
  FMX.StdCtrls,
  FMX.Types,
  FMX.Objects,
  FMX.Graphics,
  FMX.ViewPort3d,
  FMX.Objects3d,
  FMX.MaterialSources,
  FMX.Controls3d,
  FMX.Ani,
  FMX.OBJ.Importer,
  FMX.Types3d,
  FMX.Layers3D,
  Radiant.Shapes,
  ALFMXLayouts;

type
  TGame_Timer_Action = class(TObject)
    procedure OnTimer(Sender: TObject);
  end;

const
  cGame_Menu: array [0 .. 10] of string = ('Play game', 'Read manual', 'Open media folder', 'View images in fullscreen', 'Sound Tracks', '', 'Add to playlist',
    '', '', '', '');

procedure Load;

procedure Splash;

procedure Info_Box;
procedure Manual_Box;
procedure Media_Box;
procedure Fullscreen_Box;
procedure Soundtrack_Box;
procedure Favorite_Box;
procedure Playlist_Box;

procedure Show_Game_State;

procedure Run_State;
procedure Run_Game;
procedure Run_Favorite;

procedure Return;

procedure Refresh;

procedure Menu_Up;
procedure Menu_Down;

var
  vGame_Timer: TTimer;
  vGame_Timer_Action: TGame_Timer_Action;
  vGame_Main: Integer;

implementation

uses
  uDB,
  uDB_AUser,
  uEmu_Commands,
  uLoad_AllTypes,
  uView_Mode_Video_Actions,
  uView_Mode_Video_AllTypes,
  uView_Mode_Video_Mouse;

procedure Load;
var
  vi: Integer;
begin
  extrafe.Prog.State := 'emu_mame_game';
  vGame_Main := Emu_VM_Video_Var.gamelist.Selected;

  Info_Box;
  Manual_Box;
  Media_Box;
  Fullscreen_Box;
  Soundtrack_Box;
  Favorite_Box;
  Playlist_Box;

  Emu_VM_Video_Var.Game_Mode := true;
  Emu_VM_Video_Var.Game.Selected := 0;
  Emu_VM_Video.Media.Bar.Back.Visible := False;
  Emu_VM_Video.Media.Video.Video_Back.Visible := False;
  if Emu_VM_Video.Media.Video.Video.IsPlay then
    Emu_VM_Video.Media.Video.Video.Pause;
  Emu_VM_Video.gamelist.Info.Back.Visible := False;
  Emu_VM_Video.gamelist.Filters.Back.Visible := False;
  Emu_VM_Video.gamelist.Search.Back.Visible := False;
  Emu_VM_Video.gamelist.Lists.Back.Visible := False;
  Emu_VM_Video.Settings.TextSettings.FontColor := TAlphaColorRec.Limegreen;

  Refresh;
  Show_Game_State;
end;

procedure Info_Box;
const
  cGameLabels: array [0 .. 11] of string = ('Game Name', 'Year', 'Manufacturer', 'Game Type', 'Refresh Rate', 'Width', 'Height', 'Sound Channels', 'Savestate',
    'Emulation', 'Overall Status', 'Support Hiscore');
var
  vi: Integer;
  vQuery: String;
  vStr: String;
begin
  Emu_VM_Video.GameMenu.Info.Layout := TLayout.Create(Emu_VM_Video.Media.Video.Back);
  Emu_VM_Video.GameMenu.Info.Layout.Name := 'Emu_Game_Info_Box';
  Emu_VM_Video.GameMenu.Info.Layout.Parent := Emu_VM_Video.Media.Video.Back;
  Emu_VM_Video.GameMenu.Info.Layout.Align := TAlignLayout.Client;
  Emu_VM_Video.GameMenu.Info.Layout.Visible := true;

  Emu_VM_Video.GameMenu.Info.Headline := TText.Create(Emu_VM_Video.GameMenu.Info.Layout);
  Emu_VM_Video.GameMenu.Info.Headline.Name := 'Emu_Game_Info_Headline';
  Emu_VM_Video.GameMenu.Info.Headline.Parent := Emu_VM_Video.GameMenu.Info.Layout;
  Emu_VM_Video.GameMenu.Info.Headline.SetBounds(20, 20, Emu_VM_Video.GameMenu.Info.Layout.Width - 40, 22);
  Emu_VM_Video.GameMenu.Info.Headline.Text := 'General Info';
  Emu_VM_Video.GameMenu.Info.Headline.Font.Family := 'Tahoma';
  Emu_VM_Video.GameMenu.Info.Headline.Font.Size := 20;
  Emu_VM_Video.GameMenu.Info.Headline.TextSettings.HorzAlign := TTextAlign.Center;
  Emu_VM_Video.GameMenu.Info.Headline.Color := TAlphaColorRec.White;
  Emu_VM_Video.GameMenu.Info.Headline.Font.Style := Emu_VM_Video.GameMenu.Info.Headline.Font.Style + [TFontStyle.fsBold];
  Emu_VM_Video.GameMenu.Info.Headline.Visible := true;

  Emu_VM_Video.GameMenu.Info.Line := TRadiantLine.Create(Emu_VM_Video.GameMenu.Info.Layout);
  Emu_VM_Video.GameMenu.Info.Line.Name := 'Emu_Game_Info_Line';
  Emu_VM_Video.GameMenu.Info.Line.Parent := Emu_VM_Video.GameMenu.Info.Layout;
  Emu_VM_Video.GameMenu.Info.Line.SetBounds(20, 50, Emu_VM_Video.GameMenu.Info.Layout.Width - 40, 4);
  Emu_VM_Video.GameMenu.Info.Line.LineSlope := TRadiantLineSlope.Horizontal;
  Emu_VM_Video.GameMenu.Info.Line.Stroke.Thickness := 4;
  Emu_VM_Video.GameMenu.Info.Line.Stroke.Color := TAlphaColorRec.Deepskyblue;
  Emu_VM_Video.GameMenu.Info.Line.Stroke.Cap := TStrokeCap.Round;
  Emu_VM_Video.GameMenu.Info.Line.Fill.Kind := TBrushKind.Solid;
  Emu_VM_Video.GameMenu.Info.Line.Fill.Color := TAlphaColorRec.Deepskyblue;
  Emu_VM_Video.GameMenu.Info.Line.Visible := true;

  Emu_VM_Video.GameMenu.Info.Box := TALVertScrollBox.Create(Emu_VM_Video.GameMenu.Info.Layout);
  Emu_VM_Video.GameMenu.Info.Box.Name := 'Emu_Game_Game_Info_VerticalScrollBox';
  Emu_VM_Video.GameMenu.Info.Box.Parent := Emu_VM_Video.GameMenu.Info.Layout;
  Emu_VM_Video.GameMenu.Info.Box.SetBounds(10, 20, 730, 680);
  Emu_VM_Video.GameMenu.Info.Box.ShowScrollBars := False;
  Emu_VM_Video.GameMenu.Info.Box.Visible := true;

  if Emu_VM_Video_Var.Favorites_Open then
    vQuery := 'SELECT * FROM ' + Emu_XML.Game.Games + ' WHERE ROMNAME="' + Emu_VM_Video_Var.favorites.Roms[Emu_VM_Video_Var.gamelist.Selected] + '"'
  else
    vQuery := 'SELECT * FROM ' + Emu_XML.Game.Games + ' WHERE ROMNAME="' + Emu_VM_Video_Var.gamelist.Roms[Emu_VM_Video_Var.gamelist.Selected] + '"';
  uDB.Arcade_Query.Close;
  uDB.Arcade_Query.SQL.Clear;
  uDB.Arcade_Query.SQL.Add(vQuery);
  uDB.Arcade_Query.Open;
  uDB.Arcade_Query.First;

  for vi := 0 to 11 do
  begin
    Emu_VM_Video.GameMenu.Info.Text_Caption[vi] := TText.Create(Emu_VM_Video.GameMenu.Info.Box);
    Emu_VM_Video.GameMenu.Info.Text_Caption[vi].Name := 'Emu_Game_Info_Text_Caption_' + vi.ToString;
    Emu_VM_Video.GameMenu.Info.Text_Caption[vi].Parent := Emu_VM_Video.GameMenu.Info.Box;
    if vi = 0 then
    begin
      Emu_VM_Video.GameMenu.Info.Text_Caption[vi].SetBounds(20, 60 + (40 * vi), 300, 100);
      Emu_VM_Video.GameMenu.Info.Text_Caption[vi].VertTextAlign := TTextAlign.Center;
    end
    else
      Emu_VM_Video.GameMenu.Info.Text_Caption[vi].SetBounds(20, 140 + (40 * vi), 300, 24);
    Emu_VM_Video.GameMenu.Info.Text_Caption[vi].Font.Size := 20;
    Emu_VM_Video.GameMenu.Info.Text_Caption[vi].Color := TAlphaColorRec.Deepskyblue;
    Emu_VM_Video.GameMenu.Info.Text_Caption[vi].Font.Style := Emu_VM_Video.GameMenu.Info.Text_Caption[vi].Font.Style + [TFontStyle.fsBold];
    Emu_VM_Video.GameMenu.Info.Text_Caption[vi].Font.Family := 'Tahoma';
    Emu_VM_Video.GameMenu.Info.Text_Caption[vi].TextSettings.HorzAlign := TTextAlign.Leading;
    Emu_VM_Video.GameMenu.Info.Text_Caption[vi].WordWrap := true;
    Emu_VM_Video.GameMenu.Info.Text_Caption[vi].Text := cGameLabels[vi] + ' : ';
    Emu_VM_Video.GameMenu.Info.Text_Caption[vi].Visible := true;

    Emu_VM_Video.GameMenu.Info.Text[vi] := TText.Create(Emu_VM_Video.GameMenu.Info.Box);
    Emu_VM_Video.GameMenu.Info.Text[vi].Name := 'Emu_Game_Info_Text_' + vi.ToString;
    Emu_VM_Video.GameMenu.Info.Text[vi].Parent := Emu_VM_Video.GameMenu.Info.Box;
    if vi = 0 then
    begin
      Emu_VM_Video.GameMenu.Info.Text[vi].SetBounds(320, 60 + (40 * vi), Emu_VM_Video.GameMenu.Info.Box.Width - 330, 100);
      Emu_VM_Video.GameMenu.Info.Text[vi].VertTextAlign := TTextAlign.Center;
    end
    else
      Emu_VM_Video.GameMenu.Info.Text[vi].SetBounds(320, 140 + (40 * vi), Emu_VM_Video.GameMenu.Info.Box.Width - 330, 24);
    Emu_VM_Video.GameMenu.Info.Text[vi].Font.Size := 20;
    Emu_VM_Video.GameMenu.Info.Text[vi].Color := TAlphaColorRec.White;
    Emu_VM_Video.GameMenu.Info.Text[vi].Font.Style := Emu_VM_Video.GameMenu.Info.Text_Caption[vi].Font.Style + [TFontStyle.fsBold];
    Emu_VM_Video.GameMenu.Info.Text[vi].Font.Family := 'Tahoma';
    Emu_VM_Video.GameMenu.Info.Text[vi].TextSettings.HorzAlign := TTextAlign.Leading;
    Emu_VM_Video.GameMenu.Info.Text[vi].WordWrap := true;
    case vi of
      0:
        Emu_VM_Video.GameMenu.Info.Text[vi].Text := uDB.Arcade_Query.FieldByName('gamename').AsString;
      1:
        Emu_VM_Video.GameMenu.Info.Text[vi].Text := uDB.Arcade_Query.FieldByName('year').AsString;
      2:
        Emu_VM_Video.GameMenu.Info.Text[vi].Text := uDB.Arcade_Query.FieldByName('manufacturer').AsString;
      3:
        Emu_VM_Video.GameMenu.Info.Text[vi].Text := uDB.Arcade_Query.FieldByName('displaytype').AsString;
      4:
        Emu_VM_Video.GameMenu.Info.Text[vi].Text := uDB.Arcade_Query.FieldByName('refreshrate').AsString;
      5:
        Emu_VM_Video.GameMenu.Info.Text[vi].Text := uDB.Arcade_Query.FieldByName('width').AsString;
      6:
        Emu_VM_Video.GameMenu.Info.Text[vi].Text := uDB.Arcade_Query.FieldByName('height').AsString;
      7:
        Emu_VM_Video.GameMenu.Info.Text[vi].Text := uDB.Arcade_Query.FieldByName('channels').AsString;
      8:
        Emu_VM_Video.GameMenu.Info.Text[vi].Text := uDB.Arcade_Query.FieldByName('savestate').AsString;
      9:
        Emu_VM_Video.GameMenu.Info.Text[vi].Text := uDB.Arcade_Query.FieldByName('emulation').AsString;
      10:
        Emu_VM_Video.GameMenu.Info.Text[vi].Text := uDB.Arcade_Query.FieldByName('status').AsString;
      11:
        begin
          vStr := uDB.Arcade_Query.FieldByName('hiscore').AsString;
          if vStr = '0' then
            Emu_VM_Video.GameMenu.Info.Text[vi].Text := 'No'
          else
            Emu_VM_Video.GameMenu.Info.Text[vi].Text := 'Yes';
        end;
    end;
    Emu_VM_Video.GameMenu.Info.Text[vi].Visible := true;
  end;
end;

procedure Manual_Box;
begin
  Emu_VM_Video.GameMenu.Manual.Layout := TLayout.Create(Emu_VM_Video.Media.Video.Back);
  Emu_VM_Video.GameMenu.Manual.Layout.Name := 'Emu_Game_Manual_Box';
  Emu_VM_Video.GameMenu.Manual.Layout.Parent := Emu_VM_Video.Media.Video.Back;
  Emu_VM_Video.GameMenu.Manual.Layout.Align := TAlignLayout.Client;
  Emu_VM_Video.GameMenu.Manual.Layout.Visible := true;

  Emu_VM_Video.GameMenu.Manual.Headline := TText.Create(Emu_VM_Video.GameMenu.Manual.Layout);
  Emu_VM_Video.GameMenu.Manual.Headline.Name := 'Emu_Game_Manual_Headline';
  Emu_VM_Video.GameMenu.Manual.Headline.Parent := Emu_VM_Video.GameMenu.Manual.Layout;
  Emu_VM_Video.GameMenu.Manual.Headline.SetBounds(20, 20, Emu_VM_Video.GameMenu.Manual.Layout.Width - 40, 22);
  Emu_VM_Video.GameMenu.Manual.Headline.Text := 'Game Manual';
  Emu_VM_Video.GameMenu.Manual.Headline.Font.Family := 'Tahoma';
  Emu_VM_Video.GameMenu.Manual.Headline.Font.Size := 20;
  Emu_VM_Video.GameMenu.Manual.Headline.TextSettings.HorzAlign := TTextAlign.Center;
  Emu_VM_Video.GameMenu.Manual.Headline.Color := TAlphaColorRec.White;
  Emu_VM_Video.GameMenu.Manual.Headline.Font.Style := Emu_VM_Video.GameMenu.Manual.Headline.Font.Style + [TFontStyle.fsBold];
  Emu_VM_Video.GameMenu.Manual.Headline.Visible := true;

  Emu_VM_Video.GameMenu.Manual.Line := TRadiantLine.Create(Emu_VM_Video.GameMenu.Manual.Layout);
  Emu_VM_Video.GameMenu.Manual.Line.Name := 'Emu_Game_Manual_Line';
  Emu_VM_Video.GameMenu.Manual.Line.Parent := Emu_VM_Video.GameMenu.Manual.Layout;
  Emu_VM_Video.GameMenu.Manual.Line.SetBounds(20, 50, Emu_VM_Video.GameMenu.Manual.Layout.Width - 40, 4);
  Emu_VM_Video.GameMenu.Manual.Line.LineSlope := TRadiantLineSlope.Horizontal;
  Emu_VM_Video.GameMenu.Manual.Line.Stroke.Thickness := 4;
  Emu_VM_Video.GameMenu.Manual.Line.Stroke.Color := TAlphaColorRec.Deepskyblue;
  Emu_VM_Video.GameMenu.Manual.Line.Stroke.Cap := TStrokeCap.Round;
  Emu_VM_Video.GameMenu.Manual.Line.Fill.Kind := TBrushKind.Solid;
  Emu_VM_Video.GameMenu.Manual.Line.Fill.Color := TAlphaColorRec.Deepskyblue;
  Emu_VM_Video.GameMenu.Manual.Line.Visible := true;

  Emu_VM_Video.GameMenu.Manual.Box := TALVertScrollBox.Create(Emu_VM_Video.GameMenu.Manual.Layout);
  Emu_VM_Video.GameMenu.Manual.Box.Name := 'Emu_Game_Manual_Info_VerticalScrollBox';
  Emu_VM_Video.GameMenu.Manual.Box.Parent := Emu_VM_Video.GameMenu.Manual.Layout;
  Emu_VM_Video.GameMenu.Manual.Box.SetBounds(10, 20, 730, 680);
  Emu_VM_Video.GameMenu.Manual.Box.ShowScrollBars := False;
  Emu_VM_Video.GameMenu.Manual.Box.Visible := true;
end;

procedure Media_Box;
begin
  Emu_VM_Video.GameMenu.Media.Layout := TLayout.Create(Emu_VM_Video.Media.Video.Back);
  Emu_VM_Video.GameMenu.Media.Layout.Name := 'Emu_Game_Media_Box';
  Emu_VM_Video.GameMenu.Media.Layout.Parent := Emu_VM_Video.Media.Video.Back;
  Emu_VM_Video.GameMenu.Media.Layout.Align := TAlignLayout.Client;
  Emu_VM_Video.GameMenu.Media.Layout.Visible := true;

  Emu_VM_Video.GameMenu.Media.Headline := TText.Create(Emu_VM_Video.GameMenu.Media.Layout);
  Emu_VM_Video.GameMenu.Media.Headline.Name := 'Emu_Game_Media_Headline';
  Emu_VM_Video.GameMenu.Media.Headline.Parent := Emu_VM_Video.GameMenu.Media.Layout;
  Emu_VM_Video.GameMenu.Media.Headline.SetBounds(20, 20, Emu_VM_Video.GameMenu.Media.Layout.Width - 40, 22);
  Emu_VM_Video.GameMenu.Media.Headline.Text := 'Media Folders';
  Emu_VM_Video.GameMenu.Media.Headline.Font.Family := 'Tahoma';
  Emu_VM_Video.GameMenu.Media.Headline.Font.Size := 20;
  Emu_VM_Video.GameMenu.Media.Headline.TextSettings.HorzAlign := TTextAlign.Center;
  Emu_VM_Video.GameMenu.Media.Headline.Color := TAlphaColorRec.White;
  Emu_VM_Video.GameMenu.Media.Headline.Font.Style := Emu_VM_Video.GameMenu.Media.Headline.Font.Style + [TFontStyle.fsBold];
  Emu_VM_Video.GameMenu.Media.Headline.Visible := true;

  Emu_VM_Video.GameMenu.Media.Line := TRadiantLine.Create(Emu_VM_Video.GameMenu.Media.Layout);
  Emu_VM_Video.GameMenu.Media.Line.Name := 'Emu_Game_Media_Line';
  Emu_VM_Video.GameMenu.Media.Line.Parent := Emu_VM_Video.GameMenu.Media.Layout;
  Emu_VM_Video.GameMenu.Media.Line.SetBounds(20, 50, Emu_VM_Video.GameMenu.Media.Layout.Width - 40, 4);
  Emu_VM_Video.GameMenu.Media.Line.LineSlope := TRadiantLineSlope.Horizontal;
  Emu_VM_Video.GameMenu.Media.Line.Stroke.Thickness := 4;
  Emu_VM_Video.GameMenu.Media.Line.Stroke.Color := TAlphaColorRec.Deepskyblue;
  Emu_VM_Video.GameMenu.Media.Line.Stroke.Cap := TStrokeCap.Round;
  Emu_VM_Video.GameMenu.Media.Line.Fill.Kind := TBrushKind.Solid;
  Emu_VM_Video.GameMenu.Media.Line.Fill.Color := TAlphaColorRec.Deepskyblue;
  Emu_VM_Video.GameMenu.Media.Line.Visible := true;

  Emu_VM_Video.GameMenu.Media.Box := TALVertScrollBox.Create(Emu_VM_Video.GameMenu.Media.Layout);
  Emu_VM_Video.GameMenu.Media.Box.Name := 'Emu_Game_Media_Info_VerticalScrollBox';
  Emu_VM_Video.GameMenu.Media.Box.Parent := Emu_VM_Video.GameMenu.Media.Layout;
  Emu_VM_Video.GameMenu.Media.Box.SetBounds(10, 20, 730, 680);
  Emu_VM_Video.GameMenu.Media.Box.ShowScrollBars := False;
  Emu_VM_Video.GameMenu.Media.Box.Visible := true;
end;

procedure Fullscreen_Box;
begin
  Emu_VM_Video.GameMenu.Fullscreen.Layout := TLayout.Create(Emu_VM_Video.Media.Video.Back);
  Emu_VM_Video.GameMenu.Fullscreen.Layout.Name := 'Emu_Game_Fullscreen_Box';
  Emu_VM_Video.GameMenu.Fullscreen.Layout.Parent := Emu_VM_Video.Media.Video.Back;
  Emu_VM_Video.GameMenu.Fullscreen.Layout.Align := TAlignLayout.Client;
  Emu_VM_Video.GameMenu.Fullscreen.Layout.Visible := true;

  Emu_VM_Video.GameMenu.Fullscreen.Headline := TText.Create(Emu_VM_Video.GameMenu.Fullscreen.Layout);
  Emu_VM_Video.GameMenu.Fullscreen.Headline.Name := 'Emu_Game_Fullscreen_Headline';
  Emu_VM_Video.GameMenu.Fullscreen.Headline.Parent := Emu_VM_Video.GameMenu.Fullscreen.Layout;
  Emu_VM_Video.GameMenu.Fullscreen.Headline.SetBounds(20, 20, Emu_VM_Video.GameMenu.Fullscreen.Layout.Width - 40, 22);
  Emu_VM_Video.GameMenu.Fullscreen.Headline.Text := 'Images Categories';
  Emu_VM_Video.GameMenu.Fullscreen.Headline.Font.Family := 'Tahoma';
  Emu_VM_Video.GameMenu.Fullscreen.Headline.Font.Size := 20;
  Emu_VM_Video.GameMenu.Fullscreen.Headline.TextSettings.HorzAlign := TTextAlign.Center;
  Emu_VM_Video.GameMenu.Fullscreen.Headline.Color := TAlphaColorRec.White;
  Emu_VM_Video.GameMenu.Fullscreen.Headline.Font.Style := Emu_VM_Video.GameMenu.Fullscreen.Headline.Font.Style + [TFontStyle.fsBold];
  Emu_VM_Video.GameMenu.Fullscreen.Headline.Visible := true;

  Emu_VM_Video.GameMenu.Fullscreen.Line := TRadiantLine.Create(Emu_VM_Video.GameMenu.Fullscreen.Layout);
  Emu_VM_Video.GameMenu.Fullscreen.Line.Name := 'Emu_Game_Fullscreen_Line';
  Emu_VM_Video.GameMenu.Fullscreen.Line.Parent := Emu_VM_Video.GameMenu.Fullscreen.Layout;
  Emu_VM_Video.GameMenu.Fullscreen.Line.SetBounds(20, 50, Emu_VM_Video.GameMenu.Fullscreen.Layout.Width - 40, 4);
  Emu_VM_Video.GameMenu.Fullscreen.Line.LineSlope := TRadiantLineSlope.Horizontal;
  Emu_VM_Video.GameMenu.Fullscreen.Line.Stroke.Thickness := 4;
  Emu_VM_Video.GameMenu.Fullscreen.Line.Stroke.Color := TAlphaColorRec.Deepskyblue;
  Emu_VM_Video.GameMenu.Fullscreen.Line.Stroke.Cap := TStrokeCap.Round;
  Emu_VM_Video.GameMenu.Fullscreen.Line.Fill.Kind := TBrushKind.Solid;
  Emu_VM_Video.GameMenu.Fullscreen.Line.Fill.Color := TAlphaColorRec.Deepskyblue;
  Emu_VM_Video.GameMenu.Fullscreen.Line.Visible := true;

  Emu_VM_Video.GameMenu.Fullscreen.Box := TALVertScrollBox.Create(Emu_VM_Video.GameMenu.Fullscreen.Layout);
  Emu_VM_Video.GameMenu.Fullscreen.Box.Name := 'Emu_Game_Fullscreen_Info_VerticalScrollBox';
  Emu_VM_Video.GameMenu.Fullscreen.Box.Parent := Emu_VM_Video.GameMenu.Fullscreen.Layout;
  Emu_VM_Video.GameMenu.Fullscreen.Box.SetBounds(10, 20, 730, 680);
  Emu_VM_Video.GameMenu.Fullscreen.Box.ShowScrollBars := False;
  Emu_VM_Video.GameMenu.Fullscreen.Box.Visible := true;
end;

procedure Soundtrack_Box;
begin
  Emu_VM_Video.GameMenu.Soundtrack.Layout := TLayout.Create(Emu_VM_Video.Media.Video.Back);
  Emu_VM_Video.GameMenu.Soundtrack.Layout.Name := 'Emu_Game_Soundtrack_Box';
  Emu_VM_Video.GameMenu.Soundtrack.Layout.Parent := Emu_VM_Video.Media.Video.Back;
  Emu_VM_Video.GameMenu.Soundtrack.Layout.Align := TAlignLayout.Client;
  Emu_VM_Video.GameMenu.Soundtrack.Layout.Visible := true;

  Emu_VM_Video.GameMenu.Soundtrack.Headline := TText.Create(Emu_VM_Video.GameMenu.Soundtrack.Layout);
  Emu_VM_Video.GameMenu.Soundtrack.Headline.Name := 'Emu_Game_Soundtrack_Headline';
  Emu_VM_Video.GameMenu.Soundtrack.Headline.Parent := Emu_VM_Video.GameMenu.Soundtrack.Layout;
  Emu_VM_Video.GameMenu.Soundtrack.Headline.SetBounds(20, 20, Emu_VM_Video.GameMenu.Soundtrack.Layout.Width - 40, 22);
  Emu_VM_Video.GameMenu.Soundtrack.Headline.Text := 'Game Soundtracks';
  Emu_VM_Video.GameMenu.Soundtrack.Headline.Font.Family := 'Tahoma';
  Emu_VM_Video.GameMenu.Soundtrack.Headline.Font.Size := 20;
  Emu_VM_Video.GameMenu.Soundtrack.Headline.TextSettings.HorzAlign := TTextAlign.Center;
  Emu_VM_Video.GameMenu.Soundtrack.Headline.Color := TAlphaColorRec.White;
  Emu_VM_Video.GameMenu.Soundtrack.Headline.Font.Style := Emu_VM_Video.GameMenu.Soundtrack.Headline.Font.Style + [TFontStyle.fsBold];
  Emu_VM_Video.GameMenu.Soundtrack.Headline.Visible := true;

  Emu_VM_Video.GameMenu.Soundtrack.Line := TRadiantLine.Create(Emu_VM_Video.GameMenu.Soundtrack.Layout);
  Emu_VM_Video.GameMenu.Soundtrack.Line.Name := 'Emu_Game_Soundtrack_Line';
  Emu_VM_Video.GameMenu.Soundtrack.Line.Parent := Emu_VM_Video.GameMenu.Soundtrack.Layout;
  Emu_VM_Video.GameMenu.Soundtrack.Line.SetBounds(20, 50, Emu_VM_Video.GameMenu.Soundtrack.Layout.Width - 40, 4);
  Emu_VM_Video.GameMenu.Soundtrack.Line.LineSlope := TRadiantLineSlope.Horizontal;
  Emu_VM_Video.GameMenu.Soundtrack.Line.Stroke.Thickness := 4;
  Emu_VM_Video.GameMenu.Soundtrack.Line.Stroke.Color := TAlphaColorRec.Deepskyblue;
  Emu_VM_Video.GameMenu.Soundtrack.Line.Stroke.Cap := TStrokeCap.Round;
  Emu_VM_Video.GameMenu.Soundtrack.Line.Fill.Kind := TBrushKind.Solid;
  Emu_VM_Video.GameMenu.Soundtrack.Line.Fill.Color := TAlphaColorRec.Deepskyblue;
  Emu_VM_Video.GameMenu.Soundtrack.Line.Visible := true;

  Emu_VM_Video.GameMenu.Soundtrack.Box := TALVertScrollBox.Create(Emu_VM_Video.GameMenu.Soundtrack.Layout);
  Emu_VM_Video.GameMenu.Soundtrack.Box.Name := 'Emu_Game_Soundtrack_Info_VerticalScrollBox';
  Emu_VM_Video.GameMenu.Soundtrack.Box.Parent := Emu_VM_Video.GameMenu.Soundtrack.Layout;
  Emu_VM_Video.GameMenu.Soundtrack.Box.SetBounds(10, 20, 730, 680);
  Emu_VM_Video.GameMenu.Soundtrack.Box.ShowScrollBars := False;
  Emu_VM_Video.GameMenu.Soundtrack.Box.Visible := true;
end;

procedure Favorite_Box;
begin
  Emu_VM_Video.GameMenu.Favorite.Layout := TLayout.Create(Emu_VM_Video.Media.Video.Back);
  Emu_VM_Video.GameMenu.Favorite.Layout.Name := 'Emu_Game_Favorite_Box';
  Emu_VM_Video.GameMenu.Favorite.Layout.Parent := Emu_VM_Video.Media.Video.Back;
  Emu_VM_Video.GameMenu.Favorite.Layout.Align := TAlignLayout.Client;
  Emu_VM_Video.GameMenu.Favorite.Layout.Visible := true;

  Emu_VM_Video.GameMenu.Favorite.Headline := TText.Create(Emu_VM_Video.GameMenu.Favorite.Layout);
  Emu_VM_Video.GameMenu.Favorite.Headline.Name := 'Emu_Game_Favorite_Headline';
  Emu_VM_Video.GameMenu.Favorite.Headline.Parent := Emu_VM_Video.GameMenu.Favorite.Layout;
  Emu_VM_Video.GameMenu.Favorite.Headline.SetBounds(20, 20, Emu_VM_Video.GameMenu.Favorite.Layout.Width - 40, 22);
  Emu_VM_Video.GameMenu.Favorite.Headline.Text := 'Favorite';
  Emu_VM_Video.GameMenu.Favorite.Headline.Font.Family := 'Tahoma';
  Emu_VM_Video.GameMenu.Favorite.Headline.Font.Size := 20;
  Emu_VM_Video.GameMenu.Favorite.Headline.TextSettings.HorzAlign := TTextAlign.Center;
  Emu_VM_Video.GameMenu.Favorite.Headline.Color := TAlphaColorRec.White;
  Emu_VM_Video.GameMenu.Favorite.Headline.Font.Style := Emu_VM_Video.GameMenu.Favorite.Headline.Font.Style + [TFontStyle.fsBold];
  Emu_VM_Video.GameMenu.Favorite.Headline.Visible := true;

  Emu_VM_Video.GameMenu.Favorite.Line := TRadiantLine.Create(Emu_VM_Video.GameMenu.Favorite.Layout);
  Emu_VM_Video.GameMenu.Favorite.Line.Name := 'Emu_Game_Favorite_Line';
  Emu_VM_Video.GameMenu.Favorite.Line.Parent := Emu_VM_Video.GameMenu.Favorite.Layout;
  Emu_VM_Video.GameMenu.Favorite.Line.SetBounds(20, 50, Emu_VM_Video.GameMenu.Favorite.Layout.Width - 40, 4);
  Emu_VM_Video.GameMenu.Favorite.Line.LineSlope := TRadiantLineSlope.Horizontal;
  Emu_VM_Video.GameMenu.Favorite.Line.Stroke.Thickness := 4;
  Emu_VM_Video.GameMenu.Favorite.Line.Stroke.Color := TAlphaColorRec.Deepskyblue;
  Emu_VM_Video.GameMenu.Favorite.Line.Stroke.Cap := TStrokeCap.Round;
  Emu_VM_Video.GameMenu.Favorite.Line.Fill.Kind := TBrushKind.Solid;
  Emu_VM_Video.GameMenu.Favorite.Line.Fill.Color := TAlphaColorRec.Deepskyblue;
  Emu_VM_Video.GameMenu.Favorite.Line.Visible := true;

  Emu_VM_Video.GameMenu.Favorite.View := TViewport3D.Create(Emu_VM_Video.GameMenu.Favorite.Layout);
  Emu_VM_Video.GameMenu.Favorite.View.Name := 'Emu_Game_Favorite_3D_Viewport';
  Emu_VM_Video.GameMenu.Favorite.View.Parent := Emu_VM_Video.GameMenu.Favorite.Layout;
  Emu_VM_Video.GameMenu.Favorite.View.SetBounds(20, 65, 710, Emu_VM_Video.Media.Video.Back.Height - 95);
  Emu_VM_Video.GameMenu.Favorite.View.Color := TAlphaColorRec.Black;
  Emu_VM_Video.GameMenu.Favorite.View.Opacity := 0.5;
  Emu_VM_Video.GameMenu.Favorite.View.OnClick := Emu_VM_Video_Mouse.Model3D.OnMouseClick;
  Emu_VM_Video.GameMenu.Favorite.View.OnMouseEnter := Emu_VM_Video_Mouse.Model3D.OnMouseEnter;
  Emu_VM_Video.GameMenu.Favorite.View.OnMouseLeave := Emu_VM_Video_Mouse.Model3D.OnMouseLeave;
  Emu_VM_Video.GameMenu.Favorite.View.Visible := true;

  Emu_VM_Video.GameMenu.Favorite.Light := TLight.Create(Emu_VM_Video.GameMenu.Favorite.View);
  Emu_VM_Video.GameMenu.Favorite.Light.Name := 'Emu_Game_Favorite_3D_Light';
  Emu_VM_Video.GameMenu.Favorite.Light.Parent := Emu_VM_Video.GameMenu.Favorite.View;
  Emu_VM_Video.GameMenu.Favorite.Light.Color := TAlphaColorRec.White;
  Emu_VM_Video.GameMenu.Favorite.Light.Visible := true;

  Emu_VM_Video.GameMenu.Favorite.Heart := TModel3D.Create(Emu_VM_Video.GameMenu.Favorite.View);
  Emu_VM_Video.GameMenu.Favorite.Heart.Name := 'Emu_Game_Favorite_3D_Model';
  Emu_VM_Video.GameMenu.Favorite.Heart.Parent := Emu_VM_Video.GameMenu.Favorite.View;
  Emu_VM_Video.GameMenu.Favorite.Heart.LoadFromFile(Emu_XML.Images_Path + 'fav.obj');
  Emu_VM_Video.GameMenu.Favorite.Heart.RotationAngle.X := 180;
  Emu_VM_Video.GameMenu.Favorite.Heart.Scale.X := 4;
  Emu_VM_Video.GameMenu.Favorite.Heart.Scale.Y := 4;
  Emu_VM_Video.GameMenu.Favorite.Heart.Scale.Z := 4;
  Emu_VM_Video.GameMenu.Favorite.Heart.Visible := true;

  Emu_VM_Video.GameMenu.Favorite.Ani := TFloatAnimation.Create(Emu_VM_Video.GameMenu.Favorite.Heart);
  Emu_VM_Video.GameMenu.Favorite.Ani.Name := 'Emu_Game_Favorite_3D_Animation';
  Emu_VM_Video.GameMenu.Favorite.Ani.Parent := Emu_VM_Video.GameMenu.Favorite.Heart;
  Emu_VM_Video.GameMenu.Favorite.Ani.Duration := 2;
  Emu_VM_Video.GameMenu.Favorite.Ani.PropertyName := 'RotationAngle.Y';
  Emu_VM_Video.GameMenu.Favorite.Ani.StartValue := 0;
  Emu_VM_Video.GameMenu.Favorite.Ani.StopValue := 360;
  Emu_VM_Video.GameMenu.Favorite.Ani.Loop := true;
  Emu_VM_Video.GameMenu.Favorite.Ani.Enabled := False;

  Emu_VM_Video.GameMenu.Favorite.Ani_Selected := TFloatAnimation.Create(Emu_VM_Video.GameMenu.Favorite.Heart);
  Emu_VM_Video.GameMenu.Favorite.Ani_Selected.Name := 'Emu_Game_Favorite_3D_Selected_Animation';
  Emu_VM_Video.GameMenu.Favorite.Ani_Selected.Parent := Emu_VM_Video.GameMenu.Favorite.Heart;
  Emu_VM_Video.GameMenu.Favorite.Ani_Selected.Duration := 0.2;
  Emu_VM_Video.GameMenu.Favorite.Ani_Selected.PropertyName := 'RotationAngle.Y';
  Emu_VM_Video.GameMenu.Favorite.Ani_Selected.StartValue := 0;
  Emu_VM_Video.GameMenu.Favorite.Ani_Selected.StopValue := 360;
  Emu_VM_Video.GameMenu.Favorite.Ani_Selected.OnFinish := uView_Mode_Video_AllTypes.vAll_ANI.OnFinish;
  Emu_VM_Video.GameMenu.Favorite.Ani_Selected.Enabled := False;

  Emu_VM_Video.GameMenu.Favorite.Material_Source := TColorMaterialSource.Create(Emu_VM_Video.GameMenu.Favorite.View);
  Emu_VM_Video.GameMenu.Favorite.Material_Source.Name := 'Emu_Game_Favorite_3D_MaterialSource';
  Emu_VM_Video.GameMenu.Favorite.Material_Source.Parent := Emu_VM_Video.GameMenu.Favorite.View;
  Emu_VM_Video.GameMenu.Favorite.Material_Source.Color := TAlphaColorRec.Grey;

  if Emu_VM_Video_Var.favorites.game_is = False then
    Emu_VM_Video.GameMenu.Favorite.Heart.MeshCollection[0].MaterialSource := Emu_VM_Video.GameMenu.Favorite.Material_Source;
end;

procedure Playlist_Box;
begin
  Emu_VM_Video.GameMenu.Playlist.Layout := TLayout.Create(Emu_VM_Video.Media.Video.Back);
  Emu_VM_Video.GameMenu.Playlist.Layout.Name := 'Emu_Game_Playlist_Box';
  Emu_VM_Video.GameMenu.Playlist.Layout.Parent := Emu_VM_Video.Media.Video.Back;
  Emu_VM_Video.GameMenu.Playlist.Layout.Align := TAlignLayout.Client;
  Emu_VM_Video.GameMenu.Playlist.Layout.Visible := true;

  Emu_VM_Video.GameMenu.Playlist.Headline := TText.Create(Emu_VM_Video.GameMenu.Playlist.Layout);
  Emu_VM_Video.GameMenu.Playlist.Headline.Name := 'Emu_Game_Playlist_Headline';
  Emu_VM_Video.GameMenu.Playlist.Headline.Parent := Emu_VM_Video.GameMenu.Playlist.Layout;
  Emu_VM_Video.GameMenu.Playlist.Headline.SetBounds(20, 20, Emu_VM_Video.GameMenu.Playlist.Layout.Width - 40, 22);
  Emu_VM_Video.GameMenu.Playlist.Headline.Text := 'Playlist';
  Emu_VM_Video.GameMenu.Playlist.Headline.Font.Family := 'Tahoma';
  Emu_VM_Video.GameMenu.Playlist.Headline.Font.Size := 20;
  Emu_VM_Video.GameMenu.Playlist.Headline.TextSettings.HorzAlign := TTextAlign.Center;
  Emu_VM_Video.GameMenu.Playlist.Headline.Color := TAlphaColorRec.White;
  Emu_VM_Video.GameMenu.Playlist.Headline.Font.Style := Emu_VM_Video.GameMenu.Playlist.Headline.Font.Style + [TFontStyle.fsBold];
  Emu_VM_Video.GameMenu.Playlist.Headline.Visible := true;

  Emu_VM_Video.GameMenu.Playlist.Line := TRadiantLine.Create(Emu_VM_Video.GameMenu.Playlist.Layout);
  Emu_VM_Video.GameMenu.Playlist.Line.Name := 'Emu_Game_Playlist_Line';
  Emu_VM_Video.GameMenu.Playlist.Line.Parent := Emu_VM_Video.GameMenu.Playlist.Layout;
  Emu_VM_Video.GameMenu.Playlist.Line.SetBounds(20, 50, Emu_VM_Video.GameMenu.Playlist.Layout.Width - 40, 4);
  Emu_VM_Video.GameMenu.Playlist.Line.LineSlope := TRadiantLineSlope.Horizontal;
  Emu_VM_Video.GameMenu.Playlist.Line.Stroke.Thickness := 4;
  Emu_VM_Video.GameMenu.Playlist.Line.Stroke.Color := TAlphaColorRec.Deepskyblue;
  Emu_VM_Video.GameMenu.Playlist.Line.Stroke.Cap := TStrokeCap.Round;
  Emu_VM_Video.GameMenu.Playlist.Line.Fill.Kind := TBrushKind.Solid;
  Emu_VM_Video.GameMenu.Playlist.Line.Fill.Color := TAlphaColorRec.Deepskyblue;
  Emu_VM_Video.GameMenu.Playlist.Line.Visible := true;

  Emu_VM_Video.GameMenu.Playlist.Box := TALVertScrollBox.Create(Emu_VM_Video.GameMenu.Playlist.Layout);
  Emu_VM_Video.GameMenu.Playlist.Box.Name := 'Emu_Game_Playlist_Info_VerticalScrollBox';
  Emu_VM_Video.GameMenu.Playlist.Box.Parent := Emu_VM_Video.GameMenu.Playlist.Layout;
  Emu_VM_Video.GameMenu.Playlist.Box.SetBounds(10, 20, 730, 680);
  Emu_VM_Video.GameMenu.Playlist.Box.ShowScrollBars := False;
  Emu_VM_Video.GameMenu.Playlist.Box.Visible := true;
end;

procedure Return;
begin
  { Remove Game Mode }
  Emu_VM_Video_Var.Game_Mode := False;
  FreeAndNil(Emu_VM_Video.GameMenu.Info.Layout);
  FreeAndNil(Emu_VM_Video.GameMenu.Manual.Layout);
  FreeAndNil(Emu_VM_Video.GameMenu.Media.Layout);
  FreeAndNil(Emu_VM_Video.GameMenu.Fullscreen.Layout);
  FreeAndNil(Emu_VM_Video.GameMenu.Soundtrack.Layout);
  FreeAndNil(Emu_VM_Video.GameMenu.Favorite.Layout);
  FreeAndNil(Emu_VM_Video.GameMenu.Playlist.Layout);
  { Enable All The Disable }
  Emu_VM_Video.Settings.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  Emu_VM_Video.Media.Bar.Back.Visible := true;
  Emu_VM_Video.Media.Video.Video_Back.Visible := true;
  if Emu_VM_Video.Media.Video.Video.IsPause then
    Emu_VM_Video.Media.Video.Video.Resume;
  Emu_VM_Video.gamelist.Info.Back.Visible := true;
  Emu_VM_Video.gamelist.Filters.Back.Visible := true;
  Emu_VM_Video.gamelist.Search.Back.Visible := true;
  Emu_VM_Video.gamelist.Lists.Back.Visible := true;
  { Refresh the list }
  Emu_VM_Video_Var.gamelist.Selected := vGame_Main;
  uView_Mode_Video_Actions.Refresh;
end;

procedure Splash;
begin
  Emu_VM_Video.Left_Blur.Enabled := true;
  Emu_VM_Video.Right_Blur.Enabled := true;
  Emu_VM_Video.gamelist.Games.List.Visible := False;
  Emu_VM_Video.Media.Video.Back.Visible := False;

  Emu_VM_Video.GameMenu.PopUp.Back := TImage.Create(Emu_VM_Video.main);
  Emu_VM_Video.GameMenu.PopUp.Back.Name := 'Emu_Loading_Game';
  Emu_VM_Video.GameMenu.PopUp.Back.Parent := Emu_VM_Video.main;
  Emu_VM_Video.GameMenu.PopUp.Back.SetBounds((extrafe.res.Half_Width - 250), ((extrafe.res.Half_Height - 200) - 150), 500, 500);
  Emu_VM_Video.GameMenu.PopUp.Back.Bitmap.LoadFromFile(Emu_XML.Images_Path + Emu_XML.main.Black_Opacity.image);
  Emu_VM_Video.GameMenu.PopUp.Back.WrapMode := TImageWrapMode.Tile;
  Emu_VM_Video.GameMenu.PopUp.Back.Visible := true;

  Emu_VM_Video.GameMenu.PopUp.Indicator := TAniIndicator.Create(Emu_VM_Video.GameMenu.PopUp.Back);
  Emu_VM_Video.GameMenu.PopUp.Indicator.Name := 'Emu_Loading_Game_Indicator';
  Emu_VM_Video.GameMenu.PopUp.Indicator.Parent := Emu_VM_Video.GameMenu.PopUp.Back;
  Emu_VM_Video.GameMenu.PopUp.Indicator.SetBounds(20, 10, 30, 30);
  Emu_VM_Video.GameMenu.PopUp.Indicator.Enabled := true;
  Emu_VM_Video.GameMenu.PopUp.Indicator.Visible := true;

  Emu_VM_Video.GameMenu.PopUp.Line1 := TText.Create(Emu_VM_Video.GameMenu.PopUp.Back);
  Emu_VM_Video.GameMenu.PopUp.Line1.Name := 'Emu_Loading_Game_Line1';
  Emu_VM_Video.GameMenu.PopUp.Line1.Parent := Emu_VM_Video.GameMenu.PopUp.Back;
  Emu_VM_Video.GameMenu.PopUp.Line1.SetBounds(0, 10, 500, 30);
  Emu_VM_Video.GameMenu.PopUp.Line1.Text := 'Loading Game : ';
  Emu_VM_Video.GameMenu.PopUp.Line1.Font.Family := 'Tahoma';
  Emu_VM_Video.GameMenu.PopUp.Line1.Font.Size := 18;
  Emu_VM_Video.GameMenu.PopUp.Line1.TextSettings.HorzAlign := TTextAlign.Center;
  Emu_VM_Video.GameMenu.PopUp.Line1.Color := TAlphaColorRec.Deepskyblue;
  Emu_VM_Video.GameMenu.PopUp.Line1.Font.Style := Emu_VM_Video.GameMenu.PopUp.Line1.Font.Style + [TFontStyle.fsBold];
  Emu_VM_Video.GameMenu.PopUp.Line1.Visible := true;

  Emu_VM_Video.GameMenu.PopUp.Line2 := TText.Create(Emu_VM_Video.GameMenu.PopUp.Back);
  Emu_VM_Video.GameMenu.PopUp.Line2.Name := 'Emu_Loading_Game_Line2';
  Emu_VM_Video.GameMenu.PopUp.Line2.Parent := Emu_VM_Video.GameMenu.PopUp.Back;
  Emu_VM_Video.GameMenu.PopUp.Line2.SetBounds(0, 30, 500, 50);
  if Emu_VM_Video_Var.Favorites_Open then
    Emu_VM_Video.GameMenu.PopUp.Line2.Text := Emu_VM_Video_Var.favorites.Games[Emu_VM_Video_Var.gamelist.Selected]
  else
    Emu_VM_Video.GameMenu.PopUp.Line2.Text := Emu_VM_Video_Var.gamelist.Games[Emu_VM_Video_Var.gamelist.Selected];
  Emu_VM_Video.GameMenu.PopUp.Line2.Font.Family := 'Tahoma';
  Emu_VM_Video.GameMenu.PopUp.Line2.Font.Size := 18;
  Emu_VM_Video.GameMenu.PopUp.Line2.TextSettings.HorzAlign := TTextAlign.Center;
  Emu_VM_Video.GameMenu.PopUp.Line2.Color := TAlphaColorRec.White;
  Emu_VM_Video.GameMenu.PopUp.Line2.Font.Style := Emu_VM_Video.GameMenu.PopUp.Line2.Font.Style + [TFontStyle.fsBold];
  Emu_VM_Video.GameMenu.PopUp.Line2.WordWrap := true;
  Emu_VM_Video.GameMenu.PopUp.Line2.Visible := true;

  Emu_VM_Video.GameMenu.PopUp.Snap := TImage.Create(Emu_VM_Video.GameMenu.PopUp.Back);
  Emu_VM_Video.GameMenu.PopUp.Snap.Name := 'Emu_Loading_Game_Snap';
  Emu_VM_Video.GameMenu.PopUp.Snap.Parent := Emu_VM_Video.GameMenu.PopUp.Back;
  Emu_VM_Video.GameMenu.PopUp.Snap.SetBounds(60, 80, 380, 380);
  if Emu_VM_Video_Var.Favorites_Open then
    Emu_VM_Video.GameMenu.PopUp.Snap.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Media.Snapshots + Emu_VM_Video_Var.favorites.Roms
      [Emu_VM_Video_Var.gamelist.Selected] + '.png')
  else
    Emu_VM_Video.GameMenu.PopUp.Snap.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Media.Snapshots + Emu_VM_Video_Var.gamelist.Roms
      [Emu_VM_Video_Var.gamelist.Selected] + '.png');
  Emu_VM_Video.GameMenu.PopUp.Snap.WrapMode := TImageWrapMode.Stretch;
  Emu_VM_Video.GameMenu.PopUp.Snap.Visible := true;

  Emu_VM_Video.GameMenu.PopUp.Play := TText.Create(Emu_VM_Video.GameMenu.PopUp.Back);
  Emu_VM_Video.GameMenu.PopUp.Play.Name := 'Emu_Loading_Game_Play';
  Emu_VM_Video.GameMenu.PopUp.Play.Parent := Emu_VM_Video.GameMenu.PopUp.Back;
  Emu_VM_Video.GameMenu.PopUp.Play.SetBounds(10, 460, 150, 30);
  Emu_VM_Video.GameMenu.PopUp.Play.Text := 'Played : ';
  Emu_VM_Video.GameMenu.PopUp.Play.Font.Family := 'Tahoma';
  Emu_VM_Video.GameMenu.PopUp.Play.Font.Size := 18;
  Emu_VM_Video.GameMenu.PopUp.Play.TextSettings.HorzAlign := TTextAlign.Leading;
  Emu_VM_Video.GameMenu.PopUp.Play.Color := TAlphaColorRec.White;
  Emu_VM_Video.GameMenu.PopUp.Play.Font.Style := Emu_VM_Video.GameMenu.PopUp.Play.Font.Style + [TFontStyle.fsBold];
  Emu_VM_Video.GameMenu.PopUp.Play.Visible := true;

  Emu_VM_Video.GameMenu.PopUp.Play_V := TText.Create(Emu_VM_Video.GameMenu.PopUp.Back);
  Emu_VM_Video.GameMenu.PopUp.Play_V.Name := 'Emu_Loading_Game_Play_V';
  Emu_VM_Video.GameMenu.PopUp.Play_V.Parent := Emu_VM_Video.GameMenu.PopUp.Back;
  Emu_VM_Video.GameMenu.PopUp.Play_V.SetBounds(90, 460, 200, 30);
  if Emu_VM_Video_Var.Favorites_Open then
    Emu_VM_Video.GameMenu.PopUp.Play_V.Text := uDB.Query_Select(Emu_VM_Video_Var.Query, 'play_count_id_' + Emu_VM_Video_Var.User_Num.ToString,
      Emu_XML.Game.play_count_refresh_status, 'romname', Emu_VM_Video_Var.favorites.Roms[Emu_VM_Video_Var.gamelist.Selected])
  else
    Emu_VM_Video.GameMenu.PopUp.Play_V.Text := uDB.Query_Select(Emu_VM_Video_Var.Query, 'play_count_id_' + Emu_VM_Video_Var.User_Num.ToString,
      Emu_XML.Game.play_count_refresh_status, 'romname', Emu_VM_Video_Var.gamelist.Roms[Emu_VM_Video_Var.gamelist.Selected]);
  Emu_VM_Video.GameMenu.PopUp.Play_V.Font.Family := 'Tahoma';
  Emu_VM_Video.GameMenu.PopUp.Play_V.Font.Size := 18;
  Emu_VM_Video.GameMenu.PopUp.Play_V.TextSettings.HorzAlign := TTextAlign.Leading;
  Emu_VM_Video.GameMenu.PopUp.Play_V.Color := TAlphaColorRec.Deepskyblue;
  Emu_VM_Video.GameMenu.PopUp.Play_V.Font.Style := Emu_VM_Video.GameMenu.PopUp.Play_V.Font.Style + [TFontStyle.fsBold];
  Emu_VM_Video.GameMenu.PopUp.Play_V.Visible := true;
end;

procedure Show_Game_State;
begin
  Emu_VM_Video.GameMenu.Info.Layout.Visible := False;
  Emu_VM_Video.GameMenu.Manual.Layout.Visible := False;
  Emu_VM_Video.GameMenu.Media.Layout.Visible := False;
  Emu_VM_Video.GameMenu.Fullscreen.Layout.Visible := False;
  Emu_VM_Video.GameMenu.Soundtrack.Layout.Visible := False;
  Emu_VM_Video.GameMenu.Favorite.Layout.Visible := False;
  Emu_VM_Video.GameMenu.Playlist.Layout.Visible := False;

  Emu_VM_Video.GameMenu.Favorite.Ani.Stop;

  case Emu_VM_Video_Var.Game.Selected of
    0:
      Emu_VM_Video.GameMenu.Info.Layout.Visible := true;
    1:
      Emu_VM_Video.GameMenu.Manual.Layout.Visible := true;
    2:
      Emu_VM_Video.GameMenu.Media.Layout.Visible := true;
    3:
      Emu_VM_Video.GameMenu.Fullscreen.Layout.Visible := true;
    4:
      Emu_VM_Video.GameMenu.Soundtrack.Layout.Visible := true;
    5:
      begin
        Emu_VM_Video.GameMenu.Favorite.Layout.Visible := true;
        Emu_VM_Video.GameMenu.Favorite.Ani.Start;
      end;
    6:
      Emu_VM_Video.GameMenu.Playlist.Layout.Visible := true;
  end;
end;

procedure Run_State;
begin
  case Emu_VM_Video_Var.Game.Selected of
    0:
      Run_Game;
    1:
      ;
    2:
      ;
    3:
      ;
    4:
      ;
    5:
      Run_Favorite;
    6:
      ;
  end;
end;

procedure Run_Game;
begin
  Emu_VM_Video_Var.Game_Loading := true;
  Emu_VM_Video.Settings.Visible := False;
  Splash;
  vGame_Timer := TTimer.Create(Emu_VM_Video.main);
  vGame_Timer.Interval := 2500;
  vGame_Timer.OnTimer := vGame_Timer_Action.OnTimer;
  vGame_Timer.Enabled := true;
end;

procedure Run_Favorite;
begin
  if Emu_VM_Video.gamelist.Games.Line[10].Text.Text = 'Add to favorites' then
  begin
    Emu_VM_Video.GameMenu.Favorite.Heart.MeshCollection[0].MaterialSource := nil;
    Emu_VM_Video.gamelist.Games.Line[10].Text.Text := 'Remove from favorites';
  end
  else if Emu_VM_Video.gamelist.Games.Line[10].Text.Text = 'Remove from favorites' then
  begin
    Emu_VM_Video.GameMenu.Favorite.Heart.MeshCollection[0].MaterialSource := Emu_VM_Video.GameMenu.Favorite.Material_Source;
    Emu_VM_Video.gamelist.Games.Line[10].Text.Text := 'Add to favorites';
  end;
  uView_Mode_Video_Actions.Favorites_Add;
  Emu_VM_Video.GameMenu.Favorite.Ani.Stop;
  Emu_VM_Video.GameMenu.Favorite.Ani_Selected.Start;
end;

procedure Refresh;
var
  vi, ri: Integer;
begin
  for vi := 0 to 20 do
  begin
    Emu_VM_Video.gamelist.Games.Line[vi].Text.Text := '';
    Emu_VM_Video.gamelist.Games.Line[vi].Text.Color := TAlphaColorRec.White;
    Emu_VM_Video.gamelist.Games.Line[vi].Icon.Bitmap := nil;
  end;

  ri := 0;
  for vi := 10 - (Emu_VM_Video_Var.Game.Selected) to 20 - (Emu_VM_Video_Var.Game.Selected) do
  begin
    case ri of
      0:
        Emu_VM_Video.gamelist.Games.Line[vi].Icon.Bitmap.LoadFromFile(Emu_XML.Images_Path + Emu_XML.Game.menu.Play.image);
      1:
        ;
      2:
        Emu_VM_Video.gamelist.Games.Line[vi].Icon.Bitmap.LoadFromFile(Emu_XML.Images_Path + Emu_XML.Game.menu.open_folder.image);
      3:
        Emu_VM_Video.gamelist.Games.Line[vi].Icon.Bitmap.LoadFromFile(Emu_XML.Images_Path + Emu_XML.Game.menu.Fullscreen.image);
      4:
        ;
      5:
        begin
          Emu_VM_Video.gamelist.Games.Line[vi].Icon.Bitmap.LoadFromFile(Emu_XML.Images_Path + Emu_XML.Game.menu.Favorite.image);
          if Emu_VM_Video_Var.favorites.game_is then
            Emu_VM_Video.gamelist.Games.Line[vi].Text.Text := 'Remove from favorites'
          else
            Emu_VM_Video.gamelist.Games.Line[vi].Text.Text := 'Add to favorites';
        end;
      6:
        Emu_VM_Video.gamelist.Games.Line[vi].Icon.Bitmap.LoadFromFile(Emu_XML.Images_Path + Emu_XML.Game.menu.List.image);
    end;
    if ri <> 5 then
      Emu_VM_Video.gamelist.Games.Line[vi].Text.Text := cGame_Menu[ri];
    inc(ri, 1);
  end;
  if not FileExists(uDB_AUser.Local.EMULATORS.Arcade_D.Media.Manuals + Emu_VM_Video_Var.gamelist.Roms[Emu_VM_Video_Var.gamelist.Selected] + '.pdf') then
    Emu_VM_Video.gamelist.Games.Line[11 - (Emu_VM_Video_Var.Game.Selected)].Text.Color := TAlphaColorRec.Red;
  if not FileExists(uDB_AUser.Local.EMULATORS.Arcade_D.Media.Soundtracks + Emu_VM_Video_Var.gamelist.Roms[Emu_VM_Video_Var.gamelist.Selected] + '.zip') then
    Emu_VM_Video.gamelist.Games.Line[14 - (Emu_VM_Video_Var.Game.Selected)].Text.Color := TAlphaColorRec.Red;

  { Add fanart and stamps in the future }
  { if FileExists(uDB_AUser.Local.EMULATORS.Arcade_D.Media.Fanart + Emu_VM_Video_Var.Gamelist.Roms[Emu_VM_Video_Var.Gamelist.Selected] + '.png') then
    begin
    // vMame.Scene.Left.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Media.Fanart + mame.Gamelist.ListRoms[mame.Gamelist.Selected] + '.png');
    // vMame.Scene.Right.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Media.Fanart + mame.Gamelist.ListRoms[mame.Gamelist.Selected] + '.png');
    // vMame.Scene.Right.BitmapMargins.Left := -960;
    end;

    if FileExists(uDB_AUser.Local.EMULATORS.Arcade_D.Media.Stamps + Emu_VM_Video_Var.Gamelist.Roms[Emu_VM_Video_Var.Gamelist.Selected] + '.png') then
    begin
    // vMame.Scene.GameMenu.Stamp := TImage.Create(vMame.Scene.Media.Back);
    // vMame.Scene.GameMenu.Stamp.Name := 'Mame_Game_Info_Stamp';
    // vMame.Scene.GameMenu.Stamp.Parent := vMame.Scene.Media.Back;
    // vMame.Scene.GameMenu.Stamp.SetBounds((vMame.Scene.Media.Back.Width / 2) - (400 / 2), 30, 400, 150);
    // vMame.Scene.GameMenu.Stamp.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Media.Stamps + mame.Gamelist.ListGames[mame.Gamelist.Selected] + '.png');
    // vMame.Scene.GameMenu.Stamp.WrapMode := TImageWrapMode.Fit;
    // vMame.Scene.GameMenu.Stamp.Visible := True;
    end; }

  Emu_VM_Video.gamelist.Games.Selection.Enabled := False;
  Emu_VM_Video.gamelist.Games.Selection.Enabled := true;
end;

procedure Menu_Up;
begin
  if Emu_VM_Video_Var.Game.Selected > 0 then
  begin
    Dec(Emu_VM_Video_Var.Game.Selected, 1);
    Refresh;
    Show_Game_State;
  end;
end;

procedure Menu_Down;
begin
  if Emu_VM_Video_Var.Game.Selected < 6 then
  begin
    inc(Emu_VM_Video_Var.Game.Selected, 1);
    Refresh;
    Show_Game_State;
  end
end;

{ TGame_Timer_Action }

procedure TGame_Timer_Action.OnTimer(Sender: TObject);
var
  romName: String;
  play_int: Integer;
begin
  if Emu_VM_Video_Var.Favorites_Open then
    romName := Emu_VM_Video_Var.favorites.Roms[Emu_VM_Video_Var.gamelist.Selected]
  else
    romName := Emu_VM_Video_Var.gamelist.Roms[Emu_VM_Video_Var.gamelist.Selected];
  vGame_Timer.Enabled := False;
  uEmu_Commands.Run_Game(Emu_XML.emu.exe, romName, Emu_XML.emu.path, 0);
  play_int := Emu_VM_Video.GameMenu.PopUp.Play_V.Text.ToInteger;
  inc(play_int, 1);

  if Emu_VM_Video_Var.Favorites_Open then
    uDB.Query_Update(uDB.Arcade_Query, Emu_XML.Game.play_count_refresh_status, 'play_count_id_' + uDB_AUser.Local.Num.ToString, play_int.ToString, 'romname',
      Emu_VM_Video_Var.favorites.Roms[Emu_VM_Video_Var.gamelist.Selected])
  else
    uDB.Query_Update(uDB.Arcade_Query, Emu_XML.Game.play_count_refresh_status, 'play_count_id_' + uDB_AUser.Local.Num.ToString, play_int.ToString, 'romname',
      Emu_VM_Video_Var.gamelist.Roms[Emu_VM_Video_Var.gamelist.Selected]);

  FreeAndNil(Emu_VM_Video.GameMenu.PopUp.Back);
  Emu_VM_Video.Left_Blur.Enabled := False;
  Emu_VM_Video.Right_Blur.Enabled := False;
  Emu_VM_Video.gamelist.Games.List.Visible := true;
  Emu_VM_Video.Media.Video.Back.Visible := true;
  Emu_VM_Video.Settings.Visible := true;
  Emu_VM_Video.Settings_Ani.Start;
  FreeAndNil(vGame_Timer);
  Emu_VM_Video_Var.Game_Loading := False;
end;

end.
