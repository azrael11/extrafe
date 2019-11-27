unit uTIme_Time_Actions;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  System.UiConsts,
  FMX.Types,
  BASS;

type
  TTIME_ADDON_TIMER = class(TObject)
    procedure onTimer(Sender: TObject);
  end;

procedure Get_Data;

procedure Update_Analog;
procedure Update_Digital;

procedure General_ShowType(vType: String);

procedure uTime_Time_Actions_ShowBothType(vType: String);
procedure uTime_Time_Actions_ShowBoth_Default;
procedure uTime_Time_Actions_ShowBoth_A_Up_D_Down;
procedure uTime_Time_Actions_ShowBoth_A_Down_D_Up;
procedure uTime_Time_Actions_ShowBoth_A_M_Up_D_M_Down;
procedure uTime_Time_Actions_ShowBoth_A_M_Down_D_M_Up;
procedure uTime_Time_Actions_ShowBoth_A_Box_Left_D_Box_Right;
procedure uTime_Time_Actions_ShowBoth_A_Box_Right_D_Box_Left;

procedure uTime_Time_Actions_Analog_ShowSecondsIndicator;
procedure uTIme_Time_Actions_Analog_ShowQuarters;
procedure uTime_Time_Actions_Analog_ShowHours;

procedure uTime_Time_Actions_Digital_SetFont(vFont_Family_Name: String);
procedure uTime_Time_Actions_Digital_SetFontColor(vFont_Color: TAlphaColor);
procedure uTime_Time_Actions_Digital_SetBackColor(vBack_Color: TAlphaColor);
procedure uTime_Time_Actions_Digital_SetBackStrokeColor(vBack_Color: TAlphaColor);
procedure uTime_Time_Actions_ChangeSep(vSep: String);

var
  Timer_Time: TTIME_ADDON_TIMER;

implementation

uses
  uDB_AUser,
  uDB,
  uLoad_AllTypes,
  uSnippet_Text,
  uTime_SetAll,
  uTime_AllTypes;

var
  vLast_Time_Check: TTime;

procedure Get_Data;
var
  vQuery: String;
begin
  vQuery := 'SELECT * FROM ADDON_TIME_TIME WHERE USER_ID=' + uDB_AUser.Local.Num.ToString;
  uDB.ExtraFE_Query_Local.Close;
  uDB.ExtraFE_Query_Local.SQL.Clear;
  uDB.ExtraFE_Query_Local.SQL.Add(vQuery);
  uDB.ExtraFE_Query_Local.Open;
  uDB.ExtraFE_Query_Local.First;

  Local.ADDONS.Time_D.Time.vType := uDB.ExtraFE_Query_Local.FieldByName('Time_Clock_Type').AsString;
  Local.ADDONS.Time_D.Time.Both_Analog_Width := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_BOTH_ANALOG_WIDTH').AsInteger;
  Local.ADDONS.Time_D.Time.Both_Analog_Height := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_BOTH_ANALOG_HEIGHT').AsInteger;
  Local.ADDONS.Time_D.Time.Both_Analog_X := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_BOTH_ANALOG_X').AsInteger;
  Local.ADDONS.Time_D.Time.Both_Analog_Y := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_BOTH_ANALOG_Y').AsInteger;
  Local.ADDONS.Time_D.Time.Both_Digital_Width := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_BOTH_DIGITAL_WIDTH').AsInteger;
  Local.ADDONS.Time_D.Time.Both_Digital_Height := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_BOTH_DIGITAL_HEIGHT').AsInteger;
  Local.ADDONS.Time_D.Time.Both_Digital_X := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_BOTH_DIGITAL_X').AsInteger;
  Local.ADDONS.Time_D.Time.Both_Digital_Y := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_BOTH_DIGITAL_Y').AsInteger;
  Local.ADDONS.Time_D.Time.Both_Selection := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_BOTH_SELECTION').AsString;
  Local.ADDONS.Time_D.Time.Analog_Width := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_ANALOG_WIDTH').AsInteger;
  Local.ADDONS.Time_D.Time.Analog_Height := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_ANALOG_HEIGHT').AsInteger;
  Local.ADDONS.Time_D.Time.Analog_X := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_ANALOG_X').AsInteger;
  Local.ADDONS.Time_D.Time.Analog_Y := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_ANALOG_Y').AsInteger;
  Local.ADDONS.Time_D.Time.Analog_Theme := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_ANALOG_THEME').AsString;
  Local.ADDONS.Time_D.Time.Analog_Color := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_ANALOG_COLOR').AsString;
  Local.ADDONS.Time_D.Time.Analog_Font := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_ANALOG_FONT').AsString;
  Local.ADDONS.Time_D.Time.Analog_Show_Ind := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_ANALOG_SHOWIND').AsBoolean;
  Local.ADDONS.Time_D.Time.Analog_Show_Nums := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_ANALOG_SHOWNUMS').AsBoolean;
  Local.ADDONS.Time_D.Time.Analog_Tick := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_ANALOG_TICK').AsBoolean;
  Local.ADDONS.Time_D.Time.Digital_Width := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_DIGITAL_WIDTH').AsInteger;
  Local.ADDONS.Time_D.Time.Digital_Height := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_DIGITAL_HEIGHT').AsInteger;
  Local.ADDONS.Time_D.Time.Digital_X := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_DIGITAL_X').AsInteger;
  Local.ADDONS.Time_D.Time.Digital_Y := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_DIGITAL_Y').AsInteger;
  Local.ADDONS.Time_D.Time.Digital_Color := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_DIGITAL_COLOR').AsString;
  Local.ADDONS.Time_D.Time.Digital_Font := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_DIGITAL_FONT').AsString;
  Local.ADDONS.Time_D.Time.Digital_Font_Color := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_DIGITAL_FONT_COLOR').AsString;
  Local.ADDONS.Time_D.Time.Digital_Sep := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_DIGITAL_SEP').AsString;
  Local.ADDONS.Time_D.Time.Digital_Sep_Color := uDB.ExtraFE_Query_Local.FieldByName('TIME_CLOCK_DIGITAL_SEP_COLOR').AsString;

