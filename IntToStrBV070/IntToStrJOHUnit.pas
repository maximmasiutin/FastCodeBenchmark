unit IntToStrJOHUnit;

interface

{$INCLUDE Defines.inc}

{ *** Range checking and overflow checking disabled *** }

implementation

uses
  FastcodeChallengeIntToStr32Unit,
  FastcodeChallengeIntToStr64Unit,
  FastcodeChallengeUnit;

const
  TwoDigitLookup : packed array[0..99] of array[1..2] of Char =
    ('00','01','02','03','04','05','06','07','08','09',
     '10','11','12','13','14','15','16','17','18','19',
     '20','21','22','23','24','25','26','27','28','29',
     '30','31','32','33','34','35','36','37','38','39',
     '40','41','42','43','44','45','46','47','48','49',
     '50','51','52','53','54','55','56','57','58','59',
     '60','61','62','63','64','65','66','67','68','69',
     '70','71','72','73','74','75','76','77','78','79',
     '80','81','82','83','84','85','86','87','88','89',
     '90','91','92','93','94','95','96','97','98','99');

const
  MinInt64Str : string = '-9223372036854775808';

{$ifopt Q+}
  {$define OverflowCheckEnabled}
  {$Q-}
{$endif}
{$ifopt R+}
  {$define RangeCheckEnabled}
  {$R-}
{$endif}

function IntToStr32_JOH_IA32_6_a(Value: Integer): string;
asm
  push   ebx
  push   edi
  push   esi
  mov    ebx, eax                {Value}
  sar    ebx, 31                 {0 for +ve Value or -1 for -ve Value}
  xor    eax, ebx
  sub    eax, ebx                {ABS(Value)}
  mov    esi, 10                 {Max Digits in Result}
  mov    edi, edx                {@Result}
  cmp    eax, 10
  sbb    esi, 0
  cmp    eax, 100
  sbb    esi, 0
  cmp    eax, 1000
  sbb    esi, 0
  cmp    eax, 10000
  sbb    esi, 0                   
  cmp    eax, 100000
  sbb    esi, 0
  cmp    eax, 1000000
  sbb    esi, 0
  cmp    eax, 10000000
  sbb    esi, 0
  cmp    eax, 100000000
  sbb    esi, 0
  cmp    eax, 1000000000
  sbb    esi, ebx                {Digits (Including Sign Character)}
  mov    ecx, [edx]              {Result}
  test   ecx, ecx
  je     @@NewStr                {Create New String for Result}
  cmp    dword ptr [ecx-8], 1
  jne    @@ChangeStr             {Reference Count <> 1}
  cmp    esi, [ecx-4]
  je     @@LengthOk              {Existing Length = Required Length}
  sub    ecx, 8                  {Allocation Address}
  push   eax                     {ABS(Value)}
  push   ecx
  mov    eax, esp
  lea    edx, [esi+9]            {New Allocation Size}
  call   system.@ReallocMem      {Reallocate Result String}
  pop    ecx
  pop    eax                     {ABS(Value)}
  add    ecx, 8                  {Result}
  mov    [ecx-4], esi            {Set New Length}
  mov    byte ptr [ecx+esi], 0   {Add Null Terminator}
  mov    [edi], ecx              {Set Result Address}
  jmp    @@LengthOk
@@ChangeStr:
  mov     edx, dword ptr [ecx-8]  {Reference Count}
  add     edx, 1
  jz      @@NewStr                {RefCount = -1 (String Constant)}
  lock    dec dword ptr [ecx-8]   {Decrement Existing Reference Count}
@@NewStr:
  push   eax                     {ABS(Value)}
  mov    eax, esi                {Length}
  call   system.@NewAnsiString
  mov    [edi], eax              {Set Result Address}
  mov    ecx, eax                {Result}
  pop    eax                     {ABS(Value)}
@@LengthOk:
  mov    byte ptr [ecx], '-'     {Store '-' Character (May be Overwritten)}
  add    esi, ebx                {Digits (Excluding Sign Character)}
  sub    ecx, ebx                {Destination of 1st Digit}
  sub    esi, 2                  {Digits (Excluding Sign Character) - 2}
  jle    @@FinalDigits           {1 or 2 Digit Value}
  cmp    esi, 8                  {10 Digit Value?}
  jne    @@SetResult             {Not a 10 Digit Value}
  sub    eax, 2000000000         {Digit 10 must be either '1' or '2'}
  mov    dl, '2'
  jnc    @@SetDigit10            {Digit 10 = '2'}
  mov    dl, '1'                 {Digit 10 = '1'}
  add    eax, 1000000000
@@SetDigit10:
  mov    [ecx], dl               {Save Digit 10}
  mov    esi, 7                  {9 Digits Remaining}
  add    ecx, 1                  {Destination of 2nd Digit}
@@SetResult:
  mov    edi, $28F5C29           {((2^32)+100-1)/100}
@@Loop:
  mov    ebx, eax                {Dividend}
  mul    edi                     {EDX = Dividend DIV 100}
  mov    eax, edx                {Set Next Dividend}
  imul   edx, -200               {-2 * (100 * Dividend DIV  100)}
  movzx  edx, word ptr [TwoDigitLookup+ebx*2+edx] {Dividend MOD 100 in ASCII}
  mov    [ecx+esi], dx
  sub    esi, 2
  jg     @@Loop                  {Loop Until 1 or 2 Digits Remaining}
@@FinalDigits:
  pop    esi
  pop    edi
  pop    ebx
  jnz    @@LastDigit
  movzx  eax, word ptr [TwoDigitLookup+eax*2]
  mov    [ecx], ax               {Save Final 2 Digits}
  ret
@@LastDigit:
  or     al , '0'                {Ascii Adjustment}
  mov    [ecx], al               {Save Final Digit}
end;

function IntToStr32_JOH_IA32_6_b(Value: Integer): string;
asm
  push   ebx
  push   edi
  push   esi
  mov    ebx, eax                {Value}
  sar    ebx, 31                 {0 for +ve Value or -1 for -ve Value}
  xor    eax, ebx
  sub    eax, ebx                {ABS(Value)}
  mov    esi, 10                 {Max Digits in Result}
  mov    edi, edx                {@Result}
  cmp    eax, 10
  sbb    esi, 0
  cmp    eax, 100
  sbb    esi, 0
  cmp    eax, 1000
  sbb    esi, 0
  cmp    eax, 10000
  sbb    esi, 0                   
  cmp    eax, 100000
  sbb    esi, 0
  cmp    eax, 1000000
  sbb    esi, 0
  cmp    eax, 10000000
  sbb    esi, 0
  cmp    eax, 100000000
  sbb    esi, 0
  cmp    eax, 1000000000
  sbb    esi, ebx                {Digits (Including Sign Character)}
  mov    ecx, [edx]              {Result}
  test   ecx, ecx
  je     @@NewStr                {Create New String for Result}
  cmp    dword ptr [ecx-8], 1
  jne    @@ChangeStr             {Reference Count <> 1}
  cmp    esi, [ecx-4]
  je     @@LengthOk              {Existing Length = Required Length}
  sub    ecx, 8                  {Allocation Address}
  push   eax                     {ABS(Value)}
  push   ecx
  mov    eax, esp
  lea    edx, [esi+9]            {New Allocation Size}
  call   system.@ReallocMem      {Reallocate Result String}
  pop    ecx
  pop    eax                     {ABS(Value)}
  add    ecx, 8                  {Result}
  mov    [ecx-4], esi            {Set New Length}
  mov    byte ptr [ecx+esi], 0   {Add Null Terminator}
  mov    [edi], ecx              {Set Result Address}
  jmp    @@LengthOk
@@ChangeStr:
  mov     edx, dword ptr [ecx-8]  {Reference Count}
  add     edx, 1
  jz      @@NewStr                {RefCount = -1 (String Constant)}
  lock    dec dword ptr [ecx-8]   {Decrement Existing Reference Count}
@@NewStr:
  push   eax                     {ABS(Value)}
  mov    eax, esi                {Length}
  call   system.@NewAnsiString
  mov    [edi], eax              {Set Result Address}
  mov    ecx, eax                {Result}
  pop    eax                     {ABS(Value)}
@@LengthOk:
  mov    byte ptr [ecx], '-'     {Store '-' Character (May be Overwritten)}
  add    esi, ebx                {Digits (Excluding Sign Character)}
  sub    ecx, ebx                {Destination of 1st Digit}
  sub    esi, 2                  {Digits (Excluding Sign Character) - 2}
  jle    @@FinalDigits           {1 or 2 Digit Value}
  cmp    esi, 8                  {10 Digit Value?}
  jne    @@SetResult             {Not a 10 Digit Value}
  sub    eax, 2000000000         {Digit 10 must be either '1' or '2'}
  mov    dl, '2'
  jnc    @@SetDigit10            {Digit 10 = '2'}
  mov    dl, '1'                 {Digit 10 = '1'}
  add    eax, 1000000000
@@SetDigit10:
  mov    [ecx], dl               {Save Digit 10}
  mov    esi, 7                  {9 Digits Remaining}
  add    ecx, 1                  {Destination of 2nd Digit}
@@SetResult:
  mov    edi, $28F5C29           {((2^32)+100-1)/100}
@@Loop:
  mov    ebx, eax                {Dividend}
  mul    edi                     {EDX = Dividend DIV 100}
  mov    eax, edx                {Set Next Dividend}
  imul   edx, -200               {-2 * (100 * Dividend DIV  100)}
  movzx  edx, word ptr [TwoDigitLookup+ebx*2+edx] {Dividend MOD 100 in ASCII}
  mov    [ecx+esi], dx
  sub    esi, 2
  jg     @@Loop                  {Loop Until 1 or 2 Digits Remaining}
@@FinalDigits:
  pop    esi
  pop    edi
  pop    ebx
  jnz    @@LastDigit
  movzx  eax, word ptr [TwoDigitLookup+eax*2]
  mov    [ecx], ax               {Save Final 2 Digits}
  ret
@@LastDigit:
  or     al , '0'                {Ascii Adjustment}
  mov    [ecx], al               {Save Final Digit}
end;

