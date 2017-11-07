unit CharPosRevDLAUnit;

interface

implementation

uses
 MainUnit;

type
 TByteArray = array[0..$7FFFFFFE] of Byte;
 PByteArray = ^TByteArray;

function CharPosRev_DLA_Pas_1_a(SearchChar : Char; const S: string) : Integer;
var
 CharNo : Integer;
 pString: PByteArray;
begin
 Result := 0;
 if S = '' then
   Exit;
 CharNo := PCardinal(Cardinal(S) - 4)^;
 if CharNo = 0 then
   Exit;
 pString := Pointer(S);
 repeat
   Dec(CharNo);
   if pString^[CharNo] = Byte(SearchChar) then
   begin
     Result := CharNo + 1;
     Break;
   end;
 until CharNo = 0;
end;

function CharPosRev_DLA_Pas_1_b(SearchChar : Char; const S: string) : Integer;
var
 CharNo : Integer;
 pString: PByteArray;
begin
 Result := 0;
 if S = '' then
   Exit;
 CharNo := PCardinal(Cardinal(S) - 4)^;
 if CharNo = 0 then
   Exit;
 pString := Pointer(S);
 repeat
   Dec(CharNo);
   if pString^[CharNo] = Byte(SearchChar) then
   begin
     Result := CharNo + 1;
     Break;
   end;
 until CharNo = 0;
end;

function CharPosRev_DLA_Pas_1_c(SearchChar : Char; const S: string) : Integer;
var
 CharNo : Integer;
 pString: PByteArray;
begin
 Result := 0;
 if S = '' then
   Exit;
 CharNo := PCardinal(Cardinal(S) - 4)^;
 if CharNo = 0 then
   Exit;
 pString := Pointer(S);
 repeat
   Dec(CharNo);
   if pString^[CharNo] = Byte(SearchChar) then
   begin
     Result := CharNo + 1;
     Break;
   end;
 until CharNo = 0;
end;

function CharPosRev_DLA_Pas_1_d(SearchChar : Char; const S: string) : Integer;
var
 CharNo : Integer;
 pString: PByteArray;
begin
 Result := 0;
 if S = '' then
   Exit;
 CharNo := PCardinal(Cardinal(S) - 4)^;
 if CharNo = 0 then
   Exit;
 pString := Pointer(S);
 repeat
   Dec(CharNo);
   if pString^[CharNo] = Byte(SearchChar) then
   begin
     Result := CharNo + 1;
     Break;
   end;
 until CharNo = 0;
end;

function CharPosRev_DLA_Pas_2_a(SearchChar : Char; const S: string) : Integer;
var
 CharNo : Integer;
 pString: PByteArray;
begin
 Result := 0;
 if S = '' then
   Exit;
 CharNo := PCardinal(Cardinal(S) - 4)^;
 pString := Pointer(S);
 while CharNo <> 0 do
 begin
    Dec(CharNo);
    if pString^[CharNo] = Byte(SearchChar) then
    begin
      Result := CharNo + 1;
      Break;
    end;
 end;
end;

function CharPosRev_DLA_Pas_2_b(SearchChar : Char; const S: string) : Integer;
var
 CharNo : Integer;
 pString: PByteArray;
begin
 Result := 0;
 if S = '' then
   Exit;
 CharNo := PCardinal(Cardinal(S) - 4)^;
 pString := Pointer(S);
 while CharNo <> 0 do
 begin
    Dec(CharNo);
    if pString^[CharNo] = Byte(SearchChar) then
    begin
      Result := CharNo + 1;
      Break;
    end;
 end;
end;

function CharPosRev_DLA_Pas_2_c(SearchChar : Char; const S: string) : Integer;
var
 CharNo : Integer;
 pString: PByteArray;
begin
 Result := 0;
 if S = '' then
   Exit;
 CharNo := PCardinal(Cardinal(S) - 4)^;
 pString := Pointer(S);
 while CharNo <> 0 do
 begin
    Dec(CharNo);
    if pString^[CharNo] = Byte(SearchChar) then
    begin
      Result := CharNo + 1;
      Break;
    end;
 end;
end;

function CharPosRev_DLA_Pas_2_d(SearchChar : Char; const S: string) : Integer;
var
 CharNo : Integer;
 pString: PByteArray;
begin
 Result := 0;
 if S = '' then
   Exit;
 CharNo := PCardinal(Cardinal(S) - 4)^;
 pString := Pointer(S);
 while CharNo <> 0 do
 begin
    Dec(CharNo);
    if pString^[CharNo] = Byte(SearchChar) then
    begin
      Result := CharNo + 1;
      Break;
    end;
 end;
end;

function CharPosRev_DLA_PAS_4_a(SearchChar : Char; const S: string) : Integer;
var
 p: PByteArray;
begin
  if S = '' then
  begin
    Result := 0;
    Exit;
  end;
  p := Pointer(S);
  for Result := PCardinal(Cardinal(S) - 4)^ downto 1 do
    if p^[Result - 1] = Byte(SearchChar) then
    begin
      Exit;
    end;
  Result := 0;
end;

procedure Filler1;
asm
 nop
end;

function CharPosRev_DLA_PAS_4_b(SearchChar : Char; const S: string) : Integer;
var
 p: PByteArray;
begin
  if S = '' then
  begin
    Result := 0;
    Exit;
  end;
  p := Pointer(S);
  for Result := PCardinal(Cardinal(S) - 4)^ downto 1 do
    if p^[Result - 1] = Byte(SearchChar) then
    begin
      Exit;
    end;
  Result := 0;
end;

procedure Filler2;
asm
 nop
end;

function CharPosRev_DLA_PAS_4_c(SearchChar : Char; const S: string) : Integer;
var
 p: PByteArray;
begin
  if S = '' then
  begin
    Result := 0;
    Exit;
  end;
  p := Pointer(S);
  for Result := PCardinal(Cardinal(S) - 4)^ downto 1 do
    if p^[Result - 1] = Byte(SearchChar) then
    begin
      Exit;
    end;
  Result := 0;
end;

procedure Filler3;
asm
 nop
end;

function CharPosRev_DLA_PAS_4_d(SearchChar : Char; const S: string) : Integer;
var
 p: PByteArray;
begin
  if S = '' then
  begin
    Result := 0;
    Exit;
  end;
  p := Pointer(S);
  for Result := PCardinal(Cardinal(S) - 4)^ downto 1 do
    if p^[Result - 1] = Byte(SearchChar) then
    begin
      Exit;
    end;
  Result := 0;
end;

function CharPosRev_DLA_PAS_5_a(SearchChar : Char; const S: string) : Integer;
var
 p: PByteArray;
begin
  p := Pointer(S);
  for Result := Length(S) downto 1 do
    if p^[Result - 1] = Byte(SearchChar) then
    begin
      Exit;
    end;
  Result := 0;
end;

function CharPosRev_DLA_PAS_5_b(SearchChar : Char; const S: string) : Integer;
var
 p: PByteArray;
begin
  p := Pointer(S);
  for Result := Length(S) downto 1 do
    if p^[Result - 1] = Byte(SearchChar) then
    begin
      Exit;
    end;
  Result := 0;
end;

procedure Filler4;
asm
 nop
end;

function CharPosRev_DLA_PAS_5_c(SearchChar : Char; const S: string) : Integer;
var
 p: PByteArray;
begin
  p := Pointer(S);
  for Result := Length(S) downto 1 do
    if p^[Result - 1] = Byte(SearchChar) then
    begin
      Exit;
    end;
  Result := 0;
