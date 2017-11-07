unit IntToStrAZUnit;

interface

{$INCLUDE Defines.inc}

uses
  FastcodeChallengeUnit,
  FastcodeChallengeIntToStr32Unit,
  FastcodeChallengeIntToStr64Unit;

{ *** Range checking disabled ***

  IntToStr_AZ_Pas_1:
    Needed because Low(Integer) has no negative. Can be avoided by adding a
    check, resulting in the following change:

    if Value < 0 then
    begin
      // Start of added code
      if Value = Low(Integer) then
      begin
        Result := '-2147483648';
        Exit;
      end;
      // End of added code
      Sign := True;
      UValue := -Value;
}

implementation

{$ifopt Q+}
  {$define OverflowCheckEnabled}
  {$Q-}
{$endif}
{$ifopt R+}
  {$define RangeCheckEnabled}
  {$R-}
{$endif}

function IntToStr_AZ_Pas_1_a(Value: Integer): string;
var
  CharIdx: Integer;
  Res: PChar;
  Sign: Boolean;
  UValue: LongWord;
label
  Digit1, Digit2, Digit3, Digit4, Digit5, Digit6, Digit7, Digit8, Digit9;
begin
  if Value < 0 then
  begin
    Sign := True;
    UValue := -Value;
  end
  else
  begin
    Sign := False;
    UValue := Value;
  end;
  if UValue < 10000 then
    if UValue < 100 then
      if UValue < 10 then
      begin
        SetLength(Result, 1 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 9);
        goto Digit9;
      end
      else
      begin
        SetLength(Result, 2 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 8);
        goto Digit8;
      end
    else
      if UValue < 1000 then
      begin
        SetLength(Result, 3 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 7);
        goto Digit7;
      end
      else
      begin
        SetLength(Result, 4 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 6);
        goto Digit6;
      end
  else
    if UValue < 1000000 then
      if UValue < 100000 then
      begin
        SetLength(Result, 5 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 5);
        goto Digit5;
      end
      else
      begin
        SetLength(Result, 6 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 4);
        goto Digit4;
      end
    else
      if UValue < 100000000 then
        if UValue < 10000000 then
        begin
          SetLength(Result, 7 + Ord(Sign));
          if Sign then Result[1] := '-';
          Res := Pointer(Integer(Result) + Ord(Sign) - 3);
          goto Digit3;
        end
        else
        begin
          SetLength(Result, 8 + Ord(Sign));
          if Sign then Result[1] := '-';
          Res := Pointer(Integer(Result) + Ord(Sign) - 2);
          goto Digit2;
        end
      else
        if UValue < 1000000000 then
        begin
          SetLength(Result, 9 + Ord(Sign));
          if Sign then Result[1] := '-';
          Res := Pointer(Integer(Result) + Ord(Sign) - 1);
          goto Digit1;
        end
        else
        begin
          SetLength(Result, 10 + Ord(Sign));
          if Sign then Result[1] := '-';
          Res := Pointer(Integer(Result) + Ord(Sign));
        end;

  CharIdx := 0;
  if UValue >= 2000000000 then begin Inc(CharIdx, 2); Dec(UValue, 2000000000); end;
  if UValue >= 1000000000 then begin Inc(CharIdx, 1); Dec(UValue, 1000000000); end;
  Res^ := Char(CharIdx + Ord('0'));

Digit1:
  CharIdx := 0;
  if UValue >= 800000000 then begin Inc(CharIdx, 8); Dec(UValue, 800000000); end;
  if UValue >= 400000000 then begin Inc(CharIdx, 4); Dec(UValue, 400000000); end;
  if UValue >= 200000000 then begin Inc(CharIdx, 2); Dec(UValue, 200000000); end;
  if UValue >= 100000000 then begin Inc(CharIdx, 1); Dec(UValue, 100000000); end;
  (Res + 1)^ := Char(CharIdx + Ord('0'));

Digit2:
  CharIdx := 0;
  if UValue >= 80000000 then begin Inc(CharIdx, 8); Dec(UValue, 80000000); end;
  if UValue >= 40000000 then begin Inc(CharIdx, 4); Dec(UValue, 40000000); end;
  if UValue >= 20000000 then begin Inc(CharIdx, 2); Dec(UValue, 20000000); end;
  if UValue >= 10000000 then begin Inc(CharIdx, 1); Dec(UValue, 10000000); end;
  (Res + 2)^ := Char(CharIdx + Ord('0'));

Digit3:
  CharIdx := 0;
  if UValue >= 8000000 then begin Inc(CharIdx, 8); Dec(UValue, 8000000); end;
  if UValue >= 4000000 then begin Inc(CharIdx, 4); Dec(UValue, 4000000); end;
  if UValue >= 2000000 then begin Inc(CharIdx, 2); Dec(UValue, 2000000); end;
  if UValue >= 1000000 then begin Inc(CharIdx, 1); Dec(UValue, 1000000); end;
  (Res + 3)^ := Char(CharIdx + Ord('0'));

