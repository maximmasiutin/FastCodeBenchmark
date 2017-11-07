program TruncBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  TruncUnit in 'TruncUnit.pas',
  TruncJOHUnit in 'TruncJOHUnit.pas',
  TruncPLRUnit in 'TruncPLRUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
