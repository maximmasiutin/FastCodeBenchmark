unit IsPrimeJOHUnit;

{$R-,Q-}

interface

function IsPrime_JOH_PAS_6 (Number: Cardinal): Boolean;
function IsPrime_JOH_IA32_6(Number: Cardinal): Boolean;
function IsPrime_JOH_IA32_8(Number: Cardinal): Boolean;

implementation

function IsPrime_JOH_PAS_6(Number : Cardinal) : Boolean;
const {Size = 748 Bytes + 576 Byte Tables = 1324 Bytes}
  PrimeNumbers : array[0..255] of Word = {excluding 2,3 and 5}
    (7,11,13,17,19,23,29,31,37,41,43,47,53,59, 61,67,71,73,79,83,89,97,101,
     103,107,109,113,127,131,137,139,149,151,157,163,167,173,179,181,191,193,
     197,199,211,223,227,229,233,239,241,251,257,263,269,271,277,281,283,293,
     307,311,313,317,331,337,347,349,353,359,367,373,379,383,389,397,401,409,
     419,421,431,433,439,443,449,457,461,463,467,479,487,491,499,503,509,521,
     523,541,547,557,563,569,571,577,587,593,599,601,607,613,617,619,631,641,
     643,647,653,659,661,673,677,683,691,701,709,719,727,733,739,743,751,757,
     761,769,773,787,797,809,811,821,823,827,829,839,853,857,859,863,877,881,
     883,887,907,911,919,929,937,941,947,953,967,971,977,983,991,997,1009,
     1013,1019,1021,1031,1033,1039,1049,1051,1061,1063,1069,1087,1091,1093,
     1097,1103,1109,1117,1123,1129,1151,1153,1163,1171,1181,1187,1193,1201,
     1213,1217,1223,1229,1231,1237,1249,1259,1277,1279,1283,1289,1291,1297,
     1301,1303,1307,1319,1321,1327,1361,1367,1373,1381,1399,1409,1423,1427,
     1429,1433,1439,1447,1451,1453,1459,1471,1481,1483,1487,1489,1493,1499,
     1511,1523,1531,1543,1549,1553,1559,1567,1571,1579,1583,1597,1601,1607,
     1609,1613,1619,1621,1627,1637);
  ModTable : array[0..61] of Boolean = {Lookup for Mod(3) and Mod(5) Test}
    (True,False,False,True,False,True,True,False,False,True,True,False,True,
     False,False,True,False,False,True,False,True,True,False,False,True,True,
     False,True,False,False,True,False,False,True,False,True,True,False,False,
     True,True,False,True,False,False,True,False,False,True,False,True,True,
     False,False,True,True,False,True,False,False,True,False);
type
  ValueType = record
    case Integer of
      0 : (AsInt64      : Int64);
      1 : (LoInt, HiInt : Integer);
  end;
var
  A, B, J, K, P   : Cardinal;
  MaxModSet, Done : Boolean;
  MaxMod          : Int64;

  function SPPTest(Base : Cardinal) : Boolean;
  var
    C, D, N : Cardinal;
    Value   : ValueType;

    procedure SqrMod;
    const
      MaxInt64 = $7FFFFFFFFFFFFFFF;
    begin
      Value.AsInt64 := Value.AsInt64 * Value.AsInt64;
      if Value.HiInt < 0 then
        begin {Overflow - Split into Two}
          if not MaxModSet then
            begin
              MaxMod    := MaxInt64 mod Number;
              MaxModSet := True;
            end;
          Value.AsInt64 := ((Value.AsInt64 - MaxInt64) mod Number) + MaxMod;
        end;
      if (Value.AsInt64 > Number) then
        Value.AsInt64 := Value.AsInt64 mod Number;
    end; {MulMod}

  begin {SPPTest}
    Value.AsInt64 := Base;
    C := A;
    D := B;
    repeat
      SqrMod;
      if D > Cardinal(MaxInt) then
        Value.AsInt64 := (Value.AsInt64 * Base) mod Number;
      D := D shl 1;
      Dec(C);
    until D = 0;
    if Value.LoInt = 1 then
      Result := True
    else
      begin
        N := Number - 1;
        repeat
          if Cardinal(Value.LoInt) = N then
            begin
              Result := True; Exit;
            end;
          Dec(C);
          if C <= 0 then
            begin
              Result := False; Exit;
            end;
          SqrMod;
        until Cardinal(Value.LoInt) = 1;
        Result := False;
      end;
  end; {SPPTest}