end;

function CharPosRev_DLA_PAS_5_d(SearchChar : Char; const S: string) : Integer;
var
 p: PByteArray;
begin
  p := Pointer(S);
  for Result := Length(S) downto 1 do
    if p^[Result - 1] = Byte(SearchChar) then
    begin
      Exit;
    end;
  Result := 0;
end;

function CharPosRev_DLA_PAS_7_a(SearchChar: Char; const S: string): Integer;
var
  p: PByteArray;
begin
  Result := Length(S);
  if Result <= 4 then
  begin
    p := Pointer(S);
    for Result := Result downto 1 do
      if p^[Result - 1] = Byte(SearchChar) then
      begin
        Exit;
      end;
    Result := 0;
    Exit;
  end;
  Inc(Result, 3);
  p := Pointer(Cardinal(S) - 4);
  while Result >= 3 do
  begin
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Exit;
    end;
    if p^[Result - 1] = Byte(SearchChar) then
    begin
      Dec(Result, 4);
      Break;
    end;
    if p^[Result - 2] = Byte(SearchChar) then
    begin
      Dec(Result, 5);
      Break;
    end;
    if p^[Result - 3] = Byte(SearchChar) then
    begin
      Dec(Result, 6);
      Break;
    end;
    Dec(Result, 4);
  end;
  if Result < 0 then {Match Found before First Char}
    Result := 0;
end;

function CharPosRev_DLA_PAS_7_b(SearchChar: Char; const S: string): Integer;
var
  p: PByteArray;
begin
  Result := Length(S);
  if Result <= 4 then
  begin
    p := Pointer(S);
    for Result := Result downto 1 do
      if p^[Result - 1] = Byte(SearchChar) then
      begin
        Exit;
      end;
    Result := 0;
    Exit;
  end;
  Inc(Result, 3);
  p := Pointer(Cardinal(S) - 4);
  while Result >= 3 do
  begin
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Exit;
    end;
    if p^[Result - 1] = Byte(SearchChar) then
    begin
      Dec(Result, 4);
      Break;
    end;
    if p^[Result - 2] = Byte(SearchChar) then
    begin
      Dec(Result, 5);
      Break;
    end;
    if p^[Result - 3] = Byte(SearchChar) then
    begin
      Dec(Result, 6);
      Break;
    end;
    Dec(Result, 4);
  end;
  if Result < 0 then {Match Found before First Char}
    Result := 0;
end;

function CharPosRev_DLA_PAS_7_c(SearchChar: Char; const S: string): Integer;
var
  p: PByteArray;
begin
  Result := Length(S);
  if Result <= 4 then
  begin
    p := Pointer(S);
    for Result := Result downto 1 do
      if p^[Result - 1] = Byte(SearchChar) then
      begin
        Exit;
      end;
    Result := 0;
    Exit;
  end;
  Inc(Result, 3);
  p := Pointer(Cardinal(S) - 4);
  while Result >= 3 do
  begin
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Exit;
    end;
    if p^[Result - 1] = Byte(SearchChar) then
    begin
      Dec(Result, 4);
      Break;
    end;
    if p^[Result - 2] = Byte(SearchChar) then
    begin
      Dec(Result, 5);
      Break;
    end;
    if p^[Result - 3] = Byte(SearchChar) then
    begin
      Dec(Result, 6);
      Break;
    end;
    Dec(Result, 4);
  end;
  if Result < 0 then {Match Found before First Char}
    Result := 0;
end;

function CharPosRev_DLA_PAS_7_d(SearchChar: Char; const S: string): Integer;
var
  p: PByteArray;
begin
  Result := Length(S);
  if Result <= 4 then
  begin
    p := Pointer(S);
    for Result := Result downto 1 do
      if p^[Result - 1] = Byte(SearchChar) then
      begin
        Exit;
      end;
    Result := 0;
    Exit;
  end;
  Inc(Result, 3);
  p := Pointer(Cardinal(S) - 4);
  while Result >= 3 do
  begin
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Exit;
    end;
    if p^[Result - 1] = Byte(SearchChar) then
    begin
      Dec(Result, 4);
      Break;
    end;
    if p^[Result - 2] = Byte(SearchChar) then
    begin
      Dec(Result, 5);
      Break;
    end;
    if p^[Result - 3] = Byte(SearchChar) then
    begin
      Dec(Result, 6);
      Break;
    end;
    Dec(Result, 4);
  end;
  if Result < 0 then {Match Found before First Char}
    Result := 0;
end;

function CharPosRev_DLA_PAS_8_a(SearchChar: Char; const S: string): Integer;
var
  p: PByteArray;
begin
  Result := Length(S);
  if Result <= 4 then
  begin
    p := Pointer(S);
    for Result := Result downto 1 do
      if p^[Result - 1] = Byte(SearchChar) then
      begin
        Exit;
      end;
    Result := 0;
    Exit;
  end;
  Inc(Result, 3);
  p := Pointer(Cardinal(S) - 4);
  while Result >= 3 do
  begin
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Exit;
    end;
    Dec(Result);
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Break;
    end;
    Dec(Result);
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Break;
    end;
    Dec(Result);
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Break;
    end;
    Dec(Result);
  end;
  if Result < 0 then {Match Found before First Char}
    Result := 0;
end;

function CharPosRev_DLA_PAS_8_b(SearchChar: Char; const S: string): Integer;
var
  p: PByteArray;
begin
  Result := Length(S);
  if Result <= 4 then
  begin
    p := Pointer(S);
    for Result := Result downto 1 do
      if p^[Result - 1] = Byte(SearchChar) then
      begin
        Exit;
      end;
    Result := 0;
    Exit;
  end;
  Inc(Result, 3);
  p := Pointer(Cardinal(S) - 4);
  while Result >= 3 do
  begin
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Exit;
    end;
    Dec(Result);
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Break;
    end;
    Dec(Result);
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Break;
    end;
    Dec(Result);
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Break;
    end;
    Dec(Result);
  end;
  if Result < 0 then {Match Found before First Char}
    Result := 0;
end;

function CharPosRev_DLA_PAS_8_c(SearchChar: Char; const S: string): Integer;
var
  p: PByteArray;
begin
  Result := Length(S);
  if Result <= 4 then
  begin
    p := Pointer(S);
    for Result := Result downto 1 do
      if p^[Result - 1] = Byte(SearchChar) then
      begin
        Exit;
      end;
    Result := 0;
    Exit;
  end;
  Inc(Result, 3);
  p := Pointer(Cardinal(S) - 4);
  while Result >= 3 do
  begin
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Exit;
    end;
    Dec(Result);
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Break;
    end;
    Dec(Result);
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Break;
    end;
    Dec(Result);
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Break;
    end;
    Dec(Result);
  end;
  if Result < 0 then {Match Found before First Char}
    Result := 0;
end;

function CharPosRev_DLA_PAS_8_d(SearchChar: Char; const S: string): Integer;
var
  p: PByteArray;
begin
  Result := Length(S);
  if Result <= 4 then
  begin
    p := Pointer(S);
    for Result := Result downto 1 do
      if p^[Result - 1] = Byte(SearchChar) then
      begin
        Exit;
      end;
    Result := 0;
    Exit;
  end;
  Inc(Result, 3);
  p := Pointer(Cardinal(S) - 4);
  while Result >= 3 do
  begin
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Exit;
    end;
    Dec(Result);
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Break;
    end;
    Dec(Result);
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Break;
    end;
    Dec(Result);
    if p^[Result] = Byte(SearchChar) then
    begin
      Dec(Result, 3);
      Break;
    end;
    Dec(Result);
  end;
  if Result < 0 then {Match Found before First Char}
    Result := 0;