end;

procedure Update_Analog;
var
  vActuall_Time: TTime;
  vHour: Word;
  vMinutes: Word;
  vSeconds: Word;
  vMilliseconds: Word;
begin
  vActuall_Time := now;
  DecodeTime(vActuall_Time, vHour, vMinutes, vSeconds, vMilliseconds);

  vTime.P_Time.Analog.Hour.RotationAngle := StrToInt(FormatFloat('0', (360 * vHour) / 12));
  vTime.P_Time.Analog.Minutes.RotationAngle := StrToInt(FormatFloat('0', (360 * vMinutes) / 60));
  if vTime.P_Time.Analog.Seconds.RotationAngle <> StrToInt(FormatFloat('0', (360 * vSeconds) / 60)) then
  begin
    // if addons.time.P_Time.Sound_Tick then
    BASS_ChannelPlay(ADDONS.Time.Sound.Clock[0], False)
    // else
    // BASS_ChannelPlay(addons.time.Sound.Clock[1], False);
    // addons.time.P_Time.Sound_Tick:= not addons.time.P_Time.Sound_Tick;
  end;
  vTime.P_Time.Analog.Seconds.RotationAngle := StrToInt(FormatFloat('0', (360 * vSeconds) / 60));
end;

procedure Update_Digital;
var
  vActuall_Time: TTime;
  vHour, vMinutes, vSeconds, vMilliseconds: Word;
  vHour_Last, vMinutes_Last, vSeconds_Last, vMilliseconds_Last: Word;
  vFirst, vSecond, vThird, vSep, vCalc: Single;
