unit IsPrimeHRUnit;

interface

function IsPrime_HR_IA32_1(N: Cardinal): Boolean;
function IsPrime_HR_IA32_2(N: Cardinal): Boolean;
procedure IsPrimeHR_Size;

implementation

uses SysUtils, Dialogs;

{ Copyright c 2003 by Hagen Reddmann, public domain. }

{$DEFINE SmallLookup}
{$IFDEF SmallLookup}
// Tablesize = 160 bytes
const
  MaxPrime = 137;
  MaxTrial = MaxPrime * MaxPrime; // maximal trial div bounds
  MinPrime = 137;                 // trial div bounds if N >= MaxTrial, must be <= MaxPrime
  Primes: array[0..31] of Byte =
   (   3,   5,   7,  11,  13,  17,  19,  23,  29,  31,  37,  41,  43,  47,  53,  59,
      61,  67,  71,  73,  79,  83,  89,  97, 101, 103, 107, 109, 113, 127, 131, 137);

  InvPrimes: array[0..31] of Cardinal =  // InvPrimes[i] = Primes[i]^-1 mod 2^32
   ($AAAAAAAB,$CCCCCCCD,$B6DB6DB7,$BA2E8BA3,$C4EC4EC5,$F0F0F0F1,$286BCA1B,$E9BD37A7,
    $4F72C235,$BDEF7BDF,$914C1BAD,$C18F9C19,$2FA0BE83,$677D46CF,$8C13521D,$A08AD8F3,
    $C10C9715,$07A44C6B,$E327A977,$C7E3F1F9,$613716AF,$2B2E43DB,$FA3F47E9,$5F02A3A1,
    $7C32B16D,$D3431B57,$8D28AC43,$DA6C0965,$0FDBC091,$EFDFBF7F,$C9484E2B,$077975B9);

{$ELSE}
// Tablesize = 510 bytes, get small speedup compared to above lookup tables.
// The speedup are ~100 cycles with small numbers < 1000000, and over full 2^32 range
// are few cycles slower. Thus it's not worth to activate big lookup tables.
// Currently on Dennis testcases the big lookup tables are faster.
const
  MaxPrime = 443;
  MaxTrial = MaxPrime * MaxPrime;
  MinPrime = 173;
  Primes: array[0..84] of Word =
   (   3,   5,   7,  11,  13,  17,  19,  23,  29,  31,  37,  41,  43,  47,  53,  59,
      61,  67,  71,  73,  79,  83,  89,  97, 101, 103, 107, 109, 113, 127, 131, 137,
     139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227,
     229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313,
     317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419,
     421, 431, 433, 439, 443);

  InvPrimes: array[0..84] of Cardinal =  // InvPrimes[i] = Primes[i]^-1 mod 2^32
   ($AAAAAAAB,$CCCCCCCD,$B6DB6DB7,$BA2E8BA3,$C4EC4EC5,$F0F0F0F1,$286BCA1B,$E9BD37A7,
    $4F72C235,$BDEF7BDF,$914C1BAD,$C18F9C19,$2FA0BE83,$677D46CF,$8C13521D,$A08AD8F3,
    $C10C9715,$07A44C6B,$E327A977,$C7E3F1F9,$613716AF,$2B2E43DB,$FA3F47E9,$5F02A3A1,
    $7C32B16D,$D3431B57,$8D28AC43,$DA6C0965,$0FDBC091,$EFDFBF7F,$C9484E2B,$077975B9,
    $70586723,$8CE2CABD,$BF937F27,$2C0685B5,$451AB30B,$DB35A717,$0D516325,$D962AE7B,
    $10F8ED9D,$EE936F3F,$90948F41,$3D137E0D,$EF46C0F7,$6E68575B,$DB43BB1F,$9BA144CB,
    $478BBCED,$1FDCD759,$437B2E0F,$10FEF011,$9A020A33,$FF00FF01,$70E99CB7,$6205B5C5,
    $A27ACDEF,$25E4463D,$0749CB29,$C9B97113,$84CE32AD,$C74BE1FB,$A7198487,$39409D09,
    $6F71DE15,$BFCE8063,$F61FE7B1,$70E046D3,$F1545AF5,$9A7862A1,$2A128A57,$B7747D8F,
    $BB5E06DD,$12E9B5B3,$EC9DBE7F,$EC41CF4D,$AEC02945,$8382DF71,$84B1C2A9,$75EB3A0B,
    $FA86FE2D,$3F8DF54F,$0975A751,$C3EFAC07,$A8299B73);
{$ENDIF}

