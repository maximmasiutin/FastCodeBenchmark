program RoundToEXBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  RoundToEXDKCUnit in 'RoundToEXDKCUnit.pas',
  RoundToEXRefUnit in 'RoundToEXRefUnit.pas',
  RoundToEX_JOH in 'RoundToEX_JOH.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