Digit4:
  CharIdx := 0;
  if UValue >= 800000 then begin Inc(CharIdx, 8); Dec(UValue, 800000); end;
  if UValue >= 400000 then begin Inc(CharIdx, 4); Dec(UValue, 400000); end;
  if UValue >= 200000 then begin Inc(CharIdx, 2); Dec(UValue, 200000); end;
  if UValue >= 100000 then begin Inc(CharIdx, 1); Dec(UValue, 100000); end;
  (Res + 4)^ := Char(CharIdx + Ord('0'));

Digit5:
  CharIdx := 0;
  if UValue >= 80000 then begin Inc(CharIdx, 8); Dec(UValue, 80000); end;
  if UValue >= 40000 then begin Inc(CharIdx, 4); Dec(UValue, 40000); end;
  if UValue >= 20000 then begin Inc(CharIdx, 2); Dec(UValue, 20000); end;
  if UValue >= 10000 then begin Inc(CharIdx, 1); Dec(UValue, 10000); end;
  (Res + 5)^ := Char(CharIdx + Ord('0'));

Digit6:
  CharIdx := 0;
  if UValue >= 8000 then begin Inc(CharIdx, 8); Dec(UValue, 8000); end;
  if UValue >= 4000 then begin Inc(CharIdx, 4); Dec(UValue, 4000); end;
  if UValue >= 2000 then begin Inc(CharIdx, 2); Dec(UValue, 2000); end;
  if UValue >= 1000 then begin Inc(CharIdx, 1); Dec(UValue, 1000); end;
  (Res + 6)^ := Char(CharIdx + Ord('0'));

Digit7:
  CharIdx := 0;
  if UValue >= 800 then begin Inc(CharIdx, 8); Dec(UValue, 800); end;
  if UValue >= 400 then begin Inc(CharIdx, 4); Dec(UValue, 400); end;
  if UValue >= 200 then begin Inc(CharIdx, 2); Dec(UValue, 200); end;
  if UValue >= 100 then begin Inc(CharIdx, 1); Dec(UValue, 100); end;
  (Res + 7)^ := Char(CharIdx + Ord('0'));

Digit8:
  CharIdx := 0;
  if UValue >= 80 then begin Inc(CharIdx, 8); Dec(UValue, 80); end;
  if UValue >= 40 then begin Inc(CharIdx, 4); Dec(UValue, 40); end;
  if UValue >= 20 then begin Inc(CharIdx, 2); Dec(UValue, 20); end;
  if UValue >= 10 then begin Inc(CharIdx, 1); Dec(UValue, 10); end;
  (Res + 8)^ := Char(CharIdx + Ord('0'));

Digit9:
  (Res + 9)^ := Char(UValue + Ord('0'));
end;

function IntToStr_AZ_Pas_1_b(Value: Integer): string;
var
  CharIdx: Integer;
  Res: PChar;
  Sign: Boolean;
  UValue: LongWord;
label
  Digit1, Digit2, Digit3, Digit4, Digit5, Digit6, Digit7, Digit8, Digit9;
begin
  if Value < 0 then
  begin
    Sign := True;
    UValue := -Value;
  end
  else
  begin
    Sign := False;
    UValue := Value;
  end;
  if UValue < 10000 then
    if UValue < 100 then
      if UValue < 10 then
      begin
        SetLength(Result, 1 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 9);
        goto Digit9;
      end
      else
      begin
        SetLength(Result, 2 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 8);
        goto Digit8;
      end
    else
      if UValue < 1000 then
      begin
        SetLength(Result, 3 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 7);
        goto Digit7;
      end
      else
      begin
        SetLength(Result, 4 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 6);
        goto Digit6;
      end
  else
    if UValue < 1000000 then
      if UValue < 100000 then
      begin
        SetLength(Result, 5 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 5);
        goto Digit5;
      end
      else
      begin
        SetLength(Result, 6 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 4);
        goto Digit4;
      end
    else
      if UValue < 100000000 then
        if UValue < 10000000 then
        begin
          SetLength(Result, 7 + Ord(Sign));
          if Sign then Result[1] := '-';
          Res := Pointer(Integer(Result) + Ord(Sign) - 3);
          goto Digit3;
        end
        else
        begin
          SetLength(Result, 8 + Ord(Sign));
          if Sign then Result[1] := '-';
          Res := Pointer(Integer(Result) + Ord(Sign) - 2);
          goto Digit2;
        end
      else
        if UValue < 1000000000 then
        begin
          SetLength(Result, 9 + Ord(Sign));
          if Sign then Result[1] := '-';
          Res := Pointer(Integer(Result) + Ord(Sign) - 1);
          goto Digit1;
        end
        else
        begin
          SetLength(Result, 10 + Ord(Sign));
          if Sign then Result[1] := '-';
          Res := Pointer(Integer(Result) + Ord(Sign));
        end;

  CharIdx := 0;
  if UValue >= 2000000000 then begin Inc(CharIdx, 2); Dec(UValue, 2000000000); end;
  if UValue >= 1000000000 then begin Inc(CharIdx, 1); Dec(UValue, 1000000000); end;
  Res^ := Char(CharIdx + Ord('0'));

