unit UpperCaseJOHUnit;

interface

function UpperCase_JOH_PAS_1_a (const S: string): string;
function UpperCase_JOH_PAS_1_b (const S: string): string;
function UpperCase_JOH_PAS_1_c (const S: string): string;
function UpperCase_JOH_PAS_1_d (const S: string): string;
function UpperCase_JOH_IA32_0_a (const S: string): string;
function UpperCase_JOH_IA32_0_b (const S: string): string;
function UpperCase_JOH_IA32_0_c (const S: string): string;
function UpperCase_JOH_IA32_0_d (const S: string): string;
function UpperCase_JOH_IA32_1_a(const S: string): string;
function UpperCase_JOH_IA32_1_b(const S: string): string;
function UpperCase_JOH_IA32_1_c(const S: string): string;
function UpperCase_JOH_IA32_1_d(const S: string): string;
function UpperCase_JOH_MMX_1_a (const S: string): string;
function UpperCase_JOH_MMX_1_b (const S: string): string;
function UpperCase_JOH_MMX_1_c (const S: string): string;
function UpperCase_JOH_MMX_1_d (const S: string): string;
function UpperCase_JOH_SSE2_1_a(const S: string): string;
function UpperCase_JOH_SSE2_1_b(const S: string): string;
function UpperCase_JOH_SSE2_1_c(const S: string): string;
function UpperCase_JOH_SSE2_1_d(const S: string): string;
function UpperCase_JOH_IA32_2_a(const S: string): string;
function UpperCase_JOH_IA32_2_b(const S: string): string;
function UpperCase_JOH_IA32_2_c(const S: string): string;
function UpperCase_JOH_IA32_2_d(const S: string): string;

function UpperCase_JOH_SSE_2_a(const S: string): string;
function UpperCase_JOH_SSE_2_b(const S: string): string;
function UpperCase_JOH_SSE_2_c(const S: string): string;
function UpperCase_JOH_SSE_2_d(const S: string): string;
function UpperCase_JOH_SSE2_2_a(const S: string): string;
function UpperCase_JOH_SSE2_2_b(const S: string): string;
function UpperCase_JOH_SSE2_2_c(const S: string): string;
function UpperCase_JOH_SSE2_2_d(const S: string): string;
function UpperCase_JOH_MMX_3_a(const S: string): string;
function UpperCase_JOH_MMX_3_b(const S: string): string;
function UpperCase_JOH_MMX_3_c(const S: string): string;
function UpperCase_JOH_MMX_3_d(const S: string): string;
function UpperCase_JOH_IA32_3_a(const S: string): string;
function UpperCase_JOH_IA32_3_b(const S: string): string;
function UpperCase_JOH_IA32_3_c(const S: string): string;
function UpperCase_JOH_IA32_3_d(const S: string): string;

function UpperCase_JOH_IA32_4_a(const S: string): string;
function UpperCase_JOH_IA32_4_b(const S: string): string;
function UpperCase_JOH_IA32_4_c(const S: string): string;
function UpperCase_JOH_IA32_4_d(const S: string): string;
function UpperCase_JOH_IA32_5_a(const S: string): string;
function UpperCase_JOH_IA32_5_b(const S: string): string;
function UpperCase_JOH_IA32_5_c(const S: string): string;
function UpperCase_JOH_IA32_5_d(const S: string): string;
function UpperCase_JOH_IA32_6_a(const S: string): string;
function UpperCase_JOH_IA32_6_b(const S: string): string;
function UpperCase_JOH_IA32_6_c(const S: string): string;
function UpperCase_JOH_IA32_6_d(const S: string): string;


implementation

uses
  SysUtils;

var
  UppercaseLookUp : array[Char] of Char;

procedure InitializeLookUpTable;
var
  C : Char;
begin
 for C := #0 to #255 do
   UppercaseLookUp[C] := UpCase(C);
end;

function UpperCase_JOH_PAS_1_a(const S: string): string;
var
  Len : Integer;
begin
  Len := Length(S);
  SetLength(Result, Len);
  while Len > 0 do
    begin
      PByteArray(Result)[Len-1] := Byte(UppercaseLookUp[S[Len]]);
      Dec(Len);
    end;
end;

function UpperCase_JOH_PAS_1_b(const S: string): string;
var
  Len : Integer;
begin
  Len := Length(S);
  SetLength(Result, Len);
  while Len > 0 do
    begin
      PByteArray(Result)[Len-1] := Byte(UppercaseLookUp[S[Len]]);
      Dec(Len);
    end;
end;

function UpperCase_JOH_PAS_1_c(const S: string): string;
var
  Len : Integer;
begin
  Len := Length(S);
  SetLength(Result, Len);
  while Len > 0 do
    begin
      PByteArray(Result)[Len-1] := Byte(UppercaseLookUp[S[Len]]);
      Dec(Len);
    end;
end;

function UpperCase_JOH_PAS_1_d(const S: string): string;
var
  Len : Integer;
begin
  Len := Length(S);
  SetLength(Result, Len);
  while Len > 0 do
    begin
      PByteArray(Result)[Len-1] := Byte(UppercaseLookUp[S[Len]]);
      Dec(Len);
    end;
end;

function UpperCase_JOH_IA32_0_a(const S: string): string;
asm {Standalone - No Lookup Table}
  xchg   eax, edx
  test   edx, edx                   {Test for S = ''}
  jz     system.@LStrSetLength      {Reture Empty String}
  mov    ecx, edx                   {Addr(S)}
  mov    edx, [edx-4]               {Length}
  test   edx, edx
  jle    system.@LStrSetLength      {Reture Empty String}
  push   ebx
  push   edi
  push   esi
  mov    ebx, edx                   {Length}
  mov    edi, eax                   {Addr(Result)}
  mov    esi, ecx                   {Addr(S)}
  call   system.@LStrSetLength      {Create Result String}
  mov    edi, [edi]                 {Addr(Result)}
  mov    ecx, 'a' shl 8 + 'z'       {ch = 'a', cl = 'z'}
@@Loop:
  movzx  eax, [esi+ebx]
  cmp    al, ch
  jb     @@CharDone
  cmp    al, cl
  ja     @@CharDone
  sub    al, 'a' - 'A'
@@CharDone:
  mov    [edi+ebx], al
  sub    ebx, 1
  jge    @@Loop
@@Exit:
  pop    esi
  pop    edi
  pop    ebx
end;

procedure Filler7;
asm
 nop
end;

function UpperCase_JOH_IA32_0_b(const S: string): string;
asm {Standalone - No Lookup Table}
  xchg   eax, edx
  test   edx, edx                   {Test for S = ''}
  jz     system.@LStrSetLength      {Reture Empty String}
  mov    ecx, edx                   {Addr(S)}
  mov    edx, [edx-4]               {Length}
  test   edx, edx
  jle    system.@LStrSetLength      {Reture Empty String}
  push   ebx
  push   edi
  push   esi
  mov    ebx, edx                   {Length}
  mov    edi, eax                   {Addr(Result)}
  mov    esi, ecx                   {Addr(S)}
  call   system.@LStrSetLength      {Create Result String}
  mov    edi, [edi]                 {Addr(Result)}
  mov    ecx, 'a' shl 8 + 'z'       {ch = 'a', cl = 'z'}
@@Loop:
  movzx  eax, [esi+ebx]
  cmp    al, ch
  jb     @@CharDone
  cmp    al, cl
  ja     @@CharDone
  sub    al, 'a' - 'A'
@@CharDone:
  mov    [edi+ebx], al
  sub    ebx, 1
  jge    @@Loop
@@Exit:
  pop    esi
  pop    edi
  pop    ebx
end;

procedure Filler8;
asm
 nop
end;

function UpperCase_JOH_IA32_0_c(const S: string): string;
asm {Standalone - No Lookup Table}
  xchg   eax, edx
  test   edx, edx                   {Test for S = ''}
  jz     system.@LStrSetLength      {Reture Empty String}
  mov    ecx, edx                   {Addr(S)}
  mov    edx, [edx-4]               {Length}
  test   edx, edx
  jle    system.@LStrSetLength      {Reture Empty String}
  push   ebx
  push   edi
  push   esi
  mov    ebx, edx                   {Length}
  mov    edi, eax                   {Addr(Result)}
  mov    esi, ecx                   {Addr(S)}
  call   system.@LStrSetLength      {Create Result String}
  mov    edi, [edi]                 {Addr(Result)}
  mov    ecx, 'a' shl 8 + 'z'       {ch = 'a', cl = 'z'}
@@Loop:
  movzx  eax, [esi+ebx]
  cmp    al, ch
  jb     @@CharDone
  cmp    al, cl
  ja     @@CharDone
  sub    al, 'a' - 'A'
@@CharDone:
  mov    [edi+ebx], al
  sub    ebx, 1
  jge    @@Loop
@@Exit:
  pop    esi
  pop    edi
  pop    ebx
end;

procedure Filler9;
asm
 nop
end;

function UpperCase_JOH_IA32_0_d(const S: string): string;
asm {Standalone - No Lookup Table}
  xchg   eax, edx
  test   edx, edx                   {Test for S = ''}
  jz     system.@LStrSetLength      {Reture Empty String}
  mov    ecx, edx                   {Addr(S)}
  mov    edx, [edx-4]               {Length}
  test   edx, edx
  jle    system.@LStrSetLength      {Reture Empty String}
  push   ebx
  push   edi
  push   esi
  mov    ebx, edx                   {Length}
  mov    edi, eax                   {Addr(Result)}
  mov    esi, ecx                   {Addr(S)}
  call   system.@LStrSetLength      {Create Result String}
  mov    edi, [edi]                 {Addr(Result)}
  mov    ecx, 'a' shl 8 + 'z'       {ch = 'a', cl = 'z'}
