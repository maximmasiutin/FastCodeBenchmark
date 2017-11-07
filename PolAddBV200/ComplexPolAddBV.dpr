program ComplexPolAddBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  PolAddDKCUnit in 'PolAddDKCUnit.pas',
  ComplexDataTypesUnit in 'ComplexDataTypesUnit.pas',
  PolAddAZUnit in 'PolAddAZUnit.pas',
  PolAddPLRUnit in 'PolAddPLRUnit.pas',
  PolAddJOHUnit in 'PolAddJOHUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  AboutUnit in 'AboutUnit.pas' {AboutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
