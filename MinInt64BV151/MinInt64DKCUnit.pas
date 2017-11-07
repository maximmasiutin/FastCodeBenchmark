unit MinInt64DKCUnit;

interface

function Min_DKC_Pas_1_a(const A, B : Int64) : Int64;
function Min_DKC_Pas_1_b(const A, B : Int64) : Int64;
function Min_DKC_Pas_1_c(const A, B : Int64) : Int64;
function Min_DKC_Pas_1_d(const A, B : Int64) : Int64;
function Min_DKC_IA32_3_a(const A, B : Int64) : Int64;
function Min_DKC_IA32_3_b(const A, B : Int64) : Int64;
function Min_DKC_IA32_3_c(const A, B : Int64) : Int64;
function Min_DKC_IA32_3_d(const A, B : Int64) : Int64;
function Min_DKC_IA32_4_a(const A, B : Int64) : Int64;
function Min_DKC_IA32_4_b(const A, B : Int64) : Int64;
function Min_DKC_IA32_4_c(const A, B : Int64) : Int64;
function Min_DKC_IA32_4_d(const A, B : Int64) : Int64;
function Min_DKC_IA32Ext_1_a(const A, B : Int64) : Int64;
function Min_DKC_IA32Ext_1_b(const A, B : Int64) : Int64;
function Min_DKC_IA32Ext_1_c(const A, B : Int64) : Int64;
function Min_DKC_IA32Ext_1_d(const A, B : Int64) : Int64;

implementation

//Author:            Dennis Kjaer Christensen
//Date:              1/8 2003
//Instructionset(s): IA32

function Min_DKC_Pas_1_a(const A, B : Int64) : Int64;
begin
 if A <= B then
  Result := A
 else
  Result := B;
end;

procedure Filler1;
asm
 nop
 nop
 nop
end;

function Min_DKC_Pas_1_b(const A, B : Int64) : Int64;
begin
 if A <= B then
  Result := A
 else
  Result := B;
end;

procedure Filler2;
asm
 nop
 nop
 nop
end;

function Min_DKC_Pas_1_c(const A, B : Int64) : Int64;
begin
 if A <= B then
  Result := A
 else
  Result := B;
end;

procedure Filler3;
asm
 nop
 nop
 nop
end;

function Min_DKC_Pas_1_d(const A, B : Int64) : Int64;
begin
 if A <= B then
  Result := A
 else
  Result := B;
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/8 2003
//Instructionset(s): IA32

function Min_DKC_IA32_3_a(const A, B : Int64) : Int64;
asm
  //if A <= B then
  mov  edx,[ebp+$14]
  cmp  edx,[ebp+$0c]
  jnz  @LowTest
  mov  eax,[ebp+$10]
  cmp  eax,[ebp+$08]
  jnbe @ElseStart
  pop  ebp
  ret  $10
 @LowTest :
  jnle @ElseStart
  //Result := A
  mov  eax,[ebp+$10]
  pop  ebp
  ret  $10
  //Result := B;
 @ElseStart :
  mov  eax,[ebp+$08]
  mov  edx,[ebp+$0c]
end;

function Min_DKC_IA32_3_b(const A, B : Int64) : Int64;
asm
  //if A <= B then
  mov  edx,[ebp+$14]
  cmp  edx,[ebp+$0c]
  jnz  @LowTest
  mov  eax,[ebp+$10]
  cmp  eax,[ebp+$08]
  jnbe @ElseStart
  pop  ebp
  ret  $10
 @LowTest :
  jnle @ElseStart
  //Result := A
  mov  eax,[ebp+$10]
  pop  ebp
  ret  $10
  //Result := B;
 @ElseStart :
  mov  eax,[ebp+$08]
  mov  edx,[ebp+$0c]
end;

function Min_DKC_IA32_3_c(const A, B : Int64) : Int64;
asm
  //if A <= B then
  mov  edx,[ebp+$14]
  cmp  edx,[ebp+$0c]
  jnz  @LowTest
  mov  eax,[ebp+$10]
  cmp  eax,[ebp+$08]
  jnbe @ElseStart
  pop  ebp
  ret  $10
 @LowTest :
  jnle @ElseStart
  //Result := A
  mov  eax,[ebp+$10]
  pop  ebp
  ret  $10
  //Result := B;
 @ElseStart :
  mov  eax,[ebp+$08]
  mov  edx,[ebp+$0c]
end;

function Min_DKC_IA32_3_d(const A, B : Int64) : Int64;
asm
  //if A <= B then
  mov  edx,[ebp+$14]
  cmp  edx,[ebp+$0c]
  jnz  @LowTest
  mov  eax,[ebp+$10]
  cmp  eax,[ebp+$08]
  jnbe @ElseStart
  pop  ebp
  ret  $10
 @LowTest :
  jnle @ElseStart
  //Result := A
  mov  eax,[ebp+$10]
  pop  ebp
  ret  $10
  //Result := B;
 @ElseStart :
  mov  eax,[ebp+$08]
  mov  edx,[ebp+$0c]
end;

//Author:            Dennis Kjaer Christensen
//Date:              1/8 2003
//Instructionset(s): IA32

function Min_DKC_IA32_4_a(const A, B : Int64) : Int64;
asm
  //if A <= B then
  mov  edx,[ebp+$14]
  cmp  edx,[ebp+$0c]
  jnz  @LowTest
  mov  eax,[ebp+$10]
  cmp  eax,[ebp+$08]
  jnbe @ElseStart
  pop  ebp
  ret  $10
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
 @LowTest :
  jnle @ElseStart
  //Result := A
  mov  eax,[ebp+$10]
  pop  ebp
  ret  $10
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  //Result := B;
 @ElseStart :
  mov  eax,[ebp+$08]
  mov  edx,[ebp+$0c]
