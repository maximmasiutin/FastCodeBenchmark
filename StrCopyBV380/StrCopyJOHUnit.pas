unit StrCopyJOHUnit;

interface

function StrCopy_JOH_PAS_4_a(Dest: PChar; const Source: PChar): PChar; inline;
function StrCopy_JOH_PAS_4_b(Dest: PChar; const Source: PChar): PChar; inline;
function StrCopy_JOH_PAS_4_c(Dest: PChar; const Source: PChar): PChar; inline;
function StrCopy_JOH_PAS_4_d(Dest: PChar; const Source: PChar): PChar; inline;

function StrCopy_JOH_IA32_6_a(Dest: PChar; const Source: PChar): PChar;
function StrCopy_JOH_IA32_6_b(Dest: PChar; const Source: PChar): PChar;
function StrCopy_JOH_IA32_6_c(Dest: PChar; const Source: PChar): PChar;
function StrCopy_JOH_IA32_6_d(Dest: PChar; const Source: PChar): PChar;

function StrCopy_JOH_IA32_7_a(Dest: PChar; const Source: PChar): PChar;
function StrCopy_JOH_IA32_7_b(Dest: PChar; const Source: PChar): PChar;
function StrCopy_JOH_IA32_7_c(Dest: PChar; const Source: PChar): PChar;
function StrCopy_JOH_IA32_7_d(Dest: PChar; const Source: PChar): PChar;

function StrCopy_JOH_IA32_8_a(Dest: PChar; const Source: PChar): PChar;
function StrCopy_JOH_IA32_8_b(Dest: PChar; const Source: PChar): PChar;
function StrCopy_JOH_IA32_8_c(Dest: PChar; const Source: PChar): PChar;
function StrCopy_JOH_IA32_8_d(Dest: PChar; const Source: PChar): PChar;

function StrCopy_JOH_IA32_9_a(Dest: PChar; const Source: PChar): PChar;
function StrCopy_JOH_IA32_9_b(Dest: PChar; const Source: PChar): PChar;
function StrCopy_JOH_IA32_9_c(Dest: PChar; const Source: PChar): PChar;
function StrCopy_JOH_IA32_9_d(Dest: PChar; const Source: PChar): PChar;

function StrCopy_JOH_MMX_1_a(Dest: PChar; const Source: PChar): PChar;
function StrCopy_JOH_MMX_1_b(Dest: PChar; const Source: PChar): PChar;
function StrCopy_JOH_MMX_1_c(Dest: PChar; const Source: PChar): PChar;
function StrCopy_JOH_MMX_1_d(Dest: PChar; const Source: PChar): PChar;

implementation

uses
 SysUtils;

function StrCopy_JOH_PAS_4_a(Dest: PChar; const Source: PChar): PChar; inline;
var
  Src, Dst: PByte;
  I, J, K: Integer;
begin
  Result := Dest;
  Src := Pointer(Source);
  Dst := Pointer(Dest);
  if LongWord(Integer(Src) - Integer(Dst)) >= 4 then
    begin
      repeat
        Dst^ := Src^;
        if Dst^ = 0 then Exit;
        Inc(Dst);
        Inc(Src);
      until (Integer(Src) and 3) = 0;
      repeat
        I := PInteger(Src)^;
        K := I;
        J := I - $01010101;
        I := not(I);
        I := I and J;
        if (I and $80808080) <> 0 then
          Break;
        PInteger(Dst)^ := K;
        Inc(Dst, 4);
        Inc(Src, 4);
      until False;
   end;
  repeat
    Dst^ := Src^;
    if Dst^ = 0 then Exit;
    Inc(Dst);
    Inc(Src);
  until False;
end;


function StrCopy_JOH_PAS_4_b(Dest: PChar; const Source: PChar): PChar; inline;
var
  Src, Dst: PByte;
  I, J, K: Integer;
begin
  Result := Dest;
  Src := Pointer(Source);
  Dst := Pointer(Dest);
  if LongWord(Integer(Src) - Integer(Dst)) >= 4 then
    begin
      repeat
        Dst^ := Src^;
        if Dst^ = 0 then Exit;
        Inc(Dst);
        Inc(Src);
      until (Integer(Src) and 3) = 0;
      repeat
        I := PInteger(Src)^;
        K := I;
        J := I - $01010101;
        I := not(I);
        I := I and J;
        if (I and $80808080) <> 0 then
          Break;
        PInteger(Dst)^ := K;
        Inc(Dst, 4);
        Inc(Src, 4);
      until False;
   end;
  repeat
    Dst^ := Src^;
    if Dst^ = 0 then Exit;
    Inc(Dst);
    Inc(Src);
  until False;
end;


function StrCopy_JOH_PAS_4_c(Dest: PChar; const Source: PChar): PChar; inline;
var
  Src, Dst: PByte;
  I, J, K: Integer;
