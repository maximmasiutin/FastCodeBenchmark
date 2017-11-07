unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, TeeProcs, TeEngine, Chart, ComCtrls, ExtCtrls;

const
  WM_POSTPROCESSING = WM_USER + 1;
  CHALLENGE_NAME = 'StrCopy';

type
  TMainForm = class(TForm)
    TopPanel: TPanel;
    SaveSpeedButton: TSpeedButton;
    ReportRichEdit: TRichEdit;
    CloseBitBtn: TBitBtn;
    BenchmarkButton: TButton;
    FunctionSelectionRadioGroup: TRadioGroup;
    ValidateButton: TButton;
    ValidateAllButton: TButton;
    BenchmarkAllButton: TButton;
    SaveDialog: TSaveDialog;
    ClearButton: TButton;
    SpreadTestButton: TButton;
    MaxBenchEdit: TEdit;
    MinBenchEdit: TEdit;
    SpreadBenchPercentageEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    FunctionNameEdit: TEdit;
    MaxSpreadBenchPercentageEdit: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Bench1Edit: TEdit;
    Bench2Edit: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    ValidateBenchmarkButton: TButton;
    AlignMaxSpreadBenchPercentageEdit: TEdit;
    AlignFunctionName1Edit: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    AlignFunctionName2Edit: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    AlignmentBench1Edit: TEdit;
    Label16: TLabel;
    AlignmentBench2Edit: TEdit;
    Label17: TLabel;
    CleanButton: TButton;
    Label18: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure BenchmarkButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FunctionSelectionRadioGroupClick(Sender: TObject);
    procedure BenchmarkAllButtonClick(Sender: TObject);
    procedure SaveSpeedButtonClick(Sender: TObject);
    procedure ValidateButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure SpreadTestButtonClick(Sender: TObject);
    procedure SpreadBenchPercentageEditClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ValidateBenchmarkButtonClick(Sender: TObject);
    procedure CleanButtonClick(Sender: TObject);
  private
    FValidationFileName, FBenchmarkFileName, FResultsFileName : string;
    FResultList: TStringList;
    procedure CleanResultsRichEdit;
    procedure AlignmentTest;
    procedure ClearAllEditBoxes;
    procedure BenchmarkTest;
    procedure BenchmarkStatistics;
    procedure SetTabs;
    procedure Benchmark;
    procedure SortRichEdit;
  public
    procedure WMPOSTPROCESSING(var msg: TMessage); message WM_POSTPROCESSING;
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
 FastcodeCPUID, SystemInfoUnit, StrCopyDKCUnit, StrCopyJOHUnit, StrCopySHAUnit, StrCopyLBGUnit, StrCopyASUnit;

{$R *.dfm}

type
 TStrCopyFunction = function (Dest: PChar; const Source: PChar): PChar;

const
 CROSSOVERLENGTH : Cardinal = 30;
 NOOFRUNS : Cardinal = 75000;
 //Repeat benchmark runs and calculate average result must be >= 2 - Biggest result is removd
 NOOFREPEATS : Cardinal = 12;
 //Equal score for subbenches on P4 and fastest function
 SUBBENCH1SCALE : Cardinal = 2500;
 SUBBENCH2SCALE : Cardinal = 530;
 SUBBENCH3SCALE : Cardinal = 6000;
 MAXSTRLENSUBBENCH2 : Cardinal = 100;
 MAXSTRLENSUBBENCH3 : Cardinal = 50;
 MINSTRLENSUBBENCH3 : Cardinal = 10;
var
 StrCopyFunction : TStrCopyFunction;
 SourceStringArraySubBench1 : array of AnsiString;
 DestinationStringArraySubBench1 : array of AnsiString;
 SourceStringArraySubBench2 : array of AnsiString;
 DestinationStringArraySubBench2 : array of AnsiString;
 DestinationArraySubBench3 : array of Char;
 SourceArraySubBench3 : array of Char;

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

function GetCPUTick: Int64; assembler;
asm
 rdtsc
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
       if AverageBench > 0 then
        Spread := 100 * DeltaBench / AverageBench
       else
        Spread := 99999;
       if Spread > MaxSpread then
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
 AlignmentBench1Edit.Text := '';
 AlignmentBench2Edit.Text := '';
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
           if AverageBench > 0 then
            Spread := 100 * DeltaBench / AverageBench
           else
            Spread := 999999;
           if Spread > MaxSpread then
            begin
             AlignmentBench1Edit.Text := BenchString1;
             AlignmentBench2Edit.Text := BenchString2;
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

procedure TMainForm.SetTabs;
begin
 ReportRichEdit.Paragraph.TabCount := 5;
 ReportRichEdit.Paragraph.Tab[0] := 120;
 ReportRichEdit.Paragraph.Tab[1] := 150;
 ReportRichEdit.Paragraph.Tab[2] := 190;
 ReportRichEdit.Paragraph.Tab[3] := 230;
 ReportRichEdit.Paragraph.Tab[4] := 280;
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

