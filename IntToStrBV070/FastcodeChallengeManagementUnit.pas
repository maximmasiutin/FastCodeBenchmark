unit FastcodeChallengeManagementUnit;

interface

{$INCLUDE Version.inc}
{$INCLUDE defines.inc}

{$DEFINE PriorityChange} // Disable to remove priority change. KEEP ENABLED IN VERSIONS USED FOR BENCHMARKING!
{$DEFINE ReportSpread}   // Disable to not include spread in report

{$IFDEF Delphi2005Plus}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNSAFE_CODE OFF}
{$ENDIF}

uses
  Classes, FastcodeChallengeUnit, Math, ReportWriterUnit, SysUtils, Windows, Forms;

type
  TFunctionTaskStartEvent = procedure(Sender: TObject; Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction; Index, Count: Integer) of object;

  TLogLineEvent = procedure(Sender: TObject; const Text: string) of object;

  TProgressEvent = procedure(Sender: TObject; Progress, ProgressMax: Integer) of object;

  TResultsUpdatedEvent = procedure(Sender: TObject; Challenge: TFastcodeChallenge) of object;

  TStatusChangeEvent = procedure(Sender: TObject; const StatusText: string; Busy: Boolean) of object;

  TSubBenchmarkResultArray = array of Double;

  PFunctionResultRec = ^TFunctionResultRec;
  TFunctionResultRec = record
    Challenge: TFastcodeChallenge;
    Func: PFastcodeChallengeFunction;
    BenchmarkSub: TSubBenchmarkResultArray;
    BenchmarkSum: Double;
  end;

  TReportTextKind = (rtkBenchmark, rtkValidation);

  TFastcodeChallengeManager = class(TObject)
  private
    FCallback: TFastcodeChallengeCallback;
    FFailureCount: Integer;
    FFunctionResultList: TList;
    {$ifdef ThreadSafe}
      FLockCS: TRTLCriticalSection;
    {$endif}
    FOnBenchmarkStart: TFunctionTaskStartEvent;
    FOnLogLine: TLogLineEvent;
    FOnProgress: TProgressEvent;
    FOnResultsUpdated: TResultsUpdatedEvent;
    FOnStatusChange: TStatusChangeEvent;
    FOnValidateStart: TFunctionTaskStartEvent;
    procedure BenchmarkAfter;
    procedure BenchmarkBefore;
    procedure BenchmarkFunction(Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction; ResultRec: PFunctionResultRec);
    procedure BenchmarkSpeedStep;
    procedure CallbackFailure(const Desc: string);
    procedure CallbackProgress(Progress, ProgressMax: Integer);
    function FunctionResultAdd(Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction): PFunctionResultRec;
    function GetResultCount: Integer;
    function GetResults(Idx: Integer): PFunctionResultRec;
    procedure ValidateFunction(Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction);
  protected
    procedure DoBenchmarkStart(Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction; Index, Count: Integer); dynamic;
    procedure DoLogLine(const Text: string); dynamic;
    procedure DoProgress(Progress, ProgressMax: Integer); dynamic;
    procedure DoResultsUpdated(Challenge: TFastcodeChallenge); dynamic;
    procedure DoStatusChange(const StatusText: string; Busy: Boolean); dynamic;
    procedure DoValidateStart(Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction; Index, Count: Integer); dynamic;
  public
    procedure Benchmark(Challenge: TFastcodeChallenge; const Functions: array of PFastcodeChallengeFunction);
    function CalculateSpread(Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction): Double;
    procedure ClearResults;
    constructor Create;
    destructor Destroy; override;
    function HasResults(Challenge: TFastcodeChallenge): Boolean;
    procedure Lock;
    procedure ReportText(const Challenges: array of TFastcodeChallenge; ReportWriter: TReportWriter; Kind: TReportTextKind);
    procedure ReportSCCompatibleText(const Challenges: array of TFastcodeChallenge; ReportWriter: TReportWriter; Kind: TReportTextKind);
    procedure Unlock;
    procedure Validate(Challenge: TFastcodeChallenge; const Functions: array of PFastcodeChallengeFunction);

    property OnBenchmarkStart: TFunctionTaskStartEvent read FOnBenchmarkStart write FOnBenchmarkStart;
    property OnLogLine: TLogLineEvent read FOnLogLine write FOnLogLine;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
    property OnResultsUpdated: TResultsUpdatedEvent read FOnResultsUpdated write FOnResultsUpdated;
    property OnStatusChange: TStatusChangeEvent read FOnStatusChange write FOnStatusChange;
    property OnValidateStart: TFunctionTaskStartEvent read FOnValidateStart write FOnValidateStart;
    property ResultCount: Integer read GetResultCount;
    property Results[Idx: Integer]: PFunctionResultRec read GetResults;
  end;

