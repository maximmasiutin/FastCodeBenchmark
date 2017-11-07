unit SortExtendedArrayBenchmark2Unit;

interface

uses Windows, BenchmarkClassUnit, Classes, Math;

type

  TQuickSortExtendedArrayThreads = class(TFastcodeMMBenchmark)
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

  TQuickSortExtendedArrayThread = class(TThread)
    Prime: Integer;
    FBenchmark: TFastcodeMMBenchmark;
    procedure Execute; override;
  end;

  TExtended = record
   X : Extended;
   Pad1, Pad2, Pad3, Pad4, Pad5, Pad6 : Byte;
  end;

 TExtendedArray = array[0..1000000] of TExtended;
 PExtendedArray = ^TExtendedArray;

function SortCompareExtended(Item1, Item2: Pointer): Integer;
var
  Diff: Extended;
begin
  Diff := PExtended(Item1)^ - PExtended(Item2)^;
  if Diff < 0 then
    Result := -1
  else
    if Diff > 0 then
      Result := 1
    else
      Result := 0;
end;

procedure TQuickSortExtendedArrayThread.Execute;
var
  ExtArray:  PExtendedArray;
  I, J, RunNo, Size: Integer;
  CurValue: Int64;
  List: TList;
const
  MAXRUNNO = 8;
  MAXELEMENTVALUE = MAXINT;
  MINSIZE = 100;
  MAXSIZE = 10000;
  RepeatCount = 600;
begin
  CurValue := Prime;
  for J := 1 to RepeatCount do
  begin
    GetMem(ExtArray, MINSIZE * SizeOf(TExtended));
    try
      for RunNo := 1 to MAXRUNNO do
      begin
        Size := (CurValue mod (MAXSIZE-MINSIZE)) + MINSIZE;
        Inc(CurValue, Prime);
        ReallocMem(ExtArray, Size * SizeOf(TExtended));
        List := TList.Create;
        try
          List.Count := Size;
          for I := 0 to Size-1 do
          begin
            ExtArray^[I].X := (CurValue mod MAXELEMENTVALUE)*pi;
            Inc(CurValue, Prime);
            List[I] := @(ExtArray^[I].X);
          end;
          List.Sort({$IFDEF FPC}@{$ENDIF}SortCompareExtended);
        finally
          List.Free;
        end;
      end;
    finally
      FreeMem(ExtArray);
    end;
    FBenchmark.UpdateUsageStatistics;
  end;
end;

class function TQuickSortExtendedArrayThreads.GetBenchmarkDescription:
string;
begin
  Result := 'A benchmark that measures read and write speed to an array of Extendeds. '
          + 'The Extended type is padded to be 16 byte. '
          + 'Bonus is given for 16 byte alignment of array '
          + 'Will also reveil cache set associativity related issues. '
          + 'Access pattern is created by X sorting array of arbitrary values using the QuickSort algorithm implemented in TList. '
          + 'Measures memory usage after all blocks have been freed. '
          + 'Benchmark submitted by Avatar Zondertau, based on a benchmark by Dennis Kjaer Christensen.';
end;

class function TQuickSortExtendedArrayThreads.GetBenchmarkName: string;
begin
  Result := 'QuickSortExtendedArrayBenchmark';
end;

class function TQuickSortExtendedArrayThreads.GetCategory:
TBenchmarkCategory;
begin
  Result := bmMemoryAccessSpeed;
end;

class function TQuickSortExtendedArrayThreads.GetSpeedWeight: Double;
begin
  Result := 0.75;
end;

procedure TQuickSortExtendedArrayThreads.RunBenchmark;
var
  SortExtendedArrayThread1,
  SortExtendedArrayThread2,
  SortExtendedArrayThread3,
  SortExtendedArrayThread4,
  SortExtendedArrayThread5,
  SortExtendedArrayThread6,
  SortExtendedArrayThread7,
  SortExtendedArrayThread8: TQuickSortExtendedArrayThread;
