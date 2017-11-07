program MaxInt64BV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  MaxInt64DKCUnit in 'MaxInt64DKCUnit.pas',
  MaxInt64RTLUnit in 'MaxInt64RTLUnit.pas',
  MaxInt64JOHUnit in 'MaxInt64JOHUnit.pas',
  MaxInt64SHAUnit in 'MaxInt64SHAUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
