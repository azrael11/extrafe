unit uMain_Config_Themes;

interface

uses
  System.Classes,
  System.SysUtils,
  FMX.Types,
  FMX.StdCtrls,
  FMX.Listbox,
  FMX.Layouts,
  FMX.Objects;

procedure uMain_Config_Themes_Create;

{ procedure uMain_Config_Themes_LoadThemes_Names; }
procedure uMain_Config_Themes_ApplyTheme(mThemeName: string);

// DONE 1 -oNikos Kordas -cConfig_Themes: Change text colors to white depends of theme that used

implementation

uses
  main,
  // emu,
  uLoad,
  uLoad_AllTypes,
  uMain_SetAll,
  uMain_AllTypes,
  uMain_Mouse;

procedure uMain_Config_Themes_Create;
var
  vi: Integer;
begin
  mainScene.Config.main.R.Themes.Panel := TPanel.Create(mainScene.Config.main.R.Panel[5]);
  mainScene.Config.main.R.Themes.Panel.Name := 'Main_Config_Themes_Main_Panel';
  mainScene.Config.main.R.Themes.Panel.Parent := mainScene.Config.main.R.Panel[5];
  mainScene.Config.main.R.Themes.Panel.Align := TAlignLayout.Client;
  mainScene.Config.main.R.Themes.Panel.Visible := True;

  mainScene.Config.main.R.Themes.Box := TVertScrollBox.Create(mainScene.Config.main.R.Themes.Panel);
  mainScene.Config.main.R.Themes.Box.Name := 'Main_Config_Themes_Box';
  mainScene.Config.main.R.Themes.Box.Parent := mainScene.Config.main.R.Themes.Panel;
  mainScene.Config.main.R.Themes.Box.SetBounds(10, 10, mainScene.Config.main.R.Themes.Panel.Width - 20,
    mainScene.Config.main.R.Themes.Panel.Height - 60);
  mainScene.Config.main.R.Themes.Box.Visible := True;
  for vi := 0 to 0 do
  begin
    mainScene.Config.main.R.Themes.Frame[vi] := TPanel.Create(mainScene.Config.main.R.Themes.Box);
    mainScene.Config.main.R.Themes.Frame[vi].Name := 'Main_Config_Themes_Theme_' + vi.ToString;
    mainScene.Config.main.R.Themes.Frame[vi].Parent := mainScene.Config.main.R.Themes.Box;
    mainScene.Config.main.R.Themes.Frame[vi].SetBounds(10, 5 + (90 * vi),
      mainScene.Config.main.R.Themes.Box.Width - 20, 80);
    mainScene.Config.main.R.Themes.Frame[vi].Visible := True;

    mainScene.Config.main.R.Themes.Check[vi] := TCheckBox.Create(mainScene.Config.main.R.Themes.Frame[vi]);
    mainScene.Config.main.R.Themes.Check[vi].Name := 'Main_Config_Themes_Check_' + vi.ToString;
    mainScene.Config.main.R.Themes.Check[vi].Parent := mainScene.Config.main.R.Themes.Frame[vi];
    mainScene.Config.main.R.Themes.Check[vi].SetBounds(15, 30, 20, 20);
    mainScene.Config.main.R.Themes.Check[vi].IsChecked := True;
    mainScene.Config.main.R.Themes.Check[vi].Visible := True;

    mainScene.Config.main.R.Themes.Image[vi] := TImage.Create(mainScene.Config.main.R.Themes.Frame[vi]);
    mainScene.Config.main.R.Themes.Image[vi].Name := 'Main_Config_Themes_Image_' + vi.ToString;
    mainScene.Config.main.R.Themes.Image[vi].Parent := mainScene.Config.main.R.Themes.Frame[vi];
    mainScene.Config.main.R.Themes.Image[vi].SetBounds(40, 2, 134, 78);
    mainScene.Config.main.R.Themes.Image[vi].Bitmap.LoadFromFile(ex_main.Paths.Config_Images +
      'config_theme_default.png');
    mainScene.Config.main.R.Themes.Image[vi].WrapMode := TImageWrapMode.Fit;
    mainScene.Config.main.R.Themes.Image[vi].Visible := True;

    mainScene.Config.main.R.Themes.Info[vi] := TLabel.Create(mainScene.Config.main.R.Themes.Frame[vi]);
    mainScene.Config.main.R.Themes.Info[vi].Name := 'Main_Config_Themes_Info_' + vi.ToString;
    mainScene.Config.main.R.Themes.Info[vi].Parent := mainScene.Config.main.R.Themes.Frame[vi];
    mainScene.Config.main.R.Themes.Info[vi].SetBounds(190, 20, 200, 20);
    mainScene.Config.main.R.Themes.Info[vi].Text := 'The default theme of ExtraFE';
    mainScene.Config.main.R.Themes.Info[vi].Visible := True;
  end;

  mainScene.Config.main.R.Themes.Apply := TButton.Create(mainScene.Config.main.R.Themes.Panel);
  mainScene.Config.main.R.Themes.Apply.Name := 'Main_Config_Themes_Apply';
  mainScene.Config.main.R.Themes.Apply.Parent := mainScene.Config.main.R.Themes.Panel;
  mainScene.Config.main.R.Themes.Apply.SetBounds((mainScene.Config.main.R.Themes.Panel.Width / 2) - 100, mainScene.Config.main.R.Themes.Panel.Height - 40, 200, 30);
  mainScene.Config.main.R.Themes.Apply.Text := 'Apply new theme';
  mainScene.Config.main.R.Themes.Apply.OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
  mainScene.Config.main.R.Themes.Apply.Visible := True;

  // uMain_Config_Themes_LoadThemes_Names;
  // Main_Form.Themes_Change_Theme.ItemIndex:= extrafe.style.Names.IndexOf(extrafe.style.Name)+ 1;
  // mainScene.Config.Main.R.Themes.Info.Text:= 'Active Theme : '+ extrafe.style.Name;
end;

/// /////////////////////////////////////////////////////////////////////////////
{ procedure uMain_Config_Themes_LoadThemes_Names;
  var
  vRec: TSearchRec;
  vName: string;
  begin
  extrafe.style.Names := TStringList.Create;
  if FindFirst(extrafe.style.Path + '*.style', faDirectory - faAnyFile, vRec) = 0 then
  try
  repeat
  vName := vRec.Name;
  Delete(vName, Length(vName) - 5, 6);
  extrafe.style.Names.Add(vName);
  until FindNext(vRec) <> 0;
  finally
  System.SysUtils.FindClose(vRec);
  end;
  end; }

procedure uMain_Config_Themes_ApplyTheme(mThemeName: string);
begin
  if mThemeName = 'Air' then
    mainScene.main.style.LoadFromFile(extrafe.style.Path + 'Air.Style')
  else if mThemeName = 'Amakrits' then
    mainScene.main.style.LoadFromFile(extrafe.style.Path + 'Amakrits.Style')
  else if mThemeName = 'Dark' then
    mainScene.main.style.LoadFromFile(extrafe.style.Path + 'Dark.Style')
  else if mThemeName = 'Light' then
    mainScene.main.style.LoadFromFile(extrafe.style.Path + 'Light.Style')
  else
    mainScene.main.style := nil;
end;

end.
