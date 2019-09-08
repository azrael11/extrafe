unit uMain_Config_Profile_User;

interface

uses
  System.Classes,
  System.SysUtils,
  System.UiTypes,
  System.DateUtils,
  FMX.StdCtrls,
  FMX.Types,
  FMX.Objects,
  FMX.Effects,
  FMX.Filter.Effects,
  FMX.Edit,
  FMX.ILLed,
  FMX.LPTransparentControl;

type
  TPERSONAL = record
    Name: String;
    Surname: String;
    Genre: Boolean;
  end;

type
  TPROFILE_AVATAR_VARIABLES = record
    Page: Integer;
    Checked: Integer;
  end;

procedure Load;
procedure Free;
procedure Return;

procedure Genre(vType: String);
procedure Name(vName: String);
procedure Surname(vSurname: String);
procedure Apply_Changes;

var
  vTemp_Personal: TPERSONAL;

procedure Avatar;
procedure Avatar_Page(vPage: Byte);
procedure Avatar_Select(vNum: Integer);
procedure Avatar_Change;

var
  vAvatar: TPROFILE_AVATAR_VARIABLES;

procedure Password;
function Password_Check: Boolean;
procedure Password_Change;

implementation

uses
  uLoad_Alltypes,
  uDatabase_ActiveUser,
  uMain_AllTypes,
  uDatabase_SqlCommands;

