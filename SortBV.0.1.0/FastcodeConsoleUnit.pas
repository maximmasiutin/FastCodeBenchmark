unit FastcodeConsoleUnit;

interface

(*
 * Console operation mode
 * ----------------------
 *
 * If commands are specified when launching the B&V utility, it will operate
 * in console mode. In console operation mode no GUI is displayed; output will
 * be directed to the standard output handle. One can specify one or more of the
 * commands specified below, which are executed sequentially.
 *
 *
 * Benchmark command
 *
 *   Syntax:
 *     "-b" [ <classname> ]
 *
 *   The benchmark command benchmarks all functions in the specified challenge
 *   class, or in all challenges if ommitted.
 *
 *
 * Info command
 *
 *   Syntax:
 *     "-i"
 *
 *   The info command displays informations about the challenges in this
 *   B&V tool.
 *
 *
 * Report command
 *
 *   Syntax:
 *     "-r" [ <filename> ]
 *
 *   The report command reports all current benchmark results to the specified
 *   file or to the standard output if no file is specified.
 *
 *
 * Validate command
 *
 *   Syntax:
 *     "-v" [ <classname> ]
 *
 *   The benchmark command validates all functions in the specified challenge
 *   class, or in all challenges if ommitted.
 *
 *)

uses
  Classes, SysUtils, Windows;

function DisplayGui: Boolean;
procedure RunConsole;

implementation

uses
  FastcodeChallengeUnit, FastcodeChallengeManagementUnit, ReportWriterUnit;

const
  NEWLINE = #13#10;

type
  TFastcodeConsoleModeApplication = class(TObject)
  private
    FHandleOutput: THandle;
    FManager: TFastcodeChallengeManager;
    procedure ManagerBenchmarkStart(Sender: TObject; Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction; Index, Count: Integer);
    procedure ManagerLogLine(Sender: TObject; const Text: string);
    procedure ManagerStatusChange(Sender: TObject; const StatusText: string; Busy: Boolean);
    procedure ManagerValidateStart(Sender: TObject; Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction; Index, Count: Integer);
    procedure Write(const S: string);
    procedure WriteLn(const S: string = '');
  public
    procedure Benchmark(const Arg: string);
    constructor Create;
    destructor Destroy; override;
    procedure Information;
    procedure Report(const Arg: string);
    procedure UnknownCommand(const S: string);
    procedure Validate(const Arg: string);
  end;

function DisplayGui: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 1 to ParamCount do
    if ParamStr(I)[1] = '-' then
    begin
      Result := False;
      Break;
    end;

  if Result then
    FreeConsole;
end;

procedure RunConsole;
var
  App: TFastcodeConsoleModeApplication;
  Count, Index: Integer;
  Param: string;

 function FetchCommandArgument: string; forward;
 function IsCommand(const S: string): Boolean; forward;

 function FetchCommandArgument: string;
 begin
   if Index < Count then
   begin
     Result := ParamStr(Index + 1);
     if IsCommand(Result) then
       Result := ''
     else
       Inc(Index);
   end
   else
     Result := '';
 end;

 function IsCommand(const S: string): Boolean;
 begin
   Result := (Length(S) = 2) and (S[1] in ['-', '/']);
 end;

begin
  App := TFastcodeConsoleModeApplication.Create;
  try

    Count := ParamCount;
    Index := 1;
    while Index <= Count do
    begin
      Param := ParamStr(Index);
      if IsCommand(Param) then
        case Param[2] of
          'b': App.Benchmark(FetchCommandArgument);
          'i': App.Information;
          'r': App.Report(FetchCommandArgument);
          'v': App.Validate(FetchCommandArgument);
        else
          App.UnknownCommand(Param);
        end
      else
        App.UnknownCommand(Param);

      Inc(Index);
    end;

  finally
    App.Free;
  end;
end;

procedure TFastcodeConsoleModeApplication.ManagerBenchmarkStart(Sender: TObject; Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction; Index, Count: Integer);
begin
  WriteLn;
  WriteLn(Format('Benchmarking %s.%s', [Challenge.Name, Func^.Name]));
end;

procedure TFastcodeConsoleModeApplication.ManagerLogLine(Sender: TObject; const Text: string);
begin
  WriteLn(Text);
end;

procedure TFastcodeConsoleModeApplication.ManagerStatusChange(Sender: TObject; const StatusText: string; Busy: Boolean);
begin
  if Length(StatusText) > 0 then
    WriteLn(StatusText);
