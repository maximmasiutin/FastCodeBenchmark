program UpperCaseBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  UpperCaseDKCUnit in 'UpperCaseDKCUnit.pas',
  UpperCaseRTLUnit in 'UpperCaseRTLUnit.pas',
  UpperCaseSHAUnit in 'UpperCaseSHAUnit.pas',
  UpperCaseJOHUnit in 'UpperCaseJOHUnit.pas',
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