procedure Load;
begin
  extrafe.prog.State := 'main_config_profile_user';

  mainScene.Config.main.R.Profile.User.Panel := TPanel.Create(mainScene.Config.main.R.Profile.TabItem[0]);
  mainScene.Config.main.R.Profile.User.Panel.Name := 'Main_Config_Profile_User';
  mainScene.Config.main.R.Profile.User.Panel.Parent := mainScene.Config.main.R.Profile.TabItem[0];
  mainScene.Config.main.R.Profile.User.Panel.SetBounds(0, 0, mainScene.Config.main.R.Profile.TabControl.Width,
    mainScene.Config.main.R.Profile.TabControl.Height);
  mainScene.Config.main.R.Profile.User.Panel.Visible := True;

  mainScene.Config.main.R.Profile.User.Username := TLabel.Create(mainScene.Config.main.R.Profile.User.Panel);
  mainScene.Config.main.R.Profile.User.Username.Name := 'Main_Config_Profile_Main_Username_Label';
  mainScene.Config.main.R.Profile.User.Username.Parent := mainScene.Config.main.R.Profile.User.Panel;
  mainScene.Config.main.R.Profile.User.Username.SetBounds(10, 10, 300, 24);
  mainScene.Config.main.R.Profile.User.Username.Text := 'Username : ';
  mainScene.Config.main.R.Profile.User.Username.Visible := True;

  mainScene.Config.main.R.Profile.User.Username_V := TEdit.Create(mainScene.Config.main.R.Profile.User.Panel);
  mainScene.Config.main.R.Profile.User.Username_V.Name := 'Main_Config_Profile_Main_Username_Edit';
  mainScene.Config.main.R.Profile.User.Username_V.Parent := mainScene.Config.main.R.Profile.User.Panel;
  mainScene.Config.main.R.Profile.User.Username_V.SetBounds(10, 30, 370, 24);
  mainScene.Config.main.R.Profile.User.Username_V.Text := user_Active_Local.Username;
  mainScene.Config.main.R.Profile.User.Username_V.ReadOnly := True;
  mainScene.Config.main.R.Profile.User.Username_V.TextSettings.HorzAlign := TTextAlign.Center;
  mainScene.Config.main.R.Profile.User.Username_V.Visible := True;

  mainScene.Config.main.R.Profile.User.Password := TLabel.Create(mainScene.Config.main.R.Profile.User.Panel);
  mainScene.Config.main.R.Profile.User.Password.Name := 'Main_Config_Profile_Main_Password_Label';
  mainScene.Config.main.R.Profile.User.Password.Parent := mainScene.Config.main.R.Profile.User.Panel;
  mainScene.Config.main.R.Profile.User.Password.SetBounds(10, 70, 300, 24);
  mainScene.Config.main.R.Profile.User.Password.Text := 'Password : ';
  mainScene.Config.main.R.Profile.User.Password.Visible := True;

  mainScene.Config.main.R.Profile.User.Password_V := TEdit.Create(mainScene.Config.main.R.Profile.User.Panel);
  mainScene.Config.main.R.Profile.User.Password_V.Name := 'Main_Config_Profile_Main_Password_Edit';
  mainScene.Config.main.R.Profile.User.Password_V.Parent := mainScene.Config.main.R.Profile.User.Panel;
  mainScene.Config.main.R.Profile.User.Password_V.SetBounds(10, 90, 370, 24);
  mainScene.Config.main.R.Profile.User.Password_V.Text := user_Active_Local.Password;
  mainScene.Config.main.R.Profile.User.Password_V.ReadOnly := True;
  mainScene.Config.main.R.Profile.User.Password_V.TextSettings.HorzAlign := TTextAlign.Center;
  mainScene.Config.main.R.Profile.User.Password_V.Password := True;
  mainScene.Config.main.R.Profile.User.Password_V.Visible := True;

  mainScene.Config.main.R.Profile.User.Password_Change := TText.Create(mainScene.Config.main.R.Profile.User.Panel);
  mainScene.Config.main.R.Profile.User.Password_Change.Name := 'Main_Config_Profile_Main_Password_Change';
  mainScene.Config.main.R.Profile.User.Password_Change.Parent := mainScene.Config.main.R.Profile.User.Panel;
  mainScene.Config.main.R.Profile.User.Password_Change.SetBounds(180, 120, 200, 24);
  mainScene.Config.main.R.Profile.User.Password_Change.Text := 'Change Password';
  mainScene.Config.main.R.Profile.User.Password_Change.HorzTextAlign := TTextAlign.Trailing;
  mainScene.Config.main.R.Profile.User.Password_Change.TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Profile.User.Password_Change.OnClick := ex_main.input.mouse_config.Text.OnMouseClick;
  mainScene.Config.main.R.Profile.User.Password_Change.OnMouseEnter := ex_main.input.mouse_config.Text.OnMouseEnter;
  mainScene.Config.main.R.Profile.User.Password_Change.OnMouseLeave := ex_main.input.mouse_config.Text.OnMouseLeave;
  mainScene.Config.main.R.Profile.User.Password_Change.Visible := True;

  mainScene.Config.main.R.Profile.User.Email := TText.Create(mainScene.Config.main.R.Profile.User.Panel);
  mainScene.Config.main.R.Profile.User.Email.Name := 'Main_Config_Profile_Main_EMail';
  mainScene.Config.main.R.Profile.User.Email.Parent := mainScene.Config.main.R.Profile.User.Panel;
  mainScene.Config.main.R.Profile.User.Email.SetBounds(10, 135, 32, 32);
  mainScene.Config.main.R.Profile.User.Email.Font.Family := 'IcoMoon-Free';
  mainScene.Config.main.R.Profile.User.Email.Font.Size := 24;
  mainScene.Config.main.R.Profile.User.Email.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  mainScene.Config.main.R.Profile.User.Email.Text := #$e945;
  mainScene.Config.main.R.Profile.User.Email.Visible := True;

  mainScene.Config.main.R.Profile.User.Email_Dir := TText.Create(mainScene.Config.main.R.Profile.User.Panel);
  mainScene.Config.main.R.Profile.User.Email_Dir.Name := 'Main_Config_Profile_Main_EMail_Dir';
  mainScene.Config.main.R.Profile.User.Email_Dir.Parent := mainScene.Config.main.R.Profile.User.Panel;
  mainScene.Config.main.R.Profile.User.Email_Dir.SetBounds(56, 141, 400, 24);
  mainScene.Config.main.R.Profile.User.Email_Dir.Text := user_Active_Local.Email;
  mainScene.Config.main.R.Profile.User.Email_Dir.HorzTextAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Profile.User.Email_Dir.TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Profile.User.Email_Dir.Visible := True;

  mainScene.Config.main.R.Profile.User.Avatar_Show := TImage.Create(mainScene.Config.main.R.Profile.User.Panel);
  mainScene.Config.main.R.Profile.User.Avatar_Show.Name := 'Main_Config_Profile_Main_Avatar';
  mainScene.Config.main.R.Profile.User.Avatar_Show.Parent := mainScene.Config.main.R.Profile.User.Panel;
  mainScene.Config.main.R.Profile.User.Avatar_Show.SetBounds(410, 10, 150, 150);
  mainScene.Config.main.R.Profile.User.Avatar_Show.Bitmap.LoadFromFile(ex_main.Paths.Avatar_Images + user_Active_Local.Avatar + '.png');
  mainScene.Config.main.R.Profile.User.Avatar_Show.WrapMode := TImageWrapMode.Fit;
  mainScene.Config.main.R.Profile.User.Avatar_Show.Visible := True;

  mainScene.Config.main.R.Profile.User.Avatar_Change := TText.Create(mainScene.Config.main.R.Profile.User.Panel);
  mainScene.Config.main.R.Profile.User.Avatar_Change.Name := 'Main_Config_Profile_Main_Avatar_Change';
  mainScene.Config.main.R.Profile.User.Avatar_Change.Parent := mainScene.Config.main.R.Profile.User.Panel;
  mainScene.Config.main.R.Profile.User.Avatar_Change.SetBounds(410, 160, 150, 24);
  mainScene.Config.main.R.Profile.User.Avatar_Change.Text := 'Change Avatar';
  mainScene.Config.main.R.Profile.User.Avatar_Change.HorzTextAlign := TTextAlign.Center;
  mainScene.Config.main.R.Profile.User.Avatar_Change.OnClick := ex_main.input.mouse_config.Text.OnMouseClick;
  mainScene.Config.main.R.Profile.User.Avatar_Change.OnMouseEnter := ex_main.input.mouse_config.Text.OnMouseEnter;
  mainScene.Config.main.R.Profile.User.Avatar_Change.OnMouseLeave := ex_main.input.mouse_config.Text.OnMouseLeave;
  mainScene.Config.main.R.Profile.User.Avatar_Change.TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Profile.User.Avatar_Change.Visible := True;

  mainScene.Config.main.R.Profile.User.Personal := TGroupBox.Create(mainScene.Config.main.R.Profile.User.Panel);
  mainScene.Config.main.R.Profile.User.Personal.Name := 'Main_Config_Profile_Main_Personal';
  mainScene.Config.main.R.Profile.User.Personal.Parent := mainScene.Config.main.R.Profile.User.Panel;
  mainScene.Config.main.R.Profile.User.Personal.SetBounds(10, 190, 370, 200);
  mainScene.Config.main.R.Profile.User.Personal.Text := 'Personal';
  mainScene.Config.main.R.Profile.User.Personal.Visible := True;

  mainScene.Config.main.R.Profile.User.Name := TLabel.Create(mainScene.Config.main.R.Profile.User.Personal);
  mainScene.Config.main.R.Profile.User.Name.Name := 'Main_Config_Profile_Main_Name_Label';
  mainScene.Config.main.R.Profile.User.Name.Parent := mainScene.Config.main.R.Profile.User.Personal;
  mainScene.Config.main.R.Profile.User.Name.SetBounds(10, 40, 300, 24);
  mainScene.Config.main.R.Profile.User.Name.Text := 'Name : ';
  mainScene.Config.main.R.Profile.User.Name.Visible := True;

  mainScene.Config.main.R.Profile.User.Name_V := TEdit.Create(mainScene.Config.main.R.Profile.User.Personal);
  mainScene.Config.main.R.Profile.User.Name_V.Name := 'Main_Config_Profile_Main_Name_Edit';
  mainScene.Config.main.R.Profile.User.Name_V.Parent := mainScene.Config.main.R.Profile.User.Personal;
  mainScene.Config.main.R.Profile.User.Name_V.SetBounds(10, 60, mainScene.Config.main.R.Profile.User.Personal.Width - 20, 24);
  mainScene.Config.main.R.Profile.User.Name_V.Text := user_Active_Local.Name;
  mainScene.Config.main.R.Profile.User.Name_V.TextSettings.HorzAlign := TTextAlign.Center;
  mainScene.Config.main.R.Profile.User.Name_V.OnTyping := ex_main.input.mouse_config.Edit.OnTyping;
  mainScene.Config.main.R.Profile.User.Name_V.Visible := True;

  mainScene.Config.main.R.Profile.User.Surname := TLabel.Create(mainScene.Config.main.R.Profile.User.Personal);
  mainScene.Config.main.R.Profile.User.Surname.Name := 'Main_Config_Profile_Main_Surname_Label';
  mainScene.Config.main.R.Profile.User.Surname.Parent := mainScene.Config.main.R.Profile.User.Personal;
  mainScene.Config.main.R.Profile.User.Surname.SetBounds(10, 90, 300, 24);
  mainScene.Config.main.R.Profile.User.Surname.Text := 'Surname : ';
  mainScene.Config.main.R.Profile.User.Surname.Visible := True;

  mainScene.Config.main.R.Profile.User.Surname_V := TEdit.Create(mainScene.Config.main.R.Profile.User.Personal);
  mainScene.Config.main.R.Profile.User.Surname_V.Name := 'Main_Config_Profile_Main_Surname_Edit';
  mainScene.Config.main.R.Profile.User.Surname_V.Parent := mainScene.Config.main.R.Profile.User.Personal;
  mainScene.Config.main.R.Profile.User.Surname_V.SetBounds(10, 110, mainScene.Config.main.R.Profile.User.Personal.Width - 20, 24);
  mainScene.Config.main.R.Profile.User.Surname_V.Text := user_Active_Local.Surname;
  mainScene.Config.main.R.Profile.User.Surname_V.TextSettings.HorzAlign := TTextAlign.Center;
  mainScene.Config.main.R.Profile.User.Surname_V.OnTyping := ex_main.input.mouse_config.Edit.OnTyping;
  mainScene.Config.main.R.Profile.User.Surname_V.Visible := True;

  mainScene.Config.main.R.Profile.User.Gender_Male := TText.Create(mainScene.Config.main.R.Profile.User.Personal);
  mainScene.Config.main.R.Profile.User.Gender_Male.Name := 'Main_Config_Profile_Main_Gender_Male';
  mainScene.Config.main.R.Profile.User.Gender_Male.Parent := mainScene.Config.main.R.Profile.User.Personal;
  mainScene.Config.main.R.Profile.User.Gender_Male.SetBounds(mainScene.Config.main.R.Profile.User.Personal.Width - 62, 20, 28, 28);
  mainScene.Config.main.R.Profile.User.Gender_Male.Font.Family := 'IcoMoon-Free';
  mainScene.Config.main.R.Profile.User.Gender_Male.Font.Size := 24;
  mainScene.Config.main.R.Profile.User.Gender_Male.Text := #$e9dc;
  mainScene.Config.main.R.Profile.User.Gender_Male.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  mainScene.Config.main.R.Profile.User.Gender_Male.OnClick := ex_main.input.mouse_config.Text.OnMouseClick;
  mainScene.Config.main.R.Profile.User.Gender_Male.OnMouseEnter := ex_main.input.mouse_config.Text.OnMouseEnter;
  mainScene.Config.main.R.Profile.User.Gender_Male.OnMouseLeave := ex_main.input.mouse_config.Text.OnMouseLeave;
  mainScene.Config.main.R.Profile.User.Gender_Male.Visible := True;

  mainScene.Config.main.R.Profile.User.Gender_Male_Glow := TGlowEffect.Create(mainScene.Config.main.R.Profile.User.Gender_Male);
  mainScene.Config.main.R.Profile.User.Gender_Male_Glow.Name := 'Main_Config_Profile_Main_Gender_Male_Glow';
  mainScene.Config.main.R.Profile.User.Gender_Male_Glow.Parent := mainScene.Config.main.R.Profile.User.Gender_Male;
  mainScene.Config.main.R.Profile.User.Gender_Male_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  mainScene.Config.main.R.Profile.User.Gender_Male_Glow.Opacity := 0.9;
  mainScene.Config.main.R.Profile.User.Gender_Male_Glow.Enabled := False;

  mainScene.Config.main.R.Profile.User.Gender_Female := TText.Create(mainScene.Config.main.R.Profile.User.Personal);
  mainScene.Config.main.R.Profile.User.Gender_Female.Name := 'Main_Config_Profile_Main_Gender_Female';
  mainScene.Config.main.R.Profile.User.Gender_Female.Parent := mainScene.Config.main.R.Profile.User.Personal;
  mainScene.Config.main.R.Profile.User.Gender_Female.SetBounds(mainScene.Config.main.R.Profile.User.Personal.Width - 30, 20, 28, 28);
  mainScene.Config.main.R.Profile.User.Gender_Female.Font.Family := 'IcoMoon-Free';
  mainScene.Config.main.R.Profile.User.Gender_Female.Font.Size := 24;
  mainScene.Config.main.R.Profile.User.Gender_Female.Text := #$e9dd;
  mainScene.Config.main.R.Profile.User.Gender_Female.TextSettings.FontColor := TAlphaColorRec.Pink;
  mainScene.Config.main.R.Profile.User.Gender_Female.OnClick := ex_main.input.mouse_config.Text.OnMouseClick;
  mainScene.Config.main.R.Profile.User.Gender_Female.OnMouseEnter := ex_main.input.mouse_config.Text.OnMouseEnter;
  mainScene.Config.main.R.Profile.User.Gender_Female.OnMouseLeave := ex_main.input.mouse_config.Text.OnMouseLeave;
  mainScene.Config.main.R.Profile.User.Gender_Female.Visible := True;

  mainScene.Config.main.R.Profile.User.Gender_Female_Glow := TGlowEffect.Create(mainScene.Config.main.R.Profile.User.Gender_Female);
  mainScene.Config.main.R.Profile.User.Gender_Female_Glow.Name := 'Main_Config_Profile_Main_Gender_Female_Glow';
  mainScene.Config.main.R.Profile.User.Gender_Female_Glow.Parent := mainScene.Config.main.R.Profile.User.Gender_Female;
  mainScene.Config.main.R.Profile.User.Gender_Female_Glow.GlowColor := TAlphaColorRec.Pink;
  mainScene.Config.main.R.Profile.User.Gender_Female_Glow.Opacity := 0.9;
  mainScene.Config.main.R.Profile.User.Gender_Female_Glow.Enabled := False;

  mainScene.Config.main.R.Profile.User.Apply_Changes := TButton.Create(mainScene.Config.main.R.Profile.User.Personal);
  mainScene.Config.main.R.Profile.User.Apply_Changes.Name := 'Main_Config_Profile_Main_Apply_Changes';
  mainScene.Config.main.R.Profile.User.Apply_Changes.Parent := mainScene.Config.main.R.Profile.User.Personal;
  mainScene.Config.main.R.Profile.User.Apply_Changes.SetBounds(10, 155, mainScene.Config.main.R.Profile.User.Personal.Width - 20, 30);
  mainScene.Config.main.R.Profile.User.Apply_Changes.Text := 'Apply changes';
  mainScene.Config.main.R.Profile.User.Apply_Changes.OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
  mainScene.Config.main.R.Profile.User.Apply_Changes.Visible := True;

  mainScene.Config.main.R.Profile.User.Country := TImage.Create(mainScene.Config.main.R.Profile.User.Panel);
  mainScene.Config.main.R.Profile.User.Country.Name := 'Main_Config_Profile_Main_Country';
  mainScene.Config.main.R.Profile.User.Country.Parent := mainScene.Config.main.R.Profile.User.Panel;
  mainScene.Config.main.R.Profile.User.Country.SetBounds(410, 232, 150, 120);
  mainScene.Config.main.R.Profile.User.Country.Bitmap.LoadFromFile(ex_main.Paths.Flags_Images + user_Active_Local.Country + '.png');
  mainScene.Config.main.R.Profile.User.Country.WrapMode := TImageWrapMode.Fit;
  mainScene.Config.main.R.Profile.User.Country.Visible := True;

  mainScene.Config.main.R.Profile.User.Status := TGroupBox.Create(mainScene.Config.main.R.Profile.User.Panel);
  mainScene.Config.main.R.Profile.User.Status.Name := 'Main_Config_Profile_Main_Status';
  mainScene.Config.main.R.Profile.User.Status.Parent := mainScene.Config.main.R.Profile.User.Panel;
  mainScene.Config.main.R.Profile.User.Status.SetBounds(10, 400, mainScene.Config.main.R.Profile.User.Panel.Width - 20,
    mainScene.Config.main.R.Profile.User.Panel.Height - 440);
  mainScene.Config.main.R.Profile.User.Status.Text := 'Status';
  mainScene.Config.main.R.Profile.User.Status.Visible := True;

  mainScene.Config.main.R.Profile.User.Active_Led := TILLed.Create(mainScene.Config.main.R.Profile.User.Status);
  mainScene.Config.main.R.Profile.User.Active_Led.Name := 'Main_Config_Profile_Main_Active_Led';
  mainScene.Config.main.R.Profile.User.Active_Led.Parent := mainScene.Config.main.R.Profile.User.Status;
  mainScene.Config.main.R.Profile.User.Active_Led.SetBounds(10, 30, 16, 16);
  mainScene.Config.main.R.Profile.User.Active_Led.Border.Color := $00484848;
  mainScene.Config.main.R.Profile.User.Active_Led.Border.BevelOuter.Style := TULBevelStyle.bvsNone;
  mainScene.Config.main.R.Profile.User.Active_Led.Border.BevelInner.Style := TULBevelStyle.bvsNone;
  mainScene.Config.main.R.Profile.User.Active_Led.Value := user_Active_Local.Active;
  mainScene.Config.main.R.Profile.User.Active_Led.Visible := True;

  mainScene.Config.main.R.Profile.User.Active_Text := TText.Create(mainScene.Config.main.R.Profile.User.Status);
  mainScene.Config.main.R.Profile.User.Active_Text.Name := 'Main_Config_Profile_Main_Active_Led_Text';
  mainScene.Config.main.R.Profile.User.Active_Text.Parent := mainScene.Config.main.R.Profile.User.Status;
  mainScene.Config.main.R.Profile.User.Active_Text.SetBounds(40, 30, 200, 20);
  mainScene.Config.main.R.Profile.User.Active_Text.HorzTextAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Profile.User.Active_Text.TextSettings.FontColor := TAlphaColorRec.White;
  if user_Active_Local.Active then
    mainScene.Config.main.R.Profile.User.Active_Text.Text := 'User Is Active Online'
  else
    mainScene.Config.main.R.Profile.User.Active_Text.Text := 'User Is InActive Online';
  mainScene.Config.main.R.Profile.User.Active_Text.Visible := True;

  mainScene.Config.main.R.Profile.User.Created := TText.Create(mainScene.Config.main.R.Profile.User.Status);
  mainScene.Config.main.R.Profile.User.Created.Name := 'Main_Config_Profile_Main_Created';
  mainScene.Config.main.R.Profile.User.Created.Parent := mainScene.Config.main.R.Profile.User.Status;
  mainScene.Config.main.R.Profile.User.Created.SetBounds(10, 55, 500, 20);
  mainScene.Config.main.R.Profile.User.Created.TextSettings.FontColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Profile.User.Created.TextSettings.Font.Size := 12;
  mainScene.Config.main.R.Profile.User.Created.Text := 'User : was created on : ' + DateToStr(UnixToDateTime(user_Active_Local.Registered.ToInt64));
  mainScene.Config.main.R.Profile.User.Created.TextSettings.HorzAlign := TTextAlign.Leading;
  mainScene.Config.main.R.Profile.User.Created.Visible := True;

  vTemp_Personal.Name := user_Active_Local.Name;
  vTemp_Personal.Surname := user_Active_Local.Surname;
  vTemp_Personal.Genre := user_Active_Local.Genre;

  Genre(vTemp_Personal.Genre.ToString);
