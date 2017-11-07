unit FastcodeChallengeSortUnit;

interface

{$INCLUDE Defines.inc}

uses
  Classes, FastCodeChallengeUnit;

type
  TSortFunction = procedure(List: PPointerList; Count: Integer;
    Compare: TListSortCompare);

  TFastCodeChallengeSort = class(TFastCodeChallenge)
  protected
    function GetBenchmarks: TBenchmarkFunctionArray; override;
    function GetDummyFunction: Pointer; override;
    function GetName: string; override;
    function GetValidators: TValidatorFunctionArray; override;
    function GetVersion: string; override;
  end;

function ChallengeSort: TFastCodeChallengeSort;

implementation

uses
  SortRTLUnit, SysUtils, Windows, UtilsUnit;

const
  RERUN_COUNT = 5;
  RUN_COUNT = 1 shl 12;

  SORT_DATA_LENGTH = 1 shl 22;

  SCALE_BENCH1 = 1000;
  SCALE_BENCH2 = 1000;
  SCALE_BENCH3 = 1000;
  SCALE_BENCH4 = 1000;
  SCALE_BENCH5 = 1000;
  SCALE_BENCH6 = 1000;

type
  TFailureType = (ftElements, ftOrder);

  TListType = (ltDouble, ltInteger, ltString);

  TPrepareListOrderProc = procedure(List: PPointer; Count: Integer);

var
  Benchmarks: TBenchmarkFunctionArray;
  ChallengeObject: TFastCodeChallengeSort;
  SortData: array[0..SORT_DATA_LENGTH - 1] of Pointer;
  SortDataLengths: array[0..RUN_COUNT - 1] of Integer;
  SortDataTemp: array[0..SORT_DATA_LENGTH - 1] of Pointer;
  Validators: TValidatorFunctionArray;

function Benchmark1(Func: Pointer; Callback: TFastCodeChallengeCallback): Double; forward;
function Benchmark2(Func: Pointer; Callback: TFastCodeChallengeCallback): Double; forward;
function Benchmark3(Func: Pointer; Callback: TFastCodeChallengeCallback): Double; forward;
function Benchmark4(Func: Pointer; Callback: TFastCodeChallengeCallback): Double; forward;
function Benchmark5(Func: Pointer; Callback: TFastCodeChallengeCallback): Double; forward;
function Benchmark6(Func: Pointer; Callback: TFastCodeChallengeCallback): Double; forward;
function BenchmarkInt(Func: Pointer; ListOrderProc: TPrepareListOrderProc): Double; forward;
function CompareDouble(Item1, Item2: Pointer): Integer; forward;
function CompareInt(Item1, Item2: Pointer): Integer; forward;
function CompareRandom(Item1, Item2: Pointer): Integer; forward;
function DescribeFailure(ListIn, ListOut: PPointerList; Count: Integer; ListType: TListType; FailureType: TFailureType; const ActivityDesc: string): string; overload; forward;
function DescribeFailure(List: PPointerList; Count: Integer; ListType: TListType; E: Exception; const ActivityDesc: string): string; overload; forward;
function DescribeList(List: PPointerList; Count: Integer; ListType: TListType): string; forward;
procedure DummyFunction(List: PPointerList; Count: Integer; Compare: TListSortCompare); forward;
procedure InitLengths; forward;
function IntPower2(Base, Exp: LongWord): LongWord; forward;
function ListIsOrdered(List: PPointerList; Count: Integer; Compare: TListSortCompare): Boolean; forward;
function ListSameElements(List1, List2: PPointerList; Count: Integer): Boolean; forward;
procedure PrepareListOrder_Rand_Int(List: PPointer; Count: Integer); forward;
procedure PrepareListOrder_RandMul_Int(List: PPointer; Count: Integer); forward;
procedure PrepareListOrder_Sort_Int(List: PPointer; Count: Integer); forward;
procedure PrepareListOrder_SortPart_Int(List: PPointer; Count: Integer); forward;
procedure PrepareListOrder_SortRev_Int(List: PPointer; Count: Integer); forward;
procedure PrepareListOrder_SortTwo_Int(List: PPointer; Count: Integer); forward;
function Validator1(Func: Pointer; Callback: TFastCodeChallengeCallback): Boolean; forward;
function Validator2(Func: Pointer; Callback: TFastCodeChallengeCallback): Boolean; forward;
function Validator3(Func: Pointer; Callback: TFastCodeChallengeCallback): Boolean; forward;
function Validator4(Func: Pointer; Callback: TFastCodeChallengeCallback): Boolean; forward;

