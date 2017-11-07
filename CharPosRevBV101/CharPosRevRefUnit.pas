unit CharPosRevRefUnit;

interface

function CharPosRevRef(SearchChar : Char; const S: string) : Integer;

implementation

//Author:            Dennis Kjaer Christensen
//Date:              21/11 2006
//Instructionset(s): IA32

function CharPosRevRef(SearchChar : Char; const S: string) : Integer;
var
 CharNo : Integer;

begin
 Result := 0;
 for CharNo := Length(S) downto 1 do
  begin
   if S[CharNo] = SearchChar then
    begin
     Result := CharNo;
     Break;
    end;
  end;
end;

end.
