unit SmallDownsizeBenchmark;

interface

uses
  BenchmarkClassUnit, Math;

const
  {The number of pointers}
  NumPointers =
   {$IFDEF WIN64}
  10000000
   {$ELSE}
   5000000
   {$ENDIF}
  ;
type
  TSmallDownsizeBenchAbstract = class(TFastcodeMMBenchmark)
  protected
    FPointers: array[0..NumPointers - 1] of PAnsiChar;
  public
    constructor CreateBenchmark; override;
    destructor Destroy; override;
    procedure RunBenchmark; override;
    class function GetSpeedWeight: Double; override;
    class function GetCategory: TBenchmarkCategory; override;
    class function GetBlockSizeBytes: Integer; virtual; abstract;
    class function GetIterationsCount: Integer; virtual; abstract;
  end;

  TTinyDownsizeBench = class(TSmallDownsizeBenchAbstract)
    class function GetBlockSizeBytes: Integer; override;
    class function GetIterationsCount: Integer; override;
    class function GetBenchmarkName: string; override;
    class function GetBenchmarkDescription: string; override;
  end;

  TVerySmallDownsizeBench = class(TSmallDownsizeBenchAbstract)
    class function GetBlockSizeBytes: Integer; override;
    class function GetIterationsCount: Integer; override;
    class function GetBenchmarkName: string; override;
    class function GetBenchmarkDescription: string; override;
  end;

implementation

uses
  FastMM4, SysUtils;

{ TSmallDownsizeBenchAbstract }

constructor TSmallDownsizeBenchAbstract.CreateBenchmark;
begin
  inherited;
end;

destructor TSmallDownsizeBenchAbstract.Destroy;
begin
  inherited;
end;

class function TTinyDownsizeBench.GetBenchmarkDescription: string;
begin
  Result := 'Allocates a tiny block (up to 64 bytes) and immediately resizes it to a smaller size. This checks '
    + ' that the block downsizing behaviour of the MM is acceptable.  '
    + 'Benchmark submitted by Pierre le Riche.';
end;

class function TTinyDownsizeBench.GetBenchmarkName: string;
begin
  Result := 'Tiny downsize benchmark';
end;


class function TVerySmallDownsizeBench.GetBenchmarkDescription: string;
begin
  Result := 'Allocates a very small block (up to 200 bytes) and immediately resizes it to a smaller size. This checks '
    + ' that the block downsizing behaviour of the MM is acceptable.  '
    + 'Benchmark submitted by Pierre le Riche.';
end;

class function TVerySmallDownsizeBench.GetBenchmarkName: string;
begin
  Result := 'VerySmall downsize benchmark';
end;

class function TVerySmallDownsizeBench.GetBlockSizeBytes: Integer;
begin
  Result := 200;
end;

class function TSmallDownsizeBenchAbstract.GetCategory: TBenchmarkCategory;
begin
  Result := bmSingleThreadRealloc;
end;

class function TVerySmallDownsizeBench.GetIterationsCount: Integer;
begin
  Result := 5;
end;

class function TSmallDownsizeBenchAbstract.GetSpeedWeight: Double;
begin
  {Speed is not important here. It is just to check that the behaviour of the
   MM is acceptable.}
  Result := 0.2;
end;

procedure TSmallDownsizeBenchAbstract.RunBenchmark;
const
  Prime = 41;
var
  i, j, LSize, IterationsCount, MaxBlockSize: Integer;
  CurValue: Int64;
  k: Integer;
begin
  try
  {Call the inherited handler}
  inherited;
  CurValue := Prime;
  {Do the benchmark}
  IterationsCount := GetIterationsCount;
  MaxBlockSize := GetBlockSizeBytes;
  for k := 1 to IterationsCount do
  begin
    for i := low(FPointers) to high(FPointers) do
    begin
      {Get the initial block size}
      LSize := MaxBlockSize + (CurValue mod (3 * MaxBlockSize));
      Inc(CurValue, Prime);
      GetMem(FPointers[i], LSize);
      FPointers[i][0] := #13;
      if LSize > 5 then FPointers[i][LSize - 1] := #13;
      {Reallocate it a few times}
      for j := 1 to 5 do
      begin
        LSize := Max(1, LSize - (CurValue mod MaxBlockSize));
        Inc(CurValue, Prime);
        ReallocMem(FPointers[i], LSize);
        FPointers[i][0] := #13;
        if LSize > 5 then FPointers[i][LSize - 1] := #13;
      end;
    end;
    for i := low(FPointers) to high(FPointers) do
    begin
      FreeMem(FPointers[i]);
      FPointers[i] := nil;
    end;
  end;
  {What we end with should be close to the peak usage}
  UpdateUsageStatistics;
  {Free the pointers}
  except
    on E: Exception do
    begin
      E.Message := Format('%s, TotalAllocated=%d, Free=%d', [E.Message, FastMM4.FastGetHeapStatus.TotalAllocated, FastMM4.FastGetHeapStatus.TotalFree]);
      raise;
    end;
  end;
end;

{ TTinyDownsizeBench }

class function TTinyDownsizeBench.GetBlockSizeBytes: Integer;
begin
  Result := 64;
end;

class function TTinyDownsizeBench.GetIterationsCount: Integer;
begin
  Result := 7;
end;

end.
