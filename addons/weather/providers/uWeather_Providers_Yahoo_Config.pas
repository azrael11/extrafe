unit uWeather_Providers_Yahoo_Config;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  System.Math,
  FMX.Forms,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Types,
  FMX.Edit,
  FMX.Effects,
  FMX.Layouts,
  ALFmxObjects;

procedure Load;

procedure Load_Default_Config;
procedure Load_Config;

procedure Create_Options;
procedure Options_Check_System_Type(vType: String);

procedure Create_Iconsets;
procedure Create_MiniPreview(vNum: Integer);
procedure Show_Full_Iconset_Preview(vPreview_Num: Integer);
procedure Close_Full_Iconset_Preview;
procedure Set_New_Iconset_Check(vSelected: Integer);
procedure New_Iconset_Reload(vSelectd: Integer);
procedure Select_Iconset(vSelected: Integer);

implementation

uses
  uLoad_AllTypes,
  uWindows,
  uWeather_AllTypes,
  uWeather_Providers_Yahoo;

procedure Load;
var
  vi: Integer;
begin
  // Set the values in weather.ini
  addons.weather.Ini.Ini.WriteString('Provider', 'Name', 'yahoo');
  addons.weather.Action.Provider := 'yahoo';
  vWeather.Config.main.Right.Provider.Text.Text := 'Selected "Provider" : ' + UpperCase(addons.weather.Action.Provider);
  vWeather.Config.main.Left.Provider.Bitmap.LoadFromFile(addons.weather.Path.Images + 'w_provider_yahoo.png');
  // if yahoo have towns load towns else load default
  Load_Config;
  // if yahoo have towns create main towns else load default
  for vi := 0 to addons.weather.Action.Active_Total do
  begin
    SetLength(addons.weather.Action.Yahoo.Data_Town, addons.weather.Action.Yahoo.Total_WoeID + 1);
    addons.weather.Action.Yahoo.Data_Town[vi] := Get_Forecast(vi, addons.weather.Action.Yahoo.Woeid_List.Strings[vi]);
    Main_Create_Town(addons.weather.Action.Yahoo.Data_Town[vi], vi);
    addons.weather.Action.Yahoo.Data_Town[vi].Photos.Picture_Used_Num := vBest_Img_Num;
  end;
end;

procedure Load_Default_Config;
begin
  addons.weather.Action.Yahoo.Total_WoeID := -1;
  addons.weather.Action.Yahoo.Selected_Unit := 'imperial';
  addons.weather.Action.Yahoo.Iconset_Count := 3;
  addons.weather.Action.Yahoo.Iconset_Selected := 0;
  addons.weather.Action.Yahoo.Iconset_Name := 'clear';
end;

procedure Load_Config;
begin
  if addons.weather.Action.Provider = 'yahoo' then
  begin
    if addons.weather.Ini.Ini.ValueExists('yahoo', 'total') then
      addons.weather.Action.Yahoo.Total_WoeID := addons.weather.Ini.Ini.ReadInteger('yahoo', 'total', addons.weather.Action.Yahoo.Total_WoeID)
    else
      addons.weather.Action.Yahoo.Total_WoeID := -1;
    if addons.weather.Ini.Ini.ValueExists('yahoo', 'selected_unit') then
      addons.weather.Action.Yahoo.Selected_Unit := addons.weather.Ini.Ini.ReadString('yahoo', 'Selected_Unit', addons.weather.Action.Yahoo.Selected_Unit)
    else
      addons.weather.Action.Yahoo.Selected_Unit := 'imperial';
    addons.weather.Action.Yahoo.Iconset_Names := TStringList.Create;
    addons.weather.Action.Yahoo.Iconset_Names := uWindows_GetFolderNames(addons.weather.Path.Iconsets);
    addons.weather.Action.Yahoo.Iconset_Names.Insert(0, 'default');
    if addons.weather.Ini.Ini.ValueExists('yahoo', 'iconset_count') then
    begin
      addons.weather.Action.Yahoo.Iconset_Count := addons.weather.Ini.Ini.ReadInteger('yahoo', 'iconset_count', addons.weather.Action.Yahoo.Iconset_Count);
      addons.weather.Action.Yahoo.Iconset_Selected := addons.weather.Ini.Ini.ReadInteger('yahoo', 'iconset', addons.weather.Action.Yahoo.Iconset_Selected);
      addons.weather.Action.Yahoo.Iconset_Name := addons.weather.Ini.Ini.ReadString('yahoo', 'iconset_name', addons.weather.Action.Yahoo.Iconset_Name);
    end
    else
    begin
      addons.weather.Ini.Ini.WriteInteger('yahoo', 'iconset_count', 3);
      addons.weather.Ini.Ini.ReadInteger('yahoo', 'iconset', 0);
      addons.weather.Action.Yahoo.Iconset_Count := 3;
      addons.weather.Action.Yahoo.Iconset_Selected := 0;
      addons.weather.Action.Yahoo.Iconset_Name := 'clear';
    end;
    uWeather_Providers_Yahoo.Woeid_List;
  end;
end;

