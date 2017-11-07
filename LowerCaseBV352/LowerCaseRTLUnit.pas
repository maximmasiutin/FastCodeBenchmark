unit LowerCaseRTLUnit;

interface

function LowerCase_RTL_PAS_1_a(const S: string): string;
function LowerCase_RTL_PAS_1_b(const S: string): string;
function LowerCase_RTL_PAS_1_c(const S: string): string;
function LowerCase_RTL_PAS_1_d(const S: string): string;

function LowerCase_LBG_Pas_1_a(const S: string): string;
function LowerCase_LBG_Pas_1_b(const S: string): string;
function LowerCase_LBG_Pas_1_c(const S: string): string;
function LowerCase_LBG_Pas_1_d(const S: string): string;

implementation

function LowerCase_RTL_PAS_1_a(const S: string): string;
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
    if (Ch >= 'A') and (Ch <= 'Z') then Inc(Ch, 32);
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

function LowerCase_RTL_PAS_1_b(const S: string): string;
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
    if (Ch >= 'A') and (Ch <= 'Z') then Inc(Ch, 32);
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

function LowerCase_RTL_PAS_1_c(const S: string): string;
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
    if (Ch >= 'A') and (Ch <= 'Z') then Inc(Ch, 32);
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


function LowerCase_RTL_PAS_1_d(const S: string): string;
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
    if (Ch >= 'A') and (Ch <= 'Z') then Inc(Ch, 32);
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

function LowerCase_LBG_Pas_1_a(const S: string): string;
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
  if (S[CharNo+a] >= 'A') and (S[CharNo+a] <= 'Z') then
   pResult[CharNo] := char(Ord(S[CharNo+a]) + 32);
  Inc(CharNo);
 until(CharNo >= Max);
end; 

(*
  Author:            Lars Bloch Gravengaard
  Date:              25/11 2006
  Instructionset(s): PAS
  Function size      79 bytes
*)

function LowerCase_LBG_Pas_1_b(const S: string): string;
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
  if (S[CharNo+a] >= 'A') and (S[CharNo+a] <= 'Z') then
   pResult[CharNo] := char(Ord(S[CharNo+a]) + 32);
  Inc(CharNo);
 until(CharNo >= Max);
end;

(*
  Author:            Lars Bloch Gravengaard
  Date:              25/11 2006
  Instructionset(s): PAS
  Function size      79 bytes
*)

function LowerCase_LBG_Pas_1_c(const S: string): string;
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
  if (S[CharNo+a] >= 'A') and (S[CharNo+a] <= 'Z') then
   pResult[CharNo] := char(Ord(S[CharNo+a]) + 32);
  Inc(CharNo);
 until(CharNo >= Max);
end;

(*
  Author:            Lars Bloch Gravengaard
  Date:              25/11 2006
  Instructionset(s): PAS
  Function size      79 bytes
*)

function LowerCase_LBG_Pas_1_d(const S: string): string;
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
  if (S[CharNo+a] >= 'A') and (S[CharNo+a] <= 'Z') then
   pResult[CharNo] := char(Ord(S[CharNo+a]) + 32);
  Inc(CharNo);
 until(CharNo >= Max);
end;



initialization

 Filler1;
 Filler2;
 Filler3;

end.

