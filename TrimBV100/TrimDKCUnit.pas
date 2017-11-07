unit TrimDKCUnit;

interface

implementation

uses
 MainUnit;

//Author:            Dennis Kjaer Christensen
//Date:              3/2 2007
//Instructionset(s): IA32

function Trim_DKC_Pas_1_a(const S : string) : string;
var
 Left, Right : Integer;
 C : Char;

begin
 if S <> '' then
  begin
   Left := 0;
   repeat
    Inc(Left);
    C := S[Left];//May read the zero terminator and cause a range check exception
   until (C > ' ') or (Left >= Length(S));
   Right := Length(S)+1;
   repeat
    Dec(Right);
    C := S[Right];
   until (C > ' ') or (Right <= Left);
   if (Right >= Left) and (C > ' ') then
    Result := Copy(S, Left, Right-Left+1)
   else
    Result := '';
  end
 else
  Result := '';
end;

function Trim_DKC_Pas_1_b(const S : string) : string;
var
 Left, Right : Integer;
 C : Char;

begin
 if S <> '' then
  begin
   Left := 0;
   repeat
    Inc(Left);
    C := S[Left];//May read the zero terminator and cause a range check exception
   until (C > ' ') or (Left >= Length(S));
   Right := Length(S)+1;
   repeat
    Dec(Right);
    C := S[Right];
   until (C > ' ') or (Right <= Left);
   if (Right >= Left) and (C > ' ') then
    Result := Copy(S, Left, Right-Left+1)
   else
    Result := '';
  end
 else
  Result := '';
end;

procedure Filler1;
asm
 nop
end;

function Trim_DKC_Pas_1_c(const S : string) : string;
var
 Left, Right : Integer;
 C : Char;

begin
 if S <> '' then
  begin
   Left := 0;
   repeat
    Inc(Left);
    C := S[Left];//May read the zero terminator and cause a range check exception
   until (C > ' ') or (Left >= Length(S));
   Right := Length(S)+1;
   repeat
    Dec(Right);
    C := S[Right];
   until (C > ' ') or (Right <= Left);
   if (Right >= Left) and (C > ' ') then
    Result := Copy(S, Left, Right-Left+1)
   else
    Result := '';
  end
 else
  Result := '';
end;

function Trim_DKC_Pas_1_d(const S : string) : string;
var
 Left, Right : Integer;
 C : Char;

begin
 if S <> '' then
  begin
   Left := 0;
   repeat
    Inc(Left);
    C := S[Left]; //May read the zero terminator and cause a range check exception
   until (C > ' ') or (Left >= Length(S));
   Right := Length(S)+1;
   repeat
    Dec(Right);
    C := S[Right];
   until (C > ' ') or (Right <= Left);
   if (Right >= Left) and (C > ' ') then
    Result := Copy(S, Left, Right-Left+1)
   else
    Result := '';
  end
 else
  Result := '';
end;

//Author:            Dennis Kjaer Christensen
//Date:              3/2 2007
//Instructionset(s): IA32

function Trim_DKC_Pas_2_a(const S : string) : string;
var
 Left, Right, SLen : Integer;
 C : Char;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    C := S[Left];//May read the zero terminator and cause a range check exception
   until (C > ' ') or (Left >= SLen);
   Right := SLen+1;
   repeat
    Dec(Right);
    C := S[Right];
   until (C > ' ') or (Right <= Left);
   if (Right >= Left) and (C > ' ') then
    Result := Copy(S, Left, Right-Left+1)
   else
    Result := '';
  end
 else
  Result := '';
end;

procedure Filler2;
asm
 nop
end;

function Trim_DKC_Pas_2_b(const S : string) : string;
var
 Left, Right, SLen : Integer;
 C : Char;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    C := S[Left];//May read the zero terminator and cause a range check exception
   until (C > ' ') or (Left >= SLen);
   Right := SLen+1;
   repeat
    Dec(Right);
    C := S[Right];
   until (C > ' ') or (Right <= Left);
   if (Right >= Left) and (C > ' ') then
    Result := Copy(S, Left, Right-Left+1)
   else
    Result := '';
  end
 else
  Result := '';
end;

procedure Filler3;
asm
 nop
end;

function Trim_DKC_Pas_2_c(const S : string) : string;
var
 Left, Right, SLen : Integer;
 C : Char;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    C := S[Left];//May read the zero terminator and cause a range check exception
   until (C > ' ') or (Left >= SLen);
   Right := SLen+1;
   repeat
    Dec(Right);
    C := S[Right];
   until (C > ' ') or (Right <= Left);
   if (Right >= Left) and (C > ' ') then
    Result := Copy(S, Left, Right-Left+1)
   else
    Result := '';
  end
 else
  Result := '';
end;

procedure Filler4;
asm
 nop
end;

function Trim_DKC_Pas_2_d(const S : string) : string;
var
 Left, Right, SLen : Integer;
 C : Char;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    C := S[Left]; //May read the zero terminator and cause a range check exception
   until (C > ' ') or (Left >= SLen);
   Right := SLen+1;
   repeat
    Dec(Right);
    C := S[Right];
   until (C > ' ') or (Right <= Left);
   if (Right >= Left) and (C > ' ') then
    Result := Copy(S, Left, Right-Left+1)
   else
    Result := '';
  end
 else
  Result := '';
end;

//Author:            Dennis Kjaer Christensen
//Date:              3/2 2007
//Instructionset(s): IA32

