program StrLCompBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas',
  StrLCompRTLUnit in 'StrLCompRTLUnit.pas',
  StrLCompJOHUnit in 'StrLCompJOHUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{MainForm}

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