function Benchmark1(Func: Pointer; Callback: TFastCodeChallengeCallback): Double;
begin
  Result := Round(BenchmarkInt(Func, PrepareListOrder_Rand_Int) * SCALE_BENCH1);
end;

function Benchmark2(Func: Pointer; Callback: TFastCodeChallengeCallback): Double;
begin
  Result := Round(BenchmarkInt(Func, PrepareListOrder_RandMul_Int) * SCALE_BENCH2);
end;

function Benchmark3(Func: Pointer; Callback: TFastCodeChallengeCallback): Double;
begin
  Result := Round(BenchmarkInt(Func, PrepareListOrder_Sort_Int) * SCALE_BENCH3);
end;

function Benchmark4(Func: Pointer; Callback: TFastCodeChallengeCallback): Double;
begin
  Result := Round(BenchmarkInt(Func, PrepareListOrder_SortPart_Int) * SCALE_BENCH4);
end;

function Benchmark5(Func: Pointer; Callback: TFastCodeChallengeCallback): Double;
begin
  Result := Round(BenchmarkInt(Func, PrepareListOrder_SortRev_Int) * SCALE_BENCH5);
end;

function Benchmark6(Func: Pointer; Callback: TFastCodeChallengeCallback): Double;
begin
  Result := Round(BenchmarkInt(Func, PrepareListOrder_SortTwo_Int) * SCALE_BENCH6);
end;

function BenchmarkInt(Func: Pointer; ListOrderProc: TPrepareListOrderProc): Double;
var
  DurationArray: array[0..RERUN_COUNT-1] of Int64;
  I, Index, ReRunIndex: Integer;
  SortFunction: TSortFunction;
  TimeEnd, TimeFreq, TimeStart: Int64;
begin
  SortFunction := TSortFunction(Func);
  Win32Check(QueryPerformanceFrequency(TimeFreq));

  // Initialize the test data by putting random data with the right ordering
  // pattern in each sublist
  RandSeed := $12345678;
  Index := 0;
  for I := Low(SortDataLengths) to High(SortDataLengths) do
  begin
    ListOrderProc(@SortData[Index], SortDataLengths[I]);
    Index := Index + SortDataLengths[I];
  end;

  for ReRunIndex := Low(DurationArray) to High(DurationArray) do
  begin
    Move(SortData, SortDataTemp, SizeOf(SortDataTemp));

    Win32Check(QueryPerformanceCounter(TimeStart));

    Index := 0;
    for I := Low(SortDataLengths) to High(SortDataLengths) do
    begin
      SortFunction(@SortDataTemp[Index], SortDataLengths[I], CompareInt);
      Index := Index + SortDataLengths[I];
    end;

    Win32Check(QueryPerformanceCounter(TimeEnd));
    DurationArray[ReRunIndex] := TimeEnd - TimeStart;
  end;

  Result := Min(DurationArray) / TimeFreq;
end;

function CompareDouble(Item1, Item2: Pointer): Integer;
var
  Diff: Double;
begin
  Diff := PDouble(Item1)^ - PDouble(Item2)^;
  if Diff > 0 then
    Result := 1
  else
    if Diff < 0 then
      Result := -1
    else
      Result := 0;
end;

function CompareInt(Item1, Item2: Pointer): Integer;
begin
  if Integer(Item1) < Integer(Item2) then
    Result := -1
  else
    if Integer(Item1) > Integer(Item2) then
      Result := 1
    else
      Result := 0;
end;