procedure Options_Check_System_Type(vType: String);
begin
  if vType <> addons.weather.Action.Yahoo.Selected_Unit then
  begin
    if vType = 'metric' then
    begin
      if vWeather.Config.main.Right.Options_Yahoo.Metric.IsChecked = false then
      begin
        vWeather.Config.main.Right.Options_Yahoo.Imperial.IsChecked := false;
        addons.weather.Action.Yahoo.Selected_Unit := 'metric';
        addons.weather.Ini.Ini.WriteString('yahoo', 'selected_unit', 'metric');
        uWeather_Providers_Yahoo.Use_Metric;
      end;
    end
    else if vType = 'imperial' then
    begin
      if vWeather.Config.main.Right.Options_Yahoo.Imperial.IsChecked = false then
      begin
        vWeather.Config.main.Right.Options_Yahoo.Metric.IsChecked := false;
        addons.weather.Action.Yahoo.Selected_Unit := 'imperial';
        addons.weather.Ini.Ini.WriteString('yahoo', 'selected_unit', 'imperial');
        uWeather_Providers_Yahoo.Use_Imperial;
      end;
    end;
  end;
end;

procedure Create_Options;
begin
  if vWeather.Config.main.Right.Panels[2] <> nil then
    FreeAndNil(vWeather.Config.main.Right.Panels[2]);

  vWeather.Config.main.Right.Panels[2] := TPanel.Create(vWeather.Config.main.Right.Panel);
  vWeather.Config.main.Right.Panels[2].Name := 'Weather_Config_Panels_2';
  vWeather.Config.main.Right.Panels[2].Parent := vWeather.Config.main.Right.Panel;
  vWeather.Config.main.Right.Panels[2].Align := TAlignLayout.Client;
  vWeather.Config.main.Right.Panels[2].Visible := True;

  vWeather.Config.main.Right.Options_Yahoo.System_Type := TGroupBox.Create(vWeather.Config.main.Right.Panels[2]);
  vWeather.Config.main.Right.Options_Yahoo.System_Type.Name := 'A_W_Provider_Yahoo_Config_System_Type';
  vWeather.Config.main.Right.Options_Yahoo.System_Type.Parent := vWeather.Config.main.Right.Panels[2];
  vWeather.Config.main.Right.Options_Yahoo.System_Type.SetBounds(10, 10, vWeather.Config.main.Right.Panels[2].Width - 20, 100);
  vWeather.Config.main.Right.Options_Yahoo.System_Type.Text := 'Weather system type';
  vWeather.Config.main.Right.Options_Yahoo.System_Type.Visible := True;

  vWeather.Config.main.Right.Options_Yahoo.Type_Text := TALText.Create(vWeather.Config.main.Right.Options_Yahoo.System_Type);
  vWeather.Config.main.Right.Options_Yahoo.Type_Text.Name := 'A_W_Provider_Yahoo_Config_System_Text';
  vWeather.Config.main.Right.Options_Yahoo.Type_Text.Parent := vWeather.Config.main.Right.Options_Yahoo.System_Type;
  vWeather.Config.main.Right.Options_Yahoo.Type_Text.SetBounds(20, 20, vWeather.Config.main.Right.Options_Yahoo.System_Type.Width - 40, 60);
  vWeather.Config.main.Right.Options_Yahoo.Type_Text.Text :=
    'Select <font color="#f21212">Imperial</font> (Fahrenheit, inHG, Miles) or <font color="#f21212">Metric</font> (Celcius, mb, Kmph) as a default start up system';
  vWeather.Config.main.Right.Options_Yahoo.Type_Text.TextSettings.FontColor := TAlphaColorRec.White;
  vWeather.Config.main.Right.Options_Yahoo.Type_Text.TextIsHtml := True;
  vWeather.Config.main.Right.Options_Yahoo.Type_Text.WordWrap := True;
  vWeather.Config.main.Right.Options_Yahoo.Type_Text.Visible := True;

  vWeather.Config.main.Right.Options_Yahoo.Metric := TCheckBox.Create(vWeather.Config.main.Right.Options_Yahoo.System_Type);
  vWeather.Config.main.Right.Options_Yahoo.Metric.Name := 'A_W_Provider_Yahoo_Config_Metric';
  vWeather.Config.main.Right.Options_Yahoo.Metric.Parent := vWeather.Config.main.Right.Options_Yahoo.System_Type;
  vWeather.Config.main.Right.Options_Yahoo.Metric.SetBounds(20, 70, 200, 20);
  vWeather.Config.main.Right.Options_Yahoo.Metric.Text := 'Metric';
  if addons.weather.Action.Yahoo.Selected_Unit = 'metric' then
    vWeather.Config.main.Right.Options_Yahoo.Metric.IsChecked := True;
  vWeather.Config.main.Right.Options_Yahoo.Metric.Font.Style := vWeather.Config.main.Right.Options_Yahoo.Metric.Font.Style + [TFontStyle.fsBold];
  vWeather.Config.main.Right.Options_Yahoo.Metric.OnClick := addons.weather.Input.mouse_config.Checkbox.OnMouseClick;
  vWeather.Config.main.Right.Options_Yahoo.Metric.OnMouseEnter := addons.weather.Input.mouse_config.Checkbox.OnMouseEnter;
  vWeather.Config.main.Right.Options_Yahoo.Metric.Visible := True;

  vWeather.Config.main.Right.Options_Yahoo.Imperial := TCheckBox.Create(vWeather.Config.main.Right.Options_Yahoo.System_Type);
  vWeather.Config.main.Right.Options_Yahoo.Imperial.Name := 'A_W_Provider_Yahoo_Config_Imperial';
  vWeather.Config.main.Right.Options_Yahoo.Imperial.Parent := vWeather.Config.main.Right.Options_Yahoo.System_Type;
  vWeather.Config.main.Right.Options_Yahoo.Imperial.SetBounds(vWeather.Config.main.Right.Options_Yahoo.System_Type.Width - 210, 70, 200, 20);
  if addons.weather.Action.Yahoo.Selected_Unit = 'imperial' then
    vWeather.Config.main.Right.Options_Yahoo.Imperial.IsChecked := True;
  vWeather.Config.main.Right.Options_Yahoo.Imperial.Text := 'Imperial';
  vWeather.Config.main.Right.Options_Yahoo.Imperial.Font.Style := vWeather.Config.main.Right.Options_Yahoo.Imperial.Font.Style + [TFontStyle.fsBold];
  vWeather.Config.main.Right.Options_Yahoo.Imperial.OnClick := addons.weather.Input.mouse_config.Checkbox.OnMouseClick;
  vWeather.Config.main.Right.Options_Yahoo.Imperial.OnMouseEnter := addons.weather.Input.mouse_config.Checkbox.OnMouseEnter;
  vWeather.Config.main.Right.Options_Yahoo.Imperial.Visible := True;

  { vWeather.Config.main.Right.Options_Yahoo.Refresh := TGroupBox.Create(vWeather.Config.main.Right.Panels[2]);
    vWeather.Config.main.Right.Options_Yahoo.Refresh.Name := 'Weather_Config_Options_Refresh_Groupbox';
    vWeather.Config.main.Right.Options_Yahoo.Refresh.Parent := vWeather.Config.main.Right.Panels[2];
    vWeather.Config.main.Right.Options_Yahoo.Refresh.SetBounds(10, 130, vWeather.Config.main.Right.Panels[2].Width - 20, 100);
    vWeather.Config.main.Right.Options_Yahoo.Refresh.Text := 'Refresh Options';
    vWeather.Config.main.Right.Options_Yahoo.Refresh.Visible := True;

    vWeather.Config.main.Right.Options_Yahoo.Refresh_Every := TCheckBox.Create(vWeather.Config.main.Right.Options_Yahoo.Refresh);
    vWeather.Config.main.Right.Options_Yahoo.Refresh_Every.Name := 'Weather_Config_Options_Refresh_Every_Checkbox';
    vWeather.Config.main.Right.Options_Yahoo.Refresh_Every.Parent := vWeather.Config.main.Right.Options_Yahoo.Refresh;
    vWeather.Config.main.Right.Options_Yahoo.Refresh_Every.SetBounds(10, 40, 250, 20);
    vWeather.Config.main.Right.Options_Yahoo.Refresh_Every.Text := 'Every time open the weather addon';
    vWeather.Config.main.Right.Options_Yahoo.Refresh_Every.Font.Style := vWeather.Config.main.Right.Options_Yahoo.Refresh_Every.Font.Style + [TFontStyle.fsBold];
    vWeather.Config.main.Right.Options_Yahoo.Refresh_Every.OnClick := addons.weather.Input.mouse.Checkbox.OnMouseClick;
    vWeather.Config.main.Right.Options_Yahoo.Refresh_Every.OnMouseEnter := addons.weather.Input.mouse.Checkbox.OnMouseEnter;
    vWeather.Config.main.Right.Options_Yahoo.Refresh_Every.OnMouseLeave := addons.weather.Input.mouse.Checkbox.OnMouseLeave;
    vWeather.Config.main.Right.Options_Yahoo.Refresh_Every.Visible := True;

    vWeather.Config.main.Right.Options_Yahoo.Refresh_Once := TCheckBox.Create(vWeather.Config.main.Right.Options_Yahoo.Refresh);
    vWeather.Config.main.Right.Options_Yahoo.Refresh_Once.Name := 'Weather_Config_Options_Refresh_Once_Checkbox';
    vWeather.Config.main.Right.Options_Yahoo.Refresh_Once.Parent := vWeather.Config.main.Right.Options_Yahoo.Refresh;
    vWeather.Config.main.Right.Options_Yahoo.Refresh_Once.SetBounds(vWeather.Config.main.Right.Options_Yahoo.Refresh.Width - 210, 40, 200, 20);
    vWeather.Config.main.Right.Options_Yahoo.Refresh_Once.Text := 'Once when run ExtraFE';
    vWeather.Config.main.Right.Options_Yahoo.Refresh_Once.Font.Style := vWeather.Config.main.Right.Options_Yahoo.Refresh_Once.Font.Style + [TFontStyle.fsBold];
    vWeather.Config.main.Right.Options_Yahoo.Refresh_Once.OnClick := addons.weather.Input.mouse.Checkbox.OnMouseClick;
    vWeather.Config.main.Right.Options_Yahoo.Refresh_Once.OnMouseEnter := addons.weather.Input.mouse.Checkbox.OnMouseEnter;
    vWeather.Config.main.Right.Options_Yahoo.Refresh_Once.OnMouseLeave := addons.weather.Input.mouse.Checkbox.OnMouseLeave;
    vWeather.Config.main.Right.Options_Yahoo.Refresh_Once.Visible := True; }
