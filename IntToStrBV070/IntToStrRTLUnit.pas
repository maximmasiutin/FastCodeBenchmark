unit IntToStrRTLUnit;

interface

{$INCLUDE Defines.inc}
{$INCLUDE Version.inc}

uses
  FastcodeChallengeUnit,
  FastcodeChallengeIntToStr32Unit,
  FastcodeChallengeIntToStr64Unit,
  SysUtils;

implementation

{$IFNDEF Delphi6Plus}
  function FakeIntToStr(Value: Integer): string;
  begin
    FmtStr(Result, '%d', [Value]);
  end;

  function FakeIntToStr64(Value: Int64): string;
  begin
    FmtStr(Result, '%d', [Value]);
  end;
{$ENDIF}

function GetRTLIntToStr: Pointer;
var
  Temp: TIntToStr32Function;
begin
  {$IFDEF Delphi6Plus}
    Temp := IntToStr;
  {$ELSE}
    Temp := FakeIntToStr;
  {$ENDIF}
  Result := @Temp;
end;

function GetRTLIntToStr64: Pointer;
var
  Temp: TIntToStr64Function;
begin
  {$IFDEF Delphi6Plus}
    Temp := IntToStr;
  {$ELSE}
    Temp := FakeIntToStr64;
  {$ENDIF}
  Result := @Temp;
end;

initialization
begin
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_RTL_IA32_1', '', GetRTLIntToStr, fccIA32, fcaRTL));
  ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_RTL_IA32_1', '', GetRTLIntToStr64, fccIA32, fcaRTL));
end;

end.