function IntToStr32_JOH_IA32_6_c(Value: Integer): string;
asm
  push   ebx
  push   edi
  push   esi
  mov    ebx, eax                {Value}
  sar    ebx, 31                 {0 for +ve Value or -1 for -ve Value}
  xor    eax, ebx
  sub    eax, ebx                {ABS(Value)}
  mov    esi, 10                 {Max Digits in Result}
  mov    edi, edx                {@Result}
  cmp    eax, 10
  sbb    esi, 0
  cmp    eax, 100
  sbb    esi, 0
  cmp    eax, 1000
  sbb    esi, 0
  cmp    eax, 10000
  sbb    esi, 0                   
  cmp    eax, 100000
  sbb    esi, 0
  cmp    eax, 1000000
  sbb    esi, 0
  cmp    eax, 10000000
  sbb    esi, 0
  cmp    eax, 100000000
  sbb    esi, 0
  cmp    eax, 1000000000
  sbb    esi, ebx                {Digits (Including Sign Character)}
  mov    ecx, [edx]              {Result}
  test   ecx, ecx
  je     @@NewStr                {Create New String for Result}
  cmp    dword ptr [ecx-8], 1
  jne    @@ChangeStr             {Reference Count <> 1}
  cmp    esi, [ecx-4]
  je     @@LengthOk              {Existing Length = Required Length}
  sub    ecx, 8                  {Allocation Address}
  push   eax                     {ABS(Value)}
  push   ecx
  mov    eax, esp
  lea    edx, [esi+9]            {New Allocation Size}
  call   system.@ReallocMem      {Reallocate Result String}
  pop    ecx
  pop    eax                     {ABS(Value)}
  add    ecx, 8                  {Result}
  mov    [ecx-4], esi            {Set New Length}
  mov    byte ptr [ecx+esi], 0   {Add Null Terminator}
  mov    [edi], ecx              {Set Result Address}
  jmp    @@LengthOk
@@ChangeStr:
  mov     edx, dword ptr [ecx-8]  {Reference Count}
  add     edx, 1
  jz      @@NewStr                {RefCount = -1 (String Constant)}
  lock    dec dword ptr [ecx-8]   {Decrement Existing Reference Count}
@@NewStr:
  push   eax                     {ABS(Value)}
  mov    eax, esi                {Length}
  call   system.@NewAnsiString
  mov    [edi], eax              {Set Result Address}
  mov    ecx, eax                {Result}
  pop    eax                     {ABS(Value)}
@@LengthOk:
  mov    byte ptr [ecx], '-'     {Store '-' Character (May be Overwritten)}
  add    esi, ebx                {Digits (Excluding Sign Character)}
  sub    ecx, ebx                {Destination of 1st Digit}
  sub    esi, 2                  {Digits (Excluding Sign Character) - 2}
  jle    @@FinalDigits           {1 or 2 Digit Value}
  cmp    esi, 8                  {10 Digit Value?}
  jne    @@SetResult             {Not a 10 Digit Value}
  sub    eax, 2000000000         {Digit 10 must be either '1' or '2'}
  mov    dl, '2'
  jnc    @@SetDigit10            {Digit 10 = '2'}
  mov    dl, '1'                 {Digit 10 = '1'}
  add    eax, 1000000000
@@SetDigit10:
  mov    [ecx], dl               {Save Digit 10}
  mov    esi, 7                  {9 Digits Remaining}
  add    ecx, 1                  {Destination of 2nd Digit}
@@SetResult:
  mov    edi, $28F5C29           {((2^32)+100-1)/100}
@@Loop:
  mov    ebx, eax                {Dividend}
  mul    edi                     {EDX = Dividend DIV 100}
  mov    eax, edx                {Set Next Dividend}
  imul   edx, -200               {-2 * (100 * Dividend DIV  100)}
  movzx  edx, word ptr [TwoDigitLookup+ebx*2+edx] {Dividend MOD 100 in ASCII}
  mov    [ecx+esi], dx
  sub    esi, 2
  jg     @@Loop                  {Loop Until 1 or 2 Digits Remaining}
@@FinalDigits:
  pop    esi
  pop    edi
  pop    ebx
  jnz    @@LastDigit
  movzx  eax, word ptr [TwoDigitLookup+eax*2]
  mov    [ecx], ax               {Save Final 2 Digits}
  ret
@@LastDigit:
  or     al , '0'                {Ascii Adjustment}
  mov    [ecx], al               {Save Final Digit}
end;

function IntToStr32_JOH_IA32_6_d(Value: Integer): string;
asm
  push   ebx
  push   edi
  push   esi
  mov    ebx, eax                {Value}
  sar    ebx, 31                 {0 for +ve Value or -1 for -ve Value}
  xor    eax, ebx
  sub    eax, ebx                {ABS(Value)}
  mov    esi, 10                 {Max Digits in Result}
  mov    edi, edx                {@Result}
  cmp    eax, 10
  sbb    esi, 0
  cmp    eax, 100
  sbb    esi, 0
  cmp    eax, 1000
  sbb    esi, 0
  cmp    eax, 10000
  sbb    esi, 0                   
  cmp    eax, 100000
  sbb    esi, 0
  cmp    eax, 1000000
  sbb    esi, 0
  cmp    eax, 10000000
  sbb    esi, 0
  cmp    eax, 100000000
  sbb    esi, 0
  cmp    eax, 1000000000
  sbb    esi, ebx                {Digits (Including Sign Character)}
  mov    ecx, [edx]              {Result}
  test   ecx, ecx
  je     @@NewStr                {Create New String for Result}
  cmp    dword ptr [ecx-8], 1
  jne    @@ChangeStr             {Reference Count <> 1}
  cmp    esi, [ecx-4]
  je     @@LengthOk              {Existing Length = Required Length}
  sub    ecx, 8                  {Allocation Address}
  push   eax                     {ABS(Value)}
  push   ecx
  mov    eax, esp
  lea    edx, [esi+9]            {New Allocation Size}
  call   system.@ReallocMem      {Reallocate Result String}
  pop    ecx
  pop    eax                     {ABS(Value)}
  add    ecx, 8                  {Result}
  mov    [ecx-4], esi            {Set New Length}
  mov    byte ptr [ecx+esi], 0   {Add Null Terminator}
  mov    [edi], ecx              {Set Result Address}
  jmp    @@LengthOk
@@ChangeStr:
  mov     edx, dword ptr [ecx-8]  {Reference Count}
  add     edx, 1
  jz      @@NewStr                {RefCount = -1 (String Constant)}
  lock    dec dword ptr [ecx-8]   {Decrement Existing Reference Count}
@@NewStr:
  push   eax                     {ABS(Value)}
  mov    eax, esi                {Length}
  call   system.@NewAnsiString
  mov    [edi], eax              {Set Result Address}
  mov    ecx, eax                {Result}
  pop    eax                     {ABS(Value)}
@@LengthOk:
  mov    byte ptr [ecx], '-'     {Store '-' Character (May be Overwritten)}
  add    esi, ebx                {Digits (Excluding Sign Character)}
  sub    ecx, ebx                {Destination of 1st Digit}
  sub    esi, 2                  {Digits (Excluding Sign Character) - 2}
  jle    @@FinalDigits           {1 or 2 Digit Value}
  cmp    esi, 8                  {10 Digit Value?}
  jne    @@SetResult             {Not a 10 Digit Value}
  sub    eax, 2000000000         {Digit 10 must be either '1' or '2'}
  mov    dl, '2'
  jnc    @@SetDigit10            {Digit 10 = '2'}
  mov    dl, '1'                 {Digit 10 = '1'}
  add    eax, 1000000000
@@SetDigit10:
  mov    [ecx], dl               {Save Digit 10}
  mov    esi, 7                  {9 Digits Remaining}
  add    ecx, 1                  {Destination of 2nd Digit}
@@SetResult:
  mov    edi, $28F5C29           {((2^32)+100-1)/100}
@@Loop:
  mov    ebx, eax                {Dividend}
  mul    edi                     {EDX = Dividend DIV 100}
  mov    eax, edx                {Set Next Dividend}
  imul   edx, -200               {-2 * (100 * Dividend DIV  100)}
  movzx  edx, word ptr [TwoDigitLookup+ebx*2+edx] {Dividend MOD 100 in ASCII}
  mov    [ecx+esi], dx
  sub    esi, 2
  jg     @@Loop                  {Loop Until 1 or 2 Digits Remaining}
@@FinalDigits:
  pop    esi
  pop    edi
  pop    ebx
  jnz    @@LastDigit
  movzx  eax, word ptr [TwoDigitLookup+eax*2]
  mov    [ecx], ax               {Save Final 2 Digits}
  ret
@@LastDigit:
  or     al , '0'                {Ascii Adjustment}
  mov    [ecx], al               {Save Final Digit}
end;

function IntToStr32_JOH_PAS_5_a(Value: Integer): string;
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
var
  Negative       : Boolean;
  I, J, K        : Cardinal;
  Digits         : Integer;
  P              : PByte;
  NewLen, OldLen : Integer;
begin
  Negative := (Value < 0);
  I := Abs(Value);
  if I >= 10000 then
    if I >= 1000000 then
      if I >= 100000000 then
        Digits := 9 + Ord(I >= 1000000000)
      else
        Digits := 7 + Ord(I >= 10000000)
    else
      Digits := 5 + Ord(I >= 100000)
  else
    if I >= 100 then
      Digits := 3 + Ord(I >= 1000)
    else
      Digits := 1 + Ord(I >= 10);
  NewLen  := Digits + Ord(Negative);
  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if NewLen <> OldLen then
    SetLength(Result, NewLen);
  P := Pointer(Result);
  P^ := Byte('-');
  Inc(P, Ord(Negative));
  if Digits > 2 then
    repeat
      J  := I div 100;           {Dividend div 100}
      K  := J * 100;
      K  := I - K;               {Dividend mod 100}
      I  := J;                   {Next Dividend}
      Dec(Digits, 2);
      PWord(@PByteArray(P)[Digits])^ := Word(TwoDigitLookup[K]);
    until Digits <= 2;
  if Digits = 2 then
    PWord(@PByteArray(P)[Digits-2])^ := Word(TwoDigitLookup[I])
  else
    P^ := I or ord('0');
end;

function IntToStr32_JOH_PAS_5_b(Value: Integer): string;
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
var
  Negative       : Boolean;
  I, J, K        : Cardinal;
  Digits         : Integer;
  P              : PByte;
  NewLen, OldLen : Integer;
