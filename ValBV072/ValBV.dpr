program ValBV;

{$INCLUDE Version.inc}

uses
  Forms,
  FastcodeChallengeUnit in 'FastcodeChallengeUnit.pas',
  FastcodeChallengeManagementUnit in 'FastcodeChallengeManagementUnit.pas',
  FastcodeConsoleUnit in 'FastcodeConsoleUnit.pas',
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  ReportFormUnit in 'ReportFormUnit.pas' {ReportForm},
  SystemInfoUnit in 'SystemInfoUnit.pas',
  ReportWriterUnit in 'ReportWriterUnit.pas',
  FastcodeChallengeValLongUnit in 'FastcodeChallengeValLongUnit.pas',
  FastcodeChallengeValInt64Unit in 'FastcodeChallengeValInt64Unit.pas',
  FastcodeChallengeValExtUnit in 'FastcodeChallengeValExtUnit.pas',
  UtilsUnit in 'UtilsUnit.pas',
  ValJOHUnit in 'ValJOHUnit.pas',
  ValRTLUnit in 'ValRTLUnit.pas',
  ValLBGUnit in 'ValLBGUnit.pas',
  ValDKCUnit in 'ValDKCUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  if DisplayGui then
    begin
      Application.Initialize;
      Application.Title := 'Fastcode B&V';
      Application.CreateForm(TMainForm, MainForm);
  Application.Run;
    end
  else
    RunConsole;
end.
