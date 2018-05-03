{A multi-threaded benchmark that reallocates memory blocks and uses them.}

unit MultiThreadedReallocate;

interface

uses Windows, BenchmarkClassUnit, Classes, Math;

type

  TMultiThreadReallocateBenchmarkAbstract = class(TFastcodeMMBenchmark)
  public
    procedure RunBenchmark; override;
    class function GetBenchmarkName: string; override;
    class function GetBenchmarkDescription: string; override;
    class function GetCategory: TBenchmarkCategory; override;
    class function GetSpeedWeight: Double; override;
    class function IsThreadedSpecial: Boolean; override;
    class function GetNumThreads: Integer; virtual; abstract;
  end;

  TMultiThreadReallocateBenchmark2 = class(TMultiThreadReallocateBenchmarkAbstract)
    class function GetNumThreads: Integer; override;
  end;

  TMultiThreadReallocateBenchmark4 = class(TMultiThreadReallocateBenchmarkAbstract)
    class function GetNumThreads: Integer; override;
  end;

  TMultiThreadReallocateBenchmark8 = class(TMultiThreadReallocateBenchmarkAbstract)
    class function GetNumThreads: Integer; override;
  end;

  TMultiThreadReallocateBenchmark12 = class(TMultiThreadReallocateBenchmarkAbstract)
    class function GetNumThreads: Integer; override;
  end;

  TMultiThreadReallocateBenchmark16 = class(TMultiThreadReallocateBenchmarkAbstract)
    class function GetNumThreads: Integer; override;
  end;

  TMultiThreadReallocateBenchmark31 = class(TMultiThreadReallocateBenchmarkAbstract)
    class function GetNumThreads: Integer; override;
  end;

  TMultiThreadReallocateBenchmark64 = class(TMultiThreadReallocateBenchmarkAbstract)
    class function GetNumThreads: Integer; override;
  end;


implementation

uses
  PrimeNumbers,
  SysUtils;


type
  TCreateAndFreeThread = class(TThread)
  public
    FCurValue: Int64;
    FPrime: Integer;
    FRepeatCount: Integer;
    procedure Execute; override;
  end;

procedure TCreateAndFreeThread.Execute;
const
  PointerCount = 2500;
var
  LRepeatCount, i, j: Integer;
  kcalc: NativeUint;
  kloop: Cardinal;
  LPointers: array[0..PointerCount - 1] of Pointer;
  LMax, LSize, LSum: Integer;
begin
  {Allocate the initial pointers}
  for i := 0 to PointerCount - 1 do
  begin
    {Rough breakdown: 50% of pointers are <=64 bytes, 95% < 1K, 99% < 4K, rest < 256K}
    if i and 1 <> 0 then
      LMax := 64
    else
      if i and 15 <> 0 then
        LMax := 1024
      else
        if i and 255 <> 0 then
          LMax := 4 * 1024
        else
          LMax := 256 * 1024;
    {Get the size, minimum 1}
    Inc(FCurValue, FPrime);
    LSize := (FCurValue mod LMax) + 1;
    {Get the pointer}
    GetMem(LPointers[i], LSize);
  end;
  {Reallocate in a loop}
  for j := 1 to FRepeatCount do
  begin
    for i := 0 to PointerCount - 1 do
    begin
      {Rough breakdown: 50% of pointers are <=64 bytes, 95% < 1K, 99% < 4K, rest < 256K}
      if i and 1 <> 0 then
        LMax := 64
      else
        if i and 15 <> 0 then
          LMax := 1024
        else
          if i and 255 <> 0 then
            LMax := 4 * 1024
          else
            LMax := 256 * 1024;
      {Get the size, minimum 1}
      Inc(FCurValue, FPrime);
      LSize := (FCurValue mod LMax) + 1;
      {Reallocate the pointer}
      ReallocMem(LPointers[i], LSize);
      {Write the memory}
      for kloop := 0 to (LSize - 1) div 32 do
      begin
        kcalc := kloop;
        PByte(NativeUInt(LPointers[i]) + kcalc * 32)^ := byte(i);
      end;
      {Read the memory}
      LSum := 0;
      if LSize > 15 then
      begin
        for kloop := 0 to (LSize - 16) div 32 do
        begin
          kcalc := kloop;
          Inc(LSum, PShortInt(NativeUInt(LPointers[i]) + kcalc * 32 + 15)^);
        end;
      end;
      {"Use" the sum to suppress the compiler warning}
      if LSum > 0 then;
    end;
  end;
  {Free all the pointers}
  for i := 0 to PointerCount - 1 do
    FreeMem(LPointers[i]);
  {Set the return value}
  ReturnValue := 1;
