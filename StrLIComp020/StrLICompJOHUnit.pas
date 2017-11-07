unit StrLICompJOHUnit;

interface

function StrLIComp_JOH_PAS_1_a(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function StrLIComp_JOH_PAS_1_b(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function StrLIComp_JOH_PAS_1_c(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function StrLIComp_JOH_PAS_1_d(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;

function StrLIComp_JOH_IA32_1_a(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function StrLIComp_JOH_IA32_1_b(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function StrLIComp_JOH_IA32_1_c(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function StrLIComp_JOH_IA32_1_d(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;

function StrLIComp_JOH_IA32_2_a(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function StrLIComp_JOH_IA32_2_b(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function StrLIComp_JOH_IA32_2_c(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
function StrLIComp_JOH_IA32_2_d(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;

implementation

var
  Upper: array[Char] of Char;

function StrLIComp_JOH_PAS_1_a(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
var
  Ch1, Ch2   : Char;
  Offset     : Integer;
  PStr, PEnd : PChar;
begin;
  PStr   := Str1;
  PEnd   := PStr + MaxLen;
  Offset := Str2 - PStr;
  while PStr <> PEnd do
    begin
      Ch1 := Upper[PStr^];
      Ch2 := Upper[PStr[Offset]];
      if (Ch1 = #0) or (Ch1 <> Ch2) then
        begin
          Result := Integer(Ch1) - Integer(Ch2);
          Exit;
        end;
      Inc(PStr);
    end;
  Result := 0;
end;

function StrLIComp_JOH_PAS_1_b(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
var
  Ch1, Ch2   : Char;
  Offset     : Integer;
  PStr, PEnd : PChar;
begin;
  PStr   := Str1;
  PEnd   := PStr + MaxLen;
  Offset := Str2 - PStr;
  while PStr <> PEnd do
    begin
      Ch1 := Upper[PStr^];
      Ch2 := Upper[PStr[Offset]];
      if (Ch1 = #0) or (Ch1 <> Ch2) then
        begin
          Result := Integer(Ch1) - Integer(Ch2);
          Exit;
        end;
      Inc(PStr);
    end;
  Result := 0;
end;

function StrLIComp_JOH_PAS_1_c(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
var
  Ch1, Ch2   : Char;
  Offset     : Integer;
  PStr, PEnd : PChar;
begin;
  PStr   := Str1;
  PEnd   := PStr + MaxLen;
  Offset := Str2 - PStr;
  while PStr <> PEnd do
    begin
      Ch1 := Upper[PStr^];
      Ch2 := Upper[PStr[Offset]];
      if (Ch1 = #0) or (Ch1 <> Ch2) then
        begin
          Result := Integer(Ch1) - Integer(Ch2);
          Exit;
        end;
      Inc(PStr);
    end;
  Result := 0;
end;

function StrLIComp_JOH_PAS_1_d(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
var
  Ch1, Ch2   : Char;
  Offset     : Integer;
  PStr, PEnd : PChar;
begin;
  PStr   := Str1;
  PEnd   := PStr + MaxLen;
  Offset := Str2 - PStr;
  while PStr <> PEnd do
    begin
      Ch1 := Upper[PStr^];
      Ch2 := Upper[PStr[Offset]];
      if (Ch1 = #0) or (Ch1 <> Ch2) then
        begin
          Result := Integer(Ch1) - Integer(Ch2);
          Exit;
        end;
      Inc(PStr);
    end;
  Result := 0;
end;

{RTL Candidate - 70 Bytes}

function StrLIComp_JOH_IA32_1_a(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
asm
  push  ebx
  sub   eax, edx       {Difference between Str1 and Str2}
  jz    @@Exit         {Exit if Str1 = Str2}
  add   ecx, edx       {Last Check Position}
@@Loop:
  cmp   ecx, edx       {Last Check Position Reached}
  je    @@Zero         {Yes - Return 0}
  movzx ebx, [eax+edx] {Next Char of Str1}
  cmp   bl, [edx]      {Compare with Next Char of Str2}
  je    @@Same         {Same - Skip Uppercase conversion}
  add   bl, $9f        {Convert 1st Char to Uppercase}
  cmp   bl, $1a
  jnb   @@1
  sub   bl, $20
@@1:
  sub   bl, $9f        {Uppercase 1st Char}
  mov   bh, [edx]      {Next Char of Str2}
  add   bh, $9f        {Convert 1st Char to Uppercase}
  cmp   bh, $1a
  jnb   @@2
  sub   bh, $20
@@2:
  sub   bh, $9f        {Uppercase 2nd Char}
  cmp   bl, bh
  jne   @@SetResult    {Set Result if Different}
@@Same:
  add   edx, 1         {Prepare for Next Loop}
  test  bl, bl         {Both Chars Null Terminators?}
  jnz   @@Loop         {No - Repeat Loop}
@@Zero:
  xor   eax, eax
  pop   ebx
  ret                  {Exit with Result = 0}
@@SetResult:           {Difference Found}
  sbb   eax, eax       { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1          {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
  pop   ebx
end;

function StrLIComp_JOH_IA32_1_b(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
asm
  push  ebx
  sub   eax, edx       {Difference between Str1 and Str2}
  jz    @@Exit         {Exit if Str1 = Str2}
  add   ecx, edx       {Last Check Position}
@@Loop:
  cmp   ecx, edx       {Last Check Position Reached}
  je    @@Zero         {Yes - Return 0}
  movzx ebx, [eax+edx] {Next Char of Str1}
  cmp   bl, [edx]      {Compare with Next Char of Str2}
  je    @@Same         {Same - Skip Uppercase conversion}
  add   bl, $9f        {Convert 1st Char to Uppercase}
  cmp   bl, $1a
  jnb   @@1
  sub   bl, $20
@@1:
  sub   bl, $9f        {Uppercase 1st Char}
  mov   bh, [edx]      {Next Char of Str2}
  add   bh, $9f        {Convert 1st Char to Uppercase}
  cmp   bh, $1a
  jnb   @@2
  sub   bh, $20
@@2:
  sub   bh, $9f        {Uppercase 2nd Char}
  cmp   bl, bh
  jne   @@SetResult    {Set Result if Different}
@@Same:
  add   edx, 1         {Prepare for Next Loop}
  test  bl, bl         {Both Chars Null Terminators?}
  jnz   @@Loop         {No - Repeat Loop}
@@Zero:
  xor   eax, eax
  pop   ebx
  ret                  {Exit with Result = 0}
@@SetResult:           {Difference Found}
  sbb   eax, eax       { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1          {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
  pop   ebx
end;

procedure Filler1;
asm
  nop
end;

function StrLIComp_JOH_IA32_1_c(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
asm
  push  ebx
  sub   eax, edx       {Difference between Str1 and Str2}
  jz    @@Exit         {Exit if Str1 = Str2}
  add   ecx, edx       {Last Check Position}
@@Loop:
  cmp   ecx, edx       {Last Check Position Reached}
  je    @@Zero         {Yes - Return 0}
  movzx ebx, [eax+edx] {Next Char of Str1}
  cmp   bl, [edx]      {Compare with Next Char of Str2}
  je    @@Same         {Same - Skip Uppercase conversion}
  add   bl, $9f        {Convert 1st Char to Uppercase}
  cmp   bl, $1a
  jnb   @@1
  sub   bl, $20
@@1:
  sub   bl, $9f        {Uppercase 1st Char}
  mov   bh, [edx]      {Next Char of Str2}
  add   bh, $9f        {Convert 1st Char to Uppercase}
  cmp   bh, $1a
  jnb   @@2
  sub   bh, $20
@@2:
  sub   bh, $9f        {Uppercase 2nd Char}
  cmp   bl, bh
  jne   @@SetResult    {Set Result if Different}
@@Same:
  add   edx, 1         {Prepare for Next Loop}
  test  bl, bl         {Both Chars Null Terminators?}
  jnz   @@Loop         {No - Repeat Loop}
@@Zero:
  xor   eax, eax
  pop   ebx
  ret                  {Exit with Result = 0}
@@SetResult:           {Difference Found}
  sbb   eax, eax       { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1          {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
  pop   ebx
end;

function StrLIComp_JOH_IA32_1_d(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
asm
  push  ebx
  sub   eax, edx       {Difference between Str1 and Str2}
  jz    @@Exit         {Exit if Str1 = Str2}
  add   ecx, edx       {Last Check Position}
@@Loop:
  cmp   ecx, edx       {Last Check Position Reached}
  je    @@Zero         {Yes - Return 0}
  movzx ebx, [eax+edx] {Next Char of Str1}
  cmp   bl, [edx]      {Compare with Next Char of Str2}
  je    @@Same         {Same - Skip Uppercase conversion}
  add   bl, $9f        {Convert 1st Char to Uppercase}
  cmp   bl, $1a
  jnb   @@1
  sub   bl, $20
@@1:
  sub   bl, $9f        {Uppercase 1st Char}
  mov   bh, [edx]      {Next Char of Str2}
  add   bh, $9f        {Convert 1st Char to Uppercase}
  cmp   bh, $1a
  jnb   @@2
  sub   bh, $20
@@2:
  sub   bh, $9f        {Uppercase 2nd Char}
  cmp   bl, bh
  jne   @@SetResult    {Set Result if Different}
@@Same:
  add   edx, 1         {Prepare for Next Loop}
  test  bl, bl         {Both Chars Null Terminators?}
  jnz   @@Loop         {No - Repeat Loop}
@@Zero:
  xor   eax, eax
  pop   ebx
  ret                  {Exit with Result = 0}
@@SetResult:           {Difference Found}
  sbb   eax, eax       { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1          {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
  pop   ebx
end;

function StrLIComp_JOH_IA32_2_a(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
asm
  push  ebx
  push  edi
  sub   eax, edx         {Difference between Str1 and Str2}
  jz    @@Exit           {Exit if Str1 = Str2}
  add   ecx, edx         {Last Check Position}
  mov   edi, eax
@@Loop:
  cmp   ecx, edx         {Last Check Position Reached}
  je    @@Zero           {Yes - Return 0}
  movzx eax, [edi+edx]   {Next Char of Str1}
  movzx ebx, [edx]
  cmp   al, bl           {Compare with Next Char of Str2}
  je    @@Same           {Same - Skip Uppercase conversion}
  movzx eax, [eax+upper] {Uppercase Char1}
  movzx ebx, [ebx+upper] {Uppercase Char2}
  cmp   al, bl           {Compare Uppercase Characters}
  jne   @@SetResult      {Set Result if Different}
@@Same:
  add   edx, 1           {Prepare for Next Loop}
  test  bl, bl           {Both Chars Null Terminators?}
  jnz   @@Loop           {No - Repeat Loop}
@@Zero:
  xor   eax, eax
  pop   edi
  pop   ebx
  ret                    {Exit with Result = 0}
@@SetResult:             {Difference Found}
  sbb   eax, eax         { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1            {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
  pop   edi
  pop   ebx
end;

procedure Filler2;
asm
  nop
end;

function StrLIComp_JOH_IA32_2_b(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
asm
  push  ebx
  push  edi
  sub   eax, edx         {Difference between Str1 and Str2}
  jz    @@Exit           {Exit if Str1 = Str2}
  add   ecx, edx         {Last Check Position}
  mov   edi, eax
@@Loop:
  cmp   ecx, edx         {Last Check Position Reached}
  je    @@Zero           {Yes - Return 0}
  movzx eax, [edi+edx]   {Next Char of Str1}
  movzx ebx, [edx]
  cmp   al, bl           {Compare with Next Char of Str2}
  je    @@Same           {Same - Skip Uppercase conversion}
  movzx eax, [eax+upper] {Uppercase Char1}
  movzx ebx, [ebx+upper] {Uppercase Char2}
  cmp   al, bl           {Compare Uppercase Characters}
  jne   @@SetResult      {Set Result if Different}
@@Same:
  add   edx, 1           {Prepare for Next Loop}
  test  bl, bl           {Both Chars Null Terminators?}
  jnz   @@Loop           {No - Repeat Loop}
@@Zero:
  xor   eax, eax
  pop   edi
  pop   ebx
  ret                    {Exit with Result = 0}
@@SetResult:             {Difference Found}
  sbb   eax, eax         { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1            {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
  pop   edi
  pop   ebx
end;

procedure Filler3;
asm
  nop
end;

function StrLIComp_JOH_IA32_2_c(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
asm
  push  ebx
  push  edi
  sub   eax, edx         {Difference between Str1 and Str2}
  jz    @@Exit           {Exit if Str1 = Str2}
  add   ecx, edx         {Last Check Position}
  mov   edi, eax
@@Loop:
  cmp   ecx, edx         {Last Check Position Reached}
  je    @@Zero           {Yes - Return 0}
  movzx eax, [edi+edx]   {Next Char of Str1}
  movzx ebx, [edx]
  cmp   al, bl           {Compare with Next Char of Str2}
  je    @@Same           {Same - Skip Uppercase conversion}
  movzx eax, [eax+upper] {Uppercase Char1}
  movzx ebx, [ebx+upper] {Uppercase Char2}
  cmp   al, bl           {Compare Uppercase Characters}
  jne   @@SetResult      {Set Result if Different}
@@Same:
  add   edx, 1           {Prepare for Next Loop}
  test  bl, bl           {Both Chars Null Terminators?}
  jnz   @@Loop           {No - Repeat Loop}
@@Zero:
  xor   eax, eax
  pop   edi
  pop   ebx
  ret                    {Exit with Result = 0}
@@SetResult:             {Difference Found}
  sbb   eax, eax         { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1            {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
  pop   edi
  pop   ebx
end;

procedure Filler4;
asm
  nop
end;

function StrLIComp_JOH_IA32_2_d(const Str1, Str2: PChar; MaxLen: Cardinal): Integer;
asm
  push  ebx
  push  edi
  sub   eax, edx         {Difference between Str1 and Str2}
  jz    @@Exit           {Exit if Str1 = Str2}
  add   ecx, edx         {Last Check Position}
  mov   edi, eax
@@Loop:
  cmp   ecx, edx         {Last Check Position Reached}
  je    @@Zero           {Yes - Return 0}
  movzx eax, [edi+edx]   {Next Char of Str1}
  movzx ebx, [edx]
  cmp   al, bl           {Compare with Next Char of Str2}
  je    @@Same           {Same - Skip Uppercase conversion}
  movzx eax, [eax+upper] {Uppercase Char1}
  movzx ebx, [ebx+upper] {Uppercase Char2}
  cmp   al, bl           {Compare Uppercase Characters}
  jne   @@SetResult      {Set Result if Different}
@@Same:
  add   edx, 1           {Prepare for Next Loop}
  test  bl, bl           {Both Chars Null Terminators?}
  jnz   @@Loop           {No - Repeat Loop}
@@Zero:
  xor   eax, eax
  pop   edi
  pop   ebx
  ret                    {Exit with Result = 0}
@@SetResult:             {Difference Found}
  sbb   eax, eax         { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1            {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
  pop   edi
  pop   ebx
end;

var
  Ch : Char;
initialization
  for Ch := #0 to #255 do
    Upper[Ch] := Upcase(Ch);
  Filler1;
  Filler2;
  Filler3;
  Filler4;
end.