Digit1:
  CharIdx := 0;
  if UValue >= 800000000 then begin Inc(CharIdx, 8); Dec(UValue, 800000000); end;
  if UValue >= 400000000 then begin Inc(CharIdx, 4); Dec(UValue, 400000000); end;
  if UValue >= 200000000 then begin Inc(CharIdx, 2); Dec(UValue, 200000000); end;
  if UValue >= 100000000 then begin Inc(CharIdx, 1); Dec(UValue, 100000000); end;
  (Res + 1)^ := Char(CharIdx + Ord('0'));

Digit2:
  CharIdx := 0;
  if UValue >= 80000000 then begin Inc(CharIdx, 8); Dec(UValue, 80000000); end;
  if UValue >= 40000000 then begin Inc(CharIdx, 4); Dec(UValue, 40000000); end;
  if UValue >= 20000000 then begin Inc(CharIdx, 2); Dec(UValue, 20000000); end;
  if UValue >= 10000000 then begin Inc(CharIdx, 1); Dec(UValue, 10000000); end;
  (Res + 2)^ := Char(CharIdx + Ord('0'));

Digit3:
  CharIdx := 0;
  if UValue >= 8000000 then begin Inc(CharIdx, 8); Dec(UValue, 8000000); end;
  if UValue >= 4000000 then begin Inc(CharIdx, 4); Dec(UValue, 4000000); end;
  if UValue >= 2000000 then begin Inc(CharIdx, 2); Dec(UValue, 2000000); end;
  if UValue >= 1000000 then begin Inc(CharIdx, 1); Dec(UValue, 1000000); end;
  (Res + 3)^ := Char(CharIdx + Ord('0'));

Digit4:
  CharIdx := 0;
  if UValue >= 800000 then begin Inc(CharIdx, 8); Dec(UValue, 800000); end;
  if UValue >= 400000 then begin Inc(CharIdx, 4); Dec(UValue, 400000); end;
  if UValue >= 200000 then begin Inc(CharIdx, 2); Dec(UValue, 200000); end;
  if UValue >= 100000 then begin Inc(CharIdx, 1); Dec(UValue, 100000); end;
  (Res + 4)^ := Char(CharIdx + Ord('0'));

Digit5:
  CharIdx := 0;
  if UValue >= 80000 then begin Inc(CharIdx, 8); Dec(UValue, 80000); end;
  if UValue >= 40000 then begin Inc(CharIdx, 4); Dec(UValue, 40000); end;
  if UValue >= 20000 then begin Inc(CharIdx, 2); Dec(UValue, 20000); end;
  if UValue >= 10000 then begin Inc(CharIdx, 1); Dec(UValue, 10000); end;
  (Res + 5)^ := Char(CharIdx + Ord('0'));

Digit6:
  CharIdx := 0;
  if UValue >= 8000 then begin Inc(CharIdx, 8); Dec(UValue, 8000); end;
  if UValue >= 4000 then begin Inc(CharIdx, 4); Dec(UValue, 4000); end;
  if UValue >= 2000 then begin Inc(CharIdx, 2); Dec(UValue, 2000); end;
  if UValue >= 1000 then begin Inc(CharIdx, 1); Dec(UValue, 1000); end;
  (Res + 6)^ := Char(CharIdx + Ord('0'));

Digit7:
  CharIdx := 0;
  if UValue >= 800 then begin Inc(CharIdx, 8); Dec(UValue, 800); end;
  if UValue >= 400 then begin Inc(CharIdx, 4); Dec(UValue, 400); end;
  if UValue >= 200 then begin Inc(CharIdx, 2); Dec(UValue, 200); end;
  if UValue >= 100 then begin Inc(CharIdx, 1); Dec(UValue, 100); end;
  (Res + 7)^ := Char(CharIdx + Ord('0'));

Digit8:
  CharIdx := 0;
  if UValue >= 80 then begin Inc(CharIdx, 8); Dec(UValue, 80); end;
  if UValue >= 40 then begin Inc(CharIdx, 4); Dec(UValue, 40); end;
  if UValue >= 20 then begin Inc(CharIdx, 2); Dec(UValue, 20); end;
  if UValue >= 10 then begin Inc(CharIdx, 1); Dec(UValue, 10); end;
  (Res + 8)^ := Char(CharIdx + Ord('0'));

Digit9:
  (Res + 9)^ := Char(UValue + Ord('0'));
end;

function IntToStr_AZ_Pas_1_c(Value: Integer): string;
var
  CharIdx: Integer;
  Res: PChar;
  Sign: Boolean;
  UValue: LongWord;
label
  Digit1, Digit2, Digit3, Digit4, Digit5, Digit6, Digit7, Digit8, Digit9;
