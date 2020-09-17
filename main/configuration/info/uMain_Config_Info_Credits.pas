unit uMain_Config_Info_Credits;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  FMX.Objects,
  FMX.Effects,
  FMX.Layouts,
  FMX.Types,
  FMX.StdCtrls,
  FMX.TabControl,
  ALFMXObjects;

procedure Load;

procedure Brands;
procedure Brands_Clear;
procedure Brand_Show(vNum, vNum_1: Integer);

procedure Show_Embarcadero;
procedure Show_Gimp;
procedure Show_BASS;
procedure Show_PasVlc;

var
  vTab_Selected: Integer;

implementation

uses
  uLoad_AllTypes,
  uMain_AllTypes;

procedure Load;
const
  cTab_Names: array [0 .. 1] of string = ('Programs', 'Components / Libraries');
var
  vi: Integer;
begin
  ex_main.Config.Info_Credits_Selected := -1;

  if Assigned(mainScene.Config.Main.R.Info.Credits.Panel) then
    FreeAndNil(mainScene.Config.Main.R.Info.Credits.Panel);

  mainScene.Config.Main.R.Info.Credits.Panel := TPanel.Create(mainScene.Config.Main.R.Info.TabItem[4]);
  mainScene.Config.Main.R.Info.Credits.Panel.Name := 'Main_Config_Info_Credits_Panel';
  mainScene.Config.Main.R.Info.Credits.Panel.Parent := mainScene.Config.Main.R.Info.TabItem[4];
  mainScene.Config.Main.R.Info.Credits.Panel.SetBounds(0, 0, mainScene.Config.Main.R.Info.TabControl.Width, mainScene.Config.Main.R.Info.TabControl.Height);
  mainScene.Config.Main.R.Info.Credits.Panel.Visible := True;

  mainScene.Config.Main.R.Info.Credits.Groupbox := TGroupBox.Create(mainScene.Config.Main.R.Info.Credits.Panel);
  mainScene.Config.Main.R.Info.Credits.Groupbox.Name := 'Main_Config_Info_Credits_Groupbox';
  mainScene.Config.Main.R.Info.Credits.Groupbox.Parent := mainScene.Config.Main.R.Info.Credits.Panel;
  mainScene.Config.Main.R.Info.Credits.Groupbox.Width := mainScene.Config.Main.R.Info.Credits.Panel.Width - 20;
  mainScene.Config.Main.R.Info.Credits.Groupbox.Height := 80;
  mainScene.Config.Main.R.Info.Credits.Groupbox.Position.X := 10;
  mainScene.Config.Main.R.Info.Credits.Groupbox.Position.Y := 10;
  mainScene.Config.Main.R.Info.Credits.Groupbox.Text := '-------------------------';
  mainScene.Config.Main.R.Info.Credits.Groupbox.Visible := True;

  mainScene.Config.Main.R.Info.Credits.Text := TALText.Create(mainScene.Config.Main.R.Info.Credits.Groupbox);
  mainScene.Config.Main.R.Info.Credits.Text.Name := 'Main_Config_Info_Credits_Text';
  mainScene.Config.Main.R.Info.Credits.Text.Parent := mainScene.Config.Main.R.Info.Credits.Groupbox;
  mainScene.Config.Main.R.Info.Credits.Text.Width := mainScene.Config.Main.R.Info.Credits.Groupbox.Width - 20;
  mainScene.Config.Main.R.Info.Credits.Text.Height := 60;
  mainScene.Config.Main.R.Info.Credits.Text.Position.X := 10;
  mainScene.Config.Main.R.Info.Credits.Text.Position.Y := 20;
  mainScene.Config.Main.R.Info.Credits.Text.WordWrap := True;
  mainScene.Config.Main.R.Info.Credits.Text.TextIsHtml := True;
  mainScene.Config.Main.R.Info.Credits.Text.TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.Main.R.Info.Credits.Text.TextSettings.Font.Size := 14;
  mainScene.Config.Main.R.Info.Credits.Text.TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.Main.R.Info.Credits.Text.Text :=
    ' First i want to thank for my heart my Son "<font color="#ff63cbfc">Vaggelis Kordas</font>" and my Wife "<font color="#ff63cbfc">Vouli Mpakatsi</font>" for the all time support and my missing dog "<font color="#ff63cbfc">Sokrates</font>"'
    + ' when he comes to my house then i start develop the <b>ExtraFE</b>.';
  mainScene.Config.Main.R.Info.Credits.Text.Visible := True;

  mainScene.Config.Main.R.Info.Credits.Groupbox_Other := TGroupBox.Create(mainScene.Config.Main.R.Info.Credits.Panel);
  mainScene.Config.Main.R.Info.Credits.Groupbox_Other.Name := 'Main_Config_Info_Credits_Groupbox_Others';
  mainScene.Config.Main.R.Info.Credits.Groupbox_Other.Parent := mainScene.Config.Main.R.Info.Credits.Panel;
  mainScene.Config.Main.R.Info.Credits.Groupbox_Other.Width := mainScene.Config.Main.R.Info.Credits.Panel.Width - 20;
  mainScene.Config.Main.R.Info.Credits.Groupbox_Other.Height := mainScene.Config.Main.R.Info.Credits.Panel.Height - 120;
  mainScene.Config.Main.R.Info.Credits.Groupbox_Other.Position.X := 10;
  mainScene.Config.Main.R.Info.Credits.Groupbox_Other.Position.Y := 90;
  mainScene.Config.Main.R.Info.Credits.Groupbox_Other.Text := '-------------------------';
  mainScene.Config.Main.R.Info.Credits.Groupbox_Other.Visible := True;

  mainScene.Config.Main.R.Info.Credits.Control := TTabControl.Create(mainScene.Config.Main.R.Info.Credits.Groupbox_Other);
  mainScene.Config.Main.R.Info.Credits.Control.Name := 'Main_Config_Info_Credits_TabControl';
  mainScene.Config.Main.R.Info.Credits.Control.Parent := mainScene.Config.Main.R.Info.Credits.Groupbox_Other;
  mainScene.Config.Main.R.Info.Credits.Control.SetBounds(2, 22, mainScene.Config.Main.R.Info.Credits.Groupbox_Other.Width - 4,
    mainScene.Config.Main.R.Info.Credits.Groupbox_Other.Height - 22);
  mainScene.Config.Main.R.Info.Credits.Control.Visible := True;

  for vi := 0 to 1 do
  begin
    mainScene.Config.Main.R.Info.Credits.Tab_Item[vi] := TTabItem.Create(mainScene.Config.Main.R.Info.Credits.Control);
    mainScene.Config.Main.R.Info.Credits.Tab_Item[vi].Name := 'Main_Config_Info_Credits_TabItem_' + vi.ToString;
    mainScene.Config.Main.R.Info.Credits.Tab_Item[vi].Parent := mainScene.Config.Main.R.Info.Credits.Control;
    mainScene.Config.Main.R.Info.Credits.Tab_Item[vi].SetBounds(0, 0, mainScene.Config.Main.R.Info.Credits.Control.Width,
      mainScene.Config.Main.R.Info.Credits.Control.Height);
    mainScene.Config.Main.R.Info.Credits.Tab_Item[vi].Text := cTab_Names[vi];
    mainScene.Config.Main.R.Info.Credits.Tab_Item[vi].OnClick := ex_main.Input.mouse_config.TabItem.OnMouseClick;
    mainScene.Config.Main.R.Info.Credits.Tab_Item[vi].Tag := vi;
    mainScene.Config.Main.R.Info.Credits.Tab_Item[vi].Visible := True;
  end;

  for vi := 0 to 1 do
  begin
    mainScene.Config.Main.R.Info.Credits.Left_Box[vi] := TVertScrollBox.Create(mainScene.Config.Main.R.Info.Credits.Tab_Item[vi]);
    mainScene.Config.Main.R.Info.Credits.Left_Box[vi].Name := 'Main_Config_Info_Credits_LeftBox_' + vi.ToString;
    mainScene.Config.Main.R.Info.Credits.Left_Box[vi].Parent := mainScene.Config.Main.R.Info.Credits.Tab_Item[vi];
    mainScene.Config.Main.R.Info.Credits.Left_Box[vi].SetBounds(10, 10, 120, mainScene.Config.Main.R.Info.Credits.Control.Height - 20);
    mainScene.Config.Main.R.Info.Credits.Left_Box[vi].Visible := True;
  end;

  Brands;
  vTab_Selected := -1;