begin
  Result := Dest;
  Src := Pointer(Source);
  Dst := Pointer(Dest);
  if LongWord(Integer(Src) - Integer(Dst)) >= 4 then
    begin
      repeat
        Dst^ := Src^;
        if Dst^ = 0 then Exit;
        Inc(Dst);
        Inc(Src);
      until (Integer(Src) and 3) = 0;
      repeat
        I := PInteger(Src)^;
        K := I;
        J := I - $01010101;
        I := not(I);
        I := I and J;
        if (I and $80808080) <> 0 then
          Break;
        PInteger(Dst)^ := K;
        Inc(Dst, 4);
        Inc(Src, 4);
      until False;
   end;
  repeat
    Dst^ := Src^;
    if Dst^ = 0 then Exit;
    Inc(Dst);
    Inc(Src);
  until False;
end;


function StrCopy_JOH_PAS_4_d(Dest: PChar; const Source: PChar): PChar; inline;
var
  Src, Dst: PByte;
  I, J, K: Integer;
begin
  Result := Dest;
  Src := Pointer(Source);
  Dst := Pointer(Dest);
  if LongWord(Integer(Src) - Integer(Dst)) >= 4 then
    begin
      repeat
        Dst^ := Src^;
        if Dst^ = 0 then Exit;
        Inc(Dst);
        Inc(Src);
      until (Integer(Src) and 3) = 0;
      repeat
        I := PInteger(Src)^;
        K := I;
        J := I - $01010101;
        I := not(I);
        I := I and J;
        if (I and $80808080) <> 0 then
          Break;
        PInteger(Dst)^ := K;
        Inc(Dst, 4);
        Inc(Src, 4);
      until False;
   end;
  repeat
    Dst^ := Src^;
    if Dst^ = 0 then Exit;
    Inc(Dst);
    Inc(Src);
  until False;
end;


function StrCopy_JOH_IA32_6_a(Dest: PChar; const Source: PChar): PChar;
asm {Size = 109 Bytes}
  push  eax
@@Next4:
  movzx ecx, [edx]
  mov   [eax], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+1]
  mov   [eax+1], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+3]
  mov   [eax+3], cl
  test  cl, cl
  jz    @@Done
  mov   ecx, edx
  sub   ecx, eax
  cmp   ecx, 4
  jb    @@Overlap
  mov   ecx, edx             {DWORD Align Reads}
  and   edx, -4
  sub   ecx, edx
  sub   eax, ecx
  push  ebx
  push  edi
@@Loop:
  add   edx, 4               {4 Chars per Loop}
  add   eax, 4
  mov   ecx, [edx]
  mov   edi, ecx
  lea   ebx, [ecx-$01010101]
  not   ecx
  and   ecx, ebx
  test  ecx, $80808080       {Set Byte to $80 at each #0 Position}
  jnz   @@Remainder
  mov   [eax], edi
  jmp   @@Loop               {Loop until any #0 Found}
@@Overlap:
  add   eax, 4               {Source/Dest Overlap}
  add   edx, 4
  jmp   @@Next4
@@Remainder:
  pop   edi
  pop   ebx
  jmp   @@Next4
@@Done:
  pop   eax
end;

procedure Filler1;
asm
 nop
end;

function StrCopy_JOH_IA32_6_b(Dest: PChar; const Source: PChar): PChar;
asm {Size = 109 Bytes}
  push  eax
@@Next4:
  movzx ecx, [edx]
  mov   [eax], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+1]
  mov   [eax+1], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+3]
  mov   [eax+3], cl
  test  cl, cl
  jz    @@Done
  mov   ecx, edx
  sub   ecx, eax
  cmp   ecx, 4
  jb    @@Overlap
  mov   ecx, edx             {DWORD Align Reads}
  and   edx, -4
  sub   ecx, edx
  sub   eax, ecx
  push  ebx
  push  edi
@@Loop:
  add   edx, 4               {4 Chars per Loop}
  add   eax, 4
  mov   ecx, [edx]
  mov   edi, ecx
  lea   ebx, [ecx-$01010101]
  not   ecx
  and   ecx, ebx
  test  ecx, $80808080       {Set Byte to $80 at each #0 Position}
  jnz   @@Remainder
  mov   [eax], edi
  jmp   @@Loop               {Loop until any #0 Found}
@@Overlap:
  add   eax, 4               {Source/Dest Overlap}
  add   edx, 4
  jmp   @@Next4
@@Remainder:
  pop   edi
  pop   ebx
  jmp   @@Next4
@@Done:
  pop   eax
end;

procedure Filler2;
asm
 nop
end;

function StrCopy_JOH_IA32_6_c(Dest: PChar; const Source: PChar): PChar;
asm {Size = 109 Bytes}
  push  eax
@@Next4:
  movzx ecx, [edx]
  mov   [eax], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+1]
  mov   [eax+1], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+3]
  mov   [eax+3], cl
  test  cl, cl
  jz    @@Done
  mov   ecx, edx
  sub   ecx, eax
  cmp   ecx, 4
  jb    @@Overlap
  mov   ecx, edx             {DWORD Align Reads}
  and   edx, -4
  sub   ecx, edx
  sub   eax, ecx
  push  ebx
  push  edi