@@Loop:
  movzx  eax, [esi+ebx]
  cmp    al, ch
  jb     @@CharDone
  cmp    al, cl
  ja     @@CharDone
  sub    al, 'a' - 'A'
@@CharDone:
  mov    [edi+ebx], al
  sub    ebx, 1
  jge    @@Loop
@@Exit:
  pop    esi
  pop    edi
  pop    ebx
end;

function UpperCase_JOH_IA32_1_a(const S: string): string;
asm
  xchg   eax, edx
  test   edx, edx                   {Test for S = ''}
  jz     system.@LStrSetLength      {Return Empty String}
  mov    ecx, edx                   {Addr(S)}
  mov    edx, [edx-4]
  test   edx, edx
  jle    system.@LStrSetLength      {Return Empty String}
  push   ebx
  push   edi
  push   ecx                        {Addr(S)}
  mov    ebx, edx                   {Length}
  mov    edi, eax                   {Addr(Result)}
  call   system.@LStrSetLength      {Create Result String}
  mov    edi, [edi]                 {Addr(Result)}
  pop    edx                        {Addr(S)}
  lea    ecx, UppercaseLookUp       {Addr(UppercaseLookUp)}
@@Loop:
  sub    ebx, 1
  movzx  eax, [edx+ebx]             {Get Next Byte}
  movzx  eax, [ecx+eax]             {Convert to Uppercase}
  mov    [edi+ebx], al              {Save Byte}
  jnz    @@Loop
  pop    edi
  pop    ebx
end;

procedure Filler4;
asm
 nop
 nop
 nop
end;

function UpperCase_JOH_IA32_1_b(const S: string): string;
asm
  xchg   eax, edx
  test   edx, edx                   {Test for S = ''}
  jz     system.@LStrSetLength      {Return Empty String}
  mov    ecx, edx                   {Addr(S)}
  mov    edx, [edx-4]
  test   edx, edx
  jle    system.@LStrSetLength      {Return Empty String}
  push   ebx
  push   edi
  push   ecx                        {Addr(S)}
  mov    ebx, edx                   {Length}
  mov    edi, eax                   {Addr(Result)}
  call   system.@LStrSetLength      {Create Result String}
  mov    edi, [edi]                 {Addr(Result)}
  pop    edx                        {Addr(S)}
  lea    ecx, UppercaseLookUp       {Addr(UppercaseLookUp)}
@@Loop:
  sub    ebx, 1
  movzx  eax, [edx+ebx]             {Get Next Byte}
  movzx  eax, [ecx+eax]             {Convert to Uppercase}
  mov    [edi+ebx], al              {Save Byte}
  jnz    @@Loop
  pop    edi
  pop    ebx
end;

procedure Filler5;
asm
 nop
 nop
 nop
end;

function UpperCase_JOH_IA32_1_c(const S: string): string;
asm
  xchg   eax, edx
  test   edx, edx                   {Test for S = ''}
  jz     system.@LStrSetLength      {Return Empty String}
  mov    ecx, edx                   {Addr(S)}
  mov    edx, [edx-4]
  test   edx, edx
  jle    system.@LStrSetLength      {Return Empty String}
  push   ebx
  push   edi
  push   ecx                        {Addr(S)}
  mov    ebx, edx                   {Length}
  mov    edi, eax                   {Addr(Result)}
  call   system.@LStrSetLength      {Create Result String}
  mov    edi, [edi]                 {Addr(Result)}
  pop    edx                        {Addr(S)}
  lea    ecx, UppercaseLookUp       {Addr(UppercaseLookUp)}
@@Loop:
  sub    ebx, 1
  movzx  eax, [edx+ebx]             {Get Next Byte}
  movzx  eax, [ecx+eax]             {Convert to Uppercase}
  mov    [edi+ebx], al              {Save Byte}
  jnz    @@Loop
  pop    edi
  pop    ebx
end;

procedure Filler3;
asm
 nop
 nop
 nop
end;

function UpperCase_JOH_IA32_1_d(const S: string): string;
asm
  xchg   eax, edx
  test   edx, edx                   {Test for S = ''}
  jz     system.@LStrSetLength      {Return Empty String}
  mov    ecx, edx                   {Addr(S)}
  mov    edx, [edx-4]
  test   edx, edx
  jle    system.@LStrSetLength      {Return Empty String}
  push   ebx
  push   edi
  push   ecx                        {Addr(S)}
  mov    ebx, edx                   {Length}
  mov    edi, eax                   {Addr(Result)}
  call   system.@LStrSetLength      {Create Result String}
  mov    edi, [edi]                 {Addr(Result)}
  pop    edx                        {Addr(S)}
  lea    ecx, UppercaseLookUp       {Addr(UppercaseLookUp)}
@@Loop:
  sub    ebx, 1
  movzx  eax, [edx+ebx]             {Get Next Byte}
  movzx  eax, [ecx+eax]             {Convert to Uppercase}
  mov    [edi+ebx], al              {Save Byte}
  jnz    @@Loop
  pop    edi
  pop    ebx
end;

function UpperCase_JOH_MMX_1_a(const S: string): string;
const
  B05 : Int64 = $0505050505050505;
  B65 : Int64 = $6565656565656565;
  B20 : Int64 = $2020202020202020;
asm
  xchg    eax, edx
  test    edx, edx                   {Test for S = ''}
  jz      system.@LStrSetLength      {Return Empty String}
  mov     ecx, edx                   {Addr(S)}
  mov     edx, [edx-4]
  test    edx, edx
  jle     system.@LStrSetLength      {Return Empty String}
  push    ebx
  push    ecx                        {Addr(S)}
  push    edx                        {Length}
  mov     ebx, eax                   {Addr(Result)}
  call    system.@LStrSetLength      {Create Result String}
  pop     ecx                        {Length}
  pop     eax                        {Addr(S)}
  mov     edx, [ebx]                 {Result}
  cmp     ecx, 16                    {Use Table if Length < 16}
  jl      @@Small
  movq    mm4, B05
  movq    mm5, B65
  movq    mm6, B20
  add     eax, ecx
  add     edx, ecx
  neg     ecx
@@LargeLoop:
  movq    mm0, [eax+ecx  ]
  movq    mm1, [eax+ecx+8]
  movq    mm2, mm0
  movq    mm3, mm1
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edx+ecx  ], mm0
  movq    [edx+ecx+8], mm1
  add     ecx, 16
  and     ecx, -16                   {Prevent Read Past Last Character}
  jnz     @@LargeLoop                {Loop until all Characters Done}
  pop     ebx
  emms
  ret
@@Small:
  push    ebp
  lea     ebp, UppercaseLookUp
@@SmallLoop:
  sub     ecx, 1
  movzx   ebx, [eax+ecx]
  movzx   ebx, [ebp+ebx]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
  pop     ebp
  pop     ebx
end;

function UpperCase_JOH_MMX_1_b(const S: string): string;
const
  B05 : Int64 = $0505050505050505;
  B65 : Int64 = $6565656565656565;
  B20 : Int64 = $2020202020202020;
asm
  xchg    eax, edx
  test    edx, edx                   {Test for S = ''}
  jz      system.@LStrSetLength      {Return Empty String}
  mov     ecx, edx                   {Addr(S)}
  mov     edx, [edx-4]
  test    edx, edx
  jle     system.@LStrSetLength      {Return Empty String}
  push    ebx
  push    ecx                        {Addr(S)}
  push    edx                        {Length}
  mov     ebx, eax                   {Addr(Result)}
  call    system.@LStrSetLength      {Create Result String}
  pop     ecx                        {Length}
  pop     eax                        {Addr(S)}
  mov     edx, [ebx]                 {Result}
  cmp     ecx, 16                    {Use Table if Length < 16}
  jl      @@Small
  movq    mm4, B05
  movq    mm5, B65
  movq    mm6, B20
  add     eax, ecx
  add     edx, ecx
  neg     ecx
@@LargeLoop:
  movq    mm0, [eax+ecx  ]
  movq    mm1, [eax+ecx+8]
  movq    mm2, mm0
  movq    mm3, mm1
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edx+ecx  ], mm0
  movq    [edx+ecx+8], mm1
  add     ecx, 16
  and     ecx, -16                   {Prevent Read Past Last Character}
  jnz     @@LargeLoop                {Loop until all Characters Done}
  pop     ebx
  emms
  ret
@@Small:
  push    ebp
  lea     ebp, UppercaseLookUp
@@SmallLoop:
  sub     ecx, 1
  movzx   ebx, [eax+ecx]
  movzx   ebx, [ebp+ebx]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
  pop     ebp
  pop     ebx
end;

function UpperCase_JOH_MMX_1_c(const S: string): string;
const
  B05 : Int64 = $0505050505050505;
  B65 : Int64 = $6565656565656565;
  B20 : Int64 = $2020202020202020;
asm
  xchg    eax, edx
  test    edx, edx                   {Test for S = ''}
  jz      system.@LStrSetLength      {Return Empty String}
  mov     ecx, edx                   {Addr(S)}
  mov     edx, [edx-4]
  test    edx, edx
  jle     system.@LStrSetLength      {Return Empty String}
  push    ebx
  push    ecx                        {Addr(S)}
  push    edx                        {Length}
  mov     ebx, eax                   {Addr(Result)}
  call    system.@LStrSetLength      {Create Result String}
  pop     ecx                        {Length}
  pop     eax                        {Addr(S)}
  mov     edx, [ebx]                 {Result}
  cmp     ecx, 16                    {Use Table if Length < 16}
  jl      @@Small
  movq    mm4, B05
  movq    mm5, B65
  movq    mm6, B20
  add     eax, ecx
  add     edx, ecx
  neg     ecx
