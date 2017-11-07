unit ValJOHUnit;

{$R-,Q-}

{$INCLUDE Version.inc}

{$IFDEF Delphi2005Plus}
  {$WARN UNSAFE_CODE OFF}
{$ENDIF}

{.$DEFINE TestPIC} {Enable to test Position Independent Code (PIC)}
                   {PIC is only used in the IA32 Extended Val function(s)}

interface

implementation

uses
  SysUtils, Math,
  FastcodeChallengeValLongUnit,
  FastcodeChallengeValInt64Unit,
  FastcodeChallengeValExtUnit,
  FastcodeChallengeUnit;

{$IFDEF TestPIC}
  {$DEFINE PIC}
{$ENDIF}

{$IFDEF TestPIC}
function GetGOT: LongWord;
begin
  Result := 0;
end;
{$ENDIF}

{$WARNINGS OFF} {Prevent False Compiler Warning on Digit not being Initialized}
function ValLong_JOH_PAS_8_a(const s: AnsiString; var code: Integer): Longint;
const
  AdjustLowercase = Ord('a') - 10;
  AdjustUppercase = Ord('A') - 10;
var
  Digit: Integer;
  Neg, Hex, Valid: Boolean;
  P: PChar;
begin
  Code := 0;
  if s = '' then
    begin
      Result := 0;
      inc(Code);
      Exit;
    end;
  P := Pointer(S);
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
        begin {P^ in ['X','x']}
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
            break;
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
    Code := P-Pointer(S)+1;
end;
{$WARNINGS ON}

function ValLong_JOH_IA32_8_a(const s: AnsiString; var code: Integer): Longint;
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
  cmp   cl, 'a'
  jb    @@CheckNum
  sub   cl, 'a'-'A'         {'a' > 'A'}
@@CheckNum:
  sub   cl, '0'
  cmp   cl, 9
  jna   @@CheckHexRange     {'0'..'9'}
  sub   cl, 'A'-'0'
  cmp   cl, 5               {Valid Hex Character?}
  ja    @@NotHex            {No, Invalid}
  add   cl, 10              {Yes, Adjust Digit}
@@CheckHexRange:
  cmp   eax, MaxInt/8       {High(ULONG) div 16}
  ja    @@SetSign           {Overflow}
  shl   eax, 4              {Result = Result * 16}
  mov   bl, 1               {Valid := True}
  add   eax, ecx
  jmp   @@HexLoop
@@NotHex:
  add   cl, 'A'-'0'         {Restore Char-'0'}
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

{$WARNINGS OFF} {Prevent False Compiler Warning on Digit not being Initialized}
function ValInt64_JOH_PAS_8_a(const s: AnsiString; var code: Integer): Int64;
const
  AdjustLowercase = Ord('a') - 10;
  AdjustUppercase = Ord('A') - 10;
var
  I, Digit: Integer;
  Ch: Char;
  Flags: Byte; {Bit 0 = Valid, Bit 1 = Negative, Bit 2 = Hex}