end;

{ TMultiThreadReallocateBenchmarkAbstract }

class function TMultiThreadReallocateBenchmarkAbstract.GetBenchmarkDescription: string;
begin
  Result := 'A '+IntToStr(GetNumThreads)+'-threaded benchmark that allocates and reallocates memory '
    + 'blocks. The usage of different block sizes approximates real-world usage '
    + 'as seen in various replays. Allocated memory is actually "used", i.e. '
    + 'written to and read.  '
    + 'Benchmark submitted by Pierre le Riche.';
end;

class function TMultiThreadReallocateBenchmarkAbstract.GetBenchmarkName: string;
begin
  Result := 'Multi-threaded ('+IntToStr(GetNumThreads)+') reallocate and use';
end;

class function TMultiThreadReallocateBenchmarkAbstract.GetCategory: TBenchmarkCategory;
begin
  Result := bmMultiThreadRealloc;
end;

class function TMultiThreadReallocateBenchmarkAbstract.GetSpeedWeight: Double;
begin
  Result := 0.6;
end;

class function TMultiThreadReallocateBenchmarkAbstract.IsThreadedSpecial: Boolean;
begin
  Result := True;
end;

procedure TMultiThreadReallocateBenchmarkAbstract.RunBenchmark;
const
  CRepeatCountTotal = 100000;
var
  PrimeIndex, n: Integer;
  LCreateAndFree: TCreateAndFreeThread;
  threads: TList;
  LFinished: Boolean;
  LNumThreads: Integer;
begin
  inherited;
  PrimeIndex := Low(VeryGoodPrimes);
  threads:=TList.Create;
  LNumThreads := GetNumThreads;
  {create threads}
  for n := 1 to LNumThreads do begin
    LCreateAndFree := TCreateAndFreeThread.Create(True);
    LCreateAndFree.FPrime := VeryGoodPrimes[PrimeIndex];
    LCreateAndFree.FRepeatCount := CRepeatCountTotal div LNumThreads;
    Inc(PrimeIndex); if PrimeIndex > High(VeryGoodPrimes) then PrimeIndex := Low(VeryGoodPrimes);
    LCreateAndFree.FreeOnTerminate:=False;
    threads.Add(LCreateAndFree);
  end;
  {start all threads at the same time}
  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_ABOVE_NORMAL);
  for n:=0 to threads.Count-1 do
  begin
    LCreateAndFree:=TCreateAndFreeThread(threads.Items[n]);
    LCreateAndFree.Suspended := False;
  end;
  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_NORMAL);
  {wait for completion of the threads}
  repeat
    {Any threads still running?}
    LFinished := True;
    for n := 0 to threads.Count - 1 do
    begin
      LCreateAndFree := TCreateAndFreeThread(threads.Items[n]);
      LFinished := LFinished and (LCreateAndFree.ReturnValue <> 0);
    end;
    {Update usage statistics}
    UpdateUsageStatistics;
{$IFDEF WIN32}
    {Don't sleep on Win64}
    sleep(10);
{$ENDIF}
  until LFinished;
  {Free the threads}
  for n := 0 to threads.Count - 1 do
  begin
    LCreateAndFree := TCreateAndFreeThread(threads.Items[n]);
    LCreateAndFree.Terminate;
  end;
  for n := 0 to threads.Count - 1 do
  begin
    LCreateAndFree := TCreateAndFreeThread(threads.Items[n]);
    LCreateAndFree.WaitFor;
  end;
  for n := 0 to threads.Count - 1 do
  begin
    LCreateAndFree := TCreateAndFreeThread(threads.Items[n]);
    LCreateAndFree.Free;
  end;
  threads.Clear;
  threads.Free;
end;

class function TMultiThreadReallocateBenchmark2.GetNumThreads: Integer;
begin
  Result := 2;
end;

class function TMultiThreadReallocateBenchmark4.GetNumThreads: Integer;
begin
  Result := 4;
end;

class function TMultiThreadReallocateBenchmark8.GetNumThreads: Integer;
begin
  Result := 8;
end;


class function TMultiThreadReallocateBenchmark12.GetNumThreads: Integer;
begin
  Result := 12;
end;


class function TMultiThreadReallocateBenchmark16.GetNumThreads: Integer;
begin
  Result := 16;
end;


class function TMultiThreadReallocateBenchmark31.GetNumThreads: Integer;
begin
  Result := 31;
end;

class function TMultiThreadReallocateBenchmark64.GetNumThreads: Integer;
begin
  Result := 64;
end;


end.
