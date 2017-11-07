unit CompareMemPLRUnit;

interface

function CompareMem_PLR_IA32_1a(P1, P2: pointer; Length: integer): boolean;
function CompareMem_PLR_IA32_1b(P1, P2: pointer; Length: integer): boolean;
function CompareMem_PLR_IA32_1c(P1, P2: pointer; Length: integer): boolean;
function CompareMem_PLR_IA32_1d(P1, P2: pointer; Length: integer): boolean;
function CompareMem_PLR_IA32_2a(P1, P2: pointer; Length: integer): boolean;
function CompareMem_PLR_IA32_2b(P1, P2: pointer; Length: integer): boolean;
function CompareMem_PLR_IA32_2c(P1, P2: pointer; Length: integer): boolean;
function CompareMem_PLR_IA32_2d(P1, P2: pointer; Length: integer): boolean;
function CompareMem_PLR_IA32_3a(P1, P2: pointer; Length: integer): boolean;
function CompareMem_PLR_IA32_3b(P1, P2: pointer; Length: integer): boolean;
function CompareMem_PLR_IA32_3c(P1, P2: pointer; Length: integer): boolean;
function CompareMem_PLR_IA32_3d(P1, P2: pointer; Length: integer): boolean;

implementation

function CompareMem_PLR_IA32_1a(P1, P2: pointer; Length: integer): boolean;
asm
  {Subtract 8 from the count}
  sub ecx, 8
  jl @SmallCompare
  {Save registers}
  push ebx
  push esi
  {Compare the first 4 and last 8 bytes}
  mov ebx, [eax]
  xor ebx, [edx]
  {Point to the last 8 bytes}
  add eax, ecx
  add edx, ecx
  {Compare the last 8}
  mov esi, [eax]
  xor esi, [edx]
  or ebx, esi
  mov esi, [eax + 4]
  xor esi, [edx + 4]
  or ebx, esi
  jnz @Mismatch
  {Less than 12 to compare?}
  sub ecx, 4
  jle @Match
  {DWord align reads from P1 (P2 reads are not aligned)}
  neg ecx
  add ecx, eax
  and ecx, -4
  sub ecx, eax
  {Read chunks of 8 bytes at a time}
@CompareLoop:
  mov ebx, [eax + ecx]
  mov esi, [eax + ecx + 4]
  xor ebx, [edx + ecx]
  xor esi, [edx + ecx + 4]
  or ebx, esi
  jnz @Mismatch
  add ecx, 8
  jl @CompareLoop
@Match:
  pop esi
  pop ebx
@MatchSmall:
  mov al, True
  ret
@SmallCompare:
  add ecx, 8
  jle @MatchSmall
@SmallLoop:
  mov ch, [eax]
  xor ch, [edx]
  jnz @MismatchSmall
  add eax, 1
  add edx, 1
  sub cl, 1
  jnz @SmallLoop
  jmp @MatchSmall
@Mismatch:
  pop esi
  pop ebx
@MismatchSmall:
  xor eax, eax
end;

function CompareMem_PLR_IA32_1b(P1, P2: pointer; Length: integer): boolean;
asm
  {Subtract 8 from the count}
  sub ecx, 8
  jl @SmallCompare
  {Save registers}
  push ebx
  push esi
  {Compare the first 4 and last 8 bytes}
  mov ebx, [eax]
  xor ebx, [edx]
  {Point to the last 8 bytes}
  add eax, ecx
  add edx, ecx
  {Compare the last 8}
  mov esi, [eax]
  xor esi, [edx]
  or ebx, esi
  mov esi, [eax + 4]
  xor esi, [edx + 4]
  or ebx, esi
  jnz @Mismatch
  {Less than 12 to compare?}
  sub ecx, 4
  jle @Match
  {DWord align reads from P1 (P2 reads are not aligned)}
  neg ecx
  add ecx, eax
  and ecx, -4
  sub ecx, eax
  {Read chunks of 8 bytes at a time}
@CompareLoop:
  mov ebx, [eax + ecx]
  mov esi, [eax + ecx + 4]
  xor ebx, [edx + ecx]
  xor esi, [edx + ecx + 4]
  or ebx, esi
  jnz @Mismatch
  add ecx, 8
  jl @CompareLoop