function BenchmarkResultToString(const Value: Double): string;
function BenchmarkSpreadToString(const Value: Double): string;

implementation

uses
  SystemInfoUnit;

const
  FAILURE_COUNT_MAX = 256;

function CompareFunctionResult(X, Y: Pointer): Integer; forward;

function CompareFunctionResult(X, Y: Pointer): Integer;
var
  SumX, SumY: Double;
begin
  if X = Y then
    Result := 0
  else
  begin
    SumX := PFunctionResultRec(X)^.BenchmarkSum;
    SumY := PFunctionResultRec(Y)^.BenchmarkSum;
    Result := Ord(SumX > SumY) * 2 - 1;
  end;
end;

function BenchmarkResultToString(const Value: Double): string;
begin
  if IsNan(Value) then
    Result := ''
  else
    if IsInfinite(Value) then
      Result := 'failed'
    else
      Result := Format('%.0f', [Value]);
end;

function BenchmarkSpreadToString(const Value: Double): string;
begin
  if IsNan(Value) then
    Result := ''
  else
    Result := Format('%.1f%%', [Value * 100]);
end;

procedure TFastcodeChallengeManager.BenchmarkAfter;
begin
  {$ifdef PriorityChange}
    SetPriorityClass(GetCurrentProcess, NORMAL_PRIORITY_CLASS);
    SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_NORMAL);
  {$endif}
end;

procedure TFastcodeChallengeManager.BenchmarkBefore;
begin
  {$ifdef PriorityChange}
    SetPriorityClass(GetCurrentProcess, REALTIME_PRIORITY_CLASS);
    SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL);
  {$else}
    {$message warn 'Priority change disabled for debugging; don''t use this binary for real tests!'}
  {$endif}
end;

procedure TFastcodeChallengeManager.BenchmarkFunction(Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction; ResultRec: PFunctionResultRec);
var
  BenchRes, Sum: Double;
  I: Integer;
  Passed: Boolean;
begin
  Passed := True;
  Sum := 0;

  for I := 0 to Challenge.BenchmarkCount - 1 do
  begin
    DoStatusChange(Format('Running benchmark %d (of %d) on function %s', [I+1, Challenge.BenchmarkCount, Func^.Name]), True);
    Lock;
    try
      FFailureCount := 0;
    finally
      Unlock;
    end;

    BenchRes := Challenge.RunBenchmark(Func, I, FCallback);
    if BenchRes >= 0 then
    begin
      Sum := Sum + BenchRes;
      ResultRec^.BenchmarkSub[I] := BenchRes;
    end
    else
    begin
      Passed := False;
      Break;
    end;
    DoStatusChange('', False);
  end;

  if Passed then
    ResultRec^.BenchmarkSum := Sum
  else
    ResultRec^.BenchmarkSum := Infinite;

  DoResultsUpdated(Challenge);
end;

procedure TFastcodeChallengeManager.BenchmarkSpeedStep;
var
  PerfEnd, PerfFreq, PerfStart, PerfTemp: Int64;
begin
  // A quarter of a second for SpeedStep
  Win32Check(QueryPerformanceFrequency(PerfFreq));
  Win32Check(QueryPerformanceCounter(PerfStart));
  PerfEnd := PerfStart + (PerfFreq div 4);
  repeat
    Win32Check(QueryPerformanceCounter(PerfTemp));
  until PerfTemp >= PerfEnd;
end;

procedure TFastcodeChallengeManager.CallbackFailure(const Desc: string);
begin
  DoLogLine(Desc);
  Lock;
  try
    Inc(FFailureCount);
    if FFailureCount >= FAILURE_COUNT_MAX then
      raise EAbort.Create('Aborting validation - too many failures');
  finally
    Unlock;
  end;
end;

procedure TFastcodeChallengeManager.CallbackProgress(Progress, ProgressMax: Integer);
begin
  DoProgress(Progress, ProgressMax);
end;

