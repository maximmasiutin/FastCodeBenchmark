unit IntToStrAIUnit;

interface

{$INCLUDE Defines.inc}

uses
  FastcodeChallengeUnit,
  FastcodeChallengeIntToStr32Unit,
  FastcodeChallengeIntToStr64Unit,
  SysUtils;

implementation

uses
  Windows, Math;

const
  PowersOfTen       : array[0..9] of cardinal =
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

  PowersOfTen64     : array[0..18] of Int64 =
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

  { Repeated subtraction, no divisions.  }

function IntToStr_AI_PAS_14_a(Value: Integer): string;
var
  Dig               : Integer;
  rl                : Integer;
  i                 : Integer;
  pten              : Integer;
  rp                : PChar;

begin

  if Value = Low(Integer) then begin
    Result := '-2147483648';
    Exit;
  end;

  if Value < 0 then begin
    Value := Abs(Value);
    rl := 1;
  end
  else begin
    rl := 0;
  end;

  if (Value < 10) then
    i := 0
  else if (Value < 100) then
    i := 1
  else if (Value < 1000) then
    i := 2
  else if (Value < 10000) then
    i := 3
  else if (Value < 100000) then
    i := 4
  else if (Value < 1000000) then
    i := 5
  else if (Value < 10000000) then
    i := 6
  else if (Value < 100000000) then
    i := 7
  else if (Value < 1000000000) then
    i := 8
  else
    i := 9;

  if (rl = 1) then begin                // Negative
    rl := rl + i + 1;

    if (Result = '')                    { Empty string }
    or (PInteger(Integer(Result) - 8)^ <> 1) { Ref count <> 1 }
    or ((Length(Result)) <> rl) then
      SetLength(Result, rl);            { Allocate }

    rp := PChar(Integer(Result));

    rp^ := '-';
    Inc(rp);
  end
  else begin                            // Positive
    rl := rl + i + 1;

    if (Result = '')                    { Empty string }
    or (PInteger(Integer(Result) - 8)^ <> 1) { Ref count <> 1 }
    or ((Length(Result)) <> rl) then
      SetLength(Result, rl);            { Allocate }

    rp := PChar(Integer(Result));

  end;

  while i > 0 do begin
    Dig := 0;
    pten := PowersOfTen[i];
    while (Value >= pten) do begin
      Inc(Dig);
      Dec(Value, pten);
    end;
    rp^ := Chr(Ord('0') + Dig);
    Inc(rp);
    Dec(i);
  end;
  PWord(rp)^ := (Ord('0') + Value);
end;

function IntToStr_AI_PAS_14_b(Value: Integer): string;
var
  Dig               : Integer;
  rl                : Integer;
  i                 : Integer;
  pten              : Integer;
  rp                : PChar;

begin

  if Value = Low(Integer) then begin
    Result := '-2147483648';
    Exit;
  end;

  if Value < 0 then begin
    Value := Abs(Value);
    rl := 1;
  end
  else begin
    rl := 0;
  end;

  if (Value < 10) then
    i := 0
  else if (Value < 100) then
    i := 1
  else if (Value < 1000) then
    i := 2
  else if (Value < 10000) then
    i := 3
  else if (Value < 100000) then
    i := 4
  else if (Value < 1000000) then
    i := 5
  else if (Value < 10000000) then
    i := 6
  else if (Value < 100000000) then
    i := 7
  else if (Value < 1000000000) then
    i := 8
  else
    i := 9;

  if (rl = 1) then begin                // Negative
    rl := rl + i + 1;

    if (Result = '')                    { Empty string }
    or (PInteger(Integer(Result) - 8)^ <> 1) { Ref count <> 1 }
    or ((Length(Result)) <> rl) then
      SetLength(Result, rl);            { Allocate }

    rp := PChar(Integer(Result));

    rp^ := '-';
    Inc(rp);
  end
  else begin                            // Positive
    rl := rl + i + 1;

    if (Result = '')                    { Empty string }
    or (PInteger(Integer(Result) - 8)^ <> 1) { Ref count <> 1 }
    or ((Length(Result)) <> rl) then
      SetLength(Result, rl);            { Allocate }

    rp := PChar(Integer(Result));

  end;

  while i > 0 do begin
    Dig := 0;
    pten := PowersOfTen[i];
    while (Value >= pten) do begin
      Inc(Dig);
      Dec(Value, pten);
    end;
    rp^ := Chr(Ord('0') + Dig);
    Inc(rp);
    Dec(i);
  end;
  PWord(rp)^ := (Ord('0') + Value);
