unit SortShaUnit;

interface

{$INCLUDE Defines.inc}

uses
  Classes, FastCodeChallengeUnit, FastcodeChallengeSortUnit;

implementation

{$UNDEF SaveQ} {$IFOPT Q+} {$Q-} {$DEFINE SaveQ} {$ENDIF}
{$UNDEF SaveR} {$IFOPT R+} {$R-} {$DEFINE SaveR} {$ENDIF}

const
  InsertionLast=15; //InsertionLast>=0

//ShaQuickSort is optimized version of QuickSort.
//It makes partition of SortList[0..J], each part has <= (InsertionLast+1)
//elements. Number of recursive calls limited by log2((J+1)/(InsertionLast+1)).
procedure ShaQuickSort(SortList: PPointerList; J: Integer;
  Compare: TListSortCompare);
var
  I, Last: Integer;
  P, T: Pointer;
begin;
  repeat;
    I:=0;
    Last:=J;
    P:=SortList^[J shr 1];
    while true do begin;
      while Compare(SortList^[I],P)<0 do Inc(I);
      while Compare(SortList^[J],P)>0 do Dec(J);
      if I>J then break;
      T:=SortList^[I];
      SortList^[I]:=SortList^[J];
      SortList^[J]:=T;
      Inc(I);
      Dec(J);
      if I>J then break;
      end;
    if I+J>Last
    then begin;
      if J>InsertionLast then ShaQuickSort(SortList,J,Compare);
      J:=Last-I;
      SortList:=@SortList[I];
      end
    else
      if Last-I>InsertionLast then ShaQuickSort(@SortList[I],Last-I,Compare);
    until J<=InsertionLast;
  end;

//ShaInsertionSort finds minimal element in the first part of SortList:
//  min(SortList^[0..min(Last,InsertionLast)])
//and then sorts SortList[0..Last] using this value.
procedure ShaInsertionSort(SortList: PPointerList; Last: Integer;
  Compare: TListSortCompare);
var
  I, J: integer;
  T: pointer;
begin
  I:=0;
  J:=Last; if J>InsertionLast then J:=InsertionLast;
  repeat;
    if (Compare(SortList^[J], SortList^[I])<0) then I:=J;
    dec(J);
    until J<=0;
  if I>0 then begin;
    T:=SortList^[0];
    SortList^[0]:=SortList^[I];
    SortList^[I]:=T;
    end;
  J:=1;
  while J<Last do begin;
    inc(J); inc(pPointer(SortList));
    if Compare(SortList^[1],SortList^[0])<0 then begin;
      T:=SortList^[1];
      I:=0;
      repeat;
        SortList^[I+1]:=SortList^[I]; dec(I);
        until not (Compare(T,SortList^[I])<0);
      SortList^[I+1]:=T;
      end;
    end;
  end;

//Optimized QuickSort + InsertionSort
procedure Sort_Sha_Pas_1(List: PPointerList; Count: Integer;
  Compare: TListSortCompare);
begin;
  if (Count>1) and (List<>nil) then begin;
    dec(Count);
    if Count>InsertionLast then ShaQuickSort(@List[0], Count, Compare);
    if InsertionLast>0 then ShaInsertionSort(@List[0], Count, Compare);
    end;
  end;

//Standard Binary HeapSort implementation
procedure Sort_Sha_Pas_2(SortList: PPointerList; Count: Integer;
  Compare: TListSortCompare);
var
  I, J, W, Last: integer;
  T: pointer;
begin;
  Last:=Count;
  I:=Last shr 1;
  dec(Last);
  while true do begin;
    W:=I;
    if W>0 then begin;
      dec(W);
      T:=SortList[W];
      I:=W;
      end
    else begin;
      if Last<=0 then exit;
      T:=SortList[Last];
      SortList[Last]:=SortList[0];
      dec(Last);
      end;
    J:=W;
    W:=W+W+1;
    while W<=Last do begin;
      if (W<Last) and (Compare(SortList^[W],SortList^[W+1])<0) then inc(W);
      if Compare(SortList^[W],T)<=0 then break;
      SortList[J]:=SortList[W];
      J:=W;
      W:=W+W+1;
      end;
    SortList[J]:=T;
    end;
  end;

{$IFDEF SaveQ} {$Q+} {$UNDEF SaveQ} {$ENDIF}
{$IFDEF SaveR} {$R+} {$UNDEF SaveR} {$ENDIF}

initialization
begin
  ChallengeSort.RegisterFunction(FunctionData('Sort_Sha_Pas_1', 'QuickSort + InsertionSort', @Sort_Sha_Pas_1, fccPas, fcaSha));
  ChallengeSort.RegisterFunction(FunctionData('Sort_Sha_Pas_2', 'Binary HeapSort', @Sort_Sha_Pas_2, fccPas, fcaSha));
end;

end.

