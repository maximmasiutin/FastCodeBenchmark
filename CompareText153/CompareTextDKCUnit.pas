unit CompareTextDKCUnit;

interface

function CompareText_DKC_Pas_13_a(const S1, S2: string): Integer;
function CompareText_DKC_Pas_13_b(const S1, S2: string): Integer;
function CompareText_DKC_Pas_13_c(const S1, S2: string): Integer;
function CompareText_DKC_Pas_13_d(const S1, S2: string): Integer;
function CompareText_DKC_Pas_17_a(const S1, S2: string): Integer;
function CompareText_DKC_Pas_17_b(const S1, S2: string): Integer;
function CompareText_DKC_Pas_17_c(const S1, S2: string): Integer;
function CompareText_DKC_Pas_17_d(const S1, S2: string): Integer;
function CompareText_DKC_Pas_18_a(const S1, S2: string): Integer;
function CompareText_DKC_Pas_18_b(const S1, S2: string): Integer;
function CompareText_DKC_Pas_18_c(const S1, S2: string): Integer;
function CompareText_DKC_Pas_18_d(const S1, S2: string): Integer;
function CompareText_DKC_Pas_19_a(const S1, S2: string): Integer;
function CompareText_DKC_Pas_19_b(const S1, S2: string): Integer;
function CompareText_DKC_Pas_19_c(const S1, S2: string): Integer;
function CompareText_DKC_Pas_19_d(const S1, S2: string): Integer;
function CompareText_DKC_Pas_20_a(const S1, S2: string): Integer;
function CompareText_DKC_Pas_20_b(const S1, S2: string): Integer;
function CompareText_DKC_Pas_20_c(const S1, S2: string): Integer;
function CompareText_DKC_Pas_20_d(const S1, S2: string): Integer;
function CompareText_DKC_Pas_21_a(const S1, S2: string): Integer;
function CompareText_DKC_Pas_21_b(const S1, S2: string): Integer;
function CompareText_DKC_Pas_21_c(const S1, S2: string): Integer;
function CompareText_DKC_Pas_21_d(const S1, S2: string): Integer;
function CompareText_DKC_IA32_11_a(const S1, S2: string): Integer;
function CompareText_DKC_IA32_11_b(const S1, S2: string): Integer;
function CompareText_DKC_IA32_11_c(const S1, S2: string): Integer;
function CompareText_DKC_IA32_11_d(const S1, S2: string): Integer;
function CompareText_DKC_IA32_12_a(const S1, S2: string): Integer;
function CompareText_DKC_IA32_12_b(const S1, S2: string): Integer;
function CompareText_DKC_IA32_12_c(const S1, S2: string): Integer;
function CompareText_DKC_IA32_12_d(const S1, S2: string): Integer;

implementation

uses
 SysUtils;

var
 LookUpTable : array of Char;

procedure InitializeLookUpTable;
var
 I : Byte;
 S1, S2 : AnsiString;

begin
 SetLength(LookUpTable, 256);
 for I := 0 to 255 do
  begin
   S1 := Char(I);
   S2 := UpperCase(S1);
   LookUpTable[I] := S2[1];
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              9/10 2003
//Instructionset(s): IA32

function CompareText_DKC_Pas_13_a(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin;

begin
 S1Len := Length(S1);
 S2Len := Length(S2);
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1)
 until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
 if S1[I1+1] <> S2[I1+1] then
  begin
   C1 := S1[I1+1];
   C2 := S2[I1+1];
   if (C1 >= 'a') and (C1 <= 'z') then
    C1 := Char(Byte(C1) - 32);
   if (C2 >= 'a') and (C2 <= 'z') then
    C2 := Char(Byte(C2) - 32);
   if C1 = C2 then
    if I1 < MinSLen then
     goto RepeatBegin
    else
     begin
      Result := S1Len - S2Len;
      Exit;
     end;
   if C1 > C2 then
    Result := I1+1
   else //if C1 < C2 then
    Result := -(I1+1);
  end
 else
  Result := S1Len - S2Len;
end;

procedure Filler1;
asm
 nop
end;

function CompareText_DKC_Pas_13_b(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin;

begin
 S1Len := Length(S1);
 S2Len := Length(S2);
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1)
 until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
 if S1[I1+1] <> S2[I1+1] then
  begin
   C1 := S1[I1+1];
   C2 := S2[I1+1];
   if (C1 >= 'a') and (C1 <= 'z') then
    C1 := Char(Byte(C1) - 32);
   if (C2 >= 'a') and (C2 <= 'z') then
    C2 := Char(Byte(C2) - 32);
   if C1 = C2 then
    if I1 < MinSLen then
     goto RepeatBegin
    else
     begin
      Result := S1Len - S2Len;
      Exit;
     end;
   if C1 > C2 then
    Result := I1+1
   else //if C1 < C2 then
    Result := -(I1+1);
  end
 else
  Result := S1Len - S2Len;
end;

procedure Filler2;
asm
 nop
end;

function CompareText_DKC_Pas_13_c(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin;

begin
 S1Len := Length(S1);
 S2Len := Length(S2);
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1)
 until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
 if S1[I1+1] <> S2[I1+1] then
  begin
   C1 := S1[I1+1];
   C2 := S2[I1+1];
   if (C1 >= 'a') and (C1 <= 'z') then
    C1 := Char(Byte(C1) - 32);
   if (C2 >= 'a') and (C2 <= 'z') then
    C2 := Char(Byte(C2) - 32);
   if C1 = C2 then
    if I1 < MinSLen then
     goto RepeatBegin
    else
     begin
      Result := S1Len - S2Len;
      Exit;
     end;
   if C1 > C2 then
    Result := I1+1
   else //if C1 < C2 then
    Result := -(I1+1);
  end
 else
  Result := S1Len - S2Len;
end;

procedure Filler3;
asm
 nop
end;

function CompareText_DKC_Pas_13_d(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin;

begin
 S1Len := Length(S1);
 S2Len := Length(S2);
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1)
 until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
 if S1[I1+1] <> S2[I1+1] then
  begin
   C1 := S1[I1+1];
   C2 := S2[I1+1];
   if (C1 >= 'a') and (C1 <= 'z') then
    C1 := Char(Byte(C1) - 32);
   if (C2 >= 'a') and (C2 <= 'z') then
    C2 := Char(Byte(C2) - 32);
   if C1 = C2 then
    if I1 < MinSLen then
     goto RepeatBegin
    else
     begin
      Result := S1Len - S2Len;
      Exit;
     end;
   if C1 > C2 then
    Result := I1+1
   else //if C1 < C2 then
    Result := -(I1+1);
  end
 else
  Result := S1Len - S2Len;
