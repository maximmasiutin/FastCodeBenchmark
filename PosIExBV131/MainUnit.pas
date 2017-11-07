unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'PosIEX';

type

 TTestSet = record
  SubStr, S : AnsiString;
  Offset, CorrectResult : Integer;
 end;

  TMainForm = class(TForm)
    CloseBitBtn: TBitBtn;
    ReportRichEdit: TRichEdit;
    SaveDialog1: TSaveDialog;
    RunAllBenchmarksButton: TButton;
    FunctionSelectionRadioGroup: TRadioGroup;
    ProgressBar1: TProgressBar;
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
    TestCaseButton: TButton;
    AboutSpeedButton: TSpeedButton;
    procedure FormDestroy(Sender: TObject);
    procedure AboutSpeedButtonClick(Sender: TObject);
    procedure TestCaseButtonClick(Sender: TObject);
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
   TestSetArray : array of TTestSet;
   function SubBenchmark1 : Double;
   function SubBenchmark2 : Double;
   procedure FillBenchmarkStringArrays;
   procedure BenchmarkPosIEx;
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
   function Validate12: Boolean;
   function Validate13: Boolean;
   function Validate14: Boolean;
   function Validate15: Boolean;
   function Validate16: Boolean;
   function Validate17: Boolean;
   function Validate18: Boolean;
   function Validate19: Boolean;
   function Validate20: Boolean;
   function Validate21: Boolean;
   procedure SortRichEdit;
   procedure FillTestSetArray;
  public
   procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
   procedure AlignmentTest;
   procedure ClearAllEditBoxes;
   procedure BenchmarkTest;
   procedure CleanResultsRichEdit;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 StrUtils, Math, FastcodeCPUID, SystemInfoUnit, PosIExRefUnit, PosIExDKCUnit, PosIExJOHUnit, AboutUnit;

type
 TPosIExFunction = function(const SubStr, S: string; Offset: Integer = 1): Integer;

var
 //Used in validation and benchmark
 SubStrArray : array of String;
 StringArray : array of String;
 PosIExFunction : TPosIExFunction;

const
 NOOFRERUNS : Cardinal = 10;
 MAXNOOFRUNSSUB1 : Cardinal = 10000;
 MAXNOOFRUNSSUB2 : Cardinal =  1000;
 RUNTIMESCALE : Cardinal = 100;
 //Best function in subbench1 scores 1000 on Opteron 240 - incorrect due to addition of faster function
 SUBBENCH1SCALE : Double = 2650;
 //Best function in subbench2 scores 1000 on Opteron 240 - incorrect due to addition of faster function
 SUBBENCH2SCALE : Double = 1340;

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
         if MaxSpread > 2 then
          MaxSpreadBenchPercentageEdit.Color := clYellow;
         if MaxSpread > 5 then
          MaxSpreadBenchPercentageEdit.Color := clRed;
         Update;
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

//TODO 1 -DKC: Add more validation testsets

procedure TMainForm.FillTestSetArray;
var
 Size : Integer;

begin
 Size := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'a';
 TestSetArray[Size-1].S := TestSetArray[Size-1].SubStr;
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'a';
 TestSetArray[Size-1].S := 'A';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'A';
 TestSetArray[Size-1].S := 'A';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'ZZ';
 TestSetArray[Size-1].S := 'AZBZZ';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 4;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'ZZ';
 TestSetArray[Size-1].S := 'ABZZ';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 3;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'ZZ';
 TestSetArray[Size-1].S := 'ZZ';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := '';
 TestSetArray[Size-1].S := 'a';
 TestSetArray[Size-1].Offset := 2;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := '';
 TestSetArray[Size-1].S := '';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := #0;
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'E' + #0;
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 0;
 //Offset <= 0 testsets
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'ZZ';
 TestSetArray[Size-1].S := 'ZZ';
 TestSetArray[Size-1].Offset := 0;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'D';
 TestSetArray[Size-1].S := 'ABCD';
 TestSetArray[Size-1].Offset := 0;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := '';
 TestSetArray[Size-1].S := '';
 TestSetArray[Size-1].Offset := 0;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := '';
 TestSetArray[Size-1].S := '';
 TestSetArray[Size-1].Offset := -22;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := '';
 TestSetArray[Size-1].S := 'abcdefghkip';
 TestSetArray[Size-1].Offset := -22;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'kip';
 TestSetArray[Size-1].S := 'abcdefghkip';
 TestSetArray[Size-1].Offset := -22;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := '';
 TestSetArray[Size-1].S := 'b';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'a';
 TestSetArray[Size-1].S := '';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := #0;
 TestSetArray[Size-1].S := 'b';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := #0;
 TestSetArray[Size-1].S := 'b';
 TestSetArray[Size-1].Offset := 2;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'a';
 TestSetArray[Size-1].S := 'b';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'A';
 TestSetArray[Size-1].S := 'A';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := '';
 TestSetArray[Size-1].S := '';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := #0#0;
 TestSetArray[Size-1].S := #0#0;
 TestSetArray[Size-1].Offset := 2;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'B';
 TestSetArray[Size-1].S := 'AB';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 2;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'C';
 TestSetArray[Size-1].S := 'ABC';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 3;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'C';
 TestSetArray[Size-1].S := 'ABCD';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 3;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'CD';
 TestSetArray[Size-1].S := 'ABCD';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 3;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'CD';
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 3;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'A';
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'B';
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 2;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'C';
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 3;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'D';
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 4;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'E';
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 5;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'A';
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 2;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'B';
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 2;
 TestSetArray[Size-1].CorrectResult := 2;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'C';
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 2;
 TestSetArray[Size-1].CorrectResult := 3;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'D';
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 2;
 TestSetArray[Size-1].CorrectResult := 4;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'E';
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 2;
 TestSetArray[Size-1].CorrectResult := 5;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'A';
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 3;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'B';
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 3;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'C';
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 3;
 TestSetArray[Size-1].CorrectResult := 3;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'D';
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 3;
 TestSetArray[Size-1].CorrectResult := 4;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'E';
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 3;
 TestSetArray[Size-1].CorrectResult := 5;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'ABCDE';
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 1;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := 'ABCDE';
 TestSetArray[Size-1].S := 'ABCDE';
 TestSetArray[Size-1].Offset := 2;
 TestSetArray[Size-1].CorrectResult := 0;
 Inc(Size);
 SetLength(TestSetArray, Size);
 TestSetArray[Size-1].SubStr := #0 + #0 + #0 + #0 + #1 + #8;
 TestSetArray[Size-1].S := #0 + #0 + #0 + #0 + #0 + #0 + #0 + #0 + #1 + #8 + #1;
 TestSetArray[Size-1].Offset := 1;
 TestSetArray[Size-1].CorrectResult := 5;
end;

procedure ErrorTrap(ValidateNo : Integer; SubS, S : AnsiString; Offset : Integer);
begin
 PosIExFunction(SubS, S, Offset);
 if MainForm.ShowErrorDialogCheckBox.Checked then
  Application.MessageBox(PChar('Function failed in Validate' + IntToStr(ValidateNo) + ' SubString: ' + SubS + ' String: ' + S + ' Offset: ' + IntToStr(Offset)), 'Error');
end;

procedure TMainForm.BenchmarkPosIEx;
var
 Bench, SubBench1, SubBench2 : Double;
 FunctionName, PosIExFunctionAddressString : AnsiString;
 PosIExFunctionAddress : Cardinal;

begin
 try
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  PosIExFunctionAddress := Integer(@PosIExFunction);
  PosIExFunctionAddressString := IntToHex(PosIExFunctionAddress, 8);
  Update;
  SubBench1 := SubBenchmark1;
  SubBench2 := SubBenchmark2;
  Bench := SubBench1 + SubBench2;
  ReportRichEdit.Lines.Add(FunctionName  + #9 +
                           PosIExFunctionAddressString[8] + #9 +
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
 J, I1, I2, I3, I4, I5, K : Cardinal;
 RunNo : Cardinal;
 RunTimeSec : Double;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;

begin
 I1 := 0;
 I2 := 0;
 I3 := 0;
 I4 := 0;
 for J := 1 to NOOFRERUNS do
  begin
   if QueryPerformanceCounter(lpPerformanceCount) then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for RunNo := 1 to MAXNOOFRUNSSUB1 do
    begin
     //Use lower half of testset
     for K := 0 to (Length(SubStrArray) div 2) - 1 do
      begin
       I1 := PosIExFunction(SubStrArray[K], StringArray[K], 1);
       I2 := PosIExFunction(SubStrArray[K], StringArray[K], 2);
       I3 := PosIExFunction(SubStrArray[K], StringArray[K], 3);
       I4 := PosIExFunction(SubStrArray[K], StringArray[K], 4);
      end;
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
 ResultEdit.Text := IntToStr(I2);
 ResultEdit.Text := IntToStr(I3);
 ResultEdit.Text := IntToStr(I4);
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I5 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I5] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I5];
  end;
 RunTimeSec := MinNoOfTicks / Frequency;
 Result := Round(RunTimeSec*SUBBENCH1SCALE);
end;

