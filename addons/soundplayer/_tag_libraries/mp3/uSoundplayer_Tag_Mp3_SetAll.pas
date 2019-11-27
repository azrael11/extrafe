unit uSoundplayer_Tag_Mp3_SetAll;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UITypes,
  FMX.Objects,
  FMX.Dialogs,
  FMX.Grid,
  FMX.Effects,
  FMX.StdCtrls,
  FMX.Types,
  FMX.Ani,
  FMX.Filter.Effects,
  FMX.TabControl,
  FMX.Edit,
  FMX.ComboEdit,
  FMX.Memo,
  FMX.Listbox,
  FMX.Graphics,
  FMX.Layouts;

procedure Load;
procedure Free;

procedure Set_ID3v1_Frame;
procedure Set_ID3v2_Frame;
procedure Set_Info_Frame;

procedure SelectCover;
procedure Cover_Label(vShow: Boolean);

procedure Lyrics_Add;
procedure Lyrics_Get;

implementation

uses
  uLoad,
  uSnippet_Text,
  uLoad_AllTypes,
  uMain_SetAll,
  uSoundplayer_Actions,
  uSoundplayer_SetAll,
  uSoundplayer_AllTypes,
  uSoundplayer_Player,
  uSoundplayer_Mouse;

procedure Set_ID3v1_Frame;
begin
  // ID3v1
  vSoundplayer.tag.mp3.ID3v1.Title := TLabel.Create(vSoundplayer.tag.mp3.TabItem[0]);
  vSoundplayer.tag.mp3.ID3v1.Title.Name := 'A_SP_Tag_Mp3_ID3v1_Title';
  vSoundplayer.tag.mp3.ID3v1.Title.Parent := vSoundplayer.tag.mp3.TabItem[0];
  vSoundplayer.tag.mp3.ID3v1.Title.SetBounds(10, 30, 100, 24);
  vSoundplayer.tag.mp3.ID3v1.Title.Text := 'Song Name : ';
  vSoundplayer.tag.mp3.ID3v1.Title.Font.Style := vSoundplayer.tag.mp3.ID3v1.Title.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.tag.mp3.ID3v1.Title.Visible := True;

  vSoundplayer.tag.mp3.ID3v1.Title_V := TEdit.Create(vSoundplayer.tag.mp3.TabItem[0]);
  vSoundplayer.tag.mp3.ID3v1.Title_V.Name := 'A_SP_Tag_Mp3_ID3v1_Title_V';
  vSoundplayer.tag.mp3.ID3v1.Title_V.Parent := vSoundplayer.tag.mp3.TabItem[0];
  vSoundplayer.tag.mp3.ID3v1.Title_V.SetBounds(100, 30, 260, 24);
  vSoundplayer.tag.mp3.ID3v1.Title_V.Text := '';
  vSoundplayer.tag.mp3.ID3v1.Title_V.Visible := True;

  vSoundplayer.tag.mp3.ID3v1.Artist := TLabel.Create(vSoundplayer.tag.mp3.TabItem[0]);
  vSoundplayer.tag.mp3.ID3v1.Artist.Name := 'A_SP_Tag_Mp3_ID3v1_Artist';
  vSoundplayer.tag.mp3.ID3v1.Artist.Parent := vSoundplayer.tag.mp3.TabItem[0];
  vSoundplayer.tag.mp3.ID3v1.Artist.SetBounds(10, 60, 100, 24);
  vSoundplayer.tag.mp3.ID3v1.Artist.Text := 'Artist Name : ';
  vSoundplayer.tag.mp3.ID3v1.Artist.Font.Style := vSoundplayer.tag.mp3.ID3v1.Artist.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.tag.mp3.ID3v1.Artist.Visible := True;

  vSoundplayer.tag.mp3.ID3v1.Artist_V := TEdit.Create(vSoundplayer.tag.mp3.TabItem[0]);
  vSoundplayer.tag.mp3.ID3v1.Artist_V.Name := 'A_SP_Tag_Mp3_ID3v1_Artist_V';
  vSoundplayer.tag.mp3.ID3v1.Artist_V.Parent := vSoundplayer.tag.mp3.TabItem[0];
  vSoundplayer.tag.mp3.ID3v1.Artist_V.SetBounds(100, 60, 260, 24);
  vSoundplayer.tag.mp3.ID3v1.Artist_V.Text := '';
  vSoundplayer.tag.mp3.ID3v1.Artist_V.Visible := True;

  vSoundplayer.tag.mp3.ID3v1.Album := TLabel.Create(vSoundplayer.tag.mp3.TabItem[0]);
  vSoundplayer.tag.mp3.ID3v1.Album.Name := 'A_SP_Tag_Mp3_ID3v1_Album';
  vSoundplayer.tag.mp3.ID3v1.Album.Parent := vSoundplayer.tag.mp3.TabItem[0];
  vSoundplayer.tag.mp3.ID3v1.Album.SetBounds(10, 90, 100, 24);
  vSoundplayer.tag.mp3.ID3v1.Album.Text := 'Album Title : ';
  vSoundplayer.tag.mp3.ID3v1.Album.Font.Style := vSoundplayer.tag.mp3.ID3v1.Album.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.tag.mp3.ID3v1.Album.Visible := True;

  vSoundplayer.tag.mp3.ID3v1.Album_V := TEdit.Create(vSoundplayer.tag.mp3.TabItem[0]);
  vSoundplayer.tag.mp3.ID3v1.Album_V.Name := 'A_SP_Tag_Mp3_ID3v1_Album_V';
  vSoundplayer.tag.mp3.ID3v1.Album_V.Parent := vSoundplayer.tag.mp3.TabItem[0];
  vSoundplayer.tag.mp3.ID3v1.Album_V.SetBounds(100, 90, 260, 24);
  vSoundplayer.tag.mp3.ID3v1.Album_V.Text := '';
  vSoundplayer.tag.mp3.ID3v1.Album_V.Visible := True;

  vSoundplayer.tag.mp3.ID3v1.Year := TLabel.Create(vSoundplayer.tag.mp3.TabItem[0]);
  vSoundplayer.tag.mp3.ID3v1.Year.Name := 'A_SP_Tag_Mp3_ID3v1_Year';
  vSoundplayer.tag.mp3.ID3v1.Year.Parent := vSoundplayer.tag.mp3.TabItem[0];
  vSoundplayer.tag.mp3.ID3v1.Year.SetBounds(10, 120, 100, 24);
  vSoundplayer.tag.mp3.ID3v1.Year.Text := 'Year Published : ';
  vSoundplayer.tag.mp3.ID3v1.Year.Font.Style := vSoundplayer.tag.mp3.ID3v1.Year.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.tag.mp3.ID3v1.Year.Visible := True;

  vSoundplayer.tag.mp3.ID3v1.Year_V := TEdit.Create(vSoundplayer.tag.mp3.TabItem[0]);
  vSoundplayer.tag.mp3.ID3v1.Year_V.Name := 'A_SP_Tag_Mp3_ID3v1_Year_V';
  vSoundplayer.tag.mp3.ID3v1.Year_V.Parent := vSoundplayer.tag.mp3.TabItem[0];
  vSoundplayer.tag.mp3.ID3v1.Year_V.SetBounds(100, 120, 260, 24);
  vSoundplayer.tag.mp3.ID3v1.Year_V.Text := '';
  vSoundplayer.tag.mp3.ID3v1.Year_V.Visible := True;

  vSoundplayer.tag.mp3.ID3v1.Genre := TLabel.Create(vSoundplayer.tag.mp3.TabItem[0]);
  vSoundplayer.tag.mp3.ID3v1.Genre.Name := 'A_SP_Tag_Mp3_ID3v1_Genre';
  vSoundplayer.tag.mp3.ID3v1.Genre.Parent := vSoundplayer.tag.mp3.TabItem[0];
  vSoundplayer.tag.mp3.ID3v1.Genre.SetBounds(10, 150, 100, 24);
  vSoundplayer.tag.mp3.ID3v1.Genre.Text := 'Genre Type : ';
  vSoundplayer.tag.mp3.ID3v1.Genre.Font.Style := vSoundplayer.tag.mp3.ID3v1.Genre.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.tag.mp3.ID3v1.Genre.Visible := True;

  vSoundplayer.tag.mp3.ID3v1.Genre_V := TComboEdit.Create(vSoundplayer.tag.mp3.TabItem[0]);
  vSoundplayer.tag.mp3.ID3v1.Genre_V.Name := 'A_SP_Tag_Mp3_ID3v1_Genre_V';
  vSoundplayer.tag.mp3.ID3v1.Genre_V.Parent := vSoundplayer.tag.mp3.TabItem[0];
  vSoundplayer.tag.mp3.ID3v1.Genre_V.SetBounds(100, 150, 260, 24);
  vSoundplayer.tag.mp3.ID3v1.Genre_V.Items.LoadFromFile(addons.Soundplayer.Path.Files + 'sp_genre_tags.txt');
  vSoundplayer.tag.mp3.ID3v1.Genre_V.Text := '';
  vSoundplayer.tag.mp3.ID3v1.Genre_V.Visible := True;

  vSoundplayer.tag.mp3.ID3v1.Track := TLabel.Create(vSoundplayer.tag.mp3.TabItem[0]);
  vSoundplayer.tag.mp3.ID3v1.Track.Name := 'A_SP_Tag_Mp3_ID3v1_Track';
  vSoundplayer.tag.mp3.ID3v1.Track.Parent := vSoundplayer.tag.mp3.TabItem[0];
  vSoundplayer.tag.mp3.ID3v1.Track.SetBounds(10, 180, 100, 24);
  vSoundplayer.tag.mp3.ID3v1.Track.Text := 'Track Number : ';
  vSoundplayer.tag.mp3.ID3v1.Track.Font.Style := vSoundplayer.tag.mp3.ID3v1.Track.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.tag.mp3.ID3v1.Track.Visible := True;

  vSoundplayer.tag.mp3.ID3v1.Track_V := TEdit.Create(vSoundplayer.tag.mp3.TabItem[0]);
  vSoundplayer.tag.mp3.ID3v1.Track_V.Name := 'A_SP_Tag_Mp3_ID3v1_Track_V';
  vSoundplayer.tag.mp3.ID3v1.Track_V.Parent := vSoundplayer.tag.mp3.TabItem[0];
  vSoundplayer.tag.mp3.ID3v1.Track_V.SetBounds(100, 180, 260, 24);
  vSoundplayer.tag.mp3.ID3v1.Track_V.Text := '';
  vSoundplayer.tag.mp3.ID3v1.Track_V.Visible := True;

  vSoundplayer.tag.mp3.ID3v1.Comment := TLabel.Create(vSoundplayer.tag.mp3.TabItem[0]);
  vSoundplayer.tag.mp3.ID3v1.Comment.Name := 'A_SP_Tag_Mp3_ID3v1_Comments';
  vSoundplayer.tag.mp3.ID3v1.Comment.Parent := vSoundplayer.tag.mp3.TabItem[0];
  vSoundplayer.tag.mp3.ID3v1.Comment.SetBounds(10, 210, 100, 24);
  vSoundplayer.tag.mp3.ID3v1.Comment.Text := 'Comments : ';
  vSoundplayer.tag.mp3.ID3v1.Comment.Font.Style := vSoundplayer.tag.mp3.ID3v1.Comment.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.tag.mp3.ID3v1.Comment.Visible := True;

  vSoundplayer.tag.mp3.ID3v1.Comment_V := TEdit.Create(vSoundplayer.tag.mp3.TabItem[0]);
  vSoundplayer.tag.mp3.ID3v1.Comment_V.Name := 'A_SP_Tag_Mp3_ID3v1_Comments_V';
  vSoundplayer.tag.mp3.ID3v1.Comment_V.Parent := vSoundplayer.tag.mp3.TabItem[0];
  vSoundplayer.tag.mp3.ID3v1.Comment_V.SetBounds(100, 210, 260, 24);
  vSoundplayer.tag.mp3.ID3v1.Comment_V.Text := '';
  vSoundplayer.tag.mp3.ID3v1.Comment_V.Visible := True;

  vSoundplayer.tag.mp3.ID3v1.Transfer := TText.Create(vSoundplayer.tag.mp3.TabItem[0]);
  vSoundplayer.tag.mp3.ID3v1.Transfer.Name := 'A_SP_Tag_Mp3_ID3v1_Transfer';
  vSoundplayer.tag.mp3.ID3v1.Transfer.Parent := vSoundplayer.tag.mp3.TabItem[0];
  vSoundplayer.tag.mp3.ID3v1.Transfer.SetBounds(10, 350, 160, 24);
  vSoundplayer.tag.mp3.ID3v1.Transfer.Text := 'Tranfer data to ID3v2';
  vSoundplayer.tag.mp3.ID3v1.Transfer.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.ID3v1.Transfer.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.tag.mp3.ID3v1.Transfer.OnClick := addons.Soundplayer.Input.mouse_tag.Text.OnMouseClick;
  vSoundplayer.tag.mp3.ID3v1.Transfer.OnMouseEnter := addons.Soundplayer.Input.mouse_tag.Text.OnMouseEnter;
  vSoundplayer.tag.mp3.ID3v1.Transfer.OnMouseLeave := addons.Soundplayer.Input.mouse_tag.Text.OnMouseLeave;
  vSoundplayer.tag.mp3.ID3v1.Transfer.Visible := True;
end;

procedure Set_ID3v2_Frame;
var
  vi: Integer;