end;

procedure Free;
begin
  FreeAndNil(mainScene.Config.main.R.Profile.User.Panel);
  extrafe.prog.State := 'main_config';
end;

procedure Return;
begin
  extrafe.prog.State := 'main_config_profile_user';
  mainScene.Config.main.R.Profile.Blur.Enabled := False;
  mainScene.Config.main.Left_Blur.Enabled := False;
  FreeAndNil(mainScene.Config.main.R.Profile.User.Avatar.Panel);
  FreeAndNil(mainScene.Config.main.R.Profile.User.Pass.Panel);
end;

///

procedure Genre(vType: String);
begin
  if vType = '1' then
  begin
    mainScene.Config.main.R.Profile.User.Gender_Male_Glow.Enabled := True;
    mainScene.Config.main.R.Profile.User.Gender_Male.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
    mainScene.Config.main.R.Profile.User.Gender_Female_Glow.Enabled := False;
    mainScene.Config.main.R.Profile.User.Gender_Female.TextSettings.FontColor := TAlphaColorRec.Grey;
  end
  else
  begin
    mainScene.Config.main.R.Profile.User.Gender_Male_Glow.Enabled := False;
    mainScene.Config.main.R.Profile.User.Gender_Male.TextSettings.FontColor := TAlphaColorRec.Grey;
    mainScene.Config.main.R.Profile.User.Gender_Female_Glow.Enabled := True;
    mainScene.Config.main.R.Profile.User.Gender_Female.TextSettings.FontColor := TAlphaColorRec.Pink;
  end;
  vTemp_Personal.Genre := vType.ToBoolean;