end;

function CharPosRev_DLA_PAS_14_a(SearchChar: Char; const S: string):
Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 16);
    while PWalk >= PStart do
    begin
      if PWalk[15] = SearchChar then
      begin
        Result := (PWalk - PStart) + 16;
        Exit;
      end;
      if PWalk[14] = SearchChar then
      begin
        Result := (PWalk - PStart) + 15;
        Exit;
      end;
      if PWalk[13] = SearchChar then
      begin
        Result := (PWalk - PStart) + 14;
        Exit;
      end;
      if PWalk[12] = SearchChar then
      begin
        Result := (PWalk - PStart) + 13;
        Exit;
      end;
      if PWalk[11] = SearchChar then
      begin
        Result := (PWalk - PStart) + 12;
        Exit;
      end;
      if PWalk[10] = SearchChar then
      begin
        Result := (PWalk - PStart) + 11;
        Exit;
      end;
      if PWalk[9] = SearchChar then
      begin
        Result := (PWalk - PStart) + 10;
        Exit;
      end;
      if PWalk[8] = SearchChar then
      begin
        Result := (PWalk - PStart) + 9;
        Exit;
      end;
      if PWalk[7] = SearchChar then
      begin
        Result := (PWalk - PStart) + 8;
        Exit;
      end;
      if PWalk[6] = SearchChar then
      begin
        Result := (PWalk - PStart) + 7;
        Exit;
      end;
      if PWalk[5] = SearchChar then
      begin
        Result := (PWalk - PStart) + 6;
        Exit;
      end;
      if PWalk[4] = SearchChar then
      begin
        Result := (PWalk - PStart) + 5;
        Exit;
      end;
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 16);
    end;
    case 16 - (PStart - PWalk) of
      0: goto c0;
      1: goto c1;
      2: goto c2;
      3: goto c3;
      4: goto c4;
      5: goto c5;
      6: goto c6;
      7: goto c7;
      8: goto c8;
      9: goto c9;
      10: goto c10;
      11: goto c11;
      12: goto c12;
      13: goto c13;
      14: goto c14;
      15: goto c15;
      16: goto c16;
    end;
    c16:
    if PStart[15] = SearchChar then
    begin
      Result := 16;
      Exit;
    end;
    c15:
    if PStart[14] = SearchChar then
    begin
      Result := 15;
      Exit;
    end;
    c14:
    if PStart[13] = SearchChar then
    begin
      Result := 14;
      Exit;
    end;
    c13:
    if PStart[12] = SearchChar then
    begin
      Result := 13;
      Exit;
    end;
    c12:
    if PStart[11] = SearchChar then
    begin
      Result := 12;
      Exit;
    end;
    c11:
    if PStart[10] = SearchChar then
    begin
      Result := 11;
      Exit;
    end;
    c10:
    if PStart[9] = SearchChar then
    begin
      Result := 10;
      Exit;
    end;
    c9:
    if PStart[8] = SearchChar then
    begin
      Result := 9;
      Exit;
    end;
    c8:
    if PStart[7] = SearchChar then
    begin
      Result := 8;
      Exit;
    end;
    c7:
    if PStart[6] = SearchChar then
    begin
      Result := 7;
      Exit;
    end;
    c6:
    if PStart[5] = SearchChar then
    begin
      Result := 6;
      Exit;
    end;
    c5:
    if PStart[4] = SearchChar then
    begin
      Result := 5;
      Exit;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

function CharPosRev_DLA_PAS_14_b(SearchChar: Char; const S: string):
Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 16);
    while PWalk >= PStart do
    begin
      if PWalk[15] = SearchChar then
      begin
        Result := (PWalk - PStart) + 16;
        Exit;
      end;
      if PWalk[14] = SearchChar then
      begin
        Result := (PWalk - PStart) + 15;
        Exit;
      end;
      if PWalk[13] = SearchChar then
      begin
        Result := (PWalk - PStart) + 14;
        Exit;
      end;
      if PWalk[12] = SearchChar then
      begin
        Result := (PWalk - PStart) + 13;
        Exit;
      end;
      if PWalk[11] = SearchChar then
      begin
        Result := (PWalk - PStart) + 12;
        Exit;
      end;
      if PWalk[10] = SearchChar then
      begin
        Result := (PWalk - PStart) + 11;
        Exit;
      end;
      if PWalk[9] = SearchChar then
      begin
        Result := (PWalk - PStart) + 10;
        Exit;
      end;
      if PWalk[8] = SearchChar then
      begin
        Result := (PWalk - PStart) + 9;
        Exit;
      end;
      if PWalk[7] = SearchChar then
      begin
        Result := (PWalk - PStart) + 8;
        Exit;
      end;
      if PWalk[6] = SearchChar then
      begin
        Result := (PWalk - PStart) + 7;
        Exit;
      end;
      if PWalk[5] = SearchChar then
      begin
        Result := (PWalk - PStart) + 6;
        Exit;
      end;
      if PWalk[4] = SearchChar then
      begin
        Result := (PWalk - PStart) + 5;
        Exit;
      end;
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 16);
    end;
    case 16 - (PStart - PWalk) of
      0: goto c0;
      1: goto c1;
      2: goto c2;
      3: goto c3;
      4: goto c4;
      5: goto c5;
      6: goto c6;
      7: goto c7;
      8: goto c8;
      9: goto c9;
      10: goto c10;
      11: goto c11;
      12: goto c12;
      13: goto c13;
      14: goto c14;
      15: goto c15;
      16: goto c16;
    end;
    c16:
    if PStart[15] = SearchChar then
    begin
      Result := 16;
      Exit;
    end;
    c15:
    if PStart[14] = SearchChar then
    begin
      Result := 15;
      Exit;
    end;
    c14:
    if PStart[13] = SearchChar then
    begin
      Result := 14;
      Exit;
    end;
    c13:
    if PStart[12] = SearchChar then
    begin
      Result := 13;
      Exit;
    end;
    c12:
    if PStart[11] = SearchChar then
    begin
      Result := 12;
      Exit;
    end;
    c11:
    if PStart[10] = SearchChar then
    begin
      Result := 11;
      Exit;
    end;
    c10:
    if PStart[9] = SearchChar then
    begin
      Result := 10;
      Exit;
    end;
    c9:
    if PStart[8] = SearchChar then
    begin
      Result := 9;
      Exit;
    end;
    c8:
    if PStart[7] = SearchChar then
    begin
      Result := 8;
      Exit;
    end;
    c7:
    if PStart[6] = SearchChar then
    begin
      Result := 7;
      Exit;
    end;
    c6:
    if PStart[5] = SearchChar then
    begin
      Result := 6;
      Exit;
    end;
    c5:
    if PStart[4] = SearchChar then
    begin
      Result := 5;
      Exit;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

procedure Filler5;
asm
 nop
end;

