unit BlockSizeSpreadBenchmark;

interface

uses
  BenchmarkClassUnit, Math;

const
  {The number of pointers}
  BlockSizeSpreadBenchNumPointers = 3000000;
  {The maximum block size}
  BlockSizeSpreadBenchMaxBlockSize = 25;

  BlockSizeSpreadBenchIterationsCount = {$IFNDEF DEBUG}60{$ELSE}3{$ENDIF};


type

  TBlockSizeSpreadBench = class(TFastcodeMMBenchmark)
  protected
    FPointers: array[0..BlockSizeSpreadBenchNumPointers - 1] of PAnsiChar;
  public
    constructor CreateBenchmark; override;
    destructor Destroy; override;
    procedure RunBenchmark; override;
    class function GetBenchmarkName: string; override;
    class function GetBenchmarkDescription: string; override;
    class function GetCategory: TBenchmarkCategory; override;
  end;

implementation


{ TSmallResizeBench }

constructor TBlockSizeSpreadBench.CreateBenchmark;
begin
  inherited;
end;

destructor TBlockSizeSpreadBench.Destroy;
begin
  inherited;
end;

class function TBlockSizeSpreadBench.GetBenchmarkDescription: string;
begin
  Result := 'Allocates millions of small objects, checking that the MM '
    + 'has a decent block size spread.  '
    + 'Benchmark submitted by Pierre le Riche.';
end;

class function TBlockSizeSpreadBench.GetBenchmarkName: string;
begin
  Result := 'Block size spread benchmark';
end;

class function TBlockSizeSpreadBench.GetCategory: TBenchmarkCategory;
begin
  Result := bmSingleThreadAllocAndFree;
end;

procedure TBlockSizeSpreadBench.RunBenchmark;
const
  Prime = 17;
var
  i, n, LSize: integer;
  NextValue: Int64;
begin
  {Call the inherited handler}
  inherited;
  NextValue := Prime;
  for n := 1 to BlockSizeSpreadBenchIterationsCount do     // loop added to have more than 1000 MTicks for this benchmark
  begin
    {Do the benchmark}
    for i := Low(FPointers) to High(FPointers) do
    begin
      {Get the initial block size, assume object sizes are 4-byte aligned}
      LSize := (1 + (BlockSizeSpreadBenchMaxBlockSize+NextValue) mod NextValue) * 4;
      Inc(NextValue, Prime);
      GetMem(FPointers[i], LSize);
      FPointers[i][0] := #13;
      if LSize > 2 then
      begin
        FPointers[i][LSize - 1] := #13;
      end;
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
