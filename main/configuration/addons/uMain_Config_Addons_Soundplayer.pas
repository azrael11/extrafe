unit uMain_Config_Addons_Soundplayer;

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
  uDB_AUser,
  uDB, uMain_SetAll, uMain_Config_Addons_Actions, uSoundplayer_AllTypes, BASS;

procedure Show(vIndex: Integer);
begin
  mainScene.Config.main.R.Addons.Icons_Info[3].Header := TLabel.Create(mainScene.Config.main.R.Addons.Icons_Panel[3]);
  mainScene.Config.main.R.Addons.Icons_Info[3].Header.Name := 'Main_Config_Addons_Addon_Soundplayer_Header';
  mainScene.Config.main.R.Addons.Icons_Info[3].Header.Parent := mainScene.Config.main.R.Addons.Icons_Panel[3];
  mainScene.Config.main.R.Addons.Icons_Info[3].Header.SetBounds(10, 20, 300, 28);
  mainScene.Config.main.R.Addons.Icons_Info[3].Header.Text := 'This addon is : ';
  mainScene.Config.main.R.Addons.Icons_Info[3].Header.Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Activeted := TText.Create(mainScene.Config.main.R.Addons.Icons_Panel[3]);
  mainScene.Config.main.R.Addons.Icons_Info[3].Activeted.Name := 'Main_Config_Addons_Addon_Soundplayer_Active';
  mainScene.Config.main.R.Addons.Icons_Info[3].Activeted.Parent := mainScene.Config.main.R.Addons.Icons_Panel[3];
  mainScene.Config.main.R.Addons.Icons_Info[3].Activeted.SetBounds(90, 20, 200, 28);
  mainScene.Config.main.R.Addons.Icons_Info[3].Activeted.TextSettings.HorzAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[3].Activeted.Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].TextBox := TVertScrollBox.Create(mainScene.Config.main.R.Addons.Icons_Panel[3]);
  mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Name := 'Main_Config_Addons_Addon_Soundplayer_TextBox';
  mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Parent := mainScene.Config.main.R.Addons.Icons_Panel[3];
  mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.SetBounds(10, 50, mainScene.Config.main.R.Addons.Icons_Panel[3].Width - 20,
    mainScene.Config.main.R.Addons.Icons_Panel[3].Height - 100);
  mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[0] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[3].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[0].Name := 'Main_Config_Addons_Soundplayer_Paragraph_' + IntToStr(0);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[0].Parent := mainScene.Config.main.R.Addons.Icons_Info[3].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[0].SetBounds(10, 10, mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[0].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[0].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[0].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[0].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[0].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[0].Text := ' This addon provide a simple but yet powerfull audio player.';
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[0].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[1] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[3].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[1].Name := 'Main_Config_Addons_Soundplayer_Paragraph_' + IntToStr(1);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[1].Parent := mainScene.Config.main.R.Addons.Icons_Info[3].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[1].SetBounds(10, 30, mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Width - 40, 60);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[1].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[1].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[1].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[1].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[1].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[1].Text :=
    ' The <font color="#ff63cbfc">soundplayer</font> addon is in early stages of development so it has many bugs and support of media files is limited via "<font color="#ff63cbfc">BASS audio Library</font>".';
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[1].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[2] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[3].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[2].Name := 'Main_Config_Addons_Soundplayer_Paragraph_' + IntToStr(2);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[2].Parent := mainScene.Config.main.R.Addons.Icons_Info[3].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[2].SetBounds(10, 70, mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[2].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[2].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[2].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[2].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[2].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[2].Text :=
    ' <font color="#ff63cbfc">Soundplayer</font> addon currently support or under development this audio file types.';
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[2].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[3] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[3].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[3].Name := 'Main_Config_Addons_Soundplayer_Paragraph_' + IntToStr(3);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[3].Parent := mainScene.Config.main.R.Addons.Icons_Info[3].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[3].SetBounds(10, 90, mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[3].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[3].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[3].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[3].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[3].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[3].Text :=
    ' <font color="#fff21212">*</font> Mp3 with full edit tags in both versions ID3v1 and ID3v2. Rating system.';
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[3].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[4] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[3].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[4].Name := 'Main_Config_Addons_Soundplayer_Paragraph_' + IntToStr(4);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[4].Parent := mainScene.Config.main.R.Addons.Icons_Info[3].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[4].SetBounds(10, 110, mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[4].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[4].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[4].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[4].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[4].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[4].Text := ' <font color="#fff21212">*</font> Ogg with full edit tags';
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[4].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[5] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[3].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[5].Name := 'Main_Config_Addons_Soundplayer_Paragraph_' + IntToStr(5);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[5].Parent := mainScene.Config.main.R.Addons.Icons_Info[3].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[5].SetBounds(10, 130, mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[5].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[5].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[5].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[5].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[5].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[5].Text := ' <font color="#fff21212">*</font> WAV <b>WIP</b>';
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[5].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[6] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[3].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[6].Name := 'Main_Config_Addons_Soundplayer_Paragraph_' + IntToStr(6);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[6].Parent := mainScene.Config.main.R.Addons.Icons_Info[3].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[6].SetBounds(10, 150, mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[6].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[6].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[6].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[6].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[6].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[6].Text := ' <font color="#fff21212">*</font> MP4 <b>WIP</b>';
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[6].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[7] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[3].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[7].Name := 'Main_Config_Addons_Soundplayer_Paragraph_' + IntToStr(7);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[7].Parent := mainScene.Config.main.R.Addons.Icons_Info[3].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[7].SetBounds(10, 170, mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[7].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[7].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[7].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[7].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[7].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[7].Text := ' <font color="#fff21212">*</font> Flac <b>WIP</b>';
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[7].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[8] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[3].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[8].Name := 'Main_Config_Addons_Soundplayer_Paragraph_' + IntToStr(8);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[8].Parent := mainScene.Config.main.R.Addons.Icons_Info[3].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[8].SetBounds(10, 200, mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Width - 40, 60);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[8].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[8].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[8].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[8].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[8].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[8].Text :=
    ' <font color="#ff63cbfc">Soundplayer</font> addon currently support or under development this playlist file types.';
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[8].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[9] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[3].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[9].Name := 'Main_Config_Addons_Soundplayer_Paragraph_' + IntToStr(9);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[9].Parent := mainScene.Config.main.R.Addons.Icons_Info[3].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[9].SetBounds(10, 220, mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[9].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[9].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[9].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[9].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[9].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[9].Text :=
    ' <font color="#fff21212">*</font> M3U, can create, remove, edit supported to other soundplayers apps';
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[9].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[10] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[3].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[10].Name := 'Main_Config_Addons_Soundplayer_Paragraph_' + IntToStr(10);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[10].Parent := mainScene.Config.main.R.Addons.Icons_Info[3].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[10].SetBounds(10, 240, mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[10].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[10].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[10].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[10].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[10].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[10].Text := ' <font color="#fff21212">*</font> PLS <b>WIP</b>';
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[10].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[11] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[3].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[11].Name := 'Main_Config_Addons_Soundplayer_Paragraph_' + IntToStr(11);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[11].Parent := mainScene.Config.main.R.Addons.Icons_Info[3].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[11].SetBounds(10, 260, mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[11].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[11].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[11].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[11].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[11].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[11].Text := ' <font color="#fff21212">*</font> ASX <b>WIP</b>';
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[11].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[12] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[3].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[12].Name := 'Main_Config_Addons_Soundplayer_Paragraph_' + IntToStr(12);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[12].Parent := mainScene.Config.main.R.Addons.Icons_Info[3].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[12].SetBounds(10, 280, mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[12].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[12].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[12].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[12].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[12].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[12].Text := ' <font color="#fff21212">*</font> WPL <b>WIP</b>';
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[12].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[13] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[3].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[13].Name := 'Main_Config_Addons_Soundplayer_Paragraph_' + IntToStr(13);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[13].Parent := mainScene.Config.main.R.Addons.Icons_Info[3].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[13].SetBounds(10, 300, mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[13].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[13].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[13].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[13].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[13].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[13].Text := ' <font color="#fff21212">*</font> XSPF <b>WIP</b>';
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[13].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[14] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[3].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[14].Name := 'Main_Config_Addons_Soundplayer_Paragraph_' + IntToStr(14);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[14].Parent := mainScene.Config.main.R.Addons.Icons_Info[3].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[14].SetBounds(10, 320, mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Width - 40, 30);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[14].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[14].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[14].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[14].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[14].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[14].Text := ' <font color="#fff21212">*</font> EXPL <b>WIP</b>';
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[14].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[15] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[3].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[15].Name := 'Main_Config_Addons_Soundplayer_Paragraph_' + IntToStr(15);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[15].Parent := mainScene.Config.main.R.Addons.Icons_Info[3].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[15].SetBounds(10, 340, mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Width - 40, 60);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[15].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[15].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[15].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[15].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[15].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[15].Text :=
    '<font color="#fff21212"> NEW </font> Now you can remove add change places and positions for the playlists and the songs inside them';
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[15].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[16] := TALText.Create(mainScene.Config.main.R.Addons.Icons_Info[3].TextBox);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[16].Name := 'Main_Config_Addons_Soundplayer_Paragraph_' + IntToStr(16);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[16].Parent := mainScene.Config.main.R.Addons.Icons_Info[3].TextBox;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[16].SetBounds(10, 380, mainScene.Config.main.R.Addons.Icons_Info[3].TextBox.Width - 40, 60);
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[16].WordWrap := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[16].TextIsHtml := True;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[16].TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[16].TextSettings.Font.Size := 14;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[16].TextSettings.VertAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[16].Text :=
    ' To start you only need to create a playlist and add audio files in it. In this time no need for internet connection but soon it automatically download files like covers, lyrics, fan arts etc.';
  mainScene.Config.main.R.Addons.Icons_Info[3].Paragraphs[16].Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Athour := TLabel.Create(mainScene.Config.main.R.Addons.Icons_Panel[3]);
  mainScene.Config.main.R.Addons.Icons_Info[3].Athour.Name := 'Main_Config_Addons_Addon_Soundplayer_Author';
  mainScene.Config.main.R.Addons.Icons_Info[3].Athour.Parent := mainScene.Config.main.R.Addons.Icons_Panel[3];
  mainScene.Config.main.R.Addons.Icons_Info[3].Athour.SetBounds(10, mainScene.Config.main.R.Addons.Icons_Panel[3].Height - 40, 300, 28);
  mainScene.Config.main.R.Addons.Icons_Info[3].Athour.Text := 'Creator: Nikos Kordas';
  mainScene.Config.main.R.Addons.Icons_Info[3].Athour.Visible := True;

  mainScene.Config.main.R.Addons.Icons_Info[3].Action := TButton.Create(mainScene.Config.main.R.Addons.Icons_Panel[3]);
  mainScene.Config.main.R.Addons.Icons_Info[3].Action.Name := 'Main_Config_Addons_Addon_Soundplayer_Action';
  mainScene.Config.main.R.Addons.Icons_Info[3].Action.Parent := mainScene.Config.main.R.Addons.Icons_Panel[3];
  mainScene.Config.main.R.Addons.Icons_Info[3].Action.SetBounds(mainScene.Config.main.R.Addons.Icons_Panel[3].Width - 160,
    mainScene.Config.main.R.Addons.Icons_Panel[3].Height - 40, 150, 30);
  mainScene.Config.main.R.Addons.Icons_Info[3].Action.OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
  mainScene.Config.main.R.Addons.Icons_Info[3].Action.OnMouseEnter := ex_main.input.mouse_config.Button.OnMouseEnter;
  mainScene.Config.main.R.Addons.Icons_Info[3].Action.Visible := True;

  if uDB_AUser.Local.Addons.Soundplayer then
  begin
    mainScene.Config.main.R.Addons.Icons_Info[3].Activeted.Text := 'Active';
    mainScene.Config.main.R.Addons.Icons_Info[3].Activeted.Color := TAlphaColorRec.Lime;
    mainScene.Config.main.R.Addons.Icons_Info[3].Action.Text := 'Deactivate'
  end
  else
  begin
    mainScene.Config.main.R.Addons.Icons_Info[3].Activeted.Text := 'Inactive';
    mainScene.Config.main.R.Addons.Icons_Info[3].Activeted.Color := TAlphaColorRec.Red;
    mainScene.Config.main.R.Addons.Icons_Info[3].Action.Text := 'Activate';
  end;
end;

procedure Activate;
begin

  // if mainScene.Config.main.R.addons.soundplayer.Msg_Actv.main.Radio_2.IsChecked then
  // begin
  // Soundplayer_Activate_FreshStart(True)
  // end
  // else
  uMain_Config_Addons_Soundplayer.Fresh_Start(True);
  uMain_Config_Addons_Soundplayer.Free_Select_Message;
end;

procedure Show_Select_Message;
begin
  extrafe.prog.State := 'main_config_addons_actions';
  mainScene.Config.main.Left_Blur.Enabled := True;
  mainScene.Config.main.R.Addons.Panel_Blur.Enabled := True;

  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.Panel := TPanel.Create(mainScene.Config.Panel);
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.Panel.Name := 'Main_Config_Addons_Soundplayer_Activate_Msg';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.Panel.Parent := mainScene.Config.Panel;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.Panel.Width := 500;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.Panel.Height := 200;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.Panel.Position.X := (mainScene.Config.Panel.Width / 2) - 150;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.Panel.Position.Y := (mainScene.Config.Panel.Height / 2) - 100;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.Panel.Visible := True;

  CreateHeader(mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.Panel, 'IcoMoon-Free', #$e997, TAlphaColorRec.Deepskyblue, 'Activate Soundplayer addon',
    False, nil);

  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel := TPanel.Create(mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.Panel);
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel.Name := 'Main_Config_Addons_Soundplayer_Activate_Msg_Main';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel.Parent := mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.Panel;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel.Width := mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.Panel.Width;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel.Height := mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.Panel.Height - 30;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel.Position.X := 0;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel.Position.Y := 30;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel.Visible := True;

  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Text := TLabel.Create(mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel);
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Text.Name := 'Main_Config_Addons_Soundplayer_Activate_Msg_Main_Text';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Text.Parent := mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Text.Width := 400;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Text.Height := 24;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Text.Position.X := 50;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Text.Position.Y := 30;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Text.Text := 'Found old configuration and playlists do you want to use this one?';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Text.Font.Style := mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Text.Font.Style +
    [TFontStyle.fsBold];
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Text.Visible := True;

  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_1 := TRadioButton.Create(mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel);
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_1.Name := 'Main_Config_Addons_Soundplayer_Activate_Msg_Main_Radio_1';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_1.Parent := mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_1.Width := 300;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_1.Height := 24;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_1.Position.X := 100;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_1.Position.Y := 60;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_1.Text := 'Yes load my old playlists.';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_1.OnClick := ex_main.input.mouse_config.Radio.OnMouseClick;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_1.Visible := True;

  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_2 := TRadioButton.Create(mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel);
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_2.Name := 'Main_Config_Addons_Soundplayer_Activate_Msg_Main_Radio_2';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_2.Parent := mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_2.Width := 300;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_2.Height := 24;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_2.Position.X := 100;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_2.Position.Y := 90;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_2.Text := 'Lets create a new ones and rock.';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_2.OnClick := ex_main.input.mouse_config.Radio.OnMouseClick;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Radio_2.Visible := True;

  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.OK := TButton.Create(mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel);
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.OK.Name := 'Main_Config_Addons_Soundplayer_Activate_Msg_Main_OK';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.OK.Parent := mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.OK.Width := 100;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.OK.Height := 26;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.OK.Position.X := 50;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.OK.Position.Y := mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel.Height - 36;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.OK.Text := 'Activate';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.OK.OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.OK.Enabled := False;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.OK.Visible := True;

  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Cancel := TButton.Create(mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel);
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Cancel.Name := 'Main_Config_Addons_Soundplayer_Activate_Msg_Main_Cancel';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Cancel.Parent := mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Cancel.Width := 100;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Cancel.Height := 26;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Cancel.Position.X := mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel.Width - 150;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Cancel.Position.Y := mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Panel.Height - 36;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Cancel.Text := 'Cancel';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Cancel.OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.main.Cancel.Visible := True;

end;

procedure Free_Select_Message;
begin
  extrafe.prog.State := 'main_config';
  mainScene.Config.main.Left_Blur.Enabled := False;
  mainScene.Config.main.R.Addons.Panel_Blur.Enabled := False;
  FreeAndNil(mainScene.Config.main.R.Addons.Soundplayer.Msg_Actv.Panel);
end;

procedure Fresh_Start(vFresh: Boolean);
begin
  Inc(uDB_AUser.Local.Addons.Active, 1);
  uDB_AUser.Local.Addons.Soundplayer := True;
  uDB_AUser.Local.Addons.Soundplayer_D.Menu_Position := uDB_AUser.Local.Addons.Active;
  uDB_AUser.Local.Addons.Soundplayer_D.First_Pop := True;
  uDB_AUser.Local.Addons.Soundplayer_D.Volume := 80;
  uDB_AUser.Local.Addons.Soundplayer_D.Last_Visit := DateTimeToStr(now);
  uDB_AUser.Local.Addons.Soundplayer_D.Last_Play_Song_Num := -1;
  uDB_AUser.Local.Addons.Soundplayer_D.Last_Playlist_Num := -1;
  uDB_AUser.Local.Addons.Soundplayer_D.Playlist_Count := -1;
  uDB_AUser.Local.Addons.Soundplayer_D.Total_Play_Click := -1;
  uDB_AUser.Local.Addons.Soundplayer_D.Total_Play_Time := '00:00:00';

  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDONS', 'ACTIVE', uDB_AUser.Local.Addons.Active.ToString, 'USER_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDONS', 'SOUNDPLAYER', '1', 'USER_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDON_SOUNDPLAYER', 'MENU_POSITION', uDB_AUser.Local.Addons.Soundplayer_D.Menu_Position.ToString, 'USER_ID',
    uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDON_SOUNDPLAYER', 'FIRST_POP', '0', 'USER_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDON_SOUNDPLAYER', 'VOLUME', uDB_AUser.Local.Addons.Soundplayer_D.Volume.ToString, 'USER_ID',
    uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDON_SOUNDPLAYER', 'LAST_VISIT', uDB_AUser.Local.Addons.Soundplayer_D.Last_Visit, 'USER_ID',
    uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDON_SOUNDPLAYER', 'LAST_PLAY_SONG_NUM', uDB_AUser.Local.Addons.Soundplayer_D.Last_Play_Song_Num.ToString,
    'USER_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDON_SOUNDPLAYER', 'LAST_PLAYLIST_NUM', uDB_AUser.Local.Addons.Soundplayer_D.Last_Playlist_Num.ToString,
    'USER_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDON_SOUNDPLAYER', 'PLAYLIST_COUNT', uDB_AUser.Local.Addons.Soundplayer_D.Playlist_Count.ToString, 'USER_ID',
    uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDON_SOUNDPLAYER', 'TOTAL_PLAY_CLICK', uDB_AUser.Local.Addons.Soundplayer_D.Total_Play_Click.ToString, 'USER_ID',
    uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDON_SOUNDPLAYER', 'TOTAL_PLAY_TIME', uDB_AUser.Local.Addons.Soundplayer_D.Total_Play_Time, 'USER_ID',
    uDB_AUser.Local.USER.Num.ToString);

  mainScene.Config.main.R.Addons.Icons_Info[3].Activeted.Text := 'Active';
  mainScene.Config.main.R.Addons.Icons_Info[3].Activeted.Color := TAlphaColorRec.Lime;
  mainScene.Config.main.R.Addons.Icons_Info[3].Action.Text := 'Deactivate';

  uMain_SetAll.Addon_Icon(uDB_AUser.Local.Addons.Soundplayer_D.Menu_Position);
  uDB_AUser.Local.Addons.Names[uDB_AUser.Local.Addons.Soundplayer_D.Menu_Position] := 'soundplayer';
  mainScene.Header.Addon_Icon.Icons[uDB_AUser.Local.Addons.Soundplayer_D.Menu_Position].Text := #$ea15;
end;

// Deactivate
procedure Deactivate;
begin
  uMain_Config_Addons_Actions.Set_Icons(uDB_AUser.Local.Addons.Soundplayer_D.Menu_Position);

  Dec(uDB_AUser.Local.Addons.Active, 1);
  uDB_AUser.Local.Addons.Soundplayer := False;
  uDB_AUser.Local.Addons.Soundplayer_D.Menu_Position := -1;

  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDONS', 'ACTIVE', uDB_AUser.Local.Addons.Active.ToString, 'USER_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDONS', 'SOUNDPLAYER', '0', 'USER_ID', uDB_AUser.Local.USER.Num.ToString);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDON_SOUNDPLAYER', 'MENU_POSITION', '-1', 'USER_ID', uDB_AUser.Local.USER.Num.ToString);

  mainScene.Config.main.R.Addons.Icons_Info[3].Activeted.Text := 'Inactive';
  mainScene.Config.main.R.Addons.Icons_Info[3].Activeted.Color := TAlphaColorRec.Red;
  mainScene.Config.main.R.Addons.Icons_Info[3].Action.Text := 'Activate';
  if Assigned(mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_2) then
  begin
    if mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_2.IsChecked then
    begin
      // Delete playlist from database and set in addon_soundplayer the Playlist_Count to -1
      // DeleteFile(addons.soundplayer.ini.Path + addons.soundplayer.ini.Name);
      // uWindows_DeleteDirectory(addons.soundplayer.Path.Playlists, '*.*', False);
    end;
  end;
  if Soundplayer.player = sPlay then
  begin
    BASS_ChannelStop(sound.str_music[1]);
    BASS_StreamFree(sound.str_music[1]);
  end;
  Free;
end;

procedure Show_D_Select_Message;
begin
  extrafe.prog.State := 'main_config_addons_actions';
  mainScene.Config.main.Left_Blur.Enabled := True;
  mainScene.Config.main.R.Addons.Panel_Blur.Enabled := True;

  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.Panel := TPanel.Create(mainScene.Config.Panel);
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.Panel.Name := 'Main_Config_Addons_Soundplayer_Deactivate_Msg';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.Panel.Parent := mainScene.Config.Panel;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.Panel.Width := 500;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.Panel.Height := 200;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.Panel.Position.X := (mainScene.Config.Panel.Width / 2) - 150;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.Panel.Position.Y := (mainScene.Config.Panel.Height / 2) - 100;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.Panel.Visible := True;

  CreateHeader(mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.Panel, 'IcoMoon-Free', #$e996, TAlphaColorRec.Deepskyblue, 'Deactivate Soundplayer addon',
    False, nil);

  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel := TPanel.Create(mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.Panel);
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel.Name := 'Main_Config_Addons_Soundplayer_Deactivate_Msg_Main';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel.Parent := mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.Panel;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel.Width := mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.Panel.Width;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel.Height := mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.Panel.Height - 30;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel.Position.X := 0;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel.Position.Y := 30;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel.Visible := True;

  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Text := TLabel.Create(mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel);
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Text.Name := 'Main_Config_Addons_Soundplayer_Deactivate_Msg_Main_Text';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Text.Parent := mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Text.Width := 400;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Text.Height := 24;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Text.Position.X := 50;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Text.Position.Y := 30;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Text.Text := 'Do you want to keep the existance configuration and playlists?';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Text.Font.Style := mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Text.Font.Style +
    [TFontStyle.fsBold];
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Text.Visible := True;

  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_1 := TRadioButton.Create(mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel);
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_1.Name := 'Main_Config_Addons_Soundplayer_Deactivate_Msg_Main_Radio_1';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_1.Parent := mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_1.Width := 300;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_1.Height := 24;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_1.Position.X := 100;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_1.Position.Y := 60;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_1.Text := 'Yes keep it all.';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_1.OnClick := ex_main.input.mouse_config.Radio.OnMouseClick;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_1.Visible := True;

  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_2 := TRadioButton.Create(mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel);
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_2.Name := 'Main_Config_Addons_Soundplayer_Deactivate_Msg_Main_Radio_2';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_2.Parent := mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_2.Width := 300;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_2.Height := 24;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_2.Position.X := 100;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_2.Position.Y := 90;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_2.Text := 'I don''t want anything. Delete all.';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_2.OnClick := ex_main.input.mouse_config.Radio.OnMouseClick;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Radio_2.Visible := True;

  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.OK := TButton.Create(mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel);
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.OK.Name := 'Main_Config_Addons_Soundplayer_Deactivate_Msg_Main_OK';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.OK.Parent := mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.OK.Width := 100;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.OK.Height := 26;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.OK.Position.X := 50;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.OK.Position.Y := mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel.Height - 36;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.OK.Text := 'Deactivate';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.OK.OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.OK.Enabled := False;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.OK.Visible := True;

  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Cancel := TButton.Create(mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel);
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Cancel.Name := 'Main_Config_Addons_Soundplayer_Deactivate_Msg_Main_Cancel';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Cancel.Parent := mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Cancel.Width := 100;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Cancel.Height := 26;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Cancel.Position.X := mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel.Width - 150;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Cancel.Position.Y := mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Panel.Height - 36;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Cancel.Text := 'Cancel';
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Cancel.OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
  mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.main.Cancel.Visible := True;
end;

procedure Free;
begin
  extrafe.prog.State := 'main_config';
  mainScene.Config.main.Left_Blur.Enabled := False;
  mainScene.Config.main.R.Addons.Panel_Blur.Enabled := False;
  FreeAndNil(mainScene.Config.main.R.Addons.Soundplayer.Msg_Deactv.Panel);
end;

end.