begin
  Result := 0;
  Code   := 0;
  if S = '' then
    begin
      inc(Code);
      Exit;
    end;
  Flags := 0;
  while S[Code+1] = ' ' do
    Inc(Code);
  Ch := S[Code+1];
  if Ch in ['+', '-'] then
    begin
      Flags := Flags or (Ord(Ch) - Ord('+')); {Set/Reset Neg}
      inc(code);
      Ch := S[Code+1];
    end;
  if Ch = '$' then
    begin
      inc(Code);
      Flags := Flags or 4; {Hex := True}
    end
  else
    begin
      if Ch = '0' then
        begin
          Flags := Flags or 1; {Valid := True}
          inc(Code);
        end;
      if (Ord(S[Code+1]) or $20) = ord('x') then
        begin {S[Code+1] in ['X','x']}
          Flags := Flags or 4; {Hex := True}
          inc(Code);
        end;
    end;
  if (Flags and 4) <> 0 then
    begin {Hex = True}
      Flags := Flags and (not 1); {Valid := False}
      while true do
        begin
          Ch := S[Code+1];
          inc(Code);
          case Ch of
            '0'..'9': Digit := Ord(Ch) - Ord('0');
            'a'..'f': Digit := Ord(Ch) - AdjustLowercase;
            'A'..'F': Digit := Ord(Ch) - AdjustUppercase;
            else      Break;
          end;
          if UInt64(Result) > (High(Int64) shr 3) then
            Break;
          if UInt64(Result) < (MaxInt div 16)-15 then
            begin {Use Integer Math instead of Int64}
              I := Result;
              I := (I shl 4) + Digit;
              Result := I;
            end
          else
            Result := (Result shl 4) + Digit;
          Flags := Flags or 1; {Valid := True}
        end;
    end
  else
    begin
      while true do
        begin
          Ch := S[Code+1];
          inc(Code);
          if not (Ch in ['0'..'9']) then
            break;
          if UInt64(Result) > (High(Int64) div 10) then
            break;
          if UInt64(Result) < (MaxInt div 10)-9 then
            begin {Use Integer Math instead of Int64}
              I := Result;
              I := (I * 10) + Ord(Ch) - Ord('0');
              Result := I;
            end
          else {Result := (Result * 10) + Ord(Ch) - Ord('0');}
            Result := (Result shl 1) + (Result shl 3) + Ord(Ch) - Ord('0');
          Flags := Flags or 1; {Valid := True}
        end;
      if UInt64(Result) >= $8000000000000000 then {Possible Overflow}
        if ((Flags and 2) = 0) or (Result <> $8000000000000000) then
          begin {Overflow}
            if ((Flags and 2) <> 0) then {Neg=True}
              Result := -Result;
            Dec(Code);
            Exit;
          end;
    end;
  if ((Flags and 2) <> 0) then {Neg=True}
    Result := -Result;
  if ((Flags and 1) <> 0) and (Ch = #0) then
    Code := 0; {Valid=True and End Reached}
end;
{$WARNINGS ON}

function ValInt64_JOH_IA32_8_a(const s: AnsiString; var code: Integer): Int64;
asm
  test  eax, eax
  jz    @@Null
  push  ebx
  push  esi
  push  edi
  push  edx                 {Save Code Address}
  push  eax                 {Save String Pointer}
  mov   esi, eax            {String Pointer}
  xor   ebx, ebx            {Clear Valid Flag and Sign Flag}
  xor   eax, eax            {Clear Result}
  xor   edx, edx
  jmp   @@TrimEntry
@@Null:
  mov   [edx], eax
  inc   [edx]               {Code = 1}
  xor   edx, edx            {Result = 0}
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
  cmp   edx, $0ccccccc
  jae   @@CheckNumRange     {May be Out of Range}
@@InRange:
  test  edx, edx
  jnz   @@LargeNum
  cmp   eax, MaxInt/10-9    {MaxInt div 10)-9}
  ja    @@LargeNum
  lea   eax, [eax*4+eax]
  lea   eax, [eax*2+ecx]    {Result = Result * 10 + Digit}
  jmp   @@DoneNumMul
@@LargeNum:
  mov   bh, cl              {Save Digit}
  add   eax, eax
  adc   edx, edx
  mov   ecx, eax
  mov   edi, edx            {edi:ecx = Result * 2}
  shld  edx, eax, 2
  add   eax, eax
  add   eax, eax            {edx:eax = Result * 8}
  add   eax, ecx
  adc   edx, edi            {Result = Result * 10}
  movzx ecx, bh             {Restore Digit}
  add   eax, ecx            {Add Digit to Result}
  adc   edx, 0
@@DoneNumMul:
  inc   esi
  mov   bl, 1               {Valid := True}
  movzx ecx, [esi]
  jmp   @@NumLoop
@@CheckNumRange:
  ja    @@SetSign           {Out of Range}
  cmp   eax, $cccccccc
  jna   @@InRange           {Within Range}
  jmp   @@SetSign
