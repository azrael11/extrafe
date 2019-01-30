unit uSoundplayer_Tag_Mouse;

interface

uses
  System.Classes,
  System.UiTypes,
  FMX.Objects,
  FMX.StdCtrls;

type
  TSOUNDPLAYER_TAG_IMAGE = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
    procedure OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  end;

type
  TSOUNDPLAYER_TAG_BUTTON = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TSOUNDPLAYER_TAG_TEXT = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TSOUNDPLAYER_TAG_RADIOBUTTON = class(TObject)
    procedure OnMouseClick(Sender: TObject);
  end;

type
  TSOUNDPLAYER_TAG_CIRCLE = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
    procedure OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  end;

type
  TSOUNDPLAYER_MOUSE_TAG_ACTIONS = record
    Image: TSOUNDPLAYER_TAG_IMAGE;
    Button: TSOUNDPLAYER_TAG_BUTTON;
    Text: TSOUNDPLAYER_TAG_TEXT;
    Radio: TSOUNDPLAYER_TAG_RADIOBUTTON;
    Circle: TSOUNDPLAYER_TAG_CIRCLE;
  end;

implementation

uses
  uLoad_AllTypes,
  uSoundplayer_AllTypes,
  uSoundplayer_Tag_MP3_SetAll,
  uSoundplayer_Tag_MP3,
  uSoundplayer_Tag_OGG_SetAll,
  uSoundplayer_Tag_OGG;

{ TSOUNDPLAYER_TAG_IMAGE }

procedure TSOUNDPLAYER_TAG_IMAGE.OnMouseClick(Sender: TObject);
var
  viPos_mp3: Integer;
  viPos_ogg: Integer;
begin
  viPos_mp3 := Pos('addon_soundplayer_tag_mp3', extrafe.prog.State);
  viPos_ogg := Pos('addon_soundplayer_tag_opus', extrafe.prog.State);
  if viPos_mp3 <> 0 then
  begin
    if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_0' then
      uSoundplayer_Tag_Mp3.Rate_SelectStars(0)
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_1' then
      uSoundplayer_Tag_Mp3.Rate_SelectStars(1)
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_2' then
      uSoundplayer_Tag_Mp3.Rate_SelectStars(2)
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_3' then
      uSoundplayer_Tag_Mp3.Rate_SelectStars(3)
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_4' then
      uSoundplayer_Tag_Mp3.Rate_SelectStars(4)
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Covers_Cover_ArrowLeft' then
    begin
      if vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowLeft_Grey.Enabled = False then
        uSoundplayer_Tag_Mp3_Cover_Previous;
    end
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Covers_Cover_ArrowRight' then
    begin
      if vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowRight_Grey.Enabled = False then
        uSoundplayer_Tag_Mp3_Cover_Next;
    end
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Covers_AddComputer' then
    begin
      vSoundplayer.scene.OpenDialog.Name := 'A_SP_OpenDialog_Mp3_Cover_AddComputer';
      vSoundplayer.scene.OpenDialog.Execute;
    end
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Covers_Remove' then
    begin
      if vSoundplayer.Tag.mp3.ID3v2.Cover_Remove_Grey.Enabled = False then
        uSoundplayer_Tag_Mp3_Cover_Remove
    end
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Lyrics_AddComputer' then
    begin
      vSoundplayer.scene.OpenDialog.Name := 'A_SP_OpenDialog_Mp3_Lyrics_AddComputer';
      vSoundplayer.scene.OpenDialog.Execute;
    end
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Lyrics_Remove' then
    begin
      if vSoundplayer.Tag.mp3.ID3v2.Lyrics_Remove_Grey.Enabled = False then
        uSoundplayer_Tag_Mp3_Lyrics_Delete;
    end;
  end
  else if viPos_ogg <> 0 then
  begin
    if TImage(Sender).Name = 'A_SP_Tag_Opus_Cover_AddComputer' then
    begin
      vSoundplayer.scene.OpenDialog.Name := 'A_SP_OpenDialog_Ogg_Cover_AddComputer';
      vSoundplayer.scene.OpenDialog.Execute;
    end
    else if TImage(Sender).Name = 'A_SP_Tag_Opus_Covers_Remove' then
      uSoundplayer_Tag_Ogg_Cover_Delete
  end;
end;

procedure TSOUNDPLAYER_TAG_IMAGE.OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Single);
var
  viPos_mp3: Integer;
  viPos_ogg: Integer;
begin
  viPos_mp3 := Pos('addon_soundplayer_tag_mp3', extrafe.prog.State);
  viPos_ogg := Pos('addon_soundplayer_tag_opus', extrafe.prog.State);
  if viPos_mp3 <> 0 then
  begin
    if TImage(Sender).Name = ('A_SP_Tag_Mp3_ID3v2_Rate_'+ TImage(Sender).TagString) then
    begin
      if Button = TMouseButton.mbRight then
        uSoundplayer_Tag_Mp3.Rate_RemoveAll
    end;
  end
  else if viPos_ogg <> 0 then
  begin

  end;