end;

function IntToStr_AI_PAS_14_c(Value: Integer): string;
var
  Dig               : Integer;
  rl                : Integer;
  i                 : Integer;
  pten              : Integer;
  rp                : PChar;

begin

  if Value = Low(Integer) then begin
    Result := '-2147483648';
    Exit;
  end;

  if Value < 0 then begin
    Value := Abs(Value);
    rl := 1;
  end
  else begin
    rl := 0;
  end;

  if (Value < 10) then
    i := 0
  else if (Value < 100) then
    i := 1
  else if (Value < 1000) then
    i := 2
  else if (Value < 10000) then
    i := 3
  else if (Value < 100000) then
    i := 4
  else if (Value < 1000000) then
    i := 5
  else if (Value < 10000000) then
    i := 6
  else if (Value < 100000000) then
    i := 7
  else if (Value < 1000000000) then
    i := 8
  else
    i := 9;

  if (rl = 1) then begin                // Negative
    rl := rl + i + 1;

    if (Result = '')                    { Empty string }
    or (PInteger(Integer(Result) - 8)^ <> 1) { Ref count <> 1 }
    or ((Length(Result)) <> rl) then
      SetLength(Result, rl);            { Allocate }

    rp := PChar(Integer(Result));

    rp^ := '-';
    Inc(rp);
  end
  else begin                            // Positive
    rl := rl + i + 1;

    if (Result = '')                    { Empty string }
    or (PInteger(Integer(Result) - 8)^ <> 1) { Ref count <> 1 }
    or ((Length(Result)) <> rl) then
      SetLength(Result, rl);            { Allocate }

    rp := PChar(Integer(Result));

  end;

  while i > 0 do begin
    Dig := 0;
    pten := PowersOfTen[i];
    while (Value >= pten) do begin
      Inc(Dig);
      Dec(Value, pten);
    end;
    rp^ := Chr(Ord('0') + Dig);
    Inc(rp);
    Dec(i);
  end;
  PWord(rp)^ := (Ord('0') + Value);
end;

function IntToStr_AI_PAS_14_d(Value: Integer): string;
var
  Dig               : Integer;
  rl                : Integer;
  i                 : Integer;
  pten              : Integer;
  rp                : PChar;

begin

  if Value = Low(Integer) then begin
    Result := '-2147483648';
    Exit;
  end;

  if Value < 0 then begin
    Value := Abs(Value);
    rl := 1;
  end
  else begin
    rl := 0;
  end;

  if (Value < 10) then
    i := 0
  else if (Value < 100) then
    i := 1
  else if (Value < 1000) then
    i := 2
  else if (Value < 10000) then
    i := 3
  else if (Value < 100000) then
    i := 4
  else if (Value < 1000000) then
    i := 5
  else if (Value < 10000000) then
    i := 6
  else if (Value < 100000000) then
    i := 7
  else if (Value < 1000000000) then
    i := 8
  else
    i := 9;

  if (rl = 1) then begin                // Negative
    rl := rl + i + 1;

    if (Result = '')                    { Empty string }
    or (PInteger(Integer(Result) - 8)^ <> 1) { Ref count <> 1 }
    or ((Length(Result)) <> rl) then
      SetLength(Result, rl);            { Allocate }

    rp := PChar(Integer(Result));

    rp^ := '-';
    Inc(rp);
  end
  else begin                            // Positive
    rl := rl + i + 1;

    if (Result = '')                    { Empty string }
    or (PInteger(Integer(Result) - 8)^ <> 1) { Ref count <> 1 }
    or ((Length(Result)) <> rl) then
      SetLength(Result, rl);            { Allocate }

    rp := PChar(Integer(Result));

  end;

  while i > 0 do begin
    Dig := 0;
    pten := PowersOfTen[i];
    while (Value >= pten) do begin
      Inc(Dig);
      Dec(Value, pten);
    end;
    rp^ := Chr(Ord('0') + Dig);
    Inc(rp);
    Dec(i);
  end;
  PWord(rp)^ := (Ord('0') + Value);