@@NumDone:
  cmp   edx, $80000000      {Check for Overflow}
  jb    @@SetSign
  jne   @@Overflow
  test  eax, eax
  jnz   @@Overflow
  test  ebx, ebx            {Sign Flag}
  js    @@Setsign           {Result is Valid (-MaxInt64-1)}
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
  cmp   cl, 'a'
  jb    @@CheckNum
  sub   cl, 'a'-'A'         {'a' > 'A'}
@@CheckNum:
  sub   cl, '0'
  cmp   cl, 9
  jna   @@CheckHexRange     {'0'..'9'}
  sub   cl, 'A'-'0'
  cmp   cl, 5               {Valid Hex Character?}
  ja    @@NotHex            {No, Invalid}
  add   cl, 10              {Yes, Adjust Digit}
@@CheckHexRange:
  cmp   edx, $10000000
  jae   @@SetSign           {Overflow}
  shld  edx, eax, 4         {Result := Result * 16}
  shl   eax, 4
  add   eax, ecx            {Add Digit}
  adc   edx, 0
  mov   bl, 1               {Valid := True}
  jmp   @@HexLoop
@@NotHex:
  add   cl, 'A'-'0'         {Restore Char-'0'}
@@SetSign:
  mov   ch, bl              {Save Valid Flag}
  sar   ebx, 31             {Set Each Bit to Top Bit (Sign Flag)}
  xor   eax, ebx            {Negate Result if Necessary}
  xor   edx, ebx
  sub   eax, ebx
  sbb   edx, ebx
  dec   ch                  {0 if Valid, -1 if Invalid}
  or    cl, ch              {If Invalid, Force CL = -1}
  cmp   cl, -'0'
  jne   @@Error             {Not Valid or Not End of String}
  xor   esi, esi            {Code := 0}
  pop   ebx                 {Dump String Pointer}
@@Finished:
  pop   ecx
  mov   [ecx], esi          {Set Error Code}
  pop   edi
  pop   esi
  pop   ebx
  ret
@@Error:
  inc   esi
  pop   ecx                 {String Pointer}
  sub   esi, ecx
  jmp   @@Finished
end;

function ValExt_JOH_PAS_8_a(const s: AnsiString; var code: Integer): Extended;
var
  Digits, ExpValue: Integer;
  Ch: Char;
  Neg, NegExp, Valid: Boolean;
