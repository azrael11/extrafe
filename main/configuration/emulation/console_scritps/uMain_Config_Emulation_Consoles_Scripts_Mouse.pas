unit uMain_Config_Emulation_Consoles_Scripts_Mouse;

interface

uses
  System.Classes,
  FMX.StdCtrls,
  FMX.ListBox;

type
  TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_BUTTON = class(TObject)
    procedure OnMouseClick(Sender: TObject);
    procedure OnMouseEnter(Sender: TObject);
    procedure OnMouseLeave(Sender: TObject);
  end;

type
  TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_TLISTBOXITEM = class(TObject)
    procedure OnClick(Sender: TObject);
  end;

type
  TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_ACTIONS = record
    Button: TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_BUTTON;
    ListBoxItem: TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_TLISTBOXITEM;
  end;

implementation

uses
  uLoad_AllTypes,
  uMain_AllTypes,
  uMain_Config_Emulation_Consoles_Scripts_Nes_Install;

{ TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_BUTTON }

procedure TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_BUTTON.OnMouseClick(Sender: TObject);
begin
  { Nes Emulator }
  if (TButton(Sender).Name = 'Script_Nes_Install_Main_Cancel') or (TButton(Sender).Name = 'Script_Nes_Install_Main_Tab5_Close') then
    uEmulation_Consoles_Nes_Install_Free
  else if TButton(Sender).Name = 'Script_Nes_Install_Main_Next' then
    uMain_Config_Emulation_Consoles_Scripts_Nes_Install.Slide_To_Next
  else if TButton(Sender).Name = 'Script_Nes_Install_Main_Back' then
    uMain_Config_Emulation_Consoles_Scripts_Nes_Install.Slide_To_Previous
  else if TButton(Sender).Name = 'Script_Nes_Install_Main_Tab4_Find' then
    uMain_Config_Emulation_Consoles_Scripts_Nes_Install.Nes_I.Main.Tab4_1.Open_Dialog.Execute
  else if TButton(Sender).Name = 'Script_Nes_Install_Main_Tab4_Start' then
    uEmulation_Consoles_Nes_Installation;
end;

procedure TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_BUTTON.OnMouseEnter(Sender: TObject);
begin

end;

procedure TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_BUTTON.OnMouseLeave(Sender: TObject);
begin

end;


{ TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_TLISTBOXITEM }

procedure TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_TLISTBOXITEM.OnClick(Sender: TObject);
begin
  uMain_Config_Emulation_Consoles_Scripts_Nes_Install.ShowEmulatorInfo(TListBoxItem(Sender).Text);
end;

initialization

ex_main.Input.mouse_script_consoles.Button := TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_BUTTON.Create;
ex_main.Input.mouse_script_consoles.ListBoxItem := TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_TLISTBOXITEM.Create;

finalization

ex_main.Input.mouse_script_consoles.Button.Free;
ex_main.Input.mouse_script_consoles.ListBoxItem.Free;

end.
