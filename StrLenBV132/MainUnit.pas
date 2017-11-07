unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'StrLen';

type

  TMainForm = class(TForm)
    CloseBitBtn: TBitBtn;
    ReportRichEdit: TRichEdit;
    SaveDialog1: TSaveDialog;
    RunAllBenchmarksButton: TButton;
    FunctionSelectionRadioGroup: TRadioGroup;
    Panel1: TPanel;
    PrintSpeedButton: TSpeedButton;
    SaveAsSpeedButton: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ValidateAllButton: TButton;
    BenchmarkButton: TButton;
    ResultEdit: TEdit;
    ValidateButton: TButton;
    ShowErrorDialogCheckBox: TCheckBox;
    Label8: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    SpreadBench1Edit: TEdit;
    SpreadBench2Edit: TEdit;
    AlignMaxSpreadBenchPercentageEdit: TEdit;
    AlignFunctionName1Edit: TEdit;
    AlignFunctionName2Edit: TEdit;
    FunctionNameEdit: TEdit;
    MaxSpreadBenchPercentageEdit: TEdit;
    BenchTestButton: TButton;
    ClearButton: TButton;
    AlignSpreadBench1Edit: TEdit;
    AlignSpreadBench2Edit: TEdit;
    Label1: TLabel;
    Label9: TLabel;
    AlignCheckButton: TButton;
    AlignCheckEdit: TEdit;
    CleanButton: TButton;
    RunTimeEdit: TEdit;
    Label2: TLabel;
    AboutSpeedButton: TSpeedButton;
    procedure FormDestroy(Sender: TObject);
    procedure AboutSpeedButtonClick(Sender: TObject);
    procedure CleanButtonClick(Sender: TObject);
    procedure AlignCheckButtonClick(Sender: TObject);
    procedure BenchmarkButtonClick(Sender: TObject);
    procedure ValidateButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure RunAllBenchmarksButtonClick(Sender: TObject);
    procedure FunctionSelectionRadioGroupClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure PrintSpeedButtonClick(Sender: TObject);
    procedure BenchTestButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
  private
   FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
   FResultList: TStringList;
   Frequency : Int64;
   NoOfTicksArray : array of Int64;
   function SubBenchmark1 : Double;
   function SubBenchmark2 : Double;
   procedure BenchmarkStrLen;
   function Validate1 : Boolean;
   function Validate2 : Boolean;
   function Validate3 : Boolean;
   function Validate4 : Boolean;
   function Validate5 : Boolean;
   function Validate6 : Boolean;
   function Validate7 : Boolean;
   function Validate8 : Boolean;
   function Validate9 : Boolean;
   function Validate10 : Boolean;
   function Validate11 : Boolean;
   function Validate12 : Boolean;
   function Validate13 : Boolean;
   function Validate14 : Boolean;
   function Validate15 : Boolean;
   function Validate16 : Boolean;
   function Validate17 : Boolean;
   procedure SortRichEdit;
  public
   procedure AlignmentTest;
   procedure ClearAllEditBoxes;
   procedure BenchmarkTest;
   procedure CleanResultsRichEdit;
   procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 StrUtils, Math, FastCodeCPUID, StrLenDKCUnit, StrLenJOHUnit, StrLenLBGUnit, AboutUnit,
  StrLenPLRUnit, SystemInfoUnit;

type
 TStrLenFunction = function (const Str: PChar): Cardinal;

var
 StrLenFunction : TStrLenFunction;
 SubBench1TestArray : array[1..25] of Char;
 SubBench2TestArray : array[1..250] of Char;

const
 NOOFRERUNS : Cardinal = 22;
 MAXNOOFRUNSSUB1 : Cardinal = 12000000;
 MAXNOOFRUNSSUB2 : Cardinal =  5000000;
 //Adjusted according to spreadsheet
 SUBBENCH1SCALE : Double = 2780;
 SUBBENCH2SCALE : Double = 3180;

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

//Finds the maximum spread in benchmarks due to code lignment for any function.

procedure TMainForm.AlignmentTest;
var
 I1, I2, LineNo1, LineNo2, X1, X2, TabNo1, TabNo2 : Integer;
 S1, S2, BenchString1, BenchString2, FunctionName1, FunctionName2,
 ShortFunctionName1, ShortFunctionName2 : AnsiString;
 Bench1, Bench2, AverageBench, Spread, DeltaBench, MaxSpread : Double;
 C1, C2 : Char;
 Tab1Pos1, Tab1Pos2 : Cardinal;

begin
 if ReportRichEdit.Lines.Count < 2 then
  Exit;
 AlignSpreadBench1Edit.Text := '';
 AlignSpreadBench2Edit.Text := '';
 AlignMaxSpreadBenchPercentageEdit.Text := '';
 AlignFunctionName1Edit.Text := '';
 AlignFunctionName2Edit.Text := '';
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
     ShortFunctionName1 := Copy(S1, 0, Tab1Pos1-3);
     ShortFunctionName2 := Copy(S2, 0, Tab1Pos2-3);
     if ShortFunctionName1 = ShortFunctionName2 then
      begin
       if (FunctionName1[Length(FunctionName1)] = 'a') or
          (FunctionName1[Length(FunctionName1)] = 'b') or
          (FunctionName1[Length(FunctionName1)] = 'c') or
          (FunctionName1[Length(FunctionName1)] = 'd') then
        begin
         if (FunctionName2[Length(FunctionName1)] = 'a') or
            (FunctionName2[Length(FunctionName1)] = 'b') or
            (FunctionName2[Length(FunctionName1)] = 'c') or
            (FunctionName2[Length(FunctionName1)] = 'd') then
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
             AlignSpreadBench1Edit.Text := BenchString1;
             AlignSpreadBench2Edit.Text := BenchString2;
             MaxSpread := Spread;
             AlignMaxSpreadBenchPercentageEdit.Text := FloatToStrF(MaxSpread, ffFixed, 9, 1);
             AlignFunctionName1Edit.Text := FunctionName1;
             AlignFunctionName2Edit.Text := FunctionName2;
             Update;
            end;
          end;
        end;
      end;
    end;
  end;
end;

//Finds the maximum spread in benchmarks for any function.

procedure TMainForm.BenchmarkTest;
var
 I1, I2, LineNo1, LineNo2, X1, X2, TabNo1, TabNo2 : Integer;
 S1, S2, BenchString1, BenchString2, FunctionName1, FunctionName2,
 MaxBenchString1, MaxBenchString2, MaxFunctionName : AnsiString;
 Bench1, Bench2, AverageBench, Spread, DeltaBench, MaxSpread : Double;
 C1, C2 : Char;
 Tab1Pos1, Tab1Pos2 : Cardinal;
  TwoFunctionResults: Boolean;

