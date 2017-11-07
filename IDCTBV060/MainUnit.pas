unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, IDCTREFUnit;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'IDCT';

type

 TIDCTFunction = procedure (const Coef: TsdCoefBlock; const Quant : TsdIntArray64; out Sample: TsdSampleBlock; var  Wrksp: TsdIntArray64);

 TFunctionEntry = record
  FunctionName : AnsiString;
  FunctionPointer : TIDCTFunction;
 end;

 TTestData = record
  Coef : TsdCoefBlock;
  Quant : TsdIntArray64;
 end;

 TTestDataArray = array of TTestData;

  TMainForm = class(TForm)
    CloseBitBtn: TBitBtn;
    ReportRichEdit: TRichEdit;
    SaveDialog1: TSaveDialog;
    BenchmarkAllButton: TButton;
    FunctionSelectionRadioGroup: TRadioGroup;
    Panel1: TPanel;
    PrintSpeedButton: TSpeedButton;
    SaveAsSpeedButton: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ValidateAllButton: TButton;
    BenchmarkButton: TButton;
    ResultEdit: TEdit;
    ValidateButton: TButton;
    StatusBar1: TStatusBar;
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
    AboutSpeedButton: TSpeedButton;
    CleanButton: TButton;
    BitBtn1: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CleanButtonClick(Sender: TObject);
    procedure FunctionSelectionRadioGroupClick(Sender: TObject);
    procedure RegisterFunction(FunctionName : AnsiString; FunctionPointer : TIDCTFunction);
    procedure AboutSpeedButtonClick(Sender: TObject);
    procedure AlignCheckButtonClick(Sender: TObject);
    procedure BenchmarkButtonClick(Sender: TObject);
    procedure ValidateButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure BenchmarkAllButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure PrintSpeedButtonClick(Sender: TObject);
    procedure BenchTestButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
   FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
   FResultList: TStringList;
   Frequency : Int64;
   NoOfTicksArray : array of Int64;
   function LoadTestData(TESTDATAFILENAME : AnsiString) : TTestDataArray;
   function ValidationResultsPresent : Boolean;
   procedure ReadIniFile(FileName : AnsiString);
   procedure WriteIniFile(FileName : AnsiString);
   procedure FillFunctionSelectionRadioGroup;
   function SubBenchmark1 : Double;
   procedure BenchmarkIDCT;
   function Validate : Boolean;
   function Validate1 : Boolean;
   function Validate2 : Boolean;
   function Validate3 : Boolean;
   function Validate4 : Boolean;
   function Validate5 : Boolean;
   function Validate6 : Boolean;
   function Validate7 : Boolean;
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
 FastcodeCPUID, SystemInfoUnit, IniFiles, StrUtils, Math, AboutUnit, SysConst;

var
// SubBenchmark1StringArray : array of String;
// SubBenchmark2StringArray : array of String;
 IDCTFunction : TIDCTFunction;
 FunctionArray : array of TFunctionEntry;
 BenchmarkDataSet, ValidateDataSet : TTestDataArray;

const
 NOOFRERUNS : Cardinal = 2;
 FIRSTRESULTTOUSE : Cardinal = 1;
 MAXNOOFRUNSSUB1 : Cardinal = 100;
 SUBBENCH1SCALE : Double = 300;
 INIFILENAME : AnsiString = 'IDCTBV.Ini';
 BENCHTESTNOOFRUNS : Integer = 10;
 SAMPLELIMIT : Byte = 1;//How big a deviation from the reference can we allow.
 VALIDATEDATAFILENAME : AnsiString = 'IDCTValidateData.txt'; //In application dir
 BENCHMARKDATAFILENAME : AnsiString = 'IDCTBenchmarkData.txt'; //In application dir
 MAXCOEFFICIENTBITS : Integer = 11;    
 MAXQUANTIZATIONBITS : Integer = 17;
 MAXCOEFFICIENTBITSVALIDATE4 : Integer = 8;    //!!!!!!!!!!!!!!!!!
 MAXQUANTIZATIONBITSVALIDATE4 : Integer = 9;   //!!!!!!!!!!!!!!!!!
 MAXCOEFFICIENTBITSVALIDATE5 : Integer = 9;    //!!!!!!!!!!!!!!!!!
 MAXQUANTIZATIONBITSVALIDATE5 : Integer = 8;   //!!!!!!!!!!!!!!!!!

function CharPosEy(const SearchCharacter : Char;
                   const SourceString : AnsiString;
                   Occurrence : Integer = 1;
                   StartPos : Integer = 1) : Integer;
var
 Char1 : Char;
 Index, SourceStringLength : Integer;
label
 Done;

