{The memory manager benchmark taken from the NexusDB website (www.nexusdb.com).
 Two changes: (1) Monitoring of memory usage was added (shouldn't impact scores
   much) and (2) lowered max items from 4K to 2K to lower memory consumption so
   that the higher thread count tests can be run on computers with 256M RAM.
 Changes from the original benchmark are indicated by a "PLR" in the comment}

// RH 17/04/2005
// class function IterationCount in order to have reasonable benchmark execution times
// IterationCount can be defined in each individual benchmark

unit NexusDBBenchmarkUnit;

interface

uses
  Windows, SysUtils, Classes, BenchmarkClassUnit, Math;

type

  TNexusBenchmark = class(TFastcodeMMBenchmark)
  public
    constructor CreateBenchmark; override;
    destructor Destroy; override;
    class function GetBenchmarkName: string; override;
    class function GetBenchmarkDescription: string; override;
    class function NumThreads: integer; virtual; abstract;
    class function GetBenchmarkWeight: Double; override;
    procedure RunBenchmark; override;
    class function GetCategory: TBenchmarkCategory; override;
    class function IterationCount: integer; virtual;
  end;

  TNexusBenchmarkThread = class(TNexusBenchmark)
    class function IsThreadedSpecial: Boolean; override;
  end;

  TNexusBenchmark1Thread = class(TNexusBenchmarkThread)
  public
    class function NumThreads: integer; override;
    class function IterationCount: integer; override;
  end;

  TNexusBenchmark2Threads = class(TNexusBenchmarkThread)
  public
    class function NumThreads: integer; override;
    class function IterationCount: integer; override;
  end;

  TNexusBenchmark4Threads = class(TNexusBenchmarkThread)
  public
    class function NumThreads: integer; override;
    class function IterationCount: integer; override;
  end;

  TNexusBenchmark8Threads = class(TNexusBenchmarkThread)
  public
    class function NumThreads: integer; override;
    class function IterationCount: integer; override;
  end;

  TNexusBenchmark12Threads = class(TNexusBenchmarkThread)
  public
    class function NumThreads: integer; override;
    class function RunByDefault: boolean; override;
    class function IterationCount: integer; override;
  end;

  TNexusBenchmark16Threads = class(TNexusBenchmarkThread)
  public
    class function NumThreads: integer; override;
    class function RunByDefault: boolean; override;
    class function IterationCount: integer; override;
  end;

  TNexusBenchmark31Threads = class(TNexusBenchmarkThread)
  public
    class function NumThreads: integer; override;
    class function RunByDefault: boolean; override;
    class function IterationCount: integer; override;
  end;

{$IFDEF WIN64}
  TNexusBenchmark63Threads = class(TNexusBenchmarkThread)
  public
    class function NumThreads: integer; override;
    class function RunByDefault: boolean; override;
    class function IterationCount: integer; override;
    class function Is32BitSpecial: Boolean; override;
  end;

  TNexusBenchmark128Threads = class(TNexusBenchmarkThread)
  public
    class function NumThreads: integer; override;
    class function RunByDefault: boolean; override;
    class function IterationCount: integer; override;
    class function Is32BitSpecial: Boolean; override;
  end;

  TNexusBenchmark256Threads = class(TNexusBenchmarkThread)
  public
    class function NumThreads: integer; override;
    class function RunByDefault: boolean; override;
    class function IterationCount: integer; override;
    class function Is32BitSpecial: Boolean; override;
  end;

  TNexusBenchmark512Threads = class(TNexusBenchmarkThread)
  public
    class function NumThreads: integer; override;
    class function RunByDefault: boolean; override;
    class function IterationCount: integer; override;
    class function Is32BitSpecial: Boolean; override;
  end;
{$ENDIF}

implementation

uses
  PrimeNumbers;

const
  NexusIterationDivider = {$IFNDEF DEBUG}1{$ELSE}17{$ENDIF};


  MaxItems = 5{$IFNDEF FPC}+2{$ENDIF};
  TestClass : array [1..MaxItems] of TClass =

    (TStringlist, TObject, Tlist, TBits,

    {$IFNDEF FPC}
    // FreePascal cannot create very big number of TCollection/TCollectionItem
    TCollectionItem, TCollection,
    {$ENDIF}

    TStream);