function CompareRandom(Item1, Item2: Pointer): Integer;
begin
  Result := Random(3) - 1;
end;

function DescribeFailure(ListIn, ListOut: PPointerList; Count: Integer; ListType: TListType; FailureType: TFailureType; const ActivityDesc: string): string;
const
  FAILURE_DESC: array[TFailureType] of string = ('contains wrong elements', 'is ordered incorrectly');
begin
  Result := Format('While %s sorting %s resulted in %s which %s',
    [ActivityDesc, DescribeList(ListIn, Count, ListType),
    DescribeList(ListOut, Count, ListType), FAILURE_DESC[FailureType]]);
end;

function DescribeFailure(List: PPointerList; Count: Integer; ListType: TListType; E: Exception; const ActivityDesc: string): string;
begin
  Result := Format('While %s sorting %s raised a %s exception with message: %s',
    [ActivityDesc, DescribeList(List, Count, ListType),
    E.ClassName, QuoteString(E.Message)]);
end;

function DescribeList(List: PPointerList; Count: Integer; ListType: TListType): string;
var
  I: Integer;
  Items: TStringList;
begin
  Items := TStringList.Create;
  try
    for I := 0 to Count-1 do
      case ListType of
        ltDouble: Items.Add(FloatToStr(PDouble(List^[I])^));
        ltInteger: Items.Add(IntToStr(Integer(List^[I])));
        ltString: Items.Add(string(List^[I]));
      end;
    Result := '(' + Items.CommaText + ')';
  finally
    Items.Free;
  end;
end;

procedure DummyFunction(List: PPointerList; Count: Integer; Compare: TListSortCompare);
begin

end;

procedure InitLengths;

 procedure SplitLength(FragmentIndex, FragmentLength: Integer);
 var
   FragmentIndexRight, FragmentLengthNew, LengthTotal: Integer;
 begin
   LengthTotal := SortDataLengths[FragmentIndex];
   FragmentLengthNew := FragmentLength div 2;
   FragmentIndexRight := FragmentIndex + FragmentLengthNew;
   SortDataLengths[FragmentIndex] := Random(LengthTotal - FragmentLength) + FragmentLengthNew;
   SortDataLengths[FragmentIndexRight] := LengthTotal - SortDataLengths[FragmentIndex];

   if FragmentLengthNew > 1 then
   begin
     SplitLength(FragmentIndex, FragmentLengthNew);
     SplitLength(FragmentIndexRight, FragmentLengthNew);
   end;
 end;

begin
  RandSeed := $12345678;

  SortDataLengths[0] := SORT_DATA_LENGTH;
  SplitLength(0, Length(SortDataLengths));
end;

function IntPower2(Base, Exp: LongWord): LongWord;
begin
  Result := 1;
  while Exp > 0 do
  begin
    if Exp and 1 = 1 then
      Result := Result * Base;
    Base := Base * Base;
    Exp := Exp shr 1;
  end;
end;

function ListIsOrdered(List: PPointerList; Count: Integer; Compare: TListSortCompare): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to Count-2 do
    if Compare(List^[I], List^[I+1]) > 0 then
    begin
      Result := False;
      Break;
    end;
end;

function ListSameElements(List1, List2: PPointerList; Count: Integer): Boolean;
var
  I: Integer;
  List1Sort, List2Sort: PPointerList;
begin
  Result := True;

  GetMem(List1Sort, Count * SizeOf(Pointer));
  GetMem(List2Sort, Count * SizeOf(Pointer));
  try
    Move(List1^, List1Sort^, Count * SizeOf(Pointer));
    Move(List2^, List2Sort^, Count * SizeOf(Pointer));
    Sort_RTL(List1Sort, Count, CompareInt);
    Sort_RTL(List2Sort, Count, CompareInt);
    for I := 0 to Count-1 do
      if List1Sort^[I] <> List2Sort^[I] then
      begin
        Result := False;
        Break;
      end;
  finally
    FreeMem(List2Sort);
    FreeMem(List1Sort);
  end;
end;

