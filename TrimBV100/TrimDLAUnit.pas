unit TrimDLAUnit;

interface

implementation
{$IFOPT B+}
  {$define SaveB}
{$endif}

{$IFOPT Q+}
  {$define SaveQ}
{$endif}


{$B-} // disable full boolean evaluation
{$Q-} // disable overflow checking

uses
  Windows, MainUnit, TrimRTLUnit, Sysutils;
type
  TByteArray = array[0..$7FFFFFFE] of Byte;
  PByteArray = ^TByteArray;
  TLongWordArray = array[0..($7FFFFFFF div SizeOf(LongWord)) - 1] of LongWord;
  PLongWordArray = ^TLongWordArray;

// Pascal v1
// Normal pchar loop, copy at end
function Trim_DLA_PAS_1_a(const AString: string): string;
var
  iFront, iBack, sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  if sLen = 0 then
  begin
    Result := '';
    Exit;
  end;
  p := Pointer(AString);
  iFront := 0;
  while (iFront < sLen) and (p[iFront] <= ' ') do
    inc(iFront);
  if iFront = sLen then
  begin
    Result := '';
    Exit;
  end;
  iBack := sLen - 1;
  while p[iBack] <= ' ' do
    dec(iBack);
  Result := Copy(AString, iFront + 1, iBack - iFront + 1);
end;

function Trim_DLA_PAS_1_b(const AString: string): string;
var
  iFront, iBack, sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  if sLen = 0 then
  begin
    Result := '';
    Exit;
  end;
  p := Pointer(AString);
  iFront := 0;
  while (iFront < sLen) and (p[iFront] <= ' ') do
    inc(iFront);
  if iFront = sLen then
  begin
    Result := '';
    Exit;
  end;
  iBack := sLen - 1;
  while p[iBack] <= ' ' do
    dec(iBack);
  Result := Copy(AString, iFront + 1, iBack - iFront + 1);
end;

procedure Filler1;
asm
  nop;
end;

function Trim_DLA_PAS_1_c(const AString: string): string;
var
  iFront, iBack, sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  if sLen = 0 then
  begin
    Result := '';
    Exit;
  end;
  p := Pointer(AString);
  iFront := 0;
  while (iFront < sLen) and (p[iFront] <= ' ') do
    inc(iFront);
  if iFront = sLen then
  begin
    Result := '';
    Exit;
  end;
  iBack := sLen - 1;
  while p[iBack] <= ' ' do
    dec(iBack);
  Result := Copy(AString, iFront + 1, iBack - iFront + 1);
end;

function Trim_DLA_PAS_1_d(const AString: string): string;
var
  iFront, iBack, sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  if sLen = 0 then
  begin
    Result := '';
    Exit;
  end;
  p := Pointer(AString);
  iFront := 0;
  while (iFront < sLen) and (p[iFront] <= ' ') do
    inc(iFront);
  if iFront = sLen then
  begin
    Result := '';
    Exit;
  end;
  iBack := sLen - 1;
  while p[iBack] <= ' ' do
    dec(iBack);
  Result := Copy(AString, iFront + 1, iBack - iFront + 1);
end;

// Pascal v2
// same loop as v1 but use SetLength and Move or an assign
function Trim_DLA_PAS_2_a(const AString: string): string;
var
  iFront, iBack, sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  if sLen = 0 then
  begin
    Result := '';
    Exit;
  end;
  p := Pointer(AString);
  iFront := 0;
  while (iFront < sLen) and (p[iFront] <= ' ') do
    inc(iFront);
  if iFront = sLen then
  begin
    Result := '';
    Exit;
  end;
  iBack := sLen - 1;
  while p[iBack] <= ' ' do
    dec(iBack);
  Inc(iBack);
  if (iFront <> 0) or (iBack <> sLen) then
  begin
    SetLength(Result, iBack - iFront);
    Move(p[iFront], PByteArray(Pointer(Result))^[0], PCardinal(Cardinal(Pointer(Result)) - 4)^);
  end
  else
    Result := AString;
end;

function Trim_DLA_PAS_2_b(const AString: string): string;
var
  iFront, iBack, sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  if sLen = 0 then
  begin
    Result := '';
    Exit;
  end;
  p := Pointer(AString);
  iFront := 0;
  while (iFront < sLen) and (p[iFront] <= ' ') do
    inc(iFront);
  if iFront = sLen then
  begin
    Result := '';
    Exit;
  end;
  iBack := sLen - 1;
  while p[iBack] <= ' ' do
    dec(iBack);
  Inc(iBack);
  if (iFront <> 0) or (iBack <> sLen) then
  begin
    SetLength(Result, iBack - iFront);
    Move(p[iFront], PByteArray(Pointer(Result))^[0], PCardinal(Cardinal(Pointer(Result)) - 4)^);
  end
  else
    Result := AString;
end;

function Trim_DLA_PAS_2_c(const AString: string): string;
var
  iFront, iBack, sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  if sLen = 0 then
  begin
    Result := '';
    Exit;
  end;
  p := Pointer(AString);
  iFront := 0;
  while (iFront < sLen) and (p[iFront] <= ' ') do
    inc(iFront);
  if iFront = sLen then
  begin
    Result := '';
    Exit;
  end;
  iBack := sLen - 1;
  while p[iBack] <= ' ' do
    dec(iBack);
  Inc(iBack);
  if (iFront <> 0) or (iBack <> sLen) then
  begin
    SetLength(Result, iBack - iFront);
    Move(p[iFront], PByteArray(Pointer(Result))^[0], PCardinal(Cardinal(Pointer(Result)) - 4)^);
  end
  else
    Result := AString;
end;

function Trim_DLA_PAS_2_d(const AString: string): string;
var
  iFront, iBack, sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  if sLen = 0 then
  begin
    Result := '';
    Exit;
  end;
  p := Pointer(AString);
  iFront := 0;
  while (iFront < sLen) and (p[iFront] <= ' ') do
    inc(iFront);
  if iFront = sLen then
  begin
    Result := '';
    Exit;
  end;
  iBack := sLen - 1;
  while p[iBack] <= ' ' do
    dec(iBack);
  Inc(iBack);
  if (iFront <> 0) or (iBack <> sLen) then
  begin
    SetLength(Result, iBack - iFront);
    Move(p[iFront], PByteArray(Pointer(Result))^[0], PCardinal(Cardinal(Pointer(Result)) - 4)^);
  end
  else
    Result := AString;
end;