end;

procedure Create_Iconsets;
var
  vi, vl, vt: Integer;
begin
  if vWeather.Config.main.Right.Panels[3] <> nil then
    FreeAndNil(vWeather.Config.main.Right.Panels[3]);

  vWeather.Config.main.Right.Panels[3] := TPanel.Create(vWeather.Config.main.Right.Panel);
  vWeather.Config.main.Right.Panels[3].Name := 'Weather_Config_Panels_3';
  vWeather.Config.main.Right.Panels[3].Parent := vWeather.Config.main.Right.Panel;
  vWeather.Config.main.Right.Panels[3].Align := TAlignLayout.Client;
  vWeather.Config.main.Right.Panels[3].Visible := True;

  vWeather.Config.main.Right.Iconsets.Text := TLabel.Create(vWeather.Config.main.Right.Panels[3]);
  vWeather.Config.main.Right.Iconsets.Text.Name := 'A_W_Provider_Yahoo_Config_Iconsets_Text';
  vWeather.Config.main.Right.Iconsets.Text.Parent := vWeather.Config.main.Right.Panels[3];
  vWeather.Config.main.Right.Iconsets.Text.SetBounds(10, 10, 300, 20);
  vWeather.Config.main.Right.Iconsets.Text.Text := 'Iconsets preview';
  vWeather.Config.main.Right.Iconsets.Text.Font.Style := vWeather.Config.main.Right.Iconsets.Text.Font.Style + [TFontStyle.fsBold];
  vWeather.Config.main.Right.Iconsets.Text.Visible := True;

  vWeather.Config.main.Right.Iconsets.Full.Back := TText.Create(vWeather.Config.main.Right.Panels[3]);
  vWeather.Config.main.Right.Iconsets.Full.Back.Name := 'A_W_Provider_Yahoo_Config_Iconsets_Back';
  vWeather.Config.main.Right.Iconsets.Full.Back.Parent := vWeather.Config.main.Right.Panels[3];
  vWeather.Config.main.Right.Iconsets.Full.Back.SetBounds(vWeather.Config.main.Right.Panels[3].Width - 42, 7, 32, 32);
  vWeather.Config.main.Right.Iconsets.Full.Back.Font.Family := 'IcoMoon-Free';
  vWeather.Config.main.Right.Iconsets.Full.Back.Font.Size := 28;
  vWeather.Config.main.Right.Iconsets.Full.Back.Text := #$e967;
  vWeather.Config.main.Right.Iconsets.Full.Back.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vWeather.Config.main.Right.Iconsets.Full.Back.OnClick := addons.weather.Input.mouse_config.Text.OnMouseClick;
  vWeather.Config.main.Right.Iconsets.Full.Back.OnMouseEnter := addons.weather.Input.mouse_config.Text.OnMouseEnter;
  vWeather.Config.main.Right.Iconsets.Full.Back.OnMouseLeave := addons.weather.Input.mouse_config.Text.OnMouseLeave;
  vWeather.Config.main.Right.Iconsets.Full.Back.Visible := false;

  vWeather.Config.main.Right.Iconsets.Full.Back_Glow := TGlowEffect.Create(vWeather.Config.main.Right.Iconsets.Full.Back);
  vWeather.Config.main.Right.Iconsets.Full.Back_Glow.Name := 'A_W_Provider_Yahoo_Config_Back_Glow';
  vWeather.Config.main.Right.Iconsets.Full.Back_Glow.Parent := vWeather.Config.main.Right.Iconsets.Full.Back;
  vWeather.Config.main.Right.Iconsets.Full.Back_Glow.Softness := 0.4;
  vWeather.Config.main.Right.Iconsets.Full.Back_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vWeather.Config.main.Right.Iconsets.Full.Back_Glow.Opacity := 0.9;
  vWeather.Config.main.Right.Iconsets.Full.Back_Glow.Enabled := false;

  vWeather.Config.main.Right.Iconsets.Box := TVertScrollBox.Create(vWeather.Config.main.Right.Panels[3]);
  vWeather.Config.main.Right.Iconsets.Box.Name := 'A_W_Provider_Yahoo_Config_Iconsets_Box';
  vWeather.Config.main.Right.Iconsets.Box.Parent := vWeather.Config.main.Right.Panels[3];
  vWeather.Config.main.Right.Iconsets.Box.SetBounds(10, 50, vWeather.Config.main.Right.Panels[3].Width - 20, vWeather.Config.main.Right.Panels[3].Height - 80);
  vWeather.Config.main.Right.Iconsets.Box.Visible := True;

  vWeather.Config.main.Right.Iconsets.Full.Panel := TPanel.Create(vWeather.Config.main.Right.Panels[3]);
  vWeather.Config.main.Right.Iconsets.Full.Panel.Name := 'A_W_Provider_Yahoo_Config_Iconsets_Full';
  vWeather.Config.main.Right.Iconsets.Full.Panel.Parent := vWeather.Config.main.Right.Panels[3];
  vWeather.Config.main.Right.Iconsets.Full.Panel.SetBounds(10, 40, vWeather.Config.main.Right.Panels[3].Width - 20,
    vWeather.Config.main.Right.Panels[3].Height - 60);
  vWeather.Config.main.Right.Iconsets.Full.Panel.Visible := false;

  vl := 0;
  vt := 0;
  for vi := 0 to 48 do
  begin
    vWeather.Config.main.Right.Iconsets.Full.Images[vi] := TImage.Create(vWeather.Config.main.Right.Iconsets.Full.Panel);
    vWeather.Config.main.Right.Iconsets.Full.Images[vi].Name := 'A_W_Provider_Yahoo_Config_Iconsets_Full_Image_' + IntToStr(vi);
    vWeather.Config.main.Right.Iconsets.Full.Images[vi].Parent := vWeather.Config.main.Right.Iconsets.Full.Panel;
    case vi of
      7:
        begin
          vt := 64;
          vl := 0;
        end;
      14:
        begin
          vt := 128;
          vl := 0;
        end;
      21:
        begin
          vt := 192;
          vl := 0;
        end;
      28:
        begin
          vt := 256;
          vl := 0;
        end;
      35:
        begin
          vt := 320;
          vl := 0;
        end;
      42:
        begin
          vt := 384;
          vl := 0;
        end;
    end;
    vWeather.Config.main.Right.Iconsets.Full.Images[vi].SetBounds((64 * vl), vt, 64, 64);
    vWeather.Config.main.Right.Iconsets.Full.Images[vi].Visible := True;
    inc(vl, 1);
  end;

  vl := 0;
  vt := 0;
  for vi := 0 to 48 do
  begin
    vWeather.Config.main.Right.Iconsets.Full.Texts[vi] := TText.Create(vWeather.Config.main.Right.Iconsets.Full.Panel);
    vWeather.Config.main.Right.Iconsets.Full.Texts[vi].Name := 'A_W_Provider_Yahoo_Config_Iconsets_Full_Text_' + IntToStr(vi);
    vWeather.Config.main.Right.Iconsets.Full.Texts[vi].Parent := vWeather.Config.main.Right.Iconsets.Full.Panel;
    case vi of
      7:
        begin
          vt := 64;
          vl := 0;
        end;
      14:
        begin
          vt := 128;
          vl := 0;
        end;
      21:
        begin
          vt := 192;
          vl := 0;
        end;
      28:
        begin
          vt := 256;
          vl := 0;
        end;
      35:
        begin
          vt := 320;
          vl := 0;
        end;
      42:
        begin
          vt := 384;
          vl := 0;
        end;
    end;
    vWeather.Config.main.Right.Iconsets.Full.Texts[vi].SetBounds((64 * vl), vt, 64, 64);
    vWeather.Config.main.Right.Iconsets.Full.Texts[vi].Font.Family := 'Weather Icons';
    vWeather.Config.main.Right.Iconsets.Full.Texts[vi].Font.Size := 48;
    vWeather.Config.main.Right.Iconsets.Full.Texts[vi].TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vWeather.Config.main.Right.Iconsets.Full.Texts[vi].Text := '';
    vWeather.Config.main.Right.Iconsets.Full.Texts[vi].Visible := True;
    inc(vl, 1);
  end;

  for vi := 0 to addons.weather.Action.Yahoo.Iconset_Count do
    Create_MiniPreview(vi);