end;

procedure Brands;
const
  cImages_Names_Programs: array [0 .. 1] of string = ('config_emb.png', 'config_gimp.png');
  cImages_Names_Comp: array [0 .. 1] of string = ('config_bass.png', 'config_pasvlc.png');
var
  vi: Integer;
begin
  // Programs
  for vi := 0 to 1 do
  begin
    mainScene.Config.Main.R.Info.Credits.Brand[0, vi] := TImage.Create(mainScene.Config.Main.R.Info.Credits.Left_Box[0]);
    mainScene.Config.Main.R.Info.Credits.Brand[0, vi].Name := 'Main_Config_Info_Credits_Image_' + vi.ToString;
    mainScene.Config.Main.R.Info.Credits.Brand[0, vi].Parent := mainScene.Config.Main.R.Info.Credits.Left_Box[0];
    mainScene.Config.Main.R.Info.Credits.Brand[0, vi].SetBounds(5, 15 + (vi * 70), 110, 60);
    mainScene.Config.Main.R.Info.Credits.Brand[0, vi].Bitmap.LoadFromFile(ex_main.Paths.Config_Images.Info + cImages_Names_Programs[vi]);
    mainScene.Config.Main.R.Info.Credits.Brand[0, vi].WrapMode := TImageWrapMode.Fit;
    mainScene.Config.Main.R.Info.Credits.Brand[0, vi].OnClick := ex_main.Input.mouse_config.Image.OnMouseClick;
    mainScene.Config.Main.R.Info.Credits.Brand[0, vi].OnMouseEnter := ex_main.Input.mouse_config.Image.OnMouseEnter;
    mainScene.Config.Main.R.Info.Credits.Brand[0, vi].OnMouseLeave := ex_main.Input.mouse_config.Image.OnMouseLeave;
    mainScene.Config.Main.R.Info.Credits.Brand[0, vi].Tag := vi;
    mainScene.Config.Main.R.Info.Credits.Brand[0, vi].TagString := '0';
    mainScene.Config.Main.R.Info.Credits.Brand[0, vi].Visible := True;

    mainScene.Config.Main.R.Info.Credits.Brand_Glow[0, vi] := TGlowEffect.Create(mainScene.Config.Main.R.Info.Credits.Brand[0, vi]);
    mainScene.Config.Main.R.Info.Credits.Brand_Glow[0, vi].Name := 'Main_Config_Info_Credits_Image_Glow_' + vi.ToString;
    mainScene.Config.Main.R.Info.Credits.Brand_Glow[0, vi].Parent := mainScene.Config.Main.R.Info.Credits.Brand[0, vi];
    mainScene.Config.Main.R.Info.Credits.Brand_Glow[0, vi].GlowColor := TAlphaColorRec.Deepskyblue;
    mainScene.Config.Main.R.Info.Credits.Brand_Glow[0, vi].Opacity := 0.9;
    mainScene.Config.Main.R.Info.Credits.Brand_Glow[0, vi].Enabled := False;
  end;

  // Components / Libraries
  for vi := 0 to 1 do
  begin
    mainScene.Config.Main.R.Info.Credits.Brand[1, vi] := TImage.Create(mainScene.Config.Main.R.Info.Credits.Left_Box[1]);
    mainScene.Config.Main.R.Info.Credits.Brand[1, vi].Name := 'Main_Config_Info_Credits_Image_' + vi.ToString;
    mainScene.Config.Main.R.Info.Credits.Brand[1, vi].Parent := mainScene.Config.Main.R.Info.Credits.Left_Box[1];
    mainScene.Config.Main.R.Info.Credits.Brand[1, vi].SetBounds(5, 15 + (vi * 70), 110, 60);
    mainScene.Config.Main.R.Info.Credits.Brand[1, vi].Bitmap.LoadFromFile(ex_main.Paths.Config_Images.info + cImages_Names_Comp[vi]);
    mainScene.Config.Main.R.Info.Credits.Brand[1, vi].WrapMode := TImageWrapMode.Fit;
    mainScene.Config.Main.R.Info.Credits.Brand[1, vi].OnClick := ex_main.Input.mouse_config.Image.OnMouseClick;
    mainScene.Config.Main.R.Info.Credits.Brand[1, vi].OnMouseEnter := ex_main.Input.mouse_config.Image.OnMouseEnter;
    mainScene.Config.Main.R.Info.Credits.Brand[1, vi].OnMouseLeave := ex_main.Input.mouse_config.Image.OnMouseLeave;
    mainScene.Config.Main.R.Info.Credits.Brand[1, vi].Tag := vi;
    mainScene.Config.Main.R.Info.Credits.Brand[1, vi].TagString := '1';
    mainScene.Config.Main.R.Info.Credits.Brand[1, vi].Visible := True;

    mainScene.Config.Main.R.Info.Credits.Brand_Glow[1, vi] := TGlowEffect.Create(mainScene.Config.Main.R.Info.Credits.Brand[1, vi]);
    mainScene.Config.Main.R.Info.Credits.Brand_Glow[1, vi].Name := 'Main_Config_Info_Credits_Image_Glow_' + vi.ToString;
    mainScene.Config.Main.R.Info.Credits.Brand_Glow[1, vi].Parent := mainScene.Config.Main.R.Info.Credits.Brand[1, vi];
    mainScene.Config.Main.R.Info.Credits.Brand_Glow[1, vi].GlowColor := TAlphaColorRec.Deepskyblue;
    mainScene.Config.Main.R.Info.Credits.Brand_Glow[1, vi].Opacity := 0.9;
    mainScene.Config.Main.R.Info.Credits.Brand_Glow[1, vi].Enabled := False;
  end;
