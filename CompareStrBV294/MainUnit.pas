unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'CompareStr';

type
  TMainForm = class(TForm)
    ValidateButton: TButton;
    ValidEdit: TEdit;
    Label1: TLabel;
    FunctionSelectionRadioGroup: TRadioGroup;
    CloseBitBtn: TBitBtn;
    BenchmarkButton: TButton;
    Panel1: TPanel;
    SaveReportSpeedButton: TSpeedButton;
    PrintSpeedButton: TSpeedButton;
    ReportRichEdit: TRichEdit;
    SaveDialog: TSaveDialog;
    BenchmarkAllButton: TButton;
    ValidateAllButton: TButton;
    J2Edit: TEdit;
    J3Edit: TEdit;
    ClearButton: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    SpreadTestButton: TButton;
    MaxBenchEdit: TEdit;
    MinBenchEdit: TEdit;
    SpreadBenchPercentageEdit: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    J1Edit: TEdit;
    Bench1Edit: TEdit;
    Bench2Edit: TEdit;
    AlignMaxSpreadBenchPercentageEdit: TEdit;
    AlignFunctionName1Edit: TEdit;
    AlignFunctionName2Edit: TEdit;
    FunctionNameEdit: TEdit;
    MaxSpreadBenchPercentageEdit: TEdit;
    BenchTestButton: TButton;
    CleanButton: TButton;
    Label8: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    ShowErrorDialogCheckBox: TCheckBox;
    AlignCheckButton: TButton;
    AlignCheckEdit: TEdit;
    procedure FormDestroy(Sender: TObject);
    procedure AlignCheckButtonClick(Sender: TObject);
    procedure ValidateButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FunctionSelectionRadioGroupClick(Sender: TObject);
    procedure BenchmarkButtonClick(Sender: TObject);
    procedure SaveReportSpeedButtonClick(Sender: TObject);
    procedure PrintSpeedButtonClick(Sender: TObject);
    procedure BenchmarkAllButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure SpreadTestButtonClick(Sender: TObject);
    procedure SpreadBenchPercentageEditClick(Sender: TObject);
    procedure BenchTestButtonClick(Sender: TObject);
    procedure CleanButtonClick(Sender: TObject);
  private
    FResultList: TStringList;
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    procedure ClearAllEditBoxes;
    procedure BenchmarkTest;
    procedure AlignmentTest;
    procedure CleanResultsRichEdit;
    procedure SetTabs;
    procedure BenchmarkStatistics;
    procedure SortRichEdit;
    procedure CompleteValidate;
    procedure Benchmark;
  public
    { Public declarations }
   procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
  MainForm: TMainForm;

type
 TCompareStrFunction = function (const S1, S2: string): Integer;

implementation

uses
 Math, SystemInfoUnit, FastCodeCPUID, CompareStrDKCUnit, CompareStr_EWC, CompareStrLBGUnit, CompareStrPLRUnit,
 CompareStrRTLUnit, CompareStrJOHUnit;

{$R *.dfm}

var
 CompareStrFunction : TCompareStrFunction;
 SubBench1StringArray : array of string;
 SubBench2StringArray : array of string;
 SubBench3StringArray : array of string;
 TicksArray : array of Int64;
 lpFrequency : Int64;

const
 SUBBENCH1STRARRAYSIZE : Cardinal = 50;
 SUBBENCH2STRARRAYSIZE : Cardinal = 256;
 SUBBENCH3STRARRAYSIZE : Cardinal = 76;
 MAXSTRINGSIZE : Cardinal = 1000;
 //Adjusted such that each subbenchmark contributes evenly at a P42800E on the fastest function
 SUBBENCH1WEIGTH : Cardinal = 1950;
 SUBBENCH2WEIGTH : Cardinal = 2350;
 SUBBENCH3WEIGTH : Cardinal = 950;
 MAXINT64 : int64= $7FFFFFFFFFFFFFFF;
 MAXNOOFRUNS : Cardinal = 5000;
 MAXRERUNS : Cardinal = 5;//Must be at least 2

function GetCPUTick: Int64; assembler;
asm
 rdtsc
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

procedure TMainForm.BenchmarkStatistics;
var
 I2, LineNo, X1, TabNo1 : Integer;
 S1, BenchString : AnsiString;
 Bench, MinBench, MaxBench, AverageBench, SumBench, Spread : Double;
 C1 : Char;

begin
 MinBench := 99999999;
 MaxBench := 0;
 SumBench := 0;
 for LineNo := 0 to ReportRichEdit.Lines.Count-1 do
  begin
   S1 := ReportRichEdit.Lines[LineNo];
   I2 := Length(S1);
   TabNo1 := 0;
   repeat
    C1 := S1[I2];
    Dec(I2);
    if C1 = #9 then
     Inc(TabNo1);
   until(TabNo1 = 1);
   X1 := I2+2;
   BenchString := Copy(S1, X1, 5);
   //IsFloat function wanted
   try
    Bench := StrToFloat(BenchString);
   except
    Bench := 0;
   end;
   if Bench < MinBench then
    MinBench := Bench;
   if Bench > MaxBench then
    MaxBench := Bench;
   SumBench := SumBench + Bench;
  end;
 AverageBench := SumBench / (ReportRichEdit.Lines.Count);
 MaxBenchEdit.Text := FloatToStrF(MaxBench, ffFixed, 9, 0);
 MinBenchEdit.Text := FloatToStrF(MinBench, ffFixed, 9, 0);
 Spread := 100*(MaxBench-MinBench)/AverageBench;
 SpreadBenchPercentageEdit.Text := FloatToStrF(Spread, ffFixed, 9, 1);
 SpreadBenchPercentageEdit.Color := clGreen;
 if Spread > 1 then
  SpreadBenchPercentageEdit.Color := clYellow;
 if Spread > 3 then
  SpreadBenchPercentageEdit.Color := clRed;
 Update;
end;

procedure TMainForm.SetTabs;
begin
 ReportRichEdit.Paragraph.TabCount := 5;
 ReportRichEdit.Paragraph.Tab[0] := 115;
 ReportRichEdit.Paragraph.Tab[1] := 140;
 ReportRichEdit.Paragraph.Tab[2] := 170;
 ReportRichEdit.Paragraph.Tab[3] := 200;
 ReportRichEdit.Paragraph.Tab[4] := 240;
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
 Bench1Edit.Text := '';
 Bench2Edit.Text := '';
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
             Bench1Edit.Text := BenchString1;
             Bench2Edit.Text := BenchString2;
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
 Bench1Edit.Text := '';
 Bench2Edit.Text := '';
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
         Bench1Edit.Text := BenchString1;
         Bench2Edit.Text := BenchString2;
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

procedure ErrorTrap(ValidateNo : Integer; S1, S2 : AnsiString);
var
 I : Integer;
begin
 I := CompareStrFunction(S1, S2);
 if MainForm.ShowErrorDialogCheckBox.Checked then
  Application.MessageBox(PChar('Function failed in Validate' + IntToStr(ValidateNo) + ' String1: ' + S1 + ' String2: ' + S2 + 'Result: ' + IntToStr(I)), 'Error');
end;

function Validate1 : Boolean;
var
 S1, S2 : string;
 I : Integer;
const
 VALIDATENO : Integer = 1;

