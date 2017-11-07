program ComplexRegtDivBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  RegtDivDKCUnit in 'RegtDivDKCUnit.pas',
  ComplexDataTypesUnit in 'ComplexDataTypesUnit.pas',
  RectDiv_JOH in 'RectDiv_JOH.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
