unit CharPosJOHUnit;

interface

function CharPos_JOH_Pas_1_a (Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_Pas_1_b (Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_Pas_1_c (Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_Pas_1_d (Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_Pas_2_a(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_Pas_2_b(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_Pas_2_c(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_Pas_2_d(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_IA32_1_a(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_IA32_1_b(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_IA32_1_c(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_IA32_1_d(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_MMX_1_a (Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_MMX_1_b (Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_MMX_1_c (Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_MMX_1_d (Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_SSE_1_a (Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_SSE_1_b (Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_SSE_1_c (Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_SSE_1_d (Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_SSE2_1_a(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_SSE2_1_b(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_SSE2_1_c(Ch : Char; const Str : AnsiString) : Integer;
function CharPos_JOH_SSE2_1_d(Ch : Char; const Str : AnsiString) : Integer;

implementation

uses
  Windows, Graphics, Classes, SysUtils, Math;

function CharPos_JOH_Pas_1_a(Ch : Char; const Str : AnsiString) : Integer;
var
  Len, Remainder     : Integer;
  P, PEnd, PBlockEnd : PChar;
label

Ck00,Ck01,Ck02,Ck03,Ck04,Ck05,Ck06,Ck07,Ck08,Ck09,Ck10,Ck11,Ck12,Ck13,Ck14;
begin
   if Str <> '' then
     begin
       P         := Pointer(Str);
       Len       := Length(Str);
       PEnd      := P + Len;
       Result    := 1 - Integer(P);
       PBlockEnd := PEnd - 16;
       if (P <= PBlockEnd) then
         repeat
           if Ch = P^    then begin Inc(Result, Integer(P)     ); Exit; end;
           if Ch = p[ 1] then begin Inc(Result, Integer(P) +  1); Exit; end;
           if Ch = P[ 2] then begin Inc(Result, Integer(P) +  2); Exit; end;
           if Ch = P[ 3] then begin Inc(Result, Integer(P) +  3); Exit; end;
           if Ch = P[ 4] then begin Inc(Result, Integer(P) +  4); Exit; end;
           if Ch = P[ 5] then begin Inc(Result, Integer(P) +  5); Exit; end;
           if Ch = P[ 6] then begin Inc(Result, Integer(P) +  6); Exit; end;
           if Ch = P[ 7] then begin Inc(Result, Integer(P) +  7); Exit; end;
           if Ch = P[ 8] then begin Inc(Result, Integer(P) +  8); Exit; end;
           if Ch = P[ 9] then begin Inc(Result, Integer(P) +  9); Exit; end;
           if Ch = P[10] then begin Inc(Result, Integer(P) + 10); Exit; end;
           if Ch = P[11] then begin Inc(Result, Integer(P) + 11); Exit; end;
           if Ch = P[12] then begin Inc(Result, Integer(P) + 12); Exit; end;
           if Ch = P[13] then begin Inc(Result, Integer(P) + 13); Exit; end;
           if Ch = P[14] then begin Inc(Result, Integer(P) + 14); Exit; end;
           if Ch = P[15] then begin Inc(Result, Integer(P) + 15); Exit; end;
           Inc(P, 16);
         until P > PBlockEnd;
       Result    := Len - 14;
       Remainder := PEnd - P; {0..15}
       Inc(P, Remainder);
       case Remainder of
          0 : goto Ck00;
          1 : goto Ck01;
          2 : goto Ck02;
          3 : goto Ck03;
          4 : goto Ck04;
          5 : goto Ck05;
          6 : goto Ck06;
          7 : goto Ck07;
          8 : goto Ck08;
          9 : goto Ck09;
         10 : goto Ck10;
         11 : goto Ck11;
         12 : goto Ck12;
         13 : goto Ck13;
         14 : goto Ck14;
       end;
       if Ch<> P[-15] then
Ck14:  if Ch = P[-14] then begin Inc(Result,  1) end else
Ck13:  if Ch = P[-13] then begin Inc(Result,  2) end else
Ck12:  if Ch = P[-12] then begin Inc(Result,  3) end else
Ck11:  if Ch = P[-11] then begin Inc(Result,  4) end else
Ck10:  if Ch = P[-10] then begin Inc(Result,  5) end else
Ck09:  if Ch = P[ -9] then begin Inc(Result,  6) end else
Ck08:  if Ch = P[ -8] then begin Inc(Result,  7) end else
Ck07:  if Ch = P[ -7] then begin Inc(Result,  8) end else
Ck06:  if Ch = P[ -6] then begin Inc(Result,  9) end else
Ck05:  if Ch = P[ -5] then begin Inc(Result, 10) end else
Ck04:  if Ch = P[ -4] then begin Inc(Result, 11) end else
Ck03:  if Ch = P[ -3] then begin Inc(Result, 12) end else
Ck02:  if Ch = P[ -2] then begin Inc(Result, 13) end else
Ck01:  if Ch = P[ -1] then begin Inc(Result, 14) end else
Ck00:  Result := 0;
     end
   else
     Result := 0;
end;

procedure Filler5;
asm
 nop
end;

function CharPos_JOH_Pas_1_b(Ch : Char; const Str : AnsiString) : Integer;
var
  Len, Remainder     : Integer;
  P, PEnd, PBlockEnd : PChar;
label

Ck00,Ck01,Ck02,Ck03,Ck04,Ck05,Ck06,Ck07,Ck08,Ck09,Ck10,Ck11,Ck12,Ck13,Ck14;
begin
   if Str <> '' then
     begin
       P         := Pointer(Str);
       Len       := Length(Str);
       PEnd      := P + Len;
       Result    := 1 - Integer(P);
       PBlockEnd := PEnd - 16;
       if (P <= PBlockEnd) then
         repeat
           if Ch = P^    then begin Inc(Result, Integer(P)     ); Exit; end;
           if Ch = p[ 1] then begin Inc(Result, Integer(P) +  1); Exit; end;
           if Ch = P[ 2] then begin Inc(Result, Integer(P) +  2); Exit; end;
           if Ch = P[ 3] then begin Inc(Result, Integer(P) +  3); Exit; end;
           if Ch = P[ 4] then begin Inc(Result, Integer(P) +  4); Exit; end;
           if Ch = P[ 5] then begin Inc(Result, Integer(P) +  5); Exit; end;
           if Ch = P[ 6] then begin Inc(Result, Integer(P) +  6); Exit; end;
           if Ch = P[ 7] then begin Inc(Result, Integer(P) +  7); Exit; end;
           if Ch = P[ 8] then begin Inc(Result, Integer(P) +  8); Exit; end;
           if Ch = P[ 9] then begin Inc(Result, Integer(P) +  9); Exit; end;
           if Ch = P[10] then begin Inc(Result, Integer(P) + 10); Exit; end;
           if Ch = P[11] then begin Inc(Result, Integer(P) + 11); Exit; end;
           if Ch = P[12] then begin Inc(Result, Integer(P) + 12); Exit; end;
           if Ch = P[13] then begin Inc(Result, Integer(P) + 13); Exit; end;
           if Ch = P[14] then begin Inc(Result, Integer(P) + 14); Exit; end;
           if Ch = P[15] then begin Inc(Result, Integer(P) + 15); Exit; end;
           Inc(P, 16);
         until P > PBlockEnd;
       Result    := Len - 14;
       Remainder := PEnd - P; {0..15}
       Inc(P, Remainder);
       case Remainder of
          0 : goto Ck00;
          1 : goto Ck01;
          2 : goto Ck02;
          3 : goto Ck03;
          4 : goto Ck04;
          5 : goto Ck05;
          6 : goto Ck06;
          7 : goto Ck07;
          8 : goto Ck08;
          9 : goto Ck09;
         10 : goto Ck10;
         11 : goto Ck11;
         12 : goto Ck12;
         13 : goto Ck13;
         14 : goto Ck14;
       end;
       if Ch<> P[-15] then
Ck14:  if Ch = P[-14] then begin Inc(Result,  1) end else
Ck13:  if Ch = P[-13] then begin Inc(Result,  2) end else
Ck12:  if Ch = P[-12] then begin Inc(Result,  3) end else
Ck11:  if Ch = P[-11] then begin Inc(Result,  4) end else
Ck10:  if Ch = P[-10] then begin Inc(Result,  5) end else
Ck09:  if Ch = P[ -9] then begin Inc(Result,  6) end else
Ck08:  if Ch = P[ -8] then begin Inc(Result,  7) end else
Ck07:  if Ch = P[ -7] then begin Inc(Result,  8) end else
Ck06:  if Ch = P[ -6] then begin Inc(Result,  9) end else
Ck05:  if Ch = P[ -5] then begin Inc(Result, 10) end else
Ck04:  if Ch = P[ -4] then begin Inc(Result, 11) end else
Ck03:  if Ch = P[ -3] then begin Inc(Result, 12) end else
Ck02:  if Ch = P[ -2] then begin Inc(Result, 13) end else
Ck01:  if Ch = P[ -1] then begin Inc(Result, 14) end else
Ck00:  Result := 0;
     end
   else
     Result := 0;
end;

procedure Filler6;
asm
 nop
end;

function CharPos_JOH_Pas_1_c(Ch : Char; const Str : AnsiString) : Integer;
var
  Len, Remainder     : Integer;
  P, PEnd, PBlockEnd : PChar;
label

Ck00,Ck01,Ck02,Ck03,Ck04,Ck05,Ck06,Ck07,Ck08,Ck09,Ck10,Ck11,Ck12,Ck13,Ck14;
begin
   if Str <> '' then
     begin
       P         := Pointer(Str);
       Len       := Length(Str);
       PEnd      := P + Len;
       Result    := 1 - Integer(P);
       PBlockEnd := PEnd - 16;
       if (P <= PBlockEnd) then
         repeat
           if Ch = P^    then begin Inc(Result, Integer(P)     ); Exit; end;
           if Ch = p[ 1] then begin Inc(Result, Integer(P) +  1); Exit; end;
           if Ch = P[ 2] then begin Inc(Result, Integer(P) +  2); Exit; end;
           if Ch = P[ 3] then begin Inc(Result, Integer(P) +  3); Exit; end;
           if Ch = P[ 4] then begin Inc(Result, Integer(P) +  4); Exit; end;
           if Ch = P[ 5] then begin Inc(Result, Integer(P) +  5); Exit; end;
           if Ch = P[ 6] then begin Inc(Result, Integer(P) +  6); Exit; end;
           if Ch = P[ 7] then begin Inc(Result, Integer(P) +  7); Exit; end;
           if Ch = P[ 8] then begin Inc(Result, Integer(P) +  8); Exit; end;
           if Ch = P[ 9] then begin Inc(Result, Integer(P) +  9); Exit; end;
           if Ch = P[10] then begin Inc(Result, Integer(P) + 10); Exit; end;
           if Ch = P[11] then begin Inc(Result, Integer(P) + 11); Exit; end;
           if Ch = P[12] then begin Inc(Result, Integer(P) + 12); Exit; end;
           if Ch = P[13] then begin Inc(Result, Integer(P) + 13); Exit; end;
           if Ch = P[14] then begin Inc(Result, Integer(P) + 14); Exit; end;
           if Ch = P[15] then begin Inc(Result, Integer(P) + 15); Exit; end;
           Inc(P, 16);
         until P > PBlockEnd;
       Result    := Len - 14;
       Remainder := PEnd - P; {0..15}
       Inc(P, Remainder);
       case Remainder of
          0 : goto Ck00;
          1 : goto Ck01;
          2 : goto Ck02;
          3 : goto Ck03;
          4 : goto Ck04;
          5 : goto Ck05;
          6 : goto Ck06;
          7 : goto Ck07;
          8 : goto Ck08;
          9 : goto Ck09;
         10 : goto Ck10;
         11 : goto Ck11;
         12 : goto Ck12;
         13 : goto Ck13;
         14 : goto Ck14;
       end;
       if Ch<> P[-15] then
Ck14:  if Ch = P[-14] then begin Inc(Result,  1) end else
Ck13:  if Ch = P[-13] then begin Inc(Result,  2) end else
Ck12:  if Ch = P[-12] then begin Inc(Result,  3) end else
Ck11:  if Ch = P[-11] then begin Inc(Result,  4) end else
Ck10:  if Ch = P[-10] then begin Inc(Result,  5) end else
Ck09:  if Ch = P[ -9] then begin Inc(Result,  6) end else
Ck08:  if Ch = P[ -8] then begin Inc(Result,  7) end else
Ck07:  if Ch = P[ -7] then begin Inc(Result,  8) end else
Ck06:  if Ch = P[ -6] then begin Inc(Result,  9) end else
Ck05:  if Ch = P[ -5] then begin Inc(Result, 10) end else
Ck04:  if Ch = P[ -4] then begin Inc(Result, 11) end else
Ck03:  if Ch = P[ -3] then begin Inc(Result, 12) end else
Ck02:  if Ch = P[ -2] then begin Inc(Result, 13) end else
Ck01:  if Ch = P[ -1] then begin Inc(Result, 14) end else
Ck00:  Result := 0;
     end
   else
     Result := 0;
end;

procedure Filler7;
asm
 nop
end;

function CharPos_JOH_Pas_1_d(Ch : Char; const Str : AnsiString) : Integer;
var
  Len, Remainder     : Integer;
  P, PEnd, PBlockEnd : PChar;
label

Ck00,Ck01,Ck02,Ck03,Ck04,Ck05,Ck06,Ck07,Ck08,Ck09,Ck10,Ck11,Ck12,Ck13,Ck14;
begin
   if Str <> '' then
     begin
       P         := Pointer(Str);
       Len       := Length(Str);
       PEnd      := P + Len;
       Result    := 1 - Integer(P);
       PBlockEnd := PEnd - 16;
       if (P <= PBlockEnd) then
         repeat
           if Ch = P^    then begin Inc(Result, Integer(P)     ); Exit; end;
           if Ch = p[ 1] then begin Inc(Result, Integer(P) +  1); Exit; end;
           if Ch = P[ 2] then begin Inc(Result, Integer(P) +  2); Exit; end;
           if Ch = P[ 3] then begin Inc(Result, Integer(P) +  3); Exit; end;
           if Ch = P[ 4] then begin Inc(Result, Integer(P) +  4); Exit; end;
           if Ch = P[ 5] then begin Inc(Result, Integer(P) +  5); Exit; end;
           if Ch = P[ 6] then begin Inc(Result, Integer(P) +  6); Exit; end;
           if Ch = P[ 7] then begin Inc(Result, Integer(P) +  7); Exit; end;
           if Ch = P[ 8] then begin Inc(Result, Integer(P) +  8); Exit; end;
           if Ch = P[ 9] then begin Inc(Result, Integer(P) +  9); Exit; end;
           if Ch = P[10] then begin Inc(Result, Integer(P) + 10); Exit; end;
           if Ch = P[11] then begin Inc(Result, Integer(P) + 11); Exit; end;
           if Ch = P[12] then begin Inc(Result, Integer(P) + 12); Exit; end;
           if Ch = P[13] then begin Inc(Result, Integer(P) + 13); Exit; end;
           if Ch = P[14] then begin Inc(Result, Integer(P) + 14); Exit; end;
           if Ch = P[15] then begin Inc(Result, Integer(P) + 15); Exit; end;
           Inc(P, 16);
         until P > PBlockEnd;
       Result    := Len - 14;
       Remainder := PEnd - P; {0..15}
       Inc(P, Remainder);
       case Remainder of
          0 : goto Ck00;
          1 : goto Ck01;
          2 : goto Ck02;
          3 : goto Ck03;
          4 : goto Ck04;
          5 : goto Ck05;
          6 : goto Ck06;
          7 : goto Ck07;
          8 : goto Ck08;
          9 : goto Ck09;
         10 : goto Ck10;
         11 : goto Ck11;
         12 : goto Ck12;
         13 : goto Ck13;
         14 : goto Ck14;
       end;
       if Ch<> P[-15] then
Ck14:  if Ch = P[-14] then begin Inc(Result,  1) end else
Ck13:  if Ch = P[-13] then begin Inc(Result,  2) end else
Ck12:  if Ch = P[-12] then begin Inc(Result,  3) end else
Ck11:  if Ch = P[-11] then begin Inc(Result,  4) end else
Ck10:  if Ch = P[-10] then begin Inc(Result,  5) end else
Ck09:  if Ch = P[ -9] then begin Inc(Result,  6) end else
Ck08:  if Ch = P[ -8] then begin Inc(Result,  7) end else
Ck07:  if Ch = P[ -7] then begin Inc(Result,  8) end else
Ck06:  if Ch = P[ -6] then begin Inc(Result,  9) end else
Ck05:  if Ch = P[ -5] then begin Inc(Result, 10) end else
Ck04:  if Ch = P[ -4] then begin Inc(Result, 11) end else
Ck03:  if Ch = P[ -3] then begin Inc(Result, 12) end else
Ck02:  if Ch = P[ -2] then begin Inc(Result, 13) end else
Ck01:  if Ch = P[ -1] then begin Inc(Result, 14) end else
Ck00:  Result := 0;
     end
   else
     Result := 0;
end;

function CharPos_JOH_Pas_2_a(Ch : Char; const Str : AnsiString) : Integer;
var
  Len, Remainder     : Integer;
  P, PEnd, PBlockEnd : PChar;
label
  Ck00,Ck01,Ck02,Ck03,Ck04,Ck05,Ck06,Ck07,Ck08,Ck09,Ck10,
  Ck11,Ck12,Ck13,Ck14,Ck15,Ck16,Ck17,Ck18,Ck19,Ck20,Ck21,
  Ck22,Ck23,Ck24,Ck25,Ck26,Ck27,Ck28,Ck29,Ck30;
begin
   if Str <> '' then
     begin
       P         := Pointer(Str);
       Len       := Length(Str);
       PEnd      := P + Len;
       Result    := 1 - Integer(P);
       PBlockEnd := PEnd - 32;
       if (P <= PBlockEnd) then
         repeat
           if Ch = P^    then begin Inc(Result, Integer(P)     ); Exit; end;
           if Ch = p[ 1] then begin Inc(Result, Integer(P) +  1); Exit; end;
           if Ch = P[ 2] then begin Inc(Result, Integer(P) +  2); Exit; end;
           if Ch = P[ 3] then begin Inc(Result, Integer(P) +  3); Exit; end;
           if Ch = P[ 4] then begin Inc(Result, Integer(P) +  4); Exit; end;
           if Ch = P[ 5] then begin Inc(Result, Integer(P) +  5); Exit; end;
           if Ch = P[ 6] then begin Inc(Result, Integer(P) +  6); Exit; end;
           if Ch = P[ 7] then begin Inc(Result, Integer(P) +  7); Exit; end;
           if Ch = P[ 8] then begin Inc(Result, Integer(P) +  8); Exit; end;
           if Ch = P[ 9] then begin Inc(Result, Integer(P) +  9); Exit; end;
           if Ch = P[10] then begin Inc(Result, Integer(P) + 10); Exit; end;
           if Ch = P[11] then begin Inc(Result, Integer(P) + 11); Exit; end;
           if Ch = P[12] then begin Inc(Result, Integer(P) + 12); Exit; end;
           if Ch = P[13] then begin Inc(Result, Integer(P) + 13); Exit; end;
           if Ch = P[14] then begin Inc(Result, Integer(P) + 14); Exit; end;
           if Ch = P[15] then begin Inc(Result, Integer(P) + 15); Exit; end;
           if Ch = P[16] then begin Inc(Result, Integer(P) + 16); Exit; end;
           if Ch = P[17] then begin Inc(Result, Integer(P) + 17); Exit; end;
           if Ch = P[18] then begin Inc(Result, Integer(P) + 18); Exit; end;
           if Ch = P[19] then begin Inc(Result, Integer(P) + 19); Exit; end;
           if Ch = P[20] then begin Inc(Result, Integer(P) + 20); Exit; end;
           if Ch = P[21] then begin Inc(Result, Integer(P) + 21); Exit; end;
           if Ch = P[22] then begin Inc(Result, Integer(P) + 22); Exit; end;
           if Ch = P[23] then begin Inc(Result, Integer(P) + 23); Exit; end;
           if Ch = P[24] then begin Inc(Result, Integer(P) + 24); Exit; end;
           if Ch = P[25] then begin Inc(Result, Integer(P) + 25); Exit; end;
           if Ch = P[26] then begin Inc(Result, Integer(P) + 26); Exit; end;
           if Ch = P[27] then begin Inc(Result, Integer(P) + 27); Exit; end;
           if Ch = P[28] then begin Inc(Result, Integer(P) + 28); Exit; end;
           if Ch = P[29] then begin Inc(Result, Integer(P) + 29); Exit; end;
           if Ch = P[30] then begin Inc(Result, Integer(P) + 30); Exit; end;
           if Ch = P[31] then begin Inc(Result, Integer(P) + 31); Exit; end;
           Inc(P, 32);
         until P > PBlockEnd;
       Result    := Len - 30;
       Remainder := PEnd - P;
       Inc(P, Remainder);
       case Remainder of
          0 : goto Ck00;
          1 : goto Ck01;
          2 : goto Ck02;
          3 : goto Ck03;
          4 : goto Ck04;
          5 : goto Ck05;
          6 : goto Ck06;
          7 : goto Ck07;
          8 : goto Ck08;
          9 : goto Ck09;
         10 : goto Ck10;
         11 : goto Ck11;
         12 : goto Ck12;
         13 : goto Ck13;
         14 : goto Ck14;
         15 : goto Ck15;
         16 : goto Ck16;
         17 : goto Ck17;
         18 : goto Ck18;
         19 : goto Ck19;
         20 : goto Ck20;
         21 : goto Ck21;
         22 : goto Ck22;
         23 : goto Ck23;
         24 : goto Ck24;
         25 : goto Ck25;
         26 : goto Ck26;
         27 : goto Ck27;
         28 : goto Ck28;
         29 : goto Ck29;
         30 : goto Ck30;
       end;
       if Ch<> P[-31] then
Ck30:  if Ch = P[-30] then begin Inc(Result,  1) end else
Ck29:  if Ch = P[-29] then begin Inc(Result,  2) end else
Ck28:  if Ch = P[-28] then begin Inc(Result,  3) end else
Ck27:  if Ch = P[-27] then begin Inc(Result,  4) end else
Ck26:  if Ch = P[-26] then begin Inc(Result,  5) end else
Ck25:  if Ch = P[-25] then begin Inc(Result,  6) end else
Ck24:  if Ch = P[-24] then begin Inc(Result,  7) end else
Ck23:  if Ch = P[-23] then begin Inc(Result,  8) end else
Ck22:  if Ch = P[-22] then begin Inc(Result,  9) end else
Ck21:  if Ch = P[-21] then begin Inc(Result, 10) end else
Ck20:  if Ch = P[-20] then begin Inc(Result, 11) end else
Ck19:  if Ch = P[-19] then begin Inc(Result, 12) end else
Ck18:  if Ch = P[-18] then begin Inc(Result, 13) end else
Ck17:  if Ch = P[-17] then begin Inc(Result, 14) end else
Ck16:  if Ch = P[-16] then begin Inc(Result, 15) end else
Ck15:  if Ch = P[-15] then begin Inc(Result, 16) end else
Ck14:  if Ch = P[-14] then begin Inc(Result, 17) end else
Ck13:  if Ch = P[-13] then begin Inc(Result, 18) end else
Ck12:  if Ch = P[-12] then begin Inc(Result, 19) end else
Ck11:  if Ch = P[-11] then begin Inc(Result, 20) end else
Ck10:  if Ch = P[-10] then begin Inc(Result, 21) end else
Ck09:  if Ch = P[ -9] then begin Inc(Result, 22) end else
Ck08:  if Ch = P[ -8] then begin Inc(Result, 23) end else
Ck07:  if Ch = P[ -7] then begin Inc(Result, 24) end else
Ck06:  if Ch = P[ -6] then begin Inc(Result, 25) end else
Ck05:  if Ch = P[ -5] then begin Inc(Result, 26) end else
Ck04:  if Ch = P[ -4] then begin Inc(Result, 27) end else
Ck03:  if Ch = P[ -3] then begin Inc(Result, 28) end else
Ck02:  if Ch = P[ -2] then begin Inc(Result, 29) end else
Ck01:  if Ch = P[ -1] then begin Inc(Result, 30) end else
Ck00:  Result := 0;
     end
   else
     Result := 0;
end;

function CharPos_JOH_Pas_2_b(Ch : Char; const Str : AnsiString) : Integer;
var
  Len, Remainder     : Integer;
  P, PEnd, PBlockEnd : PChar;
label
  Ck00,Ck01,Ck02,Ck03,Ck04,Ck05,Ck06,Ck07,Ck08,Ck09,Ck10,
  Ck11,Ck12,Ck13,Ck14,Ck15,Ck16,Ck17,Ck18,Ck19,Ck20,Ck21,
  Ck22,Ck23,Ck24,Ck25,Ck26,Ck27,Ck28,Ck29,Ck30;
begin
   if Str <> '' then
     begin
       P         := Pointer(Str);
       Len       := Length(Str);
       PEnd      := P + Len;
       Result    := 1 - Integer(P);
       PBlockEnd := PEnd - 32;
       if (P <= PBlockEnd) then
         repeat
           if Ch = P^    then begin Inc(Result, Integer(P)     ); Exit; end;
           if Ch = p[ 1] then begin Inc(Result, Integer(P) +  1); Exit; end;
           if Ch = P[ 2] then begin Inc(Result, Integer(P) +  2); Exit; end;
           if Ch = P[ 3] then begin Inc(Result, Integer(P) +  3); Exit; end;
           if Ch = P[ 4] then begin Inc(Result, Integer(P) +  4); Exit; end;
           if Ch = P[ 5] then begin Inc(Result, Integer(P) +  5); Exit; end;
           if Ch = P[ 6] then begin Inc(Result, Integer(P) +  6); Exit; end;
           if Ch = P[ 7] then begin Inc(Result, Integer(P) +  7); Exit; end;
           if Ch = P[ 8] then begin Inc(Result, Integer(P) +  8); Exit; end;
           if Ch = P[ 9] then begin Inc(Result, Integer(P) +  9); Exit; end;
           if Ch = P[10] then begin Inc(Result, Integer(P) + 10); Exit; end;
           if Ch = P[11] then begin Inc(Result, Integer(P) + 11); Exit; end;
           if Ch = P[12] then begin Inc(Result, Integer(P) + 12); Exit; end;
           if Ch = P[13] then begin Inc(Result, Integer(P) + 13); Exit; end;
           if Ch = P[14] then begin Inc(Result, Integer(P) + 14); Exit; end;
           if Ch = P[15] then begin Inc(Result, Integer(P) + 15); Exit; end;
           if Ch = P[16] then begin Inc(Result, Integer(P) + 16); Exit; end;
           if Ch = P[17] then begin Inc(Result, Integer(P) + 17); Exit; end;
           if Ch = P[18] then begin Inc(Result, Integer(P) + 18); Exit; end;
           if Ch = P[19] then begin Inc(Result, Integer(P) + 19); Exit; end;
           if Ch = P[20] then begin Inc(Result, Integer(P) + 20); Exit; end;
           if Ch = P[21] then begin Inc(Result, Integer(P) + 21); Exit; end;
           if Ch = P[22] then begin Inc(Result, Integer(P) + 22); Exit; end;
           if Ch = P[23] then begin Inc(Result, Integer(P) + 23); Exit; end;
           if Ch = P[24] then begin Inc(Result, Integer(P) + 24); Exit; end;
           if Ch = P[25] then begin Inc(Result, Integer(P) + 25); Exit; end;
           if Ch = P[26] then begin Inc(Result, Integer(P) + 26); Exit; end;
           if Ch = P[27] then begin Inc(Result, Integer(P) + 27); Exit; end;
           if Ch = P[28] then begin Inc(Result, Integer(P) + 28); Exit; end;
           if Ch = P[29] then begin Inc(Result, Integer(P) + 29); Exit; end;
           if Ch = P[30] then begin Inc(Result, Integer(P) + 30); Exit; end;
           if Ch = P[31] then begin Inc(Result, Integer(P) + 31); Exit; end;
           Inc(P, 32);
         until P > PBlockEnd;
       Result    := Len - 30;
       Remainder := PEnd - P;
       Inc(P, Remainder);
       case Remainder of
          0 : goto Ck00;
          1 : goto Ck01;
          2 : goto Ck02;
          3 : goto Ck03;
          4 : goto Ck04;
          5 : goto Ck05;
          6 : goto Ck06;
          7 : goto Ck07;
          8 : goto Ck08;
          9 : goto Ck09;
         10 : goto Ck10;
         11 : goto Ck11;
         12 : goto Ck12;
         13 : goto Ck13;
         14 : goto Ck14;
         15 : goto Ck15;
         16 : goto Ck16;
         17 : goto Ck17;
         18 : goto Ck18;
         19 : goto Ck19;
         20 : goto Ck20;
         21 : goto Ck21;
         22 : goto Ck22;
         23 : goto Ck23;
         24 : goto Ck24;
         25 : goto Ck25;
         26 : goto Ck26;
         27 : goto Ck27;
         28 : goto Ck28;
         29 : goto Ck29;
         30 : goto Ck30;
       end;
       if Ch<> P[-31] then
Ck30:  if Ch = P[-30] then begin Inc(Result,  1) end else
Ck29:  if Ch = P[-29] then begin Inc(Result,  2) end else
Ck28:  if Ch = P[-28] then begin Inc(Result,  3) end else
Ck27:  if Ch = P[-27] then begin Inc(Result,  4) end else
Ck26:  if Ch = P[-26] then begin Inc(Result,  5) end else
Ck25:  if Ch = P[-25] then begin Inc(Result,  6) end else
Ck24:  if Ch = P[-24] then begin Inc(Result,  7) end else
Ck23:  if Ch = P[-23] then begin Inc(Result,  8) end else
Ck22:  if Ch = P[-22] then begin Inc(Result,  9) end else
Ck21:  if Ch = P[-21] then begin Inc(Result, 10) end else
Ck20:  if Ch = P[-20] then begin Inc(Result, 11) end else
Ck19:  if Ch = P[-19] then begin Inc(Result, 12) end else
Ck18:  if Ch = P[-18] then begin Inc(Result, 13) end else
Ck17:  if Ch = P[-17] then begin Inc(Result, 14) end else
Ck16:  if Ch = P[-16] then begin Inc(Result, 15) end else
Ck15:  if Ch = P[-15] then begin Inc(Result, 16) end else
Ck14:  if Ch = P[-14] then begin Inc(Result, 17) end else
Ck13:  if Ch = P[-13] then begin Inc(Result, 18) end else
Ck12:  if Ch = P[-12] then begin Inc(Result, 19) end else
Ck11:  if Ch = P[-11] then begin Inc(Result, 20) end else
Ck10:  if Ch = P[-10] then begin Inc(Result, 21) end else
Ck09:  if Ch = P[ -9] then begin Inc(Result, 22) end else
Ck08:  if Ch = P[ -8] then begin Inc(Result, 23) end else
Ck07:  if Ch = P[ -7] then begin Inc(Result, 24) end else
Ck06:  if Ch = P[ -6] then begin Inc(Result, 25) end else
Ck05:  if Ch = P[ -5] then begin Inc(Result, 26) end else
Ck04:  if Ch = P[ -4] then begin Inc(Result, 27) end else
Ck03:  if Ch = P[ -3] then begin Inc(Result, 28) end else
Ck02:  if Ch = P[ -2] then begin Inc(Result, 29) end else
Ck01:  if Ch = P[ -1] then begin Inc(Result, 30) end else
Ck00:  Result := 0;
     end
   else
     Result := 0;
end;

function CharPos_JOH_Pas_2_c(Ch : Char; const Str : AnsiString) : Integer;
var
  Len, Remainder     : Integer;
  P, PEnd, PBlockEnd : PChar;
label
  Ck00,Ck01,Ck02,Ck03,Ck04,Ck05,Ck06,Ck07,Ck08,Ck09,Ck10,
  Ck11,Ck12,Ck13,Ck14,Ck15,Ck16,Ck17,Ck18,Ck19,Ck20,Ck21,
  Ck22,Ck23,Ck24,Ck25,Ck26,Ck27,Ck28,Ck29,Ck30;
begin
   if Str <> '' then
     begin
       P         := Pointer(Str);
       Len       := Length(Str);
       PEnd      := P + Len;
       Result    := 1 - Integer(P);
       PBlockEnd := PEnd - 32;
       if (P <= PBlockEnd) then
         repeat
           if Ch = P^    then begin Inc(Result, Integer(P)     ); Exit; end;
           if Ch = p[ 1] then begin Inc(Result, Integer(P) +  1); Exit; end;
           if Ch = P[ 2] then begin Inc(Result, Integer(P) +  2); Exit; end;
           if Ch = P[ 3] then begin Inc(Result, Integer(P) +  3); Exit; end;
           if Ch = P[ 4] then begin Inc(Result, Integer(P) +  4); Exit; end;
           if Ch = P[ 5] then begin Inc(Result, Integer(P) +  5); Exit; end;
           if Ch = P[ 6] then begin Inc(Result, Integer(P) +  6); Exit; end;
           if Ch = P[ 7] then begin Inc(Result, Integer(P) +  7); Exit; end;
           if Ch = P[ 8] then begin Inc(Result, Integer(P) +  8); Exit; end;
           if Ch = P[ 9] then begin Inc(Result, Integer(P) +  9); Exit; end;
           if Ch = P[10] then begin Inc(Result, Integer(P) + 10); Exit; end;
           if Ch = P[11] then begin Inc(Result, Integer(P) + 11); Exit; end;
           if Ch = P[12] then begin Inc(Result, Integer(P) + 12); Exit; end;
           if Ch = P[13] then begin Inc(Result, Integer(P) + 13); Exit; end;
           if Ch = P[14] then begin Inc(Result, Integer(P) + 14); Exit; end;
           if Ch = P[15] then begin Inc(Result, Integer(P) + 15); Exit; end;
           if Ch = P[16] then begin Inc(Result, Integer(P) + 16); Exit; end;
           if Ch = P[17] then begin Inc(Result, Integer(P) + 17); Exit; end;
           if Ch = P[18] then begin Inc(Result, Integer(P) + 18); Exit; end;
           if Ch = P[19] then begin Inc(Result, Integer(P) + 19); Exit; end;
           if Ch = P[20] then begin Inc(Result, Integer(P) + 20); Exit; end;
           if Ch = P[21] then begin Inc(Result, Integer(P) + 21); Exit; end;
           if Ch = P[22] then begin Inc(Result, Integer(P) + 22); Exit; end;
           if Ch = P[23] then begin Inc(Result, Integer(P) + 23); Exit; end;
           if Ch = P[24] then begin Inc(Result, Integer(P) + 24); Exit; end;
           if Ch = P[25] then begin Inc(Result, Integer(P) + 25); Exit; end;
           if Ch = P[26] then begin Inc(Result, Integer(P) + 26); Exit; end;
           if Ch = P[27] then begin Inc(Result, Integer(P) + 27); Exit; end;
           if Ch = P[28] then begin Inc(Result, Integer(P) + 28); Exit; end;
           if Ch = P[29] then begin Inc(Result, Integer(P) + 29); Exit; end;
           if Ch = P[30] then begin Inc(Result, Integer(P) + 30); Exit; end;
           if Ch = P[31] then begin Inc(Result, Integer(P) + 31); Exit; end;
           Inc(P, 32);
         until P > PBlockEnd;
       Result    := Len - 30;
       Remainder := PEnd - P;
       Inc(P, Remainder);
       case Remainder of
          0 : goto Ck00;
          1 : goto Ck01;
          2 : goto Ck02;
          3 : goto Ck03;
          4 : goto Ck04;
          5 : goto Ck05;
          6 : goto Ck06;
          7 : goto Ck07;
          8 : goto Ck08;
          9 : goto Ck09;
         10 : goto Ck10;
         11 : goto Ck11;
         12 : goto Ck12;
         13 : goto Ck13;
         14 : goto Ck14;
         15 : goto Ck15;
         16 : goto Ck16;
         17 : goto Ck17;
         18 : goto Ck18;
         19 : goto Ck19;
         20 : goto Ck20;
         21 : goto Ck21;
         22 : goto Ck22;
         23 : goto Ck23;
         24 : goto Ck24;
         25 : goto Ck25;
         26 : goto Ck26;
         27 : goto Ck27;
         28 : goto Ck28;
         29 : goto Ck29;
         30 : goto Ck30;
       end;
       if Ch<> P[-31] then
Ck30:  if Ch = P[-30] then begin Inc(Result,  1) end else
Ck29:  if Ch = P[-29] then begin Inc(Result,  2) end else
Ck28:  if Ch = P[-28] then begin Inc(Result,  3) end else
Ck27:  if Ch = P[-27] then begin Inc(Result,  4) end else
Ck26:  if Ch = P[-26] then begin Inc(Result,  5) end else
Ck25:  if Ch = P[-25] then begin Inc(Result,  6) end else
Ck24:  if Ch = P[-24] then begin Inc(Result,  7) end else
Ck23:  if Ch = P[-23] then begin Inc(Result,  8) end else
Ck22:  if Ch = P[-22] then begin Inc(Result,  9) end else
Ck21:  if Ch = P[-21] then begin Inc(Result, 10) end else
Ck20:  if Ch = P[-20] then begin Inc(Result, 11) end else
Ck19:  if Ch = P[-19] then begin Inc(Result, 12) end else
Ck18:  if Ch = P[-18] then begin Inc(Result, 13) end else
Ck17:  if Ch = P[-17] then begin Inc(Result, 14) end else
Ck16:  if Ch = P[-16] then begin Inc(Result, 15) end else
Ck15:  if Ch = P[-15] then begin Inc(Result, 16) end else
Ck14:  if Ch = P[-14] then begin Inc(Result, 17) end else
Ck13:  if Ch = P[-13] then begin Inc(Result, 18) end else
Ck12:  if Ch = P[-12] then begin Inc(Result, 19) end else
Ck11:  if Ch = P[-11] then begin Inc(Result, 20) end else
Ck10:  if Ch = P[-10] then begin Inc(Result, 21) end else
Ck09:  if Ch = P[ -9] then begin Inc(Result, 22) end else
Ck08:  if Ch = P[ -8] then begin Inc(Result, 23) end else
Ck07:  if Ch = P[ -7] then begin Inc(Result, 24) end else
Ck06:  if Ch = P[ -6] then begin Inc(Result, 25) end else
Ck05:  if Ch = P[ -5] then begin Inc(Result, 26) end else
Ck04:  if Ch = P[ -4] then begin Inc(Result, 27) end else
Ck03:  if Ch = P[ -3] then begin Inc(Result, 28) end else
Ck02:  if Ch = P[ -2] then begin Inc(Result, 29) end else
Ck01:  if Ch = P[ -1] then begin Inc(Result, 30) end else
Ck00:  Result := 0;
     end
   else
     Result := 0;
end;

function CharPos_JOH_Pas_2_d(Ch : Char; const Str : AnsiString) : Integer;
var
  Len, Remainder     : Integer;
  P, PEnd, PBlockEnd : PChar;
label
  Ck00,Ck01,Ck02,Ck03,Ck04,Ck05,Ck06,Ck07,Ck08,Ck09,Ck10,
  Ck11,Ck12,Ck13,Ck14,Ck15,Ck16,Ck17,Ck18,Ck19,Ck20,Ck21,
  Ck22,Ck23,Ck24,Ck25,Ck26,Ck27,Ck28,Ck29,Ck30;
begin
   if Str <> '' then
     begin
       P         := Pointer(Str);
       Len       := Length(Str);
       PEnd      := P + Len;
       Result    := 1 - Integer(P);
       PBlockEnd := PEnd - 32;
       if (P <= PBlockEnd) then
         repeat
           if Ch = P^    then begin Inc(Result, Integer(P)     ); Exit; end;
           if Ch = p[ 1] then begin Inc(Result, Integer(P) +  1); Exit; end;
           if Ch = P[ 2] then begin Inc(Result, Integer(P) +  2); Exit; end;
           if Ch = P[ 3] then begin Inc(Result, Integer(P) +  3); Exit; end;
           if Ch = P[ 4] then begin Inc(Result, Integer(P) +  4); Exit; end;
           if Ch = P[ 5] then begin Inc(Result, Integer(P) +  5); Exit; end;
           if Ch = P[ 6] then begin Inc(Result, Integer(P) +  6); Exit; end;
           if Ch = P[ 7] then begin Inc(Result, Integer(P) +  7); Exit; end;
           if Ch = P[ 8] then begin Inc(Result, Integer(P) +  8); Exit; end;
           if Ch = P[ 9] then begin Inc(Result, Integer(P) +  9); Exit; end;
           if Ch = P[10] then begin Inc(Result, Integer(P) + 10); Exit; end;
           if Ch = P[11] then begin Inc(Result, Integer(P) + 11); Exit; end;
           if Ch = P[12] then begin Inc(Result, Integer(P) + 12); Exit; end;
           if Ch = P[13] then begin Inc(Result, Integer(P) + 13); Exit; end;
           if Ch = P[14] then begin Inc(Result, Integer(P) + 14); Exit; end;
           if Ch = P[15] then begin Inc(Result, Integer(P) + 15); Exit; end;
           if Ch = P[16] then begin Inc(Result, Integer(P) + 16); Exit; end;
           if Ch = P[17] then begin Inc(Result, Integer(P) + 17); Exit; end;
           if Ch = P[18] then begin Inc(Result, Integer(P) + 18); Exit; end;
           if Ch = P[19] then begin Inc(Result, Integer(P) + 19); Exit; end;
           if Ch = P[20] then begin Inc(Result, Integer(P) + 20); Exit; end;
           if Ch = P[21] then begin Inc(Result, Integer(P) + 21); Exit; end;
           if Ch = P[22] then begin Inc(Result, Integer(P) + 22); Exit; end;
           if Ch = P[23] then begin Inc(Result, Integer(P) + 23); Exit; end;
           if Ch = P[24] then begin Inc(Result, Integer(P) + 24); Exit; end;
           if Ch = P[25] then begin Inc(Result, Integer(P) + 25); Exit; end;
           if Ch = P[26] then begin Inc(Result, Integer(P) + 26); Exit; end;
           if Ch = P[27] then begin Inc(Result, Integer(P) + 27); Exit; end;
           if Ch = P[28] then begin Inc(Result, Integer(P) + 28); Exit; end;
           if Ch = P[29] then begin Inc(Result, Integer(P) + 29); Exit; end;
           if Ch = P[30] then begin Inc(Result, Integer(P) + 30); Exit; end;
           if Ch = P[31] then begin Inc(Result, Integer(P) + 31); Exit; end;
           Inc(P, 32);
         until P > PBlockEnd;
       Result    := Len - 30;
       Remainder := PEnd - P;
       Inc(P, Remainder);
       case Remainder of
          0 : goto Ck00;
          1 : goto Ck01;
          2 : goto Ck02;
          3 : goto Ck03;
          4 : goto Ck04;
          5 : goto Ck05;
          6 : goto Ck06;
          7 : goto Ck07;
          8 : goto Ck08;
          9 : goto Ck09;
         10 : goto Ck10;
         11 : goto Ck11;
         12 : goto Ck12;
         13 : goto Ck13;
         14 : goto Ck14;
         15 : goto Ck15;
         16 : goto Ck16;
         17 : goto Ck17;
         18 : goto Ck18;
         19 : goto Ck19;
         20 : goto Ck20;
         21 : goto Ck21;
         22 : goto Ck22;
         23 : goto Ck23;
         24 : goto Ck24;
         25 : goto Ck25;
         26 : goto Ck26;
         27 : goto Ck27;
         28 : goto Ck28;
         29 : goto Ck29;
         30 : goto Ck30;
       end;
       if Ch<> P[-31] then
Ck30:  if Ch = P[-30] then begin Inc(Result,  1) end else
Ck29:  if Ch = P[-29] then begin Inc(Result,  2) end else
Ck28:  if Ch = P[-28] then begin Inc(Result,  3) end else
Ck27:  if Ch = P[-27] then begin Inc(Result,  4) end else
Ck26:  if Ch = P[-26] then begin Inc(Result,  5) end else
Ck25:  if Ch = P[-25] then begin Inc(Result,  6) end else
Ck24:  if Ch = P[-24] then begin Inc(Result,  7) end else
Ck23:  if Ch = P[-23] then begin Inc(Result,  8) end else
Ck22:  if Ch = P[-22] then begin Inc(Result,  9) end else
Ck21:  if Ch = P[-21] then begin Inc(Result, 10) end else
Ck20:  if Ch = P[-20] then begin Inc(Result, 11) end else
Ck19:  if Ch = P[-19] then begin Inc(Result, 12) end else
Ck18:  if Ch = P[-18] then begin Inc(Result, 13) end else
Ck17:  if Ch = P[-17] then begin Inc(Result, 14) end else
Ck16:  if Ch = P[-16] then begin Inc(Result, 15) end else
Ck15:  if Ch = P[-15] then begin Inc(Result, 16) end else
Ck14:  if Ch = P[-14] then begin Inc(Result, 17) end else
Ck13:  if Ch = P[-13] then begin Inc(Result, 18) end else
Ck12:  if Ch = P[-12] then begin Inc(Result, 19) end else
Ck11:  if Ch = P[-11] then begin Inc(Result, 20) end else
Ck10:  if Ch = P[-10] then begin Inc(Result, 21) end else
Ck09:  if Ch = P[ -9] then begin Inc(Result, 22) end else
Ck08:  if Ch = P[ -8] then begin Inc(Result, 23) end else
Ck07:  if Ch = P[ -7] then begin Inc(Result, 24) end else
Ck06:  if Ch = P[ -6] then begin Inc(Result, 25) end else
Ck05:  if Ch = P[ -5] then begin Inc(Result, 26) end else
Ck04:  if Ch = P[ -4] then begin Inc(Result, 27) end else
Ck03:  if Ch = P[ -3] then begin Inc(Result, 28) end else
Ck02:  if Ch = P[ -2] then begin Inc(Result, 29) end else
Ck01:  if Ch = P[ -1] then begin Inc(Result, 30) end else
Ck00:  Result := 0;
     end
   else
     Result := 0;
end;

function CharPos_JOH_IA32_1_a(Ch : Char; const Str : AnsiString) : Integer;
asm
  test edx, edx         {Str = NIL?}
  jz   @@NotFoundExit   {Yes - Jump}
  mov  ecx, [edx-4]     {ECX = Length(Str)}
  push ebx
  mov  ebx,ecx          {Save Length(Str)}
  neg  ecx
  jz   @@CharNotFound   {Exit if Length = 0}
  cmp  ecx, -8          {Length(Str) >= 8}
  jle  @@NotSmall
  cmp  al, [edx]        {Check 1st Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+1]      {Check 2nd Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+2]      {Check 3rd Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+3]      {Check 4th Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+4]      {Check 5th Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+5]      {Check 6th Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+6]      {Check 7th Char}
  je   @@Found
@@CharNotFound:
  pop  ebx              {Restore Stack}
@@NotFoundExit:
  xor  eax, eax         {Set Result to 0}
  ret                   {Finished}
@@Found8:
  add  ecx, 7
  jmp  @@Found
@@Found7:
  add  ecx, 6
  jmp  @@Found
@@Found6:
  add  ecx, 5
  jmp  @@Found
@@Found5:
  add  ecx, 4
  jmp  @@Found
@@Found4:
  add  ecx, 3
  jmp  @@Found
@@Found3:
  add  ecx, 2
  jmp  @@Found
@@Found2:
  add  ecx, 1
@@Found:
  lea  eax, [ebx+ecx+1] {Set Result}
  pop  ebx
  ret                   {Finished}
@@NotSmall:
  sub  edx, ecx         {End of String}
@@Loop:
  cmp  al, [edx+ecx]    {Compare Next 8 Characters}
  je   @@Found
  cmp  al, [edx+ecx+1]
  je   @@Found2
  cmp  al, [edx+ecx+2]
  je   @@Found3
  cmp  al, [edx+ecx+3]
  je   @@Found4
  cmp  al, [edx+ecx+4]
  je   @@Found5
  cmp  al, [edx+ecx+5]
  je   @@Found6
  cmp  al, [edx+ecx+6]
  je   @@Found7
  cmp  al, [edx+ecx+7]
  je   @@Found8
  add  ecx, 8           {Next Character Position}
  and  ecx, -8          {Prevent Read Past End of String}
  jnz  @@Loop           {Loop until all Characters Compared}
  pop  ebx              {Restore Stack}
  xor  eax, eax         {Set Result to 0}
end;

procedure Filler8;
asm
 nop
end;

function CharPos_JOH_IA32_1_b(Ch : Char; const Str : AnsiString) : Integer;
asm
  test edx, edx         {Str = NIL?}
  jz   @@NotFoundExit   {Yes - Jump}
  mov  ecx, [edx-4]     {ECX = Length(Str)}
  push ebx
  mov  ebx,ecx          {Save Length(Str)}
  neg  ecx
  jz   @@CharNotFound   {Exit if Length = 0}
  cmp  ecx, -8          {Length(Str) >= 8}
  jle  @@NotSmall
  cmp  al, [edx]        {Check 1st Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+1]      {Check 2nd Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+2]      {Check 3rd Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+3]      {Check 4th Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+4]      {Check 5th Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+5]      {Check 6th Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+6]      {Check 7th Char}
  je   @@Found
@@CharNotFound:
  pop  ebx              {Restore Stack}
@@NotFoundExit:
  xor  eax, eax         {Set Result to 0}
  ret                   {Finished}
@@Found8:
  add  ecx, 7
  jmp  @@Found
@@Found7:
  add  ecx, 6
  jmp  @@Found
@@Found6:
  add  ecx, 5
  jmp  @@Found
@@Found5:
  add  ecx, 4
  jmp  @@Found
@@Found4:
  add  ecx, 3
  jmp  @@Found
@@Found3:
  add  ecx, 2
  jmp  @@Found
@@Found2:
  add  ecx, 1
@@Found:
  lea  eax, [ebx+ecx+1] {Set Result}
  pop  ebx
  ret                   {Finished}
@@NotSmall:
  sub  edx, ecx         {End of String}
@@Loop:
  cmp  al, [edx+ecx]    {Compare Next 8 Characters}
  je   @@Found
  cmp  al, [edx+ecx+1]
  je   @@Found2
  cmp  al, [edx+ecx+2]
  je   @@Found3
  cmp  al, [edx+ecx+3]
  je   @@Found4
  cmp  al, [edx+ecx+4]
  je   @@Found5
  cmp  al, [edx+ecx+5]
  je   @@Found6
  cmp  al, [edx+ecx+6]
  je   @@Found7
  cmp  al, [edx+ecx+7]
  je   @@Found8
  add  ecx, 8           {Next Character Position}
  and  ecx, -8          {Prevent Read Past End of String}
  jnz  @@Loop           {Loop until all Characters Compared}
  pop  ebx              {Restore Stack}
  xor  eax, eax         {Set Result to 0}
end;

procedure Filler3;
asm
 nop
 nop
 nop
end;

function CharPos_JOH_IA32_1_c(Ch : Char; const Str : AnsiString) : Integer;
asm
  test edx, edx         {Str = NIL?}
  jz   @@NotFoundExit   {Yes - Jump}
  mov  ecx, [edx-4]     {ECX = Length(Str)}
  push ebx
  mov  ebx,ecx          {Save Length(Str)}
  neg  ecx
  jz   @@CharNotFound   {Exit if Length = 0}
  cmp  ecx, -8          {Length(Str) >= 8}
  jle  @@NotSmall
  cmp  al, [edx]        {Check 1st Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+1]      {Check 2nd Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+2]      {Check 3rd Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+3]      {Check 4th Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+4]      {Check 5th Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+5]      {Check 6th Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+6]      {Check 7th Char}
  je   @@Found
@@CharNotFound:
  pop  ebx              {Restore Stack}
@@NotFoundExit:
  xor  eax, eax         {Set Result to 0}
  ret                   {Finished}
@@Found8:
  add  ecx, 7
  jmp  @@Found
@@Found7:
  add  ecx, 6
  jmp  @@Found
@@Found6:
  add  ecx, 5
  jmp  @@Found
@@Found5:
  add  ecx, 4
  jmp  @@Found
@@Found4:
  add  ecx, 3
  jmp  @@Found
@@Found3:
  add  ecx, 2
  jmp  @@Found
@@Found2:
  add  ecx, 1
@@Found:
  lea  eax, [ebx+ecx+1] {Set Result}
  pop  ebx
  ret                   {Finished}
@@NotSmall:
  sub  edx, ecx         {End of String}
@@Loop:
  cmp  al, [edx+ecx]    {Compare Next 8 Characters}
  je   @@Found
  cmp  al, [edx+ecx+1]
  je   @@Found2
  cmp  al, [edx+ecx+2]
  je   @@Found3
  cmp  al, [edx+ecx+3]
  je   @@Found4
  cmp  al, [edx+ecx+4]
  je   @@Found5
  cmp  al, [edx+ecx+5]
  je   @@Found6
  cmp  al, [edx+ecx+6]
  je   @@Found7
  cmp  al, [edx+ecx+7]
  je   @@Found8
  add  ecx, 8           {Next Character Position}
  and  ecx, -8          {Prevent Read Past End of String}
  jnz  @@Loop           {Loop until all Characters Compared}
  pop  ebx              {Restore Stack}
  xor  eax, eax         {Set Result to 0}
end;

procedure Filler9;
asm
 nop
end;

function CharPos_JOH_IA32_1_d(Ch : Char; const Str : AnsiString) : Integer;
asm
  test edx, edx         {Str = NIL?}
  jz   @@NotFoundExit   {Yes - Jump}
  mov  ecx, [edx-4]     {ECX = Length(Str)}
  push ebx
  mov  ebx,ecx          {Save Length(Str)}
  neg  ecx
  jz   @@CharNotFound   {Exit if Length = 0}
  cmp  ecx, -8          {Length(Str) >= 8}
  jle  @@NotSmall
  cmp  al, [edx]        {Check 1st Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+1]      {Check 2nd Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+2]      {Check 3rd Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+3]      {Check 4th Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+4]      {Check 5th Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+5]      {Check 6th Char}
  je   @@Found
  inc  ecx
  jz   @@CharNotFound
  cmp  al, [edx+6]      {Check 7th Char}
  je   @@Found
@@CharNotFound:
  pop  ebx              {Restore Stack}
@@NotFoundExit:
  xor  eax, eax         {Set Result to 0}
  ret                   {Finished}
@@Found8:
  add  ecx, 7
  jmp  @@Found
@@Found7:
  add  ecx, 6
  jmp  @@Found
@@Found6:
  add  ecx, 5
  jmp  @@Found
@@Found5:
  add  ecx, 4
  jmp  @@Found
@@Found4:
  add  ecx, 3
  jmp  @@Found
@@Found3:
  add  ecx, 2
  jmp  @@Found
@@Found2:
  add  ecx, 1
@@Found:
  lea  eax, [ebx+ecx+1] {Set Result}
  pop  ebx
  ret                   {Finished}
@@NotSmall:
  sub  edx, ecx         {End of String}
@@Loop:
  cmp  al, [edx+ecx]    {Compare Next 8 Characters}
  je   @@Found
  cmp  al, [edx+ecx+1]
  je   @@Found2
  cmp  al, [edx+ecx+2]
  je   @@Found3
  cmp  al, [edx+ecx+3]
  je   @@Found4
  cmp  al, [edx+ecx+4]
  je   @@Found5
  cmp  al, [edx+ecx+5]
  je   @@Found6
  cmp  al, [edx+ecx+6]
  je   @@Found7
  cmp  al, [edx+ecx+7]
  je   @@Found8
  add  ecx, 8           {Next Character Position}
  and  ecx, -8          {Prevent Read Past End of String}
  jnz  @@Loop           {Loop until all Characters Compared}
  pop  ebx              {Restore Stack}
  xor  eax, eax         {Set Result to 0}
end;

function CharPosJOH_IA32_Small(Ch : Char; const Str : AnsiString) : Integer;
asm {Will read past last character in string, but not beyond allocated
Memory}
  TEST EDX, EDX         {Str = NIL?}
  JZ   @@NotFound       {Yes - Jump}
  MOV  ECX, [EDX-4]     {ECX = Length(Str)}
  ADD  EDX, ECX         {EDX = End of String + 1}
  PUSH ECX              {Save String Length}
  NEG  ECX              {Offset from End of String}
  JZ   @@NotFound2      {Exit if Length = 0}
@@Loop: {Safe since all AnsiString's are DWORD Aligned/Padded}
  CMP  AL, [EDX+ECX]    {Compare Ch with Next Character of Str}
  JE   @@Found          {Jump if Same}
  CMP  AL, [EDX+ECX+1]  {Compare Ch with Next Character of Str}
  JE   @@FoundCheck1    {Jump if Same}
  CMP  AL, [EDX+ECX+2]  {Compare Ch with Next Character of Str}
  JE   @@FoundCheck2    {Jump if Same}
  CMP  AL, [EDX+ECX+3]  {Compare Ch with Next Character of Str}
  JE   @@FoundCheck3    {Jump if Same}
  ADD  ECX, 4           {Next Character Position}
  JS   @@Loop           {Loop until all Characters Compared}
@@NotFound2:
  POP  EDX              {Restore Stack}
@@NotFound:
  XOR  EAX, EAX         {Set Result to 0}
  RET                   {Finished}
@@FoundCheck3:
  ADD  ECX, 1           {Check if within String}
@@FoundCheck2:
  ADD  ECX, 1           {Check if within String}
@@FoundCheck1:
  ADD  ECX, 1           {Check if within String}
  JGE  @@NotFound2      {Jump if Found Position after Last Used Position}
@@Found:
  POP  EAX              {String Length}
  LEA  EAX, [EAX+ECX+1] {Set Result}
end;

function CharPos_JOH_MMX_1_a(Ch : Char; const Str : AnsiString) : Integer;
asm
  TEST      EDX, EDX         {Str = NIL?}
  JZ        @@NotFound       {Yes - Jump}
  MOV       ECX, [EDX-4]     {ECX = Length(Str)}
  CMP       ECX, 8
  JG        @@NotSmall
  TEST      ECX, ECX
  JZ        @@NotFound       {Exit if Length = 0}
@@Small:
  CMP       AL, [EDX]
  JZ        @Found1
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+1]
  JZ        @Found2
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+2]
  JZ        @Found3
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+3]
  JZ        @Found4
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+4]
  JZ        @Found5
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+5]
  JZ        @Found6
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+6]
  JZ        @Found7
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+7]
  JZ        @Found8
@@NotFound:
  XOR       EAX, EAX
  RET
@Found1:
  MOV       EAX, 1
  RET
@Found2:
  MOV       EAX, 2
  RET
@Found3:
  MOV       EAX, 3
  RET
@Found4:
  MOV       EAX, 4
  RET
@Found5:
  MOV       EAX, 5
  RET
@Found6:
  MOV       EAX, 6
  RET
@Found7:
  MOV       EAX, 7
  RET
@Found8:
  MOV       EAX, 8
  RET

@@NotSmall:                  {Length(Str) > 8}
  MOV       AH, AL
  ADD       EDX, ECX
  MOVD      MM0, EAX
  PUNPCKLWD MM0, MM0
  PUNPCKLDQ MM0, MM0
  PUSH      ECX              {Save Length}
  NEG       ECX
@@First8:
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
  JGE       @@Last8
@@Align:                     {Align to Previous 8 Byte Boundary}
  LEA       EAX, [EDX+ECX]
  AND       EAX, 7           {EAX -> 0 or 4}
  SUB       ECX, EAX
@@Loop:
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
{$IFNDEF NoUnroll}
  JGE       @@Last8
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
{$ENDIF}
  JL        @@Loop
@@Last8:
  MOVQ      MM1, [EDX-8]     {Position for Last 8 Used Characters}
  POP       EDX              {Original Length}
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched2       {Exit on Match at any Position}
  EMMS
  RET                        {Finished - Not Found}
@@Matched:                   {Set Result from 1st Match in EDX}
  POP       EDX              {Original Length}
  ADD       EDX, ECX
@@Matched2:
  EMMS
  SUB       EDX, 8           {Adjust for Extra ADD ECX,8 in Loop}
  TEST      AL, AL
  JNZ       @@MatchDone      {Match at Position 1 or 2}
  TEST      AH, AH
  JNZ       @@Match1         {Match at Position 3 or 4}
  SHR       EAX, 16
  TEST      AL, AL
  JNZ       @@Match2         {Match at Position 5 or 6}
  SHR       EAX, 8
  ADD       EDX, 6
  JMP       @@MatchDone
@@Match2:
  ADD       EDX, 4
  JMP       @@MatchDone
@@Match1:
  SHR       EAX, 8           {AL <- AH}
  ADD       EDX, 2
@@MatchDone:
  XOR       EAX, 2
  AND       EAX, 3           {EAX <- 1 or 2}
  ADD       EAX, EDX
end;

function CharPos_JOH_MMX_1_b(Ch : Char; const Str : AnsiString) : Integer;
asm
  TEST      EDX, EDX         {Str = NIL?}
  JZ        @@NotFound       {Yes - Jump}
  MOV       ECX, [EDX-4]     {ECX = Length(Str)}
  CMP       ECX, 8
  JG        @@NotSmall
  TEST      ECX, ECX
  JZ        @@NotFound       {Exit if Length = 0}
@@Small:
  CMP       AL, [EDX]
  JZ        @Found1
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+1]
  JZ        @Found2
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+2]
  JZ        @Found3
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+3]
  JZ        @Found4
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+4]
  JZ        @Found5
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+5]
  JZ        @Found6
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+6]
  JZ        @Found7
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+7]
  JZ        @Found8
@@NotFound:
  XOR       EAX, EAX
  RET
@Found1:
  MOV       EAX, 1
  RET
@Found2:
  MOV       EAX, 2
  RET
@Found3:
  MOV       EAX, 3
  RET
@Found4:
  MOV       EAX, 4
  RET
@Found5:
  MOV       EAX, 5
  RET
@Found6:
  MOV       EAX, 6
  RET
@Found7:
  MOV       EAX, 7
  RET
@Found8:
  MOV       EAX, 8
  RET

@@NotSmall:                  {Length(Str) > 8}
  MOV       AH, AL
  ADD       EDX, ECX
  MOVD      MM0, EAX
  PUNPCKLWD MM0, MM0
  PUNPCKLDQ MM0, MM0
  PUSH      ECX              {Save Length}
  NEG       ECX
@@First8:
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
  JGE       @@Last8
@@Align:                     {Align to Previous 8 Byte Boundary}
  LEA       EAX, [EDX+ECX]
  AND       EAX, 7           {EAX -> 0 or 4}
  SUB       ECX, EAX
@@Loop:
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
{$IFNDEF NoUnroll}
  JGE       @@Last8
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
{$ENDIF}
  JL        @@Loop
@@Last8:
  MOVQ      MM1, [EDX-8]     {Position for Last 8 Used Characters}
  POP       EDX              {Original Length}
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched2       {Exit on Match at any Position}
  EMMS
  RET                        {Finished - Not Found}
@@Matched:                   {Set Result from 1st Match in EDX}
  POP       EDX              {Original Length}
  ADD       EDX, ECX
@@Matched2:
  EMMS
  SUB       EDX, 8           {Adjust for Extra ADD ECX,8 in Loop}
  TEST      AL, AL
  JNZ       @@MatchDone      {Match at Position 1 or 2}
  TEST      AH, AH
  JNZ       @@Match1         {Match at Position 3 or 4}
  SHR       EAX, 16
  TEST      AL, AL
  JNZ       @@Match2         {Match at Position 5 or 6}
  SHR       EAX, 8
  ADD       EDX, 6
  JMP       @@MatchDone
@@Match2:
  ADD       EDX, 4
  JMP       @@MatchDone
@@Match1:
  SHR       EAX, 8           {AL <- AH}
  ADD       EDX, 2
@@MatchDone:
  XOR       EAX, 2
  AND       EAX, 3           {EAX <- 1 or 2}
  ADD       EAX, EDX
end;

function CharPos_JOH_MMX_1_c(Ch : Char; const Str : AnsiString) : Integer;
asm
  TEST      EDX, EDX         {Str = NIL?}
  JZ        @@NotFound       {Yes - Jump}
  MOV       ECX, [EDX-4]     {ECX = Length(Str)}
  CMP       ECX, 8
  JG        @@NotSmall
  TEST      ECX, ECX
  JZ        @@NotFound       {Exit if Length = 0}
@@Small:
  CMP       AL, [EDX]
  JZ        @Found1
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+1]
  JZ        @Found2
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+2]
  JZ        @Found3
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+3]
  JZ        @Found4
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+4]
  JZ        @Found5
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+5]
  JZ        @Found6
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+6]
  JZ        @Found7
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+7]
  JZ        @Found8
@@NotFound:
  XOR       EAX, EAX
  RET
@Found1:
  MOV       EAX, 1
  RET
@Found2:
  MOV       EAX, 2
  RET
@Found3:
  MOV       EAX, 3
  RET
@Found4:
  MOV       EAX, 4
  RET
@Found5:
  MOV       EAX, 5
  RET
@Found6:
  MOV       EAX, 6
  RET
@Found7:
  MOV       EAX, 7
  RET
@Found8:
  MOV       EAX, 8
  RET

@@NotSmall:                  {Length(Str) > 8}
  MOV       AH, AL
  ADD       EDX, ECX
  MOVD      MM0, EAX
  PUNPCKLWD MM0, MM0
  PUNPCKLDQ MM0, MM0
  PUSH      ECX              {Save Length}
  NEG       ECX
@@First8:
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
  JGE       @@Last8
@@Align:                     {Align to Previous 8 Byte Boundary}
  LEA       EAX, [EDX+ECX]
  AND       EAX, 7           {EAX -> 0 or 4}
  SUB       ECX, EAX
@@Loop:
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
{$IFNDEF NoUnroll}
  JGE       @@Last8
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
{$ENDIF}
  JL        @@Loop
@@Last8:
  MOVQ      MM1, [EDX-8]     {Position for Last 8 Used Characters}
  POP       EDX              {Original Length}
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched2       {Exit on Match at any Position}
  EMMS
  RET                        {Finished - Not Found}
@@Matched:                   {Set Result from 1st Match in EDX}
  POP       EDX              {Original Length}
  ADD       EDX, ECX
@@Matched2:
  EMMS
  SUB       EDX, 8           {Adjust for Extra ADD ECX,8 in Loop}
  TEST      AL, AL
  JNZ       @@MatchDone      {Match at Position 1 or 2}
  TEST      AH, AH
  JNZ       @@Match1         {Match at Position 3 or 4}
  SHR       EAX, 16
  TEST      AL, AL
  JNZ       @@Match2         {Match at Position 5 or 6}
  SHR       EAX, 8
  ADD       EDX, 6
  JMP       @@MatchDone
@@Match2:
  ADD       EDX, 4
  JMP       @@MatchDone
@@Match1:
  SHR       EAX, 8           {AL <- AH}
  ADD       EDX, 2
@@MatchDone:
  XOR       EAX, 2
  AND       EAX, 3           {EAX <- 1 or 2}
  ADD       EAX, EDX
end;

function CharPos_JOH_MMX_1_d(Ch : Char; const Str : AnsiString) : Integer;
asm
  TEST      EDX, EDX         {Str = NIL?}
  JZ        @@NotFound       {Yes - Jump}
  MOV       ECX, [EDX-4]     {ECX = Length(Str)}
  CMP       ECX, 8
  JG        @@NotSmall
  TEST      ECX, ECX
  JZ        @@NotFound       {Exit if Length = 0}
@@Small:
  CMP       AL, [EDX]
  JZ        @Found1
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+1]
  JZ        @Found2
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+2]
  JZ        @Found3
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+3]
  JZ        @Found4
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+4]
  JZ        @Found5
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+5]
  JZ        @Found6
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+6]
  JZ        @Found7
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+7]
  JZ        @Found8
