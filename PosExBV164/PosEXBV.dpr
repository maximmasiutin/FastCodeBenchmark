program PosEXBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  PosExDKCUnit in 'PosExDKCUnit.pas',
  PosExRTLUnit in 'PosExRTLUnit.pas',
  PosExAZUnit in 'PosExAZUnit.pas',
  PosExSHAUnit in 'PosExSHAUnit.pas',
  PosExEWCUnit in 'PosExEWCUnit.pas',
  PosExJOHUnit in 'PosExJOHUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
