unit SmallUpsizeBenchmark;

interface

uses
  BenchmarkClassUnit;

const
  {The number of pointers}
  NumPointers = 500000;
  {The maximum block size}
  MaxBlockSize = 32;

type

  TSmallUpsizeBench = class(TFastcodeMMBenchmark)
  protected
    FPointers: array[0..NumPointers - 1] of PAnsiChar;
  public
    constructor CreateBenchmark; override;
    destructor Destroy; override;
    procedure RunBenchmark; override;
    class function GetBenchmarkName: string; override;
    class function GetBenchmarkDescription: string; override;
    class function GetSpeedWeight: Double; override;
    class function GetCategory: TBenchmarkCategory; override;
  end;

implementation

const
  IterationsCount = 50;

{ TSmallResizeBench }

constructor TSmallUpsizeBench.CreateBenchmark;
begin
  inherited;
end;

destructor TSmallUpsizeBench.Destroy;
begin
  inherited;
end;

class function TSmallUpsizeBench.GetBenchmarkDescription: string;
begin
  Result := 'Allocates a small block and immediately resizes it to a slightly bigger size. This checks '
    + ' that the block upsizing behaviour of the MM is acceptable.  '
    + 'Benchmark submitted by Pierre le Riche.';
end;

class function TSmallUpsizeBench.GetBenchmarkName: string;
begin
  Result := 'Small upsize benchmark';
end;

class function TSmallUpsizeBench.GetCategory: TBenchmarkCategory;
begin
  Result := bmSingleThreadRealloc;
end;

class function TSmallUpsizeBench.GetSpeedWeight: Double;
begin
  {Speed is not important here. It is just to check that the bahaviour of the
   MM is acceptable.}
  Result := 0.2;
end;

procedure TSmallUpsizeBench.RunBenchmark;
const
  Prime = 43;
var
  i, j, k, LSize: integer;
  CurValue: Int64;
begin
  {Call the inherited handler}
  inherited;
  CurValue := Prime;
  {Do the benchmark}
  for k := 1 to IterationsCount do
  begin
    for i := low(FPointers) to high(FPointers) do
    begin
      FPointers[i] := nil;
    end;
    for i := low(FPointers) to high(FPointers) do
    begin
      {Get the initial block size}
      LSize := 1 + (CurValue mod MaxBlockSize);
      Inc(CurValue, Prime);
      ReallocMem(FPointers[i], LSize);
      FPointers[i][0] := #13;
      if LSize > 2 then
      begin
        FPointers[i][LSize - 1] := #13;
      end;
      {Reallocate it a few times}
      for j := 1 to 3 do
      begin
        LSize := LSize + (CurValue mod MaxBlockSize);
        Inc(CurValue, Prime);
        ReallocMem(FPointers[i], LSize);
        if LSize > 2 then
        begin
          FPointers[i][LSize - 1] := #13;
        end;
      end;
    end;
    {Free the pointers}
    for i := low(FPointers) to high(FPointers) do
    begin
      ReallocMem(FPointers[i], 0);
    end;
  end;
  {What we end with should be close to the peak usage}
  UpdateUsageStatistics;
end;

end.
