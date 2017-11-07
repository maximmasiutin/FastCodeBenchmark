unit CompareStr_EWC;

//* These routines represent something of a progression of thought - or the lack
//* of it - and probably only one of them is worth keeping.

{$OPTIMIZATION ON}
{$RANGECHECKS OFF}

interface

//function CompareStr_IA32_EWC_1_a(const S1, S2: string): Integer;
//function CompareStr_IA32_EWC_1_b(const S1, S2: string): Integer;
//function CompareStr_IA32_EWC_1_c(const S1, S2: string): Integer;
//function CompareStr_IA32_EWC_1_d(const S1, S2: string): Integer;
//function CompareStr_IA32_EWC_2_a(const S1, S2: string): Integer;
//function CompareStr_IA32_EWC_2_b(const S1, S2: string): Integer;
//function CompareStr_IA32_EWC_2_c(const S1, S2: string): Integer;
//function CompareStr_IA32_EWC_2_d(const S1, S2: string): Integer;
function CompareStr_EWC_IA32_3_a(const S1, S2: string): Integer;//+
function CompareStr_EWC_IA32_3_b(const S1, S2: string): Integer;//+
function CompareStr_EWC_IA32_3_c(const S1, S2: string): Integer;//+
function CompareStr_EWC_IA32_3_d(const S1, S2: string): Integer;//+
//function CompareStr_PAS_EWC_1_a(const S1, S2: string): Integer;
//function CompareStr_PAS_EWC_1_b(const S1, S2: string): Integer;
//function CompareStr_PAS_EWC_1_c(const S1, S2: string): Integer;
//function CompareStr_PAS_EWC_1_d(const S1, S2: string): Integer;
function CompareStr_EWC_PAS_2_a(const S1, S2: string): Integer;//+
function CompareStr_EWC_PAS_2_b(const S1, S2: string): Integer;//+
function CompareStr_EWC_PAS_2_c(const S1, S2: string): Integer;//+
function CompareStr_EWC_PAS_2_d(const S1, S2: string): Integer;//+

implementation

function CompareStr_IA32_EWC_1_a(const S1, S2: string): Integer;
asm
  push ebx
  push esi
  push edi

@LenTest1:
  test eax,eax
  jnz @NonZeroLen1
  xor esi, esi
  jmp @LenTest2
@NonZeroLen1:
  mov esi,[eax-$04]   //Get String S1 Length

@LenTest2:
  test edx, edx
  jnz @NonZeroLen2
  xor edi, edi
  jmp @CalcLen
@NonZeroLen2:
  mov edi,[edx-$04]   //Get String S2 Length

@CalcLen:
  //Find the smallest length and use it for a loop counter
  mov ecx, esi
  cmp esi, edi
  jle @LoopPrep
  mov ecx, edi

@LoopPrep:
  //Precalculate Result if strings are equal up to their respective lengths
  sub esi, edi

  cmp ecx, $00
  jle @EqualSoFar

@BeginLoop:
  movzx bx, BYTE [eax]
  movzx di, BYTE [edx]
  sub bx, di
  jne @NotEqual

  lea eax, [eax+1]
  lea edx, [edx+1]
  sub ecx, 1
  jz @EqualSoFar
  jmp @BeginLoop

@NotEqual:
  movsx eax, bx
  jmp @Done

@EqualSoFar:
  mov eax, esi

@Done:
  pop edi
  pop esi
  pop ebx
end;

procedure Filler1;
asm
 nop
end;

function CompareStr_IA32_EWC_1_b(const S1, S2: string): Integer;
asm
  push ebx
  push esi
  push edi

@LenTest1:
  test eax,eax
  jnz @NonZeroLen1
  xor esi, esi
  jmp @LenTest2
@NonZeroLen1:
  mov esi,[eax-$04]   //Get String S1 Length

@LenTest2:
  test edx, edx
  jnz @NonZeroLen2
  xor edi, edi
  jmp @CalcLen
@NonZeroLen2:
  mov edi,[edx-$04]   //Get String S2 Length

@CalcLen:
  //Find the smallest length and use it for a loop counter
  mov ecx, esi
  cmp esi, edi
  jle @LoopPrep
  mov ecx, edi

@LoopPrep:
  //Precalculate Result if strings are equal up to their respective lengths
  sub esi, edi

  cmp ecx, $00
  jle @EqualSoFar

@BeginLoop:
  movzx bx, BYTE [eax]
  movzx di, BYTE [edx]
  sub bx, di
  jne @NotEqual

  lea eax, [eax+1]
  lea edx, [edx+1]
  sub ecx, 1
  jz @EqualSoFar
  jmp @BeginLoop