begin
 Result := True;
 S1 := '';
 S2 := '';
 I := CompareStrFunction(S1, S2); //S1 = S2 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 if I <> 0 then
  begin
   ErrorTrap(VALIDATENO, S1, S2);
   Result := False;
   Exit;
  end;
 S1 := 'A';
 S2 := '';
 I := CompareStrFunction(S1, S2);
 if I <= 0 then
  begin
   ErrorTrap(VALIDATENO, S1, S2);
   Result := False;
   Exit;
  end;
 S1 := '';
 S2 := 'A';
 I := CompareStrFunction(S1, S2);
 if I >= 0 then
  begin
   ErrorTrap(VALIDATENO, S1, S2);
   Result := False;
   Exit;
  end;
 S1 := 'A';
 S2 := 'B';
 I := CompareStrFunction(S1, S2);
 if I >= 0 then
  begin
   ErrorTrap(VALIDATENO, S1, S2);
   Result := False;
   Exit;
  end;
 S1 := 'B';
 S2 := 'A';
 I := CompareStrFunction(S1, S2);
 if I <= 0 then
  begin
   ErrorTrap(VALIDATENO, S1, S2);
   Result := False;
   Exit;
  end;
 S1 := 'A';
 S2 := 'A';
 I := CompareStrFunction(S1, S2);
 if I <> 0 then
  begin
   ErrorTrap(VALIDATENO, S1, S2);
   Result := False;
   Exit;
  end;
 S1 := 'BB';
 S2 := 'BB';
 I := CompareStrFunction(S1, S2);
 if I <> 0 then
  begin
   ErrorTrap(VALIDATENO, S1, S2);
   Result := False;
   Exit;
  end;
 S1 := 'CCC';
 S2 := 'CCC';
 I := CompareStrFunction(S1, S2);
 if I <> 0 then
  begin
   ErrorTrap(VALIDATENO, S1, S2);
   Result := False;
   Exit;
  end;
 S1 := 'DDDD';
 S2 := 'DDDD';
 I := CompareStrFunction(S1, S2);
 if I <> 0 then
  begin
   ErrorTrap(VALIDATENO, S1, S2);
   Result := False;
   Exit;
  end;
 S1 := 'EEEEE';
 S2 := 'EEEEE';
 I := CompareStrFunction(S1, S2);
 if I <> 0 then
  begin
   ErrorTrap(VALIDATENO, S1, S2);
   Result := False;
   Exit;
  end;
 S1 := 'FFFFFF';
 S2 := 'FFFFFF';
 I := CompareStrFunction(S1, S2);
 if I <> 0 then
  begin
   ErrorTrap(VALIDATENO, S1, S2);
   Result := False;
   Exit;
  end;
 S1 := 'GGGGGGG';
 S2 := 'GGGGGGG';
 I := CompareStrFunction(S1, S2);
 if I <> 0 then
  begin
   ErrorTrap(VALIDATENO, S1, S2);
   Result := False;
   Exit;
  end;
 S1 := 'HHHHHHHH';
 S2 := 'HHHHHHHH';
 I := CompareStrFunction(S1, S2);
 if I <> 0 then
  begin
   ErrorTrap(VALIDATENO, S1, S2);
   Result := False;
   Exit;
  end;
 S1 := 'IIIIIIIII';
 S2 := 'IIIIIIIII';
 I := CompareStrFunction(S1, S2);
 if I <> 0 then
  begin
   ErrorTrap(VALIDATENO, S1, S2);
   Result := False;
  end;
end;

function Validate2 : Boolean;
var
 S1, S2 : string;
 I, RunNo : Integer;
const
 VALIDATENO : Integer = 2;
 RUNNOMAX : Integer = 10000;
begin
 Result := True;
 S2 := '';
 for RunNo := 1 to RUNNOMAX do
  begin
   S1 := S1 + 'A';
   I := CompareStrFunction(S1, S2);
   if I <= 0 then
    begin
     ErrorTrap(VALIDATENO, S1, S2);
     Result := False;
     Break;
    end;
   I := CompareStrFunction(S2, S1);
   if I >= 0 then
    begin
     ErrorTrap(VALIDATENO, S2, S1);
     Result := False;
     Break;
    end;
   I := CompareStrFunction(S1, S1);
   if I <> 0 then
    begin
     ErrorTrap(VALIDATENO, S1, S1);
     Result := False;
     Break;
    end;
  end;
end;

function Validate3 : Boolean;
var
 S1, S2 : string;
 I, RunNo1, RunNo2 : Integer;
const
 VALIDATENO : Integer = 3;
 RUNNOMAX1 : Integer = 100;
 RUNNOMAX2 : Integer = 100;

begin
 Result := True;
 for RunNo1 := 1 to RUNNOMAX1 do
  begin
   S1 := '';
   S2 := S2 + '/';
   for RunNo2 := 1 to RUNNOMAX2 do
    begin
     S1 := S1 + 'A';
     I := CompareStrFunction(S1, S2);
     if I <= 0 then
      begin
       ErrorTrap(VALIDATENO, S1, S2);
       Result := False;
       Exit;
      end;
     I := CompareStrFunction(S2, S1);
     if I >= 0 then
      begin
       ErrorTrap(VALIDATENO, S2, S1);
       Result := False;
       Exit;
      end;
     I := CompareStrFunction(S1, S1);
     if I <> 0 then
      begin
       ErrorTrap(VALIDATENO, S1, S1);
       Result := False;
       Exit;
      end;
    end;
  end;
end;

function Validate4 : Boolean;
var
 S1, S2 : string;
 J1, I : Integer;
const
 VALIDATENO : Integer = 4;

begin
 Result := True;
 S1 := 'A';
 S2 := 'A';
 for J1 := 1 to MAXSTRINGSIZE do
  begin
   I := CompareStrFunction(S1, S2);
   S1 := S1 + Char((J1 mod 256));
   S2 := S2 + Char((J1 mod 256));
   if I <> 0 then
    begin
     ErrorTrap(VALIDATENO, S1, S2);
     Result := False;
     Break;
    end;
  end;
end;

function Validate5 : Boolean;
var
 S1, S2 : string;
 J1, I : Integer;
const
 VALIDATENO : Integer = 5;

begin
 Result := False;
 S1 := 'A';
 S2 := 'B';
 for J1 := 1 to MAXSTRINGSIZE do
  begin
   I := CompareStrFunction(S1, S2);
   if I < 0 then
    Result := True
   else
    begin
     ErrorTrap(VALIDATENO, S1, S2);
     Result := False;
     Break;
    end;
   S1 := Char((J1 mod 256)) + S1;
   S2 := Char((J1 mod 256)) + S2;
  end;
end;

function Validate6 : Boolean;
var
 S1, S2 : string;
 J1, I : Integer;
const
 VALIDATENO : Integer = 6;

begin
 Result := False;
 S1 := 'B';
 S2 := 'A';
 for J1 := 1 to MAXSTRINGSIZE do
  begin
   I := CompareStrFunction(S1, S2);
   if I > 0 then
    Result := True
   else
    begin
     ErrorTrap(VALIDATENO, S1, S2);
     Result := False;
     Break;
    end;
   S1 := Char((J1 mod 256)) + S1;
   S2 := Char((J1 mod 256)) + S2;
  end;
