program CharPosBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  CharPosDKCUnit in 'CharPosDKCUnit.pas',
  CharPosJOHUnit in 'CharPosJOHUnit.pas',
  CharPosCJGUnit in 'CharPosCJGUnit.pas',
  CharPosShaUnit in 'CharPosShaUnit.pas',
  CharPosUnit in 'CharPosUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
