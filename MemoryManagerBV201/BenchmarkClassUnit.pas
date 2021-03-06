unit BenchmarkClassUnit;

interface

uses Windows;

type

  {Benchmark categories}
  TBenchmarkCategory = (
    bmSingleThreadRealloc, bmMultiThreadRealloc, bmSingleThreadAllocAndFree,
    bmMultiThreadAllocAndFree, bmSingleThreadReplay, bmMultiThreadReplay,
    bmMemoryAccessSpeed);
  TBenchmarkCategorySet = set of TBenchmarkCategory;

const
  AllBenchmarkCategories: TBenchmarkCategorySet = [low(TBenchmarkCategory)..high(TBenchmarkCategory)];

type

  {The benchmark class}
  TFastcodeMMBenchmark = class
  protected
    {Indicates whether the benchmark can be run - or if a problem was
     discovered, possibly during create}
    FCanRunBenchmark: Boolean;
    {The peak address space usage measured}
    FPeakAddressSpaceUsage: NativeUInt;
    {Gets the memory overhead of the benchmark that should be subtracted}
    function GetBenchmarkOverhead: NativeUInt; virtual;
  public
    constructor CreateBenchmark; virtual;
    {The tests - should return true if implemented}
    procedure RunBenchmark; virtual;
    {Resets the peak usage measurement}
    procedure ResetUsageStatistics;
    {Measures the address space usage and updates the peak value if the current
     usage is greater}
    procedure UpdateUsageStatistics;
    {The name of the benchmark}
    class function GetBenchmarkName: string; virtual;
    {A description for the benchmark}
    class function GetBenchmarkDescription: string; virtual;
    {Gets the relative weight of the speed portion of the benchmark vs. the
     peak address space usage portion in the calculation of relative
     performance. The peak address space weight will be 1 - this value.
     Valid range: 0.1 to 0.9, default 0.5}
    class function GetSpeedWeight: Double; virtual;
    {Gets the weight of this benchmark relative to all other benchmarks.
     Valid range: 0 to 1.0, default 1.0}
    class function GetBenchmarkWeight: Double; virtual;
    {Should this benchmark be run by default?}
    class function RunByDefault: boolean; virtual;
    {Benchmark Category}
    class function GetCategory: TBenchmarkCategory; virtual;

    class function IsThreadedSpecial: Boolean; virtual;

    class function Is32BitSpecial: Boolean; virtual;

    {The peak usage measured since the last reset}
    property PeakAddressSpaceUsage: NativeUInt read FPeakAddressSpaceUsage;
    {Indicates whether the benchmark can be run - or if a problem was
     discovered, possibly during create}
    property CanRunBenchmark: Boolean read FCanRunBenchmark;
  end;
  TFastcodeMMBenchmarkClass = class of TFastcodeMMBenchmark;

const
  {Benchmark category names}
  BenchmarkCategoryNames: array[TBenchmarkCategory] of string = (
    'Single Thread ReallocMem', 'Multi-threaded ReallocMem',
    'Single Thread GetMem and FreeMem',
    'Multi-threaded GetMem and FreeMem',
    'Single Thread Replay',
    'Multi-threaded Replay',
    'Memory Access Speed');

var
  {All the benchmarks}
  Benchmarks: array of TFastcodeMMBenchmarkClass;
  {The global weight for each benchmark}
  GlobalBenchmarkWeights: array of double;

{Get the list of benchmarks}
procedure DefineBenchmarks;
{Get the global weights for all benchmarks}
procedure ComputeBenchmarkGlobalWeights;

implementation

