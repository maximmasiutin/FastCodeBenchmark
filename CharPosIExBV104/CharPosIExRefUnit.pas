unit CharPosIExRefUnit;

interface

function CharPosIEx_Ref(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;

implementation

uses
 SysUtils;
 
//Author:            Dennis Kjaer Christensen
//Date:              10/12 2005
//Instructionset(s): IA32

function UpperCaseChar(C : Char) : Char;
begin
 if ('a' <= C) and (C <= 'z') then
  Result := Char(Ord(C) - 32)
 else
  Result := C;
end;

function CharPosIEx_Ref(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 I1, StrLength : Integer;
 SUpper : String;
 SearchCharUpper : Char;

begin
 Result := 0;
 if (Offset <= 0) then
  Exit;
 if ((S = '') and (Offset = 1)) then
  Exit;
 if S <> '' then
  StrLength := PInteger(Integer(S)-4)^
 else
  Exit;
 if ((StrLength > 0) and (Integer(Offset) <= StrLength))then
  begin
   SearchCharUpper := UpperCaseChar(SearchChar);
   SUpper := UpperCase(S);
   I1 := Offset;
   repeat
    if SearchCharUpper = SUpper[I1] then
     begin
      Result := I1;
      Exit;
     end;
    Inc(I1);
   until (I1 > StrLength);
  end
 else
  Result := 0;
end;

end.