function CharPosRev_DLA_PAS_14_c(SearchChar: Char; const S: string):
Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 16);
    while PWalk >= PStart do
    begin
      if PWalk[15] = SearchChar then
      begin
        Result := (PWalk - PStart) + 16;
        Exit;
      end;
      if PWalk[14] = SearchChar then
      begin
        Result := (PWalk - PStart) + 15;
        Exit;
      end;
      if PWalk[13] = SearchChar then
      begin
        Result := (PWalk - PStart) + 14;
        Exit;
      end;
      if PWalk[12] = SearchChar then
      begin
        Result := (PWalk - PStart) + 13;
        Exit;
      end;
      if PWalk[11] = SearchChar then
      begin
        Result := (PWalk - PStart) + 12;
        Exit;
      end;
      if PWalk[10] = SearchChar then
      begin
        Result := (PWalk - PStart) + 11;
        Exit;
      end;
      if PWalk[9] = SearchChar then
      begin
        Result := (PWalk - PStart) + 10;
        Exit;
      end;
      if PWalk[8] = SearchChar then
      begin
        Result := (PWalk - PStart) + 9;
        Exit;
      end;
      if PWalk[7] = SearchChar then
      begin
        Result := (PWalk - PStart) + 8;
        Exit;
      end;
      if PWalk[6] = SearchChar then
      begin
        Result := (PWalk - PStart) + 7;
        Exit;
      end;
      if PWalk[5] = SearchChar then
      begin
        Result := (PWalk - PStart) + 6;
        Exit;
      end;
      if PWalk[4] = SearchChar then
      begin
        Result := (PWalk - PStart) + 5;
        Exit;
      end;
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 16);
    end;
    case 16 - (PStart - PWalk) of
      0: goto c0;
      1: goto c1;
      2: goto c2;
      3: goto c3;
      4: goto c4;
      5: goto c5;
      6: goto c6;
      7: goto c7;
      8: goto c8;
      9: goto c9;
      10: goto c10;
      11: goto c11;
      12: goto c12;
      13: goto c13;
      14: goto c14;
      15: goto c15;
      16: goto c16;
    end;
    c16:
    if PStart[15] = SearchChar then
    begin
      Result := 16;
      Exit;
    end;
    c15:
    if PStart[14] = SearchChar then
    begin
      Result := 15;
      Exit;
    end;
    c14:
    if PStart[13] = SearchChar then
    begin
      Result := 14;
      Exit;
    end;
    c13:
    if PStart[12] = SearchChar then
    begin
      Result := 13;
      Exit;
    end;
    c12:
    if PStart[11] = SearchChar then
    begin
      Result := 12;
      Exit;
    end;
    c11:
    if PStart[10] = SearchChar then
    begin
      Result := 11;
      Exit;
    end;
    c10:
    if PStart[9] = SearchChar then
    begin
      Result := 10;
      Exit;
    end;
    c9:
    if PStart[8] = SearchChar then
    begin
      Result := 9;
      Exit;
    end;
    c8:
    if PStart[7] = SearchChar then
    begin
      Result := 8;
      Exit;
    end;
    c7:
    if PStart[6] = SearchChar then
    begin
      Result := 7;
      Exit;
    end;
    c6:
    if PStart[5] = SearchChar then
    begin
      Result := 6;
      Exit;
    end;
    c5:
    if PStart[4] = SearchChar then
    begin
      Result := 5;
      Exit;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

function CharPosRev_DLA_PAS_14_d(SearchChar: Char; const S: string):
Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 16);
    while PWalk >= PStart do
    begin
      if PWalk[15] = SearchChar then
      begin
        Result := (PWalk - PStart) + 16;
        Exit;
      end;
      if PWalk[14] = SearchChar then
      begin
        Result := (PWalk - PStart) + 15;
        Exit;
      end;
      if PWalk[13] = SearchChar then
      begin
        Result := (PWalk - PStart) + 14;
        Exit;
      end;
      if PWalk[12] = SearchChar then
      begin
        Result := (PWalk - PStart) + 13;
        Exit;
      end;
      if PWalk[11] = SearchChar then
      begin
        Result := (PWalk - PStart) + 12;
        Exit;
      end;
      if PWalk[10] = SearchChar then
      begin
        Result := (PWalk - PStart) + 11;
        Exit;
      end;
      if PWalk[9] = SearchChar then
      begin
        Result := (PWalk - PStart) + 10;
        Exit;
      end;
      if PWalk[8] = SearchChar then
      begin
        Result := (PWalk - PStart) + 9;
        Exit;
      end;
      if PWalk[7] = SearchChar then
      begin
        Result := (PWalk - PStart) + 8;
        Exit;
      end;
      if PWalk[6] = SearchChar then
      begin
        Result := (PWalk - PStart) + 7;
        Exit;
      end;
      if PWalk[5] = SearchChar then
      begin
        Result := (PWalk - PStart) + 6;
        Exit;
      end;
      if PWalk[4] = SearchChar then
      begin
        Result := (PWalk - PStart) + 5;
        Exit;
      end;
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 16);
    end;
    case 16 - (PStart - PWalk) of
      0: goto c0;
      1: goto c1;
      2: goto c2;
      3: goto c3;
      4: goto c4;
      5: goto c5;
      6: goto c6;
      7: goto c7;
      8: goto c8;
      9: goto c9;
      10: goto c10;
      11: goto c11;
      12: goto c12;
      13: goto c13;
      14: goto c14;
      15: goto c15;
      16: goto c16;
    end;
    c16:
    if PStart[15] = SearchChar then
    begin
      Result := 16;
      Exit;
    end;
    c15:
    if PStart[14] = SearchChar then
    begin
      Result := 15;
      Exit;
    end;
    c14:
    if PStart[13] = SearchChar then
    begin
      Result := 14;
      Exit;
    end;
    c13:
    if PStart[12] = SearchChar then
    begin
      Result := 13;
      Exit;
    end;
    c12:
    if PStart[11] = SearchChar then
    begin
      Result := 12;
      Exit;
    end;
    c11:
    if PStart[10] = SearchChar then
    begin
      Result := 11;
      Exit;
    end;
    c10:
    if PStart[9] = SearchChar then
    begin
      Result := 10;
      Exit;
    end;
    c9:
    if PStart[8] = SearchChar then
    begin
      Result := 9;
      Exit;
    end;
    c8:
    if PStart[7] = SearchChar then
    begin
      Result := 8;
      Exit;
    end;
    c7:
    if PStart[6] = SearchChar then
    begin
      Result := 7;
      Exit;
    end;
    c6:
    if PStart[5] = SearchChar then
    begin
      Result := 6;
      Exit;
    end;
    c5:
    if PStart[4] = SearchChar then
    begin
      Result := 5;
      Exit;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

function CharPosRev_DLA_PAS_15_a(SearchChar: Char; const S: string):
Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4, c5, c6, c7, c8;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 8);
    while PWalk >= PStart do
    begin
      if PWalk[7] = SearchChar then
      begin
        Result := (PWalk - PStart) + 8;
        Exit;
      end;
      if PWalk[6] = SearchChar then
      begin
        Result := (PWalk - PStart) + 7;
        Exit;
      end;
      if PWalk[5] = SearchChar then
      begin
        Result := (PWalk - PStart) + 6;
        Exit;
      end;
      if PWalk[4] = SearchChar then
      begin
        Result := (PWalk - PStart) + 5;
        Exit;
      end;
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 8);
    end;
    case 8 - (PStart - PWalk) of
      0: goto c0;
      1: goto c1;
      2: goto c2;
      3: goto c3;
      4: goto c4;
      5: goto c5;
      6: goto c6;
      7: goto c7;
      8: goto c8;
    end;
    c8:
    if PStart[7] = SearchChar then
    begin
      Result := 8;
      Exit;
    end;
    c7:
    if PStart[6] = SearchChar then
    begin
      Result := 7;
      Exit;
    end;
    c6:
    if PStart[5] = SearchChar then
    begin
      Result := 6;
      Exit;
    end;
    c5:
    if PStart[4] = SearchChar then
    begin
      Result := 5;
      Exit;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