uses
  FragmentationTestUnit, ReallocMemBenchmark, DownsizeTestUnit,
  SmallUpsizeBenchmark, AddressSpaceCreepBenchmark,
  ArrayUpsizeSingleThread, BlockSizeSpreadBenchmark,
  LargeBlockSpreadBenchmark, NexusDBBenchmarkUnit,
  RawPerformanceMultiThread, RawPerformanceSingleThread,
  ReplayBenchmarkUnit, SmallDownsizeBenchmark, StringThreadTestUnit,
  WildThreadsBenchmarkUnit, AddressSpaceCreepBenchmarkLarge,
  DoubleFPBenchmark1Unit, DoubleFPBenchmark2Unit, DoubleFPBenchmark3Unit,
  MoveBenchmark1Unit, MoveBenchmark2Unit,
  SingleFPBenchmark1Unit, SingleFPBenchmark2Unit,
  LinkedListBenchmark, BenchmarkUtilities, MemFreeBenchmark1Unit,
  MemFreeBenchmark2Unit, FillCharMultiThreadBenchmark1Unit,
  SortIntArrayBenchmark1Unit, SortExtendedArrayBenchmark1Unit,
  MultiThreadedAllocAndFree, MultiThreadedReallocate,
  SingleThreadedAllocAndFree, SingleThreadedReallocate,
  SortIntArrayBenchmark2Unit, SortExtendedArrayBenchmark2Unit,
  SingleThreadedAllocMem, SingleThreadedTinyReloc;

{ TFastcodeMMBenchmark }

procedure TFastcodeMMBenchmark.RunBenchmark;
begin
  {Reset the peak usage statistic}
  ResetUsageStatistics;
end;

class function TFastcodeMMBenchmark.GetBenchmarkName: string;
begin
  Result := '(Unnamed)';
end;

constructor TFastcodeMMBenchmark.CreateBenchmark;
begin
  inherited;
  FCanRunBenchmark := True;
end;

procedure TFastcodeMMBenchmark.ResetUsageStatistics;
begin
  FPeakAddressSpaceUsage := 0;
end;

procedure TFastcodeMMBenchmark.UpdateUsageStatistics;
var
  LCurrentUsage, LBenchmarkOverhead: NativeUInt;
begin
  {Get the usage less the usage at program startup (before the MM was started).
   The assumption here is that any static lookup tables used by the MM will be
   small.}
  LCurrentUsage := GetAddressSpaceUsed;
  LBenchmarkOverhead := GetBenchmarkOverhead;
  if LBenchmarkOverhead >= LCurrentUsage then LCurrentUsage := 0 else LCurrentUsage := LCurrentUsage - LBenchmarkOverhead;
  {Update the peak usage}
  if LCurrentUsage > FPeakAddressSpaceUsage then
    FPeakAddressSpaceUsage := LCurrentUsage;
end;

class function TFastcodeMMBenchmark.GetBenchmarkDescription: string;
begin
  Result := '';
end;

class function TFastcodeMMBenchmark.RunByDefault: boolean;
begin
  Result := True;
end;

class function TFastcodeMMBenchmark.GetSpeedWeight: Double;
begin
  Result := 0.5;
end;

class function TFastcodeMMBenchmark.IsThreadedSpecial: Boolean;
begin
  Result := False;
end;

class function TFastcodeMMBenchmark.Is32BitSpecial: Boolean;
begin
  Result := False;
end;

class function TFastcodeMMBenchmark.GetBenchmarkWeight: Double;
begin
  Result := 1;
end;

function TFastcodeMMBenchmark.GetBenchmarkOverhead: NativeUInt;
begin
  {Return the address space usage on startup}
  Result := InitialAddressSpaceUsed;
end;

{---------------------Initialization functions-------------------}

procedure AddBenchMark(ABenchmarkClass: TFastcodeMMBenchmarkClass);
var
  i: integer;
begin
  i := Length(Benchmarks);
  SetLength(Benchmarks, i + 1);
  Benchmarks[i] := ABenchmarkClass;
end;