@@NotFound:
  XOR       EAX, EAX
  RET
@Found1:
  MOV       EAX, 1
  RET
@Found2:
  MOV       EAX, 2
  RET
@Found3:
  MOV       EAX, 3
  RET
@Found4:
  MOV       EAX, 4
  RET
@Found5:
  MOV       EAX, 5
  RET
@Found6:
  MOV       EAX, 6
  RET
@Found7:
  MOV       EAX, 7
  RET
@Found8:
  MOV       EAX, 8
  RET

@@NotSmall:                  {Length(Str) > 8}
  MOV       AH, AL
  ADD       EDX, ECX
  MOVD      MM0, EAX
  PUNPCKLWD MM0, MM0
  PUNPCKLDQ MM0, MM0
  PUSH      ECX              {Save Length}
  NEG       ECX
@@First8:
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
  JGE       @@Last8
@@Align:                     {Align to Previous 8 Byte Boundary}
  LEA       EAX, [EDX+ECX]
  AND       EAX, 7           {EAX -> 0 or 4}
  SUB       ECX, EAX
@@Loop:
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
{$IFNDEF NoUnroll}
  JGE       @@Last8
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
{$ENDIF}
  JL        @@Loop
@@Last8:
  MOVQ      MM1, [EDX-8]     {Position for Last 8 Used Characters}
  POP       EDX              {Original Length}
  PCMPEQB   MM1, MM0         {Compare All 8 Bytes}
  PACKSSWB  MM1, MM1         {Pack Result into 4 Bytes}
  MOVD      EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched2       {Exit on Match at any Position}
  EMMS
  RET                        {Finished - Not Found}