@@LargeLoop:
  movq    mm0, [eax+ecx  ]
  movq    mm1, [eax+ecx+8]
  movq    mm2, mm0
  movq    mm3, mm1
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edx+ecx  ], mm0
  movq    [edx+ecx+8], mm1
  add     ecx, 16
  and     ecx, -16                   {Prevent Read Past Last Character}
  jnz     @@LargeLoop                {Loop until all Characters Done}
  pop     ebx
  emms
  ret
@@Small:
  push    ebp
  lea     ebp, UppercaseLookUp
@@SmallLoop:
  sub     ecx, 1
  movzx   ebx, [eax+ecx]
  movzx   ebx, [ebp+ebx]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
  pop     ebp
  pop     ebx
end;

function UpperCase_JOH_MMX_1_d(const S: string): string;
const
  B05 : Int64 = $0505050505050505;
  B65 : Int64 = $6565656565656565;
  B20 : Int64 = $2020202020202020;
asm
  xchg    eax, edx
  test    edx, edx                   {Test for S = ''}
  jz      system.@LStrSetLength      {Return Empty String}
  mov     ecx, edx                   {Addr(S)}
  mov     edx, [edx-4]
  test    edx, edx
  jle     system.@LStrSetLength      {Return Empty String}
  push    ebx
  push    ecx                        {Addr(S)}
  push    edx                        {Length}
  mov     ebx, eax                   {Addr(Result)}
  call    system.@LStrSetLength      {Create Result String}
  pop     ecx                        {Length}
  pop     eax                        {Addr(S)}
  mov     edx, [ebx]                 {Result}
  cmp     ecx, 16                    {Use Table if Length < 16}
  jl      @@Small
  movq    mm4, B05
  movq    mm5, B65
  movq    mm6, B20
  add     eax, ecx
  add     edx, ecx
  neg     ecx
@@LargeLoop:
  movq    mm0, [eax+ecx  ]
  movq    mm1, [eax+ecx+8]
  movq    mm2, mm0
  movq    mm3, mm1
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edx+ecx  ], mm0
  movq    [edx+ecx+8], mm1
  add     ecx, 16
  and     ecx, -16                   {Prevent Read Past Last Character}
  jnz     @@LargeLoop                {Loop until all Characters Done}
  pop     ebx
  emms
  ret
@@Small:
  push    ebp
  lea     ebp, UppercaseLookUp
@@SmallLoop:
  sub     ecx, 1
  movzx   ebx, [eax+ecx]
  movzx   ebx, [ebp+ebx]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
  pop     ebp
  pop     ebx
end;

function UpperCase_JOH_SSE2_1_a(const S: string): string;
const
  B05 : array[1..2] of Int64 = ($0505050505050505, $0505050505050505);
  B65 : array[1..2] of Int64 = ($6565656565656565, $6565656565656565);
  B20 : array[1..2] of Int64 = ($2020202020202020, $2020202020202020);
asm
  xchg    eax, edx
  test    edx, edx                   {Test for S = ''}
  jz      system.@LStrSetLength      {Return Empty String}
  mov     ecx, edx                   {Addr(S)}
  mov     edx, [edx-4]
  test    edx, edx
  jle     system.@LStrSetLength      {Return Empty String}
  push    ebx
  push    ecx                        {Addr(S)}
  push    edx                        {Length}
  mov     ebx, eax                   {Addr(Result)}
  call    system.@LStrSetLength      {Create Result String}
  pop     ecx                        {Length}
  pop     eax                        {Addr(S)}
  mov     edx, [ebx]                 {Result}
  cmp     ecx, 16
  jl      @@Small
  movdqu  xmm2, B05
  movdqu  xmm3, B65
  movdqu  xmm4, B20
  add     eax, ecx
  add     edx, ecx
  neg     ecx
@@LargeLoop:
  movdqu  xmm0, [eax+ecx]
  movdqu  xmm1, xmm0
  paddb   xmm1, xmm2
  pcmpgtb xmm1, xmm3
  pand    xmm1, xmm4
  psubb   xmm0, xmm1
  movdqu  [edx+ecx], xmm0
  add     ecx, 16
  and     ecx, -16                   {Prevent Read Past Last Character}
  jnz     @@LargeLoop                {Loop until all Characters Done}
  pop     ebx
  ret
@@Small:
  push    ebp
  lea     ebp, UppercaseLookUp
@@SmallLoop:
  sub     ecx, 1
  movzx   ebx, [eax+ecx]
  movzx   ebx, [ebp+ebx]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
  pop     ebp
  pop     ebx
end;

function UpperCase_JOH_SSE2_1_b(const S: string): string;
const
  B05 : array[1..2] of Int64 = ($0505050505050505, $0505050505050505);
  B65 : array[1..2] of Int64 = ($6565656565656565, $6565656565656565);
  B20 : array[1..2] of Int64 = ($2020202020202020, $2020202020202020);
asm
  xchg    eax, edx
  test    edx, edx                   {Test for S = ''}
  jz      system.@LStrSetLength      {Return Empty String}
  mov     ecx, edx                   {Addr(S)}
  mov     edx, [edx-4]
  test    edx, edx
  jle     system.@LStrSetLength      {Return Empty String}
  push    ebx
  push    ecx                        {Addr(S)}
  push    edx                        {Length}
  mov     ebx, eax                   {Addr(Result)}
  call    system.@LStrSetLength      {Create Result String}
  pop     ecx                        {Length}
  pop     eax                        {Addr(S)}
  mov     edx, [ebx]                 {Result}
  cmp     ecx, 16
  jl      @@Small
  movdqu  xmm2, B05
  movdqu  xmm3, B65
  movdqu  xmm4, B20
  add     eax, ecx
  add     edx, ecx
  neg     ecx
@@LargeLoop:
  movdqu  xmm0, [eax+ecx]
  movdqu  xmm1, xmm0
  paddb   xmm1, xmm2
  pcmpgtb xmm1, xmm3
  pand    xmm1, xmm4
  psubb   xmm0, xmm1
  movdqu  [edx+ecx], xmm0
  add     ecx, 16
  and     ecx, -16                   {Prevent Read Past Last Character}
  jnz     @@LargeLoop                {Loop until all Characters Done}
  pop     ebx
  ret
@@Small:
  push    ebp
  lea     ebp, UppercaseLookUp
@@SmallLoop:
  sub     ecx, 1
  movzx   ebx, [eax+ecx]
  movzx   ebx, [ebp+ebx]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
  pop     ebp
  pop     ebx
end;

function UpperCase_JOH_SSE2_1_c(const S: string): string;
const
  B05 : array[1..2] of Int64 = ($0505050505050505, $0505050505050505);
  B65 : array[1..2] of Int64 = ($6565656565656565, $6565656565656565);
  B20 : array[1..2] of Int64 = ($2020202020202020, $2020202020202020);
asm
  xchg    eax, edx
  test    edx, edx                   {Test for S = ''}
  jz      system.@LStrSetLength      {Return Empty String}
  mov     ecx, edx                   {Addr(S)}
  mov     edx, [edx-4]
  test    edx, edx
  jle     system.@LStrSetLength      {Return Empty String}
  push    ebx
  push    ecx                        {Addr(S)}
  push    edx                        {Length}
  mov     ebx, eax                   {Addr(Result)}
  call    system.@LStrSetLength      {Create Result String}
  pop     ecx                        {Length}
  pop     eax                        {Addr(S)}
  mov     edx, [ebx]                 {Result}
  cmp     ecx, 16
  jl      @@Small
  movdqu  xmm2, B05
  movdqu  xmm3, B65
  movdqu  xmm4, B20
  add     eax, ecx
  add     edx, ecx
  neg     ecx
@@LargeLoop:
  movdqu  xmm0, [eax+ecx]
  movdqu  xmm1, xmm0
  paddb   xmm1, xmm2
  pcmpgtb xmm1, xmm3
  pand    xmm1, xmm4
  psubb   xmm0, xmm1
  movdqu  [edx+ecx], xmm0
  add     ecx, 16
  and     ecx, -16                   {Prevent Read Past Last Character}
  jnz     @@LargeLoop                {Loop until all Characters Done}
  pop     ebx
  ret
@@Small:
  push    ebp
  lea     ebp, UppercaseLookUp
@@SmallLoop:
  sub     ecx, 1
  movzx   ebx, [eax+ecx]
  movzx   ebx, [ebp+ebx]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
  pop     ebp
  pop     ebx
end;

function UpperCase_JOH_SSE2_1_d(const S: string): string;
const
  B05 : array[1..2] of Int64 = ($0505050505050505, $0505050505050505);
  B65 : array[1..2] of Int64 = ($6565656565656565, $6565656565656565);
  B20 : array[1..2] of Int64 = ($2020202020202020, $2020202020202020);
asm
  xchg    eax, edx
  test    edx, edx                   {Test for S = ''}
  jz      system.@LStrSetLength      {Return Empty String}
  mov     ecx, edx                   {Addr(S)}
  mov     edx, [edx-4]
  test    edx, edx
  jle     system.@LStrSetLength      {Return Empty String}
  push    ebx
  push    ecx                        {Addr(S)}
  push    edx                        {Length}
  mov     ebx, eax                   {Addr(Result)}
  call    system.@LStrSetLength      {Create Result String}
  pop     ecx                        {Length}
  pop     eax                        {Addr(S)}
  mov     edx, [ebx]                 {Result}
  cmp     ecx, 16
  jl      @@Small
  movdqu  xmm2, B05
  movdqu  xmm3, B65
  movdqu  xmm4, B20
  add     eax, ecx
  add     edx, ecx
  neg     ecx
