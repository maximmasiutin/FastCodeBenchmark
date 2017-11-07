program CompareTextBV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  CompareTextShaUnit in 'CompareTextShaUnit.pas',
  CompareTextJOHUnit in 'CompareTextJOHUnit.pas',
  CompareTextDKCUnit in 'CompareTextDKCUnit.pas',
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
