unit StrToInt32JOHUnit;

{$R-,Q-}
{$WARNINGS OFF}

{$IFDEF Ver80}{$DEFINE Delphi1}{$ENDIF}
{$IFDEF Ver90}{$DEFINE Delphi2}{$ENDIF}
{$IFDEF Ver100}{$DEFINE Delphi3}{$ENDIF}
{$IFDEF Ver120}{$DEFINE Delphi4}{$ENDIF}
{$IFDEF Ver130}{$DEFINE Delphi5}{$ENDIF}
{$IFDEF Ver140}{$DEFINE Delphi6}{$ENDIF}
{$IFDEF Ver150}{$DEFINE Delphi7}{$ENDIF}
{$IFDEF Ver160}{$DEFINE Delphi8}{$ENDIF}
{$IFDEF Ver170}{$DEFINE Delphi2005}{$ENDIF}
{$IFDEF CONDITIONALEXPRESSIONS}
  {$IF (CompilerVersion >= 18.0) and (CompilerVersion < 19.0)}
     {$DEFINE Delphi2006}
  {$IFEND}
  {$IF (CompilerVersion >= 19.0) and (CompilerVersion < 20.0)}
     {$DEFINE Delphi2007}
  {$IFEND}
{$ENDIF}

{$IFDEF Delphi2007}{$DEFINE Delphi2007Plus}{$ENDIF}
{$IFDEF Delphi2007Plus}{$DEFINE Delphi2006Plus}{$ENDIF}
{$IFDEF Delphi2006}{$DEFINE Delphi2006Plus}{$ENDIF}
{$IFDEF Delphi2006Plus}{$DEFINE Delphi2005Plus}{$ENDIF}
{$IFDEF Delphi2005}{$DEFINE Delphi2005Plus}{$ENDIF}
{$IFDEF Delphi2005Plus}{$DEFINE Delphi7Plus}{$ENDIF}
{$IFDEF Delphi7}{$DEFINE Delphi7Plus}{$ENDIF}
{$IFDEF Delphi7Plus}{$DEFINE Delphi6Plus}{$ENDIF}
{$IFDEF Delphi6}{$DEFINE Delphi6Plus}{$ENDIF}
{$IFDEF Delphi6Plus}{$DEFINE Delphi5Plus}{$ENDIF}
{$IFDEF Delphi5}{$DEFINE Delphi5Plus}{$ENDIF}
{$IFDEF Delphi5Plus}{$DEFINE Delphi4Plus}{$ENDIF}
{$IFDEF Delphi4}{$DEFINE Delphi4Plus}{$ENDIF}
{$IFDEF Delphi4Plus}{$DEFINE Delphi3Plus}{$ENDIF}
{$IFDEF Delphi3}{$DEFINE Delphi3Plus}{$ENDIF}
{$IFDEF Delphi3Plus}{$DEFINE Delphi2Plus}{$ENDIF}
{$IFDEF Delphi2}{$DEFINE Delphi2Plus}{$ENDIF}
{$IFDEF Delphi2Plus}{$DEFINE Delphi1Plus}{$ENDIF}
{$IFDEF Delphi1}{$DEFINE Delphi1Plus}{$ENDIF}

interface

uses
  MainUnit, SysUtils, Math, SysConst;

implementation

{$IFDEF Delphi2005Plus}
//Needed until RTL Upcase is converted into an Inline Function
function UpCase(ch: Char): Char; inline;
begin
  Result := Ch;
  if Result in ['a'..'z'] then
    Dec(Result, Ord('a')-Ord('A'));
end;
{$ENDIF}

//Fastest Pascal _ValLong function from Val Challenge

function ValLong_JOH_PAS_4_a(const s; var code: Integer): Longint;
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
      inc(P);
      Hex := True;
    end
  else
    begin
      if P^ = '0' then
        begin
          inc(P);
          Valid := True;
        end;
      if Upcase(P^) = 'X' then
        begin
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
            'a'..'f': Digit := Ord(P^) - Ord('a') + 10;
            'A'..'F': Digit := Ord(P^) - Ord('A') + 10;
            else      Break;
          end;
          if (Result < 0) or (Result > $0FFFFFFF) then
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
            break;
          if Result > (MaxInt div 10) then
            break;
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

