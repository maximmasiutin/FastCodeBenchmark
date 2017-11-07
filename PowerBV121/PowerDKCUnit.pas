unit PowerDKCUnit;

interface

function Power_DKC_Pas_1(const Base, Exponent: Extended): Extended; overload;
function Power_DKC_Pas_1(const Base, Exponent: Double): Double; overload;
function Power_DKC_Pas_1(const Base, Exponent: Single): Single; overload;

function IntPowerDKCPas4(const Base: Extended; const Exponent: Integer): Extended;
function Power_DKC_Pas_4(const Base, Exponent: Extended): Extended; overload;
function Power_DKC_Pas_4(const Base, Exponent: Double): Double; overload;
function Power_DKC_Pas_4(const Base, Exponent: Single): Single; overload;
function Power_DKC_IA32_1(const Base, Exponent: Extended): Extended; overload;
function Power_DKC_IA32_1(const Base, Exponent: Double): Double; overload;
function Power_DKC_IA32_1(const Base, Exponent: Single): Single; overload;
function Power_DKC_IA32_2(const Base, Exponent: Extended): Extended; overload;
function Power_DKC_IA32_2(const Base, Exponent: Double): Double; overload;
function Power_DKC_IA32_2(const Base, Exponent: Single): Single; overload;
function Power_DKC_IA32_3(const Base, Exponent: Extended): Extended; overload;
function Power_DKC_IA32_3(const Base, Exponent: Double): Double; overload;
function Power_DKC_IA32_3(const Base, Exponent: Single): Single; overload;
function Power_DKC_IA32Ext_2(const Base, Exponent: Extended): Extended; overload;
function Power_DKC_IA32Ext_2(const Base, Exponent: Double): Double; overload;
function Power_DKC_IA32Ext_2(const Base, Exponent: Single): Single; overload;
function Power_DKC_IA32Ext_3(const Base, Exponent: Extended): Extended; overload;
function Power_DKC_IA32Ext_3(const Base, Exponent: Double): Double; overload;
function Power_DKC_IA32Ext_3(const Base, Exponent: Single): Single; overload;
function Power_DKC_IA32Ext_4(const Base, Exponent: Extended): Extended; overload;
function Power_DKC_IA32Ext_4(const Base, Exponent: Double): Double; overload;
function Power_DKC_IA32Ext_4(const Base, Exponent: Single): Single; overload;
function Power_DKC_IA32Ext_5(const Base, Exponent: Extended): Extended; overload;
function Power_DKC_IA32Ext_5(const Base, Exponent: Double): Double; overload;
function Power_DKC_IA32Ext_5(const Base, Exponent: Single): Single; overload;
function Power_DKC_SSE2_1(const Base, Exponent: Double): Double; overload;
function Power_DKC_SSE2_2(const Base, Exponent: Double): Double; overload;
function Power_DKC_SSE_1(const Base, Exponent: Single): Single; overload;
function Power_DKC_SSE_2(const Base, Exponent: Single): Single; overload;

implementation

uses
 Math;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function Power_DKC_Pas_1(const Base, Exponent: Extended): Extended; overload;
begin
  if Exponent = 0.0 then
    Result := 1.0               { n**0 = 1 }
  else if (Base = 0.0) and (Exponent > 0.0) then
    Result := 0.0               { 0**n = 0, n > 0 }
  else if (Frac(Exponent) = 0.0) and (Abs(Exponent) <= MaxInt) then
    Result := IntPower(Base, Integer(Trunc(Exponent)))
  else
    Result := Exp(Exponent * Ln(Base))
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function Power_DKC_Pas_1(const Base, Exponent: Double): Double; overload;
begin
  if Exponent = 0.0 then
    Result := 1.0               { n**0 = 1 }
  else if (Base = 0.0) and (Exponent > 0.0) then
    Result := 0.0               { 0**n = 0, n > 0 }
  else if (Frac(Exponent) = 0.0) and (Abs(Exponent) <= MaxInt) then
    Result := IntPower(Base, Integer(Trunc(Exponent)))
  else
    Result := Exp(Exponent * Ln(Base))
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function Power_DKC_Pas_1(const Base, Exponent: Single): Single; overload;
begin
  if Exponent = 0.0 then
    Result := 1.0               { n**0 = 1 }
  else if (Base = 0.0) and (Exponent > 0.0) then
    Result := 0.0               { 0**n = 0, n > 0 }
  else if (Frac(Exponent) = 0.0) and (Abs(Exponent) <= MaxInt) then
    Result := IntPower(Base, Integer(Trunc(Exponent)))
  else
    Result := Exp(Exponent * Ln(Base))
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function Power_DKC_Pas_4(const Base, Exponent: Extended): Extended; overload;
var
 Y : Integer;

begin
 if (Abs(Exponent) <= MaxInt) then
  begin
   Y := Round(Exponent);
   if (Exponent = Y) then
    Result := IntPower(Base, Y)
   else
    Result := Exp(Exponent * Ln(Base))
  end
 else
  begin
   if (Base <> 0) and (Exponent > 0) then
    Result := Exp(Exponent * Ln(Base))
   else if Base = 0 then
    Result := 0
   else
    Result := Exp(Exponent * Ln(Base))
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function Power_DKC_Pas_4(const Base, Exponent: Double): Double; overload;
var
 Y : Integer;

begin
 if (Abs(Exponent) <= MaxInt) then
  begin
   Y := Round(Exponent);
   if (Exponent = Y) then
    Result := IntPower(Base, Y)
   else
    Result := Exp(Exponent * Ln(Base))
  end
 else
  begin
   if (Base <> 0) and (Exponent > 0) then
    Result := Exp(Exponent * Ln(Base))
   else if Base = 0 then
    Result := 0
   else
    Result := Exp(Exponent * Ln(Base))
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function Power_DKC_Pas_4(const Base, Exponent: Single): Single; overload;
var
 Y : Integer;

begin
 if (Abs(Exponent) <= MaxInt) then
  begin
   Y := Round(Exponent);
   if (Exponent = Y) then
    Result := IntPower(Base, Y)
   else
    Result := Exp(Exponent * Ln(Base))
  end
 else
  begin
   if (Base <> 0) and (Exponent > 0) then
    Result := Exp(Exponent * Ln(Base))
   else if Base = 0 then
    Result := 0
   else
    Result := Exp(Exponent * Ln(Base))
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function IntPowerDKCPas4(const Base: Extended; const Exponent: Integer): Extended; overload;
var
 I, I2, I3 : Integer;
 Result2 : Extended;