procedure DefineBenchmarks;
begin
  // first all single-thread benchmarks that execute in the application's main thread...
  AddBenchMark(TFragmentationTest);
  AddBenchMark(TReallocBenchTiny);
  AddBenchMark(TReallocBenchMedium);
  AddBenchMark(TReallocBenchLarge);
  AddBenchMark(TDownsizeTest);
  AddBenchMark(TSmallUpsizeBench);
  AddBenchMark(TTinyDownsizeBench);
  AddBenchMark(TVerySmallDownsizeBench);
  AddBenchMark(TBlockSizeSpreadBench);
  AddBenchMark(TRawPerformanceSingleThread);
  AddBenchMark(TAddressSpaceCreepBench);
  AddBenchMark(TLargeBlockSpreadBench);
  AddBenchMark(TArrayUpsizeSingleThread);
  AddBenchMark(TAddressSpaceCreepBenchLarge);
  AddBenchMark(TSingleThreadReallocateVariousBlocksBenchmark);
  AddBenchMark(TSingleThreadedTinyRelocBenchmark);
  AddBenchMark(TSingleThreadAllocateAndFreeBenchmark);
  AddBenchMark(TReservationsSystemBenchmark);
  AddBenchMark(TXMLParserBenchmark);
  AddBenchMark(TDocumentClassificationBenchmark);
  // ...then all the benchmarks that create TThread descendants
  AddBenchMark(TSingleFPThreads);
  AddBenchMark(TSingleFPThreads2);
  AddBenchMark(TDoubleFPThreads1);
  AddBenchMark(TDoubleFPThreads2);
  AddBenchMark(TDoubleFPThreads3);
  AddBenchMark(TMoveThreads1);
  AddBenchMark(TMoveThreads2);
  AddBenchMark(TFillCharThreads);
  AddBenchMark(TSortIntArrayThreads);
  AddBenchMark(TStandardSortExtendedArrayThreads);
  AddBenchMark(TQuickSortExtendedArrayThreads);
  AddBenchMark(TMemFreeThreads1);
  AddBenchMark(TMemFreeThreads2);
  AddBenchMark(TLinkedListBench);
  AddBenchMark(TMultiThreadAllocateAndFreeBenchmark2);
  AddBenchMark(TMultiThreadAllocateAndFreeBenchmark4);
  AddBenchMark(TMultiThreadAllocateAndFreeBenchmark8);
  AddBenchMark(TMultiThreadAllocateAndFreeBenchmark12);
  AddBenchMark(TMultiThreadAllocateAndFreeBenchmark16);
  AddBenchMark(TMultiThreadAllocateAndFreeBenchmark31);
  AddBenchMark(TMultiThreadAllocateAndFreeBenchmark64);
  AddBenchMark(TMultiThreadReallocateBenchmark2);
  AddBenchMark(TMultiThreadReallocateBenchmark4);
  AddBenchMark(TMultiThreadReallocateBenchmark8);
  AddBenchMark(TMultiThreadReallocateBenchmark12);
  AddBenchMark(TMultiThreadReallocateBenchmark16);
  AddBenchMark(TMultiThreadReallocateBenchmark31);
  AddBenchMark(TMultiThreadReallocateBenchmark64);
  AddBenchMark(TQuickSortIntArrayThreads);
  AddBenchMark(TQuickSortExtendedArrayThreads);
  AddBenchMark(TNexusBenchmark1Thread);
  AddBenchMark(TNexusBenchmark2Threads);
  AddBenchMark(TNexusBenchmark4Threads);
  AddBenchMark(TNexusBenchmark8Threads);
  AddBenchMark(TNexusBenchmark12Threads);
  AddBenchMark(TNexusBenchmark16Threads);
  AddBenchMark(TNexusBenchmark31Threads);
{$IFDEF WIN64}
  AddBenchMark(TNexusBenchmark63Threads);
  AddBenchMark(TNexusBenchmark128Threads);
  AddBenchMark(TNexusBenchmark256Threads);
  AddBenchMark(TNexusBenchmark512Threads);
{$ENDIF}
  AddBenchMark(TWildThreads);
  AddBenchMark(TRawPerformanceMultiThread2);
  AddBenchMark(TRawPerformanceMultiThread4);
  AddBenchMark(TRawPerformanceMultiThread8);
  AddBenchMark(TRawPerformanceMultiThread12);
  AddBenchMark(TRawPerformanceMultiThread16);
  AddBenchMark(TRawPerformanceMultiThread31);
  AddBenchMark(TRawPerformanceMultiThread63);
  AddBenchMark(TRawPerformanceMultiThread128);
  AddBenchMark(TRawPerformanceMultiThread256);
  AddBenchMark(TManyThreadsTest);
  AddBenchMark(TStringThreadTest2);
  AddBenchMark(TStringThreadTest4);
  AddBenchMark(TStringThreadTest8);
  AddBenchMark(TStringThreadTest12);
  AddBenchMark(TStringThreadTest16);
  AddBenchMark(TStringThreadTest31);
  AddBenchMark(TStringThreadTest63);
  AddBenchMark(TeLinkBenchmark);
  AddBenchMark(TeLinkComServerBenchmark);
  AddBenchMark(TWebbrokerReplayBenchmark);
  AddBenchMark(TBeyondCompareBenchmark);
  AddBenchMark(TSingleThreadAllocMemBenchmark);
  {End of benchmark list}
  AddBenchMark(TReplayBenchmark);     // not active by default, added so you can run your own replays
