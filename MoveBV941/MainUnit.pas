unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, TeEngine, Series, ExtCtrls, TeeProcs, Chart,
  ComCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'Move';

type
  TMainForm = class(TForm)
    CloseBitBtn: TBitBtn;
    BenchmarkButton: TButton;
    SummedNoOfMBytesPerSecEdit: TEdit;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    SummedArraySizeEdit: TEdit;
    SaveTestResultsSpeedButton: TSpeedButton;
    ValidateButton: TButton;
    ErrorEdit: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    AllBenchmarkEdit: TEdit;
    RunResultsGroupBox: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    RunTimeEdit: TEdit;
    NoOfMBytesPerSecEdit: TEdit;
    ArraySizeLabeledEdit: TLabeledEdit;
    AddressSourceEdit: TEdit;
    AddressDestEdit: TEdit;
    RunStatisticsGroupBox: TGroupBox;
    Label3: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    NoOfMBytesPerSecMaxEdit: TEdit;
    NoOfMBytesPerSecMinEdit: TEdit;
    NoOfMBytesPerSecTotalEdit: TEdit;
    NoOfMBytesPerSecAverageEdit: TEdit;
    BenchmarkResultsGroupBox: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    SubBenchmark1Edit: TEdit;
    SubBenchmark2Edit: TEdit;
    SubBenchmark3Edit: TEdit;
    BenchmarkEdit: TEdit;
    SubBenchmark4Edit: TEdit;
    SubBenchmark5Edit: TEdit;
    Label12: TLabel;
    BestBenchmarkEdit: TEdit;
    Label13: TLabel;
    PageControl: TPageControl;
    GraphTabSheet: TTabSheet;
    BenchmarkTwiceButton: TButton;
    BenchThreeTimesButton: TButton;
    Chart1: TChart;
    Series1: TBarSeries;
    Series2: TBarSeries;
    Series3: TBarSeries;
    FunctionSelectComboBox: TComboBox;
    Label17: TLabel;
    ReportTabSheet: TTabSheet;
    ReportRichEdit: TRichEdit;
    BenchmarkAllButton: TButton;
    PrintSpeedButton: TSpeedButton;
    ReportSaveDialog: TSaveDialog;
    TextSaveDialog: TSaveDialog;
    Series5: TBarSeries;
    SubBenchmark5SpeedButton: TSpeedButton;
    SubBenchmark4SpeedButton: TSpeedButton;
    SubBenchmark3SpeedButton: TSpeedButton;
    SubBenchmark2SpeedButton: TSpeedButton;
    SubBenchmark1SpeedButton: TSpeedButton;
    ShowOptionsSpeedButton: TSpeedButton;
    Series6: TLineSeries;
    CopyChartToClipboardSpeedButton: TSpeedButton;
    Series4: TLineSeries;
    ValidateAllButton: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure SortReport;
    procedure BenchmarkButtonClick(Sender: TObject);
    procedure SaveTestResultsSpeedButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ValidateButtonClick(Sender: TObject);
    procedure SubBenchmark1EditClick(Sender: TObject);
    procedure SubBenchmark2EditClick(Sender: TObject);
    procedure SubBenchmark3EditClick(Sender: TObject);
    procedure BenchmarkEditClick(Sender: TObject);
    procedure SubBenchmark4EditClick(Sender: TObject);
    procedure SubBenchmark5EditClick(Sender: TObject);
    procedure BestBenchmarkEditClick(Sender: TObject);
    procedure BenchmarkTwiceButtonClick(Sender: TObject);
    procedure BenchThreeTimesButtonClick(Sender: TObject);
    procedure NoOfMBytesPerSecAverageEditClick(Sender: TObject);
    procedure FunctionSelectComboBoxChange(Sender: TObject);
    procedure BenchmarkAllButtonClick(Sender: TObject);
    procedure PrintSpeedButtonClick(Sender: TObject);
    procedure SubBenchmark5SpeedButtonClick(Sender: TObject);
    procedure SubBenchmark1SpeedButtonClick(Sender: TObject);
    procedure SubBenchmark2SpeedButtonClick(Sender: TObject);
    procedure SubBenchmark3SpeedButtonClick(Sender: TObject);
    procedure SubBenchmark4SpeedButtonClick(Sender: TObject);
    procedure ShowOptionsSpeedButtonClick(Sender: TObject);
    procedure CopyChartToClipboardSpeedButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    //POLLUTEARRAYSIZE : Integer = 2097152;//2MB
    PolluteArraySize : Integer;//Set in initialization to actual L2 cache size
    ShowMessage : Boolean;
    procedure SortRichEditByBench;
    procedure SortRichEditBySubBench1;
    procedure SortRichEditBySubBench2;
    procedure SortRichEditBySubBench3;
    procedure SortRichEditBySubBench4;
    procedure SortRichEditBySubBench5;
    procedure ClearGUI;
    procedure Benchmark;
    procedure SelectFunction(FunctionID : Cardinal);
    function ValidateOverlappedLeftByte : Boolean;
    function ValidateOverlappedRigthByte : Boolean;
    function ValidateOverlappedLeftCardinal : Boolean;
    function ValidateOverlappedRigthCardinal : Boolean;
    function ValidateBigOverlappedLeftCardinal : Boolean;
    function ValidateBigOverlappedRigthCardinal : Boolean;
    function WithoutCacheFlushes : Extended;
    function WithCacheFlushes : Extended;
    function WithCacheCompetition : Extended;
    function TinyMovesWithoutCacheFlushes : Extended;
    function BenchmarkOverlappedRigth : Extended;
  public
    procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  K1 : Integer;

implementation

uses
 MoveUnit, SystemInfoUnit, OptionsUnit, MoveDKCUnit, FastcodeCPUID,
 MoveJOHUnit10;

type
 TMoveProc = procedure(const Source; var Dest; Count : Integer);

const
 //
 SUBBENCHMARKH1ADJUST : Double = 0.35;
 SUBBENCHMARKH2ADJUST : Double = 1.6;//2.20;
 SUBBENCHMARKH3ADJUST : Double = 0.83;
 SUBBENCHMARKH4ADJUST : Double = 3.08;//4.00;
 SUBBENCHMARKH5ADJUST : Double = 0.1215;//0.15;

{$R *.dfm}

var
 MoveProc : TMoveProc;

//This function invalidates cache lines by filling in data in "PolluteArray"
//The Step parameter selects cachelines.
//If it is 1 then every 32 byte is touched and evicted from the caches.
//This is every cache line on P6

procedure InvalidateCaches(Step : Cardinal);
var
 PolluteArray : array[1..2048000] of Byte;
 I : Integer;
const
 ArraySize : Integer = 2048000;//2M

begin
 I := 1;
 repeat
  PolluteArray[I] := 6;
  Inc(I, Step*32);
 until(I >= ArraySize);
end;

function IsNumericDKC(C : Char) : Boolean;
var
 B : Byte;

begin
 B := Ord(C);
 if ((48 <= B) and (B <= 57)) then
  Result := True
 else
  Result := False;
end;

function HexToInt(C : Char) : Integer;
begin
 if IsNumericDKC(C) then
  Result := StrToInt(C)
 else if (C = 'A') then
  Result := 10
  else if (C = 'B') then
  Result := 11
 else if (C = 'C') then
  Result := 12
 else if (C = 'D') then
  Result := 13
 else if (C = 'E') then
  Result := 14
 else if (C = 'F') then
  Result := 15
 else
  Result := 99999;//error
end;

//This sub benchmark is testing Move speed in MB/sec on static arrays of size [8;ARRAYSIZEMAX-1]
//Source and destination arrays are 1, 2, 4, 8 & 16 byte aligned
//The benchmark is the average number of M bytes moved per second across arraysizes and alignment

function TMainForm.WithoutCacheFlushes : Extended;
var
 SourceArray : array[0..4000031] of Byte;//3 MB + possible space for alignment
 DestinationArray : array[0..4000031] of Byte;
 I, K, Kmax, RunNo, Alignment : Cardinal;
 OffsetSrc, OffsetDest : Integer;
 NoOfBytesPerSec, NoOfMBytesPerSec, NoOfMBytesPerSecTotal, NoOfMBytesPerSecMax,
 NoOfMBytesPerSecMin : Int64;
 NoOfBytesFP, RunTimeSec, NoOfMBytesPerSecAverage : Extended;
 ArraySize, NoOfBytes : Int64;
 X, Y : Pointer;
 lpFrequency, lpPerformanceCount, StartCount, EndCount,
 NoOfTicks : TLargeInteger;
 Succes : Boolean;
 XAddress, YAddress : AnsiString;
const
 ARRAYSIZEMAX : Cardinal = 3999999;
 ARRAYGROWFACTOR : Double = 1.35;
 ARRAYSIZESTART : Cardinal = 2;
 RUNNOMAX : Cardinal = 40000000; //Must be bigger than Arraysize or some big blocks will not be run
 WANTEDALIGNMENT : Cardinal = 0;//0->15, 0 is 16 byte alignment

