unit CharPosRevTestUnit;

interface

procedure CalculateStats;

implementation

uses
 MainUnit, Math;

var
 Count, Match, NonMatch : Cardinal;
 StrLengthMax : Integer;
 DistributionArray : array of Cardinal;

function CharPosRev_Test_Pas_1_a(SearchChar : Char; const S: string) : Integer;
var
 CharNo : Integer;

begin
 StrLengthMax := Max(StrLengthMax, Length(S));
 SetLength(DistributionArray, StrLengthMax+1);
 Inc(DistributionArray[Length(S)]);
 Inc(Count);
 Result := 0;
 for CharNo := Length(S) downto 1 do
  begin
   if S[CharNo] = SearchChar then
    begin
     Result := CharNo;
     Inc(Match);
     Break;
    end;
  end;
 if Result = 0 then
  Inc(NonMatch);
end;

procedure CalculateStats;
var
 //MatchRatio : Double;
 I : Integer;

begin
 //MatchRatio := Match/NonMatch;
 for I := 0 to Length(DistributionArray) - 1 do
  DistributionArray[I] := DistributionArray[I] div 100000;
end;

initialization

 Count := 0;
 Match := 0;
 NonMatch := 0;
 StrLengthMax := 0;

 //MainForm.RegisterFunction('CharPosRev_Test_Pas_1_a', @CharPosRev_Test_Pas_1_a);

end.
