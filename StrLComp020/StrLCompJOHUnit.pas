unit StrLCompJOHUnit;

interface

function StrLComp_JOH_PAS_1_a(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function StrLComp_JOH_PAS_1_b(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function StrLComp_JOH_PAS_1_c(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function StrLComp_JOH_PAS_1_d(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;

function StrLComp_JOH_IA32_1_a(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function StrLComp_JOH_IA32_1_b(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function StrLComp_JOH_IA32_1_c(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function StrLComp_JOH_IA32_1_d(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;

implementation

function StrLComp_JOH_PAS_1_a(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
var
  Ch         : Char;
  Offset     : Integer;
  PStr, PEnd : PChar;
begin;
  PStr   := Str1;
  PEnd   := PStr + MaxLen;
  Offset := Str2 - PStr;
  while PStr <> PEnd do
    begin
      Ch := PStr[Offset];
      if (Ch = #0) or (Ch <> PStr^) then
        begin
          Result := Integer(PStr^) - Integer(Ch);
          Exit;
        end;
      Inc(PStr);
    end;
  Result := 0;
end;

procedure Filler1;
asm
  nop
end;

function StrLComp_JOH_PAS_1_b(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
var
  Ch         : Char;
  Offset     : Integer;
  PStr, PEnd : PChar;
begin;
  PStr   := Str1;
  PEnd   := PStr + MaxLen;
  Offset := Str2 - PStr;
  while PStr <> PEnd do
    begin
      Ch := PStr[Offset];
      if (Ch = #0) or (Ch <> PStr^) then
        begin
          Result := Integer(PStr^) - Integer(Ch);
          Exit;
        end;
      Inc(PStr);
    end;
  Result := 0;
end;

procedure Filler2;
asm
  nop
end;

function StrLComp_JOH_PAS_1_c(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
var
  Ch         : Char;
  Offset     : Integer;
  PStr, PEnd : PChar;
begin;
  PStr   := Str1;
  PEnd   := PStr + MaxLen;
  Offset := Str2 - PStr;
  while PStr <> PEnd do
    begin
      Ch := PStr[Offset];
      if (Ch = #0) or (Ch <> PStr^) then
        begin
          Result := Integer(PStr^) - Integer(Ch);
          Exit;
        end;
      Inc(PStr);
    end;
  Result := 0;
end;

procedure Filler3;
asm
  nop
end;

function StrLComp_JOH_PAS_1_d(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
var
  Ch         : Char;
  Offset     : Integer;
  PStr, PEnd : PChar;
begin;
  PStr   := Str1;
  PEnd   := PStr + MaxLen;
  Offset := Str2 - PStr;
  while PStr <> PEnd do
    begin
      Ch := PStr[Offset];
      if (Ch = #0) or (Ch <> PStr^) then
        begin
          Result := Integer(PStr^) - Integer(Ch);
          Exit;
        end;
      Inc(PStr);
    end;
  Result := 0;
end;


{RTL Candidate - 35 Bytes}

function StrLComp_JOH_IA32_1_a(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
asm
  push  ebx
  sub   eax, edx             {Difference between Str1 and Str2}
  jz    @@Exit               {Exit if Str1 = Str2}
  add   ecx, edx             {Last Check Position}
@@Loop:
  cmp   ecx, edx             {Last Check Position Reached}
  je    @@Zero               {Yes - Return 0}
  movzx ebx, [eax+edx]       {Next Char of Str1}
  cmp   bl, [edx]            {Compare with Next Char of Str2}
  jne   @@SetResult          {Exit Loop if Different}
  inc   edx                  {Prepare for Next Loop}
  test  bl, bl               {Both Chars Null Terminators?}
  jnz   @@Loop               {No - Repeat Loop}
@@Zero:
  xor   eax, eax         
  pop   ebx
  ret                        {Exit with Result = 0}
@@SetResult:                 {Difference Found}
  sbb   eax, eax             { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1                {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
  pop   ebx
end;

function StrLComp_JOH_IA32_1_b(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
asm
  push  ebx
  sub   eax, edx             {Difference between Str1 and Str2}
  jz    @@Exit               {Exit if Str1 = Str2}
  add   ecx, edx             {Last Check Position}
@@Loop:
  cmp   ecx, edx             {Last Check Position Reached}
  je    @@Zero               {Yes - Return 0}
  movzx ebx, [eax+edx]       {Next Char of Str1}
  cmp   bl, [edx]            {Compare with Next Char of Str2}
  jne   @@SetResult          {Exit Loop if Different}
  inc   edx                  {Prepare for Next Loop}
  test  bl, bl               {Both Chars Null Terminators?}
  jnz   @@Loop               {No - Repeat Loop}
@@Zero:
  xor   eax, eax         
  pop   ebx
  ret                        {Exit with Result = 0}
@@SetResult:                 {Difference Found}
  sbb   eax, eax             { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1                {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
  pop   ebx
end;

function StrLComp_JOH_IA32_1_c(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
asm
  push  ebx
  sub   eax, edx             {Difference between Str1 and Str2}
  jz    @@Exit               {Exit if Str1 = Str2}
  add   ecx, edx             {Last Check Position}
@@Loop:
  cmp   ecx, edx             {Last Check Position Reached}
  je    @@Zero               {Yes - Return 0}
  movzx ebx, [eax+edx]       {Next Char of Str1}
  cmp   bl, [edx]            {Compare with Next Char of Str2}
  jne   @@SetResult          {Exit Loop if Different}
  inc   edx                  {Prepare for Next Loop}
  test  bl, bl               {Both Chars Null Terminators?}
  jnz   @@Loop               {No - Repeat Loop}
@@Zero:
  xor   eax, eax         
  pop   ebx
  ret                        {Exit with Result = 0}
@@SetResult:                 {Difference Found}
  sbb   eax, eax             { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1                {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
  pop   ebx
end;

function StrLComp_JOH_IA32_1_d(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
asm
  push  ebx
  sub   eax, edx             {Difference between Str1 and Str2}
  jz    @@Exit               {Exit if Str1 = Str2}
  add   ecx, edx             {Last Check Position}
@@Loop:
  cmp   ecx, edx             {Last Check Position Reached}
  je    @@Zero               {Yes - Return 0}
  movzx ebx, [eax+edx]       {Next Char of Str1}
  cmp   bl, [edx]            {Compare with Next Char of Str2}
  jne   @@SetResult          {Exit Loop if Different}
  inc   edx                  {Prepare for Next Loop}
  test  bl, bl               {Both Chars Null Terminators?}
  jnz   @@Loop               {No - Repeat Loop}
@@Zero:
  xor   eax, eax         
  pop   ebx
  ret                        {Exit with Result = 0}
@@SetResult:                 {Difference Found}
  sbb   eax, eax             { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1                {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
  pop   ebx
end;

initialization

  Filler1;
  Filler2;
  Filler3;

end.
