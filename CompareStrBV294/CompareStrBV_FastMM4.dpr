program CompareStrBV_FastMM4;

uses
  Fastmm4 in 'fastmm4/fastmm4.pas',
  Fastmm4messages in 'fastmm4/fastmm4messages.pas',
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  CompareStrPLRUnit in 'CompareStrPLRUnit.pas',
  CompareStr_EWC in 'CompareStr_EWC.pas',
  CompareStrDKCUnit in 'CompareStrDKCUnit.pas',
  CompareStrLBGUnit in 'CompareStrLBGUnit.pas',
  CompareStrRTLUnit in 'CompareStrRTLUnit.pas',
  CompareStrJOHUnit in 'CompareStrJOHUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