end;

procedure Create_MiniPreview(vNum: Integer);
var
  vi: Integer;
begin
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Name := TLabel.Create(vWeather.Config.main.Right.Iconsets.Box);
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Name.Name := 'A_W_Provider_Yahoo_Config_Iconsets_Preview_Name_' + vNum.ToString;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Name.Parent := vWeather.Config.main.Right.Iconsets.Box;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Name.SetBounds(10, 2 + (vNum * 68), 300, 20);
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Name.Text := addons.weather.Action.Yahoo.Iconset_Names.Strings[vNum];
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Name.Font.Style := vWeather.Config.main.Right.Iconsets.Mini[vNum].Name.Font.Style + [TFontStyle.fsBold];
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Name.Visible := True;

  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel := TPanel.Create(vWeather.Config.main.Right.Iconsets.Box);
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.Name := 'A_W_Provider_Yahoo_Config_Iconsets_Mini_Preview_Panel_' + vNum.ToString;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.Parent := vWeather.Config.main.Right.Iconsets.Box;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.SetBounds(10, 20 + (vNum * 68), vWeather.Config.main.Right.Iconsets.Box.Width - 30, 54);
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.OnClick := addons.weather.Input.mouse_config.Panel.OnMouseClick;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.OnMouseEnter := addons.weather.Input.mouse_config.Panel.OnMouseEnter;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.OnMouseLeave := addons.weather.Input.mouse_config.Panel.OnMouseLeave;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.TagString := vNum.ToString;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel.Visible := True;

  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel_Glow := TGlowEffect.Create(vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel);
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel_Glow.Name := 'A_W_Provider_Yahoo_Config_Iconsets_Mini_Preview_Panel_Glow_' + vNum.ToString;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel_Glow.Parent := vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel_Glow.Opacity := 0.9;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel_Glow.Softness := 0.4;
  vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel_Glow.Enabled := false;

  if vNum = 0 then
  begin
    for vi := 0 to 8 do
    begin
      vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi] := TText.Create(vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel);
      vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].Name := 'A_W_Provider_Yahoo_Config_Iconsets_TextImage_' + vNum.ToString + '_' + vi.ToString;
      vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].Parent := vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel;
      vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].SetBounds(50 * vi, 2, 50, 50);
      if vi in [0, 8] then
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].Font.Family := 'IcoMoon-Free'
      else
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].Font.Family := 'Weather Icons';
      vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].Font.Size := 32;
      if vi = 8 then
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].Text := #$e9ce
      else
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].Text := uWeather_Providers_Yahoo.Get_Icon_From_Text(RandomRange(0, 47).ToString);
      vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].Tag := vi;
      vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].TagString := vNum.ToString;
      vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].OnClick := addons.weather.Input.mouse_config.Text.OnMouseClick;
      vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].OnMouseEnter := addons.weather.Input.mouse_config.Text.OnMouseEnter;
      vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].OnMouseLeave := addons.weather.Input.mouse_config.Text.OnMouseLeave;
      vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].Visible := True;

      if vi = 8 then
      begin
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image_Glow := TGlowEffect.Create(vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[8]);
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image_Glow.Name := 'A_W_Provider_Yahoo_Config_Iconsets_Text_Image_' + vNum.ToString + '_Glow';
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image_Glow.Parent := vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[8];
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image_Glow.Opacity := 0.9;
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image_Glow.Softness := 0.4;
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image_Glow.Enabled := false;
      end;
    end;
  end
  else
  begin
    for vi := 0 to 8 do
    begin
      if vi in [0, 8] then
      begin
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi] := TText.Create(vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel);
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].Name := 'A_W_Provider_Yahoo_Config_Iconsets_TextImage_' + vNum.ToString + '_' +
          vi.ToString;
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].Parent := vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel;
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].SetBounds(50 * vi, 2, 50, 50);
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].Font.Family := 'IcoMoon-Free';
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].Font.Size := 32;
        if vi = 8 then
          vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].Text := #$e9ce
        else
          vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].Text := '';
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].Tag := vi;
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].TagString := vNum.ToString;
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].OnClick := addons.weather.Input.mouse_config.Text.OnMouseClick;
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].OnMouseEnter := addons.weather.Input.mouse_config.Text.OnMouseEnter;
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].OnMouseLeave := addons.weather.Input.mouse_config.Text.OnMouseLeave;
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi].Visible := True;

        if vi = 8 then
        begin
          vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image_Glow := TGlowEffect.Create(vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi]);
          vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image_Glow.Name := 'A_W_Provider_Yahoo_Config_Iconsets_Text_Image_' + vNum.ToString + '_Glow';
          vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image_Glow.Parent := vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[vi];
          vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
          vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image_Glow.Opacity := 0.9;
          vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image_Glow.Softness := 0.4;
          vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image_Glow.Enabled := false;
        end;
      end
      else
      begin
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi] := TImage.Create(vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel);
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].Name := 'A_W_Provider_Yahoo_Config_Iconsets_Mini_Preview_Image_' + vNum.ToString + '_' +
          vi.ToString;
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].Parent := vWeather.Config.main.Right.Iconsets.Mini[vNum].Panel;
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].SetBounds(50 * vi, 2, 50, 50);
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].Bitmap.LoadFromFile
          (addons.weather.Path.Iconsets + addons.weather.Action.Yahoo.Iconset_Names.Strings[vNum] + '\w_w_' + IntToStr(RandomRange(0, 49)) + '.png');
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].Tag := vi;
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].TagString := vNum.ToString;
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].OnClick := addons.weather.Input.mouse_config.Image.OnMouseClick;
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].OnMouseEnter := addons.weather.Input.mouse_config.Image.OnMouseEnter;
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].OnMouseLeave := addons.weather.Input.mouse_config.Image.OnMouseLeave;
        vWeather.Config.main.Right.Iconsets.Mini[vNum].Image[vi].Visible := True;
      end;
    end;
  end;

  if addons.weather.Action.Yahoo.Iconset_Selected = vNum then
    vWeather.Config.main.Right.Iconsets.Mini[vNum].Text_Image[0].Text := #$ea10;