end;

procedure FormatIntBuf_a(Value: Integer; var Buf: PChar; Digits: Integer);
var
  Dig               : Integer;
  pten              : Integer;
begin

  while Digits > 0 do begin

    Dig := Ord('0');
    pten := PowersOfTen[Digits];

    while (Value >= pten) do begin
      Inc(Dig);
      Dec(Value, pten);
    end;

    Buf^ := Chr(Dig);
    Inc(Buf);

    Dec(Digits);
  end;

  Buf^ := Chr(Ord('0') + Value);
  Inc(Buf);
end;

procedure FormatIntBuf_b(Value: Integer; var Buf: PChar; Digits: Integer);
var
  Dig               : Integer;
  pten              : Integer;
begin

  while Digits > 0 do begin

    Dig := Ord('0');
    pten := PowersOfTen[Digits];

    while (Value >= pten) do begin
      Inc(Dig);
      Dec(Value, pten);
    end;

    Buf^ := Chr(Dig);
    Inc(Buf);

    Dec(Digits);
  end;

  Buf^ := Chr(Ord('0') + Value);
  Inc(Buf);
end;

procedure FormatIntBuf_c(Value: Integer; var Buf: PChar; Digits: Integer);
var
  Dig               : Integer;
  pten              : Integer;
begin

  while Digits > 0 do begin

    Dig := Ord('0');
    pten := PowersOfTen[Digits];

    while (Value >= pten) do begin
      Inc(Dig);
      Dec(Value, pten);
    end;

    Buf^ := Chr(Dig);
    Inc(Buf);

    Dec(Digits);
  end;

  Buf^ := Chr(Ord('0') + Value);
  Inc(Buf);
end;

procedure FormatIntBuf_d(Value: Integer; var Buf: PChar; Digits: Integer);
var
  Dig               : Integer;
  pten              : Integer;
begin

  while Digits > 0 do begin

    Dig := Ord('0');
    pten := PowersOfTen[Digits];

    while (Value >= pten) do begin
      Inc(Dig);
      Dec(Value, pten);
    end;

    Buf^ := Chr(Dig);
    Inc(Buf);

    Dec(Digits);
  end;

  Buf^ := Chr(Ord('0') + Value);
  Inc(Buf);
end;

function IntToStr64_AI_PAS_15_a(Value: Int64): string;
var
  part1, part2, part3: Integer;
  part164, part264, part364: Int64;
  i1, i2, i3        : Integer;
  rl                : Integer;
  rp                : PChar;
  Neg               : Boolean;
begin

  if Value = Low(Int64) then begin
    Result := '-9223372036854775808';
  end
  else begin

    if (Value >= Low(Integer)) and (Value <= High(Integer)) then begin
      Result := IntToStr_AI_PAS_14_a(Value);
      Exit;
    end;

    if Value < 0 then begin
      Neg := True;
      Value := Abs(Value);
      rl := 2;
    end
    else begin
      Neg := False;
      rl := 1;
    end;

    part164 := Floor(Value / 10000000000);
    Value := Value - part164 * 10000000000; // mod
    part264 := Floor(Value / 100000);
    Value := Value - part264 * 100000;  // mod
    part364 := Value;

    part1 := part164;
    part2 := part264;
    part3 := part364;

    if (part1 = 0) then
      i1 := -1
    else if (part1 < 10) then
      i1 := 0
    else if (part1 < 100) then
      i1 := 1
    else if (part1 < 1000) then
      i1 := 2
    else if (part1 < 10000) then
      i1 := 3
    else if (part1 < 100000) then
      i1 := 4
    else if (part1 < 1000000) then
      i1 := 5
    else if (part1 < 10000000) then
      i1 := 6
    else if (part1 < 100000000) then
      i1 := 7
    else if (part1 < 1000000000) then
      i1 := 8
    else
      i1 := 9;

    i2 := 4;

    i3 := 4;


    rl := rl + i1 + i2 + i3 + 2;

    if (Result = '')                    { Empty string }
    or (PInteger(Integer(Result) - 8)^ <> 1) { Ref count <> 1 }
    or ((Length(Result)) <> rl) then
      SetLength(Result, rl);            { Allocate }

    rp := PChar(Integer(Result));

    if Neg then begin
      rp^ := '-';
      Inc(rp);
    end;

    if part1 > 0 then
      FormatIntBuf_a(part1, rp, i1);
    FormatIntBuf_a(part2, rp, i2);
    FormatIntBuf_a(part3, rp, i3);
    rp^ := #0;
  end
