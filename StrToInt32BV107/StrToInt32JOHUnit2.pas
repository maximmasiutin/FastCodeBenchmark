unit StrToInt32JOHUnit2;

{$R-,Q-}
{$WARNINGS OFF}

interface

uses
  MainUnit, SysUtils, Math, SysConst;

implementation

function ValLong_JOH_PAS_6_a(const s; var code: Integer): Longint;
const
  AdjustLowercase = Ord('a') - 10;
  AdjustUppercase = Ord('A') - 10;
var
  Digit: Integer;
  Neg, Hex, Valid: Boolean;
  P: PChar;
begin
  Code := 0;
  P    := @S;
  if not Assigned(P) then
    begin
      Result := 0;
      inc(Code);
      Exit;
    end;
  Neg   := False;
  Hex   := False;
  Valid := False;
  while P^ = ' ' do
    Inc(P);
  if P^ in ['+', '-'] then
    begin
      Neg := (P^ = '-');
      inc(P);
    end;
  if P^ = '$' then
    begin
      Hex := True;
      inc(P);
    end
  else
    begin
      if P^ = '0' then
        begin
          Valid := True;
          inc(P);
        end;
      if (Ord(P^) or $20) = ord('x') then
        begin {Upcase(P^) = 'X'}
          Hex := True;
          inc(P);
        end;
    end;
  Result := 0;
  if Hex then
    begin
      Valid := False;
      while True do
        begin
          case P^ of
            '0'..'9': Digit := Ord(P^) - Ord('0');
            'a'..'f': Digit := Ord(P^) - AdjustLowercase;
            'A'..'F': Digit := Ord(P^) - AdjustUppercase;
            else      Break;
          end;
          if Cardinal(Result) > MaxInt div 8 then
            Break;
          Result := (Result shl 4) + Digit;
          Valid := True;
          inc(P);
        end;
    end
  else
    begin
      while True do
        begin
          if not (P^ in ['0'..'9']) then
            Break;
          if Result > (MaxInt div 10) then
            Break;
          Result := (Result * 10) + Ord(P^) - Ord('0');
          Valid := True;
          inc(P);
        end;
      if Result < 0 then {Possible Overflow}
        if (Cardinal(Result) <> $80000000) or (not neg) then
          begin {Min(LongInt) = $80000000 is a Valid Result}
            Dec(P);
            Valid := False;
          end;
    end;
  if Neg then
    Result := -Result;
  if (not Valid) or (P^ <> #0) then
    Code := P-@S+1;
end;

function ValLong_JOH_PAS_6_b(const s; var code: Integer): Longint;
const
  AdjustLowercase = Ord('a') - 10;
  AdjustUppercase = Ord('A') - 10;
var
  Digit: Integer;
  Neg, Hex, Valid: Boolean;
  P: PChar;
begin
  Code := 0;
  P    := @S;
  if not Assigned(P) then
    begin
      Result := 0;
      inc(Code);
      Exit;
    end;
  Neg   := False;
  Hex   := False;
  Valid := False;
  while P^ = ' ' do
    Inc(P);
  if P^ in ['+', '-'] then
    begin
      Neg := (P^ = '-');
      inc(P);
    end;
  if P^ = '$' then
    begin
      Hex := True;
      inc(P);
    end
  else
    begin
      if P^ = '0' then
        begin
          Valid := True;
          inc(P);
        end;
      if (Ord(P^) or $20) = ord('x') then
        begin {Upcase(P^) = 'X'}
          Hex := True;
          inc(P);
        end;
    end;
  Result := 0;
  if Hex then
    begin
      Valid := False;
      while True do
        begin
          case P^ of
            '0'..'9': Digit := Ord(P^) - Ord('0');
            'a'..'f': Digit := Ord(P^) - AdjustLowercase;
            'A'..'F': Digit := Ord(P^) - AdjustUppercase;
            else      Break;
          end;
          if Cardinal(Result) > MaxInt div 8 then
            Break;
          Result := (Result shl 4) + Digit;
          Valid := True;
          inc(P);
        end;
    end
  else
    begin
      while True do
        begin
          if not (P^ in ['0'..'9']) then
            Break;
          if Result > (MaxInt div 10) then
            Break;
          Result := (Result * 10) + Ord(P^) - Ord('0');
          Valid := True;
          inc(P);
        end;
      if Result < 0 then {Possible Overflow}
        if (Cardinal(Result) <> $80000000) or (not neg) then
          begin {Min(LongInt) = $80000000 is a Valid Result}
            Dec(P);
            Valid := False;
          end;
    end;
  if Neg then
    Result := -Result;
  if (not Valid) or (P^ <> #0) then
    Code := P-@S+1;
end;

function ValLong_JOH_PAS_6_c(const s; var code: Integer): Longint;
const
  AdjustLowercase = Ord('a') - 10;
  AdjustUppercase = Ord('A') - 10;
var
  Digit: Integer;
  Neg, Hex, Valid: Boolean;
  P: PChar;
begin
  Code := 0;
  P    := @S;
  if not Assigned(P) then
    begin
      Result := 0;
      inc(Code);
      Exit;
    end;
  Neg   := False;
  Hex   := False;
  Valid := False;
  while P^ = ' ' do
    Inc(P);
  if P^ in ['+', '-'] then
    begin
      Neg := (P^ = '-');
      inc(P);
    end;
  if P^ = '$' then
    begin
      Hex := True;
      inc(P);
    end
  else
    begin
      if P^ = '0' then
        begin
          Valid := True;
          inc(P);
        end;
      if (Ord(P^) or $20) = ord('x') then
        begin {Upcase(P^) = 'X'}
          Hex := True;
          inc(P);
        end;
    end;
  Result := 0;
  if Hex then
    begin
      Valid := False;
      while True do
        begin
          case P^ of
            '0'..'9': Digit := Ord(P^) - Ord('0');
            'a'..'f': Digit := Ord(P^) - AdjustLowercase;
            'A'..'F': Digit := Ord(P^) - AdjustUppercase;
            else      Break;
          end;
          if Cardinal(Result) > MaxInt div 8 then
            Break;
          Result := (Result shl 4) + Digit;
          Valid := True;
          inc(P);
        end;
    end
  else
    begin
      while True do
        begin
          if not (P^ in ['0'..'9']) then
            Break;
          if Result > (MaxInt div 10) then
            Break;
          Result := (Result * 10) + Ord(P^) - Ord('0');
          Valid := True;
          inc(P);
        end;
      if Result < 0 then {Possible Overflow}
        if (Cardinal(Result) <> $80000000) or (not neg) then
          begin {Min(LongInt) = $80000000 is a Valid Result}
            Dec(P);
            Valid := False;
          end;
    end;
  if Neg then
    Result := -Result;
  if (not Valid) or (P^ <> #0) then
    Code := P-@S+1;
end;

function ValLong_JOH_PAS_6_d(const s; var code: Integer): Longint;
const
  AdjustLowercase = Ord('a') - 10;
  AdjustUppercase = Ord('A') - 10;
var
  Digit: Integer;
  Neg, Hex, Valid: Boolean;
  P: PChar;
begin
  Code := 0;
  P    := @S;
  if not Assigned(P) then
    begin
      Result := 0;
      inc(Code);
      Exit;
    end;
  Neg   := False;
  Hex   := False;
  Valid := False;
  while P^ = ' ' do
    Inc(P);
  if P^ in ['+', '-'] then
    begin
      Neg := (P^ = '-');
      inc(P);
    end;
  if P^ = '$' then
    begin
      Hex := True;
      inc(P);
    end
  else
    begin
      if P^ = '0' then
        begin
          Valid := True;
          inc(P);
        end;
      if (Ord(P^) or $20) = ord('x') then
        begin {Upcase(P^) = 'X'}
          Hex := True;
          inc(P);
        end;
    end;
  Result := 0;
  if Hex then
    begin
      Valid := False;
      while True do
        begin
          case P^ of
            '0'..'9': Digit := Ord(P^) - Ord('0');
            'a'..'f': Digit := Ord(P^) - AdjustLowercase;
            'A'..'F': Digit := Ord(P^) - AdjustUppercase;
            else      Break;
          end;
          if Cardinal(Result) > MaxInt div 8 then
            Break;
          Result := (Result shl 4) + Digit;
          Valid := True;
          inc(P);
        end;
    end
  else
    begin
      while True do
        begin
          if not (P^ in ['0'..'9']) then
            Break;
          if Result > (MaxInt div 10) then
            Break;
          Result := (Result * 10) + Ord(P^) - Ord('0');
          Valid := True;
          inc(P);
        end;
      if Result < 0 then {Possible Overflow}
        if (Cardinal(Result) <> $80000000) or (not neg) then
          begin {Min(LongInt) = $80000000 is a Valid Result}
            Dec(P);
            Valid := False;
          end;
    end;
  if Neg then
    Result := -Result;
  if (not Valid) or (P^ <> #0) then
    Code := P-@S+1;
end;

function ValLong_JOH_IA32_6_a(const s; var code: Integer): Longint;
asm
  test  eax, eax
  jz    @@Null
  push  ebx
  push  esi
  push  eax                 {Save String Pointer}
  mov   esi, eax            {String Pointer}
  xor   ebx, ebx            {Clear Valid Flag and Sign Flag}
  xor   eax, eax            {Clear Result}
  jmp   @@TrimEntry
@@Null:
  mov   [edx], eax
  inc   [edx]               {Code = 1}
  ret
@@Trim:                     {Strip Leading Spaces}
  inc   esi
@@TrimEntry:
  movzx ecx, [esi]
  cmp   cl, ' '
  je    @@Trim
  cmp   cl, '0'
  jle   @@CheckFirstChar
@@CheckAlpha:
  test  cl, not 'x'
  jz    @@CheckX            {May be 'x' or 'X'}
@@NumLoop:
  sub   cl, '0'
  cmp   cl, 9
  ja    @@NumDone           {Not '0'..'9'}
  cmp   eax, MaxInt/10
  ja    @@SetSign
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}
  inc   esi
  mov   bl, 1               {Valid := True}
  movzx ecx, [esi]
  jmp   @@NumLoop
@@NumDone:
  cmp   eax, $80000000
  jb    @@SetSign           {No Overflow}
  jne   @@Overflow
  test  ebx, ebx            {Sign Flag}
  js    @@SetSign           {Result is Valid (-MaxInt-1)}
@@Overflow:
  dec   esi
  mov   bl, 0               {Valid := False}
  jmp   @@SetSign
@@CheckFirstChar:
  cmp   cl, '+'
  je    @@PlusMinus
  cmp   cl, '-'
  jne   @@SignSet
@@PlusMinus:                {Starts with '+' or '-'}
  mov   bl, '+'+1
  sub   ebx, ecx            {Set Sign Flag: '+' -> +1, '-' -> -1}
  inc   esi
  mov   bl, 0               {Valid := False}
  movzx ecx, [esi]          {Character after '+' or '-'}
@@SignSet:
  cmp   cl, '$'
  je    @@Hex               {Hexadecimal}
  cmp   cl, '0'
  jne   @@CheckAlpha        {May start with 'x' or 'X'}
  inc   esi
  mov   bl, 1               {Assume Valid = True}
  movzx ecx, [esi]          {Character after '0'}
  jmp   @@CheckAlpha        {May start with '0x' or '0X'}
@@CheckX:
  mov   bh, cl
  or    bh, $20             {'X' -> 'x'}
  cmp   bh, 'x'
  jne   @@NumLoop
@@Hex:
  mov   bl, 0               {Valid := False}
@@HexLoop:
  inc   esi
  movzx ecx, [esi]
  sub   cl, '0'
  cmp   cl, 9
  jna   @@CheckHexRange     {'0'..'9'}
  mov   bh, cl              {Check for Valid Hex Character}
  sub   bh, 'a'-'0'         {'a' -> 0}
  cmp   bh, 'z'-'a'+1       {Carry if 'a'..'z'}
  sbb   bh, bh              {=$FF if 'a'..'z' else $00}
  and   bh, $20             {=$20 if 'a'..'z' else $00}
  sub   cl, bh              {'a'..'z' -> 'A'..'Z'}
  sub   cl, 'A'-'0'-10      {'A'..'Z' -> 10..15}
  cmp   cl, 15
  ja    @@NotHex            {Not Hex Character}
@@CheckHexRange:
  cmp   eax, MaxInt/8       {High(ULONG) div 16}
  ja    @@SetSign           {Overflow}
  shl   eax, 4              {Result = Result * 16}
  mov   bl, 1               {Valid := True}
  add   eax, ecx
  jmp   @@HexLoop
@@NotHex:
  add   cl, 'A'-'0'-10      {Restore Char-'0'}
@@SetSign:
  mov   ch, bl              {Save Valid Flag}
  sar   ebx, 31             {Set Each Bit to Top Bit}
  dec   ch                  {0 if Valid, -1 if Invalid}
  xor   eax, ebx            {Negate Result if Necessary}
  sub   eax, ebx
  or    cl, ch              {If Invalid, Force CL = -1}
  cmp   cl, -'0'            {Last Character = #0?}
  jne   @@Error             {Not Valid or Not End of String}
  xor   esi, esi            {Code := 0}
  pop   ecx                 {Dump String Pointer}
@@Finished:
  mov   [edx], esi          {Set Error Code}
  pop   esi
  pop   ebx
  ret
@@Error:
  inc   esi
  pop   ecx                 {String Pointer}
  sub   esi, ecx
  jmp   @@Finished          {Exit Setting Error Code}
end;

function ValLong_JOH_IA32_6_b(const s; var code: Integer): Longint;
asm
  test  eax, eax
  jz    @@Null
  push  ebx
  push  esi
  push  eax                 {Save String Pointer}
  mov   esi, eax            {String Pointer}
  xor   ebx, ebx            {Clear Valid Flag and Sign Flag}
  xor   eax, eax            {Clear Result}
  jmp   @@TrimEntry
@@Null:
  mov   [edx], eax
  inc   [edx]               {Code = 1}
  ret
@@Trim:                     {Strip Leading Spaces}
  inc   esi
@@TrimEntry:
  movzx ecx, [esi]
  cmp   cl, ' '
  je    @@Trim
  cmp   cl, '0'
  jle   @@CheckFirstChar
@@CheckAlpha:
  test  cl, not 'x'
  jz    @@CheckX            {May be 'x' or 'X'}
@@NumLoop:
  sub   cl, '0'
  cmp   cl, 9
  ja    @@NumDone           {Not '0'..'9'}
  cmp   eax, MaxInt/10
  ja    @@SetSign
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}
  inc   esi
  mov   bl, 1               {Valid := True}
  movzx ecx, [esi]
  jmp   @@NumLoop
@@NumDone:
  cmp   eax, $80000000
  jb    @@SetSign           {No Overflow}
  jne   @@Overflow
  test  ebx, ebx            {Sign Flag}
  js    @@SetSign           {Result is Valid (-MaxInt-1)}
@@Overflow:
  dec   esi
  mov   bl, 0               {Valid := False}
  jmp   @@SetSign
@@CheckFirstChar:
  cmp   cl, '+'
  je    @@PlusMinus
  cmp   cl, '-'
  jne   @@SignSet
@@PlusMinus:                {Starts with '+' or '-'}
  mov   bl, '+'+1
  sub   ebx, ecx            {Set Sign Flag: '+' -> +1, '-' -> -1}
  inc   esi
  mov   bl, 0               {Valid := False}
  movzx ecx, [esi]          {Character after '+' or '-'}
@@SignSet:
  cmp   cl, '$'
  je    @@Hex               {Hexadecimal}
  cmp   cl, '0'
  jne   @@CheckAlpha        {May start with 'x' or 'X'}
  inc   esi
  mov   bl, 1               {Assume Valid = True}
  movzx ecx, [esi]          {Character after '0'}
  jmp   @@CheckAlpha        {May start with '0x' or '0X'}
@@CheckX:
  mov   bh, cl
  or    bh, $20             {'X' -> 'x'}
  cmp   bh, 'x'
  jne   @@NumLoop
@@Hex:
  mov   bl, 0               {Valid := False}
@@HexLoop:
  inc   esi
  movzx ecx, [esi]
  sub   cl, '0'
  cmp   cl, 9
  jna   @@CheckHexRange     {'0'..'9'}
  mov   bh, cl              {Check for Valid Hex Character}
  sub   bh, 'a'-'0'         {'a' -> 0}
  cmp   bh, 'z'-'a'+1       {Carry if 'a'..'z'}
  sbb   bh, bh              {=$FF if 'a'..'z' else $00}
  and   bh, $20             {=$20 if 'a'..'z' else $00}
  sub   cl, bh              {'a'..'z' -> 'A'..'Z'}
  sub   cl, 'A'-'0'-10      {'A'..'Z' -> 10..15}
  cmp   cl, 15
  ja    @@NotHex            {Not Hex Character}
@@CheckHexRange:
  cmp   eax, MaxInt/8       {High(ULONG) div 16}
  ja    @@SetSign           {Overflow}
  shl   eax, 4              {Result = Result * 16}
  mov   bl, 1               {Valid := True}
  add   eax, ecx
  jmp   @@HexLoop
@@NotHex:
  add   cl, 'A'-'0'-10      {Restore Char-'0'}
@@SetSign:
  mov   ch, bl              {Save Valid Flag}
  sar   ebx, 31             {Set Each Bit to Top Bit}
  dec   ch                  {0 if Valid, -1 if Invalid}
  xor   eax, ebx            {Negate Result if Necessary}
  sub   eax, ebx
  or    cl, ch              {If Invalid, Force CL = -1}
  cmp   cl, -'0'            {Last Character = #0?}
  jne   @@Error             {Not Valid or Not End of String}
  xor   esi, esi            {Code := 0}
  pop   ecx                 {Dump String Pointer}
@@Finished:
  mov   [edx], esi          {Set Error Code}
  pop   esi
  pop   ebx
  ret
@@Error:
  inc   esi
  pop   ecx                 {String Pointer}
  sub   esi, ecx
  jmp   @@Finished          {Exit Setting Error Code}
end;

function ValLong_JOH_IA32_6_c(const s; var code: Integer): Longint;
asm
  test  eax, eax
  jz    @@Null
  push  ebx
  push  esi
  push  eax                 {Save String Pointer}
  mov   esi, eax            {String Pointer}
  xor   ebx, ebx            {Clear Valid Flag and Sign Flag}
  xor   eax, eax            {Clear Result}
  jmp   @@TrimEntry
@@Null:
  mov   [edx], eax
  inc   [edx]               {Code = 1}
  ret
@@Trim:                     {Strip Leading Spaces}
  inc   esi
@@TrimEntry:
  movzx ecx, [esi]
  cmp   cl, ' '
  je    @@Trim
  cmp   cl, '0'
  jle   @@CheckFirstChar
@@CheckAlpha:
  test  cl, not 'x'
  jz    @@CheckX            {May be 'x' or 'X'}
@@NumLoop:
  sub   cl, '0'
  cmp   cl, 9
  ja    @@NumDone           {Not '0'..'9'}
  cmp   eax, MaxInt/10
  ja    @@SetSign
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}
  inc   esi
  mov   bl, 1               {Valid := True}
  movzx ecx, [esi]
  jmp   @@NumLoop
@@NumDone:
  cmp   eax, $80000000
  jb    @@SetSign           {No Overflow}
  jne   @@Overflow
  test  ebx, ebx            {Sign Flag}
  js    @@SetSign           {Result is Valid (-MaxInt-1)}
@@Overflow:
  dec   esi
  mov   bl, 0               {Valid := False}
  jmp   @@SetSign
@@CheckFirstChar:
  cmp   cl, '+'
  je    @@PlusMinus
  cmp   cl, '-'
  jne   @@SignSet
@@PlusMinus:                {Starts with '+' or '-'}
  mov   bl, '+'+1
  sub   ebx, ecx            {Set Sign Flag: '+' -> +1, '-' -> -1}
  inc   esi
  mov   bl, 0               {Valid := False}
  movzx ecx, [esi]          {Character after '+' or '-'}
@@SignSet:
  cmp   cl, '$'
  je    @@Hex               {Hexadecimal}
  cmp   cl, '0'
  jne   @@CheckAlpha        {May start with 'x' or 'X'}
  inc   esi
  mov   bl, 1               {Assume Valid = True}
  movzx ecx, [esi]          {Character after '0'}
  jmp   @@CheckAlpha        {May start with '0x' or '0X'}
@@CheckX:
  mov   bh, cl
  or    bh, $20             {'X' -> 'x'}
  cmp   bh, 'x'
  jne   @@NumLoop
@@Hex:
  mov   bl, 0               {Valid := False}
@@HexLoop:
  inc   esi
  movzx ecx, [esi]
  sub   cl, '0'
  cmp   cl, 9
  jna   @@CheckHexRange     {'0'..'9'}
  mov   bh, cl              {Check for Valid Hex Character}
  sub   bh, 'a'-'0'         {'a' -> 0}
  cmp   bh, 'z'-'a'+1       {Carry if 'a'..'z'}
  sbb   bh, bh              {=$FF if 'a'..'z' else $00}
  and   bh, $20             {=$20 if 'a'..'z' else $00}
  sub   cl, bh              {'a'..'z' -> 'A'..'Z'}
  sub   cl, 'A'-'0'-10      {'A'..'Z' -> 10..15}
  cmp   cl, 15
  ja    @@NotHex            {Not Hex Character}
@@CheckHexRange:
  cmp   eax, MaxInt/8       {High(ULONG) div 16}
  ja    @@SetSign           {Overflow}
  shl   eax, 4              {Result = Result * 16}
  mov   bl, 1               {Valid := True}
  add   eax, ecx
  jmp   @@HexLoop
@@NotHex:
  add   cl, 'A'-'0'-10      {Restore Char-'0'}
@@SetSign:
  mov   ch, bl              {Save Valid Flag}
  sar   ebx, 31             {Set Each Bit to Top Bit}
  dec   ch                  {0 if Valid, -1 if Invalid}
  xor   eax, ebx            {Negate Result if Necessary}
  sub   eax, ebx
  or    cl, ch              {If Invalid, Force CL = -1}
  cmp   cl, -'0'            {Last Character = #0?}
  jne   @@Error             {Not Valid or Not End of String}
  xor   esi, esi            {Code := 0}
  pop   ecx                 {Dump String Pointer}
@@Finished:
  mov   [edx], esi          {Set Error Code}
  pop   esi
  pop   ebx
  ret
@@Error:
  inc   esi
  pop   ecx                 {String Pointer}
  sub   esi, ecx
  jmp   @@Finished          {Exit Setting Error Code}
end;

function ValLong_JOH_IA32_6_d(const s; var code: Integer): Longint;
asm
  test  eax, eax
  jz    @@Null
  push  ebx
  push  esi
  push  eax                 {Save String Pointer}
  mov   esi, eax            {String Pointer}
  xor   ebx, ebx            {Clear Valid Flag and Sign Flag}
  xor   eax, eax            {Clear Result}
  jmp   @@TrimEntry
@@Null:
  mov   [edx], eax
  inc   [edx]               {Code = 1}
  ret
@@Trim:                     {Strip Leading Spaces}
  inc   esi
@@TrimEntry:
  movzx ecx, [esi]
  cmp   cl, ' '
  je    @@Trim
  cmp   cl, '0'
  jle   @@CheckFirstChar
@@CheckAlpha:
  test  cl, not 'x'
  jz    @@CheckX            {May be 'x' or 'X'}
@@NumLoop:
  sub   cl, '0'
  cmp   cl, 9
  ja    @@NumDone           {Not '0'..'9'}
  cmp   eax, MaxInt/10
  ja    @@SetSign
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}
  inc   esi
  mov   bl, 1               {Valid := True}
  movzx ecx, [esi]
  jmp   @@NumLoop
@@NumDone:
  cmp   eax, $80000000
  jb    @@SetSign           {No Overflow}
  jne   @@Overflow
  test  ebx, ebx            {Sign Flag}
  js    @@SetSign           {Result is Valid (-MaxInt-1)}
@@Overflow:
  dec   esi
  mov   bl, 0               {Valid := False}
  jmp   @@SetSign
@@CheckFirstChar:
  cmp   cl, '+'
  je    @@PlusMinus
  cmp   cl, '-'
  jne   @@SignSet
@@PlusMinus:                {Starts with '+' or '-'}
  mov   bl, '+'+1
  sub   ebx, ecx            {Set Sign Flag: '+' -> +1, '-' -> -1}
  inc   esi
  mov   bl, 0               {Valid := False}
  movzx ecx, [esi]          {Character after '+' or '-'}
@@SignSet:
  cmp   cl, '$'
  je    @@Hex               {Hexadecimal}
  cmp   cl, '0'
  jne   @@CheckAlpha        {May start with 'x' or 'X'}
  inc   esi
  mov   bl, 1               {Assume Valid = True}
  movzx ecx, [esi]          {Character after '0'}
  jmp   @@CheckAlpha        {May start with '0x' or '0X'}
@@CheckX:
  mov   bh, cl
  or    bh, $20             {'X' -> 'x'}
  cmp   bh, 'x'
  jne   @@NumLoop
@@Hex:
  mov   bl, 0               {Valid := False}
@@HexLoop:
  inc   esi
  movzx ecx, [esi]
  sub   cl, '0'
  cmp   cl, 9
  jna   @@CheckHexRange     {'0'..'9'}
  mov   bh, cl              {Check for Valid Hex Character}
  sub   bh, 'a'-'0'         {'a' -> 0}
  cmp   bh, 'z'-'a'+1       {Carry if 'a'..'z'}
  sbb   bh, bh              {=$FF if 'a'..'z' else $00}
  and   bh, $20             {=$20 if 'a'..'z' else $00}
  sub   cl, bh              {'a'..'z' -> 'A'..'Z'}
  sub   cl, 'A'-'0'-10      {'A'..'Z' -> 10..15}
  cmp   cl, 15
  ja    @@NotHex            {Not Hex Character}
@@CheckHexRange:
  cmp   eax, MaxInt/8       {High(ULONG) div 16}
  ja    @@SetSign           {Overflow}
  shl   eax, 4              {Result = Result * 16}
  mov   bl, 1               {Valid := True}
  add   eax, ecx
  jmp   @@HexLoop
@@NotHex:
  add   cl, 'A'-'0'-10      {Restore Char-'0'}
@@SetSign:
  mov   ch, bl              {Save Valid Flag}
  sar   ebx, 31             {Set Each Bit to Top Bit}
  dec   ch                  {0 if Valid, -1 if Invalid}
  xor   eax, ebx            {Negate Result if Necessary}
  sub   eax, ebx
  or    cl, ch              {If Invalid, Force CL = -1}
  cmp   cl, -'0'            {Last Character = #0?}
  jne   @@Error             {Not Valid or Not End of String}
  xor   esi, esi            {Code := 0}
  pop   ecx                 {Dump String Pointer}
@@Finished:
  mov   [edx], esi          {Set Error Code}
  pop   esi
  pop   ebx
  ret
@@Error:
  inc   esi
  pop   ecx                 {String Pointer}
  sub   esi, ecx
  jmp   @@Finished          {Exit Setting Error Code}
end;

function StrToInt32_JOH_PAS_6_a(const S: string) : Integer; //Validated
var
  E: Integer;
begin
//  Val(S, Result, E); {when system._ValLong updated}
  Result := ValLong_JOH_PAS_6_a(Pointer(S)^, E);
  if E <> 0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
end;

function StrToInt32_JOH_PAS_6_b(const S: string) : Integer; //Validated
var
  E: Integer;
begin
//  Val(S, Result, E); {when system._ValLong updated}
  Result := ValLong_JOH_PAS_6_b(Pointer(S)^, E);
  if E <> 0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
end;

function StrToInt32_JOH_PAS_6_c(const S: string) : Integer; //Validated
var
  E: Integer;
begin
//  Val(S, Result, E); {when system._ValLong updated}
  Result := ValLong_JOH_PAS_6_c(Pointer(S)^, E);
  if E <> 0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
end;

function StrToInt32_JOH_PAS_6_d(const S: string) : Integer; //Validated
var
  E: Integer;
begin
//  Val(S, Result, E); {when system._ValLong updated}
  Result := ValLong_JOH_PAS_6_d(Pointer(S)^, E);
  if E <> 0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
end;

procedure StrToIntError(const S: string);
begin
  raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
end;

function StrToInt32_JOH_IA32_6_a(const S: string) : Integer;
asm
  push  eax
  push  ecx
  mov   edx, esp
  call  ValLong_JOH_IA32_6_a
  pop   ecx
  test  ecx, ecx
  jz    @@Exit
  pop   eax
  jmp   StrToIntError
@@Exit:
  pop   ecx
end;

function StrToInt32_JOH_IA32_6_b(const S: string) : Integer;
asm
  push  eax
  push  ecx
  mov   edx, esp
  call  ValLong_JOH_IA32_6_b
  pop   ecx
  test  ecx, ecx
  jz    @@Exit
  pop   eax
  jmp   StrToIntError
@@Exit:
  pop   ecx
end;

procedure Filler1;
asm
  nop
end;

function StrToInt32_JOH_IA32_6_c(const S: string) : Integer;
asm
  push  eax
  push  ecx
  mov   edx, esp
  call  ValLong_JOH_IA32_6_c
  pop   ecx
  test  ecx, ecx
  jz    @@Exit
  pop   eax
  jmp   StrToIntError
@@Exit:
  pop   ecx
end;

function StrToInt32_JOH_IA32_6_d(const S: string) : Integer;
asm
  push  eax
  push  ecx
  mov   edx, esp
  call  ValLong_JOH_IA32_6_d
  pop   ecx
  test  ecx, ecx
  jz    @@Exit
  pop   eax
  jmp   StrToIntError
@@Exit:
  pop   ecx
end;

function StrToInt32_JOH_PAS_7_a(const s: string): Longint;
const
  AdjustLowercase = Ord('a') - 10;
  AdjustUppercase = Ord('A') - 10;
var
  Digit: Integer;
  Neg, Hex, Valid: Boolean;
  P: PChar;
begin
  P := Pointer(S);
  if not Assigned(P) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
  Neg   := False;
  Hex   := False;
  Valid := False;
  while P^ = ' ' do
    Inc(P);
  if P^ in ['+', '-'] then
    begin
      Neg := (P^ = '-');
      inc(P);
    end;
  if P^ = '$' then
    begin
      Hex := True;
      inc(P);
    end
  else
    begin
      if P^ = '0' then
        begin
          Valid := True;
          inc(P);
        end;
      if (Ord(P^) or $20) = ord('x') then
        begin {Upcase(P^) = 'X'}
          Hex := True;
          inc(P);
        end;
    end;
  Result := 0;
  if Hex then
    begin
      Valid := False;
      while True do
        begin
          case P^ of
            '0'..'9': Digit := Ord(P^) - Ord('0');
            'a'..'f': Digit := Ord(P^) - AdjustLowercase;
            'A'..'F': Digit := Ord(P^) - AdjustUppercase;
            else      Break;
          end;
          if Cardinal(Result) > MaxInt div 8 then
            Break;
          Result := (Result shl 4) + Digit;
          Valid := True;
          inc(P);
        end;
    end
  else
    begin
      while True do
        begin
          if not (P^ in ['0'..'9']) then
            Break;
          if Result > (MaxInt div 10) then
            Break;
          Result := (Result * 10) + Ord(P^) - Ord('0');
          Valid := True;
          inc(P);
        end;
      if Result < 0 then {Possible Overflow}
        if (Cardinal(Result) <> $80000000) or (not neg) then
          begin {Min(LongInt) = $80000000 is a Valid Result}
            Dec(P);
            Valid := False;
          end;
    end;
  if Neg then
    Result := -Result;
  if (not Valid) or (P^ <> #0) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
end;

function StrToInt32_JOH_PAS_7_b(const s: string): Longint;
const
  AdjustLowercase = Ord('a') - 10;
  AdjustUppercase = Ord('A') - 10;
var
  Digit: Integer;
  Neg, Hex, Valid: Boolean;
  P: PChar;
begin
  P := Pointer(S);
  if not Assigned(P) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
  Neg   := False;
  Hex   := False;
  Valid := False;
  while P^ = ' ' do
    Inc(P);
  if P^ in ['+', '-'] then
    begin
      Neg := (P^ = '-');
      inc(P);
    end;
  if P^ = '$' then
    begin
      Hex := True;
      inc(P);
    end
  else
    begin
      if P^ = '0' then
        begin
          Valid := True;
          inc(P);
        end;
      if (Ord(P^) or $20) = ord('x') then
        begin {Upcase(P^) = 'X'}
          Hex := True;
          inc(P);
        end;
    end;
  Result := 0;
  if Hex then
    begin
      Valid := False;
      while True do
        begin
          case P^ of
            '0'..'9': Digit := Ord(P^) - Ord('0');
            'a'..'f': Digit := Ord(P^) - AdjustLowercase;
            'A'..'F': Digit := Ord(P^) - AdjustUppercase;
            else      Break;
          end;
          if Cardinal(Result) > MaxInt div 8 then
            Break;
          Result := (Result shl 4) + Digit;
          Valid := True;
          inc(P);
        end;
    end
  else
    begin
      while True do
        begin
          if not (P^ in ['0'..'9']) then
            Break;
          if Result > (MaxInt div 10) then
            Break;
          Result := (Result * 10) + Ord(P^) - Ord('0');
          Valid := True;
          inc(P);
        end;
      if Result < 0 then {Possible Overflow}
        if (Cardinal(Result) <> $80000000) or (not neg) then
          begin {Min(LongInt) = $80000000 is a Valid Result}
            Dec(P);
            Valid := False;
          end;
    end;
  if Neg then
    Result := -Result;
  if (not Valid) or (P^ <> #0) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
end;

function StrToInt32_JOH_PAS_7_c(const s: string): Longint;
const
  AdjustLowercase = Ord('a') - 10;
  AdjustUppercase = Ord('A') - 10;
var
  Digit: Integer;
  Neg, Hex, Valid: Boolean;
  P: PChar;
begin
  P := Pointer(S);
  if not Assigned(P) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
  Neg   := False;
  Hex   := False;
  Valid := False;
  while P^ = ' ' do
    Inc(P);
  if P^ in ['+', '-'] then
    begin
      Neg := (P^ = '-');
      inc(P);
    end;
  if P^ = '$' then
    begin
      Hex := True;
      inc(P);
    end
  else
    begin
      if P^ = '0' then
        begin
          Valid := True;
          inc(P);
        end;
      if (Ord(P^) or $20) = ord('x') then
        begin {Upcase(P^) = 'X'}
          Hex := True;
          inc(P);
        end;
    end;
  Result := 0;
  if Hex then
    begin
      Valid := False;
      while True do
        begin
          case P^ of
            '0'..'9': Digit := Ord(P^) - Ord('0');
            'a'..'f': Digit := Ord(P^) - AdjustLowercase;
            'A'..'F': Digit := Ord(P^) - AdjustUppercase;
            else      Break;
          end;
          if Cardinal(Result) > MaxInt div 8 then
            Break;
          Result := (Result shl 4) + Digit;
          Valid := True;
          inc(P);
        end;
    end
  else
    begin
      while True do
        begin
          if not (P^ in ['0'..'9']) then
            Break;
          if Result > (MaxInt div 10) then
            Break;
          Result := (Result * 10) + Ord(P^) - Ord('0');
          Valid := True;
          inc(P);
        end;
      if Result < 0 then {Possible Overflow}
        if (Cardinal(Result) <> $80000000) or (not neg) then
          begin {Min(LongInt) = $80000000 is a Valid Result}
            Dec(P);
            Valid := False;
          end;
    end;
  if Neg then
    Result := -Result;
  if (not Valid) or (P^ <> #0) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
end;

function StrToInt32_JOH_PAS_7_d(const s: string): Longint;
const
  AdjustLowercase = Ord('a') - 10;
  AdjustUppercase = Ord('A') - 10;
var
  Digit: Integer;
  Neg, Hex, Valid: Boolean;
  P: PChar;
begin
  P := Pointer(S);
  if not Assigned(P) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
  Neg   := False;
  Hex   := False;
  Valid := False;
  while P^ = ' ' do
    Inc(P);
  if P^ in ['+', '-'] then
    begin
      Neg := (P^ = '-');
      inc(P);
    end;
  if P^ = '$' then
    begin
      Hex := True;
      inc(P);
    end
  else
    begin
      if P^ = '0' then
        begin
          Valid := True;
          inc(P);
        end;
      if (Ord(P^) or $20) = ord('x') then
        begin {Upcase(P^) = 'X'}
          Hex := True;
          inc(P);
        end;
    end;
  Result := 0;
  if Hex then
    begin
      Valid := False;
      while True do
        begin
          case P^ of
            '0'..'9': Digit := Ord(P^) - Ord('0');
            'a'..'f': Digit := Ord(P^) - AdjustLowercase;
            'A'..'F': Digit := Ord(P^) - AdjustUppercase;
            else      Break;
          end;
          if Cardinal(Result) > MaxInt div 8 then
            Break;
          Result := (Result shl 4) + Digit;
          Valid := True;
          inc(P);
        end;
    end
  else
    begin
      while True do
        begin
          if not (P^ in ['0'..'9']) then
            Break;
          if Result > (MaxInt div 10) then
            Break;
          Result := (Result * 10) + Ord(P^) - Ord('0');
          Valid := True;
          inc(P);
        end;
      if Result < 0 then {Possible Overflow}
        if (Cardinal(Result) <> $80000000) or (not neg) then
          begin {Min(LongInt) = $80000000 is a Valid Result}
            Dec(P);
            Valid := False;
          end;
    end;
  if Neg then
    Result := -Result;
  if (not Valid) or (P^ <> #0) then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
end;

function StrToInt32_JOH_IA32_7_a(const S: string) : Integer;
asm
  test  eax, eax
  jz    @@Failed
  push  eax
  push  ebx
  push  edi
  push  esi
  mov   edx, eax            {String Pointer}
  xor   ebx, ebx            {Clear Sign Flag (top bit) and Valid Flag}
  xor   eax, eax            {Clear Result}
  mov   edi, '0'
  mov   esi, 9
@@Trim:                     {Strip Leading Spaces}
  movzx ecx, [edx]
  inc   edx
  cmp   cl, ' '
  je    @@Trim
  cmp   ecx, edi            {cl <= '0'?}
  jle   @@CheckFirstChar    {Yes, Check +, -, $, 0x, 0X}
  test  cl, not 'x'
  jz    @@CheckX            {May start with 'x' or 'X'}

@@Numeric:
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@TestValid         {Not '0'..'9'}
  mov   eax, ecx            {Result := Digit}

  movzx ecx, [edx]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+1]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+2]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+3]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+4]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+5]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+6]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+7]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

@@NumLoop:
  movzx ecx, [edx+8]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@NumDone           {Not '0'..'9'}
  cmp   eax, MaxInt/10
  ja    @@Error
  inc   edx
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}
  jmp   @@NumLoop

