program Int64DivBV;
{
Original names:

Int64DivRTL
Int64DivRTLNoMagic
Int64DivAMD
Int64Div_DKC_IA32_2
Int64Div_DKC_IA32ext_2
Int64Div_DKC_Pas_1
Int64Div_JOH_IA32_1
Int64Div_JOH_FPU
Int64Div_JOH_FPU_2
Int64Div_JOH_PAS

New names:

Int64Div_RTL_IA32_1
Int64Div_RTL_IA32_2
Int64Div_AMD_IA32_1
Int64Div_DKC_IA32_2
Int64Div_DKC_IA32ext_2
Int64Div_DKC_Pas_1
Int64Div_JOH_IA32_1
Int64Div_JOH_IA32_2
Int64Div_JOH_IA32_3
Int64Div_JOH_PAS_1
}

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  Int64DivAnalysisUnit in 'Int64DivAnalysisUnit.pas',
  Int64DivRTLUnit in 'Int64DivRTLUnit.pas',
  Int64DivAMDUnit in 'Int64DivAMDUnit.pas',
  Int64DivJOHUnit in 'Int64DivJOHUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  Int64DivDKCUnit in 'Int64DivDKCUnit.pas',
  AboutUnit in 'AboutUnit.pas' {AboutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