begin
 if Base = 0 then
  begin
   if Exponent = 0 then
    Result := 1
   else
    Result := 0;
  end
 else if Exponent = 0 then
  Result := 1
 else if Exponent = 1 then
  Result := Base
 else if Exponent = 2 then
  Result := Base * Base
 else if Exponent > 2 then
  begin
   Result := Base;
   Result2 := 1;
   I := 2;
   I2 := Exponent;
   repeat
    I3 := I2 and 1;
    if I3 = 1 then
     Result2 := Result2 * Result;
    I2 := I2 shr 1;
    Result := Result * Result;
    I := I * 2;
   until(I > Exponent);
   Result := Result * Result2;
  end
 else if Exponent = -1 then
  Result := 1/Base
 else if Exponent = -2 then
  Result := 1/(Base*Base)
 else //if Exponent < -2 then
  begin
   Result := Base;
   Result2 := 1;
   I := 2;
   I2 := -Exponent;
   repeat
    I3 := I2 and 1;
    if I3 = 1 then
     Result2 := Result2 * Result;
    I2 := I2 shr 1;
    Result := Result * Result;
    I := I * 2;
   until(I > -Exponent);
   Result := Result * Result2;
   Result := 1 / Result;
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function IntPowerDKCIA32_1(const Base: Single; const Exponent: Integer): Single; overload;
asm
   mov   edx,eax
   //if Base = 0 then
   fldz
   fld   Base
   fcomp
   ffree st(0)
   fstsw ax
   sahf
   jnz   @IfEnd2
   //if Exponent = 0 then
   test  edx,edx
   jnz   @Else2
   //ResultX := 1
   fld1
   jmp   @Exit
 @Else2 :
   //ResultX := 0;
   fldz
   jmp   @Exit
 @IfEnd2 :
   //else if Exponent = 0 then
   test  edx,edx
   jnz   @ElseIf2
   //ResultX := 1
   fld1
   jmp   @Exit
 @ElseIf2 :
   //else if Exponent = 1 then
   cmp   edx,1
   jnz   @ElseIf3
   //ResultX := Base
   fld   Base
   jmp   @Exit
 @ElseIf3 :
   //else if Exponent = 2 then
   cmp   edx,2
   jnz   @ElseIf4
   //ResultX := Base * Base
   fld   Base
   fmul  st(0),st(0)
   jmp   @Exit
 @ElseIf4 :
   //else if Exponent > 2 then
   cmp   edx,2
   jle   @ElseIf5
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fld   Base
   //I := 2;
   mov   eax,2
   //I2 := Exponent;
   mov   ecx,edx
   push  ebx
 @Repeat1Start :
   //I3 := I2 and 1;
   mov   ebx,ecx
   and   ebx,$01
   //if I3 = 1 then
   dec   ebx
   jnz   @IfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul  st(1),st(0)
 @IfEnd8 :
   //I2 := I2 shr 1;
   shr   ecx,1
   //ResultX := ResultX * ResultX;
   fmul  st(0),st(0)
   //I := I * 2;
   add   eax,eax
   //until(I > Exponent);
   cmp   edx,eax
   jnl   @Repeat1Start
   pop   ebx
   //ResultX := ResultX * ResultX2;
   fmulp st(1),st(0)
   jmp   @Exit
 @ElseIf5 :
   //else if Exponent = -1 then
   cmp   edx,-1
   jnz   @ElseIf6
   //ResultX := 1/Base
   fld1
   fdiv  Base
   jmp   @Exit
 @ElseIf6 :
   //else if Exponent = -2 then
   cmp   edx,-2
   jnz   @Else7
   //ResultX := 1/(Base*Base)
   fld1
   fld   Base
   fmul  st(0),st(0)
   fdiv
   jmp   @Exit
 @Else7 :
   push  ebx
   push  edi
   //else //if Exponent < -2 then
   //I := 2;
   mov   eax,2
   //I2 := -Exponent;
   mov   ecx,edx
   neg   ecx
   mov   edi,ecx
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fld   Base
 @Repeat2Start :
   //I3 := I2 and 1;
   mov   ebx,ecx
   and   ebx,1
   //if I3 = 1 then
   dec   ebx
   jnz   @IfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul  st(1),st(0)
 @IfEnd7 :
   //I2 := I2 shr 1;
   shr   ecx,1
   //ResultX := ResultX * ResultX;
   fmul  st(0),st(0)
   //I := I * 2;
   add   eax,eax
   //until(I > -Exponent);
   cmp   eax,edi
   jle   @Repeat2Start
   pop   edi
   pop   ebx
   //ResultX := ResultX * ResultX2;
   fmulp st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
 @Exit :
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function IntPowerDKCIA32_1(const Base: Double; const Exponent: Integer): Double; overload;
asm
   mov   edx,eax
   //if Base = 0 then
   fldz
   fld   Base
   fcomp
   ffree st(0)
   fstsw ax
   sahf
   jnz   @IfEnd2
   //if Exponent = 0 then
   test  edx,edx
   jnz   @Else2
   //ResultX := 1
   fld1
   jmp   @Exit
 @Else2 :
   //ResultX := 0;
   fldz
   jmp   @Exit
 @IfEnd2 :
   //else if Exponent = 0 then
   test  edx,edx
   jnz   @ElseIf2
   //ResultX := 1
   fld1
   jmp   @Exit
 @ElseIf2 :
   //else if Exponent = 1 then
   cmp   edx,1
   jnz   @ElseIf3
   //ResultX := Base
   fld   Base
   jmp   @Exit
 @ElseIf3 :
   //else if Exponent = 2 then
   cmp   edx,2
   jnz   @ElseIf4
   //ResultX := Base * Base
   fld   Base
   fmul  st(0),st(0)
   jmp   @Exit
 @ElseIf4 :
   //else if Exponent > 2 then
   cmp   edx,2
   jle   @ElseIf5
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fld   Base
   //I := 2;
   mov   eax,2
   //I2 := Exponent;
   mov   ecx,edx
   push  ebx
 @Repeat1Start :
   //I3 := I2 and 1;
   mov   ebx,ecx
   and   ebx,$01
   //if I3 = 1 then
   dec   ebx
   jnz   @IfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul  st(1),st(0)
 @IfEnd8 :
   //I2 := I2 shr 1;
   shr   ecx,1
   //ResultX := ResultX * ResultX;
   fmul  st(0),st(0)
   //I := I * 2;
   add   eax,eax
   //until(I > Exponent);
   cmp   edx,eax
   jnl   @Repeat1Start
   pop   ebx
   //ResultX := ResultX * ResultX2;
   fmulp st(1),st(0)
   jmp   @Exit
 @ElseIf5 :
   //else if Exponent = -1 then
   cmp   edx,-1
   jnz   @ElseIf6
   //ResultX := 1/Base
   fld1
   fdiv  Base
   jmp   @Exit
 @ElseIf6 :
   //else if Exponent = -2 then
   cmp   edx,-2
   jnz   @Else7
   //ResultX := 1/(Base*Base)
   fld1
   fld   Base
   fmul  st(0),st(0)
   fdiv
   jmp   @Exit
 @Else7 :
   push  ebx
   push  edi
   //else //if Exponent < -2 then
   //I := 2;
   mov   eax,2
   //I2 := -Exponent;
   mov   ecx,edx
   neg   ecx
   mov   edi,ecx
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fld   Base
 @Repeat2Start :
   //I3 := I2 and 1;
   mov   ebx,ecx
   and   ebx,1
   //if I3 = 1 then
   dec   ebx
   jnz   @IfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul  st(1),st(0)
 @IfEnd7 :
   //I2 := I2 shr 1;
   shr   ecx,1
   //ResultX := ResultX * ResultX;
   fmul  st(0),st(0)
   //I := I * 2;
   add   eax,eax
   //until(I > -Exponent);
   cmp   eax,edi
   jle   @Repeat2Start
   pop   edi
   pop   ebx
   //ResultX := ResultX * ResultX2;
   fmulp st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
 @Exit :
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function IntPowerDKCIA32_1(const Base: Extended; const Exponent: Integer): Extended; overload;
asm
   mov   edx,eax
   //if Base = 0 then
   fldz
   fld   Base
   fcomp
   ffree st(0)
   fstsw ax
   sahf
   jnz   @IfEnd2
   //if Exponent = 0 then
   test  edx,edx
   jnz   @Else2
   //ResultX := 1
   fld1
   jmp   @Exit
 @Else2 :
   //ResultX := 0;
   fldz
   jmp   @Exit
 @IfEnd2 :
   //else if Exponent = 0 then
   test  edx,edx
   jnz   @ElseIf2
   //ResultX := 1
   fld1
   jmp   @Exit
 @ElseIf2 :
   //else if Exponent = 1 then
   cmp   edx,1
   jnz   @ElseIf3
   //ResultX := Base
   fld   Base
   jmp   @Exit
 @ElseIf3 :
   //else if Exponent = 2 then
   cmp   edx,2
   jnz   @ElseIf4
   //ResultX := Base * Base
   fld   Base
   fmul  st(0),st(0)
   jmp   @Exit
 @ElseIf4 :
   //else if Exponent > 2 then
   cmp   edx,2
   jle   @ElseIf5
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fld   Base
   //I := 2;
   mov   eax,2
   //I2 := Exponent;
   mov   ecx,edx
   push  ebx
 @Repeat1Start :
   //I3 := I2 and 1;
   mov   ebx,ecx
   and   ebx,$01
   //if I3 = 1 then
   dec   ebx
   jnz   @IfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul  st(1),st(0)
 @IfEnd8 :
   //I2 := I2 shr 1;
   shr   ecx,1
   //ResultX := ResultX * ResultX;
   fmul  st(0),st(0)
   //I := I * 2;
   add   eax,eax
   //until(I > Exponent);
   cmp   edx,eax
   jnl   @Repeat1Start
   pop   ebx
   //ResultX := ResultX * ResultX2;
   fmulp st(1),st(0)
   jmp   @Exit
 @ElseIf5 :
   //else if Exponent = -1 then
   cmp   edx,-1
   jnz   @ElseIf6
   //ResultX := 1/Base
   fld1
   fld   Base
   fdivp
   jmp   @Exit
 @ElseIf6 :
   //else if Exponent = -2 then
   cmp   edx,-2
   jnz   @Else7
   //ResultX := 1/(Base*Base)
   fld1
   fld   Base
   fmul  st(0),st(0)
   fdiv
   jmp   @Exit
 @Else7 :
   push  ebx
   push  edi
   //else //if Exponent < -2 then
   //I := 2;
   mov   eax,2
   //I2 := -Exponent;
   mov   ecx,edx
   neg   ecx
   mov   edi,ecx
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fld   Base
 @Repeat2Start :
   //I3 := I2 and 1;
   mov   ebx,ecx
   and   ebx,1
   //if I3 = 1 then
   dec   ebx
   jnz   @IfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul  st(1),st(0)
 @IfEnd7 :
   //I2 := I2 shr 1;
   shr   ecx,1
   //ResultX := ResultX * ResultX;
   fmul  st(0),st(0)
   //I := I * 2;
   add   eax,eax
   //until(I > -Exponent);
   cmp   eax,edi
   jle   @Repeat2Start
   pop   edi
   pop   ebx
   //ResultX := ResultX * ResultX2;
   fmulp st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
 @Exit :
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function Power_DKC_IA32_1(const Base, Exponent: Extended): Extended; overload;
var
 Y : Integer;

begin
 if (Abs(Exponent) <= MaxInt) then
  begin
   Y := Round(Exponent);
   if (Exponent = Y) then
    Result := IntPowerDKCIA32_1(Base, Y)
   else
    Result := Exp(Exponent * Ln(Base))
  end
 else
  begin
   if (Base <> 0) and (Exponent > 0) then
    Result := Exp(Exponent * Ln(Base))
   else if Base = 0 then
    Result := 0
   else
    Result := Exp(Exponent * Ln(Base))
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function Power_DKC_IA32_1(const Base, Exponent: Double): Double; overload;
var
 Y : Integer;

begin
 if (Abs(Exponent) <= MaxInt) then
  begin
   Y := Round(Exponent);
   if (Exponent = Y) then
    Result := IntPowerDKCIA32_1(Base, Y)
   else
    Result := Exp(Exponent * Ln(Base))
  end
 else
  begin
   if (Base <> 0) and (Exponent > 0) then
    Result := Exp(Exponent * Ln(Base))
   else if Base = 0 then
    Result := 0
   else
    Result := Exp(Exponent * Ln(Base))
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function Power_DKC_IA32_1(const Base, Exponent: Single): Single; overload;
var
 Y : Integer;

begin
 if (Abs(Exponent) <= MaxInt) then
  begin
   Y := Round(Exponent);
   if (Exponent = Y) then
    Result := IntPowerDKCIA32_1(Base, Y)
   else
    Result := Exp(Exponent * Ln(Base))
  end
 else
  begin
   if (Base <> 0) and (Exponent > 0) then
    Result := Exp(Exponent * Ln(Base))
   else if Base = 0 then
    Result := 0
   else
    Result := Exp(Exponent * Ln(Base))
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI

