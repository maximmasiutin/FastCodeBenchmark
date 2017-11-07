program Floor;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  FloorUnit in 'FloorUnit.pas',
  FloorJOHUnit in 'FloorJOHUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
