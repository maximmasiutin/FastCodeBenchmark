unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'Int64Mul';

type
  TMainForm = class(TForm)
    ValidateButton: TButton;
    ValidationEdit: TEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    ReportRichEdit: TRichEdit;
    BenchmarkButton: TButton;
    RuntimeEdit: TEdit;
    FunctionSelectionRadioGroup: TRadioGroup;
    BenchmarkAllButton: TButton;
    Label2: TLabel;
    Bench1Edit: TEdit;
    Bench2Edit: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    ValidateAllButton: TButton;
    ClearButton: TButton;
    MaxSpreadBenchPercentageEdit: TEdit;
    FunctionNameEdit: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    SaveReportSpeedButton: TSpeedButton;
    PrintReportSpeedButton: TSpeedButton;
    SaveDialog: TSaveDialog;
    BenchTestButton: TButton;
    SpreadTestButton: TButton;
    CleanResultsButton: TButton;
    ZEdit: TEdit;
    BenchThreadPrioRadioGroup: TRadioGroup;
    BenchmarkRDTSCOverheadEdit: TEdit;
    procedure ValidateButtonClick(Sender: TObject);
    procedure BenchmarkButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FunctionSelectionRadioGroupClick(Sender: TObject);
    procedure BenchmarkAllButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure SaveReportSpeedButtonClick(Sender: TObject);
    procedure PrintReportSpeedButtonClick(Sender: TObject);
    procedure BenchTestButtonClick(Sender: TObject);
    procedure SpreadTestButtonClick(Sender: TObject);
    procedure MaxSpreadBenchPercentageEditClick(Sender: TObject);
    procedure CleanResultsButtonClick(Sender: TObject);
    procedure BenchThreadPrioRadioGroupClick(Sender: TObject);
    procedure SpeedButton1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    PerformanceFrequency : Int64;
    NoOfTicksArray : array of Int64;
    MaxFunctionNumber : Integer;
    FunctionSelected : Integer;
    BenchResultArray : array[1..1000] of AnsiString;
    BenchRunNo : Cardinal;
    FunctionNameArray : array[0..5] of AnsiString;
    procedure BenchmarkAll;
    procedure BenchmarkTestEventHandler;
    procedure SelectFunction(FuncNo : Integer);
    procedure RunBenchmark;
    procedure PublishBenchResults;
    procedure ClearAllEditBoxes;
    function Validate1 : Boolean;
    function Validate2 : Boolean;
    function Validate3 : Boolean;
    function Validate4 : Boolean;
    function Validate5 : Boolean;
    procedure CleanResultsRichEdit;
    procedure SortRichEdit;
    procedure BenchmarkTest;
    function SubBenchmark1 : Cardinal;
    function SubBenchmark2 : Cardinal;
    function SubBenchmarkRTL1 : Cardinal;
    function SubBenchmarkRTL2 : Cardinal;
  public
    { Public declarations }
   procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
 MainForm: TMainForm;

implementation

uses
 Math, FastcodeCPUID, SystemInfoUnit, Int64MulDKCUnit, Int64MulRTLUnit, Int64MulJOHUnit, Int64MulAMDUnit;

{$R *.dfm}

const
 SUBBENCH1SCALE : Double = 1000;
 SUBBENCH2SCALE : Double = 1000;
 MAXINT64 : Int64 = $7FFFFFFFFFFFFFFF;
 ARRAYSIZE : Cardinal = 30;//Fill several L1 lines
 CPUFREQUENCY : Double = 1600E6;
 SLEEPBEFOREGOTIME : Cardinal = 1000;
 //SUBBENCH1XMIN : Int64 = -3037000499;
 SUBBENCH1XMAX : Int64 = 3037000499; // Round(Sqrt(MAXINT64FP))-500;
 //SUBBENCH1YMIN : Int64 = -3037000499;
 SUBBENCH1YMAX : Int64 = 3037000499;
 SUBBENCH1STEPSIZE : Int64 = 3600000;
 SUBBENCH2XMIN : Int64 = -$7FFFFFFFFFFFFFFF;
 SUBBENCH2XMAX : Int64 = $7FFFFFFFFFFFFFFF;
 SUBBENCH2YMIN : Int64 = -$7FFFFFFFFFFFFFFF;
 SUBBENCH2YMAX : Int64 = $7FFFFFFFFFFFFFFF;
 SUBBENCH2STEPSIZE : Int64 = 10000000000000;
 NOOFRERUNS : Cardinal = 10;