// Random list
procedure PrepareListOrder_Rand_Int(List: PPointer; Count: Integer);
var
  I: Integer;
begin
  for I := 1 to Count do
  begin
    List^ := Pointer(Random32(Low(Integer), High(Integer)));
    Inc(List);
  end;
end;

// Random list with high likelyhood of items appearing multiple times
procedure PrepareListOrder_RandMul_Int(List: PPointer; Count: Integer);
const
  MUL_FACTOR = 2;
var
  I: Integer;
begin
  for I := 1 to Count do
  begin
    List^ := Pointer(Random(Count div MUL_FACTOR));
    Inc(List);
  end;
end;

// Sorted list
procedure PrepareListOrder_Sort_Int(List: PPointer; Count: Integer);
var
  I, Value: Integer;
begin
  Value := 0;
  for I := 1 to Count do
  begin
    Value := Value + Random(High(Integer) div Count);
    List^ := Pointer(Value);
    Inc(List);
  end;
end;

// Partially sorted list; first part sorted, then appended random entries
procedure PrepareListOrder_SortPart_Int(List: PPointer; Count: Integer);
const
  SORT_FACTOR = 0.75;
var
  SortCount: Integer;
begin
  SortCount := Round(Count * SORT_FACTOR);
  PrepareListOrder_Sort_Int(List, SortCount);
  Inc(List, SortCount);
  PrepareListOrder_Rand_Int(List, Count - SortCount);
end;

// Reversely sorted list
procedure PrepareListOrder_SortRev_Int(List: PPointer; Count: Integer);
var
  I, Value: Integer;
begin
  Value := 0;
  for I := 1 to Count do
  begin
    Value := Value - Random(High(Integer) div Count);
    List^ := Pointer(Value);
    Inc(List);
  end;
end;

// List sorted by criterium B to be sorted by criterium A + B
// Implemented by letting A = 16 high-order bits and B = 16 low-order bits
procedure PrepareListOrder_SortTwo_Int(List: PPointer; Count: Integer);
const
  MUL_FACTOR = 16;
var
  I, Value: Integer;
begin
  Value := 0;
  for I := 1 to Count do
  begin
    Value := Value + Random($00010000) div Count;
    List^ := Pointer(Value or (Random(Count div MUL_FACTOR) shl 16));
    Inc(List);
  end;
end;

// This validator sorts all lists of integers typecasted to pointers up to a
// certain length.
//
// If it is passed this means that:
// - The sort function can handle elements that are not valid pointers
// - All patterns of lists of length up to and including MAX_LENGTH are sorted
//   correctly with no exceptions raised
function Validator1(Func: Pointer; Callback: TFastCodeChallengeCallback): Boolean;
const
  ACTIVITY_DESC = 'sorting short lists of integers';
  MAX_LENGTH = 5;
var
  I, J, Len, Progress, ProgressMax: Integer;
  List, ListSort: array of Integer;
  SortFunction: TSortFunction;
begin
  SortFunction := TSortFunction(Func);
  Result := True;

  ProgressMax := 0;
  for Len := 0 to MAX_LENGTH do
    ProgressMax := ProgressMax + Integer(IntPower2(Len, Len));

  Progress := 0;
  for Len := 0 to MAX_LENGTH do
  begin
    SetLength(List, Len);
    FillChar(List[0], Len * SizeOf(Pointer), $00);
    SetLength(ListSort, Len);

    for I := 0 to IntPower2(Len, Len) - 1 do
    begin
      Callback.ReportProgress(Progress, ProgressMax);

      Move(List[0], ListSort[0], Len * SizeOf(Pointer));
      try
        SortFunction(@ListSort[0], Len, CompareInt);
        if not ListSameElements(@List[0], @ListSort[0], Len) then
        begin
          Callback.ReportFailure(DescribeFailure(@List[0], @ListSort[0], Len, ltInteger, ftElements, ACTIVITY_DESC));
          Result := False;
        end
        else
          if not ListIsOrdered(@ListSort[0], Len, CompareInt) then
          begin
            Callback.ReportFailure(DescribeFailure(@List[0], @ListSort[0], Len, ltInteger, ftOrder, ACTIVITY_DESC));
            Result := False;
          end;
      except
        on E: Exception do
        begin
          Callback.ReportFailure(DescribeFailure(@List[0], Len, ltInteger, E, ACTIVITY_DESC));
          Result := False;
        end;
      end;

      J := Len-1;
      while (J >= 0) and (List[J] = Len - 1) do
      begin
        List[J] := 0;
        Dec(J);
      end;
      if J >= 0 then Inc(List[J]);
      
      Inc(Progress);
    end;
  end;