@@Loop:
  add   edx, 4               {4 Chars per Loop}
  add   eax, 4
  mov   ecx, [edx]
  mov   edi, ecx
  lea   ebx, [ecx-$01010101]
  not   ecx
  and   ecx, ebx
  test  ecx, $80808080       {Set Byte to $80 at each #0 Position}
  jnz   @@Remainder
  mov   [eax], edi
  jmp   @@Loop               {Loop until any #0 Found}
@@Overlap:
  add   eax, 4               {Source/Dest Overlap}
  add   edx, 4
  jmp   @@Next4
@@Remainder:
  pop   edi
  pop   ebx
  jmp   @@Next4
@@Done:
  pop   eax
end;

procedure Filler3;
asm
 nop
end;

function StrCopy_JOH_IA32_6_d(Dest: PChar; const Source: PChar): PChar;
asm {Size = 109 Bytes}
  push  eax
@@Next4:
  movzx ecx, [edx]
  mov   [eax], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+1]
  mov   [eax+1], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+3]
  mov   [eax+3], cl
  test  cl, cl
  jz    @@Done
  mov   ecx, edx
  sub   ecx, eax
  cmp   ecx, 4
  jb    @@Overlap
  mov   ecx, edx             {DWORD Align Reads}
  and   edx, -4
  sub   ecx, edx
  sub   eax, ecx
  push  ebx
  push  edi
@@Loop:
  add   edx, 4               {4 Chars per Loop}
  add   eax, 4
  mov   ecx, [edx]
  mov   edi, ecx
  lea   ebx, [ecx-$01010101]
  not   ecx
  and   ecx, ebx
  test  ecx, $80808080       {Set Byte to $80 at each #0 Position}
  jnz   @@Remainder
  mov   [eax], edi
  jmp   @@Loop               {Loop until any #0 Found}
@@Overlap:
  add   eax, 4               {Source/Dest Overlap}
  add   edx, 4
  jmp   @@Next4
@@Remainder:
  pop   edi
  pop   ebx
  jmp   @@Next4
@@Done:
  pop   eax
end;

function StrCopy_JOH_IA32_7_a(Dest: PChar; const Source: PChar): PChar;
asm {Size = 147 Bytes}
  push  eax
  mov   ecx, edx
  sub   ecx, eax
  cmp   ecx, 4
  jb    @@Overlap            {Source/Dest Overlap}
  movzx ecx, [edx]
  mov   [eax], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+1]
  mov   [eax+1], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+3]
  mov   [eax+3], cl
  test  cl, cl
  jz    @@Done
  mov   ecx, edx             {DWORD Align Reads}
  and   edx, -4
  sub   ecx, edx
  sub   eax, ecx
  push  ebx
@@Loop:
  add   edx, 4               {4 Chars per Loop}
  add   eax, 4
  mov   ecx, [edx]
  lea   ebx, [ecx-$01010101]
  not   ecx
  and   ecx, ebx
  test  ecx, $80808080
  jnz   @@Remainder
  mov   ecx, [edx]
  mov   [eax], ecx
  jmp   @@Loop               {Loop until any #0 Found}
@@Remainder:
  pop   ebx
@@Overlap:
  movzx ecx, [edx]
  mov   [eax], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+1]
  mov   [eax+1], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+3]
  mov   [eax+3], cl
  test  cl, cl
  jz    @@Done
  add   eax, 4
  add   edx, 4
  jmp @@overlap
@@Done:
  pop   eax
end;

function StrCopy_JOH_IA32_7_b(Dest: PChar; const Source: PChar): PChar;
asm {Size = 147 Bytes}
  push  eax
  mov   ecx, edx
  sub   ecx, eax
  cmp   ecx, 4
  jb    @@Overlap            {Source/Dest Overlap}
  movzx ecx, [edx]
  mov   [eax], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+1]
  mov   [eax+1], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+3]
  mov   [eax+3], cl
  test  cl, cl
  jz    @@Done
  mov   ecx, edx             {DWORD Align Reads}
  and   edx, -4
  sub   ecx, edx
  sub   eax, ecx
  push  ebx
@@Loop:
  add   edx, 4               {4 Chars per Loop}
  add   eax, 4
  mov   ecx, [edx]
  lea   ebx, [ecx-$01010101]
  not   ecx
  and   ecx, ebx
  test  ecx, $80808080
  jnz   @@Remainder
  mov   ecx, [edx]
  mov   [eax], ecx
  jmp   @@Loop               {Loop until any #0 Found}
@@Remainder:
  pop   ebx
@@Overlap:
  movzx ecx, [edx]
  mov   [eax], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+1]
  mov   [eax+1], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+3]
  mov   [eax+3], cl
  test  cl, cl
  jz    @@Done
  add   eax, 4
  add   edx, 4
  jmp @@overlap
@@Done:
  pop   eax
end;

function StrCopy_JOH_IA32_7_c(Dest: PChar; const Source: PChar): PChar;
asm {Size = 147 Bytes}
  push  eax
  mov   ecx, edx
  sub   ecx, eax
  cmp   ecx, 4
  jb    @@Overlap            {Source/Dest Overlap}
  movzx ecx, [edx]
  mov   [eax], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+1]
  mov   [eax+1], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+3]
  mov   [eax+3], cl
  test  cl, cl
  jz    @@Done
  mov   ecx, edx             {DWORD Align Reads}
  and   edx, -4
  sub   ecx, edx
  sub   eax, ecx
  push  ebx
