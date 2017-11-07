unit SortRTLUnit;

interface

{$INCLUDE Defines.inc}

uses
  Classes, FastCodeChallengeUnit, FastcodeChallengeSortUnit;

procedure Sort_RTL(List: PPointerList; Count: Integer; Compare: TListSortCompare);

implementation

procedure QuickSort(SortList: PPointerList; L, R: Integer;
  SCompare: TListSortCompare);
var
  I, J: Integer;
  P, T: Pointer;
begin
  repeat
    I := L;
    J := R;
    P := SortList^[(L + R) shr 1];
    repeat
      while SCompare(SortList^[I], P) < 0 do
        Inc(I);
      while SCompare(SortList^[J], P) > 0 do
        Dec(J);
      if I <= J then
      begin
        T := SortList^[I];
        SortList^[I] := SortList^[J];
        SortList^[J] := T;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort(SortList, L, J, SCompare);
    L := I;
  until I >= R;
end;

procedure Sort_RTL(List: PPointerList; Count: Integer; Compare: TListSortCompare);
begin
  if (List <> nil) and (Count > 0) then
    QuickSort(List, 0, Count - 1, Compare);
end;

initialization
begin
  ChallengeSort.RegisterFunction(FunctionData('Sort (RTL)', '', @Sort_RTL, fccPas, fcaRTL));
end;

end.
 