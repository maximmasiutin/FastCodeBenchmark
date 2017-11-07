unit PowerUnit;

interface

function PowerPas(const Base, Exponent: Extended): Extended; overload;
function PowerPas(const Base, Exponent: Double): Double; overload;
function PowerPas(const Base, Exponent: Single): Single; overload;

function IntPowerDKCPas4(const Base: Extended; const Exponent: Integer): Extended;
function PowerDKCPas4(const Base, Exponent: Extended): Extended; overload;
function PowerDKCPas4(const Base, Exponent: Double): Double; overload;
function PowerDKCPas4(const Base, Exponent: Single): Single; overload;
function PowerDKCIA32_1(const Base, Exponent: Extended): Extended; overload;
function PowerDKCIA32_1(const Base, Exponent: Double): Double; overload;
function PowerDKCIA32_1(const Base, Exponent: Single): Single; overload;
function PowerDKCIA32_2(const Base, Exponent: Extended): Extended; overload;
function PowerDKCIA32_2(const Base, Exponent: Double): Double; overload;
function PowerDKCIA32_2(const Base, Exponent: Single): Single; overload;
function PowerDKCIA32_3(const Base, Exponent: Extended): Extended; overload;
function PowerDKCIA32_3(const Base, Exponent: Double): Double; overload;
function PowerDKCIA32_3(const Base, Exponent: Single): Single; overload;

implementation

uses
 Math;

//Author:            Dennis Kjaer Christensen
//Date:              15/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function PowerPas(const Base, Exponent: Extended): Extended; overload;
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

function PowerPas(const Base, Exponent: Double): Double; overload;
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

function PowerPas(const Base, Exponent: Single): Single; overload;
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

function PowerDKCPas4(const Base, Exponent: Extended): Extended; overload;
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

function PowerDKCPas4(const Base, Exponent: Double): Double; overload;
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

function PowerDKCPas4(const Base, Exponent: Single): Single; overload;
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

function PowerDKCIA32_1(const Base, Exponent: Extended): Extended; overload;
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

function PowerDKCIA32_1(const Base, Exponent: Double): Double; overload;
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

function PowerDKCIA32_1(const Base, Exponent: Single): Single; overload;
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

function IntPowerDKCIA32_2(const Base: Single; const Exponent: Integer): Single; overload;
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

function IntPowerDKCIA32_2(const Base: Double; const Exponent: Integer): Double; overload;
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

function IntPowerDKCIA32_2(const Base: Extended; const Exponent: Integer): Extended; overload;
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

function PowerDKCIA32_2(const Base, Exponent: Extended): Extended; overload;
var
 Y : Integer;

begin
 if (Abs(Exponent) <= MaxInt) then
  begin
   Y := Round(Exponent);
   if (Exponent = Y) then
    Result := IntPowerDKCIA32_2(Base, Y)
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

function PowerDKCIA32_2(const Base, Exponent: Double): Double; overload;
var
 Y : Integer;

begin
 if (Abs(Exponent) <= MaxInt) then
  begin
   Y := Round(Exponent);
   if (Exponent = Y) then
    Result := IntPowerDKCIA32_2(Base, Y)
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

function PowerDKCIA32_2(const Base, Exponent: Single): Single; overload;
var
 Y : Integer;

begin
 if (Abs(Exponent) <= MaxInt) then
  begin
   Y := Round(Exponent);
   if (Exponent = Y) then
    Result := IntPowerDKCIA32_2(Base, Y)
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

function IntPowerDKCIA32_3(const Base: Single; const Exponent: Integer): Single; overload;
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

function IntPowerDKCIA32_3(const Base: Double; const Exponent: Integer): Double; overload;
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

function IntPowerDKCIA32_3(const Base: Extended; const Exponent: Integer): Extended; overload;
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

function PowerDKCIA32_3(const Base, Exponent: Extended): Extended; overload;
var
 Y : Integer;

begin
 if (Abs(Exponent) <= MaxInt) then
  begin
   Y := Round(Exponent);
   if (Exponent = Y) then
    Result := IntPowerDKCIA32_3(Base, Y)
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

function PowerDKCIA32_3(const Base, Exponent: Double): Double; overload;
var
 Y : Integer;

begin
 if (Abs(Exponent) <= MaxInt) then
  begin
   Y := Round(Exponent);
   if (Exponent = Y) then
    Result := IntPowerDKCIA32_3(Base, Y)
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

function PowerDKCIA32_3(const Base, Exponent: Single): Single; overload;
var
 Y : Integer;

begin
 if (Abs(Exponent) <= MaxInt) then
  begin
   Y := Round(Exponent);
   if (Exponent = Y) then
    Result := IntPowerDKCIA32_3(Base, Y)
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

end.
