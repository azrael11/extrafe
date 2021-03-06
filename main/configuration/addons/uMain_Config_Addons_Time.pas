unit uMain_Config_Addons_Time;

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
  mainScene.Config.main.R.Addons.Icons_Info[0].Header := TLabel.Create(mainScene.Config.main.R.Addons.Icons_Panel[0]);
  mainScene.Config.main.R.Addons.Icons_Info[0].Header.Name := 'Main_Config_Addons_Addon_Time_Header';
  mainScene.Config.main.R.Addons.Icons_Info[0].Header.Parent := mainScene.Config.main.R.Addons.Icons_Panel[0];
  mainScene.Config.main.R.Addons.Icons_Info[0].Header.SetBounds(10, 20, 300, 28);
  mainScene.Config.main.R.Addons.Icons_Info[0].Header.Text := 'This addon is : ';
  mainScene.Config.main.R.Addons.Icons_Info[0].Header.Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[0].Activeted := TText.Create(mainScene.Config.main.R.Addons.Icons_Panel[0]);
  mainScene.Config.main.R.Addons.Icons_Info[0].Activeted.Name := 'Main_Config_Addons_Addon_Time_Active';
  mainScene.Config.main.R.Addons.Icons_Info[0].Activeted.Parent := mainScene.Config.main.R.Addons.Icons_Panel[0];
  mainScene.Config.main.R.Addons.Icons_Info[0].Activeted.SetBounds(90, 20, 200, 28);
  mainScene.Config.main.R.Addons.Icons_Info[0].Activeted.Color := TAlphaColorRec.Lime;
  mainScene.Config.main.R.Addons.Icons_Info[0].Activeted.Text := 'Active';
  mainScene.Config.main.R.Addons.Icons_Info[0].Activeted.TextSettings.HorzAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[0].Activeted.Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[0].TextBox := TVertScrollBox.Create(mainScene.Config.main.R.Addons.Icons_Panel[0]);
  mainScene.Config.main.R.Addons.Icons_Info[0].TextBox.Name := 'Main_Config_Addons_Addon_Time_TextBox';
  mainScene.Config.main.R.Addons.Icons_Info[0].TextBox.Parent := mainScene.Config.main.R.Addons.Icons_Panel[0];
  mainScene.Config.main.R.Addons.Icons_Info[0].TextBox.SetBounds(10, 50, mainScene.Config.main.R.Addons.Icons_Panel[0].Width - 20,
    mainScene.Config.main.R.Addons.Icons_Panel[0].Height - 100);
  mainScene.Config.main.R.Addons.Icons_Info[0].TextBox.Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[0] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[0].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[0].Name := 'Main_Config_Addons_Time_Paragraph_' + IntToStr(0);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[0].Parent := mainScene.Config.main.R.Addons.Icons_Info[0].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[0].SetBounds(10, 10, mainScene.Config.main.R.Addons.Icons_Info[0].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[0].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[0].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[0].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[0].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[0].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[0].Text :=
    ' This addon is <font color="#ff8de93a">enabled</font> by defalt. User can''t <b>deactivate</b> it.';
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[0].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[1] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[0].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[1].Name := 'Main_Config_Addons_Time_Paragraph_' + IntToStr(1);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[1].Parent := mainScene.Config.main.R.Addons.Icons_Info[0].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[1].SetBounds(10, 30, mainScene.Config.main.R.Addons.Icons_Info[0].TextBox.Width - 40, 60);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[1].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[1].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[1].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[1].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[1].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[1].Text :=
    ' It provides the user information about time <b>local</b> and <b>global</b>, user can add <b>alarm clocks</b> for any task, user olso use the <b>timer</b> or the <b>watch clock</b> to count rounds or everything else she/he wants.';
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[1].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[2] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[0].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[2].Name := 'Main_Config_Addons_Time_Paragraph_' + IntToStr(2);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[2].Parent := mainScene.Config.main.R.Addons.Icons_Info[0].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[2].SetBounds(10, 88, mainScene.Config.main.R.Addons.Icons_Info[0].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[2].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[2].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[2].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[2].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[2].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[2].Text := ' It has <font color="#fff21212">five</font> subcategories.';
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[2].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[3] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[0].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[3].Name := 'Main_Config_Addons_Time_Paragraph_' + IntToStr(3);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[3].Parent := mainScene.Config.main.R.Addons.Icons_Info[0].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[3].SetBounds(10, 108, mainScene.Config.main.R.Addons.Icons_Info[0].TextBox.Width - 40, 60);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[3].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[3].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[3].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[3].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[3].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[3].Text :=
    ' <font color="#fff21212">*</font> Clock: User can see time in two forms <b><font color="#ff63cbfc">analog</font></b> and <b><font color="#ff63cbfc">digital</font></b>.'
    + 'User can make changes of the feel and look of clocks or select from the defaults themes.';
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[3].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[4] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[0].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[4].Name := 'Main_Config_Addons_Time_Paragraph_' + IntToStr(4);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[4].Parent := mainScene.Config.main.R.Addons.Icons_Info[0].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[4].SetBounds(10, 148, mainScene.Config.main.R.Addons.Icons_Info[0].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[4].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[4].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[4].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[4].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[4].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[4].Text := ' <font color="#fff21212">*</font> Alarm: This is <b>WIP</b>.';
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[4].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[5] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[0].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[5].Name := 'Main_Config_Addons_Time_Paragraph_' + IntToStr(5);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[5].Parent := mainScene.Config.main.R.Addons.Icons_Info[0].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[5].SetBounds(10, 168, mainScene.Config.main.R.Addons.Icons_Info[0].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[5].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[5].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[5].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[5].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[5].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[5].Text := ' <font color="#fff21212">*</font> Timer: This is <b>WIP</b>.';
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[5].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[6] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[0].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[6].Name := 'Main_Config_Addons_Time_Paragraph_' + IntToStr(6);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[6].Parent := mainScene.Config.main.R.Addons.Icons_Info[0].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[6].SetBounds(10, 188, mainScene.Config.main.R.Addons.Icons_Info[0].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[6].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[6].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[6].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[6].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[6].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[6].Text := ' <font color="#fff21212">*</font> Stop Watch: This is <b>WIP</b>.';
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[6].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[7] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[0].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[7].Name := 'Main_Config_Addons_Time_Paragraph_' + IntToStr(7);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[7].Parent := mainScene.Config.main.R.Addons.Icons_Info[0].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[7].SetBounds(10, 208, mainScene.Config.main.R.Addons.Icons_Info[0].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[7].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[7].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[7].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[7].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[7].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[7].Text := ' <font color="#fff21212">*</font> World Clock: This is <b>WIP</b>.';
  mainScene.Config.main.R.Addons.Icons_Info[0].Paragraphs[7].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[0].Athour := TLabel.Create(mainScene.Config.main.R.Addons.Icons_Panel[0]);
  mainScene.Config.main.R.Addons.Icons_Info[0].Athour.Name := 'Main_Config_Addons_Addon_Time_Author';
  mainScene.Config.main.R.Addons.Icons_Info[0].Athour.Parent := mainScene.Config.main.R.Addons.Icons_Panel[0];
  mainScene.Config.main.R.Addons.Icons_Info[0].Athour.SetBounds(10, mainScene.Config.main.R.Addons.Icons_Panel[0].Height - 40, 300, 28);
  mainScene.Config.main.R.Addons.Icons_Info[0].Athour.Text := 'Creator: Nikos Kordas';
  mainScene.Config.main.R.Addons.Icons_Info[0].Athour.Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[0].Action := TButton.Create(mainScene.Config.main.R.Addons.Icons_Panel[0]);
  mainScene.Config.main.R.Addons.Icons_Info[0].Action.Name := 'Main_Config_Addons_Addon_Time_Action';
  mainScene.Config.main.R.Addons.Icons_Info[0].Action.Parent := mainScene.Config.main.R.Addons.Icons_Panel[0];
  mainScene.Config.main.R.Addons.Icons_Info[0].Action.SetBounds(mainScene.Config.main.R.Addons.Icons_Panel[0].Width - 160,
    mainScene.Config.main.R.Addons.Icons_Panel[0].Height - 40, 150, 30);
  mainScene.Config.main.R.Addons.Icons_Info[0].Action.Text := 'Nothing to do';
  mainScene.Config.main.R.Addons.Icons_Info[0].Action.Enabled := False;
  mainScene.Config.main.R.Addons.Icons_Info[0].Action.Visible := True;
end;

end.
