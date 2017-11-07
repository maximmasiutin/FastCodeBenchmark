program Round;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  RoundUnit in 'RoundUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