@@LargeLoop:
  movdqu  xmm0, [eax+ecx]
  movdqu  xmm1, xmm0
  paddb   xmm1, xmm2
  pcmpgtb xmm1, xmm3
  pand    xmm1, xmm4
  psubb   xmm0, xmm1
  movdqu  [edx+ecx], xmm0
  add     ecx, 16
  and     ecx, -16                   {Prevent Read Past Last Character}
  jnz     @@LargeLoop                {Loop until all Characters Done}
  pop     ebx
  ret
@@Small:
  push    ebp
  lea     ebp, UppercaseLookUp
@@SmallLoop:
  sub     ecx, 1
  movzx   ebx, [eax+ecx]
  movzx   ebx, [ebp+ebx]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
  pop     ebp
  pop     ebx
end;


function UpperCase_JOH_IA32_2_a(const S: string): string;
asm {Size = 152 Bytes}
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, $7f7f7f7f         {Note - For Strings of Length 1, 2 or 3,
this}
  mov     edx, eax               {will Read/Write the last 1, 2 or 3 bytes
of }
  not     edx                    {the Length Preaamble, but since these
bytes }
  and     ecx, eax               {will always contain 0's in these cases, 
they}
  and     edx, $80808080         {will never be modified}
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx-4], eax
  sub     ebx, 1
  and     ebx, -4
  jmp     @@CheckDone
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Loop:                          {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx], eax
@@CheckDone:
  sub     ebx, 4
  jnc     @@Loop
  pop     esi
  pop     edi
  pop     ebx
end;

function UpperCase_JOH_IA32_2_b(const S: string): string;
asm {Size = 152 Bytes}
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, $7f7f7f7f         {Note - For Strings of Length 1, 2 or 3,
this}
  mov     edx, eax               {will Read/Write the last 1, 2 or 3 bytes
of }
  not     edx                    {the Length Preaamble, but since these 
bytes }
  and     ecx, eax               {will always contain 0's in these cases, 
they}
  and     edx, $80808080         {will never be modified}
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx-4], eax
  sub     ebx, 1
  and     ebx, -4
  jmp     @@CheckDone
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Loop:                          {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx], eax
@@CheckDone:
  sub     ebx, 4
  jnc     @@Loop
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler2;
asm
 nop
end;

function UpperCase_JOH_IA32_2_c(const S: string): string;
asm {Size = 152 Bytes}
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, $7f7f7f7f         {Note - For Strings of Length 1, 2 or 3,
this}
  mov     edx, eax               {will Read/Write the last 1, 2 or 3 bytes
of }
  not     edx                    {the Length Preaamble, but since these 
bytes }
  and     ecx, eax               {will always contain 0's in these cases, 
they}
  and     edx, $80808080         {will never be modified}
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx-4], eax
  sub     ebx, 1
  and     ebx, -4
  jmp     @@CheckDone
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Loop:                          {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx], eax
@@CheckDone:
  sub     ebx, 4
  jnc     @@Loop
  pop     esi
  pop     edi
  pop     ebx
end;

function UpperCase_JOH_IA32_2_d(const S: string): string;
asm {Size = 152 Bytes}
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, $7f7f7f7f         {Note - For Strings of Length 1, 2 or 3,
this}
  mov     edx, eax               {will Read/Write the last 1, 2 or 3 bytes
of }
  not     edx                    {the Length Preaamble, but since these
bytes }
  and     ecx, eax               {will always contain 0's in these cases, 
they}
  and     edx, $80808080         {will never be modified}
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx-4], eax
  sub     ebx, 1
  and     ebx, -4
  jmp     @@CheckDone
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Loop:                          {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx], eax
@@CheckDone:
  sub     ebx, 4
  jnc     @@Loop
  pop     esi
  pop     edi
  pop     ebx
end;

function UpperCase_JOH_SSE_2_a(const S: string): string;
const
  B05 : Int64 = $0505050505050505;
  B65 : Int64 = $6565656565656565;
  B20 : Int64 = $2020202020202020;
asm
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  cmp     ebx, 32
  jg      @@Large
@@Small:
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, $7f7f7f7f         {Note - For Strings of Length 1, 2 or 3,
this}
  mov     edx, eax               {will Read/Write the last 1, 2 or 3 bytes
of }
  not     edx                    {the Length Preaamble, but since these 
bytes }
  and     ecx, eax               {will always contain 0 in these cases, 
hey  }
  and     edx, $80808080         {will never be modified}
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx-4], eax
  sub     ebx, 1
  and     ebx, -4
  jz      @@Done                 {Exit if Length <= 4}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
@@SmallLoop:                     {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jnz     @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
  ret
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Large:
  movq    mm4, B05
  movq    mm5, B65
  movq    mm6, B20
  movq    mm0, [esi  ]           {Translate First 16 Chars}
  movq    mm1, [esi+8]
  pshufw  mm2, mm0, $E4          {Faster Version of movq mm2, mm0}
  pshufw  mm3, mm1, $E4          {Faster Version of movq mm3, mm1}
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi  ], mm0
  movq    [edi+8], mm1
  sub     ebx, 16
  movq    mm0, [esi+ebx ]        {Translate Last 16 Chars}
  movq    mm1, [esi+ebx+8]
  pshufw  mm2, mm0, $E4          {Faster Version of movq mm2, mm0}
  pshufw  mm3, mm1, $E4          {Faster Version of movq mm3, mm1}
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi+ebx  ], mm0
  movq    [edi+ebx+8], mm1
  mov     ecx, edi               {Align Writes}
  add     esi, ebx
  add     ebx, edi
  and     edi, -16
  sub     ebx, edi
  add     edi, ebx
  sub     ebx, 16
  neg     ebx
@@LargeLoop:
  movq    mm0, [esi+ebx  ]       {Translate Next 16 Chars}
  movq    mm1, [esi+ebx+8]
  pshufw  mm2, mm0, $E4          {Faster Version of movq mm2, mm0}
  pshufw  mm3, mm1, $E4          {Faster Version of movq mm3, mm1}
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi+ebx  ], mm0
  movq    [edi+ebx+8], mm1
  add     ebx, 16
  jl      @@LargeLoop
  emms
  pop     esi
  pop     edi
  pop     ebx
end;

function UpperCase_JOH_SSE_2_b(const S: string): string;
const
  B05 : Int64 = $0505050505050505;
  B65 : Int64 = $6565656565656565;
  B20 : Int64 = $2020202020202020;
asm
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  cmp     ebx, 32
  jg      @@Large
@@Small:
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, $7f7f7f7f         {Note - For Strings of Length 1, 2 or 3, 
this}
  mov     edx, eax               {will Read/Write the last 1, 2 or 3 bytes 
of }
  not     edx                    {the Length Preaamble, but since these 
bytes }
  and     ecx, eax               {will always contain 0 in these cases, 
hey  }
  and     edx, $80808080         {will never be modified}
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx-4], eax
  sub     ebx, 1
  and     ebx, -4
  jz      @@Done                 {Exit if Length <= 4}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
@@SmallLoop:                     {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jnz     @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
  ret
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Large:
  movq    mm4, B05
  movq    mm5, B65
  movq    mm6, B20
  movq    mm0, [esi  ]           {Translate First 16 Chars}
  movq    mm1, [esi+8]
  pshufw  mm2, mm0, $E4          {Faster Version of movq mm2, mm0}
  pshufw  mm3, mm1, $E4          {Faster Version of movq mm3, mm1}
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi  ], mm0
  movq    [edi+8], mm1
  sub     ebx, 16
  movq    mm0, [esi+ebx ]        {Translate Last 16 Chars}
  movq    mm1, [esi+ebx+8]
  pshufw  mm2, mm0, $E4          {Faster Version of movq mm2, mm0}
  pshufw  mm3, mm1, $E4          {Faster Version of movq mm3, mm1}
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi+ebx  ], mm0
  movq    [edi+ebx+8], mm1
  mov     ecx, edi               {Align Writes}
  add     esi, ebx
  add     ebx, edi
  and     edi, -16
  sub     ebx, edi
  add     edi, ebx
  sub     ebx, 16
  neg     ebx
@@LargeLoop:
  movq    mm0, [esi+ebx  ]       {Translate Next 16 Chars}
  movq    mm1, [esi+ebx+8]
  pshufw  mm2, mm0, $E4          {Faster Version of movq mm2, mm0}
  pshufw  mm3, mm1, $E4          {Faster Version of movq mm3, mm1}
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi+ebx  ], mm0
  movq    [edi+ebx+8], mm1
  add     ebx, 16
  jl      @@LargeLoop
  emms
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler1;
asm
 nop
end;

function UpperCase_JOH_SSE_2_c(const S: string): string;
const
  B05 : Int64 = $0505050505050505;
  B65 : Int64 = $6565656565656565;
  B20 : Int64 = $2020202020202020;
asm
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  cmp     ebx, 32
  jg      @@Large
@@Small:
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, $7f7f7f7f         {Note - For Strings of Length 1, 2 or 3, 
this}
  mov     edx, eax               {will Read/Write the last 1, 2 or 3 bytes 
of }
  not     edx                    {the Length Preaamble, but since these 
bytes }
  and     ecx, eax               {will always contain 0 in these cases, 
hey  }
  and     edx, $80808080         {will never be modified}
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx-4], eax
  sub     ebx, 1
  and     ebx, -4
  jz      @@Done                 {Exit if Length <= 4}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