@@Loop:
  add   edx, 4               {4 Chars per Loop}
  add   eax, 4
  mov   ecx, [edx]
  lea   ebx, [ecx-$01010101]
  not   ecx
  and   ecx, ebx
  test  ecx, $80808080
  jnz   @@Remainder
  mov   ecx, [edx]
  mov   [eax], ecx
  jmp   @@Loop               {Loop until any #0 Found}
@@Remainder:
  pop   ebx
@@Overlap:
  movzx ecx, [edx]
  mov   [eax], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+1]
  mov   [eax+1], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+3]
  mov   [eax+3], cl
  test  cl, cl
  jz    @@Done
  add   eax, 4
  add   edx, 4
  jmp @@overlap
@@Done:
  pop   eax
end;

function StrCopy_JOH_IA32_7_d(Dest: PChar; const Source: PChar): PChar;
asm {Size = 147 Bytes}
  push  eax
  mov   ecx, edx
  sub   ecx, eax
  cmp   ecx, 4
  jb    @@Overlap            {Source/Dest Overlap}
  movzx ecx, [edx]
  mov   [eax], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+1]
  mov   [eax+1], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+3]
  mov   [eax+3], cl
  test  cl, cl
  jz    @@Done
  mov   ecx, edx             {DWORD Align Reads}
  and   edx, -4
  sub   ecx, edx
  sub   eax, ecx
  push  ebx
@@Loop:
  add   edx, 4               {4 Chars per Loop}
  add   eax, 4
  mov   ecx, [edx]
  lea   ebx, [ecx-$01010101]
  not   ecx
  and   ecx, ebx
  test  ecx, $80808080
  jnz   @@Remainder
  mov   ecx, [edx]
  mov   [eax], ecx
  jmp   @@Loop               {Loop until any #0 Found}
@@Remainder:
  pop   ebx
@@Overlap:
  movzx ecx, [edx]
  mov   [eax], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+1]
  mov   [eax+1], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Done
  movzx ecx, [edx+3]
  mov   [eax+3], cl
  test  cl, cl
  jz    @@Done
  add   eax, 4
  add   edx, 4
  jmp @@overlap
@@Done:
  pop   eax
end;