procedure Filler6;
asm
 nop
end;

function CharPosRev_DLA_PAS_15_b(SearchChar: Char; const S: string):
Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4, c5, c6, c7, c8;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 8);
    while PWalk >= PStart do
    begin
      if PWalk[7] = SearchChar then
      begin
        Result := (PWalk - PStart) + 8;
        Exit;
      end;
      if PWalk[6] = SearchChar then
      begin
        Result := (PWalk - PStart) + 7;
        Exit;
      end;
      if PWalk[5] = SearchChar then
      begin
        Result := (PWalk - PStart) + 6;
        Exit;
      end;
      if PWalk[4] = SearchChar then
      begin
        Result := (PWalk - PStart) + 5;
        Exit;
      end;
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 8);
    end;
    case 8 - (PStart - PWalk) of
      0: goto c0;
      1: goto c1;
      2: goto c2;
      3: goto c3;
      4: goto c4;
      5: goto c5;
      6: goto c6;
      7: goto c7;
      8: goto c8;
    end;
    c8:
    if PStart[7] = SearchChar then
    begin
      Result := 8;
      Exit;
    end;
    c7:
    if PStart[6] = SearchChar then
    begin
      Result := 7;
      Exit;
    end;
    c6:
    if PStart[5] = SearchChar then
    begin
      Result := 6;
      Exit;
    end;
    c5:
    if PStart[4] = SearchChar then
    begin
      Result := 5;
      Exit;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

procedure Filler7;
asm
 nop
end;

function CharPosRev_DLA_PAS_15_c(SearchChar: Char; const S: string):
Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4, c5, c6, c7, c8;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 8);
    while PWalk >= PStart do
    begin
      if PWalk[7] = SearchChar then
      begin
        Result := (PWalk - PStart) + 8;
        Exit;
      end;
      if PWalk[6] = SearchChar then
      begin
        Result := (PWalk - PStart) + 7;
        Exit;
      end;
      if PWalk[5] = SearchChar then
      begin
        Result := (PWalk - PStart) + 6;
        Exit;
      end;
      if PWalk[4] = SearchChar then
      begin
        Result := (PWalk - PStart) + 5;
        Exit;
      end;
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 8);
    end;
    case 8 - (PStart - PWalk) of
      0: goto c0;
      1: goto c1;
      2: goto c2;
      3: goto c3;
      4: goto c4;
      5: goto c5;
      6: goto c6;
      7: goto c7;
      8: goto c8;
    end;
    c8:
    if PStart[7] = SearchChar then
    begin
      Result := 8;
      Exit;
    end;
    c7:
    if PStart[6] = SearchChar then
    begin
      Result := 7;
      Exit;
    end;
    c6:
    if PStart[5] = SearchChar then
    begin
      Result := 6;
      Exit;
    end;
    c5:
    if PStart[4] = SearchChar then
    begin
      Result := 5;
      Exit;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

procedure Filler8;
asm
 nop
end;

function CharPosRev_DLA_PAS_15_d(SearchChar: Char; const S: string):
Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4, c5, c6, c7, c8;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 8);
    while PWalk >= PStart do
    begin
      if PWalk[7] = SearchChar then
      begin
        Result := (PWalk - PStart) + 8;
        Exit;
      end;
      if PWalk[6] = SearchChar then
      begin
        Result := (PWalk - PStart) + 7;
        Exit;
      end;
      if PWalk[5] = SearchChar then
      begin
        Result := (PWalk - PStart) + 6;
        Exit;
      end;
      if PWalk[4] = SearchChar then
      begin
        Result := (PWalk - PStart) + 5;
        Exit;
      end;
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 8);
    end;
    case 8 - (PStart - PWalk) of
      0: goto c0;
      1: goto c1;
      2: goto c2;
      3: goto c3;
      4: goto c4;
      5: goto c5;
      6: goto c6;
      7: goto c7;
      8: goto c8;
    end;
    c8:
    if PStart[7] = SearchChar then
    begin
      Result := 8;
      Exit;
    end;
    c7:
    if PStart[6] = SearchChar then
    begin
      Result := 7;
      Exit;
    end;
    c6:
    if PStart[5] = SearchChar then
    begin
      Result := 6;
      Exit;
    end;
    c5:
    if PStart[4] = SearchChar then
    begin
      Result := 5;
      Exit;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

function CharPosRev_DLA_PAS_16_a(SearchChar: Char; const S: string): Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 4);
    while PWalk >= PStart do
    begin
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 4);
    end;
    case 4 - (PStart - PWalk) of
      0: goto c0;
      1: goto c1;
      2: goto c2;
      3: goto c3;
      4: goto c4;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

function CharPosRev_DLA_PAS_16_b(SearchChar: Char; const S: string): Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 4);
    while PWalk >= PStart do
    begin
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 4);
    end;
    case 4 - (PStart - PWalk) of
      0: goto c0;
      1: goto c1;
      2: goto c2;
      3: goto c3;
      4: goto c4;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

procedure Filler9;
asm
 nop
end;

function CharPosRev_DLA_PAS_16_c(SearchChar: Char; const S: string): Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 4);
    while PWalk >= PStart do
    begin
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 4);
    end;
    case 4 - (PStart - PWalk) of
      0: goto c0;
      1: goto c1;
      2: goto c2;
      3: goto c3;
      4: goto c4;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

function CharPosRev_DLA_PAS_16_d(SearchChar: Char; const S: string): Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 4);
    while PWalk >= PStart do
    begin
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 4);
    end;
    case 4 - (PStart - PWalk) of
      0: goto c0;
      1: goto c1;
      2: goto c2;
      3: goto c3;
      4: goto c4;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

