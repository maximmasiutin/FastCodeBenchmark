program StrCopyBenchValid;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  StrCopyDKCUnit in 'StrCopyDKCUnit.pas',
  StrCopyJOHUnit in 'StrCopyJOHUnit.pas',
  StrCopySHAUnit in 'StrCopySHAUnit.pas',
  StrCopyLBGUnit in 'StrCopyLBGUnit.pas',
  StrCopyASUnit in 'StrCopyASUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