begin
  // ID3v2
  vSoundplayer.tag.mp3.ID3v2.Title := TLabel.Create(vSoundplayer.tag.mp3.TabItem[1]);
  vSoundplayer.tag.mp3.ID3v2.Title.Name := 'A_SP_Tag_Mp3_ID3v2_Title';
  vSoundplayer.tag.mp3.ID3v2.Title.Parent := vSoundplayer.tag.mp3.TabItem[1];
  vSoundplayer.tag.mp3.ID3v2.Title.SetBounds(10, 30, 100, 24);
  vSoundplayer.tag.mp3.ID3v2.Title.Text := 'Song Name : ';
  vSoundplayer.tag.mp3.ID3v2.Title.Font.Style := vSoundplayer.tag.mp3.ID3v2.Title.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.tag.mp3.ID3v2.Title.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Title_V := TEdit.Create(vSoundplayer.tag.mp3.TabItem[1]);
  vSoundplayer.tag.mp3.ID3v2.Title_V.Name := 'A_SP_Tag_Mp3_ID3v2_Title_V';
  vSoundplayer.tag.mp3.ID3v2.Title_V.Parent := vSoundplayer.tag.mp3.TabItem[1];
  vSoundplayer.tag.mp3.ID3v2.Title_V.SetBounds(100, 30, 260, 24);
  vSoundplayer.tag.mp3.ID3v2.Title_V.Text := '';
  vSoundplayer.tag.mp3.ID3v2.Title_V.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Artist := TLabel.Create(vSoundplayer.tag.mp3.TabItem[1]);
  vSoundplayer.tag.mp3.ID3v2.Artist.Name := 'A_SP_Tag_Mp3_ID3v2_Artist';
  vSoundplayer.tag.mp3.ID3v2.Artist.Parent := vSoundplayer.tag.mp3.TabItem[1];
  vSoundplayer.tag.mp3.ID3v2.Artist.SetBounds(10, 60, 100, 24);
  vSoundplayer.tag.mp3.ID3v2.Artist.Text := 'Artist Name : ';
  vSoundplayer.tag.mp3.ID3v2.Artist.Font.Style := vSoundplayer.tag.mp3.ID3v2.Artist.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.tag.mp3.ID3v2.Artist.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Artist_V := TEdit.Create(vSoundplayer.tag.mp3.TabItem[1]);
  vSoundplayer.tag.mp3.ID3v2.Artist_V.Name := 'A_SP_Tag_Mp3_ID3v2_Artist_V';
  vSoundplayer.tag.mp3.ID3v2.Artist_V.Parent := vSoundplayer.tag.mp3.TabItem[1];
  vSoundplayer.tag.mp3.ID3v2.Artist_V.SetBounds(100, 60, 260, 24);
  vSoundplayer.tag.mp3.ID3v2.Artist_V.Text := '';
  vSoundplayer.tag.mp3.ID3v2.Artist_V.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Album := TLabel.Create(vSoundplayer.tag.mp3.TabItem[1]);
  vSoundplayer.tag.mp3.ID3v2.Album.Name := 'A_SP_Tag_Mp3_ID3v2_Album';
  vSoundplayer.tag.mp3.ID3v2.Album.Parent := vSoundplayer.tag.mp3.TabItem[1];
  vSoundplayer.tag.mp3.ID3v2.Album.SetBounds(10, 90, 100, 24);
  vSoundplayer.tag.mp3.ID3v2.Album.Text := 'Album Title : ';
  vSoundplayer.tag.mp3.ID3v2.Album.Font.Style := vSoundplayer.tag.mp3.ID3v2.Album.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.tag.mp3.ID3v2.Album.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Album_V := TEdit.Create(vSoundplayer.tag.mp3.TabItem[1]);
  vSoundplayer.tag.mp3.ID3v2.Album_V.Name := 'A_SP_Tag_Mp3_ID3v2_Album_V';
  vSoundplayer.tag.mp3.ID3v2.Album_V.Parent := vSoundplayer.tag.mp3.TabItem[1];
  vSoundplayer.tag.mp3.ID3v2.Album_V.SetBounds(100, 90, 260, 24);
  vSoundplayer.tag.mp3.ID3v2.Album_V.Text := '';
  vSoundplayer.tag.mp3.ID3v2.Album_V.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Year := TLabel.Create(vSoundplayer.tag.mp3.TabItem[1]);
  vSoundplayer.tag.mp3.ID3v2.Year.Name := 'A_SP_Tag_Mp3_ID3v2_Year';
  vSoundplayer.tag.mp3.ID3v2.Year.Parent := vSoundplayer.tag.mp3.TabItem[1];
  vSoundplayer.tag.mp3.ID3v2.Year.SetBounds(10, 120, 100, 24);
  vSoundplayer.tag.mp3.ID3v2.Year.Text := 'Year Published : ';
  vSoundplayer.tag.mp3.ID3v2.Year.Font.Style := vSoundplayer.tag.mp3.ID3v2.Year.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.tag.mp3.ID3v2.Year.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Year_V := TEdit.Create(vSoundplayer.tag.mp3.TabItem[1]);
  vSoundplayer.tag.mp3.ID3v2.Year_V.Name := 'A_SP_Tag_Mp3_ID3v2_Year_V';
  vSoundplayer.tag.mp3.ID3v2.Year_V.Parent := vSoundplayer.tag.mp3.TabItem[1];
  vSoundplayer.tag.mp3.ID3v2.Year_V.SetBounds(100, 120, 260, 24);
  vSoundplayer.tag.mp3.ID3v2.Year_V.Text := '';
  vSoundplayer.tag.mp3.ID3v2.Year_V.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Genre := TLabel.Create(vSoundplayer.tag.mp3.TabItem[1]);
  vSoundplayer.tag.mp3.ID3v2.Genre.Name := 'A_SP_Tag_Mp3_ID3v2_Genre';
  vSoundplayer.tag.mp3.ID3v2.Genre.Parent := vSoundplayer.tag.mp3.TabItem[1];
  vSoundplayer.tag.mp3.ID3v2.Genre.SetBounds(10, 150, 100, 24);
  vSoundplayer.tag.mp3.ID3v2.Genre.Text := 'Genre Type : ';
  vSoundplayer.tag.mp3.ID3v2.Genre.Font.Style := vSoundplayer.tag.mp3.ID3v2.Genre.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.tag.mp3.ID3v2.Genre.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Genre_V := TComboEdit.Create(vSoundplayer.tag.mp3.TabItem[1]);
  vSoundplayer.tag.mp3.ID3v2.Genre_V.Name := 'A_SP_Tag_Mp3_ID3v2_Genre_V';
  vSoundplayer.tag.mp3.ID3v2.Genre_V.Parent := vSoundplayer.tag.mp3.TabItem[1];
  vSoundplayer.tag.mp3.ID3v2.Genre_V.SetBounds(100, 150, 260, 24);
  vSoundplayer.tag.mp3.ID3v2.Genre_V.Items.LoadFromFile(addons.Soundplayer.Path.Files + 'sp_genre_tags.txt');
  vSoundplayer.tag.mp3.ID3v2.Genre_V.Text := '';
  vSoundplayer.tag.mp3.ID3v2.Genre_V.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Track := TLabel.Create(vSoundplayer.tag.mp3.TabItem[1]);
  vSoundplayer.tag.mp3.ID3v2.Track.Name := 'A_SP_Tag_Mp3_ID3v2_Track';
  vSoundplayer.tag.mp3.ID3v2.Track.Parent := vSoundplayer.tag.mp3.TabItem[1];
  vSoundplayer.tag.mp3.ID3v2.Track.SetBounds(10, 180, 100, 24);
  vSoundplayer.tag.mp3.ID3v2.Track.Text := 'Track Number : ';
  vSoundplayer.tag.mp3.ID3v2.Track.Font.Style := vSoundplayer.tag.mp3.ID3v2.Track.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.tag.mp3.ID3v2.Track.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Track_V := TEdit.Create(vSoundplayer.tag.mp3.TabItem[1]);
  vSoundplayer.tag.mp3.ID3v2.Track_V.Name := 'A_SP_Tag_Mp3_ID3v2_Track_V';
  vSoundplayer.tag.mp3.ID3v2.Track_V.Parent := vSoundplayer.tag.mp3.TabItem[1];
  vSoundplayer.tag.mp3.ID3v2.Track_V.SetBounds(100, 180, 260, 24);
  vSoundplayer.tag.mp3.ID3v2.Track_V.Text := '';
  vSoundplayer.tag.mp3.ID3v2.Track_V.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Comment := TLabel.Create(vSoundplayer.tag.mp3.TabItem[1]);
  vSoundplayer.tag.mp3.ID3v2.Comment.Name := 'A_SP_Tag_Mp3_ID3v2_Comments';
  vSoundplayer.tag.mp3.ID3v2.Comment.Parent := vSoundplayer.tag.mp3.TabItem[1];
  vSoundplayer.tag.mp3.ID3v2.Comment.SetBounds(10, 210, 100, 24);
  vSoundplayer.tag.mp3.ID3v2.Comment.Text := 'Comments : ';
  vSoundplayer.tag.mp3.ID3v2.Comment.Font.Style := vSoundplayer.tag.mp3.ID3v2.Comment.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.tag.mp3.ID3v2.Comment.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Comment_V := TEdit.Create(vSoundplayer.tag.mp3.TabItem[1]);
  vSoundplayer.tag.mp3.ID3v2.Comment_V.Name := 'A_SP_Tag_Mp3_ID3v2_Comments_V';
  vSoundplayer.tag.mp3.ID3v2.Comment_V.Parent := vSoundplayer.tag.mp3.TabItem[1];
  vSoundplayer.tag.mp3.ID3v2.Comment_V.SetBounds(100, 210, 260, 24);
  vSoundplayer.tag.mp3.ID3v2.Comment_V.Text := '';
  vSoundplayer.tag.mp3.ID3v2.Comment_V.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Rate_Label := TLabel.Create(vSoundplayer.tag.mp3.TabItem[1]);
  vSoundplayer.tag.mp3.ID3v2.Rate_Label.Name := 'A_SP_Tag_Mp3_ID3v2_Rate_Label';
  vSoundplayer.tag.mp3.ID3v2.Rate_Label.Parent := vSoundplayer.tag.mp3.TabItem[1];
  vSoundplayer.tag.mp3.ID3v2.Rate_Label.SetBounds(92, 246, 200, 24);
  vSoundplayer.tag.mp3.ID3v2.Rate_Label.Text := 'Rating : No Rating';
  vSoundplayer.tag.mp3.ID3v2.Rate_Label.Font.Style := vSoundplayer.tag.mp3.ID3v2.Rate_Label.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.tag.mp3.ID3v2.Rate_Label.Visible := True;

  for vi := 0 to 9 do
  begin
    vSoundplayer.tag.mp3.ID3v2.Rate[vi] := TText.Create(vSoundplayer.tag.mp3.TabItem[1]);
    vSoundplayer.tag.mp3.ID3v2.Rate[vi].Name := 'A_SP_Tag_Mp3_ID3v2_Rate_' + vi.ToString;
    vSoundplayer.tag.mp3.ID3v2.Rate[vi].Parent := vSoundplayer.tag.mp3.TabItem[1];
    vSoundplayer.tag.mp3.ID3v2.Rate[vi].SetBounds(92 + (28 * vi), 268, 22, 22);
    vSoundplayer.tag.mp3.ID3v2.Rate[vi].Font.Family := 'IcoMoon-Free';
    vSoundplayer.tag.mp3.ID3v2.Rate[vi].TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vSoundplayer.tag.mp3.ID3v2.Rate[vi].Font.Size := 22;
    vSoundplayer.tag.mp3.ID3v2.Rate[vi].Text := #$e9d9;
    vSoundplayer.tag.mp3.ID3v2.Rate[vi].OnClick := addons.Soundplayer.Input.mouse_tag.Text.OnMouseClick;
    vSoundplayer.tag.mp3.ID3v2.Rate[vi].OnMouseEnter := addons.Soundplayer.Input.mouse_tag.Text.OnMouseEnter;
    vSoundplayer.tag.mp3.ID3v2.Rate[vi].OnMouseLeave := addons.Soundplayer.Input.mouse_tag.Text.OnMouseLeave;
    vSoundplayer.tag.mp3.ID3v2.Rate[vi].OnMouseDown := addons.Soundplayer.Input.mouse_tag.Text.OnMouseDown;
    vSoundplayer.tag.mp3.ID3v2.Rate[vi].TagString := vi.ToString;
    vSoundplayer.tag.mp3.ID3v2.Rate[vi].Visible := True;

    vSoundplayer.tag.mp3.ID3v2.Rate_Glow[vi] := TGlowEffect.Create(vSoundplayer.tag.mp3.ID3v2.Rate[vi]);
    vSoundplayer.tag.mp3.ID3v2.Rate_Glow[vi].Name := 'A_SP_Tag_Mp3_ID3v2_Rate_Glow_' + vi.ToString;
    vSoundplayer.tag.mp3.ID3v2.Rate_Glow[vi].Parent := vSoundplayer.tag.mp3.ID3v2.Rate[vi];
    vSoundplayer.tag.mp3.ID3v2.Rate_Glow[vi].Softness := 0.4;
    vSoundplayer.tag.mp3.ID3v2.Rate_Glow[vi].GlowColor := TAlphaColorRec.Deepskyblue;
    vSoundplayer.tag.mp3.ID3v2.Rate_Glow[vi].Opacity := 0.9;
    vSoundplayer.tag.mp3.ID3v2.Rate_Glow[vi].Enabled := False;

    vSoundplayer.tag.mp3.ID3v2.Rate_Dot[vi] := TText.Create(vSoundplayer.tag.mp3.TabItem[1]);
    vSoundplayer.tag.mp3.ID3v2.Rate_Dot[vi].Name := 'A_SP_Tag_Mp3_ID3v2_Rate_Dot_' + vi.ToString;
    vSoundplayer.tag.mp3.ID3v2.Rate_Dot[vi].Parent := vSoundplayer.tag.mp3.TabItem[1];
    vSoundplayer.tag.mp3.ID3v2.Rate_Dot[vi].SetBounds(92 + (28 * vi), 268, 22, 22);
    vSoundplayer.tag.mp3.ID3v2.Rate_Dot[vi].Font.Family := 'IcoMoon-Free';
    vSoundplayer.tag.mp3.ID3v2.Rate_Dot[vi].TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    vSoundplayer.tag.mp3.ID3v2.Rate_Dot[vi].Font.Size := 22;
    vSoundplayer.tag.mp3.ID3v2.Rate_Dot[vi].Text := #$e9d7;
    vSoundplayer.tag.mp3.ID3v2.Rate_Dot[vi].OnClick := addons.Soundplayer.Input.mouse_tag.Text.OnMouseClick;
    vSoundplayer.tag.mp3.ID3v2.Rate_Dot[vi].OnMouseEnter := addons.Soundplayer.Input.mouse_tag.Text.OnMouseEnter;
    vSoundplayer.tag.mp3.ID3v2.Rate_Dot[vi].OnMouseLeave := addons.Soundplayer.Input.mouse_tag.Text.OnMouseLeave;
    vSoundplayer.tag.mp3.ID3v2.Rate_Dot[vi].TagString := vi.ToString;
    vSoundplayer.tag.mp3.ID3v2.Rate_Dot[vi].Visible := True;
  end;

  vSoundplayer.tag.mp3.ID3v2.Transfer := TText.Create(vSoundplayer.tag.mp3.TabItem[1]);
  vSoundplayer.tag.mp3.ID3v2.Transfer.Name := 'A_SP_Tag_Mp3_ID3v2_Transfer';
  vSoundplayer.tag.mp3.ID3v2.Transfer.Parent := vSoundplayer.tag.mp3.TabItem[1];
  vSoundplayer.tag.mp3.ID3v2.Transfer.SetBounds(10, 350, 160, 24);
  vSoundplayer.tag.mp3.ID3v2.Transfer.Text := 'Tranfer data to ID3v1';
  vSoundplayer.tag.mp3.ID3v2.Transfer.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.ID3v2.Transfer.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.tag.mp3.ID3v2.Transfer.OnClick := addons.Soundplayer.Input.mouse_tag.Text.OnMouseClick;
  vSoundplayer.tag.mp3.ID3v2.Transfer.OnMouseEnter := addons.Soundplayer.Input.mouse_tag.Text.OnMouseEnter;
  vSoundplayer.tag.mp3.ID3v2.Transfer.OnMouseLeave := addons.Soundplayer.Input.mouse_tag.Text.OnMouseLeave;
  vSoundplayer.tag.mp3.ID3v2.Transfer.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Covers := TGroupBox.Create(vSoundplayer.tag.mp3.TabItem[1]);
  vSoundplayer.tag.mp3.ID3v2.Covers.Name := 'A_SP_Tag_Mp3_ID3v2_Covers_Groupbox';
  vSoundplayer.tag.mp3.ID3v2.Covers.Parent := vSoundplayer.tag.mp3.TabItem[1];
  vSoundplayer.tag.mp3.ID3v2.Covers.SetBounds(380, 20, 280, vSoundplayer.tag.mp3.TabControl.Height - 50);
  vSoundplayer.tag.mp3.ID3v2.Covers.Text := 'Covers';
  vSoundplayer.tag.mp3.ID3v2.Covers.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Cover := TImage.Create(vSoundplayer.tag.mp3.ID3v2.Covers);
  vSoundplayer.tag.mp3.ID3v2.Cover.Name := 'A_SP_Tag_Mp3_ID3v2_Covers_Cover';
  vSoundplayer.tag.mp3.ID3v2.Cover.Parent := vSoundplayer.tag.mp3.ID3v2.Covers;
  vSoundplayer.tag.mp3.ID3v2.Cover.SetBounds(10, 30, 260, 220);
  vSoundplayer.tag.mp3.ID3v2.Cover.Bitmap.LoadFromFile(addons.Soundplayer.Path.Images + 'sp_nocover.png');
  vSoundplayer.tag.mp3.ID3v2.Cover.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.tag.mp3.ID3v2.Cover.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Cover_Label := TLabel.Create(vSoundplayer.tag.mp3.ID3v2.Covers);
  vSoundplayer.tag.mp3.ID3v2.Cover_Label.Name := 'A_SP_Tag_Mp3_ID3v2_Cover_Label';
  vSoundplayer.tag.mp3.ID3v2.Cover_Label.Parent := vSoundplayer.tag.mp3.ID3v2.Covers;
  vSoundplayer.tag.mp3.ID3v2.Cover_Label.SetBounds(0, 260, 280, 24);
  vSoundplayer.tag.mp3.ID3v2.Cover_Label.Text := '';
  vSoundplayer.tag.mp3.ID3v2.Cover_Label.Font.Style := vSoundplayer.tag.mp3.ID3v1.Title.Font.Style + [TFontStyle.fsBold];
  vSoundplayer.tag.mp3.ID3v2.Cover_Label.TextAlign := TTextAlign.Center;
  vSoundplayer.tag.mp3.ID3v2.Cover_Label.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft := TText.Create(vSoundplayer.tag.mp3.ID3v2.Covers);
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft.Name := 'A_SP_Tag_Mp3_ID3v2_Covers_Cover_ArrowLeft';
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft.Parent := vSoundplayer.tag.mp3.ID3v2.Covers;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft.SetBounds(10, 130, 24, 24);
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft.Font.Family := 'IcoMoon-Free';
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft.Font.Size := 24;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft.Text := #$ea44;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft.OnClick := addons.Soundplayer.Input.mouse_tag.Text.OnMouseClick;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft.OnMouseEnter := addons.Soundplayer.Input.mouse_tag.Text.OnMouseEnter;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft.OnMouseLeave := addons.Soundplayer.Input.mouse_tag.Text.OnMouseLeave;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft_Glow := TGlowEffect.Create(vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft);
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft_Glow.Name := 'A_SP_Tag_Mp3_ID3v2_Covers_Cover_ArrowLeft_Glow';
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft_Glow.Parent := vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft_Glow.Softness := 0.4;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft_Glow.Opacity := 0.9;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowLeft_Glow.Enabled := False;

  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight := TText.Create(vSoundplayer.tag.mp3.ID3v2.Covers);
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight.Name := 'A_SP_Tag_Mp3_ID3v2_Covers_Cover_ArrowRight';
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight.Parent := vSoundplayer.tag.mp3.ID3v2.Covers;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight.SetBounds(vSoundplayer.tag.mp3.ID3v2.Covers.Width - 34, 130, 24, 24);
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight.Font.Family := 'IcoMoon-Free';
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight.Font.Size := 24;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight.Text := #$ea42;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight.OnClick := addons.Soundplayer.Input.mouse_tag.Text.OnMouseClick;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight.OnMouseEnter := addons.Soundplayer.Input.mouse_tag.Text.OnMouseEnter;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight.OnMouseLeave := addons.Soundplayer.Input.mouse_tag.Text.OnMouseLeave;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight_Glow := TGlowEffect.Create(vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight);
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight_Glow.Name := 'A_SP_Tag_Mp3_ID3v2_Covers_Cover_ArrowRight_Glow';
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight_Glow.Parent := vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight_Glow.Softness := 0.4;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight_Glow.Opacity := 0.9;
  vSoundplayer.tag.mp3.ID3v2.Cover_ArrowRight_Glow.Enabled := False;

  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer := TText.Create(vSoundplayer.tag.mp3.ID3v2.Covers);
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer.Name := 'A_SP_Tag_Mp3_ID3v2_Covers_AddComputer';
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer.Parent := vSoundplayer.tag.mp3.ID3v2.Covers;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer.SetBounds(10, vSoundplayer.tag.mp3.ID3v2.Covers.Height - 42, 28, 28);
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer.Font.Family := 'IcoMoon-Free';
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer.Text := #$e956;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer.Font.Size := 28;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer.OnClick := addons.Soundplayer.Input.mouse_tag.Text.OnMouseClick;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer.OnMouseEnter := addons.Soundplayer.Input.mouse_tag.Text.OnMouseEnter;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer.OnMouseLeave := addons.Soundplayer.Input.mouse_tag.Text.OnMouseLeave;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer_Glow := TGlowEffect.Create(vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer);
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer_Glow.Name := 'A_SP_Tag_Mp3_ID3v2_Covers_AddComputer_Glow';
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer_Glow.Parent := vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer_Glow.Softness := 0.4;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer_Glow.Opacity := 0.9;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Computer_Glow.Enabled := False;

  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet := TText.Create(vSoundplayer.tag.mp3.ID3v2.Covers);
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet.Name := 'A_SP_Tag_Mp3_ID3v2_Covers_AddInternet';
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet.Parent := vSoundplayer.tag.mp3.ID3v2.Covers;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet.SetBounds(60, vSoundplayer.tag.mp3.ID3v2.Covers.Height - 42, 28, 28);
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet.Font.Family := 'IcoMoon-Free';
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet.Text := #$e9c9;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet.Font.Size := 28;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet.OnClick := addons.Soundplayer.Input.mouse_tag.Text.OnMouseClick;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet.OnMouseEnter := addons.Soundplayer.Input.mouse_tag.Text.OnMouseEnter;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet.OnMouseLeave := addons.Soundplayer.Input.mouse_tag.Text.OnMouseLeave;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet_Glow := TGlowEffect.Create(vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet);
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet_Glow.Name := 'A_SP_Tag_Mp3_ID3v2_Covers_AddInternet_Glow';
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet_Glow.Parent := vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet_Glow.Softness := 0.4;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet_Glow.Opacity := 0.9;
  vSoundplayer.tag.mp3.ID3v2.Cover_Add_Internet_Glow.Enabled := False;

  vSoundplayer.tag.mp3.ID3v2.Cover_Remove := TText.Create(vSoundplayer.tag.mp3.ID3v2.Covers);
  vSoundplayer.tag.mp3.ID3v2.Cover_Remove.Name := 'A_SP_Tag_Mp3_ID3v2_Covers_Remove';
  vSoundplayer.tag.mp3.ID3v2.Cover_Remove.Parent := vSoundplayer.tag.mp3.ID3v2.Covers;
  vSoundplayer.tag.mp3.ID3v2.Cover_Remove.SetBounds(vSoundplayer.tag.mp3.ID3v2.Covers.Width - 42, vSoundplayer.tag.mp3.ID3v2.Covers.Height - 42, 28, 28);
  vSoundplayer.tag.mp3.ID3v2.Cover_Remove.Font.Family := 'IcoMoon-Free';
  vSoundplayer.tag.mp3.ID3v2.Cover_Remove.Text := #$e9ac;
  vSoundplayer.tag.mp3.ID3v2.Cover_Remove.TextSettings.FontColor := TAlphaColorRec.Red;
  vSoundplayer.tag.mp3.ID3v2.Cover_Remove.Font.Size := 28;
  vSoundplayer.tag.mp3.ID3v2.Cover_Remove.OnClick := addons.Soundplayer.Input.mouse_tag.Text.OnMouseClick;
  vSoundplayer.tag.mp3.ID3v2.Cover_Remove.OnMouseEnter := addons.Soundplayer.Input.mouse_tag.Text.OnMouseEnter;
  vSoundplayer.tag.mp3.ID3v2.Cover_Remove.OnMouseLeave := addons.Soundplayer.Input.mouse_tag.Text.OnMouseLeave;
  vSoundplayer.tag.mp3.ID3v2.Cover_Remove.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Cover_Remove_Glow := TGlowEffect.Create(vSoundplayer.tag.mp3.ID3v2.Cover_Remove);
  vSoundplayer.tag.mp3.ID3v2.Cover_Remove_Glow.Name := 'A_SP_Tag_Mp3_ID3v2_Covers_Remove_Glow';
  vSoundplayer.tag.mp3.ID3v2.Cover_Remove_Glow.Parent := vSoundplayer.tag.mp3.ID3v2.Cover_Remove;
  vSoundplayer.tag.mp3.ID3v2.Cover_Remove_Glow.Softness := 0.4;
  vSoundplayer.tag.mp3.ID3v2.Cover_Remove_Glow.GlowColor := TAlphaColorRec.Red;
  vSoundplayer.tag.mp3.ID3v2.Cover_Remove_Glow.Opacity := 0.9;
  vSoundplayer.tag.mp3.ID3v2.Cover_Remove_Glow.Enabled := False;

  vSoundplayer.tag.mp3.ID3v2.Lyrics := TGroupBox.Create(vSoundplayer.tag.mp3.TabItem[1]);
  vSoundplayer.tag.mp3.ID3v2.Lyrics.Name := 'A_SP_Tag_Mp3_ID3v2_Lyrics_Groupbox';
  vSoundplayer.tag.mp3.ID3v2.Lyrics.Parent := vSoundplayer.tag.mp3.TabItem[1];
  vSoundplayer.tag.mp3.ID3v2.Lyrics.SetBounds(680, 20, 280, vSoundplayer.tag.mp3.TabControl.Height - 50);
  vSoundplayer.tag.mp3.ID3v2.Lyrics.Text := 'Lyrics';
  vSoundplayer.tag.mp3.ID3v2.Lyrics.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Lyrics_Memo := TMemo.Create(vSoundplayer.tag.mp3.ID3v2.Lyrics);
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Memo.Name := 'A_SP_Tag_Mp3_ID3v2_Lyrics';
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Memo.Parent := vSoundplayer.tag.mp3.ID3v2.Lyrics;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Memo.SetBounds(10, 20, vSoundplayer.tag.mp3.ID3v2.Lyrics.Width - 20, vSoundplayer.tag.mp3.ID3v2.Lyrics.Height - 70);
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Memo.WordWrap := False;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Memo.TextSettings.HorzAlign := TTextAlign.Center;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Memo.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer := TText.Create(vSoundplayer.tag.mp3.ID3v2.Lyrics);
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer.Name := 'A_SP_Tag_Mp3_ID3v2_Lyrics_AddComputer';
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer.Parent := vSoundplayer.tag.mp3.ID3v2.Lyrics;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer.SetBounds(10, vSoundplayer.tag.mp3.ID3v2.Lyrics.Height - 42, 28, 28);
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer.Font.Family := 'IcoMoon-Free';
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer.Text := #$e956;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer.Font.Size := 28;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer.OnClick := addons.Soundplayer.Input.mouse_tag.Text.OnMouseClick;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer.OnMouseEnter := addons.Soundplayer.Input.mouse_tag.Text.OnMouseEnter;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer.OnMouseLeave := addons.Soundplayer.Input.mouse_tag.Text.OnMouseLeave;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer_Glow := TGlowEffect.Create(vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer);
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer_Glow.Name := 'A_SP_Tag_Mp3_ID3v2_Lyrics_AddComputer_Glow';
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer_Glow.Parent := vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer_Glow.Softness := 0.4;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer_Glow.Opacity := 0.9;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Computer_Glow.Enabled := False;

  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet := TText.Create(vSoundplayer.tag.mp3.ID3v2.Lyrics);
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet.Name := 'A_SP_Tag_Mp3_ID3v2_Lyrics_AddInternet';
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet.Parent := vSoundplayer.tag.mp3.ID3v2.Lyrics;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet.SetBounds(60, vSoundplayer.tag.mp3.ID3v2.Lyrics.Height - 42, 28, 28);
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet.Font.Family := 'IcoMoon-Free';
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet.Text := #$e9c9;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet.Font.Size := 28;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet.OnClick := addons.Soundplayer.Input.mouse_tag.Text.OnMouseClick;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet.OnMouseEnter := addons.Soundplayer.Input.mouse_tag.Text.OnMouseEnter;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet.OnMouseLeave := addons.Soundplayer.Input.mouse_tag.Text.OnMouseLeave;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet_Glow := TGlowEffect.Create(vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet);
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet_Glow.Name := 'A_SP_Tag_Mp3_ID3v2_Lyrics_AddInternet_Glow';
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet_Glow.Parent := vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet_Glow.Softness := 0.4;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet_Glow.Opacity := 0.9;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Add_Internet_Glow.Enabled := False;

  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove := TText.Create(vSoundplayer.tag.mp3.ID3v2.Lyrics);
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove.Name := 'A_SP_Tag_Mp3_ID3v2_Lyrics_Remove';
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove.Parent := vSoundplayer.tag.mp3.ID3v2.Lyrics;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove.SetBounds(vSoundplayer.tag.mp3.ID3v2.Lyrics.Width - 42, vSoundplayer.tag.mp3.ID3v2.Lyrics.Height - 42, 28, 28);
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove.Font.Family := 'IcoMoon-Free';
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove.Text := #$e9ac;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove.TextSettings.FontColor := TAlphaColorRec.Red;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove.Font.Size := 28;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove.OnClick := addons.Soundplayer.Input.mouse_tag.Text.OnMouseClick;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove.OnMouseEnter := addons.Soundplayer.Input.mouse_tag.Text.OnMouseEnter;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove.OnMouseLeave := addons.Soundplayer.Input.mouse_tag.Text.OnMouseLeave;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove.Visible := True;

  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove_Glow := TGlowEffect.Create(vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove);
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove_Glow.Name := 'A_SP_Tag_Mp3_ID3v2_Lyrics_Remove_Glow';
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove_Glow.Parent := vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove_Glow.Softness := 0.4;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove_Glow.GlowColor := TAlphaColorRec.Red;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove_Glow.Opacity := 0.9;
  vSoundplayer.tag.mp3.ID3v2.Lyrics_Remove_Glow.Enabled := False;
