unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons;

type
  TMainForm = class(TForm)
    DevelopButton: TButton;
    FunctionExtendedSelectionRadioGroup: TRadioGroup;
    ReportRichEdit: TRichEdit;
    Set8087PrecisionRadioGroup: TRadioGroup;
    SetRoundModeRadioGroup: TRadioGroup;
    IEdit: TEdit;
    XEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ValidateExtendedButton: TButton;
    BenchmarkExtendedButton: TButton;
    Panel1: TPanel;
    SaveReportSpeedButton: TSpeedButton;
    PrintSpeedButton: TSpeedButton;
    CloseBitBtn: TBitBtn;
    Label3: TLabel;
    ErrorEdit: TEdit;
    BenchEdit: TEdit;
    SaveDialog1: TSaveDialog;
    FunctionDoubleSelectionRadioGroup: TRadioGroup;
    FunctionSingleSelectionRadioGroup: TRadioGroup;
    ValidateAllButton: TButton;
    BenchmarkAllButton: TButton;
    Label4: TLabel;
    Label5: TLabel;
    BenchmarkDoubleButton: TButton;
    BenchmarkSingleButton: TButton;
    ValidateDoubleButton: TButton;
    ValidateSingleButton: TButton;
    BenchExtendedRTLButton: TButton;
    BenchDoubleRTLButton: TButton;
    BenchSingleRTLButton: TButton;
    ClearButton: TButton;
    Bench1Edit: TEdit;
    Bench2Edit: TEdit;
    FunctionNameEdit: TEdit;
    MaxSpreadBenchPercentageEdit: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    CleanButton: TButton;
    BenchTestButton: TButton;
    procedure DevelopButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Set8087PrecisionRadioGroupClick(Sender: TObject);
    procedure SetRoundModeRadioGroupClick(Sender: TObject);
    procedure BenchmarkExtendedButtonClick(Sender: TObject);
    procedure ValidateExtendedButtonClick(Sender: TObject);
    procedure FunctionExtendedSelectionRadioGroupClick(Sender: TObject);
    procedure SaveReportSpeedButtonClick(Sender: TObject);
    procedure PrintSpeedButtonClick(Sender: TObject);
    procedure ValidateAllButtonClick(Sender: TObject);
    procedure FunctionSingleSelectionRadioGroupClick(Sender: TObject);
    procedure FunctionDoubleSelectionRadioGroupClick(Sender: TObject);
    procedure BenchmarkDoubleButtonClick(Sender: TObject);
    procedure BenchmarkSingleButtonClick(Sender: TObject);
    procedure ValidateDoubleButtonClick(Sender: TObject);
    procedure ValidateSingleButtonClick(Sender: TObject);
    procedure BenchExtendedRTLButtonClick(Sender: TObject);
    procedure BenchDoubleRTLButtonClick(Sender: TObject);
    procedure BenchSingleRTLButtonClick(Sender: TObject);
    procedure BenchmarkAllButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure CleanButtonClick(Sender: TObject);
    procedure BenchTestButtonClick(Sender: TObject);
  private
    procedure CleanResultsRichEdit;
    procedure BenchmarkTest;
    procedure ClearAllEditBoxes;
    function BenchmarkExtended : Double;
    function BenchmarkDouble : Double;
    function BenchmarkSingle : Double;
    function BenchmarkRTLExtended : Double;
    function BenchmarkRTLDouble : Double;
    function BenchmarkRTLSingle : Double;
    function ValidateExtended1 : Boolean;
    function ValidateExtended2 : Boolean;
    function ValidateExtended3 : Boolean;
    function ValidateExtended4 : Boolean;
    function ValidateDouble1 : Boolean;
    function ValidateDouble2 : Boolean;
    function ValidateDouble3 : Boolean;
    function ValidateDouble4 : Boolean;
    function ValidateSingle1 : Boolean;
    function ValidateSingle2 : Boolean;
    function ValidateSingle3 : Boolean;
    function ValidateSingle4 : Boolean;
    function ValidateSingle5 : Boolean;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
 Math, RoundUnit, Round32Unit, Round32_JOH;

const
 NOOFLOOPS : Cardinal = 1;
 BENCHRANGESTART : Single = 1E-35;
 BENCHRANGEEND : Single = MAXINT;
 BENCHXSTEPSIZE : Single = 1.000005;
 SCALE : Double = 100;

type
 TRound32SingleFunction = function (const X : Single) : Integer;
 TRound32DoubleFunction = function (const X : Double) : Integer;
 TRound32ExtendedFunction = function (const X : Extended) : Integer;