begin
  vActuall_Time := now;
  DecodeTime(vLast_Time_Check, vHour_Last, vMinutes_Last, vSeconds_Last, vMilliseconds_Last);
  DecodeTime(vActuall_Time, vHour, vMinutes, vSeconds, vMilliseconds);
  if ((vHour = vHour_Last) and (vMinutes = vMinutes_Last) and (vSeconds <> vSeconds_Last)) or
    ((vHour = vHour_Last) and (vMinutes <> vMinutes_Last) and (vSeconds <> vSeconds_Last)) or
    ((vHour <> vHour_Last) and (vMinutes <> vMinutes_Last) and (vSeconds <> vSeconds_Last)) then
  begin
    vTime.P_Time.Digital.Sep_1.Opacity := 1;
    vTime.P_Time.Digital.Sep_2.Opacity := 1;
    vTime.P_Time.Digital.Sep_1_Ani.Start;
    vTime.P_Time.Digital.Sep_2_Ani.Start;

    vTime.P_Time.Digital.Hour.Text := FloatToStr(vHour);
    if Length(vTime.P_Time.Digital.Hour.Text) < 2 then
      vTime.P_Time.Digital.Hour.Text := '0' + FloatToStr(vHour);
    vTime.P_Time.Digital.Minutes.Text := FloatToStr(vMinutes);
    if Length(vTime.P_Time.Digital.Minutes.Text) < 2 then
      vTime.P_Time.Digital.Minutes.Text := '0' + FloatToStr(vMinutes);
    vTime.P_Time.Digital.Seconds.Text := FloatToStr(vSeconds);
    if Length(vTime.P_Time.Digital.Seconds.Text) < 2 then
      vTime.P_Time.Digital.Seconds.Text := '0' + FloatToStr(vSeconds);

    vFirst := uSnippet_Text_ToPixels(vTime.P_Time.Digital.Hour);
    vSecond := uSnippet_Text_ToPixels(vTime.P_Time.Digital.Minutes);
    vThird := uSnippet_Text_ToPixels(vTime.P_Time.Digital.Seconds);
    vSep := uSnippet_Text_ToPixels(vTime.P_Time.Digital.Sep_1);

    vTime.P_Time.Digital.Hour.Width := vFirst;
    vTime.P_Time.Digital.Minutes.Width := vSecond;
    vTime.P_Time.Digital.Seconds.Width := vThird;
    vTime.P_Time.Digital.Sep_1.Width := vSep;
    vTime.P_Time.Digital.Sep_2.Width := vSep;

    vTime.P_Time.Digital.Hour.Position.X := 20;
    vTime.P_Time.Digital.Minutes.Position.X := (vTime.P_Time.Digital.Back.Width / 2) - (vSecond / 2);
    vTime.P_Time.Digital.Seconds.Position.X := (vTime.P_Time.Digital.Back.Width - 20) - vThird;
    vCalc := vTime.P_Time.Digital.Minutes.Position.X - (vTime.P_Time.Digital.Hour.Position.X + vTime.P_Time.Digital.Hour.Width);
    vCalc := (vTime.P_Time.Digital.Hour.Position.X + vTime.P_Time.Digital.Hour.Width) + (vCalc / 2) - (vTime.P_Time.Digital.Sep_1.Width / 2);
    vTime.P_Time.Digital.Sep_1.Position.X := vCalc;
    vCalc := vTime.P_Time.Digital.Seconds.Position.X - (vTime.P_Time.Digital.Minutes.Position.X + vTime.P_Time.Digital.Minutes.Width);
    vCalc := (vTime.P_Time.Digital.Minutes.Position.X + vTime.P_Time.Digital.Minutes.Width) + (vCalc / 2) - (vTime.P_Time.Digital.Sep_2.Width / 2);
    vTime.P_Time.Digital.Sep_2.Position.X := vCalc;
  end;
  vLast_Time_Check := vActuall_Time;
end;

/// /////////////////////////////////////////////////////////////////////////////
procedure General_ShowType(vType: String);
begin
  if vType = 'Analog' then
  begin
    vTime.P_Time.Analog.Back.Visible := True;
    vTime.P_Time.Digital.Back.Visible := False;
  end
  else if vType = 'Digital' then
  begin
    vTime.P_Time.Analog.Back.Visible := False;
    vTime.P_Time.Digital.Back.Visible := True;
  end
  else if vType = 'Both' then
  begin
    vTime.P_Time.Analog.Back.Visible := True;
    vTime.P_Time.Digital.Back.Visible := True;
  end;

  uDB_AUser.Local.ADDONS.Time_D.Time.vType := vType;
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDON_TIME_TIME', 'TIME_CLOCK_TYPE', vType, 'USER_ID', uDB_AUser.Local.Num.ToString);
end;

/// /////////////////////////////////////////////////////////////////////////////
procedure uTime_Time_Actions_ShowBothType(vType: String);
begin
  if vType = 'Default' then
    uTime_Time_Actions_ShowBoth_Default
  else if vType = 'Analog Up-Digital Down' then
    uTime_Time_Actions_ShowBoth_A_Up_D_Down
  else if vType = 'Analog Down-Digital Up' then
    uTime_Time_Actions_ShowBoth_A_Down_D_Up
  else if vType = 'Analog Middle Up-Digital Middle Down' then
    uTime_Time_Actions_ShowBoth_A_M_Up_D_M_Down
  else if vType = 'Analog Middle Down-Digital Middle Up' then
    uTime_Time_Actions_ShowBoth_A_M_Down_D_M_Up
  else if vType = 'Analog Boxed Left-Digital Boxed Right' then
    uTime_Time_Actions_ShowBoth_A_Box_Left_D_Box_Right
  else if vType = 'Analog Boxed Right-Digital Boxed Left' then
    uTime_Time_Actions_ShowBoth_A_Box_Right_D_Box_Left;
end;

