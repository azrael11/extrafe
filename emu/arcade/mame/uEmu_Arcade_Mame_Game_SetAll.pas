unit uEmu_Arcade_Mame_Game_SetAll;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UITypes,
  FMX.Objects,
  FMX.Types,
  ALFmxLayouts;

type
  TEMU_ARCADE_MAME_GAME_DATA_FROM_MAME = record
    text: array of TText;
  end;

procedure uEmu_Arcade_Mame_Game_Exit;

procedure uEmu_Arcade_Mame_Game_SetAll_Set;

var
  vMame_Game_Info_Back: TImage;
  vMame_Game_Info_Stamp: TImage;
  vMame_Game_Info_Headline: TText;
  vMame_Game_Info_Vertical_Box: TALVertScrollBox;

  // Data from mame
procedure uEmu_Arcade_Mame_Game_GetDataFromMame;

var
  vMame_Data: TEMU_ARCADE_MAME_GAME_DATA_FROM_MAME;

implementation

uses
  uDatabase,
  uDatabase_ActiveUser,
  uDatabase_SQLCommands,
  uLoad_AllTypes,
  uSnippet_Search,
  uEmu_Arcade_Mame,
  uEmu_Arcade_Mame_SetAll,
  uEmu_Arcade_Mame_Actions,
  uEmu_Arcade_Mame_Gamelist,
  uEmu_Arcade_Mame_AllTypes,
  uEmu_Arcade_Mame_Support_Files,
  uEmu_Arcade_Mame_Game_Actions;

procedure uEmu_Arcade_Mame_Game_SetAll_Set;
var
  vi: Integer;
begin
  for vi := 0 to 20 do
    vMame.Scene.Gamelist.List_Line[vi].text.text := '';

  for vi := 10 to 20 do
  begin
    vMame.Scene.Gamelist.List_Line[vi].text.text := cShowGamePanelMenu[vi - 10];
    if vi = 11 then
    begin
      if not FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Manuals + mame.Gamelist.ListRoms[mame.Gamelist.Selected] + '.pdf') then
        vMame.Scene.Gamelist.List_Line[vi].text.Color := TAlphaColorRec.Red;
    end;
    if vi = 14 then
    begin
      if not FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Soundtracks + mame.Gamelist.ListRoms[mame.Gamelist.Selected] + '.zip') then
        vMame.Scene.Gamelist.List_Line[14].text.Color := TAlphaColorRec.Red;
    end;
  end;
  vMame.Scene.Settings.TextSettings.FontColor := TAlphaColorRec.Lime;
  if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Fanart + mame.Gamelist.ListRoms[mame.Gamelist.Selected] + '.png') then
  begin
    vMame.Scene.Left.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Fanart + mame.Gamelist.ListRoms[mame.Gamelist.Selected] + '.png');
    vMame.Scene.Right.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Fanart + mame.Gamelist.ListRoms[mame.Gamelist.Selected] + '.png');
    vMame.Scene.Right.BitmapMargins.Left := -960;
  end;

  vMame_Game_Info_Back := TImage.Create(vMame.Scene.Right);
  vMame_Game_Info_Back.Name := 'Mame_Game_Info_Background';
  vMame_Game_Info_Back.Parent := vMame.Scene.Right;
  vMame_Game_Info_Back.SetBounds((vMame.Scene.Right.Width / 2) - (750 / 2), 50, 750, 900);
  vMame_Game_Info_Back.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'black_menu.png');
  vMame_Game_Info_Back.WrapMode := TImageWrapMode.Tile;
  vMame_Game_Info_Back.Visible := True;

  if FileExists(user_Active_Local.EMULATORS.Arcade_D.Media.Stamps + mame.Gamelist.ListRoms[mame.Gamelist.Selected] + '.png') then
  begin
    vMame_Game_Info_Stamp := TImage.Create(vMame_Game_Info_Back);
    vMame_Game_Info_Stamp.Name := 'Mame_Game_Info_Stamp';
    vMame_Game_Info_Stamp.Parent := vMame_Game_Info_Back;
    vMame_Game_Info_Stamp.SetBounds((vMame_Game_Info_Back.Width / 2) - (400 / 2), 30, 400, 150);
    vMame_Game_Info_Stamp.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Media.Stamps + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png');
    vMame_Game_Info_Stamp.WrapMode := TImageWrapMode.Fit;
    vMame_Game_Info_Stamp.Visible := True;
  end;

  vMame_Game_Info_Headline := TText.Create(vMame_Game_Info_Back);
  vMame_Game_Info_Headline.Name := 'Mame_Game_Info_Headline';
  vMame_Game_Info_Headline.Parent := vMame_Game_Info_Back;
  vMame_Game_Info_Headline.SetBounds((vMame_Game_Info_Back.Width / 2) - (400 / 2), 190, 400, 22);
  vMame_Game_Info_Headline.text := 'General Info';
  vMame_Game_Info_Headline.Font.Family := 'Tahoma';
  vMame_Game_Info_Headline.Font.Size := 20;
  vMame_Game_Info_Headline.TextSettings.HorzAlign := TTextAlign.Center;
  vMame_Game_Info_Headline.Color := TAlphaColorRec.White;
  vMame_Game_Info_Headline.Font.Style := vMame_Game_Info_Headline.Font.Style + [TFontStyle.fsBold];
  vMame_Game_Info_Headline.Visible := True;

  vMame_Game_Info_Vertical_Box := TALVertScrollBox.Create(vMame_Game_Info_Back);
  vMame_Game_Info_Vertical_Box.Name := 'Mame_Game_Info_VerticalScrollBox';
  vMame_Game_Info_Vertical_Box.Parent := vMame_Game_Info_Back;
  vMame_Game_Info_Vertical_Box.SetBounds(10, 20, 730, 680);
  vMame_Game_Info_Vertical_Box.ShowScrollBars := False;
  vMame_Game_Info_Vertical_Box.Visible := True;

  mame.Game.Menu_Selected := 0;
  vMame.Scene.Snap.SnapInfo.Visible := False;
  vMame.Scene.Snap.Type_Arcade.Visible := False;
  vMame.Scene.Snap.Black_Image.Visible := False;
  vMame.Scene.Snap.Video.Visible := False;
  vMame.Scene.Snap.Image.Visible := False;
  uSnippet_Search.vSearch.Scene.Back.Visible := False;
  vMame.Scene.Gamelist.Filters.Visible := False;
  vMame.Scene.Gamelist.Up_Back_Image.Visible := False;
  vMame.Scene.Gamelist.Down_Back_Image.Visible := False;
  vMame.Scene.Gamelist.Filters_Back_Image.Visible := False;

  // Get data from mame for general info

  uEmu_Arcade_Mame_Game_GetDataFromMame;


