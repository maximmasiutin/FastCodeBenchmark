unit MinInt64JOHUnit;

interface

function Min_JOH_IA32_1_a(const A, B : Int64) : Int64;
function Min_JOH_IA32_1_b(const A, B : Int64) : Int64;
function Min_JOH_IA32_1_c(const A, B : Int64) : Int64;
function Min_JOH_IA32_1_d(const A, B : Int64) : Int64;
function Min_JOH_IA32_2_a(const A, B : Int64) : Int64;
function Min_JOH_IA32_2_b(const A, B : Int64) : Int64;
function Min_JOH_IA32_2_c(const A, B : Int64) : Int64;
function Min_JOH_IA32_2_d(const A, B : Int64) : Int64;

implementation

function Min_JOH_IA32_1_a(const A, B : Int64) : Int64;
asm
  lea  ecx, [ebp+8]
  pop  ebp
  mov  edx, [ecx+12]  {high(A)}
  cmp  edx, [ecx+4]   {high(B)}
  jne  @@CompareHigh
  mov  eax, [ecx+8]   {low(A)}
  cmp  eax, [ecx]     {low(B)}
  ja   @@Swap
  ret  16
@@CompareHigh:
  jg   @@Swap
  mov  eax, [ecx+8]   {EDX:EAX=A}
  ret  16
@@Swap:
  mov  eax, [ecx]
  mov  edx, [ecx+4]   {EDX:EAX=B}
  ret  16
end;

procedure Filler1;
asm
 nop
end;

function Min_JOH_IA32_1_b(const A, B : Int64) : Int64;
asm
  lea  ecx, [ebp+8]
  pop  ebp
  mov  edx, [ecx+12]  {high(A)}
  cmp  edx, [ecx+4]   {high(B)}
  jne  @@CompareHigh
  mov  eax, [ecx+8]   {low(A)}
  cmp  eax, [ecx]     {low(B)}
  ja   @@Swap
  ret  16
@@CompareHigh:
  jg   @@Swap
  mov  eax, [ecx+8]   {EDX:EAX=A}
  ret  16
@@Swap:
  mov  eax, [ecx]
  mov  edx, [ecx+4]   {EDX:EAX=B}
  ret  16
end;

procedure Filler2;
asm
 nop
 nop
end;

function Min_JOH_IA32_1_c(const A, B : Int64) : Int64;
asm
  lea  ecx, [ebp+8]
  pop  ebp
  mov  edx, [ecx+12]  {high(A)}
  cmp  edx, [ecx+4]   {high(B)}
  jne  @@CompareHigh
  mov  eax, [ecx+8]   {low(A)}
  cmp  eax, [ecx]     {low(B)}
  ja   @@Swap
  ret  16
@@CompareHigh:
  jg   @@Swap
  mov  eax, [ecx+8]   {EDX:EAX=A}
  ret  16
@@Swap:
  mov  eax, [ecx]
  mov  edx, [ecx+4]   {EDX:EAX=B}
  ret  16
end;

procedure Filler3;
asm
 nop
 nop
 nop
end;

function Min_JOH_IA32_1_d(const A, B : Int64) : Int64;
asm
  lea  ecx, [ebp+8]
  pop  ebp
  mov  edx, [ecx+12]  {high(A)}
  cmp  edx, [ecx+4]   {high(B)}
  jne  @@CompareHigh
  mov  eax, [ecx+8]   {low(A)}
  cmp  eax, [ecx]     {low(B)}
  ja   @@Swap
  ret  16
@@CompareHigh:
  jg   @@Swap
  mov  eax, [ecx+8]   {EDX:EAX=A}
  ret  16
@@Swap:
  mov  eax, [ecx]
  mov  edx, [ecx+4]   {EDX:EAX=B}
  ret  16
end;

function Min_JOH_IA32_2_a(const A, B : Int64) : Int64;
asm
  xor   ecx, ecx
  mov   eax, [ebp+20]   {high(A)}
  cmp   eax, [ebp+12]   {high(B)}
  jne   @@CompareHigh
  mov   eax, [ebp+16]   {low(A)}
  cmp   eax, [ebp+8]    {low(B)}
  setna cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
  pop   ebp
  ret   16
@@CompareHigh:
  setng cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
end;

function Min_JOH_IA32_2_b(const A, B : Int64) : Int64;
asm
  xor   ecx, ecx
  mov   eax, [ebp+20]   {high(A)}
  cmp   eax, [ebp+12]   {high(B)}
  jne   @@CompareHigh
  mov   eax, [ebp+16]   {low(A)}
  cmp   eax, [ebp+8]    {low(B)}
  setna cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
  pop   ebp
  ret   16
@@CompareHigh:
  setng cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
end;

function Min_JOH_IA32_2_c(const A, B : Int64) : Int64;
asm
  xor   ecx, ecx
  mov   eax, [ebp+20]   {high(A)}
  cmp   eax, [ebp+12]   {high(B)}
  jne   @@CompareHigh
  mov   eax, [ebp+16]   {low(A)}
  cmp   eax, [ebp+8]    {low(B)}
  setna cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
  pop   ebp
  ret   16
@@CompareHigh:
  setng cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
end;

function Min_JOH_IA32_2_d(const A, B : Int64) : Int64;
asm
  xor   ecx, ecx
  mov   eax, [ebp+20]   {high(A)}
  cmp   eax, [ebp+12]   {high(B)}
  jne   @@CompareHigh
  mov   eax, [ebp+16]   {low(A)}
  cmp   eax, [ebp+8]    {low(B)}
  setna cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
  pop   ebp
  ret   16
@@CompareHigh:
  setng cl
  mov   eax, [ebp+ecx*8+8]
  mov   edx, [ebp+ecx*8+12]
end;

initialization

 Filler1;
 Filler2;
 Filler3;

end.