begin
  if Value < 0 then
  begin
    Sign := True;
    UValue := -Value;
  end
  else
  begin
    Sign := False;
    UValue := Value;
  end;
  if UValue < 10000 then
    if UValue < 100 then
      if UValue < 10 then
      begin
        SetLength(Result, 1 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 9);
        goto Digit9;
      end
      else
      begin
        SetLength(Result, 2 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 8);
        goto Digit8;
      end
    else
      if UValue < 1000 then
      begin
        SetLength(Result, 3 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 7);
        goto Digit7;
      end
      else
      begin
        SetLength(Result, 4 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 6);
        goto Digit6;
      end
  else
    if UValue < 1000000 then
      if UValue < 100000 then
      begin
        SetLength(Result, 5 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 5);
        goto Digit5;
      end
      else
      begin
        SetLength(Result, 6 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 4);
        goto Digit4;
      end
    else
      if UValue < 100000000 then
        if UValue < 10000000 then
        begin
          SetLength(Result, 7 + Ord(Sign));
          if Sign then Result[1] := '-';
          Res := Pointer(Integer(Result) + Ord(Sign) - 3);
          goto Digit3;
        end
        else
        begin
          SetLength(Result, 8 + Ord(Sign));
          if Sign then Result[1] := '-';
          Res := Pointer(Integer(Result) + Ord(Sign) - 2);
          goto Digit2;
        end
      else
        if UValue < 1000000000 then
        begin
          SetLength(Result, 9 + Ord(Sign));
          if Sign then Result[1] := '-';
          Res := Pointer(Integer(Result) + Ord(Sign) - 1);
          goto Digit1;
        end
        else
        begin
          SetLength(Result, 10 + Ord(Sign));
          if Sign then Result[1] := '-';
          Res := Pointer(Integer(Result) + Ord(Sign));
        end;

  CharIdx := 0;
  if UValue >= 2000000000 then begin Inc(CharIdx, 2); Dec(UValue, 2000000000); end;
  if UValue >= 1000000000 then begin Inc(CharIdx, 1); Dec(UValue, 1000000000); end;
  Res^ := Char(CharIdx + Ord('0'));

Digit1:
  CharIdx := 0;
  if UValue >= 800000000 then begin Inc(CharIdx, 8); Dec(UValue, 800000000); end;
  if UValue >= 400000000 then begin Inc(CharIdx, 4); Dec(UValue, 400000000); end;
  if UValue >= 200000000 then begin Inc(CharIdx, 2); Dec(UValue, 200000000); end;
  if UValue >= 100000000 then begin Inc(CharIdx, 1); Dec(UValue, 100000000); end;
  (Res + 1)^ := Char(CharIdx + Ord('0'));

Digit2:
  CharIdx := 0;
  if UValue >= 80000000 then begin Inc(CharIdx, 8); Dec(UValue, 80000000); end;
  if UValue >= 40000000 then begin Inc(CharIdx, 4); Dec(UValue, 40000000); end;
  if UValue >= 20000000 then begin Inc(CharIdx, 2); Dec(UValue, 20000000); end;
  if UValue >= 10000000 then begin Inc(CharIdx, 1); Dec(UValue, 10000000); end;
  (Res + 2)^ := Char(CharIdx + Ord('0'));

Digit3:
  CharIdx := 0;
  if UValue >= 8000000 then begin Inc(CharIdx, 8); Dec(UValue, 8000000); end;
  if UValue >= 4000000 then begin Inc(CharIdx, 4); Dec(UValue, 4000000); end;
  if UValue >= 2000000 then begin Inc(CharIdx, 2); Dec(UValue, 2000000); end;
  if UValue >= 1000000 then begin Inc(CharIdx, 1); Dec(UValue, 1000000); end;
  (Res + 3)^ := Char(CharIdx + Ord('0'));

Digit4:
  CharIdx := 0;
  if UValue >= 800000 then begin Inc(CharIdx, 8); Dec(UValue, 800000); end;
  if UValue >= 400000 then begin Inc(CharIdx, 4); Dec(UValue, 400000); end;
  if UValue >= 200000 then begin Inc(CharIdx, 2); Dec(UValue, 200000); end;
  if UValue >= 100000 then begin Inc(CharIdx, 1); Dec(UValue, 100000); end;
  (Res + 4)^ := Char(CharIdx + Ord('0'));

Digit5:
  CharIdx := 0;
  if UValue >= 80000 then begin Inc(CharIdx, 8); Dec(UValue, 80000); end;
  if UValue >= 40000 then begin Inc(CharIdx, 4); Dec(UValue, 40000); end;
  if UValue >= 20000 then begin Inc(CharIdx, 2); Dec(UValue, 20000); end;
  if UValue >= 10000 then begin Inc(CharIdx, 1); Dec(UValue, 10000); end;
  (Res + 5)^ := Char(CharIdx + Ord('0'));