end;

procedure Name(vName: String);
begin
  vTemp_Personal.Name := vName;
end;

procedure Surname(vSurname: String);
begin
  vTemp_Personal.Surname := vSurname;
end;

procedure Apply_Changes;
begin
  if vTemp_Personal.Name <> user_Active_Online.Name then
    user_Active_Online.Name := uDatabase_SqlCommands.Update_Query('name', vTemp_Personal.Name);
  if vTemp_Personal.Surname <> user_Active_Online.Surname then
    user_Active_Online.Surname := uDatabase_SqlCommands.Update_Query('surname', vTemp_Personal.Surname);
  if vTemp_Personal.Genre <> user_Active_Online.Genre.ToBoolean then
    user_Active_Online.Genre := uDatabase_SqlCommands.Update_Query('gender', vTemp_Personal.Genre.ToString);
end;
///

procedure Avatar;
var
  vi, li, ki: Integer;
begin

  extrafe.prog.State := 'main_config_profile_avatar';
  mainScene.Config.main.Left_Blur.Enabled := True;
  mainScene.Config.main.R.Profile.Blur.Enabled := True;

  // Avatar panel
  mainScene.Config.main.R.Profile.User.Avatar.Panel := TPanel.Create(mainScene.Config.main.R.Panel[0]);
  mainScene.Config.main.R.Profile.User.Avatar.Panel.Name := 'Main_Config_Profile_Avatar_Panel';
  mainScene.Config.main.R.Profile.User.Avatar.Panel.Parent := mainScene.Config.main.R.Panel[0];
  mainScene.Config.main.R.Profile.User.Avatar.Panel.Width := 560;
  mainScene.Config.main.R.Profile.User.Avatar.Panel.Height := 560;
  mainScene.Config.main.R.Profile.User.Avatar.Panel.Position.X := (mainScene.Config.main.R.Panel[0].Width / 2) - 280;
  mainScene.Config.main.R.Profile.User.Avatar.Panel.Position.Y := (mainScene.Config.main.R.Panel[0].Height / 2) - 280;
  mainScene.Config.main.R.Profile.User.Avatar.Panel.Visible := False;

  CreateHeader(mainScene.Config.main.R.Profile.User.Avatar.Panel, 'IcoMoon-Free', #$e976, 'Change the avatar', False, nil);

  mainScene.Config.main.R.Profile.User.Avatar.main.Panel := TPanel.Create(mainScene.Config.main.R.Profile.User.Avatar.Panel);
  mainScene.Config.main.R.Profile.User.Avatar.main.Panel.Name := 'Main_Config_Profile_Avatar_Main_Panel';
  mainScene.Config.main.R.Profile.User.Avatar.main.Panel.Parent := mainScene.Config.main.R.Profile.User.Avatar.Panel;
  mainScene.Config.main.R.Profile.User.Avatar.main.Panel.Width := mainScene.Config.main.R.Profile.User.Avatar.Panel.Width;
  mainScene.Config.main.R.Profile.User.Avatar.main.Panel.Height := mainScene.Config.main.R.Profile.User.Avatar.Panel.Height - 30;
  mainScene.Config.main.R.Profile.User.Avatar.main.Panel.Position.X := 0;
  mainScene.Config.main.R.Profile.User.Avatar.main.Panel.Position.Y := 30;
  mainScene.Config.main.R.Profile.User.Avatar.main.Panel.Visible := True;

  li := 0;
  ki := 0;

  for vi := 0 to 19 do
  begin
    if (vi = 5) or (vi = 10) or (vi = 15) then
      Inc(ki, 1);
    if li > 4 then
      li := 0;

    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi] := TImage.Create(mainScene.Config.main.R.Profile.User.Avatar.main.Panel);
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi].Name := 'Main_Config_Profile_Avatar_Image_' + IntToStr(vi);
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi].Parent := mainScene.Config.main.R.Profile.User.Avatar.main.Panel;
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi].Width := 100;
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi].Height := 100;
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi].Position.X := 10 + (li * 110);
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi].Position.Y := 10 + (ki * 110);
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi].Bitmap.LoadFromFile(ex_main.Paths.Avatar_Images + '0.png');
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi].WrapMode := TImageWrapMode.Fit;
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi].Tag := vi;
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi].OnClick := ex_main.input.mouse_config.Image.OnMouseClick;
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi].OnMouseEnter := ex_main.input.mouse_config.Image.OnMouseEnter;
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi].OnMouseLeave := ex_main.input.mouse_config.Image.OnMouseLeave;
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi].Visible := True;

    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar_Check[vi] := TImage.Create(mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi]);
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar_Check[vi].Name := 'Main_Config_Profile_Avatar_Image_' + IntToStr(vi);
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar_Check[vi].Parent := mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi];
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar_Check[vi].Width := 24;
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar_Check[vi].Height := 24;
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar_Check[vi].Position.X := 0;
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar_Check[vi].Position.Y := 76;
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar_Check[vi].Bitmap.LoadFromFile(ex_main.Paths.Config_Images + 'config_check.png');
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar_Check[vi].WrapMode := TImageWrapMode.Fit;
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar_Check[vi].Visible := False;

    mainScene.Config.main.R.Profile.User.Avatar.main.AVatar_Glow[vi] := TGlowEffect.Create(mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi]);
    mainScene.Config.main.R.Profile.User.Avatar.main.AVatar_Glow[vi].Name := 'Main_Config_Profile_Avatar_Image_Glow_' + IntToStr(vi);
    mainScene.Config.main.R.Profile.User.Avatar.main.AVatar_Glow[vi].Parent := mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi];
    mainScene.Config.main.R.Profile.User.Avatar.main.AVatar_Glow[vi].GlowColor := TAlphaColorRec.Deepskyblue;
    mainScene.Config.main.R.Profile.User.Avatar.main.AVatar_Glow[vi].Softness := 0.5;
    mainScene.Config.main.R.Profile.User.Avatar.main.AVatar_Glow[vi].Opacity := 0.9;
    mainScene.Config.main.R.Profile.User.Avatar.main.AVatar_Glow[vi].Enabled := False;

    Inc(li, 1);
  end;

  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left := TImage.Create(mainScene.Config.main.R.Profile.User.Avatar.main.Panel);
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left.Name := 'Main_Config_Profile_Avatar_Left';
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left.Parent := mainScene.Config.main.R.Profile.User.Avatar.main.Panel;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left.Width := 24;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left.Height := 24;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left.Position.X := (mainScene.Config.main.R.Profile.User.Avatar.main.Panel.Width / 2) - 40;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left.Position.Y := 460;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left.Bitmap.LoadFromFile(ex_main.Paths.Config_Images + 'config_previous.png');
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left.WrapMode := TImageWrapMode.Fit;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left.OnClick := ex_main.input.mouse_config.Image.OnMouseClick;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left.OnMouseEnter := ex_main.input.mouse_config.Image.OnMouseEnter;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left.OnMouseLeave := ex_main.input.mouse_config.Image.OnMouseLeave;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left.Visible := True;

  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left_Glow := TGlowEffect.Create(mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left);
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left_Glow.Name := 'Main_Config_Profile_Avatar_Left_Glow';
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left_Glow.Parent := mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left_Glow.Softness := 0.5;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left_Glow.Opacity := 0.9;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Left_Glow.Enabled := False;

  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right := TImage.Create(mainScene.Config.main.R.Profile.User.Avatar.main.Panel);
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right.Name := 'Main_Config_Profile_Avatar_Right';
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right.Parent := mainScene.Config.main.R.Profile.User.Avatar.main.Panel;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right.Width := 24;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right.Height := 24;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right.Position.X := (mainScene.Config.main.R.Profile.User.Avatar.main.Panel.Width / 2) + 20;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right.Position.Y := 460;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right.Bitmap.LoadFromFile(ex_main.Paths.Config_Images + 'config_next.png');
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right.WrapMode := TImageWrapMode.Fit;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right.OnClick := ex_main.input.mouse_config.Image.OnMouseClick;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right.OnMouseEnter := ex_main.input.mouse_config.Image.OnMouseEnter;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right.OnMouseLeave := ex_main.input.mouse_config.Image.OnMouseLeave;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right.Visible := True;

  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right_Glow := TGlowEffect.Create(mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right);
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right_Glow.Name := 'Main_Config_Profile_Avatar_Right_Glow';
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right_Glow.Parent := mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right_Glow.Softness := 0.5;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right_Glow.Opacity := 0.9;
  mainScene.Config.main.R.Profile.User.Avatar.main.Arrow_Right_Glow.Enabled := False;

  mainScene.Config.main.R.Profile.User.Avatar.main.Page_Info := TLabel.Create(mainScene.Config.main.R.Profile.User.Avatar.main.Panel);
  mainScene.Config.main.R.Profile.User.Avatar.main.Page_Info.Name := 'Main_Config_Profile_Avatar_Page_Info';
  mainScene.Config.main.R.Profile.User.Avatar.main.Page_Info.Parent := mainScene.Config.main.R.Profile.User.Avatar.main.Panel;
  mainScene.Config.main.R.Profile.User.Avatar.main.Page_Info.Width := 300;
  mainScene.Config.main.R.Profile.User.Avatar.main.Page_Info.Height := 24;
  mainScene.Config.main.R.Profile.User.Avatar.main.Page_Info.Position.X := 10;
  mainScene.Config.main.R.Profile.User.Avatar.main.Page_Info.Position.Y := 460;
  mainScene.Config.main.R.Profile.User.Avatar.main.Page_Info.Text := 'Page 1 from 26 pages';
  mainScene.Config.main.R.Profile.User.Avatar.main.Page_Info.Visible := True;

  mainScene.Config.main.R.Profile.User.Avatar.main.Change := TButton.Create(mainScene.Config.main.R.Profile.User.Avatar.main.Panel);
  mainScene.Config.main.R.Profile.User.Avatar.main.Change.Name := 'Main_Config_Profile_Avatar_Main_Change';
  mainScene.Config.main.R.Profile.User.Avatar.main.Change.Parent := mainScene.Config.main.R.Profile.User.Avatar.main.Panel;
  mainScene.Config.main.R.Profile.User.Avatar.main.Change.Width := 100;
  mainScene.Config.main.R.Profile.User.Avatar.main.Change.Height := 30;
  mainScene.Config.main.R.Profile.User.Avatar.main.Change.Position.X := 50;
  mainScene.Config.main.R.Profile.User.Avatar.main.Change.Position.Y := mainScene.Config.main.R.Profile.User.Avatar.main.Panel.Height - 40;
  mainScene.Config.main.R.Profile.User.Avatar.main.Change.Text := 'Change';
  mainScene.Config.main.R.Profile.User.Avatar.main.Change.OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
  mainScene.Config.main.R.Profile.User.Avatar.main.Change.Visible := True;

  mainScene.Config.main.R.Profile.User.Avatar.main.Cancel := TButton.Create(mainScene.Config.main.R.Profile.User.Avatar.main.Panel);
  mainScene.Config.main.R.Profile.User.Avatar.main.Cancel.Name := 'Main_Config_Profile_Avatar_Main_Cancel';
  mainScene.Config.main.R.Profile.User.Avatar.main.Cancel.Parent := mainScene.Config.main.R.Profile.User.Avatar.main.Panel;
  mainScene.Config.main.R.Profile.User.Avatar.main.Cancel.Width := 100;
  mainScene.Config.main.R.Profile.User.Avatar.main.Cancel.Height := 30;
  mainScene.Config.main.R.Profile.User.Avatar.main.Cancel.Position.X := mainScene.Config.main.R.Profile.User.Avatar.main.Panel.Width - 150;
  mainScene.Config.main.R.Profile.User.Avatar.main.Cancel.Position.Y := mainScene.Config.main.R.Profile.User.Avatar.main.Panel.Height - 40;
  mainScene.Config.main.R.Profile.User.Avatar.main.Cancel.Text := 'Cancel';
  mainScene.Config.main.R.Profile.User.Avatar.main.Cancel.OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
  mainScene.Config.main.R.Profile.User.Avatar.main.Cancel.Visible := True;

  Avatar_Page(1);
  mainScene.Config.main.R.Profile.User.Avatar.Panel.Visible := True;