function TFastcodeChallengeManager.FunctionResultAdd(Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction): PFunctionResultRec;
begin
  Lock;
  try
    New(Result);
    try
      Result^.Challenge := Challenge;
      Result^.Func := Func;
      Result^.BenchmarkSum := Nan;
      SetLength(Result^.BenchmarkSub, 0);

      FFunctionResultList.Add(Result);
    except
      Dispose(Result);
      raise;
    end;
  finally
    Unlock;
  end;
end;

function TFastcodeChallengeManager.GetResultCount: Integer;
begin
  Lock;
  try
    Result := FFunctionResultList.Count;
  finally
    Unlock;
  end;
end;

function TFastcodeChallengeManager.GetResults(Idx: Integer): PFunctionResultRec;
begin
  Lock;
  try
    Result := FFunctionResultList[Idx];
  finally
    Unlock;
  end;
end;

procedure TFastcodeChallengeManager.ValidateFunction(Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction);
const
  BOOL_TO_TRISTATE: array[Boolean] of TTristate = (tsFalse, tsTrue);
var
  I: Integer;
  Passed: Boolean;
begin
  DoLogLine('');
  DoLogLine('Validating function '+Func^.Name);

  Passed := True;

  for I := 0 to Challenge.ValidatorCount - 1 do
  begin
    DoStatusChange(Format('Running validator %d (of %d) on function %s', [I+1, Challenge.ValidatorCount, Func^.Name]), True);
    Lock;
    try
      FFailureCount := 0;
    finally
      Unlock;
    end;

    if not Challenge.RunValidator(Func, I, FCallback) then
    begin
      DoLogLine(Format('Validation %d failed :(', [I+1]));
      Passed := False;
      Break;
    end;
  end;
  DoStatusChange('', False);

  Func^.Valid := BOOL_TO_TRISTATE[Passed];
  if Passed then
    DoLogLine('Validation passed');

  DoResultsUpdated(Challenge);
end;

procedure TFastcodeChallengeManager.DoBenchmarkStart(Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction; Index, Count: Integer);
begin
  if Assigned(FOnBenchmarkStart) then
    FOnBenchmarkStart(Self, Challenge, Func, Index, Count);
end;

procedure TFastcodeChallengeManager.DoLogLine(const Text: string);
begin
  if Assigned(FOnLogLine) then
    FOnLogLine(Self, Text);
end;

procedure TFastcodeChallengeManager.DoProgress(Progress, ProgressMax: Integer);
begin
  if Assigned(FOnProgress) then
    FOnProgress(Self, Progress, ProgressMax);
end;

procedure TFastcodeChallengeManager.DoResultsUpdated(Challenge: TFastcodeChallenge);
begin
  if Assigned(FOnResultsUpdated) then
    FOnResultsUpdated(Self, Challenge);
end;

procedure TFastcodeChallengeManager.DoStatusChange(const StatusText: string; Busy: Boolean);
begin
  if Assigned(FOnStatusChange) then
    FOnStatusChange(Self, StatusText, Busy);
end;

procedure TFastcodeChallengeManager.DoValidateStart(Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction; Index, Count: Integer);
begin
  if Assigned(FOnValidateStart) then
    FOnValidateStart(Self, Challenge, Func, Index, Count);
end;

procedure TFastcodeChallengeManager.Benchmark(Challenge: TFastcodeChallenge; const Functions: array of PFastcodeChallengeFunction);
var
  I, J: Integer;
  ResultRecs: array of PFunctionResultRec;
begin
  SetLength(ResultRecs, Length(Functions));
  for I := Low(Functions) to High(Functions) do
  begin
    ResultRecs[I] := FunctionResultAdd(Challenge, Functions[I]);
    ResultRecs[I]^.BenchmarkSum := Nan;
    SetLength(ResultRecs[I]^.BenchmarkSub, Challenge.BenchmarkCount);
    for J := Low(ResultRecs[I]^.BenchmarkSub) to High(ResultRecs[I]^.BenchmarkSub) do
      ResultRecs[I]^.BenchmarkSub[J] := Nan;
  end;

  BenchmarkSpeedStep;
  BenchmarkBefore;
  try
    for I := Low(Functions) to High(Functions) do
    begin
      DoBenchmarkStart(Challenge, Functions[I], I, Length(Functions));
      BenchmarkFunction(Challenge, Functions[I], ResultRecs[I]);
    end;
  finally
    BenchmarkAfter;
  end;