function IsPrime_HR_IA32_1(N: Cardinal): Boolean;
// normal domain with divisions in modular exponentation
asm
       TEST   AL,1
       JZ     @@0                              // even ??
       CMP    EAX,7
       JA     @@1                              // > 7 ??
       DEC    EAX
       SETNZ  AL
       RET

@@0:   CMP    EAX,2                            // even numbers
       SETZ   AL
       RET

@@1:   PUSH   EBP                              // do trial divsion to small primes
       PUSH   EBX
       PUSH   ESI
       PUSH   EDI

       MOV    EBX,EAX
       CMP    EAX,MaxTrial
       MOV    EBP,MinPrime
       JAE    @@2

       PUSH   EAX
       FILD   DWord Ptr [ESP]
       FSQRT
       FISTP  DWord Ptr [ESP]
       POP    EBP                              // EBP = Sqrt(N)

@@2:   MOV    EDI,Offset Primes
       MOV    ESI,Offset InvPrimes
       XOR    ECX,ECX

{$IFDEF SmallLookup}
@@3:   MOVZX  EDX,Byte Ptr [EDI + ECX]        // take care, InvPrimes[] MUST
{$ELSE}                                       // be after Primes[] declared
@@3:   MOVZX  EDX,Word Ptr [EDI + ECX * 2]
{$ENDIF}
       MOV    EAX,EBX
       CMP    EDX,EBP
       JA     @@5
       IMUL   EAX,[ESI + ECX * 4]
       INC    ECX
       MUL    EDX
       JC     @@3
       TEST   EDX,EDX
@@4:   POP    EDI
       POP    ESI
       POP    EBX
       POP    EBP
       SETNZ  AL
       RET

@@5:   CMP    EBX,MaxTrial                     // N <= MaxPrime^2 ??
       JBE    @@4

       MOV    EAX,EBX
       LEA    ESI,[EBX -1]                     // N -1, exponent

       MOV    ECX,32
@@6:   ADD    ESI,ESI                          // compute bits in exponent
       DEC    ECX
       JNC    @@6
       PUSH   ESI

       CMP    EAX,$08A8D7F                     // N < $08A8D7F, do SPP to bases 31,73
       MOV    EBP,ECX
       JAE    @@7
       MOV    EAX,31
       CALL   @@A
       MOV    EAX,73
       PUSH   Offset @@8
       JMP    @@A

@@7:   MOV    EAX,2                            // do SPP to bases 2,7,61
       CALL   @@A
       MOV    EAX,7
       CALL   @@A
       MOV    EAX,61
       CALL   @@A

@@8:   INC    EAX
@@9:   POP    ESI
       JMP    @@4

@@A:   MOV    ESI,[ESP +4]                     // Strong Pseudo Primality Test
       MOV    ECX,EBP
       MOV    EDI,EAX
@@B:   DEC    ECX
       MUL    EAX
       DIV    EBX
       ADD    ESI,ESI
       MOV    EAX,EDX
       JNC    @@C
       MUL    EDI
       DIV    EBX
       TEST   ESI,ESI
       MOV    EAX,EDX
@@C:   JNZ    @@B
       DEC    EAX
       LEA    EDI,[EBX -2]
       MOV    EDX,EAX
       JZ     @@F                               // +1
