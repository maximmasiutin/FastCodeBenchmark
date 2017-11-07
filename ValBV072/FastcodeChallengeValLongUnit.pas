unit FastcodeChallengeValLongUnit;

interface

{$INCLUDE Version.inc}

{$IFDEF Delphi2005Plus}
  {$WARN UNSAFE_CODE OFF}
  {$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

uses
  Classes, FastcodeChallengeUnit;

type
  TValLongFunction = function(const s: AnsiString; var code: Integer): Longint;

  TFastcodeChallengeValLong = class(TFastcodeChallenge)
  protected
    function GetBenchmarks: TBenchmarkFunctionArray; override;
    function GetName: string; override;
    function GetValidators: TValidatorFunctionArray; override;
    function GetVersion: string; override;
  end;

function ChallengeValLong: TFastcodeChallengeValLong;

implementation

uses
  Windows, Dialogs, Controls, SysUtils, UtilsUnit;

var
  ChallengeObject: TFastcodeChallengeValLong;

function Benchmark1(Func: Pointer; Callback: TFastcodeChallengeCallback): Double;
const
  MIN = -99999;
  MAX = 999999;
  RERUN_COUNT = 5;
  RUNCOUNT = 3;
  ProgressMax = RERUN_COUNT-1;
type
  DataType = array[MIN..MAX] of string;
var
  DurationArray: array[0..RERUN_COUNT - 1] of Int64;
  I1, I, ReRunIndex, J: Integer;
  ValFunction: TValLongFunction;
  TimeEnd, TimeStart, MinTicks: Int64;
  progress, code: integer;
  Data: ^DataType;
begin
  New(Data);
  try
    for I := MIN to MAX do
      Data^[I] := IntToStr(I*3);
    Progress := 0;
    ValFunction := TValLongFunction(Func);
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
  MIN = -99999;
  MAX = 999999;
  RERUN_COUNT = 5;
  RUNCOUNT = 3;
  ProgressMax = RERUN_COUNT-1;
type
  DataType = array[MIN..MAX] of string;
var
  DurationArray: array[0..RERUN_COUNT - 1] of Int64;
  I1, I, ReRunIndex, J: Integer;
  ValFunction: TValLongFunction;
  TimeEnd, TimeStart, MinTicks: Int64;
  progress, code: integer;
  Data: ^DataType;
begin
  New(Data);
  try
    for I := MIN to MAX do
      begin
        case I mod 5 of
          0   : Data^[I] := '$'  + IntToHex(I*3,0);
          1,-1: Data^[I] := '0x' + IntToHex(I*3,0);
          2,-2: Data^[I] := '0X' + IntToHex(I*3,0);
          3,-3: Data^[I] := 'x'  + IntToHex(I*3,0);
          4,-4: Data^[I] := 'X'  + IntToHex(I*3,0);
        end;
      end;
    Progress := 0;
    ValFunction := TValLongFunction(Func);
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
                     TValLongFunction(Func)(Value, Code);
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

function DescribeFailureValue(Func: Pointer; Value: string; const Res: LongInt): string;
begin
  Result := Format('Val(''%s'') returned Value %d', [Value, Res]);
  DebugFailure(Func, Result, Value);
end;

// This validator tests that the Error Code is set correctly
// and, where the error code <> 0, that the correct Value is returned
function Validator1(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  ProgressMax = 24;
var
  I, Progress: Integer;
  S: string;
  Ch: Char;
  I64: Int64;

  procedure Validate(S: string; ExpectedResult: Integer; ExpectedCode: Integer);
  var
    Res, Code: Integer;
  begin
    Res := TValLongFunction(Func)(S, code);
    if (code <> ExpectedCode) then
      begin
        Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
        Result := False;
      end;
    if (Res <> ExpectedResult) then
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

  for Ch := #0 to #255 do
    if not (Ch in [' ','0'..'9', '$', '+', '-', 'x', 'X']) then
      begin
        S := Ch;
        Validate(S, 0, 1);
      end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  S := '';
  for I := 2 to 20 do
    begin
      S := S + ' ';
      Validate(S, 0, I);
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for Ch := #0 to #255 do
    if not (Ch in [' ','0'..'9', '$', '+', '-', 'x', 'X']) then
      begin
        S := ' ' + Ch;
        Validate(S, 0, 2);
      end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  Validate('0000', 0, 0);

  Validate('+', 0, 2);
  Validate('-', 0, 2);
  Validate('x', 0, 2);
  Validate('X', 0, 2);
  Validate('$ ', 0, 2);

  Validate('1x', 1, 2);
  Validate('0x', 0, 3);        //RTL Fails this
  Validate('0X', 0, 3);        //RTL Fails this
  Validate(' 0x', 0, 4);
  Validate(' 0X', 0, 4);

  Validate('x1', 1, 0);
  Validate('xe', 14, 0);

  Validate('$$', 0, 2);
  Validate('$+', 0, 2);
  Validate('$-', 0, 2);
  Validate('$0', 0, 0);
  Validate('$g', 0, 2);
  Validate('$x', 0, 2);
  Validate('$x0', 0, 2);

  Validate('00x', 0, 3);
  Validate('0x0', 0, 0);
  Validate('0X0', 0, 0);
  Validate('0xx', 0, 3);
  Validate('0x ', 0, 3);
  Validate('0Xx', 0, 3);
  Validate('0x0x', 0, 4);
  Validate('0x0X', 0, 4);
  Validate('0x0x0', 0, 4);
  Validate('0X0X0', 0, 4);

  Validate('$a', 10, 0);
  Validate('$A', 10, 0);
  Validate('$f', 15, 0);
  Validate('$F', 15, 0);
  Validate('$g', 0, 2);
  Validate('$G', 0, 2);
  Validate('$?', 0, 2);

  Validate('++', 0, 2);
  Validate('--', 0, 2);
  Validate('+-', 0, 2);
  Validate('-+', 0, 2);
  Validate('+ ', 0, 2);
  Validate('- ', 0, 2);

  Validate('+$', 0, 3);        //RTL Fails this
  Validate('-$', 0, 3);        //RTL Fails this

  Validate('0'#0#0, 0, 0);

  Validate('-1x', -1, 3);

  Validate('123'#0'456', 123, 0);

  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  S := '000000000012345678';
  Validate(S, 12345678, 0);

  S := '$000000000012345678';
  Validate(S, $12345678, 0);

  S := '$2000000000000000';
  Validate(S, $20000000, 10);

  S := '9999999999999999';
  Validate(S, 999999999, 10);
  S := '-9999999999999999';
  Validate(S, -999999999, 11);

  I64 := MaxInt;
  S := IntToStr(I64);
  Validate(S, I64, 0);

  I64 := MaxInt;
  inc(I64);
  S := IntToStr(I64);
  Validate(S, I64, Length(S));   //RTL Fails this

  I64 := MaxInt;
  inc(I64, 2);
  S := IntToStr(I64);
  Validate(S, I64, Length(S));   //RTL Fails this
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

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
  Validate(S, I64, Length(S));   //RTL Fails this
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

  Validate('$FFFFFFFF', -1, 0);
  Validate('$FFFFFFFFF' , -1 ,10);
  Validate('-$FFFFFFFF', 1, 0);
  Validate('-$FFFFFFFFF', 1, 11);

  Validate('$F FFFFFFF', $F, 3);

  for I := 0 to $FFFF do
    begin
      S := '$' + InttoHex(I,0);
      Validate(S, I, 0);
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '$' + InttoHex(I,8);
      Validate(S, I, 0);
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '$' + InttoHex(I,0) + ' ';
      Validate(S, I, Length(S));
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '$' + InttoHex(I,0) + 'z';
      Validate(S, I, Length(S));
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '$' + InttoHex(I,0) + '  ';
      Validate(S, I, Length(S)-1);
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '$' + InttoHex(I,0) + 'zz';
      Validate(S, I, Length(S)-1);
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '0x' + InttoHex(I,0);
      Validate(S, I, 0);
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '0x' + InttoHex(I,8);
      Validate(S, I, 0);
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '0x' + InttoHex(I,0) + ' ';
      Validate(S, I, Length(S));
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '0x' + InttoHex(I,0) + 'z';
      Validate(S, I, Length(S));
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '0x' + InttoHex(I,0) + '  ';
      Validate(S, I, Length(S)-1);
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '0x' + InttoHex(I,0) + 'zz';
      Validate(S, I, Length(S)-1);
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  S := '-1x';
  Validate(S, -1, 3);

  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

end;

// This validator tests for correct conversion of valid input strings
function Validator2(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  ProgressMax = 8;
var
  Progress: Integer;
  I, Code, Res: Integer;
  S: string;
  I64: Int64;
begin
  Result := True;
  Progress := 0;

  for I := -99999 to +99999 do
    begin
      S := IntToStr(I);
      Res := TValLongFunction(Func)(S,code);
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
      Res := TValLongFunction(Func)(S,code);
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
      S := '$' + IntToHex(I, 0);
      Res := TValLongFunction(Func)(S,code);
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
      S := '-$' + IntToHex(I, 0);
      Res := TValLongFunction(Func)(S,code);
      if Code <> 0 then
        begin
          Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
          Result := False;
        end;
      if (Res <> -I)  then
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
      TValLongFunction(Func)(S,code);
      if (Code <> 10) then
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
      Res := TValLongFunction(Func)(S,code);
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
      Res := TValLongFunction(Func)(S,code);
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
      TValLongFunction(Func)(S,code);
      if (Code <> 11) then
        begin
          Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
          Result := False;
        end;
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

end;

// This validator tests Decimal conversions
function Validator3(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  Step = 9999;
  ProgressMax = 2 * (MaxInt div Step);
var
  I, Code, Res, Progress: Integer;
  S: string;
begin
  Result := True;
  Progress := 0;
  I := -MaxInt;
  while I < MaxInt-Step do
    begin
      S := IntToStr(I);
      Res := TValLongFunction(Func)(S,code);
      if (Res <> I) or (Code <> 0) then
        begin
          Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
          Result := False;
        end;
      inc(I, Step);
      inc(Progress);
      if progress mod 16 = 0 then
        Callback.ReportProgress(Progress, ProgressMax);
    end;
end;

// This validator tests Hex conversions
function Validator4(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  Step = 9999;
  ProgressMax = 2 * (MaxInt div Step);
var
  I, Code, Res, Progress: Integer;
  S: string;
begin
  Result := True;
  Progress := 0;
  I := -MaxInt;
  while I < MaxInt-Step do
    begin
      S := '$' + IntToHex(I,0);
      Res := TValLongFunction(Func)(S,code);
      if (Code <> 0) then
        begin
          Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
          Result := False;
        end;
      if (Res <> I) then
        begin
          Callback.ReportFailure(DescribeFailureValue(Func, S, Res));
          Result := False;
        end;
      S := Lowercase(S);
      Res := TValLongFunction(Func)(S,code);
      if (Code <> 0) then
        begin
          Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
          Result := False;
        end;
      if (Res <> I) then
        begin
          Callback.ReportFailure(DescribeFailureValue(Func, S, Res));
          Result := False;
        end;
      inc(I, Step);
      inc(Progress);
      if progress mod 16 = 0 then
        Callback.ReportProgress(Progress, ProgressMax);
    end;

end;

// This validator tests Basic PChar Strings
function Validator5(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
var
  P: PChar;

  procedure ValidateCode(P: PChar; ExpectedCode: Integer);
  var
    Code: Integer;
  begin
    TValLongFunction(Func)(P, code);
    if (code <> ExpectedCode) then
      begin
        Callback.ReportFailure(DescribeFailureCode(Func, P, Code));
        TValLongFunction(Func)(P, code);
        Result := False;
      end;
  end;

begin
  Result := True;

  P := '';
  ValidateCode(P, 1);

  P := ' ';
  ValidateCode(P, 2);

  P := '0';
  ValidateCode(P, 0);
end;

// This validator tests handling of non-nil zero-length strings
var
  GlobalStr: AnsiString;

function Validator6(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
var
  Res, Code: Integer;
begin
  GlobalStr := #0;
  PInteger(Integer(GlobalStr)-4)^ := 0; {Force Length to 0}
  Res := TValLongFunction(Func)(GlobalStr, code);
  Result := (Res=0) and (Code=1);
  if not Result then
    Callback.ReportFailure('Failed to Handle zero-length non-nil String');
end;

// This validator tests that memory before the first Char is not accessed
// (ie. Checks function does not access AnsiString Length or RefCount)
function Validator7(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
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
          call TValLongFunction(Func)
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
                               call TValLongFunction(Func)
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
function Validator8(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
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
          call TValLongFunction(Func)
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
                               call TValLongFunction(Func)
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

// This validator tests the whole Integer range (Decimal)
function Validator9(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  ProgressMax = (MaxInt div 10000) * 2;
var
  Lookup: packed array[0..9999] of array[1..4] of Char; {'0000'..'9999'}
  I, Max, Min, M, Code, Res, Progress: Integer;
  S: string;
  P: PInteger;

  procedure SetupLookup;
  var
    I: integer;
    S: string;
  begin
    for I := 0 to 9999 do
      begin
        S := IntToStr(I);
        if Length(S) = 1 then
          S := '000' + S
        else
          if Length(S) = 2 then
            S := '00' + S
          else
            if Length(S) = 3 then
              S := '0' + S;
        Move(S[1], Lookup[I], 4);
      end;
  end;

begin
  Result := True;
  Progress := 0;
  SetupLookup;

  I := -10000; {test -10000..+10000}
  repeat
    S := IntToStr(I);
    Res := TValLongFunction(Func)(S,code);
    if (Res <> I) or (Code <> 0) then
      begin
        Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
        Result := False;
        Exit;
      end;
    Inc(I);
  until I > 10000;

  I := MaxInt; {Test Last MaxInt MOD 10000}
  repeat
    S := IntToStr(I);
    Res := TValLongFunction(Func)(S,code);
    if (Res <> I) or (Code <> 0) then
      begin
        Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
        Result := False;
        Exit;
      end;
    Dec(I);
  until I mod 10000 = 0;
  S := IntToStr(I);
  Res := TValLongFunction(Func)(S,code);
  if (Res <> I) or (Code <> 0) then
    begin
      Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
      Result := False;
      Exit;
    end;
  Max := I;

  I := -MaxInt-1; {Test Last MinInt MOD 10000}
  repeat
    S := IntToStr(I);
    Res := TValLongFunction(Func)(S,code);
    if (Res <> I) or (Code <> 0) then
      begin
        Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
        Result := False;
        Exit;
      end;
    Inc(I);
  until I mod 10000 = 0;
  S := IntToStr(I);
  Res := TValLongFunction(Func)(S,code);
  if (Res <> I) or (Code <> 0) then
    begin
      Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
      Result := False;
      Exit;
    end;
  Min := I;

  I := 10000;
  while I < Max do {Test All Positive Values}
    begin
      S := IntToStr(I);
      P := @S[Length(S)-3];
      for M := 0 to 9999 do
        begin
          P^ := Pinteger(@Lookup[M])^; {Set Last 4 Digits in S}
          Res := TValLongFunction(Func)(S,code);
          if (Code <> 0) then         
            begin
              Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
              Result := False;
              Exit;
            end;
          if (Res <> I+M) then
            begin
              Callback.ReportFailure(DescribeFailureValue(Func, S, Res));
              Result := False;
              Exit;
            end;
        end;
      inc(I,10000);
      inc(Progress);
      Callback.ReportProgress(Progress, ProgressMax);
    end;

  I := -10000;
  while I > Min do {Test All Negative Values}
    begin
      S := IntToStr(I); 
      P := @S[Length(S)-3];
      for M := 0 to 9999 do
        begin
          P^ := Pinteger(@Lookup[M])^; {Set Last 4 Digits in S}
          Res := TValLongFunction(Func)(S,code);
          if (Code <> 0) then
            begin
              Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
              Result := False;
              Exit;
            end;
          if (Res <> I-M) then
            begin
              Callback.ReportFailure(DescribeFailureValue(Func, S, Res));
              Result := False;
              Exit;
            end;
        end;
      dec(I,10000);
      inc(Progress);
      Callback.ReportProgress(Progress, ProgressMax);
    end;

end;

// This validator tests the whole Integer range (Hex)
function Validator10(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  ProgressMax = (MaxInt div $10000) * 2;
var
  Lookup: array[0..$FFFF] of array[1..4] of Char; {'0000'..'FFFF'}
  I, J, K, Code, Res, Progress: Integer;
  S: string;
  P1, P2: PInteger;

  procedure SetupLookup;
  var
    I: integer;
    S: string;
  begin
    for I := 0 to $FFFF do
      begin
        S := IntToHex(I,4);
        Move(S[1], Lookup[I], 4);
      end;
  end;

begin
  Result := True;
  Progress := 0;
  SetupLookup;
  S  := '$00000000';
  P1 := @S[2];
  P2 := @S[6];
  for I := 0 to $FFFF do
    begin
      P1^ := Pinteger(@Lookup[I])^; {Set First 4 Chars in S}
      K := I shl 16;
      for J := 0 to $FFFF do
        begin
          P2^ := Pinteger(@Lookup[J])^; {Set Last 4 Chars in S}
          Res := TValLongFunction(Func)(S,code);
          if (Code <> 0) then
            begin
              Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
              Result := False;
              Exit;
            end;
          if (Res <> J+K) then
            begin
              Callback.ReportFailure(DescribeFailureValue(Func, S, Res));
              Result := False;
              Exit;
            end;
        end;
      inc(Progress);
      Callback.ReportProgress(Progress, ProgressMax);
    end;
end;

function ChallengeValLong: TFastcodeChallengeValLong;
begin
  if ChallengeObject = nil then
    ChallengeObject := TFastcodeChallengeValLong.RegisterChallenge as TFastcodeChallengeValLong;
  Result := ChallengeObject;
end;

function TFastcodeChallengeValLong.GetName: string;
begin
  Result := 'ValLong';
end;

function TFastcodeChallengeValLong.GetBenchmarks: TBenchmarkFunctionArray;
begin
  if Benchmarks = nil then
    begin
      AddBenchmark(Benchmark1);
      AddBenchmark(Benchmark2);
    end;
  Result := Benchmarks;
end;

function TFastcodeChallengeValLong.GetValidators: TValidatorFunctionArray;
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
      AddValidator(Validator8);
      AddValidator(Validator9);
      AddValidator(Validator10);
    end;
  Result := Validators;
end;

function TFastcodeChallengeValLong.GetVersion: string;
begin
  Result := '0.7.2';
end;

initialization
  ChallengeValLong;
end.