begin
  Negative := (Value < 0);
  I := Abs(Value);
  if I >= 10000 then
    if I >= 1000000 then
      if I >= 100000000 then
        Digits := 9 + Ord(I >= 1000000000)
      else
        Digits := 7 + Ord(I >= 10000000)
    else
      Digits := 5 + Ord(I >= 100000)
  else
    if I >= 100 then
      Digits := 3 + Ord(I >= 1000)
    else
      Digits := 1 + Ord(I >= 10);
  NewLen  := Digits + Ord(Negative);
  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if NewLen <> OldLen then
    SetLength(Result, NewLen);
  P := Pointer(Result);
  P^ := Byte('-');
  Inc(P, Ord(Negative));
  if Digits > 2 then
    repeat
      J  := I div 100;           {Dividend div 100}
      K  := J * 100;
      K  := I - K;               {Dividend mod 100}
      I  := J;                   {Next Dividend}
      Dec(Digits, 2);
      PWord(@PByteArray(P)[Digits])^ := Word(TwoDigitLookup[K]);
    until Digits <= 2;
  if Digits = 2 then
    PWord(@PByteArray(P)[Digits-2])^ := Word(TwoDigitLookup[I])
  else
    P^ := I or ord('0');
end;

function IntToStr32_JOH_PAS_5_c(Value: Integer): string;
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
var
  Negative       : Boolean;
  I, J, K        : Cardinal;
  Digits         : Integer;
  P              : PByte;
  NewLen, OldLen : Integer;
begin
  Negative := (Value < 0);
  I := Abs(Value);
  if I >= 10000 then
    if I >= 1000000 then
      if I >= 100000000 then
        Digits := 9 + Ord(I >= 1000000000)
      else
        Digits := 7 + Ord(I >= 10000000)
    else
      Digits := 5 + Ord(I >= 100000)
  else
    if I >= 100 then
      Digits := 3 + Ord(I >= 1000)
    else
      Digits := 1 + Ord(I >= 10);
  NewLen  := Digits + Ord(Negative);
  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if NewLen <> OldLen then
    SetLength(Result, NewLen);
  P := Pointer(Result);
  P^ := Byte('-');
  Inc(P, Ord(Negative));
  if Digits > 2 then
    repeat
      J  := I div 100;           {Dividend div 100}
      K  := J * 100;
      K  := I - K;               {Dividend mod 100}
      I  := J;                   {Next Dividend}
      Dec(Digits, 2);
      PWord(@PByteArray(P)[Digits])^ := Word(TwoDigitLookup[K]);
    until Digits <= 2;
  if Digits = 2 then
    PWord(@PByteArray(P)[Digits-2])^ := Word(TwoDigitLookup[I])
  else
    P^ := I or ord('0');
end;

function IntToStr32_JOH_PAS_5_d(Value: Integer): string;
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
var
  Negative       : Boolean;
  I, J, K        : Cardinal;
  Digits         : Integer;
  P              : PByte;
  NewLen, OldLen : Integer;
begin
  Negative := (Value < 0);
  I := Abs(Value);
  if I >= 10000 then
    if I >= 1000000 then
      if I >= 100000000 then
        Digits := 9 + Ord(I >= 1000000000)
      else
        Digits := 7 + Ord(I >= 10000000)
    else
      Digits := 5 + Ord(I >= 100000)
  else
    if I >= 100 then
      Digits := 3 + Ord(I >= 1000)
    else
      Digits := 1 + Ord(I >= 10);
  NewLen  := Digits + Ord(Negative);
  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if NewLen <> OldLen then
    SetLength(Result, NewLen);
  P := Pointer(Result);
  P^ := Byte('-');
  Inc(P, Ord(Negative));
  if Digits > 2 then
    repeat
      J  := I div 100;           {Dividend div 100}
      K  := J * 100;
      K  := I - K;               {Dividend mod 100}
      I  := J;                   {Next Dividend}
      Dec(Digits, 2);
      PWord(@PByteArray(P)[Digits])^ := Word(TwoDigitLookup[K]);
    until Digits <= 2;
  if Digits = 2 then
    PWord(@PByteArray(P)[Digits-2])^ := Word(TwoDigitLookup[I])
  else
    P^ := I or ord('0');
end;

function IntToStr64_JOH_IA32_6_a(Value: Int64): string;
asm
  push   ebx
  mov    ecx, [ebp+8]            {Low Integer of Value}
  mov    edx, [ebp+12]           {High Integer of Value}
  xor    ebp, ebp                {Clear Sign Flag (EBP Already Pushed)}
  mov    ebx, ecx                {Low Integer of Value}
  test   edx, edx
  jnl    @@AbsValue
  mov    ebp, 1                  {EBP = 1 for -ve Value or 0 for +ve Value}
  neg    ecx
  adc    edx, 0
  neg    edx
@@AbsValue:                      {EDX:ECX = Abs(Value)}
  jnz    @@Large
  test   ecx, ecx
  js     @@Large
  mov    edx, eax                {@Result}
  mov    eax, ebx                {Low Integer of Value}
  call   IntToStr32_JOH_IA32_6_a {Call Fastest Integer IntToStr Function}
  pop    ebx
@@Exit:
  pop    ebp                     {Restore Stack and Exit}
  ret    8
@@Large:
  push   edi
  push   esi
  mov    edi, eax
  xor    ebx, ebx
  xor    eax, eax
@@Test15:                        {Test for 15 or More Digits}
  cmp    edx, $00005af3          {100000000000000 div $100000000}
  jne    @@Check15
  cmp    ecx, $107a4000          {100000000000000 mod $100000000}
@@Check15:
  jb     @@Test13
@@Test17:                        {Test for 17 or More Digits}
  cmp    edx, $002386f2          {10000000000000000 div $100000000}
  jne    @@Check17
  cmp    ecx, $6fc10000          {10000000000000000 mod $100000000}
@@Check17:
  jb     @@Test15or16
@@Test19:                        {Test for 19 Digits}
  cmp    edx, $0de0b6b3          {1000000000000000000 div $100000000}
  jne    @@Check19
  cmp    ecx, $a7640000          {1000000000000000000 mod $100000000}
@@Check19:
  jb     @@Test17or18
  mov    al, 19
  jmp    @@SetLength
@@Test17or18:                    {17 or 18 Digits}
  mov    bl, 18
  cmp    edx, $01634578          {100000000000000000 div $100000000}
  jne    @@SetLen
  cmp    ecx, $5d8a0000          {100000000000000000 mod $100000000}
  jmp    @@SetLen
@@Test15or16:                    {15 or 16 Digits}
  mov    bl, 16
  cmp    edx, $00038d7e          {1000000000000000 div $100000000}
  jne    @@SetLen
  cmp    ecx, $a4c68000          {1000000000000000 mod $100000000}
  jmp    @@SetLen
@@Test13:                        {Test for 13 or More Digits}
  cmp    edx, $000000e8          {1000000000000 div $100000000}
  jne    @@Check13
  cmp    ecx, $d4a51000          {1000000000000 mod $100000000}
@@Check13:
  jb     @@Test11
@@Test13or14:                    {13 or 14 Digits}
  mov    bl, 14
  cmp    edx, $00000918          {10000000000000 div $100000000}
  jne    @@SetLen
  cmp    ecx, $4e72a000          {10000000000000 mod $100000000}
  jmp    @@SetLen
@@Test11:                        {10, 11 or 12 Digits}
  cmp    edx, $02                {10000000000 div $100000000}
  jne    @@Check11
  cmp    ecx, $540be400          {10000000000 mod $100000000}
@@Check11:
  mov    bl, 11
  jb     @@SetLen                {10 Digits}
@@Test11or12:                    {11 or 12 Digits}
  mov    bl, 12
  cmp    edx, $17                {100000000000 div $100000000}
  jne    @@SetLen
  cmp    ecx, $4876e800          {100000000000 mod $100000000}
@@SetLen:
  sbb    eax, 0                  {Adjust for Odd/Evem Digit Count}
  add    eax, ebx
@@SetLength:                     {Abs(Value) in EDX:ECX, Digits in EAX}
  push   ecx                     {Save Abs(Value)}
  push   edx
  lea    edx, [eax+ebp]          {Digits Needed (Including Sign Character)}
  mov    ecx, [edi]              {@Result}
  mov    esi, edx                {Digits Needed (Including Sign Character)}
  test   ecx, ecx
  je     @@NewStr                {Create New String for Result}
  cmp    dword ptr [ecx-8], 1
  jne    @@ChangeStr             {Reference Count <> 1}
  cmp    esi, [ecx-4]
  je     @@LengthOk              {Existing Length = Required Length}
  sub    ecx, 8                  {Allocation Address}
  push   eax                     {ABS(Value)}
  push   ecx
  mov    eax, esp
  lea    edx, [esi+9]            {New Allocation Size}
  call   system.@ReallocMem      {Reallocate Result String}
  pop    ecx
  pop    eax                     {ABS(Value)}
  add    ecx, 8                  {@Result}
  mov    [ecx-4], esi            {Set New Length}
  mov    byte ptr [ecx+esi], 0   {Add Null Terminator}
  mov    [edi], ecx              {Set Result Address}
  jmp    @@LengthOk
@@ChangeStr:
  mov     edx, dword ptr [ecx-8]  {Reference Count}
  add     edx, 1
  jz      @@NewStr                {RefCount = -1 (String Constant)}
  lock    dec dword ptr [ecx-8]   {Decrement Existing Reference Count}
@@NewStr:
  push   eax                     {ABS(Value)}
  mov    eax, esi                {Length}
  call   system.@NewAnsiString
  mov    [edi], eax              {Set Result Address}
  mov    ecx, eax                {@Result}
  pop    eax                     {ABS(Value)}
@@LengthOk:
  mov    edi, [edi]              {@Result}
  sub    esi, ebp                {Digits Needed (Excluding Sign Character)}
  mov    byte ptr [edi], '-'     {Store '-' Character (May be Overwritten)}
  add    edi, ebp                {Destination of 1st Digit}
  pop    edx                     {Restore Abs(Value)}
  pop    eax
  cmp    esi, 17
  jl     @@LessThan17Digits      {Digits < 17}
  je     @@SetDigit17            {Digits = 17}
  cmp    esi, 18
  je     @@SetDigit18            {Digits = 18}
  mov    cl, '0' - 1
  mov    ebx, $a7640000          {1000000000000000000 mod $100000000}
  mov    ebp, $0de0b6b3          {1000000000000000000 div $100000000}
@@CalcDigit19:
  add    ecx, 1
  sub    eax, ebx
  sbb    edx, ebp
  jnc    @@CalcDigit19
  add    eax, ebx
  adc    edx, ebp
  mov    [edi], cl
  add    edi, 1
@@SetDigit18:
  mov    cl, '0' - 1
  mov    ebx, $5d8a0000          {100000000000000000 mod $100000000}
  mov    ebp, $01634578          {100000000000000000 div $100000000}