@Match:
  pop esi
  pop ebx
@MatchSmall:
  mov al, True
  ret
@SmallCompare:
  add ecx, 8
  jle @MatchSmall
@SmallLoop:
  mov ch, [eax]
  xor ch, [edx]
  jnz @MismatchSmall
  add eax, 1
  add edx, 1
  sub cl, 1
  jnz @SmallLoop
  jmp @MatchSmall
@Mismatch:
  pop esi
  pop ebx
@MismatchSmall:
  xor eax, eax
end;

procedure Filler1;
asm
  nop
end;

function CompareMem_PLR_IA32_1c(P1, P2: pointer; Length: integer): boolean;
asm
  {Subtract 8 from the count}
  sub ecx, 8
  jl @SmallCompare
  {Save registers}
  push ebx
  push esi
  {Compare the first 4 and last 8 bytes}
  mov ebx, [eax]
  xor ebx, [edx]
  {Point to the last 8 bytes}
  add eax, ecx
  add edx, ecx
  {Compare the last 8}
  mov esi, [eax]
  xor esi, [edx]
  or ebx, esi
  mov esi, [eax + 4]
  xor esi, [edx + 4]
  or ebx, esi
  jnz @Mismatch
  {Less than 12 to compare?}
  sub ecx, 4
  jle @Match
  {DWord align reads from P1 (P2 reads are not aligned)}
  neg ecx
  add ecx, eax
  and ecx, -4
  sub ecx, eax
  {Read chunks of 8 bytes at a time}
@CompareLoop:
  mov ebx, [eax + ecx]
  mov esi, [eax + ecx + 4]
  xor ebx, [edx + ecx]
  xor esi, [edx + ecx + 4]
  or ebx, esi
  jnz @Mismatch
  add ecx, 8
  jl @CompareLoop
@Match:
  pop esi
  pop ebx
@MatchSmall:
  mov al, True
  ret
@SmallCompare:
  add ecx, 8
  jle @MatchSmall
@SmallLoop:
  mov ch, [eax]
  xor ch, [edx]
  jnz @MismatchSmall
  add eax, 1
  add edx, 1
  sub cl, 1
  jnz @SmallLoop
  jmp @MatchSmall
@Mismatch:
  pop esi
  pop ebx
@MismatchSmall:
  xor eax, eax
end;

function CompareMem_PLR_IA32_1d(P1, P2: pointer; Length: integer): boolean;
asm
  {Subtract 8 from the count}
  sub ecx, 8
  jl @SmallCompare
  {Save registers}
  push ebx
  push esi
  {Compare the first 4 and last 8 bytes}
  mov ebx, [eax]
  xor ebx, [edx]
  {Point to the last 8 bytes}
  add eax, ecx
  add edx, ecx
  {Compare the last 8}
  mov esi, [eax]
  xor esi, [edx]
  or ebx, esi
  mov esi, [eax + 4]
  xor esi, [edx + 4]
  or ebx, esi
  jnz @Mismatch
  {Less than 12 to compare?}
  sub ecx, 4
  jle @Match
  {DWord align reads from P1 (P2 reads are not aligned)}
  neg ecx
  add ecx, eax
  and ecx, -4
  sub ecx, eax
  {Read chunks of 8 bytes at a time}
@CompareLoop:
  mov ebx, [eax + ecx]
  mov esi, [eax + ecx + 4]
  xor ebx, [edx + ecx]
  xor esi, [edx + ecx + 4]
  or ebx, esi
  jnz @Mismatch
  add ecx, 8
  jl @CompareLoop
@Match:
  pop esi
  pop ebx
@MatchSmall:
  mov al, True
  ret
@SmallCompare:
  add ecx, 8
  jle @MatchSmall
@SmallLoop:
  mov ch, [eax]
  xor ch, [edx]
  jnz @MismatchSmall
  add eax, 1
  add edx, 1
  sub cl, 1
  jnz @SmallLoop
  jmp @MatchSmall