function TMainForm.SubBenchmark2 : Double;
var
 J, I1, I2, I3, I4, I5, I6, I7, I8, K : Cardinal;
 RunNo : Cardinal;
 RunTimeSec : Double;
 lpPerformanceCount, StartCount, EndCount, NoOfTicks, MinNoOfTicks : Int64;

begin
 I1 := 0;
 I2 := 0;
 I3 := 0;
 I4 := 0;
 I5 := 0;
 I6 := 0;
 I7 := 0;
 for J := 1 to NOOFRERUNS do
  begin
   if QueryPerformanceCounter(lpPerformanceCount) then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for RunNo := 1 to MAXNOOFRUNSSUB2 do
    begin
     //Use upper half of testset
     for K := (Length(SubStrArray) div 2) to Length(StringArray)-1 do
      begin
       I1 := PosIExFunction(SubStrArray[K], StringArray[K], 1);
       I2 := PosIExFunction(SubStrArray[K], StringArray[K], 2);
       I3 := PosIExFunction(SubStrArray[K], StringArray[K], 3);
       I4 := PosIExFunction(SubStrArray[K], StringArray[K], 4);
       I5 := PosIExFunction(SubStrArray[K], StringArray[K], 5);
       I6 := PosIExFunction(SubStrArray[K], StringArray[K], 7);
       I7 := PosIExFunction(SubStrArray[K], StringArray[K], 11);
      end;
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
 ResultEdit.Text := IntToStr(I2);
 ResultEdit.Text := IntToStr(I3);
 ResultEdit.Text := IntToStr(I4);
 ResultEdit.Text := IntToStr(I5);
 ResultEdit.Text := IntToStr(I6);
 ResultEdit.Text := IntToStr(I7);
 //Get fastest run
 MinNoOfTicks := NoOfTicksArray[0];
 for I8 := 1 to NOOFRERUNS-1 do
  begin
   if NoOfTicksArray[I8] < MinNoOfTicks then
    MinNoOfTicks := NoOfTicksArray[I8];
  end;
 RunTimeSec := MinNoOfTicks / Frequency;
 Result := Round(RunTimeSec*SUBBENCH2SCALE);
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
begin
 BenchmarkButton.Caption := 'Running';
 BenchmarkPosIEx;
 if ReportRichEdit.Lines.Count > 1 then
  SortRichEdit;
 BenchmarkTest;
 AlignmentTest;
 BenchmarkButton.Caption := 'Benchmark';
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
var
 FunctionName, PosIExFunctionAddressString : AnsiString;
 PosIExFunctionAddress : Cardinal;

