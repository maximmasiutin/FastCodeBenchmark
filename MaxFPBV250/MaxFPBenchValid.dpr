program MaxFPBenchValid;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  MaxFPUnit in 'MaxFPUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
