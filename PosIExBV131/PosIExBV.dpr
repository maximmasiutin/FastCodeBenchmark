program PosIExBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  PosIExRefUnit in 'PosIExRefUnit.pas',
  PosIExDKCUnit in 'PosIExDKCUnit.pas',
  PosIExJOHUnit in 'PosIExJOHUnit.pas',
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