begin
 StatusBar1.SimpleText := 'Running Sub Benchmark: WithoutCacheFlushes';
 SummedNoOfMBytesPerSecEdit.Text := '';
 SummedArraySizeEdit.Text := '';
 NoOfMBytesPerSecMaxEdit.Text := '';
 ProgressBar1.Position := 0;
 NoOfMBytesPerSecAverage := 0;
 Chart1.BottomAxis.Maximum := ARRAYSIZEMAX;
 Series1.Clear;
 //Align Source
 OffsetSrc := -1;
 repeat
  Inc(OffsetSrc);
  X := @SourceArray[OffsetSrc];
  XAddress := IntToHex(Integer(X), 8);
  Alignment := HexToInt(XAddress[8]);
 until(Alignment = WANTEDALIGNMENT);
 //Align Destination
 OffsetDest := -1;
 repeat
  Inc(OffsetDest);
  Y := @DestinationArray[OffsetDest];
  YAddress := IntToHex(Integer(Y), 8);
  Alignment := HexToInt(YAddress[8]);
 until(Alignment = WANTEDALIGNMENT);
 AddressSourceEdit.Text := IntToHex(Integer(X), 8);
 AddressDestEdit.Text := IntToHex(Integer(Y), 8);
 ProgressBar1.Max := 47;
 ArraySize := ARRAYSIZESTART;
 NoOfMBytesPerSecTotal := 0;
 NoOfMBytesPerSecMax := 0;
 NoOfMBytesPerSecMin := 99999999;
 //Initialize arrays
 for I := 0 to Length(SourceArray)-1 do
  begin
   SourceArray[I] := 255;
   DestinationArray[I] := 1;
  end;
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 RunNo := 1;
 while (ArraySize < ARRAYSIZEMAX) do
  begin
   SummedArraySizeEdit.Text := MainForm.SummedArraySizeEdit.Text + IntToStr(ArraySize) + ';';
   if ArraySize > Length(DestinationArray) then
    raise Exception.Create('ArraySize to big');
   ArraySizeLabeledEdit.Text := IntToStr(ArraySize);
   Update;
   Application.ProcessMessages;
   Kmax := Round(RUNNOMAX / ArraySize);//Adjust Kmax because more runs are needed on small blocks than on big blocks
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for K := 1 to Kmax do
    begin
     //Function to benchmark
     MoveProc(SourceArray[OffsetSrc+0], DestinationArray[OffsetDest+0], ArraySize);//16, 16 byte aligned move
     MoveProc(SourceArray[OffsetSrc+0], DestinationArray[OffsetDest+1], ArraySize);//16, 1 byte aligned move
     MoveProc(SourceArray[OffsetSrc+0], DestinationArray[OffsetDest+2], ArraySize);//16, 2 byte aligned move
     MoveProc(SourceArray[OffsetSrc+0], DestinationArray[OffsetDest+4], ArraySize);//16, 4 byte aligned move
     MoveProc(SourceArray[OffsetSrc+0], DestinationArray[OffsetDest+8], ArraySize);//16, 8 byte aligned move

     MoveProc(SourceArray[OffsetSrc+1], DestinationArray[OffsetDest+0], ArraySize);//1, 16 byte aligned move
     MoveProc(SourceArray[OffsetSrc+1], DestinationArray[OffsetDest+1], ArraySize);//1, 1 byte aligned move
     MoveProc(SourceArray[OffsetSrc+1], DestinationArray[OffsetDest+2], ArraySize);//1, 2 byte aligned move
     MoveProc(SourceArray[OffsetSrc+1], DestinationArray[OffsetDest+4], ArraySize);//1, 4 byte aligned move
     MoveProc(SourceArray[OffsetSrc+1], DestinationArray[OffsetDest+8], ArraySize);//1, 8 byte aligned move

     MoveProc(SourceArray[OffsetSrc+2], DestinationArray[OffsetDest+0], ArraySize);//2, 16 byte aligned move
     MoveProc(SourceArray[OffsetSrc+2], DestinationArray[OffsetDest+1], ArraySize);//2, 1 byte aligned move
     MoveProc(SourceArray[OffsetSrc+2], DestinationArray[OffsetDest+2], ArraySize);//2, 2 byte aligned move
     MoveProc(SourceArray[OffsetSrc+2], DestinationArray[OffsetDest+4], ArraySize);//2, 4 byte aligned move
     MoveProc(SourceArray[OffsetSrc+2], DestinationArray[OffsetDest+8], ArraySize);//2, 8 byte aligned move

     MoveProc(SourceArray[OffsetSrc+4], DestinationArray[OffsetDest+0], ArraySize);//4, 16 byte aligned move
     MoveProc(SourceArray[OffsetSrc+4], DestinationArray[OffsetDest+1], ArraySize);//4, 1 byte aligned move
     MoveProc(SourceArray[OffsetSrc+4], DestinationArray[OffsetDest+2], ArraySize);//4, 2 byte aligned move
     MoveProc(SourceArray[OffsetSrc+4], DestinationArray[OffsetDest+4], ArraySize);//4, 4 byte aligned move
     MoveProc(SourceArray[OffsetSrc+4], DestinationArray[OffsetDest+8], ArraySize);//4, 8 byte aligned move

     MoveProc(SourceArray[OffsetSrc+8], DestinationArray[OffsetDest+0], ArraySize);//8, 16 byte aligned move
     MoveProc(SourceArray[OffsetSrc+8], DestinationArray[OffsetDest+1], ArraySize);//8, 1 byte aligned move
     MoveProc(SourceArray[OffsetSrc+8], DestinationArray[OffsetDest+2], ArraySize);//8, 2 byte aligned move
     MoveProc(SourceArray[OffsetSrc+8], DestinationArray[OffsetDest+4], ArraySize);//8, 4 byte aligned move
     MoveProc(SourceArray[OffsetSrc+8], DestinationArray[OffsetDest+8], ArraySize);//8, 8 byte aligned move
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   RunTimeSec := NoOfTicks / lpFrequency;
   RunTimeEdit.Text := FloatToStrF(RunTimeSec, ffFixed, 9, 1);
   NoOfBytes := 25 * ArraySize * Kmax;//25 is number of Move calls
   NoOfBytesFP := NoOfBytes;
   if RunTimeSec <> 0 then
    NoOfBytesPerSec := Round(NoOfBytesFP / RunTimeSec)
   else
    NoOfBytesPerSec := 0;
   NoOfMBytesPerSec := Round(NoOfBytesPerSec / 1024 / 1024);
   Series1.AddXY(ArraySize, NoOfMBytesPerSec, '', clRed);
   NoOfMBytesPerSecEdit.Text := IntToStr(NoOfMBytesPerSec);
   NoOfMBytesPerSecTotal := NoOfMBytesPerSecTotal + NoOfMBytesPerSec;
   NoOfMBytesPerSecTotalEdit.Text := IntToStr(NoOfMBytesPerSecTotal);
   NoOfMBytesPerSecAverage := NoOfMBytesPerSecTotal / RunNo;
   NoOfMBytesPerSecAverageEdit.Text := FloatToStrF(NoOfMBytesPerSecAverage, ffFixed, 9, 0);
   if NoOfMBytesPerSec < NoOfMBytesPerSecMin then
    NoOfMBytesPerSecMin := NoOfMBytesPerSec;
   NoOfMBytesPerSecMinEdit.Text := IntToStr(NoOfMBytesPerSecMin);
   if NoOfMBytesPerSec > NoOfMBytesPerSecMax then
    NoOfMBytesPerSecMax := NoOfMBytesPerSec;
   NoOfMBytesPerSecMaxEdit.Text := IntToStr(NoOfMBytesPerSecMax);
   SummedNoOfMBytesPerSecEdit.Text :=  MainForm.SummedNoOfMBytesPerSecEdit.Text +  MainForm.NoOfMBytesPerSecEdit.Text + ';';
   ProgressBar1.Position := RunNo;
   ArraySize := Round(ArraySize * ARRAYGROWFACTOR);
   Inc(RunNo);
   Update;
  end;
 StatusBar1.SimpleText := 'Finished';
 Result := NoOfMBytesPerSecAverage;
end;

function TMainForm.WithCacheFlushes : Extended;
var
 SourceArray : array[0..4000031] of Byte;
 DestinationArray : array[0..4000031] of Byte;
 I, K, Kmax, RunNo : Cardinal;
 NoOfBytesPerSec, NoOfMBytesPerSec, NoOfMBytesPerSecTotal, NoOfMBytesPerSecMax,
 NoOfMBytesPerSecMin : Int64;
 NoOfBytesFP, RunTimeSec, NoOfMBytesPerSecAverage : Extended;
 ArraySize, NoOfBytes : Int64;
 X, Y : Pointer;
 lpFrequency, lpPerformanceCount, StartCount, EndCount,
 StartInvalidateCacheCount, EndInvalidateCacheCount, NoOfTicks, SumOfCacheFlushes : TLargeInteger;
 Succes : Boolean;
 OffsetSrc, OffsetDest, Alignment : Integer;
 XAddress, YAddress : AnsiString;
 PolluteArray : array[1..2097152] of Byte; //2 MB
 I2, Step : Integer;

const
 ARRAYGROWFACTOR : Double = 1.30;
 ARRAYSIZESTART : Cardinal = 128;
 ARRAYSIZEMAX : Cardinal = 3999999;
 RUNNOMAX : Cardinal = 10000000; //Must be bigger than Arraysize or some big blocks will not be run
 CACHEFLUSHADJUST : Cardinal = 1;//1->4000 If 1 then all cache lines are flushed. If 4000 only one line is flushed
 WANTEDALIGNMENT : Integer = 4;//0->15, 0 is 16 byte alignment

begin
 Chart1.BottomAxis.Maximum := 4000000;
 StatusBar1.SimpleText := 'Running Sub Benchmark: WithCacheFlushes';
 SummedNoOfMBytesPerSecEdit.Text := '';
 SummedArraySizeEdit.Text := '';
 NoOfMBytesPerSecMaxEdit.Text := '';
 ProgressBar1.Position := 0;
 //Align Source
 OffsetSrc := -1;
 repeat
  Inc(OffsetSrc);
  X := @SourceArray[OffsetSrc];
  XAddress := IntToHex(Integer(X), 8);
  Alignment := HexToInt(XAddress[8]);
 until(Alignment = WANTEDALIGNMENT);
 //Align Destination
 OffsetDest := -1;
 repeat
  Inc(OffsetDest);
  Y := @DestinationArray[OffsetDest];
  YAddress := IntToHex(Integer(Y), 8);
  Alignment := HexToInt(YAddress[8]);
 until(Alignment = WANTEDALIGNMENT);
 X := @SourceArray[OffsetSrc];
 Y := @DestinationArray[OffsetDest];
 AddressSourceEdit.Text := IntToHex(Integer(X), 8);
 AddressDestEdit.Text := IntToHex(Integer(Y), 8);
 ProgressBar1.Max := 37;
 ArraySize := ARRAYSIZESTART;
 NoOfMBytesPerSecTotal := 0;
 NoOfMBytesPerSecMax := 0;
 NoOfMBytesPerSecMin := 99999999;
 NoOfMBytesPerSecAverage := 0;
 Series2.Clear;
 //Initialize arrays
 for I := 0 to ARRAYSIZEMAX do
  begin
   SourceArray[I] := 255;
   DestinationArray[I] := 1;
  end;
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 RunNo := 1;
 while (ArraySize < ARRAYSIZEMAX) do
  begin
   SummedArraySizeEdit.Text := MainForm.SummedArraySizeEdit.Text + IntToStr(ArraySize) + ';';
   if ArraySize > Length(DestinationArray) then
    raise Exception.Create('ArraySize to big');
   ArraySizeLabeledEdit.Text := IntToStr(ArraySize);
   Application.ProcessMessages;
   Kmax := Round(RUNNOMAX / ArraySize);//Adjust Kmax because more runs are needed on small blocks than on big blocks
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   SumOfCacheFlushes := 0;
   for K := 1 to Kmax do
    begin
     QueryPerformanceCounter(lpPerformanceCount);
     StartInvalidateCacheCount := lpPerformanceCount;
     //InvalidateCaches(CACHEFLUSHADJUST);
     //Must be inlined because compiler ...... on each call
     I2 := 1;
     repeat
      PolluteArray[I2] := 6;
      Inc(I2, CACHEFLUSHADJUST*32);
     until(I2 >= POLLUTEARRAYSIZE);
     QueryPerformanceCounter(lpPerformanceCount);
     EndInvalidateCacheCount := lpPerformanceCount;
     SumOfCacheFlushes := SumOfCacheFlushes + (EndInvalidateCacheCount - StartInvalidateCacheCount);
     //Function to benchmark
     MoveProc(SourceArray[OffsetSrc], DestinationArray[OffsetDest], ArraySize);
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount - SumOfCacheFlushes;
   RunTimeSec := NoOfTicks / lpFrequency;
   RunTimeEdit.Text := FloatToStrF(RunTimeSec, ffFixed, 9, 1);
   NoOfBytes := ArraySize * Kmax;
   NoOfBytesFP := NoOfBytes;
   if RunTimeSec <> 0 then
    NoOfBytesPerSec := Round(NoOfBytesFP / RunTimeSec)
   else
    NoOfBytesPerSec := 0;
   NoOfMBytesPerSec := Round(NoOfBytesPerSec / 1024 / 1024);
   Series2.AddXY(ArraySize, NoOfMBytesPerSec, '', clBlue);
   NoOfMBytesPerSecEdit.Text := IntToStr(NoOfMBytesPerSec);
   NoOfMBytesPerSecTotal := NoOfMBytesPerSecTotal + NoOfMBytesPerSec;
   NoOfMBytesPerSecTotalEdit.Text := IntToStr(NoOfMBytesPerSecTotal);
   NoOfMBytesPerSecAverage := NoOfMBytesPerSecTotal / RunNo;
   NoOfMBytesPerSecAverageEdit.Text := FloatToStrF(NoOfMBytesPerSecAverage, ffFixed, 9, 0);
   if NoOfMBytesPerSec < NoOfMBytesPerSecMin then
    NoOfMBytesPerSecMin := NoOfMBytesPerSec;
   NoOfMBytesPerSecMinEdit.Text := IntToStr(NoOfMBytesPerSecMin);
   if NoOfMBytesPerSec > NoOfMBytesPerSecMax then
    NoOfMBytesPerSecMax := NoOfMBytesPerSec;
   NoOfMBytesPerSecMaxEdit.Text := IntToStr(NoOfMBytesPerSecMax);
   SummedNoOfMBytesPerSecEdit.Text :=  MainForm.SummedNoOfMBytesPerSecEdit.Text +  MainForm.NoOfMBytesPerSecEdit.Text + ';';
   ProgressBar1.Position := RunNo;
   ArraySize := Round(ArraySize * ARRAYGROWFACTOR);
   Inc(RunNo);
   Application.ProcessMessages;
  end;
 //TextRichEdit.Lines.Add(MainForm.SummedNoOfMBytesPerSecEdit.Text);
 StatusBar1.SimpleText := 'Finished';
 Result := NoOfMBytesPerSecAverage;