type
 TInt64MulFunction = function (var X, Y : Int64): Int64;

var
 Int64MulFunction : TInt64MulFunction;
 SubBench1XArray : array of Int64;
 SubBench1YArray : array of Int64;
 SubBench1ZArray : array of Int64;
 SubBench1X, SubBench1Y, SubBench1Z1, SubBench1Z2 : Int64;
 SubBench2X, SubBench2Y, SubBench2Z1, SubBench2Z2 : Int64;

procedure TMainForm.ClearAllEditBoxes;
var
 ComponentInx : Integer;

begin
 for ComponentInx := 0 to ComponentCount-1 do
  begin
   if Components[ComponentInx] is TEdit then
    with Components[ComponentInx] as TEdit do
     Text := '';
  end;
end;

procedure TMainForm.PublishBenchResults;
var
 I, IMax : Cardinal;

begin
 IMax := BenchRunNo;
 for I := 1 to IMax do
  begin
   ReportRichEdit.Lines.Add(BenchResultArray[I])
  end;
 SortRichEdit;
 BenchmarkTest;
 Update;
end;

procedure TMainForm.SortRichEdit;
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
    Bench1 := StrToFloat(Bench1String);
    Bench2 := StrToFloat(Bench2String);
    if Bench2 < Bench1 then
     begin
      Swapped := True;
      ReportRichEdit.Lines.Exchange(LineNo, LineNo+1);
     end;
   end;
 until(not Swapped);
end;

function CharPos(Chr : Char; const Str : AnsiString) : Integer;
var
 StrLenght, I : Integer;

begin
 StrLenght := Length(Str);
 if StrLenght > 0 then
  begin
   I := 0;
   repeat
    Inc(I);
   until((Str[I] = Chr) or (I >= StrLenght));
   if Str[I] = Chr then
    Result := I
   else
    Result := 0;
  end
 else
  Result := 0;
end;

//Finds the maximum spread in benchmarks for any function.

procedure TMainForm.BenchmarkTest;
var
 I1, I2, LineNo1, LineNo2, X1, X2, TabNo1, TabNo2 : Integer;
 S1, S2, BenchString1, BenchString2, FunctionName1, FunctionName2 : AnsiString;
 Bench1, Bench2, AverageBench, Spread, DeltaBench, MaxSpread : Double;
 C1, C2 : Char;
 Tab1Pos1, Tab1Pos2 : Cardinal;