begin
 TwoFunctionResults := False;
 if ReportRichEdit.Lines.Count < 2 then
  Exit;
 SpreadBench1Edit.Text := '';
 SpreadBench2Edit.Text := '';
 FunctionNameEdit.Text := '';
 MaxSpreadBenchPercentageEdit.Text := '';
 MaxSpreadBenchPercentageEdit.Color := clInfobk;
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
       TwoFunctionResults := True;
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
       if Spread >= MaxSpread then
        begin
         MaxBenchString1 := BenchString1;
         MaxBenchString2 := BenchString2;
         MaxSpread := Spread;
         MaxFunctionName := FunctionName1;
        end;
      end;
    end;
  end;
 if TwoFunctionResults then
  begin
   SpreadBench1Edit.Text := MaxBenchString1;
   SpreadBench2Edit.Text := MaxBenchString2;
   FunctionNameEdit.Text := MaxFunctionName;
   MaxSpreadBenchPercentageEdit.Text := FloatToStrF(MaxSpread, ffFixed, 9, 1);
   MaxSpreadBenchPercentageEdit.Color := clGreen;
   if MaxSpread > 1 then
    MaxSpreadBenchPercentageEdit.Color := clYellow;
   if MaxSpread > 2 then
    MaxSpreadBenchPercentageEdit.Color := clRed;
   Update;
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

procedure TMainForm.CleanButtonClick(Sender: TObject);
begin
 CleanResultsRichEdit;
 BenchmarkTest;
end;

procedure ErrorTrap(ValidateNo : Integer; Str: PAnsiChar);
begin
 StrLenFunction(Str);
 if MainForm.ShowErrorDialogCheckBox.Checked then
  Application.MessageBox(PChar('Function failed in Validate' + IntToStr(ValidateNo) + ' String: ' + Str), 'Error');
end;

procedure ErrorTrapException(ValidateNo : Integer; Str: PAnsiChar);
begin
 StrLenFunction(Str);
 if MainForm.ShowErrorDialogCheckBox.Checked then
  Application.MessageBox(PChar('Function failed in Validate on exception' + IntToStr(ValidateNo) + ' String: ' + Str), 'Error');
end;

procedure TMainForm.BenchmarkStrLen;
var
 Bench, SubBench1, SubBench2 : Double;
 FunctionName, StrLenFunctionAddressString : AnsiString;
 StrLenFunctionAddress : Cardinal;

begin
 try
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  StrLenFunctionAddress := Integer(@StrLenFunction);
  StrLenFunctionAddressString := IntToHex(StrLenFunctionAddress, 8);
  Update;
  SubBench1 := SubBenchmark1;
  SubBench2 := SubBenchmark2;
  Bench := SubBench1 + SubBench2;
  ReportRichEdit.Lines.Add(FunctionName  + #9 +
                           StrLenFunctionAddressString[8] + #9 +
                           FloatToStrF(SubBench1, ffFixed, 9, 0) + #9 +
                           FloatToStrF(SubBench2, ffFixed, 9, 0) + #9 +
                           FloatToStrF(Bench, ffFixed, 9, 0));
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName  + #9 +
                                     'Failed' + #9 +
                                     '9999' + #9 +
                                     '9999' + #9 +
                                     '9999');
 end;
end;

function TMainForm.SubBenchmark1 : Double;
var
 J, I1, I2, K : Cardinal;
 RunNo : Cardinal;
 RunTimeSec : Double;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 Str : PChar;
 SubBench1TestArrayLength : Integer;

begin
 RandSeed := 0;
 I1 := 0;
 SubBench1TestArrayLength := Length(SubBench1TestArray);
 for J := 1 to NOOFRERUNS do
  begin
   if QueryPerformanceCounter(lpPerformanceCount) then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for RunNo := 1 to MAXNOOFRUNSSUB1 do
    begin
     K := Random(SubBench1TestArrayLength-1)+1;
     Str := @SubBench1TestArray[K];
     I1 := StrLenFunction(Str);
    end;
   if QueryPerformanceCounter(lpPerformanceCount) then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   NoOfTicksArray[J-1] := NoOfTicks;
  end;
 ResultEdit.Text := IntToStr(I1);
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I2 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I2] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I2];
  end;
 RunTimeSec := MinNoOfTicks / Frequency;
 Result := Round(RunTimeSec*SUBBENCH1SCALE);
end;

function TMainForm.SubBenchmark2 : Double;
var
 J, I1, I2, K : Cardinal;
 RunNo : Cardinal;
 RunTimeSec : Double;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 Str : PChar;
  SubBench1TestArrayLength: Integer;
  SubBench2TestArrayLength: Integer;
  TestArrayLengthDifference: Integer;

begin
 I1 := 0;
 SubBench1TestArrayLength := Length(SubBench1TestArray);
 SubBench2TestArrayLength := Length(SubBench2TestArray);
 TestArrayLengthDifference := SubBench2TestArrayLength - SubBench1TestArrayLength;
 for J := 1 to NOOFRERUNS do
  begin
   if QueryPerformanceCounter(lpPerformanceCount) then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for RunNo := 1 to MAXNOOFRUNSSUB2 do
    begin
     K := Random(TestArrayLengthDifference-1)+1;
     Str := @SubBench2TestArray[K];
     I1 := StrLenFunction(Str);
    end;
   if QueryPerformanceCounter(lpPerformanceCount) then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   NoOfTicksArray[J-1] := NoOfTicks;
  end;
 ResultEdit.Text := IntToStr(I1);
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I2 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I2] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I2];
  end;
 RunTimeSec := MinNoOfTicks / Frequency;
 Result := Round(RunTimeSec*SUBBENCH2SCALE);
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
begin
 BenchmarkButton.Caption := 'Running';
 BenchmarkStrLen;
 if ReportRichEdit.Lines.Count > 1 then
  SortRichEdit;
 BenchmarkTest;
 AlignmentTest;
 BenchmarkButton.Caption := 'Benchmark';
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
var
 FunctionName, StrLenFunctionAddressString : AnsiString;
 StrLenFunctionAddress : Cardinal;