@@TestValid:
  test  bl, bl              {Got Valid Number?}
  jz    @@Error             {No, Error}
@@CheckDone:            
  add   ecx, edi            {Last Character = Null Terminator?}
  jnz   @@Error             {No, Error}
  sar   ebx, 31             {Set Each Bit to Top Bit (Sign Flag)}
  xor   eax, ebx            {Negate Result if Necessary}
  sub   eax, ebx
  pop   esi
  pop   edi
  pop   ebx
  pop   ecx
  ret

@@NumDone:
  cmp   eax, $80000000
  jb    @@CheckDone         {No Overflow}
  jne   @@Error             {Overflow}
  test  ebx, ebx            {Sign Flag Set?}
  js    @@CheckDone         {Yes, Result is Valid (-MaxInt-1)}
@@Error:
  pop   esi
  pop   edi
  pop   ebx
  pop   eax
@@Failed:
  jmp   StrToIntError

@@CheckFirstChar:           {First Char <= '0'}
  cmp   cl, '$'
  je    @@Hex
  cmp   cl, '-'
  je    @@Minus
  cmp   cl, '+'
  je    @@Plus
  cmp   ecx, edi            {Starts with '0'?}
  jne   @@Error             {No, Error}
  movzx ecx, [edx]          {Character after '0'}
  mov   bl, 1               {Valid := True}
  inc   edx
  jmp   @@CheckX
