unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'Trim';

type

 TTrimFunction = function (const S: string) : string;

 TFunctionEntry = record
  FunctionName : AnsiString;
  FunctionPointer : TTrimFunction;
 end;

 TTestSet = record
  S : string;
  CorrectResult : string;
 end;

  TMainForm = class(TForm)
    CloseBitBtn: TBitBtn;
    ReportRichEdit: TRichEdit;
    SaveDialog1: TSaveDialog;
    BenchmarkAllButton: TButton;
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
    OptimizeBenchStabilityButton: TButton;
    BestPrecisionEdit: TEdit;
    OptNoOfRerunsEdit: TEdit;
    OptMaxNoOfRunsScaleEdit: TEdit;
    OptThreadProrityEdit: TEdit;
    Label2: TLabel;
    Label12: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CleanButtonClick(Sender: TObject);
    procedure FunctionSelectionRadioGroupClick(Sender: TObject);
    procedure RegisterFunction(FunctionName : AnsiString; FunctionPointer : TTrimFunction);
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
    procedure OptimizeBenchStabilityButtonClick(Sender: TObject);
  private
   FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
   FResultList: TStringList;
   Frequency : Int64;
   NoOfTicksArray : array of Int64;
   ValidationTestSetArray : array of TTestSet;
   function ValidationResultsPresent : Boolean;
   procedure ReadIniFile(FileName : AnsiString);
   procedure WriteIniFile(FileName : AnsiString);
   procedure FillFunctionSelectionRadioGroup;
   function SubBenchmark1 : Double;
   function SubBenchmark2 : Double;
   procedure FillSubBenchmark1StringArrays;
   procedure FillSubBenchmark2StringArrays;
   procedure BenchmarkTrim;
   function Validate : Boolean;
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
   function Validate18 : Boolean;
   procedure SortRichEdit;
   procedure FillValidationTestSetArray;
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
 SubBenchmark1StringArray : array of String;
 SubBenchmark2StringArray : array of String;
 TrimFunction : TTrimFunction;
 FunctionArray : array of TFunctionEntry;

const
 NOOFRERUNS : Cardinal = 10;
 FIRSTRESULTTOUSE : Cardinal = 1;
 //**************
 //Adjusted such that both subbenchmarks carry identical weigth on the blended target
 //See SpreadsheetCreator
 MAXNOOFRUNSSUB1 : Cardinal = 210000;
 MAXNOOFRUNSSUB2 : Cardinal = 22000;
 SUBBENCH1SCALE : Double = 240;
 SUBBENCH2SCALE : Double = 200;
 //**************
 INIFILENAME : AnsiString = 'TrimBV.Ini';
 SUBBENCH2STRINGLENGTHMAX : Integer = 170;
 SUBBENCH2ARRAYSIZE : Integer = 1000;
 BENCHTESTNOOFRUNS : Integer = 3;

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

procedure TMainForm.RegisterFunction(FunctionName : AnsiString; FunctionPointer : TTrimFunction);
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

//TODO 1 -oDKC -cBug -DKC: Add more validation testsets

procedure TMainForm.FillValidationTestSetArray;
var
 Size : Integer;

begin
 Size := 0;
 Inc(Size);
 SetLength(ValidationTestSetArray, Size);
 ValidationTestSetArray[Size-1].S := '';
 ValidationTestSetArray[Size-1].CorrectResult := '';
 Inc(Size);
 SetLength(ValidationTestSetArray, Size);
 ValidationTestSetArray[Size-1].S := ' ';
 ValidationTestSetArray[Size-1].CorrectResult := '';
 Inc(Size);
 SetLength(ValidationTestSetArray, Size);
 ValidationTestSetArray[Size-1].S := 'A';
 ValidationTestSetArray[Size-1].CorrectResult := 'A';
 Inc(Size);
 SetLength(ValidationTestSetArray, Size);
 ValidationTestSetArray[Size-1].S := 'AB';
 ValidationTestSetArray[Size-1].CorrectResult := 'AB';
 Inc(Size);
 SetLength(ValidationTestSetArray, Size);
 ValidationTestSetArray[Size-1].S := 'ABC';
 ValidationTestSetArray[Size-1].CorrectResult := 'ABC';
 //By Davy Landman
 Inc(Size);
 SetLength(ValidationTestSetArray, Size);
 ValidationTestSetArray[Size - 1].S := '!!!';
 ValidationTestSetArray[Size - 1].CorrectResult := '!!!';
 Inc(Size);
 SetLength(ValidationTestSetArray, Size);
 ValidationTestSetArray[Size - 1].S := '   !!!!   ';
 ValidationTestSetArray[Size - 1].CorrectResult := '!!!!';
end;

procedure TMainForm.FillFunctionSelectionRadioGroup;
var
 I : Integer;