@@CalcDigit18:
  add    ecx, 1
  sub    eax, ebx
  sbb    edx, ebp
  jnc    @@CalcDigit18
  add    eax, ebx
  adc    edx, ebp
  mov    [edi], cl
  add    edi, 1
@@SetDigit17:
  mov    cl, '0' - 1
  mov    ebx, $6fc10000          {10000000000000000 mod $100000000}
  mov    ebp, $002386f2          {10000000000000000 div $100000000}
@@CalcDigit17:
  add    ecx, 1
  sub    eax, ebx
  sbb    edx, ebp
  jnc    @@CalcDigit17
  add    eax, ebx
  adc    edx, ebp
  mov    [edi], cl
  add    edi, 1                  {Update Destination}
  mov    esi, 16                 {Set 16 Digits Left}
@@LessThan17Digits:              {Process Next 8 Digits}
  mov    ecx, 100000000          {EDX:EAX = Abs(Value) = Dividend}
  div    ecx
  mov    ebp, eax                {Dividend DIV 100000000}
  mov    ebx, edx
  mov    eax, edx                {Dividend MOD 100000000}
  mov    edx, $51EB851F
  mul    edx
  shr    edx, 5                  {Dividend DIV 100}
  mov    eax, edx                {Set Next Dividend}
  lea    edx, [edx*4+edx]
  lea    edx, [edx*4+edx]
  shl    edx, 2                  {Dividend DIV 100 * 100}
  sub    ebx, edx                {Remainder (0..99)}
  movzx  ebx, word ptr [TwoDigitLookup+ebx*2]
  shl    ebx, 16
  mov    edx, $51EB851F
  mov    ecx, eax                {Dividend}
  mul    edx
  shr    edx, 5                  {Dividend DIV 100}
  mov    eax, edx
  lea    edx, [edx*4+edx]
  lea    edx, [edx*4+edx]
  shl    edx, 2                  {Dividend DIV 100 * 100}
  sub    ecx, edx                {Remainder (0..99)}
  or     bx, word ptr [TwoDigitLookup+ecx*2]
  mov    [edi+esi-4], ebx        {Store 4 Digits}
  mov    ebx, eax
  mov    edx, $51EB851F
  mul    edx
  shr    edx, 5                  {EDX := Dividend DIV 100}
  lea    eax, [edx*4+edx]
  lea    eax, [eax*4+eax]
  shl    eax, 2                  {EDX = Dividend DIV 100 * 100}
  sub    ebx, eax                {Remainder (0..99)}
  movzx  ebx, word ptr [TwoDigitLookup+ebx*2]
  movzx  ecx, word ptr [TwoDigitLookup+edx*2]
  shl    ebx, 16
  or     ebx, ecx
  mov    [edi+esi-8], ebx        {Store 4 Digits}
  mov    eax, ebp                {Remainder}
  sub    esi, 10                 {Digits Left - 2}
  jz     @@Last2Digits
@@SmallLoop:                     {Process Remaining Digits}
  mov    edx, $28F5C29           {((2^32)+100-1)/100}
  mov    ebx, eax                {Dividend}
  mul    edx
  mov    eax, edx                {Set Next Dividend}
  imul   edx, -200
  movzx  edx, word ptr [TwoDigitLookup+ebx*2+edx] {Dividend MOD 100 in ASCII}
  mov    [edi+esi], dx
  sub    esi, 2
  jg     @@SmallLoop             {Repeat Until Less than 2 Digits Remaining}
  jz     @@Last2Digits
  or     al , '0'                {Ascii Adjustment}
  mov    [edi], al               {Save Final Digit}
  jmp    @@Done
@@Last2Digits:
  movzx  eax, word ptr [TwoDigitLookup+eax*2]
  mov    [edi], ax               {Save Final 2 Digits}
@@Done:
  pop    esi
  pop    edi
  pop    ebx
end;

function IntToStr64_JOH_IA32_6_b(Value: Int64): string;
asm
  push   ebx
  mov    ecx, [ebp+8]            {Low Integer of Value}
  mov    edx, [ebp+12]           {High Integer of Value}
  xor    ebp, ebp                {Clear Sign Flag (EBP Already Pushed)}
  mov    ebx, ecx                {Low Integer of Value}
  test   edx, edx
  jnl    @@AbsValue
  mov    ebp, 1                  {EBP = 1 for -ve Value or 0 for +ve Value}
  neg    ecx
  adc    edx, 0
  neg    edx
@@AbsValue:                      {EDX:ECX = Abs(Value)}
  jnz    @@Large
  test   ecx, ecx
  js     @@Large
  mov    edx, eax                {@Result}
  mov    eax, ebx                {Low Integer of Value}
  call   IntToStr32_JOH_IA32_6_b {Call Fastest Integer IntToStr Function}
  pop    ebx
@@Exit:
  pop    ebp                     {Restore Stack and Exit}
  ret    8
@@Large:
  push   edi
  push   esi
  mov    edi, eax
  xor    ebx, ebx
  xor    eax, eax
@@Test15:                        {Test for 15 or More Digits}
  cmp    edx, $00005af3          {100000000000000 div $100000000}
  jne    @@Check15
  cmp    ecx, $107a4000          {100000000000000 mod $100000000}
@@Check15:
  jb     @@Test13
@@Test17:                        {Test for 17 or More Digits}
  cmp    edx, $002386f2          {10000000000000000 div $100000000}
  jne    @@Check17
  cmp    ecx, $6fc10000          {10000000000000000 mod $100000000}
@@Check17:
  jb     @@Test15or16
@@Test19:                        {Test for 19 Digits}
  cmp    edx, $0de0b6b3          {1000000000000000000 div $100000000}
  jne    @@Check19
  cmp    ecx, $a7640000          {1000000000000000000 mod $100000000}
@@Check19:
  jb     @@Test17or18
  mov    al, 19
  jmp    @@SetLength
@@Test17or18:                    {17 or 18 Digits}
  mov    bl, 18
  cmp    edx, $01634578          {100000000000000000 div $100000000}
  jne    @@SetLen
  cmp    ecx, $5d8a0000          {100000000000000000 mod $100000000}
  jmp    @@SetLen
@@Test15or16:                    {15 or 16 Digits}
  mov    bl, 16
  cmp    edx, $00038d7e          {1000000000000000 div $100000000}
  jne    @@SetLen
  cmp    ecx, $a4c68000          {1000000000000000 mod $100000000}
  jmp    @@SetLen
@@Test13:                        {Test for 13 or More Digits}
  cmp    edx, $000000e8          {1000000000000 div $100000000}
  jne    @@Check13
  cmp    ecx, $d4a51000          {1000000000000 mod $100000000}
@@Check13:
  jb     @@Test11
@@Test13or14:                    {13 or 14 Digits}
  mov    bl, 14
  cmp    edx, $00000918          {10000000000000 div $100000000}
  jne    @@SetLen
  cmp    ecx, $4e72a000          {10000000000000 mod $100000000}
  jmp    @@SetLen
@@Test11:                        {10, 11 or 12 Digits}
  cmp    edx, $02                {10000000000 div $100000000}
  jne    @@Check11
  cmp    ecx, $540be400          {10000000000 mod $100000000}
@@Check11:
  mov    bl, 11
  jb     @@SetLen                {10 Digits}
@@Test11or12:                    {11 or 12 Digits}
  mov    bl, 12
  cmp    edx, $17                {100000000000 div $100000000}
  jne    @@SetLen
  cmp    ecx, $4876e800          {100000000000 mod $100000000}
@@SetLen:
  sbb    eax, 0                  {Adjust for Odd/Evem Digit Count}
  add    eax, ebx
@@SetLength:                     {Abs(Value) in EDX:ECX, Digits in EAX}
  push   ecx                     {Save Abs(Value)}
  push   edx
  lea    edx, [eax+ebp]          {Digits Needed (Including Sign Character)}
  mov    ecx, [edi]              {@Result}
  mov    esi, edx                {Digits Needed (Including Sign Character)}
  test   ecx, ecx
  je     @@NewStr                {Create New String for Result}
  cmp    dword ptr [ecx-8], 1
  jne    @@ChangeStr             {Reference Count <> 1}
  cmp    esi, [ecx-4]
  je     @@LengthOk              {Existing Length = Required Length}
  sub    ecx, 8                  {Allocation Address}
  push   eax                     {ABS(Value)}
  push   ecx
  mov    eax, esp
  lea    edx, [esi+9]            {New Allocation Size}
  call   system.@ReallocMem      {Reallocate Result String}
  pop    ecx
  pop    eax                     {ABS(Value)}
  add    ecx, 8                  {@Result}
  mov    [ecx-4], esi            {Set New Length}
  mov    byte ptr [ecx+esi], 0   {Add Null Terminator}
  mov    [edi], ecx              {Set Result Address}
  jmp    @@LengthOk
@@ChangeStr:
  mov     edx, dword ptr [ecx-8]  {Reference Count}
  add     edx, 1
  jz      @@NewStr                {RefCount = -1 (String Constant)}
  lock    dec dword ptr [ecx-8]   {Decrement Existing Reference Count}
@@NewStr:
  push   eax                     {ABS(Value)}
  mov    eax, esi                {Length}
  call   system.@NewAnsiString
  mov    [edi], eax              {Set Result Address}
  mov    ecx, eax                {@Result}
  pop    eax                     {ABS(Value)}
@@LengthOk:
  mov    edi, [edi]              {@Result}
  sub    esi, ebp                {Digits Needed (Excluding Sign Character)}
  mov    byte ptr [edi], '-'     {Store '-' Character (May be Overwritten)}
  add    edi, ebp                {Destination of 1st Digit}
  pop    edx                     {Restore Abs(Value)}
  pop    eax
  cmp    esi, 17
  jl     @@LessThan17Digits      {Digits < 17}
  je     @@SetDigit17            {Digits = 17}
  cmp    esi, 18
  je     @@SetDigit18            {Digits = 18}
  mov    cl, '0' - 1
  mov    ebx, $a7640000          {1000000000000000000 mod $100000000}
  mov    ebp, $0de0b6b3          {1000000000000000000 div $100000000}
@@CalcDigit19:
  add    ecx, 1
  sub    eax, ebx
  sbb    edx, ebp
  jnc    @@CalcDigit19
  add    eax, ebx
  adc    edx, ebp
  mov    [edi], cl
  add    edi, 1
