unit StrCompJOHUnit;

interface

function StrComp_JOH_PAS_2_a(const Str1, Str2: PChar): Integer;
function StrComp_JOH_PAS_2_b(const Str1, Str2: PChar): Integer;
function StrComp_JOH_PAS_2_c(const Str1, Str2: PChar): Integer;
function StrComp_JOH_PAS_2_d(const Str1, Str2: PChar): Integer;

function StrComp_JOH_IA32_5_a(const Str1, Str2: PChar): Integer;
function StrComp_JOH_IA32_5_b(const Str1, Str2: PChar): Integer;
function StrComp_JOH_IA32_5_c(const Str1, Str2: PChar): Integer;
function StrComp_JOH_IA32_5_d(const Str1, Str2: PChar): Integer;

function StrComp_JOH_IA32_6_a(const Str1, Str2: PChar): Integer;
function StrComp_JOH_IA32_6_b(const Str1, Str2: PChar): Integer;
function StrComp_JOH_IA32_6_c(const Str1, Str2: PChar): Integer;
function StrComp_JOH_IA32_6_d(const Str1, Str2: PChar): Integer;

implementation

function StrComp_JOH_PAS_2_a(const Str1, Str2: PChar): Integer;
var
  Ch     : Char;
  Offset : Integer;
  PStr   : PChar;
begin;
  PStr   := Str1;
  Offset := Str2 - PStr;
  repeat
    Ch := PStr[Offset];
    if (Ch = #0) or (Ch <> PStr^) then
      begin
        Result := Integer(PStr^) - Integer(Ch);
        Exit;
      end;
    Inc(PStr);
  until False;
end;

procedure Filler1;
asm
  nop
end;

function StrComp_JOH_PAS_2_b(const Str1, Str2: PChar): Integer;
var
  Ch     : Char;
  Offset : Integer;
  PStr   : PChar;
begin;
  PStr   := Str1;
  Offset := Str2 - PStr;
  repeat
    Ch := PStr[Offset];
    if (Ch = #0) or (Ch <> PStr^) then
      begin
        Result := Integer(PStr^) - Integer(Ch);
        Exit;
      end;
    Inc(PStr);
  until False;
end;

procedure Filler2;
asm
  nop
end;

function StrComp_JOH_PAS_2_c(const Str1, Str2: PChar): Integer;
var
  Ch     : Char;
  Offset : Integer;
  PStr   : PChar;
begin;
  PStr   := Str1;
  Offset := Str2 - PStr;
  repeat
    Ch := PStr[Offset];
    if (Ch = #0) or (Ch <> PStr^) then
      begin
        Result := Integer(PStr^) - Integer(Ch);
        Exit;
      end;
    Inc(PStr);
  until False;
end;

procedure Filler3;
asm
  nop
end;

function StrComp_JOH_PAS_2_d(const Str1, Str2: PChar): Integer;
var
  Ch     : Char;
  Offset : Integer;
  PStr   : PChar;
begin;
  PStr   := Str1;
  Offset := Str2 - PStr;
  repeat
    Ch := PStr[Offset];
    if (Ch = #0) or (Ch <> PStr^) then
      begin
        Result := Integer(PStr^) - Integer(Ch);
        Exit;
      end;
    Inc(PStr);
  until False;
end;

{RTL Candidate - 25 Bytes}

function StrComp_JOH_IA32_5_a(const Str1, Str2: PChar): Integer;
asm
  sub   eax, edx
  jz    @@Exit
@@Loop:
  movzx ecx, [eax+edx]
  cmp   cl, [edx]
  jne   @@SetResult
  inc   edx                 
  test  cl, cl
  jnz   @@Loop
  xor   eax, eax
  ret
@@SetResult:
  sbb   eax, eax
  or    al, 1
@@Exit:
end;

function StrComp_JOH_IA32_5_b(const Str1, Str2: PChar): Integer;
asm
  sub   eax, edx
  jz    @@Exit
@@Loop:
  movzx ecx, [eax+edx]
  cmp   cl, [edx]
  jne   @@SetResult
  inc   edx
  test  cl, cl
  jnz   @@Loop
  xor   eax, eax
  ret
@@SetResult:
  sbb   eax, eax
  or    al, 1
@@Exit:
end;

function StrComp_JOH_IA32_5_c(const Str1, Str2: PChar): Integer;
asm
  sub   eax, edx
  jz    @@Exit
@@Loop:
  movzx ecx, [eax+edx]
  cmp   cl, [edx]
  jne   @@SetResult
  inc   edx
  test  cl, cl
  jnz   @@Loop
  xor   eax, eax
  ret
@@SetResult:
  sbb   eax, eax
  or    al, 1
@@Exit:
end;

function StrComp_JOH_IA32_5_d(const Str1, Str2: PChar): Integer;
asm
  sub   eax, edx
  jz    @@Exit
@@Loop:
  movzx ecx, [eax+edx]
  cmp   cl, [edx]
  jne   @@SetResult
  inc   edx
  test  cl, cl
  jnz   @@Loop
  xor   eax, eax
  ret
@@SetResult:
  sbb   eax, eax
  or    al, 1
@@Exit:
end;

function StrComp_JOH_IA32_6_a(const Str1, Str2: PChar): Integer;
asm
  sub   eax, edx
  mov   ecx, eax
  jz    @@Exit
@@Loop:
  movzx eax, [ecx+edx]
  cmp   al, [edx]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+1]
  cmp   al, [edx+1]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+2]
  cmp   al, [edx+2]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+3]
  cmp   al, [edx+3]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+4]
  cmp   al, [edx+4]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+5]
  cmp   al, [edx+5]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+6]
  cmp   al, [edx+6]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+7]
  cmp   al, [edx+7]
  jne   @@SetResult
  add   edx, 8
  test  al, al
  jnz   @@Loop
  ret
