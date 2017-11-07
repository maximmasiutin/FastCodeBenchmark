program ComplexRegtAddBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  RegtAddDKCUnit in 'RegtAddDKCUnit.pas',
  ComplexDataTypesUnit in 'ComplexDataTypesUnit.pas',
  RegtAddDFLUnit in 'RegtAddDFLUnit.pas',
  RectAdd_JOH in 'RectAdd_JOH.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