function IntPowerDKCIA32Ext_2(const Base: Single; const Exponent: Integer): Single; overload;
asm
   //if Base = 0 then
   fldz
   fld    Base
   fcomip st(0),st(1)
   ffree  st(0)
   jnz    @IfEnd2
   //if Exponent = 0 then
   test   eax,eax
   jnz    @Else2
   //ResultX := 1
   fld1
   jmp    @Exit
 @Else2 :
   //ResultX := 0;
   fldz
   jmp    @Exit
 @IfEnd2 :
   //else if Exponent = 0 then
   test   eax,eax
   jnz    @ElseIf2
   //ResultX := 1
   fld1
   jmp    @Exit
 @ElseIf2 :
   //else if Exponent = 1 then
   cmp    eax,1
   jnz    @ElseIf3
   //ResultX := Base
   fld    Base
   jmp    @Exit
 @ElseIf3 :
   //else if Exponent = 2 then
   cmp    eax,2
   jnz    @ElseIf4
   //ResultX := Base * Base
   fld    Base
   fmul   st(0),st(0)
   jmp    @Exit
 @ElseIf4 :
   //else if Exponent > 2 then
   cmp    eax,2
   jle    @ElseIf5
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fld    Base
   mov    ecx,eax
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @Repeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @Repeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   jmp    @Exit
 @ElseIf5 :
   //else if Exponent = -1 then
   cmp    eax,-1
   jnz    @ElseIf6
   //ResultX := 1/Base
   fld1
   fdiv   Base
   jmp    @Exit
 @ElseIf6 :
   //else if Exponent = -2 then
   cmp    eax,-2
   jnz    @Else7
   //ResultX := 1/(Base*Base)
   fld1
   fld    Base
   fmul   st(0),st(0)
   fdiv
   jmp    @Exit
 @Else7 :
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fld    Base
 @Repeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @Repeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
 @Exit :
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI

function IntPowerDKCIA32Ext_2(const Base: Double; const Exponent: Integer): Double; overload;
asm
   //if Base = 0 then
   fldz
   fld    Base
   fcomip st(0),st(1)
   ffree  st(0)
   jnz    @IfEnd2
   //if Exponent = 0 then
   test   eax,eax
   jnz    @Else2
   //ResultX := 1
   fld1
   jmp    @Exit
 @Else2 :
   //ResultX := 0;
   fldz
   jmp    @Exit
 @IfEnd2 :
   //else if Exponent = 0 then
   test   eax,eax
   jnz    @ElseIf2
   //ResultX := 1
   fld1
   jmp    @Exit
 @ElseIf2 :
   //else if Exponent = 1 then
   cmp    eax,1
   jnz    @ElseIf3
   //ResultX := Base
   fld    Base
   jmp    @Exit
 @ElseIf3 :
   //else if Exponent = 2 then
   cmp    eax,2
   jnz    @ElseIf4
   //ResultX := Base * Base
   fld    Base
   fmul   st(0),st(0)
   jmp    @Exit
 @ElseIf4 :
   //else if Exponent > 2 then
   cmp    eax,2
   jle    @ElseIf5
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fld    Base
   mov    ecx,eax
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @Repeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @Repeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   jmp    @Exit
 @ElseIf5 :
   //else if Exponent = -1 then
   cmp    eax,-1
   jnz    @ElseIf6
   //ResultX := 1/Base
   fld1
   fdiv   Base
   jmp    @Exit
 @ElseIf6 :
   //else if Exponent = -2 then
   cmp    eax,-2
   jnz    @Else7
   //ResultX := 1/(Base*Base)
   fld1
   fld    Base
   fmul   st(0),st(0)
   fdiv
   jmp    @Exit
 @Else7 :
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fld    Base
 @Repeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @Repeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
 @Exit :
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI

function IntPowerDKCIA32Ext_2(const Base: Extended; const Exponent: Integer): Extended; overload;
asm
   //if Base = 0 then
   fldz
   fld    Base
   fcomip st(0),st(1)
   ffree  st(0)
   jnz    @IfEnd2
   //if Exponent = 0 then
   test   eax,eax
   jnz    @Else2
   //ResultX := 1
   fld1
   jmp    @Exit
 @Else2 :
   //ResultX := 0;
   fldz
   jmp    @Exit
 @IfEnd2 :
   //else if Exponent = 0 then
   test   eax,eax
   jnz    @ElseIf2
   //ResultX := 1
   fld1
   jmp    @Exit
 @ElseIf2 :
   //else if Exponent = 1 then
   cmp    eax,1
   jnz    @ElseIf3
   //ResultX := Base
   fld    Base
   jmp    @Exit
 @ElseIf3 :
   //else if Exponent = 2 then
   cmp    eax,2
   jnz    @ElseIf4
   //ResultX := Base * Base
   fld    Base
   fmul   st(0),st(0)
   jmp    @Exit
 @ElseIf4 :
   //else if Exponent > 2 then
   cmp    eax,2
   jle    @ElseIf5
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fld    Base
   mov    ecx,eax
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @Repeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @Repeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   jmp    @Exit
 @ElseIf5 :
   //else if Exponent = -1 then
   cmp    eax,-1
   jnz    @ElseIf6
   //ResultX := 1/Base
   fld1
   fld    Base
   fdivp
   jmp    @Exit
 @ElseIf6 :
   //else if Exponent = -2 then
   cmp    eax,-2
   jnz    @Else7
   //ResultX := 1/(Base*Base)
   fld1
   fld    Base
   fmul   st(0),st(0)
   fdiv
   jmp    @Exit
 @Else7 :
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fld    Base
 @Repeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @Repeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
 @Exit :
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI

function Power_DKC_IA32Ext_2(const Base, Exponent: Extended): Extended; overload;
var
 Y : Integer;

begin
 if (Abs(Exponent) <= MaxInt) then
  begin
   Y := Round(Exponent);
   if (Exponent = Y) then
    Result := IntPowerDKCIA32Ext_2(Base, Y)
   else
    Result := Exp(Exponent * Ln(Base))
  end
 else
  begin
   if (Base <> 0) and (Exponent > 0) then
    Result := Exp(Exponent * Ln(Base))
   else if Base = 0 then
    Result := 0
   else
    Result := Exp(Exponent * Ln(Base))
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI

function Power_DKC_IA32Ext_2(const Base, Exponent: Double): Double; overload;
var
 Y : Integer;

begin
 if (Abs(Exponent) <= MaxInt) then
  begin
   Y := Round(Exponent);
   if (Exponent = Y) then
    Result := IntPowerDKCIA32Ext_2(Base, Y)
   else
    Result := Exp(Exponent * Ln(Base))
  end
 else
  begin
   if (Base <> 0) and (Exponent > 0) then
    Result := Exp(Exponent * Ln(Base))
   else if Base = 0 then
    Result := 0
   else
    Result := Exp(Exponent * Ln(Base))
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI

function Power_DKC_IA32Ext_2(const Base, Exponent: Single): Single; overload;
var
 Y : Integer;

begin
 if (Abs(Exponent) <= MaxInt) then
  begin
   Y := Round(Exponent);
   if (Exponent = Y) then
    Result := IntPowerDKCIA32Ext_2(Base, Y)
   else
    Result := Exp(Exponent * Ln(Base))
  end
 else
  begin
   if (Base <> 0) and (Exponent > 0) then
    Result := Exp(Exponent * Ln(Base))
   else if Base = 0 then
    Result := 0
   else
    Result := Exp(Exponent * Ln(Base))
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI

function IntPowerDKCIA32Ext_3(const Base: Single; const Exponent: Integer): Single; overload;
asm
   //if Base = 0 then
   fldz
   fld    Base
   fcomi  st(0),st(1)
   jnz    @IfEnd2
   //if Exponent = 0 then
   test   eax,eax
   jnz    @Else2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   jmp    @Exit
 @Else2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   jmp    @Exit
 @IfEnd2 :
   //else if Exponent = 0 then
   test   eax,eax
   jnz    @ElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   jmp    @Exit
 @ElseIf2 :
   //else if Exponent = 1 then
   cmp    eax,1
   jnz    @ElseIf3
   //ResultX := Base
   ffree  st(1)
   jmp    @Exit
 @ElseIf3 :
   //else if Exponent = 2 then
   cmp    eax,2
   jnz    @ElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   jmp    @Exit
 @ElseIf4 :
   //else if Exponent > 2 then
   cmp    eax,2
   jle    @ElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    ecx,eax
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @Repeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @Repeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   jmp    @Exit
 @ElseIf5 :
   //else if Exponent = -1 then
   cmp    eax,-1
   jnz    @ElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   jmp    @Exit
 @ElseIf6 :
   //else if Exponent = -2 then
   cmp    eax,-2
   jnz    @Else7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   jmp    @Exit
 @Else7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @Repeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @Repeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
 @Exit :
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI

function IntPowerDKCIA32Ext_3(const Base: Double; const Exponent: Integer): Double; overload;
asm
   //if Base = 0 then
   fldz
   fld    Base
   fcomi  st(0),st(1)
   jnz    @IfEnd2
   //if Exponent = 0 then
   test   eax,eax
   jnz    @Else2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   jmp    @Exit
 @Else2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   jmp    @Exit
 @IfEnd2 :
   //else if Exponent = 0 then
   test   eax,eax
   jnz    @ElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   jmp    @Exit
 @ElseIf2 :
   //else if Exponent = 1 then
   cmp    eax,1
   jnz    @ElseIf3
   //ResultX := Base
   ffree  st(1)
   jmp    @Exit
 @ElseIf3 :
   //else if Exponent = 2 then
   cmp    eax,2
   jnz    @ElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   jmp    @Exit
 @ElseIf4 :
   //else if Exponent > 2 then
   cmp    eax,2
   jle    @ElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    ecx,eax
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @Repeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @Repeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   jmp    @Exit
 @ElseIf5 :
   //else if Exponent = -1 then
   cmp    eax,-1
   jnz    @ElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   jmp    @Exit
 @ElseIf6 :
   //else if Exponent = -2 then
   cmp    eax,-2
   jnz    @Else7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   jmp    @Exit
 @Else7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @Repeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @Repeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
 @Exit :
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI

function IntPowerDKCIA32Ext_3(const Base: Extended; const Exponent: Integer): Extended; overload;
asm
   //if Base = 0 then
   fldz
   fld    Base
   fcomi  st(0),st(1)
   jnz    @IfEnd2
   //if Exponent = 0 then
   test   eax,eax
   jnz    @Else2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   jmp    @Exit
 @Else2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   jmp    @Exit
 @IfEnd2 :
   //else if Exponent = 0 then
   test   eax,eax
   jnz    @ElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   jmp    @Exit
 @ElseIf2 :
   //else if Exponent = 1 then
   cmp    eax,1
   jnz    @ElseIf3
   //ResultX := Base
   ffree  st(1)
   jmp    @Exit
 @ElseIf3 :
   //else if Exponent = 2 then
   cmp    eax,2
   jnz    @ElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   jmp    @Exit
 @ElseIf4 :
   //else if Exponent > 2 then
   cmp    eax,2
   jle    @ElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    ecx,eax
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @Repeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @Repeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   jmp    @Exit
 @ElseIf5 :
   //else if Exponent = -1 then
   cmp    eax,-1
   jnz    @ElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   jmp    @Exit
 @ElseIf6 :
   //else if Exponent = -2 then
   cmp    eax,-2
   jnz    @Else7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   jmp    @Exit
 @Else7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @Repeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @Repeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
 @Exit :
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI

function Power_DKC_IA32Ext_3(const Base, Exponent: Extended): Extended; overload;
var
 Y : Integer;

begin
 if (Abs(Exponent) <= MaxInt) then
  begin
   Y := Round(Exponent);
   if (Exponent = Y) then
    Result := IntPowerDKCIA32Ext_3(Base, Y)
   else
    Result := Exp(Exponent * Ln(Base))
  end
 else
  begin
   if (Base <> 0) and (Exponent > 0) then
    Result := Exp(Exponent * Ln(Base))
   else if Base = 0 then
    Result := 0
   else
    Result := Exp(Exponent * Ln(Base))
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI

function Power_DKC_IA32Ext_3(const Base, Exponent: Double): Double; overload;
var
 Y : Integer;

begin
 if (Abs(Exponent) <= MaxInt) then
  begin
   Y := Round(Exponent);
   if (Exponent = Y) then
    Result := IntPowerDKCIA32Ext_3(Base, Y)
   else
    Result := Exp(Exponent * Ln(Base))
  end
 else
  begin
   if (Base <> 0) and (Exponent > 0) then
    Result := Exp(Exponent * Ln(Base))
   else if Base = 0 then
    Result := 0
   else
    Result := Exp(Exponent * Ln(Base))
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI

function Power_DKC_IA32Ext_3(const Base, Exponent: Single): Single; overload;
var
 Y : Integer;

begin
 if (Abs(Exponent) <= MaxInt) then
  begin
   Y := Round(Exponent);
   if (Exponent = Y) then
    Result := IntPowerDKCIA32Ext_3(Base, Y)
   else
    Result := Exp(Exponent * Ln(Base))
  end
 else
  begin
   if (Base <> 0) and (Exponent > 0) then
    Result := Exp(Exponent * Ln(Base))
   else if Base = 0 then
    Result := 0
   else
    Result := Exp(Exponent * Ln(Base))
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI

function Power_DKC_IA32Ext_4(const Base, Exponent: Extended): Extended; overload;
const
 MAXINTFP : Extended = $7fffffff;

asm
   sub    esp,$14
   //if (Abs(Exponent) <= MaxInt) then
   fld    MAXINTFP
   fld    Exponent
   fld    st(0)
   fabs
   fcomip st(0),st(2)
   ffree  st(1)
   jae    @IfEnd1
   //Y := Round(Exponent);
   fld    st(0)
   frndint
   fist   dword ptr [esp]
   fcomip st(0),st(1)
   ffree  st(0)
   jnz    @IfEnd2
   //Result := IntPowerDKCIA32_4e(Base, Y)
   //if Base = 0 then
   fldz
   fld    Base
   fcomi  st(0),st(1)
   jnz    @IntPowIfEnd2
   //if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElse2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   jmp    @Exit
 @IntPowElse2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   jmp    @Exit
 @IntPowIfEnd2 :
   //else if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   jmp    @Exit
 @IntPowElseIf2 :
   //else if Exponent = 1 then
   cmp    ecx,1
   jnz    @IntPowElseIf3
   //ResultX := Base
   ffree  st(1)
   jmp    @Exit
 @IntPowElseIf3 :
   //else if Exponent = 2 then
   cmp    ecx,2
   jnz    @IntPowElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   jmp    @Exit
 @IntPowElseIf4 :
   //else if Exponent > 2 then
   cmp    ecx,2
   jle    @IntPowElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    eax,ecx
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @IntPowRepeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IntPowIfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @IntPowRepeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   jmp    @Exit
 @IntPowElseIf5 :
   //else if Exponent = -1 then
   cmp    ecx,-1
   jnz    @IntPowElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   jmp    @Exit
 @IntPowElseIf6 :
   //else if Exponent = -2 then
   cmp    ecx,-2
   jnz    @IntPowElse7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   jmp    @Exit
 @IntPowElse7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   mov    eax,ecx
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @IntPowRepeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IntPowIfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @IntPowRepeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
   jmp    @Exit
 @IfEnd2 :
   //Result := Exp(Exponent * Ln(Base))
   fld    Base
   fldln2
   fxch   st(1)
   fyl2x
   fld    Exponent
   fmulp
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   jmp    @Exit
 @IfEnd1 :
   //if (Exponent > 0) and (Base <> 0) then
   fldz
   fcomi  st(0),st(1)
   jbe    @IfEnd3
   fld    Base
   fcomi  st(0),st(1)
   jz     @IfEnd3
   ffree  st(1)
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0), st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   jmp    @Exit
 @IfEnd3 :
   //else if Base = 0 then
   fld    Base
   fcomi  st(0),st(1)
   ffree  st(1)
   jnz    @ElseIfEnd4
   //Result := 0
   ffree  st(2)
   jmp    @Exit
 @ElseIfEnd4 :
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0),st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
 @Exit :
   wait
   mov    esp,ebp
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI

function Power_DKC_IA32Ext_4(const Base, Exponent: Double): Double; overload;
const
 MAXINTFP : Extended = $7fffffff;

asm
   sub    esp,$14
   //if (Abs(Exponent) <= MaxInt) then
   fld    MAXINTFP
   fld    Exponent
   fld    st(0)
   fabs
   fcomip st(0),st(2)
   ffree  st(1)
   jae    @IfEnd1
   //Y := Round(Exponent);
   fld    st(0)
   frndint
   fist   dword ptr [esp]
   fcomip st(0),st(1)
   ffree  st(0)
   jnz    @IfEnd2
   //Result := IntPowerDKCIA32_4e(Base, Y)
   //if Base = 0 then
   fldz
   fld    Base
   fcomi  st(0),st(1)
   jnz    @IntPowIfEnd2
   //if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElse2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   jmp    @Exit
 @IntPowElse2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   jmp    @Exit
 @IntPowIfEnd2 :
   //else if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   jmp    @Exit
 @IntPowElseIf2 :
   //else if Exponent = 1 then
   cmp    ecx,1
   jnz    @IntPowElseIf3
   //ResultX := Base
   ffree  st(1)
   jmp    @Exit
 @IntPowElseIf3 :
   //else if Exponent = 2 then
   cmp    ecx,2
   jnz    @IntPowElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   jmp    @Exit
 @IntPowElseIf4 :
   //else if Exponent > 2 then
   cmp    ecx,2
   jle    @IntPowElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    eax,ecx
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @IntPowRepeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IntPowIfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @IntPowRepeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   jmp    @Exit
 @IntPowElseIf5 :
   //else if Exponent = -1 then
   cmp    ecx,-1
   jnz    @IntPowElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   jmp    @Exit
 @IntPowElseIf6 :
   //else if Exponent = -2 then
   cmp    ecx,-2
   jnz    @IntPowElse7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   jmp    @Exit
 @IntPowElse7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   mov    eax,ecx
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @IntPowRepeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IntPowIfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @IntPowRepeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
   jmp    @Exit
 @IfEnd2 :
   //Result := Exp(Exponent * Ln(Base))
   fld    Base
   fldln2
   fxch   st(1)
   fyl2x
   fld    Exponent
   fmulp
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   jmp    @Exit
 @IfEnd1 :
   //if (Exponent > 0) and (Base <> 0) then
   fldz
   fcomip st(0),st(1)
   fld    Base
   jbe    @IfEnd3
   fldz
   fcomip st(0),st(1)
   jz     @IfEnd3
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0), st(1)
   ffree  st(1)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   jmp    @Exit
 @IfEnd3 :
   //else if Base = 0 then
   fldz
   fcomip st(0),st(1)
   jnz    @ElseIfEnd4
   //Result := 0
   ffree  st(1)
   jmp    @Exit
 @ElseIfEnd4 :
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0),st(1)
   ffree  st(1)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
 @Exit :
   wait
   mov    esp,ebp
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI

function Power_DKC_IA32Ext_4(const Base, Exponent: Single): Single; overload;
const
 MAXINTFP : Extended = $7fffffff;