end;

procedure Show_Full_Iconset_Preview(vPreview_Num: Integer);
var
  vi: Integer;
  vPath: String;
begin
  vWeather.Config.main.Right.Iconsets.Box.Visible := false;
  vWeather.Config.main.Right.Iconsets.Full.Panel.Visible := True;
  vWeather.Config.main.Right.Iconsets.Full.Back.Visible := True;
  vPath := addons.weather.Action.Yahoo.Iconset_Names.Strings[vPreview_Num];
  vPath := addons.weather.Path.Iconsets + vPath + '\';
  if vPreview_Num <> 0 then
  begin
    for vi := 0 to 48 do
      vWeather.Config.main.Right.Iconsets.Full.Texts[vi].Visible := false;
    for vi := 0 to 48 do
    begin
      vWeather.Config.main.Right.Iconsets.Full.Images[vi].Visible := True;
      vWeather.Config.main.Right.Iconsets.Full.Images[vi].Bitmap.LoadFromFile(vPath + 'w_w_' + IntToStr(vi) + '.png');
    end;
  end
  else
  begin
    for vi := 0 to 48 do
      vWeather.Config.main.Right.Iconsets.Full.Images[vi].Visible := false;
    for vi := 0 to 48 do
    begin
      vWeather.Config.main.Right.Iconsets.Full.Texts[vi].Visible := True;
      if vi = 48 then
        vWeather.Config.main.Right.Iconsets.Full.Texts[vi].Text := uWeather_Providers_Yahoo.Get_Icon_From_Text('3200')
      else
        vWeather.Config.main.Right.Iconsets.Full.Texts[vi].Text := uWeather_Providers_Yahoo.Get_Icon_From_Text(vi.ToString);
    end;
  end;