function CharPosRev_DLA_PAS_19_a(SearchChar: Char; const S: string): Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 16);
    while PWalk >= PStart do
    begin
      if PWalk[15] = SearchChar then
      begin
        Result := (PWalk - PStart) + 16;
        Exit;
      end;
      if PWalk[14] = SearchChar then
      begin
        Result := (PWalk - PStart) + 15;
        Exit;
      end;
      if PWalk[13] = SearchChar then
      begin
        Result := (PWalk - PStart) + 14;
        Exit;
      end;
      if PWalk[12] = SearchChar then
      begin
        Result := (PWalk - PStart) + 13;
        Exit;
      end;
      if PWalk[11] = SearchChar then
      begin
        Result := (PWalk - PStart) + 12;
        Exit;
      end;
      if PWalk[10] = SearchChar then
      begin
        Result := (PWalk - PStart) + 11;
        Exit;
      end;
      if PWalk[9] = SearchChar then
      begin
        Result := (PWalk - PStart) + 10;
        Exit;
      end;
      if PWalk[8] = SearchChar then
      begin
        Result := (PWalk - PStart) + 9;
        Exit;
      end;
      if PWalk[7] = SearchChar then
      begin
        Result := (PWalk - PStart) + 8;
        Exit;
      end;
      if PWalk[6] = SearchChar then
      begin
        Result := (PWalk - PStart) + 7;
        Exit;
      end;
      if PWalk[5] = SearchChar then
      begin
        Result := (PWalk - PStart) + 6;
        Exit;
      end;
      if PWalk[4] = SearchChar then
      begin
        Result := (PWalk - PStart) + 5;
        Exit;
      end;
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 16);
    end;
    case (PStart - PWalk) of
      0: goto c16;
      1: goto c15;
      2: goto c14;
      3: goto c13;
      4: goto c12;
      5: goto c11;
      6: goto c10;
      7: goto c9;
      8: goto c8;
      9: goto c7;
      10: goto c6;
      11: goto c5;
      12: goto c4;
      13: goto c3;
      14: goto c2;
      15: goto c1;
      16: goto c0;
    end;
    c16:
    if PStart[15] = SearchChar then
    begin
      Result := 16;
      Exit;
    end;
    c15:
    if PStart[14] = SearchChar then
    begin
      Result := 15;
      Exit;
    end;
    c14:
    if PStart[13] = SearchChar then
    begin
      Result := 14;
      Exit;
    end;
    c13:
    if PStart[12] = SearchChar then
    begin
      Result := 13;
      Exit;
    end;
    c12:
    if PStart[11] = SearchChar then
    begin
      Result := 12;
      Exit;
    end;
    c11:
    if PStart[10] = SearchChar then
    begin
      Result := 11;
      Exit;
    end;
    c10:
    if PStart[9] = SearchChar then
    begin
      Result := 10;
      Exit;
    end;
    c9:
    if PStart[8] = SearchChar then
    begin
      Result := 9;
      Exit;
    end;
    c8:
    if PStart[7] = SearchChar then
    begin
      Result := 8;
      Exit;
    end;
    c7:
    if PStart[6] = SearchChar then
    begin
      Result := 7;
      Exit;
    end;
    c6:
    if PStart[5] = SearchChar then
    begin
      Result := 6;
      Exit;
    end;
    c5:
    if PStart[4] = SearchChar then
    begin
      Result := 5;
      Exit;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

function CharPosRev_DLA_PAS_19_b(SearchChar: Char; const S: string): Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 16);
    while PWalk >= PStart do
    begin
      if PWalk[15] = SearchChar then
      begin
        Result := (PWalk - PStart) + 16;
        Exit;
      end;
      if PWalk[14] = SearchChar then
      begin
        Result := (PWalk - PStart) + 15;
        Exit;
      end;
      if PWalk[13] = SearchChar then
      begin
        Result := (PWalk - PStart) + 14;
        Exit;
      end;
      if PWalk[12] = SearchChar then
      begin
        Result := (PWalk - PStart) + 13;
        Exit;
      end;
      if PWalk[11] = SearchChar then
      begin
        Result := (PWalk - PStart) + 12;
        Exit;
      end;
      if PWalk[10] = SearchChar then
      begin
        Result := (PWalk - PStart) + 11;
        Exit;
      end;
      if PWalk[9] = SearchChar then
      begin
        Result := (PWalk - PStart) + 10;
        Exit;
      end;
      if PWalk[8] = SearchChar then
      begin
        Result := (PWalk - PStart) + 9;
        Exit;
      end;
      if PWalk[7] = SearchChar then
      begin
        Result := (PWalk - PStart) + 8;
        Exit;
      end;
      if PWalk[6] = SearchChar then
      begin
        Result := (PWalk - PStart) + 7;
        Exit;
      end;
      if PWalk[5] = SearchChar then
      begin
        Result := (PWalk - PStart) + 6;
        Exit;
      end;
      if PWalk[4] = SearchChar then
      begin
        Result := (PWalk - PStart) + 5;
        Exit;
      end;
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 16);
    end;
    case (PStart - PWalk) of
      0: goto c16;
      1: goto c15;
      2: goto c14;
      3: goto c13;
      4: goto c12;
      5: goto c11;
      6: goto c10;
      7: goto c9;
      8: goto c8;
      9: goto c7;
      10: goto c6;
      11: goto c5;
      12: goto c4;
      13: goto c3;
      14: goto c2;
      15: goto c1;
      16: goto c0;
    end;
    c16:
    if PStart[15] = SearchChar then
    begin
      Result := 16;
      Exit;
    end;
    c15:
    if PStart[14] = SearchChar then
    begin
      Result := 15;
      Exit;
    end;
    c14:
    if PStart[13] = SearchChar then
    begin
      Result := 14;
      Exit;
    end;
    c13:
    if PStart[12] = SearchChar then
    begin
      Result := 13;
      Exit;
    end;
    c12:
    if PStart[11] = SearchChar then
    begin
      Result := 12;
      Exit;
    end;
    c11:
    if PStart[10] = SearchChar then
    begin
      Result := 11;
      Exit;
    end;
    c10:
    if PStart[9] = SearchChar then
    begin
      Result := 10;
      Exit;
    end;
    c9:
    if PStart[8] = SearchChar then
    begin
      Result := 9;
      Exit;
    end;
    c8:
    if PStart[7] = SearchChar then
    begin
      Result := 8;
      Exit;
    end;
    c7:
    if PStart[6] = SearchChar then
    begin
      Result := 7;
      Exit;
    end;
    c6:
    if PStart[5] = SearchChar then
    begin
      Result := 6;
      Exit;
    end;
    c5:
    if PStart[4] = SearchChar then
    begin
      Result := 5;
      Exit;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

function CharPosRev_DLA_PAS_19_c(SearchChar: Char; const S: string): Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 16);
    while PWalk >= PStart do
    begin
      if PWalk[15] = SearchChar then
      begin
        Result := (PWalk - PStart) + 16;
        Exit;
      end;
      if PWalk[14] = SearchChar then
      begin
        Result := (PWalk - PStart) + 15;
        Exit;
      end;
      if PWalk[13] = SearchChar then
      begin
        Result := (PWalk - PStart) + 14;
        Exit;
      end;
      if PWalk[12] = SearchChar then
      begin
        Result := (PWalk - PStart) + 13;
        Exit;
      end;
      if PWalk[11] = SearchChar then
      begin
        Result := (PWalk - PStart) + 12;
        Exit;
      end;
      if PWalk[10] = SearchChar then
      begin
        Result := (PWalk - PStart) + 11;
        Exit;
      end;
      if PWalk[9] = SearchChar then
      begin
        Result := (PWalk - PStart) + 10;
        Exit;
      end;
      if PWalk[8] = SearchChar then
      begin
        Result := (PWalk - PStart) + 9;
        Exit;
      end;
      if PWalk[7] = SearchChar then
      begin
        Result := (PWalk - PStart) + 8;
        Exit;
      end;
      if PWalk[6] = SearchChar then
      begin
        Result := (PWalk - PStart) + 7;
        Exit;
      end;
      if PWalk[5] = SearchChar then
      begin
        Result := (PWalk - PStart) + 6;
        Exit;
      end;
      if PWalk[4] = SearchChar then
      begin
        Result := (PWalk - PStart) + 5;
        Exit;
      end;
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 16);
    end;
    case (PStart - PWalk) of
      0: goto c16;
      1: goto c15;
      2: goto c14;
      3: goto c13;
      4: goto c12;
      5: goto c11;
      6: goto c10;
      7: goto c9;
      8: goto c8;
      9: goto c7;
      10: goto c6;
      11: goto c5;
      12: goto c4;
      13: goto c3;
      14: goto c2;
      15: goto c1;
      16: goto c0;
    end;
    c16:
    if PStart[15] = SearchChar then
    begin
      Result := 16;
      Exit;
    end;
    c15:
    if PStart[14] = SearchChar then
    begin
      Result := 15;
      Exit;
    end;
    c14:
    if PStart[13] = SearchChar then
    begin
      Result := 14;
      Exit;
    end;
    c13:
    if PStart[12] = SearchChar then
    begin
      Result := 13;
      Exit;
    end;
    c12:
    if PStart[11] = SearchChar then
    begin
      Result := 12;
      Exit;
    end;
    c11:
    if PStart[10] = SearchChar then
    begin
      Result := 11;
      Exit;
    end;
    c10:
    if PStart[9] = SearchChar then
    begin
      Result := 10;
      Exit;
    end;
    c9:
    if PStart[8] = SearchChar then
    begin
      Result := 9;
      Exit;
    end;
    c8:
    if PStart[7] = SearchChar then
    begin
      Result := 8;
      Exit;
    end;
    c7:
    if PStart[6] = SearchChar then
    begin
      Result := 7;
      Exit;
    end;
    c6:
    if PStart[5] = SearchChar then
    begin
      Result := 6;
      Exit;
    end;
    c5:
    if PStart[4] = SearchChar then
    begin
      Result := 5;
      Exit;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