begin
 if SourceString <> '' then
  begin
   SourceStringLength := PInteger(Integer(SourceString)-4)^;
   if ((SourceStringLength > 0) and (Occurrence > 0) and
       (StartPos > 0) and (StartPos <= SourceStringLength)) then
    begin
     Result := 0;
     Index := StartPos - 1;
     repeat
      Char1 := SourceString[Index+1];
      if Char1 = SearchCharacter then
       begin
        Dec(Occurrence);
        if Occurrence = 0 then
         goto Done;
       end;
      Inc(Index);
      if (Index >= SourceStringLength) then
       Exit;
      Char1 := SourceString[Index+1];
      if Char1 = SearchCharacter then
       begin
        Dec(Occurrence);
        if Occurrence = 0 then
         goto Done;
       end;
      Inc(Index);
     until(Index >= SourceStringLength);
     Exit;
    end
   else
    Index := -1;
  end
 else
  Index := -1;
 Done :
  Result := Index+1;
end;

function GetAuthorName(FunctionName : AnsiString) : AnsiString;
var
 Pos1, Pos2 : Integer;

begin
 Pos1 := CharPosEy('_', FunctionName, 1);
 Pos2 := CharPosEy('_', FunctionName, 2);
 Result := Copy(FunctionName,Pos1+1, Pos2-Pos1-1);
end;

function GetFunctionType(FunctionName : AnsiString) : AnsiString;
var
 Pos1, Pos2 : Integer;

begin
 Pos1 := CharPosEy('_', FunctionName, 2);
 Pos2 := CharPosEy('_', FunctionName, 3);
 Result := Copy(FunctionName,Pos1+1, Pos2-Pos1-1);
end;

function GetFunctionNumber(FunctionName : AnsiString) : Integer;
var
 Pos1, Pos2 : Integer;

begin
 Pos1 := CharPosEy('_', FunctionName, 3);
 Pos2 := CharPosEy('_', FunctionName, 4);
 Result := StrToInt(Copy(FunctionName,Pos1+1, Pos2-Pos1-1));
end;

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

procedure TMainForm.RegisterFunction(FunctionName : AnsiString; FunctionPointer : TIDCTFunction);
var
 Size, NewSize : Integer;

begin
 Size := Length(FunctionArray);
 NewSize := Size + 1;
 SetLength(FunctionArray, NewSize);
 FunctionArray[NewSize-1].FunctionName := FunctionName;
 FunctionArray[NewSize-1].FunctionPointer := FunctionPointer;
end;

procedure SwapEntries(Index1, Index2 : Integer);
var
 TempEntry : TFunctionEntry;

begin
 TempEntry := FunctionArray[Index1];
 FunctionArray[Index1] := FunctionArray[Index2];
 FunctionArray[Index2] := TempEntry;
end;

procedure SortFunctionArray;
var
 I1, FunctionNumber1, FunctionNumber2: Integer;
 AuthorName1, AuthorName2, FunctionType1, FunctionType2 : AnsiString;
 Swapped : Boolean;

begin
 //Sort according to function number
 repeat
  Swapped := False;
  for I1 := 0 to Length(FunctionArray)-2 do
   begin
    FunctionNumber1 := GetFunctionNumber(FunctionArray[I1].FunctionName);
    FunctionNumber2 := GetFunctionNumber(FunctionArray[I1+1].FunctionName);
    if FunctionNumber2 < FunctionNumber1 then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
   end;
 until(not Swapped);
 //Sort according to instructionset
 repeat
  Swapped := False;
  for I1 := 0 to Length(FunctionArray)-2 do
   begin
    FunctionType1 := GetFunctionType(FunctionArray[I1].FunctionName);
    FunctionType1 := UpperCase(FunctionType1);
    FunctionType2 := GetFunctionType(FunctionArray[I1+1].FunctionName);
    FunctionType2 := UpperCase(FunctionType2);
    //Clumsy programming just to get started
    if (FunctionType2 = 'PAS') and (FunctionType1 = 'IA32') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'PAS') and (FunctionType1 = 'MMX') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'PAS') and (FunctionType1 = 'SSE') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'PAS') and (FunctionType1 = 'SSE2') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'PAS') and (FunctionType1 = 'SSE3') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'IA32') and (FunctionType1 = 'MMX') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'IA32') and (FunctionType1 = 'SSE') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'IA32') and (FunctionType1 = 'SSE2') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'IA32') and (FunctionType1 = 'SSE3') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'MMX') and (FunctionType1 = 'SSE') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'MMX') and (FunctionType1 = 'SSE2') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'MMX') and (FunctionType1 = 'SSE3') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'SSE') and (FunctionType1 = 'SSE2') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'SSE') and (FunctionType1 = 'SSE3') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
    if (FunctionType2 = 'SSE2') and (FunctionType1 = 'SSE3') then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
   end;
 until(not Swapped);
 //Sort according to Author name
 repeat
  Swapped := False;
  for I1 := 0 to Length(FunctionArray)-2 do
   begin
    AuthorName1 := GetAuthorName(FunctionArray[I1].FunctionName);
    AuthorName2 := GetAuthorName(FunctionArray[I1+1].FunctionName);
    if AuthorName2 < AuthorName1 then
     begin
      SwapEntries(I1, I1+1);
      Swapped := True;
     end;
   end;
 until(not Swapped);
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
 S1, S2, BenchString1, BenchString2, FunctionName1, FunctionName2 : AnsiString;
 Bench1, Bench2, AverageBench, Spread, DeltaBench, MaxSpread : Double;
 C1, C2 : Char;
 Tab1Pos1, Tab1Pos2 : Cardinal;

