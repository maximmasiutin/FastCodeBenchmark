unit AddressSpaceCreepBenchmarkLarge;

interface

uses
  BenchmarkClassUnit, Math;

const
  {The number of pointers}
  AddressSpaceCreepBenchmarkLargeNumPointers =
  {$IFDEF WIN64}
  100000
  {$ELSE}
   20000
  {$ENDIF}
  ;
  {The maximum block size}
  MaxBlockSize = 70000;

type

  TAddressSpaceCreepBenchLarge = class(TFastcodeMMBenchmark)
  protected
    FPointers: array[0..AddressSpaceCreepBenchmarkLargeNumPointers - 1] of PAnsiChar;
  public
    constructor CreateBenchmark; override;
    destructor Destroy; override;
    procedure RunBenchmark; override;
    class function GetBenchmarkName: string; override;
    class function GetBenchmarkDescription: string; override;
    class function GetCategory: TBenchmarkCategory; override;
    class function Is32BitSpecial: Boolean; override;
  end;

implementation

{ TSmallResizeBench }

constructor TAddressSpaceCreepBenchLarge.CreateBenchmark;
begin
  inherited;
end;

destructor TAddressSpaceCreepBenchLarge.Destroy;
begin
  inherited;
end;

class function TAddressSpaceCreepBenchLarge.GetBenchmarkDescription: string;
begin
  Result := 'Allocates and deallocates thousands of large pointers in a loop, '
    + 'checking that the MM address space usage does not grow unbounded.  '
    + 'Benchmark submitted by Pierre le Riche.';
end;

class function TAddressSpaceCreepBenchLarge.GetBenchmarkName: string;
begin
  Result := 'Address space creep (larger blocks)';
end;

class function TAddressSpaceCreepBenchLarge.GetCategory: TBenchmarkCategory;
begin
  Result := bmSingleThreadAllocAndFree;
end;

class function TAddressSpaceCreepBenchLarge.Is32BitSpecial: Boolean;
begin
  Result := True;
end;

procedure TAddressSpaceCreepBenchLarge.RunBenchmark;
const
  Prime = 43;
var
  i, j, LSize, LOffset: integer;
  NextValue: Int64;
begin
  {Call the inherited handler}
  inherited;
  NextValue := Prime;
 {Allocate the pointers}
  for i := 0 to high(FPointers) do
  begin
    {Get an initial size}
    LSize := 1 + (MaxBlockSize+NextValue) mod MaxBlockSize;
    Inc(NextValue, Prime); // a prime number
    {Allocate the pointer}
    GetMem(FPointers[i], LSize);
    {Touch the memory}
    FPointers[i][0] := AnsiChar(byte(i));
    FPointers[i][LSize - 1] := AnsiChar(byte(i));
  end;
  {Free and get new pointers in a loop}
  for j := 1 to 400 do
  begin
    for i := 0 to high(FPointers) do
    begin
      {Free the pointer}
      FreeMem(FPointers[i]);
      {Get the new size}
      LSize := 1 + (MaxBlockSize+NextValue) mod MaxBlockSize;
      Inc(NextValue, Prime); // a prime number
      {Allocate the pointer}
      GetMem(FPointers[i], LSize);
      {Touch every page of the allocated memory}
      LOffset := 0;
      while LOffset < LSize do
      begin
        FPointers[i][LOffset] := AnsiChar(byte(LOffset));
        Inc(LOffset, 4096);
      end;
      {Touch the last byte}
      FPointers[i][LSize - 1] := AnsiChar(byte(i));
    end;
  end;
  {What we end with should be close to the peak usage}
  UpdateUsageStatistics;
  {Free the pointers}
  for i := 0 to high(FPointers) do
    FreeMem(FPointers[i], 1);
end;

end.