function Trim_DKC_Pas_3_a(const S : string) : string;
var
 Left, Right, SLen : Integer;
 C : Char;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    if (Left >= SLen) then
     Break;
    C := S[Left];
   until (C > ' ');
   Right := SLen+1;
   repeat
    Dec(Right);
    if (Right < Left) then
     begin
      Result := '';
      Exit;
     end;
    C := S[Right];
   until (C > ' ');
    Result := Copy(S, Left, Right-Left+1)
  end
 else
  Result := '';
end;

function Trim_DKC_Pas_3_b(const S : string) : string;
var
 Left, Right, SLen : Integer;
 C : Char;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    if (Left >= SLen) then
     Break;
    C := S[Left];
   until (C > ' ');
   Right := SLen+1;
   repeat
    Dec(Right);
    if (Right < Left) then
     begin
      Result := '';
      Exit;
     end;
    C := S[Right];
   until (C > ' ');
    Result := Copy(S, Left, Right-Left+1)
  end
 else
  Result := '';
end;

procedure Filler5;
asm
 nop
end;

function Trim_DKC_Pas_3_c(const S : string) : string;
var
 Left, Right, SLen : Integer;
 C : Char;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    if (Left >= SLen) then
     Break;
    C := S[Left];
   until (C > ' ');
   Right := SLen+1;
   repeat
    Dec(Right);
    if (Right < Left) then
     begin
      Result := '';
      Exit;
     end;
    C := S[Right];
   until (C > ' ');
    Result := Copy(S, Left, Right-Left+1)
  end
 else
  Result := '';
end;

function Trim_DKC_Pas_3_d(const S : string) : string;
var
 Left, Right, SLen : Integer;
 C : Char;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    if (Left >= SLen) then
     Break;
    C := S[Left];
   until (C > ' ');
   Right := SLen+1;
   repeat
    Dec(Right);
    if (Right < Left) then
     begin
      Result := '';
      Exit;
     end;
    C := S[Right];
   until (C > ' ');
    Result := Copy(S, Left, Right-Left+1)
  end
 else
  Result := '';
end;

//Author:            Dennis Kjaer Christensen
//Date:              4/2 2007
//Instructionset(s): IA32

function Trim_DKC_Pas_4_a(const S : string) : string;
var
 Left, Right, SLen : Integer;
 C : Char;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    if (Left >= SLen) then
     Break;
    C := S[Left];
   until (C > ' ');
   Right := SLen;
   repeat
    if (Right < Left) then
     begin
      Result := '';
      Exit;
     end;
    C := S[Right];
    Dec(Right);
   until (C > ' ');
   Result := Copy(S, Left, Right-Left+2)
  end
 else
  Result := '';
end;

function Trim_DKC_Pas_4_b(const S : string) : string;
var
 Left, Right, SLen : Integer;
 C : Char;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    if (Left >= SLen) then
     Break;
    C := S[Left];
   until (C > ' ');
   Right := SLen;
   repeat
    if (Right < Left) then
     begin
      Result := '';
      Exit;
     end;
    C := S[Right];
    Dec(Right);
   until (C > ' ');
   Result := Copy(S, Left, Right-Left+2)
  end
 else
  Result := '';
end;

function Trim_DKC_Pas_4_c(const S : string) : string;
var
 Left, Right, SLen : Integer;
 C : Char;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    if (Left >= SLen) then
     Break;
    C := S[Left];
   until (C > ' ');
   Right := SLen;
   repeat
    if (Right < Left) then
     begin
      Result := '';
      Exit;
     end;
    C := S[Right];
    Dec(Right);
   until (C > ' ');
   Result := Copy(S, Left, Right-Left+2)
  end
 else
  Result := '';
end;

function Trim_DKC_Pas_4_d(const S : string) : string;
var
 Left, Right, SLen : Integer;
 C : Char;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    if (Left >= SLen) then
     Break;
    C := S[Left];
   until (C > ' ');
   Right := SLen;
   repeat
    if (Right < Left) then
     begin
      Result := '';
      Exit;
     end;
    C := S[Right];
    Dec(Right);
   until (C > ' ');
   Result := Copy(S, Left, Right-Left+2)
  end
 else
  Result := '';
end;

//Author:            Dennis Kjaer Christensen
//Date:              4/2 2007
//Instructionset(s): IA32

function Trim_DKC_Pas_5_a(const S : string) : string;
var
 Left, Right, SLen : Integer;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    if (Left >= SLen) then
     Break;
   until (S[Left] > ' ');
   Right := SLen;
   repeat
    if (Right < Left) then
     begin
      Result := '';
      Exit;
     end;
    Dec(Right);
   until (S[Right+1] > ' ');
   Result := Copy(S, Left, Right-Left+2)
  end
 else
  Result := '';
end;

function Trim_DKC_Pas_5_b(const S : string) : string;
var
 Left, Right, SLen : Integer;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    if (Left >= SLen) then
     Break;
   until (S[Left] > ' ');
   Right := SLen;
   repeat
    if (Right < Left) then
     begin
      Result := '';
      Exit;
     end;
    Dec(Right);
   until (S[Right+1] > ' ');
   Result := Copy(S, Left, Right-Left+2)
  end
 else
  Result := '';
end;

function Trim_DKC_Pas_5_c(const S : string) : string;
var
 Left, Right, SLen : Integer;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    if (Left >= SLen) then
     Break;
   until (S[Left] > ' ');
   Right := SLen;
   repeat
    if (Right < Left) then
     begin
      Result := '';
      Exit;
     end;
    Dec(Right);
   until (S[Right+1] > ' ');
   Result := Copy(S, Left, Right-Left+2)
  end
 else
  Result := '';
end;