@Mismatch:
  pop esi
  pop ebx
@MismatchSmall:
  xor eax, eax
end;

function CompareMem_PLR_IA32_2a(P1, P2: pointer; Length: integer): boolean;
asm
  {Less than a qword to compare?}
  sub ecx, 8
  jl @VerySmallCompare
  {save ebx}
  push ebx
  {Compare first dword}
  mov ebx, [eax]
  cmp ebx, [edx]
  je @FirstFourMatches
@InitialMismatch:
  xor eax, eax
  pop ebx
  ret
@FirstFourMatches:
  {Point eax and edx to the last 8 bytes}
  add eax, ecx
  add edx, ecx
  {Compare the second last dword}
  mov ebx, [eax]
  cmp ebx, [edx]
  jne @InitialMismatch
  {Compare the last dword}
  mov ebx, [eax + 4]
  cmp ebx, [edx + 4]
  jne @InitialMismatch
  {12 or less bytes to compare?}
  sub ecx, 4
  jle @InitialMatch
  {Save esi}
  push esi
  {DWord align reads from P1 (P2 reads are not aligned)}
  neg ecx
  add ecx, eax
  and ecx, -4
  sub ecx, eax
  {Compare chunks of 8 bytes at a time}
@CompareLoop:
  mov ebx, [eax + ecx]
  mov esi, [eax + ecx + 4]
  xor ebx, [edx + ecx]
  xor esi, [edx + ecx + 4]
  or ebx, esi
  jnz @LargeMismatch
  add ecx, 8
  jl @CompareLoop
  pop esi
@InitialMatch:
  pop ebx
@MatchSmall:
  mov al, True
  ret
@VerySmallCompare:
  add ecx, 8
  jle @MatchSmall
@SmallLoop:
  mov ch, [eax]
  xor ch, [edx]
  jnz @MismatchSmall
  add eax, 1
  add edx, 1
  sub cl, 1
  jnz @SmallLoop
  jmp @MatchSmall
@LargeMismatch:
  pop esi
  pop ebx
@MismatchSmall:
  xor eax, eax
end;

function CompareMem_PLR_IA32_2b(P1, P2: pointer; Length: integer): boolean;
asm
  {Less than a qword to compare?}
  sub ecx, 8
  jl @VerySmallCompare
  {save ebx}
  push ebx
  {Compare first dword}
  mov ebx, [eax]
  cmp ebx, [edx]
  je @FirstFourMatches
@InitialMismatch:
  xor eax, eax
  pop ebx
  ret
@FirstFourMatches:
  {Point eax and edx to the last 8 bytes}
  add eax, ecx
  add edx, ecx
  {Compare the second last dword}
  mov ebx, [eax]
  cmp ebx, [edx]
  jne @InitialMismatch
  {Compare the last dword}
  mov ebx, [eax + 4]
  cmp ebx, [edx + 4]
  jne @InitialMismatch
  {12 or less bytes to compare?}
  sub ecx, 4
  jle @InitialMatch
  {Save esi}
  push esi
  {DWord align reads from P1 (P2 reads are not aligned)}
  neg ecx
  add ecx, eax
  and ecx, -4
  sub ecx, eax
  {Compare chunks of 8 bytes at a time}
@CompareLoop:
  mov ebx, [eax + ecx]
  mov esi, [eax + ecx + 4]
  xor ebx, [edx + ecx]
  xor esi, [edx + ecx + 4]
  or ebx, esi
  jnz @LargeMismatch
  add ecx, 8
  jl @CompareLoop
  pop esi
@InitialMatch:
  pop ebx
@MatchSmall:
  mov al, True
  ret
@VerySmallCompare:
  add ecx, 8
  jle @MatchSmall
@SmallLoop:
  mov ch, [eax]
  xor ch, [edx]
  jnz @MismatchSmall
  add eax, 1
  add edx, 1
  sub cl, 1
  jnz @SmallLoop
  jmp @MatchSmall
@LargeMismatch:
  pop esi
  pop ebx
@MismatchSmall:
  xor eax, eax
end;