end;

//This benchmark uses four static arrays of byte, size 2MB
//Move is called repeatedly on two sets of arrays. One array is of size X and the other is MaxSize - X
//The two array sets competes on the cache, which is never big enough to hold all 4 arrays
//The number of bytes "moved" is always MaxSize
//As X changes the ration between array sizes change
//The move speed is recorded for each X
//After N runs statistics is computed; Max -, Min - & Average - copy speed
//Average copy speed is the benchmark

function TMainForm.WithCacheCompetition : Extended;
var
 SourceArray1 : array[1..2000000] of Byte;
 DestinationArray1 : array[1..2000000] of Byte;
 SourceArray2 : array[1..2000000] of Byte;
 DestinationArray2 : array[1..2000000] of Byte;
 I, K, Kmax, RunNo : Cardinal;
 NoOfBytesPerSec, NoOfMBytesPerSec, NoOfMBytesPerSecTotal, NoOfMBytesPerSecMax,
 NoOfMBytesPerSecMin : Int64;
 NoOfBytesFP, RunTimeSec, NoOfMBytesPerSecAverage : Extended;
 ArraySize, NoOfBytes : Int64;
 X1, X2, Y1, Y2 : Pointer;
 lpFrequency, lpPerformanceCount, StartCount, EndCount,
 NoOfTicks : TLargeInteger;
 Succes : Boolean;
const
 ARRAYGROWFACTOR : Double = 1.35;
 ARRAYSIZESTART : Cardinal = 2;
 RUNNOMAX : Cardinal = 100;
 ARRAYSIZEMAX : Cardinal = 2000000;

begin
 StatusBar1.SimpleText := 'Running Sub Benchmark: WithCacheCompetition';
 SummedNoOfMBytesPerSecEdit.Text := '';
 SummedArraySizeEdit.Text := '';
 NoOfMBytesPerSecMaxEdit.Text := '';
 ProgressBar1.Position := 0;
 NoOfMBytesPerSecAverage := 0;
 X1 := @SourceArray1;
 Y1 := @DestinationArray1;
 X2 := @SourceArray2;
 Y2 := @DestinationArray2;
 AddressSourceEdit.Text := IntToHex(Integer(X1), 8) + '/' + IntToHex(Integer(X2), 8);
 AddressDestEdit.Text := IntToHex(Integer(Y1), 8) + '/' + IntToHex(Integer(Y2), 8);
 ProgressBar1.Max := 47;
 ArraySize := ARRAYSIZESTART;
 NoOfMBytesPerSecTotal := 0;
 NoOfMBytesPerSecMax := 0;
 NoOfMBytesPerSecMin := 99999999;
 Series3.Clear;
 //Initialize arrays
 for I := 1 to ARRAYSIZEMAX do
  begin
   SourceArray1[I] := 255;
   DestinationArray1[I] := 1;
   SourceArray2[I] := 255;
   DestinationArray2[I] := 1;
  end;
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 RunNo := 1;
 while (ArraySize < ARRAYSIZEMAX) do
  begin
   SummedArraySizeEdit.Text := MainForm.SummedArraySizeEdit.Text + IntToStr(ArraySize) + ';';
   if ArraySize > Length(DestinationArray1) then
    raise Exception.Create('ArraySize to big');
   ArraySizeLabeledEdit.Text := IntToStr(ArraySize);
   Update;
   Kmax := RUNNOMAX;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for K := 1 to Kmax do
    begin
     //Function to benchmark
     MoveProc(SourceArray1, DestinationArray1, ArraySize);
     MoveProc(SourceArray2, DestinationArray2, ARRAYSIZEMAX - ArraySize);
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   RunTimeSec := NoOfTicks / lpFrequency;
   RunTimeEdit.Text := FloatToStrF(RunTimeSec, ffFixed, 9, 1);
   NoOfBytes := ARRAYSIZEMAX * Kmax;
   NoOfBytesFP := NoOfBytes;
   if RunTimeSec <> 0 then
    NoOfBytesPerSec := Round(NoOfBytesFP / RunTimeSec)
   else
    NoOfBytesPerSec := 0;
   NoOfMBytesPerSec := Round(NoOfBytesPerSec / 1024 / 1024);
   NoOfMBytesPerSecEdit.Text := IntToStr(NoOfMBytesPerSec);
   Series3.AddXY(ArraySize, NoOfMBytesPerSec, '', clGreen);
   NoOfMBytesPerSecTotal := NoOfMBytesPerSecTotal + NoOfMBytesPerSec;
   NoOfMBytesPerSecTotalEdit.Text := IntToStr(NoOfMBytesPerSecTotal);
   NoOfMBytesPerSecAverage := NoOfMBytesPerSecTotal / RunNo;
   NoOfMBytesPerSecAverageEdit.Text := FloatToStrF(NoOfMBytesPerSecTotal / RunNo, ffFixed, 9, 0);
   if NoOfMBytesPerSec < NoOfMBytesPerSecMin then
    NoOfMBytesPerSecMin := NoOfMBytesPerSec;
   NoOfMBytesPerSecMinEdit.Text := IntToStr(NoOfMBytesPerSecMin);
   if NoOfMBytesPerSec > NoOfMBytesPerSecMax then
    NoOfMBytesPerSecMax := NoOfMBytesPerSec;
   NoOfMBytesPerSecMaxEdit.Text := IntToStr(NoOfMBytesPerSecMax);
   SummedNoOfMBytesPerSecEdit.Text :=  MainForm.SummedNoOfMBytesPerSecEdit.Text +  MainForm.NoOfMBytesPerSecEdit.Text + ';';
   ProgressBar1.Position := RunNo;
   ArraySize := Round(ArraySize * ARRAYGROWFACTOR);
   Inc(RunNo);
   Update;
  end;
 //TextRichEdit.Lines.Add(MainForm.SummedNoOfMBytesPerSecEdit.Text);
 StatusBar1.SimpleText := 'Finished';
 Result := NoOfMBytesPerSecAverage;
end;

function TMainForm.BenchmarkOverlappedRigth : Extended;
var
 X : array[1..1000] of Byte;
 NoOfDeleteElements, DeletePosition : Cardinal;
 Succes : Boolean;
 Count, lpFrequency, lpPerformanceCount, StartCount, EndCount, NoOfTicks{, SumOfCount} : TLargeInteger;
 RunTimeSec, MBMoved, AverageCopySpeed : Extended;
const
 ARRAYSIZE : Cardinal = 1000;//Remember to recalibrate MBMoved if changed

begin
 //SumOfCount := 0;
 Succes := QueryPerformanceFrequency(lpFrequency);
 if Succes then
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
  end
 else
  raise Exception.Create('QueryPerformanceFrequency failed');
 for NoOfDeleteElements := 1 to ARRAYSIZE div 2 do
  begin
   for DeletePosition := NoOfDeleteElements+1 to ARRAYSIZE-NoOfDeleteElements+1 do
    begin
     Count := DeletePosition-1;
     //SumOfCount := SumOfCount + Count;
     //Function to benchmark
     MoveProc(X[1], X[NoOfDeleteElements+1], Count);
    end;
  end;
 Succes := QueryPerformanceCounter(lpPerformanceCount);
 if Succes then
  EndCount := lpPerformanceCount
 else
  raise Exception.Create('QueryPerformanceCounter failed');
 NoOfTicks := EndCount - StartCount;
 RunTimeSec := NoOfTicks / lpFrequency;
 //MBMoved := (SumOfCount) / (1024 * 1024);
 MBMoved := (125000000) / (1024 * 1024);//only valid for ARRAYSIZE : Cardinal = 100;
 AverageCopySpeed := MBMoved / RunTimeSec;
 NoOfMBytesPerSecEdit.Text := FloatToStrF(AverageCopySpeed, ffFixed, 9, 0);
 RunTimeEdit.Text := FloatToStrF(RunTimeSec, ffFixed, 9, 1);
 StatusBar1.SimpleText := 'Finished';
 Result := AverageCopySpeed;
end;

procedure TMainForm.SortReport;
begin
 if ReportRichEdit.Lines.Count > 1 then
  begin
   case OptionsForm.SortReportByRadioGroup.ItemIndex of
    0 : SortRichEditBySubBench1;
    1 : SortRichEditBySubBench2;
    2 : SortRichEditBySubBench3;
    3 : SortRichEditBySubBench4;
    4 : SortRichEditBySubBench5;
    5 : SortRichEditByBench;
   end;
  end;
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
begin
 Chart1.BottomAxis.Maximum := 2000000;
 Series1.Clear;
 Series2.Clear;
 Series3.Clear;
 Series5.Clear;
 Benchmark;
 SortReport;
end;

procedure TMainForm.SaveTestResultsSpeedButtonClick(Sender: TObject);
begin
 if PageControl.ActivePageIndex = 0 then
  begin
   MessageDlg('No save as functionality defined for this page', mtInformation, [mbOk], 0)
  end
 else if PageControl.ActivePageIndex = 1 then
  begin
   ReportSaveDialog.Filter := 'Text files (*.txt)|*.TXT';
   ReportSaveDialog.FileName := FResultsFileName;
   ReportSaveDialog.Options := [ofOverwritePrompt];
   if ReportSaveDialog.Execute then
    ReportRichEdit.Lines.SaveToFile(ReportSaveDialog.FileName);
  end
end;

procedure TMainForm.ClearGUI;
begin
 Series1.Clear;
 Series2.Clear;
 Series3.Clear;
 Series5.Clear;
 SummedNoOfMBytesPerSecEdit.Text := '';
 SummedArraySizeEdit.Text := '';
 NoOfMBytesPerSecTotalEdit.Text := '';
 NoOfMBytesPerSecMinEdit.Text := '';
 NoOfMBytesPerSecMaxEdit.Text := '';
 NoOfMBytesPerSecAverageEdit.Text := '';
 ErrorEdit.Text := '';
 NoOfMBytesPerSecEdit.Text := '';
 RunTimeEdit.Text := '';
 AddressSourceEdit.Text := '';
 AddressDestEdit.Text := '';
 ArraySizeLabeledEdit.Text := '';
 SubBenchmark1Edit.Text := '';
 SubBenchmark2Edit.Text := '';
 SubBenchmark3Edit.Text := '';
 SubBenchmark4Edit.Text := '';
 SubBenchmark5Edit.Text := '';
 BenchmarkEdit.Text := '';
 BestBenchmarkEdit.Text := '';
 AllBenchmarkEdit.Text := '';
 Chart1.Title.Text.Clear;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
 L2CacheSize : Cardinal;
 CpuString : string;
