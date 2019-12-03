unit uEmu_Arcade_Mame_Lists;

interface

uses
  System.Classes,
  System.UiTypes,
  FMX.Layouts,
  FMX.Objects,
  FMX.Effects;

procedure Load;

implementation

uses
  uDB_AUser,
  uLoad_AllTypes,
  uEmu_Arcade_Mame_AllTypes;

procedure Load;
begin
  extrafe.prog.State := 'Mame_Lists';
  vMame.Scene.Left_Blur.Enabled := True;
  vMame.Scene.Right_Blur.Enabled := True;

  vMame.Scene.Settings.Visible := False;

  vMame.Scene.List.Panel := TLayout.Create(vMame.Scene.Main);
  vMame.Scene.List.Panel.Name := 'Mame_Lists';
  vMame.Scene.List.Panel.Parent := vMame.Scene.Main;
  vMame.Scene.List.Panel.SetBounds(150, 100, vMame.Scene.Main.Width - 300, vMame.Scene.Main.Height - 200);
  vMame.Scene.List.Panel.Visible := True;

  vMame.Scene.List.Add_Panel := TImage.Create(vMame.Scene.List.Panel);
  vMame.Scene.List.Add_Panel.Name := 'Mame_Lists_Add_Panel';
  vMame.Scene.List.Add_Panel.Parent := vMame.Scene.List.Panel;
  vMame.Scene.List.Add_Panel.SetBounds(0, 0, vMame.Scene.List.Panel.Width, 80);
  vMame.Scene.List.Add_Panel.Bitmap.LoadFromFile(uDB_AUser.Local.EMULATORS.Arcade_D.Mame_D.p_Images + 'vk_title.png');
  vMame.Scene.List.Add_Panel.WrapMode := TImageWrapMode.Stretch;
  vMame.Scene.List.Add_Panel.Visible := True;

  vMame.Scene.List.Add := TText.Create(vMame.Scene.List.Add_Panel);
  vMame.Scene.List.Add.Name := 'Mame_Lists_Add';
  vMame.Scene.List.Add.Parent := vMame.Scene.List.Add_Panel;
  vMame.Scene.List.Add.SetBounds(vMame.Scene.List.Add_Panel.Width - 70, 10, 50, 50);
  vMame.Scene.List.Add.Font.Family := 'IcoMoon-Free';
  vMame.Scene.List.Add.Font.Size := 34;
  vMame.Scene.List.Add.TextSettings.FontColor := TAlphaColorRec.Deepskyblue;
  vMame.Scene.List.Add.Text := #$ea0a;
  // vMame.Scene.List.Add.OnClick := '';
  // vMame.Scene.List.Add.OnMouseEnter := '';
  // vMame.Scene.List.Add.OnMouseLeave := '';
  vMame.Scene.List.Add.Visible := True;

  vMame.Scene.List.Add_Glow := TGlowEffect.Create(vMame.Scene.List.Add);
  vMame.Scene.List.Add_Glow.Name := 'Mame_Lists_Add_Glow';
  vMame.Scene.List.Add_Glow.Parent := vMame.Scene.List.Add;
  vMame.Scene.List.Add_Glow.GlowColor := TAlphaColorRec.Deepskyblue;
  vMame.Scene.List.Add_Glow.Softness := 0.9;
  vMame.Scene.List.Add_Glow.Enabled := False;



end;

end.