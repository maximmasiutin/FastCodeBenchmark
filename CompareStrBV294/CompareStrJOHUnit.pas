unit CompareStrJOHUnit;

interface

function CompareStr_JOH_IA32_1_a(const S1, S2: string): Integer;
function CompareStr_JOH_IA32_1_b(const S1, S2: string): Integer;
function CompareStr_JOH_IA32_1_c(const S1, S2: string): Integer;
function CompareStr_JOH_IA32_1_d(const S1, S2: string): Integer;


implementation

function CompareStr_JOH_IA32_1_a(const S1, S2: string): Integer;
asm {102 Bytes}
  cmp     eax, edx
  je      @@Same             {S1 = S2}
  test    eax, edx
  jz      @@CheckNil         {Need to Check for NIL Strings}
@@CompareFirstChar:
  movzx   ecx, [edx]
  cmp     cl, [eax]
  je      @@FirstCharMatches {Match on First Character}
  movzx   eax, [eax]         {Set Result from Character Difference}
  sub     eax, ecx
  ret
@@Same:
  xor     eax, eax
  ret
@@CheckNil:
  test    eax, eax
  jz      @FirstNil          {S1 = NIL}
  test    edx, edx
  jnz     @@CompareFirstChar {S1 <> NIL and S2 <> NIL}
  mov     eax, [eax-4]       {S2 = NIL, Result = Length(S1)}
  ret
@FirstNil:
  sub     eax, [edx-4]       {S1 = NIL, Result = -Length(S2)}
  ret
@@FirstCharMatches:
  push    ebx
  mov     ebx, [eax-4]       {Length(S1)}
  sub     ebx, [edx-4]       {Default Result if All Compared Characters Match}
  push    ebx                {Save Default Result}
  sbb     ecx, ecx
  and     ecx, ebx
  add     ecx, [edx-4]       {Compare Length = Min(Length(S1),Length(S2))}
  add     eax, ecx           {End of S1}
  add     edx, ecx           {End of S2}
  neg     ecx                {Negate Compare Length}
@@MainLoop:                  {Compare 4 Characters per Loop}
  mov     ebx, [eax+ecx]
  xor     ebx, [edx+ecx]
  jnz     @@CheckDiff        {Difference Found}
  add     ecx, 4
  jl      @@MainLoop         {Loop until all required Characters Compared}
  pop     eax                {Default Result}
  jmp     @@Done
@@CheckDiff:
  bsf     ebx, ebx           {Bit Offset of Difference}
  shr     ebx, 3             {Byte Offset of Different Character}
  add     ebx, ecx           {Check Position of Different Character}
  movzx   ecx, [eax+ebx]     {First Different Character}
  pop     eax                {Default Result}
  jg      @@Done             {Position of Difference beyond Compare Length}
  movzx   edx, [edx+ebx]     {Second Different Character}
  mov     eax, ecx           {Set Result from Character Difference}
  sub     eax, edx
@@Done:
  pop     ebx
end;

function CompareStr_JOH_IA32_1_b(const S1, S2: string): Integer;
asm {102 Bytes}
  cmp     eax, edx
  je      @@Same             {S1 = S2}
  test    eax, edx
  jz      @@CheckNil         {Need to Check for NIL Strings}
@@CompareFirstChar:
  movzx   ecx, [edx]
  cmp     cl, [eax]
  je      @@FirstCharMatches {Match on First Character}
  movzx   eax, [eax]         {Set Result from Character Difference}
  sub     eax, ecx
  ret
@@Same:
  xor     eax, eax
  ret
@@CheckNil:
  test    eax, eax
  jz      @FirstNil          {S1 = NIL}
  test    edx, edx
  jnz     @@CompareFirstChar {S1 <> NIL and S2 <> NIL}
  mov     eax, [eax-4]       {S2 = NIL, Result = Length(S1)}
  ret
@FirstNil:
  sub     eax, [edx-4]       {S1 = NIL, Result = -Length(S2)}
  ret
@@FirstCharMatches:
  push    ebx
  mov     ebx, [eax-4]       {Length(S1)}
  sub     ebx, [edx-4]       {Default Result if All Compared Characters Match}
  push    ebx                {Save Default Result}
  sbb     ecx, ecx
  and     ecx, ebx
  add     ecx, [edx-4]       {Compare Length = Min(Length(S1),Length(S2))}
  add     eax, ecx           {End of S1}
  add     edx, ecx           {End of S2}
  neg     ecx                {Negate Compare Length}
@@MainLoop:                  {Compare 4 Characters per Loop}
  mov     ebx, [eax+ecx]
  xor     ebx, [edx+ecx]
  jnz     @@CheckDiff        {Difference Found}
  add     ecx, 4
  jl      @@MainLoop         {Loop until all required Characters Compared}
  pop     eax                {Default Result}
  jmp     @@Done
@@CheckDiff:
  bsf     ebx, ebx           {Bit Offset of Difference}
  shr     ebx, 3             {Byte Offset of Different Character}
  add     ebx, ecx           {Check Position of Different Character}
  movzx   ecx, [eax+ebx]     {First Different Character}
  pop     eax                {Default Result}
  jg      @@Done             {Position of Difference beyond Compare Length}
  movzx   edx, [edx+ebx]     {Second Different Character}
  mov     eax, ecx           {Set Result from Character Difference}
  sub     eax, edx