begin
 for I := 1 to Length(FunctionArray) do
  FunctionSelectionRadioGroup.Items.Add(FunctionArray[I-1].FunctionName);
 FunctionSelectionRadioGroup.ItemIndex := 0;
end;

procedure ErrorTrap(ValidateNo : Integer; S : AnsiString);
var
 S2 : string;

begin
 S2 := TrimFunction(S);
 if MainForm.ShowErrorDialogCheckBox.Checked then
  Application.MessageBox(PChar('Function failed in Validate' + IntToStr(ValidateNo) + ' String: ' + S + 'Result: ' + S2), 'Error');
end;

procedure TMainForm.BenchmarkTrim;
var
 Bench, SubBench1, SubBench2 : Double;
 FunctionName, TrimFunctionAddressString : AnsiString;
 TrimFunctionAddress : Cardinal;

begin
 try
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  TrimFunctionAddress := Integer(@TrimFunction);
  TrimFunctionAddressString := IntToHex(TrimFunctionAddress, 8);
  Update;
  SubBench1 := SubBenchmark1;
  //GetTrimRatio;
  SubBench2 := SubBenchmark2;
  //GetTrimRatio;
  Bench := SubBench1 + SubBench2;
  ReportRichEdit.Lines.Add(FunctionName  + #9 +
                           TrimFunctionAddressString[8] + #9 +
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
 J, I5, K : Cardinal;
 I1 : Integer;
 RunNo : Cardinal;
 RunTimeSec : Double;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 S1 : string;

begin
 I1 := 0;
 for J := 1 to NOOFRERUNS do
  begin
   if QueryPerformanceCounter(lpPerformanceCount) then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for RunNo := 1 to MAXNOOFRUNSSUB1 do
    for K := 0 to Length(SubBenchmark1StringArray)-1 do
     S1 := TrimFunction(SubBenchmark1StringArray[K]);
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
 MinNoOfTicks := NoOfTicksArray[FIRSTRESULTTOUSE-1];
 for I5 := FIRSTRESULTTOUSE to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I5] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I5];
  end;
 RunTimeSec := MinNoOfTicks / Frequency;
 Result := Round(RunTimeSec*SUBBENCH1SCALE);
end;

function TMainForm.SubBenchmark2 : Double;
var
 J, I5, K : Cardinal;
 I1 : Integer;
 RunNo : Cardinal;
 RunTimeSec : Double;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;
 S1 : string;

begin
 I1 := 0;
 for J := 1 to NOOFRERUNS do
  begin
   if QueryPerformanceCounter(lpPerformanceCount) then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for RunNo := 1 to MAXNOOFRUNSSUB2 do
    for K := 0 to Length(SubBenchmark2StringArray)-1 do
     S1 := TrimFunction(SubBenchmark2StringArray[K]);
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
 MinNoOfTicks := NoOfTicksArray[FIRSTRESULTTOUSE-1];
 for I5 := FIRSTRESULTTOUSE to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I5] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I5];
  end;
 RunTimeSec := MinNoOfTicks / Frequency;
 Result := Round(RunTimeSec*SUBBENCH2SCALE);
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
begin
 BenchmarkButton.Caption := 'Running';
 if ValidationResultsPresent then
  ReportRichEdit.Clear;
 BenchmarkTrim;
 if ReportRichEdit.Lines.Count > 1 then
  SortRichEdit;
 BenchmarkTest;
 AlignmentTest;
 BenchmarkButton.Caption := 'Benchmark';
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
var
 FunctionName, TrimFunctionAddressString : AnsiString;
 TrimFunctionAddress : Cardinal;

