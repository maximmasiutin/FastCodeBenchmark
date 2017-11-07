unit LargeBlockSpreadBenchmark;

interface

uses
  BenchmarkClassUnit, Math;

const
  {The number of pointers}
  NumPointers = 2000;
  {The block size}
  BlockSize = 65537;

type

  TLargeBlockSpreadBench = class(TFastcodeMMBenchmark)
  protected
    FPointers: array[0..NumPointers - 1] of PAnsiChar;
  public
    constructor CreateBenchmark; override;
    destructor Destroy; override;
    procedure RunBenchmark; override;
    class function GetBenchmarkName: string; override;
    class function GetBenchmarkDescription: string; override;
    class function GetCategory: TBenchmarkCategory; override;
  end;

implementation

const
  IterationCount = 48;

{ TSmallResizeBench }

constructor TLargeBlockSpreadBench.CreateBenchmark;
begin
  inherited;
end;

destructor TLargeBlockSpreadBench.Destroy;
begin
  inherited;
end;

class function TLargeBlockSpreadBench.GetBenchmarkDescription: string;
begin
  Result := 'Allocates a few large blocks (>64K), checking that '
    + 'the MM manages large blocks efficiently.  '
    + 'Benchmark submitted by Pierre le Riche.';
end;

class function TLargeBlockSpreadBench.GetBenchmarkName: string;
begin
  Result := 'Large block spread benchmark';
end;

class function TLargeBlockSpreadBench.GetCategory: TBenchmarkCategory;
begin
  Result := bmSingleThreadAllocAndFree;
end;

procedure TLargeBlockSpreadBench.RunBenchmark;
const
  Prime = 7;
var
  i, j, k, LSize: integer;
  NextValue: Int64;
begin
  {Call the inherited handler}
  inherited;
  NextValue := Prime;
  {Do the benchmark}
  for j := 1 to IterationCount do
  begin
    for i := 0 to high(FPointers) do
    begin
      {Get the block}
      LSize := (1 + (NextValue mod 3)) * BlockSize;
      Inc(NextValue, Prime);
      GetMem(FPointers[i], LSize);
      {Fill the memory}
      for k := 0 to LSize - 1 do
        FPointers[i][k] := AnsiChar(k);
    end;
    {What we end with should be close to the peak usage}
    UpdateUsageStatistics;
    {Free the pointers}
    for i := 0 to high(FPointers) do
    begin
      FreeMem(FPointers[i]);
      FPointers[i] := nil;
    end;
  end;
end;

end.
