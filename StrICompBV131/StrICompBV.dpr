program StrICompBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  StrICompDKCUnit in 'StrICompDKCUnit.pas',
  StrICompJOHUnit in 'StrICompJOHUnit.pas',
  AboutUnit in 'AboutUnit.pas' {AboutForm},
  StrICompDFL in 'StrICompDFL.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
