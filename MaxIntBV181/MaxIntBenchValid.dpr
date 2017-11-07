program MaxIntBenchValid;

{
New names:

Max_RTL_IA32_1_a
Max_RTL_IA32_1_b
Max_RTL_IA32_1_c
Max_RTL_IA32_1_d
Max_DKC_IA32_1_a
Max_DKC_IA32_1_b
Max_DKC_IA32_1_c
Max_DKC_IA32_1_d
Max_LBG_IA32_1_a
Max_LBG_IA32_1_b
Max_LBG_IA32_1_c
Max_LBG_IA32_1_d
Max_DKC_Pas_1_a
Max_DKC_Pas_1_b
Max_DKC_Pas_1_c
Max_DKC_Pas_1_d
Max_Sha_IA32_1_a
Max_Sha_IA32_1_b
Max_Sha_IA32_1_c
Max_Sha_IA32_1_d
Max_Sha_Pas_1_a
Max_Sha_Pas_1_b
Max_Sha_Pas_1_c
Max_Sha_Pas_1_d

Original names:

MaxRTL_a
MaxRTL_b
MaxRTL_c
MaxRTL_d
MaxDKCAsm_a
MaxDKCAsm_b
MaxDKCAsm_c
MaxDKCAsm_d
MaxLBGAsm_a
MaxLBGAsm_b
MaxLBGAsm_c
MaxLBGAsm_d
MaxDKCPas_a
MaxDKCPas_b
MaxDKCPas_c
MaxDKCPas_d
MaxShaInteger_a
MaxShaInteger_b
MaxShaInteger_c
MaxShaInteger_d
MaxShaIntegerPas_a
MaxShaIntegerPas_b
MaxShaIntegerPas_c
MaxShaIntegerPas_d
}

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  MaxIntUnit in 'MaxIntUnit.pas',
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
