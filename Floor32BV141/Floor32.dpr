program Floor32;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  Floor32RefUnit in 'Floor32RefUnit.pas',
  Floor32DKCUnit in 'Floor32DKCUnit.pas',
  AboutUnit in 'AboutUnit.pas' {AboutForm},
  Floor32PLRUnit in 'Floor32PLRUnit.pas',
  Floor32JOHUnit in 'Floor32JOHUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