end;

procedure Avatar_Page(vPage: Byte);
var
  vi: Integer;
  vAvatarPage_Num: Integer;
begin
  if (vPage >= 1) and (vPage <= 26) then
  begin
    vAvatar.Page := vPage;
    vAvatar.Checked := StrToInt(user_Active_Online.Avatar);
    vAvatarPage_Num := (StrToInt(user_Active_Online.Avatar) div 20) + 1;
    for vi := 0 to 19 do
    begin
      mainScene.Config.main.R.Profile.User.Avatar.main.Avatar[vi].Bitmap.LoadFromFile(ex_main.Paths.Avatar_Images + IntToStr((20 * (vPage - 1)) + vi) + '.png');
      mainScene.Config.main.R.Profile.User.Avatar.main.AVatar_Glow[vi].Enabled := False;
      mainScene.Config.main.R.Profile.User.Avatar.main.Avatar_Check[vi].Visible := False;
      if (vAvatar.Page = vAvatarPage_Num) and ((vAvatar.Checked mod 20) = vi) then
      begin
        mainScene.Config.main.R.Profile.User.Avatar.main.AVatar_Glow[vi].GlowColor := TAlphaColorRec.White;
        mainScene.Config.main.R.Profile.User.Avatar.main.AVatar_Glow[vi].Enabled := True;
        mainScene.Config.main.R.Profile.User.Avatar.main.Avatar_Check[vi].Visible := True;
      end
    end;
    mainScene.Config.main.R.Profile.User.Avatar.main.Page_Info.Text := 'Page ' + IntToStr(vPage) + ' of 26 pages';
  end;