end;

procedure Filler7;
asm
 nop
end;

function Min_DKC_IA32_4_b(const A, B : Int64) : Int64;
asm
  //if A <= B then
  mov  edx,[ebp+$14]
  cmp  edx,[ebp+$0c]
  jnz  @LowTest
  mov  eax,[ebp+$10]
  cmp  eax,[ebp+$08]
  jnbe @ElseStart
  pop  ebp
  ret  $10
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
 @LowTest :
  jnle @ElseStart
  //Result := A
  mov  eax,[ebp+$10]
  pop  ebp
  ret  $10
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  //Result := B;
 @ElseStart :
  mov  eax,[ebp+$08]
  mov  edx,[ebp+$0c]
end;

procedure Filler8;
asm
 nop
end;

function Min_DKC_IA32_4_c(const A, B : Int64) : Int64;
asm
  //if A <= B then
  mov  edx,[ebp+$14]
  cmp  edx,[ebp+$0c]
  jnz  @LowTest
  mov  eax,[ebp+$10]
  cmp  eax,[ebp+$08]
  jnbe @ElseStart
  pop  ebp
  ret  $10
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
 @LowTest :
  jnle @ElseStart
  //Result := A
  mov  eax,[ebp+$10]
  pop  ebp
  ret  $10
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  //Result := B;
 @ElseStart :
  mov  eax,[ebp+$08]
  mov  edx,[ebp+$0c]
end;

procedure Filler9;
asm
 nop
end;

function Min_DKC_IA32_4_d(const A, B : Int64) : Int64;
asm
  //if A <= B then
  mov  edx,[ebp+$14]
  cmp  edx,[ebp+$0c]
  jnz  @LowTest
  mov  eax,[ebp+$10]
  cmp  eax,[ebp+$08]
  jnbe @ElseStart
  pop  ebp
  ret  $10
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
 @LowTest :
  jnle @ElseStart
  //Result := A
  mov  eax,[ebp+$10]
  pop  ebp
  ret  $10
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  nop
  //Result := B;
 @ElseStart :
  mov  eax,[ebp+$08]
  mov  edx,[ebp+$0c]
end;

//Author:            Dennis Kjaer Christensen
//Date:              20/10 2003
//Instructionset(s): IA32, CMOVcc

function Min_DKC_IA32Ext_1_a(const A, B : Int64) : Int64;
asm
  push  ebx
  //if A <= B then
  mov   eax,[ebp+$08]   //A in edx:eax and Result = A
  mov   edx,[ebp+$0c]
  mov   ecx,[ebp+$10]   //B in ebx:ecx
  mov   ebx,[ebp+$14]
  cmp   edx,ebx         //Compare high parts
  je    @LowTest        //jump if A.High = B.High
  cmovb edx,ebx         //Copy B.High
  cmovb eax,ecx         //Copy B.Low
  jmp   @Exit
@LowTest :
  cmp   eax,ecx         //Compare low parts
  cmova eax,ecx         //Copy B.Low
@Exit :
  pop   ebx
end;

function Min_DKC_IA32Ext_1_b(const A, B : Int64) : Int64;
asm
  push  ebx
  //if A <= B then
  mov   eax,[ebp+$08]   //A in edx:eax and Result = A
  mov   edx,[ebp+$0c]
  mov   ecx,[ebp+$10]   //B in ebx:ecx
  mov   ebx,[ebp+$14]
  cmp   edx,ebx         //Compare high parts
  je    @LowTest        //jump if A.High = B.High
  cmovb edx,ebx         //Copy B.High
  cmovb eax,ecx         //Copy B.Low
  jmp   @Exit
@LowTest :
  cmp   eax,ecx         //Compare low parts
  cmova eax,ecx         //Copy B.Low
@Exit :
  pop   ebx
end;
procedure Filler10;
asm
 nop
end;
function Min_DKC_IA32Ext_1_c(const A, B : Int64) : Int64;
asm
  push  ebx
  //if A <= B then
  mov   eax,[ebp+$08]   //A in edx:eax and Result = A
  mov   edx,[ebp+$0c]
  mov   ecx,[ebp+$10]   //B in ebx:ecx
  mov   ebx,[ebp+$14]
  cmp   edx,ebx         //Compare high parts
  je    @LowTest        //jump if A.High = B.High
  cmovb edx,ebx         //Copy B.High
  cmovb eax,ecx         //Copy B.Low
  jmp   @Exit
@LowTest :
  cmp   eax,ecx         //Compare low parts
  cmova eax,ecx         //Copy B.Low
@Exit :
  pop   ebx
end;

function Min_DKC_IA32Ext_1_d(const A, B : Int64) : Int64;
asm
  push  ebx
  //if A <= B then
  mov   eax,[ebp+$08]   //A in edx:eax and Result = A
  mov   edx,[ebp+$0c]
  mov   ecx,[ebp+$10]   //B in ebx:ecx
  mov   ebx,[ebp+$14]
  cmp   edx,ebx         //Compare high parts
  je    @LowTest        //jump if A.High = B.High
  cmovb edx,ebx         //Copy B.High
  cmovb eax,ecx         //Copy B.Low
  jmp   @Exit
@LowTest :
  cmp   eax,ecx         //Compare low parts
  cmova eax,ecx         //Copy B.Low
@Exit :
  pop   ebx
end;

initialization

 Filler1;
 Filler2;
 Filler3;
 Filler7;
 Filler8;
 Filler9;
 Filler10;
end.