end;

procedure TSOUNDPLAYER_TAG_IMAGE.OnMouseEnter(Sender: TObject);
var
  viPos_mp3: Integer;
  viPos_ogg: Integer;
begin
  viPos_mp3 := Pos('addon_soundplayer_tag_mp3', extrafe.prog.State);
  viPos_ogg := Pos('addon_soundplayer_tag_opus', extrafe.prog.State);
  if viPos_mp3 <> 0 then
  begin
    if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_0' then
      uSoundplayer_Tag_Mp3.Show_RateStars(0, False)
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_1' then
      uSoundplayer_Tag_Mp3.Show_RateStars(1, False)
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_2' then
      uSoundplayer_Tag_Mp3.Show_RateStars(2, False)
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_3' then
      uSoundplayer_Tag_Mp3.Show_RateStars(3, False)
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_4' then
      uSoundplayer_Tag_Mp3.Show_RateStars(4, False)
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Covers_Cover_ArrowLeft' then
    begin
      if vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowLeft_Grey.Enabled = False then
        vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowLeft_Glow.Enabled := True;
    end
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Covers_Cover_ArrowRight' then
    begin
      if vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowRight_Grey.Enabled = False then
        vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowRight_Glow.Enabled := True;
    end
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Covers_AddComputer' then
      vSoundplayer.Tag.mp3.ID3v2.Cover_Add_Computer_Glow.Enabled := True
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Covers_AddInternet' then
      vSoundplayer.Tag.mp3.ID3v2.Cover_Add_Internet_Glow.Enabled := True
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Covers_Remove' then
    begin
      if vSoundplayer.Tag.mp3.ID3v2.Cover_Remove_Grey.Enabled = False then
        vSoundplayer.Tag.mp3.ID3v2.Cover_Remove_Glow.Enabled := True
    end
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Lyrics_AddComputer' then
      vSoundplayer.Tag.mp3.ID3v2.Lyrics_Add_Computer_Glow.Enabled := True
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Lyrics_AddInternet' then
      vSoundplayer.Tag.mp3.ID3v2.Lyrics_Add_Internet_Glow.Enabled := True
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Lyrics_Remove' then
    begin
      if vSoundplayer.Tag.mp3.ID3v2.Lyrics_Remove_Grey.Enabled = False then
        vSoundplayer.Tag.mp3.ID3v2.Lyrics_Remove_Glow.Enabled := True;
    end;
  end
  else if viPos_ogg <> 0 then
  begin
    if TImage(Sender).Name = 'A_SP_Tag_Opus_Cover_AddComputer' then
      vSoundplayer.Tag.Opus.Cover_LoadFromComputer_Glow.Enabled := True
    else if TImage(Sender).Name = 'A_SP_Tag_Opus_Cover_AddInternet' then
      vSoundplayer.Tag.Opus.Cover_LoadFromInterent_Glow.Enabled := True
    else if TImage(Sender).Name = 'A_SP_Tag_Opus_Covers_Remove' then
    begin
      if vSoundplayer.Tag.Opus.Cover_Delete_Grey.Enabled = False then
        vSoundplayer.Tag.Opus.Cover_Delete_Glow.Enabled := True;
    end;
  end;
end;

procedure TSOUNDPLAYER_TAG_IMAGE.OnMouseLeave(Sender: TObject);
var
  viPos_mp3: Integer;
  viPos_ogg: Integer;
