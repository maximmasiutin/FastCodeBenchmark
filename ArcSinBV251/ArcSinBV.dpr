program ArcSinBV;

{%ToDo 'ArcSinBV.todo'}

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  ArcSinUnit in 'ArcSinUnit.pas',
  ArcSinJOHUnit in 'ArcSinJOHUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  AboutUnit in 'AboutUnit.pas' {AboutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