@@Matched:                   {Set Result from 1st Match in EDX}
  POP       EDX              {Original Length}
  ADD       EDX, ECX
@@Matched2:
  EMMS
  SUB       EDX, 8           {Adjust for Extra ADD ECX,8 in Loop}
  TEST      AL, AL
  JNZ       @@MatchDone      {Match at Position 1 or 2}
  TEST      AH, AH
  JNZ       @@Match1         {Match at Position 3 or 4}
  SHR       EAX, 16
  TEST      AL, AL
  JNZ       @@Match2         {Match at Position 5 or 6}
  SHR       EAX, 8
  ADD       EDX, 6
  JMP       @@MatchDone
@@Match2:
  ADD       EDX, 4
  JMP       @@MatchDone
@@Match1:
  SHR       EAX, 8           {AL <- AH}
  ADD       EDX, 2
@@MatchDone:
  XOR       EAX, 2
  AND       EAX, 3           {EAX <- 1 or 2}
  ADD       EAX, EDX
end;

function CharPos_JOH_SSE_1_a(Ch : Char; const Str : AnsiString) : Integer;
asm
  TEST      EDX, EDX         {Str = NIL?}
  JZ        @@NotFound       {Yes - Jump}
  MOV       ECX, [EDX-4]     {ECX = Length(Str)}
  CMP       ECX, 8
  JG        @@NotSmall
  TEST      ECX, ECX
  JZ        @@NotFound       {Exit if Length = 0}