type
  TOrchestratorThread = class(TThread)
  private
    FBenchmark: TNexusBenchmark;
    FSemaphore: THandle;
    FThreads: TList;
    NumThreads: Integer;
    procedure Execute; override;
    destructor Destroy; override;
  end;

  TTestThread = class(TThread)
  protected
    Orchestrator: TOrchestratorThread;
    CurValue: Int64;
    Prime: Integer;
    FBenchmark: TNexusBenchmark;
  public
    procedure Execute; override;
    constructor Create(ABenchmark: TNexusBenchmark);
  end;

{ TTestThread }

constructor TTestThread.Create(ABenchmark: TNexusBenchmark);
begin
  inherited Create(True);
  FreeOnTerminate := False;
  Priority := tpLower;
  FBenchmark := ABenchmark;
end;

procedure TTestThread.Execute;
var
  k: Integer;
  i, j, jm: Integer;
  p: Pointer;
  aString: string;
  L: TList;
  SL: TStringList;
begin
  try
    // direct memory allocation
    L := nil;
    try
      L := TList.Create;
      for i := 0 to FBenchmark.IterationCount-1 do   // RH replaced 1 * 1000 * 1000 by FBenchmark.IterationCount
      begin
        Inc(CurValue, Prime);
        j := (CurValue mod (16*1024))+1;

        GetMem(p, j);
        k:=0;
        while k<j do begin
          pAnsiChar(p)[k]:=#13;
          inc(k,4*1024);
        end;
        if j>5 then
          pAnsiChar(p)[j-1]:=#13;
        L.Add(p);
        //PLR - Reduced the count from 4K to 2K to lower memory usage
        Inc(CurValue, Prime);
        j := (CurValue mod (2 * 1024));
        if j < L.Count then begin
          p := L[j];
          L.Delete(j);
          FreeMem(p);
        end;

        //PLR - Added to measure usage every 64K iterations
        if i and $ffff = 0 then
          FBenchmark.UpdateUsageStatistics;

      end;
      for i := Pred(L.Count) downto 0 do
      begin
        FreeMem(L[i]);
      end;
    finally
      L.Free;
      L := nil;
    end;
    // component creation
    L := nil;
    try
      L := TList.Create;
      for i := 0 to FBenchmark.IterationCount-1 do   // RH replaced 1 * 1000 * 1000 by FBenchmark.IterationCount
      begin
        Inc(CurValue, Prime);
        j := CurValue mod MaxItems;
        L.Add(TestClass[j+1].Create());
        //PLR - Reduced the count from 4K to 2K to lower memory usage
        Inc(CurValue, Prime);
        j := CurValue mod (2 * 1024);
        if j < L.Count then
        begin
          TComponent(L[j]).Free;
          L.Delete(j);
        end;

        //PLR - Added to measure usage every 64K iterations
        if i and $ffff = 0 then
          FBenchmark.UpdateUsageStatistics;

      end;
      for i := Pred(L.Count) downto 0 do
      begin
        TComponent(L[i]).Free;
      end;
    finally
      L.Free;
      L := nil;
    end;
    // strings and stringlist
    SL := nil;
    try
      SL := TStringList.Create;
      for i := 0 to FBenchmark.IterationCount-1 do   // RH replaced 1 * 1000 * 1000 by FBenchmark.IterationCount
      begin
        aString:='';
        Inc(CurValue, Prime);
        jm := CurValue mod 250;
        for j := 0 to jm do
        begin    // Iterate
          aString:=aString+'A';
        end;    // for
        SL.Add(aString);

        //PLR - Added to measure usage every 4K iterations
        if i and $fff = 0 then
          FBenchmark.UpdateUsageStatistics;

        //PLR - Reduced the count from 4K to 2K to lower memory usage
        Inc(CurValue, Prime);
        j := CurValue mod (2 * 1024);
        if j < SL.Count then
        begin
          SL.Delete(j);
        end;
      end;
    finally
      SL.Free;
      SL := nil;
    end;
    {Notify that the thread is done}
  finally
    ReleaseSemaphore(Orchestrator.FSemaphore, 1, nil);
  end;
