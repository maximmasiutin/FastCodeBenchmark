program AnsiStringReplaceBV_FastMM4;

uses
  fastmm4 in 'fastmm4.pas',
  fastmm4messages in 'fastmm4messages.pas',
  Forms,
  MainUnit in 'MainUnit.pas',
  AnsiStringReplaceRefUnit in 'AnsiStringReplaceRefUnit.pas',
  StringReplaceDKCUnit in 'StringReplaceDKCUnit.pas',
  AnsiStringReplace_EWC in 'AnsiStringReplace_EWC.pas',
  HVStringReplace in 'HVStringReplace.pas',
  AnsiStringReplaceSHAUnit in 'AnsiStringReplaceSHAUnit.pas',
  StringReplaceEGPasUnit in 'StringReplaceEGPasUnit.pas',
  AnsiStringReplace_EWC2 in 'AnsiStringReplace_EWC2.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  AboutUnit in 'AboutUnit.pas' {AboutForm},
  AnsiStringReplaceJOHPASUnit12 in 'AnsiStringReplaceJOHPASUnit12.pas',
  AnsiStringReplaceJOHIA32Unit12 in 'AnsiStringReplaceJOHIA32Unit12.pas',
  AnsiStringReplaceJOHIA32Unit17 in 'AnsiStringReplaceJOHIA32Unit17.pas',
  AnsiStringReplaceJOHIA32Unit18 in 'AnsiStringReplaceJOHIA32Unit18.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
