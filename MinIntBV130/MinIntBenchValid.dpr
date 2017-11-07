program MinIntBenchValid;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  MinIntDKCUnit in 'MinIntDKCUnit.pas',
  MinIntShaUnit in 'MinIntShaUnit.pas',
  MinIntLBGUnit in 'MinIntLBGUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