begin
 try
  ValidateButton.Caption := 'Running';
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  PosIExFunctionAddress := Integer(@PosIExFunction);
  PosIExFunctionAddressString := IntToHex(PosIExFunctionAddress, 8);
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
     Validate17 and
     Validate18 and
     Validate19 and
     Validate20 and
     Validate21 then
   ReportRichEdit.Lines.Add(FunctionName + #9 + PosIExFunctionAddressString[8] + #9 + 'Passed')
  else
   ReportRichEdit.Lines.Add(FunctionName + #9 + PosIExFunctionAddressString[8] + #9 + 'Failed');
  Update;
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + PosIExFunctionAddressString[8] + #9 + 'Failed');
 end;
 StatusBar1.SimpleText := 'Validate Completed';
 ValidateButton.Caption := 'Validate';
end;

function TMainForm.Validate1 : Boolean;
var
 TestNo, I : Integer;
const
 VALIDATENO : Cardinal = 1;

begin
 StatusBar1.SimpleText := 'Running Validate1';
 Update;
 Result := True;
 ProgressBar1.Max := MaxInt;
 ProgressBar1.Min := 0;
 ProgressBar1.Max := Length(TestSetArray)-1;
 for TestNo := 0 to Length(TestSetArray)-1 do
  begin
   ProgressBar1.Position := TestNo;
   Update;
   try
    I := PosIExFunction(TestSetArray[TestNo].SubStr, TestSetArray[TestNo].S, TestSetArray[TestNo].Offset);
    if I <> TestSetArray[TestNo].CorrectResult then
     begin
      ErrorTrap(VALIDATENO, TestSetArray[TestNo].SubStr, TestSetArray[TestNo].S, TestSetArray[TestNo].Offset);
      Result := False;
      Exit;
     end;
   except
    ErrorTrap(VALIDATENO, TestSetArray[TestNo].SubStr, TestSetArray[TestNo].S, TestSetArray[TestNo].Offset);
    Result := False;
   end;
  end;
end;

function TMainForm.Validate2 : Boolean;
var
 I, Iref, J, K : Integer;
 SubS, S : String;
const
 VALIDATE2MIN : Integer = 1;
 VALIDATE2MAX : Integer = 255;
 VALIDATENO : Cardinal = 2;

begin
 StatusBar1.SimpleText := 'Running Validate2';
 Update;
 Result := True;
 ProgressBar1.Max := MaxInt;
 ProgressBar1.Min := VALIDATE2MIN;
 ProgressBar1.Max := VALIDATE2MAX;
 for K := VALIDATE2MIN to VALIDATE2MAX do
  begin
   ProgressBar1.Position := K;
   Update;
   for J := VALIDATE2MIN to VALIDATE2MAX do
    begin
     SubS := Char(K);
     S := Char(J);
     Iref := PosIEx_Ref_a(SubS, S);
     try
      I := PosIExFunction(SubS, S);
      if I <> Iref then
       begin
        ErrorTrap(VALIDATENO, SubS, S, 1);
        Result := False;
        Exit;
       end;
     except
      ErrorTrap(VALIDATENO, SubS, S, 1);
      Result := False;
     end;
    end;
  end;
end;

function TMainForm.Validate3 : Boolean;
var
 I, Iref, J, K, W : Integer;
 SubS, S : String;
const
 VALIDATE3MIN : Integer = 0;
 VALIDATE3MAX : Integer = 75;
 VALIDATENO : Cardinal = 3;

begin
 StatusBar1.SimpleText := 'Running Validate3';
 Update;
 Result := True;
 ProgressBar1.Max := MaxInt;
 ProgressBar1.Min := VALIDATE3MIN;
 ProgressBar1.Max := VALIDATE3MAX;
 for W := VALIDATE3MIN to VALIDATE3MAX do
  begin
   ProgressBar1.Position := W;
   Update;
   for K := VALIDATE3MIN to VALIDATE3MAX do
    begin
     for J := VALIDATE3MIN to VALIDATE3MAX do
      begin
       SubS := Char(K);
       S := Char(J) + Char(W);
       Iref := PosIEx_Ref_a(SubS, S);
       try
        I := PosIExFunction(SubS, S);
        if I <> Iref then
         begin
          ErrorTrap(VALIDATENO, SubS, S, 1);
          Result := False;
          Exit;
         end;
       except
        ErrorTrap(VALIDATENO, SubS, S, 1);
        Result := False;
       end;
      end;
    end;
  end;
end;

function TMainForm.Validate4 : Boolean;
var
 I, Iref, J, K, W, Q : Integer;
 SubS, S : String;
const
 VALIDATE4MIN : Integer = 90;
 VALIDATE4MAX : Integer = 115;
 VALIDATENO : Cardinal = 4;

begin
 StatusBar1.SimpleText := 'Running Validate4';
 Update;
 Result := True;
 ProgressBar1.Max := MaxInt;
 ProgressBar1.Min := VALIDATE4MIN;
 ProgressBar1.Max := VALIDATE4MAX;
 for Q := VALIDATE4MIN to VALIDATE4MAX do
  begin
   ProgressBar1.Position := Q;
   for W := VALIDATE4MIN to VALIDATE4MAX do
    begin
     Update;
     for K := VALIDATE4MIN to VALIDATE4MAX do
      begin
       for J := VALIDATE4MIN to VALIDATE4MAX do
        begin
         SubS := Char(K) + Char(Q);
         S := Char(J) + Char(W);
         Iref := PosIEx_Ref_a(SubS, S);
         try
          I := PosIExFunction(SubS, S);
          if I <> Iref then
           begin
            ErrorTrap(VALIDATENO, SubS, S, 1);
            Result := False;
            Exit;
           end;
         except
          ErrorTrap(VALIDATENO, SubS, S, 1);
          Result := False;
         end;
        end;
      end;
    end;
  end;
end;

function TMainForm.Validate5 : Boolean;
var
 I, Iref, J, K, W, Q : Integer;
 SubS, S : String;
const
 VALIDATE5MIN : Integer = 0;
 VALIDATE5MAX : Integer = 20;
 VALIDATENO : Cardinal = 5;

begin
 StatusBar1.SimpleText := 'Running Validate5';
 Update;
 Result := True;
 ProgressBar1.Max := MaxInt;
 ProgressBar1.Min := VALIDATE5MIN;
 ProgressBar1.Max := VALIDATE5MAX;
 for Q := VALIDATE5MIN to VALIDATE5MAX do
  begin
   ProgressBar1.Position := Q;
   for W := VALIDATE5MIN to VALIDATE5MAX do
    begin
     Update;
     for K := VALIDATE5MIN to VALIDATE5MAX do
      begin
       for J := VALIDATE5MIN to VALIDATE5MAX do
        begin
         SubS := Char(K);
         S := Char(J) + Char(W) + Char(Q);
         Iref := PosIEx_Ref_a(SubS, S);
         try
          I := PosIExFunction(SubS, S);
          if I <> Iref then
           begin
            ErrorTrap(VALIDATENO, SubS, S, 1);
            Result := False;
            Exit;
           end;
         except
          ErrorTrap(VALIDATENO, SubS, S, 1);
          Result := False;
         end;
        end;
      end;
    end;
  end;
end;

function TMainForm.Validate6 : Boolean;
var
 I, Iref, J, K, W, Q, T : Integer;
 SubS, S : String;
const
 VALIDATE6MIN1 : Integer = 0;
 VALIDATE6MAX1 : Integer = 45;
 VALIDATENO : Cardinal = 6;

begin
 StatusBar1.SimpleText := 'Running Validate6';
 Update;
 Result := True;
 ProgressBar1.Max := MaxInt;
 ProgressBar1.Min := VALIDATE6MIN1;
 ProgressBar1.Max := VALIDATE6MAX1;
 for T := VALIDATE6MIN1 to VALIDATE6MAX1 do
  begin
   ProgressBar1.Position := T;
   for Q := 0 to 20 do
    begin
     Update;
     for W := 65 to 75 do
      begin
       for K := 65 to 75 do
        begin
         for J := 85 to 100 do
          begin
           SubS := Char(K);
           S := Char(J) + Char(W) + Char(Q) + Char(T);
           Iref := PosIEx_Ref_a(SubS, S);
           try
            I := PosIExFunction(SubS, S);
            if I <> Iref then
             begin
              ErrorTrap(VALIDATENO, SubS, S, 1);
              Result := False;
              Exit;
             end;
           except
            Result := False;
            ErrorTrap(VALIDATENO, SubS, S, 1);
           end;
          end;
        end;
      end;
    end;
  end;
end;

function TMainForm.Validate7 : Boolean;
var
 I, Iref, J, K, W, Q, T, R : Integer;
 SubS, S : String;
const
 VALIDATE7MIN1 : Integer = 55;
 VALIDATE7MAX1 : Integer = 60;
 VALIDATENO : Cardinal = 7;

begin
 StatusBar1.SimpleText := 'Running Validate7';
 Update;
 Result := True;
 ProgressBar1.Max := MaxInt;
 ProgressBar1.Min := VALIDATE7MIN1;
 ProgressBar1.Max := VALIDATE7MAX1;
 for R := VALIDATE7MIN1 to VALIDATE7MAX1 do
  begin
   ProgressBar1.Position := R;
   for T := VALIDATE7MIN1 to VALIDATE7MAX1 do
    begin
     for Q := VALIDATE7MIN1 to VALIDATE7MAX1 do
      begin
       Update;
       for W := VALIDATE7MIN1 to VALIDATE7MAX1 do
        begin
         for K := VALIDATE7MIN1 to VALIDATE7MAX1 do
          begin
           for J := VALIDATE7MIN1 to VALIDATE7MAX1 do
            begin
             SubS := Char(K);
             S := Char(J) + Char(W) + Char(Q) + Char(T) + Char(R);
             Iref := PosIEx_Ref_a(SubS, S);
             try
              I := PosIExFunction(SubS, S);
              if I <> Iref then
               begin
                ErrorTrap(VALIDATENO, SubS, S, 1);
                Result := False;
                Exit;
               end;
             except
              ErrorTrap(VALIDATENO, SubS, S, 1);
              Result := False;
             end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

var
 SGlobal, SubGlobal : string;

function TMainForm.Validate8 : Boolean;
var
 I : Integer;
const
 VALIDATENO : Cardinal = 8;

begin
 StatusBar1.SimpleText := 'Running Validate8';
 Update;
 SubGlobal := 'zz';
 SGlobal := 'zz';
 (PInteger(Integer(SubGlobal)-4))^ := 0;
 I := PosIExFunction(SubGlobal, SGlobal);
 //Cannot find empty substring in string -> I must be 0
 if I = 0 then
  Result := True
 else
  begin
   ErrorTrap(VALIDATENO, SubGlobal, SGlobal, 1);
   Result := False;
  end;
end;

function TMainForm.Validate9 : Boolean;
var
 I : Integer;
const
 VALIDATENO : Cardinal = 9;

begin
 StatusBar1.SimpleText := 'Running Validate9';
 Update;
 SubGlobal := 'z';
 SGlobal := 'z';
 (PInteger(Integer(SGlobal)-4))^ := 0;
 I := PosIExFunction(SubGlobal, SGlobal);
 //Cannot find anything in empty string -> I must be 0
 if I = 0 then
  Result := True
 else
  begin
   Result := False;
   ErrorTrap(VALIDATENO, SubGlobal, SGlobal, 1);
  end;
end;

function TMainForm.Validate10 : Boolean;
var
 I : Integer;
const
 VALIDATENO : Cardinal = 10;

begin
 StatusBar1.SimpleText := 'Running Validate10';
 Update;
 SubGlobal := 'z';
 SGlobal := 'z';
 (PInteger(Integer(SGlobal)-4))^ := 0;
 (PInteger(Integer(SubGlobal)-4))^ := 0;
 I := PosIExFunction(SubGlobal, SGlobal);
 //Cannot find empty substring in empty string -> I must be 0
 if I = 0 then
  Result := True
 else
  begin
   ErrorTrap(VALIDATENO, SubGlobal, SGlobal, 1);
   Result := False;
  end;
end;

var
 GlobalStr: AnsiString;

function TMainForm.Validate11 : Boolean;
const
 VALIDATENO : Cardinal = 11;

begin
 StatusBar1.SimpleText := 'Running Validate11';
 Update;
 GlobalStr := '0';
 PInteger(Integer(GlobalStr)-4)^ := 0; {Set Length to 0}
 Result := PosIExFunction('0', GlobalStr) = 0;
 if not Result then
  begin
   ErrorTrap(VALIDATENO, '0', GlobalStr, 1);
   Exit;
  end;
 Result := PosIExFunction(GlobalStr, '0') = 0;
 if not Result then
  begin
   ErrorTrap(VALIDATENO, GlobalStr, '0', 1);
   Exit;
  end;
 Result := PosIExFunction(GlobalStr, GlobalStr) = 0;
 if not Result then
  ErrorTrap(VALIDATENO, GlobalStr, GlobalStr, 1);
end;

function TMainForm.Validate12 : Boolean;
var
 I, K : Integer;
 SubS, S : String;
const
 VALIDATE12MIN : Integer = 0;
 VALIDATE12MAX : Integer = 2550;
 VALIDATENO : Cardinal = 12;

begin
 StatusBar1.SimpleText := 'Running Validate12';
 Update;
 Result := True;
 ProgressBar1.Max := MaxInt;
 ProgressBar1.Min := VALIDATE12MIN;
 ProgressBar1.Max := VALIDATE12MAX;
 for K := VALIDATE12MIN to VALIDATE12MAX do
  begin
   ProgressBar1.Position := K;
   Update;
   try
    S := S + Char(K);
    SubS := LowerCase(S);
    I := PosIExFunction(SubS, S);
    if I <> 1 then
     begin
      ErrorTrap(VALIDATENO, SubS, S, 1);
      Result := False;
      Exit;
     end;
   except
    ErrorTrap(VALIDATENO, SubS, S, 1);
    Result := False;
   end;
  end;
end;

function TMainForm.Validate13 : Boolean;
var
 I, Iref, J, K : Integer;
 SubS, S : String;
const
 VALIDATE13MIN : Integer = 0;
 VALIDATE13MAX : Integer = 55;
 VALIDATENO : Cardinal = 13;

begin
 StatusBar1.SimpleText := 'Running Validate13';
 Update;
 Result := True;
 ProgressBar1.Max := MaxInt;
 ProgressBar1.Min := VALIDATE13MIN;
 ProgressBar1.Max := VALIDATE13MAX;
 for K := VALIDATE13MIN to VALIDATE13MAX do
  begin
   ProgressBar1.Position := K;
   Update;
   S := '';
   SubS := '';
   for J := VALIDATE13MIN to VALIDATE13MAX do
    begin
     SubS := SubS + Char(K) + Char(J) + Char(Random(255));
     S := S + SubS + Char(J);
     Iref := PosIEx_Ref_a(SubS, S);
     try
      I := PosIExFunction(SubS, S);
      if I <> Iref then
       begin
        ErrorTrap(VALIDATENO, SubS, S, 1);
        Result := False;
        Exit;
       end;
     except
      Result := False;
      ErrorTrap(VALIDATENO, SubS, S, 1);
     end;
    end;
  end;
end;

function TMainForm.Validate14 : Boolean;
var
 I, Iref, J, K : Integer;
 SubS, S : String;
 StartPos : Integer;
const
 VALIDATE14MIN : Integer = 0;
 VALIDATE14MAX : Integer = 15;
 VALIDATENO : Cardinal = 14;

begin
 StatusBar1.SimpleText := 'Running Validate14';
 Update;
 Result := True;
 ProgressBar1.Max := MaxInt;
 ProgressBar1.Min := VALIDATE14MIN;
 ProgressBar1.Max := VALIDATE14MAX;
 for K := VALIDATE14MIN to VALIDATE14MAX do
  begin
   ProgressBar1.Position := K;
   Update;
   S := '';
   SubS := '';
   for J := VALIDATE14MIN to VALIDATE14MAX do
    begin
     SubS := SubS + Char(K) + Char(J) + Char(Random(255));
     S := S + SubS + Char(J);
     for StartPos := 1 to Length(S) do
      begin
       Iref := PosIEx_Ref_a(SubS, S, StartPos);
       try
        I := PosIExFunction(SubS, S, StartPos);
        if I <> Iref then
         begin
          ErrorTrap(VALIDATENO, SubS, S, 1);
          Result := False;
          Exit;
         end;
       except
        Result := False;
        ErrorTrap(VALIDATENO, SubS, S, 1);
       end;
      end;
    end;
  end;
end;

function TMainForm.Validate15 : Boolean;
var
 I, Iref, J, K, M : Integer;
 SubS, S : String;
 StartPos : Integer;
const
 VALIDATE15MIN1 : Integer = 1;
 VALIDATE15MAX1 : Integer = 11;
 VALIDATE15MIN2 : Integer = 0;
 VALIDATE15MAX2 : Integer = 125;
 VALIDATENO : Cardinal = 15;

begin
 StatusBar1.SimpleText := 'Running Validate15';
 Update;
 Result := True;
 ProgressBar1.Max := MaxInt;
 ProgressBar1.Min := VALIDATE15MIN1;
 ProgressBar1.Max := VALIDATE15MAX1;
 for K := VALIDATE15MIN1 to VALIDATE15MAX1 do
  begin
   ProgressBar1.Position := K;
   Update;
   S := '';
   for J := VALIDATE15MIN2 to VALIDATE15MAX2 do
    begin
     SubS := '';
     for M := 1 to K do
      begin
       SubS := SubS + Char(J);
      end;
     S := S + SubS;
     for StartPos := 1 to Length(S) do
      begin
       Iref := PosIEx_Ref_a(SubS, S, StartPos);
       try
        I := PosIExFunction(SubS, S, StartPos);
        if I <> Iref then
         begin
          ErrorTrap(VALIDATENO, SubS, S, 1);
          Result := False;
          Exit;
         end;
       except
        ErrorTrap(VALIDATENO, SubS, S, 1);
        Result := False;
       end;
      end;
    end;
  end;
end;

//Run validation on all benchmark strings

function TMainForm.Validate16 : Boolean;
var
 I, Iref, J, K, Offset : Integer;
 SubS, S : String;
const
 VALIDATENO : Cardinal = 16;

begin
  StatusBar1.SimpleText := 'Running Validate16';
  Update;
  Result := True;
  for K := 0 to Length(SubStrArray)-1 do
   begin
    for J := 0 to Length(StringArray)-1 do
     begin
      for Offset := 1 to 10 do
       begin
        SubS := SubStrArray[J];
        S := StringArray[K];
        Iref := PosIEx_Ref_a(SubS, S, Offset);
        try
         I := PosIExFunction(SubS, S, Offset);
         if I <> Iref then
          begin
           ErrorTrap(VALIDATENO, SubS, S, Offset);
           Result := False;
           Exit;
          end;
        except
         ErrorTrap(VALIDATENO, SubS, S, Offset);
         Result := False;
        end;
       end;
     end;
   end;
end;

function TMainForm.Validate17 : Boolean;
                   var
 I, K : Integer;
 SubS, S : String;
const
 VALIDATE12MIN : Integer = 0;
 VALIDATE12MAX : Integer = 2550;
 VALIDATENO : Cardinal = 12;

begin
 StatusBar1.SimpleText := 'Running Validate17';
 Update;
 Result := True;
 ProgressBar1.Max := MaxInt;
 ProgressBar1.Min := VALIDATE12MIN;
 ProgressBar1.Max := VALIDATE12MAX;
 for K := VALIDATE12MIN to VALIDATE12MAX do
  begin
   ProgressBar1.Position := K;
   Update;
   try
    S := S + Char(K);
    SubS := UpperCase(S);
    I := PosIExFunction(SubS, S);
    if I <> 1 then
     begin
      ErrorTrap(VALIDATENO, SubS, S, 1);
      Result := False;
      Exit;
     end;
   except
    ErrorTrap(VALIDATENO, SubS, S, 1);
    Result := False;
   end;
  end;
end;

function TMainForm.Validate18 : Boolean;
var
 S, SubStr : AnsiString;
 I, K, Offset : Integer;
const
 VALIDATE18MAX : Integer = 2500;
 VALIDATENO : Cardinal = 18;

begin
 StatusBar1.SimpleText := 'Running Validate18';
 Update;
 Result := True;
 ProgressBar1.Max := MaxInt;
 ProgressBar1.Min := 1;
 ProgressBar1.Max := VALIDATE18MAX;
 for K := 1 to VALIDATE18MAX do
  begin
   ProgressBar1.Position := K;
   Update;
   SubStr := SubStr + Char(Random(255));
   S := SubStr;
   for Offset := 1 to Length(S) do
    begin
     try
      I := PosIExFunction(SubStr, S, Offset);
      if (Offset = 1) then
       begin
        //Always match at index 1
        if (I <> 1) then
         begin
          ErrorTrap(VALIDATENO, SubStr, S, Offset);
          Result := False;
          Exit;
         end;
       end
      else
       begin
        //Never match
        if (I <> 0) then
         begin
          ErrorTrap(VALIDATENO, SubStr, S, Offset);
          Result := False;
          Exit;
         end;
       end;
     except
      ErrorTrap(VALIDATENO, SubStr, S, Offset);
      Result := False;
     end;
    end;
  end;
end;

function TMainForm.Validate19 : Boolean;
var
 S, SubStr : AnsiString;
 I, K, Offset : Integer;
 C : Char;
const
 VALIDATE19MAX : Integer = 800;
 VALIDATENO : Cardinal = 19;

begin
 StatusBar1.SimpleText := 'Running Validate19';
 Update;
 Result := True;
 ProgressBar1.Max := MaxInt;
 ProgressBar1.Min := 1;
 ProgressBar1.Max := VALIDATE19MAX;
 for K := 1 to VALIDATE19MAX do
  begin
   ProgressBar1.Position := K;
   Update;
   C := Char(Random(255));
   if C = #0 then //StringReplace does not handle #0's
    C := 'X';
   SubStr := SubStr + C;
   C := Char(Random(255));
   if C = #0 then //StringReplace does not handle #0's
    C := 'X';
   S := S + C + C;
   //Make sure that SubStr is not present in S
   S := StringReplace(S, SubStr, '', [rfReplaceAll, rfIgnoreCase]);
   for Offset := 1 to Length(S) do
    begin
     try
      I := PosIExFunction(SubStr, S, Offset);
      //Never match
      if (I <> 0) then
       begin
        ErrorTrap(VALIDATENO, SubStr, S, Offset);
        Result := False;
        Exit;
       end;
     except
      ErrorTrap(VALIDATENO, SubStr, S, Offset);
      Result := False;
     end;
    end;
  end;
end;

function TMainForm.Validate20 : Boolean;
const
  PAGE_COUNT_SUBSTR = 1;
  PAGE_COUNT_S = 3;
  PAGE_SIZE = 4096;
  MEMBLOCK_SIZE = (PAGE_COUNT_SUBSTR+PAGE_COUNT_S+5)*PAGE_SIZE;
  S_LENGTH = PAGE_COUNT_S*PAGE_SIZE-8;
  SUBSTR_LENGTH = PAGE_COUNT_SUBSTR*PAGE_SIZE-8;
var
  Dummy, MemBlockPageF, MemBlockPageL, MemBlockPageM,
    MemBlockPageS, MemBlockPageSS : LongWord;
  I: Integer;
  MemBlock: Pointer;
  SubStr, S: PChar;

begin
  StatusBar1.SimpleText := 'Running Validate20';
  Update;
  Result := False;
  GetMem(MemBlock, MEMBLOCK_SIZE);
  try
    // Calculate page addresses: first, substr, middle, s, last
    MemBlockPageF  := (LongWord(MemBlock) or (PAGE_SIZE-1))+1;
    MemBlockPageSS := MemBlockPageF  + PAGE_SIZE;
    MemBlockPageM  := MemBlockPageSS + PAGE_COUNT_SUBSTR*PAGE_SIZE;
    MemBlockPageS  := MemBlockPageM  + PAGE_SIZE;
    MemBlockPageL  := MemBlockPageS  + PAGE_COUNT_S*PAGE_SIZE;

    // Initialize SubStr pointer and write length and characters
    SubStr := PChar(MemBlockPageSS + 8);
    PLongWord(MemBlockPageSS + 0)^ := $FFFFFFFF; // Ref count -1
    PLongWord(MemBlockPageSS + 4)^ := SUBSTR_LENGTH;
    for I := 0 to SUBSTR_LENGTH-1 do
      PChar(MemBlockPageSS + 8 + LongWord(I))^ := Char(I and $FF);

    // Initialize S pointer and write length and characters
    S := PChar(MemBlockPageS + 8);
    PLongWord(MemBlockPageS + 0)^ := $FFFFFFFF; // Ref count -1
    PLongWord(MemBlockPageS + 4)^ := S_LENGTH;
    for I := 0 to S_LENGTH-1 do
      PChar(MemBlockPageS + 8 + LongWord(I))^ := Char((-I) and $FF);

    try
      // Mark first, middle and last pages as no access, allow only
      // reading from the strings themselves
      Win32Check(VirtualProtect(Pointer(MemBlockPageF), PAGE_SIZE,
        PAGE_NOACCESS, Dummy));
      Win32Check(VirtualProtect(Pointer(MemBlockPageM), PAGE_SIZE,
        PAGE_NOACCESS, Dummy));
      Win32Check(VirtualProtect(Pointer(MemBlockPageL), PAGE_SIZE,
        PAGE_NOACCESS, Dummy));
      Win32Check(VirtualProtect(SubStr, PAGE_COUNT_SUBSTR*PAGE_SIZE,
        PAGE_READONLY, Dummy));
      Win32Check(VirtualProtect(S, PAGE_COUNT_S*PAGE_SIZE,
        PAGE_READONLY, Dummy));

      try
        asm
          mov    eax,   SubStr
          mov    edx,   S
          mov    ecx,   1
          call   PosIExFunction
        end;
        Result := True;
      except
        // Ignore exception; Result is False by default
      end;

    finally
      // Restore permissions before deallocation
      Win32Check(VirtualProtect(MemBlock, MEMBLOCK_SIZE,
        PAGE_EXECUTE_READWRITE, Dummy));
    end;
  finally
    FreeMem(MemBlock);
  end;
end;

function TMainForm.Validate21 : Boolean;
var
 S : AnsiString;
 I, K, Offset : Integer;
const
 VALIDATE21MAX : Integer = 3500;
 VALIDATENO : Cardinal = 18;

begin
 StatusBar1.SimpleText := 'Running Validate21';
 Update;
 Result := True;
 ProgressBar1.Max := MaxInt;
 ProgressBar1.Min := 1;
 ProgressBar1.Max := VALIDATE21MAX;
 for K := 1 to VALIDATE21MAX do
  begin
   ProgressBar1.Position := K;
   Update;
   S := S + Char(Random(255));
   for Offset := 1 to Length(S) do
    begin
     try
      I := PosIExFunction(S, S, Offset);
      if (Offset = 1) then
       begin
        //Always match at index 1
        if (I <> 1) then
         begin
          ErrorTrap(VALIDATENO, S, S, Offset);
          Result := False;
          Exit;
         end;
       end
      else
       begin
        //Never match
        if (I <> 0) then
         begin
          ErrorTrap(VALIDATENO, S, S, Offset);
          Result := False;
          Exit;
         end;
       end;
     except
      ErrorTrap(VALIDATENO, S, S, Offset);
      Result := False;
     end;
    end;
  end;
end;

function IsUpperCase(C : char) : Boolean;
begin
 if ('A' <= C) and (C <= 'Z') then
  Result := True
 else
  Result := false;
end;

function CharLowerCase(C : Char) : Char;
begin
 if ('A' <= C) and (C <= 'Z') then
  Result := Char(Ord(C) + 32)
 else
  Result := C;
end;

function CharUpperCase(C : Char) : Char;
begin
 if ('a' <= C) and (C <= 'z') then
  Result := Char(Ord(C) - 32)
 else
  Result := C;
end;

function InvertCase(C : Char) : Char; overload;
begin
 if IsUpperCase(C) then
  Result := CharLowerCase(C)
 else
  Result := CharUpperCase(C);
end;

function InvertCase(S : AnsiString) : AnsiString; overload;
var
 I: Integer;

begin
 Result := '';
 for I := 1 to Length(S) do
  begin
   Result := Result + InvertCase(S[I])
  end;
end;

//Used in benchmark

procedure TMainForm.FillBenchmarkStringArrays;
var
 S, Sinv : AnsiString;
 I, J : Integer;

begin
 //Allocate "enough" space
 SetLength(SubStrArray,200);
 SetLength(StringArray,200);
 //Subbenchmark 1 strings
 J := 0;
 SubStrArray[J]  := '';
 StringArray[J]  := '';
 Inc(J);
 SubStrArray[J]  := '';
 StringArray[J]  := 'x';
 Inc(J);
 SubStrArray[J]  := '';
 StringArray[J]  := 'X';
 Inc(J);
 SubStrArray[J]  := 'x';
 StringArray[J]  := '';
 Inc(J);
 SubStrArray[J]  := 'X';
 StringArray[J]  := '';
 Inc(J);
 SubStrArray[J]  := 'A';
 StringArray[J]  := 'B';
 Inc(J);
 SubStrArray[J]  := '1';
 StringArray[J]  := '2';
 Inc(J);
 SubStrArray[J]  := 'a';
 StringArray[J]  := 'B';
 Inc(J);
 SubStrArray[J]  := 'a';
 StringArray[J]  := 'b';
 Inc(J);
 SubStrArray[J]  := 'A';
 StringArray[J]  := 'b';
 Inc(J);
 SubStrArray[J]  := 'A';
 StringArray[J]  := 'BA';
 Inc(J);
 SubStrArray[J]  := 'a';
 StringArray[J]  := 'BA';
 Inc(J);
 SubStrArray[J]  := 'a';
 StringArray[J]  := 'ba';
 Inc(J);
 SubStrArray[J]  := 'a';
 StringArray[J]  := 'BA';
 Inc(J);
 SubStrArray[J]  := 'AB';
 StringArray[J]  := 'AB';
 Inc(J);
 SubStrArray[J]  := '12';
 StringArray[J]  := '12';
 Inc(J);
 SubStrArray[J]  := 'ab';
 StringArray[J]  := 'ab';
 Inc(J);
 SubStrArray[J]  := 'x';
 StringArray[J]  := 'ab';
 Inc(J);
 SubStrArray[J]  := 'X';
 StringArray[J]  := 'ab';
 Inc(J);
 SubStrArray[J]  := 'X';
 StringArray[J]  := 'AB';
 Inc(J);
 SubStrArray[J]  := 'x';
 StringArray[J]  := 'AB';
 Inc(J);
 SubStrArray[J]  := 'x';
 StringArray[J]  := 'abc';
 Inc(J);
 SubStrArray[J]  := '4';
 StringArray[J]  := '123';
 Inc(J);
 SubStrArray[J]  := 'X';
 StringArray[J]  := 'ABC';
 Inc(J);
 SubStrArray[J]  := 'c';
 StringArray[J]  := 'abc';
 Inc(J);
 SubStrArray[J]  := 'C';
 StringArray[J]  := 'ABC';
 Inc(J);
 SubStrArray[J]  := 'x';
 StringArray[J]  := 'abcde';
 Inc(J);
 SubStrArray[J]  := '8';
 StringArray[J]  := '12345';
 Inc(J);
 SubStrArray[J]  := 'X';
 StringArray[J]  := 'ABCDE';
 Inc(J);
 SubStrArray[J]  := 'e';
 StringArray[J]  := 'abcde';
 Inc(J);
 SubStrArray[J]  := 'e';
 StringArray[J]  := 'ABcde';
 Inc(J);
 SubStrArray[J]  := 'de';
 StringArray[J]  := 'abcde';
 Inc(J);
 SubStrArray[J]  := 'DE';
 StringArray[J]  := 'AbcDE';
 Inc(J);
 SubStrArray[J]  := 'x';
 StringArray[J]  := 'abcdef';
 Inc(J);
 SubStrArray[J]  := 'def';
 StringArray[J]  := 'abcdef';
 Inc(J);
 SubStrArray[J]  := '456';
 StringArray[J]  := '123456';
 Inc(J);
 SubStrArray[J]  := 'DEF';
 StringArray[J]  := 'abcdef';
 Inc(J);
 SubStrArray[J]  := 'DEF';
 StringArray[J]  := 'abcdefhjyttredsdfr';
 Inc(J);
 SubStrArray[J]  := 'def';
 StringArray[J]  := 'abcdefg';
 Inc(J);
 SubStrArray[J]  := 'def';
 StringArray[J]  := 'DEFabcdefghgtrfdews';
 Inc(J);
 SubStrArray[J]  := 'f';
 StringArray[J]  := 'abcdef';
 Inc(J);
 SubStrArray[J]  := 'f';
 StringArray[J]  := 'ABCDEef';
 Inc(J);
 SubStrArray[J]  := 'f';
 StringArray[J]  := 'abcdefghij';
 Inc(J);
 SubStrArray[J]  := 'x';
 StringArray[J]  := 'abcdefg';
 Inc(J);
 SubStrArray[J]  := 'g';
 StringArray[J]  := 'abcdefg';
 Inc(J);
 SubStrArray[J]  := 'aa';
 StringArray[J]  := 'bbcc';
 Inc(J);
 SubStrArray[J]  := 'AA';
 StringArray[J]  := 'BBCC';
 Inc(J);
 SubStrArray[J]  := 'ab';
 StringArray[J]  := 'ABCab';
 Inc(J);
 SubStrArray[J]  := 'ABCDEFG';
 StringArray[J]  := 'ABCDEFG';
 Inc(J);
 SubStrArray[J]  := 'abcdefg';
 StringArray[J]  := 'ABCDEFG';
 Inc(J);
 SubStrArray[J]  := 'ABCDEFGH';
 StringArray[J]  := 'ABCDEFGH';
 Inc(J);
 SubStrArray[J]  := 'ABCDEFGH';
 StringArray[J]  := 'abcdefgh';
 Inc(J);
 SubStrArray[J]  := 'ABCDEFGHI';
 StringArray[J]  := 'ABCDEFGHI';
 Inc(J);
 SubStrArray[J]  := 'abcdefghi';
 StringArray[J]  := 'abcdefghi';
 Inc(J);
 SubStrArray[J]  := 'ABCDEFGHIJ';
 StringArray[J]  := 'ABCDEFGHIJ';
 Inc(J);
 SubStrArray[J]  := 'abcdefghij';
 StringArray[J]  := 'abcdefghij';
 Inc(J);
 SubStrArray[J]  := 'ABCDEFGHIJG';
 StringArray[J]  := 'ABCDEFGHIJG';
 Inc(J);
 SubStrArray[J]  := 'abcdefghijk';
 StringArray[J]  := 'abcdefghijk';
 Inc(J);
 SubStrArray[J]  := 'ABCDEFGHIJGK';
 StringArray[J]  := 'ABCDEFGHIJGK';
 Inc(J);
 SubStrArray[J]  := 'abcdefghijk';
 StringArray[J]  := 'abcdefghijk';
 Inc(J);
 SubStrArray[J]  := 'ABCDEFGHIJGKL';
 StringArray[J]  := 'ABCDEFGHIJGKL';
 Inc(J);
 SubStrArray[J]  := 'abcdefghijkl';
 StringArray[J]  := 'abcdefghijkl';
 Inc(J);
 SubStrArray[J]  := 'ABCDEFGHIJGK';
 StringArray[J]  := 'ABCDEFGHIJGKL';
 Inc(J);
 SubStrArray[J]  := 'abcdefghijkl';
 StringArray[J]  := 'mmmabcdefghijkl';
 Inc(J);
 SubStrArray[J]  := '1234567890';
 StringArray[J]  := 'aaaaaaaaa1234567890aaaaaaa';
 Inc(J);
 SubStrArray[J]  := 'BCDEFGHIJGK';
 StringArray[J]  := 'ABCDEFGHIJGKL';
 Inc(J);
 SubStrArray[J]  := 'abcdefghyuikl';
 StringArray[J]  := 'qqqqqqqqabcdefghyuiklqqqqqqqq';
 Inc(J);
 SubStrArray[J]  := 'BCDEFGHIJG';
 StringArray[J]  := 'ABCDEFGHIJGKL';
 Inc(J);
 SubStrArray[J]  := '&&&&&&&&';
 StringArray[J]  := 'aaa&&&&&&&bbbbbb&&&&&&&&qqq';
 Inc(J);
 SubStrArray[J]  := 'CDEFGHIJG';
 StringArray[J]  := 'ABCDEFGHIJGKL';
 Inc(J);
 SubStrArray[J]  := '1234';
 StringArray[J]  := '999999999999999999991234567';
 Inc(J);
 SubStrArray[J]  := 'CDEFGHIJ';
 StringArray[J]  := 'ABCDEFGHIJGKL';
 Inc(J);
 SubStrArray[J]  := 'cdefghij';
 StringArray[J]  := 'ABCDEFGHIJGKL';
 Inc(J);
 SubStrArray[J]  := 'DEFGHIJ';
 StringArray[J]  := 'ABCDEFGHIJGKL';
 Inc(J);
 SubStrArray[J]  := 'defghij';
 StringArray[J]  := 'abcdefghijkl';
 Inc(J);
 SubStrArray[J]  := 'DEFGHI';
 StringArray[J]  := 'ABCDEFGHIJGKL';
 Inc(J);
 SubStrArray[J]  := 'defghi';
 StringArray[J]  := 'abcdefghijkl';
 Inc(J);
 SubStrArray[J]  := 'EFGHI';
 StringArray[J]  := 'ABCDEFGHIJGKL';
 Inc(J);
 SubStrArray[J]  := 'efghi';
 StringArray[J]  := 'ABCDEFGHIJGKL';
 Inc(J);
 SubStrArray[J]  := '123456789';
 StringArray[J]  := '123456789';
 Inc(J);
 SubStrArray[J]  := 'EFGH';
 StringArray[J]  := 'ABCDEFGHIJGKL';
 Inc(J);
 SubStrArray[J]  := 'EFGH';
 StringArray[J]  := 'abcdefghijklmnop';
 Inc(J);
 SubStrArray[J]  := 'bcd';
 StringArray[J]  := 'abcd';
 Inc(J);
 SubStrArray[J]  := 'xxx';
 StringArray[J]  := 'abcde';
 Inc(J);
 SubStrArray[J]  := 'efg';
 StringArray[J]  := 'xxxxxxabcdefg';
 Inc(J);
 SubStrArray[J]  := 'yyy';
 StringArray[J]  := 'xxxxxxxabcdefg';
 Inc(J);
 SubStrArray[J]  := 'cd';
 StringArray[J]  := 'xxxxxxxxabcdefg';
 Inc(J);
 SubStrArray[J]  := 'yy';
 StringArray[J]  := 'xxxxxxxxabcdefg';
 Inc(J);
 SubStrArray[J]  := 'a';
 StringArray[J]  := 'abcdefg';
 Inc(J);
 SubStrArray[J]  := 'b';
 StringArray[J]  := 'abcdefg';
 Inc(J);
 SubStrArray[J]  := 'e';
 StringArray[J]  := 'abcdefg';
 Inc(J);
 SubStrArray[J]  := 'f';
 StringArray[J]  := 'abcdefg';
 Inc(J);
 SubStrArray[J]  := 'ef';
 StringArray[J]  := 'exexexexexef';
 Inc(J);
 SubStrArray[J]  := 'ab';
 StringArray[J]  := 'abcdefg';
 Inc(J);
 SubStrArray[J]  := 'bc';
 StringArray[J]  := 'abcdefg';
 Inc(J);
 SubStrArray[J]  := 'bc';
 StringArray[J]  := 'abdacdabdacdacdabcdefghijklmnopqrstuvw';
 Inc(J);
 SubStrArray[J]  := 'efg';
 StringArray[J]  := 'abcdefg';
 Inc(J);
 SubStrArray[J]  := 'fFDSDSDFG';
 StringArray[J]  := 'VDGHFGTTGhhfyrijjjsffFDSDSDFGGF8765453';
 Inc(J);
 SubStrArray[J]  := 'tryhfgd';
 StringArray[J]  := 'jdhdftwegdghgjkhgutryhfgdfwqedsdgd';
 Inc(J);
 SubStrArray[J]  := 'efg';
 StringArray[J]  := 'efefefefgef';
 Inc(J);
 SubStrArray[J]  := 'c.6';
 StringArray[J]  := 'Woman';
 Inc(J);
 SubStrArray[J]  := 'efg';
 StringArray[J]  := 'abcdefg';
 Inc(J);
 SubStrArray[J]  := 'efg';
 StringArray[J]  := 'xxxxxxxxxabcdefg';
 Inc(J);
 SubStrArray[J]  := 'Object';
 StringArray[J]  := 'DelphiObjectPascal';
 Inc(J);
 SubStrArray[J]  := 'e';
 StringArray[J]  := 'xxxxxxxxxxxxxxxxxxxx';
 Inc(J);
 SubStrArray[J]  := 'o W';
 StringArray[J]  := 'Hello World';
 Inc(J);
 SubStrArray[J]  := 'ey';
 StringArray[J]  := 'xxxexxxexxxxexxxxxxxxexx';
 Inc(J);
 SubStrArray[J]  := 'EY';
 StringArray[J]  := 'XXXeXXXXxxxEUDCFGreDFGGHGeyXXXXXEYhjsfjshfshgfGFGFGF';
 Inc(J);
 SubStrArray[J]  := 'ey';
 StringArray[J]  := 'xxxexxxexxxxexxxxxxxxxxxey';
 Inc(J);
 SubStrArray[J]  := 'ens';
 StringArray[J]  := 'Dennis Kjaer Christensen';
 Inc(J);
 SubStrArray[J]  := 'ENS';
 StringArray[J]  := 'Dennis Kjaer Christensen';
 Inc(J);
 SubStrArray[J]  := 'ObjectPascalCox';
 StringArray[J]  := 'DelphiObjectPascalCompilerInlineAssembler';
 Inc(J);
 SubStrArray[J] := 'language';
 StringArray[J]  := 'Pascal is a wonderfull programming language';
 Inc(J);
 SubStrArray[J] := 'LANGUAGE';
 StringArray[J]  := 'Pascal is a wonderfull programming language';
 Inc(J);
 SubStrArray[J] := 'TTTTTT';
 StringArray[J]  := 'A cow jumps over a pig because it is lazy etc.';
 Inc(J);
 SubStrArray[J] := 'ebcdefg';
 StringArray[J]  := 'ebcdefebcdefebcdefebcdefebcdefgebcdefebcdefebcdef';
 Inc(J);
 SubStrArray[J] := '111111111';
 StringArray[J] := '222222222222222222222222222222222111111111111111111112222222222222222';
 Inc(J);
 SubStrArray[J] := 'htyg';
 StringArray[J] := 'AaAaAAaAaAaAaAAaAAaAAaAaaaaaAaaAAAAaaAAaAaAAaahtygCfdRewff';
 Inc(J);
 SubStrArray[J] := '1re dgfDG';
 StringArray[J] := 'ABCDEFGHIJQRSLPYTESD!"#¤%&//())=?`¨-.,~|}][{$£@½§abcdefghijklmnopqrst+uvw';
 Inc(J);
 SubStrArray[J] := '33333333';
 StringArray[J] := '111112345667789087654333566712345678903333333333333312468900000000000000000';
 Inc(J);
 SubStrArray[J] := 'file';
 StringArray[J] := 'cfsrjilchwe6384582c0rsor+02807fXEA#"!#&P=(=NJ CW#GYIYR/R&VRDES45x21a1re dgfDGDGHHHHHHH';
 Inc(J);
 SubStrArray[J] := 'GHHHHHHH';
 StringArray[J] := 'cfsrjiGDRtyr5413276in9pn  GFYFYt tr6544221YFHTTTTTTTTDDDWWWWfkjcsefkwhn,mnfvgnhgbjrcsfhbvajfWorldlchwe6384582c0rsor+02807fXEA#"!#&P=(=NJ CW#GYIYR/R&VRDES45x21a1re dgfDGDGHHHHHHH';
 Inc(J);
 SubStrArray[J] := 'The CONTENTS of this email and the attached file are for your exclusive use and should not be shared with others';
 StringArray[J] := 'The contents of this email and the attached file are for your exclusive use and should not be shared with others';
 Inc(J);
 SubStrArray[J] := 'The contents of this email and the attached file are for your exclusive use and should not be shared with others';
 StringArray[J] := 'XThe contents of this EMAIL and the attached file are for your exclusive use and should not be shared with others';
 Inc(J);
 SubStrArray[J] := 'The contents of this email and the ATTACHED file are for your exclusive use and should not be shared with others The contents of this email and the attached file are for your exclusive use and should not be shared with others';
 StringArray[J] := 'XThe contents of this email and the attached file are for your exclusive use and should not be shared with others XThe contents of this email and the attached file are for your exclusive use and should not be shared with others';
 Inc(J);
 SubStrArray[J] := 'ABC';
 StringArray[J] := 'ABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABX';
 Inc(J);
 SubStrArray[J] := 'abc';
 StringArray[J] := 'abxABXABXABXABXABXabxABXABXABXABXabxABXABXABXABXabxABXABXABXABXABXABXABXABXabxABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABXABX';
 Inc(J);
 SubStrArray[J] := 'ABCDEFG';
 StringArray[J] := 'xxxxCDEFABCDEfabCDEFABCDEFABCDEFabcDEFABCdefABCDEFabcDEFABCDEFABCDEFabcdefABCDEFABCdefABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDefg';
 Inc(J);
 SubStrArray[J] := 'ABCDEFGHIJ';
 StringArray[J] := 'ABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIJ';
 Inc(J);
 SubStrArray[J] := 'abcdefghij';
 StringArray[J] := 'abCDEFghIABCdefGHIABcdefGHIABCDEFGHIabcdefGHIABCDEFGHIABCDEFGHIABCDEFGHIabcdefghiABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIJ';
 Inc(J);
 SubStrArray[J] := 'ABCdefGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIAB';
 StringArray[J] := 'ABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIJ';
 Inc(J);
 SubStrArray[J] := 'abcdefghijklmnopqrs';
 StringArray[J] := 'abcDEFGHIABCabcdefghijklmnopqrsCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDEFGHIABCDFGHIAadsfwgtryujgjkotjhgdqerwdfstgrhyjuikhjhtfgefdrrwhh';
 Inc(J);
 SubStrArray[J] := '1111111111111111111111111111111';
 StringArray[J] := '33333333332222222222222222222222222222222222111111111111111111111111111111199999999999999999999999';
 Inc(J);
 SubStrArray[J] := '?????????????????????';
 StringArray[J] := '3333333333222222222??2222222222222222222222211111111111111111111111111111119999999?????????????????????';
 Inc(J);
 SubStrArray[J] := 'ABCDEFGhijKLMNOPQRSTUVWXYZ';
 StringArray[J] := 'lhfgRgjfjrt424189GVGDg65klækloytysweaweq1234sgfcnbjhg%¤%¤YVJVFHS#DSWERFHJOUYFDEQA"!E/&())JLPJVGDCXXSNBVCXDAZSERTGBAFDSVXXDAZDSAABCDEFGHIJKLMNOPQRSTUVWXYZ';
 SetLength(S, 255);
 for I := 1 to 255 do
 begin
  if Char(I) <> 'X' then
   S[I] := Char(I)
  else
   S[I] := 'W'
 end;
 Inc(J);
 SubStrArray[J] := 'XYZWQABGH';
 StringArray[J] := S + S + S + S + S + S + S + S + S + 'XYZWQABGH';
 Inc(J);
 SubStrArray[J] := S + S + 'XYZ';
 StringArray[J] := S + S + S + S + S + S + S + S + S + 'XYZWQABGH';
 Inc(J);
 Sinv := InvertCase(S);
 SubStrArray[J] := 'XYZWQABGH';
 StringArray[J] := Sinv + Sinv + Sinv + Sinv + Sinv + Sinv + Sinv + Sinv + Sinv + 'XYZWQABGH';
 Inc(J);
 SubStrArray[J] := Sinv + Sinv + 'XYZ';
 StringArray[J] := Sinv + Sinv + Sinv + Sinv + Sinv + Sinv + Sinv + Sinv + Sinv + 'XYZWQABGH';
 //Benchmark outer loop
 Inc(J);
 SubStrArray[J] := 'AAAA';
 StringArray[J] := 'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB';
 Inc(J);
 SubStrArray[J] := 'aaaa';
 StringArray[J] := 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb';
 Inc(J);
 SubStrArray[J] := 'AA';
 StringArray[J] := 'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB';
 Inc(J);
 SubStrArray[J] := 'aa';
 StringArray[J] := 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb';
 Inc(J);
 SubStrArray[J] := '11';
 StringArray[J] := '2222222222222222222222222222222222222222222222222222222222222222222222222222222';
 Inc(J);
 SubStrArray[J] := '11111';
 StringArray[J] := '2222222222222222222222222222222222222222222222222222222222222222222222222222222221111111';
 //Benchmark inner loop
 Inc(J);
 SubStrArray[J] := 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
 StringArray[J] := 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
 Inc(J);
 SubStrArray[J] := 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
 StringArray[J] := 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
 Inc(J);
 SubStrArray[J] := '11111111111111111111111111111111111111111111111111111111111111111111111111111111111';
 StringArray[J] := '11111111111111111111111111111111111111111111111111111111111111111111111111111111111';
 Inc(J);
 SubStrArray[J] := '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!';
 StringArray[J] := '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!';
 //Benchmark CharPosIEx
 Inc(J);
 SubStrArray[J] := '9';
 StringArray[J] := '11111111111111111111111111111111111111111111111119';
 Inc(J);
 SubStrArray[J] := '19';
 StringArray[J] := '111111111111111111111111111111111111111111111111111111111119';
 Inc(J);
 SubStrArray[J] := '191';
 StringArray[J] := '111111111111111111111111111111111111111111111111111111111111111191111111';
 Inc(J);
 SubStrArray[J] := 'AB';
 StringArray[J] := 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB';
 Inc(J);
 SubStrArray[J] := 'bfgtra';
 StringArray[J] := 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabfgtraaaaaa';
 Inc(J);
 SubStrArray[J] := 'BAVHjytfDe';
 StringArray[J] := 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABABAVHjytfDeaaaa';
 Inc(J);
 SubStrArray[J] := 'b';
 StringArray[J] := 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaba';
 Inc(J);
 SubStrArray[J] := 'BC';
 StringArray[J] := 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABCAA';
 Inc(J);
 SubStrArray[J] := 'bc';
 StringArray[J] := 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabcaa';
 Inc(J);
 SubStrArray[J] := 'Bx';
 StringArray[J] := 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABXAAA';
 Inc(J);
 SubStrArray[J] := 'bXYX';
 StringArray[J] := 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabXYXaaa';
 //Jump from outerloop to innerloop and back many times
 Inc(J);
 SubStrArray[J] := 'ABCDEF';
 StringArray[J] := 'ABCDEABCDEABCDEABCDEABCDEABCDEABCDEABCDEABCDEABCDEABCDEABCDEABCDEABCDEABCDEABCDEABCDEF';
 Inc(J);
 SubStrArray[J] := 'abcdef';
 StringArray[J] := 'abcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdeabcdef';
 Inc(J);
 SubStrArray[J] := '12345';
 StringArray[J] := '123412341234123412341234123412341234123412341234123412341234123412341234123412312312312121212345';
 Inc(J);
 SubStrArray[J] := 'ABCDEFGHIJ';
 StringArray[J] := 'AABabCABCDABCDEABCdefABCDEFGABCDEFGHABCDEFGHxIABCDEfghxIABCDEFxGHIABCDxEFGHIABCDEFGHIJxxxxxxxxxxxxxxxxx';
 Inc(J);
 SubStrArray[J] := 'abcdefghijkl';
 StringArray[J] := 'zzzzzzzzzzzzzzzzabcdefghijkabcdefghijkabcdefghijkabcdefghijkabcdefghijkabcdefghijkabcdefghijkabcdefghijkabcdefghijk';
 //Adjust array sizes
 SetLength(SubStrArray,J+1);
 SetLength(StringArray,J+1);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var CpuString : string;
begin
 ClearAllEditBoxes;
 ReportRichEdit.Clear;
 ReportRichEdit.Paragraph.TabCount := 4;
 ReportRichEdit.Paragraph.Tab[0] := 95;
 ReportRichEdit.Paragraph.Tab[1] := 125;
 ReportRichEdit.Paragraph.Tab[2] := 170;
 ReportRichEdit.Paragraph.Tab[3] := 225;
 FillBenchmarkStringArrays;;
 FunctionSelectionRadioGroupClick(nil);
 FillTestSetArray;
 if not QueryPerformanceFrequency(Frequency) then
  raise Exception.Create('QueryPerformanceFrequency failed');
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

begin
 RunAllBenchmarksButton.Caption := 'Running';
 Update;
 //for I1 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 for I1 := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I1;
   BenchmarkPosIEx;
   BenchmarkTest;
   AlignmentTest;
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
  0 : PosIExFunction := PosIEx_Ref_a;
  1 : PosIExFunction := PosIEx_Ref_b;
  2 : PosIExFunction := PosIEx_Ref_c;
  3 : PosIExFunction := PosIEx_Ref_d;
  4 : PosIExFunction := PosIEx_DKC_Pas_16_a;
  5 : PosIExFunction := PosIEx_DKC_Pas_16_b;
  6 : PosIExFunction := PosIEx_DKC_Pas_16_c;
  7 : PosIExFunction := PosIEx_DKC_Pas_16_d;
  8 : PosIExFunction := PosIEx_DKC_Pas_18_a;
  9 : PosIExFunction := PosIEx_DKC_Pas_18_b;
  10 : PosIExFunction := PosIEx_DKC_Pas_18_c;
  11 : PosIExFunction := PosIEx_DKC_Pas_18_d;
  12 : PosIExFunction := PosIEx_DKC_IA32_5_a;
  13 : PosIExFunction := PosIEx_DKC_IA32_5_b;
  14 : PosIExFunction := PosIEx_DKC_IA32_5_c;
  15 : PosIExFunction := PosIEx_DKC_IA32_5_d;
  16 : PosIExFunction := PosIEx_DKC_IA32_11_a;
  17 : PosIExFunction := PosIEx_DKC_IA32_11_b;
  18 : PosIExFunction := PosIEx_DKC_IA32_11_c;
  19 : PosIExFunction := PosIEx_DKC_IA32_11_d;
  20 : PosIExFunction := PosIEx_DKC_IA32_12_a;
  21 : PosIExFunction := PosIEx_DKC_IA32_12_b;
  22 : PosIExFunction := PosIEx_DKC_IA32_12_c;
  23 : PosIExFunction := PosIEx_DKC_IA32_12_d;
  24 : PosIExFunction := PosIEx_DKC_MMX_5_a;
  25 : PosIExFunction := PosIEx_DKC_MMX_5_b;
  26 : PosIExFunction := PosIEx_DKC_MMX_5_c;
  27 : PosIExFunction := PosIEx_DKC_MMX_5_d;
  28 : PosIExFunction := PosIEx_JOH_IA32_1_a;
  29 : PosIExFunction := PosIEx_JOH_IA32_1_b;
  30 : PosIExFunction := PosIEx_JOH_IA32_1_c;
  31 : PosIExFunction := PosIEx_JOH_IA32_1_d;
  32 : PosIExFunction := PosIEx_DKC_MMX_6_a;
  33 : PosIExFunction := PosIEx_DKC_MMX_6_b;
  34 : PosIExFunction := PosIEx_DKC_MMX_6_c;
  35 : PosIExFunction := PosIEx_DKC_MMX_6_d;
  36 : PosIExFunction := PosIEx_DKC_MMX_7_a;
  37 : PosIExFunction := PosIEx_DKC_IA32_13_a;
  38 : PosIExFunction := PosIEx_DKC_IA32_13_b;
  39 : PosIExFunction := PosIEx_DKC_IA32_13_c;
  40 : PosIExFunction := PosIEx_DKC_IA32_13_d;
  41 : PosIExFunction := PosIEx_DKC_Pas_19_a;
  42 : PosIExFunction := PosIEx_DKC_Pas_19_b;
  43 : PosIExFunction := PosIEx_DKC_Pas_19_c;
  44 : PosIExFunction := PosIEx_DKC_Pas_19_d;
  45 : PosIExFunction := PosIEx_DKC_Pas_20_a;
  46 : PosIExFunction := PosIEx_DKC_Pas_20_b;
  47 : PosIExFunction := PosIEx_DKC_Pas_20_c;
  48 : PosIExFunction := PosIEx_DKC_Pas_20_d;
  49 : PosIExFunction := PosIEx_DKC_Pas_21_a;
  50 : PosIExFunction := PosIEx_DKC_Pas_21_b;
  51 : PosIExFunction := PosIEx_DKC_Pas_21_c;
  52 : PosIExFunction := PosIEx_DKC_Pas_21_d;
  53 : PosIExFunction := PosIEx_DKC_Pas_22_a;
  54 : PosIExFunction := PosIEx_DKC_Pas_22_b;
  55 : PosIExFunction := PosIEx_DKC_Pas_22_c;
  56 : PosIExFunction := PosIEx_DKC_Pas_22_d;
  57 : PosIExFunction := PosIEx_DKC_Pas_23_a;
  58 : PosIExFunction := PosIEx_DKC_Pas_23_b;
  59 : PosIExFunction := PosIEx_DKC_Pas_23_c;
  60 : PosIExFunction := PosIEx_DKC_Pas_23_d;
  61 : PosIExFunction := PosIEx_DKC_Pas_24_a;
  62 : PosIExFunction := PosIEx_DKC_Pas_24_b;
  63 : PosIExFunction := PosIEx_DKC_Pas_24_c;
  64 : PosIExFunction := PosIEx_DKC_Pas_24_d;
  65 : PosIExFunction := PosIEx_DKC_Pas_25_a;
  66 : PosIExFunction := PosIEx_DKC_Pas_25_b;
  67 : PosIExFunction := PosIEx_DKC_Pas_25_c;
  68 : PosIExFunction := PosIEx_DKC_Pas_25_d;
  69 : PosIExFunction := PosIEx_DKC_Pas_26_a;
  70 : PosIExFunction := PosIEx_DKC_Pas_26_b;
  71 : PosIExFunction := PosIEx_DKC_Pas_26_c;
  72 : PosIExFunction := PosIEx_DKC_Pas_26_d;
 else
  raise Exception.Create('Invalid function number');
 end;
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I : Integer;
 FunctionName, PosIExFunctionAddressString : AnsiString;
 PosIExFunctionAddress : Cardinal;

begin
 ValidateAllButton.Caption := 'Running';
 //for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 for I := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
   PosIExFunctionAddress := Integer(@PosIExFunction);
   PosIExFunctionAddressString := IntToHex(PosIExFunctionAddress, 8);
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
       Validate17 and
       Validate18 and
       Validate19 and
       Validate20 and
       Validate21 then
     ReportRichEdit.Lines.Add(FunctionName + #9 + PosIExFunctionAddressString[8] + #9 + 'Passed')
    else
     ReportRichEdit.Lines.Add(FunctionName + #9 + PosIExFunctionAddressString[8] + #9 + 'Failed');
    Update;
   except
    ReportRichEdit.Lines.Add(FunctionName + #9 + PosIExFunctionAddressString[8] + #9 + 'Failed');
   end;
  end;
 StatusBar1.SimpleText := 'Validate All Completed';
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
 ReportRichEdit.Print('PosIEx Benchmark Results');
end;

procedure TMainForm.BenchTestButtonClick(Sender: TObject);
var
 I1 : Cardinal;

begin
 BenchTestButton.Caption := 'Running';
 Update;
 for I1 := 0 to 5 do
  RunAllBenchmarksButtonClick(nil);
 BenchTestButton.Caption := 'Bench Test';
end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
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
   FunctionAddress := Cardinal(@PosIExFunction);
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

procedure TMainForm.TestCaseButtonClick(Sender: TObject);
var
 I1 : Integer;

begin
 TestCaseButton.Caption := 'Running';
 Update;
 for I1 := 4 to 11 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I1;
   BenchmarkPosIEx;
   BenchmarkTest;
   AlignmentTest;
   if ReportRichEdit.Lines.Count > 1 then
    SortRichEdit;
  end;
 TestCaseButton.Caption := 'Run All';
end;

procedure TMainForm.AboutSpeedButtonClick(Sender: TObject);
begin
 AboutForm.ShowModal;
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