end;

procedure Avatar_Select(vNum: Integer);
var
  vi: Integer;
begin
  vAvatar.Checked := (20 * (vAvatar.Page - 1)) + vNum;
  for vi := 0 to 19 do
  begin
    mainScene.Config.main.R.Profile.User.Avatar.main.AVatar_Glow[vi].Enabled := False;
    mainScene.Config.main.R.Profile.User.Avatar.main.AVatar_Glow[vi].GlowColor := TAlphaColorRec.Deepskyblue;
    mainScene.Config.main.R.Profile.User.Avatar.main.Avatar_Check[vi].Visible := False;
  end;
  mainScene.Config.main.R.Profile.User.Avatar.main.AVatar_Glow[vNum].Enabled := True;
  mainScene.Config.main.R.Profile.User.Avatar.main.AVatar_Glow[vNum].GlowColor := TAlphaColorRec.White;
  mainScene.Config.main.R.Profile.User.Avatar.main.Avatar_Check[vNum].Visible := True;
end;

procedure Avatar_Change;
begin
  user_Active_Online.Avatar := uDatabase_SqlCommands.Update_Query('avatar', vAvatar.Checked.ToString);
  mainScene.Header.Avatar.Bitmap.LoadFromFile(ex_main.Paths.Avatar_Images + IntToStr(vAvatar.Checked) + '.png');
  mainScene.Config.main.R.Profile.User.Avatar_Show.Bitmap.LoadFromFile(ex_main.Paths.Avatar_Images + IntToStr(vAvatar.Checked) + '.png');
  Return;