begin
 try
  ValidateButton.Caption := 'Running';
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  StrLenFunctionAddress := Integer(@StrLenFunction);
  StrLenFunctionAddressString := IntToHex(StrLenFunctionAddress, 8);
  if Validate1 and
     Validate2 and
     Validate3 and
     Validate4 and
     Validate5 and
     Validate6 and
     Validate7 and
     Validate8 and
     Validate9 and
     Validate10 and
     Validate11 and
     Validate12 and
     Validate13 and
     Validate14 and
     Validate15 and
     Validate16 and
     Validate17 then
   ReportRichEdit.Lines.Add(FunctionName + #9 + StrLenFunctionAddressString[8] + #9 + 'Passed')
  else
   ReportRichEdit.Lines.Add(FunctionName + #9 + StrLenFunctionAddressString[8] + #9 + 'Failed');
  Update;
 except
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  StrLenFunctionAddress := Integer(@StrLenFunction);
  StrLenFunctionAddressString := IntToHex(StrLenFunctionAddress, 8);
  ReportRichEdit.Lines.Add(FunctionName + #9 + StrLenFunctionAddressString[8] + #9 + 'Failed');
 end;
 ValidateButton.Caption := 'Validate';
end;

function TMainForm.Validate1 : Boolean;
var
 I : Cardinal;
 Str : PChar;
const
 VALIDATENO : Cardinal = 1;

begin
 Str := '';
 try
  Result := True;
  I := StrLenFunction(Str);
  if I <> 0 then
   begin
    ErrorTrap(VALIDATENO, Str);
    Result := False;
   end;
 except
  ErrorTrapException(VALIDATENO, Str);
  Result := False
 end;
end;

function TMainForm.Validate2 : Boolean;
var
 I : Cardinal;
 Str : PChar;
const
 VALIDATENO : Cardinal = 2;

begin
 Str := '';//For compiler
 try
  Result := True;
  Str := 'A';
  I := StrLenFunction(Str);
  if I <> 1 then
   begin
    ErrorTrap(VALIDATENO, Str);
    Result := False;
    Exit;
   end;
  Str := 'BA';
  I := StrLenFunction(Str);
  if I <> 2 then
   begin
    ErrorTrap(VALIDATENO, Str);
    Result := False;
    Exit;
   end;
  Str := 'BAX';
  I := StrLenFunction(Str);
  if I <> 3 then
   begin
    ErrorTrap(VALIDATENO, Str);
    Result := False;
    Exit;
   end;
  Str := 'BAXQ';
  I := StrLenFunction(Str);
  if I <> 4 then
   begin
    ErrorTrap(VALIDATENO, Str);
    Result := False;
    Exit;
   end;
  Str := 'AB';
  I := StrLenFunction(Str);
  if I <> 2 then
   begin
    ErrorTrap(VALIDATENO, Str);
    Result := False;
   end;
 except
  ErrorTrapException(VALIDATENO, Str);
  Result := False
 end;
end;

function TMainForm.Validate3 : Boolean;
var
 I, J, K : Integer;
 Str : PChar;
 TestArray : array[1..12345] of Char;
const
 VALIDATENO : Cardinal = 3;

begin
 Str := '';//For compiler
 try
  Result := True;
  for K := 1 to Length(TestArray) - 1 do
   TestArray[K] := 'T';
  TestArray[Length(TestArray)] := #0;
  for J := Length(TestArray) downto 1 do
   begin
    Str := @TestArray[J];
    I := StrLenFunction(Str);
    if I <> Length(TestArray)-J then
     begin
      ErrorTrap(VALIDATENO, Str);
      Result := False;
      Exit;
     end;
   end;
 except
  ErrorTrapException(VALIDATENO, Str);
  Result := False
 end;
end;

function TMainForm.Validate4 : Boolean;
var
 I, J, K : Integer;
 Str : PChar;
 TestArray : array of Char;
const
 TESTARRAYSIZE : Integer = 10000;
 VALIDATENO : Cardinal = 4;

begin
 Str := '';//For compiler
 try
  Result := True;
  SetLength(TestArray, TESTARRAYSIZE);
  for K := 0 to Length(TestArray) - 1 do
   TestArray[K] := Char(K mod 255 + 1);
  TestArray[Length(TestArray)-1] := #0;
  for J := 0 to Length(TestArray)-1 do
   begin
    Str := @TestArray[J];
    I := StrLenFunction(Str);
    if I <> Length(TestArray)-J-1 then
     begin
      ErrorTrap(VALIDATENO, Str);
      Result := False;
      Exit;
     end;
   end;
 except
  ErrorTrapException(VALIDATENO, Str);
  Result := False
 end;
end;

function TMainForm.Validate5 : Boolean;
var
 I, J, K, TestArraySize : Integer;
 Str : PChar;
 TestArray : array of Char;
const
 TESTARRAYSIZEMAX : Integer = 3000;
 VALIDATENO : Cardinal = 5;

begin
 Str := '';//For compiler
 try
  Result := True;
  for TestArraySize := 1 to TESTARRAYSIZEMAX do
   begin
    SetLength(TestArray, TestArraySize);
    for K := 0 to Length(TestArray) - 2 do
     TestArray[K] := Char(Random(255)+1);
    TestArray[Length(TestArray)-1] := #0;
    for J := 0 to Length(TestArray)-1 do
     begin
      Str := @TestArray[J];
      I := StrLenFunction(Str);
      if I <> Length(TestArray)-J-1 then
       begin
        ErrorTrap(VALIDATENO, Str);
        Result := False;
        Exit;
       end;
     end;
   end;
 except
  ErrorTrapException(VALIDATENO, Str);
  Result := False
 end;
end;

function TMainForm.Validate6 : Boolean;
var
 I, J, K, TestArraySize : Integer;
 Str : PChar;
 TestArray : array of Char;
const
 TESTARRAYSIZEMIN : Integer = 5000;
 TESTARRAYSIZEMAX : Integer = 50000;
 STEPSIZE : Integer = 12345;
 VALIDATENO : Cardinal = 6;

begin
 Str := '';//For compiler
 try
  Result := True;
  TestArraySize := TESTARRAYSIZEMIN;
  while TestArraySize < TESTARRAYSIZEMAX do
   begin
    SetLength(TestArray, TestArraySize);
    for K := 0 to Length(TestArray) - 2 do
     TestArray[K] := Char(Random(255)+1);
    TestArray[Length(TestArray)-1] := #0;
    for J := 0 to Length(TestArray)-1 do
     begin
      Str := @TestArray[J];
      I := StrLenFunction(Str);
      if I <> Length(TestArray)-J-1 then
       begin
        ErrorTrap(VALIDATENO, Str);
        Result := False;
        Exit;
       end;
     end;
    TestArraySize := TestArraySize + STEPSIZE;
   end;
 except
  ErrorTrapException(VALIDATENO, Str);
  Result := False
 end;
end;

{$HINTS OFF}

function TMainForm.Validate7 : Boolean;
var
 I, J, K : Integer;
 Str : PChar;
 TestArray : array of Char;
 EBXRegisterBefore, ESIRegisterBefore, EDIRegisterBefore,
 EBXRegisterAfter,  ESIRegisterAfter,  EDIRegisterAfter : Cardinal;
 X, Y, Z : Extended;

const
 TESTARRAYSIZE : Integer = 1000;
 VALIDATENO : Cardinal = 7;

begin
 Str := '';//For compiler
 try
  Result := True;
  SetLength(TestArray, TESTARRAYSIZE);
  for K := 0 to Length(TestArray) - 1 do
   TestArray[K] := Char(K mod 255 + 1);
  TestArray[Length(TestArray)-1] := #0;
  for J := 0 to Length(TestArray)-1 do
   begin
    Str := @TestArray[J];
    asm
     mov EBXRegisterBefore, ebx
     mov EDIRegisterBefore, edi
     mov ESIRegisterBefore, esi
    end;
    I := StrLenFunction(Str);
    asm
     mov EBXRegisterAfter, ebx
     mov EDIRegisterAfter, edi
     mov ESIRegisterAfter, esi
    end;
    //Verify that registers are preserved
    if ((EBXRegisterAfter <> EBXRegisterBefore) or
        (EDIRegisterAfter <> EDIRegisterBefore) or
        (ESIRegisterAfter <> ESIRegisterBefore)) then
     begin
      ErrorTrap(VALIDATENO, Str);
      Result := False;
      Exit;
     end;
    try
     X := 2;
     Y := 3;
     Z := X * Y;
     if Z <> 6 then
      Z := 6;
    except
     ErrorTrap(VALIDATENO, Str);
     Result := False;
     Exit;
    end;
    if I <> Length(TestArray)-J-1 then
     begin
      ErrorTrap(VALIDATENO, Str);
      Result := False;
      Exit;
     end;
   end;
 except
  ErrorTrapException(VALIDATENO, Str);
  Result := False
 end;
end;

{$HINTS ON}

//By John O'Harrow

function TMainForm.Validate8: boolean;
const
  PageSize = 4*1024;
  VALIDATENO : Cardinal = 8;
var
  Pages, BasePage: pchar;
  Page, adr: pchar;
  flags, Oldflags: dword;
begin;
  GetMem(Pages, 4*PageSize);
  BasePage := pchar(Integer(Pages) and -PageSize);
  try
    Page := BasePage + 1*PageSize;
    VirtualProtect(Page, 1, PAGE_NOACCESS, @Oldflags);
    Page := BasePage + 3*PageSize;
    VirtualProtect(Page, 1, PAGE_NOACCESS, @flags);
    Page := BasePage + 2*PageSize;
    adr := Page + PageSize - 2;
    adr^ := 'x';
    inc(adr);
    adr^ := #0;
    Result := True;
    try
      StrLenFunction(adr);
    except
      ErrorTrapException(VALIDATENO, adr);
      Result := False;
    end;
  finally
    Page := BasePage + 1*PageSize;
    VirtualProtect(Page, 1, OldFlags, @flags);
    Page := BasePage + 3*PageSize;
    VirtualProtect(Page, 1, OldFlags, @flags);
    FreeMem(Pages);
  end;
end;

function TMainForm.Validate9 : Boolean;
var
 I, J, K, TestArraySize, RunNo, Iref : Integer;
 Str : PChar;
 TestArray : array of Char;
const
 RUNNOMAX : Integer = 100;
 TESTARRAYSIZEMIN : Integer = 1;//Always at least a zero terminator
 TESTARRAYSIZEMAX : Integer = 1000;
 VALIDATENO : Cardinal = 9;

begin
 Str := '';//For compiler
 try
  Result := True;
  for RunNo := 1 to RUNNOMAX do
   begin
    TestArraySize := Random(TESTARRAYSIZEMAX - TESTARRAYSIZEMIN) + TESTARRAYSIZEMIN;
    SetLength(TestArray, TestArraySize);
    for K := 0 to Length(TestArray) - 2 do
     TestArray[K] := Char(Random(255));//Include insertion of #0's
    TestArray[Length(TestArray)-1] := #0;
    for J := 0 to Length(TestArray)-1 do
     begin
      Str := @TestArray[J];
      Iref := StrLenFunction(Str);
      I := StrLenFunction(Str);
      if I <> Iref then
       begin
        ErrorTrap(VALIDATENO, Str);
        Result := False;
        Exit;
       end;
     end;
   end;
 except
  ErrorTrapException(VALIDATENO, Str);
  Result := False
 end;
end;

function TMainForm.Validate10 : Boolean;
var
 I, J, K, TestArraySize, RunNo, Iref : Integer;
 Str : PChar;
 TestArray : array of Char;
const
 RUNNOMAX : Integer = 1000;
 TESTARRAYSIZEMIN : Integer = 17;//Always at least a zero terminator and 16 garbage bytes
 TESTARRAYSIZEMAX : Integer = 323;//Must be bigger than TESTARRAYSIZEMIN
 VALIDATENO : Cardinal = 10;

begin
 Str := '';//For compiler
 try
  Result := True;
  for RunNo := 1 to RUNNOMAX do
   begin
    TestArraySize := Random(TESTARRAYSIZEMAX - TESTARRAYSIZEMIN) + TESTARRAYSIZEMIN;
    SetLength(TestArray, TestArraySize);
    for K := 0 to Length(TestArray) - 2 do
     TestArray[K] := Char(Random(255));//Include insertion of #0's
    TestArray[Length(TestArray)-1] := #0;
    TestArray[Length(TestArray)-17] := #0;//Some functions read beyond the end of Str. Test that they handle any garbage there
    for J := 0 to Length(TestArray)-1 do
     begin
      Str := @TestArray[J];
      Iref := StrLenFunction(Str);
      I := StrLenFunction(Str);
      if I <> Iref then
       begin
        ErrorTrap(VALIDATENO, Str);
        Result := False;
        Exit;
       end;
     end;
   end;
 except
  ErrorTrapException(VALIDATENO, Str);
  Result := False
 end;
end;

function TMainForm.Validate11 : Boolean;
var
 I1, I2, I3, I4 : Cardinal;
 I, Iref : Integer;
 Str : PChar;
 TestArray : array of Cardinal;
const
 MAXI : Cardinal = 200;
 TESTARRAYSIZE : Integer = 5;
 VALIDATENO : Cardinal = 11;

begin
 Str := '';//For compiler
 try
  SetLength(TestArray, TestArraySize);
  TestArray[Length(TestArray)-1] := 0;
  Result := True;
  for I1 := 0 to MAXI do
   begin
    TestArray[0] := I1;
    for I2 := 0 to MAXI do
     begin
      TestArray[1] := I2;
      for I3 := 0 to MAXI do
       begin
        TestArray[2] := I3;
        for I4 := 0 to MAXI do
         begin
          TestArray[3] := I4;
          Str := @TestArray[0];
          Iref := StrLenFunction(Str);
          I := StrLenFunction(Str);
          if I <> Iref then
           begin
            ErrorTrap(VALIDATENO, Str);
            Result := False;
            Exit;
           end;
         end;
       end;
     end;
   end;
 except
  ErrorTrapException(VALIDATENO, Str);
  Result := False
 end;
end;

function TMainForm.Validate12 : Boolean;
var
 I1, I2, I3 : Cardinal;
 I, Iref : Integer;
 Str : PChar;
 TestArray : array of Char;
const
 MAXI : Cardinal = 200000;//$FFFFFFFF;
 TESTARRAYSIZE : Integer = 33;
 VALIDATENO : Cardinal = 12;

begin
 Str := '';//For compiler
 try
  SetLength(TestArray, TestArraySize);
  TestArray[Length(TestArray)-1] := #0;
  Result := True;
  for I1 := 0 to MAXI do
   begin
    for I2 := 0 to 31 do
     begin
      I3 := (I1 shr I2) and 1;
      if I3 = 0 then
       TestArray[I2] := #0
      else
       TestArray[I2] := 'X';
     end;
    Str := @TestArray[0];
    Iref := StrLenFunction(Str);
    I := StrLenFunction(Str);
    if I <> Iref then
     begin
      ErrorTrap(VALIDATENO, Str);
      Result := False;
      Exit;
     end;
   end;
 except
  ErrorTrapException(VALIDATENO, Str);
  Result := False
 end;
end;

//Based on Validate8 by John O'Harrow
//Changed by Dennis Christensen
//Original testcase: Str = 'x'
//Testcase: Str = 'XX'

function TMainForm.Validate13: boolean;
var
 Pages, BasePage: pchar;
 Page, adr: pchar;
 flags, Oldflags: dword;
const
 PageSize = 4*1024;//4 kB = 4096 Byte
 VALIDATENO : Cardinal = 13;

begin;
  //Get 4 pages big memory block
  GetMem(Pages, 4*PageSize);
  //A page starts at an 4096 byte aligned address
  //Get the address of the first complete page we have allocated
  BasePage := pchar(Integer(Pages) and -PageSize);
  try
   //Read and write protect page = BasePage + 1
   Page := BasePage + 1*PageSize;
   VirtualProtect(Page, 1, PAGE_NOACCESS, @Oldflags);
   //Read and write protect page = BasePage + 3
   Page := BasePage + 3*PageSize;
   VirtualProtect(Page, 1, PAGE_NOACCESS, @flags);
   //Get Page 2 which is located between the two protected pages
   Page := BasePage + 2*PageSize;
   //Get the address three bytes back from the page boundary
   adr := Page + PageSize - 3;
   //Make a 'XX' + #0 PChar rigth up to the border
   adr^ := 'X';
   inc(adr);
   adr^ := 'X';
   inc(adr);
   adr^ := #0;
   Result := True;
   try
    //StrLen must not read past the end of the string into another page and cause an AV exception
    StrLenFunction(adr);
   except
    Result := False;
    ErrorTrapException(VALIDATENO, adr);
   end;
  finally
   //Remove protection from the two protected pages
   Page := BasePage + 1*PageSize;
   VirtualProtect(Page, 1, OldFlags, @flags);
   Page := BasePage + 3*PageSize;
   VirtualProtect(Page, 1, OldFlags, @flags);
   //Release all 4 pages
   FreeMem(Pages);
  end;
end;

function TMainForm.Validate14: boolean;
var
 Pages, BasePage, Str : PChar;
 Page, adr, PageBorderAdr, StrStartAdr : PChar;
 flags, Oldflags: dword;
 StrSize, J : Integer;
const
 PageSize = 4*1024;//4 kB = 4096 Byte
 MAXSTRSIZE : Integer = 4095;//Leave 1 byte for the #0
 VALIDATENO : Cardinal = 14;

begin;
  //Get 4 pages big memory block
  GetMem(Pages, 4*PageSize);
  //A page starts at an 4096 byte aligned address
  //Get the address of the first complete page we have allocated
  BasePage := pchar(Integer(Pages) and -PageSize);
  try
   Result := True;
   //Read and write protect page = BasePage + 1
   Page := BasePage + 1*PageSize;
   VirtualProtect(Page, 1, PAGE_NOACCESS, @Oldflags);
   //Read and write protect page = BasePage + 3
   Page := BasePage + 3*PageSize;
   VirtualProtect(Page, 1, PAGE_NOACCESS, @flags);
   //Get Page 2 which is located between the two protected pages
   Page := BasePage + 2*PageSize;
   for StrSize := 1 to MAXSTRSIZE do
    begin
     //Get the page boundary address
     PageBorderAdr := Page + PageSize-1;
     //Get the address StrSize bytes back from the page boundary + make room for one #0
     StrStartAdr := PageBorderAdr - StrSize;
     Str := StrStartAdr;
     adr := StrStartAdr;
     PageBorderAdr^ := #0;
     //Make a 'XX....' + #0 PChar rigth up to the border
     for J := 1 to StrSize do
      begin
       adr^ := 'X';
       inc(adr);
      end;
     try
      //StrLen must not read past the end of the string into another page and cause an AV exception
      StrLenFunction(Str);
     except
      Result := False;
      ErrorTrapException(VALIDATENO, Str);
      raise;
     end;
    end;
  finally
   //Remove protection from the two protected pages
   Page := BasePage + 1*PageSize;
   VirtualProtect(Page, 1, OldFlags, @flags);
   Page := BasePage + 3*PageSize;
   VirtualProtect(Page, 1, OldFlags, @flags);
   //Release all 4 pages
   FreeMem(Pages);
  end;
end;

function TMainForm.Validate15: boolean;
var
 Pages, BasePage, Str : PChar;
 Page, adr, PageBorderAdr, StrStartAdr : PChar;
 flags, Oldflags: dword;
 StrSize, J : Integer;
const
 PageSize = 4*1024;//4 kB = 4096 Byte
 MAXSTRSIZE : Integer = 4094;//Leave 2 bytes for the #0
 VALIDATENO : Cardinal = 15;

begin;
  //Get 4 pages big memory block
  GetMem(Pages, 4*PageSize);
  //A page starts at an 4096 byte aligned address
  //Get the address of the first complete page we have allocated
  BasePage := pchar(Integer(Pages) and -PageSize);
  try
   Result := True;
   //Read and write protect page = BasePage + 1
   Page := BasePage + 1*PageSize;
   VirtualProtect(Page, 1, PAGE_NOACCESS, @Oldflags);
   //Read and write protect page = BasePage + 3
   Page := BasePage + 3*PageSize;
   VirtualProtect(Page, 1, PAGE_NOACCESS, @flags);
   //Get Page 2 which is located between the two protected pages
   Page := BasePage + 2*PageSize;
   for StrSize := 0 to MAXSTRSIZE do
    begin
     //Get the page boundary address
     PageBorderAdr := Page + PageSize-1;
     //Get the address StrSize bytes back from the page boundary + make room for two #0
     StrStartAdr := PageBorderAdr - StrSize -1 ;
     Str := StrStartAdr;
     adr := StrStartAdr;
     PageBorderAdr^ := #0;
     (PageBorderAdr-1)^ := #0;
     //Make a 'XX....' + #0#0 PChar rigth up to the pageborder
     for J := 1 to StrSize do
      begin
       adr^ := 'X';
       inc(adr);
      end;
     try
      //StrLen must not read past the end of the string into another page and cause an AV exception
      StrLenFunction(Str);
     except
      Result := False;
      ErrorTrapException(VALIDATENO, Str);
      raise;
     end;
    end;
  finally
   //Remove protection from the two protected pages
   Page := BasePage + 1*PageSize;
   VirtualProtect(Page, 1, OldFlags, @flags);
   Page := BasePage + 3*PageSize;
   VirtualProtect(Page, 1, OldFlags, @flags);
   //Release all 4 pages
   FreeMem(Pages);
  end;
end;

function TMainForm.Validate16 : Boolean;
var
 Pages, BasePage, Str : PChar;
 Page, adr, PageBorderAdr, StrStartAdr : PChar;
 flags, Oldflags: dword;
 StrSize, J : Integer;
const
 PageSize = 4*1024;//4 kB = 4096 Byte
 MAXSTRSIZE : Integer = 4093;//Leave 2 bytes for the #0
 VALIDATENO : Cardinal = 16;

begin;
  //Get 4 pages big memory block
  GetMem(Pages, 4*PageSize);
  //A page starts at an 4096 byte aligned address
  //Get the address of the first complete page we have allocated
  BasePage := pchar(Integer(Pages) and -PageSize);
  try
   Result := True;
   //Read and write protect page = BasePage + 1
   Page := BasePage + 1*PageSize;
   VirtualProtect(Page, 1, PAGE_NOACCESS, @Oldflags);
   //Read and write protect page = BasePage + 3
   Page := BasePage + 3*PageSize;
   VirtualProtect(Page, 1, PAGE_NOACCESS, @flags);
   //Get Page 2 which is located between the two protected pages
   Page := BasePage + 2*PageSize;
   for StrSize := 0 to MAXSTRSIZE do
    begin
     //Get the page boundary address
     PageBorderAdr := Page + PageSize-1;
     //Get the address StrSize bytes back from the page boundary + make room for three #0
     StrStartAdr := PageBorderAdr - StrSize - 2 ;
     Str := StrStartAdr;
     adr := StrStartAdr;
     PageBorderAdr^ := #0;
     (PageBorderAdr-1)^ := #0;
     (PageBorderAdr-2)^ := #0;
     //Make a 'XX....' + #0#0 PChar rigth up to the pageborder
     for J := 1 to StrSize do
      begin
       adr^ := 'X';
       inc(adr);
      end;
     try
      //StrLen must not read past the end of the string into another page and cause an AV exception
      StrLenFunction(Str);
     except
      Result := False;
      ErrorTrapException(VALIDATENO, Str);
      raise;
     end;
    end;
  finally
   //Remove protection from the two protected pages
   Page := BasePage + 1*PageSize;
   VirtualProtect(Page, 1, OldFlags, @flags);
   Page := BasePage + 3*PageSize;
   VirtualProtect(Page, 1, OldFlags, @flags);
   //Release all 4 pages
   FreeMem(Pages);
  end;
end;

function TMainForm.Validate17 : Boolean;
var
 Pages, BasePage, Str : PChar;
 Page, adr, PageBorderAdr, StrStartAdr, TerminatorAdr : PChar;
 flags, Oldflags: dword;
 StrSize, J, K : Integer;
const
 PageSize = 4*1024;//4 kB = 4096 Byte
 MAXSTRSIZE : Integer = 4095;//Leave 1 bytes for the #0
 VALIDATENO : Cardinal = 17;

begin;
  //Get 4 pages big memory block
  GetMem(Pages, 4*PageSize);
  //A page starts at an 4096 byte aligned address
  //Get the address of the first complete page we have allocated
  BasePage := pchar(Integer(Pages) and -PageSize);
  try
   Result := True;
   //Read and write protect page = BasePage + 1
   Page := BasePage + 1*PageSize;
   VirtualProtect(Page, 1, PAGE_NOACCESS, @Oldflags);
   //Read and write protect page = BasePage + 3
   Page := BasePage + 3*PageSize;
   VirtualProtect(Page, 1, PAGE_NOACCESS, @flags);
   //Get Page 2 which is located between the two protected pages
   Page := BasePage + 2*PageSize;
   for StrSize := 1 to MAXSTRSIZE do
    begin
     //Get the page boundary address
     PageBorderAdr := Page + PageSize-1;
     //Get the address StrSize bytes back from the page boundary
     StrStartAdr := PageBorderAdr - StrSize;
     Str := StrStartAdr;
     adr := StrStartAdr;
     //Make a 'XX....' + #0 PChar rigth up to the pageborder
     for J := 1 to StrSize do
      begin
       adr^ := 'X';
       inc(adr);
      end;
     TerminatorAdr := PageBorderAdr;
     //Always one terminator at the pageborder
     TerminatorAdr^ := #0;
     for K := 1 to StrSize do
      begin
       //Insert #0's
       Dec(TerminatorAdr);
       TerminatorAdr^ := #0;
       try
        //StrLen must not read past the end of the string into another page and cause an AV exception
        StrLenFunction(Str);
       except
        Result := False;
        ErrorTrapException(VALIDATENO, Str);
        raise;
       end;
      end;
    end;
  finally
   //Remove protection from the two protected pages
   Page := BasePage + 1*PageSize;
   VirtualProtect(Page, 1, OldFlags, @flags);
   Page := BasePage + 3*PageSize;
   VirtualProtect(Page, 1, OldFlags, @flags);
   //Release all 4 pages
   FreeMem(Pages);
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var T: Integer;
    CpuString : string;
begin
 ClearAllEditBoxes;
 ReportRichEdit.Clear;
 ReportRichEdit.Paragraph.TabCount := 4;
 ReportRichEdit.Paragraph.Tab[0] := 95;
 ReportRichEdit.Paragraph.Tab[1] := 125;
 ReportRichEdit.Paragraph.Tab[2] := 170;
 ReportRichEdit.Paragraph.Tab[3] := 225;
 FunctionSelectionRadioGroupClick(nil);
 if not QueryPerformanceFrequency(Frequency) then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(NoOfTicksArray, NOOFRERUNS);
 for T := 1 to Length(SubBench1TestArray) do
  SubBench1TestArray[T] := 'A';
 SubBench1TestArray[Length(SubBench1TestArray)] := #0;
 for T := 1 to Length(SubBench2TestArray) do
  SubBench2TestArray[T] := 'A';
 SubBench2TestArray[Length(SubBench2TestArray)] := #0;

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

procedure TMainForm.SaveButtonClick(Sender: TObject);
begin
 SaveDialog1.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName);
 SaveDialog1.FileName := FResultsFileName;
 if SaveDialog1.Execute then
  ReportRichEdit.Lines.SaveToFile(SaveDialog1.FileName);
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

procedure TMainForm.RunAllBenchmarksButtonClick(Sender: TObject);
var
 I1 : Integer;
 StartTime, RunTime : TDateTime;
begin
 RunAllBenchmarksButton.Caption := 'Running';
 StartTime := Time;
 Update;
 for I1 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 //for I1 := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I1;
   BenchmarkStrLen;
   BenchmarkTest;
   AlignmentTest;
   RunTime := Time - StartTime;
   RunTimeEdit.Text := TimeToStr(RunTime);
   if ReportRichEdit.Lines.Count > 1 then
    SortRichEdit;
   ReportRichEdit.SelStart := 0;
   ReportRichEdit.Perform(EM_ScrollCaret, 0, 0);
  end;
 RunAllBenchmarksButton.Caption := 'Run All';

 if FileExists(FBenchmarkFileName) then FResultList.LoadFromFile(FBenchmarkFileName);
 FResultList.Add(Format('[%s %s] Running "%s" benchmark version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FBenchmarkFileName);
end;

procedure TMainForm.FunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionSelectionRadioGroup.ItemIndex of
  0 : StrLenFunction := SysUtils.StrLen;
  1 : StrLenFunction := StrLen_DKC_Pas_6_a;
  2 : StrLenFunction := StrLen_DKC_Pas_6_b;
  3 : StrLenFunction := StrLen_DKC_Pas_6_c;
  4 : StrLenFunction := StrLen_DKC_Pas_6_d;
  5 : StrLenFunction := StrLen_DKC_IA32_1_a;
  6 : StrLenFunction := StrLen_DKC_IA32_1_b;
  7 : StrLenFunction := StrLen_DKC_IA32_1_c;
  8 : StrLenFunction := StrLen_DKC_IA32_1_d;
  9 : StrLenFunction := StrLen_DKC_IA32_2_a;
  10 : StrLenFunction := StrLen_DKC_IA32_2_b;
  11 : StrLenFunction := StrLen_DKC_IA32_2_c;
  12 : StrLenFunction := StrLen_DKC_IA32_2_d;
  13 : StrLenFunction := StrLen_DKC_IA32_3_a;
  14 : StrLenFunction := StrLen_DKC_IA32_3_b;
  15 : StrLenFunction := StrLen_DKC_IA32_3_c;
  16 : StrLenFunction := StrLen_DKC_IA32_3_d;
  17 : StrLenFunction := StrLen_DKC_IA32_4_a;
  18 : StrLenFunction := StrLen_DKC_IA32_4_b;
  19 : StrLenFunction := StrLen_DKC_IA32_4_c;
  20 : StrLenFunction := StrLen_DKC_IA32_4_d;
  21 : StrLenFunction := StrLen_DKC_IA32_5_a;
  22 : StrLenFunction := StrLen_DKC_IA32_5_b;
  23 : StrLenFunction := StrLen_DKC_IA32_5_c;
  24 : StrLenFunction := StrLen_DKC_IA32_5_d;
  25 : StrLenFunction := StrLen_DKC_IA32_6_a;
  26 : StrLenFunction := StrLen_DKC_IA32_6_b;
  27 : StrLenFunction := StrLen_DKC_IA32_6_c;
  28 : StrLenFunction := StrLen_DKC_IA32_6_d;
  29 : StrLenFunction := StrLen_DKC_IA32_7_a;
  30 : StrLenFunction := StrLen_DKC_IA32_7_b;
  31 : StrLenFunction := StrLen_DKC_IA32_7_c;
  32 : StrLenFunction := StrLen_DKC_IA32_7_d;
  33 : StrLenFunction := StrLen_DKC_IA32_8_a;
  34 : StrLenFunction := StrLen_DKC_IA32_8_b;
  35 : StrLenFunction := StrLen_DKC_IA32_8_c;
  36 : StrLenFunction := StrLen_DKC_IA32_8_d;
  37 : StrLenFunction := StrLen_DKC_IA32_9_a;
  38 : StrLenFunction := StrLen_DKC_IA32_9_b;
  39 : StrLenFunction := StrLen_DKC_IA32_9_c;
  40 : StrLenFunction := StrLen_DKC_IA32_9_d;
  41 : StrLenFunction := StrLen_DKC_IA32_10_a;
  42 : StrLenFunction := StrLen_DKC_IA32_10_b;
  43 : StrLenFunction := StrLen_DKC_IA32_10_c;
  44 : StrLenFunction := StrLen_DKC_IA32_10_d;
  45 : StrLenFunction := StrLen_DKC_IA32_18_a;
  46 : StrLenFunction := StrLen_DKC_IA32_18_b;
  47 : StrLenFunction := StrLen_DKC_IA32_18_c;
  48 : StrLenFunction := StrLen_DKC_IA32_18_d;
  49 : StrLenFunction := StrLen_DKC_MMX_8_a;
  50 : StrLenFunction := StrLen_DKC_MMX_8_b;
  51 : StrLenFunction := StrLen_DKC_MMX_8_c;
  52 : StrLenFunction := StrLen_DKC_MMX_8_d;
  53 : StrLenFunction := StrLen_DKC_MMX_9_a;
  54 : StrLenFunction := StrLen_DKC_MMX_9_b;
  55 : StrLenFunction := StrLen_DKC_MMX_9_c;
  56 : StrLenFunction := StrLen_DKC_MMX_9_d;
  57 : StrLenFunction := StrLen_DKC_SSE2_1_a;
  58 : StrLenFunction := StrLen_DKC_SSE2_1_b;
  59 : StrLenFunction := StrLen_DKC_SSE2_1_c;
  60 : StrLenFunction := StrLen_DKC_SSE2_1_d;
  61 : StrLenFunction := StrLen_DKC_SSE2_4_a;
  62 : StrLenFunction := StrLen_DKC_SSE2_4_b;
  63 : StrLenFunction := StrLen_DKC_SSE2_4_c;
  64 : StrLenFunction := StrLen_DKC_SSE2_4_d;
  65 : StrLenFunction := StrLen_DKC_SSE2_5_a;
  66 : StrLenFunction := StrLen_DKC_SSE2_5_b;
  67 : StrLenFunction := StrLen_DKC_SSE2_5_c;
  68 : StrLenFunction := StrLen_DKC_SSE2_5_d;
  69 : StrLenFunction := StrLen_JOH_PAS_1_a;
  70 : StrLenFunction := StrLen_JOH_PAS_1_b;
  71 : StrLenFunction := StrLen_JOH_PAS_1_c;
  72 : StrLenFunction := StrLen_JOH_PAS_1_d;
  73 : StrLenFunction := StrLen_JOH_PAS_3_a;
  74 : StrLenFunction := StrLen_JOH_PAS_3_b;
  75 : StrLenFunction := StrLen_JOH_PAS_3_c;
  76 : StrLenFunction := StrLen_JOH_PAS_3_d;
  77 : StrLenFunction := StrLen_JOH_IA32_1_a;
  78 : StrLenFunction := StrLen_JOH_IA32_1_b;
  79 : StrLenFunction := StrLen_JOH_IA32_1_c;
  80 : StrLenFunction := StrLen_JOH_IA32_1_d;
  81 : StrLenFunction := StrLen_JOH_IA32_2_a;
  82 : StrLenFunction := StrLen_JOH_IA32_2_b;
  83 : StrLenFunction := StrLen_JOH_IA32_2_c;
  84 : StrLenFunction := StrLen_JOH_IA32_2_d;
  85 : StrLenFunction := StrLen_JOH_IA32_7_a;
  86 : StrLenFunction := StrLen_JOH_IA32_7_b;
  87 : StrLenFunction := StrLen_JOH_IA32_7_c;
  88 : StrLenFunction := StrLen_JOH_IA32_7_d;
  89 : StrLenFunction := StrLen_JOH_SSE2_1_a;
  90 : StrLenFunction := StrLen_JOH_SSE2_1_b;
  91 : StrLenFunction := StrLen_JOH_SSE2_1_c;
  92 : StrLenFunction := StrLen_JOH_SSE2_1_d;
  93 : StrLenFunction := StrLen_LBG_PAS_1_a;
  94 : StrLenFunction := StrLen_LBG_PAS_1_b;
  95 : StrLenFunction := StrLen_LBG_PAS_1_c;
  96 : StrLenFunction := StrLen_LBG_PAS_1_d;
  97 : StrLenFunction := StrLen_LBG_IA32_1_a;
  98 : StrLenFunction := StrLen_LBG_IA32_1_b;
  99 : StrLenFunction := StrLen_LBG_IA32_1_c;
  100 : StrLenFunction := StrLen_LBG_IA32_1_d;
  101 : StrLenFunction := StrLen_LBG_IA32_2_a;
  102 : StrLenFunction := StrLen_LBG_IA32_2_b;
  103 : StrLenFunction := StrLen_LBG_IA32_2_c;
  104 : StrLenFunction := StrLen_LBG_IA32_2_d;
  105 : StrLenFunction := StrLen_LBG_IA32_3_a;
  106 : StrLenFunction := StrLen_LBG_IA32_3_b;
  107 : StrLenFunction := StrLen_LBG_IA32_3_c;
  108 : StrLenFunction := StrLen_LBG_IA32_3_d;
  109 : StrLenFunction := StrLen_LBG_IA32_4_a;
  110 : StrLenFunction := StrLen_LBG_IA32_4_b;
  111 : StrLenFunction := StrLen_LBG_IA32_4_c;
  112 : StrLenFunction := StrLen_LBG_IA32_4_d;
  113 : StrLenFunction := StrLen_DKC_IA32_19_a;
  114 : StrLenFunction := StrLen_DKC_IA32_19_b;
  115 : StrLenFunction := StrLen_DKC_IA32_19_c;
  116 : StrLenFunction := StrLen_DKC_IA32_19_d;
  117 : StrLenFunction := StrLen_PLR_IA32_1_a;
  118 : StrLenFunction := StrLen_PLR_IA32_1_b;
  119 : StrLenFunction := StrLen_PLR_IA32_1_c;
  120 : StrLenFunction := StrLen_PLR_IA32_1_d;
  121 : StrLenFunction := StrLen_PLR_IA32_2_a;
  122 : StrLenFunction := StrLen_PLR_IA32_2_b;
  123 : StrLenFunction := StrLen_PLR_IA32_2_c;
  124 : StrLenFunction := StrLen_PLR_IA32_2_d;
  125 : StrLenFunction := StrLen_PLR_IA32_3_a;
  126 : StrLenFunction := StrLen_PLR_IA32_3_b;
  127 : StrLenFunction := StrLen_PLR_IA32_3_c;
  128 : StrLenFunction := StrLen_PLR_IA32_3_d;
  129 : StrLenFunction := StrLen_JOH_SSE2_2_a;
  130 : StrLenFunction := StrLen_JOH_SSE2_2_b;
  131 : StrLenFunction := StrLen_JOH_SSE2_2_c;
  132 : StrLenFunction := StrLen_JOH_SSE2_2_d;
 else
  raise Exception.Create('Invalid function number');
 end;
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I : Integer;
 FunctionName, StrLenFunctionAddressString : AnsiString;
 StrLenFunctionAddress : Cardinal;
 StartTime, RunTime : TDateTime;

begin
 ValidateAllButton.Caption := 'Running';
 StartTime := Time;
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 //for I := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
   StrLenFunctionAddress := Integer(@StrLenFunction);
   StrLenFunctionAddressString := IntToHex(StrLenFunctionAddress, 8);
   try
    if Validate1 and
       Validate2 and
       Validate3 and
       Validate4 and
       Validate5 and
       Validate6 and
       Validate7 and
       Validate8 and
       Validate9 and
       Validate10 and
       Validate11 and
       Validate12 and
       Validate13 and
       Validate14 and
       Validate15 and
       Validate16 and
       Validate17 then
     ReportRichEdit.Lines.Add(FunctionName + #9 + StrLenFunctionAddressString[8] + #9 + 'Passed')
    else
     ReportRichEdit.Lines.Add(FunctionName + #9 + StrLenFunctionAddressString[8] + #9 + 'Failed');
    RunTime := Time - StartTime;
    RunTimeEdit.Text := TimeToStr(RunTime);
    Update;
   except
    FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
    StrLenFunctionAddress := Integer(@StrLenFunction);
    StrLenFunctionAddressString := IntToHex(StrLenFunctionAddress, 8);
    ReportRichEdit.Lines.Add(FunctionName + #9 + StrLenFunctionAddressString[8] + #9 + 'Failed');
    Update;
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

procedure TMainForm.PrintSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('StrLen Benchmark Results');
end;

procedure TMainForm.BenchTestButtonClick(Sender: TObject);
var
 I1, I2 : Cardinal;

begin
 BenchTestButton.Caption := 'Running';
 Update;
 for I1 := 1 to 2 do
  begin
   for I2 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
    begin
     FunctionSelectionRadioGroup.ItemIndex := I2;
     BenchmarkButtonClick(nil);
     Update;
    end;
   FunctionSelectionRadioGroup.ItemIndex := I1;
   BenchmarkButtonClick(nil);
   Update;
  end;
 BenchTestButton.Caption := 'Bench Test';
end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
end;

procedure TMainForm.AboutSpeedButtonClick(Sender: TObject);
begin
 AboutForm.ShowModal;
end;

procedure TMainForm.AlignCheckButtonClick(Sender: TObject);
var
 I, J, TabPos1, TabPos2, K, L, P, Q, T : Integer;
 FunctionName, FunctionName1, FunctionName2, FunctionAddressString, FunctionAlignString1, FunctionAlignString2, S1, S2 : AnsiString;
 FunctionAddress : Cardinal;
 AlignStringArray : array[1..4] of AnsiString;

begin
 AlignCheckEdit.Text := '';
 AlignCheckEdit.Color := clGreen;
 Update;
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
   FunctionAddress := Cardinal(@StrLenFunction);
   FunctionAddressString := IntToHex(FunctionAddress, 8);
   ReportRichEdit.Lines.Add(FunctionName
                           + #9 + FunctionAddressString[8]);
  end;
 for J := 0 to ReportRichEdit.Lines.Count-1 do
  begin
   for T := 1 to 4 do
    AlignStringArray[T] := '';
   S1 := ReportRichEdit.Lines.Strings[J];
   TabPos1 := CharPos(#9, S1);
   if CharPos('_', S1) <> 0 then
    FunctionName1 := Copy(S1, 1, TabPos1-3)
   else
    FunctionName1 := Copy(S1, 1, TabPos1-1);
   FunctionAlignString1 := Copy(S1, TabPos1+1, 1);
   L := 1;
   AlignStringArray[L] := FunctionAlignString1;
   for K := J+1 to ReportRichEdit.Lines.Count-1 do
    begin
     S2 := ReportRichEdit.Lines.Strings[K];
     TabPos2 := CharPos(#9, S2);
     if CharPos('_', S2) <> 0 then
      FunctionName2 := Copy(S2, 1, TabPos2-3)
     else
      FunctionName2 := Copy(S2, 1, TabPos2-1);
     FunctionAlignString2 := Copy(S2, TabPos2+1, 1);
     if FunctionName1 = FunctionName2 then
      begin
       Inc(L);
       AlignStringArray[L] := FunctionAlignString2;
      end;
    end;
   for P := 1 to 4 do
    for Q := P+1 to 4 do
     begin
      if (AlignStringArray[P] = AlignStringArray[Q]) and (AlignStringArray[P] <> '') then
       begin
        AlignCheckEdit.Text := FunctionName1;
        AlignCheckEdit.Color := clRed;
        Exit;
       end;
     end;
  end;
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
    RunAllBenchmarksButton.Click;
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