@@SetDigit18:
  mov    cl, '0' - 1
  mov    ebx, $5d8a0000          {100000000000000000 mod $100000000}
  mov    ebp, $01634578          {100000000000000000 div $100000000}
@@CalcDigit18:
  add    ecx, 1
  sub    eax, ebx
  sbb    edx, ebp
  jnc    @@CalcDigit18
  add    eax, ebx
  adc    edx, ebp
  mov    [edi], cl
  add    edi, 1
@@SetDigit17:
  mov    cl, '0' - 1
  mov    ebx, $6fc10000          {10000000000000000 mod $100000000}
  mov    ebp, $002386f2          {10000000000000000 div $100000000}
@@CalcDigit17:
  add    ecx, 1
  sub    eax, ebx
  sbb    edx, ebp
  jnc    @@CalcDigit17
  add    eax, ebx
  adc    edx, ebp
  mov    [edi], cl
  add    edi, 1                  {Update Destination}
  mov    esi, 16                 {Set 16 Digits Left}
@@LessThan17Digits:              {Process Next 8 Digits}
  mov    ecx, 100000000          {EDX:EAX = Abs(Value) = Dividend}
  div    ecx
  mov    ebp, eax                {Dividend DIV 100000000}
  mov    ebx, edx
  mov    eax, edx                {Dividend MOD 100000000}
  mov    edx, $51EB851F
  mul    edx
  shr    edx, 5                  {Dividend DIV 100}
  mov    eax, edx                {Set Next Dividend}
  lea    edx, [edx*4+edx]
  lea    edx, [edx*4+edx]
  shl    edx, 2                  {Dividend DIV 100 * 100}
  sub    ebx, edx                {Remainder (0..99)}
  movzx  ebx, word ptr [TwoDigitLookup+ebx*2]
  shl    ebx, 16
  mov    edx, $51EB851F
  mov    ecx, eax                {Dividend}
  mul    edx
  shr    edx, 5                  {Dividend DIV 100}
  mov    eax, edx
  lea    edx, [edx*4+edx]
  lea    edx, [edx*4+edx]
  shl    edx, 2                  {Dividend DIV 100 * 100}
  sub    ecx, edx                {Remainder (0..99)}
  or     bx, word ptr [TwoDigitLookup+ecx*2]
  mov    [edi+esi-4], ebx        {Store 4 Digits}
  mov    ebx, eax
  mov    edx, $51EB851F
  mul    edx
  shr    edx, 5                  {EDX := Dividend DIV 100}
  lea    eax, [edx*4+edx]
  lea    eax, [eax*4+eax]
  shl    eax, 2                  {EDX = Dividend DIV 100 * 100}
  sub    ebx, eax                {Remainder (0..99)}
  movzx  ebx, word ptr [TwoDigitLookup+ebx*2]
  movzx  ecx, word ptr [TwoDigitLookup+edx*2]
  shl    ebx, 16
  or     ebx, ecx
  mov    [edi+esi-8], ebx        {Store 4 Digits}
  mov    eax, ebp                {Remainder}
  sub    esi, 10                 {Digits Left - 2}
  jz     @@Last2Digits
@@SmallLoop:                     {Process Remaining Digits}
  mov    edx, $28F5C29           {((2^32)+100-1)/100}
  mov    ebx, eax                {Dividend}
  mul    edx
  mov    eax, edx                {Set Next Dividend}
  imul   edx, -200
  movzx  edx, word ptr [TwoDigitLookup+ebx*2+edx] {Dividend MOD 100 in ASCII}
  mov    [edi+esi], dx
  sub    esi, 2
  jg     @@SmallLoop             {Repeat Until Less than 2 Digits Remaining}
  jz     @@Last2Digits
  or     al , '0'                {Ascii Adjustment}
  mov    [edi], al               {Save Final Digit}
  jmp    @@Done
@@Last2Digits:
  movzx  eax, word ptr [TwoDigitLookup+eax*2]
  mov    [edi], ax               {Save Final 2 Digits}
@@Done:
  pop    esi
  pop    edi
  pop    ebx
end;

function IntToStr64_JOH_IA32_6_c(Value: Int64): string;
asm
  push   ebx
  mov    ecx, [ebp+8]            {Low Integer of Value}
  mov    edx, [ebp+12]           {High Integer of Value}
  xor    ebp, ebp                {Clear Sign Flag (EBP Already Pushed)}
  mov    ebx, ecx                {Low Integer of Value}
  test   edx, edx
  jnl    @@AbsValue
  mov    ebp, 1                  {EBP = 1 for -ve Value or 0 for +ve Value}
  neg    ecx
  adc    edx, 0
  neg    edx
@@AbsValue:                      {EDX:ECX = Abs(Value)}
  jnz    @@Large
  test   ecx, ecx
  js     @@Large
  mov    edx, eax                {@Result}
  mov    eax, ebx                {Low Integer of Value}
  call   IntToStr32_JOH_IA32_6_c {Call Fastest Integer IntToStr Function}
  pop    ebx
@@Exit:
  pop    ebp                     {Restore Stack and Exit}
  ret    8
@@Large:
  push   edi
  push   esi
  mov    edi, eax
  xor    ebx, ebx
  xor    eax, eax
@@Test15:                        {Test for 15 or More Digits}
  cmp    edx, $00005af3          {100000000000000 div $100000000}
  jne    @@Check15
  cmp    ecx, $107a4000          {100000000000000 mod $100000000}
@@Check15:
  jb     @@Test13
@@Test17:                        {Test for 17 or More Digits}
  cmp    edx, $002386f2          {10000000000000000 div $100000000}
  jne    @@Check17
  cmp    ecx, $6fc10000          {10000000000000000 mod $100000000}
@@Check17:
  jb     @@Test15or16
@@Test19:                        {Test for 19 Digits}
  cmp    edx, $0de0b6b3          {1000000000000000000 div $100000000}
  jne    @@Check19
  cmp    ecx, $a7640000          {1000000000000000000 mod $100000000}
@@Check19:
  jb     @@Test17or18
  mov    al, 19
  jmp    @@SetLength
@@Test17or18:                    {17 or 18 Digits}
  mov    bl, 18
  cmp    edx, $01634578          {100000000000000000 div $100000000}
  jne    @@SetLen
  cmp    ecx, $5d8a0000          {100000000000000000 mod $100000000}
  jmp    @@SetLen
@@Test15or16:                    {15 or 16 Digits}
  mov    bl, 16
  cmp    edx, $00038d7e          {1000000000000000 div $100000000}
  jne    @@SetLen
  cmp    ecx, $a4c68000          {1000000000000000 mod $100000000}
  jmp    @@SetLen
@@Test13:                        {Test for 13 or More Digits}
  cmp    edx, $000000e8          {1000000000000 div $100000000}
  jne    @@Check13
  cmp    ecx, $d4a51000          {1000000000000 mod $100000000}
@@Check13:
  jb     @@Test11
@@Test13or14:                    {13 or 14 Digits}
  mov    bl, 14
  cmp    edx, $00000918          {10000000000000 div $100000000}
  jne    @@SetLen
  cmp    ecx, $4e72a000          {10000000000000 mod $100000000}
  jmp    @@SetLen
@@Test11:                        {10, 11 or 12 Digits}
  cmp    edx, $02                {10000000000 div $100000000}
  jne    @@Check11
  cmp    ecx, $540be400          {10000000000 mod $100000000}
@@Check11:
  mov    bl, 11
  jb     @@SetLen                {10 Digits}
@@Test11or12:                    {11 or 12 Digits}
  mov    bl, 12
  cmp    edx, $17                {100000000000 div $100000000}
  jne    @@SetLen
  cmp    ecx, $4876e800          {100000000000 mod $100000000}
@@SetLen:
  sbb    eax, 0                  {Adjust for Odd/Evem Digit Count}
  add    eax, ebx
@@SetLength:                     {Abs(Value) in EDX:ECX, Digits in EAX}
  push   ecx                     {Save Abs(Value)}
  push   edx
  lea    edx, [eax+ebp]          {Digits Needed (Including Sign Character)}
  mov    ecx, [edi]              {@Result}
  mov    esi, edx                {Digits Needed (Including Sign Character)}
  test   ecx, ecx
  je     @@NewStr                {Create New String for Result}
  cmp    dword ptr [ecx-8], 1
  jne    @@ChangeStr             {Reference Count <> 1}
  cmp    esi, [ecx-4]
  je     @@LengthOk              {Existing Length = Required Length}
  sub    ecx, 8                  {Allocation Address}
  push   eax                     {ABS(Value)}
  push   ecx
  mov    eax, esp
  lea    edx, [esi+9]            {New Allocation Size}
  call   system.@ReallocMem      {Reallocate Result String}
  pop    ecx
  pop    eax                     {ABS(Value)}
  add    ecx, 8                  {@Result}
  mov    [ecx-4], esi            {Set New Length}
  mov    byte ptr [ecx+esi], 0   {Add Null Terminator}
  mov    [edi], ecx              {Set Result Address}
  jmp    @@LengthOk
@@ChangeStr:
  mov     edx, dword ptr [ecx-8]  {Reference Count}
  add     edx, 1
  jz      @@NewStr                {RefCount = -1 (String Constant)}
  lock    dec dword ptr [ecx-8]   {Decrement Existing Reference Count}
@@NewStr:
  push   eax                     {ABS(Value)}
  mov    eax, esi                {Length}
  call   system.@NewAnsiString
  mov    [edi], eax              {Set Result Address}
  mov    ecx, eax                {@Result}
  pop    eax                     {ABS(Value)}
@@LengthOk:
  mov    edi, [edi]              {@Result}
  sub    esi, ebp                {Digits Needed (Excluding Sign Character)}
  mov    byte ptr [edi], '-'     {Store '-' Character (May be Overwritten)}
  add    edi, ebp                {Destination of 1st Digit}
  pop    edx                     {Restore Abs(Value)}
  pop    eax
  cmp    esi, 17
  jl     @@LessThan17Digits      {Digits < 17}
  je     @@SetDigit17            {Digits = 17}
  cmp    esi, 18
  je     @@SetDigit18            {Digits = 18}
  mov    cl, '0' - 1
  mov    ebx, $a7640000          {1000000000000000000 mod $100000000}
  mov    ebp, $0de0b6b3          {1000000000000000000 div $100000000}
@@CalcDigit19:
  add    ecx, 1
  sub    eax, ebx
  sbb    edx, ebp
  jnc    @@CalcDigit19
  add    eax, ebx
  adc    edx, ebp
  mov    [edi], cl
  add    edi, 1