end;

function Validate7 : Boolean;
var
 S1, S2 : string;
 J1, I, Iref : Integer;
const
 VALIDATENO : Integer = 7;

begin
 Result := False;
 S1 := 'a';
 S2 := 'A';
 for J1 := 1 to MAXSTRINGSIZE do
  begin
   Iref := CompareStr(S1, S2);
   I := CompareStrFunction(S1, S2);
   S1 := Char((J1 mod 256)) + S1;
   S2 := Char((J1 mod 256)) + S2;
   if Sign(I) = Sign(Iref) then
    Result := True
   else
    begin
     ErrorTrap(VALIDATENO, S1, S2);
     Result := False;
     Break;
    end;
  end;
end;

function Validate8 : Boolean;
var
 S1, S2 : string;
 I1, I2, K1, K2 : Integer;
const
 VALIDATENO : Integer = 8;

begin
 Result := True;
 for I1 := 0 to 255 do
  begin
   for I2 := 0 to 255 do
    begin
     S1 := Char(I1);
     S2 := Char(I2);
     K1 := CompareStr(S1, S2);
     K2 := CompareStrFunction(S1, S2);
     if (K1 < 0) and (K2 >= 0) then
      begin
       ErrorTrap(VALIDATENO, S1, S2);
       Result := False;
       Exit;
      end;
     if (K1 > 0) and (K2 <= 0) then
      begin
       ErrorTrap(VALIDATENO, S1, S2);
       Result := False;
       Exit;
      end;
     if (K1 = 0) and (K2 <> 0) then
      begin
       ErrorTrap(VALIDATENO, S1, S2);
       Result := False;
       Exit;
      end;
    end;
  end;
end;

function Validate9 : Boolean;
var
 S1, S2 : string;
 I1, I2, I3, K1, K2, K3, K4 : Integer;
const
 VALIDATENO : Integer = 9;

begin
 Result := True;
 for I1 := 100 to 255 do
  begin
   for I2 := 1 to 255 do
    begin
     for I3 := 1 to 255 do
      begin
       S1 := Char(I1);
       S2 := Char(I2) + Char(I3);
       K1 := CompareStr(S1, S2);
       K2 := CompareStrFunction(S1, S2);
       if Sign(K1) <> Sign(K2) then
        begin
         ErrorTrap(VALIDATENO, S1, S2);
         Result := False;
         Exit;
        end;
       K3 := CompareStr(S2, S1);
       K4 := CompareStrFunction(S2, S1);
       if Sign(K3) <> Sign(K4) then
        begin
         ErrorTrap(VALIDATENO, S2, S1);
         Result := False;
         Exit;
        end;
      end;
    end;
  end;
end;

function Validate10 : Boolean;
var
 S1, S2 : string;
 I1, I2, I3, K1, K2 : Integer;
const
 VALIDATENO : Integer = 10;

begin
 Result := True;
 for I1 := 80 to 100 do
  begin
   for I2 := 100 to 255 do
    begin
     for I3 := 0 to 255 do
      begin
       S1 := Char(I1) + Char(I3);
       S2 := Char(I2);
       K1 := CompareStr(S1, S2);
       K2 := CompareStrFunction(S1, S2);
       if (K1 < 0) and (K2 >= 0) then
        begin
         ErrorTrap(VALIDATENO, S1, S2);
         Result := False;
         Exit;
        end;
       if (K1 > 0) and (K2 <= 0) then
        begin
         ErrorTrap(VALIDATENO, S1, S2);
         Result := False;
         Exit;
        end;
       if (K1 = 0) and (K2 <> 0) then
        begin
         ErrorTrap(VALIDATENO, S1, S2);
         Result := False;
         Exit;
        end;
      end;
    end;
  end;
end;

function Validate11 : Boolean;
var
 S1, S2 : string;
 I1, I2, I3, I4, K1, K2 : Integer;
const
 VALIDATENO : Integer = 11;

begin
 Result := True;
 for I1 := 0 to 25 do
  begin
   for I2 := 0 to 25 do
    begin
     for I3 := 10 to 100 do
      begin
       for I4 := 10 to 100 do
        begin
         S1 := Char(I1) + Char(I3);
         S2 := Char(I2) + Char(I4);
         K1 := CompareStr(S1, S2);
         K2 := CompareStrFunction(S1, S2);
         if (K1 < 0) and (K2 >= 0) then
          begin
           ErrorTrap(VALIDATENO, S1, S2);
           Result := False;
           Exit;
          end;
         if (K1 > 0) and (K2 <= 0) then
          begin
           ErrorTrap(VALIDATENO, S1, S2);
           Result := False;
           Exit;
          end;
         if (K1 = 0) and (K2 <> 0) then
          begin
           ErrorTrap(VALIDATENO, S1, S2);
           Result := False;
           Exit;
          end;
        end;
      end;
    end;
  end;
end;

function Validate12 : Boolean;
var
 S1, S2 : string;
 I1, I2, I3, I4, K1, K2 : Integer;
const
 VALIDATENO : Integer = 12;

begin
 Result := True;
 for I1 := 10 to 25 do
  begin
   for I2 := 10 to 25 do
    begin
     for I3 := 40 to 100 do
      begin
       for I4 := 20 to 50 do
        begin
         S1 := 'AaBaCcDdwwwwww' + Char(I1) + Char(I3);
         S2 := 'AaBaCcDdwwwwww' + Char(I2) + Char(I4);
         K1 := CompareStr(S1, S2);
         K2 := CompareStrFunction(S1, S2);
         if (K1 < 0) and (K2 >= 0) then
          begin
           ErrorTrap(VALIDATENO, S1, S2);
           Result := False;
           Exit;
          end;
         if (K1 > 0) and (K2 <= 0) then
          begin
           ErrorTrap(VALIDATENO, S1, S2);
           Result := False;
           Exit;
          end;
         if (K1 = 0) and (K2 <> 0) then
          begin
           ErrorTrap(VALIDATENO, S1, S2);
           Result := False;
           Exit;
          end;
        end;
      end;
    end;
  end;
end;

function Validate13 : Boolean;
var
 S1, S2 : string;
 I, Iref : Integer;
const
 VALIDATENO : Integer = 13;

begin
 S1 := 'a';
 S2 := '\';
 Iref := CompareStr(S1, S2);
 I := CompareStrFunction(S1, S2);
 if Sign(I) = Sign(Iref) then
  Result := True
 else
  begin
   ErrorTrap(VALIDATENO, S1, S2);
   Result := False;
  end;
end;

function Validate14 : Boolean;
var
 S1, S2 : string;
 I1, I2, I3, I4, I5, I6, K1, K2 : Integer;
const
 VALIDATENO : Integer = 14;

