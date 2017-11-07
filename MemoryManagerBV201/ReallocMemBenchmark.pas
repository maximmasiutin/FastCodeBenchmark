{A simple benchmark with lots of reallocmem calls}

unit ReallocMemBenchmark;

interface

uses
  BenchmarkClassUnit;

type
  PReallocMemBenchmarkBlockSizesArray = ^TReallocMemBenchmarkBlockSizesArray;
  PReallocMemBenchmarkPointerArray    = ^TReallocMemBenchmarkPointerArray;

  TReallocMemBenchmarkPointerArray          =  packed array[0..MaxInt div SizeOf(Pointer)-1] of Pointer;
  TReallocMemBenchmarkBlockSizesArray       =  packed array[0..MaxInt div SizeOf(Pointer)-1] of Integer;

  TReallocBenchAbstract = class(TFastcodeMMBenchmark)
  protected
    BlockSizes: PReallocMemBenchmarkBlockSizesArray;
    Pointers: PReallocMemBenchmarkPointerArray;
  public
    constructor CreateBenchmark; override;
    destructor Destroy; override;
    procedure RunBenchmark; override;
    class function GetBenchmarkDescription: string; override;
    class function GetCategory: TBenchmarkCategory; override;
    class function GetIterationCount: Integer; virtual; abstract;
    class function GetNumPointers: Integer; virtual; abstract;
    class function GetBlockSizeDelta: Integer; virtual; abstract;
  end;

  TReallocBenchLarge = class(TReallocBenchAbstract)
    class function GetIterationCount: Integer; override;
    class function GetNumPointers: Integer; override;
    class function GetBlockSizeDelta: Integer; override;
    class function GetBenchmarkName: string; override;
  end;


  TReallocBenchMedium = class(TReallocBenchAbstract)
    class function GetIterationCount: Integer; override;
    class function GetNumPointers: Integer; override;
    class function GetBlockSizeDelta: Integer; override;
    class function GetBenchmarkName: string; override;
  end;

  TReallocBenchTiny = class(TReallocBenchAbstract)
    class function GetIterationCount: Integer; override;
    class function GetNumPointers: Integer; override;
    class function GetBlockSizeDelta: Integer; override;
    class function GetBenchmarkName: string; override;
  end;


implementation

{ TReallocBench }

constructor TReallocBenchAbstract.CreateBenchmark;
var
  np: Integer;
begin
  inherited;

  np := GetNumPointers;

  GetMem(Pointers, np*SizeOf(Pointer));
  {Clear all the pointers}
  FillChar(Pointers^, np*SizeOf(Pointer), 0);

  GetMem(BlockSizes, np*SizeOf(Integer));
  {Clear all the block sizes}
  FillChar(BlockSizes^, np*SizeOf(Integer), 0);
end;

destructor TReallocBenchAbstract.Destroy;
var
  np, i: integer;
begin
  np := GetNumPointers;

  {Free all residual pointers}
  for i := 0 to np - 1 do
  begin
    System.ReallocMem(Pointers^[i], 0);
  end;

  FreeMem(Pointers, np*SizeOf(Pointer)); Pointers := nil;
  FreeMem(BlockSizes, np*SizeOf(Integer)); BlockSizes := nil;

  inherited;
end;

class function TReallocBenchAbstract.GetBenchmarkDescription: string;
begin
  Result := 'Allocates lots of pointers of arbitrary sizes and continues to '
    + 'grow/shrink them arbitrarily in a loop.  '
    + 'Benchmark submitted by Pierre le Riche.';
end;

class function TReallocBenchMedium.GetBenchmarkName: string;
begin
  Result := 'ReallocMem Medium (1-4039b) benchmark';
end;

class function TReallocBenchTiny.GetBenchmarkName: string;
begin
  Result := 'ReallocMem Small (1-555b) benchmark';
end;


class function TReallocBenchAbstract.GetCategory: TBenchmarkCategory;
begin
  Result := bmSingleThreadRealloc;
end;

procedure TReallocBenchAbstract.RunBenchmark;
const
  Prime = 10513;
var
  sz, i, LPointerNumber, FIterCount, NumPointers, BlockSizeDelta, MaxBlockSize, MinBlockSize: Integer;
  CurValue: Int64;
  P: PAnsiChar;
begin
  {Call the inherited handler}
  inherited;
  MaxBlockSize := 0;
  MinBlockSize := MaxInt;
  CurValue := Prime;
  NumPointers := GetNumPointers;
  BlockSizeDelta := GetBlockSizeDelta;
  {Do the benchmark}
  FIterCount := GetIterationCount;
  for i := 1 to FIterCount do
  begin
    {Get an arbitarry pointer number}
    LPointerNumber := CurValue mod NumPointers;
    Inc(CurValue, Prime);
    {Adjust the current block size up or down by up to BlockSizeDelta}
    BlockSizes^[LPointerNumber] := abs(BlockSizes^[LPointerNumber] + (CurValue mod BlockSizeDelta) - (BlockSizeDelta shr 1) - ((i and 7)mod BlockSizeDelta));
    Inc(CurValue, Prime);
    {Reallocate the pointer}
    if MaxBlockSize < BlockSizes^[LPointerNumber] then MaxBlockSize := BlockSizes^[LPointerNumber];
    if (BlockSizes^[LPointerNumber] > 0) and (MinBlockSize > BlockSizes^[LPointerNumber]) then MinBlockSize := BlockSizes^[LPointerNumber];

    System.ReallocMem(Pointers^[LPointerNumber], BlockSizes^[LPointerNumber]);
    {Touch the memory}
    sz := BlockSizes^[LPointerNumber];
    if sz > 0 then
    begin
      P := Pointers^[LPointerNumber];
      P[0] := #1;
      if sz > 1 then
      begin
        P[sz-1] := #2;
      end;
    end;
  end;
  {What we end with should be close to the peak usage}
  UpdateUsageStatistics;
end;


{ TReallocBenchMedium }

class function TReallocBenchMedium.GetBlockSizeDelta: Integer;
begin
  {The maximum change in a block size per iteration}
  Result := 2039 {prime};
end;

class function TReallocBenchMedium.GetIterationCount: Integer;
begin
  Result := 75000*1000;
end;

class function TReallocBenchMedium.GetNumPointers: Integer;
begin
  Result := 20011 {prime};
end;

{ TReallocBenchTiny }

class function TReallocBenchTiny.GetBlockSizeDelta: Integer;
begin
  {The maximum change in a block size per iteration}
  Result := 257 {prime};
end;

class function TReallocBenchTiny.GetIterationCount: Integer;
begin
  Result := 300000*1000;
end;

class function TReallocBenchTiny.GetNumPointers: Integer;
begin
  Result := 521 {prime}; // to fit in the cache better
end;

{ TReallocBenchLarge }

class function TReallocBenchLarge.GetBenchmarkName: string;
begin
  Result := 'ReallocMem Large (1-952224b) benchmark';
end;

class function TReallocBenchLarge.GetBlockSizeDelta: Integer;
begin
  Result := 555029 {prime};
end;

class function TReallocBenchLarge.GetIterationCount: Integer;
begin
  Result := 265*1000;
end;

class function TReallocBenchLarge.GetNumPointers: Integer;
begin
  Result := 2153 {prime};
end;

end.