// Pascal v3.
// Loop in loop, probably slower
function Trim_DLA_PAS_3_a(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
begin
  for iFront := 1 to Length(AString) do
    if AString[iFront] > ' ' then
    begin
      for iBack := Length(AString) downto 0 do // actually down to i, but this is faster
      begin
        if AString[iBack] > ' ' then
        begin
          Result := Copy(AString, iFront, iBack - iFront + 1);
          Exit;
        end;
      end;
    end;
  Result := '';
end;

function Trim_DLA_PAS_3_b(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
begin
  for iFront := 1 to Length(AString) do
    if AString[iFront] > ' ' then
    begin
      for iBack := Length(AString) downto 0 do // actually down to i, but this is faster
      begin
        if AString[iBack] > ' ' then
        begin
          Result := Copy(AString, iFront, iBack - iFront + 1);
          Exit;
        end;
      end;
    end;
  Result := '';
end;
function Trim_DLA_PAS_3_c(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
begin
  for iFront := 1 to Length(AString) do
    if AString[iFront] > ' ' then
    begin
      for iBack := Length(AString) downto 0 do // actually down to i, but this is faster
      begin
        if AString[iBack] > ' ' then
        begin
          Result := Copy(AString, iFront, iBack - iFront + 1);
          Exit;
        end;
      end;
    end;
  Result := '';
end;
function Trim_DLA_PAS_3_d(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
begin
  for iFront := 1 to Length(AString) do
    if AString[iFront] > ' ' then
    begin
      for iBack := Length(AString) downto 0 do // actually down to i, but this is faster
      begin
        if AString[iBack] > ' ' then
        begin
          Result := Copy(AString, iFront, iBack - iFront + 1);
          Exit;
        end;
      end;
    end;
  Result := '';
end;

//Pascal v4.
//Rewriting the v3 loop to while's, and no need to check for the backside loop because we know it will never be below 0
//Choose between assign and move
function Trim_DLA_PAS_4_a(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := Pointer(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if p[iFront] > ' ' then
    begin
      iBack := sLen - 1;
      while p[iBack] <= ' ' do
        dec(iBack);
      Inc(iBack);
      if (iFront = 0) and (iBack = sLen) then
        Result := AString
      else
      begin
        sLen := iBack - iFront;
        SetLength(Result, sLen);
        Move(p[iFront], PByteArray(Pointer(Result))^[0], sLen);
      end;
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;
function Trim_DLA_PAS_4_b(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := Pointer(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if p[iFront] > ' ' then
    begin
      iBack := sLen - 1;
      while p[iBack] <= ' ' do
        dec(iBack);
      Inc(iBack);
      if (iFront = 0) and (iBack = sLen) then
        Result := AString
      else
      begin
        sLen := iBack - iFront;
        SetLength(Result, sLen);
        Move(p[iFront], PByteArray(Pointer(Result))^[0], sLen);
      end;
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;
function Trim_DLA_PAS_4_c(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := Pointer(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if p[iFront] > ' ' then
    begin
      iBack := sLen - 1;
      while p[iBack] <= ' ' do
        dec(iBack);
      Inc(iBack);
      if (iFront = 0) and (iBack = sLen) then
        Result := AString
      else
      begin
        sLen := iBack - iFront;
        SetLength(Result, sLen);
        Move(p[iFront], PByteArray(Pointer(Result))^[0], sLen);
      end;
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;
function Trim_DLA_PAS_4_d(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := Pointer(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if p[iFront] > ' ' then
    begin
      iBack := sLen - 1;
      while p[iBack] <= ' ' do
        dec(iBack);
      Inc(iBack);
      if (iFront = 0) and (iBack = sLen) then
        Result := AString
      else
      begin
        sLen := iBack - iFront;
        SetLength(Result, sLen);
        Move(p[iFront], PByteArray(Pointer(Result))^[0], sLen);
      end;
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;
// Pascal v5
// Same as v4 but using copy instead of SetLength and Move
function Trim_DLA_PAS_5_a(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := Pointer(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if p[iFront] > ' ' then
    begin
      iBack := sLen - 1;
      while p[iBack] <= ' ' do
        dec(iBack);
      Inc(iBack);
      if (iFront = 0) and (iBack = sLen) then
        Result := AString
      else
        Result := Copy(AString, iFront + 1, iBack - iFront);
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;
function Trim_DLA_PAS_5_b(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := Pointer(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if p[iFront] > ' ' then
    begin
      iBack := sLen - 1;
      while p[iBack] <= ' ' do
        dec(iBack);
      Inc(iBack);
      if (iFront = 0) and (iBack = sLen) then
        Result := AString
      else
        Result := Copy(AString, iFront + 1, iBack - iFront);
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;
function Trim_DLA_PAS_5_c(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := Pointer(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if p[iFront] > ' ' then
    begin
      iBack := sLen - 1;
      while p[iBack] <= ' ' do
        dec(iBack);
      Inc(iBack);
      if (iFront = 0) and (iBack = sLen) then
        Result := AString
      else
        Result := Copy(AString, iFront + 1, iBack - iFront);
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;
function Trim_DLA_PAS_5_d(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := Pointer(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if p[iFront] > ' ' then
    begin
      iBack := sLen - 1;
      while p[iBack] <= ' ' do
        dec(iBack);
      Inc(iBack);
      if (iFront = 0) and (iBack = sLen) then
        Result := AString
      else
        Result := Copy(AString, iFront + 1, iBack - iFront);
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;
// Pascal v6
// Don't do the check between assign and copy, just do the copy
function Trim_DLA_PAS_6_a(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := PChar(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if p[iFront] > ' ' then
    begin
      iBack := sLen - 1;
      while p[iBack] <= ' ' do
        dec(iBack);
      Result := Copy(AString, iFront + 1, iBack - iFront + 1);
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;
function Trim_DLA_PAS_6_b(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := PChar(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if p[iFront] > ' ' then
    begin
      iBack := sLen - 1;
      while p[iBack] <= ' ' do
        dec(iBack);
      Result := Copy(AString, iFront + 1, iBack - iFront + 1);
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;
function Trim_DLA_PAS_6_c(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := PChar(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if p[iFront] > ' ' then
    begin
      iBack := sLen - 1;
      while p[iBack] <= ' ' do
        dec(iBack);
      Result := Copy(AString, iFront + 1, iBack - iFront + 1);
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;
function Trim_DLA_PAS_6_d(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := PChar(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if p[iFront] > ' ' then
    begin
      iBack := sLen - 1;
      while p[iBack] <= ' ' do
        dec(iBack);
      Result := Copy(AString, iFront + 1, iBack - iFront + 1);
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;

(*
function LongWordContainsNonSpaces(const ALongWord: LongWord): Boolean; inline;
begin
  Result := (((ALongWord + $5F5F5F5F) or ALongWord) and $80808080) <> 0;
end;        *)





function Trim_DLA_PAS_7_a(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  pBigStep: PLongWord;
  pSmallStep: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pBigStep := Pointer(AString);
  pSmallStep := Pointer(AString);
  iFront := 0;
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(iFront, 4);
    if iFront >= sLen then
      goto NoResult;
    Inc(pBigStep);
  until False;
ForwardFound:
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  goto NoResult;
ForwardDone:
  if iFront >= sLen then
    goto NoResult;
  if sLen < 4 then
  begin
    iBack := 0;
    goto BackwardFound;
  end;
  pBigStep := Pointer(Cardinal(pSmallStep) + Cardinal(sLen) - 4);
  pSmallStep := Pointer(AString);
  iBack := sLen - 1 - 4;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(iBack, 4);
    Dec(pBigStep);
  until False;
BackwardFound:
  iBack := iBack + 4;
  if iBack >= sLen then
    iBack := sLen - 1;
  if (pSmallStep[iBack] > ' ') then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  goto NoResult;
BackwardDone:
  // just need to copy the result
  Result := Copy(AString, iFront + 1, iBack - iFront + 1);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_7_b(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  pBigStep: PLongWord;
  pSmallStep: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pBigStep := Pointer(AString);
  pSmallStep := Pointer(AString);
  iFront := 0;
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(iFront, 4);
    if iFront >= sLen then
      goto NoResult;
    Inc(pBigStep);
  until False;
ForwardFound:
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  goto NoResult;
ForwardDone:
  if iFront >= sLen then
    goto NoResult;
  if sLen < 4 then
  begin
    iBack := 0;
    goto BackwardFound;
  end;
  pBigStep := Pointer(Cardinal(pSmallStep) + Cardinal(sLen) - 4);
  pSmallStep := Pointer(AString);
  iBack := sLen - 1 - 4;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(iBack, 4);
    Dec(pBigStep);
  until False;
BackwardFound:
  iBack := iBack + 4;
  if iBack >= sLen then
    iBack := sLen - 1;
  if (pSmallStep[iBack] > ' ') then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  goto NoResult;
BackwardDone:
  // just need to copy the result
  Result := Copy(AString, iFront + 1, iBack - iFront + 1);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler2;
asm
  nop;
end;
function Trim_DLA_PAS_7_c(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  pBigStep: PLongWord;
  pSmallStep: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pBigStep := Pointer(AString);
  pSmallStep := Pointer(AString);
  iFront := 0;
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(iFront, 4);
    if iFront >= sLen then
      goto NoResult;
    Inc(pBigStep);
  until False;
ForwardFound:
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  goto NoResult;
ForwardDone:
  if iFront >= sLen then
    goto NoResult;
  if sLen < 4 then
  begin
    iBack := 0;
    goto BackwardFound;
  end;
  pBigStep := Pointer(Cardinal(pSmallStep) + Cardinal(sLen) - 4);
  pSmallStep := Pointer(AString);
  iBack := sLen - 1 - 4;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(iBack, 4);
    Dec(pBigStep);
  until False;
BackwardFound:
  iBack := iBack + 4;
  if iBack >= sLen then
    iBack := sLen - 1;
  if (pSmallStep[iBack] > ' ') then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  goto NoResult;
BackwardDone:
  // just need to copy the result
  Result := Copy(AString, iFront + 1, iBack - iFront + 1);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_7_d(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  pBigStep: PLongWord;
  pSmallStep: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pBigStep := Pointer(AString);
  pSmallStep := Pointer(AString);
  iFront := 0;
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(iFront, 4);
    if iFront >= sLen then
      goto NoResult;
    Inc(pBigStep);
  until False;
ForwardFound:
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  goto NoResult;
ForwardDone:
  if iFront >= sLen then
    goto NoResult;
  if sLen < 4 then
  begin
    iBack := 0;
    goto BackwardFound;
  end;
  pBigStep := Pointer(Cardinal(pSmallStep) + Cardinal(sLen) - 4);
  pSmallStep := Pointer(AString);
  iBack := sLen - 1 - 4;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(iBack, 4);
    Dec(pBigStep);
  until False;
BackwardFound:
  iBack := iBack + 4;
  if iBack >= sLen then
    iBack := sLen - 1;
  if (pSmallStep[iBack] > ' ') then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  goto NoResult;
BackwardDone:
  // just need to copy the result
  Result := Copy(AString, iFront + 1, iBack - iFront + 1);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_8_a(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  pBigStep: PLongWord;
  pSmallStep: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pBigStep := Pointer(AString);
  pSmallStep := Pointer(AString);
  iFront := 0;
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(iFront, 4);
    if iFront >= sLen then
      goto NoResult;
    Inc(pBigStep);
  until False;
ForwardFound:
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  goto NoResult;
ForwardDone:
  if iFront >= sLen then
    goto NoResult;
  if sLen < 4 then
  begin
    iBack := 0;
    goto BackwardFound;
  end;
  pBigStep := Pointer(Cardinal(pSmallStep) + Cardinal(sLen) - 4);
  pSmallStep := Pointer(AString);
  iBack := sLen - 1 - 4;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(iBack, 4);
    Dec(pBigStep);
  until False;
BackwardFound:
  iBack := iBack + 4;
  if iBack >= sLen then
    iBack := sLen - 1;
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  goto NoResult;
BackwardDone:
  // just need to copy the result
  sLen := iBack - iFront + 1;
  SetLength(Result, sLen);
  Move(pSmallStep[iFront], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_8_b(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  pBigStep: PLongWord;
  pSmallStep: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pBigStep := Pointer(AString);
  pSmallStep := Pointer(AString);
  iFront := 0;
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(iFront, 4);
    if iFront >= sLen then
      goto NoResult;
    Inc(pBigStep);
  until False;
ForwardFound:
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  goto NoResult;
ForwardDone:
  if iFront >= sLen then
    goto NoResult;
  if sLen < 4 then
  begin
    iBack := 0;
    goto BackwardFound;
  end;
  pBigStep := Pointer(Cardinal(pSmallStep) + Cardinal(sLen) - 4);
  pSmallStep := Pointer(AString);
  iBack := sLen - 1 - 4;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(iBack, 4);
    Dec(pBigStep);
  until False;
BackwardFound:
  iBack := iBack + 4;
  if iBack >= sLen then
    iBack := sLen - 1;
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  goto NoResult;
BackwardDone:
  // just need to copy the result
  sLen := iBack - iFront + 1;
  SetLength(Result, sLen);
  Move(pSmallStep[iFront], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_8_c(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  pBigStep: PLongWord;
  pSmallStep: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pBigStep := Pointer(AString);
  pSmallStep := Pointer(AString);
  iFront := 0;
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(iFront, 4);
    if iFront >= sLen then
      goto NoResult;
    Inc(pBigStep);
  until False;
ForwardFound:
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  goto NoResult;
ForwardDone:
  if iFront >= sLen then
    goto NoResult;
  if sLen < 4 then
  begin
    iBack := 0;
    goto BackwardFound;
  end;
  pBigStep := Pointer(Cardinal(pSmallStep) + Cardinal(sLen) - 4);
  pSmallStep := Pointer(AString);
  iBack := sLen - 1 - 4;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(iBack, 4);
    Dec(pBigStep);
  until False;
BackwardFound:
  iBack := iBack + 4;
  if iBack >= sLen then
    iBack := sLen - 1;
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  goto NoResult;
BackwardDone:
  // just need to copy the result
  sLen := iBack - iFront + 1;
  SetLength(Result, sLen);
  Move(pSmallStep[iFront], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_8_d(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  pBigStep: PLongWord;
  pSmallStep: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pBigStep := Pointer(AString);
  pSmallStep := Pointer(AString);
  iFront := 0;
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(iFront, 4);
    if iFront >= sLen then
      goto NoResult;
    Inc(pBigStep);
  until False;
ForwardFound:
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  inc(iFront);
  if pSmallStep[iFront] > ' ' then
    goto ForwardDone;
  goto NoResult;
ForwardDone:
  if iFront >= sLen then
    goto NoResult;
  if sLen < 4 then
  begin
    iBack := 0;
    goto BackwardFound;
  end;
  pBigStep := Pointer(Cardinal(pSmallStep) + Cardinal(sLen) - 4);
  pSmallStep := Pointer(AString);
  iBack := sLen - 1 - 4;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(iBack, 4);
    Dec(pBigStep);
  until False;
BackwardFound:
  iBack := iBack + 4;
  if iBack >= sLen then
    iBack := sLen - 1;
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  dec(iBack);
  if pSmallStep[iBack] > ' ' then
    goto BackwardDone;
  goto NoResult;
BackwardDone:
  // just need to copy the result
  sLen := iBack - iFront + 1;
  SetLength(Result, sLen);
  Move(pSmallStep[iFront], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_9_a(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  pBigStep: PLongWord;
  pSmallStep: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pBigStep := Pointer(AString);
  pSmallStep := Pointer(AString);
  iFront := 0;
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(iFront, 4);
    if iFront >= sLen then
      goto NoResult;
    Inc(pBigStep);
  until False;
ForwardFound:
  while iFront < sLen do
  begin
    if pSmallStep[iFront] > ' ' then
      goto ForwardDone;
    inc(iFront);
  end;
  goto NoResult;
ForwardDone:
  if iFront >= sLen then
    goto NoResult;
  if sLen < 4 then
  begin
    iBack := 0;
    goto BackwardFound;
  end;
  pBigStep := Pointer(Cardinal(pSmallStep) + Cardinal(sLen) - 4);
  pSmallStep := Pointer(AString);
  iBack := sLen - 1 - 4;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(iBack, 4);
    Dec(pBigStep);
  until False;
BackwardFound:
  iBack := iBack + 4;
  if iBack >= sLen then
    iBack := sLen - 1;
  while pSmallStep[iBack] <= ' ' do
    dec(iBack);
BackwardDone:
  // just need to copy the result
  Result := Copy(AString, iFront + 1, iBack - iFront + 1);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler3;
asm
  nop;
end;
function Trim_DLA_PAS_9_b(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  pBigStep: PLongWord;
  pSmallStep: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pBigStep := Pointer(AString);
  pSmallStep := Pointer(AString);
  iFront := 0;
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(iFront, 4);
    if iFront >= sLen then
      goto NoResult;
    Inc(pBigStep);
  until False;
ForwardFound:
  while iFront < sLen do
  begin
    if pSmallStep[iFront] > ' ' then
      goto ForwardDone;
    inc(iFront);
  end;
  goto NoResult;
ForwardDone:
  if iFront >= sLen then
    goto NoResult;
  if sLen < 4 then
  begin
    iBack := 0;
    goto BackwardFound;
  end;
  pBigStep := Pointer(Cardinal(pSmallStep) + Cardinal(sLen) - 4);
  pSmallStep := Pointer(AString);
  iBack := sLen - 1 - 4;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(iBack, 4);
    Dec(pBigStep);
  until False;
BackwardFound:
  iBack := iBack + 4;
  if iBack >= sLen then
    iBack := sLen - 1;
  while pSmallStep[iBack] <= ' ' do
    dec(iBack);
BackwardDone:
  // just need to copy the result
  Result := Copy(AString, iFront + 1, iBack - iFront + 1);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler24;
asm
  nop;
end;
function Trim_DLA_PAS_9_c(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  pBigStep: PLongWord;
  pSmallStep: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pBigStep := Pointer(AString);
  pSmallStep := Pointer(AString);
  iFront := 0;
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(iFront, 4);
    if iFront >= sLen then
      goto NoResult;
    Inc(pBigStep);
  until False;
ForwardFound:
  while iFront < sLen do
  begin
    if pSmallStep[iFront] > ' ' then
      goto ForwardDone;
    inc(iFront);
  end;
  goto NoResult;
ForwardDone:
  if iFront >= sLen then
    goto NoResult;
  if sLen < 4 then
  begin
    iBack := 0;
    goto BackwardFound;
  end;
  pBigStep := Pointer(Cardinal(pSmallStep) + Cardinal(sLen) - 4);
  pSmallStep := Pointer(AString);
  iBack := sLen - 1 - 4;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(iBack, 4);
    Dec(pBigStep);
  until False;
BackwardFound:
  iBack := iBack + 4;
  if iBack >= sLen then
    iBack := sLen - 1;
  while pSmallStep[iBack] <= ' ' do
    dec(iBack);
BackwardDone:
  // just need to copy the result
  Result := Copy(AString, iFront + 1, iBack - iFront + 1);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler23;
asm
  nop;
end;
function Trim_DLA_PAS_9_d(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  pBigStep: PLongWord;
  pSmallStep: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pBigStep := Pointer(AString);
  pSmallStep := Pointer(AString);
  iFront := 0;
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(iFront, 4);
    if iFront >= sLen then
      goto NoResult;
    Inc(pBigStep);
  until False;
ForwardFound:
  while iFront < sLen do
  begin
    if pSmallStep[iFront] > ' ' then
      goto ForwardDone;
    inc(iFront);
  end;
  goto NoResult;
ForwardDone:
  if iFront >= sLen then
    goto NoResult;
  if sLen < 4 then
  begin
    iBack := 0;
    goto BackwardFound;
  end;
  pBigStep := Pointer(Cardinal(pSmallStep) + Cardinal(sLen) - 4);
  pSmallStep := Pointer(AString);
  iBack := sLen - 1 - 4;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(iBack, 4);
    Dec(pBigStep);
  until False;
BackwardFound:
  iBack := iBack + 4;
  if iBack >= sLen then
    iBack := sLen - 1;
  while pSmallStep[iBack] <= ' ' do
    dec(iBack);
BackwardDone:
  // just need to copy the result
  Result := Copy(AString, iFront + 1, iBack - iFront + 1);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_10_a(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  pBigStep: PLongWord;
  pSmallStep: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pBigStep := Pointer(AString);
  pSmallStep := Pointer(AString);
  iFront := 0;
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(iFront, 4);
    if iFront >= sLen then
      goto NoResult;
    Inc(pBigStep);
  until False;
ForwardFound:
  while iFront < sLen do
  begin
    if pSmallStep[iFront] > ' ' then
      goto ForwardDone;
    inc(iFront);
  end;
  goto NoResult;
ForwardDone:
  if iFront >= sLen then
    goto NoResult;
  if sLen < 4 then
  begin
    iBack := 0;
    goto BackwardFound;
  end;
  pBigStep := Pointer(Cardinal(pSmallStep) + Cardinal(sLen) - 4);
  pSmallStep := Pointer(AString);
  iBack := sLen - 1 - 4;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(iBack, 4);
    Dec(pBigStep);
  until False;
BackwardFound:
  iBack := iBack + 4;
  if iBack >= sLen then
    iBack := sLen - 1;
  while pSmallStep[iBack] <= ' ' do
    dec(iBack);
BackwardDone:
  // just need to copy the result
  sLen := iBack - iFront + 1;
  SetLength(Result, sLen);
  Move(pSmallStep[iFront], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_10_b(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  pBigStep: PLongWord;
  pSmallStep: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pBigStep := Pointer(AString);
  pSmallStep := Pointer(AString);
  iFront := 0;
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(iFront, 4);
    if iFront >= sLen then
      goto NoResult;
    Inc(pBigStep);
  until False;
ForwardFound:
  while iFront < sLen do
  begin
    if pSmallStep[iFront] > ' ' then
      goto ForwardDone;
    inc(iFront);
  end;
  goto NoResult;
ForwardDone:
  if iFront >= sLen then
    goto NoResult;
  if sLen < 4 then
  begin
    iBack := 0;
    goto BackwardFound;
  end;
  pBigStep := Pointer(Cardinal(pSmallStep) + Cardinal(sLen) - 4);
  pSmallStep := Pointer(AString);
  iBack := sLen - 1 - 4;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(iBack, 4);
    Dec(pBigStep);
  until False;
BackwardFound:
  iBack := iBack + 4;
  if iBack >= sLen then
    iBack := sLen - 1;
  while pSmallStep[iBack] <= ' ' do
    dec(iBack);
BackwardDone:
  // just need to copy the result
  sLen := iBack - iFront + 1;
  SetLength(Result, sLen);
  Move(pSmallStep[iFront], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler4;
asm
  nop;
end;
function Trim_DLA_PAS_10_c(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  pBigStep: PLongWord;
  pSmallStep: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pBigStep := Pointer(AString);
  pSmallStep := Pointer(AString);
  iFront := 0;
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(iFront, 4);
    if iFront >= sLen then
      goto NoResult;
    Inc(pBigStep);
  until False;
ForwardFound:
  while iFront < sLen do
  begin
    if pSmallStep[iFront] > ' ' then
      goto ForwardDone;
    inc(iFront);
  end;
  goto NoResult;
ForwardDone:
  if iFront >= sLen then
    goto NoResult;
  if sLen < 4 then
  begin
    iBack := 0;
    goto BackwardFound;
  end;
  pBigStep := Pointer(Cardinal(pSmallStep) + Cardinal(sLen) - 4);
  pSmallStep := Pointer(AString);
  iBack := sLen - 1 - 4;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(iBack, 4);
    Dec(pBigStep);
  until False;
BackwardFound:
  iBack := iBack + 4;
  if iBack >= sLen then
    iBack := sLen - 1;
  while pSmallStep[iBack] <= ' ' do
    dec(iBack);
BackwardDone:
  // just need to copy the result
  sLen := iBack - iFront + 1;
  SetLength(Result, sLen);
  Move(pSmallStep[iFront], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_10_d(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  pBigStep: PLongWord;
  pSmallStep: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pBigStep := Pointer(AString);
  pSmallStep := Pointer(AString);
  iFront := 0;
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(iFront, 4);
    if iFront >= sLen then
      goto NoResult;
    Inc(pBigStep);
  until False;
ForwardFound:
  while iFront < sLen do
  begin
    if pSmallStep[iFront] > ' ' then
      goto ForwardDone;
    inc(iFront);
  end;
  goto NoResult;
ForwardDone:
  if iFront >= sLen then
    goto NoResult;
  if sLen < 4 then
  begin
    iBack := 0;
    goto BackwardFound;
  end;
  pBigStep := Pointer(Cardinal(pSmallStep) + Cardinal(sLen) - 4);
  pSmallStep := Pointer(AString);
  iBack := sLen - 1 - 4;
  repeat
    if (((pBigStep^ + $5F5F5F5F) or pBigStep^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(iBack, 4);
    Dec(pBigStep);
  until False;
BackwardFound:
  iBack := iBack + 4;
  if iBack >= sLen then
    iBack := sLen - 1;
  while pSmallStep[iBack] <= ' ' do
    dec(iBack);
BackwardDone:
  // just need to copy the result
  sLen := iBack - iFront + 1;
  SetLength(Result, sLen);
  Move(pSmallStep[iFront], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_11_a(const AString: string): string;
var
  sLen: Integer;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  while Cardinal(pFront) < Cardinal(pBack) do
  begin
    if pFront[0] > ' ' then
      goto ForwardDone;
    inc(pFront);
  end;
  goto NoResult;
ForwardDone:
  Dec(pBack, SizeOf(LongWord));
  if sLen < 4 then
    goto BackwardFound;
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(pBack, SizeOf(LongWord));
  until False;
BackwardFound:
  inc(pBack, SizeOf(LongWord) - 1);
  while pBack[0] <= ' ' do
    dec(pBack);
BackwardDone:
  // just need to copy the result
  Result := Copy(AString, Integer(Cardinal(pFront) - Cardinal(AString) + 1), Integer(Cardinal(pBack) - Cardinal(pFront) + 1));
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_11_b(const AString: string): string;
var
  sLen: Integer;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  while Cardinal(pFront) < Cardinal(pBack) do
  begin
    if pFront[0] > ' ' then
      goto ForwardDone;
    inc(pFront);
  end;
  goto NoResult;
ForwardDone:
  Dec(pBack, SizeOf(LongWord));
  if sLen < 4 then
    goto BackwardFound;
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(pBack, SizeOf(LongWord));
  until False;
BackwardFound:
  inc(pBack, SizeOf(LongWord) - 1);
  while pBack[0] <= ' ' do
    dec(pBack);
BackwardDone:
  // just need to copy the result
  Result := Copy(AString, Integer(Cardinal(pFront) - Cardinal(AString) + 1), Integer(Cardinal(pBack) - Cardinal(pFront) + 1));
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_11_c(const AString: string): string;
var
  sLen: Integer;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  while Cardinal(pFront) < Cardinal(pBack) do
  begin
    if pFront[0] > ' ' then
      goto ForwardDone;
    inc(pFront);
  end;
  goto NoResult;
ForwardDone:
  Dec(pBack, SizeOf(LongWord));
  if sLen < 4 then
    goto BackwardFound;
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(pBack, SizeOf(LongWord));
  until False;
BackwardFound:
  inc(pBack, SizeOf(LongWord) - 1);
  while pBack[0] <= ' ' do
    dec(pBack);
BackwardDone:
  // just need to copy the result
  Result := Copy(AString, Integer(Cardinal(pFront) - Cardinal(AString) + 1), Integer(Cardinal(pBack) - Cardinal(pFront) + 1));
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_11_d(const AString: string): string;
var
  sLen: Integer;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  while Cardinal(pFront) < Cardinal(pBack) do
  begin
    if pFront[0] > ' ' then
      goto ForwardDone;
    inc(pFront);
  end;
  goto NoResult;
ForwardDone:
  Dec(pBack, SizeOf(LongWord));
  if sLen < 4 then
    goto BackwardFound;
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(pBack, SizeOf(LongWord));
  until False;
BackwardFound:
  inc(pBack, SizeOf(LongWord) - 1);
  while pBack[0] <= ' ' do
    dec(pBack);
BackwardDone:
  // just need to copy the result
  Result := Copy(AString, Integer(Cardinal(pFront) - Cardinal(AString) + 1), Integer(Cardinal(pBack) - Cardinal(pFront) + 1));
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_12_a(const AString: string): string;
var
  sLen: Integer;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  while Cardinal(pFront) < Cardinal(pBack) do
  begin
    if pFront[0] > ' ' then
      goto ForwardDone;
    inc(pFront);
  end;
  goto NoResult;
ForwardDone:
  Dec(pBack, SizeOf(LongWord));
  if sLen < 4 then
    goto BackwardFound;
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(pBack, SizeOf(LongWord));
  until False;
BackwardFound:
  inc(pBack, SizeOf(LongWord) - 1);
  while pBack[0] <= ' ' do
    dec(pBack);
BackwardDone:
  // just need to copy the result
  sLen := Integer(Cardinal(pBack) - Cardinal(pFront) + 1);
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_12_b(const AString: string): string;
var
  sLen: Integer;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  while Cardinal(pFront) < Cardinal(pBack) do
  begin
    if pFront[0] > ' ' then
      goto ForwardDone;
    inc(pFront);
  end;
  goto NoResult;
ForwardDone:
  Dec(pBack, SizeOf(LongWord));
  if sLen < 4 then
    goto BackwardFound;
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(pBack, SizeOf(LongWord));
  until False;
BackwardFound:
  inc(pBack, SizeOf(LongWord) - 1);
  while pBack[0] <= ' ' do
    dec(pBack);
BackwardDone:
  // just need to copy the result
  sLen := Integer(Cardinal(pBack) - Cardinal(pFront) + 1);
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_12_c(const AString: string): string;
var
  sLen: Integer;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  while Cardinal(pFront) < Cardinal(pBack) do
  begin
    if pFront[0] > ' ' then
      goto ForwardDone;
    inc(pFront);
  end;
  goto NoResult;
ForwardDone:
  Dec(pBack, SizeOf(LongWord));
  if sLen < 4 then
    goto BackwardFound;
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(pBack, SizeOf(LongWord));
  until False;
BackwardFound:
  inc(pBack, SizeOf(LongWord) - 1);
  while pBack[0] <= ' ' do
    dec(pBack);
BackwardDone:
  // just need to copy the result
  sLen := Integer(Cardinal(pBack) - Cardinal(pFront) + 1);
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_12_d(const AString: string): string;
var
  sLen: Integer;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  while Cardinal(pFront) < Cardinal(pBack) do
  begin
    if pFront[0] > ' ' then
      goto ForwardDone;
    inc(pFront);
  end;
  goto NoResult;
ForwardDone:
  Dec(pBack, SizeOf(LongWord));
  if sLen < 4 then
    goto BackwardFound;
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(pBack, SizeOf(LongWord));
  until False;
BackwardFound:
  inc(pBack, SizeOf(LongWord) - 1);
  while pBack[0] <= ' ' do
    dec(pBack);
BackwardDone:
  // just need to copy the result
  sLen := Integer(Cardinal(pBack) - Cardinal(pFront) + 1);
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_13_a(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  repeat
    Dec(pBack, SizeOf(LongWord));
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    goto BackwardDone;
  end;
  dec(pBack);
  //  inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Integer(Cardinal(pBack) - Cardinal(pFront));
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_13_b(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  repeat
    Dec(pBack, SizeOf(LongWord));
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    goto BackwardDone;
  end;
  dec(pBack);
  //  inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Integer(Cardinal(pBack) - Cardinal(pFront));
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler5;
asm
  nop;
end;
function Trim_DLA_PAS_13_c(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  repeat
    Dec(pBack, SizeOf(LongWord));
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    goto BackwardDone;
  end;
  dec(pBack);
  //  inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Integer(Cardinal(pBack) - Cardinal(pFront));
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_13_d(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  repeat
    Dec(pBack, SizeOf(LongWord));
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    goto BackwardDone;
  end;
  dec(pBack);
  //  inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Integer(Cardinal(pBack) - Cardinal(pFront));
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_14_a(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) { and $80808080});
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  // must be the last one
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  repeat
    Dec(pBack, SizeOf(LongWord));
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  // mask for the location
  nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) { and $80808080});
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  // must be the last one.
//    inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler9;
asm
  nop;
end;
function Trim_DLA_PAS_14_b(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) { and $80808080});
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  // must be the last one
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  repeat
    Dec(pBack, SizeOf(LongWord));
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  // mask for the location
  nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) { and $80808080});
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  // must be the last one.
//    inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler6;
asm
  nop;
end;
function Trim_DLA_PAS_14_c(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) { and $80808080});
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  // must be the last one
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  repeat
    Dec(pBack, SizeOf(LongWord));
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  // mask for the location
  nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) { and $80808080});
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  // must be the last one.
//    inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler7;
asm
  nop;
end;
function Trim_DLA_PAS_14_d(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) { and $80808080});
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  // must be the last one
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  repeat
    Dec(pBack, SizeOf(LongWord));
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  // mask for the location
  nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) { and $80808080});
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  // must be the last one.
//    inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_15_a(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto ForwardFound;
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) { and $80808080});
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  if nonSpacesFound and $80000000 <> 0 then
  begin
    Inc(pFront, 3);
    goto ForwardDone;
  end;
  goto NoResult;
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  if sLen < 4 then
  begin
    Dec(pBack, SizeOf(LongWord));
    goto BackwardFound;
  end;
  // start the backward search
  repeat
    Dec(pBack, SizeOf(LongWord));
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  // mask for the location
  nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) { and $80808080});
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  // if it's not the last one
  if nonSpacesFound and $00000080 = 0 then
    goto NoResult;
  // must be the last one.
//    inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_15_b(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto ForwardFound;
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) { and $80808080});
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  if nonSpacesFound and $80000000 <> 0 then
  begin
    Inc(pFront, 3);
    goto ForwardDone;
  end;
  goto NoResult;
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  if sLen < 4 then
  begin
    Dec(pBack, SizeOf(LongWord));
    goto BackwardFound;
  end;
  // start the backward search
  repeat
    Dec(pBack, SizeOf(LongWord));
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  // mask for the location
  nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) { and $80808080});
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  // if it's not the last one
  if nonSpacesFound and $00000080 = 0 then
    goto NoResult;
  // must be the last one.
//    inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler8;
asm
  nop;
end;
function Trim_DLA_PAS_15_c(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto ForwardFound;
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) { and $80808080});
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  if nonSpacesFound and $80000000 <> 0 then
  begin
    Inc(pFront, 3);
    goto ForwardDone;
  end;
  goto NoResult;
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  if sLen < 4 then
  begin
    Dec(pBack, SizeOf(LongWord));
    goto BackwardFound;
  end;
  // start the backward search
  repeat
    Dec(pBack, SizeOf(LongWord));
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  // mask for the location
  nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) { and $80808080});
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  // if it's not the last one
  if nonSpacesFound and $00000080 = 0 then
    goto NoResult;
  // must be the last one.
//    inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_15_d(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto ForwardFound;
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) { and $80808080});
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  if nonSpacesFound and $80000000 <> 0 then
  begin
    Inc(pFront, 3);
    goto ForwardDone;
  end;
  goto NoResult;
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  if sLen < 4 then
  begin
    Dec(pBack, SizeOf(LongWord));
    goto BackwardFound;
  end;
  // start the backward search
  repeat
    Dec(pBack, SizeOf(LongWord));
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  // mask for the location
  nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) { and $80808080});
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  // if it's not the last one
  if nonSpacesFound and $00000080 = 0 then
    goto NoResult;
  // must be the last one.
//    inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_16_a(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, f1, f2, f3, f4, ForwardDone, BackwardFound, b1, b2, b3, b4, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto f1;
  if nonSpacesFound and $00008000 <> 0 then
    goto f2;
  if nonSpacesFound and $00800000 <> 0 then
    goto f3;
  f4: Inc(pFront);
  f3: Inc(pFront);
  f2: Inc(pFront);
  f1:
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  repeat
    Dec(pBack, SizeOf(LongWord));
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
    goto b1;
  if nonSpacesFound and $00800000 <> 0 then
    goto b2;
  if nonSpacesFound and $00008000 <> 0 then
    goto b3;
  goto b4;
  b1: Inc(pBack);
  b2: Inc(pBack);
  b3: Inc(pBack);
  b4:
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler51;
asm
  nop;
end;
function Trim_DLA_PAS_16_b(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, f1, f2, f3, f4, ForwardDone, BackwardFound, b1, b2, b3, b4, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto f1;
  if nonSpacesFound and $00008000 <> 0 then
    goto f2;
  if nonSpacesFound and $00800000 <> 0 then
    goto f3;
  f4: Inc(pFront);
  f3: Inc(pFront);
  f2: Inc(pFront);
  f1:
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  repeat
    Dec(pBack, SizeOf(LongWord));
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
    goto b1;
  if nonSpacesFound and $00800000 <> 0 then
    goto b2;
  if nonSpacesFound and $00008000 <> 0 then
    goto b3;
  goto b4;
  b1: Inc(pBack);
  b2: Inc(pBack);
  b3: Inc(pBack);
  b4:
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler10;
asm
  nop;
end;
function Trim_DLA_PAS_16_c(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, f1, f2, f3, f4, ForwardDone, BackwardFound, b1, b2, b3, b4, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto f1;
  if nonSpacesFound and $00008000 <> 0 then
    goto f2;
  if nonSpacesFound and $00800000 <> 0 then
    goto f3;
  f4: Inc(pFront);
  f3: Inc(pFront);
  f2: Inc(pFront);
  f1:
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  repeat
    Dec(pBack, SizeOf(LongWord));
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
    goto b1;
  if nonSpacesFound and $00800000 <> 0 then
    goto b2;
  if nonSpacesFound and $00008000 <> 0 then
    goto b3;
  goto b4;
  b1: Inc(pBack);
  b2: Inc(pBack);
  b3: Inc(pBack);
  b4:
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler43;
asm
  nop;
end;
function Trim_DLA_PAS_16_d(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, f1, f2, f3, f4, ForwardDone, BackwardFound, b1, b2, b3, b4, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto f1;
  if nonSpacesFound and $00008000 <> 0 then
    goto f2;
  if nonSpacesFound and $00800000 <> 0 then
    goto f3;
  f4: Inc(pFront);
  f3: Inc(pFront);
  f2: Inc(pFront);
  f1:
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  repeat
    Dec(pBack, SizeOf(LongWord));
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
    goto b1;
  if nonSpacesFound and $00800000 <> 0 then
    goto b2;
  if nonSpacesFound and $00008000 <> 0 then
    goto b3;
  goto b4;
  b1: Inc(pBack);
  b2: Inc(pBack);
  b3: Inc(pBack);
  b4:
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_17_a(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, SmallForward, ForwardFound, ForwardDone, SmallBackward, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto SmallForward;
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
  //  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  Inc(pFront, 3);
  goto ForwardDone;
  SmallForward:
  if pFront[0] > ' ' then
    goto ForwardDone;
  if pFront[1] > ' ' then
  begin
    inc(pFront);
    goto ForwardDone;
  end;
  if pFront[2] > ' ' then
  begin
    inc(pFront, 2);
    goto ForwardDone;
  end;
  if pFront[3] > ' ' then
  begin
    inc(pFront, 3);
    goto ForwardDone;
  end;
  goto NoResult;
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  if sLen < 4 then
    goto SmallBackward;
  // start the backward search
  repeat
    Dec(pBack, SizeOf(LongWord));
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  inc(pBack, SizeOf(LongWord) - 4);
  goto BackwardDone;
  SmallBackward:
  if pBack[-1] > ' ' then
  begin
    Dec(pBack, 1);
    goto BackwardDone;
  end;
  if pBack[-2] > ' ' then
  begin
    Dec(pBack, 2);
    goto BackwardDone;
  end;
  if pBack[-3] > ' ' then
  begin
    Dec(pBack, 3);
    goto BackwardDone;
  end;
  if pBack[-4] > ' ' then
  begin
    Dec(pBack, 4);
    goto BackwardDone;
  end;
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_17_b(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, SmallForward, ForwardFound, ForwardDone, SmallBackward, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto SmallForward;
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
  //  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  Inc(pFront, 3);
  goto ForwardDone;
  SmallForward:
  if pFront[0] > ' ' then
    goto ForwardDone;
  if pFront[1] > ' ' then
  begin
    inc(pFront);
    goto ForwardDone;
  end;
  if pFront[2] > ' ' then
  begin
    inc(pFront, 2);
    goto ForwardDone;
  end;
  if pFront[3] > ' ' then
  begin
    inc(pFront, 3);
    goto ForwardDone;
  end;
  goto NoResult;
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  if sLen < 4 then
    goto SmallBackward;
  // start the backward search
  repeat
    Dec(pBack, SizeOf(LongWord));
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  inc(pBack, SizeOf(LongWord) - 4);
  goto BackwardDone;
  SmallBackward:
  if pBack[-1] > ' ' then
  begin
    Dec(pBack, 1);
    goto BackwardDone;
  end;
  if pBack[-2] > ' ' then
  begin
    Dec(pBack, 2);
    goto BackwardDone;
  end;
  if pBack[-3] > ' ' then
  begin
    Dec(pBack, 3);
    goto BackwardDone;
  end;
  if pBack[-4] > ' ' then
  begin
    Dec(pBack, 4);
    goto BackwardDone;
  end;
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler52;
asm
  nop;
end;
function Trim_DLA_PAS_17_c(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, SmallForward, ForwardFound, ForwardDone, SmallBackward, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto SmallForward;
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
  //  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  Inc(pFront, 3);
  goto ForwardDone;
  SmallForward:
  if pFront[0] > ' ' then
    goto ForwardDone;
  if pFront[1] > ' ' then
  begin
    inc(pFront);
    goto ForwardDone;
  end;
  if pFront[2] > ' ' then
  begin
    inc(pFront, 2);
    goto ForwardDone;
  end;
  if pFront[3] > ' ' then
  begin
    inc(pFront, 3);
    goto ForwardDone;
  end;
  goto NoResult;
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  if sLen < 4 then
    goto SmallBackward;
  // start the backward search
  repeat
    Dec(pBack, SizeOf(LongWord));
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  inc(pBack, SizeOf(LongWord) - 4);
  goto BackwardDone;
  SmallBackward:
  if pBack[-1] > ' ' then
  begin
    Dec(pBack, 1);
    goto BackwardDone;
  end;
  if pBack[-2] > ' ' then
  begin
    Dec(pBack, 2);
    goto BackwardDone;
  end;
  if pBack[-3] > ' ' then
  begin
    Dec(pBack, 3);
    goto BackwardDone;
  end;
  if pBack[-4] > ' ' then
  begin
    Dec(pBack, 4);
    goto BackwardDone;
  end;
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_17_d(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, SmallForward, ForwardFound, ForwardDone, SmallBackward, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto SmallForward;
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
  //  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  Inc(pFront, 3);
  goto ForwardDone;
  SmallForward:
  if pFront[0] > ' ' then
    goto ForwardDone;
  if pFront[1] > ' ' then
  begin
    inc(pFront);
    goto ForwardDone;
  end;
  if pFront[2] > ' ' then
  begin
    inc(pFront, 2);
    goto ForwardDone;
  end;
  if pFront[3] > ' ' then
  begin
    inc(pFront, 3);
    goto ForwardDone;
  end;
  goto NoResult;
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  if sLen < 4 then
    goto SmallBackward;
  // start the backward search
  repeat
    Dec(pBack, SizeOf(LongWord));
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  inc(pBack, SizeOf(LongWord) - 4);
  goto BackwardDone;
  SmallBackward:
  if pBack[-1] > ' ' then
  begin
    Dec(pBack, 1);
    goto BackwardDone;
  end;
  if pBack[-2] > ' ' then
  begin
    Dec(pBack, 2);
    goto BackwardDone;
  end;
  if pBack[-3] > ' ' then
  begin
    Dec(pBack, 3);
    goto BackwardDone;
  end;
  if pBack[-4] > ' ' then
  begin
    Dec(pBack, 4);
    goto BackwardDone;
  end;
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_18_a(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  Dec(pBack, SizeOf(LongWord));
  repeat
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
    nonSpacesFound := ((((PLongWord(@pBack[-4])^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(@pBack[-4])^) and $80808080);
    if nonSpacesFound <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord));
      goto BackwardFound;
    end;
    nonSpacesFound := ((((PLongWord(@pBack[-8])^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(@pBack[-8])^) and $80808080);
    if nonSpacesFound <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord) * 2);
      goto BackwardFound;
    end;
    nonSpacesFound := ((((PLongWord(@pBack[-12])^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(@pBack[-12])^) and $80808080);
    if nonSpacesFound <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord) * 3);
      goto BackwardFound;
    end;
    Dec(pBack, SizeOf(LongWord) * 4);
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  //  inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler53;
asm
  nop;
end;
function Trim_DLA_PAS_18_b(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  Dec(pBack, SizeOf(LongWord));
  repeat
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
    nonSpacesFound := ((((PLongWord(@pBack[-4])^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(@pBack[-4])^) and $80808080);
    if nonSpacesFound <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord));
      goto BackwardFound;
    end;
    nonSpacesFound := ((((PLongWord(@pBack[-8])^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(@pBack[-8])^) and $80808080);
    if nonSpacesFound <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord) * 2);
      goto BackwardFound;
    end;
    nonSpacesFound := ((((PLongWord(@pBack[-12])^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(@pBack[-12])^) and $80808080);
    if nonSpacesFound <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord) * 3);
      goto BackwardFound;
    end;
    Dec(pBack, SizeOf(LongWord) * 4);
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  //  inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler55;
asm
  nop;
end;
function Trim_DLA_PAS_18_c(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  Dec(pBack, SizeOf(LongWord));
  repeat
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
    nonSpacesFound := ((((PLongWord(@pBack[-4])^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(@pBack[-4])^) and $80808080);
    if nonSpacesFound <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord));
      goto BackwardFound;
    end;
    nonSpacesFound := ((((PLongWord(@pBack[-8])^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(@pBack[-8])^) and $80808080);
    if nonSpacesFound <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord) * 2);
      goto BackwardFound;
    end;
    nonSpacesFound := ((((PLongWord(@pBack[-12])^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(@pBack[-12])^) and $80808080);
    if nonSpacesFound <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord) * 3);
      goto BackwardFound;
    end;
    Dec(pBack, SizeOf(LongWord) * 4);
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  //  inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler11;
asm
  nop;
end;
function Trim_DLA_PAS_18_d(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  Dec(pBack, SizeOf(LongWord));
  repeat
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
    nonSpacesFound := ((((PLongWord(@pBack[-4])^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(@pBack[-4])^) and $80808080);
    if nonSpacesFound <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord));
      goto BackwardFound;
    end;
    nonSpacesFound := ((((PLongWord(@pBack[-8])^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(@pBack[-8])^) and $80808080);
    if nonSpacesFound <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord) * 2);
      goto BackwardFound;
    end;
    nonSpacesFound := ((((PLongWord(@pBack[-12])^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(@pBack[-12])^) and $80808080);
    if nonSpacesFound <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord) * 3);
      goto BackwardFound;
    end;
    Dec(pBack, SizeOf(LongWord) * 4);
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  //  inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_19_a(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  Dec(pBack, SizeOf(LongWord));
  repeat
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
    nonSpacesFound := ((((PLongWord(@pBack[-4])^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(@pBack[-4])^) and $80808080);
    if nonSpacesFound <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord));
      goto BackwardFound;
    end;
    Dec(pBack, SizeOf(LongWord) * 2);
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  //  inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_19_b(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  Dec(pBack, SizeOf(LongWord));
  repeat
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
    nonSpacesFound := ((((PLongWord(@pBack[-4])^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(@pBack[-4])^) and $80808080);
    if nonSpacesFound <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord));
      goto BackwardFound;
    end;
    Dec(pBack, SizeOf(LongWord) * 2);
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  //  inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_19_c(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  Dec(pBack, SizeOf(LongWord));
  repeat
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
    nonSpacesFound := ((((PLongWord(@pBack[-4])^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(@pBack[-4])^) and $80808080);
    if nonSpacesFound <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord));
      goto BackwardFound;
    end;
    Dec(pBack, SizeOf(LongWord) * 2);
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  //  inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_19_d(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  Dec(pBack, SizeOf(LongWord));
  repeat
    nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
    if nonSpacesFound <> 0 then
      goto BackwardFound;
    nonSpacesFound := ((((PLongWord(@pBack[-4])^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(@pBack[-4])^) and $80808080);
    if nonSpacesFound <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord));
      goto BackwardFound;
    end;
    Dec(pBack, SizeOf(LongWord) * 2);
  until False;
BackwardFound:
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  //  inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_20_a(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) { and $80808080});
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  // must be the last one
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  Dec(pBack, SizeOf(LongWord));
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    if (((PLongWord(@pBack[-4])^ + $5F5F5F5F) or PLongWord(@pBack[-4])^) and $80808080) <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord));
      goto BackwardFound;
    end;
    if (((PLongWord(@pBack[-8])^ + $5F5F5F5F) or PLongWord(@pBack[-8])^) and $80808080) <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord) * 2);
      goto BackwardFound;
    end;
    if (((PLongWord(@pBack[-12])^ + $5F5F5F5F) or PLongWord(@pBack[-12])^) and $80808080) <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord) * 3);
      goto BackwardFound;
    end;
    Dec(pBack, SizeOf(LongWord) * 4);
  until False;
BackwardFound:
  // mask for the location
  nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) { and $80808080});
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  // must be the last one.
//    inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler12;
asm
  nop;
end;
function Trim_DLA_PAS_20_b(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) { and $80808080});
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  // must be the last one
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  Dec(pBack, SizeOf(LongWord));
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    if (((PLongWord(@pBack[-4])^ + $5F5F5F5F) or PLongWord(@pBack[-4])^) and $80808080) <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord));
      goto BackwardFound;
    end;
    if (((PLongWord(@pBack[-8])^ + $5F5F5F5F) or PLongWord(@pBack[-8])^) and $80808080) <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord) * 2);
      goto BackwardFound;
    end;
    if (((PLongWord(@pBack[-12])^ + $5F5F5F5F) or PLongWord(@pBack[-12])^) and $80808080) <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord) * 3);
      goto BackwardFound;
    end;
    Dec(pBack, SizeOf(LongWord) * 4);
  until False;
BackwardFound:
  // mask for the location
  nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) { and $80808080});
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  // must be the last one.
//    inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler13;
asm
  nop;
end;
function Trim_DLA_PAS_20_c(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) { and $80808080});
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  // must be the last one
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  Dec(pBack, SizeOf(LongWord));
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    if (((PLongWord(@pBack[-4])^ + $5F5F5F5F) or PLongWord(@pBack[-4])^) and $80808080) <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord));
      goto BackwardFound;
    end;
    if (((PLongWord(@pBack[-8])^ + $5F5F5F5F) or PLongWord(@pBack[-8])^) and $80808080) <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord) * 2);
      goto BackwardFound;
    end;
    if (((PLongWord(@pBack[-12])^ + $5F5F5F5F) or PLongWord(@pBack[-12])^) and $80808080) <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord) * 3);
      goto BackwardFound;
    end;
    Dec(pBack, SizeOf(LongWord) * 4);
  until False;
BackwardFound:
  // mask for the location
  nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) { and $80808080});
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  // must be the last one.
//    inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler14;
asm
  nop;
end;
function Trim_DLA_PAS_20_d(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) { and $80808080});
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  // must be the last one
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  Dec(pBack, SizeOf(LongWord));
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    if (((PLongWord(@pBack[-4])^ + $5F5F5F5F) or PLongWord(@pBack[-4])^) and $80808080) <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord));
      goto BackwardFound;
    end;
    if (((PLongWord(@pBack[-8])^ + $5F5F5F5F) or PLongWord(@pBack[-8])^) and $80808080) <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord) * 2);
      goto BackwardFound;
    end;
    if (((PLongWord(@pBack[-12])^ + $5F5F5F5F) or PLongWord(@pBack[-12])^) and $80808080) <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord) * 3);
      goto BackwardFound;
    end;
    Dec(pBack, SizeOf(LongWord) * 4);
  until False;
BackwardFound:
  // mask for the location
  nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) { and $80808080});
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  // must be the last one.
//    inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_21_a(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) { and $80808080});
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  // must be the last one
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  Dec(pBack, SizeOf(LongWord));
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    if (((PLongWord(@pBack[-4])^ + $5F5F5F5F) or PLongWord(@pBack[-4])^) and $80808080) <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord));
      goto BackwardFound;
    end;
    Dec(pBack, SizeOf(LongWord) * 2);
  until False;
BackwardFound:
  // mask for the location
  nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) { and $80808080});
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  // must be the last one.
//    inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler54;
asm
  nop;
end;
function Trim_DLA_PAS_21_b(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) { and $80808080});
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  // must be the last one
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  Dec(pBack, SizeOf(LongWord));
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    if (((PLongWord(@pBack[-4])^ + $5F5F5F5F) or PLongWord(@pBack[-4])^) and $80808080) <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord));
      goto BackwardFound;
    end;
    Dec(pBack, SizeOf(LongWord) * 2);
  until False;