end;

//Author:            Dennis Kjaer Christensen
//Date:              27/6 2006
//Instructionset(s): IA32

function CompareText_DKC_Pas_17_a(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin;

begin
 //S1Len := Length(S1);
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 //S2Len := Length(S2);
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1)
 until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
 if S1[I1+1] <> S2[I1+1] then
  begin
   C1 := S1[I1+1];
   C2 := S2[I1+1];
   if (C1 >= 'a') and (C1 <= 'z') then
    C1 := Char(Byte(C1) - 32);
   if (C2 >= 'a') and (C2 <= 'z') then
    C2 := Char(Byte(C2) - 32);
   if C1 = C2 then
    if I1 < MinSLen then
     goto RepeatBegin
    else
     begin
      Result := S1Len - S2Len;
      Exit;
     end;
   if C1 > C2 then
    Result := I1+1
   else //if C1 < C2 then
    Result := -(I1+1);
  end
 else
  Result := S1Len - S2Len;
end;

function CompareText_DKC_Pas_17_b(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin;

begin
 //S1Len := Length(S1);
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 //S2Len := Length(S2);
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1)
 until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
 if S1[I1+1] <> S2[I1+1] then
  begin
   C1 := S1[I1+1];
   C2 := S2[I1+1];
   if (C1 >= 'a') and (C1 <= 'z') then
    C1 := Char(Byte(C1) - 32);
   if (C2 >= 'a') and (C2 <= 'z') then
    C2 := Char(Byte(C2) - 32);
   if C1 = C2 then
    if I1 < MinSLen then
     goto RepeatBegin
    else
     begin
      Result := S1Len - S2Len;
      Exit;
     end;
   if C1 > C2 then
    Result := I1+1
   else //if C1 < C2 then
    Result := -(I1+1);
  end
 else
  Result := S1Len - S2Len;
end;

function CompareText_DKC_Pas_17_c(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin;

begin
 //S1Len := Length(S1);
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 //S2Len := Length(S2);
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1)
 until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
 if S1[I1+1] <> S2[I1+1] then
  begin
   C1 := S1[I1+1];
   C2 := S2[I1+1];
   if (C1 >= 'a') and (C1 <= 'z') then
    C1 := Char(Byte(C1) - 32);
   if (C2 >= 'a') and (C2 <= 'z') then
    C2 := Char(Byte(C2) - 32);
   if C1 = C2 then
    if I1 < MinSLen then
     goto RepeatBegin
    else
     begin
      Result := S1Len - S2Len;
      Exit;
     end;
   if C1 > C2 then
    Result := I1+1
   else //if C1 < C2 then
    Result := -(I1+1);
  end
 else
  Result := S1Len - S2Len;
end;

function CompareText_DKC_Pas_17_d(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin;

begin
 //S1Len := Length(S1);
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 //S2Len := Length(S2);
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1)
 until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
 if S1[I1+1] <> S2[I1+1] then
  begin
   C1 := S1[I1+1];
   C2 := S2[I1+1];
   if (C1 >= 'a') and (C1 <= 'z') then
    C1 := Char(Byte(C1) - 32);
   if (C2 >= 'a') and (C2 <= 'z') then
    C2 := Char(Byte(C2) - 32);
   if C1 = C2 then
    if I1 < MinSLen then
     goto RepeatBegin
    else
     begin
      Result := S1Len - S2Len;
      Exit;
     end;
   if C1 > C2 then
    Result := I1+1
   else //if C1 < C2 then
    Result := -(I1+1);
  end
 else
  Result := S1Len - S2Len;
end;

//Author:            Dennis Kjaer Christensen
//Date:              27/6 2006
//Instructionset(s): IA32

function CompareText_DKC_Pas_18_a(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin;

begin
 //S1Len := Length(S1);
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 //S2Len := Length(S2);
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1)
 until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
 if S1[I1+1] <> S2[I1+1] then
  begin
   C1 := S1[I1+1];
   C2 := S2[I1+1];
   if (C1 >= 'a') and (C1 <= 'z') then
    //C1 := Char(Byte(C1) - 32);
    C1 := LookUpTable[Byte(C1)];
   if (C2 >= 'a') and (C2 <= 'z') then
    //C2 := Char(Byte(C2) - 32);
    C2 := LookUpTable[Byte(C2)];
   if C1 = C2 then
    if I1 < MinSLen then
     goto RepeatBegin
    else
     begin
      Result := S1Len - S2Len;
      Exit;
     end;
   if C1 > C2 then
    Result := I1+1
   else //if C1 < C2 then
    Result := -(I1+1);
  end
 else
  Result := S1Len - S2Len;
end;

function CompareText_DKC_Pas_18_b(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin;

begin
 //S1Len := Length(S1);
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 //S2Len := Length(S2);
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1)
 until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
 if S1[I1+1] <> S2[I1+1] then
  begin
   C1 := S1[I1+1];
   C2 := S2[I1+1];
   if (C1 >= 'a') and (C1 <= 'z') then
    //C1 := Char(Byte(C1) - 32);
    C1 := LookUpTable[Byte(C1)];
   if (C2 >= 'a') and (C2 <= 'z') then
    //C2 := Char(Byte(C2) - 32);
    C2 := LookUpTable[Byte(C2)];
   if C1 = C2 then
    if I1 < MinSLen then
     goto RepeatBegin
    else
     begin
      Result := S1Len - S2Len;
      Exit;
     end;
   if C1 > C2 then
    Result := I1+1
   else //if C1 < C2 then
    Result := -(I1+1);
  end
 else
  Result := S1Len - S2Len;
end;

procedure Filler7;
asm
 nop
end;

function CompareText_DKC_Pas_18_c(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin;

begin
 //S1Len := Length(S1);
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 //S2Len := Length(S2);
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1)
 until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
 if S1[I1+1] <> S2[I1+1] then
  begin
   C1 := S1[I1+1];
   C2 := S2[I1+1];
   if (C1 >= 'a') and (C1 <= 'z') then
    //C1 := Char(Byte(C1) - 32);
    C1 := LookUpTable[Byte(C1)];
   if (C2 >= 'a') and (C2 <= 'z') then
    //C2 := Char(Byte(C2) - 32);
    C2 := LookUpTable[Byte(C2)];
   if C1 = C2 then
    if I1 < MinSLen then
     goto RepeatBegin
    else
     begin
      Result := S1Len - S2Len;
      Exit;
     end;
   if C1 > C2 then
    Result := I1+1
   else //if C1 < C2 then
    Result := -(I1+1);
  end
 else
  Result := S1Len - S2Len;