asm
   sub    esp,$14
   //if (Abs(Exponent) <= MaxInt) then
   fld    MAXINTFP
   fld    Exponent
   fld    st(0)
   fabs
   fcomip st(0),st(2)
   ffree  st(1)
   jae    @IfEnd1
   //Y := Round(Exponent);
   fld    st(0)
   frndint
   fist   dword ptr [esp]
   fcomip st(0),st(1)
   ffree  st(0)
   jnz    @IfEnd2
   //Result := IntPowerDKCIA32_4e(Base, Y)
   //if Base = 0 then
   fldz
   fld    Base
   fcomi  st(0),st(1)
   jnz    @IntPowIfEnd2
   //if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElse2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   jmp    @Exit
 @IntPowElse2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   jmp    @Exit
 @IntPowIfEnd2 :
   //else if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   jmp    @Exit
 @IntPowElseIf2 :
   //else if Exponent = 1 then
   cmp    ecx,1
   jnz    @IntPowElseIf3
   //ResultX := Base
   ffree  st(1)
   jmp    @Exit
 @IntPowElseIf3 :
   //else if Exponent = 2 then
   cmp    ecx,2
   jnz    @IntPowElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   jmp    @Exit
 @IntPowElseIf4 :
   //else if Exponent > 2 then
   cmp    ecx,2
   jle    @IntPowElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    eax,ecx
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @IntPowRepeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IntPowIfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @IntPowRepeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   jmp    @Exit
 @IntPowElseIf5 :
   //else if Exponent = -1 then
   cmp    ecx,-1
   jnz    @IntPowElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   jmp    @Exit
 @IntPowElseIf6 :
   //else if Exponent = -2 then
   cmp    ecx,-2
   jnz    @IntPowElse7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   jmp    @Exit
 @IntPowElse7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   mov    eax,ecx
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @IntPowRepeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IntPowIfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @IntPowRepeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
   jmp    @Exit
 @IfEnd2 :
   //Result := Exp(Exponent * Ln(Base))
   fld    Base
   fldln2
   fxch   st(1)
   fyl2x
   fld    Exponent
   fmulp
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   jmp    @Exit
 @IfEnd1 :
   //if (Exponent > 0) and (Base <> 0) then
   fldz
   fcomip st(0),st(1)
   fld    Base
   jbe    @IfEnd3
   fldz
   fcomip st(0),st(1)
   jz     @IfEnd3
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0), st(1)
   ffree  st(1)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   jmp    @Exit
 @IfEnd3 :
   //else if Base = 0 then
   fldz
   fcomip st(0),st(1)
   jnz    @ElseIfEnd4
   //Result := 0
   ffree  st(1)
   jmp    @Exit
 @ElseIfEnd4 :
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0),st(1)
   ffree  st(1)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
 @Exit :
   wait
   mov    esp,ebp
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI + SSE2

function Power_DKC_SSE2_1(const Base, Exponent: Double): Double; overload;
const
 MAXINTFP : Extended = $7fffffff;

asm
   sub    esp,$14
   //if (Abs(Exponent) <= MaxInt) then
   fld    MAXINTFP
   fld    Exponent
   fld    st(0)
   fabs
   fcomip st(0),st(2)
   ffree  st(1)
   jae    @IfEnd1
   //Y := Round(Exponent);
   fld    st(0)
   frndint
   fcomip st(0),st(1)
   ffree  st(0)
   jnz    @IfEnd2
   //Result := IntPowerDKCIA32_4e(Base, Y)
   //if Base = 0 then
   fldz
   fld    Base
   fcomi  st(0),st(1)
   jnz    @IntPowIfEnd2
   //if Exponent = 0 then
   cvtsd2si ecx,Exponent
   test   ecx,ecx
   jnz    @IntPowElse2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   jmp    @Exit
 @IntPowElse2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   jmp    @Exit
 @IntPowIfEnd2 :
   //else if Exponent = 0 then
   cvtsd2si ecx,Exponent
   test   ecx,ecx
   jnz    @IntPowElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   jmp    @Exit
 @IntPowElseIf2 :
   //else if Exponent = 1 then
   cmp    ecx,1
   jnz    @IntPowElseIf3
   //ResultX := Base
   ffree  st(1)
   jmp    @Exit
 @IntPowElseIf3 :
   //else if Exponent = 2 then
   cmp    ecx,2
   jnz    @IntPowElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   jmp    @Exit
 @IntPowElseIf4 :
   //else if Exponent > 2 then
   cmp    ecx,2
   jle    @IntPowElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    eax,ecx
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @IntPowRepeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IntPowIfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @IntPowRepeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   jmp    @Exit
 @IntPowElseIf5 :
   //else if Exponent = -1 then
   cmp    ecx,-1
   jnz    @IntPowElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   jmp    @Exit
 @IntPowElseIf6 :
   //else if Exponent = -2 then
   cmp    ecx,-2
   jnz    @IntPowElse7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   jmp    @Exit
 @IntPowElse7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   mov    eax,ecx
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @IntPowRepeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IntPowIfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @IntPowRepeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
   jmp    @Exit
 @IfEnd2 :
   //Result := Exp(Exponent * Ln(Base))
   fld    Base
   fldln2
   fxch   st(1)
   fyl2x
   fld    Exponent
   fmulp
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   jmp    @Exit
 @IfEnd1 :
   //if (Exponent > 0) and (Base <> 0) then
   fldz
   fcomip st(0),st(1)
   fld    Base
   jbe    @IfEnd3
   fldz
   fcomip st(0),st(1)
   jz     @IfEnd3
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0), st(1)
   ffree  st(1)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   jmp    @Exit
 @IfEnd3 :
   //else if Base = 0 then
   fldz
   fcomip st(0),st(1)
   jnz    @ElseIfEnd4
   //Result := 0
   ffree  st(1)
   jmp    @Exit
 @ElseIfEnd4 :
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0),st(1)
   ffree  st(1)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
 @Exit :
   wait
   mov    esp,ebp
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI + SSE2

function Power_DKC_SSE2_2(const Base, Exponent: Double): Double; overload;
const
 MAXINTFP : Extended = $7fffffff;

asm
   sub    esp,$14
   //if (Abs(Exponent) <= MaxInt) then
   fld    MAXINTFP
   fld    Exponent
   fld    st(0)
   fabs
   fcomip st(0),st(2)
   ffree  st(1)
   jae    @IfEnd1
   //Y := Round(Exponent);
   fld    st(0)
   frndint
   fcomip st(0),st(1)
   ffree  st(0)
   jnz    @IfEnd2
   //Result := IntPowerDKCIA32_4e(Base, Y)
   //if Base = 0 then
   fldz
   fld    Base
   fcomi  st(0),st(1)
   jnz    @IntPowIfEnd2
   //if Exponent = 0 then
   cvtsd2si ecx,Exponent
   test   ecx,ecx
   jnz    @IntPowElse2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   mov    esp,ebp
   pop    ebp
   ret    $10
   //jmp    @Exit
 @IntPowElse2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   mov    esp,ebp
   pop    ebp
   ret    $10
   //jmp    @Exit
 @IntPowIfEnd2 :
   //else if Exponent = 0 then
   cvtsd2si ecx,Exponent
   test   ecx,ecx
   jnz    @IntPowElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   mov    esp,ebp
   pop    ebp
   ret    $10
   //jmp    @Exit
 @IntPowElseIf2 :
   //else if Exponent = 1 then
   cmp    ecx,1
   jnz    @IntPowElseIf3
   //ResultX := Base
   ffree  st(1)
   mov    esp,ebp
   pop    ebp
   ret    $10
   //jmp    @Exit
 @IntPowElseIf3 :
   //else if Exponent = 2 then
   cmp    ecx,2
   jnz    @IntPowElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   mov    esp,ebp
   pop    ebp
   ret    $10
   //jmp    @Exit
 @IntPowElseIf4 :
   //else if Exponent > 2 then
   cmp    ecx,2
   jle    @IntPowElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    eax,ecx
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @IntPowRepeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IntPowIfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @IntPowRepeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   mov    esp,ebp
   pop    ebp
   ret    $10
   //jmp    @Exit
 @IntPowElseIf5 :
   //else if Exponent = -1 then
   cmp    ecx,-1
   jnz    @IntPowElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   mov    esp,ebp
   pop    ebp
   ret    $10
   //jmp    @Exit
 @IntPowElseIf6 :
   //else if Exponent = -2 then
   cmp    ecx,-2
   jnz    @IntPowElse7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   mov    esp,ebp
   pop    ebp
   ret    $10
   //jmp    @Exit
 @IntPowElse7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   mov    eax,ecx
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @IntPowRepeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IntPowIfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @IntPowRepeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
   mov    esp,ebp
   pop    ebp
   ret    $10
   //jmp    @Exit
 @IfEnd2 :
   //Result := Exp(Exponent * Ln(Base))
   fld    Base
   fldln2
   fxch   st(1)
   fyl2x
   fld    Exponent
   fmulp
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   mov    esp,ebp
   pop    ebp
   ret    $10
   //jmp    @Exit
 @IfEnd1 :
   //if (Exponent > 0) and (Base <> 0) then
   fldz
   fcomip st(0),st(1)
   fld    Base
   jbe    @IfEnd3
   fldz
   fcomip st(0),st(1)
   jz     @IfEnd3
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0), st(1)
   ffree  st(1)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   mov    esp,ebp
   pop    ebp
   ret    $10
   //jmp    @Exit
 @IfEnd3 :
   //else if Base = 0 then
   fldz
   fcomip st(0),st(1)
   jnz    @ElseIfEnd4
   //Result := 0
   ffree  st(1)
   mov    esp,ebp
   pop    ebp
   ret    $10
   //jmp    @Exit
 @ElseIfEnd4 :
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0),st(1)
   ffree  st(1)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
 //@Exit :
   wait
   mov    esp,ebp
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI + SSE

