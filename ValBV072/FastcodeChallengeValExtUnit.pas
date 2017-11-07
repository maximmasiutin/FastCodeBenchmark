unit FastcodeChallengeValExtUnit;

interface

{$INCLUDE Version.inc}

{$IFDEF Delphi2005Plus}
  {$WARN UNSAFE_CODE OFF}
  {$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

uses
  Classes, FastcodeChallengeUnit;

type
  TValExtFunction = function(const s: AnsiString; var code: Integer): Extended;

  TFastcodeChallengeValExt = class(TFastcodeChallenge)
  protected
    function GetBenchmarks: TBenchmarkFunctionArray; override;
    function GetName: string; override;
    function GetValidators: TValidatorFunctionArray; override;
    function GetVersion: string; override;
  end;

function ChallengeValExt: TFastcodeChallengeValExt;

implementation

uses
  SysUtils, Windows, Dialogs, Controls, UtilsUnit, Math;

var
  ChallengeObject: TFastcodeChallengeValExt;

function Benchmark1(Func: Pointer; Callback: TFastcodeChallengeCallback): Double;
const
  MIN = -9999;
  MAX = 999999;
  RERUN_COUNT = 5;
  RUNCOUNT = 3;
  ProgressMax = RERUN_COUNT-1;
type
  DataType = array[MIN..MAX] of string;
var
  DurationArray: array[0..RERUN_COUNT - 1] of Int64;
  I1, I, ReRunIndex, J: Integer;
  ValFunction: TValExtFunction;
  TimeEnd, TimeStart, MinTicks: Int64;
  progress, code: integer;
  Data: ^DataType;
  I64: Int64;
begin
  New(Data);
  try
    for I := MIN to MAX do
      begin
        I64 := I;
        Data^[I] := IntToStr(I64*33);
      end;
    Progress := 0;
    ValFunction := TValExtFunction(Func);
    for ReRunIndex := 0 to Length(DurationArray) - 1 do
      begin
        QueryPerformanceCounter(TimeStart);
        for I1 := 1 to RUNCOUNT do
          for I := MIN to MAX do
            begin
              ValFunction(Data^[I], code);
              ValFunction(Data^[I], code);
            end;
        QueryPerformanceCounter(TimeEnd);
        DurationArray[ReRunIndex] := TimeEnd - TimeStart;
        inc(Progress); Callback.ReportProgress(Progress, ProgressMax);
      end;
    MinTicks := DurationArray[0];
    for J := 1 to Length(DurationArray) - 1 do
      if DurationArray[J] < MinTicks then
       MinTicks := DurationArray[J];
    Result := (1000 * MinTicks) / PerformanceFrequency;
  finally
    Dispose(Data);
  end;
end;

function Benchmark2(Func: Pointer; Callback: TFastcodeChallengeCallback): Double;
const
  MIN = -9999;
  MAX = 999999;
  RERUN_COUNT = 5;
  RUNCOUNT = 3;
  ProgressMax = RERUN_COUNT-1;
type
  DataType = array[MIN..MAX] of string;
var
  DurationArray: array[0..RERUN_COUNT - 1] of Int64;
  I1, I, ReRunIndex, J: Integer;
  ValFunction: TValExtFunction;
  TimeEnd, TimeStart, MinTicks: Int64;
  progress, code: integer;
  Data: ^DataType;
  I64: Int64;
begin
  New(Data);
  try
    for I := MIN to MAX do
      begin
        I64 := I;
        Data^[I] := IntToStr(I64*3333333);
      end;
    Progress := 0;
    ValFunction := TValExtFunction(Func);
    for ReRunIndex := 0 to Length(DurationArray) - 1 do
      begin
        QueryPerformanceCounter(TimeStart);
        for I1 := 1 to RUNCOUNT do
          for I := MIN to MAX do
            begin
              ValFunction(Data^[I], code);
              ValFunction(Data^[I], code);
            end;
        QueryPerformanceCounter(TimeEnd);
        DurationArray[ReRunIndex] := TimeEnd - TimeStart;
        inc(Progress); Callback.ReportProgress(Progress, ProgressMax);
      end;
    MinTicks := DurationArray[0];
    for J := 1 to Length(DurationArray) - 1 do
      if DurationArray[J] < MinTicks then
       MinTicks := DurationArray[J];
    Result := (1000 * MinTicks) / PerformanceFrequency;
  finally
    Dispose(Data);
  end;
end;

function Benchmark3(Func: Pointer; Callback: TFastcodeChallengeCallback): Double;
const
  MIN = 0;
  MAX = 999999;
  RERUN_COUNT = 5;
  RUNCOUNT = 3;
  ProgressMax = RERUN_COUNT-1;
type
  DataType = array[MIN..MAX] of string;
var
  DurationArray: array[0..RERUN_COUNT - 1] of Int64;
  I1, I, ReRunIndex, J: Integer;
  ValFunction: TValExtFunction;
  TimeEnd, TimeStart, MinTicks: Int64;
  progress, code: integer;
  Data: ^DataType;
  E: Extended;
begin
  New(Data);
  try
    E := 1.0005;
    for I := MIN to MAX do
      begin
        E := E * 1.0005;
        Data^[I] := FloatToStr(E);
      end;
    Progress := 0;
    ValFunction := TValExtFunction(Func);
    for ReRunIndex := 0 to Length(DurationArray) - 1 do
      begin
        QueryPerformanceCounter(TimeStart);
        for I1 := 1 to RUNCOUNT do
          for I := MIN to MAX do
            begin
              ValFunction(Data^[I], code);
              ValFunction(Data^[I], code);
            end;
        QueryPerformanceCounter(TimeEnd);
        DurationArray[ReRunIndex] := TimeEnd - TimeStart;
        inc(Progress); Callback.ReportProgress(Progress, ProgressMax);
      end;
    MinTicks := DurationArray[0];
    for J := 1 to Length(DurationArray) - 1 do
      if DurationArray[J] < MinTicks then
       MinTicks := DurationArray[J];
    Result := (500 * MinTicks) / PerformanceFrequency;
  finally
    Dispose(Data);
  end;
end;

procedure DebugFailure(Func: Pointer; ErrorMsg, Value: string);
var
  Code: Integer;
begin
  if BreakOnFailure then
    begin
      case MessageDlg(ErrorMsg + #13#10#13#10 + 'Debug this Function Call?',
                      mtError, [mbYes, mbNo, mbNoToAll], 0) of
        mrYes    : begin
                     asm int 3 end; {Force Break}
                     TValExtFunction(Func)(Value, Code);
                   end;
        MrNoToAll: BreakOnFailure := false;
      end;
    end;
end;

function DescribeFailureCode(Func: Pointer; Value: string; const code: integer): string;
begin
  Result := Format('Val(''%s'') returned Code %d', [Value, code]);
  DebugFailure(Func, Result, Value);
end;

function DescribeFailureValue(Func: Pointer; Value: string; const Res: Extended): string;
begin
  Result := Format('Val(''%s'') returned Value %e', [Value, Res]);
  DebugFailure(Func, Result, Value);
end;

// This validator tests that the Error Code is set correctly
// and, where the error code <> 0, that the correct Value is returned
function Validator1(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  ProgressMax = 10;
var
  I, Progress: Integer;
  S: string;
  Ch: Char;
  I64: Int64;

  procedure Validate(S: string; ExpectedResult: Extended; ExpectedCode: Integer);
  var
    Res: Extended;
    Code: Integer;
  begin
    Res := TValExtFunction(Func)(S, code);
    if (code <> ExpectedCode) then
      begin
        Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
        Result := False;
      end;
    if Res <> ExpectedResult then
      if not SameValue(Res, ExpectedResult, ExpectedResult/1e14) then
        begin
          Callback.ReportFailure(DescribeFailureValue(Func, S, Res));
          Result := False;
        end;
  end;

begin
  Progress := 0;
  Result := True;

  Validate('', 0, 1);
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  S := '';
  for I := 2 to 20 do
    begin
      S := S + ' ';
      Validate(S, 0, I);
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for Ch := #0 to #255 do
    if not (Ch in [' ','0'..'9', '+', '-', 'e', 'E']) then
      begin
        S := Ch;
        Validate(S, 0, 1);
      end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for Ch := #0 to #255 do
    if not (Ch in [' ','0'..'9', '+', '-', 'e', 'E']) then
      begin
        S := ' ' + Ch;
        Validate(S, 0, 2);
      end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  S := '.';
  Validate(S, 0, 1);

  S := '..';
  Validate(S, 0, 2);

  S := ' .';
  Validate(S, 0, 2);

  S := '.1';
  Validate(S, 0.1, 0);

  S := '0.';
  Validate(S, 0, 0);

  S := '1.';
  Validate(S, 1, 0);

  S := '+';
  Validate(S, 0, 2);

  S := '-';
  Validate(S, 0, 2);

  S := '9999999999999999';
  Validate(S, 9999999999999999, 0);
  S := '-9999999999999999';
  Validate(S, -9999999999999999, 0);

  I64 := MaxInt;
  S := IntToStr(I64);
  Validate(S, I64, 0);

  I64 := MaxInt;
  inc(I64);
  S := IntToStr(I64);
  Validate(S, I64, 0);

  I64 := MaxInt;
  inc(I64, 2);
  S := IntToStr(I64);
  Validate(S, I64, 0);

  I64 := -MaxInt;
  S := IntToStr(I64);
  Validate(S, I64, 0);

  I64 := -MaxInt;
  dec(I64);
  S := IntToStr(I64);
  Validate(S, I64, 0);

  I64 := -MaxInt;
  dec(I64, 2);
  S := IntToStr(I64);
  Validate(S, I64, 0);
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to 999 do
    begin
      S := IntToStr(I) + ' ';
      Validate(S, I, Length(S));
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to 999 do
    begin
      S := IntToStr(I) + 'z';
      Validate(S, I, Length(S));
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to 999 do
    begin
      S := IntToStr(I) + '  ';
      Validate(S, I, Length(S)-1);
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to 999 do
    begin
      S := IntToStr(I) + 'zz';
      Validate(S, I, Length(S)-1);
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  S := 'e0';
  Validate(S, 0, 0);

  S := '1e';
  Validate(S, 1, 3);

  S := 'ex';
  Validate(S, 0, 2);

  S := '1e0';
  Validate(S, 1, 0);

  S := '1e1';
  Validate(S, 10, 0);

  S := '1eX';
  Validate(S, 1, 3);

  S := 'ee';
  Validate(S, 0, 2);

  S := '123456789012345678901234567890';
  Validate(S, 12345678901234567890123456789e1, 0);

  S := '-123456789012345678901234567890';
  Validate(S, -12345678901234567890123456789e1, 0);

  S := '123456789012345678901234567890x';
  Validate(S, 12345678901234567890123456789e1, Length(S));

  S := '-123456789012345678901234567890x';
  Validate(S, -12345678901234567890123456789e1, Length(S));

  S := '+';
  Validate(S, 0, 2);

  S := '-';
  Validate(S, 0, 2);

  S := '++';
  Validate(S, 0, 2);

  S := '--';
  Validate(S, 0, 2);

  S := '+-';
  Validate(S, 0, 2);

  S := '-+';
  Validate(S, 0, 2);

  S := '++1';
  Validate(S, 0, 2);

  S := '--1';
  Validate(S, 0, 2);

  S := '+-1';
  Validate(S, 0, 2);

  S := '-+1';
  Validate(S, 0, 2);

  S := '+e';
  Validate(S, 0, 3);

  S := '-e';
  Validate(S, 0, 3);

  S := '+e+1';
  Validate(S, 0, 0);

  S := '-e+1';
  Validate(S, 0, 0);

  S := '+e-1';
  Validate(S, 0, 0);

  S := '-e-1';
  Validate(S, 0, 0);

  S := '+e++1';
  Validate(S, 0, 4);

  S := '+e+-1';
  Validate(S, 0, 4);

  S := '+e 1';
  Validate(S, 0, 3);

  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  S := '-1x';
  Validate(S, -1, 3);

  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

end;

function Validator2(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  ProgressMax = 8;
var
  Progress: Integer;
  I, Code: Integer;
  Res: Extended;
  S: string;
  I64: Int64;
  E: Extended;
begin
  Result := True;
  Progress := 0;

  for I := -99999 to +99999 do
    begin
      S := IntToStr(I);
      Res := TValExtFunction(Func)(S,code);
      if Code <> 0 then
        begin
          Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
          Result := False;
        end;
      if (Res <> I)  then
        begin
          Callback.ReportFailure(DescribeFailureValue(Func, S, Res));
          Result := False;
        end;
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := -99999 to +99999 do
    begin
      S := '  ' + IntToStr(I);
      Res := TValExtFunction(Func)(S,code);
      if Code <> 0 then
        begin
          Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
          Result := False;
        end;
      if (Res <> I)  then
        begin
          Callback.ReportFailure(DescribeFailureValue(Func, S, Res));
          Result := False;
        end;
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  I64 := MaxInt;
  for I := 1 to 99999 do
    begin
      Inc(I64);
      S := IntToStr(I64);
      TValExtFunction(Func)(S,code);
      if (Code <> 0) then
        begin
          Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
          Result := False;
        end;
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  I64 := MaxInt;
  for I := 1 to 99999 do
    begin
      Dec(I64);
      S := IntToStr(I64);
      Res := TValExtFunction(Func)(S,code);
      if (Code <> 0) then
        begin
          Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
          Result := False;
        end;
      if (Res <> I64)  then
        begin
          Callback.ReportFailure(DescribeFailureValue(Func, S, Res));
          Result := False;
        end;
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  I64 := -MaxInt;
  Dec(I64);
  for I := 1 to 99999 do
    begin
      Inc(I64);
      S := IntToStr(I64);
      Res := TValExtFunction(Func)(S,code);
      if (Code <> 0) then
        begin
          Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
          Result := False;
        end;
      if (Res <> I64)  then
        begin
          Callback.ReportFailure(DescribeFailureValue(Func, S, Res));
          Result := False;
        end;
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  I64 := -MaxInt;
  Dec(I64);
  for I := 1 to 99999 do
    begin
      Dec(I64);
      S := IntToStr(I64);
      TValExtFunction(Func)(S,code);
      if (Code <> 0) then
        begin
          Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
          Result := False;
        end;
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  E := 1.0001;
  for I := 1 to 9999 do
    begin
      E := E*1.0001;
      S := FloatToStr(E);
      TValExtFunction(Func)(S,code);
      if (Code <> 0) then
        begin
          Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
          Result := False;
        end;
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

end;

function Validator3(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  MAX = 999999;
  ProgressMax = MAX div 64;
var
  I: Integer;
  ValFunction: TValExtFunction;
  progress, code: integer;
  E1, E2: Extended;
  S: string;
begin
  Result := True;
  E1 := 1.001;
  Progress := 0;
  ValFunction := TValExtFunction(Func);
  for I := 0 to MAX do
    begin
      E1 := E1 * 1.001;
      S := FloatToStr(E1);
      E2 := ValFunction(S, code);
      if (Code <> 0) then
        begin
          Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
          Result := False;
        end;
      if not SameValue(E1, E2, E1/1e14) then
        begin {Loss of Precision is too Large}
          Callback.ReportFailure(DescribeFailureValue(Func, S, E2));
          Result := False;
        end;
      if I mod 64 = 0 then
        begin
          inc(Progress); Callback.ReportProgress(Progress, ProgressMax);
        end;
    end;
end;

// This validator tests Basic PChar Strings
function Validator4(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
var
  P: PChar;

  procedure Validate(S: PChar; ExpectedResult: Extended; ExpectedCode: Integer);
  var
    Res: Extended;
    Code: Integer;
  begin
    Res := TValExtFunction(Func)(S, code);
    if (code <> ExpectedCode) then
      begin
        Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
        TValExtFunction(Func)(S, code);
        Result := False;
      end;
    if Res <> ExpectedResult then
      if not SameValue(Res, ExpectedResult, ExpectedResult/1e14) then
        begin
          Callback.ReportFailure(DescribeFailureValue(Func, S, Res));
          TValExtFunction(Func)(S, code);
          Result := False;
        end;
  end;

begin
  Result := True;

  P := '';
  Validate(P, 0, 1);

  P := ' ';
  Validate(P, 0, 2);

  P := '0';
  Validate(P, 0, 0);
end;

// This validator tests handling of non-nil zero-length strings
var
  GlobalStr: AnsiString;

function Validator5(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
var
  Res: Extended;
  Code: Integer;
begin
  GlobalStr := #0;
  PInteger(Integer(GlobalStr)-4)^ := 0; {Force Length to 0}
  Res := TValExtFunction(Func)(GlobalStr, code);
  Result := (Res=0) and (Code=1);
  if not Result then
    Callback.ReportFailure('Failed to Handle zero-length non-nil String');
end;

// This validator tests that memory before the 1st Char of PChar is not accessed
// (ie. Checks function does not access AnsiString Length or RefCount)
function Validator6(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  PAGE_SIZE  = 4096;
  S_LEN      = 5;
  FailMessge = 'Accessed Memory before Start of PChar';
var
  S: PChar;
  I, Code: Integer;
  MemBlock, Page1: Pointer;
  Page2, Dummy: Cardinal;
begin
  GetMem(MemBlock, PAGE_SIZE * 3);
  try
    Result := False;
    Page1  := Pointer((Cardinal(MemBlock) or (PAGE_SIZE-1))+1);
    Page2  := Cardinal(Page1) + PAGE_SIZE;
    {Create Fake PChar String, such that First Char is at Start of Page 2}
    S := PChar(Page2);
    for I := 0 to S_LEN-1 do {Set PChar to '01234'}
      PChar(Page2 + Cardinal(I))^ := Char((I+Ord('0')) and $FF);
    try {Lock First Page}
      Win32Check(VirtualProtect(Page1, PAGE_SIZE, PAGE_NOACCESS, Dummy));
      try
        Result := True;
        asm {Call Val Function without using @LStrFromPChar Call}
          mov  eax, S
          lea  edx, code
          call TValExtFunction(Func)
          ffree st(0) {Dump Result}
        end;
      except
        Result := False;
        Callback.ReportFailure(FailMessge);
        if BreakOnFailure then
          begin
            case MessageDlg(FailMessge + #13#10#13#10 + 'Debug this Function Call?',
                            mtError, [mbYes, mbNo, mbNoToAll], 0) of
              mrYes    : begin
                           try
                             asm
                               mov  eax, S
                               lea  edx, code
                               int  3
                               call TValExtFunction(Func)
                               ffree st(0) {Dump Result}
                             end;
                           except
                           end;
                         end;
              MrNoToAll: BreakOnFailure := false;
            end;
          end;
      end;
    finally {Unlock First Page}
      Win32Check(VirtualProtect(Page1, PAGE_SIZE, PAGE_EXECUTE_READWRITE, Dummy));
    end;
  finally
    FreeMem(MemBlock);
  end;
end;

// This validator tests that the next page after the Last Char is not accessed
function Validator7(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  PAGE_SIZE  = 4096;
  S_LEN      = 7;
  FailMessge = 'Accessed Page after End of PChar';
var
  S: PChar;
  I, Code: Integer;
  MemBlock, Page1: Pointer;
  Page2: Pointer;
  Dummy: Cardinal;
begin
  GetMem(MemBlock, PAGE_SIZE * 3);
  try
    Result := False;
    Page1  := Pointer((Cardinal(MemBlock) or (PAGE_SIZE-1))+1);
    Page2  := Pointer(Cardinal(Page1) + PAGE_SIZE);
    {Create Fake PChar String, such that terminator is at End of Page 1}
    S := PChar(Cardinal(Page2) - S_LEN - 1);
    for I := 0 to S_LEN-1 do {Set PChar to '0123456'}
      PChar(Cardinal(Page2) - S_LEN - 1 + Cardinal(I))^ := Char((I+Ord('0')) and $FF);
    PChar(Cardinal(Page2) - 1)^ := #0;
    try {Lock Second Page}
      Win32Check(VirtualProtect(Page2, PAGE_SIZE, PAGE_NOACCESS, Dummy));
      try
        Result := True;
        asm {Call Val Function without using @LStrFromPChar Call}
          mov  eax, S
          lea  edx, code
          call TValExtFunction(Func)
          ffree st(0) {Dump Result}
        end;
      except
        Result := False;
        Callback.ReportFailure(FailMessge);
        if BreakOnFailure then
          begin
            case MessageDlg(FailMessge + #13#10#13#10 + 'Debug this Function Call?',
                            mtError, [mbYes, mbNo, mbNoToAll], 0) of
              mrYes    : begin
                           try
                             asm
                               mov  eax, S
                               lea  edx, code
                               int  3
                               call TValExtFunction(Func)
                               ffree st(0) {Dump Result}
                             end;
                           except
                           end;
                         end;
              MrNoToAll: BreakOnFailure := false;
            end;
          end;
      end;
    finally {Unlock Second Page}
      Win32Check(VirtualProtect(Page2, PAGE_SIZE, PAGE_EXECUTE_READWRITE, Dummy));
    end;
  finally
    FreeMem(MemBlock);
  end;
end;

function ChallengeValExt: TFastcodeChallengeValExt;
begin
  if ChallengeObject = nil then
    ChallengeObject := TFastcodeChallengeValExt.RegisterChallenge as TFastcodeChallengeValExt;
  Result := ChallengeObject;
end;

function TFastcodeChallengeValExt.GetName: string;
begin
  Result := 'ValExt';
end;

function TFastcodeChallengeValExt.GetBenchmarks: TBenchmarkFunctionArray;
begin
  if Benchmarks = nil then
    begin
      AddBenchmark(Benchmark1);
      AddBenchmark(Benchmark2);
      AddBenchmark(Benchmark3);
    end;
  Result := Benchmarks;
end;

function TFastcodeChallengeValExt.GetValidators: TValidatorFunctionArray;
begin
  if Validators = nil then
    begin
      AddValidator(Validator1);
      AddValidator(Validator2);
      AddValidator(Validator3);
      AddValidator(Validator4);
      AddValidator(Validator5);
      AddValidator(Validator6);
      AddValidator(Validator7);
    end;
  Result := Validators;
end;

function TFastcodeChallengeValExt.GetVersion: string;
begin
  Result := '0.7.2';
end;

initialization
  ChallengeValExt;
end.
