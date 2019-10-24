program ID3v2Tester;

uses
  Forms,
  TesterUnit1 in 'TesterUnit1.pas' {Form1},
  ID3v1Library in '..\ID3v1Library.pas',
  ID3v2Library in '..\ID3v2Library.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
