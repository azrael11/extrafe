unit uMain_Config_Addons_AzPlay;

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
procedure Free;

{ Actions }
// Activate
procedure Activate;

procedure Show_Select_Message;
procedure Free_Select_Message;

procedure Fresh_Start(vFresh: Boolean);

// Deactivate
procedure Deactivate;

procedure Show_D_Select_Message;

implementation

uses
  uMain_AllTypes,
  uLoad_AllTypes,
  uDB_AUser, uDB;

procedure Show(vIndex: Integer);
begin
  mainScene.Config.main.R.Addons.Icons_Info[4].Header := TLabel.Create(mainScene.Config.main.R.Addons.Icons_Panel[4]);
  mainScene.Config.main.R.Addons.Icons_Info[4].Header.Name := 'Main_Config_Addons_Addon_Playr_Header';
  mainScene.Config.main.R.Addons.Icons_Info[4].Header.Parent := mainScene.Config.main.R.Addons.Icons_Panel[4];
  mainScene.Config.main.R.Addons.Icons_Info[4].Header.SetBounds(10, 20, 300, 28);
  mainScene.Config.main.R.Addons.Icons_Info[4].Header.Text := 'This addon is : ';
  mainScene.Config.main.R.Addons.Icons_Info[4].Header.Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[4].Activeted := TText.Create(mainScene.Config.main.R.Addons.Icons_Panel[4]);
  mainScene.Config.main.R.Addons.Icons_Info[4].Activeted.Name := 'Main_Config_Addons_Addon_Play_Active';
  mainScene.Config.main.R.Addons.Icons_Info[4].Activeted.Parent := mainScene.Config.main.R.Addons.Icons_Panel[4];
  mainScene.Config.main.R.Addons.Icons_Info[4].Activeted.SetBounds(90, 20, 200, 28);
  mainScene.Config.main.R.Addons.Icons_Info[4].Activeted.TextSettings.HorzAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[4].Activeted.Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[4].TextBox := TVertScrollBox.Create(mainScene.Config.main.R.Addons.Icons_Panel[4]);
  mainScene.Config.main.R.Addons.Icons_Info[4].TextBox.Name := 'Main_Config_Addons_Addon_Play_TextBox';
  mainScene.Config.main.R.Addons.Icons_Info[4].TextBox.Parent := mainScene.Config.main.R.Addons.Icons_Panel[4];
  mainScene.Config.main.R.Addons.Icons_Info[4].TextBox.SetBounds(10, 50, mainScene.Config.main.R.Addons.Icons_Panel[4].Width - 20,
    mainScene.Config.main.R.Addons.Icons_Panel[4].Height - 100);
  mainScene.Config.main.R.Addons.Icons_Info[4].TextBox.Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[0] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[4].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[0].Name := 'Main_Config_Addons_Play_Paragraph_' + IntToStr(0);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[0].Parent := mainScene.Config.main.R.Addons.Icons_Info[4].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[0].SetBounds(10, 10, mainScene.Config.main.R.Addons.Icons_Info[4].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[0].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[0].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[0].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[0].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[0].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[0].Text := ' This addon provide some small but addictive games.';
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[0].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[1] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[4].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[1].Name := 'Main_Config_Addons_Play_Paragraph_' + IntToStr(1);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[1].Parent := mainScene.Config.main.R.Addons.Icons_Info[4].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[1].SetBounds(10, 30, mainScene.Config.main.R.Addons.Icons_Info[4].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[1].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[1].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[1].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[1].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[1].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[1].Text := ' All games for now is under contruction. <b>WIP</b>';
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[1].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[2] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[4].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[2].Name := 'Main_Config_Addons_Play_Paragraph_' + IntToStr(2);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[2].Parent := mainScene.Config.main.R.Addons.Icons_Info[4].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[2].SetBounds(10, 50, mainScene.Config.main.R.Addons.Icons_Info[4].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[2].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[2].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[2].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[2].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[2].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[2].Text := ' The addon games are :';
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[2].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[3] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[4].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[3].Name := 'Main_Config_Addons_Play_Paragraph_' + IntToStr(3);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[3].Parent := mainScene.Config.main.R.Addons.Icons_Info[4].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[3].SetBounds(10, 70, mainScene.Config.main.R.Addons.Icons_Info[4].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[3].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[3].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[3].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[3].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[3].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[3].Text := ' <font color="#fff21212">*</font> AzHung : A hangman style game. <b>WIP</b>';
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[3].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[4] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[4].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[4].Name := 'Main_Config_Addons_Play_Paragraph_' + IntToStr(4);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[4].Parent := mainScene.Config.main.R.Addons.Icons_Info[4].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[4].SetBounds(10, 90, mainScene.Config.main.R.Addons.Icons_Info[4].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[4].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[4].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[4].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[4].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[4].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[4].Text := ' <font color="#fff21212">*</font> AzMatch : A matching tile style game. <b>WIP</b>';
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[4].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[5] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[4].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[5].Name := 'Main_Config_Addons_Play_Paragraph_' + IntToStr(5);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[5].Parent := mainScene.Config.main.R.Addons.Icons_Info[4].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[5].SetBounds(10, 110, mainScene.Config.main.R.Addons.Icons_Info[4].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[5].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[5].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[5].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[5].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[5].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[5].Text := ' <font color="#fff21212">*</font> AzOng : A pong style game. <b>WIP</b>';
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[5].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[6] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[4].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[6].Name := 'Main_Config_Addons_Play_Paragraph_' + IntToStr(6);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[6].Parent := mainScene.Config.main.R.Addons.Icons_Info[4].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[6].SetBounds(10, 130, mainScene.Config.main.R.Addons.Icons_Info[4].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[6].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[6].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[6].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[6].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[6].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[6].Text := ' <font color="#fff21212">*</font> AzSuko : A sudoku style game. <b>WIP</b>';
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[6].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[7] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[4].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[7].Name := 'Main_Config_Addons_Play_Paragraph_' + IntToStr(7);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[7].Parent := mainScene.Config.main.R.Addons.Icons_Info[4].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[7].SetBounds(10, 150, mainScene.Config.main.R.Addons.Icons_Info[4].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[7].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[7].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[7].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[7].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[7].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[7].Text := ' <font color="#fff21212">*</font> AzType : A typing style game. <b>WIP</b>';
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[7].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[8] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[4].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[8].Name := 'Main_Config_Addons_Play_Paragraph_' + IntToStr(8);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[8].Parent := mainScene.Config.main.R.Addons.Icons_Info[4].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[8].SetBounds(10, 180, mainScene.Config.main.R.Addons.Icons_Info[4].TextBox.Width - 40, 60);
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[8].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[8].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[8].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[8].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[8].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[8].Text :=
    ' <font color="#fff21212">Note : </font>For global scoring and some features must have an active internet connection.';
  mainScene.Config.main.R.Addons.Icons_Info[4].Paragraphs[8].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[4].Athour := TLabel.Create(mainScene.Config.main.R.Addons.Icons_Panel[4]);
  mainScene.Config.main.R.Addons.Icons_Info[4].Athour.Name := 'Main_Config_Addons_Addon_Play_Author';
  mainScene.Config.main.R.Addons.Icons_Info[4].Athour.Parent := mainScene.Config.main.R.Addons.Icons_Panel[4];
  mainScene.Config.main.R.Addons.Icons_Info[4].Athour.SetBounds(10, mainScene.Config.main.R.Addons.Icons_Panel[4].Height - 40, 300, 28);
  mainScene.Config.main.R.Addons.Icons_Info[4].Athour.Text := 'Creator: Nikos Kordas';
  mainScene.Config.main.R.Addons.Icons_Info[4].Athour.Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[4].Action := TButton.Create(mainScene.Config.main.R.Addons.Icons_Panel[4]);
  mainScene.Config.main.R.Addons.Icons_Info[4].Action.Name := 'Main_Config_Addons_Addon_Play_Action';
  mainScene.Config.main.R.Addons.Icons_Info[4].Action.Parent := mainScene.Config.main.R.Addons.Icons_Panel[4];
  mainScene.Config.main.R.Addons.Icons_Info[4].Action.SetBounds(mainScene.Config.main.R.Addons.Icons_Panel[4].Width - 160,
    mainScene.Config.main.R.Addons.Icons_Panel[4].Height - 40, 150, 30);
  mainScene.Config.main.R.Addons.Icons_Info[4].Action.OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
  mainScene.Config.main.R.Addons.Icons_Info[4].Action.OnMouseEnter := ex_main.input.mouse_config.Button.OnMouseEnter;
  mainScene.Config.main.R.Addons.Icons_Info[4].Action.Visible := True;

  if uDB_AUser.Local.Addons.AzPlay then
  begin
    mainScene.Config.main.R.Addons.Icons_Info[4].Activeted.Text := 'Active';
    mainScene.Config.main.R.Addons.Icons_Info[4].Activeted.Color := TAlphaColorRec.Lime;
    mainScene.Config.main.R.Addons.Icons_Info[4].Action.Text := 'Deactivate'
  end
  else
  begin
    mainScene.Config.main.R.Addons.Icons_Info[4].Activeted.Text := 'Inactive';
    mainScene.Config.main.R.Addons.Icons_Info[4].Activeted.Color := TAlphaColorRec.Red;
    mainScene.Config.main.R.Addons.Icons_Info[4].Action.Text := 'Activate';
  end;
end;

{ Actions }
// Activate
procedure Activate;
begin

end;

procedure Show_Select_Message;
begin

end;

procedure Free_Select_Message;
begin
  extrafe.prog.State := 'main_config';
  mainScene.Config.main.Left_Blur.Enabled := False;
  mainScene.Config.main.R.Addons.Panel_Blur.Enabled := False;
end;

procedure Fresh_Start(vFresh: Boolean);
begin
  Inc(uDB_AUser.Local.Addons.Active, 1);
  uDB_AUser.Local.Addons.AzPlay := True;
  uDB_AUser.Local.Addons.Azplay_D.Menu_Position := uDB_AUser.Local.Addons.Active;

  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDONS', 'ACTIVE', uDB_AUser.Local.Addons.Active.ToString, 'USER_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDONS', 'AZPLAY', '1', 'USER_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDON_AZPLAY', 'MENU_POSITION', uDB_AUser.Local.Addons.Azplay_D.Menu_Position.ToString, 'USER_ID',
    uDB_AUser.Local.USER.Num.ToString);

  mainScene.Config.main.R.Addons.Icons_Info[4].Activeted.Text := 'Active';
  mainScene.Config.main.R.Addons.Icons_Info[4].Activeted.Color := TAlphaColorRec.Lime;
  mainScene.Config.main.R.Addons.Icons_Info[4].Action.Text := 'Deactivate';
  Addons.Active_PosNames[Addons.play.Main_Menu_Position] := 'play';
end;

// Deactivate
procedure Deactivate;
begin

end;

procedure Show_D_Select_Message;
begin

end;

procedure Free;
begin

end;

end.
