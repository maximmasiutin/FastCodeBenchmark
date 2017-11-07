program MinFPBenchValid;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  MinFPDKCUnit in 'MinFPDKCUnit.pas',
  MinFPJOHUnit in 'MinFPJOHUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
