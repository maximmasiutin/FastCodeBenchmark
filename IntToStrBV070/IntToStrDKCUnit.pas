unit IntToStrDKCUnit;

interface

{$INCLUDE Defines.inc}

uses
  FastcodeChallengeIntToStr32Unit,
  FastcodeChallengeUnit;

{ *** Range checking disabled *** }

implementation

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}

function IntToStr_DKC_Pas_5_a(I : Integer): string;
var
  J, Remainder, K, Q, U : Integer;
  DigitArray : array[1..10] of Byte;
const
  CharArray : array[0..9] of Char = ('0', '1', '2', '3', '4', '5', '6', '7',
   '8', '9');
begin
 if I = Low(Integer) then
  Result := '-2147483648'
 else
 begin
  Result := '';
  if I < 0 then
   J := -I
  else
   J := I;
  K := 0;
  repeat
   U := J div 10;
   Remainder := J - 10 * U;
   J := U;
   Inc(K);
   DigitArray[K] := Remainder;
  until (J = 0);
  if I >= 0 then
   begin
    SetLength(Result, K);
    for Q := 1 to K do
     Result[Q] := CharArray[DigitArray[K-Q+1]];
    Result[K+1] := #0;
   end
  else
   begin
    SetLength(Result, K+1);
    Result[1] := '-';
    for Q := 1 to K do
     Result[Q+1] := CharArray[DigitArray[K-Q+1]];
    Result[K+2] := #0;
   end;
 end;
end;

{$ifdef RangeCheckWasOn}
  {$R+}
{$endif}

procedure DivMod_DKC_IA32_1_a(Dividend: Integer; Divisor: Integer;
  var Result: Integer; var Remainder: Integer);
asm
 push esi
 mov  esi,edx
 //Remainder := Dividend mod Divisor;
 //Result := Dividend div Divisor;
 cdq
 idiv esi
 mov  [ecx],eax
 mov  eax,[ebp+$08]
 mov  [eax],edx
 pop  esi
 pop  ebp
 ret  $0004
end;

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}

function IntToStr_DKC_IA32_3_a(I : Integer) : String;
var
 J, Remainder, K, Q : Integer;
 DigitArray : array[1..10] of Byte;
const
 CharArray : array[0..9] of Char = ('0', '1', '2', '3', '4', '5', '6', '7',
'8', '9');

begin
 if I = Low(Integer) then
  Result := '-2147483648'
 else
 begin
  Result := '';
  if I < 0 then
   J := -I
  else
   J := I;
  K := 0;
  repeat
   DivMod_DKC_IA32_1_a(J, 10, J, Remainder);
   Inc(K);
   DigitArray[K] := Remainder;
  until (J = 0);
  if I >= 0 then
   begin
    SetLength(Result, K);
    for Q := 1 to K do
     Result[Q] := CharArray[DigitArray[K-Q+1]];
    Result[K+1] := #0;
   end
  else
   begin
    SetLength(Result, K+1);
    Result[1] := '-';
    for Q := 1 to K do
     Result[Q+1] := CharArray[DigitArray[K-Q+1]];
    Result[K+2] := #0;
   end;
 end;
end;

{$ifdef RangeCheckWasOn}
  {$R+}
{$endif}

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}

function IntToStr_DKC_Pas_5_b(I : Integer): string;
var
  J, Remainder, K, Q, U : Integer;
  DigitArray : array[1..10] of Byte;
const
  CharArray : array[0..9] of Char = ('0', '1', '2', '3', '4', '5', '6', '7',
   '8', '9');
begin
 if I = Low(Integer) then
  Result := '-2147483648'
 else
 begin
  Result := '';
  if I < 0 then
   J := -I
  else
   J := I;
  K := 0;
  repeat
   U := J div 10;
   Remainder := J - 10 * U;
   J := U;
   Inc(K);
   DigitArray[K] := Remainder;
  until (J = 0);
  if I >= 0 then
   begin
    SetLength(Result, K);
    for Q := 1 to K do
     Result[Q] := CharArray[DigitArray[K-Q+1]];
    Result[K+1] := #0;
   end
  else
   begin
    SetLength(Result, K+1);
    Result[1] := '-';
    for Q := 1 to K do
     Result[Q+1] := CharArray[DigitArray[K-Q+1]];
    Result[K+2] := #0;
   end;
 end;