begin
 Result := True;
 for I1 := 10 to 12 do
  begin
   for I2 := 11 to 13 do
    begin
     for I3 := 12 to 14 do
      begin
       for I4 := 20 to 25 do
        begin
         for I5 := 24 to 30 do
          begin
           for I6 := 30 to 35 do
            begin
             S1 := 'AaBaCcD' + Char(I1) + 'dwwwwww' + Char(I3) + Char(I5);
             S2 := 'AaBaCcDdwwwwww' + Char(I2) + Char(I4) + Char(I6);
             K1 := CompareStr(S1, S2);
             K2 := CompareStrFunction(S1, S2);
             if (K1 < 0) and (K2 >= 0) then
              begin
               ErrorTrap(VALIDATENO, S1, S2);
               Result := False;
               Exit;
              end;
             if (K1 > 0) and (K2 <= 0) then
              begin
               ErrorTrap(VALIDATENO, S1, S2);
               Result := False;
               Exit;
              end;
             if (K1 = 0) and (K2 <> 0) then
              begin
               ErrorTrap(VALIDATENO, S1, S2);
               Result := False;
               Exit;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function Validate15 : Boolean;
var
 S1, S2 : string;
 J1, I : Integer;
const
 VALIDATENO : Integer = 15;

begin
 Result := False;
 S1 := 'aww';
 S2 := 'Aq';
 for J1 := 1 to MAXSTRINGSIZE do
  begin
   I := CompareStrFunction(S1, S2);
   S1 := Char((J1 mod 256)) + S1;
   S2 := Char((J1 mod 256)) + S2;
   if I > 0 then
    Result := True
   else
    begin
     ErrorTrap(VALIDATENO, S1, S2);
     Result := False;
     Break;
    end;
  end;
end;

var
 S1Global, S2Global : string;

function Validate16 : Boolean;
var
 I : Integer;
const
 VALIDATENO : Integer = 16;

begin
 S1Global := 'zzzzzzzzzzzzzz';
 S2Global := 'zzzzzzzzzzzzzz';
 (PInteger(Integer(S1Global)-4))^ := 0;
 I := CompareStrFunction(S1Global, S2Global);
 //S1Global is empty -> strings are not equal -> S1Global is the smallest -> I must be negative
 //But the functions must not read from S1Global
 if I < 0 then
  Result := True
 else
  begin
   ErrorTrap(VALIDATENO, S1Global, S2Global);
   Result := False;
  end;
end;

function Validate17 : Boolean;
var
 I : Integer;
const
 VALIDATENO : Integer = 17;

begin
 S1Global := 'zzzzzzzzzzzzzz';
 S2Global := '';
 (PInteger(Integer(S1Global)-4))^ := 0;
 I := CompareStrFunction(S1Global, S2Global);
 //S1Global and S2Global are empty -> strings are equal -> I must be 0
 //But the functions must not read from S1Global
 if I = 0 then
  Result := True
 else
  begin
   ErrorTrap(VALIDATENO, S1Global, S2Global);
   Result := False;
  end;
end;

function Validate18 : Boolean;
var
 I : Integer;
const
 VALIDATENO : Integer = 18;

begin
 S1Global := '';
 S2Global := 'zzzzzzzzzzzzzz';
 (PInteger(Integer(S2Global)-4))^ := 0;
 I := CompareStrFunction(S1Global, S2Global);
 //S1Global and S2Global are empty -> strings are equal -> I must be 0
 //But the functions must not read from S1Global
 if I = 0 then
  Result := True
 else
  begin
   ErrorTrap(VALIDATENO, S1Global, S2Global);
   Result := False;
  end;
end;

function Validate19 : Boolean;
var
 I : Integer;
const
 VALIDATENO : Integer = 19;

begin
 S1Global := 'zzzzzzzzzzzzzz';
 S2Global := 'zzzzzzzzzzzzzz';
 (PInteger(Integer(S1Global)-4))^ := 0;
 (PInteger(Integer(S2Global)-4))^ := 0;
 I := CompareStrFunction(S1Global, S2Global);
 //S1Global and S1Global are empty -> strings are equal -> I must be 0
 //And the functions must not read from S1Global or S2Global
 if I = 0 then
  Result := True
 else
  begin
   ErrorTrap(VALIDATENO, S1Global, S2Global);
   Result := False;
  end;
end;

function Validate20 : Boolean;
var
 S1 : string;
 J1, I : Integer;
const
 VALIDATENO : Integer = 20;

begin
 Result := False;
 S1 := '';
 for J1 := 1 to MAXSTRINGSIZE do
  begin
   I := CompareStrFunction(S1, S1);
   if I = 0 then
    Result := True
   else
    begin
     ErrorTrap(VALIDATENO, S1, S1);
     Result := False;
     Break;
    end;
   S1 := Char((J1 mod 256)) + S1;
  end;
end;

{$HINTS OFF}

function Validate21 : Boolean;
var
 S1, S2 : string;
 J, I, IRef : Integer;
 EBXRegisterBefore, ESIRegisterBefore, EDIRegisterBefore,
 EBXRegisterAfter,  ESIRegisterAfter,  EDIRegisterAfter : Cardinal;
 X, Y, Z : Extended;
const
 RUNNOMAX : Integer = 1000;
 VALIDATENO : Integer = 21;

begin
 Result := True;
 S1 := '';
 S2 := '';
 IRef := 0;
 for J := 0 to RUNNOMAX do
  begin
   asm
    mov EBXRegisterBefore, ebx
    mov EDIRegisterBefore, edi
    mov ESIRegisterBefore, esi
   end;
   I := CompareStrFunction(S1, S1);
   asm
    mov EBXRegisterAfter, ebx
    mov EDIRegisterAfter, edi
    mov ESIRegisterAfter, esi
   end;
   if I <> IRef then
    begin
     ErrorTrap(VALIDATENO, S1, S1);
     Result := False;
     Exit;
    end;
   //Verify that registers are preserved
   if ((EBXRegisterAfter <> EBXRegisterBefore) or
       (EDIRegisterAfter <> EDIRegisterBefore) or
       (ESIRegisterAfter <> ESIRegisterBefore)) then
    begin
     ErrorTrap(VALIDATENO, S1, S1);
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
    ErrorTrap(VALIDATENO, S1, S1);
    Result := False;
    Exit;
   end;
   S1 := S1 + Char(J);
   S2 := S2 + Char(J);
  end;
end;

{$HINTS ON}

{$HINTS OFF}

function Validate22 : Boolean;
var
 S1, S2 : string;
 J, I, IRef : Integer;
 EBXRegisterBefore, ESIRegisterBefore, EDIRegisterBefore,
 EBXRegisterAfter,  ESIRegisterAfter,  EDIRegisterAfter : Cardinal;
 X, Y, Z : Extended;
const
 RUNNOMAX : Integer = 1000;
 VALIDATENO : Integer = 22;

begin
 Result := True;
 S1 := '';
 S2 := '';
 IRef := 0;
 for J := 0 to RUNNOMAX do
  begin
   asm
    mov EBXRegisterBefore, ebx
    mov EDIRegisterBefore, edi
    mov ESIRegisterBefore, esi
   end;
   I := CompareStrFunction(S1, S2);
   asm
    mov EBXRegisterAfter, ebx
    mov EDIRegisterAfter, edi
    mov ESIRegisterAfter, esi
   end;
   if I <> IRef then
    begin
     ErrorTrap(VALIDATENO, S1, S2);
     Result := False;
     Exit;
    end;
   //Verify that registers are preserved
   if ((EBXRegisterAfter <> EBXRegisterBefore) or
       (EDIRegisterAfter <> EDIRegisterBefore) or
       (ESIRegisterAfter <> ESIRegisterBefore)) then
    begin
     ErrorTrap(VALIDATENO, S1, S2);
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
    ErrorTrap(VALIDATENO, S1, S2);
    Result := False;
    Exit;
   end;
   S1 := S1 + Char(J);
   S2 := S2 + Char(J);
  end;