function CompareMem_PLR_IA32_2c(P1, P2: pointer; Length: integer): boolean;
asm
  {Less than a qword to compare?}
  sub ecx, 8
  jl @VerySmallCompare
  {save ebx}
  push ebx
  {Compare first dword}
  mov ebx, [eax]
  cmp ebx, [edx]
  je @FirstFourMatches
@InitialMismatch:
  xor eax, eax
  pop ebx
  ret
@FirstFourMatches:
  {Point eax and edx to the last 8 bytes}
  add eax, ecx
  add edx, ecx
  {Compare the second last dword}
  mov ebx, [eax]
  cmp ebx, [edx]
  jne @InitialMismatch
  {Compare the last dword}
  mov ebx, [eax + 4]
  cmp ebx, [edx + 4]
  jne @InitialMismatch
  {12 or less bytes to compare?}
  sub ecx, 4
  jle @InitialMatch
  {Save esi}
  push esi
  {DWord align reads from P1 (P2 reads are not aligned)}
  neg ecx
  add ecx, eax
  and ecx, -4
  sub ecx, eax
  {Compare chunks of 8 bytes at a time}
@CompareLoop:
  mov ebx, [eax + ecx]
  mov esi, [eax + ecx + 4]
  xor ebx, [edx + ecx]
  xor esi, [edx + ecx + 4]
  or ebx, esi
  jnz @LargeMismatch
  add ecx, 8
  jl @CompareLoop
  pop esi
@InitialMatch:
  pop ebx
@MatchSmall:
  mov al, True
  ret
@VerySmallCompare:
  add ecx, 8
  jle @MatchSmall
@SmallLoop:
  mov ch, [eax]
  xor ch, [edx]
  jnz @MismatchSmall
  add eax, 1
  add edx, 1
  sub cl, 1
  jnz @SmallLoop
  jmp @MatchSmall
@LargeMismatch:
  pop esi
  pop ebx
@MismatchSmall:
  xor eax, eax
end;

function CompareMem_PLR_IA32_2d(P1, P2: pointer; Length: integer): boolean;
asm
  {Less than a qword to compare?}
  sub ecx, 8
  jl @VerySmallCompare
  {save ebx}
  push ebx
  {Compare first dword}
  mov ebx, [eax]
  cmp ebx, [edx]
  je @FirstFourMatches
@InitialMismatch:
  xor eax, eax
  pop ebx
  ret
@FirstFourMatches:
  {Point eax and edx to the last 8 bytes}
  add eax, ecx
  add edx, ecx
  {Compare the second last dword}
  mov ebx, [eax]
  cmp ebx, [edx]
  jne @InitialMismatch
  {Compare the last dword}
  mov ebx, [eax + 4]
  cmp ebx, [edx + 4]
  jne @InitialMismatch
  {12 or less bytes to compare?}
  sub ecx, 4
  jle @InitialMatch
  {Save esi}
  push esi
  {DWord align reads from P1 (P2 reads are not aligned)}
  neg ecx
  add ecx, eax
  and ecx, -4
  sub ecx, eax
  {Compare chunks of 8 bytes at a time}
@CompareLoop:
  mov ebx, [eax + ecx]
  mov esi, [eax + ecx + 4]
  xor ebx, [edx + ecx]
  xor esi, [edx + ecx + 4]
  or ebx, esi
  jnz @LargeMismatch
  add ecx, 8
  jl @CompareLoop
  pop esi
@InitialMatch:
  pop ebx
@MatchSmall:
  mov al, True
  ret
@VerySmallCompare:
  add ecx, 8
  jle @MatchSmall
@SmallLoop:
  mov ch, [eax]
  xor ch, [edx]
  jnz @MismatchSmall
  add eax, 1
  add edx, 1
  sub cl, 1
  jnz @SmallLoop
  jmp @MatchSmall
@LargeMismatch:
  pop esi
  pop ebx
@MismatchSmall:
  xor eax, eax
end;

