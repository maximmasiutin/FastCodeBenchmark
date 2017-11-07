program ComplexPolToRectBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  PolToRectPLRUnit in 'PolToRectPLRUnit.pas',
  ComplexDataTypesUnit in 'ComplexDataTypesUnit.pas',
  PolToRectFOUnit in 'PolToRectFOUnit.pas',
  PolToRectJOHUnit in 'PolToRectJOHUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
