unit IsPrimeDKCUnit;

interface

function IsPrimeDKCPas3(Number : Cardinal) : Boolean;
function IsPrime_DKC_Pas_23(Number : Cardinal) : Boolean;
function IsPrime_DKC_Pas_24(Number : Cardinal) : Boolean;
function IsPrime_DKC_Pas_25(Number : Cardinal) : Boolean;
function IsPrime_DKC_Pas_26(Number : Cardinal) : Boolean;
function IsPrime_DKC_Pas_27(Number : Cardinal) : Boolean;
function IsPrime_DKC_IA32_9(Number : Cardinal) : Boolean;
function IsPrime_DKC_SSE_1(Number : Cardinal) : Boolean;
function IsPrime_DKC_SSE_2(Number : Cardinal) : Boolean;
function IsPrime_DKC_SSE_3(Number : Cardinal) : Boolean;
function IsPrime_DKC_SSE_4(Number : Cardinal) : Boolean;
function IsPrime_DKC_SSE_5(Number : Cardinal) : Boolean;
function IsPrime_DKC_SSE_6(Number : Cardinal) : Boolean;
function IsPrime_DKC_SSE_7(Number : Cardinal) : Boolean;
function StrongProbablePrimeJOH(Number, Base: Cardinal): Boolean;
function StrongProbablePrimeDKCPas1(Number, Base: Cardinal): Boolean;

implementation

uses
 Math, MainUnit, SysUtils;

var
 PrimeTable : array of Cardinal;

const
 NoOfPrimesWanted : Cardinal = 43;

function MulModAsm1(X, Y, M: Cardinal) : Cardinal;
asm
 mul edx
 div ecx
 mov eax,edx
end;

function IntPowerMod32(Base, Exponent, Divisor : Cardinal) : Cardinal;
var
 I, I2, I3 : Cardinal;
 Result1, Result2 : Cardinal;

begin
 Result1 := Base;
 Result2 := 1;
 I := 2;
 I2 := Exponent;
 repeat
  I3 := I2 and 1;
  if I3 = 1 then
   Result2 := MulModAsm1(Result2, Result1, Divisor);
  I2 := I2 shr 1;
  Result1 := MulModAsm1(Result1, Result1, Divisor);
  I := I * 2;
 until(I > Exponent);
 Result := MulModAsm1(Result1, Result2, Divisor);
end;

function IntPowerMod64(Base, Exponent, Divisor : Cardinal) : Cardinal;
var
 I2, I3 : Cardinal;
 I, Result1, Result2, Divisor64 : Int64;

begin
 Result1 := Base;
 Result2 := 1;
 I := 2;
 I2 := Exponent;
 Divisor64 := Divisor;
 repeat
  I3 := I2 and 1;
  if I3 = 1 then
   Result2 := (Result2 * Result1) mod Divisor64;
  I2 := I2 shr 1;
  Result1 := (Result1 * Result1) mod Divisor64;
  I := I * 2;
 until(I > Exponent);
 Result := (Result1 * Result2) mod Divisor64;
end;

//Author:            Dennis Kjaer Christensen
//Date:              17/12 2003
//Instructionset(s): IA32

function IntPowerMod64FP(Base, Exponent, Divisor : Cardinal) : Cardinal;
var
 I1, I2, I3, HalfExponent : Cardinal;
 Result1FP, Result2FP, DivisorFP : Extended;

begin
 Result1FP := Base;
 Result2FP := 1;
 DivisorFP := Divisor;
 I1 := 2;
 I2 := Exponent;
 HalfExponent := Exponent div 2;
 repeat
  I3 := I2 and 1;
  if I3 = 1 then
   begin
    Result2FP := (Result2FP * Result1FP) - DivisorFP *(Trunc((Result2FP * Result1FP) / DivisorFP));
   end;
  I2 := I2 shr 1;
  Result1FP := (Result1FP * Result1FP) - DivisorFP * Trunc((Result1FP * Result1FP) / DivisorFP);
  if I1 > HalfExponent then
   Break;
  I1 := I1 * 2;
 until(False);
 Result := Round((Result1FP * Result2FP) - DivisorFP * Trunc((Result1FP * Result2FP) / DivisorFP));
end;

//Author:            Dennis Kjaer Christensen
//Date:              26/4 2004
//Instructionset(s): IA32

function IntPowerMod64FP2(Base, Exponent, Divisor : Cardinal) : Cardinal;
var
 I1, I2, I3, HalfExponent : Cardinal;
 Result1FP, Result2FP, DivisorFP : Extended;

begin
 Result1FP := Base;
 Result2FP := 1;
 DivisorFP := Divisor;
 I1 := 2;
 I2 := Exponent;
 HalfExponent := Exponent div 2;
 repeat
  I3 := I2 and 1;
  if I3 = 1 then
   begin
    Result2FP := (Result2FP * Result1FP) - DivisorFP *(Trunc((Result2FP * Result1FP) / DivisorFP));
   end;
  I2 := I2 shr 1;
  Result1FP := (Result1FP * Result1FP) - DivisorFP * Trunc((Result1FP * Result1FP) / DivisorFP);
  if I1 > HalfExponent then
   Break;
  I1 := I1 * 2;
 until(False);
 Result := Round((Result1FP * Result2FP) - DivisorFP * Trunc((Result1FP * Result2FP) / DivisorFP));
end;

//Author:            Dennis Kjaer Christensen
//Date:              23/10 2003
//Instructionset(s): IA32

function IsPrimeDKCPas3(Number : Cardinal) : Boolean;
var
 I, Reminder, SqrtNumber : Cardinal;

begin
 Result := True;
 if Number = 0 then
  Result := False
 else if Number = 1 then
  Result := False
 else if Number > 0 then
  begin
   SqrtNumber := Round(Sqrt(Number));
   for I := 2 to SqrtNumber do
    begin
     Reminder := Number mod I;
     if Reminder = 0 then
      begin
       Result := False;
       Break;
      end;
    end;
  end
end;

//Author:            Dennis Kjaer Christensen
//Date:              27/11 2003
//Instructionset(s): IA32

function StrongProbablePrimeDKCPas1(Number, Base: Cardinal): Boolean;
var
 d,b,s,i,v,q,w : Cardinal;
 b64, v64, n64 : Int64;
 X : Extended;

begin
 s := 0;
 v := Number-1;
 //Calculate m and k
 repeat
  X := IntPower(2,s);//X always an integer
  w := Round(X);
  d := v div w;
  q := v mod w;
  Inc(s);
  if s >= 33 then
   raise Exception.Create('k is to big');
 until((q = 0) and Odd(d));
 Dec(s);
 b := IntPowerMod64(Base,d,Number);
 if b = 1 then
  begin
   Result := True;
   Exit;
  end;
 b64 := b;
 v64 := Number-1;
 n64 := Number;
 for i := 1 to s do
  begin
   if b64 = v64 then
    begin
     Result := True;
     Exit;
    end
   else
    b64 := (b64*b64) mod n64;
  end;
 Result := False;
end;

//Author:            Dennis Kjaer Christensen
//Date:              16/12 2003
//Instructionset(s): IA32

function StrongProbablePrimeDKCPas3(Number, Base: Cardinal): Boolean;
var
 d, b, s, i, v : Cardinal;
 bFP, vFP, nFP : Extended;

begin
 v := Number-1;
 d := v;
 //Calculate d and s
 s := 0;
 repeat
  d := d shr 1;
  Inc(s);
 until odd(d);
 b := IntPowerMod64FP(Base,d,Number);
 if b = 1 then
  begin
   Result := True;
   Exit;
  end;
 bFP := b;
 vFP := Number-1;
 nFP := Number;
 for i := 1 to s do
  begin
   if Abs(bFP - vFP) < 0.01 then
    begin
     Result := True;
     Exit;
    end
   else
    bFP := (bFP*bFP) - Trunc((bFP*bFP) / nFP) * nFP;
  end;
 Result := False;
end;

//Author:            Dennis Kjaer Christensen
//Date:              26/4 2004
//Instructionset(s): IA32

function StrongProbablePrimeDKCPas4(Number, Base: Cardinal): Boolean;
var
 D, B, S, I, V : Cardinal;
 bFP, vFP, nFP : Extended;
const
 JUSTALITTLE : Single = 0.01;

begin
 v := Number-1;
 D := v;
 //Calculate d and s
 s := 0;
 repeat
  D := d shr 1;
  Inc(S);
 until Odd(D);
 B := IntPowerMod64FP2(Base, D, Number);
 if B = 1 then
  begin
   Result := True;
   Exit;
  end;
 bFP := B;
 vFP := Number - 1;
 nFP := Number;
 for I := 1 to S do
  begin
   if Abs(bFP - vFP) < JUSTALITTLE then
    begin
     Result := True;
     Exit;
    end
   else
    begin
     bFP := bFP * bFP - Trunc(Sqr(bFP) / nFP) * nFP;
    end;
  end;
 Result := False;
end;

//Author:            Dennis Kjaer Christensen
//Date:              18/12 2003
//Instructionset(s): IA32

