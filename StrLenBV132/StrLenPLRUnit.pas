unit StrLenPLRUnit;

interface

function StrLen_PLR_IA32_1_a(const Str: PChar): Cardinal;
function StrLen_PLR_IA32_1_b(const Str: PChar): Cardinal;
function StrLen_PLR_IA32_1_c(const Str: PChar): Cardinal;
function StrLen_PLR_IA32_1_d(const Str: PChar): Cardinal;
function StrLen_PLR_IA32_2_a(const Str: PChar): Cardinal;
function StrLen_PLR_IA32_2_b(const Str: PChar): Cardinal;
function StrLen_PLR_IA32_2_c(const Str: PChar): Cardinal;
function StrLen_PLR_IA32_2_d(const Str: PChar): Cardinal;
function StrLen_PLR_IA32_3_a(const Str: PChar): Cardinal;
function StrLen_PLR_IA32_3_b(const Str: PChar): Cardinal;
function StrLen_PLR_IA32_3_c(const Str: PChar): Cardinal;
function StrLen_PLR_IA32_3_d(const Str: PChar): Cardinal;

implementation

function StrLen_PLR_IA32_1_a(const Str: PChar): Cardinal;
asm
  {Check the first byte}
  cmp byte ptr [eax], 0
  je @ZeroLength
  {Get the negative of the string start in edx}
  mov edx, eax
  neg edx
  {Word align}
  add eax, 1
  and eax, -2
@ScanLoop:
  mov cx, [eax]
  add eax, 2
  test cl, ch
  jnz @ScanLoop
  test cl, cl
  jz @ReturnLess2
  test ch, ch
  jnz @ScanLoop
  lea eax, [eax + edx - 1]
  ret
@ReturnLess2:
  lea eax, [eax + edx - 2]
  ret
@ZeroLength:
  xor eax, eax
end;

procedure Filler1;
asm
 nop
end;

function StrLen_PLR_IA32_1_b(const Str: PChar): Cardinal;
asm
  {Check the first byte}
  cmp byte ptr [eax], 0
  je @ZeroLength
  {Get the negative of the string start in edx}
  mov edx, eax
  neg edx
  {Word align}
  add eax, 1
  and eax, -2
@ScanLoop:
  mov cx, [eax]
  add eax, 2
  test cl, ch
  jnz @ScanLoop
  test cl, cl
  jz @ReturnLess2
  test ch, ch
  jnz @ScanLoop
  lea eax, [eax + edx - 1]
  ret
@ReturnLess2:
  lea eax, [eax + edx - 2]
  ret
@ZeroLength:
  xor eax, eax
end;

procedure Filler2;
asm
 nop
end;

function StrLen_PLR_IA32_1_c(const Str: PChar): Cardinal;
asm
  {Check the first byte}
  cmp byte ptr [eax], 0
  je @ZeroLength
  {Get the negative of the string start in edx}
  mov edx, eax
  neg edx
  {Word align}
  add eax, 1
  and eax, -2
@ScanLoop:
  mov cx, [eax]
  add eax, 2
  test cl, ch
  jnz @ScanLoop
  test cl, cl
  jz @ReturnLess2
  test ch, ch
  jnz @ScanLoop
  lea eax, [eax + edx - 1]
  ret
@ReturnLess2:
  lea eax, [eax + edx - 2]
  ret
@ZeroLength:
  xor eax, eax
end;

procedure Filler3;
asm
 nop
end;

function StrLen_PLR_IA32_1_d(const Str: PChar): Cardinal;
asm
  {Check the first byte}
  cmp byte ptr [eax], 0
  je @ZeroLength
  {Get the negative of the string start in edx}
  mov edx, eax
  neg edx
  {Word align}
  add eax, 1
  and eax, -2
@ScanLoop:
  mov cx, [eax]
  add eax, 2
  test cl, ch
  jnz @ScanLoop
  test cl, cl
  jz @ReturnLess2
  test ch, ch
  jnz @ScanLoop
  lea eax, [eax + edx - 1]
  ret
@ReturnLess2:
  lea eax, [eax + edx - 2]
  ret
@ZeroLength:
  xor eax, eax
end;

function StrLen_PLR_IA32_2_a(const Str: PChar): Cardinal;
asm
  {Get the negative of the string start in edx}
  mov edx, eax
  neg edx
  {Check offset 0}
  cmp byte ptr [eax], 0
  je @ReturnOffset0
  {Check offset 1}
  cmp byte ptr [eax + 1], 0
  je @ReturnOffset1
  {Check offset 2}
  cmp byte ptr [eax + 2], 0
  je @ReturnOffset2
  {DWord align}
  add eax, 3
  and eax, -4
  {Scan dwords loop}
@DWordLoop:
  mov ecx, [eax]
  test cl, cl
  jz @ReturnOffset0
  test ch, ch
  jz @ReturnOffset1
  test ecx, $00ff0000
  jz @ReturnOffset2
  test ecx, $ff000000
  jz @ReturnOffset3
  add eax, 4
  jmp @DWordLoop
