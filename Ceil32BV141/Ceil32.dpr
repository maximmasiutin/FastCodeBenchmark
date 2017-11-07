program Ceil32;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  Ceil32RefUnit in 'Ceil32RefUnit.pas',
  Ceil32DKCUnit in 'Ceil32DKCUnit.pas',
  AboutUnit in 'AboutUnit.pas' {AboutForm},
  Ceil32PLRUnit in 'Ceil32PLRUnit.pas',
  Ceil32JOHUnit in 'Ceil32JOHUnit.pas',
  Ceil32LBGUnit in 'Ceil32LBGUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
