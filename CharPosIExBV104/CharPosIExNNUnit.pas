unit CharPosIExNNUnit;

interface

implementation

uses
 MainUnit, SysUtils;

function CharPosIEx_NN_Pas_1_a(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 UpperSearchChar : Char;
 UpperS : string;
 Index : Integer;

begin
 Result := 0;
 UpperSearchChar := UpCase(SearchChar);
 UpperS := UpperCase(S);
 Index := Offset;
 if Index > 0 then
  begin
   while Index <= Length(UpperS) do
    begin
     if UpperS[Index] = UpperSearchChar then
      begin
       //We have a match
       Result := Index;
       Break;
      end;
     Inc(Index);
    end;
  end;
end;

function CharPosIEx_NN_Pas_2_a(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 UpperSearchChar : Char;
 Index : Integer;

begin
 Result := 0;
 UpperSearchChar := UpCase(SearchChar);
 Index := Offset;
 if Index > 0 then
  begin
   while Index <= Length(S) do
    begin
     if UpCase(S[Index]) = UpperSearchChar then
      begin
       //We have a match
       Result := Index;
       Break;
      end;
     Inc(Index);
    end;
  end;
end;

function UpCase_NN_Pas_1( ch : Char ) : Char; inline;
begin
  Result := ch;
  case Result of
    'a'..'z':  Dec(Result, Ord('a') - Ord('A'));
  end;
end;

function CharPosIEx_NN_Pas_3_a(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 UpperSearchChar : Char;
 Index : Integer;

begin
 Result := 0;
 UpperSearchChar := UpCase_NN_Pas_1(SearchChar);
 Index := Offset;
 if Index > 0 then
  begin
   while Index <= Length(S) do
    begin
     if UpCase_NN_Pas_1(S[Index]) = UpperSearchChar then
      begin
       //We have a match
       Result := Index;
       Break;
      end;
     Inc(Index);
    end;
  end;
end;

function CharPosIEx_NN_Pas_4_a(SearchChar : Char; const S: string; Offset: Integer = 1) : Integer;
var
 UpperSearchChar : Char;
 Index, LengthS : Integer;

begin
 Result := 0;
 UpperSearchChar := UpCase_NN_Pas_1(SearchChar);
 LengthS := Length(S);
 Index := Offset;
 if Index > 0 then
  begin
   while Index <= LengthS do
    begin
     if UpCase_NN_Pas_1(S[Index]) = UpperSearchChar then
      begin
       //We have a match
       Result := Index;
       Break;
      end;
     Inc(Index);
    end;
  end;
end;

initialization

// MainForm.RegisterFunction('CharPosIEx_NN_Pas_1_a', @CharPosIEx_NN_Pas_1_a);
// MainForm.RegisterFunction('CharPosIEx_NN_Pas_2_a', @CharPosIEx_NN_Pas_2_a);
// MainForm.RegisterFunction('CharPosIEx_NN_Pas_3_a', @CharPosIEx_NN_Pas_3_a);
// MainForm.RegisterFunction('CharPosIEx_NN_Pas_4_a', @CharPosIEx_NN_Pas_4_a);

end.