@ReturnOffset0:
  add eax, edx
  ret
@ReturnOffset1:
  lea eax, [eax + edx + 1]
  ret
@ReturnOffset2:
  lea eax, [eax + edx + 2]
  ret
@ReturnOffset3:
  lea eax, [eax + edx + 3]
end;

function StrLen_PLR_IA32_2_b(const Str: PChar): Cardinal;
asm
  {Get the negative of the string start in edx}
  mov edx, eax
  neg edx
  {Check offset 0}
  cmp byte ptr [eax], 0
  je @ReturnOffset0
  {Check offset 1}
  cmp byte ptr [eax + 1], 0
  je @ReturnOffset1
  {Check offset 2}
  cmp byte ptr [eax + 2], 0
  je @ReturnOffset2
  {DWord align}
  add eax, 3
  and eax, -4
  {Scan dwords loop}
@DWordLoop:
  mov ecx, [eax]
  test cl, cl
  jz @ReturnOffset0
  test ch, ch
  jz @ReturnOffset1
  test ecx, $00ff0000
  jz @ReturnOffset2
  test ecx, $ff000000
  jz @ReturnOffset3
  add eax, 4
  jmp @DWordLoop
@ReturnOffset0:
  add eax, edx
  ret
@ReturnOffset1:
  lea eax, [eax + edx + 1]
  ret
@ReturnOffset2:
  lea eax, [eax + edx + 2]
  ret
@ReturnOffset3:
  lea eax, [eax + edx + 3]
end;

function StrLen_PLR_IA32_2_c(const Str: PChar): Cardinal;
asm
  {Get the negative of the string start in edx}
  mov edx, eax
  neg edx
  {Check offset 0}
  cmp byte ptr [eax], 0
  je @ReturnOffset0
  {Check offset 1}
  cmp byte ptr [eax + 1], 0
  je @ReturnOffset1
  {Check offset 2}
  cmp byte ptr [eax + 2], 0
  je @ReturnOffset2
  {DWord align}
  add eax, 3
  and eax, -4
  {Scan dwords loop}
@DWordLoop:
  mov ecx, [eax]
  test cl, cl
  jz @ReturnOffset0
  test ch, ch
  jz @ReturnOffset1
  test ecx, $00ff0000
  jz @ReturnOffset2
  test ecx, $ff000000
  jz @ReturnOffset3
  add eax, 4
  jmp @DWordLoop
@ReturnOffset0:
  add eax, edx
  ret
@ReturnOffset1:
  lea eax, [eax + edx + 1]
  ret
@ReturnOffset2:
  lea eax, [eax + edx + 2]
  ret
@ReturnOffset3:
  lea eax, [eax + edx + 3]
end;

function StrLen_PLR_IA32_2_d(const Str: PChar): Cardinal;
asm
  {Get the negative of the string start in edx}
  mov edx, eax
  neg edx
  {Check offset 0}
  cmp byte ptr [eax], 0
  je @ReturnOffset0
  {Check offset 1}
  cmp byte ptr [eax + 1], 0
  je @ReturnOffset1
  {Check offset 2}
  cmp byte ptr [eax + 2], 0
  je @ReturnOffset2
  {DWord align}
  add eax, 3
  and eax, -4
  {Scan dwords loop}
@DWordLoop:
  mov ecx, [eax]
  test cl, cl
  jz @ReturnOffset0
  test ch, ch
  jz @ReturnOffset1
  test ecx, $00ff0000
  jz @ReturnOffset2
  test ecx, $ff000000
  jz @ReturnOffset3
  add eax, 4
  jmp @DWordLoop
@ReturnOffset0:
  add eax, edx
  ret
@ReturnOffset1:
  lea eax, [eax + edx + 1]
  ret
@ReturnOffset2:
  lea eax, [eax + edx + 2]
  ret
@ReturnOffset3:
  lea eax, [eax + edx + 3]
end;

function StrLen_PLR_IA32_3_a(const Str: PChar): Cardinal;
asm
  {Clear ecx for comparisons}
  xor ecx, ecx
  {Get the negative of the string start in edx}
  mov edx, eax
  neg edx
  {Check 8 bytes per loop}
@Check8Bytes:
  cmp [eax], cl
  je @ReturnOffset0
  cmp [eax + 1], cl
  je @ReturnOffset1
  cmp [eax + 2], cl
  je @ReturnOffset2
  cmp [eax + 3], cl
  je @ReturnOffset3
  cmp [eax + 4], cl
  je @ReturnOffset4
  cmp [eax + 5], cl
  je @ReturnOffset5
  cmp [eax + 6], cl
  je @ReturnOffset6
  cmp [eax + 7], cl
  lea eax, [eax + 8]
  jne @Check8Bytes
  lea eax, [eax + edx - 1]
  ret
@ReturnOffset0:
  add eax, edx
  ret
