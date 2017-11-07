unit MaxInt64DKCUnit;

interface

function MaxDKCPas_a(const A, B : Int64) : Int64;
function MaxDKCPas_b(const A, B : Int64) : Int64;
function MaxDKCPas_c(const A, B : Int64) : Int64;
function MaxDKCPas_d(const A, B : Int64) : Int64;
function MaxDKCAsmIA32_a(const A, B : Int64) : Int64;
function MaxDKCAsmIA32_b(const A, B : Int64) : Int64;
function MaxDKCAsmIA32_c(const A, B : Int64) : Int64;
function MaxDKCAsmIA32_d(const A, B : Int64) : Int64;

implementation

//Author:            Dennis Kjaer Christensen
//Date:              2/10 2003
//Optimized for:     Blended
//Instructionset(s): IA32

function MaxDKCPas_a(const A, B : Int64) : Int64;
begin
 if A >= B then
  Result := A
 else
  Result := B;
end;

procedure Filler1;
asm
 nop
end;

function MaxDKCPas_b(const A, B : Int64) : Int64;
begin
 if A >= B then
  Result := A
 else
  Result := B;
end;

procedure Filler2;
asm
 nop
end;

function MaxDKCPas_c(const A, B : Int64) : Int64;
begin
 if A >= B then
  Result := A
 else
  Result := B;
end;

procedure Filler3;
asm
 nop
end;

function MaxDKCPas_d(const A, B : Int64) : Int64;
begin
 if A >= B then
  Result := A
 else
  Result := B;
end;

function MaxDKCAsmIA32_a(const A, B : Int64) : Int64;
asm
  //if A <= B then
  mov  edx,[ebp+$14]
  cmp  edx,[ebp+$0c]
  jnz  @LowTest
  mov  eax,[ebp+$10]
  cmp  eax,[ebp+$08]
  jbe  @ElseStart
  pop  ebp
  ret  $10
 @LowTest :
  jle  @ElseStart
  //Result := A
  mov  eax,[ebp+$10]
  pop  ebp
  ret  $10
  //Result := B;
 @ElseStart :
  mov  eax,[ebp+$08]
  mov  edx,[ebp+$0c]
end;

function MaxDKCAsmIA32_b(const A, B : Int64) : Int64;
asm
  //if A <= B then
  mov  edx,[ebp+$14]
  cmp  edx,[ebp+$0c]
  jnz  @LowTest
  mov  eax,[ebp+$10]
  cmp  eax,[ebp+$08]
  jbe  @ElseStart
  pop  ebp
  ret  $10
 @LowTest :
  jle  @ElseStart
  //Result := A
  mov  eax,[ebp+$10]
  pop  ebp
  ret  $10
  //Result := B;
 @ElseStart :
  mov  eax,[ebp+$08]
  mov  edx,[ebp+$0c]
end;

function MaxDKCAsmIA32_c(const A, B : Int64) : Int64;
asm
  //if A <= B then
  mov  edx,[ebp+$14]
  cmp  edx,[ebp+$0c]
  jnz  @LowTest
  mov  eax,[ebp+$10]
  cmp  eax,[ebp+$08]
  jbe  @ElseStart
  pop  ebp
  ret  $10
 @LowTest :
  jle  @ElseStart
  //Result := A
  mov  eax,[ebp+$10]
  pop  ebp
  ret  $10
  //Result := B;
 @ElseStart :
  mov  eax,[ebp+$08]
  mov  edx,[ebp+$0c]
end;

function MaxDKCAsmIA32_d(const A, B : Int64) : Int64;
asm
  //if A <= B then
  mov  edx,[ebp+$14]
  cmp  edx,[ebp+$0c]
  jnz  @LowTest
  mov  eax,[ebp+$10]
  cmp  eax,[ebp+$08]
  jbe  @ElseStart
  pop  ebp
  ret  $10
 @LowTest :
  jle  @ElseStart
  //Result := A
  mov  eax,[ebp+$10]
  pop  ebp
  ret  $10
  //Result := B;
 @ElseStart :
  mov  eax,[ebp+$08]
  mov  edx,[ebp+$0c]
end;

initialization
 Filler1;
 Filler2;
 Filler3;

end.