end;

procedure Brands_Clear;
var
  vi, vk: Integer;
begin
  for vi := 0 to 1 do
    for vk := 0 to 10 do
    begin
      if Assigned(mainScene.Config.Main.R.Info.Credits.Right_Box[vi, vk]) then
      begin
        FreeAndNil(mainScene.Config.Main.R.Info.Credits.Right_Box[vi, vk]);
        mainScene.Config.Main.R.Info.Credits.Brand_Glow[vi, vk].Enabled := False;
      end;
    end;
end;

procedure Brand_Show(vNum, vNum_1: Integer);
begin
  Brands_Clear;
  case vNum of
    0:
      begin
        case vNum_1 of
          0:
            Show_Embarcadero;
          1:
            Show_Gimp;
        end;
      end;
    1:
      begin
        case vNum_1 of
          0:
            Show_BASS;
          1:
            Show_PasVlc;
        end;
      end;
  end;
  ex_main.Config.Info_Credits_Tab_Selected := vNum;
  ex_main.Config.Info_Credits_Selected := vNum_1;
end;

procedure Show_Embarcadero;
begin
  mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0] := TVertScrollBox.Create(mainScene.Config.Main.R.Info.Credits.Tab_Item[0]);
  mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0].Name := 'Main_Config_Info_Credits_VBox_Right_0';
  mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0].Parent := mainScene.Config.Main.R.Info.Credits.Tab_Item[0];
  mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0].SetBounds(120, 0, mainScene.Config.Main.R.Info.Credits.Control.Width - 120,
    mainScene.Config.Main.R.Info.Credits.Control.Height - 24);
  mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0].Visible := True;

  mainScene.Config.Main.R.Info.Credits.Paragraphs[0] := TALText.Create(mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0]);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].Name := 'Main_Config_Info_Credits_Parag_0';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].Parent := mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0];
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].SetBounds(10, 10, mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0].Width - 20, 100);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].TextSettings.Font.Size := 14;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].TextIsHtml := True;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].WordWrap := True;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].Text :=
    '   <b><font color="#ff63cbfc">ExtraFE</font></b> created, builded with <font color="#f21212">"Delphi Community Edition"</font> from <b>Embracedero</b> company.'
    + 'This IDE tool for pascal language with many new features and new style pascal is free with a restricted lincesce.' +
    'Go to <b>Embarcadero''s</b> web site and dowloading for <b><font color="#ff63cbfc">free</font></b> and create fabulus applications.';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].Visible := True;

  mainScene.Config.Main.R.Info.Credits.Paragraphs[1] := TALText.Create(mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0]);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].Name := 'Main_Config_Info_Credits_Parag_1';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].Parent := mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0];
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].SetBounds(10, 110, mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0].Width - 20, 150);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].TextSettings.Font.Size := 14;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].WordWrap := True;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].Text :=
    '   Embarcadero tools are built for elite developers who build and maintain the world’s most critical applications.' +
    ' Our customers choose Embarcadero because we are the champion of developers, and we help them build more secure and ' +
    'scalable enterprise applications faster than any other tools on the market. In fact, ninety of the Fortune 100 and an' +
    ' active community of more than three million users worldwide have relied on Embarcadero'' s award-winning products for' + ' over 30 years.';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].Visible := True;

  mainScene.Config.Main.R.Info.Credits.Paragraphs[2] := TALText.Create(mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0]);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[2].Name := 'Main_Config_Info_Credits_Parag_2';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[2].Parent := mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0];
  mainScene.Config.Main.R.Info.Credits.Paragraphs[2].SetBounds(10, 270, mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0].Width - 20, 140);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[2].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[2].TextSettings.Font.Size := 14;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[2].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[2].WordWrap := True;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[2].Text :=
    '   If you’re trying to build a business-critical application in a demanding vertical, Embarcadero is for' +
    ' you. If you’re looking to write steadfast code quickly that will pass stringent code reviews faster than any other,' +
    ' Embarcadero is for you. We’re here to support elite developers who understand the scalability and stability of C++' +
    ' and Delphi and depend on the decades of innovation those languages bring to development.';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[2].Visible := True;

  mainScene.Config.Main.R.Info.Credits.Paragraphs[3] := TALText.Create(mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0]);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[3].Name := 'Main_Config_Info_Credits_Parag_3';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[3].Parent := mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0];
  mainScene.Config.Main.R.Info.Credits.Paragraphs[3].SetBounds(10, 410, mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0].Width - 20, 30);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[3].WordWrap := True;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[3].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[3].TextSettings.Font.Size := 14;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[3].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[3].Text := '   We invite you to try our products for free and see for yourself.';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[3].Visible := True;

  mainScene.Config.Main.R.Info.Credits.Paragraphs[4] := TALText.Create(mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0]);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[4].Name := 'Main_Config_Info_Credits_Parag_4';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[4].Parent := mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0];
  mainScene.Config.Main.R.Info.Credits.Paragraphs[4].SetBounds(10, 440, mainScene.Config.Main.R.Info.Credits.Right_Box[0, 0].Width - 20, 200);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[4].WordWrap := True;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[4].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[4].TextSettings.Font.Size := 14;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[4].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[4].Text := '   Embarcadero is an Idera, Inc. company. Idera, Inc. is the parent company of' +
    ' global B2B software productivity brands whose solutions enable technical users to do more with less, faster. Idera, ' +
    'Inc. brands span three divisions – Database Tools, Developer Tools, and Test Management Tools – with products that are' +
    ' evangelized by millions of community members and more than 50,000 customers worldwide, including some of the world’s largest' +
    ' healthcare, financial services, retail, and technology companies.';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[4].Visible := True;