function StrCopy_JOH_IA32_8_a(Dest: PChar; const Source: PChar): PChar;
asm {Size = 144 Bytes}
  mov   ecx, edx
  sub   ecx, eax
  cmp   ecx, 4
  jb    @@Overlap            {Source/Dest Overlap}
  movzx ecx, [edx]
  mov   [eax], cl
  test  cl, cl
  jz    @@Exit
  movzx ecx, [edx+1]
  mov   [eax+1], cl
  test  cl, cl
  jz    @@Exit
  movzx ecx, [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Exit
  movzx ecx, [edx+3]
  mov   [eax+3], cl
  test  cl, cl
  jz    @@Exit
  push  eax
  push  ebx
  push  edi
  mov   ecx, edx             {DWORD Align Reads}
  and   edx, -4
  sub   ecx, edx
  sub   eax, ecx
@@Loop:
  add   edx, 4               {4 Chars per Loop}
  add   eax, 4
  mov   ecx, [edx]
  mov   ebx, ecx
  lea   edi, [ecx-$01010101]
  not   ecx
  and   ecx, edi
  test  ecx, $80808080
  jnz   @@Remainder          {#0 Found}
  mov   [eax], ebx
  jmp   @@Loop               {Loop until any #0 Found}
@@Remainder:
  mov   [eax], bl            {Copy Remainder}
  test  bl, bl
  jz    @@Done
  mov   [eax+1], bh
  test  bh, bh
  jz    @@Done
  movzx ecx, word ptr [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Done
  mov   [eax+3], ch
@@Done:
  pop   edi
  pop   ebx
  pop   eax
  ret
@@Overlap:
  push  eax
@@Next:
  movzx ecx, [edx]
  mov   [eax], cl
  add   eax, 1
  add   edx, 1
  test  cl, cl
  jnz   @@Next
  pop   eax
@@Exit:
end;

procedure Filler4;
asm
 nop
end;

function StrCopy_JOH_IA32_8_b(Dest: PChar; const Source: PChar): PChar;
asm {Size = 144 Bytes}
  mov   ecx, edx
  sub   ecx, eax
  cmp   ecx, 4
  jb    @@Overlap            {Source/Dest Overlap}
  movzx ecx, [edx]
  mov   [eax], cl
  test  cl, cl
  jz    @@Exit
  movzx ecx, [edx+1]
  mov   [eax+1], cl
  test  cl, cl
  jz    @@Exit
  movzx ecx, [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Exit
  movzx ecx, [edx+3]
  mov   [eax+3], cl
  test  cl, cl
  jz    @@Exit
  push  eax
  push  ebx
  push  edi
  mov   ecx, edx             {DWORD Align Reads}
  and   edx, -4
  sub   ecx, edx
  sub   eax, ecx
@@Loop:
  add   edx, 4               {4 Chars per Loop}
  add   eax, 4
  mov   ecx, [edx]
  mov   ebx, ecx
  lea   edi, [ecx-$01010101]
  not   ecx
  and   ecx, edi
  test  ecx, $80808080
  jnz   @@Remainder          {#0 Found}
  mov   [eax], ebx
  jmp   @@Loop               {Loop until any #0 Found}
@@Remainder:
  mov   [eax], bl            {Copy Remainder}
  test  bl, bl
  jz    @@Done
  mov   [eax+1], bh
  test  bh, bh
  jz    @@Done
  movzx ecx, word ptr [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Done
  mov   [eax+3], ch
@@Done:
  pop   edi
  pop   ebx
  pop   eax
  ret
@@Overlap:
  push  eax
@@Next:
  movzx ecx, [edx]
  mov   [eax], cl
  add   eax, 1
  add   edx, 1
  test  cl, cl
  jnz   @@Next
  pop   eax
@@Exit:
end;

procedure Filler5;
asm
 nop
end;

function StrCopy_JOH_IA32_8_c(Dest: PChar; const Source: PChar): PChar;
asm {Size = 144 Bytes}
  mov   ecx, edx
  sub   ecx, eax
  cmp   ecx, 4
  jb    @@Overlap            {Source/Dest Overlap}
  movzx ecx, [edx]
  mov   [eax], cl
  test  cl, cl
  jz    @@Exit
  movzx ecx, [edx+1]
  mov   [eax+1], cl
  test  cl, cl
  jz    @@Exit
  movzx ecx, [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Exit
  movzx ecx, [edx+3]
  mov   [eax+3], cl
  test  cl, cl
  jz    @@Exit
  push  eax
  push  ebx
  push  edi
  mov   ecx, edx             {DWORD Align Reads}
  and   edx, -4
  sub   ecx, edx
  sub   eax, ecx
@@Loop:
  add   edx, 4               {4 Chars per Loop}
  add   eax, 4
  mov   ecx, [edx]
  mov   ebx, ecx
  lea   edi, [ecx-$01010101]
  not   ecx
  and   ecx, edi
  test  ecx, $80808080
  jnz   @@Remainder          {#0 Found}
  mov   [eax], ebx
  jmp   @@Loop               {Loop until any #0 Found}
@@Remainder:
  mov   [eax], bl            {Copy Remainder}
  test  bl, bl
  jz    @@Done
  mov   [eax+1], bh
  test  bh, bh
  jz    @@Done
  movzx ecx, word ptr [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Done
  mov   [eax+3], ch
@@Done:
  pop   edi
  pop   ebx
  pop   eax
  ret
@@Overlap:
  push  eax
@@Next:
  movzx ecx, [edx]
  mov   [eax], cl
  add   eax, 1
  add   edx, 1
  test  cl, cl
  jnz   @@Next
  pop   eax
@@Exit:
end;

procedure Filler6;
asm
 nop
end;

function StrCopy_JOH_IA32_8_d(Dest: PChar; const Source: PChar): PChar;
asm {Size = 144 Bytes}
  mov   ecx, edx
  sub   ecx, eax
  cmp   ecx, 4
  jb    @@Overlap            {Source/Dest Overlap}
  movzx ecx, [edx]
  mov   [eax], cl
  test  cl, cl
  jz    @@Exit
  movzx ecx, [edx+1]
  mov   [eax+1], cl
  test  cl, cl
  jz    @@Exit
  movzx ecx, [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Exit
  movzx ecx, [edx+3]
  mov   [eax+3], cl
  test  cl, cl
  jz    @@Exit
  push  eax
  push  ebx
  push  edi
  mov   ecx, edx             {DWORD Align Reads}
  and   edx, -4
  sub   ecx, edx
  sub   eax, ecx
@@Loop:
  add   edx, 4               {4 Chars per Loop}
  add   eax, 4
  mov   ecx, [edx]
  mov   ebx, ecx
  lea   edi, [ecx-$01010101]
  not   ecx
  and   ecx, edi
  test  ecx, $80808080
  jnz   @@Remainder          {#0 Found}
  mov   [eax], ebx
  jmp   @@Loop               {Loop until any #0 Found}
@@Remainder:
  mov   [eax], bl            {Copy Remainder}
  test  bl, bl
  jz    @@Done
  mov   [eax+1], bh
  test  bh, bh
  jz    @@Done
  movzx ecx, word ptr [edx+2]
  mov   [eax+2], cl
  test  cl, cl
  jz    @@Done
  mov   [eax+3], ch
@@Done:
  pop   edi
  pop   ebx
  pop   eax
  ret
@@Overlap:
  push  eax
@@Next:
  movzx ecx, [edx]
  mov   [eax], cl
  add   eax, 1
  add   edx, 1
  test  cl, cl
  jnz   @@Next
  pop   eax
@@Exit:
end;

function StrCopy_JOH_MMX_1_a(Dest: PChar; const Source: PChar): PChar;
asm {Size = 270 Bytes}
  push     eax
  mov      ecx, edx
  sub      ecx, eax
  cmp      ecx, 8
  jb       @@Overlap            {Source/Dest Overlap}
  movzx    ecx, [edx]
  mov      [eax], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+1]
  mov      [eax+1], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+2]
  mov      [eax+2], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+3]
  mov      [eax+3], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+4]
  mov      [eax+4], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+5]
  mov      [eax+5], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+6]
  mov      [eax+6], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+7]
  mov      [eax+7], cl
  test      cl, cl
  jz       @@Done
  mov      ecx, edx             {QWORD Align Reads}
  and      edx, -8
  sub      ecx, edx
  sub      eax, ecx
@@Loop:
  add      edx, 8               {8 Chars per Loop}
  add      eax, 8
  pxor     mm0, mm0
  movq     mm1, [edx]
  pcmpeqb  mm0, mm1
  packsswb mm0, mm0
  movd     ecx, mm0
  test     ecx, ecx
  jnz      @@Remainder
  movq     [eax], mm1
  jmp      @@Loop               {Loop until any #0 Found}
@@Remainder:
  emms
  movzx    ecx, [edx]
  mov      [eax], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+1]
  mov      [eax+1], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+2]
  mov      [eax+2], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+3]
  mov      [eax+3], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+4]
  mov      [eax+4], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+5]
  mov      [eax+5], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+6]
  mov      [eax+6], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+7]
  mov      [eax+7], cl
@@Done:
  pop      eax
  ret
@@Overlap:
  movzx    ecx, [edx]
  mov      [eax], cl
  add      eax, 1
  add      edx, 1
  test     cl, cl
  jnz      @@Overlap
  pop      eax
end;

procedure Filler7;
asm
 nop
end;

function StrCopy_JOH_MMX_1_b(Dest: PChar; const Source: PChar): PChar;
asm {Size = 270 Bytes}
  push     eax
  mov      ecx, edx
  sub      ecx, eax
  cmp      ecx, 8
  jb       @@Overlap            {Source/Dest Overlap}
  movzx    ecx, [edx]
  mov      [eax], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+1]
  mov      [eax+1], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+2]
  mov      [eax+2], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+3]
  mov      [eax+3], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+4]
  mov      [eax+4], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+5]
  mov      [eax+5], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+6]
  mov      [eax+6], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+7]
  mov      [eax+7], cl
  test      cl, cl
  jz       @@Done
  mov      ecx, edx             {QWORD Align Reads}
  and      edx, -8
  sub      ecx, edx
  sub      eax, ecx
