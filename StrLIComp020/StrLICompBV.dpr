program StrLICompBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  StrLICompRTLUnit in 'StrLICompRTLUnit.pas',
  StrLICompJOHUnit in 'StrLICompJOHUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
