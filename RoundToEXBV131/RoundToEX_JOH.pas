unit RoundToEX_JOH;

interface

uses
 RoundToEXRefUnit;

function RoundToEX_JOH_PAS_1 (const AValue: Extended;
                              const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToEX_JOH_PAS_2 (const AValue: Extended;
                              const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToEX_JOH_IA32_1(const AValue: Extended;
                              const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToEX_JOH_IA32_2(const AValue: Extended;
                              const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToEX_JOH_IA32_3(const AValue: Extended;
                              const ADigit: TRoundToEXRangeExtended): Extended;

implementation

uses
  SysUtils;

function RoundToEX_JOH_PAS_1(const AValue: Extended;
                             const ADigit: TRoundToEXRangeExtended): Extended;
type
  LFactors = array[1..2] of Extended;
var
 LFactor : LFactors;
 CW8087  : Word;
 Digits  : Integer;
const
 LFactorArray : array[-20..20] of LFactors = (
   (1E-20, 1E20), (1E-19, 1E19), (1E-18, 1E18), (1E-17, 1E17), (1E-16, 1E16),
   (1E-15, 1E15), (1E-14, 1E14), (1E-13, 1E13), (1E-12, 1E12), (1E-11, 1E11),
   (1E-10, 1E10), (1E-09, 1E09), (1E-08, 1E08), (1E-07, 1E07), (1E-06, 1E06),
   (1E-05, 1E05), (1E-04, 1E04), (1E-03, 1E03), (1E-02, 1E02), (1E-01, 1E01),
   (1, 1),
   (1E01, 1E-01), (1E02, 1E-02), (1E03, 1E-03), (1E04, 1E-04), (1E05, 1E-05),
   (1E06, 1E-06), (1E07, 1E-07), (1E08, 1E-08), (1E09, 1E-09), (1E10, 1E-10),
   (1E11, 1E-11), (1E12, 1E-12), (1E13, 1E-13), (1E14, 1E-14), (1E15, 1E-15),
   (1E16, 1E-16), (1E17, 1E-17), (1E18, 1E-18), (1E19, 1E-19), (1E20, 1E-20));
begin
  Digits := ADigit;
  if Abs(Digits) > 20 then
    raise Exception.Create('ADigit out of range');
  CW8087 := Get8087CW;
  try
    Set8087CW(4978);
    if Digits = 0 then
      Result := Round(AValue)
    else
      begin
        LFactor := LFactorArray[Digits];
        Result  := Round(AValue * LFactor[2]) * LFactor[1];
      end;
  finally
    Set8087CW(CW8087);
  end;
end;

function RoundToEX_JOH_PAS_2(const AValue: Extended;
                             const ADigit: TRoundToEXRangeExtended): Extended;
type
  TFactors = array[1..2] of Extended;
  PFactors = ^TFactors;
var
 LFactor : PFactors;
 CW8087  : Word;
 Digits  : Integer;
const
  LFactorArray : array[-20..20] of TFactors = (
    (1E-20, 1E20), (1E-19, 1E19), (1E-18, 1E18), (1E-17, 1E17), (1E-16, 1E16),
    (1E-15, 1E15), (1E-14, 1E14), (1E-13, 1E13), (1E-12, 1E12), (1E-11, 1E11),
    (1E-10, 1E10), (1E-09, 1E09), (1E-08, 1E08), (1E-07, 1E07), (1E-06, 1E06),
    (1E-05, 1E05), (1E-04, 1E04), (1E-03, 1E03), (1E-02, 1E02), (1E-01, 1E01),
    (1, 1),
    (1E01, 1E-01), (1E02, 1E-02), (1E03, 1E-03), (1E04, 1E-04), (1E05, 1E-05),
    (1E06, 1E-06), (1E07, 1E-07), (1E08, 1E-08), (1E09, 1E-09), (1E10, 1E-10),
    (1E11, 1E-11), (1E12, 1E-12), (1E13, 1E-13), (1E14, 1E-14), (1E15, 1E-15),
    (1E16, 1E-16), (1E17, 1E-17), (1E18, 1E-18), (1E19, 1E-19), (1E20, 1E-20));
begin
  Digits := ADigit;
  if Abs(Digits) > 20 then
    raise Exception.Create('ADigit out of range');
  CW8087 := Get8087CW;
  try
    Set8087CW(4978);
    if Digits = 0 then
      Result := Round(AValue)
    else
      begin
        LFactor := @LFactorArray[Digits];
        Result  := Round(AValue * LFactor[2]) * LFactor[1];
      end;
  finally
    Set8087CW(CW8087);
  end;
end;

procedure RoundExError;
begin
  raise Exception.Create('ADigit out of range');
end;

function RoundToEX_JOH_IA32_1(const AValue: Extended;
                              const ADigit: TRoundToEXRangeExtended): Extended;
const
  CW8087X : Word = 4978;
  LFactorArray : packed array[-20..20] of Extended = (
    1E-20, 1E-19, 1E-18, 1E-17, 1E-16, 1E-15, 1E-14, 1E-13, 1E-12, 1E-11,
    1E-10, 1E-09, 1E-08, 1E-07, 1E-06, 1E-05, 1E-04, 1E-03, 1E-02, 1E-01,
    1,
    1E+01, 1E+02, 1E+03, 1E+04, 1E+05, 1E+06, 1E+07, 1E+08, 1E+09, 1E+10,
    1E+11, 1E+12, 1E+13, 1E+14, 1E+15, 1E+16, 1E+17, 1E+18, 1E+19, 1E+20);
asm
  movsx   eax,al
  cmp     eax, 20
  jg      RoundExError
  cmp     eax, -20
  jl      RoundExError
  sub     esp, 4
  fstcw   word ptr [esp]
  fldcw   word ptr [CW8087X]
  lea     eax, [eax+eax*4]
  fld     tbyte ptr [eax*2 + LFactorArray + 20*10]
  fld     st(0)
  fld1
  fdivrp  st(1), st
  fld     AValue
  fmulp
  frndint
  fmulp
  fldcw   word ptr [esp]
  wait
  pop     eax {Restore Stack}
end;

function RoundToEX_JOH_IA32_2(const AValue: Extended;
                              const ADigit: TRoundToEXRangeExtended): Extended;
type
  TFactors = array[1..2] of Extended;
const
  CW8087X : Word = 4978;
  LFactorArray : array[-20..20] of TFactors = (
    (1E-20, 1E20), (1E-19, 1E19), (1E-18, 1E18), (1E-17, 1E17), (1E-16, 1E16),
    (1E-15, 1E15), (1E-14, 1E14), (1E-13, 1E13), (1E-12, 1E12), (1E-11, 1E11),
    (1E-10, 1E10), (1E-09, 1E09), (1E-08, 1E08), (1E-07, 1E07), (1E-06, 1E06),
    (1E-05, 1E05), (1E-04, 1E04), (1E-03, 1E03), (1E-02, 1E02), (1E-01, 1E01),
    (1, 1),
    (1E01, 1E-01), (1E02, 1E-02), (1E03, 1E-03), (1E04, 1E-04), (1E05, 1E-05),
    (1E06, 1E-06), (1E07, 1E-07), (1E08, 1E-08), (1E09, 1E-09), (1E10, 1E-10),
    (1E11, 1E-11), (1E12, 1E-12), (1E13, 1E-13), (1E14, 1E-14), (1E15, 1E-15),
    (1E16, 1E-16), (1E17, 1E-17), (1E18, 1E-18), (1E19, 1E-19), (1E20, 1E-20));
asm
  movsx   eax,al
  cmp     eax, 20
  jg      RoundExError
  cmp     eax, -20
  jl      RoundExError
  sub     esp, 4
  fstcw   word ptr [esp]
  fldcw   word ptr [CW8087X]
  lea     eax, [eax+eax*4]
  lea     eax, [eax*4 + LFactorArray + 20*20]
  fld     tbyte ptr [eax]
  fld     tbyte ptr [eax+10]
  fld     AValue
  fmulp
  frndint
  fmulp
  fldcw   word ptr [esp]
  wait
  pop     eax {Restore Stack}
end;

function RoundToEX_JOH_IA32_3(const AValue: Extended;
                              const ADigit: TRoundToEXRangeExtended): 
Extended;
const
  CW8087X : Word = 4978;
  Base    : Extended = 10;
asm {Small Version - Does not use Lookup Table}
  sub     esp, 4
  fstcw   word ptr [esp]
  fldcw   word ptr [CW8087X]
@@SetDigits:
  movsx   eax,al
  mov     ecx, eax           {Save Digits}
  cdq
  xor     eax, edx
  sub     eax, edx           {ABS(Digits)}
  jnz     @@Check
  fld     AValue             {Digits = 0}
  frndint
  jmp     @@Finished
@@Check:
  cmp     eax, 20
  jg      RoundExError
@@CalcFactors:               {Calc 1*10^ABS(Digits)}
  fld1
  fld     Base
  jmp     @@FactorEntry
@@FactorLoop:
  fmul    st, st
@@FactorEntry:
  shr     eax, 1
  jnc     @@FactorLoop
  fmul    st(1), st
  jnz     @@FactorLoop
  fxch
  fst     st(1)              {1*10^ABS(Digits)}
  fld1
  fdivrp  st(1), st          {1 / (1*10^ABS(Digits))}
  test    ecx, ecx           {Digits}
  jge     @@Calculate
  fxch                       {Swap if Digits < 0}
@@Calculate:
  fld     AValue             {Calc Result}
  fmulp
  frndint
  fmulp
@@Finished:
  fldcw   word ptr [esp]
  wait
  pop     eax                {Restore Stack}
end;

end.

