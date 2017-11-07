unit StrCompDFLUnit;

interface

function StrComp_DFL_Pas_6_a(const Str1, Str2: PChar): Integer;
function StrComp_DFL_Pas_6_b(const Str1, Str2: PChar): Integer;
function StrComp_DFL_Pas_6_c(const Str1, Str2: PChar): Integer;
function StrComp_DFL_Pas_6_d(const Str1, Str2: PChar): Integer;

implementation


//Author:            Dennis Fredberg Lauritzen
//Date:              23/2 2004
//Optimized for:     Blended
//Instructionset(s): IA32

function StrComp_DFL_Pas_6_a(const Str1, Str2: PChar): Integer;
var
 C1, C2 : Char;
 Str1x, Str2x : PChar;
label
 L1, L2;

begin
 Str1x := Str1;
 Str2x := Str2;
 repeat
  C1 := Str1x[0];
  C2 := Str2x[0];
  Inc(Str1x);
  Inc(Str2x);
  if C1 <> C2 then
   goto L1;
  if ((C1 = #0) or (C2 = #0)) then
  Break;
  C1 := Str1x[0];
  C2 := Str2x[0];
  Inc(Str1x);
  Inc(Str2x);
  if C1 <> C2 then
   goto L1;
  if ((C1 = #0) or (C2 = #0)) then
  Break;
  C1 := Str1x[0];
  C2 := Str2x[0];
  Inc(Str1x);
  Inc(Str2x);
  if C1 <> C2 then
   goto L1;
  if ((C1 = #0) or (C2 = #0)) then
  Break;
  C1 := Str1x[0];
  C2 := Str2x[0];
  Inc(Str1x);
  Inc(Str2x);
  if C1 <> C2 then
   goto L1
 until((C1 = #0) or (C2 = #0));
 Result := 0;
 Exit;
 L1 :
  begin
   if C1 < C2 then
    Result := -1
   else
    Result := 1;
  end;
end;

function StrComp_DFL_Pas_6_b(const Str1, Str2: PChar): Integer;
var
 C1, C2 : Char;
 Str1x, Str2x : PChar;
label
 L1, L2;

begin
 Str1x := Str1;
 Str2x := Str2;
 repeat
  C1 := Str1x[0];
  C2 := Str2x[0];
  Inc(Str1x);
  Inc(Str2x);
  if C1 <> C2 then
   goto L1;
  if ((C1 = #0) or (C2 = #0)) then
  Break;
  C1 := Str1x[0];
  C2 := Str2x[0];
  Inc(Str1x);
  Inc(Str2x);
  if C1 <> C2 then
   goto L1;
  if ((C1 = #0) or (C2 = #0)) then
  Break;
  C1 := Str1x[0];
  C2 := Str2x[0];
  Inc(Str1x);
  Inc(Str2x);
  if C1 <> C2 then
   goto L1;
  if ((C1 = #0) or (C2 = #0)) then
  Break;
  C1 := Str1x[0];
  C2 := Str2x[0];
  Inc(Str1x);
  Inc(Str2x);
  if C1 <> C2 then
   goto L1
 until((C1 = #0) or (C2 = #0));
 Result := 0;
 Exit;
 L1 :
  begin
   if C1 < C2 then
    Result := -1
   else
    Result := 1;
  end;
end;

function StrComp_DFL_Pas_6_c(const Str1, Str2: PChar): Integer;
var
 C1, C2 : Char;
 Str1x, Str2x : PChar;
label
 L1, L2;

begin
 Str1x := Str1;
 Str2x := Str2;
 repeat
  C1 := Str1x[0];
  C2 := Str2x[0];
  Inc(Str1x);
  Inc(Str2x);
  if C1 <> C2 then
   goto L1;
  if ((C1 = #0) or (C2 = #0)) then
  Break;
  C1 := Str1x[0];
  C2 := Str2x[0];
  Inc(Str1x);
  Inc(Str2x);
  if C1 <> C2 then
   goto L1;
  if ((C1 = #0) or (C2 = #0)) then
  Break;
  C1 := Str1x[0];
  C2 := Str2x[0];
  Inc(Str1x);
  Inc(Str2x);
  if C1 <> C2 then
   goto L1;
  if ((C1 = #0) or (C2 = #0)) then
  Break;
  C1 := Str1x[0];
  C2 := Str2x[0];
  Inc(Str1x);
  Inc(Str2x);
  if C1 <> C2 then
   goto L1
 until((C1 = #0) or (C2 = #0));
 Result := 0;
 Exit;
 L1 :
  begin
   if C1 < C2 then
    Result := -1
   else
    Result := 1;
  end;
end;

function StrComp_DFL_Pas_6_d(const Str1, Str2: PChar): Integer;
var
 C1, C2 : Char;
 Str1x, Str2x : PChar;
label
 L1, L2;

begin
 Str1x := Str1;
 Str2x := Str2;
 repeat
  C1 := Str1x[0];
  C2 := Str2x[0];
  Inc(Str1x);
  Inc(Str2x);
  if C1 <> C2 then
   goto L1;
  if ((C1 = #0) or (C2 = #0)) then
  Break;
  C1 := Str1x[0];
  C2 := Str2x[0];
  Inc(Str1x);
  Inc(Str2x);
  if C1 <> C2 then
   goto L1;
  if ((C1 = #0) or (C2 = #0)) then
  Break;
  C1 := Str1x[0];
  C2 := Str2x[0];
  Inc(Str1x);
  Inc(Str2x);
  if C1 <> C2 then
   goto L1;
  if ((C1 = #0) or (C2 = #0)) then
  Break;
  C1 := Str1x[0];
  C2 := Str2x[0];
  Inc(Str1x);
  Inc(Str2x);
  if C1 <> C2 then
   goto L1
 until((C1 = #0) or (C2 = #0));
 Result := 0;
 Exit;
 L1 :
  begin
   if C1 < C2 then
    Result := -1
   else
    Result := 1;
  end;
end;

end.