@NotEqual:
  movsx eax, bx
  jmp @Done

@EqualSoFar:
  mov eax, esi

@Done:
  pop edi
  pop esi
  pop ebx
end;

procedure Filler2;
asm
 nop
end;

function CompareStr_IA32_EWC_1_c(const S1, S2: string): Integer;
asm
  push ebx
  push esi
  push edi

@LenTest1:
  test eax,eax
  jnz @NonZeroLen1
  xor esi, esi
  jmp @LenTest2
@NonZeroLen1:
  mov esi,[eax-$04]   //Get String S1 Length

@LenTest2:
  test edx, edx
  jnz @NonZeroLen2
  xor edi, edi
  jmp @CalcLen
@NonZeroLen2:
  mov edi,[edx-$04]   //Get String S2 Length

@CalcLen:
  //Find the smallest length and use it for a loop counter
  mov ecx, esi
  cmp esi, edi
  jle @LoopPrep
  mov ecx, edi

@LoopPrep:
  //Precalculate Result if strings are equal up to their respective lengths
  sub esi, edi

  cmp ecx, $00
  jle @EqualSoFar

@BeginLoop:
  movzx bx, BYTE [eax]
  movzx di, BYTE [edx]
  sub bx, di
  jne @NotEqual

  lea eax, [eax+1]
  lea edx, [edx+1]
  sub ecx, 1
  jz @EqualSoFar
  jmp @BeginLoop

@NotEqual:
  movsx eax, bx
  jmp @Done

@EqualSoFar:
  mov eax, esi

@Done:
  pop edi
  pop esi
  pop ebx
end;

procedure Filler3;
asm
 nop
end;

function CompareStr_IA32_EWC_1_d(const S1, S2: string): Integer;
asm
  push ebx
  push esi
  push edi

@LenTest1:
  test eax,eax
  jnz @NonZeroLen1
  xor esi, esi
  jmp @LenTest2
@NonZeroLen1:
  mov esi,[eax-$04]   //Get String S1 Length

@LenTest2:
  test edx, edx
  jnz @NonZeroLen2
  xor edi, edi
  jmp @CalcLen
@NonZeroLen2:
  mov edi,[edx-$04]   //Get String S2 Length

@CalcLen:
  //Find the smallest length and use it for a loop counter
  mov ecx, esi
  cmp esi, edi
  jle @LoopPrep
  mov ecx, edi

@LoopPrep:
  //Precalculate Result if strings are equal up to their respective lengths
  sub esi, edi

  cmp ecx, $00
  jle @EqualSoFar

@BeginLoop:
  movzx bx, BYTE [eax]
  movzx di, BYTE [edx]
  sub bx, di
  jne @NotEqual

  lea eax, [eax+1]
  lea edx, [edx+1]
  sub ecx, 1
  jz @EqualSoFar
  jmp @BeginLoop

@NotEqual:
  movsx eax, bx
  jmp @Done

@EqualSoFar:
  mov eax, esi

@Done:
  pop edi
  pop esi
  pop ebx
end;

function CompareStr_IA32_EWC_2_a(const S1, S2: string): Integer;
asm
  push ebx
  push esi
  push edi

@LenTest1:
  test eax,eax
  jnz @NonZeroLen1
  xor esi, esi
  jmp @LenTest2
@NonZeroLen1:
  mov esi,[eax-$04]   //Get String S1 Length

@LenTest2:
  test edx, edx
  jnz @NonZeroLen2
  xor edi, edi
  jmp @CalcLen
@NonZeroLen2:
  mov edi,[edx-$04]   //Get String S2 Length

@CalcLen:
  //Find the smallest length and use it for a loop counter
  mov ecx, esi
  cmp esi, edi
  jle @LoopPrep
  mov ecx, edi

@LoopPrep:
  //Precalculate Result if strings are equal up to their respective lengths
  sub esi, edi

  cmp ecx, $00
  jle @EqualSoFar

@BeginLoop:
  mov bl, BYTE [eax]
  cmp bl, BYTE [edx]
  jne @NotEqual

  lea eax, [eax+1]
  lea edx, [edx+1]
  sub ecx, 1
  jz @EqualSoFar
  jmp @BeginLoop

@NotEqual:
  ja @GreaterThan

@LessThan:
  mov eax, -1
  jmp @Done

@GreaterThan:
  mov eax, 1
  jmp @Done

@EqualSoFar:
  mov eax, esi

@Done:
  pop edi
  pop esi
  pop ebx
end;

