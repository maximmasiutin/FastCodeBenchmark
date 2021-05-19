unit SortIntArrayBenchmark2Unit;

interface

uses Windows, BenchmarkClassUnit, Classes, Math;

type

  TQuickSortIntArrayThreads = class(TFastcodeMMBenchmark)
  public
    procedure RunBenchmark; override;
    class function GetBenchmarkName: string; override;
    class function GetBenchmarkDescription: string; override;
    class function GetSpeedWeight: Double; override;
    class function GetCategory: TBenchmarkCategory; override;
  end;

implementation

uses SysUtils;

type

  TSortIntArrayThread = class(TThread)
    FPrime: Integer;
    FBenchmark: TFastcodeMMBenchmark;
    procedure Execute; override;
  end;

function SortCompareInt(Item1, Item2: Pointer): Integer;
begin
  Result := NativeInt(Item1) - NativeInt(Item2);
end;

procedure TSortIntArrayThread.Execute;
var
  I, J, IntVal, Size: Integer;
  List: TList;
  FCurValue: Int64;
const
  MINSIZE = 500;
  MAXSIZE = 1500;
  RepeatCount = 103 {prime};
  CMaxValue = 101 {prime};
begin
  FCurValue := FPrime;
  for J := 1 to RepeatCount do
  begin
    for Size := MINSIZE to MAXSIZE do
    begin
      List := TList.Create;
      try
        List.Count := Size;
        for I := 0 to Size-1 do
        begin
          IntVal := FCurValue mod CMaxValue;
          Inc(FCurValue, FPrime);
          List[I] := Pointer(IntVal);
        end;
        List.Sort({$IFDEF FPC}@{$ENDIF}SortCompareInt);
      finally
        List.Free;
      end;
    end;
    FBenchmark.UpdateUsageStatistics;
  end;
end;

class function TQuickSortIntArrayThreads.GetBenchmarkDescription:
string;
begin
  Result := 'A benchmark that measures read and write speed to an array of Integer. '
          + 'Access pattern is created by  selection sorting array of arbitrary values using the QuickSort algorithm implemented in TList.. '
          + 'Measures memory usage after all blocks have been freed. '
          + 'Benchmark submitted by Avatar Zondertau, based on a benchmark by Dennis Kjaer Christensen.';
end;

class function TQuickSortIntArrayThreads.GetBenchmarkName: string;
begin
  Result := 'QuickSortIntegerArrayBenchmark';
end;

class function TQuickSortIntArrayThreads.GetCategory:
TBenchmarkCategory;
begin
  Result := bmMemoryAccessSpeed;
end;

class function TQuickSortIntArrayThreads.GetSpeedWeight: Double;
begin
  Result := 0.75;
end;

procedure TQuickSortIntArrayThreads.RunBenchmark;
var
  SortIntArrayThread : TSortIntArrayThread;

begin
  inherited;
  SortIntArrayThread := TSortIntArrayThread.Create(True);
  SortIntArrayThread.FreeOnTerminate := False;
  SortIntArrayThread.FBenchmark := Self;
  SortIntArrayThread.FPrime := 463;
  SortIntArrayThread.Suspended := False;
  SortIntArrayThread.WaitFor;
  SortIntArrayThread.Free;
end;

end.