var
 Round32SingleFunction : TRound32SingleFunction;
 Round32DoubleFunction : TRound32DoubleFunction;
 Round32ExtendedFunction : TRound32ExtendedFunction;
 Xs1, Xs2, Xs3, Xs4, Xs5, Xs6, Xs7 : Single;
 Xd1, Xd2, Xd3, Xd4, Xd5, Xd6, Xd7 : Double;//7 Double is 56 byte and a linesplit is not secured
 Xe1, Xe2, Xe3, Xe4, Xe5, Xe6, Xe7 : Extended;//7 extended is 70 byte and a linesplit is secured

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

procedure TMainForm.DevelopButtonClick(Sender: TObject);
var
 X : Extended;
 I : Integer;

begin
 X := StrToFloat(XEdit.Text);
 I := Round32ExtendedFunction(X);
 IEdit.Text := IntToStr(I);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 ReportRichEdit.Clear;
 ClearAllEditBoxes;
 Set8087PrecisionRadioGroupClick(nil);
 SetRoundModeRadioGroupClick(nil);
 Round32ExtendedFunction := Round32ExtendedDKC1;
 Round32DoubleFunction := Round32DoubleDKC1;
 Round32SingleFunction := Round32SingleDKC1;
 XEdit.Text := FloatToStr(65541 + 5/7);
 ReportRichEdit.Paragraph.TabCount := 1;
 ReportRichEdit.Paragraph.Tab[0] := 130;
end;

procedure TMainForm.Set8087PrecisionRadioGroupClick(Sender: TObject);
begin
 case Set8087PrecisionRadioGroup.ItemIndex of
  0 : SetPrecisionMode(pmSingle);
  1 : SetPrecisionMode(pmDouble);
  2 : SetPrecisionMode(pmExtended);
 end;
end;

procedure TMainForm.SetRoundModeRadioGroupClick(Sender: TObject);
var
 FPURoundingMode : TFPURoundingMode;

begin
 case SetRoundModeRadioGroup.ItemIndex of
  0 : FPURoundingMode := rmNearest;
  1 : FPURoundingMode := rmDown;
  2 : FPURoundingMode := rmUp;
  3 : FPURoundingMode := rmTruncate;
 else
  FPURoundingMode := rmNearest;
 end;
 SetRoundMode(FPURoundingMode);
end;

procedure TMainForm.BenchmarkExtendedButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 FunctionName := FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex];
 Bench := BenchmarkExtended;
 BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
 BenchmarkTest;
end;

function TMainForm.BenchmarkRTLExtended : Double;
var
 I1, I2 : Integer;
 StartTime, EndTime, RunTime : TDateTime;

begin
 try
  I1 := 1; //To satisfy compiler
  I2 := 2; //To satisfy compiler
  Xe1 := BENCHRANGESTART;
  Xe2 := BENCHRANGESTART;
  Xe3 := BENCHRANGESTART;
  Xe4 := BENCHRANGESTART;
  Xe5 := BENCHRANGESTART;
  Xe6 := BENCHRANGESTART;
  Xe7 := BENCHRANGESTART;
  StartTime := Time;
  while Xe1 < BENCHRANGEEND do
   begin
    I1 := Round(Xe1);
    I2 := Round(Xe1);
    Xe1 := Xe1 * BENCHXSTEPSIZE;
   end;
  while Xe2 < BENCHRANGEEND do
   begin
    I1 := Round(Xe2);
    I2 := Round(Xe2);
    Xe2 := Xe2 * BENCHXSTEPSIZE;
   end;
  while Xe3 < BENCHRANGEEND do
   begin
    I1 := Round(Xe3);
    I2 := Round(Xe3);
    Xe3 := Xe3 * BENCHXSTEPSIZE;
   end;
  while Xe4 < BENCHRANGEEND do
   begin
    I1 := Round(Xe4);
    I2 := Round(Xe4);
    Xe4 := Xe4 * BENCHXSTEPSIZE;
   end;
  while Xe5 < BENCHRANGEEND do
   begin
    I1 := Round(Xe5);
    I2 := Round(Xe5);
    Xe5 := Xe5 * BENCHXSTEPSIZE;
   end;
  while Xe6 < BENCHRANGEEND do
   begin
    I1 := Round(Xe6);
    I2 := Round(Xe6);
    Xe6 := Xe6 * BENCHXSTEPSIZE;
   end;
  while Xe7 < BENCHRANGEEND do
   begin
    I1 := Round(Xe7);
    I2 := Round(Xe7);
    Xe7 := Xe7 * BENCHXSTEPSIZE;
   end;
  EndTime := Time;
  RunTime := EndTime - StartTime;
  Result := SCALE * RunTime *24*60*60;
  IEdit.Text := IntToStr(I1 div I2);
 except
  Result := 99999;
 end;
