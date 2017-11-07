unit LowerCase_JOH;

interface

{Turn Off Range Checking and Overflow Checking with this Unit}
{$UNDEF RangeCheck}
{$IFOPT R+}
  {$R-}
  {$DEFINE RangeCheck}
{$ENDIF}
{$UNDEF OverflowCheck}
{$IFOPT Q+}
  {$Q-}
  {$DEFINE OverflowCheck}
{$ENDIF}

{$DEFINE AllowLengthShortcut}

function LowerCase_JOH_PAS_2_a (const S: string): string;
function LowerCase_JOH_PAS_2_b (const S: string): string;
function LowerCase_JOH_PAS_2_c (const S: string): string;
function LowerCase_JOH_PAS_2_d (const S: string): string;
function LowerCase_JOH_IA32_2_a(const S: string): string;
function LowerCase_JOH_IA32_2_b(const S: string): string;
function LowerCase_JOH_IA32_2_c(const S: string): string;
function LowerCase_JOH_IA32_2_d(const S: string): string;
function LowerCase_JOH_IA32_3_a(const S: string): string;
function LowerCase_JOH_IA32_3_b(const S: string): string;
function LowerCase_JOH_IA32_3_c(const S: string): string;
function LowerCase_JOH_IA32_3_d(const S: string): string;
function LowerCase_JOH_MMX_2_a (const S: string): string;
function LowerCase_JOH_MMX_2_b (const S: string): string;
function LowerCase_JOH_MMX_2_c (const S: string): string;
function LowerCase_JOH_MMX_2_d (const S: string): string;
function LowerCase_JOH_SSE2_2_a(const S: string): string;
function LowerCase_JOH_SSE2_2_b(const S: string): string;
function LowerCase_JOH_SSE2_2_c(const S: string): string;
function LowerCase_JOH_SSE2_2_d(const S: string): string;

function LowerCase_JOH_IA32_4_a(const S: string): string;
function LowerCase_JOH_IA32_4_b(const S: string): string;
function LowerCase_JOH_IA32_4_c(const S: string): string;
function LowerCase_JOH_IA32_4_d(const S: string): string;
function LowerCase_JOH_IA32_5_a(const S: string): string;
function LowerCase_JOH_IA32_5_b(const S: string): string;
function LowerCase_JOH_IA32_5_c(const S: string): string;
function LowerCase_JOH_IA32_5_d(const S: string): string;
function LowerCase_JOH_IA32_6_a(const S: string): string;
function LowerCase_JOH_IA32_6_b(const S: string): string;
function LowerCase_JOH_IA32_6_c(const S: string): string;
function LowerCase_JOH_IA32_6_d(const S: string): string;


implementation

