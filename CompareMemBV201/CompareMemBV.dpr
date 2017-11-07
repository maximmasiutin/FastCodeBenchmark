program CompareMemBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  CompareMemDKCUnit in 'CompareMemDKCUnit.pas',
  CompareMemSHAUnit in 'CompareMemSHAUnit.pas',
  CompareMemJOHUnit in 'CompareMemJOHUnit.pas',
  CompareMemPLRUnit in 'CompareMemPLRUnit.pas',
  AboutUnit in 'AboutUnit.pas' {AboutForm},
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