end;

function TMainForm.BenchmarkExtended : Double;
var
 I1, I2 : Integer;
 StartTime, EndTime, RunTime : TDateTime;

begin
 try
  I1 := 1; //To satisfy compiler
  I2 := 2; //To satisfy compiler
  Xe1 := BENCHRANGESTART;
  Xe2 := BENCHRANGESTART;
  Xe3 := BENCHRANGESTART;
  Xe4 := BENCHRANGESTART;
  Xe5 := BENCHRANGESTART;
  Xe6 := BENCHRANGESTART;
  Xe7 := BENCHRANGESTART;
  StartTime := Time;
  while Xe1 < BENCHRANGEEND do
   begin
    I1 := Round32ExtendedFunction(Xe1);
    I2 := Round32ExtendedFunction(Xe1);
    Xe1 := Xe1 * BENCHXSTEPSIZE;
   end;
  while Xe2 < BENCHRANGEEND do
   begin
    I1 := Round32ExtendedFunction(Xe2);
    I2 := Round32ExtendedFunction(Xe2);
    Xe2 := Xe2 * BENCHXSTEPSIZE;
   end;
  while Xe3 < BENCHRANGEEND do
   begin
    I1 := Round32ExtendedFunction(Xe3);
    I2 := Round32ExtendedFunction(Xe3);
    Xe3 := Xe3 * BENCHXSTEPSIZE;
   end;
  while Xe4 < BENCHRANGEEND do
   begin
    I1 := Round32ExtendedFunction(Xe4);
    I2 := Round32ExtendedFunction(Xe4);
    Xe4 := Xe4 * BENCHXSTEPSIZE;
   end;
  while Xe5 < BENCHRANGEEND do
   begin
    I1 := Round32ExtendedFunction(Xe5);
    I2 := Round32ExtendedFunction(Xe5);
    Xe5 := Xe5 * BENCHXSTEPSIZE;
   end;
  while Xe6 < BENCHRANGEEND do
   begin
    I1 := Round32ExtendedFunction(Xe6);
    I2 := Round32ExtendedFunction(Xe6);
    Xe6 := Xe6 * BENCHXSTEPSIZE;
   end;
  while Xe7 < BENCHRANGEEND do
   begin
    I1 := Round32ExtendedFunction(Xe7);
    I2 := Round32ExtendedFunction(Xe7);
    Xe7 := Xe7 * BENCHXSTEPSIZE;
   end;
  EndTime := Time;
  RunTime := EndTime - StartTime;
  Result := SCALE * RunTime *24*60*60;
  IEdit.Text := IntToStr(I1 div I2);
 except
  Result := 99999;
 end;
end;

function TMainForm.BenchmarkRTLDouble : Double;
var
 I1, I2 : Integer;
 StartTime, EndTime, RunTime : TDateTime;

begin
 try
  I1 := 1; //To satisfy compiler
  I2 := 2; //To satisfy compiler
  Xd1 := BENCHRANGESTART;
  Xd2 := BENCHRANGESTART;
  Xd3 := BENCHRANGESTART;
  Xd4 := BENCHRANGESTART;
  Xd5 := BENCHRANGESTART;
  Xd6 := BENCHRANGESTART;
  Xd7 := BENCHRANGESTART;
  StartTime := Time;
  while Xd1 < BENCHRANGEEND do
   begin
    I1 := Round(Xd1);
    I2 := Round(Xd1);
    Xd1 := Xd1 * BENCHXSTEPSIZE;
   end;
  while Xd2 < BENCHRANGEEND do
   begin
    I1 := Round(Xd2);
    I2 := Round(Xd2);
    Xd2 := Xd2 * BENCHXSTEPSIZE;
   end;
  while Xd3 < BENCHRANGEEND do
   begin
    I1 := Round(Xd3);
    I2 := Round(Xd3);
    Xd3 := Xd3 * BENCHXSTEPSIZE;
   end;
  while Xd4 < BENCHRANGEEND do
   begin
    I1 := Round(Xd4);
    I2 := Round(Xd4);
    Xd4 := Xd4 * BENCHXSTEPSIZE;
   end;
  while Xd5 < BENCHRANGEEND do
   begin
    I1 := Round(Xd5);
    I2 := Round(Xd5);
    Xd5 := Xd5 * BENCHXSTEPSIZE;
   end;
  while Xd6 < BENCHRANGEEND do
   begin
    I1 := Round(Xd6);
    I2 := Round(Xd6);
    Xd6 := Xd6 * BENCHXSTEPSIZE;
   end;
  while Xd7 < BENCHRANGEEND do
   begin
    I1 := Round(Xd7);
    I2 := Round(Xd7);
    Xd7 := Xd7 * BENCHXSTEPSIZE;
   end;
  EndTime := Time;
  RunTime := EndTime - StartTime;
  Result := SCALE * RunTime *24*60*60;
  IEdit.Text := IntToStr(I1 div I2);
 except
  Result := 99999;
 end;