@@Done:
  pop     ebx
end;

procedure Filler1;
asm
 nop
end;

function CompareStr_JOH_IA32_1_c(const S1, S2: string): Integer;
asm {102 Bytes}
  cmp     eax, edx
  je      @@Same             {S1 = S2}
  test    eax, edx
  jz      @@CheckNil         {Need to Check for NIL Strings}
@@CompareFirstChar:
  movzx   ecx, [edx]
  cmp     cl, [eax]
  je      @@FirstCharMatches {Match on First Character}
  movzx   eax, [eax]         {Set Result from Character Difference}
  sub     eax, ecx
  ret
  @@Same:
  xor     eax, eax
  ret
@@CheckNil:
  test    eax, eax
  jz      @FirstNil          {S1 = NIL}
  test    edx, edx
  jnz     @@CompareFirstChar {S1 <> NIL and S2 <> NIL}
  mov     eax, [eax-4]       {S2 = NIL, Result = Length(S1)}
  ret
@FirstNil:
  sub     eax, [edx-4]       {S1 = NIL, Result = -Length(S2)}
  ret
@@FirstCharMatches:
  push    ebx
  mov     ebx, [eax-4]       {Length(S1)}
  sub     ebx, [edx-4]       {Default Result if All Compared Characters
Match}
  push    ebx                {Save Default Result}
  sbb     ecx, ecx
  and     ecx, ebx
  add     ecx, [edx-4]       {Compare Length = Min(Length(S1),Length(S2))}
  add     eax, ecx           {End of S1}
  add     edx, ecx           {End of S2}
  neg     ecx                {Negate Compare Length}
@@MainLoop:                  {Compare 4 Characters per Loop}
  mov     ebx, [eax+ecx]
  xor     ebx, [edx+ecx]
  jnz     @@CheckDiff        {Difference Found}
  add     ecx, 4
  jl      @@MainLoop         {Loop until all required Characters Compared}
  pop     eax                {Default Result}
  jmp     @@Done
@@CheckDiff:
  bsf     ebx, ebx           {Bit Offset of Difference}
  shr     ebx, 3             {Byte Offset of Different Character}
  add     ebx, ecx           {Check Position of Different Character}
  movzx   ecx, [eax+ebx]     {First Different Character}
  pop     eax                {Default Result}
  jg      @@Done             {Position of Difference beyond Compare Length}
  movzx   edx, [edx+ebx]     {Second Different Character}
  mov     eax, ecx           {Set Result from Character Difference}
  sub     eax, edx
@@Done:
  pop     ebx
end;

function CompareStr_JOH_IA32_1_d(const S1, S2: string): Integer;
asm {102 Bytes}
  cmp     eax, edx
  je      @@Same             {S1 = S2}
  test    eax, edx
  jz      @@CheckNil         {Need to Check for NIL Strings}
@@CompareFirstChar:
  movzx   ecx, [edx]
  cmp     cl, [eax]
  je      @@FirstCharMatches {Match on First Character}
  movzx   eax, [eax]         {Set Result from Character Difference}
  sub     eax, ecx
  ret
  @@Same:
  xor     eax, eax
  ret
@@CheckNil:
  test    eax, eax
  jz      @FirstNil          {S1 = NIL}
  test    edx, edx
  jnz     @@CompareFirstChar {S1 <> NIL and S2 <> NIL}
  mov     eax, [eax-4]       {S2 = NIL, Result = Length(S1)}
  ret
@FirstNil:
  sub     eax, [edx-4]       {S1 = NIL, Result = -Length(S2)}
  ret
@@FirstCharMatches:
  push    ebx
  mov     ebx, [eax-4]       {Length(S1)}
  sub     ebx, [edx-4]       {Default Result if All Compared Characters
Match}
  push    ebx                {Save Default Result}
  sbb     ecx, ecx
  and     ecx, ebx
  add     ecx, [edx-4]       {Compare Length = Min(Length(S1),Length(S2))}
  add     eax, ecx           {End of S1}
  add     edx, ecx           {End of S2}
  neg     ecx                {Negate Compare Length}
@@MainLoop:                  {Compare 4 Characters per Loop}
  mov     ebx, [eax+ecx]
  xor     ebx, [edx+ecx]
  jnz     @@CheckDiff        {Difference Found}
  add     ecx, 4
  jl      @@MainLoop         {Loop until all required Characters Compared}
  pop     eax                {Default Result}
  jmp     @@Done
@@CheckDiff:
  bsf     ebx, ebx           {Bit Offset of Difference}
  shr     ebx, 3             {Byte Offset of Different Character}
  add     ebx, ecx           {Check Position of Different Character}
  movzx   ecx, [eax+ebx]     {First Different Character}
  pop     eax                {Default Result}
  jg      @@Done             {Position of Difference beyond Compare Length}
  movzx   edx, [edx+ebx]     {Second Different Character}
  mov     eax, ecx           {Set Result from Character Difference}
  sub     eax, edx
@@Done:
  pop     ebx
end;


initialization

 Filler1;

end.
