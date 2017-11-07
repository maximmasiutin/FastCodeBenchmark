unit IntToStrAIPas;

interface

uses
  FastCodeChallengeUnit, FastcodeChallengeIntToStrUnit,
  FastcodeChallengeIntToStr64Unit, SysUtils;

implementation

uses
  Windows, Math
  ;

const  
  PowersOfTen       : array[0..9] of Integer =
    (1,
    10,
    100,
    1000,
    10000,
    100000,
    1000000,
    10000000,
    100000000,
    1000000000
    );

  PowersOfTen64       : array[0..18] of Int64 =
    (1,
    10,
    100,
    1000,
    10000,
    100000,
    1000000,
    10000000,
    100000000,
    1000000000,
    10000000000,
    100000000000,
    1000000000000,
    10000000000000,
    100000000000000,
    1000000000000000,
    10000000000000000,
    100000000000000000,
    1000000000000000000
    );
{
  Repeated subtraction, no divisions.
}

function IntToStr_AI_PAS_5(Value: Integer): string;
var
  StoreAll          : Boolean;
  Dig               : Integer;
  rp                : PChar;
  rl                : Integer;
  i                 : Integer;
  Neg               : Boolean;
begin

  if Value < 0 then begin
    Value := Abs(Value);
    Neg := True;
    rl := 1;
  end
  else begin
    Neg := False;
    rl := 0;
  end;

  StoreAll := False;
  i := 9;

  while (i > 0) do begin
    Dig := 0;

    Value := Value - PowersOfTen[i];
    while (Value >= 0) do begin
      Value := Value - PowersOfTen[i];
      Inc(Dig);
    end;
    Value := Value + PowersOfTen[i];

    if (Dig > 0) then begin
      rl := rl + i + 1;
      if Length(Result) < rl then
        SetLength(Result, rl)
      else
        PInteger(Integer(Result) - 4)^ := rl;
      rp := @Result[1];
      StoreAll := True;
      if Neg then begin
        rp^ := '-';
        Inc(rp);
      end;
      rp^ := Chr(Ord('0') + Dig);
      Inc(rp);
      Dec(i);
      Break; // Leave for the optimized loop
    end;
    Dec(i);
  end;

  if not StoreAll then begin
    rl := rl + i + 1;
    if Length(Result) < rl then
      SetLength(Result, rl)
    else
      PInteger(Integer(Result) - 4)^ := rl;
    rp := @Result[1];
    if Neg then begin
      rp^ := '-';
      Inc(rp);
    end
  end;

// Optimized loop - we know we have to generate each digit now
  while i > 0 do begin

    Dig := 0;

    Value := Value - PowersOfTen[i];
    while (Value >= 0) do begin
      Value := Value - PowersOfTen[i];
      Inc(Dig);
    end;
    Value := Value + PowersOfTen[i];

    rp^ := Chr(Ord('0') + Dig);
    Inc(rp);

    Dec(i);
  end;

  rp^ := Chr(Ord('0') + Value);

end;

function IntToStr64_AI_PAS_5(Value: Int64): string;
var
  StoreAll          : Boolean;
  Dig               : Integer;
  rp                : PChar;
  rl                : Integer;
  i                 : Integer;
  Neg               : Boolean;
begin

  if Value < 0 then begin
    if Value = Low(Int64) then begin
      Result := '-9223372036854775808';
      Exit;
    end
    else begin
      Neg := True;
      Value := Abs(Value);
      rl := 1;
    end
  end
  else begin
    Neg := False;
    rl := 0;
  end;

  StoreAll := False;
  i := 18;

  while (i > 0) do begin
    Dig := 0;

    Value := Value - PowersOfTen64[i];
    while (Value >= 0) do begin
      Value := Value - PowersOfTen64[i];
      Inc(Dig);
    end;
    Value := Value + PowersOfTen64[i];

    if (Dig > 0) then begin
      rl := rl + i + 1;
      if Length(Result) < rl then
        SetLength(Result, rl)
      else
        PInteger(Integer(Result) - 4)^ := rl;
      rp := @Result[1];
      StoreAll := True;
      if Neg then begin
        rp^ := '-';
        Inc(rp);
      end;
      rp^ := Chr(Ord('0') + Dig);
      Inc(rp);
      Dec(i);
      Break;
    end;
    Dec(i);
  end;

  if not StoreAll then begin
    rl := rl + i + 1;
    if Length(Result) < rl then
      SetLength(Result, rl)
    else
      PInteger(Integer(Result) - 4)^ := rl;
    rp := @Result[1];
    if Neg then begin
      rp^ := '-';
      Inc(rp);
    end
  end;

  while i > 0 do begin

    Dig := 0;

    Value := Value - PowersOfTen64[i];
    while (Value >= 0) do begin
      Value := Value - PowersOfTen64[i];
      Inc(Dig);
    end;
    Value := Value + PowersOfTen64[i];

    rp^ := Chr(Ord('0') + Dig);
    Inc(rp);

    Dec(i);
  end;

  rp^ := Chr(Ord('0') + Value);