@@Loop:
  add      edx, 8               {8 Chars per Loop}
  add      eax, 8
  pxor     mm0, mm0
  movq     mm1, [edx]
  pcmpeqb  mm0, mm1
  packsswb mm0, mm0
  movd     ecx, mm0
  test     ecx, ecx
  jnz      @@Remainder
  movq     [eax], mm1
  jmp      @@Loop               {Loop until any #0 Found}
@@Remainder:
  emms
  movzx    ecx, [edx]
  mov      [eax], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+1]
  mov      [eax+1], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+2]
  mov      [eax+2], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+3]
  mov      [eax+3], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+4]
  mov      [eax+4], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+5]
  mov      [eax+5], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+6]
  mov      [eax+6], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+7]
  mov      [eax+7], cl
@@Done:
  pop      eax
  ret
@@Overlap:
  movzx    ecx, [edx]
  mov      [eax], cl
  add      eax, 1
  add      edx, 1
  test     cl, cl
  jnz      @@Overlap
  pop      eax
end;

procedure Filler8;
asm
 nop
end;

function StrCopy_JOH_MMX_1_c(Dest: PChar; const Source: PChar): PChar;
asm {Size = 270 Bytes}
  push     eax
  mov      ecx, edx
  sub      ecx, eax
  cmp      ecx, 8
  jb       @@Overlap            {Source/Dest Overlap}
  movzx    ecx, [edx]
  mov      [eax], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+1]
  mov      [eax+1], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+2]
  mov      [eax+2], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+3]
  mov      [eax+3], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+4]
  mov      [eax+4], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+5]
  mov      [eax+5], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+6]
  mov      [eax+6], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+7]
  mov      [eax+7], cl
  test      cl, cl
  jz       @@Done
  mov      ecx, edx             {QWORD Align Reads}
  and      edx, -8
  sub      ecx, edx
  sub      eax, ecx
@@Loop:
  add      edx, 8               {8 Chars per Loop}
  add      eax, 8
  pxor     mm0, mm0
  movq     mm1, [edx]
  pcmpeqb  mm0, mm1
  packsswb mm0, mm0
  movd     ecx, mm0
  test     ecx, ecx
  jnz      @@Remainder
  movq     [eax], mm1
  jmp      @@Loop               {Loop until any #0 Found}
@@Remainder:
  emms
  movzx    ecx, [edx]
  mov      [eax], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+1]
  mov      [eax+1], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+2]
  mov      [eax+2], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+3]
  mov      [eax+3], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+4]
  mov      [eax+4], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+5]
  mov      [eax+5], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+6]
  mov      [eax+6], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+7]
  mov      [eax+7], cl
@@Done:
  pop      eax
  ret
@@Overlap:
  movzx    ecx, [edx]
  mov      [eax], cl
  add      eax, 1
  add      edx, 1
  test     cl, cl
  jnz      @@Overlap
  pop      eax
end;

procedure Filler9;
asm
 nop