function Validate1 : Boolean;
var
 Dest1, Dest2, Src : PChar;
 SrcArray : array[0..1] of Char;
 DestArray : array[0..1] of Char;

begin
 Src := SrcArray;
 Dest1 := DestArray;
 SrcArray[0] := #0;
 SrcArray[1] := 'X';
 DestArray[0] := 'A';
 DestArray[1] := 'A';
 Dest2 := StrCopyFunction(Dest1, Src);
 if Dest1 <> Dest2 then
  begin
   Result := False;
   Exit;
  end;
 if ((DestArray[0] <> SrcArray[0]) or
     (DestArray[1] =  SrcArray[1])) then
  Result := False
 else
  Result := True;
end;

function Validate2 : Boolean;
var
 Dest1, Dest2, Src : PChar;
 SrcArray : array[0..1] of Char;
 DestArray : array[0..1] of Char;
begin
 Src := SrcArray;
 Dest1 := DestArray;
 SrcArray[0] := #0;
 DestArray[0] := 'X';
 SrcArray[1] := 'y';
 DestArray[1] := 'i';
 Dest2 := StrCopyFunction(Dest1, Src);
 if Dest1 <> Dest2 then
  begin
   Result := False;
   Exit;
  end;
 if Dest1[0] <> Src[0] then
  Result := False
 else
  Result := True;
end;

function Validate3 : Boolean;
var
 Dest, Src : PChar;
 DestArray : array[0..1] of Char;
begin
 Src := 'B';
 Dest := DestArray;
 DestArray[0] := 'X';
 Dest := StrCopyFunction(Dest, Src);
 if Dest[0] <> Src[0] then
  Result := False
 else
  Result := True;
end;

function Validate4 : Boolean;
var
 Dest, Src : PChar;
 DestArray : array[0..1] of Char;
begin
 Src := 'B';
 Dest := DestArray;
 DestArray[0] := 'X';
 StrCopyFunction(Dest, Src);
 if Dest[0] <> Src[0] then
  Result := False
 else
  Result := True;
end;

function Validate5 : Boolean;
var
 Dest1, Dest2, Src : PChar;
 SrcArray,
 DestArray : array[0..10000] of Char;
 I1, I2, SrcArraySize, DestArraySize : Cardinal;
 StrComparison : Integer;

begin
 SrcArraySize := Length(SrcArray);
 DestArraySize := Length(DestArray);
 if SrcArraySize <> DestArraySize then
  raise Exception.Create('SrcArray and DestArray not same size');
 for I1 := 0 to SrcArraySize-2 do
  begin
   SrcArray[I1] := 'A';
  end;
 SrcArray[SrcArraySize-1] := #0;
 for I2 := 0 to SrcArraySize-2 do
  begin
   DestArray[I2] := 'X';
  end;
 DestArray[DestArraySize-1] := #0;
 Src := SrcArray;
 Dest1 := DestArray;
 Dest2 := StrCopyFunction(Dest1, Src);
 if Dest1 <> Dest2 then
  begin
   Result := False;
   Exit;
  end;
 StrComparison := StrComp(Src, Dest1);
 if StrComparison <> 0 then
  Result := False
 else
  Result := True;
end;

function Validate6 : Boolean;
var
 Dest, Src : PChar;
 SrcArray : array[0..4000] of Char;
 DestArray : array[0..4000] of Char;
 I1, I2, SrcArraySize, DestArraySize, ArraySize : Cardinal;
 StrComparison : Integer;
begin
 SrcArraySize := Length(SrcArray);
 DestArraySize := Length(DestArray);
 if SrcArraySize <> DestArraySize then
  raise Exception.Create('SrcArray and DestArray not same size');
 Result := True;
 for ArraySize := 2 to DestArraySize do
  begin
   if ArraySize > DestArraySize then
    raise Exception.Create('ArraySize to big');
   for I1 := 0 to ArraySize-2 do
    begin
     SrcArray[I1] := 'A';
    end;
   SrcArray[ArraySize-1] := #0;
   for I2 := 0 to ArraySize-2 do
    begin
     DestArray[I2] := 'X';
    end;
   DestArray[ArraySize-1] := #0;
   Src := SrcArray;
   Dest := DestArray;
   StrCopyFunction(Dest, Src);
   //Result := True;
   StrComparison := StrComp(Src, Dest);
   if StrComparison <> 0 then
    begin
     Result := False;
     Break;
    end
   else
    Result := True;
  end;
end;

function Validate7 : Boolean;
var
 Dest, Src : PChar;
 SrcArray : array[0..10] of Char;
 DestArray : array[0..10] of Char;
 I1, I2, I3, I4 : Cardinal;

