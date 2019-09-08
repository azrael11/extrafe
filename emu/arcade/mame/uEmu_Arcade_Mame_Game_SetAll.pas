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
  uDatabase_ActiveUser,
  uDatabase_SQLCommands,
  uLoad_AllTypes,
  uSnippet_Search,
  uEmu_Arcade_Mame,
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
      if not FileExists(mame.Emu.Media.Manuals + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.pdf')
      then
        vMame.Scene.Gamelist.List_Line[vi].text.Color := TAlphaColorRec.Red;
    end;
    if vi = 14 then
    begin
      if not FileExists(mame.Emu.Media.Soundtracks + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.zip')
      then
        vMame.Scene.Gamelist.List_Line[14].text.Color := TAlphaColorRec.Red;
    end;
  end;
  vMame.Scene.Settings.Bitmap.LoadFromFile(mame.Prog.Images + 'settings_green.png');
  if FileExists(mame.Emu.Media.Fanart + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
  begin
    vMame.Scene.Left.Bitmap.LoadFromFile(mame.Emu.Media.Fanart + mame.Gamelist.List[0, mame.Gamelist.Selected,
      0] + '.png');
    vMame.Scene.Right.Bitmap.LoadFromFile(mame.Emu.Media.Fanart + mame.Gamelist.List[0,
      mame.Gamelist.Selected, 0] + '.png');
    vMame.Scene.Right.BitmapMargins.Left := -960;
  end;

  vMame_Game_Info_Back := TImage.Create(vMame.Scene.Right);
  vMame_Game_Info_Back.Name := 'Mame_Game_Info_Background';
  vMame_Game_Info_Back.Parent := vMame.Scene.Right;
  vMame_Game_Info_Back.Width := 750;
  vMame_Game_Info_Back.Height := 900;
  vMame_Game_Info_Back.Position.X := (vMame.Scene.Right.Width / 2) - (750 / 2);
  vMame_Game_Info_Back.Position.Y := 50;
  vMame_Game_Info_Back.Bitmap.LoadFromFile(mame.Prog.Images + 'black_menu.png');
  vMame_Game_Info_Back.WrapMode := TImageWrapMode.Tile;
  vMame_Game_Info_Back.Visible := True;

  if FileExists(mame.Emu.Media.Stamps + mame.Gamelist.List[0, mame.Gamelist.Selected, 0] + '.png') then
  begin
    vMame_Game_Info_Stamp := TImage.Create(vMame_Game_Info_Back);
    vMame_Game_Info_Stamp.Name := 'Mame_Game_Info_Stamp';
    vMame_Game_Info_Stamp.Parent := vMame_Game_Info_Back;
    vMame_Game_Info_Stamp.Width := 400;
    vMame_Game_Info_Stamp.Height := 150;
    vMame_Game_Info_Stamp.Position.X := (vMame_Game_Info_Back.Width / 2) - (400 / 2);
    vMame_Game_Info_Stamp.Position.Y := 30;
    vMame_Game_Info_Stamp.Bitmap.LoadFromFile(mame.Emu.Media.Stamps + mame.Gamelist.List[0, mame.Gamelist.Selected, 0]+ '.png');
    vMame_Game_Info_Stamp.WrapMode := TImageWrapMode.Fit;
    vMame_Game_Info_Stamp.Visible := True;
  end;

  vMame_Game_Info_Headline := TText.Create(vMame_Game_Info_Back);
  vMame_Game_Info_Headline.Name := 'Mame_Game_Info_Headline';
  vMame_Game_Info_Headline.Parent := vMame_Game_Info_Back;
  vMame_Game_Info_Headline.Width := 400;
  vMame_Game_Info_Headline.Height := 22;
  vMame_Game_Info_Headline.Position.X := (vMame_Game_Info_Back.Width / 2) - (400 / 2);
  vMame_Game_Info_Headline.Position.Y := 190;
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
  vMame_Game_Info_Vertical_Box.ShowScrollBars := False;
  vMame_Game_Info_Vertical_Box.Width := 730;
  vMame_Game_Info_Vertical_Box.Height := 680;
  vMame_Game_Info_Vertical_Box.Position.X := 10;
  vMame_Game_Info_Vertical_Box.Position.Y := 220;
  vMame_Game_Info_Vertical_Box.Visible := True;

  mame.Game.Menu_Selected := 0;
  vMame.Scene.Snap.SnapInfo.Visible := False;
  vMame.Scene.Snap.Type_Arcade.Visible := False;
  vMame.Scene.Snap.Black_Image.Visible := False;
  vMame.Scene.Snap.Video.Visible := False;
  vMame.Scene.Snap.Image.Visible := False;
  uSnippet_Search.vSearch.Scene.Back.Visible:= False;
  vMame.Scene.Gamelist.Filters.Visible := False;
  vMame.Scene.Gamelist.Up_Back_Image.Visible := False;
  vMame.Scene.Gamelist.Down_Back_Image.Visible := False;
  vMame.Scene.Gamelist.Filters_Back_Image.Visible := False;

  // Get data from mame for general info
//  uEmu_Arcade_Mame_Game_GetDataFromMame;

  vMame.Scene.Snap.Video.Stop;

end;

procedure uEmu_Arcade_Mame_Game_GetDataFromMame;
const
  cGameLabels: array [0 .. 11] of string = ('Game Name : ', 'Year : ', 'Manufacturer : ', 'Game Type : ',
    'Refresh Rate : ', 'Height : ', 'Width : ', 'Rotation : ', 'Sound Channels : ', 'Savestate : ',
    'Emulation : ', 'Overall Status : ');
var
  vData: TStringList;
  vi: Integer;
begin
  if Assigned(vData) then
    FreeAndNil(vData);
  if FileExists(mame.Prog.Data_Path + 'game.xml') then
    System.SysUtils.DeleteFile(mame.Prog.Data_Path + 'game.xml');
  vData := uEmu_Arcade_Mame_Support_Files_MAME_Data_Load(mame.Gamelist.List[0, mame.Gamelist.Selected, 0]);
  SetLength(vMame_Data.text, vData.Count);
  for vi := 0 to vData.Count - 1 do
  begin
    vMame_Data.text[vi] := TText.Create(vMame_Game_Info_Back);
    vMame_Data.text[vi].Name := 'Mame_Game_Info_Text' + IntToStr(vi);
    vMame_Data.text[vi].Parent := vMame_Game_Info_Back;
    vMame_Data.text[vi].Width := vMame_Game_Info_Back.Width - 20;
    vMame_Data.text[vi].Height := 22;
    vMame_Data.text[vi].Font.Size := 20;
    vMame_Data.text[vi].Position.X := 10;
    vMame_Data.text[vi].Position.Y := 260 + (40 * vi);
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
  if FileExists(mame.Prog.Data_Path + 'game.xml') then
    System.SysUtils.DeleteFile(mame.Prog.Data_Path + 'game.xml');
  FreeAndNil(vMame_Game_Info_Back);
  extrafe.Prog.State := 'mame';
  vMame.Scene.Settings.Tag := 1;

  vMame.Scene.Snap.SnapInfo.Visible := True;
  vMame.Scene.Snap.Type_Arcade.Visible := True;
  vMame.Scene.Snap.Black_Image.Visible := True;
  vMame.Scene.Snap.Video.Visible := True;
  vMame.Scene.Snap.Image.Visible := True;
//  vMame.Scene.Gamelist.Search.Visible := True;
  vMame.Scene.Gamelist.Filters.Visible := True;
  vMame.Scene.Gamelist.Up_Back_Image.Visible := True;
  vMame.Scene.Gamelist.Down_Back_Image.Visible := True;
  vMame.Scene.Gamelist.Filters_Back_Image.Visible := True;

  uEmu_Arcade_Mame_Gamelist_Refresh;
  vMame.Scene.Left.Bitmap.LoadFromFile(mame.Prog.Images + 'background.png');
  vMame.Scene.Right.Bitmap.LoadFromFile(mame.Prog.Images + 'background.png');
  vMame.Scene.Right.BitmapMargins.Left := -960;
  vMame.Scene.Settings.Bitmap.LoadFromFile(user_Active_Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'settings_blue.png');

  uEmu_Arcade_Mame_Actions_ShowData;
end;

end.