begin
 try
  ValidateButton.Caption := 'Running';
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  TrimFunctionAddress := Integer(@TrimFunction);
  TrimFunctionAddressString := IntToHex(TrimFunctionAddress, 8);
  if Validate then
   ReportRichEdit.Lines.Add(FunctionName + #9 + TrimFunctionAddressString[8] + #9 + 'Passed')
  else
   ReportRichEdit.Lines.Add(FunctionName + #9 + TrimFunctionAddressString[8] + #9 + 'Failed');
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + TrimFunctionAddressString[8] + #9 + 'Failed');
 end;
 StatusBar1.SimpleText := 'Validate Completed';
 ValidateButton.Caption := 'Validate';
end;

//One simple testcase

function TMainForm.Validate1 : Boolean;
var
 S1, S2 : string;
const
 VALIDATENO : Cardinal = 1;

begin
 try
  Result := True;
  S1 := '';
  S2 := TrimFunction(S1);
  if S2 <> S1 then
   begin
    ErrorTrap(VALIDATENO, S1);
    Result := False;
    Exit;
   end;
 except
  ErrorTrap(VALIDATENO, S1);
  Result := False;
 end;
end;

//Two simple testcases

function TMainForm.Validate2 : Boolean;
var
 S1, S2 : string;
const
 VALIDATENO : Cardinal = 2;

begin
 try
  Result := True;
  S1 := ' ';
  S2 := TrimFunction(S1);
  if S2 <> '' then
   begin
    ErrorTrap(VALIDATENO, S1);
    Result := False;
    Exit;
   end;
  S1 := 'A';
  S2 := TrimFunction(S1);
  if S2 <> 'A' then
   begin
    ErrorTrap(VALIDATENO, S1);
    Result := False;
    Exit;
   end;
  S1 := ' A';
  S2 := TrimFunction(S1);
  if S2 <> 'A' then
   begin
    ErrorTrap(VALIDATENO, S1);
    Result := False;
    Exit;
   end;
  S1 := 'A ';
  S2 := TrimFunction(S1);
  if S2 <> 'A' then
   begin
    ErrorTrap(VALIDATENO, S1);
    Result := False;
    Exit;
   end;
 except
  ErrorTrap(VALIDATENO, S1);
  Result := False;
 end;
end;

//Validates testset

function TMainForm.Validate3 : Boolean;
var
 TestNo : Integer;
 S1, S2 : string;
const
 VALIDATENO : Cardinal = 3;

begin
 try
  Result := True;
  for TestNo := 0 to Length(ValidationTestSetArray) - 1 do
   begin
    S1 := ValidationTestSetArray[TestNo].S;
    S2 := TrimFunction(S1);
    if S2 <> ValidationTestSetArray[TestNo].CorrectResult then
     begin
      ErrorTrap(VALIDATENO, S1);
      Result := False;
      Exit;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S1);
  Result := False;
 end;
end;

function TMainForm.Validate4 : Boolean;
var
 TestNo : Integer;
 S1, S2, Sref : string;
const
 TESTNOMAX : Integer = 1000;
 VALIDATENO : Cardinal = 4;

begin
 try
  Result := True;
  S1 := '';
  for TestNo := 1 to TESTNOMAX do
   begin
    S1 := S1 + Char(Random(255));
    Sref := Trim(S1);
    S2 := TrimFunction(S1);
    if S2 <> Sref then
     begin
      ErrorTrap(VALIDATENO, S1);
      Result := False;
      Exit;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S1);
  Result := False;
 end;
end;

function TMainForm.Validate5 : Boolean;
var
 TestNo : Integer;
 S1, S2, Sref : string;
const
 TESTNOMAX : Integer = 1000;
 VALIDATENO : Cardinal = 5;

begin
 try
  Result := True;
  S1 := '';
  for TestNo := 1 to TESTNOMAX do
   begin
    S1 := Char(Random(255)) + S1;
    Sref := Trim(S1);
    S2 := TrimFunction(S1);
    if S2 <> Sref then
     begin
      ErrorTrap(VALIDATENO, S1);
      Result := False;
      Exit;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S1);
  Result := False;
 end;
end;

function TMainForm.Validate6 : Boolean;
var
 TestNo : Integer;
 S1, S2, Sref : string;
const
 TESTNOMAX : Integer = 1000;
 VALIDATENO : Cardinal = 6;

begin
 try
  Result := True;
  S1 := '';
  for TestNo := 1 to TESTNOMAX do
   begin
    S1 := Char(Random(255)) + S1 + Char(Random(255));
    Sref := Trim(S1);
    S2 := TrimFunction(S1);
    if S2 <> Sref then
     begin
      ErrorTrap(VALIDATENO, S1);
      Result := False;
      Exit;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S1);
  Result := False;
 end;
end;

function TMainForm.Validate7 : Boolean;
var
 I1 : Integer;
 S1, S2, Sref : string;
 C1 : Char;
const
 VALIDATENO : Cardinal = 7;

begin
 try
  Result := True;
  S1 := '';
  for I1 := 0 to 255 do
   begin
    C1 := Char(I1);
    S1 := C1;
    Sref := Trim(S1);
    S2 := TrimFunction(S1);
    if S2 <> Sref then
     begin
      ErrorTrap(VALIDATENO, S1);
      Result := False;
      Exit;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S1);
  Result := False;
 end;
end;

function TMainForm.Validate8 : Boolean;
var
 I1, I2 : Integer;
 S1, S2, Sref : string;
 C1, C2 : Char;
const
 VALIDATENO : Cardinal = 8;

begin
 try
  Result := True;
  S1 := '';
  for I1 := 0 to 255 do
   begin
    C1 := Char(I1);
    for I2 := 0 to 255 do
     begin
      C2 := Char(I2);
      S1 := C1 + C2;
      Sref := Trim(S1);
      S2 := TrimFunction(S1);
      if S2 <> Sref then
       begin
        ErrorTrap(VALIDATENO, S1);
        Result := False;
        Exit;
       end;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S1);
  Result := False;
 end;
end;

function TMainForm.Validate9 : Boolean;
var
 I1, I2, I3 : Integer;
 S1, S2, Sref : string;
 C1, C2, C3 : Char;
