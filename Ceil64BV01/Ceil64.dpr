program Ceil64;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  CeilDKCUnit in 'CeilDKCUnit.pas',
  CeilJOHUnit in 'CeilJOHUnit.pas',
  Ceil_JOH in 'Ceil_JOH.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
