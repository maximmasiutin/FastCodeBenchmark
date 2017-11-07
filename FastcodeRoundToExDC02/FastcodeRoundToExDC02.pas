unit FastcodeRoundToExDC01;

(* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Fastcode
 *
 * The Initial Developer of the Original Code is Fastcode
 *
 * Portions created by the Initial Developer are Copyright (C) 2002-2004
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *
 * ***** END LICENSE BLOCK ***** *)

//Version : 0.2
//Only plain function calls supported
//Last update 16/9 2005

//Change log

//13/9 2005: Initial version 0.1 made by Dennis Christensen
//13/9 2005: 0.2 Dothan function added by Dennis Christensen

interface

type
 TRoundToEXRangeExtended = -20..20;

function RoundToExFastcodeP4P(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToExFastcodeP4N(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToExFastcodePMD(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToExFastcodePMB(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToExFastcodeAMD64(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToExFastcodeXP(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToExFastcodeBlended(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToExFastcodeRTL(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToExFastcodePascal(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;

implementation

uses
 SysUtils;

//Author:            John O'Harrow
//Date:
//Optimized for:     Intel P4 Prescott
//Instructionset(s): IA32
//Original name:     RoundToEX_JOH_IA32_3

procedure RoundExError;
begin
  raise Exception.Create('ADigit out of range');
end;

function RoundToExFastcodeP4P(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
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

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2004
//Optimized for:     Intel P4 Northwood
//Instructionset(s): IA32
//Original name:     RoundToEX_DKC_IA32_3

procedure RaiseException;
begin
 raise Exception.Create('ADigit out of range');
end;

function RoundToExFastcodeP4N(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
var
 LFactor, LFactorReciprocal : Extended;
 CW8087 : Word;
const
 CW8087X : Word = 4978;
 LFactorArray : array[-20..20] of Extended =
  (1E-20, 1E-19, 1E-18, 1E-17, 1E-16, 1E-15, 1E-14, 1E-13, 1E-12, 1E-11, 1E-10,
   1E-9, 1E-8, 1E-7, 1E-6, 1E-5, 1E-4, 1E-3, 1E-2, 1E-1, 1, 1E1, 1E2, 1E3, 1E4,
   1E5, 1E6, 1E7, 1E8, 1E9, 1E10, 1E11, 1E12, 1E13, 1E14, 1E15, 1E16, 1E17, 1E18,
   1E19, 1E20);
 LFactorReciprocalArray : array[-20..20] of Extended =
  (1E20, 1E19, 1E18, 1E17, 1E16, 1E15, 1E14, 1E13, 1E12, 1E11, 1E10, 1E9, 1E8,
   1E7, 1E6, 1E5, 1E4, 1E3, 1E2, 1E1, 1, 1E-1, 1E-2, 1E-3, 1E-4, 1E-5, 1E-6,
   1E-7, 1E-8, 1E-9, 1E-10, 1E-11, 1E-12, 1E-13, 1E-14, 1E-15, 1E-16, 1E-17,
   1E-18, 1E-19, 1E-20);

asm
   sub     esp,$40
   cmp     al,-20
   jl      @Exception
   cmp     al,20
   jle     @Continue
 @Exception :
   call    RaiseException
 @Continue :
   //CW8087 := Get8087CW;
   fstcw   word ptr [esp+6]
   //Set8087CW(4978);//pmExtended, rmNearest etc.
   fldcw   word ptr [CW8087X]
   //if ADigit = 0 then
   test    al,al
   jz      @Else
   //LFactor := LFactorArray[ADigit];
   movsx   eax,al
   lea     eax,[eax+eax*4]
   add     eax,eax
   fld     tbyte ptr [eax+LFactorArray + $C8]
   //LFactorReciprocal := LFactorReciprocalArray[ADigit];
   fld     tbyte ptr [eax+LFactorReciprocalArray + $C8]
   //Result := Round(AValue * LFactorReciprocal) * LFactor;
   fld     tbyte ptr [ebp+$08]//AValue
   fmulp
   frndint
   fmulp
   jmp     @IfEnd
 @Else :
   //Result := Round(AValue)
   fld     tbyte ptr [ebp+$08]
   frndint
 @IfEnd :
   fldcw   word ptr [esp+6]
   wait
   mov     esp,ebp
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     Intel Pentium M Dothan
//Instructionset(s): IA32
//Original name:     RoundToEX_JOH_IA32_3

function RoundToExFastcodePMD(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
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

//Author:            Dennis Kjaer Christensen
//Date:              29/12 2004
//Optimized for:     Intel Pentium M Banias
//Instructionset(s): IA32
//Original name:     RoundToEX_DKC_IA32_1

function RoundToExFastcodePMB(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
var
 LFactor, LFactorReciprocal : Extended;
 CW8087 : Word;
const
 CW8087X : Word = 4978;
 LFactorArray : array[-20..20] of Extended =
  (1E-20, 1E-19, 1E-18, 1E-17, 1E-16, 1E-15, 1E-14, 1E-13, 1E-12, 1E-11, 1E-10,
   1E-9, 1E-8, 1E-7, 1E-6, 1E-5, 1E-4, 1E-3, 1E-2, 1E-1, 1, 1E1, 1E2, 1E3, 1E4,
   1E5, 1E6, 1E7, 1E8, 1E9, 1E10, 1E11, 1E12, 1E13, 1E14, 1E15, 1E16, 1E17, 1E18,
   1E19, 1E20);
 LFactorReciprocalArray : array[-20..20] of Extended =
  (1E20, 1E19, 1E18, 1E17, 1E16, 1E15, 1E14, 1E13, 1E12, 1E11, 1E10, 1E9, 1E8,
   1E7, 1E6, 1E5, 1E4, 1E3, 1E2, 1E1, 1, 1E-1, 1E-2, 1E-3, 1E-4, 1E-5, 1E-6,
   1E-7, 1E-8, 1E-9, 1E-10, 1E-11, 1E-12, 1E-13, 1E-14, 1E-15, 1E-16, 1E-17,
   1E-18, 1E-19, 1E-20);

asm
   sub   esp,$40
   cmp     al,-20
   jl      @Exception
   cmp     al,20
   jle     @Continue
 @Exception :
   call    RaiseException
 @Continue :
   //CW8087 := Get8087CW;
   fstcw   word ptr [esp+6]
   //Set8087CW(4978);//pmExtended, rmNearest etc.
   fldcw   word ptr [CW8087X]
   //if ADigit = 0 then
   test    al,al
   jnz     @Else
   //Result := Round(AValue)
   fld     tbyte ptr [ebp+$08]
   frndint
   jmp     @IfEnd
 @Else :
   //LFactor := LFactorArray[ADigit];
   movsx   eax,al
   lea     eax,[eax+eax*4]
   fld     tbyte ptr [eax*2+LFactorArray + $C8]
   //LFactorReciprocal := LFactorReciprocalArray[ADigit];
   fld     tbyte ptr [eax*2+LFactorReciprocalArray + $C8]
   //Result := Round(AValue * LFactorReciprocal) * LFactor;
   fld     tbyte ptr [ebp+$08]//AValue
   fmulp
   frndint
   fmulp
 @IfEnd :
   fldcw   word ptr [esp+6]
   wait
   mov     esp,ebp
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2004
//Optimized for:     AMD Athlon 64, Opteron, FX
//Instructionset(s): IA32
//Original name:     RoundToEX_DKC_IA32_3

function RoundToExFastcodeAMD64(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
var
 LFactor, LFactorReciprocal : Extended;
 CW8087 : Word;
const
 CW8087X : Word = 4978;
 LFactorArray : array[-20..20] of Extended =
  (1E-20, 1E-19, 1E-18, 1E-17, 1E-16, 1E-15, 1E-14, 1E-13, 1E-12, 1E-11, 1E-10,
   1E-9, 1E-8, 1E-7, 1E-6, 1E-5, 1E-4, 1E-3, 1E-2, 1E-1, 1, 1E1, 1E2, 1E3, 1E4,
   1E5, 1E6, 1E7, 1E8, 1E9, 1E10, 1E11, 1E12, 1E13, 1E14, 1E15, 1E16, 1E17, 1E18,
   1E19, 1E20);
 LFactorReciprocalArray : array[-20..20] of Extended =
  (1E20, 1E19, 1E18, 1E17, 1E16, 1E15, 1E14, 1E13, 1E12, 1E11, 1E10, 1E9, 1E8,
   1E7, 1E6, 1E5, 1E4, 1E3, 1E2, 1E1, 1, 1E-1, 1E-2, 1E-3, 1E-4, 1E-5, 1E-6,
   1E-7, 1E-8, 1E-9, 1E-10, 1E-11, 1E-12, 1E-13, 1E-14, 1E-15, 1E-16, 1E-17,
   1E-18, 1E-19, 1E-20);

asm
   sub     esp,$40
   cmp     al,-20
   jl      @Exception
   cmp     al,20
   jle     @Continue
 @Exception :
   call    RaiseException
 @Continue :
   //CW8087 := Get8087CW;
   fstcw   word ptr [esp+6]
   //Set8087CW(4978);//pmExtended, rmNearest etc.
   fldcw   word ptr [CW8087X]
   //if ADigit = 0 then
   test    al,al
   jz      @Else
   //LFactor := LFactorArray[ADigit];
   movsx   eax,al
   lea     eax,[eax+eax*4]
   add     eax,eax
   fld     tbyte ptr [eax+LFactorArray + $C8]
   //LFactorReciprocal := LFactorReciprocalArray[ADigit];
   fld     tbyte ptr [eax+LFactorReciprocalArray + $C8]
   //Result := Round(AValue * LFactorReciprocal) * LFactor;
   fld     tbyte ptr [ebp+$08]//AValue
   fmulp
   frndint
   fmulp
   jmp     @IfEnd
 @Else :
   //Result := Round(AValue)
   fld     tbyte ptr [ebp+$08]
   frndint
 @IfEnd :
   fldcw   word ptr [esp+6]
   wait
   mov     esp,ebp
end;

//Author:            John O'Harrow
//Date:
//Optimized for:     AMD Athlon XP
//Instructionset(s): IA32
//Original name:     RoundToEX_JOH_IA32_2

function RoundToExFastcodeXP(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
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

//Author:            John O'Harrow
//Date:
//Optimized for:     Blended
//Instructionset(s): IA32
//Original name:     RoundToEX_JOH_IA32_2

function RoundToExFastcodeBlended(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
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

//Author:            John O'Harrow
//Date:
//Optimized for:     RTL Replacement
//Instructionset(s): IA32
//Original name:     RoundToEX_JOH_IA32_2

function RoundToExFastcodeRTL(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
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

//Author:            Dennis Kjaer Christensen
//Date:              31/8 2004
//Optimized for:     Blended / Pascal
//Instructionset(s): IA32
//Original name:     RoundToEX_DKC_Pas_2

function RoundToExFastcodePascal(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
var
 LFactor, LFactorReciprocal : Extended;
 CW8087 : Word;
const
 LFactorArray : array[-20..20] of Extended =
  (1E-20, 1E-19, 1E-18, 1E-17, 1E-16, 1E-15, 1E-14, 1E-13, 1E-12, 1E-11, 1E-10,
   1E-9, 1E-8, 1E-7, 1E-6, 1E-5, 1E-4, 1E-3, 1E-2, 1E-1, 1, 1E1, 1E2, 1E3, 1E4,
   1E5, 1E6, 1E7, 1E8, 1E9, 1E10, 1E11, 1E12, 1E13, 1E14, 1E15, 1E16, 1E17, 1E18,
   1E19, 1E20);
 LFactorReciprocalArray : array[-20..20] of Extended =
  (1E20, 1E19, 1E18, 1E17, 1E16, 1E15, 1E14, 1E13, 1E12, 1E11, 1E10, 1E9, 1E8,
   1E7, 1E6, 1E5, 1E4, 1E3, 1E2, 1E1, 1, 1E-1, 1E-2, 1E-3, 1E-4, 1E-5, 1E-6,
   1E-7, 1E-8, 1E-9, 1E-10, 1E-11, 1E-12, 1E-13, 1E-14, 1E-15, 1E-16, 1E-17,
   1E-18, 1E-19, 1E-20);

begin
 if (ADigit < Low(TRoundToEXRangeExtended)) or (ADigit > High(TRoundToEXRangeExtended)) then
  raise Exception.Create('ADigit out of range');
 CW8087 := Get8087CW;
 try
  Set8087CW(4978);//pmExtended, rmNearest etc.
  LFactor := LFactorArray[ADigit];
  LFactorReciprocal := LFactorReciprocalArray[ADigit];
  if ADigit = 0 then
   Result := Round(AValue)
  else
   Result := Round(AValue * LFactorReciprocal) * LFactor;
 finally
  Set8087CW(CW8087);
 end;
end;

end.
