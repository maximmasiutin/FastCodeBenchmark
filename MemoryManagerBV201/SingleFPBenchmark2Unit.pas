unit SingleFPBenchmark2Unit;

interface

uses Windows, BenchmarkClassUnit, Classes, Math;

type

  TSingleFPThreads2 = class(TFastcodeMMBenchmark)
  public
    procedure RunBenchmark; override;
    class function GetBenchmarkName: string; override;
    class function GetBenchmarkDescription: string; override;
    class function GetSpeedWeight: Double; override;
    class function GetCategory: TBenchmarkCategory; override;
  end;

implementation

uses SysUtils;

type

  TSingleFPThread2 = class(TThread)
     FBenchmark: TFastcodeMMBenchmark;
     procedure Execute; override;
  end;

  TRegtangularComplexS = packed record
   RealPart, ImaginaryPart : Single;
  end;

//Loading some Single values

procedure TestFunction(var Res : TRegtangularComplexS; const X, Y : TRegtangularComplexS);
begin
 Res.RealPart := X.RealPart + Y.RealPart
               + X.RealPart + Y.RealPart
               + X.RealPart + Y.RealPart
               + X.RealPart + Y.RealPart
               + X.RealPart + Y.RealPart
               + X.RealPart + Y.RealPart
               + X.RealPart + Y.RealPart;
 Res.ImaginaryPart := X.ImaginaryPart + Y.ImaginaryPart
                    + X.ImaginaryPart + Y.ImaginaryPart
                    + X.ImaginaryPart + Y.ImaginaryPart
                    + X.ImaginaryPart + Y.ImaginaryPart
                    + X.ImaginaryPart + Y.ImaginaryPart
                    + X.ImaginaryPart + Y.ImaginaryPart
                    + X.ImaginaryPart + Y.ImaginaryPart;
end;

procedure TSingleFPThread2.Execute;
var
 I1, I2, I5: Integer;
 Src1Array1 : array of TRegtangularComplexS;
 Src2Array1 : array of TRegtangularComplexS;
 ResultArray1 : array of TRegtangularComplexS;
 BenchArraySize, PrevArraySize : Integer;
const
 MINBENCHARRAYSIZE : Integer = 1000;
 MAXBENCHARRAYSIZE : Integer = 100000;
 ARRAYSIZEINCREMENT = 1000;
 NOOFRUNS : Integer = 20;

begin
 PrevArraySize := 0;
 BenchArraySize := MINBENCHARRAYSIZE;
 while BenchArraySize < MAXBENCHARRAYSIZE do
  begin
   SetLength(Src1Array1, BenchArraySize);
   SetLength(Src2Array1, BenchArraySize);
   SetLength(ResultArray1, BenchArraySize);
   FBenchmark.UpdateUsageStatistics;
   //Fill source arrays
   for I1 := PrevArraySize to BenchArraySize-1 do
    begin
     Src1Array1[I1].RealPart := 1;
     Src1Array1[I1].ImaginaryPart := 1;
     Src2Array1[I1].RealPart := 1;
     Src2Array1[I1].ImaginaryPart := 1;
    end;
   //This is the real botleneck and the performance we want to measure
   for I2 := 0 to NOOFRUNS do
    begin
     for I5 := 0 to BenchArraySize-1 do
      begin
       TestFunction(ResultArray1[I5], Src1Array1[I5], Src2Array1[I5]);
      end;
    end;
   PrevArraySize := BenchArraySize;
   inc(BenchArraySize, ARRAYSIZEINCREMENT);
  end;
end;

class function TSingleFPThreads2.GetBenchmarkDescription: string;
begin
  Result := 'A benchmark that tests access to Single FP variables '
    + 'in a dynamic array. '
    + 'Reveals set associativity related issues.'
    + 'Benchmark submitted by Dennis Kjaer Christensen.';
end;

class function TSingleFPThreads2.GetBenchmarkName: string;
begin
  Result := 'Single Variables Access 3 arrays at a time';
end;

class function TSingleFPThreads2.GetCategory: TBenchmarkCategory;
begin
  Result := bmMemoryAccessSpeed;
end;

class function TSingleFPThreads2.GetSpeedWeight: Double;
begin
  Result := 0.9;
end;

procedure TSingleFPThreads2.RunBenchmark;
var
  SingleFPThread : TSingleFPThread2;

begin
  inherited;
  SingleFPThread := TSingleFPThread2.Create(True);
  SingleFPThread.FreeOnTerminate := False;
  SingleFPThread.FBenchmark := Self;
  SingleFPThread.Resume;
  SingleFPThread.WaitFor;
  SingleFPThread.Free;
  SingleFPThread := nil;
end;

end.