function CompareStr_IA32_EWC_2_b(const S1, S2: string): Integer;
asm
  push ebx
  push esi
  push edi

@LenTest1:
  test eax,eax
  jnz @NonZeroLen1
  xor esi, esi
  jmp @LenTest2
@NonZeroLen1:
  mov esi,[eax-$04]   //Get String S1 Length

@LenTest2:
  test edx, edx
  jnz @NonZeroLen2
  xor edi, edi
  jmp @CalcLen
@NonZeroLen2:
  mov edi,[edx-$04]   //Get String S2 Length

@CalcLen:
  //Find the smallest length and use it for a loop counter
  mov ecx, esi
  cmp esi, edi
  jle @LoopPrep
  mov ecx, edi

@LoopPrep:
  //Precalculate Result if strings are equal up to their respective lengths
  sub esi, edi

  cmp ecx, $00
  jle @EqualSoFar

@BeginLoop:
  mov bl, BYTE [eax]
  cmp bl, BYTE [edx]
  jne @NotEqual

  lea eax, [eax+1]
  lea edx, [edx+1]
  sub ecx, 1
  jz @EqualSoFar
  jmp @BeginLoop

@NotEqual:
  ja @GreaterThan

@LessThan:
  mov eax, -1
  jmp @Done

@GreaterThan:
  mov eax, 1
  jmp @Done

@EqualSoFar:
  mov eax, esi

@Done:
  pop edi
  pop esi
  pop ebx
end;

function CompareStr_IA32_EWC_2_c(const S1, S2: string): Integer;
asm
  push ebx
  push esi
  push edi

@LenTest1:
  test eax,eax
  jnz @NonZeroLen1
  xor esi, esi
  jmp @LenTest2
@NonZeroLen1:
  mov esi,[eax-$04]   //Get String S1 Length

@LenTest2:
  test edx, edx
  jnz @NonZeroLen2
  xor edi, edi
  jmp @CalcLen
@NonZeroLen2:
  mov edi,[edx-$04]   //Get String S2 Length

@CalcLen:
  //Find the smallest length and use it for a loop counter
  mov ecx, esi
  cmp esi, edi
  jle @LoopPrep
  mov ecx, edi

@LoopPrep:
  //Precalculate Result if strings are equal up to their respective lengths
  sub esi, edi

  cmp ecx, $00
  jle @EqualSoFar

@BeginLoop:
  mov bl, BYTE [eax]
  cmp bl, BYTE [edx]
  jne @NotEqual

  lea eax, [eax+1]
  lea edx, [edx+1]
  sub ecx, 1
  jz @EqualSoFar
  jmp @BeginLoop

@NotEqual:
  ja @GreaterThan

@LessThan:
  mov eax, -1
  jmp @Done

@GreaterThan:
  mov eax, 1
  jmp @Done

@EqualSoFar:
  mov eax, esi

@Done:
  pop edi
  pop esi
  pop ebx
end;

function CompareStr_IA32_EWC_2_d(const S1, S2: string): Integer;
asm
  push ebx
  push esi
  push edi

@LenTest1:
  test eax,eax
  jnz @NonZeroLen1
  xor esi, esi
  jmp @LenTest2
@NonZeroLen1:
  mov esi,[eax-$04]   //Get String S1 Length

@LenTest2:
  test edx, edx
  jnz @NonZeroLen2
  xor edi, edi
  jmp @CalcLen
@NonZeroLen2:
  mov edi,[edx-$04]   //Get String S2 Length

@CalcLen:
  //Find the smallest length and use it for a loop counter
  mov ecx, esi
  cmp esi, edi
  jle @LoopPrep
  mov ecx, edi

@LoopPrep:
  //Precalculate Result if strings are equal up to their respective lengths
  sub esi, edi

  cmp ecx, $00
  jle @EqualSoFar

@BeginLoop:
  mov bl, BYTE [eax]
  cmp bl, BYTE [edx]
  jne @NotEqual

  lea eax, [eax+1]
  lea edx, [edx+1]
  sub ecx, 1
  jz @EqualSoFar
  jmp @BeginLoop

@NotEqual:
  ja @GreaterThan

@LessThan:
  mov eax, -1
  jmp @Done

@GreaterThan:
  mov eax, 1
  jmp @Done

@EqualSoFar:
  mov eax, esi

@Done:
  pop edi
  pop esi
  pop ebx
end;

function CompareStr_EWC_IA32_3_a(const S1, S2: string): Integer;
asm
  push ebx
  push esi
  push edi

@LenTest1:
  test eax,eax
  jnz @NonZeroLen1
  xor esi, esi
  jmp @LenTest2
