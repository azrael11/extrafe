unit uKeyHook;

{
  By William Egge
  Sep 20, 2002
  egge@eggcentric.com
  http://www.eggcentric.com

  This code may be used/modified however you wish.
}

interface

uses
  Windows, Classes;

type
  TCallbackThunk = packed record
    POPEDX: Byte;
    MOVEAX: Byte;
    SelfPtr: Pointer;
    PUSHEAX: Byte;
    PUSHEDX: Byte;
    JMP: Byte;
    JmpOffset: Integer;
  end;

  // See windows help on KeyboardProc
  // Or press F1 while your cursor is on "KeyboardProc"
  TKeyboardCallback =
      procedure(code: Integer; wparam: WPARAM; lparam: LPARAM) of object;

  TKeyboardHook = class(TComponent)
  private
    { Private declarations }
    FHook: HHook;
    FThunk: TCallbackThunk;
    FOnCallback: TKeyboardCallBack;
    function CallBack(code: Integer; wparam: WPARAM; lparam: LPARAM): LRESULT
        stdcall;
    procedure SetOnCallback(const Value: TKeyboardCallBack);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property OnCallback: TKeyboardCallBack read FOnCallback write SetOnCallback;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('EggMisc', [TKeyboardHook]);
end;

{ TKeyboardHook }

function TKeyboardHook.CallBack(code: Integer; wparam: WPARAM;
  lparam: LPARAM): LRESULT;
begin
  if Code < 0 then
    Result:= CallNextHookEx(FHook, Code, wparam, lparam)
  else
  begin
    if Assigned(FOnCallback) then
      FOnCallback(Code, wParam, lParam);
    Result:= 0;
  end;
end;

constructor TKeyboardHook.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FThunk.POPEDX:= $5A;
  FThunk.MOVEAX:= $B8;
  FThunk.SelfPtr:= Self;
  FThunk.PUSHEAX:= $50;
  FThunk.PUSHEDX:= $52;
  FThunk.JMP:= $E9;
  FThunk.JmpOffset:= Integer(@TKeyboardHook.Callback)-Integer(@FThunk.JMP)-5;
  FHook:= SetWindowsHookEx(WH_KEYBOARD, TFNHookProc(@FThunk), 0, MainThreadID);
end;

destructor TKeyboardHook.Destroy;
begin
  UnhookWindowsHookEx(FHook);
  inherited;
end;

procedure TKeyboardHook.SetOnCallback(const Value: TKeyboardCallBack);
begin
  FOnCallback := Value;
end;

end.