var
  AsciiLowerCase : array[Char] of Char = (
    #$00,#$01,#$02,#$03,#$04,#$05,#$06,#$07,#$08,#$09,#$0A,#$0B,#$0C,#$0D,#$0E,#$0F,
    #$10,#$11,#$12,#$13,#$14,#$15,#$16,#$17,#$18,#$19,#$1A,#$1B,#$1C,#$1D,#$1E,#$1F,
    #$20,#$21,#$22,#$23,#$24,#$25,#$26,#$27,#$28,#$29,#$2A,#$2B,#$2C,#$2D,#$2E,#$2F,
    #$30,#$31,#$32,#$33,#$34,#$35,#$36,#$37,#$38,#$39,#$3A,#$3B,#$3C,#$3D,#$3E,#$3F,
    #$40,#$61,#$62,#$63,#$64,#$65,#$66,#$67,#$68,#$69,#$6A,#$6B,#$6C,#$6D,#$6E,#$6F,
    #$70,#$71,#$72,#$73,#$74,#$75,#$76,#$77,#$78,#$79,#$7A,#$5B,#$5C,#$5D,#$5E,#$5F,
    #$60,#$61,#$62,#$63,#$64,#$65,#$66,#$67,#$68,#$69,#$6A,#$6B,#$6C,#$6D,#$6E,#$6F,
    #$70,#$71,#$72,#$73,#$74,#$75,#$76,#$77,#$78,#$79,#$7A,#$7B,#$7C,#$7D,#$7E,#$7F,
    #$80,#$81,#$82,#$83,#$84,#$85,#$86,#$87,#$88,#$89,#$8A,#$8B,#$8C,#$8D,#$8E,#$8F,
    #$90,#$91,#$92,#$93,#$94,#$95,#$96,#$97,#$98,#$99,#$9A,#$9B,#$9C,#$9D,#$9E,#$9F,
    #$A0,#$A1,#$A2,#$A3,#$A4,#$A5,#$A6,#$A7,#$A8,#$A9,#$AA,#$AB,#$AC,#$AD,#$AE,#$AF,
    #$B0,#$B1,#$B2,#$B3,#$B4,#$B5,#$B6,#$B7,#$B8,#$B9,#$BA,#$BB,#$BC,#$BD,#$BE,#$BF,
    #$C0,#$C1,#$C2,#$C3,#$C4,#$C5,#$C6,#$C7,#$C8,#$C9,#$CA,#$CB,#$CC,#$CD,#$CE,#$CF,
    #$D0,#$D1,#$D2,#$D3,#$D4,#$D5,#$D6,#$D7,#$D8,#$D9,#$DA,#$DB,#$DC,#$DD,#$DE,#$DF,
    #$E0,#$E1,#$E2,#$E3,#$E4,#$E5,#$E6,#$E7,#$E8,#$E9,#$EA,#$EB,#$EC,#$ED,#$EE,#$EF,
    #$F0,#$F1,#$F2,#$F3,#$F4,#$F5,#$F6,#$F7,#$F8,#$F9,#$FA,#$FB,#$FC,#$FD,#$FE,#$FF);

{Valid for ASCII Character Set Only}
function LowerCase_JOH_PAS_2_a(const S: string): string;
var
  Len, Temp1, Temp2, Temp3 : Integer;
  PSrc, PRes : Pointer;
begin
{$IFDEF AllowLengthShortcut}
  Len := 0;
  if S <> '' then
    Len := PCardinal(Cardinal(S)-4)^;
{$ELSE}
  Len := Length(S);
{$ENDIF}
  SetLength(Result, Len);
  PSrc := Pointer(S);
  PRes := Pointer(Result);
  if Len >= 4 then
    begin
      Dec(Len, 4);
      Inc(Integer(PSrc), Len);
      Inc(Integer(PRes), Len);
      Len := -Len;
      repeat {Convert 4 Characters per Loop}
        Temp1 := PInteger(Integer(PSrc)+Len)^;
        Temp2 := Temp1 xor -1;
        Temp3 := Temp1 and $7F7F7F7F;
        Temp2 := Temp2 and $80808080;
        Temp3 := Temp3 + $25252525;
        Temp3 := Temp3 and $7F7F7F7F;
        Temp3 := Temp3 + $1A1A1A1A;
        Temp3 := Temp3 and Temp2;
        Temp3 := Temp3 shr 2;
        Temp1 := Temp1 + Temp3;
        PInteger(Integer(PRes)+Len)^ := Temp1;
        Inc(Len, 4);
      until Len > 0;
      Len := -Len;
      Dec(Integer(PSrc), Len);
      Dec(Integer(PRes), Len);
      Inc(Len, 4);
    end;
  if Len = 3 then
    begin
      PChar((Integer(PRes)+2))^ := AsciiLowerCase[PChar((Integer(PSrc)+2))^];
      Dec(Len);
    end;
  if Len = 2 then
    begin
      PChar((Integer(PRes)+1))^ := AsciiLowerCase[PChar((Integer(PSrc)+1))^];
      Dec(Len);
    end;
  if Len = 1 then
    PChar((Integer(PRes)))^ := AsciiLowerCase[PChar((Integer(PSrc)))^];
end;

function LowerCase_JOH_PAS_2_b(const S: string): string;
var
  Len, Temp1, Temp2, Temp3 : Integer;
  PSrc, PRes : Pointer;
begin
{$IFDEF AllowLengthShortcut}
  Len := 0;
  if S <> '' then
    Len := PCardinal(Cardinal(S)-4)^;
{$ELSE}
  Len := Length(S);
{$ENDIF}
  SetLength(Result, Len);
  PSrc := Pointer(S);
  PRes := Pointer(Result);
  if Len >= 4 then
    begin
      Dec(Len, 4);
      Inc(Integer(PSrc), Len);
      Inc(Integer(PRes), Len);
      Len := -Len;
      repeat {Convert 4 Characters per Loop}
        Temp1 := PInteger(Integer(PSrc)+Len)^;
        Temp2 := Temp1 xor -1;
        Temp3 := Temp1 and $7F7F7F7F;
        Temp2 := Temp2 and $80808080;
        Temp3 := Temp3 + $25252525;
        Temp3 := Temp3 and $7F7F7F7F;
        Temp3 := Temp3 + $1A1A1A1A;
        Temp3 := Temp3 and Temp2;
        Temp3 := Temp3 shr 2;
        Temp1 := Temp1 + Temp3;
        PInteger(Integer(PRes)+Len)^ := Temp1;
        Inc(Len, 4);
      until Len > 0;
      Len := -Len;
      Dec(Integer(PSrc), Len);
      Dec(Integer(PRes), Len);
      Inc(Len, 4);
    end;
  if Len = 3 then
    begin
      PChar((Integer(PRes)+2))^ := AsciiLowerCase[PChar((Integer(PSrc)+2))^];
      Dec(Len);
    end;
  if Len = 2 then
    begin
      PChar((Integer(PRes)+1))^ := AsciiLowerCase[PChar((Integer(PSrc)+1))^];
      Dec(Len);
    end;
  if Len = 1 then
    PChar((Integer(PRes)))^ := AsciiLowerCase[PChar((Integer(PSrc)))^];
end;

procedure Filler4;
asm
 nop
end;

function LowerCase_JOH_PAS_2_c(const S: string): string;
var
  Len, Temp1, Temp2, Temp3 : Integer;
  PSrc, PRes : Pointer;
begin
{$IFDEF AllowLengthShortcut}
  Len := 0;
  if S <> '' then
    Len := PCardinal(Cardinal(S)-4)^;
{$ELSE}
  Len := Length(S);
{$ENDIF}
  SetLength(Result, Len);
  PSrc := Pointer(S);
  PRes := Pointer(Result);
  if Len >= 4 then
    begin
      Dec(Len, 4);
      Inc(Integer(PSrc), Len);
      Inc(Integer(PRes), Len);
      Len := -Len;
      repeat {Convert 4 Characters per Loop}
        Temp1 := PInteger(Integer(PSrc)+Len)^;
        Temp2 := Temp1 xor -1;
        Temp3 := Temp1 and $7F7F7F7F;
        Temp2 := Temp2 and $80808080;
        Temp3 := Temp3 + $25252525;
        Temp3 := Temp3 and $7F7F7F7F;
        Temp3 := Temp3 + $1A1A1A1A;
        Temp3 := Temp3 and Temp2;
        Temp3 := Temp3 shr 2;
        Temp1 := Temp1 + Temp3;
        PInteger(Integer(PRes)+Len)^ := Temp1;
        Inc(Len, 4);
      until Len > 0;
      Len := -Len;
      Dec(Integer(PSrc), Len);
      Dec(Integer(PRes), Len);
      Inc(Len, 4);
    end;
  if Len = 3 then
    begin
      PChar((Integer(PRes)+2))^ := AsciiLowerCase[PChar((Integer(PSrc)+2))^];
      Dec(Len);
    end;
  if Len = 2 then
    begin
      PChar((Integer(PRes)+1))^ := AsciiLowerCase[PChar((Integer(PSrc)+1))^];
      Dec(Len);
    end;
  if Len = 1 then
    PChar((Integer(PRes)))^ := AsciiLowerCase[PChar((Integer(PSrc)))^];
end;

function LowerCase_JOH_PAS_2_d(const S: string): string;
var
  Len, Temp1, Temp2, Temp3 : Integer;
  PSrc, PRes : Pointer;
begin
{$IFDEF AllowLengthShortcut}
  Len := 0;
  if S <> '' then
    Len := PCardinal(Cardinal(S)-4)^;
{$ELSE}
  Len := Length(S);
{$ENDIF}
  SetLength(Result, Len);
  PSrc := Pointer(S);
  PRes := Pointer(Result);
  if Len >= 4 then
    begin
      Dec(Len, 4);
      Inc(Integer(PSrc), Len);
      Inc(Integer(PRes), Len);
      Len := -Len;
      repeat {Convert 4 Characters per Loop}
        Temp1 := PInteger(Integer(PSrc)+Len)^;
        Temp2 := Temp1 xor -1;
        Temp3 := Temp1 and $7F7F7F7F;
        Temp2 := Temp2 and $80808080;
        Temp3 := Temp3 + $25252525;
        Temp3 := Temp3 and $7F7F7F7F;
        Temp3 := Temp3 + $1A1A1A1A;
        Temp3 := Temp3 and Temp2;
        Temp3 := Temp3 shr 2;
        Temp1 := Temp1 + Temp3;
        PInteger(Integer(PRes)+Len)^ := Temp1;
        Inc(Len, 4);
      until Len > 0;
      Len := -Len;
      Dec(Integer(PSrc), Len);
      Dec(Integer(PRes), Len);
      Inc(Len, 4);
    end;
  if Len = 3 then
    begin
      PChar((Integer(PRes)+2))^ := AsciiLowerCase[PChar((Integer(PSrc)+2))^];
      Dec(Len);
    end;
  if Len = 2 then
    begin
      PChar((Integer(PRes)+1))^ := AsciiLowerCase[PChar((Integer(PSrc)+1))^];
      Dec(Len);
    end;
  if Len = 1 then
    PChar((Integer(PRes)))^ := AsciiLowerCase[PChar((Integer(PSrc)))^];
end;

{No Lookup Table - Valid for ASCII Character Set Only}
function LowerCase_JOH_IA32_2_a(const S: string): string;
asm
  xchg    eax, edx
  test    edx, edx              {Test for S = ''}
  jz      system.@LStrSetLength {Return Empty String}
  mov     ecx, edx              {Addr(S)}
  mov     edx, [edx-4]
  push    ebx
  push    edi
  push    esi
  mov     edi, ecx              {Addr(S)}
  mov     esi, edx              {Length}
  mov     ebx, eax              {Addr(Result)}
  call    system.@LStrSetLength {Create Result String}
  mov     ecx, esi              {Length}
  mov     eax, edi              {Addr(S)}
  sub     ecx, 4
  mov     edx, [ebx]            {Result}
  jl      @@Small
  add     eax, ecx
  add     edx, ecx
  neg     ecx
@@Loop:
  mov     edi, [eax+ecx]        {Convert 4 Chars per Loop}
  mov     ebx, edi
  mov     esi, edi
  and     ebx, $7F7F7F7F
  not     esi
  and     esi, $80808080
  add     ebx, $25252525
  and     ebx, $7F7F7F7F
  add     ebx, $1A1A1A1A
  and     ebx, esi
  shr     ebx, 2
  add     edi, ebx
  mov     [edx+ecx], edi
  add     ecx, 4
  jle     @@Loop
  neg     ecx
  sub     eax, ecx
  sub     edx, ecx
@@Small:
  add     ecx, 4                {Remainder}
  lea     edi, AsciiLowerCase
  jz      @@Done
@@SmallLoop:
  sub     ecx, 1
  movzx   esi, [eax+ecx]
  movzx   ebx, [edi+esi]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
end;

function LowerCase_JOH_IA32_2_b(const S: string): string;
asm
  xchg    eax, edx
  test    edx, edx              {Test for S = ''}
  jz      system.@LStrSetLength {Return Empty String}
  mov     ecx, edx              {Addr(S)}
  mov     edx, [edx-4]
  push    ebx
  push    edi
  push    esi
  mov     edi, ecx              {Addr(S)}
  mov     esi, edx              {Length}
  mov     ebx, eax              {Addr(Result)}
  call    system.@LStrSetLength {Create Result String}
  mov     ecx, esi              {Length}
  mov     eax, edi              {Addr(S)}
  sub     ecx, 4
  mov     edx, [ebx]            {Result}
  jl      @@Small
  add     eax, ecx
  add     edx, ecx
  neg     ecx
@@Loop:
  mov     edi, [eax+ecx]        {Convert 4 Chars per Loop}
  mov     ebx, edi
  mov     esi, edi
  and     ebx, $7F7F7F7F
  not     esi
  and     esi, $80808080
  add     ebx, $25252525
  and     ebx, $7F7F7F7F
  add     ebx, $1A1A1A1A
  and     ebx, esi
  shr     ebx, 2
  add     edi, ebx
  mov     [edx+ecx], edi
  add     ecx, 4
  jle     @@Loop
  neg     ecx
  sub     eax, ecx
  sub     edx, ecx
@@Small:
  add     ecx, 4                {Remainder}
  lea     edi, AsciiLowerCase
  jz      @@Done
@@SmallLoop:
  sub     ecx, 1
  movzx   esi, [eax+ecx]
  movzx   ebx, [edi+esi]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler11;
asm
 nop
end;

function LowerCase_JOH_IA32_2_c(const S: string): string;
asm
  xchg    eax, edx
  test    edx, edx              {Test for S = ''}
  jz      system.@LStrSetLength {Return Empty String}
  mov     ecx, edx              {Addr(S)}
  mov     edx, [edx-4]
  push    ebx
  push    edi
  push    esi
  mov     edi, ecx              {Addr(S)}
  mov     esi, edx              {Length}
  mov     ebx, eax              {Addr(Result)}
  call    system.@LStrSetLength {Create Result String}
  mov     ecx, esi              {Length}
  mov     eax, edi              {Addr(S)}
  sub     ecx, 4
  mov     edx, [ebx]            {Result}
  jl      @@Small
  add     eax, ecx
  add     edx, ecx
  neg     ecx
@@Loop:
  mov     edi, [eax+ecx]        {Convert 4 Chars per Loop}
  mov     ebx, edi
  mov     esi, edi
  and     ebx, $7F7F7F7F
  not     esi
  and     esi, $80808080
  add     ebx, $25252525
  and     ebx, $7F7F7F7F
  add     ebx, $1A1A1A1A
  and     ebx, esi
  shr     ebx, 2
  add     edi, ebx
  mov     [edx+ecx], edi
  add     ecx, 4
  jle     @@Loop
  neg     ecx
  sub     eax, ecx
  sub     edx, ecx
@@Small:
  add     ecx, 4                {Remainder}
  lea     edi, AsciiLowerCase
  jz      @@Done
@@SmallLoop:
  sub     ecx, 1
  movzx   esi, [eax+ecx]
  movzx   ebx, [edi+esi]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
end;

function LowerCase_JOH_IA32_2_d(const S: string): string;
asm
  xchg    eax, edx
  test    edx, edx              {Test for S = ''}
  jz      system.@LStrSetLength {Return Empty String}
  mov     ecx, edx              {Addr(S)}
  mov     edx, [edx-4]
  push    ebx
  push    edi
  push    esi
  mov     edi, ecx              {Addr(S)}
  mov     esi, edx              {Length}
  mov     ebx, eax              {Addr(Result)}
  call    system.@LStrSetLength {Create Result String}
  mov     ecx, esi              {Length}
  mov     eax, edi              {Addr(S)}
  sub     ecx, 4
  mov     edx, [ebx]            {Result}
  jl      @@Small
  add     eax, ecx
  add     edx, ecx
  neg     ecx
@@Loop:
  mov     edi, [eax+ecx]        {Convert 4 Chars per Loop}
  mov     ebx, edi
  mov     esi, edi
  and     ebx, $7F7F7F7F
  not     esi
  and     esi, $80808080
  add     ebx, $25252525
  and     ebx, $7F7F7F7F
  add     ebx, $1A1A1A1A
  and     ebx, esi
  shr     ebx, 2
  add     edi, ebx
  mov     [edx+ecx], edi
  add     ecx, 4
  jle     @@Loop
  neg     ecx
  sub     eax, ecx
  sub     edx, ecx
@@Small:
  add     ecx, 4                {Remainder}
  lea     edi, AsciiLowerCase
  jz      @@Done
@@SmallLoop:
  sub     ecx, 1
  movzx   esi, [eax+ecx]
  movzx   ebx, [edi+esi]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
end;

{Uses Lookup Table - For Any 8-Bit Character Set - Reads Null Terminator}
function LowerCase_JOH_IA32_3_a(const S: string): string;
asm
  push    ebx
  push    edi
  push    esi
  test    eax, eax              {Test for S = ''}
  xchg    eax, edx
  jz      @@SetLength
  mov     esi, edx              {Addr(S)}
  mov     ebx, eax              {Addr(Result)}
  mov     edx, [esi-4]          {Length}
@@SetLength:
  mov     edi, edx              {Length}
  call    system.@LStrSetLength {Create Result String}
  test    edi, edi              {Length}
  mov     ecx, edi
  jz      @@Done
  mov     edi, [ebx]            {Addr(Result)}
  lea     edx, AsciiLowerCase
@@Loop:
  movzx   eax, [esi+ecx-1]      {Load Char}
  movzx   ebx, [esi+ecx]        {Load Next Char - May be Null Terminator}
  movzx   eax, [edx+eax]        {Translate Char}
  movzx   ebx, [edx+ebx]        {Translate Next Char}
  mov     [edi+ecx-1], al       {Save Char}
  mov     [edi+ecx], bl         {Save Next Char - May be Null Terminator}
  sub     ecx, 2
  jnc     @@Loop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler12;
asm
 nop
end;

function LowerCase_JOH_IA32_3_b(const S: string): string;
asm
  push    ebx
  push    edi
  push    esi
  test    eax, eax              {Test for S = ''}
  xchg    eax, edx
  jz      @@SetLength
  mov     esi, edx              {Addr(S)}
  mov     ebx, eax              {Addr(Result)}
  mov     edx, [esi-4]          {Length}
@@SetLength:
  mov     edi, edx              {Length}
  call    system.@LStrSetLength {Create Result String}
  test    edi, edi              {Length}
  mov     ecx, edi
  jz      @@Done
  mov     edi, [ebx]            {Addr(Result)}
  lea     edx, AsciiLowerCase
@@Loop:
  movzx   eax, [esi+ecx-1]      {Load Char}
  movzx   ebx, [esi+ecx]        {Load Next Char - May be Null Terminator}
  movzx   eax, [edx+eax]        {Translate Char}
  movzx   ebx, [edx+ebx]        {Translate Next Char}
  mov     [edi+ecx-1], al       {Save Char}
  mov     [edi+ecx], bl         {Save Next Char - May be Null Terminator}
  sub     ecx, 2
  jnc     @@Loop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler19;
asm
 nop
end;

function LowerCase_JOH_IA32_3_c(const S: string): string;
asm
  push    ebx
  push    edi
  push    esi
  test    eax, eax              {Test for S = ''}
  xchg    eax, edx
  jz      @@SetLength
  mov     esi, edx              {Addr(S)}
  mov     ebx, eax              {Addr(Result)}
  mov     edx, [esi-4]          {Length}
@@SetLength:
  mov     edi, edx              {Length}
  call    system.@LStrSetLength {Create Result String}
  test    edi, edi              {Length}
  mov     ecx, edi
  jz      @@Done
  mov     edi, [ebx]            {Addr(Result)}
  lea     edx, AsciiLowerCase
@@Loop:
  movzx   eax, [esi+ecx-1]      {Load Char}
  movzx   ebx, [esi+ecx]        {Load Next Char - May be Null Terminator}
  movzx   eax, [edx+eax]        {Translate Char}
  movzx   ebx, [edx+ebx]        {Translate Next Char}
  mov     [edi+ecx-1], al       {Save Char}
  mov     [edi+ecx], bl         {Save Next Char - May be Null Terminator}
  sub     ecx, 2
  jnc     @@Loop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler20;
asm
 nop
end;

function LowerCase_JOH_IA32_3_d(const S: string): string;
asm
  push    ebx
  push    edi
  push    esi
  test    eax, eax              {Test for S = ''}
  xchg    eax, edx
  jz      @@SetLength
  mov     esi, edx              {Addr(S)}
  mov     ebx, eax              {Addr(Result)}
  mov     edx, [esi-4]          {Length}
@@SetLength:
  mov     edi, edx              {Length}
  call    system.@LStrSetLength {Create Result String}
  test    edi, edi              {Length}
  mov     ecx, edi
  jz      @@Done
  mov     edi, [ebx]            {Addr(Result)}
  lea     edx, AsciiLowerCase
@@Loop:
  movzx   eax, [esi+ecx-1]      {Load Char}
  movzx   ebx, [esi+ecx]        {Load Next Char - May be Null Terminator}
  movzx   eax, [edx+eax]        {Translate Char}
  movzx   ebx, [edx+ebx]        {Translate Next Char}
  mov     [edi+ecx-1], al       {Save Char}
  mov     [edi+ecx], bl         {Save Next Char - May be Null Terminator}
  sub     ecx, 2
  jnc     @@Loop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
end;

function LowerCase_JOH_IA32_4_a(const S: string): string;
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
  add     ecx, $25252525
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  add     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jle     @@Loop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'A']
  cmp     edx, 'Z'-'A'+1
  sbb     ecx, ecx
  and     ecx, $20
  add     eax, ecx
  mov     [edi+ebx+4], al
  add     ebx, 1
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;

