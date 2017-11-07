program ComplexRegtMulBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  RegtMulDKCUnit in 'RegtMulDKCUnit.pas',
  ComplexDataTypesUnit in 'ComplexDataTypesUnit.pas',
  RectMul_JOH in 'RectMul_JOH.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
