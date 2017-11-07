program CharPosIExBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  CharPosIExLBGUnit in 'CharPosIExLBGUnit.pas',
  AboutUnit in 'AboutUnit.pas' {AboutForm},
  CharPosIExRefUnit in 'CharPosIExRefUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  CharPosIExDKCUnit in 'CharPosIExDKCUnit.pas',
  CharPosIExJOHUnit in 'CharPosIExJOHUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