function StrongProbablePrimeDKCIA32_9(Base, m, Number, k : Cardinal): Boolean;
asm
   push ebp
   push ebx
   push edi
   push esi
   push ecx
   //Result1 := Base;
   mov  ebx,eax
   //Result2 := 1;
   mov  [esp-4],1
   //I := 2;
   mov  esi,2
   //I2 := Exponent;
   mov  edi,edx
   //HalfExponent := Exponent div 2;
   mov  ebp,edi
   shr  ebp,1
 @IntPowerModRepeat :
   shr  edi,1
   jnc  @IntPowerModIfEnd1
   //Result2 := MulMod(Result2, Result1, Divisor);
   mov  eax,[esp-4]
   mul  ebx
   div  ecx
   mov  [esp-4],edx
 @IntPowerModIfEnd1 :
   //Result1 := MulMod(Result1, Result1, Divisor);
   mov  eax,ebx
   mul  ebx
   div  ecx
   mov  ebx,edx
   //if I > HalfExponent then
   cmp  esi,ebp
   jnbe @IntPowerModRepeatEnd
   add  esi,esi
   jmp  @IntPowerModRepeat
 @IntPowerModRepeatEnd :
   //Result := MulMod(Result1, Result2, Divisor);
   mov  eax,ebx
   mul  [esp-4]
   div  ecx
   pop  edi   //Pushed as ecx
   //pop  ebx
   mov  ebx,[esp+16]
   //if b = 1 then
   cmp  edx,1
   jz   @ResultTrue
 @IfEnd1 :
   //v := Number-1;
   mov  esi,edi
   sub  esi,1
   //if b = v then
   cmp  esi,edx
   jnz  @IfEnd2
 @ResultTrue :
   mov  al,1
   jmp  @Exit4
 @IfEnd2 :
   //for i := 1 to k-1 do
   add  ebx,1
 @ForStart :
   mov  eax,edx
   //b := MulMod(b, b, Number);
   mul  eax
   div  edi
   //if b = v then
   cmp  esi,edx
   jz   @ResultTrue
   sub  ebx,1
   jnz  @ForStart
 @ForEnd :
   //Result := False;
   xor  eax,eax
 @Exit4 :
   pop  esi
   pop  edi
   pop  ebx
   pop  ebp
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/12 2003
//Instructionset(s): IA32

function StrongProbablePrime_DKC_IA32_10(Base, m, Number, k : Cardinal): Boolean;
asm
   push ebx
   push edi
   push esi
   //Result1 := Base;
   mov  ebx,eax
   //Result2 := 1;
   mov  [esp-4],1
   //I := 2;
   mov  esi,2
   //I2 := Exponent;
   mov  edi,edx
   //HalfExponent := Exponent div 2;
   mov  ebp,edi
   shr  ebp,1
 @IntPowerModRepeat :
   shr  edi,1
   jnc  @IntPowerModIfEnd1
   //Result2 := MulMod(Result2, Result1, Divisor);
   mov  eax,[esp-4]
   mul  ebx
   div  ecx
   mov  [esp-4],edx
 @IntPowerModIfEnd1 :
   //Result1 := MulMod(Result1, Result1, Divisor);
   mov  eax,ebx
   mul  ebx
   div  ecx
   mov  ebx,edx
   //if I > HalfExponent then
   cmp  esi,ebp
   jnbe @IntPowerModRepeatEnd
   add  esi,esi
   jmp  @IntPowerModRepeat
 @IntPowerModRepeatEnd :
   //Result := MulMod(Result1, Result2, Divisor);
   mov  eax,ebx
   mul  [esp-4]
   div  ecx
   mov  edi,[esp+4]
   mov  ebx,[esp+12]
   //if b = 1 then
   cmp  edx,1
   jz   @ResultTrue
 @IfEnd1 :
   //v := Number-1;
   mov  esi,edi
   sub  esi,1
   //if b = v then
   cmp  esi,edx
   jnz  @IfEnd2
 @ResultTrue :
   mov  al,1
   jmp  @Exit4
 @IfEnd2 :
   //for i := 1 to k-1 do
   add  ebx,1
 @ForStart :
   mov  eax,edx
   //b := MulMod(b, b, Number);
   mul  edx
   div  edi
   //if b = v then
   cmp  esi,edx
   jz   @ResultTrue
   sub  ebx,1
   jnz  @ForStart
 @ForEnd :
   //Result := False;
   xor  eax,eax
 @Exit4 :
   pop  esi
   pop  edi
   pop  ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/3 2006
//Instructionset(s): IA32

function StrongProbablePrime_DKC_IA32_11(Number, Base: Cardinal): Boolean;
var
 D, S, V : Cardinal;

begin
 v := Number-1;
 D := v;
 //Calculate d and s
 s := 0;
 repeat
  D := d shr 1;
  Inc(S);
 until Odd(D);
 Result := StrongProbablePrime_DKC_IA32_10(Base, d, Number, s);
end;

//By John O'Harrow

function StrongProbablePrimeJOH(Number, Base: Cardinal): Boolean;
var
  d, s, i, r : Cardinal;
begin
  d := Number - 1;
  //Calculate S and d
  s := 0;
  repeat
    d := d shr 1;
    Inc(s);
  until odd(d);
  i := 1;
  r := Base;
  //Calculate i^r mod Number
  while (d > 1) do
    begin
      if Odd(d) then
        i := MulModAsm1(i, r, Number);
      d := d shr 1;
      r := MulModAsm1(r, r, Number);
    end;
  i := MulModAsm1(i, r, Number);
  d := Number - 1;
  Result := (i = 1) or (i = d);
  while (not Result) and (s > 0) do
    begin
      i := MulModAsm1(i, i, Number);  //i^2 mod Number
      Result := (i = d);          //Until i = d then Result = True and Exit
      Dec(s);
    end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/12 2003
//Instructionset(s): IA32

function IsPrimeDKCPas22(Number : Cardinal) : Boolean;
var
 SqrtNumber, Reminder1, Reminder2, J : Cardinal;
 CW8087 : Word;

begin
 if Number <= 1 then
  Result := False
 else if Number <= 3 then
  Result := True
 else if Number mod 2 = 0 then
  Result := False
 else if Number mod 3 = 0 then
  Result := False
 else if Number = 5 then
  Result := True
 else if Number mod 5 = 0 then
  Result := False
 else if Number = 7 then
  Result := True
 else if Number mod 7 = 0 then
  Result := False
 else if (Number <= 10000000) then
  begin
   Result := True;
   SqrtNumber := Round(Sqrt(Number));
   J := 7;
   repeat
    Reminder1 := Number mod J;
    Inc(J,2);
    Reminder2 := Number mod J;
    if (Reminder1 = 0) or (Reminder2 = 0) then
     begin
      Result := False;
      Break;
     end;
    Inc(J,2);
   until(J > SqrtNumber);
  end
 else
  begin
   CW8087 := Get8087CW;
   SetPrecisionMode(pmExtended);
   if StrongProbablePrimeDKCPas3(Number, 2)  and
      StrongProbablePrimeDKCPas3(Number, 61) and
      StrongProbablePrimeDKCPas3(Number, 7)  then
    begin
     Result := True;
    end
   else
    begin
     Result := False;
    end;
   Set8087CW(CW8087);
  end
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/3 2006
//Instructionset(s): IA32
//Size: 1225 + 208 = 1433

function IsPrime_DKC_Pas_23(Number : Cardinal) : Boolean;
var
 SqrtNumber, Reminder1, Reminder2, J : Cardinal;
 CW8087 : Word;

