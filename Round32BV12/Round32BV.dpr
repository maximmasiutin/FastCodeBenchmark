program Round32BV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  Round32Unit in 'Round32Unit.pas',
  Round32_JOH in 'Round32_JOH.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