@ReturnOffset1:
  lea eax, [eax + edx + 1]
  ret
@ReturnOffset2:
  lea eax, [eax + edx + 2]
  ret
@ReturnOffset3:
  lea eax, [eax + edx + 3]
  ret
@ReturnOffset4:
  lea eax, [eax + edx + 4]
  ret
@ReturnOffset5:
  lea eax, [eax + edx + 5]
  ret
@ReturnOffset6:
  lea eax, [eax + edx + 6]
end;

function StrLen_PLR_IA32_3_b(const Str: PChar): Cardinal;
asm
  {Clear ecx for comparisons}
  xor ecx, ecx
  {Get the negative of the string start in edx}
  mov edx, eax
  neg edx
  {Check 8 bytes per loop}
@Check8Bytes:
  cmp [eax], cl
  je @ReturnOffset0
  cmp [eax + 1], cl
  je @ReturnOffset1
  cmp [eax + 2], cl
  je @ReturnOffset2
  cmp [eax + 3], cl
  je @ReturnOffset3
  cmp [eax + 4], cl
  je @ReturnOffset4
  cmp [eax + 5], cl
  je @ReturnOffset5
  cmp [eax + 6], cl
  je @ReturnOffset6
  cmp [eax + 7], cl
  lea eax, [eax + 8]
  jne @Check8Bytes
  lea eax, [eax + edx - 1]
  ret
@ReturnOffset0:
  add eax, edx
  ret
@ReturnOffset1:
  lea eax, [eax + edx + 1]
  ret
@ReturnOffset2:
  lea eax, [eax + edx + 2]
  ret
@ReturnOffset3:
  lea eax, [eax + edx + 3]
  ret
@ReturnOffset4:
  lea eax, [eax + edx + 4]
  ret
@ReturnOffset5:
  lea eax, [eax + edx + 5]
  ret
@ReturnOffset6:
  lea eax, [eax + edx + 6]
end;

procedure Filler4;
asm
 nop
end;

function StrLen_PLR_IA32_3_c(const Str: PChar): Cardinal;
asm
  {Clear ecx for comparisons}
  xor ecx, ecx
  {Get the negative of the string start in edx}
  mov edx, eax
  neg edx
  {Check 8 bytes per loop}
@Check8Bytes:
  cmp [eax], cl
  je @ReturnOffset0
  cmp [eax + 1], cl
  je @ReturnOffset1
  cmp [eax + 2], cl
  je @ReturnOffset2
  cmp [eax + 3], cl
  je @ReturnOffset3
  cmp [eax + 4], cl
  je @ReturnOffset4
  cmp [eax + 5], cl
  je @ReturnOffset5
  cmp [eax + 6], cl
  je @ReturnOffset6
  cmp [eax + 7], cl
  lea eax, [eax + 8]
  jne @Check8Bytes
  lea eax, [eax + edx - 1]
  ret
@ReturnOffset0:
  add eax, edx
  ret
@ReturnOffset1:
  lea eax, [eax + edx + 1]
  ret
@ReturnOffset2:
  lea eax, [eax + edx + 2]
  ret
@ReturnOffset3:
  lea eax, [eax + edx + 3]
  ret
@ReturnOffset4:
  lea eax, [eax + edx + 4]
  ret
@ReturnOffset5:
  lea eax, [eax + edx + 5]
  ret
@ReturnOffset6:
  lea eax, [eax + edx + 6]
end;

function StrLen_PLR_IA32_3_d(const Str: PChar): Cardinal;
asm
  {Clear ecx for comparisons}
  xor ecx, ecx
  {Get the negative of the string start in edx}
  mov edx, eax
  neg edx
  {Check 8 bytes per loop}
@Check8Bytes:
  cmp [eax], cl
  je @ReturnOffset0
  cmp [eax + 1], cl
  je @ReturnOffset1
  cmp [eax + 2], cl
  je @ReturnOffset2
  cmp [eax + 3], cl
  je @ReturnOffset3
  cmp [eax + 4], cl
  je @ReturnOffset4
  cmp [eax + 5], cl
  je @ReturnOffset5
  cmp [eax + 6], cl
  je @ReturnOffset6
  cmp [eax + 7], cl
  lea eax, [eax + 8]
  jne @Check8Bytes
  lea eax, [eax + edx - 1]
  ret
@ReturnOffset0:
  add eax, edx
  ret
@ReturnOffset1:
  lea eax, [eax + edx + 1]
  ret
@ReturnOffset2:
  lea eax, [eax + edx + 2]
  ret
@ReturnOffset3:
  lea eax, [eax + edx + 3]
  ret
@ReturnOffset4:
  lea eax, [eax + edx + 4]
  ret
@ReturnOffset5:
  lea eax, [eax + edx + 5]
  ret
@ReturnOffset6:
  lea eax, [eax + edx + 6]
end;

initialization

 Filler1;
 Filler2;
 Filler3;
 Filler4;

end.