begin
 if Number <= 1 then
  Result := False
 else if Number <= 3 then
  Result := True
 else if Number mod 2 = 0 then
  Result := False
 else if Number mod 3 = 0 then
  Result := False
 else if Number = 5 then
  Result := True
 else if Number mod 5 = 0 then
  Result := False
 else if Number = 7 then
  Result := True
 else if Number mod 7 = 0 then
  Result := False
 else if (Number <= 2000000) then
  begin
   Result := True;
   SqrtNumber := Round(Sqrt(Number));
   J := 7;
   repeat
    Reminder1 := Number mod J;
    Inc(J,2);
    Reminder2 := Number mod J;
    if (Reminder1 = 0) or (Reminder2 = 0) then
     begin
      Result := False;
      Break;
     end;
    Inc(J,2);
   until(J > SqrtNumber);
  end
 else if (Number < 46902241) or (Number = 48527) or (Number = 74729) then
  begin
   CW8087 := Get8087CW;
   SetPrecisionMode(pmExtended);
   if StrongProbablePrimeDKCPas3(Number, 48527)  and
      StrongProbablePrimeDKCPas3(Number, 74729)  then
    begin
     Result := True;
    end
   else
    begin
     Result := False;
    end;
   Set8087CW(CW8087);
  end
 else if (Number < 152963791) or (Number = 11) or (Number = 145) then
  begin
   CW8087 := Get8087CW;
   SetPrecisionMode(pmExtended);
   if StrongProbablePrimeDKCPas3(Number, 11)  and
      StrongProbablePrimeDKCPas3(Number, 145)  then
    begin
     Result := True;
    end
   else
    begin
     Result := False;
    end;
   Set8087CW(CW8087);
  end
 else if (Number < 363941467) or (Number = 15) or (Number = 152) then
  begin
   CW8087 := Get8087CW;
   SetPrecisionMode(pmExtended);
   if StrongProbablePrimeDKCPas3(Number, 15)  and
      StrongProbablePrimeDKCPas3(Number, 152)  then
    begin
     Result := True;
    end
   else
    begin
     Result := False;
    end;
   Set8087CW(CW8087);
  end
 else if (Number < 572123521) or (Number = 2) or (Number = 118) then
  begin
   CW8087 := Get8087CW;
   SetPrecisionMode(pmExtended);
   if StrongProbablePrimeDKCPas3(Number, 2)  and
      StrongProbablePrimeDKCPas3(Number, 118)  then
    begin
     Result := True;
    end
   else
    begin
     Result := False;
    end;
   Set8087CW(CW8087);
  end
 else if (Number < 778907161) or (Number = 10) or (Number = 60) then
  begin
   CW8087 := Get8087CW;
   SetPrecisionMode(pmExtended);
   if StrongProbablePrimeDKCPas3(Number, 10)  and
      StrongProbablePrimeDKCPas3(Number, 60)  then
    begin
     Result := True;
    end
   else
    begin
     Result := False;
    end;
   Set8087CW(CW8087);
  end
 else if (Number < 1183338241) or (Number = 2) or (Number = 721) then
  begin
   CW8087 := Get8087CW;
   SetPrecisionMode(pmExtended);
   if StrongProbablePrimeDKCPas3(Number, 2)  and
      StrongProbablePrimeDKCPas3(Number, 721)  then
    begin
     Result := True;
    end
   else
    begin
     Result := False;
    end;
   Set8087CW(CW8087);
  end
 else if (Number < 1638294661) or (Number = 2) or (Number = 485) then
  begin
   CW8087 := Get8087CW;
   SetPrecisionMode(pmExtended);
   if StrongProbablePrimeDKCPas3(Number, 2)  and
      StrongProbablePrimeDKCPas3(Number, 485)  then
    begin
     Result := True;
    end
   else
    begin
     Result := False;
    end;
   Set8087CW(CW8087);
  end
 else if (Number < 2201924341) or (Number = 2) or (Number = 691) then
  begin
   CW8087 := Get8087CW;
   SetPrecisionMode(pmExtended);
   if StrongProbablePrimeDKCPas3(Number, 2)  and
      StrongProbablePrimeDKCPas3(Number, 691)  then
    begin
     Result := True;
    end
   else
    begin
     Result := False;
    end;
   Set8087CW(CW8087);
  end
 else if (Number < 2847894377) or (Number = 2) or (Number = 1301) then
  begin
   CW8087 := Get8087CW;
   SetPrecisionMode(pmExtended);
   if StrongProbablePrimeDKCPas3(Number, 2)  and
      StrongProbablePrimeDKCPas3(Number, 1301)  then
    begin
     Result := True;
    end
   else
    begin
     Result := False;
    end;
   Set8087CW(CW8087);
  end
 else if (Number < 3295362727) or (Number = 2) or (Number = 143) then
  begin
   CW8087 := Get8087CW;
   SetPrecisionMode(pmExtended);
   if StrongProbablePrimeDKCPas3(Number, 2)  and
      StrongProbablePrimeDKCPas3(Number, 143)  then
    begin
     Result := True;
    end
   else
    begin
     Result := False;
    end;
   Set8087CW(CW8087);
  end
 else if (Number < 3697278427) or (Number = 2) or (Number = 46) then
  begin
   CW8087 := Get8087CW;
   SetPrecisionMode(pmExtended);
   if StrongProbablePrimeDKCPas3(Number, 2)  and
      StrongProbablePrimeDKCPas3(Number, 46)  then
    begin
     Result := True;
    end
   else
    begin
     Result := False;
    end;
   Set8087CW(CW8087);
  end
 else
  begin
   CW8087 := Get8087CW;
   SetPrecisionMode(pmExtended);
   if StrongProbablePrimeDKCPas3(Number, 2)  and
      StrongProbablePrimeDKCPas3(Number, 78)  then
    begin
     Result := True;
    end
   else
    begin
     Result := False;
    end;
   Set8087CW(CW8087);
  end
end;

//Author:            Dennis Kjaer Christensen
//Date:              26/4 2004
//Instructionset(s): IA32
//Size = 747 + 188 = 935

function IsPrime_DKC_Pas_24(Number : Cardinal) : Boolean;
var
 SqrtNumber, Reminder1, Reminder2, J, Base2 : Cardinal;
 CW8087 : Word;

begin
 if Number <= 1 then
  Result := False
 else if Number <= 3 then
  Result := True
 else if Number mod 2 = 0 then
  Result := False
 else if Number mod 3 = 0 then
  Result := False
 else if Number = 5 then
  Result := True
 else if Number mod 5 = 0 then
  Result := False
 else if Number = 7 then
  Result := True
 else if Number mod 7 = 0 then
  Result := False
 else if (Number <= 3000000) then
  begin
   Result := True;
   SqrtNumber := Round(Sqrt(Number));
   J := 7;
   repeat
    Reminder1 := Number mod J;
    Inc(J,2);
    Reminder2 := Number mod J;
    if (Reminder1 = 0) or (Reminder2 = 0) then
     begin
      Result := False;
      Break;
     end;
    Inc(J,2);
   until(J > SqrtNumber);
  end
 else if (Number < 46902241) or (Number = 48527) or (Number = 74729) then
  begin
   CW8087 := Get8087CW;
   SetPrecisionMode(pmExtended);
   if StrongProbablePrimeDKCPas4(Number, 48527)  and
      StrongProbablePrimeDKCPas4(Number, 74729)  then
    begin
     Result := True;
    end
   else
    begin
     Result := False;
    end;
   Set8087CW(CW8087);
  end
 else
  begin
   CW8087 := Get8087CW;
   SetPrecisionMode(pmExtended);
   if StrongProbablePrimeDKCPas4(Number, 2)  then
    begin
     if (Number < 180497633) or (Number = 123833) then
      begin
       Base2 := 123833;
       if StrongProbablePrimeDKCPas4(Number, Base2)  then
        Result := True
       else
        Result := False;
      end
     else if (Number < 418667401) or (Number = 158504) then
      begin
       if StrongProbablePrimeDKCPas4(Number, 158504)  then
        Result := True
       else
        Result := False;
      end
     else if (Number < 770909107) or (Number = 18801) then
      begin
       if StrongProbablePrimeDKCPas4(Number, 18801)  then
        Result := True
       else
        Result := False;
      end
     else if (Number < 1183338241) or (Number = 721) then
      begin
       if StrongProbablePrimeDKCPas4(Number, 721)  then
        Result := True
       else
        Result := False;
      end
     else if (Number < 1776820033) or (Number = 1059) then
      begin
       if StrongProbablePrimeDKCPas4(Number, 1059)  then
        Result := True
       else
        Result := False;
      end
     else if (Number < 2202205897) or (Number = 1267) then
      begin
       if StrongProbablePrimeDKCPas4(Number, 1267)  then
        Result := True
       else
        Result := False;
      end
     else if (Number < 2847894377) or (Number = 1301) then
      begin
       if StrongProbablePrimeDKCPas4(Number, 1301)  then
        Result := True
       else
        Result := False;
      end
     else if (Number < 3402234749) or (Number = 305) then
      begin
       if StrongProbablePrimeDKCPas4(Number, 305)  then
        Result := True
       else
        Result := False;
      end
     else
      begin
       if StrongProbablePrimeDKCPas4(Number, 1766)  then
        Result := True
       else
        Result := False;
      end;
    end
   else
    begin
     Result := False;
    end;
   Set8087CW(CW8087);
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              29/3 2006
//Instructionset(s): IA32
//Size = 565 + 188 = 753

function IsPrime_DKC_Pas_25(Number : Cardinal) : Boolean;
var
 J, Base2, SqrtNumber, Reminder1, Reminder2 : Cardinal;
 CW8087 : Word;

begin
 if Number <= 1 then
  Result := False
 else if Number <= 3 then
  Result := True
 else if Number mod 2 = 0 then
  Result := False
 else if Number mod 3 = 0 then
  Result := False
 else if Number = 5 then
  Result := True
 else if Number mod 5 = 0 then
  Result := False
 else if Number = 7 then
  Result := True
 else if Number mod 7 = 0 then
  Result := False
 else if Number = 9 then
  Result := False
 else if Number mod 9 = 0 then
  Result := False
 else if Number = 11 then
  Result := True
 else if Number mod 11 = 0 then
  Result := False
 else if (Number <= 61) then
  begin
   Result := True;
   SqrtNumber := Round(Sqrt(Number));
   J := 9;
   repeat
    Reminder1 := Number mod J;
    Inc(J,2);
    Reminder2 := Number mod J;
    if (Reminder1 = 0) or (Reminder2 = 0) then
     begin
      Result := False;
      Break;
     end;
    Inc(J,2);
   until(J > SqrtNumber);
  end
 else
  begin
   CW8087 := Get8087CW;
   SetPrecisionMode(pmExtended);
   if StrongProbablePrimeDKCPas4(Number, 2)  then
    begin
     if (Number < 18443701) or (Number = 10633) then
      begin
       Base2 := 10633;
       if StrongProbablePrimeDKCPas4(Number, Base2)  then
        Result := True
       else
        Result := False;
      end
     else if (Number < 132332201) or (Number = 168754) then
      begin
       Base2 := 168754;
       if StrongProbablePrimeDKCPas4(Number, Base2)  then
        Result := True
       else
        Result := False;
      end
     else if (Number < 377192353) or (Number = 22351) then
      begin
       Base2 := 22351;
       if StrongProbablePrimeDKCPas4(Number, Base2)  then
        Result := True
       else
        Result := False;
      end
     else if (Number < 770909107) or (Number = 36535) then
      begin
       Base2 := 36535;
       if StrongProbablePrimeDKCPas4(Number, Base2)  then
        Result := True
       else
        Result := False;
      end
     else
      begin
       if StrongProbablePrimeDKCPas4(Number, 7) and
          StrongProbablePrimeDKCPas4(Number, 61) then
        Result := True
       else
        Result := False;
      end;
    end
   else
    begin
     Result := False;
    end;
   Set8087CW(CW8087);
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              30/3 2006
//Instructionset(s): IA32
//Size: 1066 byte + PrimeTable 43*4 byte = 1066 + 172 = 1238

function IsPrime_DKC_Pas_26(Number : Cardinal) : Boolean;
var
 SqrtNumber, Reminder1, PrimeDivisor : Cardinal;
 J : Integer;
 CW8087 : Word;