end;

function TFastcodeChallengeManager.CalculateSpread(Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction): Double;
var
  Count, I: Integer;
  Average, Max, Min, Sum: Double;
  ResultRec: PFunctionResultRec;
begin
  Count := 0;
  Min := Infinity;
  Max := NegInfinity;
  Sum := 0;
  Lock;
  try
    for I := 0 to FFunctionResultList.Count - 1 do
    begin
      ResultRec := PFunctionResultRec(FFunctionResultList[I]);
      if (ResultRec^.Challenge = Challenge) and (ResultRec^.Func = Func) and
        not IsNan(ResultRec^.BenchmarkSum) and not IsInfinite(ResultRec^.BenchmarkSum) then
      begin
        Max := Math.Max(Max, ResultRec^.BenchmarkSum);
        Min := Math.Min(Min, ResultRec^.BenchmarkSum);
        Sum := Sum + ResultRec^.BenchmarkSum;
        Inc(Count);
      end;
    end;
  finally
    Unlock;
  end;
  if Count > 1 then
  begin
    Average := Sum / Count;
    Result := Math.Max(Max - Average, Average - Min) / Average;
  end
  else
    Result := Nan;
end;

procedure TFastcodeChallengeManager.ClearResults;
var
  I: Integer;
begin
  Lock;
  try
    for I := 0 to FFunctionResultList.Count - 1 do
      Dispose(PFunctionResultRec(FFunctionResultList[I]));
    FFunctionResultList.Clear;
  finally
    Unlock;
  end;
end;

constructor TFastcodeChallengeManager.Create;
begin
  inherited Create;
  {$ifdef ThreadSafe}
    InitializeCriticalSection(FLockCS);
  {$endif}

  FCallback := TFastcodeChallengeCallback.Create;
  FCallback.OnFailure := CallbackFailure;
  FCallback.OnProgress := CallbackProgress;
  FFunctionResultList := TList.Create;
end;

destructor TFastcodeChallengeManager.Destroy;
begin
  ClearResults;
  FreeAndNil(FFunctionResultList);
  FreeAndNil(FCallback);

  {$ifdef ThreadSafe}
    DeleteCriticalSection(FLockCS);
  {$endif}
  inherited Destroy;
end;

function TFastcodeChallengeManager.HasResults(Challenge: TFastcodeChallenge): Boolean;
var
  I: Integer;
begin
  Lock;
  try
    Result := False;
    for I := 0 to FFunctionResultList.Count - 1 do
      if PFunctionResultRec(FFunctionResultList[I])^.Challenge = Challenge then
      begin
        Result := True;
        Break;
      end;
  finally
    Unlock;
  end;
end;

procedure TFastcodeChallengeManager.Lock;
begin
  {$ifdef ThreadSafe}
    EnterCriticalSection(FLockCS);
  {$endif}
end;

procedure TFastcodeChallengeManager.ReportText(const Challenges: array of TFastcodeChallenge; ReportWriter: TReportWriter; Kind: TReportTextKind);
const
  CReportTitles: array[TReportTextKind] of string = (
    'Benchmark report', 'Validation report');
