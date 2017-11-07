program TrimBV;

uses
//  Fastmm4,
//  Fastmm4messages,
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  SystemInfoUnit in 'SystemInfoUnit.pas',
  AboutUnit in 'AboutUnit.pas' {AboutForm},
  TrimDKCUnit in 'TrimDKCUnit.pas',
  TrimJOHUnit in 'TrimJOHUnit.pas',
  TrimPLRUnit in 'TrimPLRUnit.pas',
  TrimDLAUnit in 'TrimDLAUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
