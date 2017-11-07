unit UpperCaseRTLUnit;

interface

function UpperCase_RTL_PAS_a(const S: string): string;
function UpperCase_RTL_PAS_b(const S: string): string;
function UpperCase_RTL_PAS_c(const S: string): string;
function UpperCase_RTL_PAS_d(const S: string): string;

function UpperCase_LBG_Pas_1_a(const S: string): string;
function UpperCase_LBG_Pas_1_b(const S: string): string;
function UpperCase_LBG_Pas_1_c(const S: string): string;
function UpperCase_LBG_Pas_1_d(const S: string): string;

function UpperCase_LBG_Pas_2_a(const S: string): string;
function UpperCase_LBG_Pas_2_b(const S: string): string;
function UpperCase_LBG_Pas_2_c(const S: string): string;
function UpperCase_LBG_Pas_2_d(const S: string): string;

function UpperCase_LBG_Pas_3_a(const S: string): string;
function UpperCase_LBG_Pas_3_b(const S: string): string;
function UpperCase_LBG_Pas_3_c(const S: string): string;
function UpperCase_LBG_Pas_3_d(const S: string): string;


implementation

function UpperCase_RTL_PAS_a(const S: string): string;
var
  Ch: Char;
  L: Integer;
  Source, Dest: PChar;
begin
  L := Length(S);
  SetLength(Result, L);
  Source := Pointer(S);
  Dest := Pointer(Result);
  while L <> 0 do
  begin
    Ch := Source^;
    if (Ch >= 'a') and (Ch <= 'z') then Dec(Ch, 32);
    Dest^ := Ch;
    Inc(Source);
    Inc(Dest);
    Dec(L);
  end;
end;

procedure Filler1;
asm
 nop
end;

function UpperCase_RTL_PAS_b(const S: string): string;
var
  Ch: Char;
  L: Integer;
  Source, Dest: PChar;
begin
  L := Length(S);
  SetLength(Result, L);
  Source := Pointer(S);
  Dest := Pointer(Result);
  while L <> 0 do
  begin
    Ch := Source^;
    if (Ch >= 'a') and (Ch <= 'z') then Dec(Ch, 32);
    Dest^ := Ch;
    Inc(Source);
    Inc(Dest);
    Dec(L);
  end;
end;

procedure Filler2;
asm
 nop
end;

function UpperCase_RTL_PAS_c(const S: string): string;
var
  Ch: Char;
  L: Integer;
  Source, Dest: PChar;
begin
  L := Length(S);
  SetLength(Result, L);
  Source := Pointer(S);
  Dest := Pointer(Result);
  while L <> 0 do
  begin
    Ch := Source^;
    if (Ch >= 'a') and (Ch <= 'z') then Dec(Ch, 32);
    Dest^ := Ch;
    Inc(Source);
    Inc(Dest);
    Dec(L);
  end;
end;

procedure Filler3;
asm
 nop
end;

function UpperCase_RTL_PAS_d(const S: string): string;
var
  Ch: Char;
  L: Integer;
  Source, Dest: PChar;
begin
  L := Length(S);
  SetLength(Result, L);
  Source := Pointer(S);
  Dest := Pointer(Result);
  while L <> 0 do
  begin
    Ch := Source^;
    if (Ch >= 'a') and (Ch <= 'z') then Dec(Ch, 32);
    Dest^ := Ch;
    Inc(Source);
    Inc(Dest);
    Dec(L);
  end;
end;



(*
  Author:            Lars Bloch Gravengaard
  Date:              25/11 2006
  Instructionset(s): PAS
  Function size      79 bytes
*)

function UpperCase_LBG_Pas_1_a(const S: string): string;
const a=1;
var
 Max, CharNo : Cardinal;
 pResult : PChar;
begin
 Max := Length(S);
 SetLength(Result, Max);
 if Max <= 0 then exit;
 pResult := PChar(Result);
 CharNo := 0;
 repeat
  pResult[CharNo] := S[CharNo+a];
  if (S[CharNo+a] >= 'a') and (S[CharNo+a] <= 'z') then
   pResult[CharNo] := char(Ord(S[CharNo+a]) - 32);
  Inc(CharNo);
 until(CharNo >= Max);
