program Int64MulBV;

{
Original names:

Int64MulRTL
Int64MulRTLNoMagic
Int64MulDKCIA32_2
Int64MulJOH
Int64Mul_AMD_IA32
Int64MulJOH_2

New names:

Int64Mul_RTL_IA32_1
Int64Mul_RTL_IA32_2
Int64Mul_DKC_IA32_2
Int64Mul_JOH_IA32_1
Int64Mul_AMD_IA32_1
Int64Mul_JOH_IA32_2
}

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  Int64MulDKCUnit in 'Int64MulDKCUnit.pas',
  Int64MulRTLUnit in 'Int64MulRTLUnit.pas',
  Int64MulJOHUnit in 'Int64MulJOHUnit.pas',
  Int64MulAMDUnit in 'Int64MulAMDUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