function ValLong_JOH_PAS_4_b(const s; var code: Integer): Longint;
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
      inc(P);
      Hex := True;
    end
  else
    begin
      if P^ = '0' then
        begin
          inc(P);
          Valid := True;
        end;
      if Upcase(P^) = 'X' then
        begin
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
            'a'..'f': Digit := Ord(P^) - Ord('a') + 10;
            'A'..'F': Digit := Ord(P^) - Ord('A') + 10;
            else      Break;
          end;
          if (Result < 0) or (Result > $0FFFFFFF) then
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
            break;
          if Result > (MaxInt div 10) then
            break;
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

function ValLong_JOH_PAS_4_c(const s; var code: Integer): Longint;
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
      inc(P);
      Hex := True;
    end
  else
    begin
      if P^ = '0' then
        begin
          inc(P);
          Valid := True;
        end;
      if Upcase(P^) = 'X' then
        begin
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
            'a'..'f': Digit := Ord(P^) - Ord('a') + 10;
            'A'..'F': Digit := Ord(P^) - Ord('A') + 10;
            else      Break;
          end;
          if (Result < 0) or (Result > $0FFFFFFF) then
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
            break;
          if Result > (MaxInt div 10) then
            break;
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

function ValLong_JOH_PAS_4_d(const s; var code: Integer): Longint;
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
      inc(P);
      Hex := True;
    end
  else
    begin
      if P^ = '0' then
        begin
          inc(P);
          Valid := True;
        end;
      if Upcase(P^) = 'X' then
        begin
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
            'a'..'f': Digit := Ord(P^) - Ord('a') + 10;
            'A'..'F': Digit := Ord(P^) - Ord('A') + 10;
            else      Break;
          end;
          if (Result < 0) or (Result > $0FFFFFFF) then
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
            break;
          if Result > (MaxInt div 10) then
            break;
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

function ValLong_JOH_IA32_4_a(const s; var code: Integer): Longint;
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
  test  cl, $87
  jz    @@CheckX            {May be 'x' or 'X'}
@@NumLoop:
  sub   ecx, '0'
  cmp   ecx, 9
  ja    @@NumDone           {Not '0'..'9'}
  cmp   eax, MaxInt/10
  ja    @@NumDone
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
  js    @@Setsign           {Result is Valid (-MaxInt-1)}
@@Overflow:
  dec   esi
  mov   bl, 0               {Valid := False}
  jmp   @@SetSign
@@CheckFirstChar:
  cmp   cl, '-'
  je    @@PlusMinus
  cmp   cl, '+'
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
  jna   @@CheckRange        {'0'..'9'}
  mov   bh, cl              {Check for Valid Hex Character}
  sub   bh, 'a'-'0'         {'a' -> 0}
  cmp   bh, 'z'-'a'+1       {Carry if 'a'..'z'}
  sbb   bh, bh              {=$FF if 'a'..'z' else $00}
  and   bh, $20             {=$20 if 'a'..'z' else $00}
  sub   cl, bh              {'a'..'z' -> 'A'..'Z'}
  sub   cl, 'A'-'0'-10      {'A'..'Z' -> 10..15}
  cmp   cl, 15
  ja    @@NotHex            {Not Hex Character}
@@CheckRange:
  cmp   eax, MaxInt/8       {High(ULONG) div 16}
  ja    @@SetSign
  shl   eax, 4              {Result = Result * 16}
  mov   bl, 1               {Valid := True}
  add   eax, ecx
  jmp   @@HexLoop
@@NotHex:
  add   cl, 'A'-'0'-10      {Restore Char-'0'}
@@SetSign:
  mov   ch, bl              {Save Valid Flag}
  sar   ebx, 31             {Set Each Bit to Top Bit}
  xor   eax, ebx            {Negate Result if Necessary}
  sub   eax, ebx
  dec   ch                  {0 if Valid, -1 if Invalid}
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

function ValLong_JOH_IA32_4_b(const s; var code: Integer): Longint;
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
  test  cl, $87
  jz    @@CheckX            {May be 'x' or 'X'}
@@NumLoop:
  sub   ecx, '0'
  cmp   ecx, 9
  ja    @@NumDone           {Not '0'..'9'}
  cmp   eax, MaxInt/10
  ja    @@NumDone
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
  js    @@Setsign           {Result is Valid (-MaxInt-1)}
@@Overflow:
  dec   esi
  mov   bl, 0               {Valid := False}
  jmp   @@SetSign