BackwardFound:
  // mask for the location
  nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) { and $80808080});
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  // must be the last one.
//    inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler56;
asm
  nop;
end;
function Trim_DLA_PAS_21_c(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) { and $80808080});
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  // must be the last one
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  Dec(pBack, SizeOf(LongWord));
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    if (((PLongWord(@pBack[-4])^ + $5F5F5F5F) or PLongWord(@pBack[-4])^) and $80808080) <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord));
      goto BackwardFound;
    end;
    Dec(pBack, SizeOf(LongWord) * 2);
  until False;
BackwardFound:
  // mask for the location
  nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) { and $80808080});
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  // must be the last one.
//    inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler15;
asm
  nop;
end;
function Trim_DLA_PAS_21_d(const AString: string): string;
var
  sLen: Integer;
  nonSpacesFound: LongWord;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) { and $80808080});
  if nonSpacesFound and $00000080 <> 0 then
    goto ForwardDone;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    Inc(pFront);
    goto ForwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    Inc(pFront, 2);
    goto ForwardDone;
  end;
  // must be the last one
  Inc(pFront, 3);
ForwardDone:
  if Cardinal(pFront) >= Cardinal(pBack) then
    goto NoResult;
  // start the backward search
  Dec(pBack, SizeOf(LongWord));
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    if (((PLongWord(@pBack[-4])^ + $5F5F5F5F) or PLongWord(@pBack[-4])^) and $80808080) <> 0 then
    begin
      Dec(pBack, SizeOf(LongWord));
      goto BackwardFound;
    end;
    Dec(pBack, SizeOf(LongWord) * 2);
  until False;