@@Small:
  CMP       AL, [EDX]
  JZ        @Found1
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+1]
  JZ        @Found2
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+2]
  JZ        @Found3
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+3]
  JZ        @Found4
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+4]
  JZ        @Found5
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+5]
  JZ        @Found6
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+6]
  JZ        @Found7
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+7]
  JZ        @Found8
@@NotFound:
  XOR       EAX, EAX
  RET
@Found1:
  MOV       EAX, 1
  RET
@Found2:
  MOV       EAX, 2
  RET
@Found3:
  MOV       EAX, 3
  RET
@Found4:
  MOV       EAX, 4
  RET
@Found5:
  MOV       EAX, 5
  RET
@Found6:
  MOV       EAX, 6
  RET
@Found7:
  MOV       EAX, 7
  RET
@Found8:
  MOV       EAX, 8
  RET
@@NotSmall:
  MOV       AH, AL
  ADD       EDX, ECX
  MOVD      MM0, EAX
  PSHUFW    MM0, MM0, 0
  PUSH      ECX
  NEG       ECX
@@First8:
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
  JGE       @@Last8
@@Align:
  LEA       EAX, [EDX+ECX]
  AND       EAX, 7
  SUB       ECX, EAX
@@Loop:                      {Loop Unrolled 2X}
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
{$IFNDEF NoUnroll}
  JGE       @@Last8
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
{$ENDIF}
  JL        @@loop
