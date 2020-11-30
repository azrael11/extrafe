unit uLoad_Mouse;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Forms,
  FMX.Edit,
  FMX.Layouts,
  FMX.Listbox,
  FmxPasLibVlcPlayerUnit,
  BASS;

type
  TLOADING_BUTTON = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TLOADING_IMAGE = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TLOADING_EDIT = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
    procedure OnTyping(Sender: TObject);
    procedure OnChange(Sender: TObject);
  end;

type
  TLOADING_TEXT = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TLOADING_CHECKBOX = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TLOADING_COMBOBOX = class(TOBject)
    procedure OnChange(Sender: TObject);
  end;

type
  TLOADING_VIDEO = class(TObject)
    procedure OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
  end;

type
  TLOADING_INPUT_MOUSE = record
    Image: TLOADING_IMAGE;
    Button: TLOADING_BUTTON;
    Edit: TLOADING_EDIT;
    Text: TLOADING_TEXT;
    Checkbox: TLOADING_CHECKBOX;
    Combobox: TLOADING_COMBOBOX;
    Layout: TLOADING_VIDEO;
  end;

implementation

uses
  uLoad,
  uSnippets,
  uKeyboard,
  uLoad_AllTypes,
  uLoad_SetAll,
  uLoad_Login,
  uLoad_Register,
  uLoad_Forgat;

{ TLOADING_BUTTON }

procedure TLOADING_BUTTON.OnMouseClick(Sender: TObject);
begin
  BASS_ChannelPlay(sound.str_fx.general[0], false);
  if TButton(Sender).Name = 'Loading_Login_Login' then
  begin
    uLoad_Login.Login;
    if ex_load.Login.Warning.Visible = false then
      TButton(Sender).Cursor := crHourGlass;
  end
  else if TButton(Sender).Name = 'Loading_Login_Exit' then
    uLoad_Login.Exit_Program
  else if TButton(Sender).Name = 'Loading_Reg_Register' then
    uLoad_Register.Apply
  else if TButton(Sender).Name = 'Loading_Register_Error_Ok' then
    begin
      ex_load.Login.Panel.Visible := True;
      FreeAndNil(ex_load.Reg_Error.Panel);
    end
  else if TButton(Sender).Name = 'Loading_Reg_Cancel' then
    uLoad_Register.Cancel
  else if TButton(Sender).Name = 'Loading_FPass_Send' then
    uLoad_Forgat.Send_Pass_WithEmail(ex_load.F_Pass.Main.Email_V.Text)
  else if TButton(Sender).Name = 'Loading_FPass_Cancel' then
    uLoad_Forgat.Cancel
  else if TButton(Sender).Name = 'Loading_Terms_Close' then
  begin
    FreeAndNil(ex_load.Terms.Panel);
    ex_load.Reg.Main.Terms_Check.Enabled := True;
    uLoad_Register.Update_ReadTerms;
  end;
end;

procedure TLOADING_BUTTON.OnMouseEnter(Sender: TObject);
begin
  TButton(Sender).Cursor := crHandPoint;
end;

procedure TLOADING_BUTTON.OnMouseLeave(Sender: TObject);
begin

end;

{ TLOADING_IMAGE }

procedure TLOADING_IMAGE.OnMouseClick(Sender: TObject);
begin

end;

procedure TLOADING_IMAGE.OnMouseEnter(Sender: TObject);
begin

end;

procedure TLOADING_IMAGE.OnMouseLeave(Sender: TObject);
begin

end;

{ TLOADING_EDIT }
procedure TLOADING_EDIT.OnChange(Sender: TObject);
begin

end;

procedure TLOADING_EDIT.OnMouseClick(Sender: TObject);
begin

end;

procedure TLOADING_EDIT.OnMouseEnter(Sender: TObject);
begin
  if TEdit(Sender).Name = 'Loading_Register_User_V' then
    uLoad_Register.Enable_Help(0)
  else if TEdit(Sender).Name = 'Loading_Register_Pass_V' then
    uLoad_Register.Enable_Help(1)
  else if TEdit(Sender).Name = 'Loading_Register_RePass_V' then
    uLoad_Register.Enable_Help(2)
  else if TEdit(Sender).Name = 'Loading_Register_Email_V' then
    uLoad_Register.Enable_Help(3)
  else if TEdit(Sender).Name = 'Loading_Register_ReEmail_V' then
    uLoad_Register.Enable_Help(4)
  else if TEdit(Sender).Name = 'Loading_Register_Capt_V' then
    uLoad_Register.Enable_Help(7)