const
 VALIDATENO : Cardinal = 9;

begin
 try
  Result := True;
  S1 := '';
  for I1 := 0 to 255 do
   begin
    C1 := Char(I1);
    for I2 := 0 to 255 do
     begin
      C2 := Char(I2);
      for I3 := 0 to 255 do
       begin
        C3 := Char(I3);
        S1 := C1 + C2 + C3;
        Sref := Trim(S1);
        S2 := TrimFunction(S1);
        if S2 <> Sref then
         begin
          ErrorTrap(VALIDATENO, S1);
          Result := False;
          Exit;
         end;
       end;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S1);
  Result := False;
 end;
end;

function TMainForm.Validate10 : Boolean;
var
 TestNo : Integer;
 S1, S2 : string;
const
 TESTNOMAX : Integer = 2000;
 VALIDATENO : Cardinal = 10;

begin
 try
  Result := True;
  S1 := '';
  for TestNo := 1 to TESTNOMAX do
   begin
    S1 := Char(Random(255-Ord(' ')-1) + Ord(' ')+1) + S1;//Do not generate white space
    S2 := TrimFunction(S1);
    if S2 <> S1 then
     begin
      ErrorTrap(VALIDATENO, S1);
      Result := False;
      Exit;
     end;
   end;
 except
  ErrorTrap(VALIDATENO, S1);
  Result := False;
 end;
end;

var
 GlobalStrValidate11: AnsiString;

function TMainForm.Validate11 : Boolean;
var
 S : string;
const
 VALIDATENO : Cardinal = 11;

begin
 Result := True;
 GlobalStrValidate11 := 'A';
 PInteger(Integer(GlobalStrValidate11)-4)^ := 0; //Set Length to 0
 S := TrimFunction(GlobalStrValidate11);
 if S <> '' then
  begin
   ErrorTrap(VALIDATENO, GlobalStrValidate11);
   Result := False;
   Exit;
  end;
end;

 {$HINTS OFF}

function TMainForm.Validate12 : Boolean;
var
 J, K, OffSet, OffSetx, RunNo : Integer;
 S : string;
 SearchChar : Char;
 EBXRegisterBefore, ESIRegisterBefore, EDIRegisterBefore, EBPRegisterBefore,
 EBXRegisterAfter,  ESIRegisterAfter,  EDIRegisterAfter, EBPRegisterAfter : Cardinal;
 X, Y, Z : Extended;
const
 RUNNOMAX : Integer = 355;
 VALIDATENO : Cardinal = 12;

begin
 S := '';
 try
  Result := True;
  for RunNo := 1 to RUNNOMAX do
   begin
    asm
     mov EBXRegisterBefore, ebx
     mov EDIRegisterBefore, edi
     mov ESIRegisterBefore, esi
     mov EBPRegisterBefore, ebp
    end;
    TrimFunction(S);
    asm
     mov EBXRegisterAfter, ebx
     mov EDIRegisterAfter, edi
     mov ESIRegisterAfter, esi
     mov EBPRegisterAfter, ebp
    end;
    //Verify that registers are preserved
    if ((EBXRegisterAfter <> EBXRegisterBefore) or
        (EDIRegisterAfter <> EDIRegisterBefore) or
        (ESIRegisterAfter <> ESIRegisterBefore) or
        (EBPRegisterAfter <> EBPRegisterBefore)) then
     begin
      ErrorTrap(VALIDATENO, S);
      Result := False;
      Exit;
     end;
    try
     //Test for missing emms instruction in MMX functions
     X := 2;
     Y := 3;
     Z := X * Y;
     if Z <> 6 then
      Z := 6;
    except
     ErrorTrap(VALIDATENO, S);
     Result := False;
     Exit;
    end;
    S := S + Char(RunNo mod 255)
   end;
 except
  ErrorTrap(VALIDATENO, S);
  Result := False
 end;
end;

{$HINTS ON}

//Based on validate12 from CharPosIEx by John O'Harrow

function TMainForm.Validate13 : Boolean;
var
 I, J : Cardinal;
 MemBlock, Page1, Page2: Pointer;
 C,Dummy: Cardinal;
const
 PAGE_SIZE : Cardinal = 4096;
 S_LEN : Cardinal = 10;

