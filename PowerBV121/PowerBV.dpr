program PowerBV;

{%ToDo 'PowerBV.todo'}

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  PowerDKCUnit in 'PowerDKCUnit.pas',
  PowerJOHUnit in 'PowerJOHUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  AboutUnit in 'AboutUnit.pas' {AboutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
