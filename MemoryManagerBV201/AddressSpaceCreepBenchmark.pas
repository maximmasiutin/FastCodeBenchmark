unit AddressSpaceCreepBenchmark;

interface

uses
  BenchmarkClassUnit;

const
  {The number of pointers}
  NumPointers = 3000000;
  {The maximum block size}
  MaxBlockSize = 256;

type

  TAddressSpaceCreepBench = class(TFastcodeMMBenchmark)
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
  IterationsCount = 108;

{ TSmallResizeBench }

constructor TAddressSpaceCreepBench.CreateBenchmark;
begin
  inherited;
end;

destructor TAddressSpaceCreepBench.Destroy;
begin
  inherited;
end;

class function TAddressSpaceCreepBench.GetBenchmarkDescription: string;
begin
  Result := 'Allocates and deallocates millions of pointers in a loop, '
    + 'checking that the MM address space usage does not grow unbounded.  '
    + 'Benchmark submitted by Pierre le Riche.';
end;

class function TAddressSpaceCreepBench.GetBenchmarkName: string;
begin
  Result := 'Address space creep benchmark';
end;

class function TAddressSpaceCreepBench.GetCategory: TBenchmarkCategory;
begin
  Result := bmSingleThreadAllocAndFree;
end;

procedure TAddressSpaceCreepBench.RunBenchmark;
const
  Prime = 3;
var
  i, j, LSize: integer;
  NextValue: Int64;
begin
  {Call the inherited handler}
  inherited;
 {Allocate the pointers}
  NextValue := Prime;
  for i := 0 to high(FPointers) do
  begin
    {Get an initial size}
    LSize := 1 + (MaxBlockSize+NextValue) mod MaxBlockSize;
    Inc(NextValue, Prime);
    {Allocate the pointer}
    GetMem(FPointers[i], LSize);
    {Touch the memory}
    FPointers[i][0] := AnsiChar(byte(i));
    if LSize > 2 then
    begin
      FPointers[i][LSize - 1] := AnsiChar(byte(i));
    end;
  end;
  {Free and get new pointers in a loop}
  for j := 1 to IterationsCount do
  begin
    for i := 0 to high(FPointers) do
    begin
      {Free the pointer}
      FreeMem(FPointers[i]);
      FPointers[i] := nil;
      {Get the new size}
      LSize := 1 + (MaxBlockSize+NextValue) mod MaxBlockSize;
      Inc(NextValue, Prime);
      {Allocate the pointer}
      GetMem(FPointers[i], LSize);
      {Touch the memory}
      FPointers[i][0] := AnsiChar(byte(i));
      if LSize > 2 then
      begin
        FPointers[i][LSize - 1] := AnsiChar(byte(i));
      end;
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

end.