end;

{$HINTS ON}

{$HINTS OFF}

function Validate23 : Boolean;
var
 S1, S2 : string;
 J, I, IRef : Integer;
 EBXRegisterBefore, ESIRegisterBefore, EDIRegisterBefore,
 EBXRegisterAfter,  ESIRegisterAfter,  EDIRegisterAfter : Cardinal;
 X, Y, Z : Extended;
const
 RUNNOMAX : Integer = 1000;
 VALIDATENO : Integer = 23;

begin
 Result := True;
 S1 := '';
 S2 := '';
 for J := 0 to RUNNOMAX do
  begin
   Iref := CompareStr(S1, S2);
   asm
    mov EBXRegisterBefore, ebx
    mov EDIRegisterBefore, edi
    mov ESIRegisterBefore, esi
   end;
   I := CompareStrFunction(S1, S2);
   asm
    mov EBXRegisterAfter, ebx
    mov EDIRegisterAfter, edi
    mov ESIRegisterAfter, esi
   end;
   if Sign(I) <> Sign(IRef) then
    begin
     ErrorTrap(VALIDATENO, S1, S2);
     Result := False;
     Exit;
    end;
   //Verify that registers are preserved
   if ((EBXRegisterAfter <> EBXRegisterBefore) or
       (EDIRegisterAfter <> EDIRegisterBefore) or
       (ESIRegisterAfter <> ESIRegisterBefore)) then
    begin
     ErrorTrap(VALIDATENO, S1, S2);
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
    ErrorTrap(VALIDATENO, S1, S2);
    Result := False;
    Exit;
   end;
   S1 := S1 + Char(J);
   S2 := S2 + Char(J);
   if J mod 17 = 0 then
    S2 := S2 + 'k';
  end;
end;

{$HINTS ON}

procedure TMainForm.CompleteValidate;
var
 FunctionName, FunctionAddressString : AnsiString;
 FunctionAddress : Cardinal;