end;

function TMainForm.BenchmarkDouble : Double;
var
 I1, I2 : Integer;
 StartTime, EndTime, RunTime : TDateTime;

begin
 try
  I1 := 1; //To satisfy compiler
  I2 := 2; //To satisfy compiler
  Xd1 := BENCHRANGESTART;
  Xd2 := BENCHRANGESTART;
  Xd3 := BENCHRANGESTART;
  Xd4 := BENCHRANGESTART;
  Xd5 := BENCHRANGESTART;
  Xd6 := BENCHRANGESTART;
  Xd7 := BENCHRANGESTART;
  StartTime := Time;
  while Xd1 < BENCHRANGEEND do
   begin
    I1 := Round32DoubleFunction(Xd1);
    I2 := Round32DoubleFunction(Xd1);
    Xd1 := Xd1 * BENCHXSTEPSIZE;
   end;
  while Xd2 < BENCHRANGEEND do
   begin
    I1 := Round32DoubleFunction(Xd2);
    I2 := Round32DoubleFunction(Xd2);
    Xd2 := Xd2 * BENCHXSTEPSIZE;
   end;
  while Xd3 < BENCHRANGEEND do
   begin
    I1 := Round32DoubleFunction(Xd3);
    I2 := Round32DoubleFunction(Xd3);
    Xd3 := Xd3 * BENCHXSTEPSIZE;
   end;
  while Xd4 < BENCHRANGEEND do
   begin
    I1 := Round32DoubleFunction(Xd4);
    I2 := Round32DoubleFunction(Xd4);
    Xd4 := Xd4 * BENCHXSTEPSIZE;
   end;
  while Xd5 < BENCHRANGEEND do
   begin
    I1 := Round32DoubleFunction(Xd5);
    I2 := Round32DoubleFunction(Xd5);
    Xd5 := Xd5 * BENCHXSTEPSIZE;
   end;
  while Xd6 < BENCHRANGEEND do
   begin
    I1 := Round32DoubleFunction(Xd6);
    I2 := Round32DoubleFunction(Xd6);
    Xd6 := Xd6 * BENCHXSTEPSIZE;
   end;
  while Xd7 < BENCHRANGEEND do
   begin
    I1 := Round32DoubleFunction(Xd7);
    I2 := Round32DoubleFunction(Xd7);
    Xd7 := Xd7 * BENCHXSTEPSIZE;
   end;
  EndTime := Time;
  RunTime := EndTime - StartTime;
  Result := SCALE * RunTime *24*60*60;
  IEdit.Text := IntToStr(I1 div I2);
 except
  Result := 99999;
 end;
end;

function TMainForm.BenchmarkRTLSingle : Double;
var
 I1, I2 : Integer;
 StartTime, EndTime, RunTime : TDateTime;