end;

const
  PowersTimes1_64: array[0..17] of Int64 = (1000000000000000000,
100000000000000000,
    10000000000000000, 1000000000000000, 100000000000000,
10000000000000,
    1000000000000, 100000000000, 10000000000, 1000000000, 100000000,
10000000,
    1000000, 100000, 10000, 1000, 100, 10);
  PowersTimes2_64: array[0..17] of Int64 = (2000000000000000000,
200000000000000000,
    20000000000000000, 2000000000000000, 200000000000000,
20000000000000,
    2000000000000, 200000000000, 20000000000, 2000000000, 200000000,
20000000,
    2000000, 200000, 20000, 2000, 200, 20);
  PowersTimes4_64: array[0..17] of Int64 = (4000000000000000000,
400000000000000000,
    40000000000000000, 4000000000000000, 400000000000000,
40000000000000,
    4000000000000, 400000000000, 40000000000, 4000000000, 400000000,
40000000,
    4000000, 400000, 40000, 4000, 400, 40);
  PowersTimes8_64: array[0..17] of Int64 = (8000000000000000000,
800000000000000000,
    80000000000000000, 8000000000000000, 800000000000000,
80000000000000,
    8000000000000, 800000000000, 80000000000, 8000000000, 800000000,
80000000,
    8000000, 800000, 80000, 8000, 800, 80);

function IntToStr64_AZ_Pas_2(Value: Int64): string;
var
  CharIdx, DigitIdx, ResLen: Integer;
  Res: PChar;
  Sign: Boolean;
  UValue: Int64;
begin
  Result := '';
  if Value < 0 then
  begin
    if Value = Low(Int64) then
    begin
      Result := '-9223372036854775808';
      Exit;
    end;
    Sign := True;
    UValue := -Value;
  end
  else
  begin
    Sign := False;
    UValue := Value;
  end;
  if UValue < 10000000000 then
    if UValue < 10000 then
      if UValue < 100 then
        if UValue < 10 then
          ResLen := 1
        else
          ResLen := 2
      else
        if UValue < 1000 then
          ResLen := 3
        else
          ResLen := 4
    else
      if UValue < 1000000 then
        if UValue < 100000 then
          ResLen := 5
        else
          ResLen := 6
      else
        if UValue < 100000000 then
          if UValue < 10000000 then
            ResLen := 7
          else
            ResLen := 8
        else
          if UValue < 1000000000 then
            ResLen := 9
          else
            ResLen := 10
  else
    if UValue < 100000000000000 then
      if UValue < 1000000000000 then
        if UValue < 100000000000 then
          ResLen := 11
        else
          ResLen := 12
      else
        if UValue < 10000000000000 then
          ResLen := 13
        else
          ResLen := 14
    else
      if UValue < 10000000000000000 then
        if UValue < 1000000000000000 then
          ResLen := 15
        else
          ResLen := 16
      else
        if UValue < 1000000000000000000 then
          if UValue < 100000000000000000 then
            ResLen := 17
          else
            ResLen := 18
        else
          ResLen := 19;

  DigitIdx := 19 - ResLen;
  if Sign then
  begin
    SetLength(Result, ResLen + 1);
    Result[1] := '-';
    Res := PChar(LongWord(Result)) - DigitIdx + 1;
  end
  else
  begin
    SetLength(Result, ResLen);
    Res := PChar(LongWord(Result)) - DigitIdx;
  end;

  while DigitIdx < 18 do
  begin
    CharIdx := 0;
    if UValue >= PowersTimes8_64[DigitIdx] then begin Inc(CharIdx, 8);
Dec(UValue, PowersTimes8_64[DigitIdx]); end;
    if UValue >= PowersTimes4_64[DigitIdx] then begin Inc(CharIdx, 4);
Dec(UValue, PowersTimes4_64[DigitIdx]); end;
    if UValue >= PowersTimes2_64[DigitIdx] then begin Inc(CharIdx, 2);
Dec(UValue, PowersTimes2_64[DigitIdx]); end;
    if UValue >= PowersTimes1_64[DigitIdx] then begin Inc(CharIdx, 1);
Dec(UValue, PowersTimes1_64[DigitIdx]); end;
    (Res + DigitIdx)^ := Char(CharIdx + Ord('0'));
    Inc(DigitIdx);
  end;

  PChar(Res + DigitIdx)^ := Char(UValue + Ord('0'));
end;

initialization
begin
  ChallengeIntToStr.RegisterFunction(FunctionData('IntToStr_AI_PAS_5', @IntToStr_AI_PAS_5, fccPas, fcaAI));
  ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_AI_PAS_5', @IntToStr64_AI_PAS_5, fccPas, fcaAI));

  ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_AZ_Pas_2', @IntToStr64_AZ_Pas_2, fccPas, fcaAZ));

end;

end.