begin
  if Number > 10 then
    begin
      Result := False;
      if Odd(Number) then
        begin
          K := Number;
          K := (K shr 16) + (K and $FFFF);
          K := (K shr  8) + (K and   $FF);
          K := (K shr  4) + (K and    $F);
          if ModTable[K] then
            Exit; {Number MOD 3 = 0 or Number MOD 5 = 0}
          if Number > 1637 * 1637 then
            begin
              for K := 0 to 255 do
                begin
                  P := PrimeNumbers[K];
                  if Number mod P = 0 then Exit;
                end;
              A := 32;
              B := Number - 1;
              repeat
                Dec(A);
                Done := B > Cardinal(MaxInt);
                B := B shl 1;
              until Done;
              MaxModSet := False;
              if Number < 9080191 then
                begin
                  if SPPTest(31) then
                    Result := SPPTest(73);
                end
              else
                if SPPTest(2) then
                  if SPPTest(7) then
                    Result := SPPTest(61);
            end
          else
            begin
              J := round(sqrt(Number));
              for K := 0 to 255 do
                begin
                  P := PrimeNumbers[K];
                  if J < P then
                    begin
                      Result := True; Exit;
                    end;
                  if Number mod P = 0 then Exit;
                end;
              Result := True;
            end;
        end;
    end
  else
    Result := Number in [2,3,5,7];
end;

//Fully Validated across Whole Cardinal Range
function IsPrime_JOH_IA32_6(Number : Cardinal) : Boolean;
const {Size = 364 Bytes + 144 Byte Tables = 508 Bytes}
  LowPrimes : packed array[1..16] of Byte = {Excludes 2,3,5}
    (7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67);
  InversePrimes  : array[1..16] of Cardinal = {Primes[I]^-1 MOD 2^32}
   ($B6DB6DB7,$BA2E8BA3,$C4EC4EC5,$F0F0F0F1,$286BCA1B,$E9BD37A7,$4F72C235,
    $BDEF7BDF,$914C1BAD,$C18F9C19,$2FA0BE83,$677D46CF,$8C13521D,$A08AD8F3,
    $C10C9715,$07A44C6B);
  ModTable : packed array[0..61] of Byte = {Lookup for Mod(3) and Mod(5) Test}
    (0,1,1,0,1,0,0,1,1,0,0,1,0,1,1,0,1,1,0,1,0,0,1,1,0,0,1,0,1,1,0,
     1,1,0,1,0,0,1,1,0,0,1,0,1,1,0,1,1,0,1,0,0,1,1,0,0,1,0,1,1,0,1);
  TableSize = SizeOf(LowPrimes);
  MaxTablePrime = 67;
asm
  test  eax, 1                  {Check for Even Number}
  jz    @@Even                  {Exit of Even}
  cmp   eax, 7                  {Check if Number <= 7}
  jbe   @@SmallOdd              {Check Low Odd Numbers}
  mov   ecx, eax                {Save Number}
  mov   edx, eax
  shr   eax, 16
  and   edx, $FFFF
  add   eax, edx
  mov   edx, eax
  shr   eax, 8
  and   edx, $FF
  add   eax, edx
  mov   edx, eax
  shr   eax, 4
  and   edx, $F
  movzx eax, byte ptr [ModTable+eax+edx]
  test  eax, eax
  jz    @@Exit                  {Number MOD 3 = 0 or Number MOD 5 = 0}
  mov   eax, ecx                {Restore Number}
  push  ebx                     {Save Used Registers}
  push  ebp
  push  edi
  push  esi
  mov   ebx, eax                {Keep Number in EBX}
  mov   ecx, -TableSize         {Set-Up Prime Table Lookup}
  mov   esi, offset LowPrimes + TableSize
  mov   edi, offset InversePrimes + TableSize*4
  cmp   eax, MaxTablePrime * MaxTablePrime
  ja    @@LargeLoop             {Large if Number > Max Table Value Squared}
  push  eax
  fild  dword ptr [esp]
  fsqrt
  fistp dword ptr [esp]
  pop   ebp                     {EBP = Sqrt(Number)}