@@SetDigit18:
  mov    cl, '0' - 1
  mov    ebx, $5d8a0000          {100000000000000000 mod $100000000}
  mov    ebp, $01634578          {100000000000000000 div $100000000}
@@CalcDigit18:
  add    ecx, 1
  sub    eax, ebx
  sbb    edx, ebp
  jnc    @@CalcDigit18
  add    eax, ebx
  adc    edx, ebp
  mov    [edi], cl
  add    edi, 1
@@SetDigit17:
  mov    cl, '0' - 1
  mov    ebx, $6fc10000          {10000000000000000 mod $100000000}
  mov    ebp, $002386f2          {10000000000000000 div $100000000}
@@CalcDigit17:
  add    ecx, 1
  sub    eax, ebx
  sbb    edx, ebp
  jnc    @@CalcDigit17
  add    eax, ebx
  adc    edx, ebp
  mov    [edi], cl
  add    edi, 1                  {Update Destination}
  mov    esi, 16                 {Set 16 Digits Left}
@@LessThan17Digits:              {Process Next 8 Digits}
  mov    ecx, 100000000          {EDX:EAX = Abs(Value) = Dividend}
  div    ecx
  mov    ebp, eax                {Dividend DIV 100000000}
  mov    ebx, edx
  mov    eax, edx                {Dividend MOD 100000000}
  mov    edx, $51EB851F
  mul    edx
  shr    edx, 5                  {Dividend DIV 100}
  mov    eax, edx                {Set Next Dividend}
  lea    edx, [edx*4+edx]
  lea    edx, [edx*4+edx]
  shl    edx, 2                  {Dividend DIV 100 * 100}
  sub    ebx, edx                {Remainder (0..99)}
  movzx  ebx, word ptr [TwoDigitLookup+ebx*2]
  shl    ebx, 16
  mov    edx, $51EB851F
  mov    ecx, eax                {Dividend}
  mul    edx
  shr    edx, 5                  {Dividend DIV 100}
  mov    eax, edx
  lea    edx, [edx*4+edx]
  lea    edx, [edx*4+edx]
  shl    edx, 2                  {Dividend DIV 100 * 100}
  sub    ecx, edx                {Remainder (0..99)}
  or     bx, word ptr [TwoDigitLookup+ecx*2]
  mov    [edi+esi-4], ebx        {Store 4 Digits}
  mov    ebx, eax
  mov    edx, $51EB851F
  mul    edx
  shr    edx, 5                  {EDX := Dividend DIV 100}
  lea    eax, [edx*4+edx]
  lea    eax, [eax*4+eax]
  shl    eax, 2                  {EDX = Dividend DIV 100 * 100}
  sub    ebx, eax                {Remainder (0..99)}
  movzx  ebx, word ptr [TwoDigitLookup+ebx*2]
  movzx  ecx, word ptr [TwoDigitLookup+edx*2]
  shl    ebx, 16
  or     ebx, ecx
  mov    [edi+esi-8], ebx        {Store 4 Digits}
  mov    eax, ebp                {Remainder}
  sub    esi, 10                 {Digits Left - 2}
  jz     @@Last2Digits
@@SmallLoop:                     {Process Remaining Digits}
  mov    edx, $28F5C29           {((2^32)+100-1)/100}
  mov    ebx, eax                {Dividend}
  mul    edx
  mov    eax, edx                {Set Next Dividend}
  imul   edx, -200
  movzx  edx, word ptr [TwoDigitLookup+ebx*2+edx] {Dividend MOD 100 in ASCII}
  mov    [edi+esi], dx
  sub    esi, 2
  jg     @@SmallLoop             {Repeat Until Less than 2 Digits Remaining}
  jz     @@Last2Digits
  or     al , '0'                {Ascii Adjustment}
  mov    [edi], al               {Save Final Digit}
  jmp    @@Done
@@Last2Digits:
  movzx  eax, word ptr [TwoDigitLookup+eax*2]
  mov    [edi], ax               {Save Final 2 Digits}
@@Done:
  pop    esi
  pop    edi
  pop    ebx
end;

function IntToStr64_JOH_IA32_6_d(Value: Int64): string;
asm
  push   ebx
  mov    ecx, [ebp+8]            {Low Integer of Value}
  mov    edx, [ebp+12]           {High Integer of Value}
  xor    ebp, ebp                {Clear Sign Flag (EBP Already Pushed)}
  mov    ebx, ecx                {Low Integer of Value}
  test   edx, edx
  jnl    @@AbsValue
  mov    ebp, 1                  {EBP = 1 for -ve Value or 0 for +ve Value}
  neg    ecx
  adc    edx, 0
  neg    edx
@@AbsValue:                      {EDX:ECX = Abs(Value)}
  jnz    @@Large
  test   ecx, ecx
  js     @@Large
  mov    edx, eax                {@Result}
  mov    eax, ebx                {Low Integer of Value}
  call   IntToStr32_JOH_IA32_6_d {Call Fastest Integer IntToStr Function}
  pop    ebx
@@Exit:
  pop    ebp                     {Restore Stack and Exit}
  ret    8
@@Large:
  push   edi
  push   esi
  mov    edi, eax
  xor    ebx, ebx
  xor    eax, eax
@@Test15:                        {Test for 15 or More Digits}
  cmp    edx, $00005af3          {100000000000000 div $100000000}
  jne    @@Check15
  cmp    ecx, $107a4000          {100000000000000 mod $100000000}
@@Check15:
  jb     @@Test13
@@Test17:                        {Test for 17 or More Digits}
  cmp    edx, $002386f2          {10000000000000000 div $100000000}
  jne    @@Check17
  cmp    ecx, $6fc10000          {10000000000000000 mod $100000000}
@@Check17:
  jb     @@Test15or16
@@Test19:                        {Test for 19 Digits}
  cmp    edx, $0de0b6b3          {1000000000000000000 div $100000000}
  jne    @@Check19
  cmp    ecx, $a7640000          {1000000000000000000 mod $100000000}
@@Check19:
  jb     @@Test17or18
  mov    al, 19
  jmp    @@SetLength
@@Test17or18:                    {17 or 18 Digits}
  mov    bl, 18
  cmp    edx, $01634578          {100000000000000000 div $100000000}
  jne    @@SetLen
  cmp    ecx, $5d8a0000          {100000000000000000 mod $100000000}
  jmp    @@SetLen
@@Test15or16:                    {15 or 16 Digits}
  mov    bl, 16
  cmp    edx, $00038d7e          {1000000000000000 div $100000000}
  jne    @@SetLen
  cmp    ecx, $a4c68000          {1000000000000000 mod $100000000}
  jmp    @@SetLen
@@Test13:                        {Test for 13 or More Digits}
  cmp    edx, $000000e8          {1000000000000 div $100000000}
  jne    @@Check13
  cmp    ecx, $d4a51000          {1000000000000 mod $100000000}
@@Check13:
  jb     @@Test11
@@Test13or14:                    {13 or 14 Digits}
  mov    bl, 14
  cmp    edx, $00000918          {10000000000000 div $100000000}
  jne    @@SetLen
  cmp    ecx, $4e72a000          {10000000000000 mod $100000000}
  jmp    @@SetLen
@@Test11:                        {10, 11 or 12 Digits}
  cmp    edx, $02                {10000000000 div $100000000}
  jne    @@Check11
  cmp    ecx, $540be400          {10000000000 mod $100000000}
@@Check11:
  mov    bl, 11
  jb     @@SetLen                {10 Digits}
@@Test11or12:                    {11 or 12 Digits}
  mov    bl, 12
  cmp    edx, $17                {100000000000 div $100000000}
  jne    @@SetLen
  cmp    ecx, $4876e800          {100000000000 mod $100000000}
@@SetLen:
  sbb    eax, 0                  {Adjust for Odd/Evem Digit Count}
  add    eax, ebx
@@SetLength:                     {Abs(Value) in EDX:ECX, Digits in EAX}
  push   ecx                     {Save Abs(Value)}
  push   edx
  lea    edx, [eax+ebp]          {Digits Needed (Including Sign Character)}
  mov    ecx, [edi]              {@Result}
  mov    esi, edx                {Digits Needed (Including Sign Character)}
  test   ecx, ecx
  je     @@NewStr                {Create New String for Result}
  cmp    dword ptr [ecx-8], 1
  jne    @@ChangeStr             {Reference Count <> 1}
  cmp    esi, [ecx-4]
  je     @@LengthOk              {Existing Length = Required Length}
  sub    ecx, 8                  {Allocation Address}
  push   eax                     {ABS(Value)}
  push   ecx
  mov    eax, esp
  lea    edx, [esi+9]            {New Allocation Size}
  call   system.@ReallocMem      {Reallocate Result String}
  pop    ecx
  pop    eax                     {ABS(Value)}
  add    ecx, 8                  {@Result}
  mov    [ecx-4], esi            {Set New Length}
  mov    byte ptr [ecx+esi], 0   {Add Null Terminator}
  mov    [edi], ecx              {Set Result Address}
  jmp    @@LengthOk
@@ChangeStr:
  mov     edx, dword ptr [ecx-8]  {Reference Count}
  add     edx, 1
  jz      @@NewStr                {RefCount = -1 (String Constant)}
  lock    dec dword ptr [ecx-8]   {Decrement Existing Reference Count}
@@NewStr:
  push   eax                     {ABS(Value)}
  mov    eax, esi                {Length}
  call   system.@NewAnsiString
  mov    [edi], eax              {Set Result Address}
  mov    ecx, eax                {@Result}
  pop    eax                     {ABS(Value)}
@@LengthOk:
  mov    edi, [edi]              {@Result}
  sub    esi, ebp                {Digits Needed (Excluding Sign Character)}
  mov    byte ptr [edi], '-'     {Store '-' Character (May be Overwritten)}
  add    edi, ebp                {Destination of 1st Digit}
  pop    edx                     {Restore Abs(Value)}
  pop    eax
  cmp    esi, 17
  jl     @@LessThan17Digits      {Digits < 17}
  je     @@SetDigit17            {Digits = 17}
  cmp    esi, 18
  je     @@SetDigit18            {Digits = 18}
  mov    cl, '0' - 1
  mov    ebx, $a7640000          {1000000000000000000 mod $100000000}
  mov    ebp, $0de0b6b3          {1000000000000000000 div $100000000}
@@CalcDigit19:
  add    ecx, 1
  sub    eax, ebx
  sbb    edx, ebp
  jnc    @@CalcDigit19
  add    eax, ebx
  adc    edx, ebp
  mov    [edi], cl
  add    edi, 1