@@Minus:
  mov   ebx, $80000000      {Set Sign Flag (Top Bit), Valid := False}
@@Plus:
  movzx ecx, [edx]          {Character after '+' or '-'}
  inc   edx
  cmp   cl, '$'
  je    @@Hex               {Starts with '+$' or '-$'}
  cmp   ecx, edi            {Starts with '+0' or '-0'?}
  jne   @@CheckAlpha        {No, May start with '+x', '-x', '+X' or '-X'}
  movzx ecx, [edx]          {Character after '+0' or '-0'}
  inc   ebx                 {Starts with '+0' or '-0', Valid := True}
  inc   edx
@@CheckAlpha:
  test  cl, not 'x'         {Could Char be 'x' or 'X'?}
  jnz   @@Numeric           {No, Assume Numeric}
@@CheckX:
  or    cl, $20             {'X' -> 'x'}
  cmp   cl, 'x'             {Char = 'X' or 'x'?}
  movzx ecx, [edx-1]        {Reload Character}
  jne   @@Numeric           {Does Not start with +/-('x', 'X', '0x' or '0X')}
  mov   bl, 0               {Reset Valid to False}
@@Hex:
  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex1              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@TestValid         {Check for Valid and Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex1:
  mov   eax, ecx            {Result = Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex2              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex2:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex3              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex3:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex4              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex4:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex5              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex5:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex6              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex6:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex7              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex7:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex8              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex8:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

@@HexLoop:
  movzx ecx, [edx]
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@CheckRange        {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@CheckRange:
  cmp   eax, MaxInt/8       {High(ULONG) div 16}
  ja    @@Error             {Overflow}
  shl   eax, 4
(*
  shl   eax, 4              //Using this instead of the above 3 lines wrongly
  jc    @@Error             //  passes validation with S='$200000000000000'
*)
  add   eax, ecx            {Result = Result * 16 + Digit}
  inc   edx
  jmp   @@HexLoop
end;

procedure Filler2;
asm
  nop
end;

function StrToInt32_JOH_IA32_7_b(const S: string) : Integer;
asm
  test  eax, eax
  jz    @@Failed
  push  eax
  push  ebx
  push  edi
  push  esi
  mov   edx, eax            {String Pointer}
  xor   ebx, ebx            {Clear Sign Flag (top bit) and Valid Flag}
  xor   eax, eax            {Clear Result}
  mov   edi, '0'
  mov   esi, 9
@@Trim:                     {Strip Leading Spaces}
  movzx ecx, [edx]
  inc   edx
  cmp   cl, ' '
  je    @@Trim
  cmp   ecx, edi            {cl <= '0'?}
  jle   @@CheckFirstChar    {Yes, Check +, -, $, 0x, 0X}
  test  cl, not 'x'
  jz    @@CheckX            {May start with 'x' or 'X'}

@@Numeric:
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@TestValid         {Not '0'..'9'}
  mov   eax, ecx            {Result := Digit}

  movzx ecx, [edx]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+1]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+2]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+3]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+4]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+5]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+6]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+7]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