begin
 ClearGUI;
 ReportRichEdit.Clear;
 ReportRichEdit.Paragraph.TabCount := 7;
 ReportRichEdit.Paragraph.Tab[0] := 90;
 ReportRichEdit.Paragraph.Tab[1] := 105;
 ReportRichEdit.Paragraph.Tab[2] := 140;
 ReportRichEdit.Paragraph.Tab[3] := 175;
 ReportRichEdit.Paragraph.Tab[4] := 210;
 ReportRichEdit.Paragraph.Tab[5] := 245;
 ReportRichEdit.Paragraph.Tab[6] := 290;
 ShowMessage := True;
 FunctionSelectComboBox.ItemIndex := 0;
 FunctionSelectComboBoxChange(nil);
 L2CacheSize := CPU.L2CacheSize * 1024;
 PolluteArraySize := L2CacheSize;

 Caption := Format('%s   (%s with %s) (%s : %s)', [Caption, SystemInfoCompiler, SystemInfoCompilerSettings, FastCodeTargetStr[FastCodeTarget], SystemInfoCPUDetails]);

 case FastCodeTarget of
  fctRTLReplacement,
  fctBlendedIA32,
  fctBlendedMMX,
  fctBlendedSSE,
  fctBlendedSSE2 : CpuString := Format('%s_%s_F%d_M%d', [FastCodeTargetStr[FastCodeTarget], VendorStr[CPU.Vendor], CPU.EffFamily, CPU.EffModel ]);
  else CpuString := FastCodeTargetStr[FastCodeTarget];
 end;

 FValidationFileName := Format('%s_%s_Validation_%s.txt', [CHALLENGE_NAME,GetFormattedVersion, CpuString]);
 FBenchmarkFileName := Format('%s_%s_Benchmark_%s.txt', [CHALLENGE_NAME,GetFormattedVersion, CpuString]);
 FResultsFileName  := Format('%s_%s_Results_%s.txt', [CHALLENGE_NAME,GetFormattedVersion,CpuString]);

 FResultList := TStringList.Create;

 if ParamCount > 0 then
   PostMessage(Handle, WM_POSTPROCESSING, 0, 0)
end;

{$HINTS OFF}

procedure MoveValidate(const Source; var Dest; Count : Integer);
var
 EBXRegisterBefore, ESIRegisterBefore, EDIRegisterBefore,
 EBXRegisterAfter,  ESIRegisterAfter,  EDIRegisterAfter : Cardinal;
 X, Y, Z : Extended;
begin
 //Function to validate
 asm
  mov EBXRegisterBefore, ebx
  mov EDIRegisterBefore, edi
  mov ESIRegisterBefore, esi
 end;
 MoveProc(Source, Dest, Count);
 asm
  mov EBXRegisterAfter, ebx
  mov EDIRegisterAfter, edi
  mov ESIRegisterAfter, esi
 end;
 //Verify that registers are preserved
 if ((EBXRegisterAfter <> EBXRegisterBefore) or
     (EDIRegisterAfter <> EDIRegisterBefore) or
     (ESIRegisterAfter <> ESIRegisterBefore)) then
  raise Exception.Create('EBX, EDI or ESI register not preserved');
 try
  X := 2;
  Y := 3;
  Z := X * Y;
  if Z <> 6 then
   Z := 6;
 except
  raise Exception.Create('EMMS is missing');
 end;
end;

{$HINTS ON}

//Only validates moves to the left

function TMainForm.ValidateOverlappedLeftByte : Boolean;
var
 X : array[1..255] of Byte;
 I1, I2, I3, I4, I5, I6, NoOfDeleteElements, DeletePosition : Cardinal;
const
 ARRAYSIZE : Cardinal = 255;//Must be < 255

begin
 ProgressBar1.Max := ARRAYSIZE div 2;
 ProgressBar1.Position := 0;
 Result := True;
 for NoOfDeleteElements := 1 to ARRAYSIZE div 2 do
  begin
   for DeletePosition := 1 to ARRAYSIZE-2*(NoOfDeleteElements)+1 do
    begin
     //Initialize array
     for I1 := 1 to ARRAYSIZE do
      begin
       X[I1] := I1;
      end;
     //"Delete" elements
     for I2 := DeletePosition to DeletePosition+NoOfDeleteElements-1 do
      begin
       X[I2] := 0;
      end;
     //Move elements in place
     MoveValidate(X[DeletePosition+NoOfDeleteElements], X[DeletePosition], ARRAYSIZE-NoOfDeleteElements-DeletePosition+1);
     //Validate rest is not changed
     for I3 := ARRAYSIZE-NoOfDeleteElements+1 to ARRAYSIZE do
      begin
       if X[I3] <> I3 then
        Result := False;
      end;
     //"Delete" the rest (Just for fun)
     for I4 := ARRAYSIZE-NoOfDeleteElements+1 to ARRAYSIZE do
      begin
       X[I4] := 0;
      end;
     //Verify
     for I5 := 1 to DeletePosition-1 do
      begin
       if X[I5] <> I5 then
        Result := False;
      end;
     for I6 := DeletePosition to ARRAYSIZE-NoOfDeleteElements do
      begin
       if X[I6] <> I6 + NoOfDeleteElements then
        Result := False;
      end;
     if Result = False then
      Break;
    end;
   ProgressBar1.Position := NoOfDeleteElements;
   if Result = False then
    Break;
  end;
end;

function TMainForm.ValidateOverlappedLeftCardinal : Boolean;
var
 X : array[1..600] of Cardinal;
 I1, I2, I3, I4, I5, I6, NoOfDeleteElements, DeletePosition : Cardinal;
const
 ARRAYSIZE : Cardinal = 600;

begin
 ProgressBar1.Max := ARRAYSIZE div 2;
 ProgressBar1.Position := 0;
 Result := True;
 for NoOfDeleteElements := 1 to ARRAYSIZE div 2 do
  begin
   for DeletePosition := 1 to ARRAYSIZE-2*(NoOfDeleteElements)+1 do
    begin
     //Initialize array
     for I1 := 1 to ARRAYSIZE do
      begin
       X[I1] := I1;
      end;
     //"Delete" elements
     for I2 := DeletePosition to DeletePosition+NoOfDeleteElements-1 do
      begin
       X[I2] := 0;
      end;
     //Move elements in place
     MoveValidate(X[DeletePosition+NoOfDeleteElements], X[DeletePosition], 4*(ARRAYSIZE-NoOfDeleteElements-DeletePosition+1));
     //Validate rest is not changed
     for I3 := ARRAYSIZE-NoOfDeleteElements+1 to ARRAYSIZE do
      begin
       if X[I3] <> I3 then
        Result := False;
      end;
     //"Delete" the rest (Just for fun)
     for I4 := ARRAYSIZE-NoOfDeleteElements+1 to ARRAYSIZE do
      begin
       X[I4] := 0;
      end;
     //Verify
     for I5 := 1 to DeletePosition-1 do
      begin
       if X[I5] <> I5 then
        Result := False;
      end;
     for I6 := DeletePosition to ARRAYSIZE-NoOfDeleteElements do
      begin
       if X[I6] <> I6 + NoOfDeleteElements then
        Result := False;
      end;
     if Result = False then
      Break;
    end;
   ProgressBar1.Position := NoOfDeleteElements;
   Update;
   if Result = False then
    Break;
  end;
end;

//Only validates moves to the rigth

function TMainForm.ValidateOverlappedRigthByte : Boolean;
var
 X : array[1..255] of Byte;
 I1, I2, I3, I4, I5, I6, NoOfDeleteElements, DeletePosition : Cardinal;
const
 ARRAYSIZE : Cardinal = 255;

begin
 ProgressBar1.Max := ARRAYSIZE div 2;
 ProgressBar1.Position := 0;
 Result := True;
 for NoOfDeleteElements := 1 to ARRAYSIZE div 2 do
  begin
   for DeletePosition := NoOfDeleteElements+1 to ARRAYSIZE-NoOfDeleteElements+1 do
    begin
     //Initialize array
     for I1 := 1 to ARRAYSIZE do
      begin
       X[I1] := I1;
      end;
     //"Delete" elements
     for I2 := DeletePosition to DeletePosition+NoOfDeleteElements-1 do
      begin
       X[I2] := 0;
      end;
     //Move elements in place
     MoveValidate(X[1], X[NoOfDeleteElements+1], DeletePosition-1);
     //Validate rest is not changed
     for I3 := 1 to NoOfDeleteElements do
      begin
       if X[I3] <> I3 then
        Result := False;
      end;
     //"Delete" the rest (Just for fun)
     for I4 := 1 to NoOfDeleteElements do
      begin
       X[I4] := 0;
      end;
     //Verify
     for I5 := NoOfDeleteElements+1 to DeletePosition+NoOfDeleteElements-1 do
      begin
       if X[I5] <> I5 - NoOfDeleteElements then
        Result := False;
      end;
     for I6 := DeletePosition+NoOfDeleteElements to ARRAYSIZE do
      begin
       if X[I6] <> I6 then
        Result := False;
      end;
     if Result = False then
      Break;
    end;
   ProgressBar1.Position := NoOfDeleteElements;
   if Result = False then
    Break;
  end;
end;

function TMainForm.ValidateOverlappedRigthCardinal : Boolean;
var
 X : array[1..2000] of Cardinal;
 I1, I2, I3, I4, I5, I6, NoOfDeleteElements, DeletePosition : Cardinal;
const
 ARRAYSIZE : Cardinal = 2000;

begin
 ProgressBar1.Max := ARRAYSIZE div 2;
 ProgressBar1.Position := 0;
 Result := True;
 for NoOfDeleteElements := 1 to ARRAYSIZE div 2 do
  begin
   for DeletePosition := NoOfDeleteElements+1 to ARRAYSIZE-NoOfDeleteElements+1 do
    begin
     //Initialize array
     for I1 := 1 to ARRAYSIZE do
      begin
       X[I1] := I1;
      end;
     //"Delete" elements
     for I2 := DeletePosition to DeletePosition+NoOfDeleteElements-1 do
      begin
       X[I2] := 0;
      end;
     //Move elements in place
     MoveValidate(X[1], X[NoOfDeleteElements+1], 4*(DeletePosition-1));
     //Validate rest is not changed
     for I3 := 1 to NoOfDeleteElements do
      begin
       if X[I3] <> I3 then
        Result := False;
      end;
     //"Delete" the rest (Just for fun)
     for I4 := 1 to NoOfDeleteElements do
      begin
       X[I4] := 0;
      end;
     //Verify
     for I5 := NoOfDeleteElements+1 to DeletePosition+NoOfDeleteElements-1 do
      begin
       if X[I5] <> I5 - NoOfDeleteElements then
        Result := False;
      end;
     for I6 := DeletePosition+NoOfDeleteElements to ARRAYSIZE do
      begin
       if X[I6] <> I6 then
        Result := False;
      end;
     if Result = False then
      Break;
    end;
   ProgressBar1.Position := NoOfDeleteElements;
   Update;
   if Result = False then
    Break;
  end;
end;

function TMainForm.ValidateBigOverlappedLeftCardinal : Boolean;
var
 X : array of Cardinal;
 I1, I2, I3, I4, I5, I6, NoOfDeleteElements, DeletePosition, Count : Cardinal;
const
 ARRAYSIZE : Cardinal = 500000;//2 MB
 VALIDATESIZE : Cardinal = 100;

