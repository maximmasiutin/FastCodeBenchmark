program IDCTBV;

uses
  //FastMM4,
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  SystemInfoUnit in 'SystemInfoUnit.pas',
  AboutUnit in 'AboutUnit.pas' {AboutForm},
  IDCT_DKC_Unit in 'IDCT_DKC_Unit.pas',
  IDCTREFUnit in 'IDCTREFUnit.pas',
  IDCT_NH_Unit in 'IDCT_NH_Unit.pas',
  IDCT_LC_Unit in 'IDCT_LC_Unit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
