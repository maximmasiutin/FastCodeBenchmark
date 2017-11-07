program IsPrimeBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  IsPrimeDKCUnit in 'IsPrimeDKCUnit.pas',
  IsPrimeJOHUnit in 'IsPrimeJOHUnit.pas',
  IsPrimeHRUnit in 'IsPrimeHRUnit.pas',
  IsPrimeCJGUnit in 'IsPrimeCJGUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  AboutUnit in 'AboutUnit.pas' {AboutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