begin
 try
  I1 := 1; //To satisfy compiler
  I2 := 2; //To satisfy compiler
  Xs1 := BENCHRANGESTART;
  Xs2 := BENCHRANGESTART;
  Xs3 := BENCHRANGESTART;
  Xs4 := BENCHRANGESTART;
  Xs5 := BENCHRANGESTART;
  Xs6 := BENCHRANGESTART;
  Xs7 := BENCHRANGESTART;
  StartTime := Time;
  while Xs1 < BENCHRANGEEND do
   begin
    I1 := Round(Xs1);
    I2 := Round(Xs1);
    Xs1 := Xs1 * BENCHXSTEPSIZE;
   end;
  while Xs2 < BENCHRANGEEND do
   begin
    I1 := Round(Xs2);
    I2 := Round(Xs2);
    Xs2 := Xs2 * BENCHXSTEPSIZE;
   end;
  while Xs3 < BENCHRANGEEND do
   begin
    I1 := Round(Xs3);
    I2 := Round(Xs3);
    Xs3 := Xs3 * BENCHXSTEPSIZE;
   end;
  while Xs4 < BENCHRANGEEND do
   begin
    I1 := Round(Xs4);
    I2 := Round(Xs4);
    Xs4 := Xs4 * BENCHXSTEPSIZE;
   end;
  while Xs5 < BENCHRANGEEND do
   begin
    I1 := Round(Xs5);
    I2 := Round(Xs5);
    Xs5 := Xs5 * BENCHXSTEPSIZE;
   end;
  while Xs6 < BENCHRANGEEND do
   begin
    I1 := Round(Xs6);
    I2 := Round(Xs6);
    Xs6 := Xs6 * BENCHXSTEPSIZE;
   end;
  while Xs7 < BENCHRANGEEND do
   begin
    I1 := Round(Xs7);
    I2 := Round(Xs7);
    Xs7 := Xs7 * BENCHXSTEPSIZE;
   end;
  EndTime := Time;
  RunTime := EndTime - StartTime;
  Result := SCALE * RunTime *24*60*60;
  IEdit.Text := IntToStr(I1 div I2);
 except
  Result := 99999;
 end;
end;

function TMainForm.BenchmarkSingle : Double;
var
 I1, I2 : Integer;
 StartTime, EndTime, RunTime : TDateTime;

begin
 try
  I1 := 1; //To satisfy compiler
  I2 := 2; //To satisfy compiler
  Xs1 := BENCHRANGESTART;
  Xs2 := BENCHRANGESTART;
  Xs3 := BENCHRANGESTART;
  Xs4 := BENCHRANGESTART;
  Xs5 := BENCHRANGESTART;
  Xs6 := BENCHRANGESTART;
  Xs7 := BENCHRANGESTART;
  StartTime := Time;
  while Xs1 < BENCHRANGEEND do
   begin
    I1 := Round32SingleFunction(Xs1);
    I2 := Round32SingleFunction(Xs1);
    Xs1 := Xs1 * BENCHXSTEPSIZE;
   end;
  while Xs2 < BENCHRANGEEND do
   begin
    I1 := Round32SingleFunction(Xs2);
    I2 := Round32SingleFunction(Xs2);
    Xs2 := Xs2 * BENCHXSTEPSIZE;
   end;
  while Xs3 < BENCHRANGEEND do
   begin
    I1 := Round32SingleFunction(Xs3);
    I2 := Round32SingleFunction(Xs3);
    Xs3 := Xs3 * BENCHXSTEPSIZE;
   end;
  while Xs4 < BENCHRANGEEND do
   begin
    I1 := Round32SingleFunction(Xs4);
    I2 := Round32SingleFunction(Xs4);
    Xs4 := Xs4 * BENCHXSTEPSIZE;
   end;
  while Xs5 < BENCHRANGEEND do
   begin
    I1 := Round32SingleFunction(Xs5);
    I2 := Round32SingleFunction(Xs5);
    Xs5 := Xs5 * BENCHXSTEPSIZE;
   end;
  while Xs6 < BENCHRANGEEND do
   begin
    I1 := Round32SingleFunction(Xs6);
    I2 := Round32SingleFunction(Xs6);
    Xs6 := Xs6 * BENCHXSTEPSIZE;
   end;
  while Xs7 < BENCHRANGEEND do
   begin
    I1 := Round32SingleFunction(Xs7);
    I2 := Round32SingleFunction(Xs7);
    Xs7 := Xs7 * BENCHXSTEPSIZE;
   end;
  EndTime := Time;
  RunTime := EndTime - StartTime;
  Result := SCALE * RunTime *24*60*60;
  IEdit.Text := IntToStr(I1 div I2);
 except
  Result := 99999;
 end;
end;

function TMainForm.ValidateExtended1 : Boolean;
var
 X : Extended;
 I1 : Int64;
 I2 : Integer;

