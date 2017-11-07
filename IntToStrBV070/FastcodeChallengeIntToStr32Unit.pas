unit FastcodeChallengeIntToStr32Unit;

interface

{$INCLUDE Defines.inc}
{$INCLUDE Version.inc}

{$IFDEF Delphi2005Plus}
  {$WARN UNSAFE_CODE OFF}
  {$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

uses
  Classes, FastcodeChallengeUnit;

const
  CChallengeIntToStr32Version = '0.7.0';

type
  TIntToStr32Function = function(Value: Integer): string;

  TFastcodeChallengeIntToStr32 = class(TFastcodeChallenge)
  protected
    function GetBenchmarks: TBenchmarkFunctionArray; override;
    function GetName: string; override;
    function GetValidators: TValidatorFunctionArray; override;
    function GetVersion: string; override;
  end;

function ChallengeIntToStr32: TFastcodeChallengeIntToStr32;

implementation

uses
  SysUtils, Windows, UtilsUnit;

const
  RUN_COUNT = 1 shl 20;

  RERUN_COUNT = 30;
  RERUN_TRIM_FIRST = 5;
  RERUN_TRIM_MAX = 5;
  RERUN_TRIM_MIN = 5;

  SCALE_BENCH1 = 10000;
  SCALE_BENCH2 = 10000;
  SCALE_BENCH3 = 10000;
  SCALE_BENCH4 = 10000;
  SCALE_BENCH5 = 10000;
  SCALE_BENCH6 = 10000;
  SCALE_BENCHALT = 10000;

var
//  Benchmarks: TBenchmarkFunctionArray;
  ChallengeObject: TFastcodeChallengeIntToStr32;
  IntToStrData: array of Integer;
  PerformanceFrequency: Int64;
//  Validators: TValidatorFunctionArray;

function BenchmarkDKC(Func: Pointer; Callback: TFastcodeChallengeCallback): Double; forward;
function DescribeFailure(Value: Integer; const Res: string): string; overload; forward;
function DescribeFailure(Value: Integer; E: Exception): string; overload; forward;
function DescribeFailureAlloc(LengthValue, LengthOrig, LengthResult: Integer): string; forward;
function DescribeFailureNull(Value: Integer): string; forward;
function DescribeFailureRefCount(Value: Integer): string; overload; forward;
function DescribeFailureRefCount(Value, RefCount, RefCount2: Integer): string; overload; forward;
function DummyFunction(Value: Integer): string; forward;
procedure InitIntToStrData; forward;
function ValidateRange(Func: Pointer; Callback: TFastcodeChallengeCallback; var Progress: Integer; ProgressMax, ValueMin, ValueMax: Integer): Boolean; forward;
function Validator1(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean; forward;
function Validator2(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean; forward;
function Validator3(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean; forward;
function Validator4(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean; forward;
function Validator5(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean; forward;
function Validator6(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean; forward;
function Validator7(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean; forward;

function BenchmarkDKC(Func: Pointer; Callback: TFastcodeChallengeCallback): Double;
const
  RUN_COUNT = 1 shl 20;
  RERUN_COUNT = 10;
  RUNCOUNT : Integer = 10;
var
  DurationArray: array[0..RERUN_COUNT - 1] of Int64;
  I1, I, ReRunIndex, J: Integer;
  IntToStrFunction: TIntToStr32Function;
  TimeEnd, TimeStart, MinTicks: Int64;
begin
  IntToStrFunction := TIntToStr32Function(Func);
  for ReRunIndex := 0 to Length(DurationArray) - 1 do
  begin
    QueryPerformanceCounter(TimeStart);
    for I1 := 1 to RUNCOUNT do
      for I := 0 to RUN_COUNT - 1 do
        IntToStrFunction(IntToStrData[I]);
    QueryPerformanceCounter(TimeEnd);
    DurationArray[ReRunIndex] := TimeEnd - TimeStart;
  end;

  //Find smallest
  MinTicks := DurationArray[0];
  for J := 1 to Length(DurationArray) - 1 do
    if DurationArray[J] < MinTicks then
     MinTicks := DurationArray[J];
     
  Result := (300 * MinTicks) / PerformanceFrequency;
end;

function DescribeFailure(Value: Integer; const Res: string): string;
begin
  Result := Format('IntToStr(%d) resulted in ''%s''', [Value, Res]);
end;

function DescribeFailure(Value: Integer; E: Exception): string;
begin
  Result := Format('IntToStr(%d) raised a %s exception with message: %s',
    [Value, E.ClassName, QuoteString(E.Message)]);
end;

function DescribeFailureAlloc(LengthValue, LengthOrig, LengthResult: Integer): string;
begin
  Result := Format('IntToStr was passed a value of %d digits and string of length %d, resulting in a %d-character string',
    [LengthValue, LengthOrig, LengthResult]);
end;

function DescribeFailureNull(Value: Integer): string;
begin
  Result := Format('IntToStr(%d) did not append #0 terminator to result string', [Value]);
end;

function DescribeFailureRefCount(Value: Integer): string;
begin
  Result := Format('IntToStr(%d) overwrote references to string', [Value]);
end;

function DescribeFailureRefCount(Value, RefCount, RefCount2: Integer): string;
begin
  Result := Format('IntToStr(%d) returned with reference count %d for result and %d for copy of result', [Value, RefCount, RefCount2]);
end;

function DummyFunction(Value: Integer): string;
begin
  Result := '';
end;

procedure InitIntToStrData;
var
  I: Integer;
begin
  SetLength(IntToStrData, RUN_COUNT);
  RandSeed := $01234567;
  for I := Low(IntToStrData) to High(IntToStrData) do
    IntToStrData[I] := RandomSign * RandomLogarithmic32;
end;

function ValidateRange(Func: Pointer; Callback: TFastcodeChallengeCallback; var Progress: Integer; ProgressMax, ValueMin, ValueMax: Integer): Boolean;
const
  PROGRESS_FREQUENCY = 1 shl 8;
var
  I: Integer;
  Res: string;
begin
  Result := True;

  for I := ValueMin to ValueMax do
  begin
    if Progress mod PROGRESS_FREQUENCY = 0 then
      Callback.ReportProgress(Progress, ProgressMax);
    try
      Res := TIntToStr32Function(Func)(I);
      if Res <> IntToStr(I) then
      begin
        Callback.ReportFailure(DescribeFailure(I, Res));
        Result := False;
      end;
      if (PChar(Res) + Length(Res))^ <> #0 then
      begin
        Callback.ReportFailure(DescribeFailureNull(I));
        Result := False;
      end;
    except
      on E: Exception do
      begin
        Callback.ReportFailure(DescribeFailure(I, E));
        Result := False;
      end;
    end;
    Inc(Progress);
  end;
end;

// This validator tests corner case numbers (near Low(Integer), near 0 and near High(integer))
function Validator1(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  TEST_BLOCK_SIZE = 1 shl 14;
  PROGRESS_MAX = TEST_BLOCK_SIZE * 4;
var
  Progress: Integer;
begin
  Progress := 0;
  Result := ValidateRange(Func, Callback, Progress, PROGRESS_MAX,
    Low(Integer), Low(Integer) + TEST_BLOCK_SIZE - 1);
  Result := ValidateRange(Func, Callback, Progress, PROGRESS_MAX,
    -TEST_BLOCK_SIZE + 1, TEST_BLOCK_SIZE) and Result;
  Result := ValidateRange(Func, Callback, Progress, PROGRESS_MAX,
    High(Integer) - TEST_BLOCK_SIZE + 1, High(Integer)) and Result;
end;

// This validator tests corner case numbers (near powers of 10)
function Validator2(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  TEST_ABOVE = 10;
  TEST_BELOW = 10;
  TEST_POWER_COUNT = 10;
  PROGRESS_MAX = (TEST_ABOVE + 1 + TEST_BELOW) * TEST_POWER_COUNT * 2;
var
  I, Progress, Value: Integer;
begin
  Progress := 0;
  Result := True;

  Value := 1;
  for I := 0 to TEST_POWER_COUNT - 1 do
  begin
    if I > 0 then
      Value := Value * 10;

    Result := ValidateRange(Func, Callback, Progress, PROGRESS_MAX,
      Value - TEST_BELOW, Value + TEST_ABOVE) and Result;
    Result := ValidateRange(Func, Callback, Progress, PROGRESS_MAX,
      - Value - TEST_BELOW, - Value + TEST_ABOVE) and Result;
  end;
end;

// This validator tests corner case numbers (containing 00, 7F, 80 and FF bytes)
function Validator3(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  BYTES: array[0..3] of Integer = ($00, $7F, $80, $FF);
  PROGRESS_MAX = 256;
var
  I, J, Progress, Value: Integer;
begin
  Progress := 0;
  Result := True;

  for I := 0 to PROGRESS_MAX - 1 do
  begin
    Value := 0;
    for J := 0 to 3 do
      Value := Value or (BYTES[I shr (2 * J) and 3] shl (8 * J));
    Result := ValidateRange(Func, Callback, Progress, PROGRESS_MAX,
      Value, Value) and Result;
  end;
end;

// This validator tests random numbers
function Validator4(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  RUN_COUNT = 1 shl 20;
var
  I, Progress, R: Integer;
begin
  Progress := 0;
  Result := True;

  RandSeed := $01234567;
  for I := 0 to RUN_COUNT - 1 do
  begin
    R := Random32(Low(Integer), High(Integer));
    Result := ValidateRange(Func, Callback, Progress, RUN_COUNT,
      R, R) and Result;
  end;
end;

var
  Validator5MMOrig: TMemoryManager;
  Validator5Addr: Pointer;
  Validator5Size: Integer;

function Validator5FreeMem(P: Pointer): Integer;
begin
  Result := Validator5MMOrig.FreeMem(P);

  if P = Validator5Addr then
  begin
    Validator5Addr := nil;
    Validator5Size := 0;
  end;
end;

function Validator5ReallocMem(P: Pointer; Size: Integer): Pointer;
begin
  Result := Validator5MMOrig.ReallocMem(P, Size);

  if P = Validator5Addr then
  begin
    Validator5Addr := Result;
    Validator5Size := Size;
  end;
end;

function Validator5(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  SIZEOF_STRREC = 8;
var
  I, J, LengthAllocated, Value: Integer;
  MMHooked: TMemoryManager;
  Res: string;
begin
  Result := True;

  GetMemoryManager(Validator5MMOrig);
  try
    MMHooked.FreeMem := Validator5FreeMem;
    MMHooked.GetMem := Validator5MMOrig.GetMem;
    MMHooked.ReallocMem := Validator5ReallocMem;
    SetMemoryManager(MMHooked);

    Value := 1;
    for I := 1 to 10 do
    begin
      if I > 1 then
        Value := Value * 10;

      for J := 1 to 10 do
        try
          SetLength(Res, J);

          Validator5Addr := Pointer(LongWord(Res) - SIZEOF_STRREC);
          Validator5Size := J + SIZEOF_STRREC + 1;
          Res := TIntToStr32Function(Func)(Value);

          LengthAllocated := Validator5Size - SIZEOF_STRREC - 1;
          if (Validator5Size <> 0) and (I xor (LengthAllocated and not 3) > LengthAllocated and 3) then
          begin
            Callback.ReportFailure(DescribeFailureAlloc(I, J, LengthAllocated));
            Result := False;
          end;
        except
          on E: Exception do
          begin
            Callback.ReportFailure(DescribeFailure(I, E));
            Result := False;
          end;
        end;
    end;
  finally
    SetMemoryManager(Validator5MMOrig);
  end;
end;

function Validator6(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  SIZEOF_STRREC = 8;
var
  I, J, K, RefCount, RefCount2, Value: Integer;
  Res, Res2: string;
  Res2Overwritten: Boolean;
begin
  Result := True;
//JOH Added 05-05-2006
  try
    Res := '  ';
    Res := TIntToStr32Function(Func)(0);
  except
    on E: Exception do
    begin
      Callback.ReportFailure(DescribeFailure(0, E));
      Result := False;
      Exit;
    end;
  end;

  Value := 1;
  for I := 1 to 10 do
  begin
    if I > 1 then
      Value := Value * 10;

    for J := 1 to 10 do
      try
        SetLength(Res, J);
        for K := 1 to J do
          Res[K] := #255;
        Res2 := Res;

        Res := TIntToStr32Function(Func)(Value);
//JOH Added 05-05-2006
        if Res <> IntToStr(Value) then
        begin
          Callback.ReportFailure(DescribeFailure(Value, Res));
          Result := False;
        end;

        RefCount := PInteger(LongWord(Res) - SIZEOF_STRREC)^;
        RefCount2 := PInteger(LongWord(Res2) - SIZEOF_STRREC)^;
        if (RefCount <> 1) or (RefCount2 <> 1) then
        begin
          Callback.ReportFailure(DescribeFailureRefCount(Value, RefCount, RefCount2));
          Result := False;
        end;

        Res2Overwritten := Length(Res2) <> J;
        if not Res2Overwritten then
          for K := 1 to J do
            Res2Overwritten := Res2Overwritten or (Res2[K] <> #255);
        if Res2Overwritten then
        begin
          Callback.ReportFailure(DescribeFailureRefCount(Value));
          Result := False;
        end;
      except
        on E: Exception do
        begin
          Callback.ReportFailure(DescribeFailure(I, E));
          Result := False;
        end;
      end;
  end;
end;

// This validator tests the entire integer range, using JOH's validation routine
function Validator7(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  PROGRESS_FREQUENCY = 1 shl 8;
var
  I: Integer;
  IntToStrFunction: TIntToStr32Function;
  Res: string;

 function IsIntToStrValid(I: Integer; const S: string): Boolean;
 var
   CurrDigit: Byte;
   J, K, Len: Integer;
 begin
   Result := False;
   if S = '' then
     Exit;
   Len := PInteger(Integer(S) - 4)^;
   if Len < 2 then
     if (Len < 1) or (S[1] = '-') then
       Exit;
   J := Integer(S[1] = '-');
   if J <> 0 then
     I := -I;
   if (Len - J > 1) and (S[J + 1] = '0') then
     Exit;
   K := 0;
   repeat
     Inc(J);
     CurrDigit := Ord(S[J]) - Ord('0');
     if CurrDigit <= 9 then
       K := (K * 10) + CurrDigit
     else
       Exit;
   until J >= Len;
   Result := K = I;
 end;

begin
  IntToStrFunction := TIntToStr32Function(Func);
  Result := True;

  I := Low(Integer);
  repeat
    if I mod PROGRESS_FREQUENCY = 0 then
      Callback.ReportProgress(LongWord(I - Low(Integer)) shr 8, $01000000);
    try
      Res := IntToStrFunction(I);
      if not IsIntToStrValid(I, Res) then
      begin
        Callback.ReportFailure(DescribeFailure(I, Res));
        Result := False;
      end;
      if Res[Length(Res) + 1] <> #0 then
      begin
        Callback.ReportFailure(DescribeFailureNull(I));
        Result := False;
      end;
    except
      on E: Exception do
      begin
        Callback.ReportFailure(DescribeFailure(I, E));
        Result := False;
      end;
    end;
    Inc(I);
  until I = Low(Integer);
end;

function ChallengeIntToStr32: TFastcodeChallengeIntToStr32;
begin
  if ChallengeObject = nil then
    ChallengeObject := TFastcodeChallengeIntToStr32.RegisterChallenge as TFastcodeChallengeIntToStr32;
  Result := ChallengeObject;
end;

function TFastcodeChallengeIntToStr32.GetBenchmarks: TBenchmarkFunctionArray;
begin
  if Benchmarks = nil then
  begin
    SetLength(Benchmarks, 1);
    Benchmarks[0] := BenchmarkDKC;
  end;
  Result := Benchmarks;
end;

function TFastcodeChallengeIntToStr32.GetName: string;
begin
  Result := 'IntToStr32';
end;

function TFastcodeChallengeIntToStr32.GetValidators: TValidatorFunctionArray;
begin
  if Validators = nil then
  begin
    AddValidator(Validator1);
    AddValidator(Validator2);
    AddValidator(Validator3);
    AddValidator(Validator4);
    AddValidator(Validator5);
    AddValidator(Validator6);
    {$ifdef Int32ValidateThorough}
    AddValidator(Validator7);
    {$endif}
  end;
  Result := Validators;
end;

function TFastcodeChallengeIntToStr32.GetVersion: string;
begin
  Result := CChallengeIntToStr32Version;
end;

initialization
begin
  Win32Check(QueryPerformanceFrequency(PerformanceFrequency));
  InitIntToStrData;

  ChallengeIntToStr32;
end;

end.
