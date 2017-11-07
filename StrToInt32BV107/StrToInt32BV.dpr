program StrToInt32BV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  SystemInfoUnit in 'SystemInfoUnit.pas',
  StrToInt32RTLUnit in 'StrToInt32RTLUnit.pas',
  AboutUnit in 'AboutUnit.pas' {AboutForm},
  StrToInt32DKCUnit in 'StrToInt32DKCUnit.pas',
  StrToInt32JOHUnit in 'StrToInt32JOHUnit.pas',
  StrToInt32JOHUnit2 in 'StrToInt32JOHUnit2.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