function Trim_DKC_Pas_5_d(const S : string) : string;
var
 Left, Right, SLen : Integer;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    if (Left >= SLen) then
     Break;
   until (S[Left] > ' ');
   Right := SLen;
   repeat
    if (Right < Left) then
     begin
      Result := '';
      Exit;
     end;
    Dec(Right);
   until (S[Right+1] > ' ');
   Result := Copy(S, Left, Right-Left+2)
  end
 else
  Result := '';
end;

//Author:            Dennis Kjaer Christensen
//Date:              4/2 2007
//Instructionset(s): IA32

function Trim_DKC_Pas_6_a(const S : string) : string;
var
 Left, Right, SLen : Integer;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    if (Left >= SLen) then
     Break;
   until (S[Left] > ' ');
   Right := SLen+1;
   repeat
    Dec(Right);
    if (Right < Left) then
     Break;
   until (S[Right] > ' ');
   Result := Copy(S, Left, Right-Left+1)
  end
 else
  Result := '';
end;

function Trim_DKC_Pas_6_b(const S : string) : string;
var
 Left, Right, SLen : Integer;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    if (Left >= SLen) then
     Break;
   until (S[Left] > ' ');
   Right := SLen+1;
   repeat
    Dec(Right);
    if (Right < Left) then
     Break;
   until (S[Right] > ' ');
   Result := Copy(S, Left, Right-Left+1)
  end
 else
  Result := '';
end;

function Trim_DKC_Pas_6_c(const S : string) : string;
var
 Left, Right, SLen : Integer;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    if (Left >= SLen) then
     Break;
   until (S[Left] > ' ');
   Right := SLen+1;
   repeat
    Dec(Right);
    if (Right < Left) then
     Break;
   until (S[Right] > ' ');
   Result := Copy(S, Left, Right-Left+1)
  end
 else
  Result := '';
end;

function Trim_DKC_Pas_6_d(const S : string) : string;
var
 Left, Right, SLen : Integer;

begin
 if S <> '' then
  begin
   SLen := Length(S);
   Left := 0;
   repeat
    Inc(Left);
    if (Left >= SLen) then
     Break;
   until (S[Left] > ' ');
   Right := SLen+1;
   repeat
    Dec(Right);
    if (Right < Left) then
     Break;
   until (S[Right] > ' ');
   Result := Copy(S, Left, Right-Left+1)
  end
 else
  Result := '';
end;

//Author:            Dennis Kjaer Christensen
//Date:              4/2 2007
//Instructionset(s): IA32

function Trim_DKC_Pas_7_a(const S : string) : string;
var
 Left, Right, SLen : Integer;

begin
 SLen := Length(S);
 Left := 0;
 repeat
  Inc(Left);
  if (Left >= SLen) then
   Break;
 until (S[Left] > ' ');
 Right := SLen+1;
 repeat
  Dec(Right);
  if (Right < Left) then
   Break;
 until (S[Right] > ' ');
 Result := Copy(S, Left, Right-Left+1)
end;

function Trim_DKC_Pas_7_b(const S : string) : string;
var
 Left, Right, SLen : Integer;

begin
 SLen := Length(S);
 Left := 0;
 repeat
  Inc(Left);
  if (Left >= SLen) then
   Break;
 until (S[Left] > ' ');
 Right := SLen+1;
 repeat
  Dec(Right);
  if (Right < Left) then
   Break;
 until (S[Right] > ' ');
 Result := Copy(S, Left, Right-Left+1)
end;

function Trim_DKC_Pas_7_c(const S : string) : string;
var
 Left, Right, SLen : Integer;

begin
 SLen := Length(S);
 Left := 0;
 repeat
  Inc(Left);
  if (Left >= SLen) then
   Break;
 until (S[Left] > ' ');
 Right := SLen+1;
 repeat
  Dec(Right);
  if (Right < Left) then
   Break;
 until (S[Right] > ' ');
 Result := Copy(S, Left, Right-Left+1)
end;

function Trim_DKC_Pas_7_d(const S : string) : string;
var
 Left, Right, SLen : Integer;

begin
 SLen := Length(S);
 Left := 0;
 repeat
  Inc(Left);
  if (Left >= SLen) then
   Break;
 until (S[Left] > ' ');
 Right := SLen+1;
 repeat
  Dec(Right);
  if (Right < Left) then
   Break;
 until (S[Right] > ' ');
 Result := Copy(S, Left, Right-Left+1)
end;

//Author:            Dennis Kjaer Christensen
//Date:              4/2 2007
//Instructionset(s): IA32

