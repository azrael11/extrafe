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
  TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_LISTBOX = class(TObject)
    procedure OnMouseClick(Sender: TObject);
  end;

type
  TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_ACTIONS = record
    Button: TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_BUTTON;
    ListBox: TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_LISTBOX;
  end;

implementation
uses
  uLoad_AllTypes,
  uMain_AllTypes,
  uMain_Config_Emulation_Consoles_Scripts_Nes_Install;

{ TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_BUTTON }

procedure TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_BUTTON.OnMouseClick(Sender: TObject);
begin
  {Nes Emulator}
  if (TButton(Sender).Name = 'Script_Nes_Install_Main_Cancel') or (TButton(Sender).Name = 'Script_Nes_Install_Main_Tab5_Close') then
    uEmulation_Consoles_Nes_Install_Free
  else if TButton(Sender).Name = 'Script_Nes_Install_Main_Next' then
    uEmulation_Consoles_Nes_Slide_To_Next
  else if TButton(Sender).Name = 'Script_Nes_Install_Main_Back' then
    uEmulation_Consoles_Nes_Slide_To_Previous
  else if TButton(Sender).Name = 'Script_Nes_Install_Main_Tab4_Find' then
    uMain_Config_Emulation_Consoles_Scripts_Nes_Install.Script_Nes_Install.Main.Tab4_1.Open_Dialog.Execute
  else if TButton(Sender).Name = 'Script_Nes_Install_Main_Tab4_Start' then
    uEmulation_Consoles_Nes_Installation;


end;

procedure TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_BUTTON.OnMouseEnter(Sender: TObject);
begin

end;

procedure TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_BUTTON.OnMouseLeave(Sender: TObject);
begin

end;

{ TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_LISTBOX }

procedure TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_LISTBOX.OnMouseClick(Sender: TObject);
begin
  uEmulation_Consoles_Nes_ShowEmulatorInfo(TListBox(Sender).ItemIndex);
end;

initialization
ex_main.Input.mouse_script_consoles.Button := TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_BUTTON.Create;
ex_main.Input.mouse_script_consoles.ListBox:= TMAIN_MOUSE_CONFIG_EMULATION_CONSOLES_LISTBOX.Create;

finalization
ex_main.Input.mouse_script_consoles.Button.Free;
ex_main.Input.mouse_script_consoles.ListBox.Free;

end.