begin
 X := 1E-64;
 Result := True;
 while X < MAXINT do
  begin
   I1 := Round(X);
   I2 := Round32ExtendedFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Round(-X);
   I2 := Round32ExtendedFunction(-X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   X := X * 1.0001;
  end;
end;

function TMainForm.ValidateExtended2 : Boolean;
var
 X : Extended;
 I1 : Int64;
 I2 : Integer;

begin
 X := 0;
 Result := True;
 while X < MAXINT do
  begin
   I1 := Round(X);
   I2 := Round32ExtendedFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Round(-X);
   I2 := Round32ExtendedFunction(-X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   X := X + 50;
  end;
end;

function TMainForm.ValidateExtended3 : Boolean;
var
 X : Extended;
 I : Integer;

begin
 X := MAXINT;
 X := X + 1;
 Result := False;
 try
  I := Round32ExtendedFunction(X);
  IEdit.Text := IntToStr(I);
 except
  Result := True;
 end;
end;

function TMainForm.ValidateExtended4 : Boolean;
var
 X : Extended;
 I : Integer;

begin
 X := -MAXINT;
 X := X - 2;
 Result := False;
 try
  I := Round32ExtendedFunction(X);
  IEdit.Text := IntToStr(I);
 except
  Result := True;
 end;
end;

function TMainForm.ValidateDouble1 : Boolean;
var
 X : Double;
 I1 : Int64;
 I2 : Integer;

begin
 X := 1E-64;
 Result := True;
 while X < MAXINT do
  begin
   I1 := Round(X);
   I2 := Round32DoubleFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Round(-X);
   I2 := Round32DoubleFunction(-X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   X := X * 1.0001;
  end;
end;

function TMainForm.ValidateDouble2 : Boolean;
var
 X : Double;
 I1 : Int64;
 I2 : Integer;

begin
 X := 0;
 Result := True;
 while X < MAXINT do
  begin
   I1 := Round(X);
   I2 := Round32DoubleFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Round(-X);
   I2 := Round32DoubleFunction(-X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   X := X + 50;
  end;
end;

function TMainForm.ValidateDouble3 : Boolean;
var
 X : Double;
 I : Integer;

begin
 X := MAXINT;
 X := X + 1;
 Result := False;
 try
  I := Round32DoubleFunction(X);
  IEdit.Text := IntToStr(I);
 except
  Result := True;
 end;
end;

function TMainForm.ValidateDouble4 : Boolean;
var
 X : Double;
 I : Integer;

begin
 X := -MAXINT;
 X := X - 2;
 Result := False;
 try
  I := Round32DoubleFunction(X);
  IEdit.Text := IntToStr(I);
 except
  Result := True;
 end;
end;

function TMainForm.ValidateSingle1 : Boolean;
var
 X : Single;
 I1 : Int64;
 I2 : Integer;

begin
 X := 1E-40;
 Result := True;
 while X < MAXINT do
  begin
   I1 := Round(X);
   I2 := Round32SingleFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Round(-X);
   I2 := Round32SingleFunction(-X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   X := X * 1.0001;
  end;
end;

function TMainForm.ValidateSingle2 : Boolean;
var
 X : Single;
 I1 : Int64;
 I2 : Integer;

begin
 X := 0;
 Result := True;
 while X < 16777216 do //Above here the single datatype can not hold all integer values and adding 1 leads to nothing
  begin
   I1 := Round(X);
   I2 := Round32SingleFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Round(-X);
   I2 := Round32SingleFunction(-X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   X := X + 1;
  end;
end;

function TMainForm.ValidateSingle3 : Boolean;
var
 X : Single;
 I1 : Int64;
 I2 : Integer;

begin
 X := 0;
 Result := True;
 while X < MAXINT do
  begin
   I1 := Round(X);
   I2 := Round32SingleFunction(X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   I1 := Round(-X);
   I2 := Round32SingleFunction(-X);
   if I1 <> I2 then
    begin
     Result := False;
     Break;
    end;
   X := X + 65;//Smallest stepsize that will count up to MAXINT
  end;
end;

//Validate overflow exceptions

function TMainForm.ValidateSingle4 : Boolean;
var
 X : Single;
 I : Integer;

begin
 X := MAXINT;
 X := X + 175;
 Result := False;
 try
  I := Round32SingleFunction(X);
  IEdit.Text := IntToStr(I);
 except
  Result := True;
 end;
end;

function TMainForm.ValidateSingle5 : Boolean;
var
 X : Single;
 I : Integer;

begin
 X := -MAXINT;
 X := X - 175;
 Result := False;
 try
  I := Round32SingleFunction(X);
  IEdit.Text := IntToStr(I);
 except
  Result := True;
 end;
end;

procedure TMainForm.ValidateExtendedButtonClick(Sender: TObject);
begin
 try
  if ValidateExtended1 and
     ValidateExtended2 and
     ValidateExtended3 and
     ValidateExtended4 then
   begin
    ErrorEdit.Color := clGreen;
    ReportRichEdit.Lines.Add(FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex] + #9 + 'Passed')
   end
  else
   begin
    ErrorEdit.Color := clRed;
    ReportRichEdit.Lines.Add(FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex] + #9 + 'Failed');
   end;
 except
  ErrorEdit.Color := clRed;
  ReportRichEdit.Lines.Add(FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex] + #9 + 'Failed');
 end;
end;

procedure TMainForm.FunctionExtendedSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionExtendedSelectionRadioGroup.ItemIndex+1 of
  1 : Round32ExtendedFunction := Round32ExtendedDKC1;
  2 : Round32ExtendedFunction := Round32ExtendedJOH;
  3 : Round32ExtendedFunction := Round32ExtendedJOH_1;
  4 : Round32ExtendedFunction := Round32ExtendedJOH_2;
 else
  raise Exception.Create('Invalid function selected');
 end;
end;

procedure TMainForm.SaveReportSpeedButtonClick(Sender: TObject);
begin
 SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName);
 SaveDialog1.Filter := 'Text files (*.txt)|*.TXT';
 SaveDialog1.FileName := 'Round32BenchReport.Txt';
 if SaveDialog1.Execute then
  ReportRichEdit.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TMainForm.PrintSpeedButtonClick(Sender: TObject);
begin
 ReportRichEdit.Print('Round Report');
end;

procedure TMainForm.ValidateAllButtonClick(Sender: TObject);
var
 I1, I2, I3 : Cardinal;

begin
 for I1 := 0 to FunctionExtendedSelectionRadioGroup.Items.Count-1 do
  begin
   try
    FunctionExtendedSelectionRadioGroup.ItemIndex := I1;
    if ValidateExtended1 and
       ValidateExtended2 and
       ValidateExtended3 and
       ValidateExtended4 then
     ReportRichEdit.Lines.Add(FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex] + #9 + 'Passed')
    else
     ReportRichEdit.Lines.Add(FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex] + #9 + 'Failed');
    Update;
   except
    ReportRichEdit.Lines.Add(FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex] + #9 + 'Failed');
   end;
  end;
 for I2 := 0 to FunctionDoubleSelectionRadioGroup.Items.Count-1 do
  begin
   try
    FunctionDoubleSelectionRadioGroup.ItemIndex := I2;
    if ValidateDouble1 and
       ValidateDouble2 and
       ValidateDouble3 and
       ValidateDouble4 then
     ReportRichEdit.Lines.Add(FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex] + #9 + 'Passed')
    else
     ReportRichEdit.Lines.Add(FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex] + #9 + 'Failed');
    Update;
   except
    ReportRichEdit.Lines.Add(FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex] + #9 + 'Failed');
   end;
  end;
 for I3 := 0 to FunctionSingleSelectionRadioGroup.Items.Count-1 do
  begin
   try
    FunctionSingleSelectionRadioGroup.ItemIndex := I3;
    if ValidateSingle1 and
       ValidateSingle2 and
       ValidateSingle3 and
       ValidateSingle4 and
       ValidateSingle5 then
     ReportRichEdit.Lines.Add(FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex] + #9 + 'Passed')
    else
     ReportRichEdit.Lines.Add(FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex] + #9 + 'Failed');
    Update;
   except
    ReportRichEdit.Lines.Add(FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex] + #9 + 'Failed');
   end;
  end;
end;

procedure TMainForm.FunctionSingleSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionSingleSelectionRadioGroup.ItemIndex+1 of
  1 : Round32SingleFunction := Round32SingleDKC1;
  2 : Round32SingleFunction := Round32SingleDKCSSE_2;
  3 : Round32SingleFunction := Round32SingleJOH;
  4 : Round32SingleFunction := Round32SingleJOH_1;
  5 : Round32SingleFunction := Round32SingleJOH_2;
 else
  raise Exception.Create('Invalid function selected');
 end;
end;

procedure TMainForm.FunctionDoubleSelectionRadioGroupClick(Sender: TObject);
begin
 case FunctionDoubleSelectionRadioGroup.ItemIndex+1 of
  1 : Round32DoubleFunction := Round32DoubleDKC1;
  2 : Round32DoubleFunction := Round32DoubleDKCSSE2_2;
  3 : Round32DoubleFunction := Round32DoubleJOH;
  4 : Round32DoubleFunction := Round32DoubleJOH_1;
  5 : Round32DoubleFunction := Round32DoubleJOH_2;
 else
  raise Exception.Create('Invalid function selected');
 end;
end;

procedure TMainForm.BenchmarkDoubleButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 FunctionName := FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex];
 Bench := BenchmarkDouble;
 BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
 BenchmarkTest;
end;

procedure TMainForm.BenchmarkSingleButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 FunctionName := FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex];
 Bench := BenchmarkSingle;
 BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
 BenchmarkTest;
end;

procedure TMainForm.ValidateDoubleButtonClick(Sender: TObject);
begin
 try
  if ValidateDouble1 and
     ValidateDouble2 and
     ValidateDouble3 and
     ValidateDouble4 then
   begin
    ReportRichEdit.Lines.Add(FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex] + #9 + 'Passed');
    ErrorEdit.Color := clGreen;
   end
  else
   begin
    ReportRichEdit.Lines.Add(FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex] + #9 + 'Failed');
    ErrorEdit.Color := clRed;
   end;
 except
  ReportRichEdit.Lines.Add(FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex] + #9 + 'Failed');
  ErrorEdit.Color := clRed;
 end;
end;

procedure TMainForm.ValidateSingleButtonClick(Sender: TObject);
begin
 try
  if ValidateSingle1 and
     ValidateSingle2 and
     ValidateSingle3 and
     ValidateSingle4 and
     ValidateSingle5 then
   begin
    ReportRichEdit.Lines.Add(FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex] + #9 + 'Passed');
    ErrorEdit.Color := clGreen;
   end
  else
   begin
    ReportRichEdit.Lines.Add(FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex] + #9 + 'Failed');
    ErrorEdit.Color := clRed;
   end;
 except
  ReportRichEdit.Lines.Add(FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex] + #9 + 'Failed');
  ErrorEdit.Color := clRed;
 end;
end;

procedure TMainForm.BenchExtendedRTLButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 FunctionName := 'RoundExtendedRTL';
 Bench := BenchmarkRTLExtended;
 BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
 BenchmarkTest;
end;

procedure TMainForm.BenchDoubleRTLButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 FunctionName := 'RoundDoubleRTL';
 Bench := BenchmarkRTLDouble;
 BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
 BenchmarkTest;
end;

procedure TMainForm.BenchSingleRTLButtonClick(Sender: TObject);
var
 Bench : Double;
 FunctionName : AnsiString;

begin
 FunctionName := 'RoundSingleRTL';
 Bench := BenchmarkRTLSingle;
 BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
 ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
 BenchmarkTest;
end;

procedure TMainForm.BenchmarkAllButtonClick(Sender: TObject);
var
 I1, I2, I3 : Cardinal;
 FunctionName : AnsiString;
 Bench : Double;

begin
 BenchmarkAllButton.Caption := 'Running';
 //BenchExtendedRTLButtonClick(nil);
 Update;
 //BenchDoubleRTLButtonClick(nil);
 Update;
 //BenchSingleRTLButtonClick(nil);
 Update;
 for I1 := 0 to FunctionExtendedSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionExtendedSelectionRadioGroup.ItemIndex := I1;
   FunctionName := FunctionExtendedSelectionRadioGroup.Items[FunctionExtendedSelectionRadioGroup.ItemIndex];
   Bench := BenchmarkExtended;
   BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
   ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
   BenchmarkTest;
   Update;
  end;
 for I2 := 0 to FunctionDoubleSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionDoubleSelectionRadioGroup.ItemIndex := I2;
   FunctionName := FunctionDoubleSelectionRadioGroup.Items[FunctionDoubleSelectionRadioGroup.ItemIndex];
   Bench := BenchmarkDouble;
   BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
   ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
   BenchmarkTest;
   Update;
  end;
 for I3 := 0 to FunctionSingleSelectionRadioGroup.Items.Count-1 do
  begin
   FunctionSingleSelectionRadioGroup.ItemIndex := I3;
   FunctionName := FunctionSingleSelectionRadioGroup.Items[FunctionSingleSelectionRadioGroup.ItemIndex];
   Bench := BenchmarkSingle;
   BenchEdit.Text := FloatToStrF(Bench, ffFixed, 9, 0);
   ReportRichEdit.Lines.Add(FunctionName + #9 + FloatToStrF(Bench, ffFixed, 9, 0));
   BenchmarkTest;
   Update;
  end;
 BenchmarkAllButton.Caption := 'Benchmark All';
end;

procedure TMainForm.ClearButtonClick(Sender: TObject);
begin
 ReportRichEdit.Clear;
end;

procedure TMainForm.CleanButtonClick(Sender: TObject);
begin
 CleanResultsRichEdit;
end;

procedure TMainForm.BenchTestButtonClick(Sender: TObject);
var
 I : Cardinal;

begin
 for I := 1 to 20 do
  begin
   BenchmarkAllButtonClick(nil);
  end;
end;

end.