end;

// This validator sorts lists of doubles pointed to from within the list.
//
// If it is passed this means that:
// - The sort function can handle elements that are valid pointers
// - Lists of length up to and including MAX_LENGTH are sorted correctly
//   with no exceptions raised
function Validator2(Func: Pointer; Callback: TFastCodeChallengeCallback): Boolean;
const
  ACTIVITY_DESC = 'sorting lists of doubles';
  MAX_LENGTH = 4096;
var
  I, J: Integer;
  List, ListSort: array[0..MAX_LENGTH-1] of Pointer;
  SortFunction: TSortFunction;
  Values: array[0..MAX_LENGTH-1] of Double;
begin
  SortFunction := TSortFunction(Func);
  Result := True;

  RandSeed := $12345678;

  for I := 0 to MAX_LENGTH-1 do
    List[I] := @Values[I];

  for I := 0 to MAX_LENGTH do
  begin
    Callback.ReportProgress(I, MAX_LENGTH + 1);

    for J := 0 to I-1 do
      Values[J] := Random;

    Move(List[0], ListSort[0], I * SizeOf(Pointer));
    try
      SortFunction(@ListSort[0], I, CompareDouble);
      if not ListSameElements(@List[0], @ListSort[0], I) then
      begin
        Callback.ReportFailure(DescribeFailure(@List[0], @ListSort[0], I, ltDouble, ftElements, ACTIVITY_DESC));
        Result := False;
      end
      else
        if not ListIsOrdered(@ListSort[0], I, CompareDouble) then
        begin
          Callback.ReportFailure(DescribeFailure(@List[0], @ListSort[0], I, ltDouble, ftOrder, ACTIVITY_DESC));
          Result := False;
        end;
    except
      on E: Exception do
      begin
        Callback.ReportFailure(DescribeFailure(@List[0], I, ltDouble, E, ACTIVITY_DESC));
        Result := False;
      end;
    end;
  end;
end;

// This validator shuffles lists of integers typecasted to pointers by using a
// randomized compare.
//
// If it is passed this means that:
// - Randomized (so possibly inconsistent) sort functions are handled correctly
//   with no exceptions raised
function Validator3(Func: Pointer; Callback: TFastCodeChallengeCallback): Boolean;
const
  ACTIVITY_DESC = 'shuffling lists of integers';
  MAX_LENGTH = 4096;
var
  I: Integer;
  List, ListSort: array[0..MAX_LENGTH-1] of Integer;
  SortFunction: TSortFunction;
begin
  SortFunction := TSortFunction(Func);
  Result := True;                                           

  RandSeed := $12345678;

  for I := 0 to MAX_LENGTH-1 do
    List[I] := I;

  for I := 0 to MAX_LENGTH do
  begin
    Callback.ReportProgress(I, MAX_LENGTH + 1);

    Move(List[0], ListSort[0], I * SizeOf(Pointer));
    try
      SortFunction(@ListSort[0], I, CompareRandom);
      if not ListSameElements(@List[0], @ListSort[0], I) then
      begin
        Callback.ReportFailure(DescribeFailure(@List[0], @ListSort[0], I, ltInteger, ftElements, ACTIVITY_DESC));
        Result := False;
      end;
    except
      on E: Exception do
      begin
        Callback.ReportFailure(DescribeFailure(@List[0], I, ltInteger, E, ACTIVITY_DESC));
        Result := False;
      end;
    end;
  end;