@@Last8:
  PCMPEQB   MM0, [EDX-8]
  POP       ECX              {Original Length}
  PMOVMSKB  EAX, MM0
  TEST      EAX, EAX
  JNZ       @@Matched2
  EMMS
  RET                        {Finished}
@@Matched:                   {Set Result from 1st Match in EcX}
  POP       EDX              {Original Length}
  ADD       ECX, EDX
@@Matched2:
  EMMS
  BSF       EDX, EAX
  LEA       EAX, [EDX+ECX-7]
end;

function CharPos_JOH_SSE_1_b(Ch : Char; const Str : AnsiString) : Integer;
asm
  TEST      EDX, EDX         {Str = NIL?}
  JZ        @@NotFound       {Yes - Jump}
  MOV       ECX, [EDX-4]     {ECX = Length(Str)}
  CMP       ECX, 8
  JG        @@NotSmall
  TEST      ECX, ECX
  JZ        @@NotFound       {Exit if Length = 0}
@@Small:
  CMP       AL, [EDX]
  JZ        @Found1
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+1]
  JZ        @Found2
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+2]
  JZ        @Found3
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+3]
  JZ        @Found4
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+4]
  JZ        @Found5
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+5]
  JZ        @Found6
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+6]
  JZ        @Found7
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+7]
  JZ        @Found8