@@D:   CMP    EDX,EDI
       JE     @@F                               // -1
       DEC    ECX
       LEA    EAX,[EDX +1]
       JNG    @@E
       MUL    EAX
       DIV    EBX
       DEC    EDX
       JNZ    @@D                               // <> +1
@@E:   POP    ECX
       JMP    @@9
@@F:
end;

function IsPrime_HR_IA32_2(N: Cardinal): Boolean;
// Montgomery Version of IsPrimeHR_IA32_1()
asm
       TEST   AL,1
       JZ     @@0                          // even ??
       CMP    EAX,7
       JA     @@1                          // > 7 ??
       DEC    EAX
       SETNZ  AL
       RET

@@0:   CMP    EAX,2                        // even numbers
       SETZ   AL
       RET

@@1:   PUSH   EBP                          // do trial divsion to small primes
       PUSH   EBX
       PUSH   ESI
       PUSH   EDI

       MOV    EBX,EAX
       CMP    EAX,MaxTrial
       MOV    EBP,MinPrime
       JAE    @@2

       PUSH   EAX
       FILD   DWord Ptr [ESP]
       FSQRT
       FISTP  DWord Ptr [ESP]
       POP    EBP                          // EBP = Sqrt(N)

@@2:   MOV    EDI,Offset Primes
       MOV    ESI,Offset InvPrimes
       XOR    ECX,ECX
{$IFDEF SmallLookup}
@@3:   MOVZX  EDX,Byte Ptr [EDI + ECX]     // take care, InvPrimes[] MUST
{$ELSE}                                    // be after Primes[] declared
@@3:   MOVZX  EDX,Word Ptr [EDI + ECX * 2]
{$ENDIF}
       MOV    EAX,EBX
       CMP    EDX,EBP
       JA     @@5
       IMUL   EAX,[ESI + ECX * 4]
       INC    ECX
       MUL    EDX
       JC     @@3
       TEST   EDX,EDX
@@4:   POP    EDI
       POP    ESI
       POP    EBX
       POP    EBP
       SETNZ  AL
       RET

@@5:   CMP    EBX,MaxTrial                 // N <= MaxPrime^2 ??
       MOV    EAX,EBX
       JBE    @@4

       IMUL   EAX,EBX                      // compute domain param U = -N^-1 mod 2^32
       SUB    EAX,2                        // Lookuptable can reduce from 72 donwto 32 cycles
       IMUL   EAX,EBX
       MOV    EDX,EAX
       IMUL   EAX,EBX
       ADD    EAX,2
       IMUL   EAX,EDX
       MOV    EDX,EAX
       IMUL   EAX,EBX
       ADD    EAX,2
       IMUL   EAX,EDX
       MOV    EBP,EAX
       IMUL   EBP,EBX
       ADD    EBP,2
       IMUL   EBP,EAX                      // U = -N^-1 mod^2^32 in EBP

       MOV    EDI,EBX
       MOV    EAX,EBX
       DEC    EDI                          // N -1
       NEG    EAX
       BSF    ECX,EDI
       MUL    EAX
       PUSH   ECX                          // bits remain         [ESP + 20]
       MOV    ESI,EAX
       BSR    ECX,EDI
       MOV    EAX,EDX
       XOR    EDX,EDX
       NEG    ECX
       DIV    EBX                          // div, can't be removed
       MOV    EAX,ESI
       ADD    ECX,32
       DIV    EBX                          // div
       SHL    EDI,CL
       MOV    EAX,EDX
       IMUL   EAX,EBP
       MOV    ESI,EDX                      // C = -N^2 mod N, to fast convert into
       MUL    EBX                          // montgomery domain
       PUSH   ESI                          // C                    [ESP + 16]
       ADD    EAX,ESI
       ADC    EDX,0

       PUSH   EDX                          // +1 in montgomery     [ESP + 12]
       PUSH   EDI                          // bit mask exponent    [ESP +  8]
       NEG    EDX
       ADD    EDX,EBX

       CMP    EBX,$08A8D7F                 // N < $08A8D7F, do SPP to bases 31,73
       PUSH   EDX                          // -1 in montgomery     [ESP +  4]
       JAE    @@6
       MOV    EAX,31
       CALL   @@9
       MOV    EAX,73
       PUSH   Offset @@7
       JMP    @@9