end;

procedure Filler5;
asm
 nop
end;


function UpperCase_LBG_Pas_1_b(const S: string): string;
const a=1;
var
 Max, CharNo : Cardinal;
 pResult : PChar;
begin
 Max := Length(S);
 SetLength(Result, Max);
 if Max <= 0 then exit;
 pResult := PChar(Result);
 CharNo := 0;
 repeat
  pResult[CharNo] := S[CharNo+a];
  if (S[CharNo+a] >= 'a') and (S[CharNo+a] <= 'z') then
   pResult[CharNo] := char(Ord(S[CharNo+a]) - 32);
  Inc(CharNo);
 until(CharNo >= Max);
end;

procedure Filler6;
asm
 nop
end;


function UpperCase_LBG_Pas_1_c(const S: string): string;
const a=1;
var
 Max, CharNo : Cardinal;
 pResult : PChar;
begin
 Max := Length(S);
 SetLength(Result, Max);
 if Max <= 0 then exit;
 pResult := PChar(Result);
 CharNo := 0;
 repeat
  pResult[CharNo] := S[CharNo+a];
  if (S[CharNo+a] >= 'a') and (S[CharNo+a] <= 'z') then
   pResult[CharNo] := char(Ord(S[CharNo+a]) - 32);
  Inc(CharNo);
 until(CharNo >= Max);
end;

procedure Filler7;
asm
 nop
end;


function UpperCase_LBG_Pas_1_d(const S: string): string;
const a=1;
var
 Max, CharNo : Cardinal;
 pResult : PChar;
begin
 Max := Length(S);
 SetLength(Result, Max);
 if Max <= 0 then exit;
 pResult := PChar(Result);
 CharNo := 0;
 repeat
  pResult[CharNo] := S[CharNo+a];
  if (S[CharNo+a] >= 'a') and (S[CharNo+a] <= 'z') then
   pResult[CharNo] := char(Ord(S[CharNo+a]) - 32);
  Inc(CharNo);
 until(CharNo >= Max);
end;

(*
  Author:            Lars Bloch Gravengaard
  Date:              27/11 2006
  Instructionset(s): PAS
  Function size      72 bytes
*)
function UpperCase_LBG_Pas_2_a(const S: string): string;
const a=1;
var
 Max, CharNo : Cardinal;
 pResult : PChar;
begin
 Max := Length(S);
 SetLength(Result, Max);
 if Max <= 0 then exit;
 pResult := pointer(Result);
 CharNo := 0;
 repeat
  pResult[CharNo] := S[CharNo+a];
  if (S[CharNo+a] >= 'a') and (S[CharNo+a] <= 'z') then
   pResult[CharNo] := char(Ord(S[CharNo+a]) - 32);
  Inc(CharNo);
 until(CharNo >= Max);
end;

(*
  Author:            Lars Bloch Gravengaard
  Date:              27/11 2006
  Instructionset(s): PAS
  Function size      72 bytes
*)
function UpperCase_LBG_Pas_2_b(const S: string): string;
const a=1;
var
 Max, CharNo : Cardinal;
 pResult : PChar;
begin
 Max := Length(S);
 SetLength(Result, Max);
 if Max <= 0 then exit;
 pResult := pointer(Result);
 CharNo := 0;
 repeat
  pResult[CharNo] := S[CharNo+a];
  if (S[CharNo+a] >= 'a') and (S[CharNo+a] <= 'z') then
   pResult[CharNo] := char(Ord(S[CharNo+a]) - 32);
  Inc(CharNo);
 until(CharNo >= Max);
end;

(*
  Author:            Lars Bloch Gravengaard
  Date:              27/11 2006
  Instructionset(s): PAS
  Function size      72 bytes
*)
function UpperCase_LBG_Pas_2_c(const S: string): string;
const a=1;
var
 Max, CharNo : Cardinal;
 pResult : PChar;
begin
 Max := Length(S);
 SetLength(Result, Max);
 if Max <= 0 then exit;
 pResult := pointer(Result);
 CharNo := 0;
 repeat
  pResult[CharNo] := S[CharNo+a];
  if (S[CharNo+a] >= 'a') and (S[CharNo+a] <= 'z') then
   pResult[CharNo] := char(Ord(S[CharNo+a]) - 32);
  Inc(CharNo);
 until(CharNo >= Max);
