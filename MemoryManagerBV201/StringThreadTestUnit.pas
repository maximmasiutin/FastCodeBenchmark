{****************************************************************************************

   StringTestBenchMark & ManyThreadsTestBenchMark v1.0

   By Ivo Tops for FastCode Memory Manager BenchMark & Validation

****************************************************************************************}
unit StringThreadTestUnit;

interface

uses BenchmarkClassUnit;

type

   TStringThreadTestAbstract = class(TFastcodeMMBenchmark)
   protected
   public
     procedure RunBenchmark; override;
     class function GetBenchmarkName: string; override;
     class function GetBenchmarkDescription: string; override;
     class function GetSpeedWeight: Double; override;
     class function GetCategory: TBenchmarkCategory; override;
     class function IsThreadedSpecial: Boolean; override;
     class function NumThreads: Integer; virtual; abstract;
   end;

   TStringThreadTest2 = class(TStringThreadTestAbstract)
     class function NumThreads: Integer; override;
   end;

   TStringThreadTest4 = class(TStringThreadTestAbstract)
     class function NumThreads: Integer; override;
   end;

   TStringThreadTest8 = class(TStringThreadTestAbstract)
     class function NumThreads: Integer; override;
   end;

   TStringThreadTest12 = class(TStringThreadTestAbstract)
     class function NumThreads: Integer; override;
   end;

   TStringThreadTest16 = class(TStringThreadTestAbstract)
     class function NumThreads: Integer; override;
   end;

   TStringThreadTest31 = class(TStringThreadTestAbstract)
     class function NumThreads: Integer; override;
   end;

   TStringThreadTest64 = class(TStringThreadTestAbstract)
     class function NumThreads: Integer; override;
   end;


   TManyThreadsTest = class(TFastcodeMMBenchmark)
   protected
   public
     procedure RunBenchmark; override;
     class function GetBenchmarkName: string; override;
     class function GetBenchmarkDescription: string; override;
     class function GetSpeedWeight: Double; override;
     class function GetCategory: TBenchmarkCategory; override;
   end;

// Counters for thread running
procedure IncRunningThreads;
procedure DecRunningThreads;
procedure NotifyThreadError;
procedure NotifyValidationError;

implementation

uses
  Math, StringThread, windows, sysutils, Classes, PrimeNumbers;

var
  RunningThreads: Integer;
  ThreadError, ValidationError, ThreadMaxReached, ZeroThreadsReached: Boolean;

procedure InitTest;
begin
   RunningThreads := 0;
   ZeroThreadsReached := False;
   ThreadMaxReached := False;
   ThreadError := False;
end;

procedure ExitTest;
begin
   // If Thread had error raise exception
   if ThreadError then raise Exception.Create('TestThread failed with an Error');
   // If Thread had validate raise exception
   if ValidationError then raise Exception.Create('TestThread failed Validation');
end;

{ TStringThreadTestAbstract }

class function TStringThreadTestAbstract.GetBenchmarkDescription: string;
begin
   Result := 'A benchmark that does string manipulations concurrently in '+IntToStr(NumThreads)+' different threads';
end;

class function TStringThreadTestAbstract.GetBenchmarkName: string;
begin
   Result := 'String'+IntToStr(NumThreads)+'ThreadTest';;
end;

class function TStringThreadTestAbstract.GetCategory: TBenchmarkCategory;
begin
  Result := bmMultiThreadRealloc;
end;