@@6:   MOV    EAX,2                        // do SPP to bases 2,7,61
       CALL   @@9
       MOV    EAX,7
       CALL   @@9
       MOV    EAX,61
       CALL   @@9

@@7:   INC    EAX
@@8:   LEA    ESP,[ESP + 4 * 5]            // don't change flags !!
       JMP    @@4

@@9:   MUL    DWord Ptr [ESP + 16]         // convert base in montgomery
       MOV    EDI,EAX                      // Base' = Base * C mod N
       IMUL   EAX,EBP                      // montgomery REDC
       MOV    ESI,EDX
       MUL    EBX
       ADD    EAX,EDI
       ADC    EDX,ESI
       MOV    ECX,[ESP + 8]                // bit mask of exponent N -1
       MOV    EAX,EDX
       PUSH   EDX

@@A:   MUL    EAX                          // X = X^2 mod N
       MOV    EDI,EAX
       IMUL   EAX,EBP
       MOV    ESI,EDX
       MUL    EBX
       ADD    EAX,EDI
       ADC    EDX,ESI
       JNC    @@B
       SUB    EDX,EBX
@@B:   ADD    ECX,ECX
       MOV    EAX,EDX
       JNC    @@D
       MUL    DWord Ptr [ESP]              // X = X * Base mod N
       MOV    EDI,EAX
       IMUL   EAX,EBP
       MOV    ESI,EDX
       MUL    EBX
       ADD    EAX,EDI
       ADC    EDX,ESI
       JNC    @@C
       SUB    EDX,EBX
@@C:   TEST   ECX,ECX
       MOV    EAX,EDX
@@D:   JNZ    @@A
       CMP    EAX,EBX
       JB     @@E
       SUB    EAX,EBX
@@E:   CMP    EAX,[ESP + 16]               // == +1 ??
       MOV    ECX,[ESP + 24]               // bits remain
       JE     @@J
@@F:   CMP    EAX,[ESP + 8]                // == -1 ??
       JE     @@J
       DEC    ECX
       JNG    @@I
       MUL    EAX
       MOV    EDI,EAX
       IMUL   EAX,EBP
       MOV    ESI,EDX
       MUL    EBX
       ADD    EAX,EDI
       ADC    EDX,ESI
       JC     @@G
       CMP    EDX,EBX
       JB     @@H
@@G:   SUB    EDX,EBX
@@H:   CMP    EDX,[ESP + 16]               // <> +1 ??
       MOV    EAX,EDX
       JNE    @@F
@@I:   ADD    ESP,8
       XOR    EAX,EAX
       JMP    @@8
@@J:   POP    EDX
end;


function IsPrimeHR_IA32_1_Size: Integer;
begin
  Result := PChar(@IsPrime_HR_IA32_2) - PChar(@IsPrime_HR_IA32_1);
  Inc(Result, SizeOf(Primes) + SizeOf(InvPrimes));
end;

function IsPrimeHR_IA32_2_Size: Integer;
begin
  Result := PChar(@IsPrimeHR_IA32_1_Size) - PChar(@IsPrime_HR_IA32_2);
  Inc(Result, SizeOf(Primes) + SizeOf(InvPrimes));
end;

procedure IsPrimeHR_Size;
begin
  ShowMessage(Format('IsPrimeHR_IA32_1: %d'#13#10'IsPrimeHR_IA32_2: %d',
    [IsPrimeHR_IA32_1_Size, IsPrimeHR_IA32_2_Size]));
end;

end.