@@SmallLoop:                    {Test Small Value against Lookup Table}
  movzx edx, byte ptr [esi+ecx]
  cmp   edx, ebp
  ja    @@SetResult
  mov   eax, ebx
  imul  eax, [edi+ecx*4]
  inc   ecx
  mul   edx
  jc    @@SmallLoop
@@False:
  xor   edx, edx
@@SetResult:
  setnz al
@@Done:
  pop   esi                     {Restore Used Registers}
  pop   edi
  pop   ebp
  pop   ebx
@@Exit:
  ret
@@Even:                         {Even Number - Only Prime if Number = 2}
  cmp   eax, 2
  sete  al
  ret
@@SmallOdd:                     {Small Odd Number - Prime if Number <> 1}
  dec   eax
  setne al
  ret
@@LargeLoop:                    {Large Number}
  mov   eax, ebx
  movzx edx, byte ptr [esi+ecx]
  imul  eax, [edi+ecx*4]
  mul   edx
  jnc   @@False
  inc   ecx
  jnz   @@LargeLoop
  lea   ebp, [ebx-1]
  bsf   ecx, ebp
  dec   ecx
  shr   ebp, 2
  shr   ebp, cl
  push  ecx
  cmp   ebx, 267859
  jae   @@CheckLarge
  cmp   ebx, 16229
  je    @@LargeDone
  mov   eax, 227206             {Use 1 SPP Test}
  call  @@SPPTest
  jmp   @@LargeDone
@@CheckLarge:
  cmp   ebx, 64042903
  jae   @@VeryLarge
  mov   eax, 4923               {Use 2 SPP Tests}
  call  @@SPPTestSmallBase
  jc    @@LargeDone
  mov   eax, 463
  jmp   @@LastSPPTestSmall
@@VeryLarge:                    {Use 3 SPP Tests}
  mov   eax, 2
  call  @@SPPTestSmallBase
  jc    @@LargeDone
  mov   eax, 7
  call  @@SPPTestSmallBase
  jc    @@LargeDone
  mov   eax, 61
@@LastSPPTestSmall:
  call  @@SPPTestSmallBase
@@LargeDone:
  setnc al
  add   esp, 4
  jmp   @@Done

@@SPPTest: {Entry Point where Base^2 could be > Number}
  mov   ecx, ebp
  mov   esi, eax
  mov   edi, eax
  jmp   @@SPPEven
@@SPPTestSmallBase: {Entry Point where Base^2 < Number - Skip First DIV}
  mov   ecx, ebp
  mov   esi, eax
  mul   eax
  mov   edi, eax
  jmp   @@SPPCheck
@@SPPLoop1:
  jnc   @@SPPEven
  mov   eax, esi
  mul   edi
  jc    @@DoDiv1
  cmp   eax, ebx
  mov   esi, eax
  jna   @@SppEven
@@DoDiv1:
  div   ebx
  mov   esi, edx
@@SPPEven:
  mov   eax, edi
  mul   edi
  jc    @@DoDiv2
  cmp   eax, ebx
  mov   edi, eax
  jna   @@SppCheck
@@DoDiv2:
  div   ebx
  mov   edi, edx
@@SPPCheck:
  shr   ecx, 1
  jnz   @@SPPLoop1
  mov   eax, esi
  mul   edi
  div   ebx
  cmp   edx, 1
  je    @@SppExit
  lea   edi, [ebx-1]
  mov   ecx, [esp+4]
@@SPPLoop2:
  cmp   edx, edi
  je    @@SppExit
  mov   eax, edx
  mul   edx
  div   ebx
  sub   ecx, 1
  jnc   @@SPPLoop2
@@SPPExit:
end;

