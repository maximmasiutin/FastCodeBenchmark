unit UtilsUnit;

interface

{$INCLUDE Version.inc}

{$IFDEF Delphi2005Plus}
  {$WARN UNSAFE_CODE OFF}
{$ENDIF}

uses
  Classes, Math, SysUtils;

function AverageTrimmed(const Values: array of Int64; TrimMin, TrimMax: Integer): Double;
function CompareNum(const N1, N2: Double): Integer;
function CompareStr(const S1, S2: string): Integer;
function DelimitedText(Strings: TStrings; Delimiter: Char): string;
function Floor64(const X: Extended): Int64;
function Min(const Values: array of Int64): Int64;
function QuoteString(const S: string): string;
function Random32(RangeMin, RangeMax: Integer): Integer;
function Random64(RangeMin, RangeMax: Int64): Int64;
function RandomLogarithmic32: Integer;
function RandomLogarithmic64: Int64;
function RandomSign: Integer;
{$IFNDEF Delphi6Plus}
function TryStrToFloat(const S: string; out Value: Double): Boolean;
{$ENDIF}

implementation

function AverageTrimmed(const Values: array of Int64; TrimMin, TrimMax: Integer): Double;
var
  Count, I, J, Position: Integer;
begin
  Count := 0;
  Result := 0;

  for I := Low(Values) to High(Values) do
  begin
    Position := 0;
    for J := Low(Values) to High(Values) do
      if (Values[I] > Values[J]) or ((Values[I] = Values[J]) and (I > J)) then
        Inc(Position);

    if (TrimMin <= Position) and (Position < Length(Values) - TrimMax) then
    begin
      Inc(Count);
      Result := Result + Values[I];
    end;
  end;

  Result := Result / Count;
end;

function CompareNum(const N1, N2: Double): Integer;
begin
  if N1 > N2 then
    Result := 1
  else
    if N1 = N2 then
      Result := 0
    else
      Result := -1;
end;

function CompareStr(const S1, S2: string): Integer;
var
  F1, F2: Boolean;
  N1, N2: Double;
begin
  F1 := TryStrToFloat(S1, N1);
  F2 := TryStrToFloat(S2, N2);

  if F1 then
    if F2 then
    begin
      if N1 > N2 then
        Result := 1
      else
        if N1 = N2 then
          Result := 0
        else
          Result := -1;
    end
    else
      Result := -1
  else
    if F2 then
      Result := 1
    else
      Result := SysUtils.CompareStr(LowerCase(S1), LowerCase(S2));
end;

function DelimitedText(Strings: TStrings; Delimiter: Char): string;
begin
  {$IFDEF Delphi6Plus}
    Strings.Delimiter := Delimiter;
    Result := Strings.DelimitedText;
  {$ELSE}
    Result := StringReplace(Strings.Text, #13#10, Delimiter, [rfReplaceAll]);
  {$ENDIF}
end;

function Floor64(const X: Extended): Int64;
begin
  Result := Trunc(X);
  if Frac(X) < 0 then
    Dec(Result);
end;

function Min(const Values: array of Int64): Int64;
var
  I: Integer;
begin
  Result := High(Int64);
  for I := Low(Values) to High(Values) do
    if Values[I] < Result then
      Result := Values[I];
end;

function QuoteString(const S: string): string;
var
  I, ResLen: Integer;
  InQuote, Printable: Boolean;

 procedure AddString(const Str: string);
 var
   I: Integer;
 begin
   if ResLen+Length(Str) > Length(Result) then
     SetLength(Result, Length(Result)+Length(S));
   for I := 1 to Length(Str) do
   begin
     Inc(ResLen);
     Result[ResLen] := Str[I];
   end;
 end;

begin
  if S = '' then
  begin
    Result := '''''';
    Exit;
  end;
  SetLength(Result, Length(S)+2);
  ResLen := 0;
  InQuote := False;
  for I := 1 to Length(S) do
  begin
    Printable := S[I] in [#32..#127];
    if Printable <> InQuote then
    begin
      AddString('''');
      InQuote := not InQuote;
    end;
    if Printable then
      if S[I] = '''' then
        AddString('''''')
      else
        AddString(S[I])
    else
      AddString('#'+IntToStr(Ord(S[I])));
  end;
  if InQuote then
    AddString('''');
  Result := Copy(Result, 1, ResLen);
end;

// This random function can generate random numbers over the entire Integer range
function Random32(RangeMin, RangeMax: Integer): Integer;
begin
  Result := Random64(Low(Integer), High(Integer));
end;

// This random function can generate random numbers over the entire Int64 range
// TODO Find a better source of 64-bit randomness?
function Random64(RangeMin, RangeMax: Int64): Int64;

 function Mul64Hi(X, Y: Int64): Int64;
 asm
 //push  ebp
 //mov   ebp,   esp
   sub   esp,   16
   xor   ecx,   ecx
   mov   dword ptr [esp + 8], ecx
   mov   dword ptr [esp + 12], ecx

   mov   eax,   [ebp + 16]
   mul   dword ptr [ebp + 8]
   mov   dword ptr [esp], eax
   mov   dword ptr [esp + 4], edx

   mov   eax,   [ebp + 20]
   mul   dword ptr [ebp + 8]
   add   dword ptr [esp + 4], eax
   adc   dword ptr [esp + 8], edx
   adc   dword ptr [esp + 12], ecx

   mov   eax,   [ebp + 16]
   mul   dword ptr [ebp + 12]
   add   dword ptr [esp + 4], eax
   adc   dword ptr [esp + 8], edx
   adc   dword ptr [esp + 12], ecx

   mov   eax,   [ebp + 20]
   mul   dword ptr [ebp + 12]
   add   dword ptr [esp + 8], eax
   adc   dword ptr [esp + 12], edx

   mov   eax,   [esp + 8]
   mov   edx,   [esp + 12]

   add   esp,   16
 //pop   ebp
 end;

 function RandInt64: Int64;
 asm
   mov     eax,   System.RandSeed
   imul    edx,   eax,   $08088405
   inc     edx
   imul    eax,   edx,   $08088405
   inc     eax
   mov     System.RandSeed, eax
 end;

begin
  Result := RandInt64;
  if (RangeMin <> Low(Int64)) or (RangeMax <> High(Int64)) then
    Result := Mul64Hi(Result, RangeMax - RangeMin + 1) + RangeMin;
end;

function RandomLogarithmic32: Integer;
const
  LN_MAXINT = 21.487562;    // Ln(2^31 - 1), rounded down for safety
  INT_COUNT = 4294967296.0; // Number of 32-bit integers as a float number
var
  LogValue: Extended;
begin
  LogValue := (Random + Random / INT_COUNT) * LN_MAXINT;
  Result := Floor(Exp(LogValue));
end;

function RandomLogarithmic64: Int64;
const
  LN_MAXINT = 43.668272;    // Ln(2^63 - 1), rounded down for safety
  INT_COUNT = 4294967296.0; // Number of 32-bit integers as a float number
var
  LogValue: Extended;
begin
  LogValue := (Random + Random / INT_COUNT) * LN_MAXINT;
  Result := Floor64(Exp(LogValue));
end;

function RandomSign: Integer;
begin
  Result := Random(2) * 2 - 1;
end;

{$IFNDEF Delphi6Plus}
function TryStrToFloat(const S: string; out Value: Double): Boolean;
begin
  try
    Value := StrToFloat(S);
    Result := True;
  except
    Result := False;
  end
end;
{$ENDIF}

end.
