program Trunc32BV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  Trunc32DKCUnit in 'Trunc32DKCUnit.pas',
  Trunc32JOHUnit in 'Trunc32JOHUnit.pas',
  Trunc32DFLUnit in 'Trunc32DFLUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