Digit6:
  CharIdx := 0;
  if UValue >= 8000 then begin Inc(CharIdx, 8); Dec(UValue, 8000); end;
  if UValue >= 4000 then begin Inc(CharIdx, 4); Dec(UValue, 4000); end;
  if UValue >= 2000 then begin Inc(CharIdx, 2); Dec(UValue, 2000); end;
  if UValue >= 1000 then begin Inc(CharIdx, 1); Dec(UValue, 1000); end;
  (Res + 6)^ := Char(CharIdx + Ord('0'));

Digit7:
  CharIdx := 0;
  if UValue >= 800 then begin Inc(CharIdx, 8); Dec(UValue, 800); end;
  if UValue >= 400 then begin Inc(CharIdx, 4); Dec(UValue, 400); end;
  if UValue >= 200 then begin Inc(CharIdx, 2); Dec(UValue, 200); end;
  if UValue >= 100 then begin Inc(CharIdx, 1); Dec(UValue, 100); end;
  (Res + 7)^ := Char(CharIdx + Ord('0'));

Digit8:
  CharIdx := 0;
  if UValue >= 80 then begin Inc(CharIdx, 8); Dec(UValue, 80); end;
  if UValue >= 40 then begin Inc(CharIdx, 4); Dec(UValue, 40); end;
  if UValue >= 20 then begin Inc(CharIdx, 2); Dec(UValue, 20); end;
  if UValue >= 10 then begin Inc(CharIdx, 1); Dec(UValue, 10); end;
  (Res + 8)^ := Char(CharIdx + Ord('0'));

Digit9:
  (Res + 9)^ := Char(UValue + Ord('0'));
end;

function IntToStr_AZ_Pas_1_d(Value: Integer): string;
var
  CharIdx: Integer;
  Res: PChar;
  Sign: Boolean;
  UValue: LongWord;
label
  Digit1, Digit2, Digit3, Digit4, Digit5, Digit6, Digit7, Digit8, Digit9;
begin
  if Value < 0 then
  begin
    Sign := True;
    UValue := -Value;
  end
  else
  begin
    Sign := False;
    UValue := Value;
  end;
  if UValue < 10000 then
    if UValue < 100 then
      if UValue < 10 then
      begin
        SetLength(Result, 1 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 9);
        goto Digit9;
      end
      else
      begin
        SetLength(Result, 2 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 8);
        goto Digit8;
      end
    else
      if UValue < 1000 then
      begin
        SetLength(Result, 3 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 7);
        goto Digit7;
      end
      else
      begin
        SetLength(Result, 4 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 6);
        goto Digit6;
      end
  else
    if UValue < 1000000 then
      if UValue < 100000 then
      begin
        SetLength(Result, 5 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 5);
        goto Digit5;
      end
      else
      begin
        SetLength(Result, 6 + Ord(Sign));
        if Sign then Result[1] := '-';
        Res := Pointer(Integer(Result) + Ord(Sign) - 4);
        goto Digit4;
      end
    else
      if UValue < 100000000 then
        if UValue < 10000000 then
        begin
          SetLength(Result, 7 + Ord(Sign));
          if Sign then Result[1] := '-';
          Res := Pointer(Integer(Result) + Ord(Sign) - 3);
          goto Digit3;
        end
        else
        begin
          SetLength(Result, 8 + Ord(Sign));
          if Sign then Result[1] := '-';
          Res := Pointer(Integer(Result) + Ord(Sign) - 2);
          goto Digit2;
        end
      else
        if UValue < 1000000000 then
        begin
          SetLength(Result, 9 + Ord(Sign));
          if Sign then Result[1] := '-';
          Res := Pointer(Integer(Result) + Ord(Sign) - 1);
          goto Digit1;
        end
        else
        begin
          SetLength(Result, 10 + Ord(Sign));
          if Sign then Result[1] := '-';
          Res := Pointer(Integer(Result) + Ord(Sign));
        end;

  CharIdx := 0;
  if UValue >= 2000000000 then begin Inc(CharIdx, 2); Dec(UValue, 2000000000); end;
  if UValue >= 1000000000 then begin Inc(CharIdx, 1); Dec(UValue, 1000000000); end;
  Res^ := Char(CharIdx + Ord('0'));

Digit1:
  CharIdx := 0;
  if UValue >= 800000000 then begin Inc(CharIdx, 8); Dec(UValue, 800000000); end;
  if UValue >= 400000000 then begin Inc(CharIdx, 4); Dec(UValue, 400000000); end;
  if UValue >= 200000000 then begin Inc(CharIdx, 2); Dec(UValue, 200000000); end;
  if UValue >= 100000000 then begin Inc(CharIdx, 1); Dec(UValue, 100000000); end;
  (Res + 1)^ := Char(CharIdx + Ord('0'));

Digit2:
  CharIdx := 0;
  if UValue >= 80000000 then begin Inc(CharIdx, 8); Dec(UValue, 80000000); end;
  if UValue >= 40000000 then begin Inc(CharIdx, 4); Dec(UValue, 40000000); end;
  if UValue >= 20000000 then begin Inc(CharIdx, 2); Dec(UValue, 20000000); end;
  if UValue >= 10000000 then begin Inc(CharIdx, 1); Dec(UValue, 10000000); end;
  (Res + 2)^ := Char(CharIdx + Ord('0'));