begin
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
         SpreadBench1Edit.Text := BenchString1;
         SpreadBench2Edit.Text := BenchString2;
         MaxSpread := Spread;
         MaxSpreadBenchPercentageEdit.Text := FloatToStrF(MaxSpread, ffFixed, 9, 1);
         FunctionNameEdit.Text := FunctionName1;
         MaxSpreadBenchPercentageEdit.Color := clGreen;
         if MaxSpread > 1 then
          MaxSpreadBenchPercentageEdit.Color := clYellow;
         if MaxSpread > 3 then
          MaxSpreadBenchPercentageEdit.Color := clRed;
         Update;
        end;
      end;
    end;
  end;
end;

//Removes multiple results from same function. Preserves the fastest result

procedure TMainForm.CleanButtonClick(Sender: TObject);
begin
 CleanResultsRichEdit;
 BenchmarkTest;
end;

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

procedure TMainForm.FillFunctionSelectionRadioGroup;
var
 I : Integer;

begin
 for I := 1 to Length(FunctionArray) do
  FunctionSelectionRadioGroup.Items.Add(FunctionArray[I-1].FunctionName);
 FunctionSelectionRadioGroup.ItemIndex := 0;
end;

procedure ErrorTrap(ValidateNo : Integer; Coef: TsdCoefBlock; Quant: TsdIntArray64; Sample: TsdSampleBlock; Wrksp: TsdIntArray64);
//var
// I : Integer;

begin
// for I := 0 to Length(Wrksp) - 1 do
//  Wrksp[I] := 0;
// //IDCTFunction(Coef, Quant, Sample, Wrksp);//Enable for debugging
 if MainForm.ShowErrorDialogCheckBox.Checked then
  Application.MessageBox(PChar('Function failed in Validate' + IntToStr(ValidateNo)), 'Error');
end;

procedure TMainForm.BenchmarkIDCT;
var
 Bench, SubBench1 : Double;
 FunctionName, IDCTFunctionAddressString : AnsiString;
 IDCTFunctionAddress : Cardinal;

begin
 try
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  IDCTFunctionAddress := Integer(@IDCTFunction);
  IDCTFunctionAddressString := IntToHex(IDCTFunctionAddress, 8);
  Update;
  SubBench1 := SubBenchmark1;
  Bench := SubBench1;
  ReportRichEdit.Lines.Add(FunctionName  + #9 +
                           IDCTFunctionAddressString[8] + #9 +
                           FloatToStrF(Bench, ffFixed, 9, 0));
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName  + #9 +
                                     'Failed' + #9 +
                                     '9999');
 end;
end;

function TMainForm.SubBenchmark1 : Double;
var
 J, I5 : Cardinal;
 DataSetNo : Integer;
 RunNo : Cardinal;
 RunTimeSec : Double;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 Coef : TsdCoefBlock;
 Sample: TsdSampleBlock;
 Quant : TsdIntArray64;
 Wrksp : TsdIntArray64;

begin
 for J := 1 to NOOFRERUNS do
  begin
   if QueryPerformanceCounter(lpPerformanceCount) then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for RunNo := 1 to MAXNOOFRUNSSUB1 do
    for DataSetNo := 0 to Length(BenchmarkDataSet)-1 do
     begin
      Coef := BenchmarkDataSet[DataSetNo].Coef;
      Quant := BenchmarkDataSet[DataSetNo].Quant;
      IDCTFunction(Coef, Quant, Sample, Wrksp);
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
 ResultEdit.Text := IntToStr(Sample[1]);
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[FIRSTRESULTTOUSE-1];
 for I5 := FIRSTRESULTTOUSE to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I5] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I5];
  end;
 RunTimeSec := MinNoOfTicks / Frequency;
 Result := Round(RunTimeSec*SUBBENCH1SCALE);
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
begin
 BenchmarkButton.Caption := 'Running';
 if ValidationResultsPresent then
  ReportRichEdit.Clear;
 BenchmarkIDCT;
 if ReportRichEdit.Lines.Count > 1 then
  SortRichEdit;
 BenchmarkTest;
 AlignmentTest;
 BenchmarkButton.Caption := 'Benchmark';
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
var
 FunctionName, IDCTFunctionAddressString : AnsiString;
 IDCTFunctionAddress : Cardinal;