end;

procedure TFastcodeConsoleModeApplication.ManagerValidateStart(Sender: TObject; Challenge: TFastcodeChallenge; Func: PFastcodeChallengeFunction; Index, Count: Integer);
begin
  WriteLn;
  WriteLn(Format('Validating %s.%s', [Challenge.Name, Func^.Name]));
end;

procedure TFastcodeConsoleModeApplication.Write(const S: string);
var
  Dummy: LongWord;
begin
  if (Length(S) > 0) and (FHandleOutput <> 0) then
    Windows.WriteFile(FHandleOutput, S[1], Length(S), Dummy, nil);
end;

procedure TFastcodeConsoleModeApplication.WriteLn(const S: string = '');
begin
  Write(S + NEWLINE);
end;

procedure TFastcodeConsoleModeApplication.Benchmark(const Arg: string);
var
  Challenges: TFastcodeChallengeArray;
  Functions: array of PFastcodeChallengeFunction;
  I, J: Integer;
begin
  Challenges := TFastcodeChallenge.Challenges;
  for I := Low(Challenges) to High(Challenges) do
    if (Arg = '') or (Arg = Challenges[I].ClassName) then
    begin
      SetLength(Functions, Challenges[I].FunctionCount);
      for J := Low(Functions) to High(Functions) do
        Functions[J] := Challenges[I].Functions[J];
      FManager.Benchmark(Challenges[I], Functions);
    end;
end;

constructor TFastcodeConsoleModeApplication.Create;
begin
  inherited Create;
  FHandleOutput := GetStdHandle(STD_OUTPUT_HANDLE);

  FManager := TFastcodeChallengeManager.Create;
  FManager.OnBenchmarkStart := ManagerBenchmarkStart;
  FManager.OnLogLine := ManagerLogLine;
  FManager.OnStatusChange := ManagerStatusChange;
  FManager.OnValidateStart := ManagerValidateStart;
end;

destructor TFastcodeConsoleModeApplication.Destroy;
begin
  FreeAndNil(FManager);
  inherited Destroy;
end;

procedure TFastcodeConsoleModeApplication.Information;
var
  Challenges: TFastcodeChallengeArray;
  I, J: Integer;
begin
  Challenges := TFastcodeChallenge.Challenges;
  for I := Low(Challenges) to High(Challenges) do
  begin
    WriteLn;
    WriteLn(Format('Challenge "%s"'#9'version %s'#9'%s', [Challenges[I].Name,
      Challenges[I].Version, Challenges[I].ClassName]));
    for J := 0 to Challenges[I].FunctionCount - 1 do
      WriteLn(Challenges[I].Functions[J]^.Name);
  end;
end;

procedure TFastcodeConsoleModeApplication.Report(const Arg: string);
var
  ReportWriter: TReportWriterText;
  Stream: TStream;
begin
  ReportWriter := nil;
  Stream := nil;

  try
    if Length(Arg) > 0 then
    begin
      ReportWriter := TReportWriterTextSeparated.Create(ListSeparator, True);
      FManager.ReportText(TFastcodeChallenge.Challenges, ReportWriter);
      ReportWriter.SaveToFile(Arg);
    end
    else
    begin
      ReportWriter := TReportWriterTextPlain.Create;
      FManager.ReportText(TFastcodeChallenge.Challenges, ReportWriter);
      Stream := THandleStream.Create(GetStdHandle(STD_OUTPUT_HANDLE));
      ReportWriter.SaveToStream(Stream);
    end;
  finally
    ReportWriter.Free;
    Stream.Free;
  end;
end;

procedure TFastcodeConsoleModeApplication.UnknownCommand(const S: string);
begin
  WriteLn;
  WriteLn('*** "' + S + '" is not a valid command ***');
end;

procedure TFastcodeConsoleModeApplication.Validate(const Arg: string);
var
  Challenges: TFastcodeChallengeArray;
  Functions: array of PFastcodeChallengeFunction;
  I, J: Integer;
begin
  Challenges := TFastcodeChallenge.Challenges;
  for I := Low(Challenges) to High(Challenges) do
    if (Arg = '') or (Arg = Challenges[I].ClassName) then
    begin
      SetLength(Functions, Challenges[I].FunctionCount);
      for J := Low(Functions) to High(Functions) do
        Functions[J] := Challenges[I].Functions[J];
      FManager.Validate(Challenges[I], Functions);
    end;
end;

end.
