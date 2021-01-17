program FillCharBV;

(*

Fastcode FillChar Benchmark and Validation Tool 
Support for the Win64 platform added by Maxim Masiutin <maxim@masiutin.com>

Version 2.0

Copyright (C) 2003-2013 Dennis Kjaer Christensen and contributors. All rights reserved
Copyright (C) 2017-2021 Maxim Masiutin. All rights reserved

See comments section in the MainUnit.pas file for more details. 

*)

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {MainForm},
  FillCharUnit in 'FillCharUnit.pas',
  FillCharJOHUnit in 'FillCharJOHUnit.pas',
  FillCharDKCUnit in 'FillCharDKCUnit.pas',
  FastcodeCPUID in 'FastcodeCPUID.pas',
  SystemInfoUnit in 'SystemInfoUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