function Power_DKC_SSE_1(const Base, Exponent: Single): Single; overload;
const
 MAXINTFP : Extended = $7fffffff;

asm
   sub    esp,$14
   //if (Abs(Exponent) <= MaxInt) then
   fld    MAXINTFP
   fld    Exponent
   fld    st(0)
   fabs
   fcomip st(0),st(2)
   ffree  st(1)
   jae    @IfEnd1
   //Y := Round(Exponent);
   fld    st(0)
   frndint
   fcomip st(0),st(1)
   ffree  st(0)
   jnz    @IfEnd2
   //Result := IntPowerDKCIA32_4e(Base, Y)
   //if Base = 0 then
   fldz
   fld    Base
   fcomi  st(0),st(1)
   jnz    @IntPowIfEnd2
   //if Exponent = 0 then
   cvtss2si ecx,Exponent
   test   ecx,ecx
   jnz    @IntPowElse2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   jmp    @Exit
 @IntPowElse2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   jmp    @Exit
 @IntPowIfEnd2 :
   //else if Exponent = 0 then
   cvtss2si ecx,Exponent
   test   ecx,ecx
   jnz    @IntPowElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   jmp    @Exit
 @IntPowElseIf2 :
   //else if Exponent = 1 then
   cmp    ecx,1
   jnz    @IntPowElseIf3
   //ResultX := Base
   ffree  st(1)
   jmp    @Exit
 @IntPowElseIf3 :
   //else if Exponent = 2 then
   cmp    ecx,2
   jnz    @IntPowElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   jmp    @Exit
 @IntPowElseIf4 :
   //else if Exponent > 2 then
   cmp    ecx,2
   jle    @IntPowElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    eax,ecx
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @IntPowRepeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IntPowIfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @IntPowRepeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   jmp    @Exit
 @IntPowElseIf5 :
   //else if Exponent = -1 then
   cmp    ecx,-1
   jnz    @IntPowElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   jmp    @Exit
 @IntPowElseIf6 :
   //else if Exponent = -2 then
   cmp    ecx,-2
   jnz    @IntPowElse7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   jmp    @Exit
 @IntPowElse7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   mov    eax,ecx
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @IntPowRepeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IntPowIfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @IntPowRepeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
   jmp    @Exit
 @IfEnd2 :
   //Result := Exp(Exponent * Ln(Base))
   fld    Base
   fldln2
   fxch   st(1)
   fyl2x
   fld    Exponent
   fmulp
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   jmp    @Exit
 @IfEnd1 :
   //if (Exponent > 0) and (Base <> 0) then
   fldz
   fcomip st(0),st(1)
   fld    Base
   jbe    @IfEnd3
   fldz
   fcomip st(0),st(1)
   jz     @IfEnd3
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0), st(1)
   ffree  st(1)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   jmp    @Exit
 @IfEnd3 :
   //else if Base = 0 then
   fldz
   fcomip st(0),st(1)
   jnz    @ElseIfEnd4
   //Result := 0
   ffree  st(1)
   jmp    @Exit
 @ElseIfEnd4 :
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0),st(1)
   ffree  st(1)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
 @Exit :
   wait
   mov    esp,ebp
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI + SSE

function Power_DKC_SSE_2(const Base, Exponent: Single): Single; overload;
const
 MAXINTFP : Extended = $7fffffff;

asm
   sub    esp,$14
   //if (Abs(Exponent) <= MaxInt) then
   fld    MAXINTFP
   fld    Exponent
   fld    st(0)
   fabs
   fcomip st(0),st(2)
   ffree  st(1)
   jae    @IfEnd1
   //Y := Round(Exponent);
   fld    st(0)
   frndint
   fcomip st(0),st(1)
   ffree  st(0)
   jnz    @IfEnd2
   //Result := IntPowerDKCIA32_4e(Base, Y)
   //if Base = 0 then
   fldz
   fld    Base
   fcomi  st(0),st(1)
   jnz    @IntPowIfEnd2
   //if Exponent = 0 then
   cvtss2si ecx,Exponent
   test   ecx,ecx
   jnz    @IntPowElse2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   mov    esp,ebp
   pop    ebp
   ret    $8
   //jmp    @Exit
 @IntPowElse2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   mov    esp,ebp
   pop    ebp
   ret    $8
   //jmp    @Exit
 @IntPowIfEnd2 :
   //else if Exponent = 0 then
   cvtss2si ecx,Exponent
   test   ecx,ecx
   jnz    @IntPowElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   mov    esp,ebp
   pop    ebp
   ret    $8
   //jmp    @Exit
 @IntPowElseIf2 :
   //else if Exponent = 1 then
   cmp    ecx,1
   jnz    @IntPowElseIf3
   //ResultX := Base
   ffree  st(1)
   mov    esp,ebp
   pop    ebp
   ret    $8
   //jmp    @Exit
 @IntPowElseIf3 :
   //else if Exponent = 2 then
   cmp    ecx,2
   jnz    @IntPowElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   mov    esp,ebp
   pop    ebp
   ret    $8
   //jmp    @Exit
 @IntPowElseIf4 :
   //else if Exponent > 2 then
   cmp    ecx,2
   jle    @IntPowElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    eax,ecx
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @IntPowRepeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IntPowIfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @IntPowRepeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   mov    esp,ebp
   pop    ebp
   ret    $8
   //jmp    @Exit
 @IntPowElseIf5 :
   //else if Exponent = -1 then
   cmp    ecx,-1
   jnz    @IntPowElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   mov    esp,ebp
   pop    ebp
   ret    $8
   //jmp    @Exit
 @IntPowElseIf6 :
   //else if Exponent = -2 then
   cmp    ecx,-2
   jnz    @IntPowElse7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   mov    esp,ebp
   pop    ebp
   ret    $8
   //jmp    @Exit
 @IntPowElse7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   mov    eax,ecx
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @IntPowRepeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IntPowIfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @IntPowRepeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
   mov    esp,ebp
   pop    ebp
   ret    $8
   //jmp    @Exit
 @IfEnd2 :
   //Result := Exp(Exponent * Ln(Base))
   fld    Base
   fldln2
   fxch   st(1)
   fyl2x
   fld    Exponent
   fmulp
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   mov    esp,ebp
   pop    ebp
   ret    $8
   //jmp    @Exit
 @IfEnd1 :
   //if (Exponent > 0) and (Base <> 0) then
   fldz
   fcomip st(0),st(1)
   fld    Base
   jbe    @IfEnd3
   fldz
   fcomip st(0),st(1)
   jz     @IfEnd3
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0), st(1)
   ffree  st(1)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   mov    esp,ebp
   pop    ebp
   ret    $8
   //jmp    @Exit
 @IfEnd3 :
   //else if Base = 0 then
   fldz
   fcomip st(0),st(1)
   jnz    @ElseIfEnd4
   //Result := 0
   ffree  st(1)
   mov    esp,ebp
   pop    ebp
   ret    $8
   //jmp    @Exit
 @ElseIfEnd4 :
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0),st(1)
   ffree  st(1)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
 //@Exit :
   wait
   mov    esp,ebp
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI

function Power_DKC_IA32Ext_5(const Base, Exponent: Extended): Extended; overload;
const
 MAXINTFP : Extended = $7fffffff;

asm
   sub    esp,$14
   //if (Abs(Exponent) <= MaxInt) then
   fld    MAXINTFP
   fld    Exponent
   fld    st(0)
   fabs
   fcomip st(0),st(2)
   ffree  st(1)
   jae    @IfEnd1
   //Y := Round(Exponent);
   fld    st(0)
   frndint
   fist   dword ptr [esp]
   fcomip st(0),st(1)
   ffree  st(0)
   jnz    @IfEnd2
   //Result := IntPowerDKCIA32_4e(Base, Y)
   //if Base = 0 then
   fldz
   fld    Base
   fcomi  st(0),st(1)
   jnz    @IntPowIfEnd2
   //if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElse2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElse2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowIfEnd2 :
   //else if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElseIf2 :
   //else if Exponent = 1 then
   cmp    ecx,1
   jnz    @IntPowElseIf3
   //ResultX := Base
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElseIf3 :
   //else if Exponent = 2 then
   cmp    ecx,2
   jnz    @IntPowElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElseIf4 :
   //else if Exponent > 2 then
   cmp    ecx,2
   jle    @IntPowElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    eax,ecx
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @IntPowRepeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IntPowIfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @IntPowRepeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElseIf5 :
   //else if Exponent = -1 then
   cmp    ecx,-1
   jnz    @IntPowElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElseIf6 :
   //else if Exponent = -2 then
   cmp    ecx,-2
   jnz    @IntPowElse7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElse7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   mov    eax,ecx
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @IntPowRepeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IntPowIfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @IntPowRepeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IfEnd2 :
   //Result := Exp(Exponent * Ln(Base))
   fld    Base
   fldln2
   fxch   st(1)
   fyl2x
   fld    Exponent
   fmulp
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IfEnd1 :
   //if (Exponent > 0) and (Base <> 0) then
   fldz
   fcomi  st(0),st(1)
   jbe    @IfEnd3
   fld    Base
   fcomi  st(0),st(1)
   jz     @IfEnd3
   ffree  st(1)
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0), st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IfEnd3 :
   //else if Base = 0 then
   fld    Base
   fcomi  st(0),st(1)
   ffree  st(1)
   jnz    @ElseIfEnd4
   //Result := 0
   ffree  st(2)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @ElseIfEnd4 :
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0),st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI

function Power_DKC_IA32Ext_5(const Base, Exponent: Double): Double; overload;
const
 MAXINTFP : Extended = $7fffffff;