begin
 if Number <= 1 then
  Result := False
 else if Number <= 3 then
  Result := True
 else if Number mod 2 = 0 then
  Result := False
 else
  begin
   Result := True;
   SqrtNumber := Round(Sqrt(Number));
   J := 0;
   repeat
    Inc(J);
    PrimeDivisor := PrimeTable[J];
    if PrimeDivisor > SqrtNumber then
     Exit;
    Reminder1 := Number mod PrimeDivisor;
    if (Reminder1 = 0) then
     begin
      Result := False;
      Exit;
     end;
   until(J >= Length(PrimeTable)-1);
   if (Number < 46902241) and (Number <> 48527) and (Number <> 74729) then
    begin
     CW8087 := Get8087CW;
     SetPrecisionMode(pmExtended);
     if StrongProbablePrimeDKCPas3(Number, 48527)  and
        StrongProbablePrimeDKCPas3(Number, 74729)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
     Set8087CW(CW8087);
    end
   else if (Number < 152963791) and (Number <> 11) and (Number <> 145) then
    begin
     CW8087 := Get8087CW;
     SetPrecisionMode(pmExtended);
     if StrongProbablePrimeDKCPas3(Number, 11)  and
        StrongProbablePrimeDKCPas3(Number, 145)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
     Set8087CW(CW8087);
    end
   else if (Number < 363941467) and (Number <> 15) then
    begin
     CW8087 := Get8087CW;
     SetPrecisionMode(pmExtended);
     if StrongProbablePrimeDKCPas3(Number, 15)  and
        StrongProbablePrimeDKCPas3(Number, 152)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
     Set8087CW(CW8087);
    end
   else if (Number < 572123521) then
    begin
     CW8087 := Get8087CW;
     SetPrecisionMode(pmExtended);
     if StrongProbablePrimeDKCPas3(Number, 2)  and
        StrongProbablePrimeDKCPas3(Number, 118)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
     Set8087CW(CW8087);
    end
   else if (Number < 778907161) then
    begin
     CW8087 := Get8087CW;
     SetPrecisionMode(pmExtended);
     if StrongProbablePrimeDKCPas3(Number, 10)  and
        StrongProbablePrimeDKCPas3(Number, 60)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
     Set8087CW(CW8087);
    end
   else if (Number < 1183338241) and (Number <> 721) then
    begin
     CW8087 := Get8087CW;
     SetPrecisionMode(pmExtended);
     if StrongProbablePrimeDKCPas3(Number, 2)  and
        StrongProbablePrimeDKCPas3(Number, 721)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
     Set8087CW(CW8087);
    end
   else if (Number < 1638294661) and (Number <> 485) then
    begin
     CW8087 := Get8087CW;
     SetPrecisionMode(pmExtended);
     if StrongProbablePrimeDKCPas3(Number, 2)  and
        StrongProbablePrimeDKCPas3(Number, 485)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
     Set8087CW(CW8087);
    end
   else if (Number < 2201924341) and (Number <> 691) then
    begin
     CW8087 := Get8087CW;
     SetPrecisionMode(pmExtended);
     if StrongProbablePrimeDKCPas3(Number, 2)  and
        StrongProbablePrimeDKCPas3(Number, 691)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
     Set8087CW(CW8087);
    end
   else if (Number < 2847894377) and (Number <> 1301) then
    begin
     CW8087 := Get8087CW;
     SetPrecisionMode(pmExtended);
     if StrongProbablePrimeDKCPas3(Number, 2)  and
        StrongProbablePrimeDKCPas3(Number, 1301)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
     Set8087CW(CW8087);
    end
   else if (Number < 3295362727) and (Number <> 143) then
    begin
     CW8087 := Get8087CW;
     SetPrecisionMode(pmExtended);
     if StrongProbablePrimeDKCPas3(Number, 2)  and
        StrongProbablePrimeDKCPas3(Number, 143)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
     Set8087CW(CW8087);
    end
   else if (Number < 3697278427) then
    begin
     CW8087 := Get8087CW;
     SetPrecisionMode(pmExtended);
     if StrongProbablePrimeDKCPas3(Number, 2)  and
        StrongProbablePrimeDKCPas3(Number, 46)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
     Set8087CW(CW8087);
    end
   else
    begin
     CW8087 := Get8087CW;
     SetPrecisionMode(pmExtended);
     if StrongProbablePrimeDKCPas3(Number, 2)  and
        StrongProbablePrimeDKCPas3(Number, 78)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
     Set8087CW(CW8087);
    end
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              4/4 2006
//Instructionset(s): IA32
//Size 849 byte

function IsPrime_DKC_Pas_27(Number : Cardinal) : Boolean;
var
 SqrtNumber, Reminder1, PrimeDivisor : Cardinal;
 J : Integer;
 CW8087 : Word;
const
 LocalPrimeTable : array[0..34] of Byte = (2,3,5,7,11,13,17,19,23,29,31,37,41,43,
                                           47,53,59,61,67,71,73,79,83,89,97,101,
                                           103,107,109,113,127,131,137,139,149);

begin
 if Number <= 1 then
  Result := False
 else if Number <= 3 then
  Result := True
 else if Number mod 2 = 0 then
  Result := False
 else
  begin
   Result := True;
   SqrtNumber := Round(Sqrt(Number));
   J := -1;
   repeat
    Inc(J);
    PrimeDivisor := LocalPrimeTable[J];
    if PrimeDivisor > SqrtNumber then
     Exit;
    Reminder1 := Number mod PrimeDivisor;
    if (Reminder1 = 0) then
     begin
      Result := False;
      Exit;
     end;
   until(J >= Length(LocalPrimeTable)-2);
   CW8087 := Get8087CW;
   SetPrecisionMode(pmExtended);
   if (Number < 46902241) and (Number <> 48527) and (Number <> 74729) then
    begin
     if StrongProbablePrimeDKCPas3(Number, 48527)  and
        StrongProbablePrimeDKCPas3(Number, 74729)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
    end
   else if (Number < 152963791) and (Number <> 11) and (Number <> 145) then
    begin
     if StrongProbablePrimeDKCPas3(Number, 11)  and
        StrongProbablePrimeDKCPas3(Number, 145)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
    end
   else if (Number < 363941467) and (Number <> 15) then
    begin
     if StrongProbablePrimeDKCPas3(Number, 15)  and
        StrongProbablePrimeDKCPas3(Number, 152)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
    end
   else if (Number < 572123521) then
    begin
     if StrongProbablePrimeDKCPas3(Number, 2)  and
        StrongProbablePrimeDKCPas3(Number, 118)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
    end
   else if (Number < 778907161) then
    begin
     if StrongProbablePrimeDKCPas3(Number, 10)  and
        StrongProbablePrimeDKCPas3(Number, 60)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
    end
   else if (Number < 1183338241) and (Number <> 721) then
    begin
     if StrongProbablePrimeDKCPas3(Number, 2)  and
        StrongProbablePrimeDKCPas3(Number, 721)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
    end
   else if (Number < 1638294661) and (Number <> 485) then
    begin
     if StrongProbablePrimeDKCPas3(Number, 2)  and
        StrongProbablePrimeDKCPas3(Number, 485)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
    end
   else if (Number < 2201924341) and (Number <> 691) then
    begin
     if StrongProbablePrimeDKCPas3(Number, 2)  and
        StrongProbablePrimeDKCPas3(Number, 691)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
    end
   else if (Number < 2847894377) and (Number <> 1301) then
    begin
     if StrongProbablePrimeDKCPas3(Number, 2)  and
        StrongProbablePrimeDKCPas3(Number, 1301)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
    end
   else if (Number < 3295362727) and (Number <> 143) then
    begin
     if StrongProbablePrimeDKCPas3(Number, 2)  and
        StrongProbablePrimeDKCPas3(Number, 143)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
    end
   else if (Number < 3697278427) then
    begin
     if StrongProbablePrimeDKCPas3(Number, 2)  and
        StrongProbablePrimeDKCPas3(Number, 46)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
    end
   else
    begin
     if StrongProbablePrimeDKCPas3(Number, 2)  and
        StrongProbablePrimeDKCPas3(Number, 78)  then
      begin
       Result := True;
      end
     else
      begin
       Result := False;
      end;
    end;
   Set8087CW(CW8087);
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              19/12 2003
//Instructionset(s): IA32