//Fully Validated across Whole Cardinal Range
function IsPrime_JOH_IA32_8(Number: Cardinal): Boolean;
const {Size = 488 Bytes + 224 Byte Lookup Tables = 712 Bytes}
  LowPrimes: packed array[1..32] of Byte = {Excludes 2,3,5}
    (7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,
     79,83,89,97,101,103,107,109,113,127,131,137,139,149);
  InversePrimes: packed array[1..32] of Cardinal = {Primes[I]^-1 MOD 2^32}
   ($B6DB6DB7,$BA2E8BA3,$C4EC4EC5,$F0F0F0F1,$286BCA1B,$E9BD37A7,$4F72C235,
    $BDEF7BDF,$914C1BAD,$C18F9C19,$2FA0BE83,$677D46CF,$8C13521D,$A08AD8F3,
    $C10C9715,$07A44C6B,$E327A977,$C7E3F1F9,$613716AF,$2B2E43DB,$FA3F47E9,
    $5F02A3A1,$7C32B16D,$D3431B57,$8D28AC43,$DA6C0965,$0FDBC091,$EFDFBF7F,
    $C9484E2B,$077975B9,$70586723,$8CE2CABD);
  ModTable: packed array[0..61] of Byte = {Lookup for Mod(3) and Mod(5) Test}
    (0,1,1,0,1,0,0,1,1,0,0,1,0,1,1,0,1,1,0,1,0,0,1,1,0,0,1,0,1,1,0,
     1,1,0,1,0,0,1,1,0,0,1,0,1,1,0,1,1,0,1,0,0,1,1,0,0,1,0,1,1,0,1);
  TableSize = SizeOf(LowPrimes);
  MaxTablePrime = 149;
asm
  test  al, 1                   {Check for Even Number}
  jz    @@Even                  {Exit of Even}
  cmp   eax, 7                  {Check if Number <= 7}
  mov   ecx, eax                {Save Number}
  jbe   @@SmallOdd              {Check Low Odd Number (1,3,5)}
  mov   edx, eax
  shr   eax, 16
  and   edx, $FFFF
  add   eax, edx
  mov   edx, eax
  shr   eax, 8
  and   edx, $FF
  add   eax, edx
  mov   edx, eax
  shr   eax, 4
  and   edx, $0F
  movzx eax, byte ptr [ModTable+eax+edx]
  test  eax, eax
  jz    @@Exit                  {N MOD 3 = 0 or N MOD 5 = 0}
  push  ebx                     {Save Used Registers}
  push  ebp
  push  edi
  push  esi
  mov   ebx, ecx                {Keep Number in EBX}
  mov   ecx, -TableSize         {Set-Up Prime Table Lookup}
  cmp   ebx, MaxTablePrime * MaxTablePrime
  mov   esi, offset LowPrimes + TableSize
  mov   edi, offset InversePrimes + TableSize*4
  ja    @@LargeLoop             {N > Max Table Value Squared}
  push  ebx
  fild  dword ptr [esp]
  fsqrt
  fistp dword ptr [esp]
  pop   ebp                     {EBP = Sqrt(N)}
@@SmallLoop:                    {Test Small Value against Lookup Table}
  movzx edx, byte ptr [esi+ecx]
  cmp   edx, ebp
  mov   eax, ebx
  ja    @@SetResult
  imul  eax, [edi+ecx*4]
  inc   ecx
  mul   edx
  jc    @@SmallLoop
  jmp   @@False
@@Even:                         {Even Number - Prime if Number = 2}
  cmp   eax, 2
  sete  al
  ret
@@SmallOdd:                     {Small Odd Number - Prime if Number <> 1}
  dec   eax
  setne al
  ret
@@SetFalse:
  add   esp, 24                 {Dump Return Addess and Saved Values}
@@False:
  xor   eax, eax                {Set Zero Flag}
@@SetResult:
  setnz al                      {Result = NOT(Zero Flag)}
@@Done:
  pop   esi                     {Restore Used Registers}
  pop   edi
  pop   ebp
  pop   ebx
@@Exit:
  ret