end;

function IntToStr64_AI_PAS_15_b(Value: Int64): string;
var
  part1, part2, part3: Integer;
  part164, part264, part364: Int64;
  i1, i2, i3        : Integer;
  rl                : Integer;
  rp                : PChar;
  Neg               : Boolean;
begin

  if Value = Low(Int64) then begin
    Result := '-9223372036854775808';
  end
  else begin

    if (Value >= Low(Integer)) and (Value <= High(Integer)) then begin
      Result := IntToStr_AI_PAS_14_b(Value);
      Exit;
    end;

    if Value < 0 then begin
      Neg := True;
      Value := Abs(Value);
      rl := 2;
    end
    else begin
      Neg := False;
      rl := 1;
    end;

    part164 := Floor(Value / 10000000000);
    Value := Value - part164 * 10000000000; // mod
    part264 := Floor(Value / 100000);
    Value := Value - part264 * 100000;  // mod
    part364 := Value;

    part1 := part164;
    part2 := part264;
    part3 := part364;

    if (part1 = 0) then
      i1 := -1
    else if (part1 < 10) then
      i1 := 0
    else if (part1 < 100) then
      i1 := 1
    else if (part1 < 1000) then
      i1 := 2
    else if (part1 < 10000) then
      i1 := 3
    else if (part1 < 100000) then
      i1 := 4
    else if (part1 < 1000000) then
      i1 := 5
    else if (part1 < 10000000) then
      i1 := 6
    else if (part1 < 100000000) then
      i1 := 7
    else if (part1 < 1000000000) then
      i1 := 8
    else
      i1 := 9;

    i2 := 4;

    i3 := 4;


    rl := rl + i1 + i2 + i3 + 2;

    if (Result = '')                    { Empty string }
    or (PInteger(Integer(Result) - 8)^ <> 1) { Ref count <> 1 }
    or ((Length(Result)) <> rl) then
      SetLength(Result, rl);            { Allocate }

    rp := PChar(Integer(Result));

    if Neg then begin
      rp^ := '-';
      Inc(rp);
    end;

    if part1 > 0 then
      FormatIntBuf_b(part1, rp, i1);
    FormatIntBuf_b(part2, rp, i2);
    FormatIntBuf_b(part3, rp, i3);
    rp^ := #0;
  end
end;

function IntToStr64_AI_PAS_15_c(Value: Int64): string;
var
  part1, part2, part3: Integer;
  part164, part264, part364: Int64;
  i1, i2, i3        : Integer;
  rl                : Integer;
  rp                : PChar;
  Neg               : Boolean;
begin

  if Value = Low(Int64) then begin
    Result := '-9223372036854775808';
  end
  else begin

    if (Value >= Low(Integer)) and (Value <= High(Integer)) then begin
      Result := IntToStr_AI_PAS_14_c(Value);
      Exit;
    end;

    if Value < 0 then begin
      Neg := True;
      Value := Abs(Value);
      rl := 2;
    end
    else begin
      Neg := False;
      rl := 1;
    end;

    part164 := Floor(Value / 10000000000);
    Value := Value - part164 * 10000000000; // mod
    part264 := Floor(Value / 100000);
    Value := Value - part264 * 100000;  // mod
    part364 := Value;

    part1 := part164;
    part2 := part264;
    part3 := part364;

    if (part1 = 0) then
      i1 := -1
    else if (part1 < 10) then
      i1 := 0
    else if (part1 < 100) then
      i1 := 1
    else if (part1 < 1000) then
      i1 := 2
    else if (part1 < 10000) then
      i1 := 3
    else if (part1 < 100000) then
      i1 := 4
    else if (part1 < 1000000) then
      i1 := 5
    else if (part1 < 10000000) then
      i1 := 6
    else if (part1 < 100000000) then
      i1 := 7
    else if (part1 < 1000000000) then
      i1 := 8
    else
      i1 := 9;

    i2 := 4;

    i3 := 4;


    rl := rl + i1 + i2 + i3 + 2;

    if (Result = '')                    { Empty string }
    or (PInteger(Integer(Result) - 8)^ <> 1) { Ref count <> 1 }
    or ((Length(Result)) <> rl) then
      SetLength(Result, rl);            { Allocate }

    rp := PChar(Integer(Result));

    if Neg then begin
      rp^ := '-';
      Inc(rp);
    end;

    if part1 > 0 then
      FormatIntBuf_c(part1, rp, i1);
    FormatIntBuf_c(part2, rp, i2);
    FormatIntBuf_c(part3, rp, i3);
    rp^ := #0;
  end
