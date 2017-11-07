program ComplexRegtToPolBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  RegtToPolDKCUnit in 'RegtToPolDKCUnit.pas',
  ComplexDataTypesUnit in 'ComplexDataTypesUnit.pas',
  RectToPol_JOH in 'RectToPol_JOH.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
