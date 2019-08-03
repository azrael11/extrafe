unit uWeather_Config_Iconsets;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  System.Math,
  FMX.StdCtrls,
  FMX.Types,
  FMX.Objects,
  FMX.Layouts,
  FMX.Graphics,
  FMX.Effects;

procedure uWeather_Config_Iconsets_Show;
procedure uWeather_Config_Iconsets_Free;

Procedure uWeather_SetAll_Iconsets_CreateMiniPreview(vNum: Integer);

procedure uWeather_Config_Iconsets_Check(vCheck: String);
procedure uWeather_Config_Iconsets_Reload(vSet: String);
procedure uWeather_Config_Iconsets_UseIconSet(vIconSet_Name: String);

procedure uWeather_Config_Iconsets_ShowSet(vIconSet_Name: String);
procedure uWeather_Config_Iconsets_ReturnToPreview;

procedure uWeather_Config_Iconsets_GlowPreview(vPreview: Integer; vGlow: Boolean);

implementation

uses
  uload,
  uLoad_AllTypes,
  main,
  uWeather_Config_Towns,
  uWeather_AllTypes,
  uWeather_SetAll,
  uWeather_Actions,
  uWeather_Providers_Yahoo_Config,
  uWeather_Providers_OpenWeatherMap_Config;

procedure uWeather_Config_Iconsets_Show;
begin
  if addons.weather.Action.Provider <> '' then
  begin
    if addons.weather.Action.Provider = 'yahoo' then
      uWeather_Providers_Yahoo_Config.Create_Iconsets
    else if addons.weather.Action.Provider = 'openweathermap' then
      uWeather_Providers_OpenWeatherMap_Config.Create_Iconsets;
  end;
end;

procedure uWeather_Config_Iconsets_Free;
begin
  FreeAndNil(vWeather.Config.main.Right.Panels[3]);
end;

procedure uWeather_Config_Iconsets_Check(vCheck: String);
var
  vi: Integer;
begin
//  for vi := 0 to addons.weather.Config.Iconset.Count - 1 do
//    vWeather.Config.main.Right.Iconsets.Mini[vi].Image[0].Bitmap := nil;
//
//  vi := addons.weather.Config.Iconset.Names.IndexOf(vCheck);
//
//  vWeather.Config.main.Right.Iconsets.Mini[vi].Image[0].Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_check.png');
end;

procedure uWeather_Config_Iconsets_Reload(vSet: String);
var
  vSetPath: String;
  vi: Integer;
begin
  // vSetPath := addons.weather.Path.Iconsets + vSet + '\';
  //
  // for vi := 0 to addons.weather.Action.Active_Total do
  // begin
  // vWeather.Scene.Tab[vi].General.Image.Bitmap.LoadFromFile(vSetPath + 'w_w_' + addons.weather.Action.Choosen
  // [vi].Code + '.png');
  // vWeather.Scene.Tab[vi].Forcast.Current.Image.Bitmap.LoadFromFile
  // (vSetPath + 'w_w_' + addons.weather.Action.Choosen[vi].Current.Code + '.png');
  // vWeather.Scene.Tab[vi].Forcast.Day_1.Image.Bitmap.LoadFromFile
  // (vSetPath + 'w_w_' + addons.weather.Action.Choosen[vi].Day_1.Code + '.png');
  // vWeather.Scene.Tab[vi].Forcast.Day_2.Image.Bitmap.LoadFromFile
  // (vSetPath + 'w_w_' + addons.weather.Action.Choosen[vi].Day_2.Code + '.png');
  // vWeather.Scene.Tab[vi].Forcast.Day_3.Image.Bitmap.LoadFromFile
  // (vSetPath + 'w_w_' + addons.weather.Action.Choosen[vi].Day_3.Code + '.png');
  // vWeather.Scene.Tab[vi].Forcast.Day_4.Image.Bitmap.LoadFromFile
  // (vSetPath + 'w_w_' + addons.weather.Action.Choosen[vi].Day_4.Code + '.png');
  // vWeather.Scene.Tab[vi].Forcast.Day_5.Image.Bitmap.LoadFromFile
  // (vSetPath + 'w_w_' + addons.weather.Action.Choosen[vi].Day_5.Code + '.png');
  // vWeather.Scene.Tab[vi].Forcast.Day_6.Image.Bitmap.LoadFromFile
  // (vSetPath + 'w_w_' + addons.weather.Action.Choosen[vi].Day_6.Code + '.png');
  // vWeather.Scene.Tab[vi].Forcast.Day_7.Image.Bitmap.LoadFromFile
  // (vSetPath + 'w_w_' + addons.weather.Action.Choosen[vi].Day_7.Code + '.png');
  // vWeather.Scene.Tab[vi].Forcast.Day_8.Image.Bitmap.LoadFromFile
  // (vSetPath + 'w_w_' + addons.weather.Action.Choosen[vi].Day_8.Code + '.png');
  // vWeather.Scene.Tab[vi].Forcast.Day_9.Image.Bitmap.LoadFromFile
  // (vSetPath + 'w_w_' + addons.weather.Action.Choosen[vi].Day_9.Code + '.png');
  // end;
end;

procedure uWeather_Config_Iconsets_UseIconSet(vIconSet_Name: String);
begin
//  if vIconSet_Name <> addons.weather.Config.Iconset.Name then
//  begin
//    uWeather_Config_Iconsets_Check(vIconSet_Name);
//    uWeather_Config_Iconsets_Reload(vIconSet_Name);
//    addons.weather.Ini.Ini.WriteString('Iconset', 'Name', vIconSet_Name);
//    addons.weather.Config.Iconset.Name := vIconSet_Name;
//  end;
end;

