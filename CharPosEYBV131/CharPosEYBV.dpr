program CharPosEYBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  CharPosEYDKCUnit in 'CharPosEYDKCUnit.pas',
  CharPosEYSHAUnit in 'CharPosEYSHAUnit.pas',
  CharPosEY_JOH in 'CharPosEY_JOH.pas',
  CharPosEY_JOH2 in 'CharPosEY_JOH2.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
