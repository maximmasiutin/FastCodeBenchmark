program PosBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  PosUnit in 'PosUnit.pas',
  PosLPUnit in 'PosLPUnit.pas',
  PosJOHUnit in 'PosJOHUnit.pas',
  PosShaUnit in 'PosShaUnit.pas',
  PosShaUnit2 in 'PosShaUnit2.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