begin
  Result := 0.0;
  Code   := 0;
  if s = '' then
    begin
      inc(Code);
      Exit;
    end;
  Neg    := False;
  NegExp := False;
  Valid  := False;
  while S[code+1] = ' ' do
    Inc(Code);
  Ch := S[code+1];
  if Ch in ['+', '-'] then
    begin
      inc(Code);
      Neg := (Ch = '-');
    end;
  while true do
    begin
      Ch := S[code+1];
      inc(Code);
      if not (Ch in ['0'..'9']) then
        break;
      Result := (Result * 10) + Ord(Ch) - Ord('0');
      Valid := True;
    end;
  Digits := 0;
  if Ch = '.' then
    begin
      while true do
        begin
          Ch := S[code+1];
          inc(Code);
          if not (Ch in ['0'..'9']) then
            begin
              if not valid then {Starts with '.'}
                begin
                  if Ch = #0 then
                    dec(code); {s = '.'}
                end;
              break;
            end;
          Result := (Result * 10) + Ord(Ch) - Ord('0');
          Dec(Digits);
          Valid := true;
        end;
    end;
  ExpValue := 0;
  if (Ord(Ch) or $20) = ord('e') then
    begin {Ch in ['E','e']}
      Valid := false;
      Ch := S[code+1];
      if Ch in ['+', '-'] then
        begin
          inc(Code);
          NegExp := (Ch = '-');
          Ch := S[code+1];
        end;
      while true do
        begin
          Ch := S[code+1];
          inc(Code);
          if not (Ch in ['0'..'9']) then
            break;
          ExpValue := (ExpValue * 10) + Ord(Ch) - Ord('0');
          Valid := true;
        end;
     if NegExp then
       ExpValue := -ExpValue;
    end;
  Digits := Digits + ExpValue;
  if Digits <> 0 then
    Result := Result * IntPower(10, Digits);
  if Neg then
    Result := -Result;
  if Valid and (ch = #0) then
    code := 0;
end;

const
  Ten: Double = 10.0;

//function _Pow10(val: Extended; Power: Integer): Extended;
// -> FST(0)  val
// -> EAX Power
// <- FST(0)  val * 10**Power
procedure _Pow10;
asm
{$IFDEF PIC}
  push  eax
  call  GetGOT
  mov   ecx, eax
  pop   eax
{$ENDIF}
  test  eax, eax
  jle   @@CheckNeg
  cmp   eax, 5120
  jge   @@Infinity                     {Power Too High, Return Infinity}
  mov   edx, eax
  and   edx, $1F                       {Lower 5 Bits}
  lea   edx, [edx+edx*4]
{$IFDEF PIC}
  fld   tbyte ptr @@Tab0[ecx+edx*2]
{$ELSE}
  fld   tbyte ptr @@Tab0[edx*2]
{$ENDIF}
  fmulp
  shr   eax, 5                         {Shift Out Lower 5 Bits}
  jz    @@PosDone                      {Finished if 0}
  mov   edx, eax
  and   edx, $0F                       {Next Lower 4 Bits}
  jz    @@ThirdMul
  lea   edx, [edx+edx*4]
{$IFDEF PIC}
  fld   tbyte ptr @@Tab1[ecx+edx*2-10]
{$ELSE}
  fld   tbyte ptr @@Tab1[edx*2-10]
{$ENDIF}
  fmulp
@@ThirdMul:
  shr   eax, 4                         {Shift Out Next Lower 4 Bits}
  jz    @@PosDone                      {Finished if 0}
  lea   eax, [eax+eax*4]
{$IFDEF PIC}
  fld   tbyte ptr @@Tab2[ecx+eax*2-10]
{$ELSE}
  fld   tbyte ptr @@Tab2[eax*2-10]
{$ENDIF}
  fmulp
@@PosDone:
  ret
@@Infinity:
  fstp  st(0)                          {Replace Result with Infinity}
{$IFDEF PIC}
  fld   tbyte ptr @@Inf[ecx]
{$ELSE}
  fld   tbyte ptr @@Inf
{$ENDIF}
  ret
@@CheckNeg:
  je    @@NegDone                      {Finished if Power = 0}
  neg   eax
  cmp   eax, 5120
  jge   @@Zero                         {Power Too Low, Return Zero}
  mov   edx, eax
  and   edx, $1F                       {Lower 5 Bits}
  lea   edx, [edx+edx*4]
{$IFDEF PIC}
  fld   tbyte ptr @@Tab0[ecx+edx*2]
{$ELSE}
  fld   tbyte ptr @@Tab0[edx*2]
{$ENDIF}
  fdivp
  shr   eax, 5                         {Shift Out Lower 5 Bits}
  jz    @@NegDone                      {Finished if 0}
  mov   edx, eax
  and   edx, $0F                       {Next Lower 4 Bits}
  jz    @@ThirdDiv
  lea   edx, [edx+edx*4]
{$IFDEF PIC}
  fld   tbyte ptr @@Tab1[ecx+edx*2-10]
{$ELSE}
  fld   tbyte ptr @@Tab1[edx*2-10]
{$ENDIF}
  fdivp
@@ThirdDiv:
  shr   eax, 4                         {Shift Out Next Lower 4 Bits}
  jz    @@NegDone                      {Finished if 0}
  lea   eax, [eax+eax*4]
{$IFDEF PIC}
  fld   tbyte ptr @@Tab2[ecx+eax*2-10]
{$ELSE}
  fld   tbyte ptr @@Tab2[eax*2-10]
{$ENDIF}
  fdivp
@@NegDone:
  ret
@@Zero:
  fstp  st(0)                          {Replace Result with Zero}
  fldz
  ret
@@Inf:
  dw    $0000,$0000,$0000,$8000,$7FFF  {Infinity}
@@Tab0:
  dw    $0000,$0000,$0000,$8000,$3FFF  {10**0}
  dw    $0000,$0000,$0000,$A000,$4002  {10**1}
  dw    $0000,$0000,$0000,$C800,$4005  {10**2}
  dw    $0000,$0000,$0000,$FA00,$4008  {10**3}
  dw    $0000,$0000,$0000,$9C40,$400C  {10**4}
  dw    $0000,$0000,$0000,$C350,$400F  {10**5}
  dw    $0000,$0000,$0000,$F424,$4012  {10**6}
  dw    $0000,$0000,$8000,$9896,$4016  {10**7}
  dw    $0000,$0000,$2000,$BEBC,$4019  {10**8}
  dw    $0000,$0000,$2800,$EE6B,$401C  {10**9}
  dw    $0000,$0000,$F900,$9502,$4020  {10**10}
  dw    $0000,$0000,$B740,$BA43,$4023  {10**11}
  dw    $0000,$0000,$A510,$E8D4,$4026  {10**12}
  dw    $0000,$0000,$E72A,$9184,$402A  {10**13}
  dw    $0000,$8000,$20F4,$B5E6,$402D  {10**14}
  dw    $0000,$A000,$A931,$E35F,$4030  {10**15}
  dw    $0000,$0400,$C9BF,$8E1B,$4034  {10**16}
  dw    $0000,$C500,$BC2E,$B1A2,$4037  {10**17}
  dw    $0000,$7640,$6B3A,$DE0B,$403A  {10**18}
  dw    $0000,$89E8,$2304,$8AC7,$403E  {10**19}
  dw    $0000,$AC62,$EBC5,$AD78,$4041  {10**20}
  dw    $8000,$177A,$26B7,$D8D7,$4044  {10**21}
  dw    $9000,$6EAC,$7832,$8786,$4048  {10**22}
  dw    $B400,$0A57,$163F,$A968,$404B  {10**23}
  dw    $A100,$CCED,$1BCE,$D3C2,$404E  {10**24}
  dw    $84A0,$4014,$5161,$8459,$4052  {10**25}
  dw    $A5C8,$9019,$A5B9,$A56F,$4055  {10**26}
  dw    $0F3A,$F420,$8F27,$CECB,$4058  {10**27}
  dw    $0984,$F894,$3978,$813F,$405C  {10**28}
  dw    $0BE5,$36B9,$07D7,$A18F,$405F  {10**29}
  dw    $4EDF,$0467,$C9CD,$C9F2,$4062  {10**30}
  dw    $2296,$4581,$7C40,$FC6F,$4065  {10**31}
@@Tab1:
  dw    $B59E,$2B70,$ADA8,$9DC5,$4069  {10**32}
  dw    $A6D5,$FFCF,$1F49,$C278,$40D3  {10**64}
  dw    $14A3,$C59B,$AB16,$EFB3,$413D  {10**96}
  dw    $8CE0,$80E9,$47C9,$93BA,$41A8  {10**128}
  dw    $17AA,$7FE6,$A12B,$B616,$4212  {10**160}
  dw    $556B,$3927,$F78D,$E070,$427C  {10**192}
  dw    $C930,$E33C,$96FF,$8A52,$42E7  {10**224}
  dw    $DE8E,$9DF9,$EBFB,$AA7E,$4351  {10**256}
  dw    $2F8C,$5C6A,$FC19,$D226,$43BB  {10**288}
  dw    $E376,$F2CC,$2F29,$8184,$4426  {10**320}
  dw    $0AD2,$DB90,$2700,$9FA4,$4490  {10**352}
  dw    $AA17,$AEF8,$E310,$C4C5,$44FA  {10**384}
  dw    $9C59,$E9B0,$9C07,$F28A,$4564  {10**416}
  dw    $F3D4,$EBF7,$4AE1,$957A,$45CF  {10**448}
  dw    $A262,$0795,$D8DC,$B83E,$4639  {10**480}
@@Tab2:
  dw    $91C7,$A60E,$A0AE,$E319,$46A3  {10**512}
  dw    $0C17,$8175,$7586,$C976,$4D48  {10**1024}
  dw    $A7E4,$3993,$353B,$B2B8,$53ED  {10**1536}
  dw    $5DE5,$C53D,$3B5D,$9E8B,$5A92  {10**2048}
  dw    $F0A6,$20A1,$54C0,$8CA5,$6137  {10**2560}
  dw    $5A8B,$D88B,$5D25,$F989,$67DB  {10**3072}
  dw    $F3F8,$BF27,$C8A2,$DD5D,$6E80  {10**3584}
  dw    $979B,$8A20,$5202,$C460,$7525  {10**4096}
  dw    $59F0,$6ED5,$1162,$AE35,$7BCA  {10**4608}
end;

function ValExt_JOH_IA32_8_a(const s: AnsiString; var code: Integer): Extended;
asm
  push  ebx              {Save Used Registers}
  push  esi
  push  edi
  mov   esi, eax         {String Pointer}
  push  eax              {Save for Error Condition}
  xor   ebx, ebx
  push  eax              {Allocate Local Storage for Loading FPU}
  test  esi, esi
  jz    @@Nil            {Nil String}
@@Trim:
  movzx ebx, [esi]       {Strip Leading Spaces}
  inc   esi
  cmp   bl, ' '
  je    @@Trim
  xor   ecx, ecx         {Clear Sign Flag}
{$IFDEF PIC}
  call  GetGOT
  fld   qword [eax.Ten]  {Load 10 into FPU}
{$ELSE}
  fld   qword [Ten]      {Load 10 into FPU}
{$ENDIF}
  xor   eax, eax         {Zero Number of Decimal Places}
  fldz                   {Zero Result in FPU}
  cmp   bl, '0'
  jl    @@CheckSign      {Check for Sign Character}
@@FirstDigit:
  xor   edi, edi         {Zero Exponent Value}
@@DigitLoop:
  sub   bl, '0'
  cmp   bl, 9
  ja    @@Fraction       {Non-Digit}
  mov   cl, 1            {Set Digit Found Flag}
  mov   [esp], ebx       {Store for FPU Use}
  fmul  st(0), st(1)     {Multply by 10}
  fiadd dword ptr [esp]  {Add Next Digit}
  movzx ebx, [esi]       {Get Next Char}
  inc   esi
  test  bl, bl           {End Reached?}
  jnz   @@DigitLoop      {No, Get Next Digit}
  jmp   @@Finish         {Yes, Finished}
@@CheckSign:
  cmp   bl, '-'
  je    @@Minus
  cmp   bl, '+'
  je    @@SignSet
@@GetFirstDigit:
  test  bl, bl
  jz    @@Error          {No Digits Found}
  jmp   @@FirstDigit
@@Minus:
  mov   ch, 1            {Set Sign Flag}
@@SignSet:
  movzx ebx, [esi]       {Get Next Char}
  inc   esi
  jmp   @@GetFirstDigit
@@Fraction:
  cmp   bl, '.'-'0'
  jne   @@Exponent       {No Decimal Point}
  movzx ebx, [esi]       {Get Next Char}
  test  bl, bl
  jz    @@DotEnd         {String Ends with '.'}
  inc   esi
@@FractionLoop:
  sub   bl, '0'
  cmp   bl, 9
  ja    @@Exponent       {Non-Digit}
  mov   [esp], ebx
  dec   eax              {-(Number of Decimal Places)}
  fmul  st(0), st(1)     {Multply by 10}
  fiadd dword ptr [esp]  {Add Next Digit}
  movzx ebx, [esi]       {Get Next Char}
  inc   esi
  test  bl, bl           {End Reached?}
  jnz   @@FractionLoop   {No, Get Next Digit}
  jmp   @@Finish         {Yes, Finished (No Exponent)}
@@DotEnd:
  test  cl, cl           {Any Digits Found before '.'?}
  jnz   @@Finish         {Yes, Valid}
  jmp   @@Error          {No, Invalid}
@@Exponent:
  or    bl, $20
  cmp   bl, 'e'-'0'
  jne   @@Error          {Not 'e' or 'E'}
@@GetExponent:
  movzx ebx, [esi]       {Get Next Char}
  inc   esi
  mov   cl, 0            {Clear Exponent Sign Flag}
  cmp   bl, '-'
  je    @@MinusExp
  cmp   bl, '+'
  je    @@ExpSignSet
  jmp   @@ExpLoop
@@MinusExp:
  mov   cl, 1            {Set Exponent Sign Flag}
@@ExpSignSet:
  movzx ebx, [esi]       {Get Next Char}
  inc   esi
@@ExpLoop:
  sub   bl, '0'
  cmp   bl, 9
  ja    @@Error          {Non-Digit}
  lea   edi, [edi+edi*4] {Multiply by 10}
  add   edi, edi
  add   edi, ebx         {Add Next Digit}
  movzx ebx, [esi]       {Get Next Char}
  inc   esi
  test  bl, bl           {End Reached?}
  jnz   @@ExpLoop        {No, Get Next Digit}
@@EndExp:
  test  cl, cl           {Positive Exponent?}
  jz    @@Finish         {Yes, Keep Exponent Value}
  neg   edi              {No, Negate Exponent Value}
@@Finish:
  add   eax, edi         {Exponent Value - Number of Decimal Places}
  mov   [edx], ebx       {Result Code = 0}
  jz    @@PowerDone      {No call to _Pow10 Needed}
  mov   edi, ecx         {Save Decimal Sign Flag}
  call  _Pow10           {Raise to Power of 10}
  mov   ecx, edi         {Restore Decimal Sign Flag}
@@PowerDone:
  test  ch, ch           {Decimal Sign Flag Set?}
  jnz   @@Negate         {Yes, Negate Value}
@@Success:
  add   esp, 8           {Dump Local Storage and String Pointer}
@@Exit:
  ffree st(1)            {Remove Ten Value from FPU}
  pop   edi              {Restore Used Registers}
  pop   esi
  pop   ebx
  ret                    {Finished}
@@Negate:
  fchs                   {Negate Result in FPU}
  jmp   @@Success
@@Nil:
  inc   esi              {Force Result Code = 1}
  fldz                   {Result Value = 0}
@@Error:
  pop   ebx              {Dump Local Storage}
  pop   eax              {String Pointer}
  sub   esi, eax         {Error Offset}
  mov   [edx], esi       {Set Result Code}
  test  ch, ch           {Decimal Sign Flag Set?}
  jz    @@Exit           {No, Exit}
  fchs                   {Yes. Negate Result in FPU}
  jmp   @@Exit           {Exit Setting Result Code}
end;

initialization
  ChallengeValLong.RegisterFunction(FunctionData(
    'ValLong_JOH_PAS_8_a',  '', @ValLong_JOH_PAS_8_a, fccPAS, fcaJOH));
  ChallengeValLong.RegisterFunction(FunctionData(
    'ValLong_JOH_IA32_8_a', '', @ValLong_JOH_IA32_8_a, fccIA32, fcaJOH));

  ChallengeValInt64.RegisterFunction(FunctionData(
    'ValInt64_JOH_PAS_8_a',  '', @ValInt64_JOH_PAS_8_a, fccPAS, fcaJOH));
  ChallengeValInt64.RegisterFunction(FunctionData(
    'ValInt64_JOH_IA32_8_a',  '', @ValInt64_JOH_IA32_8_a, fccIA32, fcaJOH));

  ChallengeValExt.RegisterFunction(FunctionData(
    'ValExt_JOH_PAS_8_a',  '', @ValExt_JOH_PAS_8_a, fccPAS, fcaJOH));
  ChallengeValExt.RegisterFunction(FunctionData(
    'ValExt_JOH_IA32_8_a',  '', @ValExt_JOH_IA32_8_a, fccPAS, fcaJOH));
end.