begin
 SetLength(X, ARRAYSIZE+1);
 ProgressBar1.Max := ARRAYSIZE div 2;
 ProgressBar1.Min := ARRAYSIZE div 2 - VALIDATESIZE;
 ProgressBar1.Position := 0;
 Result := True;
 for NoOfDeleteElements := (ARRAYSIZE div 2 - VALIDATESIZE) to (ARRAYSIZE div 2) do
  begin
   for DeletePosition := 1 to ARRAYSIZE-2*(NoOfDeleteElements)+1 do
    begin
     //Initialize array
     for I1 := 1 to ARRAYSIZE do
      begin
       X[I1] := I1;
      end;
     //"Delete" elements
     for I2 := DeletePosition to DeletePosition+NoOfDeleteElements-1 do
      begin
       X[I2] := 0;
      end;
     //Move elements in place
     Count := 4*(ARRAYSIZE-NoOfDeleteElements-DeletePosition+1);
     if Count > 4*ARRAYSIZE then
      raise Exception.Create('Count is to big');
     MoveValidate(X[DeletePosition+NoOfDeleteElements], X[DeletePosition], Count);
     //Validate rest is not changed
     for I3 := ARRAYSIZE-NoOfDeleteElements+1 to ARRAYSIZE do
      begin
       if X[I3] <> I3 then
        Result := False;
      end;
     //"Delete" the rest (Just for fun)
     for I4 := ARRAYSIZE-NoOfDeleteElements+1 to ARRAYSIZE do
      begin
       X[I4] := 0;
      end;
     //Verify
     for I5 := 1 to DeletePosition-1 do
      begin
       if X[I5] <> I5 then
        Result := False;
      end;
     for I6 := DeletePosition to ARRAYSIZE-NoOfDeleteElements do
      begin
       if X[I6] <> I6 + NoOfDeleteElements then
        Result := False;
      end;
     if Result = False then
      Break;
    end;
   ProgressBar1.Position := NoOfDeleteElements;
   Update;
   if Result = False then
    Break;
  end;
 ProgressBar1.Min := 0;
end;

function TMainForm.ValidateBigOverlappedRigthCardinal : Boolean;
var
 X : array of Cardinal;
 I1, I2, I3, I4, I5, I6, NoOfDeleteElements, DeletePosition : Cardinal;
const
 ARRAYSIZE : Cardinal = 500000;
 VALIDATESIZE : Cardinal = 100;

begin
 SetLength(X, ARRAYSIZE+1);
 ProgressBar1.Max := ARRAYSIZE div 2;
 ProgressBar1.Min := ARRAYSIZE div 2 - VALIDATESIZE;
 ProgressBar1.Position := 0;
 Result := True;
 for NoOfDeleteElements := (ARRAYSIZE div 2 - VALIDATESIZE) to ARRAYSIZE div 2 do
  begin
   for DeletePosition := NoOfDeleteElements+1 to ARRAYSIZE-NoOfDeleteElements+1 do
    begin
     //Initialize array
     for I1 := 1 to ARRAYSIZE do
      begin
       X[I1] := I1;
      end;
     //"Delete" elements
     for I2 := DeletePosition to DeletePosition+NoOfDeleteElements-1 do
      begin
       X[I2] := 0;
      end;
     //Move elements in place
     MoveValidate(X[1], X[NoOfDeleteElements+1], 4*(DeletePosition-1));
     //Validate rest is not changed
     for I3 := 1 to NoOfDeleteElements do
      begin
       if X[I3] <> I3 then
        Result := False;
      end;
     //"Delete" the rest (Just for fun)
     for I4 := 1 to NoOfDeleteElements do
      begin
       X[I4] := 0;
      end;
     //Verify
     for I5 := NoOfDeleteElements+1 to DeletePosition+NoOfDeleteElements-1 do
      begin
       if X[I5] <> I5 - NoOfDeleteElements then
        Result := False;
      end;
     for I6 := DeletePosition+NoOfDeleteElements to ARRAYSIZE do
      begin
       if X[I6] <> I6 then
        Result := False;
      end;
     if Result = False then
      Break;
    end;
   ProgressBar1.Position := NoOfDeleteElements;
   Update;
   if Result = False then
    Break;
  end;
 ProgressBar1.Min := 0;
end;

function Validate17 : Boolean;
var
 I, J, K : Integer;
 S1, S2 : AnsiString;
const
 VALIDATEMIN : Integer = 1;
 VALIDATEMAX : Integer = 2000;

begin
 Result := True;
 S1 := '';
 for K := 1 to VALIDATEMIN-1 do
  S1 := S1 + Char(K mod 256);
 for J := VALIDATEMIN to VALIDATEMAX do
  begin
   S1 := S1 + Char(J mod 256);
   S2 := '';
   for I := 1 to Length(S1) do
    begin
     S2 := S2 + 'X';
    end;
   MoveProc(S1[1], S2[1], Length(S1));
   if S1 <> S2 then
    begin
     Result := False;
     Break;
    end;
  end;
end;

function Validate18 : Boolean;
var
 I, J, K : Integer;
 S1, S2 : AnsiString;
const
 VALIDATEMIN : Integer = 10000;
 VALIDATEMAX : Integer = 11000;

begin
 Result := True;
 S1 := '';
 for K := 1 to VALIDATEMIN-1 do
  S1 := S1 + Char(K mod 256);
 for J := VALIDATEMIN to VALIDATEMAX do
  begin
   S1 := S1 + Char(J mod 256);
   S2 := '';
   for I := 1 to Length(S1) do
    begin
     S2 := S2 + 'X';
    end;
   MoveProc(S1[1], S2[1], Length(S1));
   if S1 <> S2 then
    begin
     Result := False;
     Break;
    end;
  end;
end;

function Validate19 : Boolean;
var
 I, J, K : Integer;
 S1, S2 : AnsiString;
const
 VALIDATEMIN : Integer = 100000;
 VALIDATEMAX : Integer = 100100;

begin
 Result := True;
 S1 := '';
 for K := 1 to VALIDATEMIN-1 do
  S1 := S1 + Char(K mod 256);
 for J := VALIDATEMIN to VALIDATEMAX do
  begin
   S1 := S1 + Char(J mod 256);
   S2 := '';
   for I := 1 to Length(S1) do
    begin
     S2 := S2 + 'X';
    end;
   MoveProc(S1[1], S2[1], Length(S1));
   if S1 <> S2 then
    begin
     Result := False;
     Break;
    end;
  end;
end;

function Validate20 : Boolean;
var
 I, J, K : Integer;
 S1, S2 : AnsiString;
const
 VALIDATEMIN : Integer = 1000000;
 VALIDATEMAX : Integer = 1000010;

begin
 Result := True;
 S1 := '';
 for K := 1 to VALIDATEMIN-1 do
  S1 := S1 + Char(K mod 256);
 for J := VALIDATEMIN to VALIDATEMAX do
  begin
   S1 := S1 + Char(J mod 256);
   S2 := '';
   for I := 1 to Length(S1) do
    begin
     S2 := S2 + 'X';
    end;
   MoveProc(S1[1], S2[1], Length(S1));
   if S1 <> S2 then
    begin
     Result := False;
     Break;
    end;
  end;
end;

function Validate21 : Boolean;
var
 I1, I2, J, Size : Integer;
 Src, Dest : array of Byte;
 B : Byte;
const
 VALIDATEMIN : Integer = 4 * 1024 * 1024;
 VALIDATEMAX : Integer = 4 * 1024 * 1024 + 10;

begin
 Result := True;
 for Size := VALIDATEMIN to VALIDATEMAX do
  begin
   for I1 := 0 to 15 do
    begin
     for I2 := 0 to 15 do
      begin
       J := Size + 15;
       SetLength(Src, J);
       SetLength(Dest, J);
       FillChar(Src[0], J, 0);
       FillChar(Dest[0], J, 0);
       B := J mod 256;
       FillChar(Src[I1], Size, B);
       MoveProc(Src[I1], Dest[I2], Size);
       if not CompareMem(@Src[I1], @Dest[I2], Size) then
        begin
         Result := False;
         Exit;
        end;
      end;
    end;
  end;
end;

//Validates functions. If a function does not pass a validation then an exception is raised.

procedure TMainForm.ValidateButtonClick(Sender: TObject);
var
 SourceArray : array[0..1999999] of Byte;
 DestinationArray : array[0..1999999] of Byte;
 ArraySize  : Cardinal;
 I : Cardinal;
 StartTime, EndTime, RunTime : TDateTime;
 Count : Integer;

const
 ARRAYSIZEMAX : Cardinal = 1100000;

begin
 ErrorEdit.Color := clGreen;
 ErrorEdit.Text := '';
 Update;
 StartTime := Time;
 StatusBar1.SimpleText := 'Validate17 Running';
 Update;
 if not Validate17 then
  raise Exception.Create('Move does not pass Validate17');
 StatusBar1.SimpleText := 'Validate18 Running';
 Update;
 if not Validate18 then
  raise Exception.Create('Move does not pass Validate18');
 StatusBar1.SimpleText := 'Validate19 Running';
 Update;
 if not Validate19 then
  raise Exception.Create('Move does not pass Validate19');
 StatusBar1.SimpleText := 'Validate20 Running';
 Update;
 if not Validate20 then
  raise Exception.Create('Move does not pass Validate20');
 StatusBar1.SimpleText := 'Validate21 Running';
 Update;
 if not Validate21 then
  raise Exception.Create('Move does not pass Validate21');
 //Validation for RTL compatibility.
 Count := -10;
 MoveValidate(SourceArray, DestinationArray, Count);
 //Check equal source and dest errorhandling
 MoveValidate(SourceArray, SourceArray, 10);
 //Result is the same either move is done or not. Nothing to check for.
 //Validate Count=0 Move
 MoveValidate(SourceArray, DestinationArray, 0);
 //Validate overlapped (rewerse) Count=0 Move
 MoveValidate(SourceArray[1], SourceArray[0], 0);
 //Validation of nilpointer handling to comes here
 //Validate overlapped cases
 StatusBar1.SimpleText := 'Validating overlapped Byte case left';
 if not ValidateOverlappedLeftByte then
  begin
   ErrorEdit.Color := clRed;
   raise Exception.Create('Move does not handle overlapped Byte case left');
  end;
 StatusBar1.SimpleText := FloatToStr(Time * 24);//Do some FP to check for missing emms
 StatusBar1.SimpleText := '';
 StatusBar1.SimpleText := 'Validating overlapped Byte case rigth';
 if not ValidateOverlappedRigthByte then
  begin
   ErrorEdit.Color := clRed;
   raise Exception.Create('Move does not handle overlapped Byte case rigth');
  end;
 StatusBar1.SimpleText := 'Validating overlapped Cardinal case left';
 if not ValidateOverlappedLeftCardinal then
  begin
   ErrorEdit.Color := clRed;
   raise Exception.Create('Move does not handle overlapped Cardinal case left');
  end;
 StatusBar1.SimpleText := 'Validating overlapped Cardinal case rigth';
 if not ValidateOverlappedRigthCardinal then
  begin
   ErrorEdit.Color := clRed;
   raise Exception.Create('Move does not handle overlapped Cardinal case rigth');
  end;
 StatusBar1.SimpleText := 'Validating big overlapped Cardinal case left';
 if not ValidateBigOverlappedLeftCardinal then
  begin
   ErrorEdit.Color := clRed;
   raise Exception.Create('Move does not handle overlapped Cardinal case left');
  end;
 StatusBar1.SimpleText := 'Validating big overlapped Cardinal case rigth';
 if not ValidateBigOverlappedRigthCardinal then
  begin
   ErrorEdit.Color := clRed;
   raise Exception.Create('Move does not handle overlapped Cardinal case rigth');
  end;
 //Array copy validation
 StatusBar1.SimpleText := 'Validating Array copy';
 ProgressBar1.Max := ArraySizeMax;
 for ArraySize := 1 to ArraySizeMax do
  begin
   ProgressBar1.Position := ArraySize;
   ArraySizeLabeledEdit.Text := IntToStr(ArraySize);
   Update;
   //Initialize source
   for I := 0 to ArraySize-1 do
    begin
     SourceArray[I] := (I mod 255) + 1;
    end;
   //Initialize destination
   for I := 0 to ArraySize-1 do
    begin
     DestinationArray[I] := 0;
    end;
   MoveValidate(SourceArray, DestinationArray, ArraySize);
   //Validate moves
   for I := 0 to ArraySize-1 do
    begin
     if SourceArray[I] <> DestinationArray[I] then
      begin
       //Move failed
       ErrorEdit.Color := clRed;
       ErrorEdit.Text := ErrorEdit.Text + '::' + IntToStr(I) + ';' + IntToStr(SourceArray[I]) + '<>' + IntToStr(DestinationArray[I]);
       raise Exception.create('Move failed array copy test ' + IntToStr(ArraySize));
      end;
    end;
   //Validate non moves
   for I := ArraySize to ARRAYSIZEMAX-1 do
    begin
     if DestinationArray[I] <> 0 then
      begin
       //Move failed - Moved bytes that should not have been moved
       ErrorEdit.Color := clRed;
       ErrorEdit.Text := ErrorEdit.Text + '::' + IntToStr(I) + ';' + IntToStr(SourceArray[I]) + '<>' + IntToStr(DestinationArray[I]);
       raise Exception.create('Move failed array copy test');
      end;
    end;
   EndTime := Time;
   RunTime := EndTime - StartTime;
   RunTimeEdit.Text := TimeToStr(RunTime);
  end;
 StatusBar1.SimpleText := 'Finished';