function CharPosRev_DLA_PAS_19_d(SearchChar: Char; const S: string): Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 16);
    while PWalk >= PStart do
    begin
      if PWalk[15] = SearchChar then
      begin
        Result := (PWalk - PStart) + 16;
        Exit;
      end;
      if PWalk[14] = SearchChar then
      begin
        Result := (PWalk - PStart) + 15;
        Exit;
      end;
      if PWalk[13] = SearchChar then
      begin
        Result := (PWalk - PStart) + 14;
        Exit;
      end;
      if PWalk[12] = SearchChar then
      begin
        Result := (PWalk - PStart) + 13;
        Exit;
      end;
      if PWalk[11] = SearchChar then
      begin
        Result := (PWalk - PStart) + 12;
        Exit;
      end;
      if PWalk[10] = SearchChar then
      begin
        Result := (PWalk - PStart) + 11;
        Exit;
      end;
      if PWalk[9] = SearchChar then
      begin
        Result := (PWalk - PStart) + 10;
        Exit;
      end;
      if PWalk[8] = SearchChar then
      begin
        Result := (PWalk - PStart) + 9;
        Exit;
      end;
      if PWalk[7] = SearchChar then
      begin
        Result := (PWalk - PStart) + 8;
        Exit;
      end;
      if PWalk[6] = SearchChar then
      begin
        Result := (PWalk - PStart) + 7;
        Exit;
      end;
      if PWalk[5] = SearchChar then
      begin
        Result := (PWalk - PStart) + 6;
        Exit;
      end;
      if PWalk[4] = SearchChar then
      begin
        Result := (PWalk - PStart) + 5;
        Exit;
      end;
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 16);
    end;
    case (PStart - PWalk) of
      0: goto c16;
      1: goto c15;
      2: goto c14;
      3: goto c13;
      4: goto c12;
      5: goto c11;
      6: goto c10;
      7: goto c9;
      8: goto c8;
      9: goto c7;
      10: goto c6;
      11: goto c5;
      12: goto c4;
      13: goto c3;
      14: goto c2;
      15: goto c1;
      16: goto c0;
    end;
    c16:
    if PStart[15] = SearchChar then
    begin
      Result := 16;
      Exit;
    end;
    c15:
    if PStart[14] = SearchChar then
    begin
      Result := 15;
      Exit;
    end;
    c14:
    if PStart[13] = SearchChar then
    begin
      Result := 14;
      Exit;
    end;
    c13:
    if PStart[12] = SearchChar then
    begin
      Result := 13;
      Exit;
    end;
    c12:
    if PStart[11] = SearchChar then
    begin
      Result := 12;
      Exit;
    end;
    c11:
    if PStart[10] = SearchChar then
    begin
      Result := 11;
      Exit;
    end;
    c10:
    if PStart[9] = SearchChar then
    begin
      Result := 10;
      Exit;
    end;
    c9:
    if PStart[8] = SearchChar then
    begin
      Result := 9;
      Exit;
    end;
    c8:
    if PStart[7] = SearchChar then
    begin
      Result := 8;
      Exit;
    end;
    c7:
    if PStart[6] = SearchChar then
    begin
      Result := 7;
      Exit;
    end;
    c6:
    if PStart[5] = SearchChar then
    begin
      Result := 6;
      Exit;
    end;
    c5:
    if PStart[4] = SearchChar then
    begin
      Result := 5;
      Exit;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

function CharPosRev_DLA_PAS_20_a(SearchChar: Char; const S: string): Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4, c5, c6, c7, c8;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 8);
    while PWalk >= PStart do
    begin
      if PWalk[7] = SearchChar then
      begin
        Result := (PWalk - PStart) + 8;
        Exit;
      end;
      if PWalk[6] = SearchChar then
      begin
        Result := (PWalk - PStart) + 7;
        Exit;
      end;
      if PWalk[5] = SearchChar then
      begin
        Result := (PWalk - PStart) + 6;
        Exit;
      end;
      if PWalk[4] = SearchChar then
      begin
        Result := (PWalk - PStart) + 5;
        Exit;
      end;
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 8);
    end;
    case (PStart - PWalk) of
      0: goto c8;
      1: goto c7;
      2: goto c6;
      3: goto c5;
      4: goto c4;
      5: goto c3;
      6: goto c2;
      7: goto c1;
      8: goto c0;
    end;
    c8:
    if PStart[7] = SearchChar then
    begin
      Result := 8;
      Exit;
    end;
    c7:
    if PStart[6] = SearchChar then
    begin
      Result := 7;
      Exit;
    end;
    c6:
    if PStart[5] = SearchChar then
    begin
      Result := 6;
      Exit;
    end;
    c5:
    if PStart[4] = SearchChar then
    begin
      Result := 5;
      Exit;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

function CharPosRev_DLA_PAS_20_b(SearchChar: Char; const S: string): Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4, c5, c6, c7, c8;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 8);
    while PWalk >= PStart do
    begin
      if PWalk[7] = SearchChar then
      begin
        Result := (PWalk - PStart) + 8;
        Exit;
      end;
      if PWalk[6] = SearchChar then
      begin
        Result := (PWalk - PStart) + 7;
        Exit;
      end;
      if PWalk[5] = SearchChar then
      begin
        Result := (PWalk - PStart) + 6;
        Exit;
      end;
      if PWalk[4] = SearchChar then
      begin
        Result := (PWalk - PStart) + 5;
        Exit;
      end;
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 8);
    end;
    case (PStart - PWalk) of
      0: goto c8;
      1: goto c7;
      2: goto c6;
      3: goto c5;
      4: goto c4;
      5: goto c3;
      6: goto c2;
      7: goto c1;
      8: goto c0;
    end;
    c8:
    if PStart[7] = SearchChar then
    begin
      Result := 8;
      Exit;
    end;
    c7:
    if PStart[6] = SearchChar then
    begin
      Result := 7;
      Exit;
    end;
    c6:
    if PStart[5] = SearchChar then
    begin
      Result := 6;
      Exit;
    end;
    c5:
    if PStart[4] = SearchChar then
    begin
      Result := 5;
      Exit;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