@@SetDigit18:
  mov    cl, '0' - 1
  mov    ebx, $5d8a0000          {100000000000000000 mod $100000000}
  mov    ebp, $01634578          {100000000000000000 div $100000000}
@@CalcDigit18:
  add    ecx, 1
  sub    eax, ebx
  sbb    edx, ebp
  jnc    @@CalcDigit18
  add    eax, ebx
  adc    edx, ebp
  mov    [edi], cl
  add    edi, 1
@@SetDigit17:
  mov    cl, '0' - 1
  mov    ebx, $6fc10000          {10000000000000000 mod $100000000}
  mov    ebp, $002386f2          {10000000000000000 div $100000000}
@@CalcDigit17:
  add    ecx, 1
  sub    eax, ebx
  sbb    edx, ebp
  jnc    @@CalcDigit17
  add    eax, ebx
  adc    edx, ebp
  mov    [edi], cl
  add    edi, 1                  {Update Destination}
  mov    esi, 16                 {Set 16 Digits Left}
@@LessThan17Digits:              {Process Next 8 Digits}
  mov    ecx, 100000000          {EDX:EAX = Abs(Value) = Dividend}
  div    ecx
  mov    ebp, eax                {Dividend DIV 100000000}
  mov    ebx, edx
  mov    eax, edx                {Dividend MOD 100000000}
  mov    edx, $51EB851F
  mul    edx
  shr    edx, 5                  {Dividend DIV 100}
  mov    eax, edx                {Set Next Dividend}
  lea    edx, [edx*4+edx]
  lea    edx, [edx*4+edx]
  shl    edx, 2                  {Dividend DIV 100 * 100}
  sub    ebx, edx                {Remainder (0..99)}
  movzx  ebx, word ptr [TwoDigitLookup+ebx*2]
  shl    ebx, 16
  mov    edx, $51EB851F
  mov    ecx, eax                {Dividend}
  mul    edx
  shr    edx, 5                  {Dividend DIV 100}
  mov    eax, edx
  lea    edx, [edx*4+edx]
  lea    edx, [edx*4+edx]
  shl    edx, 2                  {Dividend DIV 100 * 100}
  sub    ecx, edx                {Remainder (0..99)}
  or     bx, word ptr [TwoDigitLookup+ecx*2]
  mov    [edi+esi-4], ebx        {Store 4 Digits}
  mov    ebx, eax
  mov    edx, $51EB851F
  mul    edx
  shr    edx, 5                  {EDX := Dividend DIV 100}
  lea    eax, [edx*4+edx]
  lea    eax, [eax*4+eax]
  shl    eax, 2                  {EDX = Dividend DIV 100 * 100}
  sub    ebx, eax                {Remainder (0..99)}
  movzx  ebx, word ptr [TwoDigitLookup+ebx*2]
  movzx  ecx, word ptr [TwoDigitLookup+edx*2]
  shl    ebx, 16
  or     ebx, ecx
  mov    [edi+esi-8], ebx        {Store 4 Digits}
  mov    eax, ebp                {Remainder}
  sub    esi, 10                 {Digits Left - 2}
  jz     @@Last2Digits
@@SmallLoop:                     {Process Remaining Digits}
  mov    edx, $28F5C29           {((2^32)+100-1)/100}
  mov    ebx, eax                {Dividend}
  mul    edx
  mov    eax, edx                {Set Next Dividend}
  imul   edx, -200
  movzx  edx, word ptr [TwoDigitLookup+ebx*2+edx] {Dividend MOD 100 in ASCII}
  mov    [edi+esi], dx
  sub    esi, 2
  jg     @@SmallLoop             {Repeat Until Less than 2 Digits Remaining}
  jz     @@Last2Digits
  or     al , '0'                {Ascii Adjustment}
  mov    [edi], al               {Save Final Digit}
  jmp    @@Done
@@Last2Digits:
  movzx  eax, word ptr [TwoDigitLookup+eax*2]
  mov    [edi], ax               {Save Final 2 Digits}
@@Done:
  pop    esi
  pop    edi
  pop    ebx
end;

function IntToStr64_JOH_PAS_5_a(Value: Int64): string;
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
var
  Negative           : Boolean;
  I64, J64, K64      : Int64;
  I32, J32, K32, L32 : Cardinal;
  Digits             : Byte;
  P                  : PByte;
  OldLen, NewLen     : Integer;
  C                  : Char;
begin
  if Value = $8000000000000000 then
    begin {Special Case since ABS($8000000000000000) Fails}
      Result := MinInt64Str;
      Exit;
    end;
  if (Value >= -MaxInt-1) and (Value <= MaxInt) then
    begin {Within Integer Range - Use Faster Integer Version}
      Result := IntToStr32_JOH_PAS_5_a(Value);
      Exit;
    end;
  Negative := Value < 0;
  I64 := Abs(Value);
  if I64 >= 100000000000000 then
    if I64 >= 10000000000000000 then
      if I64 >= 1000000000000000000 then
        Digits := 19
      else
        Digits := 17 + Ord(I64 >= 100000000000000000)
    else
      Digits := 15 + Ord(I64 >= 1000000000000000)
  else
    if I64 >= 1000000000000 then
      Digits := 13 + Ord(I64 >= 10000000000000)
    else
      if I64 >= 10000000000 then
        Digits := 11 + Ord(I64 >= 100000000000)
      else
        Digits := 10;
  NewLen  := Digits + Ord(Negative);
  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if NewLen <> OldLen then
    SetLength(Result, NewLen);
  P := Pointer(Result);
  P^ := Byte('-');
  Inc(P, Ord(Negative));
  if Digits > 17 then
    begin {18 or 19 Digits}
      if Digits = 19 then
        begin
          C := '0';
          while I64 >= 1000000000000000000 do
            begin
              Dec(I64, 1000000000000000000);
              Inc(C);
            end;
          P^ := Ord(C);
          Inc(P);
        end;
      C := '0';
      while I64 >= 100000000000000000 do
        begin
          Dec(I64, 100000000000000000);
          Inc(C);
        end;
      P^ := Ord(C);
      Inc(P);
      Digits := 17;
    end;
  J64 := I64 div 100000000; {Very Slow prior to Delphi 2005}
  K64 := I64 - (J64 * 100000000); {Remainder = 0..99999999}
  I32 := K64;
  J32 := I32 div 100;
  K32 := J32 * 100;
  K32 := I32 - K32;
  I32 := J32 div 100;
  L32 := I32 * 100;
  L32 := J32 - L32;
  Dec(Digits, 4);
  J32 := (Word(TwoDigitLookup[K32]) shl 16) + Word(TwoDigitLookup[L32]);
  PInteger(@PByteArray(P)[Digits])^ := J32;
  J32 := I32 div 100;
  K32 := J32 * 100;
  K32 := I32 - K32;
  Dec(Digits, 4);
  I32 := (Word(TwoDigitLookup[K32]) shl 16) + Word(TwoDigitLookup[J32]);
  PInteger(@PByteArray(P)[Digits])^ := I32;
  I32 := J64; {Dividend now Fits within Integer - Use Faster Version}
  if Digits > 2 then
    repeat
      J32 := I32 div 100;
      K32 := J32 * 100;
      K32 := I32 - K32;
      I32 := J32;
      Dec(Digits, 2);
      PWord(@PByteArray(P)[Digits])^ := Word(TwoDigitLookup[K32]);
    until Digits <= 2;
  if Digits = 2 then
    PWord(@PByteArray(P)[Digits-2])^ := Word(TwoDigitLookup[I32])
  else
    P^ := I32 or ord('0');
end;

function IntToStr64_JOH_PAS_5_b(Value: Int64): string;
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
var
  Negative           : Boolean;
  I64, J64, K64      : Int64;
  I32, J32, K32, L32 : Cardinal;
  Digits             : Byte;
  P                  : PByte;
  OldLen, NewLen     : Integer;
  C                  : Char;
begin
  if Value = $8000000000000000 then
    begin {Special Case since ABS($8000000000000000) Fails}
      Result := MinInt64Str;
      Exit;
    end;
  if (Value >= -MaxInt-1) and (Value <= MaxInt) then
    begin {Within Integer Range - Use Faster Integer Version}
      Result := IntToStr32_JOH_PAS_5_b(Value);
      Exit;
    end;
  Negative := Value < 0;
  I64 := Abs(Value);
  if I64 >= 100000000000000 then
    if I64 >= 10000000000000000 then
      if I64 >= 1000000000000000000 then
        Digits := 19
      else
        Digits := 17 + Ord(I64 >= 100000000000000000)
    else
      Digits := 15 + Ord(I64 >= 1000000000000000)
  else
    if I64 >= 1000000000000 then
      Digits := 13 + Ord(I64 >= 10000000000000)
    else
      if I64 >= 10000000000 then
        Digits := 11 + Ord(I64 >= 100000000000)
      else
        Digits := 10;
  NewLen  := Digits + Ord(Negative);
  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if NewLen <> OldLen then
    SetLength(Result, NewLen);
  P := Pointer(Result);
  P^ := Byte('-');
  Inc(P, Ord(Negative));
  if Digits > 17 then
    begin {18 or 19 Digits}
      if Digits = 19 then
        begin
          C := '0';
          while I64 >= 1000000000000000000 do
            begin
              Dec(I64, 1000000000000000000);
              Inc(C);
            end;
          P^ := Ord(C);
          Inc(P);
        end;
      C := '0';
      while I64 >= 100000000000000000 do
        begin
          Dec(I64, 100000000000000000);
          Inc(C);
        end;
      P^ := Ord(C);
      Inc(P);
      Digits := 17;
    end;
  J64 := I64 div 100000000; {Very Slow prior to Delphi 2005}
  K64 := I64 - (J64 * 100000000); {Remainder = 0..99999999}
  I32 := K64;
  J32 := I32 div 100;
  K32 := J32 * 100;
  K32 := I32 - K32;
  I32 := J32 div 100;
  L32 := I32 * 100;
  L32 := J32 - L32;
  Dec(Digits, 4);
  J32 := (Word(TwoDigitLookup[K32]) shl 16) + Word(TwoDigitLookup[L32]);
  PInteger(@PByteArray(P)[Digits])^ := J32;
  J32 := I32 div 100;
  K32 := J32 * 100;
  K32 := I32 - K32;
  Dec(Digits, 4);
  I32 := (Word(TwoDigitLookup[K32]) shl 16) + Word(TwoDigitLookup[J32]);
  PInteger(@PByteArray(P)[Digits])^ := I32;
  I32 := J64; {Dividend now Fits within Integer - Use Faster Version}
  if Digits > 2 then
    repeat
      J32 := I32 div 100;
      K32 := J32 * 100;
      K32 := I32 - K32;
      I32 := J32;
      Dec(Digits, 2);
      PWord(@PByteArray(P)[Digits])^ := Word(TwoDigitLookup[K32]);
    until Digits <= 2;
  if Digits = 2 then
    PWord(@PByteArray(P)[Digits-2])^ := Word(TwoDigitLookup[I32])
  else
    P^ := I32 or ord('0');