end;

function TMainForm.TinyMovesWithoutCacheFlushes : Extended;
var
 SourceArray : array[0..200] of Byte;//50B + possible 63 byte space for alignment and 63 byte space for misalignment
 DestinationArray : array[0..200] of Byte;
 I, K, Kmax, RunNo, Alignment, Alignment2, MisAligment : Cardinal;
 OffsetSrc, OffsetDest, MisAlignOffset : Integer;
 NoOfBytesPerSec, NoOfMBytesPerSec, NoOfMBytesPerSecTotal, NoOfMBytesPerSecMax,
 NoOfMBytesPerSecMin : Int64;
 NoOfBytesFP, RunTimeSec, NoOfMBytesPerSecAverage, ArraySizeFP : Extended;
 ArraySize, NoOfBytes : Int64;
 X, Y : Pointer;
 lpFrequency, lpPerformanceCount, StartCount, EndCount,
 NoOfTicks : TLargeInteger;
 Succes : Boolean;
 XAddress, YAddress : AnsiString;
const
 ARRAYSIZEMAX : Cardinal = 33;
 ARRAYGROWFACTOR : Double = 1.025;
 ARRAYSIZESTART : Cardinal = 1;
 RUNNOMAX : Cardinal = 10000;//Must be bigger than Arraysize or some big blocks will not be run
 WANTEDALIGNMENT : Cardinal = 0;//0->15, 0 is 16 byte alignment

begin
 StatusBar1.SimpleText := 'Running Sub Benchmark TinyMovesWithoutCacheFlushes';
 SummedNoOfMBytesPerSecEdit.Text := '';
 SummedArraySizeEdit.Text := '';
 NoOfMBytesPerSecMaxEdit.Text := '';
 ProgressBar1.Position := 0;
 NoOfMBytesPerSecAverage := 0;
 Series5.Clear;
 //Alignment code needs cleanup. It is functionally ok but clumsy.
 //Align Source
 OffsetSrc := -1;
 repeat
  Inc(OffsetSrc);
  X := @SourceArray[OffsetSrc];
  XAddress := IntToHex(Integer(X), 8);
  Alignment := HexToInt(XAddress[8]);
 until(Alignment = WANTEDALIGNMENT);
 //Extend alignment to 64 byte
 Alignment := HexToInt(XAddress[7]);
 MisAligment := Alignment mod 4;
 if MisAligment <> 0 then
  OffsetSrc := OffsetSrc + Integer((4-MisAligment)*16);
 //Align Destination
 OffsetDest := -1;
 repeat
  Inc(OffsetDest);
  Y := @DestinationArray[OffsetDest];
  YAddress := IntToHex(Integer(Y), 8);
  Alignment := HexToInt(YAddress[8]);
 until(Alignment = WANTEDALIGNMENT);
 //Extend alignment to 64 byte
 Alignment := HexToInt(YAddress[7]);
 MisAligment := Alignment mod 4;
 if MisAligment <> 0 then
  OffsetDest := OffsetDest + Integer((4-MisAligment)*16);
 X := @SourceArray[OffsetSrc];
 AddressSourceEdit.Text := IntToHex(Integer(X), 8);
 Y := @DestinationArray[OffsetDest];
 AddressDestEdit.Text := IntToHex(Integer(Y), 8);
 ProgressBar1.Max := 131;
 ArraySizeFP := ARRAYSIZESTART;
 ArraySize := Round(ArraySizeFP);
 NoOfMBytesPerSecTotal := 0;
 NoOfMBytesPerSecMax := 0;
 NoOfMBytesPerSecMin := 99999999;
 //Initialize arrays
 for I := 0 to Length(SourceArray)-1 do
  begin
   SourceArray[I] := 255;
   DestinationArray[I] := 1;
  end;
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 RunNo := 1;
 while (ArraySize < ARRAYSIZEMAX) do
  begin
   MainForm.SummedArraySizeEdit.Text := MainForm.SummedArraySizeEdit.Text + IntToStr(ArraySize) + ';';
   if ArraySize > Length(DestinationArray) then
    raise Exception.Create('ArraySize to big');
   ArraySizeLabeledEdit.Text := IntToStr(ArraySize);
   Update;
   Kmax := Round(RUNNOMAX / ArraySize);//Adjust Kmax because more runs are needed on small blocks than on big blocks
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for K := 1 to Kmax do
    begin
     //Function to benchmark
     for MisAlignOffset := 0 to 63 do
      begin
       MoveProc(SourceArray[OffsetSrc+0+MisAlignOffset], DestinationArray[OffsetDest+0+MisAlignOffset], ArraySize);//16, 16 byte aligned move
       MoveProc(SourceArray[OffsetSrc+0+MisAlignOffset], DestinationArray[OffsetDest+1+MisAlignOffset], ArraySize);//16, 1 byte aligned move
       MoveProc(SourceArray[OffsetSrc+0+MisAlignOffset], DestinationArray[OffsetDest+2+MisAlignOffset], ArraySize);//16, 2 byte aligned move
       MoveProc(SourceArray[OffsetSrc+0+MisAlignOffset], DestinationArray[OffsetDest+4+MisAlignOffset], ArraySize);//16, 4 byte aligned move
       MoveProc(SourceArray[OffsetSrc+0+MisAlignOffset], DestinationArray[OffsetDest+8+MisAlignOffset], ArraySize);//16, 8 byte aligned move

       MoveProc(SourceArray[OffsetSrc+1+MisAlignOffset], DestinationArray[OffsetDest+0+MisAlignOffset], ArraySize);//1, 16 byte aligned move
       MoveProc(SourceArray[OffsetSrc+1+MisAlignOffset], DestinationArray[OffsetDest+1+MisAlignOffset], ArraySize);//1, 1 byte aligned move
       MoveProc(SourceArray[OffsetSrc+1+MisAlignOffset], DestinationArray[OffsetDest+2+MisAlignOffset], ArraySize);//1, 2 byte aligned move
       MoveProc(SourceArray[OffsetSrc+1+MisAlignOffset], DestinationArray[OffsetDest+4+MisAlignOffset], ArraySize);//1, 4 byte aligned move
       MoveProc(SourceArray[OffsetSrc+1+MisAlignOffset], DestinationArray[OffsetDest+8+MisAlignOffset], ArraySize);//1, 8 byte aligned move

       MoveProc(SourceArray[OffsetSrc+2+MisAlignOffset], DestinationArray[OffsetDest+0+MisAlignOffset], ArraySize);//2, 16 byte aligned move
       MoveProc(SourceArray[OffsetSrc+2+MisAlignOffset], DestinationArray[OffsetDest+1+MisAlignOffset], ArraySize);//2, 1 byte aligned move
       MoveProc(SourceArray[OffsetSrc+2+MisAlignOffset], DestinationArray[OffsetDest+2+MisAlignOffset], ArraySize);//2, 2 byte aligned move
       MoveProc(SourceArray[OffsetSrc+2+MisAlignOffset], DestinationArray[OffsetDest+4+MisAlignOffset], ArraySize);//2, 4 byte aligned move
       MoveProc(SourceArray[OffsetSrc+2+MisAlignOffset], DestinationArray[OffsetDest+8+MisAlignOffset], ArraySize);//2, 8 byte aligned move

       MoveProc(SourceArray[OffsetSrc+4+MisAlignOffset], DestinationArray[OffsetDest+0+MisAlignOffset], ArraySize);//4, 16 byte aligned move
       MoveProc(SourceArray[OffsetSrc+4+MisAlignOffset], DestinationArray[OffsetDest+1+MisAlignOffset], ArraySize);//4, 1 byte aligned move
       MoveProc(SourceArray[OffsetSrc+4+MisAlignOffset], DestinationArray[OffsetDest+2+MisAlignOffset], ArraySize);//4, 2 byte aligned move
       MoveProc(SourceArray[OffsetSrc+4+MisAlignOffset], DestinationArray[OffsetDest+4+MisAlignOffset], ArraySize);//4, 4 byte aligned move
       MoveProc(SourceArray[OffsetSrc+4+MisAlignOffset], DestinationArray[OffsetDest+8+MisAlignOffset], ArraySize);//4, 8 byte aligned move

       MoveProc(SourceArray[OffsetSrc+8+MisAlignOffset], DestinationArray[OffsetDest+0+MisAlignOffset], ArraySize);//8, 16 byte aligned move
       MoveProc(SourceArray[OffsetSrc+8+MisAlignOffset], DestinationArray[OffsetDest+1+MisAlignOffset], ArraySize);//8, 1 byte aligned move
       MoveProc(SourceArray[OffsetSrc+8+MisAlignOffset], DestinationArray[OffsetDest+2+MisAlignOffset], ArraySize);//8, 2 byte aligned move
       MoveProc(SourceArray[OffsetSrc+8+MisAlignOffset], DestinationArray[OffsetDest+4+MisAlignOffset], ArraySize);//8, 4 byte aligned move
       MoveProc(SourceArray[OffsetSrc+8+MisAlignOffset], DestinationArray[OffsetDest+8+MisAlignOffset], ArraySize);//8, 8 byte aligned move
      end;
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   RunTimeSec := NoOfTicks / lpFrequency;
   RunTimeEdit.Text := FloatToStrF(RunTimeSec, ffFixed, 9, 1);
   NoOfBytes := 25 *64 * ArraySize * Kmax;//25 * 64 is number of Move calls
   NoOfBytesFP := NoOfBytes;
   if RunTimeSec <> 0 then
    NoOfBytesPerSec := Round(NoOfBytesFP / RunTimeSec)
   else
    NoOfBytesPerSec := 0;
   NoOfMBytesPerSec := Round(NoOfBytesPerSec / 1024 / 1024);
   Series5.AddXY(ArraySize, NoOfMBytesPerSec, '', clMaroon);
   NoOfMBytesPerSecEdit.Text := IntToStr(NoOfMBytesPerSec);
   NoOfMBytesPerSecTotal := NoOfMBytesPerSecTotal + NoOfMBytesPerSec;
   NoOfMBytesPerSecTotalEdit.Text := IntToStr(NoOfMBytesPerSecTotal);
   NoOfMBytesPerSecAverage := NoOfMBytesPerSecTotal / RunNo;
   NoOfMBytesPerSecAverageEdit.Text := FloatToStrF(NoOfMBytesPerSecAverage, ffFixed, 9, 0);
   if NoOfMBytesPerSec < NoOfMBytesPerSecMin then
    NoOfMBytesPerSecMin := NoOfMBytesPerSec;
   NoOfMBytesPerSecMinEdit.Text := IntToStr(NoOfMBytesPerSecMin);
   if NoOfMBytesPerSec > NoOfMBytesPerSecMax then
    NoOfMBytesPerSecMax := NoOfMBytesPerSec;
   NoOfMBytesPerSecMaxEdit.Text := IntToStr(NoOfMBytesPerSecMax);
   SummedNoOfMBytesPerSecEdit.Text :=  MainForm.SummedNoOfMBytesPerSecEdit.Text +  MainForm.NoOfMBytesPerSecEdit.Text + ';';
   ProgressBar1.Position := RunNo;
   ArraySizeFP := ArraySizeFP * ARRAYGROWFACTOR;
   ArraySize := Round(ArraySizeFP);
   Inc(RunNo);
   MainForm.Update;
  end;
 StatusBar1.SimpleText := 'Finished';
 Result := NoOfMBytesPerSecAverage;