end;

procedure Set_Info_Frame;
begin
  vSoundplayer.tag.mp3.Info.General.Loaded := TCheckBox.Create(vSoundplayer.tag.mp3.TabItem[2]);
  vSoundplayer.tag.mp3.Info.General.Loaded.Name := 'A_SP_Tag_Mp3_Info_General_Loaded';
  vSoundplayer.tag.mp3.Info.General.Loaded.Parent := vSoundplayer.tag.mp3.TabItem[2];
  vSoundplayer.tag.mp3.Info.General.Loaded.SetBounds(10, 10, 400, 27);
  vSoundplayer.tag.mp3.Info.General.Loaded.Text := ' : Loaded';
  vSoundplayer.tag.mp3.Info.General.Loaded.IsChecked := soundplayer.player_actions.Tag.mp3.Info.General.Loaded;
  vSoundplayer.tag.mp3.Info.General.Loaded.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.Info.General.Loaded.Enabled := False;
  vSoundplayer.tag.mp3.Info.General.Loaded.Visible := True;

  vSoundplayer.tag.mp3.Info.General.Box := TGroupBox.Create(vSoundplayer.tag.mp3.TabItem[2]);
  vSoundplayer.tag.mp3.Info.General.Box.Name := 'A_SP_Tag_Mp3_Info_General';
  vSoundplayer.tag.mp3.Info.General.Box.Parent := vSoundplayer.tag.mp3.TabItem[2];
  vSoundplayer.tag.mp3.Info.General.Box.SetBounds(10, 45, (vSoundplayer.tag.mp3.TabControl.Width / 2) - 15, vSoundplayer.tag.mp3.TabControl.Height - 45);
  vSoundplayer.tag.mp3.Info.General.Box.Text := 'General';
  vSoundplayer.tag.mp3.Info.General.Box.Visible := True;

  vSoundplayer.tag.mp3.Info.General.Filename := TText.Create(vSoundplayer.tag.mp3.Info.General.Box);
  vSoundplayer.tag.mp3.Info.General.Filename.Name := 'A_SP_Tag_Mp3_Info_General_Filename';
  vSoundplayer.tag.mp3.Info.General.Filename.Parent := vSoundplayer.tag.mp3.Info.General.Box;
  vSoundplayer.tag.mp3.Info.General.Filename.SetBounds(15, 20, vSoundplayer.tag.mp3.Info.General.Box.Width - 10, 27);
  vSoundplayer.tag.mp3.Info.General.Filename.Text := 'Filename : ' + soundplayer.player_actions.Tag.mp3.Info.General.Filename;
  vSoundplayer.tag.mp3.Info.General.Filename.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.Info.General.Filename.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.tag.mp3.Info.General.Filename.Visible := True;

  vSoundplayer.tag.mp3.Info.General.MajorVersion := TText.Create(vSoundplayer.tag.mp3.Info.General.Box);
  vSoundplayer.tag.mp3.Info.General.MajorVersion.Name := 'A_SP_Tag_Mp3_Info_General_MajorVersion';
  vSoundplayer.tag.mp3.Info.General.MajorVersion.Parent := vSoundplayer.tag.mp3.Info.General.Box;
  vSoundplayer.tag.mp3.Info.General.MajorVersion.SetBounds(15, 50, vSoundplayer.tag.mp3.Info.General.Box.Width - 10, 27);
  vSoundplayer.tag.mp3.Info.General.MajorVersion.Text := 'Major Version : ' + soundplayer.player_actions.Tag.mp3.Info.General.MajorVersion.ToString;
  vSoundplayer.tag.mp3.Info.General.MajorVersion.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.Info.General.MajorVersion.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.tag.mp3.Info.General.MajorVersion.Visible := True;

  vSoundplayer.tag.mp3.Info.General.MinorVersion := TText.Create(vSoundplayer.tag.mp3.Info.General.Box);
  vSoundplayer.tag.mp3.Info.General.MinorVersion.Name := 'A_SP_Tag_Mp3_Info_General_MinorVersion';
  vSoundplayer.tag.mp3.Info.General.MinorVersion.Parent := vSoundplayer.tag.mp3.Info.General.Box;
  vSoundplayer.tag.mp3.Info.General.MinorVersion.SetBounds(15, 80, vSoundplayer.tag.mp3.Info.General.Box.Width - 10, 27);
  vSoundplayer.tag.mp3.Info.General.MinorVersion.Text := 'Minor Version : ' + soundplayer.player_actions.Tag.mp3.Info.General.MinorVersion.ToString;
  vSoundplayer.tag.mp3.Info.General.MinorVersion.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.Info.General.MinorVersion.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.tag.mp3.Info.General.MinorVersion.Visible := True;

  vSoundplayer.tag.mp3.Info.General.Size := TText.Create(vSoundplayer.tag.mp3.Info.General.Box);
  vSoundplayer.tag.mp3.Info.General.Size.Name := 'A_SP_Tag_Mp3_Info_General_Size';
  vSoundplayer.tag.mp3.Info.General.Size.Parent := vSoundplayer.tag.mp3.Info.General.Box;
  vSoundplayer.tag.mp3.Info.General.Size.SetBounds(15, 110, vSoundplayer.tag.mp3.Info.General.Box.Width - 10, 27);
  vSoundplayer.tag.mp3.Info.General.Size.Text := 'Size : ' + soundplayer.player_actions.Tag.mp3.Info.General.Size.ToString + ' bytes';
  vSoundplayer.tag.mp3.Info.General.Size.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.Info.General.Size.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.tag.mp3.Info.General.Size.Visible := True;

  vSoundplayer.tag.mp3.Info.General.FramesCount := TText.Create(vSoundplayer.tag.mp3.Info.General.Box);
  vSoundplayer.tag.mp3.Info.General.FramesCount.Name := 'A_SP_Tag_Mp3_Info_General_FramesCount';
  vSoundplayer.tag.mp3.Info.General.FramesCount.Parent := vSoundplayer.tag.mp3.Info.General.Box;
  vSoundplayer.tag.mp3.Info.General.FramesCount.SetBounds(15, 140, vSoundplayer.tag.mp3.Info.General.Box.Width - 10, 27);
  vSoundplayer.tag.mp3.Info.General.FramesCount.Text := 'Frames Count : ' + soundplayer.player_actions.Tag.mp3.Info.General.FramesCount.ToString;
  vSoundplayer.tag.mp3.Info.General.FramesCount.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.Info.General.FramesCount.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.tag.mp3.Info.General.FramesCount.Visible := True;

  vSoundplayer.tag.mp3.Info.General.BitRate := TText.Create(vSoundplayer.tag.mp3.Info.General.Box);
  vSoundplayer.tag.mp3.Info.General.BitRate.Name := 'A_SP_Tag_Mp3_Info_General_BitRate';
  vSoundplayer.tag.mp3.Info.General.BitRate.Parent := vSoundplayer.tag.mp3.Info.General.Box;
  vSoundplayer.tag.mp3.Info.General.BitRate.SetBounds(15, 170, vSoundplayer.tag.mp3.Info.General.Box.Width - 10, 27);
  vSoundplayer.tag.mp3.Info.General.BitRate.Text := 'BitRate : ' + soundplayer.player_actions.Tag.mp3.Info.General.BitRate.ToString + ' bps';
  vSoundplayer.tag.mp3.Info.General.BitRate.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.Info.General.BitRate.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.tag.mp3.Info.General.BitRate.Visible := True;

  vSoundplayer.tag.mp3.Info.General.CoverArtCount := TText.Create(vSoundplayer.tag.mp3.Info.General.Box);
  vSoundplayer.tag.mp3.Info.General.CoverArtCount.Name := 'A_SP_Tag_Mp3_Info_General_CoverArtCount';
  vSoundplayer.tag.mp3.Info.General.CoverArtCount.Parent := vSoundplayer.tag.mp3.Info.General.Box;
  vSoundplayer.tag.mp3.Info.General.CoverArtCount.SetBounds(15, 200, vSoundplayer.tag.mp3.Info.General.Box.Width - 10, 27);
  vSoundplayer.tag.mp3.Info.General.CoverArtCount.Text := 'Cover Art Count : ' + soundplayer.player_actions.Tag.mp3.Info.General.CoverArtCount.ToString;
  vSoundplayer.tag.mp3.Info.General.CoverArtCount.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.Info.General.CoverArtCount.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.tag.mp3.Info.General.CoverArtCount.Visible := True;

  vSoundplayer.tag.mp3.Info.General.PlayTime := TText.Create(vSoundplayer.tag.mp3.Info.General.Box);
  vSoundplayer.tag.mp3.Info.General.PlayTime.Name := 'A_SP_Tag_Mp3_Info_General_PlayTime';
  vSoundplayer.tag.mp3.Info.General.PlayTime.Parent := vSoundplayer.tag.mp3.Info.General.Box;
  vSoundplayer.tag.mp3.Info.General.PlayTime.SetBounds(15, 230, vSoundplayer.tag.mp3.Info.General.Box.Width - 10, 27);
  vSoundplayer.tag.mp3.Info.General.PlayTime.Text := 'Play : ' + soundplayer.player_actions.Tag.mp3.Info.General.PlayTime.ToString + ' times';
  vSoundplayer.tag.mp3.Info.General.PlayTime.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.Info.General.PlayTime.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.tag.mp3.Info.General.PlayTime.Visible := True;

  vSoundplayer.tag.mp3.Info.Mpeg.Box := TGroupBox.Create(vSoundplayer.tag.mp3.TabItem[2]);
  vSoundplayer.tag.mp3.Info.Mpeg.Box.Name := 'A_SP_Tag_Mp3_Info_Mpeg';
  vSoundplayer.tag.mp3.Info.Mpeg.Box.Parent := vSoundplayer.tag.mp3.TabItem[2];
  vSoundplayer.tag.mp3.Info.Mpeg.Box.SetBounds((vSoundplayer.tag.mp3.TabControl.Width / 2) + 5, 45, (vSoundplayer.tag.mp3.TabControl.Width / 2) - 15,
    vSoundplayer.tag.mp3.TabControl.Height - 45);
  vSoundplayer.tag.mp3.Info.Mpeg.Box.Text := 'MPEG';
  vSoundplayer.tag.mp3.Info.Mpeg.Box.Visible := True;

  vSoundplayer.tag.mp3.Info.Mpeg.FrameSize := TText.Create(vSoundplayer.tag.mp3.Info.Mpeg.Box);
  vSoundplayer.tag.mp3.Info.Mpeg.FrameSize.Name := 'A_SP_Tag_Mp3_Info_Mpeg_FrameSize';
  vSoundplayer.tag.mp3.Info.Mpeg.FrameSize.Parent := vSoundplayer.tag.mp3.Info.Mpeg.Box;
  vSoundplayer.tag.mp3.Info.Mpeg.FrameSize.SetBounds(15, 20, vSoundplayer.tag.mp3.Info.Mpeg.Box.Width - 10, 27);
  vSoundplayer.tag.mp3.Info.Mpeg.FrameSize.Text := 'Frame Size : ' + soundplayer.player_actions.Tag.mp3.Info.Mpeg.FrameSize.ToString;
  vSoundplayer.tag.mp3.Info.Mpeg.FrameSize.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.Info.Mpeg.FrameSize.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.tag.mp3.Info.Mpeg.FrameSize.Visible := True;

  vSoundplayer.tag.mp3.Info.Mpeg.SampleRate := TText.Create(vSoundplayer.tag.mp3.Info.Mpeg.Box);
  vSoundplayer.tag.mp3.Info.Mpeg.SampleRate.Name := 'A_SP_Tag_Mp3_Info_Mpeg_SampleRate';
  vSoundplayer.tag.mp3.Info.Mpeg.SampleRate.Parent := vSoundplayer.tag.mp3.Info.Mpeg.Box;
  vSoundplayer.tag.mp3.Info.Mpeg.SampleRate.SetBounds(15, 50, vSoundplayer.tag.mp3.Info.Mpeg.Box.Width - 10, 27);
  vSoundplayer.tag.mp3.Info.Mpeg.SampleRate.Text := 'Sample Rate : ' + soundplayer.player_actions.Tag.mp3.Info.Mpeg.SampleRate.ToString + ' Hz';
  vSoundplayer.tag.mp3.Info.Mpeg.SampleRate.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.Info.Mpeg.SampleRate.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.tag.mp3.Info.Mpeg.SampleRate.Visible := True;

  vSoundplayer.tag.mp3.Info.Mpeg.BitRate := TText.Create(vSoundplayer.tag.mp3.Info.Mpeg.Box);
  vSoundplayer.tag.mp3.Info.Mpeg.BitRate.Name := 'A_SP_Tag_Mp3_Info_Mpeg_BitRate';
  vSoundplayer.tag.mp3.Info.Mpeg.BitRate.Parent := vSoundplayer.tag.mp3.Info.Mpeg.Box;
  vSoundplayer.tag.mp3.Info.Mpeg.BitRate.SetBounds(15, 80, vSoundplayer.tag.mp3.Info.Mpeg.Box.Width - 10, 27);
  vSoundplayer.tag.mp3.Info.Mpeg.BitRate.Text := 'BitRate : ' + soundplayer.player_actions.Tag.mp3.Info.Mpeg.BitRate.ToString + ' bps';
  vSoundplayer.tag.mp3.Info.Mpeg.BitRate.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.Info.Mpeg.BitRate.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.tag.mp3.Info.Mpeg.BitRate.Visible := True;

  vSoundplayer.tag.mp3.Info.Mpeg.Padding := TCheckBox.Create(vSoundplayer.tag.mp3.Info.Mpeg.Box);
  vSoundplayer.tag.mp3.Info.Mpeg.Padding.Name := 'A_SP_Tag_Mp3_Info_Mpeg_Padding';
  vSoundplayer.tag.mp3.Info.Mpeg.Padding.Parent := vSoundplayer.tag.mp3.Info.Mpeg.Box;
  vSoundplayer.tag.mp3.Info.Mpeg.Padding.SetBounds(15, 110, vSoundplayer.tag.mp3.Info.Mpeg.Box.Width - 10, 27);
  vSoundplayer.tag.mp3.Info.Mpeg.Padding.IsChecked := soundplayer.player_actions.Tag.mp3.Info.Mpeg.Padding;
  vSoundplayer.tag.mp3.Info.Mpeg.Padding.Text := ' : Padding';
  vSoundplayer.tag.mp3.Info.Mpeg.Padding.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.Info.Mpeg.Padding.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.tag.mp3.Info.Mpeg.Padding.Enabled := False;
  vSoundplayer.tag.mp3.Info.Mpeg.Padding.Visible := True;

  vSoundplayer.tag.mp3.Info.Mpeg.Copyrighted := TCheckBox.Create(vSoundplayer.tag.mp3.Info.Mpeg.Box);
  vSoundplayer.tag.mp3.Info.Mpeg.Copyrighted.Name := 'A_SP_Tag_Mp3_Info_Mpeg_Copyrighted';
  vSoundplayer.tag.mp3.Info.Mpeg.Copyrighted.Parent := vSoundplayer.tag.mp3.Info.Mpeg.Box;
  vSoundplayer.tag.mp3.Info.Mpeg.Copyrighted.SetBounds(15, 140, vSoundplayer.tag.mp3.Info.Mpeg.Box.Width - 10, 27);
  vSoundplayer.tag.mp3.Info.Mpeg.Copyrighted.IsChecked := soundplayer.player_actions.Tag.mp3.Info.Mpeg.Copyrighted;
  vSoundplayer.tag.mp3.Info.Mpeg.Copyrighted.Text := ': Copyrighted';
  vSoundplayer.tag.mp3.Info.Mpeg.Copyrighted.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.Info.Mpeg.Copyrighted.Enabled := False;
  vSoundplayer.tag.mp3.Info.Mpeg.Copyrighted.Visible := True;

  vSoundplayer.tag.mp3.Info.Mpeg.Quality := TText.Create(vSoundplayer.tag.mp3.Info.Mpeg.Box);
  vSoundplayer.tag.mp3.Info.Mpeg.Quality.Name := 'A_SP_Tag_Mp3_Info_Mpeg_Quality';
  vSoundplayer.tag.mp3.Info.Mpeg.Quality.Parent := vSoundplayer.tag.mp3.Info.Mpeg.Box;
  vSoundplayer.tag.mp3.Info.Mpeg.Quality.SetBounds(15, 170, vSoundplayer.tag.mp3.Info.Mpeg.Box.Width - 10, 27);
  vSoundplayer.tag.mp3.Info.Mpeg.Quality.Text := 'Sound Quality : ' + soundplayer.player_actions.Tag.mp3.Info.Mpeg.Quality.ToString;
  vSoundplayer.tag.mp3.Info.Mpeg.Quality.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.Info.Mpeg.Quality.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.tag.mp3.Info.Mpeg.Quality.Visible := True;

  vSoundplayer.tag.mp3.Info.Mpeg.ChannelMode := TText.Create(vSoundplayer.tag.mp3.Info.Mpeg.Box);
  vSoundplayer.tag.mp3.Info.Mpeg.ChannelMode.Name := 'A_SP_Tag_Mp3_Info_Mpeg_ChannelMode';
  vSoundplayer.tag.mp3.Info.Mpeg.ChannelMode.Parent := vSoundplayer.tag.mp3.Info.Mpeg.Box;
  vSoundplayer.tag.mp3.Info.Mpeg.ChannelMode.SetBounds(15, 200, vSoundplayer.tag.mp3.Info.Mpeg.Box.Width - 10, 27);
  vSoundplayer.tag.mp3.Info.Mpeg.ChannelMode.Text := 'Channel Mode : ' + soundplayer.player_actions.Tag.mp3.Info.Mpeg.ChannelMode;
  vSoundplayer.tag.mp3.Info.Mpeg.ChannelMode.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.Info.Mpeg.ChannelMode.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.tag.mp3.Info.Mpeg.ChannelMode.Visible := True;

  vSoundplayer.tag.mp3.Info.Mpeg.Layer := TText.Create(vSoundplayer.tag.mp3.Info.Mpeg.Box);
  vSoundplayer.tag.mp3.Info.Mpeg.Layer.Name := 'A_SP_Tag_Mp3_Info_Mpeg_Layer';
  vSoundplayer.tag.mp3.Info.Mpeg.Layer.Parent := vSoundplayer.tag.mp3.Info.Mpeg.Box;
  vSoundplayer.tag.mp3.Info.Mpeg.Layer.SetBounds(15, 230, vSoundplayer.tag.mp3.Info.Mpeg.Box.Width - 10, 27);
  vSoundplayer.tag.mp3.Info.Mpeg.Layer.Text := 'Layers : ' + soundplayer.player_actions.Tag.mp3.Info.Mpeg.Layer;
  vSoundplayer.tag.mp3.Info.Mpeg.Layer.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.Info.Mpeg.Layer.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.tag.mp3.Info.Mpeg.Layer.Visible := True;

  vSoundplayer.tag.mp3.Info.Mpeg.ExtensionMode := TText.Create(vSoundplayer.tag.mp3.Info.Mpeg.Box);
  vSoundplayer.tag.mp3.Info.Mpeg.ExtensionMode.Name := 'A_SP_Tag_Mp3_Info_Mpeg_ExtensionMode';
  vSoundplayer.tag.mp3.Info.Mpeg.ExtensionMode.Parent := vSoundplayer.tag.mp3.Info.Mpeg.Box;
  vSoundplayer.tag.mp3.Info.Mpeg.ExtensionMode.SetBounds(15, 270, vSoundplayer.tag.mp3.Info.Mpeg.Box.Width - 10, 27);
  vSoundplayer.tag.mp3.Info.Mpeg.ExtensionMode.Text := 'Mode Extension : ' + soundplayer.player_actions.Tag.mp3.Info.Mpeg.ExtensionMode;
  vSoundplayer.tag.mp3.Info.Mpeg.ExtensionMode.TextSettings.FontColor := TAlphaColorRec.White;
  vSoundplayer.tag.mp3.Info.Mpeg.ExtensionMode.TextSettings.HorzAlign := TTextAlign.Leading;
  vSoundplayer.tag.mp3.Info.Mpeg.ExtensionMode.Visible := True;

  // The implentamentions of the Wav, Aiff, DS, DFF variables that not needed when mp3
  // But must keep for future use
  { vSoundplayer.tag.mp3.Info.Wav.Box := TGroupBox.Create(vSoundplayer.tag.mp3.TabItem[2]);
    vSoundplayer.tag.mp3.Info.Wav.Box.Name := 'A_SP_Tag_Mp3_Info_Wav';
    vSoundplayer.tag.mp3.Info.Wav.Box.Parent := vSoundplayer.tag.mp3.TabItem[2];
    vSoundplayer.tag.mp3.Info.Wav.Box.SetBounds(330, 15, 150, vSoundplayer.tag.mp3.TabControl.Height - 45);
    vSoundplayer.tag.mp3.Info.Wav.Box.Text := 'WAV';
    vSoundplayer.tag.mp3.Info.Wav.Box.Visible := True;

    vSoundplayer.tag.mp3.Info.Wav.FmtSize := TText.Create(vSoundplayer.tag.mp3.Info.Wav.Box);
    vSoundplayer.tag.mp3.Info.Wav.FmtSize.Name := 'A_SP_Tag_Mp3_Info_Wav_FmtSize';
    vSoundplayer.tag.mp3.Info.Wav.FmtSize.Parent := vSoundplayer.tag.mp3.Info.Wav.Box;
    vSoundplayer.tag.mp3.Info.Wav.FmtSize.SetBounds(5, 5, vSoundplayer.tag.mp3.Info.Wav.Box.Width - 10, 27);
    vSoundplayer.tag.mp3.Info.Wav.FmtSize.Text := soundplayer.player_actions.Tag.mp3.Info.Wav.FmtSize.ToString;
    vSoundplayer.tag.mp3.Info.Wav.FmtSize.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.Wav.FmtSize.Visible := True;

    vSoundplayer.tag.mp3.Info.Wav.FormatTag := TText.Create(vSoundplayer.tag.mp3.Info.Wav.Box);
    vSoundplayer.tag.mp3.Info.Wav.FormatTag.Name := 'A_SP_Tag_Mp3_Info_Wav_FormatTag';
    vSoundplayer.tag.mp3.Info.Wav.FormatTag.Parent := vSoundplayer.tag.mp3.Info.Wav.Box;
    vSoundplayer.tag.mp3.Info.Wav.FormatTag.SetBounds(5, 30, vSoundplayer.tag.mp3.Info.Wav.Box.Width - 10, 27);
    vSoundplayer.tag.mp3.Info.Wav.FormatTag.Text :=
    soundplayer.player_actions.Tag.mp3.Info.Wav.FormatTag.ToString;
    vSoundplayer.tag.mp3.Info.Wav.FormatTag.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.Wav.FormatTag.Visible := True;

    vSoundplayer.tag.mp3.Info.Wav.Channels := TText.Create(vSoundplayer.tag.mp3.Info.Wav.Box);
    vSoundplayer.tag.mp3.Info.Wav.Channels.Name := 'A_SP_Tag_Mp3_Info_Wav_Channels';
    vSoundplayer.tag.mp3.Info.Wav.Channels.Parent := vSoundplayer.tag.mp3.Info.Wav.Box;
    vSoundplayer.tag.mp3.Info.Wav.Channels.SetBounds(5, 60, vSoundplayer.tag.mp3.Info.Wav.Box.Width - 10, 27);
    vSoundplayer.tag.mp3.Info.Wav.Channels.Text := soundplayer.player_actions.Tag.mp3.Info.Wav.Channels.ToString;
    vSoundplayer.tag.mp3.Info.Wav.Channels.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.Wav.Channels.Visible := True;

    vSoundplayer.tag.mp3.Info.Wav.AvgBytesPerSec := TText.Create(vSoundplayer.tag.mp3.Info.Wav.Box);
    vSoundplayer.tag.mp3.Info.Wav.AvgBytesPerSec.Name := 'A_SP_Tag_Mp3_Info_Wav_AvgBytesPerSec';
    vSoundplayer.tag.mp3.Info.Wav.AvgBytesPerSec.Parent := vSoundplayer.tag.mp3.Info.Wav.Box;
    vSoundplayer.tag.mp3.Info.Wav.AvgBytesPerSec.SetBounds(5, 90, vSoundplayer.tag.mp3.Info.Wav.Box.Width
    - 10, 27);
    vSoundplayer.tag.mp3.Info.Wav.AvgBytesPerSec.Text :=
    soundplayer.player_actions.Tag.mp3.Info.Wav.AvgBytesPerSec.ToString;
    vSoundplayer.tag.mp3.Info.Wav.AvgBytesPerSec.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.Wav.AvgBytesPerSec.Visible := True;

    vSoundplayer.tag.mp3.Info.Wav.BlockAlign := TText.Create(vSoundplayer.tag.mp3.Info.Wav.Box);
    vSoundplayer.tag.mp3.Info.Wav.BlockAlign.Name := 'A_SP_Tag_Mp3_Info_Wav_BlockAlign';
    vSoundplayer.tag.mp3.Info.Wav.BlockAlign.Parent := vSoundplayer.tag.mp3.Info.Wav.Box;
    vSoundplayer.tag.mp3.Info.Wav.BlockAlign.SetBounds(5, 120, vSoundplayer.tag.mp3.Info.Wav.Box.Width
    - 10, 27);
    vSoundplayer.tag.mp3.Info.Wav.BlockAlign.Text :=
    soundplayer.player_actions.Tag.mp3.Info.Wav.BlockAlign.ToString;
    vSoundplayer.tag.mp3.Info.Wav.BlockAlign.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.Wav.BlockAlign.Visible := True;

    vSoundplayer.tag.mp3.Info.Wav.BitsPerSamples := TText.Create(vSoundplayer.tag.mp3.Info.Wav.Box);
    vSoundplayer.tag.mp3.Info.Wav.BitsPerSamples.Name := 'A_SP_Tag_Mp3_Info_Wav_BitsPerSamples';
    vSoundplayer.tag.mp3.Info.Wav.BitsPerSamples.Parent := vSoundplayer.tag.mp3.Info.Wav.Box;
    vSoundplayer.tag.mp3.Info.Wav.BitsPerSamples.SetBounds(5, 150, vSoundplayer.tag.mp3.Info.Wav.Box.Width
    - 10, 27);
    vSoundplayer.tag.mp3.Info.Wav.BitsPerSamples.Text :=
    soundplayer.player_actions.Tag.mp3.Info.Wav.BitsPerSamples.ToString;
    vSoundplayer.tag.mp3.Info.Wav.BitsPerSamples.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.Wav.BitsPerSamples.Visible := True;

    vSoundplayer.tag.mp3.Info.Wav.CbSize := TText.Create(vSoundplayer.tag.mp3.Info.Wav.Box);
    vSoundplayer.tag.mp3.Info.Wav.CbSize.Name := 'A_SP_Tag_Mp3_Info_Wav_CbSize';
    vSoundplayer.tag.mp3.Info.Wav.CbSize.Parent := vSoundplayer.tag.mp3.Info.Wav.Box;
    vSoundplayer.tag.mp3.Info.Wav.CbSize.SetBounds(5, 180, vSoundplayer.tag.mp3.Info.Wav.Box.Width - 10, 27);
    vSoundplayer.tag.mp3.Info.Wav.CbSize.Text := soundplayer.player_actions.Tag.mp3.Info.Wav.CbSize.ToString;
    vSoundplayer.tag.mp3.Info.Wav.CbSize.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.Wav.CbSize.Visible := True;

    vSoundplayer.tag.mp3.Info.Wav.ChannelMask := TText.Create(vSoundplayer.tag.mp3.Info.Wav.Box);
    vSoundplayer.tag.mp3.Info.Wav.ChannelMask.Name := 'A_SP_Tag_Mp3_Info_Wav_ChannelMask';
    vSoundplayer.tag.mp3.Info.Wav.ChannelMask.Parent := vSoundplayer.tag.mp3.Info.Wav.Box;
    vSoundplayer.tag.mp3.Info.Wav.ChannelMask.SetBounds(5, 210, vSoundplayer.tag.mp3.Info.Wav.Box.Width
    - 10, 27);
    vSoundplayer.tag.mp3.Info.Wav.ChannelMask.Text :=
    soundplayer.player_actions.Tag.mp3.Info.Wav.ChannelMask.ToString;
    vSoundplayer.tag.mp3.Info.Wav.ChannelMask.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.Wav.ChannelMask.Visible := True;

    vSoundplayer.tag.mp3.Info.Aiff.Box := TGroupBox.Create(vSoundplayer.tag.mp3.TabItem[2]);
    vSoundplayer.tag.mp3.Info.Aiff.Box.Name := 'A_SP_Tag_Mp3_Info_Aiff';
    vSoundplayer.tag.mp3.Info.Aiff.Box.Parent := vSoundplayer.tag.mp3.TabItem[2];
    vSoundplayer.tag.mp3.Info.Aiff.Box.SetBounds(490, 15, 150, vSoundplayer.tag.mp3.TabControl.Height - 45);
    vSoundplayer.tag.mp3.Info.Aiff.Box.Text := 'AIFF';
    vSoundplayer.tag.mp3.Info.Aiff.Box.Visible := True;

    vSoundplayer.tag.mp3.Info.Aiff.Channels := TText.Create(vSoundplayer.tag.mp3.Info.Aiff.Box);
    vSoundplayer.tag.mp3.Info.Aiff.Channels.Name := 'A_SP_Tag_Mp3_Info_Aiff_Channels';
    vSoundplayer.tag.mp3.Info.Aiff.Channels.Parent := vSoundplayer.tag.mp3.Info.Aiff.Box;
    vSoundplayer.tag.mp3.Info.Aiff.Channels.SetBounds(5, 5, vSoundplayer.tag.mp3.Info.Aiff.Box.Width - 10, 27);
    vSoundplayer.tag.mp3.Info.Aiff.Channels.Text :=
    soundplayer.player_actions.Tag.mp3.Info.Aiff.Channels.ToString;
    vSoundplayer.tag.mp3.Info.Aiff.Channels.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.Aiff.Channels.Visible := True;

    vSoundplayer.tag.mp3.Info.Aiff.SampleFrames := TText.Create(vSoundplayer.tag.mp3.Info.Aiff.Box);
    vSoundplayer.tag.mp3.Info.Aiff.SampleFrames.Name := 'A_SP_Tag_Mp3_Info_Aiff_SampleFrames';
    vSoundplayer.tag.mp3.Info.Aiff.SampleFrames.Parent := vSoundplayer.tag.mp3.Info.Aiff.Box;
    vSoundplayer.tag.mp3.Info.Aiff.SampleFrames.SetBounds(5, 30, vSoundplayer.tag.mp3.Info.Aiff.Box.Width
    - 10, 27);
    vSoundplayer.tag.mp3.Info.Aiff.SampleFrames.Text :=
    soundplayer.player_actions.Tag.mp3.Info.Aiff.SampleFrames.ToString;
    vSoundplayer.tag.mp3.Info.Aiff.SampleFrames.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.Aiff.SampleFrames.Visible := True;

    vSoundplayer.tag.mp3.Info.Aiff.SampleSize := TText.Create(vSoundplayer.tag.mp3.Info.Aiff.Box);
    vSoundplayer.tag.mp3.Info.Aiff.SampleSize.Name := 'A_SP_Tag_Mp3_Info_Aiff_SampleSize';
    vSoundplayer.tag.mp3.Info.Aiff.SampleSize.Parent := vSoundplayer.tag.mp3.Info.Aiff.Box;
    vSoundplayer.tag.mp3.Info.Aiff.SampleSize.SetBounds(5, 60, vSoundplayer.tag.mp3.Info.Aiff.Box.Width
    - 10, 27);
    vSoundplayer.tag.mp3.Info.Aiff.SampleSize.Text :=
    soundplayer.player_actions.Tag.mp3.Info.Aiff.SampleSize.ToString;
    vSoundplayer.tag.mp3.Info.Aiff.SampleSize.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.Aiff.SampleSize.Visible := True;

    vSoundplayer.tag.mp3.Info.Aiff.SampleRate := TText.Create(vSoundplayer.tag.mp3.Info.Aiff.Box);
    vSoundplayer.tag.mp3.Info.Aiff.SampleRate.Name := 'A_SP_Tag_Mp3_Info_Aiff_SampleRate';
    vSoundplayer.tag.mp3.Info.Aiff.SampleRate.Parent := vSoundplayer.tag.mp3.Info.Aiff.Box;
    vSoundplayer.tag.mp3.Info.Aiff.SampleRate.SetBounds(5, 90, vSoundplayer.tag.mp3.Info.Aiff.Box.Width
    - 10, 27);
    vSoundplayer.tag.mp3.Info.Aiff.SampleRate.Text :=
    soundplayer.player_actions.Tag.mp3.Info.Aiff.SampleRate.ToString;
    vSoundplayer.tag.mp3.Info.Aiff.SampleRate.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.Aiff.SampleRate.Visible := True;

    vSoundplayer.tag.mp3.Info.Aiff.CompressionID := TText.Create(vSoundplayer.tag.mp3.Info.Aiff.Box);
    vSoundplayer.tag.mp3.Info.Aiff.CompressionID.Name := 'A_SP_Tag_Mp3_Info_Aiff_CompressionID';
    vSoundplayer.tag.mp3.Info.Aiff.CompressionID.Parent := vSoundplayer.tag.mp3.Info.Aiff.Box;
    vSoundplayer.tag.mp3.Info.Aiff.CompressionID.SetBounds(5, 120, vSoundplayer.tag.mp3.Info.Aiff.Box.Width
    - 10, 27);
    vSoundplayer.tag.mp3.Info.Aiff.CompressionID.Text :=
    soundplayer.player_actions.Tag.mp3.Info.Aiff.CompressionID;
    vSoundplayer.tag.mp3.Info.Aiff.CompressionID.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.Aiff.CompressionID.Visible := True;

    vSoundplayer.tag.mp3.Info.Aiff.Compression := TText.Create(vSoundplayer.tag.mp3.Info.Aiff.Box);
    vSoundplayer.tag.mp3.Info.Aiff.Compression.Name := 'A_SP_Tag_Mp3_Info_Aiff_Compression';
    vSoundplayer.tag.mp3.Info.Aiff.Compression.Parent := vSoundplayer.tag.mp3.Info.Aiff.Box;
    vSoundplayer.tag.mp3.Info.Aiff.Compression.SetBounds(5, 150, vSoundplayer.tag.mp3.Info.Aiff.Box.Width
    - 10, 27);
    vSoundplayer.tag.mp3.Info.Aiff.Compression.Text := soundplayer.player_actions.Tag.mp3.Info.Aiff.Compression;
    vSoundplayer.tag.mp3.Info.Aiff.Compression.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.Aiff.Compression.Visible := True;

    vSoundplayer.tag.mp3.Info.DSInfo.Box := TGroupBox.Create(vSoundplayer.tag.mp3.TabItem[2]);
    vSoundplayer.tag.mp3.Info.DSInfo.Box.Name := 'A_SP_Tag_Mp3_Info_DSInfo';
    vSoundplayer.tag.mp3.Info.DSInfo.Box.Parent := vSoundplayer.tag.mp3.TabItem[2];
    vSoundplayer.tag.mp3.Info.DSInfo.Box.SetBounds(650, 15, 150, vSoundplayer.tag.mp3.TabControl.Height - 45);
    vSoundplayer.tag.mp3.Info.DSInfo.Box.Text := 'DS';
    vSoundplayer.tag.mp3.Info.DSInfo.Box.Visible := True;

    vSoundplayer.tag.mp3.Info.DSInfo.FormatVersion := TText.Create(vSoundplayer.tag.mp3.Info.DSInfo.Box);
    vSoundplayer.tag.mp3.Info.DSInfo.FormatVersion.Name := 'A_SP_Tag_Mp3_DSInfo_FormatVersion';
    vSoundplayer.tag.mp3.Info.DSInfo.FormatVersion.Parent := vSoundplayer.tag.mp3.Info.DSInfo.Box;
    vSoundplayer.tag.mp3.Info.DSInfo.FormatVersion.SetBounds(5, 5, vSoundplayer.tag.mp3.Info.DSInfo.Box.Width
    - 10, 27);
    vSoundplayer.tag.mp3.Info.DSInfo.FormatVersion.Text :=
    soundplayer.player_actions.Tag.mp3.Info.DS.FormatVersion.ToString;
    vSoundplayer.tag.mp3.Info.DSInfo.FormatVersion.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.DSInfo.FormatVersion.Visible := True;

    vSoundplayer.tag.mp3.Info.DSInfo.FormatID := TText.Create(vSoundplayer.tag.mp3.Info.DSInfo.Box);
    vSoundplayer.tag.mp3.Info.DSInfo.FormatID.Name := 'A_SP_Tag_Mp3_DSInfo_FormatID';
    vSoundplayer.tag.mp3.Info.DSInfo.FormatID.Parent := vSoundplayer.tag.mp3.Info.DSInfo.Box;
    vSoundplayer.tag.mp3.Info.DSInfo.FormatID.SetBounds(5, 30, vSoundplayer.tag.mp3.Info.DSInfo.Box.Width
    - 10, 27);
    vSoundplayer.tag.mp3.Info.DSInfo.FormatID.Text :=
    soundplayer.player_actions.Tag.mp3.Info.DS.FormatID.ToString;
    vSoundplayer.tag.mp3.Info.DSInfo.FormatID.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.DSInfo.FormatID.Visible := True;

    vSoundplayer.tag.mp3.Info.DSInfo.SamplingFrequency := TText.Create(vSoundplayer.tag.mp3.Info.DSInfo.Box);
    vSoundplayer.tag.mp3.Info.DSInfo.SamplingFrequency.Name := 'A_SP_Tag_Mp3_DSInfo_SamplingFrequency';
    vSoundplayer.tag.mp3.Info.DSInfo.SamplingFrequency.Parent := vSoundplayer.tag.mp3.Info.DSInfo.Box;
    vSoundplayer.tag.mp3.Info.DSInfo.SamplingFrequency.SetBounds(5, 60,
    vSoundplayer.tag.mp3.Info.DSInfo.Box.Width - 10, 27);
    vSoundplayer.tag.mp3.Info.DSInfo.SamplingFrequency.Text :=
    soundplayer.player_actions.Tag.mp3.Info.DS.SamplingFrequency.ToString;
    vSoundplayer.tag.mp3.Info.DSInfo.SamplingFrequency.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.DSInfo.SamplingFrequency.Visible := True;

    vSoundplayer.tag.mp3.Info.DSInfo.SampleCount := TText.Create(vSoundplayer.tag.mp3.Info.DSInfo.Box);
    vSoundplayer.tag.mp3.Info.DSInfo.SampleCount.Name := 'A_SP_Tag_Mp3_DSInfo_SampleCount';
    vSoundplayer.tag.mp3.Info.DSInfo.SampleCount.Parent := vSoundplayer.tag.mp3.Info.DSInfo.Box;
    vSoundplayer.tag.mp3.Info.DSInfo.SampleCount.SetBounds(5, 90, vSoundplayer.tag.mp3.Info.DSInfo.Box.Width
    - 10, 27);
    vSoundplayer.tag.mp3.Info.DSInfo.SampleCount.Text :=
    soundplayer.player_actions.Tag.mp3.Info.DS.SampleCount.ToString;
    vSoundplayer.tag.mp3.Info.DSInfo.SampleCount.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.DSInfo.SampleCount.Visible := True;

    vSoundplayer.tag.mp3.Info.DSInfo.ChannelType := TText.Create(vSoundplayer.tag.mp3.Info.DSInfo.Box);
    vSoundplayer.tag.mp3.Info.DSInfo.ChannelType.Name := 'A_SP_Tag_Mp3_DSInfo_ChannelType';
    vSoundplayer.tag.mp3.Info.DSInfo.ChannelType.Parent := vSoundplayer.tag.mp3.Info.DSInfo.Box;
    vSoundplayer.tag.mp3.Info.DSInfo.ChannelType.SetBounds(5, 120, vSoundplayer.tag.mp3.Info.DSInfo.Box.Width
    - 10, 27);
    vSoundplayer.tag.mp3.Info.DSInfo.ChannelType.Text := soundplayer.player_actions.Tag.mp3.Info.DS.ChannelType;
    vSoundplayer.tag.mp3.Info.DSInfo.ChannelType.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.DSInfo.ChannelType.Visible := True;

    vSoundplayer.tag.mp3.Info.DSInfo.BlockSizePerChannel := TText.Create(vSoundplayer.tag.mp3.Info.DSInfo.Box);
    vSoundplayer.tag.mp3.Info.DSInfo.BlockSizePerChannel.Name := 'A_SP_Tag_Mp3_DSInfo_BlockSizePerChannel';
    vSoundplayer.tag.mp3.Info.DSInfo.BlockSizePerChannel.Parent := vSoundplayer.tag.mp3.Info.DSInfo.Box;
    vSoundplayer.tag.mp3.Info.DSInfo.BlockSizePerChannel.SetBounds(5, 150,
    vSoundplayer.tag.mp3.Info.DSInfo.Box.Width - 10, 27);
    vSoundplayer.tag.mp3.Info.DSInfo.BlockSizePerChannel.Text :=
    soundplayer.player_actions.Tag.mp3.Info.DS.BlockSizePerChannel.ToString;
    vSoundplayer.tag.mp3.Info.DSInfo.BlockSizePerChannel.TextSettings.FontColor := TAlphaColorRec.White;
    vSoundplayer.tag.mp3.Info.DSInfo.BlockSizePerChannel.Visible := True;

    vSoundplayer.tag.mp3.Info.DFFInfo.Box := TGroupBox.Create(vSoundplayer.tag.mp3.TabItem[2]);
    vSoundplayer.tag.mp3.Info.DFFInfo.Box.Name := 'A_SP_Tag_Mp3_Info_DFFInfo';
    vSoundplayer.tag.mp3.Info.DFFInfo.Box.Parent := vSoundplayer.tag.mp3.TabItem[2];
    vSoundplayer.tag.mp3.Info.DFFInfo.Box.SetBounds(810, 15, 150, vSoundplayer.tag.mp3.TabControl.Height - 45);
    vSoundplayer.tag.mp3.Info.DFFInfo.Box.Text := 'DFF';
    vSoundplayer.tag.mp3.Info.DFFInfo.Box.Visible := True;

    vSoundplayer.Tag.mp3.Info.DFFInfo.FormatVersion:= TText.Create(vSoundplayer.tag.mp3.Info.DFFInfo.Box);
    vSoundplayer.Tag.mp3.Info.DFFInfo.FormatVersion.Name:= 'A_SP_Tag_Mp3_Info_DFFInfo_FormatVersion';
    vSoundplayer.Tag.mp3.Info.DFFInfo.FormatVersion.Parent:=  vSoundplayer.tag.mp3.Info.DFFInfo.Box;
    vSoundplayer.Tag.mp3.Info.DFFInfo.FormatVersion.SetBounds(5, 5, vSoundplayer.tag.mp3.Info.DFFInfo.Box.Width - 10, 27);
    vSoundplayer.Tag.mp3.Info.DFFInfo.FormatVersion.Text:= addons.soundplayer.Player.Tag.mp3.Info.DFF.FormatVersion;
    vSoundplayer.Tag.mp3.Info.DFFInfo.FormatVersion.TextSettings.FontColor:= TAlphaColorRec.White;
    vSoundplayer.Tag.mp3.Info.DFFInfo.FormatVersion.Visible:= True;

    vSoundplayer.Tag.mp3.Info.DFFInfo.SampleRate:= TText.Create(vSoundplayer.tag.mp3.Info.DFFInfo.Box);
    vSoundplayer.Tag.mp3.Info.DFFInfo.SampleRate.Name:= 'A_SP_Tag_Mp3_Info_DFFInfo_SampleRate';
    vSoundplayer.Tag.mp3.Info.DFFInfo.SampleRate.Parent:=  vSoundplayer.tag.mp3.Info.DFFInfo.Box;
    vSoundplayer.Tag.mp3.Info.DFFInfo.SampleRate.SetBounds(5, 30, vSoundplayer.tag.mp3.Info.DFFInfo.Box.Width - 10, 27);
    vSoundplayer.Tag.mp3.Info.DFFInfo.SampleRate.Text:= addons.soundplayer.Player.Tag.mp3.Info.DFF.SampleRate.ToString;
    vSoundplayer.Tag.mp3.Info.DFFInfo.SampleRate.TextSettings.FontColor:= TAlphaColorRec.White;
    vSoundplayer.Tag.mp3.Info.DFFInfo.SampleRate.Visible:= True;

    vSoundplayer.Tag.mp3.Info.DFFInfo.ChannelNumber:= TText.Create(vSoundplayer.tag.mp3.Info.DFFInfo.Box);
    vSoundplayer.Tag.mp3.Info.DFFInfo.ChannelNumber.Name:= 'A_SP_Tag_Mp3_Info_DFFInfo_ChannelNumber';
    vSoundplayer.Tag.mp3.Info.DFFInfo.ChannelNumber.Parent:=  vSoundplayer.tag.mp3.Info.DFFInfo.Box;
    vSoundplayer.Tag.mp3.Info.DFFInfo.ChannelNumber.SetBounds(5, 60, vSoundplayer.tag.mp3.Info.DFFInfo.Box.Width - 10, 27);
    vSoundplayer.Tag.mp3.Info.DFFInfo.ChannelNumber.Text:= addons.soundplayer.Player.Tag.mp3.Info.DFF.ChannelNumber.ToString;
    vSoundplayer.Tag.mp3.Info.DFFInfo.ChannelNumber.TextSettings.FontColor:= TAlphaColorRec.White;
    vSoundplayer.Tag.mp3.Info.DFFInfo.ChannelNumber.Visible:= True;

    vSoundplayer.Tag.mp3.Info.DFFInfo.CompressionName:= TText.Create(vSoundplayer.tag.mp3.Info.DFFInfo.Box);
    vSoundplayer.Tag.mp3.Info.DFFInfo.CompressionName.Name:= 'A_SP_Tag_Mp3_Info_DFFInfo_CompressionName';
    vSoundplayer.Tag.mp3.Info.DFFInfo.CompressionName.Parent:=  vSoundplayer.tag.mp3.Info.DFFInfo.Box;
    vSoundplayer.Tag.mp3.Info.DFFInfo.CompressionName.SetBounds(5, 90, vSoundplayer.tag.mp3.Info.DFFInfo.Box.Width - 10, 27);
    vSoundplayer.Tag.mp3.Info.DFFInfo.CompressionName.Text:= addons.soundplayer.Player.Tag.mp3.Info.DFF.CompressionName;
    vSoundplayer.Tag.mp3.Info.DFFInfo.CompressionName.TextSettings.FontColor:= TAlphaColorRec.White;
    vSoundplayer.Tag.mp3.Info.DFFInfo.CompressionName.Visible:= True;

    vSoundplayer.Tag.mp3.Info.DFFInfo.SampleCount:= TText.Create(vSoundplayer.tag.mp3.Info.DFFInfo.Box);
    vSoundplayer.Tag.mp3.Info.DFFInfo.SampleCount.Name:= 'A_SP_Tag_Mp3_Info_DFFInfo_SampleCount';
    vSoundplayer.Tag.mp3.Info.DFFInfo.SampleCount.Parent:=  vSoundplayer.tag.mp3.Info.DFFInfo.Box;
    vSoundplayer.Tag.mp3.Info.DFFInfo.SampleCount.SetBounds(5, 120, vSoundplayer.tag.mp3.Info.DFFInfo.Box.Width - 10, 27);
    vSoundplayer.Tag.mp3.Info.DFFInfo.SampleCount.Text:= addons.soundplayer.Player.Tag.mp3.Info.DFF.SampleCount.ToString;
    vSoundplayer.Tag.mp3.Info.DFFInfo.SampleCount.TextSettings.FontColor:= TAlphaColorRec.White;
    vSoundplayer.Tag.mp3.Info.DFFInfo.SampleCount.Visible:= True;

    vSoundplayer.Tag.mp3.Info.DFFInfo.PlayTime:= TText.Create(vSoundplayer.tag.mp3.Info.DFFInfo.Box);
    vSoundplayer.Tag.mp3.Info.DFFInfo.PlayTime.Name:= 'A_SP_Tag_Mp3_Info_DFFInfo_PlayTime';
    vSoundplayer.Tag.mp3.Info.DFFInfo.PlayTime.Parent:=  vSoundplayer.tag.mp3.Info.DFFInfo.Box;
    vSoundplayer.Tag.mp3.Info.DFFInfo.PlayTime.SetBounds(5, 150, vSoundplayer.tag.mp3.Info.DFFInfo.Box.Width - 10, 27);
    vSoundplayer.Tag.mp3.Info.DFFInfo.PlayTime.Text:= addons.soundplayer.Player.Tag.mp3.Info.DFF.PlayTime.ToString;
    vSoundplayer.Tag.mp3.Info.DFFInfo.PlayTime.TextSettings.FontColor:= TAlphaColorRec.White;
    vSoundplayer.Tag.mp3.Info.DFFInfo.PlayTime.Visible:= True;

    vSoundplayer.Tag.mp3.Info.DFFInfo.BitRate:= TText.Create(vSoundplayer.tag.mp3.Info.DFFInfo.Box);
    vSoundplayer.Tag.mp3.Info.DFFInfo.BitRate.Name:= 'A_SP_Tag_Mp3_Info_DFFInfo_BitRate';
    vSoundplayer.Tag.mp3.Info.DFFInfo.BitRate.Parent:=  vSoundplayer.tag.mp3.Info.DFFInfo.Box;
    vSoundplayer.Tag.mp3.Info.DFFInfo.BitRate.SetBounds(5, 180, vSoundplayer.tag.mp3.Info.DFFInfo.Box.Width - 10, 27);
    vSoundplayer.Tag.mp3.Info.DFFInfo.BitRate.Text:= addons.soundplayer.Player.Tag.mp3.Info.DFF.BitRate.ToString;
    vSoundplayer.Tag.mp3.Info.DFFInfo.BitRate.TextSettings.FontColor:= TAlphaColorRec.White;
    vSoundplayer.Tag.mp3.Info.DFFInfo.BitRate.Visible:= True;

    vSoundplayer.Tag.mp3.Info.DFFInfo.SoundDataLenght:= TText.Create(vSoundplayer.tag.mp3.Info.DFFInfo.Box);
    vSoundplayer.Tag.mp3.Info.DFFInfo.SoundDataLenght.Name:= 'A_SP_Tag_Mp3_Info_DFFInfo_SoundDataLenght';
    vSoundplayer.Tag.mp3.Info.DFFInfo.SoundDataLenght.Parent:=  vSoundplayer.tag.mp3.Info.DFFInfo.Box;
    vSoundplayer.Tag.mp3.Info.DFFInfo.SoundDataLenght.SetBounds(5, 210, vSoundplayer.tag.mp3.Info.DFFInfo.Box.Width - 10, 27);
    vSoundplayer.Tag.mp3.Info.DFFInfo.SoundDataLenght.Text:= addons.soundplayer.Player.Tag.mp3.Info.DFF.SoundDateLenght.ToString;
    vSoundplayer.Tag.mp3.Info.DFFInfo.SoundDataLenght.TextSettings.FontColor:= TAlphaColorRec.White;
    vSoundplayer.Tag.mp3.Info.DFFInfo.SoundDataLenght.Visible:= True;

    vSoundplayer.Tag.mp3.Info.DFFInfo.DSTFramesCount:= TText.Create(vSoundplayer.tag.mp3.Info.DFFInfo.Box);
    vSoundplayer.Tag.mp3.Info.DFFInfo.DSTFramesCount.Name:= 'A_SP_Tag_Mp3_Info_DFFInfo_DSTFramesCount';
    vSoundplayer.Tag.mp3.Info.DFFInfo.DSTFramesCount.Parent:=  vSoundplayer.tag.mp3.Info.DFFInfo.Box;
    vSoundplayer.Tag.mp3.Info.DFFInfo.DSTFramesCount.SetBounds(5, 240, vSoundplayer.tag.mp3.Info.DFFInfo.Box.Width - 10, 27);
    vSoundplayer.Tag.mp3.Info.DFFInfo.DSTFramesCount.Text:= addons.soundplayer.Player.Tag.mp3.Info.DFF.DSTFramesCount.ToString;
    vSoundplayer.Tag.mp3.Info.DFFInfo.DSTFramesCount.TextSettings.FontColor:= TAlphaColorRec.White;
    vSoundplayer.Tag.mp3.Info.DFFInfo.DSTFramesCount.Visible:= True;

    vSoundplayer.Tag.mp3.Info.DFFInfo.DSTFramesRate:= TText.Create(vSoundplayer.tag.mp3.Info.DFFInfo.Box);
    vSoundplayer.Tag.mp3.Info.DFFInfo.DSTFramesRate.Name:= 'A_SP_Tag_Mp3_Info_DFFInfo_DSTFramesRate';
    vSoundplayer.Tag.mp3.Info.DFFInfo.DSTFramesRate.Parent:=  vSoundplayer.tag.mp3.Info.DFFInfo.Box;
    vSoundplayer.Tag.mp3.Info.DFFInfo.DSTFramesRate.SetBounds(5, 270, vSoundplayer.tag.mp3.Info.DFFInfo.Box.Width - 10, 27);
    vSoundplayer.Tag.mp3.Info.DFFInfo.DSTFramesRate.Text:= addons.soundplayer.Player.Tag.mp3.Info.DFF.DSTFramesRate.ToString;
    vSoundplayer.Tag.mp3.Info.DFFInfo.DSTFramesRate.TextSettings.FontColor:= TAlphaColorRec.White;
    vSoundplayer.Tag.mp3.Info.DFFInfo.DSTFramesRate.Visible:= True;

    vSoundplayer.Tag.mp3.Info.DFFInfo.Ratio:= TText.Create(vSoundplayer.tag.mp3.Info.DFFInfo.Box);
    vSoundplayer.Tag.mp3.Info.DFFInfo.Ratio.Name:= 'A_SP_Tag_Mp3_Info_DFFInfo_Ratio';
    vSoundplayer.Tag.mp3.Info.DFFInfo.Ratio.Parent:=  vSoundplayer.tag.mp3.Info.DFFInfo.Box;
    vSoundplayer.Tag.mp3.Info.DFFInfo.Ratio.SetBounds(5, 300, vSoundplayer.tag.mp3.Info.DFFInfo.Box.Width - 10, 27);
    vSoundplayer.Tag.mp3.Info.DFFInfo.Ratio.Text:= addons.soundplayer.Player.Tag.mp3.Info.DFF.Ratio.ToString;
    vSoundplayer.Tag.mp3.Info.DFFInfo.Ratio.TextSettings.FontColor:= TAlphaColorRec.White;
    vSoundplayer.Tag.mp3.Info.DFFInfo.Ratio.Visible:= True; }