end;

{ TNexusBenchmark }

constructor TNexusBenchmark.CreateBenchmark;
begin
  inherited;
end;

destructor TNexusBenchmark.Destroy;
begin
  inherited;
end;

class function TNexusBenchmark.GetBenchmarkDescription: string;
begin
  Result := 'The benchmark taken from www.nexusdb.com. Memory usage was '
    + 'slightly reduced to accommodate machines with 256MB RAM with up to 8 threads and more.';
end;

class function TNexusBenchmark.GetBenchmarkName: string;
begin
  Result := 'NexusDB with ' + IntToStr(NumThreads) + ' thread(s)';
end;

class function TNexusBenchmark.GetBenchmarkWeight: Double;
begin
  {The Nexus benchmark is represented four times, so reduce weighting}
  Result := 0.5;
end;

class function TNexusBenchmark.GetCategory: TBenchmarkCategory;
begin
  Result := bmMultiThreadRealloc;
end;

class function TNexusBenchmark.IterationCount: integer;
begin
  raise Exception.Create('Please override the iteration count for '+ClassName);
end;

destructor TOrchestratorThread.Destroy;
begin
  CloseHandle(FSemaphore);
  FSemaphore := 0;
  inherited;
end;

procedure TOrchestratorThread.Execute;
var
  PrimeIndex, i: Integer;
  T: TTestThread;
begin
  PrimeIndex := Low(VeryGoodPrimes);
  {Create the threads}
  for i := 1 to NumThreads do
  begin
    if FThreads = nil then FThreads := TList.Create;
    T := TTestThread.Create(FBenchmark);
    T.Orchestrator := Self;
    T.Prime := VeryGoodPrimes[PrimeIndex];
    Inc(PrimeIndex); if PrimeIndex > High(VeryGoodPrimes) then PrimeIndex := Low(VeryGoodPrimes);
    FThreads.Add(T);
  end;

  {Start the threads}
  for i := 0 to FThreads.Count-1 do
  begin
    T := TTestThread(FThreads[i]);
    T.Suspended := False;
  end;

  {Wait for threads to finish}
  for i := 1 to NumThreads do
  begin
    WaitForSingleObject(FSemaphore, INFINITE);
  end;

  {Terminate the threads}
  for i := 0 to FThreads.Count-1 do
  begin
    T := TTestThread(FThreads[i]);
    T.Terminate;
  end;
  for i := 0 to FThreads.Count-1 do
  begin
    T := TTestThread(FThreads[i]);
    T.WaitFor;
  end;
  for i := 0 to FThreads.Count-1 do
  begin
    T := TTestThread(FThreads[i]);
    FThreads[i] := nil;
    T.Free;
  end;
  FThreads.Clear;
  FThreads.Free;
  FThreads := nil;
end;

procedure TNexusBenchmark.RunBenchmark;
var
  T: TOrchestratorThread;
begin
  {Call the inherited method to reset the peak usage}
  inherited;
  T := TOrchestratorThread.Create(True);
  T.FBenchmark := Self;
  T.FSemaphore := CreateSemaphore(nil, 0, 9999, nil);
  T.NumThreads := NumThreads;
  T.Priority := tpHighest;
  T.Resume;
  T.WaitFor;
  T.Terminate;
  T.Free;
  T := nil;
end;

{ TNexusBenchmark1Thread }

class function TNexusBenchmark1Thread.IterationCount: integer;
begin
  Result := (10000 * 1000) div NexusIterationDivider;
end;

class function TNexusBenchmark1Thread.NumThreads: integer;
begin
  Result := 1;
end;

{ TNexusBenchmark2Threads }

class function TNexusBenchmark2Threads.IterationCount: integer;
begin
  Result := (5000 * 1000) div NexusIterationDivider;    // RH 50% of the original value
end;

class function TNexusBenchmark2Threads.NumThreads: integer;
begin
  Result := 2;