begin
 GetMem(MemBlock, PAGE_SIZE * 3);
 try
  Result := False;
  Page1  := Pointer((Cardinal(MemBlock) or (PAGE_SIZE-1))+1);
  Page2  := Pointer(Cardinal(Page1) + PAGE_SIZE);
  for J := 0 to 15 do
   begin
    for I := 0 to S_LEN-1 do
     PChar(Cardinal(Page2) - S_LEN - 1 - J + Cardinal(I))^ := Char((I+Ord('0')) and $FF);
    //Write input string zero terminator
    PChar(Cardinal(Page2) - 1 - J)^ := #0;
    //Write input string length field
    PInteger(Cardinal(Page2) - S_LEN - 4 - J)^ := S_LEN;
    //Write input string refcount field
    PInteger(Cardinal(Page2) - S_LEN - 8 - J)^ := 1;
    try {Lock Second Page}
     Win32Check(VirtualProtect(Page2, PAGE_SIZE, PAGE_NOACCESS, Dummy));
     try
      Result := True;
      C := Cardinal(Page2) - S_LEN - J;
      TrimFunction(String(C));
     except
      Result := False;
      Exit;
     end;
    finally {Unlock Second Page}
     Win32Check(VirtualProtect(Page2, PAGE_SIZE, PAGE_EXECUTE_READWRITE, Dummy));
    end;
   end;
 finally
  FreeMem(MemBlock);
 end;
end;

function TMainForm.Validate14 : Boolean;
var
 I : Integer;
 S1, S2 : string;
const
 STRLENGTHMAX : Integer = 30000;
 VALIDATENO : Cardinal = 14;

begin
 try
  Result := True;
  S1 := '';
  for I := 1 to STRLENGTHMAX do
   begin
    S2 := TrimFunction(S1);
    if S2 <> '' then
     begin
      ErrorTrap(VALIDATENO, S1);
      Result := False;
      Exit;
     end;
    S1 := S1 + ' ';
   end;
 except
  ErrorTrap(VALIDATENO, S1);
  Result := False;
 end;
end;

function TMainForm.Validate15 : Boolean;
var
 I : Integer;
 S1, S2 : string;
const
 STRLENGTHMAX : Integer = 30000;
 VALIDATENO : Cardinal = 15;

begin
 try
  Result := True;
  S1 := 'A';
  for I := 1 to STRLENGTHMAX do
   begin
    S2 := TrimFunction(S1);
    if S2 <> 'A' then
     begin
      ErrorTrap(VALIDATENO, S1);
      Result := False;
      Exit;
     end;
    S1 := S1 + ' ';
   end;
 except
  ErrorTrap(VALIDATENO, S1);
  Result := False;
 end;
end;

var
 GlobalStrValidate16: AnsiString;

function TMainForm.Validate16 : Boolean;
var
 S : string;
const
 VALIDATENO : Cardinal = 16;

begin
 Result := True;
 GlobalStrValidate16 := #0;
 PInteger(Integer(GlobalStrValidate16)-4)^ := 0; //Set Length to 0
 S := TrimFunction(GlobalStrValidate16);
 if S <> '' then
  begin
   ErrorTrap(VALIDATENO, GlobalStrValidate16);
   Result := False;
   Exit;
  end;
end;

var
 GlobalStrValidate17: AnsiString;

function TMainForm.Validate17 : Boolean;
var
 TestNo : Integer;
 S2 : string;
const
 VALIDATENO : Cardinal = 17;

begin
 Result := True;
 for TestNo := 0 to Length(ValidationTestSetArray) - 1 do
  begin
   GlobalStrValidate17 := ValidationTestSetArray[TestNo].S;
   GlobalStrValidate17 := GlobalStrValidate17 + ' ';//Force new string
   if Pointer(GlobalStrValidate17) = nil then
    Continue;
   PInteger(Integer(GlobalStrValidate17)-4)^ := 0; //Set Length to 0
   S2 := TrimFunction(GlobalStrValidate17);
   PInteger(Integer(GlobalStrValidate17)-4)^ := Length(ValidationTestSetArray[TestNo].S); //Set Length back to correct length
   if S2 <> '' then
    begin
     ErrorTrap(VALIDATENO, GlobalStrValidate17);
     Result := False;
     Exit;
    end;
  end;
end;

//Based on validate12 from CharPosIEx by John O'Harrow
//The string is S_LEN chars and located at the upper page boundary

function TMainForm.Validate18 : Boolean;
var
 I : Cardinal;
 MemBlock, Page1, Page2, Page3 : Pointer;
 C,Dummy: Cardinal;
 C1 : Char;
const
 PAGE_SIZE : Cardinal = 4096;
 S_LEN : Cardinal = 4096-8;
 VALIDATENO : Cardinal = 18;