procedure Filler4a;
asm
 nop
end;

function LowerCase_JOH_IA32_4_b(const S: string): string;
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
  add     ecx, $25252525
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  add     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jle     @@Loop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'A']
  cmp     edx, 'Z'-'A'+1
  sbb     ecx, ecx
  and     ecx, $20
  add     eax, ecx
  mov     [edi+ebx+4], al
  add     ebx, 1
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;

procedure Filler4b;
asm
 nop
end;

function LowerCase_JOH_IA32_4_c(const S: string): string;
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
  add     ecx, $25252525
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  add     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jle     @@Loop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'A']
  cmp     edx, 'Z'-'A'+1
  sbb     ecx, ecx
  and     ecx, $20
  add     eax, ecx
  mov     [edi+ebx+4], al
  add     ebx, 1
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;

procedure Filler4c;
asm
 nop
end;

function LowerCase_JOH_IA32_4_d(const S: string): string;
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
  add     ecx, $25252525
  and     ecx, $7f7f7f7f
  add     ecx, $1a1a1a1a
  and     ecx, edx
  shr     ecx, 2
  add     eax, ecx
  mov     [edi+ebx], eax
  add     ebx, 4
  jle     @@Loop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'A']
  cmp     edx, 'Z'-'A'+1
  sbb     ecx, ecx
  and     ecx, $20
  add     eax, ecx
  mov     [edi+ebx+4], al
  add     ebx, 1
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;