end;

function IntToStr64_AI_PAS_15_d(Value: Int64): string;
var
  part1, part2, part3: Integer;
  part164, part264, part364: Int64;
  i1, i2, i3        : Integer;
  rl                : Integer;
  rp                : PChar;
  Neg               : Boolean;
begin

  if Value = Low(Int64) then begin
    Result := '-9223372036854775808';
  end
  else begin

    if (Value >= Low(Integer)) and (Value <= High(Integer)) then begin
      Result := IntToStr_AI_PAS_14_d(Value);
      Exit;
    end;

    if Value < 0 then begin
      Neg := True;
      Value := Abs(Value);
      rl := 2;
    end
    else begin
      Neg := False;
      rl := 1;
    end;

    part164 := Floor(Value / 10000000000);
    Value := Value - part164 * 10000000000; // mod
    part264 := Floor(Value / 100000);
    Value := Value - part264 * 100000;  // mod
    part364 := Value;

    part1 := part164;
    part2 := part264;
    part3 := part364;

    if (part1 = 0) then
      i1 := -1
    else if (part1 < 10) then
      i1 := 0
    else if (part1 < 100) then
      i1 := 1
    else if (part1 < 1000) then
      i1 := 2
    else if (part1 < 10000) then
      i1 := 3
    else if (part1 < 100000) then
      i1 := 4
    else if (part1 < 1000000) then
      i1 := 5
    else if (part1 < 10000000) then
      i1 := 6
    else if (part1 < 100000000) then
      i1 := 7
    else if (part1 < 1000000000) then
      i1 := 8
    else
      i1 := 9;

    i2 := 4;

    i3 := 4;


    rl := rl + i1 + i2 + i3 + 2;

    if (Result = '')                    { Empty string }
    or (PInteger(Integer(Result) - 8)^ <> 1) { Ref count <> 1 }
    or ((Length(Result)) <> rl) then
      SetLength(Result, rl);            { Allocate }

    rp := PChar(Integer(Result));

    if Neg then begin
      rp^ := '-';
      Inc(rp);
    end;

    if part1 > 0 then
      FormatIntBuf_d(part1, rp, i1);
    FormatIntBuf_d(part2, rp, i2);
    FormatIntBuf_d(part3, rp, i3);
    rp^ := #0;
  end
end;

initialization
  begin
    ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_AI_PAS_14_a', 'Subtraction, powers of 10', @IntToStr_AI_PAS_14_a, fccPas, fcaAI));
    ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_AI_PAS_14_b', 'Subtraction, powers of 10', @IntToStr_AI_PAS_14_b, fccPas, fcaAI));
    ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_AI_PAS_14_c', 'Subtraction, powers of 10', @IntToStr_AI_PAS_14_c, fccPas, fcaAI));
    ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_AI_PAS_14_d', 'Subtraction, powers of 10', @IntToStr_AI_PAS_14_d, fccPas, fcaAI));
    ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_AI_PAS_15_a', '1/2/3 32 bit conversions', @IntToStr64_AI_PAS_15_a, fccPas, fcaAI));
    ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_AI_PAS_15_b', '1/2/3 32 bit conversions', @IntToStr64_AI_PAS_15_b, fccPas, fcaAI));
    ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_AI_PAS_15_c', '1/2/3 32 bit conversions', @IntToStr64_AI_PAS_15_c, fccPas, fcaAI));
    ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_AI_PAS_15_d', '1/2/3 32 bit conversions', @IntToStr64_AI_PAS_15_d, fccPas, fcaAI));
  end;

end.

