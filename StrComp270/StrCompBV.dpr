program StrCompBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  StrCompDKCUnit in 'StrCompDKCUnit.pas',
  StrCompRTLUnit in 'StrCompRTLUnit.pas',
  StrCompDFLUnit in 'StrCompDFLUnit.pas',
  StrCompRCUnit in 'StrCompRCUnit.pas',
  StrCompShaUnit in 'StrCompShaUnit.pas',
  StrCompJOHUnit in 'StrCompJOHUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