@@CheckFirstChar:
  cmp   cl, '-'
  je    @@PlusMinus
  cmp   cl, '+'
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
  jna   @@CheckRange        {'0'..'9'}
  mov   bh, cl              {Check for Valid Hex Character}
  sub   bh, 'a'-'0'         {'a' -> 0}
  cmp   bh, 'z'-'a'+1       {Carry if 'a'..'z'}
  sbb   bh, bh              {=$FF if 'a'..'z' else $00}
  and   bh, $20             {=$20 if 'a'..'z' else $00}
  sub   cl, bh              {'a'..'z' -> 'A'..'Z'}
  sub   cl, 'A'-'0'-10      {'A'..'Z' -> 10..15}
  cmp   cl, 15
  ja    @@NotHex            {Not Hex Character}
@@CheckRange:
  cmp   eax, MaxInt/8       {High(ULONG) div 16}
  ja    @@SetSign
  shl   eax, 4              {Result = Result * 16}
  mov   bl, 1               {Valid := True}
  add   eax, ecx
  jmp   @@HexLoop
@@NotHex:
  add   cl, 'A'-'0'-10      {Restore Char-'0'}
@@SetSign:
  mov   ch, bl              {Save Valid Flag}
  sar   ebx, 31             {Set Each Bit to Top Bit}
  xor   eax, ebx            {Negate Result if Necessary}
  sub   eax, ebx
  dec   ch                  {0 if Valid, -1 if Invalid}
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

function ValLong_JOH_IA32_4_c(const s; var code: Integer): Longint;
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
  test  cl, $87
  jz    @@CheckX            {May be 'x' or 'X'}
@@NumLoop:
  sub   ecx, '0'
  cmp   ecx, 9
  ja    @@NumDone           {Not '0'..'9'}
  cmp   eax, MaxInt/10
  ja    @@NumDone
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
  js    @@Setsign           {Result is Valid (-MaxInt-1)}
@@Overflow:
  dec   esi
  mov   bl, 0               {Valid := False}
  jmp   @@SetSign
@@CheckFirstChar:
  cmp   cl, '-'
  je    @@PlusMinus
  cmp   cl, '+'
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
  jna   @@CheckRange        {'0'..'9'}
  mov   bh, cl              {Check for Valid Hex Character}
  sub   bh, 'a'-'0'         {'a' -> 0}
  cmp   bh, 'z'-'a'+1       {Carry if 'a'..'z'}
  sbb   bh, bh              {=$FF if 'a'..'z' else $00}
  and   bh, $20             {=$20 if 'a'..'z' else $00}
  sub   cl, bh              {'a'..'z' -> 'A'..'Z'}
  sub   cl, 'A'-'0'-10      {'A'..'Z' -> 10..15}
  cmp   cl, 15
  ja    @@NotHex            {Not Hex Character}
@@CheckRange:
  cmp   eax, MaxInt/8       {High(ULONG) div 16}
  ja    @@SetSign
  shl   eax, 4              {Result = Result * 16}
  mov   bl, 1               {Valid := True}
  add   eax, ecx
  jmp   @@HexLoop
@@NotHex:
  add   cl, 'A'-'0'-10      {Restore Char-'0'}
@@SetSign:
  mov   ch, bl              {Save Valid Flag}
  sar   ebx, 31             {Set Each Bit to Top Bit}
  xor   eax, ebx            {Negate Result if Necessary}
  sub   eax, ebx
  dec   ch                  {0 if Valid, -1 if Invalid}
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

function ValLong_JOH_IA32_4_d(const s; var code: Integer): Longint;
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
  test  cl, $87
  jz    @@CheckX            {May be 'x' or 'X'}
@@NumLoop:
  sub   ecx, '0'
  cmp   ecx, 9
  ja    @@NumDone           {Not '0'..'9'}
  cmp   eax, MaxInt/10
  ja    @@NumDone
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
  js    @@Setsign           {Result is Valid (-MaxInt-1)}
@@Overflow:
  dec   esi
  mov   bl, 0               {Valid := False}
  jmp   @@SetSign
@@CheckFirstChar:
  cmp   cl, '-'
  je    @@PlusMinus
  cmp   cl, '+'
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
  jna   @@CheckRange        {'0'..'9'}
  mov   bh, cl              {Check for Valid Hex Character}
  sub   bh, 'a'-'0'         {'a' -> 0}
  cmp   bh, 'z'-'a'+1       {Carry if 'a'..'z'}
  sbb   bh, bh              {=$FF if 'a'..'z' else $00}
  and   bh, $20             {=$20 if 'a'..'z' else $00}
  sub   cl, bh              {'a'..'z' -> 'A'..'Z'}
  sub   cl, 'A'-'0'-10      {'A'..'Z' -> 10..15}
  cmp   cl, 15
  ja    @@NotHex            {Not Hex Character}