begin
 for I1 := 0 to Length(SrcArray)-1 do
  begin
   SrcArray[I1] := 'A';
   DestArray[I1] := 'X';
  end;
 SrcArray[7] := #0;
 Src := SrcArray;
 Dest := DestArray;
 Inc(Src,4);
 Inc(Dest,4);
 Dest := StrCopyFunction(Dest, Src);
 //Use Dest to something
 if Dest[0] <> Src[0] then
  begin
   Result := False;
   Exit;
  end;
 Result := True;
 //Are the correct bytes copied?
 for I2 := 5 to 7 do
  begin
   if SrcArray[I2] <> DestArray[I2] then
    begin
     Result := False;
     Exit;
    end;
  end;
 //Is there copied anything after the string that should not?
 for I3 := 8 to Length(SrcArray)-1 do
  begin
   if SrcArray[I3] = DestArray[I3] then
    begin
     Result := False;
     Exit;
    end;
  end;
 //Is copied anything before the string that should not?
 for I4 := 0 to 3 do
  begin
   if SrcArray[I4] = DestArray[I4] then
    begin
     Result := False;
     Exit;
    end;
  end;
end;

function Validate8 : Boolean;
var
 Dest, Src : PChar;
 SrcArray : array[0..10] of Char;
 DestArray : array[0..10] of Char;
 DestCopyArray : array[0..10] of Char;
 I1, I2, I3, I4 : Cardinal;

begin
 for I1 := 0 to Length(SrcArray)-1 do
  begin
   SrcArray[I1] := 'A';
   DestArray[I1] := 'X';
   DestCopyArray[I1] := 'X';
  end;
 SrcArray[7] := #0;
 Src := SrcArray;
 Dest := DestArray;
 Inc(Src,4);
 Inc(Dest,4);
 Dest := StrCopyFunction(Dest, Src);
 //Use Dest to something
 if Dest[0] <> Src[0] then
  begin
   Result := False;
   Exit;
  end;
 Result := True;
 //Are the correct bytes copied?
 for I2 := 5 to 7 do
  begin
   if SrcArray[I2] <> DestArray[I2] then
    begin
     Result := False;
     Exit;
    end;
  end;
 //Is copied anything after the string that should not?
 for I3 := 8 to Length(SrcArray)-1 do
  begin
   if DestArray[I3] <> DestCopyArray[I3] then
    begin
     Result := False;
     Exit;
    end;
  end;
 //Is copied anything before the string that should not?
 for I4 := 0 to 3 do
  begin
   if SrcArray[I4] = DestArray[I4] then
    begin
     Result := False;
     Exit;
    end;
  end;
end;

function Validate9 : Boolean;
var
 Dest, Src : PChar;
 SrcArray : array[0..400] of Char;
 DestArray : array[0..400] of Char;
 DestCopyArray : array[0..400] of Char;
 I1, I2, I3, I4 : Cardinal;
 EndOfSourcePos, StartOfSourcePos : Cardinal;

begin
 StartOfSourcePos := 25;
 Result := True;
 for EndOfSourcePos := StartOfSourcePos to Length(SrcArray)-25 do
  begin
   for I1 := 0 to Length(SrcArray)-1 do
    begin
     SrcArray[I1] := 'B';
     DestArray[I1] := 'Y';
     DestCopyArray[I1] := 'Y';
    end;
   SrcArray[EndOfSourcePos] := #0;
   Src := SrcArray;
   Dest := DestArray;
   //Place PChars in "middle" of arrays
   Inc(Src, StartOfSourcePos);
   Inc(Dest, StartOfSourcePos);
   Dest := StrCopyFunction(Dest, Src);
   //Use Dest to something
   if Dest[0] <> Src[0] then
    begin
     Result := False;
     Exit;
    end;
   //Are the correct bytes copied?
   for I2 := StartOfSourcePos+1 to EndOfSourcePos do
    begin
     if SrcArray[I2] <> DestArray[I2] then
      begin
       Result := False;
       Exit;
      end;
    end;
   //Is copied anything after the string that should not?
   for I3 := EndOfSourcePos+1 to Length(SrcArray)-1 do
    begin
     if DestArray[I3] <> DestCopyArray[I3] then
      begin
       Result := False;
       Exit;
      end;
    end;
   //Is copied anything before the string that should not?
   for I4 := 0 to StartOfSourcePos-1 do
    begin
     if SrcArray[I4] = DestArray[I4] then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
end;

function Validate10 : Boolean;
var
 Dest, Src : PChar;
 SrcArray : array[0..4000] of Char;
 DestArray : array[0..4000] of Char;
 DestCopyArray : array[0..4000] of Char;
 I1, I2, I3, I4 : Cardinal;
 EndOfSourcePos, StartOfSourcePos : Cardinal;

