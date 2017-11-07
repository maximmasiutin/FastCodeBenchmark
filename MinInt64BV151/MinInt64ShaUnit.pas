unit MinInt64ShaUnit;

interface

function Min_SHA_IA32_1_a(const a, b: int64): int64;
function Min_SHA_IA32_1_b(const a, b: int64): int64;
function Min_SHA_IA32_1_c(const a, b: int64): int64;
function Min_SHA_IA32_1_d(const a, b: int64): int64;
function Min_SHA_IA32_2_a(const a, b: int64): int64;
function Min_SHA_IA32_2_b(const a, b: int64): int64;
function Min_SHA_IA32_2_c(const a, b: int64): int64;
function Min_SHA_IA32_2_d(const a, b: int64): int64;

implementation

function Min_SHA_IA32_1_a(const a, b: int64): int64;
asm
  mov eax,[ebp+$08]
  xor ecx,ecx
  mov edx,[ebp+$0C]
  sub eax,[ebp+$10]
  sbb edx,[ebp+$14]
  setge cl
  mov eax,[ebp+8*ecx+$08]
  mov edx,[ebp+8*ecx+$0C]
end;

procedure Filler1;
asm
 nop
end;

function Min_SHA_IA32_1_b(const a, b: int64): int64;
asm
  mov eax,[ebp+$08]
  xor ecx,ecx
  mov edx,[ebp+$0C]
  sub eax,[ebp+$10]
  sbb edx,[ebp+$14]
  setge cl
  mov eax,[ebp+8*ecx+$08]
  mov edx,[ebp+8*ecx+$0C]
end;

procedure Filler2;
asm
 nop
 nop
end;

function Min_SHA_IA32_1_c(const a, b: int64): int64;
asm
  mov eax,[ebp+$08]
  xor ecx,ecx
  mov edx,[ebp+$0C]
  sub eax,[ebp+$10]
  sbb edx,[ebp+$14]
  setge cl
  mov eax,[ebp+8*ecx+$08]
  mov edx,[ebp+8*ecx+$0C]
end;

procedure Filler3;
asm
 nop
 nop
 nop
end;

function Min_SHA_IA32_1_d(const a, b: int64): int64;
asm
  mov eax,[ebp+$08]
  xor ecx,ecx
  mov edx,[ebp+$0C]
  sub eax,[ebp+$10]
  sbb edx,[ebp+$14]
  setge cl
  mov eax,[ebp+8*ecx+$08]
  mov edx,[ebp+8*ecx+$0C]
end;

function Min_SHA_IA32_2_a(const a, b: int64): int64;
asm
  xor ecx,ecx
  mov eax,[ebp+$10]
  mov edx,[ebp+$14]
  sub eax,[ebp+$08]
  sbb edx,[ebp+$0C]
  setge cl
  sub ecx,1
  and eax,ecx
  and edx,ecx
  add eax,[ebp+$08]
  adc edx,[ebp+$0C]
end;

function Min_SHA_IA32_2_b(const a, b: int64): int64;
asm
  xor ecx,ecx
  mov eax,[ebp+$10]
  mov edx,[ebp+$14]
  sub eax,[ebp+$08]
  sbb edx,[ebp+$0C]
  setge cl
  sub ecx,1
  and eax,ecx
  and edx,ecx
  add eax,[ebp+$08]
  adc edx,[ebp+$0C]
end;

procedure Filler4;
asm
 nop
end;

function Min_SHA_IA32_2_c(const a, b: int64): int64;
asm
  xor ecx,ecx
  mov eax,[ebp+$10]
  mov edx,[ebp+$14]
  sub eax,[ebp+$08]
  sbb edx,[ebp+$0C]
  setge cl
  sub ecx,1
  and eax,ecx
  and edx,ecx
  add eax,[ebp+$08]
  adc edx,[ebp+$0C]
end;

function Min_SHA_IA32_2_d(const a, b: int64): int64;
asm
  xor ecx,ecx
  mov eax,[ebp+$10]
  mov edx,[ebp+$14]
  sub eax,[ebp+$08]
  sbb edx,[ebp+$0C]
  setge cl
  sub ecx,1
  and eax,ecx
  and edx,ecx
  add eax,[ebp+$08]
  adc edx,[ebp+$0C]
end;

initialization

 Filler1;
 Filler2;
 Filler3;
 Filler4;

end.