end;

procedure Load;
const
  cTabNames: array [0 .. 2] of string = ('ID3v1', 'Id3v2', 'Info');
var
  vi: Integer;
begin
  extrafe.prog.State := 'addon_soundplayer_tag_mp3';

  uSoundplayer_Actions.Hide_Animations;

  vSoundplayer.tag.mp3.Back := TPanel.Create(vSoundplayer.scene.Soundplayer);
  vSoundplayer.tag.mp3.Back.Name := 'A_SP_Tag_Mp3';
  vSoundplayer.tag.mp3.Back.Parent := vSoundplayer.scene.Soundplayer;
  vSoundplayer.tag.mp3.Back.SetBounds((vSoundplayer.scene.Back.Width / 2) - 500, (vSoundplayer.scene.Back.Height / 2) - 350, 1000, 500);
  vSoundplayer.tag.mp3.Back.Visible := True;

  vSoundplayer.tag.mp3.Back_Blur := TGaussianBlurEffect.Create(vSoundplayer.tag.mp3.Back);
  vSoundplayer.tag.mp3.Back_Blur.Name := 'A_SP_Back_Blur';
  vSoundplayer.tag.mp3.Back_Blur.Parent := vSoundplayer.tag.mp3.Back;
  vSoundplayer.tag.mp3.Back_Blur.BlurAmount := 0.5;
  vSoundplayer.tag.mp3.Back_Blur.Enabled := False;

  CreateHeader(vSoundplayer.tag.mp3.Back, 'IcoMoon-Free', #$e935, 'Tag mp3', False, nil);

  vSoundplayer.tag.mp3.Main := TPanel.Create(vSoundplayer.tag.mp3.Back);
  vSoundplayer.tag.mp3.Main.Name := 'A_SP_Back_Main';
  vSoundplayer.tag.mp3.Main.Parent := vSoundplayer.tag.mp3.Back;
  vSoundplayer.tag.mp3.Main.SetBounds(0, 30, vSoundplayer.tag.mp3.Back.Width, vSoundplayer.tag.mp3.Back.Height - 30);
  vSoundplayer.tag.mp3.Main.Visible := True;

  vSoundplayer.tag.mp3.Logo := TImage.Create(vSoundplayer.tag.mp3.Main);
  vSoundplayer.tag.mp3.Logo.Name := 'A_SP_Tag_Mp3_Logo';
  vSoundplayer.tag.mp3.Logo.Parent := vSoundplayer.tag.mp3.Main;
  vSoundplayer.tag.mp3.Logo.SetBounds(vSoundplayer.tag.mp3.Main.Width - 60, 5, 50, 50);
  vSoundplayer.tag.mp3.Logo.Bitmap.LoadFromFile(addons.Soundplayer.Path.Images + 'sp_tag_mp3.png');
  vSoundplayer.tag.mp3.Logo.WrapMode := TImageWrapMode.Fit;
  vSoundplayer.tag.mp3.Logo.Visible := True;

  vSoundplayer.tag.mp3.TabControl := TTabControl.Create(vSoundplayer.tag.mp3.Main);
  vSoundplayer.tag.mp3.TabControl.Name := 'A_SP_Tag_Mp3_TabControl';
  vSoundplayer.tag.mp3.TabControl.Parent := vSoundplayer.tag.mp3.Main;
  vSoundplayer.tag.mp3.TabControl.SetBounds(10, 30, vSoundplayer.tag.mp3.Main.Width - 20, vSoundplayer.tag.mp3.Back.Height - 100);
  vSoundplayer.tag.mp3.TabControl.Visible := True;

  for vi := 0 to 2 do
  begin
    vSoundplayer.tag.mp3.TabItem[vi] := TTabItem.Create(vSoundplayer.tag.mp3.TabControl);
    vSoundplayer.tag.mp3.TabItem[vi].Name := 'A_SP_Tag_Mp3_TabItem_' + IntToStr(vi);
    vSoundplayer.tag.mp3.TabItem[vi].Parent := vSoundplayer.tag.mp3.TabControl;
    vSoundplayer.tag.mp3.TabItem[vi].Text := cTabNames[vi];
    vSoundplayer.tag.mp3.TabItem[vi].Width := vSoundplayer.tag.mp3.TabControl.Width;
    vSoundplayer.tag.mp3.TabItem[vi].Height := vSoundplayer.tag.mp3.TabControl.Height;
    vSoundplayer.tag.mp3.TabItem[vi].Visible := True;
  end;

  Set_ID3v1_Frame;
  Set_ID3v2_Frame;
  Set_Info_Frame;

  vSoundplayer.tag.mp3.Button_Save := TButton.Create(vSoundplayer.tag.mp3.Back);
  vSoundplayer.tag.mp3.Button_Save.Name := 'A_SP_Tag_Mp3_Save';
  vSoundplayer.tag.mp3.Button_Save.Parent := vSoundplayer.tag.mp3.Back;
  vSoundplayer.tag.mp3.Button_Save.SetBounds(100, vSoundplayer.tag.mp3.Back.Height - 34, 100, 24);
  vSoundplayer.tag.mp3.Button_Save.Text := 'Save changes';
  vSoundplayer.tag.mp3.Button_Save.OnClick := addons.Soundplayer.Input.mouse_tag.Button.OnMouseClick;
  vSoundplayer.tag.mp3.Button_Save.Visible := True;

  vSoundplayer.tag.mp3.Button_Cancel := TButton.Create(vSoundplayer.tag.mp3.Back);
  vSoundplayer.tag.mp3.Button_Cancel.Name := 'A_SP_Tag_Mp3_Cancel';
  vSoundplayer.tag.mp3.Button_Cancel.Parent := vSoundplayer.tag.mp3.Back;
  vSoundplayer.tag.mp3.Button_Cancel.SetBounds(vSoundplayer.tag.mp3.Back.Width - 200, vSoundplayer.tag.mp3.Back.Height - 34, 100, 24);
  vSoundplayer.tag.mp3.Button_Cancel.Text := 'Cancel';
  vSoundplayer.tag.mp3.Button_Cancel.OnClick := addons.Soundplayer.Input.mouse_tag.Button.OnMouseClick;
  vSoundplayer.tag.mp3.Button_Cancel.Visible := True;
end;

procedure SelectCover;
var
  vi: Integer;
begin
  vSoundplayer.tag.mp3.Back_Blur.Enabled := True;
  vSoundplayer.tag.mp3.TabControl.Enabled := False;

  vSoundplayer.tag.mp3.Cover_Select.Panel := TPanel.Create(vSoundplayer.scene.Soundplayer);
  vSoundplayer.tag.mp3.Cover_Select.Panel.Name := 'A_SP_Tag_Mp3_CoverSelet';
  vSoundplayer.tag.mp3.Cover_Select.Panel.Parent := vSoundplayer.scene.Soundplayer;
  vSoundplayer.tag.mp3.Cover_Select.Panel.SetBounds(extrafe.res.Half_Width - 275, extrafe.res.Half_Height - 300, 550, 400);
  vSoundplayer.tag.mp3.Cover_Select.Panel.Visible := True;

  CreateHeader(vSoundplayer.tag.mp3.Cover_Select.Panel, 'IcoMoon-Free', #$e90d, 'Choose cover type.', False, nil);

  vSoundplayer.tag.mp3.Cover_Select.Main := TPanel.Create(vSoundplayer.tag.mp3.Cover_Select.Panel);
  vSoundplayer.tag.mp3.Cover_Select.Main.Name := 'A_SP_Tag_Mp3_CoverSelet_Main';
  vSoundplayer.tag.mp3.Cover_Select.Main.Parent := vSoundplayer.tag.mp3.Cover_Select.Panel;
  vSoundplayer.tag.mp3.Cover_Select.Main.SetBounds(0, 30, vSoundplayer.tag.mp3.Cover_Select.Panel.Width, vSoundplayer.tag.mp3.Cover_Select.Panel.Height - 30);
  vSoundplayer.tag.mp3.Cover_Select.Main.Visible := True;

  vSoundplayer.tag.mp3.Cover_Select.List := TListBox.Create(vSoundplayer.tag.mp3.Cover_Select.Main);
  vSoundplayer.tag.mp3.Cover_Select.List.Name := 'A_SP_Tag_Mp3_CoverSelet_Main_List';
  vSoundplayer.tag.mp3.Cover_Select.List.Parent := vSoundplayer.tag.mp3.Cover_Select.Main;
  vSoundplayer.tag.mp3.Cover_Select.List.SetBounds(5, 5, vSoundplayer.tag.mp3.Cover_Select.Main.Width - 10, vSoundplayer.tag.mp3.Cover_Select.Main.Height - 60);
  vSoundplayer.tag.mp3.Cover_Select.List.Items.Add('Front Cover');
  vSoundplayer.tag.mp3.Cover_Select.List.Items.Add('Back Cover');
  vSoundplayer.tag.mp3.Cover_Select.List.Items.Add('CD Cover');
  vSoundplayer.tag.mp3.Cover_Select.List.Items.Add('Company Logo');
  vSoundplayer.tag.mp3.Cover_Select.List.Items.Add('Other');
  vSoundplayer.tag.mp3.Cover_Select.List.ItemIndex := 0;
  vSoundplayer.tag.mp3.Cover_Select.List.ItemHeight := 60;
  vSoundplayer.tag.mp3.Cover_Select.List.Visible := True;

  for vi := 0 to 4 do
  begin
    vSoundplayer.tag.mp3.Cover_Select.List.ListItems[vi].TextSettings.Font.Size := 24;
    vSoundplayer.tag.mp3.Cover_Select.List.ListItems[vi].StyledSettings := vSoundplayer.tag.mp3.Cover_Select.List.ListItems[vi].StyledSettings -
      [TstyledSetting.Size];
  end;

  vSoundplayer.tag.mp3.Cover_Select.Load := TButton.Create(vSoundplayer.tag.mp3.Cover_Select.Main);
  vSoundplayer.tag.mp3.Cover_Select.Load.Name := 'A_SP_Tag_Mp3_CoverSelet_Main_Load';
  vSoundplayer.tag.mp3.Cover_Select.Load.Parent := vSoundplayer.tag.mp3.Cover_Select.Main;
  vSoundplayer.tag.mp3.Cover_Select.Load.SetBounds(20, vSoundplayer.tag.mp3.Cover_Select.Main.Height - 40, 50, 30);
  vSoundplayer.tag.mp3.Cover_Select.Load.Text := 'Load';
  vSoundplayer.tag.mp3.Cover_Select.Load.OnClick := addons.Soundplayer.Input.mouse_tag.Button.OnMouseClick;
  vSoundplayer.tag.mp3.Cover_Select.Load.Visible := True;

  vSoundplayer.tag.mp3.Cover_Select.Cancel := TButton.Create(vSoundplayer.tag.mp3.Cover_Select.Main);
  vSoundplayer.tag.mp3.Cover_Select.Cancel.Name := 'A_SP_Tag_Mp3_CoverSelet_Main_Cancel';
  vSoundplayer.tag.mp3.Cover_Select.Cancel.Parent := vSoundplayer.tag.mp3.Cover_Select.Main;
  vSoundplayer.tag.mp3.Cover_Select.Cancel.SetBounds(vSoundplayer.tag.mp3.Cover_Select.Main.Width - 70, vSoundplayer.tag.mp3.Cover_Select.Main.Height -
    40, 50, 30);
  vSoundplayer.tag.mp3.Cover_Select.Cancel.Text := 'Cancel';
  vSoundplayer.tag.mp3.Cover_Select.Cancel.OnClick := addons.Soundplayer.Input.mouse_tag.Button.OnMouseClick;
  vSoundplayer.tag.mp3.Cover_Select.Cancel.Visible := True;
end;

procedure Free;
begin
  extrafe.prog.State := 'addon_soundplayer';
  vSoundplayer.scene.Back_Blur.Enabled := False;
  FreeAndNil(vSoundplayer.tag.mp3.Back);
end;

procedure Cover_Label(vShow: Boolean);
begin

end;

procedure Lyrics_Add;
begin
  vSoundplayer.tag.mp3.Back_Blur.Enabled := True;
  vSoundplayer.tag.mp3.TabControl.Enabled := False;

  vSoundplayer.tag.mp3.Lyrics_Add.Panel := TPanel.Create(vSoundplayer.scene.Soundplayer);
  vSoundplayer.tag.mp3.Lyrics_Add.Panel.Name := 'A_SP_Tag_Mp3_LyricsAdd';
  vSoundplayer.tag.mp3.Lyrics_Add.Panel.Parent := vSoundplayer.scene.Soundplayer;
  vSoundplayer.tag.mp3.Lyrics_Add.Panel.SetBounds(extrafe.res.Half_Width - 175, extrafe.res.Half_Height - 100, 350, 200);
  vSoundplayer.tag.mp3.Lyrics_Add.Panel.Visible := True;

  CreateHeader(vSoundplayer.tag.mp3.Lyrics_Add.Panel, 'IcoMoon-Free', #$e922, 'How to add lyrics?', False, nil);

  vSoundplayer.tag.mp3.Lyrics_Add.Main := TPanel.Create(vSoundplayer.tag.mp3.Lyrics_Add.Panel);
  vSoundplayer.tag.mp3.Lyrics_Add.Main.Name := 'A_SP_Tag_Mp3_LyricsAdd_Main';
  vSoundplayer.tag.mp3.Lyrics_Add.Main.Parent := vSoundplayer.tag.mp3.Lyrics_Add.Panel;
  vSoundplayer.tag.mp3.Lyrics_Add.Main.SetBounds(0, 30, vSoundplayer.tag.mp3.Lyrics_Add.Panel.Width, vSoundplayer.tag.mp3.Lyrics_Add.Panel.Height - 30);
  vSoundplayer.tag.mp3.Lyrics_Add.Main.Visible := True;

  vSoundplayer.tag.mp3.Lyrics_Add.Radio_Above := TRadioButton.Create(vSoundplayer.tag.mp3.Lyrics_Add.Main);
  vSoundplayer.tag.mp3.Lyrics_Add.Radio_Above.Name := 'A_SP_Tag_Mp3_LyricsAdd_Main_Radio_Above';
  vSoundplayer.tag.mp3.Lyrics_Add.Radio_Above.Parent := vSoundplayer.tag.mp3.Lyrics_Add.Main;
  vSoundplayer.tag.mp3.Lyrics_Add.Radio_Above.SetBounds(10, 20, 280, 24);
  vSoundplayer.tag.mp3.Lyrics_Add.Radio_Above.Text := 'Add lyrics to the end of the line.';
  vSoundplayer.tag.mp3.Lyrics_Add.Radio_Above.OnClick := addons.Soundplayer.Input.mouse_tag.Radio.OnMouseClick;
  vSoundplayer.tag.mp3.Lyrics_Add.Radio_Above.Visible := True;

  vSoundplayer.tag.mp3.Lyrics_Add.Radio_Clear := TRadioButton.Create(vSoundplayer.tag.mp3.Lyrics_Add.Main);
  vSoundplayer.tag.mp3.Lyrics_Add.Radio_Clear.Name := 'A_SP_Tag_Mp3_LyricsAdd_Main_Radio_Clear';
  vSoundplayer.tag.mp3.Lyrics_Add.Radio_Clear.Parent := vSoundplayer.tag.mp3.Lyrics_Add.Main;
  vSoundplayer.tag.mp3.Lyrics_Add.Radio_Clear.SetBounds(10, 60, 280, 24);
  vSoundplayer.tag.mp3.Lyrics_Add.Radio_Clear.Text := 'Clear the current lyrics and add the new ones.';
  vSoundplayer.tag.mp3.Lyrics_Add.Radio_Clear.OnClick := addons.Soundplayer.Input.mouse_tag.Radio.OnMouseClick;
  vSoundplayer.tag.mp3.Lyrics_Add.Radio_Clear.Visible := True;

  vSoundplayer.tag.mp3.Lyrics_Add.Add := TButton.Create(vSoundplayer.tag.mp3.Lyrics_Add.Main);
  vSoundplayer.tag.mp3.Lyrics_Add.Add.Name := 'A_SP_Tag_Mp3_LyricsAdd_Main_Add';
  vSoundplayer.tag.mp3.Lyrics_Add.Add.Parent := vSoundplayer.tag.mp3.Lyrics_Add.Main;
  vSoundplayer.tag.mp3.Lyrics_Add.Add.SetBounds(20, vSoundplayer.tag.mp3.Lyrics_Add.Main.Height - 40, 50, 30);
  vSoundplayer.tag.mp3.Lyrics_Add.Add.Text := 'Add';
  vSoundplayer.tag.mp3.Lyrics_Add.Add.Enabled := False;
  vSoundplayer.tag.mp3.Lyrics_Add.Add.OnClick := addons.Soundplayer.Input.mouse_tag.Button.OnMouseClick;
  vSoundplayer.tag.mp3.Lyrics_Add.Add.Visible := True;

  vSoundplayer.tag.mp3.Lyrics_Add.Cancel := TButton.Create(vSoundplayer.tag.mp3.Lyrics_Add.Main);
  vSoundplayer.tag.mp3.Lyrics_Add.Cancel.Name := 'A_SP_Tag_Mp3_LyricsAdd_Main_Cancel';
  vSoundplayer.tag.mp3.Lyrics_Add.Cancel.Parent := vSoundplayer.tag.mp3.Lyrics_Add.Main;
  vSoundplayer.tag.mp3.Lyrics_Add.Cancel.SetBounds(vSoundplayer.tag.mp3.Lyrics_Add.Main.Width - 70, vSoundplayer.tag.mp3.Lyrics_Add.Main.Height - 40, 50, 30);
  vSoundplayer.tag.mp3.Lyrics_Add.Cancel.Text := 'Cancel';
  vSoundplayer.tag.mp3.Lyrics_Add.Cancel.OnClick := addons.Soundplayer.Input.mouse_tag.Button.OnMouseClick;
  vSoundplayer.tag.mp3.Lyrics_Add.Cancel.Visible := True;
end;

procedure Lyrics_Get;
begin
  vSoundplayer.tag.mp3.Back_Blur.Enabled := True;

  vSoundplayer.tag.mp3.Lyrics_Int.Panel := TPanel.Create(vSoundplayer.scene.Soundplayer);
  vSoundplayer.tag.mp3.Lyrics_Int.Panel.Name := 'A_SP_Tag_Mp3_Lyrics_Get';
  vSoundplayer.tag.mp3.Lyrics_Int.Panel.Parent := vSoundplayer.scene.Soundplayer;
  vSoundplayer.tag.mp3.Lyrics_Int.Panel.SetBounds(extrafe.res.Half_Width - 300, extrafe.res.Half_Height - 450, 600, 700);
  vSoundplayer.tag.mp3.Lyrics_Int.Panel.Visible := True;

  CreateHeader(vSoundplayer.tag.mp3.Lyrics_Int.Panel, 'IcoMoon-Free', #$e922, 'Lyrics from Internet', False, nil);

  vSoundplayer.tag.mp3.Lyrics_Int.Main := TPanel.Create(vSoundplayer.tag.mp3.Lyrics_Int.Panel);
  vSoundplayer.tag.mp3.Lyrics_Int.Main.Name := 'A_SP_Tag_Mp3_Lyrics_Get_Main';
  vSoundplayer.tag.mp3.Lyrics_Int.Main.Parent := vSoundplayer.tag.mp3.Lyrics_Int.Panel;
  vSoundplayer.tag.mp3.Lyrics_Int.Main.SetBounds(0, 30, vSoundplayer.tag.mp3.Lyrics_Int.Panel.Width, vSoundplayer.tag.mp3.Lyrics_Int.Panel.Height - 30);
  vSoundplayer.tag.mp3.Lyrics_Int.Main.Visible := True;

  vSoundplayer.tag.mp3.Lyrics_Int.Info := TLabel.Create(vSoundplayer.tag.mp3.Lyrics_Int.Main);
  vSoundplayer.tag.mp3.Lyrics_Int.Info.Name := 'A_SP_Tag_Mp3_Lyrics_Get_Info';
  vSoundplayer.tag.mp3.Lyrics_Int.Info.Parent := vSoundplayer.tag.mp3.Lyrics_Int.Main;
  vSoundplayer.tag.mp3.Lyrics_Int.Info.SetBounds(175, 5, 300, 26);
  vSoundplayer.tag.mp3.Lyrics_Int.Info.Font.Size := 24;
  vSoundplayer.tag.mp3.Lyrics_Int.Info.Text := 'Lyrics By ';
  vSoundplayer.tag.mp3.Lyrics_Int.Info.Visible := True;

  vSoundplayer.tag.mp3.Lyrics_Int.Providers_Box := TVertScrollBox.Create(vSoundplayer.tag.mp3.Lyrics_Int.Main);
  vSoundplayer.tag.mp3.Lyrics_Int.Providers_Box.Name := 'A_SP_Tag_Mp3_Lyrics_Get_Providies_Box';
  vSoundplayer.tag.mp3.Lyrics_Int.Providers_Box.Parent := vSoundplayer.tag.mp3.Lyrics_Int.Main;
  vSoundplayer.tag.mp3.Lyrics_Int.Providers_Box.SetBounds(5, 35, 160, vSoundplayer.tag.mp3.Lyrics_Int.Main.Height - 95);
  vSoundplayer.tag.mp3.Lyrics_Int.Providers_Box.Visible := True;

  vSoundplayer.tag.mp3.Lyrics_Int.Providers[0] := TImage.Create(vSoundplayer.tag.mp3.Lyrics_Int.Providers_Box);
  vSoundplayer.tag.mp3.Lyrics_Int.Providers[0].Name := 'A_SP_Tag_Mp3_Lyrics_Get_Provider_0';
  vSoundplayer.tag.mp3.Lyrics_Int.Providers[0].Parent := vSoundplayer.tag.mp3.Lyrics_Int.Providers_Box;
  vSoundplayer.tag.mp3.Lyrics_Int.Providers[0].SetBounds(5, 5, 150, 60);
  vSoundplayer.tag.mp3.Lyrics_Int.Providers[0].Bitmap.LoadFromFile(addons.Soundplayer.Path.Images + 'scrapers/az.png');
  vSoundplayer.tag.mp3.Lyrics_Int.Providers[0].WrapMode := TImageWrapMode.Stretch;
  vSoundplayer.tag.mp3.Lyrics_Int.Providers[0].OnClick := addons.Soundplayer.Input.mouse_tag.Image.OnMouseClick;
  vSoundplayer.tag.mp3.Lyrics_Int.Providers[0].OnMouseEnter := addons.Soundplayer.Input.mouse_tag.Image.OnMouseEnter;
  vSoundplayer.tag.mp3.Lyrics_Int.Providers[0].OnMouseLeave := addons.Soundplayer.Input.mouse_tag.Image.OnMouseLeave;
  vSoundplayer.tag.mp3.Lyrics_Int.Providers[0].Visible := True;

  vSoundplayer.tag.mp3.Lyrics_Int.Providers_Glow[0] := TGlowEffect.Create(vSoundplayer.tag.mp3.Lyrics_Int.Providers[0]);
  vSoundplayer.tag.mp3.Lyrics_Int.Providers_Glow[0].Name := 'A_SP_Tag_Mp3_Lyrics_Get_Provider_Glow_0';
  vSoundplayer.tag.mp3.Lyrics_Int.Providers_Glow[0].Parent := vSoundplayer.tag.mp3.Lyrics_Int.Providers[0];
  vSoundplayer.tag.mp3.Lyrics_Int.Providers_Glow[0].GlowColor := TAlphaColorRec.Deepskyblue;
  vSoundplayer.tag.mp3.Lyrics_Int.Providers_Glow[0].Opacity := 0.9;
  vSoundplayer.tag.mp3.Lyrics_Int.Providers_Glow[0].Enabled := False;

  vSoundplayer.tag.mp3.Lyrics_Int.Lyrics_Box := TMemo.Create(vSoundplayer.tag.mp3.Lyrics_Int.Main);
  vSoundplayer.tag.mp3.Lyrics_Int.Lyrics_Box.Name := 'A_SP_Tag_Mp3_Lyrics_Get_Lyrics';
  vSoundplayer.tag.mp3.Lyrics_Int.Lyrics_Box.Parent := vSoundplayer.tag.mp3.Lyrics_Int.Main;
  vSoundplayer.tag.mp3.Lyrics_Int.Lyrics_Box.SetBounds(175, 35, vSoundplayer.tag.mp3.Lyrics_Int.Main.Width - 180,
    vSoundplayer.tag.mp3.Lyrics_Int.Main.Height - 95);
  vSoundplayer.tag.mp3.Lyrics_Int.Lyrics_Box.ReadOnly := True;
  vSoundplayer.tag.mp3.Lyrics_Int.Lyrics_Box.WordWrap := True;
  vSoundplayer.tag.mp3.Lyrics_Int.Lyrics_Box.TextSettings.HorzAlign := TTextAlign.Center;
  vSoundplayer.tag.mp3.Lyrics_Int.Lyrics_Box.Visible := True;

  vSoundplayer.tag.mp3.Lyrics_Int.Add := TButton.Create(vSoundplayer.tag.mp3.Lyrics_Int.Main);
  vSoundplayer.tag.mp3.Lyrics_Int.Add.Name := 'A_SP_Tag_Mp3_Lyrics_Get_Add';
  vSoundplayer.tag.mp3.Lyrics_Int.Add.Parent := vSoundplayer.tag.mp3.Lyrics_Int.Main;
  vSoundplayer.tag.mp3.Lyrics_Int.Add.SetBounds(70, vSoundplayer.tag.mp3.Lyrics_Int.Main.Height - 40, 100, 30);
  vSoundplayer.tag.mp3.Lyrics_Int.Add.Text := 'Add';
  vSoundplayer.tag.mp3.Lyrics_Int.Add.Enabled := False;
  vSoundplayer.tag.mp3.Lyrics_Int.Add.OnClick := addons.Soundplayer.Input.mouse_tag.Button.OnMouseClick;
  vSoundplayer.tag.mp3.Lyrics_Int.Add.OnMouseEnter := addons.Soundplayer.Input.mouse_tag.Button.OnMouseEnter;
  vSoundplayer.tag.mp3.Lyrics_Int.Add.Visible := True;

  vSoundplayer.tag.mp3.Lyrics_Int.Cancel := TButton.Create(vSoundplayer.tag.mp3.Lyrics_Int.Main);
  vSoundplayer.tag.mp3.Lyrics_Int.Cancel.Name := 'A_SP_Tag_Mp3_Lyrics_Get_Cancel';
  vSoundplayer.tag.mp3.Lyrics_Int.Cancel.Parent := vSoundplayer.tag.mp3.Lyrics_Int.Main;
  vSoundplayer.tag.mp3.Lyrics_Int.Cancel.SetBounds(vSoundplayer.tag.mp3.Lyrics_Int.Main.Width - 170, vSoundplayer.tag.mp3.Lyrics_Int.Main.Height - 40, 100, 30);
  vSoundplayer.tag.mp3.Lyrics_Int.Cancel.Text := 'Cancel';
  vSoundplayer.tag.mp3.Lyrics_Int.Cancel.OnClick := addons.Soundplayer.Input.mouse_tag.Button.OnMouseClick;
  vSoundplayer.tag.mp3.Lyrics_Int.Cancel.OnMouseEnter := addons.Soundplayer.Input.mouse_tag.Button.OnMouseEnter;
  vSoundplayer.tag.mp3.Lyrics_Int.Cancel.Visible := True;
end;

end.