end;

function StrCopy_JOH_MMX_1_d(Dest: PChar; const Source: PChar): PChar;
asm {Size = 270 Bytes}
  push     eax
  mov      ecx, edx
  sub      ecx, eax
  cmp      ecx, 8
  jb       @@Overlap            {Source/Dest Overlap}
  movzx    ecx, [edx]
  mov      [eax], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+1]
  mov      [eax+1], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+2]
  mov      [eax+2], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+3]
  mov      [eax+3], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+4]
  mov      [eax+4], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+5]
  mov      [eax+5], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+6]
  mov      [eax+6], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+7]
  mov      [eax+7], cl
  test      cl, cl
  jz       @@Done
  mov      ecx, edx             {QWORD Align Reads}
  and      edx, -8
  sub      ecx, edx
  sub      eax, ecx
@@Loop:
  add      edx, 8               {8 Chars per Loop}
  add      eax, 8
  pxor     mm0, mm0
  movq     mm1, [edx]
  pcmpeqb  mm0, mm1
  packsswb mm0, mm0
  movd     ecx, mm0
  test     ecx, ecx
  jnz      @@Remainder
  movq     [eax], mm1
  jmp      @@Loop               {Loop until any #0 Found}
@@Remainder:
  emms
  movzx    ecx, [edx]
  mov      [eax], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+1]
  mov      [eax+1], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+2]
  mov      [eax+2], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+3]
  mov      [eax+3], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+4]
  mov      [eax+4], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+5]
  mov      [eax+5], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+6]
  mov      [eax+6], cl
  test     cl, cl
  jz       @@Done
  movzx    ecx, [edx+7]
  mov      [eax+7], cl
@@Done:
  pop      eax
  ret
@@Overlap:
  movzx    ecx, [edx]
  mov      [eax], cl
  add      eax, 1
  add      edx, 1
  test     cl, cl
  jnz      @@Overlap
  pop      eax
end;