@@SmallLoop:                     {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jnz     @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
  ret
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Large:
  movq    mm4, B05
  movq    mm5, B65
  movq    mm6, B20
  movq    mm0, [esi  ]           {Translate First 16 Chars}
  movq    mm1, [esi+8]
  pshufw  mm2, mm0, $E4          {Faster Version of movq mm2, mm0}
  pshufw  mm3, mm1, $E4          {Faster Version of movq mm3, mm1}
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi  ], mm0
  movq    [edi+8], mm1
  sub     ebx, 16
  movq    mm0, [esi+ebx ]        {Translate Last 16 Chars}
  movq    mm1, [esi+ebx+8]
  pshufw  mm2, mm0, $E4          {Faster Version of movq mm2, mm0}
  pshufw  mm3, mm1, $E4          {Faster Version of movq mm3, mm1}
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi+ebx  ], mm0
  movq    [edi+ebx+8], mm1
  mov     ecx, edi               {Align Writes}
  add     esi, ebx
  add     ebx, edi
  and     edi, -16
  sub     ebx, edi
  add     edi, ebx
  sub     ebx, 16
  neg     ebx
@@LargeLoop:
  movq    mm0, [esi+ebx  ]       {Translate Next 16 Chars}
  movq    mm1, [esi+ebx+8]
  pshufw  mm2, mm0, $E4          {Faster Version of movq mm2, mm0}
  pshufw  mm3, mm1, $E4          {Faster Version of movq mm3, mm1}
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi+ebx  ], mm0
  movq    [edi+ebx+8], mm1
  add     ebx, 16
  jl      @@LargeLoop
  emms
  pop     esi
  pop     edi
  pop     ebx
end;

function UpperCase_JOH_SSE_2_d(const S: string): string;
const
  B05 : Int64 = $0505050505050505;
  B65 : Int64 = $6565656565656565;
  B20 : Int64 = $2020202020202020;
asm
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  cmp     ebx, 32
  jg      @@Large
@@Small:
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, $7f7f7f7f         {Note - For Strings of Length 1, 2 or 3,
this}
  mov     edx, eax               {will Read/Write the last 1, 2 or 3 bytes 
of }
  not     edx                    {the Length Preaamble, but since these 
bytes }
  and     ecx, eax               {will always contain 0 in these cases, 
hey  }
  and     edx, $80808080         {will never be modified}
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx-4], eax
  sub     ebx, 1
  and     ebx, -4
  jz      @@Done                 {Exit if Length <= 4}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
@@SmallLoop:                     {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jnz     @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
  ret
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Large:
  movq    mm4, B05
  movq    mm5, B65
  movq    mm6, B20
  movq    mm0, [esi  ]           {Translate First 16 Chars}
  movq    mm1, [esi+8]
  pshufw  mm2, mm0, $E4          {Faster Version of movq mm2, mm0}
  pshufw  mm3, mm1, $E4          {Faster Version of movq mm3, mm1}
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi  ], mm0
  movq    [edi+8], mm1
  sub     ebx, 16
  movq    mm0, [esi+ebx ]        {Translate Last 16 Chars}
  movq    mm1, [esi+ebx+8]
  pshufw  mm2, mm0, $E4          {Faster Version of movq mm2, mm0}
  pshufw  mm3, mm1, $E4          {Faster Version of movq mm3, mm1}
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi+ebx  ], mm0
  movq    [edi+ebx+8], mm1
  mov     ecx, edi               {Align Writes}
  add     esi, ebx
  add     ebx, edi
  and     edi, -16
  sub     ebx, edi
  add     edi, ebx
  sub     ebx, 16
  neg     ebx
@@LargeLoop:
  movq    mm0, [esi+ebx  ]       {Translate Next 16 Chars}
  movq    mm1, [esi+ebx+8]
  pshufw  mm2, mm0, $E4          {Faster Version of movq mm2, mm0}
  pshufw  mm3, mm1, $E4          {Faster Version of movq mm3, mm1}
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi+ebx  ], mm0
  movq    [edi+ebx+8], mm1
  add     ebx, 16
  jl      @@LargeLoop
  emms
  pop     esi
  pop     edi
  pop     ebx
end;


function UpperCase_JOH_SSE2_2_a(const S: string): string;
const
  B05 : array[1..2] of Int64 = ($0505050505050505, $0505050505050505);
  B65 : array[1..2] of Int64 = ($6565656565656565, $6565656565656565);
  B20 : array[1..2] of Int64 = ($2020202020202020, $2020202020202020);
asm
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  cmp     ebx, 32
  jg      @@Large
@@Small:
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, $7f7f7f7f         {Note - For Strings of Length 1, 2 or 3, 
this}
  mov     edx, eax               {will Read/Write the last 1, 2 or 3 bytes 
of }
  not     edx                    {the Length Preaamble, but since these 
bytes }
  and     ecx, eax               {will always contain 0 in these cases, 
hey  }
  and     edx, $80808080         {will never be modified}
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx-4], eax
  sub     ebx, 1
  and     ebx, -4
  jz      @@Done                 {Exit if Length <= 4}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
@@SmallLoop:                     {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jnz     @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
  ret
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Large:
  movdqu  xmm2, B05
  movdqu  xmm3, B65
  movdqu  xmm4, B20
  movdqu  xmm0, [esi]            {Translate First 16 Chars}
  movdqu  xmm1, xmm0
  paddb   xmm1, xmm2
  pcmpgtb xmm1, xmm3
  pand    xmm1, xmm4
  psubb   xmm0, xmm1
  movdqu  [edi], xmm0
  sub     ebx, 16
  movdqu  xmm0, [esi+ebx]        {Translate Last 16 Chars}
  movdqu  xmm1, xmm0
  paddb   xmm1, xmm2
  pcmpgtb xmm1, xmm3
  pand    xmm1, xmm4
  psubb   xmm0, xmm1
  movdqu  [edi+ebx], xmm0
  mov     ecx, edi               {Align Writes}
  add     esi, ebx
  add     ebx, edi
  and     edi, -16
  sub     ebx, edi
  add     edi, ebx
  sub     ebx, 16
  neg     ebx
@@LargeLoop:
  movdqu  xmm0, [esi+ebx]        {Translate Next 16 Chars}
  movdqa  xmm1, xmm0
  paddb   xmm1, xmm2
  pcmpgtb xmm1, xmm3
  pand    xmm1, xmm4
  psubb   xmm0, xmm1
  movdqa  [edi+ebx], xmm0
  add     ebx, 16
  jl      @@LargeLoop
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler18;
asm
 nop
end;

function UpperCase_JOH_SSE2_2_b(const S: string): string;
const
  B05 : array[1..2] of Int64 = ($0505050505050505, $0505050505050505);
  B65 : array[1..2] of Int64 = ($6565656565656565, $6565656565656565);
  B20 : array[1..2] of Int64 = ($2020202020202020, $2020202020202020);
asm
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  cmp     ebx, 32
  jg      @@Large
@@Small:
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, $7f7f7f7f         {Note - For Strings of Length 1, 2 or 3, 
this}
  mov     edx, eax               {will Read/Write the last 1, 2 or 3 bytes 
of }
  not     edx                    {the Length Preaamble, but since these
bytes }
  and     ecx, eax               {will always contain 0 in these cases, 
hey  }
  and     edx, $80808080         {will never be modified}
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx-4], eax
  sub     ebx, 1
  and     ebx, -4
  jz      @@Done                 {Exit if Length <= 4}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
@@SmallLoop:                     {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jnz     @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
  ret
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Large:
  movdqu  xmm2, B05
  movdqu  xmm3, B65
  movdqu  xmm4, B20
  movdqu  xmm0, [esi]            {Translate First 16 Chars}
  movdqu  xmm1, xmm0
  paddb   xmm1, xmm2
  pcmpgtb xmm1, xmm3
  pand    xmm1, xmm4
  psubb   xmm0, xmm1
  movdqu  [edi], xmm0
  sub     ebx, 16
  movdqu  xmm0, [esi+ebx]        {Translate Last 16 Chars}
  movdqu  xmm1, xmm0
  paddb   xmm1, xmm2
  pcmpgtb xmm1, xmm3
  pand    xmm1, xmm4
  psubb   xmm0, xmm1
  movdqu  [edi+ebx], xmm0
  mov     ecx, edi               {Align Writes}
  add     esi, ebx
  add     ebx, edi
  and     edi, -16
  sub     ebx, edi
  add     edi, ebx
  sub     ebx, 16
  neg     ebx
@@LargeLoop:
  movdqu  xmm0, [esi+ebx]        {Translate Next 16 Chars}
  movdqa  xmm1, xmm0
  paddb   xmm1, xmm2
  pcmpgtb xmm1, xmm3
  pand    xmm1, xmm4
  psubb   xmm0, xmm1
  movdqa  [edi+ebx], xmm0
  add     ebx, 16
  jl      @@LargeLoop
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler17;
asm
 nop
end;


function UpperCase_JOH_SSE2_2_c(const S: string): string;
const
  B05 : array[1..2] of Int64 = ($0505050505050505, $0505050505050505);
  B65 : array[1..2] of Int64 = ($6565656565656565, $6565656565656565);
  B20 : array[1..2] of Int64 = ($2020202020202020, $2020202020202020);
asm
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  cmp     ebx, 32
  jg      @@Large
@@Small:
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, $7f7f7f7f         {Note - For Strings of Length 1, 2 or 3,
this}
  mov     edx, eax               {will Read/Write the last 1, 2 or 3 bytes 
of }
  not     edx                    {the Length Preaamble, but since these 
bytes }
  and     ecx, eax               {will always contain 0 in these cases, 
hey  }
  and     edx, $80808080         {will never be modified}
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx-4], eax
  sub     ebx, 1
  and     ebx, -4
  jz      @@Done                 {Exit if Length <= 4}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