@NonZeroLen1:
  mov esi,[eax-$04]   //Get String S1 Length

@LenTest2:
  test edx, edx
  jnz @NonZeroLen2
  xor edi, edi
  jmp @CalcLen
@NonZeroLen2:
  mov edi,[edx-$04]   //Get String S2 Length

@CalcLen:
  //Find the smallest length and use it for a loop counter
  mov ecx, esi
  cmp esi, edi
  jle @LoopPrep
  mov ecx, edi

@LoopPrep:
  //Precalculate Result if strings are equal up to their respective lengths
  sub esi, edi

  //Calculate the number of 4 byte blocks to test and the remainder of single bytes
  mov edi, ecx
  shr ecx, 2         //Div by 4 to get loop counter of 4 byte words
  and edi, $00000003 //Mask all but the last to bits to get the remainder

  cmp ecx, $00
  jle @EqualSoFar

@BeginLoop:
  mov ebx, [eax]
  cmp ebx, [edx]
  jne @NotEqual

  lea eax, [eax+4]
  lea edx, [edx+4]
  sub ecx, 1
  jz @EqualSoFar
  jmp @BeginLoop

@EqualSoFar:
  //Loop over the remaining bytes in the string
  cmp edi, $00
  jle @EqualStill

@BeginLoopRem:
  mov bl, BYTE [eax]
  cmp bl, BYTE [edx]
  jne @NotEqualRem

  lea eax, [eax+1]
  lea edx, [edx+1]
  sub edi, 1
  jz @EqualStill
  jmp @BeginLoopRem

@NotEqual:
  //Need to convert to big-endian to do GT vs. LT comparison properly
  //  reusing esi at this point is ok, since we don't need the pre-calculated result
  mov esi, [edx]
  bswap ebx       //Convert to big-endian  (Value set in comparison above)
  bswap esi       //Convert to big-endian
  sub ebx, esi
  ja @GreaterThan

@LessThan:
  mov eax, -1
  jmp @Done

@GreaterThan:
  mov eax, 1
  jmp @Done

@NotEqualRem:
  ja @GreaterThan
  jmp @LessThan

@EqualStill:
  //esi will be untouched in this case and will contain the pre-calculated result
  mov eax, esi

@Done:
  pop edi
  pop esi
  pop ebx
end;

function CompareStr_EWC_IA32_3_b(const S1, S2: string): Integer;
asm
  push ebx
  push esi
  push edi

@LenTest1:
  test eax,eax
  jnz @NonZeroLen1
  xor esi, esi
  jmp @LenTest2
@NonZeroLen1:
  mov esi,[eax-$04]   //Get String S1 Length

@LenTest2:
  test edx, edx
  jnz @NonZeroLen2
  xor edi, edi
  jmp @CalcLen
@NonZeroLen2:
  mov edi,[edx-$04]   //Get String S2 Length

@CalcLen:
  //Find the smallest length and use it for a loop counter
  mov ecx, esi
  cmp esi, edi
  jle @LoopPrep
  mov ecx, edi

@LoopPrep:
  //Precalculate Result if strings are equal up to their respective lengths
  sub esi, edi

  //Calculate the number of 4 byte blocks to test and the remainder of single bytes
  mov edi, ecx
  shr ecx, 2         //Div by 4 to get loop counter of 4 byte words
  and edi, $00000003 //Mask all but the last to bits to get the remainder

  cmp ecx, $00
  jle @EqualSoFar

@BeginLoop:
  mov ebx, [eax]
  cmp ebx, [edx]
  jne @NotEqual

  lea eax, [eax+4]
  lea edx, [edx+4]
  sub ecx, 1
  jz @EqualSoFar
  jmp @BeginLoop

@EqualSoFar:
  //Loop over the remaining bytes in the string
  cmp edi, $00
  jle @EqualStill

@BeginLoopRem:
  mov bl, BYTE [eax]
  cmp bl, BYTE [edx]
  jne @NotEqualRem

  lea eax, [eax+1]
  lea edx, [edx+1]
  sub edi, 1
  jz @EqualStill
  jmp @BeginLoopRem

@NotEqual:
  //Need to convert to big-endian to do GT vs. LT comparison properly
  //  reusing esi at this point is ok, since we don't need the pre-calculated result
  mov esi, [edx]
  bswap ebx       //Convert to big-endian  (Value set in comparison above)
  bswap esi       //Convert to big-endian
  sub ebx, esi
  ja @GreaterThan

@LessThan:
  mov eax, -1
  jmp @Done

@GreaterThan:
  mov eax, 1
  jmp @Done