procedure uWeather_Config_Iconsets_ShowSet(vIconSet_Name: String);
var
  vi: Integer;
  vSetPath: String;
begin
  vWeather.Config.main.Right.Iconsets.Box.Visible := False;
  vWeather.Config.main.Right.Iconsets.Full.Panel.Visible := True;
  vWeather.Config.main.Right.Iconsets.Full.Back.Visible := True;
//  vSetPath := addons.weather.Path.Iconsets + vIconSet_Name + '\';
//  for vi := 0 to 48 do
//    vWeather.Config.main.Right.Iconsets.Full.Images[vi].Bitmap.LoadFromFile(vSetPath + 'w_w_' + IntToStr(vi) + '.png');
end;

procedure uWeather_Config_Iconsets_ReturnToPreview;
begin
  vWeather.Config.main.Right.Iconsets.Box.Visible := True;
  vWeather.Config.main.Right.Iconsets.Full.Panel.Visible := False;
  vWeather.Config.main.Right.Iconsets.Full.Back.Visible := False;
end;

Procedure uWeather_SetAll_Iconsets_CreateMiniPreview(vNum: Integer);
var
  vi: Integer;
begin
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Name := TLabel.Create(vWeather.Config.main.Right.Iconsets.Box);
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Name.Name := 'Weather_Config_Iconsets_Preview_Name_' + IntToStr(vNum);
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Name.Parent := vWeather.Config.main.Right.Iconsets.Box;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Name.Width := 300;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Name.Position.X := 10;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Name.Position.Y := 2 + (vNum * 68);
//  vWeather.Config.main.Right.Iconsets.Mini[vNum].Name.Text := addons.weather.Config.Iconset.Names.Strings[vNum];
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Name.Font.Style := vWeather.Config.main.Right.Iconsets.Mini[vNum].Name.Font.Style + [TFontStyle.fsBold];
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Name.Visible := True;

  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel := TPanel.Create(vWeather.Config.main.Right.Iconsets.Box);
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.Name := 'Weather_Config_Iconsets_Mini_Preview_Panel_' + IntToStr(vNum);
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.Parent := vWeather.Config.main.Right.Iconsets.Box;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.Width := vWeather.Config.main.Right.Iconsets.Box.Width - 30;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.Height := 54;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.Position.X := 10;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.Position.Y := 20 + (vNum * 68);
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.OnClick := addons.weather.Input.mouse.Panel.OnMouseClick;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.OnMouseEnter := addons.weather.Input.mouse.Panel.OnMouseEnter;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.OnMouseLeave := addons.weather.Input.mouse.Panel.OnMouseLeave;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.Tag := vNum;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.TagFloat := 100;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.Visible := True;

  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel_Glow := TGlowEffect.Create(vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel);
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel_Glow.Name := 'Weather_Config_Iconsets_Mini_Preview_Panel_Glow_' + IntToStr(vNum);
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel_Glow.Parent := vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel_Glow.Opacity := 0.9;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel_Glow.Softness := 0.4;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel_Glow.Enabled := False;

  for vi := 0 to 7 do
  begin
    vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi] := TImage.Create(vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel);
    vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].Name := 'Weather_Config_Iconsets_Mini_Preview_Image_' + IntToStr(vNum) + '_' + IntToStr(vi);
    vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].Parent := vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel;
    vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].Width := 50;
    vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].Height := 50;
    vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].Position.X := 50 * vi;
    vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].Position.Y := 2;
//    vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].Bitmap.LoadFromFile(addons.weather.Path.Iconsets + addons.weather.Config.Iconset.Names.Strings
//      [vNum] + '\w_w_' + IntToStr(RandomRange(0, 49)) + '.png');
    vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].TagFloat := 100;
    vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].Tag := vNum;
    vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].OnClick := addons.weather.Input.mouse.Image.OnMouseClick;
    vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].OnMouseEnter := addons.weather.Input.mouse.Image.OnMouseEnter;
    vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].OnMouseLeave := addons.weather.Input.mouse.Image.OnMouseLeave;
    vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].Visible := True;
  end;

//  if addons.weather.Config.Iconset.Name = addons.weather.Config.Iconset.Names.Strings[vNum] then
//    vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[0].Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_check.png')
//  else
//    vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[0].Bitmap := nil;

  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview := TImage.Create(vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel);
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview.Name := 'A_W_Config_Iconsets_Mini_Priview_' + IntToStr(vNum);
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview.Parent := vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview.Width := 40;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview.Height := 50;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview.Position.X := 50 * 8;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview.Position.Y := 2;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_preview.png');
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview.WrapMode := TImageWrapMode.Fit;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview.OnClick := addons.weather.Input.mouse.Image.OnMouseClick;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview.OnMouseEnter := addons.weather.Input.mouse.Image.OnMouseEnter;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview.OnMouseLeave := addons.weather.Input.mouse.Image.OnMouseLeave;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview.TagFloat := 101;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview.Tag := vNum;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview.Visible := True;

  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview_Glow := TGlowEffect.Create(vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview);
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview_Glow.Name := 'A_W_Config_Iconsets_Mini_Priview_Glow_' + vNum.ToString;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview_Glow.Parent := vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview_Glow.Softness := 0.4;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview_Glow.Opacity := 0.9;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Preview_Glow.Enabled := False;
end;

procedure uWeather_Config_Iconsets_GlowPreview(vPreview: Integer; vGlow: Boolean);
var
  vi: Integer;
begin
//  for vi := 0 to addons.weather.Config.Iconset.Count - 1 do
//    vWeather.Config.main.Right.Iconsets.Mini[vi].Preview_Glow.Enabled := False;

  if vGlow then
    vWeather.Config.main.Right.Iconsets.Mini[vPreview].Preview_Glow.Enabled := True;
end;

end.