end;

procedure Show_Gimp;
begin
  mainScene.Config.Main.R.Info.Credits.Right_Box[0, 1] := TVertScrollBox.Create(mainScene.Config.Main.R.Info.Credits.Tab_Item[0]);
  mainScene.Config.Main.R.Info.Credits.Right_Box[0, 1].Name := 'Main_Config_Info_Credits_VBox_Right';
  mainScene.Config.Main.R.Info.Credits.Right_Box[0, 1].Parent := mainScene.Config.Main.R.Info.Credits.Tab_Item[0];
  mainScene.Config.Main.R.Info.Credits.Right_Box[0, 1].SetBounds(120, 0, mainScene.Config.Main.R.Info.Credits.Control.Width - 120,
    mainScene.Config.Main.R.Info.Credits.Control.Height - 24);
  mainScene.Config.Main.R.Info.Credits.Right_Box[0, 1].Visible := True;

  mainScene.Config.Main.R.Info.Credits.Paragraphs[0] := TALText.Create(mainScene.Config.Main.R.Info.Credits.Right_Box[0, 1]);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].Name := 'Main_Config_Info_Credits_Parag_0';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].Parent := mainScene.Config.Main.R.Info.Credits.Right_Box[0, 1];
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].SetBounds(10, 10, mainScene.Config.Main.R.Info.Credits.Right_Box[0, 1].Width - 20, 100);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].TextSettings.Font.Size := 14;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].TextIsHtml := True;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].WordWrap := True;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].Text :=
    '   <b><font color="#ff63cbfc">ExtraFE</font></b> uses <font color="#f21212">"Gimp"</font> as the main image manipulation program.' +
    'This tool is free, very powerfull and has nothing to jelius about commercials programs.' +
    'Go to <b>Gimp''s</b> web site and dowloading for <b><font color="#ff63cbfc">free</font></b>.';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].Visible := True;

  mainScene.Config.Main.R.Info.Credits.Paragraphs[1] := TALText.Create(mainScene.Config.Main.R.Info.Credits.Right_Box[0, 1]);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].Name := 'Main_Config_Info_Credits_Parag_1';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].Parent := mainScene.Config.Main.R.Info.Credits.Right_Box[0, 1];
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].SetBounds(10, 80, mainScene.Config.Main.R.Info.Credits.Right_Box[0, 1].Width - 20, 110);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].TextSettings.Font.Size := 14;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].WordWrap := True;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].Text := '   GIMP is an acronym for GNU Image Manipulation Program. ' +
    ' It is a freely distributed program for such tasks as photo retouching, image composition and image authoring.' +
    ' The terms of usage and rules about copying are clearly listed in the GNU General Public License.';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].Visible := True;