end;

procedure TLOADING_EDIT.OnMouseLeave(Sender: TObject);
begin

end;

procedure TLOADING_EDIT.OnTyping(Sender: TObject);
begin
  TEdit(Sender).Text := TrimRight(TEdit(Sender).Text);
  if TEdit(Sender).Name = 'Loading_Login_Pass_V' then
    uLoad_Login.Update_Password(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'Loading_Register_User_V' then
  begin
    if User.User_Total < 20 then
      uLoad_Register.Update_Username(TEdit(Sender).Text)
    else
      uLoad_Register.Update_Username_Limits(TEdit(Sender).Text);
  end
  else if TEdit(Sender).Name = 'Loading_Register_Pass_V' then
  begin
    if User.Pass_Total < 20 then
      uLoad_Register.Update_Password(TEdit(Sender).Text)
    else
      uLoad_Register.Update_Password_Limits(TEdit(Sender).Text);
  end
  else if TEdit(Sender).Name = 'Loading_Register_RePass_V' then
    uLoad_Register.Update_RePassword(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'Loading_Register_Email_V' then
    uLoad_Register.Update_Email(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'Loading_Register_ReEmail_V' then
    uLoad_Register.Update_ReEmail(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'Loading_Register_Capt_V' then
    uLoad_Register.Update_Captcha(TEdit(Sender).Text)
  else if TEdit(Sender).Name = 'Loading_FPass_Email_V' then
    uLoad_Forgat.Update_Email(TEdit(Sender).Text);
end;

{ TLOADING_TEXT }

procedure TLOADING_TEXT.OnMouseClick(Sender: TObject);
begin
  if TText(Sender).TextSettings.FontColor <> TAlphaColorRec.Grey then
  begin
    if TText(Sender).Name = 'Loading_Login_Register' then
    begin
      BASS_ChannelPlay(sound.str_fx.general[0], false);
      if extrafe.databases.online_connected then
        uLoad_SetAll.Register_Form
      else
        uLoad_SetAll.Register_Error;
    end
    else if TText(Sender).Name = 'Loading_Login_Forget_Pass' then
      uLoad_SetAll.Login_Forget_Password
    else if TText(Sender).Name = 'Loading_Login_Pass_Show' then
      uLoad_Login.Show_Password
    else if TText(Sender).Name = 'Loading_Register_Capt_Refresh' then
      uLoad_Register.Refresh_Captcha
    else if TText(Sender).Name = 'Loading_Register_Terms' then
      uLoad_SetAll.Register_Terms
    else if TImage(Sender).Name = 'Loading_Register_Pass_Show' then
      uLoad_Register.Show_Password
    else if TImage(Sender).Name = 'Loading_Register_RePass_Show' then
      uLoad_Register.Show_RePassword
    else if TText(Sender).Name = 'Loading_Intro_Text' then
      uLoad.Skip_Intro
  end;
end;

procedure TLOADING_TEXT.OnMouseEnter(Sender: TObject);
begin
  if TText(Sender).TextSettings.FontColor <> TAlphaColorRec.Grey then
  begin
    if TText(Sender).Name = 'Loading_Intro_Text' then
      ex_load.Intro.Text.TextSettings.FontColor := TAlphaColorRec.Deepskyblue
    else if TText(Sender).Name = 'Loading_Login_Register' then
      uSnippets.HyperLink_OnMouseOver(TText(Sender))
    else if TText(Sender).Name = 'Loading_Login_Forget_Pass' then
      uSnippets.HyperLink_OnMouseOver(TText(Sender))
    else if TText(Sender).Name = 'Loading_Login_Pass_Show' then
    begin
      ex_load.Login.Pass_Show_Glow.Enabled := True;
      TText(Sender).Cursor := crHandPoint;
    end
    else if TImage(Sender).Name = 'Loading_Register_Capt_Refresh' then
    begin
      ex_load.Reg.Main.Capt_Refresh_Glow.Enabled := True;
      TText(Sender).Cursor := crHandPoint;
    end
    else if TText(Sender).Name = 'Loading_Register_Terms' then
    begin
      uSnippets.HyperLink_OnMouseOver(TText(Sender));
      uLoad_Register.Enable_Help(5);
    end
    else if TText(Sender).Name = 'Loading_Register_Pass_Show' then
    begin

      ex_load.Reg.Main.Pass_Show_Glow.Enabled := True;
      TText(Sender).Cursor := crHandPoint;
    end
    else if TText(Sender).Name = 'Loading_Register_RePass_Show' then
    begin
      ex_load.Reg.Main.RePass_Show_Glow.Enabled := True;
      TText(Sender).Cursor := crHandPoint;
    end
  end;
end;

procedure TLOADING_TEXT.OnMouseLeave(Sender: TObject);
begin
  if TText(Sender).TextSettings.FontColor <> TAlphaColorRec.Grey then
  begin
    if TText(Sender).Name = 'Loading_Intro_Text' then
      ex_load.Intro.Text.TextSettings.FontColor := TAlphaColorRec.White
    else if TText(Sender).Name = 'Loading_Login_Register' then
    begin
      if not extrafe.databases.online_connected then
        uSnippets.HyperLink_OnMouseLeave(TText(Sender), TAlphaColorRec.Red)
      else
        uSnippets.HyperLink_OnMouseLeave(TText(Sender), TAlphaColorRec.White)
    end
    else if TText(Sender).Name = 'Loading_Login_Forget_Pass' then
      uSnippets.HyperLink_OnMouseLeave(TText(Sender), TAlphaColorRec.Red)
    else if TText(Sender).Name = 'Loading_Login_Pass_Show' then
      ex_load.Login.Pass_Show_Glow.Enabled := false
    else if TText(Sender).Name = 'Loading_Register_Capt_Refresh' then
      ex_load.Reg.Main.Capt_Refresh_Glow.Enabled := false
    else if TText(Sender).Name = 'Loading_Register_Terms' then
      uSnippets.HyperLink_OnMouseLeave(TText(Sender), TAlphaColorRec.White)
    else if TImage(Sender).Name = 'Loading_Register_Pass_Show' then
      ex_load.Reg.Main.Pass_Show_Glow.Enabled := false
    else if TText(Sender).Name = 'Loading_Register_RePass_Show' then
      ex_load.Reg.Main.RePass_Show_Glow.Enabled := false;
  end;
end;

{ TLOADING_CHECKBOX }

procedure TLOADING_CHECKBOX.OnMouseClick(Sender: TObject);
begin
  if TCheckBox(Sender).Name = 'Loading_Register_Terms_Check' then
    uLoad_Register.Update_AcceptTerms(not TCheckBox(Sender).IsChecked)
  else if TCheckBox(Sender).Name = 'Loading_Login_Pass_Remember'  then
    uLoad_Login.Check_Password_Remember(not TCheckBox(Sender).IsChecked);
end;

procedure TLOADING_CHECKBOX.OnMouseEnter(Sender: TObject);
begin
  if TCheckBox(Sender).Name = 'Loading_Register_Terms_Check' then
    uLoad_Register.Enable_Help(6);
  TCheckBox(Sender).Cursor := crHandPoint;
end;

procedure TLOADING_CHECKBOX.OnMouseLeave(Sender: TObject);
begin

end;

{ TLOADING_LAYOUT }

procedure TLOADING_VIDEO.OnMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin
  if TFmxPasLibVlcPlayer(Sender).Name = 'Loading_Intro' then
  begin
    ex_load.Intro.Video.Cursor := crDefault;
    ex_load.Intro.Text.Cursor := crDefault;
    ex_load.Intro.Text_Ani.Stop;
    ex_load.Intro.Text.Opacity := 1;
    ex_load.Intro.Fade_Count := 0;
  end;

end;

{ TLOADING_COMBOBOX }

procedure TLOADING_COMBOBOX.OnChange(Sender: TObject);
begin
  if TComboBox(Sender).Name = 'Loading_Login_User_V' then
    uLoad_Login.Change_User(TComboBox(Sender).ItemIndex);
end;

initialization

ex_load.Input.mouse.Button := TLOADING_BUTTON.Create;
ex_load.Input.mouse.Image := TLOADING_IMAGE.Create;
ex_load.Input.mouse.Edit := TLOADING_EDIT.Create;
ex_load.Input.mouse.Text := TLOADING_TEXT.Create;
ex_load.Input.mouse.Checkbox := TLOADING_CHECKBOX.Create;
ex_load.Input.mouse.Combobox := TLOADING_COMBOBOX.Create;
ex_load.Input.mouse.Layout := TLOADING_VIDEO.Create;

finalization

ex_load.Input.mouse.Button.Free;
ex_load.Input.mouse.Image.Free;
ex_load.Input.mouse.Edit.Free;
ex_load.Input.mouse.Text.Free;
ex_load.Input.mouse.Checkbox.Free;
ex_load.Input.mouse.Layout.Free;
ex_load.Input.mouse.Combobox.Free;

end.