end;

function CompareText_DKC_Pas_18_d(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin;

begin
 //S1Len := Length(S1);
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 //S2Len := Length(S2);
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1)
 until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
 if S1[I1+1] <> S2[I1+1] then
  begin
   C1 := S1[I1+1];
   C2 := S2[I1+1];
   if (C1 >= 'a') and (C1 <= 'z') then
    //C1 := Char(Byte(C1) - 32);
    C1 := LookUpTable[Byte(C1)];
   if (C2 >= 'a') and (C2 <= 'z') then
    //C2 := Char(Byte(C2) - 32);
    C2 := LookUpTable[Byte(C2)];
   if C1 = C2 then
    if I1 < MinSLen then
     goto RepeatBegin
    else
     begin
      Result := S1Len - S2Len;
      Exit;
     end;
   if C1 > C2 then
    Result := I1+1
   else //if C1 < C2 then
    Result := -(I1+1);
  end
 else
  Result := S1Len - S2Len;
end;

//Author:            Dennis Kjaer Christensen
//Date:              27/6 2006
//Instructionset(s): IA32

function CompareText_DKC_Pas_19_a(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin, TestIgnoringCase;

begin
 //S1Len := Length(S1);
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 //S2Len := Length(S2);
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1);
  if S1[I1+1] <> S2[I1+1] then
   goto TestIgnoringCase;
 until(I1 >= MinSLen);
 Result := S1Len - S2Len;
 Exit;
TestIgnoringCase :
 C1 := S1[I1+1];
 C2 := S2[I1+1];
 C1 := LookUpTable[Byte(C1)];
 C2 := LookUpTable[Byte(C2)];
 if C1 = C2 then
  if I1 < MinSLen then
   goto RepeatBegin
  else
   begin
    Result := S1Len - S2Len;
    Exit;
   end;
 if C1 > C2 then
  Result := I1+1
 else //if C1 < C2 then
  Result := -(I1+1);
end;

function CompareText_DKC_Pas_19_b(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin, TestIgnoringCase;

begin
 //S1Len := Length(S1);
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 //S2Len := Length(S2);
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1);
  if S1[I1+1] <> S2[I1+1] then
   goto TestIgnoringCase;
 until(I1 >= MinSLen);
 Result := S1Len - S2Len;
 Exit;
TestIgnoringCase :
 C1 := S1[I1+1];
 C2 := S2[I1+1];
 C1 := LookUpTable[Byte(C1)];
 C2 := LookUpTable[Byte(C2)];
 if C1 = C2 then
  if I1 < MinSLen then
   goto RepeatBegin
  else
   begin
    Result := S1Len - S2Len;
    Exit;
   end;
 if C1 > C2 then
  Result := I1+1
 else //if C1 < C2 then
  Result := -(I1+1);
end;

function CompareText_DKC_Pas_19_c(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin, TestIgnoringCase;

begin
 //S1Len := Length(S1);
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 //S2Len := Length(S2);
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1);
  if S1[I1+1] <> S2[I1+1] then
   goto TestIgnoringCase;
 until(I1 >= MinSLen);
 Result := S1Len - S2Len;
 Exit;
TestIgnoringCase :
 C1 := S1[I1+1];
 C2 := S2[I1+1];
 C1 := LookUpTable[Byte(C1)];
 C2 := LookUpTable[Byte(C2)];
 if C1 = C2 then
  if I1 < MinSLen then
   goto RepeatBegin
  else
   begin
    Result := S1Len - S2Len;
    Exit;
   end;
 if C1 > C2 then
  Result := I1+1
 else //if C1 < C2 then
  Result := -(I1+1);
end;

function CompareText_DKC_Pas_19_d(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin, TestIgnoringCase;

begin
 //S1Len := Length(S1);
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 //S2Len := Length(S2);
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1);
  if S1[I1+1] <> S2[I1+1] then
   goto TestIgnoringCase;
 until(I1 >= MinSLen);
 Result := S1Len - S2Len;
 Exit;
TestIgnoringCase :
 C1 := S1[I1+1];
 C2 := S2[I1+1];
 C1 := LookUpTable[Byte(C1)];
 C2 := LookUpTable[Byte(C2)];
 if C1 = C2 then
  if I1 < MinSLen then
   goto RepeatBegin
  else
   begin
    Result := S1Len - S2Len;
    Exit;
   end;
 if C1 > C2 then
  Result := I1+1
 else //if C1 < C2 then
  Result := -(I1+1);
end;

//Author:            Dennis Kjaer Christensen
//Date:              27/6 2006
//Instructionset(s): IA32

function CompareText_DKC_Pas_20_a(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin, TestIgnoringCase;

begin
 //S1Len := Length(S1);
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 //S2Len := Length(S2);
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1);
  if S1[I1+1] <> S2[I1+1] then
   goto TestIgnoringCase;
 until(I1 >= MinSLen);
 Result := S1Len - S2Len;
 Exit;
TestIgnoringCase :
 C1 := S1[I1+1];
 C2 := S2[I1+1];
 if (C1 >= 'a') and (C1 <= 'z') then
  C1 := Char(Byte(C1) - 32);
 if (C2 >= 'a') and (C2 <= 'z') then
  C2 := Char(Byte(C2) - 32);
 if C1 = C2 then
  if I1 < MinSLen then
   goto RepeatBegin
  else
   begin
    Result := S1Len - S2Len;
    Exit;
   end;
 if C1 > C2 then
  Result := I1+1
 else //if C1 < C2 then
  Result := -(I1+1);
end;

procedure Filler8;
asm
 nop
end;

function CompareText_DKC_Pas_20_b(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin, TestIgnoringCase;

begin
 //S1Len := Length(S1);
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 //S2Len := Length(S2);
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1);
  if S1[I1+1] <> S2[I1+1] then
   goto TestIgnoringCase;
 until(I1 >= MinSLen);
 Result := S1Len - S2Len;
 Exit;
TestIgnoringCase :
 C1 := S1[I1+1];
 C2 := S2[I1+1];
 if (C1 >= 'a') and (C1 <= 'z') then
  C1 := Char(Byte(C1) - 32);
 if (C2 >= 'a') and (C2 <= 'z') then
  C2 := Char(Byte(C2) - 32);
 if C1 = C2 then
  if I1 < MinSLen then
   goto RepeatBegin
  else
   begin
    Result := S1Len - S2Len;
    Exit;
   end;
 if C1 > C2 then
  Result := I1+1
 else //if C1 < C2 then
  Result := -(I1+1);