@@CheckRange:
  cmp   eax, MaxInt/8       {High(ULONG) div 16}
  ja    @@SetSign
  shl   eax, 4              {Result = Result * 16}
  mov   bl, 1               {Valid := True}
  add   eax, ecx
  jmp   @@HexLoop
@@NotHex:
  add   cl, 'A'-'0'-10      {Restore Char-'0'}
@@SetSign:
  mov   ch, bl              {Save Valid Flag}
  sar   ebx, 31             {Set Each Bit to Top Bit}
  xor   eax, ebx            {Negate Result if Necessary}
  sub   eax, ebx
  dec   ch                  {0 if Valid, -1 if Invalid}
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

function StrToInt32_JOH_PAS_4_a(const S: string) : Integer;
var
  E: Integer;
begin
//  Val(S, Result, E); {when system._ValLong updated}
  Result := ValLong_JOH_PAS_4_a(Pointer(S)^, E);
  if E <> 0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
end;

function StrToInt32_JOH_PAS_4_b(const S: string) : Integer;
var
  E: Integer;
begin
//  Val(S, Result, E); {when system._ValLong updated}
  Result := ValLong_JOH_PAS_4_b(Pointer(S)^, E);
  if E <> 0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
end;

function StrToInt32_JOH_PAS_4_c(const S: string) : Integer;
var
  E: Integer;
begin
//  Val(S, Result, E); {when system._ValLong updated}
  Result := ValLong_JOH_PAS_4_c(Pointer(S)^, E);
  if E <> 0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
end;

function StrToInt32_JOH_PAS_4_d(const S: string) : Integer;
var
  E: Integer;
begin
//  Val(S, Result, E); {when system._ValLong updated}
  Result := ValLong_JOH_PAS_4_d(Pointer(S)^, E);
  if E <> 0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
end;

function StrToInt32_JOH_IA32_4_a(const S: string) : Integer;
var
  E: Integer;
begin
//  Val(S, Result, E); {when system._ValLong updated}
  Result := ValLong_JOH_IA32_4_a(Pointer(S)^, E);
  if E <> 0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
end;

function StrToInt32_JOH_IA32_4_b(const S: string) : Integer;
var
  E: Integer;
begin
//  Val(S, Result, E); {when system._ValLong updated}
  Result := ValLong_JOH_IA32_4_b(Pointer(S)^, E);
  if E <> 0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
end;

function StrToInt32_JOH_IA32_4_c(const S: string) : Integer;
var
  E: Integer;
begin
//  Val(S, Result, E); {when system._ValLong updated}
  Result := ValLong_JOH_IA32_4_c(Pointer(S)^, E);
  if E <> 0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
end;

function StrToInt32_JOH_IA32_4_d(const S: string) : Integer;
var
  E: Integer;
begin
//  Val(S, Result, E); {when system._ValLong updated}
  Result := ValLong_JOH_IA32_4_d(Pointer(S)^, E);
  if E <> 0 then
    raise EConvertError.CreateResFmt(@SInvalidInteger, [S]);
end;

initialization
  MainForm.RegisterFunction('StrToInt32_JOH_PAS_4_a', @StrToInt32_JOH_PAS_4_a);
  MainForm.RegisterFunction('StrToInt32_JOH_PAS_4_b', @StrToInt32_JOH_PAS_4_b);
  MainForm.RegisterFunction('StrToInt32_JOH_PAS_4_c', @StrToInt32_JOH_PAS_4_c);
  MainForm.RegisterFunction('StrToInt32_JOH_PAS_4_d', @StrToInt32_JOH_PAS_4_d);
  MainForm.RegisterFunction('StrToInt32_JOH_IA32_4_a', @StrToInt32_JOH_IA32_4_a);
  MainForm.RegisterFunction('StrToInt32_JOH_IA32_4_b', @StrToInt32_JOH_IA32_4_b);
  MainForm.RegisterFunction('StrToInt32_JOH_IA32_4_c', @StrToInt32_JOH_IA32_4_c);
  MainForm.RegisterFunction('StrToInt32_JOH_IA32_4_d', @StrToInt32_JOH_IA32_4_d);
end.