Digit3:
  CharIdx := 0;
  if UValue >= 8000000 then begin Inc(CharIdx, 8); Dec(UValue, 8000000); end;
  if UValue >= 4000000 then begin Inc(CharIdx, 4); Dec(UValue, 4000000); end;
  if UValue >= 2000000 then begin Inc(CharIdx, 2); Dec(UValue, 2000000); end;
  if UValue >= 1000000 then begin Inc(CharIdx, 1); Dec(UValue, 1000000); end;
  (Res + 3)^ := Char(CharIdx + Ord('0'));

Digit4:
  CharIdx := 0;
  if UValue >= 800000 then begin Inc(CharIdx, 8); Dec(UValue, 800000); end;
  if UValue >= 400000 then begin Inc(CharIdx, 4); Dec(UValue, 400000); end;
  if UValue >= 200000 then begin Inc(CharIdx, 2); Dec(UValue, 200000); end;
  if UValue >= 100000 then begin Inc(CharIdx, 1); Dec(UValue, 100000); end;
  (Res + 4)^ := Char(CharIdx + Ord('0'));

Digit5:
  CharIdx := 0;
  if UValue >= 80000 then begin Inc(CharIdx, 8); Dec(UValue, 80000); end;
  if UValue >= 40000 then begin Inc(CharIdx, 4); Dec(UValue, 40000); end;
  if UValue >= 20000 then begin Inc(CharIdx, 2); Dec(UValue, 20000); end;
  if UValue >= 10000 then begin Inc(CharIdx, 1); Dec(UValue, 10000); end;
  (Res + 5)^ := Char(CharIdx + Ord('0'));

Digit6:
  CharIdx := 0;
  if UValue >= 8000 then begin Inc(CharIdx, 8); Dec(UValue, 8000); end;
  if UValue >= 4000 then begin Inc(CharIdx, 4); Dec(UValue, 4000); end;
  if UValue >= 2000 then begin Inc(CharIdx, 2); Dec(UValue, 2000); end;
  if UValue >= 1000 then begin Inc(CharIdx, 1); Dec(UValue, 1000); end;
  (Res + 6)^ := Char(CharIdx + Ord('0'));

Digit7:
  CharIdx := 0;
  if UValue >= 800 then begin Inc(CharIdx, 8); Dec(UValue, 800); end;
  if UValue >= 400 then begin Inc(CharIdx, 4); Dec(UValue, 400); end;
  if UValue >= 200 then begin Inc(CharIdx, 2); Dec(UValue, 200); end;
  if UValue >= 100 then begin Inc(CharIdx, 1); Dec(UValue, 100); end;
  (Res + 7)^ := Char(CharIdx + Ord('0'));

Digit8:
  CharIdx := 0;
  if UValue >= 80 then begin Inc(CharIdx, 8); Dec(UValue, 80); end;
  if UValue >= 40 then begin Inc(CharIdx, 4); Dec(UValue, 40); end;
  if UValue >= 20 then begin Inc(CharIdx, 2); Dec(UValue, 20); end;
  if UValue >= 10 then begin Inc(CharIdx, 1); Dec(UValue, 10); end;
  (Res + 8)^ := Char(CharIdx + Ord('0'));

Digit9:
  (Res + 9)^ := Char(UValue + Ord('0'));
end;

{$ifdef OverflowCheckEnabled}
  {$Q+}
{$endif}
{$ifdef RangeCheckEnabled}
  {$R+}
{$endif}

function IntToStr64_AZ_Pas_2_a(Value: Int64): string;
const
  PowersTimes1_64: array[0..17] of Int64 = (1000000000000000000, 100000000000000000,
    10000000000000000, 1000000000000000, 100000000000000, 10000000000000,
    1000000000000, 100000000000, 10000000000, 1000000000, 100000000, 10000000,
    1000000, 100000, 10000, 1000, 100, 10);
  PowersTimes2_64: array[0..17] of Int64 = (2000000000000000000, 200000000000000000,
    20000000000000000, 2000000000000000, 200000000000000, 20000000000000,
    2000000000000, 200000000000, 20000000000, 2000000000, 200000000, 20000000,
    2000000, 200000, 20000, 2000, 200, 20);
  PowersTimes4_64: array[0..17] of Int64 = (4000000000000000000, 400000000000000000,
    40000000000000000, 4000000000000000, 400000000000000, 40000000000000,
    4000000000000, 400000000000, 40000000000, 4000000000, 400000000, 40000000,
    4000000, 400000, 40000, 4000, 400, 40);
  PowersTimes8_64: array[0..17] of Int64 = (8000000000000000000, 800000000000000000,
    80000000000000000, 8000000000000000, 800000000000000, 80000000000000,
    8000000000000, 800000000000, 80000000000, 8000000000, 800000000, 80000000,
    8000000, 800000, 80000, 8000, 800, 80);
