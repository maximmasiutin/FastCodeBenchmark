unit StrICompJOHUnit;

interface

function StrIComp_JOH_PAS_1_a(const Str1, Str2: PChar): Integer;
function StrIComp_JOH_PAS_1_b(const Str1, Str2: PChar): Integer;
function StrIComp_JOH_PAS_1_c(const Str1, Str2: PChar): Integer;
function StrIComp_JOH_PAS_1_d(const Str1, Str2: PChar): Integer;

function StrIComp_JOH_IA32_1_a(const Str1, Str2: PChar): Integer;
function StrIComp_JOH_IA32_1_b(const Str1, Str2: PChar): Integer;
function StrIComp_JOH_IA32_1_c(const Str1, Str2: PChar): Integer;
function StrIComp_JOH_IA32_1_d(const Str1, Str2: PChar): Integer;

function StrIComp_JOH_IA32_2_a(const Str1, Str2: PChar): Integer;
function StrIComp_JOH_IA32_2_b(const Str1, Str2: PChar): Integer;
function StrIComp_JOH_IA32_2_c(const Str1, Str2: PChar): Integer;
function StrIComp_JOH_IA32_2_d(const Str1, Str2: PChar): Integer;

function StrIComp_JOH_IA32_3_a(const Str1, Str2: PChar): Integer;
function StrIComp_JOH_IA32_3_b(const Str1, Str2: PChar): Integer;
function StrIComp_JOH_IA32_3_c(const Str1, Str2: PChar): Integer;
function StrIComp_JOH_IA32_3_d(const Str1, Str2: PChar): Integer;

function StrIComp_JOH_IA32_4_a(const Str1, Str2: PChar): Integer;
function StrIComp_JOH_IA32_4_b(const Str1, Str2: PChar): Integer;
function StrIComp_JOH_IA32_4_c(const Str1, Str2: PChar): Integer;
function StrIComp_JOH_IA32_4_d(const Str1, Str2: PChar): Integer;

implementation

uses
 SysUtils;