@@LargeLoop:                    {Large Number}
  mov   eax, ebx
  movzx edx, byte ptr [esi+ecx]
  imul  eax, [edi+ecx*4]
  mul   edx
  jnc   @@False
  inc   ecx
  jnz   @@LargeLoop

  imul  eax, ebx                {Set U = -N^-1 mod 2^32}
  sub   eax, 2                               
  imul  eax, ebx
  mov   edx, eax
  imul  eax, ebx
  add   eax, 2
  imul  eax, edx
  mov   edx, eax
  imul  eax, ebx
  add   eax, 2
  imul  eax, edx
  mov   ebp, eax
  imul  ebp, ebx
  add   ebp, 2
  imul  ebp, eax                {U = -N^-1 mod 2^32}

  mov   edi, ebx
  mov   eax, ebx
  dec   edi
  neg   eax
  bsf   ecx, edi                {Set Bits Remaining}
  mul   eax
  push  ecx                     {Save Bits Remaining}
  mov   esi, eax
  bsr   ecx, edi
  mov   eax, edx
  xor   edx, edx
  neg   ecx
  div   ebx
  mov   eax, esi
  add   ecx, 32
  div   ebx
  shl   edi, cl
  mov   eax, edx
  imul  eax, ebp
  mov   esi, edx                {C = -N^2 mod N, to fast convert}
  mul   ebx                     {  into montgomery domain}
  add   eax, esi
  adc   edx, 0
  push  esi                     {Save C}
  push  edx                     {Save +1 in montgomery}
  push  edi                     {Save Bit Mask Exponent}
  neg   edx
  add   edx, ebx                {-1 in montgomery} 
  cmp   ebx, 267859
  push  edx                     {Save -1 in montgomery}
  mov   eax, 227206
  jb    @@LastSPPTest           {N < 267859, Use 1 SPP Test}
@@Large:
  cmp   ebx, 64042903
  jae   @@VeryLarge
  mov   eax, 4923               {N < 64042903, Use 2 SPP Tests}
  call  @@SPPTest
  mov   eax, 463
  jmp   @@LastSPPTest
@@VeryLarge:                    {N >= 64042903, Use 3 SPP Tests}
  mov   eax, 2
  call  @@SPPTest
  mov   eax, 7
  call  @@SPPTest
  mov   eax, 61
@@LastSPPTest:
  call  @@SPPTest
  add   esp, 20                 {Dump Saved Values and Clear Zero Flag}
  jmp   @@SetResult

@@SPPTest: {Jumps to SetFalse if Non-Prime (Does Not Return)}
  mul   [esp+16]                {Set Base = Base * C mod N}
  mov   edi, eax
  imul  eax, ebp
  mov   esi, edx
  mul   ebx
  add   eax, edi
  adc   edx, esi                {Base = Base * C mod N}
  mov   ecx, [esp+8]            {Bit Mask of Exponent N -1}
  mov   eax, edx
  push  edx                     {Save Base}
@@SPPLoop1:
  mul   eax                     {Set X = X^2 mod N}
  mov   edi, eax
  imul  eax, ebp
  mov   esi, edx
  mul   ebx
  add   eax, edi
  adc   edx, esi                {X = X^2 mod N}
  mov   eax, edx
  sbb   edx, edx
  and   edx, ebx
  sub   eax, edx
  add   ecx, ecx
  jnc   @@SPPCheck
  mul   [esp]                   {Set X = X * Base mod N}
  mov   edi, eax
  imul  eax, ebp
  mov   esi, edx
  mul   ebx
  add   eax, edi
  adc   edx, esi                {X = X * Base mod N}
  mov   eax, edx
  sbb   edx, edx
  and   edx, ebx
  sub   eax, edx
  test  ecx, ecx
@@SPPCheck:
  jnz   @@SPPLoop1              {Bits Remaining}
  pop   ecx                     {Dump Saved Base}
  sub   eax, ebx
  sbb   ecx, ecx
  and   ecx, ebx
  add   eax, ecx
  cmp   eax, [esp+12]           {eax = +1(montgomery)?}
  mov   ecx, [esp+20]           {Ramaining Bits}
  je    @@SPPTrue               {True if eax = +1(montgomery)}
@@SPPLoop2:
  cmp   eax, [esp+4]            {eax = -1(montgomery)?}
  je    @@SPPTrue               {True if eax = -1(montgomery)}
  dec   ecx                     {Ramaining Bits}
  jz    @@SetFalse              {False if No Bits Remaining}
  mul   eax                     {Set X = X^2 mod N}
  mov   edi, eax
  imul  eax, ebp
  mov   esi, edx
  mul   ebx
  add   eax, edi
  adc   edx, esi                {X = X^2 mod N}
  sbb   edi, edi
  cmp   edx, ebx
  sbb   eax, eax
  not   eax
  or    edi, eax
  and   edi, ebx
  sub   edx, edi
  cmp   edx, [esp+12]           {edx = +1(montgomery)?}
  mov   eax, edx
  jne   @@SPPLoop2              {Loop if edx <> +1(montgomery)}
  jmp   @@SetFalse
@@SPPTrue:
end;

end.