asm
   sub    esp,$14
   //if (Abs(Exponent) <= MaxInt) then
   fld    MAXINTFP
   fld    Exponent
   fld    st(0)
   fabs
   fcomip st(0),st(2)
   ffree  st(1)
   jae    @IfEnd1
   //Y := Round(Exponent);
   fld    st(0)
   frndint
   fist   dword ptr [esp]
   fcomip st(0),st(1)
   ffree  st(0)
   jnz    @IfEnd2
   //Result := IntPowerDKCIA32_4e(Base, Y)
   //if Base = 0 then
   fldz
   fld    Base
   fcomi  st(0),st(1)
   jnz    @IntPowIfEnd2
   //if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElse2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElse2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowIfEnd2 :
   //else if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf2 :
   //else if Exponent = 1 then
   cmp    ecx,1
   jnz    @IntPowElseIf3
   //ResultX := Base
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf3 :
   //else if Exponent = 2 then
   cmp    ecx,2
   jnz    @IntPowElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf4 :
   //else if Exponent > 2 then
   cmp    ecx,2
   jle    @IntPowElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    eax,ecx
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @IntPowRepeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IntPowIfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @IntPowRepeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf5 :
   //else if Exponent = -1 then
   cmp    ecx,-1
   jnz    @IntPowElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf6 :
   //else if Exponent = -2 then
   cmp    ecx,-2
   jnz    @IntPowElse7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElse7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   mov    eax,ecx
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @IntPowRepeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IntPowIfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @IntPowRepeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IfEnd2 :
   //Result := Exp(Exponent * Ln(Base))
   fld    Base
   fldln2
   fxch   st(1)
   fyl2x
   fld    Exponent
   fmulp
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IfEnd1 :
   //if (Exponent > 0) and (Base <> 0) then
   fldz
   fcomi  st(0),st(1)
   jbe    @IfEnd3
   fld    Base
   fcomi  st(0),st(1)
   jz     @IfEnd3
   ffree  st(1)
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0), st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IfEnd3 :
   //else if Base = 0 then
   fld    Base
   fcomi  st(0),st(1)
   ffree  st(1)
   jnz    @ElseIfEnd4
   //Result := 0
   ffree  st(2)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @ElseIfEnd4 :
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0),st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32 + FCOMI

function Power_DKC_IA32Ext_5(const Base, Exponent: Single): Single; overload;
const
 MAXINTFP : Extended = $7fffffff;

asm
   sub    esp,$14
   //if (Abs(Exponent) <= MaxInt) then
   fld    MAXINTFP
   fld    Exponent
   fld    st(0)
   fabs
   fcomip st(0),st(2)
   ffree  st(1)
   jae    @IfEnd1
   //Y := Round(Exponent);
   fld    st(0)
   frndint
   fist   dword ptr [esp]
   fcomip st(0),st(1)
   ffree  st(0)
   jnz    @IfEnd2
   //Result := IntPowerDKCIA32_4e(Base, Y)
   //if Base = 0 then
   fldz
   fld    Base
   fcomi  st(0),st(1)
   jnz    @IntPowIfEnd2
   //if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElse2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElse2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowIfEnd2 :
   //else if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElseIf2 :
   //else if Exponent = 1 then
   cmp    ecx,1
   jnz    @IntPowElseIf3
   //ResultX := Base
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElseIf3 :
   //else if Exponent = 2 then
   cmp    ecx,2
   jnz    @IntPowElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElseIf4 :
   //else if Exponent > 2 then
   cmp    ecx,2
   jle    @IntPowElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    eax,ecx
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @IntPowRepeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IntPowIfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @IntPowRepeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElseIf5 :
   //else if Exponent = -1 then
   cmp    ecx,-1
   jnz    @IntPowElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElseIf6 :
   //else if Exponent = -2 then
   cmp    ecx,-2
   jnz    @IntPowElse7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElse7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   mov    eax,ecx
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @IntPowRepeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IntPowIfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @IntPowRepeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IfEnd2 :
   //Result := Exp(Exponent * Ln(Base))
   fld    Base
   fldln2
   fxch   st(1)
   fyl2x
   fld    Exponent
   fmulp
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IfEnd1 :
   //if (Exponent > 0) and (Base <> 0) then
   fldz
   fcomi  st(0),st(1)
   jbe    @IfEnd3
   fld    Base
   fcomi  st(0),st(1)
   jz     @IfEnd3
   ffree  st(1)
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0), st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IfEnd3 :
   //else if Base = 0 then
   fld    Base
   fcomi  st(0),st(1)
   ffree  st(1)
   jnz    @ElseIfEnd4
   //Result := 0
   ffree  st(2)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @ElseIfEnd4 :
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0),st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function Power_DKC_IA32_2(const Base, Exponent: Extended): Extended; overload;
const
 MAXINTFP : Extended = $7fffffff;

asm
   sub    esp,$14
   //if (Abs(Exponent) <= MaxInt) then
   fld    MAXINTFP
   fld    Exponent
   fld    st(0)
   fabs
   fcomp  st(2)
   fstsw  ax
   sahf
   ffree  st(1)
   jae    @IfEnd1
   //Y := Round(Exponent);
   fld    st(0)
   frndint
   fist   dword ptr [esp]
   fcomp  st(1)
   fstsw  ax
   sahf
   ffree  st(0)
   jnz    @IfEnd2
   //Result := IntPowerDKCIA32_4e(Base, Y)
   //if Base = 0 then
   fldz
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf       
   jnz    @IntPowIfEnd2
   //if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElse2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElse2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowIfEnd2 :
   //else if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElseIf2 :
   //else if Exponent = 1 then
   cmp    ecx,1
   jnz    @IntPowElseIf3
   //ResultX := Base
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElseIf3 :
   //else if Exponent = 2 then
   cmp    ecx,2
   jnz    @IntPowElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElseIf4 :
   //else if Exponent > 2 then
   cmp    ecx,2
   jle    @IntPowElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    eax,ecx
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @IntPowRepeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IntPowIfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @IntPowRepeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElseIf5 :
   //else if Exponent = -1 then
   cmp    ecx,-1
   jnz    @IntPowElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElseIf6 :
   //else if Exponent = -2 then
   cmp    ecx,-2
   jnz    @IntPowElse7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElse7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   mov    eax,ecx
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @IntPowRepeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IntPowIfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @IntPowRepeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IfEnd2 :
   //Result := Exp(Exponent * Ln(Base))
   fld    Base
   fldln2
   fxch   st(1)
   fyl2x
   fld    Exponent
   fmulp
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IfEnd1 :
   //if (Exponent > 0) and (Base <> 0) then
   fldz
   fcom   st(1)
   fstsw  ax
   sahf
   jbe    @IfEnd3
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf       
   jz     @IfEnd3
   ffree  st(1)
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0), st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IfEnd3 :
   //else if Base = 0 then
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf
   ffree  st(1)
   jnz    @ElseIfEnd4
   //Result := 0
   ffree  st(2)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @ElseIfEnd4 :
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0),st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function Power_DKC_IA32_2(const Base, Exponent: Double): Double; overload;
const
 MAXINTFP : Extended = $7fffffff;

asm
   sub    esp,$14
   //if (Abs(Exponent) <= MaxInt) then
   fld    MAXINTFP
   fld    Exponent
   fld    st(0)
   fabs
   fcomp  st(2)
   fstsw  ax
   sahf
   ffree  st(1)
   jae    @IfEnd1
   //Y := Round(Exponent);
   fld    st(0)
   frndint
   fist   dword ptr [esp]
   fcomp  st(1)
   fstsw  ax
   sahf
   ffree  st(0)
   jnz    @IfEnd2
   //Result := IntPowerDKCIA32_4e(Base, Y)
   //if Base = 0 then
   fldz
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf
   jnz    @IntPowIfEnd2
   //if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElse2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElse2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowIfEnd2 :
   //else if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf2 :
   //else if Exponent = 1 then
   cmp    ecx,1
   jnz    @IntPowElseIf3
   //ResultX := Base
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf3 :
   //else if Exponent = 2 then
   cmp    ecx,2
   jnz    @IntPowElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf4 :
   //else if Exponent > 2 then
   cmp    ecx,2
   jle    @IntPowElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    eax,ecx
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @IntPowRepeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IntPowIfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @IntPowRepeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf5 :
   //else if Exponent = -1 then
   cmp    ecx,-1
   jnz    @IntPowElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf6 :
   //else if Exponent = -2 then
   cmp    ecx,-2
   jnz    @IntPowElse7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElse7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   mov    eax,ecx
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @IntPowRepeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IntPowIfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @IntPowRepeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IfEnd2 :
   //Result := Exp(Exponent * Ln(Base))
   fld    Base
   fldln2
   fxch   st(1)
   fyl2x
   fld    Exponent
   fmulp
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IfEnd1 :
   //if (Exponent > 0) and (Base <> 0) then
   fldz
   fcom   st(1)
   fstsw  ax
   sahf
   jbe    @IfEnd3
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf
   jz     @IfEnd3
   ffree  st(1)
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0), st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IfEnd3 :
   //else if Base = 0 then
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf
   ffree  st(1)
   jnz    @ElseIfEnd4
   //Result := 0
   ffree  st(2)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @ElseIfEnd4 :
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0),st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function Power_DKC_IA32_2(const Base, Exponent: Single): Single; overload;
const
 MAXINTFP : Extended = $7fffffff;