begin
 StartOfSourcePos := 250;
 Result := True;
 for EndOfSourcePos := StartOfSourcePos to Length(SrcArray) - 250 do
  begin
   for I1 := 0 to Length(SrcArray)-1 do
    begin
     SrcArray[I1] := 'B';
     DestArray[I1] := 'Y';
     DestCopyArray[I1] := 'Y';
    end;
   SrcArray[EndOfSourcePos] := #0;
   Src := SrcArray;
   Dest := DestArray;
   //Place PChars in "middle" of arrays
   Inc(Src, StartOfSourcePos);
   Inc(Dest, StartOfSourcePos);
   Dest := StrCopyFunction(Dest, Src);
   //Use Dest to something
   if Dest[0] <> Src[0] then
    begin
     Result := False;
     Exit;
    end;
   //Are the correct bytes copied?
   for I2 := StartOfSourcePos+1 to EndOfSourcePos do
    begin
     if SrcArray[I2] <> DestArray[I2] then
      begin
       Result := False;
       Exit;
      end;
    end;
   //Is copied anything after the string that should not?
   for I3 := EndOfSourcePos+1 to Length(SrcArray)-1 do
    begin
     if DestArray[I3] <> DestCopyArray[I3] then
      begin
       Result := False;
       Exit;
      end;
    end;
   //Is copied anything before the string that should not?
   for I4 := 0 to StartOfSourcePos-1 do
    begin
     if SrcArray[I4] = DestArray[I4] then
      begin
       Result := False;
       Exit;
      end;
    end;
  end;
end;

function Validate11 : Boolean;
var
 Dest1, Dest2, Src : PChar;
 SrcArray : array[0..0] of Char;
 DestArray : array[0..0] of Char;

begin
 try
  Result := True;
  Src := SrcArray;
  Dest1 := DestArray;
  SrcArray[0] := #0;
  DestArray[0] := 'x';
  Dest2 := StrCopyFunction(Dest1, Src);
  if (Dest1 <> Dest2) or (DestArray[0] <> SrcArray[0]) then
   Result := False;
 except
  //If functions reads past end of PChar an exception can be raised if we are very lucky
  Result := False;
 end;
end;

function Validate12 : Boolean;
var
 Dest1, Dest2, Src : PChar;
 SrcArray : array[0..1] of Char;
 DestArray : array[0..1] of Char;

begin
 try
  Result := True;
  Src := SrcArray;
  Dest1 := DestArray;
  SrcArray[0] := 'A';
  SrcArray[1] := #0;
  DestArray[0] := 'x';
  DestArray[1] := 'x';
  Dest2 := StrCopyFunction(Dest1, Src);
  if (Dest1 <> Dest2) or (DestArray[0] <> SrcArray[0]) or (DestArray[1] <> SrcArray[1]) then
   Result := False;
 except
  //If functions reads past end of PChar an exception can be raised if we are very lucky
  Result := False;
 end;
end;

function Validate13 : Boolean;
var
 Dest1, Dest2, Src : PChar;
 SrcArray : array[0..2] of Char;
 DestArray : array[0..2] of Char;

begin
 try
  Result := True;
  Src := SrcArray;
  Dest1 := DestArray;
  SrcArray[0] := 'A';
  SrcArray[1] := 'A';
  SrcArray[2] := #0;
  DestArray[0] := 'x';
  DestArray[1] := 'x';
  DestArray[2] := 'x';
  Dest2 := StrCopyFunction(Dest1, Src);
  if  (Dest1 <> Dest2)
   or (DestArray[0] <> SrcArray[0])
   or (DestArray[1] <> SrcArray[1])
   or (DestArray[2] <> SrcArray[2]) then
   Result := False;
 except
  //If functions reads past end of PChar an exception can be raised if we are very lucky
  Result := False;
 end;
end;

function Validate14 : Boolean;
var
 Dest1, Dest2, Src : PChar;
 SrcArray : array[0..3] of Char;
 DestArray : array[0..3] of Char;

begin
 try
  Result := True;
  Src := SrcArray;
  Dest1 := DestArray;
  SrcArray[0] := 'A';
  SrcArray[1] := 'A';
  SrcArray[2] := 'A';
  SrcArray[3] := #0;
  DestArray[0] := 'x';
  DestArray[1] := 'x';
  DestArray[2] := 'x';
  DestArray[3] := 'x';
  Dest2 := StrCopyFunction(Dest1, Src);
  if  (Dest1 <> Dest2)
   or (DestArray[0] <> SrcArray[0])
   or (DestArray[1] <> SrcArray[1])
   or (DestArray[2] <> SrcArray[2])
   or (DestArray[3] <> SrcArray[3]) then
   Result := False;
 except
  //If functions reads past end of PChar an exception can be raised if we are very lucky
  Result := False;
 end;
end;

function Validate15 : Boolean;            
var
  P, F: PChar;
begin
  P := StrNew('1234567');
  F := StrNew('1234567');
  try
    StrCopy(F, F + 1);
    StrCopyFunction(P, P + 1);
    Result := (StrComp(P, F) = 0);
  finally
    StrDispose(P);
    StrDispose(F);
  end;
  if not Result then
    Exit;

  P := StrNew('12345678');
  F := StrNew('12345678');
  try
    StrCopy(F, F + 1);
    StrCopyFunction(P, P + 1);
    Result := (StrComp(P, F) = 0);
  finally
    StrDispose(P);
    StrDispose(F);
  end;
  if not Result then
    Exit;

  P := StrNew('123456789');
  F := StrNew('123456789');
  try
    StrCopy(F, F + 1);
    StrCopyFunction(P, P + 1);
    Result := (StrComp(P, F) = 0);
  finally
    StrDispose(P);
    StrDispose(F);
  end;
  if not Result then
    Exit;

  P := StrNew('1234567890');
  F := StrNew('1234567890');
  try
    StrCopy(F, F + 1);
    StrCopyFunction(P, P + 1);
    Result := (StrComp(P, F) = 0);
  finally
    StrDispose(P);
    StrDispose(F);
  end;