end;

procedure ComputeBenchmarkGlobalWeights;
const
  {PLR 6/5/2005 changed weights: Multi-threaded weights were IMO
    disproportionately high vs. single threaded. Having multithreaded benchmarks
    carry more than 50% more weight than single-threaded benchmarks is not
    realistic?! Should it be exactly balanced?}
  WeightPerCategory: array[TBenchmarkCategory] of Double = (
    {If your application reallocs a lot in speed-critical code then it is badly
     written (hence the low weight)}
    0.08, //bmSingleThreadRealloc
    0.11, //bmMultiThreadRealloc
    {Alloc and free is the typical behaviour of most apps}
    0.10, //bmSingleThreadAllocAndFree
    0.14, //bmMultiThreadAllocAndFree
    {Replays count the most (this is the closest to real-world behaviour we've
     got at the moment, although memory is not actually "used")}
    0.20, //bmSingleThreadReplay
    0.29, //bmMultiThreadReplay
    {Some anomalies with some of the current speed tests precludes using a
     bigger weight.}
    0.08 //bmMemoryAccessSpeed
  );
var
  i: integer;
  WeightSumArray: array[TBenchmarkCategory] of Double;
  Category: TBenchmarkCategory;
  LClass: TFastcodeMMBenchmarkClass;
begin
  // compute sum of relative weights within each category
  FillChar(WeightSumArray, SizeOf(WeightSumArray), 0);
  for i := Low(Benchmarks) to high(Benchmarks) do
  begin
    LClass := Benchmarks[i];
    if not Assigned(LClass) then Continue;
    if LClass.RunByDefault then
    begin
      Category := LClass.GetCategory;
      WeightSumArray[Category] := WeightSumArray[Category] + LClass.GetBenchmarkWeight;
    end;
  end;
  // compute global weight in accordance with array WeightPerCategory
  SetLength(GlobalBenchmarkWeights, Length(Benchmarks));
  for i := Low(Benchmarks) to high(Benchmarks) do
  begin
    LClass := Benchmarks[i];
    if not Assigned(LClass) then Continue;
    Category := LClass.GetCategory;
    if WeightSumArray[Category] = 0 then
      GlobalBenchmarkWeights[i] := 0
    else
      GlobalBenchmarkWeights[i] := LClass.GetBenchmarkWeight * WeightPerCategory[Category] / WeightSumArray[Category];
  end;
end;

class function TFastcodeMMBenchmark.GetCategory: TBenchmarkCategory;
begin
  Result := bmMemoryAccessSpeed;
end;

initialization
  {Get the list of benchmarks}
  DefineBenchmarks;
  {Get the global weights for all benchmarks}
  ComputeBenchmarkGlobalWeights;

end.