begin
  inherited;
  SortExtendedArrayThread1 := TQuickSortExtendedArrayThread.Create(True);
  SortExtendedArrayThread2 := TQuickSortExtendedArrayThread.Create(True);
  SortExtendedArrayThread3 := TQuickSortExtendedArrayThread.Create(True);
  SortExtendedArrayThread4 := TQuickSortExtendedArrayThread.Create(True);
  SortExtendedArrayThread5 := TQuickSortExtendedArrayThread.Create(True);
  SortExtendedArrayThread6 := TQuickSortExtendedArrayThread.Create(True);
  SortExtendedArrayThread7 := TQuickSortExtendedArrayThread.Create(True);
  SortExtendedArrayThread8 := TQuickSortExtendedArrayThread.Create(True);

  SortExtendedArrayThread1.Prime := 9721;
  SortExtendedArrayThread2.Prime := 9733;
  SortExtendedArrayThread3.Prime := 9739;
  SortExtendedArrayThread4.Prime := 9743;
  SortExtendedArrayThread5.Prime := 9749;
  SortExtendedArrayThread6.Prime := 9767;
  SortExtendedArrayThread7.Prime := 9769;
  SortExtendedArrayThread8.Prime := 9781;

  SortExtendedArrayThread1.FreeOnTerminate := False;
  SortExtendedArrayThread2.FreeOnTerminate := False;
  SortExtendedArrayThread3.FreeOnTerminate := False;
  SortExtendedArrayThread4.FreeOnTerminate := False;
  SortExtendedArrayThread5.FreeOnTerminate := False;
  SortExtendedArrayThread6.FreeOnTerminate := False;
  SortExtendedArrayThread7.FreeOnTerminate := False;
  SortExtendedArrayThread8.FreeOnTerminate := False;

  SortExtendedArrayThread1.Priority := tpIdle;
  SortExtendedArrayThread2.Priority := tpLowest;
  SortExtendedArrayThread3.Priority := tpLower;
  SortExtendedArrayThread4.Priority := tpNormal;
  SortExtendedArrayThread5.Priority := tpHigher;
  SortExtendedArrayThread6.Priority := tpHighest;
  SortExtendedArrayThread7.Priority := tpTimeCritical;
  SortExtendedArrayThread8.Priority := tpTimeCritical;

  SortExtendedArrayThread1.FBenchmark := Self;
  SortExtendedArrayThread2.FBenchmark := Self;
  SortExtendedArrayThread3.FBenchmark := Self;
  SortExtendedArrayThread4.FBenchmark := Self;
  SortExtendedArrayThread5.FBenchmark := Self;
  SortExtendedArrayThread6.FBenchmark := Self;
  SortExtendedArrayThread7.FBenchmark := Self;
  SortExtendedArrayThread8.FBenchmark := Self;

  SortExtendedArrayThread1.Start;
  SortExtendedArrayThread2.Start;
  SortExtendedArrayThread3.Start;
  SortExtendedArrayThread4.Start;
  SortExtendedArrayThread5.Start;
  SortExtendedArrayThread6.Start;
  SortExtendedArrayThread7.Start;
  SortExtendedArrayThread8.Start;

  SortExtendedArrayThread8.WaitFor;
  SortExtendedArrayThread1.Priority := tpTimeCritical;

  SortExtendedArrayThread7.WaitFor;
  SortExtendedArrayThread2.Priority := tpTimeCritical;

  SortExtendedArrayThread6.WaitFor;
  SortExtendedArrayThread3.Priority := tpTimeCritical;

  SortExtendedArrayThread5.WaitFor;
  SortExtendedArrayThread4.Priority := tpTimeCritical;

  SortExtendedArrayThread4.WaitFor;
  SortExtendedArrayThread3.WaitFor;
  SortExtendedArrayThread2.WaitFor;
  SortExtendedArrayThread1.WaitFor;

  SortExtendedArrayThread1.Free;
  SortExtendedArrayThread2.Free;
  SortExtendedArrayThread3.Free;
  SortExtendedArrayThread4.Free;
  SortExtendedArrayThread5.Free;
  SortExtendedArrayThread6.Free;
  SortExtendedArrayThread7.Free;
  SortExtendedArrayThread8.Free;

  SortExtendedArrayThread1 := nil;
  SortExtendedArrayThread2 := nil;
  SortExtendedArrayThread3 := nil;
  SortExtendedArrayThread4 := nil;
  SortExtendedArrayThread5 := nil;
  SortExtendedArrayThread6 := nil;
  SortExtendedArrayThread7 := nil;
  SortExtendedArrayThread8 := nil;
end;

end.