end;

{$ifdef RangeCheckWasOn}
  {$R+}
{$endif}

procedure DivMod_DKC_IA32_1_b(Dividend: Integer; Divisor: Integer;
  var Result: Integer; var Remainder: Integer);
asm
 push esi
 mov  esi,edx
 //Remainder := Dividend mod Divisor;
 //Result := Dividend div Divisor;
 cdq
 idiv esi
 mov  [ecx],eax
 mov  eax,[ebp+$08]
 mov  [eax],edx
 pop  esi
 pop  ebp
 ret  $0004
end;

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}

function IntToStr_DKC_IA32_3_b(I : Integer) : String;
var
 J, Remainder, K, Q : Integer;
 DigitArray : array[1..10] of Byte;
const
 CharArray : array[0..9] of Char = ('0', '1', '2', '3', '4', '5', '6', '7',
'8', '9');

begin
 if I = Low(Integer) then
  Result := '-2147483648'
 else
 begin
  Result := '';
  if I < 0 then
   J := -I
  else
   J := I;
  K := 0;
  repeat
   DivMod_DKC_IA32_1_b(J, 10, J, Remainder);
   Inc(K);
   DigitArray[K] := Remainder;
  until (J = 0);
  if I >= 0 then
   begin
    SetLength(Result, K);
    for Q := 1 to K do
     Result[Q] := CharArray[DigitArray[K-Q+1]];
    Result[K+1] := #0;
   end
  else
   begin
    SetLength(Result, K+1);
    Result[1] := '-';
    for Q := 1 to K do
     Result[Q+1] := CharArray[DigitArray[K-Q+1]];
    Result[K+2] := #0;
   end;
 end;
end;

{$ifdef RangeCheckWasOn}
  {$R+}
{$endif}

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}

function IntToStr_DKC_Pas_5_c(I : Integer): string;
var
  J, Remainder, K, Q, U : Integer;
  DigitArray : array[1..10] of Byte;
const
  CharArray : array[0..9] of Char = ('0', '1', '2', '3', '4', '5', '6', '7',
   '8', '9');
begin
 if I = Low(Integer) then
  Result := '-2147483648'
 else
 begin
  Result := '';
  if I < 0 then
   J := -I
  else
   J := I;
  K := 0;
  repeat
   U := J div 10;
   Remainder := J - 10 * U;
   J := U;
   Inc(K);
   DigitArray[K] := Remainder;
  until (J = 0);
  if I >= 0 then
   begin
    SetLength(Result, K);
    for Q := 1 to K do
     Result[Q] := CharArray[DigitArray[K-Q+1]];
    Result[K+1] := #0;
   end
  else
   begin
    SetLength(Result, K+1);
    Result[1] := '-';
    for Q := 1 to K do
     Result[Q+1] := CharArray[DigitArray[K-Q+1]];
    Result[K+2] := #0;
   end;
 end;
end;

{$ifdef RangeCheckWasOn}
  {$R+}
{$endif}

procedure DivMod_DKC_IA32_1_c(Dividend: Integer; Divisor: Integer;
  var Result: Integer; var Remainder: Integer);
asm
 push esi
 mov  esi,edx
 //Remainder := Dividend mod Divisor;
 //Result := Dividend div Divisor;
 cdq
 idiv esi
 mov  [ecx],eax
 mov  eax,[ebp+$08]
 mov  [eax],edx
 pop  esi
 pop  ebp
 ret  $0004
end;

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}

function IntToStr_DKC_IA32_3_c(I : Integer) : String;
var
 J, Remainder, K, Q : Integer;
 DigitArray : array[1..10] of Byte;
const
 CharArray : array[0..9] of Char = ('0', '1', '2', '3', '4', '5', '6', '7',
'8', '9');

begin
 if I = Low(Integer) then
  Result := '-2147483648'
 else
 begin
  Result := '';
  if I < 0 then
   J := -I
  else
   J := I;
  K := 0;
  repeat
   DivMod_DKC_IA32_1_c(J, 10, J, Remainder);
   Inc(K);
   DigitArray[K] := Remainder;
  until (J = 0);
  if I >= 0 then
   begin
    SetLength(Result, K);
    for Q := 1 to K do
     Result[Q] := CharArray[DigitArray[K-Q+1]];
    Result[K+1] := #0;
   end
  else
   begin
    SetLength(Result, K+1);
    Result[1] := '-';
    for Q := 1 to K do
     Result[Q+1] := CharArray[DigitArray[K-Q+1]];
    Result[K+2] := #0;
   end;
 end;