function CompareMem_PLR_IA32_3a(P1, P2: pointer; Length: integer): boolean;
asm
  {Negate the count. (Anything to compare?)}
  neg ecx
  jns @NoCompare
  {Save ebx}
  push ebx
  {Less than a qword to compare?}
  add ecx, 8
  jg @VerySmallCompare
  {Compare the first dword}
  mov ebx, [eax]
  cmp ebx, [edx]
  jne @Mismatch
  {Point eax and edx to the last qword}
  sub eax, ecx
  sub edx, ecx
  {Compare the second last dword}
  mov ebx, [eax]
  cmp ebx, [edx]
  jne @Mismatch
  {Compare the last dword}
  mov ebx, [eax + 4]
  cmp ebx, [edx + 4]
  jne @Mismatch
  {Medium compare?}
  add ecx, 36
  jge @MediumCompare
  {Save esi}
  push esi
  {DWord align reads from P1}
  lea ecx, [ecx + eax - 32]
  and ecx, -4
  sub ecx, eax
@CompareLoop:
  mov ebx, [eax + ecx]
  mov esi, [eax + ecx + 4]
  xor ebx, [edx + ecx]
  xor esi, [edx + ecx + 4]
  or ebx, esi
  jnz @LargeMismatch
  add ecx, 8
  js @CompareLoop
  pop esi
@Match:
  pop ebx
@NoCompare:
  mov al, True
  ret
@LargeMismatch:
  pop esi
@Mismatch:
  xor eax, eax
  pop ebx
  ret
  {Compare 1 to 3 bytes}
@VerySmallCompare:
  {Compare the first byte}
  mov bl, [eax]
  xor bl, [edx]
  lea ecx, [@SmallCompareOffset + ecx * 8 - 8]
  jmp ecx
@SmallCompareOffset:
  {Offset + 6}
  mov cl, [eax + 6]
  xor cl, [edx + 6]
  or bl, cl
  {Offset + 5}
  mov cl, [eax + 5]
  xor cl, [edx + 5]
  or bl, cl
  {Offset + 4}
  mov cl, [eax + 4]
  xor cl, [edx + 4]
  or bl, cl
  {Offset + 3}
  mov cl, [eax + 3]
  xor cl, [edx + 3]
  or bl, cl
  {Offset + 2}
  mov cl, [eax + 2]
  xor cl, [edx + 2]
  or bl, cl
  {Offset + 1}
  mov cl, [eax + 1]
  xor cl, [edx + 1]
  or bl, cl
  setz al
  pop ebx
  ret
@MediumCompare:
  and ecx, -4
  lea ecx, [@MediumCompareOffset + ecx * 2]
  xor ebx, ebx
  jmp ecx
@MediumCompareOffset:
  {When comparing 41 - 44 bytes}
  mov ecx, [eax - 32]
  xor ecx, [edx - 32]
  or ebx, ecx
  {When comparing 37 - 40 bytes}
  mov ecx, [eax - 28]
  xor ecx, [edx - 28]
  or ebx, ecx
  {When comparing 33 - 36 bytes}
  mov ecx, [eax - 24]
  xor ecx, [edx - 24]
  or ebx, ecx
  {When comparing 29 - 32 bytes}
  mov ecx, [eax - 20]
  xor ecx, [edx - 20]
  or ebx, ecx
  {When comparing 25 - 28 bytes}
  mov ecx, [eax - 16]
  xor ecx, [edx - 16]
  or ebx, ecx
  {When comparing 21 - 24 bytes}
  mov ecx, [eax - 12]
  xor ecx, [edx - 12]
  or ebx, ecx
  {When comparing 17 - 20 bytes}
  mov ecx, [eax - 8]
  xor ecx, [edx - 8]
  or ebx, ecx
  {When comparing 13 - 16 bytes}
  mov ecx, [eax - 4]
  xor ecx, [edx - 4]
  or ebx, ecx
  {When comparing 9 - 12 bytes}
  setz al
  pop ebx
  ret
  nop
  nop
  nop
  {When comparing 8 bytes}
  mov al, True
  pop ebx
  ret
end;

procedure Filler2;
asm
  nop;
end;