var
  FunctionsDisplayed: TList;
  I, J: Integer;
  ResultRec: PFunctionResultRec;
  {$ifdef ReportSpread}
    Spread, WorstSpread: Double;
  {$endif}

 procedure ReportTestInfoTable;
 begin
   ReportWriter.TableStart;
   try
     ReportWriter.TableRow(['Compiler:',      SystemInfoCompiler]);
     ReportWriter.TableRow(['Compile flags:', SystemInfoCompileFlags]);
     ReportWriter.TableRow(['CPU:',           SystemInfoCPU]);
     ReportWriter.TableRow(['Generated on:',  FormatDateTime('ddddd tt', Now)]);
     ReportWriter.TableRow(['Windows:',       SystemInfoWindows]);
     ReportWriter.TableRow(['Version:',       SystemInfoVersion]);
   finally
     ReportWriter.TableEnd;
   end;
 end;

 procedure ReportResultTableHeader(Challenge: TFastcodeChallenge);
 var
   I: Integer;
 begin
   ReportWriter.TableRowStart(True);
   try
     ReportWriter.TableField('Name');
     ReportWriter.TableField('Align');

     if Kind = rtkBenchmark then
     begin
       {$ifdef ReportSpread}
         ReportWriter.TableField('Spread');
       {$endif}
       for I := 1 to Challenge.BenchmarkCount do
         ReportWriter.TableField(Format('SubBench%d', [I]));
       ReportWriter.TableField('Benchmark');
     end;

     if Kind = rtkValidation then
       ReportWriter.TableField('Validation');
   finally
     ReportWriter.TableRowEnd;
   end;
 end;

 procedure ReportResultTableRowBenchmark(ResultRec: PFunctionResultRec);
 var
   I: Integer;
   {$ifdef ReportSpread}
     Spread: Double;
   {$endif}
 begin
   ReportWriter.TableRowStart;
   try
     ReportWriter.TableField(ResultRec^.Func^.Name);
     ReportWriter.TableField(Format('%.1x', [Longword(ResultRec^.Func^.Addr) and $F]));

     {$ifdef ReportSpread}
       Spread := CalculateSpread(ResultRec^.Challenge, ResultRec^.Func);
       ReportWriter.TableField(BenchmarkSpreadToString(Spread));
     {$endif}
     for I := 0 to ResultRec^.Challenge.BenchmarkCount - 1 do
       ReportWriter.TableField(BenchmarkResultToString(ResultRec^.BenchmarkSub[I]));
     ReportWriter.TableField(BenchmarkResultToString(ResultRec^.BenchmarkSum));
   finally
     ReportWriter.TableRowEnd;
   end;
 end;

 procedure ReportResultTableRowValidation(Func: PFastcodeChallengeFunction);
 begin
   ReportWriter.TableRowStart;
   try
     ReportWriter.TableField(Func^.Name);
     ReportWriter.TableField(Format('%.1x', [Longword(Func^.Addr) and $F]));
     case Func^.Valid of
       tsFalse: ReportWriter.TableField('FAILED');
       tsTrue:  ReportWriter.TableField('passed');
       tsNull:  ReportWriter.TableField('');
     end;
   finally
     ReportWriter.TableRowEnd;
   end;
 end;

begin
  ReportWriter.SectionStart(CReportTitles[Kind]);
  try
    ReportTestInfoTable;

    for I := Low(Challenges) to High(Challenges) do
    begin
      if (Kind = rtkBenchmark) and not HasResults(Challenges[I]) then
        Continue;

      ReportWriter.SectionStart(Format(
        '%s for %s challenge (B&V version %s)',
        [CReportTitles[Kind], Challenges[I].Name, Challenges[I].Version]));
      try

        {$ifdef ReportSpread}
          if Kind = rtkBenchmark then
          begin
            WorstSpread := Nan;
            for J := 0 to Challenges[I].FunctionCount - 1 do
            begin
              Spread := CalculateSpread(Challenges[I], Challenges[I].Functions[J]);
              if not IsNan(Spread) and (IsNan(WorstSpread) or (Spread > WorstSpread)) then
                WorstSpread := Spread;
            end;

            if not IsNan(WorstSpread) then
              ReportWriter.SectionParagraph('Worst spread: ' + BenchmarkSpreadToString(WorstSpread));
          end;
        {$endif}

        ReportWriter.TableStart;
        try
          ReportResultTableHeader(Challenges[I]);

          Lock;
          try
            if Kind = rtkBenchmark then
            begin
              FunctionsDisplayed := TList.Create;
              try
                for J := 0 to FFunctionResultList.Count - 1 do
                begin
                  ResultRec := PFunctionResultRec(FFunctionResultList[J]);
                  if (ResultRec^.Challenge = Challenges[I]) and not IsNan(ResultRec^.BenchmarkSum) then
                    FunctionsDisplayed.Add(ResultRec);
                end;
                FunctionsDisplayed.Sort(CompareFunctionResult);

                for J := 0 to FunctionsDisplayed.Count - 1 do
                  ReportResultTableRowBenchmark(PFunctionResultRec(FunctionsDisplayed[J]));
              finally
                FunctionsDisplayed.Free;
              end;
            end;

            if Kind = rtkValidation then
              for J := 0 to Challenges[I].FunctionCount - 1 do
                ReportResultTableRowValidation(Challenges[I].Functions[J]);
          finally
            Unlock;
          end;
        finally
          ReportWriter.TableEnd;
        end;
      finally
        ReportWriter.SectionEnd;
      end;
    end;
  finally
    ReportWriter.SectionEnd;
  end;