begin
  viPos_mp3 := Pos('addon_soundplayer_tag_mp3', extrafe.prog.State);
  viPos_ogg := Pos('addon_soundplayer_tag_opus', extrafe.prog.State);
  if viPos_mp3 <> 0 then
  begin
    if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_0' then
      uSoundplayer_Tag_Mp3.Show_RateStars(addons.soundplayer.Player.Tag.mp3.Rating, True)
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_1' then
      uSoundplayer_Tag_Mp3.Show_RateStars(addons.soundplayer.Player.Tag.mp3.Rating, True)
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_2' then
      uSoundplayer_Tag_Mp3.Show_RateStars(addons.soundplayer.Player.Tag.mp3.Rating, True)
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_3' then
      uSoundplayer_Tag_Mp3.Show_RateStars(addons.soundplayer.Player.Tag.mp3.Rating, True)
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_4' then
      uSoundplayer_Tag_Mp3.Show_RateStars(addons.soundplayer.Player.Tag.mp3.Rating, True)
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Covers_Cover_ArrowLeft' then
    begin
      if vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowLeft_Grey.Enabled = False then
        vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowLeft_Glow.Enabled := False;
    end
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Covers_Cover_ArrowRight' then
    begin
      if vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowRight_Grey.Enabled = False then
        vSoundplayer.Tag.mp3.ID3v2.Cover_ArrowRight_Glow.Enabled := False;
    end
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Covers_AddComputer' then
      vSoundplayer.Tag.mp3.ID3v2.Cover_Add_Computer_Glow.Enabled := False
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Covers_AddInternet' then
      vSoundplayer.Tag.mp3.ID3v2.Cover_Add_Internet_Glow.Enabled := False
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Covers_Remove' then
    begin
      if vSoundplayer.Tag.mp3.ID3v2.Cover_Remove_Grey.Enabled = False then
        vSoundplayer.Tag.mp3.ID3v2.Cover_Remove_Glow.Enabled := False
    end
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Lyrics_AddComputer' then
      vSoundplayer.Tag.mp3.ID3v2.Lyrics_Add_Computer_Glow.Enabled := False
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Lyrics_AddInternet' then
      vSoundplayer.Tag.mp3.ID3v2.Lyrics_Add_Internet_Glow.Enabled := False
    else if TImage(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Lyrics_Remove' then
    begin
      if vSoundplayer.Tag.mp3.ID3v2.Lyrics_Remove_Grey.Enabled = False then
        vSoundplayer.Tag.mp3.ID3v2.Lyrics_Remove_Glow.Enabled := False;
    end;
  end
  else if viPos_ogg <> 0 then
  begin
    if TImage(Sender).Name = 'A_SP_Tag_Opus_Cover_AddComputer' then
      vSoundplayer.Tag.Opus.Cover_LoadFromComputer_Glow.Enabled := False
    else if TImage(Sender).Name = 'A_SP_Tag_Opus_Cover_AddInternet' then
      vSoundplayer.Tag.Opus.Cover_LoadFromInterent_Glow.Enabled := False
    else if TImage(Sender).Name = 'A_SP_Tag_Opus_Covers_Remove' then
    begin
      if vSoundplayer.Tag.Opus.Cover_Delete_Grey.Enabled = False then
        vSoundplayer.Tag.Opus.Cover_Delete_Glow.Enabled := False;
    end;
  end;
end;

{ TSOUNDPLAYER_TAG_BUTTON }

procedure TSOUNDPLAYER_TAG_BUTTON.OnMouseClick(Sender: TObject);
var
  viPos_mp3: Integer;
  viPos_ogg: Integer;
begin
  viPos_mp3 := Pos('addon_soundplayer_tag_mp3', extrafe.prog.State);
  viPos_ogg := Pos('addon_soundplayer_tag_opus', extrafe.prog.State);
  if viPos_mp3 <> 0 then
  begin
    if TButton(Sender).Name = 'A_SP_Tag_Mp3_Save' then
      uSoundplayer_Tag_Mp3_Save
    else if TButton(Sender).Name = 'A_SP_Tag_Mp3_Cancel' then
      uSoundplayer_TagSet_Mp3_Free
    else if TButton(Sender).Name = 'A_SP_Tag_Mp3_CoverSelet_Main_Load' then
      uSoundplayer_Tag_Mp3_Cover_SetFromComputer(vSoundplayer.Tag.mp3.Cover_Select.List.ItemIndex)
    else if TButton(Sender).Name = 'A_SP_Tag_Mp3_CoverSelet_Main_Cancel' then
      uSoundplayer_Tag_Mp3_Cover_Select_Cancel
    else if TButton(Sender).Name = 'A_SP_Tag_Mp3_LyricsAdd_Main_Add' then
      uSoundplayer_Tag_Mp3_Lyrics_Load
    else if TButton(Sender).Name = 'A_SP_Tag_Mp3_LyricsAdd_Main_Cancel' then
      uSoundplayer_Tag_Mp3_Lyrics_Add_Cancel;
  end
  else if viPos_ogg <> 0 then
  begin
    if TButton(Sender).Name = 'A_SP_Tag_Opus_Save' then
      uSoundplayer_Tag_Ogg_Save
    else if TButton(Sender).Name = 'A_SP_Tag_Opus_Cancel' then
      uSoundplayer_Tag_Ogg_Cancel
  end
end;

procedure TSOUNDPLAYER_TAG_BUTTON.OnMouseEnter(Sender: TObject);
begin

end;

procedure TSOUNDPLAYER_TAG_BUTTON.OnMouseLeave(Sender: TObject);
begin

end;

{ TSOUNDPLAYER_TAG_TEXT }

procedure TSOUNDPLAYER_TAG_TEXT.OnMouseClick(Sender: TObject);
var
  viPos_mp3: Integer;
  viPos_ogg: Integer;
begin
  viPos_mp3 := Pos('addon_soundplayer_tag_mp3', extrafe.prog.State);
  viPos_ogg := Pos('addon_soundplayer_tag_opus', extrafe.prog.State);
  if viPos_mp3 <> 0 then
  begin
    if TText(Sender).Name = 'A_SP_Tag_Mp3_ID3v1_Transfer' then
      uSoundplayer_Tag_MP3_Transfer('to_2')
    else if TText(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Transfer' then
      uSoundplayer_Tag_MP3_Transfer('to_1');
  end
  else if viPos_ogg <> 0 then
  begin

  end;
end;

procedure TSOUNDPLAYER_TAG_TEXT.OnMouseEnter(Sender: TObject);
begin

end;

procedure TSOUNDPLAYER_TAG_TEXT.OnMouseLeave(Sender: TObject);
begin

end;

{ TSOUNDPLAYER_TAG_RADIOBUTTON }

procedure TSOUNDPLAYER_TAG_RADIOBUTTON.OnMouseClick(Sender: TObject);
var
  viPos_mp3: Integer;
  viPos_ogg: Integer;
begin
  viPos_mp3 := Pos('addon_soundplayer_tag_mp3', extrafe.prog.State);
  viPos_ogg := Pos('addon_soundplayer_tag_opus', extrafe.prog.State);
  if viPos_mp3 <> 0 then
  begin
    if TRadioButton(Sender).Name = 'A_SP_Tag_Mp3_LyricsAdd_Main_Radio_Above' then
      vSoundplayer.Tag.mp3.Lyrics_Add.Add.Enabled := True
    else if TRadioButton(Sender).Name = 'A_SP_Tag_Mp3_LyricsAdd_Main_Radio_Clear' then
      vSoundplayer.Tag.mp3.Lyrics_Add.Add.Enabled := True;
  end
  else if viPos_ogg <> 0 then
  begin

  end;
end;

{ TSOUNDPLAYER_TAG_CIRCLE }

procedure TSOUNDPLAYER_TAG_CIRCLE.OnMouseClick(Sender: TObject);
begin

end;

procedure TSOUNDPLAYER_TAG_CIRCLE.OnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Single);
begin

end;

procedure TSOUNDPLAYER_TAG_CIRCLE.OnMouseEnter(Sender: TObject);
begin
  if TCircle(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_Dot_0' then
    uSoundplayer_Tag_Mp3.Show_RateStars(0, False)
  else if TCircle(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_Dot_1' then
    uSoundplayer_Tag_Mp3.Show_RateStars(1, False)
  else if TCircle(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_Dot_2' then
    uSoundplayer_Tag_Mp3.Show_RateStars(2, False)
  else if TCircle(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_Dot_3' then
    uSoundplayer_Tag_Mp3.Show_RateStars(3, False)
  else if TCircle(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_Dot_4' then
    uSoundplayer_Tag_Mp3.Show_RateStars(4, False)
end;

procedure TSOUNDPLAYER_TAG_CIRCLE.OnMouseLeave(Sender: TObject);
begin
  if TCircle(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_Dot_0' then
    uSoundplayer_Tag_Mp3.Show_RateStars(addons.soundplayer.Player.Tag.mp3.Rating, True)
  else if TCircle(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_Dot_1' then
    uSoundplayer_Tag_Mp3.Show_RateStars(addons.soundplayer.Player.Tag.mp3.Rating, True)
  else if TCircle(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_Dot_2' then
    uSoundplayer_Tag_Mp3.Show_RateStars(addons.soundplayer.Player.Tag.mp3.Rating, True)
  else if TCircle(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_Dot_3' then
    uSoundplayer_Tag_Mp3.Show_RateStars(addons.soundplayer.Player.Tag.mp3.Rating, True)
  else if TCircle(Sender).Name = 'A_SP_Tag_Mp3_ID3v2_Rate_Dot_4' then
    uSoundplayer_Tag_Mp3.Show_RateStars(addons.soundplayer.Player.Tag.mp3.Rating, True)
end;

initialization

addons.soundplayer.Input.mouse_tag.Image := TSOUNDPLAYER_TAG_IMAGE.Create;
addons.soundplayer.Input.mouse_tag.Button := TSOUNDPLAYER_TAG_BUTTON.Create;
addons.soundplayer.Input.mouse_tag.Text := TSOUNDPLAYER_TAG_TEXT.Create;
addons.soundplayer.Input.mouse_tag.Radio := TSOUNDPLAYER_TAG_RADIOBUTTON.Create;
addons.soundplayer.Input.mouse_tag.Circle := TSOUNDPLAYER_TAG_CIRCLE.Create;

finalization

addons.soundplayer.Input.mouse_tag.Image.Free;
addons.soundplayer.Input.mouse_tag.Button.Free;
addons.soundplayer.Input.mouse_tag.Text.Free;
addons.soundplayer.Input.mouse_tag.Radio.Free;
addons.soundplayer.Input.mouse_tag.Circle.Free;

end.
