unit CompareStrPLRUnit;

interface

{IA32 entries}
function CompareStr_PLR_IA32_11a(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_11b(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_11c(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_11d(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_12a(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_12b(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_12c(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_12d(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_14a(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_14b(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_14c(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_14d(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_15a(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_15b(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_15c(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_15d(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_16a(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_16b(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_16c(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_16d(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_17a(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_17b(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_17c(const S1, S2: string): Integer;
function CompareStr_PLR_IA32_17d(const S1, S2: string): Integer;
{Pascal entry}
function CompareStr_PLR_PAS_1_a(const S1, S2: string): Integer;
function CompareStr_PLR_PAS_1_b(const S1, S2: string): Integer;
function CompareStr_PLR_PAS_1_c(const S1, S2: string): Integer;
function CompareStr_PLR_PAS_1_d(const S1, S2: string): Integer;

implementation

uses
  SysUtils;

//CPU Target: IA32, Size = 121 Bytes
function CompareStr_PLR_IA32_11a(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first character (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  movzx ecx, byte ptr [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {The first character differs}
  movzx eax, byte ptr [eax]
  sub eax, ecx
  ret
@FirstCharacterSame:
  {Save edi}
  push edi
  {set edi = length(S1)}
  mov edi, [eax - 4]
  {Save esi}
  push esi
  xor esi, esi
  mov ecx, edi
  {set edi = length(S1) - length(S2)}
  sub edi, [edx - 4]
  {set esi = 0 if length(S1) < length(S2), -1 otherwise}
  adc esi, -1
  {set esi = - min(length(s1), length(s2))}
  and esi, edi
  sub esi, ecx
  {Save ebx}
  push ebx
  {non-nil zero-length string?}
  jz @MatchUpToLength
  {Adjust the pointers to be negative based}
  sub eax, esi
  sub edx, esi
@CompareLoop:
  mov ebx, [eax + esi]
  mov ecx, [edx + esi]
  cmp ebx, ecx
  jne @Mismatch
  add esi, 4
  js @CompareLoop
  {All characters match - return the difference in length}
@MatchUpToLength:
  mov eax, edi
  pop ebx
  pop esi
  pop edi
  ret
@Mismatch:
  {There was a mismatch, but we may have compared up to three characters too
   many: Compare the first two characters (there must be a trailing #0)}
  cmp bx, cx
  je @FirstTwoMatches
@ActualMismatch:
  movzx eax, bh
  mov ah, bl
  movzx edx, ch
  mov dh, cl
  sub eax, edx
  pop ebx
  pop esi
  pop edi
  ret
@FirstTwoMatches:
  {The first two characters are the same. Have we compared two or three characters
   too many?}
  cmp esi, -3
  jg @MatchUpToLength
  {We've compared 1 or less character too many. There is always a trailing #0,
   so we can compare the rest safely.}
  shr ebx, 16
  shr ecx, 16
  jmp @ActualMismatch
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
end;

//CPU Target: IA32, Size = 121 Bytes
function CompareStr_PLR_IA32_11b(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first character (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  movzx ecx, byte ptr [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {The first character differs}
  movzx eax, byte ptr [eax]
  sub eax, ecx
  ret
@FirstCharacterSame:
  {Save edi}
  push edi
  {set edi = length(S1)}
  mov edi, [eax - 4]
  {Save esi}
  push esi
  xor esi, esi
  mov ecx, edi
  {set edi = length(S1) - length(S2)}
  sub edi, [edx - 4]
  {set esi = 0 if length(S1) < length(S2), -1 otherwise}
  adc esi, -1
  {set esi = - min(length(s1), length(s2))}
  and esi, edi
  sub esi, ecx
  {Save ebx}
  push ebx
  {non-nil zero-length string?}
  jz @MatchUpToLength
  {Adjust the pointers to be negative based}
  sub eax, esi
  sub edx, esi
@CompareLoop:
  mov ebx, [eax + esi]
  mov ecx, [edx + esi]
  cmp ebx, ecx
  jne @Mismatch
  add esi, 4
  js @CompareLoop
  {All characters match - return the difference in length}
@MatchUpToLength:
  mov eax, edi
  pop ebx
  pop esi
  pop edi
  ret
@Mismatch:
  {There was a mismatch, but we may have compared up to three characters too
   many: Compare the first two characters (there must be a trailing #0)}
  cmp bx, cx
  je @FirstTwoMatches
@ActualMismatch:
  movzx eax, bh
  mov ah, bl
  movzx edx, ch
  mov dh, cl
  sub eax, edx
  pop ebx
  pop esi
  pop edi
  ret
@FirstTwoMatches:
  {The first two characters are the same. Have we compared two or three characters
   too many?}
  cmp esi, -3
  jg @MatchUpToLength
  {We've compared 1 or less character too many. There is always a trailing #0,
   so we can compare the rest safely.}
  shr ebx, 16
  shr ecx, 16
  jmp @ActualMismatch
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
end;

//CPU Target: IA32, Size = 121 Bytes
function CompareStr_PLR_IA32_11c(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first character (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  movzx ecx, byte ptr [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {The first character differs}
  movzx eax, byte ptr [eax]
  sub eax, ecx
  ret
@FirstCharacterSame:
  {Save edi}
  push edi
  {set edi = length(S1)}
  mov edi, [eax - 4]
  {Save esi}
  push esi
  xor esi, esi
  mov ecx, edi
  {set edi = length(S1) - length(S2)}
  sub edi, [edx - 4]
  {set esi = 0 if length(S1) < length(S2), -1 otherwise}
  adc esi, -1
  {set esi = - min(length(s1), length(s2))}
  and esi, edi
  sub esi, ecx
  {Save ebx}
  push ebx
  {non-nil zero-length string?}
  jz @MatchUpToLength
  {Adjust the pointers to be negative based}
  sub eax, esi
  sub edx, esi
@CompareLoop:
  mov ebx, [eax + esi]
  mov ecx, [edx + esi]
  cmp ebx, ecx
  jne @Mismatch
  add esi, 4
  js @CompareLoop
  {All characters match - return the difference in length}
@MatchUpToLength:
  mov eax, edi
  pop ebx
  pop esi
  pop edi
  ret
@Mismatch:
  {There was a mismatch, but we may have compared up to three characters too
   many: Compare the first two characters (there must be a trailing #0)}
  cmp bx, cx
  je @FirstTwoMatches
@ActualMismatch:
  movzx eax, bh
  mov ah, bl
  movzx edx, ch
  mov dh, cl
  sub eax, edx
  pop ebx
  pop esi
  pop edi
  ret
@FirstTwoMatches:
  {The first two characters are the same. Have we compared two or three characters
   too many?}
  cmp esi, -3
  jg @MatchUpToLength
  {We've compared 1 or less character too many. There is always a trailing #0,
   so we can compare the rest safely.}
  shr ebx, 16
  shr ecx, 16
  jmp @ActualMismatch
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
end;

//CPU Target: IA32, Size = 121 Bytes
function CompareStr_PLR_IA32_11d(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first character (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  movzx ecx, byte ptr [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {The first character differs}
  movzx eax, byte ptr [eax]
  sub eax, ecx
  ret
@FirstCharacterSame:
  {Save edi}
  push edi
  {set edi = length(S1)}
  mov edi, [eax - 4]
  {Save esi}
  push esi
  xor esi, esi
  mov ecx, edi
  {set edi = length(S1) - length(S2)}
  sub edi, [edx - 4]
  {set esi = 0 if length(S1) < length(S2), -1 otherwise}
  adc esi, -1
  {set esi = - min(length(s1), length(s2))}
  and esi, edi
  sub esi, ecx
  {Save ebx}
  push ebx
  {non-nil zero-length string?}
  jz @MatchUpToLength
  {Adjust the pointers to be negative based}
  sub eax, esi
  sub edx, esi
@CompareLoop:
  mov ebx, [eax + esi]
  mov ecx, [edx + esi]
  cmp ebx, ecx
  jne @Mismatch
  add esi, 4
  js @CompareLoop
  {All characters match - return the difference in length}
@MatchUpToLength:
  mov eax, edi
  pop ebx
  pop esi
  pop edi
  ret
@Mismatch:
  {There was a mismatch, but we may have compared up to three characters too
   many: Compare the first two characters (there must be a trailing #0)}
  cmp bx, cx
  je @FirstTwoMatches
@ActualMismatch:
  movzx eax, bh
  mov ah, bl
  movzx edx, ch
  mov dh, cl
  sub eax, edx
  pop ebx
  pop esi
  pop edi
  ret
@FirstTwoMatches:
  {The first two characters are the same. Have we compared two or three characters
   too many?}
  cmp esi, -3
  jg @MatchUpToLength
  {We've compared 1 or less character too many. There is always a trailing #0,
   so we can compare the rest safely.}
  shr ebx, 16
  shr ecx, 16
  jmp @ActualMismatch
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
end;

//CPU Target: IA32, Size = 173 Bytes
function CompareStr_PLR_IA32_12a(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  mov ecx, [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  movzx ecx, cl
  sub eax, ecx
  ret
@FirstCharacterSame:
  {save ebx}
  push ebx
  {Get first four characters}
  mov ebx, [eax]
  cmp ebx, ecx
  je @FirstFourSame
  {Get the string lengths in eax and edx}
  mov eax, [eax - 4]
  mov edx, [edx - 4]
  {Is the second character the same?}
  cmp ch, bh
  je @FirstTwoCharactersMatch
  {Second character differs: Are any of the strings non-nil but zero length?}
  test eax, eax
  jz @ReturnLengthDifference
  test edx, edx
  jz @ReturnLengthDifference
  movzx eax, bh
  movzx edx, ch
@ReturnLengthDifference:
  sub eax, edx
  pop ebx
  ret
@FirstTwoCharactersMatch:
  cmp eax, 2
  jna @ReturnLengthDifference
  cmp edx, 2
  jna @ReturnLengthDifference
  {Swap the bytes in priority order}
  mov eax, ebx
  bswap eax
  bswap ecx
  sub eax, ecx
  pop ebx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
  ret
  {The first four characters are identical}
@FirstFourSame:
  {Save edi}
  push edi
  {set edi = length(S1)}
  mov edi, [eax - 4]
  {Save esi}
  push esi
  xor esi, esi
  mov ecx, edi
  {set edi = length(S1) - length(S2)}
  sub edi, [edx - 4]
  {set esi = 0 if length(S1) < length(S2), -1 otherwise}
  adc esi, -1
  {set esi = - min(length(s1), length(s2))}
  and esi, edi
  sub esi, ecx
  {Adjust the pointers to be negative based}
  sub eax, esi
  sub edx, esi
@CompareLoop:
  add esi, 4
  jns @MatchUpToLength
  mov ebx, [eax + esi]
  mov ecx, [edx + esi]
  cmp ebx, ecx
  je @CompareLoop
@Mismatch:
  {There was a mismatch, but we may have compared up to three characters too
   many: Compare the first two characters (there must be a trailing #0)}
  cmp bx, cx
  je @FirstTwoMatches
@ActualMismatch:
  movzx eax, bh
  mov ah, bl
  movzx edx, ch
  mov dh, cl
  sub eax, edx
  pop esi
  pop edi
  pop ebx
  ret
@FirstTwoMatches:
  {Move the high words into view}
  shr ebx, 16
  shr ecx, 16
  {The first two characters are the same. Have we compared two or three characters
   too many?}
  cmp esi, -3
  jng @ActualMismatch
  {All characters match - return the difference in length}
@MatchUpToLength:
  mov eax, edi
  pop esi
  pop edi
  pop ebx
end;

procedure Spacer7;
asm
  nop
end;

//CPU Target: IA32, Size = 173 Bytes
function CompareStr_PLR_IA32_12b(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  mov ecx, [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  movzx ecx, cl
  sub eax, ecx
  ret
@FirstCharacterSame:
  {save ebx}
  push ebx
  {Get first four characters}
  mov ebx, [eax]
  cmp ebx, ecx
  je @FirstFourSame
  {Get the string lengths in eax and edx}
  mov eax, [eax - 4]
  mov edx, [edx - 4]
  {Is the second character the same?}
  cmp ch, bh
  je @FirstTwoCharactersMatch
  {Second character differs: Are any of the strings non-nil but zero length?}
  test eax, eax
  jz @ReturnLengthDifference
  test edx, edx
  jz @ReturnLengthDifference
  movzx eax, bh
  movzx edx, ch
@ReturnLengthDifference:
  sub eax, edx
  pop ebx
  ret
@FirstTwoCharactersMatch:
  cmp eax, 2
  jna @ReturnLengthDifference
  cmp edx, 2
  jna @ReturnLengthDifference
  {Swap the bytes in priority order}
  mov eax, ebx
  bswap eax
  bswap ecx
  sub eax, ecx
  pop ebx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
  ret
  {The first four characters are identical}
@FirstFourSame:
  {Save edi}
  push edi
  {set edi = length(S1)}
  mov edi, [eax - 4]
  {Save esi}
  push esi
  xor esi, esi
  mov ecx, edi
  {set edi = length(S1) - length(S2)}
  sub edi, [edx - 4]
  {set esi = 0 if length(S1) < length(S2), -1 otherwise}
  adc esi, -1
  {set esi = - min(length(s1), length(s2))}
  and esi, edi
  sub esi, ecx
  {Adjust the pointers to be negative based}
  sub eax, esi
  sub edx, esi
@CompareLoop:
  add esi, 4
  jns @MatchUpToLength
  mov ebx, [eax + esi]
  mov ecx, [edx + esi]
  cmp ebx, ecx
  je @CompareLoop
@Mismatch:
  {There was a mismatch, but we may have compared up to three characters too
   many: Compare the first two characters (there must be a trailing #0)}
  cmp bx, cx
  je @FirstTwoMatches
@ActualMismatch:
  movzx eax, bh
  mov ah, bl
  movzx edx, ch
  mov dh, cl
  sub eax, edx
  pop esi
  pop edi
  pop ebx
  ret
@FirstTwoMatches:
  {Move the high words into view}
  shr ebx, 16
  shr ecx, 16
  {The first two characters are the same. Have we compared two or three characters
   too many?}
  cmp esi, -3
  jng @ActualMismatch
  {All characters match - return the difference in length}
@MatchUpToLength:
  mov eax, edi
  pop esi
  pop edi
  pop ebx
end;

procedure Spacer8;
asm
  nop
end;

//CPU Target: IA32, Size = 173 Bytes
function CompareStr_PLR_IA32_12c(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  mov ecx, [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  movzx ecx, cl
  sub eax, ecx
  ret
@FirstCharacterSame:
  {save ebx}
  push ebx
  {Get first four characters}
  mov ebx, [eax]
  cmp ebx, ecx
  je @FirstFourSame
  {Get the string lengths in eax and edx}
  mov eax, [eax - 4]
  mov edx, [edx - 4]
  {Is the second character the same?}
  cmp ch, bh
  je @FirstTwoCharactersMatch
  {Second character differs: Are any of the strings non-nil but zero length?}
  test eax, eax
  jz @ReturnLengthDifference
  test edx, edx
  jz @ReturnLengthDifference
  movzx eax, bh
  movzx edx, ch
@ReturnLengthDifference:
  sub eax, edx
  pop ebx
  ret
@FirstTwoCharactersMatch:
  cmp eax, 2
  jna @ReturnLengthDifference
  cmp edx, 2
  jna @ReturnLengthDifference
  {Swap the bytes in priority order}
  mov eax, ebx
  bswap eax
  bswap ecx
  sub eax, ecx
  pop ebx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
  ret
  {The first four characters are identical}
@FirstFourSame:
  {Save edi}
  push edi
  {set edi = length(S1)}
  mov edi, [eax - 4]
  {Save esi}
  push esi
  xor esi, esi
  mov ecx, edi
  {set edi = length(S1) - length(S2)}
  sub edi, [edx - 4]
  {set esi = 0 if length(S1) < length(S2), -1 otherwise}
  adc esi, -1
  {set esi = - min(length(s1), length(s2))}
  and esi, edi
  sub esi, ecx
  {Adjust the pointers to be negative based}
  sub eax, esi
  sub edx, esi
@CompareLoop:
  add esi, 4
  jns @MatchUpToLength
  mov ebx, [eax + esi]
  mov ecx, [edx + esi]
  cmp ebx, ecx
  je @CompareLoop
@Mismatch:
  {There was a mismatch, but we may have compared up to three characters too
   many: Compare the first two characters (there must be a trailing #0)}
  cmp bx, cx
  je @FirstTwoMatches
@ActualMismatch:
  movzx eax, bh
  mov ah, bl
  movzx edx, ch
  mov dh, cl
  sub eax, edx
  pop esi
  pop edi
  pop ebx
  ret
@FirstTwoMatches:
  {Move the high words into view}
  shr ebx, 16
  shr ecx, 16
  {The first two characters are the same. Have we compared two or three characters
   too many?}
  cmp esi, -3
  jng @ActualMismatch
  {All characters match - return the difference in length}
@MatchUpToLength:
  mov eax, edi
  pop esi
  pop edi
  pop ebx
end;

procedure Spacer9;
asm
  nop
end;

//CPU Target: IA32, Size = 173 Bytes
function CompareStr_PLR_IA32_12d(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  mov ecx, [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  movzx ecx, cl
  sub eax, ecx
  ret
@FirstCharacterSame:
  {save ebx}
  push ebx
  {Get first four characters}
  mov ebx, [eax]
  cmp ebx, ecx
  je @FirstFourSame
  {Get the string lengths in eax and edx}
  mov eax, [eax - 4]
  mov edx, [edx - 4]
  {Is the second character the same?}
  cmp ch, bh
  je @FirstTwoCharactersMatch
  {Second character differs: Are any of the strings non-nil but zero length?}
  test eax, eax
  jz @ReturnLengthDifference
  test edx, edx
  jz @ReturnLengthDifference
  movzx eax, bh
  movzx edx, ch
@ReturnLengthDifference:
  sub eax, edx
  pop ebx
  ret
@FirstTwoCharactersMatch:
  cmp eax, 2
  jna @ReturnLengthDifference
  cmp edx, 2
  jna @ReturnLengthDifference
  {Swap the bytes in priority order}
  mov eax, ebx
  bswap eax
  bswap ecx
  sub eax, ecx
  pop ebx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
  ret
  {The first four characters are identical}
@FirstFourSame:
  {Save edi}
  push edi
  {set edi = length(S1)}
  mov edi, [eax - 4]
  {Save esi}
  push esi
  xor esi, esi
  mov ecx, edi
  {set edi = length(S1) - length(S2)}
  sub edi, [edx - 4]
  {set esi = 0 if length(S1) < length(S2), -1 otherwise}
  adc esi, -1
  {set esi = - min(length(s1), length(s2))}
  and esi, edi
  sub esi, ecx
  {Adjust the pointers to be negative based}
  sub eax, esi
  sub edx, esi
@CompareLoop:
  add esi, 4
  jns @MatchUpToLength
  mov ebx, [eax + esi]
  mov ecx, [edx + esi]
  cmp ebx, ecx
  je @CompareLoop
@Mismatch:
  {There was a mismatch, but we may have compared up to three characters too
   many: Compare the first two characters (there must be a trailing #0)}
  cmp bx, cx
  je @FirstTwoMatches
@ActualMismatch:
  movzx eax, bh
  mov ah, bl
  movzx edx, ch
  mov dh, cl
  sub eax, edx
  pop esi
  pop edi
  pop ebx
  ret
@FirstTwoMatches:
  {Move the high words into view}
  shr ebx, 16
  shr ecx, 16
  {The first two characters are the same. Have we compared two or three characters
   too many?}
  cmp esi, -3
  jng @ActualMismatch
  {All characters match - return the difference in length}
@MatchUpToLength:
  mov eax, edi
  pop esi
  pop edi
  pop ebx
end;

//CPU Target: IA32, Size = 157 Bytes
function CompareStr_PLR_IA32_14a(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  mov ecx, [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  movzx ecx, cl
  sub eax, ecx
  ret
@FirstCharacterSame:
  {save ebx}
  push ebx
  {Get first four characters}
  mov ebx, [eax]
  cmp ebx, ecx
  je @FirstFourSame
  {Get the string lengths in eax and edx}
  mov eax, [eax - 4]
  mov edx, [edx - 4]
  {Is the second character the same?}
  cmp ch, bh
  je @FirstTwoCharactersMatch
  {Second character differs: Are any of the strings non-nil but zero length?}
  test eax, eax
  jz @ReturnLengthDifference
  test edx, edx
  jz @ReturnLengthDifference
  movzx eax, bh
  movzx edx, ch
@ReturnLengthDifference:
  sub eax, edx
  pop ebx
  ret
@FirstTwoCharactersMatch:
  cmp eax, 2
  jna @ReturnLengthDifference
  cmp edx, 2
  jna @ReturnLengthDifference
  {Swap the bytes into the correct order}
  mov eax, ebx
  bswap eax
  bswap ecx
  sub eax, ecx
  pop ebx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
  ret
  {The first four characters are identical}
@FirstFourSame:
  {set ebx = length(S1)}
  mov ebx, [eax - 4]
  xor ecx, ecx
  {set ebx = length(S1) - length(S2)}
  sub ebx, [edx - 4]
  {Save the length difference on the stack}
  push ebx
  {set esi = 0 if length(S1) < length(S2), $ffffffff otherwise}
  adc ecx, -1
  {set esi = - min(length(s1), length(s2))}
  and ecx, ebx
  sub ecx, [eax - 4]
  {Adjust the pointers to be negative based}
  sub eax, ecx
  sub edx, ecx
@CompareLoop:
  add ecx, 4
  jns @MatchUpToLength
  mov ebx, [eax + ecx]
  xor ebx, [edx + ecx]
  jz @CompareLoop
@Mismatch:
  bsf ebx, ebx
  shr ebx, 3
  add ecx, ebx
  jns @MatchUpToLength
  movzx eax, byte ptr [eax + ecx]
  movzx edx, byte ptr [edx + ecx]
  sub eax, edx
  pop ebx
  pop ebx
  ret
  {All characters match - return the difference in length}
@MatchUpToLength:
  pop eax
  pop ebx
end;

procedure Spacer13;
asm
  nop
end;

//CPU Target: IA32, Size = 157 Bytes
function CompareStr_PLR_IA32_14b(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  mov ecx, [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  movzx ecx, cl
  sub eax, ecx
  ret
@FirstCharacterSame:
  {save ebx}
  push ebx
  {Get first four characters}
  mov ebx, [eax]
  cmp ebx, ecx
  je @FirstFourSame
  {Get the string lengths in eax and edx}
  mov eax, [eax - 4]
  mov edx, [edx - 4]
  {Is the second character the same?}
  cmp ch, bh
  je @FirstTwoCharactersMatch
  {Second character differs: Are any of the strings non-nil but zero length?}
  test eax, eax
  jz @ReturnLengthDifference
  test edx, edx
  jz @ReturnLengthDifference
  movzx eax, bh
  movzx edx, ch
@ReturnLengthDifference:
  sub eax, edx
  pop ebx
  ret
@FirstTwoCharactersMatch:
  cmp eax, 2
  jna @ReturnLengthDifference
  cmp edx, 2
  jna @ReturnLengthDifference
  {Swap the bytes into the correct order}
  mov eax, ebx
  bswap eax
  bswap ecx
  sub eax, ecx
  pop ebx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
  ret
  {The first four characters are identical}
@FirstFourSame:
  {set ebx = length(S1)}
  mov ebx, [eax - 4]
  xor ecx, ecx
  {set ebx = length(S1) - length(S2)}
  sub ebx, [edx - 4]
  {Save the length difference on the stack}
  push ebx
  {set esi = 0 if length(S1) < length(S2), $ffffffff otherwise}
  adc ecx, -1
  {set esi = - min(length(s1), length(s2))}
  and ecx, ebx
  sub ecx, [eax - 4]
  {Adjust the pointers to be negative based}
  sub eax, ecx
  sub edx, ecx
@CompareLoop:
  add ecx, 4
  jns @MatchUpToLength
  mov ebx, [eax + ecx]
  xor ebx, [edx + ecx]
  jz @CompareLoop
@Mismatch:
  bsf ebx, ebx
  shr ebx, 3
  add ecx, ebx
  jns @MatchUpToLength
  movzx eax, byte ptr [eax + ecx]
  movzx edx, byte ptr [edx + ecx]
  sub eax, edx
  pop ebx
  pop ebx
  ret
  {All characters match - return the difference in length}
@MatchUpToLength:
  pop eax
  pop ebx
end;

procedure Spacer14;
asm
  nop
end;

//CPU Target: IA32, Size = 157 Bytes
function CompareStr_PLR_IA32_14c(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  mov ecx, [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  movzx ecx, cl
  sub eax, ecx
  ret
@FirstCharacterSame:
  {save ebx}
  push ebx
  {Get first four characters}
  mov ebx, [eax]
  cmp ebx, ecx
  je @FirstFourSame
  {Get the string lengths in eax and edx}
  mov eax, [eax - 4]
  mov edx, [edx - 4]
  {Is the second character the same?}
  cmp ch, bh
  je @FirstTwoCharactersMatch
  {Second character differs: Are any of the strings non-nil but zero length?}
  test eax, eax
  jz @ReturnLengthDifference
  test edx, edx
  jz @ReturnLengthDifference
  movzx eax, bh
  movzx edx, ch
@ReturnLengthDifference:
  sub eax, edx
  pop ebx
  ret
@FirstTwoCharactersMatch:
  cmp eax, 2
  jna @ReturnLengthDifference
  cmp edx, 2
  jna @ReturnLengthDifference
  {Swap the bytes into the correct order}
  mov eax, ebx
  bswap eax
  bswap ecx
  sub eax, ecx
  pop ebx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
  ret
  {The first four characters are identical}
@FirstFourSame:
  {set ebx = length(S1)}
  mov ebx, [eax - 4]
  xor ecx, ecx
  {set ebx = length(S1) - length(S2)}
  sub ebx, [edx - 4]
  {Save the length difference on the stack}
  push ebx
  {set esi = 0 if length(S1) < length(S2), $ffffffff otherwise}
  adc ecx, -1
  {set esi = - min(length(s1), length(s2))}
  and ecx, ebx
  sub ecx, [eax - 4]
  {Adjust the pointers to be negative based}
  sub eax, ecx
  sub edx, ecx
@CompareLoop:
  add ecx, 4
  jns @MatchUpToLength
  mov ebx, [eax + ecx]
  xor ebx, [edx + ecx]
  jz @CompareLoop
@Mismatch:
  bsf ebx, ebx
  shr ebx, 3
  add ecx, ebx
  jns @MatchUpToLength
  movzx eax, byte ptr [eax + ecx]
  movzx edx, byte ptr [edx + ecx]
  sub eax, edx
  pop ebx
  pop ebx
  ret
  {All characters match - return the difference in length}
@MatchUpToLength:
  pop eax
  pop ebx
end;

procedure Spacer15;
asm
  nop
end;

//CPU Target: IA32, Size = 157 Bytes
function CompareStr_PLR_IA32_14d(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  mov ecx, [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  movzx ecx, cl
  sub eax, ecx
  ret
@FirstCharacterSame:
  {save ebx}
  push ebx
  {Get first four characters}
  mov ebx, [eax]
  cmp ebx, ecx
  je @FirstFourSame
  {Get the string lengths in eax and edx}
  mov eax, [eax - 4]
  mov edx, [edx - 4]
  {Is the second character the same?}
  cmp ch, bh
  je @FirstTwoCharactersMatch
  {Second character differs: Are any of the strings non-nil but zero length?}
  test eax, eax
  jz @ReturnLengthDifference
  test edx, edx
  jz @ReturnLengthDifference
  movzx eax, bh
  movzx edx, ch
@ReturnLengthDifference:
  sub eax, edx
  pop ebx
  ret
@FirstTwoCharactersMatch:
  cmp eax, 2
  jna @ReturnLengthDifference
  cmp edx, 2
  jna @ReturnLengthDifference
  {Swap the bytes into the correct order}
  mov eax, ebx
  bswap eax
  bswap ecx
  sub eax, ecx
  pop ebx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
  ret
  {The first four characters are identical}
@FirstFourSame:
  {set ebx = length(S1)}
  mov ebx, [eax - 4]
  xor ecx, ecx
  {set ebx = length(S1) - length(S2)}
  sub ebx, [edx - 4]
  {Save the length difference on the stack}
  push ebx
  {set esi = 0 if length(S1) < length(S2), $ffffffff otherwise}
  adc ecx, -1
  {set esi = - min(length(s1), length(s2))}
  and ecx, ebx
  sub ecx, [eax - 4]
  {Adjust the pointers to be negative based}
  sub eax, ecx
  sub edx, ecx
@CompareLoop:
  add ecx, 4
  jns @MatchUpToLength
  mov ebx, [eax + ecx]
  xor ebx, [edx + ecx]
  jz @CompareLoop
@Mismatch:
  bsf ebx, ebx
  shr ebx, 3
  add ecx, ebx
  jns @MatchUpToLength
  movzx eax, byte ptr [eax + ecx]
  movzx edx, byte ptr [edx + ecx]
  sub eax, edx
  pop ebx
  pop ebx
  ret
  {All characters match - return the difference in length}
@MatchUpToLength:
  pop eax
  pop ebx
end;

//CPU Target: IA32, Size = 103 Bytes
function CompareStr_PLR_IA32_15a(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  mov ecx, [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  movzx ecx, cl
  sub eax, ecx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
  ret
  {The first four characters are identical}
@FirstCharacterSame:
  {Save ebx}
  push ebx
  {set ebx = length(S1)}
  mov ebx, [eax - 4]
  xor ecx, ecx
  {set ebx = length(S1) - length(S2)}
  sub ebx, [edx - 4]
  {Save the length difference on the stack}
  push ebx
  {set ecx = 0 if length(S1) < length(S2), $ffffffff otherwise}
  adc ecx, -1
  {set ecx = - min(length(s1), length(s2))}
  and ecx, ebx
  sub ecx, [eax - 4]
  {Adjust the pointers to be negative based}
  sub eax, ecx
  sub edx, ecx
@CompareLoop:
  mov ebx, [eax + ecx]
  xor ebx, [edx + ecx]
  jnz @Mismatch
  add ecx, 4
  js @CompareLoop
  {All characters match - return the difference in length}
@MatchUpToLength:
  pop eax
  pop ebx
  ret
@Mismatch:
  bsf ebx, ebx
  shr ebx, 3
  add ecx, ebx
  jns @MatchUpToLength
  movzx eax, byte ptr [eax + ecx]
  movzx edx, byte ptr [edx + ecx]
  sub eax, edx
  pop ebx
  pop ebx
end;

//CPU Target: IA32, Size = 103 Bytes
function CompareStr_PLR_IA32_15b(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  mov ecx, [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  movzx ecx, cl
  sub eax, ecx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
  ret
  {The first four characters are identical}
@FirstCharacterSame:
  {Save ebx}
  push ebx
  {set ebx = length(S1)}
  mov ebx, [eax - 4]
  xor ecx, ecx
  {set ebx = length(S1) - length(S2)}
  sub ebx, [edx - 4]
  {Save the length difference on the stack}
  push ebx
  {set ecx = 0 if length(S1) < length(S2), $ffffffff otherwise}
  adc ecx, -1
  {set ecx = - min(length(s1), length(s2))}
  and ecx, ebx
  sub ecx, [eax - 4]
  {Adjust the pointers to be negative based}
  sub eax, ecx
  sub edx, ecx
@CompareLoop:
  mov ebx, [eax + ecx]
  xor ebx, [edx + ecx]
  jnz @Mismatch
  add ecx, 4
  js @CompareLoop
  {All characters match - return the difference in length}
@MatchUpToLength:
  pop eax
  pop ebx
  ret
@Mismatch:
  bsf ebx, ebx
  shr ebx, 3
  add ecx, ebx
  jns @MatchUpToLength
  movzx eax, byte ptr [eax + ecx]
  movzx edx, byte ptr [edx + ecx]
  sub eax, edx
  pop ebx
  pop ebx
end;

procedure Spacer10;
asm
  nop
end;

//CPU Target: IA32, Size = 103 Bytes
function CompareStr_PLR_IA32_15c(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  mov ecx, [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  movzx ecx, cl
  sub eax, ecx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
  ret
  {The first four characters are identical}
@FirstCharacterSame:
  {Save ebx}
  push ebx
  {set ebx = length(S1)}
  mov ebx, [eax - 4]
  xor ecx, ecx
  {set ebx = length(S1) - length(S2)}
  sub ebx, [edx - 4]
  {Save the length difference on the stack}
  push ebx
  {set ecx = 0 if length(S1) < length(S2), $ffffffff otherwise}
  adc ecx, -1
  {set ecx = - min(length(s1), length(s2))}
  and ecx, ebx
  sub ecx, [eax - 4]
  {Adjust the pointers to be negative based}
  sub eax, ecx
  sub edx, ecx
@CompareLoop:
  mov ebx, [eax + ecx]
  xor ebx, [edx + ecx]
  jnz @Mismatch
  add ecx, 4
  js @CompareLoop
  {All characters match - return the difference in length}
@MatchUpToLength:
  pop eax
  pop ebx
  ret
@Mismatch:
  bsf ebx, ebx
  shr ebx, 3
  add ecx, ebx
  jns @MatchUpToLength
  movzx eax, byte ptr [eax + ecx]
  movzx edx, byte ptr [edx + ecx]
  sub eax, edx
  pop ebx
  pop ebx
end;

//CPU Target: IA32, Size = 103 Bytes
function CompareStr_PLR_IA32_15d(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  mov ecx, [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  movzx ecx, cl
  sub eax, ecx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
  ret
  {The first four characters are identical}
@FirstCharacterSame:
  {Save ebx}
  push ebx
  {set ebx = length(S1)}
  mov ebx, [eax - 4]
  xor ecx, ecx
  {set ebx = length(S1) - length(S2)}
  sub ebx, [edx - 4]
  {Save the length difference on the stack}
  push ebx
  {set ecx = 0 if length(S1) < length(S2), $ffffffff otherwise}
  adc ecx, -1
  {set ecx = - min(length(s1), length(s2))}
  and ecx, ebx
  sub ecx, [eax - 4]
  {Adjust the pointers to be negative based}
  sub eax, ecx
  sub edx, ecx
@CompareLoop:
  mov ebx, [eax + ecx]
  xor ebx, [edx + ecx]
  jnz @Mismatch
  add ecx, 4
  js @CompareLoop
  {All characters match - return the difference in length}
@MatchUpToLength:
  pop eax
  pop ebx
  ret
@Mismatch:
  bsf ebx, ebx
  shr ebx, 3
  add ecx, ebx
  jns @MatchUpToLength
  movzx eax, byte ptr [eax + ecx]
  movzx edx, byte ptr [edx + ecx]
  sub eax, edx
  pop ebx
  pop ebx
end;

//CPU Target: IA32, Size = 101 Bytes
function CompareStr_PLR_IA32_16a(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  movzx ecx, byte ptr [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  sub eax, ecx
  ret
@FirstCharacterSame:
  {Save ebx}
  push ebx
  {set ebx = length(S1)}
  mov ebx, [eax - 4]
  xor ecx, ecx
  {set ebx = length(S1) - length(S2)}
  sub ebx, [edx - 4]
  {Save the length difference on the stack}
  push ebx
  {set ecx = 0 if length(S1) < length(S2), $ffffffff otherwise}
  adc ecx, -1
  {set ecx = - min(length(S1), length(S2))}
  and ecx, ebx
  sub ecx, [eax - 4]
  {Adjust the pointers to be negative based}
  sub eax, ecx
  sub edx, ecx
@CompareLoop:
  mov ebx, [eax + ecx]
  xor ebx, [edx + ecx]
  jnz @Mismatch
  add ecx, 4
  js @CompareLoop
  {All characters match - return the difference in length}
@MatchUpToLength:
  pop eax
  pop ebx
  ret
@Mismatch:
  bsf ebx, ebx
  shr ebx, 3
  add ecx, ebx
  jns @MatchUpToLength
  movzx eax, byte ptr [eax + ecx]
  movzx edx, byte ptr [edx + ecx]
  sub eax, edx
  pop ebx
  pop ebx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
end;

//CPU Target: IA32, Size = 101 Bytes
function CompareStr_PLR_IA32_16b(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  movzx ecx, byte ptr [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  sub eax, ecx
  ret
@FirstCharacterSame:
  {Save ebx}
  push ebx
  {set ebx = length(S1)}
  mov ebx, [eax - 4]
  xor ecx, ecx
  {set ebx = length(S1) - length(S2)}
  sub ebx, [edx - 4]
  {Save the length difference on the stack}
  push ebx
  {set ecx = 0 if length(S1) < length(S2), $ffffffff otherwise}
  adc ecx, -1
  {set ecx = - min(length(S1), length(S2))}
  and ecx, ebx
  sub ecx, [eax - 4]
  {Adjust the pointers to be negative based}
  sub eax, ecx
  sub edx, ecx
@CompareLoop:
  mov ebx, [eax + ecx]
  xor ebx, [edx + ecx]
  jnz @Mismatch
  add ecx, 4
  js @CompareLoop
  {All characters match - return the difference in length}
@MatchUpToLength:
  pop eax
  pop ebx
  ret
@Mismatch:
  bsf ebx, ebx
  shr ebx, 3
  add ecx, ebx
  jns @MatchUpToLength
  movzx eax, byte ptr [eax + ecx]
  movzx edx, byte ptr [edx + ecx]
  sub eax, edx
  pop ebx
  pop ebx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
end;

procedure Spacer11;
asm
  nop
end;

//CPU Target: IA32, Size = 101 Bytes
function CompareStr_PLR_IA32_16c(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  movzx ecx, byte ptr [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  sub eax, ecx
  ret
@FirstCharacterSame:
  {Save ebx}
  push ebx
  {set ebx = length(S1)}
  mov ebx, [eax - 4]
  xor ecx, ecx
  {set ebx = length(S1) - length(S2)}
  sub ebx, [edx - 4]
  {Save the length difference on the stack}
  push ebx
  {set ecx = 0 if length(S1) < length(S2), $ffffffff otherwise}
  adc ecx, -1
  {set ecx = - min(length(S1), length(S2))}
  and ecx, ebx
  sub ecx, [eax - 4]
  {Adjust the pointers to be negative based}
  sub eax, ecx
  sub edx, ecx
@CompareLoop:
  mov ebx, [eax + ecx]
  xor ebx, [edx + ecx]
  jnz @Mismatch
  add ecx, 4
  js @CompareLoop
  {All characters match - return the difference in length}
@MatchUpToLength:
  pop eax
  pop ebx
  ret
@Mismatch:
  bsf ebx, ebx
  shr ebx, 3
  add ecx, ebx
  jns @MatchUpToLength
  movzx eax, byte ptr [eax + ecx]
  movzx edx, byte ptr [edx + ecx]
  sub eax, edx
  pop ebx
  pop ebx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
end;

//CPU Target: IA32, Size = 101 Bytes
function CompareStr_PLR_IA32_16d(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  movzx ecx, byte ptr [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  sub eax, ecx
  ret
@FirstCharacterSame:
  {Save ebx}
  push ebx
  {set ebx = length(S1)}
  mov ebx, [eax - 4]
  xor ecx, ecx
  {set ebx = length(S1) - length(S2)}
  sub ebx, [edx - 4]
  {Save the length difference on the stack}
  push ebx
  {set ecx = 0 if length(S1) < length(S2), $ffffffff otherwise}
  adc ecx, -1
  {set ecx = - min(length(S1), length(S2))}
  and ecx, ebx
  sub ecx, [eax - 4]
  {Adjust the pointers to be negative based}
  sub eax, ecx
  sub edx, ecx
@CompareLoop:
  mov ebx, [eax + ecx]
  xor ebx, [edx + ecx]
  jnz @Mismatch
  add ecx, 4
  js @CompareLoop
  {All characters match - return the difference in length}
@MatchUpToLength:
  pop eax
  pop ebx
  ret
@Mismatch:
  bsf ebx, ebx
  shr ebx, 3
  add ecx, ebx
  jns @MatchUpToLength
  movzx eax, byte ptr [eax + ecx]
  movzx edx, byte ptr [edx + ecx]
  sub eax, edx
  pop ebx
  pop ebx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
end;

//CPU Target: IA32, Size = 98 Bytes
function CompareStr_PLR_IA32_17a(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  movzx ecx, byte ptr [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  sub eax, ecx
  ret
@FirstCharacterSame:
  {Save ebx}
  push ebx
  {set ebx = length(S1)}
  mov ebx, [eax - 4]
  {set ebx = length(S1) - length(S2)}
  sub ebx, [edx - 4]
  {Save the length difference on the stack}
  push ebx
  {set ecx = 0 if length(S1) < length(S2), $ffffffff otherwise}
  sbb ecx, ecx
  {set ecx = - min(length(S1), length(S2))}
  and ecx, ebx
  sub ecx, [eax - 4]
  {Adjust the pointers to be negative based}
  sub eax, ecx
  sub edx, ecx
@CompareLoop:
  mov ebx, [eax + ecx]
  xor ebx, [edx + ecx]
  jnz @Mismatch
  add ecx, 4
  js @CompareLoop
  {All characters match - return the difference in length}
@MatchUpToLength:
  pop eax
  pop ebx
  ret
@Mismatch:
  bsf ebx, ebx
  shr ebx, 3
  add ecx, ebx
  jns @MatchUpToLength
  movzx eax, byte ptr [eax + ecx]
  movzx edx, byte ptr [edx + ecx]
  sub eax, edx
  pop ebx
  pop ebx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
end;

//CPU Target: IA32, Size = 98 Bytes
function CompareStr_PLR_IA32_17b(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  movzx ecx, byte ptr [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  sub eax, ecx
  ret
@FirstCharacterSame:
  {Save ebx}
  push ebx
  {set ebx = length(S1)}
  mov ebx, [eax - 4]
  {set ebx = length(S1) - length(S2)}
  sub ebx, [edx - 4]
  {Save the length difference on the stack}
  push ebx
  {set ecx = 0 if length(S1) < length(S2), $ffffffff otherwise}
  sbb ecx, ecx
  {set ecx = - min(length(S1), length(S2))}
  and ecx, ebx
  sub ecx, [eax - 4]
  {Adjust the pointers to be negative based}
  sub eax, ecx
  sub edx, ecx
@CompareLoop:
  mov ebx, [eax + ecx]
  xor ebx, [edx + ecx]
  jnz @Mismatch
  add ecx, 4
  js @CompareLoop
  {All characters match - return the difference in length}
@MatchUpToLength:
  pop eax
  pop ebx
  ret
@Mismatch:
  bsf ebx, ebx
  shr ebx, 3
  add ecx, ebx
  jns @MatchUpToLength
  movzx eax, byte ptr [eax + ecx]
  movzx edx, byte ptr [edx + ecx]
  sub eax, edx
  pop ebx
  pop ebx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
end;

//CPU Target: IA32, Size = 98 Bytes
function CompareStr_PLR_IA32_17c(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  movzx ecx, byte ptr [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  sub eax, ecx
  ret
@FirstCharacterSame:
  {Save ebx}
  push ebx
  {set ebx = length(S1)}
  mov ebx, [eax - 4]
  {set ebx = length(S1) - length(S2)}
  sub ebx, [edx - 4]
  {Save the length difference on the stack}
  push ebx
  {set ecx = 0 if length(S1) < length(S2), $ffffffff otherwise}
  sbb ecx, ecx
  {set ecx = - min(length(S1), length(S2))}
  and ecx, ebx
  sub ecx, [eax - 4]
  {Adjust the pointers to be negative based}
  sub eax, ecx
  sub edx, ecx
@CompareLoop:
  mov ebx, [eax + ecx]
  xor ebx, [edx + ecx]
  jnz @Mismatch
  add ecx, 4
  js @CompareLoop
  {All characters match - return the difference in length}
@MatchUpToLength:
  pop eax
  pop ebx
  ret
@Mismatch:
  bsf ebx, ebx
  shr ebx, 3
  add ecx, ebx
  jns @MatchUpToLength
  movzx eax, byte ptr [eax + ecx]
  movzx edx, byte ptr [edx + ecx]
  sub eax, edx
  pop ebx
  pop ebx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
end;

//CPU Target: IA32, Size = 98 Bytes
function CompareStr_PLR_IA32_17d(const S1, S2: string): Integer;
asm
  {On entry:
    eax = S1,
    edx = S2}
  cmp eax, edx
  je @SameString
  {Is either of the strings perhaps nil?}
  test eax, edx
  jz @PossibleNilString
  {Compare the first four characters (there has to be a trailing #0). In random
   string compares this can save a lot of CPU time.}
@BothNonNil:
  {Compare the first character}
  movzx ecx, byte ptr [edx]
  cmp cl, [eax]
  je @FirstCharacterSame
  {First character differs}
  movzx eax, byte ptr [eax]
  sub eax, ecx
  ret
@FirstCharacterSame:
  {Save ebx}
  push ebx
  {set ebx = length(S1)}
  mov ebx, [eax - 4]
  {set ebx = length(S1) - length(S2)}
  sub ebx, [edx - 4]
  {Save the length difference on the stack}
  push ebx
  {set ecx = 0 if length(S1) < length(S2), $ffffffff otherwise}
  sbb ecx, ecx
  {set ecx = - min(length(S1), length(S2))}
  and ecx, ebx
  sub ecx, [eax - 4]
  {Adjust the pointers to be negative based}
  sub eax, ecx
  sub edx, ecx
@CompareLoop:
  mov ebx, [eax + ecx]
  xor ebx, [edx + ecx]
  jnz @Mismatch
  add ecx, 4
  js @CompareLoop
  {All characters match - return the difference in length}
@MatchUpToLength:
  pop eax
  pop ebx
  ret
@Mismatch:
  bsf ebx, ebx
  shr ebx, 3
  add ecx, ebx
  jns @MatchUpToLength
  movzx eax, byte ptr [eax + ecx]
  movzx edx, byte ptr [edx + ecx]
  sub eax, edx
  pop ebx
  pop ebx
  ret
  {It is the same string}
@SameString:
  xor eax, eax
  ret
  {Good possibility that at least one of the strings are nil}
@PossibleNilString:
  test eax, eax
  jz @FirstStringNil
  test edx, edx
  jnz @BothNonNil
  {Return first string length: second string is nil}
  mov eax, [eax - 4]
  ret
@FirstStringNil:
  {Return 0 - length(S2): first string is nil}
  sub eax, [edx - 4]
end;

{PLR Pascal entry}
{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}
{$ifopt Q+}
  {$define OverflowCheckWasOn}
  {$Q-}
{$endif}
function CompareStr_PLR_PAS_1_a(const S1, S2: string): Integer;
type
  {Define types for older Delphi versions}
  PByte = ^Byte;
  TByteArray = array[0..0] of Byte;
  PByteArray = ^TByteArray;
  PInteger = ^Integer;
var
  LStr1, LStr2, LStr1Char1, LStr2Char1, LLength1, LLength2,
    LCompInd, LLengthDif, LChars1, LChars2: Integer;
begin
  {Assign to local variables (hopefully a register)}
  LStr1 := Integer(S1);
  LStr2 := Integer(S2);
  {Different strings?}
  if LStr1 <> LStr2 then
  begin
    {Is S1 = nil?}
    if LStr1 <> 0 then
    begin
      {Is S2 = nil?}
      if LStr2 <> 0 then
      begin
        {Compare the first character}
        LStr1Char1 := PByte(LStr1)^;
        LStr2Char1 := PByte(LStr2)^;
        if LStr1Char1 <> LStr2Char1 then
        begin
          {Mismatch on first character}
          Result := LStr1Char1 - LStr2Char1;
        end
        else
        begin
          {First character is the same: Get the number of characters to compare}
          LLength1 := PInteger(LStr1 - 4)^;
          LLength2 := PInteger(LStr2 - 4)^;
          LLengthDif := LLength1 - LLength2;
          if LLengthDif >= 0 then
            LCompInd := - LLength2
          else
            LCompInd := - LLength1;
          if LCompInd < 0 then
          begin
            Dec(LStr1, LCompInd);
            Dec(LStr2, LCompInd);
            repeat
              LChars1 := PInteger(@PByteArray(LStr1)[LCompInd])^;
              LChars2 := PInteger(@PByteArray(LStr2)[LCompInd])^;
              if LChars1 <> LChars2 then
              begin
                if SmallInt(LChars1) <> SmallInt(LChars2) then
                begin
                  Result := (Byte(LChars1) shl 8) + Byte(LChars1 shr 8)
                    - (Byte(LChars2) shl 8) - Byte(LChars2 shr 8);
                  exit;
                end
                else
                begin
                  {Matched up to length?}
                  if LCompInd > -3 then
                    break;
                  {Actual micmatch}
                  Result := (LChars1 shr 24) + ((LChars1 shr 8) and $ff00)
                    - (LChars2 shr 24) - ((LChars2 shr 8) and $ff00);
                  exit;
                end;
              end;
              Inc(LCompInd, 4);
            until LCompInd >= 0;
          end;
          {All characters match up to the max length - return the difference
           in length}
          Result := LLengthDif;
        end;
      end
      else
      begin
        {S2 = nil, return the length of S1}
        Result := PInteger(LStr1 - 4)^;
      end;
    end
    else
    begin
      {S1 = nil, return the negative length of S2}
      Result := LStr1 - PInteger(LStr2 - 4)^;
    end;
  end
  else
  begin
    {Same string}
    Result := 0;
  end;
end;
{$ifdef RangeCheckWasOn}
  {$R+}
{$endif}
{$ifdef OverflowCheckWasOn}
  {$Q+}
{$endif}

procedure Filler7;
asm
 nop
end;

{PLR Pascal entry}
{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}
{$ifopt Q+}
  {$define OverflowCheckWasOn}
  {$Q-}
{$endif}
function CompareStr_PLR_PAS_1_b(const S1, S2: string): Integer;
type
  {Define types for older Delphi versions}
  PByte = ^Byte;
  TByteArray = array[0..0] of Byte;
  PByteArray = ^TByteArray;
  PInteger = ^Integer;
var
  LStr1, LStr2, LStr1Char1, LStr2Char1, LLength1, LLength2,
    LCompInd, LLengthDif, LChars1, LChars2: Integer;
begin
  {Assign to local variables (hopefully a register)}
  LStr1 := Integer(S1);
  LStr2 := Integer(S2);
  {Different strings?}
  if LStr1 <> LStr2 then
  begin
    {Is S1 = nil?}
    if LStr1 <> 0 then
    begin
      {Is S2 = nil?}
      if LStr2 <> 0 then
      begin
        {Compare the first character}
        LStr1Char1 := PByte(LStr1)^;
        LStr2Char1 := PByte(LStr2)^;
        if LStr1Char1 <> LStr2Char1 then
        begin
          {Mismatch on first character}
          Result := LStr1Char1 - LStr2Char1;
        end
        else
        begin
          {First character is the same: Get the number of characters to compare}
          LLength1 := PInteger(LStr1 - 4)^;
          LLength2 := PInteger(LStr2 - 4)^;
          LLengthDif := LLength1 - LLength2;
          if LLengthDif >= 0 then
            LCompInd := - LLength2
          else
            LCompInd := - LLength1;
          if LCompInd < 0 then
          begin
            Dec(LStr1, LCompInd);
            Dec(LStr2, LCompInd);
            repeat
              LChars1 := PInteger(@PByteArray(LStr1)[LCompInd])^;
              LChars2 := PInteger(@PByteArray(LStr2)[LCompInd])^;
              if LChars1 <> LChars2 then
              begin
                if SmallInt(LChars1) <> SmallInt(LChars2) then
                begin
                  Result := (Byte(LChars1) shl 8) + Byte(LChars1 shr 8)
                    - (Byte(LChars2) shl 8) - Byte(LChars2 shr 8);
                  exit;
                end
                else
                begin
                  {Matched up to length?}
                  if LCompInd > -3 then
                    break;
                  {Actual micmatch}
                  Result := (LChars1 shr 24) + ((LChars1 shr 8) and $ff00)
                    - (LChars2 shr 24) - ((LChars2 shr 8) and $ff00);
                  exit;
                end;
              end;
              Inc(LCompInd, 4);
            until LCompInd >= 0;
          end;
          {All characters match up to the max length - return the difference
           in length}
          Result := LLengthDif;
        end;
      end
      else
      begin
        {S2 = nil, return the length of S1}
        Result := PInteger(LStr1 - 4)^;
      end;
    end
    else
    begin
      {S1 = nil, return the negative length of S2}
      Result := LStr1 - PInteger(LStr2 - 4)^;
    end;
  end
  else
  begin
    {Same string}
    Result := 0;
  end;
end;
{$ifdef RangeCheckWasOn}
  {$R+}
{$endif}
{$ifdef OverflowCheckWasOn}
  {$Q+}
{$endif}

procedure Filler8;
asm
 nop
end;

{PLR Pascal entry}
{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}
{$ifopt Q+}
  {$define OverflowCheckWasOn}
  {$Q-}
{$endif}
function CompareStr_PLR_PAS_1_c(const S1, S2: string): Integer;
type
  {Define types for older Delphi versions}
  PByte = ^Byte;
  TByteArray = array[0..0] of Byte;
  PByteArray = ^TByteArray;
  PInteger = ^Integer;
var
  LStr1, LStr2, LStr1Char1, LStr2Char1, LLength1, LLength2,
    LCompInd, LLengthDif, LChars1, LChars2: Integer;
begin
  {Assign to local variables (hopefully a register)}
  LStr1 := Integer(S1);
  LStr2 := Integer(S2);
  {Different strings?}
  if LStr1 <> LStr2 then
  begin
    {Is S1 = nil?}
    if LStr1 <> 0 then
    begin
      {Is S2 = nil?}
      if LStr2 <> 0 then
      begin
        {Compare the first character}
        LStr1Char1 := PByte(LStr1)^;
        LStr2Char1 := PByte(LStr2)^;
        if LStr1Char1 <> LStr2Char1 then
        begin
          {Mismatch on first character}
          Result := LStr1Char1 - LStr2Char1;
        end
        else
        begin
          {First character is the same: Get the number of characters to compare}
          LLength1 := PInteger(LStr1 - 4)^;
          LLength2 := PInteger(LStr2 - 4)^;
          LLengthDif := LLength1 - LLength2;
          if LLengthDif >= 0 then
            LCompInd := - LLength2
          else
            LCompInd := - LLength1;
          if LCompInd < 0 then
          begin
            Dec(LStr1, LCompInd);
            Dec(LStr2, LCompInd);
            repeat
              LChars1 := PInteger(@PByteArray(LStr1)[LCompInd])^;
              LChars2 := PInteger(@PByteArray(LStr2)[LCompInd])^;
              if LChars1 <> LChars2 then
              begin
                if SmallInt(LChars1) <> SmallInt(LChars2) then
                begin
                  Result := (Byte(LChars1) shl 8) + Byte(LChars1 shr 8)
                    - (Byte(LChars2) shl 8) - Byte(LChars2 shr 8);
                  exit;
                end
                else
                begin
                  {Matched up to length?}
                  if LCompInd > -3 then
                    break;
                  {Actual micmatch}
                  Result := (LChars1 shr 24) + ((LChars1 shr 8) and $ff00)
                    - (LChars2 shr 24) - ((LChars2 shr 8) and $ff00);
                  exit;
                end;
              end;
              Inc(LCompInd, 4);
            until LCompInd >= 0;
          end;
          {All characters match up to the max length - return the difference
           in length}
          Result := LLengthDif;
        end;
      end
      else
      begin
        {S2 = nil, return the length of S1}
        Result := PInteger(LStr1 - 4)^;
      end;
    end
    else
    begin
      {S1 = nil, return the negative length of S2}
      Result := LStr1 - PInteger(LStr2 - 4)^;
    end;
  end
  else
  begin
    {Same string}
    Result := 0;
  end;
end;
{$ifdef RangeCheckWasOn}
  {$R+}
{$endif}
{$ifdef OverflowCheckWasOn}
  {$Q+}
{$endif}

procedure Filler9;
asm
 nop
end;

{PLR Pascal entry}
{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}
{$ifopt Q+}
  {$define OverflowCheckWasOn}
  {$Q-}
{$endif}
function CompareStr_PLR_PAS_1_d(const S1, S2: string): Integer;
type
  {Define types for older Delphi versions}
  PByte = ^Byte;
  TByteArray = array[0..0] of Byte;
  PByteArray = ^TByteArray;
  PInteger = ^Integer;
var
  LStr1, LStr2, LStr1Char1, LStr2Char1, LLength1, LLength2,
    LCompInd, LLengthDif, LChars1, LChars2: Integer;
begin
  {Assign to local variables (hopefully a register)}
  LStr1 := Integer(S1);
  LStr2 := Integer(S2);
  {Different strings?}
  if LStr1 <> LStr2 then
  begin
    {Is S1 = nil?}
    if LStr1 <> 0 then
    begin
      {Is S2 = nil?}
      if LStr2 <> 0 then
      begin
        {Compare the first character}
        LStr1Char1 := PByte(LStr1)^;
        LStr2Char1 := PByte(LStr2)^;
        if LStr1Char1 <> LStr2Char1 then
        begin
          {Mismatch on first character}
          Result := LStr1Char1 - LStr2Char1;
        end
        else
        begin
          {First character is the same: Get the number of characters to compare}
          LLength1 := PInteger(LStr1 - 4)^;
          LLength2 := PInteger(LStr2 - 4)^;
          LLengthDif := LLength1 - LLength2;
          if LLengthDif >= 0 then
            LCompInd := - LLength2
          else
            LCompInd := - LLength1;
          if LCompInd < 0 then
          begin
            Dec(LStr1, LCompInd);
            Dec(LStr2, LCompInd);
            repeat
              LChars1 := PInteger(@PByteArray(LStr1)[LCompInd])^;
              LChars2 := PInteger(@PByteArray(LStr2)[LCompInd])^;
              if LChars1 <> LChars2 then
              begin
                if SmallInt(LChars1) <> SmallInt(LChars2) then
                begin
                  Result := (Byte(LChars1) shl 8) + Byte(LChars1 shr 8)
                    - (Byte(LChars2) shl 8) - Byte(LChars2 shr 8);
                  exit;
                end
                else
                begin
                  {Matched up to length?}
                  if LCompInd > -3 then
                    break;
                  {Actual micmatch}
                  Result := (LChars1 shr 24) + ((LChars1 shr 8) and $ff00)
                    - (LChars2 shr 24) - ((LChars2 shr 8) and $ff00);
                  exit;
                end;
              end;
              Inc(LCompInd, 4);
            until LCompInd >= 0;
          end;
          {All characters match up to the max length - return the difference
           in length}
          Result := LLengthDif;
        end;
      end
      else
      begin
        {S2 = nil, return the length of S1}
        Result := PInteger(LStr1 - 4)^;
      end;
    end
    else
    begin
      {S1 = nil, return the negative length of S2}
      Result := LStr1 - PInteger(LStr2 - 4)^;
    end;
  end
  else
  begin
    {Same string}
    Result := 0;
  end;
end;
{$ifdef RangeCheckWasOn}
  {$R+}
{$endif}
{$ifdef OverflowCheckWasOn}
  {$Q+}
{$endif}

initialization
  {Call the spacer functions to make sure the optimizer doesn't remove them}
  Spacer7;
  Spacer8;
  Spacer9;
  Spacer10;
  Spacer11;
  Spacer13;
  Spacer14;
  Spacer15;
  Filler7;
  Filler8;
  Filler9;
end.