procedure uTime_Time_Actions_ShowBoth_Default;
begin
  vTime.P_Time.Analog.Back.Scale.X := 1;
  vTime.P_Time.Analog.Back.Scale.Y := 1;

  vTime.P_Time.Analog.Back.Position.X := (vTime.P_Time.Back.Width / 2) - 300;
  vTime.P_Time.Analog.Back.Position.Y := (vTime.P_Time.Back.Height / 2) - 300;

  vTime.P_Time.Digital.Back.Scale.X := 1;
  vTime.P_Time.Digital.Back.Scale.Y := 1;

  vTime.P_Time.Digital.Back.Position.X := (vTime.P_Time.Back.Width / 2) - 300;
  vTime.P_Time.Digital.Back.Position.Y := (vTime.P_Time.Back.Height / 2) - 80;
end;

procedure uTime_Time_Actions_ShowBoth_A_Up_D_Down;
begin
  vTime.P_Time.Analog.Back.Scale.X := 1;
  vTime.P_Time.Analog.Back.Scale.Y := 1;

  vTime.P_Time.Analog.Back.Position.X := (vTime.P_Time.Back.Width / 2) - 300;
  vTime.P_Time.Analog.Back.Position.Y := 30;

  vTime.P_Time.Digital.Back.Scale.X := 1;
  vTime.P_Time.Digital.Back.Scale.Y := 1;

  vTime.P_Time.Digital.Back.Position.X := (vTime.P_Time.Back.Width / 2) - 300;
  vTime.P_Time.Digital.Back.Position.Y := vTime.P_Time.Back.Height - (vTime.P_Time.Digital.Back.Height + 30)
end;

procedure uTime_Time_Actions_ShowBoth_A_Down_D_Up;
begin
  vTime.P_Time.Analog.Back.Scale.X := 1;
  vTime.P_Time.Analog.Back.Scale.Y := 1;

  vTime.P_Time.Analog.Back.Position.X := (vTime.P_Time.Back.Width / 2) - 300;
  vTime.P_Time.Analog.Back.Position.Y := vTime.P_Time.Back.Height - (vTime.P_Time.Analog.Back.Height + 30);

  vTime.P_Time.Digital.Back.Scale.X := 1;
  vTime.P_Time.Digital.Back.Scale.Y := 1;

  vTime.P_Time.Digital.Back.Position.X := (vTime.P_Time.Back.Width / 2) - 300;
  vTime.P_Time.Digital.Back.Position.Y := 30;
end;

procedure uTime_Time_Actions_ShowBoth_A_M_Up_D_M_Down;
begin

end;

procedure uTime_Time_Actions_ShowBoth_A_M_Down_D_M_Up;
begin

end;

procedure uTime_Time_Actions_ShowBoth_A_Box_Left_D_Box_Right;
begin

end;

procedure uTime_Time_Actions_ShowBoth_A_Box_Right_D_Box_Left;
begin

end;

/// /////////////////////////////////////////////////////////////////////////////
// Analog
procedure uTIme_Time_Actions_Analog_ShowQuarters;
var
  vi: integer;
begin
  for vi := 0 to 3 do
    vTime.P_Time.Analog.Quarters[vi].Visible := not vTime.P_Time.Analog.Quarters[vi].Visible;
  // ADDONS.Time.P_Time.Analog_Img_Quarters_Show := vTime.P_Time.Analog.Quarters[0].Visible;
  // ADDONS.Time.Ini.Ini.WriteBool('TIME_LOCAL', 'Analog_ShowQuarters', ADDONS.Time.P_Time.Analog_Img_Quarters_Show);
end;

procedure uTime_Time_Actions_Analog_ShowHours;
var
  vi: integer;
begin
  for vi := 0 to 7 do
  begin
    vTime.P_Time.Analog.Hours[vi].Visible := not vTime.P_Time.Analog.Hours[vi].Visible;
    // ADDONS.Time.P_Time.Analog_Img_Hours_Show := vTime.P_Time.Analog.Hours[0].Visible;
    // ADDONS.Time.Ini.Ini.WriteBool('TIME_LOCAL', 'Analog_ShowHours', ADDONS.Time.P_Time.Analog_Img_Hours_Show);
  end;
end;

procedure uTime_Time_Actions_Analog_ShowSecondsIndicator;
begin
  vTime.P_Time.Analog.Seconds.Visible := not vTime.P_Time.Analog.Seconds.Visible;
  // ADDONS.Time.P_Time.Analog_Seconds_Indicator := vTime.P_Time.Analog.Seconds.Visible;
  // ADDONS.Time.Ini.Ini.WriteBool('TIME_LOCAL', 'Analog_ShowSecondsIndicator', ADDONS.Time.P_Time.Analog_Seconds_Indicator);