@@SmallLoop:                     {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jnz     @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
  ret
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Large:
  movdqu  xmm2, B05
  movdqu  xmm3, B65
  movdqu  xmm4, B20
  movdqu  xmm0, [esi]            {Translate First 16 Chars}
  movdqu  xmm1, xmm0
  paddb   xmm1, xmm2
  pcmpgtb xmm1, xmm3
  pand    xmm1, xmm4
  psubb   xmm0, xmm1
  movdqu  [edi], xmm0
  sub     ebx, 16
  movdqu  xmm0, [esi+ebx]        {Translate Last 16 Chars}
  movdqu  xmm1, xmm0
  paddb   xmm1, xmm2
  pcmpgtb xmm1, xmm3
  pand    xmm1, xmm4
  psubb   xmm0, xmm1
  movdqu  [edi+ebx], xmm0
  mov     ecx, edi               {Align Writes}
  add     esi, ebx
  add     ebx, edi
  and     edi, -16
  sub     ebx, edi
  add     edi, ebx
  sub     ebx, 16
  neg     ebx
@@LargeLoop:
  movdqu  xmm0, [esi+ebx]        {Translate Next 16 Chars}
  movdqa  xmm1, xmm0
  paddb   xmm1, xmm2
  pcmpgtb xmm1, xmm3
  pand    xmm1, xmm4
  psubb   xmm0, xmm1
  movdqa  [edi+ebx], xmm0
  add     ebx, 16
  jl      @@LargeLoop
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler16;
asm
 nop
end;

function UpperCase_JOH_SSE2_2_d(const S: string): string;
const
  B05 : array[1..2] of Int64 = ($0505050505050505, $0505050505050505);
  B65 : array[1..2] of Int64 = ($6565656565656565, $6565656565656565);
  B20 : array[1..2] of Int64 = ($2020202020202020, $2020202020202020);
asm
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  cmp     ebx, 32
  jg      @@Large
@@Small:
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, $7f7f7f7f         {Note - For Strings of Length 1, 2 or 3, 
this}
  mov     edx, eax               {will Read/Write the last 1, 2 or 3 bytes 
of }
  not     edx                    {the Length Preaamble, but since these 
bytes }
  and     ecx, eax               {will always contain 0 in these cases, 
hey  }
  and     edx, $80808080         {will never be modified}
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx-4], eax
  sub     ebx, 1
  and     ebx, -4
  jz      @@Done                 {Exit if Length <= 4}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
@@SmallLoop:                     {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jnz     @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
  ret
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Large:
  movdqu  xmm2, B05
  movdqu  xmm3, B65
  movdqu  xmm4, B20
  movdqu  xmm0, [esi]            {Translate First 16 Chars}
  movdqu  xmm1, xmm0
  paddb   xmm1, xmm2
  pcmpgtb xmm1, xmm3
  pand    xmm1, xmm4
  psubb   xmm0, xmm1
  movdqu  [edi], xmm0
  sub     ebx, 16
  movdqu  xmm0, [esi+ebx]        {Translate Last 16 Chars}
  movdqu  xmm1, xmm0
  paddb   xmm1, xmm2
  pcmpgtb xmm1, xmm3
  pand    xmm1, xmm4
  psubb   xmm0, xmm1
  movdqu  [edi+ebx], xmm0
  mov     ecx, edi               {Align Writes}
  add     esi, ebx
  add     ebx, edi
  and     edi, -16
  sub     ebx, edi
  add     edi, ebx
  sub     ebx, 16
  neg     ebx
@@LargeLoop:
  movdqu  xmm0, [esi+ebx]        {Translate Next 16 Chars}
  movdqa  xmm1, xmm0
  paddb   xmm1, xmm2
  pcmpgtb xmm1, xmm3
  pand    xmm1, xmm4
  psubb   xmm0, xmm1
  movdqa  [edi+ebx], xmm0
  add     ebx, 16
  jl      @@LargeLoop
  pop     esi
  pop     edi
  pop     ebx
end;


function UpperCase_JOH_MMX_3_a(const S: string): string;
const
  B05 : Int64 = $0505050505050505;
  B65 : Int64 = $6565656565656565;
  B20 : Int64 = $2020202020202020;
asm
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  cmp     ebx, 32
  jg      @@Large
@@Small:
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, $7f7f7f7f         {Note - For Strings of Length 1, 2 or 3, 
this}
  mov     edx, eax               {will Read/Write the last 1, 2 or 3 bytes 
of }
  not     edx                    {the Length Preaamble, but since these 
bytes }
  and     ecx, eax               {will always contain 0 in these cases, 
hey  }
  and     edx, $80808080         {will never be modified}
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx-4], eax
  sub     ebx, 1
  and     ebx, -4
  jz      @@Done                 {Exit if Length <= 4}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
@@SmallLoop:                     {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jnz     @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
  ret
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Large:
  movq    mm4, B05
  movq    mm5, B65
  movq    mm6, B20
  movq    mm0, [esi  ]           {Translate First 16 Chars}
  movq    mm1, [esi+8]
  movq    mm2, mm0
  movq    mm3, mm1
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi  ], mm0
  movq    [edi+8], mm1
  sub     ebx, 16
  movq    mm0, [esi+ebx ]        {Translate Last 16 Chars}
  movq    mm1, [esi+ebx+8]
  movq    mm2, mm0
  movq    mm3, mm1
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi+ebx  ], mm0
  movq    [edi+ebx+8], mm1
  mov     ecx, edi               {Align Writes}
  add     esi, ebx
  add     ebx, edi
  and     edi, -16
  sub     ebx, edi
  add     edi, ebx
  sub     ebx, 16
  neg     ebx
@@LargeLoop:
  movq    mm0, [esi+ebx  ]       {Translate Next 16 Chars}
  movq    mm1, [esi+ebx+8]
  movq    mm2, mm0
  movq    mm3, mm1
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi+ebx  ], mm0
  movq    [edi+ebx+8], mm1
  add     ebx, 16
  jl      @@LargeLoop
  emms
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler15;
asm
 nop
end;


function UpperCase_JOH_MMX_3_b(const S: string): string;
const
  B05 : Int64 = $0505050505050505;
  B65 : Int64 = $6565656565656565;
  B20 : Int64 = $2020202020202020;
asm
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  cmp     ebx, 32
  jg      @@Large
@@Small:
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, $7f7f7f7f         {Note - For Strings of Length 1, 2 or 3, 
this}
  mov     edx, eax               {will Read/Write the last 1, 2 or 3 bytes
of }
  not     edx                    {the Length Preaamble, but since these
bytes }
  and     ecx, eax               {will always contain 0 in these cases, 
hey  }
  and     edx, $80808080         {will never be modified}
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx-4], eax
  sub     ebx, 1
  and     ebx, -4
  jz      @@Done                 {Exit if Length <= 4}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
@@SmallLoop:                     {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jnz     @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
  ret
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Large:
  movq    mm4, B05
  movq    mm5, B65
  movq    mm6, B20
  movq    mm0, [esi  ]           {Translate First 16 Chars}
  movq    mm1, [esi+8]
  movq    mm2, mm0
  movq    mm3, mm1
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi  ], mm0
  movq    [edi+8], mm1
  sub     ebx, 16
  movq    mm0, [esi+ebx ]        {Translate Last 16 Chars}
  movq    mm1, [esi+ebx+8]
  movq    mm2, mm0
  movq    mm3, mm1
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi+ebx  ], mm0
  movq    [edi+ebx+8], mm1
  mov     ecx, edi               {Align Writes}
  add     esi, ebx
  add     ebx, edi
  and     edi, -16
  sub     ebx, edi
  add     edi, ebx
  sub     ebx, 16
  neg     ebx
@@LargeLoop:
  movq    mm0, [esi+ebx  ]       {Translate Next 16 Chars}
  movq    mm1, [esi+ebx+8]
  movq    mm2, mm0
  movq    mm3, mm1
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi+ebx  ], mm0
  movq    [edi+ebx+8], mm1
  add     ebx, 16
  jl      @@LargeLoop
  emms
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler14;
asm
 nop
end;


function UpperCase_JOH_MMX_3_c(const S: string): string;
const
  B05 : Int64 = $0505050505050505;
  B65 : Int64 = $6565656565656565;
  B20 : Int64 = $2020202020202020;
asm
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  cmp     ebx, 32
  jg      @@Large
@@Small:
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, $7f7f7f7f         {Note - For Strings of Length 1, 2 or 3,
this}
  mov     edx, eax               {will Read/Write the last 1, 2 or 3 bytes
of }
  not     edx                    {the Length Preaamble, but since these 
bytes }
  and     ecx, eax               {will always contain 0 in these cases,
hey  }
  and     edx, $80808080         {will never be modified}
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx-4], eax
  sub     ebx, 1
  and     ebx, -4
  jz      @@Done                 {Exit if Length <= 4}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
@@SmallLoop:                     {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jnz     @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
  ret
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Large:
  movq    mm4, B05
  movq    mm5, B65
  movq    mm6, B20
  movq    mm0, [esi  ]           {Translate First 16 Chars}
  movq    mm1, [esi+8]
  movq    mm2, mm0
  movq    mm3, mm1
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi  ], mm0
  movq    [edi+8], mm1
  sub     ebx, 16
  movq    mm0, [esi+ebx ]        {Translate Last 16 Chars}
  movq    mm1, [esi+ebx+8]
  movq    mm2, mm0
  movq    mm3, mm1
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi+ebx  ], mm0
  movq    [edi+ebx+8], mm1
  mov     ecx, edi               {Align Writes}
  add     esi, ebx
  add     ebx, edi
  and     edi, -16
  sub     ebx, edi
  add     edi, ebx
  sub     ebx, 16
  neg     ebx
@@LargeLoop:
  movq    mm0, [esi+ebx  ]       {Translate Next 16 Chars}
  movq    mm1, [esi+ebx+8]
  movq    mm2, mm0
  movq    mm3, mm1
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi+ebx  ], mm0
  movq    [edi+ebx+8], mm1
  add     ebx, 16
  jl      @@LargeLoop
  emms
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler13;
asm
 nop