@@NumLoop:
  movzx ecx, [edx+8]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@NumDone           {Not '0'..'9'}
  cmp   eax, MaxInt/10
  ja    @@Error
  inc   edx
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}
  jmp   @@NumLoop

@@TestValid:
  test  bl, bl              {Got Valid Number?}
  jz    @@Error             {No, Error}
@@CheckDone:            
  add   ecx, edi            {Last Character = Null Terminator?}
  jnz   @@Error             {No, Error}
  sar   ebx, 31             {Set Each Bit to Top Bit (Sign Flag)}
  xor   eax, ebx            {Negate Result if Necessary}
  sub   eax, ebx
  pop   esi
  pop   edi
  pop   ebx
  pop   ecx
  ret

@@NumDone:
  cmp   eax, $80000000
  jb    @@CheckDone         {No Overflow}
  jne   @@Error             {Overflow}
  test  ebx, ebx            {Sign Flag Set?}
  js    @@CheckDone         {Yes, Result is Valid (-MaxInt-1)}
@@Error:
  pop   esi
  pop   edi
  pop   ebx
  pop   eax
@@Failed:
  jmp   StrToIntError

@@CheckFirstChar:           {First Char <= '0'}
  cmp   cl, '$'
  je    @@Hex
  cmp   cl, '-'
  je    @@Minus
  cmp   cl, '+'
  je    @@Plus
  cmp   ecx, edi            {Starts with '0'?}
  jne   @@Error             {No, Error}
  movzx ecx, [edx]          {Character after '0'}
  mov   bl, 1               {Valid := True}
  inc   edx
  jmp   @@CheckX
