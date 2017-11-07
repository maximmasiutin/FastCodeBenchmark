program SpreadsheetCreator;

{%ToDo 'SpreadsheetCreator.todo'}

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  AboutUnit in 'AboutUnit.pas' {AboutForm},
  Excel_TLB in 'Excel_TLB.pas',
  OptionsUnit in 'OptionsUnit.pas' {OptionsForm},
  HelperUnit in 'HelperUnit.pas' {HelperForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TOptionsForm, OptionsForm);
  Application.CreateForm(THelperForm, HelperForm);
  Application.Run;
end.
