unit RoundToEXDKCUnit;

interface

uses
 RoundToEXRefUnit;

function RoundToEX_DKC_Pas_1(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToEX_DKC_Pas_2(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToEX_DKC_Pas_3(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToEX_DKC_Pas_4(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToEX_DKC_IA32_1(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToEX_DKC_IA32_2(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToEX_DKC_IA32_3(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
function RoundToEX_DKC_IA32_4(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;

implementation

uses
 SysUtils, Math;

//Author:            Dennis Kjaer Christensen
//Date:              31/8 2004
//Instructionset(s): IA32

function RoundToEX_DKC_Pas_1(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
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
  SetPrecisionMode(pmExtended);
  SetRoundMode(rmNearest);
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

//Author:            Dennis Kjaer Christensen
//Date:              31/8 2004
//Instructionset(s): IA32

function RoundToEX_DKC_Pas_2(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
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

//Author:            Dennis Kjaer Christensen
//Date:              2/9 2004
//Instructionset(s): IA32

function RoundToEX_DKC_Pas_3(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
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
  if ADigit = 0 then
   Result := Round(AValue)
  else
   begin
    LFactor := LFactorArray[ADigit];
    LFactorReciprocal := LFactorReciprocalArray[ADigit];
    Result := Round(AValue * LFactorReciprocal) * LFactor;
   end;
 finally
  Set8087CW(CW8087);
 end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              2/9 2004
//Instructionset(s): IA32

function RoundToEX_DKC_Pas_4(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
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
  if ADigit <> 0 then
   begin
    LFactor := LFactorArray[ADigit];
    LFactorReciprocal := LFactorReciprocalArray[ADigit];
    Result := Round(AValue * LFactorReciprocal) * LFactor;
   end
  else
   Result := Round(AValue)
 finally
  Set8087CW(CW8087);
 end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/12 2004
//Instructionset(s): IA32

procedure RaiseException;
begin
 raise Exception.Create('ADigit out of range');
end;

function RoundToEX_DKC_IA32_1(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
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
//Date:              29/12 2004
//Instructionset(s): IA32

function RoundToEX_DKC_IA32_2(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
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
   add     eax,eax
   fld     tbyte ptr [eax+LFactorArray + $C8]
   //LFactorReciprocal := LFactorReciprocalArray[ADigit];
   fld     tbyte ptr [eax+LFactorReciprocalArray + $C8]
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
//Instructionset(s): IA32

function RoundToEX_DKC_IA32_3(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
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

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2004
//Instructionset(s): IA32

function RoundToEX_DKC_IA32_4(const AValue: Extended; const ADigit: TRoundToEXRangeExtended): Extended;
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
   fldcw   word ptr [esp+6]
   wait
   mov     esp,ebp
   pop     ebp
   ret $000c
 @Else :
   //Result := Round(AValue)
   fld     tbyte ptr [ebp+$08]
   frndint
 @IfEnd :
   fldcw   word ptr [esp+6]
   wait
   mov     esp,ebp
end;

end.