end;

function UpperCase_JOH_MMX_3_d(const S: string): string;
const
  B05 : Int64 = $0505050505050505;
  B65 : Int64 = $6565656565656565;
  B20 : Int64 = $2020202020202020;
asm
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  cmp     ebx, 32
  jg      @@Large
@@Small:
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, $7f7f7f7f         {Note - For Strings of Length 1, 2 or 3,
this}
  mov     edx, eax               {will Read/Write the last 1, 2 or 3 bytes 
of }
  not     edx                    {the Length Preaamble, but since these 
bytes }
  and     ecx, eax               {will always contain 0 in these cases,
hey  }
  and     edx, $80808080         {will never be modified}
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx-4], eax
  sub     ebx, 1
  and     ebx, -4
  jz      @@Done                 {Exit if Length <= 4}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
@@SmallLoop:                     {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  xor     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jnz     @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
  ret
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Large:
  movq    mm4, B05
  movq    mm5, B65
  movq    mm6, B20
  movq    mm0, [esi  ]           {Translate First 16 Chars}
  movq    mm1, [esi+8]
  movq    mm2, mm0
  movq    mm3, mm1
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi  ], mm0
  movq    [edi+8], mm1
  sub     ebx, 16
  movq    mm0, [esi+ebx ]        {Translate Last 16 Chars}
  movq    mm1, [esi+ebx+8]
  movq    mm2, mm0
  movq    mm3, mm1
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi+ebx  ], mm0
  movq    [edi+ebx+8], mm1
  mov     ecx, edi               {Align Writes}
  add     esi, ebx
  add     ebx, edi
  and     edi, -16
  sub     ebx, edi
  add     edi, ebx
  sub     ebx, 16
  neg     ebx
@@LargeLoop:
  movq    mm0, [esi+ebx  ]       {Translate Next 16 Chars}
  movq    mm1, [esi+ebx+8]
  movq    mm2, mm0
  movq    mm3, mm1
  paddb   mm2, mm4
  paddb   mm3, mm4
  pcmpgtb mm2, mm5
  pcmpgtb mm3, mm5
  pand    mm2, mm6
  pand    mm3, mm6
  psubb   mm0, mm2
  psubb   mm1, mm3
  movq    [edi+ebx  ], mm0
  movq    [edi+ebx+8], mm1
  add     ebx, 16
  jl      @@LargeLoop
  emms
  pop     esi
  pop     edi
  pop     ebx
end;