var
  CharIdx, DigitIdx, ResLen: Integer;
  Res: PChar;
  Sign: Boolean;
  UValue: Int64;
begin
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
    if UValue >= PowersTimes8_64[DigitIdx] then begin Inc(CharIdx, 8); Dec(UValue, PowersTimes8_64[DigitIdx]); end;
    if UValue >= PowersTimes4_64[DigitIdx] then begin Inc(CharIdx, 4); Dec(UValue, PowersTimes4_64[DigitIdx]); end;
    if UValue >= PowersTimes2_64[DigitIdx] then begin Inc(CharIdx, 2); Dec(UValue, PowersTimes2_64[DigitIdx]); end;
    if UValue >= PowersTimes1_64[DigitIdx] then begin Inc(CharIdx, 1); Dec(UValue, PowersTimes1_64[DigitIdx]); end;
    (Res + DigitIdx)^ := Char(CharIdx + Ord('0'));
    Inc(DigitIdx);
  end;

  PChar(Res + DigitIdx)^ := Char(UValue + Ord('0'));
end;

function IntToStr64_AZ_Pas_2_b(Value: Int64): string;
const
  PowersTimes1_64: array[0..17] of Int64 = (1000000000000000000, 100000000000000000,
    10000000000000000, 1000000000000000, 100000000000000, 10000000000000,
    1000000000000, 100000000000, 10000000000, 1000000000, 100000000, 10000000,
    1000000, 100000, 10000, 1000, 100, 10);
  PowersTimes2_64: array[0..17] of Int64 = (2000000000000000000, 200000000000000000,
    20000000000000000, 2000000000000000, 200000000000000, 20000000000000,
    2000000000000, 200000000000, 20000000000, 2000000000, 200000000, 20000000,
    2000000, 200000, 20000, 2000, 200, 20);
  PowersTimes4_64: array[0..17] of Int64 = (4000000000000000000, 400000000000000000,
    40000000000000000, 4000000000000000, 400000000000000, 40000000000000,
    4000000000000, 400000000000, 40000000000, 4000000000, 400000000, 40000000,
    4000000, 400000, 40000, 4000, 400, 40);
  PowersTimes8_64: array[0..17] of Int64 = (8000000000000000000, 800000000000000000,
    80000000000000000, 8000000000000000, 800000000000000, 80000000000000,
    8000000000000, 800000000000, 80000000000, 8000000000, 800000000, 80000000,
    8000000, 800000, 80000, 8000, 800, 80);
var
  CharIdx, DigitIdx, ResLen: Integer;
  Res: PChar;
  Sign: Boolean;
  UValue: Int64;
begin
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
    if UValue >= PowersTimes8_64[DigitIdx] then begin Inc(CharIdx, 8); Dec(UValue, PowersTimes8_64[DigitIdx]); end;
    if UValue >= PowersTimes4_64[DigitIdx] then begin Inc(CharIdx, 4); Dec(UValue, PowersTimes4_64[DigitIdx]); end;
    if UValue >= PowersTimes2_64[DigitIdx] then begin Inc(CharIdx, 2); Dec(UValue, PowersTimes2_64[DigitIdx]); end;
    if UValue >= PowersTimes1_64[DigitIdx] then begin Inc(CharIdx, 1); Dec(UValue, PowersTimes1_64[DigitIdx]); end;
    (Res + DigitIdx)^ := Char(CharIdx + Ord('0'));
    Inc(DigitIdx);
  end;

  PChar(Res + DigitIdx)^ := Char(UValue + Ord('0'));
end;

function IntToStr64_AZ_Pas_2_c(Value: Int64): string;
const
  PowersTimes1_64: array[0..17] of Int64 = (1000000000000000000, 100000000000000000,
    10000000000000000, 1000000000000000, 100000000000000, 10000000000000,
    1000000000000, 100000000000, 10000000000, 1000000000, 100000000, 10000000,
    1000000, 100000, 10000, 1000, 100, 10);
  PowersTimes2_64: array[0..17] of Int64 = (2000000000000000000, 200000000000000000,
    20000000000000000, 2000000000000000, 200000000000000, 20000000000000,
    2000000000000, 200000000000, 20000000000, 2000000000, 200000000, 20000000,
    2000000, 200000, 20000, 2000, 200, 20);
  PowersTimes4_64: array[0..17] of Int64 = (4000000000000000000, 400000000000000000,
    40000000000000000, 4000000000000000, 400000000000000, 40000000000000,
    4000000000000, 400000000000, 40000000000, 4000000000, 400000000, 40000000,
    4000000, 400000, 40000, 4000, 400, 40);
  PowersTimes8_64: array[0..17] of Int64 = (8000000000000000000, 800000000000000000,
    80000000000000000, 8000000000000000, 800000000000000, 80000000000000,
    8000000000000, 800000000000, 80000000000, 8000000000, 800000000, 80000000,
    8000000, 800000, 80000, 8000, 800, 80);
var
  CharIdx, DigitIdx, ResLen: Integer;
  Res: PChar;
  Sign: Boolean;
  UValue: Int64;