BackwardFound:
  // mask for the location
  nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) { and $80808080});
  if nonSpacesFound and $80000000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 1);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00800000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 2);
    goto BackwardDone;
  end;
  if nonSpacesFound and $00008000 <> 0 then
  begin
    inc(pBack, SizeOf(LongWord) - 3);
    goto BackwardDone;
  end;
  // must be the last one.
//    inc(pBack, SizeOf(LongWord) - 4);
BackwardDone:
  // just need to copy the result
  sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_22_a(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := PChar(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if (((Byte(p[iFront]) + $5F) or Byte(p[iFront])) and $80) <> 0 then
    begin
      iBack := sLen - 1;
      while (((Byte(p[iBack]) + $5F) or Byte(p[iBack])) and $80) = 0 do
        dec(iBack);
      inc(iBack);
      if (iFront = 0) and (iBack = sLen) then
        Result := AString
      else
      begin
        sLen := iBack - iFront;
        SetLength(Result, sLen);
        Move(p[iFront], PByteArray(Pointer(Result))^[0], sLen);
      end;
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;

procedure Filler16;
asm
  nop;
end;
function Trim_DLA_PAS_22_b(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := PChar(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if (((Byte(p[iFront]) + $5F) or Byte(p[iFront])) and $80) <> 0 then
    begin
      iBack := sLen - 1;
      while (((Byte(p[iBack]) + $5F) or Byte(p[iBack])) and $80) = 0 do
        dec(iBack);
      inc(iBack);
      if (iFront = 0) and (iBack = sLen) then
        Result := AString
      else
      begin
        sLen := iBack - iFront;
        SetLength(Result, sLen);
        Move(p[iFront], PByteArray(Pointer(Result))^[0], sLen);
      end;
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;
procedure Filler17;
asm
  nop;
end;

function Trim_DLA_PAS_22_c(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := PChar(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if (((Byte(p[iFront]) + $5F) or Byte(p[iFront])) and $80) <> 0 then
    begin
      iBack := sLen - 1;
      while (((Byte(p[iBack]) + $5F) or Byte(p[iBack])) and $80) = 0 do
        dec(iBack);
      inc(iBack);
      if (iFront = 0) and (iBack = sLen) then
        Result := AString
      else
      begin
        sLen := iBack - iFront;
        SetLength(Result, sLen);
        Move(p[iFront], PByteArray(Pointer(Result))^[0], sLen);
      end;
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;
procedure Filler18;
asm
  nop;
end;

function Trim_DLA_PAS_22_d(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := PChar(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if (((Byte(p[iFront]) + $5F) or Byte(p[iFront])) and $80) <> 0 then
    begin
      iBack := sLen - 1;
      while (((Byte(p[iBack]) + $5F) or Byte(p[iBack])) and $80) = 0 do
        dec(iBack);
      inc(iBack);
      if (iFront = 0) and (iBack = sLen) then
        Result := AString
      else
      begin
        sLen := iBack - iFront;
        SetLength(Result, sLen);
        Move(p[iFront], PByteArray(Pointer(Result))^[0], sLen);
      end;
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;


function Trim_DLA_PAS_23_a(const AString: string): string;
var
  sLen: Integer;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if pFront[0] > ' ' then
    goto ForwardDone;
  if pFront[1] > ' ' then
  begin
    inc(pFront, 1);
    goto ForwardDone;
  end;
  if pFront[2] > ' ' then
  begin
    inc(pFront, 2);
    goto ForwardDone;
  end;
  if pFront[3] > ' ' then
  begin
    inc(pFront, 3);
    goto ForwardDone;
  end;
  goto NoResult;
ForwardDone:
  Dec(pBack, SizeOf(LongWord));
  if sLen < 4 then
    goto BackwardFound;
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(pBack, SizeOf(LongWord));
  until False;
BackwardFound:
  if pBack[3] > ' ' then
  begin
    inc(pBack, 4);
    goto BackwardDone;
  end;
  if pBack[2] > ' ' then
  begin
    inc(pBack, 3);
    goto BackwardDone;
  end;
  if pBack[1] > ' ' then
  begin
    inc(pBack, 2);
    goto BackwardDone;
  end;
  inc(pBack);
BackwardDone:
  // just need to copy the result
  sLen := Integer(Cardinal(pBack) - Cardinal(pFront));
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler19;
asm
  nop;
end;
function Trim_DLA_PAS_23_b(const AString: string): string;
var
  sLen: Integer;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if pFront[0] > ' ' then
    goto ForwardDone;
  if pFront[1] > ' ' then
  begin
    inc(pFront, 1);
    goto ForwardDone;
  end;
  if pFront[2] > ' ' then
  begin
    inc(pFront, 2);
    goto ForwardDone;
  end;
  if pFront[3] > ' ' then
  begin
    inc(pFront, 3);
    goto ForwardDone;
  end;
  goto NoResult;
ForwardDone:
  Dec(pBack, SizeOf(LongWord));
  if sLen < 4 then
    goto BackwardFound;
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(pBack, SizeOf(LongWord));
  until False;
BackwardFound:
  if pBack[3] > ' ' then
  begin
    inc(pBack, 4);
    goto BackwardDone;
  end;
  if pBack[2] > ' ' then
  begin
    inc(pBack, 3);
    goto BackwardDone;
  end;
  if pBack[1] > ' ' then
  begin
    inc(pBack, 2);
    goto BackwardDone;
  end;
  inc(pBack);
BackwardDone:
  // just need to copy the result
  sLen := Integer(Cardinal(pBack) - Cardinal(pFront));
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler20;
asm
  nop;
end;
function Trim_DLA_PAS_23_c(const AString: string): string;
var
  sLen: Integer;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if pFront[0] > ' ' then
    goto ForwardDone;
  if pFront[1] > ' ' then
  begin
    inc(pFront, 1);
    goto ForwardDone;
  end;
  if pFront[2] > ' ' then
  begin
    inc(pFront, 2);
    goto ForwardDone;
  end;
  if pFront[3] > ' ' then
  begin
    inc(pFront, 3);
    goto ForwardDone;
  end;
  goto NoResult;
ForwardDone:
  Dec(pBack, SizeOf(LongWord));
  if sLen < 4 then
    goto BackwardFound;
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(pBack, SizeOf(LongWord));
  until False;
BackwardFound:
  if pBack[3] > ' ' then
  begin
    inc(pBack, 4);
    goto BackwardDone;
  end;
  if pBack[2] > ' ' then
  begin
    inc(pBack, 3);
    goto BackwardDone;
  end;
  if pBack[1] > ' ' then
  begin
    inc(pBack, 2);
    goto BackwardDone;
  end;
  inc(pBack);
BackwardDone:
  // just need to copy the result
  sLen := Integer(Cardinal(pBack) - Cardinal(pFront));
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler21;
asm
  nop;
end;

function Trim_DLA_PAS_23_d(const AString: string): string;
var
  sLen: Integer;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardFound, BackwardDone;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  if sLen < 4 then
    goto forwardFound;
  repeat
    if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
      goto forwardFound;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
ForwardFound:
  if pFront[0] > ' ' then
    goto ForwardDone;
  if pFront[1] > ' ' then
  begin
    inc(pFront, 1);
    goto ForwardDone;
  end;
  if pFront[2] > ' ' then
  begin
    inc(pFront, 2);
    goto ForwardDone;
  end;
  if pFront[3] > ' ' then
  begin
    inc(pFront, 3);
    goto ForwardDone;
  end;
  goto NoResult;
ForwardDone:
  Dec(pBack, SizeOf(LongWord));
  if sLen < 4 then
    goto BackwardFound;
  repeat
    if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
      goto BackwardFound;
    dec(pBack, SizeOf(LongWord));
  until False;
BackwardFound:
  if pBack[3] > ' ' then
  begin
    inc(pBack, 4);
    goto BackwardDone;
  end;
  if pBack[2] > ' ' then
  begin
    inc(pBack, 3);
    goto BackwardDone;
  end;
  if pBack[1] > ' ' then
  begin
    inc(pBack, 2);
    goto BackwardDone;
  end;
  inc(pBack);
BackwardDone:
  // just need to copy the result
  sLen := Integer(Cardinal(pBack) - Cardinal(pFront));
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_24_a(const AString: string): string;
var
  sLen: Integer;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardSearch, Found;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    if pFront[0] > ' ' then
      goto BackwardSearch;
    if pFront[1] > ' ' then
    begin
      inc(pFront, 1);
      goto BackwardSearch;
    end;
    if pFront[2] > ' ' then
    begin
      inc(pFront, 2);
      goto BackwardSearch;
    end;
    if pFront[3] > ' ' then
    begin
      inc(pFront, 3);
      goto BackwardSearch;
    end;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
BackwardSearch:
  repeat
    Dec(pBack, SizeOf(LongWord));
    if pBack[3] > ' ' then
    begin
      inc(pBack, 4);
      goto Found;
    end;
    if pBack[2] > ' ' then
    begin
      inc(pBack, 3);
      goto Found;
    end;
    if pBack[1] > ' ' then
    begin
      inc(pBack, 2);
      goto Found;
    end;
    if pBack[0] > ' ' then
    begin
      inc(pBack);
      goto Found;
    end;
  until False;
Found:
  // just need to copy the result
  sLen := Integer(Cardinal(pBack) - Cardinal(pFront));
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_24_b(const AString: string): string;
var
  sLen: Integer;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardSearch, Found;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    if pFront[0] > ' ' then
      goto BackwardSearch;
    if pFront[1] > ' ' then
    begin
      inc(pFront, 1);
      goto BackwardSearch;
    end;
    if pFront[2] > ' ' then
    begin
      inc(pFront, 2);
      goto BackwardSearch;
    end;
    if pFront[3] > ' ' then
    begin
      inc(pFront, 3);
      goto BackwardSearch;
    end;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
BackwardSearch:
  repeat
    Dec(pBack, SizeOf(LongWord));
    if pBack[3] > ' ' then
    begin
      inc(pBack, 4);
      goto Found;
    end;
    if pBack[2] > ' ' then
    begin
      inc(pBack, 3);
      goto Found;
    end;
    if pBack[1] > ' ' then
    begin
      inc(pBack, 2);
      goto Found;
    end;
    if pBack[0] > ' ' then
    begin
      inc(pBack);
      goto Found;
    end;
  until False;
Found:
  // just need to copy the result
  sLen := Integer(Cardinal(pBack) - Cardinal(pFront));
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;
procedure Filler22;
asm
  nop;
end;

function Trim_DLA_PAS_24_c(const AString: string): string;
var
  sLen: Integer;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardSearch, Found;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    if pFront[0] > ' ' then
      goto BackwardSearch;
    if pFront[1] > ' ' then
    begin
      inc(pFront, 1);
      goto BackwardSearch;
    end;
    if pFront[2] > ' ' then
    begin
      inc(pFront, 2);
      goto BackwardSearch;
    end;
    if pFront[3] > ' ' then
    begin
      inc(pFront, 3);
      goto BackwardSearch;
    end;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
BackwardSearch:
  repeat
    Dec(pBack, SizeOf(LongWord));
    if pBack[3] > ' ' then
    begin
      inc(pBack, 4);
      goto Found;
    end;
    if pBack[2] > ' ' then
    begin
      inc(pBack, 3);
      goto Found;
    end;
    if pBack[1] > ' ' then
    begin
      inc(pBack, 2);
      goto Found;
    end;
    if pBack[0] > ' ' then
    begin
      inc(pBack);
      goto Found;
    end;
  until False;
Found:
  // just need to copy the result
  sLen := Integer(Cardinal(pBack) - Cardinal(pFront));
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_24_d(const AString: string): string;
var
  sLen: Integer;
  pFront: PChar;
  pBack: PChar;
label
  NoResult, ForwardFound, ForwardDone, BackwardSearch, Found;
begin
  sLen := Length(AString);
  if sLen = 0 then
    goto NoResult;
  pFront := Pointer(AString);
  pBack := Pointer(Cardinal(pFront) + Cardinal(sLen));
  repeat
    if pFront[0] > ' ' then
      goto BackwardSearch;
    if pFront[1] > ' ' then
    begin
      inc(pFront, 1);
      goto BackwardSearch;
    end;
    if pFront[2] > ' ' then
    begin
      inc(pFront, 2);
      goto BackwardSearch;
    end;
    if pFront[3] > ' ' then
    begin
      inc(pFront, 3);
      goto BackwardSearch;
    end;
    Inc(pFront, SizeOf(LongWord));
    if Cardinal(pFront) >= Cardinal(pBack) then
      goto NoResult;
  until False;
BackwardSearch:
  repeat
    Dec(pBack, SizeOf(LongWord));
    if pBack[3] > ' ' then
    begin
      inc(pBack, 4);
      goto Found;
    end;
    if pBack[2] > ' ' then
    begin
      inc(pBack, 3);
      goto Found;
    end;
    if pBack[1] > ' ' then
    begin
      inc(pBack, 2);
      goto Found;
    end;
    if pBack[0] > ' ' then
    begin
      inc(pBack);
      goto Found;
    end;
  until False;
Found:
  // just need to copy the result
  sLen := Integer(Cardinal(pBack) - Cardinal(pFront));
  SetLength(Result, sLen);
  Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
  Exit;
NoResult:
  Result := '';
end;

function Trim_DLA_PAS_25_a(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := PChar(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if p[iFront] > ' ' then
    begin
      iBack := sLen - 1;
      while p[iBack] <= ' ' do
        dec(iBack);
      sLen := iBack - iFront + 1;
      SetLength(Result, sLen);
      Move(p[iFront], PByteArray(Pointer(Result))^[0], sLen);
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;

function Trim_DLA_PAS_25_b(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := PChar(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if p[iFront] > ' ' then
    begin
      iBack := sLen - 1;
      while p[iBack] <= ' ' do
        dec(iBack);
      sLen := iBack - iFront + 1;
      SetLength(Result, sLen);
      Move(p[iFront], PByteArray(Pointer(Result))^[0], sLen);
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;

function Trim_DLA_PAS_25_c(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := PChar(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if p[iFront] > ' ' then
    begin
      iBack := sLen - 1;
      while p[iBack] <= ' ' do
        dec(iBack);
      sLen := iBack - iFront + 1;
      SetLength(Result, sLen);
      Move(p[iFront], PByteArray(Pointer(Result))^[0], sLen);
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;

function Trim_DLA_PAS_25_d(const AString: string): string;
var
  iFront: Integer;
  iBack: Integer;
  sLen: Integer;
  p: PChar;
begin
  sLen := Length(AString);
  p := PChar(AString);
  iFront := 0;
  while iFront < sLen do
  begin
    if p[iFront] > ' ' then
    begin
      iBack := sLen - 1;
      while p[iBack] <= ' ' do
        dec(iBack);
      sLen := iBack - iFront + 1;
      SetLength(Result, sLen);
      Move(p[iFront], PByteArray(Pointer(Result))^[0], sLen);
      Exit;
    end;
    inc(iFront);
  end;
  Result := '';
end;





function Trim_DLA_IA32_1_a(const AString: string): string;
asm
    push ebx
    push esi
    push edi
    mov edi, edx
    { eax = AString }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { pFront }
    mov esi, [ebx - 4]  { sLen }
    test esi,esi        { sLen = 0 ? }
    jz @NoResult
    add eax,esi         { pBack = pFront + sLen }
    cmp esi,$04         { Small string? }
    jl @CheckLastWordFront
@FrontLoop:
 //if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
    mov edx,[ebx]      { LongWord of pFront }
    mov ecx, edx       { Copy for the calc }
    add ecx,$5f5f5f5f
    or ecx,edx
    test ecx,$80808080
    jnz @CheckLastWordFront
    add ebx,$04
    cmp ebx,eax        { Not past the end? }
    jnb @NoResult
    jmp @FrontLoop
@CheckLastWordFront:
    cmp byte ptr [ebx],$20 { check first char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check second char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check third char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check fourth char }
    jnbe @BackLoop
    jmp @NoResult
@BackLoop:
    sub eax,$04
    cmp esi,$04
    jl @CheckLastWordBack
@BackRealLoop:
 //if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
    mov edx,[eax]
    mov ecx,edx
    add ecx,$5f5f5f5f
    or ecx,edx
    test ecx,$80808080
    jnz @CheckLastWordBack
    sub eax,$04
    jmp @BackRealLoop
@CheckLastWordBack:
    add eax, $03
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
@FinalPart:
 //sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
    mov esi, eax
    sub esi, ebx
    inc esi
    mov edx, esi
    mov eax, edi
    call System.@LStrSetLength
 //Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
    mov edx,[edi]
    mov eax,ebx
    mov ecx,esi
    call Move
    jmp @Exit
@NoResult:
    mov eax,edi
    pop edi
    pop esi
    pop ebx
    jmp System.@LStrClr
@Exit:
    pop edi
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_1_b(const AString: string): string;
asm
    push ebx
    push esi
    push edi
    mov edi, edx
    { eax = AString }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { pFront }
    mov esi, [ebx - 4]  { sLen }
    test esi,esi        { sLen = 0 ? }
    jz @NoResult
    add eax,esi         { pBack = pFront + sLen }
    cmp esi,$04         { Small string? }
    jl @CheckLastWordFront
@FrontLoop:
 //if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
    mov edx,[ebx]      { LongWord of pFront }
    mov ecx, edx       { Copy for the calc }
    add ecx,$5f5f5f5f
    or ecx,edx
    test ecx,$80808080
    jnz @CheckLastWordFront
    add ebx,$04
    cmp ebx,eax        { Not past the end? }
    jnb @NoResult
    jmp @FrontLoop
@CheckLastWordFront:
    cmp byte ptr [ebx],$20 { check first char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check second char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check third char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check fourth char }
    jnbe @BackLoop
    jmp @NoResult
@BackLoop:
    sub eax,$04
    cmp esi,$04
    jl @CheckLastWordBack
@BackRealLoop:
 //if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
    mov edx,[eax]
    mov ecx,edx
    add ecx,$5f5f5f5f
    or ecx,edx
    test ecx,$80808080
    jnz @CheckLastWordBack
    sub eax,$04
    jmp @BackRealLoop
@CheckLastWordBack:
    add eax, $03
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
@FinalPart:
 //sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
    mov esi, eax
    sub esi, ebx
    inc esi
    mov edx, esi
    mov eax, edi
    call System.@LStrSetLength
 //Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
    mov edx,[edi]
    mov eax,ebx
    mov ecx,esi
    call Move
    jmp @Exit
@NoResult:
    mov eax,edi
    pop edi
    pop esi
    pop ebx
    jmp System.@LStrClr
@Exit:
    pop edi
    pop esi
    pop ebx
    ret
end;
procedure Filler25;
asm
  nop;
end;

function Trim_DLA_IA32_1_c(const AString: string): string;
asm
    push ebx
    push esi
    push edi
    mov edi, edx
    { eax = AString }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { pFront }
    mov esi, [ebx - 4]  { sLen }
    test esi,esi        { sLen = 0 ? }
    jz @NoResult
    add eax,esi         { pBack = pFront + sLen }
    cmp esi,$04         { Small string? }
    jl @CheckLastWordFront
@FrontLoop:
 //if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
    mov edx,[ebx]      { LongWord of pFront }
    mov ecx, edx       { Copy for the calc }
    add ecx,$5f5f5f5f
    or ecx,edx
    test ecx,$80808080
    jnz @CheckLastWordFront
    add ebx,$04
    cmp ebx,eax        { Not past the end? }
    jnb @NoResult
    jmp @FrontLoop
@CheckLastWordFront:
    cmp byte ptr [ebx],$20 { check first char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check second char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check third char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check fourth char }
    jnbe @BackLoop
    jmp @NoResult
@BackLoop:
    sub eax,$04
    cmp esi,$04
    jl @CheckLastWordBack
@BackRealLoop:
 //if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
    mov edx,[eax]
    mov ecx,edx
    add ecx,$5f5f5f5f
    or ecx,edx
    test ecx,$80808080
    jnz @CheckLastWordBack
    sub eax,$04
    jmp @BackRealLoop
@CheckLastWordBack:
    add eax, $03
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
@FinalPart:
 //sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
    mov esi, eax
    sub esi, ebx
    inc esi
    mov edx, esi
    mov eax, edi
    call System.@LStrSetLength
 //Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
    mov edx,[edi]
    mov eax,ebx
    mov ecx,esi
    call Move
    jmp @Exit
@NoResult:
    mov eax,edi
    pop edi
    pop esi
    pop ebx
    jmp System.@LStrClr
@Exit:
    pop edi
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_1_d(const AString: string): string;
asm
    push ebx
    push esi
    push edi
    mov edi, edx
    { eax = AString }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { pFront }
    mov esi, [ebx - 4]  { sLen }
    test esi,esi        { sLen = 0 ? }
    jz @NoResult
    add eax,esi         { pBack = pFront + sLen }
    cmp esi,$04         { Small string? }
    jl @CheckLastWordFront
@FrontLoop:
 //if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
    mov edx,[ebx]      { LongWord of pFront }
    mov ecx, edx       { Copy for the calc }
    add ecx,$5f5f5f5f
    or ecx,edx
    test ecx,$80808080
    jnz @CheckLastWordFront
    add ebx,$04
    cmp ebx,eax        { Not past the end? }
    jnb @NoResult
    jmp @FrontLoop
@CheckLastWordFront:
    cmp byte ptr [ebx],$20 { check first char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check second char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check third char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check fourth char }
    jnbe @BackLoop
    jmp @NoResult
@BackLoop:
    sub eax,$04
    cmp esi,$04
    jl @CheckLastWordBack
@BackRealLoop:
 //if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
    mov edx,[eax]
    mov ecx,edx
    add ecx,$5f5f5f5f
    or ecx,edx
    test ecx,$80808080
    jnz @CheckLastWordBack
    sub eax,$04
    jmp @BackRealLoop
@CheckLastWordBack:
    add eax, $03
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
@FinalPart:
 //sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
    mov esi, eax
    sub esi, ebx
    inc esi
    mov edx, esi
    mov eax, edi
    call System.@LStrSetLength
 //Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
    mov edx,[edi]
    mov eax,ebx
    mov ecx,esi
    call Move
    jmp @Exit
@NoResult:
    mov eax,edi
    pop edi
    pop esi
    pop ebx
    jmp System.@LStrClr
@Exit:
    pop edi
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_2_a(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      test al,$80
      jnz @BackStart
      inc ebx
      test ah,$80
      jnz @BackStart
      inc ebx
      test eax,$00800000
      jnz @BackStart
      inc ebx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
// nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
// if nonSpacesFound and $80000000 <> 0 then
      add edx,$03
      test eax,$80000000
      jnz @Final
      dec edx
      test eax,$00800000
      jnz @Final
      dec edx
      test ah,$80
      jnz @Final
      dec edx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,[edx - 4]
      call Move
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;
procedure Filler26;
asm
  nop;
end;


function Trim_DLA_IA32_2_b(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      test al,$80
      jnz @BackStart
      inc ebx
      test ah,$80
      jnz @BackStart
      inc ebx
      test eax,$00800000
      jnz @BackStart
      inc ebx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
// nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
// if nonSpacesFound and $80000000 <> 0 then
      add edx,$03
      test eax,$80000000
      jnz @Final
      dec edx
      test eax,$00800000
      jnz @Final
      dec edx
      test ah,$80
      jnz @Final
      dec edx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,[edx - 4]
      call Move
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;
procedure Filler27;
asm
  nop;
end;


function Trim_DLA_IA32_2_c(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      test al,$80
      jnz @BackStart
      inc ebx
      test ah,$80
      jnz @BackStart
      inc ebx
      test eax,$00800000
      jnz @BackStart
      inc ebx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
// nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
// if nonSpacesFound and $80000000 <> 0 then
      add edx,$03
      test eax,$80000000
      jnz @Final
      dec edx
      test eax,$00800000
      jnz @Final
      dec edx
      test ah,$80
      jnz @Final
      dec edx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,[edx - 4]
      call Move
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;
procedure Filler28;
asm
  nop;
end;


function Trim_DLA_IA32_2_d(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      test al,$80
      jnz @BackStart
      inc ebx
      test ah,$80
      jnz @BackStart
      inc ebx
      test eax,$00800000
      jnz @BackStart
      inc ebx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
// nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
// if nonSpacesFound and $80000000 <> 0 then
      add edx,$03
      test eax,$80000000
      jnz @Final
      dec edx
      test eax,$00800000
      jnz @Final
      dec edx
      test ah,$80
      jnz @Final
      dec edx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,[edx - 4]
      call Move
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;


function Trim_DLA_IA32_3_a(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      test al,$80
      jnz @BackStart
      inc ebx
      test ah,$80
      jnz @BackStart
      inc ebx
      test eax,$00800000
      jnz @BackStart
      inc ebx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
// nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
// if nonSpacesFound and $80000000 <> 0 then
      add edx,$03
      test eax,$80000000
      jnz @Final
      dec edx
      test eax,$00800000
      jnz @Final
      dec edx
      test ah,$80
      jnz @Final
      dec edx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      push edi
      mov edi, edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,edi
      call Move
      pop edi
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;
procedure Filler29;
asm
  nop;
end;

function Trim_DLA_IA32_3_b(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      test al,$80
      jnz @BackStart
      inc ebx
      test ah,$80
      jnz @BackStart
      inc ebx
      test eax,$00800000
      jnz @BackStart
      inc ebx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
// nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
// if nonSpacesFound and $80000000 <> 0 then
      add edx,$03
      test eax,$80000000
      jnz @Final
      dec edx
      test eax,$00800000
      jnz @Final
      dec edx
      test ah,$80
      jnz @Final
      dec edx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      push edi
      mov edi, edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,edi
      call Move
      pop edi
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;
procedure Filler30;
asm
  nop;
end;

function Trim_DLA_IA32_3_c(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      test al,$80
      jnz @BackStart
      inc ebx
      test ah,$80
      jnz @BackStart
      inc ebx
      test eax,$00800000
      jnz @BackStart
      inc ebx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
// nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
// if nonSpacesFound and $80000000 <> 0 then
      add edx,$03
      test eax,$80000000
      jnz @Final
      dec edx
      test eax,$00800000
      jnz @Final
      dec edx
      test ah,$80
      jnz @Final
      dec edx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      push edi
      mov edi, edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,edi
      call Move
      pop edi
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;
procedure Filler31;
asm
  nop;
end;
function Trim_DLA_IA32_3_d(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      test al,$80
      jnz @BackStart
      inc ebx
      test ah,$80
      jnz @BackStart
      inc ebx
      test eax,$00800000
      jnz @BackStart
      inc ebx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
// nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
// if nonSpacesFound and $80000000 <> 0 then
      add edx,$03
      test eax,$80000000
      jnz @Final
      dec edx
      test eax,$00800000
      jnz @Final
      dec edx
      test ah,$80
      jnz @Final
      dec edx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      push edi
      mov edi, edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,edi
      call Move
      pop edi
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;

function Trim_DLA_IA32_4_a(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      mov edx, ebx
      add edx, eax
//      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      test al,$80
      jnz @BackStart
      inc ebx
      test ah,$80
      jnz @BackStart
      inc ebx
      test eax,$00800000
      jnz @BackStart
      inc ebx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
// nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
// if nonSpacesFound and $80000000 <> 0 then
      add edx,$03
      test eax,$80000000
      jnz @Final
      dec edx
      test eax,$00800000
      jnz @Final
      dec edx
      test ah,$80
      jnz @Final
      dec edx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      push edi
      mov edi, edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,edi
      call Move
      pop edi
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;

function Trim_DLA_IA32_4_b(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      mov edx, ebx
      add edx, eax
//      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      test al,$80
      jnz @BackStart
      inc ebx
      test ah,$80
      jnz @BackStart
      inc ebx
      test eax,$00800000
      jnz @BackStart
      inc ebx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
// nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
// if nonSpacesFound and $80000000 <> 0 then
      add edx,$03
      test eax,$80000000
      jnz @Final
      dec edx
      test eax,$00800000
      jnz @Final
      dec edx
      test ah,$80
      jnz @Final
      dec edx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      push edi
      mov edi, edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,edi
      call Move
      pop edi
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;

function Trim_DLA_IA32_4_c(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      mov edx, ebx
      add edx, eax
//      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      test al,$80
      jnz @BackStart
      inc ebx
      test ah,$80
      jnz @BackStart
      inc ebx
      test eax,$00800000
      jnz @BackStart
      inc ebx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
// nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
// if nonSpacesFound and $80000000 <> 0 then
      add edx,$03
      test eax,$80000000
      jnz @Final
      dec edx
      test eax,$00800000
      jnz @Final
      dec edx
      test ah,$80
      jnz @Final
      dec edx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      push edi
      mov edi, edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,edi
      call Move
      pop edi
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;

function Trim_DLA_IA32_4_d(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      mov edx, ebx
      add edx, eax
//      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      test al,$80
      jnz @BackStart
      inc ebx
      test ah,$80
      jnz @BackStart
      inc ebx
      test eax,$00800000
      jnz @BackStart
      inc ebx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
// nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
// if nonSpacesFound and $80000000 <> 0 then
      add edx,$03
      test eax,$80000000
      jnz @Final
      dec edx
      test eax,$00800000
      jnz @Final
      dec edx
      test ah,$80
      jnz @Final
      dec edx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      push edi
      mov edi, edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,edi
      call Move
      pop edi
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;

function Trim_DLA_IA32_5_a(const AString: string): string;
asm
    push ebx
    push esi
    push edi
    mov edi, edx
    { eax = AString }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { pFront }
    mov esi, [ebx - 4]  { sLen }
    test esi,esi        { sLen = 0 ? }
    jz @NoResult
    add eax,esi         { pBack = pFront + sLen }
    cmp esi,$04         { Small string? }
    jl @CheckLastWordFront
@FrontLoop:
 //if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
    mov edx,[ebx]      { LongWord of pFront }
    mov ecx, edx       { Copy for the calc }
    add ecx,$5f5f5f5f
    or ecx,edx
    test ecx,$80808080
    jnz @CheckLastWordFront
    add ebx,$04
    cmp ebx,eax        { Not past the end? }
    jnb @NoResult
    jmp @FrontLoop
@CheckLastWordFront:
    cmp byte ptr [ebx],$20 { check first char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check second char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check third char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check fourth char }
    jnbe @BackLoop
    jmp @NoResult
@BackLoop:
    sub eax,$04
    cmp esi,$04
    jl @CheckLastWordBack
@BackRealLoop:
 //if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
    mov edx,[eax]
    mov ecx,edx
    add ecx,$5f5f5f5f
    or ecx,edx
    test ecx,$80808080
    jnz @CheckLastWordBack
    sub eax,$04
    jmp @BackRealLoop
@CheckLastWordBack:
    add eax, $03
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
@FinalPart:
 //sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
    mov edx, eax
    sub edx, ebx
    inc edx
    mov esi, edx
    mov eax, edi
    call System.@LStrSetLength
 //Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
    mov edx,[edi]
    mov eax,ebx
    mov ecx,esi
    call Move
    jmp @Exit
@NoResult:
    mov eax,edi
    call System.@LStrClr
@Exit:
    pop edi
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_5_b(const AString: string): string;
asm
    push ebx
    push esi
    push edi
    mov edi, edx
    { eax = AString }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { pFront }
    mov esi, [ebx - 4]  { sLen }
    test esi,esi        { sLen = 0 ? }
    jz @NoResult
    add eax,esi         { pBack = pFront + sLen }
    cmp esi,$04         { Small string? }
    jl @CheckLastWordFront
@FrontLoop:
 //if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
    mov edx,[ebx]      { LongWord of pFront }
    mov ecx, edx       { Copy for the calc }
    add ecx,$5f5f5f5f
    or ecx,edx
    test ecx,$80808080
    jnz @CheckLastWordFront
    add ebx,$04
    cmp ebx,eax        { Not past the end? }
    jnb @NoResult
    jmp @FrontLoop
@CheckLastWordFront:
    cmp byte ptr [ebx],$20 { check first char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check second char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check third char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check fourth char }
    jnbe @BackLoop
    jmp @NoResult
@BackLoop:
    sub eax,$04
    cmp esi,$04
    jl @CheckLastWordBack
@BackRealLoop:
 //if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
    mov edx,[eax]
    mov ecx,edx
    add ecx,$5f5f5f5f
    or ecx,edx
    test ecx,$80808080
    jnz @CheckLastWordBack
    sub eax,$04
    jmp @BackRealLoop
@CheckLastWordBack:
    add eax, $03
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
@FinalPart:
 //sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
    mov edx, eax
    sub edx, ebx
    inc edx
    mov esi, edx
    mov eax, edi
    call System.@LStrSetLength
 //Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
    mov edx,[edi]
    mov eax,ebx
    mov ecx,esi
    call Move
    jmp @Exit
@NoResult:
    mov eax,edi
    call System.@LStrClr
@Exit:
    pop edi
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_5_c(const AString: string): string;
asm
    push ebx
    push esi
    push edi
    mov edi, edx
    { eax = AString }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { pFront }
    mov esi, [ebx - 4]  { sLen }
    test esi,esi        { sLen = 0 ? }
    jz @NoResult
    add eax,esi         { pBack = pFront + sLen }
    cmp esi,$04         { Small string? }
    jl @CheckLastWordFront
@FrontLoop:
 //if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
    mov edx,[ebx]      { LongWord of pFront }
    mov ecx, edx       { Copy for the calc }
    add ecx,$5f5f5f5f
    or ecx,edx
    test ecx,$80808080
    jnz @CheckLastWordFront
    add ebx,$04
    cmp ebx,eax        { Not past the end? }
    jnb @NoResult
    jmp @FrontLoop
@CheckLastWordFront:
    cmp byte ptr [ebx],$20 { check first char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check second char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check third char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check fourth char }
    jnbe @BackLoop
    jmp @NoResult
@BackLoop:
    sub eax,$04
    cmp esi,$04
    jl @CheckLastWordBack
@BackRealLoop:
 //if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
    mov edx,[eax]
    mov ecx,edx
    add ecx,$5f5f5f5f
    or ecx,edx
    test ecx,$80808080
    jnz @CheckLastWordBack
    sub eax,$04
    jmp @BackRealLoop
@CheckLastWordBack:
    add eax, $03
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
@FinalPart:
 //sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
    mov edx, eax
    sub edx, ebx
    inc edx
    mov esi, edx
    mov eax, edi
    call System.@LStrSetLength
 //Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
    mov edx,[edi]
    mov eax,ebx
    mov ecx,esi
    call Move
    jmp @Exit
@NoResult:
    mov eax,edi
    call System.@LStrClr
@Exit:
    pop edi
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_5_d(const AString: string): string;
asm
    push ebx
    push esi
    push edi
    mov edi, edx
    { eax = AString }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { pFront }
    mov esi, [ebx - 4]  { sLen }
    test esi,esi        { sLen = 0 ? }
    jz @NoResult
    add eax,esi         { pBack = pFront + sLen }
    cmp esi,$04         { Small string? }
    jl @CheckLastWordFront
@FrontLoop:
 //if (((PLongWord(pFront)^ + $5F5F5F5F) or PLongWord(pFront)^) and $80808080) <> 0 then
    mov edx,[ebx]      { LongWord of pFront }
    mov ecx, edx       { Copy for the calc }
    add ecx,$5f5f5f5f
    or ecx,edx
    test ecx,$80808080
    jnz @CheckLastWordFront
    add ebx,$04
    cmp ebx,eax        { Not past the end? }
    jnb @NoResult
    jmp @FrontLoop
@CheckLastWordFront:
    cmp byte ptr [ebx],$20 { check first char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check second char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check third char }
    jnbe @BackLoop
    inc ebx
    cmp byte ptr [ebx],$20 { check fourth char }
    jnbe @BackLoop
    jmp @NoResult
@BackLoop:
    sub eax,$04
    cmp esi,$04
    jl @CheckLastWordBack
@BackRealLoop:
 //if (((PLongWord(pBack)^ + $5F5F5F5F) or PLongWord(pBack)^) and $80808080) <> 0 then
    mov edx,[eax]
    mov ecx,edx
    add ecx,$5f5f5f5f
    or ecx,edx
    test ecx,$80808080
    jnz @CheckLastWordBack
    sub eax,$04
    jmp @BackRealLoop
@CheckLastWordBack:
    add eax, $03
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
    cmp byte ptr [eax],$20
    jnbe @FinalPart
    dec eax
@FinalPart:
 //sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
    mov edx, eax
    sub edx, ebx
    inc edx
    mov esi, edx
    mov eax, edi
    call System.@LStrSetLength
 //Move(PByteArray(pFront)^[0], PByteArray(Pointer(Result))^[0], sLen);
    mov edx,[edi]
    mov eax,ebx
    mov ecx,esi
    call Move
    jmp @Exit
@NoResult:
    mov eax,edi
    call System.@LStrClr
@Exit:
    pop edi
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_6_a(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx,[ebx + eax] { pBack }
    mov ecx, edx
    mov eax, ebx
    dec ebx
@FrontLoop:
    inc ebx
    cmp ebx, edx
    jnb @NoResult
    cmp byte ptr [ebx],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
    inc edx
    cmp eax, ebx
    jne @CopyResult
    cmp ecx, edx
    jne @CopyResult
    // same string, let's call assign
    mov edx,eax
    mov eax,esi
    call System.@LStrAsg
    jmp @Exit
@CopyResult:
    sub edx, ebx
    mov eax, esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax, ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
procedure Filler32;
asm
  nop;
end;
function Trim_DLA_IA32_6_b(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx,[ebx + eax] { pBack }
    mov ecx, edx
    mov eax, ebx
    dec ebx
@FrontLoop:
    inc ebx
    cmp ebx, edx
    jnb @NoResult
    cmp byte ptr [ebx],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
    inc edx
    cmp eax, ebx
    jne @CopyResult
    cmp ecx, edx
    jne @CopyResult
    // same string, let's call assign
    mov edx,eax
    mov eax,esi
    call System.@LStrAsg
    jmp @Exit
@CopyResult:
    sub edx, ebx
    mov eax, esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax, ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
 procedure Filler33;
asm
  nop;
end;
function Trim_DLA_IA32_6_c(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx,[ebx + eax] { pBack }
    mov ecx, edx
    mov eax, ebx
    dec ebx
@FrontLoop:
    inc ebx
    cmp ebx, edx
    jnb @NoResult
    cmp byte ptr [ebx],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
    inc edx
    cmp eax, ebx
    jne @CopyResult
    cmp ecx, edx
    jne @CopyResult
    // same string, let's call assign
    mov edx,eax
    mov eax,esi
    call System.@LStrAsg
    jmp @Exit
@CopyResult:
    sub edx, ebx
    mov eax, esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax, ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
procedure Filler34;
asm
  nop;
end;
function Trim_DLA_IA32_6_d(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx,[ebx + eax] { pBack }
    mov ecx, edx
    mov eax, ebx
    dec ebx
@FrontLoop:
    inc ebx
    cmp ebx, edx
    jnb @NoResult
    cmp byte ptr [ebx],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
    inc edx
    cmp eax, ebx
    jne @CopyResult
    cmp ecx, edx
    jne @CopyResult
    // same string, let's call assign
    mov edx,eax
    mov eax,esi
    call System.@LStrAsg
    jmp @Exit
@CopyResult:
    sub edx, ebx
    mov eax, esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax, ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_7_a(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx,[ebx + eax] { pBack }
    mov ecx, edx
    mov eax, ebx
    dec eax
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
    inc edx
    cmp eax, ebx
    jne @CopyResult
    cmp ecx, edx
    jne @CopyResult
    // same string, let's call assign
    mov edx,eax
    mov eax,esi
    call System.@LStrAsg
    jmp @Exit
@CopyResult:
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_7_b(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx,[ebx + eax] { pBack }
    mov ecx, edx
    mov eax, ebx
    dec eax
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
    inc edx
    cmp eax, ebx
    jne @CopyResult
    cmp ecx, edx
    jne @CopyResult
    // same string, let's call assign
    mov edx,eax
    mov eax,esi
    call System.@LStrAsg
    jmp @Exit
@CopyResult:
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_7_c(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx,[ebx + eax] { pBack }
    mov ecx, edx
    mov eax, ebx
    dec eax
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
    inc edx
    cmp eax, ebx
    jne @CopyResult
    cmp ecx, edx
    jne @CopyResult
    // same string, let's call assign
    mov edx,eax
    mov eax,esi
    call System.@LStrAsg
    jmp @Exit
@CopyResult:
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_7_d(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx,[ebx + eax] { pBack }
    mov ecx, edx
    mov eax, ebx
    dec eax
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
    inc edx
    cmp eax, ebx
    jne @CopyResult
    cmp ecx, edx
    jne @CopyResult
    // same string, let's call assign
    mov edx,eax
    mov eax,esi
    call System.@LStrAsg
    jmp @Exit
@CopyResult:
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_8_a(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx,[ebx + eax] { pBack }
    mov ecx, edx
    mov eax, ebx
    dec eax
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
    inc edx
@CopyResult:
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
procedure Filler35;
asm
  nop;
end;
function Trim_DLA_IA32_8_b(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx,[ebx + eax] { pBack }
    mov ecx, edx
    mov eax, ebx
    dec eax
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
    inc edx
@CopyResult:
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
procedure Filler36;
asm
  nop;
end;
function Trim_DLA_IA32_8_c(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx,[ebx + eax] { pBack }
    mov ecx, edx
    mov eax, ebx
    dec eax
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
    inc edx
@CopyResult:
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
procedure Filler37;
asm
  nop;
end;
function Trim_DLA_IA32_8_d(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx,[ebx + eax] { pBack }
    mov ecx, edx
    mov eax, ebx
    dec eax
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
    inc edx
@CopyResult:
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_9_a(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
procedure Filler38;
asm
  nop;
end;
function Trim_DLA_IA32_9_b(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
procedure Filler39;
asm
  nop;
end;
function Trim_DLA_IA32_9_c(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
procedure Filler40;
asm
  nop;
end;
function Trim_DLA_IA32_9_d(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_10_a(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoopStart
    inc eax
    cmp byte ptr [eax],$20
    jnbe @BackLoopStart
    inc eax
    cmp byte ptr [eax],$20
    jnbe @BackLoopStart
    inc eax
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoopStart:
    cmp eax, edx
    jnb @NoResult
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_10_b(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoopStart
    inc eax
    cmp byte ptr [eax],$20
    jnbe @BackLoopStart
    inc eax
    cmp byte ptr [eax],$20
    jnbe @BackLoopStart
    inc eax
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoopStart:
    cmp eax, edx
    jnb @NoResult
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
procedure Filler41;
asm
  nop;
end;
function Trim_DLA_IA32_10_c(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoopStart
    inc eax
    cmp byte ptr [eax],$20
    jnbe @BackLoopStart
    inc eax
    cmp byte ptr [eax],$20
    jnbe @BackLoopStart
    inc eax
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoopStart:
    cmp eax, edx
    jnb @NoResult
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_10_d(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoopStart
    inc eax
    cmp byte ptr [eax],$20
    jnbe @BackLoopStart
    inc eax
    cmp byte ptr [eax],$20
    jnbe @BackLoopStart
    inc eax
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoopStart:
    cmp eax, edx
    jnb @NoResult
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_11_a(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      mov ecx, 0
      bsf ecx,eax 
      shr ecx, 3
      add ebx, ecx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
// nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
      mov ecx, 0
      bsr ecx,eax 
      shr ecx, 3
      add edx, ecx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,[edx - 4]
      call Move
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;


function Trim_DLA_IA32_11_b(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      mov ecx, 0
      bsf ecx,eax 
      shr ecx, 3
      add ebx, ecx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
// nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
      mov ecx, 0
      bsr ecx,eax 
      shr ecx, 3
      add edx, ecx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,[edx - 4]
      call Move
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;

procedure Filler42;
asm
  nop;
end;
function Trim_DLA_IA32_11_c(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      mov ecx, 0
      bsf ecx,eax 
      shr ecx, 3
      add ebx, ecx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
// nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
      mov ecx, 0
      bsr ecx,eax 
      shr ecx, 3
      add edx, ecx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,[edx - 4]
      call Move
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;


function Trim_DLA_IA32_11_d(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      mov ecx, 0
      bsf ecx,eax 
      shr ecx, 3
      add ebx, ecx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
// nonSpacesFound := ((((PLongWord(pBack)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pBack)^) and $80808080);
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
      mov ecx, 0
      bsr ecx,eax 
      shr ecx, 3
      add edx, ecx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,[edx - 4]
      call Move
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;


function Trim_DLA_IA32_12_a(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      mov ecx, 0
      bsf ecx,eax
      shr ecx, 3
      add ebx, ecx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @BackFound
      sub edx,$04
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
      mov ecx, 0
      bsr ecx,eax
      shr ecx, 3
      add edx, ecx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,[edx - 4]
      call Move
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;

function Trim_DLA_IA32_12_b(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      mov ecx, 0
      bsf ecx,eax
      shr ecx, 3
      add ebx, ecx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @BackFound
      sub edx,$04
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
      mov ecx, 0
      bsr ecx,eax
      shr ecx, 3
      add edx, ecx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,[edx - 4]
      call Move
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;
procedure Filler44;
asm
  nop;
end;
function Trim_DLA_IA32_12_c(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      mov ecx, 0
      bsf ecx,eax
      shr ecx, 3
      add ebx, ecx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @BackFound
      sub edx,$04
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
      mov ecx, 0
      bsr ecx,eax
      shr ecx, 3
      add edx, ecx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,[edx - 4]
      call Move
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;

function Trim_DLA_IA32_12_d(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
//      add edx,eax
@RealFrontLoop:
// nonSpacesFound := ((((PLongWord(pFront)^ and $7F7F7F7F) + $5F5F5F5F) or PLongWord(pFront)^) and $80808080);
      mov ecx,[ebx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @FrontFound
      add ebx,$04
      cmp ebx,edx
      jnb @NoResult
      jmp @RealFrontLoop
@FrontFound:
      mov ecx, 0
      bsf ecx,eax
      shr ecx, 3
      add ebx, ecx
@BackStart:
// if Cardinal(pFront) >= Cardinal(pBack) then
      cmp ebx,edx
      jnb @NoResult
// Dec(pBack, SizeOf(LongWord));
@RealBackLoop:
      sub edx,$04
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jnz @BackFound
      sub edx,$04
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
      mov ecx, 0
      bsr ecx,eax
      shr ecx, 3
      add edx, ecx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,[edx - 4]
      call Move
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;

function Trim_DLA_IA32_13_a(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
      dec ebx
@FrontLoop:
      inc ebx
      cmp ebx, edx
      jnb @NoResult
      cmp byte ptr [ebx],$20
      jnbe @BackStart
      inc ebx
      cmp byte ptr [ebx],$20
      jnbe @BackStart
      inc ebx
      cmp byte ptr [ebx],$20
      jnbe @BackStart
      inc ebx
      cmp byte ptr [ebx],$20
      jbe @FrontLoop
@BackStart:
      cmp ebx,edx
      jnb @NoResult
@RealBackLoop:
      sub edx,$04
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
      mov ecx, 0
      bsr ecx,eax 
      shr ecx, 3
      add edx, ecx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,[edx - 4]
      call Move
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;

function Trim_DLA_IA32_13_b(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
      dec ebx
@FrontLoop:
      inc ebx
      cmp ebx, edx
      jnb @NoResult
      cmp byte ptr [ebx],$20
      jnbe @BackStart
      inc ebx
      cmp byte ptr [ebx],$20
      jnbe @BackStart
      inc ebx
      cmp byte ptr [ebx],$20
      jnbe @BackStart
      inc ebx
      cmp byte ptr [ebx],$20
      jbe @FrontLoop
@BackStart:
      cmp ebx,edx
      jnb @NoResult
@RealBackLoop:
      sub edx,$04
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
      mov ecx, 0
      bsr ecx,eax 
      shr ecx, 3
      add edx, ecx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,[edx - 4]
      call Move
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;

function Trim_DLA_IA32_13_c(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
      dec ebx
@FrontLoop:
      inc ebx
      cmp ebx, edx
      jnb @NoResult
      cmp byte ptr [ebx],$20
      jnbe @BackStart
      inc ebx
      cmp byte ptr [ebx],$20
      jnbe @BackStart
      inc ebx
      cmp byte ptr [ebx],$20
      jnbe @BackStart
      inc ebx
      cmp byte ptr [ebx],$20
      jbe @FrontLoop
@BackStart:
      cmp ebx,edx
      jnb @NoResult
@RealBackLoop:
      sub edx,$04
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
      mov ecx, 0
      bsr ecx,eax 
      shr ecx, 3
      add edx, ecx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,[edx - 4]
      call Move
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;

function Trim_DLA_IA32_13_d(const AString: string): string;
asm
      push ebx
      push esi
      mov esi,edx         { Result }
      test eax, eax       { Nil pointer? }
      jz @NoResult
      mov ebx, eax        { pFront }
      mov eax, [ebx - 4]  { sLen }
      test eax,eax        { sLen = 0 ? }
      jz @NoResult
      lea edx,[ebx + eax]         { pBack }
      dec ebx
@FrontLoop:
      inc ebx
      cmp ebx, edx
      jnb @NoResult
      cmp byte ptr [ebx],$20
      jnbe @BackStart
      inc ebx
      cmp byte ptr [ebx],$20
      jnbe @BackStart
      inc ebx
      cmp byte ptr [ebx],$20
      jnbe @BackStart
      inc ebx
      cmp byte ptr [ebx],$20
      jbe @FrontLoop
@BackStart:
      cmp ebx,edx
      jnb @NoResult
@RealBackLoop:
      sub edx,$04
      mov ecx,[edx]
      mov eax,ecx
      and eax,$7f7f7f7f
      add eax,$5f5f5f5f
      or eax,ecx
      and eax,$80808080
      test eax,eax
      jz @RealBackLoop
@BackFound:
      mov ecx, 0
      bsr ecx,eax 
      shr ecx, 3
      add edx, ecx
@Final:
// sLen := Cardinal(pBack) - Cardinal(pFront) + 1;
      sub edx,ebx
      inc edx
      mov eax,esi
      call System.@LStrSetLength
      mov edx,[esi]
      mov eax,ebx
      mov ecx,[edx - 4]
      call Move
      jmp @Exit
@NoResult:
      mov eax,esi
      call System.@LStrClr
@Exit:
      pop esi
      pop ebx
      ret
end;

function Trim_DLA_IA32_14_a(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @BackLoop
@BackFound:
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
procedure Filler45;
asm
  nop;
end;
function Trim_DLA_IA32_14_b(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @BackLoop
@BackFound:
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
procedure Filler46;
asm
  nop;
end;
function Trim_DLA_IA32_14_c(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @BackLoop
@BackFound:
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
procedure Filler47;
asm
  nop;
end;
function Trim_DLA_IA32_14_d(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @BackLoop
@BackFound:
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_15_a(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @BackLoop
@BackFound:
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_15_b(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @BackLoop
@BackFound:
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_15_c(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @BackLoop
@BackFound:
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_15_d(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @BackLoop
@BackFound:
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_16_a(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @BackFound
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @BackFound
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @BackFound
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @BackLoop
@BackFound:
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;


function Trim_DLA_IA32_16_b(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @BackFound
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @BackFound
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @BackFound
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @BackLoop
@BackFound:
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
procedure Filler48;
asm
  nop;
end;

function Trim_DLA_IA32_16_c(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @BackFound
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @BackFound
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @BackFound
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @BackLoop
@BackFound:
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;


function Trim_DLA_IA32_16_d(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @BackFound
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @BackFound
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @BackFound
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @BackLoop
@BackFound:
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;


function Trim_DLA_IA32_17_a(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult        
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_17_b(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult        
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
procedure Filler49;
asm
  nop;
end;
function Trim_DLA_IA32_17_c(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult        
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_17_d(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
    lea eax, [ebx - 1]
@FrontLoop:
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jbe @FrontLoop
    // found
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult        
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jbe @BackLoop
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_18_a(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    mov eax, ebx
@SmallFrontLoop:
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
@LargeFrontLoop:
    mov ecx,[eax]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @FrontFound
    add eax,$04
    cmp eax,edx
    jnb @NoResult
    jmp @LargeFrontLoop
@FrontFound:
    mov ecx, 0
    bsf ecx,ebx
    shr ecx, 3
    add eax, ecx
    cmp eax,edx
    jnb @NoResult
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
@LargeBackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @LargeBackLoop
@BackFound:
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_18_b(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    mov eax, ebx
@SmallFrontLoop:
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
@LargeFrontLoop:
    mov ecx,[eax]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @FrontFound
    add eax,$04
    cmp eax,edx
    jnb @NoResult
    jmp @LargeFrontLoop
@FrontFound:
    mov ecx, 0
    bsf ecx,ebx
    shr ecx, 3
    add eax, ecx
    cmp eax,edx
    jnb @NoResult
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
@LargeBackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @LargeBackLoop
@BackFound:
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_18_c(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    mov eax, ebx
@SmallFrontLoop:
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
@LargeFrontLoop:
    mov ecx,[eax]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @FrontFound
    add eax,$04
    cmp eax,edx
    jnb @NoResult
    jmp @LargeFrontLoop
@FrontFound:
    mov ecx, 0
    bsf ecx,ebx
    shr ecx, 3
    add eax, ecx
    cmp eax,edx
    jnb @NoResult
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
@LargeBackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @LargeBackLoop
@BackFound:
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_18_d(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    mov eax, ebx
@SmallFrontLoop:
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
@LargeFrontLoop:
    mov ecx,[eax]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @FrontFound
    add eax,$04
    cmp eax,edx
    jnb @NoResult
    jmp @LargeFrontLoop
@FrontFound:
    mov ecx, 0
    bsf ecx,ebx
    shr ecx, 3
    add eax, ecx
    cmp eax,edx
    jnb @NoResult
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
@LargeBackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @LargeBackLoop
@BackFound:
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;

function Trim_DLA_IA32_19_a(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    mov eax, ebx
@SmallFrontLoop:
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
@LargeFrontLoop:
    mov ecx,[eax]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @FrontFound
    add eax,$04
    cmp eax,edx
    jnb @NoResult
    jmp @LargeFrontLoop
@FrontFound:
    mov ecx, 0
    bsf ecx,ebx
    shr ecx, 3
    add eax, ecx
    cmp eax,edx
    jnb @NoResult
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
@LargeBackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @BackFound
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @LargeBackLoop
@BackFound:
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
function Trim_DLA_IA32_19_b(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    mov eax, ebx
@SmallFrontLoop:
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
@LargeFrontLoop:
    mov ecx,[eax]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @FrontFound
    add eax,$04
    cmp eax,edx
    jnb @NoResult
    jmp @LargeFrontLoop
@FrontFound:
    mov ecx, 0
    bsf ecx,ebx
    shr ecx, 3
    add eax, ecx
    cmp eax,edx
    jnb @NoResult
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
@LargeBackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @BackFound
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @LargeBackLoop
@BackFound:
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
procedure Filler50;
asm
  nop;
end;
function Trim_DLA_IA32_19_c(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    mov eax, ebx
@SmallFrontLoop:
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
@LargeFrontLoop:
    mov ecx,[eax]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @FrontFound
    add eax,$04
    cmp eax,edx
    jnb @NoResult
    jmp @LargeFrontLoop
@FrontFound:
    mov ecx, 0
    bsf ecx,ebx
    shr ecx, 3
    add eax, ecx
    cmp eax,edx
    jnb @NoResult
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
@LargeBackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @BackFound
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @LargeBackLoop
@BackFound:
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
function Trim_DLA_IA32_19_d(const AString: string): string;
asm
    push ebx
    push esi
    mov esi,edx         { Result }
    test eax, eax       { Nil pointer? }
    jz @NoResult
    mov ebx, eax        { p }
    mov eax, [ebx - 4]  { sLen }
    test eax,eax        { sLen = 0 ? }
    jz @NoResult
    lea edx, [ebx + eax] { pBack }
//    mov ecx, edx
    mov eax, ebx
@SmallFrontLoop:
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
    inc eax
    cmp eax, edx
    jnb @NoResult
    cmp byte ptr [eax],$20
    jnbe @BackLoop
@LargeFrontLoop:
    mov ecx,[eax]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @FrontFound
    add eax,$04
    cmp eax,edx
    jnb @NoResult
    jmp @LargeFrontLoop
@FrontFound:
    mov ecx, 0
    bsf ecx,ebx
    shr ecx, 3
    add eax, ecx
    cmp eax,edx
    jnb @NoResult
@BackLoop:
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
    dec edx
    cmp byte ptr [edx],$20
    jnbe @CopyResult
@LargeBackLoop:
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jnz @BackFound
    sub edx,$04
    mov ecx,[edx]
    mov ebx,ecx
    and ebx,$7f7f7f7f
    add ebx,$5f5f5f5f
    or ebx,ecx
    and ebx,$80808080
    test ebx,ebx
    jz @LargeBackLoop
@BackFound:
    mov ecx, 0
    bsr ecx,ebx
    shr ecx, 3
    add edx, ecx
//    dec edx
@CopyResult:
    inc edx
    mov ebx, eax
    sub edx, ebx
    mov eax,esi
    call System.@LStrSetLength
    mov edx,[esi]
    mov eax,ebx
    mov ecx,[edx - 4]
    call Move
    jmp @Exit
@NoResult:
    mov eax,esi
    call System.@LStrClr
@Exit:
    pop esi
    pop ebx
    ret
end;
{$ifdef SaveB}
  {$B+}
{$endif}
{$ifdef SaveQ}
  {$Q+}
{$endif}    

initialization
Filler1;
Filler2;
Filler3;
Filler4;
Filler5;
Filler6;
Filler7;
Filler8;
Filler9;
Filler10;
Filler11;
Filler12;
Filler13;
Filler14;
Filler15;
Filler16;
Filler17;
Filler18;
Filler19;
Filler20;
Filler21;
Filler22;
Filler23;
Filler24;
Filler25;
Filler26;
Filler27;
Filler28;
Filler29;
Filler30;
Filler31;
Filler32;
Filler33;
Filler34;
Filler35;
Filler36;
Filler37;
Filler38;
Filler39;
Filler40;
Filler41;
Filler42;
Filler43;
Filler44;
Filler45;
Filler46;
Filler47;
Filler48;
Filler49;
Filler50;
Filler51;
Filler52;
Filler53;
Filler54;
Filler55;
Filler56;
//MainForm.RegisterFunction('Trim_DLA_Pas_1_a', @Trim_DLA_PAS_1_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_1_b', @Trim_DLA_PAS_1_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_1_c', @Trim_DLA_PAS_1_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_1_d', @Trim_DLA_PAS_1_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_2_a', @Trim_DLA_PAS_2_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_2_b', @Trim_DLA_PAS_2_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_2_c', @Trim_DLA_PAS_2_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_2_d', @Trim_DLA_PAS_2_d);
MainForm.RegisterFunction('Trim_DLA_Pas_3_a', @Trim_DLA_PAS_3_a);
MainForm.RegisterFunction('Trim_DLA_Pas_3_b', @Trim_DLA_PAS_3_b);
MainForm.RegisterFunction('Trim_DLA_Pas_3_c', @Trim_DLA_PAS_3_c);
MainForm.RegisterFunction('Trim_DLA_Pas_3_d', @Trim_DLA_PAS_3_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_4_a', @Trim_DLA_PAS_4_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_4_b', @Trim_DLA_PAS_4_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_4_c', @Trim_DLA_PAS_4_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_4_d', @Trim_DLA_PAS_4_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_5_a', @Trim_DLA_PAS_5_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_5_b', @Trim_DLA_PAS_5_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_5_c', @Trim_DLA_PAS_5_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_5_d', @Trim_DLA_PAS_5_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_6_a', @Trim_DLA_PAS_6_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_6_b', @Trim_DLA_PAS_6_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_6_c', @Trim_DLA_PAS_6_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_6_d', @Trim_DLA_PAS_6_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_7_a', @Trim_DLA_PAS_7_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_7_b', @Trim_DLA_PAS_7_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_7_c', @Trim_DLA_PAS_7_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_7_d', @Trim_DLA_PAS_7_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_8_a', @Trim_DLA_PAS_8_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_8_b', @Trim_DLA_PAS_8_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_8_c', @Trim_DLA_PAS_8_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_8_d', @Trim_DLA_PAS_8_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_9_a', @Trim_DLA_PAS_9_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_9_b', @Trim_DLA_PAS_9_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_9_c', @Trim_DLA_PAS_9_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_9_d', @Trim_DLA_PAS_9_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_10_a', @Trim_DLA_PAS_10_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_10_b', @Trim_DLA_PAS_10_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_10_c', @Trim_DLA_PAS_10_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_10_d', @Trim_DLA_PAS_10_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_11_a', @Trim_DLA_PAS_11_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_11_b', @Trim_DLA_PAS_11_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_11_c', @Trim_DLA_PAS_11_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_11_d', @Trim_DLA_PAS_11_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_12_a', @Trim_DLA_PAS_12_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_12_b', @Trim_DLA_PAS_12_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_12_c', @Trim_DLA_PAS_12_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_12_d', @Trim_DLA_PAS_12_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_13_a', @Trim_DLA_PAS_13_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_13_b', @Trim_DLA_PAS_13_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_13_c', @Trim_DLA_PAS_13_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_13_d', @Trim_DLA_PAS_13_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_14_a', @Trim_DLA_PAS_14_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_14_b', @Trim_DLA_PAS_14_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_14_c', @Trim_DLA_PAS_14_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_14_d', @Trim_DLA_PAS_14_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_15_a', @Trim_DLA_PAS_15_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_15_b', @Trim_DLA_PAS_15_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_15_c', @Trim_DLA_PAS_15_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_15_d', @Trim_DLA_PAS_15_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_16_a', @Trim_DLA_PAS_16_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_16_b', @Trim_DLA_PAS_16_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_16_c', @Trim_DLA_PAS_16_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_16_d', @Trim_DLA_PAS_16_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_17_a', @Trim_DLA_PAS_17_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_17_b', @Trim_DLA_PAS_17_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_17_c', @Trim_DLA_PAS_17_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_17_d', @Trim_DLA_PAS_17_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_18_a', @Trim_DLA_PAS_18_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_18_b', @Trim_DLA_PAS_18_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_18_c', @Trim_DLA_PAS_18_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_18_d', @Trim_DLA_PAS_18_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_19_a', @Trim_DLA_PAS_19_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_19_b', @Trim_DLA_PAS_19_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_19_c', @Trim_DLA_PAS_19_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_19_d', @Trim_DLA_PAS_19_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_20_a', @Trim_DLA_PAS_20_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_20_b', @Trim_DLA_PAS_20_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_20_c', @Trim_DLA_PAS_20_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_20_d', @Trim_DLA_PAS_20_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_21_a', @Trim_DLA_PAS_21_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_21_b', @Trim_DLA_PAS_21_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_21_c', @Trim_DLA_PAS_21_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_21_d', @Trim_DLA_PAS_21_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_22_a', @Trim_DLA_PAS_22_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_22_b', @Trim_DLA_PAS_22_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_22_c', @Trim_DLA_PAS_22_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_22_d', @Trim_DLA_PAS_22_d);
//MainForm.RegisterFunction('Trim_DLA_Pas_23_a', @Trim_DLA_PAS_23_a);
//MainForm.RegisterFunction('Trim_DLA_Pas_23_b', @Trim_DLA_PAS_23_b);
//MainForm.RegisterFunction('Trim_DLA_Pas_23_c', @Trim_DLA_PAS_23_c);
//MainForm.RegisterFunction('Trim_DLA_Pas_23_d', @Trim_DLA_PAS_23_d);
MainForm.RegisterFunction('Trim_DLA_Pas_24_a', @Trim_DLA_PAS_24_a);
MainForm.RegisterFunction('Trim_DLA_Pas_24_b', @Trim_DLA_PAS_24_b);
MainForm.RegisterFunction('Trim_DLA_Pas_24_c', @Trim_DLA_PAS_24_c);
MainForm.RegisterFunction('Trim_DLA_Pas_24_d', @Trim_DLA_PAS_24_d);
MainForm.RegisterFunction('Trim_DLA_Pas_25_a', @Trim_DLA_PAS_25_a);
MainForm.RegisterFunction('Trim_DLA_Pas_25_b', @Trim_DLA_PAS_25_b);
MainForm.RegisterFunction('Trim_DLA_Pas_25_c', @Trim_DLA_PAS_25_c);
MainForm.RegisterFunction('Trim_DLA_Pas_25_d', @Trim_DLA_PAS_25_d);
//MainForm.RegisterFunction('Trim_DLA_IA32_1_a', @Trim_DLA_IA32_1_a);
//MainForm.RegisterFunction('Trim_DLA_IA32_1_b', @Trim_DLA_IA32_1_b);
//MainForm.RegisterFunction('Trim_DLA_IA32_1_c', @Trim_DLA_IA32_1_c);
//MainForm.RegisterFunction('Trim_DLA_IA32_1_d', @Trim_DLA_IA32_1_d);
//MainForm.RegisterFunction('Trim_DLA_IA32_2_a', @Trim_DLA_IA32_2_a);
//MainForm.RegisterFunction('Trim_DLA_IA32_2_b', @Trim_DLA_IA32_2_b);
//MainForm.RegisterFunction('Trim_DLA_IA32_2_c', @Trim_DLA_IA32_2_c);
//MainForm.RegisterFunction('Trim_DLA_IA32_2_d', @Trim_DLA_IA32_2_d);
//MainForm.RegisterFunction('Trim_DLA_IA32_3_a', @Trim_DLA_IA32_3_a);
//MainForm.RegisterFunction('Trim_DLA_IA32_3_b', @Trim_DLA_IA32_3_b);
//MainForm.RegisterFunction('Trim_DLA_IA32_3_c', @Trim_DLA_IA32_3_c);
//MainForm.RegisterFunction('Trim_DLA_IA32_3_d', @Trim_DLA_IA32_3_d);
//MainForm.RegisterFunction('Trim_DLA_IA32_4_a', @Trim_DLA_IA32_4_a);
//MainForm.RegisterFunction('Trim_DLA_IA32_4_b', @Trim_DLA_IA32_4_b);
//MainForm.RegisterFunction('Trim_DLA_IA32_4_c', @Trim_DLA_IA32_4_c);
//MainForm.RegisterFunction('Trim_DLA_IA32_4_d', @Trim_DLA_IA32_4_d);
//MainForm.RegisterFunction('Trim_DLA_IA32_5_a', @Trim_DLA_IA32_5_a);
//MainForm.RegisterFunction('Trim_DLA_IA32_5_b', @Trim_DLA_IA32_5_b);
//MainForm.RegisterFunction('Trim_DLA_IA32_5_c', @Trim_DLA_IA32_5_c);
//MainForm.RegisterFunction('Trim_DLA_IA32_5_d', @Trim_DLA_IA32_5_d);
MainForm.RegisterFunction('Trim_DLA_IA32_6_a', @Trim_DLA_IA32_6_a);
MainForm.RegisterFunction('Trim_DLA_IA32_6_b', @Trim_DLA_IA32_6_b);
MainForm.RegisterFunction('Trim_DLA_IA32_6_c', @Trim_DLA_IA32_6_c);
MainForm.RegisterFunction('Trim_DLA_IA32_6_d', @Trim_DLA_IA32_6_d);
MainForm.RegisterFunction('Trim_DLA_IA32_7_a', @Trim_DLA_IA32_7_a);
MainForm.RegisterFunction('Trim_DLA_IA32_7_b', @Trim_DLA_IA32_7_b);
MainForm.RegisterFunction('Trim_DLA_IA32_7_c', @Trim_DLA_IA32_7_c);
MainForm.RegisterFunction('Trim_DLA_IA32_7_d', @Trim_DLA_IA32_7_d);
MainForm.RegisterFunction('Trim_DLA_IA32_8_a', @Trim_DLA_IA32_8_a);
MainForm.RegisterFunction('Trim_DLA_IA32_8_b', @Trim_DLA_IA32_8_b);
MainForm.RegisterFunction('Trim_DLA_IA32_8_c', @Trim_DLA_IA32_8_c);
MainForm.RegisterFunction('Trim_DLA_IA32_8_d', @Trim_DLA_IA32_8_d);
MainForm.RegisterFunction('Trim_DLA_IA32_9_a', @Trim_DLA_IA32_9_a);
MainForm.RegisterFunction('Trim_DLA_IA32_9_b', @Trim_DLA_IA32_9_b);
MainForm.RegisterFunction('Trim_DLA_IA32_9_c', @Trim_DLA_IA32_9_c);
MainForm.RegisterFunction('Trim_DLA_IA32_9_d', @Trim_DLA_IA32_9_d);
//MainForm.RegisterFunction('Trim_DLA_IA32_10_a', @Trim_DLA_IA32_10_a);
//MainForm.RegisterFunction('Trim_DLA_IA32_10_b', @Trim_DLA_IA32_10_b);
//MainForm.RegisterFunction('Trim_DLA_IA32_10_c', @Trim_DLA_IA32_10_c);
//MainForm.RegisterFunction('Trim_DLA_IA32_10_d', @Trim_DLA_IA32_10_d);
//MainForm.RegisterFunction('Trim_DLA_IA32_11_a', @Trim_DLA_IA32_11_a);
//MainForm.RegisterFunction('Trim_DLA_IA32_11_b', @Trim_DLA_IA32_11_b);
//MainForm.RegisterFunction('Trim_DLA_IA32_11_c', @Trim_DLA_IA32_11_c);
//MainForm.RegisterFunction('Trim_DLA_IA32_11_d', @Trim_DLA_IA32_11_d);
//MainForm.RegisterFunction('Trim_DLA_IA32_12_a', @Trim_DLA_IA32_12_a);
//MainForm.RegisterFunction('Trim_DLA_IA32_12_b', @Trim_DLA_IA32_12_b);
//MainForm.RegisterFunction('Trim_DLA_IA32_12_c', @Trim_DLA_IA32_12_c);
//MainForm.RegisterFunction('Trim_DLA_IA32_12_d', @Trim_DLA_IA32_12_d);
//MainForm.RegisterFunction('Trim_DLA_IA32_13_a', @Trim_DLA_IA32_13_a);
//MainForm.RegisterFunction('Trim_DLA_IA32_13_b', @Trim_DLA_IA32_13_b);
//MainForm.RegisterFunction('Trim_DLA_IA32_13_c', @Trim_DLA_IA32_13_c);
//MainForm.RegisterFunction('Trim_DLA_IA32_13_d', @Trim_DLA_IA32_13_d);
//MainForm.RegisterFunction('Trim_DLA_IA32_14_a', @Trim_DLA_IA32_14_a);
//MainForm.RegisterFunction('Trim_DLA_IA32_14_b', @Trim_DLA_IA32_14_b);
//MainForm.RegisterFunction('Trim_DLA_IA32_14_c', @Trim_DLA_IA32_14_c);
//MainForm.RegisterFunction('Trim_DLA_IA32_14_d', @Trim_DLA_IA32_14_d);
//MainForm.RegisterFunction('Trim_DLA_IA32_15_a', @Trim_DLA_IA32_15_a);
//MainForm.RegisterFunction('Trim_DLA_IA32_15_b', @Trim_DLA_IA32_15_b);
//MainForm.RegisterFunction('Trim_DLA_IA32_15_c', @Trim_DLA_IA32_15_c);
//MainForm.RegisterFunction('Trim_DLA_IA32_15_d', @Trim_DLA_IA32_15_d);
//MainForm.RegisterFunction('Trim_DLA_IA32_16_a', @Trim_DLA_IA32_16_a);
//MainForm.RegisterFunction('Trim_DLA_IA32_16_b', @Trim_DLA_IA32_16_b);
//MainForm.RegisterFunction('Trim_DLA_IA32_16_c', @Trim_DLA_IA32_16_c);
//MainForm.RegisterFunction('Trim_DLA_IA32_16_d', @Trim_DLA_IA32_16_d);
MainForm.RegisterFunction('Trim_DLA_IA32_17_a', @Trim_DLA_IA32_17_a);
MainForm.RegisterFunction('Trim_DLA_IA32_17_b', @Trim_DLA_IA32_17_b);
MainForm.RegisterFunction('Trim_DLA_IA32_17_c', @Trim_DLA_IA32_17_c);
MainForm.RegisterFunction('Trim_DLA_IA32_17_d', @Trim_DLA_IA32_17_d);
MainForm.RegisterFunction('Trim_DLA_IA32_18_a', @Trim_DLA_IA32_18_a);
MainForm.RegisterFunction('Trim_DLA_IA32_18_b', @Trim_DLA_IA32_18_b);
MainForm.RegisterFunction('Trim_DLA_IA32_18_c', @Trim_DLA_IA32_18_c);
MainForm.RegisterFunction('Trim_DLA_IA32_18_d', @Trim_DLA_IA32_18_d);
MainForm.RegisterFunction('Trim_DLA_IA32_19_a', @Trim_DLA_IA32_19_a);
MainForm.RegisterFunction('Trim_DLA_IA32_19_b', @Trim_DLA_IA32_19_b);
MainForm.RegisterFunction('Trim_DLA_IA32_19_c', @Trim_DLA_IA32_19_c);
MainForm.RegisterFunction('Trim_DLA_IA32_19_d', @Trim_DLA_IA32_19_d);
        
end.

