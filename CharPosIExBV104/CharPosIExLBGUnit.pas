unit CharPosIExLBGUnit;

interface

implementation

uses
 MainUnit;

(*
  Author:            Lars Bloch Gravengaard
  Date:              18/11 2006
  Instructionset(s): PAS
  Function size      225 bytes
*)

function CharPosIEx_LBG_Pas_11_a(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 UpperSearchChar,LowerSearchChar : Char;
 Index,StrLength : Integer;
begin
 Result := 0;
 StrLength := Length(S);
 Index := Offset;
 if Index < 1 then Exit;
 LowerSearchChar  := SearchChar;
 UpperSearchChar:= SearchChar;
 if (SearchChar >= 'a') and (SearchChar <= 'z') then
  begin
   LowerSearchChar  := SearchChar;
   UpperSearchChar := char(Ord(SearchChar) - 32)
  end
  else
   if (SearchChar >= 'A') and (SearchChar <= 'Z') then
    begin
     UpperSearchChar:= SearchChar;
     LowerSearchChar := char(Ord(SearchChar) + 32);
  end;
  while Index <= StrLength-4 do
   begin
    if ((S[Index] = LowerSearchChar) or (S[Index] = UpperSearchChar)) then
     begin Result := Index; exit; end
    else if ((S[Index+1] = LowerSearchChar) or (S[Index+1] = UpperSearchChar)) then
     begin Result := Index+1; exit; end
    else if ((S[Index+2] = LowerSearchChar) or (S[Index+2] = UpperSearchChar)) then
     begin Result := Index+2; exit; end
    else if ((S[Index+3] = LowerSearchChar) or (S[Index+3] = UpperSearchChar))
     then begin Result := Index+3; exit; end;
    Inc(Index,4);
   end;

  while Index <= StrLength do
   begin
    if ((S[Index] = LowerSearchChar) or (S[Index] = UpperSearchChar)) then
     begin Result := Index; exit; end;
    Inc(Index);
   end;
end;

function CharPosIEx_LBG_Pas_11_b(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 UpperSearchChar,LowerSearchChar : Char;
 Index,StrLength : Integer;
begin
 Result := 0;
 StrLength := Length(S);
 Index := Offset;
 if Index < 1 then Exit;
 LowerSearchChar  := SearchChar;
 UpperSearchChar:= SearchChar;
 if (SearchChar >= 'a') and (SearchChar <= 'z') then
  begin
   LowerSearchChar  := SearchChar;
   UpperSearchChar := char(Ord(SearchChar) - 32)
  end
  else
   if (SearchChar >= 'A') and (SearchChar <= 'Z') then
    begin
     UpperSearchChar:= SearchChar;
     LowerSearchChar := char(Ord(SearchChar) + 32);
  end;
  while Index <= StrLength-4 do
   begin
    if ((S[Index] = LowerSearchChar) or (S[Index] = UpperSearchChar)) then
     begin Result := Index; exit; end
    else if ((S[Index+1] = LowerSearchChar) or (S[Index+1] = UpperSearchChar)) then
     begin Result := Index+1; exit; end
    else if ((S[Index+2] = LowerSearchChar) or (S[Index+2] = UpperSearchChar)) then
     begin Result := Index+2; exit; end
    else if ((S[Index+3] = LowerSearchChar) or (S[Index+3] = UpperSearchChar))
     then begin Result := Index+3; exit; end;
    Inc(Index,4);
   end;

  while Index <= StrLength do
   begin
    if ((S[Index] = LowerSearchChar) or (S[Index] = UpperSearchChar)) then
     begin Result := Index; exit; end;
    Inc(Index);
   end;
end;

function CharPosIEx_LBG_Pas_11_c(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 UpperSearchChar,LowerSearchChar : Char;
 Index,StrLength : Integer;
begin
 Result := 0;
 StrLength := Length(S);
 Index := Offset;
 if Index < 1 then Exit;
 LowerSearchChar  := SearchChar;
 UpperSearchChar:= SearchChar;
 if (SearchChar >= 'a') and (SearchChar <= 'z') then
  begin
   LowerSearchChar  := SearchChar;
   UpperSearchChar := char(Ord(SearchChar) - 32)
  end
  else
   if (SearchChar >= 'A') and (SearchChar <= 'Z') then
    begin
     UpperSearchChar:= SearchChar;
     LowerSearchChar := char(Ord(SearchChar) + 32);
  end;
  while Index <= StrLength-4 do
   begin
    if ((S[Index] = LowerSearchChar) or (S[Index] = UpperSearchChar)) then
     begin Result := Index; exit; end
    else if ((S[Index+1] = LowerSearchChar) or (S[Index+1] = UpperSearchChar)) then
     begin Result := Index+1; exit; end
    else if ((S[Index+2] = LowerSearchChar) or (S[Index+2] = UpperSearchChar)) then
     begin Result := Index+2; exit; end
    else if ((S[Index+3] = LowerSearchChar) or (S[Index+3] = UpperSearchChar))
     then begin Result := Index+3; exit; end;
    Inc(Index,4);
   end;

  while Index <= StrLength do
   begin
    if ((S[Index] = LowerSearchChar) or (S[Index] = UpperSearchChar)) then
     begin Result := Index; exit; end;
    Inc(Index);
   end;
end;

function CharPosIEx_LBG_Pas_11_d(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 UpperSearchChar,LowerSearchChar : Char;
 Index,StrLength : Integer;
begin
 Result := 0;
 StrLength := Length(S);
 Index := Offset;
 if Index < 1 then Exit;
 LowerSearchChar  := SearchChar;
 UpperSearchChar:= SearchChar;
 if (SearchChar >= 'a') and (SearchChar <= 'z') then
  begin
   LowerSearchChar  := SearchChar;
   UpperSearchChar := char(Ord(SearchChar) - 32)
  end
  else
   if (SearchChar >= 'A') and (SearchChar <= 'Z') then
    begin
     UpperSearchChar:= SearchChar;
     LowerSearchChar := char(Ord(SearchChar) + 32);
  end;
  while Index <= StrLength-4 do
   begin
    if ((S[Index] = LowerSearchChar) or (S[Index] = UpperSearchChar)) then
     begin Result := Index; exit; end
    else if ((S[Index+1] = LowerSearchChar) or (S[Index+1] = UpperSearchChar)) then
     begin Result := Index+1; exit; end
    else if ((S[Index+2] = LowerSearchChar) or (S[Index+2] = UpperSearchChar)) then
     begin Result := Index+2; exit; end
    else if ((S[Index+3] = LowerSearchChar) or (S[Index+3] = UpperSearchChar))
     then begin Result := Index+3; exit; end;
    Inc(Index,4);
   end;

  while Index <= StrLength do
   begin
    if ((S[Index] = LowerSearchChar) or (S[Index] = UpperSearchChar)) then
     begin Result := Index; exit; end;
    Inc(Index);
   end;
end;

 (*
  Author:            Lars Bloch Gravengaard
  Date:              18/11 2006
  Instructionset(s): PAS
  Function size      99 bytes
*)

function CharPosIEx_LBG_Pas_12_a(SearchChar : Char; const S: string; Offset:
Integer = 1) : Integer;
var
 UpperSearchChar,LowerSearchChar : Char;
 Index,StrLength : Integer;
begin
 Result := 0;
 StrLength := Length(S);
 Index := Offset;
 if Index < 1 then Exit;
 LowerSearchChar  := SearchChar;
 UpperSearchChar:= SearchChar;
 if (SearchChar >= 'a') and (SearchChar <= 'z') then
  begin
   LowerSearchChar  := SearchChar;
   UpperSearchChar := char(Ord(SearchChar) - 32)
  end
  else
   if (SearchChar >= 'A') and (SearchChar <= 'Z') then
    begin
     UpperSearchChar:= SearchChar;
     LowerSearchChar := char(Ord(SearchChar) + 32);
  end;
  while Index <= StrLength do
   begin
    if ((S[Index] = LowerSearchChar) or (S[Index] = UpperSearchChar)) then
     begin Result := Index; exit; end;
    Inc(Index);
   end;
end;

function CharPosIEx_LBG_Pas_12_b(SearchChar : Char; const S: string; Offset:
Integer = 1) : Integer;
var
 UpperSearchChar,LowerSearchChar : Char;
 Index,StrLength : Integer;
begin
 Result := 0;
 StrLength := Length(S);
 Index := Offset;
 if Index < 1 then Exit;
 LowerSearchChar  := SearchChar;
 UpperSearchChar:= SearchChar;
 if (SearchChar >= 'a') and (SearchChar <= 'z') then
  begin
   LowerSearchChar  := SearchChar;
   UpperSearchChar := char(Ord(SearchChar) - 32)
  end
  else
   if (SearchChar >= 'A') and (SearchChar <= 'Z') then
    begin
     UpperSearchChar:= SearchChar;
     LowerSearchChar := char(Ord(SearchChar) + 32);
  end;
  while Index <= StrLength do
   begin
    if ((S[Index] = LowerSearchChar) or (S[Index] = UpperSearchChar)) then
     begin Result := Index; exit; end;
    Inc(Index);
   end;
end;

function CharPosIEx_LBG_Pas_12_c(SearchChar : Char; const S: string; Offset:
Integer = 1) : Integer;
var
 UpperSearchChar,LowerSearchChar : Char;
 Index,StrLength : Integer;
begin
 Result := 0;
 StrLength := Length(S);
 Index := Offset;
 if Index < 1 then Exit;
 LowerSearchChar  := SearchChar;
 UpperSearchChar:= SearchChar;
 if (SearchChar >= 'a') and (SearchChar <= 'z') then
  begin
   LowerSearchChar  := SearchChar;
   UpperSearchChar := char(Ord(SearchChar) - 32)
  end
  else
   if (SearchChar >= 'A') and (SearchChar <= 'Z') then
    begin
     UpperSearchChar:= SearchChar;
     LowerSearchChar := char(Ord(SearchChar) + 32);
  end;
  while Index <= StrLength do
   begin
    if ((S[Index] = LowerSearchChar) or (S[Index] = UpperSearchChar)) then
     begin Result := Index; exit; end;
    Inc(Index);
   end;
end;

function CharPosIEx_LBG_Pas_12_d(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 UpperSearchChar,LowerSearchChar : Char;
 Index,StrLength : Integer;
begin
 Result := 0;
 StrLength := Length(S);
 Index := Offset;
 if Index < 1 then Exit;
 LowerSearchChar  := SearchChar;
 UpperSearchChar:= SearchChar;
 if (SearchChar >= 'a') and (SearchChar <= 'z') then
  begin
   LowerSearchChar  := SearchChar;
   UpperSearchChar := char(Ord(SearchChar) - 32)
  end
  else
   if (SearchChar >= 'A') and (SearchChar <= 'Z') then
    begin
     UpperSearchChar:= SearchChar;
     LowerSearchChar := char(Ord(SearchChar) + 32);
  end;
  while Index <= StrLength do
   begin
    if ((S[Index] = LowerSearchChar) or (S[Index] = UpperSearchChar)) then
     begin Result := Index; exit; end;
    Inc(Index);
   end;
end;

initialization

 MainForm.RegisterFunction('CharPosIEx_LBG_Pas_11_a', @CharPosIEx_LBG_Pas_11_a);
 MainForm.RegisterFunction('CharPosIEx_LBG_Pas_11_b', @CharPosIEx_LBG_Pas_11_b);
 MainForm.RegisterFunction('CharPosIEx_LBG_Pas_11_c', @CharPosIEx_LBG_Pas_11_c);
 MainForm.RegisterFunction('CharPosIEx_LBG_Pas_11_d', @CharPosIEx_LBG_Pas_11_d);
 MainForm.RegisterFunction('CharPosIEx_LBG_Pas_12_a', @CharPosIEx_LBG_Pas_12_a);
 MainForm.RegisterFunction('CharPosIEx_LBG_Pas_12_b', @CharPosIEx_LBG_Pas_12_b);
 MainForm.RegisterFunction('CharPosIEx_LBG_Pas_12_c', @CharPosIEx_LBG_Pas_12_c);
 MainForm.RegisterFunction('CharPosIEx_LBG_Pas_12_d', @CharPosIEx_LBG_Pas_12_d);

end.


