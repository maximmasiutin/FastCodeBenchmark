program ArcCosBV;

{%ToDo 'ArcCosBV.todo'}

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  ArcCosUnit in 'ArcCosUnit.pas',
  ArcCosJOHUnit in 'ArcCosJOHUnit.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  AboutUnit in 'AboutUnit.pas' {AboutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