@@Minus:
  mov   ebx, $80000000      {Set Sign Flag (Top Bit), Valid := False}
@@Plus:
  movzx ecx, [edx]          {Character after '+' or '-'}
  inc   edx
  cmp   cl, '$'
  je    @@Hex               {Starts with '+$' or '-$'}
  cmp   ecx, edi            {Starts with '+0' or '-0'?}
  jne   @@CheckAlpha        {No, May start with '+x', '-x', '+X' or '-X'}
  movzx ecx, [edx]          {Character after '+0' or '-0'}
  inc   ebx                 {Starts with '+0' or '-0', Valid := True}
  inc   edx
@@CheckAlpha:
  test  cl, not 'x'         {Could Char be 'x' or 'X'?}
  jnz   @@Numeric           {No, Assume Numeric}
@@CheckX:
  or    cl, $20             {'X' -> 'x'}
  cmp   cl, 'x'             {Char = 'X' or 'x'?}
  movzx ecx, [edx-1]        {Reload Character}
  jne   @@Numeric           {Does Not start with +/-('x', 'X', '0x' or '0X')}
  mov   bl, 0               {Reset Valid to False}
@@Hex:
  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex1              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@TestValid         {Check for Valid and Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex1:
  mov   eax, ecx            {Result = Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex2              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex2:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex3              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex3:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex4              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex4:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex5              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex5:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex6              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex6:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex7              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex7:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex8              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex8:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

@@HexLoop:
  movzx ecx, [edx]
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@CheckRange        {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@CheckRange:
  cmp   eax, MaxInt/8       {High(ULONG) div 16}
  ja    @@Error             {Overflow}
  shl   eax, 4
(*
  shl   eax, 4              //Using this instead of the above 3 lines wrongly
  jc    @@Error             //  passes validation with S='$200000000000000'
*)
  add   eax, ecx            {Result = Result * 16 + Digit}
  inc   edx
  jmp   @@HexLoop
end;

procedure Filler3;
asm
  nop
end;

function StrToInt32_JOH_IA32_7_c(const S: string) : Integer;
asm
  test  eax, eax
  jz    @@Failed
  push  eax
  push  ebx
  push  edi
  push  esi
  mov   edx, eax            {String Pointer}
  xor   ebx, ebx            {Clear Sign Flag (top bit) and Valid Flag}
  xor   eax, eax            {Clear Result}
  mov   edi, '0'
  mov   esi, 9
@@Trim:                     {Strip Leading Spaces}
  movzx ecx, [edx]
  inc   edx
  cmp   cl, ' '
  je    @@Trim
  cmp   ecx, edi            {cl <= '0'?}
  jle   @@CheckFirstChar    {Yes, Check +, -, $, 0x, 0X}
  test  cl, not 'x'
  jz    @@CheckX            {May start with 'x' or 'X'}

@@Numeric:
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@TestValid         {Not '0'..'9'}
  mov   eax, ecx            {Result := Digit}

  movzx ecx, [edx]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+1]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+2]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+3]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+4]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+5]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+6]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+7]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

