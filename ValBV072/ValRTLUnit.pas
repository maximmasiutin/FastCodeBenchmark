unit ValRTLUnit;

interface

{$INCLUDE Version.inc}

{$IFDEF Delphi2005Plus}
  {$WARN UNSAFE_CODE OFF}
{$ENDIF}


uses
  FastcodeChallengeUnit,
  FastcodeChallengeValLongUnit,
  FastcodeChallengeValInt64Unit,
  FastcodeChallengeValExtUnit,
  SysUtils;

implementation

function GetRTLValLong: Pointer;
asm
  lea  eax, system.@ValLong
end;

function GetRTLValInt64: Pointer;
asm
  lea  eax, system.@ValInt64
end;

function GetRTLValExt: Pointer;
asm
  lea  eax, system.@ValExt
end;

initialization
  ChallengeValLong.RegisterFunction(FunctionData('ValLong (RTL)', '', GetRTLValLong, fccIA32, fcaRTL));
  ChallengeValInt64.RegisterFunction(FunctionData('ValInt64 (RTL)', '', GetRTLValInt64, fccIA32, fcaRTL));
  ChallengeValExt.RegisterFunction(FunctionData('ValExt (RTL)', '', GetRTLValExt, fccIA32, fcaRTL));
end.