asm
   sub    esp,$14
   //if (Abs(Exponent) <= MaxInt) then
   fld    MAXINTFP
   fld    Exponent
   fld    st(0)
   fabs
   fcomp  st(2)
   fstsw  ax
   sahf
   ffree  st(1)
   jae    @IfEnd1
   //Y := Round(Exponent);
   fld    st(0)
   frndint
   fist   dword ptr [esp]
   fcomp   st(1)
   fstsw ax
   sahf
   ffree  st(0)
   jnz    @IfEnd2
   //Result := IntPowerDKCIA32_4e(Base, Y)
   //if Base = 0 then
   fldz
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf
   jnz    @IntPowIfEnd2
   //if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElse2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElse2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowIfEnd2 :
   //else if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElseIf2 :
   //else if Exponent = 1 then
   cmp    ecx,1
   jnz    @IntPowElseIf3
   //ResultX := Base
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElseIf3 :
   //else if Exponent = 2 then
   cmp    ecx,2
   jnz    @IntPowElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElseIf4 :
   //else if Exponent > 2 then
   cmp    ecx,2
   jle    @IntPowElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    eax,ecx
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @IntPowRepeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IntPowIfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @IntPowRepeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElseIf5 :
   //else if Exponent = -1 then
   cmp    ecx,-1
   jnz    @IntPowElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElseIf6 :
   //else if Exponent = -2 then
   cmp    ecx,-2
   jnz    @IntPowElse7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElse7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   mov    eax,ecx
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @IntPowRepeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IntPowIfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @IntPowRepeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IfEnd2 :
   //Result := Exp(Exponent * Ln(Base))
   fld    Base
   fldln2
   fxch   st(1)
   fyl2x
   fld    Exponent
   fmulp
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IfEnd1 :
   //if (Exponent > 0) and (Base <> 0) then
   fldz
   fcom   st(1)
   fstsw  ax
   sahf
   jbe    @IfEnd3
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf
   jz     @IfEnd3
   ffree  st(1)
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0), st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IfEnd3 :
   //else if Base = 0 then
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf
   ffree  st(1)
   jnz    @ElseIfEnd4
   //Result := 0
   ffree  st(2)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @ElseIfEnd4 :
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0),st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function Power_DKC_IA32_3(const Base, Exponent: Extended): Extended; overload;
const
 MAXINTFP : Extended = $7fffffff;

asm
   sub    esp,$14
   fnstcw [esp-12].Word         //Get current controlword
   mov    ax,$1372
   mov    [esp-8], ax
   fldcw  word ptr [esp-8]
   //if (Abs(Exponent) <= MaxInt) then
   fld    MAXINTFP
   fld    Exponent
   fld    st(0)
   fabs
   fcomp  st(2)
   fstsw  ax
   sahf
   ffree  st(1)
   jae    @IfEnd1
   //Y := Round(Exponent);
   fld    st(0)
   frndint
   fist   dword ptr [esp]
   fcomp  st(1)
   fstsw  ax
   sahf
   ffree  st(0)
   jnz    @IfEnd2
   //Result := IntPowerDKCIA32_4e(Base, Y)
   //if Base = 0 then
   fldz
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf       
   jnz    @IntPowIfEnd2
   //if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElse2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElse2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowIfEnd2 :
   //else if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElseIf2 :
   //else if Exponent = 1 then
   cmp    ecx,1
   jnz    @IntPowElseIf3
   //ResultX := Base
   ffree  st(1)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElseIf3 :
   //else if Exponent = 2 then
   cmp    ecx,2
   jnz    @IntPowElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElseIf4 :
   //else if Exponent > 2 then
   cmp    ecx,2
   jle    @IntPowElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    eax,ecx
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @IntPowRepeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IntPowIfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @IntPowRepeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElseIf5 :
   //else if Exponent = -1 then
   cmp    ecx,-1
   jnz    @IntPowElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElseIf6 :
   //else if Exponent = -2 then
   cmp    ecx,-2
   jnz    @IntPowElse7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IntPowElse7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   mov    eax,ecx
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @IntPowRepeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IntPowIfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @IntPowRepeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IfEnd2 :
   //Result := Exp(Exponent * Ln(Base))
   fld    Base
   fldln2
   fxch   st(1)
   fyl2x
   fld    Exponent
   fmulp
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IfEnd1 :
   //if (Exponent > 0) and (Base <> 0) then
   fldz
   fcom   st(1)
   fstsw  ax
   sahf
   jbe    @IfEnd3
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf
   jz     @IfEnd3
   ffree  st(1)
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0), st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @IfEnd3 :
   //else if Base = 0 then
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf
   ffree  st(1)
   jnz    @ElseIfEnd4
   //Result := 0
   ffree  st(2)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $18
 @ElseIfEnd4 :
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0),st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function Power_DKC_IA32_3(const Base, Exponent: Double): Double; overload;
const
 MAXINTFP : Extended = $7fffffff;

asm
   sub    esp,$14
   fnstcw [esp-12].Word         //Get current controlword
   mov    ax,$1372
   mov    [esp-8], ax
   fldcw  word ptr [esp-8]
   //if (Abs(Exponent) <= MaxInt) then
   fld    MAXINTFP
   fld    Exponent
   fld    st(0)
   fabs
   fcomp  st(2)
   fstsw  ax
   sahf
   ffree  st(1)
   jae    @IfEnd1
   //Y := Round(Exponent);
   fld    st(0)
   frndint
   fist   dword ptr [esp]
   fcomp  st(1)
   fstsw  ax
   sahf
   ffree  st(0)
   jnz    @IfEnd2
   //Result := IntPowerDKCIA32_4e(Base, Y)
   //if Base = 0 then
   fldz
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf
   jnz    @IntPowIfEnd2
   //if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElse2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElse2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowIfEnd2 :
   //else if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf2 :
   //else if Exponent = 1 then
   cmp    ecx,1
   jnz    @IntPowElseIf3
   //ResultX := Base
   ffree  st(1)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf3 :
   //else if Exponent = 2 then
   cmp    ecx,2
   jnz    @IntPowElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf4 :
   //else if Exponent > 2 then
   cmp    ecx,2
   jle    @IntPowElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    eax,ecx
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @IntPowRepeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IntPowIfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @IntPowRepeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf5 :
   //else if Exponent = -1 then
   cmp    ecx,-1
   jnz    @IntPowElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf6 :
   //else if Exponent = -2 then
   cmp    ecx,-2
   jnz    @IntPowElse7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElse7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   mov    eax,ecx
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @IntPowRepeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IntPowIfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @IntPowRepeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IfEnd2 :
   //Result := Exp(Exponent * Ln(Base))
   fld    Base
   fldln2
   fxch   st(1)
   fyl2x
   fld    Exponent
   fmulp
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IfEnd1 :
   //if (Exponent > 0) and (Base <> 0) then
   fldz
   fcom   st(1)
   fstsw  ax
   sahf
   jbe    @IfEnd3
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf
   jz     @IfEnd3
   ffree  st(1)
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0), st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IfEnd3 :
   //else if Base = 0 then
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf       
   ffree  st(1)
   jnz    @ElseIfEnd4
   //Result := 0
   ffree  st(2)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @ElseIfEnd4 :
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0),st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
end;

//Author:            Dennis Kjaer Christensen
//Date:              31/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function Power_DKC_IA32_3(const Base, Exponent: Single): Single; overload;
const
 MAXINTFP : Extended = $7fffffff;

asm
   sub    esp,$14
   fnstcw [esp-12].Word         //Get current controlword
   mov    ax,$1372
   mov    [esp-8], ax
   fldcw  word ptr [esp-8]
   //if (Abs(Exponent) <= MaxInt) then
   fld    MAXINTFP
   fld    Exponent
   fld    st(0)
   fabs
   fcomp  st(2)
   fstsw  ax
   sahf
   ffree  st(1)
   jae    @IfEnd1
   //Y := Round(Exponent);
   fld    st(0)
   frndint
   fist   dword ptr [esp]
   fcomp  st(1)
   fstsw  ax
   sahf
   ffree  st(0)
   jnz    @IfEnd2
   //Result := IntPowerDKCIA32_4e(Base, Y)
   //if Base = 0 then
   fldz
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf
   jnz    @IntPowIfEnd2
   //if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElse2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElse2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowIfEnd2 :
   //else if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElseIf2 :
   //else if Exponent = 1 then
   cmp    ecx,1
   jnz    @IntPowElseIf3
   //ResultX := Base
   ffree  st(1)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElseIf3 :
   //else if Exponent = 2 then
   cmp    ecx,2
   jnz    @IntPowElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElseIf4 :
   //else if Exponent > 2 then
   cmp    ecx,2
   jle    @IntPowElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    eax,ecx
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @IntPowRepeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IntPowIfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @IntPowRepeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElseIf5 :
   //else if Exponent = -1 then
   cmp    ecx,-1
   jnz    @IntPowElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElseIf6 :
   //else if Exponent = -2 then
   cmp    ecx,-2
   jnz    @IntPowElse7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IntPowElse7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   mov    eax,ecx
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @IntPowRepeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IntPowIfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @IntPowRepeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IfEnd2 :
   //Result := Exp(Exponent * Ln(Base))
   fld    Base
   fldln2
   fxch   st(1)
   fyl2x
   fld    Exponent
   fmulp
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IfEnd1 :
   //if (Exponent > 0) and (Base <> 0) then
   fldz
   fcom   st(1)
   fstsw  ax
   sahf
   jbe    @IfEnd3
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf
   jz     @IfEnd3
   ffree  st(1)
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0), st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @IfEnd3 :
   //else if Base = 0 then
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf
   ffree  st(1)
   jnz    @ElseIfEnd4
   //Result := 0
   ffree  st(2)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
   pop    ebp
   ret    $8
 @ElseIfEnd4 :
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0),st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   fldcw  word ptr [esp-12]     //Restore controlword
   wait
   mov    esp,ebp
end;

end.