end;

procedure uEmu_Arcade_Mame_Game_GetDataFromMame;
const
  cGameLabels: array [0 .. 11] of string = ('Game Name : ', 'Year : ', 'Manufacturer : ', 'Game Type : ', 'Refresh Rate : ', 'Height : ', 'Width : ',
    'Rotation : ', 'Sound Channels : ', 'Savestate : ', 'Emulation : ', 'Overall Status : ');
var
  vData: TStringList;
  vi: Integer;
begin

  vData:= TStringList.Create;

  uDatabase_SQLCommands.vQuery := 'SELECT * FROM GAMES WHERE ROMNAME='+ mame.Gamelist.ListRoms[mame.Gamelist.Selected];
  vMame_Query.Close;
  vMame_Query.SQL.Clear;
  vMame_Query.SQl.Add(uDatabase_SQLCommands.vQuery);
  vMame_Query.Open;
  vMame_Query.First;
  vData.Add(vMame_Query.FieldByName('gamename').AsString);
  vData.Add(vMame_Query.FieldByName('year').AsString);
  vData.Add(vMame_Query.FieldByName('manufacturer').AsString);
  vData.Add(vMame_Query.FieldByName('displaytype').AsString);
  vData.Add(vMame_Query.FieldByName('refreshrate').AsString);
  vData.Add(vMame_Query.FieldByName('height').AsString);
  vData.Add(vMame_Query.FieldByName('width').AsString);
  vData.Add('');
  vData.Add(vMame_Query.FieldByName('channels').AsString);
  vData.Add(vMame_Query.FieldByName('savestate').AsString);
  vData.Add(vMame_Query.FieldByName('emulation').AsString);
  vData.Add(vMame_Query.FieldByName('status').AsString);

  for vi := 0 to vData.Count - 1 do
  begin
    vMame_Data.text[vi] := TText.Create(vMame.Scene.Right);
    vMame_Data.text[vi].Name := 'Mame_Game_Info_Text' + IntToStr(vi);
    vMame_Data.text[vi].Parent := vMame_Game_Info_Back;
    vMame_Data.text[vi].SetBounds(10, 260 + (40 * vi), vMame_Game_Info_Back.Width - 20, 22);
    vMame_Data.text[vi].Font.Size := 20;
    vMame_Data.text[vi].Color := TAlphaColorRec.White;
    vMame_Data.text[vi].Font.Style := vMame_Data.text[vi].Font.Style + [TFontStyle.fsBold];
    vMame_Data.text[vi].Font.Family := 'Tahoma';
    vMame_Data.text[vi].TextSettings.HorzAlign := TTextAlign.Leading;
    vMame_Data.text[vi].WordWrap := True;
    vMame_Data.text[vi].text := cGameLabels[vi] + vData.Strings[vi];
    vMame_Data.text[vi].Visible := True;
  end;
end;

procedure uEmu_Arcade_Mame_Game_Exit;
begin
  if FileExists(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Database + 'game.xml') then
    System.SysUtils.DeleteFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Database + 'game.xml');
  FreeAndNil(vMame_Game_Info_Back);
  extrafe.Prog.State := 'mame';
  vMame.Scene.Settings.Tag := 1;

  vMame.Scene.Snap.SnapInfo.Visible := True;
  vMame.Scene.Snap.Type_Arcade.Visible := True;
  vMame.Scene.Snap.Black_Image.Visible := True;
  vMame.Scene.Snap.Video.Visible := True;
  vMame.Scene.Snap.Image.Visible := True;
  uSnippet_Search.vSearch.Scene.Back.Visible := True;
  vMame.Scene.Gamelist.Filters.Visible := True;
  vMame.Scene.Gamelist.Up_Back_Image.Visible := True;
  vMame.Scene.Gamelist.Down_Back_Image.Visible := True;
  vMame.Scene.Gamelist.Filters_Back_Image.Visible := True;

  uEmu_Arcade_Mame_Gamelist_Refresh;
  vMame.Scene.Left.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'background.png');
  vMame.Scene.Right.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'background.png');
  vMame.Scene.Right.BitmapMargins.Left := -960;
  vMame.Scene.Settings.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;

  uEmu_Arcade_Mame_Actions_ShowData;
end;

end.
