unit CompareMemJOHUnit;

interface                          

function CompareMem_JOH_IA32_1_a(P1, P2: pointer; Length: integer): boolean;
function CompareMem_JOH_IA32_1_b(P1, P2: pointer; Length: integer): boolean;
function CompareMem_JOH_IA32_1_c(P1, P2: pointer; Length: integer): boolean;
function CompareMem_JOH_IA32_1_d(P1, P2: pointer; Length: integer): boolean;

implementation                       

function CompareMem_JOH_IA32_1_a(P1, P2: pointer; Length: integer): boolean;
asm
  push  ebx
  sub   ecx, 8
  jl    @@Small
  mov   ebx, [eax]         {Compare First 4 Bytes}
  cmp   ebx, [edx]
  jne   @@False
  lea   ebx, [eax+ecx]     {Compare Last 8 Bytes}
  add   edx, ecx
  mov   eax, [ebx]
  cmp   eax, [edx]
  jne   @@False
  mov   eax, [ebx+4]
  cmp   eax, [edx+4]
  jne   @@False
  sub   ecx, 4
  jle   @@True             {All Bytes already Compared}
  neg   ecx                {-(Length-12)}
  add   ecx, ebx           {DWORD Align Reads}
  and   ecx, -4
  sub   ecx, ebx
@@LargeLoop:               {Compare 8 Bytes per Loop}
  mov   eax, [ebx+ecx]
  cmp   eax, [edx+ecx]
  jne   @@False
  mov   eax, [ebx+ecx+4]
  cmp   eax, [edx+ecx+4]
  jne   @@False
  add   ecx, 8
  jl    @@LargeLoop
@@True:
  mov   eax, 1
  pop   ebx
  ret
@@Small:
  add   ecx, 8
  jle   @@True             {Length <= 0}
@@SmallLoop:
  mov   bl, [eax]
  cmp   bl, [edx]
  jne   @@False
  inc   eax
  inc   edx
  dec   ecx
  jnz   @@SmallLoop
  jmp   @@True
@@False:
  xor   eax, eax
  pop   ebx
end;

function CompareMem_JOH_IA32_1_b(P1, P2: pointer; Length: integer): boolean;
asm
  push  ebx
  sub   ecx, 8
  jl    @@Small
  mov   ebx, [eax]         {Compare First 4 Bytes}
  cmp   ebx, [edx]
  jne   @@False
  lea   ebx, [eax+ecx]     {Compare Last 8 Bytes}
  add   edx, ecx
  mov   eax, [ebx]
  cmp   eax, [edx]
  jne   @@False
  mov   eax, [ebx+4]
  cmp   eax, [edx+4]
  jne   @@False
  sub   ecx, 4
  jle   @@True             {All Bytes already Compared}
  neg   ecx                {-(Length-12)}
  add   ecx, ebx           {DWORD Align Reads}
  and   ecx, -4
  sub   ecx, ebx
@@LargeLoop:               {Compare 8 Bytes per Loop}
  mov   eax, [ebx+ecx]
  cmp   eax, [edx+ecx]
  jne   @@False
  mov   eax, [ebx+ecx+4]
  cmp   eax, [edx+ecx+4]
  jne   @@False
  add   ecx, 8
  jl    @@LargeLoop
@@True:
  mov   eax, 1
  pop   ebx
  ret
@@Small:
  add   ecx, 8
  jle   @@True             {Length <= 0}
@@SmallLoop:
  mov   bl, [eax]
  cmp   bl, [edx]
  jne   @@False
  inc   eax
  inc   edx
  dec   ecx
  jnz   @@SmallLoop
  jmp   @@True
@@False:
  xor   eax, eax
  pop   ebx
end;

function CompareMem_JOH_IA32_1_c(P1, P2: pointer; Length: integer): boolean;
asm
  push  ebx
  sub   ecx, 8
  jl    @@Small
  mov   ebx, [eax]         {Compare First 4 Bytes}
  cmp   ebx, [edx]
  jne   @@False
  lea   ebx, [eax+ecx]     {Compare Last 8 Bytes}
  add   edx, ecx
  mov   eax, [ebx]
  cmp   eax, [edx]
  jne   @@False
  mov   eax, [ebx+4]
  cmp   eax, [edx+4]
  jne   @@False
  sub   ecx, 4
  jle   @@True             {All Bytes already Compared}
  neg   ecx                {-(Length-12)}
  add   ecx, ebx           {DWORD Align Reads}
  and   ecx, -4
  sub   ecx, ebx
@@LargeLoop:               {Compare 8 Bytes per Loop}
  mov   eax, [ebx+ecx]
  cmp   eax, [edx+ecx]
  jne   @@False
  mov   eax, [ebx+ecx+4]
  cmp   eax, [edx+ecx+4]
  jne   @@False
  add   ecx, 8
  jl    @@LargeLoop
@@True:
  mov   eax, 1
  pop   ebx
  ret
@@Small:
  add   ecx, 8
  jle   @@True             {Length <= 0}
@@SmallLoop:
  mov   bl, [eax]
  cmp   bl, [edx]
  jne   @@False
  inc   eax
  inc   edx
  dec   ecx
  jnz   @@SmallLoop
  jmp   @@True
@@False:
  xor   eax, eax
  pop   ebx
end;

function CompareMem_JOH_IA32_1_d(P1, P2: pointer; Length: integer): boolean;
asm
  push  ebx
  sub   ecx, 8
  jl    @@Small
  mov   ebx, [eax]         {Compare First 4 Bytes}
  cmp   ebx, [edx]
  jne   @@False
  lea   ebx, [eax+ecx]     {Compare Last 8 Bytes}
  add   edx, ecx
  mov   eax, [ebx]
  cmp   eax, [edx]
  jne   @@False
  mov   eax, [ebx+4]
  cmp   eax, [edx+4]
  jne   @@False
  sub   ecx, 4
  jle   @@True             {All Bytes already Compared}
  neg   ecx                {-(Length-12)}
  add   ecx, ebx           {DWORD Align Reads}
  and   ecx, -4
  sub   ecx, ebx
@@LargeLoop:               {Compare 8 Bytes per Loop}
  mov   eax, [ebx+ecx]
  cmp   eax, [edx+ecx]
  jne   @@False
  mov   eax, [ebx+ecx+4]
  cmp   eax, [edx+ecx+4]
  jne   @@False
  add   ecx, 8
  jl    @@LargeLoop
@@True:
  mov   eax, 1
  pop   ebx
  ret
@@Small:
  add   ecx, 8
  jle   @@True             {Length <= 0}
@@SmallLoop:
  mov   bl, [eax]
  cmp   bl, [edx]
  jne   @@False
  inc   eax
  inc   edx
  dec   ecx
  jnz   @@SmallLoop
  jmp   @@True
@@False:
  xor   eax, eax
  pop   ebx
end;

end.