end;

function Validate16 : Boolean;
var
 Pages, BasePage, Str : PChar;
 Page, adr, PageBorderAdr, StrStartAdr, TerminatorAdr : PChar;
 flags, Oldflags: dword;
 StrSize, J, K : Integer;
const
 PageSize = 4*1024;//4 kB = 4096 Byte
 MAXSTRSIZE : Integer = PageSize - 1;//Leave 1 bytes for the #0
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
        StrCopyFunction(Str, Str);
        StrCopyFunction(Page, Str);
       except
        Result := False;
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

//Validation code from Andreas Hausladen / DelphiSpeedup 
function Validate17 : Boolean;
const
  SourceString = '| Classes,| Controls,| StdCtrls';
  ResultString = ' Classes,| Controls,| StdCtrls';
var
    P, F: PChar;
    S   : string;
begin
  Result := True;

  S := SourceString;

    P := StrAlloc(16 + Length(S) + 1);
    F := P;
    try
      while (Longword(P) and $9 <> $9) do  // "align" to $xxxxxxx9
        Inc(P);
      StrPCopy(P, S);
      P := StrCopyFunction(P, P + 1);
      if StrComp(P, ResultString) <> 0 then Result := False;
    finally
      StrDispose(F);
    end;
end;

function SubBenchmark1 : Cardinal;
var
 I1, I2, I4, RunNo : Cardinal;
 Dest, Source : PChar;
 NoOfTicks, MinNoOfTicks, StartCount, lpFrequency, lpPerformanceCount, EndCount : Int64;
 TicksArray : array of Int64;
 Succes : Boolean;
 RunTimeSec : Double;

begin
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(TicksArray, NOOFREPEATS);
 for RunNo := 1 to NOOFREPEATS do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 1 to NOOFRUNS do
    begin
     for I1 := 0 to CROSSOVERLENGTH-1 do
      begin
       Source := PChar(SourceStringArraySubBench1[I1]);
       Dest := PChar(DestinationStringArraySubBench1[I1]);
       StrCopyFunction(Dest, Source);
       StrCopyFunction(Source, Dest);
      end;
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   TicksArray[RunNo-1] := NoOfTicks;
  end;
 //Get fastest run
 MinNoOfTicks := TicksArray[0];
 for I4 := 1 to NOOFREPEATS-1 do
  begin
   if TicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := TicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH1SCALE);
end;

function SubBenchmark2 : Cardinal;
var
 I1, I2, I4, RunNo : Cardinal;
 Dest, Source : PChar;
 NoOfTicks, MinNoOfTicks, StartCount, lpFrequency, lpPerformanceCount, EndCount : Int64;
 TicksArray : array of Int64;
 Succes : Boolean;
 RunTimeSec : Double;

begin
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(TicksArray, NOOFREPEATS);
 for RunNo := 1 to NOOFREPEATS do
  begin
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   for I2 := 1 to NOOFRUNS do
    begin
     for I1 := 0 to MAXSTRLENSUBBENCH2-CROSSOVERLENGTH-1 do
      begin
       Source := PChar(SourceStringArraySubBench2[I1]);
       Dest := PChar(DestinationStringArraySubBench2[I1]);
       StrCopyFunction(Dest, Source);
       StrCopyFunction(Source, Dest);
      end;
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   TicksArray[RunNo-1] := NoOfTicks;
  end;
 //Get fastest run
 MinNoOfTicks := TicksArray[0];
 for I4 := 1 to NOOFREPEATS-1 do
  begin
   if TicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := TicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH2SCALE);
end;

function SubBenchmark3 : Cardinal;
var
 I4, I1, I2, I3, RunNo : Cardinal;
 Dest, Source : PChar;
 MinNoOfTicks, NoOfTicks, EndCount, StartCount, lpFrequency, lpPerformanceCount : Int64;
 TicksArray : array of Int64;
 Succes : Boolean;
 RunTimeSec : Double;