begin
 GetMem(MemBlock, PAGE_SIZE * 4);
 try
  Result := False;
  Page1  := Pointer((Cardinal(MemBlock) or (PAGE_SIZE-1))+1);
  Page2  := Pointer(Cardinal(Page1) + PAGE_SIZE);
  Page3  := Pointer(Cardinal(Page2) + PAGE_SIZE);
  try {Lock first Page}
   Win32Check(VirtualProtect(Page1, PAGE_SIZE, PAGE_NOACCESS, Dummy));
   try {Lock third Page}
    Win32Check(VirtualProtect(Page3, PAGE_SIZE, PAGE_NOACCESS, Dummy));
    //Write string data at entire page
    for I := 0 to PAGE_SIZE-1 do
     begin
      C1 := Char(I mod 255) ;
      PChar(Cardinal(Page2) + Cardinal(I))^ := C1;
     end;
    //Write input string zero terminator at the last byte in the page
    PChar(Cardinal(Page3) - 1)^ := #0;
    //Write input string refcount field at the first integer in the page
    PInteger(Cardinal(Page2))^ := 1;
    //Write input string length field at the second integer in the page
    PInteger(Cardinal(Page2)+4)^ := S_LEN;
    try
     Result := True;
     C := Cardinal(Page2) + 8;
     TrimFunction(String(C));
    except
     Result := False;
     ErrorTrap(VALIDATENO, String(C));
     Exit;
    end;
   finally {Unlock third Page}
    Win32Check(VirtualProtect(Page3, PAGE_SIZE, PAGE_EXECUTE_READWRITE, Dummy));
   end;
  finally {Unlock first Page}
   Win32Check(VirtualProtect(Page1, PAGE_SIZE, PAGE_EXECUTE_READWRITE, Dummy));
  end;
 finally
  FreeMem(MemBlock);
 end;
end;

procedure TMainForm.FillSubBenchmark1StringArrays;
var
 J, I : Integer;

begin
 //Allocate "enough" space
 SetLength(SubBenchmark1StringArray,250);
 J := 0;
 SubBenchmark1StringArray[J]  := '';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'A';
 Inc(J);
 SubBenchmark1StringArray[J]  := ' A';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'A ';
 Inc(J);
 SubBenchmark1StringArray[J]  := ' A ';
 Inc(J);
 SubBenchmark1StringArray[J]  := ' AB';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'AB ';
 Inc(J);
 SubBenchmark1StringArray[J]  := ' AB ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABC ';
 Inc(J);
 SubBenchmark1StringArray[J]  := ' ABC';
 Inc(J);
 SubBenchmark1StringArray[J]  := ' ABC ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABC  ';
 Inc(J);
 SubBenchmark1StringArray[J]  := '  ABC';
 Inc(J);
 SubBenchmark1StringArray[J]  := '  ABC  ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCD  ';
 Inc(J);
 SubBenchmark1StringArray[J]  := '  ABCD';
 Inc(J);
 SubBenchmark1StringArray[J]  := '  ABCD  ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCD   ';
 Inc(J);
 SubBenchmark1StringArray[J]  := '   ABCD';
 Inc(J);
 SubBenchmark1StringArray[J]  := '   ABCD   ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDE   ';
 Inc(J);
 SubBenchmark1StringArray[J]  := '   ABCDE';
 Inc(J);
 SubBenchmark1StringArray[J]  := '   ABCDE   ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEF    ';
 Inc(J);
 SubBenchmark1StringArray[J]  := '    ABCDEF';
 Inc(J);
 SubBenchmark1StringArray[J]  := '   ABCDEF   ';
 Inc(J);
 SubBenchmark1StringArray[J]  := ' ABCDEFGHIJKLMNOPQRSTUVWXYZ';
 Inc(J);
 SubBenchmark1StringArray[J]  := '  ABCDEFGHIJKLMNOPQRSTUVWXYZ';
 Inc(J);
 SubBenchmark1StringArray[J]  := '   ABCDEFGHIJKLMNOPQRSTUVWXYZ';
 Inc(J);
 SubBenchmark1StringArray[J]  := '    ABCDEFGHIJKLMNOPQRSTUVWXYZ';
 Inc(J);
 SubBenchmark1StringArray[J]  := '     ABCDEFGHIJKLMNOPQRSTUVWXYZ';
 Inc(J);
 SubBenchmark1StringArray[J]  := '      ABCDEFGHIJKLMNOPQRSTUVWXYZ';
 Inc(J);
 SubBenchmark1StringArray[J]  := '       ABCDEFGHIJKLMNOPQRSTUVWXYZ';
 Inc(J);
 SubBenchmark1StringArray[J]  := '        ABCDEFGHIJKLMNOPQRSTUVWXYZ';
 Inc(J);
 SubBenchmark1StringArray[J]  := '         ABCDEFGHIJKLMNOPQRSTUVWXYZ';
 Inc(J);
 SubBenchmark1StringArray[J]  := '          ABCDEFGHIJKLMNOPQRSTUVWXYZ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ  ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ   ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ    ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ     ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ      ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ       ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ        ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ         ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ          ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ           ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'AB';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABC';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCD';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDE';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEF';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFG';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGH';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHI';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJK';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKL';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLM';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMN';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNO';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOP';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQR';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRS';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRST';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTU';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUW';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUWX';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUWXY';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUWXYZ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'AB';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABC';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCD';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDE';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEF';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFG';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGH';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHI';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJK';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKL';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLM';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMN';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNO';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOP';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQR';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRS';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRST';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTU';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUW';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUWX';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUWXY';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUWXYZ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'AB';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABC';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCD';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDE';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEF';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFG';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGH';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHI';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJK';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKL';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLM';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMN';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNO';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOP';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQ';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQR';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRS';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRST';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTU';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUW';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUWX';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUWXY';
 Inc(J);
 SubBenchmark1StringArray[J]  := 'ABCDEFGHIJKLMNOPQRSTUWXYZ';
 Inc(J);                                                   
 //By Davy Landman
 SetLength(SubBenchmark1StringArray[J], 80);
 for i := 1 to 80  do
  SubBenchmark1StringArray[J, i] := Char(i);
 Inc(J);
 SetLength(SubBenchmark1StringArray[J], 80);
 for i := 1 to 32  do
  SubBenchmark1StringArray[J, i] := Char(i);
 for i := 33 to 50 do
  SubBenchmark1StringArray[J, i] := Char(i);
 for i := 51 to 80 do
  SubBenchmark1StringArray[J, i] := Char(i - 50);
 Inc(J);
 //Adjust array size
 SetLength(SubBenchmark1StringArray,J+1);