end;

{$ifdef RangeCheckWasOn}
  {$R+}
{$endif}

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}

function IntToStr_DKC_Pas_5_d(I : Integer): string;
var
  J, Remainder, K, Q, U : Integer;
  DigitArray : array[1..10] of Byte;
const
  CharArray : array[0..9] of Char = ('0', '1', '2', '3', '4', '5', '6', '7',
   '8', '9');
begin
 if I = Low(Integer) then
  Result := '-2147483648'
 else
 begin
  Result := '';
  if I < 0 then
   J := -I
  else
   J := I;
  K := 0;
  repeat
   U := J div 10;
   Remainder := J - 10 * U;
   J := U;
   Inc(K);
   DigitArray[K] := Remainder;
  until (J = 0);
  if I >= 0 then
   begin
    SetLength(Result, K);
    for Q := 1 to K do
     Result[Q] := CharArray[DigitArray[K-Q+1]];
    Result[K+1] := #0;
   end
  else
   begin
    SetLength(Result, K+1);
    Result[1] := '-';
    for Q := 1 to K do
     Result[Q+1] := CharArray[DigitArray[K-Q+1]];
    Result[K+2] := #0;
   end;
 end;
end;

{$ifdef RangeCheckWasOn}
  {$R+}
{$endif}

procedure DivMod_DKC_IA32_1_d(Dividend: Integer; Divisor: Integer;
  var Result: Integer; var Remainder: Integer);
asm
 push esi
 mov  esi,edx
 //Remainder := Dividend mod Divisor;
 //Result := Dividend div Divisor;
 cdq
 idiv esi
 mov  [ecx],eax
 mov  eax,[ebp+$08]
 mov  [eax],edx
 pop  esi
 pop  ebp
 ret  $0004
end;

{$ifopt R+}
  {$define RangeCheckWasOn}
  {$R-}
{$endif}

function IntToStr_DKC_IA32_3_d(I : Integer) : String;
var
 J, Remainder, K, Q : Integer;
 DigitArray : array[1..10] of Byte;
const
 CharArray : array[0..9] of Char = ('0', '1', '2', '3', '4', '5', '6', '7',
'8', '9');

begin
 if I = Low(Integer) then
  Result := '-2147483648'
 else
 begin
  Result := '';
  if I < 0 then
   J := -I
  else
   J := I;
  K := 0;
  repeat
   DivMod_DKC_IA32_1_d(J, 10, J, Remainder);
   Inc(K);
   DigitArray[K] := Remainder;
  until (J = 0);
  if I >= 0 then
   begin
    SetLength(Result, K);
    for Q := 1 to K do
     Result[Q] := CharArray[DigitArray[K-Q+1]];
    Result[K+1] := #0;
   end
  else
   begin
    SetLength(Result, K+1);
    Result[1] := '-';
    for Q := 1 to K do
     Result[Q+1] := CharArray[DigitArray[K-Q+1]];
    Result[K+2] := #0;
   end;
 end;
end;

{$ifdef RangeCheckWasOn}
  {$R+}
{$endif}

initialization
begin
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_DKC_Pas_5_a',
'', @IntToStr_DKC_Pas_5_a, fccPas, fcaDKC));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_DKC_Pas_5_b',
'', @IntToStr_DKC_Pas_5_b, fccPas, fcaDKC));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_DKC_Pas_5_c',
'', @IntToStr_DKC_Pas_5_c, fccPas, fcaDKC));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_DKC_Pas_5_d',
'', @IntToStr_DKC_Pas_5_d, fccPas, fcaDKC));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_DKC_IA32_3_a',
  '', @IntToStr_DKC_IA32_3_a, fccIA32, fcaDKC));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_DKC_IA32_3_b',
'', @IntToStr_DKC_IA32_3_b, fccIA32, fcaDKC));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_DKC_IA32_3_c',
'', @IntToStr_DKC_IA32_3_c, fccIA32, fcaDKC));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_DKC_IA32_3_d',
'', @IntToStr_DKC_IA32_3_d, fccIA32, fcaDKC));
end;

end.

