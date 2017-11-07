unit FastcodeChallengeUnit;

interface

{$INCLUDE Defines.inc}

uses
  Classes, SysUtils;

type
  TFastcodeAuthor = (fcaRTL, fcaRTLM, fcaAI, fcaAZ, fcaDKC, fcaEWC, fcaJOH,
    fcaLBG, fcaOuc, fcaSHA, fcaSZ);

const
  FASTCODE_AUTHOR_NAMES: array[TFastcodeAuthor] of string = (
    '(RTL function)',           // fcaRTL
    '(modified RTL function)',  // fcaRTLM
    'Anders Isaksson',          // fcaAI
    'Avatar Zondertau',         // fcaAZ
    'Dennis Kjaer Christensen', // fcaDKC
    'Eric W. Carman',           // fcaEWC
    'John O''Harrow',           // fcaJOH
    'Lars Bloch Gravengaard',   // fcaLBG
    'Florent Ouchet',           // fcaOuc
    'Aleksandr Sharahov',       // fcaSHA
    'Sasa Zeman');              // fcaSZ

type
  TFastcodeCategory = (fccPas, fccIA32, fccIA32Ext, fccMMX, fccSSE, fccSSE2,
    fccSSE3, fcc3DNow, fcc3DNowP);

const
  FASTCODE_CATEGORY_NAMES: array[TFastcodeCategory] of string = (
    'Pascal',    // fccPas
    'IA32',      // fccIA32
    'IA32Ext',   // fccIA32Ext
    'MMX',       // fccMMX
    'SSE',       // fccSSE
    'SSE2',      // fccSSE2
    'SSE3',      // fccSSE3
    '3D-Now!',   // fcc3DNow
    '3D-Now!+'); // fcc3DNowP

type
  TFastcodeChallenge = class;
  TFastcodeChallengeCallback = class;

  TTristate = (tsFalse, tsTrue, tsNull);
  
  PFastcodeChallengeFunction = ^TFastcodeChallengeFunction;
  TFastcodeChallengeFunction = record
    Name: string;
    Desc: string;
    Addr: Pointer;
    Category: TFastcodeCategory;
    Author: TFastcodeAuthor;
    Valid: TTristate;
  end;

  TCallbackFailureEvent = procedure(const Desc: string) of object;

  TCallbackProgressEvent = procedure(Progress, ProgressMax: Integer) of object;

  TFastcodeChallengeCallback = class(TObject)
  private
    FOnFailure: TCallbackFailureEvent;
    FOnProgress: TCallbackProgressEvent;
  public
    procedure ReportFailure(const Desc: string);
    procedure ReportProgress(Progress, ProgressMax: Integer);
    property OnFailure: TCallbackFailureEvent read FOnFailure write FOnFailure;
    property OnProgress: TCallbackProgressEvent read FOnProgress write FOnProgress;
  end;

  TBenchmarkFunction = function(Func: Pointer; Callback: TFastcodeChallengeCallback): Double;
  TBenchmarkFunctionArray = array of TBenchmarkFunction;

  TFastcodeChallengeArray = array of TFastcodeChallenge;

  TValidatorFunction = function(Func: Pointer; Callback: TFastcodeChallengeCallback): Boolean;
  TValidatorFunctionArray = array of TValidatorFunction;

  TFastcodeChallenge = class(TObject)
  private
    FFunctionList: TList;
    function GetFunctionCount: Integer;
    function GetFunctions(Idx: Integer): PFastcodeChallengeFunction;
  protected
    function GetBenchmarkCount: Integer;
    function GetBenchmarks: TBenchmarkFunctionArray; virtual; abstract;
    function GetDummyFunction: Pointer; virtual; abstract;
    function GetName: string; virtual; abstract;
    function GetValidatorCount: Integer;
    function GetValidators: TValidatorFunctionArray; virtual; abstract;
    function GetVersion: string; virtual; abstract;
    class function RegisterChallenge: TFastcodeChallenge;
  public
    class function Challenges: TFastcodeChallengeArray;
    constructor Create; virtual;
    destructor Destroy; override;
    function RegisterFunction(const FunctionData: TFastcodeChallengeFunction): PFastcodeChallengeFunction;
    function RunBenchmark(Func: PFastcodeChallengeFunction; BenchIdx: Integer; Callback: TFastcodeChallengeCallback): Double;
    function RunValidator(Func: PFastcodeChallengeFunction; ValIdx: Integer; Callback: TFastcodeChallengeCallback): Boolean;
    property BenchmarkCount: Integer read GetBenchmarkCount;
    property FunctionCount: Integer read GetFunctionCount;
    property Functions[Idx: Integer]: PFastcodeChallengeFunction read GetFunctions;
    property Name: string read GetName;
    property ValidatorCount: Integer read GetValidatorCount;
    property Version: string read GetVersion;
  end;

function FunctionData(const Name, Desc: string; Addr: Pointer; Category: TFastcodeCategory; Author: TFastcodeAuthor): TFastcodeChallengeFunction;

implementation

uses
  UtilsUnit, Windows;

var
  ChallengeList: TThreadList;

