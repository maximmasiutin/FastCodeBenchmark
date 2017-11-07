program StrLenBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  StrLenDKCUnit in 'StrLenDKCUnit.pas',
  StrLenJOHUnit in 'StrLenJOHUnit.pas',
  StrLenLBGUnit in 'StrLenLBGUnit.pas',
  AboutUnit in 'AboutUnit.pas' {AboutForm},
  StrLenPLRUnit in 'StrLenPLRUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