function UpperCase_JOH_IA32_3_a(const S: string): string;
asm {Size = 125 Bytes}
  push    edi
  push    esi
  push    ebx
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  xor     edx, edx
  test    esi, esi               {Test for S = NIL}
  jz      @@Setlen               {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
@@SetLen:
  lea     ebx, [edx-4]           {Length(S) - 4}
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
  jg      @@Remainder            {Length < 4}
@@LargeLoop:                     {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  sub     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jl      @@largeLoop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'a']
  cmp     edx, 'z'-'a'+1
  sbb     ecx, ecx
  and     ecx, $20
  sub     eax, ecx
  mov     [edi+ebx+4], al
  add     ebx, 1
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;

procedure Filler12;
asm
 nop
end;

function UpperCase_JOH_IA32_3_b(const S: string): string;
asm {Size = 125 Bytes}
  push    edi
  push    esi
  push    ebx
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  xor     edx, edx
  test    esi, esi               {Test for S = NIL}
  jz      @@Setlen               {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
@@SetLen:
  lea     ebx, [edx-4]           {Length(S) - 4}
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
  jg      @@Remainder            {Length < 4}
@@LargeLoop:                     {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  sub     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jl      @@largeLoop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'a']
  cmp     edx, 'z'-'a'+1
  sbb     ecx, ecx
  and     ecx, $20
  sub     eax, ecx
  mov     [edi+ebx+4], al
  add     ebx, 1
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;

procedure Filler11;
asm
 nop
end;

function UpperCase_JOH_IA32_3_c(const S: string): string;
asm {Size = 125 Bytes}
  push    edi
  push    esi
  push    ebx
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  xor     edx, edx
  test    esi, esi               {Test for S = NIL}
  jz      @@Setlen               {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
@@SetLen:
  lea     ebx, [edx-4]           {Length(S) - 4}
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
  jg      @@Remainder            {Length < 4}
@@LargeLoop:                     {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  sub     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jl      @@largeLoop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'a']
  cmp     edx, 'z'-'a'+1
  sbb     ecx, ecx
  and     ecx, $20
  sub     eax, ecx
  mov     [edi+ebx+4], al
  add     ebx, 1
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;

procedure Filler10;
asm
 nop
end;

function UpperCase_JOH_IA32_3_d(const S: string): string;
asm {Size = 125 Bytes}
  push    edi
  push    esi
  push    ebx
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  xor     edx, edx
  test    esi, esi               {Test for S = NIL}
  jz      @@Setlen               {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
@@SetLen:
  lea     ebx, [edx-4]           {Length(S) - 4}
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
  jg      @@Remainder            {Length < 4}
@@LargeLoop:                     {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  sub     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jl      @@largeLoop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'a']
  cmp     edx, 'z'-'a'+1
  sbb     ecx, ecx
  and     ecx, $20
  sub     eax, ecx
  mov     [edi+ebx+4], al
  add     ebx, 1
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;

function UpperCase_JOH_IA32_4_a(const S: string): string;
asm {Size = 125 Bytes}
  push    edi
  push    esi
  push    ebx
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  xor     edx, edx
  test    esi, esi               {Test for S = NIL}
  jz      @@Setlen               {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
@@SetLen:
  lea     ebx, [edx-4]           {Length(S) - 4}
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
  jg      @@Remainder            {Length(S) < 4}
@@Loop:                          {Loop converting 4 Characters per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  sub     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jle     @@Loop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'a']
  cmp     edx, 'z'-'a'+1
  sbb     ecx, ecx
  and     ecx, $20
  sub     eax, ecx
  mov     [edi+ebx+4], al
  add     ebx, 1
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;

procedure Filler4x;
asm
 nop
end;

function UpperCase_JOH_IA32_4_b(const S: string): string;
asm {Size = 125 Bytes}
  push    edi
  push    esi
  push    ebx
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  xor     edx, edx
  test    esi, esi               {Test for S = NIL}
  jz      @@Setlen               {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
@@SetLen:
  lea     ebx, [edx-4]           {Length(S) - 4}
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
  jg      @@Remainder            {Length(S) < 4}
@@Loop:                          {Loop converting 4 Characters per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  sub     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jle     @@Loop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'a']
  cmp     edx, 'z'-'a'+1
  sbb     ecx, ecx
  and     ecx, $20
  sub     eax, ecx
  mov     [edi+ebx+4], al
  add     ebx, 1
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;

procedure Filler4y;
asm
 nop
end;

function UpperCase_JOH_IA32_4_c(const S: string): string;
asm {Size = 125 Bytes}
  push    edi
  push    esi
  push    ebx
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  xor     edx, edx
  test    esi, esi               {Test for S = NIL}
  jz      @@Setlen               {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
@@SetLen:
  lea     ebx, [edx-4]           {Length(S) - 4}
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
  jg      @@Remainder            {Length(S) < 4}
@@Loop:                          {Loop converting 4 Characters per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  sub     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jle     @@Loop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'a']
  cmp     edx, 'z'-'a'+1
  sbb     ecx, ecx
  and     ecx, $20
  sub     eax, ecx
  mov     [edi+ebx+4], al
  add     ebx, 1
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;

procedure Filler4z;
asm
 nop
end;

function UpperCase_JOH_IA32_4_d(const S: string): string;
asm {Size = 125 Bytes}
  push    edi
  push    esi
  push    ebx
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  xor     edx, edx
  test    esi, esi               {Test for S = NIL}
  jz      @@Setlen               {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
@@SetLen:
  lea     ebx, [edx-4]           {Length(S) - 4}
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
  jg      @@Remainder            {Length(S) < 4}
@@Loop:                          {Loop converting 4 Characters per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, $7f7f7f7f
  mov     edx, eax
  not     edx
  and     ecx, eax
  and     edx, $80808080
  add     ecx, $05050505
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  sub     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jle     @@Loop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'a']
  cmp     edx, 'z'-'a'+1
  sbb     ecx, ecx
  and     ecx, $20
  sub     eax, ecx
  mov     [edi+ebx+4], al
  add     ebx, 1
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;

function UpperCase_JOH_IA32_5_a(const S: string): string;
asm {Size = 134 Bytes}
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, eax               {4 Original Bytes}
  or      eax, $80808080         {Set High Bit of each Byte}
  mov     edx, eax               {Comments Below apply to each Byte...}
  sub     eax, $7B7B7B7B         {Set High Bit if Original <= Ord('z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('a')}
  and     eax, edx               {80h if Orig in 'a'..'z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  sub     ecx, eax               {Clear Bit 5 if Original in 'a'..'z'}
  mov     [edi+ebx-4], ecx
  sub     ebx, 1
  and     ebx, -4
  jmp     @@CheckDone
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Loop:                          {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, eax               {4 Original Bytes}
  or      eax, $80808080         {Set High Bit of each Byte}
  mov     edx, eax               {Comments Below apply to each Byte...}
  sub     eax, $7B7B7B7B         {Set High Bit if Original <= Ord('z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('a')}
  and     eax, edx               {80h if Orig in 'a'..'z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  sub     ecx, eax               {Clear Bit 5 if Original in 'a'..'z'}
  mov     [edi+ebx], ecx
@@CheckDone:
  sub     ebx, 4
  jnc     @@Loop
  pop     esi
  pop     edi
  pop     ebx
end;

function UpperCase_JOH_IA32_5_b(const S: string): string;
asm {Size = 134 Bytes}
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, eax               {4 Original Bytes}
  or      eax, $80808080         {Set High Bit of each Byte}
  mov     edx, eax               {Comments Below apply to each Byte...}
  sub     eax, $7B7B7B7B         {Set High Bit if Original <= Ord('z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('a')}
  and     eax, edx               {80h if Orig in 'a'..'z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  sub     ecx, eax               {Clear Bit 5 if Original in 'a'..'z'}
  mov     [edi+ebx-4], ecx
  sub     ebx, 1
  and     ebx, -4
  jmp     @@CheckDone
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Loop:                          {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, eax               {4 Original Bytes}
  or      eax, $80808080         {Set High Bit of each Byte}
  mov     edx, eax               {Comments Below apply to each Byte...}
  sub     eax, $7B7B7B7B         {Set High Bit if Original <= Ord('z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('a')}
  and     eax, edx               {80h if Orig in 'a'..'z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  sub     ecx, eax               {Clear Bit 5 if Original in 'a'..'z'}
  mov     [edi+ebx], ecx
@@CheckDone:
  sub     ebx, 4
  jnc     @@Loop
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler5x;
asm
 nop
end;

function UpperCase_JOH_IA32_5_c(const S: string): string;
asm {Size = 134 Bytes}
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, eax               {4 Original Bytes}
  or      eax, $80808080         {Set High Bit of each Byte}
  mov     edx, eax               {Comments Below apply to each Byte...}
  sub     eax, $7B7B7B7B         {Set High Bit if Original <= Ord('z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('a')}
  and     eax, edx               {80h if Orig in 'a'..'z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  sub     ecx, eax               {Clear Bit 5 if Original in 'a'..'z'}
  mov     [edi+ebx-4], ecx
  sub     ebx, 1
  and     ebx, -4
  jmp     @@CheckDone
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Loop:                          {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, eax               {4 Original Bytes}
  or      eax, $80808080         {Set High Bit of each Byte}
  mov     edx, eax               {Comments Below apply to each Byte...}
  sub     eax, $7B7B7B7B         {Set High Bit if Original <= Ord('z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('a')}
  and     eax, edx               {80h if Orig in 'a'..'z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  sub     ecx, eax               {Clear Bit 5 if Original in 'a'..'z'}
  mov     [edi+ebx], ecx
@@CheckDone:
  sub     ebx, 4
  jnc     @@Loop
  pop     esi
  pop     edi
  pop     ebx
end;

function UpperCase_JOH_IA32_5_d(const S: string): string;
asm {Size = 134 Bytes}
  push    ebx
  push    edi
  push    esi
  test    eax, eax               {Test for S = NIL}
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  jz      @@Null                 {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
  test    edx, edx
  je      @@Null                 {Length(S) = 0}
  mov     ebx, edx
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  mov     eax, [esi+ebx-4]       {Convert the Last 4 Characters of String}
  mov     ecx, eax               {4 Original Bytes}
  or      eax, $80808080         {Set High Bit of each Byte}
  mov     edx, eax               {Comments Below apply to each Byte...}
  sub     eax, $7B7B7B7B         {Set High Bit if Original <= Ord('z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('a')}
  and     eax, edx               {80h if Orig in 'a'..'z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  sub     ecx, eax               {Clear Bit 5 if Original in 'a'..'z'}
  mov     [edi+ebx-4], ecx
  sub     ebx, 1
  and     ebx, -4
  jmp     @@CheckDone
@@Null:
  pop     esi
  pop     edi
  pop     ebx
  jmp     System.@LStrClr
@@Loop:                          {Loop converting 4 Character per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, eax               {4 Original Bytes}
  or      eax, $80808080         {Set High Bit of each Byte}
  mov     edx, eax               {Comments Below apply to each Byte...}
  sub     eax, $7B7B7B7B         {Set High Bit if Original <= Ord('z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('a')}
  and     eax, edx               {80h if Orig in 'a'..'z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  sub     ecx, eax               {Clear Bit 5 if Original in 'a'..'z'}
  mov     [edi+ebx], ecx
@@CheckDone:
  sub     ebx, 4
  jnc     @@Loop
  pop     esi
  pop     edi
  pop     ebx
end;

function UpperCase_JOH_IA32_6_a(const S: string): string;
asm {Size = 114 Bytes}
  push    edi
  push    esi
  push    ebx
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  xor     edx, edx
  test    esi, esi               {Test for S = NIL}
  jz      @@Setlen               {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
@@SetLen:
  lea     ebx, [edx-4]           {Length(S) - 4}
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
  jg      @@Remainder            {Length(S) < 4}
@@Loop:                          {Loop converting 4 Characters per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, eax               {4 Original Bytes}
  or      eax, $80808080         {Set High Bit of each Byte}
  mov     edx, eax               {Comments Below apply to each Byte...}
  sub     eax, $7B7B7B7B         {Set High Bit if Original <= Ord('z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('a')}
  and     eax, edx               {80h if Orig in 'a'..'z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  sub     ecx, eax               {Clear Bit 5 if Original in 'a'..'z'}
  mov     [edi+ebx], ecx
  add     ebx, 4
  jle     @@Loop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'a']
  cmp     edx, 'z'-'a'+1
  sbb     ecx, ecx
  and     ecx, $20
  sub     eax, ecx
  mov     [edi+ebx+4], al
  inc     ebx
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;

function UpperCase_JOH_IA32_6_b(const S: string): string;
asm {Size = 114 Bytes}
  push    edi
  push    esi
  push    ebx
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  xor     edx, edx
  test    esi, esi               {Test for S = NIL}
  jz      @@Setlen               {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
@@SetLen:
  lea     ebx, [edx-4]           {Length(S) - 4}
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
  jg      @@Remainder            {Length(S) < 4}
@@Loop:                          {Loop converting 4 Characters per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, eax               {4 Original Bytes}
  or      eax, $80808080         {Set High Bit of each Byte}
  mov     edx, eax               {Comments Below apply to each Byte...}
  sub     eax, $7B7B7B7B         {Set High Bit if Original <= Ord('z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('a')}
  and     eax, edx               {80h if Orig in 'a'..'z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  sub     ecx, eax               {Clear Bit 5 if Original in 'a'..'z'}
  mov     [edi+ebx], ecx
  add     ebx, 4
  jle     @@Loop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'a']
  cmp     edx, 'z'-'a'+1
  sbb     ecx, ecx
  and     ecx, $20
  sub     eax, ecx
  mov     [edi+ebx+4], al
  inc     ebx
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;

function UpperCase_JOH_IA32_6_c(const S: string): string;
asm {Size = 114 Bytes}
  push    edi
  push    esi
  push    ebx
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  xor     edx, edx
  test    esi, esi               {Test for S = NIL}
  jz      @@Setlen               {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
@@SetLen:
  lea     ebx, [edx-4]           {Length(S) - 4}
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
  jg      @@Remainder            {Length(S) < 4}
@@Loop:                          {Loop converting 4 Characters per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, eax               {4 Original Bytes}
  or      eax, $80808080         {Set High Bit of each Byte}
  mov     edx, eax               {Comments Below apply to each Byte...}
  sub     eax, $7B7B7B7B         {Set High Bit if Original <= Ord('z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('a')}
  and     eax, edx               {80h if Orig in 'a'..'z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  sub     ecx, eax               {Clear Bit 5 if Original in 'a'..'z'}
  mov     [edi+ebx], ecx
  add     ebx, 4
  jle     @@Loop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'a']
  cmp     edx, 'z'-'a'+1
  sbb     ecx, ecx
  and     ecx, $20
  sub     eax, ecx
  mov     [edi+ebx+4], al
  inc     ebx
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;

function UpperCase_JOH_IA32_6_d(const S: string): string;
asm {Size = 114 Bytes}
  push    edi
  push    esi
  push    ebx
  mov     esi, eax               {@S}
  mov     edi, edx               {@Result}
  mov     eax, edx               {@Result}
  xor     edx, edx
  test    esi, esi               {Test for S = NIL}
  jz      @@Setlen               {S = NIL}
  mov     edx, [esi-4]           {Length(S)}
@@SetLen:
  lea     ebx, [edx-4]           {Length(S) - 4}
  call    system.@LStrSetLength  {Create Result String}
  mov     edi, [edi]             {@Result}
  add     esi, ebx
  add     edi, ebx
  neg     ebx
  jg      @@Remainder            {Length(S) < 4}
@@Loop:                          {Loop converting 4 Characters per Loop}
  mov     eax, [esi+ebx]
  mov     ecx, eax               {4 Original Bytes}
  or      eax, $80808080         {Set High Bit of each Byte}
  mov     edx, eax               {Comments Below apply to each Byte...}
  sub     eax, $7B7B7B7B         {Set High Bit if Original <= Ord('z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('a')}
  and     eax, edx               {80h if Orig in 'a'..'z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  sub     ecx, eax               {Clear Bit 5 if Original in 'a'..'z'}
  mov     [edi+ebx], ecx
  add     ebx, 4
  jle     @@Loop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'a']
  cmp     edx, 'z'-'a'+1
  sbb     ecx, ecx
  and     ecx, $20
  sub     eax, ecx
  mov     [edi+ebx+4], al
  inc     ebx
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;


initialization

  InitializeLookUpTable;
  Filler1;
  Filler2;
  Filler3;
  Filler4;
  Filler5;
  Filler7;
  Filler8;
  Filler9;
  Filler10;
  Filler11;
  Filler12;
  Filler13;
  Filler14;
  Filler15;
  Filler16;
  Filler17;
  Filler18;
  Filler4x;
  Filler4y;
  Filler4z;
  Filler5x;

end.

