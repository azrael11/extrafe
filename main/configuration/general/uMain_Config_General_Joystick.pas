unit uMain_Config_General_Joystick;

interface

uses
  System.Classes,
  System.UITypes,
  FMX.StdCtrls,
  FMX.Listbox,
  FMX.Objects,
  FMX.Graphics;

procedure Load;

implementation

uses
  uMain_AllTypes;

procedure Load;
begin
  mainScene.Config.Main.R.General.Joystick.Select := TComboBox.Create(mainScene.Config.Main.R.General.Tab_Item[4]);
  mainScene.Config.Main.R.General.Joystick.Select.Name := 'Main_Config_General_Joystick_Select';
  mainScene.Config.Main.R.General.Joystick.Select.Parent:=  mainScene.Config.Main.R.General.Tab_Item[4];
  mainScene.Config.Main.R.General.Joystick.Select.SetBounds(10, 20, 200, 30);
  mainScene.Config.Main.R.General.Joystick.Select.Visible := True;

  mainScene.Config.Main.R.General.Joystick.Panel := TPanel.Create(mainScene.Config.Main.R.General.Tab_Item[4]);
  mainScene.Config.Main.R.General.Joystick.Panel.Name := 'Main_Config_General_Joystick_Panel';
  mainScene.Config.Main.R.General.Joystick.Panel.Parent:=  mainScene.Config.Main.R.General.Tab_Item[4];
  mainScene.Config.Main.R.General.Joystick.Panel.SetBounds(10, 58, mainScene.Config.Main.R.General.Contol.Width - 20, mainScene.Config.Main.R.General.Contol.Height - 88);
  mainScene.Config.Main.R.General.Joystick.Panel.Visible:= True;

  mainScene.Config.Main.R.General.Joystick.Place := TRectangle.Create(mainScene.Config.Main.R.General.Joystick.Panel);
  mainScene.Config.Main.R.General.Joystick.Place.Name := 'Main_Config_General_Joystick_Place';
  mainScene.Config.Main.R.General.Joystick.Place.Parent := mainScene.Config.Main.R.General.Joystick.Panel;
  mainScene.Config.Main.R.General.Joystick.Place.SetBounds(20, 20, 140, 140);
  mainScene.Config.Main.R.General.Joystick.Place.Fill.Kind := TBrushKind.Solid;
  mainScene.Config.Main.R.General.Joystick.Place.Fill.Color := TAlphaColorRec.Deepskyblue;
  mainScene.Config.Main.R.General.Joystick.Place.Stroke.Thickness := 1;
  mainScene.Config.Main.R.General.Joystick.Place.Visible := True;

end;

end.