function StrCopy_JOH_IA32_9_a(Dest: PChar; const Source: PChar): PChar;
asm {Size = 127 Bytes}
  push  eax
  movzx ecx, [edx]
  test  cl, cl
  jz    @@Exit1              {1st Char = #0}
  or    ch, [edx+1]
  mov   [eax], cx
  jz    @@Done               {2nd Char = #0}
  movzx ecx, [edx+2]
  test  cl, cl
  jz    @@Exit2              {3rd Char = #0}
  or    ch, [edx+3]
  mov   [eax+2], cx
  jz    @@Done               {4th Char = #0}
  mov   ecx, edx
  sub   edx, eax
  cmp   edx, 4
  jb    @@Overlap            {Source/Dest Overlap by less than 4}
  and   ecx, 3               {DWORD Align Reads}
  sub   eax, ecx
  push  ebx
  push  edi
@@Loop:
  add   eax, 4               {4 Chars per Loop}
  mov   ecx, [edx+eax]
  mov   ebx, ecx
  lea   edi, [ecx-$01010101]
  not   ebx
  and   ebx, edi
  test  ebx, $80808080
  jnz   @@Remainder          {#0 Found within 4 Chars}
  mov   [eax], ecx           {Copy 4 Chars}
  jmp   @@Loop               {Loop until any #0 Found}
@@Remainder:
  pop   edi
  pop   ebx
  test  cl, cl
  jz    @@Exit1              {1st Char = #0}
  test  ch, ch
  mov   [eax], cx
  jz    @@Done               {2nd Char = #0}
  test  ecx, $00ff0000
  jz    @@Exit2              {3rd Char = #0}
  mov   [eax], ecx           {4th Char = #0}
@@Done:
  pop   eax
  ret
@@Exit2:
  add   eax, 2
@@Exit1:
  mov   byte ptr [eax], 0
  pop   eax
  ret
@@Overlap:
  movzx ecx, [edx+eax+4]
  mov   [eax+4], cl
  inc   eax
  test  cl, cl
  jnz   @@overlap
  pop   eax
end;

function StrCopy_JOH_IA32_9_b(Dest: PChar; const Source: PChar): PChar;
asm {Size = 127 Bytes}
  push  eax
  movzx ecx, [edx]
  test  cl, cl
  jz    @@Exit1              {1st Char = #0}
  or    ch, [edx+1]
  mov   [eax], cx
  jz    @@Done               {2nd Char = #0}
  movzx ecx, [edx+2]
  test  cl, cl
  jz    @@Exit2              {3rd Char = #0}
  or    ch, [edx+3]
  mov   [eax+2], cx
  jz    @@Done               {4th Char = #0}
  mov   ecx, edx
  sub   edx, eax
  cmp   edx, 4
  jb    @@Overlap            {Source/Dest Overlap by less than 4}
  and   ecx, 3               {DWORD Align Reads}
  sub   eax, ecx
  push  ebx
  push  edi
@@Loop:
  add   eax, 4               {4 Chars per Loop}
  mov   ecx, [edx+eax]
  mov   ebx, ecx
  lea   edi, [ecx-$01010101]
  not   ebx
  and   ebx, edi
  test  ebx, $80808080
  jnz   @@Remainder          {#0 Found within 4 Chars}
  mov   [eax], ecx           {Copy 4 Chars}
  jmp   @@Loop               {Loop until any #0 Found}
@@Remainder:
  pop   edi
  pop   ebx
  test  cl, cl
  jz    @@Exit1              {1st Char = #0}
  test  ch, ch
  mov   [eax], cx
  jz    @@Done               {2nd Char = #0}
  test  ecx, $00ff0000
  jz    @@Exit2              {3rd Char = #0}
  mov   [eax], ecx           {4th Char = #0}
@@Done:
  pop   eax
  ret
@@Exit2:
  add   eax, 2
@@Exit1:
  mov   byte ptr [eax], 0
  pop   eax
  ret
@@Overlap:
  movzx ecx, [edx+eax+4]
  mov   [eax+4], cl
  inc   eax
  test  cl, cl
  jnz   @@overlap
  pop   eax
end;

function StrCopy_JOH_IA32_9_c(Dest: PChar; const Source: PChar): PChar;
asm {Size = 127 Bytes}
  push  eax
  movzx ecx, [edx]
  test  cl, cl
  jz    @@Exit1              {1st Char = #0}
  or    ch, [edx+1]
  mov   [eax], cx
  jz    @@Done               {2nd Char = #0}
  movzx ecx, [edx+2]
  test  cl, cl
  jz    @@Exit2              {3rd Char = #0}
  or    ch, [edx+3]
  mov   [eax+2], cx
  jz    @@Done               {4th Char = #0}
  mov   ecx, edx
  sub   edx, eax
  cmp   edx, 4
  jb    @@Overlap            {Source/Dest Overlap by less than 4}
  and   ecx, 3               {DWORD Align Reads}
  sub   eax, ecx
  push  ebx
  push  edi
@@Loop:
  add   eax, 4               {4 Chars per Loop}
  mov   ecx, [edx+eax]
  mov   ebx, ecx
  lea   edi, [ecx-$01010101]
  not   ebx
  and   ebx, edi
  test  ebx, $80808080
  jnz   @@Remainder          {#0 Found within 4 Chars}
  mov   [eax], ecx           {Copy 4 Chars}
  jmp   @@Loop               {Loop until any #0 Found}
@@Remainder:
  pop   edi
  pop   ebx
  test  cl, cl
  jz    @@Exit1              {1st Char = #0}
  test  ch, ch
  mov   [eax], cx
  jz    @@Done               {2nd Char = #0}
  test  ecx, $00ff0000
  jz    @@Exit2              {3rd Char = #0}
  mov   [eax], ecx           {4th Char = #0}
@@Done:
  pop   eax
  ret
@@Exit2:
  add   eax, 2
@@Exit1:
  mov   byte ptr [eax], 0
  pop   eax
  ret
@@Overlap:
  movzx ecx, [edx+eax+4]
  mov   [eax+4], cl
  inc   eax
  test  cl, cl
  jnz   @@overlap
  pop   eax
end;

function StrCopy_JOH_IA32_9_d(Dest: PChar; const Source: PChar): PChar;
asm {Size = 127 Bytes}
  push  eax
  movzx ecx, [edx]
  test  cl, cl
  jz    @@Exit1              {1st Char = #0}
  or    ch, [edx+1]
  mov   [eax], cx
  jz    @@Done               {2nd Char = #0}
  movzx ecx, [edx+2]
  test  cl, cl
  jz    @@Exit2              {3rd Char = #0}
  or    ch, [edx+3]
  mov   [eax+2], cx
  jz    @@Done               {4th Char = #0}
  mov   ecx, edx
  sub   edx, eax
  cmp   edx, 4
  jb    @@Overlap            {Source/Dest Overlap by less than 4}
  and   ecx, 3               {DWORD Align Reads}
  sub   eax, ecx
  push  ebx
  push  edi
@@Loop:
  add   eax, 4               {4 Chars per Loop}
  mov   ecx, [edx+eax]
  mov   ebx, ecx
  lea   edi, [ecx-$01010101]
  not   ebx
  and   ebx, edi
  test  ebx, $80808080
  jnz   @@Remainder          {#0 Found within 4 Chars}
  mov   [eax], ecx           {Copy 4 Chars}
  jmp   @@Loop               {Loop until any #0 Found}
@@Remainder:
  pop   edi
  pop   ebx
  test  cl, cl
  jz    @@Exit1              {1st Char = #0}
  test  ch, ch
  mov   [eax], cx
  jz    @@Done               {2nd Char = #0}
  test  ecx, $00ff0000
  jz    @@Exit2              {3rd Char = #0}
  mov   [eax], ecx           {4th Char = #0}
@@Done:
  pop   eax
  ret
@@Exit2:
  add   eax, 2
@@Exit1:
  mov   byte ptr [eax], 0
  pop   eax
  ret
@@Overlap:
  movzx ecx, [edx+eax+4]
  mov   [eax+4], cl
  inc   eax
  test  cl, cl
  jnz   @@overlap
  pop   eax
end;


initialization
  Filler1;
  Filler2;
  Filler3;
  Filler4;
  Filler5;
  Filler6;
  Filler7;
  Filler8;
  Filler9;
end.

