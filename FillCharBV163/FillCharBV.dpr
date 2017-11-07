program FillCharBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  FillCharUnit in 'FillCharUnit.pas',
  FillCharJOHUnit in 'FillCharJOHUnit.pas',
  FillCharDKCUnit in 'FillCharDKCUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