@@NumLoop:
  movzx ecx, [edx+8]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@NumDone           {Not '0'..'9'}
  cmp   eax, MaxInt/10
  ja    @@Error
  inc   edx
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}
  jmp   @@NumLoop

@@TestValid:
  test  bl, bl              {Got Valid Number?}
  jz    @@Error             {No, Error}
@@CheckDone:            
  add   ecx, edi            {Last Character = Null Terminator?}
  jnz   @@Error             {No, Error}
  sar   ebx, 31             {Set Each Bit to Top Bit (Sign Flag)}
  xor   eax, ebx            {Negate Result if Necessary}
  sub   eax, ebx
  pop   esi
  pop   edi
  pop   ebx
  pop   ecx
  ret

@@NumDone:
  cmp   eax, $80000000
  jb    @@CheckDone         {No Overflow}
  jne   @@Error             {Overflow}
  test  ebx, ebx            {Sign Flag Set?}
  js    @@CheckDone         {Yes, Result is Valid (-MaxInt-1)}
@@Error:
  pop   esi
  pop   edi
  pop   ebx
  pop   eax
@@Failed:
  jmp   StrToIntError

@@CheckFirstChar:           {First Char <= '0'}
  cmp   cl, '$'
  je    @@Hex
  cmp   cl, '-'
  je    @@Minus
  cmp   cl, '+'
  je    @@Plus
  cmp   ecx, edi            {Starts with '0'?}
  jne   @@Error             {No, Error}
  movzx ecx, [edx]          {Character after '0'}
  mov   bl, 1               {Valid := True}
  inc   edx
  jmp   @@CheckX