end;

//
procedure Password;
begin

  extrafe.prog.State := 'main_config_profile_password';
  mainScene.Config.main.Left_Blur.Enabled := True;
  mainScene.Config.main.R.Profile.Blur.Enabled := True;

  // Change Password panel
  mainScene.Config.main.R.Profile.User.Pass.Panel := TPanel.Create(mainScene.Config.main.R.Panel[0]);
  mainScene.Config.main.R.Profile.User.Pass.Panel.Name := 'Main_Config_Profile_Password_Panel';
  mainScene.Config.main.R.Profile.User.Pass.Panel.Parent := mainScene.Config.main.R.Panel[0];
  mainScene.Config.main.R.Profile.User.Pass.Panel.Width := 430;
  mainScene.Config.main.R.Profile.User.Pass.Panel.Height := 260;
  mainScene.Config.main.R.Profile.User.Pass.Panel.Position.X := (mainScene.Config.main.R.Panel[0].Width / 2) - 215;
  mainScene.Config.main.R.Profile.User.Pass.Panel.Position.Y := (mainScene.Config.main.R.Panel[0].Height / 2) - 130;
  mainScene.Config.main.R.Profile.User.Pass.Panel.Visible := False;

  CreateHeader(mainScene.Config.main.R.Profile.User.Pass.Panel, 'IcoMoon-Free', #$e98d, 'Change the password', False, nil);

  mainScene.Config.main.R.Profile.User.Pass.main.Panel := TPanel.Create(mainScene.Config.main.R.Profile.User.Pass.Panel);
  mainScene.Config.main.R.Profile.User.Pass.main.Panel.Name := 'Main_Config_Profile_Password_Main_Panel';
  mainScene.Config.main.R.Profile.User.Pass.main.Panel.Parent := mainScene.Config.main.R.Profile.User.Pass.Panel;
  mainScene.Config.main.R.Profile.User.Pass.main.Panel.Width := mainScene.Config.main.R.Profile.User.Pass.Panel.Width;
  mainScene.Config.main.R.Profile.User.Pass.main.Panel.Height := mainScene.Config.main.R.Profile.User.Pass.Panel.Height - 30;
  mainScene.Config.main.R.Profile.User.Pass.main.Panel.Position.X := 0;
  mainScene.Config.main.R.Profile.User.Pass.main.Panel.Position.Y := 30;
  mainScene.Config.main.R.Profile.User.Pass.main.Panel.Visible := True;

  mainScene.Config.main.R.Profile.User.Pass.main.Current := TLabel.Create(mainScene.Config.main.R.Profile.User.Pass.main.Panel);
  mainScene.Config.main.R.Profile.User.Pass.main.Current.Name := 'Main_Config_Profile_Password_Main_Current_Label';
  mainScene.Config.main.R.Profile.User.Pass.main.Current.Parent := mainScene.Config.main.R.Profile.User.Pass.main.Panel;
  mainScene.Config.main.R.Profile.User.Pass.main.Current.Width := 430;
  mainScene.Config.main.R.Profile.User.Pass.main.Current.Height := 24;
  mainScene.Config.main.R.Profile.User.Pass.main.Current.Position.X := 10;
  mainScene.Config.main.R.Profile.User.Pass.main.Current.Position.Y := 10;
  mainScene.Config.main.R.Profile.User.Pass.main.Current.Text := 'Current password';
  mainScene.Config.main.R.Profile.User.Pass.main.Current.Visible := True;

  mainScene.Config.main.R.Profile.User.Pass.main.Current_V := TEdit.Create(mainScene.Config.main.R.Profile.User.Pass.main.Panel);
  mainScene.Config.main.R.Profile.User.Pass.main.Current_V.Name := 'Main_Config_Profile_Password_Main_Current_V_Label';
  mainScene.Config.main.R.Profile.User.Pass.main.Current_V.Parent := mainScene.Config.main.R.Profile.User.Pass.main.Panel;
  mainScene.Config.main.R.Profile.User.Pass.main.Current_V.Width := 410;
  mainScene.Config.main.R.Profile.User.Pass.main.Current_V.Height := 24;
  mainScene.Config.main.R.Profile.User.Pass.main.Current_V.Position.X := 10;
  mainScene.Config.main.R.Profile.User.Pass.main.Current_V.Position.Y := 34;
  mainScene.Config.main.R.Profile.User.Pass.main.Current_V.Text := '';
  mainScene.Config.main.R.Profile.User.Pass.main.Current_V.OnTyping := ex_main.input.mouse_config.Edit.OnTyping;
  mainScene.Config.main.R.Profile.User.Pass.main.Current_V.Visible := True;

  mainScene.Config.main.R.Profile.User.Pass.main.New := TLabel.Create(mainScene.Config.main.R.Profile.User.Pass.main.Panel);
  mainScene.Config.main.R.Profile.User.Pass.main.New.Name := 'Main_Config_Profile_Password_Main_New_Label';
  mainScene.Config.main.R.Profile.User.Pass.main.New.Parent := mainScene.Config.main.R.Profile.User.Pass.main.Panel;
  mainScene.Config.main.R.Profile.User.Pass.main.New.Width := 430;
  mainScene.Config.main.R.Profile.User.Pass.main.New.Height := 24;
  mainScene.Config.main.R.Profile.User.Pass.main.New.Position.X := 10;
  mainScene.Config.main.R.Profile.User.Pass.main.New.Position.Y := 64;
  mainScene.Config.main.R.Profile.User.Pass.main.New.Text := 'New password';
  mainScene.Config.main.R.Profile.User.Pass.main.New.Visible := True;

  mainScene.Config.main.R.Profile.User.Pass.main.New_V := TEdit.Create(mainScene.Config.main.R.Profile.User.Pass.main.Panel);
  mainScene.Config.main.R.Profile.User.Pass.main.New_V.Name := 'Main_Config_Profile_Password_Main_New_V_Label';
  mainScene.Config.main.R.Profile.User.Pass.main.New_V.Parent := mainScene.Config.main.R.Profile.User.Pass.main.Panel;
  mainScene.Config.main.R.Profile.User.Pass.main.New_V.Width := 410;
  mainScene.Config.main.R.Profile.User.Pass.main.New_V.Height := 24;
  mainScene.Config.main.R.Profile.User.Pass.main.New_V.Position.X := 10;
  mainScene.Config.main.R.Profile.User.Pass.main.New_V.Position.Y := 88;
  mainScene.Config.main.R.Profile.User.Pass.main.New_V.Text := '';
  mainScene.Config.main.R.Profile.User.Pass.main.New_V.OnTyping := ex_main.input.mouse_config.Edit.OnTyping;
  mainScene.Config.main.R.Profile.User.Pass.main.New_V.Visible := True;

  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite := TLabel.Create(mainScene.Config.main.R.Profile.User.Pass.main.Panel);
  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite.Name := 'Main_Config_Profile_Password_Main_NewRewrite_Label';
  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite.Parent := mainScene.Config.main.R.Profile.User.Pass.main.Panel;
  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite.Width := 430;
  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite.Height := 24;
  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite.Position.X := 10;
  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite.Position.Y := 118;
  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite.Text := 'Rewrite new password';
  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite.Visible := True;

  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite_V := TEdit.Create(mainScene.Config.main.R.Profile.User.Pass.main.Panel);
  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite_V.Name := 'Main_Config_Profile_Password_Main_NewRewrite_V_Label';
  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite_V.Parent := mainScene.Config.main.R.Profile.User.Pass.main.Panel;
  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite_V.Width := 410;
  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite_V.Height := 24;
  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite_V.Position.X := 10;
  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite_V.Position.Y := 142;
  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite_V.Text := '';
  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite_V.OnTyping := ex_main.input.mouse_config.Edit.OnTyping;
  mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite_V.Visible := True;

  mainScene.Config.main.R.Profile.User.Pass.main.Warning := TLabel.Create(mainScene.Config.main.R.Profile.User.Pass.main.Panel);
  mainScene.Config.main.R.Profile.User.Pass.main.Warning.Name := 'Main_Config_Profile_Password_Main_Current_Warning';
  mainScene.Config.main.R.Profile.User.Pass.main.Warning.Parent := mainScene.Config.main.R.Profile.User.Pass.main.Panel;
  mainScene.Config.main.R.Profile.User.Pass.main.Warning.Width := mainScene.Config.main.R.Profile.User.Pass.main.Panel.Width - 20;
  mainScene.Config.main.R.Profile.User.Pass.main.Warning.Height := 24;
  mainScene.Config.main.R.Profile.User.Pass.main.Warning.Position.X := 10;
  mainScene.Config.main.R.Profile.User.Pass.main.Warning.Position.Y := 164;
  mainScene.Config.main.R.Profile.User.Pass.main.Warning.Text := '';
  mainScene.Config.main.R.Profile.User.Pass.main.Warning.TextSettings.FontColor := TAlphaColorRec.Red;
  mainScene.Config.main.R.Profile.User.Pass.main.Warning.TextSettings.HorzAlign := TTextAlign.Center;
  mainScene.Config.main.R.Profile.User.Pass.main.Warning.Visible := False;

  mainScene.Config.main.R.Profile.User.Pass.main.Change := TButton.Create(mainScene.Config.main.R.Profile.User.Pass.main.Panel);
  mainScene.Config.main.R.Profile.User.Pass.main.Change.Name := 'Main_Config_Profile_Password_Main_Change';
  mainScene.Config.main.R.Profile.User.Pass.main.Change.Parent := mainScene.Config.main.R.Profile.User.Pass.main.Panel;
  mainScene.Config.main.R.Profile.User.Pass.main.Change.Width := 100;
  mainScene.Config.main.R.Profile.User.Pass.main.Change.Height := 30;
  mainScene.Config.main.R.Profile.User.Pass.main.Change.Position.X := 50;
  mainScene.Config.main.R.Profile.User.Pass.main.Change.Position.Y := mainScene.Config.main.R.Profile.User.Pass.main.Panel.Height - 40;
  mainScene.Config.main.R.Profile.User.Pass.main.Change.Text := 'Change';
  mainScene.Config.main.R.Profile.User.Pass.main.Change.OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
  mainScene.Config.main.R.Profile.User.Pass.main.Change.Visible := True;

  mainScene.Config.main.R.Profile.User.Pass.main.Cancel := TButton.Create(mainScene.Config.main.R.Profile.User.Pass.main.Panel);
  mainScene.Config.main.R.Profile.User.Pass.main.Cancel.Name := 'Main_Config_Profile_Password_Main_Cancel';
  mainScene.Config.main.R.Profile.User.Pass.main.Cancel.Parent := mainScene.Config.main.R.Profile.User.Pass.main.Panel;
  mainScene.Config.main.R.Profile.User.Pass.main.Cancel.Width := 100;
  mainScene.Config.main.R.Profile.User.Pass.main.Cancel.Height := 30;
  mainScene.Config.main.R.Profile.User.Pass.main.Cancel.Position.X := mainScene.Config.main.R.Profile.User.Pass.main.Panel.Width - 150;
  mainScene.Config.main.R.Profile.User.Pass.main.Cancel.Position.Y := mainScene.Config.main.R.Profile.User.Pass.main.Panel.Height - 40;
  mainScene.Config.main.R.Profile.User.Pass.main.Cancel.OnClick := ex_main.input.mouse_config.Button.OnMouseClick;
  mainScene.Config.main.R.Profile.User.Pass.main.Cancel.Text := 'Cancel';
  mainScene.Config.main.R.Profile.User.Pass.main.Cancel.Visible := True;

  mainScene.Config.main.R.Profile.User.Pass.Panel.Visible := True;
end;

function Password_Check: Boolean;
begin
  Result := False;
  if mainScene.Config.main.R.Profile.User.Pass.main.Current_V.Text = user_Active_Online.Password then
  begin
    if mainScene.Config.main.R.Profile.User.Pass.main.New_V.Text = mainScene.Config.main.R.Profile.User.Pass.main.New_Rewrite_V.Text then
    begin
      Result := True;
    end
    else
    begin
      mainScene.Config.main.R.Profile.User.Pass.main.Warning.Text := 'New passwords do not match please check them up.';
      mainScene.Config.main.R.Profile.User.Pass.main.Warning.Visible := True;
    end;
  end
  else
  begin
    mainScene.Config.main.R.Profile.User.Pass.main.Warning.Text := 'This is not your current password please type the right one.';
    mainScene.Config.main.R.Profile.User.Pass.main.Warning.Visible := True;
  end;
end;

procedure Password_Change;
begin
  if Password_Check then
  begin
    uDatabase_SqlCommands.Update_Query('password', mainScene.Config.main.R.Profile.User.Pass.main.New_V.Text);
    mainScene.Config.main.R.Profile.User.Password_V.Text := mainScene.Config.main.R.Profile.User.Pass.main.New_V.Text;
    Return;
  end;
end;

end.