begin
 Succes := QueryPerformanceFrequency(lpFrequency);
 if not Succes then
  raise Exception.Create('QueryPerformanceFrequency failed');
 SetLength(TicksArray, NOOFREPEATS);
 for RunNo := 1 to NOOFREPEATS do
  begin
   Dest := @DestinationArraySubBench3[0];
   Source := @SourceArraySubBench3[0];
   for I3 := 0 to MAXSTRLENSUBBENCH3-1 do
    begin
     DestinationArraySubBench3[I3] := 'X';
     SourceArraySubBench3[I3] := Char(I3+1);
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    StartCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   I1 := MAXSTRLENSUBBENCH3-1;
   while I1 > MINSTRLENSUBBENCH3 do
    begin
     Dest[I1] := #0;
     Source[I1] := #0;
     for I2 := 1 to NOOFRUNS do
      begin
       StrCopyFunction(Dest, Source);
      end;
     Dest[I1] := 'B';
     Source[I1] := 'A';
     Dest[0] := 'C';
     Source[0] := 'D';
     Inc(Dest);
     Inc(Source);
     Dec(I1,2);
    end;
   Succes := QueryPerformanceCounter(lpPerformanceCount);
   if Succes then
    EndCount := lpPerformanceCount
   else
    raise Exception.Create('QueryPerformanceCounter failed');
   NoOfTicks := EndCount - StartCount;
   if NoOfTicks < 0 then
    raise Exception.Create('Tick counter wrapped around');
   TicksArray[RunNo-1] := NoOfTicks;
  end;
 //Get fastest run
 MinNoOfTicks := TicksArray[0];
 for I4 := 1 to NOOFREPEATS-1 do
  begin
   if TicksArray[I4] < MinNoOfTicks then
    MinNoOfTicks := TicksArray[I4];
  end;
 RunTimeSec := MinNoOfTicks / lpFrequency;
 Result := Round(RunTimeSec*SUBBENCH3SCALE);
end;

procedure TMainForm.Benchmark;
var
 SubBench1, SubBench2, SubBench3, Bench, FunctionAddress : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 try
  FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
  FunctionAddress := Cardinal(@StrCopyFunction);
  FunctionAddressString := IntToHex(FunctionAddress, 8);
  SubBench1 := SubBenchMark1;
  SubBench2 := SubBenchMark2;
  SubBench3 := SubBenchMark3;
  Bench := SubBench1 + SubBench2 + SubBench3;
  ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[8]
                                        + #9 + IntToStr(SubBench1)
                                        + #9 + IntToStr(SubBench2)
                                        + #9 + IntToStr(SubBench3)
                                        + #9 + IntToStr(Bench));
 except
  ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[8]
                                        + #9 + 'Failed'
                                        + #9 + '99999'
                                        + #9 + '99999'
                                        + #9 + '99999');
 end;
end;

procedure TMainForm.BenchmarkButtonClick(Sender: TObject);
var
 Succes : Boolean;

begin
 Succes := SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_HIGHEST);
 if Succes = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_HIGHEST failed');
 Benchmark;
 SortRichEdit;
 BenchmarkTest;
 Update;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
 I1, I2 : Cardinal;
 CpuString : string;