function LowerCase_JOH_IA32_5_a(const S: string): string;
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
  sub     eax, $5B5B5B5B         {Set High Bit if Original <= Ord('Z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('A')}
  and     eax, edx               {80h if Orig in 'A'..'Z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  add     ecx, eax               {Set Bit 5 if Original in 'A'..'Z'}
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
  sub     eax, $5B5B5B5B         {Set High Bit if Original <= Ord('Z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('A')}
  and     eax, edx               {80h if Orig in 'A'..'Z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  add     ecx, eax               {Set Bit 5 if Original in 'A'..'Z'}
  mov     [edi+ebx], ecx
@@CheckDone:
  sub     ebx, 4
  jnc     @@Loop
  pop     esi
  pop     edi
  pop     ebx
end;

function LowerCase_JOH_IA32_5_b(const S: string): string;
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
  sub     eax, $5B5B5B5B         {Set High Bit if Original <= Ord('Z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('A')}
  and     eax, edx               {80h if Orig in 'A'..'Z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  add     ecx, eax               {Set Bit 5 if Original in 'A'..'Z'}
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
  sub     eax, $5B5B5B5B         {Set High Bit if Original <= Ord('Z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('A')}
  and     eax, edx               {80h if Orig in 'A'..'Z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  add     ecx, eax               {Set Bit 5 if Original in 'A'..'Z'}
  mov     [edi+ebx], ecx
@@CheckDone:
  sub     ebx, 4
  jnc     @@Loop
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler5a;
asm
 nop
end;

function LowerCase_JOH_IA32_5_c(const S: string): string;
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
  sub     eax, $5B5B5B5B         {Set High Bit if Original <= Ord('Z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('A')}
  and     eax, edx               {80h if Orig in 'A'..'Z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  add     ecx, eax               {Set Bit 5 if Original in 'A'..'Z'}
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
  sub     eax, $5B5B5B5B         {Set High Bit if Original <= Ord('Z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('A')}
  and     eax, edx               {80h if Orig in 'A'..'Z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  add     ecx, eax               {Set Bit 5 if Original in 'A'..'Z'}
  mov     [edi+ebx], ecx
@@CheckDone:
  sub     ebx, 4
  jnc     @@Loop
  pop     esi
  pop     edi
  pop     ebx
end;

function LowerCase_JOH_IA32_5_d(const S: string): string;
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
  sub     eax, $5B5B5B5B         {Set High Bit if Original <= Ord('Z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('A')}
  and     eax, edx               {80h if Orig in 'A'..'Z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  add     ecx, eax               {Set Bit 5 if Original in 'A'..'Z'}
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
  sub     eax, $5B5B5B5B         {Set High Bit if Original <= Ord('Z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('A')}
  and     eax, edx               {80h if Orig in 'A'..'Z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  add     ecx, eax               {Set Bit 5 if Original in 'A'..'Z'}
  mov     [edi+ebx], ecx
@@CheckDone:
  sub     ebx, 4
  jnc     @@Loop
  pop     esi
  pop     edi
  pop     ebx
end;


function LowerCase_JOH_IA32_6_a(const S: string): string;
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
  sub     eax, $5B5B5B5B         {Set High Bit if Original <= Ord('Z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('A')}
  and     eax, edx               {80h if Orig in 'A'..'Z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  add     ecx, eax               {Set Bit 5 if Original in 'A'..'Z'}
  mov     [edi+ebx], ecx
  add     ebx, 4
  jle     @@Loop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'A']
  cmp     edx, 'Z'-'A'+1
  sbb     ecx, ecx
  and     ecx, $20
  add     eax, ecx
  mov     [edi+ebx+4], al
  inc     ebx
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;


function LowerCase_JOH_IA32_6_b(const S: string): string;
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
  sub     eax, $5B5B5B5B         {Set High Bit if Original <= Ord('Z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('A')}
  and     eax, edx               {80h if Orig in 'A'..'Z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  add     ecx, eax               {Set Bit 5 if Original in 'A'..'Z'}
  mov     [edi+ebx], ecx
  add     ebx, 4
  jle     @@Loop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'A']
  cmp     edx, 'Z'-'A'+1
  sbb     ecx, ecx
  and     ecx, $20
  add     eax, ecx
  mov     [edi+ebx+4], al
  inc     ebx
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;


function LowerCase_JOH_IA32_6_c(const S: string): string;
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
  sub     eax, $5B5B5B5B         {Set High Bit if Original <= Ord('Z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('A')}
  and     eax, edx               {80h if Orig in 'A'..'Z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  add     ecx, eax               {Set Bit 5 if Original in 'A'..'Z'}
  mov     [edi+ebx], ecx
  add     ebx, 4
  jle     @@Loop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'A']
  cmp     edx, 'Z'-'A'+1
  sbb     ecx, ecx
  and     ecx, $20
  add     eax, ecx
  mov     [edi+ebx+4], al
  inc     ebx
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;


function LowerCase_JOH_IA32_6_d(const S: string): string;
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
  sub     eax, $5B5B5B5B         {Set High Bit if Original <= Ord('Z')}
  xor     edx, ecx               {80h if Original < 128 else 00h}
  or      eax, $80808080         {Set High Bit}
  sub     eax, $66666666         {Set High Bit if Original >= Ord('A')}
  and     eax, edx               {80h if Orig in 'A'..'Z' else 00h}
  shr     eax, 2                 {80h > 20h ('a'-'A')}
  add     ecx, eax               {Set Bit 5 if Original in 'A'..'Z'}
  mov     [edi+ebx], ecx
  add     ebx, 4
  jle     @@Loop
@@Remainder:
  sub     ebx, 4
  jz      @@Done
@@SmallLoop:                     {Loop converting 1 Character per Loop}
  movzx   eax, [esi+ebx+4]
  lea     edx, [eax-'A']
  cmp     edx, 'Z'-'A'+1
  sbb     ecx, ecx
  and     ecx, $20
  add     eax, ecx
  mov     [edi+ebx+4], al
  inc     ebx
  jnz     @@SmallLoop
@@Done:
  pop     ebx
  pop     esi
  pop     edi
end;


{No Lookup Table - Valid for ASCII Character Set Only}
function LowerCase_JOH_MMX_2_a(const S: string): string;
const
  B25 : Int64 = $2525252525252525;
  B65 : Int64 = $6565656565656565;
  B20 : Int64 = $2020202020202020;
asm
  xchg    eax, edx
  test    edx, edx              {Test for S = ''}
  jz      system.@LStrSetLength {Return Empty String}
  mov     ecx, edx              {Addr(S)}
  mov     edx, [edx-4]
  push    ebx
  push    edi
  push    esi
  mov     edi, ecx              {Addr(S)}
  mov     esi, edx              {Length}
  mov     ebx, eax              {Addr(Result)}
  call    system.@LStrSetLength {Create Result String}
  mov     ecx, esi              {Length}
  mov     eax, edi              {Addr(S)}
  sub     ecx, 16
  mov     edx, [ebx]            {Result}
  jl      @@Small
  movq    mm4, B25
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
  paddb   mm0, mm2
  paddb   mm1, mm3
  movq    [edx+ecx  ], mm0
  movq    [edx+ecx+8], mm1
  add     ecx, 16
  jle     @@LargeLoop
  emms
  neg     ecx
  sub     eax, ecx
  sub     edx, ecx
@@Small:
  add     ecx, 16
  lea     edi, AsciiLowerCase
  jz      @@Done
@@SmallLoop:
  sub     ecx, 1
  movzx   esi, [eax+ecx]
  movzx   ebx, [edi+esi]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler5;
asm
 nop
end;

function LowerCase_JOH_MMX_2_b(const S: string): string;
const
  B25 : Int64 = $2525252525252525;
  B65 : Int64 = $6565656565656565;
  B20 : Int64 = $2020202020202020;
asm
  xchg    eax, edx
  test    edx, edx              {Test for S = ''}
  jz      system.@LStrSetLength {Return Empty String}
  mov     ecx, edx              {Addr(S)}
  mov     edx, [edx-4]
  push    ebx
  push    edi
  push    esi
  mov     edi, ecx              {Addr(S)}
  mov     esi, edx              {Length}
  mov     ebx, eax              {Addr(Result)}
  call    system.@LStrSetLength {Create Result String}
  mov     ecx, esi              {Length}
  mov     eax, edi              {Addr(S)}
  sub     ecx, 16
  mov     edx, [ebx]            {Result}
  jl      @@Small
  movq    mm4, B25
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
  paddb   mm0, mm2
  paddb   mm1, mm3
  movq    [edx+ecx  ], mm0
  movq    [edx+ecx+8], mm1
  add     ecx, 16
  jle     @@LargeLoop
  emms
  neg     ecx
  sub     eax, ecx
  sub     edx, ecx
@@Small:
  add     ecx, 16
  lea     edi, AsciiLowerCase
  jz      @@Done
@@SmallLoop:
  sub     ecx, 1
  movzx   esi, [eax+ecx]
  movzx   ebx, [edi+esi]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler6;
asm
 nop
end;

function LowerCase_JOH_MMX_2_c(const S: string): string;
const
  B25 : Int64 = $2525252525252525;
  B65 : Int64 = $6565656565656565;
  B20 : Int64 = $2020202020202020;
asm
  xchg    eax, edx
  test    edx, edx              {Test for S = ''}
  jz      system.@LStrSetLength {Return Empty String}
  mov     ecx, edx              {Addr(S)}
  mov     edx, [edx-4]
  push    ebx
  push    edi
  push    esi
  mov     edi, ecx              {Addr(S)}
  mov     esi, edx              {Length}
  mov     ebx, eax              {Addr(Result)}
  call    system.@LStrSetLength {Create Result String}
  mov     ecx, esi              {Length}
  mov     eax, edi              {Addr(S)}
  sub     ecx, 16
  mov     edx, [ebx]            {Result}
  jl      @@Small
  movq    mm4, B25
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
  paddb   mm0, mm2
  paddb   mm1, mm3
  movq    [edx+ecx  ], mm0
  movq    [edx+ecx+8], mm1
  add     ecx, 16
  jle     @@LargeLoop
  emms
  neg     ecx
  sub     eax, ecx
  sub     edx, ecx
@@Small:
  add     ecx, 16
  lea     edi, AsciiLowerCase
  jz      @@Done
@@SmallLoop:
  sub     ecx, 1
  movzx   esi, [eax+ecx]
  movzx   ebx, [edi+esi]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler13;
asm
 nop
end;

function LowerCase_JOH_MMX_2_d(const S: string): string;
const
  B25 : Int64 = $2525252525252525;
  B65 : Int64 = $6565656565656565;
  B20 : Int64 = $2020202020202020;
asm
  xchg    eax, edx
  test    edx, edx              {Test for S = ''}
  jz      system.@LStrSetLength {Return Empty String}
  mov     ecx, edx              {Addr(S)}
  mov     edx, [edx-4]
  push    ebx
  push    edi
  push    esi
  mov     edi, ecx              {Addr(S)}
  mov     esi, edx              {Length}
  mov     ebx, eax              {Addr(Result)}
  call    system.@LStrSetLength {Create Result String}
  mov     ecx, esi              {Length}
  mov     eax, edi              {Addr(S)}
  sub     ecx, 16
  mov     edx, [ebx]            {Result}
  jl      @@Small
  movq    mm4, B25
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
  paddb   mm0, mm2
  paddb   mm1, mm3
  movq    [edx+ecx  ], mm0
  movq    [edx+ecx+8], mm1
  add     ecx, 16
  jle     @@LargeLoop
  emms
  neg     ecx
  sub     eax, ecx
  sub     edx, ecx
@@Small:
  add     ecx, 16
  lea     edi, AsciiLowerCase
  jz      @@Done
@@SmallLoop:
  sub     ecx, 1
  movzx   esi, [eax+ecx]
  movzx   ebx, [edi+esi]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
end;

{No Lookup Table - Valid for ASCII Character Set Only}
function LowerCase_JOH_SSE2_2_a(const S: string): string;
const
  B25 : array[1..2] of Int64 = ($2525252525252525, $2525252525252525);
  B65 : array[1..2] of Int64 = ($6565656565656565, $6565656565656565);
  B20 : array[1..2] of Int64 = ($2020202020202020, $2020202020202020);
asm
  xchg    eax, edx
  test    edx, edx              {Test for S = ''}
  jz      system.@LStrSetLength {Return Empty String}
  mov     ecx, edx              {Addr(S)}
  mov     edx, [edx-4]
  push    ebx
  push    edi
  push    esi
  mov     edi, ecx              {Addr(S)}
  mov     esi, edx              {Length}
  mov     ebx, eax              {Addr(Result)}
  call    system.@LStrSetLength {Create Result String}
  mov     ecx, esi              {Length}
  mov     eax, edi              {Addr(S)}
  sub     ecx, 16
  mov     edx, [ebx]            {Result}
  jl      @@Small
  movdqu  xmm2, B25
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
  paddb   xmm0, xmm1
  movdqu  [edx+ecx], xmm0
  add     ecx, 16
  jle     @@LargeLoop
  neg     ecx
  sub     eax, ecx
  sub     edx, ecx
@@Small:
  add     ecx, 16
  lea     edi, AsciiLowerCase
  jz      @@Done
@@SmallLoop:
  sub     ecx, 1
  movzx   esi, [eax+ecx]
  movzx   ebx, [edi+esi]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler14;
asm
 nop
 nop
 nop
end;

function LowerCase_JOH_SSE2_2_b(const S: string): string;
const
  B25 : array[1..2] of Int64 = ($2525252525252525, $2525252525252525);
  B65 : array[1..2] of Int64 = ($6565656565656565, $6565656565656565);
  B20 : array[1..2] of Int64 = ($2020202020202020, $2020202020202020);
asm
  xchg    eax, edx
  test    edx, edx              {Test for S = ''}
  jz      system.@LStrSetLength {Return Empty String}
  mov     ecx, edx              {Addr(S)}
  mov     edx, [edx-4]
  push    ebx
  push    edi
  push    esi
  mov     edi, ecx              {Addr(S)}
  mov     esi, edx              {Length}
  mov     ebx, eax              {Addr(Result)}
  call    system.@LStrSetLength {Create Result String}
  mov     ecx, esi              {Length}
  mov     eax, edi              {Addr(S)}
  sub     ecx, 16
  mov     edx, [ebx]            {Result}
  jl      @@Small
  movdqu  xmm2, B25
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
  paddb   xmm0, xmm1
  movdqu  [edx+ecx], xmm0
  add     ecx, 16
  jle     @@LargeLoop
  neg     ecx
  sub     eax, ecx
  sub     edx, ecx
@@Small:
  add     ecx, 16
  lea     edi, AsciiLowerCase
  jz      @@Done
@@SmallLoop:
  sub     ecx, 1
  movzx   esi, [eax+ecx]
  movzx   ebx, [edi+esi]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler15;
asm
 nop
 nop
 nop
end;

function LowerCase_JOH_SSE2_2_c(const S: string): string;
const
  B25 : array[1..2] of Int64 = ($2525252525252525, $2525252525252525);
  B65 : array[1..2] of Int64 = ($6565656565656565, $6565656565656565);
  B20 : array[1..2] of Int64 = ($2020202020202020, $2020202020202020);
asm
  xchg    eax, edx
  test    edx, edx              {Test for S = ''}
  jz      system.@LStrSetLength {Return Empty String}
  mov     ecx, edx              {Addr(S)}
  mov     edx, [edx-4]
  push    ebx
  push    edi
  push    esi
  mov     edi, ecx              {Addr(S)}
  mov     esi, edx              {Length}
  mov     ebx, eax              {Addr(Result)}
  call    system.@LStrSetLength {Create Result String}
  mov     ecx, esi              {Length}
  mov     eax, edi              {Addr(S)}
  sub     ecx, 16
  mov     edx, [ebx]            {Result}
  jl      @@Small
  movdqu  xmm2, B25
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
  paddb   xmm0, xmm1
  movdqu  [edx+ecx], xmm0
  add     ecx, 16
  jle     @@LargeLoop
  neg     ecx
  sub     eax, ecx
  sub     edx, ecx
@@Small:
  add     ecx, 16
  lea     edi, AsciiLowerCase
  jz      @@Done
@@SmallLoop:
  sub     ecx, 1
  movzx   esi, [eax+ecx]
  movzx   ebx, [edi+esi]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
end;

procedure Filler16;
asm
 nop
 nop
 nop
end;

function LowerCase_JOH_SSE2_2_d(const S: string): string;
const
  B25 : array[1..2] of Int64 = ($2525252525252525, $2525252525252525);
  B65 : array[1..2] of Int64 = ($6565656565656565, $6565656565656565);
  B20 : array[1..2] of Int64 = ($2020202020202020, $2020202020202020);
asm
  xchg    eax, edx
  test    edx, edx              {Test for S = ''}
  jz      system.@LStrSetLength {Return Empty String}
  mov     ecx, edx              {Addr(S)}
  mov     edx, [edx-4]
  push    ebx
  push    edi
  push    esi
  mov     edi, ecx              {Addr(S)}
  mov     esi, edx              {Length}
  mov     ebx, eax              {Addr(Result)}
  call    system.@LStrSetLength {Create Result String}
  mov     ecx, esi              {Length}
  mov     eax, edi              {Addr(S)}
  sub     ecx, 16
  mov     edx, [ebx]            {Result}
  jl      @@Small
  movdqu  xmm2, B25
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
  paddb   xmm0, xmm1
  movdqu  [edx+ecx], xmm0
  add     ecx, 16
  jle     @@LargeLoop
  neg     ecx
  sub     eax, ecx
  sub     edx, ecx
@@Small:
  add     ecx, 16
  lea     edi, AsciiLowerCase
  jz      @@Done
@@SmallLoop:
  sub     ecx, 1
  movzx   esi, [eax+ecx]
  movzx   ebx, [edi+esi]
  mov     [edx+ecx], bl
  jg      @@SmallLoop
@@Done:
  pop     esi
  pop     edi
  pop     ebx
end;

{$IFDEF RangeCheck}
  {$R+}
  {$UNDEF RangeCheck}
{$ENDIF}
{$IFDEF OverflowCheck}
  {$Q+}
  {$UNDEF OverflowCheck}
{$ENDIF}

initialization

 Filler4;
 Filler5;
 Filler6;
 Filler11;
 Filler12;
 Filler13;
 Filler14;
 Filler15;
 Filler16;
 Filler19;
 Filler20;
 Filler4a;
 Filler4b;
 Filler4c;
 Filler5a;

end.