function CharPosRev_DLA_PAS_20_c(SearchChar: Char; const S: string): Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4, c5, c6, c7, c8;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 8);
    while PWalk >= PStart do
    begin
      if PWalk[7] = SearchChar then
      begin
        Result := (PWalk - PStart) + 8;
        Exit;
      end;
      if PWalk[6] = SearchChar then
      begin
        Result := (PWalk - PStart) + 7;
        Exit;
      end;
      if PWalk[5] = SearchChar then
      begin
        Result := (PWalk - PStart) + 6;
        Exit;
      end;
      if PWalk[4] = SearchChar then
      begin
        Result := (PWalk - PStart) + 5;
        Exit;
      end;
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 8);
    end;
    case (PStart - PWalk) of
      0: goto c8;
      1: goto c7;
      2: goto c6;
      3: goto c5;
      4: goto c4;
      5: goto c3;
      6: goto c2;
      7: goto c1;
      8: goto c0;
    end;
    c8:
    if PStart[7] = SearchChar then
    begin
      Result := 8;
      Exit;
    end;
    c7:
    if PStart[6] = SearchChar then
    begin
      Result := 7;
      Exit;
    end;
    c6:
    if PStart[5] = SearchChar then
    begin
      Result := 6;
      Exit;
    end;
    c5:
    if PStart[4] = SearchChar then
    begin
      Result := 5;
      Exit;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

function CharPosRev_DLA_PAS_20_d(SearchChar: Char; const S: string): Integer;
var
  PStart, PWalk: PChar;
  StrLength: Integer;
label
  c0, c1, c2, c3, c4, c5, c6, c7, c8;
begin
  StrLength := Length(S);
  if StrLength > 0 then
  begin
    PStart := Pointer(S);
    PWalk := Pointer((Cardinal(S) + Cardinal(StrLength)) - 8);
    while PWalk >= PStart do
    begin
      if PWalk[7] = SearchChar then
      begin
        Result := (PWalk - PStart) + 8;
        Exit;
      end;
      if PWalk[6] = SearchChar then
      begin
        Result := (PWalk - PStart) + 7;
        Exit;
      end;
      if PWalk[5] = SearchChar then
      begin
        Result := (PWalk - PStart) + 6;
        Exit;
      end;
      if PWalk[4] = SearchChar then
      begin
        Result := (PWalk - PStart) + 5;
        Exit;
      end;
      if PWalk[3] = SearchChar then
      begin
        Result := (PWalk - PStart) + 4;
        Exit;
      end;
      if PWalk[2] = SearchChar then
      begin
        Result := (PWalk - PStart) + 3;
        Exit;
      end;
      if PWalk[1] = SearchChar then
      begin
        Result := (PWalk - PStart) + 2;
        Exit;
      end;
      if PWalk[0] = SearchChar then
      begin
        Result := (PWalk - PStart) + 1;
        Exit;
      end;
      Dec(PWalk, 8);
    end;
    case (PStart - PWalk) of
      0: goto c8;
      1: goto c7;
      2: goto c6;
      3: goto c5;
      4: goto c4;
      5: goto c3;
      6: goto c2;
      7: goto c1;
      8: goto c0;
    end;
    c8:
    if PStart[7] = SearchChar then
    begin
      Result := 8;
      Exit;
    end;
    c7:
    if PStart[6] = SearchChar then
    begin
      Result := 7;
      Exit;
    end;
    c6:
    if PStart[5] = SearchChar then
    begin
      Result := 6;
      Exit;
    end;
    c5:
    if PStart[4] = SearchChar then
    begin
      Result := 5;
      Exit;
    end;
    c4:
    if PStart[3] = SearchChar then
    begin
      Result := 4;
      Exit;
    end;
    c3:
    if PStart[2] = SearchChar then
    begin
      Result := 3;
      Exit;
    end;
    c2:
    if PStart[1] = SearchChar then
    begin
      Result := 2;
      Exit;
    end;
    c1:
    if PStart[0] = SearchChar then
    begin
      Result := 1;
      Exit;
    end;
  end;
  c0:
  Result := 0;
end;

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
// MainForm.RegisterFunction('CharPosRev_DLA_Pas_1_a', @CharPosRev_DLA_Pas_1_a);
// MainForm.RegisterFunction('CharPosRev_DLA_Pas_1_b', @CharPosRev_DLA_Pas_1_b);
// MainForm.RegisterFunction('CharPosRev_DLA_Pas_1_c', @CharPosRev_DLA_Pas_1_c);
// MainForm.RegisterFunction('CharPosRev_DLA_Pas_1_d', @CharPosRev_DLA_Pas_1_d);
// MainForm.RegisterFunction('CharPosRev_DLA_Pas_2_a', @CharPosRev_DLA_Pas_2_a);
// MainForm.RegisterFunction('CharPosRev_DLA_Pas_2_b', @CharPosRev_DLA_Pas_2_b);
// MainForm.RegisterFunction('CharPosRev_DLA_Pas_2_c', @CharPosRev_DLA_Pas_2_c);
// MainForm.RegisterFunction('CharPosRev_DLA_Pas_2_d', @CharPosRev_DLA_Pas_2_d);
// MainForm.RegisterFunction('CharPosRev_DLA_Pas_4_a', @CharPosRev_DLA_Pas_4_a);
// MainForm.RegisterFunction('CharPosRev_DLA_Pas_4_b', @CharPosRev_DLA_Pas_4_b);
// MainForm.RegisterFunction('CharPosRev_DLA_Pas_4_c', @CharPosRev_DLA_Pas_4_c);
// MainForm.RegisterFunction('CharPosRev_DLA_Pas_4_d', @CharPosRev_DLA_Pas_4_d);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_5_a', @CharPosRev_DLA_Pas_5_a);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_5_b', @CharPosRev_DLA_Pas_5_b);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_5_c', @CharPosRev_DLA_Pas_5_c);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_5_d', @CharPosRev_DLA_Pas_5_d);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_14_a', @CharPosRev_DLA_Pas_14_a);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_14_b', @CharPosRev_DLA_Pas_14_b);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_14_c', @CharPosRev_DLA_Pas_14_c);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_14_d', @CharPosRev_DLA_Pas_14_d);
// MainForm.RegisterFunction('CharPosRev_DLA_Pas_15_a', @CharPosRev_DLA_Pas_15_a);
// MainForm.RegisterFunction('CharPosRev_DLA_Pas_15_b', @CharPosRev_DLA_Pas_15_b);
// MainForm.RegisterFunction('CharPosRev_DLA_Pas_15_c', @CharPosRev_DLA_Pas_15_c);
// MainForm.RegisterFunction('CharPosRev_DLA_Pas_15_d', @CharPosRev_DLA_Pas_15_d);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_16_a', @CharPosRev_DLA_Pas_16_a);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_16_b', @CharPosRev_DLA_Pas_16_b);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_16_c', @CharPosRev_DLA_Pas_16_c);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_16_d', @CharPosRev_DLA_Pas_16_d);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_19_a', @CharPosRev_DLA_Pas_19_a);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_19_b', @CharPosRev_DLA_Pas_19_b);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_19_c', @CharPosRev_DLA_Pas_19_c);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_19_d', @CharPosRev_DLA_Pas_19_d);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_20_a', @CharPosRev_DLA_Pas_20_a);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_20_b', @CharPosRev_DLA_Pas_20_b);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_20_c', @CharPosRev_DLA_Pas_20_c);
 MainForm.RegisterFunction('CharPosRev_DLA_Pas_20_d', @CharPosRev_DLA_Pas_20_d);

end.