end;

procedure Filler9;
asm
 nop
end;

function CompareText_DKC_Pas_20_c(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin, TestIgnoringCase;

begin
 //S1Len := Length(S1);
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 //S2Len := Length(S2);
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1);
  if S1[I1+1] <> S2[I1+1] then
   goto TestIgnoringCase;
 until(I1 >= MinSLen);
 Result := S1Len - S2Len;
 Exit;
TestIgnoringCase :
 C1 := S1[I1+1];
 C2 := S2[I1+1];
 if (C1 >= 'a') and (C1 <= 'z') then
  C1 := Char(Byte(C1) - 32);
 if (C2 >= 'a') and (C2 <= 'z') then
  C2 := Char(Byte(C2) - 32);
 if C1 = C2 then
  if I1 < MinSLen then
   goto RepeatBegin
  else
   begin
    Result := S1Len - S2Len;
    Exit;
   end;
 if C1 > C2 then
  Result := I1+1
 else //if C1 < C2 then
  Result := -(I1+1);
end;

procedure Filler10;
asm
 nop
end;

function CompareText_DKC_Pas_20_d(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin, TestIgnoringCase;

begin
 //S1Len := Length(S1);
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 //S2Len := Length(S2);
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1);
  if S1[I1+1] <> S2[I1+1] then
   goto TestIgnoringCase;
 until(I1 >= MinSLen);
 Result := S1Len - S2Len;
 Exit;
TestIgnoringCase :
 C1 := S1[I1+1];
 C2 := S2[I1+1];
 if (C1 >= 'a') and (C1 <= 'z') then
  C1 := Char(Byte(C1) - 32);
 if (C2 >= 'a') and (C2 <= 'z') then
  C2 := Char(Byte(C2) - 32);
 if C1 = C2 then
  if I1 < MinSLen then
   goto RepeatBegin
  else
   begin
    Result := S1Len - S2Len;
    Exit;
   end;
 if C1 > C2 then
  Result := I1+1
 else //if C1 < C2 then
  Result := -(I1+1);
end;

//Author:            Dennis Kjaer Christensen
//Date:              27/6 2006
//Instructionset(s): IA32

function CompareText_DKC_Pas_21_a(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin, TestIgnoringCase;

begin
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1);
  C1 := S1[I1+1];
  C2 := S2[I1+1];
  if C1 <> C2 then
   goto TestIgnoringCase;
 until(I1 >= MinSLen);
 Result := S1Len - S2Len;
 Exit;
TestIgnoringCase :
 if (C1 >= 'a') and (C1 <= 'z') then
  C1 := Char(Byte(C1) - 32);
 if (C2 >= 'a') and (C2 <= 'z') then
  C2 := Char(Byte(C2) - 32);
 if C1 = C2 then
  if I1 < MinSLen then
   goto RepeatBegin
  else
   begin
    Result := S1Len - S2Len;
    Exit;
   end;
 if C1 > C2 then
  Result := 1
 else //if C1 < C2 then
  Result := -1;
end;

function CompareText_DKC_Pas_21_b(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin, TestIgnoringCase;

begin
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1);
  C1 := S1[I1+1];
  C2 := S2[I1+1];
  if C1 <> C2 then
   goto TestIgnoringCase;
 until(I1 >= MinSLen);
 Result := S1Len - S2Len;
 Exit;
TestIgnoringCase :
 if (C1 >= 'a') and (C1 <= 'z') then
  C1 := Char(Byte(C1) - 32);
 if (C2 >= 'a') and (C2 <= 'z') then
  C2 := Char(Byte(C2) - 32);
 if C1 = C2 then
  if I1 < MinSLen then
   goto RepeatBegin
  else
   begin
    Result := S1Len - S2Len;
    Exit;
   end;
 if C1 > C2 then
  Result := 1
 else //if C1 < C2 then
  Result := -1;
end;

function CompareText_DKC_Pas_21_c(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin, TestIgnoringCase;

begin
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1);
  C1 := S1[I1+1];
  C2 := S2[I1+1];
  if C1 <> C2 then
   goto TestIgnoringCase;
 until(I1 >= MinSLen);
 Result := S1Len - S2Len;
 Exit;
TestIgnoringCase :
 if (C1 >= 'a') and (C1 <= 'z') then
  C1 := Char(Byte(C1) - 32);
 if (C2 >= 'a') and (C2 <= 'z') then
  C2 := Char(Byte(C2) - 32);
 if C1 = C2 then
  if I1 < MinSLen then
   goto RepeatBegin
  else
   begin
    Result := S1Len - S2Len;
    Exit;
   end;
 if C1 > C2 then
  Result := 1
 else //if C1 < C2 then
  Result := -1;
end;

function CompareText_DKC_Pas_21_d(const S1, S2: string): Integer;
var
 I1, S1Len, S2Len, MinSLen : Integer;
 C1, C2 : Char;
label
 RepeatBegin, TestIgnoringCase;

begin
 if S1 <> '' then
  S1Len := PInteger(Integer(S1)-4)^
 else
  S1Len := 0;
 if S2 <> '' then
  S2Len := PInteger(Integer(S2)-4)^
 else
  S2Len := 0;
 if (S1Len = 0) then
  begin
   if (S2Len = 0) then
    begin
     Result := 0;
     Exit;
    end
   else //if (S1Len = 0) then
    begin
     Result := -1;
     Exit;
    end
  end;
 if (S2Len = 0) then
  begin
   Result := 1;
   Exit;
  end;
 if S1Len < S2Len then
  MinSLen := S1Len-1
 else
  MinSLen := S2Len-1;
 I1 := -1;
RepeatBegin :
 repeat
  Inc(I1);
  C1 := S1[I1+1];
  C2 := S2[I1+1];
  if C1 <> C2 then
   goto TestIgnoringCase;
 until(I1 >= MinSLen);
 Result := S1Len - S2Len;
 Exit;
TestIgnoringCase :
 if (C1 >= 'a') and (C1 <= 'z') then
  C1 := Char(Byte(C1) - 32);
 if (C2 >= 'a') and (C2 <= 'z') then
  C2 := Char(Byte(C2) - 32);
 if C1 = C2 then
  if I1 < MinSLen then
   goto RepeatBegin
  else
   begin
    Result := S1Len - S2Len;
    Exit;
   end;
 if C1 > C2 then
  Result := 1
 else //if C1 < C2 then
  Result := -1;
