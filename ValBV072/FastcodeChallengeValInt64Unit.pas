unit FastcodeChallengeValInt64Unit;

interface

{$INCLUDE Version.inc}

{$IFDEF Delphi2005Plus}
  {$WARN UNSAFE_CODE OFF}
  {$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

{$R-,Q-}

uses
  Classes, FastcodeChallengeUnit;

type
  TValInt64Function = function(const s: AnsiString; var code: Integer): Int64;

  TFastcodeChallengeValInt64 = class(TFastcodeChallenge)
  protected
    function GetBenchmarks: TBenchmarkFunctionArray; override;
    function GetName: string; override;
    function GetValidators: TValidatorFunctionArray; override;
    function GetVersion: string; override;
  end;

function ChallengeValInt64: TFastcodeChallengeValInt64;

implementation

uses
  SysUtils, Windows, Dialogs, Controls, UtilsUnit;

var
  ChallengeObject: TFastcodeChallengeValInt64;

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
  ValFunction: TValInt64Function;
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
    ValFunction := TValInt64Function(Func);
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
  ValFunction: TValInt64Function;
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
        case I mod 5 of
          0: Data^[I] := '$'  + IntToHex(I64*3333333,0);
          1,-1: Data^[I] := '0x' + IntToHex(I64*3333333,0);
          2,-2: Data^[I] := '0X' + IntToHex(I64*3333333,0);
          3,-3: Data^[I] := 'x'  + IntToHex(I64*3333333,0);
          4,-4: Data^[I] := 'X'  + IntToHex(I64*3333333,0);
        end;
      end;
    Progress := 0;
    ValFunction := TValInt64Function(Func);
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
                     TValInt64Function(Func)(Value, Code);
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

function DescribeFailureValue(Func: Pointer; Value: string; const Res: Int64): string;
begin
  Result := Format('Val(''%s'') returned Value %d', [Value, Res]);
  DebugFailure(Func, Result, Value);
end;

// This validator tests that the Error Code is set correctly
// and, where the error code <> 0, that the correct Value is returned
function Validator1(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  ProgressMax = 40;
var
  Progress: Integer;
  I, J, K, code: integer;
  S: string;
  Ch : Char;
  I64: Int64;
  Res1, Res2 : Int64;
  Code1, Code2: Integer;

  procedure Validate(S: string; ExpectedResult: Int64; ExpectedCode: Integer);
  var
    Res: Int64;
    Code: Integer;
  begin
    Res := TValInt64Function(Func)(S, code);
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
        S := Ch;
        Validate(S, 0, 1);
      end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for Ch := #0 to #255 do
    if not (Ch in [' ','0'..'9', '$', '+', '-', 'x', 'X']) then
      begin
        S := ' ' + Ch;
        Validate(S, 0, 2);
      end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  Validate('+', 0, 2);
  Validate('-', 0, 2);
  Validate('x', 0, 2);
  Validate('X', 0, 2);
  Validate('$ ', 0, 2);

  Validate('0x', 0, 3);
  Validate('0X', 0, 3);
  Validate(' 0x', 0, 4);
  Validate(' 0X', 0, 4);

  Validate('$$', 0, 2);
  Validate('$+', 0, 2);
  Validate('$-', 0, 2);
  Validate('$0', 0, 0);
  Validate('$g', 0, 2);
  Validate('$x', 0, 2);
  Validate('$x0', 0, 2);

  Validate('0x0', 0, 0);
  Validate('0X0', 0, 0);
  Validate('0xx', 0, 3);
  Validate('0Xx', 0, 3);
  Validate('0x0x', 0, 4);
  Validate('0x0X', 0, 4);
  Validate('0x0x0', 0, 4);
  Validate('0X0X0', 0, 4);

  Validate('++', 0, 2);
  Validate('--', 0, 2);
  Validate('+-', 0, 2);
  Validate('-+', 0, 2);
  Validate('+ ', 0, 2);
  Validate('- ', 0, 2);
  Validate('+$', 0, 3);
  Validate('-$', 0, 3);

  Validate('$a', 10, 0);
  Validate('$A', 10, 0);
  Validate('$f', 15, 0);
  Validate('$F', 15, 0);
  Validate('$g', 0, 2);
  Validate('$G', 0, 2);
  Validate('$?', 0, 2);

  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  S :='9999999999999999';
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

  Validate('$FFFFFFFF', $FFFFFFFF, 0);
  Validate('$FFFFFFFFF', $FFFFFFFFF, 0);
  Validate('-$FFFFFFFF', -$FFFFFFFF, 0);
  Validate('-$FFFFFFFFF', -$FFFFFFFFF, 0);

  for I := 0 to $FFFF do
    begin
      S := '$' + InttoHex(I,0);
      Validate(S, I, 0);
      S := Lowercase(S);
      S := '$' + InttoHex(I,0);
      Validate(S, I, 0);
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '$' + InttoHex(I,8);
      TValInt64Function(Func)(S,code);
      if (code <> 0) then
        begin
          Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
          Result := False;
        end;
      S := Lowercase(S);
      TValInt64Function(Func)(S,code);
      if (code <> 0) then
        begin
          Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
          Result := False;
        end;
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '$' + InttoHex(I,0) + ' ';
      Validate(S, I, Length(S));
      S := Lowercase(S);
      Validate(S, I, Length(S));
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '$' + InttoHex(I,0) + 'z';
      Validate(S, I, Length(S));
      S := Lowercase(S);
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
      S := Lowercase(S);
      Validate(S, I, Length(S)-1);
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '0x' + InttoHex(I,0);
      Validate(S, I, 0);
      S := Lowercase(S);
      Validate(S, I, 0);
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '0x' + InttoHex(I,8);
      Validate(S, I, 0);
      S := Lowercase(S);
      Validate(S, I, 0);
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '0x' + InttoHex(I,0) + ' ';
      Validate(S, I, Length(S));
      S := Lowercase(S);
      Validate(S, I, Length(S));
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '0x' + InttoHex(I,0) + 'z';
      Validate(S, I, Length(S));
      S := Lowercase(S);
      Validate(S, I, Length(S));
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '0x' + InttoHex(I,0) + '  ';
      Validate(S, I, Length(S)-1);
      S := Lowercase(S);
      Validate(S, I, Length(S)-1);
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  for I := 0 to $FFFF do
    begin
      S := '0x' + InttoHex(I,0) + 'zz';
      Validate(S, I, Length(S)-1);
      S := Lowercase(S);
      Validate(S, I, Length(S)-1);
    end;
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  I64 := High(Int64);
  S := IntToStr(I64);
  Validate(S, I64, 0);

  I64 := High(Int64);
  inc(I64);
  S := IntToStr(I64);
  Validate(S, I64, 0);

  I64 := High(Int64);
  inc(I64, 2);
  S := IntToStr(I64);
  Validate(S, I64, 0);

  I64 := -High(Int64);
  S := IntToStr(I64);
  Validate(S, I64, 0);

  I64 := -High(Int64);
  dec(I64);
  S := IntToStr(I64);
  Validate(S, I64, 0);

  I64 := -High(Int64);
  dec(I64, 2);
  S := IntToStr(I64);
  Validate(S, I64, 0);
  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  S := '999999999999999999';
  Validate(S, 999999999999999999, 0);
  S := '-999999999999999999';
  Validate(S, -999999999999999999, 0);

  I64 := High(Int64);
  S := IntToStr(I64);
  Inc(S[Length(s)]); {Inc Last Digit (8)}
  Validate(S, low(I64), Length(S));

  I64 := High(Int64);
  S := IntToStr(I64);
  Inc(S[Length(s)],2); {Inc Last Digit (9)}
  Validate(S, Low(int64)+1, Length(S));

  I64 := Low(Int64);
  S := IntToStr(I64);
  Validate(S, I64, 0);

  I64 := Low(Int64);
  S := IntToStr(I64);
  Inc(S[Length(s)]); {Inc Last Digit (8)}
  Validate(S, high(I64), Length(S));

  S := '9999999999999999999';
  Validate(S, 999999999999999999, 19);
  S := '-9999999999999999999';
  Validate(S, -999999999999999999, 20);

  S := '$AAAAAAAAAAAAAAAA';
  Validate(S, -$5555555555555556, 0);
  S := '-$AAAAAAAAAAAAAAAA';
  Validate(S, $5555555555555556, 0);

  S := '$AAAAAAAAAAAAAAAAA';
  Validate(S, -$5555555555555556, 18);
  S := '-$AAAAAAAAAAAAAAAAA';
  Validate(S, $5555555555555556, 19);

  S := '$FFFFFFFFFFFFFFFFFFFF';
  Validate(S, -1, 18);
  S := '-$FFFFFFFFFFFFFFFFFFFF';
  Validate(S, 1, 19);

  inc(Progress); Callback.ReportProgress(Progress, ProgressMax);

  //compare all possible 3-character string against RTL
  S := '123';
  for I := 0 to 255 do
    begin
      IF i mod 16 = 0 then
        begin
          inc(Progress); Callback.ReportProgress(Progress, ProgressMax);
        end;
      S[1] := Chr(I);
      for J := 0 to 255 do
        begin
          S[2] := Chr(J);
          for K := 0 to 255 do
            begin
              S[3] := Chr(K);
              Val(S, Res1, Code1);
              Res2 := TValInt64Function(Func)(S,code2);
              if Code1 <> Code2 then
                begin
                  Callback.ReportFailure(DescribeFailureCode(Func, S, Code1));
                  Result := False;
                end;
              if Res1 <> Res2 then
                begin
                  Callback.ReportFailure(DescribeFailureValue(Func, S, Res2));
                  Result := False;
                end;
            end;
        end;
    end;

end;

// This validator tests for correct conversion of valid input strings
function Validator2(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  ProgressMax = 8;
var
  Progress: Integer;
  I, Code: Integer;
  Res: Int64;
  S: string;
  I64: Int64;
begin
  Result := True;
  Progress := 0;

  for I := -99999 to +99999 do
    begin
      S := IntToStr(I);
      Res := TValInt64Function(Func)(S,code);
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
      Res := TValInt64Function(Func)(S,code);
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
      I64 := I;
      S := '$' + IntToHex(I64, 0);
      Res := TValInt64Function(Func)(S,code);
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
      S := Lowercase(S);
      Res := TValInt64Function(Func)(S,code);
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
      I64 := I;
      S := '-$' + IntToHex(I64, 0);
      Res := TValInt64Function(Func)(S,code);
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
      S := Lowercase(S);
      Res := TValInt64Function(Func)(S,code);
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
      TValInt64Function(Func)(S,code);
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
      Res := TValInt64Function(Func)(S,code);
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
      Res := TValInt64Function(Func)(S,code);
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
      TValInt64Function(Func)(S,code);
      if (Code <> 0) then
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
  Step = 999999999999;
  ProgressMax = 2 * (High(Int64) div Step);
var
  Code, Progress: Integer;
  I, Res: Int64;
  S: string;
begin
  Result := True;
  Progress := 0;
  I := -High(Int64);
  while I < High(Int64)-Step do
    begin
      S := IntToStr(I);
      Res := TValInt64Function(Func)(S,code);
      if (Res <> I) or (Code <> 0) then
        begin
          Callback.ReportFailure(DescribeFailureCode(Func, S, Code));
          Result := False;
        end;
      inc(I, Step);
      inc(Progress);
      if progress mod 64 = 0 then
        Callback.ReportProgress(Progress, ProgressMax);
    end;
end;

// This validator tests Hex conversions
function Validator4(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  Step = 999999999999;
  ProgressMax = 2 * (High(Int64) div Step);
var
  Code, Progress: Integer;
  I, Res: Int64;
  S: string;
begin
  Result := True;
  Progress := 0;
  I := -High(Int64);
  while I < High(Int64)-Step do
    begin
      S := '$'+IntToHex(I,0);
      Res := TValInt64Function(Func)(S,code);
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
      Res := TValInt64Function(Func)(S,code);
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
      if progress mod 64 = 0 then
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
    TValInt64Function(Func)(P, code);
    if (code <> ExpectedCode) then
      begin
        Callback.ReportFailure(DescribeFailureCode(Func, P, Code));
        TValInt64Function(Func)(P, code);
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

// This validator tests values around range limits
function Validator6(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
const
  Range = 1000000;
  ProgressMax = Range*16;
var
  J, Code, Progress: Integer;
  I, Res: Int64;
  S: string;
begin
  Result := True;
  Progress := 0;

  I := (-High(Int64)) + Range;
  for J := 1 to Range * 2 do
    begin
      S := IntToStr(I);
      Res := TValInt64Function(Func)(S,code);
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
      dec(I);
      inc(Progress);
      if Progress mod 2048 = 0 then
        Callback.ReportProgress(Progress, ProgressMax);
    end;

  I := (High(Int64)) - Range;
  for J := 1 to Range * 2 do
    begin
      S := IntToStr(I);
      Res := TValInt64Function(Func)(S,code);
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
      inc(I);
      inc(Progress);
      if Progress mod 2048 = 0 then
        Callback.ReportProgress(Progress, ProgressMax);
    end;

  I := (-High(Int64)) + Range;
  for J := 1 to Range * 2 do
    begin
      S := '$' + IntToHex(I,0);
      Res := TValInt64Function(Func)(S,code);
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
      dec(I);
      inc(Progress);
      if Progress mod 2048 = 0 then
        Callback.ReportProgress(Progress, ProgressMax);
    end;

  I := (High(Int64)) - Range;
  for J := 1 to Range * 2 do
    begin
      S := '$' + IntToHex(I,0);
      Res := TValInt64Function(Func)(S,code);
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
      inc(I);
      inc(Progress);
      if Progress mod 2048 = 0 then
        Callback.ReportProgress(Progress, ProgressMax);
    end;

  I := (High(Int64) div 10) - Range;
  while I < High(Int64) div 10 + Range do
    begin
      S := IntToStr(I);
      Res := TValInt64Function(Func)(S,code);
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
      inc(I);
      inc(Progress);
      if Progress mod 2048 = 0 then
        Callback.ReportProgress(Progress, ProgressMax);
    end;

  I := (-High(Int64) div 10) - Range;
  while I < -High(Int64) div 10 + Range do
    begin
      S := IntToStr(I);
      Res := TValInt64Function(Func)(S,code);
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
      inc(I);
      inc(Progress);
      if Progress mod 2048 = 0 then
        Callback.ReportProgress(Progress, ProgressMax);
    end;

  I := (High(Int64) div 16) - Range;
  while I < High(Int64) div 16 + Range do
    begin
      S := '$'+IntToHex(I,0);
      Res := TValInt64Function(Func)(S,code);
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
      Res := TValInt64Function(Func)(S,code);
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
      inc(I);
      inc(Progress);
      if Progress mod 2048 = 0 then
        Callback.ReportProgress(Progress, ProgressMax);
    end;

  I := (-High(Int64) div 16) - Range;
  while I < -High(Int64) div 16 + Range do
    begin
      S := '$'+IntToHex(I,0);
      Res := TValInt64Function(Func)(S,code);
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
      Res := TValInt64Function(Func)(S,code);
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
      inc(I);
      inc(Progress);
      if Progress mod 2048 = 0 then
        Callback.ReportProgress(Progress, ProgressMax);
    end;

end;

// This validator tests handling of non-nil zero-length strings
var
  GlobalStr: AnsiString;

function Validator7(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
var
  Res: Int64;
  Code: Integer;
begin
  GlobalStr := #0;
  PInteger(Integer(GlobalStr)-4)^ := 0; {Force Length to 0}
  Res := TValInt64Function(Func)(GlobalStr, code);
  Result := (Res=0) and (Code=1);
  if not Result then
    Callback.ReportFailure('Failed to Handle zero-length non-nil String');
end;

// This validator tests that memory before the 1st Char of PChar is not accessed
// (ie. Checks function does not access AnsiString Length or RefCount)
function Validator8(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
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
          call TValInt64Function(Func)
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
                               call TValInt64Function(Func)
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
function Validator9(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
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
        asm {Call Val function without using @LStrFromPChar Call}
          mov  eax, S
          lea  edx, code
          call TValInt64Function(Func)
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
                               call TValInt64Function(Func)
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

function ChallengeValInt64: TFastcodeChallengeValInt64;
begin
  if ChallengeObject = nil then
    ChallengeObject := TFastcodeChallengeValInt64.RegisterChallenge as TFastcodeChallengeValInt64;
  Result := ChallengeObject;
end;

function TFastcodeChallengeValInt64.GetName: string;
begin
  Result := 'ValInt64';
end;

function TFastcodeChallengeValInt64.GetBenchmarks: TBenchmarkFunctionArray;
begin
  if Benchmarks = nil then
    begin
      AddBenchmark(Benchmark1);
      AddBenchmark(Benchmark2);
    end;
  Result := Benchmarks;
end;

function TFastcodeChallengeValInt64.GetValidators: TValidatorFunctionArray;
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
    end;
  Result := Validators;
end;

function TFastcodeChallengeValInt64.GetVersion: string;
begin
  Result := '0.7.2';
end;

initialization
  ChallengeValInt64;
end.