begin
 try
  ValidateButton.Caption := 'Running';
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  IDCTFunctionAddress := Integer(@IDCTFunction);
  IDCTFunctionAddressString := IntToHex(IDCTFunctionAddress, 8);
  if Validate then
   ReportRichEdit.Lines.Add(FunctionName + #9 + IDCTFunctionAddressString[8] + #9 + 'Passed')
  else
   ReportRichEdit.Lines.Add(FunctionName + #9 + IDCTFunctionAddressString[8] + #9 + 'Failed');
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + IDCTFunctionAddressString[8] + #9 + 'Failed');
 end;
 StatusBar1.SimpleText := 'Validate Completed';
 ValidateButton.Caption := 'Validate';
end;

//One simple testcase

function TMainForm.Validate1 : Boolean;
var
 CoefRef, Coef : TsdCoefBlock;
 SampleRef, Sample: TsdSampleBlock;
 QuantRef, Quant : TsdIntArray64;
 WrkspRef, Wrksp : TsdIntArray64;
 I1 : SmallInt;
 I2 : Byte;
 I3, I : Integer;
const
 VALIDATENO : Cardinal = 1;

begin
 for I1 := 0 to Length(Coef)-1 do
  begin
   CoefRef[I1] := I1;
   Coef[I1] := I1;
  end;
 for I3 := 0 to Length(QuantRef)-1 do
  begin
   QuantRef[I3] := I3;
   Quant[I3] := I3;
  end;
 Result := True;
 for I := 0 to Length(WrkspRef) - 1 do
  WrkspRef[I] := 0;
 for I := 0 to Length(Wrksp) - 1 do
  Wrksp[I] := 0;   
 InverseDCT_Ref_Pas_1_a(Coef, Quant, SampleRef, WrkspRef);
 try
  IDCTFunction(Coef, Quant, Sample, Wrksp);
 except
  //Function must not raise exception
  ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
  Result := False;
  Exit;
 end;
 //Functions must not change Coef
 for I1 := 0 to Length(Coef)-1 do
  begin
   if CoefRef[I1] <> Coef[I1] then
    begin
     ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
     Result := False;
     Exit;
    end;
  end;
 //Functions must not change Quant
 for I3 := 0 to Length(Sample)-1 do
  begin
   if QuantRef[I3] <> Quant[I3] then
    begin
     ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
     Result := False;
     Exit;
    end;
  end;
 //Functions must produce correct Sample output values
 for I2 := 0 to Length(SampleRef)-1 do
  begin
   if Abs(SampleRef[I2] - Sample[I2]) > SAMPLELIMIT then
    begin
     ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
     Result := False;
     Exit;
    end;
  end;
end;

//Validates that functions handle all datasets in ValidateDataSet without chaging input values or rasing exceptions

function TMainForm.Validate2 : Boolean;
var
 CoefRef, Coef : TsdCoefBlock;
 Sample: TsdSampleBlock;
 QuantRef, Quant : TsdIntArray64;
 Wrksp : TsdIntArray64;
 I1 : SmallInt;
 I3 : Byte;
 DataSetNo, I : Integer;
const
 VALIDATENO : Cardinal = 2;

begin
 Result := True;
 for DataSetNo := 0 to Length(ValidateDataSet)-1 do
  begin
   Coef := ValidateDataSet[DataSetNo].Coef;
   CoefRef := ValidateDataSet[DataSetNo].Coef;
   Quant := ValidateDataSet[DataSetNo].Quant;
   QuantRef := ValidateDataSet[DataSetNo].Quant;
   for I := 0 to Length(Wrksp) - 1 do
    Wrksp[I] := 0;
   try
    IDCTFunction(Coef, Quant, Sample, Wrksp);
   except
    //Function must not raise exception
    ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
    Result := False;
    Exit;
   end;
   //Functions must not change Coef
   for I1 := 0 to Length(CoefRef)-1 do
    begin
     if CoefRef[I1] <> Coef[I1] then
      begin
       ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
       Result := False;
       Exit;
      end;
    end;
   //Functions must not change Quant
   for I3 := 0 to Length(QuantRef)-1 do
    begin
     if QuantRef[I3] <> Quant[I3] then
      begin
       ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
       Result := False;
       Exit;
      end;
    end;
  end;
end;

//Validates that output is correct for all datasets in ValidateDataSet

function TMainForm.Validate3 : Boolean;
var
 CoefRef, Coef : TsdCoefBlock;
 Sample, SampleRef : TsdSampleBlock;
 QuantRef, Quant : TsdIntArray64;
 Wrksp, WrkspRef : TsdIntArray64;
 DataSetNo, SampleNo, DataSetNoMax, I : Integer;
const
 VALIDATENO : Cardinal = 3;

begin
 Result := True;
 DataSetNoMax := Length(ValidateDataSet)-1;
 for DataSetNo := 0 to DataSetNoMax do
  begin
   Coef := ValidateDataSet[DataSetNo].Coef;
   CoefRef := ValidateDataSet[DataSetNo].Coef;
   Quant := ValidateDataSet[DataSetNo].Quant;
   QuantRef := ValidateDataSet[DataSetNo].Quant;
   for I := 0 to Length(WrkspRef) - 1 do
    WrkspRef[I] := 0;
   for I := 0 to Length(Wrksp) - 1 do
    Wrksp[I] := 0;
   InverseDCT_Ref_Pas_1_a(CoefRef, QuantRef, SampleRef, WrkspRef);
   try
    IDCTFunction(Coef, Quant, Sample, Wrksp);
   except
    //Function must not raise exception
    ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
    Result := False;
    Exit;
   end;
   //Ouput must match reference within a limit
   for SampleNo := 0 to Length(SampleRef)-1 do
    begin
     if Abs(SampleRef[SampleNo] - Sample[SampleNo]) > SAMPLELIMIT then
      begin
       ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
       Result := False;
       Exit;
      end;
    end;
  end;
end;

function TMainForm.Validate4 : Boolean;
var
 CoefRef, Coef : TsdCoefBlock;
 Sample: TsdSampleBlock;
 QuantRef, Quant : TsdIntArray64;
 Wrksp : TsdIntArray64;
 I1, J1 : SmallInt;
 I2 : Byte;
 I3 : Byte;
 J2 : Integer;
const
 VALIDATENO : Cardinal = 4;

begin
 Result := True;
 for I1 := 0 to Length(CoefRef)-1 do
  begin
   J1 := Random(Round(Power(2,MAXCOEFFICIENTBITSVALIDATE4)));
   CoefRef[I1] := J1;
   Coef[I1] := J1;
  end;
 for I2 := 0 to Length(QuantRef)-1 do
  begin
   J2 := Random(Round(Power(2,MAXQUANTIZATIONBITSVALIDATE4)));
   QuantRef[I2] := J2;
   Quant[I2] := J2;
  end;
 for I3 := 0 to Length(Wrksp)-1 do
  begin
   Wrksp[I3] := 0;
  end;            
 try
  IDCTFunction(Coef, Quant, Sample, Wrksp);
 except
  //Function must not raise exception
  ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
  Result := False;
  Exit;
 end;
 //Functions must not change Coef
 for I1 := 0 to Length(Coef)-1 do
  begin
   if CoefRef[I1] <> Coef[I1] then
    begin
     ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
     Result := False;
     Exit;
    end;
  end;
 //Functions must not change Quant
 for I3 := 0 to Length(Sample)-1 do
  begin
   if QuantRef[I3] <> Quant[I3] then
    begin
     ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
     Result := False;
     Exit;
    end;
  end;
end;

function TMainForm.Validate5 : Boolean;
var
 Coef : TsdCoefBlock;
 SampleRef, Sample: TsdSampleBlock;
 Quant : TsdIntArray64;
 WrkspRef, Wrksp : TsdIntArray64;
 I1, J1 : SmallInt;
 I2 : Byte;
 J2 : Integer;
 I5, I : Integer;
const
 VALIDATENO : Cardinal = 5;

begin
 Result := True;
 for I1 := 0 to Length(Coef)-1 do
  begin
   J1 := Random(Round(Power(2,MAXCOEFFICIENTBITSVALIDATE5)));
   Coef[I1] := J1;
  end;
 for I2 := 0 to Length(Quant)-1 do
  begin
   J2 := Random(Round(Power(2,MAXQUANTIZATIONBITSVALIDATE5)));
   Quant[I2] := J2;
  end;
 for I := 0 to Length(WrkspRef) - 1 do
  WrkspRef[I] := 0;
 for I := 0 to Length(Wrksp) - 1 do
  Wrksp[I] := 0;
 InverseDCT_Ref_Pas_1_a(Coef, Quant, SampleRef, WrkspRef);
 try
  IDCTFunction(Coef, Quant, Sample, Wrksp);
 except
  //Function must not raise exception
  ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
  Result := False;
  Exit;
 end;
 //Functions must produce correct Sample output values
 for I5 := 0 to Length(Sample)-1 do
  begin
   if Abs(SampleRef[I5] - Sample[I5]) > SAMPLELIMIT then
    begin
     ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
     Result := False;
     Exit;
    end;
  end;
end;

 //Validates that functions handle all datasets in BenchmarkDataSet without chaging input values or rasing exceptions

function TMainForm.Validate6 : Boolean;
var
 CoefRef, Coef : TsdCoefBlock;
 Sample: TsdSampleBlock;
 QuantRef, Quant : TsdIntArray64;
 Wrksp : TsdIntArray64;
 I1 : SmallInt;
 I3 : Byte;
 DataSetNo, I : Integer;
const
 VALIDATENO : Cardinal = 2;

begin
 Result := True;
 for DataSetNo := 0 to Length(BenchmarkDataSet)-1 do
  begin
   Coef := BenchmarkDataSet[DataSetNo].Coef;
   CoefRef := BenchmarkDataSet[DataSetNo].Coef;
   Quant := BenchmarkDataSet[DataSetNo].Quant;
   QuantRef := BenchmarkDataSet[DataSetNo].Quant;
   for I := 0 to Length(Wrksp) - 1 do
    Wrksp[I] := 0;
   try
    IDCTFunction(Coef, Quant, Sample, Wrksp);
   except
    //Function must not raise exception
    ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
    Result := False;
    Exit;
   end;
   //Functions must not change Coef
   for I1 := 0 to Length(CoefRef)-1 do
    begin
     if CoefRef[I1] <> Coef[I1] then
      begin
       ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
       Result := False;
       Exit;
      end;
    end;
   //Functions must not change Quant
   for I3 := 0 to Length(QuantRef)-1 do
    begin
     if QuantRef[I3] <> Quant[I3] then
      begin
       ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
       Result := False;
       Exit;
      end;
    end;
  end;
end;

//Validates that output is correct for all datasets in BenchmarkDataSet

function TMainForm.Validate7 : Boolean;
var
 CoefRef, Coef : TsdCoefBlock;
 Sample, SampleRef : TsdSampleBlock;
 QuantRef, Quant : TsdIntArray64;
 Wrksp, WrkspRef : TsdIntArray64;
 DataSetNo, SampleNo, DataSetNoMax, I : Integer;
const
 VALIDATENO : Cardinal = 3;

begin
 Result := True;
 DataSetNoMax := Length(BenchmarkDataSet)-1;
 for DataSetNo := 0 to DataSetNoMax do
  begin
   Coef := BenchmarkDataSet[DataSetNo].Coef;
   CoefRef := BenchmarkDataSet[DataSetNo].Coef;
   Quant := BenchmarkDataSet[DataSetNo].Quant;
   QuantRef := BenchmarkDataSet[DataSetNo].Quant;
   for I := 0 to Length(WrkspRef) - 1 do
    WrkspRef[I] := 0;
   for I := 0 to Length(Wrksp) - 1 do
    Wrksp[I] := 0;
   InverseDCT_Ref_Pas_1_a(CoefRef, QuantRef, SampleRef, WrkspRef);
   try
    IDCTFunction(Coef, Quant, Sample, Wrksp);
   except
    //Function must not raise exception
    ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
    Result := False;
    Exit;
   end;
   //Ouput must match reference within a limit
   for SampleNo := 0 to Length(SampleRef)-1 do
    begin
     if Abs(SampleRef[SampleNo] - Sample[SampleNo]) > SAMPLELIMIT then
      begin
       ErrorTrap(VALIDATENO, Coef, Quant, Sample, Wrksp);
       Result := False;
       Exit;
      end;
    end;
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 WriteIniFile(INIFILENAME);
 FResultList.Free;
end;

{Disables the window ghosting feature for the calling graphical user interface
 (GUI) process. Window ghosting is a Windows Manager feature that lets the user
 minimize, move, or close the main window of an application that is not
 responding. (This "feature" causes problems with form z-order and also
 modal forms not showing as modal after long periods of non-responsiveness)}
procedure DisableProcessWindowsGhosting;
var
  DisableProcessWindowsGhostingProc: procedure;
begin
  DisableProcessWindowsGhostingProc := GetProcAddress(
    GetModuleHandle('user32.dll'),
    'DisableProcessWindowsGhosting');
  if Assigned(DisableProcessWindowsGhostingProc) then
    DisableProcessWindowsGhostingProc;
end;

function TMainForm.LoadTestData(TestDataFileName : AnsiString) : TTestDataArray;
var
 IDCTTestData : TStringList;
 IDCTTestDataFileName, Line, S, CoefficientString, QuantizationString : AnsiString;
 NoOfDataSets, DataSetNo, LineNo1, LineNo2, I, CoeffNo, K1, K2, QuantNo, Quantization : Integer;
 Coef : TsdCoefBlock;
 Coefficient : SmallInt;
 Quant : TsdIntArray64;

begin
 IDCTTestData := TStringList.Create;
 IDCTTestDataFileName := ExtractFileDir(Application.ExeName) + '\' + TESTDATAFILENAME;
 IDCTTestData.LoadFromFile(IDCTTestDataFileName);
 NoOfDataSets := IDCTTestData.Count div 2;
 SetLength(Result, NoOfDataSets);
 for DataSetNo := 0 to NoOfDataSets-1 do
  begin
   LineNo1 := DataSetNo * 2;
   LineNo2 := DataSetNo * 2 + 1;
   Line := IDCTTestData[LineNo1];
   I := CharPos(':', Line);
   S := Copy(Line, 1, I);
   if S = 'Coefficients:' then
    begin
     Line := StringReplace(Line, 'Coefficients: ', ',', []);
     for CoeffNo := 1 to Length(Coef) do
      begin
       K1 := CharPosEy(',',Line, CoeffNo);
       K2 := CharPosEy(',',Line, CoeffNo+1);
       if (K1 = 0) or (K2 = 0) then
        raise Exception.Create('Not enough coefficients in file');
       CoefficientString := Copy(Line,K1+1,K2-K1-1);
       Coefficient := StrToInt(CoefficientString);
       if Coefficient > Power(2, MAXCOEFFICIENTBITS) then
        raise Exception.Create('Coefficient= ' + CoefficientString + '. Coefficients can be no more than ' + IntToStr(MAXCOEFFICIENTBITS) + ' bits in JPEG');
       Coef[CoeffNo-1] := Coefficient;
      end;
    end
   else
    raise Exception.Create('IDCTDataFile: ' + TestDataFileName + ' is corrupt at line: ' + IntToStr(LineNo1)  + ' ' + Line);
   Line := IDCTTestData[LineNo2];
   I := CharPos(':', Line);
   S := Copy(Line, 1, I);
   if S = 'Quantizations:' then
    begin
     Line := StringReplace(Line, 'Quantizations: ', ',', []);
     for QuantNo := 1 to Length(Quant) do
      begin
       K1 := CharPosEy(',',Line, QuantNo);
       K2 := CharPosEy(',',Line, QuantNo+1);
       if (K1 = 0) or (K2 = 0) then
        raise Exception.Create('Not enough Quantizations in file');
       QuantizationString := Copy(Line,K1+1,K2-K1-1);
       Quantization := StrToInt(QuantizationString);
       if Quantization > Power(2, MAXQUANTIZATIONBITS) then
        raise Exception.Create('Quantization= ' + QuantizationString + ' Quantizations can be no more than 8 bit in JPEG + a 9 bit premultiply');
       Quant[QuantNo-1] := Quantization;
      end;
    end
   else
    raise Exception.Create('IDCTDataFile: ' + TestDataFileName + ' is corrupt at Line: ' + IntToStr(LineNo2) + ' ' + Line);
   Result[DataSetNo].Coef := Coef;
   Result[DataSetNo].Quant := Quant;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
 CpuString : string;

begin
 ClearAllEditBoxes;
 ReportRichEdit.Clear;
 ReportRichEdit.Paragraph.TabCount := 2;
 ReportRichEdit.Paragraph.Tab[0] := 130;
 ReportRichEdit.Paragraph.Tab[1] := 180;
 if not QueryPerformanceFrequency(Frequency) then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(NoOfTicksArray, NOOFRERUNS);
 SortFunctionArray;
 FillFunctionSelectionRadioGroup;
 ReadIniFile(INIFILENAME);
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
  PostMessage(Handle, WM_POSTPROCESSING, 0, 0);
 DisableProcessWindowsGhosting;
 BenchmarkDataSet := LoadTestData(BENCHMARKDATAFILENAME);
 ValidateDataSet := LoadTestData(VALIDATEDATAFILENAME);
end;            

procedure TMainForm.FunctionSelectionRadioGroupClick(Sender: TObject);
var
 FunctionPointer : TIDCTFunction;
begin
 FunctionPointer := FunctionArray[FunctionSelectionRadioGroup.ItemIndex].FunctionPointer;
 IDCTFunction := FunctionPointer;
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

function TMainForm.ValidationResultsPresent : Boolean;
var
 LineNo : Integer;
 S1 : AnsiString;
begin
 Result := False;
 for LineNo := 0 to ReportRichEdit.Lines.Count-1 do
  begin
   S1 := ReportRichEdit.Lines[LineNo];
   if (Pos('Passed', S1) <> 0) or (Pos('Failed', S1) <> 0) then
    begin
     Result := True;
     Exit;
    end;
  end;
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I1 : Integer;

begin
 BenchmarkAllButton.Caption := 'Running';
 if Sender <> nil then//Thread priority has been set if bench test - do not reset
  if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_HIGHEST) = False then
   raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_HIGHEST failed');
 if ValidationResultsPresent then
  ReportRichEdit.Clear;
 Update;
 for I1 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 //for I1 := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I1;
   BenchmarkIDCT;
   BenchmarkTest;
   AlignmentTest;
   if ReportRichEdit.Lines.Count > 1 then
    SortRichEdit;
   ReportRichEdit.SelStart := 0;
   ReportRichEdit.Perform(EM_ScrollCaret, 0, 0);
  end;
 BenchmarkAllButton.Caption := 'Benchmark All';
 if Sender <> nil then //Do not log results when doing benchmark test
  begin
   if FileExists(FBenchmarkFileName) then
    FResultList.LoadFromFile(FBenchmarkFileName);
   FResultList.Add(Format('[%s %s] Running "%s" benchmark version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
   FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
   FResultList.AddStrings(ReportRichEdit.Lines);
   FResultList.Add('');
   FResultList.SaveToFile(FBenchmarkFileName);
  end;
end;

function TMainForm.Validate : Boolean;
begin
 Result := Validate1 and
           Validate2 and
           Validate3 and
           Validate4 and
           Validate5 and
           Validate6 and
           Validate7;
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I : Integer;
 FunctionName, IDCTFunctionAddressString : AnsiString;
 IDCTFunctionAddress : Cardinal;

begin
 ValidateAllButton.Caption := 'Running';
 if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_IDLE) = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_IDLE failed');
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 //for I := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
   IDCTFunctionAddress := Integer(@IDCTFunction);
   IDCTFunctionAddressString := IntToHex(IDCTFunctionAddress, 8);
   Update;
   try
    if Validate then
     ReportRichEdit.Lines.Add(FunctionName + #9 + IDCTFunctionAddressString[8] + #9 + 'Passed')
    else
     ReportRichEdit.Lines.Add(FunctionName + #9 + IDCTFunctionAddressString[8] + #9 + 'Failed');
    Update;
   except
    ReportRichEdit.Lines.Add(FunctionName + #9 + IDCTFunctionAddressString[8] + #9 + 'Failed');
   end;
  end;
 StatusBar1.SimpleText := 'Validate All Completed';
 ValidateAllButton.Caption := 'Validate All';
 if FileExists(FValidationFileName) then
  FResultList.LoadFromFile(FValidationFileName);
 FResultList.Add(Format('[%s %s] Running "%s" validation version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FValidationFileName);
end;

procedure TMainForm.PrintSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('IDCT Benchmark Results');
end;

procedure TMainForm.BenchTestButtonClick(Sender: TObject);
var
 I1 : Cardinal;

begin
 BenchTestButton.Caption := 'Running';
 if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_HIGHEST) = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_HIGHEST failed');
 Update;
 for I1 := 1 to BENCHTESTNOOFRUNS do
  BenchmarkAllButtonClick(nil);
 BenchTestButton.Caption := 'Bench Test';
end;

function GetFileSize(FileName : AnsiString) : Int64;
var
 FileStream : TFileStream;
 Mode : Word;

begin
 Mode := 0;
 FileStream := TFileStream.Create(FileName, Mode);
 Result := FileStream.Size;
 FileStream.Free;
end;

procedure TMainForm.BitBtn1Click(Sender: TObject);
var
 IDCTTestData : TStringList;
 IDCTTestDataFileName : AnsiString;
 LineNo1, LineNo2, I : Integer;
 FileSize : Int64;
const
 NoOfDatasetsRemove : Integer = 2000;

begin
 repeat
  IDCTTestData := TStringList.Create;
  IDCTTestDataFileName := ExtractFileDir(Application.ExeName) + '\' + BENCHMARKDATAFILENAME;
  IDCTTestData.LoadFromFile(IDCTTestDataFileName);
  //Randomly remove some datasets to shrink file
  for I := 1 to NoOfDatasetsRemove do
   begin
    LineNo1 := Random(IDCTTestData.Count-1-NoOfDatasetsRemove);
    if Odd(LineNo1) then
     Inc(LineNo1);
    LineNo2 := LineNo1 + 1;
    IDCTTestData.Delete(LineNo2);
    IDCTTestData.Delete(LineNo1);
   end;
  IDCTTestData.SaveToFile(IDCTTestDataFileName);
  IDCTTestData.Free;
  FileSize := GetFileSize(IDCTTestDataFileName);
 until (FileSize <= 15E6);
 repeat
  IDCTTestData := TStringList.Create;
  IDCTTestDataFileName := ExtractFileDir(Application.ExeName) + '\' + VALIDATEDATAFILENAME;
  IDCTTestData.LoadFromFile(IDCTTestDataFileName);
  //Randomly remove some datasets to shrink file
  for I := 1 to NoOfDatasetsRemove do
   begin
    LineNo1 := Random(IDCTTestData.Count-1-NoOfDatasetsRemove);
    if Odd(LineNo1) then
     Inc(LineNo1);
    LineNo2 := LineNo1 + 1;
    IDCTTestData.Delete(LineNo2);
    IDCTTestData.Delete(LineNo1);
   end;
  IDCTTestData.SaveToFile(IDCTTestDataFileName);
  IDCTTestData.Free;
  FileSize := GetFileSize(IDCTTestDataFileName);
 until (FileSize <= 15E6);
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
   FunctionAddress := Cardinal(@IDCTFunction);
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

//******************************************************************************
//Ini file handling functions
//******************************************************************************

procedure TMainForm.ReadIniFile(FileName : AnsiString);
var
 IniFile : TIniFile;

begin
 IniFile := TIniFile.Create(FileName);
 FunctionSelectionRadioGroup.ItemIndex := IniFile.ReadInteger('Settings', 'SelectedFunction', 0);
 ShowErrorDialogCheckBox.Checked := IniFile.ReadBool('Settings', 'ShowErrorDialog', False);
 IniFile.Free;
end;

procedure TMainForm.WriteIniFile(FileName : AnsiString);
var
 IniFile : TIniFile;

begin
 IniFile := TIniFile.Create(FileName);
 IniFile.WriteInteger('Settings', 'SelectedFunction', FunctionSelectionRadioGroup.ItemIndex);
 IniFile.WriteBool('Settings', 'ShowErrorDialog', ShowErrorDialogCheckBox.Checked);
 IniFile.Free;
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