function CompareMem_PLR_IA32_3b(P1, P2: pointer; Length: integer): boolean;
asm
  {Negate the count. (Anything to compare?)}
  neg ecx
  jns @NoCompare
  {Save ebx}
  push ebx
  {Less than a qword to compare?}
  add ecx, 8
  jg @VerySmallCompare
  {Compare the first dword}
  mov ebx, [eax]
  cmp ebx, [edx]
  jne @Mismatch
  {Point eax and edx to the last qword}
  sub eax, ecx
  sub edx, ecx
  {Compare the second last dword}
  mov ebx, [eax]
  cmp ebx, [edx]
  jne @Mismatch
  {Compare the last dword}
  mov ebx, [eax + 4]
  cmp ebx, [edx + 4]
  jne @Mismatch
  {Medium compare?}
  add ecx, 36
  jge @MediumCompare
  {Save esi}
  push esi
  {DWord align reads from P1}
  lea ecx, [ecx + eax - 32]
  and ecx, -4
  sub ecx, eax
@CompareLoop:
  mov ebx, [eax + ecx]
  mov esi, [eax + ecx + 4]
  xor ebx, [edx + ecx]
  xor esi, [edx + ecx + 4]
  or ebx, esi
  jnz @LargeMismatch
  add ecx, 8
  js @CompareLoop
  pop esi
@Match:
  pop ebx
@NoCompare:
  mov al, True
  ret
@LargeMismatch:
  pop esi
@Mismatch:
  xor eax, eax
  pop ebx
  ret
  {Compare 1 to 3 bytes}
@VerySmallCompare:
  {Compare the first byte}
  mov bl, [eax]
  xor bl, [edx]
  lea ecx, [@SmallCompareOffset + ecx * 8 - 8]
  jmp ecx
@SmallCompareOffset:
  {Offset + 6}
  mov cl, [eax + 6]
  xor cl, [edx + 6]
  or bl, cl
  {Offset + 5}
  mov cl, [eax + 5]
  xor cl, [edx + 5]
  or bl, cl
  {Offset + 4}
  mov cl, [eax + 4]
  xor cl, [edx + 4]
  or bl, cl
  {Offset + 3}
  mov cl, [eax + 3]
  xor cl, [edx + 3]
  or bl, cl
  {Offset + 2}
  mov cl, [eax + 2]
  xor cl, [edx + 2]
  or bl, cl
  {Offset + 1}
  mov cl, [eax + 1]
  xor cl, [edx + 1]
  or bl, cl
  setz al
  pop ebx
  ret
@MediumCompare:
  and ecx, -4
  lea ecx, [@MediumCompareOffset + ecx * 2]
  xor ebx, ebx
  jmp ecx
@MediumCompareOffset:
  {When comparing 41 - 44 bytes}
  mov ecx, [eax - 32]
  xor ecx, [edx - 32]
  or ebx, ecx
  {When comparing 37 - 40 bytes}
  mov ecx, [eax - 28]
  xor ecx, [edx - 28]
  or ebx, ecx
  {When comparing 33 - 36 bytes}
  mov ecx, [eax - 24]
  xor ecx, [edx - 24]
  or ebx, ecx
  {When comparing 29 - 32 bytes}
  mov ecx, [eax - 20]
  xor ecx, [edx - 20]
  or ebx, ecx
  {When comparing 25 - 28 bytes}
  mov ecx, [eax - 16]
  xor ecx, [edx - 16]
  or ebx, ecx
  {When comparing 21 - 24 bytes}
  mov ecx, [eax - 12]
  xor ecx, [edx - 12]
  or ebx, ecx
  {When comparing 17 - 20 bytes}
  mov ecx, [eax - 8]
  xor ecx, [edx - 8]
  or ebx, ecx
  {When comparing 13 - 16 bytes}
  mov ecx, [eax - 4]
  xor ecx, [edx - 4]
  or ebx, ecx
  {When comparing 9 - 12 bytes}
  setz al
  pop ebx
  ret
  nop
  nop
  nop
  {When comparing 8 bytes}
  mov al, True
  pop ebx
  ret
end;

procedure Filler3;
asm
  nop;
end;