end;

/// /////////////////////////////////////////////////////////////////////////////
// Digital
procedure uTime_Time_Actions_Digital_SetFont(vFont_Family_Name: String);
begin
  if vFont_Family_Name <> 'Choose a font...' then
  begin
    vTime.P_Time.Digital.Hour.Font.Family := vFont_Family_Name;
    vTime.P_Time.Digital.Minutes.Font.Family := vFont_Family_Name;
    vTime.P_Time.Digital.Seconds.Font.Family := vFont_Family_Name;
    vTime.P_Time.Digital.Sep_1.Font.Family := vFont_Family_Name;
    vTime.P_Time.Digital.Sep_2.Font.Family := vFont_Family_Name;

    uDB_AUser.Local.ADDONS.Time_D.Time.Digital_Font := vFont_Family_Name;
    uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDON_TIME_TIME', 'TIME_CLOCK_DIGITAL_FONT', uDB_AUser.Local.ADDONS.Time_D.Time.Digital_Font, 'USER_ID',
      uDB_AUser.Local.Num.ToString);
  end;
end;

procedure uTime_Time_Actions_Digital_SetFontColor(vFont_Color: TAlphaColor);
begin
  vTime.P_Time.Digital.Hour.TextSettings.FontColor := vFont_Color;
  vTime.P_Time.Digital.Minutes.TextSettings.FontColor := vFont_Color;
  vTime.P_Time.Digital.Seconds.TextSettings.FontColor := vFont_Color;
  vTime.P_Time.Digital.Sep_1.TextSettings.FontColor := vFont_Color;
  vTime.P_Time.Digital.Sep_2.TextSettings.FontColor := vFont_Color;

  uDB_AUser.Local.ADDONS.Time_D.Time.Digital_Color := ColorToString(vFont_Color);
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDON_TIME_TIME', 'TIME_CLOCK_DIGITAL_COLOR', uDB_AUser.Local.ADDONS.Time_D.Time.Digital_Color, 'USER_ID',
    uDB_AUser.Local.Num.ToString);
end;

procedure uTime_Time_Actions_Digital_SetBackColor(vBack_Color: TAlphaColor);
begin
  vTime.P_Time.Digital.Rect.Fill.Color := vBack_Color;

  // ADDONS.Time.P_Time.Digital_Color_Back := ColorToString(vBack_Color);
  // ADDONS.Time.Ini.Ini.WriteString('TIME_LOCAL', 'Digital_Color_Back', ColorToString(vBack_Color));
end;

procedure uTime_Time_Actions_Digital_SetBackStrokeColor(vBack_Color: TAlphaColor);
begin
  vTime.P_Time.Digital.Rect.Stroke.Color := vBack_Color;
  // ADDONS.Time.P_Time.Digital_Color_Back_Stroke := ColorToString(vBack_Color);
  // ADDONS.Time.Ini.Ini.WriteString('TIME_LOCAL', 'Digital_Color_Back_Stroke', ColorToString(vBack_Color));
end;

procedure uTime_Time_Actions_ChangeSep(vSep: String);
begin
  vTime.P_Time.Digital.Sep_1.Text := vSep;
  vTime.P_Time.Digital.Sep_2.Text := vSep;

  uDB_AUser.Local.ADDONS.Time_D.Time.Digital_Sep := vSep;
  uDB.Query_Update(uDB.ExtraFE_Query_Local, 'ADDON_TIME_TIME', 'TIME_CLOCK_DIGITAL_SEP', uDB_AUser.Local.ADDONS.Time_D.Time.Digital_Sep, 'USER_ID',
    uDB_AUser.Local.Num.ToString);
end;

{ TTIME_ADDON_TIMER }

procedure TTIME_ADDON_TIMER.onTimer(Sender: TObject);
begin
  if TTimer(Sender).Name = 'A_T_P_Time_Timer' then
  begin
    if vTime.P_Time.Timer.Enabled then
    begin
      if uDB_AUser.Local.ADDONS.Time_D.Time.vType = 'Analog' then
        uTIme_Time_Actions.Update_Analog
      else if uDB_AUser.Local.ADDONS.Time_D.Time.vType = 'Digital' then
        uTIme_Time_Actions.Update_Digital
      else if uDB_AUser.Local.ADDONS.Time_D.Time.vType = 'Both' then
      begin
        uTIme_Time_Actions.Update_Analog;
        uTIme_Time_Actions.Update_Digital;
      end;
    end;
  end;
end;

initialization

Timer_Time := TTIME_ADDON_TIMER.Create;

finalization

Timer_Time.Free;

end.