end;

procedure Show_BASS;
begin
  mainScene.Config.Main.R.Info.Credits.Right_Box[1, 0] := TVertScrollBox.Create(mainScene.Config.Main.R.Info.Credits.Tab_Item[1]);
  mainScene.Config.Main.R.Info.Credits.Right_Box[1, 0].Name := 'Main_Config_Info_Credits_VBox_Right';
  mainScene.Config.Main.R.Info.Credits.Right_Box[1, 0].Parent := mainScene.Config.Main.R.Info.Credits.Tab_Item[1];
  mainScene.Config.Main.R.Info.Credits.Right_Box[1, 0].SetBounds(120, 0, mainScene.Config.Main.R.Info.Credits.Control.Width - 120,
    mainScene.Config.Main.R.Info.Credits.Control.Height - 24);
  mainScene.Config.Main.R.Info.Credits.Right_Box[1, 0].Visible := True;

  mainScene.Config.Main.R.Info.Credits.Paragraphs[0] := TALText.Create(mainScene.Config.Main.R.Info.Credits.Right_Box[1, 0]);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].Name := 'Main_Config_Info_Credits_Parag_0';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].Parent := mainScene.Config.Main.R.Info.Credits.Right_Box[1, 0];
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].SetBounds(10, 10, mainScene.Config.Main.R.Info.Credits.Right_Box[1, 0].Width - 20, 100);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].TextSettings.Font.Size := 14;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].TextIsHtml := True;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].WordWrap := True;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].Text :=
    '   <b><font color="#ff63cbfc">ExtraFE</font></b> uses <font color="#f21212">"BASS"</font> as the main sound and effects library.' +
    'The library is free for non comercial products. It is very powerfull, easy, with great addons and in ExtraFE i use it in my Addons too.' +
    'Go to <b>BASS''s</b> web site and dowloading for <b><font color="#ff63cbfc">free</font></b>. It is worth it.';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].Visible := True;

  mainScene.Config.Main.R.Info.Credits.Paragraphs[1] := TALText.Create(mainScene.Config.Main.R.Info.Credits.Right_Box[1, 0]);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].Name := 'Main_Config_Info_Credits_Parag_1';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].Parent := mainScene.Config.Main.R.Info.Credits.Right_Box[1, 0];
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].SetBounds(10, 100, mainScene.Config.Main.R.Info.Credits.Right_Box[1, 0].Width - 20, 140);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].TextSettings.Font.Size := 14;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].WordWrap := True;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].Text := '   BASS is an audio library for use in software on several platforms. ' +
    ' Its purpose is to provide developers with powerful and efficient sample, stream (MP3, MP2, MP1, OGG, WAV, AIFF, custom generated, ' +
    'and more via OS codecs and add-ons), MOD music (XM, IT, S3M, MOD, MTM, UMX), MO3 music (MP3/OGG compressed MODs), and recording functions.' +
    ' All in a compact DLL that won''t bloat your distribution. ';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].Visible := True;