@@Minus:
  mov   ebx, $80000000      {Set Sign Flag (Top Bit), Valid := False}
@@Plus:
  movzx ecx, [edx]          {Character after '+' or '-'}
  inc   edx
  cmp   cl, '$'
  je    @@Hex               {Starts with '+$' or '-$'}
  cmp   ecx, edi            {Starts with '+0' or '-0'?}
  jne   @@CheckAlpha        {No, May start with '+x', '-x', '+X' or '-X'}
  movzx ecx, [edx]          {Character after '+0' or '-0'}
  inc   ebx                 {Starts with '+0' or '-0', Valid := True}
  inc   edx
@@CheckAlpha:
  test  cl, not 'x'         {Could Char be 'x' or 'X'?}
  jnz   @@Numeric           {No, Assume Numeric}
@@CheckX:
  or    cl, $20             {'X' -> 'x'}
  cmp   cl, 'x'             {Char = 'X' or 'x'?}
  movzx ecx, [edx-1]        {Reload Character}
  jne   @@Numeric           {Does Not start with +/-('x', 'X', '0x' or '0X')}
  mov   bl, 0               {Reset Valid to False}
@@Hex:
  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex1              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@TestValid         {Check for Valid and Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex1:
  mov   eax, ecx            {Result = Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex2              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex2:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex3              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex3:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex4              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex4:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex5              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex5:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex6              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex6:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex7              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex7:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex8              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex8:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

@@HexLoop:
  movzx ecx, [edx]
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@CheckRange        {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@CheckRange:
  cmp   eax, MaxInt/8       {High(ULONG) div 16}
  ja    @@Error             {Overflow}
  shl   eax, 4
(*
  shl   eax, 4              //Using this instead of the above 3 lines wrongly
  jc    @@Error             //  passes validation with S='$200000000000000'
*)
  add   eax, ecx            {Result = Result * 16 + Digit}
  inc   edx
  jmp   @@HexLoop
end;

procedure Filler4;
asm
  nop
end;

function StrToInt32_JOH_IA32_7_d(const S: string) : Integer;
asm
  test  eax, eax
  jz    @@Failed
  push  eax
  push  ebx
  push  edi
  push  esi
  mov   edx, eax            {String Pointer}
  xor   ebx, ebx            {Clear Sign Flag (top bit) and Valid Flag}
  xor   eax, eax            {Clear Result}
  mov   edi, '0'
  mov   esi, 9
@@Trim:                     {Strip Leading Spaces}
  movzx ecx, [edx]
  inc   edx
  cmp   cl, ' '
  je    @@Trim
  cmp   ecx, edi            {cl <= '0'?}
  jle   @@CheckFirstChar    {Yes, Check +, -, $, 0x, 0X}
  test  cl, not 'x'
  jz    @@CheckX            {May start with 'x' or 'X'}

@@Numeric:
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@TestValid         {Not '0'..'9'}
  mov   eax, ecx            {Result := Digit}

  movzx ecx, [edx]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+1]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+2]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+3]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+4]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+5]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+6]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

  movzx ecx, [edx+7]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@CheckDone         {Not '0'..'9'}
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}