@@SetResult:
  sbb   eax, eax
  or    al, 1
@@Exit:
end;

procedure Filler4;
asm
  nop
end;

function StrComp_JOH_IA32_6_b(const Str1, Str2: PChar): Integer;
asm
  sub   eax, edx
  mov   ecx, eax
  jz    @@Exit
@@Loop:
  movzx eax, [ecx+edx]
  cmp   al, [edx]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+1]
  cmp   al, [edx+1]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+2]
  cmp   al, [edx+2]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+3]
  cmp   al, [edx+3]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+4]
  cmp   al, [edx+4]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+5]
  cmp   al, [edx+5]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+6]
  cmp   al, [edx+6]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+7]
  cmp   al, [edx+7]
  jne   @@SetResult
  add   edx, 8
  test  al, al
  jnz   @@Loop
  ret
@@SetResult:
  sbb   eax, eax
  or    al, 1
@@Exit:
end;

procedure Filler5;
asm
  nop
end;

function StrComp_JOH_IA32_6_c(const Str1, Str2: PChar): Integer;
asm
  sub   eax, edx
  mov   ecx, eax
  jz    @@Exit
@@Loop:
  movzx eax, [ecx+edx]
  cmp   al, [edx]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+1]
  cmp   al, [edx+1]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+2]
  cmp   al, [edx+2]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+3]
  cmp   al, [edx+3]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+4]
  cmp   al, [edx+4]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+5]
  cmp   al, [edx+5]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+6]
  cmp   al, [edx+6]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+7]
  cmp   al, [edx+7]
  jne   @@SetResult
  add   edx, 8
  test  al, al
  jnz   @@Loop
  ret
@@SetResult:
  sbb   eax, eax
  or    al, 1
@@Exit:
end;

procedure Filler6;
asm
  nop
end;

function StrComp_JOH_IA32_6_d(const Str1, Str2: PChar): Integer;
asm
  sub   eax, edx
  mov   ecx, eax
  jz    @@Exit
@@Loop:
  movzx eax, [ecx+edx]
  cmp   al, [edx]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+1]
  cmp   al, [edx+1]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+2]
  cmp   al, [edx+2]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+3]
  cmp   al, [edx+3]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+4]
  cmp   al, [edx+4]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+5]
  cmp   al, [edx+5]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+6]
  cmp   al, [edx+6]
  jne   @@SetResult
  test  al, al
  jz    @@Exit
  movzx eax, [ecx+edx+7]
  cmp   al, [edx+7]
  jne   @@SetResult
  add   edx, 8
  test  al, al
  jnz   @@Loop
  ret
@@SetResult:
  sbb   eax, eax
  or    al, 1
@@Exit:
end;

initialization

  Filler1;
  Filler2;
  Filler3;
  Filler4;
  Filler5;
  Filler6;

end.