@NotEqualRem:
  ja @GreaterThan
  jmp @LessThan

@EqualStill:
  //esi will be untouched in this case and will contain the pre-calculated result
  mov eax, esi

@Done:
  pop edi
  pop esi
  pop ebx
end;

function CompareStr_EWC_IA32_3_c(const S1, S2: string): Integer;
asm
  push ebx
  push esi
  push edi

@LenTest1:
  test eax,eax
  jnz @NonZeroLen1
  xor esi, esi
  jmp @LenTest2
@NonZeroLen1:
  mov esi,[eax-$04]   //Get String S1 Length

@LenTest2:
  test edx, edx
  jnz @NonZeroLen2
  xor edi, edi
  jmp @CalcLen
@NonZeroLen2:
  mov edi,[edx-$04]   //Get String S2 Length

@CalcLen:
  //Find the smallest length and use it for a loop counter
  mov ecx, esi
  cmp esi, edi
  jle @LoopPrep
  mov ecx, edi

@LoopPrep:
  //Precalculate Result if strings are equal up to their respective lengths
  sub esi, edi

  //Calculate the number of 4 byte blocks to test and the remainder of single bytes
  mov edi, ecx
  shr ecx, 2         //Div by 4 to get loop counter of 4 byte words
  and edi, $00000003 //Mask all but the last to bits to get the remainder

  cmp ecx, $00
  jle @EqualSoFar

@BeginLoop:
  mov ebx, [eax]
  cmp ebx, [edx]
  jne @NotEqual

  lea eax, [eax+4]
  lea edx, [edx+4]
  sub ecx, 1
  jz @EqualSoFar
  jmp @BeginLoop

@EqualSoFar:
  //Loop over the remaining bytes in the string
  cmp edi, $00
  jle @EqualStill

@BeginLoopRem:
  mov bl, BYTE [eax]
  cmp bl, BYTE [edx]
  jne @NotEqualRem

  lea eax, [eax+1]
  lea edx, [edx+1]
  sub edi, 1
  jz @EqualStill
  jmp @BeginLoopRem

@NotEqual:
  //Need to convert to big-endian to do GT vs. LT comparison properly
  //  reusing esi at this point is ok, since we don't need the pre-calculated result
  mov esi, [edx]
  bswap ebx       //Convert to big-endian  (Value set in comparison above)
  bswap esi       //Convert to big-endian
  sub ebx, esi
  ja @GreaterThan

@LessThan:
  mov eax, -1
  jmp @Done

@GreaterThan:
  mov eax, 1
  jmp @Done

@NotEqualRem:
  ja @GreaterThan
  jmp @LessThan

@EqualStill:
  //esi will be untouched in this case and will contain the pre-calculated result
  mov eax, esi

@Done:
  pop edi
  pop esi
  pop ebx
end;

function CompareStr_EWC_IA32_3_d(const S1, S2: string): Integer;
asm
  push ebx
  push esi
  push edi

@LenTest1:
  test eax,eax
  jnz @NonZeroLen1
  xor esi, esi
  jmp @LenTest2
@NonZeroLen1:
  mov esi,[eax-$04]   //Get String S1 Length

@LenTest2:
  test edx, edx
  jnz @NonZeroLen2
  xor edi, edi
  jmp @CalcLen
@NonZeroLen2:
  mov edi,[edx-$04]   //Get String S2 Length

@CalcLen:
  //Find the smallest length and use it for a loop counter
  mov ecx, esi
  cmp esi, edi
  jle @LoopPrep
  mov ecx, edi

@LoopPrep:
  //Precalculate Result if strings are equal up to their respective lengths
  sub esi, edi

  //Calculate the number of 4 byte blocks to test and the remainder of single bytes
  mov edi, ecx
  shr ecx, 2         //Div by 4 to get loop counter of 4 byte words
  and edi, $00000003 //Mask all but the last to bits to get the remainder

  cmp ecx, $00
  jle @EqualSoFar

@BeginLoop:
  mov ebx, [eax]
  cmp ebx, [edx]
  jne @NotEqual

  lea eax, [eax+4]
  lea edx, [edx+4]
  sub ecx, 1
  jz @EqualSoFar
  jmp @BeginLoop

@EqualSoFar:
  //Loop over the remaining bytes in the string
  cmp edi, $00
  jle @EqualStill

@BeginLoopRem:
  mov bl, BYTE [eax]
  cmp bl, BYTE [edx]
  jne @NotEqualRem

  lea eax, [eax+1]
  lea edx, [edx+1]
  sub edi, 1
  jz @EqualStill
  jmp @BeginLoopRem

