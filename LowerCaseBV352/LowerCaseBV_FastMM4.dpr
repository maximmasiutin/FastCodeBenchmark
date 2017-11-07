program LowerCaseBV_FastMM4;

uses
  Fastmm4 in 'fastmm4/fastmm4.pas',
  Fastmm4messages in 'fastmm4/fastmm4messages.pas',
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  LowerCaseDKCUnit in 'LowerCaseDKCUnit.pas',
  LowerCaseRTLUnit in 'LowerCaseRTLUnit.pas',
  LowerCaseShaUnit in 'LowerCaseShaUnit.pas',
  LowerCase_JOH in 'LowerCase_JOH.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