function IsPrime_DKC_IA32_9(Number : Cardinal) : Boolean;
asm
   //if Number <= 7 then
   cmp  eax,7
   jbe  @VerySmall
   //if Number mod 2 = 0 then
   test eax,1
   jz   @ResultFalse
   //if Number mod 3 = 0 then
   push edi
   mov  edi,eax
   mov  ecx, 01010101010101010101010101010101b
   mul  ecx
   mov  ecx,edi
   shr  ecx,1
   add  eax,ecx
   shr  ecx,2
   sub  eax,ecx
   and  eax, 11000000000000000000000000000000b
   jz   @Exit5    //Result := False;
 @IfEnd9 :
   //if Number mod 5 = 0 then
   mov  eax,edi
   mov  ecx,5
   xor  edx,edx
   div  ecx
   test edx,edx
   jnz  @IfEnd10
   //Result := False;
   xor  eax,eax
   jmp  @Exit5
 @IfEnd10 :
   //if Number mod 7 = 0 then
   mov  eax,edi
   mov  ecx,7
   xor  edx,edx
   div  ecx
   test edx,edx
   jnz  @IfEnd11
   //Result := False;
   xor  eax,eax
   jmp  @Exit5
 @IfEnd11 :
   push esi
   push ebp
   //if (Number <= 100000) then
   cmp  edi,100000
   jnbe @IfEnd12
   //SqrtNumber := Round(Sqrt(Number));
   mov  [esp-4],edi
   fild dword ptr [esp-4]
   fsqrt
   fistp dword ptr [esp-4]
   mov  ebp, dword ptr [esp-4]
   //J=ecx is 7;
 @RepeatStart1 :
   //Inc(J,2);
   add  ecx,2
   //Reminder := Number mod J;
   mov  eax,edi
   xor  edx,edx
   div  ecx
   //if (Reminder = 0) then
   test edx,edx
   jz   @IfEnd14
   //until(J > SqrtNumber);
   cmp  ebp,ecx
   jnb  @RepeatStart1
 @Repeat1End :
   mov  eax,1
   jmp  @Exit2
 @IfEnd12 :
   //K := 0;
   xor  eax,eax
   //M := Number-1;
   mov  esi,edi
   sub  esi,1
   //Calculate d and s
 @RepeatStart2 :
   //M := M shr 1;
   shr  esi,1
   //Inc(K);
   add  eax,1
   //until Odd(M);
   test esi,1
   jz   @RepeatStart2
   //if StrongProbablePrimeDKCIA32_9(2, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_9(7, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_9(61, M, Number, K) then
   mov  ebp,eax
   push eax
   mov  ecx,edi
   mov  edx,esi
   mov  eax,2
   call StrongProbablePrimeDKCIA32_9
   test al,al
   jz   @IfEnd14
   push ebp
   mov  ecx,edi
   mov  edx,esi
   mov  eax,61
   call StrongProbablePrimeDKCIA32_9
   test al,al
   jz   @IfEnd14
   push ebp
   mov  ecx,edi
   mov  edx,esi
   mov  eax,7
   call StrongProbablePrimeDKCIA32_9
   test al,al
   jz   @IfEnd14
   //Result := True;
   mov  al,1
   jmp  @Exit2
 @VerySmall :
   //if Number <= 1 then
   cmp  eax,1
   jbe  @ResultFalse
   //if Number <= 3 then
   cmp  eax,3
   jbe  @ResultTrue
   //if Number = 4 then
   cmp  eax,4
   jz   @ResultFalse
   //if Number = 5 then
   cmp  eax,5
   jz   @ResultTrue
   //if Number = 6 then
   cmp  eax,6
   jz   @ResultFalse
 @IfEnd6 :
   //Number = 7 then
 @ResultTrue :
   mov  al,1
   jmp  @Exit4
 @ResultFalse :
   xor  eax,eax
   jmp  @Exit4
 @IfEnd14 :
   //Result := False;
   xor  eax,eax
 @Exit2 :
   pop   ebp
   pop   esi
 @Exit5 :
   pop   edi
 @Exit4 :
end;

//Author:            Dennis Kjaer Christensen
//Date:              18/12 2003
//Optimized for:     Blended
//Instructionset(s): IA32, SSE
//Size: 262 + 120 = 382

function IsPrime_DKC_SSE_1(Number : Cardinal) : Boolean;
asm
   //if Number <= 7 then
   cmp  eax,7
   jbe  @VerySmall
   //if Number mod 2 = 0 then
   test eax,1
   jz   @ResultFalse
   //if Number mod 3 = 0 then
   push edi
   mov  edi,eax
   mov  ecx, 01010101010101010101010101010101b
   mul  ecx
   mov  ecx,edi
   shr  ecx,1
   add  eax,ecx
   shr  ecx,2
   sub  eax,ecx
   and  eax, 11000000000000000000000000000000b
   jz   @Exit5    //Result := False;
 @IfEnd9 :
   //if Number mod 5 = 0 then
   mov  eax,edi
   mov  ecx,5
   xor  edx,edx
   div  ecx
   test edx,edx
   jnz  @IfEnd10
   //Result := False;
   xor  eax,eax
   jmp  @Exit5
 @IfEnd10 :
   //if Number mod 7 = 0 then
   mov  eax,edi
   mov  ecx,7
   xor  edx,edx
   div  ecx
   test edx,edx
   jnz  @IfEnd11
   //Result := False;
   xor  eax,eax
   jmp  @Exit5
 @IfEnd11 :
   push esi
   push ebp
   //if (Number <= 100000) then
   cmp  edi,100000
   jnbe @IfEnd12
   //SqrtNumber := Round(Sqrt(Number));
   cvtsi2ss  xmm0,edi
   sqrtss    xmm0,xmm0
   cvttss2si ebp,xmm0
   //J=ecx is 7;
 @RepeatStart1 :
   //Inc(J,2);
   add  ecx,2
   //Reminder2 := Number mod J;
   mov  eax,edi
   xor  edx,edx
   div  ecx
   //if (Reminder1 = 0) then
   test edx,edx
   jz   @IfEnd14
   //until(J > SqrtNumber);
   cmp  ebp,ecx
   jnb  @RepeatStart1
 @Repeat1End :
   mov  eax,1
   jmp  @Exit2
 @IfEnd12 :
   //K := 0;
   xor  eax,eax
   //M := Number-1;
   mov  esi,edi
   sub  esi,1
   //Calculate d and s
 @RepeatStart2 :
   //M := M shr 1;
   shr  esi,1
   //Inc(K);
   add  eax,1
   //until Odd(M);
   test esi,1
   jz   @RepeatStart2
   //if StrongProbablePrimeDKCIA32_9(2, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_9(7, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_9(61, M, Number, K) then
   mov  ebp,eax
   push eax
   mov  ecx,edi
   mov  edx,esi
   mov  eax,2
   call StrongProbablePrimeDKCIA32_9
   test al,al
   jz   @IfEnd14
   push ebp
   mov  ecx,edi
   mov  edx,esi
   mov  eax,61
   call StrongProbablePrimeDKCIA32_9
   test al,al
   jz   @IfEnd14
   push ebp
   mov  ecx,edi
   mov  edx,esi
   mov  eax,7
   call StrongProbablePrimeDKCIA32_9
   test al,al
   jz   @IfEnd14
   //Result := True;
   mov  al,1
   jmp  @Exit2
 @VerySmall :
   //if Number <= 1 then
   cmp  eax,1
   jbe  @ResultFalse
   //if Number <= 3 then
   cmp  eax,3
   jbe  @ResultTrue
   //if Number = 4 then
   cmp  eax,4
   jz   @ResultFalse
   //if Number = 5 then
   cmp  eax,5
   jz   @ResultTrue
   //if Number = 6 then
   cmp  eax,6
   jz   @ResultFalse
 @IfEnd6 :
   //Number = 7 then
 @ResultTrue :
   mov  al,1
   jmp  @Exit4
 @ResultFalse :
   xor  eax,eax
   jmp  @Exit4
 @IfEnd14 :
   //Result := False;
   xor  eax,eax
 @Exit2 :
   pop   ebp
   pop   esi
 @Exit5 :
   pop   edi
 @Exit4 :
end;

//Author:            Dennis Kjaer Christensen
//Date:              28/12 2003
//Instructionset(s): IA32, SSE
//Size: 268 + 120 = 388

function IsPrime_DKC_SSE_2(Number : Cardinal) : Boolean;
asm
   //if Number <= 7 then
   cmp  eax,7
   jbe  @VerySmall
   //if Number mod 2 = 0 then
   test eax,1
   jz   @ResultFalse
   //if Number mod 3 = 0 then
   mov  ecx,eax
   mov  edx, 01010101010101010101010101010101b
   mul  edx
   mov  edx,ecx
   shr  ecx,1
   add  eax,ecx
   shr  ecx,2
   sub  eax,ecx
   and  eax, 11000000000000000000000000000000b
   jz   @Exit4    //Result := False;
 @IfEnd9 :
   //if Number mod 5 = 0 then
   push edi
   mov  edi,edx
   mov  eax,edx
   mov  ecx,5
   xor  edx,edx
   div  ecx
   test edx,edx
   jnz  @IfEnd10
   //Result := False;
   xor  eax,eax
   jmp  @Exit5
 @IfEnd10 :
   //if Number mod 7 = 0 then
   mov  eax,edi
   mov  ecx,7
   xor  edx,edx
   div  ecx
   test edx,edx
   jnz  @IfEnd11
   //Result := False;
   xor  eax,eax
   jmp  @Exit5
 @IfEnd11 :
   push ebp
   push esi
   //if (Number <= 100000) then
   cmp  edi,100000
   jbe  @IfEnd12
   //K := 0;
   xor  eax,eax
   //M := Number-1;
   mov  esi,edi
   sub  esi,1
   //Calculate d and s
 @RepeatStart2 :
   //M := M shr 1;
   shr  esi,1
   //Inc(K);
   add  eax,1
   //until Odd(M);
   test esi,1
   jz   @RepeatStart2
   //if StrongProbablePrimeDKCIA32_10(2, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_10(7, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_10(61, M, Number, K) then
   mov  ebp,eax
   push eax
   mov  ecx,edi
   mov  edx,esi
   mov  eax,2
   call StrongProbablePrime_DKC_IA32_10
   test al,al
   jz   @IfEnd14
   sub  esp,4
   mov  ecx,edi
   mov  edx,esi
   mov  eax,61
   call StrongProbablePrime_DKC_IA32_10
   test al,al
   jz   @IfEnd14
   sub  esp,4
   mov  ecx,edi
   mov  edx,esi
   mov  eax,7
   call StrongProbablePrime_DKC_IA32_10
   test al,al
   jz   @IfEnd14
   //Result := True;
   mov  al,1
   jmp  @Exit2
 @IfEnd12 :
   //SqrtNumber := Round(Sqrt(Number));
   cvtsi2ss  xmm0,edi
   sqrtss    xmm0,xmm0
   cvttss2si ebp,xmm0
   //J=ecx is 7;
 @RepeatStart1 :
   //Inc(J,2);
   add  ecx,2
   //Reminder2 := Number mod J;
   mov  eax,edi
   xor  edx,edx
   div  ecx
   //if (Reminder1 = 0) then
   test edx,edx
   jz   @IfEnd14
   //until(J > SqrtNumber);
   cmp  ebp,ecx
   jnb  @RepeatStart1
 @Repeat1End :
   mov  eax,1
   jmp  @Exit2
 @VerySmall :
   //if Number <= 1 then
   cmp  eax,1
   jbe  @ResultFalse
   //if Number <= 3 then
   cmp  eax,3
   jbe  @ResultTrue
   //if Number = 4 then
   cmp  eax,4
   jz   @ResultFalse
   //if Number = 5 then
   cmp  eax,5
   jz   @ResultTrue
   //if Number = 6 then
   cmp  eax,6
   jz   @ResultFalse
 @IfEnd6 :
   //Number = 7 then
 @ResultTrue :
   mov  al,1
   jmp  @Exit4
 @ResultFalse :
   xor  eax,eax
   jmp  @Exit4
 @IfEnd14 :
   xor  eax,eax
 @Exit2 :
   pop   esi
   pop   ebp
 @Exit5 :
   pop   edi
 @Exit4 :