end;

function IntToStr64_JOH_PAS_5_c(Value: Int64): string;
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
var
  Negative           : Boolean;
  I64, J64, K64      : Int64;
  I32, J32, K32, L32 : Cardinal;
  Digits             : Byte;
  P                  : PByte;
  OldLen, NewLen     : Integer;
  C                  : Char;
begin
  if Value = $8000000000000000 then
    begin {Special Case since ABS($8000000000000000) Fails}
      Result := MinInt64Str;
      Exit;
    end;
  if (Value >= -MaxInt-1) and (Value <= MaxInt) then
    begin {Within Integer Range - Use Faster Integer Version}
      Result := IntToStr32_JOH_PAS_5_c(Value);
      Exit;
    end;
  Negative := Value < 0;
  I64 := Abs(Value);
  if I64 >= 100000000000000 then
    if I64 >= 10000000000000000 then
      if I64 >= 1000000000000000000 then
        Digits := 19
      else
        Digits := 17 + Ord(I64 >= 100000000000000000)
    else
      Digits := 15 + Ord(I64 >= 1000000000000000)
  else
    if I64 >= 1000000000000 then
      Digits := 13 + Ord(I64 >= 10000000000000)
    else
      if I64 >= 10000000000 then
        Digits := 11 + Ord(I64 >= 100000000000)
      else
        Digits := 10;
  NewLen  := Digits + Ord(Negative);
  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if NewLen <> OldLen then
    SetLength(Result, NewLen);
  P := Pointer(Result);
  P^ := Byte('-');
  Inc(P, Ord(Negative));
  if Digits > 17 then
    begin {18 or 19 Digits}
      if Digits = 19 then
        begin
          C := '0';
          while I64 >= 1000000000000000000 do
            begin
              Dec(I64, 1000000000000000000);
              Inc(C);
            end;
          P^ := Ord(C);
          Inc(P);
        end;
      C := '0';
      while I64 >= 100000000000000000 do
        begin
          Dec(I64, 100000000000000000);
          Inc(C);
        end;
      P^ := Ord(C);
      Inc(P);
      Digits := 17;
    end;
  J64 := I64 div 100000000; {Very Slow prior to Delphi 2005}
  K64 := I64 - (J64 * 100000000); {Remainder = 0..99999999}
  I32 := K64;
  J32 := I32 div 100;
  K32 := J32 * 100;
  K32 := I32 - K32;
  I32 := J32 div 100;
  L32 := I32 * 100;
  L32 := J32 - L32;
  Dec(Digits, 4);
  J32 := (Word(TwoDigitLookup[K32]) shl 16) + Word(TwoDigitLookup[L32]);
  PInteger(@PByteArray(P)[Digits])^ := J32;
  J32 := I32 div 100;
  K32 := J32 * 100;
  K32 := I32 - K32;
  Dec(Digits, 4);
  I32 := (Word(TwoDigitLookup[K32]) shl 16) + Word(TwoDigitLookup[J32]);
  PInteger(@PByteArray(P)[Digits])^ := I32;
  I32 := J64; {Dividend now Fits within Integer - Use Faster Version}
  if Digits > 2 then
    repeat
      J32 := I32 div 100;
      K32 := J32 * 100;
      K32 := I32 - K32;
      I32 := J32;
      Dec(Digits, 2);
      PWord(@PByteArray(P)[Digits])^ := Word(TwoDigitLookup[K32]);
    until Digits <= 2;
  if Digits = 2 then
    PWord(@PByteArray(P)[Digits-2])^ := Word(TwoDigitLookup[I32])
  else
    P^ := I32 or ord('0');
end;

function IntToStr64_JOH_PAS_5_d(Value: Int64): string;
type
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
var
  Negative           : Boolean;
  I64, J64, K64      : Int64;
  I32, J32, K32, L32 : Cardinal;
  Digits             : Byte;
  P                  : PByte;
  OldLen, NewLen     : Integer;
  C                  : Char;
begin
  if Value = $8000000000000000 then
    begin {Special Case since ABS($8000000000000000) Fails}
      Result := MinInt64Str;
      Exit;
    end;
  if (Value >= -MaxInt-1) and (Value <= MaxInt) then
    begin {Within Integer Range - Use Faster Integer Version}
      Result := IntToStr32_JOH_PAS_5_d(Value);
      Exit;
    end;
  Negative := Value < 0;
  I64 := Abs(Value);
  if I64 >= 100000000000000 then
    if I64 >= 10000000000000000 then
      if I64 >= 1000000000000000000 then
        Digits := 19
      else
        Digits := 17 + Ord(I64 >= 100000000000000000)
    else
      Digits := 15 + Ord(I64 >= 1000000000000000)
  else
    if I64 >= 1000000000000 then
      Digits := 13 + Ord(I64 >= 10000000000000)
    else
      if I64 >= 10000000000 then
        Digits := 11 + Ord(I64 >= 100000000000)
      else
        Digits := 10;
  NewLen  := Digits + Ord(Negative);
  if Result = '' then
    OldLen := 0
  else
    if PInteger(Integer(Result) - 8)^ = 1 then {Ref Count}
      OldLen := (PInteger(Integer(Result) - 4)^)
    else
      OldLen := 0;
  if NewLen <> OldLen then
    SetLength(Result, NewLen);
  P := Pointer(Result);
  P^ := Byte('-');
  Inc(P, Ord(Negative));
  if Digits > 17 then
    begin {18 or 19 Digits}
      if Digits = 19 then
        begin
          C := '0';
          while I64 >= 1000000000000000000 do
            begin
              Dec(I64, 1000000000000000000);
              Inc(C);
            end;
          P^ := Ord(C);
          Inc(P);
        end;
      C := '0';
      while I64 >= 100000000000000000 do
        begin
          Dec(I64, 100000000000000000);
          Inc(C);
        end;
      P^ := Ord(C);
      Inc(P);
      Digits := 17;
    end;
  J64 := I64 div 100000000; {Very Slow prior to Delphi 2005}
  K64 := I64 - (J64 * 100000000); {Remainder = 0..99999999}
  I32 := K64;
  J32 := I32 div 100;
  K32 := J32 * 100;
  K32 := I32 - K32;
  I32 := J32 div 100;
  L32 := I32 * 100;
  L32 := J32 - L32;
  Dec(Digits, 4);
  J32 := (Word(TwoDigitLookup[K32]) shl 16) + Word(TwoDigitLookup[L32]);
  PInteger(@PByteArray(P)[Digits])^ := J32;
  J32 := I32 div 100;
  K32 := J32 * 100;
  K32 := I32 - K32;
  Dec(Digits, 4);
  I32 := (Word(TwoDigitLookup[K32]) shl 16) + Word(TwoDigitLookup[J32]);
  PInteger(@PByteArray(P)[Digits])^ := I32;
  I32 := J64; {Dividend now Fits within Integer - Use Faster Version}
  if Digits > 2 then
    repeat
      J32 := I32 div 100;
      K32 := J32 * 100;
      K32 := I32 - K32;
      I32 := J32;
      Dec(Digits, 2);
      PWord(@PByteArray(P)[Digits])^ := Word(TwoDigitLookup[K32]);
    until Digits <= 2;
  if Digits = 2 then
    PWord(@PByteArray(P)[Digits-2])^ := Word(TwoDigitLookup[I32])
  else
    P^ := I32 or ord('0');
end;

{$ifdef OverflowCheckEnabled}
  {$Q+}
{$endif}
{$ifdef RangeCheckEnabled}
  {$R+}
{$endif}

initialization
begin
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_JOH_IA32_6_a', '2 Digits per Loop', @IntToStr32_JOH_IA32_6_a, fccIA32, fcaJOH));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_JOH_IA32_6_b', '2 Digits per Loop', @IntToStr32_JOH_IA32_6_b, fccIA32, fcaJOH));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_JOH_IA32_6_c', '2 Digits per Loop', @IntToStr32_JOH_IA32_6_c, fccIA32, fcaJOH));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_JOH_IA32_6_d', '2 Digits per Loop', @IntToStr32_JOH_IA32_6_d, fccIA32, fcaJOH));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_JOH_PAS_5_a', '2 Digits per Loop', @IntToStr32_JOH_PAS_5_a,  fccPas,  fcaJOH));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_JOH_PAS_5_b', '2 Digits per Loop', @IntToStr32_JOH_PAS_5_b,  fccPas,  fcaJOH));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_JOH_PAS_5_c', '2 Digits per Loop', @IntToStr32_JOH_PAS_5_c,  fccPas,  fcaJOH));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_JOH_PAS_5_d', '2 Digits per Loop', @IntToStr32_JOH_PAS_5_d,  fccPas,  fcaJOH));
  ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_JOH_IA32_6_a', 'Only 1 DIV', @IntToStr64_JOH_IA32_6_a, fccIA32, fcaJOH));
  ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_JOH_IA32_6_b', 'Only 1 DIV', @IntToStr64_JOH_IA32_6_b, fccIA32, fcaJOH));
  ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_JOH_IA32_6_c', 'Only 1 DIV', @IntToStr64_JOH_IA32_6_c, fccIA32, fcaJOH));
  ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_JOH_IA32_6_d', 'Only 1 DIV', @IntToStr64_JOH_IA32_6_d, fccIA32, fcaJOH));
  ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_JOH_PAS_5_a', '2 Digits per Loop', @IntToStr64_JOH_PAS_5_a,  fccPas,  fcaJOH));
  ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_JOH_PAS_5_b', '2 Digits per Loop', @IntToStr64_JOH_PAS_5_b,  fccPas,  fcaJOH));
  ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_JOH_PAS_5_c', '2 Digits per Loop', @IntToStr64_JOH_PAS_5_c,  fccPas,  fcaJOH));
  ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_JOH_PAS_5_d', '2 Digits per Loop', @IntToStr64_JOH_PAS_5_d,  fccPas,  fcaJOH));
end;

end.