@@NotFound:
  XOR       EAX, EAX
  RET
@Found1:
  MOV       EAX, 1
  RET
@Found2:
  MOV       EAX, 2
  RET
@Found3:
  MOV       EAX, 3
  RET
@Found4:
  MOV       EAX, 4
  RET
@Found5:
  MOV       EAX, 5
  RET
@Found6:
  MOV       EAX, 6
  RET
@Found7:
  MOV       EAX, 7
  RET
@Found8:
  MOV       EAX, 8
  RET
@@NotSmall:
  MOV       AH, AL
  ADD       EDX, ECX
  MOVD      MM0, EAX
  PSHUFW    MM0, MM0, 0
  PUSH      ECX
  NEG       ECX
@@First8:
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
  JGE       @@Last8
@@Align:
  LEA       EAX, [EDX+ECX]
  AND       EAX, 7
  SUB       ECX, EAX
@@Loop:                      {Loop Unrolled 2X}
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
{$IFNDEF NoUnroll}
  JGE       @@Last8
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
{$ENDIF}
  JL        @@loop
@@Last8:
  PCMPEQB   MM0, [EDX-8]
  POP       ECX              {Original Length}
  PMOVMSKB  EAX, MM0
  TEST      EAX, EAX
  JNZ       @@Matched2
  EMMS
  RET                        {Finished}