end;

(*
  Author:            Lars Bloch Gravengaard
  Date:              27/11 2006
  Instructionset(s): PAS
  Function size      72 bytes
*)
function UpperCase_LBG_Pas_2_d(const S: string): string;
const a=1;
var
 Max, CharNo : Cardinal;
 pResult : PChar;
begin
 Max := Length(S);
 SetLength(Result, Max);
 if Max <= 0 then exit;
 pResult := pointer(Result);
 CharNo := 0;
 repeat
  pResult[CharNo] := S[CharNo+a];
  if (S[CharNo+a] >= 'a') and (S[CharNo+a] <= 'z') then
   pResult[CharNo] := char(Ord(S[CharNo+a]) - 32);
  Inc(CharNo);
 until(CharNo >= Max);
end;

(*
  Author:            Lars Bloch Gravengaard
  Date:              27/11 2006
  Instructionset(s): PAS
  Function size      75
*)
function UpperCase_LBG_Pas_3_a(const S: string): string;
const a=1;
var
 Max, CharNo : Cardinal;
 pResult : PChar;
begin
 Max := Length(S);
 SetLength(Result, Max);
 if Max <= 0 then exit;
 pResult := pointer(Result);
 CharNo := 0;
 repeat
  pResult[CharNo] := S[CharNo+a];
  if (S[CharNo+a] in ['a'..'z']) then
   pResult[CharNo] := char(Ord(S[CharNo+a]) - 32);
  Inc(CharNo);
 until(CharNo >= Max);
end;

procedure Filler8;
asm
 nop
end;



(*
  Author:            Lars Bloch Gravengaard
  Date:              27/11 2006
  Instructionset(s): PAS
  Function size      75
*)
function UpperCase_LBG_Pas_3_b(const S: string): string;
const a=1;
var
 Max, CharNo : Cardinal;
 pResult : PChar;
begin
 Max := Length(S);
 SetLength(Result, Max);
 if Max <= 0 then exit;
 pResult := pointer(Result);
 CharNo := 0;
 repeat
  pResult[CharNo] := S[CharNo+a];
  if (S[CharNo+a] in ['a'..'z']) then
   pResult[CharNo] := char(Ord(S[CharNo+a]) - 32);
  Inc(CharNo);
 until(CharNo >= Max);
end;

procedure Filler9;
asm
 nop
end;


(*
  Author:            Lars Bloch Gravengaard
  Date:              27/11 2006
  Instructionset(s): PAS
  Function size      75
*)
function UpperCase_LBG_Pas_3_c(const S: string): string;
const a=1;
var
 Max, CharNo : Cardinal;
 pResult : PChar;
begin
 Max := Length(S);
 SetLength(Result, Max);
 if Max <= 0 then exit;
 pResult := pointer(Result);
 CharNo := 0;
 repeat
  pResult[CharNo] := S[CharNo+a];
  if (S[CharNo+a] in ['a'..'z']) then
   pResult[CharNo] := char(Ord(S[CharNo+a]) - 32);
  Inc(CharNo);
 until(CharNo >= Max);
end;

procedure Filler10;
asm
 nop
end;



(*
  Author:            Lars Bloch Gravengaard
  Date:              27/11 2006
  Instructionset(s): PAS
  Function size      75
*)
function UpperCase_LBG_Pas_3_d(const S: string): string;
const a=1;
var
 Max, CharNo : Cardinal;
 pResult : PChar;
begin
 Max := Length(S);
 SetLength(Result, Max);
 if Max <= 0 then exit;
 pResult := pointer(Result);
 CharNo := 0;
 repeat
  pResult[CharNo] := S[CharNo+a];
  if (S[CharNo+a] in ['a'..'z']) then
   pResult[CharNo] := char(Ord(S[CharNo+a]) - 32);
  Inc(CharNo);
 until(CharNo >= Max);
end;




initialization

  Filler1;
  Filler2;
  Filler3;

  Filler5;
  Filler6;
  Filler7;
  Filler8;
  Filler9;
  Filler10;

end.