end;

procedure TMainForm.FillSubBenchmark2StringArrays;
var
 J : Integer;
 S : string;

begin
 SetLength(SubBenchmark2StringArray, SUBBENCH2ARRAYSIZE);
 S := '';
 for J := 0 to SUBBENCH2ARRAYSIZE-1 do
  begin
   if Length(S) > SUBBENCH2STRINGLENGTHMAX then
    S := '';
   //S := S + Char(Random(255-33)+33);// TrimRatio = 0%
   //S := S + Char(Random(255-32)+32);// TrimRatio = 9%
   //S := S + Char(Random(255-31)+31);// TrimRatio = 9.3%
   //S := S + Char(Random(255-30)+30);// TrimRatio = 9.7%
   S := S + Char(Random(255-29)+29);// TrimRatio = 10.2%
   SubBenchmark2StringArray[J]  := S;
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

procedure TMainForm.FormCreate(Sender: TObject);
var
 CpuString : string;

begin
 ClearAllEditBoxes;
 ReportRichEdit.Clear;
 ReportRichEdit.Paragraph.TabCount := 4;
 ReportRichEdit.Paragraph.Tab[0] := 110;
 ReportRichEdit.Paragraph.Tab[1] := 140;
 ReportRichEdit.Paragraph.Tab[2] := 180;
 ReportRichEdit.Paragraph.Tab[3] := 230;
 FillValidationTestSetArray;
 FillSubBenchmark1StringArrays;
 FillSubBenchmark2StringArrays;
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
end;

procedure TMainForm.FunctionSelectionRadioGroupClick(Sender: TObject);
var
 FunctionPointer : TTrimFunction;
begin
 FunctionPointer := FunctionArray[FunctionSelectionRadioGroup.ItemIndex].FunctionPointer;
 TrimFunction := FunctionPointer;
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
 I1, ReRun : Integer;
const
 NoOfReRuns : Integer = 2;

begin
 BenchmarkAllButton.Caption := 'Running';
 if Sender <> nil then//Thread priority has been set if bench test - do not reset
  if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_HIGHEST) = False then
   raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_HIGHEST failed');
 if ValidationResultsPresent then
  ReportRichEdit.Clear;
 Update;
 for ReRun := 1 to NoOfReRuns do
  begin
   for I1 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
   //for I1 := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
    begin
     FunctionSelectionRadioGroup.ItemIndex := I1;
     BenchmarkTrim;
     BenchmarkTest;
     AlignmentTest;
     if ReportRichEdit.Lines.Count > 1 then
      SortRichEdit;
     ReportRichEdit.SelStart := 0;
     ReportRichEdit.Perform(EM_ScrollCaret, 0, 0);
    end;
  end;
 //Keep the best
 CleanResultsRichEdit;
 BenchmarkTest;
 BenchmarkAllButton.Caption := 'Benchmark All';
 Update;
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
           Validate17 and
           Validate18;
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I : Integer;
 FunctionName, TrimFunctionAddressString : AnsiString;
 TrimFunctionAddress : Cardinal;