function CompareMem_PLR_IA32_3c(P1, P2: pointer; Length: integer): boolean;
asm
  {Negate the count. (Anything to compare?)}
  neg ecx
  jns @NoCompare
  {Save ebx}
  push ebx
  {Less than a qword to compare?}
  add ecx, 8
  jg @VerySmallCompare
  {Compare the first dword}
  mov ebx, [eax]
  cmp ebx, [edx]
  jne @Mismatch
  {Point eax and edx to the last qword}
  sub eax, ecx
  sub edx, ecx
  {Compare the second last dword}
  mov ebx, [eax]
  cmp ebx, [edx]
  jne @Mismatch
  {Compare the last dword}
  mov ebx, [eax + 4]
  cmp ebx, [edx + 4]
  jne @Mismatch
  {Medium compare?}
  add ecx, 36
  jge @MediumCompare
  {Save esi}
  push esi
  {DWord align reads from P1}
  lea ecx, [ecx + eax - 32]
  and ecx, -4
  sub ecx, eax
@CompareLoop:
  mov ebx, [eax + ecx]
  mov esi, [eax + ecx + 4]
  xor ebx, [edx + ecx]
  xor esi, [edx + ecx + 4]
  or ebx, esi
  jnz @LargeMismatch
  add ecx, 8
  js @CompareLoop
  pop esi
@Match:
  pop ebx
@NoCompare:
  mov al, True
  ret
@LargeMismatch:
  pop esi
@Mismatch:
  xor eax, eax
  pop ebx
  ret
  {Compare 1 to 3 bytes}
@VerySmallCompare:
  {Compare the first byte}
  mov bl, [eax]
  xor bl, [edx]
  lea ecx, [@SmallCompareOffset + ecx * 8 - 8]
  jmp ecx
@SmallCompareOffset:
  {Offset + 6}
  mov cl, [eax + 6]
  xor cl, [edx + 6]
  or bl, cl
  {Offset + 5}
  mov cl, [eax + 5]
  xor cl, [edx + 5]
  or bl, cl
  {Offset + 4}
  mov cl, [eax + 4]
  xor cl, [edx + 4]
  or bl, cl
  {Offset + 3}
  mov cl, [eax + 3]
  xor cl, [edx + 3]
  or bl, cl
  {Offset + 2}
  mov cl, [eax + 2]
  xor cl, [edx + 2]
  or bl, cl
  {Offset + 1}
  mov cl, [eax + 1]
  xor cl, [edx + 1]
  or bl, cl
  setz al
  pop ebx
  ret
@MediumCompare:
  and ecx, -4
  lea ecx, [@MediumCompareOffset + ecx * 2]
  xor ebx, ebx
  jmp ecx
@MediumCompareOffset:
  {When comparing 41 - 44 bytes}
  mov ecx, [eax - 32]
  xor ecx, [edx - 32]
  or ebx, ecx
  {When comparing 37 - 40 bytes}
  mov ecx, [eax - 28]
  xor ecx, [edx - 28]
  or ebx, ecx
  {When comparing 33 - 36 bytes}
  mov ecx, [eax - 24]
  xor ecx, [edx - 24]
  or ebx, ecx
  {When comparing 29 - 32 bytes}
  mov ecx, [eax - 20]
  xor ecx, [edx - 20]
  or ebx, ecx
  {When comparing 25 - 28 bytes}
  mov ecx, [eax - 16]
  xor ecx, [edx - 16]
  or ebx, ecx
  {When comparing 21 - 24 bytes}
  mov ecx, [eax - 12]
  xor ecx, [edx - 12]
  or ebx, ecx
  {When comparing 17 - 20 bytes}
  mov ecx, [eax - 8]
  xor ecx, [edx - 8]
  or ebx, ecx
  {When comparing 13 - 16 bytes}
  mov ecx, [eax - 4]
  xor ecx, [edx - 4]
  or ebx, ecx
  {When comparing 9 - 12 bytes}
  setz al
  pop ebx
  ret
  nop
  nop
  nop
  {When comparing 8 bytes}
  mov al, True
  pop ebx
  ret
end;

procedure Filler4;
asm
  nop;
end;