function Trim_DKC_Pas_8_a(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 Left := 0;
 Right := SLen;
 repeat
  Inc(Left);
  if (Left > SLen) then
   goto Done;
 until (S[Left] > ' ');
 Inc(Right);
 repeat
  Dec(Right);
  if (Right <= Left) then
   Break;
 until (S[Right] > ' ');
Done :
 Result := Copy(S, Left, Right-Left+1)
end;

function Trim_DKC_Pas_8_b(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 Left := 0;
 Right := SLen;
 repeat
  Inc(Left);
  if (Left > SLen) then
   goto Done;
 until (S[Left] > ' ');
 Inc(Right);
 repeat
  Dec(Right);
  if (Right <= Left) then
   Break;
 until (S[Right] > ' ');
Done :
 Result := Copy(S, Left, Right-Left+1)
end;

function Trim_DKC_Pas_8_c(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 Left := 0;
 Right := SLen;
 repeat
  Inc(Left);
  if (Left > SLen) then
   goto Done;
 until (S[Left] > ' ');
 Inc(Right);
 repeat
  Dec(Right);
  if (Right <= Left) then
   Break;
 until (S[Right] > ' ');
Done :
 Result := Copy(S, Left, Right-Left+1)
end;

function Trim_DKC_Pas_8_d(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 Left := 0;
 Right := SLen;
 repeat
  Inc(Left);
  if (Left > SLen) then
   goto Done;
 until (S[Left] > ' ');
 Inc(Right);
 repeat
  Dec(Right);
  if (Right <= Left) then
   Break;
 until (S[Right] > ' ');
Done :
 Result := Copy(S, Left, Right-Left+1)
end;

//Author:            Dennis Kjaer Christensen
//Date:              4/2 2007
//Instructionset(s): IA32

function Trim_DKC_Pas_9_a(const S : string) : string;
var
 Left, Right, SLen : Integer;

begin
 SLen := Length(S);
 Left := 0;
 Right := SLen;
 repeat
  if (Left >= SLen) then
   begin
    Result := '';
    Exit;
   end;
  if (S[Left+1] > ' ') then
   Break;
  Inc(Left);
 until (False);
 repeat
  Dec(Right);
  if (Right < Left) then
   begin
    Result := '';
    Exit;
   end;
 until (S[Right+1] > ' ');
 Result := Copy(S, Left+1, Right-Left+1)
end;

function Trim_DKC_Pas_9_b(const S : string) : string;
var
 Left, Right, SLen : Integer;

begin
 SLen := Length(S);
 Left := 0;
 Right := SLen;
 repeat
  if (Left >= SLen) then
   begin
    Result := '';
    Exit;
   end;
  if (S[Left+1] > ' ') then
   Break;
  Inc(Left);
 until (False);
 repeat
  Dec(Right);
  if (Right < Left) then
   begin
    Result := '';
    Exit;
   end;
 until (S[Right+1] > ' ');
 Result := Copy(S, Left+1, Right-Left+1)
end;

procedure Filler6;
asm
 nop
end;

function Trim_DKC_Pas_9_c(const S : string) : string;
var
 Left, Right, SLen : Integer;

begin
 SLen := Length(S);
 Left := 0;
 Right := SLen;
 repeat
  if (Left >= SLen) then
   begin
    Result := '';
    Exit;
   end;
  if (S[Left+1] > ' ') then
   Break;
  Inc(Left);
 until (False);
 repeat
  Dec(Right);
  if (Right < Left) then
   begin
    Result := '';
    Exit;
   end;
 until (S[Right+1] > ' ');
 Result := Copy(S, Left+1, Right-Left+1)
end;

function Trim_DKC_Pas_9_d(const S : string) : string;
var
 Left, Right, SLen : Integer;

begin
 SLen := Length(S);
 Left := 0;
 Right := SLen;
 repeat
  if (Left >= SLen) then
   begin
    Result := '';
    Exit;
   end;
  if (S[Left+1] > ' ') then
   Break;
  Inc(Left);
 until (False);
 repeat
  Dec(Right);
  if (Right < Left) then
   begin
    Result := '';
    Exit;
   end;
 until (S[Right+1] > ' ');
 Result := Copy(S, Left+1, Right-Left+1)
end;

//Author:            Dennis Kjaer Christensen
//Date:              4/2 2007
//Instructionset(s): IA32

function Trim_DKC_Pas_10_a(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;
begin
 SLen := Length(S);
 Left := 0;
 Right := SLen;
 repeat
  if (Left >= SLen) then
   goto Done;
  if (S[Left+1] > ' ') then
   Break;
  Inc(Left);
 until (False);
 repeat
  Dec(Right);
  if (Right < Left) then
   goto Done;
 until (S[Right+1] > ' ');
 Result := Copy(S, Left+1, Right-Left+1);
 Exit;
Done :
 Result := '';
end;

procedure Filler7;
asm
 nop
end;

function Trim_DKC_Pas_10_b(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;
begin
 SLen := Length(S);
 Left := 0;
 Right := SLen;
 repeat
  if (Left >= SLen) then
   goto Done;
  if (S[Left+1] > ' ') then
   Break;
  Inc(Left);
 until (False);
 repeat
  Dec(Right);
  if (Right < Left) then
   goto Done;
 until (S[Right+1] > ' ');
 Result := Copy(S, Left+1, Right-Left+1);
 Exit;
Done :
 Result := '';
end;

procedure Filler8;
asm
 nop
end;

function Trim_DKC_Pas_10_c(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;
begin
 SLen := Length(S);
 Left := 0;
 Right := SLen;
 repeat
  if (Left >= SLen) then
   goto Done;
  if (S[Left+1] > ' ') then
   Break;
  Inc(Left);
 until (False);
 repeat
  Dec(Right);
  if (Right < Left) then
   goto Done;
 until (S[Right+1] > ' ');
 Result := Copy(S, Left+1, Right-Left+1);
 Exit;
Done :
 Result := '';
end;

procedure Filler9;
asm
 nop
end;

function Trim_DKC_Pas_10_d(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;
begin
 SLen := Length(S);
 Left := 0;
 Right := SLen;
 repeat
  if (Left >= SLen) then
   goto Done;
  if (S[Left+1] > ' ') then
   Break;
  Inc(Left);
 until (False);
 repeat
  Dec(Right);
  if (Right < Left) then
   goto Done;
 until (S[Right+1] > ' ');
 Result := Copy(S, Left+1, Right-Left+1);
 Exit;
Done :
 Result := '';
end;

//Author:            Dennis Kjaer Christensen
//Date:              6/2 2007
//Instructionset(s): IA32

function Trim_DKC_Pas_11_a(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

function Trim_DKC_Pas_11_b(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

procedure Filler10;
asm
 nop
end;

function Trim_DKC_Pas_11_c(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

function Trim_DKC_Pas_11_d(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              27/2 2007
//Instructionset(s): IA32

function Copy_DKC_Pas_1(const S : string; Index, Count : Integer) : string;{$ifdef ver170}inline; {$endif} {$ifdef ver180}inline; {$endif}{$ifdef ver190}inline; {$endif}
begin
 Result := Copy(S, Index, Count);
end;

function Trim_DKC_Pas_12_a(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy_DKC_Pas_1(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

function Trim_DKC_Pas_12_b(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy_DKC_Pas_1(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

function Trim_DKC_Pas_12_c(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy_DKC_Pas_1(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

function Trim_DKC_Pas_12_d(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy_DKC_Pas_1(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              27/2 2007
//Instructionset(s): IA32

function Copy_DKC_Pas_2(const S : string; Index, Count : Integer) : string;{$ifdef ver170}inline; {$endif} {$ifdef ver180}inline; {$endif}{$ifdef ver190}inline; {$endif}
begin
 SetLength(Result, Count);
 Result := Copy(S, Index, Count);
end;

function Trim_DKC_Pas_13_a(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy_DKC_Pas_2(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

function Trim_DKC_Pas_13_b(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy_DKC_Pas_2(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

procedure Filler11;
asm
 nop
end;

function Trim_DKC_Pas_13_c(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy_DKC_Pas_2(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

function Trim_DKC_Pas_13_d(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy_DKC_Pas_2(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              27/2 2007
//Instructionset(s): IA32

function Copy_DKC_Pas_3(const S : string; Index, Count : Integer) : string;{$ifdef ver170}inline; {$endif} {$ifdef ver180}inline; {$endif}{$ifdef ver190}inline; {$endif}
begin
 SetLength(Result, Count);
 Move(S[Index], Result[1], Count);
end;

function Trim_DKC_Pas_14_a(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy_DKC_Pas_3(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

procedure Filler12;
asm
 nop
end;

function Trim_DKC_Pas_14_b(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy_DKC_Pas_3(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

procedure Filler13;
asm
 nop
end;

function Trim_DKC_Pas_14_c(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy_DKC_Pas_3(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

procedure Filler14;
asm
 nop
end;

function Trim_DKC_Pas_14_d(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy_DKC_Pas_3(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              27/2 2007
//Instructionset(s): IA32

function Copy_DKC_Pas_4(const S : string; Index, Count : Integer) : string;{$ifdef ver170}inline; {$endif} {$ifdef ver180}inline; {$endif}{$ifdef ver190}inline; {$endif}
begin
 if Length(Result) <> Count then
  SetLength(Result, Count);
 Move(S[Index], Result[1], Count);
end;

function Trim_DKC_Pas_15_a(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy_DKC_Pas_4(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

function Trim_DKC_Pas_15_b(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy_DKC_Pas_4(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

function Trim_DKC_Pas_15_c(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy_DKC_Pas_4(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

function Trim_DKC_Pas_15_d(const S : string) : string;
var
 Left, Right, SLen : Integer;
label
 Done;

begin
 SLen := Length(S);
 if SLen = 0 then
  Result := ''
 else if (S[1] > ' ') and (S[SLen] > ' ') then
  Result := S
 else
  begin
   Left := 0;
   Right := SLen;
   repeat
    if (Left >= SLen) then
     goto Done;
    if (S[Left+1] > ' ') then
     Break;
    Inc(Left);
   until (False);
   repeat
    Dec(Right);
    if (Right < Left) then
     goto Done;
   until (S[Right+1] > ' ');
   Result := Copy_DKC_Pas_4(S, Left+1, Right-Left+1);
   Exit;
  Done :
   Result := '';
  end;
end;

//Author:            Dennis Kjaer Christensen
//Date:              10/3 2007
//Instructionset(s): IA32

function Trim_DKC_IA32_1_a(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ebp
   mov  ebp,edx
   mov  edi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //Left := 0;
 @L1 :
   xor  ebx,ebx
   //Inc(Left);
 @L3 :
   add  ebx,1
   //if (Left >= SLen) then
   cmp  eax,ebx
   jle  @L2
   //until (S[Left] > ' ');
   cmp  byte ptr [edi+ebx-$01],$20
   jbe  @L3
   //Right := SLen+1;
 @L2 :
   lea  esi,[eax+$01]
   //Dec(Right);
 @L5 :
   sub  esi,1
   //if (Right < Left) then
   cmp  ebx,esi
   jnle @L4
   //until (S[Right] > ' ');
   cmp  byte ptr [edi+esi-$01],$20
   jbe  @L5 //$004763d0
   //Result := Copy(S, Left, Right-Left+1)
 @L4 :
   push ebp
   mov  ecx,esi
   sub  ecx,ebx
   add  ecx,1
   mov  edx,ebx
   mov  eax,edi
   call System.@LStrCopy
   pop  ebp
   pop  edi
   pop  esi
   pop  ebx
end;

function Trim_DKC_IA32_1_b(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ebp
   mov  ebp,edx
   mov  edi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //Left := 0;
 @L1 :
   xor  ebx,ebx
   //Inc(Left);
 @L3 :
   add  ebx,1
   //if (Left >= SLen) then
   cmp  eax,ebx
   jle  @L2
   //until (S[Left] > ' ');
   cmp  byte ptr [edi+ebx-$01],$20
   jbe  @L3
   //Right := SLen+1;
 @L2 :
   lea  esi,[eax+$01]
   //Dec(Right);
 @L5 :
   sub  esi,1
   //if (Right < Left) then
   cmp  ebx,esi
   jnle @L4
   //until (S[Right] > ' ');
   cmp  byte ptr [edi+esi-$01],$20
   jbe  @L5 //$004763d0
   //Result := Copy(S, Left, Right-Left+1)
 @L4 :
   push ebp
   mov  ecx,esi
   sub  ecx,ebx
   add  ecx,1
   mov  edx,ebx
   mov  eax,edi
   call System.@LStrCopy
   pop  ebp
   pop  edi
   pop  esi
   pop  ebx
end;

procedure Filler15;
asm
 nop
end;

function Trim_DKC_IA32_1_c(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ebp
   mov  ebp,edx
   mov  edi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //Left := 0;
 @L1 :
   xor  ebx,ebx
   //Inc(Left);
 @L3 :
   add  ebx,1
   //if (Left >= SLen) then
   cmp  eax,ebx
   jle  @L2
   //until (S[Left] > ' ');
   cmp  byte ptr [edi+ebx-$01],$20
   jbe  @L3
   //Right := SLen+1;
 @L2 :
   lea  esi,[eax+$01]
   //Dec(Right);
 @L5 :
   sub  esi,1
   //if (Right < Left) then
   cmp  ebx,esi
   jnle @L4
   //until (S[Right] > ' ');
   cmp  byte ptr [edi+esi-$01],$20
   jbe  @L5 //$004763d0
   //Result := Copy(S, Left, Right-Left+1)
 @L4 :
   push ebp
   mov  ecx,esi
   sub  ecx,ebx
   add  ecx,1
   mov  edx,ebx
   mov  eax,edi
   call System.@LStrCopy
   pop  ebp
   pop  edi
   pop  esi
   pop  ebx
end;

function Trim_DKC_IA32_1_d(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ebp
   mov  ebp,edx
   mov  edi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //Left := 0;
 @L1 :
   xor  ebx,ebx
   //Inc(Left);
 @L3 :
   add  ebx,1
   //if (Left >= SLen) then
   cmp  eax,ebx
   jle  @L2
   //until (S[Left] > ' ');
   cmp  byte ptr [edi+ebx-$01],$20
   jbe  @L3
   //Right := SLen+1;
 @L2 :
   lea  esi,[eax+$01]
   //Dec(Right);
 @L5 :
   sub  esi,1
   //if (Right < Left) then
   cmp  ebx,esi
   jnle @L4
   //until (S[Right] > ' ');
   cmp  byte ptr [edi+esi-$01],$20
   jbe  @L5 //$004763d0
   //Result := Copy(S, Left, Right-Left+1)
 @L4 :
   push ebp
   mov  ecx,esi
   sub  ecx,ebx
   add  ecx,1
   mov  edx,ebx
   mov  eax,edi
   call System.@LStrCopy
   pop  ebp
   pop  edi
   pop  esi
   pop  ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              19/9 2007
//Instructionset(s): IA32

function Trim_DKC_IA32_2_a(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ecx
   mov  [esp],edx
   mov  esi,eax
   //SLen := Length(S);
   mov  eax,esi
   test eax,eax
   jz   @L1
   sub  eax,$04
   mov  eax,[eax]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jnz  @L2
   //Result := ''
   mov  eax,[esp]
   call System.@LStrClr
   jmp  @Exit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6 //$0047bcf7
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   pop  edx
   pop  edi
   pop  esi
   pop  ebx
end;

function Trim_DKC_IA32_2_b(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ecx
   mov  [esp],edx
   mov  esi,eax
   //SLen := Length(S);
   mov  eax,esi
   test eax,eax
   jz   @L1
   sub  eax,$04
   mov  eax,[eax]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jnz  @L2
   //Result := ''
   mov  eax,[esp]
   call System.@LStrClr
   jmp  @Exit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6 //$0047bcf7
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   pop  edx
   pop  edi
   pop  esi
   pop  ebx
end;

procedure Filler16;
asm
 nop
end;

function Trim_DKC_IA32_2_c(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ecx
   mov  [esp],edx
   mov  esi,eax
   //SLen := Length(S);
   mov  eax,esi
   test eax,eax
   jz   @L1
   sub  eax,$04
   mov  eax,[eax]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jnz  @L2
   //Result := ''
   mov  eax,[esp]
   call System.@LStrClr
   jmp  @Exit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6 //$0047bcf7
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   pop  edx
   pop  edi
   pop  esi
   pop  ebx
end;

function Trim_DKC_IA32_2_d(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ecx
   mov  [esp],edx
   mov  esi,eax
   //SLen := Length(S);
   mov  eax,esi
   test eax,eax
   jz   @L1
   sub  eax,$04
   mov  eax,[eax]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jnz  @L2
   //Result := ''
   mov  eax,[esp]
   call System.@LStrClr
   jmp  @Exit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6 //$0047bcf7
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   pop  edx
   pop  edi
   pop  esi
   pop  ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              19/9 2007
//Instructionset(s): IA32

function Trim_DKC_IA32_3_a(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ecx
   mov  [esp],edx
   mov  esi,eax
   //SLen := Length(S);
   test eax,eax
   jz   @L1
   sub  eax,$04
   mov  eax,[eax]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jnz  @L2
   //Result := ''
   mov  eax,[esp]
   call System.@LStrClr
   jmp  @Exit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6 //$0047bcf7
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   pop  edx
   pop  edi
   pop  esi
   pop  ebx
end;

function Trim_DKC_IA32_3_b(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ecx
   mov  [esp],edx
   mov  esi,eax
   //SLen := Length(S);
   test eax,eax
   jz   @L1
   sub  eax,$04
   mov  eax,[eax]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jnz  @L2
   //Result := ''
   mov  eax,[esp]
   call System.@LStrClr
   jmp  @Exit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6 //$0047bcf7
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   pop  edx
   pop  edi
   pop  esi
   pop  ebx
end;

procedure Filler17;
asm
 nop
end;

function Trim_DKC_IA32_3_c(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ecx
   mov  [esp],edx
   mov  esi,eax
   //SLen := Length(S);
   test eax,eax
   jz   @L1
   sub  eax,$04
   mov  eax,[eax]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jnz  @L2
   //Result := ''
   mov  eax,[esp]
   call System.@LStrClr
   jmp  @Exit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6 //$0047bcf7
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   pop  edx
   pop  edi
   pop  esi
   pop  ebx
end;

function Trim_DKC_IA32_3_d(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ecx
   mov  [esp],edx
   mov  esi,eax
   //SLen := Length(S);
   test eax,eax
   jz   @L1
   sub  eax,$04
   mov  eax,[eax]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jnz  @L2
   //Result := ''
   mov  eax,[esp]
   call System.@LStrClr
   jmp  @Exit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6 //$0047bcf7
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   pop  edx
   pop  edi
   pop  esi
   pop  ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              19/9 2007
//Instructionset(s): IA32

function Trim_DKC_IA32_4_a(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ecx
   mov  [esp],edx
   mov  esi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jnz  @L2
   //Result := ''
   mov  eax,[esp]
   call System.@LStrClr
   jmp  @Exit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6 //$0047bcf7
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   pop  edx
   pop  edi
   pop  esi
   pop  ebx
end;

function Trim_DKC_IA32_4_b(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ecx
   mov  [esp],edx
   mov  esi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jnz  @L2
   //Result := ''
   mov  eax,[esp]
   call System.@LStrClr
   jmp  @Exit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6 //$0047bcf7
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   pop  edx
   pop  edi
   pop  esi
   pop  ebx
end;

function Trim_DKC_IA32_4_c(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ecx
   mov  [esp],edx
   mov  esi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jnz  @L2
   //Result := ''
   mov  eax,[esp]
   call System.@LStrClr
   jmp  @Exit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6 //$0047bcf7
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   pop  edx
   pop  edi
   pop  esi
   pop  ebx
end;

function Trim_DKC_IA32_4_d(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ecx
   mov  [esp],edx
   mov  esi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jnz  @L2
   //Result := ''
   mov  eax,[esp]
   call System.@LStrClr
   jmp  @Exit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6 //$0047bcf7
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   pop  edx
   pop  edi
   pop  esi
   pop  ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              19/9 2007
//Instructionset(s): IA32

function Trim_DKC_IA32_5_a(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ecx
   mov  [esp],edx
   mov  esi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jz   @ClearExit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6 //$0047bcf7
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   pop  edx
   pop  edi
   pop  esi
   pop  ebx
end;

function Trim_DKC_IA32_5_b(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ecx
   mov  [esp],edx
   mov  esi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jz   @ClearExit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6 //$0047bcf7
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   pop  edx
   pop  edi
   pop  esi
   pop  ebx
end;

function Trim_DKC_IA32_5_c(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ecx
   mov  [esp],edx
   mov  esi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jz   @ClearExit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6 //$0047bcf7
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   pop  edx
   pop  edi
   pop  esi
   pop  ebx
end;

function Trim_DKC_IA32_5_d(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   push ecx
   mov  [esp],edx
   mov  esi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jz   @ClearExit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6 //$0047bcf7
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   pop  edx
   pop  edi
   pop  esi
   pop  ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              19/9 2007
//Instructionset(s): IA32

function Trim_DKC_IA32_6_a(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   sub  esp,4
   mov  [esp],edx
   mov  esi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jz   @ClearExit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   add  esp,4
   pop  edi
   pop  esi
   pop  ebx
end;

procedure Filler18;
asm
 nop
end;

function Trim_DKC_IA32_6_b(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   sub  esp,4
   mov  [esp],edx
   mov  esi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jz   @ClearExit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   add  esp,4
   pop  edi
   pop  esi
   pop  ebx
end;

procedure Filler19;
asm
 nop
end;

function Trim_DKC_IA32_6_c(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   sub  esp,4
   mov  [esp],edx
   mov  esi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jz   @ClearExit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   add  esp,4
   pop  edi
   pop  esi
   pop  ebx
end;

procedure Filler20;
asm
 nop
end;

function Trim_DKC_IA32_6_d(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   sub  esp,4
   mov  [esp],edx
   mov  esi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jz   @ClearExit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,[esp]
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,[esp]
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,[esp]
   call System.@LStrClr
 @Exit :
   add  esp,4
   pop  edi
   pop  esi
   pop  ebx
end;

//Author:            Dennis Kjaer Christensen
//Date:              19/9 2007
//Instructionset(s): IA32

function Trim_DKC_IA32_7_a(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   //sub  esp,4
   mov  esi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jz   @ClearExit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,edx
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,edx
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,edx
   call System.@LStrClr
 @Exit :
   pop  edi
   pop  esi
   pop  ebx
end;

function Trim_DKC_IA32_7_b(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   //sub  esp,4
   mov  esi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jz   @ClearExit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,edx
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,edx
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,edx
   call System.@LStrClr
 @Exit :
   pop  edi
   pop  esi
   pop  ebx
end;

function Trim_DKC_IA32_7_c(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   //sub  esp,4
   mov  esi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jz   @ClearExit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,edx
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,edx
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,edx
   call System.@LStrClr
 @Exit :
   pop  edi
   pop  esi
   pop  ebx
end;

function Trim_DKC_IA32_7_d(const S : string) : string;
asm
   push ebx
   push esi
   push edi
   //sub  esp,4
   mov  esi,eax
   test eax,eax
   jz   @L1
   //SLen := Length(S);
   mov  eax,[eax-4]
   //if SLen = 0 then
 @L1 :
   test eax,eax
   jz   @ClearExit
   //else if (S[1] > ' ') and (S[SLen] > ' ') then
 @L2 :
   cmp  byte ptr [esi],$20
   jbe  @L4
   cmp  byte ptr [esi+eax-$01],$20
   jbe  @L4
   //Result := S
   mov  eax,edx
   mov  edx,esi
   call System.@LStrAsg
   jmp  @Exit
   //Left := 0;
 @L4 :
   xor  ebx,ebx
   //Right := SLen;
   mov  edi,eax
   //if (Left >= SLen) then
 @L7:
   cmp  eax,ebx
   jle  @ClearExit
   //if (S[Left+1] > ' ') then
   cmp  byte ptr [esi+ebx],$20
   jnbe @L6
   //Inc(Left);
   inc  ebx
   //until (False);
   jmp  @L7
   //Dec(Right);
 @L6:
   dec  edi
   //if (Right < Left) then
   cmp  ebx,edi
   jnle @ClearExit
   //until (S[Right+1] > ' ');
   cmp  byte ptr [esi+edi],$20
   jbe  @L6
   //Result := Copy(S, Left+1, Right-Left+1);
   mov  eax,edx
   push eax
   mov  ecx,edi
   sub  ecx,ebx
   inc  ecx
   lea  edx,[ebx+$01]
   mov  eax,esi
   call System.@LStrCopy
   jmp  @Exit
   //Result := '';
 @ClearExit :
   mov  eax,edx
   call System.@LStrClr
 @Exit :
   pop  edi
   pop  esi
   pop  ebx
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
 Filler13;
 Filler14;
 Filler15;
 Filler16;
 Filler17;
 Filler18;
 Filler19;
 Filler20;
 MainForm.RegisterFunction('Trim_DKC_Pas_11_a', @Trim_DKC_Pas_11_a);
 MainForm.RegisterFunction('Trim_DKC_Pas_11_b', @Trim_DKC_Pas_11_b);
 MainForm.RegisterFunction('Trim_DKC_Pas_11_c', @Trim_DKC_Pas_11_c);
 MainForm.RegisterFunction('Trim_DKC_Pas_11_d', @Trim_DKC_Pas_11_d);
 MainForm.RegisterFunction('Trim_DKC_IA32_1_a', @Trim_DKC_IA32_1_a);
 MainForm.RegisterFunction('Trim_DKC_IA32_1_b', @Trim_DKC_IA32_1_b);
 MainForm.RegisterFunction('Trim_DKC_IA32_1_c', @Trim_DKC_IA32_1_c);
 MainForm.RegisterFunction('Trim_DKC_IA32_1_d', @Trim_DKC_IA32_1_d);
 MainForm.RegisterFunction('Trim_DKC_IA32_2_a', @Trim_DKC_IA32_2_a);
 MainForm.RegisterFunction('Trim_DKC_IA32_2_b', @Trim_DKC_IA32_2_b);
 MainForm.RegisterFunction('Trim_DKC_IA32_2_c', @Trim_DKC_IA32_2_c);
 MainForm.RegisterFunction('Trim_DKC_IA32_2_d', @Trim_DKC_IA32_2_d);
 MainForm.RegisterFunction('Trim_DKC_IA32_3_a', @Trim_DKC_IA32_3_a);
 MainForm.RegisterFunction('Trim_DKC_IA32_3_b', @Trim_DKC_IA32_3_b);
 MainForm.RegisterFunction('Trim_DKC_IA32_3_c', @Trim_DKC_IA32_3_c);
 MainForm.RegisterFunction('Trim_DKC_IA32_3_d', @Trim_DKC_IA32_3_d);
 MainForm.RegisterFunction('Trim_DKC_IA32_4_a', @Trim_DKC_IA32_4_a);
 MainForm.RegisterFunction('Trim_DKC_IA32_4_b', @Trim_DKC_IA32_4_b);
 MainForm.RegisterFunction('Trim_DKC_IA32_4_c', @Trim_DKC_IA32_4_c);
 MainForm.RegisterFunction('Trim_DKC_IA32_4_d', @Trim_DKC_IA32_4_d);
 MainForm.RegisterFunction('Trim_DKC_IA32_5_a', @Trim_DKC_IA32_5_a);
 MainForm.RegisterFunction('Trim_DKC_IA32_5_b', @Trim_DKC_IA32_5_b);
 MainForm.RegisterFunction('Trim_DKC_IA32_5_c', @Trim_DKC_IA32_5_c);
 MainForm.RegisterFunction('Trim_DKC_IA32_5_d', @Trim_DKC_IA32_5_d);
 MainForm.RegisterFunction('Trim_DKC_IA32_6_a', @Trim_DKC_IA32_6_a);
 MainForm.RegisterFunction('Trim_DKC_IA32_6_b', @Trim_DKC_IA32_6_b);
 MainForm.RegisterFunction('Trim_DKC_IA32_6_c', @Trim_DKC_IA32_6_c);
 MainForm.RegisterFunction('Trim_DKC_IA32_6_d', @Trim_DKC_IA32_6_d);
 MainForm.RegisterFunction('Trim_DKC_IA32_7_a', @Trim_DKC_IA32_7_a);
 MainForm.RegisterFunction('Trim_DKC_IA32_7_b', @Trim_DKC_IA32_7_b);
 MainForm.RegisterFunction('Trim_DKC_IA32_7_c', @Trim_DKC_IA32_7_c);
 MainForm.RegisterFunction('Trim_DKC_IA32_7_d', @Trim_DKC_IA32_7_d);

end.


