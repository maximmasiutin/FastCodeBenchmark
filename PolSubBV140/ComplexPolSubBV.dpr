program ComplexPolSubBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  PolSubDKCUnit in 'PolSubDKCUnit.pas',
  ComplexDataTypesUnit in 'ComplexDataTypesUnit.pas',
  PolSubAZUnit in 'PolSubAZUnit.pas',
  PolSubPLRUnit in 'PolSubPLRUnit.pas',
  PolSubJOHUnit in 'PolSubJOHUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
