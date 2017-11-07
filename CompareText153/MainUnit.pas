unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'CompareText';

type
  TMainForm = class(TForm)
    ValidateButton: TButton;
    ValidEdit: TEdit;
    Label1: TLabel;
    FunctionSelectionRadioGroup: TRadioGroup;
    CloseBitBtn: TBitBtn;
    BenchmarkButton: TButton;
    BenchEdit: TEdit;
    Panel1: TPanel;
    SaveReportSpeedButton: TSpeedButton;
    PrintSpeedButton: TSpeedButton;
    ReportRichEdit: TRichEdit;
    SaveDialog: TSaveDialog;
    BenchmarkAllButton: TButton;
    ValidateAllButton: TButton;
    J2Edit: TEdit;
    J3Edit: TEdit;
    Label2: TLabel;
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
    AboutSpeedButton: TSpeedButton;
    AlignCheckButton: TButton;
    AlignCheckEdit: TEdit;
    procedure FormDestroy(Sender: TObject);
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
    procedure AboutSpeedButtonClick(Sender: TObject);
    procedure AlignCheckButtonClick(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    procedure ClearAllEditBoxes;
    procedure BenchmarkTest;
    procedure AlignmentTest;
    procedure CleanResultsRichEdit;
    procedure SetTabs;
    procedure BenchmarkStatistics;
    procedure SortRichEdit;
    procedure CompleteValidate;
    function Benchmark : Cardinal;
  public
    { Public declarations }
    procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
  end;

var
  MainForm: TMainForm;

type
 TCompareTextFunction = function (const S1, S2: string): Integer;

implementation

uses
 Math, FastcodeCPUID, SystemInfoUnit, CompareTextJOHUnit, CompareTextDKCUnit,
 CompareTextShaUnit, AboutUnit;


{$R *.dfm}

var
 CompareTextFunction : TCompareTextFunction;
 SubBench1StringArray : array of string;
 SubBench2StringArray : array of string;
 SubBench3StringArray : array of string;

const
 SUBBENCH1STRARRAYSIZE : Cardinal = 50;
 SUBBENCH2STRARRAYSIZE : Cardinal = 200;
 SUBBENCH3STRARRAYSIZE : Cardinal = 50;
 MAXSTRINGSIZE : Cardinal = 1000;
 //Adjusted such that each subbenchmark contributes evenly at a P41600A on the RTL function
 SUBBENCH1WEIGTH : Cardinal = 3;
 SUBBENCH2WEIGTH : Cardinal = 11;
 SUBBENCH3WEIGTH : Cardinal = 7;
 MAXINT64 : int64= $7FFFFFFFFFFFFFFF;
 BENCHSCALE : Cardinal = 1000000;
 MAXNOOFRUNS : Cardinal = 5000;
 MAXRUNS : Cardinal = 10;//Must be at least 2

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
 ReportRichEdit.Paragraph.Tab[0] := 130;
 ReportRichEdit.Paragraph.Tab[1] := 160;
 ReportRichEdit.Paragraph.Tab[2] := 190;
 ReportRichEdit.Paragraph.Tab[3] := 220;
 ReportRichEdit.Paragraph.Tab[4] := 260;
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

procedure TMainForm.AboutSpeedButtonClick(Sender: TObject);
begin
 AboutForm.ShowModal;
end;

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

function Validate1 : Boolean;
var
 S1, S2 : string;
 I : Integer;

begin
 S1 := '';
 S2 := '';
 I := CompareTextFunction(S1, S2);
 if I = 0 then
  Result := True
 else
  Result := False;
end;

function Validate2 : Boolean;
var
 S1, S2 : string;
 I : Integer;

begin
 S1 := '';
 S2 := 'A';
 I := CompareTextFunction(S1, S2);
 if I < 0 then
  Result := True
 else
  Result := False;
end;

function Validate3 : Boolean;
var
 S1, S2 : string;
 I : Integer;

begin
 S1 := 'A';
 S2 := '';
 I := CompareTextFunction(S1, S2);
 if I > 0 then
  Result := True
 else
  Result := False;
end;

function Validate4 : Boolean;
var
 S1, S2 : string;
 J1, I : Integer;

begin
 Result := False;
 S1 := 'A';
 S2 := 'A';
 for J1 := 1 to MAXSTRINGSIZE do
  begin
   I := CompareTextFunction(S1, S2);
   S1 := S1 + Char((J1 mod 256));
   S2 := S2 + Char((J1 mod 256));
   if I = 0 then
    Result := True
   else
    begin
     Result := False;
     Break;
    end;
  end;
end;

function Validate5 : Boolean;
var
 S1, S2 : string;
 J1, I : Integer;

begin
 Result := False;
 S1 := 'A';
 S2 := 'B';
 for J1 := 1 to MAXSTRINGSIZE do
  begin
   I := CompareTextFunction(S1, S2);
   S1 := Char((J1 mod 256)) + S1;
   S2 := Char((J1 mod 256)) + S2;
   if I < 0 then
    Result := True
   else
    begin
     Result := False;
     Break;
    end;
  end;
end;

function Validate6 : Boolean;
var
 S1, S2 : string;
 J1, I : Integer;

begin
 Result := False;
 S1 := 'B';
 S2 := 'A';
 for J1 := 1 to MAXSTRINGSIZE do
  begin
   I := CompareTextFunction(S1, S2);
   S1 := Char((J1 mod 256)) + S1;
   S2 := Char((J1 mod 256)) + S2;
   if I > 0 then
    Result := True
   else
    begin
     Result := False;
     Break;
    end;
  end;
end;

function Validate7 : Boolean;
var
 S1, S2 : string;
 J1, I : Integer;

begin
 Result := False;
 S1 := 'a';
 S2 := 'A';
 for J1 := 1 to MAXSTRINGSIZE do
  begin
   I := CompareTextFunction(S1, S2);
   S1 := Char((J1 mod 256)) + S1;
   S2 := Char((J1 mod 256)) + S2;
   if I = 0 then
    Result := True
   else
    begin
     Result := False;
     Break;
    end;
  end;
end;

function Validate8 : Boolean;
var
 S1, S2 : string;
 I1, I2, K1, K2 : Integer;

begin
 Result := True;
 for I1 := 0 to 255 do
  begin
   for I2 := 0 to 255 do
    begin
     S1 := Char(I1);
     S2 := Char(I2);
     K1 := CompareText(S1, S2);
     K2 := CompareTextFunction(S1, S2);
     if (K1 < 0) and (K2 >= 0) then
      begin
       Result := False;
       Break;
      end;
     if (K1 > 0) and (K2 <= 0) then
      begin
       Result := False;
       Break;
      end;
     if (K1 = 0) and (K2 <> 0) then
      begin
       Result := False;
       Break;
      end;
    end;
  end;
end;

function Validate9 : Boolean;
var
 S1, S2 : string;
 I1, I2, I3, K1, K2 : Integer;

begin
 Result := True;
 for I1 := 100 to 255 do
  begin
   for I2 := 0 to 255 do
    begin
     for I3 := 0 to 255 do
      begin
       S1 := Char(I1);
       S2 := Char(I2) + Char(I3);
       K1 := CompareText(S1, S2);
       K2 := CompareTextFunction(S1, S2);
       if (K1 < 0) and (K2 >= 0) then
        begin
         Result := False;
         Break;
        end;
       if (K1 > 0) and (K2 <= 0) then
        begin
         Result := False;
         Break;
        end;
       if (K1 = 0) and (K2 <> 0) then
        begin
         Result := False;
         Break;
        end;
      end;
    end;
  end;
end;

function Validate10 : Boolean;
var
 S1, S2 : string;
 I1, I2, I3, K1, K2 : Integer;

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
       K1 := CompareText(S1, S2);
       K2 := CompareTextFunction(S1, S2);
       if (K1 < 0) and (K2 >= 0) then
        begin
         Result := False;
         Break;
        end;
       if (K1 > 0) and (K2 <= 0) then
        begin
         Result := False;
         Break;
        end;
       if (K1 = 0) and (K2 <> 0) then
        begin
         Result := False;
         Break;
        end;
      end;
    end;
  end;
end;

function Validate11 : Boolean;
var
 S1, S2 : string;
 I1, I2, I3, I4, K1, K2 : Integer;

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
         K1 := CompareText(S1, S2);
         K2 := CompareTextFunction(S1, S2);
         if (K1 < 0) and (K2 >= 0) then
          begin
           Result := False;
           Break;
          end;
         if (K1 > 0) and (K2 <= 0) then
          begin
           Result := False;
           Break;
          end;
         if (K1 = 0) and (K2 <> 0) then
          begin
           Result := False;
           Break;
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
         K1 := CompareText(S1, S2);
         K2 := CompareTextFunction(S1, S2);
         if (K1 < 0) and (K2 >= 0) then
          begin
           Result := False;
           Break;
          end;
         if (K1 > 0) and (K2 <= 0) then
          begin
           Result := False;
           Break;
          end;
         if (K1 = 0) and (K2 <> 0) then
          begin
           Result := False;
           Break;
          end;
        end;
      end;
    end;
  end;
end;

function Validate13 : Boolean;
var
 S1, S2 : string;
 I : Integer;

begin
 S1 := 'a';
 S2 := '\';
 I := CompareTextFunction(S1, S2);
 if I < 0 then
  Result := True
 else
  Result := False;
end;

function Validate14 : Boolean;
var
 S1, S2 : string;
 I1, I2, I3, I4, I5, I6, K1, K2 : Integer;

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
             K1 := CompareText(S1, S2);
             K2 := CompareTextFunction(S1, S2);
             if (K1 < 0) and (K2 >= 0) then
              begin
               Result := False;
               Break;
              end;
             if (K1 > 0) and (K2 <= 0) then
              begin
               Result := False;
               Break;
              end;
             if (K1 = 0) and (K2 <> 0) then
              begin
               Result := False;
               Break;
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

begin
 Result := False;
 S1 := 'aww';
 S2 := 'Aq';
 for J1 := 1 to MAXSTRINGSIZE do
  begin
   I := CompareTextFunction(S1, S2);
   S1 := Char((J1 mod 256)) + S1;
   S2 := Char((J1 mod 256)) + S2;
   if I > 0 then
    Result := True
   else
    begin
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

begin
 S1Global := 'zzzzzzzzzzzzzz';
 S2Global := 'zzzzzzzzzzzzzz';
 (PInteger(Integer(S1Global)-4))^ := 0;
 I := CompareTextFunction(S1Global, S2Global);
 //S1Global is empty -> strings are not equal -> S1Global is the smallest -> I must be negative
 //But the functions must not read from S1Global
 if I < 0 then
  Result := True
 else
  Result := False;
end;

function Validate17 : Boolean;
var
 I : Integer;

begin
 S1Global := 'zzzzzzzzzzzzzz';
 S2Global := '';
 (PInteger(Integer(S1Global)-4))^ := 0;
 I := CompareTextFunction(S1Global, S2Global);
 //S1Global and S2Global are empty -> strings are equal -> I must be 0
 //But the functions must not read from S1Global
 if I = 0 then
  Result := True
 else
  Result := False;
end;

function Validate18 : Boolean;
var
 I : Integer;

begin
 S1Global := '';
 S2Global := 'zzzzzzzzzzzzzz';
 (PInteger(Integer(S2Global)-4))^ := 0;
 I := CompareTextFunction(S1Global, S2Global);
 //S1Global and S2Global are empty -> strings are equal -> I must be 0
 //But the functions must not read from S1Global
 if I = 0 then
  Result := True
 else
  Result := False;
end;

function Validate19 : Boolean;
var
 I : Integer;

begin
 S1Global := 'zzzzzzzzzzzzzz';
 S2Global := 'zzzzzzzzzzzzzz';
 (PInteger(Integer(S1Global)-4))^ := 0;
 (PInteger(Integer(S2Global)-4))^ := 0;
 I := CompareTextFunction(S1Global, S2Global);
 //S1Global and S1Global are empty -> strings are equal -> I must be 0
 //And the functions must not read from S1Global or S2Global
 if I = 0 then
  Result := True
 else
  Result := False;
end;

procedure TMainForm.CompleteValidate;
var
 FunctionName, FunctionAddressString : AnsiString;
 FunctionAddress : Cardinal;

begin
 FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
 FunctionAddress := Cardinal(@CompareTextFunction);
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
    Validate19 then
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
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
begin
 ValidateButton.Caption := 'Running';
 Update;
 CompleteValidate;
 ValidateButton.Caption := 'Validate';
end;

function SubBenchmark1 : Cardinal;
var
 J, J1, J2, J3, J4, Jmax : Integer;
 I1, I2, NoOfRuns, RunNo : Cardinal;
 CPUTick1, CPUTick2, Ticks, SumTicks, TicksMax : Int64;
 TicksArray : array of Int64;

begin
 SetLength(TicksArray, MAXRUNS);
 J1 := 0;
 J2 := 0;
 J3 := 0;
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
 for RunNo := 1 to MAXRUNS do
  begin
   CPUTick1 := GetCPUTick;
   for NoOfRuns := 1 to MAXNOOFRUNS do
    begin
     for I1 := 1 to SUBBENCH1STRARRAYSIZE-1 do
      for I2 := 1 to SUBBENCH1STRARRAYSIZE-2 do
       begin
        J1 := CompareTextFunction(SubBench1StringArray[I1], SubBench1StringArray[I2]);
        J2 := CompareTextFunction(SubBench1StringArray[I2], SubBench1StringArray[I1]);
        J3 := CompareTextFunction(SubBench1StringArray[I1], SubBench1StringArray[I1]);
       end;
    end;
   CPUTick2 := GetCPUTick;
   Ticks := CPUTick2 - CPUTick1;
   if Ticks > 0 then
    TicksArray[RunNo-1] := Ticks
   else
    raise Exception.Create('Ticks overflow');
  end;
 //Remove the longest run
 TicksMax := TicksArray[0];
 Jmax := 0;
 for J4 := 1 to MAXRUNS-1 do
  begin
   if TicksArray[J4] > TicksMax then
    begin
     TicksMax := TicksArray[J4];
     Jmax := J4;
    end;
  end;
 TicksArray[Jmax] := 0;
 SumTicks := 0;
 for J := 0 to MAXRUNS-1 do
  begin
   SumTicks := SumTicks + TicksArray[J];
  end;
 MainForm.J1Edit.Text := IntToStr(J1);
 MainForm.J2Edit.Text := IntToStr(J2);
 MainForm.J3Edit.Text := IntToStr(J3);
 Result := Round(SumTicks / (MAXRUNS-1) / BENCHSCALE);//One bench removed
end;

function SubBenchmark2 : Cardinal;
var
 J, J1, J2, J3, J4, Jmax : Integer;
 I1, I2, NoOfRuns, RunNo : Cardinal;
 CPUTick1, CPUTick2, Ticks, SumTicks, TicksMax : Int64;
 TicksArray : array of Int64;

begin
 SetLength(TicksArray, MAXRUNS);
 J1 := 0;
 J2 := 0;
 J3 := 0;
 SubBench2StringArray[1] := 'S';
 //Create some test strings
 for I1 := 2 to SUBBENCH2STRARRAYSIZE-1 do
  begin
   SubBench2StringArray[I1] := SubBench2StringArray[I1-1] + Char(Random(255));
  end;
 for RunNo := 1 to MAXRUNS do
  begin
   CPUTick1 := GetCPUTick;
   for NoOfRuns := 1 to MAXNOOFRUNS do
    begin
     for I2 := 1 to SUBBENCH2STRARRAYSIZE-2 do
      begin
       J1 := CompareTextFunction(SubBench2StringArray[I2], SubBench2StringArray[I2+1]);
       J2 := CompareTextFunction(SubBench2StringArray[I2+1], SubBench2StringArray[I2]);
       J3 := CompareTextFunction(SubBench2StringArray[I2], SubBench2StringArray[I2]);
      end;
    end;
   CPUTick2 := GetCPUTick;
   Ticks := CPUTick2 - CPUTick1;
   if Ticks > 0 then
    TicksArray[RunNo-1] := Ticks
   else
    raise Exception.Create('Ticks overflow');
  end;
 //Remove the longest run
 TicksMax := TicksArray[0];
 Jmax := 0;
 for J4 := 1 to MAXRUNS-1 do
  begin
   if TicksArray[J4] > TicksMax then
    begin
     TicksMax := TicksArray[J4];
     Jmax := J4;
    end;
  end;
 TicksArray[Jmax] := 0;
 SumTicks := 0;
 for J := 0 to MAXRUNS-1 do
  begin
   SumTicks := SumTicks + TicksArray[J];
  end;
 MainForm.J1Edit.Text := IntToStr(J1);
 MainForm.J2Edit.Text := IntToStr(J2);
 MainForm.J3Edit.Text := IntToStr(J3);
 Result := Round(SumTicks / (MAXRUNS-1) / BENCHSCALE);
end;

function SubBenchmark3 : Cardinal;
var
 J, J1, J2, J3, J4, Jmax : Integer;
 I1, I2, NoOfRuns, RunNo : Cardinal;
 CPUTick1, CPUTick2, Ticks, SumTicks, TicksMax : Int64;
 TicksArray : array of Int64;

begin
 SetLength(TicksArray, MAXRUNS);
 J1 := 0;
 J2 := 0;
 J3 := 0;
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
 for RunNo := 1 to MAXRUNS do
  begin
   CPUTick1 := GetCPUTick;
   for NoOfRuns := 1 to MAXNOOFRUNS do
    begin
     for I1 := 1 to SUBBENCH3STRARRAYSIZE-1 do
      for I2 := 1 to SUBBENCH3STRARRAYSIZE-1 do
       begin
        J1 := CompareTextFunction(SubBench3StringArray[I1], SubBench3StringArray[I2]);
        J2 := CompareTextFunction(SubBench3StringArray[I2], SubBench3StringArray[I1]);
       end;
    end;
   CPUTick2 := GetCPUTick;
   Ticks := CPUTick2 - CPUTick1;
   if Ticks > 0 then
    TicksArray[RunNo-1] := Ticks
   else
    raise Exception.Create('Ticks overflow');
  end;
 //Remove the longest run
 TicksMax := TicksArray[0];
 Jmax := 0;
 for J4 := 1 to MAXRUNS-1 do
  begin
   if TicksArray[J4] > TicksMax then
    begin
     TicksMax := TicksArray[J4];
     Jmax := J4;
    end;
  end;
 TicksArray[Jmax] := 0;
 SumTicks := 0;
 for J := 0 to MAXRUNS-1 do
  begin
   SumTicks := SumTicks + TicksArray[J];
  end;
 MainForm.J1Edit.Text := IntToStr(J1);
 MainForm.J2Edit.Text := IntToStr(J2);
 MainForm.J3Edit.Text := IntToStr(J3);
 Result := Round(SumTicks / (MAXRUNS-1) / BENCHSCALE);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var CpuString : string;
begin
 ClearAllEditBoxes;
 CompareTextFunction := CompareText;
 ReportRichEdit.Clear;
 SetTabs;
 FunctionSelectionRadioGroupClick(nil);
 SetLength(SubBench1StringArray, SUBBENCH1STRARRAYSIZE);
 SetLength(SubBench2StringArray, SUBBENCH2STRARRAYSIZE);
 SetLength(SubBench3StringArray, SUBBENCH3STRARRAYSIZE);

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
  1 : CompareTextFunction := CompareText;
  2 : CompareTextFunction := CompareText;
  3 : CompareTextFunction := CompareText;
  4 : CompareTextFunction := CompareText;
  5 : CompareTextFunction := CompareText_JOH_PAS_1_a;
  6 : CompareTextFunction := CompareText_JOH_PAS_1_b;
  7 : CompareTextFunction := CompareText_JOH_PAS_1_c;
  8 : CompareTextFunction := CompareText_JOH_PAS_1_d;
  9 : CompareTextFunction := CompareText_DKC_Pas_13_a;
  10 : CompareTextFunction := CompareText_DKC_Pas_13_b;
  11 : CompareTextFunction := CompareText_DKC_Pas_13_c;
  12 : CompareTextFunction := CompareText_DKC_Pas_13_d;
  13 : CompareTextFunction := CompareText_DKC_IA32_11_a;
  14 : CompareTextFunction := CompareText_DKC_IA32_11_b;
  15 : CompareTextFunction := CompareText_DKC_IA32_11_c;
  16 : CompareTextFunction := CompareText_DKC_IA32_11_d;
  17 : CompareTextFunction := CompareText_DKC_IA32_12_a;
  18 : CompareTextFunction := CompareText_DKC_IA32_12_b;
  19 : CompareTextFunction := CompareText_DKC_IA32_12_c;
  20 : CompareTextFunction := CompareText_DKC_IA32_12_d;
  21 : CompareTextFunction := CompareText_JOH_IA32_5_a;
  22 : CompareTextFunction := CompareText_JOH_IA32_5_b;
  23 : CompareTextFunction := CompareText_JOH_IA32_5_c;
  24 : CompareTextFunction := CompareText_JOH_IA32_5_d;
  25 : CompareTextFunction := CompareText_JOH_IA32_6_a;
  26 : CompareTextFunction := CompareText_JOH_IA32_6_b;
  27 : CompareTextFunction := CompareText_JOH_IA32_6_c;
  28 : CompareTextFunction := CompareText_JOH_IA32_6_d;
  29 : CompareTextFunction := CompareText_Sha_IA32_3_a;
  30 : CompareTextFunction := CompareText_Sha_IA32_3_b;
  31 : CompareTextFunction := CompareText_Sha_IA32_3_c;
  32 : CompareTextFunction := CompareText_Sha_IA32_3_d;
  33 : CompareTextFunction := CompareText_Sha_IA32_4_a;
  34 : CompareTextFunction := CompareText_Sha_IA32_4_b;
  35 : CompareTextFunction := CompareText_Sha_IA32_4_c;
  36 : CompareTextFunction := CompareText_Sha_IA32_4_d;
  37 : CompareTextFunction := CompareText_Sha_Pas_5_a;
  38 : CompareTextFunction := CompareText_Sha_Pas_5_b;
  39 : CompareTextFunction := CompareText_Sha_Pas_5_c;
  40 : CompareTextFunction := CompareText_Sha_Pas_5_d;
  41 : CompareTextFunction := CompareText_DKC_Pas_17_a;
  42 : CompareTextFunction := CompareText_DKC_Pas_17_b;
  43 : CompareTextFunction := CompareText_DKC_Pas_17_c;
  44 : CompareTextFunction := CompareText_DKC_Pas_17_d;
  45 : CompareTextFunction := CompareText_DKC_Pas_18_a;
  46 : CompareTextFunction := CompareText_DKC_Pas_18_b;
  47 : CompareTextFunction := CompareText_DKC_Pas_18_c;
  48 : CompareTextFunction := CompareText_DKC_Pas_18_d;
  49 : CompareTextFunction := CompareText_DKC_Pas_19_a;
  50 : CompareTextFunction := CompareText_DKC_Pas_19_b;
  51 : CompareTextFunction := CompareText_DKC_Pas_19_c;
  52 : CompareTextFunction := CompareText_DKC_Pas_19_d;
  53 : CompareTextFunction := CompareText_DKC_Pas_20_a;
  54 : CompareTextFunction := CompareText_DKC_Pas_20_b;
  55 : CompareTextFunction := CompareText_DKC_Pas_20_c;
  56 : CompareTextFunction := CompareText_DKC_Pas_20_d;
  57 : CompareTextFunction := CompareText_DKC_Pas_21_a;
  58 : CompareTextFunction := CompareText_DKC_Pas_21_b;
  59 : CompareTextFunction := CompareText_DKC_Pas_21_c;
  60 : CompareTextFunction := CompareText_DKC_Pas_21_d;
 else
  raise Exception.Create('Invalid function number');
 end;
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
var
 Bench : Cardinal;

begin
 Bench := Benchmark;
 BenchEdit.Text := IntToStr(Bench);
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
 ReportRichEdit.Print('Fastcode CompareText Challenge Report');
end;

function TMainForm.Benchmark : Cardinal;
var
 Bench, SubBench1, SubBench2, SubBench3, FunctionAddress : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  SubBench1 := SubBenchmark1;
  SubBench2 := SubBenchmark2;
  SubBench3 := SubBenchmark3;
  Bench := SubBench1 * SUBBENCH1WEIGTH
         + SubBench2 * SUBBENCH2WEIGTH
         + SubBench3 * SUBBENCH3WEIGTH;
  FunctionAddress := Cardinal(@CompareTextFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[8]
                                        + #9 + IntToStr(SubBench1 * SUBBENCH1WEIGTH)
                                        + #9 + IntToStr(SubBench2 * SUBBENCH2WEIGTH)
                                        + #9 + IntToStr(SubBench3 * SUBBENCH3WEIGTH)
                                        + #9 + IntToStr(Bench));
  Result := Bench;
 except
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@CompareTextFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[8]
                                        + #9 + 'Failed'
                                        + #9 + IntToStr(99999)
                                        + #9 + IntToStr(99999)
                                        + #9 + IntToStr(99999));
  Result := 99999;

 end;
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 K, Bench : Cardinal;

begin
 BenchmarkAllButton.Caption := 'Running';
 if SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_ABOVE_NORMAL) = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_ABOVE_NORMAL failed');
 for K := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
 //for K := FunctionSelectionRadioGroup.Items.Count-1 downto 0 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := K;
   Bench := Benchmark;
   BenchEdit.Text := IntToStr(Bench);
   SortRichEdit;
   BenchmarkTest;
   AlignmentTest;
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
 K, Bench : Cardinal;
 SpreadTestButtonCaption : AnsiString;

begin
 SpreadTestButtonCaption := SpreadTestButton.Caption;
 SpreadTestButton.Caption := 'Running';
 for K := 0 to 20 do
  begin
   Bench := Benchmark;
   SortRichEdit;
   BenchmarkStatistics;
   BenchEdit.Text := IntToStr(Bench);
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
 I1, I2 : Cardinal;

begin
 BenchTestButton.Caption := 'Running';
 Update;
 for I1 := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
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
   FunctionAddress := Cardinal(@CompareTextFunction);
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

procedure TMainForm.CleanButtonClick(Sender: TObject);
begin
 CleanResultsRichEdit;
 SortRichEdit;
 BenchmarkStatistics;
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