end;

//Author:            Dennis Kjaer Christensen
//Date:              7/2 2005
//Instructionset(s): IA32, SSE
//Size: 334 + 120 = 454

function IsPrime_DKC_SSE_3(Number : Cardinal) : Boolean;
asm
   //if Number <= 7 then
   cmp  eax,7
   jbe  @VerySmall
   //if Number mod 2 = 0 then
   test eax,1
   jz   @ResultFalse
   //if Number mod 3 = 0 then
   mov  ecx,eax
   mov  edx, 01010101010101010101010101010101b
   mul  edx
   mov  edx,ecx
   shr  ecx,1
   add  eax,ecx
   shr  ecx,2
   sub  eax,ecx
   and  eax, 11000000000000000000000000000000b
   jz   @Exit4    //Result := False;
 @IfEnd9 :
   //if Number mod 5 = 0 then
   push edi
   mov  edi,edx
   mov  eax,edx
   mov  ecx,5
   xor  edx,edx
   div  ecx
   test edx,edx
   jnz  @IfEnd10
   //Result := False;
   xor  eax,eax
   jmp  @Exit5
 @IfEnd10 :
   //if Number mod 7 = 0 then
   mov  eax,edi
   mov  ecx,7
   xor  edx,edx
   div  ecx
   test edx,edx
   jnz  @IfEnd11
   //Result := False;
   xor  eax,eax
   jmp  @Exit5
 @IfEnd11 :
   push ebp
   push esi
   //if (Number <= 100000) then
   cmp  edi,100000
   jbe  @IfEnd12
   //K := 0;
   xor  eax,eax
   //M := Number-1;
   mov  esi,edi
   sub  esi,1
   //Calculate d and s
 @RepeatStart2 :
   //M := M shr 1;
   shr  esi,1
   //Inc(K);
   add  eax,1
   //until Odd(M);
   test esi,1
   jz   @RepeatStart2
   //if (Number <= 46902241) then
   cmp  edi,46902241
   jb   @TwoBaseTest
   //if StrongProbablePrimeDKCIA32_11(2, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_10(7, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_10(61, M, Number, K) then
   mov  ebp,eax
   push eax
   mov  ecx,edi
   mov  edx,esi
   mov  eax,2
   call StrongProbablePrime_DKC_IA32_10
   test al,al
   jz   @IfEnd14
   sub  esp,4
   mov  ecx,edi
   mov  edx,esi
   mov  eax,61
   call StrongProbablePrime_DKC_IA32_10
   test al,al
   jz   @IfEnd14
   sub  esp,4
   mov  ecx,edi
   mov  edx,esi
   mov  eax,7
   call StrongProbablePrime_DKC_IA32_10
   test al,al
   jz   @IfEnd14
   //Result := True;
   mov  al,1
   jmp  @Exit2
 @TwoBaseTest :
   //if StrongProbablePrimeDKCIA32_10(48527, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_10(74729, M, Number, K) then
   mov  ebp,eax
   push eax
   mov  ecx,edi
   mov  edx,esi
   mov  eax,48527
   call StrongProbablePrime_DKC_IA32_10
   test al,al
   jz   @IfEnd14
   sub  esp,4
   mov  ecx,edi
   mov  edx,esi
   mov  eax,74729
   call StrongProbablePrime_DKC_IA32_10
   test al,al
   jz   @IfEnd14
   //Result := True;
   mov  al,1
   jmp  @Exit2
 @IfEnd12 :
   //SqrtNumber := Round(Sqrt(Number));
   cvtsi2ss  xmm0,edi
   sqrtss    xmm0,xmm0
   cvttss2si ebp,xmm0
   //J=ecx is 7;
 @RepeatStart1 :
   //Inc(J,2);
   add  ecx,2
   //Reminder2 := Number mod J;
   mov  eax,edi
   xor  edx,edx
   div  ecx
   //if (Reminder1 = 0) then
   test edx,edx
   jz   @IfEnd14
   //until(J > SqrtNumber);
   cmp  ebp,ecx
   jnb  @RepeatStart1
 @Repeat1End :
   mov  eax,1
   jmp  @Exit2
 @VerySmall :
   //if Number <= 1 then
   cmp  eax,1
   jbe  @ResultFalse
   //if Number <= 3 then
   cmp  eax,3
   jbe  @ResultTrue
   //if Number = 4 then
   cmp  eax,4
   jz   @ResultFalse
   //if Number = 5 then
   cmp  eax,5
   jz   @ResultTrue
   //if Number = 6 then
   cmp  eax,6
   jz   @ResultFalse
 @IfEnd6 :
   //Number = 7 then
 @ResultTrue :
   mov  al,1
   jmp  @Exit4
 @ResultFalse :
   xor  eax,eax
   jmp  @Exit4
 @IfEnd14 :
   xor  eax,eax
 @Exit2 :
   pop   esi
   pop   ebp
 @Exit5 :
   pop   edi
 @Exit4 :
end;

//Author:            Dennis Kjaer Christensen
//Date:              6/4 2006
//Instructionset(s): IA32, SSE
//Size: 354 + 120 + 35 = 474 + 35 = 509

function IsPrime_DKC_SSE_4(Number : Cardinal) : Boolean;
const
 LocalPrimeTable : array[0..34] of Byte = (2,3,5,7,11,13,17,19,23,29,31,37,41,43,
                                           47,53,59,61,67,71,73,79,83,89,97,101,
                                           103,107,109,113,127,131,137,139,149);

asm
   //if Number <= 7 then
   cmp       eax,7
   jbe       @VerySmall
   //if Number mod 2 = 0 then
   test      eax,1
   jz        @ResultFalse
   //if Number mod 3 = 0 then
   mov       ecx,eax
   mov       edx,01010101010101010101010101010101b
   mul       edx
   mov       edx,ecx
   shr       ecx,1
   add       eax,ecx
   shr       ecx,2
   sub       eax,ecx
   and       eax,11000000000000000000000000000000b
   jz        @Exit4    //Result := False;
 @IfEnd9 :
   //if Number mod 5 = 0 then
   push      edi
   mov       edi,edx
   mov       eax,edx
   mov       ecx,5
   xor       edx,edx
   div       ecx
   test      edx,edx
   jz        @ExitFalse
 @IfEnd11 :
   push      ebp
   push      esi
   push      ebx
 @IfEnd12 :
   //SqrtNumber := Round(Sqrt(Number));
   cvtsi2ss  xmm0,edi
   sqrtss    xmm0,xmm0
   cvttss2si ebp,xmm0
   xor       ecx,ecx
   mov       esi,offset LocalPrimeTable
 @RepeatStart1 :
   movzx     ebx,byte ptr [esi+ecx]
   add       ecx,1
   //Reminder := Number mod J;
   mov       eax,edi
   xor       edx,edx
   div       ebx
   //if (Reminder = 0) then
   test      edx,edx
   jz        @IfEnd144
   cmp       ecx,35
   jae       @SPRPTest
   //until(Divisor > SqrtNumber);
   cmp       ebp,ebx
   jnb       @RepeatStart1
 @Repeat1End :
   mov       eax,1
   pop       ebx
   jmp       @Exit2
 @SPRPTest :
   pop       ebx
   //K := 0;
   xor       eax,eax
   //M := Number-1;
   mov       esi,edi
   sub       esi,1
   //Calculate d and s
 @RepeatStart2 :
   //M := M shr 1;
   shr       esi,1
   //Inc(K);
   add       eax,1
   //until Odd(M);
   test      esi,1
   jz        @RepeatStart2
   //if (Number < 46902241) then
   cmp       edi,46902241
   jb        @TwoBaseTest
 @ThreeBaseTest :
   //if StrongProbablePrimeDKCIA32_11(2, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_10(7, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_10(61, M, Number, K) then
   mov       ebp,eax
   push      eax
   mov       ecx,edi
   mov       edx,esi
   mov       eax,2
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   sub       esp,4
   mov       ecx,edi
   mov       edx,esi
   mov       eax,61
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   sub       esp,4
   mov       ecx,edi
   mov       edx,esi
   mov       eax,7
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   //Result := True;
   mov       al,1
   pop       esi
   pop       ebp
   pop       edi
   ret
 @TwoBaseTest :
   //if StrongProbablePrimeDKCIA32_10(48527, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_10(74729, M, Number, K) then
   cmp       edi,48527
   je        @ThreeBaseTest
   cmp       edi,74729
   je        @ThreeBaseTest
   mov       ebp,eax
   push      eax
   mov       ecx,edi
   mov       edx,esi
   mov       eax,48527
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   sub       esp,4
   mov       ecx,edi
   mov       edx,esi
   mov       eax,74729
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   //Result := True;
   mov       al,1
   //jmp       @Exit2
   pop       esi
   pop       ebp
   pop       edi
   ret
 @VerySmall :
   //if Number <= 1 then
   cmp       eax,1
   jbe       @ResultFalse
   //if Number <= 3 then
   cmp       eax,3
   jbe       @ResultTrue
   //if Number = 4 then
   cmp       eax,4
   jz        @ResultFalse
   //if Number = 5 then
   cmp       eax,5
   jz        @ResultTrue
   //if Number = 6 then
   cmp       eax,6
   jz        @ResultFalse
 @IfEnd6 :
   //Number = 7 then
 @ResultTrue :
   mov       al,1
   jmp       @Exit4
 @ResultFalse :
   xor       eax,eax
   //jmp       @Exit4
   ret
 @IfEnd144 :
   pop       ebx
   xor       eax,eax
   pop       esi
   pop       ebp
   pop       edi
   jmp       @Exit4
 @ExitFalse :
   xor       eax,eax
   pop       edi
   ret
 @IfEnd14 :
   xor       eax,eax
 @Exit2 :
   pop       esi
   pop       ebp
 @Exit5 :
   pop       edi
 @Exit4 :