function CompareMem_PLR_IA32_3d(P1, P2: pointer; Length: integer): boolean;
asm
  {Negate the count. (Anything to compare?)}
  neg ecx
  jns @NoCompare
  {Save ebx}
  push ebx
  {Less than a qword to compare?}
  add ecx, 8
  jg @VerySmallCompare
  {Compare the first dword}
  mov ebx, [eax]
  cmp ebx, [edx]
  jne @Mismatch
  {Point eax and edx to the last qword}
  sub eax, ecx
  sub edx, ecx
  {Compare the second last dword}
  mov ebx, [eax]
  cmp ebx, [edx]
  jne @Mismatch
  {Compare the last dword}
  mov ebx, [eax + 4]
  cmp ebx, [edx + 4]
  jne @Mismatch
  {Medium compare?}
  add ecx, 36
  jge @MediumCompare
  {Save esi}
  push esi
  {DWord align reads from P1}
  lea ecx, [ecx + eax - 32]
  and ecx, -4
  sub ecx, eax
@CompareLoop:
  mov ebx, [eax + ecx]
  mov esi, [eax + ecx + 4]
  xor ebx, [edx + ecx]
  xor esi, [edx + ecx + 4]
  or ebx, esi
  jnz @LargeMismatch
  add ecx, 8
  js @CompareLoop
  pop esi
@Match:
  pop ebx
@NoCompare:
  mov al, True
  ret
@LargeMismatch:
  pop esi
@Mismatch:
  xor eax, eax
  pop ebx
  ret
  {Compare 1 to 3 bytes}
@VerySmallCompare:
  {Compare the first byte}
  mov bl, [eax]
  xor bl, [edx]
  lea ecx, [@SmallCompareOffset + ecx * 8 - 8]
  jmp ecx
@SmallCompareOffset:
  {Offset + 6}
  mov cl, [eax + 6]
  xor cl, [edx + 6]
  or bl, cl
  {Offset + 5}
  mov cl, [eax + 5]
  xor cl, [edx + 5]
  or bl, cl
  {Offset + 4}
  mov cl, [eax + 4]
  xor cl, [edx + 4]
  or bl, cl
  {Offset + 3}
  mov cl, [eax + 3]
  xor cl, [edx + 3]
  or bl, cl
  {Offset + 2}
  mov cl, [eax + 2]
  xor cl, [edx + 2]
  or bl, cl
  {Offset + 1}
  mov cl, [eax + 1]
  xor cl, [edx + 1]
  or bl, cl
  setz al
  pop ebx
  ret
@MediumCompare:
  and ecx, -4
  lea ecx, [@MediumCompareOffset + ecx * 2]
  xor ebx, ebx
  jmp ecx
@MediumCompareOffset:
  {When comparing 41 - 44 bytes}
  mov ecx, [eax - 32]
  xor ecx, [edx - 32]
  or ebx, ecx
  {When comparing 37 - 40 bytes}
  mov ecx, [eax - 28]
  xor ecx, [edx - 28]
  or ebx, ecx
  {When comparing 33 - 36 bytes}
  mov ecx, [eax - 24]
  xor ecx, [edx - 24]
  or ebx, ecx
  {When comparing 29 - 32 bytes}
  mov ecx, [eax - 20]
  xor ecx, [edx - 20]
  or ebx, ecx
  {When comparing 25 - 28 bytes}
  mov ecx, [eax - 16]
  xor ecx, [edx - 16]
  or ebx, ecx
  {When comparing 21 - 24 bytes}
  mov ecx, [eax - 12]
  xor ecx, [edx - 12]
  or ebx, ecx
  {When comparing 17 - 20 bytes}
  mov ecx, [eax - 8]
  xor ecx, [edx - 8]
  or ebx, ecx
  {When comparing 13 - 16 bytes}
  mov ecx, [eax - 4]
  xor ecx, [edx - 4]
  or ebx, ecx
  {When comparing 9 - 12 bytes}
  setz al
  pop ebx
  ret
  nop
  nop
  nop
  {When comparing 8 bytes}
  mov al, True
  pop ebx
  ret
end;

initialization
  Filler1;
  Filler2;
  Filler3;
  Filler4;

end.
