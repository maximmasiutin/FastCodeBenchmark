program MoveValidateBenchmark;

{%ToDo 'MoveValidateBenchmark.todo'}

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  MoveUnit in 'MoveUnit.pas',
  OptionsUnit in 'OptionsUnit.pas' {OptionsForm},
  MoveDKCUnit in 'MoveDKCUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  MoveJOHUnit10 in 'MoveJOHUnit10.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TOptionsForm, OptionsForm);
  Application.Run;
end.