begin
 if ReportRichEdit.Lines.Count < 2 then
  Exit;
 Bench1Edit.Text := '';
 Bench2Edit.Text := '';
 FunctionNameEdit.Text := '';
 MaxSpreadBenchPercentageEdit.Text := '';
 MaxSpreadBenchPercentageEdit.Color := clInfoBk;
 MaxSpread := 0;
 for LineNo1 := 0 to ReportRichEdit.Lines.Count-2 do
  begin
   S1 := ReportRichEdit.Lines[LineNo1];
   for LineNo2 := LineNo1+1 to ReportRichEdit.Lines.Count-1 do
    begin
     S2 := ReportRichEdit.Lines[LineNo2];
     Tab1Pos1 := CharPos(#9, S1);
     Tab1Pos2 := CharPos(#9, S2);
     FunctionName1 := Copy(S1, 0, Tab1Pos1-1);
     FunctionName2 := Copy(S2, 0, Tab1Pos2-1);
     if FunctionName1 = FunctionName2 then
      begin
       //****************************
       //X1 := CharPosRew(#9, S1)
       I1 := Length(S1);
       TabNo1 := 0;
       repeat
        C1 := S1[I1];
        Dec(I1);
        if C1 = #9 then
         Inc(TabNo1);
       until(TabNo1 = 1);
       X1 := I1+2;
       //*****************************
       BenchString1 := Copy(S1, X1, 5);
       try
        Bench1 := StrToFloat(BenchString1);
       except
        Bench1 := 0;
       end;
       //****************************
       //X2 := CharPosRew(#9, S2)
       I2 := Length(S2);
       TabNo2 := 0;
       repeat
        C2 := S2[I2];
        Dec(I2);
        if C2 = #9 then
         Inc(TabNo2);
       until(TabNo2 = 1);
       X2 := I2+2;
       //****************************
       BenchString2 := Copy(S2, X2, 5);
       try
        Bench2 := StrToFloat(BenchString2);
       except
        Bench2 := 0;
       end;
       DeltaBench := Abs(Bench1 - Bench2);
       AverageBench := (Bench1+Bench2) / 2;
       Spread := 100 * DeltaBench / AverageBench;
       if Spread > MaxSpread then
        begin
         Bench1Edit.Text := BenchString1;
         Bench2Edit.Text := BenchString2;
         MaxSpread := Spread;
         MaxSpreadBenchPercentageEdit.Text := FloatToStrF(MaxSpread, ffFixed, 9, 2);
         FunctionNameEdit.Text := FunctionName1;
         MaxSpreadBenchPercentageEdit.Color := clGreen;
         if MaxSpread > 1 then
          MaxSpreadBenchPercentageEdit.Color := clYellow;
         if MaxSpread > 3 then
          MaxSpreadBenchPercentageEdit.Color := clRed;
         Update;
        end
       else
        begin
         //MaxSpreadBenchPercentageEdit.Color := clGreen;
         //MaxSpreadBenchPercentageEdit.Text := FloatToStrF(MaxSpread, ffFixed, 9, 2);
        end;
      end;
    end;
  end;
end;

//Removes multiple results from same function. Preserves the fastest result

procedure TMainForm.CleanResultsRichEdit;
var
 LineNo1, LineNo2, Tab1Pos1, Tab1Pos2 : Integer;
 S1, S2, FunctionName1, FunctionName2 : AnsiString;

begin
 for LineNo1 := 0 to ReportRichEdit.Lines.Count-2 do
  begin
   S1 := ReportRichEdit.Lines[LineNo1];
   LineNo2 := LineNo1+1;
   while LineNo2 <= ReportRichEdit.Lines.Count-1 do
    begin
     S2 := ReportRichEdit.Lines[LineNo2];
     Tab1Pos1 := CharPos(#9, S1);
     Tab1Pos2 := CharPos(#9, S2);
     FunctionName1 := Copy(S1, 0, Tab1Pos1-1);
     FunctionName2 := Copy(S2, 0, Tab1Pos2-1);
     if FunctionName1 = FunctionName2 then
      begin
       ReportRichEdit.Lines.Delete(LineNo2);
       Dec(LineNo2);
      end;
     Inc(LineNo2);
    end;
  end;
end;

function TMainForm.Validate1 : Boolean;
var
 X, Y, Z : Int64;
 MAXINT64fp : Extended;

begin
 Result := True;
 X := 10;
 Y := 5;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X * Y
 else
  Z := Int64MulFunction(X, Y);
 if Z <> 50 then
  begin
   Result := False;
   Exit;
  end;
 X := 1;
 Y := MAXINT64;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X * Y
 else
  Z := Int64MulFunction(X, Y);
 if Z <> MAXINT64 then
  begin
   Result := False;
   Exit;
  end;
 X := -1;
 Y := MAXINT64;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X * Y
 else
  Z := Int64MulFunction(X, Y);
 if Z <> -MAXINT64 then
  begin
   Result := False;
   Exit;
  end;
 X := 1;
 Y := -MAXINT64;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X * Y
 else
  Z := Int64MulFunction(X, Y);
 if Z <> -MAXINT64 then
  begin
   Result := False;
   Exit;
  end;
 X := -1;
 Y := -MAXINT64;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X * Y
 else
  Z := Int64MulFunction(X, Y);
 if Z <> MAXINT64 then
  begin
   Result := False;
   Exit;
  end;
 MAXINT64fp := MAXINT64;
 X := -Trunc(Sqrt(MAXINT64fp));
 Y := 2152999501;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X * Y
 else
  Z := Int64MulFunction(X, Y);
 if Z <> -6538660558883750999 then
  begin
   Result := False;
   Exit;
  end;
 MAXINT64fp := MAXINT64;
 X := Trunc(Sqrt(MAXINT64fp));
 Y := Trunc(Sqrt(MAXINT64fp));
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X * Y
 else
  Z := Int64MulFunction(X, Y);
 if Z <> 9223372030926249001 then
  begin
   Result := False;
   Exit;
  end;
 X := 4611000000000000000;
 Y := -2;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X * Y
 else
  Z := Int64MulFunction(X, Y);
 if Z <> -(4611000000000000000 + 4611000000000000000) then
  begin
   Result := False;
  end;
end;

function TMainForm.Validate2 : Boolean;
var
 X, Y, Z : Int64;

begin
 X := 2;
 Y := MAXINT;
 if FunctionSelectionRadioGroup.ItemIndex = 0 then
  Z := X * Y
 else
  Z := Int64MulFunction(X, Y);
 if Z = X*Y then
  Result := True
 else
  Result := False;
end;

function TMainForm.Validate3 : Boolean;
var
 X, Y, Z1, Z2 : Int64;
const
 YSTEPSIZE : Cardinal = 10000000;
 XSTEPSIZE : Cardinal = 10000000;
 MAXVALIDATE3 : Int64 = 3037000499;

begin
 Result := True;
 X := -MAXVALIDATE3;
 while X < (MAXVALIDATE3-XSTEPSIZE) do
  begin
   Y := -MAXVALIDATE3;
   while Y < (MAXVALIDATE3-YSTEPSIZE) do
    begin
     Z1 := X * Y;
     if FunctionSelectionRadioGroup.ItemIndex = 0 then
      Z2 := X * Y
     else
      Z2 := Int64MulFunction(X, Y);
     if Z1 <> Z2 then
      begin
       Result := False;
       Break;
      end;
     Inc(Y, YSTEPSIZE);
    end;
   Inc(X, XSTEPSIZE);
  end;
end;

function TMainForm.Validate4 : Boolean;
var
 X, Y, Z1, Z2, Ymin, Ymax : Int64;
const
 XSTEPSIZE : Int64 = 1000000000000;
 YSTEPSIZE : Int64 = 1000000000000;

begin
 Result := True;
 X := MAXINT64;
 while X >= MAXINT do
  begin
   Ymin := 0;
   Ymax := Round(MAXINT64/X);
   Y := Ymin;
   while Y <= Ymax do
    begin
     Z1 := X * Y;
     if FunctionSelectionRadioGroup.ItemIndex = 0 then
      Z2 := X * Y
     else
      Z2 := Int64MulFunction(X, Y);
     if Z1 <> Z2 then
      begin
       Result := False;
       Break;
      end;
     Inc(Y, YSTEPSIZE);
    end;
   Dec(X, XSTEPSIZE);
  end;
end;

function TMainForm.Validate5 : Boolean;
var
 X, Y, Z1, Z2, Ymin, Ymax : Int64;
const
 XSTEPSIZE : Int64 = 1000000000000;
 YSTEPSIZE : Int64 = 1;
 MAXVALIDATE5 : Int64 = 3037000499;

begin
 Result := True;
 X := MAXINT64;
 while X > MAXVALIDATE5+XSTEPSIZE do
  begin
   Ymin := -Trunc(MAXINT64/X);
   Ymax := 0;
   Y := Ymin;
   while Y <= Ymax do
    begin
     Z1 := X * Y;
     if FunctionSelectionRadioGroup.ItemIndex = 0 then
      Z2 := X * Y
     else
      Z2 := Int64MulFunction(X, Y);
     if Z1 <> Z2 then
      begin
       Result := False;
       Break;
      end;
     Inc(Y, YSTEPSIZE);
    end;
   Dec(X, XSTEPSIZE);
  end;
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
var
 FunctionAddress : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  ValidateButton.Caption := 'Running';
  ValidationEdit.Color := clBlue;
  Update;
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@Int64MulFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  if Validate1 and
     Validate2 and
     Validate3 and
     Validate4 and
     Validate5 then
   begin
    ValidationEdit.Color := clGreen;
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Passed');
   end
  else
   begin
    ValidationEdit.Color := clRed;
    ReportRichEdit.Lines.Add(FunctionName + #9 + 'Failed');
   end;
  ValidateButton.Caption := 'Validate';
 except
  ValidateButton.Caption := 'Validate';
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Failed');
 end;
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
begin
 RunBenchmark;
end;

procedure TMainForm.RunBenchmark;
var
 FunctionAddress, Bench, SubBench1, SubBench2 : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  BenchmarkButton.Caption := 'Running';
  Update;
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@Int64MulFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  if FunctionSelectionRadioGroup.ItemIndex = 0 then
   begin
    SubBench1 := SubBenchmarkRTL1;
    SubBench2 := SubBenchmarkRTL2;
   end
  else
   begin
    SubBench1 := SubBenchmark1;
    SubBench2 := SubBenchmark2;
   end;
  Bench := SubBench1 + SubBench2;
  RuntimeEdit.Text := IntToStr(Bench);
  ReportRichEdit.Lines.Add(FunctionName + #9 + IntToStr(SubBench1)
                                        + #9 + IntToStr(SubBench2)
                                        + #9 + IntToStr(Bench));
  SortRichEdit;
  BenchmarkTest;
  BenchmarkButton.Caption := 'Benchmark';
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + 'Failed'
                                        + #9 + '999'
                                        + #9 + '999');
 end;
end;

function TMainForm.SubBenchmark1 : Cardinal;
var
 I1, I4 : Cardinal;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;

begin
 SubBench1Z1 := 0;
 SubBench1Z2 := 0;
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   SubBench1X := -SUBBENCH1XMAX; //SUBBENCH1XMIN;
   while SubBench1X < SUBBENCH1XMAX-SUBBENCH1STEPSIZE do
    begin
     SubBench1Y := -SUBBENCH1XMAX;//SUBBENCH1YMIN;
     while SubBench1Y < SUBBENCH1YMAX-SUBBENCH1STEPSIZE do
      begin
       SubBench1Z1 := Int64MulFunction(SubBench1X, SubBench1Y);
       SubBench1Z2 := Int64MulFunction(SubBench1X, SubBench1Y);
       Inc(SubBench1Y, SUBBENCH1STEPSIZE);
      end;
     Inc(SubBench1X, SUBBENCH1STEPSIZE);
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   NoOfTicksArray[I1] := NoOfTicks;
  end;
 ZEdit.Text := IntToStr(SubBench1Z1);
 ZEdit.Text := IntToStr(SubBench1Z2);
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / PerformanceFrequency;
 Result := Round(RunTimeSec * SUBBENCH1SCALE);
end;

function TMainForm.SubBenchmark2 : Cardinal;
var
 I1, I4 : Cardinal;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;

begin
 SubBench2Z1 := 0;
 SubBench2Z2 := 0;
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   SubBench2X := 1;
   SubBench2Y := SUBBENCH2YMIN;
   while SubBench2Y < SUBBENCH2YMAX-SUBBENCH2STEPSIZE do
    begin
     SubBench2Z1 := Int64MulFunction(SubBench2X, SubBench2Y);
     SubBench2Z2 := Int64MulFunction(SubBench2X, SubBench2Y);
     Inc(SubBench2Y, SUBBENCH2STEPSIZE);
    end;
   SubBench2Y := 1;
   SubBench2X := SUBBENCH2XMIN;
   while SubBench2X < SUBBENCH2XMAX-SUBBENCH2STEPSIZE do
    begin
     SubBench2Z1 := Int64MulFunction(SubBench2X, SubBench2Y);
     SubBench2Z2 := Int64MulFunction(SubBench2X, SubBench2Y);
     Inc(SubBench2X, SUBBENCH2STEPSIZE);
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   NoOfTicksArray[I1] := NoOfTicks;
  end;
 ZEdit.Text := IntToStr(SubBench2Z1);
 ZEdit.Text := IntToStr(SubBench2Z2);
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / PerformanceFrequency;
 Result := Round(RunTimeSec * SUBBENCH2SCALE);
end;

function TMainForm.SubBenchmarkRTL1 : Cardinal;
var
 I1, I4 : Cardinal;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;

begin
 SubBench1Z1 := 0;
 SubBench1Z2 := 0;
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   SubBench1X := -SUBBENCH1XMAX;//SUBBENCH1XMIN;
   while SubBench1X < SUBBENCH1XMAX-SUBBENCH1STEPSIZE do
    begin
     SubBench1Y := -SUBBENCH1XMAX;//SUBBENCH1YMIN;
     while SubBench1Y < SUBBENCH1YMAX-SUBBENCH1STEPSIZE do
      begin
       SubBench1Z1 := SubBench1X * SubBench1Y;
       SubBench1Z2 := SubBench1X * SubBench1Y;
       Inc(SubBench1Y, SUBBENCH1STEPSIZE);
      end;
     Inc(SubBench1X, SUBBENCH1STEPSIZE);
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   NoOfTicksArray[I1] := NoOfTicks;
  end;
 ZEdit.Text := IntToStr(SubBench1Z1);
 ZEdit.Text := IntToStr(SubBench1Z2);
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / PerformanceFrequency;
 Result := Round(RunTimeSec * SUBBENCH1SCALE);
end;

function TMainForm.SubBenchmarkRTL2 : Cardinal;
var
 I1, I4 : Cardinal;
 Succes : Boolean;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 RunTimeSec : Double;

begin
 SubBench2Z1 := 0;
 SubBench2Z2 := 0;
 for I1 := 0 to NOOFRERUNS-1 do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   SubBench2X := 1;
   SubBench2Y := SUBBENCH2YMIN;
   while SubBench2Y < SUBBENCH2YMAX-SUBBENCH2STEPSIZE do
    begin
     SubBench2Z1 := SubBench2X * SubBench2Y;
     SubBench2Z2 := SubBench2X * SubBench2Y;
     Inc(SubBench2Y, SUBBENCH2STEPSIZE);
    end;
   SubBench2Y := 1;
   SubBench2X := SUBBENCH2XMIN;
   while SubBench2X < SUBBENCH2XMAX-SUBBENCH2STEPSIZE do
    begin
     SubBench2Z1 := SubBench2X * SubBench2Y;
     SubBench2Z2 := SubBench2X * SubBench2Y;
     Inc(SubBench2X, SUBBENCH2STEPSIZE);
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   NoOfTicksArray[I1] := NoOfTicks;
  end;
 ZEdit.Text := IntToStr(SubBench2Z1);
 ZEdit.Text := IntToStr(SubBench2Z2);
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I4 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / PerformanceFrequency;
 Result := Round(RunTimeSec * SUBBENCH2SCALE);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
 I : Integer;
 CpuString : string;
begin
 if not QueryPerformanceFrequency(PerformanceFrequency) then
  raise Exception.Create('QueryPerformanceFrequency failed');
 MaxFunctionNumber := FunctionSelectionRadioGroup.Items.Count-1;
 BenchRunNo := 0;
 BenchThreadPrioRadioGroupClick(nil);
 Int64MulFunction := Int64Mul_RTL_IA32_2;
 ReportRichEdit.Clear;
 ClearAllEditBoxes;
 ReportRichEdit.Paragraph.TabCount := 5;
 ReportRichEdit.Paragraph.Tab[0] := 100;
 ReportRichEdit.Paragraph.Tab[1] := 130;
 ReportRichEdit.Paragraph.Tab[2] := 160;
 ReportRichEdit.Paragraph.Tab[3] := 190;
 ReportRichEdit.Paragraph.Tab[4] := 250;
 FunctionSelectionRadioGroupClick(nil);
 SetLength(SubBench1XArray, ARRAYSIZE);
 SetLength(SubBench1YArray, ARRAYSIZE);
 SetLength(SubBench1ZArray, ARRAYSIZE);
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionNameArray[I] := FunctionSelectionRadioGroup.Items[I];
  end;
 SetLength(NoOfTicksArray, NOOFRERUNS);

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

procedure TMainForm.FormDestroy(Sender: TObject);
begin
 FreeAndNil(FResultList);
end;

procedure TMainForm.FunctionSelectionRadioGroupClick(Sender: TObject);
begin
 FunctionSelected := FunctionSelectionRadioGroup.ItemIndex;
 SelectFunction(FunctionSelectionRadioGroup.ItemIndex);
end;

procedure TMainForm.SelectFunction(FuncNo : Integer);
begin
 case FuncNo+1 of
  1 : ;
  2 : Int64MulFunction := Int64Mul_RTL_IA32_2;
  3 : Int64MulFunction := Int64Mul_DKC_IA32_2;
  4 : Int64MulFunction := Int64Mul_JOH_IA32_1;
  5 : Int64MulFunction := Int64Mul_AMD_IA32_1;
  6 : Int64MulFunction := Int64Mul_JOH_IA32_2;
 else
  raise Exception.Create('Invalid Function Number');
 end;
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
begin
 BenchmarkAll;
end;

procedure TMainForm.BenchmarkAll;
var
 I : Cardinal;

begin
 BenchmarkAllButton.Caption := 'Running';
 Update;
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   RunBenchmark;
  end;
 BenchmarkAllButton.Caption := 'Benchmark All';

 if FileExists(FBenchmarkFileName) then FResultList.LoadFromFile(FBenchmarkFileName);
 FResultList.Add(Format('[%s %s] Running "%s" benchmark version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FBenchmarkFileName);
end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 ValidateAllButton.Caption := 'Running';
 Update;
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   ValidateButtonClick(nil);
   Update;
  end;
 ValidateAllButton.Caption := 'Validate All';

 if FileExists(FValidationFileName) then FResultList.LoadFromFile(FValidationFileName);
 FResultList.Add(Format('[%s %s] Running "%s" validation version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FValidationFileName);
end;

procedure TMainForm.SaveReportSpeedButtonClick(Sender: TObject);
begin
 SaveDialog.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
 SaveDialog.FileName := FResultsFileName;
 if SaveDialog.Execute then
  ReportRichEdit.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TMainForm.PrintReportSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('Int64Mul Report');
end;

procedure TMainForm.BenchTestButtonClick(Sender: TObject);
begin
 BenchmarkTestEventHandler;
end;

procedure TMainForm.BenchmarkTestEventHandler;
var
 I1, I2 : Cardinal;

begin
 if False then
  begin
  end
 else
  begin
   BenchTestButton.Caption := 'Running';
   Update;
  end;
 if False then
  begin
   for I1 := 0 to MaxFunctionNumber do
    begin
     for I2 := 0 to MaxFunctionNumber do
      begin
       FunctionSelected := I2;
       SelectFunction(I2);
       RunBenchmark;
      end;
     FunctionSelected := I1;
     SelectFunction(I1);
     RunBenchmark;
    end;
  end
 else
  begin
   for I1 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
    begin
     for I2 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
      begin
       FunctionSelectionRadioGroup.ItemIndex := I2;
       RunBenchmark;
      end;
     FunctionSelectionRadioGroup.ItemIndex := I1;
     RunBenchmark;
    end;
  end;
 if False then
  begin
   PublishBenchResults;
  end
 else
  begin
   BenchTestButton.Caption := 'Bench Test';
  end;
end;

procedure TMainForm.SpreadTestButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 for I := 1 to 20 do
  begin
   BenchmarkButtonClick(nil);
   Update;
  end;
end;

procedure TMainForm.MaxSpreadBenchPercentageEditClick(Sender: TObject);
begin
 MaxSpreadBenchPercentageEdit.SelectAll;
 MaxSpreadBenchPercentageEdit.CopyToClipboard;
end;

procedure TMainForm.CleanResultsButtonClick(Sender: TObject);
begin
 CleanResultsRichEdit;
 BenchmarkTest;
end;

procedure TMainForm.BenchThreadPrioRadioGroupClick(Sender: TObject);
begin
 case BenchThreadPrioRadioGroup.ItemIndex of
  0 :
   begin
    if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_IDLE) = False then
     raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_IDLE failed');
   end;
  1 :
   begin
    if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_NORMAL) = False then
     raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_NORMAL failed');
   end;
  2 :
   begin
    if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_ABOVE_NORMAL) = False then
     raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_ABOVE_NORMAL failed');
   end;
  3 :
   begin
    if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_HIGHEST) = False then
     raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_HIGHEST failed');
   end;
  4 :
   begin
    if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_TIME_CRITICAL) = False then
     raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_TIME_CRITICAL failed');
   end;
 else
  raise Exception.Create('XXXXXXXXXXXXXXXXXXXXXXXXXXX');
 end;
end;

procedure TMainForm.SpeedButton1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 BenchmarkTestEventHandler;
end;

procedure TMainForm.SpeedButton2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 RunBenchmark;
 PublishBenchResults;
end;

procedure TMainForm.SpeedButton3MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 BenchmarkAll;
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
