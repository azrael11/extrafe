unit uMain_Config_Addons_Calendar;

interface
uses
  System.Classes,
  System.SysUtils,
  System.UITypes,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Types,
  FMX.Layouts,
  ALFmxObjects;

procedure Show(vIndex: Integer);


implementation

uses
  uMain_AllTypes,
  uLoad_AllTypes,
  uDB_AUser;

procedure Show(vIndex: Integer);
begin
  mainScene.Config.main.R.Addons.Icons_Info[1].Header := TLabel.Create(mainScene.Config.main.R.Addons.Icons_Panel[1]);
  mainScene.Config.main.R.Addons.Icons_Info[1].Header.Name := 'Main_Config_Addons_Addon_Calendar_Header';
  mainScene.Config.main.R.Addons.Icons_Info[1].Header.Parent := mainScene.Config.main.R.Addons.Icons_Panel[1];
  mainScene.Config.main.R.Addons.Icons_Info[1].Header.SetBounds(10, 20, 300, 28);
  mainScene.Config.main.R.Addons.Icons_Info[1].Header.Text := 'This addon is : ';
  mainScene.Config.main.R.Addons.Icons_Info[1].Header.Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[1].Activeted := TText.Create(mainScene.Config.main.R.Addons.Icons_Panel[1]);
  mainScene.Config.main.R.Addons.Icons_Info[1].Activeted.Name := 'Main_Config_Addons_Addon_Calendar_Active';
  mainScene.Config.main.R.Addons.Icons_Info[1].Activeted.Parent := mainScene.Config.main.R.Addons.Icons_Panel[1];
  mainScene.Config.main.R.Addons.Icons_Info[1].Activeted.SetBounds(90, 20, 200, 28);
  mainScene.Config.main.R.Addons.Icons_Info[1].Activeted.Color := TAlphaColorRec.Lime;
  mainScene.Config.main.R.Addons.Icons_Info[1].Activeted.Text := 'Active';
  mainScene.Config.main.R.Addons.Icons_Info[1].Activeted.TextSettings.HorzAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[1].Activeted.Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[1].TextBox := TVertScrollBox.Create(mainScene.Config.main.R.Addons.Icons_Panel[1]);
  mainScene.Config.main.R.Addons.Icons_Info[1].TextBox.Name := 'Main_Config_Addons_Addon_Calendar_TextBox';
  mainScene.Config.main.R.Addons.Icons_Info[1].TextBox.Parent := mainScene.Config.main.R.Addons.Icons_Panel[1];
  mainScene.Config.main.R.Addons.Icons_Info[1].TextBox.SetBounds(10, 50, mainScene.Config.main.R.Addons.Icons_Panel[1].Width - 20,
    mainScene.Config.main.R.Addons.Icons_Panel[1].Height - 100);
  mainScene.Config.main.R.Addons.Icons_Info[1].TextBox.Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[0] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[1].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[0].Name := 'Main_Config_Addons_Calendar_Paragraph_' + IntToStr(0);
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[0].Parent := mainScene.Config.main.R.Addons.Icons_Info[1].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[0].SetBounds(10, 10, mainScene.Config.main.R.Addons.Icons_Info[1].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[0].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[0].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[0].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[0].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[0].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[0].Text :=
    ' This addon is <font color="#ff8de93a">enabled</font> by defalt. User can''t <b>deactivate</b> it.';
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[0].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[1] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[1].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[1].Name := 'Main_Config_Addons_Calendar_Paragraph_' + IntToStr(1);
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[1].Parent := mainScene.Config.main.R.Addons.Icons_Info[1].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[1].SetBounds(10, 30, mainScene.Config.main.R.Addons.Icons_Info[1].TextBox.Width - 40, 60);
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[1].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[1].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[1].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[1].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[1].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[1].Text := ' This addons is <b>WIP</b>.';
  mainScene.Config.main.R.Addons.Icons_Info[1].Paragraphs[1].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[1].Athour := TLabel.Create(mainScene.Config.main.R.Addons.Icons_Panel[1]);
  mainScene.Config.main.R.Addons.Icons_Info[1].Athour.Name := 'Main_Config_Addons_Addon_Calendar_Author';
  mainScene.Config.main.R.Addons.Icons_Info[1].Athour.Parent := mainScene.Config.main.R.Addons.Icons_Panel[1];
  mainScene.Config.main.R.Addons.Icons_Info[1].Athour.SetBounds(10, mainScene.Config.main.R.Addons.Icons_Panel[1].Height - 40, 300, 28);
  mainScene.Config.main.R.Addons.Icons_Info[1].Athour.Text := 'Creator: Nikos Kordas';
  mainScene.Config.main.R.Addons.Icons_Info[1].Athour.Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[1].Action := TButton.Create(mainScene.Config.main.R.Addons.Icons_Panel[1]);
  mainScene.Config.main.R.Addons.Icons_Info[1].Action.Name := 'Main_Config_Addons_Addon_Calendar_Action';
  mainScene.Config.main.R.Addons.Icons_Info[1].Action.Parent := mainScene.Config.main.R.Addons.Icons_Panel[1];
  mainScene.Config.main.R.Addons.Icons_Info[1].Action.SetBounds(mainScene.Config.main.R.Addons.Icons_Panel[1].Width - 160,
    mainScene.Config.main.R.Addons.Icons_Panel[1].Height - 40, 150, 30);
  mainScene.Config.main.R.Addons.Icons_Info[1].Action.Text := 'Nothing to do';
  mainScene.Config.main.R.Addons.Icons_Info[1].Action.Enabled := False;
  mainScene.Config.main.R.Addons.Icons_Info[1].Action.Visible := True;
end;

end.