@NotEqual:
  //Need to convert to big-endian to do GT vs. LT comparison properly
  //  reusing esi at this point is ok, since we don't need the pre-calculated result
  mov esi, [edx]
  bswap ebx       //Convert to big-endian  (Value set in comparison above)
  bswap esi       //Convert to big-endian
  sub ebx, esi
  ja @GreaterThan

@LessThan:
  mov eax, -1
  jmp @Done

@GreaterThan:
  mov eax, 1
  jmp @Done

@NotEqualRem:
  ja @GreaterThan
  jmp @LessThan

@EqualStill:
  //esi will be untouched in this case and will contain the pre-calculated result
  mov eax, esi

@Done:
  pop edi
  pop esi
  pop ebx
end;

{$WARNINGS OFF}
function CompareStr_PAS_EWC_1_a(const S1, S2: string): Integer;
var
  i: Integer;
  Len1: Integer;
  Len2: Integer;
  Cnt:  Integer;
  Chr1: PByte;
  Chr2: PByte;
begin
//  Result := 0;
  Len1 := Length(S1);
  Len2 := Length(S2);

  if Len1 < Len2 then
    Cnt := Len1
  else
    Cnt := Len2;

  if Len1 > 0 then
    Chr1 := @S1[1];

  if Len2 > 0 then
    Chr2 := @S2[1];

  i := 1;
  while i <= Cnt do
    begin
      Result := Chr1^ - Chr2^;
      if Result <> 0 then
        Exit;

      Inc(Chr1);
      Inc(Chr2);
      Inc(i);
    end;

  Result := Len1 - Len2;
end;
{$WARNINGS ON}

{$WARNINGS OFF}
function CompareStr_PAS_EWC_1_b(const S1, S2: string): Integer;
var
  i: Integer;
  Len1: Integer;
  Len2: Integer;
  Cnt:  Integer;
  Chr1: PByte;
  Chr2: PByte;
begin
//  Result := 0;
  Len1 := Length(S1);
  Len2 := Length(S2);

  if Len1 < Len2 then
    Cnt := Len1
  else
    Cnt := Len2;

  if Len1 > 0 then
    Chr1 := @S1[1];

  if Len2 > 0 then
    Chr2 := @S2[1];

  i := 1;
  while i <= Cnt do
    begin
      Result := Chr1^ - Chr2^;
      if Result <> 0 then
        Exit;

      Inc(Chr1);
      Inc(Chr2);
      Inc(i);
    end;

  Result := Len1 - Len2;
end;
{$WARNINGS ON}

{$WARNINGS OFF}
function CompareStr_PAS_EWC_1_c(const S1, S2: string): Integer;
var
  i: Integer;
  Len1: Integer;
  Len2: Integer;
  Cnt:  Integer;
  Chr1: PByte;
  Chr2: PByte;
begin
//  Result := 0;
  Len1 := Length(S1);
  Len2 := Length(S2);

  if Len1 < Len2 then
    Cnt := Len1
  else
    Cnt := Len2;

  if Len1 > 0 then
    Chr1 := @S1[1];

  if Len2 > 0 then
    Chr2 := @S2[1];

  i := 1;
  while i <= Cnt do
    begin
      Result := Chr1^ - Chr2^;
      if Result <> 0 then
        Exit;

      Inc(Chr1);
      Inc(Chr2);
      Inc(i);
    end;

  Result := Len1 - Len2;
end;
{$WARNINGS ON}

{$WARNINGS OFF}
function CompareStr_PAS_EWC_1_d(const S1, S2: string): Integer;
var
  i: Integer;
  Len1: Integer;
  Len2: Integer;
  Cnt:  Integer;
  Chr1: PByte;
  Chr2: PByte;
begin
//  Result := 0;
  Len1 := Length(S1);
  Len2 := Length(S2);

  if Len1 < Len2 then
    Cnt := Len1
  else
    Cnt := Len2;

  if Len1 > 0 then
    Chr1 := @S1[1];

  if Len2 > 0 then
    Chr2 := @S2[1];

  i := 1;
  while i <= Cnt do
    begin
      Result := Chr1^ - Chr2^;
      if Result <> 0 then
        Exit;

      Inc(Chr1);
      Inc(Chr2);
      Inc(i);
    end;

  Result := Len1 - Len2;
end;
{$WARNINGS ON}

{$WARNINGS OFF}
function CompareStr_EWC_PAS_2_a(const S1, S2: string): Integer;
var
  i: Integer;
  Len1: Integer;
  Len2: Integer;
  Cnt:  Integer;
  CntRem: Integer;
  Word1: PInteger;
  Word2: PInteger;
  Chr1: PByte;
  Chr2: PByte;