begin
 try
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@CompareStrFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  ValidEdit.Text := 'Running';
  ValidEdit.Color := clLime;
  Update;
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
     Validate21 and
     Validate22 and
     Validate23 then
   begin
    ValidEdit.Text := 'Passed';
    ValidEdit.Color := clGreen;
    ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[8] + #9 + 'Passed');
   end
  else
   begin
    ValidEdit.Text := 'Failed';
    ValidEdit.Color := clRed;
    ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[8] + #9 + 'Failed');
   end;
 except
  ValidEdit.Text := 'Failed';
  ValidEdit.Color := clRed;
  FunctionAddress := Cardinal(@CompareStrFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[8] + #9 + 'Failed');
 end;
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
begin
 ValidateButton.Caption := 'Running';
 Update;
 CompleteValidate;
 ValidateButton.Caption := 'Validate';
end;

procedure FillSubBench1StringArray;
begin
 //Create some test strings
 SubBench1StringArray[0] := '';
 SubBench1StringArray[1] := 'S';
 SubBench1StringArray[2] := 'XY';
 SubBench1StringArray[3] := 'ABC';
 SubBench1StringArray[4] := 'DEFG';
 SubBench1StringArray[5] := 'DEFGH';
 SubBench1StringArray[6] := 'ADEFGH';
 SubBench1StringArray[7] := 'ADEFGHI';
 SubBench1StringArray[8] := 'SWERfghy';
 SubBench1StringArray[9] := 'aqwedfgykj';
 SubBench1StringArray[10] := 'aqwedhhdsfj';
 SubBench1StringArray[11] := 'dddddddddddd';
 SubBench1StringArray[12] := 'dddddddddddda';
 SubBench1StringArray[13] := 'DDDDDDDDDDDDyy';
 SubBench1StringArray[14] := 'xDDDDDDDDDDDDjk';
 SubBench1StringArray[15] := '123456789asdfgwe';
 SubBench1StringArray[16] := '123456789asdfgert';
 SubBench1StringArray[17] := '123456789asdfguiop';
 SubBench1StringArray[18] := '12345678awsdfhjWERT';
 SubBench1StringArray[19] := 'abcdefghijdrtyuiPOIY';
 SubBench1StringArray[20] := 'ABCDEFGHIJQWERTY,.-¨+0';
 SubBench1StringArray[21] := 'ABCDEFjGHIJQWERTY,.-¨+0';
 SubBench1StringArray[22] := 'ABCDEFjGHiIJQWERTY,.-¨+0';
 SubBench1StringArray[23] := 'ABCDEFjGHiIJQWERTY,.-¨+0u';
 SubBench1StringArray[24] := 'AhBCDEFjGHiIJQWERTY,.-¨+0u';
 SubBench1StringArray[25] := 'aAaAaAaAaAaAaAaAaAaAaAaAaAa';
 SubBench1StringArray[26] := 'AaAaAaAaAaAaAaAaAaAaAaAaAaA';
 SubBench1StringArray[27] := 'AAAAAAAAAAAAAAAAAAAAAAAAAAAA';
 SubBench1StringArray[28] := 'aaaaaaaaaaaaaaaaaaaaaaaaaaaa';
 SubBench1StringArray[29] := 'abcdefghijklmnopqrstuvxyz1234';
 SubBench1StringArray[30] := 'ABCDEFGHIJKLMNOPQRSTUVXYZ1234';
 SubBench1StringArray[31] := 'pokijuhytgfredswqazxbghuithdlm';
 SubBench1StringArray[32] := 'DERTFGYUIOPLKJHGFRDEWSQAZXCVFF';
 SubBench1StringArray[33] := 'qWsedRtfGGyuHjikNbvGt567Cde"#)(';
 SubBench1StringArray[34] := 'SWErff677))0+08751§qawrvnmd.-*¨,';
 SubBench1StringArray[35] := 'hdw3r6fkjg-.eoa8u633szwq1edcvythb';
 SubBench1StringArray[36] := 'SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS';
 SubBench1StringArray[37] := 'ssssssssssssssssssssssssssssssssss';
 SubBench1StringArray[38] := 'SsSssSsSSsSsSsSsSsSsSsSsSsSsSsssSs';
 SubBench1StringArray[39] := 'sSsssssSssssSSSSSssSSssSssSSssssSs';
 SubBench1StringArray[40] := 'UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU';
 SubBench1StringArray[41] := 'UuUUuUuuUUuuUUuuUuuuuUUUuuuuUUUUuu';
 SubBench1StringArray[42] := 'UUUUUUUUUUUUUUUUUUytyrewqsdrrggghy';
 SubBench1StringArray[43] := 'POKIJuhytGFredsswqaZXcvbnMjL,.-_:;¨^';
 SubBench1StringArray[44] := 'gffseqgjsgdjbdjwgbdhgwqnfburefbjhgrhb';
 SubBench1StringArray[45] := 'htytfgqfetqyjhcbwjgerbfwebrhwbnbvskheh';
 SubBench1StringArray[46] := 'hhyrtyrndsbfjshfgiwlhjuhfygrtfdrqedaswp';
 SubBench1StringArray[47] := 'aqswdefrgthyjukilopMNBVCXZASQWEDRFGTHYUKOP';
 SubBench1StringArray[48] := 'drtGHYUJikloP!"#456778890?=)(/&%¤##""!vdfgrtyw';
 SubBench1StringArray[49] := 'QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ';
end;

function SubBenchmark1 : Cardinal;
var
 J1, J2, J3, J4 : Integer;
 I1, I2, NoOfRuns, RunNo : Cardinal;
 StartCount, EndCount, Ticks, TicksMin, lpPerformanceCount : Int64;
 RunTimeSec : Double;

begin
 J1 := 0;
 J2 := 0;
 J3 := 0;
 for RunNo := 1 to MAXRERUNS do
  begin
   if QueryPerformanceCounter(lpPerformanceCount) then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for NoOfRuns := 1 to MAXNOOFRUNS do
    begin
     for I1 := 1 to SUBBENCH1STRARRAYSIZE-1 do
      for I2 := 1 to SUBBENCH1STRARRAYSIZE-2 do
       begin
        //Sometimes tests identical strings
        J1 := CompareStrFunction(SubBench1StringArray[I1], SubBench1StringArray[I2]);
        J2 := CompareStrFunction(SubBench1StringArray[I2], SubBench1StringArray[I1]);
        //Always tests identical strings
        //J3 := CompareStrFunction(SubBench1StringArray[I1], SubBench1StringArray[I1]);
       end;
    end;
   if QueryPerformanceCounter(lpPerformanceCount) then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   Ticks := EndCount - StartCount;
   if Ticks > 0 then
    TicksArray[RunNo-1] := Ticks
   else
    raise Exception.Create('Ticks overflow');
  end;
 //Get the fastest run
 TicksMin := TicksArray[0];
 for J4 := 1 to MAXRERUNS-1 do
  begin
   if TicksArray[J4] < TicksMin then
    TicksMin := TicksArray[J4];
  end;
 MainForm.J1Edit.Text := IntToStr(J1);
 MainForm.J2Edit.Text := IntToStr(J2);
 MainForm.J3Edit.Text := IntToStr(J3);
 RunTimeSec := TicksMin / lpFrequency;
 Result := Round(RunTimeSec * SUBBENCH1WEIGTH);
end;

procedure FillSubBench2StringArray;
var
 I1: Cardinal;

begin
 SubBench2StringArray[1] := 'S';
 //Create some test strings
 for I1 := 2 to SUBBENCH2STRARRAYSIZE - 1 do
  begin
   SubBench2StringArray[I1] := SubBench2StringArray[I1 - 1] + Char(Random(255));
  end;
end;

function SubBenchmark2 : Cardinal;
var
 J1, J2, J3, J4 : Integer;
 I2, NoOfRuns, RunNo : Cardinal;
 StartCount, EndCount, Ticks, lpPerformanceCount, TicksMin : Int64;
 RunTimeSec : Double;

begin
 J1 := 0;
 J2 := 0;
 J3 := 0;
 for RunNo := 1 to MAXRERUNS do
  begin
   if QueryPerformanceCounter(lpPerformanceCount) then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for NoOfRuns := 1 to MAXNOOFRUNS do
    begin
     for I2 := 1 to SUBBENCH2STRARRAYSIZE-2 do
      begin
       J1 := CompareStrFunction(SubBench2StringArray[I2], SubBench2StringArray[I2+1]);
       J2 := CompareStrFunction(SubBench2StringArray[I2+1], SubBench2StringArray[I2]);
       //J3 := CompareStrFunction(SubBench2StringArray[I2], SubBench2StringArray[I2]);
      end;
    end;
   if QueryPerformanceCounter(lpPerformanceCount) then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   Ticks := EndCount - StartCount;
   if Ticks > 0 then
    TicksArray[RunNo-1] := Ticks
   else
    raise Exception.Create('Ticks overflow');
  end;
 //Get the fastest run
 TicksMin := TicksArray[0];
 for J4 := 1 to MAXRERUNS-1 do
  begin
   if TicksArray[J4] < TicksMin then
    TicksMin := TicksArray[J4];
  end;
 MainForm.J1Edit.Text := IntToStr(J1);
 MainForm.J2Edit.Text := IntToStr(J2);
 MainForm.J3Edit.Text := IntToStr(J3);
 RunTimeSec := TicksMin / lpFrequency;
 Result := Round(RunTimeSec * SUBBENCH2WEIGTH);
end;

procedure FillSubBench3StringArray;
begin
 //Create some test strings
 SubBench3StringArray[0] := 'Christensen Dennis';
 SubBench3StringArray[1] := 'Jensen Mariann';
 SubBench3StringArray[2] := 'Gobel Bent';
 SubBench3StringArray[3] := 'Kjær Jesper';
 SubBench3StringArray[4] := 'Jensen Erik';
 SubBench3StringArray[5] := 'Hansen Hans';
 SubBench3StringArray[6] := 'Andersen Elin';
 SubBench3StringArray[7] := 'Andersen Svend Erik';
 SubBench3StringArray[8] := 'Thorpe Danny';
 SubBench3StringArray[9] := 'Gates Bill';
 SubBench3StringArray[10] := 'Nielsen Dorte';
 SubBench3StringArray[11] := 'Mathisen Polle';
 SubBench3StringArray[12] := 'Olsen Ole';
 SubBench3StringArray[13] := 'Madsen Arne';
 SubBench3StringArray[14] := 'Christensen Tommy';
 SubBench3StringArray[15] := 'Otto Steffen';
 SubBench3StringArray[16] := 'Jensen Niels Kjell';
 SubBench3StringArray[17] := 'Hansen Erna';
 SubBench3StringArray[18] := 'Rasmussen Susanne';
 SubBench3StringArray[19] := 'Ytting Hans';
 SubBench3StringArray[20] := 'Hyttel Mie';
 SubBench3StringArray[21] := 'Olsen Thomas';
 SubBench3StringArray[22] := 'Bager Dennis';
 SubBench3StringArray[23] := 'Lee Robert';
 SubBench3StringArray[24] := 'Woods Tiger';
 SubBench3StringArray[25] := 'Spodsberg Soren';
 SubBench3StringArray[26] := 'Downs Dan';
 SubBench3StringArray[27] := 'Larsen Kirsten';
 SubBench3StringArray[28] := 'Fugl Mette';
 SubBench3StringArray[29] := 'Eriksen Tom';
 SubBench3StringArray[30] := 'Larsen Diana';
 SubBench3StringArray[31] := 'Hansen Mary';
 SubBench3StringArray[32] := 'Frederik';
 SubBench3StringArray[33] := 'Jensen Camilla';
 SubBench3StringArray[34] := 'Jensen Erik';
 SubBench3StringArray[35] := 'Hansen Hans Peter';
 SubBench3StringArray[36] := 'Fisker Poul';
 SubBench3StringArray[37] := 'Andersen Svend Erik';
 SubBench3StringArray[38] := 'Petersen Henrik';
 SubBench3StringArray[39] := 'Petersen Jannie';
 SubBench3StringArray[40] := 'Hansen Bente';
 SubBench3StringArray[41] := 'Jester Anette';
 SubBench3StringArray[42] := 'Philip Kim';
 SubBench3StringArray[43] := 'Jensen Niels';
 SubBench3StringArray[44] := 'Sampras Pete';
 SubBench3StringArray[45] := 'Larsen Mads';
 SubBench3StringArray[46] := 'Ottke Svend';
 SubBench3StringArray[47] := 'Schumacher Ralph';
 SubBench3StringArray[48] := 'Kiesa Nikolas';
 SubBench3StringArray[49] := 'Riis Bjarne';
 //New strings for release 2.0
 SubBench3StringArray[50] := 'Christensen Dennis';
 SubBench3StringArray[51] := 'Jensen Mariann';
 SubBench3StringArray[52] := 'Gobel Bent';
 SubBench3StringArray[53] := 'Kjær Jesper';
 SubBench3StringArray[54] := 'Jensen Erik';
 SubBench3StringArray[55] := 'Hansen Hans';
 SubBench3StringArray[56] := 'Andersen Svend Erik';
 SubBench3StringArray[57] := 'Petersen Henrik';
 SubBench3StringArray[58] := 'Petersen Jannie';
 SubBench3StringArray[59] := 'Hansen Bente';
 SubBench3StringArray[60] := 'Mercedes';
 SubBench3StringArray[61] := 'Siemens';
 SubBench3StringArray[62] := 'Bosch';
 SubBench3StringArray[63] := 'Tony Stokholm';
 SubBench3StringArray[64] := 'Pierre le Riche';
 SubBench3StringArray[65] := 'Marco Cantu';
 SubBench3StringArray[66] := 'Ulla Maria Hansen';
 SubBench3StringArray[67] := 'Marina Bohrsen';
 SubBench3StringArray[68] := 'Jens Jensen';
 SubBench3StringArray[69] := 'Hans Hansen';
 SubBench3StringArray[70] := 'Erik Eriksen';
 SubBench3StringArray[71] := 'Karl Karlsen';
 SubBench3StringArray[72] := 'Christian Christiansen';
 SubBench3StringArray[73] := 'Nils Nilsen';
 SubBench3StringArray[74] := 'Egon Olsen';
 SubBench3StringArray[75] := 'Ole Olsen';
end;

function SubBenchmark3 : Cardinal;
var
 J1, J2, J3, J4 : Integer;
 I1, I2, NoOfRuns, RunNo : Cardinal;
 StartCount, EndCount, Ticks, lpPerformanceCount, TicksMin : Int64;
 RunTimeSec : Double;

begin
 J1 := 0;
 J2 := 0;
 J3 := 0;
 for RunNo := 1 to MAXRERUNS do
  begin
   if QueryPerformanceCounter(lpPerformanceCount) then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for NoOfRuns := 1 to MAXNOOFRUNS do
    begin
     for I1 := 1 to SUBBENCH3STRARRAYSIZE-1 do
      for I2 := 1 to SUBBENCH3STRARRAYSIZE-1 do
       begin
        J1 := CompareStrFunction(SubBench3StringArray[I1], SubBench3StringArray[I2]);
        J2 := CompareStrFunction(SubBench3StringArray[I2], SubBench3StringArray[I1]);
       end;
    end;
   if QueryPerformanceCounter(lpPerformanceCount) then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   Ticks := EndCount - StartCount;
   if Ticks > 0 then
    TicksArray[RunNo-1] := Ticks
   else
    raise Exception.Create('Ticks overflow');
  end;
 //Get the fastest run
 TicksMin := TicksArray[0];
 for J4 := 1 to MAXRERUNS-1 do
  begin
   if TicksArray[J4] < TicksMin then
    TicksMin := TicksArray[J4];
  end;
 MainForm.J1Edit.Text := IntToStr(J1);
 MainForm.J2Edit.Text := IntToStr(J2);
 MainForm.J3Edit.Text := IntToStr(J3);
 RunTimeSec := TicksMin / lpFrequency;
 Result := Round(RunTimeSec * SUBBENCH3WEIGTH);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var CpuString : string;
begin
 ClearAllEditBoxes;
 CompareStrFunction := CompareStr;
 ReportRichEdit.Clear;
 SetTabs;
 //DebugMode
 FunctionSelectionRadioGroup.ItemIndex := FunctionSelectionRadioGroup.Items.Count;
 FunctionSelectionRadioGroupClick(nil);
 SetLength(SubBench1StringArray, SUBBENCH1STRARRAYSIZE);
 FillSubBench1StringArray;
 SetLength(SubBench2StringArray, SUBBENCH2STRARRAYSIZE);
 FillSubBench2StringArray;
 SetLength(SubBench3StringArray, SUBBENCH3STRARRAYSIZE);
 FillSubBench3StringArray;
 SetLength(TicksArray, MAXRERUNS);
 if not QueryPerformanceFrequency(lpFrequency) then
  raise Exception.Create('QueryPerformanceFrequency failed');

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

procedure TMainForm.FunctionSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionSelectionRadioGroup.ItemIndex+1 of
  1 : CompareStrFunction := CompareStr;
  2 : CompareStrFunction := CompareStr_DKC_Pas_11_a;
  3 : CompareStrFunction := CompareStr_DKC_Pas_11_b;
  4 : CompareStrFunction := CompareStr_DKC_Pas_11_c;
  5 : CompareStrFunction := CompareStr_DKC_Pas_11_d;
  6 : CompareStrFunction := CompareStr_DKC_Pas_12_a;
  7 : CompareStrFunction := CompareStr_DKC_Pas_12_b;
  8 : CompareStrFunction := CompareStr_DKC_Pas_12_c;
  9 : CompareStrFunction := CompareStr_DKC_Pas_12_d;
  10 : CompareStrFunction := CompareStr_DKC_IA32_20_a;
  11 : CompareStrFunction := CompareStr_DKC_IA32_20_b;
  12 : CompareStrFunction := CompareStr_DKC_IA32_20_c;
  13 : CompareStrFunction := CompareStr_DKC_IA32_20_d;
  14 : CompareStrFunction := CompareStr_DKC_MMX_3_a;
  15 : CompareStrFunction := CompareStr_DKC_MMX_3_b;
  16 : CompareStrFunction := CompareStr_DKC_MMX_3_c;
  17 : CompareStrFunction := CompareStr_DKC_MMX_3_d;
  18 : CompareStrFunction := CompareStr_DKC_MMX_4_a;
  19 : CompareStrFunction := CompareStr_DKC_MMX_4_b;
  20 : CompareStrFunction := CompareStr_DKC_MMX_4_c;
  21 : CompareStrFunction := CompareStr_DKC_MMX_4_d;
  22 : CompareStrFunction := CompareStr_DKC_MMX_5_a;
  23 : CompareStrFunction := CompareStr_DKC_MMX_5_b;
  24 : CompareStrFunction := CompareStr_DKC_MMX_5_c;
  25 : CompareStrFunction := CompareStr_DKC_MMX_5_d;
  26 : CompareStrFunction := CompareStr_DKC_SSE2_3_a;
  27 : CompareStrFunction := CompareStr_DKC_SSE2_3_b;
  28 : CompareStrFunction := CompareStr_DKC_SSE2_3_c;
  29 : CompareStrFunction := CompareStr_DKC_SSE2_3_d;
  30 : CompareStrFunction := CompareStr_PLR_IA32_17a;
  31 : CompareStrFunction := CompareStr_PLR_IA32_17b;
  32 : CompareStrFunction := CompareStr_PLR_IA32_17c;
  33 : CompareStrFunction := CompareStr_PLR_IA32_17d;
  34 : CompareStrFunction := CompareStr_LBG_IA32ext_1_a;
  35 : CompareStrFunction := CompareStr_LBG_IA32ext_1_b;
  36 : CompareStrFunction := CompareStr_LBG_IA32ext_1_c;
  37 : CompareStrFunction := CompareStr_LBG_IA32ext_1_d;
  38 : CompareStrFunction := CompareStr_EWC_IA32_3_a;
  39 : CompareStrFunction := CompareStr_EWC_IA32_3_b;
  40 : CompareStrFunction := CompareStr_EWC_IA32_3_c;
  41 : CompareStrFunction := CompareStr_EWC_IA32_3_d;
  42 : CompareStrFunction := CompareStr_EWC_PAS_2_a;
  43 : CompareStrFunction := CompareStr_EWC_PAS_2_b;
  44 : CompareStrFunction := CompareStr_EWC_PAS_2_c;
  45 : CompareStrFunction := CompareStr_EWC_PAS_2_d;
  46 : CompareStrFunction := CompareStr_JOH_IA32_1_a;
  47 : CompareStrFunction := CompareStr_JOH_IA32_1_b;
  48 : CompareStrFunction := CompareStr_JOH_IA32_1_c;
  49 : CompareStrFunction := CompareStr_JOH_IA32_1_d;
  50 : CompareStrFunction := CompareStr_PLR_IA32_16a;
  51 : CompareStrFunction := CompareStr_PLR_IA32_16b;
  52 : CompareStrFunction := CompareStr_PLR_IA32_16c;
  53 : CompareStrFunction := CompareStr_PLR_IA32_16d;
  54 : CompareStrFunction := CompareStr_PLR_PAS_1_a;
  55 : CompareStrFunction := CompareStr_PLR_PAS_1_b;
  56 : CompareStrFunction := CompareStr_PLR_PAS_1_c;
  57 : CompareStrFunction := CompareStr_PLR_PAS_1_d;
  58 : CompareStrFunction := CompareStr_PLR_IA32_12a;
  59 : CompareStrFunction := CompareStr_PLR_IA32_12b;
  60 : CompareStrFunction := CompareStr_PLR_IA32_12c;
  61 : CompareStrFunction := CompareStr_PLR_IA32_12d;
  62 : CompareStrFunction := CompareStr_PLR_IA32_14a;
  63 : CompareStrFunction := CompareStr_PLR_IA32_14b;
  64 : CompareStrFunction := CompareStr_PLR_IA32_14c;
  65 : CompareStrFunction := CompareStr_PLR_IA32_14d;
  66 : CompareStrFunction := CompareStr_PLR_IA32_15a;
  67 : CompareStrFunction := CompareStr_PLR_IA32_15b;
  68 : CompareStrFunction := CompareStr_PLR_IA32_15c;
  69 : CompareStrFunction := CompareStr_PLR_IA32_15d;
 else
   raise Exception.Create('Invalid function number');
 end;
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
begin
 Benchmark;
 SortRichEdit;
 BenchmarkTest;
 AlignmentTest;
end;

procedure TMainForm.SaveReportSpeedButtonClick(Sender: TObject);
begin
 SaveDialog.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
 SaveDialog.FileName := FResultsFileName;
 if SaveDialog.Execute then
  ReportRichEdit.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TMainForm.PrintSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('Fastcode CompareStr Challenge Report');
end;

procedure TMainForm.Benchmark;
var
 Bench, SubBench1, SubBench2, SubBench3, FunctionAddress : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;
 FunctionAddressChar : Char;

begin
 try
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  SubBench1 := SubBenchmark1;
  SubBench2 := SubBenchmark2;
  SubBench3 := SubBenchmark3;
  Bench := SubBench1 + SubBench2 + SubBench3;
  FunctionAddress := Cardinal(@CompareStrFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  FunctionAddressChar := FunctionAddressString[8];
  ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressChar
                                        + #9 + IntToStr(SubBench1)
                                        + #9 + IntToStr(SubBench2)
                                        + #9 + IntToStr(SubBench3)
                                        + #9 + IntToStr(Bench));
 except
  FunctionAddress := Cardinal(@CompareStrFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  FunctionAddressChar := FunctionAddressString[8];
  ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressChar
                                        + #9 + '9999'
                                        + #9 + '9999'
                                        + #9 + '9999'
                                        + #9 + '9999');
 end;
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 K : Cardinal;

begin
 BenchmarkAllButton.Caption := 'Running';
 if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_ABOVE_NORMAL) = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_ABOVE_NORMAL failed');
 //for K := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 for K := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := K;
   Benchmark;
   SortRichEdit;
   BenchmarkTest;
   AlignmentTest;
   ReportRichEdit.SelStart := 0;
   ReportRichEdit.Perform(EM_ScrollCaret, 0, 0);
   Update;
  end;
 BenchmarkAllButton.Caption := 'Benchmark All';

 if FileExists(FBenchmarkFileName) then FResultList.LoadFromFile(FBenchmarkFileName);
 FResultList.Add(Format('[%s %s] Running "%s" benchmark version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FBenchmarkFileName);
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 K : Cardinal;

begin
 ValidateAllButton.Caption := 'Running';
 ValidEdit.Text := 'Running';
 ValidEdit.Color := clLime;
 Update;
 for K := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 //for K := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := K;
   CompleteValidate;
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

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
end;

procedure TMainForm.SpreadTestButtonClick(Sender: TObject);
var
 K : Cardinal;
 SpreadTestButtonCaption : AnsiString;

begin
 SpreadTestButtonCaption := SpreadTestButton.Caption;
 SpreadTestButton.Caption := 'Running';
 for K := 0 to 20 do
  begin
   Benchmark;
   SortRichEdit;
   BenchmarkStatistics;
   Update;
  end;
 SpreadTestButton.Caption := SpreadTestButtonCaption;
end;

procedure TMainForm.SpreadBenchPercentageEditClick(Sender: TObject);
begin
 SpreadBenchPercentageEdit.SelectAll;
 SpreadBenchPercentageEdit.CopyToClipboard;
end;

procedure TMainForm.BenchTestButtonClick(Sender: TObject);
var
 I1, I2, I3 : Cardinal;

begin
 BenchTestButton.Caption := 'Running';
 Update;
 //for I1 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 for I1 := 0 to 3 do
  begin
   for I2 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
    begin
     FunctionSelectionRadioGroup.ItemIndex := I2;
     BenchmarkButtonClick(nil);
     Update;
    end;
   FunctionSelectionRadioGroup.ItemIndex := I1;
   BenchmarkButtonClick(nil);
   for I3 := FunctionSelectionRadioGroup.Items.Count-1 downto 0do
    begin
     FunctionSelectionRadioGroup.ItemIndex := I3;
     BenchmarkButtonClick(nil);
     Update;
    end;
   Update;
  end;
 BenchTestButton.Caption := 'Bench Test';
end;

procedure TMainForm.CleanButtonClick(Sender: TObject);
begin
 CleanResultsRichEdit;
 SortRichEdit;
 BenchmarkStatistics;
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
   FunctionAddress := Cardinal(@CompareStrFunction);
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