end;

//Author:            Dennis Kjaer Christensen
//Date:              9/10 2003
//Optimized for:
//Instructionset(s): IA32

function CompareText_DKC_IA32_11_a(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   mov   ebx,eax
   test  ebx,ebx
   jz    @S1LenEnd
   mov   ebx,[ebx-$04]
 @S1LenEnd :
   mov   ebp,edx
   test  ebp,ebp
   jz    @S2LenEnd
   mov   ebp,[ebp-$04]
 @S2LenEnd :
   //if (S1Len = 0) then
   test  ebx,ebx
   jnz   @If8End
   //if (S2Len = 0) then
   test  ebp,ebp
   jnz   @If7End
   //Result := 0;
   xor   eax,eax
   jmp   @Exit
 @If7End :
   //else //if (S1Len = 0) then
   //Result := -1;
   or    eax,-$01
   jmp   @Exit
 @If8End :
   //if (S2Len = 0) then
   test  ebp,ebp
   jnz   @If9End
   //Result := 1;
   mov   eax,1
   jmp   @Exit
  @If9End :
   //if S1Len < S2Len then
   cmp   ebx,ebp
   jle   @If2End
   //MinSLen := S1Len-1
   mov   edi,ebx
   sub   edi,1
   jmp   @Else2End
 @If2End :
   //else
   //MinSLen := S2Len-1;
   mov   edi,ebp
   sub   edi,1
   //I1 := -1;
 @Else2End :
   or    esi,-$01
   //RepeatBegin :
 @RepeatBegin :
   //Inc(I1);
   add   esi,1
   //C1 := S1[I1+1];
   movzx ecx,[eax+esi]
   //until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
   cmp   cl,[edx+esi]
   jnz   @RepeatEnd
   cmp   edi,esi
   jnle  @RepeatBegin
 @RepeatEnd :
   //C2 := S2[I1+1];
   movzx ebx,[edx+esi]
   mov   bh,$7a
   mov   ch,$61
   //if S1[I1+1] <> S2[I1+1] then
   cmp   cl,bl
   jz @If3End
   //if (C1 >= 'a') and (C1 <= 'z') then
   cmp   cl,ch
   jb    @If6End
   cmp   cl,bh
   jnbe  @If6End
   //C1 := blar(Byte(C1) - 32);
   sub   cl,$20
 @If6End :
   //if (C2 >= 'a') and (C2 <= 'z') then
   cmp   bl,ch
   jb    @If4End
   cmp   bl,bh
   jnbe  @If4End
   //C2 := Char(Byte(C2) - 32);
   sub   bl,$20
 @If4End :
   //if C1 = C2 then
   cmp   bl,cl
   jz    @RepeatBegin
   //if C1 > C2 then
   cmp   cl,bl
   jbe   @If5End
   //Result := I1+1
   mov   eax,esi
   add   eax,1
   jmp   @Exit
   @If5End :
   //else //if C1 < C2 then
   //Result := -(I1+1);
   mov   eax,esi
   add   eax,1
   neg   eax
   jmp   @Exit
   @If3End :
   //else
   //Result := S1Len - S2Len;
   mov   eax,[eax-$04]
   sub   eax,ebp
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

function CompareText_DKC_IA32_11_b(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   mov   ebx,eax
   test  ebx,ebx
   jz    @S1LenEnd
   mov   ebx,[ebx-$04]
 @S1LenEnd :
   mov   ebp,edx
   test  ebp,ebp
   jz    @S2LenEnd
   mov   ebp,[ebp-$04]
 @S2LenEnd :
   //if (S1Len = 0) then
   test  ebx,ebx
   jnz   @If8End
   //if (S2Len = 0) then
   test  ebp,ebp
   jnz   @If7End
   //Result := 0;
   xor   eax,eax
   jmp   @Exit
 @If7End :
   //else //if (S1Len = 0) then
   //Result := -1;
   or    eax,-$01
   jmp   @Exit
 @If8End :
   //if (S2Len = 0) then
   test  ebp,ebp
   jnz   @If9End
   //Result := 1;
   mov   eax,1
   jmp   @Exit
  @If9End :
   //if S1Len < S2Len then
   cmp   ebx,ebp
   jle   @If2End
   //MinSLen := S1Len-1
   mov   edi,ebx
   sub   edi,1
   jmp   @Else2End
 @If2End :
   //else
   //MinSLen := S2Len-1;
   mov   edi,ebp
   sub   edi,1
   //I1 := -1;
 @Else2End :
   or    esi,-$01
   //RepeatBegin :
 @RepeatBegin :
   //Inc(I1);
   add   esi,1
   //C1 := S1[I1+1];
   movzx ecx,[eax+esi]
   //until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
   cmp   cl,[edx+esi]
   jnz   @RepeatEnd
   cmp   edi,esi
   jnle  @RepeatBegin
 @RepeatEnd :
   //C2 := S2[I1+1];
   movzx ebx,[edx+esi]
   mov   bh,$7a
   mov   ch,$61
   //if S1[I1+1] <> S2[I1+1] then
   cmp   cl,bl
   jz @If3End
   //if (C1 >= 'a') and (C1 <= 'z') then
   cmp   cl,ch
   jb    @If6End
   cmp   cl,bh
   jnbe  @If6End
   //C1 := blar(Byte(C1) - 32);
   sub   cl,$20
 @If6End :
   //if (C2 >= 'a') and (C2 <= 'z') then
   cmp   bl,ch
   jb    @If4End
   cmp   bl,bh
   jnbe  @If4End
   //C2 := Char(Byte(C2) - 32);
   sub   bl,$20
 @If4End :
   //if C1 = C2 then
   cmp   bl,cl
   jz    @RepeatBegin
   //if C1 > C2 then
   cmp   cl,bl
   jbe   @If5End
   //Result := I1+1
   mov   eax,esi
   add   eax,1
   jmp   @Exit
   @If5End :
   //else //if C1 < C2 then
   //Result := -(I1+1);
   mov   eax,esi
   add   eax,1
   neg   eax
   jmp   @Exit
   @If3End :
   //else
   //Result := S1Len - S2Len;
   mov   eax,[eax-$04]
   sub   eax,ebp
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

function CompareText_DKC_IA32_11_c(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   mov   ebx,eax
   test  ebx,ebx
   jz    @S1LenEnd
   mov   ebx,[ebx-$04]
 @S1LenEnd :
   mov   ebp,edx
   test  ebp,ebp
   jz    @S2LenEnd
   mov   ebp,[ebp-$04]
 @S2LenEnd :
   //if (S1Len = 0) then
   test  ebx,ebx
   jnz   @If8End
   //if (S2Len = 0) then
   test  ebp,ebp
   jnz   @If7End
   //Result := 0;
   xor   eax,eax
   jmp   @Exit
 @If7End :
   //else //if (S1Len = 0) then
   //Result := -1;
   or    eax,-$01
   jmp   @Exit
 @If8End :
   //if (S2Len = 0) then
   test  ebp,ebp
   jnz   @If9End
   //Result := 1;
   mov   eax,1
   jmp   @Exit
  @If9End :
   //if S1Len < S2Len then
   cmp   ebx,ebp
   jle   @If2End
   //MinSLen := S1Len-1
   mov   edi,ebx
   sub   edi,1
   jmp   @Else2End
 @If2End :
   //else
   //MinSLen := S2Len-1;
   mov   edi,ebp
   sub   edi,1
   //I1 := -1;
 @Else2End :
   or    esi,-$01
   //RepeatBegin :
 @RepeatBegin :
   //Inc(I1);
   add   esi,1
   //C1 := S1[I1+1];
   movzx ecx,[eax+esi]
   //until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
   cmp   cl,[edx+esi]
   jnz   @RepeatEnd
   cmp   edi,esi
   jnle  @RepeatBegin
 @RepeatEnd :
   //C2 := S2[I1+1];
   movzx ebx,[edx+esi]
   mov   bh,$7a
   mov   ch,$61
   //if S1[I1+1] <> S2[I1+1] then
   cmp   cl,bl
   jz @If3End
   //if (C1 >= 'a') and (C1 <= 'z') then
   cmp   cl,ch
   jb    @If6End
   cmp   cl,bh
   jnbe  @If6End
   //C1 := blar(Byte(C1) - 32);
   sub   cl,$20
 @If6End :
   //if (C2 >= 'a') and (C2 <= 'z') then
   cmp   bl,ch
   jb    @If4End
   cmp   bl,bh
   jnbe  @If4End
   //C2 := Char(Byte(C2) - 32);
   sub   bl,$20
 @If4End :
   //if C1 = C2 then
   cmp   bl,cl
   jz    @RepeatBegin
   //if C1 > C2 then
   cmp   cl,bl
   jbe   @If5End
   //Result := I1+1
   mov   eax,esi
   add   eax,1
   jmp   @Exit
   @If5End :
   //else //if C1 < C2 then
   //Result := -(I1+1);
   mov   eax,esi
   add   eax,1
   neg   eax
   jmp   @Exit
   @If3End :
   //else
   //Result := S1Len - S2Len;
   mov   eax,[eax-$04]
   sub   eax,ebp
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

function CompareText_DKC_IA32_11_d(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   mov   ebx,eax
   test  ebx,ebx
   jz    @S1LenEnd
   mov   ebx,[ebx-$04]
 @S1LenEnd :
   mov   ebp,edx
   test  ebp,ebp
   jz    @S2LenEnd
   mov   ebp,[ebp-$04]
 @S2LenEnd :
   //if (S1Len = 0) then
   test  ebx,ebx
   jnz   @If8End
   //if (S2Len = 0) then
   test  ebp,ebp
   jnz   @If7End
   //Result := 0;
   xor   eax,eax
   jmp   @Exit
 @If7End :
   //else //if (S1Len = 0) then
   //Result := -1;
   or    eax,-$01
   jmp   @Exit
 @If8End :
   //if (S2Len = 0) then
   test  ebp,ebp
   jnz   @If9End
   //Result := 1;
   mov   eax,1
   jmp   @Exit
  @If9End :
   //if S1Len < S2Len then
   cmp   ebx,ebp
   jle   @If2End
   //MinSLen := S1Len-1
   mov   edi,ebx
   sub   edi,1
   jmp   @Else2End
 @If2End :
   //else
   //MinSLen := S2Len-1;
   mov   edi,ebp
   sub   edi,1
   //I1 := -1;
 @Else2End :
   or    esi,-$01
   //RepeatBegin :
 @RepeatBegin :
   //Inc(I1);
   add   esi,1
   //C1 := S1[I1+1];
   movzx ecx,[eax+esi]
   //until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
   cmp   cl,[edx+esi]
   jnz   @RepeatEnd
   cmp   edi,esi
   jnle  @RepeatBegin
 @RepeatEnd :
   //C2 := S2[I1+1];
   movzx ebx,[edx+esi]
   mov   bh,$7a
   mov   ch,$61
   //if S1[I1+1] <> S2[I1+1] then
   cmp   cl,bl
   jz @If3End
   //if (C1 >= 'a') and (C1 <= 'z') then
   cmp   cl,ch
   jb    @If6End
   cmp   cl,bh
   jnbe  @If6End
   //C1 := blar(Byte(C1) - 32);
   sub   cl,$20
 @If6End :
   //if (C2 >= 'a') and (C2 <= 'z') then
   cmp   bl,ch
   jb    @If4End
   cmp   bl,bh
   jnbe  @If4End
   //C2 := Char(Byte(C2) - 32);
   sub   bl,$20
 @If4End :
   //if C1 = C2 then
   cmp   bl,cl
   jz    @RepeatBegin
   //if C1 > C2 then
   cmp   cl,bl
   jbe   @If5End
   //Result := I1+1
   mov   eax,esi
   add   eax,1
   jmp   @Exit
   @If5End :
   //else //if C1 < C2 then
   //Result := -(I1+1);
   mov   eax,esi
   add   eax,1
   neg   eax
   jmp   @Exit
   @If3End :
   //else
   //Result := S1Len - S2Len;
   mov   eax,[eax-$04]
   sub   eax,ebp
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              9/10 2003
//Optimized for:     P4
//Instructionset(s): IA32

function CompareText_DKC_IA32_12_a(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if (S1 = '') then
   test  eax,eax
   jz    @S1Nil
   //if (S2 = '') then
   test  edx,edx
   jz    @S2ZeroS1NotNil
   //S1Len := Length(S1);
   mov   ebx,[eax-$04]
   //S2Len := Length(S2);
   mov   ebp,[edx-$04]
   //if (S1Len = 0) then
   test  ebx,ebx
   jz    @S1Zero
   //if (S2Len = 0) then
   test  ebp,ebp
   jz    @S2ZeroS1NotZero
   //MinSLen := Min(S1Len, S2Len) -1
   cmp    ebx,ebp
   cmova  edi,ebp
   cmovbe edi,ebx
   sub    edi,1
   //I1 := -1;
 @Else2End :
   or    esi,-$01
   //RepeatBegin :
 @RepeatBegin :
   //Inc(I1);
   add   esi,1
   //C1 := S1[I1+1];
   movzx ecx,[eax+esi]
   //C2 := S2[I1+1];
   movzx ebx,[edx+esi]
   //until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
   cmp   cl,bl
   jnz   @RepeatEnd
   cmp   edi,esi
   jnle  @RepeatBegin
 @RepeatEnd :
   //C2 := S2[I1+1];
   mov   bh,$7a
   mov   ch,$61
   //if S1[I1+1] <> S2[I1+1] then
   cmp   cl,bl
   jz @If3End
   //if (C1 >= 'a') and (C1 <= 'z') then
   cmp   cl,ch
   jb    @If6End
   cmp   cl,bh
   jnbe  @If6End
   //C1 := blar(Byte(C1) - 32);
   sub   cl,$20
 @If6End :
   //if (C2 >= 'a') and (C2 <= 'z') then
   cmp   bl,ch
   jb    @If4End
   cmp   bl,bh
   jnbe  @If4End
   //C2 := Char(Byte(C2) - 32);
   sub   bl,$20
 @If4End :
   //if C1 = C2 then
   cmp   bl,cl
   jz    @RepeatBegin
   //if C1 > C2 then
   cmp   cl,bl
   jbe   @If5End
   //Result := I1+1
   mov   eax,esi
   add   eax,1
   jmp   @Exit
   @If5End :
   //else //if C1 < C2 then
   //Result := -(I1+1);
   mov   eax,esi
   add   eax,1
   neg   eax
   jmp   @Exit
   @If3End :
   //else
   //Result := S1Len - S2Len;
   mov   eax,[eax-$04]
   sub   eax,ebp
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S1Zero :
   test  ebp,ebp
   jz    @S1andS2Zero
   mov   eax,-1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S1Nil :
   test  edx,edx
   jz    @S1andS2Zero//Actually S1 = nil and S2 = nil
  //S2Len := Length(S2);
   mov   ebp,[edx-$04]
   test  ebp,ebp
   jz    @S1andS2Zero//Actually S1 = nil and S2Len = 0
   mov   eax,-1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S2ZeroS1NotZero :
   mov   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S2ZeroS1NotNil :
  //S1Len := Length(S1);
   mov   ebx,[eax-$04]
   test  ebx,ebx
   jz    @S1andS2Zero
   mov   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S1andS2Zero :
   //Result := 0;
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
end;

procedure Filler4;
asm
 nop
end;

function CompareText_DKC_IA32_12_b(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if (S1 = '') then
   test  eax,eax
   jz    @S1Nil
   //if (S2 = '') then
   test  edx,edx
   jz    @S2ZeroS1NotNil
   //S1Len := Length(S1);
   mov   ebx,[eax-$04]
   //S2Len := Length(S2);
   mov   ebp,[edx-$04]
   //if (S1Len = 0) then
   test  ebx,ebx
   jz    @S1Zero
   //if (S2Len = 0) then
   test  ebp,ebp
   jz    @S2ZeroS1NotZero
   //MinSLen := Min(S1Len, S2Len) -1
   cmp    ebx,ebp
   cmova  edi,ebp
   cmovbe edi,ebx
   sub    edi,1
   //I1 := -1;
 @Else2End :
   or    esi,-$01
   //RepeatBegin :
 @RepeatBegin :
   //Inc(I1);
   add   esi,1
   //C1 := S1[I1+1];
   movzx ecx,[eax+esi]
   //C2 := S2[I1+1];
   movzx ebx,[edx+esi]
   //until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
   cmp   cl,bl
   jnz   @RepeatEnd
   cmp   edi,esi
   jnle  @RepeatBegin
 @RepeatEnd :
   //C2 := S2[I1+1];
   mov   bh,$7a
   mov   ch,$61
   //if S1[I1+1] <> S2[I1+1] then
   cmp   cl,bl
   jz @If3End
   //if (C1 >= 'a') and (C1 <= 'z') then
   cmp   cl,ch
   jb    @If6End
   cmp   cl,bh
   jnbe  @If6End
   //C1 := blar(Byte(C1) - 32);
   sub   cl,$20
 @If6End :
   //if (C2 >= 'a') and (C2 <= 'z') then
   cmp   bl,ch
   jb    @If4End
   cmp   bl,bh
   jnbe  @If4End
   //C2 := Char(Byte(C2) - 32);
   sub   bl,$20
 @If4End :
   //if C1 = C2 then
   cmp   bl,cl
   jz    @RepeatBegin
   //if C1 > C2 then
   cmp   cl,bl
   jbe   @If5End
   //Result := I1+1
   mov   eax,esi
   add   eax,1
   jmp   @Exit
   @If5End :
   //else //if C1 < C2 then
   //Result := -(I1+1);
   mov   eax,esi
   add   eax,1
   neg   eax
   jmp   @Exit
   @If3End :
   //else
   //Result := S1Len - S2Len;
   mov   eax,[eax-$04]
   sub   eax,ebp
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S1Zero :
   test  ebp,ebp
   jz    @S1andS2Zero
   mov   eax,-1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S1Nil :
   test  edx,edx
   jz    @S1andS2Zero//Actually S1 = nil and S2 = nil
  //S2Len := Length(S2);
   mov   ebp,[edx-$04]
   test  ebp,ebp
   jz    @S1andS2Zero//Actually S1 = nil and S2Len = 0
   mov   eax,-1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S2ZeroS1NotZero :
   mov   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S2ZeroS1NotNil :
  //S1Len := Length(S1);
   mov   ebx,[eax-$04]
   test  ebx,ebx
   jz    @S1andS2Zero
   mov   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S1andS2Zero :
   //Result := 0;
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
end;

procedure Filler5;
asm
 nop
end;

function CompareText_DKC_IA32_12_c(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if (S1 = '') then
   test  eax,eax
   jz    @S1Nil
   //if (S2 = '') then
   test  edx,edx
   jz    @S2ZeroS1NotNil
   //S1Len := Length(S1);
   mov   ebx,[eax-$04]
   //S2Len := Length(S2);
   mov   ebp,[edx-$04]
   //if (S1Len = 0) then
   test  ebx,ebx
   jz    @S1Zero
   //if (S2Len = 0) then
   test  ebp,ebp
   jz    @S2ZeroS1NotZero
   //MinSLen := Min(S1Len, S2Len) -1
   cmp    ebx,ebp
   cmova  edi,ebp
   cmovbe edi,ebx
   sub    edi,1
   //I1 := -1;
 @Else2End :
   or    esi,-$01
   //RepeatBegin :
 @RepeatBegin :
   //Inc(I1);
   add   esi,1
   //C1 := S1[I1+1];
   movzx ecx,[eax+esi]
   //C2 := S2[I1+1];
   movzx ebx,[edx+esi]
   //until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
   cmp   cl,bl
   jnz   @RepeatEnd
   cmp   edi,esi
   jnle  @RepeatBegin
 @RepeatEnd :
   //C2 := S2[I1+1];
   mov   bh,$7a
   mov   ch,$61
   //if S1[I1+1] <> S2[I1+1] then
   cmp   cl,bl
   jz @If3End
   //if (C1 >= 'a') and (C1 <= 'z') then
   cmp   cl,ch
   jb    @If6End
   cmp   cl,bh
   jnbe  @If6End
   //C1 := blar(Byte(C1) - 32);
   sub   cl,$20
 @If6End :
   //if (C2 >= 'a') and (C2 <= 'z') then
   cmp   bl,ch
   jb    @If4End
   cmp   bl,bh
   jnbe  @If4End
   //C2 := Char(Byte(C2) - 32);
   sub   bl,$20
 @If4End :
   //if C1 = C2 then
   cmp   bl,cl
   jz    @RepeatBegin
   //if C1 > C2 then
   cmp   cl,bl
   jbe   @If5End
   //Result := I1+1
   mov   eax,esi
   add   eax,1
   jmp   @Exit
   @If5End :
   //else //if C1 < C2 then
   //Result := -(I1+1);
   mov   eax,esi
   add   eax,1
   neg   eax
   jmp   @Exit
   @If3End :
   //else
   //Result := S1Len - S2Len;
   mov   eax,[eax-$04]
   sub   eax,ebp
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S1Zero :
   test  ebp,ebp
   jz    @S1andS2Zero
   mov   eax,-1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S1Nil :
   test  edx,edx
   jz    @S1andS2Zero//Actually S1 = nil and S2 = nil
  //S2Len := Length(S2);
   mov   ebp,[edx-$04]
   test  ebp,ebp
   jz    @S1andS2Zero//Actually S1 = nil and S2Len = 0
   mov   eax,-1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S2ZeroS1NotZero :
   mov   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S2ZeroS1NotNil :
  //S1Len := Length(S1);
   mov   ebx,[eax-$04]
   test  ebx,ebx
   jz    @S1andS2Zero
   mov   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S1andS2Zero :
   //Result := 0;
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
end;

procedure Filler6;
asm
 nop
end;

function CompareText_DKC_IA32_12_d(const S1, S2: string): Integer;
asm
   push  ebx
   push  esi
   push  edi
   push  ebp
   //if (S1 = '') then
   test  eax,eax
   jz    @S1Nil
   //if (S2 = '') then
   test  edx,edx
   jz    @S2ZeroS1NotNil
   //S1Len := Length(S1);
   mov   ebx,[eax-$04]
   //S2Len := Length(S2);
   mov   ebp,[edx-$04]
   //if (S1Len = 0) then
   test  ebx,ebx
   jz    @S1Zero
   //if (S2Len = 0) then
   test  ebp,ebp
   jz    @S2ZeroS1NotZero
   //MinSLen := Min(S1Len, S2Len) -1
   cmp    ebx,ebp
   cmova  edi,ebp
   cmovbe edi,ebx
   sub    edi,1
   //I1 := -1;
 @Else2End :
   or    esi,-$01
   //RepeatBegin :
 @RepeatBegin :
   //Inc(I1);
   add   esi,1
   //C1 := S1[I1+1];
   movzx ecx,[eax+esi]
   //C2 := S2[I1+1];
   movzx ebx,[edx+esi]
   //until((S1[I1+1] <> S2[I1+1]) or (I1 >= MinSLen));//Runs as long as strings are equal and the end of the shortest string is not met
   cmp   cl,bl
   jnz   @RepeatEnd
   cmp   edi,esi
   jnle  @RepeatBegin
 @RepeatEnd :
   //C2 := S2[I1+1];
   mov   bh,$7a
   mov   ch,$61
   //if S1[I1+1] <> S2[I1+1] then
   cmp   cl,bl
   jz @If3End
   //if (C1 >= 'a') and (C1 <= 'z') then
   cmp   cl,ch
   jb    @If6End
   cmp   cl,bh
   jnbe  @If6End
   //C1 := blar(Byte(C1) - 32);
   sub   cl,$20
 @If6End :
   //if (C2 >= 'a') and (C2 <= 'z') then
   cmp   bl,ch
   jb    @If4End
   cmp   bl,bh
   jnbe  @If4End
   //C2 := Char(Byte(C2) - 32);
   sub   bl,$20
 @If4End :
   //if C1 = C2 then
   cmp   bl,cl
   jz    @RepeatBegin
   //if C1 > C2 then
   cmp   cl,bl
   jbe   @If5End
   //Result := I1+1
   mov   eax,esi
   add   eax,1
   jmp   @Exit
   @If5End :
   //else //if C1 < C2 then
   //Result := -(I1+1);
   mov   eax,esi
   add   eax,1
   neg   eax
   jmp   @Exit
   @If3End :
   //else
   //Result := S1Len - S2Len;
   mov   eax,[eax-$04]
   sub   eax,ebp
 @Exit :
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S1Zero :
   test  ebp,ebp
   jz    @S1andS2Zero
   mov   eax,-1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S1Nil :
   test  edx,edx
   jz    @S1andS2Zero//Actually S1 = nil and S2 = nil
  //S2Len := Length(S2);
   mov   ebp,[edx-$04]
   test  ebp,ebp
   jz    @S1andS2Zero//Actually S1 = nil and S2Len = 0
   mov   eax,-1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S2ZeroS1NotZero :
   mov   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S2ZeroS1NotNil :
  //S1Len := Length(S1);
   mov   ebx,[eax-$04]
   test  ebx,ebx
   jz    @S1andS2Zero
   mov   eax,1
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
@S1andS2Zero :
   //Result := 0;
   xor   eax,eax
   pop   ebp
   pop   edi
   pop   esi
   pop   ebx
   ret
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
 InitializeLookUpTable;

end.
