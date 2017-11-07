program RGBAToBGRABV;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  RGBToBGRDKCUnit in 'RGBToBGRDKCUnit.pas',
  RGBToBGRNHUnit in 'RGBToBGRNHUnit.pas',
  RGBToBGR_LBG_Unit in 'RGBToBGR_LBG_Unit.pas',
  RGBToBGR_JOH_Unit in 'RGBToBGR_JOH_Unit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