begin
 Caption := Caption + ' Version ' + GetFormattedVersion;
 ClearAllEditBoxes;
 StrCopyFunction := StrCopy;
 ReportRichEdit.Clear;
 FunctionSelectionRadioGroupClick(nil);
 SetLength(SourceStringArraySubBench1, CROSSOVERLENGTH);
 SetLength(DestinationStringArraySubBench1, CROSSOVERLENGTH);
 for I1 := 1 to CROSSOVERLENGTH do
  begin
   for I2 := 1 to I1 do
    begin
     SourceStringArraySubBench1[I1-1] := SourceStringArraySubBench1[I1-1] + 'A';
     DestinationStringArraySubBench1[I1-1] := DestinationStringArraySubBench1[I1-1] + 'B';
    end;
  end;
 SetLength(SourceStringArraySubBench2, MAXSTRLENSUBBENCH2-CROSSOVERLENGTH);
 SetLength(DestinationStringArraySubBench2, MAXSTRLENSUBBENCH2-CROSSOVERLENGTH);
 for I1 := 1 to MAXSTRLENSUBBENCH2-CROSSOVERLENGTH do
  begin
   for I2 := 1 to I1+CROSSOVERLENGTH do
    begin
     SourceStringArraySubBench2[I1-1] := SourceStringArraySubBench2[I1-1] + 'A';
     DestinationStringArraySubBench2[I1-1] := DestinationStringArraySubBench2[I1-1] + 'B';
    end;
  end;
 SetLength(SourceArraySubBench3, MAXSTRLENSUBBENCH3);
 SetLength(DestinationArraySubBench3, MAXSTRLENSUBBENCH3);
 SourceArraySubBench3[MAXSTRLENSUBBENCH3-1] := #0;
 DestinationArraySubBench3[MAXSTRLENSUBBENCH3-1] := #0;
 FillChar(SourceArraySubBench3[0], MAXSTRLENSUBBENCH3-1, 'X');
 FillChar(DestinationArraySubBench3[0], MAXSTRLENSUBBENCH3-1, 'Y');

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
  1 : StrCopyFunction := StrCopy;
  2 : StrCopyFunction := StrCopy_DKC_IA32_1_a;
  3 : StrCopyFunction := StrCopy_DKC_IA32_1_b;
  4 : StrCopyFunction := StrCopy_DKC_IA32_1_c;
  5 : StrCopyFunction := StrCopy_DKC_IA32_1_d;
  6 : StrCopyFunction := StrCopy_Lbg_IA32_1_a;
  7 : StrCopyFunction := StrCopy_Lbg_IA32_1_b;
  8 : StrCopyFunction := StrCopy_Lbg_IA32_1_c;
  9 : StrCopyFunction := StrCopy_Lbg_IA32_1_d;
  10 : StrCopyFunction := StrCopy_Sha_Pas_1_a;
  11 : StrCopyFunction := StrCopy_Sha_Pas_1_b;
  12 : StrCopyFunction := StrCopy_Sha_Pas_1_c;
  13 : StrCopyFunction := StrCopy_Sha_Pas_1_d;
  14 : StrCopyFunction := StrCopy_DKC_Pas_13_a;
  15 : StrCopyFunction := StrCopy_DKC_Pas_13_b;
  16 : StrCopyFunction := StrCopy_AS_IA32_5_a;
  17 : StrCopyFunction := StrCopy_AS_IA32_5_b;
  18 : StrCopyFunction := StrCopy_AS_IA32_5_c;
  19 : StrCopyFunction := StrCopy_AS_IA32_5_d;
  20 : StrCopyFunction := StrCopy_DKC_IA32_2_a;
  21 : StrCopyFunction := StrCopy_DKC_IA32_2_b;
  22 : StrCopyFunction := StrCopy_DKC_IA32_2_c;
  23 : StrCopyFunction := StrCopy_DKC_IA32_2_d;
  24 : StrCopyFunction := StrCopy_Sha_IA32_4_a;
  25 : StrCopyFunction := StrCopy_Sha_IA32_4_b;
  26 : StrCopyFunction := StrCopy_Sha_IA32_4_c;
  27 : StrCopyFunction := StrCopy_Sha_IA32_4_d;
  28 : StrCopyFunction := StrCopy_DKC_IA32_3_a;
  29 : StrCopyFunction := StrCopy_DKC_IA32_3_b;
  30 : StrCopyFunction := StrCopy_DKC_IA32_3_c;
  31 : StrCopyFunction := StrCopy_DKC_IA32_3_d;
  32 : StrCopyFunction := StrCopy_AS_IA32_6_a;
  33 : StrCopyFunction := StrCopy_AS_IA32_6_b;
  34 : StrCopyFunction := StrCopy_AS_IA32_6_c;
  35 : StrCopyFunction := StrCopy_AS_IA32_6_d;
  36 : StrCopyFunction := StrCopy_Sha_IA32_2_a;
  37 : StrCopyFunction := StrCopy_Sha_IA32_2_b;
  38 : StrCopyFunction := StrCopy_Sha_IA32_2_c;
  39 : StrCopyFunction := StrCopy_Sha_IA32_2_d;
  40 : StrCopyFunction := StrCopy_Sha_IA32_3_a;
  41 : StrCopyFunction := StrCopy_Sha_IA32_3_b;
  42 : StrCopyFunction := StrCopy_Sha_IA32_3_c;
  43 : StrCopyFunction := StrCopy_Sha_IA32_3_d;
  44 : StrCopyFunction := StrCopy_DKC_IA32_4_a;
  45 : StrCopyFunction := StrCopy_DKC_IA32_4_b;
  46 : StrCopyFunction := StrCopy_DKC_IA32_4_c;
  47 : StrCopyFunction := StrCopy_DKC_IA32_4_d;
  48 : StrCopyFunction := StrCopy_DKC_IA32_5_a;
  49 : StrCopyFunction := StrCopy_DKC_IA32_5_b;
  50 : StrCopyFunction := StrCopy_DKC_IA32_5_c;
  51 : StrCopyFunction := StrCopy_DKC_IA32_5_d;

  52 : StrCopyFunction := StrCopy_JOH_PAS_4_a;
  53 : StrCopyFunction := StrCopy_JOH_PAS_4_b;
  54 : StrCopyFunction := StrCopy_JOH_PAS_4_c;
  55 : StrCopyFunction := StrCopy_JOH_PAS_4_d;

  56 : StrCopyFunction := StrCopy_JOH_IA32_6_a;
  57 : StrCopyFunction := StrCopy_JOH_IA32_6_b;
  58 : StrCopyFunction := StrCopy_JOH_IA32_6_c;
  59 : StrCopyFunction := StrCopy_JOH_IA32_6_d;

  60 : StrCopyFunction := StrCopy_JOH_IA32_7_a;
  61 : StrCopyFunction := StrCopy_JOH_IA32_7_b;
  62 : StrCopyFunction := StrCopy_JOH_IA32_7_c;
  63 : StrCopyFunction := StrCopy_JOH_IA32_7_d;

  64 : StrCopyFunction := StrCopy_JOH_IA32_8_a;
  65 : StrCopyFunction := StrCopy_JOH_IA32_8_b;
  66 : StrCopyFunction := StrCopy_JOH_IA32_8_c;
  67 : StrCopyFunction := StrCopy_JOH_IA32_8_d;

  68 : StrCopyFunction := StrCopy_JOH_MMX_1_a;
  69 : StrCopyFunction := StrCopy_JOH_MMX_1_b;
  70 : StrCopyFunction := StrCopy_JOH_MMX_1_c;
  71 : StrCopyFunction := StrCopy_JOH_MMX_1_d;

  72 : StrCopyFunction := StrCopy_JOH_IA32_9_a;
  73 : StrCopyFunction := StrCopy_JOH_IA32_9_b;
  74 : StrCopyFunction := StrCopy_JOH_IA32_9_c;
  75 : StrCopyFunction := StrCopy_JOH_IA32_9_d;
 else
  raise Exception.Create('Invalid function number');
 end;
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I : Cardinal;
 BenchmarkAllButtonCaption : AnsiString;
 Succes : Boolean;