end;

//Author:            Dennis Kjaer Christensen
//Date:              6/4 2006
//Instructionset(s): IA32, SSE
//Size: 356 + 120 + 30*2 = 536

function IsPrime_DKC_SSE_5(Number : Cardinal) : Boolean;
const
 LocalPrimeTable : array[0..29] of Word = (2,3,5,7,11,13,17,19,23,29,31,37,41,
                                           43,47,53,59,61,67,71,73,79,83,89,97,
                                           101,103,107,109,113);
asm
   //if Number <= 7 then
   cmp       eax,7
   jbe       @VerySmall
   //if Number mod 2 = 0 then
   test      eax,1
   jz        @ResultFalse
   //if Number mod 3 = 0 then
   mov       ecx,eax
   mov       edx,01010101010101010101010101010101b
   mul       edx
   mov       edx,ecx
   shr       ecx,1
   add       eax,ecx
   shr       ecx,2
   sub       eax,ecx
   and       eax,11000000000000000000000000000000b
   jz        @Exit4    //Result := False;
 @IfEnd9 :
   //if Number mod 5 = 0 then
   push      edi
   mov       edi,edx
   mov       eax,edx
   mov       ecx,5
   xor       edx,edx
   div       ecx
   test      edx,edx
   jz        @ExitFalse
 @IfEnd11 :
   push      ebp
   push      esi
   push      ebx
 @IfEnd12 :
   //SqrtNumber := Round(Sqrt(Number));
   cvtsi2ss  xmm0,edi
   sqrtss    xmm0,xmm0
   cvttss2si ebp,xmm0
   xor       ecx,ecx
   mov       esi,offset LocalPrimeTable
   xor       ebx,ebx
 @RepeatStart1 :
   mov       bx,word ptr [esi+ecx]
   add       ecx,2
   //Reminder := Number mod J;
   mov       eax,edi
   xor       edx,edx
   div       ebx
   //if (Reminder = 0) then
   test      edx,edx
   jz        @IfEnd144
   cmp       ecx,30
   jae       @SPRPTest
   //until(Divisor > SqrtNumber);
   cmp       ebp,ebx
   jnb       @RepeatStart1
 @Repeat1End :
   mov       eax,1
   pop       ebx
   jmp       @Exit2
 @SPRPTest :
   pop       ebx
   //K := 0;
   xor       eax,eax
   //M := Number-1;
   mov       esi,edi
   sub       esi,1
   //Calculate d and s
 @RepeatStart2 :
   //M := M shr 1;
   shr       esi,1
   //Inc(K);
   add       eax,1
   //until Odd(M);
   test      esi,1
   jz        @RepeatStart2
   //if (Number < 46902241) then
   cmp       edi,46902241
   jb        @TwoBaseTest
 @ThreeBaseTest :
   //if StrongProbablePrimeDKCIA32_11(13, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_10(41, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_10(54, M, Number, K) then
   mov       ebp,eax
   push      eax
   mov       ecx,edi
   mov       edx,esi
   mov       eax,13
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   sub       esp,4
   mov       ecx,edi
   mov       edx,esi
   mov       eax,41
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   sub       esp,4
   mov       ecx,edi
   mov       edx,esi
   mov       eax,54
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   //Result := True;
   mov       al,1
   pop       esi
   pop       ebp
   pop       edi
   ret
 @TwoBaseTest :
   //if StrongProbablePrimeDKCIA32_10(48527, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_10(74729, M, Number, K) then
   cmp       edi,48527
   je        @ThreeBaseTest
   cmp       edi,74729
   je        @ThreeBaseTest
   mov       ebp,eax
   push      eax
   mov       ecx,edi
   mov       edx,esi
   mov       eax,48527
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   sub       esp,4
   mov       ecx,edi
   mov       edx,esi
   mov       eax,74729
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   //Result := True;
   mov       al,1
   //jmp       @Exit2
   pop       esi
   pop       ebp
   pop       edi
   ret
 @VerySmall :
   //if Number <= 1 then
   cmp       eax,1
   jbe       @ResultFalse
   //if Number <= 3 then
   cmp       eax,3
   jbe       @ResultTrue
   //if Number = 4 then
   cmp       eax,4
   jz        @ResultFalse
   //if Number = 5 then
   cmp       eax,5
   jz        @ResultTrue
   //if Number = 6 then
   cmp       eax,6
   jz        @ResultFalse
 @IfEnd6 :
   //Number = 7 then
 @ResultTrue :
   mov       al,1
   jmp       @Exit4
 @ResultFalse :
   xor       eax,eax
   //jmp       @Exit4
   ret
 @IfEnd144 :
   pop       ebx
   xor       eax,eax
   pop       esi
   pop       ebp
   pop       edi
   jmp       @Exit4
 @ExitFalse :
   xor       eax,eax
   pop       edi
   ret
 @IfEnd14 :
   xor       eax,eax
 @Exit2 :
   pop       esi
   pop       ebp
 @Exit5 :
   pop       edi
 @Exit4 :
end;

//Author:            Dennis Kjaer Christensen
//Date:              6/4 2006
//Instructionset(s): IA32, SSE
//Size: 356 + 120 + 29*2 = 476 + 58 = 534

function IsPrime_DKC_SSE_6(Number : Cardinal) : Boolean;
const
 LocalPrimeTable : array[0..29] of Word = (2,3,5,7,11,13,17,19,23,29,31,37,41,
                                           43,47,53,59,61,67,71,73,79,83,89,97,
                                           101,103,107,109,113);
asm
   //if Number <= 7 then
   cmp       eax,7
   jbe       @VerySmall
   //if Number mod 2 = 0 then
   test      eax,1
   jz        @ResultFalse
   //if Number mod 3 = 0 then
   mov       ecx,eax
   mov       edx,01010101010101010101010101010101b
   mul       edx
   mov       edx,ecx
   shr       ecx,1
   add       eax,ecx
   shr       ecx,2
   sub       eax,ecx
   and       eax,11000000000000000000000000000000b
   jz        @Exit4    //Result := False;
 @IfEnd9 :
   //if Number mod 5 = 0 then
   push      edi
   mov       edi,edx
   mov       eax,edx
   mov       ecx,5
   xor       edx,edx
   div       ecx
   test      edx,edx
   jz        @ExitFalse
 @IfEnd11 :
   push      ebp
   push      esi
   push      ebx
 @IfEnd12 :
   //SqrtNumber := Round(Sqrt(Number));
   cvtsi2ss  xmm0,edi
   sqrtss    xmm0,xmm0
   cvttss2si ebp,xmm0
   xor       ecx,ecx
   mov       esi,offset LocalPrimeTable
   xor       ebx,ebx
 @RepeatStart1 :
   mov       bx,word ptr [esi+ecx]
   add       ecx,2
   //Reminder := Number mod J;
   mov       eax,edi
   xor       edx,edx
   div       ebx
   //if (Reminder = 0) then
   test      edx,edx
   jz        @IfEnd144
   cmp       ecx,30
   jae       @SPRPTest
   //until(Divisor > SqrtNumber);
   cmp       ebp,ebx
   jnb       @RepeatStart1
 @Repeat1End :
   mov       eax,1
   pop       ebx
   jmp       @Exit2
 @SPRPTest :
   pop       ebx
   //K := 0;
   xor       eax,eax
   //M := Number-1;
   mov       esi,edi
   sub       esi,1
   //Calculate d and s
 @RepeatStart2 :
   //M := M shr 1;
   shr       esi,1
   //Inc(K);
   add       eax,1
   //until Odd(M);
   test      esi,1
   jz        @RepeatStart2
   //if (Number < 46902241) then
   cmp       edi,46902241
   jb        @TwoBaseTest
 @ThreeBaseTest :
   //if StrongProbablePrimeDKCIA32_11(2, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_10(7, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_10(61, M, Number, K) then
   mov       ebp,eax
   push      eax
   mov       ecx,edi
   mov       edx,esi
   mov       eax,2
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   sub       esp,4
   mov       ecx,edi
   mov       edx,esi
   mov       eax,7
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   sub       esp,4
   mov       ecx,edi
   mov       edx,esi
   mov       eax,61
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   //Result := True;
   mov       al,1
   pop       esi
   pop       ebp
   pop       edi
   ret
 @TwoBaseTest :
   //if StrongProbablePrimeDKCIA32_10(48527, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_10(74729, M, Number, K) then
   cmp       edi,48527
   je        @ThreeBaseTest
   cmp       edi,74729
   je        @ThreeBaseTest
   mov       ebp,eax
   push      eax
   mov       ecx,edi
   mov       edx,esi
   mov       eax,48527
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   sub       esp,4
   mov       ecx,edi
   mov       edx,esi
   mov       eax,74729
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   //Result := True;
   mov       al,1
   //jmp       @Exit2
   pop       esi
   pop       ebp
   pop       edi
   ret
 @VerySmall :
   //if Number <= 1 then
   cmp       eax,1
   jbe       @ResultFalse
   //if Number <= 3 then
   cmp       eax,3
   jbe       @ResultTrue
   //if Number = 4 then
   cmp       eax,4
   jz        @ResultFalse
   //if Number = 5 then
   cmp       eax,5
   jz        @ResultTrue
   //if Number = 6 then
   cmp       eax,6
   jz        @ResultFalse
 @IfEnd6 :
   //Number = 7 then
 @ResultTrue :
   mov       al,1
   jmp       @Exit4
 @ResultFalse :
   xor       eax,eax
   //jmp       @Exit4
   ret
 @IfEnd144 :
   pop       ebx
   xor       eax,eax
   pop       esi
   pop       ebp
   pop       edi
   jmp       @Exit4
 @ExitFalse :
   xor       eax,eax
   pop       edi
   ret
 @IfEnd14 :
   xor       eax,eax
 @Exit2 :
   pop       esi
   pop       ebp
 @Exit5 :
   pop       edi
 @Exit4 :