end;

//Function calls to Move functions to benchmark are labeled "Function to benchmark"

procedure TMainForm.Benchmark;
var
 SubBenchmark1, SubBenchmark2, SubBenchmark3, SubBenchmark4, SubBenchmark5,
 Benchmark : Extended;
 FunctionAddress : Cardinal;
 FunctionAddressString : AnsiString;
const
 BestBenchmark : Extended = 0; //Static not const

begin
 try
  FunctionAddress := Cardinal(@MoveProc);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  SubBenchmark1 := WithoutCacheFlushes * SUBBENCHMARKH1ADJUST;
  SubBenchmark1Edit.Text := FloatToStrF(SubBenchmark1, ffFixed, 9, 0);
  Update;
  SubBenchmark2 := WithCacheFlushes * SUBBENCHMARKH2ADJUST;
  SubBenchmark2Edit.Text := FloatToStrF(SubBenchmark2, ffFixed, 9, 0);
  Update;
  SubBenchmark3 := WithCacheCompetition * SUBBENCHMARKH3ADJUST;
  SubBenchmark3Edit.Text := FloatToStrF(SubBenchmark3, ffFixed, 9, 0);
  Application.ProcessMessages;
  SubBenchmark4 := TinyMovesWithoutCacheFlushes;
  SubBenchmark4 := SubBenchmark4 * SUBBENCHMARKH4ADJUST;
  SubBenchmark4Edit.Text := FloatToStrF(SubBenchmark4, ffFixed, 9, 0);
  Update;
  SubBenchmark5 := BenchmarkOverlappedRigth;
  SubBenchmark5 := SubBenchmark5 * SUBBENCHMARKH5ADJUST;
  SubBenchmark5Edit.Text := FloatToStrF(SubBenchmark5, ffFixed, 9, 0);
  Update;
  Benchmark := SubBenchmark1 + SubBenchmark2 + SubBenchmark3 + SubBenchmark4 + SubBenchmark5;
  BenchmarkEdit.Text := FloatToStrF(Benchmark, ffFixed, 9, 0);
  if Benchmark > BestBenchmark then
   BestBenchmark := Benchmark;
  BestBenchmarkEdit.Text := FloatToStrF(BestBenchmark, ffFixed, 9, 0);
  if AllBenchmarkEdit.Text <> '' then
   AllBenchmarkEdit.Text := AllBenchmarkEdit.Text + ';' + BenchmarkEdit.Text
  else
   AllBenchmarkEdit.Text := BenchmarkEdit.Text;
  ReportRichEdit.Lines.Add(FunctionSelectComboBox.Text
                           + #9 + FunctionAddressString[8]
                           + #9 + FloatToStrF(SubBenchmark1, ffFixed, 9, 0)
                           + #9 + FloatToStrF(SubBenchmark2, ffFixed, 9, 0)
                           + #9 + FloatToStrF(SubBenchmark3, ffFixed, 9, 0)
                           + #9 + FloatToStrF(SubBenchmark4, ffFixed, 9, 0)
                           + #9 + FloatToStrF(SubBenchmark5, ffFixed, 9, 0)
                           + #9 + FloatToStrF(Benchmark, ffFixed, 9, 0));
  Update;
 except
  StatusBar1.SimpleText := 'Stopped on exception';
  ReportRichEdit.Lines.Add(FunctionSelectComboBox.Text + #9 + 'Failed');
 end;
end;

procedure TMainForm.BenchmarkTwiceButtonClick(Sender: TObject);
begin
 Benchmark;
 Benchmark;
end;

procedure TMainForm.BenchThreeTimesButtonClick(Sender: TObject);
begin
 Benchmark;
 Benchmark;
 Sleep(1000);
 Benchmark;
end;

procedure TMainForm.SubBenchmark1EditClick(Sender: TObject);
begin
 SubBenchmark1Edit.SelectAll;
 SubBenchmark1Edit.CopyToClipboard;
end;

procedure TMainForm.SubBenchmark2EditClick(Sender: TObject);
begin
 SubBenchmark2Edit.SelectAll;
 SubBenchmark2Edit.CopyToClipboard;
end;

procedure TMainForm.SubBenchmark3EditClick(Sender: TObject);
begin
 SubBenchmark3Edit.SelectAll;
 SubBenchmark3Edit.CopyToClipboard;
end;

procedure TMainForm.SubBenchmark4EditClick(Sender: TObject);
begin
 SubBenchmark4Edit.SelectAll;
 SubBenchmark4Edit.CopyToClipboard;
end;

procedure TMainForm.BenchmarkEditClick(Sender: TObject);
begin
 BenchmarkEdit.SelectAll;
 BenchmarkEdit.CopyToClipboard;
end;

procedure TMainForm.SubBenchmark5EditClick(Sender: TObject);
begin
 SubBenchmark5Edit.SelectAll;
 SubBenchmark5Edit.CopyToClipboard;
end;

procedure TMainForm.BestBenchmarkEditClick(Sender: TObject);
begin
 BestBenchmarkEdit.SelectAll;
 BestBenchmarkEdit.CopyToClipboard;
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I : Integer;

begin
 ValidateAllButton.Caption := 'Running';
 PageControl.ActivePageIndex := 1;
 Update;

 for I := 0 to FunctionSelectComboBox.Items.Count-1 do
  begin
   FunctionSelectComboBox.ItemIndex := I;
   FunctionSelectComboBox.Text := FunctionSelectComboBox.Items[I];
   ClearGUI;
   SelectFunction(I);
   Update;
   try
    ValidateButtonClick(ValidateAllButton);
    ReportRichEdit.Lines.Add(FunctionSelectComboBox.Text
                            + #9 + 'Passed');
    except
    ReportRichEdit.Lines.Add(FunctionSelectComboBox.Text
                            + #9 + 'Failed');

   end;
  end;

 ValidateAllButton.Caption := 'Validate All';

 if FileExists(FValidationFileName) then FResultList.LoadFromFile(FValidationFileName);
 FResultList.Add(Format('[%s %s] Running "%s" validation version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FValidationFileName);
end;

procedure TMainForm.NoOfMBytesPerSecAverageEditClick(Sender: TObject);
begin
 NoOfMBytesPerSecAverageEdit.SelectAll;
 NoOfMBytesPerSecAverageEdit.CopyToClipboard;
end;

procedure TMainForm.SelectFunction(FunctionID : Cardinal);
begin
 case FunctionID of
   0 : MoveProc := System.Move;
   1 : MoveProc := Move_RTL_PAS_1;
   2 : MoveProc := Move_JOH_PAS_10;
   3 : MoveProc := Move_JOH_IA32_10;
   4 : MoveProc := Move_JOH_MMX_10;
   5 : MoveProc := Move_JOH_SSE_10;
   6 : MoveProc := Move_JOH_SSE2_10;
   7 : MoveProc := Move_JOH_SSE3_10;
   8 : MoveProc := Move_RL_IA32_1;
   9 : MoveProc := Move_DKC_IA32_5;
  10 : MoveProc := Move_DKC_SSE_1;
  11 : MoveProc := Move_DKC_SSE3_1;
  12 : MoveProc := Move_DKC_SSE2_3;
  13 : MoveProc := Move_DKC_IA32_1;
  14 : MoveProc := Move_DKC_IA32_2;
  15 : MoveProc := Move_DKC_IA32_4;
  16 : MoveProc := Move_DKC_Pas_16;
  17 : MoveProc := Move_DKC_Pas_37;
  18 : MoveProc := Move_DKC_Pas_38;

 else
  raise Exception.Create('Invalid function');
 end;
end;

procedure TMainForm.FunctionSelectComboBoxChange(Sender: TObject);
begin
 ClearGUI;
 SelectFunction(FunctionSelectComboBox.ItemIndex)
end;

procedure TMainForm.SortRichEditByBench;
var
 I2, I3, LineNo, X1, X2 : Integer;
 S1, S2, Bench1String, Bench2String : AnsiString;
 Bench1, Bench2 : Double;
 Swapped : Boolean;
 C1, C2 : Char;

begin
 repeat
  Swapped := False;
  for LineNo := 0 to ReportRichEdit.Lines.Count-2 do
   begin
    S1 := ReportRichEdit.Lines[LineNo];
    S2 := ReportRichEdit.Lines[LineNo+1];
    I2 := Length(S1);
    repeat
     C1 := S1[I2];
     Dec(I2);
    until(C1 = #9);
    X1 := I2+2;
    I3 := Length(S2);
    repeat
     C2 := S2[I3];
     Dec(I3);
    until(C2 = #9);
    X2 := I3+2;
    Bench1String := Copy(S1, X1, Length(S1));
    Bench2String := Copy(S2, X2, Length(S2));
    //IsFloat function wanted
    try
     Bench1 := StrToFloat(Bench1String);
    except
     Bench1 := 0;
    end;
    try
     Bench2 := StrToFloat(Bench2String);
    except
     Bench2 := 0;
    end;
    if Bench2 > Bench1 then
     begin
      Swapped := True;
      ReportRichEdit.Lines.Exchange(LineNo, LineNo+1);
     end;
   end;
 until(not Swapped);
end;

function DKCCharPos(SourceString : AnsiString; SearchCharacter : Char; Occurrence : Cardinal) : Integer;
var
 Char1 : Char;
 Index, NoOfCharsFound, SourceStringSize : Cardinal;
 Finished : Boolean;

begin
 Result := -1;
 SourceStringSize := Length(SourceString);
 Finished := False;
 Index := 1;
 NoOfCharsFound := 0;
 repeat
  Char1 := SourceString[Index];
  if Char1 = SearchCharacter then
   begin
    Result := Index;
    Inc(NoOfCharsFound);
    if NoOfCharsFound = Occurrence then
     Finished := True;
   end;
  Inc(Index);
  if Index > SourceStringSize then
   begin
    Result := -1;
    Finished := True;
   end;
 until(Finished);
end;

procedure TMainForm.SortRichEditBySubBench1;
var
 LineNo : Integer;
 S1, S2, Bench1String, Bench2String : AnsiString;
 Bench1, Bench2 : Double;
 Swapped : Boolean;
 S1PosTab1, S1PosTab2, S2PosTab1, S2PosTab2: Cardinal;

begin
 repeat
  Swapped := False;
  for LineNo := 0 to ReportRichEdit.Lines.Count-2 do
   begin
    S1 := ReportRichEdit.Lines[LineNo];
    S2 := ReportRichEdit.Lines[LineNo+1];
    //I2 := Length(S1);
    S1PosTab1 := DKCCharPos(S1, #9, 2);
    S1PosTab2 := DKCCharPos(S1, #9, 3);
    S2PosTab1 := DKCCharPos(S2, #9, 2);
    S2PosTab2 := DKCCharPos(S2, #9, 3);
    Bench1String := Copy(S1, S1PosTab1+1, S1PosTab2-S1PosTab1-1);
    Bench2String := Copy(S2, S2PosTab1+1, S2PosTab2-S2PosTab1-1);
    //IsFloat function wanted
    try
     Bench1 := StrToFloat(Bench1String);
    except
     Bench1 := 0;
    end;
    try
     Bench2 := StrToFloat(Bench2String);
    except
     Bench2 := 0;
    end;
    if Bench2 > Bench1 then
     begin
      Swapped := True;
      ReportRichEdit.Lines.Exchange(LineNo, LineNo+1);
     end;
   end;
 until(not Swapped);
end;

procedure TMainForm.SortRichEditBySubBench2;
var
 LineNo : Integer;
 S1, S2, Bench1String, Bench2String : AnsiString;
 Bench1, Bench2 : Double;
 Swapped : Boolean;
 S1PosTab1, S1PosTab2, S2PosTab1, S2PosTab2: Cardinal;

begin
 repeat
  Swapped := False;
  for LineNo := 0 to ReportRichEdit.Lines.Count-2 do
   begin
    S1 := ReportRichEdit.Lines[LineNo];
    S2 := ReportRichEdit.Lines[LineNo+1];
    //I2 := Length(S1);
    S1PosTab1 := DKCCharPos(S1, #9, 3);
    S1PosTab2 := DKCCharPos(S1, #9, 4);
    S2PosTab1 := DKCCharPos(S2, #9, 3);
    S2PosTab2 := DKCCharPos(S2, #9, 4);
    Bench1String := Copy(S1, S1PosTab1+1, S1PosTab2-S1PosTab1-1);
    Bench2String := Copy(S2, S2PosTab1+1, S2PosTab2-S2PosTab1-1);
    //IsFloat function wanted
    try
     Bench1 := StrToFloat(Bench1String);
    except
     Bench1 := 0;
    end;
    try
     Bench2 := StrToFloat(Bench2String);
    except
     Bench2 := 0;
    end;
    if Bench2 > Bench1 then
     begin
      Swapped := True;
      ReportRichEdit.Lines.Exchange(LineNo, LineNo+1);
     end;
   end;
 until(not Swapped);
end;

procedure TMainForm.SortRichEditBySubBench3;
var
 LineNo : Integer;
 S1, S2, Bench1String, Bench2String : AnsiString;
 Bench1, Bench2 : Double;
 Swapped : Boolean;
 S1PosTab1, S1PosTab2, S2PosTab1, S2PosTab2: Cardinal;

begin
 repeat
  Swapped := False;
  for LineNo := 0 to ReportRichEdit.Lines.Count-2 do
   begin
    S1 := ReportRichEdit.Lines[LineNo];
    S2 := ReportRichEdit.Lines[LineNo+1];
    //I2 := Length(S1);
    S1PosTab1 := DKCCharPos(S1, #9, 4);
    S1PosTab2 := DKCCharPos(S1, #9, 5);
    S2PosTab1 := DKCCharPos(S2, #9, 4);
    S2PosTab2 := DKCCharPos(S2, #9, 5);
    Bench1String := Copy(S1, S1PosTab1+1, S1PosTab2-S1PosTab1-1);
    Bench2String := Copy(S2, S2PosTab1+1, S2PosTab2-S2PosTab1-1);
    //IsFloat function wanted
    try
     Bench1 := StrToFloat(Bench1String);
    except
     Bench1 := 0;
    end;
    try
     Bench2 := StrToFloat(Bench2String);
    except
     Bench2 := 0;
    end;
    if Bench2 > Bench1 then
     begin
      Swapped := True;
      ReportRichEdit.Lines.Exchange(LineNo, LineNo+1);
     end;
   end;
 until(not Swapped);
end;

procedure TMainForm.SortRichEditBySubBench4;
var
 LineNo : Integer;
 S1, S2, Bench1String, Bench2String : AnsiString;
 Bench1, Bench2 : Double;
 Swapped : Boolean;
 S1PosTab1, S1PosTab2, S2PosTab1, S2PosTab2: Cardinal;

begin
 repeat
  Swapped := False;
  for LineNo := 0 to ReportRichEdit.Lines.Count-2 do
   begin
    S1 := ReportRichEdit.Lines[LineNo];
    S2 := ReportRichEdit.Lines[LineNo+1];
    S1PosTab1 := DKCCharPos(S1, #9, 5);
    S1PosTab2 := DKCCharPos(S1, #9, 6);
    S2PosTab1 := DKCCharPos(S2, #9, 5);
    S2PosTab2 := DKCCharPos(S2, #9, 6);
    Bench1String := Copy(S1, S1PosTab1+1, S1PosTab2-S1PosTab1-1);
    Bench2String := Copy(S2, S2PosTab1+1, S2PosTab2-S2PosTab1-1);
    //IsFloat function wanted
    try
     Bench1 := StrToFloat(Bench1String);
    except
     Bench1 := 0;
    end;
    try
     Bench2 := StrToFloat(Bench2String);
    except
     Bench2 := 0;
    end;
    if Bench2 > Bench1 then
     begin
      Swapped := True;
      ReportRichEdit.Lines.Exchange(LineNo, LineNo+1);
     end;
   end;
 until(not Swapped);
end;

procedure TMainForm.SortRichEditBySubBench5;
var
 LineNo : Integer;
 S1, S2, Bench1String, Bench2String : AnsiString;
 Bench1, Bench2 : Double;
 Swapped : Boolean;
 S1PosTab1, S1PosTab2, S2PosTab1, S2PosTab2: Cardinal;

begin
 repeat
  Swapped := False;
  for LineNo := 0 to ReportRichEdit.Lines.Count-2 do
   begin
    S1 := ReportRichEdit.Lines[LineNo];
    S2 := ReportRichEdit.Lines[LineNo+1];
    S1PosTab1 := DKCCharPos(S1, #9, 6);
    S1PosTab2 := DKCCharPos(S1, #9, 7);
    S2PosTab1 := DKCCharPos(S2, #9, 6);
    S2PosTab2 := DKCCharPos(S2, #9, 7);
    Bench1String := Copy(S1, S1PosTab1+1, S1PosTab2-S1PosTab1-1);
    Bench2String := Copy(S2, S2PosTab1+1, S2PosTab2-S2PosTab1-1);
    //IsFloat function wanted
    try
     Bench1 := StrToFloat(Bench1String);
    except
     Bench1 := 0;
    end;
    try
     Bench2 := StrToFloat(Bench2String);
    except
     Bench2 := 0;
    end;
    if Bench2 > Bench1 then
     begin
      Swapped := True;
      ReportRichEdit.Lines.Exchange(LineNo, LineNo+1);
     end;
   end;
 until(not Swapped);
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I : Integer;

begin
 BenchmarkAllButton.Caption := 'Running';
 Update;

 for I := 0 to FunctionSelectComboBox.Items.Count-1 do
  begin
   FunctionSelectComboBox.ItemIndex := I;
   FunctionSelectComboBox.Text := FunctionSelectComboBox.Items[I];
   ClearGUI;
   SelectFunction(I);
   Update;
   Benchmark;
   SortReport;
  end;

 BenchmarkAllButton.Caption := 'Benchmark All';

 if FileExists(FBenchmarkFileName) then FResultList.LoadFromFile(FBenchmarkFileName);
 FResultList.Add(Format('[%s %s] Running "%s" benchmark version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FBenchmarkFileName);

end;

procedure TMainForm.PrintSpeedButtonClick(Sender: TObject);
begin
 if PageControl.ActivePageIndex = 0 then
 else if PageControl.ActivePageIndex = 1 then
  Chart1.Print
 else if PageControl.ActivePageIndex = 2 then
 else if PageControl.ActivePageIndex = 3 then
  ReportRichEdit.Print('Move B&V 6.4 Report');
end;

procedure TMainForm.SubBenchmark1SpeedButtonClick(Sender: TObject);
var
 SubBenchmark1 : Double;

begin
 Chart1.BottomAxis.Maximum := 2000000;
 SubBenchmark1 := WithoutCacheFlushes * SUBBENCHMARKH1ADJUST;
 SubBenchmark1Edit.Text := FloatToStrF(SubBenchmark1, ffFixed, 9, 0);
end;

procedure TMainForm.SubBenchmark2SpeedButtonClick(Sender: TObject);
var
 SubBenchmark2 : Double;

begin
 SubBenchmark2 := WithCacheFlushes * SUBBENCHMARKH2ADJUST;
 SubBenchmark2Edit.Text := FloatToStrF(SubBenchmark2, ffFixed, 9, 0);
end;

procedure TMainForm.SubBenchmark3SpeedButtonClick(Sender: TObject);
var
 SubBenchmark3 : Double;

begin
 SubBenchmark3 := WithCacheCompetition * SUBBENCHMARKH3ADJUST;
 SubBenchmark3Edit.Text := FloatToStrF(SubBenchmark3, ffFixed, 9, 0);
end;

procedure TMainForm.SubBenchmark4SpeedButtonClick(Sender: TObject);
var
 SubBenchmark4 : Double;

begin
 Chart1.BottomAxis.Maximum := 55;
 SubBenchmark4 := TinyMovesWithoutCacheFlushes * SUBBENCHMARKH4ADJUST;
 SubBenchmark4Edit.Text := FloatToStrF(SubBenchmark4, ffFixed, 9, 0);
end;

procedure TMainForm.SubBenchmark5SpeedButtonClick(Sender: TObject);
var
 SubBenchmark5 : Double;
const
 SubBenchmark5Sum : Double = 0;
 SubBenchmark5Count : Integer = 0;

begin
 SubBenchmark5 := BenchmarkOverlappedRigth;//Forward & Backward
 SubBenchmark5 := SubBenchmark5 * SUBBENCHMARKH5ADJUST;
 SubBenchmark5Edit.Text := FloatToStrF(SubBenchmark5, ffFixed, 9, 0);
 Update;
end;

procedure TMainForm.ShowOptionsSpeedButtonClick(Sender: TObject);
begin
 OptionsForm.ShowModal;
end;

procedure TMainForm.CopyChartToClipboardSpeedButtonClick(Sender: TObject);
begin
 Chart1.CopyToClipboardBitmap;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
 FreeAndNil(FResultList);
end;

procedure TMainForm.WMPOSTPROCESSING(var msg: TMessage);
begin
  if FindCmdLineSwitch('C', ['-', '/'], True) then
  begin
    // clear results;
    if FileExists(FValidationFileName) then DeleteFile(FValidationFileName);
    if FileExists(FBenchmarkFileName) then DeleteFile(FBenchmarkFileName);
  end;

  if FindCmdLineSwitch('B', ['-', '/'], True) then
  begin
    // run all benchmarks
    Show;
    Enabled := False;
    Application.ProcessMessages;
    Enabled := True;
    BenchmarkAllButton.Click;
    Halt;
  end;

  if FindCmdLineSwitch('V', ['-', '/'], True) then
  begin
    // perform all validations
    Show;
    Enabled := False;
    Application.ProcessMessages;
    Enabled := True;
    ValidateAllButton.Click;
    Halt;
  end;
end;

end.