begin
  Len1 := Length(S1);
  Len2 := Length(S2);

  if Len1 < Len2 then
    begin
      CntRem := Len1 mod 4;
      Cnt    := Len1 shr 2;
    end
  else
    begin
      CntRem := Len2 mod 4;
      Cnt    := Len2 shr 2;
    end;

  if Len1 > 0 then
    Word1 := @S1[1];

  if Len2 > 0 then
    Word2 := @S2[1];

  i := 1;
  while i <= Cnt do
    begin
      if Word1^ <> Word2^ then
        begin
          //Determine which byte failed and return the value of this.
          // little-endian notation doesn't make treating a 4-byte string as
          // an integer very easy....
          Chr1 := PByte(Word1);
          Chr2 := PByte(Word2);
          Result := Chr1^ - Chr2^;
          if Result <> 0 then
            Exit;
          Inc(Chr1);
          Inc(Chr2);
          Result := Chr1^ - Chr2^;
          if Result <> 0 then
            Exit;
          Inc(Chr1);
          Inc(Chr2);
          Result := Chr1^ - Chr2^;
          if Result <> 0 then
            Exit;
          Inc(Chr1);
          Inc(Chr2);
          Result := Chr1^ - Chr2^;
          Exit;
        end;

      Inc(Word1);
      Inc(Word2);
      Inc(i);
    end;

  case CntRem of
    1:
      begin
        Chr1 := PByte(Word1);
        Chr2 := PByte(Word2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;
      end;
    2:
      begin
        Chr1 := PByte(Word1);
        Chr2 := PByte(Word2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;

        Inc(Chr1);
        Inc(Chr2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;
      end;
    3:
      begin
        Chr1 := PByte(Word1);
        Chr2 := PByte(Word2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;

        Inc(Chr1);
        Inc(Chr2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;

        Inc(Chr1);
        Inc(Chr2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;
      end;
  end;

  Result := Len1 - Len2;
end;
{$WARNINGS ON}

{$WARNINGS OFF}
function CompareStr_EWC_PAS_2_b(const S1, S2: string): Integer;
var
  i: Integer;
  Len1: Integer;
  Len2: Integer;
  Cnt:  Integer;
  CntRem: Integer;
  Word1: PInteger;
  Word2: PInteger;
  Chr1: PByte;
  Chr2: PByte;
begin
  Len1 := Length(S1);
  Len2 := Length(S2);

  if Len1 < Len2 then
    begin
      CntRem := Len1 mod 4;
      Cnt    := Len1 shr 2;
    end
  else
    begin
      CntRem := Len2 mod 4;
      Cnt    := Len2 shr 2;
    end;

  if Len1 > 0 then
    Word1 := @S1[1];

  if Len2 > 0 then
    Word2 := @S2[1];

  i := 1;
  while i <= Cnt do
    begin
      if Word1^ <> Word2^ then
        begin
          //Determine which byte failed and return the value of this.
          // little-endian notation doesn't make treating a 4-byte string as
          // an integer very easy....
          Chr1 := PByte(Word1);
          Chr2 := PByte(Word2);
          Result := Chr1^ - Chr2^;
          if Result <> 0 then
            Exit;
          Inc(Chr1);
          Inc(Chr2);
          Result := Chr1^ - Chr2^;
          if Result <> 0 then
            Exit;
          Inc(Chr1);
          Inc(Chr2);
          Result := Chr1^ - Chr2^;
          if Result <> 0 then
            Exit;
          Inc(Chr1);
          Inc(Chr2);
          Result := Chr1^ - Chr2^;
          Exit;
        end;

      Inc(Word1);
      Inc(Word2);
      Inc(i);
    end;

  case CntRem of
    1:
      begin
        Chr1 := PByte(Word1);
        Chr2 := PByte(Word2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;
      end;
    2:
      begin
        Chr1 := PByte(Word1);
        Chr2 := PByte(Word2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;

        Inc(Chr1);
        Inc(Chr2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;
      end;
    3:
      begin
        Chr1 := PByte(Word1);
        Chr2 := PByte(Word2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;

        Inc(Chr1);
        Inc(Chr2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;

        Inc(Chr1);
        Inc(Chr2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;
      end;
  end;

  Result := Len1 - Len2;
end;
{$WARNINGS ON}

{$WARNINGS OFF}
function CompareStr_EWC_PAS_2_c(const S1, S2: string): Integer;
var
  i: Integer;
  Len1: Integer;
  Len2: Integer;
  Cnt:  Integer;
  CntRem: Integer;
  Word1: PInteger;
  Word2: PInteger;
  Chr1: PByte;
  Chr2: PByte;
begin
  Len1 := Length(S1);
  Len2 := Length(S2);

  if Len1 < Len2 then
    begin
      CntRem := Len1 mod 4;
      Cnt    := Len1 shr 2;
    end
  else
    begin
      CntRem := Len2 mod 4;
      Cnt    := Len2 shr 2;
    end;

  if Len1 > 0 then
    Word1 := @S1[1];

  if Len2 > 0 then
    Word2 := @S2[1];

  i := 1;
  while i <= Cnt do
    begin
      if Word1^ <> Word2^ then
        begin
          //Determine which byte failed and return the value of this.
          // little-endian notation doesn't make treating a 4-byte string as
          // an integer very easy....
          Chr1 := PByte(Word1);
          Chr2 := PByte(Word2);
          Result := Chr1^ - Chr2^;
          if Result <> 0 then
            Exit;
          Inc(Chr1);
          Inc(Chr2);
          Result := Chr1^ - Chr2^;
          if Result <> 0 then
            Exit;
          Inc(Chr1);
          Inc(Chr2);
          Result := Chr1^ - Chr2^;
          if Result <> 0 then
            Exit;
          Inc(Chr1);
          Inc(Chr2);
          Result := Chr1^ - Chr2^;
          Exit;
        end;

      Inc(Word1);
      Inc(Word2);
      Inc(i);
    end;

  case CntRem of
    1:
      begin
        Chr1 := PByte(Word1);
        Chr2 := PByte(Word2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;
      end;
    2:
      begin
        Chr1 := PByte(Word1);
        Chr2 := PByte(Word2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;

        Inc(Chr1);
        Inc(Chr2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;
      end;
    3:
      begin
        Chr1 := PByte(Word1);
        Chr2 := PByte(Word2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;

        Inc(Chr1);
        Inc(Chr2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;

        Inc(Chr1);
        Inc(Chr2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;
      end;
  end;

  Result := Len1 - Len2;
end;
{$WARNINGS ON}

{$WARNINGS OFF}
function CompareStr_EWC_PAS_2_d(const S1, S2: string): Integer;
var
  i: Integer;
  Len1: Integer;
  Len2: Integer;
  Cnt:  Integer;
  CntRem: Integer;
  Word1: PInteger;
  Word2: PInteger;
  Chr1: PByte;
  Chr2: PByte;
begin
  Len1 := Length(S1);
  Len2 := Length(S2);

  if Len1 < Len2 then
    begin
      CntRem := Len1 mod 4;
      Cnt    := Len1 shr 2;
    end
  else
    begin
      CntRem := Len2 mod 4;
      Cnt    := Len2 shr 2;
    end;

  if Len1 > 0 then
    Word1 := @S1[1];

  if Len2 > 0 then
    Word2 := @S2[1];

  i := 1;
  while i <= Cnt do
    begin
      if Word1^ <> Word2^ then
        begin
          //Determine which byte failed and return the value of this.
          // little-endian notation doesn't make treating a 4-byte string as
          // an integer very easy....
          Chr1 := PByte(Word1);
          Chr2 := PByte(Word2);
          Result := Chr1^ - Chr2^;
          if Result <> 0 then
            Exit;
          Inc(Chr1);
          Inc(Chr2);
          Result := Chr1^ - Chr2^;
          if Result <> 0 then
            Exit;
          Inc(Chr1);
          Inc(Chr2);
          Result := Chr1^ - Chr2^;
          if Result <> 0 then
            Exit;
          Inc(Chr1);
          Inc(Chr2);
          Result := Chr1^ - Chr2^;
          Exit;
        end;

      Inc(Word1);
      Inc(Word2);
      Inc(i);
    end;

  case CntRem of
    1:
      begin
        Chr1 := PByte(Word1);
        Chr2 := PByte(Word2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;
      end;
    2:
      begin
        Chr1 := PByte(Word1);
        Chr2 := PByte(Word2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;

        Inc(Chr1);
        Inc(Chr2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;
      end;
    3:
      begin
        Chr1 := PByte(Word1);
        Chr2 := PByte(Word2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;

        Inc(Chr1);
        Inc(Chr2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;

        Inc(Chr1);
        Inc(Chr2);
        Result := Chr1^ - Chr2^;
        if Result <> 0 then
          Exit;
      end;
  end;

  Result := Len1 - Len2;
end;
{$WARNINGS ON}

initialization

 Filler1;
 Filler2;
 Filler3;

end.