end;

{ TNexusBenchmark4Threads }

class function TNexusBenchmark4Threads.IterationCount: integer;
begin
  Result := (2500 * 1000) div NexusIterationDivider;    // RH 50% of the original value
end;

class function TNexusBenchmark4Threads.NumThreads: integer;
begin
  Result := 4;
end;

{ TNexusBenchmark8Threads }

class function TNexusBenchmark8Threads.IterationCount: integer;
begin
  Result := (1250 * 1000) div NexusIterationDivider;    // RH 25% of the original value
end;

class function TNexusBenchmark8Threads.NumThreads: integer;
begin
  Result := 8;
end;

{ TNexusBenchmark12Threads }

class function TNexusBenchmark12Threads.IterationCount: integer;
begin
  Result := (1100 * 1000) div NexusIterationDivider;
end;

class function TNexusBenchmark12Threads.NumThreads: integer;
begin
  Result := 12;
end;

class function TNexusBenchmark12Threads.RunByDefault: boolean;
begin
  Result := True;
end;

{ TNexusBenchmark16Threads }

class function TNexusBenchmark16Threads.IterationCount: integer;
begin
  Result := (600 * 1000) div NexusIterationDivider;
end;

class function TNexusBenchmark16Threads.NumThreads: integer;
begin
  Result := 16;
end;

class function TNexusBenchmark16Threads.RunByDefault: boolean;
begin
  Result := True;
end;

{ TNexusBenchmark31Threads }

class function TNexusBenchmark31Threads.IterationCount: integer;
begin
  Result := (300 * 1000) div NexusIterationDivider;
end;

class function TNexusBenchmark31Threads.NumThreads: integer;
begin
  Result := 31;
end;

class function TNexusBenchmark31Threads.RunByDefault: boolean;
begin
  Result := True;
end;

{$IFDEF WIN64}

{ TNexusBenchmark64Threads }

class function TNexusBenchmark63Threads.Is32BitSpecial: Boolean;
begin
  Result := True;
end;

class function TNexusBenchmark63Threads.IterationCount: integer;
begin
  Result := (200 * 1000) div NexusIterationDivider;
end;

class function TNexusBenchmark63Threads.NumThreads: integer;
begin
  Result := 63;
end;

class function TNexusBenchmark63Threads.RunByDefault: boolean;
begin
  Result := True;
end;

{ TNexusBenchmark128Threads }

class function TNexusBenchmark128Threads.Is32BitSpecial: Boolean;
begin
  Result := True;
end;

class function TNexusBenchmark128Threads.IterationCount: integer;
begin
  Result := (70 * 1000) div NexusIterationDivider;
end;

class function TNexusBenchmark128Threads.NumThreads: integer;
begin
  Result := 128;
end;

class function TNexusBenchmark128Threads.RunByDefault: boolean;
begin
  Result := True;
end;

{ TNexusBenchmark256Threads }

class function TNexusBenchmark256Threads.Is32BitSpecial: Boolean;
begin
  Result := True;
end;

class function TNexusBenchmark256Threads.IterationCount: integer;
begin
  Result := (60 * 1000) div NexusIterationDivider;
end;

class function TNexusBenchmark256Threads.NumThreads: integer;
begin
  Result := 256;
end;

class function TNexusBenchmark256Threads.RunByDefault: boolean;
begin
  Result := True;
end;

{ TNexusBenchmark512Threads }

class function TNexusBenchmark512Threads.Is32BitSpecial: Boolean;
begin
  Result := True;
end;

class function TNexusBenchmark512Threads.IterationCount: integer;
begin
  Result := (30 * 1000) div NexusIterationDivider;
end;

class function TNexusBenchmark512Threads.NumThreads: integer;
begin
  Result := 512;
end;

class function TNexusBenchmark512Threads.RunByDefault: boolean;
begin
  Result := True;
end;

{$ENDIF}

{ TNexusBenchmarkThread }

class function TNexusBenchmarkThread.IsThreadedSpecial: Boolean;
begin
  Result := NumThreads > 1;
end;

end.
