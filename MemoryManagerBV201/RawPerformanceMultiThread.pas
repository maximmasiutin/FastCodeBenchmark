// A benchmark to measure raw performance and fragmentation resistance.
// Alternates large number of small string and small number of large string allocations.
// Pure GetMem / FreeMem benchmark without reallocations, similar to WildThreads Benchmark.
// 8-thread version that has approx. same memory footprint and CPU load as single-thread version.

unit RawPerformanceMultiThread;

interface

uses
  Windows, BenchmarkClassUnit, Classes, Math;

type
  TRawPerformanceMultiThreadAbstract = class(TFastcodeMMBenchmark)
  private
  public
    procedure RunBenchmark; override;
    class function GetBenchmarkName: string; override;
    class function GetBenchmarkDescription: string; override;
    class function GetCategory: TBenchmarkCategory; override;
    class function IsThreadedSpecial: Boolean; override;
    class function NumThreads: Integer; virtual; abstract;
 end;

  TRawPerformanceMultiThread2 = class(TRawPerformanceMultiThreadAbstract)
    class function NumThreads: Integer; override;
  end;

  TRawPerformanceMultiThread4 = class(TRawPerformanceMultiThreadAbstract)
    class function NumThreads: Integer; override;
  end;

  TRawPerformanceMultiThread8 = class(TRawPerformanceMultiThreadAbstract)
    class function NumThreads: Integer; override;
  end;

  TRawPerformanceMultiThread12 = class(TRawPerformanceMultiThreadAbstract)
    class function NumThreads: Integer; override;
  end;

  TRawPerformanceMultiThread16 = class(TRawPerformanceMultiThreadAbstract)
    class function NumThreads: Integer; override;
  end;

  TRawPerformanceMultiThread31 = class(TRawPerformanceMultiThreadAbstract)
    class function NumThreads: Integer; override;
  end;

  TRawPerformanceMultiThread64 = class(TRawPerformanceMultiThreadAbstract)
    class function NumThreads: Integer; override;
  end;




implementation

uses
  SysUtils;

type
  TRawPerformanceThread = class(TThread)
  public
    ThreadCount: Integer;
    FBenchmark: TFastcodeMMBenchmark;
    procedure Execute; override;
  end;

procedure TRawPerformanceThread.Execute;
const
  POINTERS = 2039;  // take prime just below 2048  (scaled down 8x from single-thread)
  MAXCHUNK = 1024;  // take power of 2
  REPEATCOUNT = 140;
var
  ToJ, i, j, n, Size, LIndex: Cardinal;
  s: array [0..POINTERS - 1] of string;
begin
  ToJ := (REPEATCOUNT div ThreadCount)+1;
  for j := 1 to ToJ do
  begin
    n := Low(s);
    for i := 1 to 1 * 1024 * 1024 do begin
      if i and $FF < $F0 then         // 240 times out of 256 ==> chunk < 1 kB
        Size := (4 * i) and (MAXCHUNK-1) + 1
      else if i and $FF <> $FF then   //  15 times out of 256 ==> chunk < 32 kB
        Size := 16 * n + 1
      else                            //   1 time  out of 256 ==> chunk < 256 kB
        Size := 128 * n + 1;
      s[n] := '';
      SetLength(s[n], Size);
      //start and end of string are already assigned, access every 4K page in the middle
      LIndex := 1;
      while LIndex <= Size do
      begin
        s[n][LIndex] := #1;
        Inc(LIndex, 4096);
      end;
      Inc(n);
      if n > High(s) then
        n := Low(s);
      if i and $FFFF = 0 then
        FBenchmark.UpdateUsageStatistics;
    end;
    FBenchmark.UpdateUsageStatistics;
    for n := Low(s) to High(s) do
      s[n] := '';
  end;
end;

{ TRawPerformanceMultiThreadAbstract }

class function TRawPerformanceMultiThreadAbstract.GetBenchmarkDescription: string;
begin
  Result := 'A benchmark to measure raw performance and fragmentation resistance. ' +
    'Allocates large number of small strings (< 1 kB) and small number of larger ' +
    '(< 32 kB) to very large (< 256 kB) strings. '+IntToStr(NumThreads)+'-thread version.';
end;

class function TRawPerformanceMultiThreadAbstract.GetBenchmarkName: string;
begin
  Result := 'Raw Performance '+IntToStr(NumThreads)+' threads';
end;

class function TRawPerformanceMultiThreadAbstract.GetCategory: TBenchmarkCategory;
begin
  Result := bmMultiThreadAllocAndFree;
end;

class function TRawPerformanceMultiThreadAbstract.IsThreadedSpecial: Boolean;
begin
  Result := True;
end;

procedure TRawPerformanceMultiThreadAbstract.RunBenchmark;
var
  THREADCOUNT: Integer;
  Threads: array of TRawPerformanceThread;
  i: integer;
begin
  inherited;
  THREADCOUNT := NumThreads;
  SetLength(Threads, THREADCOUNT);
  for i := 0 to THREADCOUNT - 1 do
  begin
    Threads[i] := TRawPerformanceThread.Create(True);
    Threads[i].FreeOnTerminate := False;
    Threads[i].FBenchmark := Self;
    Threads[i].ThreadCount := THREADCOUNT;
    Threads[i].Priority := tpLower;
  end;
  for i := 0 to THREADCOUNT - 1 do
  begin
    Threads[i].Start;
  end;
  for i := 0 to THREADCOUNT - 1 do
  begin
    Threads[i].WaitFor;
  end;
  for i := 0 to THREADCOUNT - 1 do
  begin
    Threads[i].Free;
    Threads[i] := nil;
  end;
  SetLength(Threads, 0);
  Finalize(Threads);
end;

{ TRawPerformanceMultiThread8 }

class function TRawPerformanceMultiThread8.NumThreads: Integer;
begin
  Result := 8;
end;

{ TRawPerformanceMultiThread64 }

class function TRawPerformanceMultiThread64.NumThreads: Integer;
begin
  Result := 64;
end;

{ TRawPerformanceMultiThread2 }

class function TRawPerformanceMultiThread2.NumThreads: Integer;
begin
  Result := 2;
end;

{ TRawPerformanceMultiThread4 }

class function TRawPerformanceMultiThread4.NumThreads: Integer;
begin
  Result := 4;
end;

{ TRawPerformanceMultiThread12 }

class function TRawPerformanceMultiThread12.NumThreads: Integer;
begin
  Result := 12;
end;

{ TRawPerformanceMultiThread16 }

class function TRawPerformanceMultiThread16.NumThreads: Integer;
begin
  Result := 16;
end;

{ TRawPerformanceMultiThread31 }

class function TRawPerformanceMultiThread31.NumThreads: Integer;
begin
  Result := 31;
end;

end.