end;

// This validator sorts a list of integers typecasted to pointers while allowing
// minimal access rights to the pointer list and it's surroundings.
//
// If it is passed this means that:
// - No elements are accessed other than those in the page of the list
function Validator4(Func: Pointer; Callback: TFastCodeChallengeCallback): Boolean;
const
  ACTIVITY_DESC = 'shuffling a list with restricted access';
  PAGE_SIZE = 4096;
  ARRAY_LENGTH = PAGE_SIZE div SizeOf(Integer);
type
  PIntegerArray = ^TIntegerArray;
  TIntegerArray = array[0..ARRAY_LENGTH-1] of Integer;
var
  Dummy: LongWord;
  I: Integer;
  List: TIntegerArray;
  ListSort: PIntegerArray;
  ListSortData: array[0..PAGE_SIZE*5-1] of Byte;
  SortFunction: TSortFunction;
begin
  SortFunction := TSortFunction(Func);
  Result := True;

  for I := 0 to ARRAY_LENGTH-1 do
    List[I] := ARRAY_LENGTH - I;
  ListSort := Pointer((LongWord(@ListSortData) and not (PAGE_SIZE - 1)) + PAGE_SIZE * 2);
  Move(List, ListSort^, SizeOf(ListSort^));

  try
    VirtualProtect(Pointer(LongWord(ListSort) - PAGE_SIZE), PAGE_SIZE, PAGE_NOACCESS, Dummy);
    VirtualProtect(ListSort, PAGE_SIZE, PAGE_READWRITE, Dummy);
    VirtualProtect(Pointer(LongWord(ListSort) + PAGE_SIZE), PAGE_SIZE, PAGE_NOACCESS, Dummy);
    try
      SortFunction(@ListSort^[0], ARRAY_LENGTH, CompareInt);
    finally
      VirtualProtect(@ListSortData, SizeOf(ListSortData), PAGE_EXECUTE_READWRITE, Dummy);
    end;

    if not ListSameElements(@List[0], @ListSort^[0], ARRAY_LENGTH) then
    begin
      Callback.ReportFailure(DescribeFailure(@List[0], @ListSort^[0], ARRAY_LENGTH, ltInteger, ftElements, ACTIVITY_DESC));
      Result := False;
    end;
  except
    on E: Exception do
    begin
      Callback.ReportFailure(DescribeFailure(@List[0], ARRAY_LENGTH, ltInteger, E, ACTIVITY_DESC));
      Result := False;
    end;
  end;
end;

function ChallengeSort: TFastCodeChallengeSort;
begin
  if ChallengeObject = nil then
    ChallengeObject := TFastCodeChallengeSort.RegisterChallenge as TFastCodeChallengeSort;
  Result := ChallengeObject;
end;

function TFastCodeChallengeSort.GetBenchmarks: TBenchmarkFunctionArray;
begin
  if Benchmarks = nil then
  begin
    SetLength(Benchmarks, 6);
    Benchmarks[0] := Benchmark1;
    Benchmarks[1] := Benchmark2;
    Benchmarks[2] := Benchmark3;
    Benchmarks[3] := Benchmark4;
    Benchmarks[4] := Benchmark5;
    Benchmarks[5] := Benchmark6;
  end;
  Result := Benchmarks;
end;

function TFastCodeChallengeSort.GetDummyFunction: Pointer;
begin
  Result := @DummyFunction;
end;

function TFastCodeChallengeSort.GetName: string;
begin
  Result := 'Sort';
end;

function TFastCodeChallengeSort.GetValidators: TValidatorFunctionArray;
begin
  if Validators = nil then
  begin
    SetLength(Validators, 4);
    Validators[0] := Validator1;
    Validators[1] := Validator2;
    Validators[2] := Validator3;
    Validators[3] := Validator4;
  end;
  Result := Validators;
end;

function TFastCodeChallengeSort.GetVersion: string;
begin
  Result := '0.9';
end;

initialization
begin
  InitLengths;
  ChallengeSort;
end;

end.
