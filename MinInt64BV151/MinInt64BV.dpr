program MinInt64BV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  MinInt64DKCUnit in 'MinInt64DKCUnit.pas',
  MinInt64ShaUnit in 'MinInt64ShaUnit.pas',
  MinInt64JOHUnit in 'MinInt64JOHUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
