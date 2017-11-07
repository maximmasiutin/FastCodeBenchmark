unit CompareStrDKCUnit;

interface

function CompareStr_DKC_Pas_11_a(const S1, S2: string): Integer;//+
function CompareStr_DKC_Pas_11_b(const S1, S2: string): Integer;//+
function CompareStr_DKC_Pas_11_c(const S1, S2: string): Integer;//+
function CompareStr_DKC_Pas_11_d(const S1, S2: string): Integer;//+
function CompareStr_DKC_Pas_12_a(const S1, S2: string): Integer;
function CompareStr_DKC_Pas_12_b(const S1, S2: string): Integer;
function CompareStr_DKC_Pas_12_c(const S1, S2: string): Integer;
function CompareStr_DKC_Pas_12_d(const S1, S2: string): Integer;
function CompareStr_DKC_IA32_20_a(const S1, S2: string): Integer;
function CompareStr_DKC_IA32_20_b(const S1, S2: string): Integer;
function CompareStr_DKC_IA32_20_c(const S1, S2: string): Integer;
function CompareStr_DKC_IA32_20_d(const S1, S2: string): Integer;
function CompareStr_DKC_IA32ext_2_a(const S1, S2: string): Integer;//+
function CompareStr_DKC_IA32ext_2_b(const S1, S2: string): Integer;//+
function CompareStr_DKC_IA32ext_2_c(const S1, S2: string): Integer;//+
function CompareStr_DKC_IA32ext_2_d(const S1, S2: string): Integer;//+
function CompareStr_DKC_IA32ext_3_a(const S1, S2: string): Integer;//+
function CompareStr_DKC_IA32ext_3_b(const S1, S2: string): Integer;//+
function CompareStr_DKC_IA32ext_3_c(const S1, S2: string): Integer;//+
function CompareStr_DKC_IA32ext_3_d(const S1, S2: string): Integer;//+
function CompareStr_DKC_IA32ext_4_a(const S1, S2: string): Integer;//+
function CompareStr_DKC_IA32ext_4_b(const S1, S2: string): Integer;//+
function CompareStr_DKC_IA32ext_4_c(const S1, S2: string): Integer;//+
function CompareStr_DKC_IA32ext_4_d(const S1, S2: string): Integer;//+
function CompareStr_DKC_MMX_3_a(const S1, S2: string): Integer;
function CompareStr_DKC_MMX_3_b(const S1, S2: string): Integer;
function CompareStr_DKC_MMX_3_c(const S1, S2: string): Integer;
function CompareStr_DKC_MMX_3_d(const S1, S2: string): Integer;
function CompareStr_DKC_MMX_4_a(const S1, S2: string): Integer;
function CompareStr_DKC_MMX_4_b(const S1, S2: string): Integer;
function CompareStr_DKC_MMX_4_c(const S1, S2: string): Integer;
function CompareStr_DKC_MMX_4_d(const S1, S2: string): Integer;
function CompareStr_DKC_MMX_5_a(const S1, S2: string): Integer;
function CompareStr_DKC_MMX_5_b(const S1, S2: string): Integer;
function CompareStr_DKC_MMX_5_c(const S1, S2: string): Integer;
function CompareStr_DKC_MMX_5_d(const S1, S2: string): Integer;
function CompareStr_DKC_SSE2_3_a(const S1, S2: string): Integer;
function CompareStr_DKC_SSE2_3_b(const S1, S2: string): Integer;
function CompareStr_DKC_SSE2_3_c(const S1, S2: string): Integer;
function CompareStr_DKC_SSE2_3_d(const S1, S2: string): Integer;
{function CompareStr_DKC_SSE3_3_a(const S1, S2: string): Integer;
function CompareStr_DKC_SSE3_3_b(const S1, S2: string): Integer;
function CompareStr_DKC_SSE3_3_c(const S1, S2: string): Integer;
function CompareStr_DKC_SSE3_3_d(const S1, S2: string): Integer;
}
implementation

uses
 SysUtils, Math;

//Author:            Dennis Kjaer Christensen
//Date:              7/9 2005
//Instructionset(s): IA32

function CompareStr_DKC_Pas_11_a(const S1, S2: string): Integer;
var
 S1Length, S2Length, SLengthMin, Stop : Integer;
 PInt1, PInt2 : PInteger;
 FirstChar1, FirstChar2 : Char;