end;

procedure Show_PasVlc;
begin
  mainScene.Config.Main.R.Info.Credits.Right_Box[1, 1] := TVertScrollBox.Create(mainScene.Config.Main.R.Info.Credits.Tab_Item[1]);
  mainScene.Config.Main.R.Info.Credits.Right_Box[1, 1].Name := 'Main_Config_Info_Credits_VBox_Right';
  mainScene.Config.Main.R.Info.Credits.Right_Box[1, 1].Parent := mainScene.Config.Main.R.Info.Credits.Tab_Item[1];
  mainScene.Config.Main.R.Info.Credits.Right_Box[1, 1].SetBounds(120, 0, mainScene.Config.Main.R.Info.Credits.Control.Width - 120,
    mainScene.Config.Main.R.Info.Credits.Control.Height - 24);
  mainScene.Config.Main.R.Info.Credits.Right_Box[1, 1].Visible := True;

  mainScene.Config.Main.R.Info.Credits.Paragraphs[0] := TALText.Create(mainScene.Config.Main.R.Info.Credits.Right_Box[1, 1]);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].Name := 'Main_Config_Info_Credits_Parag_0';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].Parent := mainScene.Config.Main.R.Info.Credits.Right_Box[1, 1];
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].SetBounds(10, 10, mainScene.Config.Main.R.Info.Credits.Right_Box[1, 1].Width - 20, 100);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].TextSettings.Font.Size := 14;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].TextIsHtml := True;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].WordWrap := True;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].Text :=
    '   <b><font color="#ff63cbfc">ExtraFE</font></b> uses <font color="#f21212">"PasLibVlc"</font> as the main video encoder/decoder library.' +
    'The library is free. It is very powerfull, easy, and use the libvlc.dll to provide video.' +
    'Go to <b>PasLibVlc''s</b> web site and dowloading for <b><font color="#ff63cbfc">free</font></b>. Use it to make your own video player.';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[0].Visible := True;

  mainScene.Config.Main.R.Info.Credits.Paragraphs[1] := TALText.Create(mainScene.Config.Main.R.Info.Credits.Right_Box[1, 1]);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].Name := 'Main_Config_Info_Credits_Parag_1';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].Parent := mainScene.Config.Main.R.Info.Credits.Right_Box[1, 1];
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].SetBounds(10, 100, mainScene.Config.Main.R.Info.Credits.Right_Box[1, 1].Width - 20, 80);
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].TextSettings.Font.Size := 14;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].WordWrap := True;
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].Text :=
    '   PasLibVlc is interface to VideoLAN libvlc.dll and VCL player component for Delphi / FreePascal based on VideoLAN. ' +
    ' Note: libvlc.dll is part of project VideoLAN. For more information please visit VideoLAN site.';
  mainScene.Config.Main.R.Info.Credits.Paragraphs[1].Visible := True;
end;

end.
