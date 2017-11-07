program IntToStrBV;

{$INCLUDE Defines.inc}

uses
  Forms,
  FastcodeChallengeUnit in 'FastcodeChallengeUnit.pas',
  FastcodeChallengeManagementUnit in 'FastcodeChallengeManagementUnit.pas',
  FastcodeConsoleUnit in 'FastcodeConsoleUnit.pas',
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  ReportFormUnit in 'ReportFormUnit.pas' {ReportForm},
  SystemInfoUnit in 'SystemInfoUnit.pas',
  UtilsUnit in 'UtilsUnit.pas',
  ReportWriterUnit in 'ReportWriterUnit.pas',
  FastcodeChallengeIntToStr32Unit in 'FastcodeChallengeIntToStr32Unit.pas',
  FastcodeChallengeIntToStr64Unit in 'FastcodeChallengeIntToStr64Unit.pas',
  IntToStrAIUnit in 'IntToStrAIUnit.pas',
  IntToStrAZUnit in 'IntToStrAZUnit.pas',
  IntToStrDKCUnit in 'IntToStrDKCUnit.pas',
  IntToStrJOHUnit in 'IntToStrJOHUnit.pas',
  IntToStrLBGUnit in 'IntToStrLBGUnit.pas',
  IntToStrOucUnit in 'IntToStrOucUnit.pas',
  IntToStrRTLUnit in 'IntToStrRTLUnit.pas',
  IntToStrSZUnit in 'IntToStrSZUnit.pas',
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