@@NumLoop:
  movzx ecx, [edx+8]
  sub   ecx, edi
  cmp   ecx, esi
  ja    @@NumDone           {Not '0'..'9'}
  cmp   eax, MaxInt/10
  ja    @@Error
  inc   edx
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}
  jmp   @@NumLoop

@@TestValid:
  test  bl, bl              {Got Valid Number?}
  jz    @@Error             {No, Error}
@@CheckDone:            
  add   ecx, edi            {Last Character = Null Terminator?}
  jnz   @@Error             {No, Error}
  sar   ebx, 31             {Set Each Bit to Top Bit (Sign Flag)}
  xor   eax, ebx            {Negate Result if Necessary}
  sub   eax, ebx
  pop   esi
  pop   edi
  pop   ebx
  pop   ecx
  ret

@@NumDone:
  cmp   eax, $80000000
  jb    @@CheckDone         {No Overflow}
  jne   @@Error             {Overflow}
  test  ebx, ebx            {Sign Flag Set?}
  js    @@CheckDone         {Yes, Result is Valid (-MaxInt-1)}
@@Error:
  pop   esi
  pop   edi
  pop   ebx
  pop   eax
@@Failed:
  jmp   StrToIntError

@@CheckFirstChar:           {First Char <= '0'}
  cmp   cl, '$'
  je    @@Hex
  cmp   cl, '-'
  je    @@Minus
  cmp   cl, '+'
  je    @@Plus
  cmp   ecx, edi            {Starts with '0'?}
  jne   @@Error             {No, Error}
  movzx ecx, [edx]          {Character after '0'}
  mov   bl, 1               {Valid := True}
  inc   edx
  jmp   @@CheckX
@@Minus:
  mov   ebx, $80000000      {Set Sign Flag (Top Bit), Valid := False}
@@Plus:
  movzx ecx, [edx]          {Character after '+' or '-'}
  inc   edx
  cmp   cl, '$'
  je    @@Hex               {Starts with '+$' or '-$'}
  cmp   ecx, edi            {Starts with '+0' or '-0'?}
  jne   @@CheckAlpha        {No, May start with '+x', '-x', '+X' or '-X'}
  movzx ecx, [edx]          {Character after '+0' or '-0'}
  inc   ebx                 {Starts with '+0' or '-0', Valid := True}
  inc   edx
@@CheckAlpha:
  test  cl, not 'x'         {Could Char be 'x' or 'X'?}
  jnz   @@Numeric           {No, Assume Numeric}
@@CheckX:
  or    cl, $20             {'X' -> 'x'}
  cmp   cl, 'x'             {Char = 'X' or 'x'?}
  movzx ecx, [edx-1]        {Reload Character}
  jne   @@Numeric           {Does Not start with +/-('x', 'X', '0x' or '0X')}
  mov   bl, 0               {Reset Valid to False}
@@Hex:
  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex1              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@TestValid         {Check for Valid and Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex1:
  mov   eax, ecx            {Result = Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex2              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex2:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex3              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex3:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex4              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex4:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex5              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex5:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex6              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex6:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex7              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex7:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

  movzx ecx, [edx]
  inc   edx
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@Hex8              {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@Hex8:
  shl   eax, 4
  add   eax, ecx            {Result = Result * 16 + Digit}

@@HexLoop:
  movzx ecx, [edx]
  sub   ecx, edi
  cmp   ecx, esi
  jna   @@CheckRange        {'0'..'9'}
  cmp   cl, 'z'-'0'
  ja    @@CheckDone         {Check for Null Terminator}
  or    cl, $20             {'A'..'F' -> 'a'..'f'}
  sub   cl, 'a'-'0'-10      {'A'..'F' or 'a'..'f' -> 10..15}
  cmp   cl, 15
  ja    @@Error             {Not Hex Character}
@@CheckRange:
  cmp   eax, MaxInt/8       {High(ULONG) div 16}
  ja    @@Error             {Overflow}
  shl   eax, 4
(*
  shl   eax, 4              //Using this instead of the above 3 lines wrongly
  jc    @@Error             //  passes validation with S='$200000000000000'
*)
  add   eax, ecx            {Result = Result * 16 + Digit}
  inc   edx
  jmp   @@HexLoop
end;

initialization
  Filler1;
  Filler2;
  Filler3;
  Filler4;

  MainForm.RegisterFunction('StrToInt32_JOH_PAS_6_a', @StrToInt32_JOH_PAS_6_a);
  MainForm.RegisterFunction('StrToInt32_JOH_PAS_6_b', @StrToInt32_JOH_PAS_6_b);
  MainForm.RegisterFunction('StrToInt32_JOH_PAS_6_c', @StrToInt32_JOH_PAS_6_c);
  MainForm.RegisterFunction('StrToInt32_JOH_PAS_6_d', @StrToInt32_JOH_PAS_6_d);

  MainForm.RegisterFunction('StrToInt32_JOH_IA32_6_a', @StrToInt32_JOH_IA32_6_a);
  MainForm.RegisterFunction('StrToInt32_JOH_IA32_6_b', @StrToInt32_JOH_IA32_6_b);
  MainForm.RegisterFunction('StrToInt32_JOH_IA32_6_c', @StrToInt32_JOH_IA32_6_c);
  MainForm.RegisterFunction('StrToInt32_JOH_IA32_6_d', @StrToInt32_JOH_IA32_6_d);

  MainForm.RegisterFunction('StrToInt32_JOH_PAS_7_a', @StrToInt32_JOH_PAS_7_a);
  MainForm.RegisterFunction('StrToInt32_JOH_PAS_7_b', @StrToInt32_JOH_PAS_7_b);
  MainForm.RegisterFunction('StrToInt32_JOH_PAS_7_c', @StrToInt32_JOH_PAS_7_c);
  MainForm.RegisterFunction('StrToInt32_JOH_PAS_7_d', @StrToInt32_JOH_PAS_7_d);

  MainForm.RegisterFunction('StrToInt32_JOH_IA32_7_a', @StrToInt32_JOH_IA32_7_a);
  MainForm.RegisterFunction('StrToInt32_JOH_IA32_7_b', @StrToInt32_JOH_IA32_7_b);
  MainForm.RegisterFunction('StrToInt32_JOH_IA32_7_c', @StrToInt32_JOH_IA32_7_c);
  MainForm.RegisterFunction('StrToInt32_JOH_IA32_7_d', @StrToInt32_JOH_IA32_7_d);

end.

