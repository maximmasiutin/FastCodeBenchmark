unit StrLCompJOHUnit;

interface

function StrCompJOH_PAS_2_a(const Str1, Str2: PChar): Integer;
function StrCompJOH_PAS_2_b(const Str1, Str2: PChar): Integer;
function StrCompJOH_PAS_2_c(const Str1, Str2: PChar): Integer;
function StrCompJOH_PAS_2_d(const Str1, Str2: PChar): Integer;

function StrCompJOH_IA32_5_a(const Str1, Str2: PChar): Integer;
function StrCompJOH_IA32_5_b(const Str1, Str2: PChar): Integer;
function StrCompJOH_IA32_5_c(const Str1, Str2: PChar): Integer;
function StrCompJOH_IA32_5_d(const Str1, Str2: PChar): Integer;

function StrCompJOH_IA32_6_a(const Str1, Str2: PChar): Integer;
function StrCompJOH_IA32_6_b(const Str1, Str2: PChar): Integer;
function StrCompJOH_IA32_6_c(const Str1, Str2: PChar): Integer;
function StrCompJOH_IA32_6_d(const Str1, Str2: PChar): Integer;

implementation

function StrCompJOH_PAS_2_a(const Str1, Str2: PChar): Integer;
var
  Ch     : Char;
  Offset : Integer;
  PStr   : PChar;
begin;
  PStr   := Str1;
  Offset := Str2 - PStr;
  while True do
    begin
      Ch := PStr[Offset];
      if (Ch = #0) or (Ch <> PStr^) then
        Break;
      Inc(PStr);
    end;
  Result := Integer(PStr^) - Integer(Ch);
end;

function StrCompJOH_PAS_2_b(const Str1, Str2: PChar): Integer;
var
  Ch     : Char;
  Offset : Integer;
  PStr   : PChar;
begin;
  PStr   := Str1;
  Offset := Str2 - PStr;
  while True do
    begin
      Ch := PStr[Offset];
      if (Ch = #0) or (Ch <> PStr^) then
        Break;
      Inc(PStr);
    end;
  Result := Integer(PStr^) - Integer(Ch);
end;

function StrCompJOH_PAS_2_c(const Str1, Str2: PChar): Integer;
var
  Ch     : Char;
  Offset : Integer;
  PStr   : PChar;
begin;
  PStr   := Str1;
  Offset := Str2 - PStr;
  while True do
    begin
      Ch := PStr[Offset];
      if (Ch = #0) or (Ch <> PStr^) then
        Break;
      Inc(PStr);
    end;
  Result := Integer(PStr^) - Integer(Ch);
end;

function StrCompJOH_PAS_2_d(const Str1, Str2: PChar): Integer;
var
  Ch     : Char;
  Offset : Integer;
  PStr   : PChar;
begin;
  PStr   := Str1;
  Offset := Str2 - PStr;
  while True do
    begin
      Ch := PStr[Offset];
      if (Ch = #0) or (Ch <> PStr^) then
        Break;
      Inc(PStr);
    end;
  Result := Integer(PStr^) - Integer(Ch);
end;

{RTL Candidate - 25 Bytes}

function StrCompJOH_IA32_5_a(const Str1, Str2: PChar): Integer;
asm
  sub   eax, edx             {Difference between Str1 and Str2}
  jz    @@Exit               {Str1}
  mov   ecx, eax             {Exit if Str1 = Str2}
@@Loop:
  movzx eax, [ecx+edx]       {Next Char of Str1}
  cmp   al, [edx]            {Compare with Next Char of Str2}
  jne   @@SetResult          {Exit Loop if Different}
  inc   edx                  {Prepare for Next Loop}
  test  al, al               {Both Chars Null Terminators?}
  jnz   @@Loop               {No - Repeat Loop}
  ret                        {Exit with Result = 0}
@@SetResult:                 {Difference Found}
  sbb   eax, eax             { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1                {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
end;

function StrCompJOH_IA32_5_b(const Str1, Str2: PChar): Integer;
asm
  sub   eax, edx
  jz    @@Exit
  mov   ecx, eax
@@Loop:
  movzx eax, [ecx+edx]
  cmp   al, [edx]
  jne   @@SetResult
  inc   edx
  test  al, al
  jnz   @@Loop
  ret
@@SetResult:
  sbb   eax, eax
  or    al, 1
@@Exit:
end;

function StrCompJOH_IA32_5_c(const Str1, Str2: PChar): Integer;
asm
  sub   eax, edx
  jz    @@Exit
  mov   ecx, eax
@@Loop:
  movzx eax, [ecx+edx]
  cmp   al, [edx]
  jne   @@SetResult
  inc   edx
  test  al, al
  jnz   @@Loop
  ret
@@SetResult:
  sbb   eax, eax
  or    al, 1
@@Exit:
end;

function StrCompJOH_IA32_5_d(const Str1, Str2: PChar): Integer;
asm
  sub   eax, edx
  jz    @@Exit
  mov   ecx, eax
@@Loop:
  movzx eax, [ecx+edx]
  cmp   al, [edx]
  jne   @@SetResult
  inc   edx
  test  al, al
  jnz   @@Loop
  ret
@@SetResult:
  sbb   eax, eax
  or    al, 1
@@Exit:
end;

function StrCompJOH_IA32_6_a(const Str1, Str2: PChar): Integer;
asm
  sub   eax, edx             {Difference between Str1 and Str2}
  mov   ecx, eax             {Str1}
  jz    @@Exit               {Exit if Str1 = Str2}
@@Loop:
  movzx eax, [ecx+edx]       {Next Char of Str1}
  cmp   al, [edx]            {Compare with Next Char of Str2}
  jne   @@SetResult          {Exit Loop if Different}
  test  al, al               {Both Chars Null Terminators?}
  jz    @@Exit               {Yes - Exit with Result = 0}
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
  add   edx, 8               {Prepare for Next Loop}
  test  al, al
  jnz   @@Loop
  ret
@@SetResult:                 {Difference Found}
  sbb   eax, eax             { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1                {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
end;

procedure Filler1;
asm
  nop
end;

function StrCompJOH_IA32_6_b(const Str1, Str2: PChar): Integer;
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

procedure Filler2;
asm
  nop
end;

function StrCompJOH_IA32_6_c(const Str1, Str2: PChar): Integer;
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

procedure Filler3;
asm
  nop
end;

function StrCompJOH_IA32_6_d(const Str1, Str2: PChar): Integer;
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

end.