@@Matched:                   {Set Result from 1st Match in EcX}
  POP       EDX              {Original Length}
  ADD       ECX, EDX
@@Matched2:
  EMMS
  BSF       EDX, EAX
  LEA       EAX, [EDX+ECX-7]
end;

function CharPos_JOH_SSE_1_c(Ch : Char; const Str : AnsiString) : Integer;
asm
  TEST      EDX, EDX         {Str = NIL?}
  JZ        @@NotFound       {Yes - Jump}
  MOV       ECX, [EDX-4]     {ECX = Length(Str)}
  CMP       ECX, 8
  JG        @@NotSmall
  TEST      ECX, ECX
  JZ        @@NotFound       {Exit if Length = 0}
@@Small:
  CMP       AL, [EDX]
  JZ        @Found1
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+1]
  JZ        @Found2
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+2]
  JZ        @Found3
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+3]
  JZ        @Found4
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+4]
  JZ        @Found5
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+5]
  JZ        @Found6
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+6]
  JZ        @Found7
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+7]
  JZ        @Found8
@@NotFound:
  XOR       EAX, EAX
  RET
@Found1:
  MOV       EAX, 1
  RET
@Found2:
  MOV       EAX, 2
  RET
@Found3:
  MOV       EAX, 3
  RET
@Found4:
  MOV       EAX, 4
  RET
@Found5:
  MOV       EAX, 5
  RET
@Found6:
  MOV       EAX, 6
  RET
@Found7:
  MOV       EAX, 7
  RET
@Found8:
  MOV       EAX, 8
  RET
@@NotSmall:
  MOV       AH, AL
  ADD       EDX, ECX
  MOVD      MM0, EAX
  PSHUFW    MM0, MM0, 0
  PUSH      ECX
  NEG       ECX
@@First8:
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
  JGE       @@Last8
@@Align:
  LEA       EAX, [EDX+ECX]
  AND       EAX, 7
  SUB       ECX, EAX
@@Loop:                      {Loop Unrolled 2X}
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
{$IFNDEF NoUnroll}
  JGE       @@Last8
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
{$ENDIF}
  JL        @@loop
@@Last8:
  PCMPEQB   MM0, [EDX-8]
  POP       ECX              {Original Length}
  PMOVMSKB  EAX, MM0
  TEST      EAX, EAX
  JNZ       @@Matched2
  EMMS
  RET                        {Finished}
@@Matched:                   {Set Result from 1st Match in EcX}
  POP       EDX              {Original Length}
  ADD       ECX, EDX
@@Matched2:
  EMMS
  BSF       EDX, EAX
  LEA       EAX, [EDX+ECX-7]
end;

function CharPos_JOH_SSE_1_d(Ch : Char; const Str : AnsiString) : Integer;
asm
  TEST      EDX, EDX         {Str = NIL?}
  JZ        @@NotFound       {Yes - Jump}
  MOV       ECX, [EDX-4]     {ECX = Length(Str)}
  CMP       ECX, 8
  JG        @@NotSmall
  TEST      ECX, ECX
  JZ        @@NotFound       {Exit if Length = 0}
@@Small:
  CMP       AL, [EDX]
  JZ        @Found1
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+1]
  JZ        @Found2
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+2]
  JZ        @Found3
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+3]
  JZ        @Found4
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+4]
  JZ        @Found5
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+5]
  JZ        @Found6
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+6]
  JZ        @Found7
  DEC       ECX
  JZ        @@NotFound
  CMP       AL, [EDX+7]
  JZ        @Found8
@@NotFound:
  XOR       EAX, EAX
  RET
@Found1:
  MOV       EAX, 1
  RET
@Found2:
  MOV       EAX, 2
  RET
@Found3:
  MOV       EAX, 3
  RET
@Found4:
  MOV       EAX, 4
  RET
@Found5:
  MOV       EAX, 5
  RET
@Found6:
  MOV       EAX, 6
  RET
@Found7:
  MOV       EAX, 7
  RET
@Found8:
  MOV       EAX, 8
  RET
@@NotSmall:
  MOV       AH, AL
  ADD       EDX, ECX
  MOVD      MM0, EAX
  PSHUFW    MM0, MM0, 0
  PUSH      ECX
  NEG       ECX
@@First8:
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
  JGE       @@Last8
@@Align:
  LEA       EAX, [EDX+ECX]
  AND       EAX, 7
  SUB       ECX, EAX
@@Loop:                      {Loop Unrolled 2X}
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
{$IFNDEF NoUnroll}
  JGE       @@Last8
  MOVQ      MM1, [EDX+ECX]
  ADD       ECX, 8
  PCMPEQB   MM1, MM0         {Compare Next 8 Bytes}
  PMOVMSKB  EAX, MM1
  TEST      EAX, EAX
  JNZ       @@Matched        {Exit on Match at any Position}
  CMP       ECX, -8          {Check if Next Loop would pass String End}
{$ENDIF}
  JL        @@loop
@@Last8:
  PCMPEQB   MM0, [EDX-8]
  POP       ECX              {Original Length}
  PMOVMSKB  EAX, MM0
  TEST      EAX, EAX
  JNZ       @@Matched2
  EMMS
  RET                        {Finished}
@@Matched:                   {Set Result from 1st Match in EcX}
  POP       EDX              {Original Length}
  ADD       ECX, EDX
@@Matched2:
  EMMS
  BSF       EDX, EAX
  LEA       EAX, [EDX+ECX-7]
end;

function CharPos_JOH_SSE2_1_a(Ch : Char; const Str : AnsiString) : Integer;
asm
  test      edx, edx
  jz        @@NullString
  mov       ecx, [edx-4]
  push      ebx
  mov       ebx, eax
  cmp       ecx, 16
  jl        @@Small
@@NotSmall:
  mov       ah, al           {Fill each Byte of XMM1 with AL}
  movd      xmm1, eax
  pshuflw   xmm1, xmm1, 0
  pshufd    xmm1, xmm1, 0
@@First16:
  movups    xmm0, [edx]      {Unaligned}
  pcmpeqb   xmm0, xmm1       {Compare First 16 Characters}
  pmovmskb  eax, xmm0
  test      eax, eax
  jnz       @@FoundStart     {Exit on any Match}
  cmp       ecx, 32
  jl        @@Medium         {If Length(Str) < 32, Check Remainder}
@@Align:
  sub       ecx, 16          {Align Block Reads}
  push      ecx
  mov       eax, edx
  neg       eax
  and       eax, 15
  add       edx, ecx
  neg       ecx
  add       ecx, eax
@@Loop:
  movaps    xmm0, [edx+ecx]  {Aligned}
  pcmpeqb   xmm0, xmm1       {Compare Next 16 Characters}
  pmovmskb  eax, xmm0
  test      eax, eax
  jnz       @@Found          {Exit on any Match}
  add       ecx, 16
  jle       @@Loop
  pop       eax              {Check Remaining Characters}
  add       edx, 16
  add       eax, ecx         {Count from Last Loop End Position}
  jmp       dword ptr [@@JumpTable2-ecx*4]
  nop
  nop
@@NullString:
  xor       eax, eax         {Result = 0}
  ret
  nop
@@FoundStart:
  bsf       eax, eax         {Get Set Bit}
  pop       ebx
  inc       eax              {Set Result}
  ret
  nop
  nop
@@Found:
  pop       edx
  bsf       eax, eax         {Get Set Bit}
  add       edx, ecx
  pop       ebx
  lea       eax, [eax+edx+1] {Set Result}
  ret
@@Medium:
  add       edx, ecx         {End of String}
  mov       eax, 16          {Count from 16}
  jmp       dword ptr [@@JumpTable1-64-ecx*4]
  nop
  nop
@@Small:
  add       edx, ecx         {End of String}
  xor       eax, eax         {Count from 0}
  jmp       dword ptr [@@JumpTable1-ecx*4]
  nop
@@JumpTable1:
  dd        @@NotFound, @@01, @@02, @@03, @@04, @@05, @@06, @@07
  dd        @@08, @@09, @@10, @@11, @@12, @@13, @@14, @@15, @@16
@@JumpTable2:
  dd        @@16, @@15, @@14, @@13, @@12, @@11, @@10, @@09, @@08
  dd        @@07, @@06, @@05, @@04, @@03, @@02, @@01, @@NotFound
@@16:
  add       eax, 1
  cmp       bl, [edx-16]
  je        @@Done
@@15:
  add       eax, 1
  cmp       bl, [edx-15]
  je        @@Done
@@14:
  add       eax, 1
  cmp       bl, [edx-14]
  je        @@Done
@@13:
  add       eax, 1
  cmp       bl, [edx-13]
  je        @@Done
@@12:
  add       eax, 1
  cmp       bl, [edx-12]
  je        @@Done
@@11:
  add       eax, 1
  cmp       bl, [edx-11]
  je        @@Done
@@10:
  add       eax, 1
  cmp       bl, [edx-10]
  je        @@Done
@@09:
  add       eax, 1
  cmp       bl, [edx-9]
  je        @@Done
@@08:
  add       eax, 1
  cmp       bl, [edx-8]
  je        @@Done
@@07:
  add       eax, 1
  cmp       bl, [edx-7]
  je        @@Done
@@06:
  add       eax, 1
  cmp       bl, [edx-6]
  je        @@Done
@@05:
  add       eax, 1
  cmp       bl, [edx-5]
  je        @@Done
@@04:
  add       eax, 1
  cmp       bl, [edx-4]
  je        @@Done
@@03:
  add       eax, 1
  cmp       bl, [edx-3]
  je        @@Done
@@02:
  add       eax, 1
  cmp       bl, [edx-2]
  je        @@Done
@@01:
  add       eax, 1
  cmp       bl, [edx-1]
  je        @@Done
@@NotFound:
  xor       eax, eax
  pop       ebx
  ret
@@Done:
  pop       ebx
end;

procedure Filler1;
asm
 nop
end;

function CharPos_JOH_SSE2_1_b(Ch : Char; const Str : AnsiString) : Integer;
asm
  test      edx, edx
  jz        @@NullString
  mov       ecx, [edx-4]
  push      ebx
  mov       ebx, eax
  cmp       ecx, 16
  jl        @@Small
@@NotSmall:
  mov       ah, al           {Fill each Byte of XMM1 with AL}
  movd      xmm1, eax
  pshuflw   xmm1, xmm1, 0
  pshufd    xmm1, xmm1, 0
@@First16:
  movups    xmm0, [edx]      {Unaligned}
  pcmpeqb   xmm0, xmm1       {Compare First 16 Characters}
  pmovmskb  eax, xmm0
  test      eax, eax
  jnz       @@FoundStart     {Exit on any Match}
  cmp       ecx, 32
  jl        @@Medium         {If Length(Str) < 32, Check Remainder}
@@Align:
  sub       ecx, 16          {Align Block Reads}
  push      ecx
  mov       eax, edx
  neg       eax
  and       eax, 15
  add       edx, ecx
  neg       ecx
  add       ecx, eax