begin
 ValidateAllButton.Caption := 'Running';
 if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_IDLE) = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_IDLE failed');
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 //for I := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
   TrimFunctionAddress := Integer(@TrimFunction);
   TrimFunctionAddressString := IntToHex(TrimFunctionAddress, 8);
   Update;
   try
    if Validate then
     ReportRichEdit.Lines.Add(FunctionName + #9 + TrimFunctionAddressString[8] + #9 + 'Passed')
    else
     ReportRichEdit.Lines.Add(FunctionName + #9 + TrimFunctionAddressString[8] + #9 + 'Failed');
    Update;
   except
    ReportRichEdit.Lines.Add(FunctionName + #9 + TrimFunctionAddressString[8] + #9 + 'Failed');
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
 ReportRichEdit.Print('Trim Benchmark Results');
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

procedure TMainForm.OptimizeBenchStabilityButtonClick(Sender: TObject);
//var
// BestPrecision, Precision, RunTimeSec : Double;
// OptNoOfReruns, MaxNoOfRunsScale, OptMaxNoOfRunsScale, NoOfFunctions, ThreadPrio : Integer;
// Results : TStringList;
// StartTime, RunTime : TDateTime;
// FileNamePath, CpuString, ThreadProrityS, WorstFunction, OldCaption : AnsiString;
//
begin
// OldCaption := OptimizeBenchStabilityButton.Caption;
// OptimizeBenchStabilityButton.Caption := 'Running';
// NoOfFunctions := FunctionSelectionRadioGroup.Items.Count;
// Results := TStringList.Create;
// case FastCodeTarget of
//  fctRTLReplacement,
//  fctBlendedIA32,
//  fctBlendedMMX,
//  fctBlendedSSE,
//  fctBlendedSSE2 : CpuString := Format('%s_%s_F%d_M%d', [FastCodeTargetStr[FastCodeTarget], VendorStr[CPU.Vendor], CPU.EffFamily, CPU.EffModel ]);
// else
//  CpuString := FastCodeTargetStr[FastCodeTarget];
// end;
// FileNamePath := ExtractFileDir(Application.ExeName) + '\TrimBenchmarkStability_' + CpuString + '.txt';
// Results.Add(CpuString);
// BestPrecision := MaxDouble;
// MaxNoOfRunsScale := 1;
// while MaxNoOfRunsScale <= 10 do
//  begin
//   MAXNOOFRUNSSUB1 := 21000 * MaxNoOfRunsScale;
//   MAXNOOFRUNSSUB2 := 1140 * MaxNoOfRunsScale;
//   NOOFRERUNS := 2;
//   while NOOFRERUNS <= 10 do
//    begin
//     SetLength(NoOfTicksArray, NOOFRERUNS);
//     for ThreadPrio := 1 to 3 do
//      begin
//       case ThreadPrio of
//        1 :
//         begin
//          if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_NORMAL) = False then
//           raise Exception.Create('SetThreadPriority to THREAD_PRIORITY__NORMAL failed');
//          ThreadProrityS := 'THREAD_PRIORITY_NORMAL';
//         end;
//        2 :
//         begin
//          if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_ABOVE_NORMAL) = False then
//           raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_ABOVE_NORMAL failed');
//          ThreadProrityS := 'THREAD_PRIORITY_ABOVE_NORMAL';
//         end;
//        3 :
//         begin
//          if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_HIGHEST) = False then
//           raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_HIGHEST failed');
//          ThreadProrityS := 'THREAD_PRIORITY_HIGHEST';
//         end;
//       end;
//       ReportRichEdit.Clear;
//       StartTime := Time;
//       BenchTestButtonClick(nil);
//       RunTime := Time - StartTime;
//       RunTimeSec := RunTime * 24*60*60;
//       WorstFunction := FunctionNameEdit.Text;
//       Precision := StrToFloat(MaxSpreadBenchPercentageEdit.Text);
//       Results.Add('MAXNOOFRUNSSUB1: ' + IntToStr(MAXNOOFRUNSSUB1)
//            + #9 + 'MAXNOOFRUNSSUB2: ' + IntToStr(MAXNOOFRUNSSUB2)
//            + #9 + 'NOOFRERUNS: ' + IntToStr(NOOFRERUNS)
//            + #9 + 'Thread priority: ' + ThreadProrityS
//            + #9 + 'Precision: ' + MaxSpreadBenchPercentageEdit.Text
//            + #9 + '#Functions: ' + IntToStr(NoOfFunctions)
//            + #9 + 'WorstFunction' + WorstFunction
//            + #9 + 'AvgBenchRuntimePerFunction: ' + FloatToStrF(RunTimeSec/(NoOfFunctions*BENCHTESTNOOFRUNS), ffFixed, 9, 0));
//       Results.SaveToFile(FileNamePath);
//       if Precision < BestPrecision then
//        begin
//         BestPrecision := Precision;
//         OptNoOfReruns := NOOFRERUNS;
//         OptMaxNoOfRunsScale := MaxNoOfRunsScale;
//         BestPrecisionEdit.Text := FloatToStrF(Precision, ffFixed, 9, 1);
//         OptNoOfRerunsEdit.Text := IntToStr(OptNoOfReruns);
//         OptMaxNoOfRunsScaleEdit.Text := IntToStr(OptMaxNoOfRunsScale);
//         OptThreadProrityEdit.Text := ThreadProrityS;
//        end;
//      end;
//     Inc(NOOFRERUNS,2);
//    end;
//   Inc(MaxNoOfRunsScale,2);
//  end;
// Results.Free;
// OptimizeBenchStabilityButton.Caption := OldCaption;
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
   FunctionAddress := Cardinal(@TrimFunction);
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