end;



procedure TFastcodeChallengeManager.ReportSCCompatibleText(const Challenges: array of TFastcodeChallenge; ReportWriter: TReportWriter; Kind: TReportTextKind);
var
  FunctionsDisplayed: TList;
  I, J: Integer;
  ResultRec: PFunctionResultRec;

 procedure ReportBenchmarkHeader;
 begin
     ReportWriter.TableRow([Format('[%s %s] Running "%s" benchmark version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), SystemInfoVersion, SystemInfoCompileFlags])]);
     ReportWriter.TableRow([Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPU])]);
 end;

 procedure ReportValidationkHeader;
 begin
     ReportWriter.TableRow([Format('[%s %s] Running "%s" validation version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), SystemInfoVersion, SystemInfoCompileFlags])]);
     ReportWriter.TableRow([Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPU])]);
 end;

 procedure ReportResultTableRowBenchmark(ResultRec: PFunctionResultRec);
 var
   I: Integer;
 begin
   ReportWriter.TableRowStart;
   try
     ReportWriter.TableField(ResultRec^.Func^.Name);
     ReportWriter.TableField(Format('%.1x', [Longword(ResultRec^.Func^.Addr) and $F]));

     for I := 0 to ResultRec^.Challenge.BenchmarkCount - 1 do
       ReportWriter.TableField(BenchmarkResultToString(ResultRec^.BenchmarkSub[I]));
     ReportWriter.TableField(BenchmarkResultToString(ResultRec^.BenchmarkSum));
   finally
     ReportWriter.TableRowEnd;
   end;
 end;

 procedure ReportResultTableRowValidation(Func: PFastcodeChallengeFunction);
 begin
   ReportWriter.TableRowStart;
   try
     ReportWriter.TableField(Func^.Name);
     ReportWriter.TableField(Format('%.1x', [Longword(Func^.Addr) and $F]));
     case Func^.Valid of
       tsFalse: ReportWriter.TableField('FAILED');
       tsTrue:  ReportWriter.TableField('Passed');
       tsNull:  ReportWriter.TableField('');
     end;
   finally
     ReportWriter.TableRowEnd;
   end;
 end;

begin
  ReportWriter.SectionStart;

  try
   case Kind of
     rtkBenchmark  : ReportBenchmarkHeader;
     rtkValidation : ReportValidationkHeader;
   end;


    for I := Low(Challenges) to High(Challenges) do
    begin
      if (Kind = rtkBenchmark) and not HasResults(Challenges[I]) then
        Continue;

      ReportWriter.SectionStart;

      try
        try
          Lock;
          try
            if Kind = rtkBenchmark then
            begin
              FunctionsDisplayed := TList.Create;
              try
                for J := 0 to FFunctionResultList.Count - 1 do
                begin
                  ResultRec := PFunctionResultRec(FFunctionResultList[J]);
                  if (ResultRec^.Challenge = Challenges[I]) and not IsNan(ResultRec^.BenchmarkSum) then
                    FunctionsDisplayed.Add(ResultRec);
                end;
                FunctionsDisplayed.Sort(CompareFunctionResult);

                for J := 0 to FunctionsDisplayed.Count - 1 do
                  ReportResultTableRowBenchmark(PFunctionResultRec(FunctionsDisplayed[J]));
              finally
                FunctionsDisplayed.Free;
              end;
            end;

            if Kind = rtkValidation then
              for J := 0 to Challenges[I].FunctionCount - 1 do
                ReportResultTableRowValidation(Challenges[I].Functions[J]);
          finally
            Unlock;
          end;
        finally
          ReportWriter.TableEnd;
        end;
      finally
        ReportWriter.SectionEnd;
      end;
    end;
  finally
    ReportWriter.SectionEnd;
  end;
end;




procedure TFastcodeChallengeManager.Unlock;
begin
  {$ifdef ThreadSafe}
    LeaveCriticalSection(FLockCS);
  {$endif}
end;

procedure TFastcodeChallengeManager.Validate(Challenge: TFastcodeChallenge; const Functions: array of PFastcodeChallengeFunction);
var
  I: Integer;
begin
  for I := Low(Functions) to High(Functions) do
  begin
    DoValidateStart(Challenge, Functions[I], I, Length(Functions));
    ValidateFunction(Challenge, Functions[I]);
  end;
end;

end.
