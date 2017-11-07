program CharPosRevBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  AboutUnit in 'AboutUnit.pas' {AboutForm},
  CharPosRevTestUnit in 'CharPosRevTestUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  CharPosRevDKCUnit in 'CharPosRevDKCUnit.pas',
  CharPosRevJOHUnit in 'CharPosRevJOHUnit.pas',
  CharPosRevDLAUnit in 'CharPosRevDLAUnit.pas',
  CharPosRevRefUnit in 'CharPosRevRefUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