begin
 if S1 <> '' then
  S1Length := PInteger(Integer(S1)-4)^
 else
  S1Length := 0;
 if S2 <> '' then
  S2Length := PInteger(Integer(S2)-4)^
 else
  S2Length := 0;
 if (S1Length = 0) and (S2Length = 0) then
  begin
   Result := 0;
   Exit;
  end;
 if (S1Length <> 0) and (S2Length = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if (S1Length = 0) and (S2Length <> 0) then
  begin
   Result := -1;
   Exit;
  end;
 FirstChar1 := S1[1];
 FirstChar2 := S2[1];
 if FirstChar1 < FirstChar2 then
  begin
   Result := -1;
   Exit;
  end;
 if FirstChar1 > FirstChar2 then
  begin
   Result := 1;
   Exit;
  end;
 if S1Length <= S2Length then
  SLengthMin := S1Length
 else
  SLengthMin := S2Length;
 if SLengthMin >= 8 then
  begin
   Stop := SLengthMin-7;
   Result := 1;
   PInt1 := Pointer(S1);
   PInt2 := Pointer(S2);
   repeat
    if PInt1^ <> PInt2^ then
     Break;
    Inc(Result,4);
    Inc(PInt1);
    Inc(PInt2);
    if PInt1^ <> PInt2^ then
     Break;
    Inc(Result,4);
    Inc(PInt1);
    Inc(PInt2);
    until(Result > Stop);
   if Result <= SLengthMin then
    begin
     repeat
      if Ord(S1[Result]) <> Ord(S2[Result]) then
       begin
        if Ord(S1[Result]) < Ord(S2[Result]) then
         Result := -Result;
        Exit;
       end;
      Inc(Result);
     until(Result > SLengthMin);
    end;
  end
 else
  begin
   Result := 1;
   repeat
    if Ord(S1[Result]) <> Ord(S2[Result]) then
     begin
      if Ord(S1[Result]) < Ord(S2[Result]) then
       Result := -Result;
      Exit;
     end;
    Inc(Result);
   until(Result > SLengthMin);
  end;
 if S1Length = S2Length then
  Result := 0
 else if S1Length > S2Length then
  Result := 1
 else
  Result := -1;
end;

function CompareStr_DKC_Pas_11_b(const S1, S2: string): Integer;
var
 S1Length, S2Length, SLengthMin, Stop : Integer;
 PInt1, PInt2 : PInteger;
 FirstChar1, FirstChar2 : Char;

begin
 if S1 <> '' then
  S1Length := PInteger(Integer(S1)-4)^
 else
  S1Length := 0;
 if S2 <> '' then
  S2Length := PInteger(Integer(S2)-4)^
 else
  S2Length := 0;
 if (S1Length = 0) and (S2Length = 0) then
  begin
   Result := 0;
   Exit;
  end;
 if (S1Length <> 0) and (S2Length = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if (S1Length = 0) and (S2Length <> 0) then
  begin
   Result := -1;
   Exit;
  end;
 FirstChar1 := S1[1];
 FirstChar2 := S2[1];
 if FirstChar1 < FirstChar2 then
  begin
   Result := -1;
   Exit;
  end;
 if FirstChar1 > FirstChar2 then
  begin
   Result := 1;
   Exit;
  end;
 if S1Length <= S2Length then
  SLengthMin := S1Length
 else
  SLengthMin := S2Length;
 if SLengthMin >= 8 then
  begin
   Stop := SLengthMin-7;
   Result := 1;
   PInt1 := Pointer(S1);
   PInt2 := Pointer(S2);
   repeat
    if PInt1^ <> PInt2^ then
     Break;
    Inc(Result,4);
    Inc(PInt1);
    Inc(PInt2);
    if PInt1^ <> PInt2^ then
     Break;
    Inc(Result,4);
    Inc(PInt1);
    Inc(PInt2);
    until(Result > Stop);
   if Result <= SLengthMin then
    begin
     repeat
      if Ord(S1[Result]) <> Ord(S2[Result]) then
       begin
        if Ord(S1[Result]) < Ord(S2[Result]) then
         Result := -Result;
        Exit;
       end;
      Inc(Result);
     until(Result > SLengthMin);
    end;
  end
 else
  begin
   Result := 1;
   repeat
    if Ord(S1[Result]) <> Ord(S2[Result]) then
     begin
      if Ord(S1[Result]) < Ord(S2[Result]) then
       Result := -Result;
      Exit;
     end;
    Inc(Result);
   until(Result > SLengthMin);
  end;
 if S1Length = S2Length then
  Result := 0
 else if S1Length > S2Length then
  Result := 1
 else
  Result := -1;
end;

procedure Filler8;
asm
 nop
end;

function CompareStr_DKC_Pas_11_c(const S1, S2: string): Integer;
var
 S1Length, S2Length, SLengthMin, Stop : Integer;
 PInt1, PInt2 : PInteger;
 FirstChar1, FirstChar2 : Char;
begin

 if S1 <> '' then
  S1Length := PInteger(Integer(S1)-4)^
 else
  S1Length := 0;
 if S2 <> '' then
  S2Length := PInteger(Integer(S2)-4)^
 else
  S2Length := 0;
 if (S1Length = 0) and (S2Length = 0) then
  begin
   Result := 0;
   Exit;
  end;
 if (S1Length <> 0) and (S2Length = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if (S1Length = 0) and (S2Length <> 0) then
  begin
   Result := -1;
   Exit;
  end;
 FirstChar1 := S1[1];
 FirstChar2 := S2[1];
 if FirstChar1 < FirstChar2 then
  begin
   Result := -1;
   Exit;
  end;
 if FirstChar1 > FirstChar2 then
  begin
   Result := 1;
   Exit;
  end;
 if S1Length <= S2Length then
  SLengthMin := S1Length
 else
  SLengthMin := S2Length;
 if SLengthMin >= 8 then
  begin
   Stop := SLengthMin-7;
   Result := 1;
   PInt1 := Pointer(S1);
   PInt2 := Pointer(S2);
   repeat
    if PInt1^ <> PInt2^ then
     Break;
    Inc(Result,4);
    Inc(PInt1);
    Inc(PInt2);
    if PInt1^ <> PInt2^ then
     Break;
    Inc(Result,4);
    Inc(PInt1);
    Inc(PInt2);
    until(Result > Stop);
   if Result <= SLengthMin then
    begin
     repeat
      if Ord(S1[Result]) <> Ord(S2[Result]) then
       begin
        if Ord(S1[Result]) < Ord(S2[Result]) then
         Result := -Result;
        Exit;
       end;
      Inc(Result);
     until(Result > SLengthMin);
    end;
  end
 else
  begin
   Result := 1;
   repeat
    if Ord(S1[Result]) <> Ord(S2[Result]) then
     begin
      if Ord(S1[Result]) < Ord(S2[Result]) then
       Result := -Result;
      Exit;
     end;
    Inc(Result);
   until(Result > SLengthMin);
  end;
 if S1Length = S2Length then
  Result := 0
 else if S1Length > S2Length then
  Result := 1
 else
  Result := -1;
end;

function CompareStr_DKC_Pas_11_d(const S1, S2: string): Integer;
var
 S1Length, S2Length, SLengthMin, Stop : Integer;
 PInt1, PInt2 : PInteger;
 FirstChar1, FirstChar2 : Char;

begin
 if S1 <> '' then
  S1Length := PInteger(Integer(S1)-4)^
 else
  S1Length := 0;
 if S2 <> '' then
  S2Length := PInteger(Integer(S2)-4)^
 else
  S2Length := 0;
 if (S1Length = 0) and (S2Length = 0) then
  begin
   Result := 0;
   Exit;
  end;
 if (S1Length <> 0) and (S2Length = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if (S1Length = 0) and (S2Length <> 0) then
  begin
   Result := -1;
   Exit;
  end;
 FirstChar1 := S1[1];
 FirstChar2 := S2[1];
 if FirstChar1 < FirstChar2 then
  begin
   Result := -1;
   Exit;
  end;
 if FirstChar1 > FirstChar2 then
  begin
   Result := 1;
   Exit;
  end;
 if S1Length <= S2Length then
  SLengthMin := S1Length
 else
  SLengthMin := S2Length;
 if SLengthMin >= 8 then
  begin
   Stop := SLengthMin-7;
   Result := 1;
   PInt1 := Pointer(S1);
   PInt2 := Pointer(S2);
   repeat
    if PInt1^ <> PInt2^ then
     Break;
    Inc(Result,4);
    Inc(PInt1);
    Inc(PInt2);
    if PInt1^ <> PInt2^ then
     Break;
    Inc(Result,4);
    Inc(PInt1);
    Inc(PInt2);
    until(Result > Stop);
   if Result <= SLengthMin then
    begin
     repeat
      if Ord(S1[Result]) <> Ord(S2[Result]) then
       begin
        if Ord(S1[Result]) < Ord(S2[Result]) then
         Result := -Result;
        Exit;
       end;
      Inc(Result);
     until(Result > SLengthMin);
    end;
  end
 else
  begin
   Result := 1;
   repeat
    if Ord(S1[Result]) <> Ord(S2[Result]) then
     begin
      if Ord(S1[Result]) < Ord(S2[Result]) then
       Result := -Result;
      Exit;
     end;
    Inc(Result);
   until(Result > SLengthMin);
  end;
 if S1Length = S2Length then
  Result := 0
 else if S1Length > S2Length then
  Result := 1
 else
  Result := -1;
end;

//Author:            Dennis Kjaer Christensen
//Date:              14/9 2005
//Instructionset(s): IA32

function CompareStr_DKC_Pas_12_a(const S1, S2: string): Integer;
var
 S1Length, S2Length, SLengthMin, Stop : Integer;
 PInt1, PInt2 : PInteger;
 FirstChar1, FirstChar2 : Char;

begin
 Result := 0;
 PInt1 := Pointer(S1);
 PInt2 := Pointer(S2);
 if (PInt1 = PInt2) then
  Exit;
 if S1 <> '' then
  S1Length := PInteger(Integer(S1)-4)^
 else
  S1Length := 0;
 if S2 <> '' then
  S2Length := PInteger(Integer(S2)-4)^
 else
  S2Length := 0;
 if (S1Length = 0) and (S2Length = 0) then
  Exit;
 if (S1Length <> 0) and (S2Length = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if (S1Length = 0) and (S2Length <> 0) then
  begin
   Result := -1;
   Exit;
  end;
 FirstChar1 := S1[1];
 FirstChar2 := S2[1];
 if FirstChar1 < FirstChar2 then
  begin
   Result := -1;
   Exit;
  end;
 if FirstChar1 > FirstChar2 then
  begin
   Result := 1;
   Exit;
  end;
 if S1Length <= S2Length then
  SLengthMin := S1Length
 else
  SLengthMin := S2Length;
 if SLengthMin >= 8 then
  begin
   Stop := SLengthMin-7;
   Result := 1;
   repeat
    if PInt1^ <> PInt2^ then
     Break;
    Inc(Result,4);
    Inc(PInt1);
    Inc(PInt2);
    if PInt1^ <> PInt2^ then
     Break;
    Inc(Result,4);
    Inc(PInt1);
    Inc(PInt2);
    until(Result > Stop);
   if Result <= SLengthMin then
    begin
     repeat
      if Ord(S1[Result]) <> Ord(S2[Result]) then
       begin
        if Ord(S1[Result]) < Ord(S2[Result]) then
         Result := -Result;
        Exit;
       end;
      Inc(Result);
     until(Result > SLengthMin);
    end;
  end
 else
  begin
   Result := 1;
   repeat
    if Ord(S1[Result]) <> Ord(S2[Result]) then
     begin
      if Ord(S1[Result]) < Ord(S2[Result]) then
       Result := -Result;
      Exit;
     end;
    Inc(Result);
   until(Result > SLengthMin);
  end;
 if S1Length = S2Length then
  Result := 0
 else if S1Length > S2Length then
  Result := 1
 else
  Result := -1;
end;

function CompareStr_DKC_Pas_12_b(const S1, S2: string): Integer;
var
 S1Length, S2Length, SLengthMin, Stop : Integer;
 PInt1, PInt2 : PInteger;
 FirstChar1, FirstChar2 : Char;

begin
 Result := 0;
 PInt1 := Pointer(S1);
 PInt2 := Pointer(S2);
 if (PInt1 = PInt2) then
  Exit;
 if S1 <> '' then
  S1Length := PInteger(Integer(S1)-4)^
 else
  S1Length := 0;
 if S2 <> '' then
  S2Length := PInteger(Integer(S2)-4)^
 else
  S2Length := 0;
 if (S1Length = 0) and (S2Length = 0) then
  Exit;
 if (S1Length <> 0) and (S2Length = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if (S1Length = 0) and (S2Length <> 0) then
  begin
   Result := -1;
   Exit;
  end;
 FirstChar1 := S1[1];
 FirstChar2 := S2[1];
 if FirstChar1 < FirstChar2 then
  begin
   Result := -1;
   Exit;
  end;
 if FirstChar1 > FirstChar2 then
  begin
   Result := 1;
   Exit;
  end;
 if S1Length <= S2Length then
  SLengthMin := S1Length
 else
  SLengthMin := S2Length;
 if SLengthMin >= 8 then
  begin
   Stop := SLengthMin-7;
   Result := 1;
   repeat
    if PInt1^ <> PInt2^ then
     Break;
    Inc(Result,4);
    Inc(PInt1);
    Inc(PInt2);
    if PInt1^ <> PInt2^ then
     Break;
    Inc(Result,4);
    Inc(PInt1);
    Inc(PInt2);
    until(Result > Stop);
   if Result <= SLengthMin then
    begin
     repeat
      if Ord(S1[Result]) <> Ord(S2[Result]) then
       begin
        if Ord(S1[Result]) < Ord(S2[Result]) then
         Result := -Result;
        Exit;
       end;
      Inc(Result);
     until(Result > SLengthMin);
    end;
  end
 else
  begin
   Result := 1;
   repeat
    if Ord(S1[Result]) <> Ord(S2[Result]) then
     begin
      if Ord(S1[Result]) < Ord(S2[Result]) then
       Result := -Result;
      Exit;
     end;
    Inc(Result);
   until(Result > SLengthMin);
  end;
 if S1Length = S2Length then
  Result := 0
 else if S1Length > S2Length then
  Result := 1
 else
  Result := -1;
end;

function CompareStr_DKC_Pas_12_c(const S1, S2: string): Integer;
var
 S1Length, S2Length, SLengthMin, Stop : Integer;
 PInt1, PInt2 : PInteger;
 FirstChar1, FirstChar2 : Char;

begin
 Result := 0;
 PInt1 := Pointer(S1);
 PInt2 := Pointer(S2);
 if (PInt1 = PInt2) then
  Exit;
 if S1 <> '' then
  S1Length := PInteger(Integer(S1)-4)^
 else
  S1Length := 0;
 if S2 <> '' then
  S2Length := PInteger(Integer(S2)-4)^
 else
  S2Length := 0;
 if (S1Length = 0) and (S2Length = 0) then
  Exit;
 if (S1Length <> 0) and (S2Length = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if (S1Length = 0) and (S2Length <> 0) then
  begin
   Result := -1;
   Exit;
  end;
 FirstChar1 := S1[1];
 FirstChar2 := S2[1];
 if FirstChar1 < FirstChar2 then
  begin
   Result := -1;
   Exit;
  end;
 if FirstChar1 > FirstChar2 then
  begin
   Result := 1;
   Exit;
  end;
 if S1Length <= S2Length then
  SLengthMin := S1Length
 else
  SLengthMin := S2Length;
 if SLengthMin >= 8 then
  begin
   Stop := SLengthMin-7;
   Result := 1;
   repeat
    if PInt1^ <> PInt2^ then
     Break;
    Inc(Result,4);
    Inc(PInt1);
    Inc(PInt2);
    if PInt1^ <> PInt2^ then
     Break;
    Inc(Result,4);
    Inc(PInt1);
    Inc(PInt2);
    until(Result > Stop);
   if Result <= SLengthMin then
    begin
     repeat
      if Ord(S1[Result]) <> Ord(S2[Result]) then
       begin
        if Ord(S1[Result]) < Ord(S2[Result]) then
         Result := -Result;
        Exit;
       end;
      Inc(Result);
     until(Result > SLengthMin);
    end;
  end
 else
  begin
   Result := 1;
   repeat
    if Ord(S1[Result]) <> Ord(S2[Result]) then
     begin
      if Ord(S1[Result]) < Ord(S2[Result]) then
       Result := -Result;
      Exit;
     end;
    Inc(Result);
   until(Result > SLengthMin);
  end;
 if S1Length = S2Length then
  Result := 0
 else if S1Length > S2Length then
  Result := 1
 else
  Result := -1;
end;

function CompareStr_DKC_Pas_12_d(const S1, S2: string): Integer;
var
 S1Length, S2Length, SLengthMin, Stop : Integer;
 PInt1, PInt2 : PInteger;
 FirstChar1, FirstChar2 : Char;

begin
 Result := 0;
 PInt1 := Pointer(S1);
 PInt2 := Pointer(S2);
 if (PInt1 = PInt2) then
  Exit;
 if S1 <> '' then
  S1Length := PInteger(Integer(S1)-4)^
 else
  S1Length := 0;
 if S2 <> '' then
  S2Length := PInteger(Integer(S2)-4)^
 else
  S2Length := 0;
 if (S1Length = 0) and (S2Length = 0) then
  Exit;
 if (S1Length <> 0) and (S2Length = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if (S1Length = 0) and (S2Length <> 0) then
  begin
   Result := -1;
   Exit;
  end;
 FirstChar1 := S1[1];
 FirstChar2 := S2[1];
 if FirstChar1 < FirstChar2 then
  begin
   Result := -1;
   Exit;
  end;
 if FirstChar1 > FirstChar2 then
  begin
   Result := 1;
   Exit;
  end;
 if S1Length <= S2Length then
  SLengthMin := S1Length
 else
  SLengthMin := S2Length;
 if SLengthMin >= 8 then
  begin
   Stop := SLengthMin-7;
   Result := 1;
   repeat
    if PInt1^ <> PInt2^ then
     Break;
    Inc(Result,4);
    Inc(PInt1);
    Inc(PInt2);
    if PInt1^ <> PInt2^ then
     Break;
    Inc(Result,4);
    Inc(PInt1);
    Inc(PInt2);
    until(Result > Stop);
   if Result <= SLengthMin then
    begin
     repeat
      if Ord(S1[Result]) <> Ord(S2[Result]) then
       begin
        if Ord(S1[Result]) < Ord(S2[Result]) then
         Result := -Result;
        Exit;
       end;
      Inc(Result);
     until(Result > SLengthMin);
    end;
  end
 else
  begin
   Result := 1;
   repeat
    if Ord(S1[Result]) <> Ord(S2[Result]) then
     begin
      if Ord(S1[Result]) < Ord(S2[Result]) then
       Result := -Result;
      Exit;
     end;
    Inc(Result);
   until(Result > SLengthMin);
  end;
 if S1Length = S2Length then
  Result := 0
 else if S1Length > S2Length then
  Result := 1
 else
  Result := -1;
end;

//Author:            Dennis Kjaer Christensen
//Date:              5/9 2005
//Instructionset(s): IA32

function CompareStr_DKC_IA32_17_a(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   jl    @Label8
   //SLengthMin := S1Length
   mov   ebp,edi
   jmp   @Label8
   //SLengthMin := S2Length;
 @Label8 :
   mov   esi,edx
   //Result := 1;
   mov   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @4ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @4ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   movzx ecx,[eax+ebx]
   cmp   dl,cl
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   or    eax,-1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

function CompareStr_DKC_IA32_17_b(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   jl    @Label8
   //SLengthMin := S1Length
   mov   ebp,edi
   jmp   @Label8
   //SLengthMin := S2Length;
 @Label8 :
   mov   esi,edx
   //Result := 1;
   mov   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @4ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @4ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   movzx ecx,[eax+ebx]
   cmp   dl,cl
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   or    eax,-1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

function CompareStr_DKC_IA32_17_c(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   jl    @Label8
   //SLengthMin := S1Length
   mov   ebp,edi
   jmp   @Label8
   //SLengthMin := S2Length;
 @Label8 :
   mov   esi,edx
   //Result := 1;
   mov   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @4ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @4ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   movzx ecx,[eax+ebx]
   cmp   dl,cl
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   or    eax,-1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

function CompareStr_DKC_IA32_17_d(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   jl    @Label8
   //SLengthMin := S1Length
   mov   ebp,edi
   jmp   @Label8
   //SLengthMin := S2Length;
 @Label8 :
   mov   esi,edx
   //Result := 1;
   mov   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @4ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @4ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   movzx ecx,[eax+ebx]
   cmp   dl,cl
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   or    eax,-1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              5/9 2005
//Instructionset(s): IA32

function CompareStr_DKC_IA32_18_a(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   jl    @Label8
   //SLengthMin := S1Length
   mov   ebp,edi
   jmp   @Label8
   //SLengthMin := S2Length;
 @Label8 :
   mov   esi,edx
   //Result := 1;
   //mov   ebx,1
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @4ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @4ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   movzx ecx,[eax+ebx]
   cmp   dl,cl
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

function CompareStr_DKC_IA32_18_b(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   jl    @Label8
   //SLengthMin := S1Length
   mov   ebp,edi
   jmp   @Label8
   //SLengthMin := S2Length;
 @Label8 :
   mov   esi,edx
   //Result := 1;
   //mov   ebx,1
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @4ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @4ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   movzx ecx,[eax+ebx]
   cmp   dl,cl
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

function CompareStr_DKC_IA32_18_c(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   jl    @Label8
   //SLengthMin := S1Length
   mov   ebp,edi
   jmp   @Label8
   //SLengthMin := S2Length;
 @Label8 :
   mov   esi,edx
   //Result := 1;
   //mov   ebx,1
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @4ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @4ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   movzx ecx,[eax+ebx]
   cmp   dl,cl
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

function CompareStr_DKC_IA32_18_d(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   jl    @Label8
   //SLengthMin := S1Length
   mov   ebp,edi
   jmp   @Label8
   //SLengthMin := S2Length;
 @Label8 :
   mov   esi,edx
   //Result := 1;
   //mov   ebx,1
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @4ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @4ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   movzx ecx,[eax+ebx]
   cmp   dl,cl
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/9 2005
//Instructionset(s): IA32

function CompareStr_DKC_IA32_20_a(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   jl    @Label8
   //SLengthMin := S1Length
   mov   ebp,edi
   jmp   @Label8
   //SLengthMin := S2Length;
 @Label8 :
   mov   esi,edx
   //Result := 1;
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @4ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatchRetry
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatchRetry
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @4ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   movzx ecx,[eax+ebx]
   cmp   dl,cl
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatchRetry :
   add   ebp,7
   jmp   @1ByteLoopStart
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

function CompareStr_DKC_IA32_20_b(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   jl    @Label8
   //SLengthMin := S1Length
   mov   ebp,edi
   jmp   @Label8
   //SLengthMin := S2Length;
 @Label8 :
   mov   esi,edx
   //Result := 1;
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @4ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatchRetry
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatchRetry
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @4ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   movzx ecx,[eax+ebx]
   cmp   dl,cl
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatchRetry :
   add   ebp,7
   jmp   @1ByteLoopStart
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

function CompareStr_DKC_IA32_20_c(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   jl    @Label8
   //SLengthMin := S1Length
   mov   ebp,edi
   jmp   @Label8
   //SLengthMin := S2Length;
 @Label8 :
   mov   esi,edx
   //Result := 1;
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @4ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatchRetry
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatchRetry
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @4ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   movzx ecx,[eax+ebx]
   cmp   dl,cl
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatchRetry :
   add   ebp,7
   jmp   @1ByteLoopStart
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

function CompareStr_DKC_IA32_20_d(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   jl    @Label8
   //SLengthMin := S1Length
   mov   ebp,edi
   jmp   @Label8
   //SLengthMin := S2Length;
 @Label8 :
   mov   esi,edx
   //Result := 1;
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @4ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatchRetry
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatchRetry
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @4ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   movzx ecx,[eax+ebx]
   cmp   dl,cl
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatchRetry :
   add   ebp,7
   jmp   @1ByteLoopStart
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              7/9 2005
//Instructionset(s): IA32, IA32 extensions

function CompareStr_DKC_IA32ext_2_a(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   //jl    @Label8
   //SLengthMin := S1Length
   cmova ebp,edi
   //jmp   @Label8
   //SLengthMin := S2Length;
 //@Label8 :
   mov   esi,edx
   //Result := 1;
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @4ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @4ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   movzx ecx,[eax+ebx]
   cmp   dl,cl
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler2;
asm
 nop
end;

function CompareStr_DKC_IA32ext_2_b(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   //jl    @Label8
   //SLengthMin := S1Length
   cmova ebp,edi
   //jmp   @Label8
   //SLengthMin := S2Length;
 //@Label8 :
   mov   esi,edx
   //Result := 1;
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @4ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @4ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   movzx ecx,[eax+ebx]
   cmp   dl,cl
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler3;
asm
 nop
end;

function CompareStr_DKC_IA32ext_2_c(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   //jl    @Label8
   //SLengthMin := S1Length
   cmova ebp,edi
   //jmp   @Label8
   //SLengthMin := S2Length;
 //@Label8 :
   mov   esi,edx
   //Result := 1;
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @4ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @4ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   movzx ecx,[eax+ebx]
   cmp   dl,cl
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler4;
asm
 nop
end;

function CompareStr_DKC_IA32ext_2_d(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   //jl    @Label8
   //SLengthMin := S1Length
   cmova ebp,edi
   //jmp   @Label8
   //SLengthMin := S2Length;
 //@Label8 :
   mov   esi,edx
   //Result := 1;
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @4ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @4ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   movzx ecx,[eax+ebx]
   cmp   dl,cl
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              7/9 2005
//Instructionset(s): IA32, IA32 extensions

function CompareStr_DKC_IA32ext_3_a(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   //SLengthMin := Min(S1Length, S2Length);
   cmova ebp,edi
   mov   esi,edx
   //Result := 1;
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @8ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @8ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   //movzx ecx,[eax+ebx]
   cmp   dl,[eax+ebx]
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler5;
asm
 nop
end;

function CompareStr_DKC_IA32ext_3_b(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   //SLengthMin := Min(S1Length, S2Length);
   cmova ebp,edi
   mov   esi,edx
   //Result := 1;
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @8ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @8ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   //movzx ecx,[eax+ebx]
   cmp   dl,[eax+ebx]
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler6;
asm
 nop
end;

function CompareStr_DKC_IA32ext_3_c(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   //SLengthMin := Min(S1Length, S2Length);
   cmova ebp,edi
   mov   esi,edx
   //Result := 1;
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @8ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @8ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   //movzx ecx,[eax+ebx]
   cmp   dl,[eax+ebx]
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler7;
asm
 nop
end;

function CompareStr_DKC_IA32ext_3_d(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   //SLengthMin := Min(S1Length, S2Length);
   cmova ebp,edi
   mov   esi,edx
   //Result := 1;
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @8ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @8ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   //movzx ecx,[eax+ebx]
   cmp   dl,[eax+ebx]
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/9 2005
//Instructionset(s): IA32, IA32 extensions

function CompareStr_DKC_IA32ext_4_a(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 = S2 then
   cmp      eax,edx
   je       @Result0Exit
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   //SLengthMin := Min(S1Length, S2Length);
   cmova ebp,edi
   mov   esi,edx
   //Result := 1;
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @8ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @8ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   cmp   dl,[eax+ebx]
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

function CompareStr_DKC_IA32ext_4_b(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 = S2 then
   cmp      eax,edx
   je       @Result0Exit
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   //SLengthMin := Min(S1Length, S2Length);
   cmova ebp,edi
   mov   esi,edx
   //Result := 1;
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @8ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @8ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   cmp   dl,[eax+ebx]
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

procedure Filler12;
asm
 nop
end;

function CompareStr_DKC_IA32ext_4_c(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 = S2 then
   cmp      eax,edx
   je       @Result0Exit
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   //SLengthMin := Min(S1Length, S2Length);
   cmova ebp,edi
   mov   esi,edx
   //Result := 1;
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @8ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @8ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   cmp   dl,[eax+ebx]
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

function CompareStr_DKC_IA32ext_4_d(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if S1 = S2 then
   cmp      eax,edx
   je       @Result0Exit
   //if S1 <> '' then
   test  eax,eax
   jz    @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov   edi,[eax-4]
   jmp   @Label2
   //S1Length := 0;
 @Label1 :
   xor   edi,edi
   //if S2 <> '' then
 @Label2 :
   test  edx,edx
   jz    @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov   ebp,[edx-4]
   jmp   @Label4
   //S2Length := 0;
 @Label3 :
   xor   ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test  edi,edi
   jnz   @Label5
   test  ebp,ebp
   jnz   @Label5
   jmp   @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test  edi,edi
   jz    @Label6
   test  ebp,ebp
   jnz   @Label6
   jmp   @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test  edi,edi
   jnz   @Label7
   test  ebp,ebp
   jz    @Label7
   jmp   @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp   ebp,edi
   //SLengthMin := Min(S1Length, S2Length);
   cmova ebp,edi
   mov   esi,edx
   //Result := 1;
   xor   ebx,ebx
   add   ebx,1
   sub   esi,1
   sub   eax,1
   cmp   ebp,8
   jb    @1ByteLoopStart
   sub   ebp,7
 @8ByteLoopStart :
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   mov   edx,[esi+ebx]
   mov   ecx,[eax+ebx]
   cmp   edx,ecx
   jne   @NoMatch
   add   ebx,4
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jl    @8ByteLoopStart
   add   ebp,7
   cmp   ebx,ebp
   ja    @1ByteLoopEnd
 @1ByteLoopStart :
   movzx edx,[esi+ebx]
   cmp   dl,[eax+ebx]
   jne   @NoMatch
   //Inc(Result);
   add   ebx,1
   //until(Result > SLengthMin);
   cmp   ebx,ebp
   jle   @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp   [esi-3],edi
   jnz   @Label11
   jmp   @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp   [esi-3],edi
   jnl   @ResultMinus1Exit
   jmp   @Result1Exit
 @NoMatch :
   jb    @Result1Exit
 @ResultMinus1Exit :
   xor   eax,eax
   sub   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result0Exit :
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
 @Result1Exit :
   or    eax,1
   xor   eax,eax
   add   eax,1
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              7/9 2005
//Instructionset(s): IA32, IA32 extensions, MMX

function CompareStr_DKC_MMX_2_a(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp      ebp,edi
   //jl       @Label8
   //SLengthMin := S1Length
   cmova    ebp,edi
   //jmp      @Label8
   //SLengthMin := S2Length;
 //@Label8 :
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,8
   jb       @1ByteLoopStart
   sub      ebp,7
 @8ByteLoopStart :
   movq     mm0,[esi+ebx]
   movq     mm1,[eax+ebx]
   pcmpeqb  mm1, mm0
   packsswb mm1, mm1
   movd     ecx, mm1
   cmp      ecx, $FFFFFFFF
   jne      @NoMatchFindDifference
   add      ebx,8
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   emms
   add      ebp,7
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   add      ebp,7
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

function CompareStr_DKC_MMX_2_b(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp      ebp,edi
   //jl       @Label8
   //SLengthMin := S1Length
   cmova    ebp,edi
   //jmp      @Label8
   //SLengthMin := S2Length;
 //@Label8 :
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,8
   jb       @1ByteLoopStart
   sub      ebp,7
 @8ByteLoopStart :
   movq     mm0,[esi+ebx]
   movq     mm1,[eax+ebx]
   pcmpeqb  mm1, mm0
   packsswb mm1, mm1
   movd     ecx, mm1
   cmp      ecx, $FFFFFFFF
   jne      @NoMatchFindDifference
   add      ebx,8
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   emms
   add      ebp,7
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   add      ebp,7
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

function CompareStr_DKC_MMX_2_c(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp      ebp,edi
   //jl       @Label8
   //SLengthMin := S1Length
   cmova    ebp,edi
   //jmp      @Label8
   //SLengthMin := S2Length;
 //@Label8 :
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,8
   jb       @1ByteLoopStart
   sub      ebp,7
 @8ByteLoopStart :
   movq     mm0,[esi+ebx]
   movq     mm1,[eax+ebx]
   pcmpeqb  mm1, mm0
   packsswb mm1, mm1
   movd     ecx, mm1
   cmp      ecx, $FFFFFFFF
   jne      @NoMatchFindDifference
   add      ebx,8
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   emms
   add      ebp,7
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   add      ebp,7
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

function CompareStr_DKC_MMX_2_d(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp      ebp,edi
   //jl       @Label8
   //SLengthMin := S1Length
   cmova    ebp,edi
   //jmp      @Label8
   //SLengthMin := S2Length;
 //@Label8 :
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,8
   jb       @1ByteLoopStart
   sub      ebp,7
 @8ByteLoopStart :
   movq     mm0,[esi+ebx]
   movq     mm1,[eax+ebx]
   pcmpeqb  mm1, mm0
   packsswb mm1, mm1
   movd     ecx, mm1
   cmp      ecx, $FFFFFFFF
   jne      @NoMatchFindDifference
   add      ebx,8
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   emms
   add      ebp,7
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   add      ebp,7
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              19/9 2005
//Instructionset(s): IA32, IA32 extensions, MMX

function CompareStr_DKC_MMX_3_a(const S1, S2: string): Integer;
asm
   //if S1 = S2 then
   cmp      eax,edx
   jne      @Continue
   xor      eax,eax
   ret
 @Continue :
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
 @Label7 :
   //SLengthMin := Min(S1Length, S2Length)
   cmp      ebp,edi
   cmova    ebp,edi
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,8
   jb       @1ByteLoopStart
   sub      ebp,7
 @8ByteLoopStart :
   movq     mm0,[esi+ebx]
   movq     mm1,[eax+ebx]
   pcmpeqb  mm1, mm0
   packsswb mm1, mm1
   movd     ecx, mm1
   cmp      ecx, $FFFFFFFF
   jne      @NoMatchFindDifference
   add      ebx,8
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   emms
   add      ebp,7
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   emms
   add      ebp,7
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

function CompareStr_DKC_MMX_3_b(const S1, S2: string): Integer;
asm
   //if S1 = S2 then
   cmp      eax,edx
   jne      @Continue
   xor      eax,eax
   ret
 @Continue :
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
 @Label7 :
   //SLengthMin := Min(S1Length, S2Length)
   cmp      ebp,edi
   cmova    ebp,edi
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,8
   jb       @1ByteLoopStart
   sub      ebp,7
 @8ByteLoopStart :
   movq     mm0,[esi+ebx]
   movq     mm1,[eax+ebx]
   pcmpeqb  mm1, mm0
   packsswb mm1, mm1
   movd     ecx, mm1
   cmp      ecx, $FFFFFFFF
   jne      @NoMatchFindDifference
   add      ebx,8
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   emms
   add      ebp,7
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   emms
   add      ebp,7
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

function CompareStr_DKC_MMX_3_c(const S1, S2: string): Integer;
asm
   //if S1 = S2 then
   cmp      eax,edx
   jne      @Continue
   xor      eax,eax
   ret
 @Continue :
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
 @Label7 :
   //SLengthMin := Min(S1Length, S2Length)
   cmp      ebp,edi
   cmova    ebp,edi
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,8
   jb       @1ByteLoopStart
   sub      ebp,7
 @8ByteLoopStart :
   movq     mm0,[esi+ebx]
   movq     mm1,[eax+ebx]
   pcmpeqb  mm1, mm0
   packsswb mm1, mm1
   movd     ecx, mm1
   cmp      ecx, $FFFFFFFF
   jne      @NoMatchFindDifference
   add      ebx,8
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   emms
   add      ebp,7
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   emms
   add      ebp,7
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

function CompareStr_DKC_MMX_3_d(const S1, S2: string): Integer;
asm
   //if S1 = S2 then
   cmp      eax,edx
   jne      @Continue
   xor      eax,eax
   ret
 @Continue :
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
 @Label7 :
   //SLengthMin := Min(S1Length, S2Length)
   cmp      ebp,edi
   cmova    ebp,edi
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,8
   jb       @1ByteLoopStart
   sub      ebp,7
 @8ByteLoopStart :
   movq     mm0,[esi+ebx]
   movq     mm1,[eax+ebx]
   pcmpeqb  mm1, mm0
   packsswb mm1, mm1
   movd     ecx, mm1
   cmp      ecx, $FFFFFFFF
   jne      @NoMatchFindDifference
   add      ebx,8
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   emms
   add      ebp,7
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   emms
   add      ebp,7
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              21/9 2005
//Instructionset(s): IA32, IA32 extensions, MMX

function CompareStr_DKC_MMX_5_a(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp      ebp,edi
   //SLengthMin := S1Length
   cmova    ebp,edi
   //SLengthMin := S2Length;
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,8
   jb       @1ByteLoopStart
   sub      ebp,7
 @8ByteLoopStart :
   movq     mm0,[esi+ebx]
   movq     mm1,[eax+ebx]
   pcmpeqb  mm1, mm0
   packsswb mm1, mm1
   movd     ecx, mm1
   cmp      ecx, $FFFFFFFF
   jne      @NoMatchFindDifference
   add      ebx,8
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   emms
   add      ebp,7
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   emms
   add      ebp,7
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

function CompareStr_DKC_MMX_5_b(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp      ebp,edi
   //SLengthMin := S1Length
   cmova    ebp,edi
   //SLengthMin := S2Length;
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,8
   jb       @1ByteLoopStart
   sub      ebp,7
 @8ByteLoopStart :
   movq     mm0,[esi+ebx]
   movq     mm1,[eax+ebx]
   pcmpeqb  mm1, mm0
   packsswb mm1, mm1
   movd     ecx, mm1
   cmp      ecx, $FFFFFFFF
   jne      @NoMatchFindDifference
   add      ebx,8
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   emms
   add      ebp,7
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   emms
   add      ebp,7
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

procedure Filler11;
asm
 nop
end;

function CompareStr_DKC_MMX_5_c(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp      ebp,edi
   //SLengthMin := S1Length
   cmova    ebp,edi
   //SLengthMin := S2Length;
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,8
   jb       @1ByteLoopStart
   sub      ebp,7
 @8ByteLoopStart :
   movq     mm0,[esi+ebx]
   movq     mm1,[eax+ebx]
   pcmpeqb  mm1, mm0
   packsswb mm1, mm1
   movd     ecx, mm1
   cmp      ecx, $FFFFFFFF
   jne      @NoMatchFindDifference
   add      ebx,8
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   emms
   add      ebp,7
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   emms
   add      ebp,7
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

function CompareStr_DKC_MMX_5_d(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp      ebp,edi
   //SLengthMin := S1Length
   cmova    ebp,edi
   //SLengthMin := S2Length;
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,8
   jb       @1ByteLoopStart
   sub      ebp,7
 @8ByteLoopStart :
   movq     mm0,[esi+ebx]
   movq     mm1,[eax+ebx]
   pcmpeqb  mm1, mm0
   packsswb mm1, mm1
   movd     ecx, mm1
   cmp      ecx, $FFFFFFFF
   jne      @NoMatchFindDifference
   add      ebx,8
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   emms
   add      ebp,7
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   emms
   add      ebp,7
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              7/9 2005
//Instructionset(s): IA32, MMX, SSE, SSE2

function CompareStr_DKC_SSE2_3_a(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp      ebp,edi
   //jl       @Label8
   //SLengthMin := S1Length
   cmova    ebp,edi
   //jmp      @Label8
   //SLengthMin := S2Length;
 //@Label8 :
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,16
   jb       @1ByteLoopStart
   sub      ebp,15
 @8ByteLoopStart :
   movdqu   xmm0,[esi+ebx]
   movdqu   xmm1,[eax+ebx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ecx,xmm0
   cmp      cx,$FFFF
   jne      @NoMatchFindDifference
   add      ebx,16
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   add      ebp,15
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   add      ebp,15
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

function CompareStr_DKC_SSE2_3_b(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp      ebp,edi
   //jl       @Label8
   //SLengthMin := S1Length
   cmova    ebp,edi
   //jmp      @Label8
   //SLengthMin := S2Length;
 //@Label8 :
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,16
   jb       @1ByteLoopStart
   sub      ebp,15
 @8ByteLoopStart :
   movdqu   xmm0,[esi+ebx]
   movdqu   xmm1,[eax+ebx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ecx,xmm0
   cmp      cx,$FFFF
   jne      @NoMatchFindDifference
   add      ebx,16
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   add      ebp,15
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   add      ebp,15
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

function CompareStr_DKC_SSE2_3_c(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp      ebp,edi
   //jl       @Label8
   //SLengthMin := S1Length
   cmova    ebp,edi
   //jmp      @Label8
   //SLengthMin := S2Length;
 //@Label8 :
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,16
   jb       @1ByteLoopStart
   sub      ebp,15
 @8ByteLoopStart :
   movdqu   xmm0,[esi+ebx]
   movdqu   xmm1,[eax+ebx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ecx,xmm0
   cmp      cx,$FFFF
   jne      @NoMatchFindDifference
   add      ebx,16
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   add      ebp,15
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   add      ebp,15
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

function CompareStr_DKC_SSE2_3_d(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp      ebp,edi
   //jl       @Label8
   //SLengthMin := S1Length
   cmova    ebp,edi
   //jmp      @Label8
   //SLengthMin := S2Length;
 //@Label8 :
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,16
   jb       @1ByteLoopStart
   sub      ebp,15
 @8ByteLoopStart :
   movdqu   xmm0,[esi+ebx]
   movdqu   xmm1,[eax+ebx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ecx,xmm0
   cmp      cx,$FFFF
   jne      @NoMatchFindDifference
   add      ebx,16
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   add      ebp,15
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   add      ebp,15
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;
{
//Author:            Dennis Kjaer Christensen
//Date:              7/9 2005
//Instructionset(s): IA32, Ia32 extensions, MMX, SSE, SSE2, SSE3

function CompareStr_DKC_SSE3_3_a(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp      ebp,edi
   //jl       @Label8
   //SLengthMin := S1Length
   cmova      ebp,edi
   //jmp      @Label8
   //SLengthMin := S2Length;
 //@Label8 :
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,32
   jb       @1ByteLoopStart
   sub      ebp,31
 @32ByteLoopStart :
   lddqu    xmm0,[esi+ebx]
   lddqu    xmm1,[eax+ebx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ecx,xmm0
   cmp      cx,$FFFF
   jne      @NoMatchFindDifference
   add      ebx,16
   lddqu    xmm0,[esi+ebx]
   lddqu    xmm1,[eax+ebx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ecx,xmm0
   cmp      cx,$FFFF
   jne      @NoMatchFindDifference
   add      ebx,16
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @32ByteLoopStart
   add      ebp,31
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   add      ebp,31
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

function CompareStr_DKC_SSE3_3_b(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp      ebp,edi
   //jl       @Label8
   //SLengthMin := S1Length
   cmova      ebp,edi
   //jmp      @Label8
   //SLengthMin := S2Length;
 //@Label8 :
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,32
   jb       @1ByteLoopStart
   sub      ebp,31
 @32ByteLoopStart :
   lddqu    xmm0,[esi+ebx]
   lddqu    xmm1,[eax+ebx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ecx,xmm0
   cmp      cx,$FFFF
   jne      @NoMatchFindDifference
   add      ebx,16
   lddqu    xmm0,[esi+ebx]
   lddqu    xmm1,[eax+ebx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ecx,xmm0
   cmp      cx,$FFFF
   jne      @NoMatchFindDifference
   add      ebx,16
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @32ByteLoopStart
   add      ebp,31
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   add      ebp,31
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

function CompareStr_DKC_SSE3_3_c(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp      ebp,edi
   //jl       @Label8
   //SLengthMin := S1Length
   cmova      ebp,edi
   //jmp      @Label8
   //SLengthMin := S2Length;
 //@Label8 :
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,32
   jb       @1ByteLoopStart
   sub      ebp,31
 @32ByteLoopStart :
   lddqu    xmm0,[esi+ebx]
   lddqu    xmm1,[eax+ebx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ecx,xmm0
   cmp      cx,$FFFF
   jne      @NoMatchFindDifference
   add      ebx,16
   lddqu    xmm0,[esi+ebx]
   lddqu    xmm1,[eax+ebx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ecx,xmm0
   cmp      cx,$FFFF
   jne      @NoMatchFindDifference
   add      ebx,16
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @32ByteLoopStart
   add      ebp,31
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   add      ebp,31
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

function CompareStr_DKC_SSE3_3_d(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
   //if S1Length <= S2Length then
 @Label7 :
   cmp      ebp,edi
   //jl       @Label8
   //SLengthMin := S1Length
   cmova      ebp,edi
   //jmp      @Label8
   //SLengthMin := S2Length;
 //@Label8 :
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,32
   jb       @1ByteLoopStart
   sub      ebp,31
 @32ByteLoopStart :
   lddqu    xmm0,[esi+ebx]
   lddqu    xmm1,[eax+ebx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ecx,xmm0
   cmp      cx,$FFFF
   jne      @NoMatchFindDifference
   add      ebx,16
   lddqu    xmm0,[esi+ebx]
   lddqu    xmm1,[eax+ebx]
   pcmpeqb  xmm0,xmm1
   pmovmskb ecx,xmm0
   cmp      cx,$FFFF
   jne      @NoMatchFindDifference
   add      ebx,16
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @32ByteLoopStart
   add      ebp,31
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   add      ebp,31
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;
}
//Author:            Dennis Kjaer Christensen
//Date:              21/9 2005
//Instructionset(s): IA32, IA32 extensions, MMX

function CompareStr_DKC_MMX_4_a(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 = S2 then
   cmp      eax,edx
   je       @Result0Exit
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
 @Label7 :
   //SLengthMin := Min(S1Length, S2Length)
   cmp      ebp,edi
   cmova    ebp,edi
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,8
   jb       @1ByteLoopStart
   sub      ebp,7
 @8ByteLoopStart :
   movq     mm0,[esi+ebx]
   movq     mm1,[eax+ebx]
   pcmpeqb  mm1, mm0
   packsswb mm1, mm1
   movd     ecx, mm1
   cmp      ecx, $FFFFFFFF
   jne      @NoMatchFindDifference
   add      ebx,8
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   emms
   add      ebp,7
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   emms
   add      ebp,7
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

procedure Filler1;
asm
 nop
end;

function CompareStr_DKC_MMX_4_b(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 = S2 then
   cmp      eax,edx
   je       @Result0Exit
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
 @Label7 :
   //SLengthMin := Min(S1Length, S2Length)
   cmp      ebp,edi
   cmova    ebp,edi
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,8
   jb       @1ByteLoopStart
   sub      ebp,7
 @8ByteLoopStart :
   movq     mm0,[esi+ebx]
   movq     mm1,[eax+ebx]
   pcmpeqb  mm1, mm0
   packsswb mm1, mm1
   movd     ecx, mm1
   cmp      ecx, $FFFFFFFF
   jne      @NoMatchFindDifference
   add      ebx,8
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   emms
   add      ebp,7
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   emms
   add      ebp,7
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

procedure Filler9;
asm
 nop
end;

function CompareStr_DKC_MMX_4_c(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 = S2 then
   cmp      eax,edx
   je       @Result0Exit
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
 @Label7 :
   //SLengthMin := Min(S1Length, S2Length)
   cmp      ebp,edi
   cmova    ebp,edi
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,8
   jb       @1ByteLoopStart
   sub      ebp,7
 @8ByteLoopStart :
   movq     mm0,[esi+ebx]
   movq     mm1,[eax+ebx]
   pcmpeqb  mm1, mm0
   packsswb mm1, mm1
   movd     ecx, mm1
   cmp      ecx, $FFFFFFFF
   jne      @NoMatchFindDifference
   add      ebx,8
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   emms
   add      ebp,7
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   emms
   add      ebp,7
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
end;

procedure Filler10;
asm
 nop
end;

function CompareStr_DKC_MMX_4_d(const S1, S2: string): Integer;
asm
   push     ebx
   push     esi
   push     edi
   push     ebp
   //if S1 = S2 then
   cmp      eax,edx
   je       @Result0Exit
   //if S1 <> '' then
   test     eax,eax
   jz       @Label1
   //S1Length := PInteger(Integer(S1)-4)^
   mov      edi,[eax-4]
   jmp      @Label2
   //S1Length := 0;
 @Label1 :
   xor      edi,edi
   //if S2 <> '' then
 @Label2 :
   test     edx,edx
   jz       @Label3
   //S2Length := PInteger(Integer(S2)-4)^
   mov      ebp,[edx-4]
   jmp      @Label4
   //S2Length := 0;
 @Label3 :
   xor      ebp,ebp
   //if (S1Length = 0) and (S2Length = 0) then
 @Label4 :
   test     edi,edi
   jnz      @Label5
   test     ebp,ebp
   jnz      @Label5
   jmp      @Result0Exit
   //if (S1Length <> 0) and (S2Length = 0) then
 @Label5 :
   test     edi,edi
   jz       @Label6
   test     ebp,ebp
   jnz      @Label6
   jmp      @Result1Exit
   //if (S1Length = 0) and (S2Length <> 0) then
 @Label6 :
   test     edi,edi
   jnz      @Label7
   test     ebp,ebp
   jz       @Label7
   jmp      @ResultMinus1Exit
 @Label7 :
   //SLengthMin := Min(S1Length, S2Length)
   cmp      ebp,edi
   cmova    ebp,edi
   mov      esi,edx
   //Result := 1;
   mov      ebx,1
   dec      esi
   dec      eax
   cmp      ebp,8
   jb       @1ByteLoopStart
   sub      ebp,7
 @8ByteLoopStart :
   movq     mm0,[esi+ebx]
   movq     mm1,[eax+ebx]
   pcmpeqb  mm1, mm0
   packsswb mm1, mm1
   movd     ecx, mm1
   cmp      ecx, $FFFFFFFF
   jne      @NoMatchFindDifference
   add      ebx,8
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jl       @8ByteLoopStart
   emms
   add      ebp,7
   cmp      ebx,ebp
   ja       @1ByteLoopEnd
 @1ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @1ByteLoopStart
 @1ByteLoopEnd :
   //if S1Length = S2Length then
   cmp      [esi-3],edi
   jnz      @Label11
   jmp      @Result0Exit
   //else if S1Length > S2Length then
 @Label11 :
   cmp      [esi-3],edi
   jnl      @ResultMinus1Exit
   jmp      @Result1Exit
 @NoMatchFindDifference :
   emms
   add      ebp,7
 @ByteLoopStart :
   movzx    edx,[esi+ebx]
   movzx    ecx,[eax+ebx]
   cmp      dl,cl
   jne      @NoMatch
   //Inc(Result);
   inc      ebx
   //until(Result > SLengthMin);
   cmp      ebx,ebp
   jle      @ByteLoopStart
 @NoMatch :
   jb       @Result1Exit
 @ResultMinus1Exit :
   or       eax,-1
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result0Exit :
   xor      eax,eax
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
   ret
 @Result1Exit :
   xor      eax,eax
   inc      eax
 @Exit :
   pop      ebp
   pop      edi
   pop      esi
   pop      ebx
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
 Filler10;
 Filler11;
 Filler12;

end.