begin
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
    if UValue >= PowersTimes8_64[DigitIdx] then begin Inc(CharIdx, 8); Dec(UValue, PowersTimes8_64[DigitIdx]); end;
    if UValue >= PowersTimes4_64[DigitIdx] then begin Inc(CharIdx, 4); Dec(UValue, PowersTimes4_64[DigitIdx]); end;
    if UValue >= PowersTimes2_64[DigitIdx] then begin Inc(CharIdx, 2); Dec(UValue, PowersTimes2_64[DigitIdx]); end;
    if UValue >= PowersTimes1_64[DigitIdx] then begin Inc(CharIdx, 1); Dec(UValue, PowersTimes1_64[DigitIdx]); end;
    (Res + DigitIdx)^ := Char(CharIdx + Ord('0'));
    Inc(DigitIdx);
  end;

  PChar(Res + DigitIdx)^ := Char(UValue + Ord('0'));
end;

function IntToStr64_AZ_Pas_2_d(Value: Int64): string;
const
  PowersTimes1_64: array[0..17] of Int64 = (1000000000000000000, 100000000000000000,
    10000000000000000, 1000000000000000, 100000000000000, 10000000000000,
    1000000000000, 100000000000, 10000000000, 1000000000, 100000000, 10000000,
    1000000, 100000, 10000, 1000, 100, 10);
  PowersTimes2_64: array[0..17] of Int64 = (2000000000000000000, 200000000000000000,
    20000000000000000, 2000000000000000, 200000000000000, 20000000000000,
    2000000000000, 200000000000, 20000000000, 2000000000, 200000000, 20000000,
    2000000, 200000, 20000, 2000, 200, 20);
  PowersTimes4_64: array[0..17] of Int64 = (4000000000000000000, 400000000000000000,
    40000000000000000, 4000000000000000, 400000000000000, 40000000000000,
    4000000000000, 400000000000, 40000000000, 4000000000, 400000000, 40000000,
    4000000, 400000, 40000, 4000, 400, 40);
  PowersTimes8_64: array[0..17] of Int64 = (8000000000000000000, 800000000000000000,
    80000000000000000, 8000000000000000, 800000000000000, 80000000000000,
    8000000000000, 800000000000, 80000000000, 8000000000, 800000000, 80000000,
    8000000, 800000, 80000, 8000, 800, 80);
var
  CharIdx, DigitIdx, ResLen: Integer;
  Res: PChar;
  Sign: Boolean;
  UValue: Int64;
begin
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
    if UValue >= PowersTimes8_64[DigitIdx] then begin Inc(CharIdx, 8); Dec(UValue, PowersTimes8_64[DigitIdx]); end;
    if UValue >= PowersTimes4_64[DigitIdx] then begin Inc(CharIdx, 4); Dec(UValue, PowersTimes4_64[DigitIdx]); end;
    if UValue >= PowersTimes2_64[DigitIdx] then begin Inc(CharIdx, 2); Dec(UValue, PowersTimes2_64[DigitIdx]); end;
    if UValue >= PowersTimes1_64[DigitIdx] then begin Inc(CharIdx, 1); Dec(UValue, PowersTimes1_64[DigitIdx]); end;
    (Res + DigitIdx)^ := Char(CharIdx + Ord('0'));
    Inc(DigitIdx);
  end;

  PChar(Res + DigitIdx)^ := Char(UValue + Ord('0'));
end;

initialization
begin
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_AZ_Pas_1_a', 'Subtraction, powers of 2 and 10, unrolled', @IntToStr_AZ_Pas_1_a, fccPas, fcaAZ));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_AZ_Pas_1_b', 'Subtraction, powers of 2 and 10, unrolled', @IntToStr_AZ_Pas_1_b, fccPas, fcaAZ));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_AZ_Pas_1_c', 'Subtraction, powers of 2 and 10, unrolled', @IntToStr_AZ_Pas_1_c, fccPas, fcaAZ));
  ChallengeIntToStr32.RegisterFunction(FunctionData('IntToStr_AZ_Pas_1_d', 'Subtraction, powers of 2 and 10, unrolled', @IntToStr_AZ_Pas_1_d, fccPas, fcaAZ));
  ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_AZ_Pas_2_a', 'Subtraction, powers of 2 and 10', @IntToStr64_AZ_Pas_2_a, fccPas, fcaAZ));
  ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_AZ_Pas_2_b', 'Subtraction, powers of 2 and 10', @IntToStr64_AZ_Pas_2_b, fccPas, fcaAZ));
  ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_AZ_Pas_2_c', 'Subtraction, powers of 2 and 10', @IntToStr64_AZ_Pas_2_c, fccPas, fcaAZ));
  ChallengeIntToStr64.RegisterFunction(FunctionData('IntToStr64_AZ_Pas_2_d', 'Subtraction, powers of 2 and 10', @IntToStr64_AZ_Pas_2_d, fccPas, fcaAZ));
end;

end.
