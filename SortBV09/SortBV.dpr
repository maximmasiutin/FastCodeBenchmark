program SortBV;

{$INCLUDE Defines.inc}

uses
  FastMM4,
  Forms,
  D5Support in 'D5Support.pas',
  FastcodeConsoleUnit in 'FastcodeConsoleUnit.pas',
  FastcodeChallengeManagementUnit in 'FastcodeChallengeManagementUnit.pas',
  FastCodeChallengeUnit in 'FastCodeChallengeUnit.pas',
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  ReportFormUnit in 'ReportFormUnit.pas' {ReportForm},
  ReportWriterUnit in 'ReportWriterUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  UtilsUnit in 'UtilsUnit.pas',
  FastcodeChallengeSortUnit in 'FastcodeChallengeSortUnit.pas',
  SortAZUnit in 'SortAZUnit.pas',
  SortRTLUnit in 'SortRTLUnit.pas',
  SortShaUnit in 'SortShaUnit.pas';

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