const
  Upper: array[Char] of Char =
    (#$00,#$01,#$02,#$03,#$04,#$05,#$06,#$07,#$08,#$09,#$0A,#$0B,#$0C,#$0D,#$0E,#$0F,
     #$10,#$11,#$12,#$13,#$14,#$15,#$16,#$17,#$18,#$19,#$1A,#$1B,#$1C,#$1D,#$1E,#$1F,
     #$20,#$21,#$22,#$23,#$24,#$25,#$26,#$27,#$28,#$29,#$2A,#$2B,#$2C,#$2D,#$2E,#$2F,
     #$30,#$31,#$32,#$33,#$34,#$35,#$36,#$37,#$38,#$39,#$3A,#$3B,#$3C,#$3D,#$3E,#$3F,
     #$40,#$41,#$42,#$43,#$44,#$45,#$46,#$47,#$48,#$49,#$4A,#$4B,#$4C,#$4D,#$4E,#$4F,
     #$50,#$51,#$52,#$53,#$54,#$55,#$56,#$57,#$58,#$59,#$5A,#$5B,#$5C,#$5D,#$5E,#$5F,
     #$60,#$41,#$42,#$43,#$44,#$45,#$46,#$47,#$48,#$49,#$4A,#$4B,#$4C,#$4D,#$4E,#$4F,
     #$50,#$51,#$52,#$53,#$54,#$55,#$56,#$57,#$58,#$59,#$5A,#$7B,#$7C,#$7D,#$7E,#$7F,
     #$80,#$81,#$82,#$83,#$84,#$85,#$86,#$87,#$88,#$89,#$8A,#$8B,#$8C,#$8D,#$8E,#$8F,
     #$90,#$91,#$92,#$93,#$94,#$95,#$96,#$97,#$98,#$99,#$9A,#$9B,#$9C,#$9D,#$9E,#$9F,
     #$A0,#$A1,#$A2,#$A3,#$A4,#$A5,#$A6,#$A7,#$A8,#$A9,#$AA,#$AB,#$AC,#$AD,#$AE,#$AF,
     #$B0,#$B1,#$B2,#$B3,#$B4,#$B5,#$B6,#$B7,#$B8,#$B9,#$BA,#$BB,#$BC,#$BD,#$BE,#$BF,
     #$C0,#$C1,#$C2,#$C3,#$C4,#$C5,#$C6,#$C7,#$C8,#$C9,#$CA,#$CB,#$CC,#$CD,#$CE,#$CF,
     #$D0,#$D1,#$D2,#$D3,#$D4,#$D5,#$D6,#$D7,#$D8,#$D9,#$DA,#$DB,#$DC,#$DD,#$DE,#$DF,
     #$E0,#$E1,#$E2,#$E3,#$E4,#$E5,#$E6,#$E7,#$E8,#$E9,#$EA,#$EB,#$EC,#$ED,#$EE,#$EF,
     #$F0,#$F1,#$F2,#$F3,#$F4,#$F5,#$F6,#$F7,#$F8,#$F9,#$FA,#$FB,#$FC,#$FD,#$FE,#$FF);

function StrIComp_JOH_PAS_1_a(const Str1, Str2: PChar): Integer;
var
  Ch1, Ch2 : Char;
  Offset   : Integer;
  PStr     : PChar;
begin;
  PStr   := Str1;
  Offset := Str2 - PStr;
  repeat
    Ch1 := Upper[PStr^];
    Ch2 := Upper[PStr[Offset]];
    if (Ch1 = #0) or (Ch1 <> Ch2) then
      Break;
    Inc(PStr);
  until False;
  Result := Integer(Ch1) - Integer(Ch2);
end;

procedure Filler1;
asm
  nop
end;

function StrIComp_JOH_PAS_1_b(const Str1, Str2: PChar): Integer;
var
  Ch1, Ch2 : Char;
  Offset   : Integer;
  PStr     : PChar;
begin;
  PStr   := Str1;
  Offset := Str2 - PStr;
  repeat
    Ch1 := Upper[PStr^];
    Ch2 := Upper[PStr[Offset]];
    if (Ch1 = #0) or (Ch1 <> Ch2) then
      Break;
    Inc(PStr);
  until False;
  Result := Integer(Ch1) - Integer(Ch2);
end;

procedure Filler2;
asm
  nop
end;

function StrIComp_JOH_PAS_1_c(const Str1, Str2: PChar): Integer;
var
  Ch1, Ch2 : Char;
  Offset   : Integer;
  PStr     : PChar;
begin;
  PStr   := Str1;
  Offset := Str2 - PStr;
  repeat
    Ch1 := Upper[PStr^];
    Ch2 := Upper[PStr[Offset]];
    if (Ch1 = #0) or (Ch1 <> Ch2) then
      Break;
    Inc(PStr);
  until False;
  Result := Integer(Ch1) - Integer(Ch2);
end;

procedure Filler3;
asm
  nop
end;

function StrIComp_JOH_PAS_1_d(const Str1, Str2: PChar): Integer;
var
  Ch1, Ch2 : Char;
  Offset   : Integer;
  PStr     : PChar;
begin;
  PStr   := Str1;
  Offset := Str2 - PStr;
  repeat
    Ch1 := Upper[PStr^];
    Ch2 := Upper[PStr[Offset]];
    if (Ch1 = #0) or (Ch1 <> Ch2) then
      Break;
    Inc(PStr);
  until False;
  Result := Integer(Ch1) - Integer(Ch2);
end;

{RTL Candidate - 56 Bytes}

function StrIComp_JOH_IA32_1_a(const Str1, Str2: PChar): Integer;
asm
  sub   eax, edx       {Difference between Str1 and Str2}
  jz    @@Exit         {Str1}
  mov   ecx, eax       {Exit if Str1 = Str2}
@@Loop:
  movzx eax, [ecx+edx] {Next Char of Str1}
  cmp   al, [edx]      {Compare with Next Char of Str2}
  je    @@Same         {Same - Skip Uppercase conversion}
  add   al, $9f        {Convert 1st Char to Uppercase}
  cmp   al, $1a
  jnb   @@1
  sub   al, $20
@@1:
  sub   al, $9f        {Uppercase 1st Char}
  mov   ah, [edx]      {Next Char of Str2}
  add   ah, $9f        {Convert 1st Char to Uppercase}
  cmp   ah, $1a
  jnb   @@2
  sub   ah, $20
@@2:
  sub   ah, $9f        {Uppercase 2nd Char}
  cmp   al, ah         {Compare Uppercase Characters}
  jne   @@SetResult    {Set Result if Different}
@@Same:
  add   edx, 1         {Prepare for Next Loop}
  test  al, al         {Both Chars Null Terminators?}
  jnz   @@Loop         {No - Repeat Loop}
  ret                  {Exit with Result = 0}
@@SetResult:
  sbb   eax, eax       { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1          {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
end;

function StrIComp_JOH_IA32_1_b(const Str1, Str2: PChar): Integer;
asm
  sub   eax, edx       {Difference between Str1 and Str2}
  jz    @@Exit         {Str1}
  mov   ecx, eax       {Exit if Str1 = Str2}
@@Loop:
  movzx eax, [ecx+edx] {Next Char of Str1}
  cmp   al, [edx]      {Compare with Next Char of Str2}
  je    @@Same         {Same - Skip Uppercase conversion}
  add   al, $9f        {Convert 1st Char to Uppercase}
  cmp   al, $1a
  jnb   @@1
  sub   al, $20
@@1:
  sub   al, $9f        {Uppercase 1st Char}
  mov   ah, [edx]      {Next Char of Str2}
  add   ah, $9f        {Convert 1st Char to Uppercase}
  cmp   ah, $1a
  jnb   @@2
  sub   ah, $20
@@2:
  sub   ah, $9f        {Uppercase 2nd Char}
  cmp   al, ah         {Compare Uppercase Characters}
  jne   @@SetResult    {Set Result if Different}
@@Same:
  add   edx, 1         {Prepare for Next Loop}
  test  al, al         {Both Chars Null Terminators?}
  jnz   @@Loop         {No - Repeat Loop}
  ret                  {Exit with Result = 0}
@@SetResult:
  sbb   eax, eax       { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1          {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
end;

function StrIComp_JOH_IA32_1_c(const Str1, Str2: PChar): Integer;
asm
  sub   eax, edx       {Difference between Str1 and Str2}
  jz    @@Exit         {Str1}
  mov   ecx, eax       {Exit if Str1 = Str2}
@@Loop:
  movzx eax, [ecx+edx] {Next Char of Str1}
  cmp   al, [edx]      {Compare with Next Char of Str2}
  je    @@Same         {Same - Skip Uppercase conversion}
  add   al, $9f        {Convert 1st Char to Uppercase}
  cmp   al, $1a
  jnb   @@1
  sub   al, $20
@@1:
  sub   al, $9f        {Uppercase 1st Char}
  mov   ah, [edx]      {Next Char of Str2}
  add   ah, $9f        {Convert 1st Char to Uppercase}
  cmp   ah, $1a
  jnb   @@2
  sub   ah, $20
@@2:
  sub   ah, $9f        {Uppercase 2nd Char}
  cmp   al, ah         {Compare Uppercase Characters}
  jne   @@SetResult    {Set Result if Different}
@@Same:
  add   edx, 1         {Prepare for Next Loop}
  test  al, al         {Both Chars Null Terminators?}
  jnz   @@Loop         {No - Repeat Loop}
  ret                  {Exit with Result = 0}
@@SetResult:
  sbb   eax, eax       { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1          {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
end;

function StrIComp_JOH_IA32_1_d(const Str1, Str2: PChar): Integer;
asm
  sub   eax, edx       {Difference between Str1 and Str2}
  jz    @@Exit         {Str1}
  mov   ecx, eax       {Exit if Str1 = Str2}
@@Loop:
  movzx eax, [ecx+edx] {Next Char of Str1}
  cmp   al, [edx]      {Compare with Next Char of Str2}
  je    @@Same         {Same - Skip Uppercase conversion}
  add   al, $9f        {Convert 1st Char to Uppercase}
  cmp   al, $1a
  jnb   @@1
  sub   al, $20
@@1:
  sub   al, $9f        {Uppercase 1st Char}
  mov   ah, [edx]      {Next Char of Str2}
  add   ah, $9f        {Convert 1st Char to Uppercase}
  cmp   ah, $1a
  jnb   @@2
  sub   ah, $20
@@2:
  sub   ah, $9f        {Uppercase 2nd Char}
  cmp   al, ah         {Compare Uppercase Characters}
  jne   @@SetResult    {Set Result if Different}
@@Same:
  add   edx, 1         {Prepare for Next Loop}
  test  al, al         {Both Chars Null Terminators?}
  jnz   @@Loop         {No - Repeat Loop}
  ret                  {Exit with Result = 0}
@@SetResult:
  sbb   eax, eax       { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1          {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
end;

function StrIComp_JOH_IA32_2_a(const Str1, Str2: PChar): Integer;
asm
  push  ebx
  sub   eax, edx         {Difference between Str1 and Str2}
  jz    @@Exit           {Str1}
  mov   ebx, eax         {Exit if Str1 = Str2}
@@Loop:
  movzx eax, [ebx+edx]   {Next Char of Str1}
  movzx ecx, [edx]
  cmp   al, cl           {Compare with Next Char of Str2}
  je    @@Same           {Same - Skip Uppercase conversion}
  movzx eax, [eax+upper] {Uppercase Char1}
  movzx ecx, [ecx+upper] {Uppercase Char2}
  cmp   al, cl           {Compare Uppercase Characters}
  jne   @@SetResult      {Set Result if Different}
@@Same:
  add   edx, 1           {Prepare for Next Loop}
  test  al, al           {Both Chars Null Terminators?}
  jnz   @@Loop           {No - Repeat Loop}
  pop   ebx
  ret                    {Exit with Result = 0}
@@SetResult:
  sbb   eax, eax         { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1            {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
  pop   ebx
end;

function StrIComp_JOH_IA32_2_b(const Str1, Str2: PChar): Integer;
asm
  push  ebx
  sub   eax, edx         {Difference between Str1 and Str2}
  jz    @@Exit           {Str1}
  mov   ebx, eax         {Exit if Str1 = Str2}
@@Loop:
  movzx eax, [ebx+edx]   {Next Char of Str1}
  movzx ecx, [edx]
  cmp   al, cl           {Compare with Next Char of Str2}
  je    @@Same           {Same - Skip Uppercase conversion}
  movzx eax, [eax+upper] {Uppercase Char1}
  movzx ecx, [ecx+upper] {Uppercase Char2}
  cmp   al, cl           {Compare Uppercase Characters}
  jne   @@SetResult      {Set Result if Different}
@@Same:
  add   edx, 1           {Prepare for Next Loop}
  test  al, al           {Both Chars Null Terminators?}
  jnz   @@Loop           {No - Repeat Loop}
  pop   ebx
  ret                    {Exit with Result = 0}
@@SetResult:
  sbb   eax, eax         { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1            {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
  pop   ebx
end;

function StrIComp_JOH_IA32_2_c(const Str1, Str2: PChar): Integer;
asm
  push  ebx
  sub   eax, edx         {Difference between Str1 and Str2}
  jz    @@Exit           {Str1}
  mov   ebx, eax         {Exit if Str1 = Str2}
@@Loop:
  movzx eax, [ebx+edx]   {Next Char of Str1}
  movzx ecx, [edx]
  cmp   al, cl           {Compare with Next Char of Str2}
  je    @@Same           {Same - Skip Uppercase conversion}
  movzx eax, [eax+upper] {Uppercase Char1}
  movzx ecx, [ecx+upper] {Uppercase Char2}
  cmp   al, cl           {Compare Uppercase Characters}
  jne   @@SetResult      {Set Result if Different}
@@Same:
  add   edx, 1           {Prepare for Next Loop}
  test  al, al           {Both Chars Null Terminators?}
  jnz   @@Loop           {No - Repeat Loop}
  pop   ebx
  ret                    {Exit with Result = 0}
@@SetResult:
  sbb   eax, eax         { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1            {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
  pop   ebx
end;

function StrIComp_JOH_IA32_2_d(const Str1, Str2: PChar): Integer;
asm
  push  ebx
  sub   eax, edx         {Difference between Str1 and Str2}
  jz    @@Exit           {Str1}
  mov   ebx, eax         {Exit if Str1 = Str2}
@@Loop:
  movzx eax, [ebx+edx]   {Next Char of Str1}
  movzx ecx, [edx]
  cmp   al, cl           {Compare with Next Char of Str2}
  je    @@Same           {Same - Skip Uppercase conversion}
  movzx eax, [eax+upper] {Uppercase Char1}
  movzx ecx, [ecx+upper] {Uppercase Char2}
  cmp   al, cl           {Compare Uppercase Characters}
  jne   @@SetResult      {Set Result if Different}
@@Same:
  add   edx, 1           {Prepare for Next Loop}
  test  al, al           {Both Chars Null Terminators?}
  jnz   @@Loop           {No - Repeat Loop}
  pop   ebx
  ret                    {Exit with Result = 0}
@@SetResult:
  sbb   eax, eax         { 0 if Str1 > Str2, -1 if Str1 < Str2}
  or    al, 1            {+1 if Str1 > Str2, -1 if Str1 < Str2}
@@Exit:
  pop   ebx
end;

{RTL Candidate - 53 Bytes}

function StrIComp_JOH_IA32_3_a(const Str1, Str2: PChar): Integer;
asm
  push  ebx
  sub   eax, edx   
  mov   ecx, eax       {Difference between Str1 and Str2}
@@Check:                         
  test  eax, eax
  jz    @@Exit         {End Reached - Return 0}
@@Loop:
  movzx eax, [ecx+edx] {Next Char of Str1}
  movzx ebx, [edx]     {Next Char of Str2}
  inc   edx            {Prepare for Next Loop}
  cmp   eax, ebx       {Compare Chars}
  je    @@Check        {Same - Skip Uppercase Check}
  add   eax, $9f       {Convert 1st Char}
  add   ebx, $9f       {Convert 2nd Char}
  cmp   al, $1a
  jnb   @@1
  sub   eax, $20
@@1:
  cmp   bl, $1a
  jnb   @@2
  sub   ebx, $20
@@2:
  sub   eax, ebx       {Compare Converted Characters}
  je    @@Loop         {Loop until Different}
@@Exit:
  pop   ebx
end;

function StrIComp_JOH_IA32_3_b(const Str1, Str2: PChar): Integer;
asm
  push  ebx
  sub   eax, edx   
  mov   ecx, eax       {Difference between Str1 and Str2}
@@Check:
  test  eax, eax
  jz    @@Exit         {End Reached - Return 0}
@@Loop:
  movzx eax, [ecx+edx] {Next Char of Str1}
  movzx ebx, [edx]     {Next Char of Str2}
  inc   edx            {Prepare for Next Loop}
  cmp   eax, ebx       {Compare Chars}
  je    @@Check        {Same - Skip Uppercase Check}
  add   eax, $9f       {Convert 1st Char}
  add   ebx, $9f       {Convert 2nd Char}
  cmp   al, $1a
  jnb   @@1
  sub   eax, $20
@@1:
  cmp   bl, $1a
  jnb   @@2
  sub   ebx, $20
@@2:
  sub   eax, ebx       {Compare Converted Characters}
  je    @@Loop         {Loop until Different}
@@Exit:
  pop   ebx
end;

procedure Filler4;
asm
  nop
end;

function StrIComp_JOH_IA32_3_c(const Str1, Str2: PChar): Integer;
asm
  push  ebx
  sub   eax, edx   
  mov   ecx, eax       {Difference between Str1 and Str2}
@@Check:
  test  eax, eax
  jz    @@Exit         {End Reached - Return 0}
@@Loop:
  movzx eax, [ecx+edx] {Next Char of Str1}
  movzx ebx, [edx]     {Next Char of Str2}
  inc   edx            {Prepare for Next Loop}
  cmp   eax, ebx       {Compare Chars}
  je    @@Check        {Same - Skip Uppercase Check}
  add   eax, $9f       {Convert 1st Char}
  add   ebx, $9f       {Convert 2nd Char}
  cmp   al, $1a
  jnb   @@1
  sub   eax, $20
@@1:
  cmp   bl, $1a
  jnb   @@2
  sub   ebx, $20
@@2:
  sub   eax, ebx       {Compare Converted Characters}
  je    @@Loop         {Loop until Different}
@@Exit:
  pop   ebx
end;

function StrIComp_JOH_IA32_3_d(const Str1, Str2: PChar): Integer;
asm
  push  ebx
  sub   eax, edx   
  mov   ecx, eax       {Difference between Str1 and Str2}
@@Check:
  test  eax, eax
  jz    @@Exit         {End Reached - Return 0}
@@Loop:
  movzx eax, [ecx+edx] {Next Char of Str1}
  movzx ebx, [edx]     {Next Char of Str2}
  inc   edx            {Prepare for Next Loop}
  cmp   eax, ebx       {Compare Chars}
  je    @@Check        {Same - Skip Uppercase Check}
  add   eax, $9f       {Convert 1st Char}
  add   ebx, $9f       {Convert 2nd Char}
  cmp   al, $1a
  jnb   @@1
  sub   eax, $20
@@1:
  cmp   bl, $1a
  jnb   @@2
  sub   ebx, $20
@@2:
  sub   eax, ebx       {Compare Converted Characters}
  je    @@Loop         {Loop until Different}
@@Exit:
  pop   ebx
end;

function StrIComp_JOH_IA32_4_a(const Str1, Str2: PChar): Integer;
asm
  push  ebx
  sub   eax, edx         {Difference between Str1 and Str2}
  mov   ebx, eax         {Exit if Str1 = Str2}
@@Check:
  test  eax, eax
  jz    @@Exit           {End Reached - Return 0}
@@Loop:
  movzx eax, [ebx+edx]   {Next Char of Str1}
  movzx ecx, [edx]
  add   edx, 1           {Prepare for Next Loop}
  cmp   eax, ecx         {Compare with Next Char of Str2}
  je    @@Check          {Same - Skip Uppercase conversion}
  movzx eax, [eax+upper] {Uppercase Char1}
  movzx ecx, [ecx+upper] {Uppercase Char2}
  sub   eax, ecx         {Compare Uppercase Characters}
  je    @@Loop
@@Exit:
  pop   ebx
end;

function StrIComp_JOH_IA32_4_b(const Str1, Str2: PChar): Integer;
asm
  push  ebx
  sub   eax, edx         {Difference between Str1 and Str2}
  mov   ebx, eax         {Exit if Str1 = Str2}
@@Check:
  test  eax, eax
  jz    @@Exit           {End Reached - Return 0}
@@Loop:
  movzx eax, [ebx+edx]   {Next Char of Str1}
  movzx ecx, [edx]
  add   edx, 1           {Prepare for Next Loop}
  cmp   eax, ecx         {Compare with Next Char of Str2}
  je    @@Check          {Same - Skip Uppercase conversion}
  movzx eax, [eax+upper] {Uppercase Char1}
  movzx ecx, [ecx+upper] {Uppercase Char2}
  sub   eax, ecx         {Compare Uppercase Characters}
  je    @@Loop
@@Exit:
  pop   ebx
end;

function StrIComp_JOH_IA32_4_c(const Str1, Str2: PChar): Integer;
asm
  push  ebx
  sub   eax, edx         {Difference between Str1 and Str2}
  mov   ebx, eax         {Exit if Str1 = Str2}
@@Check:
  test  eax, eax
  jz    @@Exit           {End Reached - Return 0}
@@Loop:
  movzx eax, [ebx+edx]   {Next Char of Str1}
  movzx ecx, [edx]
  add   edx, 1           {Prepare for Next Loop}
  cmp   eax, ecx         {Compare with Next Char of Str2}
  je    @@Check          {Same - Skip Uppercase conversion}
  movzx eax, [eax+upper] {Uppercase Char1}
  movzx ecx, [ecx+upper] {Uppercase Char2}
  sub   eax, ecx         {Compare Uppercase Characters}
  je    @@Loop
@@Exit:
  pop   ebx
end;

function StrIComp_JOH_IA32_4_d(const Str1, Str2: PChar): Integer;
asm
  push  ebx
  sub   eax, edx         {Difference between Str1 and Str2}
  mov   ebx, eax         {Exit if Str1 = Str2}
@@Check:
  test  eax, eax
  jz    @@Exit           {End Reached - Return 0}
@@Loop:
  movzx eax, [ebx+edx]   {Next Char of Str1}
  movzx ecx, [edx]
  add   edx, 1           {Prepare for Next Loop}
  cmp   eax, ecx         {Compare with Next Char of Str2}
  je    @@Check          {Same - Skip Uppercase conversion}
  movzx eax, [eax+upper] {Uppercase Char1}
  movzx ecx, [ecx+upper] {Uppercase Char2}
  sub   eax, ecx         {Compare Uppercase Characters}
  je    @@Loop
@@Exit:
  pop   ebx
end;


initialization
  Filler1;
  Filler2;
  Filler3;
  Filler4;
end.