@@Loop:
  movaps    xmm0, [edx+ecx]  {Aligned}
  pcmpeqb   xmm0, xmm1       {Compare Next 16 Characters}
  pmovmskb  eax, xmm0
  test      eax, eax
  jnz       @@Found          {Exit on any Match}
  add       ecx, 16
  jle       @@Loop
  pop       eax              {Check Remaining Characters}
  add       edx, 16
  add       eax, ecx         {Count from Last Loop End Position}
  jmp       dword ptr [@@JumpTable2-ecx*4]
  nop
  nop
@@NullString:
  xor       eax, eax         {Result = 0}
  ret
  nop
@@FoundStart:
  bsf       eax, eax         {Get Set Bit}
  pop       ebx
  inc       eax              {Set Result}
  ret
  nop
  nop
@@Found:
  pop       edx
  bsf       eax, eax         {Get Set Bit}
  add       edx, ecx
  pop       ebx
  lea       eax, [eax+edx+1] {Set Result}
  ret
@@Medium:
  add       edx, ecx         {End of String}
  mov       eax, 16          {Count from 16}
  jmp       dword ptr [@@JumpTable1-64-ecx*4]
  nop
  nop
@@Small:
  add       edx, ecx         {End of String}
  xor       eax, eax         {Count from 0}
  jmp       dword ptr [@@JumpTable1-ecx*4]
  nop
@@JumpTable1:
  dd        @@NotFound, @@01, @@02, @@03, @@04, @@05, @@06, @@07
  dd        @@08, @@09, @@10, @@11, @@12, @@13, @@14, @@15, @@16
@@JumpTable2:
  dd        @@16, @@15, @@14, @@13, @@12, @@11, @@10, @@09, @@08
  dd        @@07, @@06, @@05, @@04, @@03, @@02, @@01, @@NotFound
@@16:
  add       eax, 1
  cmp       bl, [edx-16]
  je        @@Done
@@15:
  add       eax, 1
  cmp       bl, [edx-15]
  je        @@Done
@@14:
  add       eax, 1
  cmp       bl, [edx-14]
  je        @@Done
@@13:
  add       eax, 1
  cmp       bl, [edx-13]
  je        @@Done
@@12:
  add       eax, 1
  cmp       bl, [edx-12]
  je        @@Done
@@11:
  add       eax, 1
  cmp       bl, [edx-11]
  je        @@Done
@@10:
  add       eax, 1
  cmp       bl, [edx-10]
  je        @@Done
@@09:
  add       eax, 1
  cmp       bl, [edx-9]
  je        @@Done
@@08:
  add       eax, 1
  cmp       bl, [edx-8]
  je        @@Done
@@07:
  add       eax, 1
  cmp       bl, [edx-7]
  je        @@Done
@@06:
  add       eax, 1
  cmp       bl, [edx-6]
  je        @@Done
@@05:
  add       eax, 1
  cmp       bl, [edx-5]
  je        @@Done
@@04:
  add       eax, 1
  cmp       bl, [edx-4]
  je        @@Done
@@03:
  add       eax, 1
  cmp       bl, [edx-3]
  je        @@Done
@@02:
  add       eax, 1
  cmp       bl, [edx-2]
  je        @@Done
@@01:
  add       eax, 1
  cmp       bl, [edx-1]
  je        @@Done
@@NotFound:
  xor       eax, eax
  pop       ebx
  ret
@@Done:
  pop       ebx
end;

procedure Filler2;
asm
 nop
end;

function CharPos_JOH_SSE2_1_c(Ch : Char; const Str : AnsiString) : Integer;
asm
  test      edx, edx
  jz        @@NullString
  mov       ecx, [edx-4]
  push      ebx
  mov       ebx, eax
  cmp       ecx, 16
  jl        @@Small
@@NotSmall:
  mov       ah, al           {Fill each Byte of XMM1 with AL}
  movd      xmm1, eax
  pshuflw   xmm1, xmm1, 0
  pshufd    xmm1, xmm1, 0
@@First16:
  movups    xmm0, [edx]      {Unaligned}
  pcmpeqb   xmm0, xmm1       {Compare First 16 Characters}
  pmovmskb  eax, xmm0
  test      eax, eax
  jnz       @@FoundStart     {Exit on any Match}
  cmp       ecx, 32
  jl        @@Medium         {If Length(Str) < 32, Check Remainder}
@@Align:
  sub       ecx, 16          {Align Block Reads}
  push      ecx
  mov       eax, edx
  neg       eax
  and       eax, 15
  add       edx, ecx
  neg       ecx
  add       ecx, eax
@@Loop:
  movaps    xmm0, [edx+ecx]  {Aligned}
  pcmpeqb   xmm0, xmm1       {Compare Next 16 Characters}
  pmovmskb  eax, xmm0
  test      eax, eax
  jnz       @@Found          {Exit on any Match}
  add       ecx, 16
  jle       @@Loop
  pop       eax              {Check Remaining Characters}
  add       edx, 16
  add       eax, ecx         {Count from Last Loop End Position}
  jmp       dword ptr [@@JumpTable2-ecx*4]
  nop
  nop
@@NullString:
  xor       eax, eax         {Result = 0}
  ret
  nop
@@FoundStart:
  bsf       eax, eax         {Get Set Bit}
  pop       ebx
  inc       eax              {Set Result}
  ret
  nop
  nop
@@Found:
  pop       edx
  bsf       eax, eax         {Get Set Bit}
  add       edx, ecx
  pop       ebx
  lea       eax, [eax+edx+1] {Set Result}
  ret
@@Medium:
  add       edx, ecx         {End of String}
  mov       eax, 16          {Count from 16}
  jmp       dword ptr [@@JumpTable1-64-ecx*4]
  nop
  nop
@@Small:
  add       edx, ecx         {End of String}
  xor       eax, eax         {Count from 0}
  jmp       dword ptr [@@JumpTable1-ecx*4]
  nop
@@JumpTable1:
  dd        @@NotFound, @@01, @@02, @@03, @@04, @@05, @@06, @@07
  dd        @@08, @@09, @@10, @@11, @@12, @@13, @@14, @@15, @@16
@@JumpTable2:
  dd        @@16, @@15, @@14, @@13, @@12, @@11, @@10, @@09, @@08
  dd        @@07, @@06, @@05, @@04, @@03, @@02, @@01, @@NotFound
@@16:
  add       eax, 1
  cmp       bl, [edx-16]
  je        @@Done
@@15:
  add       eax, 1
  cmp       bl, [edx-15]
  je        @@Done
@@14:
  add       eax, 1
  cmp       bl, [edx-14]
  je        @@Done
@@13:
  add       eax, 1
  cmp       bl, [edx-13]
  je        @@Done
@@12:
  add       eax, 1
  cmp       bl, [edx-12]
  je        @@Done
@@11:
  add       eax, 1
  cmp       bl, [edx-11]
  je        @@Done
@@10:
  add       eax, 1
  cmp       bl, [edx-10]
  je        @@Done
@@09:
  add       eax, 1
  cmp       bl, [edx-9]
  je        @@Done
@@08:
  add       eax, 1
  cmp       bl, [edx-8]
  je        @@Done
@@07:
  add       eax, 1
  cmp       bl, [edx-7]
  je        @@Done
@@06:
  add       eax, 1
  cmp       bl, [edx-6]
  je        @@Done
@@05:
  add       eax, 1
  cmp       bl, [edx-5]
  je        @@Done
@@04:
  add       eax, 1
  cmp       bl, [edx-4]
  je        @@Done
@@03:
  add       eax, 1
  cmp       bl, [edx-3]
  je        @@Done
@@02:
  add       eax, 1
  cmp       bl, [edx-2]
  je        @@Done
@@01:
  add       eax, 1
  cmp       bl, [edx-1]
  je        @@Done
@@NotFound:
  xor       eax, eax
  pop       ebx
  ret
@@Done:
  pop       ebx
end;

procedure Filler4;
asm
 nop
end;

function CharPos_JOH_SSE2_1_d(Ch : Char; const Str : AnsiString) : Integer;
asm
  test      edx, edx
  jz        @@NullString
  mov       ecx, [edx-4]
  push      ebx
  mov       ebx, eax
  cmp       ecx, 16
  jl        @@Small
@@NotSmall:
  mov       ah, al           {Fill each Byte of XMM1 with AL}
  movd      xmm1, eax
  pshuflw   xmm1, xmm1, 0
  pshufd    xmm1, xmm1, 0
@@First16:
  movups    xmm0, [edx]      {Unaligned}
  pcmpeqb   xmm0, xmm1       {Compare First 16 Characters}
  pmovmskb  eax, xmm0
  test      eax, eax
  jnz       @@FoundStart     {Exit on any Match}
  cmp       ecx, 32
  jl        @@Medium         {If Length(Str) < 32, Check Remainder}
@@Align:
  sub       ecx, 16          {Align Block Reads}
  push      ecx
  mov       eax, edx
  neg       eax
  and       eax, 15
  add       edx, ecx
  neg       ecx
  add       ecx, eax
@@Loop:
  movaps    xmm0, [edx+ecx]  {Aligned}
  pcmpeqb   xmm0, xmm1       {Compare Next 16 Characters}
  pmovmskb  eax, xmm0
  test      eax, eax
  jnz       @@Found          {Exit on any Match}
  add       ecx, 16
  jle       @@Loop
  pop       eax              {Check Remaining Characters}
  add       edx, 16
  add       eax, ecx         {Count from Last Loop End Position}
  jmp       dword ptr [@@JumpTable2-ecx*4]
  nop
  nop
@@NullString:
  xor       eax, eax         {Result = 0}
  ret
  nop
@@FoundStart:
  bsf       eax, eax         {Get Set Bit}
  pop       ebx
  inc       eax              {Set Result}
  ret
  nop
  nop
@@Found:
  pop       edx
  bsf       eax, eax         {Get Set Bit}
  add       edx, ecx
  pop       ebx
  lea       eax, [eax+edx+1] {Set Result}
  ret
@@Medium:
  add       edx, ecx         {End of String}
  mov       eax, 16          {Count from 16}
  jmp       dword ptr [@@JumpTable1-64-ecx*4]
  nop
  nop
@@Small:
  add       edx, ecx         {End of String}
  xor       eax, eax         {Count from 0}
  jmp       dword ptr [@@JumpTable1-ecx*4]
  nop
@@JumpTable1:
  dd        @@NotFound, @@01, @@02, @@03, @@04, @@05, @@06, @@07
  dd        @@08, @@09, @@10, @@11, @@12, @@13, @@14, @@15, @@16
@@JumpTable2:
  dd        @@16, @@15, @@14, @@13, @@12, @@11, @@10, @@09, @@08
  dd        @@07, @@06, @@05, @@04, @@03, @@02, @@01, @@NotFound
@@16:
  add       eax, 1
  cmp       bl, [edx-16]
  je        @@Done
@@15:
  add       eax, 1
  cmp       bl, [edx-15]
  je        @@Done
@@14:
  add       eax, 1
  cmp       bl, [edx-14]
  je        @@Done
@@13:
  add       eax, 1
  cmp       bl, [edx-13]
  je        @@Done
@@12:
  add       eax, 1
  cmp       bl, [edx-12]
  je        @@Done
@@11:
  add       eax, 1
  cmp       bl, [edx-11]
  je        @@Done
@@10:
  add       eax, 1
  cmp       bl, [edx-10]
  je        @@Done
@@09:
  add       eax, 1
  cmp       bl, [edx-9]
  je        @@Done
@@08:
  add       eax, 1
  cmp       bl, [edx-8]
  je        @@Done
@@07:
  add       eax, 1
  cmp       bl, [edx-7]
  je        @@Done
@@06:
  add       eax, 1
  cmp       bl, [edx-6]
  je        @@Done
@@05:
  add       eax, 1
  cmp       bl, [edx-5]
  je        @@Done
@@04:
  add       eax, 1
  cmp       bl, [edx-4]
  je        @@Done
@@03:
  add       eax, 1
  cmp       bl, [edx-3]
  je        @@Done
@@02:
  add       eax, 1
  cmp       bl, [edx-2]
  je        @@Done
@@01:
  add       eax, 1
  cmp       bl, [edx-1]
  je        @@Done
@@NotFound:
  xor       eax, eax
  pop       ebx
  ret
@@Done:
  pop       ebx
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

end.