begin
 Succes := SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_HIGHEST);
 if Succes = False then
  raise Exception.Create('SetThreadPriority to THREAD_PRIORITY_HIGHEST failed');
 BenchmarkAllButtonCaption := BenchmarkAllButton.Caption;
 BenchmarkAllButton.Caption := 'Running';
 Update;
 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   Application.ProcessMessages;
   Sleep(1000);
   Benchmark;
   SortRichEdit;
   BenchmarkTest;
   AlignmentTest;
   Update;
  end;
 BenchmarkAllButton.Caption := BenchmarkAllButtonCaption;

 if FileExists(FBenchmarkFileName) then FResultList.LoadFromFile(FBenchmarkFileName);
 FResultList.Add(Format('[%s %s] Running "%s" benchmark version %s with compiler settings: "%s".', [DateToStr(now), TimeToStr(now), ExtractFileName(Application.ExeName), GetFormattedVersion, SystemInfoCompilerSettings]));
 FResultList.Add(Format('OS: "%s". CPU :"%s / %s".', [SystemInfoWindows, SystemInfoCPU, SystemInfoCPUDetails]));
 FResultList.AddStrings(ReportRichEdit.Lines);
 FResultList.Add('');
 FResultList.SaveToFile(FBenchmarkFileName);
end;

procedure TMainForm.SaveSpeedButtonClick(Sender: TObject);
begin
 SaveDialog.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog.InitialDir := ExtractFilePath(Application.ExeName);
 SaveDialog.FileName := FResultsFileName;
 if SaveDialog.Execute then
  ReportRichEdit.Lines.SaveToFile(SaveDialog.FileName);
end;

function ValidateComplete : Boolean;
begin
 try
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
            Validate17;
 except
  Result := False;
 end;
end;

procedure TMainForm.ValidateButtonClick(Sender: TObject);
var
 Valid : Boolean;
 FunctionAddress : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
 FunctionAddress := Cardinal(@StrCopyFunction);
 FunctionAddressString := IntToHex(FunctionAddress, 8);
 Valid := ValidateComplete;
 if Valid then
  ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[8] + #9 + 'Passed')
 else
  ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[8] + #9 + 'Failed');
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I : Cardinal;
 Valid : Boolean;
 FunctionAddress : Cardinal;
 FunctionName, FunctionAddressString : AnsiString;

begin
 ValidateAllButton.Caption := 'Running';

 for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSelectionRadioGroup.ItemIndex := I;
   FunctionName := FunctionSelectionRadioGroup.Items[FunctionSelectionRadioGroup.ItemIndex];
   FunctionAddress := Cardinal(@StrCopyFunction);
   FunctionAddressString := IntToHex(FunctionAddress, 8);
   Valid := ValidateComplete;
   if Valid then
    ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[8] + #9 + 'Passed')
   else
    ReportRichEdit.Lines.Add(FunctionName + #9 + FunctionAddressString[8] + #9 + 'Failed');
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
   BenchmarkTest;
   Update;
  end;
 SpreadTestButton.Caption := SpreadTestButtonCaption;
 ReportRichEdit.Lines.Add('');
 ReportRichEdit.Lines.Add('Spread [%] :  ' + SpreadBenchPercentageEdit.Text);
end;

procedure TMainForm.SpreadBenchPercentageEditClick(Sender: TObject);
begin
 SpreadBenchPercentageEdit.SelectAll;
 SpreadBenchPercentageEdit.CopyToClipboard;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
 SetTabs;
end;

procedure TMainForm.ValidateBenchmarkButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 ValidateBenchmarkButton.Caption := 'Running';
 for I := 0 to 3 do
 //for I := 0 to FunctionSelectionRadioGroup.Items.Count-1 do
  begin
   BenchmarkAllButtonClick(nil);
   FunctionSelectionRadioGroup.ItemIndex := I;
   Benchmark;
  end;
 ValidateBenchmarkButton.Caption := 'Validate Benchmark';
end;

procedure TMainForm.CleanButtonClick(Sender: TObject);
begin
 CleanResultsRichEdit;
 BenchmarkTest;
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