end;

//Author:            Dennis Kjaer Christensen
//Date:              7/4 2006
//Instructionset(s): IA32, SSE
//Size: 337 + 120 + 30*2 = 517

function IsPrime_DKC_SSE_7(Number : Cardinal) : Boolean;
const
 LocalPrimeTable : array[0..29] of Word = (5,7,11,13,17,19,23,29,31,37,41,
                                           43,47,53,59,61,67,71,73,79,83,89,97,
                                           101,103,107,109,113,127,131);
asm
   //if Number <= 7 then
   cmp       eax,7
   jbe       @VerySmall
   //if Number mod 2 = 0 then
   test      eax,1
   jz        @ResultFalse
   //if Number mod 3 = 0 then
   mov       ecx,eax
   mov       edx,01010101010101010101010101010101b
   mul       edx
   mov       edx,ecx
   shr       ecx,1
   add       eax,ecx
   shr       ecx,2
   sub       eax,ecx
   and       eax,11000000000000000000000000000000b
   jz        @Exit4    //Result := False;
 @IfEnd11 :
   push      edi
   push      ebp
   push      esi
   push      ebx
 @IfEnd12 :
   //SqrtNumber := Round(Sqrt(Number));
   mov       edi,edx
   cvtsi2ss  xmm0,edi
   sqrtss    xmm0,xmm0
   cvttss2si ebp,xmm0
   xor       ecx,ecx
   mov       esi,offset LocalPrimeTable
   xor       ebx,ebx
 @RepeatStart1 :
   mov       bx,word ptr [esi+ecx]
   add       ecx,2
   //Reminder := Number mod J;
   mov       eax,edi
   xor       edx,edx
   div       ebx
   //if (Reminder = 0) then
   test      edx,edx
   jz        @IfEnd144
   cmp       ecx,30
   jae       @SPRPTest
   //until(Divisor > SqrtNumber);
   cmp       ebp,ebx
   jnb       @RepeatStart1
 @Repeat1End :
   mov       eax,1
   pop       ebx
   jmp       @Exit2
 @SPRPTest :
   pop       ebx
   //K := 0;
   xor       eax,eax
   //M := Number-1;
   mov       esi,edi
   sub       esi,1
   //Calculate d and s
 @RepeatStart2 :
   //M := M shr 1;
   shr       esi,1
   //Inc(K);
   add       eax,1
   //until Odd(M);
   test      esi,1
   jz        @RepeatStart2
   //if (Number < 46902241) then
   cmp       edi,46902241
   jb        @TwoBaseTest
 @ThreeBaseTest :
   //if StrongProbablePrimeDKCIA32_11(2, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_10(7, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_10(61, M, Number, K) then
   mov       ebp,eax
   push      eax
   mov       ecx,edi
   mov       edx,esi
   mov       eax,2
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   sub       esp,4
   mov       ecx,edi
   mov       edx,esi
   mov       eax,7
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   sub       esp,4
   mov       ecx,edi
   mov       edx,esi
   mov       eax,61
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   //Result := True;
   mov       al,1
   pop       esi
   pop       ebp
   pop       edi
   ret
 @TwoBaseTest :
   //if StrongProbablePrimeDKCIA32_10(48527, M, Number, K) and
   //  StrongProbablePrimeDKCIA32_10(74729, M, Number, K) then
   cmp       edi,48527
   je        @ThreeBaseTest
   cmp       edi,74729
   je        @ThreeBaseTest
   mov       ebp,eax
   push      eax
   mov       ecx,edi
   mov       edx,esi
   mov       eax,48527
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   sub       esp,4
   mov       ecx,edi
   mov       edx,esi
   mov       eax,74729
   call      StrongProbablePrime_DKC_IA32_10
   test      al,al
   jz        @IfEnd14
   //Result := True;
   mov       al,1
   pop       esi
   pop       ebp
   pop       edi
   ret
 @VerySmall :
   //if Number <= 1 then
   cmp       eax,1
   jbe       @ResultFalse
   //if Number <= 3 then
   cmp       eax,3
   jbe       @ResultTrue
   //if Number = 4 then
   cmp       eax,4
   jz        @ResultFalse
   //if Number = 5 then
   cmp       eax,5
   jz        @ResultTrue
   //if Number = 6 then
   cmp       eax,6
   jz        @ResultFalse
 @IfEnd6 :
   //Number = 7 then
 @ResultTrue :
   mov       al,1
   ret
 @ResultFalse :
   xor       eax,eax
   ret
 @IfEnd144 :
   pop       ebx
   xor       eax,eax
   pop       esi
   pop       ebp
   pop       edi
   ret
 @ExitFalse :
   xor       eax,eax
   pop       edi
   ret
 @IfEnd14 :
   xor       eax,eax
 @Exit2 :
   pop       esi
   pop       ebp
 @Exit5 :
   pop       edi
 @Exit4 :
end;

function FillPrimeTable(NoOfNumbers : Cardinal) : Cardinal;
var
 I1, I2, I3, I4, Divisor, MaxUsedEntry : Cardinal;
 Done : Boolean;

begin
 SetLength(PrimeTable, NoOfNumbers);
 for I1 := 0 to NoOfNumbers - 1 do
  PrimeTable[I1] := I1+2;
 for I2 := 0 to Round(Sqrt(NoOfNumbers - 1)) do
  begin
   //Divisor := 1;    //[Pascal Hint] IsPrimeDKCUnit.pas(1909): H2077 Value assigned to 'Divisor' never used
   //[Pascal Warning] IsPrimeDKCUnit.pas(1917): W1036 Variable 'Divisor' might not have been initialized
   if PrimeTable[I2] <> 0 then
    Divisor := PrimeTable[I2]
   else
    Continue;
   for I3 := I2+1 to NoOfNumbers - 1 do
    begin
     if (PrimeTable[I3] mod Divisor = 0) then
      PrimeTable[I3] := 0;
    end;
  end;
 repeat
  Done := True;
  for I4 := 0 to NoOfNumbers - 2 do
   begin
    if (PrimeTable[I4] = 0) and (PrimeTable[I4+1] <> 0) then
     begin
      PrimeTable[I4] := PrimeTable[I4+1];
      PrimeTable[I4+1] := 0;
      Done := False;
     end;
   end;
 until (Done);
 MaxUsedEntry := NoOfNumbers;
 repeat
  Dec(MaxUsedEntry);
 until PrimeTable[MaxUsedEntry] <> 0;
 SetLength(PrimeTable, MaxUsedEntry+1);
 Result := MaxUsedEntry +1;
end;

procedure InitializePrimeTable(NoOfPrimesWanted : Cardinal);
var
 NoOfNumbers, NoOfPrimes, EstimatedNoOfPrimes : Cardinal;
 X : Extended;
begin
 NoOfNumbers := 2;
 repeat
  Inc(NoOfNumbers);
  X := NoOfNumbers;
  EstimatedNoOfPrimes := Round(X / (Ln(X)-1));
 until EstimatedNoOfPrimes = NoOfPrimesWanted;
 NoOfPrimes := FillPrimeTable(NoOfNumbers);
 if NoOfPrimes = NoOfPrimesWanted then
  Exit
 else if NoOfPrimes < NoOfPrimesWanted then
  begin
   repeat
    Inc(NoOfNumbers);
    NoOfPrimes := FillPrimeTable(NoOfNumbers);
   until NoOfPrimes = NoOfPrimesWanted;
  end
 else
  begin
   repeat
    Dec(NoOfNumbers);
    NoOfPrimes := FillPrimeTable(NoOfNumbers);
   until NoOfPrimes = NoOfPrimesWanted;
  end;
end;

initialization

 InitializePrimeTable(NoOfPrimesWanted);

end.
