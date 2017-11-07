program ComplexRegtSubBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  RegtSubDKCUnit in 'RegtSubDKCUnit.pas',
  ComplexDataTypesUnit in 'ComplexDataTypesUnit.pas',
  RectSub_JOH in 'RectSub_JOH.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