class function TStringThreadTestAbstract.GetSpeedWeight: Double;
begin
  {We're testing speed here, not memory usage}
  Result := 0.8;
end;

class function TStringThreadTestAbstract.IsThreadedSpecial: Boolean;
begin
  Result := True;
end;

procedure TStringThreadTestAbstract.RunBenchmark;
const
  cIterations = 25000;
var
  tc, ic, I, PrimeIndex: Integer;
  Threads: TList;
  T: TStringThreadEx;
  Handles: PWOHandleArray;
  wr, wrc: Cardinal;
begin
   inherited;
   InitTest;
   PrimeIndex := Low(VeryGoodPrimes);
   New(Handles);
   tc := NumThreads;
   ic := (cIterations div tc)+1;
   Threads := TList.Create;
   for I := 1 to tc do // Create a loose new thread that does stringactions
   begin
     T := TStringThreadEx.Create(ic, 2000, 4096, False);
     T.FPrime := VeryGoodPrimes[PrimeIndex];
     Inc(PrimeIndex);
     if PrimeIndex > High(VeryGoodPrimes) then
     begin
       PrimeIndex := Low(VeryGoodPrimes);
     end;

     Threads.Add(T);
   end;

   for i := 0 to Threads.Count-1 do
   begin
     T := TStringThreadEx(Threads[i]);
     Handles^[i] := T.Handle;
   end;

   for i := 0 to Threads.Count-1 do
   begin
     T := TStringThreadEx(Threads[i]);
     T.Start;
   end;

   wr := WaitForMultipleObjects(Threads.Count, Handles, True, INFINITE);
   wrc := WAIT_OBJECT_0+Threads.Count;
{$WARN COMPARISON_FALSE OFF}
   if (wr < WAIT_OBJECT_0) or (wr > wrc) then
   begin
     raise Exception.Create('WaitForMultipleObjects failed on TStringThreadTestAbstract.RunBenchmark');
   end;
{$WARN COMPARISON_FALSE ON}

   {Update the peak address space usage}
   UpdateUsageStatistics;
   Dispose(Handles);

   for i := 0 to Threads.Count-1 do
   begin
     T := TStringThreadEx(Threads[i]);
     T.Terminate;
   end;

   for i := 0 to Threads.Count-1 do
   begin
     T := TStringThreadEx(Threads[i]);
     T.WaitFor;
   end;

   for i := 0 to Threads.Count-1 do
   begin
     T := TStringThreadEx(Threads[i]);
     T.Free;
   end;

   Threads.Clear;
   Threads.Free;
   Threads := nil;
   // Done
   ExitTest;
end;

procedure IncRunningThreads;
var
   RT: Integer;
begin
   RT := InterlockedExchangeAdd({$IFDEF WIN32}@{$ENDIF} RunningThreads, 1);
   ZeroThreadsReached := False;
   ThreadMaxReached := RT > 1250;
end;

procedure DecRunningThreads;
var
   RT: Integer;
begin
   RT := InterlockedExchangeAdd({$IFDEF WIN32}@{$ENDIF} RunningThreads, -1);
   ThreadMaxReached := RT > 1250;
   ZeroThreadsReached := RT = 1; // Old value is 1, so new value is zero
end;

{ TManyThreadsTest }

class function TManyThreadsTest.GetBenchmarkDescription: string;
begin
   Result := 'A benchmark that has many temporary threads, each doing a little string processing. ';
   Result := Result + 'This test exposes possible multithreading issues in a memory manager and large per-thread ';
   Result := Result + 'memory requirements.';
end;

class function TManyThreadsTest.GetBenchmarkName: string;
begin
   Result := 'ManyShortLivedThreads';
end;

class function TManyThreadsTest.GetCategory: TBenchmarkCategory;
begin
  Result := bmMultiThreadRealloc;
end;

class function TManyThreadsTest.GetSpeedWeight: Double;
begin
  {We're testing speed here, not memory usage}
  Result := 0.8;
end;

procedure TManyThreadsTest.RunBenchmark;
var
  I: Integer;
  E: THandle;
  PrimeIdx: Integer;
  ThreadList: TList;

  procedure AddThread(T: TStringThreadEx);
  begin
    T.FPrime := VeryGoodPrimes[PrimeIdx];
    T.FEventHandle := E;
    Inc(PrimeIdx);
    if PrimeIdx > High(VeryGoodPrimes) then
    begin
      PrimeIdx := Low(VeryGoodPrimes);
    end;
    ThreadList.Add(T);
  end;

var
  T: TStringThreadEx;
  wr: Cardinal;
begin
   inherited;
   InitTest;
   PrimeIdx := Low(VeryGoodPrimes);
   ThreadList := TList.Create;
   E := CreateEvent(nil, False, False, nil);
   // Launch a lot of threads
   for I := 1 to 100 do
   begin
     AddThread(TStringThreadEx.Create(1000, 10, 512, False));
     AddThread(TStringThreadEx.Create(10, 2, 4096, False));
     AddThread(TStringThreadEx.Create(10, 2, 1024*1024, False));
   end;
   // Launch a lot of threads keeping threadmax in account
   for I := 1 to 500 do
   begin
     AddThread(TStringThreadEx.Create(100, 1, 512, False));
     AddThread(TStringThreadEx.Create(100, 100, 512, False));
     AddThread(TStringThreadEx.Create(100, 1, 512, False));
   end;
   for I := 0 to ThreadList.Count-1 do
   begin
     T := TStringThreadEx(ThreadList[i]);
     T.Start;
   end;
   repeat
     wr := WaitForSingleObject(E, INFINITE);
     if wr = WAIT_OBJECT_0 then
     begin
       for I := ThreadList.Count-1 downto 0 do
       begin
         T := TStringThreadEx(ThreadList[i]);
         if T.Finished then
         begin
           T.WaitFor;
           T.Free;
           ThreadList[i] := nil;
         end;
       end;
       ThreadList.Pack;
     end else
     begin
       raise Exception.Create('TManyThreadsTest.RunBenchmark -- failed');
     end;
   until ThreadList.Count = 0;
   CloseHandle(E);
   {Update the peak address space usage}
   UpdateUsageStatistics;
   // Done
   ExitTest;
end;

procedure NotifyThreadError;
begin
   ThreadError := True;
end;

procedure NotifyValidationError;
begin
   ValidationError := True;
end;

{ TStringThreadTest8 }

class function TStringThreadTest8.NumThreads: Integer;
begin
  Result := 8;
end;

{ TStringThreadTest2 }

class function TStringThreadTest2.NumThreads: Integer;
begin
  Result := 2;
end;

{ TStringThreadTest4 }

class function TStringThreadTest4.NumThreads: Integer;
begin
  Result := 4;
end;

{ TStringThreadTest12 }

class function TStringThreadTest12.NumThreads: Integer;
begin
  Result := 12;
end;

{ TStringThreadTest16 }

class function TStringThreadTest16.NumThreads: Integer;
begin
  Result := 16;
end;

{ TStringThreadTest31 }

class function TStringThreadTest31.NumThreads: Integer;
begin
  Result := 31;
end;

{ TStringThreadTest64 }

class function TStringThreadTest64.NumThreads: Integer;
begin
  Result := 64;
end;

end.