end;

procedure Close_Full_Iconset_Preview;
begin
  vWeather.Config.main.Right.Iconsets.Box.Visible := True;
  vWeather.Config.main.Right.Iconsets.Full.Panel.Visible := false;
  vWeather.Config.main.Right.Iconsets.Full.Back.Visible := false;
end;

procedure Set_New_Iconset_Check(vSelected: Integer);
var
  vi: Integer;
begin
  for vi := 0 to addons.weather.Action.Yahoo.Iconset_Count do
    vWeather.Config.main.Right.Iconsets.Mini[vi].Text_Image[0].Text := '';
  vWeather.Config.main.Right.Iconsets.Mini[vSelected].Text_Image[0].Text := #$ea10;
end;

procedure New_Iconset_Reload(vSelectd: Integer);
var
  vi: Integer;
  vk: Integer;
begin
  if vSelectd = 0 then
  begin
    // Free Items
    for vi := 0 to addons.weather.Action.Yahoo.Total_WoeID do
    begin
      FreeAndNil(vWeather.Scene.Tab[vi].General.Image);
      for vk := 0 to 24 do
      begin
        if Assigned(vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Icon) then
          FreeAndNil(vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Icon);
      end;
      for vk := 0 to 10 do
      begin
        if Assigned(vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Icon) then
          FreeAndNil(vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Icon);
      end;
    end;
    // Create items
    for vi := 0 to addons.weather.Action.Yahoo.Total_WoeID do
    begin
      vWeather.Scene.Tab[vi].General.Text_Image := TText.Create(vWeather.Scene.Tab[vi].Tab);
      vWeather.Scene.Tab[vi].General.Text_Image.Name := 'A_W_Provider_Yahoo_Text_Image_' + vi.ToString;
      vWeather.Scene.Tab[vi].General.Text_Image.Parent := vWeather.Scene.Tab[vi].Tab;
      vWeather.Scene.Tab[vi].General.Text_Image.SetBounds(50, 60, 150, 150);
      vWeather.Scene.Tab[vi].General.Text_Image.Font.Family := 'Weather Icons';
      vWeather.Scene.Tab[vi].General.Text_Image.Font.Size := 72;
      vWeather.Scene.Tab[vi].General.Text_Image.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
      vWeather.Scene.Tab[vi].General.Text_Image.Text := Get_Icon_From_Text(addons.weather.Action.Yahoo.Data_Town[vi].Observation.ConditionCode);
      vWeather.Scene.Tab[vi].General.Text_Image.Visible := True;
      for vk := 0 to 24 do
      begin
        vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Text_Icon := TText.Create(vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Layout);
        vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Text_Icon.Name := 'A_W_Provider_Yahoo_Hourly_Info_Text_Image_' + vk.ToString;
        vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Text_Icon.Parent := vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Layout;
        vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Text_Icon.SetBounds(15, 25, 90, 90);
        vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Text_Icon.Font.Family := 'Weather Icons';
        vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Text_Icon.Font.Size := 48;
        vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Text_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
        vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Text_Icon.Text :=
          Get_Icon_From_Text(addons.weather.Action.Yahoo.Data_Town[vi].Forcasts.Hourly[vk].ConditionCode);
        vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Text_Icon.Visible := True;
      end;
      for vk := 0 to 10 do
      begin
        vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Text_Icon := TText.Create(vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Layout);
        vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Text_Icon.Name := 'A_W_Provider_Yahoo_Daily_Icon_' + vk.ToString;
        vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Text_Icon.Parent := vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Layout;
        vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Text_Icon.SetBounds(5, 5, 100, 100);
        vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Text_Icon.Font.Family := 'Weather Icons';
        vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Text_Icon.Font.Size := 56;
        vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Text_Icon.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
        vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Text_Icon.Text :=
          Get_Icon_From_Text(addons.weather.Action.Yahoo.Data_Town[vi].Forcasts.Daily[vk].ConditionCode);
        vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Text_Icon.Visible := True;
      end;
    end;
  end
  else
  begin
    // Free items if nessecery
    if Assigned(vWeather.Scene.Tab[0].General.Text_Image) then
    begin
      // Free
      for vi := 0 to addons.weather.Action.Yahoo.Total_WoeID do
      begin
        FreeAndNil(vWeather.Scene.Tab[vi].General.Text_Image);
        for vk := 0 to 24 do
          FreeAndNil(vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Text_Icon);
        for vk := 0 to 10 do
          FreeAndNil(vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Text_Icon);
      end;
      // Create
      for vi := 0 to addons.weather.Action.Yahoo.Total_WoeID do
      begin
        vWeather.Scene.Tab[vi].General.Image := TImage.Create(vWeather.Scene.Tab[vi].Tab);
        vWeather.Scene.Tab[vi].General.Image.Name := 'A_W_Provider_Yahoo_Image_' + IntToStr(vi);
        vWeather.Scene.Tab[vi].General.Image.Parent := vWeather.Scene.Tab[vi].Tab;
        vWeather.Scene.Tab[vi].General.Image.SetBounds(50, 60, 150, 150);
        vWeather.Scene.Tab[vi].General.Image.Bitmap.LoadFromFile(addons.weather.Path.Iconsets + addons.weather.Action.Yahoo.Iconset_Names.Strings[vSelectd] +
          '\w_w_' + addons.weather.Action.Yahoo.Data_Town[vi].Observation.ConditionCode + '.png');
        vWeather.Scene.Tab[vi].General.Image.Tag := vi;
        vWeather.Scene.Tab[vi].General.Image.Visible := True;
        for vk := 0 to 24 do
        begin
          vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Icon := TImage.Create(vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Layout);
          vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Icon.Name := 'A_W_Provider_Yahoo_Hourly_Info_Image_' + vk.ToString;
          vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Icon.Parent := vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Layout;
          vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Icon.SetBounds(15, 25, 90, 90);
          vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Icon.Bitmap.LoadFromFile
            (addons.weather.Path.Iconsets + addons.weather.Action.Yahoo.Iconset_Names.Strings[vSelectd] + '\w_w_' + addons.weather.Action.Yahoo.Data_Town[vi]
            .Forcasts.Hourly[vk].ConditionCode + '.png');
          vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Icon.WrapMode := TImageWrapMode.Fit;
          vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Icon.Visible := True;
        end;
        for vk := 0 to 10 do
        begin
          vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Icon := TImage.Create(vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Layout);
          vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Icon.Name := 'A_W_Provider_Yahoo_Daily_Icon_' + vk.ToString;
          vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Icon.Parent := vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Layout;
          vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Icon.SetBounds(5, 5, 100, 100);
          vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Icon.Bitmap.LoadFromFile
            (addons.weather.Path.Iconsets + addons.weather.Action.Yahoo.Iconset_Names.Strings[vSelectd] + '\w_w_' + addons.weather.Action.Yahoo.Data_Town[vi]
            .Forcasts.Daily[vk].ConditionCode + '.png');
          vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Icon.WrapMode := TImageWrapMode.Fit;
          vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Icon.Visible := True;
        end;
      end;
    end
    else
    begin
      for vi := 0 to addons.weather.Action.Yahoo.Total_WoeID do
      begin
        vWeather.Scene.Tab[vi].General.Image.Bitmap.LoadFromFile(addons.weather.Path.Iconsets + addons.weather.Action.Yahoo.Iconset_Names.Strings[vSelectd] +
          '\w_w_' + addons.weather.Action.Yahoo.Data_Town[vi].Observation.ConditionCode + '.png');
        for vk := 0 to 24 do
        begin
          vWeather.Scene.Tab[vi].Forecast_Hourly.Hourly[vk].Icon.Bitmap.LoadFromFile
            (addons.weather.Path.Iconsets + addons.weather.Action.Yahoo.Iconset_Names.Strings[vSelectd] + '\w_w_' + addons.weather.Action.Yahoo.Data_Town[vi]
            .Forcasts.Hourly[vk].ConditionCode + '.png');
        end;
        for vk := 0 to 10 do
        begin
          vWeather.Scene.Tab[vi].Forecast_Daily.Daily[vk].Icon.Bitmap.LoadFromFile
            (addons.weather.Path.Iconsets + addons.weather.Action.Yahoo.Iconset_Names.Strings[vSelectd] + '\w_w_' + addons.weather.Action.Yahoo.Data_Town[vi]
            .Forcasts.Daily[vi].ConditionCode + '.png');
        end;
      end;
    end;
  end;
end;

procedure Select_Iconset(vSelected: Integer);
begin
  if vSelected <> addons.weather.Action.Yahoo.Iconset_Selected then
  begin
    Set_New_Iconset_Check(vSelected);
    New_Iconset_Reload(vSelected);
    addons.weather.Action.Yahoo.Iconset_Selected := vSelected;
    if vSelected = 0 then
      addons.weather.Action.Yahoo.Iconset_Name := 'default'
    else
      addons.weather.Action.Yahoo.Iconset_Name := addons.weather.Action.Yahoo.Iconset_Names.Strings[vSelected];
    addons.weather.Ini.Ini.WriteInteger('yahoo', 'iconset', addons.weather.Action.Yahoo.Iconset_Selected);
    addons.weather.Ini.Ini.WriteString('yahoo', 'iconset_name', addons.weather.Action.Yahoo.Iconset_Name);
    vWeather.Scene.Blur.Enabled:= False;
    vWeather.Scene.Blur.Enabled:= True;
  end;
end;

end.