procedure FreeChallengeList; forward;

procedure FreeChallengeList;
var
  I: Integer;
  List: TList;
begin
  if ChallengeList <> nil then
  begin
    List := ChallengeList.LockList;
    try
      for I := 0 to List.Count-1 do
        TObject(List[I]).Free;
    finally
      ChallengeList.UnlockList;
    end;
    FreeAndNil(ChallengeList);
  end;
end;

function FunctionData(const Name, Desc: string; Addr: Pointer; Category: TFastcodeCategory; Author: TFastcodeAuthor): TFastcodeChallengeFunction;
begin
  Result.Name := Name;
  Result.Desc := Desc;
  Result.Addr := Addr;
  Result.Author := Author;
  Result.Category := Category;
  Result.Valid := tsNull;
end;

procedure TFastcodeChallengeCallback.ReportFailure(const Desc: string);
begin
  if Assigned(FOnFailure) then
    FOnFailure(Desc);
end;

procedure TFastcodeChallengeCallback.ReportProgress(Progress, ProgressMax: Integer);
begin
  if Assigned(FOnProgress) then
    FOnProgress(Progress, ProgressMax);
end;

function TFastcodeChallenge.GetFunctionCount: Integer;
begin
  Result := FFunctionList.Count;
end;

function TFastcodeChallenge.GetFunctions(Idx: Integer): PFastcodeChallengeFunction;
begin
  Assert(Idx in [0..FFunctionList.Count-1], Format('%s.GetFunctions: function index %d out of bounds', [ClassName, Idx]));
  Result := FFunctionList[Idx];
end;

function TFastcodeChallenge.GetBenchmarkCount: Integer;
begin
  Result := Length(GetBenchmarks);
end;

function TFastcodeChallenge.GetValidatorCount: Integer;
begin
  Result := Length(GetValidators);
end;

class function TFastcodeChallenge.RegisterChallenge: TFastcodeChallenge;
begin
  Result := Create;
  try
    if ChallengeList = nil then
      ChallengeList := TThreadList.Create;
    ChallengeList.Add(Result);
  except
    Result.Free;
    raise;
  end;
end;

class function TFastcodeChallenge.Challenges: TFastcodeChallengeArray;
var
  I: Integer;
  List: TList;
begin
  if ChallengeList = nil then
    SetLength(Result, 0)
  else
  begin
    List := ChallengeList.LockList;
    try
      SetLength(Result, List.Count);
      for I := Low(Result) to High(Result) do
        Result[I] := List[I];
    finally
      ChallengeList.UnlockList;
    end;
  end;
end;

constructor TFastcodeChallenge.Create;
begin
  inherited Create;
  FFunctionList := TList.Create;
end;

destructor TFastcodeChallenge.Destroy;
var
  I: Integer;
begin
  if FFunctionList <> nil then
  begin
    for I := 0 to FFunctionList.Count-1 do
      Dispose(PFastcodeChallengeFunction(FFunctionList[I]));
    FFunctionList.Free;
  end;
  inherited Destroy;
end;

function TFastcodeChallenge.RegisterFunction(const FunctionData: TFastcodeChallengeFunction): PFastcodeChallengeFunction;
begin
  New(Result);
  try
    Result^ := FunctionData;
    FFunctionList.Add(Result);
  except
    Dispose(Result);
    raise;
  end;
end;

function TFastcodeChallenge.RunBenchmark(Func: PFastcodeChallengeFunction; BenchIdx: Integer; Callback: TFastcodeChallengeCallback): Double;
var
  Benchmarks: TBenchmarkFunctionArray;
  FuncAddr: Pointer;
begin
  Benchmarks := GetBenchmarks;
  Assert(BenchIdx in [0..Length(Benchmarks)-1], Format('%s.RunBenchmark: benchmark index %d out of bounds', [ClassName, BenchIdx]));
  try
    if Func = nil then
      FuncAddr := GetDummyFunction
    else
      FuncAddr := Func^.Addr;
    Result := Benchmarks[BenchIdx](FuncAddr, Callback);
  except
    on E: Exception do
    begin
      Callback.ReportFailure(Format('Uncaught %s exception in benchmark %d: %s', [E.ClassName, BenchIdx+1, QuoteString(E.Message)]));
      Result := -1;
    end;
  end;
end;

function TFastcodeChallenge.RunValidator(Func: PFastcodeChallengeFunction; ValIdx: Integer; Callback: TFastcodeChallengeCallback): Boolean;
var
  Validators: TValidatorFunctionArray;
begin
  Validators := GetValidators;
  Assert(ValIdx in [0..Length(Validators)-1], Format('%s.RunValidator: validator index %d out of bounds', [ClassName, ValIdx]));
  try
    Result := Validators[ValIdx](Func^.Addr, Callback);
  except
    on E: Exception do
    begin
      if not (E is EAbort) then
        Callback.ReportFailure(Format('Uncaught %s exception in validator %d: %s', [E.ClassName, ValIdx+1, QuoteString(E.Message)]));
      Result := False;
    end;
  end;
end;

initialization
begin

end;

finalization
begin
  FreeChallengeList;
end;

end.
